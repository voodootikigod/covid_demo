####################
### Max Dates
####################

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

####################
### Ranks
####################

view: country_rank {
  derived_table: {
    explore_source: jhu_sample_county_level_final {
      bind_all_filters: yes
      column: country_raw {}
      column: confirmed_running_total {}
      derived_column: rank {
        sql: row_number() OVER (PARTITION BY 'X' ORDER BY confirmed_running_total desc) ;;
      }
    }
  }
  dimension: country_raw { primary_key: yes hidden: yes }
  dimension: rank { hidden: yes type: number }
}

view: state_rank {
  derived_table: {
    explore_source: jhu_sample_county_level_final {
      bind_all_filters: yes
      column: province_state {}
      column: confirmed_running_total {}
      derived_column: rank {
        sql: row_number() OVER (PARTITION BY 'X' ORDER BY confirmed_running_total desc) ;;
      }
      filters: {
        field: jhu_sample_county_level_final.country_raw
        value: "US"
      }
    }
  }
  dimension: province_state { primary_key: yes hidden: yes }
  dimension: rank { hidden: yes type: number }
}

view: fips_rank {
  derived_table: {
    explore_source: jhu_sample_county_level_final {
      bind_all_filters: yes
      column: fips {}
      column: confirmed_running_total {}
      derived_column: rank {
        sql: row_number() OVER (PARTITION BY 'X' ORDER BY confirmed_running_total desc) ;;
      }
      filters: {
        field: jhu_sample_county_level_final.country_raw
        value: "US"
      }
    }
  }
  dimension: fips { primary_key: yes hidden: yes }
  dimension: rank { hidden: yes type: number }
}


####################
### Growth Rate / Days to Double
####################

