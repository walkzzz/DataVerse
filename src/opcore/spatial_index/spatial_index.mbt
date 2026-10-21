///|
/// # opcore/spatial_index 空间索引 / Spatial Index
///
/// RTree / QuadTree / KDTree / GeoHash / Grid / Hilbert / ZOrder / Voronoi / Delaunay。
/// 对标 ArcGIS Pro 空间索引与几何工具集。
/// S4.7 填充：契约 + 模拟实现（无外部 GIS 引擎）。
///
/// # Spatial index
///
/// RTree / QuadTree / KDTree / GeoHash / Grid / Hilbert / ZOrder / Voronoi / Delaunay.

// ============================================================
// 常量 / Constants
// ============================================================

const SI_PI : Double = 3.141592653589793
const SI_E : Double = 2.718281828459045
const SI_LARGE : Double = 999999999999999.0

// ============================================================
// 辅助数学函数 / Helper math functions (private)
// ============================================================

fn si_sqrt(x : Double) -> Double {
  if x <= 0.0 {
    0.0
  } else {
    let mut guess = x / 2.0
    if guess == 0.0 {
      guess = 1.0
    }
    for _ in 0..<60 {
      guess = (guess + x / guess) / 2.0
    }
    guess
  }
}

fn si_abs(x : Double) -> Double {
  if x < 0.0 {
    -x
  } else {
    x
  }
}

// ============================================================
// 类型定义 / Type definitions
// ============================================================

/// 二维点 / 2D point.
pub struct SIPoint {
  x : Double
  y : Double
} derive(Debug, Eq)

pub extend SIPoint with Eq::{equal, not_equal}
pub extend SIPoint with Debug::{to_repr}

/// 包围盒 / Bounding box.
pub struct BBox {
  min_x : Double
  min_y : Double
  max_x : Double
  max_y : Double
} derive(Debug, Eq)

pub extend BBox with Eq::{equal, not_equal}
pub extend BBox with Debug::{to_repr}

/// 索引节点条目 / Index entry (point with id).
pub struct SIEntry {
  id : Int
  point : SIPoint
} derive(Debug, Eq)

pub extend SIEntry with Eq::{equal, not_equal}
pub extend SIEntry with Debug::{to_repr}

/// RTree 索引 / R-tree index.
pub struct RTree {
  entries : Array[SIEntry]
  bbox : BBox
} derive(Debug, Eq)

pub extend RTree with Eq::{equal, not_equal}
pub extend RTree with Debug::{to_repr}

/// QuadTree 索引 / Quadtree index.
pub struct QuadTree {
  entries : Array[SIEntry]
  bbox : BBox
  capacity : Int
} derive(Debug, Eq)

pub extend QuadTree with Eq::{equal, not_equal}
pub extend QuadTree with Debug::{to_repr}

/// KDTree 索引 / KD-tree index.
pub struct KDTree {
  entries : Array[SIEntry]
} derive(Debug, Eq)

pub extend KDTree with Eq::{equal, not_equal}
pub extend KDTree with Debug::{to_repr}

/// GeoHash 编码器 / GeoHash encoder.
pub struct GeoHash {
  precision : Int
} derive(Debug, Eq)

pub extend GeoHash with Eq::{equal, not_equal}
pub extend GeoHash with Debug::{to_repr}

/// 网格索引 / Grid index.
pub struct GridIndex {
  cell_size : Double
  origin : SIPoint
  cells : Array[Array[Array[SIEntry]]]
  rows : Int
  cols : Int
} derive(Debug, Eq)

pub extend GridIndex with Eq::{equal, not_equal}
pub extend GridIndex with Debug::{to_repr}

/// Hilbert 曲线 / Hilbert curve.
pub struct HilbertCurve {
  order : Int
} derive(Debug, Eq)

pub extend HilbertCurve with Eq::{equal, not_equal}
pub extend HilbertCurve with Debug::{to_repr}

/// Z 序曲线 / Z-order curve.
pub struct ZOrder {
  bits : Int
} derive(Debug, Eq)

pub extend ZOrder with Eq::{equal, not_equal}
pub extend ZOrder with Debug::{to_repr}

/// Voronoi 图 / Voronoi diagram.
pub struct Voronoi {
  sites : Array[SIPoint]
} derive(Debug, Eq)

pub extend Voronoi with Eq::{equal, not_equal}
pub extend Voronoi with Debug::{to_repr}

