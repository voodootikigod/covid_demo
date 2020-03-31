view: state_region {
  sql_table_name: `lookerdata.covid19.state_region`
    ;;

  dimension: division {
    hidden: yes
    type: string
    sql: ${TABLE}.Division ;;
  }

  dimension: region {
    group_label: "Location"
    label: "Region (US-Only)"
    type: string
    sql: ${TABLE}.Region ;;
  }

  dimension: state {
    primary_key: yes
    hidden: yes
    type: string
    sql: ${TABLE}.State ;;
    drill_fields: [jhu_sample_county_level_final.province_state]
  }

  dimension: state_code {
    hidden: yes
    type: string
    sql: ${TABLE}.state_code ;;
  }

  measure: count {
    hidden: yes
    type: count
    drill_fields: []
  }
}
