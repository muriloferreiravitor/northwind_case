with
    stg_products as (
        select * from {{ref('stg_products')}}
    )
    , stg_suppliers as (
        select * from {{ref('stg_suppliers')}}
    )
    , stg_categories as (
        select * from {{ref('stg_categories')}}
    )
    , dim_products as (
        select
            *
        from stg_products
        join stg_suppliers
            on stg_products.supplier_id = stg_suppliers.supplier_id
        join stg_categories
            on stg_products.category_id = stg_categories.category_id 
    )
select * from dim_products