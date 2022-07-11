CREATE DEFINER=`root`@`localhost` PROCEDURE `delete_recipient_phone`(recipientID int, phone varchar(20))
BEGIN
declare count int;

select count(*) into count from recipient_phone rp
where rp.recipientID=recipientID;

if(count>1) then
delete from recipient_phone rp
where rp.recipientID=recipientID and rp.phone=phone;
end if;
select * 
from recipient_phone;
END