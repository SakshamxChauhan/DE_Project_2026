# Scalability & Partitioning Report (CP4)

## 1. Scale-Up & Range Partitioning Architecture
- **Data Scale**: Scaled `trips` 3x from **250,000 rows** to **750,000 rows**.
- **Declarative Range Partitioning (`sql/08_partitioning.sql`)**: Implemented `trips_partitioned` partitioned by `RANGE (requested_at)` across quarterly partitions (`trips_2026_q1`, `trips_2026_q2`, `trips_2026_default`), enabling PostgreSQL partition pruning for date-bounded analytical queries (`R02`, `R04`, `R06`, `R07`, `R19`, `R20`).

## 2. 250K vs. 750K Rows Performance Comparison

| Query ID | Type | 250K Optimized Avg (ms) | 750K Scaled Avg (ms) | Scale Factor | Plan Node at 750K |
| :--- | :--- | ---: | ---: | ---: | :--- |
| R01 | READ | 0.056 | 0.064 | 1.14x | Index Scan using idx_trips_rider_req on trips |
| R02 | READ | 0.055 | 0.103 | 1.87x | Bitmap Heap Scan on trips | Bitmap Index Scan on idx_trips_driver_status_req |
| R03 | READ | 0.109 | 0.083 | 0.76x | Index Scan using idx_riders_lower_email on riders |
| R04 | READ | 0.152 | 0.137 | 0.90x | Seq Scan on cities | Bitmap Heap Scan on trips | Bitmap Index Scan on idx_trips_city_req |
| R05 | READ | 0.285 | 0.259 | 0.91x | Index Scan using idx_trips_active_status on trips |
| R06 | READ | 18.678 | 24.699 | 1.32x | Bitmap Heap Scan on trips | Bitmap Index Scan on idx_trips_status_req | Seq Scan on cities |
| R07 | READ | 14.577 | 33.068 | 2.27x | Seq Scan on cities | Seq Scan on drivers | Index Scan using idx_trips_driver_status_req on trips |
| R08 | READ | 58.292 | 58.541 | 1.00x | Seq Scan on payments |
| R09 | READ | 5.054 | 15.446 | 3.06x | Seq Scan on riders | Index Only Scan using idx_trips_rider_req on trips |
| R10 | READ | 5.858 | 19.896 | 3.40x | Seq Scan on trips | Seq Scan on drivers |
| R11 | READ | 25.770 | 26.408 | 1.02x | Index Only Scan using idx_ratings_rated_by_trip on ratings | Index Scan using trips_pkey on trips |
| R12 | READ | 18.942 | 71.880 | 3.79x | Seq Scan on cities | Bitmap Heap Scan on trips | Bitmap Index Scan on idx_trips_city_req |
| R13 | READ | 6.479 | 7.278 | 1.12x | Seq Scan on riders |
| R14 | READ | 0.027 | 0.035 | 1.30x | Index Scan using idx_vehicles_reg_no on vehicles | Index Scan using drivers_pkey on drivers |
| R15 | READ | 0.077 | 1.402 | 18.21x | Index Scan using trips_pkey on trips | Index Scan using riders_pkey on riders | Index Scan using drivers_pkey on drivers | Index Scan using vehicles_pkey on vehicles | Index Scan using idx_payments_trip_id on payments |
| R16 | READ | 30.268 | 33.098 | 1.09x | Index Scan using trips_pkey on trips |
| R17 | READ | 17.436 | 49.218 | 2.82x | Seq Scan on trips | Seq Scan on cities |
| R18 | READ | 6.405 | 13.011 | 2.03x | Seq Scan on riders | Index Only Scan using idx_trips_rider_req on trips |
| R19 | READ | 10.703 | 28.974 | 2.71x | Bitmap Heap Scan on trips | Bitmap Index Scan on idx_trips_status_req | Seq Scan on drivers |
| R20 | READ | 9.715 | 36.501 | 3.76x | Bitmap Heap Scan on trips | Bitmap Index Scan on idx_trips_status_req |
| R21 | READ | 16.041 | 44.072 | 2.75x | Index Scan using promo_codes_pkey on promo_codes | Index Scan using idx_trips_promo_code on trips |
| R22 | READ | 0.024 | 0.124 | 5.17x | Index Scan using idx_payments_status_paid on payments | Index Scan using trips_pkey on trips | Index Scan using riders_pkey on riders |
| R23 | READ | 132.275 | 420.567 | 3.18x | Seq Scan on trips |
| R24 | READ | 12.486 | 34.385 | 2.75x | Seq Scan on trips |
| R25 | READ | 17.577 | 49.507 | 2.82x | Seq Scan on trips |
| W01 | WRITE | 0.489 | 0.565 | 1.16x | (no scan) |
| W02 | WRITE | 0.226 | 0.246 | 1.09x | Index Only Scan using idx_trips_ongoing_id on trips | Index Scan using trips_pkey on trips |
| W03 | WRITE | 2.922 | 3.233 | 1.11x | Bitmap Heap Scan on drivers | Bitmap Index Scan on idx_drivers_status_rating |
| W04 | WRITE | 55.475 | 63.489 | 1.14x | (no scan) |
| W05 | WRITE | 3.433 | 2.440 | 0.71x | Index Scan using idx_trips_city_req on trips |
