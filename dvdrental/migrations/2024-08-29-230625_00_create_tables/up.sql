CREATE SEQUENCE public.customers_customer_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.customers_customer_id_seq OWNER TO postgres;

CREATE TABLE public.customers (
    customer_id integer DEFAULT nextval('public.customers_customer_id_seq'::regclass) NOT NULL,
    store_id smallint NOT NULL,
    first_name character varying(45) NOT NULL,
    last_name character varying(45) NOT NULL,
    email character varying(50),
    address_id smallint NOT NULL,
    activebool boolean DEFAULT true NOT NULL,
    create_date date DEFAULT ('now'::text)::date NOT NULL,
    last_update timestamp without time zone DEFAULT now(),
    active integer
);


ALTER TABLE public.customers OWNER TO postgres;

CREATE SEQUENCE public.actors_actor_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.actors_actor_id_seq OWNER TO postgres;


CREATE TABLE public.actors (
    actor_id integer DEFAULT nextval('public.actors_actor_id_seq'::regclass) NOT NULL,
    first_name character varying(45) NOT NULL,
    last_name character varying(45) NOT NULL,
    last_update timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.actors OWNER TO postgres;


CREATE SEQUENCE public.categories_category_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.categories_category_id_seq OWNER TO postgres;


CREATE TABLE public.categories (
    category_id integer DEFAULT nextval('public.categories_category_id_seq'::regclass) NOT NULL,
    name character varying(25) NOT NULL,
    last_update timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.categories OWNER TO postgres;


CREATE SEQUENCE public.films_film_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.films_film_id_seq OWNER TO postgres;


CREATE TABLE public.films (
    film_id integer DEFAULT nextval('public.films_film_id_seq'::regclass) NOT NULL,
    title character varying(255) NOT NULL,
    description text,
    release_year public.year,
    language_id smallint NOT NULL,
    rental_duration smallint DEFAULT 3 NOT NULL,
    rental_rate numeric(4,2) DEFAULT 4.99 NOT NULL,
    length smallint,
    replacement_cost numeric(5,2) DEFAULT 19.99 NOT NULL,
    rating public.mpaa_rating DEFAULT 'G'::public.mpaa_rating,
    last_update timestamp without time zone DEFAULT now() NOT NULL,
    special_features text[],
    fulltext tsvector NOT NULL
);


ALTER TABLE public.films OWNER TO postgres;


CREATE TABLE public.films_actors (
    actor_id smallint NOT NULL,
    film_id smallint NOT NULL,
    last_update timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.films_actors OWNER TO postgres;


CREATE TABLE public.films_categories (
    film_id smallint NOT NULL,
    category_id smallint NOT NULL,
    last_update timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.films_categories OWNER TO postgres;





CREATE SEQUENCE public.addresses_address_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.addresses_address_id_seq OWNER TO postgres;


CREATE TABLE public.addresses (
    address_id integer DEFAULT nextval('public.addresses_address_id_seq'::regclass) NOT NULL,
    address1 character varying(50) NOT NULL,
    address2 character varying(50),
    district character varying(20) NOT NULL,
    city_id smallint NOT NULL,
    postal_code character varying(10),
    phone character varying(20) NOT NULL,
    last_update timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.addresses OWNER TO postgres;


CREATE SEQUENCE public.cities_city_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.cities_city_id_seq OWNER TO postgres;


CREATE TABLE public.cities (
    city_id integer DEFAULT nextval('public.cities_city_id_seq'::regclass) NOT NULL,
    city_name character varying(50) NOT NULL,
    country_id smallint NOT NULL,
    last_update timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.cities OWNER TO postgres;


CREATE SEQUENCE public.countries_country_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.countries_country_id_seq OWNER TO postgres;


CREATE TABLE public.countries (
    country_id integer DEFAULT nextval('public.countries_country_id_seq'::regclass) NOT NULL,
    country_name character varying(50) NOT NULL,
    last_update timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.countries OWNER TO postgres;





CREATE SEQUENCE public.employees_employee_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.employees_employee_id_seq OWNER TO postgres;


CREATE TABLE public.employees (
    employee_id integer DEFAULT nextval('public.employees_employee_id_seq'::regclass) NOT NULL,
    first_name character varying(45) NOT NULL,
    last_name character varying(45) NOT NULL,
    address_id smallint NOT NULL,
    email character varying(50),
    store_id smallint NOT NULL,
    active boolean DEFAULT true NOT NULL,
    username character varying(16) NOT NULL,
    password character varying(40),
    last_update timestamp without time zone DEFAULT now() NOT NULL,
    picture bytea
);


ALTER TABLE public.employees OWNER TO postgres;








CREATE SEQUENCE public.inventory_inventory_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.inventory_inventory_id_seq OWNER TO postgres;


CREATE TABLE public.inventory (
    inventory_id integer DEFAULT nextval('public.inventory_inventory_id_seq'::regclass) NOT NULL,
    film_id smallint NOT NULL,
    store_id smallint NOT NULL,
    last_update timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.inventory OWNER TO postgres;


CREATE SEQUENCE public.languages_language_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.languages_language_id_seq OWNER TO postgres;


CREATE TABLE public.languages (
    language_id integer DEFAULT nextval('public.languages_language_id_seq'::regclass) NOT NULL,
    name character(20) NOT NULL,
    last_update timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.languages OWNER TO postgres;





CREATE SEQUENCE public.payments_payment_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.payments_payment_id_seq OWNER TO postgres;


CREATE TABLE public.payments (
    payment_id integer DEFAULT nextval('public.payments_payment_id_seq'::regclass) NOT NULL,
    customer_id smallint NOT NULL,
    employee_id smallint NOT NULL,
    rental_id integer NOT NULL,
    amount numeric(5,2) NOT NULL,
    payment_date timestamp without time zone NOT NULL
);


ALTER TABLE public.payments OWNER TO postgres;


CREATE SEQUENCE public.rentals_rental_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.rentals_rental_id_seq OWNER TO postgres;


CREATE TABLE public.rentals (
    rental_id integer DEFAULT nextval('public.rentals_rental_id_seq'::regclass) NOT NULL,
    rental_date timestamp without time zone NOT NULL,
    inventory_id integer NOT NULL,
    customer_id smallint NOT NULL,
    return_date timestamp without time zone,
    employee_id smallint NOT NULL,
    last_update timestamp without time zone DEFAULT now() NOT NULL
);

ALTER TABLE public.rentals OWNER TO postgres;

CREATE SEQUENCE public.stores_store_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.stores_store_id_seq OWNER TO postgres;

CREATE TABLE public.stores (
    store_id integer DEFAULT nextval('public.stores_store_id_seq'::regclass) NOT NULL,
    manager_employee_id smallint NOT NULL,
    address_id smallint NOT NULL,
    last_update timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.stores OWNER TO postgres;

ALTER TABLE actors ADD PRIMARY KEY (actor_id);
ALTER TABLE addresses ADD PRIMARY KEY (address_id);
ALTER TABLE categories ADD PRIMARY KEY (category_id);
ALTER TABLE cities ADD PRIMARY KEY (city_id);
ALTER TABLE countries ADD PRIMARY KEY (country_id);
ALTER TABLE customers ADD PRIMARY KEY (customer_id);
ALTER TABLE employees ADD PRIMARY KEY (employee_id);
ALTER TABLE films ADD PRIMARY KEY (film_id);
ALTER TABLE inventory ADD PRIMARY KEY (inventory_id);
ALTER TABLE languages ADD PRIMARY KEY (language_id);
ALTER TABLE payments ADD PRIMARY KEY (payment_id);
ALTER TABLE rentals ADD PRIMARY KEY (rental_id);
ALTER TABLE stores ADD PRIMARY KEY (store_id);
ALTER TABLE films_categories ADD PRIMARY KEY (film_id, category_id);
ALTER TABLE films_actors ADD PRIMARY KEY (actor_id, film_id);

