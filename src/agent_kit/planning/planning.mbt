///|
/// # agent_kit/planning 规划引擎 / Planning Engine
///
/// 任务分解、路径规划、资源分配、HTN、MDP。
/// 架构 §4.8 Agent-Kit。S12.8 填充。
///
/// # Planning engine
///
/// Task decomposition / path planning / resource allocation / HTN / MDP.

/// 任务 / Task.
pub struct Task {
  task_id : Int
  name : String
  description : String
  priority : Int
  duration : Int
} derive(Debug, Eq)

pub extend Task with Eq::{equal, not_equal}
pub extend Task with Debug::{to_repr}

/// 计划 / Plan.
pub struct Plan {
  plan_id : String
  tasks : Array[Task]
  dependencies : Array[(Int, Int)]
} derive(Debug, Eq)

pub extend Plan with Eq::{equal, not_equal}
pub extend Plan with Debug::{to_repr}

/// 目标 / Goal.
pub struct Goal {
  goal_id : String
  description : String
  achieved : Bool
} derive(Debug, Eq)

pub extend Goal with Eq::{equal, not_equal}
pub extend Goal with Debug::{to_repr}

/// 动作 / Action.
pub struct Action {
  action_id : String
  name : String
  preconditions : Array[String]
  effects : Array[String]
  cost : Double
} derive(Debug, Eq)

pub extend Action with Eq::{equal, not_equal}
pub extend Action with Debug::{to_repr}

/// 状态 / State.
pub struct State {
  state_id : String
  facts : Array[String]
} derive(Debug, Eq)

pub extend State with Eq::{equal, not_equal}
pub extend State with Debug::{to_repr}

/// 资源 / Resource.
pub struct Resource {
  resource_id : String
  name : String
  capacity : Int
  used : Int
} derive(Debug, Eq)

pub extend Resource with Eq::{equal, not_equal}
pub extend Resource with Debug::{to_repr}

/// 约束 / Constraint.
pub struct Constraint {
  constraint_id : String
  description : String
  penalty : Double
} derive(Debug, Eq)

pub extend Constraint with Eq::{equal, not_equal}
pub extend Constraint with Debug::{to_repr}

/// 时间线 / Timeline.
pub struct Timeline {
  timeline_id : String
  slots : Array[(Int, Int, String)]
} derive(Debug, Eq)

pub extend Timeline with Eq::{equal, not_equal}
pub extend Timeline with Debug::{to_repr}

/// 有向无环图 / DAG.
pub struct DAG {
  nodes : Array[String]
  edges : Array[(String, String)]
} derive(Debug, Eq)

pub extend DAG with Eq::{equal, not_equal}
pub extend DAG with Debug::{to_repr}

/// HTN 方法 / HTN method.
pub struct HTNMethod {
  method_id : String
  task_name : String
  subtasks : Array[String]
} derive(Debug, Eq)

pub extend HTNMethod with Eq::{equal, not_equal}
pub extend HTNMethod with Debug::{to_repr}

/// HTN / Hierarchical Task Network.
pub struct HTN {
  htn_id : String
  methods : Array[HTNMethod]
} derive(Debug, Eq)

pub extend HTN with Eq::{equal, not_equal}
pub extend HTN with Debug::{to_repr}

/// MDP / Markov Decision Process.
pub struct MDP {
  mdp_id : String
  states : Array[String]
  actions : Array[String]
  transitions : Array[(String, String, String, Double)]
  rewards : Array[(String, String, Double)]
  gamma : Double
} derive(Debug, Eq)

pub extend MDP with Eq::{equal, not_equal}
pub extend MDP with Debug::{to_repr}

/// 策略 / Policy.
pub struct Policy {
  policy_id : String
  mapping : Array[(String, String)]
} derive(Debug, Eq)

pub extend Policy with Eq::{equal, not_equal}
pub extend Policy with Debug::{to_repr}

///===
/// 构造函数 / Constructors

