///|
/// # datatemporal/event_sourcing 事件溯源 / Event Sourcing
///
/// 事件存储、聚合、命令、快照、投影、订阅、Saga、CQRS、死信、重放。
///
/// # Event sourcing operators

///|
///===
/// 内部数学辅助 / Internal math helpers
fn es_max(a : Int32, b : Int32) -> Int32 {
  if a > b {
    a
  } else {
    b
  }
}

///|
fn es_min(a : Int32, b : Int32) -> Int32 {
  if a < b {
    a
  } else {
    b
  }
}

///|
///===
/// Event
pub struct Event {
  id : String
  aggregate_id : String
  event_type : String
  payload : String
  timestamp : Int32
  version : Int32
} derive(Debug, Eq)

///|
pub extend Event with Eq::{equal, not_equal}

///|
pub extend Event with Debug::{to_repr}

///|
/// 构造事件 / Build event.
pub fn make_event(
  id : String,
  aggregate_id : String,
  event_type : String,
  payload : String,
  timestamp : Int32,
) -> Event {
  { id, aggregate_id, event_type, payload, timestamp, version: 1, }
}

///|
/// 事件序列化 / Serialize event.
pub fn event_serialize(e : Event) -> String {
  e.id +
  "|" +
  e.aggregate_id +
  "|" +
  e.event_type +
  "|" +
  e.payload +
  "|" +
  e.timestamp.to_string() +
  "|" +
  e.version.to_string()
}

///|
/// 事件反序列化 / Deserialize event.
pub fn event_deserialize(s : String) -> Event {
  let parts : Array[String] = []
  let mut current = ""
  let n = s.length()
  let mut i = 0
  while i < n {
    let ch = s[i]
    if ch == 124 {
      parts.push(current)
      current = ""
    } else {
      current = current + ch.to_int().unsafe_to_char().to_string()
    }
    i = i + 1
  }
  parts.push(current)
  if parts.length() < 6 {
    return make_event("", "", "", "", 0)
  }
  {
    id: parts[0],
    aggregate_id: parts[1],
    event_type: parts[2],
    payload: parts[3],
    timestamp: 0,
    version: 0,
  }
}

///|
///===
/// EventStore
pub struct EventStore {
  id : String
  events : Array[Event]
  next_version : Int32
} derive(Debug, Eq)

///|
pub extend EventStore with Eq::{equal, not_equal}

///|
pub extend EventStore with Debug::{to_repr}

///|
/// 构造事件存储 / Build event store.
pub fn make_event_store(id : String) -> EventStore {
  { id, events: [], next_version: 1, }
}

///|
/// 存储事件 / Store event.
pub fn store_event(store : EventStore, event : Event) -> EventStore {
  let events : Array[Event] = []
  for i in 0..<store.events.length() {
    events.push(store.events[i])
  }
  let stamped = {
    id: event.id,
    aggregate_id: event.aggregate_id,
    event_type: event.event_type,
    payload: event.payload,
    timestamp: event.timestamp,
    version: store.next_version,
  }
  events.push(stamped)
  { id: store.id, events, next_version: store.next_version + 1, }
}

///|
/// 加载事件 / Load events for aggregate.
pub fn load_events(store : EventStore, aggregate_id : String) -> Array[Event] {
  let result : Array[Event] = []
  for i in 0..<store.events.length() {
    if store.events[i].aggregate_id == aggregate_id {
      result.push(store.events[i])
    }
  }
  result
}

///|
/// 重放事件 / Replay events to rebuild state.
pub fn replay_events(events : Array[Event]) -> String {
  let mut state = ""
  for i in 0..<events.length() {
    state = state + events[i].event_type + ":" + events[i].payload
    if i < events.length() - 1 {
      state = state + ";"
    }
  }
  state
}

///|
///===
/// Aggregate
pub struct Aggregate {
  id : String
  state : String
  version : Int32
} derive(Debug, Eq)

///|
pub extend Aggregate with Eq::{equal, not_equal}

///|
pub extend Aggregate with Debug::{to_repr}

///|
/// 构造聚合 / Build aggregate.
pub fn make_aggregate(id : String) -> Aggregate {
  { id, state: "", version: 0, }
}

