show databases;                                             -- to view all databases

create database NFT_PRO;                                    -- to create a new database

use NFT_PRO;                                                -- to use the database

-- imported data using table data import wizard

describe nft_top_collections;                                -- to see the table structure

select * from nft_top_collections;                           -- to view our data

/* Q1. Identify the top 3 collections that have a higher 
average price than the average of all collections and list their market cap and floor price. */

                                                                            -- Using Subquery

SELECT Name, Average_Price_USD, Market_Cap_USD, Floor_Price_USD
FROM nft_top_collections
WHERE Average_Price_USD > (
    SELECT AVG(Average_Price_USD)
    FROM nft_top_collections
)
ORDER BY Average_Price_USD DESC
LIMIT 3;

                                                                                   -- Using CTE + Window Function

WITH avg_price AS (
    SELECT AVG(Average_Price_USD) AS overall_avg_price FROM nft_top_collections
)
SELECT Name, Average_Price_USD, Market_Cap_USD, Floor_Price_USD
FROM nft_top_collections, avg_price
WHERE Average_Price_USD > overall_avg_price
ORDER BY Average_Price_USD DESC
LIMIT 3;


/* Q2. Rank collections by their owner-to-asset ratio and return those in the top 5,
along with their total sales and category. */

/* Using ORDER BY + LIMIT */

SELECT Name, Owner_Asset_Ratio, Sales, Category
FROM nft_top_collections
ORDER BY Owner_Asset_Ratio DESC
LIMIT 5;


/* Using Window Function (RANK) */

WITH ranked_assets AS (
 SELECT Name, Owner_Asset_Ratio, Sales, Category,
 RANK() OVER (ORDER BY Owner_Asset_Ratio DESC) AS rank_pos
 FROM nft_top_collections
)
SELECT Name, Owner_Asset_Ratio, Sales, Category
FROM ranked_assets
WHERE rank_pos <= 5;

/* Q3. Find collections that contribute more than 10% of the total volume in USD and
display their relative percentage. */

/* Using subquery */

SELECT Name, Volume_USD,
 ROUND((Volume_USD * 100.0) / (
 SELECT SUM(Volume_USD) FROM nft_top_collections
 ), 2) AS Volume_Percentage
FROM nft_top_collections
WHERE (Volume_USD * 100.0) / (
 SELECT SUM(Volume_USD) FROM nft_top_collections
 ) > 10;
 
 /* Using Window Function and WITH clause */
WITH vol_percent AS (
 SELECT Name, Volume_USD,
 ROUND((Volume_USD * 100.0) / SUM(Volume_USD) OVER (), 2) AS Volume_Percentage
 FROM nft_top_collections
)
SELECT Name, Volume_USD, Volume_Percentage
FROM vol_percent
WHERE Volume_Percentage > 10;

/* Q4. Show collections with a floor price greater than the average but having sales
below average. */

/* Using subqueries */

SELECT Name, Floor_Price, Sales
FROM nft_top_collections
WHERE Floor_Price > (SELECT AVG(Floor_Price) FROM nft_top_collections)
 AND Sales < (SELECT AVG(Sales) FROM nft_top_collections);
 
/* Using CTE */

WITH stats AS (
 SELECT AVG(Floor_Price) AS avg_floor, AVG(Sales) AS avg_sales FROM nft_top_collections
)
SELECT c.Name, c.Floor_Price, c.Sales
FROM nft_top_collections c, stats
WHERE c.Floor_Price > avg_floor AND c.Sales < avg_sales;


/* Q5. Show the top 3 collections by sales per asset (Sales divided by Assets). */

/* Using derived column */

SELECT Name, Sales, Assets,
 ROUND(Sales / Assets, 2) AS Sales_Per_Asset
FROM nft_top_collections
ORDER BY Sales_Per_Asset DESC
LIMIT 3;

/* Using CTE */

WITH sales_ratio AS (
 SELECT Name, Sales, Assets,
 ROUND(Sales / Assets, 2) AS Sales_Per_Asset
 FROM nft_top_collections
)
SELECT * FROM sales_ratio
ORDER BY Sales_Per_Asset DESC
LIMIT 3;

/* Q6. Identify collections with above-average sales and volume (USD). */

/* Using subqueries */

SELECT Name, Sales, Volume_USD
FROM nft_top_collections
WHERE Sales > (SELECT AVG(Sales) FROM nft_top_collections)
 AND Volume_USD > (SELECT AVG(Volume_USD) FROM nft_top_collections);
 
/* Using CTE */

