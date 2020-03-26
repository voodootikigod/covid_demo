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
    type: string
    sql: ${TABLE}.PUMA
    ;;
  }

  dimension: puma {
    label: "Public Use Microdata Area (PUMA)"
    type: string
    sql:CASE WHEN LENGTH(cast(${puma_raw} as string)) = 6 THEN CONCAT('0',${puma_raw}) ELSE cast(${puma_raw} as string) END ;;
    map_layer_name: us_pumas
    html: {{name._value}} ;;
  }

  dimension: state {
    hidden: yes
    type: number
    sql: ${TABLE}.STATE ;;
  }

  dimension: state_abbreviation {
    type: string
    sql: ${TABLE}.state_abbreviation ;;
    map_layer_name: us_states
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
