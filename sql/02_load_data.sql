-- Sample Seed Data for MealBridge Analytical Warehouse

INSERT INTO dim_donors (donor_id, donor_name, category, city) VALUES
(101, 'Hotel Grand Taj', 'Hotel', 'Sonipat'),
(102, 'Campus Canteen', 'Cafeteria', 'Sonipat'),
(103, 'Fresh Bakers', 'Bakery', 'Delhi');

INSERT INTO dim_recipients (recipient_id, recipient_name, capacity, city) VALUES
(201, 'Hope Shelter Home', 100, 'Sonipat'),
(202, 'Child Welfare Center', 50, 'Delhi');

INSERT INTO fact_donations (donation_id, donor_id, recipient_id, food_item, quantity_kg, status, created_at, claimed_at, time_to_claim_minutes) VALUES
(1, 101, 201, 'Mixed Veg & Rice', 25.50, 'Delivered', '2026-11-01 12:00:00', '2026-11-01 12:30:00', 30.0),
(2, 102, 201, 'Surplus Sandwich Platters', 10.00, 'Claimed', '2026-11-02 14:00:00', '2026-11-02 14:15:00', 15.0),
(3, 103, 202, 'Fresh Bread Loaves', 15.20, 'Delivered', '2026-11-03 09:00:00', '2026-11-03 09:45:00', 45.0);
