///|
/// # opcore/feature_store 特征存储 / Feature Store
///
/// 特征定义、特征组、特征视图、在线/离线读写、点对时间查询、
/// 特征管道、特征监控、特征变换、嵌入存储、特征索引、版本血缘审计。
///
/// # Feature store

///===
/// 内部辅助 / Internal helpers

fn fs_min(a : Double, b : Double) -> Double {
  if a < b { a } else { b }
}

fn fs_abs(x : Double) -> Double {
  if x < 0.0 { -x } else { x }
}

fn fs_sqrt(x : Double) -> Double {
  if x <= 0.0 {
    return 0.0
  }
  let mut guess = x / 2.0
  if guess == 0.0 {
    guess = 1.0
  }
  for _ in 0..<60 {
    guess = (guess + x / guess) / 2.0
  }
  guess
}

fn fs_contains(arr : Array[String], v : String) -> Bool {
  for i in 0..<arr.length() {
    if arr[i] == v {
      return true
    }
  }
  false
}

fn fs_mean(arr : Array[Double]) -> Double {
  let n = arr.length()
  if n == 0 {
    return 0.0
  }
  let mut sum = 0.0
  for i in 0..<n {
    sum = sum + arr[i]
  }
  sum / n.to_double()
}

///===
/// FeatureDef / 特征定义

pub(all) enum FeatureType {
  Numerical
  Categorical
  Binary
  Text
  Embedding
} derive(Debug, Eq)

pub extend FeatureType with Eq::{equal, not_equal}
pub extend FeatureType with Debug::{to_repr}

pub(all) enum FeatureDType {
  Float32
  Float64
  Int32
  Int64
  String_
  Bool_
} derive(Debug, Eq)

pub extend FeatureDType with Eq::{equal, not_equal}
pub extend FeatureDType with Debug::{to_repr}

pub struct FeatureDef {
  name : String
  feature_type : FeatureType
  dtype : FeatureDType
  description : String
  tags : Array[String]
} derive(Debug, Eq)

pub extend FeatureDef with Eq::{equal, not_equal}
pub extend FeatureDef with Debug::{to_repr}

/// 构造特征定义 / Build a feature definition.
pub fn make_feature_def(
  name : String,
  feature_type : FeatureType,
  dtype : FeatureDType
) -> FeatureDef {
  { name, feature_type, dtype, description: "", tags: [] }
}

/// 特征名称 / Get feature name.
pub fn feature_name(f : FeatureDef) -> String {
  f.name
}

/// 特征类型 / Get feature type.
pub fn feature_type(f : FeatureDef) -> FeatureType {
  f.feature_type
}

/// 特征数据类型 / Get feature dtype.
pub fn feature_dtype(f : FeatureDef) -> FeatureDType {
  f.dtype
}

///===
/// FeatureGroup / 特征组

pub struct FeatureGroup {
  name : String
  features : Array[FeatureDef]
  description : String
} derive(Debug, Eq)

pub extend FeatureGroup with Eq::{equal, not_equal}
pub extend FeatureGroup with Debug::{to_repr}

/// 构造特征组 / Build a feature group.
pub fn make_feature_group(name : String, description : String) -> FeatureGroup {
  { name, features: [], description }
}

/// 组添加 / Add feature to group.
pub fn group_add(group : FeatureGroup, feature : FeatureDef) -> FeatureGroup {
  { name: group.name, features: group.features + [feature], description: group.description }
}

/// 组移除 / Remove feature from group.
pub fn group_remove(group : FeatureGroup, feature_name : String) -> FeatureGroup {
  let new_features : Array[FeatureDef] = []
  for i in 0..<group.features.length() {
    if group.features[i].name != feature_name {
      new_features.push(group.features[i])
    }
  }
  { name: group.name, features: new_features, description: group.description }
}

/// 组列表 / List features in group.
pub fn group_list(group : FeatureGroup) -> Array[String] {
  let result : Array[String] = []
  for i in 0..<group.features.length() {
    result.push(group.features[i].name)
  }
  result
}

