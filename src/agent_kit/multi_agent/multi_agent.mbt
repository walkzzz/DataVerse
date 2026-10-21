///|
/// # agent_kit/multi_agent 多智能体系统 / Multi-Agent System
///
/// 多智能体协调、通信、协商、拍卖、合约、任务分配、共享状态、共识、黑板、市场、联盟、委托、监督、层级、联邦、群体智能、环境。
/// 架构 §4.8 Agent-Kit。
///
/// # Multi-agent system

/// 拍卖类型 / Auction type.
pub(all) enum AuctionType {
  English
  Dutch
  SealedBid
}

/// 共识类型 / Consensus type.
pub(all) enum ConsensusType {
  Majority
  Unanimous
  Weighted
}

/// 智能体配置 / Agent configuration.
pub struct AgentConfig {
  agent_id : String
  name : String
  capabilities : Array[String]
  capacity : Double
  reliability : Double
} derive(Debug, Eq)

pub extend AgentConfig with Eq::{equal, not_equal}
pub extend AgentConfig with Debug::{to_repr}

/// 消息 / Message.
pub struct Message {
  msg_id : String
  sender : String
  receiver : String
  content : String
  timestamp : Double
} derive(Debug, Eq)

pub extend Message with Eq::{equal, not_equal}
pub extend Message with Debug::{to_repr}

/// 消息通道 / Message channel.
pub struct MessageChannel {
  channel_id : String
  participants : Array[String]
  messages : Array[Message]
  capacity : Int
} derive(Debug, Eq)

pub extend MessageChannel with Eq::{equal, not_equal}
pub extend MessageChannel with Debug::{to_repr}

/// 角色 / Role.
pub struct Role {
  role_id : String
  permissions : Array[String]
  priority : Int
} derive(Debug, Eq)

pub extend Role with Eq::{equal, not_equal}
pub extend Role with Debug::{to_repr}

/// 角色分配 / Role assignment.
pub struct RoleAssignment {
  agent_id : String
  role : Role
} derive(Debug, Eq)

pub extend RoleAssignment with Eq::{equal, not_equal}
pub extend RoleAssignment with Debug::{to_repr}

/// 协调协议 / Coordination protocol.
pub struct CoordinationProtocol {
  protocol_id : String
  protocol_type : String
  participants : Array[String]
  rules : Array[String]
} derive(Debug, Eq)

pub extend CoordinationProtocol with Eq::{equal, not_equal}
pub extend CoordinationProtocol with Debug::{to_repr}

/// 拍卖 / Auction.
pub struct Auction {
  auction_id : String
  item : String
  bids : Array[(String, Double)]
  reserved_price : Double
  active : Bool
} derive(Debug, Eq)

pub extend Auction with Eq::{equal, not_equal}
pub extend Auction with Debug::{to_repr}

/// 合约 / Contract.
pub struct Contract {
  contract_id : String
  parties : Array[String]
  terms : String
  signed : Array[String]
  active : Bool
} derive(Debug, Eq)

pub extend Contract with Eq::{equal, not_equal}
pub extend Contract with Debug::{to_repr}

/// 任务分配 / Task allocation.
pub struct TaskAllocation {
  task_id : String
  agent_id : String
  task_desc : String
  priority : Int
  status : String
} derive(Debug, Eq)

pub extend TaskAllocation with Eq::{equal, not_equal}
pub extend TaskAllocation with Debug::{to_repr}

/// 共享状态 / Shared state.
pub struct SharedState {
  state_id : String
  data : Array[(String, String)]
  version : Int
} derive(Debug, Eq)

pub extend SharedState with Eq::{equal, not_equal}
pub extend SharedState with Debug::{to_repr}

/// 投票 / Vote.
pub struct Vote {
  voter : String
  proposal : String
  support : Bool
  weight : Double
} derive(Debug, Eq)

pub extend Vote with Eq::{equal, not_equal}
pub extend Vote with Debug::{to_repr}

/// 共识 / Consensus.
pub struct Consensus {
  consensus_id : String
  proposal : String
  votes : Array[Vote]
  threshold : Double
} derive(Debug, Eq)

pub extend Consensus with Eq::{equal, not_equal}
pub extend Consensus with Debug::{to_repr}

