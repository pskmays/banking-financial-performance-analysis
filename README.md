# Banking Financial Performance Analysis
![MySQL Workbench](https://img.shields.io/badge/MySQL-4479A1?style=for-the-badge&logo=mysql&logoColor=white)
![Microsoft Excel](https://img.shields.io/badge/Microsoft_Excel-217346?style=for-the-badge&logo=microsoft-excel&logoColor=white)
![Microsoft Office](https://img.shields.io/badge/Microsoft_Office-D83B01?style=for-the-badge&logo=microsoft-office&logoColor=white)
![Microsoft Word](https://img.shields.io/badge/Microsoft_Word-2B579A?style=for-the-badge&logo=microsoft-word&logoColor=white)
![GitHub](https://img.shields.io/badge/github-%23121011.svg?style=for-the-badge&logo=github&logoColor=white)


## Overview
This project simulates a real-world financial analytics engagement for a regional banking corporation. The executive leadership team required visibility into branch performance, departmental spending, cost center variance, and overall budget utilization.

I designed and queried a MySQL relational database to explore financial and operational data across 12 interrelated tables. After validating relationships and extracting key metrics using SQL, I connected Excel directly to the database using Power Query to clean, transform, and model the data.

The final deliverable was an executive-ready Excel dashboard highlighting budget vs. actual performance, departmental breakdowns, regional trends, and over-budget cost centers.

## [Reports](https://github.com/tushar2704/Sales-for-Retail-and-Food-Services/tree/main/reports)
## Project Structure

    ├── LICENSE
    ├── README.md          <- README .
    ├── query              <- Code of the DB creation and queries.
    │   │
    │   └── retail_sales_tables_db.sql       <- DB creation.
    │   └── analysis.sql                     <- Final queries.
    │   └── query_data                       <- Final queries data.
    ├── reports            <- Folder containing the final reports/results of this project.
    │   │
    │   └── query_report.docx        <- Final analysis report Document.
    │   └── query_report.pdf         <- Final query report in PDF for verifying data.
    │   
    ├── src                <- Source for this project.
        │
        ├── data           <- Datasets used and collected for this project.
        
--------




## Dataset
The dataset simulates financial and operational data from a regional banking corporation. It includes 12 relational tables covering departments, branches, budgets, expenditures, cost centers, regions, employees, customers, transactions, and loan applications.

The structured format allows for budget vs. actual analysis, cost center performance evaluation, regional financial comparisons, and overall operational insight.

## Database
To facilitate data management and analysis, a SQL database has been created to store the dataset. SQL provides a robust and efficient way to query and manipulate the data. The database schema has been designed to ensure proper organization and ease of use. The structure of the database enables seamless integration with various data visualization tools.

## Data Processing
The data obtained from the U.S. government website might require some preprocessing to clean and transform it into a suitable format for analysis. SQL queries have been utilized to clean, filter, and transform the data as necessary. This ensures that the data used for the dashboard is accurate and reliable.
![Quick Summary table](https://github.com/tushar2704/Sales-for-Retail-and-Food-Services/assets/66141195/c897f5c5-e4ce-446f-8944-c0c0376fcee9)



## Project includes:

**Overview:** A leadership-focused dashboard summarizing total budget, total actual expenditures, budget variance (amount and %), and overall budget utilization.

**Budget vs. Expenditure Analysis:** Departmental and cost center breakdowns highlighting over-budget areas and spending efficiency.

**Regional Financial Analysis:** Comparisons of financial performance across regions and branches.

**Cost Center Performance:** Identification of the top over-budget cost centers and high-spend vendors.

**Trend Analysis:** Monthly expenditure trends to identify spending patterns over time.
**Data Modeling & Relationships:**Structured relational database design and Excel Data Model relationships to ensure accurate financial reporting.

**Filtering and Interactivity:** PivotTables and slicers enabling dynamic financial analysis and drill-down capabilities.

## Technologies Used
**SQL:** For data extraction, transformation, and loading into the database.

**Database Management System:** MySQL Workbench to host and manage the dataset.

**Programming Languages:**  SQL for data processing and scripting.

**Excel:** Power Query for data cleaning and transformation, Data Model for relationship management, and dashboard development for executive reporting.



**Executive Summary**
A substantial portion of revenue comes from the Northeast region of the U.S., which not only generates the highest revenue but also has the largest customer base among all five regions. Given its significance, marketing strategies should prioritize the Northeast to maximize impact. HQ Procurement Vendor Management ranks first among over-budget cost centers and second in total expenses, indicating both high spending levels and budget variance. I am suggesting the need for closer budget monitoring and expense control.

## Author
- <ins><b>©2023 Tushar Aggarwal. All rights reserved</b></ins>
- <b>[LinkedIn](https://www.linkedin.com/in/kenye-mays/?skipRedirect=true)</b>
- <b>[Medium](https://medium.com/@tushar_aggarwal)</b> 
- <b>[My Website](https://pskmays.github.io/portfolio/)</b>
- <b>[New Kaggle](https://www.kaggle.com/tagg27)</b> 

## Contact me!

If you have any questions, suggestions, or want to say hello, you can reach out to me at [Kenye Mays](mailto:kenyemays00@gmail.com). I would love to hear from you!