/// 构造任务 / Make task.
pub fn make_task(task_id : Int, name : String, description : String, priority : Int, duration : Int) -> Task {
  { task_id, name, description, priority, duration }
}

/// 构造计划 / Make plan.
pub fn make_plan(plan_id : String, tasks : Array[Task], dependencies : Array[(Int, Int)]) -> Plan {
  { plan_id, tasks, dependencies }
}

/// 构造目标 / Make goal.
pub fn make_goal(goal_id : String, description : String, achieved : Bool) -> Goal {
  { goal_id, description, achieved }
}

/// 构造动作 / Make action.
pub fn make_action(action_id : String, name : String, preconditions : Array[String], effects : Array[String], cost : Double) -> Action {
  { action_id, name, preconditions, effects, cost }
}

///===
/// 任务分解 / Task decomposition

/// 分解任务 / Decompose task.
pub fn decompose_task(task : Task, parts : Int) -> Array[Task] {
  let result : Array[Task] = []
  if parts <= 0 {
    return result
  }
  let sub_duration = task.duration / parts
  for i = 0; i < parts; i = i + 1 {
    result.push(make_task(task.task_id * 100 + i, task.name + "_sub_" + i.to_string(), "Subtask of " + task.description, task.priority, sub_duration))
  }
  result
}

/// 子任务 / Subtasks.
pub fn subtasks(plan : Plan, task_id : Int) -> Array[Task] {
  let result : Array[Task] = []
  for i = 0; i < plan.dependencies.length(); i = i + 1 {
    if plan.dependencies[i].0 == task_id {
      let dep_id = plan.dependencies[i].1
      for j = 0; j < plan.tasks.length(); j = j + 1 {
        if plan.tasks[j].task_id == dep_id {
          result.push(plan.tasks[j])
        }
      }
    }
  }
  result
}

/// 任务依赖 / Task dependencies.
pub fn task_dependencies(plan : Plan, task_id : Int) -> Array[Int] {
  let result : Array[Int] = []
  for i = 0; i < plan.dependencies.length(); i = i + 1 {
    if plan.dependencies[i].1 == task_id {
      result.push(plan.dependencies[i].0)
    }
  }
  result
}

///===
/// 状态与搜索 / State and search

/// 构造状态 / Make state.
pub fn make_state(state_id : String, facts : Array[String]) -> State {
  { state_id, facts }
}

/// 状态转移 / State transition.
pub fn state_transition(state : State, action : Action) -> State {
  let new_facts = state.facts.copy()
  for i = 0; i < action.effects.length(); i = i + 1 {
    new_facts.push(action.effects[i])
  }
  { state_id: state.state_id + "_" + action.action_id, facts: new_facts }
}

/// 目标达成 / Goal reached.
pub fn goal_reached(state : State, goal : Goal) -> Bool {
  if goal.achieved {
    return true
  }
  for i = 0; i < state.facts.length(); i = i + 1 {
    if state.facts[i] == goal.description {
      return true
    }
  }
  false
}

/// 前向搜索 / Forward search.
pub fn forward_search(initial : State, goal : Goal, actions : Array[Action], max_depth : Int) -> Array[Action] {
  let result : Array[Action] = []
  let mut current = initial
  let mut depth = 0
  while not(goal_reached(current, goal)) && depth < max_depth {
    let mut applied = false
    for i = 0; i < actions.length(); i = i + 1 {
      let a = actions[i]
      let mut pre_ok = true
      for j = 0; j < a.preconditions.length(); j = j + 1 {
        let mut found = false
        for k = 0; k < current.facts.length(); k = k + 1 {
          if current.facts[k] == a.preconditions[j] {
            found = true
          }
        }
        if not(found) {
          pre_ok = false
        }
      }
      if pre_ok {
        current = state_transition(current, a)
        result.push(a)
        applied = true
      }
    }
    if not(applied) {
      return result
    }
    depth = depth + 1
  }
  result
}

