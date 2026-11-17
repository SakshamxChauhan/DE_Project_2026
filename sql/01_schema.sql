-- MealBridge Data Warehouse DDL (Star Schema)

CREATE TABLE IF NOT EXISTS dim_donors (
    donor_id INT PRIMARY KEY,
    donor_name VARCHAR(255) NOT NULL,
    category VARCHAR(100),
    city VARCHAR(100)
);

CREATE TABLE IF NOT EXISTS dim_recipients (
    recipient_id INT PRIMARY KEY,
    recipient_name VARCHAR(255) NOT NULL,
    capacity INT,
    city VARCHAR(100)
);

CREATE TABLE IF NOT EXISTS fact_donations (
    donation_id INT PRIMARY KEY,
    donor_id INT REFERENCES dim_donors(donor_id),
    recipient_id INT REFERENCES dim_recipients(recipient_id),
    food_item VARCHAR(255) NOT NULL,
    quantity_kg DECIMAL(10, 2) NOT NULL,
    status VARCHAR(50) NOT NULL,
    created_at TIMESTAMP,
    claimed_at TIMESTAMP,
    time_to_claim_minutes DECIMAL(10, 2)
);
