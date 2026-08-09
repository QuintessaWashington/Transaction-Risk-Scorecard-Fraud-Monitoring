-- 1. What is the Transaction Count?
Select count(*)
from transactions;

 -- 2. What is the Date Range?
Select 
min(transaction_date),
max(transaction_date)
from transactions;

 -- 3. What is the Number of Customers?
Select count(distinct(customer_id))
from transactions;

 -- 4. What is the Total Transaction Amount?
Select 
sum(transaction_amount)
from transactions;
Question 5 -- What is the Average Fraud Transaction Amount?
Select avg(transaction_amount) 
from transactions
 where fraud_flag = '1' ;

 -- 6. What is the Maximum Fraud Transaction Amount?
Select max(transaction_amount)
 from transactions 
where fraud_flag = '1' ;

 -- 7. What Day of the Week Does Fraud Most Commonly Occur?
SELECT
 TRIM(TO_CHAR(transaction_date, 'Day')) AS day_of_week, 
COUNT() AS total_transactions, 
SUM(fraud_flag) AS fraud_transactions, 
ROUND( SUM(fraud_flag)::NUMERIC / COUNT() * 100, 2 ) AS fraud_rate_pct 
FROM transactions 
GROUP BY day_of_week 
ORDER BY fraud_rate_pct DESC;

 -- 8. What Time of Day Does Fraud Most Commonly Occur?
SELECT EXTRACT(HOUR FROM transaction_timestamp) AS hour_of_day,
COUNT() AS total_transactions, 
SUM(fraud_flag) AS fraud_transactions, 
ROUND( (SUM(fraud_flag)::NUMERIC / COUNT()) * 100, 2 ) AS fraud_rate_pct, 
ROUND( (SUM(fraud_flag)::NUMERIC / SUM(SUM(fraud_flag)) OVER ()) * 100, 2 ) AS pct_of_all_fraud 
FROM transactions 
GROUP BY hour_of_day 
ORDER BY fraud_transactions DESC;

-- 9. What Locations Have High Fraud Rates?
SELECT transaction_location, transaction_country , COUNT() AS total_transactions, SUM(fraud_flag) AS fraud_transactions, ROUND( SUM(fraud_flag)::NUMERIC / COUNT() * 100, 2 ) AS fraud_rate_pct FROM transactions GROUP BY transaction_location, transaction_country ORDER BY fraud_rate_pct DESC;

-- 10. Which merchants have the highest fraud rates after a minimum transaction threshold?   (Threshold of 100 transactions)
With Merchant As(
SELECT t.merchant_id, m.merchant, m.mcc_code, m.mcc_description,mcc_risk_level,
COUNT(*) AS total_transactions, 
SUM(fraud_flag) AS fraud_transactions, 
ROUND( SUM(fraud_flag)::NUMERIC / COUNT(*) * 100, 2 ) AS fraud_rate_pct 
FROM transactions as t 
left join merchants as m 
on m.merchant_id = t.merchant_id
GROUP BY t.merchant_id, m.merchant, m.mcc_code, m.mcc_description,mcc_risk_level 
ORDER BY fraud_rate_pct DESC)
Select merchant_id, merchant, mcc_code, mcc_description,mcc_risk_level,total_transactions,fraud_transactions,fraud_rate_pct
from merchant
where total_transactions > '100'
GROUP BY merchant_id, merchant, mcc_code, mcc_description,mcc_risk_level,total_transactions,fraud_transactions,fraud_rate_pct 
ORDER BY fraud_rate_pct DESC;

-- 11. What MCC Codes Have High Fraud Rates after a minimum transaction threshold?  (Threshold of 250 transactions)
With MCC AS 
(SELECT m.mcc_code, m.mcc_description, 
COUNT(*) AS total_transactions, SUM(fraud_flag) AS fraud_transactions, 
ROUND( SUM(fraud_flag)::NUMERIC / COUNT(*) * 100, 2 ) AS fraud_rate_pct 
FROM transactions as t 
left join merchants as m 
on m.merchant_id = t.merchant_id 
GROUP BY m.mcc_code, m.mcc_description 
ORDER BY fraud_rate_pct DESC)
Select mcc_code,mcc_description,total_transactions,fraud_transactions,fraud_rate_pct
from MCC
where total_transactions > '250'
GROUP BY mcc_code, mcc_description,total_transactions,fraud_transactions,fraud_rate_pct 
ORDER BY fraud_rate_pct DESC;

