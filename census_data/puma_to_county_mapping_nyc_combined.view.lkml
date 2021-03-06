view: puma_to_county_mapping_nyc_combined {
  sql_table_name: `lookerdata.covid19.puma_to_county_mapping_nyc_combined`;;
  label: " COVID19"

  dimension: primary_key {
    hidden: yes
    primary_key: yes
    type: string
    sql: concat(${county_fips},${puma_fips}) ;;
  }

  dimension: county_fips {
    hidden: yes
    type: string
    sql: ${TABLE}.county_fips ;;
  }

  dimension: county_pop {
    hidden: yes
    type: number
    sql: ${TABLE}.county_pop ;;
  }

  dimension: name {
    hidden: yes
    type: string
    sql: ${TABLE}.name  ;;
  }

  dimension: pct_of_county_pop_in_puma {
    hidden: yes
    type: number
    sql: ${TABLE}.pct_of_county_pop_in_puma ;;
  }

  dimension: pct_of_puma_pop_in_county {
    hidden: yes
    type: number
    sql: ${TABLE}.pct_of_puma_pop_in_county ;;
  }


  dimension: puma_fips_raw {
    hidden: yes
    type: string
    sql:${TABLE}.puma_fips  ;;
  }

  dimension: puma_fips {
    group_label: "Location"
    label: "Public Use Microdata Area (PUMA)"
    type: string
    sql: ${puma_fips_raw}  ;;
    html: {{puma_to_county_mapping_nyc_combined.name._value}} ;;
    map_layer_name: us_pumas_nyc_combined

    suggest_dimension: puma_to_county_mapping_nyc_combined.name
    suggest_persist_for: "168 hours"
  }

  dimension: puma_pop {
    hidden: yes
    type: number
    sql: ${TABLE}.puma_pop ;;
  }

  measure: count {
    hidden: yes
    type: count
    drill_fields: [name]
  }
}
