select count(*) from City

-- 2

select p.planName AS nameofplan,
p.price AS planPricee ,
idp.internetDataPlanName,
idp.dataAllowanceMB , 
idp.price AS internetDataPlanPrice ,
mno.operatorName 
From [Plan] p 
JOIN InternetDataPlan idp 
	ON p.internetDataPlanID = idp.internetDataPlanID 
JOIN MobileNetworkOperator mno 
	ON idp.operatorID = mno.operatorID;


-- 3
select serviceName from Service --service id for lithuanian call is id 2 
SELECT
    [mno].[operatorName],
    [p].[planName],
    [p].[price]
FROM [MobileNetworkOperator] AS [mno]
JOIN [Plan]        AS [p]  ON [p].[operatorID] = [mno].[operatorID]
JOIN [PlanBundle]  AS [pb] ON [pb].[planID]    = [p].[planID]
JOIN [Discount]    AS [d]  ON [d].[bundleID]   = [pb].[bundleID]
WHERE [pb].[serviceID] = 2
  AND [d].[quantity] >= 100;


--4
SELECT 
    c.cityName,
    COUNT(p.personID) AS numberOfUsers
FROM City AS c
JOIN Person AS p 
    ON p.cityID = c.cityID
GROUP BY c.cityName;
--5
SELECT cityName
FROM City
WHERE cityID NOT IN (
    SELECT cityID
    FROM Person
);

--6 excluding cities with no users;

SELECT 
    ROUND(AVG(1.0 * userCount), 3) AS averageUsersPerCity
FROM (
    SELECT 
        COUNT(p.personID) AS userCount
    FROM City AS c
    JOIN Person AS p ON p.cityID = c.cityID
    GROUP BY c.cityID
) AS CityTotals;


--6 including cities with no users.
SELECT 
    ROUND(
        1.0 * COUNT(p.personID) / (SELECT COUNT(*) FROM City), 
        3
    ) AS averageUsersPerCity
FROM City AS c
JOIN Person AS p ON p.cityID = c.cityID;

-- 7 
SELECT TOP 1 WITH TIES o.operatorName
FROM [MobileNetworkOperator] o
JOIN [Plan] p ON p.operatorID = o.operatorID
GROUP BY o.operatorID, o.operatorName
ORDER BY COUNT(*) DESC;

--8 for the question 8 the last year is 2024 and the question wants the one's betwen january 3, 2025 and January 10, 2025 so it filter nothing 

SELECT MIN([contractStartDate]) AS [firstDate], MAX([contractStartDate]) AS [lastDate]
FROM [Subscriber];
-- 8 corrected filtring between 2014 to 2015

SELECT
    [Person].[firstName],
    [Person].[lastName],
    [Plan].[planName],
    [Subscriber].[contractStartDate]
FROM [Subscriber]
JOIN [Person] ON [Person].[personID] = [Subscriber].[personID]
JOIN [Plan]   ON [Plan].[planID]     = [Subscriber].[planID]
WHERE [Subscriber].[contractStartDate] >= '2014-01-01'
  AND [Subscriber].[contractStartDate] <= '2015-01-01'
ORDER BY [Subscriber].[contractStartDate], [Person].[lastName];
-- 9
SELECT
    [MobileNetworkOperator].[operatorName],
    AVG([Plan].[price]) AS [avgPlanPrice]
FROM [MobileNetworkOperator]
JOIN [Plan] ON [Plan].[operatorID] = [MobileNetworkOperator].[operatorID]
GROUP BY [MobileNetworkOperator].[operatorID], [MobileNetworkOperator].[operatorName]
ORDER BY [avgPlanPrice] DESC;



-- 10
SELECT o.operatorName,
       (SELECT COUNT(*)
        FROM [OperatorAdditionalService] oas
        WHERE oas.operatorID = o.operatorID) AS numberOfAdditionalServices
FROM [MobileNetworkOperator] o;

-- Practical Assignment 3 

