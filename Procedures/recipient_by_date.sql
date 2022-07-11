CREATE DEFINER=`root`@`localhost` PROCEDURE `recipient_by_date`(dateOut date)
BEGIN
select * from bloodtransaction bt
natural join recipient 
where bt.dateOut=dateOut;
END