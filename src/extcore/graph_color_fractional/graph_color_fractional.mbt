///===
/// extcore/graph_color_fractional

pub(all) struct GraphcolorfractionalPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn graph_color_fractional_make_point(x : Double, y : Double) -> GraphcolorfractionalPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn graph_color_fractional_make_point3(x : Double, y : Double, z : Double) -> GraphcolorfractionalPoint {
  { x, y, z, label: 0 }
}

pub fn GraphcolorfractionalPoint::x(self : GraphcolorfractionalPoint) -> Double { self.x }

pub fn GraphcolorfractionalPoint::y(self : GraphcolorfractionalPoint) -> Double { self.y }

pub fn GraphcolorfractionalPoint::z(self : GraphcolorfractionalPoint) -> Double { self.z }

pub fn GraphcolorfractionalPoint::label(self : GraphcolorfractionalPoint) -> Int { self.label }

pub fn GraphcolorfractionalPoint::dist(self : GraphcolorfractionalPoint, other : GraphcolorfractionalPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn GraphcolorfractionalPoint::add(self : GraphcolorfractionalPoint, other : GraphcolorfractionalPoint) -> GraphcolorfractionalPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn GraphcolorfractionalPoint::sub(self : GraphcolorfractionalPoint, other : GraphcolorfractionalPoint) -> GraphcolorfractionalPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn GraphcolorfractionalPoint::scale(self : GraphcolorfractionalPoint, s : Double) -> GraphcolorfractionalPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn GraphcolorfractionalPoint::dot(self : GraphcolorfractionalPoint, other : GraphcolorfractionalPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn GraphcolorfractionalPoint::cross(self : GraphcolorfractionalPoint, other : GraphcolorfractionalPoint) -> GraphcolorfractionalPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn GraphcolorfractionalPoint::norm(self : GraphcolorfractionalPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn GraphcolorfractionalPoint::normalize(self : GraphcolorfractionalPoint) -> GraphcolorfractionalPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn GraphcolorfractionalPoint::negate(self : GraphcolorfractionalPoint) -> GraphcolorfractionalPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn GraphcolorfractionalPoint::mid(self : GraphcolorfractionalPoint, other : GraphcolorfractionalPoint) -> GraphcolorfractionalPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn GraphcolorfractionalPoint::lerp(self : GraphcolorfractionalPoint, other : GraphcolorfractionalPoint, t : Double) -> GraphcolorfractionalPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn GraphcolorfractionalPoint::to_string(self : GraphcolorfractionalPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct GraphcolorfractionalSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn graph_color_fractional_make_series(vals : Array[Double], name : String) -> GraphcolorfractionalSeries {
  { vals, name, meta: 0 }
}

pub fn GraphcolorfractionalSeries::len(self : GraphcolorfractionalSeries) -> Int { self.vals.length() }

pub fn GraphcolorfractionalSeries::sum(self : GraphcolorfractionalSeries) -> Double { @_common.sum(self.vals) }

pub fn GraphcolorfractionalSeries::mean(self : GraphcolorfractionalSeries) -> Double { @_common.mean(self.vals) }

pub fn GraphcolorfractionalSeries::min(self : GraphcolorfractionalSeries) -> Double { @_common.min(self.vals) }

pub fn GraphcolorfractionalSeries::max(self : GraphcolorfractionalSeries) -> Double { @_common.max(self.vals) }

pub fn GraphcolorfractionalSeries::range(self : GraphcolorfractionalSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn GraphcolorfractionalSeries::variance(self : GraphcolorfractionalSeries) -> Double { @_common.variance(self.vals) }

pub fn GraphcolorfractionalSeries::std(self : GraphcolorfractionalSeries) -> Double { @_common.std(self.vals) }

pub fn GraphcolorfractionalSeries::median(self : GraphcolorfractionalSeries) -> Double { @_common.median(self.vals) }

pub fn GraphcolorfractionalSeries::scale(self : GraphcolorfractionalSeries, f : Double) -> GraphcolorfractionalSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn GraphcolorfractionalSeries::add(self : GraphcolorfractionalSeries, other : GraphcolorfractionalSeries) -> GraphcolorfractionalSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn GraphcolorfractionalSeries::sub(self : GraphcolorfractionalSeries, other : GraphcolorfractionalSeries) -> GraphcolorfractionalSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn GraphcolorfractionalSeries::normalize(self : GraphcolorfractionalSeries) -> GraphcolorfractionalSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn GraphcolorfractionalSeries::cumsum(self : GraphcolorfractionalSeries) -> GraphcolorfractionalSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn GraphcolorfractionalSeries::to_string(self : GraphcolorfractionalSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct GraphcolorfractionalMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn graph_color_fractional_make_matrix(rows : Int, cols : Int, val : Double) -> GraphcolorfractionalMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn graph_color_fractional_matrix_identity(n : Int) -> GraphcolorfractionalMatrix {
  let m = graph_color_fractional_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn GraphcolorfractionalMatrix::get(self : GraphcolorfractionalMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn GraphcolorfractionalMatrix::transpose(self : GraphcolorfractionalMatrix) -> GraphcolorfractionalMatrix {
  let result = graph_color_fractional_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn GraphcolorfractionalMatrix::add(self : GraphcolorfractionalMatrix, other : GraphcolorfractionalMatrix) -> GraphcolorfractionalMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = graph_color_fractional_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn GraphcolorfractionalMatrix::scale(self : GraphcolorfractionalMatrix, s : Double) -> GraphcolorfractionalMatrix {
  let result = graph_color_fractional_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn GraphcolorfractionalMatrix::multiply(self : GraphcolorfractionalMatrix, other : GraphcolorfractionalMatrix) -> GraphcolorfractionalMatrix {
  if self.cols != other.rows { return graph_color_fractional_make_matrix(self.rows, other.cols, 0.0) }
  let result = graph_color_fractional_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn GraphcolorfractionalMatrix::trace(self : GraphcolorfractionalMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn GraphcolorfractionalMatrix::det(self : GraphcolorfractionalMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn GraphcolorfractionalMatrix::norm(self : GraphcolorfractionalMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn GraphcolorfractionalMatrix::to_string(self : GraphcolorfractionalMatrix) -> String {
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

pub(all) struct GraphcolorfractionalVector {
  comps : Array[Double]
  dim : Int
}

pub fn graph_color_fractional_make_vector(comps : Array[Double]) -> GraphcolorfractionalVector {
  { comps, dim: comps.length() }
}

pub fn graph_color_fractional_vector_zero(dim : Int) -> GraphcolorfractionalVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn GraphcolorfractionalVector::add(self : GraphcolorfractionalVector, other : GraphcolorfractionalVector) -> GraphcolorfractionalVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn GraphcolorfractionalVector::sub(self : GraphcolorfractionalVector, other : GraphcolorfractionalVector) -> GraphcolorfractionalVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn GraphcolorfractionalVector::scale(self : GraphcolorfractionalVector, s : Double) -> GraphcolorfractionalVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn GraphcolorfractionalVector::dot(self : GraphcolorfractionalVector, other : GraphcolorfractionalVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn GraphcolorfractionalVector::norm(self : GraphcolorfractionalVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn GraphcolorfractionalVector::normalize(self : GraphcolorfractionalVector) -> GraphcolorfractionalVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn GraphcolorfractionalVector::dist(self : GraphcolorfractionalVector, other : GraphcolorfractionalVector) -> Double {
  self.sub(other).norm()
}

pub fn GraphcolorfractionalVector::to_string(self : GraphcolorfractionalVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn graph_color_fractional_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn graph_color_fractional_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn graph_color_fractional_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn graph_color_fractional_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn graph_color_fractional_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn graph_color_fractional_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn graph_color_fractional_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn graph_color_fractional_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn graph_color_fractional_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn graph_color_fractional_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn graph_color_fractional_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn graph_color_fractional_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn graph_color_fractional_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn graph_color_fractional_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn graph_color_fractional_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn graph_color_fractional_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn graph_color_fractional_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn graph_color_fractional_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn graph_color_fractional_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn graph_color_fractional_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn graph_color_fractional_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn graph_color_fractional_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn graph_color_fractional_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn graph_color_fractional_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn graph_color_fractional_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn graph_color_fractional_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn graph_color_fractional_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn graph_color_fractional_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn graph_color_fractional_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct GraphcolorfractionalFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_color_fractional_frame_make(size : Int) -> GraphcolorfractionalFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_color_fractional_frame_len(s : GraphcolorfractionalFrame) -> Int { s.size }

pub fn graph_color_fractional_frame_get(s : GraphcolorfractionalFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_color_fractional_frame_set(s : GraphcolorfractionalFrame, i : Int, v : Double) -> GraphcolorfractionalFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_color_fractional_frame_sum(s : GraphcolorfractionalFrame) -> Double { @_common.sum(s.data) }

pub fn graph_color_fractional_frame_mean(s : GraphcolorfractionalFrame) -> Double { @_common.mean(s.data) }

pub fn graph_color_fractional_frame_scale(s : GraphcolorfractionalFrame, f : Double) -> GraphcolorfractionalFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_color_fractional_frame_add(a : GraphcolorfractionalFrame, b : GraphcolorfractionalFrame) -> GraphcolorfractionalFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_color_fractional_frame_copy(s : GraphcolorfractionalFrame) -> GraphcolorfractionalFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_color_fractional_frame_fill(s : GraphcolorfractionalFrame, v : Double) -> GraphcolorfractionalFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_color_fractional_frame_min(s : GraphcolorfractionalFrame) -> Double { @_common.min(s.data) }

pub fn graph_color_fractional_frame_max(s : GraphcolorfractionalFrame) -> Double { @_common.max(s.data) }

pub fn graph_color_fractional_frame_to_string(s : GraphcolorfractionalFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphcolorfractionalTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_color_fractional_table_make(size : Int) -> GraphcolorfractionalTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_color_fractional_table_len(s : GraphcolorfractionalTable) -> Int { s.size }

pub fn graph_color_fractional_table_get(s : GraphcolorfractionalTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_color_fractional_table_set(s : GraphcolorfractionalTable, i : Int, v : Double) -> GraphcolorfractionalTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_color_fractional_table_sum(s : GraphcolorfractionalTable) -> Double { @_common.sum(s.data) }

pub fn graph_color_fractional_table_mean(s : GraphcolorfractionalTable) -> Double { @_common.mean(s.data) }

pub fn graph_color_fractional_table_scale(s : GraphcolorfractionalTable, f : Double) -> GraphcolorfractionalTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_color_fractional_table_add(a : GraphcolorfractionalTable, b : GraphcolorfractionalTable) -> GraphcolorfractionalTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_color_fractional_table_copy(s : GraphcolorfractionalTable) -> GraphcolorfractionalTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_color_fractional_table_fill(s : GraphcolorfractionalTable, v : Double) -> GraphcolorfractionalTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_color_fractional_table_min(s : GraphcolorfractionalTable) -> Double { @_common.min(s.data) }

pub fn graph_color_fractional_table_max(s : GraphcolorfractionalTable) -> Double { @_common.max(s.data) }

pub fn graph_color_fractional_table_to_string(s : GraphcolorfractionalTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphcolorfractionalGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_color_fractional_graphn_make(size : Int) -> GraphcolorfractionalGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_color_fractional_graphn_len(s : GraphcolorfractionalGraphN) -> Int { s.size }

pub fn graph_color_fractional_graphn_get(s : GraphcolorfractionalGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_color_fractional_graphn_set(s : GraphcolorfractionalGraphN, i : Int, v : Double) -> GraphcolorfractionalGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_color_fractional_graphn_sum(s : GraphcolorfractionalGraphN) -> Double { @_common.sum(s.data) }

pub fn graph_color_fractional_graphn_mean(s : GraphcolorfractionalGraphN) -> Double { @_common.mean(s.data) }

pub fn graph_color_fractional_graphn_scale(s : GraphcolorfractionalGraphN, f : Double) -> GraphcolorfractionalGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_color_fractional_graphn_add(a : GraphcolorfractionalGraphN, b : GraphcolorfractionalGraphN) -> GraphcolorfractionalGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_color_fractional_graphn_copy(s : GraphcolorfractionalGraphN) -> GraphcolorfractionalGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_color_fractional_graphn_fill(s : GraphcolorfractionalGraphN, v : Double) -> GraphcolorfractionalGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_color_fractional_graphn_min(s : GraphcolorfractionalGraphN) -> Double { @_common.min(s.data) }

pub fn graph_color_fractional_graphn_max(s : GraphcolorfractionalGraphN) -> Double { @_common.max(s.data) }

pub fn graph_color_fractional_graphn_to_string(s : GraphcolorfractionalGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphcolorfractionalNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_color_fractional_node_make(size : Int) -> GraphcolorfractionalNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_color_fractional_node_len(s : GraphcolorfractionalNode) -> Int { s.size }

pub fn graph_color_fractional_node_get(s : GraphcolorfractionalNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_color_fractional_node_set(s : GraphcolorfractionalNode, i : Int, v : Double) -> GraphcolorfractionalNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_color_fractional_node_sum(s : GraphcolorfractionalNode) -> Double { @_common.sum(s.data) }

pub fn graph_color_fractional_node_mean(s : GraphcolorfractionalNode) -> Double { @_common.mean(s.data) }

pub fn graph_color_fractional_node_scale(s : GraphcolorfractionalNode, f : Double) -> GraphcolorfractionalNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_color_fractional_node_add(a : GraphcolorfractionalNode, b : GraphcolorfractionalNode) -> GraphcolorfractionalNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_color_fractional_node_copy(s : GraphcolorfractionalNode) -> GraphcolorfractionalNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_color_fractional_node_fill(s : GraphcolorfractionalNode, v : Double) -> GraphcolorfractionalNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_color_fractional_node_min(s : GraphcolorfractionalNode) -> Double { @_common.min(s.data) }

pub fn graph_color_fractional_node_max(s : GraphcolorfractionalNode) -> Double { @_common.max(s.data) }

pub fn graph_color_fractional_node_to_string(s : GraphcolorfractionalNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphcolorfractionalEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_color_fractional_edge_make(size : Int) -> GraphcolorfractionalEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_color_fractional_edge_len(s : GraphcolorfractionalEdge) -> Int { s.size }

pub fn graph_color_fractional_edge_get(s : GraphcolorfractionalEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_color_fractional_edge_set(s : GraphcolorfractionalEdge, i : Int, v : Double) -> GraphcolorfractionalEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_color_fractional_edge_sum(s : GraphcolorfractionalEdge) -> Double { @_common.sum(s.data) }

pub fn graph_color_fractional_edge_mean(s : GraphcolorfractionalEdge) -> Double { @_common.mean(s.data) }

pub fn graph_color_fractional_edge_scale(s : GraphcolorfractionalEdge, f : Double) -> GraphcolorfractionalEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_color_fractional_edge_add(a : GraphcolorfractionalEdge, b : GraphcolorfractionalEdge) -> GraphcolorfractionalEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_color_fractional_edge_copy(s : GraphcolorfractionalEdge) -> GraphcolorfractionalEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_color_fractional_edge_fill(s : GraphcolorfractionalEdge, v : Double) -> GraphcolorfractionalEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_color_fractional_edge_min(s : GraphcolorfractionalEdge) -> Double { @_common.min(s.data) }

pub fn graph_color_fractional_edge_max(s : GraphcolorfractionalEdge) -> Double { @_common.max(s.data) }

pub fn graph_color_fractional_edge_to_string(s : GraphcolorfractionalEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphcolorfractionalPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_color_fractional_path_make(size : Int) -> GraphcolorfractionalPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_color_fractional_path_len(s : GraphcolorfractionalPath) -> Int { s.size }

pub fn graph_color_fractional_path_get(s : GraphcolorfractionalPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_color_fractional_path_set(s : GraphcolorfractionalPath, i : Int, v : Double) -> GraphcolorfractionalPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_color_fractional_path_sum(s : GraphcolorfractionalPath) -> Double { @_common.sum(s.data) }

pub fn graph_color_fractional_path_mean(s : GraphcolorfractionalPath) -> Double { @_common.mean(s.data) }

pub fn graph_color_fractional_path_scale(s : GraphcolorfractionalPath, f : Double) -> GraphcolorfractionalPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_color_fractional_path_add(a : GraphcolorfractionalPath, b : GraphcolorfractionalPath) -> GraphcolorfractionalPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_color_fractional_path_copy(s : GraphcolorfractionalPath) -> GraphcolorfractionalPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_color_fractional_path_fill(s : GraphcolorfractionalPath, v : Double) -> GraphcolorfractionalPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_color_fractional_path_min(s : GraphcolorfractionalPath) -> Double { @_common.min(s.data) }

pub fn graph_color_fractional_path_max(s : GraphcolorfractionalPath) -> Double { @_common.max(s.data) }

pub fn graph_color_fractional_path_to_string(s : GraphcolorfractionalPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphcolorfractionalCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_color_fractional_cluster_make(size : Int) -> GraphcolorfractionalCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_color_fractional_cluster_len(s : GraphcolorfractionalCluster) -> Int { s.size }

pub fn graph_color_fractional_cluster_get(s : GraphcolorfractionalCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_color_fractional_cluster_set(s : GraphcolorfractionalCluster, i : Int, v : Double) -> GraphcolorfractionalCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_color_fractional_cluster_sum(s : GraphcolorfractionalCluster) -> Double { @_common.sum(s.data) }

pub fn graph_color_fractional_cluster_mean(s : GraphcolorfractionalCluster) -> Double { @_common.mean(s.data) }

pub fn graph_color_fractional_cluster_scale(s : GraphcolorfractionalCluster, f : Double) -> GraphcolorfractionalCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_color_fractional_cluster_add(a : GraphcolorfractionalCluster, b : GraphcolorfractionalCluster) -> GraphcolorfractionalCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_color_fractional_cluster_copy(s : GraphcolorfractionalCluster) -> GraphcolorfractionalCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_color_fractional_cluster_fill(s : GraphcolorfractionalCluster, v : Double) -> GraphcolorfractionalCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_color_fractional_cluster_min(s : GraphcolorfractionalCluster) -> Double { @_common.min(s.data) }

pub fn graph_color_fractional_cluster_max(s : GraphcolorfractionalCluster) -> Double { @_common.max(s.data) }

pub fn graph_color_fractional_cluster_to_string(s : GraphcolorfractionalCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphcolorfractionalModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_color_fractional_model_make(size : Int) -> GraphcolorfractionalModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_color_fractional_model_len(s : GraphcolorfractionalModel) -> Int { s.size }

pub fn graph_color_fractional_model_get(s : GraphcolorfractionalModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_color_fractional_model_set(s : GraphcolorfractionalModel, i : Int, v : Double) -> GraphcolorfractionalModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_color_fractional_model_sum(s : GraphcolorfractionalModel) -> Double { @_common.sum(s.data) }

pub fn graph_color_fractional_model_mean(s : GraphcolorfractionalModel) -> Double { @_common.mean(s.data) }

pub fn graph_color_fractional_model_scale(s : GraphcolorfractionalModel, f : Double) -> GraphcolorfractionalModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_color_fractional_model_add(a : GraphcolorfractionalModel, b : GraphcolorfractionalModel) -> GraphcolorfractionalModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_color_fractional_model_copy(s : GraphcolorfractionalModel) -> GraphcolorfractionalModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_color_fractional_model_fill(s : GraphcolorfractionalModel, v : Double) -> GraphcolorfractionalModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_color_fractional_model_min(s : GraphcolorfractionalModel) -> Double { @_common.min(s.data) }

pub fn graph_color_fractional_model_max(s : GraphcolorfractionalModel) -> Double { @_common.max(s.data) }

pub fn graph_color_fractional_model_to_string(s : GraphcolorfractionalModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphcolorfractionalLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_color_fractional_layer_make(size : Int) -> GraphcolorfractionalLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_color_fractional_layer_len(s : GraphcolorfractionalLayer) -> Int { s.size }

pub fn graph_color_fractional_layer_get(s : GraphcolorfractionalLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_color_fractional_layer_set(s : GraphcolorfractionalLayer, i : Int, v : Double) -> GraphcolorfractionalLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_color_fractional_layer_sum(s : GraphcolorfractionalLayer) -> Double { @_common.sum(s.data) }

pub fn graph_color_fractional_layer_mean(s : GraphcolorfractionalLayer) -> Double { @_common.mean(s.data) }

pub fn graph_color_fractional_layer_scale(s : GraphcolorfractionalLayer, f : Double) -> GraphcolorfractionalLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_color_fractional_layer_add(a : GraphcolorfractionalLayer, b : GraphcolorfractionalLayer) -> GraphcolorfractionalLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_color_fractional_layer_copy(s : GraphcolorfractionalLayer) -> GraphcolorfractionalLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_color_fractional_layer_fill(s : GraphcolorfractionalLayer, v : Double) -> GraphcolorfractionalLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_color_fractional_layer_min(s : GraphcolorfractionalLayer) -> Double { @_common.min(s.data) }

pub fn graph_color_fractional_layer_max(s : GraphcolorfractionalLayer) -> Double { @_common.max(s.data) }

pub fn graph_color_fractional_layer_to_string(s : GraphcolorfractionalLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphcolorfractionalBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_color_fractional_buffer_make(size : Int) -> GraphcolorfractionalBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_color_fractional_buffer_len(s : GraphcolorfractionalBuffer) -> Int { s.size }

pub fn graph_color_fractional_buffer_get(s : GraphcolorfractionalBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_color_fractional_buffer_set(s : GraphcolorfractionalBuffer, i : Int, v : Double) -> GraphcolorfractionalBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_color_fractional_buffer_sum(s : GraphcolorfractionalBuffer) -> Double { @_common.sum(s.data) }

pub fn graph_color_fractional_buffer_mean(s : GraphcolorfractionalBuffer) -> Double { @_common.mean(s.data) }

pub fn graph_color_fractional_buffer_scale(s : GraphcolorfractionalBuffer, f : Double) -> GraphcolorfractionalBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_color_fractional_buffer_add(a : GraphcolorfractionalBuffer, b : GraphcolorfractionalBuffer) -> GraphcolorfractionalBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_color_fractional_buffer_copy(s : GraphcolorfractionalBuffer) -> GraphcolorfractionalBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_color_fractional_buffer_fill(s : GraphcolorfractionalBuffer, v : Double) -> GraphcolorfractionalBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_color_fractional_buffer_min(s : GraphcolorfractionalBuffer) -> Double { @_common.min(s.data) }

pub fn graph_color_fractional_buffer_max(s : GraphcolorfractionalBuffer) -> Double { @_common.max(s.data) }

pub fn graph_color_fractional_buffer_to_string(s : GraphcolorfractionalBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphcolorfractionalCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_color_fractional_cursor_make(size : Int) -> GraphcolorfractionalCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_color_fractional_cursor_len(s : GraphcolorfractionalCursor) -> Int { s.size }

pub fn graph_color_fractional_cursor_get(s : GraphcolorfractionalCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_color_fractional_cursor_set(s : GraphcolorfractionalCursor, i : Int, v : Double) -> GraphcolorfractionalCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_color_fractional_cursor_sum(s : GraphcolorfractionalCursor) -> Double { @_common.sum(s.data) }

pub fn graph_color_fractional_cursor_mean(s : GraphcolorfractionalCursor) -> Double { @_common.mean(s.data) }

pub fn graph_color_fractional_cursor_scale(s : GraphcolorfractionalCursor, f : Double) -> GraphcolorfractionalCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_color_fractional_cursor_add(a : GraphcolorfractionalCursor, b : GraphcolorfractionalCursor) -> GraphcolorfractionalCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_color_fractional_cursor_copy(s : GraphcolorfractionalCursor) -> GraphcolorfractionalCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_color_fractional_cursor_fill(s : GraphcolorfractionalCursor, v : Double) -> GraphcolorfractionalCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_color_fractional_cursor_min(s : GraphcolorfractionalCursor) -> Double { @_common.min(s.data) }

pub fn graph_color_fractional_cursor_max(s : GraphcolorfractionalCursor) -> Double { @_common.max(s.data) }

pub fn graph_color_fractional_cursor_to_string(s : GraphcolorfractionalCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphcolorfractionalView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_color_fractional_view_make(size : Int) -> GraphcolorfractionalView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_color_fractional_view_len(s : GraphcolorfractionalView) -> Int { s.size }

pub fn graph_color_fractional_view_get(s : GraphcolorfractionalView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_color_fractional_view_set(s : GraphcolorfractionalView, i : Int, v : Double) -> GraphcolorfractionalView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_color_fractional_view_sum(s : GraphcolorfractionalView) -> Double { @_common.sum(s.data) }

pub fn graph_color_fractional_view_mean(s : GraphcolorfractionalView) -> Double { @_common.mean(s.data) }

pub fn graph_color_fractional_view_scale(s : GraphcolorfractionalView, f : Double) -> GraphcolorfractionalView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_color_fractional_view_add(a : GraphcolorfractionalView, b : GraphcolorfractionalView) -> GraphcolorfractionalView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_color_fractional_view_copy(s : GraphcolorfractionalView) -> GraphcolorfractionalView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_color_fractional_view_fill(s : GraphcolorfractionalView, v : Double) -> GraphcolorfractionalView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_color_fractional_view_min(s : GraphcolorfractionalView) -> Double { @_common.min(s.data) }

pub fn graph_color_fractional_view_max(s : GraphcolorfractionalView) -> Double { @_common.max(s.data) }

pub fn graph_color_fractional_view_to_string(s : GraphcolorfractionalView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphcolorfractionalRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_color_fractional_range_make(size : Int) -> GraphcolorfractionalRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_color_fractional_range_len(s : GraphcolorfractionalRange) -> Int { s.size }

pub fn graph_color_fractional_range_get(s : GraphcolorfractionalRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_color_fractional_range_set(s : GraphcolorfractionalRange, i : Int, v : Double) -> GraphcolorfractionalRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_color_fractional_range_sum(s : GraphcolorfractionalRange) -> Double { @_common.sum(s.data) }

pub fn graph_color_fractional_range_mean(s : GraphcolorfractionalRange) -> Double { @_common.mean(s.data) }

pub fn graph_color_fractional_range_scale(s : GraphcolorfractionalRange, f : Double) -> GraphcolorfractionalRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_color_fractional_range_add(a : GraphcolorfractionalRange, b : GraphcolorfractionalRange) -> GraphcolorfractionalRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_color_fractional_range_copy(s : GraphcolorfractionalRange) -> GraphcolorfractionalRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_color_fractional_range_fill(s : GraphcolorfractionalRange, v : Double) -> GraphcolorfractionalRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_color_fractional_range_min(s : GraphcolorfractionalRange) -> Double { @_common.min(s.data) }

pub fn graph_color_fractional_range_max(s : GraphcolorfractionalRange) -> Double { @_common.max(s.data) }

pub fn graph_color_fractional_range_to_string(s : GraphcolorfractionalRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphcolorfractionalSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_color_fractional_slice_make(size : Int) -> GraphcolorfractionalSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_color_fractional_slice_len(s : GraphcolorfractionalSlice) -> Int { s.size }

pub fn graph_color_fractional_slice_get(s : GraphcolorfractionalSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_color_fractional_slice_set(s : GraphcolorfractionalSlice, i : Int, v : Double) -> GraphcolorfractionalSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_color_fractional_slice_sum(s : GraphcolorfractionalSlice) -> Double { @_common.sum(s.data) }

pub fn graph_color_fractional_slice_mean(s : GraphcolorfractionalSlice) -> Double { @_common.mean(s.data) }

pub fn graph_color_fractional_slice_scale(s : GraphcolorfractionalSlice, f : Double) -> GraphcolorfractionalSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_color_fractional_slice_add(a : GraphcolorfractionalSlice, b : GraphcolorfractionalSlice) -> GraphcolorfractionalSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_color_fractional_slice_copy(s : GraphcolorfractionalSlice) -> GraphcolorfractionalSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_color_fractional_slice_fill(s : GraphcolorfractionalSlice, v : Double) -> GraphcolorfractionalSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_color_fractional_slice_min(s : GraphcolorfractionalSlice) -> Double { @_common.min(s.data) }

pub fn graph_color_fractional_slice_max(s : GraphcolorfractionalSlice) -> Double { @_common.max(s.data) }

pub fn graph_color_fractional_slice_to_string(s : GraphcolorfractionalSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