/// 后向搜索 / Backward search.
pub fn backward_search(goal : Goal, actions : Array[Action], max_depth : Int) -> Array[Action] {
  let result : Array[Action] = []
  let remaining : Array[String] = [goal.description]
  let mut depth = 0
  while remaining.length() > 0 && depth < max_depth {
    let target = remaining.remove(remaining.length() - 1)
    for i = 0; i < actions.length(); i = i + 1 {
      let a = actions[i]
      for j = 0; j < a.effects.length(); j = j + 1 {
        if a.effects[j] == target {
          result.push(a)
          for k = 0; k < a.preconditions.length(); k = k + 1 {
            remaining.push(a.preconditions[k])
          }
        }
      }
    }
    depth = depth + 1
  }
  result
}

/// A* 搜索 / A-star search.
pub fn a_star_search(start : String, goal : String, graph : Array[(String, String, Double)], heuristic : Array[(String, Double)]) -> Array[String] {
  let path : Array[String] = [start]
  let mut current = start
  let mut steps = 0
  while current != goal && steps < 100 {
    let mut best_next : String? = None
    let mut best_score = 999999.0
    for i = 0; i < graph.length(); i = i + 1 {
      if graph[i].0 == current {
        let next = graph[i].1
        let cost = graph[i].2
        let mut h = 0.0
        for j = 0; j < heuristic.length(); j = j + 1 {
          if heuristic[j].0 == next {
            h = heuristic[j].1
          }
        }
        let score = cost + h
        if score < best_score {
          best_score = score
          best_next = Some(next)
        }
      }
    }
    match best_next {
      Some(n) => {
        path.push(n)
        current = n
      }
      None => return path
    }
    steps = steps + 1
  }
  path
}

///===
/// 资源管理 / Resource management

/// 构造资源 / Make resource.
pub fn make_resource(resource_id : String, name : String, capacity : Int) -> Resource {
  { resource_id, name, capacity, used: 0 }
}

/// 分配资源 / Allocate resource.
pub fn allocate_resource_plan(resource : Resource, amount : Int) -> Resource {
  if resource.used + amount <= resource.capacity && amount >= 0 {
    { ..resource, used: resource.used + amount }
  } else {
    resource
  }
}

/// 释放资源 / Deallocate resource.
pub fn deallocate_resource(resource : Resource, amount : Int) -> Resource {
  if amount >= resource.used {
    { ..resource, used: 0 }
  } else if amount >= 0 {
    { ..resource, used: resource.used - amount }
  } else {
    resource
  }
}

///===
/// 约束 / Constraints

/// 构造约束 / Make constraint.
pub fn make_constraint(constraint_id : String, description : String, penalty : Double) -> Constraint {
  { constraint_id, description, penalty }
}

/// 检查约束 / Check constraint.
pub fn check_constraint(constraint : Constraint, value : Double, limit : Double) -> Bool {
  if value <= limit {
    true
  } else {
    constraint.penalty == 0.0
  }
}

/// 满足所有约束 / Satisfy constraints.
pub fn satisfy_constraints(constraints : Array[Constraint], values : Array[Double], limits : Array[Double]) -> Bool {
  let n = constraints.length()
  if values.length() < n || limits.length() < n {
    return false
  }
  for i = 0; i < n; i = i + 1 {
    if not(check_constraint(constraints[i], values[i], limits[i])) {
      return false
    }
  }
  true
}

///===
/// 时间线 / Timeline

/// 构造时间线 / Make timeline.
pub fn make_timeline(timeline_id : String) -> Timeline {
  { timeline_id, slots: [] }
}

/// 调度任务 / Schedule task.
pub fn schedule_task_plan(timeline : Timeline, task : Task, start : Int) -> Timeline {
  let new_slots = timeline.slots.copy()
  new_slots.push((start, start + task.duration, task.name))
  { ..timeline, slots: new_slots }
}

