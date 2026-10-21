///===
/// extcore/_common — 共享辅助函数（性能优化版）
///
/// 提取自 825 个语义包的重复辅助函数，统一维护。
/// - sqrt: 牛顿法 20 次迭代（double 精度足够）
/// - abs:  条件判断
/// - dbl:  Double → String 格式化
/// - 统计/评估/排序/数学/数据处理函数统一实现

// ============================================================================
// 基础数学函数
// ============================================================================

/// 牛顿法求平方根，自适应迭代（最多 20 次，变化 < 1e-15 时提前停止）
pub fn sqrt(x : Double) -> Double {
  match x {
    x if x <= 0.0 => 0.0
    1.0 => 1.0
    _ => {
      let mut g = x / 2.0
      if g < 1.0 {
        g = 1.0
      }
      for _ in 0..<20 {
        let next = (g + x / g) / 2.0
        let diff = next - g
        if diff < 0.0 {
          if -diff < 0.000000000000001 {
            g = next
            break
          }
        } else if diff < 0.000000000000001 {
          g = next
          break
        }
        g = next
      }
      g
    }
  }
}

/// 绝对值
pub fn abs(x : Double) -> Double {
  if x < 0.0 {
    -x
  } else {
    x
  }
}

/// Double → String 格式化
pub fn dbl(x : Double) -> String {
  x.to_string()
}

/// 限制值在 [lo, hi] 范围内（自动修正 lo > hi 的情况）
pub fn clamp(x : Double, lo : Double, hi : Double) -> Double {
  let (lo, hi) = if lo <= hi { (lo, hi) } else { (hi, lo) }
  if x < lo {
    lo
  } else if x > hi {
    hi
  } else {
    x
  }
}

/// 判断两个 Double 是否近似相等（容差 1e-7）
pub fn approx_eq(a : Double, b : Double) -> Bool {
  abs(a - b) < 0.0000001
}

/// 线性插值
pub fn lerp(a : Double, b : Double, t : Double) -> Double {
  a + (b - a) * t
}

/// 将角度从度转为弧度
pub fn deg_to_rad(deg : Double) -> Double {
  deg * 3.141592653589793 / 180.0
}

/// 将角度从弧度转为度
pub fn rad_to_deg(rad : Double) -> Double {
  rad * 180.0 / 3.141592653589793
}

// ============================================================================
// 统计函数
// ============================================================================

/// 均值
pub fn mean(data : Array[Double]) -> Double {
  guard data.length() > 0 else { 0.0 }
  sum(data) / data.length().to_double()
}

/// 求和
pub fn sum(data : Array[Double]) -> Double {
  let mut total = 0.0
  for x in data {
    total = total + x
  }
  total
}

/// 方差
pub fn variance(data : Array[Double]) -> Double {
  let n = data.length()
  match n {
    0 => 0.0
    _ => {
      let m = mean(data)
      let mut total = 0.0
      for x in data {
        let d = x - m
        total = total + d * d
      }
      total / n.to_double()
    }
  }
}

/// 标准差
pub fn std(data : Array[Double]) -> Double {
  sqrt(variance(data))
}

/// 协方差
pub fn cov(a : Array[Double], b : Array[Double]) -> Double {
  let n = if a.length() < b.length() {
    a.length()
  } else {
    b.length()
  }
  match n {
    0 => 0.0
    _ => {
      let ma = mean(a)
      let mb = mean(b)
      let mut total = 0.0
      for i in 0..<n {
        total = total + (a[i] - ma) * (b[i] - mb)
      }
      total / n.to_double()
    }
  }
}

/// 相关系数
pub fn corr(a : Array[Double], b : Array[Double]) -> Double {
  let sa = std(a)
  let sb = std(b)
  if sa < 0.0000001 || sb < 0.0000001 {
    0.0
  } else {
    cov(a, b) / (sa * sb)
  }
}