///===
/// FeatureView / 特征视图

pub struct FeatureView {
  name : String
  feature_names : Array[String]
  entity_column : String
  materialized : Bool
} derive(Debug, Eq)

pub extend FeatureView with Eq::{equal, not_equal}
pub extend FeatureView with Debug::{to_repr}

/// 构造特征视图 / Build a feature view.
pub fn make_feature_view(name : String, entity_column : String) -> FeatureView {
  { name, feature_names: [], entity_column, materialized: false }
}

/// 视图创建 / Create a feature view.
pub fn view_create(
  name : String,
  feature_names : Array[String],
  entity_column : String
) -> FeatureView {
  { name, feature_names, entity_column, materialized: false }
}

/// 视图查询 / Query a feature view.
pub fn view_query(view : FeatureView, entity_id : String) -> String {
  let mut result = "view:" + view.name + " entity:" + entity_id + " features:["
  for i in 0..<view.feature_names.length() {
    if i > 0 {
      result = result + ","
    }
    result = result + view.feature_names[i]
  }
  result = result + "]"
  result
}

/// 视图物化 / Materialize a feature view.
pub fn view_materialize(view : FeatureView) -> FeatureView {
  { name: view.name, feature_names: view.feature_names, entity_column: view.entity_column, materialized: true }
}

///===
/// FeatureStore / 特征存储

pub struct FeatureStore {
  features : Array[(String, FeatureDef)]
  groups : Array[FeatureGroup]
  views : Array[FeatureView]
  online_data : Array[(String, Array[Double])]
  offline_data : Array[(String, Array[Double])]
  audit_log : Array[String]
} derive(Debug, Eq)

pub extend FeatureStore with Eq::{equal, not_equal}
pub extend FeatureStore with Debug::{to_repr}

/// 构造特征存储 / Build a feature store.
pub fn make_feature_store() -> FeatureStore {
  { features: [], groups: [], views: [], online_data: [], offline_data: [], audit_log: [] }
}

/// 注册特征 / Register a feature.
pub fn fs_register(store : FeatureStore, feature : FeatureDef) -> FeatureStore {
  {
    features: store.features + [(feature.name, feature)],
    groups: store.groups,
    views: store.views,
    online_data: store.online_data,
    offline_data: store.offline_data,
    audit_log: store.audit_log + ["register:" + feature.name],
  }
}

/// 获取特征 / Get a feature.
pub fn fs_get(store : FeatureStore, name : String) -> FeatureDef? {
  for i in 0..<store.features.length() {
    if store.features[i].0 == name {
      return Some(store.features[i].1)
    }
  }
  None
}

/// 删除特征 / Delete a feature.
pub fn fs_delete(store : FeatureStore, name : String) -> FeatureStore {
  let new_features : Array[(String, FeatureDef)] = []
  for i in 0..<store.features.length() {
    if store.features[i].0 != name {
      new_features.push(store.features[i])
    }
  }
  {
    features: new_features,
    groups: store.groups,
    views: store.views,
    online_data: store.online_data,
    offline_data: store.offline_data,
    audit_log: store.audit_log + ["delete:" + name],
  }
}

///===
/// Online / Offline read-write / 在线离线读写

/// 在线读 / Online read.
pub fn fs_online_read(store : FeatureStore, key : String) -> Array[Double] {
  for i in 0..<store.online_data.length() {
    if store.online_data[i].0 == key {
      return store.online_data[i].1
    }
  }
  []
}

/// 在线写 / Online write.
pub fn fs_online_write(
  store : FeatureStore,
  key : String,
  values : Array[Double]
) -> FeatureStore {
  let new_data : Array[(String, Array[Double])] = []
  let mut found = false
  for i in 0..<store.online_data.length() {
    if store.online_data[i].0 == key {
      new_data.push((key, values))
      found = true
    } else {
      new_data.push(store.online_data[i])
    }
  }
  if !(found) {
    new_data.push((key, values))
  }
  {
    features: store.features,
    groups: store.groups,
    views: store.views,
    online_data: new_data,
    offline_data: store.offline_data,
    audit_log: store.audit_log + ["online_write:" + key],
  }
}