WITH avg_metrics AS (
 SELECT AVG(Sales) AS avg_sales, AVG(Volume_USD) AS avg_volume
 FROM nft_top_collections
)
SELECT n.Name, n.Sales, n.Volume_USD
FROM nft_top_collections n, avg_metrics
WHERE n.Sales > avg_sales AND n.Volume_USD > avg_volume;

/* Q7. Rank collections based on the percentage difference between average and floor
price. */

/* Simple math + ORDER BY */

SELECT Name, Average_Price_USD, Floor_Price_USD,
 ROUND(((Average_Price_USD - Floor_Price_USD) / Floor_Price_USD) * 100, 2) AS
Percent_Diff
FROM nft_top_collections
ORDER BY Percent_Diff DESC;

/* Using Window Function + CTE */

WITH diff_rank AS (
 SELECT Name, Average_Price_USD, Floor_Price_USD,
 ROUND(((Average_Price_USD - Floor_Price_USD) / Floor_Price_USD) * 100, 2) AS
Percent_Diff,
 RANK() OVER (ORDER BY ((Average_Price_USD - Floor_Price_USD) / Floor_Price_USD)
DESC) AS Price_Rank
 FROM nft_top_collections
)
SELECT * FROM diff_rank
WHERE Price_Rank <= 5;

/* Q8. Return the collection with the highest number of sales and how much higher it is
than the average. */

/* Using subquery for AVG */

SELECT Name, Sales,
 Sales - (SELECT AVG(Sales) FROM nft_top_collections) AS Above_Avg_Sales
FROM nft_top_collections
ORDER BY Sales DESC
LIMIT 1;

/* Using CTE */

WITH avg_sales AS (
 SELECT AVG(Sales) AS avg_val FROM nft_top_collections
)
SELECT n.Name, n.Sales,
 n.Sales - avg_val AS Above_Avg_Sales
FROM nft_top_collections n, avg_sales
ORDER BY n.Sales DESC
LIMIT 1;

/* Q9. Calculate total market cap (USD) per category and show top 3 categories. */

/* Using GROUP BY */

SELECT Category, SUM(Market_Cap_USD) AS Total_Market_Cap
FROM nft_top_collections
GROUP BY Category
ORDER BY Total_Market_Cap DESC
LIMIT 3;

/* Using CTE + RANK */

WITH category_sum AS (
 SELECT Category, SUM(Market_Cap_USD) AS Total_Market_Cap
 FROM nft_top_collections
 GROUP BY Category
),
ranked AS (
 SELECT *, RANK() OVER (ORDER BY Total_Market_Cap DESC) AS cat_rank
 FROM category_sum
)
SELECT Category, Total_Market_Cap
FROM ranked
WHERE cat_rank <= 3;

/* Q10. For each collection, show its share (%) of the total average price in the
dataset. */

/* Using subquery */

SELECT Name, Average_Price_USD,
 ROUND((Average_Price_USD * 100.0) / (
 SELECT SUM(Average_Price_USD) FROM nft_top_collections
 ), 2) AS Price_Share_Percent
FROM nft_top_collections;

/* Using Window Function */

SELECT Name, Average_Price_USD,
 ROUND((Average_Price_USD * 100.0) / SUM(Average_Price_USD) OVER (), 2) AS
Price_Share_Percent
FROM nft_top_collections;

/* Q11. Find collections with fewer assets than average but more owners than average. */

/* Using subqueries */

SELECT Name, Owners, Assets
FROM nft_top_collections
WHERE Assets < (SELECT AVG(Assets) FROM nft_top_collections)
 AND Owners > (SELECT AVG(Owners) FROM nft_top_collections);
 
/* Using CTE */

WITH stats AS (
 SELECT AVG(Assets) AS avg_assets, AVG(Owners) AS avg_owners FROM nft_top_collections
)
SELECT n.Name, n.Owners, n.Assets
FROM nft_top_collections n, stats
WHERE n.Assets < avg_assets AND n.Owners > avg_owners;

/* Q12. List collections whose average price is above the median of all collections. */

/* Using CTE + ROW_NUMBER */

WITH ranked AS (
 SELECT Name, Average_Price_USD,
 ROW_NUMBER() OVER (ORDER BY Average_Price_USD) AS row_num,
 COUNT(*) OVER () AS total_rows
 FROM nft_top_collections
),
median_val AS (
 SELECT Average_Price_USD AS median_price
 FROM ranked
 WHERE row_num = FLOOR((total_rows + 1) / 2)
)
SELECT n.Name, n.Average_Price_USD
FROM nft_top_collections n, median_val
WHERE n.Average_Price_USD > median_price;







