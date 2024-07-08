CREATE DATABASE FROM Auction WHERE status = 1;
GO

USE Jewelry_Auction_System;
GO

-- Create sequences
CREATE SEQUENCE userID_sequence
    START WITH 0
    INCREMENT BY 1;
GO

CREATE SEQUENCE addressID_sequence
    START WITH 0
    INCREMENT BY 1;
GO

CREATE SEQUENCE categoryID_sequence
    START WITH 0
    INCREMENT BY 1;
GO

CREATE SEQUENCE valuationId_sequence
    START WITH 0
    INCREMENT BY 1;
GO

CREATE SEQUENCE notificationId_sequence
    START WITH 0
    INCREMENT BY 1;
GO

CREATE SEQUENCE jewelryID_sequence
    AS BIGINT
    START WITH 1
    INCREMENT BY 1;
GO

CREATE SEQUENCE auctionID_sequence
    AS BIGINT
    START WITH 1
    INCREMENT BY 1;
GO

CREATE SEQUENCE sessionID_sequence
    AS BIGINT
    START WITH 1
    INCREMENT BY 1;
GO

-- Create tables
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

CREATE TABLE [Member] (
    memberID VARCHAR(50) NOT NULL PRIMARY KEY,
    userID VARCHAR(50) NOT NULL,
    firstName NVARCHAR(50),
    lastName NVARCHAR(50),
    phoneNumber VARCHAR(20),
    gender NVARCHAR(10),
    dob DATE,
    avatar NVARCHAR(255),
	status_register_to_bid bit default 0,
    CONSTRAINT fk_member_userID FOREIGN KEY (userID) REFERENCES Users(userID)
);
GO
CREATE TABLE [Address](
    addressID VARCHAR(50) NOT NULL PRIMARY KEY,
    city NVARCHAR(255) NOT NULL,
    [state] NVARCHAR(255) NOT NULL,
    zipcode VARCHAR(50) NOT NULL,
    country NVARCHAR(255) NOT NULL,
    memberID VARCHAR(50) NOT NULL,
    CONSTRAINT fk_memberID FOREIGN KEY (memberID) REFERENCES [Member](memberID)
); 
GO
CREATE TABLE category (
    categoryID NVARCHAR(50) NOT NULL PRIMARY KEY,
    categoryName NVARCHAR(255) NOT NULL,
    parentID NVARCHAR(50),
    [active] BIT DEFAULT 1,
    FOREIGN KEY (parentID) REFERENCES category(categoryID)
);
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
    status BIT DEFAULT 0,
    final_Status BIT DEFAULT 0,
    FOREIGN KEY (memberId) REFERENCES [Member](memberId)
);
GO

CREATE TABLE [Notification](
    notificationId VARCHAR(50) NOT NULL PRIMARY KEY,
    valuationId VARCHAR(50),
    content NVARCHAR(MAX),
    FOREIGN KEY (valuationId) REFERENCES RequestValuation(valuationId)
);
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
    temp_Price VARCHAR(255),
    valuationId VARCHAR(50),
    photos NVARCHAR(MAX),
    [status] VARCHAR(50) DEFAULT 'Re-Evaluated',
    final_Price VARCHAR(255),
	Sold decimal(18,2) default 0,
    FOREIGN KEY (valuationId) REFERENCES RequestValuation(valuationId),
    FOREIGN KEY (categoryID) REFERENCES category(categoryID)
);
GO
CREATE TABLE Auction (
    auctionId VARCHAR(50) PRIMARY KEY NOT NULL,
    startDate DATE,
    startTime TIME,
	endTime TIME,
	endDate DATE,
    [status] BIT DEFAULT 0
);
GO
CREATE TABLE [Session](
    sessionID VARCHAR(50) NOT NULL PRIMARY KEY,
    auctionID VARCHAR(50) NOT NULL,
    jewelryID VARCHAR(50) NOT NULL, 
    startBid DECIMAL(18,2),
    winnerID VARCHAR(50),
    [status] BIT DEFAULT 0,
    CONSTRAINT fk_auctionID FOREIGN KEY (auctionID) REFERENCES Auction(auctionId),
    CONSTRAINT fk_jewelryID FOREIGN KEY (jewelryID) REFERENCES Jewelry(jewelryID),
    CONSTRAINT uc_auction_jewelry UNIQUE (auctionID, jewelryID)
);
GO
CREATE TABLE Register_Bid(
    registerBidID VARCHAR(50) NOT NULL PRIMARY KEY,
    sessionID VARCHAR(50) NOT NULL,
    memberID VARCHAR(50) NOT NULL,
    bidAmount_Current DECIMAL(18,2),
    bidTime_Current DATETIME,
    preBid_Amount DECIMAL(18,2),
    preBid_Time TIME,
    [status] varchar(50) default 'Placed',
    CONSTRAINT fk_sessionID FOREIGN KEY (sessionID) REFERENCES [Session](sessionID),
    CONSTRAINT fk_Register_Bid_memberID FOREIGN KEY (memberID) REFERENCES [Member](memberID),
	CONSTRAINT uc_member_session UNIQUE (memberID, sessionID)
);
GO
CREATE SEQUENCE registerBidID_sequence
    START WITH 0
    INCREMENT BY 1;
