SET search_path TO uber;

CREATE INDEX IF NOT EXISTS idx_trips_rider_req ON trips (rider_id, requested_at DESC);
CREATE INDEX IF NOT EXISTS idx_trips_driver_status_req ON trips (driver_id, status, requested_at);
CREATE INDEX IF NOT EXISTS idx_riders_lower_email ON riders (LOWER(email));
CREATE INDEX IF NOT EXISTS idx_trips_city_req ON trips (city_id, requested_at);
CREATE INDEX IF NOT EXISTS idx_trips_active_status ON trips (requested_at) WHERE status IN ('REQUESTED', 'ACCEPTED', 'ONGOING');
CREATE INDEX IF NOT EXISTS idx_trips_status_req ON trips (status, requested_at);
CREATE INDEX IF NOT EXISTS idx_payments_status_paid ON payments (payment_status, paid_at);
CREATE INDEX IF NOT EXISTS idx_ratings_rated_by_trip ON ratings (rated_by, trip_id) INCLUDE (stars);
CREATE INDEX IF NOT EXISTS idx_vehicles_reg_no ON vehicles (registration_no);
CREATE INDEX IF NOT EXISTS idx_payments_trip_id ON payments (trip_id);
CREATE INDEX IF NOT EXISTS idx_trips_promo_code ON trips (promo_code) WHERE promo_code IS NOT NULL;
CREATE INDEX IF NOT EXISTS idx_trips_ongoing_id ON trips (trip_id) WHERE status = 'ONGOING';
CREATE INDEX IF NOT EXISTS idx_drivers_status_rating ON drivers (status, driver_rating);

ANALYZE;