///|
/// 聚合应用事件 / Apply event to aggregate.
pub fn aggregate_apply(agg : Aggregate, event : Event) -> Aggregate {
  {
    id: agg.id,
    state: agg.state + event.event_type + ":" + event.payload + ";",
    version: es_max(agg.version, event.version) + 1,
  }
}

///|
/// 聚合状态 / Get aggregate state.
pub fn aggregate_state(agg : Aggregate) -> String {
  agg.state
}

///|
///===
/// Command
pub struct Command {
  id : String
  aggregate_id : String
  command_type : String
  payload : String
} derive(Debug, Eq)

///|
pub extend Command with Eq::{equal, not_equal}

///|
pub extend Command with Debug::{to_repr}

///|
/// 构造命令 / Build command.
pub fn make_command(
  id : String,
  aggregate_id : String,
  command_type : String,
  payload : String,
) -> Command {
  { id, aggregate_id, command_type, payload, }
}

///|
/// 命令验证 / Validate command.
pub fn command_validate(cmd : Command) -> Bool {
  cmd.id.length() > 0 &&
  cmd.aggregate_id.length() > 0 &&
  cmd.command_type.length() > 0
}

///|
/// 命令执行 / Execute command producing event.
pub fn command_execute(cmd : Command, timestamp : Int32) -> Event {
  make_event(cmd.id, cmd.aggregate_id, cmd.command_type, cmd.payload, timestamp)
}

///|
///===
/// Snapshot
pub struct Snapshot {
  aggregate_id : String
  state : String
  version : Int32
  timestamp : Int32
} derive(Debug, Eq)

///|
pub extend Snapshot with Eq::{equal, not_equal}

///|
pub extend Snapshot with Debug::{to_repr}

///|
/// 构造快照 / Build snapshot.
pub fn make_snapshot(
  aggregate_id : String,
  state : String,
  version : Int32,
) -> Snapshot {
  { aggregate_id, state, version, timestamp: 0, }
}

///|
/// 保存快照 / Save snapshot.
pub fn snapshot_save(agg : Aggregate, timestamp : Int32) -> Snapshot {
  { aggregate_id: agg.id, state: agg.state, version: agg.version, timestamp, }
}

///|
/// 加载快照 / Load snapshot into aggregate.
pub fn snapshot_load(snap : Snapshot) -> Aggregate {
  { id: snap.aggregate_id, state: snap.state, version: snap.version, }
}

///|
/// 快照间隔 / Compute snapshot interval.
pub fn snapshot_interval(total_events : Int32, snapshot_every : Int32) -> Int32 {
  if snapshot_every <= 0 {
    return 0
  }
  total_events / snapshot_every
}

///|
///===
/// Projection
pub struct Projection {
  name : String
  read_model : Array[(String, String)]
} derive(Debug, Eq)

///|
pub extend Projection with Eq::{equal, not_equal}

///|
pub extend Projection with Debug::{to_repr}

///|
/// 构造投影 / Build projection.
pub fn make_projection(name : String) -> Projection {
  { name, read_model: [], }
}

///|
/// 投影应用事件 / Apply event to projection.
pub fn projection_apply(proj : Projection, event : Event) -> Projection {
  let read_model : Array[(String, String)] = []
  for i in 0..<proj.read_model.length() {
    read_model.push(proj.read_model[i])
  }
  read_model.push((event.aggregate_id, event.payload))
  { name: proj.name, read_model, }
}

///|
/// 投影查询 / Query projection.
pub fn projection_query(proj : Projection, aggregate_id : String) -> String {
  let mut result = ""
  for i in 0..<proj.read_model.length() {
    let pair = proj.read_model[i]
    if pair.0 == aggregate_id {
      result = result + pair.1 + ";"
    }
  }
  result
}

///|
///===
/// Subscription
pub struct Subscription {
  id : String
  subscriber : String
  event_types : Array[String]
  active : Bool
} derive(Debug, Eq)

///|
pub extend Subscription with Eq::{equal, not_equal}

///|
pub extend Subscription with Debug::{to_repr}

///|
/// 构造订阅 / Build subscription.
pub fn make_subscription(
  id : String,
  subscriber : String,
  event_types : Array[String],
) -> Subscription {
  { id, subscriber, event_types, active: true, }
}

///|
/// 订阅 / Subscribe.
pub fn subscribe(
  id : String,
  subscriber : String,
  event_types : Array[String],
) -> Subscription {
  make_subscription(id, subscriber, event_types)
}

