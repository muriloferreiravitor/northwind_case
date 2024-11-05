with
    stg_employees as (
        select * from {{ref('stg_employees')}}
    )
    -- , stg_employee_territories as (
    --     select * from {{ref('stg_employee_territories')}}
    -- )
    -- , dim_territories as (
    --     select * from {{ref('dim_territories')}}
    -- )
    , dim_employees as (
        select
            *
            -- stg_employees.*
            -- , dim_territories.*
        from stg_employees
        -- join stg_employee_territories
        --     on stg_employees.employee_id = stg_employee_territories.employee_id
        -- join dim_territories
        --     on stg_employee_territories.territory_id = dim_territories.territory_id 
    )
select * from dim_employees