--1
SELECT AdditionalService.additionalServiceName, OperatorAdditionalService.price
FROM AdditionalService
JOIN OperatorAdditionalService ON AdditionalService.additionalServiceID = OperatorAdditionalService.additionalServiceID
WHERE OperatorAdditionalService.operatorID =3;
-- id of TELE 2 is 3

-- 2 
SELECT MobileNetworkOperator.operatorName, AdditionalService.additionalServiceName, OperatorAdditionalService.price
FROM AdditionalService
JOIN OperatorAdditionalService ON AdditionalService.additionalServiceID = OperatorAdditionalService.additionalServiceID
JOIN MobileNetworkOperator ON MobileNetworkOperator.operatorID = OperatorAdditionalService.operatorID

-- 3 
select [Zone].zoneName , COUNT (*) as  numberofcountrys
from Country
join [Zone] on [Zone].zoneID = Country.zoneID
GROUP BY [Zone].zoneName;
-- 4 
-- this one to get the country id code 
select countryName , countryCode From Country where countryCode = 0052
-- this one to select the service call the forigne contry (ID = 4)
select serviceName , serviceID from [Service] 
-- the query
select Top 1 MobileNetworkOperator.operatorName 
from MobileNetworkOperator
join ServicePriceInZone on ServicePriceInZone.operatorID = MobileNetworkOperator.operatorID
join [Zone] on [Zone].zoneID = [ServicePriceInZone].zoneID
join Country on [Country].zoneID = [Zone].zoneID
where ServicePriceInZone.serviceID = 4 and [Country].countryCode = 0052
order by ServicePriceInZone.price desc;
-- 5 
SELECT 
    MobileNetworkOperator.operatorName, 
    InternetDataPlan.internetDataPlanName, 
    InternetDataPlan.price
FROM InternetDataPlan
JOIN MobileNetworkOperator ON InternetDataPlan.operatorID = MobileNetworkOperator.operatorID
WHERE InternetDataPlan.internetDataPlanID NOT IN (
    SELECT internetDataPlanID FROM OrderedInternetDataPlan
)
and InternetDataPlan.price >0
ORDER BY InternetDataPlan.price ASC;

select * from InternetDataPlan
select * from [Plan]
--6
SELECT 
    MobileNetworkOperator.operatorName,
    COUNT(Subscriber.subscriberID) AS NombreAbonnes,
    (COUNT(Subscriber.subscriberID) * 100.0 / (SELECT COUNT(*) FROM Subscriber)) AS PourcentageDistribution
FROM Subscriber
JOIN [Plan] ON Subscriber.planID = [Plan].planID
JOIN MobileNetworkOperator ON [Plan].operatorID = MobileNetworkOperator.operatorID
GROUP BY MobileNetworkOperator.operatorName;
--7 
SELECT TOP 3
    [Plan].planName, 
    COUNT(Subscriber.subscriberID) AS SubscriberCount
FROM [Plan]
JOIN Subscriber ON [Plan].planID = Subscriber.planID
GROUP BY [Plan].planName
ORDER BY SubscriberCount DESC;


WITH PlanCounts AS (
    SELECT [Plan].planName,
           COUNT(Subscriber.subscriberID) AS SubscriberCount
    FROM [Plan]
    JOIN Subscriber ON [Plan].planID = Subscriber.planID
    GROUP BY [Plan].planID, [Plan].planName
)
SELECT a.planName,
       a.SubscriberCount
FROM PlanCounts a
WHERE (
    SELECT COUNT(DISTINCT b.SubscriberCount)
    FROM PlanCounts b
    WHERE b.SubscriberCount > a.SubscriberCount
) < 3
ORDER BY a.SubscriberCount DESC;
--8
SELECT TOP 10
    Person.firstName + ' ' + Person.lastName AS FullName,
    City.cityName,
    Subscriber.phoneNumber,
    Subscriber.contractStartDate,
    Subscriber.contractEndDate,
    MobileNetworkOperator.operatorName,
    [Plan].planName,

    (SELECT COUNT(*) FROM OrderedInternetDataPlan
     WHERE subscriberID = Subscriber.subscriberID) AS HasOrderedDataPlan,

    (SELECT COUNT(*) FROM OrderedAdditionalService
     WHERE subscriberID = Subscriber.subscriberID) AS HasOrderedAdditionalService

