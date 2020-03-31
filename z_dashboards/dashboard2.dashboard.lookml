# - dashboard: 2__covid_19_country
#   title: 2 - COVID 19 (Country)
#   layout: newspaper
#   elements:
#   - title: Total Cases
#     name: Total Cases
#     model: covid
#     explore: covid_data
#     type: single_value
#     fields: [covid_data.confirmed_cases, covid_data.date_date]
#     fill_fields: [covid_data.date_date]
#     limit: 500
#     dynamic_fields: [{table_calculation: last_week, label: last_week, expression: 'offset(${covid_data.confirmed_cases},7)',
#         value_format: !!null '', value_format_name: !!null '', _kind_hint: measure,
#         _type_hint: number}, {table_calculation: vs_last_week, label: vs. last week,
#         expression: "${covid_data.confirmed_cases}-${last_week}", value_format: !!null '',
#         value_format_name: decimal_0, _kind_hint: measure, _type_hint: number}]
#     custom_color_enabled: true
#     show_single_value_title: true
#     show_comparison: true
#     comparison_type: change
#     comparison_reverse_colors: true
#     show_comparison_label: true
#     enable_conditional_formatting: false
#     conditional_formatting_include_totals: false
#     conditional_formatting_include_nulls: false
#     defaults_version: 1
#     hidden_fields: [last_week]
#     listen:
#       Country: covid_data.country
#       State: covid_data.state
#       KPI: covid_data.new_vs_running_total
#     row: 0
#     col: 0
#     width: 12
#     height: 4
#   - title: Closed - Death
#     name: Closed - Death
#     model: covid
#     explore: covid_data
#     type: single_value
#     fields: [covid_data.date_date, covid_data.deaths]
#     fill_fields: [covid_data.date_date]
#     sorts: [covid_data.date_date desc]
#     limit: 500
#     dynamic_fields: [{table_calculation: last_week, label: last_week, expression: 'offset(${covid_data.deaths},7)',
#         value_format: !!null '', value_format_name: !!null '', _kind_hint: measure,
#         _type_hint: number}, {table_calculation: vs_last_week, label: vs. last week,
#         expression: "${covid_data.deaths}-${last_week}", value_format: !!null '',
#         value_format_name: decimal_0, _kind_hint: measure, _type_hint: number}]
#     custom_color_enabled: true
#     show_single_value_title: true
#     show_comparison: true
#     comparison_type: change
#     comparison_reverse_colors: true
#     show_comparison_label: true
#     enable_conditional_formatting: false
#     conditional_formatting_include_totals: false
#     conditional_formatting_include_nulls: false
#     defaults_version: 1
#     hidden_fields: [last_week]
#     listen:
#       Country: covid_data.country
#       State: covid_data.state
#       KPI: covid_data.new_vs_running_total
#     row: 4
#     col: 8
#     width: 4
#     height: 4
#   - title: Active
#     name: Active
#     model: covid
#     explore: covid_data
#     type: single_value
#     fields: [covid_data.date_date, covid_data.active_cases]
#     fill_fields: [covid_data.date_date]
#     sorts: [covid_data.date_date desc]
#     limit: 500
#     dynamic_fields: [{table_calculation: last_week, label: last_week, expression: 'offset(${covid_data.active_cases},7)',
#         value_format: !!null '', value_format_name: !!null '', is_disabled: false,
#         _kind_hint: measure, _type_hint: number}, {table_calculation: vs_last_week,
#         label: vs. last week, expression: "${covid_data.active_cases}-${last_week}",
#         value_format: !!null '', value_format_name: decimal_0, _kind_hint: measure,
#         _type_hint: number}]
#     custom_color_enabled: true
#     show_single_value_title: true
#     show_comparison: true
#     comparison_type: change
#     comparison_reverse_colors: true
#     show_comparison_label: true
#     enable_conditional_formatting: false
#     conditional_formatting_include_totals: false
#     conditional_formatting_include_nulls: false
#     defaults_version: 1
#     hidden_fields: [last_week]
#     listen:
#       Country: covid_data.country
#       State: covid_data.state
#       KPI: covid_data.new_vs_running_total
#     row: 4
#     col: 0
#     width: 4
#     height: 4
#   - title: Closed - Recovery
#     name: Closed - Recovery
#     model: covid
#     explore: covid_data
#     type: single_value
#     fields: [covid_data.date_date, covid_data.recoveries]
#     fill_fields: [covid_data.date_date]
#     sorts: [covid_data.date_date desc]
#     limit: 500
#     dynamic_fields: [{table_calculation: last_week, label: last_week, expression: 'offset(${covid_data.recoveries},7)',
#         value_format: !!null '', value_format_name: !!null '', _kind_hint: measure,
#         _type_hint: number}, {table_calculation: vs_last_week, label: vs. last week,
#         expression: "${covid_data.recoveries}-${last_week}", value_format: !!null '',
#         value_format_name: decimal_0, _kind_hint: measure, _type_hint: number}]
#     custom_color_enabled: true
#     show_single_value_title: true
#     show_comparison: true
#     comparison_type: change
#     comparison_reverse_colors: false
#     show_comparison_label: true
#     enable_conditional_formatting: false
#     conditional_formatting_include_totals: false
#     conditional_formatting_include_nulls: false
#     defaults_version: 1
#     hidden_fields: [last_week]
#     listen:
#       Country: covid_data.country
#       State: covid_data.state
#       KPI: covid_data.new_vs_running_total
#     row: 4
#     col: 4
#     width: 4
#     height: 4
#   - title: State Breakdown
#     name: State Breakdown
#     model: covid
#     explore: covid_data
#     type: looker_grid
#     fields: [covid_data.confirmed_cases, covid_data.active_rate, covid_data.deaths,
#       covid_data.recoveries, covid_data.state]
#     sorts: [covid_data.confirmed_cases desc]
#     limit: 500
#     column_limit: 50
#     show_view_names: false
#     show_row_numbers: true
#     transpose: false
#     truncate_text: true
#     hide_totals: false
#     hide_row_totals: false
#     size_to_fit: true
#     table_theme: white
#     limit_displayed_rows: false
#     enable_conditional_formatting: false
#     header_text_alignment: left
#     header_font_size: 12
#     rows_font_size: 12
#     conditional_formatting_include_totals: false
#     conditional_formatting_include_nulls: false
#     map_plot_mode: points
#     heatmap_gridlines: false
#     heatmap_gridlines_empty: false
#     heatmap_opacity: 0.5
#     show_region_field: true
#     draw_map_labels_above_data: true
#     map_tile_provider: light
#     map_position: custom
#     map_scale_indicator: 'off'
#     map_pannable: true
#     map_zoomable: true
#     map_marker_type: circle
#     map_marker_icon_name: default
#     map_marker_radius_mode: proportional_value
#     map_marker_units: pixels
#     map_marker_proportional_scale_type: linear
#     map_marker_color_mode: value
#     show_legend: true
#     quantize_map_value_colors: false
#     reverse_map_value_colors: false
#     map_latitude: 34.452218472826566
#     map_longitude: -9.667968750000002
#     map_zoom: 2
#     map_marker_radius_min: 1
#     map_marker_radius_max: 50
#     series_types: {}
#     defaults_version: 1
#     listen:
#       Country: covid_data.country
#       State: covid_data.state
#       KPI: covid_data.new_vs_running_total
#     row: 8
#     col: 0
#     width: 12
#     height: 8
#   - title: Confirmed Cases Breakdown
#     name: Confirmed Cases Breakdown
#     model: covid
#     explore: covid_data
#     type: looker_column
#     fields: [covid_data.date_date, covid_data.active_cases, covid_data.deaths, covid_data.recoveries]
#     filters:
#       covid_data.active_cases: ">=0"
#     sorts: [covid_data.date_date desc]
#     limit: 500
#     column_limit: 50
#     x_axis_gridlines: false
#     y_axis_gridlines: true
#     show_view_names: false
#     show_y_axis_labels: true
#     show_y_axis_ticks: true
#     y_axis_tick_density: default
#     y_axis_tick_density_custom: 5
#     show_x_axis_label: true
#     show_x_axis_ticks: true
#     y_axis_scale_mode: linear
#     x_axis_reversed: false
#     y_axis_reversed: false
#     plot_size_by_field: false
#     trellis: ''
#     stacking: normal
#     limit_displayed_rows: false
#     legend_position: center
#     point_style: none
#     show_value_labels: false
#     label_density: 25
#     x_axis_scale: auto
#     y_axis_combined: true
#     ordering: none
#     show_null_labels: false
#     show_totals_labels: false
#     show_silhouette: false
#     totals_color: "#808080"
#     y_axes: [{label: '', orientation: left, series: [{axisId: covid_data.death_rate,
#             id: covid_data.death_rate, name: Death Rate}, {axisId: covid_data.recovery_rate,
#             id: covid_data.recovery_rate, name: Recovery Rate}], showLabels: true,
#         showValues: true, unpinAxis: false, tickDensity: default, tickDensityCustom: 5,
#         type: linear}, {label: '', orientation: right, series: [{axisId: covid_data.closed_running_total,
#             id: covid_data.closed_running_total, name: Closed Cases (Running Total)}],
#         showLabels: false, showValues: true, unpinAxis: false, tickDensity: default,
#         type: linear}]
#     hidden_series: [covid_data.confirmed_running_total]
#     series_types: {}
#     series_colors:
#       covid_data.death_rate: "#B32F37"
#       covid_data.recovery_rate: "#72D16D"
#       covid_data.confirmed_running_total: "#4276BE"
#       covid_data.closed_running_total: "#4276BE"
#       covid_data.deaths: "#B32F37"
#       covid_data.recoveries: "#72D16D"
#       covid_data.active_cases: "#3EB0D5"
#     series_labels:
#       covid_data.recoveries: Closed - Recovery
#       covid_data.deaths: Closed - Death
#       covid_data.active_cases: Active
#     show_null_points: true
#     interpolation: linear
#     map_plot_mode: points
#     heatmap_gridlines: false
#     heatmap_gridlines_empty: false
#     heatmap_opacity: 0.5
#     show_region_field: true
#     draw_map_labels_above_data: true
#     map_tile_provider: light
#     map_position: custom
#     map_scale_indicator: 'off'
#     map_pannable: true
#     map_zoomable: true
#     map_marker_type: circle
#     map_marker_icon_name: default
#     map_marker_radius_mode: proportional_value
#     map_marker_units: pixels
#     map_marker_proportional_scale_type: linear
#     map_marker_color_mode: value
#     show_legend: true
#     quantize_map_value_colors: false
#     reverse_map_value_colors: false
#     map_latitude: 34.452218472826566
#     map_longitude: -9.667968750000002
#     map_zoom: 2
#     map_marker_radius_min: 1
#     map_marker_radius_max: 50
#     defaults_version: 1
#     listen:
#       Country: covid_data.country
#       State: covid_data.state
#       KPI: covid_data.new_vs_running_total
#     row: 0
#     col: 12
#     width: 12
#     height: 8
#   - title: Active Cases by State
#     name: Active Cases by State
#     model: covid
#     explore: covid_data
#     type: looker_column
#     fields: [covid_data.active_cases, covid_data.state, covid_data.date_date]
#     pivots: [covid_data.state]
#     filters: {}
#     sorts: [covid_data.active_cases desc 0, covid_data.state]
#     limit: 500
#     column_limit: 50
#     x_axis_gridlines: false
#     y_axis_gridlines: true
#     show_view_names: false
#     show_y_axis_labels: true
#     show_y_axis_ticks: true
#     y_axis_tick_density: default
#     y_axis_tick_density_custom: 5
#     show_x_axis_label: true
#     show_x_axis_ticks: true
#     y_axis_scale_mode: linear
#     x_axis_reversed: false
#     y_axis_reversed: false
#     plot_size_by_field: false
#     trellis: ''
#     stacking: normal
#     limit_displayed_rows: false
#     legend_position: center
#     point_style: none
#     show_value_labels: false
#     label_density: 25
#     x_axis_scale: auto
#     y_axis_combined: true
#     ordering: none
#     show_null_labels: false
#     show_totals_labels: false
#     show_silhouette: false
#     totals_color: "#808080"
#     y_axes: [{label: '', orientation: left, series: [{axisId: covid_data.death_rate,
#             id: covid_data.death_rate, name: Death Rate}, {axisId: covid_data.recovery_rate,
#             id: covid_data.recovery_rate, name: Recovery Rate}], showLabels: true,
#         showValues: true, unpinAxis: false, tickDensity: default, tickDensityCustom: 5,
#         type: linear}, {label: '', orientation: right, series: [{axisId: covid_data.closed_running_total,
#             id: covid_data.closed_running_total, name: Closed Cases (Running Total)}],
#         showLabels: false, showValues: true, unpinAxis: false, tickDensity: default,
#         type: linear}]
#     hidden_series: [covid_data.confirmed_running_total]
#     series_types: {}
#     series_colors:
#       covid_data.death_rate: "#B32F37"
#       covid_data.recovery_rate: "#72D16D"
#       covid_data.confirmed_running_total: "#4276BE"
#       covid_data.closed_running_total: "#4276BE"
#     show_null_points: true
#     interpolation: linear
#     map_plot_mode: points
#     heatmap_gridlines: false
#     heatmap_gridlines_empty: false
#     heatmap_opacity: 0.5
#     show_region_field: true
#     draw_map_labels_above_data: true
#     map_tile_provider: light
#     map_position: custom
#     map_scale_indicator: 'off'
#     map_pannable: true
#     map_zoomable: true
#     map_marker_type: circle
#     map_marker_icon_name: default
#     map_marker_radius_mode: proportional_value
#     map_marker_units: pixels
#     map_marker_proportional_scale_type: linear
#     map_marker_color_mode: value
#     show_legend: true
#     quantize_map_value_colors: false
#     reverse_map_value_colors: false
#     map_latitude: 34.452218472826566
#     map_longitude: -9.667968750000002
#     map_zoom: 2
#     map_marker_radius_min: 1
#     map_marker_radius_max: 50
#     defaults_version: 1
#     listen:
#       Country: covid_data.country
#       State: covid_data.state
#       KPI: covid_data.new_vs_running_total
#     row: 8
#     col: 12
#     width: 12
#     height: 8
#   filters:
#   - name: KPI
#     title: KPI
#     type: field_filter
#     default_value: running^_total
#     allow_multiple_values: true
#     required: false
#     model: covid
#     explore: covid_data
#     listens_to_filters: []
#     field: covid_data.new_vs_running_total
#   - name: Country
#     title: Country
#     type: field_filter
#     default_value: China
#     allow_multiple_values: true
#     required: false
#     model: covid
#     explore: covid_data
#     listens_to_filters: [Country vs. State, Region]
#     field: covid_data.country
#   - name: State
#     title: State
#     type: field_filter
#     default_value: ''
#     allow_multiple_values: true
#     required: false
#     model: covid
#     explore: covid_data
#     listens_to_filters: [Country, Region]
#     field: covid_data.state
