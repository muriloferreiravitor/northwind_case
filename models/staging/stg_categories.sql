with
    source as (
        select

            -- /* Primary Key */
            category_id

            , category_name as product_category_name
            , description as product_description
            , picture

        from {{ source('northwind_case', 'categories') }}
    )
select * from source