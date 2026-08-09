Drop Table If Exists risk_scorecard;

CREATE TABLE risk_scorecard AS (
With risk_base as 
(Select  
t.transaction_id,
t.customer_id,
t.transaction_date,
trim(TO_CHAR(t.transaction_date, 'Day')) AS day_of_week,
t.customer_account_age_days,
t.authentication_method,
t.transaction_type,
t.transaction_amount,
t.account_status,
t.fraud_flag,
t.ip_address,
t.device_type,
t.payment_method,
t.transaction_location,
concat(c.home_city,',',' ',c.home_state) as customer_location,
ip.location_risk_level,
ip.ip_risk_level
from transactions t
left join ip_address ip
on t.ip_address = ip.ip_address
left join customers c
on t.customer_id = c.customer_id),

Scored_base As (

Select *, 

Case When ip_risk_level = 'High' Then 1 
When ip_risk_level = 'Moderate' Then .5 
When ip_risk_level = 'Low' Then 0 
Else 0 
End as ip_indicator_score, 


Case When location_risk_level = 'High' Then 1 
When location_risk_level = 'Moderate' Then .5 
When location_risk_level = 'Low' Then 0 
Else 0 
End as location_indicator_score, 


Case When device_type = 'Tablet' Then 1 
Else 0
End as device_indicator_score,

Case When authentication_method = 'Password' then 1 
when authentication_method = 'None' then 0.5
else 0
End as authentication_indicator_score,

Case When transaction_type = 'Refund' then 1 
When transaction_type in ('Virtual Card Purchase','Installment Payment') then 0.5 
Else 0 
End as transaction_indicator_score,

Case When account_status = 'Active' Then 1 
when account_status = 'Dormant' Then 0.5 
Else 0 
End status_indicator_score, 

Case When payment_method = 'Virtual Card' then 1 
When payment_method in ('Digital Wallet','Credit Card','Debit Card') then .5 
Else 0 
End payment_indicator_score,

Case When transaction_amount <=50 then 0.5
When transaction_amount >= 51 and transaction_amount <= 100 then 1
when transaction_amount >= 101 and transaction_amount <= 250 then  .5 
when transaction_amount >= 251 and transaction_amount <= 500 then 0
Else 1
End as amount_indicator_score,

Case When customer_account_age_days <= 255 Then 0
When customer_account_age_days >= 256 And customer_account_age_days <= 894 Then .5
When customer_account_age_days >= 895 And  customer_account_age_days <= 2082 Then 1
When customer_account_age_days >= 2083 And  customer_account_age_days <= 4210 Then .5 
When customer_account_age_days >= 4211 And customer_account_age_days <= 7696 Then .5
Else 0 
End as age_indicator_score,

-- Monday fraud rate = 1.75% (highest)
-- Saturday, Tuesday, Wednesday = medium fraud rate (~1.67%)

Case When day_of_week = 'Monday' Then 1 
When day_of_week in ('Saturday','Wednesday','Tuesday') Then .5
Else  0 
End as dow_indicator_score 
from risk_base
)

SELECT
    *,
    
    ip_indicator_score * 15 AS ip_risk_score,
    location_indicator_score * 20 AS location_risk_score,
    device_indicator_score * 10 AS device_risk_score,
	age_indicator_score * 15 AS age_risk_score,
    dow_indicator_score * 5 AS dow_risk_score,
	authentication_indicator_score *10 AS authentication_risk_score,
	transaction_indicator_score * 5 AS trans_type_risk_score,
	payment_indicator_score * 10 AS payment_risk_score,
	amount_indicator_score * 5 As amount_risk_score, 
	status_indicator_score * 5 AS status_risk_score,

    (
        ip_indicator_score * 15 +
        location_indicator_score * 20 +
        device_indicator_score * 10 +
		age_indicator_score * 15 + 
        dow_indicator_score * 5 +
		authentication_indicator_score *10 + 
		transaction_indicator_score * 5 +
		payment_indicator_score * 10 + 
		amount_indicator_score * 5 +
		status_indicator_score * 5
    ) AS transaction_risk_score

FROM scored_base);
