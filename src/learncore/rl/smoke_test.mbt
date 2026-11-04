///|
/// # Smoke tests - auto-generated
///
test "reinforcement_make_actor_critic_config_smoke" {
  let _ = @rl.reinforcement_make_actor_critic_config(1.0, 1.0, 1.0)
}
///|
test "reinforcement_make_experience_replay_smoke" {
  let _ = @rl.reinforcement_make_experience_replay(1)
}
///|
test "reinforcement_reinforcement_id_smoke" {
  let _ = @rl.reinforcement_reinforcement_id()
}
///|
test "rl_ext_make_a2c_smoke" {
  let _ = @rl.rl_ext_make_a2c(1, 1.0, 1.0, 1.0)
}
///|
test "rl_ext_make_actor_critic_smoke" {
  let _ = @rl.rl_ext_make_actor_critic(1, 1.0, 1.0, 1.0)
}
///|
test "rl_ext_make_agent_smoke" {
  let _ = @rl.rl_ext_make_agent(1, 1, 1.0, 1.0, 1.0)
}
///|
test "rl_ext_make_buffer_smoke" {
  let _ = @rl.rl_ext_make_buffer(1)
}
///|
test "rl_ext_make_dqn_smoke" {
  let _ = @rl.rl_ext_make_dqn(1, 1.0, 1.0)
}
///|
test "rl_ext_make_env_wrapper_smoke" {
  let _ = @rl.rl_ext_make_env_wrapper(1, 1)
}
///|
test "rl_ext_make_episode_smoke" {
  let _ = @rl.rl_ext_make_episode()
}
