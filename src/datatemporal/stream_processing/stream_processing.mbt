///|
/// # datatemporal/stream_processing 流处理 / Stream Processing
///
/// 流处理引擎：DAG、连接器、算子、窗口、连接、聚合、状态、触发器、水位线、检查点、精确一次、监控、模式注册。
/// S11.8 新建。
///
/// # Stream processing

/// 流处理状态 / Stream processing status.
pub(all) enum ProcStatus {
  ProcIdle
  ProcRunning
  ProcStopped
  ProcFailed
}

/// DAG 节点 / DAG node.
pub struct DagNode {
  id : String
  op_type : String
}

/// DAG 边 / DAG edge.
pub struct DagEdge {
  from : String
  to : String
}

/// 流 DAG / Stream DAG.
pub struct StreamDag {
  nodes : Array[DagNode]
  edges : Array[DagEdge]
}

/// 流处理 / Stream processor.
pub struct StreamProc {
  name : String
  status : ProcStatus
  dag : StreamDag
}

/// 流事件 / Stream event.
pub struct StreamEvent {
  key : String
  value : Double
  timestamp : Double
}

/// 构造流 DAG / Create stream DAG.
pub fn make_stream_dag() -> StreamDag {
  { nodes: [], edges: [] }
}

/// 添加节点 / Add node.
pub fn dag_add_node(dag : StreamDag, node : DagNode) -> StreamDag {
  let new_nodes = dag.nodes.copy()
  new_nodes.push(node)
  { ..dag, nodes: new_nodes }
}

/// 添加边 / Add edge.
pub fn dag_add_edge(dag : StreamDag, edge : DagEdge) -> StreamDag {
  let new_edges = dag.edges.copy()
  new_edges.push(edge)
  { ..dag, edges: new_edges }
}

/// 验证 DAG / Validate DAG.
pub fn dag_validate(dag : StreamDag) -> Bool {
  let mut ok = true
  for i in 0..<dag.edges.length() {
    let e = dag.edges[i]
    let mut from_found = false
    let mut to_found = false
    for j in 0..<dag.nodes.length() {
      if dag.nodes[j].id == e.from {
        from_found = true
      }
      if dag.nodes[j].id == e.to {
        to_found = true
      }
    }
    if !(from_found) || !(to_found) {
      ok = false
    }
  }
  ok
}

/// 构造流处理 / Create stream processor.
pub fn make_stream_proc(name : String, dag : StreamDag) -> StreamProc {
  { name: name, status: ProcIdle, dag: dag }
}

/// 启动 / Start.
pub fn proc_start(proc : StreamProc) -> StreamProc {
  { ..proc, status: ProcRunning }
}

/// 停止 / Stop.
pub fn proc_stop(proc : StreamProc) -> StreamProc {
  { ..proc, status: ProcStopped }
}

/// 状态 / Status.
pub fn proc_status(proc : StreamProc) -> ProcStatus {
  proc.status
}

///===
/// 源连接器 / Source connector

/// 源连接器 / Source connector.
pub struct SourceConnector {
  id : String
  source_type : String
  connected : Bool
}

/// 构造源连接器 / Create source connector.
pub fn make_source_connector(id : String, source_type : String) -> SourceConnector {
  { id: id, source_type: source_type, connected: false }
}

/// 连接源 / Connect source.
pub fn source_connect(conn : SourceConnector) -> SourceConnector {
  { ..conn, connected: true }
}

/// 读取源 / Read source.
pub fn source_read(conn : SourceConnector, events : Array[StreamEvent]) -> Array[StreamEvent] {
  if !(conn.connected) {
    []
  } else {
    events
  }
}

/// 关闭源 / Close source.
pub fn source_close(conn : SourceConnector) -> SourceConnector {
  { ..conn, connected: false }
}

///===
/// 汇连接器 / Sink connector

/// 汇连接器 / Sink connector.
pub struct SinkConnector {
  id : String
  sink_type : String
  connected : Bool
  written : Int
}

/// 构造汇连接器 / Create sink connector.
pub fn make_sink_connector(id : String, sink_type : String) -> SinkConnector {
  { id: id, sink_type: sink_type, connected: false, written: 0 }
}

