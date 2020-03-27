view: italy_regions {
  # SRC: https://github.com/pcm-dpc/COVID-19/blob/master/dati-regioni/dpc-covid19-ita-regioni.csv
  derived_table: {
    sql:
    SELECT
      date(ir.data) as data
      , ir.denominazione_regione
      , ir.codice_regione
      , "In fase di definizione/aggiornamento" as denominazione_provincia
      , '' as sigla_provincia
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
      , ip.totale_casi
      , ip.totale_casi - coalesce(LAG(ip.totale_casi, 1) OVER (PARTITION BY ir.denominazione_regione, ir.codice_regione ORDER BY ir.data ASC),0) as totale_casi_nuovi
      , ir.tamponi
      , tamponi - coalesce(LAG(tamponi, 1) OVER (PARTITION BY ir.denominazione_regione, ir.codice_regione ORDER BY ir.data ASC),0) as tamponi_nuovi
    FROM
      `lookerdata.covid19.italy_regions` ir
      LEFT JOIN ${italy_province.SQL_TABLE_NAME} ip
        ON date(ir.data) = ip.data
        AND ir.denominazione_regione = ip.denominazione_regione
        AND ir.codice_regione = ip.codice_regione
        AND ip.denominazione_provincia = "In fase di definizione/aggiornamento"
    UNION ALL
    SELECT
      data
      , denominazione_regione
      , codice_regione
      , denominazione_provincia
      , sigla_provincia
      , NULL as ricoverati_con_sintomi
      , NULL as ricoverati_con_sintomi_cambio
      , NULL as terapia_intensiva
      , NULL as terapia_intensiva_cambio
      , NULL as totale_ospedalizzati
      , NULL as totale_ospedalizzati_cambio
      , NULL as isolamento_domiciliare
      , NULL as isolamento_domiciliare_cambio
      , NULL as totale_attualmente_positivi
      , NULL as nuovi_attualmente_positivi
      , NULL as dimessi_guariti
      , NULL as dimessi_guariti_nuovi
      , NULL as deceduti
      , NULL as deceduti_nuovi
      , totale_casi
      , totale_casi - coalesce(LAG(totale_casi, 1) OVER (PARTITION BY denominazione_regione, codice_regione ORDER BY data ASC),0) as totale_casi_nuovi
      , NULL as tamponi
      , NULL as tamponi_nuovi
    FROM
      ${italy_province.SQL_TABLE_NAME}
    WHERE
      denominazione_provincia != "In fase di definizione/aggiornamento"
      ;;
    sql_trigger_value: SELECT COUNT(*) FROM `lookerdata.covid19.italy_regions` ;;
  }


######## PRIMARY KEY ########

  dimension: pk {
    primary_key: yes
    sql: concat(${denominazione_regione}, ${codice_regione}, ${denominazione_provincia}) ;;
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
    drill_fields: [denominazione_provincia]
  }

  dimension: denominazione_provincia {
    type: string
    sql: ${TABLE}.denominazione_provincia ;;
    hidden: yes
    label: "Raw Province Name"
    description: "The name of the province in Italy, (IT: Denominazione Provincia)"
  }

  dimension: sigla_provincia {
    type: string
    sql: ${TABLE}.sigla_provincia ;;
    label: "Province Initials"
    description: "The initials of the province in Italy, (IT: Sigla Provincia)"
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

  dimension: totale_casi {
    type: number
    hidden: yes
    label: "Total cases"
  }

  dimension: totale_casi_nuovi {
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

  dimension: nome_pro {
    type: string
    sql:  CASE
            WHEN UPPER(${denominazione_provincia}) = "FORLÌ-CESENA"
            THEN "FORLI'-CESENA"
            WHEN UPPER(${denominazione_provincia}) = "MASSA CARRARA"
            THEN "MASSA-CARRARA"
            WHEN UPPER(${denominazione_provincia}) = "IN FASE DI DEFINIZIONE/AGGIORNAMENTO"
            THEN "Not Specified"
            ELSE UPPER(${denominazione_provincia})
          END
             ;;
    map_layer_name: province_italiane
    html: {{ denominazione_provincia._value }} ;;
    label: "Province Name"
    description: "The name of the province in Italy, (IT: Denominazione Provincia)"
  }

#   dimension: is_max_date {
#     type: yesno
#     hidden: yes
#     sql: ${reporting_date} = ${max_date_italy.max_date_raw} ;;
#   }

  dimension: nome_reg {
    type: string
    sql:
      CASE
        WHEN UPPER(${denominazione_regione}) = "EMILIA ROMAGNA"
        THEN "EMILIA-ROMAGNA"
        WHEN ${denominazione_regione} in ("P.A. Trento", "P.A. Bolzano")
        THEN "TRENTINO-ALTO ADIGE/SUDTIROL"
        ELSE UPPER(${denominazione_regione})
      END ;;
    map_layer_name: regioni_italiani
#     html: {{ denominazione_regione._value }} ;;
    label: "Region Name"
    description: "The name of the region in Italy, (IT: Denominazione Regione)"
    drill_fields: [denominazione_provincia]
  }

######## NEW MEASURES ########

  measure: currently_hospitalized {
#     hidden: yes
    type: number
    sql: ARRAY_AGG(${ricoverati_con_sintomi} IGNORE NULLS ORDER BY ${reporting_date} DESC LIMIT 1)[SAFE_ORDINAL(1)];;
    label: "Non-ICU hospitalizations"
    description: "Current number of patients hospitalized, excluding in ICU (IT: Ricoverati con sintomi)"
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
    description: "Current number of patients in ICU (IT: Terapia intensiva)"
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
    description: "Current number of patients hospitalized, including in ICU (IT: Totale ospedalizzati)"
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
    description: "Positive cases currently at home (IT: Isolamento domiciliare)"
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
    description: "Count of active cases including hospitalized patients + home confinement (IT: Totale attualmente positive)"
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
    description: "Running total of all patients who have recovered (IT: Dimessi guariti)"
    group_label: "Resolved cases by status"
  }

  measure: newly_recovered {
    type: sum
    sql: ${dimessi_guariti_nuovi} ;;
    label: "Newly recovered"
    description: "The count of patients who were reported recovered in that day (IT: Dimessi guariti nuovi)"
    group_label: "Resolved cases by status"
  }

  measure: deceased {
    type: number
    sql: ARRAY_AGG(${deceduti} IGNORE NULLS ORDER BY ${reporting_date} DESC LIMIT 1)[SAFE_ORDINAL(1)];;
    label: "Deceased"
    description: "Running total of deaths (IT: Deceduti)"
    group_label: "Resolved cases by status"
  }

  measure: newly_deceased {
    type: sum
    sql: ${deceduti_nuovi} ;;
    label: "Newly deceased"
    description: "The count of deaths by day (IT: Deceduti nuovi)"
    group_label: "Resolved cases by status"
  }

  measure: total_cases {
    type: sum
    sql: ${totale_casi_nuovi};;
    label: "Total cases"
    description: "Running total of confirmed cases (IT: Totale casi)"
    group_label: "Total cases"
    drill_fields: [denominazione_provincia]
  }

  measure: new_cases {
    type: sum
    sql: ${totale_casi_nuovi} ;;
    label: "New cases"
    description: "Newly confirmed cases by day (IT: Totale casi nuovi)"
    group_label: "Total cases"
  }

  measure: tests_run {
    type: number
    sql: ARRAY_AGG(${tamponi} IGNORE NULLS ORDER BY ${reporting_date} DESC LIMIT 1)[SAFE_ORDINAL(1)];;
    label: "Tests run"
    description: "Running total of tests run (IT: Tamponi)"
    group_label: "Testing"
  }

  measure: new_tests {
    type: sum
    sql: ${tamponi_nuovi} ;;
    label: "New tests run"
    description: "Count of tests run by day (IT: Tamponi nuovi)"
    group_label: "Testing"
  }




#   parameter: new_vs_running_total {
#     type: unquoted
#     default_value: "new_cases"
#     allowed_value: {
#       label: "New Cases"
#       value: "new_cases"
#     }
#     allowed_value: {
#       label: "Running Total"
#       value: "running_total"
#     }
#   }

  measure: max_date {
    sql: MAX(${reporting_date}) ;;
    type: date
    label: "Last Update Date"
  }

  # measure: confirmed_cases {
  #   group_label: "Dynamic"
  #   label: "Confirmed Cases"
  #   type: number
  #   sql:
  #       {% if new_vs_running_total._parameter_value == 'new_cases' %} ${confirmed_new}
  #       {% elsif new_vs_running_total._parameter_value == 'running_total' %} ${confirmed_running_total}
  #       {% endif %} ;;
  # }

#   measure: confirmed_new {
#     label: "Confirmed Cases (New)"
#     type: sum
#     sql: ${new_cases} ;;
#   }
#
#   measure: confirmed_option_1 {
#     hidden: yes
#     type: sum
#     sql: ${total_cases} ;;
#   }
#
#   measure: confirmed_option_2 {
#     hidden: yes
#     type: sum
#     sql: ${total_cases} ;;
#     filters: {
#       field: is_max_date
#       value: "Yes"
#     }
#   }
#
#   measure: confirmed_running_total {
#     label: "Confirmed Cases (Running Total)"
#     type: number
#     sql:
#           {% if italy.reporting_date._in_query %} ${confirmed_option_1}
#           {% else if italy.reporting_week._in_query %}${confirmed_option_1}
#           {% else if italy.reporting_month._in_query %}${confirmed_option_1}
#           {% else %}  ${confirmed_option_2}
#           {% endif %} ;;
#   }

}
