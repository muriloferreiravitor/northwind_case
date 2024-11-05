with
    source as (
        select
            
            -- /* Primary Key */
            shipper_id
            
            , company_name
            , phone
            
        from {{ source('northwind_case', 'shippers') }}
    )
select * from source