/// 连接汇 / Connect sink.
pub fn sink_connect(conn : SinkConnector) -> SinkConnector {
  { ..conn, connected: true }
}

/// 写入汇 / Write sink.
pub fn sink_write(conn : SinkConnector, events : Array[StreamEvent]) -> SinkConnector {
  if !(conn.connected) {
    conn
  } else {
    { ..conn, written: conn.written + events.length() }
  }
}

/// 关闭汇 / Close sink.
pub fn sink_close(conn : SinkConnector) -> SinkConnector {
  { ..conn, connected: false }
}

///===
/// 转换算子 / Transform operator

/// 转换算子 / Transform operator.
pub struct TransformOp {
  op_type : String
}

/// 构造转换算子 / Create transform op.
pub fn make_transform_op(op_type : String) -> TransformOp {
  { op_type: op_type }
}

/// Map 转换 / Map transform.
pub fn transform_map(events : Array[StreamEvent], f : (StreamEvent) -> StreamEvent) -> Array[StreamEvent] {
  let result : Array[StreamEvent] = []
  for i in 0..<events.length() {
    result.push(f(events[i]))
  }
  result
}

/// Filter 转换 / Filter transform.
pub fn transform_filter(events : Array[StreamEvent], pred : (StreamEvent) -> Bool) -> Array[StreamEvent] {
  let result : Array[StreamEvent] = []
  for i in 0..<events.length() {
    if pred(events[i]) {
      result.push(events[i])
    }
  }
  result
}

/// Reduce 转换 / Reduce transform.
pub fn transform_reduce(events : Array[StreamEvent], init : Double, f : (Double, StreamEvent) -> Double) -> Double {
  let mut acc = init
  for i in 0..<events.length() {
    acc = f(acc, events[i])
  }
  acc
}

///===
/// 窗口算子 / Window operator

/// 窗口算子 / Window operator.
pub struct WindowOp {
  window_type : String
  size : Double
  slide : Double
}

/// 构造窗口算子 / Create window op.
pub fn make_window_op(window_type : String, size : Double, slide : Double) -> WindowOp {
  { window_type: window_type, size: size, slide: slide }
}

/// 滚动窗口 / Tumbling window.
pub fn window_tumbling_sp(events : Array[StreamEvent], size : Double) -> Array[Array[StreamEvent]] {
  if events.length() == 0 || size <= 0.0 {
    return []
  }
  let sorted = events.copy()
  sorted.sort_by(fn(a, b) { a.timestamp.compare(b.timestamp) })
  let result : Array[Array[StreamEvent]] = []
  let mut i = 0
  while i < sorted.length() {
    let window_start = sorted[i].timestamp
    let window_end = window_start + size
    let batch : Array[StreamEvent] = []
    while i < sorted.length() && sorted[i].timestamp < window_end {
      batch.push(sorted[i])
      i = i + 1
    }
    result.push(batch)
  }
  result
}

/// 滑动窗口 / Sliding window.
pub fn window_sliding_sp(events : Array[StreamEvent], size : Double, slide : Double) -> Array[Array[StreamEvent]] {
  if events.length() == 0 || size <= 0.0 || slide <= 0.0 {
    return []
  }
  let sorted = events.copy()
  sorted.sort_by(fn(a, b) { a.timestamp.compare(b.timestamp) })
  let result : Array[Array[StreamEvent]] = []
  let last_ts = sorted[sorted.length() - 1].timestamp
  let mut window_start = sorted[0].timestamp
  while window_start < last_ts {
    let window_end = window_start + size
    let batch : Array[StreamEvent] = []
    for idx in 0..<sorted.length() {
      if sorted[idx].timestamp >= window_start && sorted[idx].timestamp < window_end {
        batch.push(sorted[idx])
      }
    }
    result.push(batch)
    window_start = window_start + slide
  }
  result
}

