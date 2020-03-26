view: max_date_intl {
  derived_table: {
    datagroup_trigger: jhu_data
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

# view: cases_by_country_by_date {
#   derived_table: {
#     datagroup_trigger: jhu_data
#     explore_source: covid_data {
#       column: country_raw {}
#       column: date_raw {}
#       column: confirmed_running_total {}
#     }
#   }
#   dimension: pk {
#     hidden: yes
#     primary_key: yes
#     type: string
#     sql: concat(${country_raw},cast(${date_raw} as string)) ;;
#   }
#   dimension: country_raw {
#     hidden: yes
#   }
#   dimension_group: date {
#     type: time
#     timeframes: [
#       raw,
#       date
#     ]
#     hidden: yes
#     sql: cast(${TABLE}.date_raw as date) ;;
#   }
#   dimension: confirmed_running_total {
#     hidden: yes
#   }
#
#   parameter: number_of_cases {
#     type: number
#     default_value: "1"
#   }
#
#   dimension: is_number_of_cases_greater {
#     hidden: yes
#     type: yesno
#     sql: ${confirmed_running_total} > {% parameter number_of_cases %} ;;
#   }
#
#   measure: min_date {
#     hidden: yes
#     type: date
#     sql: min(${date_raw}) ;;
#   }
# }
#
#
# view: days_since_first_case_country {
#   derived_table: {
#     # datagroup_trigger: once_daily
#     explore_source: covid_data {
#       column: country_raw { field: cases_by_country_by_date.country_raw }
#       column: min_date { field: cases_by_country_by_date.min_date }
#       filters: {
#         field: cases_by_country_by_date.is_number_of_cases_greater
#         value: "Yes"
#       }
#     }
#   }
#   dimension: country_raw {
#     primary_key: yes
#     hidden: yes
#   }
#   dimension_group: min {
#     type: time
#     timeframes: [
#       raw,
#       date
#     ]
#     hidden: yes
#     sql: cast(${TABLE}.min_date as date) ;;
#   }
# }
#
# view: days_since_first_case_state {
#   derived_table: {
#     datagroup_trigger: jhu_data
#     explore_source: covid_data {
#       column: country {}
#       column: state {}
#       column: min_date {}
#       filters: {
#         field: covid_data.confirmed_new_cases
#         value: ">0"
#       }
#     }
#   }
#   dimension: pk {
#     primary_key: yes
#     sql: concat(${state},${country}) ;;
#   }
#   dimension: country {
#     hidden: yes
#   }
#   dimension: state {
#     hidden: yes
#   }
#   dimension_group: min {
#     type: time
#     timeframes: [
#       raw,
#       date
#     ]
#     hidden: yes
#     sql: cast(${TABLE}.min_date as date) ;;
#   }
# }


view: prior_days_cases {
  view_label: "Trends"
  derived_table: {
    datagroup_trigger: jhu_data
    explore_source: covid_data {
      column: date_date {}
      column: country_raw {}
      column: state {}
      column: confirmed_running_total {}
      derived_column: prior_1_days_cumulative_cases_raw {
        sql: coalesce (max (${confirmed_running_total}) OVER (PARTITION BY ${country_raw}, ${state} ORDER BY ${date_date} asc ROWS BETWEEN 2 PRECEDING and 1 PRECEDING),0) ;;
      }
      derived_column: prior_2_days_cumulative_cases_raw {
        sql: coalesce (max (${confirmed_running_total}) OVER (PARTITION BY ${country_raw}, ${state} ORDER BY ${date_date} asc ROWS BETWEEN 3 PRECEDING and 2 PRECEDING),0) ;;
      }
      derived_column: prior_3_days_cumulative_cases_raw {
        sql: coalesce (max (${confirmed_running_total}) OVER (PARTITION BY ${country_raw}, ${state} ORDER BY ${date_date} asc ROWS BETWEEN 4 PRECEDING and 3 PRECEDING),0) ;;
      }
      derived_column: prior_4_days_cumulative_cases_raw {
        sql: coalesce (max (${confirmed_running_total}) OVER (PARTITION BY ${country_raw}, ${state} ORDER BY ${date_date} asc ROWS BETWEEN 5 PRECEDING and 4 PRECEDING),0) ;;
      }
      derived_column: prior_5_days_cumulative_cases_raw {
        sql: coalesce (max (${confirmed_running_total}) OVER (PARTITION BY ${country_raw}, ${state} ORDER BY ${date_date} asc ROWS BETWEEN 6 PRECEDING and 5 PRECEDING),0) ;;
      }
      derived_column: prior_6_days_cumulative_cases_raw {
        sql: coalesce (max (${confirmed_running_total}) OVER (PARTITION BY ${country_raw}, ${state} ORDER BY ${date_date} asc ROWS BETWEEN 7 PRECEDING and 6 PRECEDING),0) ;;
      }
      derived_column: prior_7_days_cumulative_cases_raw {
        sql: coalesce (max (${confirmed_running_total}) OVER (PARTITION BY ${country_raw}, ${state} ORDER BY ${date_date} asc ROWS BETWEEN 8 PRECEDING and 7 PRECEDING),0) ;;
      }
    }
  }
  dimension: date_date {
    type: date
    hidden:yes
  }
  dimension: country_raw { hidden:yes}
  dimension: state {hidden:yes}
  dimension: prior_1_days_cumulative_cases_raw {type:number hidden:yes}
  dimension: prior_2_days_cumulative_cases_raw {type:number hidden:yes}
  dimension: prior_3_days_cumulative_cases_raw {type:number hidden:yes}
  dimension: prior_4_days_cumulative_cases_raw {type:number hidden:yes}
  dimension: prior_5_days_cumulative_cases_raw {type:number hidden:yes}
  dimension: prior_6_days_cumulative_cases_raw {type:number hidden:yes}
  dimension: prior_7_days_cumulative_cases_raw {type:number hidden:yes}
  #All of these metrics require having date selected, or filtered to a single date.
  measure: prior_1_days_cumulative_cases { group_label: "Past Days Totals" type:sum sql: ${prior_1_days_cumulative_cases_raw};;}
  measure: prior_2_days_cumulative_cases { group_label: "Past Days Totals" type:sum sql: ${prior_2_days_cumulative_cases_raw};;}
  measure: prior_3_days_cumulative_cases { group_label: "Past Days Totals" type:sum sql: ${prior_3_days_cumulative_cases_raw};;}
  measure: prior_4_days_cumulative_cases { group_label: "Past Days Totals" type:sum sql: ${prior_4_days_cumulative_cases_raw};;}
  measure: prior_5_days_cumulative_cases { group_label: "Past Days Totals" type:sum sql: ${prior_5_days_cumulative_cases_raw};;}
  measure: prior_6_days_cumulative_cases { group_label: "Past Days Totals" type:sum sql: ${prior_6_days_cumulative_cases_raw};;}
  measure: prior_7_days_cumulative_cases { group_label: "Past Days Totals" type:sum sql: ${prior_7_days_cumulative_cases_raw};;}

  measure: change_since_yesterday {
    type: number
    value_format_name: percent_0
    sql:  (${covid_data.confirmed_running_total} - ${prior_1_days_cumulative_cases}) / NULLIF(${prior_1_days_cumulative_cases},0);;
  }

  measure: doubling_time {
    type: number
    value_format_name: decimal_1
    sql:  70 / NULLIF(100*${seven_day_average_change_rate},0);;
    html: {{rendered_value}} Day(s) ;;
  }

  measure: seven_day_average_change_rate {
    type: number
    value_format_name: percent_0
    sql: ( ((${covid_data.confirmed_running_total} - ${prior_1_days_cumulative_cases}) / NULLIF(${prior_1_days_cumulative_cases},0))*7.0
    + ((${prior_1_days_cumulative_cases} - ${prior_2_days_cumulative_cases}) / NULLIF(${prior_2_days_cumulative_cases},0))*6.0
    + ((${prior_2_days_cumulative_cases} - ${prior_3_days_cumulative_cases}) / NULLIF(${prior_3_days_cumulative_cases},0))*5.0
    + ((${prior_3_days_cumulative_cases} - ${prior_4_days_cumulative_cases}) / NULLIF(${prior_4_days_cumulative_cases},0))*4.0
    + ((${prior_4_days_cumulative_cases} - ${prior_5_days_cumulative_cases}) / NULLIF(${prior_5_days_cumulative_cases},0))*3.0
    + ((${prior_5_days_cumulative_cases} - ${prior_6_days_cumulative_cases}) / NULLIF(${prior_6_days_cumulative_cases},0))*2.0
    + ((${prior_6_days_cumulative_cases} - ${prior_7_days_cumulative_cases}) / NULLIF(${prior_7_days_cumulative_cases},0)) )/28.0;;
  }

}
