CREATE DEFINER=`root`@`localhost` PROCEDURE `donors_by_date`(dateDonated date)
BEGIN
select * 
from donor dl
where dl.dateDonated=dateDonated;
END