/// 会话窗口 / Session window.
pub fn window_session_sp(events : Array[StreamEvent], gap : Double) -> Array[Array[StreamEvent]] {
  if events.length() == 0 {
    return []
  }
  let sorted = events.copy()
  sorted.sort_by(fn(a, b) { a.timestamp.compare(b.timestamp) })
  let result : Array[Array[StreamEvent]] = []
  let mut batch : Array[StreamEvent] = [sorted[0]]
  for i in 1..<sorted.length() {
    if sorted[i].timestamp - sorted[i - 1].timestamp <= gap {
      batch.push(sorted[i])
    } else {
      result.push(batch)
      batch = [sorted[i]]
    }
  }
  result.push(batch)
  result
}

///===
/// 连接算子 / Join operator

/// 连接算子 / Join operator.
pub struct JoinOp {
  join_type : String
  key : String
}

/// 构造连接算子 / Create join op.
pub fn make_join_op(join_type : String, key : String) -> JoinOp {
  { join_type: join_type, key: key }
}

/// 内连接 / Inner join.
pub fn join_inner(left : Array[StreamEvent], right : Array[StreamEvent]) -> Array[(StreamEvent, StreamEvent)] {
  let result : Array[(StreamEvent, StreamEvent)] = []
  for i in 0..<left.length() {
    for j in 0..<right.length() {
      if left[i].key == right[j].key {
        result.push((left[i], right[j]))
      }
    }
  }
  result
}

/// 外连接 / Outer join.
pub fn join_outer(left : Array[StreamEvent], right : Array[StreamEvent]) -> Array[(StreamEvent?, StreamEvent?)] {
  let result : Array[(StreamEvent?, StreamEvent?)] = []
  let right_matched : Array[Bool] = []
  for _ in 0..<right.length() {
    right_matched.push(false)
  }
  for i in 0..<left.length() {
    let mut matched = false
    for j in 0..<right.length() {
      if left[i].key == right[j].key {
        result.push((Some(left[i]), Some(right[j])))
        right_matched[j] = true
        matched = true
      }
    }
    if !(matched) {
      result.push((Some(left[i]), None))
    }
  }
  for j in 0..<right.length() {
    if !(right_matched[j]) {
      result.push((None, Some(right[j])))
    }
  }
  result
}

/// 时态连接 / Temporal join.
pub fn join_temporal(left : Array[StreamEvent], right : Array[StreamEvent], window : Double) -> Array[(StreamEvent, StreamEvent)] {
  let result : Array[(StreamEvent, StreamEvent)] = []
  for i in 0..<left.length() {
    for j in 0..<right.length() {
      if left[i].key == right[j].key && (left[i].timestamp - right[j].timestamp).abs() <= window {
        result.push((left[i], right[j]))
      }
    }
  }
  result
}

///===
/// 聚合算子 / Aggregation operator

/// 聚合算子 / Aggregation operator.
pub struct AggregationOp {
  agg_type : String
}

/// 构造聚合算子 / Create aggregation op.
pub fn make_aggregation_op(agg_type : String) -> AggregationOp {
  { agg_type: agg_type }
}

/// 求和聚合 / Sum aggregation.
pub fn agg_sum_sp(events : Array[StreamEvent]) -> Double {
  let mut sum = 0.0
  for i in 0..<events.length() {
    sum = sum + events[i].value
  }
  sum
}

/// 计数聚合 / Count aggregation.
pub fn agg_count_sp(events : Array[StreamEvent]) -> Int {
  events.length()
}

/// 平均聚合 / Average aggregation.
pub fn agg_avg_sp(events : Array[StreamEvent]) -> Double {
  let n = events.length()
  if n == 0 {
    0.0
  } else {
    agg_sum_sp(events) / n.to_double()
  }
}

///===
/// 有状态算子 / Stateful operator

/// 有状态算子 / Stateful operator.
pub struct StatefulOp {
  state : Array[(String, Double)]
}

/// 构造有状态算子 / Create stateful op.
pub fn make_stateful_op() -> StatefulOp {
  { state: [] }
}

/// 状态更新 / Update state.
pub fn state_update(op : StatefulOp, key : String, value : Double) -> StatefulOp {
  let new_state : Array[(String, Double)] = []
  let mut found = false
  for i in 0..<op.state.length() {
    if op.state[i].0 == key {
      new_state.push((key, value))
      found = true
    } else {
      new_state.push(op.state[i])
    }
  }
  if !(found) {
    new_state.push((key, value))
  }
  { state: new_state }
}

