-- Inner Joins
SELECT table1.column,table2.column from table1 INNER JOIN table2 ON table1.column1=table2.column1;
SELECT * from movies INNER JOIN directors ON movies.dicrector_id=directors.dicrector_id;

SELECT mv.movie_id,mv.movie_name,mv.director_id,d.first_name from movies mv INNER JOIN directors d ON mv.dicrector_id=d.dicrector_id;

SELECT mv.movie_id,mv.movie_name,mv.director_id,d.first_name from movies mv INNER JOIN directors d ON mv.director_id=d.director_id where mv.movie_lang='English' AND d.director_id=3

SELECT mv.*,d.* from movies mv INNER JOIN directors d ON mv.director_id=d.director_id where mv.movie_lang='English' AND d.director_id=3

-- Using in Inner Join
SELECT * from movies INNER JOIN directors USING(director_id)
SELECT * from movies INNER JOIN movies_ USING (movie_id)

-- Can we connect three tables 
SELECT * from movies INNER JOIN directors USING(director_id) INNER JOIN movies_revenues USING(movie_id)

-- Inner Join with filter Data
SELECT mv.movie_name,d.first_name,d.last_name,r.revenues_domestic from movies mv INNER JOIN directors d ON mv.director_id=d.director_id INNER JOIN movies_revenues r ON mv.movie_id=r.movie_id WHERE mv.movie_lang='Japanese'
SELECT mv.movie_name,d.first_name,d.last_name,r.revenues_domestic from movies mv INNER JOIN directors d ON mv.director_id=d.director_id WHERE mv.movie_lang IN('Engllish','Japanese','Chinese') AND r.revenues_domestic>200 ORDER BY 4 directors
SELECT mv.movie_name,d.first_name,d.last_name,r.revenues_domestic,r.revenues_international,(r.revenues_domestic+r.revenues_international) as "Total Revenue" from movies mv INNER JOIN directors d ON mv.director_id=d.director_id INNER JOIn movies_revenues r On mv.movie_id =r.movie_id ORDER BY 6 DESC NULLS LAST
SELECT mv.movie_name,mv.movie_lang,mv.release_date,d.first_name,d.last_name,r.revenues_domestic,r.revenues_international,(r.revenues_domestic+r.revenues_international) as "Total Revenue" from movies mv INNER JOIN directors d ON mv.directors_id=d.director_id INNER JOIN movies_revenues r ON mv.movie_id=r.movie_id WHERE mv.release_date BETWEEN '2005-01-01'AND '2008-12-31'ORDER BY 7 DESC NULLS LAST

-- Inner Join with different data type columns
Using CAST

-- Left Join

SELECT table1.column1,table2.column1 from table1 LEFT JOIN table2 table1.column1=table2.column1;
create table left_products (product_id SERIAL PRIMARY KEY,product_name VARCHAR(100))
create table right_products(product_id SERIAL PRIMARY KEY),product_name VARCHAR(100))
INSERT INTO left_products(prodcut_id,product_name)VALUES(1,'computer'),(2,'Laptops'),(3,'Monitors'),(5,'Mics')
SELECT * from left_products;
INSERT INTO right_products(prodcut_id,product_name)VALUES(1,'computer'),(2,'Laptops'),(3,'Monitors'),(4,'Pen'),(7,'Papers');
SELECT * from left_products
SELECT * from right_products
SELECT * from left_products LEFT JOIN right_products ON left_products.product_id=right_products.product_id;
SELECT d.first_name,d.last_name,mv.movie_name from directors d LEFT JOIN movies mv ON mv.director_id=d.director_id;
SELECT * from directors;
SELECT d.first_name,d.last_name,mv.movie_name from movies mv LEFT JOIN directors d ON d.director_id=mv.director_id;
SELECT d.first_name,d.last_name,mv.movie_name from movies mv LEFT JOIN directors d ON d.director_id=mv.director_id where mv.movie_lang IN('English','Chinese')
SELECT d.first_name,d.last_name,COUNT(*) AS "Total Movies" from directors d LEFT JOIN movies mv ON mv.director_id=d.director_id GROUP BY d.first_name,d.last_name ORDER BY COUNT(*) DESC;
SELECT * from directors d LEFT JOIN movies mv ON d.director_id=mv.director_id where d.nationality IN ('American','Chinese','Japanese');
SELECT * from directors;
SELECT d.first_name,d.last_name,SUM(r.revenues_domestic+r.revenues_international) as "Total Revenues" from directors d LEFT JOIN movies mv ON mv.director_id=d.director_id
LEFT JOIN movies_revenues r ON r.movie_id=v.movie_id GROUP BY d.first_name,d.last_name HAVING SUM(r.revenues_domestic+r.revenues_international)>0 ORDER BY 3 DESC NULLS LAST;

