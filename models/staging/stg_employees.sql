with
    source as (
        select

            -- /* Primary Key */
            employee_id

            , first_name ||" "|| last_name as full_name
            , last_name
            , first_name
            , title
            , title_of_courtesy
            , birth_date
            , hire_date
            , address
            , city
            , region
            , postal_code
            , country
            , home_phone
            , extension
            , photo
            , notes
            , reports_to
            , photo_path
            
        from {{ source('northwind_case', 'employees') }}
    )
select * from source


