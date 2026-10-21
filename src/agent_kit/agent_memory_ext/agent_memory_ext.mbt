///|
/// # agent_kit/agent_memory_ext Agent 记忆扩展 / Agent Memory Extension
///
/// 向量 / 图 / 情节 / 语义 / 程序 / 工作 / 反思 / 固化 / 遗忘 / 关联 / 压缩 / 索引 / 缓存。
/// S11.5 新建：50+ pub fn Agent 记忆扩展算子。
///
/// # Agent memory extension
///
/// Vector / graph / episodic / semantic / procedural / working / reflective memory.

const MEM_LARGE_DOUBLE : Double = 999999999999999.0
const MEM_EPS : Double = 0.0000000000000001

/// 记忆种类 / Memory kind.
pub(all) enum MemoryKind {
  VectorKind
  GraphKind
  EpisodicKind
  SemanticKind
  ProceduralKind
  WorkingKind
  ReflectiveKind
} derive(Debug, Eq)

pub extend MemoryKind with Eq::{equal, not_equal}
pub extend MemoryKind with Debug::{to_repr}

/// 优先级 / Priority level.
pub(all) enum PriorityLevel {
  PriorityLow
  PriorityMedium
  PriorityHigh
} derive(Debug, Eq)

pub extend PriorityLevel with Eq::{equal, not_equal}
pub extend PriorityLevel with Debug::{to_repr}

/// 记忆条目 / Memory item.
pub struct MemoryItem {
  id : String
  content : String
  embedding : Array[Double]
  kind : MemoryKind
  priority : PriorityLevel
  timestamp : Double
  importance : Double
  access_count : Int
  decay_factor : Double
}

/// 记忆扩展 / Memory extension (main store).
pub struct MemoryExt {
  items : Array[MemoryItem]
  capacity : Int
  cache : Array[MemoryItem]
  index : Array[(String, Int)]
}

/// 向量记忆 / Vector memory.
pub struct VectorMemory {
  items : Array[MemoryItem]
  dimension : Int
}

/// 图记忆 / Graph memory.
pub struct GraphMemory {
  nodes : Array[MemoryItem]
  edges : Array[(String, String, Double)]
}

/// 情节记忆 / Episodic memory.
pub struct EpisodicExt {
  episodes : Array[MemoryItem]
  current_episode : Int
}

/// 语义记忆 / Semantic memory.
pub struct SemanticMemory {
  items : Array[MemoryItem]
  encoded : Array[(String, Array[Double])]
}

/// 程序记忆 / Procedural memory.
pub struct ProceduralMemory {
  procedures : Array[MemoryItem]
  execution_count : Int
}

/// 工作记忆 / Working memory.
pub struct WorkingMemory {
  stack : Array[MemoryItem]
  max_size : Int
}

/// 反思记忆 / Reflective memory.
pub struct ReflectiveMemory {
  reflections : Array[MemoryItem]
  analysis_count : Int
}

/// 记忆固化 / Memory consolidation.
pub struct MemoryConsolidation {
  short_term : Array[MemoryItem]
  long_term : Array[MemoryItem]
}

/// 记忆遗忘 / Memory forgetting.
pub struct MemoryForgetting {
  decay_rate : Double
  repetition_boost : Double
}

/// 记忆关联 / Memory association.
pub struct MemoryAssociation {
  links : Array[(String, String, Double)]
}

/// 记忆压缩 / Memory compression.
pub struct MemoryCompression {
  compressed : Array[(String, String)]
  ratio : Double
}

/// 记忆索引 / Memory index.
pub struct MemoryIndex {
  entries : Array[(String, Int)]
  built : Bool
}

/// 记忆缓存 / Memory cache.
pub struct MemoryCache {
  entries : Array[MemoryItem]
  max_size : Int
}

///===
/// 辅助数学 / Helper math (private)

