///===
/// agent_kit/dialogue 对话管理 / Dialogue Management
/// S12 Phase 12 — 对话状态跟踪/策略/意图识别/槽位填充
/// 对话系统：状态跟踪 + 策略学习 + 意图识别 + 槽位填充 + 响应生成

///===
/// 意图 / Intent

pub struct Intent {
  name : String
  confidence : Double
  slots : Array[Slot]
}

/// 构造意图
pub fn make_intent(name : String, confidence : Double) -> Intent {
  { name, confidence, slots: [] }
}

/// 意图带槽位
pub fn intent_with_slots(intent : Intent, slots : Array[Slot]) -> Intent {
  { name: intent.name, confidence: intent.confidence, slots }
}

/// 意图转字符串
pub fn intent_to_string(intent : Intent) -> String {
  let mut result = "Intent(" + intent.name + ", conf=" + double_to_string(intent.confidence) + ")"
  if array_length(intent.slots) > 0 {
    result = result + " slots:["
    for i in 0..<array_length(intent.slots) {
      if i > 0 {
        result = result + ", "
      }
      result = result + slot_to_string(intent.slots[i])
    }
    result = result + "]"
  }
  result
}

///===
/// 槽位 / Slot

pub struct Slot {
  name : String
  value : String
  confidence : Double
  required : Bool
}

/// 构造槽位
pub fn make_slot(name : String, value : String, confidence : Double) -> Slot {
  { name, value, confidence, required: false }
}

/// 必需槽位
pub fn required_slot(name : String) -> Slot {
  { name, value: "", confidence: 0.0, required: true }
}

/// 槽位转字符串
pub fn slot_to_string(slot : Slot) -> String {
  slot.name + "=" + slot.value + "(" + double_to_string(slot.confidence) + ")"
}

/// 槽位是否填充
pub fn slot_is_filled(slot : Slot) -> Bool {
  slot.value != "" && slot.confidence > 0.5
}

///===
/// 对话状态 / Dialogue state

pub struct DialogueState {
  turn : Int
  current_intent : String
  slots : Array[Slot]
  history : Array[String]
  context : Array[(String, String)]
  completed : Bool
}

/// 构造初始对话状态
pub fn make_dialogue_state() -> DialogueState {
  { turn: 0, current_intent: "", slots: [], history: [], context: [], completed: false }
}

/// 对话状态转字符串
pub fn dialogue_state_to_string(state : DialogueState) -> String {
  let mut result = "State(turn=" + int_to_string(state.turn) + ", intent=" + state.current_intent + ")"
  if array_length(state.slots) > 0 {
    result = result + " slots:["
    for i in 0..<array_length(state.slots) {
      if i > 0 {
        result = result + ", "
      }
      result = result + slot_to_string(state.slots[i])
    }
    result = result + "]"
  }
  if state.completed {
    result = result + " [completed]"
  }
  result
}

/// 更新对话状态
pub fn update_dialogue_state(state : DialogueState, intent : Intent, user_input : String) -> DialogueState {
  let new_turn = state.turn + 1
  let new_history = array_append_str(state.history, [user_input])
  let new_intent = if intent.confidence > 0.5 {
    intent.name
  } else {
    state.current_intent
  }
  let new_slots = merge_slots(state.slots, intent.slots)
  let all_filled = check_all_required(new_slots)
  { turn: new_turn, current_intent: new_intent, slots: new_slots, history: new_history, context: state.context, completed: all_filled }
}

/// 合并槽位
fn merge_slots(old : Array[Slot], new : Array[Slot]) -> Array[Slot] {
  let mut result = []
  let used = Array::make(array_length(new), false)
  for i in 0..<array_length(old) {
    let mut found = false
    for j in 0..<array_length(new) {
      if old[i].name == new[j].name {
        result = array_append_slot(result, [new[j]])
        used[j] = true
        found = true
      }
    }
    if !(found) {
      result = array_append_slot(result, [old[i]])
    }
  }
  for j in 0..<array_length(new) {
    if !(used[j]) {
      result = array_append_slot(result, [new[j]])
    }
  }
  result
}

/// 检查所有必需槽位是否填充
fn check_all_required(slots : Array[Slot]) -> Bool {
  for i in 0..<array_length(slots) {
    if slots[i].required && !(slot_is_filled(slots[i])) {
      return false
    }
  }
  true
}

