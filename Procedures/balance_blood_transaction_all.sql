CREATE DEFINER=`root`@`localhost` PROCEDURE `balance_blood_transaction_all`(recipientID int)
BEGIN
declare count int;
declare ID int;
declare r_city varchar(30);
declare r_state varchar(30);
declare r_country varchar(30);
declare r_qty_left int ;
declare r_bloodtype varchar(3);

select r.city, r.state, r.country, r.qty_asked-r.qty_out,r.bloodType into 
r_city, r_state, r_country, r_qty_left,r_bloodType from recipient r
where r.recipientID=recipientID;

select count(*) into count from 
donor_available d where 
d.city=r_city and  d.state=r_state and d.country=r_country and d.bloodType=r_bloodType;

if(count!=0 and count >=r_qty_left and r_qty_left>0) then
while(r_qty_left !=0) do

select donorID into ID from 
donor_available d where 
d.city=r_city and  d.state=r_state and d.country=r_country and d.bloodType=r_bloodType
limit 1;

insert into bloodtransaction
values (ID,recipientID, current_date());

update recipient r
set qty_out=qty_out+1
where r.recipientID=recipientID;

set r_qty_left=r_qty_left-1;
end while;

select * from bloodtransaction bt
natural join donor d
where bt.recipientID=recipientID and dateOut=current_date();

elseif(count!=0 and count < r_qty_left and r_qty_left>0) then
while(count !=0) do

select donorID into ID from 
donor_available d where 
d.city=r_city and  d.state=r_state and d.country=r_country and d.bloodType=r_bloodType
limit 1;

insert into bloodtransaction
values (ID,recipientID, current_date());

update recipient r
set qty_out=qty_out+1
where r.recipientID=recipientID;

set count=count-1;
end while;

select * from bloodtransaction bt
natural join donor d
where bt.recipientID=recipientID and dateOut=current_date();

end if;
END