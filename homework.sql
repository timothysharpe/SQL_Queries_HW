USE sakila;
-- 1 A.)
SELECT first_name, last_name FROM actor;

-- 1 B.)
SELECT CONCAT(UCASE(first_name), " ", UCASE(last_name)) as "Actor"
FROM actor;

-- 2 A.)
SELECT actor_id, first_name, last_name FROM actor
WHERE first_name = "Joe";

-- 2 B.)
SELECT actor_id, first_name, last_name FROM actor
WHERE last_name LIKE '%gen%';

-- 2 C.)
SELECT * FROM actor
WHERE last_name LIKE '%LI%'
ORDER BY last_name, first_name;

-- 2 D.)
SELECT country_id, country FROM country
WHERE country IN ('Afghanistan', 'Bangladesh', 'China');

-- 3 A.)
ALTER TABLE actor
ADD COLUMN description BLOB AFTER last_name;

-- 3 B.)
ALTER TABLE actor
DROP description;

-- 4 A.)
SELECT last_name, COUNT(last_name) AS 'Number of Last Names' 
FROM actor
GROUP BY last_name;

-- 4 B.)
SELECT last_name, COUNT(last_name) AS 'Number of Shared Last Names' 
FROM actor
GROUP BY last_name
HAVING COUNT(last_name) > 1;

-- 4 C.)
UPDATE actor
SET first_name = 'HARPO'
WHERE first_name = 'GROUCHO' AND last_name = 'WILLIAMS';

-- 4 D.)
UPDATE actor
SET first_name =
	CASE
		WHEN first_name = 'HARPO'
			THEN 'GROUCHO'
		ELSE 'MUCHO GROUCHO'
	END
WHERE actor_id = 172;

-- 5 A.)
SHOW COLUMNS FROM sakila.address;
CREATE TABLE sakila.address;

-- 6 A.)
SELECT first_name, last_name, address from staff s
INNER JOIN address a ON s.address_id = a.address_id;

-- 6 B.)
SELECT s.staff_id, first_name, last_name, SUM(amount) as "Total Amount Rung Up"
FROM staff s
INNER JOIN payment p 
ON s.staff_id = p.staff_id
GROUP BY s.staff_id;

-- 6 C.)
Select f.title, COUNT(fa.actor_id) as "Actors Numbered"
FROM film f
LEFT JOIN film_actor fa
ON f.film_id = fa.film_id
GROUP BY f.film_id;

-- 6 D.)
SELECT f.title, COUNT(i.inventory_id) as "Films in Inventory"
FROM film f
INNER JOIN inventory i
ON f.film_id = i.film_id
GROUP BY f.film_id
HAVING title = "Hunchback Impossible";

-- 6 E.)
SELECT c.last_name, c.first_name, SUM(p.amount) as "Amount Paid"
FROM customer c
INNER JOIN payment p
ON c.customer_id = p.customer_id
GROUP BY p.customer_id
ORDER BY last_name, first_name;

-- 7 A.)
SELECT title FROM film
WHERE language_id IN
	(SELECT language_id FROM language
	WHERE name = "English")
AND (title LIKE "K%") OR (title LIKE "Q%");

-- 7 B.)
SELECT first_name, last_name FROM actor
WHERE actor_id IN
	(SELECT actor_id FROM film_actor
	WHERE film_id IN
		(SELECT film_id FROM film
		WHERE title = "Alone Trip"));

-- 7 C.)
SELECT c.first_name, c.last_name, c.email, ct.country FROM customer c
LEFT JOIN address a
ON c.address_id = a.address_id
LEFT JOIN city cy
ON cy.city_id = a.city_id
LEFT JOIN country ct
ON ct.country_id = cy.country_id
WHERE country = "Canada";

-- 7 D.)
SELECT * from film
WHERE film_id IN
	(SELECT film_id FROM film_category
	WHERE category_id IN
		(SELECT category_id FROM category
		WHERE name = "Family"));
        
-- 7 E.)
SELECT f.title , COUNT(r.rental_id) AS "Film Rentals" FROM film f
RIGHT JOIN inventory i
ON f.film_id = i.film_id
JOIN rental r 
ON r.inventory_id = i.inventory_id
GROUP BY f.title
ORDER BY COUNT(r.rental_id) DESC;

-- 7 F.)
SELECT s.store_id, sum(amount) as "Revenue" FROM store s
RIGHT JOIN staff stf
ON s.store_id = stf.store_id
LEFT JOIN payment p
ON stf.staff_id = p.staff_id
GROUP BY s.store_id;

-- 7 G.)
SELECT s.store_id, cy.city, ct.country FROM store s
JOIN address a
ON s.address_id = a.address_id
JOIN city cy
ON a.city_id = cy.city_id
JOIN country ct
ON cy.country_id = ct.country_id;

-- 7 H.)
-- Skipped, couldn't figure out, will review when solution is posted.

-- 8 A./B.)
-- Skipped like 7H, unable will review.
-- 8 C)
ALTER TABLE top_five_genres
DROP VIEW top_five_genres;



