view: country_url_code_final {
  sql_table_name: `lookerdata.covid19.country_url_code_final` ;;

  dimension: country {
    primary_key: yes
    hidden: yes
    type: string
    sql: ${TABLE}.country ;;
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
