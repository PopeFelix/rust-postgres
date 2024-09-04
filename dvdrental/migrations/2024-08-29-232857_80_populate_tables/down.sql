-- This file should undo anything in `up.sql`
SET session_replication_role = 'replica';

TRUNCATE TABLE actors CASCADE;
TRUNCATE TABLE addresses CASCADE;
TRUNCATE TABLE categories CASCADE;
TRUNCATE TABLE cities CASCADE;
TRUNCATE TABLE countries CASCADE;
TRUNCATE TABLE customers CASCADE;
TRUNCATE TABLE films CASCADE;
TRUNCATE TABLE films_actors CASCADE;
TRUNCATE TABLE films_categories CASCADE;
TRUNCATE TABLE inventory CASCADE;
TRUNCATE TABLE languages CASCADE;
TRUNCATE TABLE payments CASCADE;
TRUNCATE TABLE rentals CASCADE;
TRUNCATE TABLE employees CASCADE;
TRUNCATE TABLE stores CASCADE;

SET session_replication_role = 'origin';