/// Delaunay 三角网 / Delaunay triangulation.
pub struct Delaunay {
  points : Array[SIPoint]
  triangles : Array[(Int, Int, Int)]
} derive(Debug, Eq)

pub extend Delaunay with Eq::{equal, not_equal}
pub extend Delaunay with Debug::{to_repr}

/// 近邻结果 / Nearest neighbor result.
pub struct NNResult {
  entry : SIEntry
  distance : Double
} derive(Debug, Eq)

pub extend NNResult with Eq::{equal, not_equal}
pub extend NNResult with Debug::{to_repr}

// ============================================================
// 基础构造 / Basic constructors
// ============================================================

/// 构造点 / Build a point.
pub fn make_point(x : Double, y : Double) -> SIPoint {
  { x, y }
}

/// 构造包围盒 / Build a bounding box.
///
/// 退化安全：自动规范 min/max 顺序。
pub fn make_bbox(min_x : Double, min_y : Double, max_x : Double, max_y : Double) -> BBox {
  let lo_x = if min_x <= max_x { min_x } else { max_x }
  let hi_x = if min_x <= max_x { max_x } else { min_x }
  let lo_y = if min_y <= max_y { min_y } else { max_y }
  let hi_y = if min_y <= max_y { max_y } else { min_y }
  { min_x: lo_x, min_y: lo_y, max_x: hi_x, max_y: hi_y }
}

/// 构造 RTree / Build an R-tree.
pub fn make_rtree(bbox : BBox) -> RTree {
  { entries: [], bbox }
}

/// 构造 QuadTree / Build a quadtree.
pub fn make_quadtree(bbox : BBox, capacity : Int) -> QuadTree {
  let cap = if capacity <= 0 { 4 } else { capacity }
  { entries: [], bbox, capacity: cap }
}

/// 构造 KDTree / Build a KD-tree.
pub fn make_kdtree() -> KDTree {
  { entries: [] }
}

// ============================================================
// 包围盒运算 / BBox operations
// ============================================================

/// 包围盒包含点 / BBox contains point.
pub fn bbox_contains(b : BBox, p : SIPoint) -> Bool {
  p.x >= b.min_x && p.x <= b.max_x && p.y >= b.min_y && p.y <= b.max_y
}

/// 包围盒相交 / Two bboxes intersect.
pub fn bbox_intersects(a : BBox, b : BBox) -> Bool {
  !(a.max_x < b.min_x || a.min_x > b.max_x || a.max_y < b.min_y || a.min_y > b.max_y)
}

/// 包围盒并集 / Union of two bboxes.
pub fn bbox_union(a : BBox, b : BBox) -> BBox {
  {
    min_x: if a.min_x < b.min_x { a.min_x } else { b.min_x },
    min_y: if a.min_y < b.min_y { a.min_y } else { b.min_y },
    max_x: if a.max_x > b.max_x { a.max_x } else { b.max_x },
    max_y: if a.max_y > b.max_y { a.max_y } else { b.max_y },
  }
}

/// 包围盒面积 / BBox area.
pub fn bbox_area(b : BBox) -> Double {
  let w = b.max_x - b.min_x
  let h = b.max_y - b.min_y
  if w <= 0.0 || h <= 0.0 {
    0.0
  } else {
    w * h
  }
}

/// 包围盒扩展 / Expand bbox by margin.
pub fn bbox_expand(b : BBox, margin : Double) -> BBox {
  let m = si_abs(margin)
  { min_x: b.min_x - m, min_y: b.min_y - m, max_x: b.max_x + m, max_y: b.max_y + m }
}

/// 包围盒中心 / BBox center.
pub fn bbox_center(b : BBox) -> SIPoint {
  { x: (b.min_x + b.max_x) / 2.0, y: (b.min_y + b.max_y) / 2.0 }
}

/// 包围盒中心距离 / Distance between bbox centers.
pub fn bbox_distance(a : BBox, b : BBox) -> Double {
  point_distance(bbox_center(a), bbox_center(b))
}

/// 点在包围盒内 / Point in bbox (alias).
pub fn point_in_bbox(p : SIPoint, b : BBox) -> Bool {
  bbox_contains(b, p)
}

/// 点距离 / Euclidean point distance.
pub fn point_distance(a : SIPoint, b : SIPoint) -> Double {
  si_sqrt(point_distance_sq(a, b))
}

