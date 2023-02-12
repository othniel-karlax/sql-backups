
-- Introduction to PL/pgSQL language
Pl/pgSql is a powerful SQL scripting language that is heavily influenced by the oracle PL/SQL
PL/pgSQL is a full fledged SQL development language 
originally designed for simple scalar functions,and now providing
1.Full PostgreSQL internals
2.Control Structures
3.Variable Declarations
4.Expression
5.Loops
6.Cursors and much more 
Ability to create 
1.complex functions
2.new data types
3.stored procedures and much more 
It is easy to use
Available by default on postgresql
optimized  for performance of data intensive tasks.

-- PL/pgSQL Vs SQL
SQL is a query language,but can only execute SQL statement individually
PL/pgSQL is 
--wrap multiple statement in a object
--store that object on the server
--instead of sending multiple statements to the server one by one,we can send one statement to execute the 'object' stored in the server
--reduced round trips to server for each statement to execute 
--provide transactional integrity and much more 

-- Structure of a PL/pgSQL function
create function function_name(p1 type,p2 type) RETURNS return_type AS
$$
BEGIN
  --statements

END
$$
LANGUAGE plpqsql

SELECT x-SQL
RETURN x-PLPGSQL

CREATE OR REPLACE FUNCTION fn_api_products_max_price() RETURNS bigint AS
$$
BEGIN
RETURN MAX(unit_price) from products;
END
$$
LANGUAGE plpgsql;

-- PL/pgSQL Block Structure
1.PL/pgSQL function or stored procedure is organized into blocks
2.Block structure Syntax
[<<label>>]
[DECLARE
declarations]
BEGIN
statements;
END;[label];

-- Declaring Variables 
DO 
$$
DECLARE 
  mynum integer :=1;
  first_name varchar(100) :='Latha';
  hire_date date :='2020-01-01';
  start_time timestamp: =NOW();
  emptyvar integer;
  var1 integer;
  BEGIN
  RAISE NOTICE 'My variables % % % % %',
  mynum,
  first_name,
  hire_date,
  start_time,
  emptyvar,
  var1;
  END

  $$


--   Declaring Variables Via ALIAS FOR
newname ALIAS FOR oldname
CREATE OR REPLACE FUNCTION function_name(int,int)RETURNS INT AS 
$$
DECLARE
X ALIAS FOR $1
Y ALIAS FOR $2
BEGIN
END;

$$ language plpqsql

-- Declaring Variables in function
CREATE OR REPLACE Function fn_my_sum(int,int)RETURNS integer AS
$BODY$
DECLARE 
ret integer;
X ALIAS for $1;
Y ALIAS for $2
BEGIN
ret := x+y;
RETURN ret;
END;
$BODY$
LANGUAGE plpqsql

SELECT fn_my_sum(2,2);

-- Variable Initialize Timing
DO
$$
DECLARE 
  start_time time := NOW();
  BEGIN
   RAISE NOTICE 'Starting at : %',start_time;
   PERFORM pg_sleep(2);
   RAISE NOTICE 'Next time at : %',start_time;

  END;

$$
LANGUAGE plpqsql

-- Copying Data Types

DO 
$$
DECLARE
  variable_name table_name.column_name%TYPE;
  empl_first_name employess.first_name%TYPE;
  prod_name products.product_name%TYPE
  BEGIN
     variable_name;
  END;

--   Assigning Variables from Query
DO 
$$
  DECLARE 
    product_title products.product_name%TYPE;
    BEGIN
    SELECT product_name FROM products INTO product_title WHERE product_id=1 LIMIT 1
    RAISE NOTICE 'Your Product name is %',product_title;

    END;
$$

DO
$$
DECLARE 
row_product record;
BEGIN
SELECT * from products INTO product_title WHERE product_id=1 LIMIT 1;
RAISE NOTICE 'Your product name is %',product_title;
END;

$$

-- Using IN,OUT without RETURNS
CREATE OR REPLACE FUNCTION fn_my_sum(IN x integer,IN y integer,OUT z integer) AS
BEGIN
z :=x+y;
END
$$ LANGUAGE PLPGSQL;
SELECT fn_my_sum(3,4);


CREATE OR REPLACE FUNCTION fn_my_sum2(IN x integer,IN y integer,OUT w integer,OUT z integer) AS
$$
BEGIN
w :=x+y;
z :=x*y;
END;
$$
LANGUAGE PLPGSQL;

SELECT fn_my_sum2();

-- Variables in Block and Subblock

DO 
$$
<<parent>>
DECLARE 
 counter integer :=0;
 BEGIN
 counter := counter+1;
 RAISE NOTICE 'The Current Value of counter is %',counter
 ---another block
 DECLARE 
 counter :=0;
 BEGIN
 counter := counter+5;
 RAISE NOTICE 'The current value of COUNTER at subblock is %',counter;
 RAISE NOTICE 'The CURRENT VALUE OF COUNTER at parent is %',Parent.counter;
 END:
 $$

