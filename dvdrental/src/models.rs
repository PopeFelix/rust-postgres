// Generated by diesel_ext

#![allow(unused)]
#![allow(clippy::all)]

use chrono::NaiveDate;
use chrono::NaiveDateTime;
use diesel::prelude::*;

#[derive(Debug, diesel_derive_enum::DbEnum)]
#[ExistingTypePath = "crate::schema::sql_types::MpaaRating"]
pub enum MpaaRating {
    G,
    PG,
    PG13,
    R,
    NC17,
}

// #[derive(Insertable)]
// #[diesel(table_name = crate::schema::rentals)]
// pub struct NewRental {
//     pub rental_date: NaiveDateTime,
//     pub inventory_id: i32,
//     pub customer_id: i32,
//     pub return_date: NaiveDateTime,
//     pub employee_id: i32,
// }

#[derive(Queryable, Debug, Identifiable)]
#[diesel(table_name=crate::schema::actors)]
#[diesel(primary_key(actor_id))]
#[diesel(check_for_backend(diesel::pg::Pg))]
pub struct Actor {
    pub actor_id: i32,
    pub first_name: String,
    pub last_name: String,
    pub last_update: NaiveDateTime,
}

#[derive(Queryable, Debug, Identifiable)]
#[diesel(table_name=crate::schema::addresses)]
#[diesel(primary_key(address_id))]
#[diesel(check_for_backend(diesel::pg::Pg))]
pub struct Address {
    pub address_id: i32,
    pub address1: String,
    pub address2: Option<String>,
    pub district: String,
    pub city_id: i16,
    pub postal_code: Option<String>,
    pub phone: String,
    pub last_update: NaiveDateTime,
}

#[derive(Queryable, Debug, Identifiable)]
#[diesel(table_name=crate::schema::categories)]
#[diesel(primary_key(category_id))]
#[diesel(check_for_backend(diesel::pg::Pg))]
pub struct Category {
    pub category_id: i32,
    pub name: String,
    pub last_update: NaiveDateTime,
}

#[derive(Queryable, Debug, Identifiable)]
#[diesel(table_name=crate::schema::cities)]
#[diesel(primary_key(city_id))]
#[diesel(check_for_backend(diesel::pg::Pg))]
pub struct City {
    pub city_id: i32,
    pub city_name: String,
    pub country_id: i16,
    pub last_update: NaiveDateTime,
}

#[derive(Queryable, Debug, Identifiable)]
#[diesel(table_name=crate::schema::countries)]
#[diesel(primary_key(country_id))]
#[diesel(check_for_backend(diesel::pg::Pg))]
pub struct Country {
    pub country_id: i32,
    pub country_name: String,
    pub last_update: NaiveDateTime,
}

#[derive(Queryable, Debug, Identifiable)]
#[diesel(table_name=crate::schema::customers)]
#[diesel(primary_key(customer_id))]
#[diesel(check_for_backend(diesel::pg::Pg))]
pub struct Customer {
    pub customer_id: i32,
    pub store_id: i16,
    pub first_name: String,
    pub last_name: String,
    pub email: Option<String>,
    pub address_id: i16,
    pub activebool: bool,
    pub create_date: NaiveDate,
    pub last_update: Option<NaiveDateTime>,
    pub active: Option<i32>,
}

#[derive(Queryable, Debug, Identifiable)]
#[diesel(table_name=crate::schema::employees)]
#[diesel(primary_key(employee_id))]
#[diesel(check_for_backend(diesel::pg::Pg))]
pub struct Employee {
    pub employee_id: i32,
    pub first_name: String,
    pub last_name: String,
    pub address_id: i16,
    pub email: Option<String>,
    pub store_id: i16,
    pub active: bool,
    pub username: String,
    pub password: Option<String>,
    pub last_update: NaiveDateTime,
    pub picture: Option<Vec<u8>>,
}

#[derive(Queryable, Debug, Identifiable)]
#[diesel(table_name=crate::schema::films)]
#[diesel(primary_key(film_id))]
#[diesel(check_for_backend(diesel::pg::Pg))]
pub struct Film {
    pub film_id: i32,
    pub title: String,
    pub description: Option<String>,
    pub release_year: Option<i32>,
    pub language_id: i16,
    pub rental_duration: i16,
    pub rental_rate: f32,
    pub length: Option<i16>,
    pub replacement_cost: f32,
    pub rating: Option<MpaaRating>,
    pub last_update: NaiveDateTime,
    pub special_features: Option<Vec<Option<String>>>,
    // pub fulltext: Vec<String>, /* FIXME: This is a Tsvector */
}

#[derive(Queryable, Debug, Identifiable)]
#[diesel(table_name=crate::schema::films_actors)]
#[diesel(primary_key(actor_id, film_id))]
#[diesel(check_for_backend(diesel::pg::Pg))]
pub struct FilmsActor {
    pub actor_id: i16,
    pub film_id: i16,
    pub last_update: NaiveDateTime,
}

#[derive(Queryable, Debug, Identifiable)]
#[diesel(table_name=crate::schema::films_categories)]
#[diesel(primary_key(film_id, category_id))]
#[diesel(check_for_backend(diesel::pg::Pg))]
pub struct FilmsCategory {
    pub film_id: i16,
    pub category_id: i16,
    pub last_update: NaiveDateTime,
}

#[derive(Queryable, Debug, Identifiable)]
#[diesel(table_name=crate::schema::inventory)]
#[diesel(primary_key(inventory_id))]
#[diesel(check_for_backend(diesel::pg::Pg))]
pub struct Inventory {
    pub inventory_id: i32,
    pub film_id: i16,
    pub store_id: i16,
    pub last_update: NaiveDateTime,
}

#[derive(Queryable, Debug, Identifiable)]
#[diesel(table_name=crate::schema::languages)]
#[diesel(primary_key(language_id))]
#[diesel(check_for_backend(diesel::pg::Pg))]
pub struct Language {
    pub language_id: i32,
    pub name: String,
    pub last_update: NaiveDateTime,
}

#[derive(Queryable, Debug, Identifiable)]
#[diesel(table_name=crate::schema::payments)]
#[diesel(primary_key(payment_id))]
#[diesel(check_for_backend(diesel::pg::Pg))]
pub struct Payment {
    pub payment_id: i32,
    pub customer_id: i16,
    pub employee_id: i16,
    pub rental_id: i32,
    pub amount: f32,
    pub payment_date: NaiveDateTime,
}

#[derive(Queryable, Debug, Identifiable, Selectable)]
#[diesel(table_name=crate::schema::rentals)]
#[diesel(primary_key(rental_id))]
#[diesel(check_for_backend(diesel::pg::Pg))]
pub struct Rental {
    pub rental_id: i32,
    pub rental_date: NaiveDateTime,
    pub inventory_id: i32,
    pub customer_id: i16,
    pub return_date: Option<NaiveDateTime>,
    pub employee_id: i16,
    pub last_update: NaiveDateTime,
}

#[derive(Queryable, Debug, Identifiable)]
#[diesel(table_name=crate::schema::stores)]
#[diesel(primary_key(store_id))]
#[diesel(check_for_backend(diesel::pg::Pg))]
pub struct Store {
    pub store_id: i32,
    pub manager_employee_id: i16,
    pub address_id: i16,
    pub last_update: NaiveDateTime,
}