/// 点距离平方 / Squared point distance.
pub fn point_distance_sq(a : SIPoint, b : SIPoint) -> Double {
  let dx = b.x - a.x
  let dy = b.y - a.y
  dx * dx + dy * dy
}

// ============================================================
// RTree 操作 / RTree operations
// ============================================================

/// RTree 插入 / Insert into R-tree.
pub fn rtree_insert(tree : RTree, entry : SIEntry) -> RTree {
  let entries = tree.entries.copy()
  entries.push(entry)
  let bbox = if entries.length() == 1 {
    make_bbox(entry.point.x, entry.point.y, entry.point.x, entry.point.y)
  } else {
    bbox_union(tree.bbox, make_bbox(entry.point.x, entry.point.y, entry.point.x, entry.point.y))
  }
  { entries, bbox }
}

/// RTree 搜索 / Search R-tree by bbox.
pub fn rtree_search(tree : RTree, bbox : BBox) -> Array[SIEntry] {
  let result : Array[SIEntry] = []
  for e in tree.entries {
    if bbox_contains(bbox, e.point) {
      result.push(e)
    }
  }
  result
}

/// RTree 删除 / Delete from R-tree by id.
pub fn rtree_delete(tree : RTree, id : Int) -> RTree {
  let entries : Array[SIEntry] = []
  for e in tree.entries {
    if e.id != id {
      entries.push(e)
    }
  }
  let bbox = if entries.length() == 0 {
    make_bbox(0.0, 0.0, 0.0, 0.0)
  } else {
    let mut bb = make_bbox(entries[0].point.x, entries[0].point.y, entries[0].point.x, entries[0].point.y)
    for i in 1..<entries.length() {
      bb = bbox_union(bb, make_bbox(entries[i].point.x, entries[i].point.y, entries[i].point.x, entries[i].point.y))
    }
    bb
  }
  { entries, bbox }
}

/// RTree 范围查询 / Range query.
pub fn rtree_range_query(tree : RTree, center : SIPoint, radius : Double) -> Array[SIEntry] {
  if radius <= 0.0 {
    return []
  }
  let result : Array[SIEntry] = []
  let r2 = radius * radius
  for e in tree.entries {
    if point_distance_sq(center, e.point) <= r2 {
      result.push(e)
    }
  }
  result
}

// ============================================================
// QuadTree 操作 / QuadTree operations
// ============================================================

/// QuadTree 插入 / Insert into quadtree.
pub fn quadtree_insert(tree : QuadTree, entry : SIEntry) -> QuadTree {
  let entries = tree.entries.copy()
  entries.push(entry)
  { entries, bbox: tree.bbox, capacity: tree.capacity }
}

/// QuadTree 搜索 / Search quadtree by bbox.
pub fn quadtree_search(tree : QuadTree, bbox : BBox) -> Array[SIEntry] {
  let result : Array[SIEntry] = []
  for e in tree.entries {
    if bbox_contains(bbox, e.point) {
      result.push(e)
    }
  }
  result
}

/// QuadTree 删除 / Delete from quadtree by id.
pub fn quadtree_delete(tree : QuadTree, id : Int) -> QuadTree {
  let entries : Array[SIEntry] = []
  for e in tree.entries {
    if e.id != id {
      entries.push(e)
    }
  }
  { entries, bbox: tree.bbox, capacity: tree.capacity }
}

/// QuadTree 范围查询 / Range query.
pub fn quadtree_range_query(tree : QuadTree, center : SIPoint, radius : Double) -> Array[SIEntry] {
  if radius <= 0.0 {
    return []
  }
  let result : Array[SIEntry] = []
  let r2 = radius * radius
  for e in tree.entries {
    if point_distance_sq(center, e.point) <= r2 {
      result.push(e)
    }
  }
  result
}

// ============================================================
// KDTree 操作 / KDTree operations
// ============================================================

/// KDTree 插入 / Insert into KD-tree.
pub fn kdtree_insert(tree : KDTree, entry : SIEntry) -> KDTree {
  let entries = tree.entries.copy()
  entries.push(entry)
  { entries, }
}

/// KDTree 搜索 / Search KD-tree by bbox.
pub fn kdtree_search(tree : KDTree, bbox : BBox) -> Array[SIEntry] {
  let result : Array[SIEntry] = []
  for e in tree.entries {
    if bbox_contains(bbox, e.point) {
      result.push(e)
    }
  }
  result
}

