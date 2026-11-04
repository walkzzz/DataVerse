///|
/// # dosi/scheduler 调度策略 / Scheduler
///
/// 调度策略：优先级调度、资源管理、队列管理。
/// S10.4 新建。
///
/// # Scheduling strategies

///|
/// 调度策略 / Scheduling policy.
pub(all) enum SchedulePolicy {
  FIFO
  Priority
  RoundRobin
  ShortestJobFirst
  FairShare
}

///|
/// 调度任务 / Scheduled task.
pub struct ScheduleTask {
  id : String
  priority : Int32
  estimated_cost : Double
  resource_requirement : Double
  submit_time : Double
}

///|
/// 调度结果 / Schedule result.
pub struct ScheduleResult {
  task_id : String
  start_time : Double
  assigned_resource : String
  policy : SchedulePolicy
}

///|
/// 构造调度任务 / Create scheduled task.
pub fn make_task(
  id : String,
  priority : Int32,
  estimated_cost : Double,
  resource_requirement : Double,
  submit_time : Double,
) -> ScheduleTask {
  { id, priority, estimated_cost, resource_requirement, submit_time, }
}

///|
/// 构造调度结果 / Create schedule result.
pub fn make_schedule_result(
  task_id : String,
  start_time : Double,
  assigned_resource : String,
  policy : SchedulePolicy,
) -> ScheduleResult {
  { task_id, start_time, assigned_resource, policy, }
}

///===
/// 优先级调度 / Priority scheduling

///|
/// 按优先级排序 / Sort by priority (descending).
pub fn sort_by_priority(tasks : Array[ScheduleTask]) -> Array[ScheduleTask] {
  let result = tasks.copy()
  result.sort_by(fn(a, b) { b.priority.compare(a.priority) })
  result
}

///|
/// 优先级调度 / Schedule by priority.
pub fn schedule_priority(
  tasks : Array[ScheduleTask],
  resource_id : String,
  base_time : Double,
) -> Array[ScheduleResult] {
  let sorted = sort_by_priority(tasks)
  let result : Array[ScheduleResult] = []
  let mut current_time = base_time
  for i in 0..<sorted.length() {
    result.push(
      make_schedule_result(sorted[i].id, current_time, resource_id, Priority),
    )
    current_time = current_time + sorted[i].estimated_cost
  }
  result
}

///===
/// FIFO 调度 / FIFO scheduling

///|
/// 按提交时间排序 / Sort by submit time.
pub fn sort_by_submit_time(tasks : Array[ScheduleTask]) -> Array[ScheduleTask] {
  let result = tasks.copy()
  result.sort_by(fn(a, b) { a.submit_time.compare(b.submit_time) })
  result
}

///|
/// FIFO 调度 / Schedule FIFO.
pub fn schedule_fifo(
  tasks : Array[ScheduleTask],
  resource_id : String,
  base_time : Double,
) -> Array[ScheduleResult] {
  let sorted = sort_by_submit_time(tasks)
  let result : Array[ScheduleResult] = []
  let mut current_time = base_time
  for i in 0..<sorted.length() {
    result.push(
      make_schedule_result(sorted[i].id, current_time, resource_id, FIFO),
    )
    current_time = current_time + sorted[i].estimated_cost
  }
  result
}

///===
/// 最短作业优先 / Shortest job first

///|
/// 按估计成本排序 / Sort by estimated cost.
pub fn sort_by_cost(tasks : Array[ScheduleTask]) -> Array[ScheduleTask] {
  let result = tasks.copy()
  result.sort_by(fn(a, b) { a.estimated_cost.compare(b.estimated_cost) })
  result
}

///|
/// 最短作业优先调度 / Schedule shortest job first.
pub fn schedule_sjf(
  tasks : Array[ScheduleTask],
  resource_id : String,
  base_time : Double,
) -> Array[ScheduleResult] {
  let sorted = sort_by_cost(tasks)
  let result : Array[ScheduleResult] = []
  let mut current_time = base_time
  for i in 0..<sorted.length() {
    result.push(
      make_schedule_result(
        sorted[i].id,
        current_time,
        resource_id,
        ShortestJobFirst,
      ),
    )
    current_time = current_time + sorted[i].estimated_cost
  }
  result
}

///===
/// 资源管理 / Resource management

///|
/// 资源 / Resource.
pub struct Resource {
  id : String
  capacity : Double
  used : Double
}

///|
/// 构造资源 / Create resource.
pub fn make_resource(id : String, capacity : Double) -> Resource {
  { id, capacity, used: 0.0, }
}

///|
/// 分配资源 / Allocate resource.
pub fn allocate_resource(r : Resource, amount : Double) -> Resource? {
  if r.used + amount > r.capacity {
    return None
  }
  Some({ ..r, used: r.used + amount, })
}

///|
/// 释放资源 / Release resource.
pub fn release_resource(r : Resource, amount : Double) -> Resource {
  let new_used = if r.used - amount < 0.0 { 0.0 } else { r.used - amount }
  { ..r, used: new_used, }
}

///|
/// 资源利用率 / Resource utilization.
pub fn resource_utilization(r : Resource) -> Double {
  if r.capacity == 0.0 {
    0.0
  } else {
    r.used / r.capacity
  }
}

///|
///===
/// 策略名称 / Policy name
pub fn policy_name(policy : SchedulePolicy) -> String {
  match policy {
    FIFO => "fifo"
    Priority => "priority"
    RoundRobin => "round_robin"
    ShortestJobFirst => "shortest_job_first"
    FairShare => "fair_share"
  }
}

///|
///===
/// ID
pub fn scheduler_id() -> String {
  "dosi/scheduler"
}
