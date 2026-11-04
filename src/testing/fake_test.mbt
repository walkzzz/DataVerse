///|
/// # testing/fake 测试 — FAKE 退化数据测试
///
/// 验证关键算子对五类退化数据的处理：
/// 1. 空数据 — 不崩溃，返回默认值
/// 2. 超长数据 — 不溢出，结果合理
/// 3. 乱码数据 — NaN/Inf 处理安全
/// 4. 模态缺失 — 空 embedding/空请求 处理安全
/// 5. 边界值 — 0/1/max/min 处理正确

///|
/// ============================================================================
/// 1. 空数据退化测试
/// ============================================================================

///|
/// 测试 mse 对空数组退化安全
test "fake: mse empty_safe" {
  let result = @ml.metrics_mse(@testing.fake_empty_doubles(), @testing.fake_empty_doubles())
  proof_assert result == 0.0
}

///|
/// 测试 mae 对空数组退化安全
test "fake: mae empty_safe" {
  let result = @ml.metrics_mae(@testing.fake_empty_doubles(), @testing.fake_empty_doubles())
  proof_assert result == 0.0
}

///|
/// 测试 softmax 对空数组退化安全
test "fake: softmax empty_safe" {
  let result = @dl.dl_layers_softmax(@testing.fake_empty_doubles())
  proof_assert result.length() == 0
}

///|
/// 测试 softmax 对单元素退化安全
test "fake: softmax singleton_safe" {
  let result = @dl.dl_layers_softmax(@testing.fake_singleton(5.0))
  proof_assert result.length() == 1
  proof_assert result[0] > 0.99 && result[0] < 1.01
}

///|
/// 测试 euclidean_distance 对同点退化安全
test "fake: euclidean_distance same_point_safe" {
  let a = @spatial.proximity_make_point(0.0, 0.0)
  proof_assert @spatial.proximity_euclidean_distance(a, a) == 0.0
}

///|
/// ============================================================================
/// 2. 超长数据退化测试
/// ============================================================================

///|
/// 测试 mse 对超长数组处理
test "fake: mse long_array_safe" {
  let pred = @testing.fake_long_doubles(1000, 1.0)
  let actual = @testing.fake_long_doubles(1000, 2.0)
  let result = @ml.metrics_mse(pred, actual)
  proof_assert result >= 0.0
  proof_assert result > 0.99 && result < 1.01
}

///|
/// 测试 softmax 对超长数组处理
test "fake: softmax long_array_safe" {
  let input = @testing.fake_long_doubles(100, 1.0)
  let result = @dl.dl_layers_softmax(input)
  proof_assert result.length() == 100
  let mut sum = 0.0
  for i in 0..<result.length() {
    sum = sum + result[i]
  }
  proof_assert sum > 0.99 && sum < 1.01
}

///|
/// ============================================================================
/// 3. 乱码数据退化测试
/// ============================================================================

///|
/// 测试 mse 对含 NaN 的数组处理
test "fake: mse with_nan_safe" {
  let pred = [1.0, 2.0, 3.0]
  let actual = [1.0, @testing.fake_nan(), 3.0]
  let result = @ml.metrics_mse(pred, actual)
  // NaN 传播：结果应为 NaN 或非负
  proof_assert !(result == result) || result >= 0.0
}

///|
/// 测试 softmax 对含 Inf 的数组处理
test "fake: softmax with_inf_safe" {
  let input = [1.0, @testing.fake_inf(), 3.0]
  let result = @dl.dl_layers_softmax(input)
  proof_assert result.length() == 3
}

///|
/// ============================================================================
/// 4. 模态缺失退化测试
/// ============================================================================

///|
/// 测试空 embedding 文档构造
test "fake: document no_embedding_safe" {
  let doc = @testing.fake_document_no_embedding("d1", "test content")
  proof_assert doc.id == "d1"
  proof_assert doc.content == "test content"
  proof_assert doc.embedding.length() == 0
}

///|
/// 测试空 LLM 请求构造
test "fake: empty_llm_request_safe" {
  let req = @testing.fake_empty_llm_request()
  proof_assert req.model == "mock"
  proof_assert req.messages.length() == 0
  proof_assert req.max_tokens == 0
}

///|
/// 测试零向量 cosine_similarity
test "fake: cosine_similarity zero_vectors_safe" {
  let v1 = @testing.fake_zero_vector(5)
  let v2 = @testing.fake_zero_vector(5)
  let result = @retrieval.cosine_similarity(v1, v2)
  // 零向量 cosine 应为 0 或 NaN（分母为 0）
  proof_assert result == 0.0 || !(result == result)
}

///|
/// ============================================================================
/// 5. 边界值退化测试
/// ============================================================================

///|
/// 测试 mse 边界值（完全匹配 → 0）
test "fake: mse boundary_exact_match" {
  let pred = [1.0, 2.0, 3.0]
  let actual = [1.0, 2.0, 3.0]
  let result = @ml.metrics_mse(pred, actual)
  proof_assert result == 0.0
}

///|
/// 测试 mse 边界值（完全相反 → 最大误差）
test "fake: mse boundary_max_diff" {
  let pred = [@testing.fake_large(), @testing.fake_large()]
  let actual = [-@testing.fake_large(), -@testing.fake_large()]
  let result = @ml.metrics_mse(pred, actual)
  proof_assert result >= 0.0
}

///|
/// 测试 euclidean_distance 边界值（极小距离）
test "fake: euclidean_distance boundary_epsilon" {
  let a = @spatial.proximity_make_point(0.0, 0.0)
  let b = @spatial.proximity_make_point(@testing.fake_epsilon(), 0.0)
  let d = @spatial.proximity_euclidean_distance(a, b)
  proof_assert d >= 0.0
  proof_assert d <= @testing.fake_epsilon() * 1.01
}

///|
/// 测试 softmax 边界值（全相同 → 均匀分布）
test "fake: softmax boundary_uniform" {
  let input = @testing.fake_long_doubles(5, 3.0)
  let result = @dl.dl_layers_softmax(input)
  proof_assert result.length() == 5
  // 均匀分布：每个元素 ≈ 1/5 = 0.2
  for i in 0..<5 {
    proof_assert result[i] > 0.19 && result[i] < 0.21
  }
}