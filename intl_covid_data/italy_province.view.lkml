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
      GROUP BY 1, 2, 3)
    SELECT
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
      not (denominazione_provincia = "In fase di definizione/aggiornamento" AND totale_casi = 0)
    ORDER BY 1, 2
    ;;
    sql_trigger_value: SELECT COUNT(*) FROM `lookerdata.covid19.italy_province` ;;
  }




}