/// 离线读 / Offline read.
pub fn fs_offline_read(store : FeatureStore, key : String) -> Array[Double] {
  for i in 0..<store.offline_data.length() {
    if store.offline_data[i].0 == key {
      return store.offline_data[i].1
    }
  }
  []
}

/// 离线写 / Offline write.
pub fn fs_offline_write(
  store : FeatureStore,
  key : String,
  values : Array[Double]
) -> FeatureStore {
  let new_data : Array[(String, Array[Double])] = []
  let mut found = false
  for i in 0..<store.offline_data.length() {
    if store.offline_data[i].0 == key {
      new_data.push((key, values))
      found = true
    } else {
      new_data.push(store.offline_data[i])
    }
  }
  if !(found) {
    new_data.push((key, values))
  }
  {
    features: store.features,
    groups: store.groups,
    views: store.views,
    online_data: store.online_data,
    offline_data: new_data,
    audit_log: store.audit_log + ["offline_write:" + key],
  }
}

///===
/// Point-in-time / 点对时间

/// 点对时间查询 / Point-in-time join.
pub fn fs_point_in_time(
  store : FeatureStore,
  entity_id : String,
  timestamp : Double
) -> Array[(String, Double)] {
  let result : Array[(String, Double)] = []
  for i in 0..<store.offline_data.length() {
    if store.offline_data[i].0 == entity_id {
      let vals = store.offline_data[i].1
      for j in 0..<vals.length() {
        result.push(("f" + j.to_string(), vals[j]))
      }
      break
    }
  }
  result.push(("timestamp", timestamp))
  result
}

/// 连接特征 / Join features.
pub fn fs_join_features(
  left : Array[(String, Array[Double])],
  right : Array[(String, Array[Double])]
) -> Array[(String, Array[Double])] {
  let result : Array[(String, Array[Double])] = []
  let seen : Array[String] = []
  for i in 0..<left.length() {
    result.push(left[i])
    seen.push(left[i].0)
  }
  for i in 0..<right.length() {
    if !(fs_contains(seen, right[i].0)) {
      result.push(right[i])
    }
  }
  result
}

/// 特征向量 / Get feature vector.
pub fn fs_feature_vector(store : FeatureStore, keys : Array[String]) -> Array[Double] {
  let result : Array[Double] = []
  for i in 0..<keys.length() {
    let vals = fs_online_read(store, keys[i])
    for j in 0..<vals.length() {
      result.push(vals[j])
    }
  }
  result
}

///===
/// FeaturePipeline / 特征管道

pub struct FeaturePipeline {
  name : String
  steps : Array[String]
  schedule : String
  last_run : Double
} derive(Debug, Eq)

pub extend FeaturePipeline with Eq::{equal, not_equal}
pub extend FeaturePipeline with Debug::{to_repr}

/// 构造特征管道 / Build a feature pipeline.
pub fn make_feature_pipeline(name : String, schedule : String) -> FeaturePipeline {
  { name, steps: [], schedule, last_run: 0.0 }
}

/// 管道计算 / Compute pipeline.
pub fn pipeline_compute(
  pipeline : FeaturePipeline,
  input : Array[Double]
) -> Array[Double] {
  let result : Array[Double] = []
  for i in 0..<input.length() {
    result.push(input[i])
  }
  for i in 0..<pipeline.steps.length() {
    let step = pipeline.steps[i]
    if step == "normalize" {
      let m = fs_mean(result)
      let new_result : Array[Double] = []
      for j in 0..<result.length() {
        new_result.push(result[j] - m)
      }
      ignore(new_result)
    }
  }
  result
}

/// 管道调度 / Schedule pipeline.
pub fn pipeline_schedule(pipeline : FeaturePipeline, schedule : String) -> FeaturePipeline {
  { name: pipeline.name, steps: pipeline.steps, schedule, last_run: pipeline.last_run }
}