/// 黑板 / Blackboard.
pub struct Blackboard {
  blackboard_id : String
  entries : Array[(String, String, Double)]
} derive(Debug, Eq)

pub extend Blackboard with Eq::{equal, not_equal}
pub extend Blackboard with Debug::{to_repr}

/// 市场订单 / Market order.
pub struct MarketOrder {
  order_id : String
  agent_id : String
  side : String
  price : Double
  quantity : Double
} derive(Debug, Eq)

pub extend MarketOrder with Eq::{equal, not_equal}
pub extend MarketOrder with Debug::{to_repr}

/// 市场 / Market.
pub struct Market {
  market_id : String
  bids : Array[MarketOrder]
  asks : Array[MarketOrder]
  cleared : Bool
} derive(Debug, Eq)

pub extend Market with Eq::{equal, not_equal}
pub extend Market with Debug::{to_repr}

/// 联盟 / Coalition.
pub struct Coalition {
  coalition_id : String
  members : Array[String]
  value : Double
} derive(Debug, Eq)

pub extend Coalition with Eq::{equal, not_equal}
pub extend Coalition with Debug::{to_repr}

/// 委托 / Delegation.
pub struct Delegation {
  delegation_id : String
  delegator : String
  delegatee : String
  task : String
  accepted : Bool
} derive(Debug, Eq)

pub extend Delegation with Eq::{equal, not_equal}
pub extend Delegation with Debug::{to_repr}

/// 监督记录 / Supervision record.
pub struct SupervisionRecord {
  supervisor_id : String
  agent_id : String
  status : String
  intervention : String
} derive(Debug, Eq)

pub extend SupervisionRecord with Eq::{equal, not_equal}
pub extend SupervisionRecord with Debug::{to_repr}

/// 层级 / Hierarchy.
pub struct Hierarchy {
  hierarchy_id : String
  levels : Array[(String, Int)]
  parent_map : Array[(String, String)]
} derive(Debug, Eq)

pub extend Hierarchy with Eq::{equal, not_equal}
pub extend Hierarchy with Debug::{to_repr}

/// 联邦 / Federation.
pub struct Federation {
  federation_id : String
  members : Array[String]
  round : Int
  aggregated_value : Double
} derive(Debug, Eq)

pub extend Federation with Eq::{equal, not_equal}
pub extend Federation with Debug::{to_repr}

/// 群体 / Swarm.
pub struct Swarm {
  swarm_id : String
  agents : Array[String]
  positions : Array[(String, Double, Double)]
  behavior : String
} derive(Debug, Eq)

pub extend Swarm with Eq::{equal, not_equal}
pub extend Swarm with Debug::{to_repr}

/// 环境 / Environment.
pub struct Environment {
  env_id : String
  state : Array[(String, String)]
  reward : Double
  step : Int
} derive(Debug, Eq)

pub extend Environment with Eq::{equal, not_equal}
pub extend Environment with Debug::{to_repr}

/// 多智能体系统 / Multi-agent system.
pub struct MultiAgentSystem {
  system_id : String
  agents : Array[AgentConfig]
  channels : Array[MessageChannel]
  protocols : Array[CoordinationProtocol]
} derive(Debug, Eq)

pub extend MultiAgentSystem with Eq::{equal, not_equal}
pub extend MultiAgentSystem with Debug::{to_repr}

///===
/// 构造函数 / Constructors

/// 构造智能体配置 / Make agent config.
pub fn make_agent_config(
  agent_id : String,
  name : String,
  capabilities : Array[String],
  capacity : Double,
  reliability : Double,
) -> AgentConfig {
  { agent_id, name, capabilities, capacity, reliability }
}

/// 构造多智能体系统 / Make multi-agent system.
pub fn make_multi_agent_system(system_id : String) -> MultiAgentSystem {
  { system_id, agents: [], channels: [], protocols: [] }
}

/// 添加智能体 / Add agent to system.
pub fn add_agent_to_system(
  system : MultiAgentSystem,
  agent : AgentConfig,
) -> MultiAgentSystem {
  let new_agents = system.agents.copy()
  new_agents.push(agent)
  { ..system, agents: new_agents }
}

