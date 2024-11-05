with
    source as (
        select
            
            -- /* Primary Key */
            region_id
            
            , region_description
            
        from {{ source('northwind_case', 'region') }}
    )
select * from source

