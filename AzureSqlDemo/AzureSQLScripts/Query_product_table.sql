--Getting Product number and names
SELECT [ProductID]
      ,[Name]
      ,[ProductNumber]      
  FROM [SalesLT].[Product]

--Simply join
SELECT c.FirstName, c.LastName, c.Title, adr.AddressType
FROM SalesLT.Customer c
JOIN SalesLT.CustomerAddress adr
        ON c.CustomerID = adr.CustomerID


--Gets total customer counts per sales person		
SELECT SalesPerson, Count(SalesPerson) AS CustomerCount
FROM [SalesLT].[Customer]
GROUP BY SalesPerson


--Gets all sales people with more than 100 customers
SELECT SalesPerson, Count(SalesPerson) AS TotalCustomers
FROM [SalesLT].[Customer]
GROUP BY SalesPerson
HAVING COUNT(SalesPerson) >= 100