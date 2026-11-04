///|
/// # Smoke tests - auto-generated
///
test "generative_generate_id_smoke" {
  let _ = @generative.generative_generate_id()
}
///|
test "generative_make_autoregressive_smoke" {
  let _ = @generative.generative_make_autoregressive(1, 1, 1, 1)
}
///|
test "generative_make_diffusion_smoke" {
  let _ = @generative.generative_make_diffusion(1, 1.0, 1.0, 1, 1)
}
///|
test "generative_make_discriminator_net_smoke" {
  let _ = @generative.generative_make_discriminator_net(1, 1, 1)
}
///|
test "generative_make_flow_model_smoke" {
  let _ = @generative.generative_make_flow_model(1, 1, 1)
}
///|
test "generative_make_gan_model_smoke" {
  let _ = @generative.generative_make_gan_model(1, 1, 1, 1.0, 1)
}
///|
test "generative_make_generator_net_smoke" {
  let _ = @generative.generative_make_generator_net(1, 1, 1, 1)
}
///|
test "generative_make_text_gan_smoke" {
  let _ = @generative.generative_make_text_gan(1, 1, 1, 1)
}
///|
test "generative_make_vae_model_smoke" {
  let _ = @generative.generative_make_vae_model(1, 1, 1, 1.0, 1)
}
///|
test "lpd_lpd_make_labeled_point_smoke" {
  let _ = @types.dv_make_labeled_point(1.0, 1.0, 1)
}