///|
/// 取消订阅 / Unsubscribe.
pub fn unsubscribe(sub : Subscription) -> Subscription {
  {
    id: sub.id,
    subscriber: sub.subscriber,
    event_types: sub.event_types,
    active: false,
  }
}

///|
/// 通知 / Notify subscriber of event.
pub fn notify(sub : Subscription, event : Event) -> Bool {
  if !sub.active {
    return false
  }
  for i in 0..<sub.event_types.length() {
    if sub.event_types[i] == event.event_type {
      return true
    }
  }
  false
}

///===
/// event_order / causality / dependency

///|
/// 事件顺序 / Check event ordering.
pub fn event_order(e1 : Event, e2 : Event) -> Int32 {
  if e1.timestamp < e2.timestamp {
    -1
  } else if e1.timestamp > e2.timestamp {
    1
  } else {
    0
  }
}

///|
/// 事件因果 / Check event causality.
pub fn event_causality(e1 : Event, e2 : Event) -> Bool {
  e1.timestamp < e2.timestamp && e1.aggregate_id == e2.aggregate_id
}

///|
/// 事件依赖 / Check event dependency.
pub fn event_dependency(e1 : Event, e2 : Event) -> Bool {
  e1.version < e2.version && e1.aggregate_id == e2.aggregate_id
}

///|
///===
/// Saga
pub struct Saga {
  id : String
  steps : Array[String]
  compensations : Array[String]
  current_step : Int32
} derive(Debug, Eq)

///|
pub extend Saga with Eq::{equal, not_equal}

///|
pub extend Saga with Debug::{to_repr}

///|
/// 构造 Saga / Build saga.
pub fn make_saga(
  id : String,
  steps : Array[String],
  compensations : Array[String],
) -> Saga {
  { id, steps, compensations, current_step: 0, }
}

///|
/// Saga 执行 / Execute saga step.
pub fn saga_execute(saga : Saga) -> Saga {
  let next = es_min(saga.current_step + 1, saga.steps.length())
  {
    id: saga.id,
    steps: saga.steps,
    compensations: saga.compensations,
    current_step: next,
  }
}

///|
/// Saga 补偿 / Compensate saga.
pub fn saga_compensate(saga : Saga) -> Saga {
  let prev = es_max(saga.current_step - 1, 0)
  {
    id: saga.id,
    steps: saga.steps,
    compensations: saga.compensations,
    current_step: prev,
  }
}

///|
/// Saga 回滚 / Rollback saga fully.
pub fn saga_rollback(saga : Saga) -> Saga {
  {
    id: saga.id,
    steps: saga.steps,
    compensations: saga.compensations,
    current_step: 0,
  }
}

///|
///===
/// CQRS
pub struct Cqrs {
  command_store : EventStore
  query_projection : Projection
} derive(Debug, Eq)

///|
pub extend Cqrs with Eq::{equal, not_equal}

///|
pub extend Cqrs with Debug::{to_repr}

///|
/// 构造 CQRS / Build CQRS.
pub fn make_cqrs(
  command_store_id : String,
  query_projection_name : String,
) -> Cqrs {
  {
    command_store: make_event_store(command_store_id),
    query_projection: make_projection(query_projection_name),
  }
}

///|
/// CQRS 命令端 / CQRS command side.
pub fn cqrs_command_side(cqrs : Cqrs, cmd : Command, timestamp : Int32) -> Cqrs {
  if !command_validate(cmd) {
    return cqrs
  }
  let event = command_execute(cmd, timestamp)
  let store = store_event(cqrs.command_store, event)
  { command_store: store, query_projection: cqrs.query_projection, }
}

///|
/// CQRS 查询端 / CQRS query side.
pub fn cqrs_query_side(cqrs : Cqrs, aggregate_id : String) -> String {
  projection_query(cqrs.query_projection, aggregate_id)
}

///|
///===
/// EventVersion
pub struct EventVersion {
  major : Int32
  minor : Int32
  patch : Int32
} derive(Debug, Eq)

///|
pub extend EventVersion with Eq::{equal, not_equal}

///|
pub extend EventVersion with Debug::{to_repr}

