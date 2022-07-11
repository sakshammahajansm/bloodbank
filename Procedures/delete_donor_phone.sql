CREATE DEFINER=`root`@`localhost` PROCEDURE `delete_donor_phone`(donorID int, phone varchar(20) )
BEGIN

declare count int;

select count(*) into count from donor_phone dp
where dp.donorID=donorID;

if(count>1) then
delete from donor_phone dp
where dp.donorID=donorID and dp.phone=phone;
end if;

select * 
from donor_phone;
END