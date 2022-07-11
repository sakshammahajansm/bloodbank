CREATE DEFINER=`root`@`localhost` PROCEDURE `donors_of_recipient`(recipientID int)
BEGIN
select * from bloodtransaction bt
natural join donor d
where bt.recipientID=recipientID;
END