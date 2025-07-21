# 🛒 Zepto SQL Data Analyst Portfolio Project

This project showcases an end-to-end **MySQL-based data analysis** workflow using product-level inventory data from **Zepto**, one of India’s fastest-growing quick-commerce startups. The objective was to simulate how a data analyst tackles messy real-world data, prepares it for insights, and performs business-driven analysis using SQL.

---

## 📌 Project Objectives

- Clean and preprocess raw product inventory data  
- Create a well-structured MySQL table with accurate datatypes  
- Perform exploratory data analysis (EDA) using SQL  
- Extract actionable business insights for inventory, pricing, and stock  
- Apply analytical thinking to simulate real e-commerce scenarios

---

## 🔍 Dataset Overview

The dataset represents a simulated export of Zepto’s live inventory. Each row corresponds to a unique SKU (Stock Keeping Unit), including variables like pricing, weight, quantity, and availability.

### 🔑 Key Columns

| Column Name              | Description |
|--------------------------|-------------|
| `sku_id`                 | Unique ID for each product entry |
| `name`                   | Product title as shown on the platform |
| `category`               | Product category (e.g., Fruits, Snacks, Beverages) |
| `mrp`                    | Maximum Retail Price in ₹ (converted from paise) |
| `discountPercent`        | Discount applied on MRP |
| `discountedSellingPrice` | Final price after discount |
| `availableQuantity`      | Units currently in inventory |
| `weightInGms`            | Product weight in grams |
| `outOfStock`             | Boolean showing stock availability |
| `quantity`               | Units per pack or weight count |

---

## 🧠 Key Insights Derived

- Top 10 most discounted products by percentage  
- Out-of-stock high-MRP products for priority restocking  
- Estimated potential revenue per category  
- Categories with highest average discount offers  
- Best value products by ₹/gram cost  
- Total weight of inventory by product category  
- Weight-based product segmentation (Low, Medium, Bulk)

---

## 🧠 Skills Demonstrated

- MySQL query design and debugging  
- SQL-based EDA and KPI tracking  
- Data cleaning & unit normalization  
- Business logic through conditional SQL queries  
- E-commerce domain knowledge application  

---

## 🛠️ Tools & Technologies Used

- **MySQL** (via MySQL Workbench)  
- **SQL**: Joins, CASE, Aggregation, CTEs  
- **Excel**: Dataset inspection and formatting  
- **VS Code**: Query planning and documentation  

---

## 🧪 Sample Query — Revenue by Category

```sql
SELECT 
    category,
    SUM(discountedSellingPrice * availableQuantity) AS estimated_revenue
FROM zepto
WHERE outOfStock = FALSE
GROUP BY category
ORDER BY estimated_revenue DESC;
```

## 🚀 Project Highlights

- Real-world simulation of e-commerce product inventory analysis  
- Applies SQL for both technical and business-level insights  
- End-to-end workflow from raw data to strategic insights  
- Clean, modular SQL queries for real interview and job use cases  
- Portfolio-ready project for GitHub and LinkedIn display

---

## 📬 Let’s Connect

> 📌 This project is part of my journey into **Data Analytics**.  
> Feel free to explore the project, give feedback, or connect with me on [LinkedIn](https://www.linkedin.com/in/gitesh-garg/)

---

## 🏷️ Tags

`#SQL` `#MySQL` `#Zepto` `#DataCleaning` `#RetailAnalytics` `#PortfolioProject` `#EcommerceAnalysis` `#DataAnalyst`