///===
/// 消息通道 / Message channel

/// 构造消息通道 / Make message channel.
pub fn make_message_channel(
  channel_id : String,
  participants : Array[String],
  capacity : Int,
) -> MessageChannel {
  { channel_id, participants, messages: [], capacity }
}

/// 发送消息 / Send message.
pub fn send_message(channel : MessageChannel, msg : Message) -> MessageChannel {
  if channel.messages.length() >= channel.capacity {
    return channel
  }
  let new_messages = channel.messages.copy()
  new_messages.push(msg)
  { ..channel, messages: new_messages }
}

/// 接收消息 / Receive messages.
pub fn receive_message(
  channel : MessageChannel,
  agent_id : String,
) -> (MessageChannel, Array[Message]) {
  let remaining : Array[Message] = []
  let received : Array[Message] = []
  for i in 0..<channel.messages.length() {
    let msg = channel.messages[i]
    if msg.receiver == agent_id {
      received.push(msg)
    } else {
      remaining.push(msg)
    }
  }
  ({ ..channel, messages: remaining }, received)
}

/// 广播消息 / Broadcast message.
pub fn broadcast(
  channel : MessageChannel,
  sender : String,
  content : String,
  timestamp : Double,
) -> MessageChannel {
  let new_messages = channel.messages.copy()
  for i in 0..<channel.participants.length() {
    let p = channel.participants[i]
    if p != sender {
      let msg_id = "bcast_" + sender + "_" + p + "_" + new_messages.length().to_string()
      let msg = { msg_id, sender, receiver: p, content, timestamp }
      if new_messages.length() < channel.capacity {
        new_messages.push(msg)
      }
    }
  }
  { ..channel, messages: new_messages }
}

///===
/// 角色 / Role

/// 构造角色 / Make role.
pub fn make_role(
  role_id : String,
  permissions : Array[String],
  priority : Int,
) -> Role {
  { role_id, permissions, priority }
}

/// 分配角色 / Assign role.
pub fn assign_role(agent_id : String, role : Role) -> RoleAssignment {
  { agent_id, role }
}

/// 检查角色权限 / Check role permission.
pub fn check_role_permission(role : Role, permission : String) -> Bool {
  for i in 0..<role.permissions.length() {
    if role.permissions[i] == permission {
      return true
    }
  }
  false
}

///===
/// 协调协议 / Coordination protocol

/// 构造协调协议 / Make coordination protocol.
pub fn make_coordination_protocol(
  protocol_id : String,
  protocol_type : String,
  participants : Array[String],
) -> CoordinationProtocol {
  { protocol_id, protocol_type, participants, rules: [] }
}

/// 协调 / Coordinate.
pub fn coordinate(
  protocol : CoordinationProtocol,
  agents : Array[String],
) -> String {
  let mut result = protocol.protocol_type + ":"
  for i in 0..<agents.length() {
    result = result + agents[i]
    if i < agents.length() - 1 {
      result = result + ","
    }
  }
  result
}

/// 协商 / Negotiate.
pub fn negotiate(
  _protocol : CoordinationProtocol,
  proposal_a : String,
  proposal_b : String,
) -> String {
  if proposal_a == proposal_b {
    proposal_a
  } else {
    "compromise(" + proposal_a + "," + proposal_b + ")"
  }
}

///===
/// 拍卖 / Auction

/// 构造拍卖 / Make auction.
pub fn make_auction(
  auction_id : String,
  item : String,
  reserved_price : Double,
) -> Auction {
  { auction_id, item, bids: [], reserved_price, active: true }
}

/// 拍卖出价 / Auction bid.
pub fn auction_bid(auction : Auction, bidder : String, amount : Double) -> Auction {
  if !(auction.active) || amount < auction.reserved_price {
    return auction
  }
  let new_bids = auction.bids.copy()
  new_bids.push((bidder, amount))
  { ..auction, bids: new_bids }
}

/// 拍卖分配 / Auction allocate.
pub fn auction_allocate(auction : Auction) -> String? {
  if auction.bids.length() == 0 {
    return None
  }
  let mut best_idx = 0
  let mut best_amount = auction.bids[0].1
  for i in 1..<auction.bids.length() {
    if auction.bids[i].1 > best_amount {
      best_amount = auction.bids[i].1
      best_idx = i
    }
  }
  Some(auction.bids[best_idx].0)
}