/// KDTree 最近邻 / Nearest neighbor in KD-tree.
///
/// 退化安全：空树返回 None。
pub fn kdtree_nearest(tree : KDTree, query : SIPoint) -> NNResult? {
  let n = tree.entries.length()
  if n == 0 {
    return None
  }
  let mut best_idx = 0
  let mut best_d2 = point_distance_sq(query, tree.entries[0].point)
  for i in 1..<n {
    let d2 = point_distance_sq(query, tree.entries[i].point)
    if d2 < best_d2 {
      best_d2 = d2
      best_idx = i
    }
  }
  Some({ entry: tree.entries[best_idx], distance: si_sqrt(best_d2) })
}

/// KDTree K 近邻 / K nearest neighbors.
///
/// 退化安全：k <= 0 返回空数组。
pub fn kdtree_knn(tree : KDTree, query : SIPoint, k : Int) -> Array[NNResult] {
  if k <= 0 || tree.entries.length() == 0 {
    return []
  }
  let pairs : Array[(Int, Double)] = []
  for i in 0..<tree.entries.length() {
    pairs.push((i, point_distance_sq(query, tree.entries[i].point)))
  }
  pairs.sort_by(fn(a, b) {
    if a.1 < b.1 {
      -1
    } else if a.1 > b.1 {
      1
    } else {
      0
    }
  })
  let kk = if k <= pairs.length() { k } else { pairs.length() }
  let result : Array[NNResult] = []
  for i in 0..<kk {
    let (idx, d2) = pairs[i]
    result.push({ entry: tree.entries[idx], distance: si_sqrt(d2) })
  }
  result
}

// ============================================================
// 通用近邻 / Generic nearest neighbor
// ============================================================

/// 最近邻 / Nearest neighbor among entries.
pub fn nearest_neighbor(entries : Array[SIEntry], query : SIPoint) -> NNResult? {
  let n = entries.length()
  if n == 0 {
    return None
  }
  let mut best_idx = 0
  let mut best_d2 = point_distance_sq(query, entries[0].point)
  for i in 1..<n {
    let d2 = point_distance_sq(query, entries[i].point)
    if d2 < best_d2 {
      best_d2 = d2
      best_idx = i
    }
  }
  Some({ entry: entries[best_idx], distance: si_sqrt(best_d2) })
}

/// K 近邻搜索 / KNN search.
pub fn knn_search(entries : Array[SIEntry], query : SIPoint, k : Int) -> Array[NNResult] {
  if k <= 0 || entries.length() == 0 {
    return []
  }
  let pairs : Array[(Int, Double)] = []
  for i in 0..<entries.length() {
    pairs.push((i, point_distance_sq(query, entries[i].point)))
  }
  pairs.sort_by(fn(a, b) {
    if a.1 < b.1 {
      -1
    } else if a.1 > b.1 {
      1
    } else {
      0
    }
  })
  let kk = if k <= pairs.length() { k } else { pairs.length() }
  let result : Array[NNResult] = []
  for i in 0..<kk {
    let (idx, d2) = pairs[i]
    result.push({ entry: entries[idx], distance: si_sqrt(d2) })
  }
  result
}

/// 范围搜索 / Range search.
pub fn range_search(entries : Array[SIEntry], center : SIPoint, radius : Double) -> Array[SIEntry] {
  if radius <= 0.0 {
    return []
  }
  let result : Array[SIEntry] = []
  let r2 = radius * radius
  for e in entries {
    if point_distance_sq(center, e.point) <= r2 {
      result.push(e)
    }
  }
  result
}

// ============================================================
// GeoHash / GeoHash encoding
// ============================================================

/// 构造 GeoHash / Build GeoHash encoder.
pub fn make_geohash(precision : Int) -> GeoHash {
  let p = if precision <= 0 { 6 } else { precision }
  { precision: p }
}

/// GeoHash 编码 / Encode point to geohash string.
///
/// 经度范围 [-180, 180]，纬度范围 [-90, 90]。
pub fn geohash_encode(gh : GeoHash, lon : Double, lat : Double) -> String {
  let alphabet = "0123456789bcdefghjkmnpqrstuvwxyz"
  let mut lo_lon = -180.0
  let mut hi_lon = 180.0
  let mut lo_lat = -90.0
  let mut hi_lat = 90.0
  let mut result = ""
  let mut bit = 0
  let mut ch = 0
  let mut even = true
  let mut count = 0
  while count < gh.precision {
    if even {
      let mid = (lo_lon + hi_lon) / 2.0
      if lon >= mid {
        ch = ch | (1 << (4 - bit))
        lo_lon = mid
      } else {
        hi_lon = mid
      }
    } else {
      let mid = (lo_lat + hi_lat) / 2.0
      if lat >= mid {
        ch = ch | (1 << (4 - bit))
        lo_lat = mid
      } else {
        hi_lat = mid
      }
    }
    even = !(even)
    bit = bit + 1
    if bit == 5 {
      result = result + alphabet[ch].to_string()
      bit = 0
      ch = 0
      count = count + 1
    }
  }
  result
}

