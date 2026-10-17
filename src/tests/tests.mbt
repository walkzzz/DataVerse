///|
/// # tests 跨包测试 / Cross-package Tests
///
/// 跨包测试：算子鲁棒性、退化数据、一致性回归。架构 §5。
/// S0.2: kernel 四模式一致性回归测试 + 退化数据测试。
///
/// # Cross-package tests
///
/// Operator robustness, degenerate data, consistency regression.
/// See architecture §5. S0.2: kernel four-mode consistency + degenerate data tests.

test "kernel mode_name covers four modes" {
  assert_eq(@kernel.mode_name(@kernel.Exact), "exact")
  assert_eq(@kernel.mode_name(@kernel.Approx(42)), "approx(seed)")
  assert_eq(@kernel.mode_name(@kernel.Streaming), "streaming")
  assert_eq(@kernel.mode_name(@kernel.Cache), "cache")
}

test "kernel mode_consistency contract" {
  assert_eq(@kernel.mode_consistency(@kernel.Exact), @kernel.ByteExact)
  assert_eq(@kernel.mode_consistency(@kernel.Approx(7)), @kernel.SeededBound(7, 0.0))
  assert_eq(@kernel.mode_consistency(@kernel.Streaming), @kernel.WindowEquiv)
  assert_eq(@kernel.mode_consistency(@kernel.Cache), @kernel.CacheHitEquiv)
}

test "kernel mode_from_tag roundtrip" {
  assert_eq(@kernel.mode_from_tag("exact", 0), @kernel.Exact)
  assert_eq(@kernel.mode_from_tag("approx", 42), @kernel.Approx(42))
  assert_eq(@kernel.mode_from_tag("streaming", 0), @kernel.Streaming)
  assert_eq(@kernel.mode_from_tag("cache", 0), @kernel.Cache)
}

test "kernel mode_from_tag unknown degrades to exact" {
  // 退化策略：未知 tag 安全退化为 Exact（最严格一致性）
  assert_eq(@kernel.mode_from_tag("unknown", 0), @kernel.Exact)
  assert_eq(@kernel.mode_from_tag("", 0), @kernel.Exact)
}

test "kernel all_mode_tags aggregates four sub-packages" {
  let tags = @kernel.all_mode_tags()
  assert_eq(tags.length(), 4)
  assert_eq(tags[0], "exact")
  assert_eq(tags[1], "approx")
  assert_eq(tags[2], "streaming")
  assert_eq(tags[3], "cache")
}

test "kernel exact sub-package contract" {
  assert_eq(@exact.exact_id(), "kernel/exact")
  assert_eq(@exact.mode_tag(), "exact")
  assert_eq(@exact.consistency_guarantee(), "byte-exact")
  assert_true(@exact.handles_empty())
}

test "kernel approx sub-package contract" {
  assert_eq(@approx.approx_id(), "kernel/approx")
  assert_eq(@approx.mode_tag(), "approx")
  assert_eq(@approx.consistency_guarantee(), "seeded-bound")
  assert_eq(@approx.default_seed(), 42)
  assert_true(@approx.valid_seed(0))
  assert_true(@approx.valid_seed(100))
  assert_false(@approx.valid_seed(-1))
}

test "kernel streaming sub-package contract" {
  assert_eq(@streaming.streaming_id(), "kernel/streaming")
  assert_eq(@streaming.mode_tag(), "streaming")
  assert_eq(@streaming.consistency_guarantee(), "window-equiv")
  let w = @streaming.default_window()
  assert_eq(w.window_size, 100)
  assert_eq(w.slide, 100)
  assert_true(@streaming.valid_window(w))
}

test "kernel streaming sliding window" {
  let w = @streaming.sliding_window(200, 50)
  assert_eq(w.window_size, 200)
  assert_eq(w.slide, 50)
  assert_true(@streaming.valid_window(w))
  let bad = @streaming.sliding_window(0, 10)
  assert_false(@streaming.valid_window(bad))
}

test "kernel cache sub-package contract" {
  assert_eq(@cache.cache_id(), "kernel/cache")
  assert_eq(@cache.mode_tag(), "cache")
  assert_eq(@cache.consistency_guarantee(), "cache-hit-equiv")
}

test "kernel cache key fingerprint and hit" {
  let k1 = @cache.make_key("abc")
  assert_eq(k1.key, "abc")
  assert_eq(k1.fingerprint, "fp:abc")
  let k2 = @cache.make_key("abc")
  assert_true(@cache.is_hit(k1, k2))
  let k3 = @cache.make_key("xyz")
  assert_false(@cache.is_hit(k1, k3))
}

test "kernel degenerate: empty content cache key" {
  // 退化数据：空字符串安全处理
  let k = @cache.make_key("")
  assert_eq(k.key, "")
  assert_eq(k.fingerprint, "fp:")
}