view: max_date_intl {
  derived_table: {
    datagroup_trigger: once_daily
    explore_source: covid_data {
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

view: cases_by_country_by_date {
  derived_table: {
    datagroup_trigger: once_daily
    explore_source: covid_data {
      column: country_raw {}
      column: date_raw {}
      column: confirmed_running_total {}
    }
  }
  dimension: pk {
    hidden: yes
    primary_key: yes
    type: string
    sql: concat(${country_raw},cast(${date_raw} as string)) ;;
  }
  dimension: country_raw {
    hidden: yes
  }
  dimension_group: date {
    type: time
    timeframes: [
      raw,
      date
    ]
    hidden: yes
    sql: cast(${TABLE}.date_raw as date) ;;
  }
  dimension: confirmed_running_total {
    hidden: yes
  }

  parameter: number_of_cases {
    type: number
    default_value: "1"
  }

  dimension: is_number_of_cases_greater {
    hidden: yes
    type: yesno
    sql: ${confirmed_running_total} > {% parameter number_of_cases %} ;;
  }

  measure: min_date {
    hidden: yes
    type: date
    sql: min(${date_raw}) ;;
  }
}


view: days_since_first_case_country {
  derived_table: {
    # datagroup_trigger: once_daily
    explore_source: covid_data {
      column: country_raw { field: cases_by_country_by_date.country_raw }
      column: min_date { field: cases_by_country_by_date.min_date }
      filters: {
        field: cases_by_country_by_date.is_number_of_cases_greater
        value: "Yes"
      }
    }
  }
  dimension: country_raw {
    primary_key: yes
    hidden: yes
  }
  dimension_group: min {
    type: time
    timeframes: [
      raw,
      date
    ]
    hidden: yes
    sql: cast(${TABLE}.min_date as date) ;;
  }
}

view: days_since_first_case_state {
  derived_table: {
    datagroup_trigger: once_daily
    explore_source: covid_data {
      column: country {}
      column: state {}
      column: min_date {}
      filters: {
        field: covid_data.confirmed_new_cases
        value: ">0"
      }
    }
  }
  dimension: pk {
    primary_key: yes
    sql: concat(${state},${country}) ;;
  }
  dimension: country {
    hidden: yes
  }
  dimension: state {
    hidden: yes
  }
  dimension_group: min {
    type: time
    timeframes: [
      raw,
      date
    ]
    hidden: yes
    sql: cast(${TABLE}.min_date as date) ;;
  }
}


view: prior_days_cases {
  derived_table: {
    datagroup_trigger: once_daily
    explore_source: covid_data {
      column: date_date {}
      column: country_raw {}
      column: state {}
      column: confirmed_running_total {}
      derived_column: prior_1_day_cumulative_cases {
        sql: coalesce (max (${confirmed_running_total}) OVER (PARTITION BY ${country_raw}, ${state} ORDER BY ${date_date} asc ROWS BETWEEN 2 PRECEDING and 1 PRECEDING),0) ;;
      }
      derived_column: prior_2_days_cumulative_cases {
        sql: coalesce (max (${confirmed_running_total}) OVER (PARTITION BY ${country_raw}, ${state} ORDER BY ${date_date} asc ROWS BETWEEN 3 PRECEDING and 2 PRECEDING),0) ;;
      }
      derived_column: prior_3_days_cumulative_cases {
        sql: coalesce (max (${confirmed_running_total}) OVER (PARTITION BY ${country_raw}, ${state} ORDER BY ${date_date} asc ROWS BETWEEN 4 PRECEDING and 3 PRECEDING),0) ;;
      }
      derived_column: prior_4_days_cumulative_cases {
        sql: coalesce (max (${confirmed_running_total}) OVER (PARTITION BY ${country_raw}, ${state} ORDER BY ${date_date} asc ROWS BETWEEN 5 PRECEDING and 4 PRECEDING),0) ;;
      }
      derived_column: prior_5_days_cumulative_cases {
        sql: coalesce (max (${confirmed_running_total}) OVER (PARTITION BY ${country_raw}, ${state} ORDER BY ${date_date} asc ROWS BETWEEN 6 PRECEDING and 5 PRECEDING),0) ;;
      }
      derived_column: prior_6_days_cumulative_cases {
        sql: coalesce (max (${confirmed_running_total}) OVER (PARTITION BY ${country_raw}, ${state} ORDER BY ${date_date} asc ROWS BETWEEN 7 PRECEDING and 6 PRECEDING),0) ;;
      }
      derived_column: prior_7_days_cumulative_cases {
        sql: coalesce (max (${confirmed_running_total}) OVER (PARTITION BY ${country_raw}, ${state} ORDER BY ${date_date} asc ROWS BETWEEN 8 PRECEDING and 7 PRECEDING),0) ;;
      }
    }
  }
  dimension: date_date {
    type: date
  }
  dimension: country_raw {}
  dimension: state {}
  dimension: prior_1_day_cumulative_cases {type:number}
  dimension: prior_2_days_cumulative_cases {type:number}
  dimension: prior_3_days_cumulative_cases {type:number}
  dimension: prior_4_days_cumulative_cases {type:number}
  dimension: prior_5_days_cumulative_cases {type:number}
  dimension: prior_6_days_cumulative_cases {type:number}
  dimension: prior_7_days_cumulative_cases {type:number}
}
