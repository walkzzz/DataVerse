///|
/// # dataobject/data_catalog 数据目录 / Data Catalog
///
/// 数据目录、数据源、数据汇、数据管道、数据质量、数据契约、数据域、数据产品、数据策略、数据发现、数据血缘、数据访问、数据使用。
/// S11.7 新建。
///
/// # Data catalog

/// 目录条目 / Catalog entry.
pub struct CatalogEntry {
  id : String
  name : String
  description : String
  owner : String
  tags : Array[String]
  metadata : Array[(String, String)]
  created_at : Double
}

/// 数据目录 / Data catalog.
pub struct DataCatalog {
  name : String
  entries : Array[CatalogEntry]
}

/// 构造目录条目 / Create catalog entry.
pub fn make_catalog_entry(
  id : String,
  name : String,
  description : String,
  owner : String,
  tags : Array[String],
  metadata : Array[(String, String)],
  created_at : Double,
) -> CatalogEntry {
  { id: id, name: name, description: description, owner: owner, tags: tags, metadata: metadata, created_at: created_at }
}

/// 构造数据目录 / Create data catalog.
pub fn make_catalog(name : String) -> DataCatalog {
  { name: name, entries: [] }
}

/// 添加条目 / Add entry.
pub fn catalog_add(catalog : DataCatalog, entry : CatalogEntry) -> DataCatalog {
  let new_entries = catalog.entries.copy()
  new_entries.push(entry)
  { ..catalog, entries: new_entries }
}

/// 移除条目 / Remove entry.
pub fn catalog_remove(catalog : DataCatalog, entry_id : String) -> DataCatalog {
  let new_entries : Array[CatalogEntry] = []
  for i in 0..<catalog.entries.length() {
    if catalog.entries[i].id != entry_id {
      new_entries.push(catalog.entries[i])
    }
  }
  { ..catalog, entries: new_entries }
}

/// 搜索条目 / Search entries.
pub fn catalog_search(catalog : DataCatalog, query : String) -> Array[CatalogEntry] {
  let result : Array[CatalogEntry] = []
  for i in 0..<catalog.entries.length() {
    let e = catalog.entries[i]
    if e.name.contains(query) || e.description.contains(query) {
      result.push(e)
    }
  }
  result
}

/// 条目元数据 / Entry metadata.
pub fn entry_metadata(entry : CatalogEntry) -> Array[(String, String)] {
  entry.metadata
}

/// 条目标签 / Entry tags.
pub fn entry_tags(entry : CatalogEntry) -> Array[String] {
  entry.tags
}

/// 条目所有者 / Entry owner.
pub fn entry_owner(entry : CatalogEntry) -> String {
  entry.owner
}

///===
/// 数据源 / Data source

/// 数据源 / Data source.
pub struct DataSource {
  id : String
  source_type : String
  connection : String
  schema : String
  healthy : Bool
}

/// 数据源注册表 / Data source registry.
pub struct DataSourceRegistry {
  sources : Array[DataSource]
}

/// 构造数据源 / Create data source.
pub fn make_data_source(id : String, source_type : String, connection : String, schema : String) -> DataSource {
  { id: id, source_type: source_type, connection: connection, schema: schema, healthy: true }
}

/// 注册数据源 / Register data source.
pub fn source_register(registry : DataSourceRegistry, source : DataSource) -> DataSourceRegistry {
  let new_sources = registry.sources.copy()
  new_sources.push(source)
  { sources: new_sources }
}

/// 验证数据源 / Validate data source.
pub fn source_validate(source : DataSource) -> Bool {
  source.id.length() > 0 && source.source_type.length() > 0 && source.connection.length() > 0
}

/// 数据源健康 / Source health.
pub fn source_health(source : DataSource) -> Bool {
  source.healthy
}

///===
/// 数据汇 / Data sink

/// 数据汇 / Data sink.
pub struct DataSink {
  id : String
  sink_type : String
  connection : String
}

/// 数据汇注册表 / Data sink registry.
pub struct DataSinkRegistry {
  sinks : Array[DataSink]
}

