-- Median Price Of Wines
-- Find the median price for each wine variety across both datasets. Output distinct varieties along with the corresponding median price.
-----------
winemag_p1
-----------
id int
country varchar
description varchar
designation varchar
points int
price float
province varchar
region_1 varchar
region_2 varchar
variety varchar
winery varchar

-----------
winemag_p2
-----------
id int
country varchar
description varchar
designation varchar
points int
price float
province varchar
region_1 varchar
region_2 varchar
taster_name varchar
taster_twitter_handle varchar
title varchar
variet yvarchar
winery varchar


with exhaustive as (select variety, price from winemag_p1
union all
select variety, price from winemag_p2)

select variety, percentile_cont(0.5) # postgresql way to calculate median is via percentile function
within group(order by price) as median # ordered-set aggregate
from exhaustive 
group by variety
