///===
/// S12 Phase 12 新包测试 / New package tests

///|
///===
/// S12.1 opcore/statistics 统计分析测试
test "opcore/statistics mean" {
  let data = [1.0, 2.0, 3.0, 4.0, 5.0]
  let m = @statistics.mean(data)
  assert_true(m > 2.99 && m < 3.01)
}

///|
test "opcore/statistics median" {
  let data = [1.0, 2.0, 3.0, 4.0, 5.0]
  let m = @statistics.median(data)
  assert_true(m > 2.99 && m < 3.01)
}

///|
test "opcore/statistics variance" {
  let data = [1.0, 2.0, 3.0, 4.0, 5.0]
  let v = @statistics.variance(data)
  assert_true(v > 1.99 && v < 2.51)
}

///|
test "opcore/statistics std_dev" {
  let data = [1.0, 2.0, 3.0, 4.0, 5.0]
  let s = @statistics.std_dev(data)
  assert_true(s > 1.4 && s < 1.61)
}

///|
test "opcore/statistics sum" {
  let data = [1.0, 2.0, 3.0, 4.0, 5.0]
  let s = @statistics.sum(data)
  assert_true(s > 14.99 && s < 15.01)
}

///|
test "opcore/statistics min/max" {
  let data = [3.0, 1.0, 4.0, 1.0, 5.0]
  let lo = @statistics.min(data)
  let hi = @statistics.max(data)
  assert_true(lo > 0.99 && lo < 1.01)
  assert_true(hi > 4.99 && hi < 5.01)
}

///|
test "opcore/statistics range" {
  let data = [3.0, 1.0, 4.0, 1.0, 5.0]
  let r = @statistics.range(data)
  assert_true(r > 3.99 && r < 4.01)
}

///|
test "opcore/statistics z_score" {
  let data = [1.0, 2.0, 3.0, 4.0, 5.0]
  let z = @statistics.z_score(3.0, data)
  assert_true(z > -0.01 && z < 0.01)
}

///|
///===
/// S12.56 opcore/quantum_comp 量子计算测试
test "opcore/quantum_comp complex_add" {
  let a = @quantum_comp.make_complex(1.0, 2.0)
  let b = @quantum_comp.make_complex(3.0, 4.0)
  let c = @quantum_comp.cadd(a, b)
  assert_true(c.re > 3.99 && c.re < 4.01)
  assert_true(c.im > 5.99 && c.im < 6.01)
}

///|
test "opcore/quantum_comp complex_mul" {
  let a = @quantum_comp.make_complex(1.0, 2.0)
  let b = @quantum_comp.make_complex(3.0, 4.0)
  let c = @quantum_comp.cmul(a, b)
  assert_true(c.re > -5.01 && c.re < -4.99)
  assert_true(c.im > 9.99 && c.im < 10.01)
}

///|
test "opcore/quantum_comp complex_abs" {
  let a = @quantum_comp.make_complex(3.0, 4.0)
  let abs_val = @quantum_comp.cabs(a)
  assert_true(abs_val > 4.99 && abs_val < 5.01)
}

///|
test "opcore/quantum_comp complex_conj" {
  let a = @quantum_comp.make_complex(3.0, 4.0)
  let c = @quantum_comp.cconj(a)
  assert_true(c.re > 2.99 && c.re < 3.01)
  assert_true(c.im > -4.01 && c.im < -3.99)
}

///|
test "opcore/quantum_comp complex_scale" {
  let a = @quantum_comp.make_complex(3.0, 4.0)
  let c = @quantum_comp.cscale(a, 2.0)
  assert_true(c.re > 5.99 && c.re < 6.01)
  assert_true(c.im > 7.99 && c.im < 8.01)
}

///|
test "opcore/quantum_comp ket0" {
  let state = @quantum_comp.ket0()
  let p0 = @quantum_comp.probability(state, 0)
  let p1 = @quantum_comp.probability(state, 1)
  assert_true(p0 > 0.99 && p0 < 1.01)
  assert_true(p1 > -0.01 && p1 < 0.01)
}

///|
test "opcore/quantum_comp ket1" {
  let state = @quantum_comp.ket1()
  let p0 = @quantum_comp.probability(state, 0)
  let p1 = @quantum_comp.probability(state, 1)
  assert_true(p0 > -0.01 && p0 < 0.01)
  assert_true(p1 > 0.99 && p1 < 1.01)
}

///|
test "opcore/quantum_comp hadamard" {
  let state = @quantum_comp.ket0()
  let gate = @quantum_comp.hadamard_gate()
  let result = @quantum_comp.apply_gate(gate, state)
  let p0 = @quantum_comp.probability(result, 0)
  let p1 = @quantum_comp.probability(result, 1)
  assert_true(p0 > 0.49 && p0 < 0.51)
  assert_true(p1 > 0.49 && p1 < 0.51)
}