/// GeoHash 解码 / Decode geohash to (lon, lat).
pub fn geohash_decode(gh : GeoHash, hash : String) -> (Double, Double) {
  let alphabet = "0123456789bcdefghjkmnpqrstuvwxyz"
  let mut lo_lon = -180.0
  let mut hi_lon = 180.0
  let mut lo_lat = -90.0
  let mut hi_lat = 90.0
  let mut even = true
  for i in 0..<hash.length() {
    let c = hash[i]
    let mut idx = -1
    for j in 0..<alphabet.length() {
      if alphabet[j] == c {
        idx = j
        break
      }
    }
    if idx < 0 {
      continue
    }
    for b in 0..<5 {
      let bit_val = (idx >> (4 - b)) & 1
      if even {
        let mid = (lo_lon + hi_lon) / 2.0
        if bit_val == 1 {
          lo_lon = mid
        } else {
          hi_lon = mid
        }
      } else {
        let mid = (lo_lat + hi_lat) / 2.0
        if bit_val == 1 {
          lo_lat = mid
        } else {
          hi_lat = mid
        }
      }
      even = !(even)
    }
  }
  ((lo_lon + hi_lon) / 2.0, (lo_lat + hi_lat) / 2.0)
}

/// GeoHash 邻居 / Get 8 neighbors of geohash.
pub fn geohash_neighbor(gh : GeoHash, hash : String) -> Array[String] {
  let (lon, lat) = geohash_decode(gh, hash)
  let result : Array[String] = []
  let offsets = [
    (1.0, 0.0), (-1.0, 0.0), (0.0, 1.0), (0.0, -1.0),
    (1.0, 1.0), (1.0, -1.0), (-1.0, 1.0), (-1.0, -1.0),
  ]
  let (lo_lon, hi_lon, lo_lat, hi_lat) = geohash_bounds(gh.precision)
  let d_lon = (hi_lon - lo_lon) / 360.0
  let d_lat = (hi_lat - lo_lat) / 180.0
  for i in 0..<8 {
    let (dx, dy) = offsets[i]
    let n_lon = lon + dx * d_lon
    let n_lat = lat + dy * d_lat
    if n_lon >= -180.0 && n_lon <= 180.0 && n_lat >= -90.0 && n_lat <= 90.0 {
      result.push(geohash_encode(gh, n_lon, n_lat))
    }
  }
  result
}

fn geohash_bounds(precision : Int) -> (Double, Double, Double, Double) {
  let mut lon_range = 360.0
  let mut lat_range = 180.0
  let total_bits = precision * 5
  let lon_bits = total_bits / 2
  let lat_bits = total_bits - lon_bits
  for _ in 0..<lon_bits {
    lon_range = lon_range / 2.0
  }
  for _ in 0..<lat_bits {
    lat_range = lat_range / 2.0
  }
  (-180.0, lon_range, -90.0, lat_range)
}

// ============================================================
// 网格索引 / Grid index
// ============================================================

/// 构造网格索引 / Build grid index.
pub fn make_grid_index(origin : SIPoint, cell_size : Double, rows : Int, cols : Int) -> GridIndex {
  let cs = if cell_size <= 0.0 { 1.0 } else { cell_size }
  let r = if rows <= 0 { 1 } else { rows }
  let c = if cols <= 0 { 1 } else { cols }
  let cells : Array[Array[Array[SIEntry]]] = []
  for _ in 0..<r {
    let row : Array[Array[SIEntry]] = []
    for _ in 0..<c {
      row.push([])
    }
    cells.push(row)
  }
  { cell_size: cs, origin, cells, rows: r, cols: c }
}

/// 网格插入 / Insert into grid.
pub fn grid_insert(grid : GridIndex, entry : SIEntry) -> GridIndex {
  let (row, col) = grid_cell(grid, entry.point)
  if row < 0 || row >= grid.rows || col < 0 || col >= grid.cols {
    return grid
  }
  let cells = grid.cells.copy()
  cells[row][col] = cells[row][col].copy()
  cells[row][col].push(entry)
  { cell_size: grid.cell_size, origin: grid.origin, cells, rows: grid.rows, cols: grid.cols }
}

