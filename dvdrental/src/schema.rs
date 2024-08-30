// @generated automatically by Diesel CLI.

pub mod sql_types {
    #[derive(diesel::query_builder::QueryId, diesel::sql_types::SqlType)]
    #[diesel(postgres_type(name = "mpaa_rating"))]
    pub struct MpaaRating;

    #[derive(diesel::query_builder::QueryId, diesel::sql_types::SqlType)]
    #[diesel(postgres_type(name = "tsvector", schema = "pg_catalog"))]
    pub struct Tsvector;
}

diesel::table! {
    actors (actor_id) {
        actor_id -> Int4,
        #[max_length = 45]
        first_name -> Varchar,
        #[max_length = 45]
        last_name -> Varchar,
        last_update -> Timestamp,
    }
}

diesel::table! {
    addresses (address_id) {
        address_id -> Int4,
        #[max_length = 50]
        address1 -> Varchar,
        #[max_length = 50]
        address2 -> Nullable<Varchar>,
        #[max_length = 20]
        district -> Varchar,
        city_id -> Int2,
        #[max_length = 10]
        postal_code -> Nullable<Varchar>,
        #[max_length = 20]
        phone -> Varchar,
        last_update -> Timestamp,
    }
}

diesel::table! {
    categories (category_id) {
        category_id -> Int4,
        #[max_length = 25]
        name -> Varchar,
        last_update -> Timestamp,
    }
}

diesel::table! {
    cities (city_id) {
        city_id -> Int4,
        #[max_length = 50]
        city_name -> Varchar,
        country_id -> Int2,
        last_update -> Timestamp,
    }
}

diesel::table! {
    countries (country_id) {
        country_id -> Int4,
        #[max_length = 50]
        country_name -> Varchar,
        last_update -> Timestamp,
    }
}

diesel::table! {
    customers (customer_id) {
        customer_id -> Int4,
        store_id -> Int2,
        #[max_length = 45]
        first_name -> Varchar,
        #[max_length = 45]
        last_name -> Varchar,
        #[max_length = 50]
        email -> Nullable<Varchar>,
        address_id -> Int2,
        activebool -> Bool,
        create_date -> Date,
        last_update -> Nullable<Timestamp>,
        active -> Nullable<Int4>,
    }
}

diesel::table! {
    employees (employee_id) {
        employee_id -> Int4,
        #[max_length = 45]
        first_name -> Varchar,
        #[max_length = 45]
        last_name -> Varchar,
        address_id -> Int2,
        #[max_length = 50]
        email -> Nullable<Varchar>,
        store_id -> Int2,
        active -> Bool,
        #[max_length = 16]
        username -> Varchar,
        #[max_length = 40]
        password -> Nullable<Varchar>,
        last_update -> Timestamp,
        picture -> Nullable<Bytea>,
    }
}

diesel::table! {
    use diesel::sql_types::*;
    use super::sql_types::MpaaRating;
    use super::sql_types::Tsvector;

    films (film_id) {
        film_id -> Int4,
        #[max_length = 255]
        title -> Varchar,
        description -> Nullable<Text>,
        release_year -> Nullable<Int4>,
        language_id -> Int2,
        rental_duration -> Int2,
        rental_rate -> Numeric,
        length -> Nullable<Int2>,
        replacement_cost -> Numeric,
        rating -> Nullable<MpaaRating>,
        last_update -> Timestamp,
        special_features -> Nullable<Array<Nullable<Text>>>,
        fulltext -> Tsvector,
    }
}

diesel::table! {
    films_actors (actor_id, film_id) {
        actor_id -> Int2,
        film_id -> Int2,
        last_update -> Timestamp,
    }
}

diesel::table! {
    films_categories (film_id, category_id) {
        film_id -> Int2,
        category_id -> Int2,
        last_update -> Timestamp,
    }
}

diesel::table! {
    inventory (inventory_id) {
        inventory_id -> Int4,
        film_id -> Int2,
        store_id -> Int2,
        last_update -> Timestamp,
    }
}

diesel::table! {
    languages (language_id) {
        language_id -> Int4,
        #[max_length = 20]
        name -> Bpchar,
        last_update -> Timestamp,
    }
}

diesel::table! {
    payments (payment_id) {
        payment_id -> Int4,
        customer_id -> Int2,
        employee_id -> Int2,
        rental_id -> Int4,
        amount -> Numeric,
        payment_date -> Timestamp,
    }
}

diesel::table! {
    rentals (rental_id) {
        rental_id -> Int4,
        rental_date -> Timestamp,
        inventory_id -> Int4,
        customer_id -> Int2,
        return_date -> Nullable<Timestamp>,
        employee_id -> Int2,
        last_update -> Timestamp,
    }
}

diesel::table! {
    stores (store_id) {
        store_id -> Int4,
        manager_employee_id -> Int2,
        address_id -> Int2,
        last_update -> Timestamp,
    }
}

diesel::allow_tables_to_appear_in_same_query!(
    actors,
    addresses,
    categories,
    cities,
    countries,
    customers,
    employees,
    films,
    films_actors,
    films_categories,
    inventory,
    languages,
    payments,
    rentals,
    stores,
);