///|
test "opcore/quantum_comp pauli_x" {
  let state = @quantum_comp.ket0()
  let gate = @quantum_comp.pauli_x_gate()
  let result = @quantum_comp.apply_gate(gate, state)
  let p1 = @quantum_comp.probability(result, 1)
  assert_true(p1 > 0.99 && p1 < 1.01)
}

///|
test "opcore/quantum_comp bell_state" {
  let state = @quantum_comp.bell_state()
  let p0 = @quantum_comp.probability(state, 0)
  let p3 = @quantum_comp.probability(state, 3)
  assert_true(p0 > 0.49 && p0 < 0.51)
  assert_true(p3 > 0.49 && p3 < 0.51)
}

///|
///===
/// S12.57 learncore/neuro_symbolic 神经符号AI测试
test "learncore/neuro_symbolic make_predicate" {
  let p = @neuro_symbolic.make_predicate("likes", ["alice", "bob"])
  let s = @neuro_symbolic.predicate_to_string(p)
  assert_true(s.contains("likes"))
  assert_true(s.contains("alice"))
  assert_true(s.contains("bob"))
}

///|
test "learncore/neuro_symbolic predicate_eq" {
  let p1 = @neuro_symbolic.make_predicate("likes", ["alice", "bob"])
  let p2 = @neuro_symbolic.make_predicate("likes", ["alice", "bob"])
  let p3 = @neuro_symbolic.make_predicate("knows", ["alice", "bob"])
  assert_true(@neuro_symbolic.predicate_eq(p1, p2))
  assert_false(@neuro_symbolic.predicate_eq(p1, p3))
}

///|
test "learncore/neuro_symbolic ltn_and" {
  let result = @neuro_symbolic.ltn_and([0.8, 0.6, 0.9])
  assert_true(result > 0.43 && result < 0.44)
}

///|
test "learncore/neuro_symbolic ltn_or" {
  let result = @neuro_symbolic.ltn_or([0.3, 0.4])
  assert_true(result > 0.57 && result < 0.59)
}

///|
test "learncore/neuro_symbolic ltn_implies" {
  let result = @neuro_symbolic.ltn_implies(0.8, 0.6)
  assert_true(result > 0.67 && result < 0.69)
}

///|
test "learncore/neuro_symbolic ltn_not" {
  let result = @neuro_symbolic.ltn_not(0.7)
  assert_true(result > 0.29 && result < 0.31)
}

///|
test "learncore/neuro_symbolic t_norm_product" {
  let result = @neuro_symbolic.t_norm_product(0.5, 0.6)
  assert_true(result > 0.29 && result < 0.31)
}

///|
test "learncore/neuro_symbolic t_norm_min" {
  let result = @neuro_symbolic.t_norm_min(0.5, 0.6)
  assert_true(result > 0.49 && result < 0.51)
}

///|
test "learncore/neuro_symbolic t_conorm_max" {
  let result = @neuro_symbolic.t_conorm_max(0.5, 0.6)
  assert_true(result > 0.59 && result < 0.61)
}

///|
test "learncore/neuro_symbolic make_triple" {
  let t = @neuro_symbolic.make_triple("alice", "likes", "bob")
  let s = @neuro_symbolic.triple_to_string(t)
  assert_true(s.contains("alice"))
  assert_true(s.contains("likes"))
  assert_true(s.contains("bob"))
}

///|
test "learncore/neuro_symbolic kg_query" {
  let triples = [
    @neuro_symbolic.make_triple("alice", "likes", "bob"),
    @neuro_symbolic.make_triple("bob", "likes", "charlie"),
  ]
  let kg = @neuro_symbolic.make_knowledge_graph(triples)
  let results = @neuro_symbolic.kg_query(kg, "alice", "likes")
  assert_eq(results.length(), 1)
  assert_eq(results[0], "bob")
}

///|
///===
/// S12.58 agent_kit/dialogue 对话管理测试
test "agent_kit/dialogue make_intent" {
  let intent = @dialogue.make_intent("greeting", 0.9)
  let s = @dialogue.intent_to_string(intent)
  assert_true(s.contains("greeting"))
}

///|
test "agent_kit/dialogue make_slot" {
  let slot = @dialogue.make_slot("name", "Alice", 0.95)
  let filled = @dialogue.slot_is_filled(slot)
  assert_true(filled)
}

///|
test "agent_kit/dialogue required_slot" {
  let slot = @dialogue.required_slot("name")
  let filled = @dialogue.slot_is_filled(slot)
  assert_false(filled)
}

///|
test "agent_kit/dialogue slot_to_string" {
  let slot = @dialogue.make_slot("name", "Alice", 0.95)
  let s = @dialogue.slot_to_string(slot)
  assert_true(s.contains("name"))
  assert_true(s.contains("Alice"))
}

///|
test "agent_kit/dialogue state_init" {
  let state = @dialogue.make_dialogue_state()
  let s = @dialogue.dialogue_state_to_string(state)
  assert_true(s.contains("turn=0"))
}

///|
test "agent_kit/dialogue update_state" {
  let state = @dialogue.make_dialogue_state()
  let intent = @dialogue.make_intent("book_flight", 0.95)
  let new_state = @dialogue.update_dialogue_state(
    state, intent, "I want to book a flight",
  )
  assert_eq(new_state.turn, 1)
}