view: prior_days_cases_covid {
  view_label: "Trends"
  derived_table: {
    datagroup_trigger: covid_data
    explore_source: jhu_sample_county_level_final {
      column: measurement_date {}
      column: pre_pk {}
      column: confirmed_running_total {}
      column: deaths_running_total {}
      column: confirmed_new {}
      column: deaths_new {}
      column: confirmed_running_total_per_million {}
      column: deaths_running_total_per_million {}
      column: confirmed_new_per_million {}
      column: deaths_new_per_million {}

      derived_column: prior_1_days_confirmed_running_total {sql: coalesce (max (${confirmed_running_total}) OVER (PARTITION BY ${pre_pk} ORDER BY ${measurement_date} asc ROWS BETWEEN 2 PRECEDING and 1 PRECEDING),0) ;;}
      derived_column: prior_2_days_confirmed_running_total {sql: coalesce (max (${confirmed_running_total}) OVER (PARTITION BY ${pre_pk} ORDER BY ${measurement_date} asc ROWS BETWEEN 3 PRECEDING and 2 PRECEDING),0) ;;}
      derived_column: prior_3_days_confirmed_running_total {sql: coalesce (max (${confirmed_running_total}) OVER (PARTITION BY ${pre_pk} ORDER BY ${measurement_date} asc ROWS BETWEEN 4 PRECEDING and 3 PRECEDING),0) ;;}
      derived_column: prior_4_days_confirmed_running_total {sql: coalesce (max (${confirmed_running_total}) OVER (PARTITION BY ${pre_pk} ORDER BY ${measurement_date} asc ROWS BETWEEN 5 PRECEDING and 4 PRECEDING),0) ;;}
      derived_column: prior_5_days_confirmed_running_total {sql: coalesce (max (${confirmed_running_total}) OVER (PARTITION BY ${pre_pk} ORDER BY ${measurement_date} asc ROWS BETWEEN 6 PRECEDING and 5 PRECEDING),0) ;;}
      derived_column: prior_6_days_confirmed_running_total {sql: coalesce (max (${confirmed_running_total}) OVER (PARTITION BY ${pre_pk} ORDER BY ${measurement_date} asc ROWS BETWEEN 7 PRECEDING and 6 PRECEDING),0) ;;}
      derived_column: prior_7_days_confirmed_running_total {sql: coalesce (max (${confirmed_running_total}) OVER (PARTITION BY ${pre_pk} ORDER BY ${measurement_date} asc ROWS BETWEEN 8 PRECEDING and 7 PRECEDING),0) ;;}

      derived_column: prior_1_days_deaths_running_total {sql: coalesce (max (${deaths_running_total}) OVER (PARTITION BY ${pre_pk} ORDER BY ${measurement_date} asc ROWS BETWEEN 2 PRECEDING and 1 PRECEDING),0) ;;}
      derived_column: prior_2_days_deaths_running_total {sql: coalesce (max (${deaths_running_total}) OVER (PARTITION BY ${pre_pk} ORDER BY ${measurement_date} asc ROWS BETWEEN 3 PRECEDING and 2 PRECEDING),0) ;;}
      derived_column: prior_3_days_deaths_running_total {sql: coalesce (max (${deaths_running_total}) OVER (PARTITION BY ${pre_pk} ORDER BY ${measurement_date} asc ROWS BETWEEN 4 PRECEDING and 3 PRECEDING),0) ;;}
      derived_column: prior_4_days_deaths_running_total {sql: coalesce (max (${deaths_running_total}) OVER (PARTITION BY ${pre_pk} ORDER BY ${measurement_date} asc ROWS BETWEEN 5 PRECEDING and 4 PRECEDING),0) ;;}
      derived_column: prior_5_days_deaths_running_total {sql: coalesce (max (${deaths_running_total}) OVER (PARTITION BY ${pre_pk} ORDER BY ${measurement_date} asc ROWS BETWEEN 6 PRECEDING and 5 PRECEDING),0) ;;}
      derived_column: prior_6_days_deaths_running_total {sql: coalesce (max (${deaths_running_total}) OVER (PARTITION BY ${pre_pk} ORDER BY ${measurement_date} asc ROWS BETWEEN 7 PRECEDING and 6 PRECEDING),0) ;;}
      derived_column: prior_7_days_deaths_running_total {sql: coalesce (max (${deaths_running_total}) OVER (PARTITION BY ${pre_pk} ORDER BY ${measurement_date} asc ROWS BETWEEN 8 PRECEDING and 7 PRECEDING),0) ;;}

      derived_column: prior_1_days_confirmed_new {sql: coalesce (max (${confirmed_new}) OVER (PARTITION BY ${pre_pk} ORDER BY ${measurement_date} asc ROWS BETWEEN 2 PRECEDING and 1 PRECEDING),0) ;;}
      derived_column: prior_2_days_confirmed_new {sql: coalesce (max (${confirmed_new}) OVER (PARTITION BY ${pre_pk} ORDER BY ${measurement_date} asc ROWS BETWEEN 3 PRECEDING and 2 PRECEDING),0) ;;}
      derived_column: prior_3_days_confirmed_new {sql: coalesce (max (${confirmed_new}) OVER (PARTITION BY ${pre_pk} ORDER BY ${measurement_date} asc ROWS BETWEEN 4 PRECEDING and 3 PRECEDING),0) ;;}
      derived_column: prior_4_days_confirmed_new {sql: coalesce (max (${confirmed_new}) OVER (PARTITION BY ${pre_pk} ORDER BY ${measurement_date} asc ROWS BETWEEN 5 PRECEDING and 4 PRECEDING),0) ;;}
      derived_column: prior_5_days_confirmed_new {sql: coalesce (max (${confirmed_new}) OVER (PARTITION BY ${pre_pk} ORDER BY ${measurement_date} asc ROWS BETWEEN 6 PRECEDING and 5 PRECEDING),0) ;;}
      derived_column: prior_6_days_confirmed_new {sql: coalesce (max (${confirmed_new}) OVER (PARTITION BY ${pre_pk} ORDER BY ${measurement_date} asc ROWS BETWEEN 7 PRECEDING and 6 PRECEDING),0) ;;}
      derived_column: prior_7_days_confirmed_new {sql: coalesce (max (${confirmed_new}) OVER (PARTITION BY ${pre_pk} ORDER BY ${measurement_date} asc ROWS BETWEEN 8 PRECEDING and 7 PRECEDING),0) ;;}

      derived_column: prior_1_days_deaths_new {sql: coalesce (max (${deaths_new}) OVER (PARTITION BY ${pre_pk} ORDER BY ${measurement_date} asc ROWS BETWEEN 2 PRECEDING and 1 PRECEDING),0) ;;}
      derived_column: prior_2_days_deaths_new {sql: coalesce (max (${deaths_new}) OVER (PARTITION BY ${pre_pk} ORDER BY ${measurement_date} asc ROWS BETWEEN 3 PRECEDING and 2 PRECEDING),0) ;;}
      derived_column: prior_3_days_deaths_new {sql: coalesce (max (${deaths_new}) OVER (PARTITION BY ${pre_pk} ORDER BY ${measurement_date} asc ROWS BETWEEN 4 PRECEDING and 3 PRECEDING),0) ;;}
      derived_column: prior_4_days_deaths_new {sql: coalesce (max (${deaths_new}) OVER (PARTITION BY ${pre_pk} ORDER BY ${measurement_date} asc ROWS BETWEEN 5 PRECEDING and 4 PRECEDING),0) ;;}
      derived_column: prior_5_days_deaths_new {sql: coalesce (max (${deaths_new}) OVER (PARTITION BY ${pre_pk} ORDER BY ${measurement_date} asc ROWS BETWEEN 6 PRECEDING and 5 PRECEDING),0) ;;}
      derived_column: prior_6_days_deaths_new {sql: coalesce (max (${deaths_new}) OVER (PARTITION BY ${pre_pk} ORDER BY ${measurement_date} asc ROWS BETWEEN 7 PRECEDING and 6 PRECEDING),0) ;;}
      derived_column: prior_7_days_deaths_new {sql: coalesce (max (${deaths_new}) OVER (PARTITION BY ${pre_pk} ORDER BY ${measurement_date} asc ROWS BETWEEN 8 PRECEDING and 7 PRECEDING),0) ;;}

      derived_column: prior_1_days_confirmed_running_total_per_million {sql: coalesce (max (${confirmed_running_total_per_million}) OVER (PARTITION BY ${pre_pk} ORDER BY ${measurement_date} asc ROWS BETWEEN 2 PRECEDING and 1 PRECEDING),0) ;;}
      derived_column: prior_2_days_confirmed_running_total_per_million {sql: coalesce (max (${confirmed_running_total_per_million}) OVER (PARTITION BY ${pre_pk} ORDER BY ${measurement_date} asc ROWS BETWEEN 3 PRECEDING and 2 PRECEDING),0) ;;}
      derived_column: prior_3_days_confirmed_running_total_per_million {sql: coalesce (max (${confirmed_running_total_per_million}) OVER (PARTITION BY ${pre_pk} ORDER BY ${measurement_date} asc ROWS BETWEEN 4 PRECEDING and 3 PRECEDING),0) ;;}
      derived_column: prior_4_days_confirmed_running_total_per_million {sql: coalesce (max (${confirmed_running_total_per_million}) OVER (PARTITION BY ${pre_pk} ORDER BY ${measurement_date} asc ROWS BETWEEN 5 PRECEDING and 4 PRECEDING),0) ;;}
      derived_column: prior_5_days_confirmed_running_total_per_million {sql: coalesce (max (${confirmed_running_total_per_million}) OVER (PARTITION BY ${pre_pk} ORDER BY ${measurement_date} asc ROWS BETWEEN 6 PRECEDING and 5 PRECEDING),0) ;;}
      derived_column: prior_6_days_confirmed_running_total_per_million {sql: coalesce (max (${confirmed_running_total_per_million}) OVER (PARTITION BY ${pre_pk} ORDER BY ${measurement_date} asc ROWS BETWEEN 7 PRECEDING and 6 PRECEDING),0) ;;}
      derived_column: prior_7_days_confirmed_running_total_per_million {sql: coalesce (max (${confirmed_running_total_per_million}) OVER (PARTITION BY ${pre_pk} ORDER BY ${measurement_date} asc ROWS BETWEEN 8 PRECEDING and 7 PRECEDING),0) ;;}

      derived_column: prior_1_days_deaths_running_total_per_million {sql: coalesce (max (${deaths_running_total_per_million}) OVER (PARTITION BY ${pre_pk} ORDER BY ${measurement_date} asc ROWS BETWEEN 2 PRECEDING and 1 PRECEDING),0) ;;}
      derived_column: prior_2_days_deaths_running_total_per_million {sql: coalesce (max (${deaths_running_total_per_million}) OVER (PARTITION BY ${pre_pk} ORDER BY ${measurement_date} asc ROWS BETWEEN 3 PRECEDING and 2 PRECEDING),0) ;;}
      derived_column: prior_3_days_deaths_running_total_per_million {sql: coalesce (max (${deaths_running_total_per_million}) OVER (PARTITION BY ${pre_pk} ORDER BY ${measurement_date} asc ROWS BETWEEN 4 PRECEDING and 3 PRECEDING),0) ;;}
      derived_column: prior_4_days_deaths_running_total_per_million {sql: coalesce (max (${deaths_running_total_per_million}) OVER (PARTITION BY ${pre_pk} ORDER BY ${measurement_date} asc ROWS BETWEEN 5 PRECEDING and 4 PRECEDING),0) ;;}
      derived_column: prior_5_days_deaths_running_total_per_million {sql: coalesce (max (${deaths_running_total_per_million}) OVER (PARTITION BY ${pre_pk} ORDER BY ${measurement_date} asc ROWS BETWEEN 6 PRECEDING and 5 PRECEDING),0) ;;}
      derived_column: prior_6_days_deaths_running_total_per_million {sql: coalesce (max (${deaths_running_total_per_million}) OVER (PARTITION BY ${pre_pk} ORDER BY ${measurement_date} asc ROWS BETWEEN 7 PRECEDING and 6 PRECEDING),0) ;;}
      derived_column: prior_7_days_deaths_running_total_per_million {sql: coalesce (max (${deaths_running_total_per_million}) OVER (PARTITION BY ${pre_pk} ORDER BY ${measurement_date} asc ROWS BETWEEN 8 PRECEDING and 7 PRECEDING),0) ;;}

      derived_column: prior_1_days_confirmed_new_per_million {sql: coalesce (max (${confirmed_new_per_million}) OVER (PARTITION BY ${pre_pk} ORDER BY ${measurement_date} asc ROWS BETWEEN 2 PRECEDING and 1 PRECEDING),0) ;;}
      derived_column: prior_2_days_confirmed_new_per_million {sql: coalesce (max (${confirmed_new_per_million}) OVER (PARTITION BY ${pre_pk} ORDER BY ${measurement_date} asc ROWS BETWEEN 3 PRECEDING and 2 PRECEDING),0) ;;}
      derived_column: prior_3_days_confirmed_new_per_million {sql: coalesce (max (${confirmed_new_per_million}) OVER (PARTITION BY ${pre_pk} ORDER BY ${measurement_date} asc ROWS BETWEEN 4 PRECEDING and 3 PRECEDING),0) ;;}
      derived_column: prior_4_days_confirmed_new_per_million {sql: coalesce (max (${confirmed_new_per_million}) OVER (PARTITION BY ${pre_pk} ORDER BY ${measurement_date} asc ROWS BETWEEN 5 PRECEDING and 4 PRECEDING),0) ;;}
      derived_column: prior_5_days_confirmed_new_per_million {sql: coalesce (max (${confirmed_new_per_million}) OVER (PARTITION BY ${pre_pk} ORDER BY ${measurement_date} asc ROWS BETWEEN 6 PRECEDING and 5 PRECEDING),0) ;;}
      derived_column: prior_6_days_confirmed_new_per_million {sql: coalesce (max (${confirmed_new_per_million}) OVER (PARTITION BY ${pre_pk} ORDER BY ${measurement_date} asc ROWS BETWEEN 7 PRECEDING and 6 PRECEDING),0) ;;}
      derived_column: prior_7_days_confirmed_new_per_million {sql: coalesce (max (${confirmed_new_per_million}) OVER (PARTITION BY ${pre_pk} ORDER BY ${measurement_date} asc ROWS BETWEEN 8 PRECEDING and 7 PRECEDING),0) ;;}

      derived_column: prior_1_days_deaths_new_per_million {sql: coalesce (max (${deaths_new_per_million}) OVER (PARTITION BY ${pre_pk} ORDER BY ${measurement_date} asc ROWS BETWEEN 2 PRECEDING and 1 PRECEDING),0) ;;}
      derived_column: prior_2_days_deaths_new_per_million {sql: coalesce (max (${deaths_new_per_million}) OVER (PARTITION BY ${pre_pk} ORDER BY ${measurement_date} asc ROWS BETWEEN 3 PRECEDING and 2 PRECEDING),0) ;;}
      derived_column: prior_3_days_deaths_new_per_million {sql: coalesce (max (${deaths_new_per_million}) OVER (PARTITION BY ${pre_pk} ORDER BY ${measurement_date} asc ROWS BETWEEN 4 PRECEDING and 3 PRECEDING),0) ;;}
      derived_column: prior_4_days_deaths_new_per_million {sql: coalesce (max (${deaths_new_per_million}) OVER (PARTITION BY ${pre_pk} ORDER BY ${measurement_date} asc ROWS BETWEEN 5 PRECEDING and 4 PRECEDING),0) ;;}
      derived_column: prior_5_days_deaths_new_per_million {sql: coalesce (max (${deaths_new_per_million}) OVER (PARTITION BY ${pre_pk} ORDER BY ${measurement_date} asc ROWS BETWEEN 6 PRECEDING and 5 PRECEDING),0) ;;}
      derived_column: prior_6_days_deaths_new_per_million {sql: coalesce (max (${deaths_new_per_million}) OVER (PARTITION BY ${pre_pk} ORDER BY ${measurement_date} asc ROWS BETWEEN 7 PRECEDING and 6 PRECEDING),0) ;;}
      derived_column: prior_7_days_deaths_new_per_million {sql: coalesce (max (${deaths_new_per_million}) OVER (PARTITION BY ${pre_pk} ORDER BY ${measurement_date} asc ROWS BETWEEN 8 PRECEDING and 7 PRECEDING),0) ;;}

    }
  }

  dimension: pk {
    primary_key: yes
    hidden: yes
    type: string
    sql: concat(${pre_pk},${measurement_date}) ;;
  }

  dimension: measurement_date {
    type: date
    hidden:yes
  }
  dimension: pre_pk { hidden:yes}

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

  dimension: prior_1_days_confirmed_new {type:number hidden:yes}
  dimension: prior_2_days_confirmed_new {type:number hidden:yes}
  dimension: prior_3_days_confirmed_new {type:number hidden:yes}
  dimension: prior_4_days_confirmed_new {type:number hidden:yes}
  dimension: prior_5_days_confirmed_new {type:number hidden:yes}
  dimension: prior_6_days_confirmed_new {type:number hidden:yes}
  dimension: prior_7_days_confirmed_new {type:number hidden:yes}

  dimension: prior_1_days_deaths_new {type:number hidden:yes}
  dimension: prior_2_days_deaths_new {type:number hidden:yes}
  dimension: prior_3_days_deaths_new {type:number hidden:yes}
  dimension: prior_4_days_deaths_new {type:number hidden:yes}
  dimension: prior_5_days_deaths_new {type:number hidden:yes}
  dimension: prior_6_days_deaths_new {type:number hidden:yes}
  dimension: prior_7_days_deaths_new {type:number hidden:yes}

  dimension: prior_1_days_confirmed_running_total_per_million {type:number hidden:yes}
  dimension: prior_2_days_confirmed_running_total_per_million {type:number hidden:yes}
  dimension: prior_3_days_confirmed_running_total_per_million {type:number hidden:yes}
  dimension: prior_4_days_confirmed_running_total_per_million {type:number hidden:yes}
  dimension: prior_5_days_confirmed_running_total_per_million {type:number hidden:yes}
  dimension: prior_6_days_confirmed_running_total_per_million {type:number hidden:yes}
  dimension: prior_7_days_confirmed_running_total_per_million {type:number hidden:yes}

  dimension: prior_1_days_deaths_running_total_per_million {type:number hidden:yes}
  dimension: prior_2_days_deaths_running_total_per_million {type:number hidden:yes}
  dimension: prior_3_days_deaths_running_total_per_million {type:number hidden:yes}
  dimension: prior_4_days_deaths_running_total_per_million {type:number hidden:yes}
  dimension: prior_5_days_deaths_running_total_per_million {type:number hidden:yes}
  dimension: prior_6_days_deaths_running_total_per_million {type:number hidden:yes}
  dimension: prior_7_days_deaths_running_total_per_million {type:number hidden:yes}

  dimension: prior_1_days_confirmed_new_per_million {type:number hidden:yes}
  dimension: prior_2_days_confirmed_new_per_million {type:number hidden:yes}
  dimension: prior_3_days_confirmed_new_per_million {type:number hidden:yes}
  dimension: prior_4_days_confirmed_new_per_million {type:number hidden:yes}
  dimension: prior_5_days_confirmed_new_per_million {type:number hidden:yes}
  dimension: prior_6_days_confirmed_new_per_million {type:number hidden:yes}
  dimension: prior_7_days_confirmed_new_per_million {type:number hidden:yes}

  dimension: prior_1_days_deaths_new_per_million {type:number hidden:yes}
  dimension: prior_2_days_deaths_new_per_million {type:number hidden:yes}
  dimension: prior_3_days_deaths_new_per_million {type:number hidden:yes}
  dimension: prior_4_days_deaths_new_per_million {type:number hidden:yes}
  dimension: prior_5_days_deaths_new_per_million {type:number hidden:yes}
  dimension: prior_6_days_deaths_new_per_million {type:number hidden:yes}
  dimension: prior_7_days_deaths_new_per_million {type:number hidden:yes}


  #All of these metrics require having date selected, or filtered to a single date.
  measure: sum_prior_1_days_confirmed_running_total { type:sum hidden:yes sql: ${prior_1_days_confirmed_running_total};;}
  measure: sum_prior_2_days_confirmed_running_total { type:sum hidden:yes sql: ${prior_2_days_confirmed_running_total};;}
  measure: sum_prior_3_days_confirmed_running_total { type:sum hidden:yes sql: ${prior_3_days_confirmed_running_total};;}
  measure: sum_prior_4_days_confirmed_running_total { type:sum hidden:yes sql: ${prior_4_days_confirmed_running_total};;}
  measure: sum_prior_5_days_confirmed_running_total { type:sum hidden:yes sql: ${prior_5_days_confirmed_running_total};;}
  measure: sum_prior_6_days_confirmed_running_total { type:sum hidden:yes sql: ${prior_6_days_confirmed_running_total};;}
  measure: sum_prior_7_days_confirmed_running_total { type:sum hidden:yes sql: ${prior_7_days_confirmed_running_total};;}

  measure: sum_prior_1_days_deaths_running_total { type:sum hidden:yes sql: ${prior_1_days_deaths_running_total};;}
  measure: sum_prior_2_days_deaths_running_total { type:sum hidden:yes sql: ${prior_2_days_deaths_running_total};;}
  measure: sum_prior_3_days_deaths_running_total { type:sum hidden:yes sql: ${prior_3_days_deaths_running_total};;}
  measure: sum_prior_4_days_deaths_running_total { type:sum hidden:yes sql: ${prior_4_days_deaths_running_total};;}
  measure: sum_prior_5_days_deaths_running_total { type:sum hidden:yes sql: ${prior_5_days_deaths_running_total};;}
  measure: sum_prior_6_days_deaths_running_total { type:sum hidden:yes sql: ${prior_6_days_deaths_running_total};;}
  measure: sum_prior_7_days_deaths_running_total { type:sum hidden:yes sql: ${prior_7_days_deaths_running_total};;}

  measure: sum_prior_1_days_confirmed_new { type:sum hidden:yes sql: ${prior_1_days_confirmed_new};;}
  measure: sum_prior_2_days_confirmed_new { type:sum hidden:yes sql: ${prior_2_days_confirmed_new};;}
  measure: sum_prior_3_days_confirmed_new { type:sum hidden:yes sql: ${prior_3_days_confirmed_new};;}
  measure: sum_prior_4_days_confirmed_new { type:sum hidden:yes sql: ${prior_4_days_confirmed_new};;}
  measure: sum_prior_5_days_confirmed_new { type:sum hidden:yes sql: ${prior_5_days_confirmed_new};;}
  measure: sum_prior_6_days_confirmed_new { type:sum hidden:yes sql: ${prior_6_days_confirmed_new};;}
  measure: sum_prior_7_days_confirmed_new { type:sum hidden:yes sql: ${prior_7_days_confirmed_new};;}

  measure: sum_prior_1_days_deaths_new { type:sum hidden:yes sql: ${prior_1_days_deaths_new};;}
  measure: sum_prior_2_days_deaths_new { type:sum hidden:yes sql: ${prior_2_days_deaths_new};;}
  measure: sum_prior_3_days_deaths_new { type:sum hidden:yes sql: ${prior_3_days_deaths_new};;}
  measure: sum_prior_4_days_deaths_new { type:sum hidden:yes sql: ${prior_4_days_deaths_new};;}
  measure: sum_prior_5_days_deaths_new { type:sum hidden:yes sql: ${prior_5_days_deaths_new};;}
  measure: sum_prior_6_days_deaths_new { type:sum hidden:yes sql: ${prior_6_days_deaths_new};;}
  measure: sum_prior_7_days_deaths_new { type:sum hidden:yes sql: ${prior_7_days_deaths_new};;}

  measure: sum_prior_1_days_confirmed_running_total_per_million { type:sum hidden:yes sql: ${prior_1_days_confirmed_running_total_per_million};;}
  measure: sum_prior_2_days_confirmed_running_total_per_million { type:sum hidden:yes sql: ${prior_2_days_confirmed_running_total_per_million};;}
  measure: sum_prior_3_days_confirmed_running_total_per_million { type:sum hidden:yes sql: ${prior_3_days_confirmed_running_total_per_million};;}
  measure: sum_prior_4_days_confirmed_running_total_per_million { type:sum hidden:yes sql: ${prior_4_days_confirmed_running_total_per_million};;}
  measure: sum_prior_5_days_confirmed_running_total_per_million { type:sum hidden:yes sql: ${prior_5_days_confirmed_running_total_per_million};;}
  measure: sum_prior_6_days_confirmed_running_total_per_million { type:sum hidden:yes sql: ${prior_6_days_confirmed_running_total_per_million};;}
  measure: sum_prior_7_days_confirmed_running_total_per_million { type:sum hidden:yes sql: ${prior_7_days_confirmed_running_total_per_million};;}

  measure: sum_prior_1_days_deaths_running_total_per_million { type:sum hidden:yes sql: ${prior_1_days_deaths_running_total_per_million};;}
  measure: sum_prior_2_days_deaths_running_total_per_million { type:sum hidden:yes sql: ${prior_2_days_deaths_running_total_per_million};;}
  measure: sum_prior_3_days_deaths_running_total_per_million { type:sum hidden:yes sql: ${prior_3_days_deaths_running_total_per_million};;}
  measure: sum_prior_4_days_deaths_running_total_per_million { type:sum hidden:yes sql: ${prior_4_days_deaths_running_total_per_million};;}
  measure: sum_prior_5_days_deaths_running_total_per_million { type:sum hidden:yes sql: ${prior_5_days_deaths_running_total_per_million};;}
  measure: sum_prior_6_days_deaths_running_total_per_million { type:sum hidden:yes sql: ${prior_6_days_deaths_running_total_per_million};;}
  measure: sum_prior_7_days_deaths_running_total_per_million { type:sum hidden:yes sql: ${prior_7_days_deaths_running_total_per_million};;}

  measure: sum_prior_1_days_confirmed_new_per_million { type:sum hidden:yes sql: ${prior_1_days_confirmed_new_per_million};;}
  measure: sum_prior_2_days_confirmed_new_per_million { type:sum hidden:yes sql: ${prior_2_days_confirmed_new_per_million};;}
  measure: sum_prior_3_days_confirmed_new_per_million { type:sum hidden:yes sql: ${prior_3_days_confirmed_new_per_million};;}
  measure: sum_prior_4_days_confirmed_new_per_million { type:sum hidden:yes sql: ${prior_4_days_confirmed_new_per_million};;}
  measure: sum_prior_5_days_confirmed_new_per_million { type:sum hidden:yes sql: ${prior_5_days_confirmed_new_per_million};;}
  measure: sum_prior_6_days_confirmed_new_per_million { type:sum hidden:yes sql: ${prior_6_days_confirmed_new_per_million};;}
  measure: sum_prior_7_days_confirmed_new_per_million { type:sum hidden:yes sql: ${prior_7_days_confirmed_new_per_million};;}

  measure: sum_prior_1_days_deaths_new_per_million { type:sum hidden:yes sql: ${prior_1_days_deaths_new_per_million};;}
  measure: sum_prior_2_days_deaths_new_per_million { type:sum hidden:yes sql: ${prior_2_days_deaths_new_per_million};;}
  measure: sum_prior_3_days_deaths_new_per_million { type:sum hidden:yes sql: ${prior_3_days_deaths_new_per_million};;}
  measure: sum_prior_4_days_deaths_new_per_million { type:sum hidden:yes sql: ${prior_4_days_deaths_new_per_million};;}
  measure: sum_prior_5_days_deaths_new_per_million { type:sum hidden:yes sql: ${prior_5_days_deaths_new_per_million};;}
  measure: sum_prior_6_days_deaths_new_per_million { type:sum hidden:yes sql: ${prior_6_days_deaths_new_per_million};;}
  measure: sum_prior_7_days_deaths_new_per_million { type:sum hidden:yes sql: ${prior_7_days_deaths_new_per_million};;}

  measure: seven_day_average_change_rate_confirmed_cases_running_total {
    group_label: "Advanced Analytics"
    label: "Confirmed Cases Running Total (7 Day Average Change)"
    type: number
    value_format_name: percent_1
    sql:
        (
            ((${jhu_sample_county_level_final.confirmed_running_total}    - ${sum_prior_1_days_confirmed_running_total}) / NULLIF(${sum_prior_1_days_confirmed_running_total},0))*7.0
          + ((${sum_prior_1_days_confirmed_running_total}                 - ${sum_prior_2_days_confirmed_running_total}) / NULLIF(${sum_prior_2_days_confirmed_running_total},0))*6.0
          + ((${sum_prior_2_days_confirmed_running_total}                 - ${sum_prior_3_days_confirmed_running_total}) / NULLIF(${sum_prior_3_days_confirmed_running_total},0))*5.0
          + ((${sum_prior_3_days_confirmed_running_total}                 - ${sum_prior_4_days_confirmed_running_total}) / NULLIF(${sum_prior_4_days_confirmed_running_total},0))*4.0
          + ((${sum_prior_4_days_confirmed_running_total}                 - ${sum_prior_5_days_confirmed_running_total}) / NULLIF(${sum_prior_5_days_confirmed_running_total},0))*3.0
          + ((${sum_prior_5_days_confirmed_running_total}                 - ${sum_prior_6_days_confirmed_running_total}) / NULLIF(${sum_prior_6_days_confirmed_running_total},0))*2.0
          + ((${sum_prior_6_days_confirmed_running_total}                 - ${sum_prior_7_days_confirmed_running_total}) / NULLIF(${sum_prior_7_days_confirmed_running_total},0))
        )/28.0;;
  }

  measure: seven_day_average_change_rate_deaths_running_total {
    group_label: "Advanced Analytics"
    label: "Deaths Running Total (7 Day Average Change)"
    type: number
    value_format_name: percent_1
    sql:
        (
            ((${jhu_sample_county_level_final.deaths_running_total}   - ${sum_prior_1_days_deaths_running_total}) / NULLIF(${sum_prior_1_days_deaths_running_total},0))*7.0
          + ((${sum_prior_1_days_deaths_running_total}                - ${sum_prior_2_days_deaths_running_total}) / NULLIF(${sum_prior_2_days_deaths_running_total},0))*6.0
          + ((${sum_prior_2_days_deaths_running_total}                - ${sum_prior_3_days_deaths_running_total}) / NULLIF(${sum_prior_3_days_deaths_running_total},0))*5.0
          + ((${sum_prior_3_days_deaths_running_total}                - ${sum_prior_4_days_deaths_running_total}) / NULLIF(${sum_prior_4_days_deaths_running_total},0))*4.0
          + ((${sum_prior_4_days_deaths_running_total}                - ${sum_prior_5_days_deaths_running_total}) / NULLIF(${sum_prior_5_days_deaths_running_total},0))*3.0
          + ((${sum_prior_5_days_deaths_running_total}                - ${sum_prior_6_days_deaths_running_total}) / NULLIF(${sum_prior_6_days_deaths_running_total},0))*2.0
          + ((${sum_prior_6_days_deaths_running_total}                - ${sum_prior_7_days_deaths_running_total}) / NULLIF(${sum_prior_7_days_deaths_running_total},0))
        )/28.0;;
  }

  measure: seven_day_average_change_rate_confirmed_cases_new {
    group_label: "Advanced Analytics"
    label: "Confirmed Cases New (7 Day Average Change)"
    type: number
    value_format_name: percent_1
    sql:
        (
            ((${jhu_sample_county_level_final.confirmed_new}    - ${sum_prior_1_days_confirmed_new}) / NULLIF(${sum_prior_1_days_confirmed_new},0))*7.0
          + ((${sum_prior_1_days_confirmed_new}                 - ${sum_prior_2_days_confirmed_new}) / NULLIF(${sum_prior_2_days_confirmed_new},0))*6.0
          + ((${sum_prior_2_days_confirmed_new}                 - ${sum_prior_3_days_confirmed_new}) / NULLIF(${sum_prior_3_days_confirmed_new},0))*5.0
          + ((${sum_prior_3_days_confirmed_new}                 - ${sum_prior_4_days_confirmed_new}) / NULLIF(${sum_prior_4_days_confirmed_new},0))*4.0
          + ((${sum_prior_4_days_confirmed_new}                 - ${sum_prior_5_days_confirmed_new}) / NULLIF(${sum_prior_5_days_confirmed_new},0))*3.0
          + ((${sum_prior_5_days_confirmed_new}                 - ${sum_prior_6_days_confirmed_new}) / NULLIF(${sum_prior_6_days_confirmed_new},0))*2.0
          + ((${sum_prior_6_days_confirmed_new}                 - ${sum_prior_7_days_confirmed_new}) / NULLIF(${sum_prior_7_days_confirmed_new},0))
        )/28.0;;
  }

  measure: seven_day_average_change_rate_deaths_new {
    group_label: "Advanced Analytics"
    label: "Deaths New (7 Day Average Change)"
    type: number
    value_format_name: percent_1
    sql:
        (
            ((${jhu_sample_county_level_final.deaths_new}   - ${sum_prior_1_days_deaths_new}) / NULLIF(${sum_prior_1_days_deaths_new},0))*7.0
          + ((${sum_prior_1_days_deaths_new}                - ${sum_prior_2_days_deaths_new}) / NULLIF(${sum_prior_2_days_deaths_new},0))*6.0
          + ((${sum_prior_2_days_deaths_new}                - ${sum_prior_3_days_deaths_new}) / NULLIF(${sum_prior_3_days_deaths_new},0))*5.0
          + ((${sum_prior_3_days_deaths_new}                - ${sum_prior_4_days_deaths_new}) / NULLIF(${sum_prior_4_days_deaths_new},0))*4.0
          + ((${sum_prior_4_days_deaths_new}                - ${sum_prior_5_days_deaths_new}) / NULLIF(${sum_prior_5_days_deaths_new},0))*3.0
          + ((${sum_prior_5_days_deaths_new}                - ${sum_prior_6_days_deaths_new}) / NULLIF(${sum_prior_6_days_deaths_new},0))*2.0
          + ((${sum_prior_6_days_deaths_new}                - ${sum_prior_7_days_deaths_new}) / NULLIF(${sum_prior_7_days_deaths_new},0))
        )/28.0;;
  }

  measure: seven_day_average_change_rate_confirmed_cases_running_total_per_million {
    group_label: "Advanced Analytics"
    label: "Confirmed Cases Running Total per Million (7 Day Average Change)"
    type: number
    value_format_name: percent_1
    sql:
        (
            ((${jhu_sample_county_level_final.confirmed_running_total_per_million}    - ${sum_prior_1_days_confirmed_running_total_per_million}) / NULLIF(${sum_prior_1_days_confirmed_running_total_per_million},0))*7.0
          + ((${sum_prior_1_days_confirmed_running_total_per_million}                 - ${sum_prior_2_days_confirmed_running_total_per_million}) / NULLIF(${sum_prior_2_days_confirmed_running_total_per_million},0))*6.0
          + ((${sum_prior_2_days_confirmed_running_total_per_million}                 - ${sum_prior_3_days_confirmed_running_total_per_million}) / NULLIF(${sum_prior_3_days_confirmed_running_total_per_million},0))*5.0
          + ((${sum_prior_3_days_confirmed_running_total_per_million}                 - ${sum_prior_4_days_confirmed_running_total_per_million}) / NULLIF(${sum_prior_4_days_confirmed_running_total_per_million},0))*4.0
          + ((${sum_prior_4_days_confirmed_running_total_per_million}                 - ${sum_prior_5_days_confirmed_running_total_per_million}) / NULLIF(${sum_prior_5_days_confirmed_running_total_per_million},0))*3.0
          + ((${sum_prior_5_days_confirmed_running_total_per_million}                 - ${sum_prior_6_days_confirmed_running_total_per_million}) / NULLIF(${sum_prior_6_days_confirmed_running_total_per_million},0))*2.0
          + ((${sum_prior_6_days_confirmed_running_total_per_million}                 - ${sum_prior_7_days_confirmed_running_total_per_million}) / NULLIF(${sum_prior_7_days_confirmed_running_total_per_million},0))
        )/28.0;;
  }

  measure: seven_day_average_change_rate_deaths_running_total_per_million {
    group_label: "Advanced Analytics"
    label: "Deaths Running Total per Million (7 Day Average Change)"
    type: number
    value_format_name: percent_1
    sql:
        (
            ((${jhu_sample_county_level_final.deaths_running_total_per_million}   - ${sum_prior_1_days_deaths_running_total_per_million}) / NULLIF(${sum_prior_1_days_deaths_running_total_per_million},0))*7.0
          + ((${sum_prior_1_days_deaths_running_total_per_million}                - ${sum_prior_2_days_deaths_running_total_per_million}) / NULLIF(${sum_prior_2_days_deaths_running_total_per_million},0))*6.0
          + ((${sum_prior_2_days_deaths_running_total_per_million}                - ${sum_prior_3_days_deaths_running_total_per_million}) / NULLIF(${sum_prior_3_days_deaths_running_total_per_million},0))*5.0
          + ((${sum_prior_3_days_deaths_running_total_per_million}                - ${sum_prior_4_days_deaths_running_total_per_million}) / NULLIF(${sum_prior_4_days_deaths_running_total_per_million},0))*4.0
          + ((${sum_prior_4_days_deaths_running_total_per_million}                - ${sum_prior_5_days_deaths_running_total_per_million}) / NULLIF(${sum_prior_5_days_deaths_running_total_per_million},0))*3.0
          + ((${sum_prior_5_days_deaths_running_total_per_million}                - ${sum_prior_6_days_deaths_running_total_per_million}) / NULLIF(${sum_prior_6_days_deaths_running_total_per_million},0))*2.0
          + ((${sum_prior_6_days_deaths_running_total_per_million}                - ${sum_prior_7_days_deaths_running_total_per_million}) / NULLIF(${sum_prior_7_days_deaths_running_total_per_million},0))
        )/28.0;;
  }

  measure: seven_day_average_change_rate_confirmed_cases_new_per_million {
    group_label: "Advanced Analytics"
    label: "Confirmed Cases New per Million (7 Day Average Change)"
    type: number
    value_format_name: percent_1
    sql:
        (
            ((${jhu_sample_county_level_final.confirmed_new_per_million}    - ${sum_prior_1_days_confirmed_new_per_million}) / NULLIF(${sum_prior_1_days_confirmed_new_per_million},0))*7.0
          + ((${sum_prior_1_days_confirmed_new_per_million}                 - ${sum_prior_2_days_confirmed_new_per_million}) / NULLIF(${sum_prior_2_days_confirmed_new_per_million},0))*6.0
          + ((${sum_prior_2_days_confirmed_new_per_million}                 - ${sum_prior_3_days_confirmed_new_per_million}) / NULLIF(${sum_prior_3_days_confirmed_new_per_million},0))*5.0
          + ((${sum_prior_3_days_confirmed_new_per_million}                 - ${sum_prior_4_days_confirmed_new_per_million}) / NULLIF(${sum_prior_4_days_confirmed_new_per_million},0))*4.0
          + ((${sum_prior_4_days_confirmed_new_per_million}                 - ${sum_prior_5_days_confirmed_new_per_million}) / NULLIF(${sum_prior_5_days_confirmed_new_per_million},0))*3.0
          + ((${sum_prior_5_days_confirmed_new_per_million}                 - ${sum_prior_6_days_confirmed_new_per_million}) / NULLIF(${sum_prior_6_days_confirmed_new_per_million},0))*2.0
          + ((${sum_prior_6_days_confirmed_new_per_million}                 - ${sum_prior_7_days_confirmed_new_per_million}) / NULLIF(${sum_prior_7_days_confirmed_new_per_million},0))
        )/28.0;;
  }

  measure: seven_day_average_change_rate_deaths_new_per_million {
    group_label: "Advanced Analytics"
    label: "Deaths New per Million (7 Day Average Change)"
    type: number
    value_format_name: percent_1
    sql:
        (
            ((${jhu_sample_county_level_final.deaths_new_per_million}   - ${sum_prior_1_days_deaths_new_per_million}) / NULLIF(${sum_prior_1_days_deaths_new_per_million},0))*7.0
          + ((${sum_prior_1_days_deaths_new_per_million}                - ${sum_prior_2_days_deaths_new_per_million}) / NULLIF(${sum_prior_2_days_deaths_new_per_million},0))*6.0
          + ((${sum_prior_2_days_deaths_new_per_million}                - ${sum_prior_3_days_deaths_new_per_million}) / NULLIF(${sum_prior_3_days_deaths_new_per_million},0))*5.0
          + ((${sum_prior_3_days_deaths_new_per_million}                - ${sum_prior_4_days_deaths_new_per_million}) / NULLIF(${sum_prior_4_days_deaths_new_per_million},0))*4.0
          + ((${sum_prior_4_days_deaths_new_per_million}                - ${sum_prior_5_days_deaths_new_per_million}) / NULLIF(${sum_prior_5_days_deaths_new_per_million},0))*3.0
          + ((${sum_prior_5_days_deaths_new_per_million}                - ${sum_prior_6_days_deaths_new_per_million}) / NULLIF(${sum_prior_6_days_deaths_new_per_million},0))*2.0
          + ((${sum_prior_6_days_deaths_new_per_million}                - ${sum_prior_7_days_deaths_new_per_million}) / NULLIF(${sum_prior_7_days_deaths_new_per_million},0))
        )/28.0;;
  }

  measure: doubling_time_confirmed_cases_rolling_total {
    group_label: "Advanced Analytics"
    label: "Confirmed Cases Running Total (Days to Double)"
    type: number
    value_format_name: decimal_1
    sql:  70 / NULLIF(100*${seven_day_average_change_rate_confirmed_cases_running_total},0);;
    html: {{rendered_value}} Day(s) ;;
  }

  measure: doubling_time_deaths_rolling_total {
    group_label: "Advanced Analytics"
    label: "Deaths Running Total (Days to Double)"
    type: number
    value_format_name: decimal_1
    sql:  70 / NULLIF(100*${seven_day_average_change_rate_deaths_running_total},0);;
    html: {{rendered_value}} Day(s) ;;
  }

  measure: doubling_time_confirmed_cases_new {
    group_label: "Advanced Analytics"
    label: "Confirmed Cases New (Days to Double)"
    type: number
    value_format_name: decimal_1
    sql:  70 / NULLIF(100*${seven_day_average_change_rate_confirmed_cases_new},0);;
    html: {{rendered_value}} Day(s) ;;
  }

  measure: doubling_time_deaths_new {
    group_label: "Advanced Analytics"
    label: "Deaths New (Days to Double)"
    type: number
    value_format_name: decimal_1
    sql:  70 / NULLIF(100*${seven_day_average_change_rate_deaths_new},0);;
    html: {{rendered_value}} Day(s) ;;
  }

  measure: doubling_time_confirmed_cases_rolling_total_per_million {
    group_label: "Advanced Analytics"
    label: "Confirmed Cases Running Total per Million (Days to Double)"
    type: number
    value_format_name: decimal_1
    sql:  70 / NULLIF(100*${seven_day_average_change_rate_confirmed_cases_running_total_per_million},0);;
    html: {{rendered_value}} Day(s) ;;
  }

  measure: doubling_time_deaths_rolling_total_per_million {
    group_label: "Advanced Analytics"
    label: "Deaths Running Total per Million (Days to Double)"
    type: number
    value_format_name: decimal_1
    sql:  70 / NULLIF(100*${seven_day_average_change_rate_deaths_running_total_per_million},0);;
    html: {{rendered_value}} Day(s) ;;
  }

  measure: doubling_time_confirmed_cases_new_per_million {
    group_label: "Advanced Analytics"
    label: "Confirmed Cases New per Million (Days to Double)"
    type: number
    value_format_name: decimal_1
    sql:  70 / NULLIF(100*${seven_day_average_change_rate_confirmed_cases_new_per_million},0);;
    html: {{rendered_value}} Day(s) ;;
  }

  measure: doubling_time_deaths_new_per_million {
    group_label: "Advanced Analytics"
    label: "Deaths New per Million (Days to Double)"
    type: number
    value_format_name: decimal_1
    sql:  70 / NULLIF(100*${seven_day_average_change_rate_deaths_new_per_million},0);;
    html: {{rendered_value}} Day(s) ;;
  }

}

