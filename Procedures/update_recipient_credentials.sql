CREATE DEFINER=`root`@`localhost` PROCEDURE `update_recipient_credentials`(recipientID int, qty_asked int, disease int, address varchar(60), city varchar(30), state varchar(30), country varchar(30),email varchar(100),oldphone varchar(20),newphone varchar(20))
BEGIN
declare r_qty_out int;

select r.qty_out into r_qty_out 
from recipient r
where r.recipientID=recipientID;

update recipient r
set r.disease = disease,r.address=address,r.city=city, r.state=state, r.country=country, r.email=email
where r.recipientID = recipientID;

if(qty_asked>=r_qty_out) then
update recipient r
set r.qty_asked=qty_asked
where r.recipientID = recipientID;
end if;

update recipient_phone r
set phone=newphone
where r.recipientID=recipientID and r.phone=oldphone;

select * 
from recipientlist r 
where r.recipientID=recipientID;

END