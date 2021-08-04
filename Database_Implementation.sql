fCREATE DATABASE CitizenRecordManagement
USE CitizenRecordManagement

CREATE TABLE GeneralRecord
(NationID INT NOT NULL,
FirstName VARCHAR(20) NOT NULL,
LastName VARCHAR(20) NOT NULL,
DateofBirth DATE NOT NULL,
Gender VARCHAR(10) NOT NULL,
PhoneNumber VARCHAR(20) NOT NULL,
EmailID VARCHAR(70),
Qualification VARCHAR(45),
PanNumber VARCHAR(15),
WorkStatus BIT,
CityofBirth VARCHAR(30),
PassportNumber VARCHAR(15),
StreetNumber VARCHAR(10),
City VARCHAR(45) NOT NULL,
State VARCHAR(45) NOT NULL,
Country VARCHAR(45) NOT NULL,
ZipCode VARCHAR(45) NOT NULL,
DateofDeath DATE NULL,
Age as DATEDIFF(hour,dateofbirth,getdate())/8766 ,
CumulativeAchievment AS dbo.fn_Achievementcount(NationID)
CONSTRAINT PK_GeneralRecord PRIMARY KEY(NationID));


CREATE TABLE SchoolRecord
(SchoolID VARCHAR(45) NOT NULL,
SchoolName VARCHAR(200) NOT NULL,
StreetNumber VARCHAR(10),
City VARCHAR(30) NOT NULL,
State VARCHAR(45) NOT NULL,
Country VARCHAR(45) NOT	NULL,
ZipCode VARCHAR(45) NOT NULL
CONSTRAINT PK_SchoolRecord PRIMARY KEY(SchoolID));


CREATE TABLE GeneralSchoolRecord
(NationID INT NOT NULL,
SchoolID VARCHAR(45) NOT NULL
CONSTRAINT PK_GeneralSchoolRecord PRIMARY KEY(NationID,SchoolID),
CONSTRAINT FK_GeneralSchoolRecordNationID FOREIGN KEY (NationID) REFERENCES GeneralRecord (NationID),
CONSTRAINT FK_GeneralSchoolRecordSchoolID FOREIGN KEY (SchoolID) REFERENCES SchoolRecord(SchoolID)
);


CREATE TABLE CollegeRecord
(CollegeID VARCHAR(45) NOT NULL,
CollegeName VARCHAR(200) NOT NULL,
StreetNumber VARCHAR(10),
City VARCHAR(30) NOT NULL,
State VARCHAR(45) NOT NULL,
Country VARCHAR(45) NOT NULL,
ZipCode VARCHAR(45) NOT NULL
CONSTRAINT PK_CollegeRecord PRIMARY KEY(CollegeID));


CREATE TABLE GeneralCollegeRecord
(NationID INT NOT NULL,
CollegeID VARCHAR(45) NOT NULL,
CONSTRAINT PK_GeneralCollegeRecord PRIMARY KEY(NationID,CollegeID),
CONSTRAINT FK_GeneralCollegeRecordNationID FOREIGN KEY (NationID) REFERENCES GeneralRecord (NationID),
CONSTRAINT FK_GeneralCollegeRecordCollegeID FOREIGN KEY (CollegeID) REFERENCES CollegeRecord(CollegeID)
);


CREATE TABLE HealthRecord
(
HealthID Varchar(45) NOT NULL,
NationID Int not null,
BMI float,
BloodGroup varchar(10),
MedicalCheckupDate Date,
HealthPolicyNumber varchar(15),
HealthInsurerName varchar(50),
CommunicableDiseases BIT NOT NULL,
PatientSummary Varchar(100),
CONSTRAINT PK_HealthRecord PRIMARY KEY(HealthID,NationID),
CONSTRAINT FK_HealthRecordNationID FOREIGN KEY (NationID) REFERENCES GeneralRecord (NationID)
);


CREATE TABLE BankRecord
(BankID VARCHAR(45) NOT NULL,
BankName VARCHAR(45) NOT NULL,
IFSC VARCHAR(45) NOT NULL,
BranchName VARCHAR(45) NOT NULL
CONSTRAINT PK_BankRecord PRIMARY KEY(BankID));


CREATE TABLE GeneralBankRecord
(
NationID INT NOT NULL,
AccountNumber Varchar(50) NOT NULL,
BankID VARCHAR(45) NOT NULL,
CONSTRAINT PK_GeneralBankRecord PRIMARY KEY clustered (AccountNumber,NationID,BankID),
CONSTRAINT FK_GeneralBankRecordNationID FOREIGN KEY (NationID) REFERENCES GeneralRecord (NationID),
CONSTRAINT FK_GeneralBankRecordBankID FOREIGN KEY (BankID) REFERENCES Bankrecord (BankID)
);


CREATE TABLE UtilityRecord
(
UtilityID INT NOT NULL,
ConsumptionPeriod DATE NOT NULL,
ElectricityConsumption FLOAT NOT NULL,
WaterConsumption FLOAT NOT NULL,
GasConsumption FLOAT,
NationID INT NOT NULL
CONSTRAINT PK_UtilityRecord PRIMARY KEY(UtilityID,NationID),
CONSTRAINT FK_UtilityRecordNationID FOREIGN KEY(NationID) REFERENCES GeneralRecord(NationID));

USE CitizenRecordManagement
CREATE TABLE PropertyDetails
(PropertyID VARCHAR(45) NOT NULL,
PropertyOwned VARCHAR(45) NOT NULL,
Area FLOAT NOT NULL,
Location VARCHAR(20) NOT NULL,
PropertyValue BIGINT NOT NULL,
PropertyTax INT NOT NULL,
NationID INT NOT NULL
CONSTRAINT PK_PropertyDetails PRIMARY KEY(PropertyID,NationID),
CONSTRAINT FK_PropertyDetailsNationID FOREIGN KEY(NationID) REFERENCES GeneralRecord(NationID));


CREATE TABLE VehicleRecord
(VehicleID VARCHAR(30) NOT NULL,
VehicleNumber VARCHAR(45) NOT NULL,
VehicleType VARCHAR(45),
FuelType VARCHAR(20),
EngineNumber VARCHAR(45) NOT NULL,
ChassisNumber VARCHAR(45) NOT NULL,
VehicleInsurerName VARCHAR(200),
VehiclePolicyNumber VARCHAR(45),
NationID INT NOT NULL,
CONSTRAINT PK_VehicleRecord PRIMARY KEY(VehicleID,NationID),
CONSTRAINT FK_VehicleRecordNationID FOREIGN KEY(NationID) REFERENCES GeneralRecord(NationID));


CREATE TABLE CompanyRecord
(CompanyID VARCHAR(45) NOT NULL,
CompanyName VARCHAR(45) NOT NULL
CONSTRAINT PK_CompanyRecord PRIMARY KEY(CompanyID));


CREATE TABLE GeneralCompanyRecord
(NationID INT NOT NULL,
CompanyID VARCHAR(45) NOT NULL,
DateOfJoining DATE NOT NULL,
DateOfReleving DATE,
Designation VARCHAR(45) NOT NULL,
CurrentSalary INT,
Skills VARCHAR(45)
CONSTRAINT PK_GeneralCompanyRecord PRIMARY KEY(NationID,CompanyID),
CONSTRAINT FK_GeneralCompanyRecorddNationID FOREIGN KEY (NationID) REFERENCES GeneralRecord (NationID),
CONSTRAINT FK_GeneralCompanyRecordCompanyID FOREIGN KEY (CompanyID) REFERENCES CompanyRecord(CompanyID));


CREATE TABLE CriminalRecord(
CrimeID VARCHAR(45) NOT NULL,
FIRNumber VARCHAR(45) NOT NULL,
Section VARCHAR(10),
TypeOfCrime VARCHAR(20),
CurrentStatus BIT NOT NULL,
NationID INT NOT NULL
CONSTRAINT PK_CriminalRecord PRIMARY KEY (CrimeID,NationID),
CONSTRAINT FK_CriminalRecordNationID FOREIGN KEY(NationID) REFERENCES GeneralRecord(NationID));


