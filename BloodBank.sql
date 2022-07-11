CREATE DATABASE `BloodBank` ;

use BloodBank;

-- Create Tables and Views
CREATE TABLE Donor(
donorID INT AUTO_INCREMENT,
firstName VARCHAR( 50 ) NOT NULL,
lastname VARCHAR( 50 ),
address VARCHAR( 60 ) NOT NULL,
city VARCHAR( 30 ) NOT NULL,
state VARCHAR( 30 ) NOT NULL,
country VARCHAR( 30 ) NOT NULL,
email VARCHAR( 100 ),
age INT NOT NULL CHECK(age >= 18 AND age <= 65),
bloodType varchar (3) NOT NULL,
gender char(1) NOT NULL,
dateDonated DATE NOT NULL,
disease INT DEFAULT '0' NOT NULL CHECK(disease=0),
PRIMARY KEY ( donorID )
);

CREATE TABLE Recipient(
recipientID INT AUTO_INCREMENT,
firstName VARCHAR( 50 ) NOT NULL,
lastname VARCHAR( 50 ),
address VARCHAR( 60 ) NOT NULL,
city VARCHAR( 30 ) NOT NULL,
state VARCHAR( 30 ) NOT NULL,
country VARCHAR( 30 ) NOT NULL,
email VARCHAR( 100 ),
age INT NOT NULL,
bloodType varchar (3) NOT NULL,
gender char(1) NOT NULL,
qty_asked INT DEFAULT '1' NOT NULL CHECK(qty_asked >= 1),
qty_out INT DEFAULT '0' NOT NULL CHECK(qty_out >= 0),
disease INT DEFAULT '0' NOT NULL,
PRIMARY KEY ( recipientID )
);

CREATE TABLE Donor_Phone(
donorID INT REFERENCES Donor,
phone VARCHAR( 20 ) NOT NULL,
PRIMARY KEY (donorID , phone)
);

CREATE TABLE Recipient_Phone(
recipientID INT REFERENCES Recipient,
phone VARCHAR( 20 ) NOT NULL,
PRIMARY KEY (recipientID , phone)
);

CREATE TABLE bloodTransaction(
donorID INT REFERENCES Donor,
recipientID INT REFERENCES Recipient,
dateOut DATE NOT NULL,
PRIMARY KEY(donorID)
);

ALTER TABLE recipient
ADD CONSTRAINT qty_limit CHECK ( qty_asked >= qty_out);

create view BloodStock as select
Donor.bloodType as 'Blood Type', 
count(*) as 'In Stock'from Donor
where Donor.donorID not in (select 
donorID from bloodTransaction)
group by bloodType;

create view recipientList as select * 
from recipient 
natural join recipient_phone;

create view donorList as select * 
from donor 
natural join donor_phone;

create view recipient_resolved as select * 
from recipient
where qty_asked=qty_out;

create view recipient_pending as select * 
from recipient
where qty_asked>qty_out;

create view donor_available as select *
from donor
where donorID not in (select donorID from bloodtransaction);

insert into donor(firstName,lastName,address,city,state,country,email,age,bloodType,gender,dateDonated,disease) values
('neeru','chawla',' 87, Janmabhoomi Rd, Opp Press, Fort','Mumbai','Maharashtra','India', 'neeru.bawa@yahoo.com', 20,'A+', 'f','2022-04-01',0),
('Paras',' Bhatia','Shop 7,Versova,Andheri(w)','Mumbai','Maharashtra','India', 'parasbhatia08@gmail.com',21,'A+','m','2022-04-02',0 ),
('Rakesh','Mehra', 'Shop 3, Trupti Apt, Sahar Road, Andheri (west)','Mumbai','Maharashtra','India', 'rakesh12@gmil.com',22,'A-','m', '2022-04-03',0),
('Sukhwinder','Sood','G 4, Ambika Terrace,Masjid Bunder (east)','Mumbai','Maharashtra','India', 'sunnysuyan@gmail.com',22,'A-','m', '2022-04-04',0),
('Manu','Phullar','Cb 365, Ring Road, Naraina','Delhi','Delhi','India', 'manpreetkaler@yahoo.com',20,'AB+', 'f','2022-04-05',0),
('Prabhjot','Kaur','20-4-1204/b,Lad Bazar','Hyderabad','Andhra Pradesh', 'India', 'prabh786@gmail.com', 30,'O+','m','2022-04-03',0);

