///===
/// extcore/graph_connect_strong

pub(all) struct GraphconnectstrongPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn graph_connect_strong_make_point(x : Double, y : Double) -> GraphconnectstrongPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn graph_connect_strong_make_point3(x : Double, y : Double, z : Double) -> GraphconnectstrongPoint {
  { x, y, z, label: 0 }
}

pub fn GraphconnectstrongPoint::x(self : GraphconnectstrongPoint) -> Double { self.x }

pub fn GraphconnectstrongPoint::y(self : GraphconnectstrongPoint) -> Double { self.y }

pub fn GraphconnectstrongPoint::z(self : GraphconnectstrongPoint) -> Double { self.z }

pub fn GraphconnectstrongPoint::label(self : GraphconnectstrongPoint) -> Int { self.label }

pub fn GraphconnectstrongPoint::dist(self : GraphconnectstrongPoint, other : GraphconnectstrongPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn GraphconnectstrongPoint::add(self : GraphconnectstrongPoint, other : GraphconnectstrongPoint) -> GraphconnectstrongPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn GraphconnectstrongPoint::sub(self : GraphconnectstrongPoint, other : GraphconnectstrongPoint) -> GraphconnectstrongPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn GraphconnectstrongPoint::scale(self : GraphconnectstrongPoint, s : Double) -> GraphconnectstrongPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn GraphconnectstrongPoint::dot(self : GraphconnectstrongPoint, other : GraphconnectstrongPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn GraphconnectstrongPoint::cross(self : GraphconnectstrongPoint, other : GraphconnectstrongPoint) -> GraphconnectstrongPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn GraphconnectstrongPoint::norm(self : GraphconnectstrongPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn GraphconnectstrongPoint::normalize(self : GraphconnectstrongPoint) -> GraphconnectstrongPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn GraphconnectstrongPoint::negate(self : GraphconnectstrongPoint) -> GraphconnectstrongPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn GraphconnectstrongPoint::mid(self : GraphconnectstrongPoint, other : GraphconnectstrongPoint) -> GraphconnectstrongPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn GraphconnectstrongPoint::lerp(self : GraphconnectstrongPoint, other : GraphconnectstrongPoint, t : Double) -> GraphconnectstrongPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn GraphconnectstrongPoint::to_string(self : GraphconnectstrongPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct GraphconnectstrongSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn graph_connect_strong_make_series(vals : Array[Double], name : String) -> GraphconnectstrongSeries {
  { vals, name, meta: 0 }
}

pub fn GraphconnectstrongSeries::len(self : GraphconnectstrongSeries) -> Int { self.vals.length() }

pub fn GraphconnectstrongSeries::sum(self : GraphconnectstrongSeries) -> Double { @_common.sum(self.vals) }

pub fn GraphconnectstrongSeries::mean(self : GraphconnectstrongSeries) -> Double { @_common.mean(self.vals) }

pub fn GraphconnectstrongSeries::min(self : GraphconnectstrongSeries) -> Double { @_common.min(self.vals) }

pub fn GraphconnectstrongSeries::max(self : GraphconnectstrongSeries) -> Double { @_common.max(self.vals) }

pub fn GraphconnectstrongSeries::range(self : GraphconnectstrongSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn GraphconnectstrongSeries::variance(self : GraphconnectstrongSeries) -> Double { @_common.variance(self.vals) }

pub fn GraphconnectstrongSeries::std(self : GraphconnectstrongSeries) -> Double { @_common.std(self.vals) }

pub fn GraphconnectstrongSeries::median(self : GraphconnectstrongSeries) -> Double { @_common.median(self.vals) }

pub fn GraphconnectstrongSeries::scale(self : GraphconnectstrongSeries, f : Double) -> GraphconnectstrongSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn GraphconnectstrongSeries::add(self : GraphconnectstrongSeries, other : GraphconnectstrongSeries) -> GraphconnectstrongSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn GraphconnectstrongSeries::sub(self : GraphconnectstrongSeries, other : GraphconnectstrongSeries) -> GraphconnectstrongSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn GraphconnectstrongSeries::normalize(self : GraphconnectstrongSeries) -> GraphconnectstrongSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn GraphconnectstrongSeries::cumsum(self : GraphconnectstrongSeries) -> GraphconnectstrongSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn GraphconnectstrongSeries::to_string(self : GraphconnectstrongSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct GraphconnectstrongMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn graph_connect_strong_make_matrix(rows : Int, cols : Int, val : Double) -> GraphconnectstrongMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn graph_connect_strong_matrix_identity(n : Int) -> GraphconnectstrongMatrix {
  let m = graph_connect_strong_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn GraphconnectstrongMatrix::get(self : GraphconnectstrongMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn GraphconnectstrongMatrix::transpose(self : GraphconnectstrongMatrix) -> GraphconnectstrongMatrix {
  let result = graph_connect_strong_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn GraphconnectstrongMatrix::add(self : GraphconnectstrongMatrix, other : GraphconnectstrongMatrix) -> GraphconnectstrongMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = graph_connect_strong_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn GraphconnectstrongMatrix::scale(self : GraphconnectstrongMatrix, s : Double) -> GraphconnectstrongMatrix {
  let result = graph_connect_strong_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn GraphconnectstrongMatrix::multiply(self : GraphconnectstrongMatrix, other : GraphconnectstrongMatrix) -> GraphconnectstrongMatrix {
  if self.cols != other.rows { return graph_connect_strong_make_matrix(self.rows, other.cols, 0.0) }
  let result = graph_connect_strong_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn GraphconnectstrongMatrix::trace(self : GraphconnectstrongMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn GraphconnectstrongMatrix::det(self : GraphconnectstrongMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn GraphconnectstrongMatrix::norm(self : GraphconnectstrongMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn GraphconnectstrongMatrix::to_string(self : GraphconnectstrongMatrix) -> String {
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

pub(all) struct GraphconnectstrongVector {
  comps : Array[Double]
  dim : Int
}

pub fn graph_connect_strong_make_vector(comps : Array[Double]) -> GraphconnectstrongVector {
  { comps, dim: comps.length() }
}

pub fn graph_connect_strong_vector_zero(dim : Int) -> GraphconnectstrongVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn GraphconnectstrongVector::add(self : GraphconnectstrongVector, other : GraphconnectstrongVector) -> GraphconnectstrongVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn GraphconnectstrongVector::sub(self : GraphconnectstrongVector, other : GraphconnectstrongVector) -> GraphconnectstrongVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn GraphconnectstrongVector::scale(self : GraphconnectstrongVector, s : Double) -> GraphconnectstrongVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn GraphconnectstrongVector::dot(self : GraphconnectstrongVector, other : GraphconnectstrongVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn GraphconnectstrongVector::norm(self : GraphconnectstrongVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn GraphconnectstrongVector::normalize(self : GraphconnectstrongVector) -> GraphconnectstrongVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn GraphconnectstrongVector::dist(self : GraphconnectstrongVector, other : GraphconnectstrongVector) -> Double {
  self.sub(other).norm()
}

pub fn GraphconnectstrongVector::to_string(self : GraphconnectstrongVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn graph_connect_strong_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn graph_connect_strong_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn graph_connect_strong_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn graph_connect_strong_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn graph_connect_strong_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn graph_connect_strong_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn graph_connect_strong_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn graph_connect_strong_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn graph_connect_strong_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn graph_connect_strong_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn graph_connect_strong_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn graph_connect_strong_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn graph_connect_strong_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn graph_connect_strong_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn graph_connect_strong_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn graph_connect_strong_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn graph_connect_strong_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn graph_connect_strong_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn graph_connect_strong_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn graph_connect_strong_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn graph_connect_strong_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn graph_connect_strong_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn graph_connect_strong_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn graph_connect_strong_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn graph_connect_strong_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn graph_connect_strong_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn graph_connect_strong_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn graph_connect_strong_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn graph_connect_strong_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct GraphconnectstrongFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_connect_strong_frame_make(size : Int) -> GraphconnectstrongFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_connect_strong_frame_len(s : GraphconnectstrongFrame) -> Int { s.size }

pub fn graph_connect_strong_frame_get(s : GraphconnectstrongFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_connect_strong_frame_set(s : GraphconnectstrongFrame, i : Int, v : Double) -> GraphconnectstrongFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_connect_strong_frame_sum(s : GraphconnectstrongFrame) -> Double { @_common.sum(s.data) }

pub fn graph_connect_strong_frame_mean(s : GraphconnectstrongFrame) -> Double { @_common.mean(s.data) }

pub fn graph_connect_strong_frame_scale(s : GraphconnectstrongFrame, f : Double) -> GraphconnectstrongFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_connect_strong_frame_add(a : GraphconnectstrongFrame, b : GraphconnectstrongFrame) -> GraphconnectstrongFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_connect_strong_frame_copy(s : GraphconnectstrongFrame) -> GraphconnectstrongFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_connect_strong_frame_fill(s : GraphconnectstrongFrame, v : Double) -> GraphconnectstrongFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_connect_strong_frame_min(s : GraphconnectstrongFrame) -> Double { @_common.min(s.data) }

pub fn graph_connect_strong_frame_max(s : GraphconnectstrongFrame) -> Double { @_common.max(s.data) }

pub fn graph_connect_strong_frame_to_string(s : GraphconnectstrongFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphconnectstrongTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_connect_strong_table_make(size : Int) -> GraphconnectstrongTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_connect_strong_table_len(s : GraphconnectstrongTable) -> Int { s.size }

pub fn graph_connect_strong_table_get(s : GraphconnectstrongTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_connect_strong_table_set(s : GraphconnectstrongTable, i : Int, v : Double) -> GraphconnectstrongTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_connect_strong_table_sum(s : GraphconnectstrongTable) -> Double { @_common.sum(s.data) }

pub fn graph_connect_strong_table_mean(s : GraphconnectstrongTable) -> Double { @_common.mean(s.data) }

pub fn graph_connect_strong_table_scale(s : GraphconnectstrongTable, f : Double) -> GraphconnectstrongTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_connect_strong_table_add(a : GraphconnectstrongTable, b : GraphconnectstrongTable) -> GraphconnectstrongTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_connect_strong_table_copy(s : GraphconnectstrongTable) -> GraphconnectstrongTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_connect_strong_table_fill(s : GraphconnectstrongTable, v : Double) -> GraphconnectstrongTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_connect_strong_table_min(s : GraphconnectstrongTable) -> Double { @_common.min(s.data) }

pub fn graph_connect_strong_table_max(s : GraphconnectstrongTable) -> Double { @_common.max(s.data) }

pub fn graph_connect_strong_table_to_string(s : GraphconnectstrongTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphconnectstrongGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_connect_strong_graphn_make(size : Int) -> GraphconnectstrongGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_connect_strong_graphn_len(s : GraphconnectstrongGraphN) -> Int { s.size }

pub fn graph_connect_strong_graphn_get(s : GraphconnectstrongGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_connect_strong_graphn_set(s : GraphconnectstrongGraphN, i : Int, v : Double) -> GraphconnectstrongGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_connect_strong_graphn_sum(s : GraphconnectstrongGraphN) -> Double { @_common.sum(s.data) }

pub fn graph_connect_strong_graphn_mean(s : GraphconnectstrongGraphN) -> Double { @_common.mean(s.data) }

pub fn graph_connect_strong_graphn_scale(s : GraphconnectstrongGraphN, f : Double) -> GraphconnectstrongGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_connect_strong_graphn_add(a : GraphconnectstrongGraphN, b : GraphconnectstrongGraphN) -> GraphconnectstrongGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_connect_strong_graphn_copy(s : GraphconnectstrongGraphN) -> GraphconnectstrongGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_connect_strong_graphn_fill(s : GraphconnectstrongGraphN, v : Double) -> GraphconnectstrongGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_connect_strong_graphn_min(s : GraphconnectstrongGraphN) -> Double { @_common.min(s.data) }

pub fn graph_connect_strong_graphn_max(s : GraphconnectstrongGraphN) -> Double { @_common.max(s.data) }

pub fn graph_connect_strong_graphn_to_string(s : GraphconnectstrongGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphconnectstrongNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_connect_strong_node_make(size : Int) -> GraphconnectstrongNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_connect_strong_node_len(s : GraphconnectstrongNode) -> Int { s.size }

pub fn graph_connect_strong_node_get(s : GraphconnectstrongNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_connect_strong_node_set(s : GraphconnectstrongNode, i : Int, v : Double) -> GraphconnectstrongNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_connect_strong_node_sum(s : GraphconnectstrongNode) -> Double { @_common.sum(s.data) }

pub fn graph_connect_strong_node_mean(s : GraphconnectstrongNode) -> Double { @_common.mean(s.data) }

pub fn graph_connect_strong_node_scale(s : GraphconnectstrongNode, f : Double) -> GraphconnectstrongNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_connect_strong_node_add(a : GraphconnectstrongNode, b : GraphconnectstrongNode) -> GraphconnectstrongNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_connect_strong_node_copy(s : GraphconnectstrongNode) -> GraphconnectstrongNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_connect_strong_node_fill(s : GraphconnectstrongNode, v : Double) -> GraphconnectstrongNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_connect_strong_node_min(s : GraphconnectstrongNode) -> Double { @_common.min(s.data) }

pub fn graph_connect_strong_node_max(s : GraphconnectstrongNode) -> Double { @_common.max(s.data) }

pub fn graph_connect_strong_node_to_string(s : GraphconnectstrongNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphconnectstrongEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_connect_strong_edge_make(size : Int) -> GraphconnectstrongEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_connect_strong_edge_len(s : GraphconnectstrongEdge) -> Int { s.size }

pub fn graph_connect_strong_edge_get(s : GraphconnectstrongEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_connect_strong_edge_set(s : GraphconnectstrongEdge, i : Int, v : Double) -> GraphconnectstrongEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_connect_strong_edge_sum(s : GraphconnectstrongEdge) -> Double { @_common.sum(s.data) }

pub fn graph_connect_strong_edge_mean(s : GraphconnectstrongEdge) -> Double { @_common.mean(s.data) }

pub fn graph_connect_strong_edge_scale(s : GraphconnectstrongEdge, f : Double) -> GraphconnectstrongEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_connect_strong_edge_add(a : GraphconnectstrongEdge, b : GraphconnectstrongEdge) -> GraphconnectstrongEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_connect_strong_edge_copy(s : GraphconnectstrongEdge) -> GraphconnectstrongEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_connect_strong_edge_fill(s : GraphconnectstrongEdge, v : Double) -> GraphconnectstrongEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_connect_strong_edge_min(s : GraphconnectstrongEdge) -> Double { @_common.min(s.data) }

pub fn graph_connect_strong_edge_max(s : GraphconnectstrongEdge) -> Double { @_common.max(s.data) }

pub fn graph_connect_strong_edge_to_string(s : GraphconnectstrongEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphconnectstrongPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_connect_strong_path_make(size : Int) -> GraphconnectstrongPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_connect_strong_path_len(s : GraphconnectstrongPath) -> Int { s.size }

pub fn graph_connect_strong_path_get(s : GraphconnectstrongPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_connect_strong_path_set(s : GraphconnectstrongPath, i : Int, v : Double) -> GraphconnectstrongPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_connect_strong_path_sum(s : GraphconnectstrongPath) -> Double { @_common.sum(s.data) }

pub fn graph_connect_strong_path_mean(s : GraphconnectstrongPath) -> Double { @_common.mean(s.data) }

pub fn graph_connect_strong_path_scale(s : GraphconnectstrongPath, f : Double) -> GraphconnectstrongPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_connect_strong_path_add(a : GraphconnectstrongPath, b : GraphconnectstrongPath) -> GraphconnectstrongPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_connect_strong_path_copy(s : GraphconnectstrongPath) -> GraphconnectstrongPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_connect_strong_path_fill(s : GraphconnectstrongPath, v : Double) -> GraphconnectstrongPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_connect_strong_path_min(s : GraphconnectstrongPath) -> Double { @_common.min(s.data) }

pub fn graph_connect_strong_path_max(s : GraphconnectstrongPath) -> Double { @_common.max(s.data) }

pub fn graph_connect_strong_path_to_string(s : GraphconnectstrongPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphconnectstrongCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_connect_strong_cluster_make(size : Int) -> GraphconnectstrongCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_connect_strong_cluster_len(s : GraphconnectstrongCluster) -> Int { s.size }

pub fn graph_connect_strong_cluster_get(s : GraphconnectstrongCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_connect_strong_cluster_set(s : GraphconnectstrongCluster, i : Int, v : Double) -> GraphconnectstrongCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_connect_strong_cluster_sum(s : GraphconnectstrongCluster) -> Double { @_common.sum(s.data) }

pub fn graph_connect_strong_cluster_mean(s : GraphconnectstrongCluster) -> Double { @_common.mean(s.data) }

pub fn graph_connect_strong_cluster_scale(s : GraphconnectstrongCluster, f : Double) -> GraphconnectstrongCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_connect_strong_cluster_add(a : GraphconnectstrongCluster, b : GraphconnectstrongCluster) -> GraphconnectstrongCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_connect_strong_cluster_copy(s : GraphconnectstrongCluster) -> GraphconnectstrongCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_connect_strong_cluster_fill(s : GraphconnectstrongCluster, v : Double) -> GraphconnectstrongCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_connect_strong_cluster_min(s : GraphconnectstrongCluster) -> Double { @_common.min(s.data) }

pub fn graph_connect_strong_cluster_max(s : GraphconnectstrongCluster) -> Double { @_common.max(s.data) }

pub fn graph_connect_strong_cluster_to_string(s : GraphconnectstrongCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphconnectstrongModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_connect_strong_model_make(size : Int) -> GraphconnectstrongModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_connect_strong_model_len(s : GraphconnectstrongModel) -> Int { s.size }

pub fn graph_connect_strong_model_get(s : GraphconnectstrongModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_connect_strong_model_set(s : GraphconnectstrongModel, i : Int, v : Double) -> GraphconnectstrongModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_connect_strong_model_sum(s : GraphconnectstrongModel) -> Double { @_common.sum(s.data) }

pub fn graph_connect_strong_model_mean(s : GraphconnectstrongModel) -> Double { @_common.mean(s.data) }

pub fn graph_connect_strong_model_scale(s : GraphconnectstrongModel, f : Double) -> GraphconnectstrongModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_connect_strong_model_add(a : GraphconnectstrongModel, b : GraphconnectstrongModel) -> GraphconnectstrongModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_connect_strong_model_copy(s : GraphconnectstrongModel) -> GraphconnectstrongModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_connect_strong_model_fill(s : GraphconnectstrongModel, v : Double) -> GraphconnectstrongModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_connect_strong_model_min(s : GraphconnectstrongModel) -> Double { @_common.min(s.data) }

pub fn graph_connect_strong_model_max(s : GraphconnectstrongModel) -> Double { @_common.max(s.data) }

pub fn graph_connect_strong_model_to_string(s : GraphconnectstrongModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphconnectstrongLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_connect_strong_layer_make(size : Int) -> GraphconnectstrongLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_connect_strong_layer_len(s : GraphconnectstrongLayer) -> Int { s.size }

pub fn graph_connect_strong_layer_get(s : GraphconnectstrongLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_connect_strong_layer_set(s : GraphconnectstrongLayer, i : Int, v : Double) -> GraphconnectstrongLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_connect_strong_layer_sum(s : GraphconnectstrongLayer) -> Double { @_common.sum(s.data) }

pub fn graph_connect_strong_layer_mean(s : GraphconnectstrongLayer) -> Double { @_common.mean(s.data) }

pub fn graph_connect_strong_layer_scale(s : GraphconnectstrongLayer, f : Double) -> GraphconnectstrongLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_connect_strong_layer_add(a : GraphconnectstrongLayer, b : GraphconnectstrongLayer) -> GraphconnectstrongLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_connect_strong_layer_copy(s : GraphconnectstrongLayer) -> GraphconnectstrongLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_connect_strong_layer_fill(s : GraphconnectstrongLayer, v : Double) -> GraphconnectstrongLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_connect_strong_layer_min(s : GraphconnectstrongLayer) -> Double { @_common.min(s.data) }

pub fn graph_connect_strong_layer_max(s : GraphconnectstrongLayer) -> Double { @_common.max(s.data) }

pub fn graph_connect_strong_layer_to_string(s : GraphconnectstrongLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphconnectstrongBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_connect_strong_buffer_make(size : Int) -> GraphconnectstrongBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_connect_strong_buffer_len(s : GraphconnectstrongBuffer) -> Int { s.size }

pub fn graph_connect_strong_buffer_get(s : GraphconnectstrongBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_connect_strong_buffer_set(s : GraphconnectstrongBuffer, i : Int, v : Double) -> GraphconnectstrongBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_connect_strong_buffer_sum(s : GraphconnectstrongBuffer) -> Double { @_common.sum(s.data) }

pub fn graph_connect_strong_buffer_mean(s : GraphconnectstrongBuffer) -> Double { @_common.mean(s.data) }

pub fn graph_connect_strong_buffer_scale(s : GraphconnectstrongBuffer, f : Double) -> GraphconnectstrongBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_connect_strong_buffer_add(a : GraphconnectstrongBuffer, b : GraphconnectstrongBuffer) -> GraphconnectstrongBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_connect_strong_buffer_copy(s : GraphconnectstrongBuffer) -> GraphconnectstrongBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_connect_strong_buffer_fill(s : GraphconnectstrongBuffer, v : Double) -> GraphconnectstrongBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_connect_strong_buffer_min(s : GraphconnectstrongBuffer) -> Double { @_common.min(s.data) }

pub fn graph_connect_strong_buffer_max(s : GraphconnectstrongBuffer) -> Double { @_common.max(s.data) }

pub fn graph_connect_strong_buffer_to_string(s : GraphconnectstrongBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphconnectstrongCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_connect_strong_cursor_make(size : Int) -> GraphconnectstrongCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_connect_strong_cursor_len(s : GraphconnectstrongCursor) -> Int { s.size }

pub fn graph_connect_strong_cursor_get(s : GraphconnectstrongCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_connect_strong_cursor_set(s : GraphconnectstrongCursor, i : Int, v : Double) -> GraphconnectstrongCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_connect_strong_cursor_sum(s : GraphconnectstrongCursor) -> Double { @_common.sum(s.data) }

pub fn graph_connect_strong_cursor_mean(s : GraphconnectstrongCursor) -> Double { @_common.mean(s.data) }

pub fn graph_connect_strong_cursor_scale(s : GraphconnectstrongCursor, f : Double) -> GraphconnectstrongCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_connect_strong_cursor_add(a : GraphconnectstrongCursor, b : GraphconnectstrongCursor) -> GraphconnectstrongCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_connect_strong_cursor_copy(s : GraphconnectstrongCursor) -> GraphconnectstrongCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_connect_strong_cursor_fill(s : GraphconnectstrongCursor, v : Double) -> GraphconnectstrongCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_connect_strong_cursor_min(s : GraphconnectstrongCursor) -> Double { @_common.min(s.data) }

pub fn graph_connect_strong_cursor_max(s : GraphconnectstrongCursor) -> Double { @_common.max(s.data) }

pub fn graph_connect_strong_cursor_to_string(s : GraphconnectstrongCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphconnectstrongView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_connect_strong_view_make(size : Int) -> GraphconnectstrongView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_connect_strong_view_len(s : GraphconnectstrongView) -> Int { s.size }

pub fn graph_connect_strong_view_get(s : GraphconnectstrongView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_connect_strong_view_set(s : GraphconnectstrongView, i : Int, v : Double) -> GraphconnectstrongView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_connect_strong_view_sum(s : GraphconnectstrongView) -> Double { @_common.sum(s.data) }

pub fn graph_connect_strong_view_mean(s : GraphconnectstrongView) -> Double { @_common.mean(s.data) }

pub fn graph_connect_strong_view_scale(s : GraphconnectstrongView, f : Double) -> GraphconnectstrongView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_connect_strong_view_add(a : GraphconnectstrongView, b : GraphconnectstrongView) -> GraphconnectstrongView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_connect_strong_view_copy(s : GraphconnectstrongView) -> GraphconnectstrongView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_connect_strong_view_fill(s : GraphconnectstrongView, v : Double) -> GraphconnectstrongView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_connect_strong_view_min(s : GraphconnectstrongView) -> Double { @_common.min(s.data) }

pub fn graph_connect_strong_view_max(s : GraphconnectstrongView) -> Double { @_common.max(s.data) }

pub fn graph_connect_strong_view_to_string(s : GraphconnectstrongView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphconnectstrongRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_connect_strong_range_make(size : Int) -> GraphconnectstrongRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_connect_strong_range_len(s : GraphconnectstrongRange) -> Int { s.size }

pub fn graph_connect_strong_range_get(s : GraphconnectstrongRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_connect_strong_range_set(s : GraphconnectstrongRange, i : Int, v : Double) -> GraphconnectstrongRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_connect_strong_range_sum(s : GraphconnectstrongRange) -> Double { @_common.sum(s.data) }

pub fn graph_connect_strong_range_mean(s : GraphconnectstrongRange) -> Double { @_common.mean(s.data) }

pub fn graph_connect_strong_range_scale(s : GraphconnectstrongRange, f : Double) -> GraphconnectstrongRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_connect_strong_range_add(a : GraphconnectstrongRange, b : GraphconnectstrongRange) -> GraphconnectstrongRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_connect_strong_range_copy(s : GraphconnectstrongRange) -> GraphconnectstrongRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_connect_strong_range_fill(s : GraphconnectstrongRange, v : Double) -> GraphconnectstrongRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_connect_strong_range_min(s : GraphconnectstrongRange) -> Double { @_common.min(s.data) }

pub fn graph_connect_strong_range_max(s : GraphconnectstrongRange) -> Double { @_common.max(s.data) }

pub fn graph_connect_strong_range_to_string(s : GraphconnectstrongRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphconnectstrongSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_connect_strong_slice_make(size : Int) -> GraphconnectstrongSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_connect_strong_slice_len(s : GraphconnectstrongSlice) -> Int { s.size }

pub fn graph_connect_strong_slice_get(s : GraphconnectstrongSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_connect_strong_slice_set(s : GraphconnectstrongSlice, i : Int, v : Double) -> GraphconnectstrongSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_connect_strong_slice_sum(s : GraphconnectstrongSlice) -> Double { @_common.sum(s.data) }

pub fn graph_connect_strong_slice_mean(s : GraphconnectstrongSlice) -> Double { @_common.mean(s.data) }

pub fn graph_connect_strong_slice_scale(s : GraphconnectstrongSlice, f : Double) -> GraphconnectstrongSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_connect_strong_slice_add(a : GraphconnectstrongSlice, b : GraphconnectstrongSlice) -> GraphconnectstrongSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_connect_strong_slice_copy(s : GraphconnectstrongSlice) -> GraphconnectstrongSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_connect_strong_slice_fill(s : GraphconnectstrongSlice, v : Double) -> GraphconnectstrongSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_connect_strong_slice_min(s : GraphconnectstrongSlice) -> Double { @_common.min(s.data) }

pub fn graph_connect_strong_slice_max(s : GraphconnectstrongSlice) -> Double { @_common.max(s.data) }

pub fn graph_connect_strong_slice_to_string(s : GraphconnectstrongSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

