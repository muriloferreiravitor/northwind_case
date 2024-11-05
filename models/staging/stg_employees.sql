with
    source as (
        select

            -- /* Primary Key */
            employee_id

            , reports_to
            , first_name ||" "|| last_name as name
            , birth_date
            , country
            , region
            , city
            , address
            , postal_code
            , home_phone
            , hire_date
            , title
            , title_of_courtesy
            , notes
            , extension
            , photo_path
            
        from {{ source('northwind_case', 'employees') }}
    )
select * from source