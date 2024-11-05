with
    stg_territories as (
        select * from {{ref('stg_territories')}}
    )
    , stg_region as (
        select * from {{ref('stg_region')}}
    )
    , dim_territories as (
        select
            stg_territories.territory_id
            , stg_territories.region_id
            , stg_territories.territory_description
            , stg_region.region_description
        from stg_territories
        join stg_region
            on stg_territories.region_id = stg_region.region_id
    )
select * from dim_territories