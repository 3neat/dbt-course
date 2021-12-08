## Week 3
#What is the overall conversion rate?#
> 0.352
```
select round(conv_rate,4) from dbt_brandon_r_product.fact_conversion_rate;
```

#2. What is our conversion rate by product?#
Pothos,0.48
Bamboo,0.53
Philodendron,0.42
Monstera,0.67
String of pearls,0.63
ZZ Plant,0.55
Snake Plant,0.43
Orchid,0.6
Birds Nest Fern,0.55
Calathea Makoyana,0.48
Peace Lily,0.63
Bird of Paradise ,0.52
Fiddle Leaf Fig,0.44
Ficus,0.37
Pilea Peperomioides,0.48
Angel Wings Begonia,0.47
Jade Plant,0.43
Arrow Head,0.46
Majesty Palm,0.57
Spider Plant,0.5
Money Tree,0.48
Cactus,0.52
Devil's Ivy,0.32
Alocasia Polly,0.38
Pink Anthurium,0.54
Dragon Tree,0.54
Aloe Vera,0.41
Rubber Plant,0.38
Ponytail Palm,0.37
Boston Fern,0.52

```
select * from dbt_brandon_r_product.fact_conversion_rate_by_product;
```

on just a cursory look, we don't account for any cart_deletions per product. this means that a user can add and delete a product and it will be accounted for in this conversion rate calculation.