/// 网格查询 / Query grid cell.
pub fn grid_query(grid : GridIndex, p : SIPoint) -> Array[SIEntry] {
  let (row, col) = grid_cell(grid, p)
  if row < 0 || row >= grid.rows || col < 0 || col >= grid.cols {
    return []
  }
  grid.cells[row][col]
}

/// 网格单元坐标 / Grid cell coordinates of point.
pub fn grid_cell(grid : GridIndex, p : SIPoint) -> (Int, Int) {
  let col = ((p.x - grid.origin.x) / grid.cell_size).to_int()
  let row = ((p.y - grid.origin.y) / grid.cell_size).to_int()
  (row, col)
}

// ============================================================
// Hilbert 曲线 / Hilbert curve
// ============================================================

/// 构造 Hilbert 曲线 / Build Hilbert curve.
pub fn make_hilbert_curve(order : Int) -> HilbertCurve {
  let o = if order <= 0 { 1 } else { order }
  { order: o }
}

/// Hilbert 编码 / Encode (x, y) to Hilbert distance.
pub fn hilbert_encode(hc : HilbertCurve, x : Int, y : Int) -> Int {
  let n = 1 << hc.order
  let mut px = x
  let mut py = y
  if px < 0 {
    px = 0
  }
  if py < 0 {
    py = 0
  }
  if px >= n {
    px = n - 1
  }
  if py >= n {
    py = n - 1
  }
  let mut d = 0
  let mut s = n / 2
  while s > 0 {
    let rx = if (px & s) > 0 { 1 } else { 0 }
    let ry = if (py & s) > 0 { 1 } else { 0 }
    d = d + s * s * ((3 * rx) ^ ry)
    let rot : (Int, Int) = if ry == 0 {
      if rx == 1 {
        (s - 1 - py, s - 1 - px)
      } else {
        (py, px)
      }
    } else {
      (py, px)
    }
    px = rot.0
    py = rot.1
    s = s / 2
  }
  d
}

/// Hilbert 解码 / Decode Hilbert distance to (x, y).
pub fn hilbert_decode(hc : HilbertCurve, d : Int) -> (Int, Int) {
  let n = 1 << hc.order
  let mut px = 0
  let mut py = 0
  let mut dist = d
  if dist < 0 {
    dist = 0
  }
  if dist >= n * n {
    dist = n * n - 1
  }
  let mut s = 1
  while s < n {
    let rx = 1 & (dist / 2)
    let ry = 1 & (dist ^ rx)
    px = px + s * rx
    py = py + s * ry
    dist = dist / 4
    s = s * 2
  }
  (px, py)
}

// ============================================================
// Z 序曲线 / Z-order curve
// ============================================================

/// 构造 Z 序曲线 / Build Z-order curve.
pub fn make_z_order(bits : Int) -> ZOrder {
  let b = if bits <= 0 { 8 } else { bits }
  { bits: b }
}

/// Z 序编码 / Encode (x, y) to Z-order (Morton code).
pub fn z_order_encode(zo : ZOrder, x : Int, y : Int) -> Int {
  let mut result = 0
  let mut px = x
  let mut py = y
  if px < 0 {
    px = 0
  }
  if py < 0 {
    py = 0
  }
  for i in 0..<zo.bits {
    result = result | (((px >> i) & 1) << (2 * i))
    result = result | (((py >> i) & 1) << (2 * i + 1))
  }
  result
}

/// Z 序解码 / Decode Z-order to (x, y).
pub fn z_order_decode(zo : ZOrder, z : Int) -> (Int, Int) {
  let mut x = 0
  let mut y = 0
  let mut pz = z
  if pz < 0 {
    pz = 0
  }
  for i in 0..<zo.bits {
    x = x | (((pz >> (2 * i)) & 1) << i)
    y = y | (((pz >> (2 * i + 1)) & 1) << i)
  }
  (x, y)
}

// ============================================================
// 空间连接 / Spatial join
// ============================================================

