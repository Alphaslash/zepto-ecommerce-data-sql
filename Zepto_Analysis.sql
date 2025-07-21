--  Basic Table Inspection
SELECT COUNT(*) FROM zepto_v2;

SELECT * FROM zepto_v2
LIMIT 10;

-- 🛠️ Table Structure Updates (Rename, Add Primary Key, Modify Column Types)

-- Rename incorrectly encoded column
ALTER TABLE zepto_v2
CHANGE COLUMN ï»¿Category category VARCHAR(120);

-- Add sku_id as AUTO_INCREMENT PRIMARY KEY (if not already exists)
ALTER TABLE zepto_v2
ADD COLUMN sku_id INT AUTO_INCREMENT PRIMARY KEY;

-- Modify data types of existing columns
ALTER TABLE zepto_v2
MODIFY COLUMN category VARCHAR(120),
MODIFY COLUMN name VARCHAR(150) NOT NULL,
MODIFY COLUMN mrp DECIMAL(8,2),
MODIFY COLUMN discountPercent DECIMAL(5,2),
MODIFY COLUMN availableQuantity INT,
MODIFY COLUMN discountedSellingPrice DECIMAL(8,2),
MODIFY COLUMN weightInGms INT,
MODIFY COLUMN outOfStock BOOLEAN,
MODIFY COLUMN quantity INT;

-- Data Quality Checks
SELECT * FROM zepto_v2
WHERE category IS NULL
   OR name IS NULL
   OR mrp IS NULL
   OR discountPercent IS NULL
   OR availableQuantity IS NULL
   OR discountedSellingPrice IS NULL
   OR weightInGms IS NULL
   OR outOfStock IS NULL
   OR quantity IS NULL;

-- Data Exploration
SELECT DISTINCT category
FROM zepto_v2
ORDER BY category;

SELECT outOfStock, COUNT(sku_id) AS Count
FROM zepto_v2
GROUP BY outOfStock;

SELECT name, COUNT(sku_id) AS Count
FROM zepto_v2
GROUP BY name
HAVING COUNT(sku_id) > 1
ORDER BY Count DESC;

-- 🧹 Data Cleaning
SELECT * FROM zepto_v2
WHERE mrp = 0
   OR discountedSellingPrice = 0;

SET SQL_SAFE_UPDATES = 0;

DELETE FROM zepto_v2
WHERE mrp = 0;

-- Data Transformation - Convert paise to rupees
ALTER TABLE zepto_v2
MODIFY COLUMN mrp DECIMAL(8,2),
MODIFY COLUMN discountedSellingPrice DECIMAL(8,2);

UPDATE zepto_v2
SET mrp = mrp / 100.0,
    discountedSellingPrice = discountedSellingPrice / 100.0;

UPDATE zepto_v2
SET mrp = mrp * 100,
    discountedSellingPrice = discountedSellingPrice * 100;

SELECT FORMAT(mrp, 2) AS mrp, FORMAT(discountedSellingPrice, 2) AS discountedSellingPrice
FROM zepto_v2;

-- data analysis

-- Q1. Find the top 10 best-value products based on the discount percentage.
SELECT DISTINCT name, mrp, discountPercent
FROM zepto_v2
ORDER BY discountPercent DESC
LIMIT 10;

-- Q2.What are the Products with High MRP but Out of Stock

SELECT DISTINCT name, mrp
FROM zepto_v2
WHERE outOfStock = 'true' AND mrp > 300
ORDER BY mrp DESC;

-- Q3.Calculate Estimated Revenue for each category
SELECT category,
SUM(discountedSellingPrice * availableQuantity) AS total_revenue
FROM zepto_v2
GROUP BY category
ORDER BY total_revenue;

-- Q4. Find all products where MRP is greater than ₹500 and discount is less than 10%.
SELECT DISTINCT name, mrp, discountPercent
FROM zepto_v2
WHERE mrp > 500 AND discountPercent < 10
ORDER BY mrp DESC, discountPercent DESC;

-- Q5. Identify the top 5 categories offering the highest average discount percentage.
SELECT category,
ROUND(AVG(discountPercent),2) AS avg_discount
FROM zepto_v2
GROUP BY category
ORDER BY avg_discount DESC
LIMIT 5;

-- Q6. Find the price per gram for products above 100g and sort by best value.
SELECT DISTINCT name, weightInGms, discountedSellingPrice,
ROUND(discountedSellingPrice/weightInGms,2) AS price_per_gram
FROM zepto_v2
WHERE weightInGms >= 100
ORDER BY price_per_gram;

-- Q7.Group the products into categories like Low, Medium, Bulk.
SELECT DISTINCT name, weightInGms,
CASE WHEN weightInGms < 1000 THEN 'Low'
	WHEN weightInGms < 5000 THEN 'Medium'
	ELSE 'Bulk'
	END AS weight_category
FROM zepto_v2;

-- Q8.What is the Total Inventory Weight Per Category 
SELECT category,
SUM(weightInGms * availableQuantity) AS total_weight
FROM zepto_v2
GROUP BY category
ORDER BY total_weight;

