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
      , ir.totale_attualmente_positivi
      , ir.nuovi_attualmente_positivi
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
    sql_trigger_value: SELECT COUNT(*) FROM `lookerdata.covid19.italy_regions` ;;
  }


######## PRIMARY KEY ########

  dimension: pk {
    primary_key: yes
    sql: concat(${denominazione_regione}, ${codice_regione}, ${reporting_date}) ;;
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

  dimension: totale_attualmente_positivi {
    type: number
    hidden: yes
    label: "Total number of active cases (Hospitalized patients + Home confinement)"
  }

  dimension: nuovi_attualmente_positivi {
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
          WHEN ${denominazione_regione} = 'Emilia Romagna'
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
#     hidden: yes
    type: number
    sql: ARRAY_AGG(${ricoverati_con_sintomi} IGNORE NULLS ORDER BY ${reporting_date} DESC LIMIT 1)[SAFE_ORDINAL(1)];;
    label: "Non-ICU hospitalizations"
    description: "Current number of patients hospitalized, excluding in ICU (IT: Ricoverati con sintomi), avail by region only"
    group_label: "Current cases by status"
  }

#   measure: currently_hospitalized_change {
#     type: sum
#     sql: ${ricoverati_con_sintomi_cambio} ;;
#     label: "Change hospitalized patients"
#     value_format: "#;-#"
#   }

  measure: icu {
    type: number
    label: "Current ICU patients"
    sql: ARRAY_AGG(${terapia_intensiva} IGNORE NULLS ORDER BY ${reporting_date} DESC LIMIT 1)[SAFE_ORDINAL(1)];;
    description: "Current number of patients in ICU (IT: Terapia intensiva), avail by region only"
    group_label: "Current cases by status"
  }

#   dimension: terapia_intensiva_cambio {
#     type: number
#     hidden: yes
#     label: "Change in ICU patients"
#   }

  measure: total_hospitalized {
    type: number
    sql: ARRAY_AGG(${totale_ospedalizzati} IGNORE NULLS ORDER BY ${reporting_date} DESC LIMIT 1)[SAFE_ORDINAL(1)];;
    label: "All hospitalizations"
    description: "Current number of patients hospitalized, including in ICU (IT: Totale ospedalizzati), avail by region only"
    group_label: "Current cases by status"
  }

#   dimension: totale_ospedalizzati_cambio {
#     type: number
#     hidden: yes
#     label: "Change in total hospitalized"
#   }
#
  measure: home_quarantine {
    type: number
    sql: ARRAY_AGG(${isolamento_domiciliare} IGNORE NULLS ORDER BY ${reporting_date} DESC LIMIT 1)[SAFE_ORDINAL(1)];;
    label: "Currently under home quarantine"
    description: "Positive cases currently at home (IT: Isolamento domiciliare), avail by region only"
    group_label: "Current cases by status"
  }
#
#   dimension: isolamento_domiciliare_cambio {
#     type: number
#     hidden: yes
#     label: "Change in number under home quarantine"
#   }
#
  measure: total_active_cases {
    type: number
    sql: ARRAY_AGG(${totale_attualmente_positivi} IGNORE NULLS ORDER BY ${reporting_date} DESC LIMIT 1)[SAFE_ORDINAL(1)];;
    label: "Total number of active cases"
    description: "Count of active cases including hospitalized patients + home confinement (IT: Totale attualmente positive), avail by region only"
    group_label: "Total cases"
  }
#
#   dimension: nuovi_attualmente_positivi {
#     type: number
#     hidden: yes
#     label: "New amount of active cases (total number of active cases - total number of active cases from the previous day)"
#   }
#
  measure: recovered {
    type: number
    sql: ARRAY_AGG(${dimessi_guariti} IGNORE NULLS ORDER BY ${reporting_date} DESC)[SAFE_ORDINAL(1)];;
    label: "Recovered"
    description: "Running total of all patients who have recovered (IT: Dimessi guariti), avail by region only"
    group_label: "Resolved cases by status"
  }

  measure: newly_recovered {
    type: sum
    sql: ${dimessi_guariti_nuovi} ;;
    label: "Newly recovered"
    description: "The count of patients who were reported recovered in that day (IT: Dimessi guariti nuovi), avail by region only"
    group_label: "Resolved cases by status"
  }

  measure: deceased {
    type: number
    sql: ARRAY_AGG(${deceduti} IGNORE NULLS ORDER BY ${reporting_date} DESC LIMIT 1)[SAFE_ORDINAL(1)];;
    label: "Deceased"
    description: "Running total of deaths (IT: Deceduti), avail by region only"
    group_label: "Resolved cases by status"
  }

  measure: newly_deceased {
    type: sum
    sql: ${deceduti_nuovi} ;;
    label: "Newly deceased"
    description: "The count of deaths by day (IT: Deceduti nuovi), avail by region only"
    group_label: "Resolved cases by status"
  }


  measure: total_cases_region {
    type: number
    sql:  ARRAY_AGG(${totale_casi_regione} IGNORE NULLS ORDER BY ${reporting_date} DESC LIMIT 1)[SAFE_ORDINAL(1)];;
    hidden: yes
  }

  measure: total_cases {
    type: number
    sql: {% if italy_province.denominazione_provincia._in_query  or italy_province.sigla_provincia._in_query %}
          ${italy_province.total_cases_province}
         {% else %}
        ${total_cases_region}
          {% endif %}
    ;;
    label: "Total cases"
    description: "Running total of confirmed cases (IT: Totale casi), avail by region or province"
    group_label: "Total cases"
    drill_fields: [italy_province.denominazione_provincia]
  }

  measure: new_cases_region {
    type: number
    sql:  ARRAY_AGG(${totale_casi_nuovi_regione} IGNORE NULLS ORDER BY ${reporting_date} DESC LIMIT 1)[SAFE_ORDINAL(1)];;
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
    type: number
    sql: ARRAY_AGG(${tamponi} IGNORE NULLS ORDER BY ${reporting_date} DESC LIMIT 1)[SAFE_ORDINAL(1)];;
    label: "Tests run"
    description: "Running total of tests run (IT: Tamponi), avail by region only"
    group_label: "Testing"
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
    label: "Last Update Date"
  }

}
