import pandas as pd
import matplotlib.pyplot as plt
import numpy as np
import os
os.makedirs("../output/visuals", exist_ok = True)
#read file
df = pd.read_csv(r"C:\Users\tanup\Downloads\sales_data.csv")
print(df.head())
#info
print(df.info())
#null values
print(df.isnull().sum())
#remove duplicates
df.drop_duplicates(inplace = True)
#handle null value
df.dropna(inplace = True)
#convert date column 
df['Sale_Date'] = pd.to_datetime(df['Sale_Date'])
#Create new columns
df['Year'] = df['Sale_Date'].dt.year
df['Month'] = df['Sale_Date'].dt.month_name()
#KPI Metrics
total_sales = df['Sales_Amount'].sum()
avg_sales = df['Sales_Amount'].mean()
total_orders = df.shape[0]
print("Total Sales:", total_sales)
print("Average Sales:", avg_sales)
print("Total Orders:", total_orders)
#ANALYTICS
#TOP PRODUCTS
top_products = df.groupby('Product_ID')['Sales_Amount'].sum().sort_values(ascending = False).head(10)
print("\nTop Products:\n", top_products)
#Region wise sales
region_sales = df.groupby('Region')['Sales_Amount'].sum().sort_values(ascending = False)
print("\nRegion Sales:\n",region_sales)
#Category wise sales
category_sales = df.groupby('Product_Category')['Sales_Amount'].sum()
print("\nCategory Sales:\n",category_sales)
#Monthly trend
monthly_sales = df.groupby('Month')['Sales_Amount'].sum()
print("\nMonthly Sales:\n", monthly_sales)
#Sales Channel
channel_sales = df.groupby('Sales_Channel')['Sales_Amount'].sum()
print("\nSales Channel:\n",channel_sales)
#VISUALIZATIONS
#Region
region_sales.plot(kind = 'bar', title = "Sales by Region")
plt.savefig("../output/visuals/region_sales.png")
plt.show()
#Top products
top_products.plot(kind = 'bar', title = "Top Products")
plt.savefig("../output/visuals/top_products.png")
plt.show()
#Category
category_sales.plot(kind = 'pie', autopct = '%1.1f%%', title = "Category Sales")
plt.savefig("../output/visuals/category_sales.png")
plt.show()
#Monthly trend
monthly_sales.plot(marker = 'o', title = "Monthly Sales Trend")
plt.xticks(rotation = 45)
plt.savefig("../output/visuals/monthly_sales.png")
plt.show()
#Save clean data
df.to_csv("../output/cleaned_data.csv", index = False)
print("\n Project Completed Successfully!")