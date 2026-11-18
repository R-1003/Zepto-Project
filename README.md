# Zepto-Project
PostgreSQL SQL project analyzing Zepto product data, including discounts, pricing, inventory, stock availability, and business insights.

# 🛒 Zepto Product Data Analysis using SQL

## 📌 Project Overview

This project focuses on analyzing **Zepto product data using PostgreSQL**.

The project covers the complete SQL analysis process, starting from **data exploration and data quality checking**, followed by **data cleaning**, and finally **business-oriented analysis** to extract useful insights from product, pricing, discount, inventory, and stock data.

The main objective is to use SQL to answer practical business questions from the dataset.

---

## 🎯 Project Objectives

- Explore and understand the Zepto product dataset
- Identify missing and duplicate information
- Perform basic data cleaning
- Convert product prices from paise to rupees
- Analyze product discounts and pricing
- Analyze stock availability
- Estimate potential revenue by category
- Analyze inventory weight
- Categorize products based on weight
- Answer practical business questions using SQL

---

## 🗃️ Dataset & Table Structure

The project uses a single table named `ZEPTO`.

### Table: `ZEPTO`

| Column | Data Type | Description |
|---|---|---|
| `sku_id` | SERIAL | Unique SKU identifier |
| `Category` | VARCHAR(100) | Product category |
| `name` | VARCHAR(100) | Product name |
| `mrp` | NUMERIC(10,3) | Maximum Retail Price |
| `discountPercent` | NUMERIC(10,3) | Discount percentage |
| `availableQuantity` | NUMERIC(10,3) | Available product quantity |
| `discountedSellingPrice` | NUMERIC(10,3) | Selling price after discount |
| `weightInGms` | NUMERIC(10,3) | Product weight in grams |
| `outOfStock` | BOOLEAN | Stock availability status |
| `quantity` | INT | Product quantity |

---

# 🔍 Data Exploration

The first stage of the project was to understand the dataset before performing any analysis.

### 1. Check total number of records

```sql
SELECT COUNT(*) FROM ZEPTO;
```

This helps understand the overall size of the dataset.

### 2. View the dataset

```sql
SELECT * FROM ZEPTO;
```

This helps understand the available columns and the type of product information stored.

### 3. Check for NULL values

The project checks important columns for missing values before performing further analysis.

This is important because missing values can affect calculations such as:

- Average discount
- Revenue estimation
- Inventory calculations
- Product pricing analysis

### 4. Compare in-stock and out-of-stock products

```sql
SELECT OUTOFSTOCK, COUNT(SKU_ID)
FROM ZEPTO
GROUP BY OUTOFSTOCK;
```

This helps understand the distribution of product availability.

### 5. Identify products with multiple SKUs

```sql
SELECT name, COUNT(SKU_ID) AS "Number of SKUs"
FROM ZEPTO
GROUP BY name
HAVING COUNT(SKU_ID) > 1
ORDER BY COUNT(SKU_ID) DESC;
```

This identifies products that appear under multiple SKU records.

---

# 🧹 Data Cleaning

After exploring the data, cleaning operations were performed to make the data more suitable for analysis.

### 1. Identify products with zero price

```sql
SELECT *
FROM ZEPTO
WHERE MRP = 0
   OR DISCOUNTEDSELLINGPRICE = 0;
```

Records with zero MRP were then removed from the dataset.

### 2. Convert prices from paise to rupees

The dataset stores prices in paise, so the project converts them into rupees:

```sql
UPDATE ZEPTO
SET MRP = MRP / 100,
    DISCOUNTEDSELLINGPRICE = DISCOUNTEDSELLINGPRICE / 100;
```

This makes the pricing information easier to interpret and use in business analysis.

---

# 📊 Business Analysis

After data exploration and cleaning, SQL queries were used to answer business-related questions.

## Questions Answered

### 1. Which products have the highest discount percentages?

The project identifies the top 10 products based on discount percentage.

**SQL concepts used:**

- `DISTINCT`
- `ORDER BY`
- `DESC`
- `LIMIT`

---

### 2. Which high-MRP products are currently out of stock?

This analysis identifies products that have a higher MRP and are currently unavailable.

**SQL concepts used:**

- `WHERE`
- `AND`
- Boolean filtering
- `ORDER BY`

---

### 3. What is the estimated potential revenue for each category?

Potential revenue is calculated using:

**Discounted Selling Price × Available Quantity**