///|
/// 构造事件版本 / Build event version.
pub fn make_event_version(
  major : Int32,
  minor : Int32,
  patch : Int32,
) -> EventVersion {
  { major, minor, patch, }
}

///|
/// 版本检查 / Check version compatibility.
pub fn version_check(v1 : EventVersion, v2 : EventVersion) -> Bool {
  v1.major == v2.major
}

///|
/// 版本升级 / Upgrade version.
pub fn version_upgrade(v : EventVersion) -> EventVersion {
  { major: v.major, minor: v.minor + 1, patch: 0, }
}

///===
/// dedup / idempotent / ordering

///|
/// 事件去重 / Deduplicate events.
pub fn event_dedup(events : Array[Event]) -> Array[Event] {
  let result : Array[Event] = []
  let seen : Array[String] = []
  for i in 0..<events.length() {
    let mut found = false
    for j in 0..<seen.length() {
      if seen[j] == events[i].id {
        found = true
        break
      }
    }
    if !found {
      seen.push(events[i].id)
      result.push(events[i])
    }
  }
  result
}

///|
/// 事件幂等 / Check event idempotency.
pub fn event_idempotent(events : Array[Event], event : Event) -> Bool {
  for i in 0..<events.length() {
    if events[i].id == event.id {
      return false
    }
  }
  true
}

///|
/// 事件排序 / Sort events by timestamp.
pub fn event_ordering(events : Array[Event]) -> Array[Event] {
  let result : Array[Event] = []
  for i in 0..<events.length() {
    result.push(events[i])
  }
  let n = result.length()
  for i in 0..<n {
    for j in 0..<(n - 1 - i) {
      if result[j].timestamp > result[j + 1].timestamp {
        let tmp = result[j]
        result[j] = result[j + 1]
        result[j + 1] = tmp
      }
    }
  }
  result
}

///|
///===
/// EventBus
pub struct EventBus {
  name : String
  subscribers : Array[Subscription]
} derive(Debug, Eq)

///|
pub extend EventBus with Eq::{equal, not_equal}

///|
pub extend EventBus with Debug::{to_repr}

///|
/// 构造事件总线 / Build event bus.
pub fn make_event_bus(name : String) -> EventBus {
  { name, subscribers: [], }
}

///|
/// 发布事件 / Publish event to bus.
pub fn publish_event(bus : EventBus, event : Event) -> Int32 {
  let mut count = 0
  for i in 0..<bus.subscribers.length() {
    if notify(bus.subscribers[i], event) {
      count = count + 1
    }
  }
  count
}

///|
/// 订阅事件 / Subscribe to event bus.
pub fn subscribe_event(bus : EventBus, sub : Subscription) -> EventBus {
  let subscribers : Array[Subscription] = []
  for i in 0..<bus.subscribers.length() {
    subscribers.push(bus.subscribers[i])
  }
  subscribers.push(sub)
  { name: bus.name, subscribers, }
}

///|
///===
/// DeadLetter
pub struct DeadLetter {
  queue : Array[Event]
  max_retries : Int32
} derive(Debug, Eq)

///|
pub extend DeadLetter with Eq::{equal, not_equal}

///|
pub extend DeadLetter with Debug::{to_repr}

///|
/// 构造死信 / Build dead letter queue.
pub fn make_dead_letter(max_retries : Int32) -> DeadLetter {
  { queue: [], max_retries, }
}

///|
/// 死信队列 / Add to dead letter queue.
pub fn dead_letter_queue(dl : DeadLetter, event : Event) -> DeadLetter {
  let queue : Array[Event] = []
  for i in 0..<dl.queue.length() {
    queue.push(dl.queue[i])
  }
  queue.push(event)
  { queue, max_retries: dl.max_retries, }
}

///|
/// 重试事件 / Retry event from dead letter.
pub fn retry_event(dl : DeadLetter, retries : Int32) -> Bool {
  retries < dl.max_retries
}

///===
/// replay_from / replay_to / replay_range

///|
/// 从时间点重放 / Replay events from timestamp.
pub fn event_replay_from(
  events : Array[Event],
  from_ts : Int32,
) -> Array[Event] {
  let result : Array[Event] = []
  for i in 0..<events.length() {
    if events[i].timestamp >= from_ts {
      result.push(events[i])
    }
  }
  result
}

