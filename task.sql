show databases;
use task;
show tables;

/*-----populating all data from each table---*/

select * from employees;
select * from offices;
select * from products;
select * from payments;
select * from productlines;
select * from orders;
select * from orderdetails;
select * from customers;

/*-----finding count of each table---*/
select count(*) as COUNT,  'EMPLOYEE' TABLE_NAME  from employees
union 
select count(*) as COUNT, 'CUSTOMERS' TABLE_NAME from customers
union 
select count(*) as COUNT, 'OFFICES' TABLE_NAME from offices
union
select count(*) as COUNT, 'PAYMENTS' TABLE_NAME from payments
union
select count(*) as COUNT, 'ORDERS' TABLE_NAME from orders
union
select count(*) as COUNT, 'ORDERDETAILS' TABLE_NAME from orderdetails
union
select count(*) as COUNT,'PRODUCTS' TABLE_NAME from products
union
select count(*) as COUNT,'PRODUCTLINES' TABLE_NAME from productlines;


SELECT CustomerName, City, Country FROM Customers;
SELECT DISTINCT Country FROM Customers;
SELECT * FROM Customers WHERE Country = 'USA';
SELECT * FROM Customers WHERE customerNumber = 1003; 
SELECT * FROM Customers WHERE Country = 'USA' AND state = 'California';
SELECT * FROM Customers WHERE Country = 'Australia' OR Country = 'Europe';
SELECT * FROM Customers WHERE NOT Country = 'Germany';
SELECT * FROM Customers WHERE NOT Country = 'China' AND NOT Country = 'USA';
SELECT MIN(buyPrice) AS SmallestPrice FROM Products;
SELECT MAX(buyPrice) AS LargestPrice FROM Products;
SELECT AVG(buyPrice) FROM Products;

SELECT o.orderNumber, c.CustomerName, o.orderDate FROM orders o
INNER JOIN customers c
ON o.customerNumber=c.customerNumber where orderDate='2003-01-06';


SELECT * FROM employees
WHERE firstName LIKE 'E%';

update employees set lastName='Musk' where employeeNumber=101;

SELECT * FROM Customers
WHERE Country IN ('USA', 'Japan', 'China');

SELECT * FROM Customers
WHERE Country NOT IN ('USA', 'Japan', 'China');

SELECT * FROM Products
WHERE buyPrice BETWEEN 2000 AND 5000;

SELECT * FROM payments
WHERE amount NOT BETWEEN 10000 AND 20000;

SELECT orderNumber, quantityOrdered,
CASE
    WHEN quantityOrdered > 40 THEN 'The quantity is greater than 40'
    WHEN quantityOrdered = 40 THEN 'The quantity is 40'
    ELSE 'The quantity is under 40'
END AS QuantityText
FROM orderDetails;

SELECT c.customerNumber,customerName, CONCAT("Check No : ",checkNumber, ", Payment Date :", paymentDate, ", Amount : ", amount) AS Payment_Details
FROM payments p
inner join customers c
where c.customerNumber=p.customerNumber;

drop view USA_Customers;
create view USA_Customers as
select customerName, phone from customers
where country='USA';
select * from USA_Customers;

select orderDate,productName,quantityOrdered,priceEach,amount ,status from employees e
inner join customers c
on e.employeeNumber=c.salesRepEmployeeNumber
inner join orders o
on c.customerNumber=o.customerNumber
inner join orderDetails od
on od.orderNumber=o.orderNumber
inner join products p
on p.productCode=od.productCode
inner join payments py
on py.customerNumber=c.customerNumber
where firstName='Jaoquin';

select customerNumber, customerName,creditLimit from customers where creditLimit in (select max(creditLimit) from customers);

select c.customerNumber,customerName,productName,firstName as SalesRep,(priceEach*quantityOrdered) as Total_Amount from employees e
inner join customers c
on c.salesRepEmployeeNumber=e.employeeNumber
inner join orders o
on c.customerNumber=o.customerNumber
inner join orderdetails od
on od.orderNumber=o.orderNumber
inner join products pd
on pd.productCode=od.productCode
where pd.productCode='P101';
