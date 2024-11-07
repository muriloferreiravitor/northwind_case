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
            stg_products.product_id

            , stg_products.product_name
            , stg_products.unit_price
            , stg_products.quantity_per_unit
            , stg_products.units_in_stock
            , stg_products.units_on_order
            , stg_products.reorder_level
            , stg_products.is_discontinued

            , stg_categories.product_category_name
            , stg_categories.product_description

            , stg_suppliers.company_name
            , stg_suppliers.contact_name
            , stg_suppliers.contact_title
            , stg_suppliers.country
            , stg_suppliers.region
            , stg_suppliers.city
            , stg_suppliers.address
            , stg_suppliers.postal_code
            , stg_suppliers.phone
            , stg_suppliers.fax
            , stg_suppliers.homepage

        from stg_products
        left join stg_suppliers
            on stg_products.supplier_id = stg_suppliers.supplier_id
        left join stg_categories
            on stg_products.category_id = stg_categories.category_id 
    )
select * from dim_products