GO
CREATE TRIGGER autogenerate_registerBidID 
ON Register_Bid
INSTEAD OF INSERT
AS 
BEGIN
    DECLARE @newregisterBidID NVARCHAR(50);
    SET @newregisterBidID = 'Reg' + CAST(NEXT VALUE FOR registerBidID_sequence AS NVARCHAR(50));
    INSERT INTO Register_Bid(registerBidID, sessionID, memberID, bidAmount_Current, bidTime_Current, preBid_Amount, preBid_Time, [status])
    SELECT @newregisterBidID, sessionID, memberID, bidAmount_Current, bidTime_Current, preBid_Amount, CONVERT(TIME, GETDATE()), [status]
    FROM inserted;
END;
GO
CREATE TABLE Bid_Track(
    bidID VARCHAR(50) NOT NULL PRIMARY KEY,
    sessionID VARCHAR(50) NOT NULL,
    memberID VARCHAR(50) NOT NULL,
    bidAmount DECIMAL(18,2) NOT NULL,
    bidTime TIME,
    CONSTRAINT fk_sessionID_live FOREIGN KEY (sessionID) REFERENCES [Session](sessionID),
    CONSTRAINT fk_memberID_live FOREIGN KEY (memberID) REFERENCES [Member](memberID)
);
GO
CREATE SEQUENCE bidID_sequence
    START WITH 0
    INCREMENT BY 1;
GO
CREATE TRIGGER autogenerate_bidID
ON Bid_Track
INSTEAD OF INSERT
AS 
BEGIN
    DECLARE @newbidID NVARCHAR(50);
    SET @newbidID = 'Bid' + CAST(NEXT VALUE FOR bidID_sequence AS NVARCHAR(50));
    INSERT INTO Bid_Track(bidID, bidAmount, bidTime, sessionID, memberID)
    SELECT @newbidID, bidAmount, CONVERT(TIME, GETDATE()), sessionID, memberID
    FROM inserted;
END;
GO
drop trigger autogenerate_bidID
CREATE TABLE Invoice(
    invoiceID VARCHAR(50) NOT NULL PRIMARY KEY,
    memberID VARCHAR(50),
	jewelryID VARCHAR(50),
    invoiceDate DATETIME ,
    totalAmount DECIMAL(18,2) ,
    FOREIGN KEY (memberID) REFERENCES Member(memberID)
);
Insert Invoice(invoiceID, memberID, jewelryID, invoiceDate, totalAmount) values ('52446360', 'Member1', 'Lot44', '2024-07-03 01:43:07', '5100000000')
delete from Invoice
93 000 00 0 00.00

GO
-- Create triggers
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

CREATE TRIGGER trg_UpdateStatusOnFinalPrice
ON Jewelry
AFTER UPDATE
AS
BEGIN
    IF UPDATE(final_Price)
    BEGIN
        UPDATE Jewelry
        SET [status] = 'Final-Evaluated'
        WHERE jewelryID IN (SELECT jewelryID FROM Inserted) AND final_Price IS NOT NULL;
    END
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
CREATE TRIGGER autogenerate_auctionID
ON Auction
INSTEAD OF INSERT
AS 
BEGIN
    DECLARE @newauctionID NVARCHAR(50);

    INSERT INTO Auction (auctionID, startDate, endDate, startTime, endTime)
    SELECT 'Auc' + CAST(NEXT VALUE FOR auctionID_sequence AS NVARCHAR(50)), startDate, endDate, startTime, endTime
    FROM inserted;
END;
GO
CREATE TRIGGER autogenerate_sessionID
ON [Session]
INSTEAD OF INSERT
AS 
BEGIN
    DECLARE @newsessionID NVARCHAR(50);

    INSERT INTO [Session] (sessionID, auctionID, jewelryID)
    SELECT 'Turn' + CAST(NEXT VALUE FOR sessionID_sequence AS NVARCHAR(50)), auctionID, jewelryID
    FROM inserted;
END;
GO
CREATE SEQUENCE addressID_sequence
    START WITH 0
    INCREMENT BY 1;
GO
CREATE TRIGGER autogenerate_addressID
ON [Address]
INSTEAD OF INSERT
AS 
BEGIN
    DECLARE @newaddressID NVARCHAR(50);
    SET @newaddressID = 'Add' + CAST(NEXT VALUE FOR addressID_sequence AS NVARCHAR(50));
    INSERT INTO [Address] (addressID, city, state, zipcode, country, memberID, address1, address2)
    SELECT @newaddressID,  city, state, zipcode, country, memberID, address1, address2
    FROM inserted;
END;
GO
update Member set status_register_to_bid = 0 where memberID = 'Member5'
select * from Member

CREATE SEQUENCE memberID_sequence
    START WITH 0
    INCREMENT BY 1;
GO