/// 空间连接 / Spatial join: find pairs within distance.
pub fn spatial_join(left : Array[SIEntry], right : Array[SIEntry], max_distance : Double) -> Array[(SIEntry, SIEntry)] {
  if max_distance <= 0.0 {
    return []
  }
  let result : Array[(SIEntry, SIEntry)] = []
  let d2 = max_distance * max_distance
  for a in left {
    for b in right {
      if point_distance_sq(a.point, b.point) <= d2 {
        result.push((a, b))
      }
    }
  }
  result
}

/// 空间过滤 / Spatial filter: keep entries within bbox.
pub fn spatial_filter(entries : Array[SIEntry], bbox : BBox) -> Array[SIEntry] {
  let result : Array[SIEntry] = []
  for e in entries {
    if bbox_contains(bbox, e.point) {
      result.push(e)
    }
  }
  result
}

/// 空间排序 / Spatial sort by Hilbert order.
pub fn spatial_sort(entries : Array[SIEntry]) -> Array[SIEntry] {
  if entries.length() <= 1 {
    return entries.copy()
  }
  let mut min_x = entries[0].point.x
  let mut max_x = entries[0].point.x
  let mut min_y = entries[0].point.y
  let mut max_y = entries[0].point.y
  for e in entries {
    if e.point.x < min_x {
      min_x = e.point.x
    }
    if e.point.x > max_x {
      max_x = e.point.x
    }
    if e.point.y < min_y {
      min_y = e.point.y
    }
    if e.point.y > max_y {
      max_y = e.point.y
    }
  }
  let range_x = max_x - min_x
  let range_y = max_y - min_y
  let hc = make_hilbert_curve(8)
  let indexed : Array[(SIEntry, Int)] = []
  for e in entries {
    let nx = if range_x > 0.0 { ((e.point.x - min_x) / range_x * 255.0).to_int() } else { 0 }
    let ny = if range_y > 0.0 { ((e.point.y - min_y) / range_y * 255.0).to_int() } else { 0 }
    indexed.push((e, hilbert_encode(hc, nx, ny)))
  }
  indexed.sort_by(fn(a, b) {
    if a.1 < b.1 {
      -1
    } else if a.1 > b.1 {
      1
    } else {
      0
    }
  })
  let result : Array[SIEntry] = []
  for i in 0..<indexed.length() {
    result.push(indexed[i].0)
  }
  result
}

// ============================================================
// Voronoi 图 / Voronoi diagram
// ============================================================

/// 构造 Voronoi / Build Voronoi diagram.
pub fn make_voronoi(sites : Array[SIPoint]) -> Voronoi {
  { sites: sites.copy() }
}

/// Voronoi 单元 / Find cell site for a point.
///
/// 退化安全：空站点返回 -1。
pub fn voronoi_cell(v : Voronoi, p : SIPoint) -> Int {
  let n = v.sites.length()
  if n == 0 {
    return -1
  }
  let mut best = 0
  let mut best_d2 = point_distance_sq(p, v.sites[0])
  for i in 1..<n {
    let d2 = point_distance_sq(p, v.sites[i])
    if d2 < best_d2 {
      best_d2 = d2
      best = i
    }
  }
  best
}

/// Voronoi 邻居 / Neighbor sites of a cell.
pub fn voronoi_neighbors(v : Voronoi, cell_idx : Int) -> Array[Int] {
  let n = v.sites.length()
  if cell_idx < 0 || cell_idx >= n {
    return []
  }
  let center = v.sites[cell_idx]
  let dists : Array[(Int, Double)] = []
  for i in 0..<n {
    if i != cell_idx {
      dists.push((i, point_distance_sq(center, v.sites[i])))
    }
  }
  dists.sort_by(fn(a, b) {
    if a.1 < b.1 {
      -1
    } else if a.1 > b.1 {
      1
    } else {
      0
    }
  })
  let k = if dists.length() >= 4 { 4 } else { dists.length() }
  let result : Array[Int] = []
  for i in 0..<k {
    result.push(dists[i].0)
  }
  result
}

// ============================================================
// Delaunay 三角网 / Delaunay triangulation
// ============================================================

/// 构造 Delaunay / Build Delaunay triangulation.
pub fn make_delaunay(points : Array[SIPoint]) -> Delaunay {
  { points: points.copy(), triangles: [] }
}

/// Delaunay 三角化 / Triangulate points.
pub fn delaunay_triangulate(d : Delaunay) -> Delaunay {
  let n = d.points.length()
  if n < 3 {
    return { points: d.points, triangles: [] }
  }
  let triangles : Array[(Int, Int, Int)] = []
  for i in 0..<(n - 2) {
    triangles.push((i, i + 1, i + 2))
  }
  { points: d.points, triangles }
}

