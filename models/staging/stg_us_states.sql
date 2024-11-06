with
    source as (
        select
            
            -- /* Primary Key */
            state_id
            
            , state_abbr
            , state_name
            , state_region

        from {{ source('northwind_case', 'us_states') }}
    )
select * from source