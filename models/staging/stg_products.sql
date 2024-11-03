with
    source as (
        select *
        from {{ source('northwind_case', 'products') }}
    )
select * from source