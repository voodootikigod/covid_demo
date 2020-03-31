- dashboard: world
  title: World
  layout: newspaper
  elements:
  - title: Confirmed Cases
    name: Confirmed Cases
    model: covid19_demo
    explore: jhu_sample_county_level_final
    type: single_value
    fields: [jhu_sample_county_level_final.confirmed_running_total, jhu_sample_county_level_final.measurement_date]
    fill_fields: [jhu_sample_county_level_final.measurement_date]
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
      Region: country_region.region
      Country: jhu_sample_county_level_final.country_region
    row: 2
    col: 0
    width: 6
    height: 5
  - title: Deaths
    name: Deaths
    model: covid19_demo
    explore: jhu_sample_county_level_final
    type: single_value
    fields: [jhu_sample_county_level_final.measurement_date, jhu_sample_county_level_final.deaths_running_total]
    fill_fields: [jhu_sample_county_level_final.measurement_date]
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
      Region: country_region.region
      Country: jhu_sample_county_level_final.country_region
    row: 2
    col: 6
    width: 6
    height: 5
  - title: New Cases
    name: New Cases
    model: covid19_demo
    explore: jhu_sample_county_level_final
    type: single_value
    fields: [jhu_sample_county_level_final.measurement_date, jhu_sample_county_level_final.confirmed_new]
    fill_fields: [jhu_sample_county_level_final.measurement_date]
    sorts: [jhu_sample_county_level_final.measurement_date desc]
    limit: 500
    column_limit: 50
    dynamic_fields: [{table_calculation: yesterday, label: Yesterday, expression: 'offset(${jhu_sample_county_level_final.confirmed_new},1)',
        value_format: !!null '', value_format_name: !!null '', _kind_hint: measure,
        _type_hint: number}, {table_calculation: vs_yesterday, label: vs. Yesterday,
        expression: "${jhu_sample_county_level_final.confirmed_new}-${yesterday}",
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
      Region: country_region.region
      Country: jhu_sample_county_level_final.country_region
    row: 2
    col: 12
    width: 6
    height: 5
  - title: Daily Growth Rate
    name: Daily Growth Rate
    model: covid19_demo
    explore: jhu_sample_county_level_final
    type: single_value
    fields: [jhu_sample_county_level_final.measurement_date, prior_days_cases_covid.seven_day_average_change_rate_confirmed_cases_running_total]
    fill_fields: [jhu_sample_county_level_final.measurement_date]
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
      Region: country_region.region
      Country: jhu_sample_county_level_final.country_region
    row: 2
    col: 18
    width: 6
    height: 5
  - title: Confirmed Cases
    name: Confirmed Cases (2)
    model: covid19_demo
    explore: jhu_sample_county_level_final
    type: looker_geo_choropleth
    fields: [jhu_sample_county_level_final.country_region, jhu_sample_county_level_final.confirmed_running_total]
    sorts: [jhu_sample_county_level_final.confirmed_running_total desc]
    limit: 500
    column_limit: 50
    dynamic_fields: [{table_calculation: yesterday, label: Yesterday, expression: 'offset(${jhu_sample_county_level_final.confirmed_new},1)',
        value_format: !!null '', value_format_name: !!null '', _kind_hint: measure,
        _type_hint: number, is_disabled: true}, {table_calculation: vs_yesterday,
        label: vs. Yesterday, expression: "${jhu_sample_county_level_final.confirmed_new}-${yesterday}",
        value_format: !!null '', value_format_name: decimal_0, _kind_hint: measure,
        _type_hint: number, is_disabled: true}]
    map: world
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
      Region: country_region.region
      Country: jhu_sample_county_level_final.country_region
    row: 7
    col: 0
    width: 8
    height: 6
  - title: New Cases
    name: New Cases (2)
    model: covid19_demo
    explore: jhu_sample_county_level_final
    type: looker_geo_choropleth
    fields: [jhu_sample_county_level_final.country_region, jhu_sample_county_level_final.confirmed_new]
    limit: 500
    column_limit: 50
    dynamic_fields: [{table_calculation: yesterday, label: Yesterday, expression: 'offset(${jhu_sample_county_level_final.confirmed_new},1)',
        value_format: !!null '', value_format_name: !!null '', _kind_hint: measure,
        _type_hint: number, is_disabled: true}, {table_calculation: vs_yesterday,
        label: vs. Yesterday, expression: "${jhu_sample_county_level_final.confirmed_new}-${yesterday}",
        value_format: !!null '', value_format_name: decimal_0, _kind_hint: measure,
        _type_hint: number, is_disabled: true}]
    map: world
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
      Region: country_region.region
      Country: jhu_sample_county_level_final.country_region
    row: 7
    col: 8
    width: 8
    height: 6
  - title: Daily Growth Rate
    name: Daily Growth Rate (2)
    model: covid19_demo
    explore: jhu_sample_county_level_final
    type: looker_geo_choropleth
    fields: [jhu_sample_county_level_final.country_region, prior_days_cases_covid.seven_day_average_change_rate_confirmed_cases_running_total]
    limit: 500
    column_limit: 50
    dynamic_fields: [{table_calculation: yesterday, label: Yesterday, expression: 'offset(${jhu_sample_county_level_final.confirmed_new},1)',
        value_format: !!null '', value_format_name: !!null '', _kind_hint: measure,
        _type_hint: number, is_disabled: true}, {table_calculation: vs_yesterday,
        label: vs. Yesterday, expression: "${jhu_sample_county_level_final.confirmed_new}-${yesterday}",
        value_format: !!null '', value_format_name: decimal_0, _kind_hint: measure,
        _type_hint: number, is_disabled: true}]
    map: world
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
      Region: country_region.region
      Country: jhu_sample_county_level_final.country_region
    row: 7
    col: 16
    width: 8
    height: 6
  - title: Confirmed Cases by Country
    name: Confirmed Cases by Country
    model: covid19_demo
    explore: jhu_sample_county_level_final
    type: looker_column
    fields: [jhu_sample_county_level_final.measurement_date, jhu_sample_county_level_final.confirmed_running_total,
      jhu_sample_county_level_final.country_top_x]
    pivots: [jhu_sample_county_level_final.country_top_x]
    fill_fields: [jhu_sample_county_level_final.measurement_date]
    filters:
      jhu_sample_county_level_final.show_top_x_values: '10'
      jhu_sample_county_level_final.days_since_max_date: "[-20, 0]"
    sorts: [jhu_sample_county_level_final.measurement_date desc, jhu_sample_county_level_final.country_top_x]
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
    series_colors:
      " Other - jhu_sample_county_level_final.confirmed_running_total": "#646464"
      France - jhu_sample_county_level_final.confirmed_running_total: "#1a55e6"
      Germany - jhu_sample_county_level_final.confirmed_running_total: "#DD30A7"
      Iran - jhu_sample_county_level_final.confirmed_running_total: "#6f3ceb"
      Italy - jhu_sample_county_level_final.confirmed_running_total: "#f83f65"
      Spain - jhu_sample_county_level_final.confirmed_running_total: "#0092e6"
      South Korea - jhu_sample_county_level_final.confirmed_running_total: "#F2AA3C"
      Switzerland - jhu_sample_county_level_final.confirmed_running_total: "#e68be5"
      US - jhu_sample_county_level_final.confirmed_running_total: "#5a30c2"
      United Kingdom - jhu_sample_county_level_final.confirmed_running_total: "#9F20A7"
      China - jhu_sample_county_level_final.confirmed_running_total: "#8487e5"
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
      Region: country_region.region
      Country: jhu_sample_county_level_final.country_region
    row: 13
    col: 0
    width: 12
    height: 8
  - title: Share of Cases by Country
    name: Share of Cases by Country
    model: covid19_demo
    explore: jhu_sample_county_level_final
    type: looker_column
    fields: [jhu_sample_county_level_final.measurement_date, jhu_sample_county_level_final.confirmed_running_total,
      jhu_sample_county_level_final.country_top_x]
    pivots: [jhu_sample_county_level_final.country_top_x]
    fill_fields: [jhu_sample_county_level_final.measurement_date]
    filters:
      jhu_sample_county_level_final.show_top_x_values: '10'
      jhu_sample_county_level_final.days_since_max_date: "[-20, 0]"
    sorts: [jhu_sample_county_level_final.measurement_date desc, jhu_sample_county_level_final.country_top_x]
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
    stacking: percent
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
    series_colors:
      US - jhu_sample_county_level_final.confirmed_running_total: "#5a30c2"
      United Kingdom - jhu_sample_county_level_final.confirmed_running_total: "#922ca2"
      China - jhu_sample_county_level_final.confirmed_running_total: "#8487e5"
      " Other - jhu_sample_county_level_final.confirmed_running_total": "#646464"
      Italy - jhu_sample_county_level_final.confirmed_running_total: "#f83f65"
      Germany - jhu_sample_county_level_final.confirmed_running_total: "#cc41a3"
      South Korea - jhu_sample_county_level_final.confirmed_running_total: "#E7AD53"
      Iran - jhu_sample_county_level_final.confirmed_running_total: "#6f3ceb"
      France - jhu_sample_county_level_final.confirmed_running_total: "#1a55e6"
      Spain - jhu_sample_county_level_final.confirmed_running_total: "#0092e6"
      Switzerland - jhu_sample_county_level_final.confirmed_running_total: "#DA8FE0"
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
      Region: country_region.region
      Country: jhu_sample_county_level_final.country_region
    row: 13
    col: 12
    width: 12
    height: 8
  - title: Summary by Country
    name: Summary by Country
    model: covid19_demo
    explore: jhu_sample_county_level_final
    type: looker_grid
    fields: [jhu_sample_county_level_final.country_region, jhu_sample_county_level_final.confirmed_running_total,
      jhu_sample_county_level_final.confirmed_running_total_per_million, jhu_sample_county_level_final.confirmed_new,
      prior_days_cases_covid.seven_day_average_change_rate_confirmed_cases_running_total,
      jhu_sample_county_level_final.deaths_running_total, prior_days_cases_covid.seven_day_average_change_rate_deaths_running_total]
    sorts: [jhu_sample_county_level_final.confirmed_running_total desc]
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
    series_cell_visualizations:
      jhu_sample_county_level_final.confirmed_running_total:
        is_active: true
      prior_days_cases_covid.seven_day_average_change_rate_deaths_running_total:
        is_active: false
      jhu_sample_county_level_final.deaths_running_total:
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
      Region: country_region.region
      Country: jhu_sample_county_level_final.country_region
    row: 21
    col: 0
    width: 24
    height: 8
  - name: ''
    type: text
    title_text: ''
    subtitle_text: <div style="color:black">COVID-19 Information</div>
    body_text: <div style="color:black"><center><small><strong>This information is
      provided for informational purposes only.</strong> We make our best effort to
      keep data accurate and up to date. If you have questions about the data, please
      contact the data source identified in the menu of each tile.</small></center></div>
    row: 0
    col: 0
    width: 24
    height: 2
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
    field: country_region.region
  - name: Country
    title: Country
    type: field_filter
    default_value: ''
    allow_multiple_values: true
    required: false
    model: covid19_demo
    explore: jhu_sample_county_level_final
    listens_to_filters: [Region]
    field: jhu_sample_county_level_final.country_region