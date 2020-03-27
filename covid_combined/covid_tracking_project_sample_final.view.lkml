view: covid_tracking_project_sample_final {
  sql_table_name: `lookerdata.covid19.covid_tracking_project_sample_final`
    ;;

  dimension: death {
    type: number
    sql: ${TABLE}.death ;;
  }

  dimension: hospitalized {
    type: number
    sql: ${TABLE}.hospitalized ;;
  }

  dimension_group: measurement {
    type: time
    timeframes: [
      raw,
      date,
      week,
      month,
      quarter,
      year
    ]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.measurement_date ;;
  }

  dimension: negative {
    type: number
    sql: ${TABLE}.negative ;;
  }

  dimension: pending {
    type: number
    sql: ${TABLE}.pending ;;
  }

  dimension: positive {
    type: number
    sql: ${TABLE}.positive ;;
  }

  dimension: state {
    type: string
    sql: ${TABLE}.state ;;
  }

  dimension: total {
    type: number
    sql: ${TABLE}.total ;;
  }

  measure: count {
    type: count
    drill_fields: []
  }
}