/// 构造数据汇 / Create data sink.
pub fn make_data_sink(id : String, sink_type : String, connection : String) -> DataSink {
  { id: id, sink_type: sink_type, connection: connection }
}

/// 注册数据汇 / Register data sink.
pub fn sink_register(registry : DataSinkRegistry, sink : DataSink) -> DataSinkRegistry {
  let new_sinks = registry.sinks.copy()
  new_sinks.push(sink)
  { sinks: new_sinks }
}

/// 验证数据汇 / Validate data sink.
pub fn sink_validate(sink : DataSink) -> Bool {
  sink.id.length() > 0 && sink.sink_type.length() > 0
}

///===
/// 数据管道 / Data pipeline

/// 数据管道 / Data pipeline.
pub struct DataPipeline {
  id : String
  source_id : String
  sink_id : String
  transformations : Array[String]
}

/// 数据管道注册表 / Data pipeline registry.
pub struct DataPipelineRegistry {
  pipelines : Array[DataPipeline]
}

/// 构造数据管道 / Create data pipeline.
pub fn make_data_pipeline(id : String, source_id : String, sink_id : String, transformations : Array[String]) -> DataPipeline {
  { id: id, source_id: source_id, sink_id: sink_id, transformations: transformations }
}

/// 注册数据管道 / Register data pipeline.
pub fn pipeline_register(registry : DataPipelineRegistry, pipeline : DataPipeline) -> DataPipelineRegistry {
  let new_pipelines = registry.pipelines.copy()
  new_pipelines.push(pipeline)
  { pipelines: new_pipelines }
}

/// 验证数据管道 / Validate data pipeline.
pub fn pipeline_validate(pipeline : DataPipeline) -> Bool {
  pipeline.id.length() > 0 && pipeline.source_id.length() > 0 && pipeline.sink_id.length() > 0
}

///===
/// 数据质量目录 / Data quality catalog

/// 数据质量规则 / Data quality rule.
pub struct QualityRule {
  id : String
  metric : String
  threshold : Double
}

/// 数据质量目录 / Data quality catalog.
pub struct DataQualityCatalog {
  rules : Array[QualityRule]
}

/// 构造数据质量目录 / Create data quality catalog.
pub fn make_data_quality_catalog() -> DataQualityCatalog {
  { rules: [] }
}

/// 注册质量规则 / Register quality rule.
pub fn quality_register(catalog : DataQualityCatalog, rule : QualityRule) -> DataQualityCatalog {
  let new_rules = catalog.rules.copy()
  new_rules.push(rule)
  { ..catalog, rules: new_rules }
}

/// 检查质量 / Check quality.
pub fn quality_check_catalog(catalog : DataQualityCatalog, metric : String, value : Double) -> Bool {
  let mut ok = true
  for i in 0..<catalog.rules.length() {
    if catalog.rules[i].metric == metric {
      if value < catalog.rules[i].threshold {
        ok = false
      }
    }
  }
  ok
}

///===
/// 数据契约 / Data contract

/// 数据契约 / Data contract.
pub struct DataContract {
  id : String
  producer : String
  consumer : String
  schema : String
  sla : Double
}

/// 构造数据契约 / Create data contract.
pub fn make_data_contract(id : String, producer : String, consumer : String, schema : String, sla : Double) -> DataContract {
  { id: id, producer: producer, consumer: consumer, schema: schema, sla: sla }
}

/// 创建契约 / Create contract.
pub fn contract_create(id : String, producer : String, consumer : String, schema : String, sla : Double) -> DataContract {
  make_data_contract(id, producer, consumer, schema, sla)
}

/// 验证契约 / Validate contract.
pub fn contract_validate(contract : DataContract) -> Bool {
  contract.id.length() > 0 && contract.producer.length() > 0 && contract.consumer.length() > 0 && contract.sla >= 0.0
}

/// 强制契约 / Enforce contract.
pub fn contract_enforce(contract : DataContract, actual_sla : Double) -> Bool {
  actual_sla >= contract.sla
}

///===
/// 数据域 / Data domain

