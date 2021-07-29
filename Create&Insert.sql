use task;
CREATE TABLE offices (
  officeCode varchar(10) NOT NULL primary key,
  city varchar(50) NOT NULL,
  phone varchar(50) NOT NULL,
  addressLine1 varchar(50) NOT NULL,
  addressLine2 varchar(50) DEFAULT NULL,
  state varchar(50) DEFAULT NULL,
  country varchar(50) NOT NULL,
  postalCode varchar(15) NOT NULL,
  territory varchar(10) NOT NULL
  );
insert into offices values(2,'San Francisco','8965435678','Green Appartments','Flat B12','SC','USA','078','NA'),
(3,'Florida','8965765689','Street 143','Holy park 764','Melbourne','Australia','067','NA'),
(4,'Fuchu','89756427869','Blue park','564 Street','Tokyo','Japan','067','NA'),
(5,'Wuhan','8965765678','Street 67','Wuhan Park','Henan','China','067','NA');

CREATE TABLE employees (
  employeeNumber int (10) NOT NULL,
  lastName varchar(50) NOT NULL,
  firstName varchar(50) NOT NULL,
  extension varchar(10) NOT NULL,
  email varchar(100) NOT NULL,
  officeCode varchar(10) NOT NULL,
  reportsTo int (10) DEFAULT NULL,
  jobTitle varchar(50) NOT NULL,
  PRIMARY KEY (employeeNumber),
  CONSTRAINT emp_fk_1 FOREIGN KEY (reportsTo) REFERENCES employees (employeeNumber),
  CONSTRAINT emp_fk_2 FOREIGN KEY (officeCode) REFERENCES offices (officeCode)
);
insert into employees values
(101,'Mask','Elon','x6545','kane@gmail.com','1',null,'CEO'),
(102,'Lannister','Tyrion','x0987','tyrion@gmail.com','2',101,'President'),
(103,'Binklage','Peter','x8747','peter@gmail.com','3',102,'Vice President'),
(104,'Nolan','Christopher','x9875','nolan@gmail.com','4',103,'Manager'),
(105,'Targaryen','Daenerys','x1234','daen@gmail.com','4',104,'Assistant Manager'),
(106,'Ledger','Heath','x5435','heath@gmail.com','4',104,'Assistant Manager'),
(107,'Decaprio','Leonardo','x5435','leonardo@gmail.com','4',106,'Sales Rep'),
(108,'Bale','Christian','x1085','bale@gmail.com','4',106,'Sales Rep'),
(109,'Phoenix','Jaoquin','x3210','jacky@gmail.com','4',105,'Sales Rep'),
(110,'Robbie','Margot','x3275','bale@gmail.com','4',105,'Sales Rep');

CREATE TABLE customers (
  customerNumber int(10) NOT NULL,
  customerName varchar(50) NOT NULL,
  contactLastName varchar(50) NOT NULL,
  contactFirstName varchar(50) NOT NULL,
  phone varchar(50) NOT NULL,
  addressLine1 varchar(50) NOT NULL,
  addressLine2 varchar(50) DEFAULT NULL,
  city varchar(50) NOT NULL,
  state varchar(50) DEFAULT NULL,
  postalCode varchar(15) DEFAULT NULL,
  country varchar(50) NOT NULL,
  salesRepEmployeeNumber int (10) DEFAULT NULL,
  creditLimit int (10) DEFAULT NULL,
  PRIMARY KEY (customerNumber),
  CONSTRAINT cstmr_fk_1 FOREIGN KEY (salesRepEmployeeNumber) REFERENCES employees (employeeNumber)
);
insert into customers values
('1001', 'Australian Motors', 'Jackman', 'Hugh', '8723145610', 'Safari Park', 'Street 645', 'Melbourne', 'Victoria', '625', 'Australia', '109', '500000'),
('1002', 'Suntech Motors', 'Jackman', 'Hugh', '8723145610', 'Safari Park', 'Street 645', 'Nagano', 'Kanagawa', '154', 'Japan', '109', '100000'),
('1003', 'Auto Motors Collections', 'Cameron', 'James', '7291737191', 'Asian Park', 'Street 645', 'Gifu', 'Beijing', '625', 'China', '109', '350000'),
('1004', 'AV Stores', 'Stannis', 'Baratheon', '7649034123', 'Valley Center', 'Street 403', 'Houston', 'California', '045', 'USA', '110', '500000'),
('1005', 'Eurotech Imports', 'Lee', 'John', '8723145610', 'Chestnut Street', 'Apartment 4', 'Vienna', 'Austria', '154', 'Europe', '107', '75000');

