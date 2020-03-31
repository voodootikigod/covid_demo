- dashboard: us_cases__spread
  title: US Cases & Spread
  layout: newspaper
  elements:
  - title: Confirmed Cases
    name: Confirmed Cases
    model: covid19_demo
    explore: jhu_sample_county_level_final
    type: single_value
    fields: [jhu_sample_county_level_final.confirmed_running_total, jhu_sample_county_level_final.measurement_date]
    fill_fields: [jhu_sample_county_level_final.measurement_date]
    filters:
      jhu_sample_county_level_final.country_region: US
    sorts: [jhu_sample_county_level_final.measurement_date desc]
    limit: 500
    column_limit: 50
    dynamic_fields: [{table_calculation: yesterday, label: Yesterday, expression: 'offset(${jhu_sample_county_level_final.confirmed_running_total},1)',
        value_format: !!null '', value_format_name: !!null '', _kind_hint: measure,
        _type_hint: number}, {table_calculation: vs_yesterday, label: vs. Yesterday,
        expression: "${jhu_sample_county_level_final.confirmed_running_total}-${yesterday}",
        value_format: !!null '', value_format_name: decimal_0, _kind_hint: measure,
        _type_hint: number}]
    custom_color_enabled: true
    show_single_value_title: true
    show_comparison: true
    comparison_type: change
    comparison_reverse_colors: true
    show_comparison_label: true
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
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
    defaults_version: 1
    hidden_fields: [last_week, yesterday]
    series_types: {}
    listen:
      Region: state_region.region
      State: jhu_sample_county_level_final.province_state
    row: 0
    col: 0
    width: 4
    height: 4
  - title: Deaths
    name: Deaths
    model: covid19_demo
    explore: jhu_sample_county_level_final
    type: single_value
    fields: [jhu_sample_county_level_final.measurement_date, jhu_sample_county_level_final.deaths_running_total]
    fill_fields: [jhu_sample_county_level_final.measurement_date]
    filters:
      jhu_sample_county_level_final.country_region: US
    sorts: [jhu_sample_county_level_final.measurement_date desc]
    limit: 500
    column_limit: 50
    dynamic_fields: [{table_calculation: yesterday, label: Yesterday, expression: 'offset(${jhu_sample_county_level_final.deaths_running_total},1)',
        value_format: !!null '', value_format_name: !!null '', _kind_hint: measure,
        _type_hint: number}, {table_calculation: vs_yesterday, label: vs. Yesterday,
        expression: "${jhu_sample_county_level_final.deaths_running_total}-${yesterday}",
        value_format: !!null '', value_format_name: decimal_0, _kind_hint: measure,
        _type_hint: number}]
    custom_color_enabled: true
    show_single_value_title: true
    show_comparison: true
    comparison_type: change
    comparison_reverse_colors: true
    show_comparison_label: true
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
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
    defaults_version: 1
    hidden_fields: [last_week, yesterday]
    series_types: {}
    listen:
      Region: state_region.region
      State: jhu_sample_county_level_final.province_state
    row: 4
    col: 0
    width: 4
    height: 4
  - title: Daily Growth Rate
    name: Daily Growth Rate
    model: covid19_demo
    explore: jhu_sample_county_level_final
    type: single_value
    fields: [jhu_sample_county_level_final.measurement_date, prior_days_cases_covid.seven_day_average_change_rate_confirmed_cases_running_total]
    fill_fields: [jhu_sample_county_level_final.measurement_date]
    filters:
      jhu_sample_county_level_final.country_region: US
    sorts: [jhu_sample_county_level_final.measurement_date desc]
    limit: 500
    column_limit: 50
    dynamic_fields: [{table_calculation: yesterday, label: Yesterday, expression: 'offset(${prior_days_cases_covid.seven_day_average_change_rate_confirmed_cases_running_total},1)',
        value_format: !!null '', value_format_name: !!null '', _kind_hint: measure,
        _type_hint: number}, {table_calculation: vs_yesterday, label: vs. Yesterday,
        expression: "${prior_days_cases_covid.seven_day_average_change_rate_confirmed_cases_running_total}-${yesterday}",
        value_format: !!null '', value_format_name: percent_1, _kind_hint: measure,
        _type_hint: number}]
    custom_color_enabled: true
    show_single_value_title: true
    show_comparison: true
    comparison_type: change
    comparison_reverse_colors: true
    show_comparison_label: true
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
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
    defaults_version: 1
    hidden_fields: [last_week, yesterday]
    series_types: {}
    listen:
      Region: state_region.region
      State: jhu_sample_county_level_final.province_state
    row: 4
    col: 4
    width: 4
    height: 4
  - title: Confirmed Cases per Million
    name: Confirmed Cases per Million
    model: covid19_demo
    explore: jhu_sample_county_level_final
    type: single_value
    fields: [jhu_sample_county_level_final.measurement_date, jhu_sample_county_level_final.confirmed_running_total_per_million]
    fill_fields: [jhu_sample_county_level_final.measurement_date]
    filters:
      jhu_sample_county_level_final.country_region: US
    sorts: [jhu_sample_county_level_final.measurement_date desc]
    limit: 500
    column_limit: 50
    dynamic_fields: [{table_calculation: yesterday, label: Yesterday, expression: 'offset(${jhu_sample_county_level_final.confirmed_running_total_per_million},1)',
        value_format: !!null '', value_format_name: !!null '', _kind_hint: measure,
        _type_hint: number}, {table_calculation: vs_yesterday, label: vs. Yesterday,
        expression: "${jhu_sample_county_level_final.confirmed_running_total_per_million}-${yesterday}",
        value_format: !!null '', value_format_name: decimal_2, _kind_hint: measure,
        _type_hint: number}]
    custom_color_enabled: true
    show_single_value_title: true
    show_comparison: true
    comparison_type: change
    comparison_reverse_colors: true
    show_comparison_label: true
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
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
    defaults_version: 1
    hidden_fields: [last_week, yesterday]
    series_types: {}
    listen:
      Region: state_region.region
      State: jhu_sample_county_level_final.province_state
    row: 0
    col: 4
    width: 4
    height: 4
  - title: Confirmed Cases
    name: Confirmed Cases (2)
    model: covid19_demo
    explore: jhu_sample_county_level_final
    type: looker_geo_choropleth
    fields: [jhu_sample_county_level_final.province_state, jhu_sample_county_level_final.confirmed_running_total]
    filters:
      jhu_sample_county_level_final.country_region: US
    limit: 500
    column_limit: 50
    dynamic_fields: [{table_calculation: yesterday, label: Yesterday, expression: 'offset(${jhu_sample_county_level_final.confirmed_running_total},1)',
        value_format: !!null '', value_format_name: !!null '', _kind_hint: measure,
        _type_hint: number, is_disabled: true}, {table_calculation: vs_yesterday,
        label: vs. Yesterday, expression: "${jhu_sample_county_level_final.confirmed_running_total}-${yesterday}",
        value_format: !!null '', value_format_name: decimal_0, _kind_hint: measure,
        _type_hint: number, is_disabled: true}]
    map: usa
    map_projection: ''
    show_view_names: false
    quantize_colors: false
    colors: ["#5a30c2"]
    custom_color_enabled: true
    show_single_value_title: true
    show_comparison: true
    comparison_type: change
    comparison_reverse_colors: true
    show_comparison_label: true
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    x_axis_gridlines: false
    y_axis_gridlines: true
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
    defaults_version: 1
    hidden_fields: [last_week]
    series_types: {}
    map_plot_mode: points
    heatmap_gridlines: false
    heatmap_gridlines_empty: false
    heatmap_opacity: 0.5
    show_region_field: true
    draw_map_labels_above_data: true
    map_tile_provider: light
    map_position: fit_data
    map_scale_indicator: 'off'
    map_pannable: true
    map_zoomable: true
    map_marker_type: circle
    map_marker_icon_name: default
    map_marker_radius_mode: proportional_value
    map_marker_units: meters
    map_marker_proportional_scale_type: linear
    map_marker_color_mode: fixed
    show_legend: true
    quantize_map_value_colors: false
    reverse_map_value_colors: false
    listen:
      Region: state_region.region
      State: jhu_sample_county_level_final.province_state
    row: 0
    col: 8
    width: 6
    height: 8
  - title: Daily Growth Rate
    name: Daily Growth Rate (2)
    model: covid19_demo
    explore: jhu_sample_county_level_final
    type: looker_geo_choropleth
    fields: [jhu_sample_county_level_final.province_state, prior_days_cases_covid.seven_day_average_change_rate_confirmed_cases_running_total]
    filters:
      jhu_sample_county_level_final.country_region: US
    limit: 500
    column_limit: 50
    dynamic_fields: [{table_calculation: yesterday, label: Yesterday, expression: 'offset(${jhu_sample_county_level_final.confirmed_running_total},1)',
        value_format: !!null '', value_format_name: !!null '', _kind_hint: measure,
        _type_hint: number, is_disabled: true}, {table_calculation: vs_yesterday,
        label: vs. Yesterday, expression: "${jhu_sample_county_level_final.confirmed_running_total}-${yesterday}",
        value_format: !!null '', value_format_name: decimal_0, _kind_hint: measure,
        _type_hint: number, is_disabled: true}]
    map: usa
    map_projection: ''
    show_view_names: false
    quantize_colors: false
    colors: ["#5a30c2"]
    custom_color_enabled: true
    show_single_value_title: true
    show_comparison: true
    comparison_type: change
    comparison_reverse_colors: true
    show_comparison_label: true
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    x_axis_gridlines: false
    y_axis_gridlines: true
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
    defaults_version: 1
    hidden_fields: [last_week]
    series_types: {}
    map_plot_mode: points
    heatmap_gridlines: false
    heatmap_gridlines_empty: false
    heatmap_opacity: 0.5
    show_region_field: true
    draw_map_labels_above_data: true
    map_tile_provider: light
    map_position: fit_data
    map_scale_indicator: 'off'
    map_pannable: true
    map_zoomable: true
    map_marker_type: circle
    map_marker_icon_name: default
    map_marker_radius_mode: proportional_value
    map_marker_units: meters
    map_marker_proportional_scale_type: linear
    map_marker_color_mode: fixed
    show_legend: true
    quantize_map_value_colors: false
    reverse_map_value_colors: false
    listen:
      Region: state_region.region
      State: jhu_sample_county_level_final.province_state
    row: 0
    col: 14
    width: 5
    height: 8
  - title: State Policy Scoring
    name: State Policy Scoring
    model: covid19_demo
    explore: jhu_sample_county_level_final
    type: looker_geo_choropleth
    fields: [jhu_sample_county_level_final.province_state, policies_by_state.average_policy_score]
    filters:
      jhu_sample_county_level_final.country_region: US
    sorts: [policies_by_state.average_policy_score desc]
    limit: 500
    column_limit: 50
    dynamic_fields: [{table_calculation: yesterday, label: Yesterday, expression: 'offset(${jhu_sample_county_level_final.confirmed_running_total},1)',
        value_format: !!null '', value_format_name: !!null '', _kind_hint: measure,
        _type_hint: number, is_disabled: true}, {table_calculation: vs_yesterday,
        label: vs. Yesterday, expression: "${jhu_sample_county_level_final.confirmed_running_total}-${yesterday}",
        value_format: !!null '', value_format_name: decimal_0, _kind_hint: measure,
        _type_hint: number, is_disabled: true}]
    map: usa
    map_projection: ''
    show_view_names: false
    quantize_colors: false
    colors: []
    custom_color_enabled: true
    show_single_value_title: true
    show_comparison: true
    comparison_type: change
    comparison_reverse_colors: true
    show_comparison_label: true
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    x_axis_gridlines: false
    y_axis_gridlines: true
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
    defaults_version: 1
    hidden_fields: [last_week]
    series_types: {}
    map_plot_mode: points
    heatmap_gridlines: false
    heatmap_gridlines_empty: false
    heatmap_opacity: 0.5
    show_region_field: true
    draw_map_labels_above_data: true
    map_tile_provider: light
    map_position: fit_data
    map_scale_indicator: 'off'
    map_pannable: true
    map_zoomable: true
    map_marker_type: circle
    map_marker_icon_name: default
    map_marker_radius_mode: proportional_value
    map_marker_units: meters
    map_marker_proportional_scale_type: linear
    map_marker_color_mode: fixed
    show_legend: true
    quantize_map_value_colors: false
    reverse_map_value_colors: false
    listen:
      Region: state_region.region
      State: jhu_sample_county_level_final.province_state
    row: 0
    col: 19
    width: 5
    height: 8
  - title: Confirmed Cases (7 Day Forecast)
    name: Confirmed Cases (7 Day Forecast)
    model: covid19_demo
    explore: jhu_sample_county_level_final
    type: looker_column
    fields: [jhu_sample_county_level_final.real_vs_forecasted, jhu_sample_county_level_final.measurement_date,
      jhu_sample_county_level_final.confirmed_running_total]
    pivots: [jhu_sample_county_level_final.real_vs_forecasted]
    fill_fields: [jhu_sample_county_level_final.measurement_date]
    filters:
      jhu_sample_county_level_final.country_region: US
      jhu_sample_county_level_final.allow_forecasted_values: 'yes'
      jhu_sample_county_level_final.days_since_max_date: "[-20, 7]"
    sorts: [jhu_sample_county_level_final.real_vs_forecasted desc 0, jhu_sample_county_level_final.measurement_date]
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
    stacking: normal
    limit_displayed_rows: false
    legend_position: center
    point_style: none
    show_value_labels: false
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    color_application:
      collection_id: covid
      palette_id: covid-categorical-0
      options:
        steps: 5
    y_axes: [{label: '', orientation: left, series: [{axisId: jhu_sample_county_level_final.confirmed_running_total,
            id: Forecasted - jhu_sample_county_level_final.confirmed_running_total,
            name: Forecasted -  COVID19 Confirmed Cases (Running Total)}, {axisId: jhu_sample_county_level_final.confirmed_running_total,
            id: Real Data - jhu_sample_county_level_final.confirmed_running_total,
            name: Real Data -  COVID19 Confirmed Cases (Running Total)}, {axisId: jhu_sample_county_level_final.deaths_running_total,
            id: Forecasted - jhu_sample_county_level_final.deaths_running_total, name: Forecasted
              -  COVID19 Deaths (Running Total)}, {axisId: jhu_sample_county_level_final.deaths_running_total,
            id: Real Data - jhu_sample_county_level_final.deaths_running_total, name: Real
              Data -  COVID19 Deaths (Running Total)}], showLabels: true, showValues: true,
        unpinAxis: false, tickDensity: default, tickDensityCustom: 5, type: linear},
      {label: !!null '', orientation: left, series: [{axisId: jhu_sample_county_level_final.confirmed_cases_per_icu_beds,
            id: Forecasted - jhu_sample_county_level_final.confirmed_cases_per_icu_beds,
            name: Forecasted -  COVID19 Confirmed Cases per ICU Beds}, {axisId: jhu_sample_county_level_final.confirmed_cases_per_icu_beds,
            id: Real Data - jhu_sample_county_level_final.confirmed_cases_per_icu_beds,
            name: Real Data -  COVID19 Confirmed Cases per ICU Beds}], showLabels: true,
        showValues: true, unpinAxis: false, tickDensity: default, tickDensityCustom: 5,
        type: linear}]
    hidden_series: []
    colors: ["#5a30c2"]
    series_types: {}
    series_colors: {}
    show_null_points: true
    interpolation: linear
    map: usa
    map_projection: ''
    quantize_colors: false
    custom_color_enabled: true
    show_single_value_title: true
    show_comparison: true
    comparison_type: change
    comparison_reverse_colors: true
    show_comparison_label: true
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    defaults_version: 1
    hidden_fields: [last_week]
    map_plot_mode: points
    heatmap_gridlines: false
    heatmap_gridlines_empty: false
    heatmap_opacity: 0.5
    show_region_field: true
    draw_map_labels_above_data: true
    map_tile_provider: light
    map_position: fit_data
    map_scale_indicator: 'off'
    map_pannable: true
    map_zoomable: true
    map_marker_type: circle
    map_marker_icon_name: default
    map_marker_radius_mode: proportional_value
    map_marker_units: meters
    map_marker_proportional_scale_type: linear
    map_marker_color_mode: fixed
    show_legend: true
    quantize_map_value_colors: false
    reverse_map_value_colors: false
    listen:
      Region: state_region.region
      State: jhu_sample_county_level_final.province_state
    row: 8
    col: 12
    width: 12
    height: 9
  - title: Confirmed Cases (Last 3 Weeks)
    name: Confirmed Cases (Last 3 Weeks)
    model: covid19_demo
    explore: jhu_sample_county_level_final
    type: looker_column
    fields: [jhu_sample_county_level_final.measurement_date, jhu_sample_county_level_final.confirmed_running_total,
      jhu_sample_county_level_final.state_top_x]
    pivots: [jhu_sample_county_level_final.state_top_x]
    fill_fields: [jhu_sample_county_level_final.measurement_date]
    filters:
      jhu_sample_county_level_final.show_top_x_values: '5'
      jhu_sample_county_level_final.days_since_max_date: "[-20, 0]"
      jhu_sample_county_level_final.country_region: US
    sorts: [jhu_sample_county_level_final.measurement_date desc, jhu_sample_county_level_final.state_top_x]
    limit: 500
    column_limit: 50
    dynamic_fields: [{table_calculation: yesterday, label: Yesterday, expression: 'offset(${jhu_sample_county_level_final.confirmed_new},1)',
        value_format: !!null '', value_format_name: !!null '', _kind_hint: measure,
        _type_hint: number, is_disabled: true}, {table_calculation: vs_yesterday,
        label: vs. Yesterday, expression: "${jhu_sample_county_level_final.confirmed_new}-${yesterday}",
        value_format: !!null '', value_format_name: decimal_0, _kind_hint: measure,
        _type_hint: number, is_disabled: true}]
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
    stacking: normal
    limit_displayed_rows: false
    legend_position: center
    point_style: none
    show_value_labels: false
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    color_application:
      collection_id: covid
      palette_id: covid-categorical-0
      options:
        steps: 5
    colors: ["#5a30c2"]
    series_types: {}
    series_colors: {}
    map: world
    map_projection: ''
    quantize_colors: false
    custom_color_enabled: true
    show_single_value_title: true
    show_comparison: true
    comparison_type: change
    comparison_reverse_colors: true
    show_comparison_label: true
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    show_null_points: true
    interpolation: linear
    defaults_version: 1
    hidden_fields: [last_week]
    map_plot_mode: points
    heatmap_gridlines: false
    heatmap_gridlines_empty: false
    heatmap_opacity: 0.5
    show_region_field: true
    draw_map_labels_above_data: true
    map_tile_provider: light
    map_position: fit_data
    map_scale_indicator: 'off'
    map_pannable: true
    map_zoomable: true
    map_marker_type: circle
    map_marker_icon_name: default
    map_marker_radius_mode: proportional_value
    map_marker_units: meters
    map_marker_proportional_scale_type: linear
    map_marker_color_mode: fixed
    show_legend: true
    quantize_map_value_colors: false
    reverse_map_value_colors: false
    listen:
      Region: state_region.region
      State: jhu_sample_county_level_final.province_state
    row: 8
    col: 0
    width: 12
    height: 9
  - title: State Summary (Today)
    name: State Summary (Today)
    model: covid19_demo
    explore: jhu_sample_county_level_final
    type: looker_grid
    fields: [jhu_sample_county_level_final.province_state, jhu_sample_county_level_final.confirmed_cases_per_icu_beds,
      jhu_sample_county_level_final.confirmed_running_total, jhu_sample_county_level_final.deaths_running_total,
      jhu_sample_county_level_final.confirmed_running_total_per_million, jhu_sample_county_level_final.confirmed_new]
    filters:
      jhu_sample_county_level_final.country_region: US
    sorts: [jhu_sample_county_level_final.confirmed_cases_per_icu_beds desc]
    limit: 500
    column_limit: 50
    show_view_names: false
    show_row_numbers: true
    transpose: false
    truncate_text: true
    hide_totals: false
    hide_row_totals: false
    size_to_fit: true
    table_theme: white
    limit_displayed_rows: false
    enable_conditional_formatting: false
    header_text_alignment: left
    header_font_size: '12'
    rows_font_size: '12'
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    color_application:
      collection_id: covid
      palette_id: covid-categorical-0
      options:
        steps: 5
    show_sql_query_menu_options: false
    show_totals: true
    show_row_totals: true
    series_labels:
      jhu_sample_county_level_final.confirmed_running_total: Confirmed
      jhu_sample_county_level_final.deaths_running_total: Deaths
      prior_days_cases_covid.seven_day_average_change_rate_confirmed_cases_running_total: Confirmed
        Growth
      prior_days_cases_covid.seven_day_average_change_rate_deaths_running_total: Death
        Growth
      jhu_sample_county_level_final.confirmed_running_total_per_million: Cases per
        Million
      jhu_sample_county_level_final.confirmed_new: New Cases
      jhu_sample_county_level_final.confirmed_cases_per_icu_beds: Cases / ICU Bed
    series_cell_visualizations:
      jhu_sample_county_level_final.confirmed_running_total:
        is_active: false
      prior_days_cases_covid.seven_day_average_change_rate_deaths_running_total:
        is_active: false
      jhu_sample_county_level_final.deaths_running_total:
        is_active: false
      jhu_sample_county_level_final.confirmed_cases_per_icu_beds:
        is_active: true
    x_axis_gridlines: false
    y_axis_gridlines: true
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
    stacking: normal
    legend_position: center
    colors: ["#5a30c2"]
    series_types: {}
    point_style: none
    series_colors: {}
    show_value_labels: false
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    map: world
    map_projection: ''
    quantize_colors: false
    custom_color_enabled: true
    show_single_value_title: true
    show_comparison: true
    comparison_type: change
    comparison_reverse_colors: true
    show_comparison_label: true
    show_null_points: true
    interpolation: linear
    defaults_version: 1
    hidden_fields: [last_week]
    map_plot_mode: points
    heatmap_gridlines: false
    heatmap_gridlines_empty: false
    heatmap_opacity: 0.5
    show_region_field: true
    draw_map_labels_above_data: true
    map_tile_provider: light
    map_position: fit_data
    map_scale_indicator: 'off'
    map_pannable: true
    map_zoomable: true
    map_marker_type: circle
    map_marker_icon_name: default
    map_marker_radius_mode: proportional_value
    map_marker_units: meters
    map_marker_proportional_scale_type: linear
    map_marker_color_mode: fixed
    show_legend: true
    quantize_map_value_colors: false
    reverse_map_value_colors: false
    listen:
      Region: state_region.region
      State: jhu_sample_county_level_final.province_state
    row: 17
    col: 0
    width: 12
    height: 9
  - title: State Summary (in 7 Days)
    name: State Summary (in 7 Days)
    model: covid19_demo
    explore: jhu_sample_county_level_final
    type: looker_grid
    fields: [jhu_sample_county_level_final.province_state, jhu_sample_county_level_final.confirmed_cases_per_icu_beds,
      jhu_sample_county_level_final.confirmed_running_total, jhu_sample_county_level_final.deaths_running_total,
      jhu_sample_county_level_final.confirmed_running_total_per_million, jhu_sample_county_level_final.confirmed_new]
    filters:
      jhu_sample_county_level_final.country_region: US
      jhu_sample_county_level_final.days_since_max_date: '7'
      jhu_sample_county_level_final.allow_forecasted_values: 'yes'
    sorts: [jhu_sample_county_level_final.confirmed_cases_per_icu_beds desc]
    limit: 500
    column_limit: 50
    show_view_names: false
    show_row_numbers: true
    transpose: false
    truncate_text: true
    hide_totals: false
    hide_row_totals: false
    size_to_fit: true
    table_theme: white
    limit_displayed_rows: false
    enable_conditional_formatting: false
    header_text_alignment: left
    header_font_size: '12'
    rows_font_size: '12'
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    color_application:
      collection_id: covid
      palette_id: covid-categorical-0
      options:
        steps: 5
    show_sql_query_menu_options: false
    show_totals: true
    show_row_totals: true
    series_labels:
      jhu_sample_county_level_final.confirmed_running_total: Confirmed
      jhu_sample_county_level_final.deaths_running_total: Deaths
      prior_days_cases_covid.seven_day_average_change_rate_confirmed_cases_running_total: Confirmed
        Growth
      prior_days_cases_covid.seven_day_average_change_rate_deaths_running_total: Death
        Growth
      jhu_sample_county_level_final.confirmed_running_total_per_million: Cases per
        Million
      jhu_sample_county_level_final.confirmed_new: New Cases
      jhu_sample_county_level_final.confirmed_cases_per_icu_beds: Cases / ICU Bed
    series_cell_visualizations:
      jhu_sample_county_level_final.confirmed_running_total:
        is_active: false
      prior_days_cases_covid.seven_day_average_change_rate_deaths_running_total:
        is_active: false
      jhu_sample_county_level_final.deaths_running_total:
        is_active: false
      jhu_sample_county_level_final.confirmed_cases_per_icu_beds:
        is_active: true
    x_axis_gridlines: false
    y_axis_gridlines: true
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
    stacking: normal
    legend_position: center
    colors: ["#5a30c2"]
    series_types: {}
    point_style: none
    series_colors: {}
    show_value_labels: false
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    map: world
    map_projection: ''
    quantize_colors: false
    custom_color_enabled: true
    show_single_value_title: true
    show_comparison: true
    comparison_type: change
    comparison_reverse_colors: true
    show_comparison_label: true
    show_null_points: true
    interpolation: linear
    defaults_version: 1
    hidden_fields: [last_week]
    map_plot_mode: points
    heatmap_gridlines: false
    heatmap_gridlines_empty: false
    heatmap_opacity: 0.5
    show_region_field: true
    draw_map_labels_above_data: true
    map_tile_provider: light
    map_position: fit_data
    map_scale_indicator: 'off'
    map_pannable: true
    map_zoomable: true
    map_marker_type: circle
    map_marker_icon_name: default
    map_marker_radius_mode: proportional_value
    map_marker_units: meters
    map_marker_proportional_scale_type: linear
    map_marker_color_mode: fixed
    show_legend: true
    quantize_map_value_colors: false
    reverse_map_value_colors: false
    listen:
      Region: state_region.region
      State: jhu_sample_county_level_final.province_state
    row: 17
    col: 12
    width: 12
    height: 9
  filters:
  - name: Region
    title: Region
    type: field_filter
    default_value: ''
    allow_multiple_values: true
    required: false
    model: covid19_demo
    explore: jhu_sample_county_level_final
    listens_to_filters: []
    field: state_region.region
  - name: State
    title: State
    type: field_filter
    default_value: ''
    allow_multiple_values: true
    required: false
    model: covid19_demo
    explore: jhu_sample_county_level_final
    listens_to_filters: [Region]
    field: jhu_sample_county_level_final.province_state