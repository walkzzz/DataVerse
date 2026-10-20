///===
/// extcore/graph_flow_transport

pub(all) struct GraphflowtransportPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn graph_flow_transport_make_point(x : Double, y : Double) -> GraphflowtransportPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn graph_flow_transport_make_point3(x : Double, y : Double, z : Double) -> GraphflowtransportPoint {
  { x, y, z, label: 0 }
}

pub fn GraphflowtransportPoint::x(self : GraphflowtransportPoint) -> Double { self.x }

pub fn GraphflowtransportPoint::y(self : GraphflowtransportPoint) -> Double { self.y }

pub fn GraphflowtransportPoint::z(self : GraphflowtransportPoint) -> Double { self.z }

pub fn GraphflowtransportPoint::label(self : GraphflowtransportPoint) -> Int { self.label }

pub fn GraphflowtransportPoint::dist(self : GraphflowtransportPoint, other : GraphflowtransportPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn GraphflowtransportPoint::add(self : GraphflowtransportPoint, other : GraphflowtransportPoint) -> GraphflowtransportPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn GraphflowtransportPoint::sub(self : GraphflowtransportPoint, other : GraphflowtransportPoint) -> GraphflowtransportPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn GraphflowtransportPoint::scale(self : GraphflowtransportPoint, s : Double) -> GraphflowtransportPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn GraphflowtransportPoint::dot(self : GraphflowtransportPoint, other : GraphflowtransportPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn GraphflowtransportPoint::cross(self : GraphflowtransportPoint, other : GraphflowtransportPoint) -> GraphflowtransportPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn GraphflowtransportPoint::norm(self : GraphflowtransportPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn GraphflowtransportPoint::normalize(self : GraphflowtransportPoint) -> GraphflowtransportPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn GraphflowtransportPoint::negate(self : GraphflowtransportPoint) -> GraphflowtransportPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn GraphflowtransportPoint::mid(self : GraphflowtransportPoint, other : GraphflowtransportPoint) -> GraphflowtransportPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn GraphflowtransportPoint::lerp(self : GraphflowtransportPoint, other : GraphflowtransportPoint, t : Double) -> GraphflowtransportPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn GraphflowtransportPoint::to_string(self : GraphflowtransportPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct GraphflowtransportSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn graph_flow_transport_make_series(vals : Array[Double], name : String) -> GraphflowtransportSeries {
  { vals, name, meta: 0 }
}

pub fn GraphflowtransportSeries::len(self : GraphflowtransportSeries) -> Int { self.vals.length() }

pub fn GraphflowtransportSeries::sum(self : GraphflowtransportSeries) -> Double { @_common.sum(self.vals) }

pub fn GraphflowtransportSeries::mean(self : GraphflowtransportSeries) -> Double { @_common.mean(self.vals) }

pub fn GraphflowtransportSeries::min(self : GraphflowtransportSeries) -> Double { @_common.min(self.vals) }

pub fn GraphflowtransportSeries::max(self : GraphflowtransportSeries) -> Double { @_common.max(self.vals) }

pub fn GraphflowtransportSeries::range(self : GraphflowtransportSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn GraphflowtransportSeries::variance(self : GraphflowtransportSeries) -> Double { @_common.variance(self.vals) }

pub fn GraphflowtransportSeries::std(self : GraphflowtransportSeries) -> Double { @_common.std(self.vals) }

pub fn GraphflowtransportSeries::median(self : GraphflowtransportSeries) -> Double { @_common.median(self.vals) }

pub fn GraphflowtransportSeries::scale(self : GraphflowtransportSeries, f : Double) -> GraphflowtransportSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn GraphflowtransportSeries::add(self : GraphflowtransportSeries, other : GraphflowtransportSeries) -> GraphflowtransportSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn GraphflowtransportSeries::sub(self : GraphflowtransportSeries, other : GraphflowtransportSeries) -> GraphflowtransportSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn GraphflowtransportSeries::normalize(self : GraphflowtransportSeries) -> GraphflowtransportSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn GraphflowtransportSeries::cumsum(self : GraphflowtransportSeries) -> GraphflowtransportSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn GraphflowtransportSeries::to_string(self : GraphflowtransportSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct GraphflowtransportMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn graph_flow_transport_make_matrix(rows : Int, cols : Int, val : Double) -> GraphflowtransportMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn graph_flow_transport_matrix_identity(n : Int) -> GraphflowtransportMatrix {
  let m = graph_flow_transport_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn GraphflowtransportMatrix::get(self : GraphflowtransportMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn GraphflowtransportMatrix::transpose(self : GraphflowtransportMatrix) -> GraphflowtransportMatrix {
  let result = graph_flow_transport_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn GraphflowtransportMatrix::add(self : GraphflowtransportMatrix, other : GraphflowtransportMatrix) -> GraphflowtransportMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = graph_flow_transport_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn GraphflowtransportMatrix::scale(self : GraphflowtransportMatrix, s : Double) -> GraphflowtransportMatrix {
  let result = graph_flow_transport_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn GraphflowtransportMatrix::multiply(self : GraphflowtransportMatrix, other : GraphflowtransportMatrix) -> GraphflowtransportMatrix {
  if self.cols != other.rows { return graph_flow_transport_make_matrix(self.rows, other.cols, 0.0) }
  let result = graph_flow_transport_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn GraphflowtransportMatrix::trace(self : GraphflowtransportMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn GraphflowtransportMatrix::det(self : GraphflowtransportMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn GraphflowtransportMatrix::norm(self : GraphflowtransportMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn GraphflowtransportMatrix::to_string(self : GraphflowtransportMatrix) -> String {
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

pub(all) struct GraphflowtransportVector {
  comps : Array[Double]
  dim : Int
}

pub fn graph_flow_transport_make_vector(comps : Array[Double]) -> GraphflowtransportVector {
  { comps, dim: comps.length() }
}

pub fn graph_flow_transport_vector_zero(dim : Int) -> GraphflowtransportVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn GraphflowtransportVector::add(self : GraphflowtransportVector, other : GraphflowtransportVector) -> GraphflowtransportVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn GraphflowtransportVector::sub(self : GraphflowtransportVector, other : GraphflowtransportVector) -> GraphflowtransportVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn GraphflowtransportVector::scale(self : GraphflowtransportVector, s : Double) -> GraphflowtransportVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn GraphflowtransportVector::dot(self : GraphflowtransportVector, other : GraphflowtransportVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn GraphflowtransportVector::norm(self : GraphflowtransportVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn GraphflowtransportVector::normalize(self : GraphflowtransportVector) -> GraphflowtransportVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn GraphflowtransportVector::dist(self : GraphflowtransportVector, other : GraphflowtransportVector) -> Double {
  self.sub(other).norm()
}

pub fn GraphflowtransportVector::to_string(self : GraphflowtransportVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn graph_flow_transport_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn graph_flow_transport_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn graph_flow_transport_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn graph_flow_transport_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn graph_flow_transport_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn graph_flow_transport_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn graph_flow_transport_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn graph_flow_transport_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn graph_flow_transport_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn graph_flow_transport_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn graph_flow_transport_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn graph_flow_transport_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn graph_flow_transport_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn graph_flow_transport_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn graph_flow_transport_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn graph_flow_transport_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn graph_flow_transport_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn graph_flow_transport_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn graph_flow_transport_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn graph_flow_transport_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn graph_flow_transport_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn graph_flow_transport_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn graph_flow_transport_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn graph_flow_transport_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn graph_flow_transport_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn graph_flow_transport_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn graph_flow_transport_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn graph_flow_transport_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn graph_flow_transport_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct GraphflowtransportFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_flow_transport_frame_make(size : Int) -> GraphflowtransportFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_flow_transport_frame_len(s : GraphflowtransportFrame) -> Int { s.size }

pub fn graph_flow_transport_frame_get(s : GraphflowtransportFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_flow_transport_frame_set(s : GraphflowtransportFrame, i : Int, v : Double) -> GraphflowtransportFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_flow_transport_frame_sum(s : GraphflowtransportFrame) -> Double { @_common.sum(s.data) }

pub fn graph_flow_transport_frame_mean(s : GraphflowtransportFrame) -> Double { @_common.mean(s.data) }

pub fn graph_flow_transport_frame_scale(s : GraphflowtransportFrame, f : Double) -> GraphflowtransportFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_flow_transport_frame_add(a : GraphflowtransportFrame, b : GraphflowtransportFrame) -> GraphflowtransportFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_flow_transport_frame_copy(s : GraphflowtransportFrame) -> GraphflowtransportFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_flow_transport_frame_fill(s : GraphflowtransportFrame, v : Double) -> GraphflowtransportFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_flow_transport_frame_min(s : GraphflowtransportFrame) -> Double { @_common.min(s.data) }

pub fn graph_flow_transport_frame_max(s : GraphflowtransportFrame) -> Double { @_common.max(s.data) }

pub fn graph_flow_transport_frame_to_string(s : GraphflowtransportFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphflowtransportTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_flow_transport_table_make(size : Int) -> GraphflowtransportTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_flow_transport_table_len(s : GraphflowtransportTable) -> Int { s.size }

pub fn graph_flow_transport_table_get(s : GraphflowtransportTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_flow_transport_table_set(s : GraphflowtransportTable, i : Int, v : Double) -> GraphflowtransportTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_flow_transport_table_sum(s : GraphflowtransportTable) -> Double { @_common.sum(s.data) }

pub fn graph_flow_transport_table_mean(s : GraphflowtransportTable) -> Double { @_common.mean(s.data) }

pub fn graph_flow_transport_table_scale(s : GraphflowtransportTable, f : Double) -> GraphflowtransportTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_flow_transport_table_add(a : GraphflowtransportTable, b : GraphflowtransportTable) -> GraphflowtransportTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_flow_transport_table_copy(s : GraphflowtransportTable) -> GraphflowtransportTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_flow_transport_table_fill(s : GraphflowtransportTable, v : Double) -> GraphflowtransportTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_flow_transport_table_min(s : GraphflowtransportTable) -> Double { @_common.min(s.data) }

pub fn graph_flow_transport_table_max(s : GraphflowtransportTable) -> Double { @_common.max(s.data) }

pub fn graph_flow_transport_table_to_string(s : GraphflowtransportTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphflowtransportGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_flow_transport_graphn_make(size : Int) -> GraphflowtransportGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_flow_transport_graphn_len(s : GraphflowtransportGraphN) -> Int { s.size }

pub fn graph_flow_transport_graphn_get(s : GraphflowtransportGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_flow_transport_graphn_set(s : GraphflowtransportGraphN, i : Int, v : Double) -> GraphflowtransportGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_flow_transport_graphn_sum(s : GraphflowtransportGraphN) -> Double { @_common.sum(s.data) }

pub fn graph_flow_transport_graphn_mean(s : GraphflowtransportGraphN) -> Double { @_common.mean(s.data) }

pub fn graph_flow_transport_graphn_scale(s : GraphflowtransportGraphN, f : Double) -> GraphflowtransportGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_flow_transport_graphn_add(a : GraphflowtransportGraphN, b : GraphflowtransportGraphN) -> GraphflowtransportGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_flow_transport_graphn_copy(s : GraphflowtransportGraphN) -> GraphflowtransportGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_flow_transport_graphn_fill(s : GraphflowtransportGraphN, v : Double) -> GraphflowtransportGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_flow_transport_graphn_min(s : GraphflowtransportGraphN) -> Double { @_common.min(s.data) }

pub fn graph_flow_transport_graphn_max(s : GraphflowtransportGraphN) -> Double { @_common.max(s.data) }

pub fn graph_flow_transport_graphn_to_string(s : GraphflowtransportGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphflowtransportNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_flow_transport_node_make(size : Int) -> GraphflowtransportNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_flow_transport_node_len(s : GraphflowtransportNode) -> Int { s.size }

pub fn graph_flow_transport_node_get(s : GraphflowtransportNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_flow_transport_node_set(s : GraphflowtransportNode, i : Int, v : Double) -> GraphflowtransportNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_flow_transport_node_sum(s : GraphflowtransportNode) -> Double { @_common.sum(s.data) }

pub fn graph_flow_transport_node_mean(s : GraphflowtransportNode) -> Double { @_common.mean(s.data) }

pub fn graph_flow_transport_node_scale(s : GraphflowtransportNode, f : Double) -> GraphflowtransportNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_flow_transport_node_add(a : GraphflowtransportNode, b : GraphflowtransportNode) -> GraphflowtransportNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_flow_transport_node_copy(s : GraphflowtransportNode) -> GraphflowtransportNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_flow_transport_node_fill(s : GraphflowtransportNode, v : Double) -> GraphflowtransportNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_flow_transport_node_min(s : GraphflowtransportNode) -> Double { @_common.min(s.data) }

pub fn graph_flow_transport_node_max(s : GraphflowtransportNode) -> Double { @_common.max(s.data) }

pub fn graph_flow_transport_node_to_string(s : GraphflowtransportNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphflowtransportEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_flow_transport_edge_make(size : Int) -> GraphflowtransportEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_flow_transport_edge_len(s : GraphflowtransportEdge) -> Int { s.size }

pub fn graph_flow_transport_edge_get(s : GraphflowtransportEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_flow_transport_edge_set(s : GraphflowtransportEdge, i : Int, v : Double) -> GraphflowtransportEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_flow_transport_edge_sum(s : GraphflowtransportEdge) -> Double { @_common.sum(s.data) }

pub fn graph_flow_transport_edge_mean(s : GraphflowtransportEdge) -> Double { @_common.mean(s.data) }

pub fn graph_flow_transport_edge_scale(s : GraphflowtransportEdge, f : Double) -> GraphflowtransportEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_flow_transport_edge_add(a : GraphflowtransportEdge, b : GraphflowtransportEdge) -> GraphflowtransportEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_flow_transport_edge_copy(s : GraphflowtransportEdge) -> GraphflowtransportEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_flow_transport_edge_fill(s : GraphflowtransportEdge, v : Double) -> GraphflowtransportEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_flow_transport_edge_min(s : GraphflowtransportEdge) -> Double { @_common.min(s.data) }

pub fn graph_flow_transport_edge_max(s : GraphflowtransportEdge) -> Double { @_common.max(s.data) }

pub fn graph_flow_transport_edge_to_string(s : GraphflowtransportEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphflowtransportPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_flow_transport_path_make(size : Int) -> GraphflowtransportPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_flow_transport_path_len(s : GraphflowtransportPath) -> Int { s.size }

pub fn graph_flow_transport_path_get(s : GraphflowtransportPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_flow_transport_path_set(s : GraphflowtransportPath, i : Int, v : Double) -> GraphflowtransportPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_flow_transport_path_sum(s : GraphflowtransportPath) -> Double { @_common.sum(s.data) }

pub fn graph_flow_transport_path_mean(s : GraphflowtransportPath) -> Double { @_common.mean(s.data) }

pub fn graph_flow_transport_path_scale(s : GraphflowtransportPath, f : Double) -> GraphflowtransportPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_flow_transport_path_add(a : GraphflowtransportPath, b : GraphflowtransportPath) -> GraphflowtransportPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_flow_transport_path_copy(s : GraphflowtransportPath) -> GraphflowtransportPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_flow_transport_path_fill(s : GraphflowtransportPath, v : Double) -> GraphflowtransportPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_flow_transport_path_min(s : GraphflowtransportPath) -> Double { @_common.min(s.data) }

pub fn graph_flow_transport_path_max(s : GraphflowtransportPath) -> Double { @_common.max(s.data) }

pub fn graph_flow_transport_path_to_string(s : GraphflowtransportPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphflowtransportCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_flow_transport_cluster_make(size : Int) -> GraphflowtransportCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_flow_transport_cluster_len(s : GraphflowtransportCluster) -> Int { s.size }

pub fn graph_flow_transport_cluster_get(s : GraphflowtransportCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_flow_transport_cluster_set(s : GraphflowtransportCluster, i : Int, v : Double) -> GraphflowtransportCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_flow_transport_cluster_sum(s : GraphflowtransportCluster) -> Double { @_common.sum(s.data) }

pub fn graph_flow_transport_cluster_mean(s : GraphflowtransportCluster) -> Double { @_common.mean(s.data) }

pub fn graph_flow_transport_cluster_scale(s : GraphflowtransportCluster, f : Double) -> GraphflowtransportCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_flow_transport_cluster_add(a : GraphflowtransportCluster, b : GraphflowtransportCluster) -> GraphflowtransportCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_flow_transport_cluster_copy(s : GraphflowtransportCluster) -> GraphflowtransportCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_flow_transport_cluster_fill(s : GraphflowtransportCluster, v : Double) -> GraphflowtransportCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_flow_transport_cluster_min(s : GraphflowtransportCluster) -> Double { @_common.min(s.data) }

pub fn graph_flow_transport_cluster_max(s : GraphflowtransportCluster) -> Double { @_common.max(s.data) }

pub fn graph_flow_transport_cluster_to_string(s : GraphflowtransportCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphflowtransportModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_flow_transport_model_make(size : Int) -> GraphflowtransportModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_flow_transport_model_len(s : GraphflowtransportModel) -> Int { s.size }

pub fn graph_flow_transport_model_get(s : GraphflowtransportModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_flow_transport_model_set(s : GraphflowtransportModel, i : Int, v : Double) -> GraphflowtransportModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_flow_transport_model_sum(s : GraphflowtransportModel) -> Double { @_common.sum(s.data) }

pub fn graph_flow_transport_model_mean(s : GraphflowtransportModel) -> Double { @_common.mean(s.data) }

pub fn graph_flow_transport_model_scale(s : GraphflowtransportModel, f : Double) -> GraphflowtransportModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_flow_transport_model_add(a : GraphflowtransportModel, b : GraphflowtransportModel) -> GraphflowtransportModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_flow_transport_model_copy(s : GraphflowtransportModel) -> GraphflowtransportModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_flow_transport_model_fill(s : GraphflowtransportModel, v : Double) -> GraphflowtransportModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_flow_transport_model_min(s : GraphflowtransportModel) -> Double { @_common.min(s.data) }

pub fn graph_flow_transport_model_max(s : GraphflowtransportModel) -> Double { @_common.max(s.data) }

pub fn graph_flow_transport_model_to_string(s : GraphflowtransportModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphflowtransportLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_flow_transport_layer_make(size : Int) -> GraphflowtransportLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_flow_transport_layer_len(s : GraphflowtransportLayer) -> Int { s.size }

pub fn graph_flow_transport_layer_get(s : GraphflowtransportLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_flow_transport_layer_set(s : GraphflowtransportLayer, i : Int, v : Double) -> GraphflowtransportLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_flow_transport_layer_sum(s : GraphflowtransportLayer) -> Double { @_common.sum(s.data) }

pub fn graph_flow_transport_layer_mean(s : GraphflowtransportLayer) -> Double { @_common.mean(s.data) }

pub fn graph_flow_transport_layer_scale(s : GraphflowtransportLayer, f : Double) -> GraphflowtransportLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_flow_transport_layer_add(a : GraphflowtransportLayer, b : GraphflowtransportLayer) -> GraphflowtransportLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_flow_transport_layer_copy(s : GraphflowtransportLayer) -> GraphflowtransportLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_flow_transport_layer_fill(s : GraphflowtransportLayer, v : Double) -> GraphflowtransportLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_flow_transport_layer_min(s : GraphflowtransportLayer) -> Double { @_common.min(s.data) }

pub fn graph_flow_transport_layer_max(s : GraphflowtransportLayer) -> Double { @_common.max(s.data) }

pub fn graph_flow_transport_layer_to_string(s : GraphflowtransportLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphflowtransportBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_flow_transport_buffer_make(size : Int) -> GraphflowtransportBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_flow_transport_buffer_len(s : GraphflowtransportBuffer) -> Int { s.size }

pub fn graph_flow_transport_buffer_get(s : GraphflowtransportBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_flow_transport_buffer_set(s : GraphflowtransportBuffer, i : Int, v : Double) -> GraphflowtransportBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_flow_transport_buffer_sum(s : GraphflowtransportBuffer) -> Double { @_common.sum(s.data) }

pub fn graph_flow_transport_buffer_mean(s : GraphflowtransportBuffer) -> Double { @_common.mean(s.data) }

pub fn graph_flow_transport_buffer_scale(s : GraphflowtransportBuffer, f : Double) -> GraphflowtransportBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_flow_transport_buffer_add(a : GraphflowtransportBuffer, b : GraphflowtransportBuffer) -> GraphflowtransportBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_flow_transport_buffer_copy(s : GraphflowtransportBuffer) -> GraphflowtransportBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_flow_transport_buffer_fill(s : GraphflowtransportBuffer, v : Double) -> GraphflowtransportBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_flow_transport_buffer_min(s : GraphflowtransportBuffer) -> Double { @_common.min(s.data) }

pub fn graph_flow_transport_buffer_max(s : GraphflowtransportBuffer) -> Double { @_common.max(s.data) }

pub fn graph_flow_transport_buffer_to_string(s : GraphflowtransportBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphflowtransportCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_flow_transport_cursor_make(size : Int) -> GraphflowtransportCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_flow_transport_cursor_len(s : GraphflowtransportCursor) -> Int { s.size }

pub fn graph_flow_transport_cursor_get(s : GraphflowtransportCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_flow_transport_cursor_set(s : GraphflowtransportCursor, i : Int, v : Double) -> GraphflowtransportCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_flow_transport_cursor_sum(s : GraphflowtransportCursor) -> Double { @_common.sum(s.data) }

pub fn graph_flow_transport_cursor_mean(s : GraphflowtransportCursor) -> Double { @_common.mean(s.data) }

pub fn graph_flow_transport_cursor_scale(s : GraphflowtransportCursor, f : Double) -> GraphflowtransportCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_flow_transport_cursor_add(a : GraphflowtransportCursor, b : GraphflowtransportCursor) -> GraphflowtransportCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_flow_transport_cursor_copy(s : GraphflowtransportCursor) -> GraphflowtransportCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_flow_transport_cursor_fill(s : GraphflowtransportCursor, v : Double) -> GraphflowtransportCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_flow_transport_cursor_min(s : GraphflowtransportCursor) -> Double { @_common.min(s.data) }

pub fn graph_flow_transport_cursor_max(s : GraphflowtransportCursor) -> Double { @_common.max(s.data) }

pub fn graph_flow_transport_cursor_to_string(s : GraphflowtransportCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphflowtransportView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_flow_transport_view_make(size : Int) -> GraphflowtransportView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_flow_transport_view_len(s : GraphflowtransportView) -> Int { s.size }

pub fn graph_flow_transport_view_get(s : GraphflowtransportView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_flow_transport_view_set(s : GraphflowtransportView, i : Int, v : Double) -> GraphflowtransportView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_flow_transport_view_sum(s : GraphflowtransportView) -> Double { @_common.sum(s.data) }

pub fn graph_flow_transport_view_mean(s : GraphflowtransportView) -> Double { @_common.mean(s.data) }

pub fn graph_flow_transport_view_scale(s : GraphflowtransportView, f : Double) -> GraphflowtransportView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_flow_transport_view_add(a : GraphflowtransportView, b : GraphflowtransportView) -> GraphflowtransportView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_flow_transport_view_copy(s : GraphflowtransportView) -> GraphflowtransportView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_flow_transport_view_fill(s : GraphflowtransportView, v : Double) -> GraphflowtransportView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_flow_transport_view_min(s : GraphflowtransportView) -> Double { @_common.min(s.data) }

pub fn graph_flow_transport_view_max(s : GraphflowtransportView) -> Double { @_common.max(s.data) }

pub fn graph_flow_transport_view_to_string(s : GraphflowtransportView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphflowtransportRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_flow_transport_range_make(size : Int) -> GraphflowtransportRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_flow_transport_range_len(s : GraphflowtransportRange) -> Int { s.size }

pub fn graph_flow_transport_range_get(s : GraphflowtransportRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_flow_transport_range_set(s : GraphflowtransportRange, i : Int, v : Double) -> GraphflowtransportRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_flow_transport_range_sum(s : GraphflowtransportRange) -> Double { @_common.sum(s.data) }

pub fn graph_flow_transport_range_mean(s : GraphflowtransportRange) -> Double { @_common.mean(s.data) }

pub fn graph_flow_transport_range_scale(s : GraphflowtransportRange, f : Double) -> GraphflowtransportRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_flow_transport_range_add(a : GraphflowtransportRange, b : GraphflowtransportRange) -> GraphflowtransportRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_flow_transport_range_copy(s : GraphflowtransportRange) -> GraphflowtransportRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_flow_transport_range_fill(s : GraphflowtransportRange, v : Double) -> GraphflowtransportRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_flow_transport_range_min(s : GraphflowtransportRange) -> Double { @_common.min(s.data) }

pub fn graph_flow_transport_range_max(s : GraphflowtransportRange) -> Double { @_common.max(s.data) }

pub fn graph_flow_transport_range_to_string(s : GraphflowtransportRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphflowtransportSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_flow_transport_slice_make(size : Int) -> GraphflowtransportSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_flow_transport_slice_len(s : GraphflowtransportSlice) -> Int { s.size }

pub fn graph_flow_transport_slice_get(s : GraphflowtransportSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_flow_transport_slice_set(s : GraphflowtransportSlice, i : Int, v : Double) -> GraphflowtransportSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_flow_transport_slice_sum(s : GraphflowtransportSlice) -> Double { @_common.sum(s.data) }

pub fn graph_flow_transport_slice_mean(s : GraphflowtransportSlice) -> Double { @_common.mean(s.data) }

pub fn graph_flow_transport_slice_scale(s : GraphflowtransportSlice, f : Double) -> GraphflowtransportSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_flow_transport_slice_add(a : GraphflowtransportSlice, b : GraphflowtransportSlice) -> GraphflowtransportSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_flow_transport_slice_copy(s : GraphflowtransportSlice) -> GraphflowtransportSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_flow_transport_slice_fill(s : GraphflowtransportSlice, v : Double) -> GraphflowtransportSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_flow_transport_slice_min(s : GraphflowtransportSlice) -> Double { @_common.min(s.data) }

pub fn graph_flow_transport_slice_max(s : GraphflowtransportSlice) -> Double { @_common.max(s.data) }

pub fn graph_flow_transport_slice_to_string(s : GraphflowtransportSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

