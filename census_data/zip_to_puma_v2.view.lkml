view: zip_to_puma_v2 {
  sql_table_name: lookerdata.covid19.zip_to_puma_v2 ;;
  label: "Location"

  dimension: name {
    hidden: yes
    type: string
    sql: ${TABLE}.Name ;;
  }

  dimension: pct_puma_pop_in_zip {
    hidden: yes
    type: number
    sql: ${TABLE}.pct_puma_pop_in_zip ;;
  }

  dimension: pct_zip_pop_in_puma {
    hidden: yes
    type: number
    sql: ${TABLE}.pct_zip_pop_in_puma ;;
  }

  dimension: puma_raw {
    hidden: yes
    type: string
    sql: ${TABLE}.PUMA
    ;;
  }

  dimension: puma {
    label: "Public Use Microdata Area (PUMA)"
    type: string
    sql:CASE WHEN LENGTH(cast(${puma_raw} as string)) = 6 THEN CONCAT('0',${puma_raw}) ELSE cast(${puma_raw} as string) END ;;
    map_layer_name: us_pumas
    html: <a href="{{puma._link}}" target="_self"> <span style="color:#4f565e;">{{ zip_to_puma_v2.name._value }}</span></a> ;;

    suggest_dimension: zip_to_puma_v2.name
    suggest_persist_for: "168 hours"

    link: {
      label: "View Census Map"
      url: "https://www2.census.gov/geo/maps/dc10map/PUMA_RefMap/st{{state._value}}_{{lower_case_state_abbrev._value}}/puma{{value}}/DC10PUMA{{value}}_001.pdf"
      icon_url: "http://www.google.com/s2/favicons?domain=https://www2.census.gov"
    }

  }

  dimension: state {
#     hidden: yes
    type: number
    sql: ${TABLE}.STATE ;;
  }

  dimension: state_abbreviation {
    label: "State"
    type: string
    sql: ${TABLE}.state_abbreviation ;;
    map_layer_name: us_states
  }

  dimension: lower_case_state_abbrev {
    hidden: yes
    type: string
    sql: lower(${state_abbreviation}) ;;
  }

  dimension: state_name {
    type: string
    sql: ${TABLE}.state_name ;;
  }

  dimension: zcta5 {
    hidden: yes
    label: "Zip"
    type: zipcode
    sql: ${TABLE}.ZCTA5 ;;
  }

  dimension: zip {
    type: zipcode
    sql: CASE
      WHEN LENGTH(cast(${zcta5} as string)) = 3 THEN CONCAT('00',${zcta5})
      WHEN LENGTH(cast(${zcta5} as string)) = 4 THEN CONCAT('0',${zcta5})
    ELSE cast(${zcta5} as string) END ;;
  }

  measure: count {
    hidden: yes
    type: count
    drill_fields: [state_name, name]
  }
}