CREATE TABLE TravelRecord
(TravelID VARCHAR(45) NOT NULL,
CountryVisited VARCHAR(45) NOT NULL,
DateofEntry DATE NOT NULL,
DateofExit DATE,
TravelInsuranceNumber VARCHAR(45),
TravelInsurerName VARCHAR(45),
NationID INT NOT NULL
CONSTRAINT PK_TravelRecord PRIMARY KEY(TravelID,NationID),
CONSTRAINT FK_TravelRecordNationID FOREIGN KEY(NationID) REFERENCES GeneralRecord(NationID));


CREATE TABLE AchievementRecord
(AchievementID VARCHAR(45) NOT NULL,
AchievementName VARCHAR(45) NOT NULL
CONSTRAINT PK_AchievementRecord PRIMARY KEY(AchievementID));

CREATE TABLE GoodSamaritanRecord
(NationID INT NOT NULL,
AchievementID VARCHAR(45) NOT NULL
CONSTRAINT PK_GoodSamaritanRecord PRIMARY KEY(NationID,AchievementID),
CONSTRAINT FK_GoodSamaritanRecordNationID FOREIGN KEY(NationID) REFERENCES GeneralRecord(NationID),
CONSTRAINT FK_GoodSamaritanRecordAchievementID FOREIGN KEY(AchievementID) REFERENCES AchievementRecord(AchievementID));
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--INSERT STATEMENTS FOR GENERALRECORD

Insert Into GeneralRecord Values(1,'Sara','Dsouza','1986-05-01','Female','8123725753','d.sara@gmail.com','B.E','AAECC6548C','1','Goa','J8369854','15A','Goa','Goa','India','403110',NULL)
Insert Into GeneralRecord Values(2, 'Neha', 'Sharma','1972/09/28', 'Female','9345678658', 'sharma.neha72@hotmail.com', 'B.COM', 'BNZPM2501F', '1', 'Delhi', 'J5498883', '1C', 'Chandigarh','Chandigarh', 'India', '160005',NULL)
Insert Into GeneralRecord Values(3, 'Rakesh', 'Kumar', '1991/10/14', 'Male','7645783546','rakeshkumar14@yahoo.com','CA', 'ABCD1234A', '1', 'Mumbai', 'N1242853', '44C', 'Mumbai','Maharashtra', 'India', '400002',NULL)
Insert Into GeneralRecord Values(4, 'Andrew', 'Symonds', '1958/03/15', 'Male', '9987653421','andrew15symonds@gmail.com', 'B.SC', 'AQDPP8277H', '1', 'Cochin', 'N4017151', '12D', 'Chennai','Tamil Nadu','India', '682001', '12-04-19')
Insert Into GeneralRecord Values(5, 'Richard', 'Parker', '1990/12/11', 'Male','6789334567', 'rp11@outlook.com', 'M.A', 'BLUPS4233F', '1', 'Chennai', 'F7802033', '7A', 'Bangalore','Karnataka','India',  '560078',NULL)
Insert Into GeneralRecord Values(6, 'Raksha', 'Ramkumar', '1997-10-05','Female','8721908009','raksharamkumar@gmail.com', 'B.E', 'BAWIPP1078K', '1', 'Bangalore', 'FH2004824', '8A', 'Bangalore','Karnataka', 'India',  '560068',NULL)
Insert Into GeneralRecord Values(7, 'Paul', 'Wesley', '1982-07-23','Male','7213425789','wesleypaul2307@gmail.com', 'BBA', 'AABTG6381M', '0', 'Pune', 'H9137927', '7D', 'Pune', 'Maharashtra','India','400003',NULL)
Insert Into GeneralRecord Values(8, 'Ritika', 'Ahuja', '1999/12/31','Female','9704358558','ritikaa1999@gmail.com', 'B.COM', 'AAECB2434L', '0', 'Mumbai', 'F6494641', '11B', 'Kolkata', 'West Bengal','India',  '700027',NULL)
Insert Into GeneralRecord Values(9, 'Anusha', 'Rao', '1992/07/13','Female','9538283441','raoanusha@gmail.com', 'MS', 'AAMTS2433L', '1', 'Bangalore', 'H3925627', '6C', 'Hyderabad','Telangana', 'India',  '500001',NULL)
Insert Into GeneralRecord Values(10, 'Sachin', 'Tendulkar', '1973/04/24','Male','8356478921','sachintendulkar@gmail.com', 'High School', 'AAJFN2389N', '0', 'Mumbai', 'M1278934', 'C37', 'Ahemadabad','Gujarat', 'India','320008',NULL)
Insert Into GeneralRecord Values(11, 'Manasa', 'Narayan', '1997/05/19','Female','6225789220','nmanasa@gmail.com', 'B.E', 'BOXPA789WE', '1', 'Kanpur', 'F9876234', '17E', 'Kanpur','Uttar Pradesh', 'India','208001',NULL)
Insert Into GeneralRecord Values(12, 'Parul', 'Herur', '1997/10/29','Female','8892638464','parulherur@gmail.com', 'MBBS', 'MNO98765RT', '0', 'Coimbatore', 'B3457892', '9B', 'Chennai','Tamil Nadu', 'India','682001',NULL)
Insert Into GeneralRecord Values(13, 'Alex', 'Pinto', '1963/08/12','Male','7843567821','alexp@gmail.com', 'Diploma', 'ABX9873ELM', '0', 'Shimla', 'UYT78932', '32R', 'Shimla','Himachal Pradesh', 'India','176001','2016-09-29')
Insert Into GeneralRecord Values(14, 'Nupur', 'Singh', '1975/05/05','Female','9987635467','nupursingh@gmail.com', 'PhD', 'LMNY87546R', '1', 'New Delhi', 'BZ987387', 'M23', 'New Delhi','New Delhi', 'India','110001',NULL)
Insert Into GeneralRecord Values(15, 'Vandana', 'Kapoor', '1998/01/09','Female','8763897651','vandyk@gmail.com', 'B.E', 'BMWX234561', '1', 'Amritsar', 'BCD123678', '128F', 'Amritsar','Punjab', 'India','1110034',NULL)
Insert Into GeneralRecord Values(16, 'Nishanth', 'Marer', '1997/07/04','Male','786543891','nishanthp@gmail.com', 'LLB', 'NMW1234561', '1', 'Jaipur', 'VNMK3456', '42H', 'Jaipur','rajasthan', 'India','720089',NULL)
Insert Into GeneralRecord Values(17, 'Shekhar', 'Jaganath', '1997/08/02','Male','6789453651','shekharj@gmail.com', 'BCom', 'MNO123789H', '1', 'Shillong', 'APS89345', '100Z', 'Shillong','Meghalaya', 'India','793001',NULL)
Insert Into GeneralRecord Values(18, 'Prithviraj', 'Chauhan', '1981/12/04','Male','8764532899','prithvic@gmail.com', 'High School', 'FCJ7835679', '1', 'Patna', 'LMNO9863', '122C', 'Patna','Bihar', 'India','800001',NULL)
Insert Into GeneralRecord Values(19, 'Sneha', 'Ravichandran', '1996/08/16','Female','9978653429','snehar@gmail.com', 'B.E', 'KHM9876310', '1', 'Srinagar', 'PQR87678', '78T', 'Srinagar','Jammu & Kashmir', 'India','180001',NULL)
Insert Into GeneralRecord Values(20, 'Vaishnavi', 'Gadve', '1995/04/22','Female','8976578009','vaishnavigadve@gmail.com', 'B.E', 'HIJ3456789', '1', 'Raipur', 'XYZ9876A', '56B', 'Raipur','Chattisgargh', 'India','490042',NULL)
Insert Into GeneralRecord Values(21, 'Preeti', 'Tiwari', '1991/02/12','Female','7825990811','preetitiwari@gmail.com', 'MBA', 'UVW67892', '1', 'Bhopal', 'IJK98765', '201A', 'Bhopal','Madhya Pradesh', 'India','569870',NULL)
Insert Into GeneralRecord Values(22, 'Tanisha', 'Chatterjee', '1979/02/28','Female','6789234561','tanishachatterjee@gmail.com', 'Graduate', 'EFG678234Q', '0', 'Tripura', 'BKC78976', '1W', 'Tripura','Agartala', 'India','890011',NULL)
Insert Into GeneralRecord Values(23, 'Pritha', 'Bisarad', '1992/01/14','Female','6786539901','prithabisarad@gmail.com', 'Mcom', 'GKJH763900', '1', 'Dehradun', 'ABV23908', 'W23', 'Dehradun','Uttrakhand', 'India','432009',NULL)
Insert Into GeneralRecord Values(24, 'Anjali', 'Chaudhary', '1989/06/06','Female','9789356789','anjalichaudhary@gmail.com', 'Bsc', 'SDW8976221', '0', 'Bhubaneshwar', 'BNU89733', 'W2B', 'Cuttack','Orrissa', 'India','560098',NULL)
Insert Into GeneralRecord Values(25, 'Rahul', 'Mishra', '1994/05/21','Male','7634257831','rahulmishra@gmail.com', 'Diploma', 'TRE789012W', '0', 'Kota', 'BCD45678', 'BB9', 'Kota','Rajasthan', 'India','890034',NULL)
Insert Into GeneralRecord Values(26, 'Bipin', 'Yadav', '1990/12/31','Male','6789124567','vbipinyadav@gmail.com', 'MA', 'TRA678390W', '1', 'Gwalior', 'JKL76499', '89J', 'Gwalior','Madhya Pradesh', 'India','760089',NULL)
Insert Into GeneralRecord Values(27, 'Vicky', 'Kaushal', '1970/11/13','Male','876234900','vickykaushal@gmail.com', 'B.E', 'NMJ984568L', '1', 'Bokaro', 'FGT89011', '39UN', 'Bokaro','Jharkhand', 'India','890034',NULL)
Insert Into GeneralRecord Values(28, 'Rajkumar', 'Rao', '1981/09/11','Male','9980012002','rajrao@gmail.com', 'CA', 'JHU98077UM', '1', 'Darjeeling', 'BNS90825', 'MNC4', 'Darjeeling','West Bengal', 'India','600121',NULL)
Insert Into GeneralRecord Values(29, 'Amar', 'Kumar', '1986/11/14','Male','6009234561',',amar123@gmail.com', 'Mcom', 'JNU12478UK', '1', 'Gangtok', 'VVR00123', '221B', 'Gangtok','Sikkim', 'India','760001',NULL)
Insert Into GeneralRecord Values(30, 'Manjot', 'Bhullar', '1999/08/15','Male','8907929292','bhullarmanjot@gmail.com', 'High School', 'YMC23458IL', '0', 'Nainital', 'HUI98763', '89K', 'Mussorie','Uttrakhand', 'India','120098',NULL)

