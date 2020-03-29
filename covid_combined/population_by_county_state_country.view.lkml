view: population_by_county_state_country {
  sql_table_name: `lookerdata.covid19.population_by_county_state_country`
    ;;

  dimension: pre_pk {
    primary_key: yes
    hidden: yes
    type: string
    sql: concat(coalesce(${county},''), coalesce(${province_state},''), coalesce(${country_region},'')) ;;
  }

  dimension: count2 {
    hidden: yes
    type: number
    sql: ${TABLE}.count ;;
  }

  dimension: country_region {
    hidden: yes
    type: string
    sql: ${TABLE}.country_region ;;
  }

  dimension: county {
    hidden: yes
    type: string
    sql: ${TABLE}.county ;;
  }

  dimension: fips {
    hidden: yes
    type: number
    sql: ${TABLE}.fips ;;
  }

  dimension: population {
    hidden: yes
    type: number
    sql: ${TABLE}.population ;;
  }

  dimension: province_state {
    hidden: yes
    type: string
    sql: ${TABLE}.province_state ;;
  }

  measure: sum_population {
    label: "Total Population"
    type: sum
    sql: ${population} ;;
  }

  measure: count {
    hidden: yes
    type: count
    drill_fields: []
  }
}
