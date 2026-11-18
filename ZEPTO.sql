CREATE TABLE ZEPTO
(
sku_id	SERIAL	PRIMARY KEY,
Category	VARCHAR(100),	
name	VARCHAR(100),	
mrp	NUMERIC(10,3),	
discountPercent	NUMERIC(10,3),	
availableQuantity	NUMERIC(10,3),	
discountedSellingPrice	NUMERIC(10,3),	
weightInGms	NUMERIC(10,3),	
outOfStock	BOOLEAN,	
quantity	INT	

);


--CHECK THE FIELDS OF THE TABLE
SELECT * FROM ZEPTO;


--🔍 Data Exploration
--Counted the total number of records in the dataset
SELECT  COUNT(*) FROM ZEPTO;

--Viewed a sample of the dataset to understand structure and content
SELECT * FROM ZEPTO;


--Checked for null values across all columns
SELECT * FROM ZEPTO
WHERE CATEGORY IS NULL 
OR NAME IS NULL
OR MRP IS NULL 
OR DISCOUNTPERCENT IS NULL
OR AVAILABLEQUANTITY IS NULL
OR DISCOUNTEDSELLINGPRICE IS NULL
OR WEIGHTINGMS IS NULL 
OR OUTOFSTOCK IS NULL
OR QUANTITY IS NULL;

--Identified distinct (UNIQUE) product categories available in the dataset
SELECT DISTINCT(NAME) FROM ZEPTO;

--Compared in-stock vs out-of-stock product counts

SELECT OUTOFSTOCK AS IN_STOCK_Vs_OUT_OF_STOCK , COUNT(SKU_ID) FROM ZEPTO
GROUP BY OUTOFSTOCK ;

--Detected products present multiple times, representing different SKUs
SELECT name, COUNT(SKU_ID) AS "Number of SKUs"
FROM zepto
GROUP BY name
HAVING count(SKU_ID) > 1
ORDER BY count(SKU_ID) DESC;


--🧹 Data Cleaning
--Identified and removed rows where MRP or discounted selling price was zero
SELECT * FROM ZEPTO
WHERE MRP = 0 OR DISCOUNTEDSELLINGPRICE = 0; -- INDENTIFIED

DELETE FROM ZEPTO 
WHERE MRP = 0;



--Converted mrp and discountedSellingPrice from paise to rupees for consistency and readability
UPDATE ZEPTO
SET MRP = MRP / 100 ,
DISCOUNTEDSELLINGPRICE = DISCOUNTEDSELLINGPRICE / 100
;

--📊 Business Insights
--Found top 10 best-value products based on discount percentage
SELECT * FROM ZEPTO;

SELECT DISTINCT NAME, MRP, DISCOUNTPERCENT FROM ZEPTO 
ORDER BY DISCOUNTPERCENT DESC 
LIMIT 10;




--Identified high-MRP products that are currently out of stock (MRP IS CONSIDER HERE IS > 300)
SELECT DISTINCT NAME , MRP , AVAILABLEQUANTITY , OUTOFSTOCK FROM ZEPTO
WHERE OUTOFSTOCK = 'TRUE' AND MRP > 150
ORDER BY MRP DESC;


--Estimated potential revenue for each product category
SELECT CATEGORY , 
ROUND(SUM(DISCOUNTEDSELLINGPRICE * AVAILABLEQUANTITY) ,2)  AS REVENUE
FROM ZEPTO
GROUP BY CATEGORY
ORDER BY REVENUE;


--Filtered expensive products (MRP > ₹500) with minimal discount

SELECT * FROM ZEPTO
WHERE MRP > 500 AND DISCOUNTPERCENT < 10
ORDER BY MRP DESC, DISCOUNTPERCENT DESC;

--Ranked top 5 categories offering highest average discounts
SELECT CATEGORY , ROUND(AVG(DISCOUNTPERCENT),2) AS AVG_DISCOUNTS FROM ZEPTO
GROUP BY CATEGORY
ORDER BY ROUND(AVG(DISCOUNTPERCENT),2) DESC
LIMIT 5;


--Find the price per gram for products above 100g and sort by best value.

SELECT  
DISTINCT NAME , WEIGHTINGMS, DISCOUNTEDSELLINGPRICE,
ROUND(WEIGHTINGMS / DISCOUNTEDSELLINGPRICE ,2 )AS PRICE_PER_GRAM 
FROM ZEPTO
WHERE WEIGHTINGMS > 100
ORDER BY PRICE_PER_GRAM DESC;


--Grouped products based on weight into Low, Medium, and Bulk categories
SELECT DISTINCT NAME , WEIGHTINGMS,
CASE 
	WHEN WEIGHTINGMS < 1000 THEN 'LOW'
	WHEN WEIGHTINGMS < 5000 THEN 'MEDIUM'
	ELSE 'BULK'
	END AS WEIGHT_CATOGORIES
FROM ZEPTO;	

--Measured total inventory weight per product category
SELECT 
CATEGORY , ROUND(SUM(WEIGHTINGMS * AVAILABLEQUANTITY),2) AS TOTAL_INVENTORY_WEIGHT
FROM ZEPTO
GROUP BY CATEGORY
ORDER BY TOTAL_INVENTORY_WEIGHT; 

