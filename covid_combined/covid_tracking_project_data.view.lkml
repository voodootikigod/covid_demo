# explore: covid_tracking_project_sample_final {}
view: covid_tracking_project_sample_final {
  # sql_table_name: `lookerdata.covid19.covid_tracking_project_sample_final` ;;
  derived_table: {
    datagroup_trigger: covid_data
    sql:
      SELECT
        a.state,
        date as measurement_date,

        total as total_cumulative,
        total - coalesce(LAG(total, 1) OVER (PARTITION BY a.state  ORDER BY date ASC),0) as total_new_cases,

        death as death_cumulative,
        death - coalesce(LAG(death, 1) OVER (PARTITION BY a.state  ORDER BY date ASC),0) as death_new_cases,

        recovered as recovered_cumulative,
        recovered - coalesce(LAG(recovered, 1) OVER (PARTITION BY a.state  ORDER BY date ASC),0) as recovered_new_cases,

        hospitalizedCumulative as hospitalized_cumulative,
        hospitalizedCumulative - coalesce(LAG(hospitalizedCumulative, 1) OVER (PARTITION BY a.state  ORDER BY date ASC),0) as hospitalized_new_cases,
        hospitalizedCurrently,

        inIcuCumulative as inIcu_Cumulative,
        inIcuCumulative - coalesce(LAG(inIcuCumulative, 1) OVER (PARTITION BY a.state  ORDER BY date ASC),0) as inIcu_new_cases,
        inIcuCurrently,

        onVentilatorCumulative as onVentilator_Cumulative,
        onVentilatorCumulative - coalesce(LAG(onVentilatorCumulative, 1) OVER (PARTITION BY a.state  ORDER BY date ASC),0) as onVentilator_new_cases,
        onVentilatorCurrently,

        positive as positive_cumulative,
        positive - coalesce(LAG(positive, 1) OVER (PARTITION BY a.state  ORDER BY date ASC),0) as positive_new_cases,

        pending as pending_cumulative,
        pending - coalesce(LAG(pending, 1) OVER (PARTITION BY a.state  ORDER BY date ASC),0) as pending_new_cases,

        negative as negative_cumulative,
        negative - coalesce(LAG(negative, 1) OVER (PARTITION BY a.state  ORDER BY date ASC),0) as negative_new_cases,

      FROM
      (
        SELECT
          b.state
        , a.fips
        , a.date
        , a.positive
        , a.negative
        , a.pending
        , a.hospitalizedCurrently
        , a.hospitalizedCumulative
        , a.inIcuCurrently
        , a.inIcuCumulative
        , a.onVentilatorCurrently
        , a.onVentilatorCumulative
        , a.recovered
        , a.death
        , a.hospitalized
        , a.total
        , a.totalTestResults
        , a.posNeg
      FROM `lookerdata.covid19.covidtrackingproject_attempt2` a
      LEFT JOIN `lookerdata.covid19.state_region` b
              ON a.state = b.state_code
      ) a
    ;;
  }

####################
#### Original Dimensions ####
####################

### PK

  dimension: pk {
    primary_key: yes
    hidden: yes
    sql: concat(${state}, ${measurement_raw}) ;;
  }

## Date & Location

  dimension: state {
    hidden: yes
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

  dimension_group: measurement {
    hidden: yes
    type: time
    timeframes: [
      raw,
      date
    ]
#       week,
#       month,
#       quarter,
#       year
    convert_tz: no
    datatype: date
    sql: ${TABLE}.measurement_date ;;
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
    hidden: yes
    type: yesno
    sql: ${measurement_raw} = ${max_date_tracking_project.max_date_raw} ;;
  }

####################
#### Measures ####
####################

  measure: hospitalizations {
    group_label: "Dynamic (Testing - US Only)"
    label: "Hospitalizations"
    type: number
    sql:
        {% if jhu_sample_county_level_final.new_vs_running_total._parameter_value == 'new_cases' %} ${hospitalized_new}
        {% elsif jhu_sample_county_level_final.new_vs_running_total._parameter_value == 'running_total' %} ${hospitalized_running_total}
        {% endif %} ;;
    drill_fields: [drill*]
  }

  measure: negative_test {
    group_label: "Dynamic (Testing - US Only)"
    label: "Negative Test Results"
    type: number
    sql:
        {% if jhu_sample_county_level_final.new_vs_running_total._parameter_value == 'new_cases' %} ${negative_new}
        {% elsif jhu_sample_county_level_final.new_vs_running_total._parameter_value == 'running_total' %} ${negative_running_total}
        {% endif %} ;;
    drill_fields: [drill*]
  }

  measure: pending_test {
    group_label: "Dynamic (Testing - US Only)"
    label: "Pending Test Results"
    type: number
    sql:
        {% if jhu_sample_county_level_final.new_vs_running_total._parameter_value == 'new_cases' %} ${pending_new}
        {% elsif jhu_sample_county_level_final.new_vs_running_total._parameter_value == 'running_total' %} ${pending_running_total}
        {% endif %} ;;
    drill_fields: [drill*]
  }

  measure: positive_test {
    group_label: "Dynamic (Testing - US Only)"
    label: "Positive Test Results"
    type: number
    sql:
        {% if jhu_sample_county_level_final.new_vs_running_total._parameter_value == 'new_cases' %} ${positive_new}
        {% elsif jhu_sample_county_level_final.new_vs_running_total._parameter_value == 'running_total' %} ${positive_running_total}
        {% endif %} ;;
    drill_fields: [drill*]
  }

  measure: total {
    group_label: "Dynamic (Testing - US Only)"
    label: "Total Tests"
    type: number
    sql:
        {% if jhu_sample_county_level_final.new_vs_running_total._parameter_value == 'new_cases' %} ${total_new}
        {% elsif jhu_sample_county_level_final.new_vs_running_total._parameter_value == 'running_total' %} ${total_running_total}
        {% endif %} ;;
    drill_fields: [drill*]
  }

#   measure: total_tests_per_capita {
#     group_label: "Dynamic (Testing - US Only)"
#     description: "Tests Per 1K People"
#     type: number
#     sql: 1000*${total} / nullif(${acs_puma_state_facts.population},0) ;;
#     value_format_name: decimal_3
#     drill_fields: [drill*, total_tests_per_capita]
#   }

  measure: hospitalized_new {
    group_label: "New Cases (Testing - US Only)"
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
    group_label: "Running Total (Testing - US Only)"
    label: "Hospitalizations (Running Total)"
    type: number
    sql:
    {% if covid_tracking_project_sample_final.measurement_date._in_query %} ${hospitalized_option_1}
    {% else %}  ${hospitalized_option_2}
    {% endif %} ;;
  }

  measure: negative_new {
    group_label: "New Cases (Testing - US Only)"
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
    group_label: "Running Total (Testing - US Only)"
    label: "Negative Test Results (Running Total)"
    type: number
    sql:
    {% if covid_tracking_project_sample_final.measurement_date._in_query %} ${negative_option_1}
    {% else %}  ${negative_option_2}
    {% endif %} ;;
  }

  measure: pending_new {
    group_label: "New Cases (Testing - US Only)"
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
    group_label: "Running Total (Testing - US Only)"
    label: "Pending Test Results (Running Total)"
    type: number
    sql:
    {% if covid_tracking_project_sample_final.measurement_date._in_query %} ${pending_option_1}
    {% else %}  ${pending_option_2}
    {% endif %} ;;
  }

  measure: positive_new {
    group_label: "New Cases (Testing - US Only)"
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
    group_label: "Running Total (Testing - US Only)"
    label: "Positive Test Results (Running Total)"
    type: number
    sql:
    {% if covid_tracking_project_sample_final.measurement_date._in_query %} ${positive_option_1}
    {% else %}  ${positive_option_2}
    {% endif %} ;;
  }

  measure: total_new {
    group_label: "New Cases (Testing - US Only)"
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
    group_label: "Running Total (Testing - US Only)"
    label: "Total Tests (Running Total)"
    type: number
    sql:
    {% if covid_tracking_project_sample_final.measurement_date._in_query %} ${total_option_1}
    {% else %}  ${total_option_2}
    {% endif %} ;;
  }

  measure: positive_rate {
    group_label: "Rates (Testing - US Only)"
    description: "Of all tests, how many are positive?"
    type: number
    sql: 1.0 * ${positive_running_total} / nullif((${total_running_total}),0);;
    value_format_name: percent_1
  }

  measure: pending_rate {
    group_label: "Rates (Testing - US Only)"
    description: "Of all tests, how many are pending?"
    type: number
    sql: 1.0 * ${pending_running_total} / nullif((${total_running_total}),0);;
    value_format_name: percent_1
  }

  measure: negative_rate {
    group_label: "Rates (Testing - US Only)"
    description: "Of all tests, how many are negative?"
    type: number
    sql: 1.0 * ${negative_running_total} / nullif((${total_running_total}),0);;
    value_format_name: percent_1
  }

  measure: case_hospitalization_rate {
    group_label: "Rates (Testing - US Only)"
    description: "What percent of infections have resulted in hospitalization?"
    type: number
    sql: 1.0 * ${hospitalized_running_total}/NULLIF(${positive_running_total}, 0);;
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
    sql: max(${measurement_raw}) ;;
  }

#### REDUNDANT FROM JHU DATA

  measure: deaths {
    hidden: yes
    group_label: "Dynamic (Testing - US Only)"
    label: "Deaths"
    type: number
    sql:
        {% if jhu_sample_county_level_final.new_vs_running_total._parameter_value == 'new_cases' %} ${death_new}
        {% elsif jhu_sample_county_level_final.new_vs_running_total._parameter_value == 'running_total' %} ${death_running_total}
        {% endif %} ;;
    drill_fields: [drill*]
  }

  measure: death_new {
    hidden: yes
    group_label: "New Cases (Testing - US Only)"
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
    hidden: yes
    group_label: "Running Total (Testing - US Only)"
    label: "Deaths (Running Total)"
    type: number
    sql:
    {% if covid_tracking_project_sample_final.measurement_date._in_query %} ${death_option_1}
    {% else %}  ${death_option_2}
    {% endif %} ;;
  }

  measure: case_fatality_rate {
    hidden: yes
    group_label: "Rates (Testing - US Only)"
    description: "What percent of infections have resulted in death?"
    type: number
    sql: 1.0 * ${death_running_total}/NULLIF(${positive_running_total}, 0);;
    value_format_name: percent_1
  }

  measure: case_fatality_or_hospitalization_rate {
    hidden: yes
    group_label: "Rates (Testing - US Only)"
    description: "What percent of infections have resulted in hospitalization or death?"
    type: number
    sql: 1.0 * (${death_running_total} + ${hospitalized_running_total}) /NULLIF(${positive_running_total}, 0);;
    value_format_name: percent_1
  }

  set: drill {
    fields: [
      state,
      measurement_date,
      total,
      positive_test,
      pending_test,
      negative_test,
      deaths,
      hospitalizations
    ]
  }
}
