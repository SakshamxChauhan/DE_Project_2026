SET search_path TO uber;

CREATE TABLE IF NOT EXISTS trips_partitioned (
    trip_id BIGINT NOT NULL,
    rider_id INT NOT NULL,
    driver_id INT,
    vehicle_id INT,
    city_id INT NOT NULL,
    promo_code VARCHAR(30),
    status VARCHAR(30) NOT NULL,
    requested_at TIMESTAMPTZ NOT NULL,
    pickup_at TIMESTAMPTZ,
    dropoff_at TIMESTAMPTZ,
    pickup_lat NUMERIC(9,6),
    pickup_lng NUMERIC(9,6),
    drop_lat NUMERIC(9,6),
    drop_lng NUMERIC(9,6),
    distance_km NUMERIC(8,2),
    duration_min INT,
    surge_multiplier NUMERIC(4,2) DEFAULT 1.00,
    fare_amount NUMERIC(10,2),
    PRIMARY KEY (trip_id, requested_at)
) PARTITION BY RANGE (requested_at);

CREATE TABLE IF NOT EXISTS trips_2026_q1 PARTITION OF trips_partitioned
    FOR VALUES FROM ('2026-01-01 00:00:00+05:30') TO ('2026-04-01 00:00:00+05:30');

CREATE TABLE IF NOT EXISTS trips_2026_q2 PARTITION OF trips_partitioned
    FOR VALUES FROM ('2026-04-01 00:00:00+05:30') TO ('2026-07-01 00:00:00+05:30');

CREATE TABLE IF NOT EXISTS trips_2026_default PARTITION OF trips_partitioned DEFAULT;

INSERT INTO trips_partitioned SELECT * FROM trips ON CONFLICT DO NOTHING;

CREATE INDEX IF NOT EXISTS idx_trips_part_city_req ON trips_partitioned (city_id, requested_at);
CREATE INDEX IF NOT EXISTS idx_trips_part_rider_req ON trips_partitioned (rider_id, requested_at DESC);

ANALYZE trips_partitioned;
