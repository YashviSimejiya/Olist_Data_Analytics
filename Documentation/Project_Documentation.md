# Olist E-Commerce Analytics Project

**End-to-end Data Analysis using MySQL, Excel Power Query, Power Pivot &
DAX**

------------------------------------------------------------------------

## 1. Project Overview

This project analyzes the **Olist Brazilian E-Commerce dataset** to
evaluate business performance across sales, orders, customers, products,
sellers, payments, reviews, delivery, and logistics.

The project was designed as an end-to-end Data Analyst workflow:

**Raw CSV data → MySQL database → data validation & quality checks →
business analysis → Excel Power Query → Power Pivot data model → DAX
measures → PivotTables/PivotCharts → business dashboard → insights &
recommendations**

The goal was not only to calculate KPIs, but to demonstrate the
analytical reasoning required to turn transactional data into reliable
business decisions.

------------------------------------------------------------------------

## 2. Business Problem

Raw E-commerce transactions do not directly explain whether the business
is growing, where customers are concentrated, which products drive
sales, whether delivery performance is strong, or what operational
issues may affect customer satisfaction.

The analysis therefore addresses questions across five major areas:

### Commercial Performance

-   How are product sales performing over time?
-   What are the monthly and annual sales trends?
-   Which product categories generate the most sales?
-   How does freight cost move with sales?

### Customers

-   How large is the actual customer base?
-   Where are customers geographically concentrated?
-   Which customers are repeat customers?
-   How can customer behavior be evaluated using cohort and RFM
    analysis?

### Operations

-   What proportion of orders reach delivered status?
-   How long does delivery take?
-   Does delivery performance relate to customer experience?

### Customer Experience

-   What is the average review score?
-   What proportion of customers give positive ratings?
-   Which factors should be investigated behind low-rated orders?

### Data Reliability

-   Are joins producing correct row counts?
-   Is the order-item grain correctly understood?
-   Can payments or reviews accidentally multiply transactional values?
-   Are customer counts based on the correct customer identifier?

------------------------------------------------------------------------

## 3. Project Objectives

1.  Analyze overall sales and revenue performance.
2.  Identify monthly and annual sales trends.
3.  Measure order volume and the actual customer base.
4.  Identify high-performing product categories.
5.  Analyze customer geographic concentration.
6.  Evaluate delivery completion and delivery time.
7.  Analyze customer satisfaction through review scores.
8.  Examine freight costs relative to product sales.
9.  Analyze payments, sellers, repeat customers, cohorts, and customer
    value where relevant.
10. Build a reliable relational analytical model.
11. Perform explicit data-quality and validation checks.
12. Create dynamic DAX measures rather than relying on hardcoded
    dashboard values.
13. Translate analytical results into business recommendations.

------------------------------------------------------------------------

## 4. Dataset & Data Model

The project uses nine Olist datasets:

| Table | Purpose | Key Identifier |
|---|---|---|
| `customers` | Customer and location information | `customer_id`, `customer_unique_id` |
| `orders` | Order status and timestamps | `order_id` |
| `order_items` | Products, prices, freight, and sellers within orders | `order_id`, `order_item_id` |
| `order_payments` | Payment methods, installments, and payment values | `order_id` |
| `order_reviews` | Customer review scores and comments | `review_id`, `order_id` |
| `products` | Product information and categories | `product_id` |
| `sellers` | Seller information | `seller_id` |
| `geolocation` | Brazilian geographic information | Geographic identifiers |
| `product_category_translation` | Portuguese-to-English category translation | `product_category_name` |

### Analytical Grain

Understanding table grain was an important part of the project.

-   **Orders** are at order level.
-   **Order items** are at order-line level.
-   `order_item_id` is only unique **within an order**, so an order item
    is identified by the combination `(order_id, order_item_id)`.
-   **Payments** can contain multiple rows for an order.
-   **Reviews** require order-level thinking when being connected to
    item/category data.
-   `customer_id` is associated with Olist\'s order/customer records,
    while **`customer_unique_id` represents the actual customer
    identity** and is therefore used for customer-level and
    repeat-purchase analysis.

This distinction prevents common analytical errors such as overstating
customer counts or duplicating review and payment values.

### Power Pivot Relationships

The Excel Data Model connects the principal tables through their
business keys:

