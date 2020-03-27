view: nyt_by_county_data {
  sql_table_name: `lookerdata.covid19.nyt_by_county_data`
    ;;

  dimension: cases {
    type: number
    sql: ${TABLE}.cases ;;
  }

  dimension: county {
    type: string
    sql: ${TABLE}.county ;;
  }

  dimension_group: date {
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
    sql: ${TABLE}.date ;;
  }

  dimension: deaths {
    type: number
    sql: ${TABLE}.deaths ;;
  }

  dimension: fips {
    type: number
    sql: ${TABLE}.fips ;;
  }

  dimension: state {
    type: string
    sql: ${TABLE}.state ;;
  }

  measure: count {
    type: count
    drill_fields: []
  }
}
