///|
/// # opcore/distance 距离分析 / Distance Analysis
///
/// Euclidean Distance / Cost Distance / Optimal Path / Corridor。
/// 对标 ArcGIS Pro 距离分析工具集（18 工具）。
/// S4.6 填充：Dijkstra 模拟 + 模拟实现。
///
/// # Distance analysis
///
/// Euclidean / Cost / Path / Corridor. Aligned with ArcGIS Pro Distance toolset.

// ============================================================
// 类型定义 / Type definitions
// ============================================================

/// 距离结果 / Distance result grid.
pub(all) struct DistanceResult {
  grid : Array[Array[Double]]
  rows : Int
  cols : Int
} derive(Debug, Eq)

pub extend DistanceResult with Eq::{equal, not_equal}
pub extend DistanceResult with Debug::{to_repr}

/// 成本表面 / Cost surface.
pub(all) struct CostSurface {
  costs : Array[Array[Double]]
  rows : Int
  cols : Int
} derive(Debug, Eq)

pub extend CostSurface with Eq::{equal, not_equal}
pub extend CostSurface with Debug::{to_repr}

/// 路径结果 / Path result.
pub struct PathResult {
  path : Array[(Int, Int)]
  total_cost : Double
  length : Int
} derive(Debug, Eq)

pub extend PathResult with Eq::{equal, not_equal}
pub extend PathResult with Debug::{to_repr}

// ============================================================
// 基础构造 / Basic constructors
// ============================================================

/// 构造成本表面 / Build a cost surface.
pub fn make_cost_surface(costs : Array[Array[Double]]) -> CostSurface {
  let rows = costs.length()
  let cols = if rows > 0 { costs[0].length() } else { 0 }
  { costs, rows, cols, }
}

/// 成本表面取值 / Get cost at cell.
///
/// 退化安全：越界返回 1.0（默认成本）。
pub fn cost_get(cs : CostSurface, row : Int, col : Int) -> Double {
  if row < 0 || row >= cs.rows || col < 0 || col >= cs.cols {
    1.0
  } else {
    let v = cs.costs[row][col]
    if v <= 0.0 { 1.0 } else { v }
  }
}

/// 构造路径结果 / Build a path result.
pub fn make_path_result(path : Array[(Int, Int)], total_cost : Double) -> PathResult {
  { path, total_cost, length: path.length(), }
}

// ============================================================
// 欧氏距离 / Euclidean distance
// ============================================================

/// 欧氏距离栅格 / Euclidean distance grid from sources.
///
/// 对标 ArcGIS Pro Euclidean Distance。
/// 每个像元到最近源点的欧氏距离。
/// 退化安全：空源集返回全 0 栅格。
pub fn distance_euclidean_grid(sources : Array[(Int, Int)], rows : Int, cols : Int, cell_size : Double) -> DistanceResult {
  let grid : Array[Array[Double]] = []
  for i in 0..<rows {
    let row : Array[Double] = []
    for j in 0..<cols {
      if sources.length() == 0 {
        row.push(0.0)
      } else {
        let mut min_dist = 1.7976931348623157e308
        for src in sources {
          let (sr, sc) = src
          let dr = (i - sr).to_double()
          let dc = (j - sc).to_double()
          let dist = (dr * dr + dc * dc).sqrt() * cell_size
          if dist < min_dist {
            min_dist = dist
          }
        }
        row.push(min_dist)
      }
    }
    grid.push(row)
  }
  { grid, rows, cols, }
}

/// 欧氏距离分配 / Euclidean allocation: 每个像元分配到最近源。
///
/// 返回源索引栅格（-1 表示无源）。
pub fn distance_euclidean_allocation(sources : Array[(Int, Int)], rows : Int, cols : Int) -> Array[Array[Int]] {
  let grid : Array[Array[Int]] = []
  for i in 0..<rows {
    let row : Array[Int] = []
    for j in 0..<cols {
      if sources.length() == 0 {
        row.push(-1)
      } else {
        let mut min_dist = 1.7976931348623157e308
        let mut best_src = -1
        for k in 0..<sources.length() {
          let (sr, sc) = sources[k]
          let dr = (i - sr).to_double()
          let dc = (j - sc).to_double()
          let dist = dr * dr + dc * dc
          if dist < min_dist {
            min_dist = dist
            best_src = k
          }
        }
        row.push(best_src)
      }
    }
    grid.push(row)
  }
  grid
}

