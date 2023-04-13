with customer_orders as (

    select
    customer_id,
    min(order_date) as first_order_date,
    max(order_date) as last_order_date,
    count(order_id) as total_orders

    from {{ref ('stg_orders')}}

    group by 1

),

customer_payments as (

    select
    customer_id,
    sum(coalesce (payments.total_revenue,0)) as total_revenue

    from {{ref ('stg_orders')}}

    left join {{ref ('stg_payments')}} as payments using (order_id)

    group by 1

),

fact_cohort_analysis as (

    select
    customer_orders.customer_id,
    customer_orders.first_order_date,
    customer_orders.last_order_date,
    (customer_orders.last_order_date-customer_orders.first_order_date)/coalesce (customer_orders.total_orders, 0) as avg_days_btwn_orders ,
    coalesce (customer_orders.total_orders, 0) as total_orders,
    coalesce (customer_payments.total_revenue, 0) as total_revenue,
    current_date as created_at

    from customer_orders

    left join customer_payments using (customer_id)

)

select * from fact_cohort_analysis