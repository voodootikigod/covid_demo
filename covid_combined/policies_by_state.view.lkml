# explore:  policies_by_state {}

view: policies_by_state {
  derived_table: {
    datagroup_trigger: covid_data
    sql:

SELECT
    state
  , CASE WHEN Bar__Restaurant_Limits = '-' THEN 'None' ELSE Bar__Restaurant_Limits END as Bar__Restaurant_Limits
  , CASE WHEN Mandatory_Quarantine IS NULL THEN 'None' ELSE Mandatory_Quarantine END as Mandatory_Quarantine
  , CASE WHEN Non_Essential_Business_Closures = '-' THEN 'None' ELSE Non_Essential_Business_Closures END as Non_Essential_Business_Closures
  , Emergency_Declaration
  , Primary_Election_Postponement
  , CASE WHEN State_Mandated_School_Closures = '-' THEN 'None' ELSE State_Mandated_School_Closures END as State_Mandated_School_Closures
  , CASE WHEN Large_Gatherings_Ban = '-' THEN 'None' ELSE Large_Gatherings_Ban END as Large_Gatherings_Ban
  , CASE WHEN Waive_Cost_Sharing_for_COVID_19_Treatment = '-' THEN 'No policy' ELSE Waive_Cost_Sharing_for_COVID_19_Treatment END as Waive_Cost_Sharing_for_COVID_19_Treatment
  , CASE WHEN Free_Cost_Vaccine_When_Available = '-' THEN 'No policy' ELSE Free_Cost_Vaccine_When_Available END as Free_Cost_Vaccine_When_Available
  , CASE WHEN State_Requires_Waiver_of_Prior_Authorization_Requirements = '-' THEN 'No policy' ELSE State_Requires_Waiver_of_Prior_Authorization_Requirements END as State_Requires_Waiver_of_Prior_Authorization_Requirements
  , CASE WHEN Early_Prescription_Refills = '-' THEN 'No policy' ELSE Early_Prescription_Refills END as Early_Prescription_Refills
  , CASE WHEN Marketplace_Special_Enrollment_Period__SEP_ = '-' THEN 'No policy' ELSE Marketplace_Special_Enrollment_Period__SEP_ END as Marketplace_Special_Enrollment_Period__SEP_
  , CASE WHEN Section_1135_Waiver = '-' THEN 'Not approved' ELSE Section_1135_Waiver END as Section_1135_Waiver
  , CASE WHEN Paid_Sick_Leave = '-' THEN 'No policy' ELSE Paid_Sick_Leave END as Paid_Sick_Leave
FROM
(
  SELECT
      coalesce(a.Location,b.Location)  as state
    , a.Bar__Restaurant_Limits
    , a.Mandatory_Quarantine
    , a.Non_Essential_Business_Closures
    , a.Emergency_Declaration
    , a.Primary_Election_Postponement
    , a.State_Mandated_School_Closures
    , a.Large_Gatherings_Ban
    , b.Waive_Cost_Sharing_for_COVID_19_Treatment
    , b.Free_Cost_Vaccine_When_Available
    , b.State_Requires_Waiver_of_Prior_Authorization_Requirements
    , b.Early_Prescription_Refills
    , b.Marketplace_Special_Enrollment_Period__SEP_
    , b.Section_1135_Waiver
    , b.Paid_Sick_Leave
  FROM `lookerdata.covid19.state_mitigations_staging` a
  LEFT JOIN `lookerdata.covid19.state_policy_attempt2` b
    ON a.Location = b.Location
) a

    ;;
  }
  # sql_table_name: `lookerdata.covid19.state_policy_combined_final`

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
    sql: ${TABLE}.Bar__Restaurant_Limits ;;
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

#   dimension_group: stay_order {
#     group_label: "Social Gatherings"
#     type: time
#     timeframes: [
#       raw,
#       date,
#     ]
#     convert_tz: no
#     datatype: date
#     sql: ${TABLE}.Stay_Order_Date ;;
#   }
#
#   dimension: stay_order_policy {
#     group_label: "Social Gatherings"
#     type: string
#     sql: ${TABLE}.Stay_Order_Policy ;;
#     html:
#     {% if value == 'No policy' %} <font color="red">{{ rendered_value }}</font>
#     {% else %}                    <font color="green">{{ rendered_value }}</font>
#     {% endif %} ;;
#   }
#
#   dimension: stay_order_reach {
#     group_label: "Social Gatherings"
#     type: string
#     sql: ${TABLE}.Stay_Order_Reach ;;
#     html:
#     {% if value == 'No Counties' %} <font color="red">{{ rendered_value }}</font>
#     {% elsif value == 'State-wide' %} <font color="green">{{ rendered_value }}</font>
#     {% else %}                    <font color="black">{{ rendered_value }}</font>
#     {% endif %} ;;
#   }

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
      {% elsif value == 'Not approved' %} <font color="black">{{ rendered_value }}</font>
      {% else %}                    <font color="green">{{ rendered_value }}</font>
      {% endif %} ;;
  }

  dimension: emergency_declaration {
    group_label: "Policy"
    type: yesno
    sql: ${TABLE}.Emergency_Declaration ;;
    html:
    {% if value == 'No policy' %} <font color="red">{{ rendered_value }}</font>
    {% elsif value == 'Not approved' %} <font color="black">{{ rendered_value }}</font>
    {% else %}                    <font color="green">{{ rendered_value }}</font>
    {% endif %} ;;
  }

  dimension: free_cost_vaccine_when_available {
    group_label: "Policy"
    type: string
    sql: ${TABLE}.Free_Cost_Vaccine_When_Available ;;
    html:
    {% if value == 'No policy' %} <font color="red">{{ rendered_value }}</font>
    {% elsif value == 'Not approved' %} <font color="black">{{ rendered_value }}</font>
    {% else %}                    <font color="green">{{ rendered_value }}</font>
    {% endif %} ;;
  }

  dimension: marketplace_special_enrollment_period__sep_ {
    group_label: "Policy"
    type: string
    sql: ${TABLE}.Marketplace_Special_Enrollment_Period__SEP_ ;;
    html:
    {% if value == 'No policy' %} <font color="red">{{ rendered_value }}</font>
    {% elsif value == 'Not approved' %} <font color="black">{{ rendered_value }}</font>
    {% else %}                    <font color="green">{{ rendered_value }}</font>
    {% endif %} ;;
  }

  dimension: paid_sick_leave {
    group_label: "Policy"
    type: string
    sql: ${TABLE}.Paid_Sick_Leave ;;
    html:
    {% if value == 'No policy' %} <font color="red">{{ rendered_value }}</font>
    {% elsif value == 'Not approved' %} <font color="black">{{ rendered_value }}</font>
    {% elsif value == 'Enacted' %} <font color="green">{{ rendered_value }}</font>
    {% else %}                    <font color="black">{{ rendered_value }}</font>
    {% endif %} ;;
  }

  dimension: section_1135_waiver {
    group_label: "Policy"
    type: string
    sql: ${TABLE}.Section_1135_Waiver ;;
    html:
    {% if value == 'No policy' %} <font color="red">{{ rendered_value }}</font>
    {% elsif value == 'Not approved' %} <font color="black">{{ rendered_value }}</font>
    {% else %}                    <font color="green">{{ rendered_value }}</font>
    {% endif %} ;;
  }

  dimension: state_requires_waiver_of_prior_authorization_requirements {
    group_label: "Policy"
    type: string
    sql: ${TABLE}.State_Requires_Waiver_of_Prior_Authorization_Requirements ;;
    html:
    {% if value == 'No policy' %} <font color="red">{{ rendered_value }}</font>
    {% elsif value == 'Not approved' %} <font color="black">{{ rendered_value }}</font>
    {% else %}                    <font color="green">{{ rendered_value }}</font>
    {% endif %} ;;
  }

  dimension: waive_cost_sharing_for_covid_19_treatment {
    group_label: "Policy"
    type: string
    sql: ${TABLE}.Waive_Cost_Sharing_for_COVID_19_Treatment ;;
    html:
    {% if value == 'No policy' %} <font color="red">{{ rendered_value }}</font>
    {% elsif value == 'Not approved' %} <font color="black">{{ rendered_value }}</font>
    {% else %}                    <font color="green">{{ rendered_value }}</font>
    {% endif %} ;;
  }

