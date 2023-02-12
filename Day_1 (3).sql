CREATE TABLE customers (
	customer_id SERIAL PRIMARY KEY,
	first_name VARCHAR(50),
	last_name VARCHAR(50),
	email VARCHAR(150),
	age INT
);

SELECT * FROM customers;

INSERT INTO customers (first_name, last_name, email, age)
VALUES ('Adnan','Waheed','a@b.com',40);

INSERT INTO customers (first_name, last_name)
VALUES 
('ADNAN','WAHEED'),
('JOHN','ADAMS'),
('LINDA','ABE');


/* */
INSERT INTO customers (first_name)
VALUES ('ADAM');

INSERT INTO customers (first_name)
VALUES ('JOSEPH') RETURNING *;

INSERT INTO customers (first_name)
VALUES ('JOSEPH1') RETURNING customer_id;

SELECT * FROM customers;


/* */
INSERT INTO customers (first_name)
VALUES 
('Bill''O Sullivan');

SELECT * FROM customers;
  

/* */

SELECT * FROM customers;

UPDATE customers
SET email = 'a2@b.com'
WHERE customer_id = 1;

UPDATE customers
SET 
email = 'a2@b.com',
age = 30
WHERE customer_id = 1;

/* */
SELECT * FROM customers;

UPDATE customers
SET email = 'a2@b.com'
WHERE customer_id = 1
REETURNING *;
/* */
SELECT * FROM customers;

UPDATE customers
SET age = 1;



 
  