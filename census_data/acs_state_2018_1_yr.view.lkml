include: "acs_base_fields.view"

view: acs_state_2018_1yr {
  sql_table_name: `bigquery-public-data.census_bureau_acs.state_2018_1yr`;;
  extends: [acs_base_fields]

  dimension: geo_id {
    label: "State"
  }

}
