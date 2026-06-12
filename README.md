# Renewable Energy Consumption Dashboard

## Project Overview

This project analyzes renewable energy consumption patterns across households using AWS, Snowflake, SQL, and Tableau. The objective was to perform data transformation in Snowflake and create an interactive dashboard to visualize renewable energy adoption, energy usage, and cost savings.

## Tools Used

- AWS S3
- Snowflake
- SQL
- Tableau Desktop
- Tableau Public

## Data Transformations

The following transformations were performed in Snowflake:

- Increased cost savings by 15% for households receiving subsidies.
- Created an Adoption Status column (Early Adopter / Recent Adopter).
- Increased monthly energy usage by 8% for Biomass energy households.
- Created a Usage Category column (Low Usage, Medium Usage, High Usage).
- Created a Green Rating column (Gold, Silver, Bronze) based on subsidy status and cost savings.

## Dashboard Features

### KPI Cards

- Total Households
- Average Monthly Usage
- Average Cost Savings
- Total Countries

### Visualizations

- Country-wise Renewable Adoption
- Cost Savings by Income Level
- Green Rating Distribution
- Adoption Status Analysis
- Average Monthly Usage by Energy Source
- Most Popular Energy Source

### Interactive Filters

- Country
- Energy Source
- Income Level

## Project Workflow

```text
CSV Dataset → AWS S3 → Snowflake → SQL Transformations → Tableau Dashboard
```

## Tableau Public Dashboard

View the dashboard here:

🔗 https://public.tableau.com/views/Renewable_Energy_Dashboard/Tableau-RenewableEnergyConsumptionDashboard?:language=en-US&:display_count=n&:origin=viz_share_link

## Key Skills Demonstrated

- Data Loading using AWS S3 and Snowflake
- SQL Data Transformation and Data Enrichment
- Snowflake Data Warehousing
- Interactive Dashboard Development in Tableau
- KPI Design and Business Reporting
- Data Visualization and Analysis
