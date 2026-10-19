///|
/// # dataobject/streaming 流处理 / Stream Processing
///
/// 流式数据处理的算子集合：source/sink、map/filter/reduce、window/join、
/// watermark、checkpoint、backpressure、buffer、serialize、kafka/file source、
/// rate limiter、monitor、exactly-once。
///
/// # Stream processing operators

///===
/// 内部数学辅助 / Internal math helpers

fn st_sqrt(x : Double) -> Double {
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

fn st_abs(x : Double) -> Double {
  if x < 0.0 {
    -x
  } else {
    x
  }
}

fn st_max(a : Double, b : Double) -> Double {
  if a > b {
    a
  } else {
    b
  }
}

fn st_min(a : Double, b : Double) -> Double {
  if a < b {
    a
  } else {
    b
  }
}

fn st_mean(arr : Array[Double]) -> Double {
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
/// StreamConfig

pub struct StreamConfig {
  name : String
  parallelism : Int
  buffer_size : Int
  timeout_ms : Int
  watermark_interval : Int
  checkpoint_interval : Int
} derive(Debug, Eq)

pub extend StreamConfig with Eq::{equal, not_equal}
pub extend StreamConfig with Debug::{to_repr}

/// 构造流配置 / Build stream config.
pub fn make_stream_config(
  name : String,
  parallelism : Int,
  buffer_size : Int
) -> StreamConfig {
  {
    name,
    parallelism,
    buffer_size,
    timeout_ms: 30000,
    watermark_interval: 1000,
    checkpoint_interval: 60000,
  }
}

///===
/// StreamProcessor

pub struct StreamProcessor {
  config : StreamConfig
  source_id : String
  sink_id : String
  active : Bool
} derive(Debug, Eq)

pub extend StreamProcessor with Eq::{equal, not_equal}
pub extend StreamProcessor with Debug::{to_repr}

/// 构造流处理器 / Build stream processor.
pub fn make_stream_processor(
  config : StreamConfig,
  source_id : String,
  sink_id : String
) -> StreamProcessor {
  { config, source_id, sink_id, active: true }
}

/// 处理流 / Process a stream of values.
pub fn process_stream(
  processor : StreamProcessor,
  data : Array[Double]
) -> Array[Double] {
  if not(processor.active) {
    return []
  }
  let result : Array[Double] = []
  let n = data.length()
  let p = processor.config.parallelism
  if p <= 0 {
    return data
  }
  for i in 0..<n {
    result.push(data[i] * p.to_double() / p.to_double())
  }
  result
}

///===
/// StreamSource / StreamSink

pub struct StreamSource {
  id : String
  source_type : String
  rate_per_sec : Double
} derive(Debug, Eq)

pub extend StreamSource with Eq::{equal, not_equal}
pub extend StreamSource with Debug::{to_repr}

pub struct StreamSink {
  id : String
  sink_type : String
  capacity : Int
} derive(Debug, Eq)

pub extend StreamSink with Eq::{equal, not_equal}
pub extend StreamSink with Debug::{to_repr}

/// 构造流源 / Build stream source.
pub fn make_stream_source(
  id : String,
  source_type : String,
  rate_per_sec : Double
) -> StreamSource {
  { id, source_type, rate_per_sec }
}

/// 构造流汇 / Build stream sink.
pub fn make_stream_sink(
  id : String,
  sink_type : String,
  capacity : Int
) -> StreamSink {
  { id, sink_type, capacity }
}

/// 连接源到汇 / Connect source to sink.
pub fn stream_connect(
  source : StreamSource,
  sink : StreamSink
) -> String {
  source.id + "->" + sink.id
}

///===
/// map / filter / reduce / aggregate

/// 流映射 / Map over stream.
pub fn stream_map(
  data : Array[Double],
  f : (Double) -> Double
) -> Array[Double] {
  let result : Array[Double] = []
  for i in 0..<data.length() {
    result.push(f(data[i]))
  }
  result
}

/// 流过滤 / Filter stream.
pub fn stream_filter(
  data : Array[Double],
  pred : (Double) -> Bool
) -> Array[Double] {
  let result : Array[Double] = []
  for i in 0..<data.length() {
    if pred(data[i]) {
      result.push(data[i])
    }
  }
  result
}

/// 流归约 / Reduce stream.
pub fn stream_reduce(
  data : Array[Double],
  init : Double,
  op : (Double, Double) -> Double
) -> Double {
  let mut acc = init
  for i in 0..<data.length() {
    acc = op(acc, data[i])
  }
  acc
}

/// 流聚合 / Aggregate stream by window.
pub fn stream_aggregate(
  data : Array[Double],
  window : Int
) -> Array[Double] {
  let n = data.length()
  if n == 0 || window <= 0 {
    return []
  }
  let result : Array[Double] = []
  let mut i = 0
  while i < n {
    let mut sum = 0.0
    let mut cnt = 0
    let end = if i + window < n { i + window } else { n }
    for j in i..<end {
      sum = sum + data[j]
      cnt = cnt + 1
    }
    if cnt > 0 {
      result.push(sum / cnt.to_double())
    }
    i = i + window
  }
  result
}

///===
/// window / join / merge / split

/// 流窗口 / Window stream.
pub fn stream_window(
  data : Array[Double],
  size : Int,
  slide : Int
) -> Array[Array[Double]] {
  let n = data.length()
  if n == 0 || size <= 0 || slide <= 0 {
    return []
  }
  let result : Array[Array[Double]] = []
  let mut start = 0
  while start < n {
    let win : Array[Double] = []
    let end = if start + size < n { start + size } else { n }
    for j in start..<end {
      win.push(data[j])
    }
    result.push(win)
    start = start + slide
  }
  result
}

/// 流连接 / Join two streams by index.
pub fn stream_join(
  left : Array[Double],
  right : Array[Double]
) -> Array[Double] {
  let n = if left.length() < right.length() {
    left.length()
  } else {
    right.length()
  }
  let result : Array[Double] = []
  for i in 0..<n {
    result.push(left[i] + right[i])
  }
  result
}

/// 流合并 / Merge two sorted streams.
pub fn stream_merge(
  left : Array[Double],
  right : Array[Double]
) -> Array[Double] {
  let result : Array[Double] = []
  let mut i = 0
  let mut j = 0
  let nl = left.length()
  let nr = right.length()
  while i < nl && j < nr {
    if left[i] <= right[j] {
      result.push(left[i])
      i = i + 1
    } else {
      result.push(right[j])
      j = j + 1
    }
  }
  while i < nl {
    result.push(left[i])
    i = i + 1
  }
  while j < nr {
    result.push(right[j])
    j = j + 1
  }
  result
}

/// 流拆分 / Split stream by predicate.
pub fn stream_split(
  data : Array[Double],
  pred : (Double) -> Bool
) -> (Array[Double], Array[Double]) {
  let yes : Array[Double] = []
  let no : Array[Double] = []
  for i in 0..<data.length() {
    if pred(data[i]) {
      yes.push(data[i])
    } else {
      no.push(data[i])
    }
  }
  (yes, no)
}

///===
/// batch / unbatch / flatten

/// 流批处理 / Batch stream into chunks.
pub fn stream_batch(
  data : Array[Double],
  batch_size : Int
) -> Array[Array[Double]] {
  let n = data.length()
  if n == 0 || batch_size <= 0 {
    return []
  }
  let result : Array[Array[Double]] = []
  let mut i = 0
  while i < n {
    let batch : Array[Double] = []
    let end = if i + batch_size < n { i + batch_size } else { n }
    for j in i..<end {
      batch.push(data[j])
    }
    result.push(batch)
    i = i + batch_size
  }
  result
}

/// 流反批处理 / Unbatch chunks into flat stream.
pub fn stream_unbatch(batches : Array[Array[Double]]) -> Array[Double] {
  let result : Array[Double] = []
  for i in 0..<batches.length() {
    let b = batches[i]
    for j in 0..<b.length() {
      result.push(b[j])
    }
  }
  result
}

/// 流展平 / Flatten nested stream.
pub fn stream_flatten(nested : Array[Array[Double]]) -> Array[Double] {
  stream_unbatch(nested)
}

///===
/// Watermark

pub struct Watermark {
  timestamp : Int
  max_out_of_orderness : Int
} derive(Debug, Eq)

pub extend Watermark with Eq::{equal, not_equal}
pub extend Watermark with Debug::{to_repr}

/// 构造水位线 / Build watermark.
pub fn make_watermark(
  timestamp : Int,
  max_out_of_orderness : Int
) -> Watermark {
  { timestamp, max_out_of_orderness }
}

/// 跟踪水位线 / Track watermark with new event time.
pub fn watermark_track(
  wm : Watermark,
  event_time : Int
) -> Watermark {
  let new_ts = if event_time > wm.timestamp {
    event_time
  } else {
    wm.timestamp
  }
  { timestamp: new_ts, max_out_of_orderness: wm.max_out_of_orderness }
}

/// 水位线延迟 / Watermark delay.
pub fn watermark_delay(wm : Watermark) -> Int {
  wm.timestamp - wm.max_out_of_orderness
}

///===
/// Checkpoint

pub struct Checkpoint {
  id : String
  timestamp : Int
  state : Array[Double]
} derive(Debug, Eq)

pub extend Checkpoint with Eq::{equal, not_equal}
pub extend Checkpoint with Debug::{to_repr}

/// 构造检查点 / Build checkpoint.
pub fn make_checkpoint(
  id : String,
  timestamp : Int
) -> Checkpoint {
  { id, timestamp, state: [] }
}

/// 保存检查点 / Save checkpoint state.
pub fn checkpoint_save(
  cp : Checkpoint,
  state : Array[Double]
) -> Checkpoint {
  { id: cp.id, timestamp: cp.timestamp, state }
}

/// 加载检查点 / Load checkpoint state.
pub fn checkpoint_load(cp : Checkpoint) -> Array[Double] {
  cp.state
}

///===
/// Backpressure

pub struct Backpressure {
  high_threshold : Double
  low_threshold : Double
  current_load : Double
} derive(Debug, Eq)

pub extend Backpressure with Eq::{equal, not_equal}
pub extend Backpressure with Debug::{to_repr}

/// 构造背压 / Build backpressure controller.
pub fn make_backpressure(
  high_threshold : Double,
  low_threshold : Double
) -> Backpressure {
  { high_threshold, low_threshold, current_load: 0.0 }
}

/// 处理背压 / Handle backpressure with new load.
pub fn backpressure_handle(
  bp : Backpressure,
  load : Double
) -> Backpressure {
  { high_threshold: bp.high_threshold, low_threshold: bp.low_threshold, current_load: load }
}

/// 检查背压 / Check if backpressure active.
pub fn backpressure_check(bp : Backpressure) -> Bool {
  bp.current_load >= bp.high_threshold
}

///===
/// StreamBuffer

pub struct StreamBuffer {
  capacity : Int
  items : Array[Double]
} derive(Debug, Eq)

pub extend StreamBuffer with Eq::{equal, not_equal}
pub extend StreamBuffer with Debug::{to_repr}

/// 构造流缓冲区 / Build stream buffer.
pub fn make_stream_buffer(capacity : Int) -> StreamBuffer {
  { capacity, items: [] }
}

/// 缓冲区推入 / Push to buffer.
pub fn buffer_push(
  buf : StreamBuffer,
  item : Double
) -> StreamBuffer {
  let items : Array[Double] = []
  for i in 0..<buf.items.length() {
    items.push(buf.items[i])
  }
  if items.length() < buf.capacity {
    items.push(item)
  }
  { capacity: buf.capacity, items }
}

/// 缓冲区弹出 / Pop from buffer.
pub fn buffer_pop(buf : StreamBuffer) -> (StreamBuffer, Double) {
  if buf.items.length() == 0 {
    return ({ capacity: buf.capacity, items: [] }, 0.0)
  }
  let items : Array[Double] = []
  for i in 1..<buf.items.length() {
    items.push(buf.items[i])
  }
  ({ capacity: buf.capacity, items }, buf.items[0])
}

/// 缓冲区窥视 / Peek buffer head.
pub fn buffer_peek(buf : StreamBuffer) -> Double {
  if buf.items.length() == 0 {
    return 0.0
  }
  buf.items[0]
}

///===
/// serialize / deserialize / compress

/// 流序列化 / Serialize stream to string.
pub fn stream_serialize(data : Array[Double]) -> String {
  let mut s = ""
  for i in 0..<data.length() {
    if i > 0 {
      s = s + ","
    }
    s = s + data[i].to_string()
  }
  s
}

/// 流反序列化 / Deserialize string to stream (count only).
pub fn stream_deserialize(s : String) -> Array[Double] {
  let result : Array[Double] = []
  let mut current = ""
  let n = s.length()
  let mut i = 0
  while i < n {
    let ch = s[i]
    if ch == 44 {
      if current.length() > 0 {
        result.push(st_parse_double(current))
      }
      current = ""
    } else {
      current = current + ch.to_int().to_char().to_string()
    }
    i = i + 1
  }
  if current.length() > 0 {
    result.push(st_parse_double(current))
  }
  result
}

fn st_parse_double(s : String) -> Double {
  let mut result = 0.0
  let mut sign = 1.0
  let mut idx = 0
  let n = s.length()
  if n == 0 {
    return 0.0
  }
  if s[0] == 45 {
    sign = -1.0
    idx = 1
  }
  let mut after_dot = false
  let mut divisor = 10.0
  while idx < n {
    let ch = s[idx]
    let code = ch.to_int()
    if code == 46 {
      after_dot = true
    } else if code >= 48 && code <= 57 {
      let digit = (code - 48).to_double()
      if after_dot {
        result = result + digit / divisor
        divisor = divisor * 10.0
      } else {
        result = result * 10.0 + digit
      }
    }
    idx = idx + 1
  }
  sign * result
}

/// 流压缩 / Compress stream (delta encoding).
pub fn stream_compress(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 {
    return []
  }
  let result : Array[Double] = [data[0]]
  for i in 1..<n {
    result.push(data[i] - data[i - 1])
  }
  result
}

///===
/// KafkaSource

pub struct KafkaSource {
  topic : String
  brokers : String
  group_id : String
  partition : Int
} derive(Debug, Eq)

pub extend KafkaSource with Eq::{equal, not_equal}
pub extend KafkaSource with Debug::{to_repr}

/// 构造 Kafka 源 / Build kafka source.
pub fn make_kafka_source(
  topic : String,
  brokers : String,
  group_id : String
) -> KafkaSource {
  { topic, brokers, group_id, partition: 0 }
}

/// Kafka 消费 / Consume from kafka (simulated).
pub fn kafka_consume(
  source : KafkaSource,
  max_records : Int
) -> Array[String] {
  let result : Array[String] = []
  for i in 0..<max_records {
    result.push(source.topic + ":" + i.to_string())
  }
  result
}

/// Kafka 生产 / Produce to kafka (simulated).
pub fn kafka_produce(
  source : KafkaSource,
  records : Array[String]
) -> Int {
  records.length()
}

///===
/// FileSource

pub struct FileSource {
  path : String
  format : String
  batch_size : Int
} derive(Debug, Eq)

pub extend FileSource with Eq::{equal, not_equal}
pub extend FileSource with Debug::{to_repr}

/// 构造文件源 / Build file source.
pub fn make_file_source(
  path : String,
  format : String
) -> FileSource {
  { path, format, batch_size: 1024 }
}

/// 文件流读 / Read file stream (simulated).
pub fn file_stream_read(
  source : FileSource,
  n : Int
) -> Array[String] {
  let result : Array[String] = []
  for i in 0..<n {
    result.push(source.path + "/line_" + i.to_string())
  }
  result
}

/// 文件流写 / Write file stream (simulated).
pub fn file_stream_write(
  source : FileSource,
  lines : Array[String]
) -> Int {
  lines.length()
}

///===
/// RateLimiter

pub struct RateLimiter {
  rate_per_sec : Double
  burst : Int
  tokens : Double
} derive(Debug, Eq)

pub extend RateLimiter with Eq::{equal, not_equal}
pub extend RateLimiter with Debug::{to_repr}

/// 构造限流器 / Build rate limiter.
pub fn make_rate_limiter(
  rate_per_sec : Double,
  burst : Int
) -> RateLimiter {
  { rate_per_sec, burst, tokens: burst.to_double() }
}

/// 限流 / Apply rate limit.
pub fn rate_limit(
  rl : RateLimiter,
  elapsed_sec : Double
) -> RateLimiter {
  let new_tokens = st_min(
    rl.burst.to_double(),
    rl.tokens + elapsed_sec * rl.rate_per_sec
  )
  { rate_per_sec: rl.rate_per_sec, burst: rl.burst, tokens: new_tokens }
}

/// 限流检查 / Check rate limit.
pub fn rate_check(rl : RateLimiter) -> Bool {
  rl.tokens >= 1.0
}

///===
/// monitor / metrics / health

pub struct StreamMetrics {
  processed : Int
  errors : Int
  latency_ms : Double
  throughput : Double
} derive(Debug, Eq)

pub extend StreamMetrics with Eq::{equal, not_equal}
pub extend StreamMetrics with Debug::{to_repr}

/// 流监控 / Monitor stream.
pub fn stream_monitor(
  data : Array[Double],
  window : Int
) -> Array[Double] {
  stream_aggregate(data, window)
}

/// 流指标 / Compute stream metrics.
pub fn stream_metrics(
  processed : Int,
  errors : Int,
  latency_ms : Double
) -> StreamMetrics {
  let throughput = if latency_ms > 0.0 {
    processed.to_double() / latency_ms * 1000.0
  } else {
    0.0
  }
  { processed, errors, latency_ms, throughput }
}

/// 流健康 / Stream health check.
pub fn stream_health(metrics : StreamMetrics) -> String {
  if metrics.errors > metrics.processed / 2 {
    "unhealthy"
  } else if metrics.throughput > 0.0 {
    "healthy"
  } else {
    "idle"
  }
}

///===
/// ExactlyOnce

pub struct ExactlyOnce {
  transactional_id : String
  epoch : Int
  committed : Bool
} derive(Debug, Eq)

pub extend ExactlyOnce with Eq::{equal, not_equal}
pub extend ExactlyOnce with Debug::{to_repr}

/// 构造精确一次 / Build exactly-once semantics.
pub fn make_exactly_once(
  transactional_id : String
) -> ExactlyOnce {
  { transactional_id, epoch: 0, committed: false }
}

/// 精确一次处理 / Process with exactly-once.
pub fn exactly_once_process(
  eo : ExactlyOnce,
  data : Array[Double]
) -> (ExactlyOnce, Array[Double]) {
  let new_eo = {
    transactional_id: eo.transactional_id,
    epoch: eo.epoch + 1,
    committed: true,
  }
  (new_eo, data)
}

/// 幂等检查 / Idempotent check.
pub fn idempotent_check(
  eo : ExactlyOnce,
  seen_ids : Array[String],
  id : String
) -> Bool {
  for i in 0..<seen_ids.length() {
    if seen_ids[i] == id {
      return false
    }
  }
  let _ = eo
  true
}

///===
/// ID

/// 流处理模块 ID / Streaming module id.
pub fn streaming_id() -> String {
  "dataobject/streaming"
}