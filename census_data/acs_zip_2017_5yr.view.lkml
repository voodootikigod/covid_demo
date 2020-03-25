include: "acs_base_fields.view"

view: acs_zip_codes_2017_5yr {
  sql_table_name: `bigquery-public-data.census_bureau_acs.zip_codes_2017_5yr`;;
  extends: [acs_base_fields]

  dimension: geo_id {
    label: "Zipcode"
    type: zipcode
  }

  measure: population_density {
    description: "Resident per Square Mile"
    view_label: "Demographic Populations"
    type: number
    sql: 1.0*${total_pop}/nullif(${us_zipcode_boundaries.total_area_land_meters}/2590000,0);;

  }

}


view: zipcode_facts {
  derived_table: {
    sql: SELECT
        us_zipcode_boundaries.zip_code  AS us_zipcode_boundaries_zip_code,
        1.0*(COALESCE(SUM(acs_zip_codes_2017_5yr.total_pop ), 0))/nullif((COALESCE(SUM(us_zipcode_boundaries.area_land_meters ), 0))/2590000,0) AS acs_zip_codes_2017_5yr_population_density
      FROM `bigquery-public-data.census_bureau_acs.zip_codes_2017_5yr` AS acs_zip_codes_2017_5yr
      LEFT JOIN `bigquery-public-data.geo_us_boundaries.zip_codes` AS us_zipcode_boundaries ON acs_zip_codes_2017_5yr.geo_id = us_zipcode_boundaries.zip_code

      GROUP BY 1
       ;;
  }

  dimension: us_zipcode_boundaries_zip_code {
    primary_key: yes
    hidden: yes
    type: string
    sql: ${TABLE}.us_zipcode_boundaries_zip_code ;;
  }

  dimension: population_density {
    hidden: yes
    type: number
    sql: ${TABLE}.acs_zip_codes_2017_5yr_population_density ;;
  }

  dimension: zipcode_population_density_tier {
    description: "The population density group for the zipcode"
    view_label: "Demographic Populations"
    type: tier
    sql: ${population_density} ;;
    tiers: [50,100,500,1000,2000,3000,4000,5000,10000]
    style: integer
  }

  dimension: is_high_risk_zipcode {
    view_label: "Demographic Populations"
    description: "Zipcode has more than 5000 residents per square mile"
    type: yesno
    sql: ${population_density}>10000 ;;
  }

  measure: residents_in_highrisk_zips {
    view_label: "Demographic Populations"
    description: "Number of residents that live in high risk zipcodes"
    type: sum
    sql: ${acs_zip_codes_2017_5yr.total_pop_d};;
    filters: {
      field: is_high_risk_zipcode
      value: "yes"
    }
  }

  measure: percent_residents_in_highrisk_zips {
    view_label: "Demographic Populations"
    description: "Number of residents that live in high risk zipcodes"
    type: number
    sql: 1.0*${residents_in_highrisk_zips}/nullif(${acs_zip_codes_2017_5yr.total_pop},0);;
    value_format_name: percent_2
  }

  measure: count {
    type: count
    view_label: "Geographic Areas"
    label: "Number of Zipcodes"
    drill_fields: [us_zipcode_boundaries_zip_code.zip_code]
  }


}