#   dimension: score_stay_order_policy {
#     hidden: yes
#     type: number
#     sql:
#       CASE
#         WHEN ${stay_order_policy} = 'No policy' then 0
#         WHEN ${stay_order_reach} = 'State-wide' then 1
#         ELSE 0.5
#       END
#     ;;
#   }

  dimension: score_non_essential_business_closures {
    hidden: yes
    type: number
    sql:
      CASE
        WHEN ${non_essential_business_closures} = 'None' then 0
        WHEN ${non_essential_business_closures} = 'All Non-Essential Businesses' then 1
        WHEN ${non_essential_business_closures} = 'All Non-Essential Retail Businesses' then 0.75
        ELSE 0.5
      END
    ;;
  }

  dimension: score_large_gatherings_ban {
    hidden: yes
    type: number
    sql:
      CASE
        WHEN ${large_gatherings_ban} = 'None' then 0
        WHEN ${large_gatherings_ban} = 'All Gatherings Prohibited' then 1
        ELSE 0.5
      END
    ;;
  }

  dimension: score_bar_restaurant_limits {
    hidden: yes
    type: number
    sql:
      CASE
        WHEN ${bar_restaurant_limits} = 'None' then 0
        WHEN ${bar_restaurant_limits} = 'Limited On-site Service' then 0.5
        WHEN ${bar_restaurant_limits} = 'Closed except for takeout/delivery' then 1
        ELSE 0.5
      END
    ;;
  }

  dimension: score_state_mandated_school_closures {
    hidden: yes
    type: number
    sql:
      CASE
        WHEN ${state_mandated_school_closures} = 'No' then 0
        WHEN ${state_mandated_school_closures} = 'Yes' then 1
        WHEN ${state_mandated_school_closures} = 'Effectively Closed' then 0.75
        ELSE 0.5
      END
    ;;
  }

  dimension: score_emergency_declaration {
    hidden: yes
    type: number
    sql:
      CASE
        WHEN ${emergency_declaration} = FALSE then 0
        WHEN ${emergency_declaration} = TRUE then 1
        ELSE 0.25
      END
    ;;
  }

  dimension: score_paid_sick_leave {
    hidden: yes
    type: number
    sql:
      CASE
        WHEN ${paid_sick_leave} = 'No policy' then 0
        WHEN ${paid_sick_leave} = 'Not approved' then 0.25
        WHEN ${paid_sick_leave} = 'Enacted' then 1
        ELSE 0.25
      END
    ;;
  }

  dimension: policy_score {
    hidden: yes
    type: number
    # (${score_stay_order_policy} * 35) +
    sql:
      (
        (${score_non_essential_business_closures} * 25) +
        (${score_large_gatherings_ban} * 20) +
        (${score_bar_restaurant_limits} * 20) +
        (${score_state_mandated_school_closures} * 15) +
        (${score_emergency_declaration} * 10) +
        (${score_paid_sick_leave} * 10)
      ) / 100.0
    ;;
  }

  measure: average_policy_score {
    label: "Policy Score"
    type: average
    sql: ${policy_score} ;;
    value_format_name: percent_0
  }

  measure: count {
    hidden: yes
    type: count
    drill_fields: []
  }
}
