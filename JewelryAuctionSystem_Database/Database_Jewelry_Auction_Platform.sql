CREATE DATABASE Jewelry_Auction_System;
GO
USE Jewelry_Auction_System;
GO

CREATE SEQUENCE userID_sequence
    START WITH 0
    INCREMENT BY 1;
GO

CREATE TABLE [Role] (
    roleID VARCHAR(50) NOT NULL PRIMARY KEY,
    role_name NVARCHAR(50)
);
GO

CREATE TABLE Users (
    userID VARCHAR(50) NOT NULL PRIMARY KEY,
    username VARCHAR(50) UNIQUE,
    email NVARCHAR(255),
    [password] NVARCHAR(255) NOT NULL,
    roleID VARCHAR(50) NOT NULL DEFAULT 'Role01',
    joined_at DATE,
    CONSTRAINT fk_roleID FOREIGN KEY (roleID) REFERENCES [Role](roleID)
);
GO

CREATE TRIGGER check_unique_username
ON Users
INSTEAD OF INSERT
AS
BEGIN
    IF EXISTS (SELECT 1 FROM Users INNER JOIN inserted ON Users.username = inserted.username)
    BEGIN
        RAISERROR ('username already exists.', 16, 1);
        ROLLBACK TRANSACTION;
    END
    ELSE
    BEGIN
        DECLARE @new_userID VARCHAR(50);
        SET @new_userID = 'User' + CAST(NEXT VALUE FOR userID_sequence AS VARCHAR(50));
        
        INSERT INTO Users (userID, username, email, [password], joined_at, roleID)
        SELECT @new_userID, username, email, [password], GETDATE(), roleID
        FROM inserted;
    END
END;
GO

CREATE TABLE [Member] (
    memberID VARCHAR(50) NOT NULL PRIMARY KEY,
    userID VARCHAR(50) NOT NULL,
    firstName NVARCHAR(50),
    lastName NVARCHAR(50),
    phoneNumber VARCHAR(20),
    gender NVARCHAR(10),
    dob DATE,
    avatar NVARCHAR(255),
    CONSTRAINT fk_member_userID FOREIGN KEY (userID) REFERENCES Users(userID)
);
GO

CREATE SEQUENCE addressID_sequence
    START WITH 0
    INCREMENT BY 1;
GO

CREATE TABLE [Address](
    addressID VARCHAR(50) NOT NULL PRIMARY KEY,
    street NVARCHAR(255) NOT NULL,
    city NVARCHAR(255) NOT NULL,
    [state] NVARCHAR(255) NOT NULL,
    zipcode VARCHAR(50) NOT NULL,
    country NVARCHAR(255) NOT NULL,
    memberID VARCHAR(50) NOT NULL,
    CONSTRAINT fk_memberID FOREIGN KEY (memberID) REFERENCES [Member](memberID)
); 
GO

CREATE TRIGGER autogenerate_addressID 
ON [Address] 
INSTEAD OF INSERT
AS 
BEGIN
    DECLARE @newaddressID VARCHAR(50);
    SET @newaddressID = 'Address' + CAST(NEXT VALUE FOR addressID_sequence AS VARCHAR(50));
    INSERT INTO [Address] (addressID, street, city, [state], zipcode, country, memberID)
    SELECT @newaddressID, street, city, [state], zipcode, country, memberID
    FROM inserted;
END;
GO

CREATE SEQUENCE categoryID_sequence
    START WITH 0
    INCREMENT BY 1;
GO

CREATE TABLE category (
    categoryID NVARCHAR(50) NOT NULL PRIMARY KEY,
    categoryName NVARCHAR(255) NOT NULL,
    parentID NVARCHAR(50),
    [active] BIT DEFAULT 1,
    FOREIGN KEY (parentID) REFERENCES category(categoryID)
);
GO

CREATE TRIGGER autogenerate_categoryID 
ON category 
INSTEAD OF INSERT
AS 
BEGIN
    DECLARE @newcategoryID NVARCHAR(50);
    SET @newcategoryID = 'category' + CAST(NEXT VALUE FOR categoryID_sequence AS NVARCHAR(50));
    INSERT INTO category (categoryID, categoryName)
    SELECT @newcategoryID, categoryName
    FROM inserted;
END;
GO

