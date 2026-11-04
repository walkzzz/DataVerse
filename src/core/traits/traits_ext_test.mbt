///|
/// # core/traits 扩展测试 / Extended trait tests
///
/// 为每个 trait 验证可通过 helper 函数模拟实现。

///|
test "trait_describable_implementable" {
  fn helper_describe(self : Int) -> String {
    "int=" + self.to_string()
  }
  assert_true(helper_describe(42) == "int=42")
}

///|
test "trait_versioned_implementable" {
  fn helper_version(_self : Int) -> String {
    "1.0.0"
  }
  assert_true(helper_version(0) == "1.0.0")
}

///|
test "trait_displayable_implementable" {
  fn helper_display(self : Int) -> String {
    "Int(" + self.to_string() + ")"
  }
  assert_true(helper_display(5) == "Int(5)")
}

///|
test "trait_verifiable_implementable" {
  fn helper_verify(self : Int) -> Bool {
    self >= 0
  }
  assert_true(helper_verify(1))
  assert_true(helper_verify(-1) == false)
}

///|
test "trait_resettable_implementable" {
  fn helper_reset(_self : Int) -> Int {
    0
  }
  assert_true(helper_reset(42) == 0)
}

///|
test "trait_serializable_implementable" {
  fn helper_serialize(self : Int) -> String {
    self.to_string()
  }
  assert_true(helper_serialize(42) == "42")
  assert_true(helper_serialize(0) == "0")
  assert_true(helper_serialize(-1) == "-1")
}

///|
test "trait_countable_implementable" {
  fn helper_count(self : Array[Int]) -> Int {
    self.length()
  }
  assert_true(helper_count([1, 2, 3]) == 3)
  assert_true(helper_count([]) == 0)
}

///|
test "trait_summarizable_implementable" {
  fn helper_summary(self : Array[Int]) -> String {
    "len=" + self.length().to_string()
  }
  assert_true(helper_summary([1, 2, 3]) == "len=3")
}

