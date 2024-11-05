with
    source as (
        select

            -- /* Primary Key */
            employee_id
            
            -- /* Foreign Key */
            , territory_id

        from {{ source('northwind_case', 'employee_territories') }}
    )
select * from source