CREATE SEQUENCE valuationId_sequence
    START WITH 0
    INCREMENT BY 1;
GO

CREATE TABLE RequestValuation (
    valuationId VARCHAR(50) NOT NULL PRIMARY KEY,
    [name] NVARCHAR(255) NOT NULL, 
    email NVARCHAR(255) NOT NULL,
    phonenumber VARCHAR(20) NOT NULL,
    communication NVARCHAR(100),
    [description] NVARCHAR(MAX),
    photos VARCHAR(255),
    memberId VARCHAR(50),
    status bit default 0,
    FOREIGN KEY (memberId) REFERENCES [Member](memberId)
);
GO

CREATE TRIGGER autogenerate_valuationId 
ON RequestValuation
INSTEAD OF INSERT
AS 
BEGIN
    DECLARE @newvaluationId NVARCHAR(50);
    SET @newvaluationId = 'val' + CAST(NEXT VALUE FOR valuationId_sequence AS NVARCHAR(50));
    INSERT INTO RequestValuation (valuationId, [name], email, phonenumber, communication, [description], photos, memberId)
    SELECT @newvaluationId, [name], email, phonenumber, communication, [description], photos, memberId
    FROM inserted;
END;
GO


CREATE SEQUENCE notificationId_sequence
    START WITH 0
    INCREMENT BY 1;
GO

CREATE TABLE [Notification](
    notificationId VARCHAR(50) NOT NULL PRIMARY KEY,
    valuationId VARCHAR(50),
    content NVARCHAR(MAX),
    FOREIGN KEY (valuationId) REFERENCES RequestValuation(valuationId)
);
GO

CREATE TRIGGER autogenerate_notificationId 
ON [Notification] 
INSTEAD OF INSERT
AS 
BEGIN
    DECLARE @newnotificationId NVARCHAR(50);
    SET @newnotificationId = 'No' + CAST(NEXT VALUE FOR notificationId_sequence AS NVARCHAR(50));
    INSERT INTO [Notification] (notificationId, valuationId, content)
    SELECT @newnotificationId, valuationId, content
    FROM inserted;
END;
GO

CREATE SEQUENCE jewelryID_sequence
    AS BIGINT
    START WITH 1
    INCREMENT BY 1;
GO

CREATE TABLE Jewelry (
    jewelryID VARCHAR(50) NOT NULL PRIMARY KEY,
    categoryID NVARCHAR(50),
    jewelryName NVARCHAR(500),
    artist NVARCHAR(255),
    circa NVARCHAR(50),
    material NVARCHAR(500),
    dial NVARCHAR(500),
    braceletMaterial NVARCHAR(500),
    caseDimensions NVARCHAR(500),
    braceletSize NVARCHAR(50),
    serialNumber NVARCHAR(255),
    referenceNumber NVARCHAR(255),
    caliber NVARCHAR(255),
    movement NVARCHAR(255),
    [condition] NVARCHAR(500),
    metal NVARCHAR(255),
    gemstones NVARCHAR(500),
    measurements NVARCHAR(500),
    [weight] VARCHAR(255),
    stamped NVARCHAR(255),
    ringSize NVARCHAR(50),
    minPrice VARCHAR(255),
    maxPrice VARCHAR(255),
	temp_Price varchar(255),
    valuationId VARCHAR(50),
	photos nvarchar(MAX),
    [status] varchar(50) default 'Re-Evaluated',
	final_Price varchar(255),
    FOREIGN KEY (valuationId) REFERENCES RequestValuation(valuationId),
    FOREIGN KEY (categoryID) REFERENCES category(categoryID)
);
ALTER TABLE Jewelry
DROP CONSTRAINT DF__Jewelry__statusF__75A278F5;
ALTER TABLE Jewelry
DROP COLUMN [status];
ALTER TABLE Jewelry
ADD [status] VARCHAR(50) default 'Re-Evaluated';
ALTER TABLE Jewelry
ADD temp_Price varchar(255);
ALTER TABLE Jewelry
ADD final_Price varchar(255);
GO
DROP TRIGGER autogenerate_jewelryID;