#   measure: change_since_yesterday {
#     hidden: yes
#     type: number
#     value_format_name: percent_0
#     sql:  (${covid_data.confirmed_running_total} - ${prior_1_days_cumulative_cases}) / NULLIF(${prior_1_days_cumulative_cases},0);;
#   }

####################
### Forecasting
####################

view: growth_rate_by_pk {
  derived_table: {
    # datagroup_trigger: covid_data
    explore_source: jhu_sample_county_level_final {
      column: fips {}
      column: county {}
      column: province_state {}
      column: country_raw {}
      column: lat {}
      column: long {}
      column: combined_key {}
      column: confirmed_running_total {}
      column: deaths_running_total {}
      column: seven_day_average_change_rate_confirmed_cases_new { field: prior_days_cases_covid.seven_day_average_change_rate_confirmed_cases_new }
      column: seven_day_average_change_rate_confirmed_cases_running_total { field: prior_days_cases_covid.seven_day_average_change_rate_confirmed_cases_running_total }
      column: seven_day_average_change_rate_deaths_new { field: prior_days_cases_covid.seven_day_average_change_rate_deaths_new }
      column: seven_day_average_change_rate_deaths_running_total { field: prior_days_cases_covid.seven_day_average_change_rate_deaths_running_total }
      filters: {
        field: jhu_sample_county_level_final.is_max_date
        value: "Yes"
      }
    }
  }
}

