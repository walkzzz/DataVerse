///|
/// # opcore/groundwater 地下水分析 / Groundwater Analysis
///
/// Darcy Flow / Particle Track / Porous Puff。
/// 对标 ArcGIS Pro 地下水分析工具集（4 工具）。
/// S5.3 填充：达西流 + 粒子追踪 + 孔隙扩散。
///
/// # Groundwater analysis
///
/// Darcy Flow / Particle Track / Porous Puff. Aligned with ArcGIS Pro Groundwater toolset.

// ============================================================
// 类型定义 / Type definitions
// ============================================================

/// 地下水配置 / Groundwater configuration.
pub struct GroundwaterConfig {
  porosity : Double         // 孔隙度（0-1）
  conductivity : Double    // 渗透系数（m/s）
  gradient_x : Double       // 水头梯度 x 分量
  gradient_y : Double       // 水头梯度 y 分量
} derive(Debug, Eq)

pub extend GroundwaterConfig with Eq::{equal, not_equal}
pub extend GroundwaterConfig with Debug::{to_repr}

/// 达西流结果 / Darcy flow result.
pub struct DarcyFlowResult {
  flow_x : Double           // x 方向通量
  flow_y : Double           // y 方向通量
  velocity : Double         // 实际流速大小
  head_gradient : Double    // 水头梯度大小
} derive(Debug, Eq)

pub extend DarcyFlowResult with Eq::{equal, not_equal}
pub extend DarcyFlowResult with Debug::{to_repr}

/// 粒子追踪结果 / Particle track result.
pub struct ParticleTrackResult {
  path : Array[(Double, Double)]  // 粒子路径
  total_distance : Double         // 总距离
  total_time : Double             // 总时间
  steps : Int                     // 步数
} derive(Debug, Eq)

pub extend ParticleTrackResult with Eq::{equal, not_equal}
pub extend ParticleTrackResult with Debug::{to_repr}

// ============================================================
// 基础构造 / Basic constructors
// ============================================================

/// 构造地下水配置 / Build groundwater config.
pub fn make_groundwater_config(porosity : Double, conductivity : Double, gradient_x : Double, gradient_y : Double) -> GroundwaterConfig {
  let n = if porosity < 0.0 { 0.0 } else if porosity > 1.0 { 1.0 } else { porosity }
  let k = if conductivity < 0.0 { 0.0 } else { conductivity }
  { porosity: n, conductivity: k, gradient_x, gradient_y, }
}

/// 构造达西流结果 / Build Darcy flow result.
pub fn make_darcy_flow_result(flow_x : Double, flow_y : Double, velocity : Double, head_gradient : Double) -> DarcyFlowResult {
  { flow_x, flow_y, velocity, head_gradient, }
}

/// 构造粒子追踪结果 / Build particle track result.
pub fn make_particle_track_result(path : Array[(Double, Double)], total_distance : Double, total_time : Double, steps : Int) -> ParticleTrackResult {
  { path, total_distance, total_time, steps, }
}

// ============================================================
// 达西流 / Darcy flow
// ============================================================

/// 水头梯度大小 / Head gradient magnitude.
///
/// 公式：|grad(h)| = sqrt(grad_x² + grad_y²)
pub fn groundwater_head_gradient(config : GroundwaterConfig) -> Double {
  (config.gradient_x * config.gradient_x + config.gradient_y * config.gradient_y).sqrt()
}

/// 达西流 / Darcy flow.
///
/// 公式：q = -K * grad(h)
/// 退化安全：K=0 返回全 0 结果。
pub fn darcy_flow(config : GroundwaterConfig) -> DarcyFlowResult {
  let flow_x = -config.conductivity * config.gradient_x
  let flow_y = -config.conductivity * config.gradient_y
  let velocity = darcy_velocity(config)
  let grad = groundwater_head_gradient(config)
  make_darcy_flow_result(flow_x, flow_y, velocity, grad)
}

/// 达西速度 / Darcy velocity (actual seepage velocity).
///
/// 公式：v = q / n = -K * grad(h) / n
/// 退化安全：n=0 返回 0。
pub fn darcy_velocity(config : GroundwaterConfig) -> Double {
  if config.porosity <= 0.0 {
    0.0
  } else {
    let flow_x = -config.conductivity * config.gradient_x
    let flow_y = -config.conductivity * config.gradient_y
    (flow_x * flow_x + flow_y * flow_y).sqrt() / config.porosity
  }
}

/// 达西流方向 / Darcy flow direction (degrees).
///
/// 退化安全：零梯度返回 0。
pub fn groundwater_flow_direction(config : GroundwaterConfig) -> Double {
  let flow_x = -config.conductivity * config.gradient_x
  let flow_y = -config.conductivity * config.gradient_y
  if flow_x == 0.0 && flow_y == 0.0 {
    0.0
  } else {
    atan2_deg(flow_y, flow_x)
  }
}

fn atan2_deg(y : Double, x : Double) -> Double {
  let pi = 3.14159265358979323846
  let result = if x > 0.0 {
    atan_custom(y / x)
  } else if x < 0.0 && y >= 0.0 {
    atan_custom(y / x) + pi
  } else if x < 0.0 && y < 0.0 {
    atan_custom(y / x) - pi
  } else if x == 0.0 && y > 0.0 {
    pi / 2.0
  } else if x == 0.0 && y < 0.0 {
    -pi / 2.0
  } else {
    0.0
  }
  rad_to_deg(result)
}


