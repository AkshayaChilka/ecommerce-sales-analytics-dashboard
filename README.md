🛒 E-Commerce Retail Sales & Predictive Analytics — End-to-End Project

Tools: Python (Pandas) · MySQL · Microsoft Power BI
Domain: E-Commerce · Retail Analytics · Sales Forecasting · Business Intelligence
Dashboard: 3 pages — Retail Sales · Geographic Intelligence · Sales Forecasting
Author: Akshaya Chilka · AI & DS, St. Martin's Engineering College '27


📌 Project Overview
A complete, production-style analytics pipeline on a retail e-commerce dataset — from raw data ingestion and cleaning in Python, through 13 business-focused SQL queries, to a 3-page interactive Power BI dashboard covering sales intelligence, geographic analysis, and a 3-month revenue forecast with actionable business recommendations.
Dataset Scale:
MetricValueTotal Orders116,000Total Revenue₹80.52M (₹8,05,19,173.24)Average Order Value₹693.53Cities Covered3,831Date RangeMarch 2022 – June 2022Cancellation Rate10.04%Shipping Success Rate84.81%

🗂️ Repository Structure
ecommerce-sales-analysis/
│
├── Data_Cleaning.ipynb              # Python data cleaning pipeline
├── e-commerce.sql                   # 13 SQL business analysis queries
├── E-Commerce_Sales_DashBoard.pbix  # Power BI 3-page dashboard
├── E-commerce Sales Data.csv        # Cleaned source dataset
└── README.md

🔧 Phase 1 — Data Cleaning (Python · Pandas)
File: Data_Cleaning.ipynb
Issue FoundTreatment AppliedMissing Courier Status valuesFilled 'Cancelled' — business logic: no status = no fulfilmentMissing fulfilled-by valuesFilled 'Self Ship' — default fulfilment fallbackCities with only 1 orderRemoved — insufficient data for city-level analysis across 3,831 citiesMissing Amount valuesImputed with column median — robust to revenue outliersDuplicate recordsDetected and flagged via duplicated()
pythondf['Courier Status'] = df['Courier Status'].fillna('Cancelled')
df['fulfilled-by']   = df['fulfilled-by'].fillna('Self Ship')
city_counts = df['ship-city'].value_counts()
df = df[df['ship-city'].isin(city_counts[city_counts > 1].index)]
df['Amount'] = df['Amount'].fillna(df['Amount'].median())
df.to_csv("E-commerce Sales Data.csv", index=False)

📊 Phase 2 — SQL Business Analysis (MySQL · 13 Queries)
File: e-commerce.sql
Revenue & Category Performance
#QueryBusiness Finding1Total Revenue + Orders + AOV₹80.52M · 116K orders · ₹693.53 AOV2Revenue by Category × MonthSet ₹40M · Kurta ₹22M · Western Dress ₹11M · Top ₹5M4Category Ranking (Window)RANK() OVER (ORDER BY SUM(Amount) DESC) — Set = Rank 19Category Contribution %Set ~50% of total revenue
Customer & Geography
#QueryBusiness Finding3Top 5 Cities Contribution %Bengaluru 29.26% · Hyderabad 22.79% · Mumbai 14.64%6High-Value Orders (Outlier Detection)WHERE Amount > AVG + 2×STDDEV7Repeat vs One-time CustomersHAVING COUNT(*) > 1 on Order_ID8City-wise AOVBengaluru: 11,095 orders · ₹7.60M revenue
Operations & Fulfilment
#QueryBusiness Finding5Delivery Success Rate84.81% shipped · 10.04% cancelled · 9.95% unshipped107-Day Moving AverageAVG() OVER (ROWS BETWEEN 6 PRECEDING AND CURRENT ROW)11Fulfilment MethodEasy Ship 69.59% (86.77K) · Self Ship 30.41% (37.92K)12Cancellation Rate10.04% — flagged as Risk Alert in dashboard13Size DemandDistribution across 116K orders
Advanced SQL used:

Window functions: RANK() OVER, AVG() OVER ... ROWS BETWEEN 6 PRECEDING AND CURRENT ROW
Statistical outlier detection: AVG(Amount) + 2 * STDDEV(Amount)
Subqueries for % contribution: SUM(Amount) * 100 / (SELECT SUM(Amount) FROM ecommerce)
Conditional aggregation: SUM(CASE WHEN courier_status = 'Cancelled' THEN 1 ELSE 0 END)
DATE_FORMAT(Date, '%Y-%m') for monthly time-series grouping


📈 Phase 3 — Power BI Dashboard (3 Pages)
File: E-Commerce_Sales_DashBoard.pbix

Page 1 — Retail Sales & Customer Intelligence Dashboard
KPI Cards:
MetricValueTotal Orders116KTotal Revenue₹80.52MAvg Order Value₹693.53Cancellation Rate10.04%
Visuals:

