///===
/// extcore/graph_connect_euler

pub(all) struct GraphconnecteulerPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn graph_connect_euler_make_point(x : Double, y : Double) -> GraphconnecteulerPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn graph_connect_euler_make_point3(x : Double, y : Double, z : Double) -> GraphconnecteulerPoint {
  { x, y, z, label: 0 }
}

pub fn GraphconnecteulerPoint::x(self : GraphconnecteulerPoint) -> Double { self.x }

pub fn GraphconnecteulerPoint::y(self : GraphconnecteulerPoint) -> Double { self.y }

pub fn GraphconnecteulerPoint::z(self : GraphconnecteulerPoint) -> Double { self.z }

pub fn GraphconnecteulerPoint::label(self : GraphconnecteulerPoint) -> Int { self.label }

pub fn GraphconnecteulerPoint::dist(self : GraphconnecteulerPoint, other : GraphconnecteulerPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn GraphconnecteulerPoint::add(self : GraphconnecteulerPoint, other : GraphconnecteulerPoint) -> GraphconnecteulerPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn GraphconnecteulerPoint::sub(self : GraphconnecteulerPoint, other : GraphconnecteulerPoint) -> GraphconnecteulerPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn GraphconnecteulerPoint::scale(self : GraphconnecteulerPoint, s : Double) -> GraphconnecteulerPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn GraphconnecteulerPoint::dot(self : GraphconnecteulerPoint, other : GraphconnecteulerPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn GraphconnecteulerPoint::cross(self : GraphconnecteulerPoint, other : GraphconnecteulerPoint) -> GraphconnecteulerPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn GraphconnecteulerPoint::norm(self : GraphconnecteulerPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn GraphconnecteulerPoint::normalize(self : GraphconnecteulerPoint) -> GraphconnecteulerPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn GraphconnecteulerPoint::negate(self : GraphconnecteulerPoint) -> GraphconnecteulerPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn GraphconnecteulerPoint::mid(self : GraphconnecteulerPoint, other : GraphconnecteulerPoint) -> GraphconnecteulerPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn GraphconnecteulerPoint::lerp(self : GraphconnecteulerPoint, other : GraphconnecteulerPoint, t : Double) -> GraphconnecteulerPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn GraphconnecteulerPoint::to_string(self : GraphconnecteulerPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct GraphconnecteulerSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn graph_connect_euler_make_series(vals : Array[Double], name : String) -> GraphconnecteulerSeries {
  { vals, name, meta: 0 }
}

pub fn GraphconnecteulerSeries::len(self : GraphconnecteulerSeries) -> Int { self.vals.length() }

pub fn GraphconnecteulerSeries::sum(self : GraphconnecteulerSeries) -> Double { @_common.sum(self.vals) }

pub fn GraphconnecteulerSeries::mean(self : GraphconnecteulerSeries) -> Double { @_common.mean(self.vals) }

pub fn GraphconnecteulerSeries::min(self : GraphconnecteulerSeries) -> Double { @_common.min(self.vals) }

pub fn GraphconnecteulerSeries::max(self : GraphconnecteulerSeries) -> Double { @_common.max(self.vals) }

pub fn GraphconnecteulerSeries::range(self : GraphconnecteulerSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn GraphconnecteulerSeries::variance(self : GraphconnecteulerSeries) -> Double { @_common.variance(self.vals) }

pub fn GraphconnecteulerSeries::std(self : GraphconnecteulerSeries) -> Double { @_common.std(self.vals) }

pub fn GraphconnecteulerSeries::median(self : GraphconnecteulerSeries) -> Double { @_common.median(self.vals) }

pub fn GraphconnecteulerSeries::scale(self : GraphconnecteulerSeries, f : Double) -> GraphconnecteulerSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn GraphconnecteulerSeries::add(self : GraphconnecteulerSeries, other : GraphconnecteulerSeries) -> GraphconnecteulerSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn GraphconnecteulerSeries::sub(self : GraphconnecteulerSeries, other : GraphconnecteulerSeries) -> GraphconnecteulerSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn GraphconnecteulerSeries::normalize(self : GraphconnecteulerSeries) -> GraphconnecteulerSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn GraphconnecteulerSeries::cumsum(self : GraphconnecteulerSeries) -> GraphconnecteulerSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn GraphconnecteulerSeries::to_string(self : GraphconnecteulerSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct GraphconnecteulerMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn graph_connect_euler_make_matrix(rows : Int, cols : Int, val : Double) -> GraphconnecteulerMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn graph_connect_euler_matrix_identity(n : Int) -> GraphconnecteulerMatrix {
  let m = graph_connect_euler_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn GraphconnecteulerMatrix::get(self : GraphconnecteulerMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn GraphconnecteulerMatrix::transpose(self : GraphconnecteulerMatrix) -> GraphconnecteulerMatrix {
  let result = graph_connect_euler_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn GraphconnecteulerMatrix::add(self : GraphconnecteulerMatrix, other : GraphconnecteulerMatrix) -> GraphconnecteulerMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = graph_connect_euler_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn GraphconnecteulerMatrix::scale(self : GraphconnecteulerMatrix, s : Double) -> GraphconnecteulerMatrix {
  let result = graph_connect_euler_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn GraphconnecteulerMatrix::multiply(self : GraphconnecteulerMatrix, other : GraphconnecteulerMatrix) -> GraphconnecteulerMatrix {
  if self.cols != other.rows { return graph_connect_euler_make_matrix(self.rows, other.cols, 0.0) }
  let result = graph_connect_euler_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn GraphconnecteulerMatrix::trace(self : GraphconnecteulerMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn GraphconnecteulerMatrix::det(self : GraphconnecteulerMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn GraphconnecteulerMatrix::norm(self : GraphconnecteulerMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn GraphconnecteulerMatrix::to_string(self : GraphconnecteulerMatrix) -> String {
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

pub(all) struct GraphconnecteulerVector {
  comps : Array[Double]
  dim : Int
}

pub fn graph_connect_euler_make_vector(comps : Array[Double]) -> GraphconnecteulerVector {
  { comps, dim: comps.length() }
}

pub fn graph_connect_euler_vector_zero(dim : Int) -> GraphconnecteulerVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn GraphconnecteulerVector::add(self : GraphconnecteulerVector, other : GraphconnecteulerVector) -> GraphconnecteulerVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn GraphconnecteulerVector::sub(self : GraphconnecteulerVector, other : GraphconnecteulerVector) -> GraphconnecteulerVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn GraphconnecteulerVector::scale(self : GraphconnecteulerVector, s : Double) -> GraphconnecteulerVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn GraphconnecteulerVector::dot(self : GraphconnecteulerVector, other : GraphconnecteulerVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn GraphconnecteulerVector::norm(self : GraphconnecteulerVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn GraphconnecteulerVector::normalize(self : GraphconnecteulerVector) -> GraphconnecteulerVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn GraphconnecteulerVector::dist(self : GraphconnecteulerVector, other : GraphconnecteulerVector) -> Double {
  self.sub(other).norm()
}

pub fn GraphconnecteulerVector::to_string(self : GraphconnecteulerVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn graph_connect_euler_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn graph_connect_euler_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn graph_connect_euler_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn graph_connect_euler_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn graph_connect_euler_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn graph_connect_euler_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn graph_connect_euler_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn graph_connect_euler_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn graph_connect_euler_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn graph_connect_euler_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn graph_connect_euler_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn graph_connect_euler_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn graph_connect_euler_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn graph_connect_euler_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn graph_connect_euler_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn graph_connect_euler_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn graph_connect_euler_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn graph_connect_euler_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn graph_connect_euler_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn graph_connect_euler_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn graph_connect_euler_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn graph_connect_euler_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn graph_connect_euler_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn graph_connect_euler_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn graph_connect_euler_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn graph_connect_euler_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn graph_connect_euler_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn graph_connect_euler_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn graph_connect_euler_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct GraphconnecteulerFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_connect_euler_frame_make(size : Int) -> GraphconnecteulerFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_connect_euler_frame_len(s : GraphconnecteulerFrame) -> Int { s.size }

pub fn graph_connect_euler_frame_get(s : GraphconnecteulerFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_connect_euler_frame_set(s : GraphconnecteulerFrame, i : Int, v : Double) -> GraphconnecteulerFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_connect_euler_frame_sum(s : GraphconnecteulerFrame) -> Double { @_common.sum(s.data) }

pub fn graph_connect_euler_frame_mean(s : GraphconnecteulerFrame) -> Double { @_common.mean(s.data) }

pub fn graph_connect_euler_frame_scale(s : GraphconnecteulerFrame, f : Double) -> GraphconnecteulerFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_connect_euler_frame_add(a : GraphconnecteulerFrame, b : GraphconnecteulerFrame) -> GraphconnecteulerFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_connect_euler_frame_copy(s : GraphconnecteulerFrame) -> GraphconnecteulerFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_connect_euler_frame_fill(s : GraphconnecteulerFrame, v : Double) -> GraphconnecteulerFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_connect_euler_frame_min(s : GraphconnecteulerFrame) -> Double { @_common.min(s.data) }

pub fn graph_connect_euler_frame_max(s : GraphconnecteulerFrame) -> Double { @_common.max(s.data) }

pub fn graph_connect_euler_frame_to_string(s : GraphconnecteulerFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphconnecteulerTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_connect_euler_table_make(size : Int) -> GraphconnecteulerTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_connect_euler_table_len(s : GraphconnecteulerTable) -> Int { s.size }

pub fn graph_connect_euler_table_get(s : GraphconnecteulerTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_connect_euler_table_set(s : GraphconnecteulerTable, i : Int, v : Double) -> GraphconnecteulerTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_connect_euler_table_sum(s : GraphconnecteulerTable) -> Double { @_common.sum(s.data) }

pub fn graph_connect_euler_table_mean(s : GraphconnecteulerTable) -> Double { @_common.mean(s.data) }

pub fn graph_connect_euler_table_scale(s : GraphconnecteulerTable, f : Double) -> GraphconnecteulerTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_connect_euler_table_add(a : GraphconnecteulerTable, b : GraphconnecteulerTable) -> GraphconnecteulerTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_connect_euler_table_copy(s : GraphconnecteulerTable) -> GraphconnecteulerTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_connect_euler_table_fill(s : GraphconnecteulerTable, v : Double) -> GraphconnecteulerTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_connect_euler_table_min(s : GraphconnecteulerTable) -> Double { @_common.min(s.data) }

pub fn graph_connect_euler_table_max(s : GraphconnecteulerTable) -> Double { @_common.max(s.data) }

pub fn graph_connect_euler_table_to_string(s : GraphconnecteulerTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphconnecteulerGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_connect_euler_graphn_make(size : Int) -> GraphconnecteulerGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_connect_euler_graphn_len(s : GraphconnecteulerGraphN) -> Int { s.size }

pub fn graph_connect_euler_graphn_get(s : GraphconnecteulerGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_connect_euler_graphn_set(s : GraphconnecteulerGraphN, i : Int, v : Double) -> GraphconnecteulerGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_connect_euler_graphn_sum(s : GraphconnecteulerGraphN) -> Double { @_common.sum(s.data) }

pub fn graph_connect_euler_graphn_mean(s : GraphconnecteulerGraphN) -> Double { @_common.mean(s.data) }

pub fn graph_connect_euler_graphn_scale(s : GraphconnecteulerGraphN, f : Double) -> GraphconnecteulerGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_connect_euler_graphn_add(a : GraphconnecteulerGraphN, b : GraphconnecteulerGraphN) -> GraphconnecteulerGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_connect_euler_graphn_copy(s : GraphconnecteulerGraphN) -> GraphconnecteulerGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_connect_euler_graphn_fill(s : GraphconnecteulerGraphN, v : Double) -> GraphconnecteulerGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_connect_euler_graphn_min(s : GraphconnecteulerGraphN) -> Double { @_common.min(s.data) }

pub fn graph_connect_euler_graphn_max(s : GraphconnecteulerGraphN) -> Double { @_common.max(s.data) }

pub fn graph_connect_euler_graphn_to_string(s : GraphconnecteulerGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphconnecteulerNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_connect_euler_node_make(size : Int) -> GraphconnecteulerNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_connect_euler_node_len(s : GraphconnecteulerNode) -> Int { s.size }

pub fn graph_connect_euler_node_get(s : GraphconnecteulerNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_connect_euler_node_set(s : GraphconnecteulerNode, i : Int, v : Double) -> GraphconnecteulerNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_connect_euler_node_sum(s : GraphconnecteulerNode) -> Double { @_common.sum(s.data) }

pub fn graph_connect_euler_node_mean(s : GraphconnecteulerNode) -> Double { @_common.mean(s.data) }

pub fn graph_connect_euler_node_scale(s : GraphconnecteulerNode, f : Double) -> GraphconnecteulerNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_connect_euler_node_add(a : GraphconnecteulerNode, b : GraphconnecteulerNode) -> GraphconnecteulerNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_connect_euler_node_copy(s : GraphconnecteulerNode) -> GraphconnecteulerNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_connect_euler_node_fill(s : GraphconnecteulerNode, v : Double) -> GraphconnecteulerNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_connect_euler_node_min(s : GraphconnecteulerNode) -> Double { @_common.min(s.data) }

pub fn graph_connect_euler_node_max(s : GraphconnecteulerNode) -> Double { @_common.max(s.data) }

pub fn graph_connect_euler_node_to_string(s : GraphconnecteulerNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphconnecteulerEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_connect_euler_edge_make(size : Int) -> GraphconnecteulerEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_connect_euler_edge_len(s : GraphconnecteulerEdge) -> Int { s.size }

pub fn graph_connect_euler_edge_get(s : GraphconnecteulerEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_connect_euler_edge_set(s : GraphconnecteulerEdge, i : Int, v : Double) -> GraphconnecteulerEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_connect_euler_edge_sum(s : GraphconnecteulerEdge) -> Double { @_common.sum(s.data) }

pub fn graph_connect_euler_edge_mean(s : GraphconnecteulerEdge) -> Double { @_common.mean(s.data) }

pub fn graph_connect_euler_edge_scale(s : GraphconnecteulerEdge, f : Double) -> GraphconnecteulerEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_connect_euler_edge_add(a : GraphconnecteulerEdge, b : GraphconnecteulerEdge) -> GraphconnecteulerEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_connect_euler_edge_copy(s : GraphconnecteulerEdge) -> GraphconnecteulerEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_connect_euler_edge_fill(s : GraphconnecteulerEdge, v : Double) -> GraphconnecteulerEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_connect_euler_edge_min(s : GraphconnecteulerEdge) -> Double { @_common.min(s.data) }

pub fn graph_connect_euler_edge_max(s : GraphconnecteulerEdge) -> Double { @_common.max(s.data) }

pub fn graph_connect_euler_edge_to_string(s : GraphconnecteulerEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphconnecteulerPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_connect_euler_path_make(size : Int) -> GraphconnecteulerPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_connect_euler_path_len(s : GraphconnecteulerPath) -> Int { s.size }

pub fn graph_connect_euler_path_get(s : GraphconnecteulerPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_connect_euler_path_set(s : GraphconnecteulerPath, i : Int, v : Double) -> GraphconnecteulerPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_connect_euler_path_sum(s : GraphconnecteulerPath) -> Double { @_common.sum(s.data) }

pub fn graph_connect_euler_path_mean(s : GraphconnecteulerPath) -> Double { @_common.mean(s.data) }

pub fn graph_connect_euler_path_scale(s : GraphconnecteulerPath, f : Double) -> GraphconnecteulerPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_connect_euler_path_add(a : GraphconnecteulerPath, b : GraphconnecteulerPath) -> GraphconnecteulerPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_connect_euler_path_copy(s : GraphconnecteulerPath) -> GraphconnecteulerPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_connect_euler_path_fill(s : GraphconnecteulerPath, v : Double) -> GraphconnecteulerPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_connect_euler_path_min(s : GraphconnecteulerPath) -> Double { @_common.min(s.data) }

pub fn graph_connect_euler_path_max(s : GraphconnecteulerPath) -> Double { @_common.max(s.data) }

pub fn graph_connect_euler_path_to_string(s : GraphconnecteulerPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphconnecteulerCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_connect_euler_cluster_make(size : Int) -> GraphconnecteulerCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_connect_euler_cluster_len(s : GraphconnecteulerCluster) -> Int { s.size }

pub fn graph_connect_euler_cluster_get(s : GraphconnecteulerCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_connect_euler_cluster_set(s : GraphconnecteulerCluster, i : Int, v : Double) -> GraphconnecteulerCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_connect_euler_cluster_sum(s : GraphconnecteulerCluster) -> Double { @_common.sum(s.data) }

pub fn graph_connect_euler_cluster_mean(s : GraphconnecteulerCluster) -> Double { @_common.mean(s.data) }

pub fn graph_connect_euler_cluster_scale(s : GraphconnecteulerCluster, f : Double) -> GraphconnecteulerCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_connect_euler_cluster_add(a : GraphconnecteulerCluster, b : GraphconnecteulerCluster) -> GraphconnecteulerCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_connect_euler_cluster_copy(s : GraphconnecteulerCluster) -> GraphconnecteulerCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_connect_euler_cluster_fill(s : GraphconnecteulerCluster, v : Double) -> GraphconnecteulerCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_connect_euler_cluster_min(s : GraphconnecteulerCluster) -> Double { @_common.min(s.data) }

pub fn graph_connect_euler_cluster_max(s : GraphconnecteulerCluster) -> Double { @_common.max(s.data) }

pub fn graph_connect_euler_cluster_to_string(s : GraphconnecteulerCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphconnecteulerModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_connect_euler_model_make(size : Int) -> GraphconnecteulerModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_connect_euler_model_len(s : GraphconnecteulerModel) -> Int { s.size }

pub fn graph_connect_euler_model_get(s : GraphconnecteulerModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_connect_euler_model_set(s : GraphconnecteulerModel, i : Int, v : Double) -> GraphconnecteulerModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_connect_euler_model_sum(s : GraphconnecteulerModel) -> Double { @_common.sum(s.data) }

pub fn graph_connect_euler_model_mean(s : GraphconnecteulerModel) -> Double { @_common.mean(s.data) }

pub fn graph_connect_euler_model_scale(s : GraphconnecteulerModel, f : Double) -> GraphconnecteulerModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_connect_euler_model_add(a : GraphconnecteulerModel, b : GraphconnecteulerModel) -> GraphconnecteulerModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_connect_euler_model_copy(s : GraphconnecteulerModel) -> GraphconnecteulerModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_connect_euler_model_fill(s : GraphconnecteulerModel, v : Double) -> GraphconnecteulerModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_connect_euler_model_min(s : GraphconnecteulerModel) -> Double { @_common.min(s.data) }

pub fn graph_connect_euler_model_max(s : GraphconnecteulerModel) -> Double { @_common.max(s.data) }

pub fn graph_connect_euler_model_to_string(s : GraphconnecteulerModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphconnecteulerLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_connect_euler_layer_make(size : Int) -> GraphconnecteulerLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_connect_euler_layer_len(s : GraphconnecteulerLayer) -> Int { s.size }

pub fn graph_connect_euler_layer_get(s : GraphconnecteulerLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_connect_euler_layer_set(s : GraphconnecteulerLayer, i : Int, v : Double) -> GraphconnecteulerLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_connect_euler_layer_sum(s : GraphconnecteulerLayer) -> Double { @_common.sum(s.data) }

pub fn graph_connect_euler_layer_mean(s : GraphconnecteulerLayer) -> Double { @_common.mean(s.data) }

pub fn graph_connect_euler_layer_scale(s : GraphconnecteulerLayer, f : Double) -> GraphconnecteulerLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_connect_euler_layer_add(a : GraphconnecteulerLayer, b : GraphconnecteulerLayer) -> GraphconnecteulerLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_connect_euler_layer_copy(s : GraphconnecteulerLayer) -> GraphconnecteulerLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_connect_euler_layer_fill(s : GraphconnecteulerLayer, v : Double) -> GraphconnecteulerLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_connect_euler_layer_min(s : GraphconnecteulerLayer) -> Double { @_common.min(s.data) }

pub fn graph_connect_euler_layer_max(s : GraphconnecteulerLayer) -> Double { @_common.max(s.data) }

pub fn graph_connect_euler_layer_to_string(s : GraphconnecteulerLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphconnecteulerBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_connect_euler_buffer_make(size : Int) -> GraphconnecteulerBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_connect_euler_buffer_len(s : GraphconnecteulerBuffer) -> Int { s.size }

pub fn graph_connect_euler_buffer_get(s : GraphconnecteulerBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_connect_euler_buffer_set(s : GraphconnecteulerBuffer, i : Int, v : Double) -> GraphconnecteulerBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_connect_euler_buffer_sum(s : GraphconnecteulerBuffer) -> Double { @_common.sum(s.data) }

pub fn graph_connect_euler_buffer_mean(s : GraphconnecteulerBuffer) -> Double { @_common.mean(s.data) }

pub fn graph_connect_euler_buffer_scale(s : GraphconnecteulerBuffer, f : Double) -> GraphconnecteulerBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_connect_euler_buffer_add(a : GraphconnecteulerBuffer, b : GraphconnecteulerBuffer) -> GraphconnecteulerBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_connect_euler_buffer_copy(s : GraphconnecteulerBuffer) -> GraphconnecteulerBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_connect_euler_buffer_fill(s : GraphconnecteulerBuffer, v : Double) -> GraphconnecteulerBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_connect_euler_buffer_min(s : GraphconnecteulerBuffer) -> Double { @_common.min(s.data) }

pub fn graph_connect_euler_buffer_max(s : GraphconnecteulerBuffer) -> Double { @_common.max(s.data) }

pub fn graph_connect_euler_buffer_to_string(s : GraphconnecteulerBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphconnecteulerCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_connect_euler_cursor_make(size : Int) -> GraphconnecteulerCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_connect_euler_cursor_len(s : GraphconnecteulerCursor) -> Int { s.size }

pub fn graph_connect_euler_cursor_get(s : GraphconnecteulerCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_connect_euler_cursor_set(s : GraphconnecteulerCursor, i : Int, v : Double) -> GraphconnecteulerCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_connect_euler_cursor_sum(s : GraphconnecteulerCursor) -> Double { @_common.sum(s.data) }

pub fn graph_connect_euler_cursor_mean(s : GraphconnecteulerCursor) -> Double { @_common.mean(s.data) }

pub fn graph_connect_euler_cursor_scale(s : GraphconnecteulerCursor, f : Double) -> GraphconnecteulerCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_connect_euler_cursor_add(a : GraphconnecteulerCursor, b : GraphconnecteulerCursor) -> GraphconnecteulerCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_connect_euler_cursor_copy(s : GraphconnecteulerCursor) -> GraphconnecteulerCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_connect_euler_cursor_fill(s : GraphconnecteulerCursor, v : Double) -> GraphconnecteulerCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_connect_euler_cursor_min(s : GraphconnecteulerCursor) -> Double { @_common.min(s.data) }

pub fn graph_connect_euler_cursor_max(s : GraphconnecteulerCursor) -> Double { @_common.max(s.data) }

pub fn graph_connect_euler_cursor_to_string(s : GraphconnecteulerCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphconnecteulerView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_connect_euler_view_make(size : Int) -> GraphconnecteulerView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_connect_euler_view_len(s : GraphconnecteulerView) -> Int { s.size }

pub fn graph_connect_euler_view_get(s : GraphconnecteulerView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_connect_euler_view_set(s : GraphconnecteulerView, i : Int, v : Double) -> GraphconnecteulerView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_connect_euler_view_sum(s : GraphconnecteulerView) -> Double { @_common.sum(s.data) }

pub fn graph_connect_euler_view_mean(s : GraphconnecteulerView) -> Double { @_common.mean(s.data) }

pub fn graph_connect_euler_view_scale(s : GraphconnecteulerView, f : Double) -> GraphconnecteulerView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_connect_euler_view_add(a : GraphconnecteulerView, b : GraphconnecteulerView) -> GraphconnecteulerView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_connect_euler_view_copy(s : GraphconnecteulerView) -> GraphconnecteulerView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_connect_euler_view_fill(s : GraphconnecteulerView, v : Double) -> GraphconnecteulerView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_connect_euler_view_min(s : GraphconnecteulerView) -> Double { @_common.min(s.data) }

pub fn graph_connect_euler_view_max(s : GraphconnecteulerView) -> Double { @_common.max(s.data) }

pub fn graph_connect_euler_view_to_string(s : GraphconnecteulerView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphconnecteulerRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_connect_euler_range_make(size : Int) -> GraphconnecteulerRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_connect_euler_range_len(s : GraphconnecteulerRange) -> Int { s.size }

pub fn graph_connect_euler_range_get(s : GraphconnecteulerRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_connect_euler_range_set(s : GraphconnecteulerRange, i : Int, v : Double) -> GraphconnecteulerRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_connect_euler_range_sum(s : GraphconnecteulerRange) -> Double { @_common.sum(s.data) }

pub fn graph_connect_euler_range_mean(s : GraphconnecteulerRange) -> Double { @_common.mean(s.data) }

pub fn graph_connect_euler_range_scale(s : GraphconnecteulerRange, f : Double) -> GraphconnecteulerRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_connect_euler_range_add(a : GraphconnecteulerRange, b : GraphconnecteulerRange) -> GraphconnecteulerRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_connect_euler_range_copy(s : GraphconnecteulerRange) -> GraphconnecteulerRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_connect_euler_range_fill(s : GraphconnecteulerRange, v : Double) -> GraphconnecteulerRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_connect_euler_range_min(s : GraphconnecteulerRange) -> Double { @_common.min(s.data) }

pub fn graph_connect_euler_range_max(s : GraphconnecteulerRange) -> Double { @_common.max(s.data) }

pub fn graph_connect_euler_range_to_string(s : GraphconnecteulerRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphconnecteulerSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_connect_euler_slice_make(size : Int) -> GraphconnecteulerSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_connect_euler_slice_len(s : GraphconnecteulerSlice) -> Int { s.size }

pub fn graph_connect_euler_slice_get(s : GraphconnecteulerSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_connect_euler_slice_set(s : GraphconnecteulerSlice, i : Int, v : Double) -> GraphconnecteulerSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_connect_euler_slice_sum(s : GraphconnecteulerSlice) -> Double { @_common.sum(s.data) }

pub fn graph_connect_euler_slice_mean(s : GraphconnecteulerSlice) -> Double { @_common.mean(s.data) }

pub fn graph_connect_euler_slice_scale(s : GraphconnecteulerSlice, f : Double) -> GraphconnecteulerSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_connect_euler_slice_add(a : GraphconnecteulerSlice, b : GraphconnecteulerSlice) -> GraphconnecteulerSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_connect_euler_slice_copy(s : GraphconnecteulerSlice) -> GraphconnecteulerSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_connect_euler_slice_fill(s : GraphconnecteulerSlice, v : Double) -> GraphconnecteulerSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_connect_euler_slice_min(s : GraphconnecteulerSlice) -> Double { @_common.min(s.data) }

pub fn graph_connect_euler_slice_max(s : GraphconnecteulerSlice) -> Double { @_common.max(s.data) }

pub fn graph_connect_euler_slice_to_string(s : GraphconnecteulerSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

