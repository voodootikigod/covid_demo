view: tests_by_state {
  derived_table: {
    datagroup_trigger: once_daily
    sql:
    SELECT
      a.state,
      b.region,
      date,
      total as total_cumulative,
      total - coalesce(LAG(total, 1) OVER (PARTITION BY a.state  ORDER BY date ASC),0) as total_new_cases,
      death as death_cumulative,
      death - coalesce(LAG(death, 1) OVER (PARTITION BY a.state  ORDER BY date ASC),0) as death_new_cases,
      hospitalized as hospitalized_cumulative,
      hospitalized - coalesce(LAG(hospitalized, 1) OVER (PARTITION BY a.state  ORDER BY date ASC),0) as hospitalized_new_cases,
      positive as positive_cumulative,
      positive - coalesce(LAG(positive, 1) OVER (PARTITION BY a.state  ORDER BY date ASC),0) as positive_new_cases,
      pending as pending_cumulative,
      pending - coalesce(LAG(pending, 1) OVER (PARTITION BY a.state  ORDER BY date ASC),0) as pending_new_cases,
      negative as negative_cumulative,
      negative - coalesce(LAG(negative, 1) OVER (PARTITION BY a.state  ORDER BY date ASC),0) as negative_new_cases,
    FROM `lookerdata.covid19.tests_by_state` a
     LEFT JOIN `lookerdata.covid19.state_region` b
      ON a.state = b.state_code ;;
  }
  # sql_table_name: `covid-271711.covid19.tests_by_state` ;;

####################
#### Original Dimensions ####
####################

### PK

  dimension: pk {
    primary_key: yes
    hidden: yes
    sql: concat(${state}, ${date_raw}) ;;
  }

## Date & Location

  dimension: state {
    map_layer_name: us_states
    type: string
    sql: ${TABLE}.state ;;
    link: {
      label: "{{ value }} Drill Down"
      url: "/dashboards-next/4?State={{ value }}"
      icon_url: "https://looker.com/favicon.ico"
    }
    link: {
      label: "See original data"
      url: "https://covidtracking.com/us-daily/"
      icon_url: "https://looker.com/favicon.ico"
    }
  }

  dimension: region {
    type: string
    sql: ${TABLE}.region ;;
    drill_fields: [state]
    link: {
      label: "See original data"
      url: "https://covidtracking.com/us-daily/"
      icon_url: "https://looker.com/favicon.ico"
    }
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
    drill_fields: [region, state]
  }

### KPIs

  dimension: death_cumulative {
    hidden: yes
    type: number
    sql: ${TABLE}.death_cumulative ;;
  }

  dimension: death_new_cases {
    hidden: yes
    type: number
    sql: ${TABLE}.death_new_cases ;;
  }

  dimension: hospitalized_cumulative {
    hidden: yes
    type: number
    sql: ${TABLE}.hospitalized_cumulative ;;
  }

  dimension: hospitalized_new_cases {
    hidden: yes
    type: number
    sql: ${TABLE}.hospitalized_new_cases ;;
  }

  dimension: negative_cumulative {
    hidden: yes
    type: number
    sql: ${TABLE}.negative_cumulative ;;
  }

  dimension: negative_new_cases {
    hidden: yes
    type: number
    sql: ${TABLE}.negative_new_cases ;;
  }

  dimension: pending_cumulative {
    hidden: yes
    type: number
    sql: ${TABLE}.pending_cumulative ;;
  }

  dimension: pending_new_cases {
    hidden: yes
    type: number
    sql: ${TABLE}.pending_new_cases ;;
  }

  dimension: positive_cumulative {
    hidden: yes
    type: number
    sql: ${TABLE}.positive_cumulative ;;
  }

  dimension: positive_new_cases {
    hidden: yes
    type: number
    sql: ${TABLE}.positive_new_cases ;;
  }

  dimension: total_cumulative {
    hidden: yes
    type: number
    sql: ${TABLE}.total_cumulative ;;
  }

  dimension: total_new_cases {
    hidden: yes
    type: number
    sql: ${TABLE}.total_new_cases ;;
  }

####################
#### Derived Dimensions ####
####################

  dimension: total_tests_cumulative {
    hidden: yes
    type: number
    sql: ${positive_cumulative} + ${pending_cumulative} + ${negative_cumulative} ;;
  }

  dimension: total_tests_new_cases {
    hidden: yes
    type: number
    sql: ${positive_new_cases} + ${pending_new_cases} + ${negative_new_cases} ;;
  }

  dimension: is_max_date {
    type: yesno
    sql: ${date_raw} = ${max_date_us.max_date_raw} ;;
  }

####################
#### Measures ####
####################

  parameter: new_vs_running_total {
    type: unquoted
    default_value: "new_cases"
    allowed_value: {
      label: "New Cases"
      value: "new_cases"
    }
    allowed_value: {
      label: "Running Total"
      value: "running_total"
    }
  }

  measure: deaths {
    group_label: "Dynamic"
    label: "Deaths"
    type: number
    sql:
        {% if new_vs_running_total._parameter_value == 'new_cases' %} ${death_new}
        {% elsif new_vs_running_total._parameter_value == 'running_total' %} ${death_running_total}
        {% endif %} ;;
    drill_fields: [drill*]
  }

  measure: hospitalizations {
    group_label: "Dynamic"
    label: "Hospitalizations"
    type: number
    sql:
        {% if new_vs_running_total._parameter_value == 'new_cases' %} ${hospitalized_new}
        {% elsif new_vs_running_total._parameter_value == 'running_total' %} ${hospitalized_running_total}
        {% endif %} ;;
    drill_fields: [drill*]
  }

  measure: negative_test {
    group_label: "Dynamic"
    label: "Negative Test Results"
    type: number
    sql:
        {% if new_vs_running_total._parameter_value == 'new_cases' %} ${negative_new}
        {% elsif new_vs_running_total._parameter_value == 'running_total' %} ${negative_running_total}
        {% endif %} ;;
    drill_fields: [drill*]
  }

  measure: pending_test {
    group_label: "Dynamic"
    label: "Pending Test Results"
    type: number
    sql:
        {% if new_vs_running_total._parameter_value == 'new_cases' %} ${pending_new}
        {% elsif new_vs_running_total._parameter_value == 'running_total' %} ${pending_running_total}
        {% endif %} ;;
    drill_fields: [drill*]
  }

  measure: positive_test {
    group_label: "Dynamic"
    label: "Positive Test Results"
    type: number
    sql:
        {% if new_vs_running_total._parameter_value == 'new_cases' %} ${positive_new}
        {% elsif new_vs_running_total._parameter_value == 'running_total' %} ${positive_running_total}
        {% endif %} ;;
    drill_fields: [drill*]
  }

  measure: total {
    group_label: "Dynamic"
    label: "Total Tests"
    type: number
    sql:
        {% if new_vs_running_total._parameter_value == 'new_cases' %} ${total_new}
        {% elsif new_vs_running_total._parameter_value == 'running_total' %} ${total_running_total}
        {% endif %} ;;
    drill_fields: [drill*]
  }

  measure: total_tests_per_capita {
    group_label: "Dynamic"
    description: "Tests Per 1K People"
    type: number
    sql: 1000*${total} / nullif(${acs_puma_state_facts.population},0) ;;
    value_format_name: decimal_3
    drill_fields: [drill*, total_tests_per_capita]
  }

#   measure: total_tests {
#     group_label: "Dynamic"
#     label: "Total Tests"
#     type: number
#     sql:
#         {% if new_vs_running_total._parameter_value == 'new_cases' %} ${total_tests_new}
#         {% elsif new_vs_running_total._parameter_value == 'running_total' %} ${total_tests_running_total}
#         {% endif %} ;;
#     drill_fields: [drill*]
#   }

  measure: death_new {
    group_label: "New Cases"
    label: "Deaths (New)"
    type: sum
    sql: ${death_new_cases} ;;
  }

  measure: death_option_1 {
    hidden: yes
    type: sum
    sql: ${death_cumulative} ;;
  }

  measure: death_option_2 {
    hidden: yes
    type: sum
    sql: ${death_cumulative} ;;
    filters: {
      field: is_max_date
      value: "Yes"
    }
  }

  measure: death_running_total {
    group_label: "Running Total"
    label: "Deaths (Running Total)"
    type: number
    sql:
    {% if tests_by_state.date_date._in_query %} ${death_option_1}
    {% else %}  ${death_option_2}
    {% endif %} ;;
  }

  measure: hospitalized_new {
    group_label: "New Cases"
    label: "Hospitalizations (New)"
    type: sum
    sql: ${hospitalized_new_cases} ;;
  }

  measure: hospitalized_option_1 {
    hidden: yes
    type: sum
    sql: ${hospitalized_cumulative} ;;
  }

  measure: hospitalized_option_2 {
    hidden: yes
    type: sum
    sql: ${hospitalized_cumulative} ;;
    filters: {
      field: is_max_date
      value: "Yes"
    }
  }

  measure: hospitalized_running_total {
    group_label: "Running Total"
    label: "Hospitalizations (Running Total)"
    type: number
    sql:
    {% if tests_by_state.date_date._in_query %} ${hospitalized_option_1}
    {% else %}  ${hospitalized_option_2}
    {% endif %} ;;
  }

  measure: negative_new {
    group_label: "New Cases"
    label: "Negative Test Results (New)"
    type: sum
    sql: ${negative_new_cases} ;;
  }

  measure: negative_option_1 {
    hidden: yes
    type: sum
    sql: ${negative_cumulative} ;;
  }

  measure: negative_option_2 {
    hidden: yes
    type: sum
    sql: ${negative_cumulative} ;;
    filters: {
      field: is_max_date
      value: "Yes"
    }
  }

  measure: negative_running_total {
    group_label: "Running Total"
    label: "Negative Test Results (Running Total)"
    type: number
    sql:
    {% if tests_by_state.date_date._in_query %} ${negative_option_1}
    {% else %}  ${negative_option_2}
    {% endif %} ;;
  }

  measure: pending_new {
    group_label: "New Cases"
    label: "Pending Test Results (New)"
    type: sum
    sql: ${pending_new_cases} ;;
  }

  measure: pending_option_1 {
    hidden: yes
    type: sum
    sql: ${pending_cumulative} ;;
  }

  measure: pending_option_2 {
    hidden: yes
    type: sum
    sql: ${pending_cumulative} ;;
    filters: {
      field: is_max_date
      value: "Yes"
    }
  }

  measure: pending_running_total {
    group_label: "Running Total"
    label: "Pending Test Results (Running Total)"
    type: number
    sql:
    {% if tests_by_state.date_date._in_query %} ${pending_option_1}
    {% else %}  ${pending_option_2}
    {% endif %} ;;
  }

  measure: positive_new {
    group_label: "New Cases"
    label: "Positive Test Results (New)"
    type: sum
    sql: ${positive_new_cases} ;;
  }

  measure: positive_option_1 {
    hidden: yes
    type: sum
    sql: ${positive_cumulative} ;;
  }

  measure: positive_option_2 {
    hidden: yes
    type: sum
    sql: ${positive_cumulative} ;;
    filters: {
      field: is_max_date
      value: "Yes"
    }
  }

  measure: positive_running_total {
    group_label: "Running Total"
    label: "Positive Test Results (Running Total)"
    type: number
    sql:
    {% if tests_by_state.date_date._in_query %} ${positive_option_1}
    {% else %}  ${positive_option_2}
    {% endif %} ;;
  }

  measure: total_new {
    group_label: "New Cases"
    label: "Total Tests (New)"
    type: sum
    sql: ${total_new_cases} ;;
  }

  measure: total_option_1 {
    hidden: yes
    type: sum
    sql: ${total_cumulative} ;;
  }

  measure: total_option_2 {
    hidden: yes
    type: sum
    sql: ${total_cumulative} ;;
    filters: {
      field: is_max_date
      value: "Yes"
    }
  }

  measure: total_running_total {
    group_label: "Running Total"
    label: "Total Tests (Running Total)"
    type: number
    sql:
    {% if tests_by_state.date_date._in_query %} ${total_option_1}
    {% else %}  ${total_option_2}
    {% endif %} ;;
  }

  measure: positive_rate {
    group_label: "Rates"
    description: "Of all tests, how many are positive?"
    type: number
    sql: 1.0 * ${positive_running_total} / nullif((${total_running_total}),0);;
    value_format_name: percent_1
  }

  measure: pending_rate {
    group_label: "Rates"
    description: "Of all tests, how many are pending?"
    type: number
    sql: 1.0 * ${pending_running_total} / nullif((${total_running_total}),0);;
    value_format_name: percent_1
  }

  measure: negative_rate {
    group_label: "Rates"
    description: "Of all tests, how many are negative?"
    type: number
    sql: 1.0 * ${negative_running_total} / nullif((${total_running_total}),0);;
    value_format_name: percent_1
  }

  measure: case_fatality_rate {
    group_label: "Rates"
    description: "What percent of infections have resulted in death?"
    type: number
    sql: 1.0 * ${death_running_total}/NULLIF(${positive_running_total}, 0);;
    value_format_name: percent_1
  }

  measure: case_hospitalization_rate {
    group_label: "Rates"
    description: "What percent of infections have resulted in hospitalization?"
    type: number
    sql: 1.0 * ${hospitalized_running_total}/NULLIF(${positive_running_total}, 0);;
    value_format_name: percent_1
  }

  measure: case_fatality_or_hospitalization_rate {
    group_label: "Rates"
    description: "What percent of infections have resulted in hospitalization or death?"
    type: number
    sql: 1.0 * (${death_running_total} + ${hospitalized_running_total}) /NULLIF(${positive_running_total}, 0);;
    value_format_name: percent_1
  }

  measure: count {
    hidden: yes
    type: count
    drill_fields: []
  }

  measure: max_date {
    hidden: yes
    type: date
    sql: max(${date_raw}) ;;
  }

  set: drill {
    fields: [
      state,
      date_raw,
      total,
      positive_test,
      pending_test,
      negative_test,
      deaths,
      hospitalizations
    ]
  }

  #   dimension_group: date_checked {
#     hidden: yes
#     type: time
#     timeframes: [
#       raw,
#       date
#     ]
#     sql: ${TABLE}.dateChecked ;;
#   }

}
