view: state_region {
  sql_table_name: `lookerdata.covid19.state_region`
    ;;

  dimension: division {
    type: string
    sql: ${TABLE}.Division ;;
  }

  dimension: region {
    type: string
    sql: ${TABLE}.Region ;;
  }

  dimension: state {
    type: string
    sql: ${TABLE}.State ;;
  }

  dimension: state_code {
    type: string
    sql: ${TABLE}.state_code ;;
  }

  measure: count {
    type: count
    drill_fields: []
  }
}
