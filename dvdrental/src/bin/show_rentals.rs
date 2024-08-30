use self::models::Rental;
use diesel::prelude::*;
use dvdrental::*;
//use tracing::debug;

fn main() {
    use self::schema::rentals::dsl::*;
    let conn = &mut establish_connection();

    let results = rentals
        .filter(return_date.is_null())
        .limit(5)
        .select(Rental::as_select())
        .load(conn)
        .expect("Error loading rentals");
    println!("Displaying {} results", results.len());
    // println!("Here");
    // dbg!(&results);
    // println!("There");
    for rental in results {
        println!("ID {}", rental.rental_id);
        println!("Rental Date {}", rental.rental_date);
        println!("Inventory ID {}", rental.inventory_id);
        println!("Customer ID {}", rental.customer_id);
        if let Some(rd) = rental.return_date {
            println!("Return Date {}", rd);
        } else {
            println!("RENTAL OUTSTANDING");
        }
        // let return_date = match rental.return_date {
        //     Some(_) => todo!("Return date"),
        //     // Some(return_date) => println!("Return Date {}", return_date),
        //     // None => println("RENTAL OUTSTANDING"),
        // }
        println!("Employee ID {}", rental.employee_id);
        println!("Last Updated {}", rental.last_update);
        println!("-----\n")
    }
}