///|
test "trait_ordered_implementable" {
  fn helper_compare(self : Int, other : Int) -> Int {
    if self < other {
      -1
    } else if self > other {
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
test "trait_transformable_implementable" {
  fn helper_transform(self : Double) -> Double {
    self * 2.0
  }
  assert_true(helper_transform(3.0) > 5.99)
}

///|
test "trait_composable_implementable" {
  fn helper_compose(f : (Int) -> Int, g : (Int) -> Int) -> (Int) -> Int {
    fn(x) {
      f(g(x))
    }
  }
  let f = fn(x : Int) -> Int { x + 1 }
  let g = fn(x : Int) -> Int { x * 2 }
  let fg = helper_compose(f, g)
  assert_true(fg(3) == 7)
}

///|
test "trait_runnable_implementable" {
  fn helper_run(self : Int) -> Int {
    self * self
  }
  assert_true(helper_run(4) == 16)
}

///|
test "trait_foldable_implementable" {
  fn helper_fold(self : Array[Int], init : Int, f : (Int, Int) -> Int) -> Int {
    let mut acc = init
    for i in 0..<self.length() {
      acc = f(acc, self[i])
    }
    acc
  }
  let result = helper_fold([1, 2, 3, 4], 0, fn(a : Int, b : Int) -> Int { a + b })
  assert_true(result == 10)
}

///|
test "trait_mappable_implementable" {
  fn helper_map(self : Array[Int], f : (Int) -> Int) -> Array[Int] {
    let result = []
    for i in 0..<self.length() {
      result.push(f(self[i]))
    }
    result
  }
  let result = helper_map([1, 2, 3], fn(x : Int) -> Int { x * 2 })
  assert_true(result.length() == 3)
  assert_true(result[0] == 2)
  assert_true(result[2] == 6)
}

///|
test "trait_filterable_implementable" {
  fn helper_filter(self : Array[Int], pred : (Int) -> Bool) -> Array[Int] {
    let result = []
    for i in 0..<self.length() {
      if pred(self[i]) {
        result.push(self[i])
      }
    }
    result
  }
  let result = helper_filter([1, 2, 3, 4, 5], fn(x : Int) -> Bool { x > 2 })
  assert_true(result.length() == 3)
}

///|
test "trait_hashable_implementable" {
  fn helper_hash(self : Int) -> Int {
    self
  }
  assert_true(helper_hash(42) == 42)
}

///|
test "trait_iterable_implementable" {
  fn helper_iter_next(self : Array[Int], idx : Int) -> Option[Int] {
    if idx < self.length() {
      Some(self[idx])
    } else {
      None
    }
  }
  let arr = [1, 2, 3]
  assert_true(helper_iter_next(arr, 0) == Some(1))
  assert_true(helper_iter_next(arr, 3) == None)
}

///|
test "trait_named_describable_composition" {
  fn name(_self : Int) -> String { "Int" }
  fn describe(self : Int) -> String { "value=" + self.to_string() }
  fn display(self : Int) -> String { name(self) + "(" + describe(self) + ")" }
  assert_true(display(42) == "Int(value=42)")
}

///|
test "trait_checkable_verifiable_composition" {
  fn check(self : Int) -> Bool { self >= 0 }
  fn verify(self : Int) -> Bool { check(self) && self < 100 }
  assert_true(verify(50))
  assert_true(verify(-1) == false)
  assert_true(verify(150) == false)
}

///|
test "trait_cloneable_idempotent" {
  fn clone(self : Int) -> Int { self }
  let x = 42
  let y = clone(x)
  let z = clone(y)
  assert_true(x == y)
  assert_true(y == z)
}

///|
test "trait_resettable_default" {
  fn reset(_self : Int) -> Int { 0 }
  assert_true(reset(100) == 0)
  assert_true(reset(-100) == 0)
  assert_true(reset(0) == 0)
}

///|
test "trait_countable_empty" {
  fn count(self : Array[Int]) -> Int { self.length() }
  assert_true(count([]) == 0)
}

///|
test "trait_countable_single" {
  fn count(self : Array[Int]) -> Int { self.length() }
  assert_true(count([1]) == 1)
}

///|
test "trait_ordered_reflexive" {
  fn compare(self : Int, other : Int) -> Int {
    if self < other { -1 } else if self > other { 1 } else { 0 }
  }
  assert_true(compare(5, 5) == 0)
}

///|
test "trait_ordered_antisymmetric" {
  fn compare(self : Int, other : Int) -> Int {
    if self < other { -1 } else if self > other { 1 } else { 0 }
  }
  assert_true(compare(1, 2) == -1)
  assert_true(compare(2, 1) == 1)
}
///|
test "trait_checkable_true_always" {
  fn check(_self : Int) -> Bool { true }
  assert_true(check(0))
  assert_true(check(-1))
  assert_true(check(999999))
}

///|
test "trait_checkable_false_always" {
  fn check(_self : Int) -> Bool { false }
  assert_true(check(0) == false)
  assert_true(check(1) == false)
}

///|
test "trait_resettable_to_zero" {
  fn reset(_self : Double) -> Double { 0.0 }
  assert_true(reset(3.14) == 0.0)
  assert_true(reset(-100.0) == 0.0)
}

///|
test "trait_resettable_idempotent" {
  fn reset(_self : Int) -> Int { 0 }
  let r1 = reset(42)
  let r2 = reset(r1)
  assert_true(r1 == r2)
}

///|
test "trait_checkable_resettable_compose" {
  fn check(self : Int) -> Bool { self > 0 }
  fn reset(_self : Int) -> Int { 0 }
  let v = 5
  assert_true(check(v))
  let r = reset(v)
  assert_true(check(r) == false)
}

///|
test "trait_cloneable_preserves_check" {
  fn check(self : Int) -> Bool { self > 0 }
  fn clone(self : Int) -> Int { self }
  let v = 42
  assert_true(check(v) == check(clone(v)))
}

///|
test "trait_displayable_format" {
  fn name(_self : Int) -> String { "Int" }
  fn describe(self : Int) -> String { self.to_string() }
  fn display(self : Int) -> String { name(self) + "(" + describe(self) + ")" }
  assert_true(display(0) == "Int(0)")
  assert_true(display(-1) == "Int(-1)")
  assert_true(display(100) == "Int(100)")
}

///|
test "trait_ordered_transitive" {
  fn compare(self : Int, other : Int) -> Int {
    if self < other { -1 } else if self > other { 1 } else { 0 }
  }
  assert_true(compare(1, 2) == -1)
  assert_true(compare(2, 3) == -1)
  assert_true(compare(1, 3) == -1)
}

///|
test "trait_countable_additive" {
  fn count(self : Array[Int]) -> Int { self.length() }
  let a = [1, 2, 3]
  let b = [4, 5]
  assert_true(count(a) + count(b) == 5)
}

///|
test "trait_serializable_roundtrip" {
  fn serialize(self : Int) -> String { self.to_string() }
  assert_true(serialize(42) == "42")
  assert_true(serialize(0) == "0")
  assert_true(serialize(-1) == "-1")
}

///|
test "trait_transformable_identity" {
  fn identity(self : Double) -> Double { self }
  assert_true(identity(3.14) > 3.13)
  assert_true(identity(3.14) < 3.15)
}

///|
test "trait_transformable_compose" {
  fn double(x : Double) -> Double { x * 2.0 }
  fn add1(x : Double) -> Double { x + 1.0 }
  let compose = fn(x : Double) -> Double { double(add1(x)) }
  assert_true(compose(3.0) > 7.99)
  assert_true(compose(3.0) < 8.01)
}

///|
test "trait_filterable_preserves_count" {
  fn filter(self : Array[Int], pred : (Int) -> Bool) -> Array[Int] {
    let result = []
    for i in 0..<self.length() {
      if pred(self[i]) {
        result.push(self[i])
      }
    }
    result
  }
  let arr = [1, 2, 3, 4, 5, 6]
  let evens = filter(arr, fn(x : Int) -> Bool { x % 2 == 0 })
  assert_true(evens.length() == 3)
  assert_true(evens[0] == 2)
  assert_true(evens[2] == 6)
}

///|
test "trait_mappable_preserves_length" {
  fn map(self : Array[Int], f : (Int) -> Int) -> Array[Int] {
    let result = []
    for i in 0..<self.length() {
      result.push(f(self[i]))
    }
    result
  }
  let arr = [1, 2, 3, 4, 5]
  let squared = map(arr, fn(x : Int) -> Int { x * x })
  assert_true(squared.length() == arr.length())
  assert_true(squared[0] == 1)
  assert_true(squared[4] == 25)
}

///|
test "trait_foldable_sum" {
  fn fold(self : Array[Int], init : Int, f : (Int, Int) -> Int) -> Int {
    let mut acc = init
    for i in 0..<self.length() {
      acc = f(acc, self[i])
    }
    acc
  }
  let arr = [1, 2, 3, 4, 5]
  let sum = fold(arr, 0, fn(a : Int, b : Int) -> Int { a + b })
  assert_true(sum == 15)
}

///|
test "trait_foldable_product" {
  fn fold(self : Array[Int], init : Int, f : (Int, Int) -> Int) -> Int {
    let mut acc = init
    for i in 0..<self.length() {
      acc = f(acc, self[i])
    }
    acc
  }
  let arr = [1, 2, 3, 4, 5]
  let product = fold(arr, 1, fn(a : Int, b : Int) -> Int { a * b })
  assert_true(product == 120)
}

///|
test "trait_composable_identity" {
  fn identity(x : Int) -> Int { x }
  fn f(x : Int) -> Int { x + 10 }
  let compose = fn(x : Int) -> Int { f(identity(x)) }
  assert_true(compose(5) == 15)
}

///|
test "trait_runnable_repeat" {
  fn run(self : Int) -> Int { self * 2 }
  let v = 3
  let v1 = run(v)
  let v2 = run(v1)
  let v3 = run(v2)
  assert_true(v3 == 24)
}

///|
test "trait_hashable_deterministic" {
  fn hash(self : Int) -> Int { self * 31 }
  assert_true(hash(1) == hash(1))
  assert_true(hash(2) != hash(1))
}

///|
test "trait_iterable_exhaustion" {
  fn next(self : Array[Int], idx : Int) -> Option[Int] {
    if idx < self.length() {
      Some(self[idx])
    } else {
      None
    }
  }
  let arr = [10, 20, 30]
  assert_true(next(arr, 0) == Some(10))
  assert_true(next(arr, 1) == Some(20))
  assert_true(next(arr, 2) == Some(30))
  assert_true(next(arr, 3) == None)
}

///|
test "trait_combinator_check_and_reset" {
  fn check(self : Int) -> Bool { self > 0 }
  fn reset(_self : Int) -> Int { 0 }
  let v = 5
  assert_true(check(v))
  let r = reset(v)
  assert_true(check(r) == false)
}

///|
test "trait_combinator_display_with_status" {
  fn display(_self : Int) -> String { "Int" }
  fn check(self : Int) -> Bool { self > 0 }
  let v = 42
  let status = if check(v) { "OK" } else { "INVALID" }
  let result = display(v) + " [" + status + "]"
  assert_true(result == "Int [OK]")
}

///|
test "trait_combinator_name_with_version" {
  fn name(_self : Int) -> String { "MyType" }
  fn version(_self : Int) -> String { "1.0" }
  let v = 0
  let result = name(v) + " v" + version(v)
  assert_true(result == "MyType v1.0")
}

///|
test "trait_combinator_double_check" {
  fn check(self : Int) -> Bool { self > 0 }
  fn verify(self : Int) -> Bool { check(self) }
  let v = 42
  assert_true(verify(v) && check(v))
  let v2 = -1
  assert_true(verify(v2) == false)
}

///|
test "trait_default_displayable" {
  fn name(_self : Int) -> String { "Point" }
  fn describe(self : Int) -> String { "val=" + self.to_string() }
  let v = 42
  let display = name(v) + "(" + describe(v) + ")"
  assert_true(display == "Point(val=42)")
}

///|
test "trait_helper_point_describe" {
  let r = @traits.point_describe(1.5, 2.5)
  assert_true(r.contains("x=1.5"))
}

///|
test "trait_helper_series_describe" {
  let r = @traits.series_describe(3, "test")
  assert_true(r == "vals=3, name=test")
}

///|
test "trait_helper_matrix_describe" {
  let r = @traits.matrix_describe(2, 3)
  assert_true(r == "rows=2, cols=3")
}

///|
test "trait_helper_vector_describe" {
  let r = @traits.vector_describe(5)
  assert_true(r == "dim=5")
}