--INSERT STATEMENTS FOR COMPANYRECORD
Insert Into CompanyRecord values('ACCN','Accenture')
Insert Into CompanyRecord values('COGN','Cognizant')
Insert Into CompanyRecord values('INFY','Infosys')
Insert Into CompanyRecord values('GS','Goldman Sachs')
Insert Into CompanyRecord values('ALGS','AllGosystems')
Insert Into CompanyRecord values('TCS','Tata Consultancies')
Insert Into CompanyRecord values('MOS','Microsoft')
Insert Into CompanyRecord values('GGL','Google')
Insert Into CompanyRecord values('JPMC','JP Morgan Chase')
Insert Into CompanyRecord values('CDS','Cadence Design Systems')
Insert Into CompanyRecord values('MSTRL','Mistral Soultions')
Insert Into CompanyRecord values('SSFT','Surya Software')
Insert Into CompanyRecord values('BTSS','Bestsol Soultions')

--INSERT STATEMENTS FOR GENERALSCHOOLRECORD
Insert Into GeneralSchoolRecord values(2,'HPSR')
Insert Into GeneralSchoolRecord values(1,'DPSN')
Insert Into GeneralSchoolRecord values(5,'CARM')
Insert Into GeneralSchoolRecord values(4,'APS')
Insert Into GeneralSchoolRecord values(4,'DAV')
Insert Into GeneralSchoolRecord values(4,'HPSR')
Insert Into GeneralSchoolRecord values(6,'LFS')
Insert Into GeneralSchoolRecord values(7,'BVBS')
Insert Into GeneralSchoolRecord values(10,'NHVPS')
Insert Into GeneralSchoolRecord values(3,'AGCS')
Insert Into GeneralSchoolRecord values(8,'NHVPS')
Insert Into GeneralSchoolRecord values(1,'BNM')
Insert Into GeneralSchoolRecord values(7,'SKCH')
Insert Into GeneralSchoolRecord values(11,'JKV')
Insert Into GeneralSchoolRecord values(12,'DAV')
Insert Into GeneralSchoolRecord values(13,'DPSN')
Insert Into GeneralSchoolRecord values(14,'BVBS')
Insert Into GeneralSchoolRecord values(15,'SKCH')
Insert Into GeneralSchoolRecord values(16,'SKCH')
Insert Into GeneralSchoolRecord values(17,'HPSR')
Insert Into GeneralSchoolRecord values(18,'BNM')
Insert Into GeneralSchoolRecord values(19,'APS')
Insert Into GeneralSchoolRecord values(20,'JKV')
Insert Into GeneralSchoolRecord values(21,'OXHS')
Insert Into GeneralSchoolRecord values(22,'AGCS')
Insert Into GeneralSchoolRecord values(23,'NBPS')
Insert Into GeneralSchoolRecord values(24,'OXHS')
Insert Into GeneralSchoolRecord values(25,'LFS')
Insert Into GeneralSchoolRecord values(26,'CARM')
Insert Into GeneralSchoolRecord values(27,'DAV')
Insert Into GeneralSchoolRecord values(28,'JKV')
Insert Into GeneralSchoolRecord values(29,'LFS')
Insert Into GeneralSchoolRecord values(30,'HPSR')


--INSERT STATEMENTS FOR SCHOOLRECORD
Insert Into SchoolRecord values('HPSR','Hyderabad Public School','44A','Hyderabad','Telangana','India','560098')
Insert Into SchoolRecord values('DPSN','Delhi Public School North','2D','Delhi','Delhi','India','700001')
Insert Into SchoolRecord values('CARM','Carmel High School','23D','Bangalore','Karnataka','India','500078')
Insert Into SchoolRecord values('APS','Albert Public School','12A','Cochin','Kerala','India','430023')
Insert Into SchoolRecord values('LFS','Little Flower School','4D','Bangalore','Karnataka','India','560078')
Insert Into SchoolRecord values('BVBS','Bhartiya Vidhya Bhavans School','223E','Pune','Maharashtra','India','320087')
Insert Into SchoolRecord values('AGCS','Assembly of God Church School','10M','Mumbai','Maharashtra','India','432001')
Insert Into SchoolRecord values('NBPS','Nava Bharath Public School','23D','Kolkata','West Bengal','India','500001')
Insert Into SchoolRecord values('BNM','Bhageerathibai Narayanrao Maney','15D','God','Goa','India','570072')
Insert Into SchoolRecord values('SKCh','Shri Kumarans Children Home','1A','Bangalore','Karnataka','India','652001')
Insert Into SchoolRecord values('DAV','Dayanand Aglo Vedic','25V','Chennai','Tamil Nadu','India','654898')
Insert Into SchoolRecord values('NHVPS','National Hill View Public School','23D','Ahemadabad','Gujrat','India','540021')
Insert Into SchoolRecord values('JKV','Jyothi Kendriya Vidhyalay','14D','Patna','bihar','India','560098')
Insert Into SchoolRecord values('OXHS','Oxford High School','13B','Raipur','chattisgargh','India','439001')


