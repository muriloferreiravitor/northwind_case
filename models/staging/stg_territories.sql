with
    source as (
        select
            
            -- /* Primary Key */
            territory_id
            
            -- /* Foreign Key */
            , region_id

            , territory_description

        from {{ source('northwind_case', 'territories') }}
    )
select * from source