/// 关键路径 / Critical path.
pub fn critical_path(plan : Plan) -> Array[Int] {
  let n = plan.tasks.length()
  if n == 0 {
    return []
  }
  let est = Array::make(n, 0)
  let eft = Array::make(n, 0)
  let mut loop_guard_count = 0
  let mut improved = true
  while improved && loop_guard_count < n + 1 {
    improved = false
    loop_guard_count = loop_guard_count + 1
    for i = 0; i < n; i = i + 1 {
      for j = 0; j < plan.dependencies.length(); j = j + 1 {
        if plan.dependencies[j].1 == plan.tasks[i].task_id {
          let dep_id = plan.dependencies[j].0
          for k = 0; k < n; k = k + 1 {
            if plan.tasks[k].task_id == dep_id && eft[k] > est[i] {
              est[i] = eft[k]
              improved = true
            }
          }
        }
      }
      let new_eft = est[i] + plan.tasks[i].duration
      if new_eft != eft[i] {
        eft[i] = new_eft
        improved = true
      }
    }
  }
  let mut max_eft = 0
  let mut max_idx = 0
  for i = 0; i < n; i = i + 1 {
    if eft[i] > max_eft {
      max_eft = eft[i]
      max_idx = i
    }
  }
  let result : Array[Int] = []
  result.push(plan.tasks[max_idx].task_id)
  let mut current = max_idx

  let mut done = false
  let mut loop_guard2 = 0
  while not(done) && loop_guard2 < n {
    done = true
    loop_guard2 = loop_guard2 + 1
    for j = 0; j < plan.dependencies.length(); j = j + 1 {
      if plan.dependencies[j].1 == plan.tasks[current].task_id {
        let dep_id = plan.dependencies[j].0
        for k = 0; k < n; k = k + 1 {
          if plan.tasks[k].task_id == dep_id && eft[k] == est[current] {
            result.push(plan.tasks[k].task_id)
            current = k
            done = false
          }
        }
      }
    }
  }
  let reversed : Array[Int] = []
  let len = result.length()
  for i = 0; i < len; i = i + 1 {
    reversed.push(result[len - 1 - i])
  }
  reversed
}

///===
/// DAG / Directed Acyclic Graph

/// 构造 DAG / Make DAG.
pub fn make_dag(nodes : Array[String], edges : Array[(String, String)]) -> DAG {
  { nodes, edges }
}

fn node_index(dag : DAG, node : String) -> Int {
  for i = 0; i < dag.nodes.length(); i = i + 1 {
    if dag.nodes[i] == node {
      return i
    }
  }
  -1
}

/// 拓扑排序 / Topological sort.
pub fn topological_sort(dag : DAG) -> Array[String] {
  let result : Array[String] = []
  let n = dag.nodes.length()
  let visited = Array::make(n, false)
  let mut remaining = n
  let mut loop_guard = 0
  while remaining > 0 && loop_guard < n * n + 1 {
    loop_guard = loop_guard + 1
    for i = 0; i < n; i = i + 1 {
      if not(visited[i]) {
        let mut all_deps_visited = true
        for j = 0; j < dag.edges.length(); j = j + 1 {
          if dag.edges[j].1 == dag.nodes[i] {
            let mut dep_visited = false
            for k = 0; k < n; k = k + 1 {
              if dag.nodes[k] == dag.edges[j].0 && visited[k] {
                dep_visited = true
              }
            }
            if not(dep_visited) {
              all_deps_visited = false
            }
          }
        }
        if all_deps_visited {
          result.push(dag.nodes[i])
          visited[i] = true
          remaining = remaining - 1
        }
      }
    }
  }
  result
}

/// 最长路径 / Longest path.
pub fn longest_path(dag : DAG, source : String, target : String) -> Int {
  let n = dag.nodes.length()
  if n == 0 {
    return 0
  }
  let dist = Array::make(n, 0)
  let sorted = topological_sort(dag)
  for i = 0; i < sorted.length(); i = i + 1 {
    let u = sorted[i]
    let u_idx = node_index(dag, u)
    if u_idx >= 0 {
      for j = 0; j < dag.edges.length(); j = j + 1 {
        if dag.edges[j].0 == u {
          let v = dag.edges[j].1
          let v_idx = node_index(dag, v)
          if v_idx >= 0 && dist[v_idx] < dist[u_idx] + 1 {
            dist[v_idx] = dist[u_idx] + 1
          }
        }
      }
    }
  }
  let s_idx = node_index(dag, source)
  let t_idx = node_index(dag, target)
  if s_idx >= 0 && t_idx >= 0 {
    dist[t_idx] - dist[s_idx]
  } else {
    0
  }
}