--INSERT STATEMENTS FOR GENERALCOMPANYRECORD
Insert into GeneralCompanyRecord values(1,'JPMC','2018-07-07', NULL,'Sr.Software Developer',1100000,'Java')
Insert into GeneralCompanyRecord values(1,'ACCN','2011/04/02','2018/06/19','Associate Software Engineer',800000,'Perl')
Insert into GeneralCompanyRecord values(2,'MOS','2016/05/10',NULL,'Software Development Engineer',1500000,'Python')
Insert into GeneralCompanyRecord values (2,'TCS','2014/03/23','2016/04/01','DevOps Engineer',700000,'Python')
Insert into GeneralCompanyRecord values(2,'INFY','2010/01/15','2014/02/28','Business Development Associate',540000,'SQL')
Insert into GeneralCompanyRecord values(3,'ACCN','2015/08/15',NULL,'Accounts Manager',900000,'Java')
Insert into GeneralCompanyRecord values(4,'MOS','1999/11/13','2019/01/04','Production Manager',3000000,'C')
Insert into GeneralCompanyRecord values(4,'GS','1996/06/19','1999/10/20','Project Manager',1200000,'Ruby')
Insert into GeneralCompanyRecord values(5,'COGN','2012/07/15',NULL,'Senior Program Analyst',950000,'R')
Insert into GeneralCompanyRecord values(6,'ALGS','2019/07/05',NULL,'Software Developer',550000,'.net')
Insert into GeneralCompanyRecord values(7,'GS','2009/05/12',NULL,'Manager',1600000,'.Spark')
Insert into GeneralCompanyRecord values(9,'MOS','2019/03/07',NULL,'AI Engineer',2200000,'Matlab')
Insert into GeneralCompanyRecord values(9,'JPMC','2015/07/24','2013-02-19','Application Development Engineer',1400000,'C#')
Insert into GeneralCompanyRecord values(11,'MSTRL','2015/07/24',NULL,'Software Engineer',550000,'R')
Insert into GeneralCompanyRecord values(14,'MOS','2015/07/24',NULL,'Director of Technical Operations',2400000,'Java')
Insert into GeneralCompanyRecord values(15,'SSFT','2015/07/24',NULL,'Technical Support Engineer',440000,'C')
Insert into GeneralCompanyRecord values(16,'JPMC','2015/07/24',NULL,'Financial Advisor',770000,'Accounts')
Insert into GeneralCompanyRecord values(17,'COGN','2015/07/24',NULL,'Associate Accountant',375000,'Statistics')
Insert into GeneralCompanyRecord values(18,'ACCN','2015/07/24',NULL,'Driver',250000,Null)
Insert into GeneralCompanyRecord values(19,'INFY','2015/07/24',NULL,'Associate Software Engineer',650000,'Python')
Insert into GeneralCompanyRecord values(20,'ALGS','2015/07/24',NULL,'Business Analyst',660000,'SQL')
Insert into GeneralCompanyRecord values(21,'GS','2015/07/24',NULL,'ABusiness Development Associate',1000000,'Marketing')
Insert into GeneralCompanyRecord values(23,'TCS','2015/07/24',NULL,'ML Engineer',980000,'Machine Learning')
Insert into GeneralCompanyRecord values(26,'TCS','2015/07/24',NULL,'HR',800000,Null)
Insert into GeneralCompanyRecord values(27,'ALGS','2015/07/24',NULL,'Hardware Engineer',1900000,'Embedded Systems#')
Insert into GeneralCompanyRecord values(28,'MSTRL','2015/07/24',NULL,'Accounts Manager',1500000,'Accounts')
Insert into GeneralCompanyRecord values(29,'BTSS','2012/08/29',NULL,'Senior Accountant',1150000,'Accounts')


--INSERT STATEMENTS FOR GOODSAMRITANRECORD
Insert Into GoodSamaritanRecord values(1,'1')
Insert Into GoodSamaritanRecord values(1,'4')
Insert Into GoodSamaritanRecord values(3,'6')
Insert Into GoodSamaritanRecord values(3,'2')
Insert Into GoodSamaritanRecord values(5,'7')
Insert Into GoodSamaritanRecord values(6,'8')
Insert Into GoodSamaritanRecord values(7,'9')
Insert Into GoodSamaritanRecord values(8,'2')
Insert Into GoodSamaritanRecord values(9,'10')
Insert Into GoodSamaritanRecord values(10,'3')
Insert Into GoodSamaritanRecord values(4,'3')
Insert Into GoodSamaritanRecord values(10,'5')
Insert Into GoodSamaritanRecord values(11,'1')
Insert Into GoodSamaritanRecord values(12,'2')
Insert Into GoodSamaritanRecord values(13,'2')
Insert Into GoodSamaritanRecord values(14,'3')
Insert Into GoodSamaritanRecord values(16,'4')
Insert Into GoodSamaritanRecord values(17,'5')
Insert Into GoodSamaritanRecord values(18,'5')
Insert Into GoodSamaritanRecord values(20,'6')
Insert Into GoodSamaritanRecord values(20,'7')
Insert Into GoodSamaritanRecord values(22,'8')
Insert Into GoodSamaritanRecord values(22,'1')
Insert Into GoodSamaritanRecord values(23,'9')
Insert Into GoodSamaritanRecord values(24,'10')
Insert Into GoodSamaritanRecord values(25,'10')
Insert Into GoodSamaritanRecord values(25,'2')
Insert Into GoodSamaritanRecord values(26,'5')
Insert Into GoodSamaritanRecord values(27,'5')
Insert Into GoodSamaritanRecord values(28,'6')
Insert Into GoodSamaritanRecord values(29,'8')
Insert Into GoodSamaritanRecord values(30,'3')
Insert Into GoodSamaritanRecord values(1,'10')


--INSERT STATEMENTS FOR ACHIEVEMENTRECORD
Insert Into AchievementRecord values('1','Blood Donation')
Insert Into AchievementRecord values('2','Educational Drives')
Insert Into AchievementRecord values('3','Plantation Drive')
Insert Into AchievementRecord values('4','Army Service')
Insert Into AchievementRecord values('5','Scientific Invention')
Insert Into AchievementRecord values('6','Sports')
Insert Into AchievementRecord values('7','National Bravery Award')
Insert Into AchievementRecord values('8','Contribution to rural Upliftment')
Insert Into AchievementRecord values('9','Women Empowerment')
Insert Into AchievementRecord values('10','Government Donation')

--INSERT STATEMENTS FOR PROPERTYDETAILS

Insert Into PropertyDetails values('P1','Individual House','1000.25','Goa','2500000','208333','1')
Insert Into PropertyDetails values('P2','Flats','2000.21','Chandigargh','3000000','250000','2')
Insert Into PropertyDetails values('P3','Ground','1548.95','Mumbai','10000000','833333','3')
Insert Into PropertyDetails values('P4','Flats','711.45','Chennai','15000000','1250000','4')
Insert Into PropertyDetails values('P5','Villa','850.45','Bangalore','15000000','1250000','5')
Insert Into PropertyDetails values('P6','Mansion','601.95',' Bangalore','10000000','833333','6')
Insert Into PropertyDetails values('P7','Flats','999.65','Pune','20000000','1666666','7')
Insert Into PropertyDetails values('P8','Individual House','500.78','Kolkata','7000000','583333','8')
Insert Into PropertyDetails values('P9','Individual House','760.36',' Hyderabad','10000000','833333','9')
Insert Into PropertyDetails values('P10','Ground','820.48','Ahemadabad','15000000','1250000','10')
Insert Into PropertyDetails values('P11','Land','840.48','Bellary','16500000','110000','11')
Insert Into PropertyDetails values('P12','Land','734.68','Delhi','10000000','225000','12')
Insert Into PropertyDetails values('P13','Flat','1400','Jaipur','35000000','2250000','13')
Insert Into PropertyDetails values('P14','Flat','900','Lucknow','15000000','1200000','15')
Insert Into PropertyDetails values('P15','Indipendent House','1200','Kochi','17000000','1090000','16')
Insert Into PropertyDetails values('P16','Ground','880','Mysore','2000000','1150000','19')
Insert Into PropertyDetails values('P17','Flat','1500','Bangalore','50000000','2340000','20')
Insert Into PropertyDetails values('P18','Flat','920.48','Kolkata','25000000','1650000','21')
Insert Into PropertyDetails values('P19','Land','770','Ahemadabad','15000000','1250000','22')
Insert Into PropertyDetails values('P20','Flat','810','Mumbai','45000000','2650000','26')
Insert Into PropertyDetails values('P21','Ground','945.67','Udaipur','35000000','1290000','29')
Insert Into PropertyDetails values('P22','Independent','1100','Darjeeling','2000000','100000','23')
Insert Into PropertyDetails values('P23','Flat','1600.78','Jammu & Kashmir','15000000','1110000','24')
Insert Into PropertyDetails values('P24','Flat','1945.67','Mumbai','45000000','1590000','25')
Insert Into PropertyDetails values('P25','Ground','745.67','Nagpur','21000000','190000','27')
Insert Into PropertyDetails values('P26','Independent House','945.67','Mysore','19000000','190000','28')

--INSERT STATEMENTS FOR VEHICLERECORD

