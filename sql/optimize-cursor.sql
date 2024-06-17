-- CURSOR
DECLARE @StockItemID INT, @Description NVARCHAR(50)

DECLARE @SalesDetail TABLE
(
	OrderID INT NOT NULL,
	OrderLineID INT,
	Quantity int,
	PickedQuantity INT,
	StockItemID INT NOT NULL,
	Description NVARCHAR(50) NOT NULL
)
DECLARE MyCursorName --create cursor
CURSOR FAST_FORWARD
FOR
	SELECT StockItemID, BinLocation
--cursor base SELECT statement
FROM Warehouse.StockItemHoldings
WHERE BinLocation LIKE 'K9'

OPEN MyCursorName
FETCH NEXT FROM MyCursorName
INTO @StockItemID, @Description

WHILE @@FETCH_STATUS = 0
BEGIN
	INSERT INTO @SalesDetail
		(OrderID, StockItemID, Description, OrderLineID, Quantity, PickedQuantity)
	SELECT OrderID, @StockItemID, @Description, OrderLineID, Quantity, PickedQuantity
	FROM Sales.OrderLines
	WHERE StockItemID = @StockItemID

	FETCH NEXT FROM MyCursorName
INTO @StockItemID, @Description

END
CLOSE MyCursorName
DEALLOCATE MyCursorName

SELECT OrderLineID, Description, SUM(Quantity) AS Quantity, SUM(PickedQuantity) AS PickedQuantityX
FROM @SalesDetail sd
	JOIN Sales.Orders h ON sd.OrderID = h.OrderID
GROUP BY OrderLineID, Description


-- Optimized query
SELECT OrderLineID, Description, SUM(Quantity) AS Quantity, SUM(PickedQuantity) AS PickedQuantityX
FROM Sales.OrderLines ol
       JOIN Sales.Orders h ON ol.OrderID = h.OrderID
WHERE StockItemID IN
       (SELECT StockItemID
       FROM Warehouse.StockItemHoldings
       WHERE BinLocation LIKE 'K9')
GROUP BY OrderLineID, Description
