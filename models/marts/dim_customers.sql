with
    stg_customers as (
        select * from {{ref('stg_customers')}}
    )
    , dim_customers as (
        select
            *
        from stg_customers
    )
select * from dim_customers