///===
/// 意图识别 / Intent recognition

pub struct IntentClassifier {
  intents : Array[(String, Array[String])]
  threshold : Double
}

/// 构造意图分类器
pub fn make_intent_classifier(intents : Array[(String, Array[String])], threshold : Double) -> IntentClassifier {
  { intents, threshold }
}

/// 关键词匹配意图识别
pub fn classify_intent(classifier : IntentClassifier, text : String) -> Intent {
  let lower = to_lower(text)
  let mut best_intent = "unknown"
  let mut best_score = 0.0
  for i in 0..<array_length(classifier.intents) {
    let intent_name = classifier.intents[i].0
    let keywords = classifier.intents[i].1
    let mut score = 0.0
    for j in 0..<array_length(keywords) {
      if string_contains(lower, to_lower(keywords[j])) {
        score = score + 1.0
      }
    }
    score = score / int_to_double(array_length(keywords))
    if score > best_score {
      best_score = score
      best_intent = intent_name
    }
  }
  if best_score >= classifier.threshold {
    make_intent(best_intent, best_score)
  } else {
    make_intent("unknown", best_score)
  }
}

/// 多意图识别
pub fn classify_intents_multi(classifier : IntentClassifier, text : String) -> Array[Intent] {
  let lower = to_lower(text)
  let mut results = []
  for i in 0..<array_length(classifier.intents) {
    let intent_name = classifier.intents[i].0
    let keywords = classifier.intents[i].1
    let mut score = 0.0
    for j in 0..<array_length(keywords) {
      if string_contains(lower, to_lower(keywords[j])) {
        score = score + 1.0
      }
    }
    score = score / int_to_double(array_length(keywords))
    if score >= classifier.threshold {
      results = array_append_intent(results, [make_intent(intent_name, score)])
    }
  }
  results
}

///===
/// 槽位填充 / Slot filling

pub struct SlotFiller {
  slot_patterns : Array[(String, Array[String])]
}

/// 构造槽位填充器
pub fn make_slot_filler(slot_patterns : Array[(String, Array[String])]) -> SlotFiller {
  { slot_patterns }
}

/// 填充槽位
pub fn fill_slots(filler : SlotFiller, text : String, required_slots : Array[Slot]) -> Array[Slot] {
  let lower = to_lower(text)
  let mut filled = []
  for i in 0..<array_length(filler.slot_patterns) {
    let slot_name = filler.slot_patterns[i].0
    let patterns = filler.slot_patterns[i].1
    for j in 0..<array_length(patterns) {
      if string_contains(lower, to_lower(patterns[j])) {
        filled = array_append_slot(filled, [make_slot(slot_name, patterns[j], 1.0)])
      }
    }
  }
  for i in 0..<array_length(required_slots) {
    let mut found = false
    for j in 0..<array_length(filled) {
      if filled[j].name == required_slots[i].name {
        found = true
      }
    }
    if !(found) && required_slots[i].required {
      filled = array_append_slot(filled, [required_slot(required_slots[i].name)])
    }
  }
  filled
}

/// 检查缺失槽位
pub fn missing_slots(slots : Array[Slot]) -> Array[String] {
  let mut missing = []
  for i in 0..<array_length(slots) {
    if slots[i].required && !(slot_is_filled(slots[i])) {
      missing = array_append_str(missing, [slots[i].name])
    }
  }
  missing
}

///===
/// 对话策略 / Dialogue policy

pub struct DialoguePolicy {
  rules : Array[(String, String)]
  default_action : String
}

/// 构造对话策略
pub fn make_policy(rules : Array[(String, String)], default_action : String) -> DialoguePolicy {
  { rules, default_action }
}

/// 选择动作
pub fn select_action(policy : DialoguePolicy, state : DialogueState) -> String {
  if state.completed {
    return "confirm"
  }
  let missing = missing_slots(state.slots)
  if array_length(missing) > 0 {
    return "ask_" + missing[0]
  }
  for i in 0..<array_length(policy.rules) {
    if policy.rules[i].0 == state.current_intent {
      return policy.rules[i].1
    }
  }
  policy.default_action
}

///===
/// 响应生成 / Response generation

pub struct ResponseTemplate {
  action : String
  template : String
  variations : Array[String]
}

