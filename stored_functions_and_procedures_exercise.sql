-- QUESTION 1
	--Create a Stored Procedure that will insert a new film into the film table with the
	--following arguments: title, description, release_year, language_id, rental_duration,
	--rental_rate, length, replace_cost, rating
SELECT *
FROM film f ;


CREATE OR REPLACE PROCEDURE add_film(title VARCHAR, description TEXT, release_year YEAR, language_id INTEGER, rental_duration INTEGER, rental_rate NUMERIC(4,2), length INTEGER, replacement_cost NUMERIC(5,2), rating VARCHAR )
LANGUAGE plpgsql
AS $$
BEGIN 
	INSERT INTO film(title, description, release_year, language_id, rental_duration, rental_rate, length, replacement_cost, rating)
	VALUES(title, description, release_year, language_id, rental_duration, rental_rate, length, replacement_cost, rating::mpaa_rating);
END;
$$;

CALL add_film('Avatar','Set more than a decade after the events of the first film', 2022, 1, 7, 5.99, 190, 31.99, 'PG-13');

SELECT *
FROM film
WHERE title = 'Avatar';

-- QUESTION 2
--Create a Stored Function that will take in a category_id and return the number of
 --films in that category

select c.category_id, name, count(*) as num_movies_in_cat
	from category c
	join film_category fc 
	on c.category_id = fc.category_id
	group by c.category_id 
	order by count(*) desc;	

CREATE OR REPLACE FUNCTION get_category_count (category_name VARCHAR)
RETURNS integer
LANGUAGE plpgsql
AS $$
	DECLARE category_count integer;
BEGIN 
	SELECT count(*) INTO category_count
	from category c
	join film_category fc 
	on c.category_id = fc.category_id
	WHERE name = category_name;
	RETURN category_count;
END;
$$;

SELECT get_category_count('Sports'); --74