insert into donor(firstName,lastName,address,city,state,country,email,age,bloodType,gender,dateDonated,disease) values 
('Jaspinder','Bhal','15-9-609, Mahaboobgunj','Hyderabad','Andhra Pradesh','India', 'singhjaspinder12@gmail.com', 24,'B+','m','2022-04-09',0),
('Sahil','Kumar','19, First Pycrofts Road, Royapettah','Chennai','Tamil Nadu','India', 'sahildubey@gmail.com', 20,'B+','m','2022-04-09',0),
('sonu','Singh','6, Amba Estate, Hathijan Road, Vatva','Ahemdabad','Gujarat','India', 'sonukhana34@gmail.com',  29,'B-','m','2022-04-10',0),
('Vinny','Sharma','1st Flr, Shri Hari Complex','Vadodra','Gujarat','India', 'vinny786@gmail.com',  27,'B-','m','2022-04-11',0),
('Rishav ','Bhatia',' Budhana Gate','Meerut','Uttar Pradesh', 'India', 'rbhatia@ymail.com', 24,'O-','m','2022-04-01',0),
('Rahul ','Bangar','29, 2 Cross, Sudhamanagar','Bangalore','Karnataka','India','raulban@gmail.com', 23,'O-','m','2022-04-02',0);

insert into donor(firstName,lastName,address,city,state,country,email,age,bloodType,gender,dateDonated,disease) values
('margret','chandna', '15-9-609, Mahaboobgunj','Hyderabad','Andhra Pradesh','India', 'manat@yahoo.com', 45,'O+','f','2022-04-01',0),
('Abhishek','Charisya','C4e/334, Janak Puri','Delhi','Delhi','India', 'abhi@ymail.com',24,'AB+','m', '2022-04-06',0),
('Ramanjeet',' Kaur','4e/5, Janak Puri','Delhi','Delhi','India',  'rbawa08@yahoo.com', 26, 'AB-','f', '2022-04-07',0),
('kuldip', 'Banga','4e/5, Jhandewalan Extn','Delhi','Delhi','India', 'kbanga@yahoo.com', 26, 'AB-','m','2022-04-08',0);

insert into donor_phone values 
(1,'9463958058'),(1,'9463958128'),(2,'7463958058'),(3,'9463958098'),(3,'9465658058'),(4,'9463909058'),
(5,'8463909058'),(6,'7463909058'),(7,'9673909058'),(8,'9463900058'),(8,'7663909058'),(9,'8763909058'),
(10,'9461209058'),(10,'9422909058'),(11,'7463978058'),(12,'8463909058'),(13,'9463907898'),
(14,'7443909058'),(15,'9464509058'),(14,'9436909058'),(16,'7234909058'),(16,'8663909058');

insert into recipient(firstName,lastName,address,city,state,country,email,age,bloodType,gender,qty_asked,disease) values
('Vansh','Bhal','15-9-609, Mahaboobgunj','Hyderabad','Andhra Pradesh','India', 'vansh12@gmail.com', 24,'A+','m',3,1),
('Ajeet','Kumar','19, First Pycrofts Road, Royapettah','Chennai','Tamil Nadu','India', 'ajeetkumar@gmail.com', 20,'B+','m',4,0),
('Raghav','Singh','6, Amba Estate, Hathijan Road, Vatva','Ahemdabad','Gujarat','India', 'raghav34@gmail.com',  29,'B-','m',2,0),
('Karan','Sharma','1st Flr, Shri Hari Complex','Vadodra','Gujarat','India', 'karan786@gmail.com',  27,'A-','m',5,0),
('Rithvik ','Bhatia',' Budhana Gate','Meerut','Uttar Pradesh', 'India', 'rbhatia@ymail.com', 24,'O-','m',1,1),
('Sagar ','Bangar','29, 2 Cross, Sudhamanagar','Bangalore','Karnataka','India','sagarban@gmail.com', 23,'O+','m',2,1),
('Aakash','Sood','G 4, Ambika Terrace,Masjid Bunder (east)','Mumbai','Maharashtra','India', 'aakashsood@gmail.com',22,'AB-','m',3,1),
('Ramanjeet',' Kaur','4e/5, Janak Puri','Delhi','Delhi','India',  'rbawa08@yahoo.com', 26, 'AB+','f', 4,0),
('Paras',' Bhatnagar','Shop 7,Versova,Andheri(w)','Mumbai','Maharashtra','India', 'paras@gmail.com',26,'A+','m',2,0 ),
('Abhi','Sharma','C4e/334, Janak Puri','Delhi','Delhi','India', 'sharma07@ymail.com',24,'AB+','m', 5,0);