-   `customers[customer_id]` → `orders[customer_id]`
-   `orders[order_id]` → `order_items[order_id]`
-   `orders[order_id]` → `order_payments[order_id]`
-   `orders[order_id]` → `order_reviews[order_id]`
-   `products[product_id]` → `order_items[product_id]`
-   `sellers[seller_id]` → `order_items[seller_id]`
-   `product_category_translation[product_category_name]` →
    `products[product_category_name]`
-   Calendar → order purchase date for time-based analysis

The resulting model allows transaction-level data to be analyzed through
customer, product, seller, category, and calendar dimensions without
unnecessarily flattening every table into one large dataset.

------------------------------------------------------------------------

## 5. Data Preparation & Quality Control

Data preparation was performed in both MySQL and Excel Power Query.

### Preparation Activities

-   Imported the Olist CSV datasets into MySQL.
-   Created the required database tables.
-   Loaded and validated the source data.
-   Checked row counts and data completeness.
-   Reviewed null and duplicate conditions where relevant.
-   Standardized and interpreted date/timestamp fields.
-   Created a calendar table for time-based reporting.
-   Created month labels and sorting fields to maintain chronological
    monthly reporting.
-   Used `customer_unique_id` for customer-level analysis.
-   Used `order_items.price` for product-sales analysis.
-   Kept `freight_value` separate from product sales and combined it
    only when calculating total revenue.
-   Applied order-level logic to review analysis.
-   Used aggregation before combining tables when necessary to prevent
    join multiplication.

### Important QC Findings

Several checks materially affected the analytical design.

#### 1. Order-item grain

A check based only on `order_item_id` would incorrectly suggest
duplication because `order_item_id` restarts within different orders.

**Correct grain:** `(order_id, order_item_id)`.

#### 2. Customer identity

Counting `customer_id` as customers would not correctly represent the
actual customer base for repeat behavior.

**Customer-level identity:** `customer_unique_id`.

#### 3. Payment multiplication

Joining raw order items directly to raw payments can multiply item-level
sales because an order may have multiple payment rows.

**Approach:** aggregate at the appropriate order grain before combining
payment information with item-level analysis.

#### 4. Review multiplication

Joining item/category rows directly to reviews can repeat an order\'s
review score across multiple item rows.

**Approach:** use order-level or deduplicated logic for review-based
analysis.

#### 5. Payment coverage

The payment dataset contains one fewer order than the full order
dataset, so payment coverage was explicitly checked rather than assuming
every order has a payment row.

#### 6. Cohort calculation

Calendar-month cohort calculations use calendar month differences rather
than raw elapsed-month duration, avoiding misleading cohort periods
around month boundaries.

These checks demonstrate that the project treated **data reliability and
analytical grain as part of the analysis**, not as an afterthought.

------------------------------------------------------------------------

## 6. Analytical Logic & Metric Definitions

A key design decision was separating different monetary concepts.

### Product Sales

**Product Sales = SUM(order_items.price)**

This is the primary sales measure used for category and sales-trend
analysis.

### Freight

**Freight = SUM(order_items.freight_value)**

Freight is analyzed separately to understand logistics cost.

### Total Revenue

**Total Revenue = Product Sales + Freight**

This combined measure is used where the analysis requires product value
plus freight.

### Average Order Value

The dashboard\'s AOV is based on total revenue per distinct order.

This prevents payment values from being incorrectly substituted for
item-level sales.

------------------------------------------------------------------------

## 7. SQL Analysis

MySQL was used for detailed exploration, validation, aggregation, and
business-question analysis.

The SQL work includes:

-   Database and table creation
-   Data imports
-   Row-count and completeness validation
-   Sales/revenue analysis
-   Monthly and annual performance
-   Product and category analysis
-   Payment analysis
-   Customer repeat-purchase analysis
-   Cohort/retention analysis
-   RFM customer analysis
-   RFM segment revenue analysis
-   Seller analysis
-   Review and category analysis
-   Delivery analysis
-   Relationship between delivery and repeat behavior
-   Data-quality and consistency checks

The complete SQL workflow is available in `SQL/Olist_Analytics_SQL.sql`.

------------------------------------------------------------------------

## 8. Customer Analysis

Customer analysis was designed around **actual customer identity**, not
simply order records.

The project explored:

-   Unique customer counts
-   Repeat-purchase behavior
-   Customer ordering patterns
-   Cohort analysis
-   Retention
-   RFM-style customer segmentation
-   Revenue contribution by customer segment

