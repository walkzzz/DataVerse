///===
/// dataobject/metadata_ext 元数据管理 / Metadata Management
/// S12 Phase 12 — 元数据模式/提取/验证/索引/搜索/血缘/目录
/// 元数据管理：模式定义 + 提取 + 验证 + 索引 + 搜索 + 血缘 + 目录

///===
/// 元数据模式 / Metadata schema

pub struct MetadataField {
  name : String
  field_type : String
  nullable : Bool
  default_value : String
  description : String
  tags : Array[String]
}

/// 构造元数据字段
pub fn make_metadata_field(name : String, field_type : String) -> MetadataField {
  { name, field_type, nullable: true, default_value: "", description: "", tags: [] }
}

/// 设置可空
pub fn field_with_nullable(field : MetadataField, nullable : Bool) -> MetadataField {
  { name: field.name, field_type: field.field_type, nullable, default_value: field.default_value, description: field.description, tags: field.tags }
}

/// 设置默认值
pub fn field_with_default(field : MetadataField, default_value : String) -> MetadataField {
  { name: field.name, field_type: field.field_type, nullable: field.nullable, default_value, description: field.description, tags: field.tags }
}

/// 设置描述
pub fn field_with_description(field : MetadataField, description : String) -> MetadataField {
  { name: field.name, field_type: field.field_type, nullable: field.nullable, default_value: field.default_value, description, tags: field.tags }
}

/// 设置标签
pub fn field_with_tags(field : MetadataField, tags : Array[String]) -> MetadataField {
  { name: field.name, field_type: field.field_type, nullable: field.nullable, default_value: field.default_value, description: field.description, tags }
}

/// 字段转字符串
pub fn field_to_string(field : MetadataField) -> String {
  let mut result = field.name + ":" + field.field_type
  if field.nullable {
    result = result + "?"
  }
  if field.default_value != "" {
    result = result + " = " + field.default_value
  }
  if field.description != "" {
    result = result + " // " + field.description
  }
  result
}

/// 元数据模式
pub struct MetadataSchema {
  name : String
  fields : Array[MetadataField]
  version : String
  owner : String
}

/// 构造元数据模式
pub fn make_metadata_schema(name : String, fields : Array[MetadataField]) -> MetadataSchema {
  { name, fields, version: "1.0.0", owner: "" }
}

/// 模式带版本
pub fn schema_with_version(schema : MetadataSchema, version : String) -> MetadataSchema {
  { name: schema.name, fields: schema.fields, version, owner: schema.owner }
}

/// 模式带所有者
pub fn schema_with_owner(schema : MetadataSchema, owner : String) -> MetadataSchema {
  { name: schema.name, fields: schema.fields, version: schema.version, owner }
}

/// 模式转字符串
pub fn schema_to_string(schema : MetadataSchema) -> String {
  let mut result = "Schema " + schema.name + " v" + schema.version
  if schema.owner != "" {
    result = result + " (owner: " + schema.owner + ")"
  }
  result = result + " {\n"
  for i in 0..<array_length(schema.fields) {
    result = result + "  " + field_to_string(schema.fields[i]) + "\n"
  }
  result + "}"
}

/// 查找字段
pub fn schema_find_field(schema : MetadataSchema, name : String) -> Int {
  for i in 0..<array_length(schema.fields) {
    if schema.fields[i].name == name {
      return i
    }
  }
  -1
}

/// 字段数
pub fn schema_field_count(schema : MetadataSchema) -> Int {
  array_length(schema.fields)
}

///===
/// 元数据实例 / Metadata instance

pub struct MetadataInstance {
  schema_name : String
  values : Array[(String, String)]
  source : String
  timestamp : Int
}

/// 构造元数据实例
pub fn make_metadata_instance(schema_name : String, values : Array[(String, String)]) -> MetadataInstance {
  { schema_name, values, source: "", timestamp: 0 }
}

/// 实例带来源
pub fn instance_with_source(inst : MetadataInstance, source : String) -> MetadataInstance {
  { schema_name: inst.schema_name, values: inst.values, source, timestamp: inst.timestamp }
}

/// 实例带时间戳
pub fn instance_with_timestamp(inst : MetadataInstance, timestamp : Int) -> MetadataInstance {
  { schema_name: inst.schema_name, values: inst.values, source: inst.source, timestamp }
}

/// 获取字段值
pub fn instance_get(inst : MetadataInstance, field_name : String) -> String {
  for i in 0..<array_length(inst.values) {
    if inst.values[i].0 == field_name {
      return inst.values[i].1
    }
  }
  ""
}

