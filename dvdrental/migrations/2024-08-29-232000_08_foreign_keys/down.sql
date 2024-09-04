ALTER TABLE ONLY public.customers
    DROP CONSTRAINT customers_address_id_fkey;
ALTER TABLE ONLY public.employees
    DROP CONSTRAINT employees_address_id_fkey;
ALTER TABLE ONLY public.films_actors
    DROP CONSTRAINT films_actor_film_id_fkey;
ALTER TABLE ONLY public.films_actors
    DROP CONSTRAINT films_actors_actor_id_fkey;
ALTER TABLE ONLY public.films_categories
    DROP CONSTRAINT films_categories_category_id_fkey;
ALTER TABLE ONLY public.films_categories
    DROP CONSTRAINT films_category_film_id_fkey;
ALTER TABLE ONLY public.films
    DROP CONSTRAINT films_language_id_fkey;
ALTER TABLE ONLY public.addresses
    DROP CONSTRAINT fk_addresses_cities;
ALTER TABLE ONLY public.cities
    DROP CONSTRAINT fk_cities;
ALTER TABLE ONLY public.inventory
    DROP CONSTRAINT inventory_film_id_fkey;
ALTER TABLE ONLY public.payments
    DROP CONSTRAINT payments_customer_id_fkey;
ALTER TABLE ONLY public.payments
    DROP CONSTRAINT payments_employee_id_fkey;
ALTER TABLE ONLY public.payments
    DROP CONSTRAINT payments_rental_id_fkey;
ALTER TABLE ONLY public.rentals
    DROP CONSTRAINT rentals_customer_id_fkey;
ALTER TABLE ONLY public.rentals
    DROP CONSTRAINT rentals_employee_id_key;
ALTER TABLE ONLY public.rentals
    DROP CONSTRAINT rentals_inventory_id_fkey;
ALTER TABLE ONLY public.stores
    DROP CONSTRAINT stores_address_id_fkey;
ALTER TABLE ONLY public.stores
    DROP CONSTRAINT stores_manager_employee_id_fkey;
