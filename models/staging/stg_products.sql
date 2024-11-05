with
    source as (
        select
        
            /* Primary Key */
            product_id

            /* Foreign Key */
            , supplier_id
            , category_id

            , product_name
            , unit_price
            , quantity_per_unit
            , units_in_stock
            , units_on_order
            , reorder_level
            , 
            case
                when discontinued = 1 then true
                else false
            end as is_discontinued
        
        from {{ source('northwind_case', 'products') }}
    )
select * from source