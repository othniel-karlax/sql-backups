-- Data type in postgresql
-- Boolean
-- Character Types [ such as char, varchar, and text]
-- Numeric Types [ such as integer and floating-point number]
-- Temporal Types [ such as date, time, timestamp, and interval]
-- UUID [ for storing UUID (Universally Unique Identifiers) ]
-- Array [ for storing array strings, numbers, etc.]
-- JSON [ stores JSON data]
-- hstore [ stores key-value pair]
-- Special Types [ such as network address and geometric data]
-- -- Boolean
-- 1, yes, y, t, true values are converted to true
-- 0, no, false, f values are converted to false
-- Characters 

  
create table persons (
    person_id SERIAL PRIMARY KEY,
    first_name VARCHAR(20) NOT NULL,
    last_name VARCHAR(20)  NOT NULL,

);
ALTER table persons ADD column age INT not null;
ALTER table persons ADD column age INT not null,ADD column email VARCHAR(250) UNIQUE;

-- ADD/Modify Column
ALTER table users RENAME To persons;

ALTER table persons rename column age to person_age;
Alter table persons drop column person_age;
alter table persons add column age varchar(10);
ALTER table persons alter column age type int using age::integer;
alter table persons alter column age type varchar(10);
alter table persons add column is_enable VARCHAR(10)
alter table persons add column is_enable SET default='Y';
INSERT into persons(first_name,last_name,nationality,age) values('latha','radha','US','20')

-- Add constraints to columns
create table web_links(
    link_id SERIAL PRIMARY KEY,
    link_url VARCHAR(255)not null,
    link_target VARCHAR(20) UNIQUE
);
INSERT into web_links(link_url,link_target) VALUES ('https://www.google.com','_blank')
ALTER TABLE web_links ADD constraint unique_web_url UNIQUE (link_url);
ALTER table web_links ADD column is_enable VARCHAR(2);
INSERT INTO web_links(link_url,link_target,is_enable) VALUES ('http://www.google.com','_blank','Y');o
ALTER table web_links  ADD check (is_enable IN ('Y','N'));
update web_links SET is_enable='Y' where link_id=3;

-- Data type conversion
SELECT * from movies where movie_id =1;
SELECT * from movies where movie_id ='1'; //Implicit conversion
SELECT * from movies where movie_id = integer '1'; //explicit conversion

-- Using CAST for data type conversion
SELECT CAST('10' as integer);
SELECT CAST('10' as integer);
SELECT CAST('2020-05-01' AS DATE)

-- Implicit to explicit conversion
SELECT '10 minute':: interval,'4 hour'::interval
SELECT 20 ! AS "result"

-- Table data conversion



-- Postgresql constraints
constraints are gatekeepers.It will allow you to enter certain data into database.
controls the kind of  data enter into database.
cloumn level constraints
table level constraints
Not Null,Unique,Default,primary key,Foreign key,check.

-- Not Null Constraint

create table table_nn(
    id serial key primary key,
    tag text not null
);
 Select * from table_nn;
 Insert into table_nn values('adam');
 Insert into table_nn values(NULL);
  Insert into table_nn values('');

  create table table_nn2(
    id serial key primary key,
    tag text 
);

alter table table_nn2 ALTER column tag2 SET not null;

-- Unique constraint

create table table_emails(
    id serial PRIMARY KEY,
    emails text UNIQUE
);

insert into table_emails(emails) values('A@gmail.com');
create table table_products(
    id serial primary key,
    product_code varchar(10),
    product_name text,

)

alter table table_products ADD constraint unique_product_code UNIQUE(product_code,product_name)
insert into table_products(product_code,product_name)values('A','apple')
select * from table_products;

-- Default constraint
create table employees(
    employee_id SERIAL PRIMARY KEY,
    first_name VARCHAR(20),
    last_name VARCHAR(20),
    is_enable VARCHAR(2) DEFAULT 'Y'
);