view: covid_forecasting {
  derived_table: {
    # publish_as_db_view: yes
    # datagroup_trigger: covid_data
    sql:
    SELECT
      c.fips,
      c.county,
      c.province_state,
      c.country_raw as country_region,
      c.lat,
      c.long,
      c.combined_key,
      a.number,
      date_add(cast(b.max_date as date), INTERVAL number day) as forecast_date,
      c.seven_day_average_change_rate_confirmed_cases_new,
      c.seven_day_average_change_rate_confirmed_cases_running_total,
      c.seven_day_average_change_rate_deaths_new,
      c.seven_day_average_change_rate_deaths_running_total,
      c.confirmed_running_total,
      c.deaths_running_total,
    FROM `lookerdata.covid19.day_counter_90_days` a
    CROSS JOIN ${max_date_covid.SQL_TABLE_NAME} b
    CROSS JOIN ${growth_rate_by_pk.SQL_TABLE_NAME} c
    WHERE a.number < 31
    ;;
  }
  # sql_table_name: `lookerdata.covid19.day_counter_90_days` ;;

#   dimension: pk {hidden: yes primary_key: yes sql: concat(${pre_pk},${number});;}
#   dimension: pre_pk {hidden: yes}
  dimension: fips {}
  dimension: county {}
  dimension: province_state {}
  dimension: country_region {}
  dimension: lat {}
  dimension: long {}
  dimension: combined_key {}
  dimension: number {hidden: yes type:number}
#   dimension: seven_day_average_change_rate_confirmed_cases_new {hidden:yes type:number}
  dimension: seven_day_average_change_rate_confirmed_cases_running_total {type:number}
#   dimension: seven_day_average_change_rate_deaths_new {hidden:yes type:number}
  dimension: seven_day_average_change_rate_deaths_running_total { type:number}
#   dimension: confirmed_new_option_2 {hidden:yes type:number}
  dimension: confirmed_running_total {type:number}
#   dimension: deaths_new_option_2 {hidden:yes type:number}
  dimension: deaths_running_total { type:number}
  dimension: dynamic_seven_day_average_change_rate_confirmed_cases_running_total {
    type: number
    sql: ${seven_day_average_change_rate_confirmed_cases_running_total} - (${number} / 31 * 0.9 * ${seven_day_average_change_rate_confirmed_cases_running_total}) ;;
  }
  dimension: dynamic_seven_day_average_change_rate_deaths_running_total {
    type: number
    sql: ${seven_day_average_change_rate_deaths_running_total} - (${number} / 31 * 0.9 * ${seven_day_average_change_rate_deaths_running_total}) ;;
  }
  dimension: confirmed_cases_rolling_total_forecasting {
    type: number
    sql:1.0 * ${confirmed_running_total} * POW(cast((1 + round(${dynamic_seven_day_average_change_rate_confirmed_cases_running_total},3)) as numeric),${number}) ;;
    value_format_name: decimal_0
  }
  dimension: deaths_rolling_total_forecasting {
    type: number
    sql:1.0 * ${deaths_running_total} * POW(cast((1 + round(${dynamic_seven_day_average_change_rate_deaths_running_total},3)) as numeric),${number}) ;;
    value_format_name: decimal_0
  }
  dimension: forecasted_new_confirmed_cases {
    type: number
    sql: ${confirmed_running_total} * ${dynamic_seven_day_average_change_rate_confirmed_cases_running_total} ;;
  }
  dimension: forecasted_new_deaths {
    type: number
    sql: ${deaths_running_total} * ${dynamic_seven_day_average_change_rate_deaths_running_total} ;;
  }
  dimension_group: forecast {
    type: time
    timeframes: [
      raw,
      date
    ]
    sql: cast(${TABLE}.forecast_date as timestamp) ;;
  }
}

