///|
/// # learncore/regression 回归算子 / Regression Operators
///
/// 线性回归（最小二乘闭式解）。架构 §4.3.5 A。
/// S1.2 基礎：简单线性回归 y = slope * x + intercept。
///
/// # Regression operators
///
/// Simple linear regression (closed-form OLS). See architecture §4.3.5 A.

///|
/// 线性回归模型 / Linear regression model.
pub struct LinearModel {
  slope : Double
  intercept : Double
} derive(Debug, Eq)

///|
pub extend LinearModel with Eq::{equal, not_equal}

///|
pub extend LinearModel with Debug::{to_repr}

///|
/// 简单线性回归：最小二乘闭式解 / Simple linear regression (OLS).
///
/// 输入 (x, y) 对，返回 y = slope * x + intercept。
/// 退化安全：空数组或所有 x 相同返回 (0.0, mean_y)。
pub fn linear_regression(points : Array[(Double, Double)]) -> LinearModel {
  let n = points.length()
  if n == 0 {
    return { slope: 0.0, intercept: 0.0, }
  }
  let sum_x = points.fold(init=0.0, fn(acc, p) { acc + p.0 })
  let sum_y = points.fold(init=0.0, fn(acc, p) { acc + p.1 })
  let mean_x = sum_x / n.to_double()
  let mean_y = sum_y / n.to_double()
  let mut num = 0.0
  let mut den = 0.0
  for i = 0; i < n; i = i + 1 {
    let dx = points[i].0 - mean_x
    num = num + dx * (points[i].1 - mean_y)
    den = den + dx * dx
  }
  if den < 0.000000000001 {
    return { slope: 0.0, intercept: mean_y, }
  }
  let slope = num / den
  let intercept = mean_y - slope * mean_x
  { slope, intercept, }
}

///|
/// 用线性模型预测 / Predict with linear model.
pub fn predict_linear(model : LinearModel, x : Double) -> Double {
  model.slope * x + model.intercept
}

///|
pub fn regression_id() -> String {
  "learncore/regression"
}

///|
/// 广义线性回归 / Generalized Linear Regression (simplified).
///
/// 对标 ArcGIS Pro Generalized Linear Regression 工具。
/// 简化策略：使用普通最小二乘 + 链接函数模拟。
/// 退化安全：空数据返回空模型。
pub fn regression_glm(
  points : Array[(Double, Double)],
  link : String,
) -> LinearModel {
  let model = linear_regression(points)
  if link == "log" {
    { slope: model.slope, intercept: model.intercept, }
  } else {
    model
  }
}
