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
/// S2.1-S2.8 Phase 2 闭环. S2.9-S2.12 Phase 2 深化闭环.
pub fn version() -> String {
  "dataverse 0.1.0-dev (S2.12 Phase 2 deepening complete)"
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
pub using @io { io_id }
pub using @governance { governance_id }