Insert Into VehicleRecord values('V01','KA 09 CA 1243',	'car', 'Diesel','53WCV10223','1KDF2932HE237119','Bajaj Allianz','198478RY346','5')
Insert Into VehicleRecord values('V02',	'TN 10 ED 9987','car','Petrol','27AWC98237','1AKJDJ29428B232O8','Bharti AXA','28167SADH8643','4')
Insert Into VehicleRecord values('V03','KA 01 AW 0065','car','Diesel','98QWE98730','1KS23726J2J222','New India Insurance','1846JFHS17246','6')
Insert Into VehicleRecord values('V04','MH 07 AZ 4563','car','Petrol','09LKJF12332','1AAJK29137NN1387','Bajaj Allianz','12461FKH278871','7')
Insert Into VehicleRecord values('V05','TS 09 AA 0010','Car','Diesel','99ZXZ91833','1KJKSD2746JH22929','New India Insurance','1486712414KA7723','9')
Insert Into VehicleRecord values('V06','TN 08 AC 2881',	'Two wheeler','Petrol','88EER776611','1JSD28736HHS17823','New India Insurance','1846SALC176811','4')
Insert Into VehicleRecord values('V07','CH 09 AA 7767','Two wheeler','Petrol','11HFG00987','1JKDF27367NJ2272','Future Generali','18467QWQ871476','2')
Insert Into VehicleRecord values('V08','GA 01 AS 0001','Two wheeler','Petrol','21AAS654277','1BFZJ73248BJ2292','Bajaj Allianz','1476CJCKZ11971','1')
Insert Into VehicleRecord values('V09','KA 08 AZ 1001','car','Diesel','77ZSE297947','1AIRU283684H2800','New India Insurance','1471KSDH876','4')
Insert Into VehicleRecord values('V10','GJ 01 AA 0123',	'car','Diesel','88DDG13711','1KSD3286TYU93788','Bharti AXA','832617AKH3784','10')
Insert Into VehicleRecord values('V011','KA 09 CA 1243','Car', 'Diesel','53WCV10223','1KDF2932HE237119','Bajaj Allianz','198478RY346','5')
Insert Into VehicleRecord values('V012','TN 10 ED 9987','Car','Petrol','27AWC98237','1AKJDJ29428B232O8','Bharti AXA','28167SADH8643','4')
Insert Into VehicleRecord values('V013','KA 01 AW 0065','Car','Diesel','98QWE98730','1KS23726J2J222','New India Insurance','1846JFHS17246','6')
Insert Into VehicleRecord values('V014','MH 07 AZ 4563','Two Wheeler','Petrol','09LKJF12332','1AAJK29137NN1387','Bajaj Allianz','12461FKH278871','7')
Insert Into VehicleRecord values('V015','TS 09 AA 0010','Two Wheeler','Diesel','99ZXZ91833','1KJKSD2746JH22929','New India Insurance','1486712414KA7723','9')
Insert Into VehicleRecord values('V016','TN 08 AC 2881','Two Wheeler','Petrol','88EER776611','1JSD28736HHS17823','New India Insurance','1846SALC176811','4')
Insert Into VehicleRecord values('V017','CH 09 AA 7767','Two Wheeler','Petrol','11HFG00987','1JKDF27367NJ2272','Future Generali','18467QWQ871476','2')
Insert Into VehicleRecord values('V018','GA 01 AS 0001','Two Wheeler','Petrol','21AAS654277','1BFZJ73248BJ2292','Bajaj Allianz','1476CJCKZ11971','1')
Insert Into VehicleRecord values('V019','KA 08 AZ 1001','Car','Diesel','77ZSE297947','1AIRU283684H2800','New India Insurance','1471KSDH876','4')
Insert Into VehicleRecord values('V020','GJ 01 AA 0123','Car','Diesel','88DDG13711','1KSD3286TYU93788','Bharti AXA','832617AKH3784','10')
Insert Into VehicleRecord values('V021','KA 09 CA 1243','Car','Diesel','53WCV10223','1KDF2932HE237119','Bajaj Allianz','198478RY346','5')
Insert Into VehicleRecord values('V022','TN 10 ED 9987','Two Wheeler','Petrol','27AWC98237','1AKJDJ29428B232O8','Bharti AXA','28167SADH8643','4')
Insert Into VehicleRecord values('V023','KA 01 AW 0065','Two Wheeler','Diesel','98QWE98730','1KS23726J2J222','New India Insurance','1846JFHS17246','6')
Insert Into VehicleRecord values('V024','MH 07 AZ 4563','Car','Petrol','09LKJF12332','1AAJK29137NN1387','Bajaj Allianz','12461FKH278871','7')
Insert Into VehicleRecord values('V025','TS 09 AA 0010','Car','Diesel','99ZXZ91833','1KJKSD2746JH22929','New India Insurance','1486712414KA7723','9')
Insert Into VehicleRecord values('V026','TN 08 AC 2881','Two wheeler','Petrol','88EER776611','1JSD28736HHS17823','New India Insurance','1846SALC176811','4')
Insert Into VehicleRecord values('V027','CH 09 AA 7767','Two wheeler','Petrol','11HFG00987','1JKDF27367NJ2272','Future Generali','18467QWQ871476','2')
Insert Into VehicleRecord values('V028','GA 01 AS 0001','Two wheeler','Petrol','21AAS654277','1BFZJ73248BJ2292','Bajaj Allianz','1476CJCKZ11971','1')
Insert Into VehicleRecord values('V029','KA 08 AZ 1001','Car','Diesel','77ZSE297947','1AIRU283684H2800','New India Insurance','1471KSDH876','4')
Insert Into VehicleRecord values('V030','GJ 01 AA 0123','Two Wheeler','Diesel','88DDG13711','1KSD3286TYU93788','Bharti AXA','832617AKH3784','10')

--INSERT STATEMENTS FOR UTILITYRECORD

Insert Into UtilityRecord values('11','2020-05-11','1000.25','500.95','20.01','11')
Insert Into UtilityRecord values('12','2019-04-20','850.96','750.65','100.23','12')
Insert Into UtilityRecord values('13','2018-05-20','2000.24','1056.96','75.45','13')
Insert Into UtilityRecord values('14','2019-05-05','4500.45','478.45','50.8','14')
Insert Into UtilityRecord values('15','2018-05-19','956.96','1005.75','952.45','14')
Insert Into UtilityRecord values('16','2020-05-19','2150.96','1256.75','852.45','14')
Insert Into UtilityRecord values('17','2020-05-19','2150.96','1000.75','250.45','15')
Insert Into UtilityRecord values('18','2020-01-29','3000.47','2500.89','300.32','16')
Insert Into UtilityRecord values('19','2018-12-19','1150.16','550.45','100.45','17')
Insert Into UtilityRecord values('20','2019-12-12','750.36','300.45','150.47','18')
Insert Into UtilityRecord values('21','2020-02-20','1500.02','1250.78','800.69','19')
Insert Into UtilityRecord values('22','2020-07-07','1250.36','1000.45','550.36','20')
Insert Into UtilityRecord values('23','2020-05-11','1000.25','650.95','20.01','21')
Insert Into UtilityRecord values('24','2019-04-20','982.96','779.65','100.23','22')
Insert Into UtilityRecord values('25','2018-05-20','1540.24','1569.96','175.45','23')
Insert Into UtilityRecord values('26','2019-05-05','4500.45','478.45','50.8','23')
Insert Into UtilityRecord values('27','2020-05-19','963.96','1456.75','963.45','23')
Insert Into UtilityRecord values('28','2020-05-19','2150.96','1256.75','852.45','24')
Insert Into UtilityRecord values('29','2020-05-19','2150.96','1258.75','250.45','25')
Insert Into UtilityRecord values('30','2020-01-29','2856.47','2500.89','300.32','26')
Insert Into UtilityRecord values('31','2018-12-19','1150.16','550.45','169.45','27')
Insert Into UtilityRecord values('32','2019-12-12','750.36','1569.45','150.47','27')
Insert Into UtilityRecord values('33','2020-02-20','2458.02','1250.78','965.69','28')
Insert Into UtilityRecord values('34','2020-07-07','152.36','1000.45','550.36','28')
Insert Into UtilityRecord values('35','2018-05-19','956.96','1005.75','952.45','29')
Insert Into UtilityRecord values('36','2020-05-19','2150.96','1256.75','852.45','30')
Insert Into UtilityRecord values('1','2020-05-11','1000.25','500.95','20.01','1')
Insert Into UtilityRecord values('2','2020-04-20','850.96','750.65','100.23','2')
Insert Into UtilityRecord values('3','2020-05-20','2000.24','1056.96','75.45','2')
Insert Into UtilityRecord values('4','2019-05-05','650.45','1201.45','50.8','4')
Insert Into UtilityRecord values('5','2020-05-19','2150.96','1000.75','250.45','5')
Insert Into UtilityRecord values('6','2020-01-29','3000.47','2500.89','300.32','6')
Insert Into UtilityRecord values('7','2018-12-19','1150.16','550.45','100.45','7')
Insert Into UtilityRecord values('8','2020-12-12','750.36','300.45','150.47','8')
Insert Into UtilityRecord values('9','2020-02-20','1500.02','1250.78','800.69','9')
Insert Into UtilityRecord values('10','2020-07-07','1250.36','1000.45','550.36','10')