///|
/// 重放到时间点 / Replay events to timestamp.
pub fn event_replay_to(events : Array[Event], to_ts : Int32) -> Array[Event] {
  let result : Array[Event] = []
  for i in 0..<events.length() {
    if events[i].timestamp <= to_ts {
      result.push(events[i])
    }
  }
  result
}

///|
/// 范围重放 / Replay events in time range.
pub fn event_replay_range(
  events : Array[Event],
  from_ts : Int32,
  to_ts : Int32,
) -> Array[Event] {
  let result : Array[Event] = []
  for i in 0..<events.length() {
    if events[i].timestamp >= from_ts && events[i].timestamp <= to_ts {
      result.push(events[i])
    }
  }
  result
}

///===
/// aggregate_id / event_id_gen / correlation_id

///|
/// 聚合 ID 生成 / Generate aggregate id.
pub fn aggregate_id(prefix : String, seq : Int32) -> String {
  prefix + "-agg-" + seq.to_string()
}

///|
/// 事件 ID 生成 / Generate event id.
pub fn event_id_gen(prefix : String, seq : Int32) -> String {
  prefix + "-evt-" + seq.to_string()
}

///|
/// 关联 ID 生成 / Generate correlation id.
pub fn correlation_id(prefix : String, seq : Int32) -> String {
  prefix + "-corr-" + seq.to_string()
}

///===
/// 批量操作 / Batch operations

///|
/// 批量存储事件 / Batch store events.
pub fn event_batch_store(
  store : EventStore,
  events : Array[Event],
) -> EventStore {
  let mut s = store
  for i in 0..<events.length() {
    s = store_event(s, events[i])
  }
  s
}

///|
/// 批量加载事件 / Batch load events.
pub fn event_batch_load(
  store : EventStore,
  aggregate_ids : Array[String],
) -> Array[Event] {
  let result : Array[Event] = []
  for i in 0..<aggregate_ids.length() {
    let events = load_events(store, aggregate_ids[i])
    for j in 0..<events.length() {
      result.push(events[j])
    }
  }
  result
}

///|
/// 按类型过滤事件 / Filter events by type.
pub fn event_filter_by_type(
  events : Array[Event],
  event_type : String,
) -> Array[Event] {
  let result : Array[Event] = []
  for i in 0..<events.length() {
    if events[i].event_type == event_type {
      result.push(events[i])
    }
  }
  result
}

///|
/// 按类型统计事件 / Count events by type.
pub fn event_count_by_type(events : Array[Event], event_type : String) -> Int32 {
  let mut count = 0
  for i in 0..<events.length() {
    if events[i].event_type == event_type {
      count = count + 1
    }
  }
  count
}

///|
/// 事件时间范围 / Event timestamp range.
pub fn event_timestamp_range(events : Array[Event]) -> (Int32, Int32) {
  if events.length() == 0 {
    return (0, 0)
  }
  let mut min_ts = events[0].timestamp
  let mut max_ts = events[0].timestamp
  for i in 1..<events.length() {
    if events[i].timestamp < min_ts {
      min_ts = events[i].timestamp
    }
    if events[i].timestamp > max_ts {
      max_ts = events[i].timestamp
    }
  }
  (min_ts, max_ts)
}

///|
/// 聚合版本 / Get aggregate version from events.
pub fn event_aggregate_version(
  events : Array[Event],
  aggregate_id : String,
) -> Int32 {
  let mut max_version = 0
  for i in 0..<events.length() {
    if events[i].aggregate_id == aggregate_id && events[i].version > max_version {
      max_version = events[i].version
    }
  }
  max_version
}

///===
/// 快照重放 / Snapshot replay

///|
/// 快照重放 / Replay from snapshot.
pub fn snapshot_replay(snap : Snapshot, events : Array[Event]) -> Aggregate {
  let mut agg = snapshot_load(snap)
  for i in 0..<events.length() {
    if events[i].aggregate_id == snap.aggregate_id &&
      events[i].version > snap.version {
      agg = aggregate_apply(agg, events[i])
    }
  }
  agg
}

///|
/// 投影重建 / Rebuild projection from events.
pub fn projection_rebuild(
  proj : Projection,
  events : Array[Event],
) -> Projection {
  let mut p = proj
  for i in 0..<events.length() {
    p = projection_apply(p, events[i])
  }
  p
}

