CREATE DEFINER=`root`@`localhost` PROCEDURE `recipient_pending_bloodtype`(bloodType varchar(3))
BEGIN
select * from recipient_pending r 
where r.bloodType=bloodType;

END