insert into recipient_phone values 
(1,'8463958058'),(1,'8463958128'),(2,'9463958058'),(3,'8463958098'),(3,'7465658058'),(4,'8463909058'),
(5,'8463909058'),(5,'7463909058'),(6,'9673909058'),(8,'9463900058'),(7,'7663909058'),(7,'7763909058'),
(7,'8461209058'),(8,'7422909058');

select * from donor;

-- Queries for data manipulation and checking the expected results out of the Database.

-- days_after_donation(recipientID)
-- Returns the number of days passed since the dateDonated for the donorID
call days_after_donation(1);

select * from donor;
-- donor_available_bloodtype(bloodType)
-- Selects Available donors based on bloodType given as input parameter.
call donor_available_bloodtype("B+");

select * from donor;
-- donors_by_date(dateDonated)
-- Selects donors based on the dateDonated given as input parameter.
call donors_by_date("2022-04-02");

select * from donor;
select * from recipient;
-- balance_blood_transaction_all(recipientID)
-- Matches the donor and recipient based on bloodType, city,state and country
call balance_blood_transaction_all(9);

select * from bloodtransaction;
select * from recipient_resolved;
select * from recipient_pending;

-- donors_of_recipient(recipientID)
-- Will select all the donors that have donated blood to a particular recipientID
call donors_of_recipient(9);

-- recipient_by_date(dateOut)
-- Will select all recipients that have recieved blood on the dateOut date
call recipient_by_date("2022-04-13");

-- recipient_of_donor(donorID)
-- Will select the recipient that recieved blood from the donor
call recipient_of_donor(1);
call recipient_of_donor(2);

call balance_blood_transaction_all(9);
select * from bloodtransaction;

select * from recipient;
select * from donor;
-- balance_blood_transaction(recipientID)
-- Matches the donor and recipient based only on bloodType
call balance_blood_transaction(8);

select * from bloodtransaction;
select * from recipient_resolved;
select * from recipient_pending;

-- recipient_pending_bloodtype(bloodType)
-- Selects the recipients pending based on the bloodType
call recipient_pending_bloodtype("AB+");

/*
-- SELECT QUERIES

show tables;
select * from bloodstock;
select * from donor;
select * from donor_phone;
select * from recipient;
select * from recipient_phone;
select * from bloodstock;
select * from donor_available;
select * from donorlist;
select * from recipient_pending;
select * from recipient_resolved;
select * from recipientlist;
*/

-- Update Queries

select * from recipientlist;
-- update_recipient_credentials`(recipientID, qty_asked, disease, address, city, state, country,email,oldphone,newphone);
-- Will update the given parameters for the reciepientID
call update_recipient_credentials(1,4,0,'Shop 7,Versova,Andheri(w)','Mumbai','Maharashtra','India','bhal102@yahoo.com','8463958058','9876251123');

select * from donorlist;
-- update_donor_credential(donorID, email,oldphone,newphone)
-- Will update the given parameters for the donorID, rest of the parameters not considered since once donor has donated the blood at a particular
-- camp city, state, country cannot be changed
call update_donor_credential(1,'neeru293@yahoo.com','9463958058','7890123456');


-- Delete Queries

select * from donor_phone;
-- delete_donor_phone(donorID, phone)
-- Will delete the mentioned donor phone number only if there are more than one phone numbers in total for that donorID in database
call delete_donor_phone(3,'9463958098');
call delete_donor_phone(2,'7463958058');

select * from recipient_phone;
-- delete_recipient_phone(recipientID, phone)
-- Will delete the mentioned recipient phone number only if there are more than one phone numbers in total for that recipientID in database
call delete_recipient_phone(3,'8463958098');

-- Drop Queries

/*
drop view bloodstock;
drop view donor_available;
drop view donorlist;
drop view recipient_pending;
drop view recipient_resolved;
drop view recipientlist;
drop table donor;
drop table donor_phone;
drop table recipient;
drop table recipient_phone;
drop table bloodTransaction;
*/
-- drop database bloodbank;