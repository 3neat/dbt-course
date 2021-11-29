## Part 1:
#What is our repeat rate?#
```
select
    count(distinct case when total_orders >=2 then user_id else null end) as repeat_users
    , count(distinct user_id) as total_users
    , round((count(distinct case when total_orders >= 2 then user_id else null end)::numeric / count(distinct user_id)::numeric),2) as repeat_rate
from dbt_brandon_r_reporting.dim_users;
```

#2. What are good indicators of a user who will likely purchase again? What about indicators of users who are likely NOT to purchase again? If you had more data, what features would you want to look into to answer this question?#

i set up an `int_users` and `dim_users` to include the users: `zip, state, country, email_domain, account_age_days, has_used_promo_code, total_orders_made, last_delivered_order_at_utc, total_gross_order_costs, total_shipping_costs` as potential features that could be analyzed for determining liklihood of a user purchasing again, or NOT purchasing again. with additional time, i'd also tie in events from the events table (ie. `added_to_cart, deleted_from_cart, checkout, etc...`) to improve the features available.

## Part 2:

#What assumptions are you making about each model? (ie. why are you adding each test?)#
i'm assuming that there are some issues with the data (ie. events.created_at); i create tests at the intermediate model to filter out NULL values here. this is something that i would assume eng would need to fix. i keep the data at staging to have as reference if it's needed.

i found bad data by trying to make sense of some assumptions i made on my part. one of these is the assumption that the `id` fields are irrelevant. using these as primary identifiers for `users <--> address` would result in mismatches. 

due to lack of time, i didn't get a chance to explore the dbt_utils datespine package. i would likely leverage this to build out date cohorts for the models, and explore leveraging incremental loads / snapshots if this had additional data...