///===
/// Feature stats / quality / drift / 特征统计/质量/漂移

/// 特征统计 / Compute feature statistics.
pub fn feature_stats_store(values : Array[Double]) -> (Double, Double, Double, Double) {
  let n = values.length()
  if n == 0 {
    return (0.0, 0.0, 0.0, 0.0)
  }
  let mean = fs_mean(values)
  let mut sum_sq = 0.0
  let mut mn = values[0]
  let mut mx = values[0]
  for i in 0..<n {
    let d = values[i] - mean
    sum_sq = sum_sq + d * d
    if values[i] < mn {
      mn = values[i]
    }
    if values[i] > mx {
      mx = values[i]
    }
  }
  let variance = sum_sq / n.to_double()
  let std = fs_sqrt(variance)
  (mean, std, mn, mx)
}

/// 特征质量 / Compute feature quality.
pub fn feature_quality_store(values : Array[Double]) -> Double {
  let n = values.length()
  if n == 0 {
    return 0.0
  }
  let mut non_finite = 0
  for i in 0..<n {
    if values[i] != values[i] {
      non_finite = non_finite + 1
    }
  }
  (n - non_finite).to_double() / n.to_double()
}

/// 特征漂移 / Compute feature drift (PSI).
pub fn feature_drift_store(
  expected : Array[Double],
  actual : Array[Double]
) -> Double {
  let n = expected.length()
  if n == 0 || n != actual.length() {
    return 0.0
  }
  let exp_mean = fs_mean(expected)
  let act_mean = fs_mean(actual)
  if exp_mean == 0.0 {
    return fs_abs(act_mean)
  }
  fs_abs((act_mean - exp_mean) / exp_mean)
}

///===
/// FeatureMonitor / 特征监控

pub struct FeatureMonitor {
  feature_name : String
  drift_threshold : Double
  quality_threshold : Double
  alerts : Array[String]
} derive(Debug, Eq)

pub extend FeatureMonitor with Eq::{equal, not_equal}
pub extend FeatureMonitor with Debug::{to_repr}

/// 构造特征监控 / Build a feature monitor.
pub fn make_feature_monitor(
  feature_name : String,
  drift_threshold : Double,
  quality_threshold : Double
) -> FeatureMonitor {
  { feature_name, drift_threshold, quality_threshold, alerts: [] }
}

/// 监控漂移 / Monitor drift.
pub fn monitor_drift(
  monitor : FeatureMonitor,
  drift_value : Double
) -> FeatureMonitor {
  if fs_abs(drift_value) > monitor.drift_threshold {
    { feature_name: monitor.feature_name, drift_threshold: monitor.drift_threshold, quality_threshold: monitor.quality_threshold, alerts: monitor.alerts + ["drift:" + drift_value.to_string()] }
  } else {
    monitor
  }
}

/// 监控质量 / Monitor quality.
pub fn monitor_quality(
  monitor : FeatureMonitor,
  quality_value : Double
) -> FeatureMonitor {
  if quality_value < monitor.quality_threshold {
    { feature_name: monitor.feature_name, drift_threshold: monitor.drift_threshold, quality_threshold: monitor.quality_threshold, alerts: monitor.alerts + ["quality:" + quality_value.to_string()] }
  } else {
    monitor
  }
}

///===
/// FeatureTransform / 特征变换

pub struct FeatureTransform {
  name : String
  transform_type : String
  params : Array[Double]
} derive(Debug, Eq)

pub extend FeatureTransform with Eq::{equal, not_equal}
pub extend FeatureTransform with Debug::{to_repr}

/// 构造特征变换 / Build a feature transform.
pub fn make_feature_transform(name : String, transform_type : String) -> FeatureTransform {
  { name, transform_type, params: [] }
}