view: covid_forecasting_results {
  derived_table: {
    publish_as_db_view: yes
    datagroup_trigger: covid_data
    explore_source: covid_forecasting {
      column: fips {}
      column: county {}
      column: province_state {}
      column: country_region {}
      column: lat {}
      column: long {}
      column: combined_key {}
      column: forecast_date {}
      column: confirmed_running_total {}
      column: deaths_running_total {}
      column: forecasted_new_confirmed_cases {}
      column: forecasted_new_deaths {}
    }
  }
  dimension: fips {}
}

####################
### Compare Geographies
####################

view: kpis_by_county_by_date {
  derived_table: {
    datagroup_trigger: covid_data
    explore_source: jhu_sample_county_level_final {
      column: county_full {}
      column: measurement_date {}
      column: days_since_first_outbreak {}
      column: confirmed_new {}
      column: confirmed_new_per_million {}
      column: deaths_new {}
      column: deaths_new_per_million {}
      column: confirmed_running_total {}
      column: confirmed_running_total_per_million {}
      column: deaths_running_total {}
      column: deaths_running_total_per_million {}
      column: doubling_time_confirmed_cases_new_per_million { field: prior_days_cases_covid.doubling_time_confirmed_cases_new_per_million }
      column: doubling_time_confirmed_cases_rolling_total_per_million { field: prior_days_cases_covid.doubling_time_confirmed_cases_rolling_total_per_million }
      column: doubling_time_deaths_new_per_million { field: prior_days_cases_covid.doubling_time_deaths_new_per_million }
      column: doubling_time_deaths_rolling_total_per_million { field: prior_days_cases_covid.doubling_time_deaths_rolling_total_per_million }
      filters: {
        field: jhu_sample_county_level_final.fips
        value: "NOT NULL"
      }
    }
  }
}

