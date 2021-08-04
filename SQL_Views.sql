USE CitizenRecordManagement

-- VIEW - 1 ( All In One View)
--SELECT * FROM AllInOneViews 
-- House Keeping
DROP VIEW IF EXISTS AllInOneView;
-- View Creation
CREATE VIEW AllInOneView WITH SCHEMABINDING
AS 
SELECT gr.NationID,FirstName, LastName, DateofBirth, CommunicableDiseases, MedicalCheckupDate, AchievementName, DateOfExit, 
CountryVisited, FIRNumber, CurrentStatus, CompanyName, CurrentSalary, VehicleNumber, VehicleType, PropertyValue,
Location, ElectricityConsumption,GasConsumption, WaterConsumption, BankName, AccountNumber, CollegeName,
colr.State AS CollegeState, SchoolName, sr.State AS SchoolState
FROM
dbo.GeneralRecord gr LEFT JOIN dbo.HealthRecord hr
ON gr.NationID = hr.NationID
LEFT JOIN dbo.GoodSamaritanRecord gsr
ON gr.NationID = gsr.NationID
LEFT JOIN dbo.AchievementRecord  ar
ON gsr.AchievementID = ar.AchievementID
LEFT JOIN dbo.TravelRecord tr
ON tr.NationID = gr.NationID
LEFT JOIN dbo.CriminalRecord cr
ON cr.NationID = gr.NationID
LEFT JOIN dbo.GeneralCompanyRecord gcr
ON gcr.NationID = gr.NationID
LEFT JOIN dbo.CompanyRecord com
ON com.CompanyID = gcr.CompanyID
LEFT JOIN dbo.VehicleRecord vr
ON vr.NationID = gr.NationID
LEFT JOIN dbo.PropertyDetails pd
ON pd.NationID = gr.NationID
LEFT JOIN dbo.GeneralSchoolRecord gscr
ON gscr.NationID = gr.NationID
LEFT JOIN dbo.SchoolRecord sr
ON sr.SchoolID = gscr.SchoolID
LEFT JOIN dbo.GeneralCollegeRecord gcolr
ON gcolr.NationID = gr.NationID
LEFT JOIN dbo.CollegeRecord colr
ON colr.CollegeID = gcolr.CollegeID
LEFT JOIN dbo.UtilityRecord ur
ON ur.NationID = gr.NationID
LEFT JOIN dbo.GeneralBankRecord gbr
ON gr.NationID = gbr.NationID
LEFT JOIN dbo.BankRecord br
ON br.BankID = gbr.BankID

GO

SELECT * FROM AllInOneView 
-- View 2 (CommunicableDiesease View)

-- House Keeping
DROP VIEW IF EXISTS CommunicableDiseasesView
-- View Creation
CREATE VIEW CommunicableDiseasesView WITH SCHEMABINDING
AS
SELECT gr.NationID, FirstName, LastName, Gender, DateOfBirth, MedicalCheckupDate,CommunicableDiseases,
CountryVisited,DateofEntry, DateofExit FROM
dbo.GeneralRecord gr LEFT JOIN dbo.HealthRecord hr
ON gr.NationID = hr.NationID
LEFT JOIN dbo.TravelRecord tr
ON gr.NationID = tr.NationID

GO

SELECT * FROM CommunicableDiseasesView