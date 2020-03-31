view: max_date_us {
  derived_table: {
    datagroup_trigger: once_daily
    explore_source: tests_by_state {
      column: max_date {}
    }
  }
  dimension_group: max_date {
    hidden: yes
    type: time
    timeframes: [
      raw,
      date
    ]
    sql: cast(${TABLE}.max_date as date) ;;
  }
}
