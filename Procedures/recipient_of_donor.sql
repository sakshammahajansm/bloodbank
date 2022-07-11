CREATE DEFINER=`root`@`localhost` PROCEDURE `recipient_of_donor`(donorID int)
BEGIN
select * from bloodtransaction bt
natural join recipient
where bt.donorID=donorID ;
END