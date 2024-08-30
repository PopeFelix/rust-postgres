pub mod models;
// pub mod rentals;
pub mod config;
pub mod schema;

use crate::models::*;
use crate::schema::*;
use diesel::pg::PgConnection;
use diesel::prelude::*;
use dotenvy::dotenv;
use std::env;

pub fn establish_connection() -> PgConnection {
    dotenv().ok();

    let database_url = env::var("DATABASE_URL").expect("DATABASE_URL must be set");
    PgConnection::establish(&database_url)
        .unwrap_or_else(|_| panic!("Error connecting to {}", database_url))
}

// pub fn create_rental(conn: &mut PgConnection, rental: NewRental) -> Rental {
//     diesel::insert_into(rentals::table)
//         .values(&rental)
//         .returning(Rental::as_returning())
//         .get_result(conn)
//         .expect("Error saving new rental")
// }

// pub fn get_rental(conn: &mut PgConnection, id: i32) -> () {
//     let rental = rentals.find(id)
//     .select(Rental::as_select)
//     // let result = rental
//     //     .filter(rental_id.eq(id))
//     //     .load::<Rental>(conn)
//     //     .expect("Error retrieving rental");
// }
// pub fn list_rentals(conn: &mut PgConnection)

#[cfg(test)]
mod tests {
    use super::*;
    use diesel::result::Error;
    use std::panic;

    #[test]
    fn test_establish_connection() {
        let result = panic::catch_unwind(|| {
            establish_connection();
        });
        assert!(result.is_ok())
    }
    // #[test]
    // #[test]
    // fn test_create_rental() {
    //     let dt = chrono::offset::Utc::now();
    //     let rental_date = dt.naive_utc();
    //     let inventory_id = 1;
    //     let customer_id = 2;
    //     let return_date = dt.naive_utc();
    //     let staff_id = 3;
    //     let mut conn = establish_connection();
    //     conn.test_transaction::<_, Error, _>(|conn| {
    //         let new_rental = NewRental {
    //             rental_date,
    //             inventory_id,
    //             customer_id,
    //             return_date,
    //             staff_id,
    //         };
    //         let rental = create_rental(conn, new_rental);

    //         assert_eq!(rental.inventory_id, inventory_id);

    //         Ok(())
    //     });
    // }

    // #[test]
    // fn it_works() {
    //     let result = add(2, 2);
    //     assert_eq!(result, 4);
    // }
}