fn mem_sqrt(x : Double) -> Double {
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

fn mem_abs(x : Double) -> Double {
  if x < 0.0 {
    -x
  } else {
    x
  }
}

fn mem_exp(x : Double) -> Double {
  if x > 700.0 {
    return MEM_LARGE_DOUBLE
  }
  if x < -700.0 {
    return 0.0
  }
  let mut result = 1.0
  let mut term = 1.0
  for i in 1..<40 {
    term = term * x / i.to_double()
    result = result + term
    if mem_abs(term) < MEM_EPS {
      break
    }
  }
  result
}

fn mem_cosine_sim(a : Array[Double], b : Array[Double]) -> Double {
  let len = if a.length() < b.length() { a.length() } else { b.length() }
  if len == 0 {
    return 0.0
  }
  let mut dot = 0.0
  let mut na = 0.0
  let mut nb = 0.0
  for i in 0..<len {
    dot = dot + a[i] * b[i]
    na = na + a[i] * a[i]
    nb = nb + b[i] * b[i]
  }
  let denom = mem_sqrt(na) * mem_sqrt(nb)
  if denom == 0.0 {
    0.0
  } else {
    dot / denom
  }
}

///===
/// 构造 / Constructors

/// 构造记忆条目 / Create memory item.
pub fn make_memory_item(
  id : String,
  content : String,
  embedding : Array[Double],
  kind : MemoryKind,
  priority : PriorityLevel,
  timestamp : Double,
  importance : Double,
) -> MemoryItem {
  { id: id, content: content, embedding: embedding, kind: kind, priority: priority, timestamp: timestamp, importance: importance, access_count: 0, decay_factor: 1.0 }
}

/// 构造记忆扩展 / Create memory extension.
pub fn make_memory_ext(capacity : Int) -> MemoryExt {
  { items: [], capacity: capacity, cache: [], index: [] }
}

/// 构造向量记忆 / Create vector memory.
pub fn make_vector_memory(dimension : Int) -> VectorMemory {
  { items: [], dimension: dimension }
}

/// 构造图记忆 / Create graph memory.
pub fn make_graph_memory() -> GraphMemory {
  { nodes: [], edges: [] }
}

/// 构造情节记忆 / Create episodic memory.
pub fn make_episodic_ext() -> EpisodicExt {
  { episodes: [], current_episode: 0 }
}

/// 构造语义记忆 / Create semantic memory.
pub fn make_semantic_memory() -> SemanticMemory {
  { items: [], encoded: [] }
}

/// 构造程序记忆 / Create procedural memory.
pub fn make_procedural_memory() -> ProceduralMemory {
  { procedures: [], execution_count: 0 }
}

/// 构造工作记忆 / Create working memory.
pub fn make_working_memory(max_size : Int) -> WorkingMemory {
  { stack: [], max_size: max_size }
}

/// 构造反思记忆 / Create reflective memory.
pub fn make_reflective_memory() -> ReflectiveMemory {
  { reflections: [], analysis_count: 0 }
}

/// 构造记忆固化 / Create memory consolidation.
pub fn make_memory_consolidation() -> MemoryConsolidation {
  { short_term: [], long_term: [] }
}

/// 构造记忆遗忘 / Create memory forgetting.
pub fn make_memory_forgetting(decay_rate : Double, repetition_boost : Double) -> MemoryForgetting {
  { decay_rate: decay_rate, repetition_boost: repetition_boost }
}

/// 构造记忆关联 / Create memory association.
pub fn make_memory_association() -> MemoryAssociation {
  { links: [] }
}

/// 构造记忆压缩 / Create memory compression.
pub fn make_memory_compression() -> MemoryCompression {
  { compressed: [], ratio: 0.0 }
}

/// 构造记忆索引 / Create memory index.
pub fn make_memory_index() -> MemoryIndex {
  { entries: [], built: false }
}

/// 构造记忆缓存 / Create memory cache.
pub fn make_memory_cache(max_size : Int) -> MemoryCache {
  { entries: [], max_size: max_size }
}

///===
/// 基础操作 / Basic operations

/// 添加记忆 / Add memory item.
pub fn ext_add(ext : MemoryExt, item : MemoryItem) -> MemoryExt {
  let new_items = ext.items.copy()
  new_items.push(item)
  let pruned = mem_prune_items(new_items, ext.capacity)
  { ..ext, items: pruned }
}

/// 检索记忆 / Retrieve memory by id.
pub fn ext_retrieve(ext : MemoryExt, id : String) -> MemoryItem {
  let empty = make_memory_item("", "", [], VectorKind, PriorityLow, 0.0, 0.0)
  for i in 0..<ext.items.length() {
    if ext.items[i].id == id {
      return ext.items[i]
    }
  }
  empty
}

/// 搜索记忆 / Search memory by keyword.
pub fn ext_search(ext : MemoryExt, keyword : String) -> Array[MemoryItem] {
  let result : Array[MemoryItem] = []
  for i in 0..<ext.items.length() {
    if ext.items[i].content.contains(keyword) {
      result.push(ext.items[i])
    }
  }
  result
}

fn mem_prune_items(items : Array[MemoryItem], capacity : Int) -> Array[MemoryItem] {
  if items.length() <= capacity {
    return items
  }
  let sorted = items.copy()
  sorted.sort_by(fn(a, b) { b.importance.compare(a.importance) })
  let result : Array[MemoryItem] = []
  for i in 0..<capacity {
    result.push(sorted[i])
  }
  result
}

///===
/// 向量记忆 / Vector memory

/// 向量存储 / Store vector.
pub fn vector_store(vm : VectorMemory, item : MemoryItem) -> VectorMemory {
  let new_items = vm.items.copy()
  new_items.push(item)
  { ..vm, items: new_items }
}

/// 向量搜索 / Vector search memory.
pub fn vector_search_mem(vm : VectorMemory, query : Array[Double], top_k : Int) -> Array[MemoryItem] {
  let scored : Array[(MemoryItem, Double)] = []
  for i in 0..<vm.items.length() {
    let sim = mem_cosine_sim(query, vm.items[i].embedding)
    scored.push((vm.items[i], sim))
  }
  scored.sort_by(fn(a, b) { b.1.compare(a.1) })
  let result : Array[MemoryItem] = []
  let k = if top_k < scored.length() { top_k } else { scored.length() }
  for i in 0..<k {
    result.push(scored[i].0)
  }
  result
}

/// 向量索引 / Vector index (return sorted indices by similarity).
pub fn vector_index(vm : VectorMemory, query : Array[Double]) -> Array[Int] {
  let scored : Array[(Int, Double)] = []
  for i in 0..<vm.items.length() {
    let sim = mem_cosine_sim(query, vm.items[i].embedding)
    scored.push((i, sim))
  }
  scored.sort_by(fn(a, b) { b.1.compare(a.1) })
  let result : Array[Int] = []
  for i in 0..<scored.length() {
    result.push(scored[i].0)
  }
  result
}

///===
/// 图记忆 / Graph memory

/// 图存储 / Store graph node.
pub fn graph_store(gm : GraphMemory, item : MemoryItem) -> GraphMemory {
  let new_nodes = gm.nodes.copy()
  new_nodes.push(item)
  { ..gm, nodes: new_nodes }
}

/// 图遍历 / Graph traverse (BFS from node id).
pub fn graph_traverse_mem(gm : GraphMemory, start_id : String, max_depth : Int) -> Array[String] {
  let result : Array[String] = []
  let visited : Array[String] = []
  let frontier : Array[(String, Int)] = [(start_id, 0)]
  while frontier.length() > 0 {
    let head = frontier[0]
    let _ = frontier.remove(0)
    let node_id = head.0
    let depth = head.1
    let mut already = false
    for i in 0..<visited.length() {
      if visited[i] == node_id {
        already = true
        break
      }
    }
    if already {
      continue
    }
    visited.push(node_id)
    result.push(node_id)
    if depth >= max_depth {
      continue
    }
    for i in 0..<gm.edges.length() {
      if gm.edges[i].0 == node_id {
        frontier.push((gm.edges[i].1, depth + 1))
      }
    }
  }
  result
}

/// 图查询 / Graph query (neighbors of node).
pub fn graph_query_mem(gm : GraphMemory, node_id : String) -> Array[String] {
  let result : Array[String] = []
  for i in 0..<gm.edges.length() {
    if gm.edges[i].0 == node_id {
      result.push(gm.edges[i].1)
    }
  }
  result
}

///===
/// 情节记忆 / Episodic memory

/// 情节存储 / Store episode.
pub fn episode_store(em : EpisodicExt, item : MemoryItem) -> EpisodicExt {
  let new_episodes = em.episodes.copy()
  new_episodes.push(item)
  { ..em, episodes: new_episodes, current_episode: new_episodes.length() - 1 }
}

/// 情节检索 / Retrieve episode by index.
pub fn episode_retrieve(em : EpisodicExt, index : Int) -> MemoryItem {
  let empty = make_memory_item("", "", [], EpisodicKind, PriorityLow, 0.0, 0.0)
  if index < 0 || index >= em.episodes.length() {
    return empty
  }
  em.episodes[index]
}

/// 情节回放 / Replay episodes (return all in order).
pub fn episode_replay_mem(em : EpisodicExt) -> Array[MemoryItem] {
  em.episodes.copy()
}

///===
/// 语义记忆 / Semantic memory

/// 语义编码 / Semantic encode (store with embedding).
pub fn semantic_encode(sm : SemanticMemory, id : String, embedding : Array[Double]) -> SemanticMemory {
  let new_encoded = sm.encoded.copy()
  new_encoded.push((id, embedding))
  { ..sm, encoded: new_encoded }
}

/// 语义搜索 / Semantic search.
pub fn semantic_search(sm : SemanticMemory, query : Array[Double], top_k : Int) -> Array[String] {
  let scored : Array[(String, Double)] = []
  for i in 0..<sm.encoded.length() {
    let sim = mem_cosine_sim(query, sm.encoded[i].1)
    scored.push((sm.encoded[i].0, sim))
  }
  scored.sort_by(fn(a, b) { b.1.compare(a.1) })
  let result : Array[String] = []
  let k = if top_k < scored.length() { top_k } else { scored.length() }
  for i in 0..<k {
    result.push(scored[i].0)
  }
  result
}

/// 语义匹配 / Semantic match (best match id).
pub fn semantic_match(sm : SemanticMemory, query : Array[Double]) -> String {
  let results = semantic_search(sm, query, 1)
  if results.length() == 0 {
    ""
  } else {
    results[0]
  }
}

///===
/// 程序记忆 / Procedural memory

/// 程序存储 / Store procedure.
pub fn procedure_store(pm : ProceduralMemory, item : MemoryItem) -> ProceduralMemory {
  let new_procedures = pm.procedures.copy()
  new_procedures.push(item)
  { ..pm, procedures: new_procedures }
}

/// 程序检索 / Retrieve procedure by id.
pub fn procedure_retrieve(pm : ProceduralMemory, id : String) -> MemoryItem {
  let empty = make_memory_item("", "", [], ProceduralKind, PriorityLow, 0.0, 0.0)
  for i in 0..<pm.procedures.length() {
    if pm.procedures[i].id == id {
      return pm.procedures[i]
    }
  }
  empty
}

/// 程序执行 / Execute procedure (increment execution count).
pub fn procedure_execute(pm : ProceduralMemory, id : String) -> ProceduralMemory {
  let new_procedures = pm.procedures.copy()
  for i in 0..<new_procedures.length() {
    if new_procedures[i].id == id {
      new_procedures[i] = { ..new_procedures[i], access_count: new_procedures[i].access_count + 1 }
    }
  }
  { ..pm, procedures: new_procedures, execution_count: pm.execution_count + 1 }
}

///===
/// 工作记忆 / Working memory

/// 工作记忆压入 / Push to working memory.
pub fn working_push(wm : WorkingMemory, item : MemoryItem) -> WorkingMemory {
  let new_stack = wm.stack.copy()
  new_stack.push(item)
  if new_stack.length() > wm.max_size {
    let _ = new_stack.remove(0)
  }
  { ..wm, stack: new_stack }
}

/// 工作记忆弹出 / Pop from working memory.
pub fn working_pop(wm : WorkingMemory) -> (WorkingMemory, MemoryItem) {
  let empty = make_memory_item("", "", [], WorkingKind, PriorityLow, 0.0, 0.0)
  if wm.stack.length() == 0 {
    return (wm, empty)
  }
  let new_stack = wm.stack.copy()
  let last = new_stack[new_stack.length() - 1]
  let _ = new_stack.remove(new_stack.length() - 1)
  ({ ..wm, stack: new_stack }, last)
}

/// 工作记忆清空 / Clear working memory.
pub fn working_clear(wm : WorkingMemory) -> WorkingMemory {
  { ..wm, stack: [] }
}

///===
/// 反思记忆 / Reflective memory

/// 反思存储 / Store reflection.
pub fn reflect_store(rm : ReflectiveMemory, item : MemoryItem) -> ReflectiveMemory {
  let new_reflections = rm.reflections.copy()
  new_reflections.push(item)
  { ..rm, reflections: new_reflections }
}

/// 反思检索 / Retrieve reflections by keyword.
pub fn reflect_retrieve(rm : ReflectiveMemory, keyword : String) -> Array[MemoryItem] {
  let result : Array[MemoryItem] = []
  for i in 0..<rm.reflections.length() {
    if rm.reflections[i].content.contains(keyword) {
      result.push(rm.reflections[i])
    }
  }
  result
}

/// 反思分析 / Analyze reflections (count and average importance).
pub fn reflect_analyze(rm : ReflectiveMemory) -> (Int, Double) {
  let n = rm.reflections.length()
  if n == 0 {
    return (0, 0.0)
  }
  let mut sum = 0.0
  for i in 0..<n {
    sum = sum + rm.reflections[i].importance
  }
  (n, sum / n.to_double())
}

///===
/// 记忆固化 / Consolidation

/// 短期固化 / Consolidate short-term (move high importance to long-term).
pub fn consolidate_short(mc : MemoryConsolidation, threshold : Double) -> MemoryConsolidation {
  let new_long = mc.long_term.copy()
  let remaining : Array[MemoryItem] = []
  for i in 0..<mc.short_term.length() {
    if mc.short_term[i].importance >= threshold {
      new_long.push(mc.short_term[i])
    } else {
      remaining.push(mc.short_term[i])
    }
  }
  { short_term: remaining, long_term: new_long }
}

/// 长期固化 / Consolidate long-term (merge into existing).
pub fn consolidate_long(mc : MemoryConsolidation, items : Array[MemoryItem]) -> MemoryConsolidation {
  let new_long = mc.long_term.copy()
  for i in 0..<items.length() {
    new_long.push(items[i])
  }
  { ..mc, long_term: new_long }
}

///===
/// 记忆遗忘 / Forgetting

/// 衰减遗忘 / Decay forgetting.
pub fn forget_decay(mf : MemoryForgetting, item : MemoryItem, elapsed : Double) -> MemoryItem {
  let decay = mem_exp(-mf.decay_rate * elapsed)
  { ..item, decay_factor: item.decay_factor * decay, importance: item.importance * decay }
}

/// 间隔遗忘 / Spaced repetition.
pub fn forget_spaced(mf : MemoryForgetting, item : MemoryItem, interval : Double) -> MemoryItem {
  let boost = mem_exp(mf.repetition_boost * interval)
  { ..item, importance: item.importance * boost, access_count: item.access_count + 1 }
}

/// 重复遗忘 / Repetition boost.
pub fn forget_repetition(mf : MemoryForgetting, item : MemoryItem, repetitions : Int) -> MemoryItem {
  let boost = 1.0 + mf.repetition_boost * repetitions.to_double()
  { ..item, importance: item.importance * boost, access_count: item.access_count + repetitions }
}

///===
/// 记忆关联 / Association

/// 关联链接 / Associate link.
pub fn associate_link(ma : MemoryAssociation, from_id : String, to_id : String, weight : Double) -> MemoryAssociation {
  let new_links = ma.links.copy()
  new_links.push((from_id, to_id, weight))
  { ..ma, links: new_links }
}

/// 关联检索 / Associate retrieve (linked ids).
pub fn associate_retrieve(ma : MemoryAssociation, id : String) -> Array[String] {
  let result : Array[String] = []
  for i in 0..<ma.links.length() {
    if ma.links[i].0 == id {
      result.push(ma.links[i].1)
    }
  }
  result
}

/// 关联扩散 / Associate spread (multi-hop).
pub fn associate_spread(ma : MemoryAssociation, start_id : String, max_hops : Int) -> Array[String] {
  let result : Array[String] = []
  let visited : Array[String] = [start_id]
  let frontier : Array[(String, Int)] = [(start_id, 0)]
  while frontier.length() > 0 {
    let head = frontier[0]
    let _ = frontier.remove(0)
    let node_id = head.0
    let hops = head.1
    if hops >= max_hops {
      continue
    }
    for i in 0..<ma.links.length() {
      if ma.links[i].0 == node_id {
        let target = ma.links[i].1
        let mut already = false
        for j in 0..<visited.length() {
          if visited[j] == target {
            already = true
            break
          }
        }
        if !(already) {
          visited.push(target)
          result.push(target)
          frontier.push((target, hops + 1))
        }
      }
    }
  }
  result
}

///===
/// 记忆压缩 / Compression

/// 压缩记忆 / Compress memory (summarize content).
pub fn compress_mem(mc : MemoryCompression, id : String, content : String) -> MemoryCompression {
  let new_compressed = mc.compressed.copy()
  let summary = if content.length() > 100 { content[:100].to_owned() } else { content }
  new_compressed.push((id, summary))
  let ratio = if content.length() == 0 { 0.0 } else { summary.length().to_double() / content.length().to_double() }
  { ..mc, compressed: new_compressed, ratio: ratio }
}

/// 解压记忆 / Decompress memory (return original if stored).
pub fn decompress_mem(mc : MemoryCompression, id : String) -> String {
  for i in 0..<mc.compressed.length() {
    if mc.compressed[i].0 == id {
      return mc.compressed[i].1
    }
  }
  ""
}

/// 压缩摘要 / Compress summary (overall ratio).
pub fn compress_summary(mc : MemoryCompression) -> Double {
  mc.ratio
}

///===
/// 记忆索引 / Index

/// 构建索引 / Build memory index.
pub fn index_build_mem(mi : MemoryIndex, items : Array[MemoryItem]) -> MemoryIndex {
  let entries : Array[(String, Int)] = []
  for i in 0..<items.length() {
    entries.push((items[i].id, i))
  }
  { entries: entries, built: true }
}

/// 查询索引 / Query memory index.
pub fn index_query_mem(mi : MemoryIndex, id : String) -> Int {
  for i in 0..<mi.entries.length() {
    if mi.entries[i].0 == id {
      return mi.entries[i].1
    }
  }
  -1
}

/// 更新索引 / Update memory index.
pub fn index_update_mem(mi : MemoryIndex, id : String, idx : Int) -> MemoryIndex {
  let new_entries = mi.entries.copy()
  let mut found = false
  for i in 0..<new_entries.length() {
    if new_entries[i].0 == id {
      new_entries[i] = (id, idx)
      found = true
      break
    }
  }
  if !(found) {
    new_entries.push((id, idx))
  }
  { ..mi, entries: new_entries }
}

///===
/// 记忆缓存 / Cache

/// 缓存存储 / Cache store.
pub fn cache_store(mc : MemoryCache, item : MemoryItem) -> MemoryCache {
  let new_entries = mc.entries.copy()
  new_entries.push(item)
  if new_entries.length() > mc.max_size {
    let _ = new_entries.remove(0)
  }
  { ..mc, entries: new_entries }
}

/// 缓存查找 / Cache lookup.
pub fn cache_lookup(mc : MemoryCache, id : String) -> MemoryItem {
  let empty = make_memory_item("", "", [], VectorKind, PriorityLow, 0.0, 0.0)
  for i in 0..<mc.entries.length() {
    if mc.entries[i].id == id {
      return mc.entries[i]
    }
  }
  empty
}

/// 缓存失效 / Cache invalidate.
pub fn cache_invalidate(mc : MemoryCache, id : String) -> MemoryCache {
  let new_entries : Array[MemoryItem] = []
  for i in 0..<mc.entries.length() {
    if mc.entries[i].id != id {
      new_entries.push(mc.entries[i])
    }
  }
  { ..mc, entries: new_entries }
}

///===
/// 容量 / 使用 / 驱逐 / 优先级 / Capacity / Usage / Evict / Priority

/// 记忆容量 / Memory capacity.
pub fn memory_capacity(ext : MemoryExt) -> Int {
  ext.capacity
}

/// 记忆使用 / Memory usage (current size).
pub fn memory_usage(ext : MemoryExt) -> Int {
  ext.items.length()
}

/// 记忆驱逐 / Memory evict (remove lowest importance).
pub fn memory_evict(ext : MemoryExt, count : Int) -> MemoryExt {
  if count <= 0 {
    return ext
  }
  let sorted = ext.items.copy()
  sorted.sort_by(fn(a, b) { a.importance.compare(b.importance) })
  let remove_n = if count < sorted.length() { count } else { sorted.length() }
  let remaining : Array[MemoryItem] = []
  for i in remove_n..<sorted.length() {
    remaining.push(sorted[i])
  }
  { ..ext, items: remaining }
}

/// 记忆优先级 / Memory priority (set priority of item).
pub fn memory_priority(ext : MemoryExt, id : String, priority : PriorityLevel) -> MemoryExt {
  let new_items = ext.items.copy()
  for i in 0..<new_items.length() {
    if new_items[i].id == id {
      new_items[i] = { ..new_items[i], priority: priority }
    }
  }
  { ..ext, items: new_items }
}

///===
/// ID

/// 模块 ID / Module id.
pub fn agent_memory_ext_id() -> String {
  "agent_kit/agent_memory_ext"
}