/// 设置字段值
pub fn instance_set(inst : MetadataInstance, field_name : String, value : String) -> MetadataInstance {
  let mut new_values = []
  let mut found = false
  for i in 0..<array_length(inst.values) {
    if inst.values[i].0 == field_name {
      new_values = array_append_pair(new_values, [(field_name, value)])
      found = true
    } else {
      new_values = array_append_pair(new_values, [inst.values[i]])
    }
  }
  if !(found) {
    new_values = array_append_pair(new_values, [(field_name, value)])
  }
  { schema_name: inst.schema_name, values: new_values, source: inst.source, timestamp: inst.timestamp }
}

/// 实例转字符串
pub fn instance_to_string(inst : MetadataInstance) -> String {
  let mut result = inst.schema_name + " {"
  for i in 0..<array_length(inst.values) {
    if i > 0 {
      result = result + ", "
    }
    result = result + inst.values[i].0 + "=" + inst.values[i].1
  }
  result + "}"
}

///===
/// 元数据验证 / Metadata validation

pub struct ValidationResult {
  valid : Bool
  errors : Array[String]
  warnings : Array[String]
}

/// 构造验证结果
pub fn make_validation_result(valid : Bool) -> ValidationResult {
  { valid, errors: [], warnings: [] }
}

/// 添加错误
pub fn validation_add_error(result : ValidationResult, error : String) -> ValidationResult {
  { valid: false, errors: array_append_str(result.errors, [error]), warnings: result.warnings }
}

/// 添加警告
pub fn validation_add_warning(result : ValidationResult, warning : String) -> ValidationResult {
  { valid: result.valid, errors: result.errors, warnings: array_append_str(result.warnings, [warning]) }
}

/// 验证实例
pub fn validate_instance(schema : MetadataSchema, inst : MetadataInstance) -> ValidationResult {
  let mut result = make_validation_result(true)
  for i in 0..<array_length(schema.fields) {
    let field = schema.fields[i]
    let value = instance_get(inst, field.name)
    if value == "" && !(field.nullable) && field.default_value == "" {
      result = validation_add_error(result, "Missing required field: " + field.name)
    }
    if value != "" {
      let type_valid = validate_type(value, field.field_type)
      if !(type_valid) {
        result = validation_add_error(result, "Type mismatch for field " + field.name + ": expected " + field.field_type)
      }
    }
  }
  for i in 0..<array_length(inst.values) {
    let field_name = inst.values[i].0
    if schema_find_field(schema, field_name) == -1 {
      result = validation_add_warning(result, "Unknown field: " + field_name)
    }
  }
  result
}

/// 验证类型
fn validate_type(value : String, type_name : String) -> Bool {
  if type_name == "string" {
    true
  } else if type_name == "int" {
    is_int_string(value)
  } else if type_name == "double" {
    is_double_string(value)
  } else if type_name == "bool" {
    value == "true" || value == "false"
  } else {
    true
  }
}

fn is_int_string(s : String) -> Bool {
  if string_length(s) == 0 {
    return false
  }
  let mut start = 0
  if s[0] == 45 {
    start = 1
  }
  if start >= string_length(s) {
    return false
  }
  for i in start..<string_length(s) {
    if s[i] < 48 || s[i] > 57 {
      return false
    }
  }
  true
}

fn is_double_string(s : String) -> Bool {
  if string_length(s) == 0 {
    return false
  }
  let mut has_dot = false
  let mut start = 0
  if s[0] == 45 {
    start = 1
  }
  for i in start..<string_length(s) {
    if s[i] == 46 {
      if has_dot {
        return false
      }
      has_dot = true
    } else if s[i] < 48 || s[i] > 57 {
      return false
    }
  }
  true
}

///===
/// 元数据索引 / Metadata index

pub struct MetadataIndex {
  entries : Array[(String, MetadataInstance)]
  field_index : Array[(String, Array[String])]
}

/// 构造元数据索引
pub fn make_metadata_index() -> MetadataIndex {
  { entries: [], field_index: [] }
}

/// 添加到索引
pub fn index_add(index : MetadataIndex, id : String, inst : MetadataInstance) -> MetadataIndex {
  let new_entries = array_append_pair2(index.entries, [(id, inst)])
  let mut new_field_index = index.field_index
  for i in 0..<array_length(inst.values) {
    let field_name = inst.values[i].0
    let value = inst.values[i].1
    new_field_index = update_field_index(new_field_index, field_name, value, id)
  }
  { entries: new_entries, field_index: new_field_index }
}

