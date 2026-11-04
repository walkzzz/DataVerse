///|
/// # Smoke tests - auto-generated
///
test "nlp_advanced_make_constituency_parser_smoke" {
  let _ = @nlp_ops.nlp_advanced_make_constituency_parser(["a", "b"])
}
///|
test "nlp_advanced_make_coref_smoke" {
  let _ = @nlp_ops.nlp_advanced_make_coref(1)
}
///|
test "nlp_advanced_make_dependency_parser_smoke" {
  let _ = @nlp_ops.nlp_advanced_make_dependency_parser(["a", "b"])
}
///|
test "nlp_advanced_make_dialog_manager_smoke" {
  let _ = @nlp_ops.nlp_advanced_make_dialog_manager()
}
///|
test "nlp_advanced_make_embedding_model_smoke" {
  let _ = @nlp_ops.nlp_advanced_make_embedding_model(1)
}
///|
test "nlp_advanced_make_entity_linker_smoke" {
  let _ = @nlp_ops.nlp_advanced_make_entity_linker(1)
}
///|
test "nlp_advanced_make_event_extractor_smoke" {
  let _ = @nlp_ops.nlp_advanced_make_event_extractor(["a", "b"])
}
///|
test "nlp_advanced_make_intent_recognizer_smoke" {
  let _ = @nlp_ops.nlp_advanced_make_intent_recognizer(["a", "b"])
}
///|
test "nlp_advanced_make_language_model_smoke" {
  let _ = @nlp_ops.nlp_advanced_make_language_model(1, 1)
}
///|
test "nlp_advanced_make_ner_smoke" {
  let _ = @nlp_ops.nlp_advanced_make_ner(["a", "b"])
}
