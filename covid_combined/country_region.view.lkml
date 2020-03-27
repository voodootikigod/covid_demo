view: country_region {
  sql_table_name: `lookerdata.covid19.country_region`
    ;;

  dimension: country {
    hidden: yes
    primary_key: yes
    type: string
    map_layer_name: countries
    sql: ${TABLE}.Country ;;
  }

  dimension: global_south {
    hidden: yes
    type: string
    sql: ${TABLE}.Global_South ;;
  }

  dimension: region {
    group_label: "Location"
    label: "Region (World)"
    type: string
    sql: ${TABLE}.Region ;;
    drill_fields: [jhu_sample_county_level_final.country_region]
  }

  measure: count {
    hidden: yes
    type: count
    drill_fields: []
  }
}
