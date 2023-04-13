with payments as (

    select
    id as payment_id,
    orderid as order_id,
    status as payment_status,
    paymentmethod as payment_method,
    amount as total_revenue,
    created as payment_date

    from raw.stripe.payment

)

select * from payments