# Query Optimization & Indexing Report (CP3)

## 1. Indexing & Query Rewrite Strategy
- **Composite & Covering Indexes (`sql/05_indexes.sql`)**: Created targeted B-tree indexes on `(rider_id, requested_at DESC)`, `(driver_id, status, requested_at)`, `(city_id, requested_at)`, `(payment_status, paid_at)`, and functional index `LOWER(email)`.
- **Partial Indexes**: Added filtered indexes for active dispatch (`status IN ('REQUESTED','ACCEPTED','ONGOING')`) and ongoing trip lookup (`status = 'ONGOING'`) to minimize index bloat and write overhead.
- **SARGable Query Rewrites (`sql/06_optimized_queries.sql`)**: Replaced non-SARGable `DATE(requested_at)`, `EXTRACT(YEAR FROM paid_at)`, and `requested_at::date` predicates with half-open range bounds (`>=` and `<`), and converted `NOT IN` subqueries (`R09`, `R10`) into anti-join `NOT EXISTS`.

## 2. Before vs. After Benchmark Comparison

| Query ID | Type | Baseline Avg (ms) | Optimized Avg (ms) | Speedup | Optimized Plan Node |
| :--- | :--- | ---: | ---: | ---: | :--- |
| R01 | READ | 13.707 | 0.056 | 244.77x | Bitmap Heap Scan on trips | Bitmap Index Scan on idx_trips_rider_req |
| R02 | READ | 11.297 | 0.055 | 205.40x | Bitmap Heap Scan on trips | Bitmap Index Scan on idx_trips_driver_status_req |
| R03 | READ | 6.440 | 0.109 | 59.08x | Index Scan using idx_riders_lower_email on riders |
| R04 | READ | 9.680 | 0.152 | 63.68x | Seq Scan on cities | Bitmap Heap Scan on trips | Bitmap Index Scan on idx_trips_city_req |
| R05 | READ | 14.166 | 0.285 | 49.71x | Index Scan using idx_trips_active_status on trips |
| R06 | READ | 10.635 | 18.678 | 0.57x | Bitmap Heap Scan on trips | Bitmap Index Scan on idx_trips_status_req | Seq Scan on cities |
| R07 | READ | 12.810 | 14.577 | 0.88x | Seq Scan on cities | Seq Scan on drivers | Index Scan using idx_trips_driver_status_req on trips |
| R08 | READ | 66.565 | 58.292 | 1.14x | Seq Scan on payments |
| R09 | READ | 24.733 | 5.054 | 4.89x | Seq Scan on riders | Index Only Scan using idx_trips_rider_req on trips |
| R10 | READ | 14.236 | 5.858 | 2.43x | Index Only Scan using idx_trips_driver_status_req on trips | Seq Scan on drivers |
| R11 | READ | 17.016 | 25.770 | 0.66x | Index Only Scan using idx_ratings_rated_by_trip on ratings | Index Scan using trips_pkey on trips |
| R12 | READ | 31.174 | 18.942 | 1.65x | Seq Scan on cities | Bitmap Heap Scan on trips | Bitmap Index Scan on idx_trips_city_req |
| R13 | READ | 6.715 | 6.479 | 1.04x | Seq Scan on riders |
| R14 | READ | 0.194 | 0.027 | 7.19x | Index Scan using idx_vehicles_reg_no on vehicles | Index Scan using drivers_pkey on drivers |
| R15 | READ | 6.648 | 0.077 | 86.34x | Index Scan using trips_pkey on trips | Index Scan using riders_pkey on riders | Index Scan using drivers_pkey on drivers | Index Scan using vehicles_pkey on vehicles | Index Scan using idx_payments_trip_id on payments |
| R16 | READ | 26.842 | 30.268 | 0.89x | Index Scan using trips_pkey on trips |
| R17 | READ | 17.641 | 17.436 | 1.01x | Seq Scan on trips | Seq Scan on cities |
| R18 | READ | 36263.480 | 6.405 | 5661.75x | Seq Scan on riders | Index Only Scan using idx_trips_rider_req on trips |
| R19 | READ | 11.242 | 10.703 | 1.05x | Bitmap Heap Scan on trips | Bitmap Index Scan on idx_trips_status_req | Seq Scan on drivers |
| R20 | READ | 12.327 | 9.715 | 1.27x | Bitmap Heap Scan on trips | Bitmap Index Scan on idx_trips_status_req |
| R21 | READ | 23.744 | 16.041 | 1.48x | Index Scan using promo_codes_pkey on promo_codes | Index Scan using idx_trips_promo_code on trips |
| R22 | READ | 5.731 | 0.024 | 238.79x | Index Scan using idx_payments_status_paid on payments | Index Scan using trips_pkey on trips | Index Scan using riders_pkey on riders |
| R23 | READ | 131.172 | 132.275 | 0.99x | Seq Scan on trips |
| R24 | READ | 12.320 | 12.486 | 0.99x | Seq Scan on trips |
| R25 | READ | 16.990 | 17.577 | 0.97x | Seq Scan on trips |
| W01 | WRITE | 0.389 | 0.489 | 0.80x | (no scan) |
| W02 | WRITE | 0.134 | 0.226 | 0.59x | Index Only Scan using idx_trips_ongoing_id on trips | Index Scan using trips_pkey on trips |
| W03 | WRITE | 2.293 | 2.922 | 0.78x | Bitmap Heap Scan on drivers | Bitmap Index Scan on idx_drivers_status_rating |
| W04 | WRITE | 31.443 | 55.475 | 0.57x | (no scan) |
| W05 | WRITE | 15.218 | 3.433 | 4.43x | Index Scan using idx_trips_city_req on trips |