fn update_field_index(field_index : Array[(String, Array[String])], field_name : String, _value : String, id : String) -> Array[(String, Array[String])] {
  let mut new_index = []
  let mut found = false
  for i in 0..<array_length(field_index) {
    if field_index[i].0 == field_name {
      found = true
      new_index = array_append_pair2(new_index, [(field_name, array_append_str(field_index[i].1, [id]))])
    } else {
      new_index = array_append_pair2(new_index, [field_index[i]])
    }
  }
  if !(found) {
    new_index = array_append_pair2(new_index, [(field_name, [id])])
  }
  new_index
}

/// 按字段搜索
pub fn index_search_by_field(index : MetadataIndex, field_name : String, value : String) -> Array[String] {
  let mut results = []
  for i in 0..<array_length(index.entries) {
    let id = index.entries[i].0
    let inst = index.entries[i].1
    if instance_get(inst, field_name) == value {
      results = array_append_str(results, [id])
    }
  }
  results
}

/// 按 ID 查找
pub fn index_get(index : MetadataIndex, id : String) -> MetadataInstance {
  for i in 0..<array_length(index.entries) {
    if index.entries[i].0 == id {
      return index.entries[i].1
    }
  }
  make_metadata_instance("", [])
}

/// 索引大小
pub fn index_size(index : MetadataIndex) -> Int {
  array_length(index.entries)
}

///===
/// 元数据搜索 / Metadata search

pub struct SearchQuery {
  field_filters : Array[(String, String)]
  text_query : String
  limit : Int
}

/// 构造搜索查询
pub fn make_search_query() -> SearchQuery {
  { field_filters: [], text_query: "", limit: 100 }
}

/// 添加字段过滤
pub fn search_add_filter(query : SearchQuery, field : String, value : String) -> SearchQuery {
  { field_filters: array_append_pair(query.field_filters, [(field, value)]), text_query: query.text_query, limit: query.limit }
}

/// 设置文本查询
pub fn search_with_text(query : SearchQuery, text : String) -> SearchQuery {
  { field_filters: query.field_filters, text_query: text, limit: query.limit }
}

/// 设置限制
pub fn search_with_limit(query : SearchQuery, limit : Int) -> SearchQuery {
  { field_filters: query.field_filters, text_query: query.text_query, limit }
}

/// 执行搜索
pub fn search_execute(index : MetadataIndex, query : SearchQuery) -> Array[(String, MetadataInstance)] {
  let mut results = []
  for i in 0..<array_length(index.entries) {
    let id = index.entries[i].0
    let inst = index.entries[i].1
    let mut matches = true
    for j in 0..<array_length(query.field_filters) {
      let field = query.field_filters[j].0
      let value = query.field_filters[j].1
      if instance_get(inst, field) != value {
        matches = false
      }
    }
    if matches && query.text_query != "" {
      let inst_str = instance_to_string(inst)
      if !(string_contains(inst_str, query.text_query)) {
        matches = false
      }
    }
    if matches {
      results = array_append_pair3(results, [(id, inst)])
      if array_length(results) >= query.limit {
        return results
      }
    }
  }
  results
}

///===
/// 元数据血缘 / Metadata lineage

pub struct LineageNode {
  id : String
  node_type : String
  name : String
}

/// 构造血缘节点
pub fn make_lineage_node(id : String, node_type : String, name : String) -> LineageNode {
  { id, node_type, name }
}

/// 血缘边
pub struct LineageEdge {
  source : String
  target : String
  edge_type : String
}

/// 构造血缘边
pub fn make_lineage_edge(source : String, target : String, edge_type : String) -> LineageEdge {
  { source, target, edge_type }
}

/// 血缘图
pub struct LineageGraph {
  nodes : Array[LineageNode]
  edges : Array[LineageEdge]
}

/// 构造血缘图
pub fn make_lineage_graph() -> LineageGraph {
  { nodes: [], edges: [] }
}

/// 添加节点
pub fn lineage_add_node(graph : LineageGraph, node : LineageNode) -> LineageGraph {
  { nodes: array_append_node(graph.nodes, [node]), edges: graph.edges }
}

/// 添加边
pub fn lineage_add_edge(graph : LineageGraph, edge : LineageEdge) -> LineageGraph {
  { nodes: graph.nodes, edges: array_append_edge(graph.edges, [edge]) }
}

