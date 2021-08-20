-- Lab SQL 2.9
USE sakila;
-- #1 How many distinct (different) actors' last names are there?
SELECT count(distinct last_name) as 'distinct_last_names' 
FROM actor;
-- There are 121 distinct last names.

-- #2 Add an additional column day_type with values 'weekend' and 'workday'
-- depending on the rental day of the week.
SELECT *,
case
WHEN (date_format(rental_date, '%a')) in ('Sat', 'Sun') then 'weekend'
else 'workday'
END AS 'day_type'
FROM rental;

-- 3 Get all films with ARMAGEDDON in the title.
SELECT * 
FROM film
where title like '%armageddon%';

-- 4 Get 10 the longest films.
SELECT title, length
FROM film
order by length desc
LIMIT 10;

-- 5 How many films include Behind the Scenes content?
SELECT count(special_features) as 'Films with Behind the Scenes content'
FROM film
WHERE special_features LIKE '%Behind the Scenes%';
-- 538 films include Behind the Scenes content.

-- 6 Which kind of movies (rating) have a mean duration of more than two hours?
SELECT c.name, round(avg(length),2) as 'mean_duration' 
FROM category c 
JOIN film_category fc USING(category_id)
JOIN film f USING(film_id)
GROUP BY c.name
HAVING mean_duration > 120;
-- Drama, Foreign, Games, and Sports have a mean duration of more than two hours.

-- 7 Rank films by length (filter out the rows that have nulls or 0s in length column). 
-- In your output, only select the columns title, length, and the rank.
SELECT title, length, rank() over (order by length desc) as 'rank'
FROM film 
WHERE length >0 and length is not NULL
ORDER BY length desc;


