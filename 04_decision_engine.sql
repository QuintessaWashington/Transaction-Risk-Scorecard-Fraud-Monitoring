ALTER TABLE risk_scorecard
ADD decision_engine VARCHAR(25);


UPDATE risk_scorecard
SET decision_engine =
CASE
WHEN transaction_risk_score <= 20 THEN 'Approve'
WHEN transaction_risk_score BETWEEN 21 AND 40 THEN 'Approve & Monitor'
WHEN transaction_risk_score BETWEEN 41 AND 60 THEN 'Manual Review'
ELSE 'Decline'
END;


ALTER TABLE risk_scorecard
ADD risk_tier VARCHAR(25);

UPDATE risk_scorecard
SET risk_tier =
CASE
WHEN transaction_risk_score <= 20 THEN 'LOW'
WHEN transaction_risk_score BETWEEN 21 AND 40 THEN 'Moderate'
WHEN transaction_risk_score BETWEEN 41 AND 60 THEN 'High'
ELSE 'Critical'
END;