FROM Subscriber
JOIN Person ON Subscriber.personID = Person.personID
JOIN City ON Person.cityID = City.cityID
JOIN [Plan] ON Subscriber.planID = [Plan].planID
JOIN MobileNetworkOperator ON [Plan].operatorID = MobileNetworkOperator.operatorID

ORDER BY NEWID();
--9
SELECT TOP 5
    Subscriber.subscriberID,
    Person.firstName + ' ' + Person.lastName AS FullName,
    COUNT(*) AS NumberOfCalls

FROM Subscriber
JOIN Person
    ON Subscriber.personID = Person.personID
JOIN P2PConnection
    ON Subscriber.subscriberID = P2PConnection.subscriberID

WHERE P2PConnection.serviceID = 1
AND P2PConnection.connectionStart >= '2013-10-01'
AND P2PConnection.connectionStart < '2013-11-01'

GROUP BY
    Subscriber.subscriberID,
    Person.firstName,
    Person.lastName

ORDER BY NumberOfCalls DESC;
--10
SELECT c.countryName
FROM P2PConnection p
JOIN Country c ON c.countryCode = p.recipientCountry
WHERE p.recipientCountry <> p.connectionInitializationPlace
GROUP BY c.countryName
HAVING COUNT(*) = (
    SELECT MAX(cnt)
    FROM (
        SELECT COUNT(*) AS cnt
        FROM P2PConnection p2
        WHERE p2.recipientCountry <> p2.connectionInitializationPlace
        GROUP BY p2.recipientCountry
    ) AS counts
);
    
        SELECT COUNT(*) AS cnt
        FROM P2PConnection p2
        WHERE p2.recipientCountry <> p2.connectionInitializationPlace
        GROUP BY p2.recipientCountry
    
SELECT c.countryName,
       COUNT(*) AS numberOfCalls
FROM P2PConnection p
JOIN Country c ON c.countryCode = p.recipientCountry
WHERE p.recipientCountry <> p.connectionInitializationPlace
GROUP BY c.countryName
HAVING COUNT(*) = (
    SELECT MAX(cnt)
    FROM (
        SELECT COUNT(*) AS cnt
        FROM P2PConnection p2
        WHERE p2.recipientCountry <> p2.connectionInitializationPlace
        GROUP BY p2.recipientCountry
    ) AS counts
);
-- -1
ALTER TABLE Subscriber 
ADD discount DECIMAL(3,2) NOT NULL DEFAULT 0.00;

-- -2
ALTER TABLE Person 
ADD email VARCHAR(50) NULL;

-- -3
CREATE TABLE Domain (
    domainID INT IDENTITY(1,1) PRIMARY KEY,
    domainName VARCHAR(15) NOT NULL
);

-- -4
INSERT INTO Domain (domainName) VALUES 
('gmail.com'), 
('yahoo.com'), 
('hotmail.com'), 
('eif.viko.lt');

-- -5
UPDATE p
SET p.email = LOWER(p.firstName) + '.' + LOWER(p.lastName) + '@' + d.domainName
FROM Person p
CROSS APPLY (
    SELECT TOP 1 domainName 
    FROM Domain 
    ORDER BY NEWID()
) d;

-- -6 & -7
CREATE TABLE MobilePhone (
    mobTelID INT IDENTITY(1,1) PRIMARY KEY,
    manufacturer VARCHAR(15),
    model VARCHAR(30),
    price FLOAT,
    monthlyPrice FLOAT
);

-- -8
ALTER TABLE Subscriber 
ADD mobTelID INT NULL;

-- -9
ALTER TABLE Subscriber
ADD CONSTRAINT FK_Subscriber_MobilePhone 
FOREIGN KEY (mobTelID) REFERENCES MobilePhone(mobTelID);