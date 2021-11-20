{% snapshot hourly_orders_snapshot %}
{{ 
    config(
        target_schema='snapshots',
        unique_key='id',

        strategy='timestamp',
        updated_at='updated_at'
    )

}}

SELECT 
FROM {{ source('staging', 'orders')}}

{% endsnapshot %}