CREATE TABLE productlines (
  productLine varchar(50) NOT NULL,
  textDescription varchar(4000) DEFAULT NULL,
  htmlDescription text,
  image blob,
  PRIMARY KEY (productLine)
);
insert into productlines values
('Motocycles','Make your wildest car ownership dreams come true. Whether you are looking for classic muscle cars, dream sports cars or movie-inspired miniatures, you will find great choices in this category.','','')
,('Planes','Unique, diecast airplane and helicopter replicas suitable for collections, as well as home, office or classroom decorations.','','')
,('Ships','The perfect holiday or anniversary gift for executives, clients, friends, and family.','','')
,('Trains',' Model trains are a rewarding hobby for enthusiasts of all ages. Whether you are looking for collectible wooden trains, electric streetcars or locomotives, youll find a number of great choices for any budget within this category.','','');

update productlines set htmlDescription='NULL' where productline in ('Cars','Motorcycles','Planes','Ships','Trains');
CREATE TABLE products (
  productCode varchar(15) NOT NULL,
  productName varchar(70) NOT NULL,
  productLine varchar(50) NOT NULL,
  productScale varchar(10) NOT NULL,
  productVendor varchar(50) NOT NULL,
  productDescription text NOT NULL,
  quantityInStock smallint NOT NULL,
  buyPrice decimal(10,2) NOT NULL,
  MSRP decimal(10,2) NOT NULL,
  PRIMARY KEY (productCode),
  CONSTRAINT pdt_fk_1 FOREIGN KEY (productLine) REFERENCES productlines (productLine)
);
insert into products values ('P101','Harley Davidson','Motorcycles','1:10','Motors Inc.','null','32',2537,725278),
('P102','Rolls Roys ghost','Cars','1:10','Car Stors Inc.','null','43',85527,122278),
('P103','ferrari','Cars','1:10','Ferrari Inc.','null','54',5723,88882),
('P104','Acela','Trains','1:10','Railway Inc.','null','30',53472,72000),
('P105','HMAS Vampire','Ships','1:10','Waterways inc','null','15',1337,5078),
('P106','Alaska Airlines','Planes','1:10','Airways inc','null','12',6570,86658);

CREATE TABLE orders (
  orderNumber int (10) NOT NULL,
  orderDate date NOT NULL,
  requiredDate date NOT NULL,
  shippedDate date DEFAULT NULL,
  status varchar(15) NOT NULL,
  comments text,
  customerNumber int (10) NOT NULL,
  PRIMARY KEY (orderNumber),
  CONSTRAINT ordr_fk_1 FOREIGN KEY (customerNumber) REFERENCES customers (customerNumber)
);
insert into orders values
(0101,'2003-01-06','2003-01-13','2003-01-10','Shipped',NULL,1001),
(0102,'2003-01-09','2003-01-18','2003-01-11','Shipped',NULL,1002),
(0103,'2021-07-10','2003-07-27','2003-01-14','On Progress',NULL,1003),
(0104,'2003-01-29','2003-02-07','2003-02-02','Shipped',NULL,1004),
(0105,'2003-01-31','2003-02-09','2003-02-01','Shipped',NULL,1005);

CREATE TABLE orderdetails (
  orderNumber int (10) NOT NULL,
  productCode varchar(15) NOT NULL,
  quantityOrdered smallint (5) NOT NULL,
  priceEach decimal(7,2) NOT NULL,
  orderLineNumber tinyint (3) NOT NULL,
  PRIMARY KEY (orderNumber,productCode),
  CONSTRAINT od_fk_1 FOREIGN KEY (orderNumber) REFERENCES orders (orderNumber),
  CONSTRAINT od_fk_2 FOREIGN KEY (productCode) REFERENCES products (productCode)
);
insert into orderdetails values
(0101,'P101',30,'136.00',3),
(0102,'P101',50,'55.09',2),
(0103,'P102',22,'75.46',4),
(0104,'P103',49,'35.29',1),
(0105,'P103',25,'108.06',4);

CREATE TABLE payments(
customerNumber int (10) NOT NULL,
checkNumber varchar (50) NOT NULL,
paymentDate date NOT NULL,
amount decimal (8,2) NOT NULL,
primary key (customerNumber,checkNumber),
constraint py_fk_1 foreign key (customerNumber) references customers (customerNumber)
);
insert into payments values
(1001,'HQ336336','2004-10-19','6066.78'),
(1002,'JM555205','2003-06-05','14571.44'),
(1003,'OM314933','2021-07-12','1676.14'),
(1004,'BO864823','2004-12-17','14191.12'),
(1005,'HQ55022','2003-06-06','32641.98');