view: kpis_by_state_by_date {
  derived_table: {
    datagroup_trigger: covid_data
    explore_source: jhu_sample_county_level_final {
      column: state_full {}
      column: measurement_date {}
      column: days_since_first_outbreak {}
      column: confirmed_new {}
      column: confirmed_new_per_million {}
      column: deaths_new {}
      column: deaths_new_per_million {}
      column: confirmed_running_total {}
      column: confirmed_running_total_per_million {}
      column: deaths_running_total {}
      column: deaths_running_total_per_million {}
      column: doubling_time_confirmed_cases_new_per_million { field: prior_days_cases_covid.doubling_time_confirmed_cases_new_per_million }
      column: doubling_time_confirmed_cases_rolling_total_per_million { field: prior_days_cases_covid.doubling_time_confirmed_cases_rolling_total_per_million }
      column: doubling_time_deaths_new_per_million { field: prior_days_cases_covid.doubling_time_deaths_new_per_million }
      column: doubling_time_deaths_rolling_total_per_million { field: prior_days_cases_covid.doubling_time_deaths_rolling_total_per_million }
      filters: {
        field: jhu_sample_county_level_final.province_state
        value: "-NULL"
      }
    }
  }
}

view: kpis_by_country_by_date {
  derived_table: {
    datagroup_trigger: covid_data
    explore_source: jhu_sample_county_level_final {
      column: country_region {}
      column: measurement_date {}
      column: days_since_first_outbreak {}
      column: confirmed_new {}
      column: confirmed_new_per_million {}
      column: deaths_new {}
      column: deaths_new_per_million {}
      column: confirmed_running_total {}
      column: confirmed_running_total_per_million {}
      column: deaths_running_total {}
      column: deaths_running_total_per_million {}
      column: doubling_time_confirmed_cases_new_per_million { field: prior_days_cases_covid.doubling_time_confirmed_cases_new_per_million }
      column: doubling_time_confirmed_cases_rolling_total_per_million { field: prior_days_cases_covid.doubling_time_confirmed_cases_rolling_total_per_million }
      column: doubling_time_deaths_new_per_million { field: prior_days_cases_covid.doubling_time_deaths_new_per_million }
      column: doubling_time_deaths_rolling_total_per_million { field: prior_days_cases_covid.doubling_time_deaths_rolling_total_per_million }
      filters: {
        field: jhu_sample_county_level_final.country_region
        value: "-NULL"
      }
    }
  }
}

