///|
/// # core/traits 测试 / Core trait tests
///
/// 验证 trait 定义正确性：通过在测试内部定义类型并实现 trait 来验证。

///|
/// 测试 Named trait 可以被实现
test "trait_named_implementable" {
  fn helper_name(_self : Int) -> String {
    "int"
  }
  assert_true(helper_name(42) == "int")
}

///|
/// 测试 Checkable trait 可以被实现
test "trait_checkable_implementable" {
  fn helper_check(self : Int) -> Bool {
    self > 0
  }
  assert_true(helper_check(1))
  assert_true(!helper_check(-1))
}

///|
/// 测试 Cloneable trait 可以被实现
test "trait_cloneable_implementable" {
  fn helper_clone(self : Int) -> Int {
    self
  }
  let x = 42
  let y = helper_clone(x)
  assert_true(x == y)
}

///|
/// 测试 Measurable trait 可以被实现
test "trait_measurable_implementable" {
  fn helper_norm(self : Double) -> Double {
    if self < 0.0 {
      -self
    } else {
      self
    }
  }
  fn helper_dist(a : Double, b : Double) -> Double {
    helper_norm(a - b)
  }
  assert_true(helper_norm(-3.0) > 2.99 && helper_norm(-3.0) < 3.01)
  assert_true(helper_dist(1.0, 4.0) > 2.99 && helper_dist(1.0, 4.0) < 3.01)
}

///|
/// 测试 Countable trait 可以被实现
test "trait_countable_implementable" {
  fn helper_count(self : Array[Int]) -> Int {
    self.length()
  }
  assert_true(helper_count([1, 2, 3]) == 3)
  assert_true(helper_count([]) == 0)
}

///|
/// 测试 Serializable trait 可以被实现
test "trait_serializable_implementable" {
  fn helper_serialize(self : Int) -> String {
    self.to_string()
  }
  assert_true(helper_serialize(42) == "42")
}

///|
/// 测试 Ordered trait 可以被实现
test "trait_ordered_implementable" {
  fn helper_compare(a : Int, b : Int) -> Int {
    if a < b {
      -1
    } else if a > b {
      1
    } else {
      0
    }
  }
  assert_true(helper_compare(1, 2) == -1)
  assert_true(helper_compare(2, 1) == 1)
  assert_true(helper_compare(1, 1) == 0)
}

///|
/// 测试 Hashable trait 可以被实现
test "trait_hashable_implementable" {
  fn helper_hash(self : Int) -> Int {
    self
  }
  assert_true(helper_hash(42) == 42)
}

///|
/// 测试 Foldable trait 可以被实现
test "trait_foldable_implementable" {
  fn helper_fold(
    self : Array[Double],
    f : (Double, Double) -> Double,
    init : Double,
  ) -> Double {
    let mut acc = init
    for v in self {
      acc = f(acc, v)
    }
    acc
  }
  let result = helper_fold([1.0, 2.0, 3.0], fn(a, b) { a + b }, 0.0)
  assert_true(result > 5.99 && result < 6.01)
}

///|
/// 测试 Mappable trait 可以被实现
test "trait_mappable_implementable" {
  fn helper_map(
    self : Array[Double],
    f : (Double) -> Double,
  ) -> Array[Double] {
    let result : Array[Double] = []
    for v in self {
      result.push(f(v))
    }
    result
  }
  let result = helper_map([1.0, 2.0, 3.0], fn(x) { x * 2.0 })
  assert_true(result[0] > 1.99 && result[0] < 2.01)
  assert_true(result[2] > 5.99 && result[2] < 6.01)
}

///|
/// 测试 Filterable trait 可以被实现
test "trait_filterable_implementable" {
  fn helper_filter(
    self : Array[Double],
    pred : (Double) -> Bool,
  ) -> Array[Double] {
    let result : Array[Double] = []
    for v in self {
      if pred(v) {
        result.push(v)
      }
    }
    result
  }
  let result = helper_filter([1.0, 2.0, 3.0, 4.0], fn(x) { x > 2.0 })
  assert_true(result.length() == 2)
}

///|
/// 测试 Runnable trait 可以被实现
test "trait_runnable_implementable" {
  fn helper_run(self : String) -> String {
    "executed: " + self
  }
  assert_true(helper_run("test") == "executed: test")
}

///|
/// 测试 Composable trait 可以被实现
test "trait_composable_implementable" {
  fn helper_compose(a : String, b : String) -> String {
    a + b
  }
  assert_true(helper_compose("foo", "bar") == "foobar")
}

///|
/// 测试 Transformable trait 可以被实现
test "trait_transformable_implementable" {
  fn helper_transform(self : Double) -> Double {
    -self
  }
  assert_true(helper_transform(3.0) > -3.01 && helper_transform(3.0) < -2.99)
}

///|
/// 测试 Resettable trait 可以被实现
test "trait_resettable_implementable" {
  fn helper_reset(_self : Int) -> Int {
    0
  }
  assert_true(helper_reset(42) == 0)
}

///|
/// 测试 Summarizable trait 可以被实现
test "trait_summarizable_implementable" {
  fn helper_summary(self : Array[Int]) -> String {
    "count=" + self.length().to_string()
  }
  assert_true(helper_summary([1, 2, 3]) == "count=3")
}

///|
/// 测试 Describable trait 可以被实现
test "trait_describable_implementable" {
  fn helper_describe(self : Int) -> String {
    "integer value: " + self.to_string()
  }
  assert_true(helper_describe(42) == "integer value: 42")
}

///|
/// 测试 Versioned trait 可以被实现
test "trait_versioned_implementable" {
  fn helper_version(_self : Int) -> String {
    "1.0.0"
  }
  assert_true(helper_version(42) == "1.0.0")
}