/// Delaunay 插入点 / Insert point into triangulation.
pub fn delaunay_insert(d : Delaunay, p : SIPoint) -> Delaunay {
  let points = d.points.copy()
  points.push(p)
  let triangles = d.triangles.copy()
  let n = points.length()
  if n >= 3 {
    triangles.push((n - 3, n - 2, n - 1))
  }
  { points, triangles }
}

// ============================================================
// 凸包 / Convex hull
// ============================================================

/// 凸包 / Compute convex hull (Andrew's monotone chain).
///
/// 退化安全：少于 3 点返回原数组。
pub fn convex_hull(points : Array[SIPoint]) -> Array[SIPoint] {
  let n = points.length()
  if n <= 1 {
    return points.copy()
  }
  let sorted = points.copy()
  sorted.sort_by(fn(a, b) {
    if a.x < b.x {
      -1
    } else if a.x > b.x {
      1
    } else if a.y < b.y {
      -1
    } else if a.y > b.y {
      1
    } else {
      0
    }
  })
  if n == 2 {
    return sorted
  }
  let lower : Array[SIPoint] = []
  for p in sorted {
    while lower.length() >= 2 && cross(lower[lower.length() - 2], lower[lower.length() - 1], p) <= 0.0 {
      ignore(lower.pop())
    }
    lower.push(p)
  }
  let upper : Array[SIPoint] = []
  let mut i = n - 1
  while i >= 0 {
    let p = sorted[i]
    while upper.length() >= 2 && cross(upper[upper.length() - 2], upper[upper.length() - 1], p) <= 0.0 {
      ignore(upper.pop())
    }
    upper.push(p)
    i = i - 1
  }
  ignore(lower.pop())
  ignore(upper.pop())
  let result = lower
  for p in upper {
    result.push(p)
  }
  result
}

fn cross(o : SIPoint, a : SIPoint, b : SIPoint) -> Double {
  (a.x - o.x) * (b.y - o.y) - (a.y - o.y) * (b.x - o.x)
}

/// 凹包 / Compute concave hull (approximate).
///
/// 退化安全：少于 3 点返回凸包。
pub fn concave_hull(points : Array[SIPoint], concavity : Double) -> Array[SIPoint] {
  let n = points.length()
  if n <= 3 {
    return convex_hull(points)
  }
  let hull = convex_hull(points)
  let k = hull.length()
  let threshold = if concavity > 0.0 { concavity } else { 2.0 }
  if k <= 3 || threshold >= 100.0 {
    return hull
  }
  hull
}

/// 几何简化 / Simplify geometry (Douglas-Peucker).
pub fn simplify_geometry(points : Array[SIPoint], tolerance : Double) -> Array[SIPoint] {
  let n = points.length()
  if n <= 2 || tolerance <= 0.0 {
    return points.copy()
  }
  dp_simplify(points, 0, n - 1, tolerance)
}

fn dp_simplify(points : Array[SIPoint], start : Int, end : Int, tolerance : Double) -> Array[SIPoint] {
  if end <= start {
    return []
  }
  let mut max_d = 0.0
  let mut max_idx = start
  let p1 = points[start]
  let p2 = points[end]
  for i in (start + 1)..<end {
    let d = perpendicular_distance(points[i], p1, p2)
    if d > max_d {
      max_d = d
      max_idx = i
    }
  }
  if max_d > tolerance {
    let left = dp_simplify(points, start, max_idx, tolerance)
    let right = dp_simplify(points, max_idx, end, tolerance)
    let result = left
    for i in 1..<right.length() {
      result.push(right[i])
    }
    result
  } else {
    [p1, p2]
  }
}

fn perpendicular_distance(p : SIPoint, a : SIPoint, b : SIPoint) -> Double {
  let dx = b.x - a.x
  let dy = b.y - a.y
  let len_sq = dx * dx + dy * dy
  if len_sq == 0.0 {
    return point_distance(p, a)
  }
  let t = ((p.x - a.x) * dx + (p.y - a.y) * dy) / len_sq
  let proj_x = a.x + t * dx
  let proj_y = a.y + t * dy
  point_distance(p, { x: proj_x, y: proj_y })
}

// ============================================================
// 标识 / Identity
// ============================================================

/// 模块标识 / Module identity string.
pub fn spatial_index_id() -> String {
  "dataverse/opcore/spatial_index@0.1.0-dev"
}