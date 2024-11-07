SELECT TOP (1000) [CustomerID]
      ,[CustomerName]
      ,[Region]
      ,[SubscriptionType]
      ,[SubscriptionStart]
      ,[SubscriptionEnd]
      ,[Canceled]
      ,[Revenue]
      ,[Cancellation_Rate]
  FROM [Project].[dbo].[Customer Data]

   SELECT * FROM [Customer Data];
  
  --1 total number of customers from each region-
  SELECT Region,COUNT(CustomerID)
  AS NumberOfCustomer
  FROM [Customer Data]
  GROUP BY Region

  --2 most popular subscription type by number of customers--
  SELECT TOP 1 SubscriptionType,
  COUNT(CustomerID) AS
  CustomerCount
  FROM[Customer Data]
  GROUP BY SubscriptionType
  ORDER BY CustomerCount DESC;

  --3 customer who cancelled their subscription within 6months--
  SELECT CustomerName
  FROM [Customer Data]
  WHERE Canceled=1
  AND DATEDIFF(MONTH,
  SubscriptionStart,SubscriptionEnd)<=6;

  --4 Average subscription duration for all customers--
  SELECT AVG(DATEDIFF(DAY,
  SubscriptionStart,SubscriptionEnd))
  AS AverageSubscriptionDuration
  FROM [Customer Data]

  --5 customers with subscription longer than 12 months--
  SELECT CustomerName
  FROM [Customer Data]
  WHERE DATEDIFF(MONTH,
  SubscriptionStart,SubscriptionEnd)>12;

  --6 total revenue by subscription type
SELECT SubscriptionType,
SUM(Revenue) AS TotalRevenue
FROM [Customer Data]
GROUP BY SubscriptionType;

-- 7 Top 3 regions by subscription cancellation--
   SELECT TOP 3 Region,
   COUNT(CustomerID) AS Cancellations 
   FROM [Customer Data]
   WHERE Canceled = 1
   GROUP BY Region
   ORDER BY Cancellations DESC;

   --8 total number of active and cancelled subscription--
   SELECT SUM(CASE WHEN Canceled
   =0 THEN 1 ELSE 0 END) AS ActiveSubscriptions,
   SUM(CASE WHEN Canceled
   =1 THEN 1 ELSE 0 END) AS CanceledSubscriptions
   FROM [Customer Data]
 
  