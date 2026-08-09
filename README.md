##  Transaction Risk and Fraud Monitoring for Buy Now, Pay Later (BNPL) Company with (Excel/SQL/Tableau)

Author: Quintessa Washington

## About This Project

This portfolio project was developed to demonstrate practical fraud
analytics skills across the complete analytics lifecycle from data
generation and database design to risk scoring, visualization, and
business communication. While the company and data are fictional, the
methodologies reflect real-world fraud analytics concepts used within
the financial services industry.

## Executive Summary

Financial institutions process millions of transactions every day,
making it impossible for fraud analysts to manually review every
payment. Effective fraud monitoring requires transforming raw
transaction data into actionable risk signals that prioritize
investigations while minimizing operational costs.

This project demonstrates the design and development of an end-to-end
Fraud Indicator Reporting System for NovaPay, a fictional Buy Now, Pay
Later (BNPL) financial technology company.

## Business Objective

Design and deliver a fraud analytics solution capable of:

-   Detecting potentially fraudulent transactions

-   Identifying high-risk behavioral patterns

-   Prioritizing investigations using transaction risk scores

-   Supporting both strategic and operational fraud decisions

-   Demonstrating an end-to-end fraud analytics workflow

## Project Highlights

-   Designed a fictional BNPL company (NovaPay) to simulate a real-world
    fraud analytics engagement.

-   Generated a realistic synthetic transaction dataset using banking
    logic and Excel formulas.

-   Built a PostgreSQL relational database.

-   Performed Exploratory Data Analysis (EDA) using SQL.

-   Engineered multiple fraud indicators based on transaction behavior.

-   Developed a weighted Transaction Risk Score Engine.

-   Classified transactions into operational decision tiers.

-   Built interactive Tableau dashboards for fraud monitoring and
    executive reporting.

## Project Workflow

Business Requirements -> Synthetic Data Generation -\> PostgreSQL
Database Design -\> SQL Exploratory Data Analysis -\> Fraud Indicator
Engineering -\> Transaction Risk Score Engine -\> Risk Classification
-\> Transaction Risk Scorecard Evaluation Dashboard -\> Fraud Risk
Monitoring Dashboard

## Tools & Techniques

-   PostgreSQL: Database Management

-   SQL: Data exploration and fraud logic

-   Tableau: Dashboard development

-   Excel: Synthetic data generation

-   GitHub: Documentation

## Dataset Overview

|Metric | Value|
|--- | ---|
|Customers| 8,325 |
|Transactions | 81,758 | 
|Date Range | Aug 2015 - Jun 2026 | 
|Total Transaction Volume | $20.8 Million | 
|Industry | Buy Now, Pay Later (BNPL) |

[View database creation queries](https://github.com/QuintessaWashington/Transaction-Risk-Scorecard-Fraud-Monitoring/blob/main/01_database_schema.sql)


## Synthetic Data Generation

One of the primary goals of this project was demonstrating the ability
to create realistic financial data when production banking data is
unavailable.

The synthetic dataset was generated using banking-inspired business
rules rather than purely random values.

Examples include:

-   Customer lifecycle simulation

-   Account age calculations

-   Transaction velocity

-   Device behavior

-   Geographic risk

-   Merchant risk

-   Authentication methods

-   Payment outcomes

-   Fraud probability modeling

This approach creates a dataset that more closely resembles a production fraud environment while protecting sensitive financial information.
**[Download the Synthetic Database Tables](https://github.com/QuintessaWashington/Transaction-Risk-Scorecard-Fraud-Monitoring/blob/main/Database_Tables.zip)**

## Exploratory Data Analysis

The project begins with SQL based exploratory analysis to understand
customer behavior and identify potential fraud patterns.

Questions explored include:

-   How many transactions occurred?

-   Which days experience the highest fraud activity?

-   What transaction amounts are most associated with fraud?

-   Which merchant categories present the highest risk?

-   Which geographic regions require additional monitoring?

-   When does fraud most commonly occur?

These findings informed the design of the fraud indicators used later in
the project.

## Fraud Indicator Engineering

Behavioral indicators were engineered using SQL to identify suspicious
activity.

Indicators include:

-   IP Risk

-   High-Risk Geography

-   Account Age

-   Authentication Method

-   Weekend Activity

-   Transaction Amount

-   Transaction Velocity

-   Device Type

-   Payment Status

-   Transaction Type

Each indicator contributes to an overall Transaction Risk Score.

## Transaction Risk Score Engine

A weighted scoring model was developed to prioritize transactions for
fraud operations.

Decision Engine

| Risk Score | Action |
| --- | --- |
| 0--24 | Approve |
| 25--49 | Approve & Monitor |
| 50--69 | Manual Review |
| 70--100 | Decline |

This approach demonstrates how multiple behavioral indicators can be
combined into a transparent, explainable fraud decision framework.

## Dashboards

### Transaction Risk Scorecard Evaluation Dashboard

[View the Interactive Dashboard on Tableau Public](https://public.tableau.com/views/TransactionRiskScorecardEvaluation/TransactionRiskScorecardEvaluation?:language=en-US&:sid=&:redirect=auth&:display_count=n&:origin=viz_share_link)

Provides leadership with high-level fraud performance metrics,
including:

-   Fraud Capture Rate

-   False Positive Rate

-   Total Fraud Exposure

-   Potential Fraud Savings

-   Risk Score Distribution

-   Operational KPIs

  

### Fraud Risk Monitoring Dashboard

[View the Interactive Dashboard on Tableau Public](https://public.tableau.com/views/RiskMonitoringDashboard_17849507629950/NovaPayFraudRiskMonitoringDashboard?:language=en-US&:sid=&:redirect=auth&:display_count=n&:origin=viz_share_link)

Designed for fraud analysts to monitor high-risk transactions in real
time.

Features include:

-   Decision Tier Filters

-   Transaction Drilldowns

-   High-Risk Transaction Queue

-   Fraud Trend Monitoring

-   Operational Investigation Support

## Business Value

This project demonstrates how fraud analytics extends beyond reporting
by transforming raw transaction data into actionable business
intelligence.

The workflow mirrors the responsibilities of a Fraud Analytics
professional responsible for:

-   Fraud detection strategy

-   Risk segmentation

-   Operational reporting

-   Decision support

-   Executive communication



