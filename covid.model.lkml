connection: "lookerdata"

include: "/intl_covid_data/*.view.lkml"
include: "/us_covid_data/*.view.lkml"
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

explore: italy {
  from: italy_regions

#   join: max_date_italy {
#     fields: []
#     relationship: one_to_one
#     sql_on: 1 = 1  ;;
#   }
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

############ Map Layers #################

map_layer: regioni_italiani {
  format: "vector_tile_region"
  url: "https://a.tiles.mapbox.com/v4/looker-maps.61hkfosh/{z}/{x}/{y}.mvt?access_token=@{mapbox_api_key}"
  feature_key: "reg2011_g"
  extents_json_url: "https://rawcdn.githack.com/dwmintz/looker_map_layers/6894c6448fb0721f93e2ce4ce9c30659e6a30c06/regioni_italiani.json"
  min_zoom_level: 3
  max_zoom_level: 11
  property_key: "NOME_REG"
}
map_layer: province_italiane {
  format: "vector_tile_region"
  url: "https://a.tiles.mapbox.com/v4/looker-maps.4ocnvk26/{z}/{x}/{y}.mvt?access_token=@{mapbox_api_key}"
  feature_key: "province_ditalia"
  extents_json_url: "https://rawcdn.githack.com/dwmintz/looker_map_layers/6894c6448fb0721f93e2ce4ce9c30659e6a30c06/province_italiane.json"
  min_zoom_level: 3
  max_zoom_level: 12
  property_key: "NOME_PRO"
}