The use of `customer_unique_id` is particularly important because a
customer can place multiple orders under different Olist order-level
customer records.

------------------------------------------------------------------------

## 9. Product, Category & Seller Analysis

Product analysis uses item-level transactional data to identify:

-   Top product categories by sales
-   Category-level sales concentration
-   Product performance
-   Seller performance
-   Category and seller relationships where relevant

The category translation table was used to make Portuguese product
categories easier to interpret in reporting.

------------------------------------------------------------------------

## 10. Payment Analysis

Payment data was analyzed separately from item-level sales because
payment rows can have a different grain.

The analysis considered:

-   Payment methods
-   Payment values
-   Installments
-   Order-level payment behavior

Payment values were not treated as a replacement for product sales,
preventing the two concepts from being mixed in the dashboard.

------------------------------------------------------------------------

## 11. Delivery & Customer Experience Analysis

Delivery performance was evaluated using order timestamps and delivery
status.

Key measures include:

-   Delivered orders
-   Delivery rate
-   Average delivery time
-   Monthly delivery-time trends
-   Delivery performance in relation to customer experience/repeat
    behavior

Customer experience was evaluated using review scores.

The analysis also recognized that low ratings should not automatically
be attributed to one factor; seller, category, and delivery performance
are useful dimensions for further investigation.

------------------------------------------------------------------------

## 12. DAX Measures & Calculations

The Excel Power Pivot model uses dynamic DAX measures for the dashboard.

| Measure | Purpose |
|---|---|
| `Total Sales` | Calculates total product sales |
| `Total Freight` | Calculates total freight value |
| `Total Revenue` | Calculates product sales plus freight |
| `Total Orders` | Counts distinct orders |
| `Total Customers` | Counts distinct customers using `customer_unique_id` |
| `Delivered Orders` | Counts delivered orders |
| `Delivery Rate` | Calculates the percentage of orders delivered |
| `Average Delivery Days` | Calculates average delivery time for valid orders |
| `Average Review Score` | Calculates average customer review score |
| `Average Order Value` | Calculates average revenue per order |
| `Number of Reviews` | Counts review records |

### Average Delivery Days

``` DAX
Average Delivery Days :=
AVERAGEX(
    FILTER(
        orders_full,
        NOT(ISBLANK(orders_full[order_delivered_customer_date])) &&
        NOT(ISBLANK(orders_full[order_purchase_timestamp]))
    ),
    DATEDIFF(
        orders_full[order_purchase_timestamp],
        orders_full[order_delivered_customer_date],
        DAY
    )
)
```

**Purpose:** Calculates average delivery time for valid orders.

The dashboard KPI cells use `CUBEVALUE` references to the Data Model
measures, so the displayed KPI values are dynamic rather than manually
hardcoded.

------------------------------------------------------------------------

## 13. Dashboard & KPI Explanation

The final dashboard provides a consolidated business-performance view.

### KPI Cards

 | KPI | Result | Meaning |
|---|---:|---|
| Total Sales | **₹13.59M** | Total product sales |
| Total Orders | **99,441** | Distinct orders |
| Total Customers | **96,096** | Distinct customers using `customer_unique_id` |
| Delivery Rate | **97.02%** | Share of orders reaching delivered status |
| Avg. Review Score | **4.09 / 5** | Overall customer satisfaction |
| Avg. Order Value | **₹159.33** | Average total revenue per order |

> **Currency note:** The Olist source dataset is Brazilian and its
> monetary values are denominated in Brazilian Real (BRL). The dashboard
> displays the `₹` symbol as a presentation convention in this portfolio
> version; the underlying analytical values are unchanged.

### Main Dashboard Visualizations

1.  **Monthly Sales Trend** --- identifies sales movement and
    seasonality over time.
2.  **Annual Sales Performance** --- compares yearly product sales.
3.  **Top 10 Product Categories by Sales** --- identifies major
    revenue-generating categories.
4.  **Order Status Distribution** --- shows the distribution of order
    outcomes.
5.  **Top 10 States by Customers** --- highlights geographic customer
    concentration.
6.  **Review Score Distribution** --- evaluates customer satisfaction.
7.  **Average Delivery Time by Month** --- tracks delivery-time
    performance.
8.  **Monthly Sales vs Freight** --- compares sales growth with freight
    costs.

