///|
/// # DataVerse 数据算子库根包 / Root Package
///
/// 对外统一入口 `@dataverse`，重导出所有一级子包公共 API。
/// S0.1 骨架 + S0.2 kernel + S0.3 dataobject + S0.4 opcore 框架 + 三类算子。
///
/// # Root package of DataVerse
///
/// Unified entry `@dataverse`, re-exports all first-level sub-packages' public API.
/// S0.1 skeleton + S0.2 kernel + S0.3 dataobject + S0.4 opcore framework + 3 operators.
pub fn version() -> String {
  "dataverse 0.1.0-dev (S0.4 opcore framework + 3 operators)"
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
pub using @datatemporal { datatemporal_id }
pub using @recipe { recipe_id }
pub using @datair { datair_id }
pub using @dosi { dosi_id }
pub using @agent_kit { agent_kit_id }
pub using @self_evolve { self_evolve_id }
pub using @parallel { parallel_id }
pub using @io { io_id }
pub using @governance { governance_id }