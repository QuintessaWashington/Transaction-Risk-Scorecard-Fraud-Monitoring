DROP TABLE IF EXISTS customers;

CREATE TABLE customers (
    customer_id         BIGINT PRIMARY KEY,
    gender              VARCHAR(1),
    first_name          VARCHAR(50),
    last_name           VARCHAR(50),
    date_of_birth       DATE,
    signup_date         DATE,
    home_city           VARCHAR(100),
    home_state          VARCHAR(50),
    age_at_signup       INTEGER);

DROP TABLE IF EXISTS ip_address;

CREATE TABLE ip_address (
    ip_id INTEGER PRIMARY KEY,
    ip_address VARCHAR(15) NOT NULL,
    state_province VARCHAR(100) NOT NULL,
    country VARCHAR(50) NOT NULL,
    location_risk_level VARCHAR(10) NOT NULL,
    ip_type VARCHAR(20) NOT NULL,
    ip_risk_level VARCHAR(10) NOT NULL,
    combined_risk_level VARCHAR(10) NOT NULL);

CREATE TABLE merchants (
    merchant_id VARCHAR(4) PRIMARY KEY,
    merchant VARCHAR(30) NOT NULL,
    mcc_code INTEGER NOT NULL,
    mcc_description VARCHAR(40) NOT NULL,
    category VARCHAR(25) NOT NULL,
    mcc_risk_level VARCHAR(10) NOT NULL);

CREATE TABLE location_risk (
    location_id VARCHAR(10) PRIMARY KEY,
    city VARCHAR(100) NOT NULL,
    state_province VARCHAR(100),
    country VARCHAR(100) NOT NULL,
    risk_level VARCHAR(10) NOT NULL);

DROP TABLE IF EXISTS transactions;

CREATE TABLE transactions (
    transaction_id VARCHAR(10) PRIMARY KEY,
    customer_id BIGINT NOT NULL,
    transaction_date DATE NOT NULL,
    transaction_timestamp TIMESTAMP NOT NULL,

    customer_account_age_days INTEGER,
    transaction_amount NUMERIC(10,2),
    daily_trans_count INTEGER,

    transaction_type VARCHAR(30),
    payment_method VARCHAR(20),
    device_type VARCHAR(15),

    ip_address VARCHAR(45),

    authentication_method VARCHAR(25),

    merchant_id VARCHAR(10),
    merchant_category VARCHAR(30),

    transaction_location VARCHAR(50),
    transaction_country VARCHAR(50),

    payment_status VARCHAR(20),

    fraud_flag SMALLINT);



