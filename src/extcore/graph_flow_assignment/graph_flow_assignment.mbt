///===
/// extcore/graph_flow_assignment

pub(all) struct GraphflowassignmentPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn graph_flow_assignment_make_point(x : Double, y : Double) -> GraphflowassignmentPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn graph_flow_assignment_make_point3(x : Double, y : Double, z : Double) -> GraphflowassignmentPoint {
  { x, y, z, label: 0 }
}

pub fn GraphflowassignmentPoint::x(self : GraphflowassignmentPoint) -> Double { self.x }

pub fn GraphflowassignmentPoint::y(self : GraphflowassignmentPoint) -> Double { self.y }

pub fn GraphflowassignmentPoint::z(self : GraphflowassignmentPoint) -> Double { self.z }

pub fn GraphflowassignmentPoint::label(self : GraphflowassignmentPoint) -> Int { self.label }

pub fn GraphflowassignmentPoint::dist(self : GraphflowassignmentPoint, other : GraphflowassignmentPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn GraphflowassignmentPoint::add(self : GraphflowassignmentPoint, other : GraphflowassignmentPoint) -> GraphflowassignmentPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn GraphflowassignmentPoint::sub(self : GraphflowassignmentPoint, other : GraphflowassignmentPoint) -> GraphflowassignmentPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn GraphflowassignmentPoint::scale(self : GraphflowassignmentPoint, s : Double) -> GraphflowassignmentPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn GraphflowassignmentPoint::dot(self : GraphflowassignmentPoint, other : GraphflowassignmentPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn GraphflowassignmentPoint::cross(self : GraphflowassignmentPoint, other : GraphflowassignmentPoint) -> GraphflowassignmentPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn GraphflowassignmentPoint::norm(self : GraphflowassignmentPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn GraphflowassignmentPoint::normalize(self : GraphflowassignmentPoint) -> GraphflowassignmentPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn GraphflowassignmentPoint::negate(self : GraphflowassignmentPoint) -> GraphflowassignmentPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn GraphflowassignmentPoint::mid(self : GraphflowassignmentPoint, other : GraphflowassignmentPoint) -> GraphflowassignmentPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn GraphflowassignmentPoint::lerp(self : GraphflowassignmentPoint, other : GraphflowassignmentPoint, t : Double) -> GraphflowassignmentPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn GraphflowassignmentPoint::to_string(self : GraphflowassignmentPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct GraphflowassignmentSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn graph_flow_assignment_make_series(vals : Array[Double], name : String) -> GraphflowassignmentSeries {
  { vals, name, meta: 0 }
}

pub fn GraphflowassignmentSeries::len(self : GraphflowassignmentSeries) -> Int { self.vals.length() }

pub fn GraphflowassignmentSeries::sum(self : GraphflowassignmentSeries) -> Double { @_common.sum(self.vals) }

pub fn GraphflowassignmentSeries::mean(self : GraphflowassignmentSeries) -> Double { @_common.mean(self.vals) }

pub fn GraphflowassignmentSeries::min(self : GraphflowassignmentSeries) -> Double { @_common.min(self.vals) }

pub fn GraphflowassignmentSeries::max(self : GraphflowassignmentSeries) -> Double { @_common.max(self.vals) }

pub fn GraphflowassignmentSeries::range(self : GraphflowassignmentSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn GraphflowassignmentSeries::variance(self : GraphflowassignmentSeries) -> Double { @_common.variance(self.vals) }

pub fn GraphflowassignmentSeries::std(self : GraphflowassignmentSeries) -> Double { @_common.std(self.vals) }

pub fn GraphflowassignmentSeries::median(self : GraphflowassignmentSeries) -> Double { @_common.median(self.vals) }

pub fn GraphflowassignmentSeries::scale(self : GraphflowassignmentSeries, f : Double) -> GraphflowassignmentSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn GraphflowassignmentSeries::add(self : GraphflowassignmentSeries, other : GraphflowassignmentSeries) -> GraphflowassignmentSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn GraphflowassignmentSeries::sub(self : GraphflowassignmentSeries, other : GraphflowassignmentSeries) -> GraphflowassignmentSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn GraphflowassignmentSeries::normalize(self : GraphflowassignmentSeries) -> GraphflowassignmentSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn GraphflowassignmentSeries::cumsum(self : GraphflowassignmentSeries) -> GraphflowassignmentSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn GraphflowassignmentSeries::to_string(self : GraphflowassignmentSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct GraphflowassignmentMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn graph_flow_assignment_make_matrix(rows : Int, cols : Int, val : Double) -> GraphflowassignmentMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn graph_flow_assignment_matrix_identity(n : Int) -> GraphflowassignmentMatrix {
  let m = graph_flow_assignment_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn GraphflowassignmentMatrix::get(self : GraphflowassignmentMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn GraphflowassignmentMatrix::transpose(self : GraphflowassignmentMatrix) -> GraphflowassignmentMatrix {
  let result = graph_flow_assignment_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn GraphflowassignmentMatrix::add(self : GraphflowassignmentMatrix, other : GraphflowassignmentMatrix) -> GraphflowassignmentMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = graph_flow_assignment_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn GraphflowassignmentMatrix::scale(self : GraphflowassignmentMatrix, s : Double) -> GraphflowassignmentMatrix {
  let result = graph_flow_assignment_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn GraphflowassignmentMatrix::multiply(self : GraphflowassignmentMatrix, other : GraphflowassignmentMatrix) -> GraphflowassignmentMatrix {
  if self.cols != other.rows { return graph_flow_assignment_make_matrix(self.rows, other.cols, 0.0) }
  let result = graph_flow_assignment_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn GraphflowassignmentMatrix::trace(self : GraphflowassignmentMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn GraphflowassignmentMatrix::det(self : GraphflowassignmentMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn GraphflowassignmentMatrix::norm(self : GraphflowassignmentMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn GraphflowassignmentMatrix::to_string(self : GraphflowassignmentMatrix) -> String {
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

pub(all) struct GraphflowassignmentVector {
  comps : Array[Double]
  dim : Int
}

pub fn graph_flow_assignment_make_vector(comps : Array[Double]) -> GraphflowassignmentVector {
  { comps, dim: comps.length() }
}

pub fn graph_flow_assignment_vector_zero(dim : Int) -> GraphflowassignmentVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn GraphflowassignmentVector::add(self : GraphflowassignmentVector, other : GraphflowassignmentVector) -> GraphflowassignmentVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn GraphflowassignmentVector::sub(self : GraphflowassignmentVector, other : GraphflowassignmentVector) -> GraphflowassignmentVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn GraphflowassignmentVector::scale(self : GraphflowassignmentVector, s : Double) -> GraphflowassignmentVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn GraphflowassignmentVector::dot(self : GraphflowassignmentVector, other : GraphflowassignmentVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn GraphflowassignmentVector::norm(self : GraphflowassignmentVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn GraphflowassignmentVector::normalize(self : GraphflowassignmentVector) -> GraphflowassignmentVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn GraphflowassignmentVector::dist(self : GraphflowassignmentVector, other : GraphflowassignmentVector) -> Double {
  self.sub(other).norm()
}

pub fn GraphflowassignmentVector::to_string(self : GraphflowassignmentVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn graph_flow_assignment_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn graph_flow_assignment_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn graph_flow_assignment_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn graph_flow_assignment_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn graph_flow_assignment_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn graph_flow_assignment_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn graph_flow_assignment_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn graph_flow_assignment_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn graph_flow_assignment_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn graph_flow_assignment_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn graph_flow_assignment_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn graph_flow_assignment_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn graph_flow_assignment_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn graph_flow_assignment_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn graph_flow_assignment_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn graph_flow_assignment_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn graph_flow_assignment_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn graph_flow_assignment_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn graph_flow_assignment_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn graph_flow_assignment_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn graph_flow_assignment_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn graph_flow_assignment_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn graph_flow_assignment_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn graph_flow_assignment_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn graph_flow_assignment_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn graph_flow_assignment_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn graph_flow_assignment_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn graph_flow_assignment_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn graph_flow_assignment_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct GraphflowassignmentFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_flow_assignment_frame_make(size : Int) -> GraphflowassignmentFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_flow_assignment_frame_len(s : GraphflowassignmentFrame) -> Int { s.size }

pub fn graph_flow_assignment_frame_get(s : GraphflowassignmentFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_flow_assignment_frame_set(s : GraphflowassignmentFrame, i : Int, v : Double) -> GraphflowassignmentFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_flow_assignment_frame_sum(s : GraphflowassignmentFrame) -> Double { @_common.sum(s.data) }

pub fn graph_flow_assignment_frame_mean(s : GraphflowassignmentFrame) -> Double { @_common.mean(s.data) }

pub fn graph_flow_assignment_frame_scale(s : GraphflowassignmentFrame, f : Double) -> GraphflowassignmentFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_flow_assignment_frame_add(a : GraphflowassignmentFrame, b : GraphflowassignmentFrame) -> GraphflowassignmentFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_flow_assignment_frame_copy(s : GraphflowassignmentFrame) -> GraphflowassignmentFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_flow_assignment_frame_fill(s : GraphflowassignmentFrame, v : Double) -> GraphflowassignmentFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_flow_assignment_frame_min(s : GraphflowassignmentFrame) -> Double { @_common.min(s.data) }

pub fn graph_flow_assignment_frame_max(s : GraphflowassignmentFrame) -> Double { @_common.max(s.data) }

pub fn graph_flow_assignment_frame_to_string(s : GraphflowassignmentFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphflowassignmentTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_flow_assignment_table_make(size : Int) -> GraphflowassignmentTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_flow_assignment_table_len(s : GraphflowassignmentTable) -> Int { s.size }

pub fn graph_flow_assignment_table_get(s : GraphflowassignmentTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_flow_assignment_table_set(s : GraphflowassignmentTable, i : Int, v : Double) -> GraphflowassignmentTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_flow_assignment_table_sum(s : GraphflowassignmentTable) -> Double { @_common.sum(s.data) }

pub fn graph_flow_assignment_table_mean(s : GraphflowassignmentTable) -> Double { @_common.mean(s.data) }

pub fn graph_flow_assignment_table_scale(s : GraphflowassignmentTable, f : Double) -> GraphflowassignmentTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_flow_assignment_table_add(a : GraphflowassignmentTable, b : GraphflowassignmentTable) -> GraphflowassignmentTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_flow_assignment_table_copy(s : GraphflowassignmentTable) -> GraphflowassignmentTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_flow_assignment_table_fill(s : GraphflowassignmentTable, v : Double) -> GraphflowassignmentTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_flow_assignment_table_min(s : GraphflowassignmentTable) -> Double { @_common.min(s.data) }

pub fn graph_flow_assignment_table_max(s : GraphflowassignmentTable) -> Double { @_common.max(s.data) }

pub fn graph_flow_assignment_table_to_string(s : GraphflowassignmentTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphflowassignmentGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_flow_assignment_graphn_make(size : Int) -> GraphflowassignmentGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_flow_assignment_graphn_len(s : GraphflowassignmentGraphN) -> Int { s.size }

pub fn graph_flow_assignment_graphn_get(s : GraphflowassignmentGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_flow_assignment_graphn_set(s : GraphflowassignmentGraphN, i : Int, v : Double) -> GraphflowassignmentGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_flow_assignment_graphn_sum(s : GraphflowassignmentGraphN) -> Double { @_common.sum(s.data) }

pub fn graph_flow_assignment_graphn_mean(s : GraphflowassignmentGraphN) -> Double { @_common.mean(s.data) }

pub fn graph_flow_assignment_graphn_scale(s : GraphflowassignmentGraphN, f : Double) -> GraphflowassignmentGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_flow_assignment_graphn_add(a : GraphflowassignmentGraphN, b : GraphflowassignmentGraphN) -> GraphflowassignmentGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_flow_assignment_graphn_copy(s : GraphflowassignmentGraphN) -> GraphflowassignmentGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_flow_assignment_graphn_fill(s : GraphflowassignmentGraphN, v : Double) -> GraphflowassignmentGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_flow_assignment_graphn_min(s : GraphflowassignmentGraphN) -> Double { @_common.min(s.data) }

pub fn graph_flow_assignment_graphn_max(s : GraphflowassignmentGraphN) -> Double { @_common.max(s.data) }

pub fn graph_flow_assignment_graphn_to_string(s : GraphflowassignmentGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphflowassignmentNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_flow_assignment_node_make(size : Int) -> GraphflowassignmentNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_flow_assignment_node_len(s : GraphflowassignmentNode) -> Int { s.size }

pub fn graph_flow_assignment_node_get(s : GraphflowassignmentNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_flow_assignment_node_set(s : GraphflowassignmentNode, i : Int, v : Double) -> GraphflowassignmentNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_flow_assignment_node_sum(s : GraphflowassignmentNode) -> Double { @_common.sum(s.data) }

pub fn graph_flow_assignment_node_mean(s : GraphflowassignmentNode) -> Double { @_common.mean(s.data) }

pub fn graph_flow_assignment_node_scale(s : GraphflowassignmentNode, f : Double) -> GraphflowassignmentNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_flow_assignment_node_add(a : GraphflowassignmentNode, b : GraphflowassignmentNode) -> GraphflowassignmentNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_flow_assignment_node_copy(s : GraphflowassignmentNode) -> GraphflowassignmentNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_flow_assignment_node_fill(s : GraphflowassignmentNode, v : Double) -> GraphflowassignmentNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_flow_assignment_node_min(s : GraphflowassignmentNode) -> Double { @_common.min(s.data) }

pub fn graph_flow_assignment_node_max(s : GraphflowassignmentNode) -> Double { @_common.max(s.data) }

pub fn graph_flow_assignment_node_to_string(s : GraphflowassignmentNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphflowassignmentEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_flow_assignment_edge_make(size : Int) -> GraphflowassignmentEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_flow_assignment_edge_len(s : GraphflowassignmentEdge) -> Int { s.size }

pub fn graph_flow_assignment_edge_get(s : GraphflowassignmentEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_flow_assignment_edge_set(s : GraphflowassignmentEdge, i : Int, v : Double) -> GraphflowassignmentEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_flow_assignment_edge_sum(s : GraphflowassignmentEdge) -> Double { @_common.sum(s.data) }

pub fn graph_flow_assignment_edge_mean(s : GraphflowassignmentEdge) -> Double { @_common.mean(s.data) }

pub fn graph_flow_assignment_edge_scale(s : GraphflowassignmentEdge, f : Double) -> GraphflowassignmentEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_flow_assignment_edge_add(a : GraphflowassignmentEdge, b : GraphflowassignmentEdge) -> GraphflowassignmentEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_flow_assignment_edge_copy(s : GraphflowassignmentEdge) -> GraphflowassignmentEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_flow_assignment_edge_fill(s : GraphflowassignmentEdge, v : Double) -> GraphflowassignmentEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_flow_assignment_edge_min(s : GraphflowassignmentEdge) -> Double { @_common.min(s.data) }

pub fn graph_flow_assignment_edge_max(s : GraphflowassignmentEdge) -> Double { @_common.max(s.data) }

pub fn graph_flow_assignment_edge_to_string(s : GraphflowassignmentEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphflowassignmentPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_flow_assignment_path_make(size : Int) -> GraphflowassignmentPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_flow_assignment_path_len(s : GraphflowassignmentPath) -> Int { s.size }

pub fn graph_flow_assignment_path_get(s : GraphflowassignmentPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_flow_assignment_path_set(s : GraphflowassignmentPath, i : Int, v : Double) -> GraphflowassignmentPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_flow_assignment_path_sum(s : GraphflowassignmentPath) -> Double { @_common.sum(s.data) }

pub fn graph_flow_assignment_path_mean(s : GraphflowassignmentPath) -> Double { @_common.mean(s.data) }

pub fn graph_flow_assignment_path_scale(s : GraphflowassignmentPath, f : Double) -> GraphflowassignmentPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_flow_assignment_path_add(a : GraphflowassignmentPath, b : GraphflowassignmentPath) -> GraphflowassignmentPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_flow_assignment_path_copy(s : GraphflowassignmentPath) -> GraphflowassignmentPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_flow_assignment_path_fill(s : GraphflowassignmentPath, v : Double) -> GraphflowassignmentPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_flow_assignment_path_min(s : GraphflowassignmentPath) -> Double { @_common.min(s.data) }

pub fn graph_flow_assignment_path_max(s : GraphflowassignmentPath) -> Double { @_common.max(s.data) }

pub fn graph_flow_assignment_path_to_string(s : GraphflowassignmentPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphflowassignmentCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_flow_assignment_cluster_make(size : Int) -> GraphflowassignmentCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_flow_assignment_cluster_len(s : GraphflowassignmentCluster) -> Int { s.size }

pub fn graph_flow_assignment_cluster_get(s : GraphflowassignmentCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_flow_assignment_cluster_set(s : GraphflowassignmentCluster, i : Int, v : Double) -> GraphflowassignmentCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_flow_assignment_cluster_sum(s : GraphflowassignmentCluster) -> Double { @_common.sum(s.data) }

pub fn graph_flow_assignment_cluster_mean(s : GraphflowassignmentCluster) -> Double { @_common.mean(s.data) }

pub fn graph_flow_assignment_cluster_scale(s : GraphflowassignmentCluster, f : Double) -> GraphflowassignmentCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_flow_assignment_cluster_add(a : GraphflowassignmentCluster, b : GraphflowassignmentCluster) -> GraphflowassignmentCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_flow_assignment_cluster_copy(s : GraphflowassignmentCluster) -> GraphflowassignmentCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_flow_assignment_cluster_fill(s : GraphflowassignmentCluster, v : Double) -> GraphflowassignmentCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_flow_assignment_cluster_min(s : GraphflowassignmentCluster) -> Double { @_common.min(s.data) }

pub fn graph_flow_assignment_cluster_max(s : GraphflowassignmentCluster) -> Double { @_common.max(s.data) }

pub fn graph_flow_assignment_cluster_to_string(s : GraphflowassignmentCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphflowassignmentModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_flow_assignment_model_make(size : Int) -> GraphflowassignmentModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_flow_assignment_model_len(s : GraphflowassignmentModel) -> Int { s.size }

pub fn graph_flow_assignment_model_get(s : GraphflowassignmentModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_flow_assignment_model_set(s : GraphflowassignmentModel, i : Int, v : Double) -> GraphflowassignmentModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_flow_assignment_model_sum(s : GraphflowassignmentModel) -> Double { @_common.sum(s.data) }

pub fn graph_flow_assignment_model_mean(s : GraphflowassignmentModel) -> Double { @_common.mean(s.data) }

pub fn graph_flow_assignment_model_scale(s : GraphflowassignmentModel, f : Double) -> GraphflowassignmentModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_flow_assignment_model_add(a : GraphflowassignmentModel, b : GraphflowassignmentModel) -> GraphflowassignmentModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_flow_assignment_model_copy(s : GraphflowassignmentModel) -> GraphflowassignmentModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_flow_assignment_model_fill(s : GraphflowassignmentModel, v : Double) -> GraphflowassignmentModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_flow_assignment_model_min(s : GraphflowassignmentModel) -> Double { @_common.min(s.data) }

pub fn graph_flow_assignment_model_max(s : GraphflowassignmentModel) -> Double { @_common.max(s.data) }

pub fn graph_flow_assignment_model_to_string(s : GraphflowassignmentModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphflowassignmentLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_flow_assignment_layer_make(size : Int) -> GraphflowassignmentLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_flow_assignment_layer_len(s : GraphflowassignmentLayer) -> Int { s.size }

pub fn graph_flow_assignment_layer_get(s : GraphflowassignmentLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_flow_assignment_layer_set(s : GraphflowassignmentLayer, i : Int, v : Double) -> GraphflowassignmentLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_flow_assignment_layer_sum(s : GraphflowassignmentLayer) -> Double { @_common.sum(s.data) }

pub fn graph_flow_assignment_layer_mean(s : GraphflowassignmentLayer) -> Double { @_common.mean(s.data) }

pub fn graph_flow_assignment_layer_scale(s : GraphflowassignmentLayer, f : Double) -> GraphflowassignmentLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_flow_assignment_layer_add(a : GraphflowassignmentLayer, b : GraphflowassignmentLayer) -> GraphflowassignmentLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_flow_assignment_layer_copy(s : GraphflowassignmentLayer) -> GraphflowassignmentLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_flow_assignment_layer_fill(s : GraphflowassignmentLayer, v : Double) -> GraphflowassignmentLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_flow_assignment_layer_min(s : GraphflowassignmentLayer) -> Double { @_common.min(s.data) }

pub fn graph_flow_assignment_layer_max(s : GraphflowassignmentLayer) -> Double { @_common.max(s.data) }

pub fn graph_flow_assignment_layer_to_string(s : GraphflowassignmentLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphflowassignmentBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_flow_assignment_buffer_make(size : Int) -> GraphflowassignmentBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_flow_assignment_buffer_len(s : GraphflowassignmentBuffer) -> Int { s.size }

pub fn graph_flow_assignment_buffer_get(s : GraphflowassignmentBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_flow_assignment_buffer_set(s : GraphflowassignmentBuffer, i : Int, v : Double) -> GraphflowassignmentBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_flow_assignment_buffer_sum(s : GraphflowassignmentBuffer) -> Double { @_common.sum(s.data) }

pub fn graph_flow_assignment_buffer_mean(s : GraphflowassignmentBuffer) -> Double { @_common.mean(s.data) }

pub fn graph_flow_assignment_buffer_scale(s : GraphflowassignmentBuffer, f : Double) -> GraphflowassignmentBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_flow_assignment_buffer_add(a : GraphflowassignmentBuffer, b : GraphflowassignmentBuffer) -> GraphflowassignmentBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_flow_assignment_buffer_copy(s : GraphflowassignmentBuffer) -> GraphflowassignmentBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_flow_assignment_buffer_fill(s : GraphflowassignmentBuffer, v : Double) -> GraphflowassignmentBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_flow_assignment_buffer_min(s : GraphflowassignmentBuffer) -> Double { @_common.min(s.data) }

pub fn graph_flow_assignment_buffer_max(s : GraphflowassignmentBuffer) -> Double { @_common.max(s.data) }

pub fn graph_flow_assignment_buffer_to_string(s : GraphflowassignmentBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphflowassignmentCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_flow_assignment_cursor_make(size : Int) -> GraphflowassignmentCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_flow_assignment_cursor_len(s : GraphflowassignmentCursor) -> Int { s.size }

pub fn graph_flow_assignment_cursor_get(s : GraphflowassignmentCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_flow_assignment_cursor_set(s : GraphflowassignmentCursor, i : Int, v : Double) -> GraphflowassignmentCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_flow_assignment_cursor_sum(s : GraphflowassignmentCursor) -> Double { @_common.sum(s.data) }

pub fn graph_flow_assignment_cursor_mean(s : GraphflowassignmentCursor) -> Double { @_common.mean(s.data) }

pub fn graph_flow_assignment_cursor_scale(s : GraphflowassignmentCursor, f : Double) -> GraphflowassignmentCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_flow_assignment_cursor_add(a : GraphflowassignmentCursor, b : GraphflowassignmentCursor) -> GraphflowassignmentCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_flow_assignment_cursor_copy(s : GraphflowassignmentCursor) -> GraphflowassignmentCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_flow_assignment_cursor_fill(s : GraphflowassignmentCursor, v : Double) -> GraphflowassignmentCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_flow_assignment_cursor_min(s : GraphflowassignmentCursor) -> Double { @_common.min(s.data) }

pub fn graph_flow_assignment_cursor_max(s : GraphflowassignmentCursor) -> Double { @_common.max(s.data) }

pub fn graph_flow_assignment_cursor_to_string(s : GraphflowassignmentCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphflowassignmentView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_flow_assignment_view_make(size : Int) -> GraphflowassignmentView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_flow_assignment_view_len(s : GraphflowassignmentView) -> Int { s.size }

pub fn graph_flow_assignment_view_get(s : GraphflowassignmentView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_flow_assignment_view_set(s : GraphflowassignmentView, i : Int, v : Double) -> GraphflowassignmentView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_flow_assignment_view_sum(s : GraphflowassignmentView) -> Double { @_common.sum(s.data) }

pub fn graph_flow_assignment_view_mean(s : GraphflowassignmentView) -> Double { @_common.mean(s.data) }

pub fn graph_flow_assignment_view_scale(s : GraphflowassignmentView, f : Double) -> GraphflowassignmentView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_flow_assignment_view_add(a : GraphflowassignmentView, b : GraphflowassignmentView) -> GraphflowassignmentView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_flow_assignment_view_copy(s : GraphflowassignmentView) -> GraphflowassignmentView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_flow_assignment_view_fill(s : GraphflowassignmentView, v : Double) -> GraphflowassignmentView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_flow_assignment_view_min(s : GraphflowassignmentView) -> Double { @_common.min(s.data) }

pub fn graph_flow_assignment_view_max(s : GraphflowassignmentView) -> Double { @_common.max(s.data) }

pub fn graph_flow_assignment_view_to_string(s : GraphflowassignmentView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphflowassignmentRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_flow_assignment_range_make(size : Int) -> GraphflowassignmentRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_flow_assignment_range_len(s : GraphflowassignmentRange) -> Int { s.size }

pub fn graph_flow_assignment_range_get(s : GraphflowassignmentRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_flow_assignment_range_set(s : GraphflowassignmentRange, i : Int, v : Double) -> GraphflowassignmentRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_flow_assignment_range_sum(s : GraphflowassignmentRange) -> Double { @_common.sum(s.data) }

pub fn graph_flow_assignment_range_mean(s : GraphflowassignmentRange) -> Double { @_common.mean(s.data) }

pub fn graph_flow_assignment_range_scale(s : GraphflowassignmentRange, f : Double) -> GraphflowassignmentRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_flow_assignment_range_add(a : GraphflowassignmentRange, b : GraphflowassignmentRange) -> GraphflowassignmentRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_flow_assignment_range_copy(s : GraphflowassignmentRange) -> GraphflowassignmentRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_flow_assignment_range_fill(s : GraphflowassignmentRange, v : Double) -> GraphflowassignmentRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_flow_assignment_range_min(s : GraphflowassignmentRange) -> Double { @_common.min(s.data) }

pub fn graph_flow_assignment_range_max(s : GraphflowassignmentRange) -> Double { @_common.max(s.data) }

pub fn graph_flow_assignment_range_to_string(s : GraphflowassignmentRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphflowassignmentSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_flow_assignment_slice_make(size : Int) -> GraphflowassignmentSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_flow_assignment_slice_len(s : GraphflowassignmentSlice) -> Int { s.size }

pub fn graph_flow_assignment_slice_get(s : GraphflowassignmentSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_flow_assignment_slice_set(s : GraphflowassignmentSlice, i : Int, v : Double) -> GraphflowassignmentSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_flow_assignment_slice_sum(s : GraphflowassignmentSlice) -> Double { @_common.sum(s.data) }

pub fn graph_flow_assignment_slice_mean(s : GraphflowassignmentSlice) -> Double { @_common.mean(s.data) }

pub fn graph_flow_assignment_slice_scale(s : GraphflowassignmentSlice, f : Double) -> GraphflowassignmentSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_flow_assignment_slice_add(a : GraphflowassignmentSlice, b : GraphflowassignmentSlice) -> GraphflowassignmentSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_flow_assignment_slice_copy(s : GraphflowassignmentSlice) -> GraphflowassignmentSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_flow_assignment_slice_fill(s : GraphflowassignmentSlice, v : Double) -> GraphflowassignmentSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_flow_assignment_slice_min(s : GraphflowassignmentSlice) -> Double { @_common.min(s.data) }

pub fn graph_flow_assignment_slice_max(s : GraphflowassignmentSlice) -> Double { @_common.max(s.data) }

pub fn graph_flow_assignment_slice_to_string(s : GraphflowassignmentSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

