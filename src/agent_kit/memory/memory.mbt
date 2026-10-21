///|
/// # agent_kit/memory Agent 记忆 / Agent Memory
///
/// 短期记忆、长期记忆、工作记忆。
/// S11.4 新建。
///
/// # Agent memory operators

/// 记忆类型 / Memory type.
pub(all) enum MemoryType {
  ShortTerm
  LongTerm
  Working
  Episodic
}

/// 记忆条目 / Memory entry.
pub struct MemoryEntry {
  id : String
  content : String
  memory_type : MemoryType
  timestamp : Double
  importance : Double
  access_count : Int
}

/// 记忆存储 / Memory store.
pub struct MemoryStore {
  entries : Array[MemoryEntry]
  max_short_term : Int
  max_long_term : Int
}

/// 构造记忆条目 / Create memory entry.
pub fn make_memory_entry(
  id : String,
  content : String,
  memory_type : MemoryType,
  timestamp : Double,
  importance : Double,
) -> MemoryEntry {
  { id: id, content: content, memory_type: memory_type, timestamp: timestamp, importance: importance, access_count: 0 }
}

/// 构造记忆存储 / Create memory store.
pub fn make_memory_store(max_short_term : Int, max_long_term : Int) -> MemoryStore {
  { entries: [], max_short_term: max_short_term, max_long_term: max_long_term }
}

///===
/// 记忆操作 / Memory operations

/// 添加记忆 / Add memory entry.
pub fn add_memory(store : MemoryStore, entry : MemoryEntry) -> MemoryStore {
  let new_entries = store.entries.copy()
  new_entries.push(entry)
  { ..store, entries: prune_memory(new_entries, store.max_short_term, store.max_long_term) }
}

/// 修剪记忆 / Prune memory by capacity.
fn prune_memory(
  entries : Array[MemoryEntry],
  max_short : Int,
  max_long : Int,
) -> Array[MemoryEntry] {
  let short_entries : Array[MemoryEntry] = []
  let long_entries : Array[MemoryEntry] = []
  let other_entries : Array[MemoryEntry] = []
  for i in 0..<entries.length() {
    match entries[i].memory_type {
      ShortTerm => short_entries.push(entries[i])
      LongTerm => long_entries.push(entries[i])
      _ => other_entries.push(entries[i])
    }
  }
  let sorted_short = short_entries.copy()
  sorted_short.sort_by(fn(a, b) { b.timestamp.compare(a.timestamp) })
  let sorted_long = long_entries.copy()
  sorted_long.sort_by(fn(a, b) { b.importance.compare(a.importance) })
  let result : Array[MemoryEntry] = []
  let short_count = if sorted_short.length() < max_short { sorted_short.length() } else { max_short }
  for i in 0..<short_count {
    result.push(sorted_short[i])
  }
  let long_count = if sorted_long.length() < max_long { sorted_long.length() } else { max_long }
  for i in 0..<long_count {
    result.push(sorted_long[i])
  }
  for i in 0..<other_entries.length() {
    result.push(other_entries[i])
  }
  result
}

/// 检索记忆 / Retrieve memory by type.
pub fn retrieve_by_type(store : MemoryStore, memory_type : MemoryType) -> Array[MemoryEntry] {
  let result : Array[MemoryEntry] = []
  for i in 0..<store.entries.length() {
    let is_match = match (store.entries[i].memory_type, memory_type) {
      (ShortTerm, ShortTerm) => true
      (LongTerm, LongTerm) => true
      (Working, Working) => true
      (Episodic, Episodic) => true
      _ => false
    }
    if is_match {
      result.push(store.entries[i])
    }
  }
  result
}

/// 检索记忆 by 关键词 / Retrieve memory by keyword.
pub fn retrieve_by_keyword(store : MemoryStore, keyword : String) -> Array[MemoryEntry] {
  let result : Array[MemoryEntry] = []
  for i in 0..<store.entries.length() {
    if store.entries[i].content.contains(keyword) {
      result.push(store.entries[i])
    }
  }
  result
}

///===
/// 记忆访问 / Memory access

/// 访问记忆 / Access memory (increment access count).
pub fn access_memory(store : MemoryStore, entry_id : String) -> MemoryStore {
  let new_entries = store.entries.copy()
  for i in 0..<new_entries.length() {
    if new_entries[i].id == entry_id {
      new_entries[i] = { ..new_entries[i], access_count: new_entries[i].access_count + 1 }
    }
  }
  { ..store, entries: new_entries }
}

/// 清除短期记忆 / Clear short-term memory.
pub fn clear_short_term(store : MemoryStore) -> MemoryStore {
  let new_entries : Array[MemoryEntry] = []
  for i in 0..<store.entries.length() {
    let is_short = match store.entries[i].memory_type {
      ShortTerm => true
      _ => false
    }
    if !(is_short) {
      new_entries.push(store.entries[i])
    }
  }
  { ..store, entries: new_entries }
}

///===
/// 记忆统计 / Memory statistics

/// 记忆总数 / Total memory count.
pub fn memory_count(store : MemoryStore) -> Int {
  store.entries.length()
}

/// 按类型统计 / Count by type.
pub fn memory_count_by_type(store : MemoryStore, memory_type : MemoryType) -> Int {
  let mut count = 0
  for i in 0..<store.entries.length() {
    let is_match = match (store.entries[i].memory_type, memory_type) {
      (ShortTerm, ShortTerm) => true
      (LongTerm, LongTerm) => true
      (Working, Working) => true
      (Episodic, Episodic) => true
      _ => false
    }
    if is_match {
      count = count + 1
    }
  }
  count
}

///===
/// 类型名称 / Type name

pub fn memory_type_name(mt : MemoryType) -> String {
  match mt {
    ShortTerm => "short_term"
    LongTerm => "long_term"
    Working => "working"
    Episodic => "episodic"
  }
}

///===
/// ID

pub fn memory_id() -> String {
  "agent_kit/memory"
}