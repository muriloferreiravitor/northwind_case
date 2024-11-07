with
    fact_orders_details as (
        select * from {{ref('fact_orders_details')}}
    )
    , flat_orders_details as (
        select

            order_id
            , order_date

            , customer_name
            , customer_country

            , shipper_name
            , freight

            , product_name
            , product_category_name
            , product_description

            , unit_price
            , quantity
            , discount

            , discount_percent
            , order_details_total_price
            , order_details_total_discount
            , order_details_final_price

        from fact_orders_details
    )
select * from flat_orders_details