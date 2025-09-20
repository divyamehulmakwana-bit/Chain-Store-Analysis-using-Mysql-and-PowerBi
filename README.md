# 📊 Chain Store Analysis using MySQL & Power BI

This project demonstrates an end-to-end **retail sales analysis** workflow — from **data cleaning & transformation in MySQL** to **interactive dashboards in Power BI**.  

It covers sales, customers, products, and store performance, enabling insights into **revenue trends, profitability, customer demographics, and regional performance**.

---

## 🚀 Project Workflow

### 1. Data Preparation (MySQL)
- Corrected data types (especially date columns).
- Wrote SQL queries to answer **20+ business questions**, such as:
  - List all products in a category (e.g., Electronics).
  - Total number of male and female customers.
  - Total Sales Revenue & Profit.
  - Top 5 Customers by Spend.
  - Monthly Sales Trend & Year-over-Year Growth.
  - Sales by Category, Store, and Region.
  - Best-selling Products.
  - Customer Demographics (Age, Gender, City).
  - New vs Returning Customers.
  - Customers with no transactions in the last 6 months.
  - Popular Payment Methods.
  - Profit per Product.

SQL was used to generate structured, analysis-ready datasets for Power BI.

---

### 2. Data Visualization (Power BI)
Created **4 dashboard pages** with slicers for **Country, Gender, Category, and Date**.  

---

### 📌 Sales Overview
**KPIs / Cards:**
- Total Profit (₹5M) vs PY (₹3.14M) → Growth ✅  
- Total Revenue (₹15.4M) vs PY (₹9.96M) → Growth ✅  
- Avg Order Value: ₹3.1K  
- Total Orders: 5K  
- Country with most revenue: Russia  

**Visuals:**
- Gauge chart for profit vs previous year’s profit.  
- Donut chart: Revenue by Store.  
- Combo chart: Revenue by Products & Orders.  
- Line chart: Monthly Sales Trend.  
- Donut chart: Revenue by Payment Method (Credit Card ~25.68%).  

![Sales Overview](https://github.com/divyamehulmakwana-bit/Chain-Store-Analysis-using-Mysql-and-PowerBi/blob/main/Screen%20Shots/Sales%20Overview%20Blue.png)

---

### 📌 Customer Analysis
**KPIs / Cards:**
- Total Customers: 200  
- Best Customer: *Brittny* (₹153K revenue, 50 orders).  
- Avg Spend per Customer: ₹77.38K  
- New Customers (last 6 months): 23  
- Avg Spend per Transaction: ₹3.12K  

**Visuals:**
- Line chart: Customers joined by month (peaks in Jan, Jun, Dec).  
- Donut chart: Gender split (56.5% Male).  
- Bar chart: Customers by Age Group (50–60 largest).  
- Combo chart: Revenue by Customers & Orders.  
- Treemap: Customers joining by day (Wed highest).  

![Customer Analysis](https://github.com/divyamehulmakwana-bit/Chain-Store-Analysis-using-Mysql-and-PowerBi/blob/main/Screen%20Shots/Customer%20Analysis%20Blue.png)

---

### 📌 Product Analysis
**KPIs / Cards:**
- Most Purchased Product: *Road Clothing* (₹139K revenue, 27 purchases).  
- Avg Product Price: ₹1.03K  
- Total Products: 50  
- Categories: 3 | Subcategories: 14  

**Visuals:**
- Bar chart: Revenue by Product.  
- Scatter plot: Profit vs Revenue.  
- Decomposition tree: Revenue breakdown (Category → Subcategory).  
- Treemap: Orders by Category & Subcategory.  

![Product Analysis](https://github.com/divyamehulmakwana-bit/Chain-Store-Analysis-using-Mysql-and-PowerBi/blob/main/Screen%20Shots/Product%20Analysis%20Blue.png)

---

### 📌 Store Performance
**KPIs / Cards:**
- Best Performing Store: *MegaMart* (₹3.16M revenue, 1K orders).  
- Best Performing Region: East  
- Best Performing Country: Russia  
- Total Stores: 5 | Countries: 5  

**Visuals:**
- Bar chart: Customers by Store.  
- Line chart: Profit over Year (East leading).  
- Map: Countries colored by Profit.  
- Matrix: Store-wise Orders, Revenue, Profit, Quantity, Profit Sparkline.  

![Store Performance](https://github.com/divyamehulmakwana-bit/Chain-Store-Analysis-using-Mysql-and-PowerBi/blob/main/Screen%20Shots/Store%20Performance%20Blue.png)

---

## 🛠️ Tools & Technologies
- **Database:** MySQL  
- **Visualization:** Power BI  
- **Techniques:** SQL Joins, Aggregations, Window Functions, DAX, Data Modeling  

---

## 📈 Key Insights
- Revenue grew **54% YoY** (₹15.4M vs ₹9.96M).  
- **Russia** generated the highest revenue across all countries.  
- **Accessories** category led in sales (₹2M, 556 orders).  
- Majority of customers were **aged 50–60**, with **male customers (56.5%)** being the largest segment.  
- **Credit Card** and **Cash** were equally popular (25% each).  
- *Brittny* emerged as the **most valuable customer**.  
- *MegaMart* (East Region, Russia) was the **top-performing store**.  

---

## 📂 Repository Structure
