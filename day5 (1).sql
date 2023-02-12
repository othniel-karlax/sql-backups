-- Group BY 
SELECT column1, Aggregate_function(column2) from tablename Group BY column1;
Agggregate functions are SUM,MIN,MAX,COUNT.
Gropu BY Eliminates Duplicate Values;

SELECT * from movies;
SELECT movie_lang,COUNT(movie_lang) from movies GROUP BY movie_lang;
SELECT movie_lang,AVG(movie_length) from movies GROUP By movie_lang ORDER BY movie_lang;
SELECT age_certificate,SUM(movie_length) from movies GROUP BY age_certificate;
SELECT movie_lang,MIN(movie_length),MAX(movie_length) FROM movies GROUP BY movie_lang;
SELECT movie_length from movies GROUP BY movie_length;
SELECT movie_length from movies ORDER BY movie_length;

-- Using group BY with Multiple Columns,Order BY
SELECT movie_lang,age_certificate,AVG(movie_length) as "AVG movie length" from movies GROUP BY movie_lang,age_certificate ORDER BY movie_lang,3 DESC;
SELECT movie_lang,age_certificate,AVG(movie_length) from movies GROUP BY movie_lang,age_certificate GROUP BY movie_lang;

SELECT movie_lang,age_certificate,AVG(movie_length) as "AVG movie Length" from movies where movie_length>100 GROUP BY movie_lang,age_certificate,movie_length ORDER BY movie_length;

SELECT age_certificate,AVG(movie_length) from movies where age_certificate='10' GROUP BY age_certificate;
SELECT nationality,COUNT(*) as "Total_directors" from directors GROUP BY nationality ORDER By 2 DESC;
SELECT movie_lang,age_certificate,SUM(movie_length) from movies GROUP BY movie_lang,age_certificate ORDER BY 3 DESC;

-- Order of Execution in GROUP BY
FROM 
 WHERE - Conditions 
  GROUP BY - group sets
   HAVING - filter again
    SELECT - columns
    DISTINCT - unique columns if you use DISTINCT
    ORDER BY 
    LIMIT -Filter records

-- Using Having
SELECT movie_lang,SUM(movie_length) from movies GROUP BY movie_lang HAVING SUM(movie_length)>200 ORDER BY SUM(movie_length);
SELECT director_id,SUM(movie_length) from movies GROUP BY director_id HAVING SUM(movie_length)>200 ORDER BY director_id;

-- Order of Execution of Having Clause
FROM
WHERE 
GROUP BY
HAVING
SELECT
DISTINCT
ORDER BY
LIMIT

-- Handling Null values with group BY
create table employee_test(
    employee_id SERIAL PRIMARY KEY,
    employee_name VARCHAR(100),
    department VARCHAR(100),
    salary INT
);

select * from employee_test;
INSERT  INTO employee_test(employee_name,department,salary)VALUES 
('john','finance',2500),
('mary',NULL,3000),
('adam',NULL,3000),
('bruce','finance',4000),
('Linda','IT',5000),
('Megan','IT',4000);

SELECT * from employee_test;
SELECT employee_name,department,salary from employee_test ORDER BY department
SELECT department,COUNT(salary) AS total_employee from employee_test GROUP BY department
SELECT COALSEC(department,'No Department'),COUNT(salary) AS total_employee from employee_test GROUP BY department





