/// 上游血缘
pub fn lineage_upstream(graph : LineageGraph, node_id : String) -> Array[String] {
  let mut results = []
  let mut queue = [node_id]
  let mut visited = []
  while array_length(queue) > 0 {
    let current = queue[0]
    ignore(queue.remove(0))
    if !(array_contains_str(visited, current)) {
      visited = array_append_str(visited, [current])
      for i in 0..<array_length(graph.edges) {
        if graph.edges[i].target == current {
          results = array_append_str(results, [graph.edges[i].source])
          queue = array_append_str(queue, [graph.edges[i].source])
        }
      }
    }
  }
  results
}

/// 下游血缘
pub fn lineage_downstream(graph : LineageGraph, node_id : String) -> Array[String] {
  let mut results = []
  let mut queue = [node_id]
  let mut visited = []
  while array_length(queue) > 0 {
    let current = queue[0]
    ignore(queue.remove(0))
    if !(array_contains_str(visited, current)) {
      visited = array_append_str(visited, [current])
      for i in 0..<array_length(graph.edges) {
        if graph.edges[i].source == current {
          results = array_append_str(results, [graph.edges[i].target])
          queue = array_append_str(queue, [graph.edges[i].target])
        }
      }
    }
  }
  results
}

/// 血缘路径
pub fn lineage_path(graph : LineageGraph, source : String, target : String) -> Array[String] {
  let mut path = [source]
  let mut current = source
  let mut visited = [source]
  let mut found = false
  while !(found) && current != target {
    let mut next = ""
    for i in 0..<array_length(graph.edges) {
      if graph.edges[i].source == current && !(array_contains_str(visited, graph.edges[i].target)) {
        next = graph.edges[i].target
        visited = array_append_str(visited, [next])
        path = array_append_str(path, [next])
        if next == target {
          found = true
        }
        break
      }
    }
    if next == "" {
      return []
    }
    current = next
  }
  if found {
    path
  } else {
    []
  }
}

///===
/// 元数据目录 / Metadata catalog

pub struct MetadataCatalog {
  schemas : Array[(String, MetadataSchema)]
  instances : MetadataIndex
  lineage : LineageGraph
  description : String
}

/// 构造元数据目录
pub fn make_metadata_catalog(description : String) -> MetadataCatalog {
  { schemas: [], instances: make_metadata_index(), lineage: make_lineage_graph(), description }
}

/// 注册模式
pub fn catalog_register_schema(catalog : MetadataCatalog, schema : MetadataSchema) -> MetadataCatalog {
  { schemas: array_append_pair2(catalog.schemas, [(schema.name, schema)]), instances: catalog.instances, lineage: catalog.lineage, description: catalog.description }
}

/// 获取模式
pub fn catalog_get_schema(catalog : MetadataCatalog, name : String) -> MetadataSchema {
  for i in 0..<array_length(catalog.schemas) {
    if catalog.schemas[i].0 == name {
      return catalog.schemas[i].1
    }
  }
  make_metadata_schema("", [])
}

/// 添加实例
pub fn catalog_add_instance(catalog : MetadataCatalog, id : String, inst : MetadataInstance) -> MetadataCatalog {
  { schemas: catalog.schemas, instances: index_add(catalog.instances, id, inst), lineage: catalog.lineage, description: catalog.description }
}

/// 搜索实例
pub fn catalog_search(catalog : MetadataCatalog, query : SearchQuery) -> Array[(String, MetadataInstance)] {
  search_execute(catalog.instances, query)
}

/// 目录模式数
pub fn catalog_schema_count(catalog : MetadataCatalog) -> Int {
  array_length(catalog.schemas)
}

/// 目录实例数
pub fn catalog_instance_count(catalog : MetadataCatalog) -> Int {
  index_size(catalog.instances)
}

/// 目录转字符串
pub fn catalog_to_string(catalog : MetadataCatalog) -> String {
  let mut result = "Catalog: " + catalog.description + "\n"
  result = result + "  Schemas: " + int_to_string(array_length(catalog.schemas)) + "\n"
  result = result + "  Instances: " + int_to_string(index_size(catalog.instances)) + "\n"
  result = result + "  Lineage nodes: " + int_to_string(array_length(catalog.lineage.nodes)) + "\n"
  result = result + "  Lineage edges: " + int_to_string(array_length(catalog.lineage.edges))
  result
}

///===
/// 元数据提取 / Metadata extraction

