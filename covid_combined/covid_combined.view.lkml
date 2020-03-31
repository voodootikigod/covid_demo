view: nyc_correction {
  derived_table: {
    datagroup_trigger: covid_data
    sql:

      SELECT
        fips,
        county,
        province_state,
        country_region,
        lat,
        long,
        combined_key,
        measurement_date,
        confirmed,
        deaths

    FROM `lookerdata.covid19.combined_covid_data`
    WHERE NOT (province_state = 'New York' AND country_region = 'US' AND fips = 123456789)

    UNION ALL

    SELECT
    36005 as fips,
    'Bronx' as county,
    'New York' as province_state,
    'US' as country_region,
    40.860208 as lat,
    -73.857072 as long,
    'Bronx, New York, US' as combined_key,
    measurement_date,
    round(confirmed * 0.17,0) as confirmed,
    round(deaths * 0.17,0) as deaths
    FROM `lookerdata.covid19.combined_covid_data`
    WHERE province_state = 'New York'
    AND country_region = 'US'
    AND fips = 123456789

    UNION ALL

    SELECT
      36081 as fips,
      'Queens' as county,
      'New York' as province_state,
      'US' as country_region,
      40.724358 as lat,
      -73.798797 as long,
      'Queens, New York, US' as combined_key,
      measurement_date,
      round(confirmed * 0.27,0) as confirmed,
      round(deaths * 0.27,0) as deaths
    FROM `lookerdata.covid19.combined_covid_data`
    WHERE province_state = 'New York'
    AND country_region = 'US'
    AND fips = 123456789

    UNION ALL

    SELECT
      36061 as fips,
      'New York County' as county,
      'New York' as province_state,
      'US' as country_region,
      40.774242 as lat,
      -73.975842 as long,
      'New York County, New York, US' as combined_key,
      measurement_date,
      round(confirmed * 0.19,0) as confirmed,
      round(deaths * 0.19,0) as deaths
    FROM `lookerdata.covid19.combined_covid_data`
    WHERE province_state = 'New York'
    AND country_region = 'US'
    AND fips = 123456789

    UNION ALL

    SELECT
      36047 as fips,
      'Brooklyn' as county,
      'New York' as province_state,
      'US' as country_region,
      40.682217 as lat,
      -73.937122 as long,
      'Brooklyn, New York, US' as combined_key,
      measurement_date,
      round(confirmed * 0.31,0) as confirmed,
      round(deaths * 0.31,0) as deaths
    FROM `lookerdata.covid19.combined_covid_data`
    WHERE province_state = 'New York'
    AND country_region = 'US'
    AND fips = 123456789

    UNION ALL

    SELECT
      36085 as fips,
      'Richmond' as county,
      'New York' as province_state,
      'US' as country_region,
      40.585763 as lat,
      -74.135702 as long,
      'Richmond, New York, US' as combined_key,
      measurement_date,
      round(confirmed * 0.06,0) as confirmed,
      round(deaths * 0.06,0) as deaths
    FROM `lookerdata.covid19.combined_covid_data`
    WHERE province_state = 'New York'
    AND country_region = 'US'
    AND fips = 123456789

    ;;
  }
}
view: jhu_sample_county_level_final {
  derived_table: {
    datagroup_trigger: covid_data
    sql:

    SELECT
        'Real Data' as real_vs_forecasted,
        fips,
        county,
        province_state,
        country_region,
        lat,
        long,
        combined_key,
        measurement_date,

        confirmed as confirmed_cumulative,
        confirmed - coalesce(LAG(confirmed, 1) OVER (PARTITION BY concat(coalesce(county,''), coalesce(province_state,''), coalesce(country_region,'')) ORDER BY measurement_date ASC),0) as confirmed_new_cases,

        deaths as deaths_cumulative,
        deaths - coalesce(LAG(deaths, 1) OVER (PARTITION BY concat(coalesce(county,''), coalesce(province_state,''), coalesce(country_region,''))  ORDER BY measurement_date ASC),0) as deaths_new_cases

    FROM ${nyc_correction.SQL_TABLE_NAME}

    UNION ALL

        SELECT
        'Forecasted' as real_vs_forecasted,
        fips,
        county,
        province_state,
        country_region,
        lat,
        long,
        combined_key,
        cast(forecast_date as date) as measurement_date,

        round(confirmed_running_total + SUM(forecasted_new_confirmed_cases) OVER (PARTITION BY concat(coalesce(county,''), coalesce(province_state,''), coalesce(country_region,'')) ORDER BY forecast_date ASC ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW),0) as confirmed_cumulative,
        round(forecasted_new_confirmed_cases,0) as confirmed_new_cases,

        round(deaths_running_total + SUM(forecasted_new_deaths) OVER (PARTITION BY concat(coalesce(county,''), coalesce(province_state,''), coalesce(country_region,'')) ORDER BY forecast_date ASC ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW),0) as deaths_cumulative,
        round(forecasted_new_deaths,0) as deaths_new_cases

    FROM `lookerdata.covid19.forecasting_results_temp_table3`
    WHERE cast(forecast_date as date) > (SELECT max(measurement_date) FROM `lookerdata.covid19.combined_covid_data`)

    ;;
  }

####################
#### Original Dimensions ####
####################

  dimension: pk {
    primary_key: yes
    hidden: yes
    type: string
    sql: concat(${pre_pk},${measurement_raw}) ;;
  }

  dimension: real_vs_forecasted {
    type: string
    sql: ${TABLE}.real_vs_forecasted ;;
  }

  dimension: pre_pk {
    hidden: yes
    type: string
    sql: concat(coalesce(${county},''), coalesce(${province_state},''), coalesce(${country_region},'')) ;;
  }

  dimension: combined_key {
    hidden: yes
    type: string
    sql: ${TABLE}.combined_key ;;
  }

  dimension_group: measurement {
    type: time
    timeframes: [
      raw,
      date
    ]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.measurement_date ;;
  }

#### Location ####

  dimension: country_raw {
    hidden: yes
    type: string
    sql: ${TABLE}.country_region ;;
  }

  dimension: county {
    group_label: "Location"
    label: "County"
    type: string
    sql: ${TABLE}.county ;;
    link: {
      label: "{{ value }} - County Deep Dive"
      url: "/dashboards/22?County={{ value }}&State={{ province_state._value }}"
      icon_url: "https://looker.com/favicon.ico"
    }
    link: {
      label: "{{ value }} - News Search"
      url: "https://news.google.com/search?q={{ value }}%20county%20{{ province_state._value}}%20covid"
      icon_url: "http://www.google.com/s2/favicons?domain_url=http://www.news.google.com"
    }
  }

  dimension: lat {
    hidden: yes
    type: number
    sql: ${TABLE}.lat ;;
  }

  dimension: long {
    hidden: yes
    type: number
    sql: ${TABLE}.long ;;
  }

  dimension: location {
    group_label: "Location"
    type: location
    sql_latitude: ${lat} ;;
    sql_longitude: ${long} ;;
  }

  dimension: fips {
    group_label: "Location"
    label: "County (Maps)"
    map_layer_name: us_counties_fips
    type: number
    sql: ${TABLE}.fips ;;
    html: {{ county._value }} ;;
  }

  dimension: province_state {
    group_label: "Location"
    label: "State"
    map_layer_name: us_states
    type: string
    sql: ${TABLE}.province_state ;;
    drill_fields: [fips]
    link: {
      label: "{{ value }} - State Deep Dive"
      url: "/dashboards/21?State={{ value }}"
      icon_url: "https://looker.com/favicon.ico"
    }
    link: {
      label: "{{ value }} - COVID19 Website"
      url: "{{ state_url_code_final.url._value }}"
      icon_url: "http://google.com/favicon.ico"
    }
    link: {
      label: "{{ value }} - News Search"
      url: "https://news.google.com/search?q={{ value }}%20covid"
      icon_url: "http://www.google.com/s2/favicons?domain_url=http://www.news.google.com"
    }
  }

#### KPIs ####

  dimension: confirmed_cumulative {
    hidden: yes
    type: number
    sql: ${TABLE}.confirmed_cumulative ;;
  }

  dimension: confirmed_new_cases {
    hidden: yes
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

  dimension: x {
    hidden: yes
    type: string
    sql: '' ;;
    # sql: ${TABLE}.x ;;
  }

####################
#### Derived Dimensions ####
####################

#### Location ####

  dimension: country_region {
    group_label: "Location"
    label: "Country"
    type: string
    map_layer_name: countries
    sql:
      case
        when ${TABLE}.country_region = 'Korea, South' then 'South Korea'
        when ${TABLE}.country_region = 'Tanzania' then 'United Republic of Tanzania'
        when ${TABLE}.country_region = 'Congo (Kinshasa)' then 'Democratic Republic of the Congo'
        when ${TABLE}.country_region = 'Congo (Brazzaville)' then 'Republic of the Congo'
        when ${TABLE}.country_region = 'Czechia' then 'Czech Republic'
        when ${TABLE}.country_region = 'Czechia' then 'Czech Republic'
        when ${TABLE}.country_region = 'Serbia' then 'Republic of Serbia'
        when ${TABLE}.country_region = 'North Macedonia' then 'Macedonia'
        else ${TABLE}.country_region
        -- when ${TABLE}.Country = 'Cote d'Ivoire' then 'Ivory Coast'
      end ;;
    drill_fields: [province_state]
    link: {
      label: "{{ value }} - Country Deep Dive"
      url: "/dashboards/23?Country={{ value }}"
      icon_url: "https://looker.com/favicon.ico"
    }
    link: {
      label: "{{ value }} - COVID19 Website"
      url: "{{ country_url_code_final.url._value }}"
      icon_url: "http://google.com/favicon.ico"
    }
    link: {
      label: "{{ value }} - News Search"
      url: "https://news.google.com/search?q={{ value }}%20covid"
      icon_url: "http://www.google.com/s2/favicons?domain_url=http://www.news.google.com"
    }
  }

  dimension: county_non_null {
    hidden: yes
    type: string
    sql: coalesce(${county},${province_state},${country_region}) ;;
  }

  dimension: county_full {
    hidden: yes
    group_label: "Location"
    label: "County (Full)"
    sql: concat(coalesce(concat(${county},', '),''),coalesce(concat(${province_state},', ')),${country_region}) ;;
  }

  dimension: state_full {
    hidden: yes
    group_label: "Location"
    label: "State (Full)"
    sql: concat(coalesce(concat(${province_state},', ')),${country_region}) ;;
  }

  dimension: fips_as_string {
    hidden: yes
    type: string
    sql: CASE WHEN LENGTH(cast(${fips} as string)) = 4 THEN CONCAT('0',${fips})
      ELSE cast(${fips} as string) END;;
  }

#   dimension: distance {
#     type: distance
#     sql: ${} ;;
#   }

#### Location Rank ####

  dimension: country_ordered {
    group_label: "Location"
    label: "Country (Ordered)"
    sql: concat(cast(${country_rank.rank} as string),'-',${country_raw} ;;
    html: {{ country_region._value }} ;;
  }

  dimension: state_ordered {
    group_label: "Location"
    label: "State (Ordered)"
    sql: concat(cast(${state_rank.rank} as string),'-',${province_state} ;;
    html: {{ province_state._value }} ;;
  }

  dimension: fips_ordered {
    group_label: "Location"
    label: "County (Ordered)"
    sql: concat(cast(${fips_rank.rank} as string),'-',${fips} ;;
    html: {{ county._value }} ;;
  }

  parameter: show_top_x_values {
    type: number
    default_value: "10"
  }

  dimension: country_top_x {
    group_label: "Location"
    label: "Country (Show Top X Values)"
    sql: case when ${country_rank.rank} <= {% parameter show_top_x_values %} then ${country_region} else ' Other' end ;;
    link: {
      label: "{{ value }} - Country Deep Dive"
      url: "/dashboards/23?Country={{ value }}"
      icon_url: "https://looker.com/favicon.ico"
    }
#     link: {
#       label: "{{ value }} - COVID19 Website"
#       url: "{{ country_url_code_final.url._value }}"
#       icon_url: "http://google.com/favicon.ico"
#     }
  }

  dimension: state_top_x {
    group_label: "Location"
    label: "State (Show Top X Values)"
    sql: case when ${state_rank.rank} <= {% parameter show_top_x_values %} then ${province_state} else ' Other' end ;;
    link: {
      label: "{{ value }} - State Deep Dive"
      url: "/dashboards/21?State={{ value }}"
      icon_url: "https://looker.com/favicon.ico"
    }
#     link: {
#       label: "{{ value }} - COVID19 Website"
#       url: "{{ state_url_code_final.url._value }}"
#       icon_url: "http://google.com/favicon.ico"
#     }
  }

  dimension: county_top_x {
    group_label: "Location"
    label: "County (Show Top X Values)"
    sql: case when ${fips_rank.rank} <= {% parameter show_top_x_values %} then ${county} else ' Other' end ;;
    link: {
      label: "{{ value }} - County Deep Dive"
      url: "/dashboards/22?County={{ value }}&State={{ state_top_x._value }}"
      icon_url: "https://looker.com/favicon.ico"
    }
  }

#### Forecasted ####

  parameter: allow_forecasted_values {
    type: unquoted
    default_value: "no"
    allowed_value: {
      label: "No"
      value: "no"
    }
    allowed_value: {
      label: "Yes"
      value: "yes"
    }
  }

#   parameter: location_selector {
#     type: unquoted
#     default_value: "state"
#     allowed_value: {
#       label: "State"
#       value: "state"
#     }
#     allowed_value: {
#       label: "County"
#       value: "county"
#     }
#     allowed_value: {
#       label: "PUMA"
#       value: "puma"
#     }
#   }
#
#   dimension: location_selection {
#     group_label: "Location"
#     type: string
#     sql:
#         {% if    location_selector._parameter_value == 'state' %} ${province_state}
#         {% elsif location_selector._parameter_value == 'county' %} ${fips}
#         {% elsif location_selector._parameter_value == 'puma' %} ${zip_to_puma_v2.puma}
#         {% endif %} ;;
#   }

#### Max Date ####

  dimension: is_max_date {
    # hidden: yes
    type: yesno
    sql: ${measurement_raw} = ${max_date_covid.max_date_raw} ;;
  }

  dimension: days_since_max_date {
    type:  number
    sql: date_diff(${measurement_raw},${max_date_covid.max_date_raw},day) ;;
  }

#### Days since X Case ####

  parameter: minimum_number_cases {
    label: "Minimum Number of cases (X)"
    description: "Modify your analysis to start counting days since outbreak to start with a minumum of X cases."
    type: number
    default_value: "1"
  }

  dimension_group: county_outbreak_start {
    hidden: yes
    type: time
    timeframes: [raw, date]
    sql: (SELECT CAST(MIN(foobar.measurement_date) AS TIMESTAMP)
      FROM ${jhu_sample_county_level_final.SQL_TABLE_NAME} as foobar
      WHERE foobar.confirmed_cumulative >= {% parameter minimum_number_cases %}
      AND coalesce(${TABLE}.county, ${TABLE}.province_state, ${TABLE}.country_region) = coalesce(foobar.county,foobar.province_state,foobar.country_region )  )  ;;
  }

  dimension_group: state_outbreak_start {
    hidden: yes
    type: time
    timeframes: [raw, date]
    sql: (SELECT CAST(MIN(foobar.measurement_date) AS TIMESTAMP)
      FROM ${jhu_sample_county_level_final.SQL_TABLE_NAME} as foobar
      WHERE foobar.confirmed_cumulative >= {% parameter minimum_number_cases %}
      AND coalesce(${TABLE}.province_state, ${TABLE}.country_region) = coalesce(foobar.province_state,foobar.country_region ) )  ;;
  }

  dimension_group: country_outbreak_start {
    hidden: yes
    type: time
    timeframes: [raw, date]
    sql: (SELECT CAST(MIN(foobar.measurement_date) AS TIMESTAMP)
      FROM ${jhu_sample_county_level_final.SQL_TABLE_NAME} as foobar
      WHERE foobar.confirmed_cumulative >= {% parameter minimum_number_cases %}
      AND ${TABLE}.country_region = foobar.country_region ) ;;
  }

  dimension_group: system_outbreak_start {
    hidden: yes
    type: time
    timeframes: [raw, date]
    sql: (SELECT CAST(MIN(foobar.measurement_date) AS TIMESTAMP)
      FROM ${jhu_sample_county_level_final.SQL_TABLE_NAME} as foobar
      WHERE foobar.confirmed_cumulative >= {% parameter minimum_number_cases %} );;
  }

  dimension: days_since_first_outbreak_county {
    hidden: yes
    type:  number
    sql: date_diff(${measurement_raw},${county_outbreak_start_date},  day) + 1 ;;
  }

  dimension: days_since_first_outbreak_state {
    hidden: yes
    type:  number
    sql: date_diff(${measurement_raw},${state_outbreak_start_date},  day) + 1 ;;
  }

  dimension: days_since_first_outbreak_country {
    hidden: yes
    type:  number
    sql: date_diff(${measurement_raw},${country_outbreak_start_date},  day) + 1 ;;
  }

  dimension: days_since_first_outbreak_system {
    hidden: yes
    type:  number
    sql: date_diff(${measurement_raw},${system_outbreak_start_date},  day) + 1 ;;
  }

  dimension: days_since_first_outbreak {
    label: "Days Since Oubreak of X cases"
    type:  number
    sql:
          {% if jhu_sample_county_level_final.fips._in_query %} ${days_since_first_outbreak_county}
          {% elsif jhu_sample_county_level_final.province_state._in_query %} ${days_since_first_outbreak_state}
          {% elsif jhu_sample_county_level_final.country_region._in_query %} ${days_since_first_outbreak_country}
          {% else %}  ${days_since_first_outbreak_system}
          {% endif %} ;;
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
    group_label: " Dynamic"
    label: "Confirmed Cases"
    type: number
    sql:
        {% if new_vs_running_total._parameter_value == 'new_cases' %} ${confirmed_new}
        {% elsif new_vs_running_total._parameter_value == 'running_total' %} ${confirmed_running_total}
        {% endif %} ;;
    drill_fields: [drill*]
    link: {
      label: "Data Source - NYT County Data"
      url: "https://github.com/nytimes/covid-19-data"
      icon_url: "http://www.google.com/s2/favicons?domain_url=http://www.nytimes.com"
    }
    link: {
      label: "Data Source - Johns Hopkins State & Country Data"
      url: "https://github.com/CSSEGISandData/COVID-19"
      icon_url: "http://www.google.com/s2/favicons?domain_url=http://www.jhu.edu"
    }
  }

  measure: deaths {
    group_label: " Dynamic"
    label: "Deaths"
    type: number
    sql:
        {% if new_vs_running_total._parameter_value == 'new_cases' %} ${deaths_new}
        {% elsif new_vs_running_total._parameter_value == 'running_total' %} ${deaths_running_total}
        {% endif %} ;;
    drill_fields: [drill*]
    link: {
      label: "Data Source - NYT County Data"
      url: "https://github.com/nytimes/covid-19-data"
      icon_url: "http://www.google.com/s2/favicons?domain_url=http://www.nytimes.com"
    }
    link: {
      label: "Data Source - Johns Hopkins State & Country Data"
      url: "https://github.com/CSSEGISandData/COVID-19"
      icon_url: "http://www.google.com/s2/favicons?domain_url=http://www.jhu.edu"
    }
  }

  measure: confirmed_new_option_1 {
    hidden: yes
    type: sum
    sql: ${confirmed_new_cases} ;;
  }

  measure: confirmed_new_option_2 {
    hidden: yes
    type: sum
    sql: ${confirmed_new_cases} ;;
    filters: {
      field: is_max_date
      value: "Yes"
    }
  }

  measure: confirmed_new {
    group_label: " New Cases"
    label: "Confirmed Cases (New)"
    type: number
    sql:
      {% if jhu_sample_county_level_final.measurement_date._in_query or jhu_sample_county_level_final.days_since_first_outbreak._in_query or jhu_sample_county_level_final.days_since_max_date._in_query %} ${confirmed_new_option_1}
      {% else %}  ${confirmed_new_option_2}
      {% endif %} ;;
    drill_fields: [drill*]
    link: {
      label: "Data Source - NYT County Data"
      url: "https://github.com/nytimes/covid-19-data"
      icon_url: "http://www.google.com/s2/favicons?domain_url=http://www.nytimes.com"
    }
    link: {
      label: "Data Source - Johns Hopkins State & Country Data"
      url: "https://github.com/CSSEGISandData/COVID-19"
      icon_url: "http://www.google.com/s2/favicons?domain_url=http://www.jhu.edu"
    }
  }

  measure: confirmed_new_per_million {
    group_label: " New Cases"
    label: "Confirmed Cases per Million (New)"
    type: number
    sql: 1000000*${confirmed_new} / nullif(${population_by_county_state_country.sum_population},0) ;;
    value_format_name: decimal_0
    drill_fields: [drill*]
    link: {
      label: "Data Source - NYT County Data"
      url: "https://github.com/nytimes/covid-19-data"
      icon_url: "http://www.google.com/s2/favicons?domain_url=http://www.nytimes.com"
    }
    link: {
      label: "Data Source - Johns Hopkins State & Country Data"
      url: "https://github.com/CSSEGISandData/COVID-19"
      icon_url: "http://www.google.com/s2/favicons?domain_url=http://www.jhu.edu"
    }
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
    group_label: " Running Total"
    label: "Confirmed Cases (Running Total)"
    type: number
    sql:
          {% if jhu_sample_county_level_final.measurement_date._in_query or jhu_sample_county_level_final.days_since_first_outbreak._in_query or jhu_sample_county_level_final.days_since_max_date._in_query %} ${confirmed_option_1}
          {% else %}  ${confirmed_option_2}
          {% endif %} ;;
    drill_fields: [drill*]
    link: {
      label: "Data Source - NYT County Data"
      url: "https://github.com/nytimes/covid-19-data"
      icon_url: "http://www.google.com/s2/favicons?domain_url=http://www.nytimes.com"
    }
    link: {
      label: "Data Source - Johns Hopkins State & Country Data"
      url: "https://github.com/CSSEGISandData/COVID-19"
      icon_url: "http://www.google.com/s2/favicons?domain_url=http://www.jhu.edu"
    }
  }

  measure: confirmed_running_total_per_million {
    group_label: " Running Total"
    label: "Confirmed Cases per Million (Running Total)"
    type: number
    sql: 1000000*${confirmed_running_total} / nullif(${population_by_county_state_country.sum_population},0) ;;
    value_format_name: decimal_0
    drill_fields: [drill*]
    link: {
      label: "Data Source - NYT County Data"
      url: "https://github.com/nytimes/covid-19-data"
      icon_url: "http://www.google.com/s2/favicons?domain_url=http://www.nytimes.com"
    }
    link: {
      label: "Data Source - Johns Hopkins State & Country Data"
      url: "https://github.com/CSSEGISandData/COVID-19"
      icon_url: "http://www.google.com/s2/favicons?domain_url=http://www.jhu.edu"
    }
  }

  measure: confirmed_cases_per_icu_beds {
    group_label: "Hospital Capacity"
    label: "Confirmed Cases per ICU Beds"
    type: number
    sql: 1.0*${confirmed_running_total}*${hospital_bed_summary_final.estimated_percent_of_covid_cases_of_county}/nullif(${hospital_bed_summary_final.sum_num_icu_beds},0) ;;
    value_format_name: decimal_2
    drill_fields: [drill*]
    link: {
      label: "Data Source - NYT County Data"
      url: "https://github.com/nytimes/covid-19-data"
      icon_url: "http://www.google.com/s2/favicons?domain_url=http://www.nytimes.com"
    }
    link: {
      label: "Data Source - ESRI Hospital Beds"
      url: "https://coronavirus-resources.esri.com/datasets/definitivehc::definitive-healthcare-usa-hospital-beds?geometry=38.847%2C-16.820%2C-63.809%2C72.123"
      icon_url: "http://www.google.com/s2/favicons?domain_url=http://www.esri.com"
    }
  }

  measure: confirmed_cases_per_staffed_beds {
    group_label: "Hospital Capacity"
    label: "Confirmed Cases per Staffed Beds"
    type: number
    sql: 1.0*${confirmed_running_total}*${hospital_bed_summary_final.estimated_percent_of_covid_cases_of_county}/nullif(${hospital_bed_summary_final.sum_num_staffed_beds},0) ;;
    value_format_name: decimal_2
    drill_fields: [drill*]
    link: {
      label: "Data Source - NYT County Data"
      url: "https://github.com/nytimes/covid-19-data"
      icon_url: "http://www.google.com/s2/favicons?domain_url=http://www.nytimes.com"
    }
    link: {
      label: "Data Source - ESRI Hospital Beds"
      url: "https://coronavirus-resources.esri.com/datasets/definitivehc::definitive-healthcare-usa-hospital-beds?geometry=38.847%2C-16.820%2C-63.809%2C72.123"
      icon_url: "http://www.google.com/s2/favicons?domain_url=http://www.esri.com"
    }
  }

  measure: confirmed_cases_per_licensed_beds {
    group_label: "Hospital Capacity"
    label: "Confirmed Cases per Licensed Beds"
    type: number
    sql: 1.0*${confirmed_running_total}*${hospital_bed_summary_final.estimated_percent_of_covid_cases_of_county}/nullif(${hospital_bed_summary_final.sum_num_licensed_beds},0) ;;
    value_format_name: decimal_2
    drill_fields: [drill*]
    link: {
      label: "Data Source - NYT County Data"
      url: "https://github.com/nytimes/covid-19-data"
      icon_url: "http://www.google.com/s2/favicons?domain_url=http://www.nytimes.com"
    }
    link: {
      label: "Data Source - ESRI Hospital Beds"
      url: "https://coronavirus-resources.esri.com/datasets/definitivehc::definitive-healthcare-usa-hospital-beds?geometry=38.847%2C-16.820%2C-63.809%2C72.123"
      icon_url: "http://www.google.com/s2/favicons?domain_url=http://www.esri.com"
    }
  }

  measure: deaths_new_option_1 {
    hidden: yes
    type: sum
    sql: ${deaths_new_cases} ;;
  }

  measure: deaths_new_option_2 {
    hidden: yes
    type: sum
    sql: ${deaths_new_cases} ;;
    filters: {
      field: is_max_date
      value: "Yes"
    }
  }

  measure: deaths_new {
    group_label: " New Cases"
    label: "Deaths (New)"
    type: number
    sql:
      {% if jhu_sample_county_level_final.measurement_date._in_query or jhu_sample_county_level_final.days_since_first_outbreak._in_query or jhu_sample_county_level_final.days_since_max_date._in_query %} ${deaths_new_option_1}
      {% else %}  ${deaths_new_option_2}
      {% endif %} ;;
    drill_fields: [drill*]
    link: {
      label: "Data Source - NYT County Data"
      url: "https://github.com/nytimes/covid-19-data"
      icon_url: "http://www.google.com/s2/favicons?domain_url=http://www.nytimes.com"
    }
    link: {
      label: "Data Source - Johns Hopkins State & Country Data"
      url: "https://github.com/CSSEGISandData/COVID-19"
      icon_url: "http://www.google.com/s2/favicons?domain_url=http://www.jhu.edu"
    }
  }

  measure: deaths_new_per_million {
    group_label: " New Cases"
    label: "Deaths per Million (New)"
    type: number
    sql: 1000000*${deaths_new} / nullif(${population_by_county_state_country.sum_population},0) ;;
    value_format_name: decimal_0
    drill_fields: [drill*]
    link: {
      label: "Data Source - NYT County Data"
      url: "https://github.com/nytimes/covid-19-data"
      icon_url: "http://www.google.com/s2/favicons?domain_url=http://www.nytimes.com"
    }
    link: {
      label: "Data Source - Johns Hopkins State & Country Data"
      url: "https://github.com/CSSEGISandData/COVID-19"
      icon_url: "http://www.google.com/s2/favicons?domain_url=http://www.jhu.edu"
    }
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
    group_label: " Running Total"
    label: "Deaths (Running Total)"
    type: number
    sql:
          {% if jhu_sample_county_level_final.measurement_date._in_query or jhu_sample_county_level_final.days_since_first_outbreak._in_query or jhu_sample_county_level_final.days_since_max_date._in_query %} ${deaths_option_1}
          {% else %}  ${deaths_option_2}
          {% endif %} ;;
    drill_fields: [drill*]
    link: {
      label: "Data Source - NYT County Data"
      url: "https://github.com/nytimes/covid-19-data"
      icon_url: "http://www.google.com/s2/favicons?domain_url=http://www.nytimes.com"
    }
    link: {
      label: "Data Source - Johns Hopkins State & Country Data"
      url: "https://github.com/CSSEGISandData/COVID-19"
      icon_url: "http://www.google.com/s2/favicons?domain_url=http://www.jhu.edu"
    }
  }

  measure: deaths_running_total_per_million {
    group_label: " Running Total"
    label: "Deaths per Million (Running Total)"
    type: number
    sql: 1000000*${deaths_running_total} / nullif(${population_by_county_state_country.sum_population},0) ;;
    value_format_name: decimal_0
    drill_fields: [drill*]
    link: {
      label: "Data Source - NYT County Data"
      url: "https://github.com/nytimes/covid-19-data"
      icon_url: "http://www.google.com/s2/favicons?domain_url=http://www.nytimes.com"
    }
    link: {
      label: "Data Source - Johns Hopkins State & Country Data"
      url: "https://github.com/CSSEGISandData/COVID-19"
      icon_url: "http://www.google.com/s2/favicons?domain_url=http://www.jhu.edu"
    }
  }

  measure: case_fatality_rate {
    group_label: " Rates"
    description: "What percent of infections have resulted in death?"
    type: number
    sql: 1.0 * ${deaths_running_total}/NULLIF(${confirmed_running_total}, 0);;
    value_format_name: percent_1
    drill_fields: [drill*]
    link: {
      label: "Data Source - NYT County Data"
      url: "https://github.com/nytimes/covid-19-data"
      icon_url: "http://www.google.com/s2/favicons?domain_url=http://www.nytimes.com"
    }
    link: {
      label: "Data Source - Johns Hopkins State & Country Data"
      url: "https://github.com/CSSEGISandData/COVID-19"
      icon_url: "http://www.google.com/s2/favicons?domain_url=http://www.jhu.edu"
    }
  }

  measure: min_date {
    hidden: yes
    type: date
    sql: min(${measurement_raw}) ;;
  }

  measure: max_date {
    hidden: yes
    type: date
    sql: max(${measurement_raw}) ;;
  }

  measure: count {
    hidden: yes
    type: count
    drill_fields: []
  }

########################################
## County to PUMA Measure Conversion ###
########################################


#   dimension: base_result {
#     hidden: yes
#     type: number
#     sql: 1 ;;
#   }

  dimension: puma_conversion_factor {
    hidden: yes
    description: "Convert county to zip then zip to PUMA, by population weight respectively"
    type: number
    sql: (${zip_to_county.pct_county_pop_in_zip})*(${zip_to_puma_v2.pct_zip_pop_in_puma}) ;;
  }

  dimension: puma_confirmed_new_cases {
    description: "For zip to PUMA or County weighting"
    hidden: yes
    type: number
    sql: ${confirmed_new_cases}*${puma_conversion_factor} ;;
  }

  measure: puma_confirmed_new {
    group_label: "Measures by Public Use Microdata Area (PUMA)"
    label: "PUMA - Confirmed Cases (New)"
    type: sum_distinct
    sql: ${puma_confirmed_new_cases} ;;
    sql_distinct_key: concat(${pk},${zip_to_county.zip},${zip_to_puma_v2.puma}) ;;
    value_format_name: decimal_0
  }



##############
### Drills ###
##############

  set: drill {
    fields: [
      country_region,
      province_state,
      x,
      confirmed_cases,
      deaths
    ]
  }
}


#         case
#           when (coalesce(lag(confirmed,17) OVER (PARTITION BY combined_key  ORDER BY measurement_date ASC),0) - deaths) < 0 then 0
#           else (coalesce(lag(confirmed,17) OVER (PARTITION BY combined_key  ORDER BY measurement_date ASC),0) - deaths)
#         end
#           as recovered_cumulative,
#         case
#           when
#               (coalesce(lag(confirmed,17) OVER (PARTITION BY combined_key  ORDER BY measurement_date ASC),0) - deaths) -
#               (coalesce(LAG(confirmed, 18) OVER (PARTITION BY combined_key  ORDER BY measurement_date ASC),0) - coalesce(LAG(deaths, 1) OVER (PARTITION BY combined_key  ORDER BY measurement_date ASC),0))
#             < 0 then 0
#           else
#               (coalesce(lag(confirmed,17) OVER (PARTITION BY combined_key  ORDER BY measurement_date ASC),0) - deaths) -
#               (coalesce(LAG(confirmed, 18) OVER (PARTITION BY combined_key  ORDER BY measurement_date ASC),0) - coalesce(LAG(deaths, 1) OVER (PARTITION BY combined_key  ORDER BY measurement_date ASC),0))
#           end
#             as recovered_new_cases


# Note: if you take confirmed cases 17 days ago - deaths today, you can approxiamate recoveries; https://github.com/CSSEGISandData/COVID-19/issues/1250#issuecomment-604485405

# sql_table_name: `lookerdata.covid19.jhu_sample_county_level_final` ;;


#   dimension: recovered_cumulative {
#     hidden: yes
#     type: number
#     sql: ${TABLE}.recovered_cumulative ;;
#   }
#
#   dimension: recovered_new_cases {
#     hidden: yes
#     type: number
#     sql: ${TABLE}.recovered_new_cases ;;
#   }


#   dimension: active_cumulative {
#     hidden: yes
#     type: number
#     sql: ${confirmed_cumulative} - ${recovered_cumulative} - ${deaths_cumulative} ;;
#   }
#
#   dimension: active_new_cases {
#     hidden: yes
#     type: number
#     sql: ${confirmed_new_cases} - ${recovered_new_cases} - ${deaths_new_cases} ;;
#   }
#
#   dimension: closed_cumulative {
#     hidden: yes
#     type: number
#     sql: ${recovered_cumulative} + ${deaths_cumulative} ;;
#   }
#
#   dimension: closed_new_cases {
#     hidden: yes
#     type: number
#     sql: ${recovered_new_cases} + ${deaths_new_cases} ;;
#   }

# measure: recoveries {
#   group_label: " Dynamic"
#   label: "Recoveries"
#   type: number
#   sql:
#         {% if new_vs_running_total._parameter_value == 'new_cases' %} ${recovery_new}
#         {% elsif new_vs_running_total._parameter_value == 'running_total' %} ${recovery_running_total}
#         {% endif %} ;;
#   drill_fields: [drill*]
# }
#
# measure: active_cases {
#   group_label: " Dynamic"
#   label: "Active Cases"
#   type: number
#   sql:
#         {% if new_vs_running_total._parameter_value == 'new_cases' %} ${active_new}
#         {% elsif new_vs_running_total._parameter_value == 'running_total' %} ${active_running_total}
#         {% endif %} ;;
#   drill_fields: [drill*]
# }
#
# measure: closed_cases {
#   group_label: " Dynamic"
#   label: "Closed Cases"
#   type: number
#   sql:
#         {% if new_vs_running_total._parameter_value == 'new_cases' %} ${closed_new}
#         {% elsif new_vs_running_total._parameter_value == 'running_total' %} ${closed_running_total}
#         {% endif %} ;;
#   drill_fields: [drill*]
# }

# measure: recovery_new {
#   group_label: " New Cases"
#   label: "Recoveries (New)"
#   type: sum
#   sql: ${recovered_new_cases} ;;
# }
#
# measure: recovered_option_1 {
#   hidden: yes
#   type: sum
#   sql: ${recovered_cumulative} ;;
# }
#
# measure: recovered_option_2 {
#   hidden: yes
#   type: sum
#   sql: ${recovered_cumulative} ;;
#   filters: {
#     field: is_max_date
#     value: "Yes"
#   }
# }
#
# measure: recovery_running_total {
#   group_label: " Running Total"
#   label: "Recoveries (Running Total)"
#   type: number
#   sql:
#           {% if jhu_sample_county_level_final.measurement_date._in_query or jhu_sample_county_level_final.days_since_first_outbreak._in_query %} ${recovered_option_1}
#           {% else %}  ${recovered_option_2}
#           {% endif %} ;;
# }
#
# measure: active_new {
#   group_label: " New Cases"
#   label: "Active Cases (New)"
#   type: sum
#   sql: ${active_new_cases} ;;
# }
#
# measure: active_option_1 {
#   hidden: yes
#   type: sum
#   sql: ${active_cumulative} ;;
# }
#
# measure: active_option_2 {
#   hidden: yes
#   type: sum
#   sql: ${active_cumulative} ;;
#   filters: {
#     field: is_max_date
#     value: "Yes"
#   }
# }
#
# measure: active_running_total {
#   group_label: " Running Total"
#   label: "Active Cases (Running Total)"
#   type: number
#   sql:
#           {% if jhu_sample_county_level_final.measurement_date._in_query or jhu_sample_county_level_final.days_since_first_outbreak._in_query %} ${active_option_1}
#           {% else %}  ${active_option_2}
#           {% endif %} ;;
# }
#
# measure: closed_new {
#   group_label: " New Cases"
#   label: "Closed Cases (New)"
#   type: sum
#   sql: ${closed_new_cases} ;;
# }
#
# measure: closed_option_1 {
#   hidden: yes
#   type: sum
#   sql: ${closed_cumulative} ;;
# }
#
# measure: closed_option_2 {
#   hidden: yes
#   type: sum
#   sql: ${closed_cumulative} ;;
#   filters: {
#     field: is_max_date
#     value: "Yes"
#   }
# }
#
# measure: closed_running_total {
#   group_label: " Running Total"
#   label: "Closed Cases (Running Total)"
#   type: number
#   sql:
#           {% if jhu_sample_county_level_final.measurement_date._in_query or jhu_sample_county_level_final.days_since_first_outbreak._in_query %} ${closed_option_1}
#           {% else %}  ${closed_option_2}
#           {% endif %} ;;
# }

# measure: active_rate {
#   group_label: " Rates"
#   description: "Of all cases, how many are active?"
#   type: number
#   sql: 1.0 * ${active_running_total} / nullif((${confirmed_running_total}),0);;
#   value_format_name: percent_1
# }
#
# measure: recovery_rate {
#   group_label: " Rates"
#   description: "Of closed cases, how many recovered (vs. died)?"
#   type: number
#   sql: 1.0 * ${recovery_running_total} / NULLIF(${confirmed_running_total}, 0);;
#   value_format_name: percent_1
# }


# view: max_date {
#   derived_table: {
#     datagroup_trigger: covid_data
#     sql:
#         SELECT min(max_date) as max_date
#         FROM
#         (
#           SELECT max(cast(date as date)) as max_date FROM `lookerdata.covid19.nyt_covid_data`
#           UNION ALL
#           SELECT max(cast(date as date)) as max_date FROM `bigquery-public-data.covid19_jhu_csse.summary`
#         ) a
#       ;;
#   }
# }

# view: pre_table {
#   derived_table: {
#     datagroup_trigger: covid_data
#     sql:
#       SELECT
#         a.fips,
#         a.county,
#         a.state as province_state,
#         'US' as country_region,
#         b.lat,
#         b.long,
#         case
#           when a.state is null then 'US'
#           when a.state is not null AND a.county is null then concat(a.state,', US')
#           when a.county is not null then concat(a.county, ', ', a.state, ', US')
#         end as combined_key,
#         date as measurement_date,
#         a.cases as confirmed,
#         a.deaths
#       FROM `lookerdata.covid19.nyt_by_county_data` a
#       LEFT JOIN (SELECT fips, lat, long, count(*) as count FROM `lookerdata.covid19.jhu_sample_county_level_final` WHERE fips is not null GROUP BY 1,2,3) b
#         ON a.fips = b.fips
#       LEFT JOIN ${max_date.SQL_TABLE_NAME} c
#         ON 1 = 1
#       WHERE cast(a.date as date) <= cast(c.max_date as date)
#
#       UNION ALL
#
#       SELECT
#         NULL as fips,
#         NULL as county,
#         province_state,
#         country_region,
#         latitude,
#         longitude,
#         case
#           when province_state is null then country_region
#           when province_state is not null AND country_region is null then concat(province_state,', ',country_region)
#         end as combined_key,
#         cast(date as date) as measurement_date,
#         confirmed,
#         deaths
#       FROM `bigquery-public-data.covid19_jhu_csse.summary` a
#       LEFT JOIN ${max_date.SQL_TABLE_NAME} c
#         ON 1 = 1
#       WHERE country_region <> 'US'
#       AND cast(a.date as date) <= cast(c.max_date as date)
#     ;;
#   }
# }