///===
/// HTN / Hierarchical Task Network

/// 构造 HTN / Make HTN.
pub fn make_htn(htn_id : String, methods : Array[HTNMethod]) -> HTN {
  { htn_id, methods }
}

/// HTN 分解 / HTN decompose.
pub fn htn_decompose(htn : HTN, task_name : String) -> Array[String] {
  for i = 0; i < htn.methods.length(); i = i + 1 {
    if htn.methods[i].task_name == task_name {
      return htn.methods[i].subtasks.copy()
    }
  }
  []
}

/// HTN 规划 / HTN plan.
pub fn htn_plan(htn : HTN, root_task : String, max_depth : Int) -> Array[String] {
  let result : Array[String] = []
  let queue : Array[(String, Int)] = [(root_task, 0)]
  while queue.length() > 0 {
    let item = queue.remove(queue.length() - 1)
    let task = item.0
    let depth = item.1
    let subs = htn_decompose(htn, task)
    if subs.length() == 0 || depth >= max_depth {
      result.push(task)
    } else {
      for i = 0; i < subs.length(); i = i + 1 {
        queue.push((subs[i], depth + 1))
      }
    }
  }
  let reversed : Array[String] = []
  let len = result.length()
  for i = 0; i < len; i = i + 1 {
    reversed.push(result[len - 1 - i])
  }
  reversed
}

///===
/// MDP / Markov Decision Process

/// 构造 MDP / Make MDP.
pub fn make_mdp(mdp_id : String, states : Array[String], actions : Array[String], transitions : Array[(String, String, String, Double)], rewards : Array[(String, String, Double)], gamma : Double) -> MDP {
  { mdp_id, states, actions, transitions, rewards, gamma }
}

fn state_value(values : Array[(String, Double)], s : String) -> Double {
  for i = 0; i < values.length(); i = i + 1 {
    if values[i].0 == s {
      return values[i].1
    }
  }
  0.0
}

/// 值迭代 / Value iteration.
pub fn value_iteration(mdp : MDP, max_iter : Int, threshold : Double) -> Array[(String, Double)] {
  let n = mdp.states.length()
  let values = Array::make(n, 0.0)
  let mut iter = 0
  let mut delta = threshold + 1.0
  while iter < max_iter && delta > threshold {
    delta = 0.0
    for i = 0; i < n; i = i + 1 {
      let s = mdp.states[i]
      let old_v = values[i]
      let mut best_v = 0.0
      let mut first = true
      for a = 0; a < mdp.actions.length(); a = a + 1 {
        let action = mdp.actions[a]
        let mut q = 0.0
        for t = 0; t < mdp.transitions.length(); t = t + 1 {
          if mdp.transitions[t].0 == s && mdp.transitions[t].1 == action {
            let s2 = mdp.transitions[t].2
            let prob = mdp.transitions[t].3
            let mut r = 0.0
            for rw = 0; rw < mdp.rewards.length(); rw = rw + 1 {
              if mdp.rewards[rw].0 == s && mdp.rewards[rw].1 == action {
                r = mdp.rewards[rw].2
              }
            }
            let mut v2 = 0.0
            for k = 0; k < n; k = k + 1 {
              if mdp.states[k] == s2 {
                v2 = values[k]
              }
            }
            q = q + prob * (r + mdp.gamma * v2)
          }
        }
        if first || q > best_v {
          best_v = q
          first = false
        }
      }
      values[i] = best_v
      let diff = best_v - old_v
      if diff < 0.0 {
        let neg_diff = 0.0 - diff
        if neg_diff > delta {
          delta = neg_diff
        }
      } else {
        if diff > delta {
          delta = diff
        }
      }
    }
    iter = iter + 1
  }
  let result : Array[(String, Double)] = []
  for i = 0; i < n; i = i + 1 {
    result.push((mdp.states[i], values[i]))
  }
  result
}

