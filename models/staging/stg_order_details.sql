with
    source as (
        select
            
            -- /* Primary Key */
            order_id
            
            -- /* Foreign Key */
            , product_id
            
            , unit_price
            , quantity
            , discount

        from {{ source('northwind_case', 'order_details') }}
    )
select * from source