--INSERT STATEMENTS FOR GENERALBANKRECORD

Insert Into GeneralBankRecord values('1','1288547943829008','HDFCB')
Insert Into GeneralBankRecord values('2','679900564483','SBIB')
Insert Into GeneralBankRecord values('3','900884384409','BOB')
Insert Into GeneralBankRecord values('4','7554564480041224','AXB')
Insert Into GeneralBankRecord values('5','338888700033','KMB')
Insert Into GeneralBankRecord values('6','112343438776','IIB')
Insert Into GeneralBankRecord values('7','998700554876','YB')
Insert Into GeneralBankRecord values('8','9984097775534443','PNB')
Insert Into GeneralBankRecord values('9','777658440032','BOI')
Insert Into GeneralBankRecord values('10','2243008006601122','ICICIB')
Insert Into GeneralBankRecord values('11','569845878854','HDFCB')
Insert Into GeneralBankRecord values('12','5648946512315','SBIB')
Insert Into GeneralBankRecord values('13','105549564655489','BOB')
Insert Into GeneralBankRecord values('14','1234648945121','AXB')
Insert Into GeneralBankRecord values('15','91561132165476','KMB')
Insert Into GeneralBankRecord values('16','56651321894984','IIB')
Insert Into GeneralBankRecord values('17','561132154894','YB')
Insert Into GeneralBankRecord values('18','998403216544','PNB')
Insert Into GeneralBankRecord values('19','777658440032','BOI')
Insert Into GeneralBankRecord values('20','5641651321654984','ICICIB')
Insert Into GeneralBankRecord values('21','65156131326489','HDFCB')
Insert Into GeneralBankRecord values('22','566518948651561','SBIB')
Insert Into GeneralBankRecord values('23','894654651648949','BOB')
Insert Into GeneralBankRecord values('24','561213215480005','AXB')
Insert Into GeneralBankRecord values('25','848945050210550','KMB')
Insert Into GeneralBankRecord values('26','000005612132189','IIB')
Insert Into GeneralBankRecord values('27','6500040132048505','YB')
Insert Into GeneralBankRecord values('28','9984097775534443','PNB')
Insert Into GeneralBankRecord values('29','0005612048416510','BOI')
Insert Into GeneralBankRecord values('30','2243008006601122','ICICIB')



--INSERT STATEMENTS FOR BANKRECORD

Insert Into BankRecord values('HDFCB','HDFC Bank','HDFC00006457','siolim')
Insert Into BankRecord values('BOB','Bank of Baroda','BOBN00003214','Chandigarh main')
Insert Into BankRecord values('SBIB','State Bank of India' ,'SBIN00008870','Kohinoor city')
Insert Into BankRecord values('AXB','Axis Bank','UTIB00001122','Adyar')
Insert Into BankRecord values('KMB','Kotak Mahindra Bank','KKBK00000172','langford road')
Insert Into BankRecord values('IIB','Indusind Bank' ,'INDB00000030','BTS layout') 
Insert Into BankRecord values('YB','Yes Bank' ,'YESB0000008','Indapur')
Insert Into BankRecord values('PNB','Punjab National Bank','PUNB03090300','Bangur')
Insert Into BankRecord values('BOI','Bank of India','BKID00080987','Banjara Hills') 
Insert Into BankRecord values('ICICIB','ICICI Bank' ,'ICIC00000005','Behampura')

--INSERT STATEMENTS FOR CRIMINALRECORD

Insert  Into CriminalRecord values('CR08','FIR001','SEC112','Theft','1','2');
Insert  Into CriminalRecord values('CR09','FIR002','SEC724','Drunken Drive','1','2');
Insert  Into CriminalRecord values('CR10','FIR003','SEC420','Fraud','1','2');
Insert  Into CriminalRecord values('CR101','FIR021','SEC111','Murder','1','4');
Insert  Into CriminalRecord values('CR105','FIR022','SEC112','Theft','1','4');
Insert  Into CriminalRecord values('CR108','FIR023','SEC724','Drunken Drive','1','4');
Insert  Into CriminalRecord values('CR110','FIR024','SEC111','Murder','1','4');
Insert  Into CriminalRecord values('CR120','FIR025','SEC119','Money laundering','1','4');
Insert  Into CriminalRecord values('CR096','FIR004','SEC420','Fraud','1','2');
Insert  Into CriminalRecord values('CR40','FIR005','SEC900','Pickpocket','0','2');
Insert  Into CriminalRecord values('CR11','FIR009','SEC112','Theft','1','19');
Insert  Into CriminalRecord values('CR58','FIR0019','SEC724','Illegal Drug Trade','1','19');
Insert  Into CriminalRecord values('CR74','FIR0015','SEC420','Wildlife Trafficking','1','15');
Insert  Into CriminalRecord values('CR79','FIR0015A','SEC590','Money laundering','1','15');
Insert  Into CriminalRecord values('CR95','FIR0021','SEC100','Arms Trafficking','1','21');
Insert  Into CriminalRecord values('CR96','FIR0021A','SEC111','Murder','1','21');

--INSERT STATEMENTS FOR TRAVELRECORD
Insert Into TravelRecord values ('NK08','Northkorea','2017-10-20','2017-10-30','AKF842','AirTravelInsurance','1');
Insert Into TravelRecord values('UK01','UnitedKingdom','2015-06-05','2015-07-05','XYG678','SafeTravelInsurance','2');
Insert Into TravelRecord values('US98','Unitedstates','2000-01-10','2000-11-10','ASD456','SafeTravelInsurance','3');
Insert Into TravelRecord values('BR25','Brazil','1990-03-25','1990-04-27','QWE256','AirIndiaTravelInsurance','4');
Insert into TravelRecord values('PA81','Paris','2014-08-13','2014-10-10','MIK098','SafeTravelInsurance','5');
Insert Into TravelRecord values('SW55','Switzerland','2002-04-17','2002-05-01','JKL512','AirIndiaTravelInsurance','6');
Insert Into TravelRecord values('US98','Unitedstates','2008-06-09','2009-06-09','GHY710','AirIndiaTravelInsurance','7');
Insert Into TravelRecord values('SP09','Spain','1997-06-08','1997-10-01','MLK389','AirTravelInsurance','8');
Insert Into TravelRecord values('TH04','Thailand','2001-01-22','2001-02-05','KLM125','AirTravelInsurance','9');
Insert Into TravelRecord values('IR34','Ireland','1994-06-30','1994-07-10','FGY890','AirTravelInsurance','10');
Insert Into TravelRecord values('JK2','Dubai','2019-03-12','2019-03-27','ABC876','AirTravelInsurance','11');
Insert Into TravelRecord values('AB12','United Kingdom','2003-02-14','2003-03-01','LMN678','AirTravelInsurance','12');
Insert Into TravelRecord values('QR67','Milan','2018-09-29','2018-10-05','PQR563','AirTravelInsurance','14');
Insert Into TravelRecord values('QR67','Milan','2018-09-29','2018-10-05','UVW009','AirTravelInsurance','15');
Insert Into TravelRecord values('XY6','Turkey','1996-10-23','1996-10-30','JKV001','SafeTravelInsurance','16');
Insert Into TravelRecord values('IJ78','Israel','2011-09-09','2011-09-20','DEF234','SafeTravelInsurance','17');
Insert Into TravelRecord values('FCD7','Paris','2017-08-04','2017-08-28','DEL090','SafeTravelInsurance','18');
Insert Into TravelRecord values('PQR5','Qatar','2006-06-06','2006-06-16','WEP974','SafeTravelInsurance','19');
Insert Into TravelRecord values('WE34','Bahrain','2019-12-25','2020-01-02','OPQ343','SaharaTravelInsurance','20');
Insert Into TravelRecord values('WE24','Bahrain','2019-12-25','2020-01-02','CSR559','SaharaTravelInsurance','21');
Insert Into TravelRecord values('RS34','Russia','2014-02-02','2014-02-17','BBN660','SaharaTravelInsurance','22');
Insert Into TravelRecord values('UT5','United States','2020-02-18','2020-03-03','SHS221','SaharaTravelInsurance','23');
Insert Into TravelRecord values('RS34','Russia','2014-02-02','2014-02-17','AIR221','SaharaTravelInsurance','24');
Insert Into TravelRecord values('SMS2','Canada','2019-10-23','2019-10-30','BVG420','AirTravelInsurance','25');
Insert Into TravelRecord values('MN02','Argentina','2019-09-28','2019-10-10','CNZ340','AirTravelInsurance','26');
Insert Into TravelRecord values('TU65','Indonesia','2011-03-22','2011-03-27','GHJ764','SaharaTravelInsurance','27');
Insert Into TravelRecord values('AS2','Malaysia','2019-07-26','2019-09-02','PSR320','SaharaTravelInsurance','29');
Insert Into TravelRecord values('MN02','Argentina','2019-09-28','2019-10-10','HIJ786','KingfisherTravelInsurance','30');


