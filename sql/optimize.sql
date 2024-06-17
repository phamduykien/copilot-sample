SELECT p.ProductID, p.ProductName, 
       (SELECT SUM(od.Quantity) 
        FROM OrderDetails od 
        WHERE od.ProductID = p.ProductID ) AS TotalQuantitySold
FROM Products p
WHERE p.Discontinued = 0;

-- Optimized query
SELECT p.ProductID, p.ProductName, 
       SUM(od.Quantity) AS TotalQuantitySold
FROM Products p
JOIN OrderDetails od ON od.ProductID = p.ProductID
WHERE p.Discontinued = 0 
GROUP BY p.ProductID, p.ProductName;





