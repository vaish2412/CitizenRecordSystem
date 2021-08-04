USE CitizenRecordManagement

--TABLE LEVEL CONSTRATINT
CREATE FUNCTION restrictGoodSamaritan
(@NationID int)
RETURNS smallInt
AS 
BEGIN
	DECLARE @output smallInt =0;
	SELECT @output = COUNT(NationID)
	FROM 
	dbo.CriminalRecord
	WHERE CurrentStatus = 1 AND NationID = @NationID;
	RETURN @Output
END;


ALTER TABLE dbo.GoodSamaritanRecord ADD CONSTRAINT restrictCriminalEntry CHECK 
(dbo.restrictGoodSamaritan(NationID)=0)