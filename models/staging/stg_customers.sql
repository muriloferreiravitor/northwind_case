with
    source as (
        select

            -- /* Primary Key */
            customer_id
            
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
            
        from {{ source('northwind_case', 'customers') }}
    )
select * from source
