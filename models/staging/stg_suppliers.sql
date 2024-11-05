with
    source as (
        select
            
            -- /* Primary Key */
            supplier_id
            
            , company_name
            , contact_name
            , contact_title
            , address
            , city
            , region
            , postal_code
            , country
            , phone
            , fax
            , homepage
            
        from {{ source('northwind_case', 'suppliers') }}
    )
select * from source