INSERT INTO employees (first_name,last_name) VALUES('JOHN','ADAM')

ALTER table employess alter column is_enable SET DEFAULT 'N'

ALTER table employess alter column is_enable DROP default;

-- Primary Key constraint

PRimary key Should be as Unique Not NULL

create table table_items(
    item_id INTEGER PRIMARY KEY,
    item_name VARCHAR(100) NOT NULL
);

INSERT INTO table_items(item_id,item_name) VALUES (2,'PEN')
ALTER TABLE table_items DROP constraint cname;
ALTER table table_items ADD PRIMARY KEY(item_id,item_name);
INSERT INTO table_items(item_id,item_name) VALUES (2,'PEN');
INSERT INTO table_items(item_id,item_name) VALUES (2,'');


create table t_grades(
    course_id VARCHAR(20) NOT NULL,
    student_name VARCHAR(20) NOT NULL,
    grade int NOT NULL
);

INSERT into t_grades(course_id,student_id,grade) VALUES('MATH','S2',70),('PHYSICS','S1',70),('CHEMISTRY','S1',70),('ENGLISH','S2',70),PRIMARY KEY(course_id,student_id);

ALTER table t_grades drop constraint cname;
ALTER table t_grades ADD CONSTRAINT t_grades_course_id_session_id_pkey PRIMARY KEY(course_id,student_id);

-- Foreign KEY Constraint

Parent table(reference column) foreign Key(primary key id )
create table t_products(product_id INT PRIMARY KEY,product_name VARCHAR(20) NOT NULL,supplier_id INT NOT NULL);
create table t_suppliers(supplier_id INT PRIMARY KEY,supllier name VARCHAR(100) NOT NULL);
INSERT into t_products(product_id,product_name,supplier_id)VALUES (1,'PEN',1),(2,'PAPER',2);
SELECT * from t_products;
INSERT into t_suppliers(supplier_id,supplier_name)VALUES(1,'SUPPLIER1'),(2,'SUPPLIER2');
SELECT * from t_suppliers;
INSERT into t_products(product_id,product_name,supplier_id)VALUES (1,'COMPUTER',10);

create table t_products(product_id INT PRIMARY KEY,product_name VARCHAR(20) NOT NULL,supplier_id INT NOT NULL,FOREIGN KEY (supplier_id) REFERENCES t_suppliers(supplier_id));

INSERT into t_products(product_id,product_name,supplier_id)VALUES (1,'COMPUTER',10);


delete from t_products where product_id=4;
delete from t_suppliers where supplier_id=100;

update t_products SET supplier_id=100 where product_id=100;
alter table t_products constraint cnmae;
alter table t_products ADD constraint t_products_supplier_id_fkey FOREIGN KEY REFERENCES t_suppliers(supplier_id)

-- Check Constraint

create table staff(
    staff_id SERIAL PRIMARY KEY,
    first_name VARCHAR(20),
    last_name VARCHAR(20),
    birth_date DATE CHECK(birth_date>'1999-03-03'),
    joined_date DATE CHECK(joined_date>birth_date),
    salary NUMERIC check(salary>100)
);

insert into staff(first_name,last_name,birth_date,joined_date,salary)VALUES('latha','radha','1992-05-17','2022-09-12',100);
insert into staff(first_name,last_name,birth_date,joined_date,salary)VALUES('latha','radha','1992-05-17','2022-09-12',10);
update staff set salary=0 where staff_id=1;

create table prices(price_id SERIAL PRIMARY KEY,product_id INT NOT NULL,price NUMERIC NOT NULL,discount NUMERIC NOT NULL,valid_from DATE NOT NULL)
alter table prices ADD constraint price_check CHECK(
price >0
AND discount>=0
AND price>discount
)
insert into prices(product_id,price,discount,valid_from) VALUES('2',100,20,'2020-02-01')
ALTER table prices RENAME constraint price_check to price_discount_check;
ALTER table prices drop constraint cname;












