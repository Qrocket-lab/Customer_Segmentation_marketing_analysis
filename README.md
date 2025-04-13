# Customer Segmentation and Marketing Channel Analysis

This repository contains SQL scripts and analyses for customer segmentation and marketing channel performance evaluation.

## Project Overview

This project aims to provide insights into customer behavior and marketing channel effectiveness by analyzing two datasets:

1.  **Attribution Data:** This dataset captures customer interactions with different marketing channels, including conversions and their associated values.
2.  **Superstore Orders Data:** This dataset contains sales and customer information for a superstore, enabling customer segmentation using RFM analysis.

## Datasets

* **attribution.csv:** Contains marketing attribution data.
* **superstore_orders.csv:** Contains superstore order data.

## SQL Scripts

The following SQL scripts are included in this repository:

### Attribution Analysis

* **attribution_analysis.sql:** This script analyzes the attribution data to:
    * Calculate total interactions and conversions per channel.
    * Determine conversion rates for each channel.
    * Calculate total and average conversion values.
    * Analyze customer session and conversion behavior.
    * Create summary tables for marketing channel performance and customer behavior.

### RFM Analysis

* **rfm_analysis.sql:** This script performs RFM (Recency, Frequency, Monetary) analysis on the superstore orders data to segment customers. It includes steps to:
    * Calculate RFM values for each customer.
    * Assign RFM scores.
    * Create a final table with RFM scores and customer data.
    * Integrate RFM scores with superstore order detail.

## Usage

1.  **Setup:**
    * Ensure you have a PostgreSQL database installed.
    * Import the `attribution.csv` and `superstore_orders.csv` data into your database.
2.  **Run SQL Scripts:**
    * Execute the SQL scripts (`attribution_analysis.sql` and `rfm_analysis.sql`) in your PostgreSQL client.
3.  **Analyze Results:**
    * Query the resulting tables to analyze marketing channel performance and customer segments.

## Project Structure
```Customer Segmentation and Marketing Channel Analysis/
├── attribution_analysis.sql
├── rfm_analysis.sql
├── attribution.csv
├── superstore_orders.csv
└── README.md
```

Detailed findings from the analysis can be found in this Google Doc: [Customer Segmentation and Marketing Channel Analysis Findings](https://docs.google.com/document/d/16ImrG24aMpcgVLGeHwS2XfUDX0UDvpIDA63MFA6Cdys/edit?usp=sharing)

## Further Analysis

* Visualize the results using data visualization tools (e.g., Tableau, Power BI).
* Develop marketing strategies based on the customer segments and channel performance.
* Implement predictive models to forecast customer behavior and conversion rates.
* Create dashboards for real-time monitoring of marketing campaigns and customer engagement.

## Contributing

Contributions to this project are welcome. Please submit a pull request with your proposed changes.
