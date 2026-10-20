///===
/// extcore/graph_search_bellman

pub(all) struct GraphsearchbellmanPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn graph_search_bellman_make_point(x : Double, y : Double) -> GraphsearchbellmanPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn graph_search_bellman_make_point3(x : Double, y : Double, z : Double) -> GraphsearchbellmanPoint {
  { x, y, z, label: 0 }
}

pub fn GraphsearchbellmanPoint::x(self : GraphsearchbellmanPoint) -> Double { self.x }

pub fn GraphsearchbellmanPoint::y(self : GraphsearchbellmanPoint) -> Double { self.y }

pub fn GraphsearchbellmanPoint::z(self : GraphsearchbellmanPoint) -> Double { self.z }

pub fn GraphsearchbellmanPoint::label(self : GraphsearchbellmanPoint) -> Int { self.label }

pub fn GraphsearchbellmanPoint::dist(self : GraphsearchbellmanPoint, other : GraphsearchbellmanPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn GraphsearchbellmanPoint::add(self : GraphsearchbellmanPoint, other : GraphsearchbellmanPoint) -> GraphsearchbellmanPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn GraphsearchbellmanPoint::sub(self : GraphsearchbellmanPoint, other : GraphsearchbellmanPoint) -> GraphsearchbellmanPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn GraphsearchbellmanPoint::scale(self : GraphsearchbellmanPoint, s : Double) -> GraphsearchbellmanPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn GraphsearchbellmanPoint::dot(self : GraphsearchbellmanPoint, other : GraphsearchbellmanPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn GraphsearchbellmanPoint::cross(self : GraphsearchbellmanPoint, other : GraphsearchbellmanPoint) -> GraphsearchbellmanPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn GraphsearchbellmanPoint::norm(self : GraphsearchbellmanPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn GraphsearchbellmanPoint::normalize(self : GraphsearchbellmanPoint) -> GraphsearchbellmanPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn GraphsearchbellmanPoint::negate(self : GraphsearchbellmanPoint) -> GraphsearchbellmanPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn GraphsearchbellmanPoint::mid(self : GraphsearchbellmanPoint, other : GraphsearchbellmanPoint) -> GraphsearchbellmanPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn GraphsearchbellmanPoint::lerp(self : GraphsearchbellmanPoint, other : GraphsearchbellmanPoint, t : Double) -> GraphsearchbellmanPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn GraphsearchbellmanPoint::to_string(self : GraphsearchbellmanPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct GraphsearchbellmanSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn graph_search_bellman_make_series(vals : Array[Double], name : String) -> GraphsearchbellmanSeries {
  { vals, name, meta: 0 }
}

pub fn GraphsearchbellmanSeries::len(self : GraphsearchbellmanSeries) -> Int { self.vals.length() }

pub fn GraphsearchbellmanSeries::sum(self : GraphsearchbellmanSeries) -> Double { @_common.sum(self.vals) }

pub fn GraphsearchbellmanSeries::mean(self : GraphsearchbellmanSeries) -> Double { @_common.mean(self.vals) }

pub fn GraphsearchbellmanSeries::min(self : GraphsearchbellmanSeries) -> Double { @_common.min(self.vals) }

pub fn GraphsearchbellmanSeries::max(self : GraphsearchbellmanSeries) -> Double { @_common.max(self.vals) }

pub fn GraphsearchbellmanSeries::range(self : GraphsearchbellmanSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn GraphsearchbellmanSeries::variance(self : GraphsearchbellmanSeries) -> Double { @_common.variance(self.vals) }

pub fn GraphsearchbellmanSeries::std(self : GraphsearchbellmanSeries) -> Double { @_common.std(self.vals) }

pub fn GraphsearchbellmanSeries::median(self : GraphsearchbellmanSeries) -> Double { @_common.median(self.vals) }

pub fn GraphsearchbellmanSeries::scale(self : GraphsearchbellmanSeries, f : Double) -> GraphsearchbellmanSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn GraphsearchbellmanSeries::add(self : GraphsearchbellmanSeries, other : GraphsearchbellmanSeries) -> GraphsearchbellmanSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn GraphsearchbellmanSeries::sub(self : GraphsearchbellmanSeries, other : GraphsearchbellmanSeries) -> GraphsearchbellmanSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn GraphsearchbellmanSeries::normalize(self : GraphsearchbellmanSeries) -> GraphsearchbellmanSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn GraphsearchbellmanSeries::cumsum(self : GraphsearchbellmanSeries) -> GraphsearchbellmanSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn GraphsearchbellmanSeries::to_string(self : GraphsearchbellmanSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct GraphsearchbellmanMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn graph_search_bellman_make_matrix(rows : Int, cols : Int, val : Double) -> GraphsearchbellmanMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn graph_search_bellman_matrix_identity(n : Int) -> GraphsearchbellmanMatrix {
  let m = graph_search_bellman_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn GraphsearchbellmanMatrix::get(self : GraphsearchbellmanMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn GraphsearchbellmanMatrix::transpose(self : GraphsearchbellmanMatrix) -> GraphsearchbellmanMatrix {
  let result = graph_search_bellman_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn GraphsearchbellmanMatrix::add(self : GraphsearchbellmanMatrix, other : GraphsearchbellmanMatrix) -> GraphsearchbellmanMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = graph_search_bellman_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn GraphsearchbellmanMatrix::scale(self : GraphsearchbellmanMatrix, s : Double) -> GraphsearchbellmanMatrix {
  let result = graph_search_bellman_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn GraphsearchbellmanMatrix::multiply(self : GraphsearchbellmanMatrix, other : GraphsearchbellmanMatrix) -> GraphsearchbellmanMatrix {
  if self.cols != other.rows { return graph_search_bellman_make_matrix(self.rows, other.cols, 0.0) }
  let result = graph_search_bellman_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn GraphsearchbellmanMatrix::trace(self : GraphsearchbellmanMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn GraphsearchbellmanMatrix::det(self : GraphsearchbellmanMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn GraphsearchbellmanMatrix::norm(self : GraphsearchbellmanMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn GraphsearchbellmanMatrix::to_string(self : GraphsearchbellmanMatrix) -> String {
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

pub(all) struct GraphsearchbellmanVector {
  comps : Array[Double]
  dim : Int
}

pub fn graph_search_bellman_make_vector(comps : Array[Double]) -> GraphsearchbellmanVector {
  { comps, dim: comps.length() }
}

pub fn graph_search_bellman_vector_zero(dim : Int) -> GraphsearchbellmanVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn GraphsearchbellmanVector::add(self : GraphsearchbellmanVector, other : GraphsearchbellmanVector) -> GraphsearchbellmanVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn GraphsearchbellmanVector::sub(self : GraphsearchbellmanVector, other : GraphsearchbellmanVector) -> GraphsearchbellmanVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn GraphsearchbellmanVector::scale(self : GraphsearchbellmanVector, s : Double) -> GraphsearchbellmanVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn GraphsearchbellmanVector::dot(self : GraphsearchbellmanVector, other : GraphsearchbellmanVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn GraphsearchbellmanVector::norm(self : GraphsearchbellmanVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn GraphsearchbellmanVector::normalize(self : GraphsearchbellmanVector) -> GraphsearchbellmanVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn GraphsearchbellmanVector::dist(self : GraphsearchbellmanVector, other : GraphsearchbellmanVector) -> Double {
  self.sub(other).norm()
}

pub fn GraphsearchbellmanVector::to_string(self : GraphsearchbellmanVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn graph_search_bellman_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn graph_search_bellman_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn graph_search_bellman_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn graph_search_bellman_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn graph_search_bellman_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn graph_search_bellman_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn graph_search_bellman_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn graph_search_bellman_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn graph_search_bellman_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn graph_search_bellman_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn graph_search_bellman_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn graph_search_bellman_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn graph_search_bellman_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn graph_search_bellman_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn graph_search_bellman_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn graph_search_bellman_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn graph_search_bellman_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn graph_search_bellman_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn graph_search_bellman_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn graph_search_bellman_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn graph_search_bellman_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn graph_search_bellman_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn graph_search_bellman_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn graph_search_bellman_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn graph_search_bellman_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn graph_search_bellman_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn graph_search_bellman_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn graph_search_bellman_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn graph_search_bellman_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct GraphsearchbellmanFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_search_bellman_frame_make(size : Int) -> GraphsearchbellmanFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_search_bellman_frame_len(s : GraphsearchbellmanFrame) -> Int { s.size }

pub fn graph_search_bellman_frame_get(s : GraphsearchbellmanFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_search_bellman_frame_set(s : GraphsearchbellmanFrame, i : Int, v : Double) -> GraphsearchbellmanFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_search_bellman_frame_sum(s : GraphsearchbellmanFrame) -> Double { @_common.sum(s.data) }

pub fn graph_search_bellman_frame_mean(s : GraphsearchbellmanFrame) -> Double { @_common.mean(s.data) }

pub fn graph_search_bellman_frame_scale(s : GraphsearchbellmanFrame, f : Double) -> GraphsearchbellmanFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_search_bellman_frame_add(a : GraphsearchbellmanFrame, b : GraphsearchbellmanFrame) -> GraphsearchbellmanFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_search_bellman_frame_copy(s : GraphsearchbellmanFrame) -> GraphsearchbellmanFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_search_bellman_frame_fill(s : GraphsearchbellmanFrame, v : Double) -> GraphsearchbellmanFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_search_bellman_frame_min(s : GraphsearchbellmanFrame) -> Double { @_common.min(s.data) }

pub fn graph_search_bellman_frame_max(s : GraphsearchbellmanFrame) -> Double { @_common.max(s.data) }

pub fn graph_search_bellman_frame_to_string(s : GraphsearchbellmanFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphsearchbellmanTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_search_bellman_table_make(size : Int) -> GraphsearchbellmanTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_search_bellman_table_len(s : GraphsearchbellmanTable) -> Int { s.size }

pub fn graph_search_bellman_table_get(s : GraphsearchbellmanTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_search_bellman_table_set(s : GraphsearchbellmanTable, i : Int, v : Double) -> GraphsearchbellmanTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_search_bellman_table_sum(s : GraphsearchbellmanTable) -> Double { @_common.sum(s.data) }

pub fn graph_search_bellman_table_mean(s : GraphsearchbellmanTable) -> Double { @_common.mean(s.data) }

pub fn graph_search_bellman_table_scale(s : GraphsearchbellmanTable, f : Double) -> GraphsearchbellmanTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_search_bellman_table_add(a : GraphsearchbellmanTable, b : GraphsearchbellmanTable) -> GraphsearchbellmanTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_search_bellman_table_copy(s : GraphsearchbellmanTable) -> GraphsearchbellmanTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_search_bellman_table_fill(s : GraphsearchbellmanTable, v : Double) -> GraphsearchbellmanTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_search_bellman_table_min(s : GraphsearchbellmanTable) -> Double { @_common.min(s.data) }

pub fn graph_search_bellman_table_max(s : GraphsearchbellmanTable) -> Double { @_common.max(s.data) }

pub fn graph_search_bellman_table_to_string(s : GraphsearchbellmanTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphsearchbellmanGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_search_bellman_graphn_make(size : Int) -> GraphsearchbellmanGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_search_bellman_graphn_len(s : GraphsearchbellmanGraphN) -> Int { s.size }

pub fn graph_search_bellman_graphn_get(s : GraphsearchbellmanGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_search_bellman_graphn_set(s : GraphsearchbellmanGraphN, i : Int, v : Double) -> GraphsearchbellmanGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_search_bellman_graphn_sum(s : GraphsearchbellmanGraphN) -> Double { @_common.sum(s.data) }

pub fn graph_search_bellman_graphn_mean(s : GraphsearchbellmanGraphN) -> Double { @_common.mean(s.data) }

pub fn graph_search_bellman_graphn_scale(s : GraphsearchbellmanGraphN, f : Double) -> GraphsearchbellmanGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_search_bellman_graphn_add(a : GraphsearchbellmanGraphN, b : GraphsearchbellmanGraphN) -> GraphsearchbellmanGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_search_bellman_graphn_copy(s : GraphsearchbellmanGraphN) -> GraphsearchbellmanGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_search_bellman_graphn_fill(s : GraphsearchbellmanGraphN, v : Double) -> GraphsearchbellmanGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_search_bellman_graphn_min(s : GraphsearchbellmanGraphN) -> Double { @_common.min(s.data) }

pub fn graph_search_bellman_graphn_max(s : GraphsearchbellmanGraphN) -> Double { @_common.max(s.data) }

pub fn graph_search_bellman_graphn_to_string(s : GraphsearchbellmanGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphsearchbellmanNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_search_bellman_node_make(size : Int) -> GraphsearchbellmanNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_search_bellman_node_len(s : GraphsearchbellmanNode) -> Int { s.size }

pub fn graph_search_bellman_node_get(s : GraphsearchbellmanNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_search_bellman_node_set(s : GraphsearchbellmanNode, i : Int, v : Double) -> GraphsearchbellmanNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_search_bellman_node_sum(s : GraphsearchbellmanNode) -> Double { @_common.sum(s.data) }

pub fn graph_search_bellman_node_mean(s : GraphsearchbellmanNode) -> Double { @_common.mean(s.data) }

pub fn graph_search_bellman_node_scale(s : GraphsearchbellmanNode, f : Double) -> GraphsearchbellmanNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_search_bellman_node_add(a : GraphsearchbellmanNode, b : GraphsearchbellmanNode) -> GraphsearchbellmanNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_search_bellman_node_copy(s : GraphsearchbellmanNode) -> GraphsearchbellmanNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_search_bellman_node_fill(s : GraphsearchbellmanNode, v : Double) -> GraphsearchbellmanNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_search_bellman_node_min(s : GraphsearchbellmanNode) -> Double { @_common.min(s.data) }

pub fn graph_search_bellman_node_max(s : GraphsearchbellmanNode) -> Double { @_common.max(s.data) }

pub fn graph_search_bellman_node_to_string(s : GraphsearchbellmanNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphsearchbellmanEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_search_bellman_edge_make(size : Int) -> GraphsearchbellmanEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_search_bellman_edge_len(s : GraphsearchbellmanEdge) -> Int { s.size }

pub fn graph_search_bellman_edge_get(s : GraphsearchbellmanEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_search_bellman_edge_set(s : GraphsearchbellmanEdge, i : Int, v : Double) -> GraphsearchbellmanEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_search_bellman_edge_sum(s : GraphsearchbellmanEdge) -> Double { @_common.sum(s.data) }

pub fn graph_search_bellman_edge_mean(s : GraphsearchbellmanEdge) -> Double { @_common.mean(s.data) }

pub fn graph_search_bellman_edge_scale(s : GraphsearchbellmanEdge, f : Double) -> GraphsearchbellmanEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_search_bellman_edge_add(a : GraphsearchbellmanEdge, b : GraphsearchbellmanEdge) -> GraphsearchbellmanEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_search_bellman_edge_copy(s : GraphsearchbellmanEdge) -> GraphsearchbellmanEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_search_bellman_edge_fill(s : GraphsearchbellmanEdge, v : Double) -> GraphsearchbellmanEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_search_bellman_edge_min(s : GraphsearchbellmanEdge) -> Double { @_common.min(s.data) }

pub fn graph_search_bellman_edge_max(s : GraphsearchbellmanEdge) -> Double { @_common.max(s.data) }

pub fn graph_search_bellman_edge_to_string(s : GraphsearchbellmanEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphsearchbellmanPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_search_bellman_path_make(size : Int) -> GraphsearchbellmanPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_search_bellman_path_len(s : GraphsearchbellmanPath) -> Int { s.size }

pub fn graph_search_bellman_path_get(s : GraphsearchbellmanPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_search_bellman_path_set(s : GraphsearchbellmanPath, i : Int, v : Double) -> GraphsearchbellmanPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_search_bellman_path_sum(s : GraphsearchbellmanPath) -> Double { @_common.sum(s.data) }

pub fn graph_search_bellman_path_mean(s : GraphsearchbellmanPath) -> Double { @_common.mean(s.data) }

pub fn graph_search_bellman_path_scale(s : GraphsearchbellmanPath, f : Double) -> GraphsearchbellmanPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_search_bellman_path_add(a : GraphsearchbellmanPath, b : GraphsearchbellmanPath) -> GraphsearchbellmanPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_search_bellman_path_copy(s : GraphsearchbellmanPath) -> GraphsearchbellmanPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_search_bellman_path_fill(s : GraphsearchbellmanPath, v : Double) -> GraphsearchbellmanPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_search_bellman_path_min(s : GraphsearchbellmanPath) -> Double { @_common.min(s.data) }

pub fn graph_search_bellman_path_max(s : GraphsearchbellmanPath) -> Double { @_common.max(s.data) }

pub fn graph_search_bellman_path_to_string(s : GraphsearchbellmanPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphsearchbellmanCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_search_bellman_cluster_make(size : Int) -> GraphsearchbellmanCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_search_bellman_cluster_len(s : GraphsearchbellmanCluster) -> Int { s.size }

pub fn graph_search_bellman_cluster_get(s : GraphsearchbellmanCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_search_bellman_cluster_set(s : GraphsearchbellmanCluster, i : Int, v : Double) -> GraphsearchbellmanCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_search_bellman_cluster_sum(s : GraphsearchbellmanCluster) -> Double { @_common.sum(s.data) }

pub fn graph_search_bellman_cluster_mean(s : GraphsearchbellmanCluster) -> Double { @_common.mean(s.data) }

pub fn graph_search_bellman_cluster_scale(s : GraphsearchbellmanCluster, f : Double) -> GraphsearchbellmanCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_search_bellman_cluster_add(a : GraphsearchbellmanCluster, b : GraphsearchbellmanCluster) -> GraphsearchbellmanCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_search_bellman_cluster_copy(s : GraphsearchbellmanCluster) -> GraphsearchbellmanCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_search_bellman_cluster_fill(s : GraphsearchbellmanCluster, v : Double) -> GraphsearchbellmanCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_search_bellman_cluster_min(s : GraphsearchbellmanCluster) -> Double { @_common.min(s.data) }

pub fn graph_search_bellman_cluster_max(s : GraphsearchbellmanCluster) -> Double { @_common.max(s.data) }

pub fn graph_search_bellman_cluster_to_string(s : GraphsearchbellmanCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphsearchbellmanModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_search_bellman_model_make(size : Int) -> GraphsearchbellmanModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_search_bellman_model_len(s : GraphsearchbellmanModel) -> Int { s.size }

pub fn graph_search_bellman_model_get(s : GraphsearchbellmanModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_search_bellman_model_set(s : GraphsearchbellmanModel, i : Int, v : Double) -> GraphsearchbellmanModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_search_bellman_model_sum(s : GraphsearchbellmanModel) -> Double { @_common.sum(s.data) }

pub fn graph_search_bellman_model_mean(s : GraphsearchbellmanModel) -> Double { @_common.mean(s.data) }

pub fn graph_search_bellman_model_scale(s : GraphsearchbellmanModel, f : Double) -> GraphsearchbellmanModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_search_bellman_model_add(a : GraphsearchbellmanModel, b : GraphsearchbellmanModel) -> GraphsearchbellmanModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_search_bellman_model_copy(s : GraphsearchbellmanModel) -> GraphsearchbellmanModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_search_bellman_model_fill(s : GraphsearchbellmanModel, v : Double) -> GraphsearchbellmanModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_search_bellman_model_min(s : GraphsearchbellmanModel) -> Double { @_common.min(s.data) }

pub fn graph_search_bellman_model_max(s : GraphsearchbellmanModel) -> Double { @_common.max(s.data) }

pub fn graph_search_bellman_model_to_string(s : GraphsearchbellmanModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphsearchbellmanLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_search_bellman_layer_make(size : Int) -> GraphsearchbellmanLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_search_bellman_layer_len(s : GraphsearchbellmanLayer) -> Int { s.size }

pub fn graph_search_bellman_layer_get(s : GraphsearchbellmanLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_search_bellman_layer_set(s : GraphsearchbellmanLayer, i : Int, v : Double) -> GraphsearchbellmanLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_search_bellman_layer_sum(s : GraphsearchbellmanLayer) -> Double { @_common.sum(s.data) }

pub fn graph_search_bellman_layer_mean(s : GraphsearchbellmanLayer) -> Double { @_common.mean(s.data) }

pub fn graph_search_bellman_layer_scale(s : GraphsearchbellmanLayer, f : Double) -> GraphsearchbellmanLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_search_bellman_layer_add(a : GraphsearchbellmanLayer, b : GraphsearchbellmanLayer) -> GraphsearchbellmanLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_search_bellman_layer_copy(s : GraphsearchbellmanLayer) -> GraphsearchbellmanLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_search_bellman_layer_fill(s : GraphsearchbellmanLayer, v : Double) -> GraphsearchbellmanLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_search_bellman_layer_min(s : GraphsearchbellmanLayer) -> Double { @_common.min(s.data) }

pub fn graph_search_bellman_layer_max(s : GraphsearchbellmanLayer) -> Double { @_common.max(s.data) }

pub fn graph_search_bellman_layer_to_string(s : GraphsearchbellmanLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphsearchbellmanBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_search_bellman_buffer_make(size : Int) -> GraphsearchbellmanBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_search_bellman_buffer_len(s : GraphsearchbellmanBuffer) -> Int { s.size }

pub fn graph_search_bellman_buffer_get(s : GraphsearchbellmanBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_search_bellman_buffer_set(s : GraphsearchbellmanBuffer, i : Int, v : Double) -> GraphsearchbellmanBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_search_bellman_buffer_sum(s : GraphsearchbellmanBuffer) -> Double { @_common.sum(s.data) }

pub fn graph_search_bellman_buffer_mean(s : GraphsearchbellmanBuffer) -> Double { @_common.mean(s.data) }

pub fn graph_search_bellman_buffer_scale(s : GraphsearchbellmanBuffer, f : Double) -> GraphsearchbellmanBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_search_bellman_buffer_add(a : GraphsearchbellmanBuffer, b : GraphsearchbellmanBuffer) -> GraphsearchbellmanBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_search_bellman_buffer_copy(s : GraphsearchbellmanBuffer) -> GraphsearchbellmanBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_search_bellman_buffer_fill(s : GraphsearchbellmanBuffer, v : Double) -> GraphsearchbellmanBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_search_bellman_buffer_min(s : GraphsearchbellmanBuffer) -> Double { @_common.min(s.data) }

pub fn graph_search_bellman_buffer_max(s : GraphsearchbellmanBuffer) -> Double { @_common.max(s.data) }

pub fn graph_search_bellman_buffer_to_string(s : GraphsearchbellmanBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphsearchbellmanCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_search_bellman_cursor_make(size : Int) -> GraphsearchbellmanCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_search_bellman_cursor_len(s : GraphsearchbellmanCursor) -> Int { s.size }

pub fn graph_search_bellman_cursor_get(s : GraphsearchbellmanCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_search_bellman_cursor_set(s : GraphsearchbellmanCursor, i : Int, v : Double) -> GraphsearchbellmanCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_search_bellman_cursor_sum(s : GraphsearchbellmanCursor) -> Double { @_common.sum(s.data) }

pub fn graph_search_bellman_cursor_mean(s : GraphsearchbellmanCursor) -> Double { @_common.mean(s.data) }

pub fn graph_search_bellman_cursor_scale(s : GraphsearchbellmanCursor, f : Double) -> GraphsearchbellmanCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_search_bellman_cursor_add(a : GraphsearchbellmanCursor, b : GraphsearchbellmanCursor) -> GraphsearchbellmanCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_search_bellman_cursor_copy(s : GraphsearchbellmanCursor) -> GraphsearchbellmanCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_search_bellman_cursor_fill(s : GraphsearchbellmanCursor, v : Double) -> GraphsearchbellmanCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_search_bellman_cursor_min(s : GraphsearchbellmanCursor) -> Double { @_common.min(s.data) }

pub fn graph_search_bellman_cursor_max(s : GraphsearchbellmanCursor) -> Double { @_common.max(s.data) }

pub fn graph_search_bellman_cursor_to_string(s : GraphsearchbellmanCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphsearchbellmanView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_search_bellman_view_make(size : Int) -> GraphsearchbellmanView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_search_bellman_view_len(s : GraphsearchbellmanView) -> Int { s.size }

pub fn graph_search_bellman_view_get(s : GraphsearchbellmanView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_search_bellman_view_set(s : GraphsearchbellmanView, i : Int, v : Double) -> GraphsearchbellmanView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_search_bellman_view_sum(s : GraphsearchbellmanView) -> Double { @_common.sum(s.data) }

pub fn graph_search_bellman_view_mean(s : GraphsearchbellmanView) -> Double { @_common.mean(s.data) }

pub fn graph_search_bellman_view_scale(s : GraphsearchbellmanView, f : Double) -> GraphsearchbellmanView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_search_bellman_view_add(a : GraphsearchbellmanView, b : GraphsearchbellmanView) -> GraphsearchbellmanView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_search_bellman_view_copy(s : GraphsearchbellmanView) -> GraphsearchbellmanView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_search_bellman_view_fill(s : GraphsearchbellmanView, v : Double) -> GraphsearchbellmanView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_search_bellman_view_min(s : GraphsearchbellmanView) -> Double { @_common.min(s.data) }

pub fn graph_search_bellman_view_max(s : GraphsearchbellmanView) -> Double { @_common.max(s.data) }

pub fn graph_search_bellman_view_to_string(s : GraphsearchbellmanView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphsearchbellmanRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_search_bellman_range_make(size : Int) -> GraphsearchbellmanRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_search_bellman_range_len(s : GraphsearchbellmanRange) -> Int { s.size }

pub fn graph_search_bellman_range_get(s : GraphsearchbellmanRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_search_bellman_range_set(s : GraphsearchbellmanRange, i : Int, v : Double) -> GraphsearchbellmanRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_search_bellman_range_sum(s : GraphsearchbellmanRange) -> Double { @_common.sum(s.data) }

pub fn graph_search_bellman_range_mean(s : GraphsearchbellmanRange) -> Double { @_common.mean(s.data) }

pub fn graph_search_bellman_range_scale(s : GraphsearchbellmanRange, f : Double) -> GraphsearchbellmanRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_search_bellman_range_add(a : GraphsearchbellmanRange, b : GraphsearchbellmanRange) -> GraphsearchbellmanRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_search_bellman_range_copy(s : GraphsearchbellmanRange) -> GraphsearchbellmanRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_search_bellman_range_fill(s : GraphsearchbellmanRange, v : Double) -> GraphsearchbellmanRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_search_bellman_range_min(s : GraphsearchbellmanRange) -> Double { @_common.min(s.data) }

pub fn graph_search_bellman_range_max(s : GraphsearchbellmanRange) -> Double { @_common.max(s.data) }

pub fn graph_search_bellman_range_to_string(s : GraphsearchbellmanRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphsearchbellmanSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_search_bellman_slice_make(size : Int) -> GraphsearchbellmanSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_search_bellman_slice_len(s : GraphsearchbellmanSlice) -> Int { s.size }

pub fn graph_search_bellman_slice_get(s : GraphsearchbellmanSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_search_bellman_slice_set(s : GraphsearchbellmanSlice, i : Int, v : Double) -> GraphsearchbellmanSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_search_bellman_slice_sum(s : GraphsearchbellmanSlice) -> Double { @_common.sum(s.data) }

pub fn graph_search_bellman_slice_mean(s : GraphsearchbellmanSlice) -> Double { @_common.mean(s.data) }

pub fn graph_search_bellman_slice_scale(s : GraphsearchbellmanSlice, f : Double) -> GraphsearchbellmanSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_search_bellman_slice_add(a : GraphsearchbellmanSlice, b : GraphsearchbellmanSlice) -> GraphsearchbellmanSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_search_bellman_slice_copy(s : GraphsearchbellmanSlice) -> GraphsearchbellmanSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_search_bellman_slice_fill(s : GraphsearchbellmanSlice, v : Double) -> GraphsearchbellmanSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_search_bellman_slice_min(s : GraphsearchbellmanSlice) -> Double { @_common.min(s.data) }

pub fn graph_search_bellman_slice_max(s : GraphsearchbellmanSlice) -> Double { @_common.max(s.data) }

pub fn graph_search_bellman_slice_to_string(s : GraphsearchbellmanSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

