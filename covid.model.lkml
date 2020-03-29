connection: "lookerdata"

include: "/covid_combined/*.view.lkml"
include: "/census_data/*.view.lkml"
include: "/intl_covid_data/*.view.lkml"
include: "/us_covid_data/*.view.lkml"

# include: "/**/view.lkml"                   # include all views in this project
# include: "/dashboards/*.dashboard.lookml"   # include a LookML dashboard called my_dashboard

############ New COVID ############
## Note: this dataset has real data for JHU Daily Summary & COVID Tracking Project for March 26, 2020
## All other data (March 1 - 25) is extrapolated from those values

explore: jhu_sample_county_level_final {
  group_label: "*COVID 19"
  label: "COVID - Main"
  view_label: " COVID19"

  join: covid_tracking_project_sample_final {
    view_label: " COVID19"
    relationship: many_to_one
    sql_on:
          ${jhu_sample_county_level_final.province_state} = ${covid_tracking_project_sample_final.state}
      AND ${jhu_sample_county_level_final.measurement_raw} = ${covid_tracking_project_sample_final.measurement_raw}
    ;;
  }

  join: max_date_covid {
    relationship: one_to_one
    sql_on: 1 = 1  ;;
  }

  join: max_date_tracking_project {
    relationship: one_to_one
    sql_on: 1 = 1  ;;
  }

  join: population_by_county_state_country {
    view_label: " COVID19"
    relationship: many_to_one
    sql_on: ${jhu_sample_county_level_final.pre_pk} = ${population_by_county_state_country.pre_pk} ;;
  }

  join: state_region {
    view_label: " COVID19"
    relationship: many_to_one
    sql_on: ${jhu_sample_county_level_final.province_state} = ${state_region.state} ;;
  }

  join: country_region {
    view_label: " COVID19"
    relationship: many_to_one
    sql_on: ${jhu_sample_county_level_final.country_region} = ${country_region.country} ;;
  }

  join: prior_days_cases_covid {
    view_label: " COVID19"
    relationship: one_to_one
    sql_on:
        ${jhu_sample_county_level_final.measurement_date} = ${prior_days_cases_covid.measurement_date}
    AND ${jhu_sample_county_level_final.pre_pk} = ${prior_days_cases_covid.pre_pk};;
  }
}

explore: kpis_by_entity_by_date {
  group_label: "*COVID 19"
  label: "COVID Apps - Compare Geographies"
  view_label: " COVID19"
  sql_always_where:
          {% if kpis_by_entity_by_date.days_since_first_outbreaks._in_query %} ${days_since_first_outbreaks} > 0
          {% else %}  1 = 1
          {% endif %}
  ;;
}


############ Census ############

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

explore: acs_puma_2018 {
  group_label: "IN PROGRESS"
  label: "DRAFT: Census Data (PUMA Level)"

  join: zip_to_puma_v2 {
    relationship: many_to_many
    sql_on: ${acs_puma_2018.geo_id} = ${zip_to_puma_v2.puma} ;;
  }

#   join: us_zipcode_boundaries {
#     relationship: one_to_one
#     sql_on: ${zip_to_puma_v2.zcta5} = ${us_zipcode_boundaries.zip_code} ;;
#   }
#   join: zipcode_facts {
#     relationship: one_to_one
#     sql_on: ${zipcode_facts.us_zipcode_boundaries_zip_code}=${us_zipcode_boundaries.zip_code} ;;
#   }

}

############ OLD INTL ############

explore: covid_data {
  group_label: "OLD"

  join: max_date_intl {
    fields: []
    relationship: one_to_one
    sql_on: 1 = 1  ;;
  }

#   join: cases_by_country_by_date {
#     # fields: []
#     relationship: many_to_one
#     sql_on:
#           ${covid_data.country_raw} = ${cases_by_country_by_date.country_raw}
#       AND ${covid_data.date_raw} = ${cases_by_country_by_date.date_raw}
#       ;;
#   }
#
#   join: days_since_first_case_country {
#     fields: []
#     relationship: many_to_one
#     sql_on: ${covid_data.country_raw} = ${days_since_first_case_country.country_raw} ;;
#   }
#
#   join: days_since_first_case_state {
#     fields: []
#     relationship: many_to_one
#     sql_on: ${covid_data.state} = ${days_since_first_case_state.state} ;;
#   }

  join: prior_days_cases {
    relationship: one_to_one
    type: inner
    sql_on: ${prior_days_cases.country_raw} = ${covid_data.country_raw}
      AND ${prior_days_cases.state} = ${covid_data.state}
      AND ${prior_days_cases.date_date} = ${covid_data.date_date}
    ;;
  }
}



explore: italy {
  from: italy_regions
}


############ OLD US ############

explore: tests_by_state {
  group_label: "OLD"

  join: max_date_us {
    fields: []
    relationship: one_to_one
    sql_on: 1 = 1  ;;
  }

  join: acs_puma_state_facts {
    relationship: many_to_one
    sql_on: ${tests_by_state.state} = ${acs_puma_state_facts.state_abbreviation} ;;
  }

}

############ Caching Logic ############

persist_with: covid_data

### PDT Timeframes

datagroup: covid_data {
  max_cache_age: "12 hours"
  sql_trigger:
  SELECT sum(count)
  FROM
  (
    SELECT count(*) as count FROM `lookerdata.covid19.nyt_covid_data`
    UNION ALL
    SELECT count(*) as count FROM `bigquery-public-data.covid19_jhu_csse.summary`
  )
  ;;
}

datagroup: jhu_data {
  max_cache_age: "12 hours"
  sql_trigger: SELECT count(*) FROM  `bigquery-public-data.covid19_jhu_csse.summary` ;;
}


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
map_layer: us_pumas {
  format: "vector_tile_region"
  url: "https://a.tiles.mapbox.com/v4/looker-maps.3ip3jv1a/{z}/{x}/{y}.mvt?access_token=@{mapbox_api_key}"
  feature_key: "ipums_puma_2010geojson"
  extents_json_url: "https://rawcdn.githack.com/dwmintz/looker_map_layers/4a48ef77a012a9be8d9e1df7aa38e783f5f81e82/puma_extents.json"
  min_zoom_level: 3
  max_zoom_level: 13
  property_key: "GEOID"
}
