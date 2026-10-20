///===
/// extcore/graph_tree_mst

pub(all) struct GraphtreemstPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn graph_tree_mst_make_point(x : Double, y : Double) -> GraphtreemstPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn graph_tree_mst_make_point3(x : Double, y : Double, z : Double) -> GraphtreemstPoint {
  { x, y, z, label: 0 }
}

pub fn GraphtreemstPoint::x(self : GraphtreemstPoint) -> Double { self.x }

pub fn GraphtreemstPoint::y(self : GraphtreemstPoint) -> Double { self.y }

pub fn GraphtreemstPoint::z(self : GraphtreemstPoint) -> Double { self.z }

pub fn GraphtreemstPoint::label(self : GraphtreemstPoint) -> Int { self.label }

pub fn GraphtreemstPoint::dist(self : GraphtreemstPoint, other : GraphtreemstPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn GraphtreemstPoint::add(self : GraphtreemstPoint, other : GraphtreemstPoint) -> GraphtreemstPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn GraphtreemstPoint::sub(self : GraphtreemstPoint, other : GraphtreemstPoint) -> GraphtreemstPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn GraphtreemstPoint::scale(self : GraphtreemstPoint, s : Double) -> GraphtreemstPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn GraphtreemstPoint::dot(self : GraphtreemstPoint, other : GraphtreemstPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn GraphtreemstPoint::cross(self : GraphtreemstPoint, other : GraphtreemstPoint) -> GraphtreemstPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn GraphtreemstPoint::norm(self : GraphtreemstPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn GraphtreemstPoint::normalize(self : GraphtreemstPoint) -> GraphtreemstPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn GraphtreemstPoint::negate(self : GraphtreemstPoint) -> GraphtreemstPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn GraphtreemstPoint::mid(self : GraphtreemstPoint, other : GraphtreemstPoint) -> GraphtreemstPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn GraphtreemstPoint::lerp(self : GraphtreemstPoint, other : GraphtreemstPoint, t : Double) -> GraphtreemstPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn GraphtreemstPoint::to_string(self : GraphtreemstPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct GraphtreemstSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn graph_tree_mst_make_series(vals : Array[Double], name : String) -> GraphtreemstSeries {
  { vals, name, meta: 0 }
}

pub fn GraphtreemstSeries::len(self : GraphtreemstSeries) -> Int { self.vals.length() }

pub fn GraphtreemstSeries::sum(self : GraphtreemstSeries) -> Double { @_common.sum(self.vals) }

pub fn GraphtreemstSeries::mean(self : GraphtreemstSeries) -> Double { @_common.mean(self.vals) }

pub fn GraphtreemstSeries::min(self : GraphtreemstSeries) -> Double { @_common.min(self.vals) }

pub fn GraphtreemstSeries::max(self : GraphtreemstSeries) -> Double { @_common.max(self.vals) }

pub fn GraphtreemstSeries::range(self : GraphtreemstSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn GraphtreemstSeries::variance(self : GraphtreemstSeries) -> Double { @_common.variance(self.vals) }

pub fn GraphtreemstSeries::std(self : GraphtreemstSeries) -> Double { @_common.std(self.vals) }

pub fn GraphtreemstSeries::median(self : GraphtreemstSeries) -> Double { @_common.median(self.vals) }

pub fn GraphtreemstSeries::scale(self : GraphtreemstSeries, f : Double) -> GraphtreemstSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn GraphtreemstSeries::add(self : GraphtreemstSeries, other : GraphtreemstSeries) -> GraphtreemstSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn GraphtreemstSeries::sub(self : GraphtreemstSeries, other : GraphtreemstSeries) -> GraphtreemstSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn GraphtreemstSeries::normalize(self : GraphtreemstSeries) -> GraphtreemstSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn GraphtreemstSeries::cumsum(self : GraphtreemstSeries) -> GraphtreemstSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn GraphtreemstSeries::to_string(self : GraphtreemstSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct GraphtreemstMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn graph_tree_mst_make_matrix(rows : Int, cols : Int, val : Double) -> GraphtreemstMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn graph_tree_mst_matrix_identity(n : Int) -> GraphtreemstMatrix {
  let m = graph_tree_mst_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn GraphtreemstMatrix::get(self : GraphtreemstMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn GraphtreemstMatrix::transpose(self : GraphtreemstMatrix) -> GraphtreemstMatrix {
  let result = graph_tree_mst_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn GraphtreemstMatrix::add(self : GraphtreemstMatrix, other : GraphtreemstMatrix) -> GraphtreemstMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = graph_tree_mst_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn GraphtreemstMatrix::scale(self : GraphtreemstMatrix, s : Double) -> GraphtreemstMatrix {
  let result = graph_tree_mst_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn GraphtreemstMatrix::multiply(self : GraphtreemstMatrix, other : GraphtreemstMatrix) -> GraphtreemstMatrix {
  if self.cols != other.rows { return graph_tree_mst_make_matrix(self.rows, other.cols, 0.0) }
  let result = graph_tree_mst_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn GraphtreemstMatrix::trace(self : GraphtreemstMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn GraphtreemstMatrix::det(self : GraphtreemstMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn GraphtreemstMatrix::norm(self : GraphtreemstMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn GraphtreemstMatrix::to_string(self : GraphtreemstMatrix) -> String {
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

pub(all) struct GraphtreemstVector {
  comps : Array[Double]
  dim : Int
}

pub fn graph_tree_mst_make_vector(comps : Array[Double]) -> GraphtreemstVector {
  { comps, dim: comps.length() }
}

pub fn graph_tree_mst_vector_zero(dim : Int) -> GraphtreemstVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn GraphtreemstVector::add(self : GraphtreemstVector, other : GraphtreemstVector) -> GraphtreemstVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn GraphtreemstVector::sub(self : GraphtreemstVector, other : GraphtreemstVector) -> GraphtreemstVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn GraphtreemstVector::scale(self : GraphtreemstVector, s : Double) -> GraphtreemstVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn GraphtreemstVector::dot(self : GraphtreemstVector, other : GraphtreemstVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn GraphtreemstVector::norm(self : GraphtreemstVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn GraphtreemstVector::normalize(self : GraphtreemstVector) -> GraphtreemstVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn GraphtreemstVector::dist(self : GraphtreemstVector, other : GraphtreemstVector) -> Double {
  self.sub(other).norm()
}

pub fn GraphtreemstVector::to_string(self : GraphtreemstVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn graph_tree_mst_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn graph_tree_mst_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn graph_tree_mst_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn graph_tree_mst_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn graph_tree_mst_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn graph_tree_mst_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn graph_tree_mst_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn graph_tree_mst_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn graph_tree_mst_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn graph_tree_mst_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn graph_tree_mst_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn graph_tree_mst_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn graph_tree_mst_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn graph_tree_mst_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn graph_tree_mst_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn graph_tree_mst_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn graph_tree_mst_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn graph_tree_mst_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn graph_tree_mst_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn graph_tree_mst_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn graph_tree_mst_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn graph_tree_mst_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn graph_tree_mst_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn graph_tree_mst_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn graph_tree_mst_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn graph_tree_mst_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn graph_tree_mst_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn graph_tree_mst_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn graph_tree_mst_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct GraphtreemstFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_tree_mst_frame_make(size : Int) -> GraphtreemstFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_tree_mst_frame_len(s : GraphtreemstFrame) -> Int { s.size }

pub fn graph_tree_mst_frame_get(s : GraphtreemstFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_tree_mst_frame_set(s : GraphtreemstFrame, i : Int, v : Double) -> GraphtreemstFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_tree_mst_frame_sum(s : GraphtreemstFrame) -> Double { @_common.sum(s.data) }

pub fn graph_tree_mst_frame_mean(s : GraphtreemstFrame) -> Double { @_common.mean(s.data) }

pub fn graph_tree_mst_frame_scale(s : GraphtreemstFrame, f : Double) -> GraphtreemstFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_tree_mst_frame_add(a : GraphtreemstFrame, b : GraphtreemstFrame) -> GraphtreemstFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_tree_mst_frame_copy(s : GraphtreemstFrame) -> GraphtreemstFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_tree_mst_frame_fill(s : GraphtreemstFrame, v : Double) -> GraphtreemstFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_tree_mst_frame_min(s : GraphtreemstFrame) -> Double { @_common.min(s.data) }

pub fn graph_tree_mst_frame_max(s : GraphtreemstFrame) -> Double { @_common.max(s.data) }

pub fn graph_tree_mst_frame_to_string(s : GraphtreemstFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphtreemstTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_tree_mst_table_make(size : Int) -> GraphtreemstTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_tree_mst_table_len(s : GraphtreemstTable) -> Int { s.size }

pub fn graph_tree_mst_table_get(s : GraphtreemstTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_tree_mst_table_set(s : GraphtreemstTable, i : Int, v : Double) -> GraphtreemstTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_tree_mst_table_sum(s : GraphtreemstTable) -> Double { @_common.sum(s.data) }

pub fn graph_tree_mst_table_mean(s : GraphtreemstTable) -> Double { @_common.mean(s.data) }

pub fn graph_tree_mst_table_scale(s : GraphtreemstTable, f : Double) -> GraphtreemstTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_tree_mst_table_add(a : GraphtreemstTable, b : GraphtreemstTable) -> GraphtreemstTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_tree_mst_table_copy(s : GraphtreemstTable) -> GraphtreemstTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_tree_mst_table_fill(s : GraphtreemstTable, v : Double) -> GraphtreemstTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_tree_mst_table_min(s : GraphtreemstTable) -> Double { @_common.min(s.data) }

pub fn graph_tree_mst_table_max(s : GraphtreemstTable) -> Double { @_common.max(s.data) }

pub fn graph_tree_mst_table_to_string(s : GraphtreemstTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphtreemstGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_tree_mst_graphn_make(size : Int) -> GraphtreemstGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_tree_mst_graphn_len(s : GraphtreemstGraphN) -> Int { s.size }

pub fn graph_tree_mst_graphn_get(s : GraphtreemstGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_tree_mst_graphn_set(s : GraphtreemstGraphN, i : Int, v : Double) -> GraphtreemstGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_tree_mst_graphn_sum(s : GraphtreemstGraphN) -> Double { @_common.sum(s.data) }

pub fn graph_tree_mst_graphn_mean(s : GraphtreemstGraphN) -> Double { @_common.mean(s.data) }

pub fn graph_tree_mst_graphn_scale(s : GraphtreemstGraphN, f : Double) -> GraphtreemstGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_tree_mst_graphn_add(a : GraphtreemstGraphN, b : GraphtreemstGraphN) -> GraphtreemstGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_tree_mst_graphn_copy(s : GraphtreemstGraphN) -> GraphtreemstGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_tree_mst_graphn_fill(s : GraphtreemstGraphN, v : Double) -> GraphtreemstGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_tree_mst_graphn_min(s : GraphtreemstGraphN) -> Double { @_common.min(s.data) }

pub fn graph_tree_mst_graphn_max(s : GraphtreemstGraphN) -> Double { @_common.max(s.data) }

pub fn graph_tree_mst_graphn_to_string(s : GraphtreemstGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphtreemstNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_tree_mst_node_make(size : Int) -> GraphtreemstNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_tree_mst_node_len(s : GraphtreemstNode) -> Int { s.size }

pub fn graph_tree_mst_node_get(s : GraphtreemstNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_tree_mst_node_set(s : GraphtreemstNode, i : Int, v : Double) -> GraphtreemstNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_tree_mst_node_sum(s : GraphtreemstNode) -> Double { @_common.sum(s.data) }

pub fn graph_tree_mst_node_mean(s : GraphtreemstNode) -> Double { @_common.mean(s.data) }

pub fn graph_tree_mst_node_scale(s : GraphtreemstNode, f : Double) -> GraphtreemstNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_tree_mst_node_add(a : GraphtreemstNode, b : GraphtreemstNode) -> GraphtreemstNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_tree_mst_node_copy(s : GraphtreemstNode) -> GraphtreemstNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_tree_mst_node_fill(s : GraphtreemstNode, v : Double) -> GraphtreemstNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_tree_mst_node_min(s : GraphtreemstNode) -> Double { @_common.min(s.data) }

pub fn graph_tree_mst_node_max(s : GraphtreemstNode) -> Double { @_common.max(s.data) }

pub fn graph_tree_mst_node_to_string(s : GraphtreemstNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphtreemstEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_tree_mst_edge_make(size : Int) -> GraphtreemstEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_tree_mst_edge_len(s : GraphtreemstEdge) -> Int { s.size }

pub fn graph_tree_mst_edge_get(s : GraphtreemstEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_tree_mst_edge_set(s : GraphtreemstEdge, i : Int, v : Double) -> GraphtreemstEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_tree_mst_edge_sum(s : GraphtreemstEdge) -> Double { @_common.sum(s.data) }

pub fn graph_tree_mst_edge_mean(s : GraphtreemstEdge) -> Double { @_common.mean(s.data) }

pub fn graph_tree_mst_edge_scale(s : GraphtreemstEdge, f : Double) -> GraphtreemstEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_tree_mst_edge_add(a : GraphtreemstEdge, b : GraphtreemstEdge) -> GraphtreemstEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_tree_mst_edge_copy(s : GraphtreemstEdge) -> GraphtreemstEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_tree_mst_edge_fill(s : GraphtreemstEdge, v : Double) -> GraphtreemstEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_tree_mst_edge_min(s : GraphtreemstEdge) -> Double { @_common.min(s.data) }

pub fn graph_tree_mst_edge_max(s : GraphtreemstEdge) -> Double { @_common.max(s.data) }

pub fn graph_tree_mst_edge_to_string(s : GraphtreemstEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphtreemstPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_tree_mst_path_make(size : Int) -> GraphtreemstPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_tree_mst_path_len(s : GraphtreemstPath) -> Int { s.size }

pub fn graph_tree_mst_path_get(s : GraphtreemstPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_tree_mst_path_set(s : GraphtreemstPath, i : Int, v : Double) -> GraphtreemstPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_tree_mst_path_sum(s : GraphtreemstPath) -> Double { @_common.sum(s.data) }

pub fn graph_tree_mst_path_mean(s : GraphtreemstPath) -> Double { @_common.mean(s.data) }

pub fn graph_tree_mst_path_scale(s : GraphtreemstPath, f : Double) -> GraphtreemstPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_tree_mst_path_add(a : GraphtreemstPath, b : GraphtreemstPath) -> GraphtreemstPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_tree_mst_path_copy(s : GraphtreemstPath) -> GraphtreemstPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_tree_mst_path_fill(s : GraphtreemstPath, v : Double) -> GraphtreemstPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_tree_mst_path_min(s : GraphtreemstPath) -> Double { @_common.min(s.data) }

pub fn graph_tree_mst_path_max(s : GraphtreemstPath) -> Double { @_common.max(s.data) }

pub fn graph_tree_mst_path_to_string(s : GraphtreemstPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphtreemstCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_tree_mst_cluster_make(size : Int) -> GraphtreemstCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_tree_mst_cluster_len(s : GraphtreemstCluster) -> Int { s.size }

pub fn graph_tree_mst_cluster_get(s : GraphtreemstCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_tree_mst_cluster_set(s : GraphtreemstCluster, i : Int, v : Double) -> GraphtreemstCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_tree_mst_cluster_sum(s : GraphtreemstCluster) -> Double { @_common.sum(s.data) }

pub fn graph_tree_mst_cluster_mean(s : GraphtreemstCluster) -> Double { @_common.mean(s.data) }

pub fn graph_tree_mst_cluster_scale(s : GraphtreemstCluster, f : Double) -> GraphtreemstCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_tree_mst_cluster_add(a : GraphtreemstCluster, b : GraphtreemstCluster) -> GraphtreemstCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_tree_mst_cluster_copy(s : GraphtreemstCluster) -> GraphtreemstCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_tree_mst_cluster_fill(s : GraphtreemstCluster, v : Double) -> GraphtreemstCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_tree_mst_cluster_min(s : GraphtreemstCluster) -> Double { @_common.min(s.data) }

pub fn graph_tree_mst_cluster_max(s : GraphtreemstCluster) -> Double { @_common.max(s.data) }

pub fn graph_tree_mst_cluster_to_string(s : GraphtreemstCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphtreemstModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_tree_mst_model_make(size : Int) -> GraphtreemstModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_tree_mst_model_len(s : GraphtreemstModel) -> Int { s.size }

pub fn graph_tree_mst_model_get(s : GraphtreemstModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_tree_mst_model_set(s : GraphtreemstModel, i : Int, v : Double) -> GraphtreemstModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_tree_mst_model_sum(s : GraphtreemstModel) -> Double { @_common.sum(s.data) }

pub fn graph_tree_mst_model_mean(s : GraphtreemstModel) -> Double { @_common.mean(s.data) }

pub fn graph_tree_mst_model_scale(s : GraphtreemstModel, f : Double) -> GraphtreemstModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_tree_mst_model_add(a : GraphtreemstModel, b : GraphtreemstModel) -> GraphtreemstModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_tree_mst_model_copy(s : GraphtreemstModel) -> GraphtreemstModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_tree_mst_model_fill(s : GraphtreemstModel, v : Double) -> GraphtreemstModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_tree_mst_model_min(s : GraphtreemstModel) -> Double { @_common.min(s.data) }

pub fn graph_tree_mst_model_max(s : GraphtreemstModel) -> Double { @_common.max(s.data) }

pub fn graph_tree_mst_model_to_string(s : GraphtreemstModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphtreemstLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_tree_mst_layer_make(size : Int) -> GraphtreemstLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_tree_mst_layer_len(s : GraphtreemstLayer) -> Int { s.size }

pub fn graph_tree_mst_layer_get(s : GraphtreemstLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_tree_mst_layer_set(s : GraphtreemstLayer, i : Int, v : Double) -> GraphtreemstLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_tree_mst_layer_sum(s : GraphtreemstLayer) -> Double { @_common.sum(s.data) }

pub fn graph_tree_mst_layer_mean(s : GraphtreemstLayer) -> Double { @_common.mean(s.data) }

pub fn graph_tree_mst_layer_scale(s : GraphtreemstLayer, f : Double) -> GraphtreemstLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_tree_mst_layer_add(a : GraphtreemstLayer, b : GraphtreemstLayer) -> GraphtreemstLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_tree_mst_layer_copy(s : GraphtreemstLayer) -> GraphtreemstLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_tree_mst_layer_fill(s : GraphtreemstLayer, v : Double) -> GraphtreemstLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_tree_mst_layer_min(s : GraphtreemstLayer) -> Double { @_common.min(s.data) }

pub fn graph_tree_mst_layer_max(s : GraphtreemstLayer) -> Double { @_common.max(s.data) }

pub fn graph_tree_mst_layer_to_string(s : GraphtreemstLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphtreemstBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_tree_mst_buffer_make(size : Int) -> GraphtreemstBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_tree_mst_buffer_len(s : GraphtreemstBuffer) -> Int { s.size }

pub fn graph_tree_mst_buffer_get(s : GraphtreemstBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_tree_mst_buffer_set(s : GraphtreemstBuffer, i : Int, v : Double) -> GraphtreemstBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_tree_mst_buffer_sum(s : GraphtreemstBuffer) -> Double { @_common.sum(s.data) }

pub fn graph_tree_mst_buffer_mean(s : GraphtreemstBuffer) -> Double { @_common.mean(s.data) }

pub fn graph_tree_mst_buffer_scale(s : GraphtreemstBuffer, f : Double) -> GraphtreemstBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_tree_mst_buffer_add(a : GraphtreemstBuffer, b : GraphtreemstBuffer) -> GraphtreemstBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_tree_mst_buffer_copy(s : GraphtreemstBuffer) -> GraphtreemstBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_tree_mst_buffer_fill(s : GraphtreemstBuffer, v : Double) -> GraphtreemstBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_tree_mst_buffer_min(s : GraphtreemstBuffer) -> Double { @_common.min(s.data) }

pub fn graph_tree_mst_buffer_max(s : GraphtreemstBuffer) -> Double { @_common.max(s.data) }

pub fn graph_tree_mst_buffer_to_string(s : GraphtreemstBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphtreemstCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_tree_mst_cursor_make(size : Int) -> GraphtreemstCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_tree_mst_cursor_len(s : GraphtreemstCursor) -> Int { s.size }

pub fn graph_tree_mst_cursor_get(s : GraphtreemstCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_tree_mst_cursor_set(s : GraphtreemstCursor, i : Int, v : Double) -> GraphtreemstCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_tree_mst_cursor_sum(s : GraphtreemstCursor) -> Double { @_common.sum(s.data) }

pub fn graph_tree_mst_cursor_mean(s : GraphtreemstCursor) -> Double { @_common.mean(s.data) }

pub fn graph_tree_mst_cursor_scale(s : GraphtreemstCursor, f : Double) -> GraphtreemstCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_tree_mst_cursor_add(a : GraphtreemstCursor, b : GraphtreemstCursor) -> GraphtreemstCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_tree_mst_cursor_copy(s : GraphtreemstCursor) -> GraphtreemstCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_tree_mst_cursor_fill(s : GraphtreemstCursor, v : Double) -> GraphtreemstCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_tree_mst_cursor_min(s : GraphtreemstCursor) -> Double { @_common.min(s.data) }

pub fn graph_tree_mst_cursor_max(s : GraphtreemstCursor) -> Double { @_common.max(s.data) }

pub fn graph_tree_mst_cursor_to_string(s : GraphtreemstCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphtreemstView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_tree_mst_view_make(size : Int) -> GraphtreemstView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_tree_mst_view_len(s : GraphtreemstView) -> Int { s.size }

pub fn graph_tree_mst_view_get(s : GraphtreemstView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_tree_mst_view_set(s : GraphtreemstView, i : Int, v : Double) -> GraphtreemstView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_tree_mst_view_sum(s : GraphtreemstView) -> Double { @_common.sum(s.data) }

pub fn graph_tree_mst_view_mean(s : GraphtreemstView) -> Double { @_common.mean(s.data) }

pub fn graph_tree_mst_view_scale(s : GraphtreemstView, f : Double) -> GraphtreemstView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_tree_mst_view_add(a : GraphtreemstView, b : GraphtreemstView) -> GraphtreemstView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_tree_mst_view_copy(s : GraphtreemstView) -> GraphtreemstView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_tree_mst_view_fill(s : GraphtreemstView, v : Double) -> GraphtreemstView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_tree_mst_view_min(s : GraphtreemstView) -> Double { @_common.min(s.data) }

pub fn graph_tree_mst_view_max(s : GraphtreemstView) -> Double { @_common.max(s.data) }

pub fn graph_tree_mst_view_to_string(s : GraphtreemstView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphtreemstRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_tree_mst_range_make(size : Int) -> GraphtreemstRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_tree_mst_range_len(s : GraphtreemstRange) -> Int { s.size }

pub fn graph_tree_mst_range_get(s : GraphtreemstRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_tree_mst_range_set(s : GraphtreemstRange, i : Int, v : Double) -> GraphtreemstRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_tree_mst_range_sum(s : GraphtreemstRange) -> Double { @_common.sum(s.data) }

pub fn graph_tree_mst_range_mean(s : GraphtreemstRange) -> Double { @_common.mean(s.data) }

pub fn graph_tree_mst_range_scale(s : GraphtreemstRange, f : Double) -> GraphtreemstRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_tree_mst_range_add(a : GraphtreemstRange, b : GraphtreemstRange) -> GraphtreemstRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_tree_mst_range_copy(s : GraphtreemstRange) -> GraphtreemstRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_tree_mst_range_fill(s : GraphtreemstRange, v : Double) -> GraphtreemstRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_tree_mst_range_min(s : GraphtreemstRange) -> Double { @_common.min(s.data) }

pub fn graph_tree_mst_range_max(s : GraphtreemstRange) -> Double { @_common.max(s.data) }

pub fn graph_tree_mst_range_to_string(s : GraphtreemstRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphtreemstSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_tree_mst_slice_make(size : Int) -> GraphtreemstSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_tree_mst_slice_len(s : GraphtreemstSlice) -> Int { s.size }

pub fn graph_tree_mst_slice_get(s : GraphtreemstSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_tree_mst_slice_set(s : GraphtreemstSlice, i : Int, v : Double) -> GraphtreemstSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_tree_mst_slice_sum(s : GraphtreemstSlice) -> Double { @_common.sum(s.data) }

pub fn graph_tree_mst_slice_mean(s : GraphtreemstSlice) -> Double { @_common.mean(s.data) }

pub fn graph_tree_mst_slice_scale(s : GraphtreemstSlice, f : Double) -> GraphtreemstSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_tree_mst_slice_add(a : GraphtreemstSlice, b : GraphtreemstSlice) -> GraphtreemstSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_tree_mst_slice_copy(s : GraphtreemstSlice) -> GraphtreemstSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_tree_mst_slice_fill(s : GraphtreemstSlice, v : Double) -> GraphtreemstSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_tree_mst_slice_min(s : GraphtreemstSlice) -> Double { @_common.min(s.data) }

pub fn graph_tree_mst_slice_max(s : GraphtreemstSlice) -> Double { @_common.max(s.data) }

pub fn graph_tree_mst_slice_to_string(s : GraphtreemstSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

