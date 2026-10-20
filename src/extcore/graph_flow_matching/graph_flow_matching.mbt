///===
/// extcore/graph_flow_matching

pub(all) struct GraphflowmatchingPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn graph_flow_matching_make_point(x : Double, y : Double) -> GraphflowmatchingPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn graph_flow_matching_make_point3(x : Double, y : Double, z : Double) -> GraphflowmatchingPoint {
  { x, y, z, label: 0 }
}

pub fn GraphflowmatchingPoint::x(self : GraphflowmatchingPoint) -> Double { self.x }

pub fn GraphflowmatchingPoint::y(self : GraphflowmatchingPoint) -> Double { self.y }

pub fn GraphflowmatchingPoint::z(self : GraphflowmatchingPoint) -> Double { self.z }

pub fn GraphflowmatchingPoint::label(self : GraphflowmatchingPoint) -> Int { self.label }

pub fn GraphflowmatchingPoint::dist(self : GraphflowmatchingPoint, other : GraphflowmatchingPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn GraphflowmatchingPoint::add(self : GraphflowmatchingPoint, other : GraphflowmatchingPoint) -> GraphflowmatchingPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn GraphflowmatchingPoint::sub(self : GraphflowmatchingPoint, other : GraphflowmatchingPoint) -> GraphflowmatchingPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn GraphflowmatchingPoint::scale(self : GraphflowmatchingPoint, s : Double) -> GraphflowmatchingPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn GraphflowmatchingPoint::dot(self : GraphflowmatchingPoint, other : GraphflowmatchingPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn GraphflowmatchingPoint::cross(self : GraphflowmatchingPoint, other : GraphflowmatchingPoint) -> GraphflowmatchingPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn GraphflowmatchingPoint::norm(self : GraphflowmatchingPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn GraphflowmatchingPoint::normalize(self : GraphflowmatchingPoint) -> GraphflowmatchingPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn GraphflowmatchingPoint::negate(self : GraphflowmatchingPoint) -> GraphflowmatchingPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn GraphflowmatchingPoint::mid(self : GraphflowmatchingPoint, other : GraphflowmatchingPoint) -> GraphflowmatchingPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn GraphflowmatchingPoint::lerp(self : GraphflowmatchingPoint, other : GraphflowmatchingPoint, t : Double) -> GraphflowmatchingPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn GraphflowmatchingPoint::to_string(self : GraphflowmatchingPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct GraphflowmatchingSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn graph_flow_matching_make_series(vals : Array[Double], name : String) -> GraphflowmatchingSeries {
  { vals, name, meta: 0 }
}

pub fn GraphflowmatchingSeries::len(self : GraphflowmatchingSeries) -> Int { self.vals.length() }

pub fn GraphflowmatchingSeries::sum(self : GraphflowmatchingSeries) -> Double { @_common.sum(self.vals) }

pub fn GraphflowmatchingSeries::mean(self : GraphflowmatchingSeries) -> Double { @_common.mean(self.vals) }

pub fn GraphflowmatchingSeries::min(self : GraphflowmatchingSeries) -> Double { @_common.min(self.vals) }

pub fn GraphflowmatchingSeries::max(self : GraphflowmatchingSeries) -> Double { @_common.max(self.vals) }

pub fn GraphflowmatchingSeries::range(self : GraphflowmatchingSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn GraphflowmatchingSeries::variance(self : GraphflowmatchingSeries) -> Double { @_common.variance(self.vals) }

pub fn GraphflowmatchingSeries::std(self : GraphflowmatchingSeries) -> Double { @_common.std(self.vals) }

pub fn GraphflowmatchingSeries::median(self : GraphflowmatchingSeries) -> Double { @_common.median(self.vals) }

pub fn GraphflowmatchingSeries::scale(self : GraphflowmatchingSeries, f : Double) -> GraphflowmatchingSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn GraphflowmatchingSeries::add(self : GraphflowmatchingSeries, other : GraphflowmatchingSeries) -> GraphflowmatchingSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn GraphflowmatchingSeries::sub(self : GraphflowmatchingSeries, other : GraphflowmatchingSeries) -> GraphflowmatchingSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn GraphflowmatchingSeries::normalize(self : GraphflowmatchingSeries) -> GraphflowmatchingSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn GraphflowmatchingSeries::cumsum(self : GraphflowmatchingSeries) -> GraphflowmatchingSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn GraphflowmatchingSeries::to_string(self : GraphflowmatchingSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct GraphflowmatchingMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn graph_flow_matching_make_matrix(rows : Int, cols : Int, val : Double) -> GraphflowmatchingMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn graph_flow_matching_matrix_identity(n : Int) -> GraphflowmatchingMatrix {
  let m = graph_flow_matching_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn GraphflowmatchingMatrix::get(self : GraphflowmatchingMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn GraphflowmatchingMatrix::transpose(self : GraphflowmatchingMatrix) -> GraphflowmatchingMatrix {
  let result = graph_flow_matching_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn GraphflowmatchingMatrix::add(self : GraphflowmatchingMatrix, other : GraphflowmatchingMatrix) -> GraphflowmatchingMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = graph_flow_matching_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn GraphflowmatchingMatrix::scale(self : GraphflowmatchingMatrix, s : Double) -> GraphflowmatchingMatrix {
  let result = graph_flow_matching_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn GraphflowmatchingMatrix::multiply(self : GraphflowmatchingMatrix, other : GraphflowmatchingMatrix) -> GraphflowmatchingMatrix {
  if self.cols != other.rows { return graph_flow_matching_make_matrix(self.rows, other.cols, 0.0) }
  let result = graph_flow_matching_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn GraphflowmatchingMatrix::trace(self : GraphflowmatchingMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn GraphflowmatchingMatrix::det(self : GraphflowmatchingMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn GraphflowmatchingMatrix::norm(self : GraphflowmatchingMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn GraphflowmatchingMatrix::to_string(self : GraphflowmatchingMatrix) -> String {
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

pub(all) struct GraphflowmatchingVector {
  comps : Array[Double]
  dim : Int
}

pub fn graph_flow_matching_make_vector(comps : Array[Double]) -> GraphflowmatchingVector {
  { comps, dim: comps.length() }
}

pub fn graph_flow_matching_vector_zero(dim : Int) -> GraphflowmatchingVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn GraphflowmatchingVector::add(self : GraphflowmatchingVector, other : GraphflowmatchingVector) -> GraphflowmatchingVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn GraphflowmatchingVector::sub(self : GraphflowmatchingVector, other : GraphflowmatchingVector) -> GraphflowmatchingVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn GraphflowmatchingVector::scale(self : GraphflowmatchingVector, s : Double) -> GraphflowmatchingVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn GraphflowmatchingVector::dot(self : GraphflowmatchingVector, other : GraphflowmatchingVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn GraphflowmatchingVector::norm(self : GraphflowmatchingVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn GraphflowmatchingVector::normalize(self : GraphflowmatchingVector) -> GraphflowmatchingVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn GraphflowmatchingVector::dist(self : GraphflowmatchingVector, other : GraphflowmatchingVector) -> Double {
  self.sub(other).norm()
}

pub fn GraphflowmatchingVector::to_string(self : GraphflowmatchingVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn graph_flow_matching_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn graph_flow_matching_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn graph_flow_matching_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn graph_flow_matching_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn graph_flow_matching_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn graph_flow_matching_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn graph_flow_matching_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn graph_flow_matching_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn graph_flow_matching_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn graph_flow_matching_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn graph_flow_matching_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn graph_flow_matching_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn graph_flow_matching_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn graph_flow_matching_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn graph_flow_matching_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn graph_flow_matching_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn graph_flow_matching_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn graph_flow_matching_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn graph_flow_matching_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn graph_flow_matching_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn graph_flow_matching_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn graph_flow_matching_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn graph_flow_matching_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn graph_flow_matching_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn graph_flow_matching_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn graph_flow_matching_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn graph_flow_matching_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn graph_flow_matching_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn graph_flow_matching_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct GraphflowmatchingFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_flow_matching_frame_make(size : Int) -> GraphflowmatchingFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_flow_matching_frame_len(s : GraphflowmatchingFrame) -> Int { s.size }

pub fn graph_flow_matching_frame_get(s : GraphflowmatchingFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_flow_matching_frame_set(s : GraphflowmatchingFrame, i : Int, v : Double) -> GraphflowmatchingFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_flow_matching_frame_sum(s : GraphflowmatchingFrame) -> Double { @_common.sum(s.data) }

pub fn graph_flow_matching_frame_mean(s : GraphflowmatchingFrame) -> Double { @_common.mean(s.data) }

pub fn graph_flow_matching_frame_scale(s : GraphflowmatchingFrame, f : Double) -> GraphflowmatchingFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_flow_matching_frame_add(a : GraphflowmatchingFrame, b : GraphflowmatchingFrame) -> GraphflowmatchingFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_flow_matching_frame_copy(s : GraphflowmatchingFrame) -> GraphflowmatchingFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_flow_matching_frame_fill(s : GraphflowmatchingFrame, v : Double) -> GraphflowmatchingFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_flow_matching_frame_min(s : GraphflowmatchingFrame) -> Double { @_common.min(s.data) }

pub fn graph_flow_matching_frame_max(s : GraphflowmatchingFrame) -> Double { @_common.max(s.data) }

pub fn graph_flow_matching_frame_to_string(s : GraphflowmatchingFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphflowmatchingTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_flow_matching_table_make(size : Int) -> GraphflowmatchingTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_flow_matching_table_len(s : GraphflowmatchingTable) -> Int { s.size }

pub fn graph_flow_matching_table_get(s : GraphflowmatchingTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_flow_matching_table_set(s : GraphflowmatchingTable, i : Int, v : Double) -> GraphflowmatchingTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_flow_matching_table_sum(s : GraphflowmatchingTable) -> Double { @_common.sum(s.data) }

pub fn graph_flow_matching_table_mean(s : GraphflowmatchingTable) -> Double { @_common.mean(s.data) }

pub fn graph_flow_matching_table_scale(s : GraphflowmatchingTable, f : Double) -> GraphflowmatchingTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_flow_matching_table_add(a : GraphflowmatchingTable, b : GraphflowmatchingTable) -> GraphflowmatchingTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_flow_matching_table_copy(s : GraphflowmatchingTable) -> GraphflowmatchingTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_flow_matching_table_fill(s : GraphflowmatchingTable, v : Double) -> GraphflowmatchingTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_flow_matching_table_min(s : GraphflowmatchingTable) -> Double { @_common.min(s.data) }

pub fn graph_flow_matching_table_max(s : GraphflowmatchingTable) -> Double { @_common.max(s.data) }

pub fn graph_flow_matching_table_to_string(s : GraphflowmatchingTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphflowmatchingGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_flow_matching_graphn_make(size : Int) -> GraphflowmatchingGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_flow_matching_graphn_len(s : GraphflowmatchingGraphN) -> Int { s.size }

pub fn graph_flow_matching_graphn_get(s : GraphflowmatchingGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_flow_matching_graphn_set(s : GraphflowmatchingGraphN, i : Int, v : Double) -> GraphflowmatchingGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_flow_matching_graphn_sum(s : GraphflowmatchingGraphN) -> Double { @_common.sum(s.data) }

pub fn graph_flow_matching_graphn_mean(s : GraphflowmatchingGraphN) -> Double { @_common.mean(s.data) }

pub fn graph_flow_matching_graphn_scale(s : GraphflowmatchingGraphN, f : Double) -> GraphflowmatchingGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_flow_matching_graphn_add(a : GraphflowmatchingGraphN, b : GraphflowmatchingGraphN) -> GraphflowmatchingGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_flow_matching_graphn_copy(s : GraphflowmatchingGraphN) -> GraphflowmatchingGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_flow_matching_graphn_fill(s : GraphflowmatchingGraphN, v : Double) -> GraphflowmatchingGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_flow_matching_graphn_min(s : GraphflowmatchingGraphN) -> Double { @_common.min(s.data) }

pub fn graph_flow_matching_graphn_max(s : GraphflowmatchingGraphN) -> Double { @_common.max(s.data) }

pub fn graph_flow_matching_graphn_to_string(s : GraphflowmatchingGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphflowmatchingNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_flow_matching_node_make(size : Int) -> GraphflowmatchingNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_flow_matching_node_len(s : GraphflowmatchingNode) -> Int { s.size }

pub fn graph_flow_matching_node_get(s : GraphflowmatchingNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_flow_matching_node_set(s : GraphflowmatchingNode, i : Int, v : Double) -> GraphflowmatchingNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_flow_matching_node_sum(s : GraphflowmatchingNode) -> Double { @_common.sum(s.data) }

pub fn graph_flow_matching_node_mean(s : GraphflowmatchingNode) -> Double { @_common.mean(s.data) }

pub fn graph_flow_matching_node_scale(s : GraphflowmatchingNode, f : Double) -> GraphflowmatchingNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_flow_matching_node_add(a : GraphflowmatchingNode, b : GraphflowmatchingNode) -> GraphflowmatchingNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_flow_matching_node_copy(s : GraphflowmatchingNode) -> GraphflowmatchingNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_flow_matching_node_fill(s : GraphflowmatchingNode, v : Double) -> GraphflowmatchingNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_flow_matching_node_min(s : GraphflowmatchingNode) -> Double { @_common.min(s.data) }

pub fn graph_flow_matching_node_max(s : GraphflowmatchingNode) -> Double { @_common.max(s.data) }

pub fn graph_flow_matching_node_to_string(s : GraphflowmatchingNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphflowmatchingEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_flow_matching_edge_make(size : Int) -> GraphflowmatchingEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_flow_matching_edge_len(s : GraphflowmatchingEdge) -> Int { s.size }

pub fn graph_flow_matching_edge_get(s : GraphflowmatchingEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_flow_matching_edge_set(s : GraphflowmatchingEdge, i : Int, v : Double) -> GraphflowmatchingEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_flow_matching_edge_sum(s : GraphflowmatchingEdge) -> Double { @_common.sum(s.data) }

pub fn graph_flow_matching_edge_mean(s : GraphflowmatchingEdge) -> Double { @_common.mean(s.data) }

pub fn graph_flow_matching_edge_scale(s : GraphflowmatchingEdge, f : Double) -> GraphflowmatchingEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_flow_matching_edge_add(a : GraphflowmatchingEdge, b : GraphflowmatchingEdge) -> GraphflowmatchingEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_flow_matching_edge_copy(s : GraphflowmatchingEdge) -> GraphflowmatchingEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_flow_matching_edge_fill(s : GraphflowmatchingEdge, v : Double) -> GraphflowmatchingEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_flow_matching_edge_min(s : GraphflowmatchingEdge) -> Double { @_common.min(s.data) }

pub fn graph_flow_matching_edge_max(s : GraphflowmatchingEdge) -> Double { @_common.max(s.data) }

pub fn graph_flow_matching_edge_to_string(s : GraphflowmatchingEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphflowmatchingPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_flow_matching_path_make(size : Int) -> GraphflowmatchingPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_flow_matching_path_len(s : GraphflowmatchingPath) -> Int { s.size }

pub fn graph_flow_matching_path_get(s : GraphflowmatchingPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_flow_matching_path_set(s : GraphflowmatchingPath, i : Int, v : Double) -> GraphflowmatchingPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_flow_matching_path_sum(s : GraphflowmatchingPath) -> Double { @_common.sum(s.data) }

pub fn graph_flow_matching_path_mean(s : GraphflowmatchingPath) -> Double { @_common.mean(s.data) }

pub fn graph_flow_matching_path_scale(s : GraphflowmatchingPath, f : Double) -> GraphflowmatchingPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_flow_matching_path_add(a : GraphflowmatchingPath, b : GraphflowmatchingPath) -> GraphflowmatchingPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_flow_matching_path_copy(s : GraphflowmatchingPath) -> GraphflowmatchingPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_flow_matching_path_fill(s : GraphflowmatchingPath, v : Double) -> GraphflowmatchingPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_flow_matching_path_min(s : GraphflowmatchingPath) -> Double { @_common.min(s.data) }

pub fn graph_flow_matching_path_max(s : GraphflowmatchingPath) -> Double { @_common.max(s.data) }

pub fn graph_flow_matching_path_to_string(s : GraphflowmatchingPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphflowmatchingCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_flow_matching_cluster_make(size : Int) -> GraphflowmatchingCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_flow_matching_cluster_len(s : GraphflowmatchingCluster) -> Int { s.size }

pub fn graph_flow_matching_cluster_get(s : GraphflowmatchingCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_flow_matching_cluster_set(s : GraphflowmatchingCluster, i : Int, v : Double) -> GraphflowmatchingCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_flow_matching_cluster_sum(s : GraphflowmatchingCluster) -> Double { @_common.sum(s.data) }

pub fn graph_flow_matching_cluster_mean(s : GraphflowmatchingCluster) -> Double { @_common.mean(s.data) }

pub fn graph_flow_matching_cluster_scale(s : GraphflowmatchingCluster, f : Double) -> GraphflowmatchingCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_flow_matching_cluster_add(a : GraphflowmatchingCluster, b : GraphflowmatchingCluster) -> GraphflowmatchingCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_flow_matching_cluster_copy(s : GraphflowmatchingCluster) -> GraphflowmatchingCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_flow_matching_cluster_fill(s : GraphflowmatchingCluster, v : Double) -> GraphflowmatchingCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_flow_matching_cluster_min(s : GraphflowmatchingCluster) -> Double { @_common.min(s.data) }

pub fn graph_flow_matching_cluster_max(s : GraphflowmatchingCluster) -> Double { @_common.max(s.data) }

pub fn graph_flow_matching_cluster_to_string(s : GraphflowmatchingCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphflowmatchingModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_flow_matching_model_make(size : Int) -> GraphflowmatchingModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_flow_matching_model_len(s : GraphflowmatchingModel) -> Int { s.size }

pub fn graph_flow_matching_model_get(s : GraphflowmatchingModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_flow_matching_model_set(s : GraphflowmatchingModel, i : Int, v : Double) -> GraphflowmatchingModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_flow_matching_model_sum(s : GraphflowmatchingModel) -> Double { @_common.sum(s.data) }

pub fn graph_flow_matching_model_mean(s : GraphflowmatchingModel) -> Double { @_common.mean(s.data) }

pub fn graph_flow_matching_model_scale(s : GraphflowmatchingModel, f : Double) -> GraphflowmatchingModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_flow_matching_model_add(a : GraphflowmatchingModel, b : GraphflowmatchingModel) -> GraphflowmatchingModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_flow_matching_model_copy(s : GraphflowmatchingModel) -> GraphflowmatchingModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_flow_matching_model_fill(s : GraphflowmatchingModel, v : Double) -> GraphflowmatchingModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_flow_matching_model_min(s : GraphflowmatchingModel) -> Double { @_common.min(s.data) }

pub fn graph_flow_matching_model_max(s : GraphflowmatchingModel) -> Double { @_common.max(s.data) }

pub fn graph_flow_matching_model_to_string(s : GraphflowmatchingModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphflowmatchingLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_flow_matching_layer_make(size : Int) -> GraphflowmatchingLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_flow_matching_layer_len(s : GraphflowmatchingLayer) -> Int { s.size }

pub fn graph_flow_matching_layer_get(s : GraphflowmatchingLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_flow_matching_layer_set(s : GraphflowmatchingLayer, i : Int, v : Double) -> GraphflowmatchingLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_flow_matching_layer_sum(s : GraphflowmatchingLayer) -> Double { @_common.sum(s.data) }

pub fn graph_flow_matching_layer_mean(s : GraphflowmatchingLayer) -> Double { @_common.mean(s.data) }

pub fn graph_flow_matching_layer_scale(s : GraphflowmatchingLayer, f : Double) -> GraphflowmatchingLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_flow_matching_layer_add(a : GraphflowmatchingLayer, b : GraphflowmatchingLayer) -> GraphflowmatchingLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_flow_matching_layer_copy(s : GraphflowmatchingLayer) -> GraphflowmatchingLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_flow_matching_layer_fill(s : GraphflowmatchingLayer, v : Double) -> GraphflowmatchingLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_flow_matching_layer_min(s : GraphflowmatchingLayer) -> Double { @_common.min(s.data) }

pub fn graph_flow_matching_layer_max(s : GraphflowmatchingLayer) -> Double { @_common.max(s.data) }

pub fn graph_flow_matching_layer_to_string(s : GraphflowmatchingLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphflowmatchingBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_flow_matching_buffer_make(size : Int) -> GraphflowmatchingBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_flow_matching_buffer_len(s : GraphflowmatchingBuffer) -> Int { s.size }

pub fn graph_flow_matching_buffer_get(s : GraphflowmatchingBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_flow_matching_buffer_set(s : GraphflowmatchingBuffer, i : Int, v : Double) -> GraphflowmatchingBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_flow_matching_buffer_sum(s : GraphflowmatchingBuffer) -> Double { @_common.sum(s.data) }

pub fn graph_flow_matching_buffer_mean(s : GraphflowmatchingBuffer) -> Double { @_common.mean(s.data) }

pub fn graph_flow_matching_buffer_scale(s : GraphflowmatchingBuffer, f : Double) -> GraphflowmatchingBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_flow_matching_buffer_add(a : GraphflowmatchingBuffer, b : GraphflowmatchingBuffer) -> GraphflowmatchingBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_flow_matching_buffer_copy(s : GraphflowmatchingBuffer) -> GraphflowmatchingBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_flow_matching_buffer_fill(s : GraphflowmatchingBuffer, v : Double) -> GraphflowmatchingBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_flow_matching_buffer_min(s : GraphflowmatchingBuffer) -> Double { @_common.min(s.data) }

pub fn graph_flow_matching_buffer_max(s : GraphflowmatchingBuffer) -> Double { @_common.max(s.data) }

pub fn graph_flow_matching_buffer_to_string(s : GraphflowmatchingBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphflowmatchingCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_flow_matching_cursor_make(size : Int) -> GraphflowmatchingCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_flow_matching_cursor_len(s : GraphflowmatchingCursor) -> Int { s.size }

pub fn graph_flow_matching_cursor_get(s : GraphflowmatchingCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_flow_matching_cursor_set(s : GraphflowmatchingCursor, i : Int, v : Double) -> GraphflowmatchingCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_flow_matching_cursor_sum(s : GraphflowmatchingCursor) -> Double { @_common.sum(s.data) }

pub fn graph_flow_matching_cursor_mean(s : GraphflowmatchingCursor) -> Double { @_common.mean(s.data) }

pub fn graph_flow_matching_cursor_scale(s : GraphflowmatchingCursor, f : Double) -> GraphflowmatchingCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_flow_matching_cursor_add(a : GraphflowmatchingCursor, b : GraphflowmatchingCursor) -> GraphflowmatchingCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_flow_matching_cursor_copy(s : GraphflowmatchingCursor) -> GraphflowmatchingCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_flow_matching_cursor_fill(s : GraphflowmatchingCursor, v : Double) -> GraphflowmatchingCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_flow_matching_cursor_min(s : GraphflowmatchingCursor) -> Double { @_common.min(s.data) }

pub fn graph_flow_matching_cursor_max(s : GraphflowmatchingCursor) -> Double { @_common.max(s.data) }

pub fn graph_flow_matching_cursor_to_string(s : GraphflowmatchingCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphflowmatchingView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_flow_matching_view_make(size : Int) -> GraphflowmatchingView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_flow_matching_view_len(s : GraphflowmatchingView) -> Int { s.size }

pub fn graph_flow_matching_view_get(s : GraphflowmatchingView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_flow_matching_view_set(s : GraphflowmatchingView, i : Int, v : Double) -> GraphflowmatchingView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_flow_matching_view_sum(s : GraphflowmatchingView) -> Double { @_common.sum(s.data) }

pub fn graph_flow_matching_view_mean(s : GraphflowmatchingView) -> Double { @_common.mean(s.data) }

pub fn graph_flow_matching_view_scale(s : GraphflowmatchingView, f : Double) -> GraphflowmatchingView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_flow_matching_view_add(a : GraphflowmatchingView, b : GraphflowmatchingView) -> GraphflowmatchingView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_flow_matching_view_copy(s : GraphflowmatchingView) -> GraphflowmatchingView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_flow_matching_view_fill(s : GraphflowmatchingView, v : Double) -> GraphflowmatchingView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_flow_matching_view_min(s : GraphflowmatchingView) -> Double { @_common.min(s.data) }

pub fn graph_flow_matching_view_max(s : GraphflowmatchingView) -> Double { @_common.max(s.data) }

pub fn graph_flow_matching_view_to_string(s : GraphflowmatchingView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphflowmatchingRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_flow_matching_range_make(size : Int) -> GraphflowmatchingRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_flow_matching_range_len(s : GraphflowmatchingRange) -> Int { s.size }

pub fn graph_flow_matching_range_get(s : GraphflowmatchingRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_flow_matching_range_set(s : GraphflowmatchingRange, i : Int, v : Double) -> GraphflowmatchingRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_flow_matching_range_sum(s : GraphflowmatchingRange) -> Double { @_common.sum(s.data) }

pub fn graph_flow_matching_range_mean(s : GraphflowmatchingRange) -> Double { @_common.mean(s.data) }

pub fn graph_flow_matching_range_scale(s : GraphflowmatchingRange, f : Double) -> GraphflowmatchingRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_flow_matching_range_add(a : GraphflowmatchingRange, b : GraphflowmatchingRange) -> GraphflowmatchingRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_flow_matching_range_copy(s : GraphflowmatchingRange) -> GraphflowmatchingRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_flow_matching_range_fill(s : GraphflowmatchingRange, v : Double) -> GraphflowmatchingRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_flow_matching_range_min(s : GraphflowmatchingRange) -> Double { @_common.min(s.data) }

pub fn graph_flow_matching_range_max(s : GraphflowmatchingRange) -> Double { @_common.max(s.data) }

pub fn graph_flow_matching_range_to_string(s : GraphflowmatchingRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphflowmatchingSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_flow_matching_slice_make(size : Int) -> GraphflowmatchingSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_flow_matching_slice_len(s : GraphflowmatchingSlice) -> Int { s.size }

pub fn graph_flow_matching_slice_get(s : GraphflowmatchingSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_flow_matching_slice_set(s : GraphflowmatchingSlice, i : Int, v : Double) -> GraphflowmatchingSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_flow_matching_slice_sum(s : GraphflowmatchingSlice) -> Double { @_common.sum(s.data) }

pub fn graph_flow_matching_slice_mean(s : GraphflowmatchingSlice) -> Double { @_common.mean(s.data) }

pub fn graph_flow_matching_slice_scale(s : GraphflowmatchingSlice, f : Double) -> GraphflowmatchingSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_flow_matching_slice_add(a : GraphflowmatchingSlice, b : GraphflowmatchingSlice) -> GraphflowmatchingSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_flow_matching_slice_copy(s : GraphflowmatchingSlice) -> GraphflowmatchingSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_flow_matching_slice_fill(s : GraphflowmatchingSlice, v : Double) -> GraphflowmatchingSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_flow_matching_slice_min(s : GraphflowmatchingSlice) -> Double { @_common.min(s.data) }

pub fn graph_flow_matching_slice_max(s : GraphflowmatchingSlice) -> Double { @_common.max(s.data) }

pub fn graph_flow_matching_slice_to_string(s : GraphflowmatchingSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

