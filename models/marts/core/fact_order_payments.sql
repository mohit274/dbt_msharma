with orders as (

    select
    *
    from {{ref ('stg_orders')}}

),

payments as (

    select
    *
    from {{ref ('stg_payments')}}

),

fact_cohort_analysis as (

    select
        orders.order_id,
        p.payment_id,
        orders.customer_id,
        orders.order_status,
        p.payment_status,
        p.payment_method,
        coalesce (sum(p.total_revenue),0) as payment_amount,
        orders.order_date,
        p.payment_date,
        current_date as created_at

    from orders 

    left join payments as p using (order_id)

    group by 1,2,3,4,5,6,8,9

)

select * from fact_cohort_analysis