-- 12. Have We Seen an Increase in Fraud Year-over-Year?
WITH fraud_monthly AS ( SELECT DATE_TRUNC('month', transaction_date) AS period, SUM(fraud_flag) AS fraud_count FROM transactions GROUP BY 1 ) SELECT period, fraud_count, LAG(fraud_count, 12) OVER ( ORDER BY period ) AS prior_year_fraud_count, ROUND( ( fraud_count - LAG(fraud_count, 12) OVER ( ORDER BY period ) )::numeric / NULLIF( LAG(fraud_count, 12) OVER ( ORDER BY period ), 0 ) * 100, 2 ) AS yoy_change_pct FROM fraud_monthly ORDER BY period DeSC limit 13;

-- 13. What Payment Methods Have High Fraud Rates?
Select payment_method,COUNT() AS total_transactions, SUM(fraud_flag) AS fraud_transactions, ROUND( SUM(fraud_flag)::NUMERIC / COUNT() * 100, 2 ) AS fraud_rate_pct from transactions Group by payment_method Order by fraud_rate_pct DESC;

-- 14. Which IP addresses are associated with multiple customers ?
Select ip_address, transaction_location, transaction_country, sum(fraud_flag) as fraud_count, count(transaction_location) as Locations from transactions Group by ip_address, transaction_location, transaction_country Having sum(fraud_flag) > 0 Order by sum(fraud_flag) DESC;

-- 15. Fraud Rates per Customer Account Age?
With Bins As 
(SELECT *, 	
 NTILE(6) OVER (ORDER BY customer_account_age_days) AS age_bucket
FROM transactions)
Select age_bucket,
concat(min(customer_account_age_days),'-',max(customer_account_age_days)) as age_bucket_range,
COUNT(*) AS total_transactions, SUM(fraud_flag) AS fraud_transactions, 
ROUND( SUM(fraud_flag)::NUMERIC / COUNT(*) * 100, 2 ) AS fraud_rate_pct 
from bins 
group by age_bucket
Order by fraud_rate_pct DESC;

-- 16. Which device types have the highest fraud rate?
Select device_type,
COUNT(*) AS total_transactions, 
SUM(fraud_flag) AS fraud_transactions, 
ROUND( SUM(fraud_flag)::NUMERIC / COUNT(*) * 100, 2 ) AS fraud_rate_pct 
from transactions 
Group by device_type 
Order by fraud_rate_pct DESC;

-- 17. Which authentication methods experience the highest fraud rate?
Select authentication_method,
COUNT(*) AS total_transactions, 
SUM(fraud_flag) AS fraud_transactions, 
ROUND( SUM(fraud_flag)::NUMERIC / COUNT(*) * 100, 2 ) AS fraud_rate_pct 
from transactions 
Group by authentication_method 
Order by fraud_rate_pct DESC;
-- 18. Does fraud vary by customer activity status?
Select account_status,
COUNT(*) AS total_transactions, 
SUM(fraud_flag) AS fraud_transactions, 
ROUND( SUM(fraud_flag)::NUMERIC / COUNT(*) * 100, 2 ) AS fraud_rate_pct 
from transactions 
Group by account_status
Order by fraud_rate_pct DESC;

-- 19. Which transaction amount ranges experience the highest fraud rates?
Select 
Case When transaction_amount <=50 then 'Tier 1'
When transaction_amount >= 51 and transaction_amount <= 100 then 'Tier 2'
when transaction_amount >= 101 and transaction_amount <= 250 then  'Tier 3' 
when transaction_amount >= 251 and transaction_amount <= 500 then 'Tier 4'
Else 'Tier 5' 
End as transaction_tier,
concat(min(transaction_amount),' -',max(transaction_amount)) as tier_range,
Count(*) as transaction_count,
SUM(fraud_flag) AS fraud_transactions,
ROUND(
(SUM(fraud_flag)::NUMERIC / COUNT(*)) * 100,
2
) AS fraud_rate_pct,
ROUND(
(SUM(fraud_flag)::NUMERIC /
SUM(SUM(fraud_flag)) OVER ()) * 100,
2
) AS pct_of_all_fraud
from transactions
Group by transaction_tier
Order by pct_of_all_fraud DESC;
