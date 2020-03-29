view: policies_by_state {
  sql_table_name: `lookerdata.covid19.policies_by_state`
    ;;

### PK

  dimension: state {
    primary_key: yes
    hidden: yes
    type: string
    sql: ${TABLE}.State ;;
  }

### Social Gatherings

  dimension: bar_restaurant_limits {
    group_label: "Social Gatherings"
    type: string
    sql: ${TABLE}.Bar_Restaurant_Limits ;;
    html:
    {% if value == 'None' %} <font color="red">{{ rendered_value }}</font>
    {% elsif value == 'Limited On-site Service' %} <font color="red">{{ rendered_value }}</font>
    {% elsif value == 'Closed except for takeout/delivery' %} <font color="green">{{ rendered_value }}</font>
    {% else %}                    <font color="black">{{ rendered_value }}</font>
    {% endif %} ;;
  }

  dimension: large_gatherings_ban {
    group_label: "Social Gatherings"
    type: string
    sql: ${TABLE}.Large_Gatherings_Ban ;;
      html:
      {% if value == 'None' %} <font color="red">{{ rendered_value }}</font>
      {% elsif value == 'All Gatherings Prohibited' %} <font color="green">{{ rendered_value }}</font>
      {% else %}                    <font color="black">{{ rendered_value }}</font>
      {% endif %} ;;
  }

  dimension_group: stay_order {
    group_label: "Social Gatherings"
    type: time
    timeframes: [
      raw,
      date,
    ]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.Stay_Order_Date ;;
  }

  dimension: stay_order_policy {
    group_label: "Social Gatherings"
    type: string
    sql: ${TABLE}.Stay_Order_Policy ;;
    html:
    {% if value == 'No policy' %} <font color="red">{{ rendered_value }}</font>
    {% else %}                    <font color="green">{{ rendered_value }}</font>
    {% endif %} ;;
  }

  dimension: stay_order_reach {
    group_label: "Social Gatherings"
    type: string
    sql: ${TABLE}.Stay_Order_Reach ;;
    html:
    {% if value == 'No Counties' %} <font color="red">{{ rendered_value }}</font>
    {% elsif value == 'State-wide' %} <font color="green">{{ rendered_value }}</font>
    {% else %}                    <font color="black">{{ rendered_value }}</font>
    {% endif %} ;;
  }

  dimension: non_essential_business_closures {
    group_label: "Social Gatherings"
    type: string
    sql: ${TABLE}.Non_Essential_Business_Closures ;;
    html:
    {% if value == 'None' %} <font color="red">{{ rendered_value }}</font>
    {% elsif value == 'All Non-Essential Businesses' %} <font color="green">{{ rendered_value }}</font>
    {% else %}                    <font color="black">{{ rendered_value }}</font>
    {% endif %} ;;
  }

  dimension: primary_election_postponement {
    group_label: "Social Gatherings"
    type: string
    sql: ${TABLE}.Primary_Election_Postponement ;;
  }

  dimension: state_mandated_school_closures {
    group_label: "Social Gatherings"
    type: string
    sql: ${TABLE}.State_Mandated_School_Closures ;;
    html:
    {% if value == 'No' %} <font color="red">{{ rendered_value }}</font>
    {% elsif value == 'Yes' %} <font color="green">{{ rendered_value }}</font>
    {% elsif value == 'Effectively Closed' %} <font color="green">{{ rendered_value }}</font>
    {% else %}                    <font color="black">{{ rendered_value }}</font>
    {% endif %} ;;
  }

### Policy

  dimension: early_prescription_refills {
    group_label: "Policy"
    type: string
    sql: ${TABLE}.Early_Prescription_Refills ;;
    html:
      {% if value == 'No policy' %} <font color="red">{{ rendered_value }}</font>
      {% else %}                    <font color="green">{{ rendered_value }}</font>
      {% endif %} ;;
  }

  dimension: emergency_declaration {
    group_label: "Policy"
    type: yesno
    sql: ${TABLE}.Emergency_Declaration ;;
    html:
    {% if value == 'No policy' %} <font color="red">{{ rendered_value }}</font>
    {% else %}                    <font color="green">{{ rendered_value }}</font>
    {% endif %} ;;
  }

  dimension: free_cost_vaccine_when_available {
    group_label: "Policy"
    type: string
    sql: ${TABLE}.Free_Cost_Vaccine_When_Available ;;
    html:
    {% if value == 'No policy' %} <font color="red">{{ rendered_value }}</font>
    {% else %}                    <font color="green">{{ rendered_value }}</font>
    {% endif %} ;;
  }

  dimension: marketplace_special_enrollment_period__sep_ {
    group_label: "Policy"
    type: string
    sql: ${TABLE}.Marketplace_Special_Enrollment_Period__SEP_ ;;
    html:
    {% if value == 'No policy' %} <font color="red">{{ rendered_value }}</font>
    {% else %}                    <font color="green">{{ rendered_value }}</font>
    {% endif %} ;;
  }

  dimension: paid_sick_leave {
    group_label: "Policy"
    type: string
    sql: ${TABLE}.Paid_Sick_Leave ;;
    html:
    {% if value == 'No policy' %} <font color="red">{{ rendered_value }}</font>
    {% else %}                    <font color="green">{{ rendered_value }}</font>
    {% endif %} ;;
  }

  dimension: section_1135_waiver {
    group_label: "Policy"
    type: string
    sql: ${TABLE}.Section_1135_Waiver ;;
    html:
    {% if value == 'No policy' %} <font color="red">{{ rendered_value }}</font>
    {% else %}                    <font color="green">{{ rendered_value }}</font>
    {% endif %} ;;
  }

  dimension: state_requires_waiver_of_prior_authorization_requirements {
    group_label: "Policy"
    type: string
    sql: ${TABLE}.State_Requires_Waiver_of_Prior_Authorization_Requirements ;;
    html:
    {% if value == 'No policy' %} <font color="red">{{ rendered_value }}</font>
    {% else %}                    <font color="green">{{ rendered_value }}</font>
    {% endif %} ;;
  }

  dimension: waive_cost_sharing_for_covid_19_treatment {
    group_label: "Policy"
    type: string
    sql: ${TABLE}.Waive_Cost_Sharing_for_COVID_19_Treatment ;;
    html:
    {% if value == 'No policy' %} <font color="red">{{ rendered_value }}</font>
    {% else %}                    <font color="green">{{ rendered_value }}</font>
    {% endif %} ;;
  }

  measure: count {
    hidden: yes
    type: count
    drill_fields: []
  }
}
