with
    source as (
        select

            -- /* Primary Key */
            customer_id
            
            , company_name
            , contact_name
            , contact_title
            , country
            , region
            , city
            , address
            , postal_code
            , phone
            , fax
            
        from {{ source('northwind_case', 'customers') }}
    )
select * from source