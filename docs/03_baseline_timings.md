# Baseline Performance Timings (CP2)

## Benchmark Configuration
- **Database Engine**: PostgreSQL 16 (`EXPLAIN (ANALYZE, BUFFERS)`)
- **Dataset Scale**: 250,000 trips, 250,000 payments, 150,000 ratings, 30,000 riders, 5,000 drivers
- **Workload**: `queries/workload_30.sql` (25 Read + 5 Write queries, 3 runs each)

## Execution Timings (ms)

| Query ID | Type | Run 1 (ms) | Run 2 (ms) | Run 3 (ms) | Average (ms) | Dominant Plan Node |
| :--- | :--- | ---: | ---: | ---: | ---: | :--- |
| R01 | READ | 18.158 | 13.496 | 9.466 | 13.707 | Seq Scan on trips |
| R02 | READ | 13.284 | 10.788 | 9.819 | 11.297 | Seq Scan on trips |
| R03 | READ | 6.648 | 5.438 | 7.235 | 6.440 | Seq Scan on riders |
| R04 | READ | 11.242 | 7.615 | 10.184 | 9.680 | Seq Scan on trips | Seq Scan on cities |
| R05 | READ | 14.819 | 14.619 | 13.061 | 14.166 | Seq Scan on trips |
| R06 | READ | 11.365 | 9.930 | 10.611 | 10.635 | Seq Scan on trips | Seq Scan on cities |
| R07 | READ | 13.253 | 12.963 | 12.214 | 12.810 | Seq Scan on trips | Seq Scan on drivers | Seq Scan on cities |
| R08 | READ | 67.594 | 66.670 | 65.431 | 66.565 | Seq Scan on payments |
| R09 | READ | 24.584 | 25.248 | 24.368 | 24.733 | Seq Scan on riders | Seq Scan on trips |
| R10 | READ | 14.447 | 14.185 | 14.077 | 14.236 | Seq Scan on drivers | Seq Scan on trips |
| R11 | READ | 17.311 | 17.055 | 16.683 | 17.016 | Seq Scan on trips | Seq Scan on ratings |
| R12 | READ | 31.283 | 31.275 | 30.964 | 31.174 | Seq Scan on trips | Seq Scan on cities |
| R13 | READ | 6.655 | 6.595 | 6.894 | 6.715 | Seq Scan on riders |
| R14 | READ | 0.189 | 0.207 | 0.185 | 0.194 | Seq Scan on vehicles | Index Scan using drivers_pkey on drivers |
| R15 | READ | 7.088 | 5.474 | 7.382 | 6.648 | Index Scan using trips_pkey on trips | Index Scan using riders_pkey on riders | Index Scan using drivers_pkey on drivers | Index Scan using vehicles_pkey on vehicles | Seq Scan on payments |
| R16 | READ | 30.120 | 26.160 | 24.246 | 26.842 | Index Scan using trips_pkey on trips |
| R17 | READ | 17.805 | 17.442 | 17.677 | 17.641 | Seq Scan on trips | Seq Scan on cities |
| R18 | READ | 36402.826 | 36753.918 | 35633.696 | 36263.480 | Seq Scan on riders | Seq Scan on trips |
| R19 | READ | 11.761 | 11.022 | 10.942 | 11.242 | Seq Scan on trips | Seq Scan on drivers |
| R20 | READ | 12.550 | 12.274 | 12.156 | 12.327 | Seq Scan on trips |
| R21 | READ | 23.838 | 23.616 | 23.778 | 23.744 | Seq Scan on trips | Seq Scan on promo_codes |
| R22 | READ | 5.748 | 5.835 | 5.610 | 5.731 | Seq Scan on payments | Index Scan using trips_pkey on trips | Index Scan using riders_pkey on riders |
| R23 | READ | 131.122 | 131.710 | 130.684 | 131.172 | Seq Scan on trips |
| R24 | READ | 12.872 | 12.323 | 11.765 | 12.320 | Seq Scan on trips |
| R25 | READ | 16.968 | 17.231 | 16.772 | 16.990 | Seq Scan on trips |
| W01 | WRITE | 0.427 | 0.379 | 0.362 | 0.389 | (no scan) |
| W02 | WRITE | 0.147 | 0.136 | 0.120 | 0.134 | Index Scan using trips_pkey on trips |
| W03 | WRITE | 2.136 | 1.634 | 3.108 | 2.293 | Seq Scan on drivers |
| W04 | WRITE | 35.829 | 30.151 | 28.348 | 31.443 | (no scan) |
| W05 | WRITE | 15.446 | 15.179 | 15.028 | 15.218 | Seq Scan on trips |
