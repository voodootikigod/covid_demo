view: population_by_county_state_country {
  derived_table: {
    datagroup_trigger: covid_data
    sql:
      SELECT a.*, b.area_land_meters
      FROM
      (
         SELECT * FROM `lookerdata.covid19.population_by_county_state_country` UNION ALL
         SELECT 36005 as fips,'Bronx' as county,'New York' as province_state,'US' as country_region,1432000 as population, 1 as count UNION ALL
         SELECT 36081 as fips,'Queens' as county,'New York' as province_state,'US' as country_region,2273000 as population, 1 as count UNION ALL
         SELECT 36061 as fips,'New York County' as county,'New York' as province_state,'US' as country_region,1629000 as population, 1 as count UNION ALL
         SELECT 36047 as fips,'Brooklyn' as county,'New York' as province_state,'US' as country_region,2533000 as population, 1 as count UNION ALL
         SELECT 36085 as fips,'Richmond' as county,'New York' as province_state,'US' as country_region,476000 as population, 1 as count
      ) a
      LEFT JOIN `bigquery-public-data.utility_us.us_county_area` b
        ON cast(a.fips as int64) = cast(b.geo_id as int64)
       WHERE province_state = 'New York'
    ;;
  }
  # sql_table_name: `lookerdata.covid19.population_by_county_state_country` ;;

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

  dimension: area_land_meters {
    hidden: yes
    type: number
    sql: ${TABLE}.area_land_meters ;;
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

  measure: sum_area_land_meters {
    label: "Total Land Area"
    type: sum
    sql: ${area_land_meters} ;;
  }

  measure: population_density {
    description: "People per 1000 Sq. Kilometers"
    type: number
    sql: 1000000.0*${sum_population}/nullif(${sum_area_land_meters},0) ;;
    value_format_name: decimal_1
  }

  measure: count {
    hidden: yes
    type: count
    drill_fields: []
  }
}
