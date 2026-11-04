///|
/// # Smoke tests - auto-generated
///
test "neuro_symbolic_make_extracted_rule_smoke" {
  let _ = @lnlp.neuro_symbolic_make_extracted_rule(["a", "b"], "test", 1.0, 1)
}
///|
test "neuro_symbolic_make_ltn_predicate_smoke" {
  let _ = @lnlp.neuro_symbolic_make_ltn_predicate("test", [1.0, 2.0, 3.0], 1.0)
}
///|
test "neuro_symbolic_make_ltn_variable_smoke" {
  let _ = @lnlp.neuro_symbolic_make_ltn_variable("test", 1.0, true)
}
///|
test "neuro_symbolic_make_predicate_smoke" {
  let _ = @lnlp.neuro_symbolic_make_predicate("test", ["a", "b"])
}
///|
test "neuro_symbolic_make_triple_smoke" {
  let _ = @lnlp.neuro_symbolic_make_triple("test", "test", "test")
}
///|
test "nlp_make_bert_config_smoke" {
  let _ = @lnlp.nlp_make_bert_config(1, 1, 1, 1)
}
///|
test "nlp_make_gpt_config_smoke" {
  let _ = @lnlp.nlp_make_gpt_config(1, 1, 1, 1)
}
///|
test "nlp_nlp_id_smoke" {
  let _ = @lnlp.nlp_nlp_id()
}