view: kpis_by_entity_by_date {
  derived_table: {
    datagroup_trigger: covid_data
    sql:

  SELECT
    'County' as entity_level
  , county_full as entity
  , measurement_date
  , days_since_first_outbreak
  , confirmed_new
  , confirmed_new_per_million
  , deaths_new
  , deaths_new_per_million
  , confirmed_running_total
  , confirmed_running_total_per_million
  , deaths_running_total
  , deaths_running_total_per_million
  , doubling_time_confirmed_cases_new_per_million
  , doubling_time_confirmed_cases_rolling_total_per_million
  , doubling_time_deaths_new_per_million
  , doubling_time_deaths_rolling_total_per_million
  FROM ${kpis_by_county_by_date.SQL_TABLE_NAME}

  UNION ALL

  SELECT 'State' as entity_level, *
  FROM ${kpis_by_state_by_date.SQL_TABLE_NAME}

  UNION ALL

  SELECT 'Country' as entity_level, *
  FROM ${kpis_by_country_by_date.SQL_TABLE_NAME}

    ;;
  }

  dimension: entity {
    type: string
#     sql:
#       CASE
#         WHEN entity = 'Country' then concat('  ',${TABLE}.entity)
#         WHEN entity = 'State' then concat(' ',${TABLE}.entity)
#         WHEN entity = 'County' then ${TABLE}.entity
#       END
#     ;;
  }
  dimension: pk {
    primary_key: yes
    hidden: yes
    sql: concat(${entity},cast(${measurement_date} as string)) ;;
  }

  dimension_group: measurement {
    type: time
    timeframes: [
      raw,date
    ]
    sql: ${TABLE}.measurement_date ;;
  }

  dimension: days_since_first_outbreak {
    hidden: yes
    type: number
  }

  dimension: entity_level { type: number hidden:yes }
  dimension: confirmed_new { type: number hidden:yes }
  dimension: confirmed_new_per_million { type: number hidden:yes }
  dimension: deaths_new { type: number hidden:yes }
  dimension: deaths_new_per_million { type: number hidden:yes }
  dimension: confirmed_running_total { type: number hidden:yes }
  dimension: confirmed_running_total_per_million { type: number hidden:yes }
  dimension: deaths_running_total { type: number hidden:yes }
  dimension: deaths_running_total_per_million { type: number hidden:yes }
  dimension: doubling_time_confirmed_cases_new_per_million { type: number hidden:yes }
  dimension: doubling_time_confirmed_cases_rolling_total_per_million { type: number hidden:yes }
  dimension: doubling_time_deaths_new_per_million { type: number hidden:yes }
  dimension: doubling_time_deaths_rolling_total_per_million { type: number hidden:yes }

  parameter: minimum_number_cases {
    label: "Minimum Number of cases (X)"
    description: "Modify your analysis to start counting days since outbreak to start with a minumum of X cases."
    type: number
    default_value: "1"
  }

  dimension_group: outbreak_start {
    hidden: yes
    type: time
    timeframes: [raw, date]
    sql:
      (
        SELECT CAST(MIN(foobar.measurement_date) AS TIMESTAMP)
        FROM ${kpis_by_entity_by_date.SQL_TABLE_NAME} as foobar
        WHERE foobar.confirmed_running_total >=  {% parameter minimum_number_cases %}
        AND ${TABLE}.entity = foobar.entity
      )
      ;;
  }

  dimension: days_since_first_outbreaks {
    label: "Days Since (X) Cases"
    type:  number
    sql: date_diff(${measurement_date},${outbreak_start_date},  day) + 1 ;;
  }

  parameter: metric_type {
    type: string
    default_value: "new"
    allowed_value: {
      label: "New"
      value: "new"
    }
    allowed_value: {
      label: "Running Total"
      value: "running_total"
    }
  }

  parameter: metric_value {
    type: string
    default_value: "per_million_people"
    allowed_value: {
      label: "Actual Value"
      value: "actual_value"
    }
    allowed_value: {
      label: "Per Million People"
      value: "per_million_people"
    }
    allowed_value: {
      label: "Days to Double"
      value: "days_to_double"
    }
  }

  parameter: metric {
    type: string
    default_value: "confirmed_cases"
    allowed_value: {
      label: "Confirmed_Cases"
      value: "confirmed_cases"
    }
    allowed_value: {
      label: "Deaths"
      value: "deaths"
    }
  }

  dimension: concat_parameters {
    type: string
    # hidden: yes
    sql: concat({% parameter metric_type %},'|',{% parameter metric_value %},'|',{% parameter metric %}) ;;
  }

  measure: kpi_to_select {
    label: " Dynamic KPI"
    type: number
    sql:
    CASE
      WHEN ${concat_parameters} = 'new|actual_value|confirmed_cases'                  THEN ${sum_confirmed_new}
      WHEN ${concat_parameters} = 'new|actual_value|deaths'                           THEN ${sum_deaths_new}
      WHEN ${concat_parameters} = 'new|per_million_people|confirmed_cases'            THEN ${sum_confirmed_new_per_million}
      WHEN ${concat_parameters} = 'new|per_million_people|deaths'                     THEN ${sum_deaths_new_per_million}
      WHEN ${concat_parameters} = 'new|days_to_double|confirmed_cases'                THEN ${sum_doubling_time_confirmed_cases_new_per_million}
      WHEN ${concat_parameters} = 'new|days_to_double|deaths'                         THEN ${sum_doubling_time_deaths_new_per_million}
      WHEN ${concat_parameters} = 'running_total|actual_value|confirmed_cases'        THEN ${sum_confirmed_running_total}
      WHEN ${concat_parameters} = 'running_total|actual_value|deaths'                 THEN ${sum_deaths_running_total}
      WHEN ${concat_parameters} = 'running_total|per_million_people|confirmed_cases'  THEN ${sum_confirmed_running_total_per_million}
      WHEN ${concat_parameters} = 'running_total|per_million_people|deaths'           THEN ${sum_deaths_running_total_per_million}
      WHEN ${concat_parameters} = 'running_total|days_to_double|confirmed_cases'      THEN ${sum_doubling_time_confirmed_cases_rolling_total_per_million}
      WHEN ${concat_parameters} = 'running_total|days_to_double|deaths'               THEN ${sum_doubling_time_deaths_rolling_total_per_million}
    END
    ;;
    value_format_name: decimal_1
  }

#   sql:
#   {% if    metric_type._parameter_value == 'new' AND metric_value._parameter_value == 'actual_value' AND metric._parameter_value == 'confirmed_cases' %} ${sum_confirmed_new}
#   {% elsif metric_type._parameter_value == 'new' AND metric_value._parameter_value == 'actual_value' AND metric._parameter_value == 'deaths' %} ${sum_deaths_new}
#   {% elsif metric_type._parameter_value == 'new' AND metric_value._parameter_value == 'per_million_people' AND metric._parameter_value == 'confirmed_cases' %} ${sum_confirmed_new_per_million}
#   {% elsif metric_type._parameter_value == 'new' AND metric_value._parameter_value == 'per_million_people' AND metric._parameter_value == 'deaths' %} ${sum_deaths_new_per_million}
#   {% elsif metric_type._parameter_value == 'new' AND metric_value._parameter_value == 'days_to_double' AND metric._parameter_value == 'confirmed_cases' %} ${sum_doubling_time_confirmed_cases_new_per_million}
#   {% elsif metric_type._parameter_value == 'new' AND metric_value._parameter_value == 'days_to_double' AND metric._parameter_value == 'deaths' %} ${sum_doubling_time_deaths_new_per_million}
#   {% elsif metric_type._parameter_value == 'running_total' AND metric_value._parameter_value == 'actual_value' AND metric._parameter_value == 'confirmed_cases' %} ${sum_confirmed_running_total}
#   {% elsif metric_type._parameter_value == 'running_total' AND metric_value._parameter_value == 'actual_value' AND metric._parameter_value == 'deaths' %} ${sum_deaths_running_total}
#   {% elsif metric_type._parameter_value == 'running_total' AND metric_value._parameter_value == 'per_million_people' AND metric._parameter_value == 'confirmed_cases' %} ${sum_confirmed_running_total_per_million}
#   {% elsif metric_type._parameter_value == 'running_total' AND metric_value._parameter_value == 'per_million_people' AND metric._parameter_value == 'deaths' %} ${sum_deaths_running_total_per_million}
#   {% elsif metric_type._parameter_value == 'running_total' AND metric_value._parameter_value == 'days_to_double' AND metric._parameter_value == 'confirmed_cases' %} ${sum_doubling_time_confirmed_cases_rolling_total_per_million}
#   {% elsif metric_type._parameter_value == 'running_total' AND metric_value._parameter_value == 'days_to_double' AND metric._parameter_value == 'deaths' %} ${sum_doubling_time_deaths_rolling_total_per_million}
#   {% endif %}
#   ;;

  measure: sum_confirmed_new {
    label: "Confirmed (New)"
    type: sum
    sql: ${confirmed_new} ;;
    value_format_name: decimal_0
  }
  measure: sum_confirmed_new_per_million {
    label: "Confirmed (New) (Per Million)"
    type: sum
    sql: ${confirmed_new_per_million} ;;
    value_format_name: decimal_0
  }
  measure: sum_deaths_new {
    label: "Deaths (New)"
    type: sum
    sql: ${deaths_new} ;;
    value_format_name: decimal_0
  }
  measure: sum_deaths_new_per_million {
    label: "Deaths (New) (Per Million)"
    type: sum
    sql: ${deaths_new_per_million} ;;
    value_format_name: decimal_0
  }
  measure: sum_confirmed_running_total {
    label: "Confirmed (Running Total)"
    type: sum
    sql: ${confirmed_running_total} ;;
    value_format_name: decimal_0
  }
  measure: sum_confirmed_running_total_per_million {
    label: "Confirmed (Running Total) (Per Million)"
    type: sum
    sql: ${confirmed_running_total_per_million} ;;
    value_format_name: decimal_0
  }
  measure: sum_deaths_running_total {
    label: "Deaths (Running Total)"
    type: sum
    sql: ${deaths_running_total} ;;
    value_format_name: decimal_0
  }
  measure: sum_deaths_running_total_per_million {
    label: "Deaths (Running Total) (Per Million)"
    type: sum
    sql: ${deaths_running_total_per_million} ;;
    value_format_name: decimal_0
  }
  measure: sum_doubling_time_confirmed_cases_new_per_million {
    label: "Days to double Confirmed Cases (New)"
    type: average
    sql: ${doubling_time_confirmed_cases_new_per_million} ;;
    value_format_name: decimal_1
    html: {{rendered_value}} Day(s) ;;
  }
  measure: sum_doubling_time_confirmed_cases_rolling_total_per_million {
    label: "Days to double Confirmed Cases (Rolling Total)"
    type: average
    sql: ${doubling_time_confirmed_cases_rolling_total_per_million} ;;
    value_format_name: decimal_1
    html: {{rendered_value}} Day(s) ;;
  }
  measure: sum_doubling_time_deaths_new_per_million {
    label: "Days to double Deaths (New)"
    type: average
    sql: ${doubling_time_deaths_new_per_million} ;;
    value_format_name: decimal_1
    html: {{rendered_value}} Day(s) ;;
  }
  measure: sum_doubling_time_deaths_rolling_total_per_million {
    label: "Days to double Deaths (Rolling Total)"
    type: average
    sql: ${doubling_time_deaths_rolling_total_per_million} ;;
    value_format_name: decimal_1
    html: {{rendered_value}} Day(s) ;;
  }
}

####################
### Animation
####################

