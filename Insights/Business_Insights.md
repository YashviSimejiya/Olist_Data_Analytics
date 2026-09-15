# Olist E-Commerce Analytics --- Business Insights

## Executive Summary

The Olist analysis presents a business with **strong sales growth, high
delivery completion, and generally positive customer satisfaction**.

The analysis also identifies three important opportunity areas:

1.  **Customer concentration** in a small number of states
2.  **Freight-cost exposure** as sales grow
3.  **Lower-rated customer experiences** that warrant root-cause
    analysis

The recommendations below are based on the combined sales, customer,
category, delivery, review, and logistics analysis.

------------------------------------------------------------------------

## 1. Strong Sales Growth

### Finding

Product sales reached approximately **₹13.59M**, with approximately
**20% growth from 2017 to 2018**.

The strongest monthly product-sales result was approximately **₹1.01M in
November 2017**.

### What it means

The business shows strong growth momentum. High-performing periods
should therefore be considered when planning inventory, promotions, and
marketing capacity.

### Recommendation

**Focus inventory and marketing efforts on high-performing products,
categories, and periods.**

------------------------------------------------------------------------

## 2. Geographic Customer Concentration

### Finding

**São Paulo accounts for approximately 43% of unique customers**, while
the top three states represent approximately **69%** of the customer
base.

### What it means

Olist has strong penetration in its largest markets, but the customer
base is geographically concentrated.

This creates an opportunity to expand demand in underrepresented regions
while maintaining service quality in existing core markets.

### Recommendation

**Maintain strong logistics coverage in major markets while expanding
customer acquisition in underrepresented regions.**

------------------------------------------------------------------------

## 3. Strong Customer Satisfaction

### Finding

The average review score is **4.09/5**, with approximately **77% of
reviews receiving 4 or 5 stars**.

### What it means

The majority of customer experiences are positive.

However, the lower-rated orders are analytically valuable because
dissatisfaction may be associated with different operational factors,
including seller, category, or delivery performance.

### Recommendation

**Analyze low-rated orders by seller, category, and delivery performance
to identify recurring causes of dissatisfaction.**

------------------------------------------------------------------------

## 4. Strong Delivery Performance

### Finding

**97.02% of orders reached delivered status.**

The average delivery time for valid delivered orders is approximately
**12.50 days**.

### What it means

The delivery completion rate is strong, but completion rate alone does
not tell the full operational story. Delivery time and delays can still
affect customer satisfaction.

### Recommendation

**Maintain delivery efficiency while reducing delays in lower-performing
areas and monitoring delivery time alongside customer reviews.**

------------------------------------------------------------------------

## 5. Freight Cost Exposure

### Finding

Freight costs total approximately **₹2.25M**, representing roughly
**16.6% of product sales**.

Freight costs also increase alongside sales.

### What it means

As marketplace activity grows, logistics becomes an increasingly
important cost area.

The objective should therefore not simply be to increase sales, but to
understand whether additional sales are being generated efficiently from
a logistics perspective.

### Recommendation

**Monitor freight costs by month, region, seller, and order
characteristics, and optimize shipping routes and carrier allocation
during high-sales periods.**

------------------------------------------------------------------------

## 6. High-Performing Product Categories

### Finding

The strongest categories by product sales include:

| Rank | Category | Approx. Product Sales |
|---:|---|---:|
| 1 | Health & Beauty | ₹1.26M |
| 2 | Watches & Gifts | ₹1.21M |
| 3 | Bed & Bath Table | ₹1.04M |
| 4 | Sports & Leisure | ₹0.99M |
| 5 | Computers & Accessories | ₹0.91M |

### What it means

Sales are not evenly distributed across categories. A relatively small
group of categories contributes substantial sales and therefore deserves
focused inventory and merchandising attention.

### Recommendation

**Prioritize high-performing categories while improving visibility and
promotions for lower-performing categories.**

------------------------------------------------------------------------

## 7. Customer & Retention Analysis

The SQL analysis went beyond simple customer counts and included:

-   Repeat-purchase analysis
-   Cohort analysis
-   Retention analysis
-   RFM-style customer segmentation
-   Revenue contribution by RFM segment

### Why this matters

A customer count alone cannot explain customer quality or long-term
value.

