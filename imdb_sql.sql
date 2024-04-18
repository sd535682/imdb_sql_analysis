---------------------------------------- CineInsight: Analyzing IMDbs Movie_Database Through _SQL ---------------------------------------------------
--------------------------------------------------- Project _by_ Subhadeep Das ----------------------------------------------------------------------

-- create_schema
create schema imdb;

-- use schema table
use imdb;

-- create table director
create table director(name varchar(100) not null, id int not null, gender varchar(10) not null, 
uid int not null, department varchar(100) not null, primary key(uid));

-- show table director
select * from director;

-- change 0 1 2 to respective gender
UPDATE director
SET gender = CASE
    WHEN gender = 0 THEN 'other'
    WHEN gender = 1 THEN 'female'
    WHEN gender = 2 THEN 'male'
END;

-- create table movies
create table movies(id int not null, title varchar(100) not null, budget bigint not null, popularity int not null, 
release_date date not null, revenue bigint, vote_count int not null, 
uid int not null, director_id int not null,
primary key(id));

-- show table movies
select * from movies;

--------------------------------------------------------------- BASIC ANALYSIS ----------------------------------------------------------------------

-- Q1. Find these 3 directors : James Cameron, Luc Besson, John Woo
select * from director where name in('James Cameron', 'Luc Besson', 'John Woo');

-- Q2. Count the female directors
select count(*) from director where gender = 'female';

-- Q3. What are the 3 most popular movies
select * from movies order by popularity desc limit 3;

-- Q4. What are 3 most bankable movies
select * from movies order by budget desc limit 3;

-- Q5. Which is the most profitable movie since Jan 1st, 2010
select * from movies where release_date > '2010-01-01' order by revenue desc limit 1;

------------------------------------------------------------------ JOINS ---------------------------------------------------------------------------

-- Q6. Which movie(s) were directed by Brenda Chapman
select title from movies join director on movies.director_id = director.id where director.name = 'Brenda Chapman';

-- Q7. Give the title, release date, budget, revenue, populartity movies made by Steven Spielberg
select title, release_date, budget, revenue, popularity from movies join director on movies.director_id = director.id
where director.name = 'Steven Spielberg';

------------------------------------------------------------- Revenue Analysis ---------------------------------------------------------------------
-- Q8. Find the top 10 highest revenue making movies
select title from movies order by revenue limit 10;

-- Q9. Find the average budget and revenue for movies directed by female directors.
select name, avg(budget), avg(revenue) from movies join director where director.gender = 'female' group by director.name;

-- Q10. Calculate the month with the highest average revenue across all years
select month(release_date), avg(revenue) from movies group by month(release_date) order by avg(revenue) desc limit 1;