/// 数据域 / Data domain.
pub struct DataDomain {
  id : String
  name : String
  description : String
  owners : Array[String]
}

/// 数据域注册表 / Data domain registry.
pub struct DataDomainRegistry {
  domains : Array[DataDomain]
}

/// 构造数据域 / Create data domain.
pub fn make_data_domain(id : String, name : String, description : String, owners : Array[String]) -> DataDomain {
  { id: id, name: name, description: description, owners: owners }
}

/// 注册数据域 / Register data domain.
pub fn domain_register(registry : DataDomainRegistry, domain : DataDomain) -> DataDomainRegistry {
  let new_domains = registry.domains.copy()
  new_domains.push(domain)
  { domains: new_domains }
}

/// 分类数据域 / Classify data domain.
pub fn domain_classify(domain : DataDomain, tags : Array[String]) -> String {
  if tags.length() == 0 {
    domain.name
  } else {
    let mut result = domain.name + ":"
    for i in 0..<tags.length() {
      result = result + tags[i]
      if i < tags.length() - 1 {
        result = result + ","
      }
    }
    result
  }
}

///===
/// 数据产品 / Data product

/// 数据产品 / Data product.
pub struct DataProduct {
  id : String
  name : String
  domain_id : String
  published : Bool
  subscribers : Array[String]
}

/// 构造数据产品 / Create data product.
pub fn make_data_product(id : String, name : String, domain_id : String) -> DataProduct {
  { id: id, name: name, domain_id: domain_id, published: false, subscribers: [] }
}

/// 创建产品 / Create product.
pub fn product_create(id : String, name : String, domain_id : String) -> DataProduct {
  make_data_product(id, name, domain_id)
}

/// 发布产品 / Publish product.
pub fn product_publish(product : DataProduct) -> DataProduct {
  { ..product, published: true }
}

/// 订阅产品 / Subscribe to product.
pub fn product_subscribe(product : DataProduct, subscriber : String) -> DataProduct {
  let new_subscribers = product.subscribers.copy()
  new_subscribers.push(subscriber)
  { ..product, subscribers: new_subscribers }
}

///===
/// 数据策略 / Data policy

/// 数据策略 / Data policy.
pub struct DataPolicy {
  id : String
  rule : String
  action : String
  audit_log : Array[String]
}

/// 构造数据策略 / Create data policy.
pub fn make_data_policy(id : String, rule : String, action : String) -> DataPolicy {
  { id: id, rule: rule, action: action, audit_log: [] }
}

/// 创建策略 / Create policy.
pub fn policy_create(id : String, rule : String, action : String) -> DataPolicy {
  make_data_policy(id, rule, action)
}

/// 强制策略 / Enforce policy.
pub fn policy_enforce(policy : DataPolicy, context : String) -> Bool {
  context.contains(policy.rule)
}

/// 策略审计 / Policy audit.
pub fn policy_audit(policy : DataPolicy, event : String) -> DataPolicy {
  let new_log = policy.audit_log.copy()
  new_log.push(event)
  { ..policy, audit_log: new_log }
}

///===
/// 数据发现 / Data discovery

/// 数据发现 / Data discovery.
pub struct DataDiscovery {
  catalog : DataCatalog
  recommendations : Array[(String, String)]
}

/// 构造数据发现 / Create data discovery.
pub fn make_data_discovery(catalog : DataCatalog) -> DataDiscovery {
  { catalog: catalog, recommendations: [] }
}

/// 发现搜索 / Discovery search.
pub fn discovery_search(discovery : DataDiscovery, query : String) -> Array[CatalogEntry] {
  catalog_search(discovery.catalog, query)
}

/// 发现推荐 / Discovery recommend.
pub fn discovery_recommend(discovery : DataDiscovery, user_id : String) -> Array[String] {
  let result : Array[String] = []
  for i in 0..<discovery.recommendations.length() {
    if discovery.recommendations[i].0 == user_id {
      result.push(discovery.recommendations[i].1)
    }
  }
  result
}

///===
/// 数据血缘目录 / Data lineage catalog