/// 拍卖结果 / Auction result.
pub fn auction_result(auction : Auction) -> (String, Double) {
  if auction.bids.length() == 0 {
    return ("none", 0.0)
  }
  let mut best_idx = 0
  let mut best_amount = auction.bids[0].1
  for i in 1..<auction.bids.length() {
    if auction.bids[i].1 > best_amount {
      best_amount = auction.bids[i].1
      best_idx = i
    }
  }
  (auction.bids[best_idx].0, best_amount)
}

///===
/// 合约 / Contract

/// 构造合约 / Make contract.
pub fn make_contract(
  contract_id : String,
  parties : Array[String],
  terms : String,
) -> Contract {
  { contract_id, parties, terms, signed: [], active: false }
}

/// 签署合约 / Sign contract.
pub fn contract_sign(contract : Contract, party : String) -> Contract {
  let mut party_exists = false
  for i in 0..<contract.parties.length() {
    if contract.parties[i] == party {
      party_exists = true
    }
  }
  if !(party_exists) {
    return contract
  }
  let new_signed = contract.signed.copy()
  new_signed.push(party)
  let all_signed = new_signed.length() >= contract.parties.length()
  { ..contract, signed: new_signed, active: all_signed }
}

/// 验证合约 / Verify contract.
pub fn contract_verify(contract : Contract) -> Bool {
  if contract.parties.length() == 0 {
    return false
  }
  contract.signed.length() >= contract.parties.length()
}

/// 执行合约 / Execute contract.
pub fn contract_execute(contract : Contract) -> String {
  if !(contract_verify(contract)) {
    "contract_not_ready"
  } else {
    "execute:" + contract.terms
  }
}

///===
/// 任务分配 / Task allocation

/// 构造任务分配 / Make task allocation.
pub fn make_task_allocation(
  task_id : String,
  agent_id : String,
  task_desc : String,
  priority : Int,
) -> TaskAllocation {
  { task_id, agent_id, task_desc, priority, status: "pending" }
}

/// 分配任务 / Allocate task.
pub fn allocate_task(
  allocations : Array[TaskAllocation],
  allocation : TaskAllocation,
) -> Array[TaskAllocation] {
  let result = allocations.copy()
  result.push(allocation)
  result
}

/// 取消分配 / Deallocate task.
pub fn deallocate_task(
  allocations : Array[TaskAllocation],
  task_id : String,
) -> Array[TaskAllocation] {
  let result : Array[TaskAllocation] = []
  for i in 0..<allocations.length() {
    if allocations[i].task_id != task_id {
      result.push(allocations[i])
    }
  }
  result
}

///===
/// 共享状态 / Shared state

/// 构造共享状态 / Make shared state.
pub fn make_shared_state(state_id : String) -> SharedState {
  { state_id, data: [], version: 0 }
}

/// 读取共享 / Read shared.
pub fn read_shared(state : SharedState, key : String) -> String? {
  for i in 0..<state.data.length() {
    if state.data[i].0 == key {
      return Some(state.data[i].1)
    }
  }
  None
}

/// 写入共享 / Write shared.
pub fn write_shared(
  state : SharedState,
  key : String,
  value : String,
) -> SharedState {
  let new_data : Array[(String, String)] = []
  let mut found = false
  for i in 0..<state.data.length() {
    if state.data[i].0 == key {
      new_data.push((key, value))
      found = true
    } else {
      new_data.push(state.data[i])
    }
  }
  if !(found) {
    new_data.push((key, value))
  }
  { ..state, data: new_data, version: state.version + 1 }
}

/// 更新共享 / Update shared.
pub fn update_shared(
  state : SharedState,
  key : String,
  value : String,
) -> SharedState {
  write_shared(state, key, value)
}

///===
/// 共识 / Consensus

/// 构造共识 / Make consensus.
pub fn make_consensus(
  consensus_id : String,
  proposal : String,
  threshold : Double,
) -> Consensus {
  { consensus_id, proposal, votes: [], threshold }
}

