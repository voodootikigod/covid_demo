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
