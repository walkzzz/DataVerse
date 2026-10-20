///===
/// extcore/sort_exchange_cocktail

pub(all) struct SortexchangecocktailPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn sort_exchange_cocktail_make_point(x : Double, y : Double) -> SortexchangecocktailPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn sort_exchange_cocktail_make_point3(x : Double, y : Double, z : Double) -> SortexchangecocktailPoint {
  { x, y, z, label: 0 }
}

pub fn sort_exchange_cocktail_point_x(pt : SortexchangecocktailPoint) -> Double { pt.x }

pub fn sort_exchange_cocktail_point_y(pt : SortexchangecocktailPoint) -> Double { pt.y }

pub fn sort_exchange_cocktail_point_z(pt : SortexchangecocktailPoint) -> Double { pt.z }

pub fn sort_exchange_cocktail_point_label(pt : SortexchangecocktailPoint) -> Int { pt.label }

pub fn sort_exchange_cocktail_point_dist(a : SortexchangecocktailPoint, b : SortexchangecocktailPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn sort_exchange_cocktail_point_add(a : SortexchangecocktailPoint, b : SortexchangecocktailPoint) -> SortexchangecocktailPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn sort_exchange_cocktail_point_sub(a : SortexchangecocktailPoint, b : SortexchangecocktailPoint) -> SortexchangecocktailPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn sort_exchange_cocktail_point_scale(pt : SortexchangecocktailPoint, s : Double) -> SortexchangecocktailPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn sort_exchange_cocktail_point_dot(a : SortexchangecocktailPoint, b : SortexchangecocktailPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn sort_exchange_cocktail_point_cross(a : SortexchangecocktailPoint, b : SortexchangecocktailPoint) -> SortexchangecocktailPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn sort_exchange_cocktail_point_norm(pt : SortexchangecocktailPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn sort_exchange_cocktail_point_normalize(pt : SortexchangecocktailPoint) -> SortexchangecocktailPoint {
  let n = sort_exchange_cocktail_point_norm(pt)
  if n < 0.0000001 { pt } else { sort_exchange_cocktail_point_scale(pt, 1.0 / n) }
}

pub fn sort_exchange_cocktail_point_negate(pt : SortexchangecocktailPoint) -> SortexchangecocktailPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn sort_exchange_cocktail_point_mid(a : SortexchangecocktailPoint, b : SortexchangecocktailPoint) -> SortexchangecocktailPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn sort_exchange_cocktail_point_lerp(a : SortexchangecocktailPoint, b : SortexchangecocktailPoint, t : Double) -> SortexchangecocktailPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn sort_exchange_cocktail_point_to_string(pt : SortexchangecocktailPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct SortexchangecocktailSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn sort_exchange_cocktail_make_series(vals : Array[Double], name : String) -> SortexchangecocktailSeries {
  { vals, name, meta: 0 }
}

pub fn sort_exchange_cocktail_series_len(s : SortexchangecocktailSeries) -> Int { s.vals.length() }

pub fn sort_exchange_cocktail_series_sum(s : SortexchangecocktailSeries) -> Double { @_common.sum(s.vals) }

pub fn sort_exchange_cocktail_series_mean(s : SortexchangecocktailSeries) -> Double { @_common.mean(s.vals) }

pub fn sort_exchange_cocktail_series_min(s : SortexchangecocktailSeries) -> Double { @_common.min(s.vals) }

pub fn sort_exchange_cocktail_series_max(s : SortexchangecocktailSeries) -> Double { @_common.max(s.vals) }

pub fn sort_exchange_cocktail_series_range(s : SortexchangecocktailSeries) -> Double {
  @_common.max(s.vals) - @_common.min(s.vals)
}

pub fn sort_exchange_cocktail_series_var(s : SortexchangecocktailSeries) -> Double { @_common.variance(s.vals) }

pub fn sort_exchange_cocktail_series_std(s : SortexchangecocktailSeries) -> Double { @_common.std(s.vals) }

pub fn sort_exchange_cocktail_series_median(s : SortexchangecocktailSeries) -> Double { @_common.median(s.vals) }

pub fn sort_exchange_cocktail_series_scale(s : SortexchangecocktailSeries, f : Double) -> SortexchangecocktailSeries {
  { vals: @_common.scale_arr(s.vals, f), name: s.name, meta: s.meta }
}

pub fn sort_exchange_cocktail_series_add(a : SortexchangecocktailSeries, b : SortexchangecocktailSeries) -> SortexchangecocktailSeries {
  { vals: @_common.add_arr(a.vals, b.vals), name: a.name + "+" + b.name, meta: a.meta }
}

pub fn sort_exchange_cocktail_series_sub(a : SortexchangecocktailSeries, b : SortexchangecocktailSeries) -> SortexchangecocktailSeries {
  { vals: @_common.sub_arr(a.vals, b.vals), name: a.name + "-" + b.name, meta: a.meta }
}

pub fn sort_exchange_cocktail_series_normalize(s : SortexchangecocktailSeries) -> SortexchangecocktailSeries {
  let mn = sort_exchange_cocktail_series_min(s)
  let mx = sort_exchange_cocktail_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn sort_exchange_cocktail_series_cumsum(s : SortexchangecocktailSeries) -> SortexchangecocktailSeries {
  { vals: @_common.cumsum(s.vals), name: s.name + "_cumsum", meta: s.meta }
}

pub fn sort_exchange_cocktail_series_to_string(s : SortexchangecocktailSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct SortexchangecocktailMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn sort_exchange_cocktail_make_matrix(rows : Int, cols : Int, val : Double) -> SortexchangecocktailMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn sort_exchange_cocktail_matrix_identity(n : Int) -> SortexchangecocktailMatrix {
  let m = sort_exchange_cocktail_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn sort_exchange_cocktail_matrix_get(m : SortexchangecocktailMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn sort_exchange_cocktail_matrix_transpose(m : SortexchangecocktailMatrix) -> SortexchangecocktailMatrix {
  let result = sort_exchange_cocktail_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn sort_exchange_cocktail_matrix_add(a : SortexchangecocktailMatrix, b : SortexchangecocktailMatrix) -> SortexchangecocktailMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = sort_exchange_cocktail_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn sort_exchange_cocktail_matrix_scale(m : SortexchangecocktailMatrix, s : Double) -> SortexchangecocktailMatrix {
  let result = sort_exchange_cocktail_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn sort_exchange_cocktail_matrix_multiply(a : SortexchangecocktailMatrix, b : SortexchangecocktailMatrix) -> SortexchangecocktailMatrix {
  if a.cols != b.rows { return sort_exchange_cocktail_make_matrix(a.rows, b.cols, 0.0) }
  let result = sort_exchange_cocktail_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn sort_exchange_cocktail_matrix_trace(m : SortexchangecocktailMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn sort_exchange_cocktail_matrix_det(m : SortexchangecocktailMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn sort_exchange_cocktail_matrix_norm(m : SortexchangecocktailMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn sort_exchange_cocktail_matrix_to_string(m : SortexchangecocktailMatrix) -> String {
  let mut result = "Mat(" + m.rows.to_string() + "x" + m.cols.to_string() + ")\n"
  let rl = if m.rows < 5 { m.rows } else { 5 }
  let cl = if m.cols < 5 { m.cols } else { 5 }
  for i in 0..<rl {
    result = result + "  ["
    for j in 0..<cl { if j > 0 { result = result + ", " }; result = result + @_common.dbl(m.data[i][j]) }
    result = result + "]\n"
  }
  result
}

pub(all) struct SortexchangecocktailVector {
  comps : Array[Double]
  dim : Int
}

pub fn sort_exchange_cocktail_make_vector(comps : Array[Double]) -> SortexchangecocktailVector {
  { comps, dim: comps.length() }
}

pub fn sort_exchange_cocktail_vector_zero(dim : Int) -> SortexchangecocktailVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn sort_exchange_cocktail_vector_add(a : SortexchangecocktailVector, b : SortexchangecocktailVector) -> SortexchangecocktailVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  { comps: @_common.add_arr(a.comps, b.comps), dim: n }
}

pub fn sort_exchange_cocktail_vector_sub(a : SortexchangecocktailVector, b : SortexchangecocktailVector) -> SortexchangecocktailVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  { comps: @_common.sub_arr(a.comps, b.comps), dim: n }
}

pub fn sort_exchange_cocktail_vector_scale(v : SortexchangecocktailVector, s : Double) -> SortexchangecocktailVector {
  { comps: @_common.scale_arr(v.comps, s), dim: v.dim }
}

pub fn sort_exchange_cocktail_vector_dot(a : SortexchangecocktailVector, b : SortexchangecocktailVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn sort_exchange_cocktail_vector_norm(v : SortexchangecocktailVector) -> Double { @_common.sqrt(sort_exchange_cocktail_vector_dot(v, v)) }

pub fn sort_exchange_cocktail_vector_normalize(v : SortexchangecocktailVector) -> SortexchangecocktailVector {
  let n = sort_exchange_cocktail_vector_norm(v)
  if n < 0.0000001 { v } else { sort_exchange_cocktail_vector_scale(v, 1.0 / n) }
}

pub fn sort_exchange_cocktail_vector_dist(a : SortexchangecocktailVector, b : SortexchangecocktailVector) -> Double {
  sort_exchange_cocktail_vector_norm(sort_exchange_cocktail_vector_sub(a, b))
}

pub fn sort_exchange_cocktail_vector_to_string(v : SortexchangecocktailVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn sort_exchange_cocktail_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn sort_exchange_cocktail_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn sort_exchange_cocktail_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn sort_exchange_cocktail_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn sort_exchange_cocktail_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn sort_exchange_cocktail_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn sort_exchange_cocktail_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn sort_exchange_cocktail_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn sort_exchange_cocktail_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn sort_exchange_cocktail_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn sort_exchange_cocktail_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn sort_exchange_cocktail_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn sort_exchange_cocktail_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn sort_exchange_cocktail_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn sort_exchange_cocktail_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn sort_exchange_cocktail_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn sort_exchange_cocktail_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn sort_exchange_cocktail_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn sort_exchange_cocktail_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn sort_exchange_cocktail_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn sort_exchange_cocktail_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn sort_exchange_cocktail_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn sort_exchange_cocktail_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn sort_exchange_cocktail_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn sort_exchange_cocktail_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn sort_exchange_cocktail_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn sort_exchange_cocktail_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn sort_exchange_cocktail_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn sort_exchange_cocktail_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct SortexchangecocktailFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_exchange_cocktail_frame_make(size : Int) -> SortexchangecocktailFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_exchange_cocktail_frame_len(s : SortexchangecocktailFrame) -> Int { s.size }

pub fn sort_exchange_cocktail_frame_get(s : SortexchangecocktailFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_exchange_cocktail_frame_set(s : SortexchangecocktailFrame, i : Int, v : Double) -> SortexchangecocktailFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_exchange_cocktail_frame_sum(s : SortexchangecocktailFrame) -> Double { @_common.sum(s.data) }

pub fn sort_exchange_cocktail_frame_mean(s : SortexchangecocktailFrame) -> Double { @_common.mean(s.data) }

pub fn sort_exchange_cocktail_frame_scale(s : SortexchangecocktailFrame, f : Double) -> SortexchangecocktailFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_exchange_cocktail_frame_add(a : SortexchangecocktailFrame, b : SortexchangecocktailFrame) -> SortexchangecocktailFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_exchange_cocktail_frame_copy(s : SortexchangecocktailFrame) -> SortexchangecocktailFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_exchange_cocktail_frame_fill(s : SortexchangecocktailFrame, v : Double) -> SortexchangecocktailFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_exchange_cocktail_frame_min(s : SortexchangecocktailFrame) -> Double { @_common.min(s.data) }

pub fn sort_exchange_cocktail_frame_max(s : SortexchangecocktailFrame) -> Double { @_common.max(s.data) }

pub fn sort_exchange_cocktail_frame_to_string(s : SortexchangecocktailFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortexchangecocktailTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_exchange_cocktail_table_make(size : Int) -> SortexchangecocktailTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_exchange_cocktail_table_len(s : SortexchangecocktailTable) -> Int { s.size }

pub fn sort_exchange_cocktail_table_get(s : SortexchangecocktailTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_exchange_cocktail_table_set(s : SortexchangecocktailTable, i : Int, v : Double) -> SortexchangecocktailTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_exchange_cocktail_table_sum(s : SortexchangecocktailTable) -> Double { @_common.sum(s.data) }

pub fn sort_exchange_cocktail_table_mean(s : SortexchangecocktailTable) -> Double { @_common.mean(s.data) }

pub fn sort_exchange_cocktail_table_scale(s : SortexchangecocktailTable, f : Double) -> SortexchangecocktailTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_exchange_cocktail_table_add(a : SortexchangecocktailTable, b : SortexchangecocktailTable) -> SortexchangecocktailTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_exchange_cocktail_table_copy(s : SortexchangecocktailTable) -> SortexchangecocktailTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_exchange_cocktail_table_fill(s : SortexchangecocktailTable, v : Double) -> SortexchangecocktailTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_exchange_cocktail_table_min(s : SortexchangecocktailTable) -> Double { @_common.min(s.data) }

pub fn sort_exchange_cocktail_table_max(s : SortexchangecocktailTable) -> Double { @_common.max(s.data) }

pub fn sort_exchange_cocktail_table_to_string(s : SortexchangecocktailTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortexchangecocktailGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_exchange_cocktail_graphn_make(size : Int) -> SortexchangecocktailGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_exchange_cocktail_graphn_len(s : SortexchangecocktailGraphN) -> Int { s.size }

pub fn sort_exchange_cocktail_graphn_get(s : SortexchangecocktailGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_exchange_cocktail_graphn_set(s : SortexchangecocktailGraphN, i : Int, v : Double) -> SortexchangecocktailGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_exchange_cocktail_graphn_sum(s : SortexchangecocktailGraphN) -> Double { @_common.sum(s.data) }

pub fn sort_exchange_cocktail_graphn_mean(s : SortexchangecocktailGraphN) -> Double { @_common.mean(s.data) }

pub fn sort_exchange_cocktail_graphn_scale(s : SortexchangecocktailGraphN, f : Double) -> SortexchangecocktailGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_exchange_cocktail_graphn_add(a : SortexchangecocktailGraphN, b : SortexchangecocktailGraphN) -> SortexchangecocktailGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_exchange_cocktail_graphn_copy(s : SortexchangecocktailGraphN) -> SortexchangecocktailGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_exchange_cocktail_graphn_fill(s : SortexchangecocktailGraphN, v : Double) -> SortexchangecocktailGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_exchange_cocktail_graphn_min(s : SortexchangecocktailGraphN) -> Double { @_common.min(s.data) }

pub fn sort_exchange_cocktail_graphn_max(s : SortexchangecocktailGraphN) -> Double { @_common.max(s.data) }

pub fn sort_exchange_cocktail_graphn_to_string(s : SortexchangecocktailGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortexchangecocktailNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_exchange_cocktail_node_make(size : Int) -> SortexchangecocktailNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_exchange_cocktail_node_len(s : SortexchangecocktailNode) -> Int { s.size }

pub fn sort_exchange_cocktail_node_get(s : SortexchangecocktailNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_exchange_cocktail_node_set(s : SortexchangecocktailNode, i : Int, v : Double) -> SortexchangecocktailNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_exchange_cocktail_node_sum(s : SortexchangecocktailNode) -> Double { @_common.sum(s.data) }

pub fn sort_exchange_cocktail_node_mean(s : SortexchangecocktailNode) -> Double { @_common.mean(s.data) }

pub fn sort_exchange_cocktail_node_scale(s : SortexchangecocktailNode, f : Double) -> SortexchangecocktailNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_exchange_cocktail_node_add(a : SortexchangecocktailNode, b : SortexchangecocktailNode) -> SortexchangecocktailNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_exchange_cocktail_node_copy(s : SortexchangecocktailNode) -> SortexchangecocktailNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_exchange_cocktail_node_fill(s : SortexchangecocktailNode, v : Double) -> SortexchangecocktailNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_exchange_cocktail_node_min(s : SortexchangecocktailNode) -> Double { @_common.min(s.data) }

pub fn sort_exchange_cocktail_node_max(s : SortexchangecocktailNode) -> Double { @_common.max(s.data) }

pub fn sort_exchange_cocktail_node_to_string(s : SortexchangecocktailNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortexchangecocktailEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_exchange_cocktail_edge_make(size : Int) -> SortexchangecocktailEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_exchange_cocktail_edge_len(s : SortexchangecocktailEdge) -> Int { s.size }

pub fn sort_exchange_cocktail_edge_get(s : SortexchangecocktailEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_exchange_cocktail_edge_set(s : SortexchangecocktailEdge, i : Int, v : Double) -> SortexchangecocktailEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_exchange_cocktail_edge_sum(s : SortexchangecocktailEdge) -> Double { @_common.sum(s.data) }

pub fn sort_exchange_cocktail_edge_mean(s : SortexchangecocktailEdge) -> Double { @_common.mean(s.data) }

pub fn sort_exchange_cocktail_edge_scale(s : SortexchangecocktailEdge, f : Double) -> SortexchangecocktailEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_exchange_cocktail_edge_add(a : SortexchangecocktailEdge, b : SortexchangecocktailEdge) -> SortexchangecocktailEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_exchange_cocktail_edge_copy(s : SortexchangecocktailEdge) -> SortexchangecocktailEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_exchange_cocktail_edge_fill(s : SortexchangecocktailEdge, v : Double) -> SortexchangecocktailEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_exchange_cocktail_edge_min(s : SortexchangecocktailEdge) -> Double { @_common.min(s.data) }

pub fn sort_exchange_cocktail_edge_max(s : SortexchangecocktailEdge) -> Double { @_common.max(s.data) }

pub fn sort_exchange_cocktail_edge_to_string(s : SortexchangecocktailEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortexchangecocktailPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_exchange_cocktail_path_make(size : Int) -> SortexchangecocktailPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_exchange_cocktail_path_len(s : SortexchangecocktailPath) -> Int { s.size }

pub fn sort_exchange_cocktail_path_get(s : SortexchangecocktailPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_exchange_cocktail_path_set(s : SortexchangecocktailPath, i : Int, v : Double) -> SortexchangecocktailPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_exchange_cocktail_path_sum(s : SortexchangecocktailPath) -> Double { @_common.sum(s.data) }

pub fn sort_exchange_cocktail_path_mean(s : SortexchangecocktailPath) -> Double { @_common.mean(s.data) }

pub fn sort_exchange_cocktail_path_scale(s : SortexchangecocktailPath, f : Double) -> SortexchangecocktailPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_exchange_cocktail_path_add(a : SortexchangecocktailPath, b : SortexchangecocktailPath) -> SortexchangecocktailPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_exchange_cocktail_path_copy(s : SortexchangecocktailPath) -> SortexchangecocktailPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_exchange_cocktail_path_fill(s : SortexchangecocktailPath, v : Double) -> SortexchangecocktailPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_exchange_cocktail_path_min(s : SortexchangecocktailPath) -> Double { @_common.min(s.data) }

pub fn sort_exchange_cocktail_path_max(s : SortexchangecocktailPath) -> Double { @_common.max(s.data) }

pub fn sort_exchange_cocktail_path_to_string(s : SortexchangecocktailPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortexchangecocktailCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_exchange_cocktail_cluster_make(size : Int) -> SortexchangecocktailCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_exchange_cocktail_cluster_len(s : SortexchangecocktailCluster) -> Int { s.size }

pub fn sort_exchange_cocktail_cluster_get(s : SortexchangecocktailCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_exchange_cocktail_cluster_set(s : SortexchangecocktailCluster, i : Int, v : Double) -> SortexchangecocktailCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_exchange_cocktail_cluster_sum(s : SortexchangecocktailCluster) -> Double { @_common.sum(s.data) }

pub fn sort_exchange_cocktail_cluster_mean(s : SortexchangecocktailCluster) -> Double { @_common.mean(s.data) }

pub fn sort_exchange_cocktail_cluster_scale(s : SortexchangecocktailCluster, f : Double) -> SortexchangecocktailCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_exchange_cocktail_cluster_add(a : SortexchangecocktailCluster, b : SortexchangecocktailCluster) -> SortexchangecocktailCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_exchange_cocktail_cluster_copy(s : SortexchangecocktailCluster) -> SortexchangecocktailCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_exchange_cocktail_cluster_fill(s : SortexchangecocktailCluster, v : Double) -> SortexchangecocktailCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_exchange_cocktail_cluster_min(s : SortexchangecocktailCluster) -> Double { @_common.min(s.data) }

pub fn sort_exchange_cocktail_cluster_max(s : SortexchangecocktailCluster) -> Double { @_common.max(s.data) }

pub fn sort_exchange_cocktail_cluster_to_string(s : SortexchangecocktailCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortexchangecocktailModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_exchange_cocktail_model_make(size : Int) -> SortexchangecocktailModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_exchange_cocktail_model_len(s : SortexchangecocktailModel) -> Int { s.size }

pub fn sort_exchange_cocktail_model_get(s : SortexchangecocktailModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_exchange_cocktail_model_set(s : SortexchangecocktailModel, i : Int, v : Double) -> SortexchangecocktailModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_exchange_cocktail_model_sum(s : SortexchangecocktailModel) -> Double { @_common.sum(s.data) }

pub fn sort_exchange_cocktail_model_mean(s : SortexchangecocktailModel) -> Double { @_common.mean(s.data) }

pub fn sort_exchange_cocktail_model_scale(s : SortexchangecocktailModel, f : Double) -> SortexchangecocktailModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_exchange_cocktail_model_add(a : SortexchangecocktailModel, b : SortexchangecocktailModel) -> SortexchangecocktailModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_exchange_cocktail_model_copy(s : SortexchangecocktailModel) -> SortexchangecocktailModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_exchange_cocktail_model_fill(s : SortexchangecocktailModel, v : Double) -> SortexchangecocktailModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_exchange_cocktail_model_min(s : SortexchangecocktailModel) -> Double { @_common.min(s.data) }

pub fn sort_exchange_cocktail_model_max(s : SortexchangecocktailModel) -> Double { @_common.max(s.data) }

pub fn sort_exchange_cocktail_model_to_string(s : SortexchangecocktailModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortexchangecocktailLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_exchange_cocktail_layer_make(size : Int) -> SortexchangecocktailLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_exchange_cocktail_layer_len(s : SortexchangecocktailLayer) -> Int { s.size }

pub fn sort_exchange_cocktail_layer_get(s : SortexchangecocktailLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_exchange_cocktail_layer_set(s : SortexchangecocktailLayer, i : Int, v : Double) -> SortexchangecocktailLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_exchange_cocktail_layer_sum(s : SortexchangecocktailLayer) -> Double { @_common.sum(s.data) }

pub fn sort_exchange_cocktail_layer_mean(s : SortexchangecocktailLayer) -> Double { @_common.mean(s.data) }

pub fn sort_exchange_cocktail_layer_scale(s : SortexchangecocktailLayer, f : Double) -> SortexchangecocktailLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_exchange_cocktail_layer_add(a : SortexchangecocktailLayer, b : SortexchangecocktailLayer) -> SortexchangecocktailLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_exchange_cocktail_layer_copy(s : SortexchangecocktailLayer) -> SortexchangecocktailLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_exchange_cocktail_layer_fill(s : SortexchangecocktailLayer, v : Double) -> SortexchangecocktailLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_exchange_cocktail_layer_min(s : SortexchangecocktailLayer) -> Double { @_common.min(s.data) }

pub fn sort_exchange_cocktail_layer_max(s : SortexchangecocktailLayer) -> Double { @_common.max(s.data) }

pub fn sort_exchange_cocktail_layer_to_string(s : SortexchangecocktailLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortexchangecocktailBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_exchange_cocktail_buffer_make(size : Int) -> SortexchangecocktailBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_exchange_cocktail_buffer_len(s : SortexchangecocktailBuffer) -> Int { s.size }

pub fn sort_exchange_cocktail_buffer_get(s : SortexchangecocktailBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_exchange_cocktail_buffer_set(s : SortexchangecocktailBuffer, i : Int, v : Double) -> SortexchangecocktailBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_exchange_cocktail_buffer_sum(s : SortexchangecocktailBuffer) -> Double { @_common.sum(s.data) }

pub fn sort_exchange_cocktail_buffer_mean(s : SortexchangecocktailBuffer) -> Double { @_common.mean(s.data) }

pub fn sort_exchange_cocktail_buffer_scale(s : SortexchangecocktailBuffer, f : Double) -> SortexchangecocktailBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_exchange_cocktail_buffer_add(a : SortexchangecocktailBuffer, b : SortexchangecocktailBuffer) -> SortexchangecocktailBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_exchange_cocktail_buffer_copy(s : SortexchangecocktailBuffer) -> SortexchangecocktailBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_exchange_cocktail_buffer_fill(s : SortexchangecocktailBuffer, v : Double) -> SortexchangecocktailBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_exchange_cocktail_buffer_min(s : SortexchangecocktailBuffer) -> Double { @_common.min(s.data) }

pub fn sort_exchange_cocktail_buffer_max(s : SortexchangecocktailBuffer) -> Double { @_common.max(s.data) }

pub fn sort_exchange_cocktail_buffer_to_string(s : SortexchangecocktailBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortexchangecocktailCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_exchange_cocktail_cursor_make(size : Int) -> SortexchangecocktailCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_exchange_cocktail_cursor_len(s : SortexchangecocktailCursor) -> Int { s.size }

pub fn sort_exchange_cocktail_cursor_get(s : SortexchangecocktailCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_exchange_cocktail_cursor_set(s : SortexchangecocktailCursor, i : Int, v : Double) -> SortexchangecocktailCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_exchange_cocktail_cursor_sum(s : SortexchangecocktailCursor) -> Double { @_common.sum(s.data) }

pub fn sort_exchange_cocktail_cursor_mean(s : SortexchangecocktailCursor) -> Double { @_common.mean(s.data) }

pub fn sort_exchange_cocktail_cursor_scale(s : SortexchangecocktailCursor, f : Double) -> SortexchangecocktailCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_exchange_cocktail_cursor_add(a : SortexchangecocktailCursor, b : SortexchangecocktailCursor) -> SortexchangecocktailCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_exchange_cocktail_cursor_copy(s : SortexchangecocktailCursor) -> SortexchangecocktailCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_exchange_cocktail_cursor_fill(s : SortexchangecocktailCursor, v : Double) -> SortexchangecocktailCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_exchange_cocktail_cursor_min(s : SortexchangecocktailCursor) -> Double { @_common.min(s.data) }

pub fn sort_exchange_cocktail_cursor_max(s : SortexchangecocktailCursor) -> Double { @_common.max(s.data) }

pub fn sort_exchange_cocktail_cursor_to_string(s : SortexchangecocktailCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortexchangecocktailView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_exchange_cocktail_view_make(size : Int) -> SortexchangecocktailView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_exchange_cocktail_view_len(s : SortexchangecocktailView) -> Int { s.size }

pub fn sort_exchange_cocktail_view_get(s : SortexchangecocktailView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_exchange_cocktail_view_set(s : SortexchangecocktailView, i : Int, v : Double) -> SortexchangecocktailView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_exchange_cocktail_view_sum(s : SortexchangecocktailView) -> Double { @_common.sum(s.data) }

pub fn sort_exchange_cocktail_view_mean(s : SortexchangecocktailView) -> Double { @_common.mean(s.data) }

pub fn sort_exchange_cocktail_view_scale(s : SortexchangecocktailView, f : Double) -> SortexchangecocktailView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_exchange_cocktail_view_add(a : SortexchangecocktailView, b : SortexchangecocktailView) -> SortexchangecocktailView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_exchange_cocktail_view_copy(s : SortexchangecocktailView) -> SortexchangecocktailView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_exchange_cocktail_view_fill(s : SortexchangecocktailView, v : Double) -> SortexchangecocktailView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_exchange_cocktail_view_min(s : SortexchangecocktailView) -> Double { @_common.min(s.data) }

pub fn sort_exchange_cocktail_view_max(s : SortexchangecocktailView) -> Double { @_common.max(s.data) }

pub fn sort_exchange_cocktail_view_to_string(s : SortexchangecocktailView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortexchangecocktailRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_exchange_cocktail_range_make(size : Int) -> SortexchangecocktailRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_exchange_cocktail_range_len(s : SortexchangecocktailRange) -> Int { s.size }

pub fn sort_exchange_cocktail_range_get(s : SortexchangecocktailRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_exchange_cocktail_range_set(s : SortexchangecocktailRange, i : Int, v : Double) -> SortexchangecocktailRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_exchange_cocktail_range_sum(s : SortexchangecocktailRange) -> Double { @_common.sum(s.data) }

pub fn sort_exchange_cocktail_range_mean(s : SortexchangecocktailRange) -> Double { @_common.mean(s.data) }

pub fn sort_exchange_cocktail_range_scale(s : SortexchangecocktailRange, f : Double) -> SortexchangecocktailRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_exchange_cocktail_range_add(a : SortexchangecocktailRange, b : SortexchangecocktailRange) -> SortexchangecocktailRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_exchange_cocktail_range_copy(s : SortexchangecocktailRange) -> SortexchangecocktailRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_exchange_cocktail_range_fill(s : SortexchangecocktailRange, v : Double) -> SortexchangecocktailRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_exchange_cocktail_range_min(s : SortexchangecocktailRange) -> Double { @_common.min(s.data) }

pub fn sort_exchange_cocktail_range_max(s : SortexchangecocktailRange) -> Double { @_common.max(s.data) }

pub fn sort_exchange_cocktail_range_to_string(s : SortexchangecocktailRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortexchangecocktailSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_exchange_cocktail_slice_make(size : Int) -> SortexchangecocktailSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_exchange_cocktail_slice_len(s : SortexchangecocktailSlice) -> Int { s.size }

pub fn sort_exchange_cocktail_slice_get(s : SortexchangecocktailSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_exchange_cocktail_slice_set(s : SortexchangecocktailSlice, i : Int, v : Double) -> SortexchangecocktailSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_exchange_cocktail_slice_sum(s : SortexchangecocktailSlice) -> Double { @_common.sum(s.data) }

pub fn sort_exchange_cocktail_slice_mean(s : SortexchangecocktailSlice) -> Double { @_common.mean(s.data) }

pub fn sort_exchange_cocktail_slice_scale(s : SortexchangecocktailSlice, f : Double) -> SortexchangecocktailSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_exchange_cocktail_slice_add(a : SortexchangecocktailSlice, b : SortexchangecocktailSlice) -> SortexchangecocktailSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_exchange_cocktail_slice_copy(s : SortexchangecocktailSlice) -> SortexchangecocktailSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_exchange_cocktail_slice_fill(s : SortexchangecocktailSlice, v : Double) -> SortexchangecocktailSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_exchange_cocktail_slice_min(s : SortexchangecocktailSlice) -> Double { @_common.min(s.data) }

pub fn sort_exchange_cocktail_slice_max(s : SortexchangecocktailSlice) -> Double { @_common.max(s.data) }

pub fn sort_exchange_cocktail_slice_to_string(s : SortexchangecocktailSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