/// 投票 / Consensus vote.
pub fn consensus_vote(consensus : Consensus, vote : Vote) -> Consensus {
  let new_votes = consensus.votes.copy()
  new_votes.push(vote)
  { ..consensus, votes: new_votes }
}

/// 是否达成共识 / Consensus reach.
pub fn consensus_reach(consensus : Consensus) -> Bool {
  if consensus.votes.length() == 0 {
    return false
  }
  let mut support_weight = 0.0
  let mut total_weight = 0.0
  for i in 0..<consensus.votes.length() {
    total_weight = total_weight + consensus.votes[i].weight
    if consensus.votes[i].support {
      support_weight = support_weight + consensus.votes[i].weight
    }
  }
  if total_weight == 0.0 {
    false
  } else {
    support_weight / total_weight >= consensus.threshold
  }
}

/// 共识结果 / Consensus result.
pub fn consensus_result(consensus : Consensus) -> (Bool, Double) {
  if consensus.votes.length() == 0 {
    return (false, 0.0)
  }
  let mut support_weight = 0.0
  let mut total_weight = 0.0
  for i in 0..<consensus.votes.length() {
    total_weight = total_weight + consensus.votes[i].weight
    if consensus.votes[i].support {
      support_weight = support_weight + consensus.votes[i].weight
    }
  }
  if total_weight == 0.0 {
    (false, 0.0)
  } else {
    let ratio = support_weight / total_weight
    (ratio >= consensus.threshold, ratio)
  }
}

///===
/// 黑板 / Blackboard

/// 构造黑板 / Make blackboard.
pub fn make_blackboard(blackboard_id : String) -> Blackboard {
  { blackboard_id, entries: [] }
}

/// 写入黑板 / Write blackboard.
pub fn blackboard_write(
  bb : Blackboard,
  key : String,
  value : String,
  confidence : Double,
) -> Blackboard {
  let new_entries : Array[(String, String, Double)] = []
  let mut found = false
  for i in 0..<bb.entries.length() {
    if bb.entries[i].0 == key {
      new_entries.push((key, value, confidence))
      found = true
    } else {
      new_entries.push(bb.entries[i])
    }
  }
  if !(found) {
    new_entries.push((key, value, confidence))
  }
  { ..bb, entries: new_entries }
}

/// 读取黑板 / Read blackboard.
pub fn blackboard_read(bb : Blackboard, key : String) -> String? {
  let mut best : String? = None
  let mut best_conf = -1.0
  for i in 0..<bb.entries.length() {
    if bb.entries[i].0 == key && bb.entries[i].2 > best_conf {
      best = Some(bb.entries[i].1)
      best_conf = bb.entries[i].2
    }
  }
  best
}

///===
/// 市场 / Market

/// 构造市场 / Make market.
pub fn make_market(market_id : String) -> Market {
  { market_id, bids: [], asks: [], cleared: false }
}

/// 市场买单 / Market bid.
pub fn market_bid(market : Market, order : MarketOrder) -> Market {
  let new_bids = market.bids.copy()
  new_bids.push(order)
  { ..market, bids: new_bids }
}

/// 市场卖单 / Market ask.
pub fn market_ask(market : Market, order : MarketOrder) -> Market {
  let new_asks = market.asks.copy()
  new_asks.push(order)
  { ..market, asks: new_asks }
}

/// 市场清算 / Market clear.
pub fn market_clear(market : Market) -> Market {
  let new_bids : Array[MarketOrder] = []
  let new_asks : Array[MarketOrder] = []
  for i in 0..<market.bids.length() {
    let mut matched = false
    for j in 0..<market.asks.length() {
      if market.bids[i].price >= market.asks[j].price && market.bids[i].quantity == market.asks[j].quantity {
        matched = true
      }
    }
    if !(matched) {
      new_bids.push(market.bids[i])
    }
  }
  for j in 0..<market.asks.length() {
    let mut matched = false
    for i in 0..<market.bids.length() {
      if market.bids[i].price >= market.asks[j].price && market.bids[i].quantity == market.asks[j].quantity {
        matched = true
      }
    }
    if !(matched) {
      new_asks.push(market.asks[j])
    }
  }
  { ..market, bids: new_bids, asks: new_asks, cleared: true }
}

