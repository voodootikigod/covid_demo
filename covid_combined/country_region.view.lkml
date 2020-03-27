view: country_region {
  sql_table_name: `lookerdata.covid19.country_region`
    ;;

  dimension: country {
    type: string
    map_layer_name: countries
    sql: ${TABLE}.Country ;;
  }

  dimension: global_south {
    type: string
    sql: ${TABLE}.Global_South ;;
  }

  dimension: region {
    type: string
    sql: ${TABLE}.Region ;;
  }

  measure: count {
    type: count
    drill_fields: []
  }
}
