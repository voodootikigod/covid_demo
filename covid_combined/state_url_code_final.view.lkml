view: state_url_code_final {
  sql_table_name: `lookerdata.covid19.state_url_code_final`
    ;;

  dimension: state {
    primary_key: yes
    hidden: yes
    type: string
    sql: ${TABLE}.state ;;
  }

  dimension: url {
    hidden: yes
    type: string
    sql: ${TABLE}.url ;;
  }

  measure: count {
    hidden: yes
    type: count
    drill_fields: []
  }
}
