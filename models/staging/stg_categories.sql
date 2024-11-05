with
    source as (
        select

            -- /* Primary Key */
            category_id

            , category_name
            , description
            , picture

        from {{ source('northwind_case', 'categories') }}
    )
select * from source