--INSERT STATEMENTS FOR HEALTHRECORD
Insert Into HealthRecord values('HT01','1','18.5','A+','2017-09-15','SHN0045','StarHealth','1','Patient has NOVEL COVID 19');
Insert Into HealthRecord values('HT02','2','30.1','A-','2015-04-10','HDFCN0100','HDFCLife','0','patient is undergoing treatment for cancer');
Insert Into HealthRecord values('HT03','3','27.3','B+','2001-02-10','MCN0115','MedCare','0','Patient is sufuring from ulcer');
Insert Into HealthRecord values('HT04','4','32.3','B-','1991-04-10','MCN0007','MedCare','0','Patient has undergone openheart surgery');
Insert Into HealthRecord values('HT05','5','19.2','O+','2013-01-10','SHN0200','StarHealth','0','Patient has drinking habit');
Insert Into HealthRecord values('HT06','6','24.9','O-','2003-05-17','SBILN0050','SBILife','1','Patient has hepetitis A');
Insert Into HealthRecord values('HT07','7','33.4','AB+','2010-06-12','HDFCN0034','HDFCLife','0','Patirent has High BMI , Diabetes');
Insert Into HealthRecord values('HT08','8','29.9','AB-','1997-09-10','HDFCN0052','HDFCLife','0','Patient has very are blood group');
Insert Into HealthRecord values('HT09','9','30.0','A+','2001-01-20','SBILN0088','SBILife','0','Patient is alergic to penicillin');
Insert Into HealthRecord values('HT10','10','18.5','B+','1994-11-04','SHN0097','StarHealth','0','Patient is in Good health');
Insert Into HealthRecord values('HT11','11','18.5','A+','2017-09-15','SHN0045','StarHealth','1','Patient has COVID-19');
Insert Into HealthRecord values('HT12','12','30.1','A-','2015-04-10','HDFCN0100','HDFCLife','0','Patient is undergoing treatment for cancer');
Insert Into HealthRecord values('HT13','13','27.3','B+','2001-02-10','MCN0115','MedCare','0','Patient is in Good health');
Insert Into HealthRecord values('HT14','14','32.3','B-','1991-04-10','MCN0007','MedCare','0','Patient is in Good health');
Insert Into HealthRecord values('HT15','16','19.2','O+','2013-01-10','SHN0200','StarHealth','0','Patient is in Good health');
Insert Into HealthRecord values('HT16','16','22.3','O+','2014-05-17','SHN0200','StarHealth','0','Patient is in Good health');
Insert Into HealthRecord values('HT17','17','33.4','AB+','2010-06-12','HDFCN0034','HDFCLife','0','Patient is in Good health');
Insert Into HealthRecord values('HT18','18','29.9','AB-','1997-09-10','HDFCN0052','HDFCLife','1','Patient has hepetitis B');
Insert Into HealthRecord values('HT19','19','30.0','A+','2001-01-20','SBILN0088','SBILife','1','Patient has hepetitis B');
Insert Into HealthRecord values('HT20','19','18.5','B+','1994-11-04','SHN0097','StarHealth','1','Patient has hepetitis C');
Insert Into HealthRecord values('HT21','21','18.5','A+','2017-09-15','SHN0045','StarHealth','1','Patient has COVID 19');
Insert Into HealthRecord values('HT22','22','30.1','A-','2015-04-10','HDFCN0100','HDFCLife','0','Patient is in Good health');
Insert Into HealthRecord values('HT23','23','27.3','B+','2001-02-10','MCN0115','MedCare','0','Patient is in Good health');
Insert Into HealthRecord values('HT24','25','32.3','B-','2012-04-10','MCN0007','MedCare','0','Patient is in Good health');
Insert Into HealthRecord values('HT25','25','31.2','B-','2013-01-10','MCN0007','MedCare','0','Patient is in Good health');
Insert Into HealthRecord values('HT26','25','32.5','B-','2014-05-17','MCN0007','MedCare','0','Patient is in Good health');
Insert Into HealthRecord values('HT27','27','33.4','AB+','2010-06-12','HDFCN0034','HDFCLife','1','Patient has salmonella');
Insert Into HealthRecord values('HT28','28','29.9','AB-','1997-09-10','HDFCN0052','HDFCLife','1','Patient has Ebola');
Insert Into HealthRecord values('HT29','29','30.0','A+','2001-01-20','SBILN0088','SBILife','1','Patient has Meningitis');
Insert Into HealthRecord values('HT30','30','18.5','B+','1994-11-04','SHN0097','StarHealth','1','Patient has Norovirus');

--INSERT STATEMENTS FOR GENERALCOLLGERECORD

Insert Into GeneralCollegeRecord values('1','IISC003');
Insert Into GeneralCollegeRecord values ('2','IITD089');
Insert Into GeneralCollegeRecord values ('3','IITM101');
Insert Into GeneralCollegeRecord values ('4','IITKGP12');
Insert Into GeneralCollegeRecord values ('5','IITK45');
Insert Into GeneralCollegeRecord values ('6','IISC003');
Insert Into GeneralCollegeRecord values ('7','UH003');
Insert Into GeneralCollegeRecord values ('8','IITR220');
Insert Into GeneralCollegeRecord values ('9','IITG077');
Insert Into GeneralCollegeRecord values ('10','IITB004');
Insert Into GeneralCollegeRecord values ('11','IITG077');
Insert Into GeneralCollegeRecord values ('12','BMC12');
Insert Into GeneralCollegeRecord values ('13','UH003');
Insert Into GeneralCollegeRecord values ('14','IISC003');
Insert Into GeneralCollegeRecord values ('15','BIT001');
Insert Into GeneralCollegeRecord values ('16','NLS001');
Insert Into GeneralCollegeRecord values ('17','SBMJ20');
Insert Into GeneralCollegeRecord values ('19','IITKGP12');
Insert Into GeneralCollegeRecord values ('20','IITK45');
Insert Into GeneralCollegeRecord values ('21','IITK45');
Insert Into GeneralCollegeRecord values ('22','SBMJ20');
Insert Into GeneralCollegeRecord values ('23','SBMJ20');
Insert Into GeneralCollegeRecord values ('24','SBMJ20');
Insert Into GeneralCollegeRecord values ('25','UH003');
Insert Into GeneralCollegeRecord values ('26','UH003');
Insert Into GeneralCollegeRecord values ('27','BIT001');
Insert Into GeneralCollegeRecord values ('28','UH003');
Insert Into GeneralCollegeRecord values ('29','SBMJ20');


--INSERT STATEMENTS FOR COLLEGERECORD

