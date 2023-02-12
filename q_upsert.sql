-- create sample table

CREATE TABLE t_tags( 
	id serial PRIMARY KEY,
	tag text UNIQUE,
	update_date TIMESTAMP DEFAULT NOW()	
);

-- insert some sample data

INSERT INTO t_tags (tag) values
('Pen'),
('Pencil');

-- Lets view the data

SELECT * FROM t_tags;

-- 2020-12-29 19:13:19.392095

-- Lets insert a record, on conflict do noting

INSERT INTO t_tags (tag) 
VALUES ('Pen')
ON CONFLICT (tag) 
DO 
	NOTHING;


SELECT * FROM t_tags;



-- Lets insert a record, on conflict set new values

INSERT INTO t_tags (tag) 
VALUES ('Pen')
ON CONFLICT (tag) 
DO 
	UPDATE SET
		tag = EXCLUDED.tag || '1',
		update_date = NOW();


/* Select All Data from a table */
SELECT * from actors;
SELECT * from movies;


/* Adding aliases to column in the table */
SELECT * from actors;
SELECT first_name As firstName from actors;
SELECT first_name As "firstName" from actors;

SELECT first_name As "first Name" from actors;

SELECT movie_name AS "Movie Name",movie_lang As "Language" from movies;

SELECT first_name As 'first Name' from actors;

/* Using SELECT statement for expresssions */
SELECT first_name,last_name from actors;
SELECT first_name||last_name from actors;
SELECT first_name||''||last_name from actors;
SELECT first_name||''||last_name As "Full Name" from actors;
SELECT 2*5;

/* Using OrderBy to sort Records */
SELECT * from movies Order By release_date ASC;
SELECT * from movies Order By release_date;
SELECT * from movies Order By release_date DESC;
SELECT * from movies Order By movie_name Asc,release_date DESC;

/* Using OrderBY with alias column name */
SELECT first_name,last_name from actors;
SELECT first_name,last_name As surname  from actors;
SELECT first_name,last_name As surname  from actors order by last_name ASC;
SELECT first_name,last_name As surname  from actors order by last_name DESC;
SELECT first_name,last_name As surname  from actors order by sur_name DESC;

/* Using Order BY to sort rows by expressions */
SELECT * from actors;
SELECT first_name,LENGTH(first_name) from actors;

SELECT first_name,LENGTH(first_name) as len from actors order by len ASC ;
SELECT first_name,LENGTH(first_name) from actors order by len DESC;
SELECT 5*10;

-- Using ORDER BY with column name or column number
SELECT * from actors;
SELECT * from actors order by first_name ASC, date_of_birth DESC;
SELECT first_name,last_name,date_of_birth from actors order by first_name ASC,date_of_birth DESC;
SELECT first_name,last_name,date_of_birth from actors order by 1 ASC,2 DESC;

-- Using ORDER BY with NULL values
SELECT * from demo_sorting ORDER By num Asc;
SELECT * from test ORDER By num NUlls last;
SELECT * from test ORDER By num NUlls First;
SELECT * from test ORDER By num Desc NUlls First;

-- Using DISTINCT for selecting distinct values
SELECT * from movies;
SELECT movie_lang from Movies;
SELECT Distinct movie_lang from Movies order by 1 Asc;
SELECT Distinct director_id from Movies order by 1 Asc;
SELECT Distinct director_id,movie_lang from movies order by 1 Asc;
SELECT Distinct * from movies order by 1;


-- Comparison, Logical and Arithmetic operator
1.Comparision
Equal to :=
greater than : >
less than : <
greater than or equal to: >=
less than or equal to:<=
Not equal to :<>

2.Logical
1.AND 
2.OR
3.LIKE
4.IN
5.BETWEEN

3.Arithmatic 
1.+
2.-
3./
4.multiply *

-- AND Operator 
SELECT * from movies where movie_lang='English' AND age_certificate='18'

-- OR operator
SELCT * from movies;
SELECT * from movies where movie_lang='English' OR movie_lang='chinese';
SELECT * from movies where movie_lang='English' OR movie_lang='chinese' order by movie_lang;
SELECT * from movie where movie_lang='English' AND director_id ='8'

-- Combining AND, OR operators
SELECT * from movies where movie_lang='English' OR movie_lang='Chinese'AND age_certificate='12';
SELECT * from movies where (movie_lang='English' OR movie_lang='Chinese')AND age_certificate='12';

-- What goes before and after WHERE clause
SELECT * from where orderby

-- Column aliases with column
No you cant use

-- Using Logical operators
SELECT * from movies where movie_length>100 order by movie_length;
SELECT * from movies where movie_length>=100 order by movie_length;
SELECT * from movies where movie_length<100 order by movie_length;
SELECT * from movies where movie_length<=100 order by movie_length;
SELECT * from movies order by release_date='1992-12-31';
SELECT * from movies order by release_date>'1992-12-31';
SELECT * from movies where movie_lang='English';
SELECT * from movies where movie_lang>'English';
SELECT * from movies where movie_lang<'English' order by movie_lang;
SELECT * from movies where movie_lang<>'English' order by movie_lang;
SELECT * from movies where movie_length>100;


Latha — Today at 12:51 PM
SELECT * from movies order by movie_length DESC LIMIT 5;
SELECT * from directors where nationality='American' Order By date_of_birth LIMIT 5 OFFSET 4;
SELECT * from directors where nationality='American' Order By date_of_birth FETCH FIRST 5 row only;


SELECT * from movie_lang in('English','Chinese','Japenese') order by movie_lang DESC;

SELECT * from movie_lang Not in ('English','Chinese','Japenese') order by movie_lang DESC;
SELECT * from actors where actor_id not in (1,2,3,4);
SELECT * from movies where movie_length not between 100 and 200 order by movie_length;

SELECT * from actors where first_name like '%tim'

SELECT * from actors where first_name ilike '%tim'























