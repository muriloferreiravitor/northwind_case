with
    fact_orders_details as (
        select * from {{ref('fact_orders_details')}}
    )
    , flat_orders as (
        select

            -- /* Primary Key */
            order_id

            , max(order_date) as order_date
            , any_value(freight) as freight
            , any_value(customer_country) as customer_country 

            /* Orders metrics */
            , sum(order_details_total_price) as order_total_price
            , sum(order_details_total_discount) as order_total_discount
            , sum(order_details_final_price) as order_final_price
            , (sum(order_details_final_price) + any_value(freight)) as order_final_price_plus_freight
            , ((sum(order_details_total_discount) / sum(order_details_total_price)) * 100) as total_discount_percent
            , ((sum(distinct freight) / sum(order_details_final_price)) * 100) as freight_per_orders_percent

        from fact_orders_details
        group by
            order_id
    )
select * from flat_orders