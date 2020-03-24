# - dashboard: 3__covid_19_us
#   title: 3 - COVID 19 (US)
#   layout: newspaper
#   elements:
#   - title: Total Cases
#     name: Total Cases
#     model: covid
#     explore: tests_by_state
#     type: single_value
#     fields: [tests_by_state.date_date, tests_by_state.positive_test]
#     fill_fields: [tests_by_state.date_date]
#     sorts: [tests_by_state.date_date desc]
#     limit: 500
#     dynamic_fields: [{table_calculation: last_week, label: last week, expression: 'offset(${tests_by_state.positive_test},7)',
#         value_format: !!null '', value_format_name: !!null '', _kind_hint: measure,
#         _type_hint: number}, {table_calculation: vs_last_week, label: vs. Last Week,
#         expression: "${tests_by_state.positive_test} - ${last_week}", value_format: !!null '',
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
#     stacking: ''
#     limit_displayed_rows: false
#     legend_position: center
#     point_style: none
#     show_value_labels: false
#     label_density: 25
#     x_axis_scale: auto
#     y_axis_combined: true
#     show_null_points: true
#     interpolation: linear
#     defaults_version: 1
#     series_types: {}
#     hidden_fields: [last_week]
#     listen:
#       KPI: tests_by_state.new_vs_running_total
#       Region: tests_by_state.region
#       State: tests_by_state.state
#     row: 0
#     col: 0
#     width: 9
#     height: 4
#   - title: Deaths
#     name: Deaths
#     model: covid
#     explore: tests_by_state
#     type: single_value
#     fields: [tests_by_state.date_date, tests_by_state.deaths]
#     fill_fields: [tests_by_state.date_date]
#     sorts: [tests_by_state.date_date desc]
#     limit: 500
#     dynamic_fields: [{table_calculation: last_week, label: last week, expression: 'offset(${tests_by_state.deaths},7)',
#         value_format: !!null '', value_format_name: !!null '', is_disabled: false,
#         _kind_hint: measure, _type_hint: number}, {table_calculation: vs_last_week,
#         label: vs. Last Week, expression: "${tests_by_state.deaths} - ${last_week}",
#         value_format: !!null '', value_format_name: decimal_0, is_disabled: false,
#         _kind_hint: measure, _type_hint: number}]
#     custom_color_enabled: true
#     show_single_value_title: true
#     show_comparison: true
#     comparison_type: change
#     comparison_reverse_colors: true
#     show_comparison_label: true
#     enable_conditional_formatting: false
#     conditional_formatting_include_totals: false
#     conditional_formatting_include_nulls: false
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
#     stacking: ''
#     limit_displayed_rows: false
#     legend_position: center
#     point_style: none
#     show_value_labels: false
#     label_density: 25
#     x_axis_scale: auto
#     y_axis_combined: true
#     show_null_points: true
#     interpolation: linear
#     defaults_version: 1
#     series_types: {}
#     hidden_fields: [last_week]
#     listen:
#       KPI: tests_by_state.new_vs_running_total
#       Region: tests_by_state.region
#       State: tests_by_state.state
#     row: 4
#     col: 3
#     width: 3
#     height: 4
#   - title: Hospitalizations
#     name: Hospitalizations
#     model: covid
#     explore: tests_by_state
#     type: single_value
#     fields: [tests_by_state.date_date, tests_by_state.hospitalizations]
#     fill_fields: [tests_by_state.date_date]
#     sorts: [tests_by_state.date_date desc]
#     limit: 500
#     dynamic_fields: [{table_calculation: last_week, label: last week, expression: 'offset(${tests_by_state.hospitalizations},7)',
#         value_format: !!null '', value_format_name: !!null '', is_disabled: false,
#         _kind_hint: measure, _type_hint: number}, {table_calculation: vs_last_week,
#         label: vs. Last Week, expression: "${tests_by_state.hospitalizations} - coalesce(${last_week},0)",
#         value_format: !!null '', value_format_name: decimal_0, is_disabled: false,
#         _kind_hint: measure, _type_hint: number}]
#     custom_color_enabled: true
#     show_single_value_title: true
#     show_comparison: true
#     comparison_type: change
#     comparison_reverse_colors: true
#     show_comparison_label: true
#     enable_conditional_formatting: false
#     conditional_formatting_include_totals: false
#     conditional_formatting_include_nulls: false
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
#     stacking: ''
#     limit_displayed_rows: false
#     legend_position: center
#     point_style: none
#     show_value_labels: false
#     label_density: 25
#     x_axis_scale: auto
#     y_axis_combined: true
#     show_null_points: true
#     interpolation: linear
#     defaults_version: 1
#     series_types: {}
#     hidden_fields: [last_week]
#     listen:
#       KPI: tests_by_state.new_vs_running_total
#       Region: tests_by_state.region
#       State: tests_by_state.state
#     row: 4
#     col: 0
#     width: 3
#     height: 4
#   - title: Total Tests
#     name: Total Tests
#     model: covid
#     explore: tests_by_state
#     type: single_value
#     fields: [tests_by_state.date_date, tests_by_state.total]
#     fill_fields: [tests_by_state.date_date]
#     sorts: [tests_by_state.date_date desc]
#     limit: 500
#     dynamic_fields: [{table_calculation: last_week, label: last week, expression: 'offset(${tests_by_state.total},7)',
#         value_format: !!null '', value_format_name: !!null '', is_disabled: false,
#         _kind_hint: measure, _type_hint: number}, {table_calculation: vs_last_week,
#         label: vs. Last Week, expression: "${tests_by_state.total} - ${last_week}",
#         value_format: !!null '', value_format_name: decimal_0, is_disabled: false,
#         _kind_hint: measure, _type_hint: number}]
#     custom_color_enabled: true
#     show_single_value_title: true
#     show_comparison: true
#     comparison_type: change
#     comparison_reverse_colors: true
#     show_comparison_label: true
#     enable_conditional_formatting: false
#     conditional_formatting_include_totals: false
#     conditional_formatting_include_nulls: false
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
#     stacking: ''
#     limit_displayed_rows: false
#     legend_position: center
#     point_style: none
#     show_value_labels: false
#     label_density: 25
#     x_axis_scale: auto
#     y_axis_combined: true
#     show_null_points: true
#     interpolation: linear
#     defaults_version: 1
#     series_types: {}
#     hidden_fields: [last_week]
#     listen:
#       KPI: tests_by_state.new_vs_running_total
#       Region: tests_by_state.region
#       State: tests_by_state.state
#     row: 4
#     col: 6
#     width: 3
#     height: 4
#   - title: Map of Cases
#     name: Map of Cases
#     model: covid
#     explore: tests_by_state
#     type: looker_geo_choropleth
#     fields: [tests_by_state.total, tests_by_state.state]
#     sorts: [tests_by_state.total desc]
#     limit: 500
#     dynamic_fields: [{table_calculation: last_week, label: last week, expression: 'offset(${tests_by_state.total},7)',
#         value_format: !!null '', value_format_name: !!null '', _kind_hint: measure,
#         _type_hint: number, is_disabled: true}, {table_calculation: vs_last_week,
#         label: vs. Last Week, expression: "${tests_by_state.total} - ${last_week}",
#         value_format: !!null '', value_format_name: decimal_0, _kind_hint: measure,
#         _type_hint: number, is_disabled: true}]
#     map: usa
#     map_projection: ''
#     show_view_names: false
#     quantize_colors: false
#     colors: [red]
#     custom_color_enabled: true
#     show_single_value_title: true
#     show_comparison: true
#     comparison_type: change
#     comparison_reverse_colors: true
#     show_comparison_label: true
#     enable_conditional_formatting: false
#     conditional_formatting_include_totals: false
#     conditional_formatting_include_nulls: false
#     x_axis_gridlines: false
#     y_axis_gridlines: true
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
#     stacking: ''
#     limit_displayed_rows: false
#     legend_position: center
#     point_style: none
#     show_value_labels: false
#     label_density: 25
#     x_axis_scale: auto
#     y_axis_combined: true
#     show_null_points: true
#     interpolation: linear
#     defaults_version: 1
#     series_types: {}
#     hidden_fields: []
#     map_plot_mode: points
#     heatmap_gridlines: false
#     heatmap_gridlines_empty: false
#     heatmap_opacity: 0.5
#     show_region_field: true
#     draw_map_labels_above_data: true
#     map_tile_provider: light
#     map_position: fit_data
#     map_scale_indicator: 'off'
#     map_pannable: true
#     map_zoomable: true
#     map_marker_type: circle
#     map_marker_icon_name: default
#     map_marker_radius_mode: proportional_value
#     map_marker_units: meters
#     map_marker_proportional_scale_type: linear
#     map_marker_color_mode: fixed
#     show_legend: true
#     quantize_map_value_colors: false
#     reverse_map_value_colors: false
#     listen:
#       KPI: tests_by_state.new_vs_running_total
#       Region: tests_by_state.region
#       State: tests_by_state.state
#     row: 0
#     col: 9
#     width: 9
#     height: 8
#   - title: Test Summary
#     name: Test Summary
#     model: covid
#     explore: tests_by_state
#     type: looker_donut_multiples
#     fields: [tests_by_state.negative_test, tests_by_state.pending_test, tests_by_state.positive_test]
#     limit: 500
#     dynamic_fields: [{table_calculation: last_week, label: last week, expression: 'offset(${tests_by_state.total},7)',
#         value_format: !!null '', value_format_name: !!null '', _kind_hint: measure,
#         _type_hint: number, is_disabled: true}, {table_calculation: vs_last_week,
#         label: vs. Last Week, expression: "${tests_by_state.total} - ${last_week}",
#         value_format: !!null '', value_format_name: decimal_0, _kind_hint: measure,
#         _type_hint: number, is_disabled: true}]
#     show_value_labels: false
#     font_size: 12
#     colors: [red]
#     series_colors:
#       tests_by_state.negative_test: "#72D16D"
#       tests_by_state.pending_test: "#747980"
#       tests_by_state.positive_test: "#B32F37"
#     map: usa
#     map_projection: ''
#     show_view_names: false
#     quantize_colors: false
#     custom_color_enabled: true
#     show_single_value_title: true
#     show_comparison: true
#     comparison_type: change
#     comparison_reverse_colors: true
#     show_comparison_label: true
#     enable_conditional_formatting: false
#     conditional_formatting_include_totals: false
#     conditional_formatting_include_nulls: false
#     x_axis_gridlines: false
#     y_axis_gridlines: true
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
#     stacking: ''
#     limit_displayed_rows: false
#     legend_position: center
#     point_style: none
#     label_density: 25
#     x_axis_scale: auto
#     y_axis_combined: true
#     show_null_points: true
#     interpolation: linear
#     defaults_version: 1
#     series_types: {}
#     hidden_fields: []
#     map_plot_mode: points
#     heatmap_gridlines: false
#     heatmap_gridlines_empty: false
#     heatmap_opacity: 0.5
#     show_region_field: true
#     draw_map_labels_above_data: true
#     map_tile_provider: light
#     map_position: fit_data
#     map_scale_indicator: 'off'
#     map_pannable: true
#     map_zoomable: true
#     map_marker_type: circle
#     map_marker_icon_name: default
#     map_marker_radius_mode: proportional_value
#     map_marker_units: meters
#     map_marker_proportional_scale_type: linear
#     map_marker_color_mode: fixed
#     show_legend: true
#     quantize_map_value_colors: false
#     reverse_map_value_colors: false
#     value_labels: legend
#     label_type: labPer
#     listen:
#       KPI: tests_by_state.new_vs_running_total
#       Region: tests_by_state.region
#       State: tests_by_state.state
#     row: 0
#     col: 18
#     width: 6
#     height: 8
#   - title: Tests over Time
#     name: Tests over Time
#     model: covid
#     explore: tests_by_state
#     type: looker_column
#     fields: [tests_by_state.negative_test, tests_by_state.pending_test, tests_by_state.positive_test,
#       tests_by_state.date_date]
#     fill_fields: [tests_by_state.date_date]
#     limit: 500
#     dynamic_fields: [{table_calculation: last_week, label: last week, expression: 'offset(${tests_by_state.total},7)',
#         value_format: !!null '', value_format_name: !!null '', _kind_hint: measure,
#         _type_hint: number, is_disabled: true}, {table_calculation: vs_last_week,
#         label: vs. Last Week, expression: "${tests_by_state.total} - ${last_week}",
#         value_format: !!null '', value_format_name: decimal_0, _kind_hint: measure,
#         _type_hint: number, is_disabled: true}]
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
#     colors: [red]
#     font_size: '12'
#     series_types: {}
#     series_colors:
#       tests_by_state.negative_test: "#72D16D"
#       tests_by_state.pending_test: "#747980"
#       tests_by_state.positive_test: "#B32F37"
#     map: usa
#     map_projection: ''
#     quantize_colors: false
#     custom_color_enabled: true
#     show_single_value_title: true
#     show_comparison: true
#     comparison_type: change
#     comparison_reverse_colors: true
#     show_comparison_label: true
#     enable_conditional_formatting: false
#     conditional_formatting_include_totals: false
#     conditional_formatting_include_nulls: false
#     show_null_points: true
#     interpolation: linear
#     defaults_version: 1
#     hidden_fields: []
#     map_plot_mode: points
#     heatmap_gridlines: false
#     heatmap_gridlines_empty: false
#     heatmap_opacity: 0.5
#     show_region_field: true
#     draw_map_labels_above_data: true
#     map_tile_provider: light
#     map_position: fit_data
#     map_scale_indicator: 'off'
#     map_pannable: true
#     map_zoomable: true
#     map_marker_type: circle
#     map_marker_icon_name: default
#     map_marker_radius_mode: proportional_value
#     map_marker_units: meters
#     map_marker_proportional_scale_type: linear
#     map_marker_color_mode: fixed
#     show_legend: true
#     quantize_map_value_colors: false
#     reverse_map_value_colors: false
#     value_labels: legend
#     label_type: labPer
#     listen:
#       KPI: tests_by_state.new_vs_running_total
#       Region: tests_by_state.region
#       State: tests_by_state.state
#     row: 8
#     col: 0
#     width: 12
#     height: 8
#   - title: Cases by Geography
#     name: Cases by Geography
#     model: covid
#     explore: tests_by_state
#     type: looker_column
#     fields: [tests_by_state.date_date, tests_by_state.total, tests_by_state.region]
#     pivots: [tests_by_state.region]
#     fill_fields: [tests_by_state.date_date]
#     sorts: [tests_by_state.date_date desc, tests_by_state.region]
#     limit: 500
#     dynamic_fields: [{table_calculation: last_week, label: last week, expression: 'offset(${tests_by_state.total},7)',
#         value_format: !!null '', value_format_name: !!null '', _kind_hint: measure,
#         _type_hint: number, is_disabled: true}, {table_calculation: vs_last_week,
#         label: vs. Last Week, expression: "${tests_by_state.total} - ${last_week}",
#         value_format: !!null '', value_format_name: decimal_0, _kind_hint: measure,
#         _type_hint: number, is_disabled: true}]
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
#     color_application:
#       collection_id: b43731d5-dc87-4a8e-b807-635bef3948e7
#       palette_id: fb7bb53e-b77b-4ab6-8274-9d420d3d73f3
#       options:
#         steps: 5
#     colors: [red]
#     font_size: '12'
#     series_types: {}
#     series_colors: {}
#     show_null_points: true
#     interpolation: linear
#     map: usa
#     map_projection: ''
#     quantize_colors: false
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
#     hidden_fields: []
#     map_plot_mode: points
#     heatmap_gridlines: false
#     heatmap_gridlines_empty: false
#     heatmap_opacity: 0.5
#     show_region_field: true
#     draw_map_labels_above_data: true
#     map_tile_provider: light
#     map_position: fit_data
#     map_scale_indicator: 'off'
#     map_pannable: true
#     map_zoomable: true
#     map_marker_type: circle
#     map_marker_icon_name: default
#     map_marker_radius_mode: proportional_value
#     map_marker_units: meters
#     map_marker_proportional_scale_type: linear
#     map_marker_color_mode: fixed
#     show_legend: true
#     quantize_map_value_colors: false
#     reverse_map_value_colors: false
#     value_labels: legend
#     label_type: labPer
#     listen:
#       KPI: tests_by_state.new_vs_running_total
#       Region: tests_by_state.region
#       State: tests_by_state.state
#     row: 16
#     col: 12
#     width: 12
#     height: 8
#   - title: Deaths & Hospitalizations
#     name: Deaths & Hospitalizations
#     model: covid
#     explore: tests_by_state
#     type: looker_line
#     fields: [tests_by_state.date_date, tests_by_state.case_fatality_rate, tests_by_state.case_hospitalization_rate,
#       tests_by_state.total]
#     fill_fields: [tests_by_state.date_date]
#     sorts: [tests_by_state.date_date]
#     limit: 500
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
#     stacking: ''
#     limit_displayed_rows: false
#     legend_position: center
#     point_style: circle_outline
#     show_value_labels: false
#     label_density: 25
#     x_axis_scale: auto
#     y_axis_combined: true
#     show_null_points: true
#     interpolation: linear
#     color_application:
#       collection_id: b43731d5-dc87-4a8e-b807-635bef3948e7
#       palette_id: fb7bb53e-b77b-4ab6-8274-9d420d3d73f3
#       options:
#         steps: 5
#     y_axes: [{label: '', orientation: left, series: [{axisId: tests_by_state.case_fatality_rate,
#             id: tests_by_state.case_fatality_rate, name: Case Fatality Rate}, {axisId: tests_by_state.case_hospitalization_rate,
#             id: tests_by_state.case_hospitalization_rate, name: Case Hospitalization
#               Rate}], showLabels: true, showValues: true, unpinAxis: false, tickDensity: default,
#         tickDensityCustom: 5, type: linear}, {label: !!null '', orientation: right,
#         series: [{axisId: tests_by_state.total, id: tests_by_state.total, name: Total
#               Cases}], showLabels: true, showValues: true, unpinAxis: false, tickDensity: default,
#         tickDensityCustom: 5, type: linear}]
#     colors: [red]
#     font_size: '12'
#     series_types:
#       tests_by_state.total: column
#     series_colors:
#       tests_by_state.total: "#cacfde"
#     ordering: none
#     show_null_labels: false
#     show_totals_labels: false
#     show_silhouette: false
#     totals_color: "#808080"
#     map: usa
#     map_projection: ''
#     quantize_colors: false
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
#     hidden_fields: []
#     map_plot_mode: points
#     heatmap_gridlines: false
#     heatmap_gridlines_empty: false
#     heatmap_opacity: 0.5
#     show_region_field: true
#     draw_map_labels_above_data: true
#     map_tile_provider: light
#     map_position: fit_data
#     map_scale_indicator: 'off'
#     map_pannable: true
#     map_zoomable: true
#     map_marker_type: circle
#     map_marker_icon_name: default
#     map_marker_radius_mode: proportional_value
#     map_marker_units: meters
#     map_marker_proportional_scale_type: linear
#     map_marker_color_mode: fixed
#     show_legend: true
#     quantize_map_value_colors: false
#     reverse_map_value_colors: false
#     value_labels: legend
#     label_type: labPer
#     listen:
#       KPI: tests_by_state.new_vs_running_total
#       Region: tests_by_state.region
#       State: tests_by_state.state
#     row: 8
#     col: 12
#     width: 12
#     height: 8
#   - title: State Breakdown
#     name: State Breakdown
#     model: covid
#     explore: tests_by_state
#     type: looker_grid
#     fields: [tests_by_state.state, tests_by_state.total, tests_by_state.deaths, tests_by_state.hospitalizations,
#       tests_by_state.total_tests]
#     limit: 500
#     dynamic_fields: [{table_calculation: last_week, label: last week, expression: 'offset(${tests_by_state.total},7)',
#         value_format: !!null '', value_format_name: !!null '', _kind_hint: measure,
#         _type_hint: number, is_disabled: true}, {table_calculation: vs_last_week,
#         label: vs. Last Week, expression: "${tests_by_state.total} - ${last_week}",
#         value_format: !!null '', value_format_name: decimal_0, _kind_hint: measure,
#         _type_hint: number, is_disabled: true}]
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
#     x_axis_gridlines: false
#     y_axis_gridlines: true
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
#     legend_position: center
#     colors: [red]
#     font_size: '12'
#     series_types: {}
#     point_style: none
#     series_colors:
#       tests_by_state.negative_test: "#72D16D"
#       tests_by_state.pending_test: "#747980"
#       tests_by_state.positive_test: "#B32F37"
#     show_value_labels: false
#     label_density: 25
#     x_axis_scale: auto
#     y_axis_combined: true
#     ordering: none
#     show_null_labels: false
#     show_totals_labels: false
#     show_silhouette: false
#     totals_color: "#808080"
#     map: usa
#     map_projection: ''
#     quantize_colors: false
#     custom_color_enabled: true
#     show_single_value_title: true
#     show_comparison: true
#     comparison_type: change
#     comparison_reverse_colors: true
#     show_comparison_label: true
#     show_null_points: true
#     interpolation: linear
#     defaults_version: 1
#     hidden_fields: []
#     map_plot_mode: points
#     heatmap_gridlines: false
#     heatmap_gridlines_empty: false
#     heatmap_opacity: 0.5
#     show_region_field: true
#     draw_map_labels_above_data: true
#     map_tile_provider: light
#     map_position: fit_data
#     map_scale_indicator: 'off'
#     map_pannable: true
#     map_zoomable: true
#     map_marker_type: circle
#     map_marker_icon_name: default
#     map_marker_radius_mode: proportional_value
#     map_marker_units: meters
#     map_marker_proportional_scale_type: linear
#     map_marker_color_mode: fixed
#     show_legend: true
#     quantize_map_value_colors: false
#     reverse_map_value_colors: false
#     value_labels: legend
#     label_type: labPer
#     listen:
#       KPI: tests_by_state.new_vs_running_total
#       Region: tests_by_state.region
#       State: tests_by_state.state
#     row: 16
#     col: 0
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
#     explore: tests_by_state
#     listens_to_filters: []
#     field: tests_by_state.new_vs_running_total
#   - name: Region
#     title: Region
#     type: field_filter
#     default_value: ''
#     allow_multiple_values: true
#     required: false
#     model: covid
#     explore: tests_by_state
#     listens_to_filters: []
#     field: tests_by_state.region
#   - name: State
#     title: State
#     type: field_filter
#     default_value: ''
#     allow_multiple_values: true
#     required: false
#     model: covid
#     explore: tests_by_state
#     listens_to_filters: []
#     field: tests_by_state.state