/// 血缘节点 / Lineage node.
pub struct LineageNode {
  id : String
  parents : Array[String]
}

/// 数据血缘目录 / Data lineage catalog.
pub struct DataLineageCatalog {
  nodes : Array[LineageNode]
}

/// 构造数据血缘目录 / Create data lineage catalog.
pub fn make_data_lineage_catalog() -> DataLineageCatalog {
  { nodes: [] }
}

/// 跟踪血缘 / Track lineage.
pub fn lineage_track_catalog(catalog : DataLineageCatalog, node : LineageNode) -> DataLineageCatalog {
  let new_nodes = catalog.nodes.copy()
  new_nodes.push(node)
  { ..catalog, nodes: new_nodes }
}

/// 查询血缘 / Query lineage.
pub fn lineage_query_catalog(catalog : DataLineageCatalog, node_id : String) -> Array[String] {
  let result : Array[String] = []
  for i in 0..<catalog.nodes.length() {
    if catalog.nodes[i].id == node_id {
      for j in 0..<catalog.nodes[i].parents.length() {
        result.push(catalog.nodes[i].parents[j])
      }
    }
  }
  result
}

///===
/// 数据访问 / Data access

/// 数据访问 / Data access.
pub struct DataAccess {
  grants : Array[(String, String, String)]
}

/// 构造数据访问 / Create data access.
pub fn make_data_access() -> DataAccess {
  { grants: [] }
}

/// 授予访问 / Grant access.
pub fn access_grant(access : DataAccess, user : String, resource : String, permission : String) -> DataAccess {
  let new_grants = access.grants.copy()
  new_grants.push((user, resource, permission))
  { ..access, grants: new_grants }
}

/// 撤销访问 / Revoke access.
pub fn access_revoke(access : DataAccess, user : String, resource : String) -> DataAccess {
  let new_grants : Array[(String, String, String)] = []
  for i in 0..<access.grants.length() {
    let g = access.grants[i]
    if !(g.0 == user && g.1 == resource) {
      new_grants.push(g)
    }
  }
  { ..access, grants: new_grants }
}

/// 检查访问 / Check access.
pub fn access_check(access : DataAccess, user : String, resource : String, permission : String) -> Bool {
  let mut ok = false
  for i in 0..<access.grants.length() {
    let g = access.grants[i]
    if g.0 == user && g.1 == resource && g.2 == permission {
      ok = true
    }
  }
  ok
}

///===
/// 数据使用 / Data usage

/// 数据使用 / Data usage.
pub struct DataUsage {
  records : Array[(String, String, Double)]
}

/// 构造数据使用 / Create data usage.
pub fn make_data_usage() -> DataUsage {
  { records: [] }
}

/// 跟踪使用 / Track usage.
pub fn usage_track(usage : DataUsage, user : String, resource : String, amount : Double) -> DataUsage {
  let new_records = usage.records.copy()
  new_records.push((user, resource, amount))
  { ..usage, records: new_records }
}

/// 使用报告 / Usage report.
pub fn usage_report(usage : DataUsage, user : String) -> Double {
  let mut sum = 0.0
  for i in 0..<usage.records.length() {
    if usage.records[i].0 == user {
      sum = sum + usage.records[i].2
    }
  }
  sum
}

/// 使用分析 / Usage analytics.
pub fn usage_analytics(usage : DataUsage) -> Array[(String, Double)] {
  let users : Array[String] = []
  let totals : Array[Double] = []
  for i in 0..<usage.records.length() {
    let u = usage.records[i].0
    let mut found = false
    for j in 0..<users.length() {
      if users[j] == u {
        totals[j] = totals[j] + usage.records[i].2
        found = true
      }
    }
    if !(found) {
      users.push(u)
      totals.push(usage.records[i].2)
    }
  }
  let result : Array[(String, Double)] = []
  for i in 0..<users.length() {
    result.push((users[i], totals[i]))
  }
  result
}

///===
/// ID

pub fn data_catalog_id() -> String {
  "dataobject/data_catalog"
}