--  How to Return Query Results
CREATE OR REPLACE FUNCTION function_name RETURNS SETOF table_name AS
$$
BEGIN
RETURN QUERY SELECT;
END;
$$ LANGUAGE PLPGSQL;

SELECT * from orders ORDER BY order_date DESC;
CREATE OR REPLACE FUNCTION fn_api_orders() RETURNS SETOF orders AS
$$
BEGIN 
 RETURN QUERY 
 SELECT * from orders ORDER BY order_date DESC
 LIMIT 10
 END;
 $$ LANGUAGE PLPGSQL ;
 SELECT * from fn_api_orders();


--  Control Structures-If Statement

-- Control structure
-- conditional statements
-- Loop statements
-- Exceptional hadler functions
-- Conditional statements
   IF
   CASE

IF expression THEN
 statement ..
 ELSIF expression THEN
 statement ...
  ELSIF expression THEN
 statement ...
  ELSIF expression THEN
 statement ...
 ELSE
 statement
 END IF;

--  Using IF with table data 

CREATE OR REPLACE FUNCTION fn_api_products_category(price real) RETURNS text AS
$$
BEGIN
IF price > 50  THEN 
 RETURN 'HIGH';
ELSIF price > 25 THEN 
  RETURN 'MEDIUM';
ELSE
 RETURN 'SWEET_SPOT';
 END IF;
 END;

$$ LANGUAGE PLPGSQL

SELECT fn_api_products_category(unit_price),* from products ORDER BY 1 DESC;

-- CASE STATEMENT

simple List of values
searched Range of values

CREATE OR REPLACE FUNCTION fn_my_check_value(x integer default 0)RETURNS TEXT AS
$$
BEGIN
CASE x
WHEN 10 THEN
 RETURN 'Value=10';
 WHEN 20 THEN
 RETURN 'Value =20';
 ELSE
 RETURN 'No values found,returning input vaue x';
 END CASE;

END;
$$ LANGUAGE PLPGSQL; 

SELECT fn_my_check_integer(20);

SELECT * from orders;
SELECT * from shippers;


-- Searched CASE statement

DO 
$$
DECLARE 
total_amount numeric;
order_type varchar(50);
BEGIN
SELECT SUM((unit_price+quantity)-discount)INTO total_amount
FROM order_details WHERE order_id=10248;
IF FOUND THEN 
CASE
WHEN total_amount > 200 THEN 
 order_type='PLATINUM';
 WHEN total_amount >100 THEN 
 order_type='GOLD'
 ELSE
 order_type='SILVER';
 END CASE;
 RAISE  NOTICE 'Order Amount,Order Type % %',total_amount,order_type;
 ELSE
 RAISE NOTICE 'No order was found';
 END IF;
 END;
 $$ LANGUAGE PLPGSQL;

--  LOOP Statement

LOOP 
 STATEMENT 
 EXIT;
 END LOOP;

 LOOP
  STATEMENT
  EXIT WHEN CONDITION met 
END LOOP

LOOP
STATEMENT 
IF CONDITION THEN 
EXIT;
END IF;
END LOOP;

DO
$$
DECLARE 
counter integer =0;
BEGIN
LOOP
RAISE NOTICE '%',counter;
counter := counter+1;
EXIT WHEN 
counter=5;
END LOOP;
END;
$$ LANGUAGE PLPGSQL;

-- FOR LOOP
FOR [counter name] IN [REVERSE] (START VALUE).....(END VALUE) (By stepping)
LOOP 
statements;
END LOOP;

DO 
$$
BEGIN 
FOR COUNTER IN 1..10
LOOP
  RAISE NOTICE 'Counter: %',counter;
END LOOP;
END;

$$ LANGUAGE PLPGSQL;


DO 
$$
BEGIN 
FOR COUNTER IN REVERSE 10..1 
LOOP
  RAISE NOTICE 'Counter: %',counter;
END LOOP;
END;

$$ LANGUAGE PLPGSQL;


DO 
$$
BEGIN 
FOR COUNTER IN REVERSE 10..1 BY 2
LOOP
  RAISE NOTICE 'Counter: %',counter;
END LOOP;
END;

$$ LANGUAGE PLPGSQL;

-- For Loop iterate over result set
FOR target IN your_select_statement
LOOP
END LOOP;

DO
$$
DECLARE
rec record;
BEGIN FOR rec IN
SELECT order_id,customer_id from orders LIMIT 10
LOOP
RAISE NOTICE '%,%',order_id,customer_id;
END LOOP;
END;
$$LANGUAGE PLPGSQL;

-- CONTINUE STATEMENT
CONTINUE (loop_label)(when condition)
DO
$$
DECLARE 
counter int = 0;
BEGIN
LOOP
 counter=counter+1;
 EXIT WHEN counter>20;
 CONTINUE WHEN MOD(counter,2)=1;
 RAISE NOTICE '%',counter;
 END LOOP;
 END;
 $$ LANGUAGE PLPGSQL;


--  ForEach Loop With arrays

FOREACH var IN ARRAY array_name
Loop
statements...
END LOOP

