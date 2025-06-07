# Insurance-SQL-RSTUDIO
Customer Policy Subscription Analysis
This project focuses on analyzing customer subscription behavior across three policy types: Health, Motor, and Travel. Using a combination of SQL for data preparation and R for data cleaning, transformation, and visualization, the project explores key demographic and behavioral insights that can inform business decisions in the insurance sector.

📊 Data Preparation & Integration
Data from separate policy tables were merged using SQL joins to consolidate customer information into a single dataset. Each customer's engagement level was quantified by calculating the total number of policies they subscribed to. Additional transformations included handling missing values, removing outliers (e.g., unrealistic ages), and deriving categorical variables such as age groups and policy engagement levels.

📈 Exploratory Data Analysis (EDA)
Using R, the cleaned data was analyzed to identify trends and patterns based on:

Gender

Age group

Occupation

Channel of policy purchase

Visualizations include bar charts, stacked bar plots, mosaic plots, and pie charts to compare the distribution of policy subscriptions across various demographic dimensions. This helped uncover insights such as gender-wise policy preferences and age groups with the highest engagement.

📌 Key Features
SQL-driven ETL process for merging and preparing data

Dynamic data wrangling in R using dplyr and ggplot2

Outlier detection and replacement strategy

Policy engagement categorization and visualization

Use of mosaic plots for multivariate categorical comparison

🔍 Outcomes
The project successfully identifies key demographic segments with higher policy engagement, which can support targeted marketing, cross-selling strategies, and customer retention planning.