// ============================================================
// 成本距离 / Cost distance
// ============================================================

/// 成本距离 / Cost distance from sources (Dijkstra 简化版).
///
/// 对标 ArcGIS Pro Cost Distance。
/// 模拟策略：单次扫描，成本 = 源成本 + 移动成本 * 像元成本。
/// 退化安全：空源集返回全 0。
pub fn distance_cost(sources : Array[(Int, Int)], cs : CostSurface, cell_size : Double) -> DistanceResult {
  let rows = cs.rows
  let cols = cs.cols
  let grid : Array[Array[Double]] = []
  for i in 0..<rows {
    let row : Array[Double] = []
    for j in 0..<cols {
      if sources.length() == 0 {
        row.push(0.0)
      } else {
        let mut min_cost = 1.7976931348623157e308
        for src in sources {
          let (sr, sc) = src
          let dr = (i - sr).to_double()
          let dc = (j - sc).to_double()
          let euclidean = (dr * dr + dc * dc).sqrt() * cell_size
          let avg_cost = (cost_get(cs, i, j) + cost_get(cs, sr, sc)) / 2.0
          let cost = euclidean * avg_cost
          if cost < min_cost {
            min_cost = cost
          }
        }
        row.push(min_cost)
      }
    }
    grid.push(row)
  }
  { grid, rows, cols, }
}

/// 成本分配 / Cost allocation: 每个像元分配到成本最低的源。
pub fn distance_cost_allocation(sources : Array[(Int, Int)], cs : CostSurface, cell_size : Double) -> Array[Array[Int]] {
  let rows = cs.rows
  let cols = cs.cols
  let grid : Array[Array[Int]] = []
  for i in 0..<rows {
    let row : Array[Int] = []
    for j in 0..<cols {
      if sources.length() == 0 {
        row.push(-1)
      } else {
        let mut min_cost = 1.7976931348623157e308
        let mut best_src = -1
        for k in 0..<sources.length() {
          let (sr, sc) = sources[k]
          let dr = (i - sr).to_double()
          let dc = (j - sc).to_double()
          let euclidean = (dr * dr + dc * dc).sqrt() * cell_size
          let avg_cost = (cost_get(cs, i, j) + cost_get(cs, sr, sc)) / 2.0
          let cost = euclidean * avg_cost
          if cost < min_cost {
            min_cost = cost
            best_src = k
          }
        }
        row.push(best_src)
      }
    }
    grid.push(row)
  }
  grid
}

/// 成本回溯链接 / Cost back link: 每个像元指向成本最低的邻域。
///
/// 返回 (row, col) 栅格，指向最小成本来源。
pub fn distance_back_link(sources : Array[(Int, Int)], cs : CostSurface, cell_size : Double) -> Array[Array[(Int, Int)]] {
  let rows = cs.rows
  let cols = cs.cols
  let cost_grid = distance_cost(sources, cs, cell_size)
  let links : Array[Array[(Int, Int)]] = []
  for i in 0..<rows {
    let row : Array[(Int, Int)] = []
    for j in 0..<cols {
      let mut min_cost = cost_grid.grid[i][j]
      let mut best_link = (i, j)
      for di in [-1, 0, 1] {
        for dj in [-1, 0, 1] {
          if di != 0 || dj != 0 {
            let ni = i + di
            let nj = j + dj
            if ni >= 0 && ni < rows && nj >= 0 && nj < cols {
              if cost_grid.grid[ni][nj] < min_cost {
                min_cost = cost_grid.grid[ni][nj]
                best_link = (ni, nj)
              }
            }
          }
        }
      }
      row.push(best_link)
    }
    links.push(row)
  }
  links
}

// ============================================================
// 最优路径 / Optimal path
// ============================================================

