-- Users table
CREATE TABLE users (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    password_hash VARCHAR(255) NOT NULL,
    phone VARCHAR(20),
    pix_key VARCHAR(100),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Universities table
CREATE TABLE universities (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    city VARCHAR(100) NOT NULL,
    state CHAR(2) NOT NULL
);

-- Rides table
CREATE TABLE rides (
    id SERIAL PRIMARY KEY,
    driver_id INTEGER REFERENCES users(id) ON DELETE SET NULL,
    university_origin_id INTEGER REFERENCES universities(id),
    departure_datetime TIMESTAMP NOT NULL,
    available_seats INTEGER NOT NULL,
    route_description TEXT,
    status VARCHAR(20) CHECK (status IN ('active', 'completed', 'cancelled')),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Ride destinations table
CREATE TABLE ride_destinations (
    id SERIAL PRIMARY KEY,
    ride_id INTEGER REFERENCES rides(id) ON DELETE CASCADE,
    city VARCHAR(100) NOT NULL,
    state CHAR(2) NOT NULL,
    price DECIMAL(10, 2) NOT NULL,
    order_num INTEGER NOT NULL,
    UNIQUE (ride_id, order_num)
);

-- Bookings table
CREATE TABLE bookings (
    id SERIAL PRIMARY KEY,
    ride_id INTEGER REFERENCES rides(id) ON DELETE CASCADE,
    passenger_id INTEGER REFERENCES users(id) ON DELETE CASCADE,
    destination_id INTEGER REFERENCES ride_destinations(id) ON DELETE CASCADE,
    status VARCHAR(20) CHECK (status IN ('pending', 'confirmed', 'cancelled')),
    booked_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Indexes for improving query performance
CREATE INDEX idx_rides_departure_datetime ON rides(departure_datetime DESC);
CREATE INDEX idx_rides_university_origin ON rides(university_origin_id);
CREATE INDEX idx_ride_destinations_ride_id ON ride_destinations(ride_id);
CREATE INDEX idx_bookings_ride_passenger ON bookings(ride_id, passenger_id);
