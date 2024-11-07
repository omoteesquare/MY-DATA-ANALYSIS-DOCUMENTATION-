SELECT TOP (1000) [OrderID]
      ,[Customer_Id]
      ,[Product]
      ,[Region]
      ,[OrderDate]
      ,[Quantity]
      ,[UnitPrice]
      ,[Total_Sales]
  FROM [Project].[dbo].[Sales Data]

  SELECT * FROM [Sales Data];

   SELECT Product,SUM(Total_Sales) AS
  TotalSales
  FROM [Sales Data]
  GROUP BY Product
   
  --2 Find the number of sales transactions in each region
  SELECT Region, COUNT(OrderID) AS
  NumOfTransactions
  FROM [Sales Data]
  GROUP BY Region

  --3 find the highest selling product by total sales value-
  SELECT Top (1) Product, SUM(Total_Sales) 
  AS TotalSales
  FROM [Sales Data]
  GROUP BY Product
  ORDER BY TotalSales DESC

  --4 calculate total revenue per product
  SELECT Product,SUM(Total_Sales) AS
  TotalRevenue
  FROM [Sales Data]
  GROUP BY Product

  --5 calculate monthly sales totals for current year
  SELECT Month(OrderDate) AS Month,
  SUM(Total_Sales) AS MonthlySalesTotal FROM [Sales Data] WHERE YEAR(OrderDate) = 2024
  GROUP BY Month(OrderDate)
  ORDER BY Month

  --6 find the top 5 customers by total purchase amount--
  SELECT Top (5) Customer_id,
  SUM(Total_Sales) AS TotalPurchaseAmount
  FROM [Sales Data]
  GROUP BY Customer_Id
  ORDER BY TotalPurchaseAmount DESC

  --7 calculate the percentage of total sales contributed by each region--
  SELECT Region,SUM(Total_Sales) AS 
  RegionTotalSales,
  FORMAT(ROUND((SUM(Total_Sales)/
  CAST((SELECT SUM(Total_Sales) FROM
  [Sales Data] AS DECIMAL(10,2))*100),1),'0.#')
  AS PercentageOfTotalSales
  FROM [Sales Data]
  GROUP BY Region
  ORDER BY PercentageOfTotalSales 
  DESC

  --8 Identify products with no sales in the last quarter--
  SELECT Product FROM [Sales Data]
  GROUP BY Product
  HAVING SUM(CASE
  WHEN OrderDate BETWEEN
  '2024-06-01' AND '2024-08-31'
  THEN 1 ELSE 0 END)= 0