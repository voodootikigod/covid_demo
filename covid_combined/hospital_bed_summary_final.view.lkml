view: hospital_bed_summary_final {
  sql_table_name: `lookerdata.covid19.hospital_bed_summary_final`
    ;;

  dimension: pk {
    primary_key: yes
    type: string
    sql: ${objectid} ;;
  }

  dimension: bed_utilization {
    type: number
    sql: ${TABLE}.BED_UTILIZATION ;;
  }

  dimension: cnty_fips {
    type: number
    sql: ${TABLE}.CNTY_FIPS ;;
  }

  dimension: county_name {
    type: string
    sql: ${TABLE}.COUNTY_NAME ;;
  }

  dimension: county_num_icu_beds {
    type: number
    sql: ${TABLE}.county_num_icu_beds ;;
  }

  dimension: county_num_licensed_beds {
    type: number
    sql: ${TABLE}.county_num_licensed_beds ;;
  }

  dimension: county_num_staffed_beds {
    type: number
    sql: ${TABLE}.county_num_staffed_beds ;;
  }

  dimension: fips {
    type: number
    sql: ${TABLE}.FIPS ;;
  }

  dimension: hospital_name {
    type: string
    sql: ${TABLE}.HOSPITAL_NAME ;;
  }

  dimension: hospital_type {
    type: string
    sql: ${TABLE}.HOSPITAL_TYPE ;;
  }

  dimension: hq_address {
    type: string
    sql: ${TABLE}.HQ_ADDRESS ;;
  }

  dimension: hq_address1 {
    type: string
    sql: ${TABLE}.HQ_ADDRESS1 ;;
  }

  dimension: hq_city {
    type: string
    sql: ${TABLE}.HQ_CITY ;;
  }

  dimension: hq_state {
    type: string
    sql: ${TABLE}.HQ_STATE ;;
  }

  dimension: hq_zip_code {
    type: number
    sql: ${TABLE}.HQ_ZIP_CODE ;;
  }

  dimension: lat {
    type: number
    sql: ${TABLE}.Lat ;;
  }

  dimension: long {
    type: number
    sql: ${TABLE}.Long ;;
  }

  dimension: num_icu_beds {
    type: number
    sql: ${TABLE}.NUM_ICU_BEDS ;;
  }

  dimension: num_licensed_beds {
    type: number
    sql: ${TABLE}.NUM_LICENSED_BEDS ;;
  }

  dimension: num_staffed_beds {
    type: number
    sql: ${TABLE}.NUM_STAFFED_BEDS ;;
  }

  dimension: objectid {
    primary_key: yes
    type: number
    value_format_name: id
    sql: ${TABLE}.OBJECTID ;;
  }

  dimension: potential_increase_in_bed_capac {
    type: number
    sql: ${TABLE}.Potential_Increase_In_Bed_Capac ;;
  }

  dimension: state_fips {
    type: number
    sql: ${TABLE}.STATE_FIPS ;;
  }

  dimension: state_name {
    type: string
    sql: ${TABLE}.STATE_NAME ;;
  }

  measure: count {
    type: count
    drill_fields: [hospital_name, state_name, county_name]
  }
}