fn rad_to_deg(rad : Double) -> Double {
  rad * 180.0 / 3.14159265358979323846
}

fn atan_custom(x : Double) -> Double {
  let pi = 3.14159265358979323846
  let abs_x = if x < 0.0 { -x } else { x }
  let sign = if x < 0.0 { -1.0 } else { 1.0 }
  if abs_x > 1.0 {
    sign * (pi / 2.0 - atan_taylor(1.0 / abs_x))
  } else {
    sign * atan_taylor(abs_x)
  }
}

fn atan_taylor(x : Double) -> Double {
  let mut result = 0.0
  let mut x_pow = x
  for n in 0..<50 {
    let term = x_pow / (2 * n + 1).to_double()
    if n % 2 == 0 {
      result = result + term
    } else {
      result = result - term
    }
    x_pow = x_pow * x * x
    if term < 0.0000001 && term > -0.0000001 {
      break
    }
  }
  result
}

// ============================================================
// 粒子追踪 / Particle track
// ============================================================

/// 粒子追踪 / Particle track through velocity field.
///
/// 从起点出发，沿达西流速场移动指定步数。
/// 退化安全：零流速返回仅含起点的路径。
pub fn particle_track(config : GroundwaterConfig, start_x : Double, start_y : Double, step_size : Double, max_steps : Int) -> ParticleTrackResult {
  if step_size <= 0.0 || max_steps <= 0 {
    make_particle_track_result([(start_x, start_y)], 0.0, 0.0, 0)
  } else {
    let v = darcy_velocity(config)
    if v <= 0.0 {
      make_particle_track_result([(start_x, start_y)], 0.0, 0.0, 0)
    } else {
      let flow_x = -config.conductivity * config.gradient_x / config.porosity
      let flow_y = -config.conductivity * config.gradient_y / config.porosity
      let dir_x = flow_x / v
      let dir_y = flow_y / v
      let path : Array[(Double, Double)] = [(start_x, start_y)]
      let mut cur_x = start_x
      let mut cur_y = start_y
      let mut total_dist = 0.0
      for _ in 0..<max_steps {
        cur_x = cur_x + dir_x * step_size
        cur_y = cur_y + dir_y * step_size
        path.push((cur_x, cur_y))
        total_dist = total_dist + step_size
      }
      let total_time = total_dist / v
      make_particle_track_result(path, total_dist, total_time, max_steps)
    }
  }
}

// ============================================================
// 孔隙扩散 / Porous puff
// ============================================================

/// 孔隙扩散 / Porous puff dispersion.
///
/// 模拟公式：C(r,t) = C0 / (4πDt) × exp(-r² / (4Dt))
/// 退化安全：D<=0 或 t<=0 返回 0。
pub fn porous_puff(distance : Double, time : Double, diffusivity : Double, initial_concentration : Double) -> Double {
  if diffusivity <= 0.0 || time <= 0.0 {
    0.0
  } else {
    let pi = 3.14159265358979323846
    let denom = 4.0 * pi * diffusivity * time
    let exponent = -(distance * distance) / denom
    initial_concentration / denom * exp_custom(exponent)
  }
}

fn exp_custom(x : Double) -> Double {
  if x < -20.0 {
    0.0
  } else if x > 20.0 {
    exp_custom(20.0)
  } else {
    let mut result = 1.0
    let mut term = 1.0
    for n in 1..<30 {
      term = term * x / n.to_double()
      result = result + term
      if term < 0.0000001 && term > -0.0000001 {
        break
      }
    }
    result
  }
}

/// 孔隙扩散网格 / Porous puff over a grid of distances.
///
/// 退化安全：空数组返回空数组。
pub fn porous_puff_grid(distances : Array[Array[Double]], time : Double, diffusivity : Double, initial_concentration : Double) -> Array[Array[Double]] {
  let rows = distances.length()
  if rows == 0 {
    []
  } else {
    let result : Array[Array[Double]] = []
    for i in 0..<rows {
      let row : Array[Double] = []
      for j in 0..<distances[i].length() {
        row.push(porous_puff(distances[i][j], time, diffusivity, initial_concentration))
      }
      result.push(row)
    }
    result
  }
}

// ============================================================
// 统计 / Statistics
// ============================================================

/// 地下水统计 / Groundwater flow statistics.
///
/// 返回 (velocity, gradient, flow_direction)。
pub fn groundwater_stats(config : GroundwaterConfig) -> (Double, Double, Double) {
  let v = darcy_velocity(config)
  let g = groundwater_head_gradient(config)
  let d = groundwater_flow_direction(config)
  (v, g, d)
}

/// 地下水配置摘要 / Groundwater config summary string.
pub fn groundwater_config_summary(config : GroundwaterConfig) -> String {
  "porosity=" + config.porosity.to_string() + ", conductivity=" + config.conductivity.to_string() + ", gradient=(" + config.gradient_x.to_string() + ", " + config.gradient_y.to_string() + ")"
}

/// 粒子追踪摘要 / Particle track summary string.
pub fn particle_track_summary(result : ParticleTrackResult) -> String {
  "steps=" + result.steps.to_string() + ", distance=" + result.total_distance.to_string() + ", time=" + result.total_time.to_string() + ", path_length=" + result.path.length().to_string()
}