/// 中位数
pub fn median(data : Array[Double]) -> Double {
  let n = data.length()
  match n {
    0 => 0.0
    _ => {
      let sorted = sort(data)
      if n % 2 == 1 {
        sorted[n / 2]
      } else {
        (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0
      }
    }
  }
}

// ============================================================================
// 评估指标
// ============================================================================

/// 分类准确率
pub fn accuracy(pred : Array[Int], labels : Array[Int]) -> Double {
  let n = if pred.length() < labels.length() {
    pred.length()
  } else {
    labels.length()
  }
  match n {
    0 => 0.0
    _ => {
      let mut correct = 0
      for i in 0..<n {
        if pred[i] == labels[i] {
          correct = correct + 1
        }
      }
      correct.to_double() / n.to_double()
    }
  }
}

/// 均方误差
pub fn mse(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() {
    pred.length()
  } else {
    labels.length()
  }
  match n {
    0 => 0.0
    _ => {
      let mut sum = 0.0
      for i in 0..<n {
        let d = pred[i] - labels[i]
        sum = sum + d * d
      }
      sum / n.to_double()
    }
  }
}

/// 均方根误差
pub fn rmse(pred : Array[Double], labels : Array[Double]) -> Double {
  sqrt(mse(pred, labels))
}

/// 平均绝对误差
pub fn mae(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() {
    pred.length()
  } else {
    labels.length()
  }
  match n {
    0 => 0.0
    _ => {
      let mut sum = 0.0
      for i in 0..<n {
        sum = sum + abs(pred[i] - labels[i])
      }
      sum / n.to_double()
    }
  }
}

/// R² 决定系数
pub fn r2(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() {
    pred.length()
  } else {
    labels.length()
  }
  match n {
    0 => 0.0
    _ => {
      let lm = mean(labels)
      let mut ss_res = 0.0
      let mut ss_tot = 0.0
      for i in 0..<n {
        let r = labels[i] - pred[i]
        ss_res = ss_res + r * r
        let t = labels[i] - lm
        ss_tot = ss_tot + t * t
      }
      if ss_tot < 0.0000001 {
        0.0
      } else {
        1.0 - ss_res / ss_tot
      }
    }
  }
}

/// 精确率
pub fn precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() {
    pred.length()
  } else {
    labels.length()
  }
  let mut tp = 0
  let mut fp = 0
  for i in 0..<n {
    if pred[i] == pos {
      if labels[i] == pos {
        tp = tp + 1
      } else {
        fp = fp + 1
      }
    }
  }
  match tp + fp {
    0 => 0.0
    _ => tp.to_double() / (tp + fp).to_double()
  }
}

/// 召回率
pub fn recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() {
    pred.length()
  } else {
    labels.length()
  }
  let mut tp = 0
  let mut fn_ = 0
  for i in 0..<n {
    if labels[i] == pos {
      if pred[i] == pos {
        tp = tp + 1
      } else {
        fn_ = fn_ + 1
      }
    }
  }
  match tp + fn_ {
    0 => 0.0
    _ => tp.to_double() / (tp + fn_).to_double()
  }
}

/// F1 分数
pub fn f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let p_ = precision(pred, labels, pos)
  let r = recall(pred, labels, pos)
  if p_ + r < 0.0000001 {
    0.0
  } else {
    2.0 * p_ * r / (p_ + r)
  }
}

// ============================================================================
// 排序函数
// ============================================================================

/// 插入排序（小数组优化，n <= 16 时优于快排）
fn insertion_sort(arr : Array[Double], lo : Int, hi : Int) -> Unit {
  let start = lo + 1
  let end = hi + 1
  for i in start..<end {
    let key = arr[i]
    let mut j = i - 1
    while j >= lo && arr[j] > key {
      arr[j + 1] = arr[j]
      j = j - 1
    }
    arr[j + 1] = key
  }
}

/// 三数取中选择 pivot，避免已排序数组退化到 O(n²)
fn median3(arr : Array[Double], lo : Int, hi : Int) -> Double {
  let mid = lo + (hi - lo) / 2
  let a = arr[lo]
  let b = arr[mid]
  let c = arr[hi]
  if (a <= b && b <= c) || (c <= b && b <= a) {
    b
  } else if (b <= a && a <= c) || (c <= a && a <= b) {
    a
  } else {
    c
  }
}

/// 快速排序（升序）— 三数取中 + 插入排序优化
fn qsort_helper(arr : Array[Double], lo : Int, hi : Int) -> Unit {
  if hi - lo <= 16 {
    insertion_sort(arr, lo, hi)
  } else if lo < hi {
    let pivot = median3(arr, lo, hi)
    let mut i = lo - 1
    let mut j = hi + 1
    let mut done = false
    while !(done) {
      i = i + 1
      while arr[i] < pivot {
        i = i + 1
      }
      j = j - 1
      while arr[j] > pivot {
        j = j - 1
      }
      if i >= j {
        done = true
      } else {
        let tmp = arr[i]
        arr[i] = arr[j]
        arr[j] = tmp
      }
    }
    qsort_helper(arr, lo, j)
    qsort_helper(arr, j + 1, hi)
  }
}

/// 排序（升序）— 快速排序 O(n log n)
pub fn sort(arr : Array[Double]) -> Array[Double] {
  let n = arr.length()
  match n {
    0 => []
    1 => [arr[0]]
    _ => {
      let result = Array::make(n, 0.0)
      for i in 0..<n {
        result[i] = arr[i]
      }
      qsort_helper(result, 0, n - 1)
      result
    }
  }
}

/// 降序排序
pub fn sort_desc(arr : Array[Double]) -> Array[Double] {
  let sorted = sort(arr)
  let n = sorted.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n {
    result[i] = sorted[n - 1 - i]
  }
  result
}

// ============================================================================
// 数论函数
// ============================================================================

/// 阶乘（负数返回 0.0，n > 170 自然溢出为 Infinity）
pub fn factorial(n : Int) -> Double {
  match n {
    n if n < 0 => 0.0
    _ => {
      let mut result = 1.0
      let end = n + 1
      for i in 2..<end {
        result = result * i.to_double()
      }
      result
    }
  }
}

