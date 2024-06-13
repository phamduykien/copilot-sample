SELECT p.ProductID, p.ProductName, 
       (SELECT SUM(od.Quantity) 
        FROM OrderDetails od 
        WHERE od.ProductID = p.ProductID AND od.OrderDate > '2024-05-01' AND od.OrderDate < '2024-06-01') AS TotalQuantitySold
FROM Products p
WHERE p.Discontinued = 0;

-- Optimized query
SELECT p.ProductID, p.ProductName, 
       SUM(od.Quantity) AS TotalQuantitySold
FROM Products p
JOIN OrderDetails od ON od.ProductID = p.ProductID
WHERE p.Discontinued = 0 AND od.OrderDate > '2024-05-01' AND od.OrderDate < '2024-06-01'
GROUP BY p.ProductID, p.ProductName;





