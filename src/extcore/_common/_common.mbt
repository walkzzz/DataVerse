///===
/// extcore/_common — 共享辅助函数（性能优化版）
///
/// 提取自 825 个语义包的重复辅助函数，统一维护。
/// - sqrt: 牛顿法 20 次迭代（double 精度足够）
/// - abs:  条件判断
/// - dbl:  Double → String 格式化

/// 牛顿法求平方根，20 次迭代（double 精度足够收敛）
pub fn sqrt(x : Double) -> Double {
  if x <= 0.0 {
    0.0
  } else if x == 1.0 {
    1.0
  } else {
    let mut g = x / 2.0
    if g < 1.0 {
      g = 1.0
    }
    for _ in 0..<20 {
      g = (g + x / g) / 2.0
    }
    g
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

/// 限制值在 [lo, hi] 范围内
pub fn clamp(x : Double, lo : Double, hi : Double) -> Double {
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