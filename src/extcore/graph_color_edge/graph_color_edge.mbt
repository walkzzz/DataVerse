///===
/// extcore/graph_color_edge

pub(all) struct GraphcoloredgePoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn graph_color_edge_make_point(x : Double, y : Double) -> GraphcoloredgePoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn graph_color_edge_make_point3(x : Double, y : Double, z : Double) -> GraphcoloredgePoint {
  { x, y, z, label: 0 }
}

pub fn GraphcoloredgePoint::x(self : GraphcoloredgePoint) -> Double { self.x }

pub fn GraphcoloredgePoint::y(self : GraphcoloredgePoint) -> Double { self.y }

pub fn GraphcoloredgePoint::z(self : GraphcoloredgePoint) -> Double { self.z }

pub fn GraphcoloredgePoint::label(self : GraphcoloredgePoint) -> Int { self.label }

pub fn GraphcoloredgePoint::dist(self : GraphcoloredgePoint, other : GraphcoloredgePoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn GraphcoloredgePoint::add(self : GraphcoloredgePoint, other : GraphcoloredgePoint) -> GraphcoloredgePoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn GraphcoloredgePoint::sub(self : GraphcoloredgePoint, other : GraphcoloredgePoint) -> GraphcoloredgePoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn GraphcoloredgePoint::scale(self : GraphcoloredgePoint, s : Double) -> GraphcoloredgePoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn GraphcoloredgePoint::dot(self : GraphcoloredgePoint, other : GraphcoloredgePoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn GraphcoloredgePoint::cross(self : GraphcoloredgePoint, other : GraphcoloredgePoint) -> GraphcoloredgePoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn GraphcoloredgePoint::norm(self : GraphcoloredgePoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn GraphcoloredgePoint::normalize(self : GraphcoloredgePoint) -> GraphcoloredgePoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn GraphcoloredgePoint::negate(self : GraphcoloredgePoint) -> GraphcoloredgePoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn GraphcoloredgePoint::mid(self : GraphcoloredgePoint, other : GraphcoloredgePoint) -> GraphcoloredgePoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn GraphcoloredgePoint::lerp(self : GraphcoloredgePoint, other : GraphcoloredgePoint, t : Double) -> GraphcoloredgePoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn GraphcoloredgePoint::to_string(self : GraphcoloredgePoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct GraphcoloredgeSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn graph_color_edge_make_series(vals : Array[Double], name : String) -> GraphcoloredgeSeries {
  { vals, name, meta: 0 }
}

pub fn GraphcoloredgeSeries::len(self : GraphcoloredgeSeries) -> Int { self.vals.length() }

pub fn GraphcoloredgeSeries::sum(self : GraphcoloredgeSeries) -> Double { @_common.sum(self.vals) }

pub fn GraphcoloredgeSeries::mean(self : GraphcoloredgeSeries) -> Double { @_common.mean(self.vals) }

pub fn GraphcoloredgeSeries::min(self : GraphcoloredgeSeries) -> Double { @_common.min(self.vals) }

pub fn GraphcoloredgeSeries::max(self : GraphcoloredgeSeries) -> Double { @_common.max(self.vals) }

pub fn GraphcoloredgeSeries::range(self : GraphcoloredgeSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn GraphcoloredgeSeries::variance(self : GraphcoloredgeSeries) -> Double { @_common.variance(self.vals) }

pub fn GraphcoloredgeSeries::std(self : GraphcoloredgeSeries) -> Double { @_common.std(self.vals) }

pub fn GraphcoloredgeSeries::median(self : GraphcoloredgeSeries) -> Double { @_common.median(self.vals) }

pub fn GraphcoloredgeSeries::scale(self : GraphcoloredgeSeries, f : Double) -> GraphcoloredgeSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn GraphcoloredgeSeries::add(self : GraphcoloredgeSeries, other : GraphcoloredgeSeries) -> GraphcoloredgeSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn GraphcoloredgeSeries::sub(self : GraphcoloredgeSeries, other : GraphcoloredgeSeries) -> GraphcoloredgeSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn GraphcoloredgeSeries::normalize(self : GraphcoloredgeSeries) -> GraphcoloredgeSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn GraphcoloredgeSeries::cumsum(self : GraphcoloredgeSeries) -> GraphcoloredgeSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn GraphcoloredgeSeries::to_string(self : GraphcoloredgeSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct GraphcoloredgeMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn graph_color_edge_make_matrix(rows : Int, cols : Int, val : Double) -> GraphcoloredgeMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn graph_color_edge_matrix_identity(n : Int) -> GraphcoloredgeMatrix {
  let m = graph_color_edge_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn GraphcoloredgeMatrix::get(self : GraphcoloredgeMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn GraphcoloredgeMatrix::transpose(self : GraphcoloredgeMatrix) -> GraphcoloredgeMatrix {
  let result = graph_color_edge_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn GraphcoloredgeMatrix::add(self : GraphcoloredgeMatrix, other : GraphcoloredgeMatrix) -> GraphcoloredgeMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = graph_color_edge_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn GraphcoloredgeMatrix::scale(self : GraphcoloredgeMatrix, s : Double) -> GraphcoloredgeMatrix {
  let result = graph_color_edge_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn GraphcoloredgeMatrix::multiply(self : GraphcoloredgeMatrix, other : GraphcoloredgeMatrix) -> GraphcoloredgeMatrix {
  if self.cols != other.rows { return graph_color_edge_make_matrix(self.rows, other.cols, 0.0) }
  let result = graph_color_edge_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn GraphcoloredgeMatrix::trace(self : GraphcoloredgeMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn GraphcoloredgeMatrix::det(self : GraphcoloredgeMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn GraphcoloredgeMatrix::norm(self : GraphcoloredgeMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn GraphcoloredgeMatrix::to_string(self : GraphcoloredgeMatrix) -> String {
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

pub(all) struct GraphcoloredgeVector {
  comps : Array[Double]
  dim : Int
}

pub fn graph_color_edge_make_vector(comps : Array[Double]) -> GraphcoloredgeVector {
  { comps, dim: comps.length() }
}

pub fn graph_color_edge_vector_zero(dim : Int) -> GraphcoloredgeVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn GraphcoloredgeVector::add(self : GraphcoloredgeVector, other : GraphcoloredgeVector) -> GraphcoloredgeVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn GraphcoloredgeVector::sub(self : GraphcoloredgeVector, other : GraphcoloredgeVector) -> GraphcoloredgeVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn GraphcoloredgeVector::scale(self : GraphcoloredgeVector, s : Double) -> GraphcoloredgeVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn GraphcoloredgeVector::dot(self : GraphcoloredgeVector, other : GraphcoloredgeVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn GraphcoloredgeVector::norm(self : GraphcoloredgeVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn GraphcoloredgeVector::normalize(self : GraphcoloredgeVector) -> GraphcoloredgeVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn GraphcoloredgeVector::dist(self : GraphcoloredgeVector, other : GraphcoloredgeVector) -> Double {
  self.sub(other).norm()
}

pub fn GraphcoloredgeVector::to_string(self : GraphcoloredgeVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn graph_color_edge_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn graph_color_edge_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn graph_color_edge_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn graph_color_edge_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn graph_color_edge_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn graph_color_edge_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn graph_color_edge_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn graph_color_edge_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn graph_color_edge_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn graph_color_edge_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn graph_color_edge_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn graph_color_edge_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn graph_color_edge_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn graph_color_edge_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn graph_color_edge_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn graph_color_edge_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn graph_color_edge_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn graph_color_edge_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn graph_color_edge_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn graph_color_edge_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn graph_color_edge_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn graph_color_edge_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn graph_color_edge_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn graph_color_edge_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn graph_color_edge_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn graph_color_edge_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn graph_color_edge_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn graph_color_edge_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn graph_color_edge_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct GraphcoloredgeFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_color_edge_frame_make(size : Int) -> GraphcoloredgeFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_color_edge_frame_len(s : GraphcoloredgeFrame) -> Int { s.size }

pub fn graph_color_edge_frame_get(s : GraphcoloredgeFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_color_edge_frame_set(s : GraphcoloredgeFrame, i : Int, v : Double) -> GraphcoloredgeFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_color_edge_frame_sum(s : GraphcoloredgeFrame) -> Double { @_common.sum(s.data) }

pub fn graph_color_edge_frame_mean(s : GraphcoloredgeFrame) -> Double { @_common.mean(s.data) }

pub fn graph_color_edge_frame_scale(s : GraphcoloredgeFrame, f : Double) -> GraphcoloredgeFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_color_edge_frame_add(a : GraphcoloredgeFrame, b : GraphcoloredgeFrame) -> GraphcoloredgeFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_color_edge_frame_copy(s : GraphcoloredgeFrame) -> GraphcoloredgeFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_color_edge_frame_fill(s : GraphcoloredgeFrame, v : Double) -> GraphcoloredgeFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_color_edge_frame_min(s : GraphcoloredgeFrame) -> Double { @_common.min(s.data) }

pub fn graph_color_edge_frame_max(s : GraphcoloredgeFrame) -> Double { @_common.max(s.data) }

pub fn graph_color_edge_frame_to_string(s : GraphcoloredgeFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphcoloredgeTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_color_edge_table_make(size : Int) -> GraphcoloredgeTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_color_edge_table_len(s : GraphcoloredgeTable) -> Int { s.size }

pub fn graph_color_edge_table_get(s : GraphcoloredgeTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_color_edge_table_set(s : GraphcoloredgeTable, i : Int, v : Double) -> GraphcoloredgeTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_color_edge_table_sum(s : GraphcoloredgeTable) -> Double { @_common.sum(s.data) }

pub fn graph_color_edge_table_mean(s : GraphcoloredgeTable) -> Double { @_common.mean(s.data) }

pub fn graph_color_edge_table_scale(s : GraphcoloredgeTable, f : Double) -> GraphcoloredgeTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_color_edge_table_add(a : GraphcoloredgeTable, b : GraphcoloredgeTable) -> GraphcoloredgeTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_color_edge_table_copy(s : GraphcoloredgeTable) -> GraphcoloredgeTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_color_edge_table_fill(s : GraphcoloredgeTable, v : Double) -> GraphcoloredgeTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_color_edge_table_min(s : GraphcoloredgeTable) -> Double { @_common.min(s.data) }

pub fn graph_color_edge_table_max(s : GraphcoloredgeTable) -> Double { @_common.max(s.data) }

pub fn graph_color_edge_table_to_string(s : GraphcoloredgeTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphcoloredgeGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_color_edge_graphn_make(size : Int) -> GraphcoloredgeGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_color_edge_graphn_len(s : GraphcoloredgeGraphN) -> Int { s.size }

pub fn graph_color_edge_graphn_get(s : GraphcoloredgeGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_color_edge_graphn_set(s : GraphcoloredgeGraphN, i : Int, v : Double) -> GraphcoloredgeGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_color_edge_graphn_sum(s : GraphcoloredgeGraphN) -> Double { @_common.sum(s.data) }

pub fn graph_color_edge_graphn_mean(s : GraphcoloredgeGraphN) -> Double { @_common.mean(s.data) }

pub fn graph_color_edge_graphn_scale(s : GraphcoloredgeGraphN, f : Double) -> GraphcoloredgeGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_color_edge_graphn_add(a : GraphcoloredgeGraphN, b : GraphcoloredgeGraphN) -> GraphcoloredgeGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_color_edge_graphn_copy(s : GraphcoloredgeGraphN) -> GraphcoloredgeGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_color_edge_graphn_fill(s : GraphcoloredgeGraphN, v : Double) -> GraphcoloredgeGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_color_edge_graphn_min(s : GraphcoloredgeGraphN) -> Double { @_common.min(s.data) }

pub fn graph_color_edge_graphn_max(s : GraphcoloredgeGraphN) -> Double { @_common.max(s.data) }

pub fn graph_color_edge_graphn_to_string(s : GraphcoloredgeGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphcoloredgeNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_color_edge_node_make(size : Int) -> GraphcoloredgeNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_color_edge_node_len(s : GraphcoloredgeNode) -> Int { s.size }

pub fn graph_color_edge_node_get(s : GraphcoloredgeNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_color_edge_node_set(s : GraphcoloredgeNode, i : Int, v : Double) -> GraphcoloredgeNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_color_edge_node_sum(s : GraphcoloredgeNode) -> Double { @_common.sum(s.data) }

pub fn graph_color_edge_node_mean(s : GraphcoloredgeNode) -> Double { @_common.mean(s.data) }

pub fn graph_color_edge_node_scale(s : GraphcoloredgeNode, f : Double) -> GraphcoloredgeNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_color_edge_node_add(a : GraphcoloredgeNode, b : GraphcoloredgeNode) -> GraphcoloredgeNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_color_edge_node_copy(s : GraphcoloredgeNode) -> GraphcoloredgeNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_color_edge_node_fill(s : GraphcoloredgeNode, v : Double) -> GraphcoloredgeNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_color_edge_node_min(s : GraphcoloredgeNode) -> Double { @_common.min(s.data) }

pub fn graph_color_edge_node_max(s : GraphcoloredgeNode) -> Double { @_common.max(s.data) }

pub fn graph_color_edge_node_to_string(s : GraphcoloredgeNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphcoloredgeEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_color_edge_edge_make(size : Int) -> GraphcoloredgeEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_color_edge_edge_len(s : GraphcoloredgeEdge) -> Int { s.size }

pub fn graph_color_edge_edge_get(s : GraphcoloredgeEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_color_edge_edge_set(s : GraphcoloredgeEdge, i : Int, v : Double) -> GraphcoloredgeEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_color_edge_edge_sum(s : GraphcoloredgeEdge) -> Double { @_common.sum(s.data) }

pub fn graph_color_edge_edge_mean(s : GraphcoloredgeEdge) -> Double { @_common.mean(s.data) }

pub fn graph_color_edge_edge_scale(s : GraphcoloredgeEdge, f : Double) -> GraphcoloredgeEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_color_edge_edge_add(a : GraphcoloredgeEdge, b : GraphcoloredgeEdge) -> GraphcoloredgeEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_color_edge_edge_copy(s : GraphcoloredgeEdge) -> GraphcoloredgeEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_color_edge_edge_fill(s : GraphcoloredgeEdge, v : Double) -> GraphcoloredgeEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_color_edge_edge_min(s : GraphcoloredgeEdge) -> Double { @_common.min(s.data) }

pub fn graph_color_edge_edge_max(s : GraphcoloredgeEdge) -> Double { @_common.max(s.data) }

pub fn graph_color_edge_edge_to_string(s : GraphcoloredgeEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphcoloredgePath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_color_edge_path_make(size : Int) -> GraphcoloredgePath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_color_edge_path_len(s : GraphcoloredgePath) -> Int { s.size }

pub fn graph_color_edge_path_get(s : GraphcoloredgePath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_color_edge_path_set(s : GraphcoloredgePath, i : Int, v : Double) -> GraphcoloredgePath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_color_edge_path_sum(s : GraphcoloredgePath) -> Double { @_common.sum(s.data) }

pub fn graph_color_edge_path_mean(s : GraphcoloredgePath) -> Double { @_common.mean(s.data) }

pub fn graph_color_edge_path_scale(s : GraphcoloredgePath, f : Double) -> GraphcoloredgePath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_color_edge_path_add(a : GraphcoloredgePath, b : GraphcoloredgePath) -> GraphcoloredgePath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_color_edge_path_copy(s : GraphcoloredgePath) -> GraphcoloredgePath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_color_edge_path_fill(s : GraphcoloredgePath, v : Double) -> GraphcoloredgePath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_color_edge_path_min(s : GraphcoloredgePath) -> Double { @_common.min(s.data) }

pub fn graph_color_edge_path_max(s : GraphcoloredgePath) -> Double { @_common.max(s.data) }

pub fn graph_color_edge_path_to_string(s : GraphcoloredgePath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphcoloredgeCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_color_edge_cluster_make(size : Int) -> GraphcoloredgeCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_color_edge_cluster_len(s : GraphcoloredgeCluster) -> Int { s.size }

pub fn graph_color_edge_cluster_get(s : GraphcoloredgeCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_color_edge_cluster_set(s : GraphcoloredgeCluster, i : Int, v : Double) -> GraphcoloredgeCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_color_edge_cluster_sum(s : GraphcoloredgeCluster) -> Double { @_common.sum(s.data) }

pub fn graph_color_edge_cluster_mean(s : GraphcoloredgeCluster) -> Double { @_common.mean(s.data) }

pub fn graph_color_edge_cluster_scale(s : GraphcoloredgeCluster, f : Double) -> GraphcoloredgeCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_color_edge_cluster_add(a : GraphcoloredgeCluster, b : GraphcoloredgeCluster) -> GraphcoloredgeCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_color_edge_cluster_copy(s : GraphcoloredgeCluster) -> GraphcoloredgeCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_color_edge_cluster_fill(s : GraphcoloredgeCluster, v : Double) -> GraphcoloredgeCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_color_edge_cluster_min(s : GraphcoloredgeCluster) -> Double { @_common.min(s.data) }

pub fn graph_color_edge_cluster_max(s : GraphcoloredgeCluster) -> Double { @_common.max(s.data) }

pub fn graph_color_edge_cluster_to_string(s : GraphcoloredgeCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphcoloredgeModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_color_edge_model_make(size : Int) -> GraphcoloredgeModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_color_edge_model_len(s : GraphcoloredgeModel) -> Int { s.size }

pub fn graph_color_edge_model_get(s : GraphcoloredgeModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_color_edge_model_set(s : GraphcoloredgeModel, i : Int, v : Double) -> GraphcoloredgeModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_color_edge_model_sum(s : GraphcoloredgeModel) -> Double { @_common.sum(s.data) }

pub fn graph_color_edge_model_mean(s : GraphcoloredgeModel) -> Double { @_common.mean(s.data) }

pub fn graph_color_edge_model_scale(s : GraphcoloredgeModel, f : Double) -> GraphcoloredgeModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_color_edge_model_add(a : GraphcoloredgeModel, b : GraphcoloredgeModel) -> GraphcoloredgeModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_color_edge_model_copy(s : GraphcoloredgeModel) -> GraphcoloredgeModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_color_edge_model_fill(s : GraphcoloredgeModel, v : Double) -> GraphcoloredgeModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_color_edge_model_min(s : GraphcoloredgeModel) -> Double { @_common.min(s.data) }

pub fn graph_color_edge_model_max(s : GraphcoloredgeModel) -> Double { @_common.max(s.data) }

pub fn graph_color_edge_model_to_string(s : GraphcoloredgeModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphcoloredgeLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_color_edge_layer_make(size : Int) -> GraphcoloredgeLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_color_edge_layer_len(s : GraphcoloredgeLayer) -> Int { s.size }

pub fn graph_color_edge_layer_get(s : GraphcoloredgeLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_color_edge_layer_set(s : GraphcoloredgeLayer, i : Int, v : Double) -> GraphcoloredgeLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_color_edge_layer_sum(s : GraphcoloredgeLayer) -> Double { @_common.sum(s.data) }

pub fn graph_color_edge_layer_mean(s : GraphcoloredgeLayer) -> Double { @_common.mean(s.data) }

pub fn graph_color_edge_layer_scale(s : GraphcoloredgeLayer, f : Double) -> GraphcoloredgeLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_color_edge_layer_add(a : GraphcoloredgeLayer, b : GraphcoloredgeLayer) -> GraphcoloredgeLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_color_edge_layer_copy(s : GraphcoloredgeLayer) -> GraphcoloredgeLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_color_edge_layer_fill(s : GraphcoloredgeLayer, v : Double) -> GraphcoloredgeLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_color_edge_layer_min(s : GraphcoloredgeLayer) -> Double { @_common.min(s.data) }

pub fn graph_color_edge_layer_max(s : GraphcoloredgeLayer) -> Double { @_common.max(s.data) }

pub fn graph_color_edge_layer_to_string(s : GraphcoloredgeLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphcoloredgeBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_color_edge_buffer_make(size : Int) -> GraphcoloredgeBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_color_edge_buffer_len(s : GraphcoloredgeBuffer) -> Int { s.size }

pub fn graph_color_edge_buffer_get(s : GraphcoloredgeBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_color_edge_buffer_set(s : GraphcoloredgeBuffer, i : Int, v : Double) -> GraphcoloredgeBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_color_edge_buffer_sum(s : GraphcoloredgeBuffer) -> Double { @_common.sum(s.data) }

pub fn graph_color_edge_buffer_mean(s : GraphcoloredgeBuffer) -> Double { @_common.mean(s.data) }

pub fn graph_color_edge_buffer_scale(s : GraphcoloredgeBuffer, f : Double) -> GraphcoloredgeBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_color_edge_buffer_add(a : GraphcoloredgeBuffer, b : GraphcoloredgeBuffer) -> GraphcoloredgeBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_color_edge_buffer_copy(s : GraphcoloredgeBuffer) -> GraphcoloredgeBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_color_edge_buffer_fill(s : GraphcoloredgeBuffer, v : Double) -> GraphcoloredgeBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_color_edge_buffer_min(s : GraphcoloredgeBuffer) -> Double { @_common.min(s.data) }

pub fn graph_color_edge_buffer_max(s : GraphcoloredgeBuffer) -> Double { @_common.max(s.data) }

pub fn graph_color_edge_buffer_to_string(s : GraphcoloredgeBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphcoloredgeCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_color_edge_cursor_make(size : Int) -> GraphcoloredgeCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_color_edge_cursor_len(s : GraphcoloredgeCursor) -> Int { s.size }

pub fn graph_color_edge_cursor_get(s : GraphcoloredgeCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_color_edge_cursor_set(s : GraphcoloredgeCursor, i : Int, v : Double) -> GraphcoloredgeCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_color_edge_cursor_sum(s : GraphcoloredgeCursor) -> Double { @_common.sum(s.data) }

pub fn graph_color_edge_cursor_mean(s : GraphcoloredgeCursor) -> Double { @_common.mean(s.data) }

pub fn graph_color_edge_cursor_scale(s : GraphcoloredgeCursor, f : Double) -> GraphcoloredgeCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_color_edge_cursor_add(a : GraphcoloredgeCursor, b : GraphcoloredgeCursor) -> GraphcoloredgeCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_color_edge_cursor_copy(s : GraphcoloredgeCursor) -> GraphcoloredgeCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_color_edge_cursor_fill(s : GraphcoloredgeCursor, v : Double) -> GraphcoloredgeCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_color_edge_cursor_min(s : GraphcoloredgeCursor) -> Double { @_common.min(s.data) }

pub fn graph_color_edge_cursor_max(s : GraphcoloredgeCursor) -> Double { @_common.max(s.data) }

pub fn graph_color_edge_cursor_to_string(s : GraphcoloredgeCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphcoloredgeView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_color_edge_view_make(size : Int) -> GraphcoloredgeView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_color_edge_view_len(s : GraphcoloredgeView) -> Int { s.size }

pub fn graph_color_edge_view_get(s : GraphcoloredgeView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_color_edge_view_set(s : GraphcoloredgeView, i : Int, v : Double) -> GraphcoloredgeView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_color_edge_view_sum(s : GraphcoloredgeView) -> Double { @_common.sum(s.data) }

pub fn graph_color_edge_view_mean(s : GraphcoloredgeView) -> Double { @_common.mean(s.data) }

pub fn graph_color_edge_view_scale(s : GraphcoloredgeView, f : Double) -> GraphcoloredgeView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_color_edge_view_add(a : GraphcoloredgeView, b : GraphcoloredgeView) -> GraphcoloredgeView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_color_edge_view_copy(s : GraphcoloredgeView) -> GraphcoloredgeView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_color_edge_view_fill(s : GraphcoloredgeView, v : Double) -> GraphcoloredgeView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_color_edge_view_min(s : GraphcoloredgeView) -> Double { @_common.min(s.data) }

pub fn graph_color_edge_view_max(s : GraphcoloredgeView) -> Double { @_common.max(s.data) }

pub fn graph_color_edge_view_to_string(s : GraphcoloredgeView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphcoloredgeRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_color_edge_range_make(size : Int) -> GraphcoloredgeRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_color_edge_range_len(s : GraphcoloredgeRange) -> Int { s.size }

pub fn graph_color_edge_range_get(s : GraphcoloredgeRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_color_edge_range_set(s : GraphcoloredgeRange, i : Int, v : Double) -> GraphcoloredgeRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_color_edge_range_sum(s : GraphcoloredgeRange) -> Double { @_common.sum(s.data) }

pub fn graph_color_edge_range_mean(s : GraphcoloredgeRange) -> Double { @_common.mean(s.data) }

pub fn graph_color_edge_range_scale(s : GraphcoloredgeRange, f : Double) -> GraphcoloredgeRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_color_edge_range_add(a : GraphcoloredgeRange, b : GraphcoloredgeRange) -> GraphcoloredgeRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_color_edge_range_copy(s : GraphcoloredgeRange) -> GraphcoloredgeRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_color_edge_range_fill(s : GraphcoloredgeRange, v : Double) -> GraphcoloredgeRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_color_edge_range_min(s : GraphcoloredgeRange) -> Double { @_common.min(s.data) }

pub fn graph_color_edge_range_max(s : GraphcoloredgeRange) -> Double { @_common.max(s.data) }

pub fn graph_color_edge_range_to_string(s : GraphcoloredgeRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphcoloredgeSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_color_edge_slice_make(size : Int) -> GraphcoloredgeSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_color_edge_slice_len(s : GraphcoloredgeSlice) -> Int { s.size }

pub fn graph_color_edge_slice_get(s : GraphcoloredgeSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_color_edge_slice_set(s : GraphcoloredgeSlice, i : Int, v : Double) -> GraphcoloredgeSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_color_edge_slice_sum(s : GraphcoloredgeSlice) -> Double { @_common.sum(s.data) }

pub fn graph_color_edge_slice_mean(s : GraphcoloredgeSlice) -> Double { @_common.mean(s.data) }

pub fn graph_color_edge_slice_scale(s : GraphcoloredgeSlice, f : Double) -> GraphcoloredgeSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_color_edge_slice_add(a : GraphcoloredgeSlice, b : GraphcoloredgeSlice) -> GraphcoloredgeSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_color_edge_slice_copy(s : GraphcoloredgeSlice) -> GraphcoloredgeSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_color_edge_slice_fill(s : GraphcoloredgeSlice, v : Double) -> GraphcoloredgeSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_color_edge_slice_min(s : GraphcoloredgeSlice) -> Double { @_common.min(s.data) }

pub fn graph_color_edge_slice_max(s : GraphcoloredgeSlice) -> Double { @_common.max(s.data) }

pub fn graph_color_edge_slice_to_string(s : GraphcoloredgeSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