/// 策略迭代 / Policy iteration.
pub fn policy_iteration(mdp : MDP, max_iter : Int) -> Policy {
  let n = mdp.states.length()
  let values = value_iteration(mdp, max_iter, 0.001)
  let new_mapping : Array[(String, String)] = []
  for i = 0; i < n; i = i + 1 {
    let s = mdp.states[i]
    let mut best_action = ""
    let mut best_q = 0.0
    let mut first = true
    for a = 0; a < mdp.actions.length(); a = a + 1 {
      let action = mdp.actions[a]
      let mut q = 0.0
      for t = 0; t < mdp.transitions.length(); t = t + 1 {
        if mdp.transitions[t].0 == s && mdp.transitions[t].1 == action {
          let s2 = mdp.transitions[t].2
          let prob = mdp.transitions[t].3
          let mut r = 0.0
          for rw = 0; rw < mdp.rewards.length(); rw = rw + 1 {
            if mdp.rewards[rw].0 == s && mdp.rewards[rw].1 == action {
              r = mdp.rewards[rw].2
            }
          }
          let v2 = state_value(values, s2)
          q = q + prob * (r + mdp.gamma * v2)
        }
      }
      if first || q > best_q {
        best_q = q
        best_action = action
        first = false
      }
    }
    new_mapping.push((s, best_action))
  }
  { policy_id: "policy_" + mdp.mdp_id, mapping: new_mapping }
}

/// Q-learning 单步更新 / Q-learning step.
pub fn q_learning_step(q_table : Array[(String, String, Double)], state : String, action : String, reward : Double, next_state : String, next_actions : Array[String], alpha : Double, gamma : Double) -> Array[(String, String, Double)] {
  let new_q = q_table.copy()
  let mut current_q = 0.0
  let mut q_idx = -1
  for i = 0; i < new_q.length(); i = i + 1 {
    if new_q[i].0 == state && new_q[i].1 == action {
      current_q = new_q[i].2
      q_idx = i
    }
  }
  let mut max_next_q = 0.0
  let mut first = true
  for a = 0; a < next_actions.length(); a = a + 1 {
    for i = 0; i < q_table.length(); i = i + 1 {
      if q_table[i].0 == next_state && q_table[i].1 == next_actions[a] {
        if first || q_table[i].2 > max_next_q {
          max_next_q = q_table[i].2
          first = false
        }
      }
    }
  }
  let updated_q = current_q + alpha * (reward + gamma * max_next_q - current_q)
  if q_idx >= 0 {
    new_q[q_idx] = (state, action, updated_q)
  } else {
    new_q.push((state, action, updated_q))
  }
  new_q
}

/// SARSA 单步更新 / SARSA step.
pub fn sarsa_step(q_table : Array[(String, String, Double)], state : String, action : String, reward : Double, next_state : String, next_action : String, alpha : Double, gamma : Double) -> Array[(String, String, Double)] {
  let new_q = q_table.copy()
  let mut current_q = 0.0
  let mut q_idx = -1
  for i = 0; i < new_q.length(); i = i + 1 {
    if new_q[i].0 == state && new_q[i].1 == action {
      current_q = new_q[i].2
      q_idx = i
    }
  }
  let mut next_q = 0.0
  for i = 0; i < q_table.length(); i = i + 1 {
    if q_table[i].0 == next_state && q_table[i].1 == next_action {
      next_q = q_table[i].2
    }
  }
  let updated_q = current_q + alpha * (reward + gamma * next_q - current_q)
  if q_idx >= 0 {
    new_q[q_idx] = (state, action, updated_q)
  } else {
    new_q.push((state, action, updated_q))
  }
  new_q
}

