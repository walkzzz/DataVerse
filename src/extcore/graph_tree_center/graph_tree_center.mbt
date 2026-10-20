///===
/// extcore/graph_tree_center

pub(all) struct GraphtreecenterPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn graph_tree_center_make_point(x : Double, y : Double) -> GraphtreecenterPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn graph_tree_center_make_point3(x : Double, y : Double, z : Double) -> GraphtreecenterPoint {
  { x, y, z, label: 0 }
}

pub fn GraphtreecenterPoint::x(self : GraphtreecenterPoint) -> Double { self.x }

pub fn GraphtreecenterPoint::y(self : GraphtreecenterPoint) -> Double { self.y }

pub fn GraphtreecenterPoint::z(self : GraphtreecenterPoint) -> Double { self.z }

pub fn GraphtreecenterPoint::label(self : GraphtreecenterPoint) -> Int { self.label }

pub fn GraphtreecenterPoint::dist(self : GraphtreecenterPoint, other : GraphtreecenterPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn GraphtreecenterPoint::add(self : GraphtreecenterPoint, other : GraphtreecenterPoint) -> GraphtreecenterPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn GraphtreecenterPoint::sub(self : GraphtreecenterPoint, other : GraphtreecenterPoint) -> GraphtreecenterPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn GraphtreecenterPoint::scale(self : GraphtreecenterPoint, s : Double) -> GraphtreecenterPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn GraphtreecenterPoint::dot(self : GraphtreecenterPoint, other : GraphtreecenterPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn GraphtreecenterPoint::cross(self : GraphtreecenterPoint, other : GraphtreecenterPoint) -> GraphtreecenterPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn GraphtreecenterPoint::norm(self : GraphtreecenterPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn GraphtreecenterPoint::normalize(self : GraphtreecenterPoint) -> GraphtreecenterPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn GraphtreecenterPoint::negate(self : GraphtreecenterPoint) -> GraphtreecenterPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn GraphtreecenterPoint::mid(self : GraphtreecenterPoint, other : GraphtreecenterPoint) -> GraphtreecenterPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn GraphtreecenterPoint::lerp(self : GraphtreecenterPoint, other : GraphtreecenterPoint, t : Double) -> GraphtreecenterPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn GraphtreecenterPoint::to_string(self : GraphtreecenterPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct GraphtreecenterSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn graph_tree_center_make_series(vals : Array[Double], name : String) -> GraphtreecenterSeries {
  { vals, name, meta: 0 }
}

pub fn GraphtreecenterSeries::len(self : GraphtreecenterSeries) -> Int { self.vals.length() }

pub fn GraphtreecenterSeries::sum(self : GraphtreecenterSeries) -> Double { @_common.sum(self.vals) }

pub fn GraphtreecenterSeries::mean(self : GraphtreecenterSeries) -> Double { @_common.mean(self.vals) }

pub fn GraphtreecenterSeries::min(self : GraphtreecenterSeries) -> Double { @_common.min(self.vals) }

pub fn GraphtreecenterSeries::max(self : GraphtreecenterSeries) -> Double { @_common.max(self.vals) }

pub fn GraphtreecenterSeries::range(self : GraphtreecenterSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn GraphtreecenterSeries::variance(self : GraphtreecenterSeries) -> Double { @_common.variance(self.vals) }

pub fn GraphtreecenterSeries::std(self : GraphtreecenterSeries) -> Double { @_common.std(self.vals) }

pub fn GraphtreecenterSeries::median(self : GraphtreecenterSeries) -> Double { @_common.median(self.vals) }

pub fn GraphtreecenterSeries::scale(self : GraphtreecenterSeries, f : Double) -> GraphtreecenterSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn GraphtreecenterSeries::add(self : GraphtreecenterSeries, other : GraphtreecenterSeries) -> GraphtreecenterSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn GraphtreecenterSeries::sub(self : GraphtreecenterSeries, other : GraphtreecenterSeries) -> GraphtreecenterSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn GraphtreecenterSeries::normalize(self : GraphtreecenterSeries) -> GraphtreecenterSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn GraphtreecenterSeries::cumsum(self : GraphtreecenterSeries) -> GraphtreecenterSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn GraphtreecenterSeries::to_string(self : GraphtreecenterSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct GraphtreecenterMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn graph_tree_center_make_matrix(rows : Int, cols : Int, val : Double) -> GraphtreecenterMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn graph_tree_center_matrix_identity(n : Int) -> GraphtreecenterMatrix {
  let m = graph_tree_center_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn GraphtreecenterMatrix::get(self : GraphtreecenterMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn GraphtreecenterMatrix::transpose(self : GraphtreecenterMatrix) -> GraphtreecenterMatrix {
  let result = graph_tree_center_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn GraphtreecenterMatrix::add(self : GraphtreecenterMatrix, other : GraphtreecenterMatrix) -> GraphtreecenterMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = graph_tree_center_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn GraphtreecenterMatrix::scale(self : GraphtreecenterMatrix, s : Double) -> GraphtreecenterMatrix {
  let result = graph_tree_center_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn GraphtreecenterMatrix::multiply(self : GraphtreecenterMatrix, other : GraphtreecenterMatrix) -> GraphtreecenterMatrix {
  if self.cols != other.rows { return graph_tree_center_make_matrix(self.rows, other.cols, 0.0) }
  let result = graph_tree_center_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn GraphtreecenterMatrix::trace(self : GraphtreecenterMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn GraphtreecenterMatrix::det(self : GraphtreecenterMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn GraphtreecenterMatrix::norm(self : GraphtreecenterMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn GraphtreecenterMatrix::to_string(self : GraphtreecenterMatrix) -> String {
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

pub(all) struct GraphtreecenterVector {
  comps : Array[Double]
  dim : Int
}

pub fn graph_tree_center_make_vector(comps : Array[Double]) -> GraphtreecenterVector {
  { comps, dim: comps.length() }
}

pub fn graph_tree_center_vector_zero(dim : Int) -> GraphtreecenterVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn GraphtreecenterVector::add(self : GraphtreecenterVector, other : GraphtreecenterVector) -> GraphtreecenterVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn GraphtreecenterVector::sub(self : GraphtreecenterVector, other : GraphtreecenterVector) -> GraphtreecenterVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn GraphtreecenterVector::scale(self : GraphtreecenterVector, s : Double) -> GraphtreecenterVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn GraphtreecenterVector::dot(self : GraphtreecenterVector, other : GraphtreecenterVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn GraphtreecenterVector::norm(self : GraphtreecenterVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn GraphtreecenterVector::normalize(self : GraphtreecenterVector) -> GraphtreecenterVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn GraphtreecenterVector::dist(self : GraphtreecenterVector, other : GraphtreecenterVector) -> Double {
  self.sub(other).norm()
}

pub fn GraphtreecenterVector::to_string(self : GraphtreecenterVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn graph_tree_center_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn graph_tree_center_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn graph_tree_center_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn graph_tree_center_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn graph_tree_center_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn graph_tree_center_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn graph_tree_center_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn graph_tree_center_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn graph_tree_center_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn graph_tree_center_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn graph_tree_center_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn graph_tree_center_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn graph_tree_center_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn graph_tree_center_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn graph_tree_center_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn graph_tree_center_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn graph_tree_center_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn graph_tree_center_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn graph_tree_center_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn graph_tree_center_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn graph_tree_center_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn graph_tree_center_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn graph_tree_center_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn graph_tree_center_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn graph_tree_center_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn graph_tree_center_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn graph_tree_center_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn graph_tree_center_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn graph_tree_center_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct GraphtreecenterFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_tree_center_frame_make(size : Int) -> GraphtreecenterFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_tree_center_frame_len(s : GraphtreecenterFrame) -> Int { s.size }

pub fn graph_tree_center_frame_get(s : GraphtreecenterFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_tree_center_frame_set(s : GraphtreecenterFrame, i : Int, v : Double) -> GraphtreecenterFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_tree_center_frame_sum(s : GraphtreecenterFrame) -> Double { @_common.sum(s.data) }

pub fn graph_tree_center_frame_mean(s : GraphtreecenterFrame) -> Double { @_common.mean(s.data) }

pub fn graph_tree_center_frame_scale(s : GraphtreecenterFrame, f : Double) -> GraphtreecenterFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_tree_center_frame_add(a : GraphtreecenterFrame, b : GraphtreecenterFrame) -> GraphtreecenterFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_tree_center_frame_copy(s : GraphtreecenterFrame) -> GraphtreecenterFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_tree_center_frame_fill(s : GraphtreecenterFrame, v : Double) -> GraphtreecenterFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_tree_center_frame_min(s : GraphtreecenterFrame) -> Double { @_common.min(s.data) }

pub fn graph_tree_center_frame_max(s : GraphtreecenterFrame) -> Double { @_common.max(s.data) }

pub fn graph_tree_center_frame_to_string(s : GraphtreecenterFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphtreecenterTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_tree_center_table_make(size : Int) -> GraphtreecenterTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_tree_center_table_len(s : GraphtreecenterTable) -> Int { s.size }

pub fn graph_tree_center_table_get(s : GraphtreecenterTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_tree_center_table_set(s : GraphtreecenterTable, i : Int, v : Double) -> GraphtreecenterTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_tree_center_table_sum(s : GraphtreecenterTable) -> Double { @_common.sum(s.data) }

pub fn graph_tree_center_table_mean(s : GraphtreecenterTable) -> Double { @_common.mean(s.data) }

pub fn graph_tree_center_table_scale(s : GraphtreecenterTable, f : Double) -> GraphtreecenterTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_tree_center_table_add(a : GraphtreecenterTable, b : GraphtreecenterTable) -> GraphtreecenterTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_tree_center_table_copy(s : GraphtreecenterTable) -> GraphtreecenterTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_tree_center_table_fill(s : GraphtreecenterTable, v : Double) -> GraphtreecenterTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_tree_center_table_min(s : GraphtreecenterTable) -> Double { @_common.min(s.data) }

pub fn graph_tree_center_table_max(s : GraphtreecenterTable) -> Double { @_common.max(s.data) }

pub fn graph_tree_center_table_to_string(s : GraphtreecenterTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphtreecenterGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_tree_center_graphn_make(size : Int) -> GraphtreecenterGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_tree_center_graphn_len(s : GraphtreecenterGraphN) -> Int { s.size }

pub fn graph_tree_center_graphn_get(s : GraphtreecenterGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_tree_center_graphn_set(s : GraphtreecenterGraphN, i : Int, v : Double) -> GraphtreecenterGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_tree_center_graphn_sum(s : GraphtreecenterGraphN) -> Double { @_common.sum(s.data) }

pub fn graph_tree_center_graphn_mean(s : GraphtreecenterGraphN) -> Double { @_common.mean(s.data) }

pub fn graph_tree_center_graphn_scale(s : GraphtreecenterGraphN, f : Double) -> GraphtreecenterGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_tree_center_graphn_add(a : GraphtreecenterGraphN, b : GraphtreecenterGraphN) -> GraphtreecenterGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_tree_center_graphn_copy(s : GraphtreecenterGraphN) -> GraphtreecenterGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_tree_center_graphn_fill(s : GraphtreecenterGraphN, v : Double) -> GraphtreecenterGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_tree_center_graphn_min(s : GraphtreecenterGraphN) -> Double { @_common.min(s.data) }

pub fn graph_tree_center_graphn_max(s : GraphtreecenterGraphN) -> Double { @_common.max(s.data) }

pub fn graph_tree_center_graphn_to_string(s : GraphtreecenterGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphtreecenterNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_tree_center_node_make(size : Int) -> GraphtreecenterNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_tree_center_node_len(s : GraphtreecenterNode) -> Int { s.size }

pub fn graph_tree_center_node_get(s : GraphtreecenterNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_tree_center_node_set(s : GraphtreecenterNode, i : Int, v : Double) -> GraphtreecenterNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_tree_center_node_sum(s : GraphtreecenterNode) -> Double { @_common.sum(s.data) }

pub fn graph_tree_center_node_mean(s : GraphtreecenterNode) -> Double { @_common.mean(s.data) }

pub fn graph_tree_center_node_scale(s : GraphtreecenterNode, f : Double) -> GraphtreecenterNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_tree_center_node_add(a : GraphtreecenterNode, b : GraphtreecenterNode) -> GraphtreecenterNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_tree_center_node_copy(s : GraphtreecenterNode) -> GraphtreecenterNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_tree_center_node_fill(s : GraphtreecenterNode, v : Double) -> GraphtreecenterNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_tree_center_node_min(s : GraphtreecenterNode) -> Double { @_common.min(s.data) }

pub fn graph_tree_center_node_max(s : GraphtreecenterNode) -> Double { @_common.max(s.data) }

pub fn graph_tree_center_node_to_string(s : GraphtreecenterNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphtreecenterEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_tree_center_edge_make(size : Int) -> GraphtreecenterEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_tree_center_edge_len(s : GraphtreecenterEdge) -> Int { s.size }

pub fn graph_tree_center_edge_get(s : GraphtreecenterEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_tree_center_edge_set(s : GraphtreecenterEdge, i : Int, v : Double) -> GraphtreecenterEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_tree_center_edge_sum(s : GraphtreecenterEdge) -> Double { @_common.sum(s.data) }

pub fn graph_tree_center_edge_mean(s : GraphtreecenterEdge) -> Double { @_common.mean(s.data) }

pub fn graph_tree_center_edge_scale(s : GraphtreecenterEdge, f : Double) -> GraphtreecenterEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_tree_center_edge_add(a : GraphtreecenterEdge, b : GraphtreecenterEdge) -> GraphtreecenterEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_tree_center_edge_copy(s : GraphtreecenterEdge) -> GraphtreecenterEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_tree_center_edge_fill(s : GraphtreecenterEdge, v : Double) -> GraphtreecenterEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_tree_center_edge_min(s : GraphtreecenterEdge) -> Double { @_common.min(s.data) }

pub fn graph_tree_center_edge_max(s : GraphtreecenterEdge) -> Double { @_common.max(s.data) }

pub fn graph_tree_center_edge_to_string(s : GraphtreecenterEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphtreecenterPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_tree_center_path_make(size : Int) -> GraphtreecenterPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_tree_center_path_len(s : GraphtreecenterPath) -> Int { s.size }

pub fn graph_tree_center_path_get(s : GraphtreecenterPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_tree_center_path_set(s : GraphtreecenterPath, i : Int, v : Double) -> GraphtreecenterPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_tree_center_path_sum(s : GraphtreecenterPath) -> Double { @_common.sum(s.data) }

pub fn graph_tree_center_path_mean(s : GraphtreecenterPath) -> Double { @_common.mean(s.data) }

pub fn graph_tree_center_path_scale(s : GraphtreecenterPath, f : Double) -> GraphtreecenterPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_tree_center_path_add(a : GraphtreecenterPath, b : GraphtreecenterPath) -> GraphtreecenterPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_tree_center_path_copy(s : GraphtreecenterPath) -> GraphtreecenterPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_tree_center_path_fill(s : GraphtreecenterPath, v : Double) -> GraphtreecenterPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_tree_center_path_min(s : GraphtreecenterPath) -> Double { @_common.min(s.data) }

pub fn graph_tree_center_path_max(s : GraphtreecenterPath) -> Double { @_common.max(s.data) }

pub fn graph_tree_center_path_to_string(s : GraphtreecenterPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphtreecenterCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_tree_center_cluster_make(size : Int) -> GraphtreecenterCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_tree_center_cluster_len(s : GraphtreecenterCluster) -> Int { s.size }

pub fn graph_tree_center_cluster_get(s : GraphtreecenterCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_tree_center_cluster_set(s : GraphtreecenterCluster, i : Int, v : Double) -> GraphtreecenterCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_tree_center_cluster_sum(s : GraphtreecenterCluster) -> Double { @_common.sum(s.data) }

pub fn graph_tree_center_cluster_mean(s : GraphtreecenterCluster) -> Double { @_common.mean(s.data) }

pub fn graph_tree_center_cluster_scale(s : GraphtreecenterCluster, f : Double) -> GraphtreecenterCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_tree_center_cluster_add(a : GraphtreecenterCluster, b : GraphtreecenterCluster) -> GraphtreecenterCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_tree_center_cluster_copy(s : GraphtreecenterCluster) -> GraphtreecenterCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_tree_center_cluster_fill(s : GraphtreecenterCluster, v : Double) -> GraphtreecenterCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_tree_center_cluster_min(s : GraphtreecenterCluster) -> Double { @_common.min(s.data) }

pub fn graph_tree_center_cluster_max(s : GraphtreecenterCluster) -> Double { @_common.max(s.data) }

pub fn graph_tree_center_cluster_to_string(s : GraphtreecenterCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphtreecenterModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_tree_center_model_make(size : Int) -> GraphtreecenterModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_tree_center_model_len(s : GraphtreecenterModel) -> Int { s.size }

pub fn graph_tree_center_model_get(s : GraphtreecenterModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_tree_center_model_set(s : GraphtreecenterModel, i : Int, v : Double) -> GraphtreecenterModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_tree_center_model_sum(s : GraphtreecenterModel) -> Double { @_common.sum(s.data) }

pub fn graph_tree_center_model_mean(s : GraphtreecenterModel) -> Double { @_common.mean(s.data) }

pub fn graph_tree_center_model_scale(s : GraphtreecenterModel, f : Double) -> GraphtreecenterModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_tree_center_model_add(a : GraphtreecenterModel, b : GraphtreecenterModel) -> GraphtreecenterModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_tree_center_model_copy(s : GraphtreecenterModel) -> GraphtreecenterModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_tree_center_model_fill(s : GraphtreecenterModel, v : Double) -> GraphtreecenterModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_tree_center_model_min(s : GraphtreecenterModel) -> Double { @_common.min(s.data) }

pub fn graph_tree_center_model_max(s : GraphtreecenterModel) -> Double { @_common.max(s.data) }

pub fn graph_tree_center_model_to_string(s : GraphtreecenterModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphtreecenterLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_tree_center_layer_make(size : Int) -> GraphtreecenterLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_tree_center_layer_len(s : GraphtreecenterLayer) -> Int { s.size }

pub fn graph_tree_center_layer_get(s : GraphtreecenterLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_tree_center_layer_set(s : GraphtreecenterLayer, i : Int, v : Double) -> GraphtreecenterLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_tree_center_layer_sum(s : GraphtreecenterLayer) -> Double { @_common.sum(s.data) }

pub fn graph_tree_center_layer_mean(s : GraphtreecenterLayer) -> Double { @_common.mean(s.data) }

pub fn graph_tree_center_layer_scale(s : GraphtreecenterLayer, f : Double) -> GraphtreecenterLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_tree_center_layer_add(a : GraphtreecenterLayer, b : GraphtreecenterLayer) -> GraphtreecenterLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_tree_center_layer_copy(s : GraphtreecenterLayer) -> GraphtreecenterLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_tree_center_layer_fill(s : GraphtreecenterLayer, v : Double) -> GraphtreecenterLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_tree_center_layer_min(s : GraphtreecenterLayer) -> Double { @_common.min(s.data) }

pub fn graph_tree_center_layer_max(s : GraphtreecenterLayer) -> Double { @_common.max(s.data) }

pub fn graph_tree_center_layer_to_string(s : GraphtreecenterLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphtreecenterBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_tree_center_buffer_make(size : Int) -> GraphtreecenterBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_tree_center_buffer_len(s : GraphtreecenterBuffer) -> Int { s.size }

pub fn graph_tree_center_buffer_get(s : GraphtreecenterBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_tree_center_buffer_set(s : GraphtreecenterBuffer, i : Int, v : Double) -> GraphtreecenterBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_tree_center_buffer_sum(s : GraphtreecenterBuffer) -> Double { @_common.sum(s.data) }

pub fn graph_tree_center_buffer_mean(s : GraphtreecenterBuffer) -> Double { @_common.mean(s.data) }

pub fn graph_tree_center_buffer_scale(s : GraphtreecenterBuffer, f : Double) -> GraphtreecenterBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_tree_center_buffer_add(a : GraphtreecenterBuffer, b : GraphtreecenterBuffer) -> GraphtreecenterBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_tree_center_buffer_copy(s : GraphtreecenterBuffer) -> GraphtreecenterBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_tree_center_buffer_fill(s : GraphtreecenterBuffer, v : Double) -> GraphtreecenterBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_tree_center_buffer_min(s : GraphtreecenterBuffer) -> Double { @_common.min(s.data) }

pub fn graph_tree_center_buffer_max(s : GraphtreecenterBuffer) -> Double { @_common.max(s.data) }

pub fn graph_tree_center_buffer_to_string(s : GraphtreecenterBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphtreecenterCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_tree_center_cursor_make(size : Int) -> GraphtreecenterCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_tree_center_cursor_len(s : GraphtreecenterCursor) -> Int { s.size }

pub fn graph_tree_center_cursor_get(s : GraphtreecenterCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_tree_center_cursor_set(s : GraphtreecenterCursor, i : Int, v : Double) -> GraphtreecenterCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_tree_center_cursor_sum(s : GraphtreecenterCursor) -> Double { @_common.sum(s.data) }

pub fn graph_tree_center_cursor_mean(s : GraphtreecenterCursor) -> Double { @_common.mean(s.data) }

pub fn graph_tree_center_cursor_scale(s : GraphtreecenterCursor, f : Double) -> GraphtreecenterCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_tree_center_cursor_add(a : GraphtreecenterCursor, b : GraphtreecenterCursor) -> GraphtreecenterCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_tree_center_cursor_copy(s : GraphtreecenterCursor) -> GraphtreecenterCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_tree_center_cursor_fill(s : GraphtreecenterCursor, v : Double) -> GraphtreecenterCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_tree_center_cursor_min(s : GraphtreecenterCursor) -> Double { @_common.min(s.data) }

pub fn graph_tree_center_cursor_max(s : GraphtreecenterCursor) -> Double { @_common.max(s.data) }

pub fn graph_tree_center_cursor_to_string(s : GraphtreecenterCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphtreecenterView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_tree_center_view_make(size : Int) -> GraphtreecenterView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_tree_center_view_len(s : GraphtreecenterView) -> Int { s.size }

pub fn graph_tree_center_view_get(s : GraphtreecenterView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_tree_center_view_set(s : GraphtreecenterView, i : Int, v : Double) -> GraphtreecenterView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_tree_center_view_sum(s : GraphtreecenterView) -> Double { @_common.sum(s.data) }

pub fn graph_tree_center_view_mean(s : GraphtreecenterView) -> Double { @_common.mean(s.data) }

pub fn graph_tree_center_view_scale(s : GraphtreecenterView, f : Double) -> GraphtreecenterView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_tree_center_view_add(a : GraphtreecenterView, b : GraphtreecenterView) -> GraphtreecenterView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_tree_center_view_copy(s : GraphtreecenterView) -> GraphtreecenterView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_tree_center_view_fill(s : GraphtreecenterView, v : Double) -> GraphtreecenterView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_tree_center_view_min(s : GraphtreecenterView) -> Double { @_common.min(s.data) }

pub fn graph_tree_center_view_max(s : GraphtreecenterView) -> Double { @_common.max(s.data) }

pub fn graph_tree_center_view_to_string(s : GraphtreecenterView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphtreecenterRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_tree_center_range_make(size : Int) -> GraphtreecenterRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_tree_center_range_len(s : GraphtreecenterRange) -> Int { s.size }

pub fn graph_tree_center_range_get(s : GraphtreecenterRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_tree_center_range_set(s : GraphtreecenterRange, i : Int, v : Double) -> GraphtreecenterRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_tree_center_range_sum(s : GraphtreecenterRange) -> Double { @_common.sum(s.data) }

pub fn graph_tree_center_range_mean(s : GraphtreecenterRange) -> Double { @_common.mean(s.data) }

pub fn graph_tree_center_range_scale(s : GraphtreecenterRange, f : Double) -> GraphtreecenterRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_tree_center_range_add(a : GraphtreecenterRange, b : GraphtreecenterRange) -> GraphtreecenterRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_tree_center_range_copy(s : GraphtreecenterRange) -> GraphtreecenterRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_tree_center_range_fill(s : GraphtreecenterRange, v : Double) -> GraphtreecenterRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_tree_center_range_min(s : GraphtreecenterRange) -> Double { @_common.min(s.data) }

pub fn graph_tree_center_range_max(s : GraphtreecenterRange) -> Double { @_common.max(s.data) }

pub fn graph_tree_center_range_to_string(s : GraphtreecenterRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphtreecenterSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_tree_center_slice_make(size : Int) -> GraphtreecenterSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_tree_center_slice_len(s : GraphtreecenterSlice) -> Int { s.size }

pub fn graph_tree_center_slice_get(s : GraphtreecenterSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_tree_center_slice_set(s : GraphtreecenterSlice, i : Int, v : Double) -> GraphtreecenterSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_tree_center_slice_sum(s : GraphtreecenterSlice) -> Double { @_common.sum(s.data) }

pub fn graph_tree_center_slice_mean(s : GraphtreecenterSlice) -> Double { @_common.mean(s.data) }

pub fn graph_tree_center_slice_scale(s : GraphtreecenterSlice, f : Double) -> GraphtreecenterSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_tree_center_slice_add(a : GraphtreecenterSlice, b : GraphtreecenterSlice) -> GraphtreecenterSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_tree_center_slice_copy(s : GraphtreecenterSlice) -> GraphtreecenterSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_tree_center_slice_fill(s : GraphtreecenterSlice, v : Double) -> GraphtreecenterSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_tree_center_slice_min(s : GraphtreecenterSlice) -> Double { @_common.min(s.data) }

pub fn graph_tree_center_slice_max(s : GraphtreecenterSlice) -> Double { @_common.max(s.data) }

pub fn graph_tree_center_slice_to_string(s : GraphtreecenterSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