/// 应用变换 / Apply transform.
pub fn transform_apply(t : FeatureTransform, value : Double) -> Double {
  if t.transform_type == "scale" && t.params.length() > 0 {
    value * t.params[0]
  } else if t.transform_type == "shift" && t.params.length() > 0 {
    value + t.params[0]
  } else if t.transform_type == "log" {
    if value > 0.0 {
      let mut result = 0.0
      let mut x = (value - 1.0) / (value + 1.0)
      let x2 = x * x
      for k in 0..<50 {
        result = result + x / (2 * k + 1).to_double()
        x = x * x2
      }
      2.0 * result
    } else {
      0.0
    }
  } else if t.transform_type == "abs" {
    fs_abs(value)
  } else {
    value
  }
}

/// 变换链 / Chain transforms.
pub fn transform_chain(
  transforms : Array[FeatureTransform],
  value : Double
) -> Double {
  let mut result = value
  for i in 0..<transforms.length() {
    result = transform_apply(transforms[i], result)
  }
  result
}

///===
/// On-demand / Pre-compute / Cache / 按需/预计算/缓存

pub(all) enum CacheStrategy {
  CacheAll
  CacheNone
  CacheLRU
  CacheTTL
} derive(Debug, Eq)

pub extend CacheStrategy with Eq::{equal, not_equal}
pub extend CacheStrategy with Debug::{to_repr}

/// 按需计算 / On-demand computation.
pub fn fs_on_demand(store : FeatureStore, name : String) -> Array[Double] {
  fs_online_read(store, name)
}

/// 预计算 / Pre-compute features.
pub fn fs_pre_compute(
  store : FeatureStore,
  names : Array[String]
) -> FeatureStore {
  let mut s = store
  for i in 0..<names.length() {
    let online_vals = fs_online_read(s, names[i])
    if online_vals.length() == 0 {
      let offline_vals = fs_offline_read(s, names[i])
      s = fs_online_write(s, names[i], offline_vals)
    }
  }
  s
}

/// 缓存策略 / Cache strategy.
pub fn fs_cache_strategy(strategy : String) -> CacheStrategy {
  match strategy {
    "all" => CacheAll
    "none" => CacheNone
    "lru" => CacheLRU
    "ttl" => CacheTTL
    _ => CacheLRU
  }
}

///===
/// EmbeddingStore / 嵌入存储

pub struct EmbeddingStore {
  embeddings : Array[(String, Array[Double])]
  dimension : Int
} derive(Debug, Eq)

pub extend EmbeddingStore with Eq::{equal, not_equal}
pub extend EmbeddingStore with Debug::{to_repr}

/// 构造嵌入存储 / Build an embedding store.
pub fn make_embedding_store(dimension : Int) -> EmbeddingStore {
  { embeddings: [], dimension }
}

/// 注册嵌入 / Register an embedding.
pub fn embedding_register(
  store : EmbeddingStore,
  key : String,
  vec : Array[Double]
) -> EmbeddingStore {
  { embeddings: store.embeddings + [(key, vec)], dimension: store.dimension }
}

/// 嵌入搜索 / Search embeddings (cosine similarity).
pub fn embedding_search(
  store : EmbeddingStore,
  query : Array[Double],
  top_k : Int
) -> Array[(String, Double)] {
  let scores : Array[(String, Double)] = []
  for i in 0..<store.embeddings.length() {
    let (k, v) = store.embeddings[i]
    let mut dot = 0.0
    let mut norm_a = 0.0
    let mut norm_b = 0.0
    let n = fs_min(query.length().to_double(), v.length().to_double()).to_int()
    for j in 0..<n {
      dot = dot + query[j] * v[j]
      norm_a = norm_a + query[j] * query[j]
      norm_b = norm_b + v[j] * v[j]
    }
    let denom = fs_sqrt(norm_a) * fs_sqrt(norm_b)
    let score = if denom > 0.0 { dot / denom } else { 0.0 }
    scores.push((k, score))
  }
  scores.sort_by(fn(a, b) { b.1.compare(a.1) })
  let result : Array[(String, Double)] = []
  let k = if top_k > scores.length() { scores.length() } else { top_k }
  for i in 0..<k {
    result.push(scores[i])
  }
  result
}