CREATE TRIGGER autogenerate_jewelryID
ON Jewelry
INSTEAD OF INSERT
AS 
BEGIN
    DECLARE @newjewelryID NVARCHAR(50);

    INSERT INTO Jewelry (
        jewelryID, categoryID, jewelryName, artist, circa, material, dial, braceletMaterial,
        caseDimensions, braceletSize, serialNumber, referenceNumber, caliber, movement, [condition], 
        metal, gemstones, measurements, [weight], stamped, ringSize, minPrice, maxPrice, temp_Price, valuationId, photos
    )
    SELECT 
        'Lot' + CAST(NEXT VALUE FOR jewelryID_sequence AS NVARCHAR(50)),
        categoryID, jewelryName, artist, circa, material, dial, braceletMaterial, 
        caseDimensions, braceletSize, serialNumber, referenceNumber, caliber, movement, [condition], 
        metal, gemstones, measurements, [weight], stamped, ringSize, minPrice, maxPrice, temp_Price, valuationId, photos
    FROM inserted;
END;
GO


CREATE TRIGGER update_valuation_status
ON Jewelry
AFTER INSERT
AS
BEGIN
    UPDATE val
    SET val.status = 1
    FROM RequestValuation val
    JOIN inserted i ON val.valuationId = i.valuationId;
END;
GO
create table Auction(
	auctionID varchar(50) not null primary key,
	startDate date not null,
	[status] bit default 0,
)
create table [Session](
	sessionID varchar(50) not null primary key,
	auctionID varchar(50) not null,
	jewelryID varchar(50) not null, 
	startTime time not null,
	endTime time not null,
	startBid decimal(18,2),
	winnerID varchar(50),
	status bit default 0,
	CONSTRAINT fk_auctionID FOREIGN KEY (auctionID) REFERENCES Auction(auctionID),
	CONSTRAINT fk_jewelryID FOREIGN KEY (jewelryID) REFERENCES Jewelry(jewelryID),
	CONSTRAINT uc_auction_jewelry UNIQUE (auctionID, jewelryID)
)
CREATE TABLE Register_Bid(
    registerBidID varchar(50) NOT NULL PRIMARY KEY,
    sessionID varchar(50) NOT NULL,
    memberID varchar(50) NOT NULL,
    bidAmount_Current decimal(18,2),
    bidTime_Current datetime,
	preBid_Amount decimal(18,2),
	preBid_Time time,
	status bit,
    CONSTRAINT fk_sessionID FOREIGN KEY (sessionID) REFERENCES [Session](sessionID),
    CONSTRAINT fk_Register_Bid_memberID FOREIGN KEY (memberID) REFERENCES Member(memberID)
);

CREATE TABLE Bid_Track(
    bidID varchar(50) NOT NULL PRIMARY KEY,
    sessionID varchar(50) NOT NULL,
    memberID varchar(50) NOT NULL,
    bidAmount decimal(18,2) NOT NULL,
    bidTime datetime NOT NULL,
    CONSTRAINT fk_sessionID_live FOREIGN KEY (sessionID) REFERENCES [Session](sessionID),
    CONSTRAINT fk_memberID_live FOREIGN KEY (memberID) REFERENCES Member(memberID)
);

CREATE TABLE Invoice(
    invoiceID varchar(50) NOT NULL PRIMARY KEY,
    registerBidID varchar(50) NOT NULL,
    invoiceDate datetime NOT NULL,
    totalAmount decimal(18,2) NOT NULL,
    paymentMethod varchar(50),  -- Field for payment method
    shippingAddress nvarchar(500),  -- Field for shipping address
    CONSTRAINT fk_RegisterBid FOREIGN KEY (registerBidID) REFERENCES Register_Bid(registerBidID)
);	
select * from users   
select * from RequestValuation
delete from RequestValuation
delete from Jewelry
SELECT * FROM REQUESTVALUATION
select * from Member
select * from Jewelry
select * from Role
insert into Users (username, email, password, roleID) values ('staff', 'staff123@gmail.com', '123', 'Role02')
insert into Users (username, email, password, roleID) values ('manager', 'manager123@gmail.com', '123', 'Role03')
insert into Users (username, email, password, roleID) values ('admin', 'admin123@gmail.com', '123', 'Role04')
insert into Member (memberID, userID, firstName, lastName, phoneNumber, gender, dob, avatar) values
('Member1', 'User0', 'Alex', 'Watson', '0978787898', 'Male', '2000-02-19', null)
select * from Jewelry
SELECT * FROM CATEGORY
select * from Notification