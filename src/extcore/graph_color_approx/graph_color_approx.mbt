///===
/// extcore/graph_color_approx

pub(all) struct GraphcolorapproxPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn graph_color_approx_make_point(x : Double, y : Double) -> GraphcolorapproxPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn graph_color_approx_make_point3(x : Double, y : Double, z : Double) -> GraphcolorapproxPoint {
  { x, y, z, label: 0 }
}

pub fn GraphcolorapproxPoint::x(self : GraphcolorapproxPoint) -> Double { self.x }

pub fn GraphcolorapproxPoint::y(self : GraphcolorapproxPoint) -> Double { self.y }

pub fn GraphcolorapproxPoint::z(self : GraphcolorapproxPoint) -> Double { self.z }

pub fn GraphcolorapproxPoint::label(self : GraphcolorapproxPoint) -> Int { self.label }

pub fn GraphcolorapproxPoint::dist(self : GraphcolorapproxPoint, other : GraphcolorapproxPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn GraphcolorapproxPoint::add(self : GraphcolorapproxPoint, other : GraphcolorapproxPoint) -> GraphcolorapproxPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn GraphcolorapproxPoint::sub(self : GraphcolorapproxPoint, other : GraphcolorapproxPoint) -> GraphcolorapproxPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn GraphcolorapproxPoint::scale(self : GraphcolorapproxPoint, s : Double) -> GraphcolorapproxPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn GraphcolorapproxPoint::dot(self : GraphcolorapproxPoint, other : GraphcolorapproxPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn GraphcolorapproxPoint::cross(self : GraphcolorapproxPoint, other : GraphcolorapproxPoint) -> GraphcolorapproxPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn GraphcolorapproxPoint::norm(self : GraphcolorapproxPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn GraphcolorapproxPoint::normalize(self : GraphcolorapproxPoint) -> GraphcolorapproxPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn GraphcolorapproxPoint::negate(self : GraphcolorapproxPoint) -> GraphcolorapproxPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn GraphcolorapproxPoint::mid(self : GraphcolorapproxPoint, other : GraphcolorapproxPoint) -> GraphcolorapproxPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn GraphcolorapproxPoint::lerp(self : GraphcolorapproxPoint, other : GraphcolorapproxPoint, t : Double) -> GraphcolorapproxPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn GraphcolorapproxPoint::to_string(self : GraphcolorapproxPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct GraphcolorapproxSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn graph_color_approx_make_series(vals : Array[Double], name : String) -> GraphcolorapproxSeries {
  { vals, name, meta: 0 }
}

pub fn GraphcolorapproxSeries::len(self : GraphcolorapproxSeries) -> Int { self.vals.length() }

pub fn GraphcolorapproxSeries::sum(self : GraphcolorapproxSeries) -> Double { @_common.sum(self.vals) }

pub fn GraphcolorapproxSeries::mean(self : GraphcolorapproxSeries) -> Double { @_common.mean(self.vals) }

pub fn GraphcolorapproxSeries::min(self : GraphcolorapproxSeries) -> Double { @_common.min(self.vals) }

pub fn GraphcolorapproxSeries::max(self : GraphcolorapproxSeries) -> Double { @_common.max(self.vals) }

pub fn GraphcolorapproxSeries::range(self : GraphcolorapproxSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn GraphcolorapproxSeries::variance(self : GraphcolorapproxSeries) -> Double { @_common.variance(self.vals) }

pub fn GraphcolorapproxSeries::std(self : GraphcolorapproxSeries) -> Double { @_common.std(self.vals) }

pub fn GraphcolorapproxSeries::median(self : GraphcolorapproxSeries) -> Double { @_common.median(self.vals) }

pub fn GraphcolorapproxSeries::scale(self : GraphcolorapproxSeries, f : Double) -> GraphcolorapproxSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn GraphcolorapproxSeries::add(self : GraphcolorapproxSeries, other : GraphcolorapproxSeries) -> GraphcolorapproxSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn GraphcolorapproxSeries::sub(self : GraphcolorapproxSeries, other : GraphcolorapproxSeries) -> GraphcolorapproxSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn GraphcolorapproxSeries::normalize(self : GraphcolorapproxSeries) -> GraphcolorapproxSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn GraphcolorapproxSeries::cumsum(self : GraphcolorapproxSeries) -> GraphcolorapproxSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn GraphcolorapproxSeries::to_string(self : GraphcolorapproxSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct GraphcolorapproxMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn graph_color_approx_make_matrix(rows : Int, cols : Int, val : Double) -> GraphcolorapproxMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn graph_color_approx_matrix_identity(n : Int) -> GraphcolorapproxMatrix {
  let m = graph_color_approx_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn GraphcolorapproxMatrix::get(self : GraphcolorapproxMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn GraphcolorapproxMatrix::transpose(self : GraphcolorapproxMatrix) -> GraphcolorapproxMatrix {
  let result = graph_color_approx_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn GraphcolorapproxMatrix::add(self : GraphcolorapproxMatrix, other : GraphcolorapproxMatrix) -> GraphcolorapproxMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = graph_color_approx_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn GraphcolorapproxMatrix::scale(self : GraphcolorapproxMatrix, s : Double) -> GraphcolorapproxMatrix {
  let result = graph_color_approx_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn GraphcolorapproxMatrix::multiply(self : GraphcolorapproxMatrix, other : GraphcolorapproxMatrix) -> GraphcolorapproxMatrix {
  if self.cols != other.rows { return graph_color_approx_make_matrix(self.rows, other.cols, 0.0) }
  let result = graph_color_approx_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn GraphcolorapproxMatrix::trace(self : GraphcolorapproxMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn GraphcolorapproxMatrix::det(self : GraphcolorapproxMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn GraphcolorapproxMatrix::norm(self : GraphcolorapproxMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn GraphcolorapproxMatrix::to_string(self : GraphcolorapproxMatrix) -> String {
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

pub(all) struct GraphcolorapproxVector {
  comps : Array[Double]
  dim : Int
}

pub fn graph_color_approx_make_vector(comps : Array[Double]) -> GraphcolorapproxVector {
  { comps, dim: comps.length() }
}

pub fn graph_color_approx_vector_zero(dim : Int) -> GraphcolorapproxVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn GraphcolorapproxVector::add(self : GraphcolorapproxVector, other : GraphcolorapproxVector) -> GraphcolorapproxVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn GraphcolorapproxVector::sub(self : GraphcolorapproxVector, other : GraphcolorapproxVector) -> GraphcolorapproxVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn GraphcolorapproxVector::scale(self : GraphcolorapproxVector, s : Double) -> GraphcolorapproxVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn GraphcolorapproxVector::dot(self : GraphcolorapproxVector, other : GraphcolorapproxVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn GraphcolorapproxVector::norm(self : GraphcolorapproxVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn GraphcolorapproxVector::normalize(self : GraphcolorapproxVector) -> GraphcolorapproxVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn GraphcolorapproxVector::dist(self : GraphcolorapproxVector, other : GraphcolorapproxVector) -> Double {
  self.sub(other).norm()
}

pub fn GraphcolorapproxVector::to_string(self : GraphcolorapproxVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn graph_color_approx_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn graph_color_approx_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn graph_color_approx_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn graph_color_approx_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn graph_color_approx_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn graph_color_approx_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn graph_color_approx_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn graph_color_approx_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn graph_color_approx_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn graph_color_approx_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn graph_color_approx_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn graph_color_approx_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn graph_color_approx_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn graph_color_approx_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn graph_color_approx_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn graph_color_approx_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn graph_color_approx_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn graph_color_approx_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn graph_color_approx_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn graph_color_approx_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn graph_color_approx_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn graph_color_approx_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn graph_color_approx_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn graph_color_approx_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn graph_color_approx_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn graph_color_approx_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn graph_color_approx_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn graph_color_approx_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn graph_color_approx_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct GraphcolorapproxFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_color_approx_frame_make(size : Int) -> GraphcolorapproxFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_color_approx_frame_len(s : GraphcolorapproxFrame) -> Int { s.size }

pub fn graph_color_approx_frame_get(s : GraphcolorapproxFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_color_approx_frame_set(s : GraphcolorapproxFrame, i : Int, v : Double) -> GraphcolorapproxFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_color_approx_frame_sum(s : GraphcolorapproxFrame) -> Double { @_common.sum(s.data) }

pub fn graph_color_approx_frame_mean(s : GraphcolorapproxFrame) -> Double { @_common.mean(s.data) }

pub fn graph_color_approx_frame_scale(s : GraphcolorapproxFrame, f : Double) -> GraphcolorapproxFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_color_approx_frame_add(a : GraphcolorapproxFrame, b : GraphcolorapproxFrame) -> GraphcolorapproxFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_color_approx_frame_copy(s : GraphcolorapproxFrame) -> GraphcolorapproxFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_color_approx_frame_fill(s : GraphcolorapproxFrame, v : Double) -> GraphcolorapproxFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_color_approx_frame_min(s : GraphcolorapproxFrame) -> Double { @_common.min(s.data) }

pub fn graph_color_approx_frame_max(s : GraphcolorapproxFrame) -> Double { @_common.max(s.data) }

pub fn graph_color_approx_frame_to_string(s : GraphcolorapproxFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphcolorapproxTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_color_approx_table_make(size : Int) -> GraphcolorapproxTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_color_approx_table_len(s : GraphcolorapproxTable) -> Int { s.size }

pub fn graph_color_approx_table_get(s : GraphcolorapproxTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_color_approx_table_set(s : GraphcolorapproxTable, i : Int, v : Double) -> GraphcolorapproxTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_color_approx_table_sum(s : GraphcolorapproxTable) -> Double { @_common.sum(s.data) }

pub fn graph_color_approx_table_mean(s : GraphcolorapproxTable) -> Double { @_common.mean(s.data) }

pub fn graph_color_approx_table_scale(s : GraphcolorapproxTable, f : Double) -> GraphcolorapproxTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_color_approx_table_add(a : GraphcolorapproxTable, b : GraphcolorapproxTable) -> GraphcolorapproxTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_color_approx_table_copy(s : GraphcolorapproxTable) -> GraphcolorapproxTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_color_approx_table_fill(s : GraphcolorapproxTable, v : Double) -> GraphcolorapproxTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_color_approx_table_min(s : GraphcolorapproxTable) -> Double { @_common.min(s.data) }

pub fn graph_color_approx_table_max(s : GraphcolorapproxTable) -> Double { @_common.max(s.data) }

pub fn graph_color_approx_table_to_string(s : GraphcolorapproxTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphcolorapproxGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_color_approx_graphn_make(size : Int) -> GraphcolorapproxGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_color_approx_graphn_len(s : GraphcolorapproxGraphN) -> Int { s.size }

pub fn graph_color_approx_graphn_get(s : GraphcolorapproxGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_color_approx_graphn_set(s : GraphcolorapproxGraphN, i : Int, v : Double) -> GraphcolorapproxGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_color_approx_graphn_sum(s : GraphcolorapproxGraphN) -> Double { @_common.sum(s.data) }

pub fn graph_color_approx_graphn_mean(s : GraphcolorapproxGraphN) -> Double { @_common.mean(s.data) }

pub fn graph_color_approx_graphn_scale(s : GraphcolorapproxGraphN, f : Double) -> GraphcolorapproxGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_color_approx_graphn_add(a : GraphcolorapproxGraphN, b : GraphcolorapproxGraphN) -> GraphcolorapproxGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_color_approx_graphn_copy(s : GraphcolorapproxGraphN) -> GraphcolorapproxGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_color_approx_graphn_fill(s : GraphcolorapproxGraphN, v : Double) -> GraphcolorapproxGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_color_approx_graphn_min(s : GraphcolorapproxGraphN) -> Double { @_common.min(s.data) }

pub fn graph_color_approx_graphn_max(s : GraphcolorapproxGraphN) -> Double { @_common.max(s.data) }

pub fn graph_color_approx_graphn_to_string(s : GraphcolorapproxGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphcolorapproxNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_color_approx_node_make(size : Int) -> GraphcolorapproxNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_color_approx_node_len(s : GraphcolorapproxNode) -> Int { s.size }

pub fn graph_color_approx_node_get(s : GraphcolorapproxNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_color_approx_node_set(s : GraphcolorapproxNode, i : Int, v : Double) -> GraphcolorapproxNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_color_approx_node_sum(s : GraphcolorapproxNode) -> Double { @_common.sum(s.data) }

pub fn graph_color_approx_node_mean(s : GraphcolorapproxNode) -> Double { @_common.mean(s.data) }

pub fn graph_color_approx_node_scale(s : GraphcolorapproxNode, f : Double) -> GraphcolorapproxNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_color_approx_node_add(a : GraphcolorapproxNode, b : GraphcolorapproxNode) -> GraphcolorapproxNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_color_approx_node_copy(s : GraphcolorapproxNode) -> GraphcolorapproxNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_color_approx_node_fill(s : GraphcolorapproxNode, v : Double) -> GraphcolorapproxNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_color_approx_node_min(s : GraphcolorapproxNode) -> Double { @_common.min(s.data) }

pub fn graph_color_approx_node_max(s : GraphcolorapproxNode) -> Double { @_common.max(s.data) }

pub fn graph_color_approx_node_to_string(s : GraphcolorapproxNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphcolorapproxEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_color_approx_edge_make(size : Int) -> GraphcolorapproxEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_color_approx_edge_len(s : GraphcolorapproxEdge) -> Int { s.size }

pub fn graph_color_approx_edge_get(s : GraphcolorapproxEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_color_approx_edge_set(s : GraphcolorapproxEdge, i : Int, v : Double) -> GraphcolorapproxEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_color_approx_edge_sum(s : GraphcolorapproxEdge) -> Double { @_common.sum(s.data) }

pub fn graph_color_approx_edge_mean(s : GraphcolorapproxEdge) -> Double { @_common.mean(s.data) }

pub fn graph_color_approx_edge_scale(s : GraphcolorapproxEdge, f : Double) -> GraphcolorapproxEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_color_approx_edge_add(a : GraphcolorapproxEdge, b : GraphcolorapproxEdge) -> GraphcolorapproxEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_color_approx_edge_copy(s : GraphcolorapproxEdge) -> GraphcolorapproxEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_color_approx_edge_fill(s : GraphcolorapproxEdge, v : Double) -> GraphcolorapproxEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_color_approx_edge_min(s : GraphcolorapproxEdge) -> Double { @_common.min(s.data) }

pub fn graph_color_approx_edge_max(s : GraphcolorapproxEdge) -> Double { @_common.max(s.data) }

pub fn graph_color_approx_edge_to_string(s : GraphcolorapproxEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphcolorapproxPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_color_approx_path_make(size : Int) -> GraphcolorapproxPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_color_approx_path_len(s : GraphcolorapproxPath) -> Int { s.size }

pub fn graph_color_approx_path_get(s : GraphcolorapproxPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_color_approx_path_set(s : GraphcolorapproxPath, i : Int, v : Double) -> GraphcolorapproxPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_color_approx_path_sum(s : GraphcolorapproxPath) -> Double { @_common.sum(s.data) }

pub fn graph_color_approx_path_mean(s : GraphcolorapproxPath) -> Double { @_common.mean(s.data) }

pub fn graph_color_approx_path_scale(s : GraphcolorapproxPath, f : Double) -> GraphcolorapproxPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_color_approx_path_add(a : GraphcolorapproxPath, b : GraphcolorapproxPath) -> GraphcolorapproxPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_color_approx_path_copy(s : GraphcolorapproxPath) -> GraphcolorapproxPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_color_approx_path_fill(s : GraphcolorapproxPath, v : Double) -> GraphcolorapproxPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_color_approx_path_min(s : GraphcolorapproxPath) -> Double { @_common.min(s.data) }

pub fn graph_color_approx_path_max(s : GraphcolorapproxPath) -> Double { @_common.max(s.data) }

pub fn graph_color_approx_path_to_string(s : GraphcolorapproxPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphcolorapproxCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_color_approx_cluster_make(size : Int) -> GraphcolorapproxCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_color_approx_cluster_len(s : GraphcolorapproxCluster) -> Int { s.size }

pub fn graph_color_approx_cluster_get(s : GraphcolorapproxCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_color_approx_cluster_set(s : GraphcolorapproxCluster, i : Int, v : Double) -> GraphcolorapproxCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_color_approx_cluster_sum(s : GraphcolorapproxCluster) -> Double { @_common.sum(s.data) }

pub fn graph_color_approx_cluster_mean(s : GraphcolorapproxCluster) -> Double { @_common.mean(s.data) }

pub fn graph_color_approx_cluster_scale(s : GraphcolorapproxCluster, f : Double) -> GraphcolorapproxCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_color_approx_cluster_add(a : GraphcolorapproxCluster, b : GraphcolorapproxCluster) -> GraphcolorapproxCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_color_approx_cluster_copy(s : GraphcolorapproxCluster) -> GraphcolorapproxCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_color_approx_cluster_fill(s : GraphcolorapproxCluster, v : Double) -> GraphcolorapproxCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_color_approx_cluster_min(s : GraphcolorapproxCluster) -> Double { @_common.min(s.data) }

pub fn graph_color_approx_cluster_max(s : GraphcolorapproxCluster) -> Double { @_common.max(s.data) }

pub fn graph_color_approx_cluster_to_string(s : GraphcolorapproxCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphcolorapproxModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_color_approx_model_make(size : Int) -> GraphcolorapproxModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_color_approx_model_len(s : GraphcolorapproxModel) -> Int { s.size }

pub fn graph_color_approx_model_get(s : GraphcolorapproxModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_color_approx_model_set(s : GraphcolorapproxModel, i : Int, v : Double) -> GraphcolorapproxModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_color_approx_model_sum(s : GraphcolorapproxModel) -> Double { @_common.sum(s.data) }

pub fn graph_color_approx_model_mean(s : GraphcolorapproxModel) -> Double { @_common.mean(s.data) }

pub fn graph_color_approx_model_scale(s : GraphcolorapproxModel, f : Double) -> GraphcolorapproxModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_color_approx_model_add(a : GraphcolorapproxModel, b : GraphcolorapproxModel) -> GraphcolorapproxModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_color_approx_model_copy(s : GraphcolorapproxModel) -> GraphcolorapproxModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_color_approx_model_fill(s : GraphcolorapproxModel, v : Double) -> GraphcolorapproxModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_color_approx_model_min(s : GraphcolorapproxModel) -> Double { @_common.min(s.data) }

pub fn graph_color_approx_model_max(s : GraphcolorapproxModel) -> Double { @_common.max(s.data) }

pub fn graph_color_approx_model_to_string(s : GraphcolorapproxModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphcolorapproxLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_color_approx_layer_make(size : Int) -> GraphcolorapproxLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_color_approx_layer_len(s : GraphcolorapproxLayer) -> Int { s.size }

pub fn graph_color_approx_layer_get(s : GraphcolorapproxLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_color_approx_layer_set(s : GraphcolorapproxLayer, i : Int, v : Double) -> GraphcolorapproxLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_color_approx_layer_sum(s : GraphcolorapproxLayer) -> Double { @_common.sum(s.data) }

pub fn graph_color_approx_layer_mean(s : GraphcolorapproxLayer) -> Double { @_common.mean(s.data) }

pub fn graph_color_approx_layer_scale(s : GraphcolorapproxLayer, f : Double) -> GraphcolorapproxLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_color_approx_layer_add(a : GraphcolorapproxLayer, b : GraphcolorapproxLayer) -> GraphcolorapproxLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_color_approx_layer_copy(s : GraphcolorapproxLayer) -> GraphcolorapproxLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_color_approx_layer_fill(s : GraphcolorapproxLayer, v : Double) -> GraphcolorapproxLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_color_approx_layer_min(s : GraphcolorapproxLayer) -> Double { @_common.min(s.data) }

pub fn graph_color_approx_layer_max(s : GraphcolorapproxLayer) -> Double { @_common.max(s.data) }

pub fn graph_color_approx_layer_to_string(s : GraphcolorapproxLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphcolorapproxBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_color_approx_buffer_make(size : Int) -> GraphcolorapproxBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_color_approx_buffer_len(s : GraphcolorapproxBuffer) -> Int { s.size }

pub fn graph_color_approx_buffer_get(s : GraphcolorapproxBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_color_approx_buffer_set(s : GraphcolorapproxBuffer, i : Int, v : Double) -> GraphcolorapproxBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_color_approx_buffer_sum(s : GraphcolorapproxBuffer) -> Double { @_common.sum(s.data) }

pub fn graph_color_approx_buffer_mean(s : GraphcolorapproxBuffer) -> Double { @_common.mean(s.data) }

pub fn graph_color_approx_buffer_scale(s : GraphcolorapproxBuffer, f : Double) -> GraphcolorapproxBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_color_approx_buffer_add(a : GraphcolorapproxBuffer, b : GraphcolorapproxBuffer) -> GraphcolorapproxBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_color_approx_buffer_copy(s : GraphcolorapproxBuffer) -> GraphcolorapproxBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_color_approx_buffer_fill(s : GraphcolorapproxBuffer, v : Double) -> GraphcolorapproxBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_color_approx_buffer_min(s : GraphcolorapproxBuffer) -> Double { @_common.min(s.data) }

pub fn graph_color_approx_buffer_max(s : GraphcolorapproxBuffer) -> Double { @_common.max(s.data) }

pub fn graph_color_approx_buffer_to_string(s : GraphcolorapproxBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphcolorapproxCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_color_approx_cursor_make(size : Int) -> GraphcolorapproxCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_color_approx_cursor_len(s : GraphcolorapproxCursor) -> Int { s.size }

pub fn graph_color_approx_cursor_get(s : GraphcolorapproxCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_color_approx_cursor_set(s : GraphcolorapproxCursor, i : Int, v : Double) -> GraphcolorapproxCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_color_approx_cursor_sum(s : GraphcolorapproxCursor) -> Double { @_common.sum(s.data) }

pub fn graph_color_approx_cursor_mean(s : GraphcolorapproxCursor) -> Double { @_common.mean(s.data) }

pub fn graph_color_approx_cursor_scale(s : GraphcolorapproxCursor, f : Double) -> GraphcolorapproxCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_color_approx_cursor_add(a : GraphcolorapproxCursor, b : GraphcolorapproxCursor) -> GraphcolorapproxCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_color_approx_cursor_copy(s : GraphcolorapproxCursor) -> GraphcolorapproxCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_color_approx_cursor_fill(s : GraphcolorapproxCursor, v : Double) -> GraphcolorapproxCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_color_approx_cursor_min(s : GraphcolorapproxCursor) -> Double { @_common.min(s.data) }

pub fn graph_color_approx_cursor_max(s : GraphcolorapproxCursor) -> Double { @_common.max(s.data) }

pub fn graph_color_approx_cursor_to_string(s : GraphcolorapproxCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphcolorapproxView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_color_approx_view_make(size : Int) -> GraphcolorapproxView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_color_approx_view_len(s : GraphcolorapproxView) -> Int { s.size }

pub fn graph_color_approx_view_get(s : GraphcolorapproxView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_color_approx_view_set(s : GraphcolorapproxView, i : Int, v : Double) -> GraphcolorapproxView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_color_approx_view_sum(s : GraphcolorapproxView) -> Double { @_common.sum(s.data) }

pub fn graph_color_approx_view_mean(s : GraphcolorapproxView) -> Double { @_common.mean(s.data) }

pub fn graph_color_approx_view_scale(s : GraphcolorapproxView, f : Double) -> GraphcolorapproxView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_color_approx_view_add(a : GraphcolorapproxView, b : GraphcolorapproxView) -> GraphcolorapproxView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_color_approx_view_copy(s : GraphcolorapproxView) -> GraphcolorapproxView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_color_approx_view_fill(s : GraphcolorapproxView, v : Double) -> GraphcolorapproxView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_color_approx_view_min(s : GraphcolorapproxView) -> Double { @_common.min(s.data) }

pub fn graph_color_approx_view_max(s : GraphcolorapproxView) -> Double { @_common.max(s.data) }

pub fn graph_color_approx_view_to_string(s : GraphcolorapproxView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphcolorapproxRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_color_approx_range_make(size : Int) -> GraphcolorapproxRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_color_approx_range_len(s : GraphcolorapproxRange) -> Int { s.size }

pub fn graph_color_approx_range_get(s : GraphcolorapproxRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_color_approx_range_set(s : GraphcolorapproxRange, i : Int, v : Double) -> GraphcolorapproxRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_color_approx_range_sum(s : GraphcolorapproxRange) -> Double { @_common.sum(s.data) }

pub fn graph_color_approx_range_mean(s : GraphcolorapproxRange) -> Double { @_common.mean(s.data) }

pub fn graph_color_approx_range_scale(s : GraphcolorapproxRange, f : Double) -> GraphcolorapproxRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_color_approx_range_add(a : GraphcolorapproxRange, b : GraphcolorapproxRange) -> GraphcolorapproxRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_color_approx_range_copy(s : GraphcolorapproxRange) -> GraphcolorapproxRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_color_approx_range_fill(s : GraphcolorapproxRange, v : Double) -> GraphcolorapproxRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_color_approx_range_min(s : GraphcolorapproxRange) -> Double { @_common.min(s.data) }

pub fn graph_color_approx_range_max(s : GraphcolorapproxRange) -> Double { @_common.max(s.data) }

pub fn graph_color_approx_range_to_string(s : GraphcolorapproxRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphcolorapproxSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_color_approx_slice_make(size : Int) -> GraphcolorapproxSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_color_approx_slice_len(s : GraphcolorapproxSlice) -> Int { s.size }

pub fn graph_color_approx_slice_get(s : GraphcolorapproxSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_color_approx_slice_set(s : GraphcolorapproxSlice, i : Int, v : Double) -> GraphcolorapproxSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_color_approx_slice_sum(s : GraphcolorapproxSlice) -> Double { @_common.sum(s.data) }

pub fn graph_color_approx_slice_mean(s : GraphcolorapproxSlice) -> Double { @_common.mean(s.data) }

pub fn graph_color_approx_slice_scale(s : GraphcolorapproxSlice, f : Double) -> GraphcolorapproxSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_color_approx_slice_add(a : GraphcolorapproxSlice, b : GraphcolorapproxSlice) -> GraphcolorapproxSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_color_approx_slice_copy(s : GraphcolorapproxSlice) -> GraphcolorapproxSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_color_approx_slice_fill(s : GraphcolorapproxSlice, v : Double) -> GraphcolorapproxSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_color_approx_slice_min(s : GraphcolorapproxSlice) -> Double { @_common.min(s.data) }

pub fn graph_color_approx_slice_max(s : GraphcolorapproxSlice) -> Double { @_common.max(s.data) }

pub fn graph_color_approx_slice_to_string(s : GraphcolorapproxSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

