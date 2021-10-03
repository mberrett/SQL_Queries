--Revenue Over Time
--Find the 3-month rolling average of total revenue from purchases given a table with users, 
--their purchase amount, and date purchased. Do not include returns which are represented by negative purchase values. 

--Output the year-month (YYYY-MM) and 3-month rolling average of revenue, sorted from earliest month to latest month.

--A 3-month rolling average is defined by calculating the average total revenue from all user purchases for the current month and previous two months. 
--The first two months will not be a true 3-month rolling average since we are not given data from last year.

customer_purchases
user_id      |  int
created_at   |  datetime
purchase_amt |  int


WITH date_lever as 
(SELECT user_id, purchase_amt, TO_CHAR(created_at, 'YYYY-MM') as year_month
FROM customer_purchases),

month_level as (SELECT sum(purchase_amt) as monthly_purchase, year_month
FROM date_lever
WHERE purchase_amt > 0
GROUP by year_month
ORDER by year_month)

SELECT year_month, avg(monthly_purchase) over(ROWS BETWEEN 2 PRECEDING AND CURRENT ROW) three_month_avg
FROM month_level

