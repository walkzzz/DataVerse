///===
/// extcore/graph_search_johnson

pub(all) struct GraphsearchjohnsonPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn graph_search_johnson_make_point(x : Double, y : Double) -> GraphsearchjohnsonPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn graph_search_johnson_make_point3(x : Double, y : Double, z : Double) -> GraphsearchjohnsonPoint {
  { x, y, z, label: 0 }
}

pub fn GraphsearchjohnsonPoint::x(self : GraphsearchjohnsonPoint) -> Double { self.x }

pub fn GraphsearchjohnsonPoint::y(self : GraphsearchjohnsonPoint) -> Double { self.y }

pub fn GraphsearchjohnsonPoint::z(self : GraphsearchjohnsonPoint) -> Double { self.z }

pub fn GraphsearchjohnsonPoint::label(self : GraphsearchjohnsonPoint) -> Int { self.label }

pub fn GraphsearchjohnsonPoint::dist(self : GraphsearchjohnsonPoint, other : GraphsearchjohnsonPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn GraphsearchjohnsonPoint::add(self : GraphsearchjohnsonPoint, other : GraphsearchjohnsonPoint) -> GraphsearchjohnsonPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn GraphsearchjohnsonPoint::sub(self : GraphsearchjohnsonPoint, other : GraphsearchjohnsonPoint) -> GraphsearchjohnsonPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn GraphsearchjohnsonPoint::scale(self : GraphsearchjohnsonPoint, s : Double) -> GraphsearchjohnsonPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn GraphsearchjohnsonPoint::dot(self : GraphsearchjohnsonPoint, other : GraphsearchjohnsonPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn GraphsearchjohnsonPoint::cross(self : GraphsearchjohnsonPoint, other : GraphsearchjohnsonPoint) -> GraphsearchjohnsonPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn GraphsearchjohnsonPoint::norm(self : GraphsearchjohnsonPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn GraphsearchjohnsonPoint::normalize(self : GraphsearchjohnsonPoint) -> GraphsearchjohnsonPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn GraphsearchjohnsonPoint::negate(self : GraphsearchjohnsonPoint) -> GraphsearchjohnsonPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn GraphsearchjohnsonPoint::mid(self : GraphsearchjohnsonPoint, other : GraphsearchjohnsonPoint) -> GraphsearchjohnsonPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn GraphsearchjohnsonPoint::lerp(self : GraphsearchjohnsonPoint, other : GraphsearchjohnsonPoint, t : Double) -> GraphsearchjohnsonPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn GraphsearchjohnsonPoint::to_string(self : GraphsearchjohnsonPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct GraphsearchjohnsonSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn graph_search_johnson_make_series(vals : Array[Double], name : String) -> GraphsearchjohnsonSeries {
  { vals, name, meta: 0 }
}

pub fn GraphsearchjohnsonSeries::len(self : GraphsearchjohnsonSeries) -> Int { self.vals.length() }

pub fn GraphsearchjohnsonSeries::sum(self : GraphsearchjohnsonSeries) -> Double { @_common.sum(self.vals) }

pub fn GraphsearchjohnsonSeries::mean(self : GraphsearchjohnsonSeries) -> Double { @_common.mean(self.vals) }

pub fn GraphsearchjohnsonSeries::min(self : GraphsearchjohnsonSeries) -> Double { @_common.min(self.vals) }

pub fn GraphsearchjohnsonSeries::max(self : GraphsearchjohnsonSeries) -> Double { @_common.max(self.vals) }

pub fn GraphsearchjohnsonSeries::range(self : GraphsearchjohnsonSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn GraphsearchjohnsonSeries::variance(self : GraphsearchjohnsonSeries) -> Double { @_common.variance(self.vals) }

pub fn GraphsearchjohnsonSeries::std(self : GraphsearchjohnsonSeries) -> Double { @_common.std(self.vals) }

pub fn GraphsearchjohnsonSeries::median(self : GraphsearchjohnsonSeries) -> Double { @_common.median(self.vals) }

pub fn GraphsearchjohnsonSeries::scale(self : GraphsearchjohnsonSeries, f : Double) -> GraphsearchjohnsonSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn GraphsearchjohnsonSeries::add(self : GraphsearchjohnsonSeries, other : GraphsearchjohnsonSeries) -> GraphsearchjohnsonSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn GraphsearchjohnsonSeries::sub(self : GraphsearchjohnsonSeries, other : GraphsearchjohnsonSeries) -> GraphsearchjohnsonSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn GraphsearchjohnsonSeries::normalize(self : GraphsearchjohnsonSeries) -> GraphsearchjohnsonSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn GraphsearchjohnsonSeries::cumsum(self : GraphsearchjohnsonSeries) -> GraphsearchjohnsonSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn GraphsearchjohnsonSeries::to_string(self : GraphsearchjohnsonSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct GraphsearchjohnsonMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn graph_search_johnson_make_matrix(rows : Int, cols : Int, val : Double) -> GraphsearchjohnsonMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn graph_search_johnson_matrix_identity(n : Int) -> GraphsearchjohnsonMatrix {
  let m = graph_search_johnson_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn GraphsearchjohnsonMatrix::get(self : GraphsearchjohnsonMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn GraphsearchjohnsonMatrix::transpose(self : GraphsearchjohnsonMatrix) -> GraphsearchjohnsonMatrix {
  let result = graph_search_johnson_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn GraphsearchjohnsonMatrix::add(self : GraphsearchjohnsonMatrix, other : GraphsearchjohnsonMatrix) -> GraphsearchjohnsonMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = graph_search_johnson_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn GraphsearchjohnsonMatrix::scale(self : GraphsearchjohnsonMatrix, s : Double) -> GraphsearchjohnsonMatrix {
  let result = graph_search_johnson_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn GraphsearchjohnsonMatrix::multiply(self : GraphsearchjohnsonMatrix, other : GraphsearchjohnsonMatrix) -> GraphsearchjohnsonMatrix {
  if self.cols != other.rows { return graph_search_johnson_make_matrix(self.rows, other.cols, 0.0) }
  let result = graph_search_johnson_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn GraphsearchjohnsonMatrix::trace(self : GraphsearchjohnsonMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn GraphsearchjohnsonMatrix::det(self : GraphsearchjohnsonMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn GraphsearchjohnsonMatrix::norm(self : GraphsearchjohnsonMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn GraphsearchjohnsonMatrix::to_string(self : GraphsearchjohnsonMatrix) -> String {
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

pub(all) struct GraphsearchjohnsonVector {
  comps : Array[Double]
  dim : Int
}

pub fn graph_search_johnson_make_vector(comps : Array[Double]) -> GraphsearchjohnsonVector {
  { comps, dim: comps.length() }
}

pub fn graph_search_johnson_vector_zero(dim : Int) -> GraphsearchjohnsonVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn GraphsearchjohnsonVector::add(self : GraphsearchjohnsonVector, other : GraphsearchjohnsonVector) -> GraphsearchjohnsonVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn GraphsearchjohnsonVector::sub(self : GraphsearchjohnsonVector, other : GraphsearchjohnsonVector) -> GraphsearchjohnsonVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn GraphsearchjohnsonVector::scale(self : GraphsearchjohnsonVector, s : Double) -> GraphsearchjohnsonVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn GraphsearchjohnsonVector::dot(self : GraphsearchjohnsonVector, other : GraphsearchjohnsonVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn GraphsearchjohnsonVector::norm(self : GraphsearchjohnsonVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn GraphsearchjohnsonVector::normalize(self : GraphsearchjohnsonVector) -> GraphsearchjohnsonVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn GraphsearchjohnsonVector::dist(self : GraphsearchjohnsonVector, other : GraphsearchjohnsonVector) -> Double {
  self.sub(other).norm()
}

pub fn GraphsearchjohnsonVector::to_string(self : GraphsearchjohnsonVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn graph_search_johnson_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn graph_search_johnson_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn graph_search_johnson_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn graph_search_johnson_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn graph_search_johnson_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn graph_search_johnson_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn graph_search_johnson_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn graph_search_johnson_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn graph_search_johnson_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn graph_search_johnson_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn graph_search_johnson_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn graph_search_johnson_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn graph_search_johnson_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn graph_search_johnson_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn graph_search_johnson_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn graph_search_johnson_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn graph_search_johnson_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn graph_search_johnson_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn graph_search_johnson_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn graph_search_johnson_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn graph_search_johnson_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn graph_search_johnson_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn graph_search_johnson_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn graph_search_johnson_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn graph_search_johnson_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn graph_search_johnson_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn graph_search_johnson_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn graph_search_johnson_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn graph_search_johnson_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct GraphsearchjohnsonFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_search_johnson_frame_make(size : Int) -> GraphsearchjohnsonFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_search_johnson_frame_len(s : GraphsearchjohnsonFrame) -> Int { s.size }

pub fn graph_search_johnson_frame_get(s : GraphsearchjohnsonFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_search_johnson_frame_set(s : GraphsearchjohnsonFrame, i : Int, v : Double) -> GraphsearchjohnsonFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_search_johnson_frame_sum(s : GraphsearchjohnsonFrame) -> Double { @_common.sum(s.data) }

pub fn graph_search_johnson_frame_mean(s : GraphsearchjohnsonFrame) -> Double { @_common.mean(s.data) }

pub fn graph_search_johnson_frame_scale(s : GraphsearchjohnsonFrame, f : Double) -> GraphsearchjohnsonFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_search_johnson_frame_add(a : GraphsearchjohnsonFrame, b : GraphsearchjohnsonFrame) -> GraphsearchjohnsonFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_search_johnson_frame_copy(s : GraphsearchjohnsonFrame) -> GraphsearchjohnsonFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_search_johnson_frame_fill(s : GraphsearchjohnsonFrame, v : Double) -> GraphsearchjohnsonFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_search_johnson_frame_min(s : GraphsearchjohnsonFrame) -> Double { @_common.min(s.data) }

pub fn graph_search_johnson_frame_max(s : GraphsearchjohnsonFrame) -> Double { @_common.max(s.data) }

pub fn graph_search_johnson_frame_to_string(s : GraphsearchjohnsonFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphsearchjohnsonTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_search_johnson_table_make(size : Int) -> GraphsearchjohnsonTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_search_johnson_table_len(s : GraphsearchjohnsonTable) -> Int { s.size }

pub fn graph_search_johnson_table_get(s : GraphsearchjohnsonTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_search_johnson_table_set(s : GraphsearchjohnsonTable, i : Int, v : Double) -> GraphsearchjohnsonTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_search_johnson_table_sum(s : GraphsearchjohnsonTable) -> Double { @_common.sum(s.data) }

pub fn graph_search_johnson_table_mean(s : GraphsearchjohnsonTable) -> Double { @_common.mean(s.data) }

pub fn graph_search_johnson_table_scale(s : GraphsearchjohnsonTable, f : Double) -> GraphsearchjohnsonTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_search_johnson_table_add(a : GraphsearchjohnsonTable, b : GraphsearchjohnsonTable) -> GraphsearchjohnsonTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_search_johnson_table_copy(s : GraphsearchjohnsonTable) -> GraphsearchjohnsonTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_search_johnson_table_fill(s : GraphsearchjohnsonTable, v : Double) -> GraphsearchjohnsonTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_search_johnson_table_min(s : GraphsearchjohnsonTable) -> Double { @_common.min(s.data) }

pub fn graph_search_johnson_table_max(s : GraphsearchjohnsonTable) -> Double { @_common.max(s.data) }

pub fn graph_search_johnson_table_to_string(s : GraphsearchjohnsonTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphsearchjohnsonGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_search_johnson_graphn_make(size : Int) -> GraphsearchjohnsonGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_search_johnson_graphn_len(s : GraphsearchjohnsonGraphN) -> Int { s.size }

pub fn graph_search_johnson_graphn_get(s : GraphsearchjohnsonGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_search_johnson_graphn_set(s : GraphsearchjohnsonGraphN, i : Int, v : Double) -> GraphsearchjohnsonGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_search_johnson_graphn_sum(s : GraphsearchjohnsonGraphN) -> Double { @_common.sum(s.data) }

pub fn graph_search_johnson_graphn_mean(s : GraphsearchjohnsonGraphN) -> Double { @_common.mean(s.data) }

pub fn graph_search_johnson_graphn_scale(s : GraphsearchjohnsonGraphN, f : Double) -> GraphsearchjohnsonGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_search_johnson_graphn_add(a : GraphsearchjohnsonGraphN, b : GraphsearchjohnsonGraphN) -> GraphsearchjohnsonGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_search_johnson_graphn_copy(s : GraphsearchjohnsonGraphN) -> GraphsearchjohnsonGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_search_johnson_graphn_fill(s : GraphsearchjohnsonGraphN, v : Double) -> GraphsearchjohnsonGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_search_johnson_graphn_min(s : GraphsearchjohnsonGraphN) -> Double { @_common.min(s.data) }

pub fn graph_search_johnson_graphn_max(s : GraphsearchjohnsonGraphN) -> Double { @_common.max(s.data) }

pub fn graph_search_johnson_graphn_to_string(s : GraphsearchjohnsonGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphsearchjohnsonNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_search_johnson_node_make(size : Int) -> GraphsearchjohnsonNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_search_johnson_node_len(s : GraphsearchjohnsonNode) -> Int { s.size }

pub fn graph_search_johnson_node_get(s : GraphsearchjohnsonNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_search_johnson_node_set(s : GraphsearchjohnsonNode, i : Int, v : Double) -> GraphsearchjohnsonNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_search_johnson_node_sum(s : GraphsearchjohnsonNode) -> Double { @_common.sum(s.data) }

pub fn graph_search_johnson_node_mean(s : GraphsearchjohnsonNode) -> Double { @_common.mean(s.data) }

pub fn graph_search_johnson_node_scale(s : GraphsearchjohnsonNode, f : Double) -> GraphsearchjohnsonNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_search_johnson_node_add(a : GraphsearchjohnsonNode, b : GraphsearchjohnsonNode) -> GraphsearchjohnsonNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_search_johnson_node_copy(s : GraphsearchjohnsonNode) -> GraphsearchjohnsonNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_search_johnson_node_fill(s : GraphsearchjohnsonNode, v : Double) -> GraphsearchjohnsonNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_search_johnson_node_min(s : GraphsearchjohnsonNode) -> Double { @_common.min(s.data) }

pub fn graph_search_johnson_node_max(s : GraphsearchjohnsonNode) -> Double { @_common.max(s.data) }

pub fn graph_search_johnson_node_to_string(s : GraphsearchjohnsonNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphsearchjohnsonEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_search_johnson_edge_make(size : Int) -> GraphsearchjohnsonEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_search_johnson_edge_len(s : GraphsearchjohnsonEdge) -> Int { s.size }

pub fn graph_search_johnson_edge_get(s : GraphsearchjohnsonEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_search_johnson_edge_set(s : GraphsearchjohnsonEdge, i : Int, v : Double) -> GraphsearchjohnsonEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_search_johnson_edge_sum(s : GraphsearchjohnsonEdge) -> Double { @_common.sum(s.data) }

pub fn graph_search_johnson_edge_mean(s : GraphsearchjohnsonEdge) -> Double { @_common.mean(s.data) }

pub fn graph_search_johnson_edge_scale(s : GraphsearchjohnsonEdge, f : Double) -> GraphsearchjohnsonEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_search_johnson_edge_add(a : GraphsearchjohnsonEdge, b : GraphsearchjohnsonEdge) -> GraphsearchjohnsonEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_search_johnson_edge_copy(s : GraphsearchjohnsonEdge) -> GraphsearchjohnsonEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_search_johnson_edge_fill(s : GraphsearchjohnsonEdge, v : Double) -> GraphsearchjohnsonEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_search_johnson_edge_min(s : GraphsearchjohnsonEdge) -> Double { @_common.min(s.data) }

pub fn graph_search_johnson_edge_max(s : GraphsearchjohnsonEdge) -> Double { @_common.max(s.data) }

pub fn graph_search_johnson_edge_to_string(s : GraphsearchjohnsonEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphsearchjohnsonPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_search_johnson_path_make(size : Int) -> GraphsearchjohnsonPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_search_johnson_path_len(s : GraphsearchjohnsonPath) -> Int { s.size }

pub fn graph_search_johnson_path_get(s : GraphsearchjohnsonPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_search_johnson_path_set(s : GraphsearchjohnsonPath, i : Int, v : Double) -> GraphsearchjohnsonPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_search_johnson_path_sum(s : GraphsearchjohnsonPath) -> Double { @_common.sum(s.data) }

pub fn graph_search_johnson_path_mean(s : GraphsearchjohnsonPath) -> Double { @_common.mean(s.data) }

pub fn graph_search_johnson_path_scale(s : GraphsearchjohnsonPath, f : Double) -> GraphsearchjohnsonPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_search_johnson_path_add(a : GraphsearchjohnsonPath, b : GraphsearchjohnsonPath) -> GraphsearchjohnsonPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_search_johnson_path_copy(s : GraphsearchjohnsonPath) -> GraphsearchjohnsonPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_search_johnson_path_fill(s : GraphsearchjohnsonPath, v : Double) -> GraphsearchjohnsonPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_search_johnson_path_min(s : GraphsearchjohnsonPath) -> Double { @_common.min(s.data) }

pub fn graph_search_johnson_path_max(s : GraphsearchjohnsonPath) -> Double { @_common.max(s.data) }

pub fn graph_search_johnson_path_to_string(s : GraphsearchjohnsonPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphsearchjohnsonCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_search_johnson_cluster_make(size : Int) -> GraphsearchjohnsonCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_search_johnson_cluster_len(s : GraphsearchjohnsonCluster) -> Int { s.size }

pub fn graph_search_johnson_cluster_get(s : GraphsearchjohnsonCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_search_johnson_cluster_set(s : GraphsearchjohnsonCluster, i : Int, v : Double) -> GraphsearchjohnsonCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_search_johnson_cluster_sum(s : GraphsearchjohnsonCluster) -> Double { @_common.sum(s.data) }

pub fn graph_search_johnson_cluster_mean(s : GraphsearchjohnsonCluster) -> Double { @_common.mean(s.data) }

pub fn graph_search_johnson_cluster_scale(s : GraphsearchjohnsonCluster, f : Double) -> GraphsearchjohnsonCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_search_johnson_cluster_add(a : GraphsearchjohnsonCluster, b : GraphsearchjohnsonCluster) -> GraphsearchjohnsonCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_search_johnson_cluster_copy(s : GraphsearchjohnsonCluster) -> GraphsearchjohnsonCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_search_johnson_cluster_fill(s : GraphsearchjohnsonCluster, v : Double) -> GraphsearchjohnsonCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_search_johnson_cluster_min(s : GraphsearchjohnsonCluster) -> Double { @_common.min(s.data) }

pub fn graph_search_johnson_cluster_max(s : GraphsearchjohnsonCluster) -> Double { @_common.max(s.data) }

pub fn graph_search_johnson_cluster_to_string(s : GraphsearchjohnsonCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphsearchjohnsonModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_search_johnson_model_make(size : Int) -> GraphsearchjohnsonModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_search_johnson_model_len(s : GraphsearchjohnsonModel) -> Int { s.size }

pub fn graph_search_johnson_model_get(s : GraphsearchjohnsonModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_search_johnson_model_set(s : GraphsearchjohnsonModel, i : Int, v : Double) -> GraphsearchjohnsonModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_search_johnson_model_sum(s : GraphsearchjohnsonModel) -> Double { @_common.sum(s.data) }

pub fn graph_search_johnson_model_mean(s : GraphsearchjohnsonModel) -> Double { @_common.mean(s.data) }

pub fn graph_search_johnson_model_scale(s : GraphsearchjohnsonModel, f : Double) -> GraphsearchjohnsonModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_search_johnson_model_add(a : GraphsearchjohnsonModel, b : GraphsearchjohnsonModel) -> GraphsearchjohnsonModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_search_johnson_model_copy(s : GraphsearchjohnsonModel) -> GraphsearchjohnsonModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_search_johnson_model_fill(s : GraphsearchjohnsonModel, v : Double) -> GraphsearchjohnsonModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_search_johnson_model_min(s : GraphsearchjohnsonModel) -> Double { @_common.min(s.data) }

pub fn graph_search_johnson_model_max(s : GraphsearchjohnsonModel) -> Double { @_common.max(s.data) }

pub fn graph_search_johnson_model_to_string(s : GraphsearchjohnsonModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphsearchjohnsonLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_search_johnson_layer_make(size : Int) -> GraphsearchjohnsonLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_search_johnson_layer_len(s : GraphsearchjohnsonLayer) -> Int { s.size }

pub fn graph_search_johnson_layer_get(s : GraphsearchjohnsonLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_search_johnson_layer_set(s : GraphsearchjohnsonLayer, i : Int, v : Double) -> GraphsearchjohnsonLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_search_johnson_layer_sum(s : GraphsearchjohnsonLayer) -> Double { @_common.sum(s.data) }

pub fn graph_search_johnson_layer_mean(s : GraphsearchjohnsonLayer) -> Double { @_common.mean(s.data) }

pub fn graph_search_johnson_layer_scale(s : GraphsearchjohnsonLayer, f : Double) -> GraphsearchjohnsonLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_search_johnson_layer_add(a : GraphsearchjohnsonLayer, b : GraphsearchjohnsonLayer) -> GraphsearchjohnsonLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_search_johnson_layer_copy(s : GraphsearchjohnsonLayer) -> GraphsearchjohnsonLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_search_johnson_layer_fill(s : GraphsearchjohnsonLayer, v : Double) -> GraphsearchjohnsonLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_search_johnson_layer_min(s : GraphsearchjohnsonLayer) -> Double { @_common.min(s.data) }

pub fn graph_search_johnson_layer_max(s : GraphsearchjohnsonLayer) -> Double { @_common.max(s.data) }

pub fn graph_search_johnson_layer_to_string(s : GraphsearchjohnsonLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphsearchjohnsonBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_search_johnson_buffer_make(size : Int) -> GraphsearchjohnsonBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_search_johnson_buffer_len(s : GraphsearchjohnsonBuffer) -> Int { s.size }

pub fn graph_search_johnson_buffer_get(s : GraphsearchjohnsonBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_search_johnson_buffer_set(s : GraphsearchjohnsonBuffer, i : Int, v : Double) -> GraphsearchjohnsonBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_search_johnson_buffer_sum(s : GraphsearchjohnsonBuffer) -> Double { @_common.sum(s.data) }

pub fn graph_search_johnson_buffer_mean(s : GraphsearchjohnsonBuffer) -> Double { @_common.mean(s.data) }

pub fn graph_search_johnson_buffer_scale(s : GraphsearchjohnsonBuffer, f : Double) -> GraphsearchjohnsonBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_search_johnson_buffer_add(a : GraphsearchjohnsonBuffer, b : GraphsearchjohnsonBuffer) -> GraphsearchjohnsonBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_search_johnson_buffer_copy(s : GraphsearchjohnsonBuffer) -> GraphsearchjohnsonBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_search_johnson_buffer_fill(s : GraphsearchjohnsonBuffer, v : Double) -> GraphsearchjohnsonBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_search_johnson_buffer_min(s : GraphsearchjohnsonBuffer) -> Double { @_common.min(s.data) }

pub fn graph_search_johnson_buffer_max(s : GraphsearchjohnsonBuffer) -> Double { @_common.max(s.data) }

pub fn graph_search_johnson_buffer_to_string(s : GraphsearchjohnsonBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphsearchjohnsonCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_search_johnson_cursor_make(size : Int) -> GraphsearchjohnsonCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_search_johnson_cursor_len(s : GraphsearchjohnsonCursor) -> Int { s.size }

pub fn graph_search_johnson_cursor_get(s : GraphsearchjohnsonCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_search_johnson_cursor_set(s : GraphsearchjohnsonCursor, i : Int, v : Double) -> GraphsearchjohnsonCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_search_johnson_cursor_sum(s : GraphsearchjohnsonCursor) -> Double { @_common.sum(s.data) }

pub fn graph_search_johnson_cursor_mean(s : GraphsearchjohnsonCursor) -> Double { @_common.mean(s.data) }

pub fn graph_search_johnson_cursor_scale(s : GraphsearchjohnsonCursor, f : Double) -> GraphsearchjohnsonCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_search_johnson_cursor_add(a : GraphsearchjohnsonCursor, b : GraphsearchjohnsonCursor) -> GraphsearchjohnsonCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_search_johnson_cursor_copy(s : GraphsearchjohnsonCursor) -> GraphsearchjohnsonCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_search_johnson_cursor_fill(s : GraphsearchjohnsonCursor, v : Double) -> GraphsearchjohnsonCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_search_johnson_cursor_min(s : GraphsearchjohnsonCursor) -> Double { @_common.min(s.data) }

pub fn graph_search_johnson_cursor_max(s : GraphsearchjohnsonCursor) -> Double { @_common.max(s.data) }

pub fn graph_search_johnson_cursor_to_string(s : GraphsearchjohnsonCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphsearchjohnsonView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_search_johnson_view_make(size : Int) -> GraphsearchjohnsonView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_search_johnson_view_len(s : GraphsearchjohnsonView) -> Int { s.size }

pub fn graph_search_johnson_view_get(s : GraphsearchjohnsonView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_search_johnson_view_set(s : GraphsearchjohnsonView, i : Int, v : Double) -> GraphsearchjohnsonView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_search_johnson_view_sum(s : GraphsearchjohnsonView) -> Double { @_common.sum(s.data) }

pub fn graph_search_johnson_view_mean(s : GraphsearchjohnsonView) -> Double { @_common.mean(s.data) }

pub fn graph_search_johnson_view_scale(s : GraphsearchjohnsonView, f : Double) -> GraphsearchjohnsonView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_search_johnson_view_add(a : GraphsearchjohnsonView, b : GraphsearchjohnsonView) -> GraphsearchjohnsonView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_search_johnson_view_copy(s : GraphsearchjohnsonView) -> GraphsearchjohnsonView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_search_johnson_view_fill(s : GraphsearchjohnsonView, v : Double) -> GraphsearchjohnsonView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_search_johnson_view_min(s : GraphsearchjohnsonView) -> Double { @_common.min(s.data) }

pub fn graph_search_johnson_view_max(s : GraphsearchjohnsonView) -> Double { @_common.max(s.data) }

pub fn graph_search_johnson_view_to_string(s : GraphsearchjohnsonView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphsearchjohnsonRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_search_johnson_range_make(size : Int) -> GraphsearchjohnsonRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_search_johnson_range_len(s : GraphsearchjohnsonRange) -> Int { s.size }

pub fn graph_search_johnson_range_get(s : GraphsearchjohnsonRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_search_johnson_range_set(s : GraphsearchjohnsonRange, i : Int, v : Double) -> GraphsearchjohnsonRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_search_johnson_range_sum(s : GraphsearchjohnsonRange) -> Double { @_common.sum(s.data) }

pub fn graph_search_johnson_range_mean(s : GraphsearchjohnsonRange) -> Double { @_common.mean(s.data) }

pub fn graph_search_johnson_range_scale(s : GraphsearchjohnsonRange, f : Double) -> GraphsearchjohnsonRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_search_johnson_range_add(a : GraphsearchjohnsonRange, b : GraphsearchjohnsonRange) -> GraphsearchjohnsonRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_search_johnson_range_copy(s : GraphsearchjohnsonRange) -> GraphsearchjohnsonRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_search_johnson_range_fill(s : GraphsearchjohnsonRange, v : Double) -> GraphsearchjohnsonRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_search_johnson_range_min(s : GraphsearchjohnsonRange) -> Double { @_common.min(s.data) }

pub fn graph_search_johnson_range_max(s : GraphsearchjohnsonRange) -> Double { @_common.max(s.data) }

pub fn graph_search_johnson_range_to_string(s : GraphsearchjohnsonRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphsearchjohnsonSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_search_johnson_slice_make(size : Int) -> GraphsearchjohnsonSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_search_johnson_slice_len(s : GraphsearchjohnsonSlice) -> Int { s.size }

pub fn graph_search_johnson_slice_get(s : GraphsearchjohnsonSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_search_johnson_slice_set(s : GraphsearchjohnsonSlice, i : Int, v : Double) -> GraphsearchjohnsonSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_search_johnson_slice_sum(s : GraphsearchjohnsonSlice) -> Double { @_common.sum(s.data) }

pub fn graph_search_johnson_slice_mean(s : GraphsearchjohnsonSlice) -> Double { @_common.mean(s.data) }

pub fn graph_search_johnson_slice_scale(s : GraphsearchjohnsonSlice, f : Double) -> GraphsearchjohnsonSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_search_johnson_slice_add(a : GraphsearchjohnsonSlice, b : GraphsearchjohnsonSlice) -> GraphsearchjohnsonSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_search_johnson_slice_copy(s : GraphsearchjohnsonSlice) -> GraphsearchjohnsonSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_search_johnson_slice_fill(s : GraphsearchjohnsonSlice, v : Double) -> GraphsearchjohnsonSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_search_johnson_slice_min(s : GraphsearchjohnsonSlice) -> Double { @_common.min(s.data) }

pub fn graph_search_johnson_slice_max(s : GraphsearchjohnsonSlice) -> Double { @_common.max(s.data) }

pub fn graph_search_johnson_slice_to_string(s : GraphsearchjohnsonSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

