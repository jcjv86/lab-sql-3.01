-- Lab | SQL - Lab 3.01


use sakila;

-- ACTIVITY 1 --

/* 1. Drop column picture from staff.
*/
ALTER TABLE staff
DROP picture;

/* 2. A new person is hired to help Jon. Her name is TAMMY SANDERS, and she is a customer. Update the database accordingly.
*/
SELECT * FROM staff
WHERE first_name LIKE 'Jon';
-- Jon Stephens, @ store_id 2
-- I will need staff_id=3, first_name= Tammy, last_name= Sanders, address_id=79, email=Tammy.Sanders@sakilastaff.com, store_id=2, active = 1, username= Tammy, password=null, last_update=today
-- I will have to drop Tammy's info from customer table too

SELECT * FROM customer
WHERE first_name LIKE 'tammy' AND last_name='Sanders';
-- customer ID 75

INSERT INTO staff(staff_id, first_name, last_name, address_id, email, store_id, active, username, password, last_update)
VALUES
(3,'Tammy','Sanders', 79, 'Tammy.Sanders@sakilastaff.com', 2, 1, 'Tammy', null, '2023-01-23 14:08:00');
SELECT * FROM staff;

/* -- If we would like to remove Tammy's info from customer table just remove the power comment.
DELETE FROM customer
WHERE customer_id=75; -- customer_id is a unique key so best option to use the delete from with.*/


/* 3. Add rental for movie "Academy Dinosaur" by Charlotte Hunter from Mike Hillyer at Store 1. 
You can use current date for the rental_date column in the rental table. 
Hint: Check the columns in the table rental and see what information you would need to add there. 
You can query those pieces of information. For eg., you would notice that you need customer_id information as well. 
To get that you can use the following query: 
select customer_id from sakila.customer
where first_name = 'CHARLOTTE' and last_name = 'HUNTER';
*/
SELECT customer_id FROM customer
WHERE first_name = 'CHARLOTTE' AND last_name = 'HUNTER'; -- Customer ID: 130

SELECT first_name, last_name, staff_id, store_id from staff
where store_id = 1; -- Mike has staff_id: 1

SELECT * FROM rental; -- checking columns for which I need info to add the rental and the last number for the rental_id, which is 16049, so I need to use 16050.

-- rental_id 16050, rental_date=today (in datetime format), inventory_id(1,2,3 or 4), customer_id=130, return_date=null, staff_id=1, last_update=not required (see below)

SELECT title, film_id from film
WHERE title='Academy Dinosaur'; -- finding out which film ID corresponds to the film title (film_id=1)

SELECT film_id, inventory_id, store_id from inventory
WHERE film_id = 1 and store_id = 1; -- finding out which inventory_ids match with film_id=1 (inventoryid=1,2,3,4)

SELECT inventory_id, rental_date, return_date from rental
WHERE inventory_id BETWEEN 1 and 4; -- all the items have a return date therefore all are available. I will just assign number one.

/* last update options are DEFAULT CURRENT TIMESTAMP ON UPDATE CURRENT_TIMESTAMP according to the table diagram, which means that it will 
add by default the current timestamp to the insertion, so no need to specify it. However, rental_id is not so we need to specify the number.
Since the movie was just renter return_date will be null.*/

INSERT INTO rental(rental_id, rental_date, inventory_id, customer_id, return_date, staff_id)
VALUES
(16050, '2023-01-23 17:05:00', 1, 130, null, 1);

SELECT * from rental
where rental_id = 16050;
-- done successfully. --