Insert Into CollegeRecord values('IISC003','Indian Institute of Science (IISC) Bangalore','12A','Bangalore','Karnataka','India','560012');
Insert Into CollegeRecord values('IITD089','Indian Institute of Technology Delhi (IITD)','15/3','Delhi','Delhi','India','110016');
Insert Into CollegeRecord values('IITM101','Indian Institute of Technology Madras (IITM)','108A','Chennai','Tamilnadu','India','600036');
Insert Into CollegeRecord values('IITKGP12','Indian Institute of Technology Kharagpur (IITKGP)','56B','Kharagpur','Westbengal','India','721302');
Insert Into CollegeRecord values('IITK45','Indian Institute of Technology Kanpur (IITK)','96R','Kanpur','Uttar Pradesh','India','208016');
Insert Into CollegeRecord values('IISC004','Indian Institute of Science (IISC) Bangalore','154/6','Bangalore','Karnataka','India','560012');
Insert Into CollegeRecord values('UH003','University of Hyderabad','56S','Hyderabad','Telengana','India','500046');
Insert Into CollegeRecord values('IITR220','Indian Institute of Technology Roorkee (IITR)','96R','Roorkee','Uttarakhand','India','800123');
Insert Into CollegeRecord values('IITG077','Indian Institute of Technology Guwahati (IITG)','32A','Guwahati','Assam','India','781039');
Insert Into CollegeRecord values('IITB004','Indian Institute of Technology Bombay (IITB)','565A','Bombay','Maharastra','India','400076');
Insert Into CollegeRecord values('BMC12','Bangalore Medical College','223D','Bangalore','Karnataka','India','560012');
Insert Into CollegeRecord values('BIT001','Bhopal Institute of Technology Bombay (IITB)','44A','Bhopal','Madhya Pradesh','India','720010');
Insert Into CollegeRecord values('NLS001','National Law University','441/B','New Delhi','New Delhi','India','110016');
Insert Into CollegeRecord values('SBMJ20','Shri Bhagwan Mahaveer jain College','221B','Mumabi','Maharastra','India','400076');
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
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
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--COMPUTED COLUMN
Create Function fn_Achievementcount(@NationID INT)
Returns int
As
Begin
Declare @achievecount int;
(select @achievecount=COALESCE (Count(AchievementID),0)
 FROM GoodSamaritanRecord s
JOIN GeneralRecord g
ON s.Nationid=g.Nationid
Where s.NationID= @NationID);
Return @achievecount;
END

---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- VIEW - 1 (Person History View)
-- House Keeping
DROP VIEW IF EXISTS PersonHistory;
-- View Creation
CREATE VIEW PersonHistory WITH SCHEMABINDING
AS 
SELECT DISTINCT gr.NationID,FirstName, LastName, DateofBirth, PhoneNumber, 

STUFF((SELECT ', ' + RTRIM(CAST(MedicalCheckupDate AS CHAR)) FROM dbo.HealthRecord  hr1 
WHERE gr.NationID=hr1.NationID FOR XML PATH('')),1,2,'') AS MeadicalHealthCheckUpDate,

ISNULL(STUFF((SELECT ', ' + RTRIM(CAST(AchievementName AS CHAR)) FROM dbo.AchievementRecord  ar1  LEFT JOIN dbo.GoodSamaritanRecord gsr1
ON gsr1.AchievementID = ar1.AchievementID WHERE gr.NationID=gsr1.NationID FOR XML PATH('')),1,2,''),'No Achievement') AS AchievementName,

STUFF((SELECT ', ' + RTRIM(CAST(CountryVisited AS CHAR)) FROM dbo.TravelRecord tr1
WHERE gr.NationID=tr1.NationID FOR XML PATH('')),1,2,'') AS 'CountryVisited',

ISNULL(STUFF((SELECT ', ' + RTRIM(CAST(CompanyName AS CHAR)) FROM dbo.CompanyRecord com1 LEFT JOIN dbo.GeneralCompanyRecord gcr1
ON com1.CompanyID = gcr1.CompanyID WHERE gcr1.NationID = gr.NationID FOR XML PATH('')),1,2,''),'Nil' )AS CompanyName, 

ISNULL(STUFF((SELECT ', ' + RTRIM(CAST(VehicleNumber AS CHAR)) FROM dbo.VehicleRecord vr1
WHERE vr1.NationID = gr.NationID FOR XML PATH('')),1,2,''),'Nil') AS 'Vehicle',

Location AS PropertyLocation, 

STUFF((SELECT ', ' + RTRIM(CAST(ElectricityConsumption AS CHAR)) FROM dbo.UtilityRecord ur1 
WHERE gr.NationID = ur1.NationID FOR XML PATH('')),1,2,'') AS 'ElectricityConsumption',

STUFF((SELECT ', ' + RTRIM(CAST(GasConsumption AS CHAR)) FROM dbo.UtilityRecord ur1 
WHERE gr.NationID = ur1.NationID FOR XML PATH('')),1,2,'') AS 'GasConsumption',

STUFF((SELECT ', ' + RTRIM(CAST(WaterConsumption AS CHAR)) FROM dbo.UtilityRecord ur1 
WHERE gr.NationID = ur1.NationID FOR XML PATH('')),1,2,'') AS 'Water Consumption',
 
 BankName, AccountNumber, 

 ISNULL(STUFF((SELECT ', ' + SchoolName FROM dbo.SchoolRecord sr1 
LEFT JOIN dbo.GeneralSchoolRecord gsr1 ON sr1.SchoolID = gsr1.SchoolID WHERE gr.NationID = gsr1.NationID FOR XML PATH('')),1,2,''),'Nil') AS 'School',

ISNULL(STUFF((SELECT ', ' + CollegeName FROM dbo.CollegeRecord cr1 
LEFT JOIN dbo.GeneralCollegeRecord gcr1 ON cr1.CollegeID = gcr1.CollegeID WHERE gr.NationID = gcr1.NationID FOR XML PATH('')),1,2,''),'Nil') AS 'College'

FROM
dbo.GeneralRecord gr LEFT JOIN dbo.HealthRecord hr ON gr.NationID = hr.NationID
LEFT JOIN dbo.GoodSamaritanRecord gsr ON gr.NationID = gsr.NationID
LEFT JOIN dbo.AchievementRecord  ar ON gsr.AchievementID = ar.AchievementID
LEFT JOIN dbo.TravelRecord tr ON tr.NationID = gr.NationID
LEFT JOIN dbo.CriminalRecord cr ON cr.NationID = gr.NationID
LEFT JOIN dbo.GeneralCompanyRecord gcr ON gcr.NationID = gr.NationID
LEFT JOIN dbo.CompanyRecord com ON com.CompanyID = gcr.CompanyID
LEFT JOIN dbo.VehicleRecord vr ON vr.NationID = gr.NationID
LEFT JOIN dbo.PropertyDetails pd ON pd.NationID = gr.NationID
LEFT JOIN dbo.GeneralSchoolRecord gscr ON gscr.NationID = gr.NationID
LEFT JOIN dbo.SchoolRecord sr ON sr.SchoolID = gscr.SchoolID
LEFT JOIN dbo.GeneralCollegeRecord gcolr ON gcolr.NationID = gr.NationID
LEFT JOIN dbo.CollegeRecord colr ON colr.CollegeID = gcolr.CollegeID
LEFT JOIN dbo.UtilityRecord ur ON ur.NationID = gr.NationID
LEFT JOIN dbo.GeneralBankRecord gbr ON gr.NationID = gbr.NationID
LEFT JOIN dbo.BankRecord br ON br.BankID = gbr.BankID

GO

-- View 2 (CommunicableDiesease View)
-- House Keeping
DROP VIEW IF EXISTS CommunicableDiseasesView
-- View Creation
ALTER VIEW CommunicableDiseasesView WITH SCHEMABINDING
AS

SELECT gr.NationID, FirstName, LastName, Gender, DateOfBirth, PhoneNumber,MedicalCheckupDate,
PatientSummary,
CountryVisited,DateofEntry, DateofExit FROM
dbo.GeneralRecord gr LEFT JOIN dbo.HealthRecord hr ON gr.NationID = hr.NationID
LEFT JOIN dbo.TravelRecord tr ON gr.NationID = tr.NationID 
WHERE CommunicableDiseases = 1

GO