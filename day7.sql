
-- Combining Queries Together
-- Combining result set with Union
-- combines result set from one or more select statements into single resul set;
SELECT column1,column2 from table1 UNION SELECT column1,column2 from table2
SELECT product_id,product_name from left_products UNION SELECT product_id,product_name from right_products;
INSERT into right_products(product_id,product_name)VALUES (10,'Pen')
SELECT product_id,product_name from left_products UNION ALL SELECT product_id,product_name from right_products;
SELECT first_name,last_name from directors UNION SELECT first_name,last_name from actors ORDER BY first_name ASC;
SELECT first_name,last_name ,'directors'As "table name " from directors UNION SELECT first_name,last_name,"actors"as "table name" from actors ORDER BY first_name ASC;
-- Union with flters and conditions
SELECT first_name,last_name,'directors' as "table name " from directors WHERE nationality in('American','Japanese','Chinese') UNION 
SELECT first_name,last_name,'actors' as"table name" from actors ORDER BY first name ;

SELECT 
first_name,
last_name,
date_of_birth,
"directors" as "tablename"
from directors WHERE first_name like '%A'
UNION
SELECT 
first_name,
last_name,
date_of_birth,
'actors' as "table name" from actors WHERE date_of_birth >'1970-12-31'ORDER BY date_of_birth ASC

-- Union with different number of columns

create table1(
    col1 INT,
    col2 INT
);

create table2(
    col3 INT   
);

SELECT col1,col2 from table1 UNION SELECT NULL as col1,col3 from table2;

-- Intersect With Tables
SELECT column1,column2 from table1 INTERSECT SELECT column1,column2 from table2;
SELECT product_id,product_name from left_products INTERSECT SELECT product_id,product_name from right_products;
SELECT first_name,last_name from directors INTERSECT SELECT first_name,last_name from actors;

-- EXcept with tables 

-- The Except operator to return the first query that do not appear in the output of the second query
-- To be able to use Except:
-- The order and number of columns in the select list of all queries must be same.
-- The data types must be compatible too
SELECT column1,column2 from table1 Except SELECT column1,column2 from table2;
SELECT product_id,product_name from left_products EXCEPT SELECT product_id,product_name from right_products;
SELECT first_name,last_name from directors EXCEPT SELECT first_name,last_name from actors;
SELECT first_name,last_name from directors EXCEPT SELECT first_name,last_name from actors WHERE gender="F"


-- All About Views
You can save your query into a view,so instead of writing long queries you can refer view.
A view is a database object that is stored query that will speedup your workflow.
Query a view,join a view to regular tabeles(or other views),use the view to insert or update data into the tables.
regular view doesnt store any data except the materialized view.
Views are useful because they allow you to 
1)Avoid duplicate efforts by writing query once and access the result when needed.
2)Provide security by limiting access to only certain columns in a table.
3)Like a table you can grant a permission to users through a view that specific data or columns that the users are authorized to see.

Creating a View
CREATE or REPLACE VIEW view_name as query 
-- query can be 
-- 1)SELECT with subquery
-- 2)SELECT with joins 
-- 3)pretty much that you can run via SELECT can be turned into a view .

-- create or replace view v_movies_quick As
SELECT movie_name,movie_length,release_date from movies mv;
 CREATE or replace view v_movies_directors_all AS 
 SELECT 
 * from movies mv INNER JOIN directors d ON d.director_id=mv.director_id;
 SELECT * from v_movies_quick;
 SELECT * from v_movies_director_all;

--  Rename a View 
Alter view v_movie RENAME To v_movie2;

-- Delete a view

drop view v_movie_quick;
-- Using filters with view
CREATE or REPLACE VIEW v_movies_after_1997 AS
SELECT * from movies where release_date>='1996-12-31'ORDER BY release_date DESC;
SELECT * from v_movies_after_1997 WHERE movie_lang='English' AND age_certifiacte='12' ORDER BY movie_lang;
SELECT * from v_movies_directors_all WHERE nationality in ('American','Japanese');

-- A view with union of multiple tables 
create view v_movies_directors_all AS SELECT first_name,last_name ,'actors' as people_type from actors UNION ALL SELECT first_name,last_name,
'directors' as people_type from directors ;
SELECT * from v_movies_directors_all WHERE first_name LIKE 'J%' ORDER BY people_type,first_name;

-- Connecting Multiple table with a single view 

create or replace view v_multiple_table AS
SELECT * from movies mv INNER JOIN directors d ON d.director_id=mv.director_id INNER JOIN movies_revenues r on r.movie_id =mv.movie_id;
SELECT * from v_multiple_table WHERE age_certificate='12'

-- Rearrange a column in a view
create view v_directors AS SELECT first_name,last_name from directors;

-- Add a column in a view 
You can add a new column in a view by replace command .
-- Regular views are dynamic 
-- A regular view does not store data permanantly 
-- does not store data physically 
-- always give updated data 

SELECT * from v_directors;
INSERT into direcors (first_name)VALUES ('test name1');
DELETE from directors where director_id=9;
SELECT * from directors;

-- What is an Updatable View
An updatable view allows you to update the data on the underlying data.However there are some rules to follow.
1.The query must have one from entry which can either from a table or another updatable view 
2.The query cannot contains the following at top level 
DISTINCt,group by,with,limit,offset,union,intersect,except,having
You cannot use the following in the selection list
SUM,COUNT,AVG,MIN,MAX
You can use the following operation to update the data 
INSERT UPDATE DELETE  along with a say where clause
When you perform an update opeartion,users must have privileges on the view.But you dont have privilege on the underlying table.

