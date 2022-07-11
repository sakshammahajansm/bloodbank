CREATE DEFINER=`root`@`localhost` PROCEDURE `update_donor_credential`(donorID int, email varchar(100),oldphone varchar(20),newphone varchar(20) )
BEGIN
update donor d
set d.email=email
where d.donorID = donorID;

update donor_phone d
set phone=newphone
where d.donorID=donorID and d.phone=oldphone;

select * 
from donorlist d 
where d.donorID=donorID;
END