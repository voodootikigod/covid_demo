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

view: max_date_tracking_project {
  derived_table: {
    datagroup_trigger: covid_data
    explore_source: jhu_sample_county_level_final {
      column: max_date { field: covid_tracking_project_sample_final.max_date }
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

view: prior_days_cases_covid {
  view_label: "Trends"
  derived_table: {
    datagroup_trigger: covid_data
    explore_source: jhu_sample_county_level_final {
      column: measurement_date {}
      column: combined_key {}
      column: confirmed_running_total {}
      column: deaths_running_total {}

      derived_column: prior_1_days_confirmed_running_total {sql: coalesce (max (${confirmed_running_total}) OVER (PARTITION BY ${combined_key} ORDER BY ${measurement_date} asc ROWS BETWEEN 2 PRECEDING and 1 PRECEDING),0) ;;}
      derived_column: prior_2_days_confirmed_running_total {sql: coalesce (max (${confirmed_running_total}) OVER (PARTITION BY ${combined_key} ORDER BY ${measurement_date} asc ROWS BETWEEN 3 PRECEDING and 2 PRECEDING),0) ;;}
      derived_column: prior_3_days_confirmed_running_total {sql: coalesce (max (${confirmed_running_total}) OVER (PARTITION BY ${combined_key} ORDER BY ${measurement_date} asc ROWS BETWEEN 4 PRECEDING and 3 PRECEDING),0) ;;}
      derived_column: prior_4_days_confirmed_running_total {sql: coalesce (max (${confirmed_running_total}) OVER (PARTITION BY ${combined_key} ORDER BY ${measurement_date} asc ROWS BETWEEN 5 PRECEDING and 4 PRECEDING),0) ;;}
      derived_column: prior_5_days_confirmed_running_total {sql: coalesce (max (${confirmed_running_total}) OVER (PARTITION BY ${combined_key} ORDER BY ${measurement_date} asc ROWS BETWEEN 6 PRECEDING and 5 PRECEDING),0) ;;}
      derived_column: prior_6_days_confirmed_running_total {sql: coalesce (max (${confirmed_running_total}) OVER (PARTITION BY ${combined_key} ORDER BY ${measurement_date} asc ROWS BETWEEN 7 PRECEDING and 6 PRECEDING),0) ;;}
      derived_column: prior_7_days_confirmed_running_total {sql: coalesce (max (${confirmed_running_total}) OVER (PARTITION BY ${combined_key} ORDER BY ${measurement_date} asc ROWS BETWEEN 8 PRECEDING and 7 PRECEDING),0) ;;}

      derived_column: prior_1_days_deaths_running_total {sql: coalesce (max (${deaths_running_total}) OVER (PARTITION BY ${combined_key} ORDER BY ${measurement_date} asc ROWS BETWEEN 2 PRECEDING and 1 PRECEDING),0) ;;}
      derived_column: prior_2_days_deaths_running_total {sql: coalesce (max (${deaths_running_total}) OVER (PARTITION BY ${combined_key} ORDER BY ${measurement_date} asc ROWS BETWEEN 3 PRECEDING and 2 PRECEDING),0) ;;}
      derived_column: prior_3_days_deaths_running_total {sql: coalesce (max (${deaths_running_total}) OVER (PARTITION BY ${combined_key} ORDER BY ${measurement_date} asc ROWS BETWEEN 4 PRECEDING and 3 PRECEDING),0) ;;}
      derived_column: prior_4_days_deaths_running_total {sql: coalesce (max (${deaths_running_total}) OVER (PARTITION BY ${combined_key} ORDER BY ${measurement_date} asc ROWS BETWEEN 5 PRECEDING and 4 PRECEDING),0) ;;}
      derived_column: prior_5_days_deaths_running_total {sql: coalesce (max (${deaths_running_total}) OVER (PARTITION BY ${combined_key} ORDER BY ${measurement_date} asc ROWS BETWEEN 6 PRECEDING and 5 PRECEDING),0) ;;}
      derived_column: prior_6_days_deaths_running_total {sql: coalesce (max (${deaths_running_total}) OVER (PARTITION BY ${combined_key} ORDER BY ${measurement_date} asc ROWS BETWEEN 7 PRECEDING and 6 PRECEDING),0) ;;}
      derived_column: prior_7_days_deaths_running_total {sql: coalesce (max (${deaths_running_total}) OVER (PARTITION BY ${combined_key} ORDER BY ${measurement_date} asc ROWS BETWEEN 8 PRECEDING and 7 PRECEDING),0) ;;}
    }
  }

  dimension: pk {
    primary_key: yes
    hidden: yes
    type: string
    sql: concat(${combined_key},${measurement_date}) ;;
  }

  dimension: measurement_date {
    type: date
    hidden:yes
  }
  dimension: combined_key { hidden:yes}

  dimension: prior_1_days_confirmed_running_total {type:number hidden:yes}
  dimension: prior_2_days_confirmed_running_total {type:number hidden:yes}
  dimension: prior_3_days_confirmed_running_total {type:number hidden:yes}
  dimension: prior_4_days_confirmed_running_total {type:number hidden:yes}
  dimension: prior_5_days_confirmed_running_total {type:number hidden:yes}
  dimension: prior_6_days_confirmed_running_total {type:number hidden:yes}
  dimension: prior_7_days_confirmed_running_total {type:number hidden:yes}

  dimension: prior_1_days_deaths_running_total {type:number hidden:yes}
  dimension: prior_2_days_deaths_running_total {type:number hidden:yes}
  dimension: prior_3_days_deaths_running_total {type:number hidden:yes}
  dimension: prior_4_days_deaths_running_total {type:number hidden:yes}
  dimension: prior_5_days_deaths_running_total {type:number hidden:yes}
  dimension: prior_6_days_deaths_running_total {type:number hidden:yes}
  dimension: prior_7_days_deaths_running_total {type:number hidden:yes}

  #All of these metrics require having date selected, or filtered to a single date.
  measure: sum_prior_1_days_confirmed_running_total { group_label: "Past Days Totals" type:sum sql: ${prior_1_days_confirmed_running_total};;}
  measure: sum_prior_2_days_confirmed_running_total { group_label: "Past Days Totals" type:sum sql: ${prior_2_days_confirmed_running_total};;}
  measure: sum_prior_3_days_confirmed_running_total { group_label: "Past Days Totals" type:sum sql: ${prior_3_days_confirmed_running_total};;}
  measure: sum_prior_4_days_confirmed_running_total { group_label: "Past Days Totals" type:sum sql: ${prior_4_days_confirmed_running_total};;}
  measure: sum_prior_5_days_confirmed_running_total { group_label: "Past Days Totals" type:sum sql: ${prior_5_days_confirmed_running_total};;}
  measure: sum_prior_6_days_confirmed_running_total { group_label: "Past Days Totals" type:sum sql: ${prior_6_days_confirmed_running_total};;}
  measure: sum_prior_7_days_confirmed_running_total { group_label: "Past Days Totals" type:sum sql: ${prior_7_days_confirmed_running_total};;}

  measure: sum_prior_1_days_deaths_running_total { group_label: "Past Days Totals" type:sum sql: ${prior_1_days_deaths_running_total};;}
  measure: sum_prior_2_days_deaths_running_total { group_label: "Past Days Totals" type:sum sql: ${prior_2_days_deaths_running_total};;}
  measure: sum_prior_3_days_deaths_running_total { group_label: "Past Days Totals" type:sum sql: ${prior_3_days_deaths_running_total};;}
  measure: sum_prior_4_days_deaths_running_total { group_label: "Past Days Totals" type:sum sql: ${prior_4_days_deaths_running_total};;}
  measure: sum_prior_5_days_deaths_running_total { group_label: "Past Days Totals" type:sum sql: ${prior_5_days_deaths_running_total};;}
  measure: sum_prior_6_days_deaths_running_total { group_label: "Past Days Totals" type:sum sql: ${prior_6_days_deaths_running_total};;}
  measure: sum_prior_7_days_deaths_running_total { group_label: "Past Days Totals" type:sum sql: ${prior_7_days_deaths_running_total};;}

  measure: seven_day_average_change_rate_confirmed_cases {
    group_label: "Advanced Analytics"
    type: number
    value_format_name: percent_0
    sql: (
            ((${jhu_sample_county_level_final.confirmed_running_total} - ${sum_prior_1_days_confirmed_running_total}) / NULLIF(${sum_prior_1_days_confirmed_running_total},0))*7.0
          + ((${sum_prior_1_days_confirmed_running_total}                 - ${sum_prior_2_days_confirmed_running_total}) / NULLIF(${sum_prior_2_days_confirmed_running_total},0))*6.0
          + ((${sum_prior_2_days_confirmed_running_total}                 - ${sum_prior_3_days_confirmed_running_total}) / NULLIF(${sum_prior_3_days_confirmed_running_total},0))*5.0
          + ((${sum_prior_3_days_confirmed_running_total}                 - ${sum_prior_4_days_confirmed_running_total}) / NULLIF(${sum_prior_4_days_confirmed_running_total},0))*4.0
          + ((${sum_prior_4_days_confirmed_running_total}                 - ${sum_prior_5_days_confirmed_running_total}) / NULLIF(${sum_prior_5_days_confirmed_running_total},0))*3.0
          + ((${sum_prior_5_days_confirmed_running_total}                 - ${sum_prior_6_days_confirmed_running_total}) / NULLIF(${sum_prior_6_days_confirmed_running_total},0))*2.0
          + ((${sum_prior_6_days_confirmed_running_total}                 - ${sum_prior_7_days_confirmed_running_total}) / NULLIF(${sum_prior_7_days_confirmed_running_total},0)) )/28.0;;
  }

  measure: seven_day_average_change_rate_deaths {
    group_label: "Advanced Analytics"
    type: number
    value_format_name: percent_0
    sql: (
            ((${jhu_sample_county_level_final.deaths_running_total}   - ${sum_prior_1_days_deaths_running_total}) / NULLIF(${sum_prior_1_days_deaths_running_total},0))*7.0
          + ((${sum_prior_1_days_deaths_running_total}                - ${sum_prior_2_days_deaths_running_total}) / NULLIF(${sum_prior_2_days_deaths_running_total},0))*6.0
          + ((${sum_prior_2_days_deaths_running_total}                - ${sum_prior_3_days_deaths_running_total}) / NULLIF(${sum_prior_3_days_deaths_running_total},0))*5.0
          + ((${sum_prior_3_days_deaths_running_total}                - ${sum_prior_4_days_deaths_running_total}) / NULLIF(${sum_prior_4_days_deaths_running_total},0))*4.0
          + ((${sum_prior_4_days_deaths_running_total}                - ${sum_prior_5_days_deaths_running_total}) / NULLIF(${sum_prior_5_days_deaths_running_total},0))*3.0
          + ((${sum_prior_5_days_deaths_running_total}                - ${sum_prior_6_days_deaths_running_total}) / NULLIF(${sum_prior_6_days_deaths_running_total},0))*2.0
          + ((${sum_prior_6_days_deaths_running_total}                - ${sum_prior_7_days_deaths_running_total}) / NULLIF(${sum_prior_7_days_deaths_running_total},0)) )/28.0;;
  }

  measure: doubling_time_confirmed_cases {
    group_label: "Advanced Analytics"
    description: "Days for Confirmed Cases to Double"
    type: number
    value_format_name: decimal_1
    sql:  70 / NULLIF(100*${seven_day_average_change_rate_confirmed_cases},0);;
    html: {{rendered_value}} Day(s) ;;
  }

  measure: doubling_time_deaths {
    group_label: "Advanced Analytics"
    description: "Days for Confirmed Cases to Double"
    type: number
    value_format_name: decimal_1
    sql:  70 / NULLIF(100*${seven_day_average_change_rate_deaths},0);;
    html: {{rendered_value}} Day(s) ;;
  }

}

#   measure: change_since_yesterday {
#     hidden: yes
#     type: number
#     value_format_name: percent_0
#     sql:  (${covid_data.confirmed_running_total} - ${prior_1_days_cumulative_cases}) / NULLIF(${prior_1_days_cumulative_cases},0);;
#   }