-- An Updatable view with CRUD Operation
CREATE or REPLACE VIEW vu_directors AS 
SELECT first_name,last_name from directors 
INSERT into vu_directors(first_name)VALUES('dir1')('dir2');
SELECT * from vu_directors;
SELECT* from directors;
DELETE from vu_directors WHERE first_name='dir1'

-- Updatable view with Check Options
create table countries(
    country_id SERIAL PRIMARY KEY,
    country_code VARCHAR(4),
    city_name VARCHAR(5)
);

INSERT INTO countries(country_code,city_name)VALUES ('US','New York'),('US','NEW Jersy'),('UK','London');
SELECT * from countries;
CREATE or REPLACE view v_cities_us AS
SELECT country_id,country_code,city_name from countries where country_code='US';
SELECT * from v_cities_us;
INSERT into v_cities_us(country_code,city_name)VALUES('US','California')
INSERT into v_cities_us(country_code,city_name)VALUES('UK','California')



Its actually pretty simple.

The view in mysql are created using some select statement.

example: consider following table empl.

empno   ename       deptno
1       Ross        University
2       Rachel      Sales
3       Monika      Chef
4       Chandler    Managment
5       Joe         Actor
6       Pheobe      Singer
we can create a view myview in following manner

CREATE VIEW myview 
AS 
SELECT empno, ename
FROM empl
WHERE ename LIKE "R%";
Let me create another view myview2 but with WITH CHECK OPTION

CREATE VIEW myview 
AS 
SELECT empno, ename
FROM empl
WHERE ename LIKE "R%";
WITH CHECK OPTION;
Now the select statement for both the views is that the ename should start with R.

Let see what happens if we update the view myview.

UPDATE myview
SET ename = "David" 
WHERE empno =1;
Follwoing will be the output

empno   ename       deptno
1       David       University
2       Rachel      Sales
However, when we do same with myview2

UPDATE myview2
SET ename = "David" 
WHERE empno =1;
we get an error.

ERROR 1369 (HY000): CHECK OPTION failed 'database.myview2'
This is becuase the view check the condition that the ename should start with R.

CREATE TABLE t1 (a INT);
CREATE VIEW v1 AS SELECT * FROM t1 WHERE a < 2
WITH CHECK OPTION;
CREATE VIEW v2 AS SELECT * FROM v1 WHERE a > 0
WITH LOCAL CHECK OPTION;
CREATE VIEW v3 AS SELECT * FROM v1 WHERE a > 0
WITH CASCADED CHECK OPTION;

mysql> INSERT INTO v2 VALUES (2);
Query OK, 1 row affected (0.00 sec)
mysql> INSERT INTO v3 VALUES (2);
ERROR 1369 (HY000): CHECK OPTION failed 'test.v3'

mysql> INSERT INTO v2 VALUES (2);
ERROR 1369 (HY000): CHECK OPTION failed 'test.v2'
mysql> INSERT INTO v3 VALUES (2);
ERROR 1369 (HY000): CHECK OPTION failed 'test.v3'


-- Materialized View:
-- store a result of a query physically and update the data periodically.
-- A materialized view caches the result of a complex expensive query and then allow you to refresh this query periodically.
-- A materialized view executes the query once and then holds onto those results for your viewing pleasure until you refresh the materialized view.
Simple view (freshness data)
Materialized View(Cached data)
CREATE Materialized View IF NOT EXISTS view_name as query with [NO]data

-- Materialized View
store result of a query physically and update data periodically.
A matview can be used like a regular table ,for example you can add indexes or primary key on it.It suports VACCUM and ANALYSE COMMAND.
When materialized view can be used for ?
Materialized view can be used to cache results of a heavy query.
When you need to store data that has been manipulated from its basic normalized state.

-- Creating a materialized view
CREATE Materialized VIEW IF NOT EXISTS view_name AS query WITH [NO] data
CREATE Materialized view IF NOT EXISTS mv_directors AS SELECT first_name,last_name from directors WITH data 
CREATE Materialized view IF NOT EXISTS mv_directors_all AS SELECT first_name,last_name from directors WITH No data 
SELECT * from mv_directors;
SELECT * from mv_directors_all;
REFRESH Materialized VIEW mv_directors_nodata;

-- Drop a Materialized View 
DROP materialized view view_name;

-- Changing Materialized view data 
SELECT * from directors;
SELECT * from mv_directors;
INSERT INTO mv_directors(first_name)VALUES ('dir1'),('dir2');
REFRESH MATERIALIZED VIEW mv_directors;
DELETE FROM directors where directors_id IN(43,44,45);
UPDATE directors SET first_name ='ddir1' WHERE first_name ='dir1';

-- How to check if materialized view is populated or not
SELECT relispopulated FROM pg_class WHERE rel_name='mv_directors2';
CREATE MATERIALIZED VIEW mv_directors2 AS
SELECT 
first_name 
last_name
FROM directors
WITH NO DATA;
SELECT * from mv_directors2;

-- Refreshing data in materialized view
create materialized view mv_directors_us AS 
SELECT 
director_id,
first_name,
last_name,
date_of_birth,
nationality
FROm directors where nationality='American'WITH NO DATA;

SELECT * from mv_directors_us;
REFRESH Materialized view mv_directors_us;
SELECT * from mv_directors_us;






insert into rtable(n_ame,dept)values
('michael','eee'),
('aaron','mech'),
('othniel','civil'),
('bala','computer'),
('obadiah','computer')



insert into ltable(n_ame,dept)values
('michael','eee'),
('aaron','mech'),
('ananthunath','civil'),
('chandru','mech'),
('othniel','civil'),
('bala','computer'),
('obadiah','computer')          



























