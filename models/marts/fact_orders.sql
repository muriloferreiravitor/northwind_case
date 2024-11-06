with
    dim_customers as (
        select * from {{ref('dim_customers')}}
    )
    , dim_employees as (
        select * from {{ref('dim_employees')}}
    )
    , dim_products as (
        select * from {{ref('dim_products')}}
    )
    , dim_shippers as (
        select * from {{ref('dim_shippers')}}
    )
    , stg_orders as (
        select
            stg_orders.*
        from {{ref('stg_orders')}}
        left join dim_customers
            on stg_orders.customer_id = dim_customers.customer_id
        left join dim_employees
            on stg_orders.employee_id = dim_employees.employee_id
        left join dim_shippers
            on stg_orders.shipper_id = dim_shippers.shipper_id
    )
    , stg_order_details as (
        select
            stg_order_details.*
        from {{ref('stg_order_details')}}
        left join dim_products
            on stg_order_details.product_id = dim_products.product_id
    )
    , fact_orders_details as (
        select

            -- /* Primary Key */
            stg_orders.order_id

            -- /* Foreign Key */
            , stg_order_details.product_id
            , stg_orders.customer_id
            , stg_orders.employee_id
            , stg_orders.shipper_id

            -- /* Orders info */
            , stg_orders.order_date
            , stg_orders.required_date
            , stg_orders.shipped_date
            , stg_orders.freight
            , stg_orders.ship_name
            , stg_orders.ship_country
            , stg_orders.ship_region
            , stg_orders.ship_city
            , stg_orders.ship_address
            , stg_orders.ship_postal_code

            -- /* Orders details */            
            , stg_order_details.unit_price
            , stg_order_details.quantity
            , stg_order_details.discount

            /* Orders details metrics */
            , ((stg_order_details.discount / stg_order_details.unit_price) * 100) as order_details_discount_percent
            , (stg_order_details.unit_price * stg_order_details.quantity) as order_details_total_price
            , (stg_order_details.discount * stg_order_details.quantity) as order_details_total_discount
            , ((stg_order_details.unit_price - stg_order_details.discount)
                * stg_order_details.quantity) as order_details_final_price

        from stg_orders
        left join stg_order_details
            on stg_orders.order_id = stg_order_details.order_id
    )
    , fact_orders as (
        select

            -- /* Primary Key */
            order_id

            -- /* Foreign Key */
            , any_value(customer_id) as customer_id
            , any_value(employee_id) as employee_id
            , any_value(shipper_id) as shipper_id

            -- /* Orders info */
            , any_value(order_date) as order_date
            , any_value(required_date) as required_date
            , any_value(shipped_date) as shipped_date
            , any_value(freight) as freight
            , any_value(ship_name) as ship_name
            , any_value(ship_country) as ship_country
            , any_value(ship_region) as ship_region
            , any_value(ship_city) as ship_city
            , any_value(ship_address) as ship_address
            , any_value(ship_postal_code) as ship_postal_code

            /* Orders metrics */
            , sum(order_details_total_price) as order_total_price
            , sum(order_details_total_discount) as order_total_discount
            , sum(order_details_final_price) as order_total_price_minus_discount
            , (sum(order_details_final_price) - any_value(freight)) as order_final_price_minus_freight

        from fact_orders_details
        group by
            order_id
    )
select * from fact_orders