/// 构造响应模板
pub fn make_response_template(action : String, template : String, variations : Array[String]) -> ResponseTemplate {
  { action, template, variations }
}

/// 响应生成器
pub struct ResponseGenerator {
  templates : Array[ResponseTemplate]
  var_index : Int
}

/// 构造响应生成器
pub fn make_response_generator(templates : Array[ResponseTemplate]) -> ResponseGenerator {
  { templates, var_index: 0 }
}

/// 生成响应
pub fn generate_response(generator : ResponseGenerator, action : String, state : DialogueState) -> String {
  for i in 0..<array_length(generator.templates) {
    if generator.templates[i].action == action {
      let template = generator.templates[i].template
      let filled = fill_template(template, state)
      if array_length(generator.templates[i].variations) > 0 {
        let idx = generator.var_index % array_length(generator.templates[i].variations)
        let variation = generator.templates[i].variations[idx]
        return fill_template(variation, state)
      }
      return filled
    }
  }
  "I'm sorry, I didn't understand that."
}

/// 填充模板
fn fill_template(template : String, state : DialogueState) -> String {
  let mut result = template
  for i in 0..<array_length(state.slots) {
    let placeholder = "{" + state.slots[i].name + "}"
    result = result.replace(old=placeholder, new=state.slots[i].value)
  }
  result
}

///===
/// 对话上下文 / Dialogue context

pub struct DialogueContext {
  user_id : String
  session_id : String
  preferences : Array[(String, String)]
  memory : Array[(String, String)]
  max_memory : Int
}

/// 构造对话上下文
pub fn make_dialogue_context(user_id : String, session_id : String) -> DialogueContext {
  { user_id, session_id, preferences: [], memory: [], max_memory: 100 }
}

/// 添加记忆
pub fn add_context_memory(ctx : DialogueContext, key : String, value : String) -> DialogueContext {
  let mut new_memory = ctx.memory
  new_memory = array_append_pair(new_memory, [(key, value)])
  if array_length(new_memory) > ctx.max_memory {
    let mut trimmed = []
    let start = array_length(new_memory) - ctx.max_memory
    for i in start..<array_length(new_memory) {
      trimmed = array_append_pair(trimmed, [new_memory[i]])
    }
    new_memory = trimmed
  }
  { user_id: ctx.user_id, session_id: ctx.session_id, preferences: ctx.preferences, memory: new_memory, max_memory: ctx.max_memory }
}

/// 查询记忆
pub fn query_context_memory(ctx : DialogueContext, key : String) -> String {
  for i in 0..<array_length(ctx.memory) {
    if ctx.memory[i].0 == key {
      return ctx.memory[i].1
    }
  }
  ""
}

/// 设置偏好
pub fn set_preference(ctx : DialogueContext, key : String, value : String) -> DialogueContext {
  let mut new_prefs = []
  let mut found = false
  for i in 0..<array_length(ctx.preferences) {
    if ctx.preferences[i].0 == key {
      new_prefs = array_append_pair(new_prefs, [(key, value)])
      found = true
    } else {
      new_prefs = array_append_pair(new_prefs, [ctx.preferences[i]])
    }
  }
  if !(found) {
    new_prefs = array_append_pair(new_prefs, [(key, value)])
  }
  { user_id: ctx.user_id, session_id: ctx.session_id, preferences: new_prefs, memory: ctx.memory, max_memory: ctx.max_memory }
}

/// 获取偏好
pub fn get_preference(ctx : DialogueContext, key : String) -> String {
  for i in 0..<array_length(ctx.preferences) {
    if ctx.preferences[i].0 == key {
      return ctx.preferences[i].1
    }
  }
  ""
}

///===
/// 多轮对话管理器 / Multi-turn dialogue manager

pub struct DialogueManager {
  state : DialogueState
  policy : DialoguePolicy
  classifier : IntentClassifier
  filler : SlotFiller
  generator : ResponseGenerator
  required_slots : Array[Slot]
}

/// 构造对话管理器
pub fn make_dialogue_manager(
  policy : DialoguePolicy,
  classifier : IntentClassifier,
  filler : SlotFiller,
  generator : ResponseGenerator,
  required_slots : Array[Slot]
) -> DialogueManager {
  { state: make_dialogue_state(), policy, classifier, filler, generator, required_slots }
}

