///===
/// extcore/graph_connect_weak

pub(all) struct GraphconnectweakPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn graph_connect_weak_make_point(x : Double, y : Double) -> GraphconnectweakPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn graph_connect_weak_make_point3(x : Double, y : Double, z : Double) -> GraphconnectweakPoint {
  { x, y, z, label: 0 }
}

pub fn GraphconnectweakPoint::x(self : GraphconnectweakPoint) -> Double { self.x }

pub fn GraphconnectweakPoint::y(self : GraphconnectweakPoint) -> Double { self.y }

pub fn GraphconnectweakPoint::z(self : GraphconnectweakPoint) -> Double { self.z }

pub fn GraphconnectweakPoint::label(self : GraphconnectweakPoint) -> Int { self.label }

pub fn GraphconnectweakPoint::dist(self : GraphconnectweakPoint, other : GraphconnectweakPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn GraphconnectweakPoint::add(self : GraphconnectweakPoint, other : GraphconnectweakPoint) -> GraphconnectweakPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn GraphconnectweakPoint::sub(self : GraphconnectweakPoint, other : GraphconnectweakPoint) -> GraphconnectweakPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn GraphconnectweakPoint::scale(self : GraphconnectweakPoint, s : Double) -> GraphconnectweakPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn GraphconnectweakPoint::dot(self : GraphconnectweakPoint, other : GraphconnectweakPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn GraphconnectweakPoint::cross(self : GraphconnectweakPoint, other : GraphconnectweakPoint) -> GraphconnectweakPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn GraphconnectweakPoint::norm(self : GraphconnectweakPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn GraphconnectweakPoint::normalize(self : GraphconnectweakPoint) -> GraphconnectweakPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn GraphconnectweakPoint::negate(self : GraphconnectweakPoint) -> GraphconnectweakPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn GraphconnectweakPoint::mid(self : GraphconnectweakPoint, other : GraphconnectweakPoint) -> GraphconnectweakPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn GraphconnectweakPoint::lerp(self : GraphconnectweakPoint, other : GraphconnectweakPoint, t : Double) -> GraphconnectweakPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn GraphconnectweakPoint::to_string(self : GraphconnectweakPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct GraphconnectweakSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn graph_connect_weak_make_series(vals : Array[Double], name : String) -> GraphconnectweakSeries {
  { vals, name, meta: 0 }
}

pub fn GraphconnectweakSeries::len(self : GraphconnectweakSeries) -> Int { self.vals.length() }

pub fn GraphconnectweakSeries::sum(self : GraphconnectweakSeries) -> Double { @_common.sum(self.vals) }

pub fn GraphconnectweakSeries::mean(self : GraphconnectweakSeries) -> Double { @_common.mean(self.vals) }

pub fn GraphconnectweakSeries::min(self : GraphconnectweakSeries) -> Double { @_common.min(self.vals) }

pub fn GraphconnectweakSeries::max(self : GraphconnectweakSeries) -> Double { @_common.max(self.vals) }

pub fn GraphconnectweakSeries::range(self : GraphconnectweakSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn GraphconnectweakSeries::variance(self : GraphconnectweakSeries) -> Double { @_common.variance(self.vals) }

pub fn GraphconnectweakSeries::std(self : GraphconnectweakSeries) -> Double { @_common.std(self.vals) }

pub fn GraphconnectweakSeries::median(self : GraphconnectweakSeries) -> Double { @_common.median(self.vals) }

pub fn GraphconnectweakSeries::scale(self : GraphconnectweakSeries, f : Double) -> GraphconnectweakSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn GraphconnectweakSeries::add(self : GraphconnectweakSeries, other : GraphconnectweakSeries) -> GraphconnectweakSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn GraphconnectweakSeries::sub(self : GraphconnectweakSeries, other : GraphconnectweakSeries) -> GraphconnectweakSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn GraphconnectweakSeries::normalize(self : GraphconnectweakSeries) -> GraphconnectweakSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn GraphconnectweakSeries::cumsum(self : GraphconnectweakSeries) -> GraphconnectweakSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn GraphconnectweakSeries::to_string(self : GraphconnectweakSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct GraphconnectweakMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn graph_connect_weak_make_matrix(rows : Int, cols : Int, val : Double) -> GraphconnectweakMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn graph_connect_weak_matrix_identity(n : Int) -> GraphconnectweakMatrix {
  let m = graph_connect_weak_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn GraphconnectweakMatrix::get(self : GraphconnectweakMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn GraphconnectweakMatrix::transpose(self : GraphconnectweakMatrix) -> GraphconnectweakMatrix {
  let result = graph_connect_weak_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn GraphconnectweakMatrix::add(self : GraphconnectweakMatrix, other : GraphconnectweakMatrix) -> GraphconnectweakMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = graph_connect_weak_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn GraphconnectweakMatrix::scale(self : GraphconnectweakMatrix, s : Double) -> GraphconnectweakMatrix {
  let result = graph_connect_weak_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn GraphconnectweakMatrix::multiply(self : GraphconnectweakMatrix, other : GraphconnectweakMatrix) -> GraphconnectweakMatrix {
  if self.cols != other.rows { return graph_connect_weak_make_matrix(self.rows, other.cols, 0.0) }
  let result = graph_connect_weak_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn GraphconnectweakMatrix::trace(self : GraphconnectweakMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn GraphconnectweakMatrix::det(self : GraphconnectweakMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn GraphconnectweakMatrix::norm(self : GraphconnectweakMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn GraphconnectweakMatrix::to_string(self : GraphconnectweakMatrix) -> String {
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

pub(all) struct GraphconnectweakVector {
  comps : Array[Double]
  dim : Int
}

pub fn graph_connect_weak_make_vector(comps : Array[Double]) -> GraphconnectweakVector {
  { comps, dim: comps.length() }
}

pub fn graph_connect_weak_vector_zero(dim : Int) -> GraphconnectweakVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn GraphconnectweakVector::add(self : GraphconnectweakVector, other : GraphconnectweakVector) -> GraphconnectweakVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn GraphconnectweakVector::sub(self : GraphconnectweakVector, other : GraphconnectweakVector) -> GraphconnectweakVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn GraphconnectweakVector::scale(self : GraphconnectweakVector, s : Double) -> GraphconnectweakVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn GraphconnectweakVector::dot(self : GraphconnectweakVector, other : GraphconnectweakVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn GraphconnectweakVector::norm(self : GraphconnectweakVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn GraphconnectweakVector::normalize(self : GraphconnectweakVector) -> GraphconnectweakVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn GraphconnectweakVector::dist(self : GraphconnectweakVector, other : GraphconnectweakVector) -> Double {
  self.sub(other).norm()
}

pub fn GraphconnectweakVector::to_string(self : GraphconnectweakVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn graph_connect_weak_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn graph_connect_weak_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn graph_connect_weak_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn graph_connect_weak_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn graph_connect_weak_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn graph_connect_weak_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn graph_connect_weak_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn graph_connect_weak_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn graph_connect_weak_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn graph_connect_weak_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn graph_connect_weak_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn graph_connect_weak_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn graph_connect_weak_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn graph_connect_weak_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn graph_connect_weak_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn graph_connect_weak_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn graph_connect_weak_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn graph_connect_weak_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn graph_connect_weak_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn graph_connect_weak_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn graph_connect_weak_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn graph_connect_weak_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn graph_connect_weak_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn graph_connect_weak_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn graph_connect_weak_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn graph_connect_weak_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn graph_connect_weak_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn graph_connect_weak_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn graph_connect_weak_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct GraphconnectweakFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_connect_weak_frame_make(size : Int) -> GraphconnectweakFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_connect_weak_frame_len(s : GraphconnectweakFrame) -> Int { s.size }

pub fn graph_connect_weak_frame_get(s : GraphconnectweakFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_connect_weak_frame_set(s : GraphconnectweakFrame, i : Int, v : Double) -> GraphconnectweakFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_connect_weak_frame_sum(s : GraphconnectweakFrame) -> Double { @_common.sum(s.data) }

pub fn graph_connect_weak_frame_mean(s : GraphconnectweakFrame) -> Double { @_common.mean(s.data) }

pub fn graph_connect_weak_frame_scale(s : GraphconnectweakFrame, f : Double) -> GraphconnectweakFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_connect_weak_frame_add(a : GraphconnectweakFrame, b : GraphconnectweakFrame) -> GraphconnectweakFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_connect_weak_frame_copy(s : GraphconnectweakFrame) -> GraphconnectweakFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_connect_weak_frame_fill(s : GraphconnectweakFrame, v : Double) -> GraphconnectweakFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_connect_weak_frame_min(s : GraphconnectweakFrame) -> Double { @_common.min(s.data) }

pub fn graph_connect_weak_frame_max(s : GraphconnectweakFrame) -> Double { @_common.max(s.data) }

pub fn graph_connect_weak_frame_to_string(s : GraphconnectweakFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphconnectweakTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_connect_weak_table_make(size : Int) -> GraphconnectweakTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_connect_weak_table_len(s : GraphconnectweakTable) -> Int { s.size }

pub fn graph_connect_weak_table_get(s : GraphconnectweakTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_connect_weak_table_set(s : GraphconnectweakTable, i : Int, v : Double) -> GraphconnectweakTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_connect_weak_table_sum(s : GraphconnectweakTable) -> Double { @_common.sum(s.data) }

pub fn graph_connect_weak_table_mean(s : GraphconnectweakTable) -> Double { @_common.mean(s.data) }

pub fn graph_connect_weak_table_scale(s : GraphconnectweakTable, f : Double) -> GraphconnectweakTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_connect_weak_table_add(a : GraphconnectweakTable, b : GraphconnectweakTable) -> GraphconnectweakTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_connect_weak_table_copy(s : GraphconnectweakTable) -> GraphconnectweakTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_connect_weak_table_fill(s : GraphconnectweakTable, v : Double) -> GraphconnectweakTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_connect_weak_table_min(s : GraphconnectweakTable) -> Double { @_common.min(s.data) }

pub fn graph_connect_weak_table_max(s : GraphconnectweakTable) -> Double { @_common.max(s.data) }

pub fn graph_connect_weak_table_to_string(s : GraphconnectweakTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphconnectweakGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_connect_weak_graphn_make(size : Int) -> GraphconnectweakGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_connect_weak_graphn_len(s : GraphconnectweakGraphN) -> Int { s.size }

pub fn graph_connect_weak_graphn_get(s : GraphconnectweakGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_connect_weak_graphn_set(s : GraphconnectweakGraphN, i : Int, v : Double) -> GraphconnectweakGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_connect_weak_graphn_sum(s : GraphconnectweakGraphN) -> Double { @_common.sum(s.data) }

pub fn graph_connect_weak_graphn_mean(s : GraphconnectweakGraphN) -> Double { @_common.mean(s.data) }

pub fn graph_connect_weak_graphn_scale(s : GraphconnectweakGraphN, f : Double) -> GraphconnectweakGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_connect_weak_graphn_add(a : GraphconnectweakGraphN, b : GraphconnectweakGraphN) -> GraphconnectweakGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_connect_weak_graphn_copy(s : GraphconnectweakGraphN) -> GraphconnectweakGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_connect_weak_graphn_fill(s : GraphconnectweakGraphN, v : Double) -> GraphconnectweakGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_connect_weak_graphn_min(s : GraphconnectweakGraphN) -> Double { @_common.min(s.data) }

pub fn graph_connect_weak_graphn_max(s : GraphconnectweakGraphN) -> Double { @_common.max(s.data) }

pub fn graph_connect_weak_graphn_to_string(s : GraphconnectweakGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphconnectweakNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_connect_weak_node_make(size : Int) -> GraphconnectweakNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_connect_weak_node_len(s : GraphconnectweakNode) -> Int { s.size }

pub fn graph_connect_weak_node_get(s : GraphconnectweakNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_connect_weak_node_set(s : GraphconnectweakNode, i : Int, v : Double) -> GraphconnectweakNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_connect_weak_node_sum(s : GraphconnectweakNode) -> Double { @_common.sum(s.data) }

pub fn graph_connect_weak_node_mean(s : GraphconnectweakNode) -> Double { @_common.mean(s.data) }

pub fn graph_connect_weak_node_scale(s : GraphconnectweakNode, f : Double) -> GraphconnectweakNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_connect_weak_node_add(a : GraphconnectweakNode, b : GraphconnectweakNode) -> GraphconnectweakNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_connect_weak_node_copy(s : GraphconnectweakNode) -> GraphconnectweakNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_connect_weak_node_fill(s : GraphconnectweakNode, v : Double) -> GraphconnectweakNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_connect_weak_node_min(s : GraphconnectweakNode) -> Double { @_common.min(s.data) }

pub fn graph_connect_weak_node_max(s : GraphconnectweakNode) -> Double { @_common.max(s.data) }

pub fn graph_connect_weak_node_to_string(s : GraphconnectweakNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphconnectweakEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_connect_weak_edge_make(size : Int) -> GraphconnectweakEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_connect_weak_edge_len(s : GraphconnectweakEdge) -> Int { s.size }

pub fn graph_connect_weak_edge_get(s : GraphconnectweakEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_connect_weak_edge_set(s : GraphconnectweakEdge, i : Int, v : Double) -> GraphconnectweakEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_connect_weak_edge_sum(s : GraphconnectweakEdge) -> Double { @_common.sum(s.data) }

pub fn graph_connect_weak_edge_mean(s : GraphconnectweakEdge) -> Double { @_common.mean(s.data) }

pub fn graph_connect_weak_edge_scale(s : GraphconnectweakEdge, f : Double) -> GraphconnectweakEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_connect_weak_edge_add(a : GraphconnectweakEdge, b : GraphconnectweakEdge) -> GraphconnectweakEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_connect_weak_edge_copy(s : GraphconnectweakEdge) -> GraphconnectweakEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_connect_weak_edge_fill(s : GraphconnectweakEdge, v : Double) -> GraphconnectweakEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_connect_weak_edge_min(s : GraphconnectweakEdge) -> Double { @_common.min(s.data) }

pub fn graph_connect_weak_edge_max(s : GraphconnectweakEdge) -> Double { @_common.max(s.data) }

pub fn graph_connect_weak_edge_to_string(s : GraphconnectweakEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphconnectweakPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_connect_weak_path_make(size : Int) -> GraphconnectweakPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_connect_weak_path_len(s : GraphconnectweakPath) -> Int { s.size }

pub fn graph_connect_weak_path_get(s : GraphconnectweakPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_connect_weak_path_set(s : GraphconnectweakPath, i : Int, v : Double) -> GraphconnectweakPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_connect_weak_path_sum(s : GraphconnectweakPath) -> Double { @_common.sum(s.data) }

pub fn graph_connect_weak_path_mean(s : GraphconnectweakPath) -> Double { @_common.mean(s.data) }

pub fn graph_connect_weak_path_scale(s : GraphconnectweakPath, f : Double) -> GraphconnectweakPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_connect_weak_path_add(a : GraphconnectweakPath, b : GraphconnectweakPath) -> GraphconnectweakPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_connect_weak_path_copy(s : GraphconnectweakPath) -> GraphconnectweakPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_connect_weak_path_fill(s : GraphconnectweakPath, v : Double) -> GraphconnectweakPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_connect_weak_path_min(s : GraphconnectweakPath) -> Double { @_common.min(s.data) }

pub fn graph_connect_weak_path_max(s : GraphconnectweakPath) -> Double { @_common.max(s.data) }

pub fn graph_connect_weak_path_to_string(s : GraphconnectweakPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphconnectweakCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_connect_weak_cluster_make(size : Int) -> GraphconnectweakCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_connect_weak_cluster_len(s : GraphconnectweakCluster) -> Int { s.size }

pub fn graph_connect_weak_cluster_get(s : GraphconnectweakCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_connect_weak_cluster_set(s : GraphconnectweakCluster, i : Int, v : Double) -> GraphconnectweakCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_connect_weak_cluster_sum(s : GraphconnectweakCluster) -> Double { @_common.sum(s.data) }

pub fn graph_connect_weak_cluster_mean(s : GraphconnectweakCluster) -> Double { @_common.mean(s.data) }

pub fn graph_connect_weak_cluster_scale(s : GraphconnectweakCluster, f : Double) -> GraphconnectweakCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_connect_weak_cluster_add(a : GraphconnectweakCluster, b : GraphconnectweakCluster) -> GraphconnectweakCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_connect_weak_cluster_copy(s : GraphconnectweakCluster) -> GraphconnectweakCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_connect_weak_cluster_fill(s : GraphconnectweakCluster, v : Double) -> GraphconnectweakCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_connect_weak_cluster_min(s : GraphconnectweakCluster) -> Double { @_common.min(s.data) }

pub fn graph_connect_weak_cluster_max(s : GraphconnectweakCluster) -> Double { @_common.max(s.data) }

pub fn graph_connect_weak_cluster_to_string(s : GraphconnectweakCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphconnectweakModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_connect_weak_model_make(size : Int) -> GraphconnectweakModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_connect_weak_model_len(s : GraphconnectweakModel) -> Int { s.size }

pub fn graph_connect_weak_model_get(s : GraphconnectweakModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_connect_weak_model_set(s : GraphconnectweakModel, i : Int, v : Double) -> GraphconnectweakModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_connect_weak_model_sum(s : GraphconnectweakModel) -> Double { @_common.sum(s.data) }

pub fn graph_connect_weak_model_mean(s : GraphconnectweakModel) -> Double { @_common.mean(s.data) }

pub fn graph_connect_weak_model_scale(s : GraphconnectweakModel, f : Double) -> GraphconnectweakModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_connect_weak_model_add(a : GraphconnectweakModel, b : GraphconnectweakModel) -> GraphconnectweakModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_connect_weak_model_copy(s : GraphconnectweakModel) -> GraphconnectweakModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_connect_weak_model_fill(s : GraphconnectweakModel, v : Double) -> GraphconnectweakModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_connect_weak_model_min(s : GraphconnectweakModel) -> Double { @_common.min(s.data) }

pub fn graph_connect_weak_model_max(s : GraphconnectweakModel) -> Double { @_common.max(s.data) }

pub fn graph_connect_weak_model_to_string(s : GraphconnectweakModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphconnectweakLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_connect_weak_layer_make(size : Int) -> GraphconnectweakLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_connect_weak_layer_len(s : GraphconnectweakLayer) -> Int { s.size }

pub fn graph_connect_weak_layer_get(s : GraphconnectweakLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_connect_weak_layer_set(s : GraphconnectweakLayer, i : Int, v : Double) -> GraphconnectweakLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_connect_weak_layer_sum(s : GraphconnectweakLayer) -> Double { @_common.sum(s.data) }

pub fn graph_connect_weak_layer_mean(s : GraphconnectweakLayer) -> Double { @_common.mean(s.data) }

pub fn graph_connect_weak_layer_scale(s : GraphconnectweakLayer, f : Double) -> GraphconnectweakLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_connect_weak_layer_add(a : GraphconnectweakLayer, b : GraphconnectweakLayer) -> GraphconnectweakLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_connect_weak_layer_copy(s : GraphconnectweakLayer) -> GraphconnectweakLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_connect_weak_layer_fill(s : GraphconnectweakLayer, v : Double) -> GraphconnectweakLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_connect_weak_layer_min(s : GraphconnectweakLayer) -> Double { @_common.min(s.data) }

pub fn graph_connect_weak_layer_max(s : GraphconnectweakLayer) -> Double { @_common.max(s.data) }

pub fn graph_connect_weak_layer_to_string(s : GraphconnectweakLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphconnectweakBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_connect_weak_buffer_make(size : Int) -> GraphconnectweakBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_connect_weak_buffer_len(s : GraphconnectweakBuffer) -> Int { s.size }

pub fn graph_connect_weak_buffer_get(s : GraphconnectweakBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_connect_weak_buffer_set(s : GraphconnectweakBuffer, i : Int, v : Double) -> GraphconnectweakBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_connect_weak_buffer_sum(s : GraphconnectweakBuffer) -> Double { @_common.sum(s.data) }

pub fn graph_connect_weak_buffer_mean(s : GraphconnectweakBuffer) -> Double { @_common.mean(s.data) }

pub fn graph_connect_weak_buffer_scale(s : GraphconnectweakBuffer, f : Double) -> GraphconnectweakBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_connect_weak_buffer_add(a : GraphconnectweakBuffer, b : GraphconnectweakBuffer) -> GraphconnectweakBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_connect_weak_buffer_copy(s : GraphconnectweakBuffer) -> GraphconnectweakBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_connect_weak_buffer_fill(s : GraphconnectweakBuffer, v : Double) -> GraphconnectweakBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_connect_weak_buffer_min(s : GraphconnectweakBuffer) -> Double { @_common.min(s.data) }

pub fn graph_connect_weak_buffer_max(s : GraphconnectweakBuffer) -> Double { @_common.max(s.data) }

pub fn graph_connect_weak_buffer_to_string(s : GraphconnectweakBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphconnectweakCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_connect_weak_cursor_make(size : Int) -> GraphconnectweakCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_connect_weak_cursor_len(s : GraphconnectweakCursor) -> Int { s.size }

pub fn graph_connect_weak_cursor_get(s : GraphconnectweakCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_connect_weak_cursor_set(s : GraphconnectweakCursor, i : Int, v : Double) -> GraphconnectweakCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_connect_weak_cursor_sum(s : GraphconnectweakCursor) -> Double { @_common.sum(s.data) }

pub fn graph_connect_weak_cursor_mean(s : GraphconnectweakCursor) -> Double { @_common.mean(s.data) }

pub fn graph_connect_weak_cursor_scale(s : GraphconnectweakCursor, f : Double) -> GraphconnectweakCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_connect_weak_cursor_add(a : GraphconnectweakCursor, b : GraphconnectweakCursor) -> GraphconnectweakCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_connect_weak_cursor_copy(s : GraphconnectweakCursor) -> GraphconnectweakCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_connect_weak_cursor_fill(s : GraphconnectweakCursor, v : Double) -> GraphconnectweakCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_connect_weak_cursor_min(s : GraphconnectweakCursor) -> Double { @_common.min(s.data) }

pub fn graph_connect_weak_cursor_max(s : GraphconnectweakCursor) -> Double { @_common.max(s.data) }

pub fn graph_connect_weak_cursor_to_string(s : GraphconnectweakCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphconnectweakView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_connect_weak_view_make(size : Int) -> GraphconnectweakView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_connect_weak_view_len(s : GraphconnectweakView) -> Int { s.size }

pub fn graph_connect_weak_view_get(s : GraphconnectweakView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_connect_weak_view_set(s : GraphconnectweakView, i : Int, v : Double) -> GraphconnectweakView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_connect_weak_view_sum(s : GraphconnectweakView) -> Double { @_common.sum(s.data) }

pub fn graph_connect_weak_view_mean(s : GraphconnectweakView) -> Double { @_common.mean(s.data) }

pub fn graph_connect_weak_view_scale(s : GraphconnectweakView, f : Double) -> GraphconnectweakView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_connect_weak_view_add(a : GraphconnectweakView, b : GraphconnectweakView) -> GraphconnectweakView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_connect_weak_view_copy(s : GraphconnectweakView) -> GraphconnectweakView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_connect_weak_view_fill(s : GraphconnectweakView, v : Double) -> GraphconnectweakView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_connect_weak_view_min(s : GraphconnectweakView) -> Double { @_common.min(s.data) }

pub fn graph_connect_weak_view_max(s : GraphconnectweakView) -> Double { @_common.max(s.data) }

pub fn graph_connect_weak_view_to_string(s : GraphconnectweakView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphconnectweakRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_connect_weak_range_make(size : Int) -> GraphconnectweakRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_connect_weak_range_len(s : GraphconnectweakRange) -> Int { s.size }

pub fn graph_connect_weak_range_get(s : GraphconnectweakRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_connect_weak_range_set(s : GraphconnectweakRange, i : Int, v : Double) -> GraphconnectweakRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_connect_weak_range_sum(s : GraphconnectweakRange) -> Double { @_common.sum(s.data) }

pub fn graph_connect_weak_range_mean(s : GraphconnectweakRange) -> Double { @_common.mean(s.data) }

pub fn graph_connect_weak_range_scale(s : GraphconnectweakRange, f : Double) -> GraphconnectweakRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_connect_weak_range_add(a : GraphconnectweakRange, b : GraphconnectweakRange) -> GraphconnectweakRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_connect_weak_range_copy(s : GraphconnectweakRange) -> GraphconnectweakRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_connect_weak_range_fill(s : GraphconnectweakRange, v : Double) -> GraphconnectweakRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_connect_weak_range_min(s : GraphconnectweakRange) -> Double { @_common.min(s.data) }

pub fn graph_connect_weak_range_max(s : GraphconnectweakRange) -> Double { @_common.max(s.data) }

pub fn graph_connect_weak_range_to_string(s : GraphconnectweakRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphconnectweakSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_connect_weak_slice_make(size : Int) -> GraphconnectweakSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_connect_weak_slice_len(s : GraphconnectweakSlice) -> Int { s.size }

pub fn graph_connect_weak_slice_get(s : GraphconnectweakSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_connect_weak_slice_set(s : GraphconnectweakSlice, i : Int, v : Double) -> GraphconnectweakSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_connect_weak_slice_sum(s : GraphconnectweakSlice) -> Double { @_common.sum(s.data) }

pub fn graph_connect_weak_slice_mean(s : GraphconnectweakSlice) -> Double { @_common.mean(s.data) }

pub fn graph_connect_weak_slice_scale(s : GraphconnectweakSlice, f : Double) -> GraphconnectweakSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_connect_weak_slice_add(a : GraphconnectweakSlice, b : GraphconnectweakSlice) -> GraphconnectweakSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_connect_weak_slice_copy(s : GraphconnectweakSlice) -> GraphconnectweakSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_connect_weak_slice_fill(s : GraphconnectweakSlice, v : Double) -> GraphconnectweakSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_connect_weak_slice_min(s : GraphconnectweakSlice) -> Double { @_common.min(s.data) }

pub fn graph_connect_weak_slice_max(s : GraphconnectweakSlice) -> Double { @_common.max(s.data) }

pub fn graph_connect_weak_slice_to_string(s : GraphconnectweakSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

