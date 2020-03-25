connection: "lookerdata"

include: "/intl_covid_data/*.view.lkml"
include: "/us_covid_data/*.view.lkml"

include: "/census_data/*.view.lkml"
# include: "/**/view.lkml"                   # include all views in this project
# include: "/dashboards/*.dashboard.lookml"   # include a LookML dashboard called my_dashboard

explore: covid_data {

  join: max_date_intl {
    fields: []
    relationship: one_to_one
    sql_on: 1 = 1  ;;
  }

  join: cases_by_country_by_date {
    # fields: []
    relationship: many_to_one
    sql_on:
          ${covid_data.country_raw} = ${cases_by_country_by_date.country_raw}
      AND ${covid_data.date_raw} = ${cases_by_country_by_date.date_raw}
      ;;
  }

  join: days_since_first_case_country {
    fields: []
    relationship: many_to_one
    sql_on: ${covid_data.country_raw} = ${days_since_first_case_country.country_raw} ;;
  }

  join: days_since_first_case_state {
    fields: []
    relationship: many_to_one
    sql_on: ${covid_data.state} = ${days_since_first_case_state.state} ;;
  }
  join: prior_days_cases {
    relationship: one_to_one
    type: inner
    sql_on: ${prior_days_cases.country_raw} = ${covid_data.country_raw}
      AND ${prior_days_cases.state} = ${covid_data.state}
      AND ${prior_days_cases.date_date} = ${covid_data.date_date}

    ;;
  }
}

explore: tests_by_state {

  join: max_date_us {
    fields: []
    relationship: one_to_one
    sql_on: 1 = 1  ;;
  }
}

############ Census Explores ############

explore: acs_zip_codes_2017_5yr {
  label: "ACS 2017 Data, By Zipcode"
  join: us_zipcode_boundaries {
    relationship: one_to_one
    sql_on: ${acs_zip_codes_2017_5yr.geo_id} = ${us_zipcode_boundaries.zip_code} ;;
  }
  join: zipcode_facts {
    relationship: one_to_one
    sql_on: ${zipcode_facts.us_zipcode_boundaries_zip_code}=${us_zipcode_boundaries.zip_code} ;;
  }
}





############ Caching Logic ############

persist_with: once_weekly

### PDT Timeframes

datagroup: once_daily {
  max_cache_age: "24 hours"
  sql_trigger: SELECT current_date() ;;
}

datagroup: once_weekly {
  max_cache_age: "168 hours"
  sql_trigger: SELECT extract(week from current_date()) ;;
}

datagroup: once_monthly {
  max_cache_age: "720 hours"
  sql_trigger: SELECT extract(month from current_date()) ;;
}

datagroup: once_yearly {
  max_cache_age: "9000 hours"
  sql_trigger: SELECT extract(year from current_date()) ;;
}
