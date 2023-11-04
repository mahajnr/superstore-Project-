select * 
from PortfolioProject..Orders

--total revenue

select [Unit Price]*[Quantity ordered new]-[Sales] as 'total revenue' 
from PortfolioProject..Orders


-- total cost
select [Unit Price]+[Shipping Cost] as 'total cost' 
from PortfolioProject..Orders

select [Unit Price]*[Quantity ordered new]-[Sales] as 'total revenue' , [Unit Price]+[Shipping Cost] as 'total cost' 
from PortfolioProject..Orders

--gross profit
SELECT
    ([Unit Price] * [Quantity ordered new] - [Sales]) - ([Unit Price] + [Shipping Cost]) AS 'Gross Profit'
FROM PortfolioProject..Orders
 where Region = 'west' or Region = 'south'

 --gross profit
 -- customer shipping mode and profit made from their shipment
SELECT [Customer Name], [Ship Mode],
    ([Unit Price] * [Quantity ordered new] - [Sales]) - ([Unit Price] + [Shipping Cost]) AS 'Gross Profit'
FROM PortfolioProject..Orders
 where [Ship Mode] in ('Delivery truck', 'express air')
 order by [Customer Name] ASC



-- TEMP TABLE
CREATE TABLE #GrossProfit
(
    [customer segment] nvarchar(255),
    [product categories] nvarchar(255),
    [total revenue] numeric,
    [total cost] numeric
)

-- Insert data into the temporary table
INSERT INTO #GrossProfit
SELECT
    [customer segment],
    [product category],
    [Unit Price] * [Quantity ordered new] - [Sales] AS 'total revenue',
    [Unit Price] + [Shipping Cost] AS 'total cost'
FROM PortfolioProject..Orders
WHERE ([Unit Price] * [Quantity ordered new] - [Sales]) > 0
ORDER BY 2, 3;
 
select * from #GrossProfit
where [customer segment] in ('home office','corporate')
--
--drop table if exists #GrossProfit