/// 状态查询 / Query state.
pub fn state_query(op : StatefulOp, key : String) -> Double? {
  let mut result : Double? = None
  for i in 0..<op.state.length() {
    if op.state[i].0 == key {
      result = Some(op.state[i].1)
    }
  }
  result
}

/// 状态快照 / State snapshot.
pub fn state_snapshot(op : StatefulOp) -> Array[(String, Double)] {
  op.state.copy()
}

///===
/// 触发器 / Trigger

/// 触发器类型 / Trigger type.
pub(all) enum TriggerType {
  TriggerEvent
  TriggerTime
  TriggerCount
}

/// 触发器 / Trigger.
pub struct Trigger {
  trigger_type : TriggerType
  threshold : Double
  fired : Bool
}

/// 构造触发器 / Create trigger.
pub fn make_trigger(trigger_type : TriggerType, threshold : Double) -> Trigger {
  { trigger_type: trigger_type, threshold: threshold, fired: false }
}

/// 事件触发 / Event trigger.
pub fn trigger_event(trigger : Trigger, events : Array[StreamEvent]) -> Trigger {
  if events.length().to_double() >= trigger.threshold {
    { ..trigger, fired: true }
  } else {
    { ..trigger, fired: false }
  }
}

/// 时间触发 / Time trigger.
pub fn trigger_time(trigger : Trigger, current_time : Double, last_fire : Double) -> Trigger {
  if current_time - last_fire >= trigger.threshold {
    { ..trigger, fired: true }
  } else {
    { ..trigger, fired: false }
  }
}

/// 计数触发 / Count trigger.
pub fn trigger_count(trigger : Trigger, count : Int) -> Trigger {
  if count.to_double() >= trigger.threshold {
    { ..trigger, fired: true }
  } else {
    { ..trigger, fired: false }
  }
}

///===
/// 水位线 / Watermark

/// 水位线 / Watermark.
pub struct EWatermark {
  timestamp : Double
  max_out_of_order : Double
}

/// 构造水位线 / Create watermark.
pub fn make_ewatermark(timestamp : Double, max_out_of_order : Double) -> EWatermark {
  { timestamp: timestamp, max_out_of_order: max_out_of_order }
}

/// 发射水位线 / Emit watermark.
pub fn watermark_emit(wm : EWatermark, event_time : Double) -> EWatermark {
  let new_ts = event_time - wm.max_out_of_order
  if new_ts > wm.timestamp {
    { ..wm, timestamp: new_ts }
  } else {
    wm
  }
}

/// 推进水位线 / Advance watermark.
pub fn watermark_advance(wm : EWatermark, new_timestamp : Double) -> EWatermark {
  if new_timestamp > wm.timestamp {
    { ..wm, timestamp: new_timestamp }
  } else {
    wm
  }
}

///===
/// 检查点 / Checkpoint

/// 检查点 / Checkpoint.
pub struct CheckpointSp {
  id : Int
  state : Array[(String, Double)]
  timestamp : Double
}

/// 构造检查点 / Create checkpoint.
pub fn make_checkpoint_sp(id : Int, state : Array[(String, Double)], timestamp : Double) -> CheckpointSp {
  { id: id, state: state, timestamp: timestamp }
}

/// 保存检查点 / Save checkpoint.
pub fn checkpoint_save_sp(op : StatefulOp, id : Int, timestamp : Double) -> CheckpointSp {
  { id: id, state: op.state.copy(), timestamp: timestamp }
}

/// 恢复检查点 / Restore checkpoint.
pub fn checkpoint_restore_sp(cp : CheckpointSp) -> StatefulOp {
  { state: cp.state.copy() }
}

///===
/// 精确一次 / Exactly once

/// 精确一次 / Exactly once.
pub struct ExactlyOnceSp {
  processed_ids : Array[String]
}

/// 构造精确一次 / Create exactly once.
pub fn make_exactly_once_sp() -> ExactlyOnceSp {
  { processed_ids: [] }
}

