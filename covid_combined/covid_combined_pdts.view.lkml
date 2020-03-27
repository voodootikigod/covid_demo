view: max_date_covid {
  derived_table: {
    datagroup_trigger: covid_data
    explore_source: jhu_sample_county_level_final {
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
