view: italy_province {
  derived_table: {
    sql:
    -- First roll the province-level data up to the region level
    WITH region_rollup AS (
      SELECT
        date(data) as data
        , codice_regione
        -- Because of Trento/Bolzano, we need the denominazione as well as the codice
        , denominazione_regione
        , SUM(totale_casi) as provincia_casi
      FROM covid19.italy_province
      GROUP BY 1, 2, 3),
    unioned_provinces as (SELECT
      date(ir.data) as data
      , ir.denominazione_regione
      , ir.codice_regione
      -- Since we're looking for data that isn't specified in the province-level, use this
      , "In fase di definizione/aggiornamento" as denominazione_provincia
      , '' as sigla_provincia
      , ir.totale_casi - rr.provincia_casi as totale_casi
    FROM
      covid19.italy_regions ir
      -- Join the regional data to the province-level rollup on date, region code and region name
      LEFT JOIN region_rollup rr ON
        rr.data = date(ir.data)
        AND rr.codice_regione = ir.codice_regione
        AND ir.denominazione_regione = rr.denominazione_regione
    WHERE
      -- Next find the rows in which the sum of province data doesn't match the regional data
      ir.totale_casi - rr.provincia_casi <> 0
    UNION ALL
    -- Now union the few rows that we had to create with the actual province-level data
    SELECT
      date(data) as data
      , denominazione_regione
      , codice_regione
      , denominazione_provincia
      , sigla_provincia
      , totale_casi
    FROM
      covid19.italy_province
    WHERE
      not (denominazione_provincia = "In fase di definizione/aggiornamento" AND totale_casi = 0))
    SELECT
      data
      , denominazione_regione
      , codice_regione
      , denominazione_provincia
      , sigla_provincia
      , totale_casi
      , totale_casi - coalesce(LAG(totale_casi, 1) OVER (PARTITION BY denominazione_provincia, denominazione_regione ORDER BY data ASC),0) as totale_casi_nuovi
    FROM
      unioned_provinces
    ;;
    sql_trigger_value: SELECT COUNT(*) FROM `lookerdata.covid19.italy_province` ;;
  }

######## PRIMARY KEY ########

  dimension: pk {
    primary_key: yes
    sql: concat(${denominazione_regione}, ${denominazione_provincia}, ${reporting_date}) ;;
    hidden: yes
  }

  dimension: region_fk {
    sql: concat(${nome_reg}, ${codice_regione}, ${reporting_date}) ;;
    hidden: yes
  }

######## RAW DIMENSIONS ########

  dimension_group: reporting {
    type: time
    datatype: date
    timeframes: [
      date,
    ]
    sql: ${TABLE}.data ;;
    hidden: yes
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
    hidden: yes
    label: "Region Code"
    description: "The ISTAT code of the region in Italy, (IT: Codice della Regione)"
    drill_fields: [italy_province.denominazione_provincia]
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


######## NEW DIMENSIONS ########

  dimension: nome_pro {
    type: string
    sql:  CASE
            WHEN UPPER(${denominazione_provincia}) = "IN FASE DI DEFINIZIONE/AGGIORNAMENTO"
            THEN "Not Specified"
            ELSE ${denominazione_provincia}
          END
             ;;
    map_layer_name: province_italiane
    label: "Province Name"
    description: "The name of the province in Italy, (IT: Denominazione Provincia)"
  }

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
    hidden: yes
  }


######## NEW MEASURES ########

  measure: total_cases {
    type: sum
    sql:  {% if italy.reporting_date._is_selected %}
            ${totale_casi}
          {% else %}
            CASE WHEN ${reporting_date} = ${max_italy_date.max_date} THEN ${totale_casi} ELSE NULL END
          {% endif %};;
    label: "Total cases"
    description: "Running total of confirmed cases (IT: Totale casi), avail by region or province"
    group_label: "Total cases"
    drill_fields: [denominazione_provincia]

  }

  measure: new_cases_province {
    type: number
    sql:  ARRAY_AGG(${totale_casi_nuovi} IGNORE NULLS ORDER BY ${reporting_date} DESC LIMIT 1)[SAFE_ORDINAL(1)];;
    hidden: yes
  }






}
