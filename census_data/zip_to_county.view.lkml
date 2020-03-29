view: zip_to_county {
  sql_table_name: `lookerdata.covid19.zip_to_county_master`
    ;;

  ## DIMENSIONS (NOTE: not all brought in from table) ##

  dimension: primary_key {
    type:string
    primary_key: yes
    sql: CONCAT(${zip}, ${county}) ;;
    hidden: yes
  }

  dimension: county_raw {
    hidden: yes
    type: number
    sql: ${TABLE}.GEOID ;;
  }

  dimension: county {
    hidden: yes
    type: string
    sql: CASE WHEN LENGTH(cast(${county_raw} as string)) = 4 THEN CONCAT('0',${county_raw})
    ELSE cast(${county_raw} as string) END ;;
  }

  dimension: pct_zip_pop_in_county {
    hidden: yes
    type: number
    sql: (${TABLE}.ZPOPPCT) / 100.0  ;;
    value_format_name: percent_3
  }

  dimension: pct_county_pop_in_zip {
    hidden: yes
    type: number
    sql: (${TABLE}.COPOPPCT) / 100.0 ;;
    value_format_name: percent_3
  }

  dimension: zcta5 {
    hidden: yes
    type: number
    sql: ${TABLE}.ZCTA5 ;;
  }

  dimension: zip {
    hidden: yes
    type: zipcode
    sql: CASE
      WHEN LENGTH(cast(${zcta5} as string)) = 3 THEN CONCAT('00',${zcta5})
      WHEN LENGTH(cast(${zcta5} as string)) = 4 THEN CONCAT('0',${zcta5})
    ELSE cast(${zcta5} as string) END ;;
  }

}