/// 处理用户输入
pub fn process_input(manager : DialogueManager, user_input : String) -> (DialogueManager, String) {
  let intent = classify_intent(manager.classifier, user_input)
  let slots = fill_slots(manager.filler, user_input, manager.required_slots)
  let intent_with_s = intent_with_slots(intent, slots)
  let new_state = update_dialogue_state(manager.state, intent_with_s, user_input)
  let action = select_action(manager.policy, new_state)
  let response = generate_response(manager.generator, action, new_state)
  let new_manager = { state: new_state, policy: manager.policy, classifier: manager.classifier, filler: manager.filler, generator: manager.generator, required_slots: manager.required_slots }
  (new_manager, response)
}

/// 重置对话
pub fn reset_dialogue(manager : DialogueManager) -> DialogueManager {
  { state: make_dialogue_state(), policy: manager.policy, classifier: manager.classifier, filler: manager.filler, generator: manager.generator, required_slots: manager.required_slots }
}

/// 对话是否完成
pub fn dialogue_is_complete(manager : DialogueManager) -> Bool {
  manager.state.completed
}

/// 获取当前状态
pub fn get_current_state(manager : DialogueManager) -> DialogueState {
  manager.state
}

///===
/// 对话评估 / Dialogue evaluation

/// 对话成功率
pub fn dialogue_success_rate(manager : DialogueManager) -> Double {
  if manager.state.turn == 0 {
    0.0
  } else if manager.state.completed {
    1.0
  } else {
    let filled = array_fold(manager.state.slots, 0, fn(acc, s) {
      if slot_is_filled(s) {
        acc + 1
      } else {
        acc
      }
    })
    int_to_double(filled) / int_to_double(array_length(manager.state.slots))
  }
}

/// 对话效率（完成轮数）
pub fn dialogue_efficiency(manager : DialogueManager) -> Double {
  if manager.state.turn == 0 {
    0.0
  } else if manager.state.completed {
    1.0 / int_to_double(manager.state.turn)
  } else {
    0.0
  }
}

/// 平均槽位填充率
pub fn slot_filling_rate(state : DialogueState) -> Double {
  if array_length(state.slots) == 0 {
    0.0
  } else {
    let mut filled = 0
    for i in 0..<array_length(state.slots) {
      if slot_is_filled(state.slots[i]) {
        filled = filled + 1
      }
    }
    int_to_double(filled) / int_to_double(array_length(state.slots))
  }
}

///===
/// 辅助函数 / Helper functions

fn to_lower(s : String) -> String {
  let mut result = ""
  for i in 0..<string_length(s) {
    let c = s[i]
    if c >= 65 && c <= 90 {
      result = result + String::from_array([Int::unsafe_to_char(c.to_int() + 32)])
    } else {
      result = result + String::from_array([Int::unsafe_to_char(c.to_int())])
    }
  }
  result
}

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

fn double_to_string(x : Double) -> String {
  let int_part = int_of_double(x)
  let frac = x - int_to_double(int_part)
  let frac_int = int_of_double(abs_double(frac) * 1000000.0)
  int_to_string(int_part) + "." + int_to_string(frac_int)
}

fn abs_double(x : Double) -> Double {
  if x < 0.0 {
    -x
  } else {
    x
  }
}

fn int_of_double(x : Double) -> Int {
  if x >= 0.0 {
    int_of_double_impl(x)
  } else {
    -int_of_double_impl(-x)
  }
}

fn int_of_double_impl(x : Double) -> Int {
  let mut n = 0
  let mut d = x
  while d >= 1.0 {
    n = n + 1
    d = d - 1.0
  }
  n
}

fn int_to_double(n : Int) -> Double {
  n.to_double()
}

fn int_to_string(n : Int) -> String {
  n.to_string()
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

fn array_append_slot(arr : Array[Slot], elem : Array[Slot]) -> Array[Slot] {
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

fn array_append_intent(arr : Array[Intent], elem : Array[Intent]) -> Array[Intent] {
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

fn[A, B] array_fold(arr : Array[A], init : B, f : (B, A) -> B) -> B {
  let mut result = init
  for i in 0..<array_length(arr) {
    result = f(result, arr[i])
  }
  result
}