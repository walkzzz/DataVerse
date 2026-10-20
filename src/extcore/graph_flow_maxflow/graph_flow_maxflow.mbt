///===
/// extcore/graph_flow_maxflow

pub(all) struct GraphflowmaxflowPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn graph_flow_maxflow_make_point(x : Double, y : Double) -> GraphflowmaxflowPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn graph_flow_maxflow_make_point3(x : Double, y : Double, z : Double) -> GraphflowmaxflowPoint {
  { x, y, z, label: 0 }
}

pub fn GraphflowmaxflowPoint::x(self : GraphflowmaxflowPoint) -> Double { self.x }

pub fn GraphflowmaxflowPoint::y(self : GraphflowmaxflowPoint) -> Double { self.y }

pub fn GraphflowmaxflowPoint::z(self : GraphflowmaxflowPoint) -> Double { self.z }

pub fn GraphflowmaxflowPoint::label(self : GraphflowmaxflowPoint) -> Int { self.label }

pub fn GraphflowmaxflowPoint::dist(self : GraphflowmaxflowPoint, other : GraphflowmaxflowPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn GraphflowmaxflowPoint::add(self : GraphflowmaxflowPoint, other : GraphflowmaxflowPoint) -> GraphflowmaxflowPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn GraphflowmaxflowPoint::sub(self : GraphflowmaxflowPoint, other : GraphflowmaxflowPoint) -> GraphflowmaxflowPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn GraphflowmaxflowPoint::scale(self : GraphflowmaxflowPoint, s : Double) -> GraphflowmaxflowPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn GraphflowmaxflowPoint::dot(self : GraphflowmaxflowPoint, other : GraphflowmaxflowPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn GraphflowmaxflowPoint::cross(self : GraphflowmaxflowPoint, other : GraphflowmaxflowPoint) -> GraphflowmaxflowPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn GraphflowmaxflowPoint::norm(self : GraphflowmaxflowPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn GraphflowmaxflowPoint::normalize(self : GraphflowmaxflowPoint) -> GraphflowmaxflowPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn GraphflowmaxflowPoint::negate(self : GraphflowmaxflowPoint) -> GraphflowmaxflowPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn GraphflowmaxflowPoint::mid(self : GraphflowmaxflowPoint, other : GraphflowmaxflowPoint) -> GraphflowmaxflowPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn GraphflowmaxflowPoint::lerp(self : GraphflowmaxflowPoint, other : GraphflowmaxflowPoint, t : Double) -> GraphflowmaxflowPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn GraphflowmaxflowPoint::to_string(self : GraphflowmaxflowPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct GraphflowmaxflowSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn graph_flow_maxflow_make_series(vals : Array[Double], name : String) -> GraphflowmaxflowSeries {
  { vals, name, meta: 0 }
}

pub fn GraphflowmaxflowSeries::len(self : GraphflowmaxflowSeries) -> Int { self.vals.length() }

pub fn GraphflowmaxflowSeries::sum(self : GraphflowmaxflowSeries) -> Double { @_common.sum(self.vals) }

pub fn GraphflowmaxflowSeries::mean(self : GraphflowmaxflowSeries) -> Double { @_common.mean(self.vals) }

pub fn GraphflowmaxflowSeries::min(self : GraphflowmaxflowSeries) -> Double { @_common.min(self.vals) }

pub fn GraphflowmaxflowSeries::max(self : GraphflowmaxflowSeries) -> Double { @_common.max(self.vals) }

pub fn GraphflowmaxflowSeries::range(self : GraphflowmaxflowSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn GraphflowmaxflowSeries::variance(self : GraphflowmaxflowSeries) -> Double { @_common.variance(self.vals) }

pub fn GraphflowmaxflowSeries::std(self : GraphflowmaxflowSeries) -> Double { @_common.std(self.vals) }

pub fn GraphflowmaxflowSeries::median(self : GraphflowmaxflowSeries) -> Double { @_common.median(self.vals) }

pub fn GraphflowmaxflowSeries::scale(self : GraphflowmaxflowSeries, f : Double) -> GraphflowmaxflowSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn GraphflowmaxflowSeries::add(self : GraphflowmaxflowSeries, other : GraphflowmaxflowSeries) -> GraphflowmaxflowSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn GraphflowmaxflowSeries::sub(self : GraphflowmaxflowSeries, other : GraphflowmaxflowSeries) -> GraphflowmaxflowSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn GraphflowmaxflowSeries::normalize(self : GraphflowmaxflowSeries) -> GraphflowmaxflowSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn GraphflowmaxflowSeries::cumsum(self : GraphflowmaxflowSeries) -> GraphflowmaxflowSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn GraphflowmaxflowSeries::to_string(self : GraphflowmaxflowSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct GraphflowmaxflowMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn graph_flow_maxflow_make_matrix(rows : Int, cols : Int, val : Double) -> GraphflowmaxflowMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn graph_flow_maxflow_matrix_identity(n : Int) -> GraphflowmaxflowMatrix {
  let m = graph_flow_maxflow_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn GraphflowmaxflowMatrix::get(self : GraphflowmaxflowMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn GraphflowmaxflowMatrix::transpose(self : GraphflowmaxflowMatrix) -> GraphflowmaxflowMatrix {
  let result = graph_flow_maxflow_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn GraphflowmaxflowMatrix::add(self : GraphflowmaxflowMatrix, other : GraphflowmaxflowMatrix) -> GraphflowmaxflowMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = graph_flow_maxflow_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn GraphflowmaxflowMatrix::scale(self : GraphflowmaxflowMatrix, s : Double) -> GraphflowmaxflowMatrix {
  let result = graph_flow_maxflow_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn GraphflowmaxflowMatrix::multiply(self : GraphflowmaxflowMatrix, other : GraphflowmaxflowMatrix) -> GraphflowmaxflowMatrix {
  if self.cols != other.rows { return graph_flow_maxflow_make_matrix(self.rows, other.cols, 0.0) }
  let result = graph_flow_maxflow_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn GraphflowmaxflowMatrix::trace(self : GraphflowmaxflowMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn GraphflowmaxflowMatrix::det(self : GraphflowmaxflowMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn GraphflowmaxflowMatrix::norm(self : GraphflowmaxflowMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn GraphflowmaxflowMatrix::to_string(self : GraphflowmaxflowMatrix) -> String {
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

pub(all) struct GraphflowmaxflowVector {
  comps : Array[Double]
  dim : Int
}

pub fn graph_flow_maxflow_make_vector(comps : Array[Double]) -> GraphflowmaxflowVector {
  { comps, dim: comps.length() }
}

pub fn graph_flow_maxflow_vector_zero(dim : Int) -> GraphflowmaxflowVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn GraphflowmaxflowVector::add(self : GraphflowmaxflowVector, other : GraphflowmaxflowVector) -> GraphflowmaxflowVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn GraphflowmaxflowVector::sub(self : GraphflowmaxflowVector, other : GraphflowmaxflowVector) -> GraphflowmaxflowVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn GraphflowmaxflowVector::scale(self : GraphflowmaxflowVector, s : Double) -> GraphflowmaxflowVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn GraphflowmaxflowVector::dot(self : GraphflowmaxflowVector, other : GraphflowmaxflowVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn GraphflowmaxflowVector::norm(self : GraphflowmaxflowVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn GraphflowmaxflowVector::normalize(self : GraphflowmaxflowVector) -> GraphflowmaxflowVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn GraphflowmaxflowVector::dist(self : GraphflowmaxflowVector, other : GraphflowmaxflowVector) -> Double {
  self.sub(other).norm()
}

pub fn GraphflowmaxflowVector::to_string(self : GraphflowmaxflowVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn graph_flow_maxflow_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn graph_flow_maxflow_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn graph_flow_maxflow_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn graph_flow_maxflow_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn graph_flow_maxflow_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn graph_flow_maxflow_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn graph_flow_maxflow_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn graph_flow_maxflow_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn graph_flow_maxflow_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn graph_flow_maxflow_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn graph_flow_maxflow_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn graph_flow_maxflow_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn graph_flow_maxflow_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn graph_flow_maxflow_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn graph_flow_maxflow_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn graph_flow_maxflow_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn graph_flow_maxflow_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn graph_flow_maxflow_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn graph_flow_maxflow_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn graph_flow_maxflow_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn graph_flow_maxflow_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn graph_flow_maxflow_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn graph_flow_maxflow_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn graph_flow_maxflow_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn graph_flow_maxflow_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn graph_flow_maxflow_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn graph_flow_maxflow_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn graph_flow_maxflow_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn graph_flow_maxflow_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct GraphflowmaxflowFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_flow_maxflow_frame_make(size : Int) -> GraphflowmaxflowFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_flow_maxflow_frame_len(s : GraphflowmaxflowFrame) -> Int { s.size }

pub fn graph_flow_maxflow_frame_get(s : GraphflowmaxflowFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_flow_maxflow_frame_set(s : GraphflowmaxflowFrame, i : Int, v : Double) -> GraphflowmaxflowFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_flow_maxflow_frame_sum(s : GraphflowmaxflowFrame) -> Double { @_common.sum(s.data) }

pub fn graph_flow_maxflow_frame_mean(s : GraphflowmaxflowFrame) -> Double { @_common.mean(s.data) }

pub fn graph_flow_maxflow_frame_scale(s : GraphflowmaxflowFrame, f : Double) -> GraphflowmaxflowFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_flow_maxflow_frame_add(a : GraphflowmaxflowFrame, b : GraphflowmaxflowFrame) -> GraphflowmaxflowFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_flow_maxflow_frame_copy(s : GraphflowmaxflowFrame) -> GraphflowmaxflowFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_flow_maxflow_frame_fill(s : GraphflowmaxflowFrame, v : Double) -> GraphflowmaxflowFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_flow_maxflow_frame_min(s : GraphflowmaxflowFrame) -> Double { @_common.min(s.data) }

pub fn graph_flow_maxflow_frame_max(s : GraphflowmaxflowFrame) -> Double { @_common.max(s.data) }

pub fn graph_flow_maxflow_frame_to_string(s : GraphflowmaxflowFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphflowmaxflowTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_flow_maxflow_table_make(size : Int) -> GraphflowmaxflowTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_flow_maxflow_table_len(s : GraphflowmaxflowTable) -> Int { s.size }

pub fn graph_flow_maxflow_table_get(s : GraphflowmaxflowTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_flow_maxflow_table_set(s : GraphflowmaxflowTable, i : Int, v : Double) -> GraphflowmaxflowTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_flow_maxflow_table_sum(s : GraphflowmaxflowTable) -> Double { @_common.sum(s.data) }

pub fn graph_flow_maxflow_table_mean(s : GraphflowmaxflowTable) -> Double { @_common.mean(s.data) }

pub fn graph_flow_maxflow_table_scale(s : GraphflowmaxflowTable, f : Double) -> GraphflowmaxflowTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_flow_maxflow_table_add(a : GraphflowmaxflowTable, b : GraphflowmaxflowTable) -> GraphflowmaxflowTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_flow_maxflow_table_copy(s : GraphflowmaxflowTable) -> GraphflowmaxflowTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_flow_maxflow_table_fill(s : GraphflowmaxflowTable, v : Double) -> GraphflowmaxflowTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_flow_maxflow_table_min(s : GraphflowmaxflowTable) -> Double { @_common.min(s.data) }

pub fn graph_flow_maxflow_table_max(s : GraphflowmaxflowTable) -> Double { @_common.max(s.data) }

pub fn graph_flow_maxflow_table_to_string(s : GraphflowmaxflowTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphflowmaxflowGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_flow_maxflow_graphn_make(size : Int) -> GraphflowmaxflowGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_flow_maxflow_graphn_len(s : GraphflowmaxflowGraphN) -> Int { s.size }

pub fn graph_flow_maxflow_graphn_get(s : GraphflowmaxflowGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_flow_maxflow_graphn_set(s : GraphflowmaxflowGraphN, i : Int, v : Double) -> GraphflowmaxflowGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_flow_maxflow_graphn_sum(s : GraphflowmaxflowGraphN) -> Double { @_common.sum(s.data) }

pub fn graph_flow_maxflow_graphn_mean(s : GraphflowmaxflowGraphN) -> Double { @_common.mean(s.data) }

pub fn graph_flow_maxflow_graphn_scale(s : GraphflowmaxflowGraphN, f : Double) -> GraphflowmaxflowGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_flow_maxflow_graphn_add(a : GraphflowmaxflowGraphN, b : GraphflowmaxflowGraphN) -> GraphflowmaxflowGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_flow_maxflow_graphn_copy(s : GraphflowmaxflowGraphN) -> GraphflowmaxflowGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_flow_maxflow_graphn_fill(s : GraphflowmaxflowGraphN, v : Double) -> GraphflowmaxflowGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_flow_maxflow_graphn_min(s : GraphflowmaxflowGraphN) -> Double { @_common.min(s.data) }

pub fn graph_flow_maxflow_graphn_max(s : GraphflowmaxflowGraphN) -> Double { @_common.max(s.data) }

pub fn graph_flow_maxflow_graphn_to_string(s : GraphflowmaxflowGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphflowmaxflowNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_flow_maxflow_node_make(size : Int) -> GraphflowmaxflowNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_flow_maxflow_node_len(s : GraphflowmaxflowNode) -> Int { s.size }

pub fn graph_flow_maxflow_node_get(s : GraphflowmaxflowNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_flow_maxflow_node_set(s : GraphflowmaxflowNode, i : Int, v : Double) -> GraphflowmaxflowNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_flow_maxflow_node_sum(s : GraphflowmaxflowNode) -> Double { @_common.sum(s.data) }

pub fn graph_flow_maxflow_node_mean(s : GraphflowmaxflowNode) -> Double { @_common.mean(s.data) }

pub fn graph_flow_maxflow_node_scale(s : GraphflowmaxflowNode, f : Double) -> GraphflowmaxflowNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_flow_maxflow_node_add(a : GraphflowmaxflowNode, b : GraphflowmaxflowNode) -> GraphflowmaxflowNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_flow_maxflow_node_copy(s : GraphflowmaxflowNode) -> GraphflowmaxflowNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_flow_maxflow_node_fill(s : GraphflowmaxflowNode, v : Double) -> GraphflowmaxflowNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_flow_maxflow_node_min(s : GraphflowmaxflowNode) -> Double { @_common.min(s.data) }

pub fn graph_flow_maxflow_node_max(s : GraphflowmaxflowNode) -> Double { @_common.max(s.data) }

pub fn graph_flow_maxflow_node_to_string(s : GraphflowmaxflowNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphflowmaxflowEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_flow_maxflow_edge_make(size : Int) -> GraphflowmaxflowEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_flow_maxflow_edge_len(s : GraphflowmaxflowEdge) -> Int { s.size }

pub fn graph_flow_maxflow_edge_get(s : GraphflowmaxflowEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_flow_maxflow_edge_set(s : GraphflowmaxflowEdge, i : Int, v : Double) -> GraphflowmaxflowEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_flow_maxflow_edge_sum(s : GraphflowmaxflowEdge) -> Double { @_common.sum(s.data) }

pub fn graph_flow_maxflow_edge_mean(s : GraphflowmaxflowEdge) -> Double { @_common.mean(s.data) }

pub fn graph_flow_maxflow_edge_scale(s : GraphflowmaxflowEdge, f : Double) -> GraphflowmaxflowEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_flow_maxflow_edge_add(a : GraphflowmaxflowEdge, b : GraphflowmaxflowEdge) -> GraphflowmaxflowEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_flow_maxflow_edge_copy(s : GraphflowmaxflowEdge) -> GraphflowmaxflowEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_flow_maxflow_edge_fill(s : GraphflowmaxflowEdge, v : Double) -> GraphflowmaxflowEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_flow_maxflow_edge_min(s : GraphflowmaxflowEdge) -> Double { @_common.min(s.data) }

pub fn graph_flow_maxflow_edge_max(s : GraphflowmaxflowEdge) -> Double { @_common.max(s.data) }

pub fn graph_flow_maxflow_edge_to_string(s : GraphflowmaxflowEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphflowmaxflowPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_flow_maxflow_path_make(size : Int) -> GraphflowmaxflowPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_flow_maxflow_path_len(s : GraphflowmaxflowPath) -> Int { s.size }

pub fn graph_flow_maxflow_path_get(s : GraphflowmaxflowPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_flow_maxflow_path_set(s : GraphflowmaxflowPath, i : Int, v : Double) -> GraphflowmaxflowPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_flow_maxflow_path_sum(s : GraphflowmaxflowPath) -> Double { @_common.sum(s.data) }

pub fn graph_flow_maxflow_path_mean(s : GraphflowmaxflowPath) -> Double { @_common.mean(s.data) }

pub fn graph_flow_maxflow_path_scale(s : GraphflowmaxflowPath, f : Double) -> GraphflowmaxflowPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_flow_maxflow_path_add(a : GraphflowmaxflowPath, b : GraphflowmaxflowPath) -> GraphflowmaxflowPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_flow_maxflow_path_copy(s : GraphflowmaxflowPath) -> GraphflowmaxflowPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_flow_maxflow_path_fill(s : GraphflowmaxflowPath, v : Double) -> GraphflowmaxflowPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_flow_maxflow_path_min(s : GraphflowmaxflowPath) -> Double { @_common.min(s.data) }

pub fn graph_flow_maxflow_path_max(s : GraphflowmaxflowPath) -> Double { @_common.max(s.data) }

pub fn graph_flow_maxflow_path_to_string(s : GraphflowmaxflowPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphflowmaxflowCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_flow_maxflow_cluster_make(size : Int) -> GraphflowmaxflowCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_flow_maxflow_cluster_len(s : GraphflowmaxflowCluster) -> Int { s.size }

pub fn graph_flow_maxflow_cluster_get(s : GraphflowmaxflowCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_flow_maxflow_cluster_set(s : GraphflowmaxflowCluster, i : Int, v : Double) -> GraphflowmaxflowCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_flow_maxflow_cluster_sum(s : GraphflowmaxflowCluster) -> Double { @_common.sum(s.data) }

pub fn graph_flow_maxflow_cluster_mean(s : GraphflowmaxflowCluster) -> Double { @_common.mean(s.data) }

pub fn graph_flow_maxflow_cluster_scale(s : GraphflowmaxflowCluster, f : Double) -> GraphflowmaxflowCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_flow_maxflow_cluster_add(a : GraphflowmaxflowCluster, b : GraphflowmaxflowCluster) -> GraphflowmaxflowCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_flow_maxflow_cluster_copy(s : GraphflowmaxflowCluster) -> GraphflowmaxflowCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_flow_maxflow_cluster_fill(s : GraphflowmaxflowCluster, v : Double) -> GraphflowmaxflowCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_flow_maxflow_cluster_min(s : GraphflowmaxflowCluster) -> Double { @_common.min(s.data) }

pub fn graph_flow_maxflow_cluster_max(s : GraphflowmaxflowCluster) -> Double { @_common.max(s.data) }

pub fn graph_flow_maxflow_cluster_to_string(s : GraphflowmaxflowCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphflowmaxflowModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_flow_maxflow_model_make(size : Int) -> GraphflowmaxflowModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_flow_maxflow_model_len(s : GraphflowmaxflowModel) -> Int { s.size }

pub fn graph_flow_maxflow_model_get(s : GraphflowmaxflowModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_flow_maxflow_model_set(s : GraphflowmaxflowModel, i : Int, v : Double) -> GraphflowmaxflowModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_flow_maxflow_model_sum(s : GraphflowmaxflowModel) -> Double { @_common.sum(s.data) }

pub fn graph_flow_maxflow_model_mean(s : GraphflowmaxflowModel) -> Double { @_common.mean(s.data) }

pub fn graph_flow_maxflow_model_scale(s : GraphflowmaxflowModel, f : Double) -> GraphflowmaxflowModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_flow_maxflow_model_add(a : GraphflowmaxflowModel, b : GraphflowmaxflowModel) -> GraphflowmaxflowModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_flow_maxflow_model_copy(s : GraphflowmaxflowModel) -> GraphflowmaxflowModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_flow_maxflow_model_fill(s : GraphflowmaxflowModel, v : Double) -> GraphflowmaxflowModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_flow_maxflow_model_min(s : GraphflowmaxflowModel) -> Double { @_common.min(s.data) }

pub fn graph_flow_maxflow_model_max(s : GraphflowmaxflowModel) -> Double { @_common.max(s.data) }

pub fn graph_flow_maxflow_model_to_string(s : GraphflowmaxflowModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphflowmaxflowLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_flow_maxflow_layer_make(size : Int) -> GraphflowmaxflowLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_flow_maxflow_layer_len(s : GraphflowmaxflowLayer) -> Int { s.size }

pub fn graph_flow_maxflow_layer_get(s : GraphflowmaxflowLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_flow_maxflow_layer_set(s : GraphflowmaxflowLayer, i : Int, v : Double) -> GraphflowmaxflowLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_flow_maxflow_layer_sum(s : GraphflowmaxflowLayer) -> Double { @_common.sum(s.data) }

pub fn graph_flow_maxflow_layer_mean(s : GraphflowmaxflowLayer) -> Double { @_common.mean(s.data) }

pub fn graph_flow_maxflow_layer_scale(s : GraphflowmaxflowLayer, f : Double) -> GraphflowmaxflowLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_flow_maxflow_layer_add(a : GraphflowmaxflowLayer, b : GraphflowmaxflowLayer) -> GraphflowmaxflowLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_flow_maxflow_layer_copy(s : GraphflowmaxflowLayer) -> GraphflowmaxflowLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_flow_maxflow_layer_fill(s : GraphflowmaxflowLayer, v : Double) -> GraphflowmaxflowLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_flow_maxflow_layer_min(s : GraphflowmaxflowLayer) -> Double { @_common.min(s.data) }

pub fn graph_flow_maxflow_layer_max(s : GraphflowmaxflowLayer) -> Double { @_common.max(s.data) }

pub fn graph_flow_maxflow_layer_to_string(s : GraphflowmaxflowLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphflowmaxflowBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_flow_maxflow_buffer_make(size : Int) -> GraphflowmaxflowBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_flow_maxflow_buffer_len(s : GraphflowmaxflowBuffer) -> Int { s.size }

pub fn graph_flow_maxflow_buffer_get(s : GraphflowmaxflowBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_flow_maxflow_buffer_set(s : GraphflowmaxflowBuffer, i : Int, v : Double) -> GraphflowmaxflowBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_flow_maxflow_buffer_sum(s : GraphflowmaxflowBuffer) -> Double { @_common.sum(s.data) }

pub fn graph_flow_maxflow_buffer_mean(s : GraphflowmaxflowBuffer) -> Double { @_common.mean(s.data) }

pub fn graph_flow_maxflow_buffer_scale(s : GraphflowmaxflowBuffer, f : Double) -> GraphflowmaxflowBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_flow_maxflow_buffer_add(a : GraphflowmaxflowBuffer, b : GraphflowmaxflowBuffer) -> GraphflowmaxflowBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_flow_maxflow_buffer_copy(s : GraphflowmaxflowBuffer) -> GraphflowmaxflowBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_flow_maxflow_buffer_fill(s : GraphflowmaxflowBuffer, v : Double) -> GraphflowmaxflowBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_flow_maxflow_buffer_min(s : GraphflowmaxflowBuffer) -> Double { @_common.min(s.data) }

pub fn graph_flow_maxflow_buffer_max(s : GraphflowmaxflowBuffer) -> Double { @_common.max(s.data) }

pub fn graph_flow_maxflow_buffer_to_string(s : GraphflowmaxflowBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphflowmaxflowCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_flow_maxflow_cursor_make(size : Int) -> GraphflowmaxflowCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_flow_maxflow_cursor_len(s : GraphflowmaxflowCursor) -> Int { s.size }

pub fn graph_flow_maxflow_cursor_get(s : GraphflowmaxflowCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_flow_maxflow_cursor_set(s : GraphflowmaxflowCursor, i : Int, v : Double) -> GraphflowmaxflowCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_flow_maxflow_cursor_sum(s : GraphflowmaxflowCursor) -> Double { @_common.sum(s.data) }

pub fn graph_flow_maxflow_cursor_mean(s : GraphflowmaxflowCursor) -> Double { @_common.mean(s.data) }

pub fn graph_flow_maxflow_cursor_scale(s : GraphflowmaxflowCursor, f : Double) -> GraphflowmaxflowCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_flow_maxflow_cursor_add(a : GraphflowmaxflowCursor, b : GraphflowmaxflowCursor) -> GraphflowmaxflowCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_flow_maxflow_cursor_copy(s : GraphflowmaxflowCursor) -> GraphflowmaxflowCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_flow_maxflow_cursor_fill(s : GraphflowmaxflowCursor, v : Double) -> GraphflowmaxflowCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_flow_maxflow_cursor_min(s : GraphflowmaxflowCursor) -> Double { @_common.min(s.data) }

pub fn graph_flow_maxflow_cursor_max(s : GraphflowmaxflowCursor) -> Double { @_common.max(s.data) }

pub fn graph_flow_maxflow_cursor_to_string(s : GraphflowmaxflowCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphflowmaxflowView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_flow_maxflow_view_make(size : Int) -> GraphflowmaxflowView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_flow_maxflow_view_len(s : GraphflowmaxflowView) -> Int { s.size }

pub fn graph_flow_maxflow_view_get(s : GraphflowmaxflowView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_flow_maxflow_view_set(s : GraphflowmaxflowView, i : Int, v : Double) -> GraphflowmaxflowView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_flow_maxflow_view_sum(s : GraphflowmaxflowView) -> Double { @_common.sum(s.data) }

pub fn graph_flow_maxflow_view_mean(s : GraphflowmaxflowView) -> Double { @_common.mean(s.data) }

pub fn graph_flow_maxflow_view_scale(s : GraphflowmaxflowView, f : Double) -> GraphflowmaxflowView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_flow_maxflow_view_add(a : GraphflowmaxflowView, b : GraphflowmaxflowView) -> GraphflowmaxflowView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_flow_maxflow_view_copy(s : GraphflowmaxflowView) -> GraphflowmaxflowView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_flow_maxflow_view_fill(s : GraphflowmaxflowView, v : Double) -> GraphflowmaxflowView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_flow_maxflow_view_min(s : GraphflowmaxflowView) -> Double { @_common.min(s.data) }

pub fn graph_flow_maxflow_view_max(s : GraphflowmaxflowView) -> Double { @_common.max(s.data) }

pub fn graph_flow_maxflow_view_to_string(s : GraphflowmaxflowView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphflowmaxflowRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_flow_maxflow_range_make(size : Int) -> GraphflowmaxflowRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_flow_maxflow_range_len(s : GraphflowmaxflowRange) -> Int { s.size }

pub fn graph_flow_maxflow_range_get(s : GraphflowmaxflowRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_flow_maxflow_range_set(s : GraphflowmaxflowRange, i : Int, v : Double) -> GraphflowmaxflowRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_flow_maxflow_range_sum(s : GraphflowmaxflowRange) -> Double { @_common.sum(s.data) }

pub fn graph_flow_maxflow_range_mean(s : GraphflowmaxflowRange) -> Double { @_common.mean(s.data) }

pub fn graph_flow_maxflow_range_scale(s : GraphflowmaxflowRange, f : Double) -> GraphflowmaxflowRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_flow_maxflow_range_add(a : GraphflowmaxflowRange, b : GraphflowmaxflowRange) -> GraphflowmaxflowRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_flow_maxflow_range_copy(s : GraphflowmaxflowRange) -> GraphflowmaxflowRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_flow_maxflow_range_fill(s : GraphflowmaxflowRange, v : Double) -> GraphflowmaxflowRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_flow_maxflow_range_min(s : GraphflowmaxflowRange) -> Double { @_common.min(s.data) }

pub fn graph_flow_maxflow_range_max(s : GraphflowmaxflowRange) -> Double { @_common.max(s.data) }

pub fn graph_flow_maxflow_range_to_string(s : GraphflowmaxflowRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphflowmaxflowSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_flow_maxflow_slice_make(size : Int) -> GraphflowmaxflowSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_flow_maxflow_slice_len(s : GraphflowmaxflowSlice) -> Int { s.size }

pub fn graph_flow_maxflow_slice_get(s : GraphflowmaxflowSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_flow_maxflow_slice_set(s : GraphflowmaxflowSlice, i : Int, v : Double) -> GraphflowmaxflowSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_flow_maxflow_slice_sum(s : GraphflowmaxflowSlice) -> Double { @_common.sum(s.data) }

pub fn graph_flow_maxflow_slice_mean(s : GraphflowmaxflowSlice) -> Double { @_common.mean(s.data) }

pub fn graph_flow_maxflow_slice_scale(s : GraphflowmaxflowSlice, f : Double) -> GraphflowmaxflowSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_flow_maxflow_slice_add(a : GraphflowmaxflowSlice, b : GraphflowmaxflowSlice) -> GraphflowmaxflowSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_flow_maxflow_slice_copy(s : GraphflowmaxflowSlice) -> GraphflowmaxflowSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_flow_maxflow_slice_fill(s : GraphflowmaxflowSlice, v : Double) -> GraphflowmaxflowSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_flow_maxflow_slice_min(s : GraphflowmaxflowSlice) -> Double { @_common.min(s.data) }

pub fn graph_flow_maxflow_slice_max(s : GraphflowmaxflowSlice) -> Double { @_common.max(s.data) }

pub fn graph_flow_maxflow_slice_to_string(s : GraphflowmaxflowSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

