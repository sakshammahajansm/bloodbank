CREATE DEFINER=`root`@`localhost` PROCEDURE `days_after_donation`(donorID int)
BEGIN
select CURRENT_DATE()-d.dateDonated as days_after_donation
from donor d
where d.donorID=donorID;
END