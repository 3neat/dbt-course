# Analytics engineering with dbt

Template repository for the projects and environment of the course: Analytics engineering with dbt

## License

Apache 2.0

# Projects
## Week 1:
1. How many users do we have?
```
dbt=# SELECT COUNT(distinct user_id) FROM dbt_brandon_r.stg_users;
 count 
-------
   130
```

2. On average, how many orders to we receive per hour?
```
dbt=# SELECT AVG(orders) as avg_orders FROM ( SELECT date_trunc('hour', created_at) as hourly, COUNT(distinct order_id) as orders FROM dbt_brandon_r.stg_orders WHERE status != 'pending' GROUP BY date_trunc('hour', created_at)) a;

     avg_orders     
--------------------
8.1250000000000000
```

3. On average, how long does an order take from being placed to being delivered?
 ```
 dbt=# SELECT AVG(delivery_time) FROM (SELECT (delivered_at - created_at) as delivery_time FROM dbt_brandon_r.stg_orders WHERE status = 'delivered') x;
          avg           
------------------------
 3 days 22:13:10.504451
 ```

 4. How many users have only made one purchase? two purchases? three+ purchases?
 ```
SELECT 
    COUNT(distinct CASE WHEN orders = 1 THEN user_id ELSE NULL END) as one_purchase
    , COUNT(distinct CASE WHEN orders = 2 THEN user_id ELSE NULL END) as two_purchases
    , COUNT(distinct CASE WHEN orders >= 3 THEN user_id ELSE NULL END) as three_or_more_purchases
FROM (
    SELECT user_id, COUNT(distinct order_id) as orders
    FROM dbt_brandon_r.stg_orders
    GROUP BY user_id
) x;
 one_purchase | two_purchases | three_or_more_purchases 
--------------+---------------+-------------------------
           25 |            22 |                      81
 ```

5. On average, how many unique sessions do we have per hour?
dbt=# SELECT AVG(dist_sessions) FROM (SELECT date_trunc('hour', created_at) as hourly, COUNT(distinct session_id) as dist_sessions FROM dbt_brandon_r.stg_events GROUP BY date_trunc('hour', created_at)) x;
        avg         
--------------------
 7.3894009216589862
