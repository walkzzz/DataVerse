///===
/// extcore/graph_search_floyd

pub(all) struct GraphsearchfloydPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn graph_search_floyd_make_point(x : Double, y : Double) -> GraphsearchfloydPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn graph_search_floyd_make_point3(x : Double, y : Double, z : Double) -> GraphsearchfloydPoint {
  { x, y, z, label: 0 }
}

pub fn GraphsearchfloydPoint::x(self : GraphsearchfloydPoint) -> Double { self.x }

pub fn GraphsearchfloydPoint::y(self : GraphsearchfloydPoint) -> Double { self.y }

pub fn GraphsearchfloydPoint::z(self : GraphsearchfloydPoint) -> Double { self.z }

pub fn GraphsearchfloydPoint::label(self : GraphsearchfloydPoint) -> Int { self.label }

pub fn GraphsearchfloydPoint::dist(self : GraphsearchfloydPoint, other : GraphsearchfloydPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn GraphsearchfloydPoint::add(self : GraphsearchfloydPoint, other : GraphsearchfloydPoint) -> GraphsearchfloydPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn GraphsearchfloydPoint::sub(self : GraphsearchfloydPoint, other : GraphsearchfloydPoint) -> GraphsearchfloydPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn GraphsearchfloydPoint::scale(self : GraphsearchfloydPoint, s : Double) -> GraphsearchfloydPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn GraphsearchfloydPoint::dot(self : GraphsearchfloydPoint, other : GraphsearchfloydPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn GraphsearchfloydPoint::cross(self : GraphsearchfloydPoint, other : GraphsearchfloydPoint) -> GraphsearchfloydPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn GraphsearchfloydPoint::norm(self : GraphsearchfloydPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn GraphsearchfloydPoint::normalize(self : GraphsearchfloydPoint) -> GraphsearchfloydPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn GraphsearchfloydPoint::negate(self : GraphsearchfloydPoint) -> GraphsearchfloydPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn GraphsearchfloydPoint::mid(self : GraphsearchfloydPoint, other : GraphsearchfloydPoint) -> GraphsearchfloydPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn GraphsearchfloydPoint::lerp(self : GraphsearchfloydPoint, other : GraphsearchfloydPoint, t : Double) -> GraphsearchfloydPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn GraphsearchfloydPoint::to_string(self : GraphsearchfloydPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct GraphsearchfloydSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn graph_search_floyd_make_series(vals : Array[Double], name : String) -> GraphsearchfloydSeries {
  { vals, name, meta: 0 }
}

pub fn GraphsearchfloydSeries::len(self : GraphsearchfloydSeries) -> Int { self.vals.length() }

pub fn GraphsearchfloydSeries::sum(self : GraphsearchfloydSeries) -> Double { @_common.sum(self.vals) }

pub fn GraphsearchfloydSeries::mean(self : GraphsearchfloydSeries) -> Double { @_common.mean(self.vals) }

pub fn GraphsearchfloydSeries::min(self : GraphsearchfloydSeries) -> Double { @_common.min(self.vals) }

pub fn GraphsearchfloydSeries::max(self : GraphsearchfloydSeries) -> Double { @_common.max(self.vals) }

pub fn GraphsearchfloydSeries::range(self : GraphsearchfloydSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn GraphsearchfloydSeries::variance(self : GraphsearchfloydSeries) -> Double { @_common.variance(self.vals) }

pub fn GraphsearchfloydSeries::std(self : GraphsearchfloydSeries) -> Double { @_common.std(self.vals) }

pub fn GraphsearchfloydSeries::median(self : GraphsearchfloydSeries) -> Double { @_common.median(self.vals) }

pub fn GraphsearchfloydSeries::scale(self : GraphsearchfloydSeries, f : Double) -> GraphsearchfloydSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn GraphsearchfloydSeries::add(self : GraphsearchfloydSeries, other : GraphsearchfloydSeries) -> GraphsearchfloydSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn GraphsearchfloydSeries::sub(self : GraphsearchfloydSeries, other : GraphsearchfloydSeries) -> GraphsearchfloydSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn GraphsearchfloydSeries::normalize(self : GraphsearchfloydSeries) -> GraphsearchfloydSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn GraphsearchfloydSeries::cumsum(self : GraphsearchfloydSeries) -> GraphsearchfloydSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn GraphsearchfloydSeries::to_string(self : GraphsearchfloydSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct GraphsearchfloydMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn graph_search_floyd_make_matrix(rows : Int, cols : Int, val : Double) -> GraphsearchfloydMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn graph_search_floyd_matrix_identity(n : Int) -> GraphsearchfloydMatrix {
  let m = graph_search_floyd_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn GraphsearchfloydMatrix::get(self : GraphsearchfloydMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn GraphsearchfloydMatrix::transpose(self : GraphsearchfloydMatrix) -> GraphsearchfloydMatrix {
  let result = graph_search_floyd_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn GraphsearchfloydMatrix::add(self : GraphsearchfloydMatrix, other : GraphsearchfloydMatrix) -> GraphsearchfloydMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = graph_search_floyd_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn GraphsearchfloydMatrix::scale(self : GraphsearchfloydMatrix, s : Double) -> GraphsearchfloydMatrix {
  let result = graph_search_floyd_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn GraphsearchfloydMatrix::multiply(self : GraphsearchfloydMatrix, other : GraphsearchfloydMatrix) -> GraphsearchfloydMatrix {
  if self.cols != other.rows { return graph_search_floyd_make_matrix(self.rows, other.cols, 0.0) }
  let result = graph_search_floyd_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn GraphsearchfloydMatrix::trace(self : GraphsearchfloydMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn GraphsearchfloydMatrix::det(self : GraphsearchfloydMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn GraphsearchfloydMatrix::norm(self : GraphsearchfloydMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn GraphsearchfloydMatrix::to_string(self : GraphsearchfloydMatrix) -> String {
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

pub(all) struct GraphsearchfloydVector {
  comps : Array[Double]
  dim : Int
}

pub fn graph_search_floyd_make_vector(comps : Array[Double]) -> GraphsearchfloydVector {
  { comps, dim: comps.length() }
}

pub fn graph_search_floyd_vector_zero(dim : Int) -> GraphsearchfloydVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn GraphsearchfloydVector::add(self : GraphsearchfloydVector, other : GraphsearchfloydVector) -> GraphsearchfloydVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn GraphsearchfloydVector::sub(self : GraphsearchfloydVector, other : GraphsearchfloydVector) -> GraphsearchfloydVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn GraphsearchfloydVector::scale(self : GraphsearchfloydVector, s : Double) -> GraphsearchfloydVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn GraphsearchfloydVector::dot(self : GraphsearchfloydVector, other : GraphsearchfloydVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn GraphsearchfloydVector::norm(self : GraphsearchfloydVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn GraphsearchfloydVector::normalize(self : GraphsearchfloydVector) -> GraphsearchfloydVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn GraphsearchfloydVector::dist(self : GraphsearchfloydVector, other : GraphsearchfloydVector) -> Double {
  self.sub(other).norm()
}

pub fn GraphsearchfloydVector::to_string(self : GraphsearchfloydVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn graph_search_floyd_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn graph_search_floyd_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn graph_search_floyd_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn graph_search_floyd_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn graph_search_floyd_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn graph_search_floyd_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn graph_search_floyd_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn graph_search_floyd_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn graph_search_floyd_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn graph_search_floyd_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn graph_search_floyd_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn graph_search_floyd_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn graph_search_floyd_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn graph_search_floyd_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn graph_search_floyd_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn graph_search_floyd_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn graph_search_floyd_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn graph_search_floyd_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn graph_search_floyd_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn graph_search_floyd_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn graph_search_floyd_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn graph_search_floyd_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn graph_search_floyd_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn graph_search_floyd_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn graph_search_floyd_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn graph_search_floyd_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn graph_search_floyd_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn graph_search_floyd_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn graph_search_floyd_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct GraphsearchfloydFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_search_floyd_frame_make(size : Int) -> GraphsearchfloydFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_search_floyd_frame_len(s : GraphsearchfloydFrame) -> Int { s.size }

pub fn graph_search_floyd_frame_get(s : GraphsearchfloydFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_search_floyd_frame_set(s : GraphsearchfloydFrame, i : Int, v : Double) -> GraphsearchfloydFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_search_floyd_frame_sum(s : GraphsearchfloydFrame) -> Double { @_common.sum(s.data) }

pub fn graph_search_floyd_frame_mean(s : GraphsearchfloydFrame) -> Double { @_common.mean(s.data) }

pub fn graph_search_floyd_frame_scale(s : GraphsearchfloydFrame, f : Double) -> GraphsearchfloydFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_search_floyd_frame_add(a : GraphsearchfloydFrame, b : GraphsearchfloydFrame) -> GraphsearchfloydFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_search_floyd_frame_copy(s : GraphsearchfloydFrame) -> GraphsearchfloydFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_search_floyd_frame_fill(s : GraphsearchfloydFrame, v : Double) -> GraphsearchfloydFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_search_floyd_frame_min(s : GraphsearchfloydFrame) -> Double { @_common.min(s.data) }

pub fn graph_search_floyd_frame_max(s : GraphsearchfloydFrame) -> Double { @_common.max(s.data) }

pub fn graph_search_floyd_frame_to_string(s : GraphsearchfloydFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphsearchfloydTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_search_floyd_table_make(size : Int) -> GraphsearchfloydTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_search_floyd_table_len(s : GraphsearchfloydTable) -> Int { s.size }

pub fn graph_search_floyd_table_get(s : GraphsearchfloydTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_search_floyd_table_set(s : GraphsearchfloydTable, i : Int, v : Double) -> GraphsearchfloydTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_search_floyd_table_sum(s : GraphsearchfloydTable) -> Double { @_common.sum(s.data) }

pub fn graph_search_floyd_table_mean(s : GraphsearchfloydTable) -> Double { @_common.mean(s.data) }

pub fn graph_search_floyd_table_scale(s : GraphsearchfloydTable, f : Double) -> GraphsearchfloydTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_search_floyd_table_add(a : GraphsearchfloydTable, b : GraphsearchfloydTable) -> GraphsearchfloydTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_search_floyd_table_copy(s : GraphsearchfloydTable) -> GraphsearchfloydTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_search_floyd_table_fill(s : GraphsearchfloydTable, v : Double) -> GraphsearchfloydTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_search_floyd_table_min(s : GraphsearchfloydTable) -> Double { @_common.min(s.data) }

pub fn graph_search_floyd_table_max(s : GraphsearchfloydTable) -> Double { @_common.max(s.data) }

pub fn graph_search_floyd_table_to_string(s : GraphsearchfloydTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphsearchfloydGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_search_floyd_graphn_make(size : Int) -> GraphsearchfloydGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_search_floyd_graphn_len(s : GraphsearchfloydGraphN) -> Int { s.size }

pub fn graph_search_floyd_graphn_get(s : GraphsearchfloydGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_search_floyd_graphn_set(s : GraphsearchfloydGraphN, i : Int, v : Double) -> GraphsearchfloydGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_search_floyd_graphn_sum(s : GraphsearchfloydGraphN) -> Double { @_common.sum(s.data) }

pub fn graph_search_floyd_graphn_mean(s : GraphsearchfloydGraphN) -> Double { @_common.mean(s.data) }

pub fn graph_search_floyd_graphn_scale(s : GraphsearchfloydGraphN, f : Double) -> GraphsearchfloydGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_search_floyd_graphn_add(a : GraphsearchfloydGraphN, b : GraphsearchfloydGraphN) -> GraphsearchfloydGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_search_floyd_graphn_copy(s : GraphsearchfloydGraphN) -> GraphsearchfloydGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_search_floyd_graphn_fill(s : GraphsearchfloydGraphN, v : Double) -> GraphsearchfloydGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_search_floyd_graphn_min(s : GraphsearchfloydGraphN) -> Double { @_common.min(s.data) }

pub fn graph_search_floyd_graphn_max(s : GraphsearchfloydGraphN) -> Double { @_common.max(s.data) }

pub fn graph_search_floyd_graphn_to_string(s : GraphsearchfloydGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphsearchfloydNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_search_floyd_node_make(size : Int) -> GraphsearchfloydNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_search_floyd_node_len(s : GraphsearchfloydNode) -> Int { s.size }

pub fn graph_search_floyd_node_get(s : GraphsearchfloydNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_search_floyd_node_set(s : GraphsearchfloydNode, i : Int, v : Double) -> GraphsearchfloydNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_search_floyd_node_sum(s : GraphsearchfloydNode) -> Double { @_common.sum(s.data) }

pub fn graph_search_floyd_node_mean(s : GraphsearchfloydNode) -> Double { @_common.mean(s.data) }

pub fn graph_search_floyd_node_scale(s : GraphsearchfloydNode, f : Double) -> GraphsearchfloydNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_search_floyd_node_add(a : GraphsearchfloydNode, b : GraphsearchfloydNode) -> GraphsearchfloydNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_search_floyd_node_copy(s : GraphsearchfloydNode) -> GraphsearchfloydNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_search_floyd_node_fill(s : GraphsearchfloydNode, v : Double) -> GraphsearchfloydNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_search_floyd_node_min(s : GraphsearchfloydNode) -> Double { @_common.min(s.data) }

pub fn graph_search_floyd_node_max(s : GraphsearchfloydNode) -> Double { @_common.max(s.data) }

pub fn graph_search_floyd_node_to_string(s : GraphsearchfloydNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphsearchfloydEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_search_floyd_edge_make(size : Int) -> GraphsearchfloydEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_search_floyd_edge_len(s : GraphsearchfloydEdge) -> Int { s.size }

pub fn graph_search_floyd_edge_get(s : GraphsearchfloydEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_search_floyd_edge_set(s : GraphsearchfloydEdge, i : Int, v : Double) -> GraphsearchfloydEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_search_floyd_edge_sum(s : GraphsearchfloydEdge) -> Double { @_common.sum(s.data) }

pub fn graph_search_floyd_edge_mean(s : GraphsearchfloydEdge) -> Double { @_common.mean(s.data) }

pub fn graph_search_floyd_edge_scale(s : GraphsearchfloydEdge, f : Double) -> GraphsearchfloydEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_search_floyd_edge_add(a : GraphsearchfloydEdge, b : GraphsearchfloydEdge) -> GraphsearchfloydEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_search_floyd_edge_copy(s : GraphsearchfloydEdge) -> GraphsearchfloydEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_search_floyd_edge_fill(s : GraphsearchfloydEdge, v : Double) -> GraphsearchfloydEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_search_floyd_edge_min(s : GraphsearchfloydEdge) -> Double { @_common.min(s.data) }

pub fn graph_search_floyd_edge_max(s : GraphsearchfloydEdge) -> Double { @_common.max(s.data) }

pub fn graph_search_floyd_edge_to_string(s : GraphsearchfloydEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphsearchfloydPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_search_floyd_path_make(size : Int) -> GraphsearchfloydPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_search_floyd_path_len(s : GraphsearchfloydPath) -> Int { s.size }

pub fn graph_search_floyd_path_get(s : GraphsearchfloydPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_search_floyd_path_set(s : GraphsearchfloydPath, i : Int, v : Double) -> GraphsearchfloydPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_search_floyd_path_sum(s : GraphsearchfloydPath) -> Double { @_common.sum(s.data) }

pub fn graph_search_floyd_path_mean(s : GraphsearchfloydPath) -> Double { @_common.mean(s.data) }

pub fn graph_search_floyd_path_scale(s : GraphsearchfloydPath, f : Double) -> GraphsearchfloydPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_search_floyd_path_add(a : GraphsearchfloydPath, b : GraphsearchfloydPath) -> GraphsearchfloydPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_search_floyd_path_copy(s : GraphsearchfloydPath) -> GraphsearchfloydPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_search_floyd_path_fill(s : GraphsearchfloydPath, v : Double) -> GraphsearchfloydPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_search_floyd_path_min(s : GraphsearchfloydPath) -> Double { @_common.min(s.data) }

pub fn graph_search_floyd_path_max(s : GraphsearchfloydPath) -> Double { @_common.max(s.data) }

pub fn graph_search_floyd_path_to_string(s : GraphsearchfloydPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphsearchfloydCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_search_floyd_cluster_make(size : Int) -> GraphsearchfloydCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_search_floyd_cluster_len(s : GraphsearchfloydCluster) -> Int { s.size }

pub fn graph_search_floyd_cluster_get(s : GraphsearchfloydCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_search_floyd_cluster_set(s : GraphsearchfloydCluster, i : Int, v : Double) -> GraphsearchfloydCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_search_floyd_cluster_sum(s : GraphsearchfloydCluster) -> Double { @_common.sum(s.data) }

pub fn graph_search_floyd_cluster_mean(s : GraphsearchfloydCluster) -> Double { @_common.mean(s.data) }

pub fn graph_search_floyd_cluster_scale(s : GraphsearchfloydCluster, f : Double) -> GraphsearchfloydCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_search_floyd_cluster_add(a : GraphsearchfloydCluster, b : GraphsearchfloydCluster) -> GraphsearchfloydCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_search_floyd_cluster_copy(s : GraphsearchfloydCluster) -> GraphsearchfloydCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_search_floyd_cluster_fill(s : GraphsearchfloydCluster, v : Double) -> GraphsearchfloydCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_search_floyd_cluster_min(s : GraphsearchfloydCluster) -> Double { @_common.min(s.data) }

pub fn graph_search_floyd_cluster_max(s : GraphsearchfloydCluster) -> Double { @_common.max(s.data) }

pub fn graph_search_floyd_cluster_to_string(s : GraphsearchfloydCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphsearchfloydModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_search_floyd_model_make(size : Int) -> GraphsearchfloydModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_search_floyd_model_len(s : GraphsearchfloydModel) -> Int { s.size }

pub fn graph_search_floyd_model_get(s : GraphsearchfloydModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_search_floyd_model_set(s : GraphsearchfloydModel, i : Int, v : Double) -> GraphsearchfloydModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_search_floyd_model_sum(s : GraphsearchfloydModel) -> Double { @_common.sum(s.data) }

pub fn graph_search_floyd_model_mean(s : GraphsearchfloydModel) -> Double { @_common.mean(s.data) }

pub fn graph_search_floyd_model_scale(s : GraphsearchfloydModel, f : Double) -> GraphsearchfloydModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_search_floyd_model_add(a : GraphsearchfloydModel, b : GraphsearchfloydModel) -> GraphsearchfloydModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_search_floyd_model_copy(s : GraphsearchfloydModel) -> GraphsearchfloydModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_search_floyd_model_fill(s : GraphsearchfloydModel, v : Double) -> GraphsearchfloydModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_search_floyd_model_min(s : GraphsearchfloydModel) -> Double { @_common.min(s.data) }

pub fn graph_search_floyd_model_max(s : GraphsearchfloydModel) -> Double { @_common.max(s.data) }

pub fn graph_search_floyd_model_to_string(s : GraphsearchfloydModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphsearchfloydLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_search_floyd_layer_make(size : Int) -> GraphsearchfloydLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_search_floyd_layer_len(s : GraphsearchfloydLayer) -> Int { s.size }

pub fn graph_search_floyd_layer_get(s : GraphsearchfloydLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_search_floyd_layer_set(s : GraphsearchfloydLayer, i : Int, v : Double) -> GraphsearchfloydLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_search_floyd_layer_sum(s : GraphsearchfloydLayer) -> Double { @_common.sum(s.data) }

pub fn graph_search_floyd_layer_mean(s : GraphsearchfloydLayer) -> Double { @_common.mean(s.data) }

pub fn graph_search_floyd_layer_scale(s : GraphsearchfloydLayer, f : Double) -> GraphsearchfloydLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_search_floyd_layer_add(a : GraphsearchfloydLayer, b : GraphsearchfloydLayer) -> GraphsearchfloydLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_search_floyd_layer_copy(s : GraphsearchfloydLayer) -> GraphsearchfloydLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_search_floyd_layer_fill(s : GraphsearchfloydLayer, v : Double) -> GraphsearchfloydLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_search_floyd_layer_min(s : GraphsearchfloydLayer) -> Double { @_common.min(s.data) }

pub fn graph_search_floyd_layer_max(s : GraphsearchfloydLayer) -> Double { @_common.max(s.data) }

pub fn graph_search_floyd_layer_to_string(s : GraphsearchfloydLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphsearchfloydBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_search_floyd_buffer_make(size : Int) -> GraphsearchfloydBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_search_floyd_buffer_len(s : GraphsearchfloydBuffer) -> Int { s.size }

pub fn graph_search_floyd_buffer_get(s : GraphsearchfloydBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_search_floyd_buffer_set(s : GraphsearchfloydBuffer, i : Int, v : Double) -> GraphsearchfloydBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_search_floyd_buffer_sum(s : GraphsearchfloydBuffer) -> Double { @_common.sum(s.data) }

pub fn graph_search_floyd_buffer_mean(s : GraphsearchfloydBuffer) -> Double { @_common.mean(s.data) }

pub fn graph_search_floyd_buffer_scale(s : GraphsearchfloydBuffer, f : Double) -> GraphsearchfloydBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_search_floyd_buffer_add(a : GraphsearchfloydBuffer, b : GraphsearchfloydBuffer) -> GraphsearchfloydBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_search_floyd_buffer_copy(s : GraphsearchfloydBuffer) -> GraphsearchfloydBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_search_floyd_buffer_fill(s : GraphsearchfloydBuffer, v : Double) -> GraphsearchfloydBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_search_floyd_buffer_min(s : GraphsearchfloydBuffer) -> Double { @_common.min(s.data) }

pub fn graph_search_floyd_buffer_max(s : GraphsearchfloydBuffer) -> Double { @_common.max(s.data) }

pub fn graph_search_floyd_buffer_to_string(s : GraphsearchfloydBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphsearchfloydCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_search_floyd_cursor_make(size : Int) -> GraphsearchfloydCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_search_floyd_cursor_len(s : GraphsearchfloydCursor) -> Int { s.size }

pub fn graph_search_floyd_cursor_get(s : GraphsearchfloydCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_search_floyd_cursor_set(s : GraphsearchfloydCursor, i : Int, v : Double) -> GraphsearchfloydCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_search_floyd_cursor_sum(s : GraphsearchfloydCursor) -> Double { @_common.sum(s.data) }

pub fn graph_search_floyd_cursor_mean(s : GraphsearchfloydCursor) -> Double { @_common.mean(s.data) }

pub fn graph_search_floyd_cursor_scale(s : GraphsearchfloydCursor, f : Double) -> GraphsearchfloydCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_search_floyd_cursor_add(a : GraphsearchfloydCursor, b : GraphsearchfloydCursor) -> GraphsearchfloydCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_search_floyd_cursor_copy(s : GraphsearchfloydCursor) -> GraphsearchfloydCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_search_floyd_cursor_fill(s : GraphsearchfloydCursor, v : Double) -> GraphsearchfloydCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_search_floyd_cursor_min(s : GraphsearchfloydCursor) -> Double { @_common.min(s.data) }

pub fn graph_search_floyd_cursor_max(s : GraphsearchfloydCursor) -> Double { @_common.max(s.data) }

pub fn graph_search_floyd_cursor_to_string(s : GraphsearchfloydCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphsearchfloydView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_search_floyd_view_make(size : Int) -> GraphsearchfloydView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_search_floyd_view_len(s : GraphsearchfloydView) -> Int { s.size }

pub fn graph_search_floyd_view_get(s : GraphsearchfloydView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_search_floyd_view_set(s : GraphsearchfloydView, i : Int, v : Double) -> GraphsearchfloydView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_search_floyd_view_sum(s : GraphsearchfloydView) -> Double { @_common.sum(s.data) }

pub fn graph_search_floyd_view_mean(s : GraphsearchfloydView) -> Double { @_common.mean(s.data) }

pub fn graph_search_floyd_view_scale(s : GraphsearchfloydView, f : Double) -> GraphsearchfloydView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_search_floyd_view_add(a : GraphsearchfloydView, b : GraphsearchfloydView) -> GraphsearchfloydView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_search_floyd_view_copy(s : GraphsearchfloydView) -> GraphsearchfloydView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_search_floyd_view_fill(s : GraphsearchfloydView, v : Double) -> GraphsearchfloydView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_search_floyd_view_min(s : GraphsearchfloydView) -> Double { @_common.min(s.data) }

pub fn graph_search_floyd_view_max(s : GraphsearchfloydView) -> Double { @_common.max(s.data) }

pub fn graph_search_floyd_view_to_string(s : GraphsearchfloydView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphsearchfloydRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_search_floyd_range_make(size : Int) -> GraphsearchfloydRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_search_floyd_range_len(s : GraphsearchfloydRange) -> Int { s.size }

pub fn graph_search_floyd_range_get(s : GraphsearchfloydRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_search_floyd_range_set(s : GraphsearchfloydRange, i : Int, v : Double) -> GraphsearchfloydRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_search_floyd_range_sum(s : GraphsearchfloydRange) -> Double { @_common.sum(s.data) }

pub fn graph_search_floyd_range_mean(s : GraphsearchfloydRange) -> Double { @_common.mean(s.data) }

pub fn graph_search_floyd_range_scale(s : GraphsearchfloydRange, f : Double) -> GraphsearchfloydRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_search_floyd_range_add(a : GraphsearchfloydRange, b : GraphsearchfloydRange) -> GraphsearchfloydRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_search_floyd_range_copy(s : GraphsearchfloydRange) -> GraphsearchfloydRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_search_floyd_range_fill(s : GraphsearchfloydRange, v : Double) -> GraphsearchfloydRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_search_floyd_range_min(s : GraphsearchfloydRange) -> Double { @_common.min(s.data) }

pub fn graph_search_floyd_range_max(s : GraphsearchfloydRange) -> Double { @_common.max(s.data) }

pub fn graph_search_floyd_range_to_string(s : GraphsearchfloydRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphsearchfloydSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_search_floyd_slice_make(size : Int) -> GraphsearchfloydSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_search_floyd_slice_len(s : GraphsearchfloydSlice) -> Int { s.size }

pub fn graph_search_floyd_slice_get(s : GraphsearchfloydSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_search_floyd_slice_set(s : GraphsearchfloydSlice, i : Int, v : Double) -> GraphsearchfloydSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_search_floyd_slice_sum(s : GraphsearchfloydSlice) -> Double { @_common.sum(s.data) }

pub fn graph_search_floyd_slice_mean(s : GraphsearchfloydSlice) -> Double { @_common.mean(s.data) }

pub fn graph_search_floyd_slice_scale(s : GraphsearchfloydSlice, f : Double) -> GraphsearchfloydSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_search_floyd_slice_add(a : GraphsearchfloydSlice, b : GraphsearchfloydSlice) -> GraphsearchfloydSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_search_floyd_slice_copy(s : GraphsearchfloydSlice) -> GraphsearchfloydSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_search_floyd_slice_fill(s : GraphsearchfloydSlice, v : Double) -> GraphsearchfloydSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_search_floyd_slice_min(s : GraphsearchfloydSlice) -> Double { @_common.min(s.data) }

pub fn graph_search_floyd_slice_max(s : GraphsearchfloydSlice) -> Double { @_common.max(s.data) }

pub fn graph_search_floyd_slice_to_string(s : GraphsearchfloydSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