CREATE TRIGGER autogenerate_memberID
ON Member
INSTEAD OF INSERT
AS
BEGIN
	DECLARE @newmemberID VARCHAR(50);
	SET @newmemberID = 'Member' + CAST(NEXT VALUE FOR memberID_sequence AS VARCHAR(50));
	INSERT INTO Member (memberID, userID, firstName, lastName, phoneNumber, gender, dob, avatar, status_register_to_bid, companyName)
	SELECT @newmemberID, userID, firstName, lastName, phoneNumber, gender, dob, avatar, status_register_to_bid, companyName
	FROM inserted;
END;
GO

UPDATE s
SET s.status = 0
FROM Session s
WHERE s.auctionID = (SELECT a.auctionId FROM Auction a WHERE a.auctionId = 'Auc73');

Select * from Jewelry j, Session s, Register_Bid r where j.jewelryID = s.jewelryID and s.sessionID = r.sessionID and s.sessionID = 'Turn45'

select j.jewelryID, j.photos, r.preBid_Amount  from Register_Bid r, Session s, Jewelry j where r.sessionID = s.sessionID and j.jewelryID = s.jewelryID and r.memberID = 'Member1' and s.status = 0
select * from Session where auctionID = 'Auc72'
select * from Session where status = 1
delete from Bid_Track
delete from Register_Bid
select * from Register_Bid
select * from Bid_Track

WITH MaxPreBid AS (
    SELECT 
        S.jewelryID,
        MAX(RB.preBid_Amount) AS max_preBid_Amount,
    FROM 
        Register_Bid RB
    JOIN 
        Session S ON RB.sessionID = S.sessionID
    GROUP BY 
        S.jewelryID
)
SELECT 
    J.*, 
    C.CATEGORYNAME, 
    MP.max_preBid_Amount,
FROM 
    JEWELRY J
JOIN 
    CATEGORY C ON J.CATEGORYID = C.CATEGORYID
JOIN 
    Session S ON J.jewelryID = S.jewelryID
JOIN 
    Auction AUC ON S.AUCTIONID = AUC.AUCTIONID
LEFT JOIN 
    MaxPreBid MP ON J.jewelryID = MP.jewelryID
WHERE 
    AUC.AUCTIONID = 'Auc73';

	Update Register_Bid set status = 'Placed'

select * from Register_Bid
select * from Session
Update Register_Bid Set status = 'Pending Payment' where memberID = ''
select * from Register_Bid where sessionID = 'Turn47'
SELECT MAX(MAX(bidAmount_Current) )AS maxBidAmount,  memberID FROM Register_Bid WHERE sessionID = 'Turn47' group by memberID, bidAmount_Current
select * from Register_Bid r, Session s where s.sessionID = r.sessionID and s.auctionID = 'Auc72' 
select * from Bid_Track

select j.jewelryID, j.photos, r.preBid_Amount, r.status  from Register_Bid r, Session s, Jewelry j where r.sessionID = s.sessionID and j.jewelryID = s.jewelryID and r.memberID = 'Member1'
select j.jewelryID, j.photos, r.preBid_Amount  from Register_Bid r, Session s, Jewelry j where r.sessionID = s.sessionID and j.jewelryID = s.jewelryID and r.memberID = ?

select * from Users
select * from Member

select * from Register_Bid r, Session s where r.sessionID = s.sessionID and s.jewelryID = 'Lot44'

select * FROM Auction WHERE status = 1

UPDATE Register_Bid 
SET status = 'Pending Payment'
WHERE memberID = 'Member1' 
  AND status = 'Paid'
  AND sessionID IN (
    SELECT s.sessionID
    FROM Session s
    WHERE s.jewelryID = 'Lot44'
  );

  select * from Jewelry
  delete from Invoice
  

  select j.jewelryID, j.jewelryName, j.photos, m.firstName, m.lastName, r.bidAmount_Current from Jewelry j, Session s, Register_Bid r, Member m where j.jewelryID = s.jewelryID and s.sessionID = r.sessionID and r.status = 'Paid' and r.memberID = m.memberID
  select inv.invoiceID, inv.invoiceDate, inv.totalAmount, j.jewelryID, j.jewelryName, j.photos, j.status,  m.firstName, m.lastName
  from Invoice inv, Member m, Jewelry j where inv.jewelryID = j.jewelryID and inv.memberID = m.memberID

  s
  select * from Session
  select * from Invoice

UPDATE rb
SET rb.status = 'Paid'
FROM Register_Bid rb
INNER JOIN [Session] s ON rb.sessionID = s.sessionID
WHERE s.jewelryID = 'Lot44' and rb.status = 'Delivery'

UPDATE Jewelry SET status = 'SOLD' where jewelryID = ?
select * from Jewelry
SELECT inv.invoiceID, inv.invoiceDate, inv.totalAmount, j.jewelryID, j.jewelryName, j.photos, m.firstName, m.lastName
FROM Invoice inv
JOIN Jewelry j ON inv.jewelryID = j.jewelryID
JOIN Member m ON inv.memberID = m.memberID
WHERE j.status = 'Confirmed';

alter table Jewelry
add Sold DECIMAL(18,2) default 0

UPDATE r
SET r.bidAmount_Current = 220
FROM Register_Bid r, Session s where r.sessionID = s.sessionID and s.jewelryID = 'Lot46'


select * from Users