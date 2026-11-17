# Data Warehouse Schema Design (Star Schema)

## Dimensions
1. **dim_donors**: Stores details of entities posting surplus food.
   - `donor_id` (Primary Key)
   - `donor_name`
   - `category` (Restaurant, Hotel, Caterer)
   - `city`

2. **dim_recipients**: Stores details of NGOs and shelters receiving food.
   - `recipient_id` (Primary Key)
   - `recipient_name`
   - `capacity`
   - `city`

## Fact Table
1. **fact_donations**: Captures quantitative metrics and key events of every food redistribution transaction.
   - `donation_id` (Primary Key)
   - `donor_id` (Foreign Key)
   - `recipient_id` (Foreign Key)
   - `food_item`
   - `quantity_kg`
   - `status` (Posted, Claimed, Delivered, Expired)
   - `created_at` (Timestamp)
   - `claimed_at` (Timestamp)
   - `time_to_claim_minutes` (Derived analytical metric)
