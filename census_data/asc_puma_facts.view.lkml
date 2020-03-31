view: acs_puma_facts {

  derived_table: {
    explore_source: acs_puma_2018 {
      column: puma { field: zip_to_puma_v2.puma }
      column: total_pop {field: acs_puma_2018.total_pop}
      column: female_pop {field: acs_puma_2018.female_pop}
      column: male_pop {field: acs_puma_2018.male_pop}
      column: population_above_50 {field: acs_puma_2018.population_above_50}
      column: population_above_65 {field: acs_puma_2018.population_above_65}
      column: population_above_80 {field: acs_puma_2018.population_above_80}
      column: dwellings_5_or_more_units {field: acs_puma_2018.dwellings_5_or_more_units}
      column: total_dwellings {field: acs_puma_2018.total_dwellings}
    }
  }
  dimension: puma {
    primary_key: yes
    label: "PUMA"
    hidden: yes
  }
  dimension: total_pop {
    hidden: yes
    description: "The total number of all people living in a given geographic area. "
    type: number
  }
  dimension: female_pop {
    hidden: yes
    label: "Demographic Populations Female Population"
    type: number
  }
  dimension: male_pop {
    hidden: yes
    label: "Demographic Populations Male Population"
    type: number
  }
  dimension: population_above_50 {
    hidden: yes
    label: "Age Groups Population Above 50"
    type: number
  }
  dimension: population_above_65 {
    hidden: yes
    label: "Age Groups Population Above 65"
    type: number
  }
  dimension: population_above_80 {
    hidden: yes
    label: "Age Groups Population Above 80"
    type: number
  }
  dimension: dwellings_5_or_more_units {
    hidden: yes
    type: number
  }
  dimension: total_dwellings {
    hidden: yes
    type: number
  }

  ### MEASURES ###

  measure: population {
    type: sum
    sql: ${total_pop} ;;
    value_format_name: decimal_0
  }

  measure: male_population {
    type: sum
    sql: ${male_pop} ;;
    value_format_name: decimal_0
  }

  measure: female_population {
    type: sum
    sql: ${female_pop} ;;
    value_format_name: decimal_0
  }

  measure: total_population_above_50 {
    type: sum
    sql: ${population_above_50} ;;
    value_format_name: decimal_0
  }

  measure: total_population_above_65 {
    type: sum
    sql: ${population_above_65} ;;
    value_format_name: decimal_0
  }

  measure: total_population_above_80 {
    type: sum
    sql: ${population_above_80} ;;
    value_format_name: decimal_0
  }

  measure: sum_dwellings_5_or_more_units {
    hidden: yes
    type: sum
    sql: ${dwellings_5_or_more_units} ;;
  }
  measure: sum_total_dwellings {
    hidden: yes
    type: sum
    sql: ${total_dwellings} ;;
  }

  measure: percent_population_above_65 {
    type: number
    sql: 1.0*${total_population_above_65} / nullif(${population},0)  ;;
    value_format_name: percent_1
    link: {
      label: "Data Source - American Community Survey Data (ACS)"
      url: "https://www2.census.gov/programs-surveys/acs/summary_file/2017/data/?#"
      icon_url: "http://www.google.com/s2/favicons?domain_url=http://www.census.gov"
    }
  }
  measure: percent_apartment_buildings {
    type: number
    sql: 1.0*${sum_dwellings_5_or_more_units} / nullif(${sum_total_dwellings},0)  ;;
    value_format_name: percent_1
    link: {
      label: "Data Source - American Community Survey Data (ACS)"
      url: "https://www2.census.gov/programs-surveys/acs/summary_file/2017/data/?#"
      icon_url: "http://www.google.com/s2/favicons?domain_url=http://www.census.gov"
    }
  }

}