/// 精确一次处理 / Exactly once process.
pub fn exactly_once_process_sp(eo : ExactlyOnceSp, event : StreamEvent) -> (ExactlyOnceSp, Bool) {
  let mut dup = false
  for i in 0..<eo.processed_ids.length() {
    if eo.processed_ids[i] == event.key {
      dup = true
    }
  }
  if dup {
    (eo, false)
  } else {
    let new_ids = eo.processed_ids.copy()
    new_ids.push(event.key)
    ({ processed_ids: new_ids }, true)
  }
}

/// 去重 / Dedup.
pub fn dedup_sp(events : Array[StreamEvent]) -> Array[StreamEvent] {
  let result : Array[StreamEvent] = []
  for i in 0..<events.length() {
    let mut dup = false
    for j in 0..<result.length() {
      if result[j].key == events[i].key {
        dup = true
      }
    }
    if !(dup) {
      result.push(events[i])
    }
  }
  result
}

///===
/// 监控 / Monitoring

/// 流监控 / Stream monitor.
pub struct StreamMonitor {
  events_processed : Int
  errors : Int
  last_event_time : Double
}

/// 流指标 / Stream metrics.
pub struct StreamMetrics {
  throughput : Double
  error_rate : Double
  latency : Double
}

/// 流告警 / Stream alert.
pub struct StreamAlert {
  alert_type : String
  message : String
  severity : Double
}

/// 监控 / Monitor.
pub fn stream_monitor_sp(events : Array[StreamEvent], errors : Int) -> StreamMonitor {
  let mut last_time = 0.0
  for i in 0..<events.length() {
    if events[i].timestamp > last_time {
      last_time = events[i].timestamp
    }
  }
  { events_processed: events.length(), errors: errors, last_event_time: last_time }
}

/// 指标 / Metrics.
pub fn stream_metrics_sp(monitor : StreamMonitor, time_window : Double) -> StreamMetrics {
  let throughput = if time_window > 0.0 { monitor.events_processed.to_double() / time_window } else { 0.0 }
  let total = monitor.events_processed + monitor.errors
  let error_rate = if total == 0 { 0.0 } else { monitor.errors.to_double() / total.to_double() }
  { throughput: throughput, error_rate: error_rate, latency: time_window }
}

/// 告警 / Alert.
pub fn stream_alert_sp(metrics : StreamMetrics, error_threshold : Double, throughput_min : Double) -> StreamAlert? {
  if metrics.error_rate > error_threshold {
    Some({ alert_type: "error_rate", message: "Error rate exceeds threshold", severity: metrics.error_rate })
  } else if metrics.throughput < throughput_min {
    let sev = 1.0 - metrics.throughput / throughput_min
    Some({ alert_type: "low_throughput", message: "Throughput below minimum", severity: sev })
  } else {
    None
  }
}

///===
/// 模式注册 / Schema registry

/// 模式 / Schema.
pub struct SchemaSp {
  id : String
  fields : Array[String]
}

/// 模式注册表 / Schema registry.
pub struct SchemaRegistry {
  schemas : Array[SchemaSp]
}

/// 构造模式注册表 / Create schema registry.
pub fn make_schema_registry() -> SchemaRegistry {
  { schemas: [] }
}

/// 注册模式 / Register schema.
pub fn schema_register_sp(registry : SchemaRegistry, schema : SchemaSp) -> SchemaRegistry {
  let new_schemas = registry.schemas.copy()
  new_schemas.push(schema)
  { ..registry, schemas: new_schemas }
}

/// 验证模式 / Validate schema.
pub fn schema_validate_sp(registry : SchemaRegistry, schema_id : String, fields : Array[String]) -> Bool {
  let mut ok = false
  for i in 0..<registry.schemas.length() {
    if registry.schemas[i].id == schema_id {
      ok = true
      let expected = registry.schemas[i].fields
      if expected.length() != fields.length() {
        ok = false
      } else {
        for j in 0..<expected.length() {
          if expected[j] != fields[j] {
            ok = false
          }
        }
      }
    }
  }
  ok
}

///===
/// ID

pub fn stream_processing_id() -> String {
  "datatemporal/stream_processing"
}