# view: animation {
#   derived_table: {
#     sql:
#       SELECT puma as puma, confirmed_running_total_per_million, '2 Weeks Ago' as timeframe FROM ${by_puma_2_weeks_ago.SQL_TABLE_NAME} UNION ALL
#       SELECT puma as puma, confirmed_running_total_per_million, '1 Week Ago' as timeframe FROM ${by_puma_last_week.SQL_TABLE_NAME} UNION ALL
#       SELECT puma as puma, confirmed_running_total_per_million, 'Today' as timeframe FROM ${by_puma_today.SQL_TABLE_NAME} UNION ALL
#       SELECT puma as puma, confirmed_running_total_per_million, 'Forecasted' as timeframe FROM ${by_puma_next_week.SQL_TABLE_NAME} UNION ALL
#       SELECT '999999' as puma, min, '2 Weeks Ago' as timeframe FROM ${max_values.SQL_TABLE_NAME} UNION ALL
#       SELECT '999999' as puma, min, '1 Week Ago' as timeframe FROM ${max_values.SQL_TABLE_NAME} UNION ALL
#       SELECT '999999' as puma, min, 'Today' as timeframe FROM ${max_values.SQL_TABLE_NAME} UNION ALL
#       SELECT '999999' as puma, min, 'Forecasted' as timeframe FROM ${max_values.SQL_TABLE_NAME} UNION ALL
#       SELECT '999999' as puma, max, '2 Weeks Ago' as timeframe FROM ${max_values.SQL_TABLE_NAME} UNION ALL
#       SELECT '999999' as puma, max, '1 Week Ago' as timeframe FROM ${max_values.SQL_TABLE_NAME} UNION ALL
#       SELECT '999999' as puma, max, 'Today' as timeframe FROM ${max_values.SQL_TABLE_NAME} UNION ALL
#       SELECT '999999' as puma, max, 'Forecasted' as timeframe FROM ${max_values.SQL_TABLE_NAME}
#     ;;
#   }
#   dimension: pk {
#     primary_key: yes
#     hidden: yes
#     type: string
#     sql: concat(${puma},${timeframe}) ;;
#   }
#   dimension: puma {
#     type: number
#   }
#   dimension: timeframe {
#     type: string
#   }
#   dimension: confirmed_running_total_per_million {
#     hidden: yes
#     type: string
#   }
#   measure: sum_confirmed_running_total_per_million {
#     type: sum
#     sql: ${confirmed_running_total_per_million} ;;
#   }
# }
#
# view: max_values {
#   derived_table: {
#     sql:
#   SELECT min(min) as min, max(max) as max
#   FROM
#   (
#     SELECT min(confirmed_running_total_per_million) as min , max(confirmed_running_total_per_million) as max FROM ${by_puma_2_weeks_ago.SQL_TABLE_NAME} UNION ALL
#     SELECT min(confirmed_running_total_per_million) as min , max(confirmed_running_total_per_million) as max FROM ${by_puma_last_week.SQL_TABLE_NAME} UNION ALL
#     SELECT min(confirmed_running_total_per_million) as min , max(confirmed_running_total_per_million) as max FROM ${by_puma_today.SQL_TABLE_NAME} UNION ALL
#     SELECT min(confirmed_running_total_per_million) as min , max(confirmed_running_total_per_million) as max FROM ${by_puma_next_week.SQL_TABLE_NAME}
#   ) a
#     ;;
#   }
#   # max(confirmed_new_per_million) as max_confirmed_new_per_million,
#   # max(seven_day_average_change_rate_confirmed_cases_new_per_million) as max_seven_day_average_change_rate_confirmed_cases_new_per_million
# }
#
# view: by_puma_2_weeks_ago {
#   derived_table: {
#     explore_source: jhu_sample_county_level_final {
#       bind_all_filters: yes
#       column: puma { field: zip_to_puma_v2.puma }
#       column: confirmed_running_total_per_million {}
#       # column: confirmed_new_per_million {}
#       # column: seven_day_average_change_rate_confirmed_cases_new_per_million { field: prior_days_cases_covid.seven_day_average_change_rate_confirmed_cases_new_per_million }
#       filters: {
#         field: jhu_sample_county_level_final.days_since_max_date
#         value: "-14"
#       }
#     }
#   }
# }
#
# view: by_puma_last_week {
#   derived_table: {
#     explore_source: jhu_sample_county_level_final {
#       bind_all_filters: yes
#       column: puma { field: zip_to_puma_v2.puma }
#       column: confirmed_running_total_per_million {}
#       # column: confirmed_new_per_million {}
#       # column: seven_day_average_change_rate_confirmed_cases_new_per_million { field: prior_days_cases_covid.seven_day_average_change_rate_confirmed_cases_new_per_million }
#       filters: {
#         field: jhu_sample_county_level_final.days_since_max_date
#         value: "-7"
#       }
#     }
#   }
# }
#
# view: by_puma_today {
#   derived_table: {
#     explore_source: jhu_sample_county_level_final {
#       bind_all_filters: yes
#       column: puma { field: zip_to_puma_v2.puma }
#       column: confirmed_running_total_per_million {}
#       # column: confirmed_new_per_million {}
#       # column: seven_day_average_change_rate_confirmed_cases_new_per_million { field: prior_days_cases_covid.seven_day_average_change_rate_confirmed_cases_new_per_million }
#       filters: {
#         field: jhu_sample_county_level_final.days_since_max_date
#         value: "0"
#       }
#     }
#   }
# }
#
# view: by_puma_next_week {
#   derived_table: {
#     explore_source: jhu_sample_county_level_final {
#       bind_all_filters: yes
#       column: puma { field: zip_to_puma_v2.puma }
#       column: confirmed_running_total_per_million {}
#       # column: confirmed_new_per_million {}
#       # column: seven_day_average_change_rate_confirmed_cases_new_per_million { field: prior_days_cases_covid.seven_day_average_change_rate_confirmed_cases_new_per_million }
#       filters: {
#         field: jhu_sample_county_level_final.days_since_max_date
#         value: "7"
#       }
#       filters: {
#         field: jhu_sample_county_level_final.allow_forecasted_values
#         value: "yes"
#       }
#     }
#   }
# }










#   measure: start_confirmed_cases {
#     type: sum
#     sql: ${confirmed_running_total} ;;
#     filters: {
#       field: number
#       value: "1"
#     }
#   }
#   measure: sum_forecasted_new_confirmed_cases {
#     type: sum
#     sql: ${forecasted_new_confirmed_cases} ;;
#     value_format_name: decimal_0
#   }
#   measure: forecasted_confirmed_cases_running_total {
#     type: running_total
#     sql: ${start_confirmed_cases} + ${sum_forecasted_new_confirmed_cases} ;;
#     value_format_name: decimal_0
#   }
#   measure: start_deaths {
#     type: sum
#     sql: ${deaths_running_total} ;;
#     filters: {
#       field: number
#       value: "1"
#     }
#   }
#   measure: sum_forecasted_new_deaths {
#     type: sum
#     sql: ${forecasted_new_deaths} ;;
#     value_format_name: decimal_0
#   }
#   measure: forecasted_deaths_running_total {
#     type: running_total
#     sql: ${start_deaths} + ${sum_forecasted_new_deaths} ;;
#     value_format_name: decimal_0
#   }



#   measure: sum_number {type: sum hidden:yes sql: ${number} ;;}
# #   measure: sum_seven_day_average_change_rate_confirmed_cases_new {type: average hidden:yes sql: ${seven_day_average_change_rate_confirmed_cases_new} ;;}
#   measure: sum_seven_day_average_change_rate_confirmed_cases_running_total {type: sum  sql: ${dynamic_seven_day_average_change_rate_confirmed_cases_running_total} ;;}
# #   measure: sum_seven_day_average_change_rate_deaths_new {type: average hidden:yes sql: ${seven_day_average_change_rate_deaths_new} ;;}
#   measure: sum_seven_day_average_change_rate_deaths_running_total {type: sum  sql: ${dynamic_seven_day_average_change_rate_deaths_running_total} ;;}
# #   measure: sum_confirmed_new_option_2 {type: average hidden:yes sql: ${confirmed_new_option_2} ;;}
#   measure: sum_confirmed_running_total {type: sum  sql: ${confirmed_running_total} ;;}
# #   measure: sum_deaths_new_option_2 {type: average hidden:yes sql: ${deaths_new_option_2} ;;}
#   measure: sum_deaths_running_total {type: sum  sql: ${deaths_running_total} ;;}
# #   measure: confirmed_cases_new_forecasting {
# #     type: number
# #     sql: 1.0 * ${sum_confirmed_new_option_2} * POW((1 + ${sum_seven_day_average_change_rate_confirmed_cases_new}),${sum_number}) ;;
# #     value_format_name: decimal_0
# #   }
#   measure: confirmed_cases_rolling_total_forecasting {
#     type: number
#     sql: 1.0 * ${sum_confirmed_running_total} * POW(cast((1 + round(${sum_seven_day_average_change_rate_confirmed_cases_running_total},3)) as numeric),${sum_number}) ;;
#     value_format_name: decimal_0
#   }
# #   measure: deaths_new_forecasting {
# #     type: number
# #     sql: 1.0 * ${sum_deaths_new_option_2} * POW((1 + ${sum_seven_day_average_change_rate_deaths_new}),${sum_number}) ;;
# #     value_format_name: decimal_0
# #   }
#   measure: deaths_rolling_total_forecasting {
#     type: number
#     sql: 1.0 * ${sum_deaths_running_total} * POW((1 + ${sum_seven_day_average_change_rate_deaths_running_total}),${sum_number}) ;;
#     value_format_name: decimal_0
#   }
# }

# view: forecasting {
#   derived_table: {
#     sql:
#       SELECT *
#       FROM ${jhu_sample_county_level_final.SQL_TABLE_NAME}
#
#     ;;
#   }
# }