```sql
SELECT CATEGORY,
       ROUND(SUM(DISCOUNTEDSELLINGPRICE * AVAILABLEQUANTITY), 2) AS REVENUE
FROM ZEPTO
GROUP BY CATEGORY
ORDER BY REVENUE;
```

This helps compare the potential value of inventory across product categories.

---

### 4. Which expensive products have minimal discounts?

The project identifies products with:

- MRP greater than ₹500
- Discount less than 10%

This can help identify expensive products where customers receive relatively low discounts.

---

### 5. Which categories offer the highest average discounts?

The project calculates the average discount for each category and returns the top five categories.

**SQL concepts used:**

- `AVG()`
- `GROUP BY`
- `ROUND()`
- `ORDER BY`
- `LIMIT`

---

### 6. What is the price per gram of products?

For products above 100 grams, the project calculates price per gram.

This provides a normalized way to compare product pricing based on weight.

---

### 7. How can products be categorized based on weight?

A `CASE` statement is used to classify products into:

- **LOW** – below 1000 grams
- **MEDIUM** – below 5000 grams
- **BULK** – 5000 grams and above

This demonstrates how SQL can create business categories from numerical data.

---

### 8. What is the total inventory weight for each category?

The project calculates total inventory weight using:

**Product Weight × Available Quantity**

The result is grouped by product category.

---

# 🧠 SQL Concepts Practiced

This project helped practice the following PostgreSQL/SQL concepts:

### Basic SQL

- `SELECT`
- `WHERE`
- `DISTINCT`
- `ORDER BY`
- `LIMIT`
- `COUNT()`

### Aggregation

- `SUM()`
- `AVG()`
- `ROUND()`
- `GROUP BY`

### Filtering

- Multiple conditions using `AND`
- Boolean filtering
- `HAVING`

### Data Cleaning

- NULL checking
- Identifying invalid/zero values
- `DELETE`
- `UPDATE`
- Unit conversion

### Advanced SQL

- `CASE`
- Derived/calculated columns
- Aggregated business metrics

---

# 💡 Key Learnings

Through this project, I learned how SQL can be used beyond simple data retrieval.

The project follows a practical data-analysis workflow:

**Data → Exploration → Data Cleaning → Analysis → Business Insights**

I learned how to:

- Understand an unfamiliar dataset
- Check data quality before analysis
- Clean incorrect or unusable records
- Transform data into a usable format
- Calculate business metrics using SQL
- Group data to compare categories
- Create derived metrics
- Use conditional logic with `CASE`
- Convert business questions into SQL queries

---

# 🔎 Why Data Exploration Comes First

Before calculating business insights, it is important to understand the dataset.

For example, before calculating average discounts or revenue, we need to know:

- How many records exist?
- Are there NULL values?
- Are there duplicate products?
- Are prices stored correctly?
- Are products in stock or out of stock?

Therefore, the project starts with **data exploration and quality checks** before moving to business analysis.

---

# 📈 Business Value

The SQL analysis can help a business understand:

- Which products have attractive discounts
- Which expensive products are unavailable
- Which categories have higher inventory value
- Which categories provide higher average discounts
- How product pricing compares based on weight
- How much inventory is being held across categories

These types of analysis can support decisions related to **pricing, inventory management, product availability, and promotions**.

---

# 📁 Project Files

```text
Zepto-SQL-Analysis/
│
├── ZEPTO.sql
└── README.md
```

### `ZEPTO.sql`

Contains the complete SQL code used for:

- Data exploration
- Data cleaning
- Business analysis
- Product pricing analysis
- Discount analysis
- Inventory analysis

### `README.md`

Contains the project overview, questions, SQL concepts, and explanation of the analysis.

---

# 🚀 Future Improvements

The project can be further extended by:

- Creating more advanced SQL queries
- Adding product-level revenue analysis
- Creating monthly or category-level sales analysis if sales-date data is available
- Building a Power BI dashboard using the cleaned dataset
- Creating KPIs for inventory and product performance
- Performing deeper customer or order analysis if transaction-level data becomes available

---

# 📝 Project Summary

This project demonstrates the use of **PostgreSQL for real-world product data analysis**.

Instead of only writing individual SQL queries, the project follows a complete analytical workflow:

**Explore → Clean → Analyze → Generate Business Insights**

The project helped strengthen practical SQL skills in data exploration, data cleaning, aggregation, filtering, conditional logic, and business-oriented analysis.

---

## 🛠️ Tools Used

- **Database:** PostgreSQL
- **Language:** SQL
- **Dataset:** Zepto Product Data
- **Platform:** GitHub

---