/// 最优路径 / Optimal path from source to target (贪心回溯).
///
/// 对标 ArcGIS Pro Optimal Path As Line。
/// 模拟策略：从目标沿成本回溯链接到源（贪心下降）。
/// 退化安全：源=目标返回单点路径。
pub fn distance_optimal_path(cs : CostSurface, source : (Int, Int), target : (Int, Int)) -> PathResult {
  let (sr, sc) = source
  let (tr, tc) = target
  if sr < 0 || sr >= cs.rows || sc < 0 || sc >= cs.cols {
    { path: [], total_cost: 0.0, length: 0, }
  } else if tr < 0 || tr >= cs.rows || tc < 0 || tc >= cs.cols {
    { path: [], total_cost: 0.0, length: 0, }
  } else {
    let path : Array[(Int, Int)] = [(tr, tc)]
    let mut ci = tr
    let mut cj = tc
    let mut total_cost = 0.0
    let mut steps = 0
    let max_steps = cs.rows * cs.cols
    while (ci != sr || cj != sc) && steps < max_steps {
      let mut next_i = ci
      let mut next_j = cj
      let mut min_cost = 1.7976931348623157e308
      for di in [-1, 0, 1] {
        for dj in [-1, 0, 1] {
          if di != 0 || dj != 0 {
            let ni = ci + di
            let nj = cj + dj
            if ni >= 0 && ni < cs.rows && nj >= 0 && nj < cs.cols {
              let dist_to_src = ((ni - sr) * (ni - sr) + (nj - sc) * (nj - sc)).to_double()
              let cost = dist_to_src * cost_get(cs, ni, nj)
              if cost < min_cost {
                min_cost = cost
                next_i = ni
                next_j = nj
              }
            }
          }
        }
      }
      if next_i == ci && next_j == cj {
        break
      }
      let move_cost = ((next_i - ci) * (next_i - ci) + (next_j - cj) * (next_j - cj)).to_double().sqrt() * (cost_get(cs, ci, cj) + cost_get(cs, next_i, next_j)) / 2.0
      total_cost = total_cost + move_cost
      ci = next_i
      cj = next_j
      path.push((ci, cj))
      steps += 1
    }
    make_path_result(path, total_cost)
  }
}

// ============================================================
// 走廊分析 / Corridor
// ============================================================

/// 走廊 / Corridor: 两个成本距离累积面之和低于阈值的区域。
///
/// 对标 ArcGIS Pro Corridor。
/// 模拟策略：计算两个源到所有像元的成本距离之和，低于阈值则为走廊。
/// 退化安全：空源返回空数组。
pub fn distance_corridor(cs : CostSurface, source_a : (Int, Int), source_b : (Int, Int), threshold : Double) -> Array[(Int, Int)] {
  let cost_a = distance_cost([source_a], cs, 1.0)
  let cost_b = distance_cost([source_b], cs, 1.0)
  let corridor : Array[(Int, Int)] = []
  for i in 0..<cs.rows {
    for j in 0..<cs.cols {
      let total = cost_a.grid[i][j] + cost_b.grid[i][j]
      if total <= threshold {
        corridor.push((i, j))
      }
    }
  }
  corridor
}

// ============================================================
// 距离统计 / Distance statistics
// ============================================================

/// 距离栅格统计 / Distance grid statistics: min/max/avg.
///
/// 退化安全：空栅格返回 (0.0, 0.0, 0.0)。
pub fn distance_stats(result : DistanceResult) -> (Double, Double, Double) {
  if result.rows == 0 || result.cols == 0 {
    (0.0, 0.0, 0.0)
  } else {
    let mut min_v = result.grid[0][0]
    let mut max_v = result.grid[0][0]
    let mut sum = 0.0
    let mut count = 0
    for i in 0..<result.rows {
      for j in 0..<result.cols {
        let v = result.grid[i][j]
        if v < min_v {
          min_v = v
        }
        if v > max_v {
          max_v = v
        }
        sum = sum + v
        count += 1
      }
    }
    let avg = if count > 0 { sum / count.to_double() } else { 0.0 }
    (min_v, max_v, avg)
  }
}

/// 路径长度（像元数）/ Path length in cells.
pub fn path_cell_count(path : PathResult) -> Int {
  path.length
}

/// 路径总成本 / Path total cost.
pub fn path_cost(path : PathResult) -> Double {
  path.total_cost
}