DO 
$$
DECLARE 
arr1 int[] :=array[1,2,3,4];
arr2 int[] :=array[5,6,7,8];
var int;
BEGIN
FOREACH var In ARRAY arr1||arr2
LOOP
RAISE INFO '%',var
END LOOP;
END;
$$ LANGUAGE PLPGSQL;

-- WHILE LOOP

CREATE or REPLACE function fn_create_table_insert_values(x integer) RETURNS boolean AS
$$
DECLARE 
 counter integer :=1;
 done boolean :=false;
 BEGIN
 EXECUTE format('
 CREATE TABLE IF NOT EXISTS t_table (id int)
 ');
 WHILE counter <= x 
 LOOP
 INSERT INTO t_table(id)VALUES(counter);
 counter :=counter+1;
 END LOOP;
 RETURN done;
 END;
 $$ LANGUAGE PLPGSQL;
 
 SELECT fn_create_table_insert_values(10);

--  Using Return Query
RETURN QUERY your_select_statement

CREATE OR REPLACE FUNCTION fn_sold_products_more_values(p_total_sales real)
RETURNS SETOF products AS
$$
BEGIN
RETURN QUERY
SELECT * from products WHERE product_id IN (
  SELECT product_id from (
    SELECT product_id,SUM ((unit_price+quantity)-discount)
    FROM order_details
    GROUP BY product_id
    HAVING SUM((unit_price+quantity)-discount)>p_total_sales
  ) AS filter_products
);
IF NOT FOUND THEN 
RAISE EXCEPTION 'No products was found for total_sales> %',p_total_sales;
END IF;
END;
$$ LANGUAGE PLPGSQL

-- RETURNS TABLE
RETURNS TABLE(column_list);

CREATE OR REPLACE FUNCTION fn_api_products_key(p_pattern varchar)
RETURNS TABLE (productname varchar,unitprice real)
AS
$$
BEGIN 
RETURN QUERY SELECT product_name,unit_price FROM products WHERE product_name LIKE p_pattern;
END;

$$ LANGUAGE PLPGSQL;
SELECT * FROM fn_api_products_key('B%')


-- Exploring Stored Procedures 
-- Function Vs Stored Procedures 
1. A user defined function cannot execute transaction.
2.Inside a function you cannot start transaction.
3.Stored procedures support transaction.
4.Stored procedure doesnt return any value,so you cannot use return.
5.However you can use return statement without the expression to stop the stored procedure immediately.
6.INOUT mode can be used to return a value from stored procedure .
7.Cannot be executed or called from within a SELECT
CALL procedure_name()
8.You can call procedure as often as you like.
9.They are compiled object.
10.Procedures may or may not use parmaters 
procedure(p1,p2)
11.Execution
1.Explicit Execution-Execute command,along with sp name and optional parameters
2.Implicit Execution-using only sp name CALL procudure_name()
12.Declaration section can be empty.
13.stored procedure do not have parameters called "static"
13.Stored procedure having parameter called "dynamic"

CREATE OR REPLACE procedure procedre_name (parameter_list)
AS LANGUAGE PLPGSQL
$$
DECLARE 

BEGIN

END

$$

-- Create a transaction
create table t_accounts(
  recid SERIAL PRIMARY KEY,
  name VARCHAR NOT NULL,
  balance dec(15,2) NOT NULL
);
INSERT INTO t_accounts(name,balance) values ('Adam',100),('Linda',100);
SELECT * from t_accounts;
CREATE OR REPLACE procedure pr_sum(sender int,receiver int,amount dec)AS
$$
BEGIN
UPDATE t_accounts SET balance =balance -amount where recid=sender;

UPDATE t_accounts SET balance =balance + amount where recid=receiver;

COMMIT;
END;

$$ LANGUAGE PLPGSQL

CALL pr_sum(1,2,100);
SELECT * from t_accounts;

-- Understanding the use of stored procedures 
1.data consistency
2.complex  operations into a single easy to use unit.
3.To simply overall 'Change Management' if tables,columns or business logic needs to be chnaged then only stored procedure need to be updated
instead of all chnages at every level
4.To ensure security.
5.To fully utilize transaction and its all benefits for data integrity and much more.
6.Performnace 
7.Modularity
8.Security-SQL Injection errors.

-- Returning a Value

CREATE OR REPLACE PROCEDURE pr_orders(INOUT total_count integer default 0) AS
$$
BEGIN 

SELECT COUNT(*) INTO total_count from orders
END;

$$LANGUAGE PLPGSQL

CALL pr_orers()

-- Drop a Procedure 

drop procedure (if exists) procedure_name (argument_list) (cascade|restrict)
drop procedure procedure_name;

-- Introduction To triggers 

CREATE OR REPLACE FUNCTION fn_my_check(x integer default 0,y integer default 0)RETURN text AS
$$
BEGIN
IF x>y THEN 
 RETURN 'x>y';
 ELSIF x=y THEN
  RETURN 'x=y';
 ELSE
 RETURN 'x<y';
 ENDIF;

END;

$$ LANGUAGE PLPGSQL;
SELECT fn_my_check();




















































           












































          