///===
/// 联盟 / Coalition

/// 构造联盟 / Make coalition.
pub fn make_coalition(coalition_id : String, members : Array[String]) -> Coalition {
  { coalition_id, members, value: 0.0 }
}

/// 形成联盟 / Form coalition.
pub fn form_coalition(agents : Array[String], coalition_id : String) -> Coalition {
  { coalition_id, members: agents.copy(), value: agents.length().to_double() }
}

/// 联盟价值 / Coalition value.
pub fn coalition_value(coalition : Coalition) -> Double {
  let n = coalition.members.length().to_double()
  n * (n - 1.0) / 2.0
}

///===
/// 委托 / Delegation

/// 构造委托 / Make delegation.
pub fn make_delegation(
  delegation_id : String,
  delegator : String,
  delegatee : String,
  task : String,
) -> Delegation {
  { delegation_id, delegator, delegatee, task, accepted: false }
}

/// 委托任务 / Delegate task.
pub fn delegate_task(delegation : Delegation) -> Delegation {
  { ..delegation, accepted: false }
}

/// 接受委托 / Accept delegation.
pub fn accept_delegation(delegation : Delegation) -> Delegation {
  { ..delegation, accepted: true }
}

///===
/// 监督 / Supervision

/// 构造监督 / Make supervisor.
pub fn make_supervisor(
  supervisor_id : String,
  agent_id : String,
) -> SupervisionRecord {
  { supervisor_id, agent_id, status: "monitoring", intervention: "" }
}

/// 监督智能体 / Supervise agent.
pub fn supervise_agent(
  record : SupervisionRecord,
  status : String,
) -> SupervisionRecord {
  { ..record, status }
}

/// 干预 / Intervene.
pub fn intervene(record : SupervisionRecord, action : String) -> SupervisionRecord {
  { ..record, intervention: action, status: "intervened" }
}

///===
/// 层级 / Hierarchy

/// 构造层级 / Make hierarchy.
pub fn make_hierarchy(hierarchy_id : String) -> Hierarchy {
  { hierarchy_id, levels: [], parent_map: [] }
}

/// 层级委托 / Hierarchical delegate.
pub fn hierarchical_delegate(
  hierarchy : Hierarchy,
  agent : String,
  target : String,
) -> Hierarchy {
  let new_parent = hierarchy.parent_map.copy()
  new_parent.push((agent, target))
  let new_levels = hierarchy.levels.copy()
  let mut agent_found = false
  let mut target_found = false
  for i in 0..<new_levels.length() {
    if new_levels[i].0 == agent {
      agent_found = true
    }
    if new_levels[i].0 == target {
      target_found = true
    }
  }
  if !(agent_found) {
    new_levels.push((agent, 0))
  }
  if !(target_found) {
    new_levels.push((target, 1))
  }
  { ..hierarchy, levels: new_levels, parent_map: new_parent }
}

/// 层级报告 / Hierarchical report.
pub fn hierarchical_report(hierarchy : Hierarchy, agent : String) -> String {
  let mut parent : String? = None
  for i in 0..<hierarchy.parent_map.length() {
    if hierarchy.parent_map[i].0 == agent {
      parent = Some(hierarchy.parent_map[i].1)
    }
  }
  match parent {
    Some(p) => agent + "->" + p
    None => agent + "->top"
  }
}

///===
/// 联邦 / Federation

/// 构造联邦 / Make federation.
pub fn make_federation(federation_id : String) -> Federation {
  { federation_id, members: [], round: 0, aggregated_value: 0.0 }
}

/// 联邦智能体 / Federate agents.
pub fn federate_agents(
  federation : Federation,
  agents : Array[String],
) -> Federation {
  { ..federation, members: agents.copy() }
}

/// 联邦学习 / Federated learn.
pub fn federated_learn(
  federation : Federation,
  local_values : Array[Double],
) -> Federation {
  if local_values.length() == 0 {
    return { ..federation, round: federation.round + 1 }
  }
  let mut sum = 0.0
  for i in 0..<local_values.length() {
    sum = sum + local_values[i]
  }
  let avg = sum / local_values.length().to_double()
  { ..federation, round: federation.round + 1, aggregated_value: avg }
}

