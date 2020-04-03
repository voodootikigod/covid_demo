- dashboard: longterm_curves
  title: Long-Term Curves
  layout: newspaper
  elements:
  - title: Compare Geographies
    name: Compare Geographies
    model: covid
    explore: kpis_by_entity_by_date
    type: looker_area
    fields: [kpis_by_entity_by_date.days_since_first_outbreaks, kpis_by_entity_by_date.entity,
      kpis_by_entity_by_date.kpi_to_select]
    pivots: [kpis_by_entity_by_date.entity]
    filters: {}
    sorts: [kpis_by_entity_by_date.days_since_first_outbreaks, kpis_by_entity_by_date.entity
        0]
    limit: 500
    column_limit: 50
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    show_x_axis_ticks: true
    y_axis_scale_mode: linear
    x_axis_reversed: false
    y_axis_reversed: false
    plot_size_by_field: false
    trellis: ''
    stacking: ''
    limit_displayed_rows: false
    legend_position: center
    point_style: none
    show_value_labels: false
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    show_null_points: true
    interpolation: linear
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    defaults_version: 1
    series_types: {}
    listen:
      Metric: kpis_by_entity_by_date.metric
      Metric Type: kpis_by_entity_by_date.metric_type
      Metric Value: kpis_by_entity_by_date.metric_value
      'Minimum # of Cases': kpis_by_entity_by_date.minimum_number_cases
      Geography: kpis_by_entity_by_date.entity
    row: 0
    col: 0
    width: 24
    height: 12
  filters:
  - name: Metric
    title: Metric
    type: field_filter
    default_value: confirmed^_cases
    allow_multiple_values: true
    required: false
    model: covid
    explore: kpis_by_entity_by_date
    listens_to_filters: []
    field: kpis_by_entity_by_date.metric
  - name: Metric Type
    title: Metric Type
    type: field_filter
    default_value: new
    allow_multiple_values: true
    required: false
    model: covid
    explore: kpis_by_entity_by_date
    listens_to_filters: []
    field: kpis_by_entity_by_date.metric_type
  - name: Metric Value
    title: Metric Value
    type: field_filter
    default_value: per^_million^_people
    allow_multiple_values: true
    required: false
    model: covid
    explore: kpis_by_entity_by_date
    listens_to_filters: []
    field: kpis_by_entity_by_date.metric_value
  - name: 'Minimum # of Cases'
    title: 'Minimum # of Cases'
    type: field_filter
    default_value: '100'
    allow_multiple_values: true
    required: false
    model: covid
    explore: kpis_by_entity_by_date
    listens_to_filters: []
    field: kpis_by_entity_by_date.minimum_number_cases
  - name: Geography
    title: Geography
    type: field_filter
    default_value: '"Hubei, China",Italy,"New York, US"'
    allow_multiple_values: true
    required: false
    model: covid
    explore: kpis_by_entity_by_date
    listens_to_filters: []
    field: kpis_by_entity_by_date.entity
