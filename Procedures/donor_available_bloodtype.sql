CREATE DEFINER=`root`@`localhost` PROCEDURE `donor_available_bloodtype`(bloodType varchar(3))
BEGIN
select * from donor_available d
where d.bloodType=bloodType;
END