///|
test "agent_kit/dialogue state_with_slots" {
  let state = @dialogue.make_dialogue_state()
  let intent = @dialogue.make_intent("search", 0.9)
  let slots = [@dialogue.make_slot("query", "hotels", 0.95)]
  let intent_with_s = @dialogue.intent_with_slots(intent, slots)
  let new_state = @dialogue.update_dialogue_state(
    state, intent_with_s, "search hotels",
  )
  assert_eq(new_state.turn, 1)
}

///|
test "agent_kit/dialogue context" {
  let ctx = @dialogue.make_dialogue_context("user1", "session1")
  let updated = @dialogue.add_context_memory(ctx, "last_query", "hotels")
  let memory = @dialogue.query_context_memory(updated, "last_query")
  assert_eq(memory, "hotels")
}

///|
test "agent_kit/dialogue preference" {
  let ctx = @dialogue.make_dialogue_context("user1", "session1")
  let updated = @dialogue.set_preference(ctx, "language", "en")
  let pref = @dialogue.get_preference(updated, "language")
  assert_eq(pref, "en")
}

///|
///===
/// S12.59 dataobject/metadata_ext 元数据管理测试
test "dataobject/metadata_ext make_field" {
  let field = @metadata_ext.make_metadata_field("age", "int")
  let s = @metadata_ext.field_to_string(field)
  assert_true(s.contains("age"))
  assert_true(s.contains("int"))
}

///|
test "dataobject/metadata_ext field_nullable" {
  let field = @metadata_ext.make_metadata_field("age", "int")
  let field2 = @metadata_ext.field_with_nullable(field, false)
  let s = @metadata_ext.field_to_string(field2)
  assert_false(s.contains("?"))
}

///|
test "dataobject/metadata_ext make_schema" {
  let fields = [
    @metadata_ext.make_metadata_field("name", "string"),
    @metadata_ext.make_metadata_field("age", "int"),
  ]
  let schema = @metadata_ext.make_metadata_schema("User", fields)
  let count = @metadata_ext.schema_field_count(schema)
  assert_eq(count, 2)
}

///|
test "dataobject/metadata_ext schema_find_field" {
  let fields = [
    @metadata_ext.make_metadata_field("name", "string"),
    @metadata_ext.make_metadata_field("age", "int"),
  ]
  let schema = @metadata_ext.make_metadata_schema("User", fields)
  let idx = @metadata_ext.schema_find_field(schema, "age")
  assert_eq(idx, 1)
}

///|
test "dataobject/metadata_ext make_instance" {
  let inst = @metadata_ext.make_metadata_instance("User", [
    ("name", "Alice"),
    ("age", "30"),
  ])
  let name = @metadata_ext.instance_get(inst, "name")
  assert_eq(name, "Alice")
}

///|
test "dataobject/metadata_ext instance_set" {
  let inst = @metadata_ext.make_metadata_instance("User", [])
  let updated = @metadata_ext.instance_set(inst, "name", "Bob")
  let name = @metadata_ext.instance_get(updated, "name")
  assert_eq(name, "Bob")
}

///|
test "dataobject/metadata_ext validate" {
  let fields = [@metadata_ext.make_metadata_field("name", "string")]
  let schema = @metadata_ext.make_metadata_schema("User", fields)
  let inst = @metadata_ext.make_metadata_instance("User", [("name", "Alice")])
  let result = @metadata_ext.validate_instance(schema, inst)
  assert_true(result.valid)
}

///|
test "dataobject/metadata_ext catalog" {
  let catalog = @metadata_ext.make_metadata_catalog("Test catalog")
  let count = @metadata_ext.catalog_schema_count(catalog)
  assert_eq(count, 0)
}

///|
test "dataobject/metadata_ext catalog_register" {
  let fields = [@metadata_ext.make_metadata_field("name", "string")]
  let schema = @metadata_ext.make_metadata_schema("User", fields)
  let catalog = @metadata_ext.make_metadata_catalog("Test catalog")
  let updated = @metadata_ext.catalog_register_schema(catalog, schema)
  let count = @metadata_ext.catalog_schema_count(updated)
  assert_eq(count, 1)
}

///|
test "dataobject/metadata_ext index" {
  let index = @metadata_ext.make_metadata_index()
  let size = @metadata_ext.index_size(index)
  assert_eq(size, 0)
}

///|
test "dataobject/metadata_ext lineage" {
  let graph = @metadata_ext.make_lineage_graph()
  let node = @metadata_ext.make_lineage_node("n1", "table", "users")
  let updated = @metadata_ext.lineage_add_node(graph, node)
  assert_eq(updated.nodes.length(), 1)
}

///|
test "dataobject/metadata_ext search_query" {
  let query = @metadata_ext.make_search_query()
  let query2 = @metadata_ext.search_with_limit(query, 10)
  assert_eq(query2.limit, 10)
}
