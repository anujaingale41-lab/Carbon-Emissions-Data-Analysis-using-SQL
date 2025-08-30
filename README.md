# Carbon-Emissions-Data-Analysis-using-SQL
This project leverages SQL to design and analyze a database focused on carbon emissions data. By structuring information on emission sources, industry sectors, and time periods into relational tables, the project enables efficient storage, retrieval, and analysis of sustainability-related metrics.
Project Overview
This project focuses on analyzing *carbon emissions data* using SQL.  
By organizing data into relational tables and applying advanced queries, the project reveals trends, highlights inefficiencies, and provides actionable insights for companies aiming to *reduce their carbon footprint*.  

The project demonstrates how SQL can move beyond basic reporting and become a tool for *sustainability analytics, supporting **ESG compliance* and *data-driven decision-making*.

## 🎯 Objectives
- Design a *relational database* to store emissions data by source, sector, and time period.  
- Write SQL queries to uncover *trends, anomalies, and patterns* in emissions.  
- Calculate *KPIs* such as:
  - Total emissions
  - Sectoral contribution (%)
  - Year-over-year changes
  - Regional breakdowns  
- Generate insights that help companies:
  - Understand emission drivers  
  - Track progress toward reduction goals  
  - Identify opportunities for sustainability improvements  

## 🛠️ Tools & Technologies
- *SQL* (PostgreSQL / MySQL / SQLite – adaptable)  
- *Data Visualization* (Power BI / Tableau) for dashboards  
- *Excel /* (optional, for preprocessing raw data)  

## 🗂️ Database Schema (Sample)

📦 Carbon_Emissions_DB ┣ 📄 total_Emissions_Mtco2e ┃ ┣ year ┃ ┣ parent_entity ┣  ┣ parent_name ┃ 

## 🔍 Example SQL Queries
```sql
-- 1. Find total emissions by year
SELECT year, SUM(emission_value) AS total_emissions
FROM Emissions
GROUP BY year
ORDER BY year;

-- 2. Identify top 3 sectors contributing to emissions
SELECT s.sector_name, SUM(e.emission_value) AS sector_emissions
FROM Emissions e
JOIN Sectors s ON e.sector_id = s.sector_id
GROUP BY s.sector_name
ORDER BY sector_emissions DESC
LIMIT 3;

-- 3. Calculate year-over-year emission change
SELECT year,
       SUM(emission_value) AS total_emissions,
       LAG(SUM(emission_value)) OVER (ORDER BY year) AS prev_year_emissions,
       (SUM(emission_value) - LAG(SUM(emission_value)) OVER (ORDER BY year)) AS yoy_change
FROM Emissions
GROUP BY year
ORDER BY year;


📊 Insights & Business Value

Identified largest contributing sectors and regions.

Measured seasonal and year-over-year changes in emissions.

Helped companies track progress toward sustainability targets.

Provided a scalable framework for ESG reporting and policy decision-making.

🚀 Future Improvements

Automate dashboards for real-time monitoring.

Apply predictive analytics using Python + SQL for forecasting future emissions.


📎 Author

👩‍💻 Anuja Ingale

LinkedIn: https://www.linkedin.com/in/anuja-ingale-3aa17b1b3/

GitHub: anujaingale41-lab
