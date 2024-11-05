with
    source as (
        select

            -- /* Primary Key */
            order_id

            -- /* Foreign Key */
            , customer_id
            , employee_id
            , ship_via as shipper_id

            , order_date
            , required_date
            , shipped_date
            , freight
            , ship_name
            , ship_address
            , ship_city
            , ship_region
            , ship_postal_code
            , ship_country

        from {{ source('northwind_case', 'orders') }}
    )
select * from source