/// 从键值对提取
pub fn extract_from_pairs(pairs : Array[(String, String)]) -> MetadataInstance {
  make_metadata_instance("extracted", pairs)
}

/// 从 JSON 简化提取
pub fn extract_from_json(json : String) -> MetadataInstance {
  let pairs = parse_simple_json(json)
  make_metadata_instance("extracted", pairs)
}

fn parse_simple_json(json : String) -> Array[(String, String)] {
  let mut pairs = []
  let mut i = 0
  let n = string_length(json)
  while i < n {
    if json[i] == 34 {
      let mut key = ""
      i = i + 1
      while i < n && json[i] != 34 {
        key = key + String::from_array([Int::unsafe_to_char(json[i].to_int())])
        i = i + 1
      }
      i = i + 1
      while i < n && json[i] != 34 {
        i = i + 1
      }
      if i < n && json[i] == 34 {
        let mut value = ""
        i = i + 1
        while i < n && json[i] != 34 {
          value = value + String::from_array([Int::unsafe_to_char(json[i].to_int())])
          i = i + 1
        }
        pairs = array_append_pair(pairs, [(key, value)])
      }
    }
    i = i + 1
  }
  pairs
}

///===
/// 辅助函数 / Helper functions

fn string_contains(s : String, sub : String) -> Bool {
  let n = string_length(s)
  let m = string_length(sub)
  if m == 0 {
    return true
  }
  if m > n {
    return false
  }
  for i in 0..<(n - m + 1) {
    let mut is_match = true
    for j in 0..<m {
      if s[i + j] != sub[j] {
        is_match = false
      }
    }
    if is_match {
      return true
    }
  }
  false
}

fn string_length(s : String) -> Int {
  s.length()
}

fn[A] array_length(arr : Array[A]) -> Int {
  arr.length()
}

fn int_to_string(n : Int) -> String {
  n.to_string()
}

fn array_contains_str(arr : Array[String], x : String) -> Bool {
  for i in 0..<array_length(arr) {
    if arr[i] == x {
      return true
    }
  }
  false
}

fn array_append_str(arr : Array[String], elem : Array[String]) -> Array[String] {
  let n = array_length(arr)
  let m = array_length(elem)
  if n == 0 {
    return elem
  }
  let result = Array::make(n + m, arr[0])
  for i in 0..<n {
    result[i] = arr[i]
  }
  for i in 0..<m {
    result[n + i] = elem[i]
  }
  result
}

fn array_append_pair(arr : Array[(String, String)], elem : Array[(String, String)]) -> Array[(String, String)] {
  let n = array_length(arr)
  let m = array_length(elem)
  if n == 0 {
    return elem
  }
  let result = Array::make(n + m, arr[0])
  for i in 0..<n {
    result[i] = arr[i]
  }
  for i in 0..<m {
    result[n + i] = elem[i]
  }
  result
}

fn[A, B] array_append_pair2(arr : Array[(A, B)], elem : Array[(A, B)]) -> Array[(A, B)] {
  let n = array_length(arr)
  let m = array_length(elem)
  if n == 0 {
    return elem
  }
  let result = Array::make(n + m, arr[0])
  for i in 0..<n {
    result[i] = arr[i]
  }
  for i in 0..<m {
    result[n + i] = elem[i]
  }
  result
}

fn[A, B] array_append_pair3(arr : Array[(A, B)], elem : Array[(A, B)]) -> Array[(A, B)] {
  let n = array_length(arr)
  let m = array_length(elem)
  if n == 0 {
    return elem
  }
  let result = Array::make(n + m, arr[0])
  for i in 0..<n {
    result[i] = arr[i]
  }
  for i in 0..<m {
    result[n + i] = elem[i]
  }
  result
}

fn array_append_node(arr : Array[LineageNode], elem : Array[LineageNode]) -> Array[LineageNode] {
  let n = array_length(arr)
  let m = array_length(elem)
  if n == 0 {
    return elem
  }
  let result = Array::make(n + m, arr[0])
  for i in 0..<n {
    result[i] = arr[i]
  }
  for i in 0..<m {
    result[n + i] = elem[i]
  }
  result
}

fn array_append_edge(arr : Array[LineageEdge], elem : Array[LineageEdge]) -> Array[LineageEdge] {
  let n = array_length(arr)
  let m = array_length(elem)
  if n == 0 {
    return elem
  }
  let result = Array::make(n + m, arr[0])
  for i in 0..<n {
    result[i] = arr[i]
  }
  for i in 0..<m {
    result[n + i] = elem[i]
  }
  result
}