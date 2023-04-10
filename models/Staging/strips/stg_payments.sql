with payments as ( 

    select
    id as payment_id,
    orderid as order_id,
    amount as total_revenue

    from raw.stripe.payment

)