///|
/// 订阅计数 / Count active subscriptions.
pub fn subscription_count(subscriptions : Array[Subscription]) -> Int32 {
  let mut count = 0
  for i in 0..<subscriptions.length() {
    if subscriptions[i].active {
      count = count + 1
    }
  }
  count
}

///|
/// Saga 状态 / Get saga status.
pub fn saga_status(saga : Saga) -> String {
  if saga.current_step == 0 {
    "pending"
  } else if saga.current_step >= saga.steps.length() {
    "completed"
  } else {
    "in_progress"
  }
}

///|
/// CQRS 同步 / Sync command side to query side.
pub fn cqrs_sync(cqrs : Cqrs) -> Cqrs {
  let events = load_events(cqrs.command_store, "")
  let mut proj = cqrs.query_projection
  for i in 0..<events.length() {
    proj = projection_apply(proj, events[i])
  }
  { command_store: cqrs.command_store, query_projection: proj, }
}

///|
/// 版本比较 / Compare versions.
pub fn version_compare(v1 : EventVersion, v2 : EventVersion) -> Int32 {
  if v1.major != v2.major {
    return if v1.major > v2.major { 1 } else { -1 }
  }
  if v1.minor != v2.minor {
    return if v1.minor > v2.minor { 1 } else { -1 }
  }
  if v1.patch != v2.patch {
    return if v1.patch > v2.patch { 1 } else { -1 }
  }
  0
}

///===
/// 存储管理 / Store management

///|
/// 事件存储大小 / Event store size.
pub fn event_store_size(store : EventStore) -> Int32 {
  store.events.length()
}

///|
/// 事件存储清空 / Clear event store.
pub fn event_store_clear(store : EventStore) -> EventStore {
  { id: store.id, events: [], next_version: 1, }
}

///|
/// 事件压缩 / Compact events (remove duplicates).
pub fn event_compact(store : EventStore) -> EventStore {
  let compacted = event_dedup(store.events)
  { id: store.id, events: compacted, next_version: store.next_version, }
}

///|
/// 事件 TTL 检查 / Check event TTL.
pub fn event_ttl_check(
  events : Array[Event],
  current_time : Int32,
  ttl_ms : Int32,
) -> Array[Event] {
  let result : Array[Event] = []
  for i in 0..<events.length() {
    if current_time - events[i].timestamp <= ttl_ms {
      result.push(events[i])
    }
  }
  result
}

///|
/// 事件归档 / Archive old events.
pub fn event_archive(
  events : Array[Event],
  archive_before : Int32,
) -> (Array[Event], Array[Event]) {
  let active : Array[Event] = []
  let archived : Array[Event] = []
  for i in 0..<events.length() {
    if events[i].timestamp < archive_before {
      archived.push(events[i])
    } else {
      active.push(events[i])
    }
  }
  (active, archived)
}

///|
/// 事件恢复 / Restore archived events.
pub fn event_restore(
  active : Array[Event],
  archived : Array[Event],
) -> Array[Event] {
  let result : Array[Event] = []
  for i in 0..<active.length() {
    result.push(active[i])
  }
  for i in 0..<archived.length() {
    result.push(archived[i])
  }
  event_ordering(result)
}

///|
/// 事件批量大小 / Compute optimal batch size.
pub fn event_batch_size(total_events : Int32, max_batch : Int32) -> Int32 {
  if total_events <= 0 || max_batch <= 0 {
    return 0
  }
  let batches = (total_events + max_batch - 1) / max_batch
  if batches == 0 {
    max_batch
  } else {
    total_events / batches
  }
}

///|
/// 事件存储合并 / Merge two event stores.
pub fn event_store_merge(
  store1 : EventStore,
  store2 : EventStore,
) -> EventStore {
  let events : Array[Event] = []
  for i in 0..<store1.events.length() {
    events.push(store1.events[i])
  }
  for i in 0..<store2.events.length() {
    events.push(store2.events[i])
  }
  let merged = event_ordering(events)
  {
    id: store1.id,
    events: merged,
    next_version: store1.next_version + store2.next_version,
  }
}

///===
/// ID

///|
/// 事件溯源模块 ID / Event sourcing module id.
pub fn event_sourcing_id() -> String {
  "datatemporal/event_sourcing"
}
