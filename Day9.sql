
-- Server Programming 

-- Functions in SQL
-- Creating our first SQL fuction 
create or replace FUNCTION fn_mysum(int,int)
RETURNS int AS
'
SELECT $1 + $2
' LANGUAGE SQL
SELECT fn_mysum(10,20);

-- Introducing Dollar Quoting

create or replace FUNCTION fn_mysum(int,int)
RETURNS int AS
$$
SELECT $1 + $2
$$ LANGUAGE SQL
SELECT fn_mysum(10,20);

-- Function Returning Null values
SELECT * from employess /North Wind database
CREATE or REPLACE FUNCTION fn_employess_update_country() RETURNS VOID AS
$$
  update employess SET country='N/A'WHERE country is NULL
$$ LANGUAGE SQL

SELECT fn_employess_update_country()
UPDATE employess SET country=NULL where employee_id=1

-- Function returning single value 
CREATE or REPLACE FUNCTION fn_product_min_price() RETURNS VOID AS
$$
  SELECT MIN(unit_price) FROM products
$$ LANGUAGE SQL

SELECT fn_product_min_price()

CREATE or REPLACE FUNCTION fn_product_max_price() RETURNS VOID AS
$$
  SELECT MAX(unit_price) FROM products
$$ LANGUAGE SQL

SELECT fn_product_max_price()

CREATE or REPLACE FUNCTION fn_biggest_order() RETURNS double precision AS
$$
SELECT MAX(amount)from(
    SELECT order_id,SUM(unit_price_quantity)as amount from order_details GROUP BY order_id)as total_amount
)
$$ LANGUAGE SQL

SELECT fn_biggest_order();


CREATE or REPLACE FUNCTION fn_smallest_order() RETURNS double precision AS
$$
SELECT MIN(amount)from(
    SELECT order_id,SUM(unit_price_quantity)as amount from order_details GROUP BY order_id)as total_amount
)
$$ LANGUAGE SQL

SELECT fn_smallest_order();

-- Function returning single value part 2

SELECT *from customers 

CREATE or REPLACE FUNCTION total_customers() RETURNS bigint AS
$$
SELECT COUNT(*) from customers
$$ LANGUAGE SQL
SELECT total_customers()

-- Function returning single value part 3
SELECT * from customers;
CREATE or REPLACE FUNCTION fn_api_empty_tax() RETURNS bigint AS
$$
 SELECT COUNT(*) from customers WHERE fax is NULL
$$ LANGUAGE SQL

SELECT fn_api_empty_tax();

SELECT * from customers;
CREATE or REPLACE FUNCTION fn_api_empty_region() RETURNS bigint AS
$$
 SELECT COUNT(*) from customers WHERE region is NULL
$$ LANGUAGE SQL

SELECT fn_api_empty_region();

-- Functions Using Parameters
CREATE OR REPLACE FUNCTION fn_mid(p_string varchar,p_starting_point integer) RETURNS varchar AS
$$
SELECT substring(p_string,p_starting_point)
$$ LANGUAGE SQL
SELECT fn_mid('AMAZING',2)

SELECT * from customers;
CREATE or REPLACE FUNCTION fn_api_by_city(p_city varchar) RETURNS bigint AS
$$
  SELECT COUNT(*) from customers where city=p_city
$$ LANGUAGE SQL

SELECT fn_api_by_city('London')

-- Function Using Parameters part 2

CREATE or REPLACE FUNCTION fn_api_total_orders(p_customer_id varchar) RETURNS bigint AS
$$
  SELECT COUNT(*) from orders NATURAL JOIN customers where customer_id=p_customer_id
$$ LANGUAGE SQL

SELECT fn_api_total_orders('BERGES')

-- Function Using Parameters part 3
CREATE or REPLACE FUNCTION fn_largest_order(p_customer_id bpchar) RETURNS double precision AS
$$
SELECT MAX(order_amount) FROM(
SELECT orders.order_id,SUM((unit_price+quantity)-discount) as order_amount FROM order_details NATURAL JOIN orders 
WHERE orders.customer_id=p_customer_id GROUP BY orders.order_id)as total_amount
$$ LANGUAGE SQL 
SELECT fn_largets_order('ALFKI');


-- Function Using Parameters part 4

CREATE OR REPLACE FUNCTION fn_most_ordered_product(p_customer_id bpchar) RETURNS varchar AS
$$
  SELECT product_name from products WHERE product_id IN (
    SELECT product_id from (
        SELECT product_id,SUM(quantity) as total_quantity from order_details NATURAL JOIN orders WHERE 
        orders.customer_id='CACTU'
        GROUP BY product_id
        ORDER BY 2 DESC
        LIMIT 1

    )AS product_order
  )

$$ LANGUAGE SQL 


-- Functions returning a composite




















