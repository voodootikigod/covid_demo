view: us_zipcode_boundaries {
  label: "Geographic Areas"
  sql_table_name: `bigquery-public-data.geo_us_boundaries.zip_codes`;;

  dimension: zip_code {
    primary_key: yes
    type: zipcode
    map_layer_name: us_zipcode_tabulation_areas
    sql: ${TABLE}.zip_code ;;
  }

  dimension: city {
    drill_fields: [zip_code]
    type: string
    sql: ${TABLE}.city ;;
  }

  dimension: county {
    type: string
    sql: ${TABLE}.county ;;
  }

  dimension: state_fips_code {
    hidden: yes
    type: string
    sql: ${TABLE}.state_fips_code ;;
  }

  dimension: state_code {
    type: string
    sql: ${TABLE}.state_code ;;
  }

  dimension: state_name {
    drill_fields: [city, zip_code]
    map_layer_name: us_states
    type: string
    sql: case when ${TABLE}.state_name = 'Washington, D.C.' then 'District of Columbia'
              when  ${TABLE}.state_name = 'Washington (state)' then 'Washington'
              when ${TABLE}.state_name = 'Georgia (U.S. state)' then 'Georgia'
    else  ${TABLE}.state_name end ;;
  }

  dimension: fips_class_code {
    hidden: yes
    type: string
    sql: ${TABLE}.fips_class_code ;;
  }

  dimension: mtfcc_feature_class_code {
    hidden: yes
    type: string
    sql: ${TABLE}.mtfcc_feature_class_code ;;
  }

  dimension: functional_status {
    hidden: yes
    type: string
    sql: ${TABLE}.functional_status ;;
  }

  dimension: area_land_meters {
    hidden: yes
    type: number
    sql: ${TABLE}.area_land_meters ;;
  }

  measure: total_area_land_meters {
    hidden: yes
    type: sum
    sql: ${area_land_meters} ;;
  }

  dimension: area_water_meters {
    hidden: yes
    type: number
    sql: ${TABLE}.area_water_meters ;;
  }

  dimension: internal_point_lat {
    hidden: yes
    type: number
    sql: ${TABLE}.internal_point_lat ;;
  }
#
#   measure: average_lat {
#     type: average
#     sql: ${internal_point_lat} ;;
#   }

  dimension: zipcode_location {
    description: "Point on the map for zipcode"
    type: location
    sql_latitude: ${internal_point_lat} ;;
    sql_longitude: ${internal_point_lon} ;;
  }

  dimension: internal_point_lon {
    hidden: yes
    type: number
    sql: ${TABLE}.internal_point_lon ;;
  }

#   measure: average_lon {
#     type: average
#     sql: ${internal_point_lat} ;;
#   }

  dimension: internal_point_geom {
    hidden: yes
    type: string
    sql: ${TABLE}.internal_point_geom ;;
  }

  dimension: zip_code_geom {
    hidden: yes
    type: string
    sql: ${TABLE}.zip_code_geom ;;
  }

}
