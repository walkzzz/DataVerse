///|
/// # DataVerse 数据算子库根包 / Root Package
///
/// 对外统一入口 `@dataverse`，重导出所有一级子包公共 API。
/// S0.1-S0.7: kernel + dataobject + opcore + datatemporal + datair + dosi.
///
/// # Root package of DataVerse
///
/// Unified entry `@dataverse`, re-exports all first-level sub-packages' public API.
/// S0.1 skeleton + S0.2 kernel + S0.3 dataobject + S0.4 opcore + S0.5 datatemporal + S0.6 datair + S0.7 dosi.
/// Phase 3 闭环: io + 并行 + 插件 + 基准+融合 + 文档生成.
pub fn version() -> String {
  "dataverse 0.1.0-dev (S3.5 Phase 3 complete)"
}

pub using @kernel {
  kernel_id, mode_name, mode_consistency, mode_from_tag, all_mode_tags,
}
pub using @dataobject {
  dataobject_id, make_dataobject, empty_dataobject, content_length, has_lineage,
  make_lineage, empty_lineage, make_quality_card, passing_quality_card,
}
pub using @dataobject.schema { schema_id, make as make_schema, empty as empty_schema, size as schema_size }
pub using @dataobject.chunk { chunk_id, make as make_chunk, length as chunk_length }
pub using @dataobject.embedding { embedding_id, make as make_embedding, dim as embedding_dim }
pub using @dataobject.record_dataset { record_dataset_id, make_record, make_dataset, size as dataset_size }
pub using @opcore {
  opcore_id, make_operator, make_result, category_name,
}
pub using @opcore.clean { clean_id, remove_empty, strip_whitespace }
pub using @opcore.dedup { dedup_id, exact_dedup, dedup_count }
pub using @opcore.filter { filter_id, length_filter, non_empty_filter, filter_all }
pub using @opcore.registry { registry_id, empty as empty_registry, register, lookup, size as registry_size, valid_operator }
pub using @opcore.ingest { ingest_id, text_formatter, json_formatter, csv_formatter }
pub using @opcore.normalize { normalize_id, whitespace_normalization, punctuation_normalization }
pub using @opcore.quality { quality_id, length_quality_score, text_quality_score }
pub using @opcore.transform { transform_id, to_lowercase, to_uppercase, truncate }
pub using @opcore.annotate { annotate_id, tag_by_length, tag_modality }
pub using @opcore.select { select_id, topk_by_length, threshold_by_length }
pub using @opcore.mix { mix_id, group_by_modality, interleave }
pub using @opcore.pack { pack_id, text_chunk }
pub using @opcore.eval { eval_id, GlobalStats, global_statistics }
pub using @opcore.lineage_op { lineage_op_id, attach_lineage, make_op_lineage }
pub using @opcore.safety { safety_id, mask_digits, mask_email }
pub using @opcore.image {
  image_id, ImageMeta, make_image_meta, empty_image_meta, image_size, aspect_ratio, aspect_ratio_filter, image_resize, image_crop, image_to_dataobject,
  FlipAxis, RotateAngle, image_flip, image_rotate, flip_axis_name, rotate_angle_name,
}
pub using @opcore.audio {
  audio_id, AudioMeta, make_audio_meta, empty_audio_meta, audio_duration, sample_rate_filter, audio_segment, audio_to_dataobject,
  audio_mix, audio_normalize_duration,
}
pub using @opcore.video {
  video_id, VideoMeta, make_video_meta, empty_video_meta, video_duration, frame_count, video_sample_frames, video_to_dataobject,
  video_extract_frames, video_frame_timestamps, video_trim,
}
pub using @opcore.semantic {
  semantic_id, RewriteMode, SynthesisMode, semantic_quality_score, content_diversity_score, rewrite_text, synthesize_text, rewrite_mode_name, synthesis_mode_name,
  default_stopwords, remove_stopwords, remove_stopwords_custom,
  rewrite_trim, rewrite_lowercase, rewrite_uppercase,
  synthesize_concat, synthesize_template,
  word_frequency, text_similarity,
}
pub using @opcore.plugin {
  plugin_id, PluginStatus, PluginMeta, PluginDependency, PluginEntry, PluginRegistry,
  plugin_status_name, make_plugin_meta, make_plugin_dependency, make_plugin_entry,
  empty_plugin_registry, register_plugin, unregister_plugin, list_plugins,
  get_plugin_status, enable_plugin, disable_plugin, plugin_count, plugins_by_status,
  check_dependency, check_all_dependencies, plugin_registry_uri,
}
pub using @opcore.proximity {
  Point, GeometryKind, BufferResult, ProximityPair, NearResult,
  make_point, make_buffer_result, euclidean_distance, manhattan_distance,
  distances_to_all, point_distance_matrix, buffer_area, buffer_perimeter,
  buffer_point, multi_ring_buffer, nearest_point, near_table,
  all_proximity_pairs, thiessen_polygons, bounding_box, polygon_neighbors,
  points_from_dataobject, buffer_stats,
}
pub using @opcore.overlay {
  Polygon, OverlayKind, OverlayResult,
  make_polygon, empty_polygon, vertex_count, polygon_area, polygon_perimeter,
  polygon_bbox, bbox_overlap, bbox_contains, overlay_intersect, overlay_union,
  overlay_erase, overlay_identity, overlay_sym_diff, overlay_update,
  overlay_spatial_join, batch_intersections, polygon_from_dataobject,
  overlay_result_summary,
}
pub using @opcore.hydrology {
  RasterGrid, FlowDirResult, FlowAccumResult, HydrologyResult,
  make_raster, empty_raster, raster_rows, raster_cols, raster_get,
  hydrology_find_sinks, hydrology_fill, hydrology_flow_direction,
  hydrology_flow_accumulation, hydrology_watershed, hydrology_basin,
  hydrology_stream_cells, hydrology_stream_order, hydrology_flow_length,
  hydrology_stats, hydrology_snap_pour,
}
pub using @opcore.surface {
  AspectDirection, ContourLine, SurfaceResult,
  make_surface_result, slope_result, aspect_result,
  surface_slope, surface_slope_percent, surface_slope_grid,
  surface_aspect, surface_aspect_direction, surface_aspect_grid,
  surface_hillshade, surface_hillshade_grid,
  surface_contour, surface_contour_count,
  surface_curvature, surface_curvature_grid,
  surface_viewshed, surface_viewshed_stats, surface_stats,
}
pub using @opcore.density {
  DensityMethod, DensityResult,
  quadratic_kernel, gaussian_kernel,
  density_kernel_at, density_kernel_grid,
  density_point_count_at, density_point_at, density_point_grid,
  density_line_at, density_line_grid,
  density_stats, make_density_result, density_kernel_results, density_method_name,
}
pub using @learncore {
  learncore_id, ModelSpace, model_space_name, Hyperparams, make_hyperparams,
}
pub using @learncore.regression { regression_id, LinearModel, linear_regression, predict_linear }
pub using @learncore.classify { classify_id, knn_classify }
pub using @learncore.cluster { cluster_id, kmeans }
pub using @learncore.feature { feature_id, standardize, normalize_minmax }
pub using @learncore.metrics { metrics_id, accuracy, mse, mae, confusion_matrix }
pub using @learncore.dl_layers {
  dl_layers_id, Activation, LinearLayer, make_linear_layer, make_linear_layer_with_weights, linear_forward, activate, activation_forward, activation_name,
  Conv2dMeta, make_conv2d, conv2d_output_dim, MaxPoolMeta, make_maxpool, maxpool_output_dim,
  DropoutMode, dropout_forward, dropout_mode_name, BatchNormMeta, make_batchnorm, batchnorm_forward,
}
pub using @learncore.dl_losses {
  dl_losses_id, LossKind, mse_loss, cross_entropy_loss, hinge_loss, loss_value, loss_name,
}
pub using @learncore.dl_optimizers {
  dl_optimizers_id, OptimizerKind, OptimizerState, make_optimizer, sgd_step, adam_step, optimizer_step, update_state, optimizer_name,
}
pub using @learncore.cross_validation {
  cross_validation_id, CVSplit, kfold_splits, CVStats, cv_stats, loo_count,
}
pub using @learncore.hyperparam_search {
  hyperparam_search_id, GridConfig, ParamCombo, GridResult, make_grid_config, grid_combinations, grid_search, empty_grid_result,
}
pub using @datatemporal {
  datatemporal_id, make_fingerprint, empty_fingerprint, matches as fingerprint_matches,
}
pub using @datatemporal.version { version_id as dt_version_id, make_version, root_version, empty_tower, append as tower_append, height as tower_height, latest as tower_latest, get_by_id as tower_get_by_id, ancestors as tower_ancestors }
pub using @datatemporal.lineage { lineage_id as dt_lineage_id, make_bi_lineage, make_field_lineage, reverse as lineage_reverse, compose as lineage_compose, input_count, output_count }
pub using @datatemporal.drift { drift_id, make_drift_report, is_significant, drift_direction, merge_reports }
pub using @datatemporal.replay { replay_id, make_trace, empty_trace, step_count, append_step, replay as replay_trace, trace_summary }
pub using @datatemporal.aging { aging_id, AgingConfig, make_aging_config, aging_weight, aging_score }
pub using @datatemporal.incremental { incremental_id, IncrementalUpdate, make_incremental_update, detect_conflicts, merge_incremental }
pub using @datatemporal.field_lineage { field_lineage_id, FieldDep, FieldLineageGraph, make_field_dep, build_graph, impact_analysis, has_cycle }
pub using @datatemporal { datatemporal_id }
pub using @recipe { recipe_id }
pub using @recipe.cleaning_line { cleaning_line_id, cleaning_line }
pub using @recipe.dedup_line { dedup_line_id, dedup_line }
pub using @recipe.quality_line { quality_line_id, quality_line }
pub using @recipe.balance_line { balance_line_id, balance_line }
pub using @recipe.packing_line { packing_line_id, packing_line }
pub using @recipe.eval_line { eval_line_id, EvalReport, eval_line, empty_eval_report }
pub using @recipe.cross_modal_line { cross_modal_line_id, CrossModalReport, cross_modal_line }
pub using @datair { datair_id, ir_core_id, ir_entity_id, ir_operator_id, ir_kind_count }
pub using @datair.ir_core { IRNodeId, IRMetadata }
pub using @datair.ir_entity { EntityType, EntityIR, entity_type_name }
pub using @datair.ir_operator {
  Determinism, IRModality, CostModel, OperatorIR, determinism_name, modality_name,
}
pub using @datair.ir_pipeline {
  ir_pipeline_id, DAGEdge, PipelineIR,
}
pub using @datair.ir_optimizer {
  ir_optimizer_id, fuse_adjacent_maps, remove_identity, optimize, OptStats, opt_stats,
}
pub using @datair.ir_fusion {
  ir_fusion_id, FusionRule, FusionResult, fusion_rule_name, make_fusion_result,
  apply_fusion, fusion_reduction_ratio, fusion_result_uri, iterative_fusion,
}
pub using @dosi {
  dosi_id, builder_id, router_id,
  SymbolicEntry, SemanticEntry, DOSIEntry, DOSIIndex,
}
pub using @dosi.builder { build_opcore_index, build_from_operator_ir, merge }
pub using @dosi.router {
  lookup_by_path, lookup_by_category, lookup_by_modality, lookup_by_prefix,
}
pub using @dosi.context_budget {
  context_budget_id, ContextBudget, make_budget, allocate, is_over_budget, remaining, usage_ratio, compress, with_used,
}
pub using @dosi.verifier {
  verifier_id, VerifyResult, verify_index, check_dependencies, detect_cycles, valid_result,
}
pub using @dosi.batch {
  batch_id, BatchOp, BatchOperation, batch_add, batch_remove, batch_update, apply_batch, batch_op_name,
}
pub using @dosi.versioned {
  versioned_id, VersionedIndex, make_versioned_index, empty_versioned_index, advance_version, get_version, current as current_version, version_count, rollback,
}
pub using @agent_kit { agent_kit_id }
pub using @agent_kit.dosi_adapter {
  dosi_adapter_id, QueryResult, query_dosi, plan_pipeline, empty_query_result,
}
pub using @agent_kit.planner {
  planner_id, PlanStep, ExecutionPlan, make_plan_step, make_execution_plan, empty_execution_plan, parse_nl_to_plan, plan_step_count,
}
pub using @agent_kit.executor {
  executor_id, ExecStatus, ExecResult, ExecStats, make_exec_result, execute_plan, exec_stats, exec_status_name,
}
pub using @self_evolve { self_evolve_id }
pub using @parallel { parallel_id }
pub using @parallel.cpu_serial {
  cpu_serial_id, ExecutionPlan, ExecutionResult, make_plan, execute, empty_plan, plan_step_count, merge_results,
}
pub using @parallel.cpu_parallel {
  cpu_parallel_id, PartitionStrategy, PartitionConfig, ShuffleType, ShuffleConfig, GatherMode, ParallelExecPlan, ParallelStats,
  make_partition_config, partition_strategy_name, partition_data,
  shuffle_type_name, make_shuffle_config, shuffle_data,
  gather_mode_name, gather_results,
  make_parallel_plan, compute_parallel_stats, parallel_plan_uri,
}
pub using @io { io_id }
pub using @io.source {
  DataSourceType, SourceConfig, SourceMeta, make_source_config, file_source, object_storage_source, in_memory_source,
  source_uri, source_type_name, read_source, make_source_meta, source_meta_uri,
}
pub using @io.sink {
  DataSinkType, SinkConfig, WriteResult, SinkStats, make_sink_config, file_sink, object_storage_sink, in_memory_sink,
  sink_uri, sink_type_name, write_sink, make_write_result, execute_write, make_sink_stats, sink_stats_uri,
}
pub using @governance { governance_id }pub using @governance.benchmark {
  benchmark_id, BenchmarkConfig, BenchmarkResult, BenchmarkSuite, SuiteStats,
  make_benchmark_config, default_benchmark_config, run_benchmark,
  make_benchmark_suite, empty_benchmark_suite, add_result, compute_suite_stats, benchmark_suite_uri,
}pub using @governance.docgen {
  docgen_id, DocEntry, DocIndex, make_doc_entry, empty_doc_index, add_doc_entry,
  generate_dataverse_doc_index, doc_entry_to_markdown, doc_index_to_markdown,
  doc_entry_to_html, doc_index_to_html, doc_index_stats,
}