# Monthly Percentage Difference
# Given a table of purchases by date, calculate the month-over-month percentage change in revenue. The output should include the year-month date (YYYY-MM) and percentage change, rounded to the 2nd decimal point, and sorted from the beginning of the year to the end of the year.

# sf_transactions table

id          | int
created_at  | datetime
value       | int
purchase_id | int


# Long Format Answer (readibility)


WITH month_level as (SELECT TO_CHAR(created_at, 'YYYY-MM') as year_month, 
                    sum(value) as month_rev

                    FROM sf_transactions

                    GROUP BY TO_CHAR(created_at, 'YYYY-MM')), # or GROUP BY 1
                    
                    
lagged as (SELECT year_month, month_rev, LAG(month_rev) OVER(ORDER BY year_month asc) as prev_month_rev
FROM month_level)

SELECT month, ROUND((month_rev - prev_month_rev)/prev_month_rev*100,2) as perc_diff
FROM lagged


# Condensed Format Answer

SELECT TO_CHAR(created_at, 'YYYY-MM') as year_month,
ROUND(((SUM(value) - LAG(SUM(value)) OVER(ORDER by TO_CHAR(created_at, 'YYYY-MM')))/LAG(SUM(value)) OVER(ORDER BY to_char(created_at, 'YYYY-MM')))*100,2) as perc_diff
FROM
sf_transactions
GROUP by TO_CHAR(created_at, 'YYYY-MM') # or GROUP BY 1
