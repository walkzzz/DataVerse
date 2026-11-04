///|
/// # Smoke tests - auto-generated
///
test "audio_audio_id_smoke" {
  let _ = @audio.audio_audio_id()
}
///|
test "audio_empty_audio_meta_smoke" {
  let _ = @audio.audio_empty_audio_meta()
}
///|
test "audio_make_audio_meta_smoke" {
  let _ = @audio.audio_make_audio_meta(1, 1, 1, "test")
}
///|
test "audio_proc_adv_audio_proc_adv_id_smoke" {
  let _ = @audio.audio_proc_adv_audio_proc_adv_id()
}
///|
test "audio_proc_adv_make_audio_adv_smoke" {
  let _ = @audio.audio_proc_adv_make_audio_adv([1.0, 2.0, 3.0], 1, 1)
}
///|
test "audio_s9_make_audio_signal_smoke" {
  let _ = @audio.audio_s9_make_audio_signal([1.0, 2.0, 3.0], 1)
}