///===
/// 群体 / Swarm

/// 构造群体 / Make swarm.
pub fn make_swarm(swarm_id : String, behavior : String) -> Swarm {
  { swarm_id, agents: [], positions: [], behavior }
}

/// 群体行为 / Swarm behavior.
pub fn swarm_behavior(
  swarm : Swarm,
  agent : String,
  new_pos : (Double, Double),
) -> Swarm {
  let new_agents = swarm.agents.copy()
  let new_positions = swarm.positions.copy()
  let mut found = false
  for i in 0..<new_positions.length() {
    if new_positions[i].0 == agent {
      new_positions[i] = (agent, new_pos.0, new_pos.1)
      found = true
    }
  }
  if !(found) {
    new_agents.push(agent)
    new_positions.push((agent, new_pos.0, new_pos.1))
  }
  { ..swarm, agents: new_agents, positions: new_positions }
}

/// 群体智能 / Swarm intelligence.
pub fn swarm_intelligence(swarm : Swarm) -> (Double, Double) {
  if swarm.positions.length() == 0 {
    return (0.0, 0.0)
  }
  let mut sum_x = 0.0
  let mut sum_y = 0.0
  for i in 0..<swarm.positions.length() {
    sum_x = sum_x + swarm.positions[i].1
    sum_y = sum_y + swarm.positions[i].2
  }
  let n = swarm.positions.length().to_double()
  (sum_x / n, sum_y / n)
}

///===
/// 智能体交互 / Agent interaction

/// 智能体通信 / Agent communication.
pub fn agent_communication(
  sender : String,
  receiver : String,
  content : String,
) -> Message {
  { msg_id: "msg_" + sender + "_" + receiver, sender, receiver, content, timestamp: 0.0 }
}

/// 智能体协作 / Agent collaboration.
pub fn agent_collaboration(agents : Array[String], task : String) -> String {
  let mut result = "collaborate("
  for i in 0..<agents.length() {
    result = result + agents[i]
    if i < agents.length() - 1 {
      result = result + ","
    }
  }
  result = result + "):" + task
  result
}

/// 智能体竞争 / Agent competition.
pub fn agent_competition(agents : Array[String], reward : Double) -> String {
  let mut result = "compete("
  for i in 0..<agents.length() {
    result = result + agents[i]
    if i < agents.length() - 1 {
      result = result + ","
    }
  }
  let reward_tag = if reward > 0.0 { "positive" } else { "zero_or_neg" }
  result = result + "):" + reward_tag
  result
}

///===
/// 环境 / Environment

/// 构造环境 / Make environment.
pub fn make_environment(env_id : String) -> Environment {
  { env_id, state: [], reward: 0.0, step: 0 }
}

/// 环境观察 / Environment observe.
pub fn env_observe(env : Environment, key : String) -> String? {
  for i in 0..<env.state.length() {
    if env.state[i].0 == key {
      return Some(env.state[i].1)
    }
  }
  None
}

/// 环境行动 / Environment act.
pub fn env_act(
  env : Environment,
  action : String,
  key : String,
  value : String,
) -> Environment {
  let new_state : Array[(String, String)] = []
  let mut found = false
  for i in 0..<env.state.length() {
    if env.state[i].0 == key {
      new_state.push((key, value))
      found = true
    } else {
      new_state.push(env.state[i])
    }
  }
  if !(found) {
    new_state.push((key, value))
  }
  let bonus = if action == "reward" { 1.0 } else { 0.0 }
  let new_reward = env.reward + bonus
  { ..env, state: new_state, step: env.step + 1, reward: new_reward }
}

/// 环境多智能体奖励 / Environment multi-agent reward.
pub fn env_reward_multi(env : Environment, rewards : Array[Double]) -> Environment {
  let mut sum = 0.0
  for i in 0..<rewards.length() {
    sum = sum + rewards[i]
  }
  let avg = if rewards.length() == 0 {
    0.0
  } else {
    sum / rewards.length().to_double()
  }
  { ..env, reward: env.reward + avg }
}

///===
/// 模块标识 / Module id

pub fn multi_agent_id() -> String {
  "agent_kit/multi_agent"
}