Using `customer_unique_id` allows the analysis to distinguish customers
who return from customers who place only one order, while cohort and RFM
analysis provide additional ways to understand customer behavior and
value.

### Business use

These analyses can support:

-   retention strategies,
-   customer segmentation,
-   targeted marketing,
-   identification of valuable customer groups,
-   and prioritization of customer-acquisition versus retention efforts.

------------------------------------------------------------------------

## 8. Seller & Product Analysis

The analysis also examined seller performance and product-level/category
performance.

This creates a path from a broad business KPI such as average review
score to more actionable questions:

-   Which sellers contribute strongly to sales?
-   Where are lower-rated experiences concentrated?
-   Which categories generate the most product sales?
-   Are operational issues concentrated among particular sellers or
    categories?

### Business use

Seller and category analysis can support:

-   seller performance management,
-   category strategy,
-   inventory planning,
-   promotional prioritization,
-   and customer-experience improvement.

------------------------------------------------------------------------

## 9. Payment Analysis

Payment data was analyzed separately because payment rows can have a
different grain from order-item rows.

The analysis considered:

-   payment methods,
-   payment values,
-   installment behavior,
-   and order-level payment patterns.

### Important analytical point

**Payment value was not treated as a replacement for product sales.**

Keeping these concepts separate avoids mixing payment behavior with
item-level revenue and prevents misleading results when multiple payment
records exist for an order.

------------------------------------------------------------------------

## 10. Data Quality Was Part of the Analysis

One of the strongest analytical lessons from the project was that
correct-looking SQL can still produce incorrect business conclusions if
table grain is misunderstood.

### Key QC Lessons

**Order items:** `order_item_id` is not globally unique. The correct
item-level key is `(order_id, order_item_id)`.

**Customers:** `customer_unique_id` is required for actual
customer-level analysis.

**Payments:** Directly joining order items to raw payment rows can
multiply sales values.

**Reviews:** Joining reviews to item/category rows can repeat review
scores across multiple items in the same order.

**Payment coverage:** The payment dataset contains one fewer order than
the complete orders dataset, so coverage was explicitly checked.

**Cohorts:** Calendar-month differences were used for cohort periods
instead of raw month-duration calculations.

These checks were necessary to make the final KPIs and business insights
trustworthy.

------------------------------------------------------------------------

## 11. Overall Business Assessment

| Business Area | Assessment | Evidence |
|---|---|---|
| Sales Growth | **Strong** | ~20% growth from 2017 to 2018 |
| Customer Base | **Concentrated** | Top 3 states ≈ 69% |
| Customer Satisfaction | **Strong** | 4.09 / 5 average |
| Positive Reviews | **Strong** | ≈ 77% rated 4–5 stars |
| Delivery Completion | **Strong** | 97.02% delivered |
| Delivery Time | **Optimization Opportunity** | ≈ 12.50 days average |
| Freight Cost | **Significant Cost Area** | ≈ 16.6% of product sales |
| Category Performance | **Concentrated** | Health & Beauty leads |

------------------------------------------------------------------------

## 12. Priority Recommendations

### Priority 1 --- Protect Growth

Continue investing in high-performing products, categories, and sales
periods while ensuring sufficient inventory and operational capacity.

### Priority 2 --- Optimize Logistics

Track sales, freight, and delivery performance together to identify
where additional sales are generating disproportionately high logistics
costs or delivery pressure.

### Priority 3 --- Improve Customer Experience

Use low review scores as a starting point for root-cause analysis across
seller, category, and delivery dimensions.

### Priority 4 --- Expand Geographically

Use the strong customer base in major states as a foundation while
targeting acquisition in underrepresented regions.

### Priority 5 --- Strengthen Category Strategy

Use category-level sales performance to guide inventory, promotions,
merchandising, and marketing decisions.

------------------------------------------------------------------------

## Final Takeaway

**Olist shows strong overall business health, but growth should be
managed alongside logistics efficiency, customer experience, and
geographic diversification.**

The key analytical lesson is that a strong KPI is only useful when its
**grain, definition, relationships, and business meaning** are correct.

The project therefore moves beyond "sales = ₹13.59M" to the more useful
questions:

> **What is driving the result? Where is the business concentrated? What
> operational costs accompany growth? What could explain
> dissatisfaction? And what action should management take next?**
