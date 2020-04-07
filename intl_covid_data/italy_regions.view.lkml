view: italy_regions {
  # SRC: https://github.com/pcm-dpc/COVID-19/blob/master/dati-regioni/dpc-covid19-ita-regioni.csv
  derived_table: {
    sql:
    SELECT
      date(ir.data) as data
      , ir.denominazione_regione
      , ir.codice_regione
      , ir.ricoverati_con_sintomi
      , ricoverati_con_sintomi - coalesce(LAG(ricoverati_con_sintomi, 1) OVER (PARTITION BY ir.denominazione_regione, ir.codice_regione ORDER BY ir.data ASC),0) as ricoverati_con_sintomi_cambio
      , ir.terapia_intensiva
      , terapia_intensiva - coalesce(LAG(terapia_intensiva, 1) OVER (PARTITION BY ir.denominazione_regione, ir.codice_regione ORDER BY ir.data ASC),0) as terapia_intensiva_cambio
      , ir.totale_ospedalizzati
      , totale_ospedalizzati - coalesce(LAG(totale_ospedalizzati, 1) OVER (PARTITION BY ir.denominazione_regione, ir.codice_regione ORDER BY ir.data ASC),0) as totale_ospedalizzati_cambio
      , ir.isolamento_domiciliare
      , isolamento_domiciliare - coalesce(LAG(isolamento_domiciliare, 1) OVER (PARTITION BY ir.denominazione_regione, ir.codice_regione ORDER BY ir.data ASC),0) as isolamento_domiciliare_cambio
      , ir.totale_positivi
      , ir.variazione_totale_positivi
      , ir.dimessi_guariti
      , dimessi_guariti - coalesce(LAG(dimessi_guariti, 1) OVER (PARTITION BY ir.denominazione_regione, ir.codice_regione ORDER BY ir.data ASC),0) as dimessi_guariti_nuovi
      , ir.deceduti
      , deceduti - coalesce(LAG(deceduti, 1) OVER (PARTITION BY ir.denominazione_regione, ir.codice_regione ORDER BY ir.data ASC),0) as deceduti_nuovi
      , ir.totale_casi as totale_casi_regione
      , ir.totale_casi - coalesce(LAG(ir.totale_casi, 1) OVER (PARTITION BY ir.denominazione_regione, ir.codice_regione ORDER BY ir.data ASC),0) as totale_casi_nuovi_regione
      , ir.tamponi
      , tamponi - coalesce(LAG(tamponi, 1) OVER (PARTITION BY ir.denominazione_regione, ir.codice_regione ORDER BY ir.data ASC),0) as tamponi_nuovi
    FROM
      `lookerdata.covid19.italy_regions` ir
    WHERE
      data is not null
      AND denominazione_regione is not null
      ;;
    sql_trigger_value: SELECT COUNT(*) FROM `lookerdata.covid19.italy_regions` WHERE codice_regione is not null ;;
  }


######## PRIMARY KEY ########

  dimension: pk {
    primary_key: yes
    # Need both the name and code of each region because they're reporting Bolzano and Trento on their own rows despite their both being in region 4
    sql: concat(${nome_reg}, ${codice_regione}, ${reporting_date}) ;;
    hidden: yes
  }

######## RAW DIMENSIONS ########

  dimension_group: reporting {
    type: time
    datatype: date
    timeframes: [
      date,
      week,
      month,
    ]
    sql: ${TABLE}.data ;;
  }

  dimension: denominazione_regione {
    type: string
    sql: ${TABLE}.denominazione_regione ;;
    hidden: yes
    label: "Region Name"
    description: "The name of the region in Italy, with Trento and Bolzano named separately (IT: Denominazione Regione)"
  }

  dimension: codice_regione {
    type: number
    sql: ${TABLE}.codice_regione ;;
    label: "Region Code"
    description: "The ISTAT code of the region in Italy, (IT: Codice della Regione)"
    drill_fields: [italy_province.denominazione_provincia]
  }

  dimension: ricoverati_con_sintomi {
    type: number
    hidden: yes
    label: "Currently hospitalized patients with symptoms"
  }

  dimension: ricoverati_con_sintomi_cambio {
    type: number
    hidden: yes
    label: "Change in hospitalized patients with symptoms"
  }

  dimension: terapia_intensiva {
    type: number
    hidden: yes
    label: "Current ICU patients"
  }

  dimension: terapia_intensiva_cambio {
    type: number
    hidden: yes
    label: "Change in ICU patients"
  }

  dimension: totale_ospedalizzati {
    type: number
    hidden: yes
    label: "Total hospitalized"
  }

  dimension: totale_ospedalizzati_cambio {
    type: number
    hidden: yes
    label: "Change in total hospitalized"
  }

  dimension: isolamento_domiciliare {
    type: number
    hidden: yes
    label: "Currently under home quarantine"
  }

  dimension: isolamento_domiciliare_cambio {
    type: number
    hidden: yes
    label: "Change in number under home quarantine"
  }

  dimension: totale_positivi {
    type: number
    hidden: yes
    label: "Total number of active cases (Hospitalized patients + Home confinement)"
  }

  dimension: variazione_totale_positivi {
    type: number
    hidden: yes
    label: "New amount of active cases (total number of active cases - total number of active cases from the previous day)"
  }

  dimension: dimessi_guariti {
    type: number
    hidden: yes
    label: "Recovered"
  }

  dimension: dimessi_guariti_nuovi {
    type: number
    hidden: yes
    label: "Newly recovered"
  }

  dimension: deceduti {
    type: number
    hidden: yes
    label: "Deceased"
  }

  dimension: deceduti_nuovi {
    type: number
    hidden: yes
    label: "Newly deceased"
  }

  dimension: totale_casi_regione {
    type: number
    hidden: yes
    label: "Total cases"
  }

  dimension: totale_casi_nuovi_regione {
    type: number
    hidden: yes
    label: "New cases"
  }

  dimension: tamponi {
    type: number
    hidden: yes
    label: "Tests"
  }

  dimension: tamponi_nuovi {
    type: number
    hidden: yes
    label: "New tests"
  }



######## NEW DIMENSIONS ########

#   dimension: is_max_date {
#     type: yesno
#     hidden: yes
#     sql: ${reporting_date} = ${max_date_italy.max_date_raw} ;;
#   }

  dimension: nome_reg {
    type: string
    sql: CASE
          WHEN ${denominazione_regione} = 'P.A. Bolzano'
          THEN 'Bolzano'
          WHEN ${denominazione_regione} = 'P.A. Trento'
          THEN 'Trento'
          WHEN ${denominazione_regione} in ('Emilia Romagna', 'Emilia-Romagna')
          THEN 'Emilia-Romagna'
          ELSE ${denominazione_regione}
        END
          ;;
    map_layer_name: regioni_italiani
    label: "Region Name"
    description: "The name of the region in Italy, (IT: Denominazione Regione)"
    drill_fields: [italy_provinces.denominazione_provincia]
  }

######## NEW MEASURES ########

  measure: currently_hospitalized {
    type: sum
    sql: {% if reporting_date._is_selected %}
            ${ricoverati_con_sintomi}
          {% else %}
            CASE WHEN ${reporting_date} = ${max_italy_date.max_date} THEN ${ricoverati_con_sintomi} ELSE NULL END
          {% endif %};;
    label: "Non-ICU hospitalizations"
    description: "Current number of patients hospitalized, excluding in ICU (IT: Ricoverati con sintomi), avail by region only"
    group_label: "Current cases by status"
  }

  measure: hospitalized_non_icu_pp {
    type: number
    sql: 1000* ${currently_hospitalized}/NULLIF(${population}, 0) ;;
    label: "Currently hospitalized (non-ICU) (per thousand)"
    group_label: "Current cases by status"
    value_format_name: decimal_2
  }


#   measure: currently_hospitalized_change {
#     type: sum
#     sql: ${ricoverati_con_sintomi_cambio} ;;
#     label: "Change hospitalized patients"
#     value_format: "#;-#"
#   }

  measure: icu {
    type: sum
    label: "Current ICU patients"
    sql: {% if reporting_date._is_selected %}
            ${terapia_intensiva}
          {% else %}
            CASE WHEN ${reporting_date} = ${max_italy_date.max_date} THEN ${terapia_intensiva} ELSE NULL END
          {% endif %};;
    description: "Current number of patients in ICU (IT: Terapia intensiva), avail by region only"
    group_label: "Current cases by status"
  }

  measure: icu_pp {
    type: number
    sql: 1000* ${icu}/NULLIF(${population}, 0) ;;
    label: "Current ICU patients (per thousand)"
    group_label: "Current cases by status"
    value_format_name: decimal_2
  }


#   dimension: terapia_intensiva_cambio {
#     type: number
#     hidden: yes
#     label: "Change in ICU patients"
#   }

  measure: total_hospitalized {
    type: sum
    sql:  {% if reporting_date._is_selected %}
            ${totale_ospedalizzati}
          {% else %}
            CASE WHEN ${reporting_date} = ${max_italy_date.max_date} THEN ${totale_ospedalizzati} ELSE NULL END
          {% endif %};;
    label: "All hospitalizations"
    description: "Current number of patients hospitalized, including in ICU (IT: Totale ospedalizzati), avail by region only"
    group_label: "Current cases by status"
  }

  measure: change_in_hospitalization {
    type: sum
    sql: ${totale_ospedalizzati_cambio} ;;
    label: "Change in total hospitalized"
    description: "Change in number of patients hospitalized from previous period, including in ICU (IT: Totale ospedalizzati cambio), avail by region only"
    group_label: "Current cases by status"
  }

  measure: hospitalized_pp {
    type: number
    sql: 1000* ${total_hospitalized}/NULLIF(${population}, 0) ;;
    label: "Current Hospitalized (incl ICU) (per thousand)"
    group_label: "Current cases by status"
    value_format_name: decimal_2
  }

  measure: home_quarantine {
    type: sum
    sql:  {% if reporting_date._is_selected %}
            ${isolamento_domiciliare}
          {% else %}
            CASE WHEN ${reporting_date} = ${max_italy_date.max_date} THEN ${isolamento_domiciliare} ELSE NULL END
          {% endif %};;
    label: "Currently under home quarantine"
    description: "Positive cases currently at home (IT: Isolamento domiciliare), avail by region only"
    group_label: "Current cases by status"
  }

  measure: home_quarantine_pp {
    type: number
    sql: 1000* ${home_quarantine}/NULLIF(${population}, 0) ;;
    label: "Current Home Quarantine (per thousand)"
    group_label: "Current cases by status"
    value_format_name: decimal_2
  }

  measure: total_active_cases {
    type: sum
    sql:  {% if reporting_date._is_selected %}
            ${totale_positivi}
          {% else %}
            CASE WHEN ${reporting_date} = ${max_italy_date.max_date} THEN ${totale_positivi} ELSE NULL END
          {% endif %};;
    label: "Total number of active cases"
    description: "Count of active cases including hospitalized patients + home confinement (IT: Totale attualmente positive), avail by region only"
    group_label: "Total cases"
  }

  measure: total_active_cases_pp {
    type: number
    sql: 1000* ${total_active_cases}/NULLIF(${population}, 0) ;;
    label: "Total Active Cases (per thousand)"
    group_label: "Total cases"
    value_format_name: decimal_2
  }

  measure: recovered {
    type: sum
    sql:  {% if reporting_date._is_selected %}
            ${dimessi_guariti}
          {% else %}
            CASE WHEN ${reporting_date} = ${max_italy_date.max_date} THEN ${dimessi_guariti} ELSE NULL END
          {% endif %};;
    label: "Recovered"
    description: "Running total of all patients who have recovered (IT: Dimessi guariti), avail by region only"
    group_label: "Resolved cases by status"
  }

  measure: total_recovered_pp {
    type: number
    sql: 1000* ${recovered}/NULLIF(${population}, 0) ;;
    label: "Total Recovered (per thousand)"
    group_label: "Resolved cases by status"
    value_format_name: decimal_2
  }

  measure: newly_recovered {
    type: sum
    sql: ${dimessi_guariti_nuovi} ;;
    label: "Newly recovered"
    description: "The count of patients who were reported recovered in that day (IT: Dimessi guariti nuovi), avail by region only"
    group_label: "Resolved cases by status"
  }

  measure: deceased {
    type: sum
    sql:  {% if reporting_date._is_selected %}
            ${deceduti}
          {% else %}
            CASE WHEN ${reporting_date} = ${max_italy_date.max_date} THEN ${deceduti} ELSE NULL END
          {% endif %};;
    label: "Deceased"
    description: "Running total of deaths (IT: Deceduti), avail by region only"
    group_label: "Resolved cases by status"
  }

  measure: total_deceased_pp {
    type: number
    sql: 1000* ${deceased}/NULLIF(${population}, 0) ;;
    label: "Total Deaths (per thousand)"
    group_label: "Resolved cases by status"
    value_format_name: decimal_2
  }

  measure: newly_deceased {
    type: sum
    sql: ${deceduti_nuovi} ;;
    label: "Newly deceased"
    description: "The count of deaths by day (IT: Deceduti nuovi), avail by region only"
    group_label: "Resolved cases by status"
  }


  measure: total_cases_region {
    type: sum
    sql:  {% if reporting_date._is_selected %}
            ${totale_casi_regione}
          {% else %}
            CASE WHEN ${reporting_date} = ${max_italy_date.max_date} THEN ${totale_casi_regione} ELSE NULL END
          {% endif %};;
    hidden: yes
  }

  measure: new_cases_region {
    type: sum
    sql:  ${totale_casi_nuovi_regione};;
    hidden: yes
  }

  measure: new_cases {
    type: number
    sql: {% if italy_province.denominazione_provincia._in_query  or italy_province.sigla_provincia._in_query %}
        ${italy_province.new_cases_province}
       {% else %}
      ${new_cases_region}
        {% endif %}
        ;;
      label: "New cases"
      description: "Newly confirmed cases by day (IT: Totale casi nuovi), avail by region or province"
      group_label: "Total cases"
      drill_fields: [italy_province.denominazione_provincia]
    }

  measure: tests_run {
    type: sum
    sql:  {% if reporting_date._is_selected %}
            ${tamponi}
          {% else %}
            CASE WHEN ${reporting_date} = ${max_italy_date.max_date} THEN ${tamponi} ELSE NULL END
          {% endif %};;
    label: "Tests run"
    description: "Running total of tests run (IT: Tamponi), avail by region only"
    group_label: "Testing"
  }

  measure: tests_pp {
    type: number
    sql: 1000* ${tests_run}/NULLIF(${population}, 0) ;;
    label: "Tests run (per thousand)"
    group_label: "Testing"
    value_format_name: decimal_2
  }


  measure: new_tests {
    type: sum
    sql: ${tamponi_nuovi} ;;
    label: "New tests run"
    description: "Count of tests run by day (IT: Tamponi nuovi), avail by region only"
    group_label: "Testing"
  }


  measure: max_date {
    sql: MAX(${reporting_date}) ;;
    type: date
    label: "Last Updated"
  }

  measure: population {
    type: number
    sql: COALESCE(${italy_province_stats.population}, ${italy_region_stats.population}) ;;
    label: "Population"
    value_format_name: decimal_0
  }

}


view: max_italy_date {
  derived_table: {
   sql: SELECT
    max(data) as max_date
  FROM
    `lookerdata.covid19.italy_regions`
  WHERE
    {% condition italy.reporting_date %} date(data) {% endcondition %} ;;
  }

  dimension: max_date {
    hidden: yes
    type: date
  }

}
