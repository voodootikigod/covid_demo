### Data Source: https://raw.githubusercontent.com/datasets/covid-19/master/time-series-19-covid-combined.csv

view: covid_data {
  derived_table: {
    datagroup_trigger: once_daily
    sql:

    SELECT
      a.province_state as State,
      a.country_region as Country,
      cast(Date as date) as Date,
      latitude as Lat,
      longitude as Long,
      b.region as region_state,
      c.region as region_country,
      Confirmed as confirmed_cumulative,
      Confirmed - coalesce(LAG(Confirmed, 1) OVER (PARTITION BY coalesce(a.province_state,''), a.country_region  ORDER BY Date ASC),0) as confirmed_new_cases,

      Recovered as recovered_cumulative,
      Recovered - coalesce(LAG(Recovered, 1) OVER (PARTITION BY coalesce(a.province_state,''), a.country_region  ORDER BY Date ASC),0) as recovered_new_cases,

      Deaths as deaths_cumulative,
      Deaths - coalesce(LAG(Deaths, 1) OVER (PARTITION BY coalesce(a.province_state,''), a.country_region  ORDER BY Date ASC),0) as deaths_new_cases,

    FROM `bigquery-public-data.covid19_jhu_csse.summary` a
    LEFT JOIN `lookerdata.covid19.state_region` b
      ON a.province_state = b.state
    LEFT JOIN `lookerdata.covid19.country_region` c
      ON a.country_region = c.country
    WHERE a.province_state IS NULL OR a.province_state NOT LIKE '%,%'

    ;;
  }

  # sql_table_name: `covid-271711.covid19.covid_data` ;;

####################
#### Original Dimensions ####
####################

  dimension: pk {
    primary_key: yes
    sql: concat(${state}, ${country}, ${date_raw}) ;;
  }

#### Location ####

  dimension: country_raw {
    hidden: yes
    type: string
    sql: ${TABLE}.Country ;;
  }

  dimension: country {
    type: string
    map_layer_name: countries
    sql:
      case
        when ${TABLE}.Country = 'Korea, South' then 'South Korea'
        when ${TABLE}.Country = 'Tanzania' then 'United Republic of Tanzania'
        when ${TABLE}.Country = 'Congo (Kinshasa)' then 'Democratic Republic of the Congo'
        when ${TABLE}.Country = 'Congo (Brazzaville)' then 'Republic of the Congo'
        when ${TABLE}.Country = 'Czechia' then 'Czech Republic'
        when ${TABLE}.Country = 'Czechia' then 'Czech Republic'
        when ${TABLE}.Country = 'Serbia' then 'Republic of Serbia'
        when ${TABLE}.Country = 'North Macedonia' then 'Macedonia'
        else ${TABLE}.Country
        -- when ${TABLE}.Country = 'Cote d'Ivoire' then 'Ivory Coast'
      end
      ;;
    drill_fields: [state]
    link: {
      label: "{{ value }} Drill Down"
      url: "/dashboards-next/2?Country={{ value }}"
      icon_url: "https://looker.com/favicon.ico"
    }
    link: {
      label: "See original data"
      url: "https://coronavirus.jhu.edu/map.html"
      icon_url: "https://looker.com/favicon.ico"
    }
  }

  dimension: state {
    type: string
    map_layer_name: us_states
    sql: coalesce(${TABLE}.State,${country_raw}) ;;
    link: {
      label: "See original data"
      url: "https://coronavirus.jhu.edu/map.html"
      icon_url: "https://looker.com/favicon.ico"
    }
  }

  dimension: region_country {
    label: "Region"
    type: string
    map_layer_name: countries
    sql: ${TABLE}.region_country ;;
    drill_fields: [country, state]
  }

  dimension: region_state {
    label: "Region (US States)"
    type: string
    sql: ${TABLE}.region_state ;;
  }

  dimension: region_cut {
    hidden: yes
    type: number
    sql: 'delete me later' ;;
  }

  dimension: lat {
    type: number
    sql: ${TABLE}.Lat ;;
  }

  dimension: long {
    type: number
    sql: ${TABLE}.Long ;;
  }

  dimension: location {
    type: location
    sql_latitude: ${lat} ;;
    sql_longitude: ${long} ;;
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
    sql: ${TABLE}.Date ;;
    drill_fields: [region_country, country, state]
  }

  dimension: confirmed_cumulative {
    # hidden: yes
    type: number
    sql: ${TABLE}.confirmed_cumulative ;;
  }

  dimension: confirmed_new_cases {
    # hidden: yes
    type: number
    sql: ${TABLE}.confirmed_new_cases ;;
  }

  dimension: deaths_cumulative {
    hidden: yes
    type: number
    sql: ${TABLE}.deaths_cumulative ;;
  }

  dimension: deaths_new_cases {
    hidden: yes
    type: number
    sql: ${TABLE}.deaths_new_cases ;;
  }

  dimension: recovered_cumulative {
    hidden: yes
    type: number
    sql: ${TABLE}.recovered_cumulative ;;
  }

  dimension: recovered_new_cases {
    hidden: yes
    type: number
    sql: ${TABLE}.recovered_new_cases ;;
  }


  dimension: x {
    hidden: yes
    type: string
    sql: '' ;;
    # sql: ${TABLE}.x ;;
  }

####################
#### Derived Dimensions ####
####################

  # parameter: country_vs_state {
  #   type: unquoted
  #   default_value: "country"
  #   allowed_value: {
  #     label: "By Country"
  #     value: "country"
  #   }
  #   allowed_value: {
  #     label: "By State"
  #     value: "state"
  #   }
  # }

  # dimension: geographic_cut {
  #   label: " Country/State"
  #   type: string
  #   sql:
  #         {% if country_vs_state._parameter_value == 'country' %} ${country}
  #         {% elsif country_vs_state._parameter_value == 'state' %} ${state}
  #         {% endif %} ;;
  # }

  # dimension: region_cut {
  #   label: " Region"
  #   type: string
  #   sql:
  #       {% if country_vs_state._parameter_value == 'country' %} ${region_country}
  #       {% elsif country_vs_state._parameter_value == 'state' %} ${region_state}
  #       {% endif %} ;;
  #   drill_fields: [geographic_cut]
  # }

  dimension: active_cumulative {
    hidden: yes
    type: number
    sql: ${confirmed_cumulative} - ${recovered_cumulative} - ${deaths_cumulative} ;;
  }

  dimension: active_new_cases {
    hidden: yes
    type: number
    sql: ${confirmed_new_cases} - ${recovered_new_cases} - ${deaths_new_cases} ;;
  }

  dimension: closed_cumulative {
    hidden: yes
    type: number
    sql: ${recovered_cumulative} + ${deaths_cumulative} ;;
  }

  dimension: closed_new_cases {
    hidden: yes
    type: number
    sql: ${recovered_new_cases} + ${deaths_new_cases} ;;
  }

  dimension: days_since_first_case {
    type: number
    sql:

        DATE_DIFF(${date_raw},
          {% if covid_data.country._in_query %} ${days_since_first_case_country.min_raw}
          {% else %} ${days_since_first_case_state.min_raw}
          {% endif %}
        , DAY) ;;
        # {% elsif country_vs_state._parameter_value == 'state' %}
    }

    dimension: is_max_date {
      type: yesno
      sql: ${date_raw} = ${max_date_intl.max_date_raw} ;;
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

    measure: confirmed_cases {
      group_label: "Dynamic"
      label: "Confirmed Cases"
      type: number
      sql:
        {% if new_vs_running_total._parameter_value == 'new_cases' %} ${confirmed_new}
        {% elsif new_vs_running_total._parameter_value == 'running_total' %} ${confirmed_running_total}
        {% endif %} ;;
      drill_fields: [drill*]
    }

    measure: deaths {
      group_label: "Dynamic"
      label: "Deaths"
      type: number
      sql:
        {% if new_vs_running_total._parameter_value == 'new_cases' %} ${deaths_new}
        {% elsif new_vs_running_total._parameter_value == 'running_total' %} ${deaths_running_total}
        {% endif %} ;;
      drill_fields: [drill*]
    }

    measure: recoveries {
      group_label: "Dynamic"
      label: "Recoveries"
      type: number
      sql:
        {% if new_vs_running_total._parameter_value == 'new_cases' %} ${recovery_new}
        {% elsif new_vs_running_total._parameter_value == 'running_total' %} ${recovery_running_total}
        {% endif %} ;;
      drill_fields: [drill*]
    }

    measure: active_cases {
      group_label: "Dynamic"
      label: "Active Cases"
      type: number
      sql:
        {% if new_vs_running_total._parameter_value == 'new_cases' %} ${active_new}
        {% elsif new_vs_running_total._parameter_value == 'running_total' %} ${active_running_total}
        {% endif %} ;;
      drill_fields: [drill*]
    }

    measure: closed_cases {
      group_label: "Dynamic"
      label: "Closed Cases"
      type: number
      sql:
        {% if new_vs_running_total._parameter_value == 'new_cases' %} ${closed_new}
        {% elsif new_vs_running_total._parameter_value == 'running_total' %} ${closed_running_total}
        {% endif %} ;;
      drill_fields: [drill*]
    }

    measure: count {
      hidden: yes
      type: count
      drill_fields: []
    }

    measure: count_pk {
      hidden: yes
      type: count_distinct
      sql: ${pk} ;;
    }

    measure: confirmed_new {
      group_label: "New Cases"
      label: "Confirmed Cases (New)"
      type: sum
      sql: ${confirmed_new_cases} ;;
    }

    measure: confirmed_option_1 {
      hidden: yes
      type: sum
      sql: ${confirmed_cumulative} ;;
    }

    measure: confirmed_option_2 {
      hidden: yes
      type: sum
      sql: ${confirmed_cumulative} ;;
      filters: {
        field: is_max_date
        value: "Yes"
      }
    }

    measure: confirmed_running_total {
      group_label: "Running Total"
      label: "Confirmed Cases (Running Total)"
      type: number
      sql:
          {% if covid_data.date_date._in_query %} ${confirmed_option_1}
          {% else %}  ${confirmed_option_2}
          {% endif %} ;;
    }

    measure: deaths_new {
      group_label: "New Cases"
      label: "Deaths (New)"
      type: sum
      sql: ${deaths_new_cases} ;;
    }

    measure: deaths_option_1 {
      hidden: yes
      type: sum
      sql: ${deaths_cumulative} ;;
    }

    measure: deaths_option_2 {
      hidden: yes
      type: sum
      sql: ${deaths_cumulative} ;;
      filters: {
        field: is_max_date
        value: "Yes"
      }
    }

    measure: deaths_running_total {
      group_label: "Running Total"
      label: "Deaths (Running Total)"
      type: number
      sql:
          {% if covid_data.date_date._in_query %} ${deaths_option_1}
          {% else %}  ${deaths_option_2}
          {% endif %} ;;
    }

    measure: recovery_new {
      group_label: "New Cases"
      label: "Recoveries (New)"
      type: sum
      sql: ${recovered_new_cases} ;;
    }

    measure: recovered_option_1 {
      hidden: yes
      type: sum
      sql: ${recovered_cumulative} ;;
    }

    measure: recovered_option_2 {
      hidden: yes
      type: sum
      sql: ${recovered_cumulative} ;;
      filters: {
        field: is_max_date
        value: "Yes"
      }
    }

    measure: recovery_running_total {
      group_label: "Running Total"
      label: "Recoveries (Running Total)"
      type: number
      sql:
          {% if covid_data.date_date._in_query %} ${recovered_option_1}
          {% else %}  ${recovered_option_2}
          {% endif %} ;;
    }

    measure: active_new {
      group_label: "New Cases"
      label: "Active Cases (New)"
      type: sum
      sql: ${active_new_cases} ;;
    }

    measure: active_option_1 {
      hidden: yes
      type: sum
      sql: ${active_cumulative} ;;
    }

    measure: active_option_2 {
      hidden: yes
      type: sum
      sql: ${active_cumulative} ;;
      filters: {
        field: is_max_date
        value: "Yes"
      }
    }

    measure: active_running_total {
      group_label: "Running Total"
      label: "Active Cases (Running Total)"
      type: number
      sql:
          {% if covid_data.date_date._in_query %} ${active_option_1}
          {% else %}  ${active_option_2}
          {% endif %} ;;
    }

    measure: closed_new {
      group_label: "New Cases"
      label: "Closed Cases (New)"
      type: sum
      sql: ${closed_new_cases} ;;
    }

    measure: closed_option_1 {
      hidden: yes
      type: sum
      sql: ${closed_cumulative} ;;
    }

    measure: closed_option_2 {
      hidden: yes
      type: sum
      sql: ${closed_cumulative} ;;
      filters: {
        field: is_max_date
        value: "Yes"
      }
    }

    measure: closed_running_total {
      group_label: "Running Total"
      label: "Closed Cases (Running Total)"
      type: number
      sql:
          {% if covid_data.date_date._in_query %} ${closed_option_1}
          {% else %}  ${closed_option_2}
          {% endif %} ;;
    }

    measure: active_rate {
      group_label: "Rates"
      description: "Of all cases, how many are active?"
      type: number
      sql: 1.0 * ${active_running_total} / nullif((${confirmed_running_total}),0);;
      value_format_name: percent_1
    }

    measure: recovery_rate {
      group_label: "Rates"
      description: "Of closed cases, how many recovered (vs. died)?"
      type: number
      sql: 1.0 * ${recovery_running_total} / NULLIF(${confirmed_running_total}, 0);;
      value_format_name: percent_1
    }

    measure: case_fatality_rate {
      group_label: "Rates"
      description: "What percent of infections have resulted in death?"
      type: number
      sql: 1.0 * ${deaths_running_total}/NULLIF(${confirmed_running_total}, 0);;
      value_format_name: percent_1
    }

    measure: min_date {
      hidden: yes
      type: date
      sql: min(${date_raw}) ;;
    }

    measure: max_date {
      hidden: yes
      type: date
      sql: max(${date_raw}) ;;
    }

    set: drill {
      fields: [
        region_country,
        x,
        confirmed_cases,
        active_rate,
        deaths
      ]
    }

    # measure: geographic_cut_ordered {
    #   type: list
    #   list_field: geographic_cut
    #   order_by_field: confirmed_running_total
    # }
  }