---Right Join
SELECT * from left_products RIGHT JOIN right_products ON left_products.product_id=right_products.product_id;
SELECT d.first_name,d.last_name,mv.movie_name FROM directors d RIGHT JOIN movies mv ON mv.director_id=d.director_id;
(Repeat From Left Join)

-- Full Join
SELECT * from left_products FULL JOIN right_products ON left_products.product_id=right_product.product_id

-- Joining Multiple Tables

SELECT * from movies mv JOIN directors d ON d.director_id=mv.director_id JOIN movies_revenues r ON r.movie_id=mv.movie_id;
SELECT * FROM actors ac
JOIN movie_actors ma ON ma.actor_id=ac.actor_id
JOIN movies mv ON mv.movie_id=ma.movie_id
JOIN directors d ON d.director_id=mv.director_id
JOIN movies_revenues r ON r.movie_id =mv.movie_id;

-- Self Join
SELECT * from left_products t1 INNER JOIN left_products t2 On t1.product_id=t2.product_id;
SELECT * from directors t1 INNER JOIN directors t2 ON t1.director_id=t2.director_id;
SELECT t1.movie_name,t2.movie_name,t1.movie_length from movies t1 INNER JOIN movies t2 ON t1.movie_length=t2.movie_length
AND t1.movie_name <> t2.movie_name ORDER BY t1.movie_length DESC,t1.movie_name
SELECT * from movies ORDER BY director_id;
SELECT t1.movie_name,t2.director_id from movies t1 INNER JOIN movies t2 ON t1.director_id=t2.movie_id ORDER BY t2.director_id,t1.movie_name

-- Cross Join(Cartesian Product)
SELECT * from left_products CROSS JOIN right_products;
-- Lets cross join left_products,right_products
SELECT * from left_products,right_products;
SELECT * from right_products INNER JOIN left_products ON true
SELECT * from actors CROSS JOIN directors ;
-- Natural Join
-- Postgresql will take inner join as default
-- Implicit join based on same column name 
SELECT * from left_products NATURAL LEFT JOIN right_products;
SELECT * from movies NATURAL RIGHT JOIN directors;

-- Append tables with different column

Customer
+----+----------+-----+-----------+----------+
| ID | NAME     | AGE | ADDRESS   | SALARY   |
+----+----------+-----+-----------+----------+
|  1 | Ramesh   |  32 | Ahmedabad |  2000.00 |
|  2 | Khilan   |  25 | Delhi     |  1500.00 |
|  3 | kaushik  |  23 | Kota      |  2000.00 |
|  4 | Chaitali |  25 | Mumbai    |  6500.00 |
|  5 | Hardik   |  27 | Bhopal    |  8500.00 |
|  6 | Komal    |  22 | MP        |  4500.00 |
|  7 | Muffy    |  24 | Indore    | 10000.00 |
+----+----------+-----+-----------+----------+
Order
+-----+---------------------+-------------+--------+
| OID | DATE                | CUSTOMER_ID | AMOUNT |
+-----+---------------------+-------------+--------+
| 102 | 2009-10-08 00:00:00 |           3 |   3000 |
| 100 | 2009-10-08 00:00:00 |           3 |   1500 |
| 101 | 2009-11-20 00:00:00 |           2 |   1560 |
| 103 | 2008-05-20 00:00:00 |           4 |   2060 |
+-----+---------------------+-------------+--------+
SQL> SELECT  ID, NAME, AMOUNT, DATE
   FROM CUSTOMERS
   INNER JOIN ORDERS
   ON CUSTOMERS.ID = ORDERS.CUSTOMER_ID;

   +----+----------+--------+---------------------+
| ID | NAME     | AMOUNT | DATE                |
+----+----------+--------+---------------------+
|  3 | kaushik  |   3000 | 2009-10-08 00:00:00 |
|  3 | kaushik  |   1500 | 2009-10-08 00:00:00 |
|  2 | Khilan   |   1560 | 2009-11-20 00:00:00 |
|  4 | Chaitali |   2060 | 2008-05-20 00:00:00 |
+----+----------+--------+---------------------+



















