CREATE VIEW public.actor_info AS
 SELECT a.actor_id,
    a.first_name,
    a.last_name,
    public.group_concat(DISTINCT (((c.name)::text || ': '::text) || ( SELECT public.group_concat((f.title)::text) AS group_concat
           FROM ((public.films f
             JOIN public.films_categories fc_1 ON ((f.film_id = fc_1.film_id)))
             JOIN public.films_actors fa_1 ON ((f.film_id = fa_1.film_id)))
          WHERE ((fc_1.category_id = c.category_id) AND (fa_1.actor_id = a.actor_id))
          GROUP BY fa_1.actor_id))) AS film_info
   FROM (((public.actors a
     LEFT JOIN public.films_actors fa ON ((a.actor_id = fa.actor_id)))
     LEFT JOIN public.films_categories fc ON ((fa.film_id = fc.film_id)))
     LEFT JOIN public.categories c ON ((fc.category_id = c.category_id)))
  GROUP BY a.actor_id, a.first_name, a.last_name;


ALTER VIEW public.actor_info OWNER TO postgres;














CREATE VIEW public.customer_list AS
 SELECT cu.customer_id AS id,
    (((cu.first_name)::text || ' '::text) || (cu.last_name)::text) AS name,
    a.address1,
    a.postal_code AS "zip code",
    a.phone,
    cities.city_name,
    countries.country_name,
        CASE
            WHEN cu.activebool THEN 'active'::text
            ELSE ''::text
        END AS notes,
    cu.store_id AS sid
   FROM (((public.customers cu
     JOIN public.addresses a ON ((cu.address_id = a.address_id)))
     JOIN public.cities ON ((a.city_id = cities.city_id)))
     JOIN public.countries ON ((cities.country_id = countries.country_id)));


ALTER VIEW public.customer_list OWNER TO postgres;





CREATE VIEW public.employee_list AS
 SELECT s.employee_id AS id,
    (((s.first_name)::text || ' '::text) || (s.last_name)::text) AS name,
    a.address1,
    a.postal_code AS "zip code",
    a.phone,
    cities.city_name,
    countries.country_name,
    s.store_id AS sid
   FROM (((public.employees s
     JOIN public.addresses a ON ((s.address_id = a.address_id)))
     JOIN public.cities ON ((a.city_id = cities.city_id)))
     JOIN public.countries ON ((cities.country_id = countries.country_id)));


ALTER VIEW public.employee_list OWNER TO postgres;


CREATE VIEW public.film_list AS
 SELECT films.film_id AS fid,
    films.title,
    films.description,
    categories.name AS categories,
    films.rental_rate AS price,
    films.length,
    films.rating,
    public.group_concat((((actors.first_name)::text || ' '::text) || (actors.last_name)::text)) AS actors
   FROM ((((public.categories
     LEFT JOIN public.films_categories ON ((categories.category_id = films_categories.category_id)))
     LEFT JOIN public.films ON ((films_categories.film_id = films.film_id)))
     JOIN public.films_actors ON ((films.film_id = films_actors.film_id)))
     JOIN public.actors ON ((films_actors.actor_id = actors.actor_id)))
  GROUP BY films.film_id, films.title, films.description, categories.name, films.rental_rate, films.length, films.rating;


ALTER VIEW public.film_list OWNER TO postgres;









CREATE VIEW public.nicer_but_slower_film_list AS
 SELECT films.film_id AS fid,
    films.title,
    films.description,
    categories.name AS categories,
    films.rental_rate AS price,
    films.length,
    films.rating,
    public.group_concat((((upper("substring"((actors.first_name)::text, 1, 1)) || lower("substring"((actors.first_name)::text, 2))) || upper("substring"((actors.last_name)::text, 1, 1))) || lower("substring"((actors.last_name)::text, 2)))) AS actors
   FROM ((((public.categories
     LEFT JOIN public.films_categories ON ((categories.category_id = films_categories.category_id)))
     LEFT JOIN public.films ON ((films_categories.film_id = films.film_id)))
     JOIN public.films_actors ON ((films.film_id = films_actors.film_id)))
     JOIN public.actors ON ((films_actors.actor_id = actors.actor_id)))
  GROUP BY films.film_id, films.title, films.description, categories.name, films.rental_rate, films.length, films.rating;


ALTER VIEW public.nicer_but_slower_film_list OWNER TO postgres;






CREATE VIEW public.sales_by_stores AS
 SELECT (((c.city_name)::text || ','::text) || (cy.country_name)::text) AS stores,
    (((m.first_name)::text || ' '::text) || (m.last_name)::text) AS manager,
    sum(p.amount) AS total_sales
   FROM (((((((public.payments p
     JOIN public.rentals r ON ((p.rental_id = r.rental_id)))
     JOIN public.inventory i ON ((r.inventory_id = i.inventory_id)))
     JOIN public.stores s ON ((i.store_id = s.store_id)))
     JOIN public.addresses a ON ((s.address_id = a.address_id)))
     JOIN public.cities c ON ((a.city_id = c.city_id)))
     JOIN public.countries cy ON ((c.country_id = cy.country_id)))
     JOIN public.employees m ON ((s.manager_employee_id = m.employee_id)))
  GROUP BY cy.country_name, c.city_name, s.store_id, m.first_name, m.last_name
  ORDER BY cy.country_name, c.city_name;


ALTER VIEW public.sales_by_stores OWNER TO postgres;
