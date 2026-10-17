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
/// S1.1 opcore 补齐 14 类算子（ingest/normalize/quality/transform/annotate/select/mix/pack/eval/lineage_op/safety）.
pub fn version() -> String {
  "dataverse 0.1.0-dev (S1.1 opcore 14 ops)"
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
pub using @learncore {
  learncore_id, ModelSpace, model_space_name, Hyperparams, make_hyperparams,
}
pub using @learncore.regression { regression_id, LinearModel, linear_regression, predict_linear }
pub using @learncore.classify { classify_id, knn_classify }
pub using @learncore.cluster { cluster_id, kmeans }
pub using @learncore.feature { feature_id, standardize, normalize_minmax }
pub using @learncore.metrics { metrics_id, accuracy, mse, mae, confusion_matrix }
pub using @datatemporal {
  datatemporal_id, make_fingerprint, empty_fingerprint, matches as fingerprint_matches,
}
pub using @datatemporal.version { version_id as dt_version_id, make_version, root_version, empty_tower, append as tower_append, height as tower_height }
pub using @datatemporal.lineage { lineage_id as dt_lineage_id, make_bi_lineage, make_field_lineage }
pub using @datatemporal.drift { drift_id, make_drift_report, is_significant }
pub using @datatemporal.replay { replay_id, make_trace, empty_trace, step_count }
pub using @datatemporal { datatemporal_id }
pub using @recipe { recipe_id }
pub using @recipe.cleaning_line { cleaning_line_id, cleaning_line }
pub using @recipe.dedup_line { dedup_line_id, dedup_line }
pub using @recipe.quality_line { quality_line_id, quality_line }
pub using @recipe.balance_line { balance_line_id, balance_line }
pub using @datair { datair_id, ir_core_id, ir_entity_id, ir_operator_id, ir_kind_count }
pub using @datair.ir_core { IRNodeId, IRMetadata }
pub using @datair.ir_entity { EntityType, EntityIR, entity_type_name }
pub using @datair.ir_operator {
  Determinism, IRModality, CostModel, OperatorIR, determinism_name, modality_name,
}
pub using @dosi {
  dosi_id, builder_id, router_id,
  SymbolicEntry, SemanticEntry, DOSIEntry, DOSIIndex,
}
pub using @dosi.builder { build_opcore_index, build_from_operator_ir, merge }
pub using @dosi.router {
  lookup_by_path, lookup_by_category, lookup_by_modality, lookup_by_prefix,
}
pub using @agent_kit { agent_kit_id }
pub using @self_evolve { self_evolve_id }
pub using @parallel { parallel_id }
pub using @io { io_id }
pub using @governance { governance_id }