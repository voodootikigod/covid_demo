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

# view: {
#   sql_table_name:
#       {% if covid_data.country._in_query %} ${days_since_first_case_country.SQL_TABLE_NAME}
#       {% else %} ${days_since_first_case_state.SQL_TABLE_NAME}
#       {% endif %}
#   ;;
# }

view: days_since_first_case_country {
  derived_table: {
    datagroup_trigger: once_daily
    explore_source: covid_data {
      column: country_raw {}
      column: min_date {}
      filters: {
        field: covid_data.confirmed_new_cases
        value: ">0"
      }
    }
  }
  dimension: country_raw {
    primary_key: yes
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
