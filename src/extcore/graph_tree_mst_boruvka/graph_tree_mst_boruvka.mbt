///===
/// extcore/graph_tree_mst_boruvka

pub(all) struct GraphtreemstboruvkaPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn graph_tree_mst_boruvka_make_point(x : Double, y : Double) -> GraphtreemstboruvkaPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn graph_tree_mst_boruvka_make_point3(x : Double, y : Double, z : Double) -> GraphtreemstboruvkaPoint {
  { x, y, z, label: 0 }
}

pub fn GraphtreemstboruvkaPoint::x(self : GraphtreemstboruvkaPoint) -> Double { self.x }

pub fn GraphtreemstboruvkaPoint::y(self : GraphtreemstboruvkaPoint) -> Double { self.y }

pub fn GraphtreemstboruvkaPoint::z(self : GraphtreemstboruvkaPoint) -> Double { self.z }

pub fn GraphtreemstboruvkaPoint::label(self : GraphtreemstboruvkaPoint) -> Int { self.label }

pub fn GraphtreemstboruvkaPoint::dist(self : GraphtreemstboruvkaPoint, other : GraphtreemstboruvkaPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn GraphtreemstboruvkaPoint::add(self : GraphtreemstboruvkaPoint, other : GraphtreemstboruvkaPoint) -> GraphtreemstboruvkaPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn GraphtreemstboruvkaPoint::sub(self : GraphtreemstboruvkaPoint, other : GraphtreemstboruvkaPoint) -> GraphtreemstboruvkaPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn GraphtreemstboruvkaPoint::scale(self : GraphtreemstboruvkaPoint, s : Double) -> GraphtreemstboruvkaPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn GraphtreemstboruvkaPoint::dot(self : GraphtreemstboruvkaPoint, other : GraphtreemstboruvkaPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn GraphtreemstboruvkaPoint::cross(self : GraphtreemstboruvkaPoint, other : GraphtreemstboruvkaPoint) -> GraphtreemstboruvkaPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn GraphtreemstboruvkaPoint::norm(self : GraphtreemstboruvkaPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn GraphtreemstboruvkaPoint::normalize(self : GraphtreemstboruvkaPoint) -> GraphtreemstboruvkaPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn GraphtreemstboruvkaPoint::negate(self : GraphtreemstboruvkaPoint) -> GraphtreemstboruvkaPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn GraphtreemstboruvkaPoint::mid(self : GraphtreemstboruvkaPoint, other : GraphtreemstboruvkaPoint) -> GraphtreemstboruvkaPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn GraphtreemstboruvkaPoint::lerp(self : GraphtreemstboruvkaPoint, other : GraphtreemstboruvkaPoint, t : Double) -> GraphtreemstboruvkaPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn GraphtreemstboruvkaPoint::to_string(self : GraphtreemstboruvkaPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct GraphtreemstboruvkaSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn graph_tree_mst_boruvka_make_series(vals : Array[Double], name : String) -> GraphtreemstboruvkaSeries {
  { vals, name, meta: 0 }
}

pub fn GraphtreemstboruvkaSeries::len(self : GraphtreemstboruvkaSeries) -> Int { self.vals.length() }

pub fn GraphtreemstboruvkaSeries::sum(self : GraphtreemstboruvkaSeries) -> Double { @_common.sum(self.vals) }

pub fn GraphtreemstboruvkaSeries::mean(self : GraphtreemstboruvkaSeries) -> Double { @_common.mean(self.vals) }

pub fn GraphtreemstboruvkaSeries::min(self : GraphtreemstboruvkaSeries) -> Double { @_common.min(self.vals) }

pub fn GraphtreemstboruvkaSeries::max(self : GraphtreemstboruvkaSeries) -> Double { @_common.max(self.vals) }

pub fn GraphtreemstboruvkaSeries::range(self : GraphtreemstboruvkaSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn GraphtreemstboruvkaSeries::variance(self : GraphtreemstboruvkaSeries) -> Double { @_common.variance(self.vals) }

pub fn GraphtreemstboruvkaSeries::std(self : GraphtreemstboruvkaSeries) -> Double { @_common.std(self.vals) }

pub fn GraphtreemstboruvkaSeries::median(self : GraphtreemstboruvkaSeries) -> Double { @_common.median(self.vals) }

pub fn GraphtreemstboruvkaSeries::scale(self : GraphtreemstboruvkaSeries, f : Double) -> GraphtreemstboruvkaSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn GraphtreemstboruvkaSeries::add(self : GraphtreemstboruvkaSeries, other : GraphtreemstboruvkaSeries) -> GraphtreemstboruvkaSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn GraphtreemstboruvkaSeries::sub(self : GraphtreemstboruvkaSeries, other : GraphtreemstboruvkaSeries) -> GraphtreemstboruvkaSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn GraphtreemstboruvkaSeries::normalize(self : GraphtreemstboruvkaSeries) -> GraphtreemstboruvkaSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn GraphtreemstboruvkaSeries::cumsum(self : GraphtreemstboruvkaSeries) -> GraphtreemstboruvkaSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn GraphtreemstboruvkaSeries::to_string(self : GraphtreemstboruvkaSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct GraphtreemstboruvkaMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn graph_tree_mst_boruvka_make_matrix(rows : Int, cols : Int, val : Double) -> GraphtreemstboruvkaMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn graph_tree_mst_boruvka_matrix_identity(n : Int) -> GraphtreemstboruvkaMatrix {
  let m = graph_tree_mst_boruvka_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn GraphtreemstboruvkaMatrix::get(self : GraphtreemstboruvkaMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn GraphtreemstboruvkaMatrix::transpose(self : GraphtreemstboruvkaMatrix) -> GraphtreemstboruvkaMatrix {
  let result = graph_tree_mst_boruvka_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn GraphtreemstboruvkaMatrix::add(self : GraphtreemstboruvkaMatrix, other : GraphtreemstboruvkaMatrix) -> GraphtreemstboruvkaMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = graph_tree_mst_boruvka_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn GraphtreemstboruvkaMatrix::scale(self : GraphtreemstboruvkaMatrix, s : Double) -> GraphtreemstboruvkaMatrix {
  let result = graph_tree_mst_boruvka_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn GraphtreemstboruvkaMatrix::multiply(self : GraphtreemstboruvkaMatrix, other : GraphtreemstboruvkaMatrix) -> GraphtreemstboruvkaMatrix {
  if self.cols != other.rows { return graph_tree_mst_boruvka_make_matrix(self.rows, other.cols, 0.0) }
  let result = graph_tree_mst_boruvka_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn GraphtreemstboruvkaMatrix::trace(self : GraphtreemstboruvkaMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn GraphtreemstboruvkaMatrix::det(self : GraphtreemstboruvkaMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn GraphtreemstboruvkaMatrix::norm(self : GraphtreemstboruvkaMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn GraphtreemstboruvkaMatrix::to_string(self : GraphtreemstboruvkaMatrix) -> String {
  let mut result = "Mat(" + self.rows.to_string() + "x" + self.cols.to_string() + ")\n"
  let rl = if self.rows < 5 { self.rows } else { 5 }
  let cl = if self.cols < 5 { self.cols } else { 5 }
  for i in 0..<rl {
    result = result + "  ["
    for j in 0..<cl { if j > 0 { result = result + ", " }; result = result + @_common.dbl(self.data[i][j]) }
    result = result + "]\n"
  }
  result
}

pub(all) struct GraphtreemstboruvkaVector {
  comps : Array[Double]
  dim : Int
}

pub fn graph_tree_mst_boruvka_make_vector(comps : Array[Double]) -> GraphtreemstboruvkaVector {
  { comps, dim: comps.length() }
}

pub fn graph_tree_mst_boruvka_vector_zero(dim : Int) -> GraphtreemstboruvkaVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn GraphtreemstboruvkaVector::add(self : GraphtreemstboruvkaVector, other : GraphtreemstboruvkaVector) -> GraphtreemstboruvkaVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn GraphtreemstboruvkaVector::sub(self : GraphtreemstboruvkaVector, other : GraphtreemstboruvkaVector) -> GraphtreemstboruvkaVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn GraphtreemstboruvkaVector::scale(self : GraphtreemstboruvkaVector, s : Double) -> GraphtreemstboruvkaVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn GraphtreemstboruvkaVector::dot(self : GraphtreemstboruvkaVector, other : GraphtreemstboruvkaVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn GraphtreemstboruvkaVector::norm(self : GraphtreemstboruvkaVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn GraphtreemstboruvkaVector::normalize(self : GraphtreemstboruvkaVector) -> GraphtreemstboruvkaVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn GraphtreemstboruvkaVector::dist(self : GraphtreemstboruvkaVector, other : GraphtreemstboruvkaVector) -> Double {
  self.sub(other).norm()
}

pub fn GraphtreemstboruvkaVector::to_string(self : GraphtreemstboruvkaVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn graph_tree_mst_boruvka_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn graph_tree_mst_boruvka_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn graph_tree_mst_boruvka_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn graph_tree_mst_boruvka_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn graph_tree_mst_boruvka_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn graph_tree_mst_boruvka_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn graph_tree_mst_boruvka_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn graph_tree_mst_boruvka_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn graph_tree_mst_boruvka_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn graph_tree_mst_boruvka_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn graph_tree_mst_boruvka_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn graph_tree_mst_boruvka_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn graph_tree_mst_boruvka_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn graph_tree_mst_boruvka_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn graph_tree_mst_boruvka_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn graph_tree_mst_boruvka_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn graph_tree_mst_boruvka_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn graph_tree_mst_boruvka_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn graph_tree_mst_boruvka_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn graph_tree_mst_boruvka_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn graph_tree_mst_boruvka_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn graph_tree_mst_boruvka_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn graph_tree_mst_boruvka_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn graph_tree_mst_boruvka_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn graph_tree_mst_boruvka_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn graph_tree_mst_boruvka_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn graph_tree_mst_boruvka_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn graph_tree_mst_boruvka_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn graph_tree_mst_boruvka_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct GraphtreemstboruvkaFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_tree_mst_boruvka_frame_make(size : Int) -> GraphtreemstboruvkaFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_tree_mst_boruvka_frame_len(s : GraphtreemstboruvkaFrame) -> Int { s.size }

pub fn graph_tree_mst_boruvka_frame_get(s : GraphtreemstboruvkaFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_tree_mst_boruvka_frame_set(s : GraphtreemstboruvkaFrame, i : Int, v : Double) -> GraphtreemstboruvkaFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_tree_mst_boruvka_frame_sum(s : GraphtreemstboruvkaFrame) -> Double { @_common.sum(s.data) }

pub fn graph_tree_mst_boruvka_frame_mean(s : GraphtreemstboruvkaFrame) -> Double { @_common.mean(s.data) }

pub fn graph_tree_mst_boruvka_frame_scale(s : GraphtreemstboruvkaFrame, f : Double) -> GraphtreemstboruvkaFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_tree_mst_boruvka_frame_add(a : GraphtreemstboruvkaFrame, b : GraphtreemstboruvkaFrame) -> GraphtreemstboruvkaFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_tree_mst_boruvka_frame_copy(s : GraphtreemstboruvkaFrame) -> GraphtreemstboruvkaFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_tree_mst_boruvka_frame_fill(s : GraphtreemstboruvkaFrame, v : Double) -> GraphtreemstboruvkaFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_tree_mst_boruvka_frame_min(s : GraphtreemstboruvkaFrame) -> Double { @_common.min(s.data) }

pub fn graph_tree_mst_boruvka_frame_max(s : GraphtreemstboruvkaFrame) -> Double { @_common.max(s.data) }

pub fn graph_tree_mst_boruvka_frame_to_string(s : GraphtreemstboruvkaFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphtreemstboruvkaTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_tree_mst_boruvka_table_make(size : Int) -> GraphtreemstboruvkaTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_tree_mst_boruvka_table_len(s : GraphtreemstboruvkaTable) -> Int { s.size }

pub fn graph_tree_mst_boruvka_table_get(s : GraphtreemstboruvkaTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_tree_mst_boruvka_table_set(s : GraphtreemstboruvkaTable, i : Int, v : Double) -> GraphtreemstboruvkaTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_tree_mst_boruvka_table_sum(s : GraphtreemstboruvkaTable) -> Double { @_common.sum(s.data) }

pub fn graph_tree_mst_boruvka_table_mean(s : GraphtreemstboruvkaTable) -> Double { @_common.mean(s.data) }

pub fn graph_tree_mst_boruvka_table_scale(s : GraphtreemstboruvkaTable, f : Double) -> GraphtreemstboruvkaTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_tree_mst_boruvka_table_add(a : GraphtreemstboruvkaTable, b : GraphtreemstboruvkaTable) -> GraphtreemstboruvkaTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_tree_mst_boruvka_table_copy(s : GraphtreemstboruvkaTable) -> GraphtreemstboruvkaTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_tree_mst_boruvka_table_fill(s : GraphtreemstboruvkaTable, v : Double) -> GraphtreemstboruvkaTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_tree_mst_boruvka_table_min(s : GraphtreemstboruvkaTable) -> Double { @_common.min(s.data) }

pub fn graph_tree_mst_boruvka_table_max(s : GraphtreemstboruvkaTable) -> Double { @_common.max(s.data) }

pub fn graph_tree_mst_boruvka_table_to_string(s : GraphtreemstboruvkaTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphtreemstboruvkaGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_tree_mst_boruvka_graphn_make(size : Int) -> GraphtreemstboruvkaGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_tree_mst_boruvka_graphn_len(s : GraphtreemstboruvkaGraphN) -> Int { s.size }

pub fn graph_tree_mst_boruvka_graphn_get(s : GraphtreemstboruvkaGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_tree_mst_boruvka_graphn_set(s : GraphtreemstboruvkaGraphN, i : Int, v : Double) -> GraphtreemstboruvkaGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_tree_mst_boruvka_graphn_sum(s : GraphtreemstboruvkaGraphN) -> Double { @_common.sum(s.data) }

pub fn graph_tree_mst_boruvka_graphn_mean(s : GraphtreemstboruvkaGraphN) -> Double { @_common.mean(s.data) }

pub fn graph_tree_mst_boruvka_graphn_scale(s : GraphtreemstboruvkaGraphN, f : Double) -> GraphtreemstboruvkaGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_tree_mst_boruvka_graphn_add(a : GraphtreemstboruvkaGraphN, b : GraphtreemstboruvkaGraphN) -> GraphtreemstboruvkaGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_tree_mst_boruvka_graphn_copy(s : GraphtreemstboruvkaGraphN) -> GraphtreemstboruvkaGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_tree_mst_boruvka_graphn_fill(s : GraphtreemstboruvkaGraphN, v : Double) -> GraphtreemstboruvkaGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_tree_mst_boruvka_graphn_min(s : GraphtreemstboruvkaGraphN) -> Double { @_common.min(s.data) }

pub fn graph_tree_mst_boruvka_graphn_max(s : GraphtreemstboruvkaGraphN) -> Double { @_common.max(s.data) }

pub fn graph_tree_mst_boruvka_graphn_to_string(s : GraphtreemstboruvkaGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphtreemstboruvkaNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_tree_mst_boruvka_node_make(size : Int) -> GraphtreemstboruvkaNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_tree_mst_boruvka_node_len(s : GraphtreemstboruvkaNode) -> Int { s.size }

pub fn graph_tree_mst_boruvka_node_get(s : GraphtreemstboruvkaNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_tree_mst_boruvka_node_set(s : GraphtreemstboruvkaNode, i : Int, v : Double) -> GraphtreemstboruvkaNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_tree_mst_boruvka_node_sum(s : GraphtreemstboruvkaNode) -> Double { @_common.sum(s.data) }

pub fn graph_tree_mst_boruvka_node_mean(s : GraphtreemstboruvkaNode) -> Double { @_common.mean(s.data) }

pub fn graph_tree_mst_boruvka_node_scale(s : GraphtreemstboruvkaNode, f : Double) -> GraphtreemstboruvkaNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_tree_mst_boruvka_node_add(a : GraphtreemstboruvkaNode, b : GraphtreemstboruvkaNode) -> GraphtreemstboruvkaNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_tree_mst_boruvka_node_copy(s : GraphtreemstboruvkaNode) -> GraphtreemstboruvkaNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_tree_mst_boruvka_node_fill(s : GraphtreemstboruvkaNode, v : Double) -> GraphtreemstboruvkaNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_tree_mst_boruvka_node_min(s : GraphtreemstboruvkaNode) -> Double { @_common.min(s.data) }

pub fn graph_tree_mst_boruvka_node_max(s : GraphtreemstboruvkaNode) -> Double { @_common.max(s.data) }

pub fn graph_tree_mst_boruvka_node_to_string(s : GraphtreemstboruvkaNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphtreemstboruvkaEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_tree_mst_boruvka_edge_make(size : Int) -> GraphtreemstboruvkaEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_tree_mst_boruvka_edge_len(s : GraphtreemstboruvkaEdge) -> Int { s.size }

pub fn graph_tree_mst_boruvka_edge_get(s : GraphtreemstboruvkaEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_tree_mst_boruvka_edge_set(s : GraphtreemstboruvkaEdge, i : Int, v : Double) -> GraphtreemstboruvkaEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_tree_mst_boruvka_edge_sum(s : GraphtreemstboruvkaEdge) -> Double { @_common.sum(s.data) }

pub fn graph_tree_mst_boruvka_edge_mean(s : GraphtreemstboruvkaEdge) -> Double { @_common.mean(s.data) }

pub fn graph_tree_mst_boruvka_edge_scale(s : GraphtreemstboruvkaEdge, f : Double) -> GraphtreemstboruvkaEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_tree_mst_boruvka_edge_add(a : GraphtreemstboruvkaEdge, b : GraphtreemstboruvkaEdge) -> GraphtreemstboruvkaEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_tree_mst_boruvka_edge_copy(s : GraphtreemstboruvkaEdge) -> GraphtreemstboruvkaEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_tree_mst_boruvka_edge_fill(s : GraphtreemstboruvkaEdge, v : Double) -> GraphtreemstboruvkaEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_tree_mst_boruvka_edge_min(s : GraphtreemstboruvkaEdge) -> Double { @_common.min(s.data) }

pub fn graph_tree_mst_boruvka_edge_max(s : GraphtreemstboruvkaEdge) -> Double { @_common.max(s.data) }

pub fn graph_tree_mst_boruvka_edge_to_string(s : GraphtreemstboruvkaEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphtreemstboruvkaPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_tree_mst_boruvka_path_make(size : Int) -> GraphtreemstboruvkaPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_tree_mst_boruvka_path_len(s : GraphtreemstboruvkaPath) -> Int { s.size }

pub fn graph_tree_mst_boruvka_path_get(s : GraphtreemstboruvkaPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_tree_mst_boruvka_path_set(s : GraphtreemstboruvkaPath, i : Int, v : Double) -> GraphtreemstboruvkaPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_tree_mst_boruvka_path_sum(s : GraphtreemstboruvkaPath) -> Double { @_common.sum(s.data) }

pub fn graph_tree_mst_boruvka_path_mean(s : GraphtreemstboruvkaPath) -> Double { @_common.mean(s.data) }

pub fn graph_tree_mst_boruvka_path_scale(s : GraphtreemstboruvkaPath, f : Double) -> GraphtreemstboruvkaPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_tree_mst_boruvka_path_add(a : GraphtreemstboruvkaPath, b : GraphtreemstboruvkaPath) -> GraphtreemstboruvkaPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_tree_mst_boruvka_path_copy(s : GraphtreemstboruvkaPath) -> GraphtreemstboruvkaPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_tree_mst_boruvka_path_fill(s : GraphtreemstboruvkaPath, v : Double) -> GraphtreemstboruvkaPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_tree_mst_boruvka_path_min(s : GraphtreemstboruvkaPath) -> Double { @_common.min(s.data) }

pub fn graph_tree_mst_boruvka_path_max(s : GraphtreemstboruvkaPath) -> Double { @_common.max(s.data) }

pub fn graph_tree_mst_boruvka_path_to_string(s : GraphtreemstboruvkaPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphtreemstboruvkaCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_tree_mst_boruvka_cluster_make(size : Int) -> GraphtreemstboruvkaCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_tree_mst_boruvka_cluster_len(s : GraphtreemstboruvkaCluster) -> Int { s.size }

pub fn graph_tree_mst_boruvka_cluster_get(s : GraphtreemstboruvkaCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_tree_mst_boruvka_cluster_set(s : GraphtreemstboruvkaCluster, i : Int, v : Double) -> GraphtreemstboruvkaCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_tree_mst_boruvka_cluster_sum(s : GraphtreemstboruvkaCluster) -> Double { @_common.sum(s.data) }

pub fn graph_tree_mst_boruvka_cluster_mean(s : GraphtreemstboruvkaCluster) -> Double { @_common.mean(s.data) }

pub fn graph_tree_mst_boruvka_cluster_scale(s : GraphtreemstboruvkaCluster, f : Double) -> GraphtreemstboruvkaCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_tree_mst_boruvka_cluster_add(a : GraphtreemstboruvkaCluster, b : GraphtreemstboruvkaCluster) -> GraphtreemstboruvkaCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_tree_mst_boruvka_cluster_copy(s : GraphtreemstboruvkaCluster) -> GraphtreemstboruvkaCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_tree_mst_boruvka_cluster_fill(s : GraphtreemstboruvkaCluster, v : Double) -> GraphtreemstboruvkaCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_tree_mst_boruvka_cluster_min(s : GraphtreemstboruvkaCluster) -> Double { @_common.min(s.data) }

pub fn graph_tree_mst_boruvka_cluster_max(s : GraphtreemstboruvkaCluster) -> Double { @_common.max(s.data) }

pub fn graph_tree_mst_boruvka_cluster_to_string(s : GraphtreemstboruvkaCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphtreemstboruvkaModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_tree_mst_boruvka_model_make(size : Int) -> GraphtreemstboruvkaModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_tree_mst_boruvka_model_len(s : GraphtreemstboruvkaModel) -> Int { s.size }

pub fn graph_tree_mst_boruvka_model_get(s : GraphtreemstboruvkaModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_tree_mst_boruvka_model_set(s : GraphtreemstboruvkaModel, i : Int, v : Double) -> GraphtreemstboruvkaModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_tree_mst_boruvka_model_sum(s : GraphtreemstboruvkaModel) -> Double { @_common.sum(s.data) }

pub fn graph_tree_mst_boruvka_model_mean(s : GraphtreemstboruvkaModel) -> Double { @_common.mean(s.data) }

pub fn graph_tree_mst_boruvka_model_scale(s : GraphtreemstboruvkaModel, f : Double) -> GraphtreemstboruvkaModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_tree_mst_boruvka_model_add(a : GraphtreemstboruvkaModel, b : GraphtreemstboruvkaModel) -> GraphtreemstboruvkaModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_tree_mst_boruvka_model_copy(s : GraphtreemstboruvkaModel) -> GraphtreemstboruvkaModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_tree_mst_boruvka_model_fill(s : GraphtreemstboruvkaModel, v : Double) -> GraphtreemstboruvkaModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_tree_mst_boruvka_model_min(s : GraphtreemstboruvkaModel) -> Double { @_common.min(s.data) }

pub fn graph_tree_mst_boruvka_model_max(s : GraphtreemstboruvkaModel) -> Double { @_common.max(s.data) }

pub fn graph_tree_mst_boruvka_model_to_string(s : GraphtreemstboruvkaModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphtreemstboruvkaLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_tree_mst_boruvka_layer_make(size : Int) -> GraphtreemstboruvkaLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_tree_mst_boruvka_layer_len(s : GraphtreemstboruvkaLayer) -> Int { s.size }

pub fn graph_tree_mst_boruvka_layer_get(s : GraphtreemstboruvkaLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_tree_mst_boruvka_layer_set(s : GraphtreemstboruvkaLayer, i : Int, v : Double) -> GraphtreemstboruvkaLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_tree_mst_boruvka_layer_sum(s : GraphtreemstboruvkaLayer) -> Double { @_common.sum(s.data) }

pub fn graph_tree_mst_boruvka_layer_mean(s : GraphtreemstboruvkaLayer) -> Double { @_common.mean(s.data) }

pub fn graph_tree_mst_boruvka_layer_scale(s : GraphtreemstboruvkaLayer, f : Double) -> GraphtreemstboruvkaLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_tree_mst_boruvka_layer_add(a : GraphtreemstboruvkaLayer, b : GraphtreemstboruvkaLayer) -> GraphtreemstboruvkaLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_tree_mst_boruvka_layer_copy(s : GraphtreemstboruvkaLayer) -> GraphtreemstboruvkaLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_tree_mst_boruvka_layer_fill(s : GraphtreemstboruvkaLayer, v : Double) -> GraphtreemstboruvkaLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_tree_mst_boruvka_layer_min(s : GraphtreemstboruvkaLayer) -> Double { @_common.min(s.data) }

pub fn graph_tree_mst_boruvka_layer_max(s : GraphtreemstboruvkaLayer) -> Double { @_common.max(s.data) }

pub fn graph_tree_mst_boruvka_layer_to_string(s : GraphtreemstboruvkaLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphtreemstboruvkaBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_tree_mst_boruvka_buffer_make(size : Int) -> GraphtreemstboruvkaBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_tree_mst_boruvka_buffer_len(s : GraphtreemstboruvkaBuffer) -> Int { s.size }

pub fn graph_tree_mst_boruvka_buffer_get(s : GraphtreemstboruvkaBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_tree_mst_boruvka_buffer_set(s : GraphtreemstboruvkaBuffer, i : Int, v : Double) -> GraphtreemstboruvkaBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_tree_mst_boruvka_buffer_sum(s : GraphtreemstboruvkaBuffer) -> Double { @_common.sum(s.data) }

pub fn graph_tree_mst_boruvka_buffer_mean(s : GraphtreemstboruvkaBuffer) -> Double { @_common.mean(s.data) }

pub fn graph_tree_mst_boruvka_buffer_scale(s : GraphtreemstboruvkaBuffer, f : Double) -> GraphtreemstboruvkaBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_tree_mst_boruvka_buffer_add(a : GraphtreemstboruvkaBuffer, b : GraphtreemstboruvkaBuffer) -> GraphtreemstboruvkaBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_tree_mst_boruvka_buffer_copy(s : GraphtreemstboruvkaBuffer) -> GraphtreemstboruvkaBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_tree_mst_boruvka_buffer_fill(s : GraphtreemstboruvkaBuffer, v : Double) -> GraphtreemstboruvkaBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_tree_mst_boruvka_buffer_min(s : GraphtreemstboruvkaBuffer) -> Double { @_common.min(s.data) }

pub fn graph_tree_mst_boruvka_buffer_max(s : GraphtreemstboruvkaBuffer) -> Double { @_common.max(s.data) }

pub fn graph_tree_mst_boruvka_buffer_to_string(s : GraphtreemstboruvkaBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphtreemstboruvkaCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_tree_mst_boruvka_cursor_make(size : Int) -> GraphtreemstboruvkaCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_tree_mst_boruvka_cursor_len(s : GraphtreemstboruvkaCursor) -> Int { s.size }

pub fn graph_tree_mst_boruvka_cursor_get(s : GraphtreemstboruvkaCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_tree_mst_boruvka_cursor_set(s : GraphtreemstboruvkaCursor, i : Int, v : Double) -> GraphtreemstboruvkaCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_tree_mst_boruvka_cursor_sum(s : GraphtreemstboruvkaCursor) -> Double { @_common.sum(s.data) }

pub fn graph_tree_mst_boruvka_cursor_mean(s : GraphtreemstboruvkaCursor) -> Double { @_common.mean(s.data) }

pub fn graph_tree_mst_boruvka_cursor_scale(s : GraphtreemstboruvkaCursor, f : Double) -> GraphtreemstboruvkaCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_tree_mst_boruvka_cursor_add(a : GraphtreemstboruvkaCursor, b : GraphtreemstboruvkaCursor) -> GraphtreemstboruvkaCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_tree_mst_boruvka_cursor_copy(s : GraphtreemstboruvkaCursor) -> GraphtreemstboruvkaCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_tree_mst_boruvka_cursor_fill(s : GraphtreemstboruvkaCursor, v : Double) -> GraphtreemstboruvkaCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_tree_mst_boruvka_cursor_min(s : GraphtreemstboruvkaCursor) -> Double { @_common.min(s.data) }

pub fn graph_tree_mst_boruvka_cursor_max(s : GraphtreemstboruvkaCursor) -> Double { @_common.max(s.data) }

pub fn graph_tree_mst_boruvka_cursor_to_string(s : GraphtreemstboruvkaCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphtreemstboruvkaView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_tree_mst_boruvka_view_make(size : Int) -> GraphtreemstboruvkaView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_tree_mst_boruvka_view_len(s : GraphtreemstboruvkaView) -> Int { s.size }

pub fn graph_tree_mst_boruvka_view_get(s : GraphtreemstboruvkaView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_tree_mst_boruvka_view_set(s : GraphtreemstboruvkaView, i : Int, v : Double) -> GraphtreemstboruvkaView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_tree_mst_boruvka_view_sum(s : GraphtreemstboruvkaView) -> Double { @_common.sum(s.data) }

pub fn graph_tree_mst_boruvka_view_mean(s : GraphtreemstboruvkaView) -> Double { @_common.mean(s.data) }

pub fn graph_tree_mst_boruvka_view_scale(s : GraphtreemstboruvkaView, f : Double) -> GraphtreemstboruvkaView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_tree_mst_boruvka_view_add(a : GraphtreemstboruvkaView, b : GraphtreemstboruvkaView) -> GraphtreemstboruvkaView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_tree_mst_boruvka_view_copy(s : GraphtreemstboruvkaView) -> GraphtreemstboruvkaView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_tree_mst_boruvka_view_fill(s : GraphtreemstboruvkaView, v : Double) -> GraphtreemstboruvkaView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_tree_mst_boruvka_view_min(s : GraphtreemstboruvkaView) -> Double { @_common.min(s.data) }

pub fn graph_tree_mst_boruvka_view_max(s : GraphtreemstboruvkaView) -> Double { @_common.max(s.data) }

pub fn graph_tree_mst_boruvka_view_to_string(s : GraphtreemstboruvkaView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphtreemstboruvkaRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_tree_mst_boruvka_range_make(size : Int) -> GraphtreemstboruvkaRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_tree_mst_boruvka_range_len(s : GraphtreemstboruvkaRange) -> Int { s.size }

pub fn graph_tree_mst_boruvka_range_get(s : GraphtreemstboruvkaRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_tree_mst_boruvka_range_set(s : GraphtreemstboruvkaRange, i : Int, v : Double) -> GraphtreemstboruvkaRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_tree_mst_boruvka_range_sum(s : GraphtreemstboruvkaRange) -> Double { @_common.sum(s.data) }

pub fn graph_tree_mst_boruvka_range_mean(s : GraphtreemstboruvkaRange) -> Double { @_common.mean(s.data) }

pub fn graph_tree_mst_boruvka_range_scale(s : GraphtreemstboruvkaRange, f : Double) -> GraphtreemstboruvkaRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_tree_mst_boruvka_range_add(a : GraphtreemstboruvkaRange, b : GraphtreemstboruvkaRange) -> GraphtreemstboruvkaRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_tree_mst_boruvka_range_copy(s : GraphtreemstboruvkaRange) -> GraphtreemstboruvkaRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_tree_mst_boruvka_range_fill(s : GraphtreemstboruvkaRange, v : Double) -> GraphtreemstboruvkaRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_tree_mst_boruvka_range_min(s : GraphtreemstboruvkaRange) -> Double { @_common.min(s.data) }

pub fn graph_tree_mst_boruvka_range_max(s : GraphtreemstboruvkaRange) -> Double { @_common.max(s.data) }

pub fn graph_tree_mst_boruvka_range_to_string(s : GraphtreemstboruvkaRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphtreemstboruvkaSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_tree_mst_boruvka_slice_make(size : Int) -> GraphtreemstboruvkaSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_tree_mst_boruvka_slice_len(s : GraphtreemstboruvkaSlice) -> Int { s.size }

pub fn graph_tree_mst_boruvka_slice_get(s : GraphtreemstboruvkaSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_tree_mst_boruvka_slice_set(s : GraphtreemstboruvkaSlice, i : Int, v : Double) -> GraphtreemstboruvkaSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_tree_mst_boruvka_slice_sum(s : GraphtreemstboruvkaSlice) -> Double { @_common.sum(s.data) }

pub fn graph_tree_mst_boruvka_slice_mean(s : GraphtreemstboruvkaSlice) -> Double { @_common.mean(s.data) }

pub fn graph_tree_mst_boruvka_slice_scale(s : GraphtreemstboruvkaSlice, f : Double) -> GraphtreemstboruvkaSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_tree_mst_boruvka_slice_add(a : GraphtreemstboruvkaSlice, b : GraphtreemstboruvkaSlice) -> GraphtreemstboruvkaSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_tree_mst_boruvka_slice_copy(s : GraphtreemstboruvkaSlice) -> GraphtreemstboruvkaSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_tree_mst_boruvka_slice_fill(s : GraphtreemstboruvkaSlice, v : Double) -> GraphtreemstboruvkaSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_tree_mst_boruvka_slice_min(s : GraphtreemstboruvkaSlice) -> Double { @_common.min(s.data) }

pub fn graph_tree_mst_boruvka_slice_max(s : GraphtreemstboruvkaSlice) -> Double { @_common.max(s.data) }

pub fn graph_tree_mst_boruvka_slice_to_string(s : GraphtreemstboruvkaSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

