
-- Postgresql Sequences
-- Create a sequence, advance a sequence, get current value, set value
create sequence IF NOT EXISTS test_seq ;
SELECT nextval(test_seq)
SELECT currval(test_seq)
SELECT setval('test_seq',100)
select setval('test_seq',100,false)
create sequence IF NOT EXISTS test_seq2 STARTS WITH 100
SELECT nextval('test_seq')
ALTER sequence test_seq RESTART WITH 100
ALTER sequnce test_seq rename to my_seq4

create sequence IF NOT EXISTS test_seq_3
INCREMENT BY 50
MINvalue 400 
maxvalue 1000
start with 500

select nextval('test_seq_3')
create sequence if not exists test_seqsmallint AS smallint
create sequence if not exists test_seqsmallint AS INT
create sequence if not exists test_seq4 AS bigint
create sequence  seq_desc increment -1 minvalue 1 maxvalue 3 start 3 no cycle;
select nextval('seq_desc')
delete sequence test_seq3
create table users (
    user_id SERIAL primary key,
    user_name VARCHAR(20)
)
insert into users(user_name)VALUES('ADAMN3')
SELECT * from users;
alter sequence users_user_id_seq RESTART with 100;
create table users2(
    user2_id INT primary key,
    user2_name VARCHAR(20)
)
create sequnece users2_user2_id_seq start with 100 owned by users2.user_id
alter table users2
alter column user2_id SET default nextval('users2_user2_id_seq')
insert into users2(user2_name) values('ADAM')
select * from users2
--  Listing all sequences
select relname sequence_name from pg_class where relkind='S'
-- share one sequnece between two tables 
create sequence common_fruits_seq start with 100;
create table apples(
    fruit_id INT DEFAULT nextval('common_fruits_seq') NOT NULL,
    fruit_name VARCHAR(10)
)
create table mangos(
     fruit_id INT DEFAULT nextval('common_fruits_seq') NOT NULL,
     fruit_name VARCHAR(20) 
)
insert into mangos(fruit_name) values('big_mangos')
select * from mangos;
insert into apples(fruit_name) values('big_mangos');

-- create an alphanumeric series
create sequence table_seq;
create table contacts(
    contact_id TEXT NOT NULL DEFAULT('ID'||nextval('table_seq')),
    contact_name varchar(50)
)
alter sequence table_seq owned_by contacts.contact_id;


-- String functions
-- UPPER,LOWER,INITCAP
SELECT UPPER('latha')
SELECT upper(first_name) as first_name,upper(last_name)as last_name from directors;
SELECT lower('Amazing')
SELECT initcap('amazing place')
select initcap(
    concat(first_name,'',last_name)
)AS full_name
from directors order by first_name

-- Left and Right

SELECT LEFT('ABCDD',2) //first 2 character
SELECT LEFT('ABC',-1) /except last one character
SELECT LEFT(first_name,1) AS initial,count(*) as total_initials from directors group by 1 order by 1;
SELECT movie_name,LEFT(movie_name,6) from movies
SELECT RIGHT('ABCCD',1)
SELECT RIGHT('ABCCD',-1)
SELECT last_name form directors where RIGHT(last_name,2)="on"

-- Reverse

SELECT reverse('AmAzing')

-- SPlit PART only work on string 

select split_part('1,2,3',',',1);
select split_part('A,B,C',',',2);
select split_part('A|B|C|D',',',3)
select movie_name,release_date,split_part(release_date::text,'-',2)as release_year from movies
select * from movies
SELECT LTRIM('yummy','y');
SELECT RTRIM('yummy','y');
SELECT BTRIM('yummy','y');
SELECT LTRIM(' Amazing')
SELECT RTRIM(' Amazing ')
SELECT BTRIM(' Amazing ')

-- LPAD and RPAD

SELECT LPAD('Database',15,'*')
SELECT RPAD('Database',15,'*')
-- LENGTH
SELECT length('Amazing database ')
SELECT length(first_name||''||last_name) full_name_length from directors orderby 2 DESC;

-- POSITION
SELECT position ('amazing' IN 'amazing is world')
-- STRPOS
SELECT strpos('Tech on the net', 't');
SELECT strpos('techonthenet.com', 'h');
 strpos
--------
      4
(1 row)

-- Substring
SELECT substring('What a wonderful' from 2 for 8)
SELECT substring('What a wonderful' from 8 for 10)
SELECT substring('What a wonderful' from 2 for 8)

SELECT first_name,lasst_name,SUBSTRING(first_name,1,1)AS INITIAL from directors order by last_name;


-- REPEAT
SELECT repeat('AB',2)

-- REPLACE

SELECT REPLACE('ABCD','A','X')

-- Aggregate Functions

SELECT COUNT(*) from movies;
SELECT * from movies;
SELECT COUNT(movie_length) from movies;
SELECT COUNT(distict(movie_lang)) from movies;
SELECT COUNT(distict(director_id)) from directors;
SELECT COUNT(*) from movies where movie_lang='ENGLISH'

-- SUM Function
SELECT SUM(revenues_domestic) from movies_revenues;
SELECT SUM(revenues_domestic) from movies_revenues where revenues_domestic>200;
SELECT SUM(movie_length)from movies where movie_lang='English'
SELECT SUM(DISTINCT revenues_domestic) from movies_revenues;

-- MIN and Max Function
SELECT MAX(release_date) from movies where movie_lang='Japanese'

SELECT MIN(release_date) from movies where movie_lang='Japanese'

-- GREATEST and LEAST function

SELECT LEAST('A','B','C')

-- Average With AVG function
SELECT AVG(DISTINCT movie_length) from movies where movie_lang='English';


-- Combining two columns
SELECT movie_id,revenues_domestic,revenues_international,(revenues_domestic+revenues_international) AS "total revenue" from movie_revenues;












