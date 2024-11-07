with
    fact_orders_details as (
        select * from {{ref('fact_orders_details')}}
    )
    , customer_last_order as (
        select
            customer_name
            , any_value(customer_country) as customer_country
            , max(order_date) as last_order_date
            , count (distinct order_id) as qtd_order_id
            , sum(distinct freight) as sum_freight
            , sum(order_details_total_price) as sum_order_details_total_price
            , sum(order_details_total_discount) as sum_order_details_total_discount
            , sum(order_details_final_price) as sum_order_details_final_price

        from fact_orders_details
        group by customer_name
    )
    , customer_churn as (
        select
            customer_name
            , customer_country
            , last_order_date
            , qtd_order_id
            , sum_freight
            , sum_order_details_total_price
            , sum_order_details_total_discount
            , sum_order_details_final_price
            , ((sum_order_details_total_discount / sum_order_details_total_price) * 100) as total_discount_percent
            , ((sum_freight / sum_order_details_final_price) * 100) as freight_per_orders_percent
            , if (last_order_date < DATE_SUB('1998-05-01', INTERVAL 6 MONTH), true, false) as churn_6m
            ,
            if (
                (last_order_date < (DATE_SUB('1998-05-01', INTERVAL 3 MONTH)))
                and (last_order_date > (DATE_SUB('1998-05-01', INTERVAL 6 MONTH))), 
                true, false
            ) as churn_3m
        from customer_last_order
    )
select * from customer_churn