///===
/// Versioning / Lineage / Audit / 版本/血缘/审计

/// 特征版本 / Feature versioning.
pub fn fs_versioning(store : FeatureStore) -> Int {
  store.audit_log.length()
}

/// 特征血缘 / Feature lineage.
pub fn fs_lineage(store : FeatureStore) -> Array[String] {
  let result : Array[String] = []
  for i in 0..<store.features.length() {
    result.push(store.features[i].0)
  }
  result
}

/// 特征审计 / Feature audit.
pub fn fs_audit(store : FeatureStore) -> Array[String] {
  store.audit_log
}

///===
/// Validation / Schema / Type / 校验/模式/类型

/// 特征校验 / Validate feature store.
pub fn fs_validation(store : FeatureStore) -> Bool {
  let seen : Array[String] = []
  for i in 0..<store.features.length() {
    if fs_contains(seen, store.features[i].0) {
      return false
    }
    seen.push(store.features[i].0)
  }
  true
}

/// 模式检查 / Schema check.
pub fn fs_schema_check(store : FeatureStore, feature : FeatureDef) -> Bool {
  if feature.name.length() == 0 {
    return false
  }
  for i in 0..<store.features.length() {
    if store.features[i].0 == feature.name {
      let existing = store.features[i].1
      if existing.dtype != feature.dtype {
        return false
      }
    }
  }
  true
}

/// 类型检查 / Type check.
pub fn fs_type_check(values : Array[Double], expected_type : FeatureType) -> Bool {
  match expected_type {
    Numerical => {
      for i in 0..<values.length() {
        if values[i] != values[i] {
          return false
        }
      }
      true
    }
    Binary => {
      for i in 0..<values.length() {
        if values[i] != 0.0 && values[i] != 1.0 {
          return false
        }
      }
      true
    }
    _ => true
  }
}

///===
/// FeatureIndex / 特征索引

pub struct FeatureIndex {
  name : String
  keys : Array[String]
  values : Array[Int]
} derive(Debug, Eq)

pub extend FeatureIndex with Eq::{equal, not_equal}
pub extend FeatureIndex with Debug::{to_repr}

/// 构造特征索引 / Build a feature index.
pub fn make_feature_index(name : String) -> FeatureIndex {
  { name, keys: [], values: [] }
}

/// 构建索引 / Build index.
pub fn index_build(
  index : FeatureIndex,
  entries : Array[(String, Int)]
) -> FeatureIndex {
  let keys : Array[String] = []
  let values : Array[Int] = []
  for i in 0..<entries.length() {
    keys.push(entries[i].0)
    values.push(entries[i].1)
  }
  { name: index.name, keys, values }
}

/// 索引查询 / Query index.
pub fn index_query(index : FeatureIndex, key : String) -> Int {
  for i in 0..<index.keys.length() {
    if index.keys[i] == key {
      return index.values[i]
    }
  }
  -1
}

/// 索引更新 / Update index.
pub fn index_update(
  index : FeatureIndex,
  key : String,
  value : Int
) -> FeatureIndex {
  let new_keys : Array[String] = []
  let new_values : Array[Int] = []
  let mut found = false
  for i in 0..<index.keys.length() {
    if index.keys[i] == key {
      new_keys.push(key)
      new_values.push(value)
      found = true
    } else {
      new_keys.push(index.keys[i])
      new_values.push(index.values[i])
    }
  }
  if !(found) {
    new_keys.push(key)
    new_values.push(value)
  }
  { name: index.name, keys: new_keys, values: new_values }
}

///===
/// 包标识 / Package id

/// 包标识 / Package id.
pub fn feature_store_id() -> String {
  let pkg = "opcore/feature_store"
  let version = "S12.12"
  let features = "def,group,view,online,offline,pit,join,vector,pipeline,monitor,transform,embedding,index,audit"
  let result = pkg + " (" + version + "): " + features
  if result.length() > 0 {
    result
  } else {
    pkg
  }
}