/// 构造策略 / Make policy.
pub fn make_policy(policy_id : String, mapping : Array[(String, String)]) -> Policy {
  { policy_id, mapping }
}

///===
/// 计划评估与优化 / Plan evaluation and optimization

/// 评估计划 / Evaluate plan.
pub fn evaluate_plan(plan : Plan) -> Double {
  let cost = plan_cost(plan)
  let duration = plan_duration(plan).to_double()
  cost + duration
}

/// 计划成本 / Plan cost.
pub fn plan_cost(plan : Plan) -> Double {
  let mut total = 0.0
  for i = 0; i < plan.tasks.length(); i = i + 1 {
    total = total + plan.tasks[i].priority.to_double()
  }
  total
}

/// 计划工期 / Plan duration.
pub fn plan_duration(plan : Plan) -> Int {
  let mut total = 0
  for i = 0; i < plan.tasks.length(); i = i + 1 {
    total = total + plan.tasks[i].duration
  }
  total
}

/// 优化计划 / Optimize plan.
pub fn optimize_plan(plan : Plan) -> Plan {
  let sorted_tasks = plan.tasks.copy()
  let n = sorted_tasks.length()
  for i = 0; i < n; i = i + 1 {
    for j = i + 1; j < n; j = j + 1 {
      if sorted_tasks[j].priority > sorted_tasks[i].priority {
        let tmp = sorted_tasks[i]
        sorted_tasks[i] = sorted_tasks[j]
        sorted_tasks[j] = tmp
      }
    }
  }
  { ..plan, tasks: sorted_tasks }
}

/// 并行化任务 / Parallelize tasks.
pub fn parallelize_tasks(plan : Plan) -> Array[Array[Task]] {
  let result : Array[Array[Task]] = []
  let n = plan.tasks.length()
  if n == 0 {
    return result
  }
  let scheduled = Array::make(n, false)
  let mut remaining = n
  let mut loop_guard = 0
  while remaining > 0 && loop_guard < n + 1 {
    loop_guard = loop_guard + 1
    let batch : Array[Task] = []
    for i = 0; i < n; i = i + 1 {
      if not(scheduled[i]) {
        let mut deps_ok = true
        for j = 0; j < plan.dependencies.length(); j = j + 1 {
          if plan.dependencies[j].1 == plan.tasks[i].task_id {
            let mut dep_done = false
            for k = 0; k < n; k = k + 1 {
              if plan.tasks[k].task_id == plan.dependencies[j].0 && scheduled[k] {
                dep_done = true
              }
            }
            if not(dep_done) {
              deps_ok = false
            }
          }
        }
        if deps_ok {
          batch.push(plan.tasks[i])
          scheduled[i] = true
          remaining = remaining - 1
        }
      }
    }
    if batch.length() > 0 {
      result.push(batch)
    } else {
      return result
    }
  }
  result
}

/// 序列化任务 / Serialize tasks.
pub fn serialize_tasks(plan : Plan) -> Array[Task] {
  let n = plan.tasks.length()
  if n == 0 {
    return []
  }
  let node_names : Array[String] = []
  let edges : Array[(String, String)] = []
  for i = 0; i < n; i = i + 1 {
    node_names.push(plan.tasks[i].task_id.to_string())
  }
  for j = 0; j < plan.dependencies.length(); j = j + 1 {
    edges.push((plan.dependencies[j].0.to_string(), plan.dependencies[j].1.to_string()))
  }
  let dag = make_dag(node_names, edges)
  let sorted = topological_sort(dag)
  let result : Array[Task] = []
  for i = 0; i < sorted.length(); i = i + 1 {
    for j = 0; j < n; j = j + 1 {
      if plan.tasks[j].task_id.to_string() == sorted[i] {
        result.push(plan.tasks[j])
      }
    }
  }
  result
}

/// 模块标识 / Module id.
pub fn planning_id() -> String {
  "agent_kit/planning"
}