Revenue by Category (bar): Set ₹40M · Kurta ₹22M · Western Dress ₹11M · Top ₹5M · Ethnic Dress ₹1M
Total Revenue by Month (line): Apr–Jun 2022 · daily peak ~₹1M
Fulfilment Distribution (donut): Easy Ship 86.77K (69.59%) · Self Ship 37.92K (30.41%)
Order Status Distribution (donut): Shipped 105.75K (84.81%) · Cancelled 12.4K (9.95%) · Unshipped 9.95%
Top Revenue Cities (bar): Bengaluru ₹7.6M · Hyderabad ₹5.9M · Mumbai ₹4.5M · Delhi ₹4.2M · Chennai ₹3.8M

Smart Narrative Auto-Insights:

🏆 Top Revenue City: Bengaluru (₹7.6M)
📦 Best Category: Set contributes ₹40M
⚠️ Risk Alert: Cancellation Rate 10.04%
✅ Shipping Success: 84.81%


Page 2 — Geographic & Order Intelligence Dashboard
KPI Cards:
MetricValueTotal Cities3,831Avg Orders per City30.31Avg Revenue per City₹21.02KTop City Revenue₹7.60M
Visuals:

Order Volume by City (bar): Bengaluru 11.9K · Hyderabad 9.1K · Mumbai 7.1K · Delhi 6.3K · Chennai 6.3K · Pune 4.6K
Revenue Distribution by City (bar): Bengaluru ₹7.6M · Hyderabad ₹5.9M · Mumbai ₹4.5M · Delhi ₹4.2M · Chennai ₹3.8M
Revenue Share Donut: Bengaluru 29.26% · Hyderabad 22.79% · Mumbai 14.64% · Delhi 15.9%
City Detail Table (top 10): 49,893 orders · ₹3,43,29,509 total revenue

CityOrdersRevenue (₹)Bengaluru11,09576,04,335.80Hyderabad8,36959,22,892.35Mumbai6,57244,82,575.16New Delhi5,94841,73,515.20Chennai5,72638,03,542.94Pune4,31729,38,360.79Kolkata2,68617,81,652.99Gurugram1,85413,32,884.78Thane1,77011,73,821.35Lucknow1,55611,15,928.10
Smart Narrative Cards:

🥇 Bengaluru leads revenue
📊 Hyderabad highest order density
🌍 20 active cities served


Page 3 — Sales Forecasting & Predictive Analytics Dashboard
KPI Cards (same base): ₹80.52M · 116K Orders · ₹693.53 AOV · 10.04% Cancellation Rate
Visuals:

Historical Revenue Trend (line): Mar–Jun 2022, ~₹0.5M–₹1M daily range with visible seasonality
Revenue Forecast — Next 3 Months (line + shaded CI): Power BI forecast extension to Jul 2022, with confidence interval shading showing expected range
Category Revenue Outlook (bar): Set ₹40M · Kurta ₹22M · Western Dress ₹11M · Top ₹5M · Ethnic Dress ₹1M
Revenue Trend Summary Table: Daily granularity — 31 Mar 2022 to 14 Apr 2022 shown; total ₹8,05,19,173.24

Daily Revenue Sample (from table):
DateDaily Revenue (₹)31 March 20221,05,676.8501 April 20229,03,777.0703 April 202210,36,644.3310 April 202210,89,882.4114 April 202211,39,258.89
AI-Generated Business Narrative (smart cards):

📈 Growth Outlook: Stable revenue trend expected
🏆 Revenue Driver: Set category remains top contributor
⚠️ Risk Indicator: 10.04% cancellations impact growth
🎯 Recommendation: Focus promotions in top cities

Recommendations Panel:

Increase inventory for high-demand cities
Reduce cancellations through logistics optimisation
Promote top-performing categories


💡 Key Business Insights Across All 3 Pages
InsightDataActionSet dominates revenue₹40M · ~50% of totalPrioritise inventory and promotionsBengaluru is #1 market₹7.6M · 11,095 orders · 29.26% shareIncrease marketing budget allocation10.04% cancellation rate12.4K orders lostInvestigate courier SLA and logistics gapsEasy Ship outperforms69.59% volume vs 30.41% Self ShipReduce Self Ship dependencyHyderabad: high volume, lower AOV9.1K orders · ₹5.9MUpsell opportunity in high-frequency, lower-spend marketStable 3-month forecastPower BI forecast CIPlan inventory for Jul–Sep 2022 based on trendTop 10 cities = majority of revenue49,893 orders · ₹3.43CrGeo-targeted campaigns for tier-2 cities

🚀 How to Run
bash# Python
pip install pandas jupyter
jupyter notebook Data_Cleaning.ipynb
sql-- MySQL Workbench or any MySQL client
SOURCE e-commerce.sql;
# Power BI Desktop
Open E-Commerce_Sales_DashBoard.pbix
Refresh data source → point to E-commerce Sales Data.csv

🛠️ Tech Stack
ToolUsagePython 3 + PandasNull handling · median imputation · deduplication · EDAMySQL13 queries · window functions · statistical outlier detection · time-seriesMicrosoft Power BI3-page dashboard · DAX measures · Power BI forecast · smart narratives · cross-page slicers

👩‍💻 About
Akshaya Chilka — AI & Data Science, St. Martin's Engineering College, Hyderabad
