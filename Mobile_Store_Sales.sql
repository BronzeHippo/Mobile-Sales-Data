    with cte_price as 
  (
  select Customer_name, sum(price) as TotalPrice, sum(Quantity_Sold) as QuantityBought
  from sales
  group by Customer_Name
  )
  select Customer_name, TotalPrice, QuantityBought
  from cte_price
  where TotalPrice > $1000000 and QuantityBought > 50
  order by QuantityBought desc;

  -- Total and Average sales/revenue broken down by brand
  select Brand, sum(Price) as TotalRevenue, sum(Quantity_Sold) as QuantitySold, sum(price)/sum(Quantity_Sold) as AvgPrice
  from sales
  group by Brand
  order by TotalRevenue desc;

  -- Performance by Processor + SSD combinations(revenue, volume, and average price)
  select Processor_Specification, SSD, sum(Price) as TotalRevenue, sum(Quantity_Sold) as QuantitySold 
  from sales
  group by Processor_Specification, SSD
  order by TotalRevenue;

  -- Brand + Region cross-analysis
  select Brand, Region, sum(Price) as TotalRevenue, sum(Quantity_Sold) as QuantitySold
  from sales
  group by Region, brand
  order by Brand;

  -- Top product performers per brand
  select brand, sales.Product, sum(price) as TotalRevenue, sum(Quantity_Sold) as QuantitySold
  from sales
  group by Brand, sales.Product
  order by TotalRevenue desc;

  -- Average Price per product
  select brand, sum(price) as TotalRevenue, sum(Quantity_Sold) as QuantitySold, sum(price)/sum(Quantity_Sold) as AvgPrice
  from sales
  group by Brand
  order by AvgPrice desc;

  -- Average price per transaction by brand
  select brand, sum(price) as TotalRevenue, count(Quantity_Sold) as QuantitySold, sum(price)/count(Quantity_Sold) as AvgPrice
  from sales
  group by brand 
  order by AvgPrice desc;

  -- Inventory Efficiency
  select brand, sum(price) as TotalPrice, sum(Quantity_Sold) as QuantitySold, min(Days_in_Stock) as MinStock, 
  max(Days_in_Stock) as MaxStock, avg(Days_in_Stock) as AvgStock, count(Quantity_Sold) as Transactions
  from sales
  group by brand
  order by Transactions desc;
  
  -- Fastest moving stocks
  with cte_stock as 
 (
  select brand, sales.product, Avg(Days_in_Stock) as AvgStock, count(Quantity_Sold) as Transactions
  from sales
  group by Brand, sales.Product
  )
  select *
  from cte_stock
  where AvgStock < 30

  -- Overall performance by region
  select region, sum(price) as TotalRevenue, count(price) as Transactions, (sum(price)/count(price)) as Avg_price_per_Transaction
  from sales
  group by region
  order by TotalRevenue desc;

  --Sales by RAM 
  select RAM, sum(Price) as TotalRevenue, count(*) as Transactions, (sum(price)/count(*)) as Avg_price_per_Transaction
  from sales
  group by RAM
  order by TotalRevenue desc;

  -- Monthly Sales
  select DATENAME(month, Dispatch_Date) + ' ' + CAST(YEAR(Dispatch_Date) AS VARCHAR(4)) as sales_month, 
  sum(price) as monthly_revenue, count(*) as transactions
  from sales
  group by DATENAME(month, Dispatch_Date) + ' ' + CAST(YEAR(Dispatch_Date) AS VARCHAR(4))
  order by sales_month

  -- Top/Bottom Performers
  select  Top 10 brand, sales.product, sum(price) as total_revenue, sum(quantity_sold) as units_sold
  from sales
  group by brand, sales.product
  order by total_revenue desc;


 



