///|
/// # testing/fake — FAKE 退化测试框架 / Fake Data Test Framework
///
/// R16 阶段门禁第 2 手段：FAKE（假数据/退化数据）。
///
/// 提供退化数据生成器，统一管理五类退化场景：
/// 1. **空数据**（empty）— 空数组、空字符串、零长度
/// 2. **超长数据**（overflow）— 大数组、长字符串、溢出边界
/// 3. **乱码数据**（corrupt）— 非法字符、NaN、Inf、类型不匹配
/// 4. **模态缺失**（missing）— 缺失字段、null 值、默认值
/// 5. **边界值**（boundary）— 0、1、max_int、min_int、epsilon

///|
/// ============================================================================
/// 1. 空数据生成器 / Empty data generators
/// ============================================================================

///|
/// 空数组 / Empty array.
pub fn[T] fake_empty_array() -> Array[T] {
  []
}

///|
/// 空字符串 / Empty string.
pub fn fake_empty_string() -> String {
  ""
}

///|
/// 空 Double 数组 / Empty double array.
pub fn fake_empty_doubles() -> Array[Double] {
  []
}

///|
/// 空 Int 数组 / Empty int array.
pub fn fake_empty_ints() -> Array[Int32] {
  []
}

///|
/// 空字符串数组 / Empty string array.
pub fn fake_empty_strings() -> Array[String] {
  []
}

///|
/// ============================================================================
/// 2. 超长数据生成器 / Overflow data generators
/// ============================================================================

///|
/// 超长字符串（重复 N 次）/ Oversized string (repeated N times).
pub fn fake_long_string(n : Int32) -> String {
  let mut s = ""
  for _ in 0..<n {
    s = s + "x"
  }
  s
}

///|
/// 超长 Double 数组（N 个相同值）/ Oversized double array (N identical values).
pub fn fake_long_doubles(n : Int32, val : Double) -> Array[Double] {
  let result : Array[Double] = []
  for _ in 0..<n {
    result.push(val)
  }
  result
}

///|
/// 超长 Int 数组（0..N-1）/ Oversized int array (0..N-1).
pub fn fake_long_ints(n : Int32) -> Array[Int32] {
  let result : Array[Int32] = []
  for i in 0..<n {
    result.push(i)
  }
  result
}

///|
/// ============================================================================
/// 3. 乱码数据生成器 / Corrupt data generators
/// ============================================================================

///|
/// NaN 值 / NaN value.
pub fn fake_nan() -> Double {
  0.0 / 0.0
}

///|
/// 正无穷 / Positive infinity.
pub fn fake_inf() -> Double {
  1.0 / 0.0
}

///|
/// 负无穷 / Negative infinity.
pub fn fake_neg_inf() -> Double {
  -1.0 / 0.0
}

///|
/// 混合正常与异常值 / Mix normal and abnormal values.
pub fn fake_mixed_doubles() -> Array[Double] {
  [1.0, 0.0 / 0.0, 3.0, 1.0 / 0.0, -1.0 / 0.0, 5.0]
}

///|
/// 乱码字符串（控制字符）/ Corrupt string (control characters).
pub fn fake_corrupt_string() -> String {
  "\u0000\u0001\u0002\u0003\u0004\u0005"
}

///|
/// ============================================================================
/// 4. 模态缺失生成器 / Missing data generators
/// ============================================================================

///|
/// 全零向量 / All-zero vector.
pub fn fake_zero_vector(dim : Int32) -> Array[Double] {
  let result : Array[Double] = []
  for _ in 0..<dim {
    result.push(0.0)
  }
  result
}

///|
/// 单元素数组 / Single-element array.
pub fn fake_singleton(val : Double) -> Array[Double] {
  [val]
}

///|
/// 缺失 embedding 的文档 / Document with empty embedding.
pub fn fake_document_no_embedding(id : String, content : String) -> @retrieval.Document {
  @retrieval.make_document(id, content, [], "")
}

///|
/// 空 LLM 请求 / Empty LLM request.
pub fn fake_empty_llm_request() -> @llm.LLMRequest {
  @llm.make_request("mock", @llm.Local, [], 0, 0.0)
}

///|
/// ============================================================================
/// 5. 边界值生成器 / Boundary value generators
/// ============================================================================

///|
/// 边界值集合 / Boundary values for Double.
pub fn fake_boundary_doubles() -> Array[Double] {
  [0.0, 1.0, -1.0, 0.0000001, 999999.0, -999999.0]
}

///|
/// 边界值集合 / Boundary values for Int32.
pub fn fake_boundary_ints() -> Array[Int32] {
  [0, 1, -1, 2147483647, -2147483648]
}

///|
/// 极小正数 / Epsilon.
pub fn fake_epsilon() -> Double {
  0.0000001
}

///|
/// 极大正数 / Large value.
pub fn fake_large() -> Double {
  999999999.0
}

///|
/// ============================================================================
/// 6. 退化安全验证器 / Degenerate-safe validators
/// ============================================================================

///|
/// 验证函数对空输入退化安全 / Verify function is degenerate-safe on empty input.
///
/// 退化安全 = 不崩溃 + 返回合理默认值（0.0 / 空数组 / false）。
pub fn fake_assert_degenerate_safe_double(fn_ : (Array[Double]) -> Double, input : Array[Double], expected : Double) -> Bool {
  let result = fn_(input)
  result == expected
}

///|
/// 验证函数对空输入退化安全（返回数组）/ Verify function is degenerate-safe on empty input (returns array).
pub fn fake_assert_degenerate_safe_array(fn_ : (Array[Double]) -> Array[Double], input : Array[Double], expected_len : Int32) -> Bool {
  let result = fn_(input)
  result.length() == expected_len
}