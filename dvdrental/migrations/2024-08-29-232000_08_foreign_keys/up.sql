ALTER TABLE ONLY public.customers
    ADD CONSTRAINT customers_address_id_fkey FOREIGN KEY (address_id) REFERENCES public.addresses(address_id) ON UPDATE CASCADE ON DELETE RESTRICT;
--
ALTER TABLE ONLY public.employees
    ADD CONSTRAINT employees_address_id_fkey FOREIGN KEY (address_id) REFERENCES public.addresses(address_id) ON UPDATE CASCADE ON DELETE RESTRICT;
--
ALTER TABLE ONLY public.films_actors
    ADD CONSTRAINT films_actor_film_id_fkey FOREIGN KEY (film_id) REFERENCES public.films(film_id) ON UPDATE CASCADE ON DELETE RESTRICT;
--
ALTER TABLE ONLY public.films_actors
    ADD CONSTRAINT films_actors_actor_id_fkey FOREIGN KEY (actor_id) REFERENCES public.actors(actor_id) ON UPDATE CASCADE ON DELETE RESTRICT;
--
ALTER TABLE ONLY public.films_categories
    ADD CONSTRAINT films_categories_category_id_fkey FOREIGN KEY (category_id) REFERENCES public.categories(category_id) ON UPDATE CASCADE ON DELETE RESTRICT;
--
ALTER TABLE ONLY public.films_categories
    ADD CONSTRAINT films_category_film_id_fkey FOREIGN KEY (film_id) REFERENCES public.films(film_id) ON UPDATE CASCADE ON DELETE RESTRICT;
--
ALTER TABLE ONLY public.films
    ADD CONSTRAINT films_language_id_fkey FOREIGN KEY (language_id) REFERENCES public.languages(language_id) ON UPDATE CASCADE ON DELETE RESTRICT;
--
ALTER TABLE ONLY public.addresses
    ADD CONSTRAINT fk_addresses_cities FOREIGN KEY (city_id) REFERENCES public.cities(city_id);
--
ALTER TABLE ONLY public.cities
    ADD CONSTRAINT fk_cities FOREIGN KEY (country_id) REFERENCES public.countries(country_id);
--
ALTER TABLE ONLY public.inventory
    ADD CONSTRAINT inventory_film_id_fkey FOREIGN KEY (film_id) REFERENCES public.films(film_id) ON UPDATE CASCADE ON DELETE RESTRICT;
--
ALTER TABLE ONLY public.payments
    ADD CONSTRAINT payments_customer_id_fkey FOREIGN KEY (customer_id) REFERENCES public.customers(customer_id) ON UPDATE CASCADE ON DELETE RESTRICT;
--
ALTER TABLE ONLY public.payments
    ADD CONSTRAINT payments_employee_id_fkey FOREIGN KEY (employee_id) REFERENCES public.employees(employee_id) ON UPDATE CASCADE ON DELETE RESTRICT;
--
ALTER TABLE ONLY public.payments
    ADD CONSTRAINT payments_rental_id_fkey FOREIGN KEY (rental_id) REFERENCES public.rentals(rental_id) ON UPDATE CASCADE ON DELETE SET NULL;
--
ALTER TABLE ONLY public.rentals
    ADD CONSTRAINT rentals_customer_id_fkey FOREIGN KEY (customer_id) REFERENCES public.customers(customer_id) ON UPDATE CASCADE ON DELETE RESTRICT;
--
ALTER TABLE ONLY public.rentals
    ADD CONSTRAINT rentals_employee_id_key FOREIGN KEY (employee_id) REFERENCES public.employees(employee_id);
--
ALTER TABLE ONLY public.rentals
    ADD CONSTRAINT rentals_inventory_id_fkey FOREIGN KEY (inventory_id) REFERENCES public.inventory(inventory_id) ON UPDATE CASCADE ON DELETE RESTRICT;
--
ALTER TABLE ONLY public.stores
    ADD CONSTRAINT stores_address_id_fkey FOREIGN KEY (address_id) REFERENCES public.addresses(address_id) ON UPDATE CASCADE ON DELETE RESTRICT;
--
ALTER TABLE ONLY public.stores
    ADD CONSTRAINT stores_manager_employee_id_fkey FOREIGN KEY (manager_employee_id) REFERENCES public.employees(employee_id) ON UPDATE CASCADE ON DELETE RESTRICT;