The dashboard was deliberately kept focused on high-value business views
rather than filling the page with every available metric.

------------------------------------------------------------------------

## 14. Key Analytical Results

-   **Product sales:** approximately **₹13.59M**
-   **Orders:** **99,441**
-   **Unique customers:** **96,096**
-   **Delivered orders:** **96,478**
-   **Delivery rate:** **97.02%**
-   **Average review score:** **4.09 / 5**
-   **Average delivery time:** approximately **12.50 days**
-   **Average order value:** approximately **₹159.33**
-   **Freight:** approximately **₹2.25M**
-   **Freight as a share of product sales:** approximately **16.6%**
-   **2017 → 2018 product-sales growth:** approximately **20%**

The strongest monthly product-sales result was approximately **₹1.01M in
November 2017**.

------------------------------------------------------------------------

## 15. Business Insights

### Strong Sales Growth

Product sales reached approximately **₹13.59M**, with approximately
**20% growth from 2017 to 2018**.

The growth indicates strong marketplace activity and provides a basis
for protecting high-performing categories and periods.

### Geographic Concentration

São Paulo represents approximately **43% of unique customers**, while
the top three states represent approximately **69%**.

This creates strong market depth in major regions but also indicates
geographic concentration risk.

### Strong Customer Satisfaction

The average review score is **4.09/5**, and approximately **77% of
reviews are rated 4 or 5 stars**.

The overall customer experience is positive, while the lower-rated
segment remains valuable for root-cause analysis.

### Strong Delivery Completion

The delivery rate is **97.02%**.

This indicates strong overall fulfillment completion, although delivery
time and regional/seller-level delays remain useful areas for
optimization.

### Freight Cost Exposure

Freight totals approximately **₹2.25M**, or roughly **16.6% of product
sales**.

As sales increase, freight becomes an important operational cost to
monitor.

### Category Concentration

The strongest categories include **Health & Beauty, Watches & Gifts, Bed
& Bath Table, Sports & Leisure, and Computers & Accessories**.

Category-level performance can therefore inform inventory,
merchandising, and promotional decisions.

------------------------------------------------------------------------

## 16. Business Recommendations

### 1. Protect High-Growth Areas

Focus inventory and marketing efforts on high-performing categories,
products, and sales periods.

### 2. Optimize Logistics

Monitor freight costs together with sales and delivery performance.
High-sales periods deserve particular attention because logistics costs
can rise with activity.

### 3. Investigate Low-Rated Experiences

Analyze low-rated orders by **seller, category, and delivery
performance** rather than assuming a single cause of dissatisfaction.

### 4. Expand Beyond Concentrated Markets

Maintain strong logistics coverage in major customer markets while
developing acquisition strategies for underrepresented states.

### 5. Strengthen Category Strategy

Prioritize high-performing categories while improving visibility,
merchandising, and promotions for lower-performing categories.

------------------------------------------------------------------------

## 17. Conclusion

The analysis indicates that Olist demonstrates strong overall business
performance, supported by sales growth, high delivery completion, and
generally positive customer satisfaction.

At the same time, the business has identifiable opportunities:

-   geographic customer concentration,
-   meaningful freight-cost exposure,
-   delivery-time optimization,
-   and investigation of lower-rated customer experiences.

The strongest part of the project is not any single KPI. It is the
analytical workflow used to ensure that the KPIs are **calculated at the
correct grain, based on appropriate business definitions, validated
through QC, and interpreted in a business context**.

------------------------------------------------------------------------

## 18. Portfolio Takeaways

This project demonstrates practical Data Analyst capabilities in:

-   SQL data analysis
-   Complex joins and aggregation
-   Data cleaning and validation
-   Data-grain reasoning
-   Relational data modeling
-   KPI definition
-   DAX
-   Power Query
-   Power Pivot
-   PivotTables and PivotCharts
-   Excel dashboard development
-   Time-series analysis
-   Customer and retention analysis
-   Cohort analysis
-   RFM analysis
-   Product/category analysis
-   Seller analysis
-   Payment analysis
-   Delivery and operational analysis
-   Review/customer-experience analysis
-   Data-quality investigation
-   Business storytelling
-   Actionable recommendations

The project demonstrates an important analyst mindset: **do not simply
calculate a number---first understand what the number represents, how
the underlying tables relate, whether the aggregation is valid, and what
business decision the result can support.**