/// 最大公约数
pub fn gcd(a : Int, b : Int) -> Int {
  let mut x = if a < 0 {
    -a
  } else {
    a
  }
  let mut y = if b < 0 {
    -b
  } else {
    b
  }
  while y > 0 {
    let t = y
    y = x % y
    x = t
  }
  x
}

/// 最小公倍数（用 Double 计算防止 Int 溢出）
pub fn lcm(a : Int, b : Int) -> Int {
  match a {
    0 => 0
    _ => match b {
      0 => 0
      _ => {
        let g = gcd(a, b)
        let result = (a / g).to_double() * b.to_double()
        if result > 2147483647.0 || result < -2147483648.0 {
          0
        } else {
          result.to_int()
        }
      }
    }
  }
}

/// 判断素数（用 i <= n/i 代替 i*i <= n 防止 Int 溢出）
pub fn is_prime(n : Int) -> Bool {
  match n {
    n if n < 2 => false
    2 => true
    n if n % 2 == 0 => false
    _ => {
      let mut result = true
      let mut i = 3
      while i <= n / i {
        if n % i == 0 {
          result = false
        }
        i = i + 2
      }
      result
    }
  }
}

/// 斐波那契数列（负数返回 0）
pub fn fibonacci(n : Int) -> Int {
  match n {
    n if n < 0 => 0
    0 => 0
    1 => 1
    _ => {
      let mut a = 0
      let mut b = 1
      let end = n + 1
      for _ in 2..<end {
        let c = a + b
        a = b
        b = c
      }
      b
    }
  }
}

// ============================================================================
// 数据处理函数
// ============================================================================

/// 最小值
pub fn min(data : Array[Double]) -> Double {
  guard data.length() > 0 else { 0.0 }
  let mut m = data[0]
  for x in data {
    if x < m {
      m = x
    }
  }
  m
}

/// 最大值
pub fn max(data : Array[Double]) -> Double {
  guard data.length() > 0 else { 0.0 }
  let mut m = data[0]
  for x in data {
    if x > m {
      m = x
    }
  }
  m
}

/// 归一化到 [0, 1]
pub fn normalize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  match n {
    0 => []
    _ => {
      let mn = min(data)
      let mx = max(data)
      let r = mx - mn
      if r < 0.0000001 {
        Array::make(n, 0.0)
      } else {
        let result = Array::make(n, 0.0)
        for i in 0..<n {
          result[i] = (data[i] - mn) / r
        }
        result
      }
    }
  }
}

/// 标准化（Z-score）
pub fn standardize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  match n {
    0 => []
    _ => {
      let m = mean(data)
      let sd = std(data)
      if sd < 0.0000001 {
        Array::make(n, 0.0)
      } else {
        let result = Array::make(n, 0.0)
        for i in 0..<n {
          result[i] = (data[i] - m) / sd
        }
        result
      }
    }
  }
}

/// 截断到 [lo, hi] 范围
pub fn clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n {
    let v = data[i]
    result[i] = if v < lo {
      lo
    } else if v > hi {
      hi
    } else {
      v
    }
  }
  result
}

/// 累积和
pub fn cumsum(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  let mut total = 0.0
  for i in 0..<n {
    total = total + data[i]
    result[i] = total
  }
  result
}

/// 反转数组
pub fn reverse(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n {
    result[i] = data[n - 1 - i]
  }
  result
}

/// 拼接两个数组
pub fn concat(a : Array[Double], b : Array[Double]) -> Array[Double] {
  let na = a.length()
  let nb = b.length()
  let result = Array::make(na + nb, 0.0)
  for i in 0..<na {
    result[i] = a[i]
  }
  for i in 0..<nb {
    result[na + i] = b[i]
  }
  result
}
/// 复制数组
pub fn copy_arr(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n {
    result[i] = data[i]
  }
  result
}

/// 数组缩放
pub fn scale_arr(data : Array[Double], f : Double) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n {
    result[i] = data[i] * f
  }
  result
}

/// 数组逐元素加
pub fn add_arr(a : Array[Double], b : Array[Double]) -> Array[Double] {
  let n = if a.length() < b.length() {
    a.length()
  } else {
    b.length()
  }
  let result = Array::make(n, 0.0)
  for i in 0..<n {
    result[i] = a[i] + b[i]
  }
  result
}

/// 数组逐元素减
pub fn sub_arr(a : Array[Double], b : Array[Double]) -> Array[Double] {
  let n = if a.length() < b.length() {
    a.length()
  } else {
    b.length()
  }
  let result = Array::make(n, 0.0)
  for i in 0..<n {
    result[i] = a[i] - b[i]
  }
  result
}

/// 填充数组
pub fn fill_arr(n : Int, v : Double) -> Array[Double] {
  Array::make(n, v)
}