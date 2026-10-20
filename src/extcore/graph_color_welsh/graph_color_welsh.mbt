///===
/// extcore/graph_color_welsh

pub(all) struct GraphcolorwelshPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn graph_color_welsh_make_point(x : Double, y : Double) -> GraphcolorwelshPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn graph_color_welsh_make_point3(x : Double, y : Double, z : Double) -> GraphcolorwelshPoint {
  { x, y, z, label: 0 }
}

pub fn GraphcolorwelshPoint::x(self : GraphcolorwelshPoint) -> Double { self.x }

pub fn GraphcolorwelshPoint::y(self : GraphcolorwelshPoint) -> Double { self.y }

pub fn GraphcolorwelshPoint::z(self : GraphcolorwelshPoint) -> Double { self.z }

pub fn GraphcolorwelshPoint::label(self : GraphcolorwelshPoint) -> Int { self.label }

pub fn GraphcolorwelshPoint::dist(self : GraphcolorwelshPoint, other : GraphcolorwelshPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn GraphcolorwelshPoint::add(self : GraphcolorwelshPoint, other : GraphcolorwelshPoint) -> GraphcolorwelshPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn GraphcolorwelshPoint::sub(self : GraphcolorwelshPoint, other : GraphcolorwelshPoint) -> GraphcolorwelshPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn GraphcolorwelshPoint::scale(self : GraphcolorwelshPoint, s : Double) -> GraphcolorwelshPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn GraphcolorwelshPoint::dot(self : GraphcolorwelshPoint, other : GraphcolorwelshPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn GraphcolorwelshPoint::cross(self : GraphcolorwelshPoint, other : GraphcolorwelshPoint) -> GraphcolorwelshPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn GraphcolorwelshPoint::norm(self : GraphcolorwelshPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn GraphcolorwelshPoint::normalize(self : GraphcolorwelshPoint) -> GraphcolorwelshPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn GraphcolorwelshPoint::negate(self : GraphcolorwelshPoint) -> GraphcolorwelshPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn GraphcolorwelshPoint::mid(self : GraphcolorwelshPoint, other : GraphcolorwelshPoint) -> GraphcolorwelshPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn GraphcolorwelshPoint::lerp(self : GraphcolorwelshPoint, other : GraphcolorwelshPoint, t : Double) -> GraphcolorwelshPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn GraphcolorwelshPoint::to_string(self : GraphcolorwelshPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct GraphcolorwelshSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn graph_color_welsh_make_series(vals : Array[Double], name : String) -> GraphcolorwelshSeries {
  { vals, name, meta: 0 }
}

pub fn GraphcolorwelshSeries::len(self : GraphcolorwelshSeries) -> Int { self.vals.length() }

pub fn GraphcolorwelshSeries::sum(self : GraphcolorwelshSeries) -> Double { @_common.sum(self.vals) }

pub fn GraphcolorwelshSeries::mean(self : GraphcolorwelshSeries) -> Double { @_common.mean(self.vals) }

pub fn GraphcolorwelshSeries::min(self : GraphcolorwelshSeries) -> Double { @_common.min(self.vals) }

pub fn GraphcolorwelshSeries::max(self : GraphcolorwelshSeries) -> Double { @_common.max(self.vals) }

pub fn GraphcolorwelshSeries::range(self : GraphcolorwelshSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn GraphcolorwelshSeries::variance(self : GraphcolorwelshSeries) -> Double { @_common.variance(self.vals) }

pub fn GraphcolorwelshSeries::std(self : GraphcolorwelshSeries) -> Double { @_common.std(self.vals) }

pub fn GraphcolorwelshSeries::median(self : GraphcolorwelshSeries) -> Double { @_common.median(self.vals) }

pub fn GraphcolorwelshSeries::scale(self : GraphcolorwelshSeries, f : Double) -> GraphcolorwelshSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn GraphcolorwelshSeries::add(self : GraphcolorwelshSeries, other : GraphcolorwelshSeries) -> GraphcolorwelshSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn GraphcolorwelshSeries::sub(self : GraphcolorwelshSeries, other : GraphcolorwelshSeries) -> GraphcolorwelshSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn GraphcolorwelshSeries::normalize(self : GraphcolorwelshSeries) -> GraphcolorwelshSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn GraphcolorwelshSeries::cumsum(self : GraphcolorwelshSeries) -> GraphcolorwelshSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn GraphcolorwelshSeries::to_string(self : GraphcolorwelshSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct GraphcolorwelshMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn graph_color_welsh_make_matrix(rows : Int, cols : Int, val : Double) -> GraphcolorwelshMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn graph_color_welsh_matrix_identity(n : Int) -> GraphcolorwelshMatrix {
  let m = graph_color_welsh_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn GraphcolorwelshMatrix::get(self : GraphcolorwelshMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn GraphcolorwelshMatrix::transpose(self : GraphcolorwelshMatrix) -> GraphcolorwelshMatrix {
  let result = graph_color_welsh_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn GraphcolorwelshMatrix::add(self : GraphcolorwelshMatrix, other : GraphcolorwelshMatrix) -> GraphcolorwelshMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = graph_color_welsh_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn GraphcolorwelshMatrix::scale(self : GraphcolorwelshMatrix, s : Double) -> GraphcolorwelshMatrix {
  let result = graph_color_welsh_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn GraphcolorwelshMatrix::multiply(self : GraphcolorwelshMatrix, other : GraphcolorwelshMatrix) -> GraphcolorwelshMatrix {
  if self.cols != other.rows { return graph_color_welsh_make_matrix(self.rows, other.cols, 0.0) }
  let result = graph_color_welsh_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn GraphcolorwelshMatrix::trace(self : GraphcolorwelshMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn GraphcolorwelshMatrix::det(self : GraphcolorwelshMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn GraphcolorwelshMatrix::norm(self : GraphcolorwelshMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn GraphcolorwelshMatrix::to_string(self : GraphcolorwelshMatrix) -> String {
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

pub(all) struct GraphcolorwelshVector {
  comps : Array[Double]
  dim : Int
}

pub fn graph_color_welsh_make_vector(comps : Array[Double]) -> GraphcolorwelshVector {
  { comps, dim: comps.length() }
}

pub fn graph_color_welsh_vector_zero(dim : Int) -> GraphcolorwelshVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn GraphcolorwelshVector::add(self : GraphcolorwelshVector, other : GraphcolorwelshVector) -> GraphcolorwelshVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn GraphcolorwelshVector::sub(self : GraphcolorwelshVector, other : GraphcolorwelshVector) -> GraphcolorwelshVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn GraphcolorwelshVector::scale(self : GraphcolorwelshVector, s : Double) -> GraphcolorwelshVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn GraphcolorwelshVector::dot(self : GraphcolorwelshVector, other : GraphcolorwelshVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn GraphcolorwelshVector::norm(self : GraphcolorwelshVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn GraphcolorwelshVector::normalize(self : GraphcolorwelshVector) -> GraphcolorwelshVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn GraphcolorwelshVector::dist(self : GraphcolorwelshVector, other : GraphcolorwelshVector) -> Double {
  self.sub(other).norm()
}

pub fn GraphcolorwelshVector::to_string(self : GraphcolorwelshVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn graph_color_welsh_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn graph_color_welsh_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn graph_color_welsh_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn graph_color_welsh_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn graph_color_welsh_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn graph_color_welsh_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn graph_color_welsh_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn graph_color_welsh_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn graph_color_welsh_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn graph_color_welsh_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn graph_color_welsh_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn graph_color_welsh_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn graph_color_welsh_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn graph_color_welsh_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn graph_color_welsh_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn graph_color_welsh_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn graph_color_welsh_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn graph_color_welsh_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn graph_color_welsh_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn graph_color_welsh_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn graph_color_welsh_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn graph_color_welsh_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn graph_color_welsh_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn graph_color_welsh_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn graph_color_welsh_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn graph_color_welsh_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn graph_color_welsh_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn graph_color_welsh_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn graph_color_welsh_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct GraphcolorwelshFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_color_welsh_frame_make(size : Int) -> GraphcolorwelshFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_color_welsh_frame_len(s : GraphcolorwelshFrame) -> Int { s.size }

pub fn graph_color_welsh_frame_get(s : GraphcolorwelshFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_color_welsh_frame_set(s : GraphcolorwelshFrame, i : Int, v : Double) -> GraphcolorwelshFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_color_welsh_frame_sum(s : GraphcolorwelshFrame) -> Double { @_common.sum(s.data) }

pub fn graph_color_welsh_frame_mean(s : GraphcolorwelshFrame) -> Double { @_common.mean(s.data) }

pub fn graph_color_welsh_frame_scale(s : GraphcolorwelshFrame, f : Double) -> GraphcolorwelshFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_color_welsh_frame_add(a : GraphcolorwelshFrame, b : GraphcolorwelshFrame) -> GraphcolorwelshFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_color_welsh_frame_copy(s : GraphcolorwelshFrame) -> GraphcolorwelshFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_color_welsh_frame_fill(s : GraphcolorwelshFrame, v : Double) -> GraphcolorwelshFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_color_welsh_frame_min(s : GraphcolorwelshFrame) -> Double { @_common.min(s.data) }

pub fn graph_color_welsh_frame_max(s : GraphcolorwelshFrame) -> Double { @_common.max(s.data) }

pub fn graph_color_welsh_frame_to_string(s : GraphcolorwelshFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphcolorwelshTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_color_welsh_table_make(size : Int) -> GraphcolorwelshTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_color_welsh_table_len(s : GraphcolorwelshTable) -> Int { s.size }

pub fn graph_color_welsh_table_get(s : GraphcolorwelshTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_color_welsh_table_set(s : GraphcolorwelshTable, i : Int, v : Double) -> GraphcolorwelshTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_color_welsh_table_sum(s : GraphcolorwelshTable) -> Double { @_common.sum(s.data) }

pub fn graph_color_welsh_table_mean(s : GraphcolorwelshTable) -> Double { @_common.mean(s.data) }

pub fn graph_color_welsh_table_scale(s : GraphcolorwelshTable, f : Double) -> GraphcolorwelshTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_color_welsh_table_add(a : GraphcolorwelshTable, b : GraphcolorwelshTable) -> GraphcolorwelshTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_color_welsh_table_copy(s : GraphcolorwelshTable) -> GraphcolorwelshTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_color_welsh_table_fill(s : GraphcolorwelshTable, v : Double) -> GraphcolorwelshTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_color_welsh_table_min(s : GraphcolorwelshTable) -> Double { @_common.min(s.data) }

pub fn graph_color_welsh_table_max(s : GraphcolorwelshTable) -> Double { @_common.max(s.data) }

pub fn graph_color_welsh_table_to_string(s : GraphcolorwelshTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphcolorwelshGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_color_welsh_graphn_make(size : Int) -> GraphcolorwelshGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_color_welsh_graphn_len(s : GraphcolorwelshGraphN) -> Int { s.size }

pub fn graph_color_welsh_graphn_get(s : GraphcolorwelshGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_color_welsh_graphn_set(s : GraphcolorwelshGraphN, i : Int, v : Double) -> GraphcolorwelshGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_color_welsh_graphn_sum(s : GraphcolorwelshGraphN) -> Double { @_common.sum(s.data) }

pub fn graph_color_welsh_graphn_mean(s : GraphcolorwelshGraphN) -> Double { @_common.mean(s.data) }

pub fn graph_color_welsh_graphn_scale(s : GraphcolorwelshGraphN, f : Double) -> GraphcolorwelshGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_color_welsh_graphn_add(a : GraphcolorwelshGraphN, b : GraphcolorwelshGraphN) -> GraphcolorwelshGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_color_welsh_graphn_copy(s : GraphcolorwelshGraphN) -> GraphcolorwelshGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_color_welsh_graphn_fill(s : GraphcolorwelshGraphN, v : Double) -> GraphcolorwelshGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_color_welsh_graphn_min(s : GraphcolorwelshGraphN) -> Double { @_common.min(s.data) }

pub fn graph_color_welsh_graphn_max(s : GraphcolorwelshGraphN) -> Double { @_common.max(s.data) }

pub fn graph_color_welsh_graphn_to_string(s : GraphcolorwelshGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphcolorwelshNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_color_welsh_node_make(size : Int) -> GraphcolorwelshNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_color_welsh_node_len(s : GraphcolorwelshNode) -> Int { s.size }

pub fn graph_color_welsh_node_get(s : GraphcolorwelshNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_color_welsh_node_set(s : GraphcolorwelshNode, i : Int, v : Double) -> GraphcolorwelshNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_color_welsh_node_sum(s : GraphcolorwelshNode) -> Double { @_common.sum(s.data) }

pub fn graph_color_welsh_node_mean(s : GraphcolorwelshNode) -> Double { @_common.mean(s.data) }

pub fn graph_color_welsh_node_scale(s : GraphcolorwelshNode, f : Double) -> GraphcolorwelshNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_color_welsh_node_add(a : GraphcolorwelshNode, b : GraphcolorwelshNode) -> GraphcolorwelshNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_color_welsh_node_copy(s : GraphcolorwelshNode) -> GraphcolorwelshNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_color_welsh_node_fill(s : GraphcolorwelshNode, v : Double) -> GraphcolorwelshNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_color_welsh_node_min(s : GraphcolorwelshNode) -> Double { @_common.min(s.data) }

pub fn graph_color_welsh_node_max(s : GraphcolorwelshNode) -> Double { @_common.max(s.data) }

pub fn graph_color_welsh_node_to_string(s : GraphcolorwelshNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphcolorwelshEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_color_welsh_edge_make(size : Int) -> GraphcolorwelshEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_color_welsh_edge_len(s : GraphcolorwelshEdge) -> Int { s.size }

pub fn graph_color_welsh_edge_get(s : GraphcolorwelshEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_color_welsh_edge_set(s : GraphcolorwelshEdge, i : Int, v : Double) -> GraphcolorwelshEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_color_welsh_edge_sum(s : GraphcolorwelshEdge) -> Double { @_common.sum(s.data) }

pub fn graph_color_welsh_edge_mean(s : GraphcolorwelshEdge) -> Double { @_common.mean(s.data) }

pub fn graph_color_welsh_edge_scale(s : GraphcolorwelshEdge, f : Double) -> GraphcolorwelshEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_color_welsh_edge_add(a : GraphcolorwelshEdge, b : GraphcolorwelshEdge) -> GraphcolorwelshEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_color_welsh_edge_copy(s : GraphcolorwelshEdge) -> GraphcolorwelshEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_color_welsh_edge_fill(s : GraphcolorwelshEdge, v : Double) -> GraphcolorwelshEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_color_welsh_edge_min(s : GraphcolorwelshEdge) -> Double { @_common.min(s.data) }

pub fn graph_color_welsh_edge_max(s : GraphcolorwelshEdge) -> Double { @_common.max(s.data) }

pub fn graph_color_welsh_edge_to_string(s : GraphcolorwelshEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphcolorwelshPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_color_welsh_path_make(size : Int) -> GraphcolorwelshPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_color_welsh_path_len(s : GraphcolorwelshPath) -> Int { s.size }

pub fn graph_color_welsh_path_get(s : GraphcolorwelshPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_color_welsh_path_set(s : GraphcolorwelshPath, i : Int, v : Double) -> GraphcolorwelshPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_color_welsh_path_sum(s : GraphcolorwelshPath) -> Double { @_common.sum(s.data) }

pub fn graph_color_welsh_path_mean(s : GraphcolorwelshPath) -> Double { @_common.mean(s.data) }

pub fn graph_color_welsh_path_scale(s : GraphcolorwelshPath, f : Double) -> GraphcolorwelshPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_color_welsh_path_add(a : GraphcolorwelshPath, b : GraphcolorwelshPath) -> GraphcolorwelshPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_color_welsh_path_copy(s : GraphcolorwelshPath) -> GraphcolorwelshPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_color_welsh_path_fill(s : GraphcolorwelshPath, v : Double) -> GraphcolorwelshPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_color_welsh_path_min(s : GraphcolorwelshPath) -> Double { @_common.min(s.data) }

pub fn graph_color_welsh_path_max(s : GraphcolorwelshPath) -> Double { @_common.max(s.data) }

pub fn graph_color_welsh_path_to_string(s : GraphcolorwelshPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphcolorwelshCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_color_welsh_cluster_make(size : Int) -> GraphcolorwelshCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_color_welsh_cluster_len(s : GraphcolorwelshCluster) -> Int { s.size }

pub fn graph_color_welsh_cluster_get(s : GraphcolorwelshCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_color_welsh_cluster_set(s : GraphcolorwelshCluster, i : Int, v : Double) -> GraphcolorwelshCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_color_welsh_cluster_sum(s : GraphcolorwelshCluster) -> Double { @_common.sum(s.data) }

pub fn graph_color_welsh_cluster_mean(s : GraphcolorwelshCluster) -> Double { @_common.mean(s.data) }

pub fn graph_color_welsh_cluster_scale(s : GraphcolorwelshCluster, f : Double) -> GraphcolorwelshCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_color_welsh_cluster_add(a : GraphcolorwelshCluster, b : GraphcolorwelshCluster) -> GraphcolorwelshCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_color_welsh_cluster_copy(s : GraphcolorwelshCluster) -> GraphcolorwelshCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_color_welsh_cluster_fill(s : GraphcolorwelshCluster, v : Double) -> GraphcolorwelshCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_color_welsh_cluster_min(s : GraphcolorwelshCluster) -> Double { @_common.min(s.data) }

pub fn graph_color_welsh_cluster_max(s : GraphcolorwelshCluster) -> Double { @_common.max(s.data) }

pub fn graph_color_welsh_cluster_to_string(s : GraphcolorwelshCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphcolorwelshModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_color_welsh_model_make(size : Int) -> GraphcolorwelshModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_color_welsh_model_len(s : GraphcolorwelshModel) -> Int { s.size }

pub fn graph_color_welsh_model_get(s : GraphcolorwelshModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_color_welsh_model_set(s : GraphcolorwelshModel, i : Int, v : Double) -> GraphcolorwelshModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_color_welsh_model_sum(s : GraphcolorwelshModel) -> Double { @_common.sum(s.data) }

pub fn graph_color_welsh_model_mean(s : GraphcolorwelshModel) -> Double { @_common.mean(s.data) }

pub fn graph_color_welsh_model_scale(s : GraphcolorwelshModel, f : Double) -> GraphcolorwelshModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_color_welsh_model_add(a : GraphcolorwelshModel, b : GraphcolorwelshModel) -> GraphcolorwelshModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_color_welsh_model_copy(s : GraphcolorwelshModel) -> GraphcolorwelshModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_color_welsh_model_fill(s : GraphcolorwelshModel, v : Double) -> GraphcolorwelshModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_color_welsh_model_min(s : GraphcolorwelshModel) -> Double { @_common.min(s.data) }

pub fn graph_color_welsh_model_max(s : GraphcolorwelshModel) -> Double { @_common.max(s.data) }

pub fn graph_color_welsh_model_to_string(s : GraphcolorwelshModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphcolorwelshLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_color_welsh_layer_make(size : Int) -> GraphcolorwelshLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_color_welsh_layer_len(s : GraphcolorwelshLayer) -> Int { s.size }

pub fn graph_color_welsh_layer_get(s : GraphcolorwelshLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_color_welsh_layer_set(s : GraphcolorwelshLayer, i : Int, v : Double) -> GraphcolorwelshLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_color_welsh_layer_sum(s : GraphcolorwelshLayer) -> Double { @_common.sum(s.data) }

pub fn graph_color_welsh_layer_mean(s : GraphcolorwelshLayer) -> Double { @_common.mean(s.data) }

pub fn graph_color_welsh_layer_scale(s : GraphcolorwelshLayer, f : Double) -> GraphcolorwelshLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_color_welsh_layer_add(a : GraphcolorwelshLayer, b : GraphcolorwelshLayer) -> GraphcolorwelshLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_color_welsh_layer_copy(s : GraphcolorwelshLayer) -> GraphcolorwelshLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_color_welsh_layer_fill(s : GraphcolorwelshLayer, v : Double) -> GraphcolorwelshLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_color_welsh_layer_min(s : GraphcolorwelshLayer) -> Double { @_common.min(s.data) }

pub fn graph_color_welsh_layer_max(s : GraphcolorwelshLayer) -> Double { @_common.max(s.data) }

pub fn graph_color_welsh_layer_to_string(s : GraphcolorwelshLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphcolorwelshBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_color_welsh_buffer_make(size : Int) -> GraphcolorwelshBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_color_welsh_buffer_len(s : GraphcolorwelshBuffer) -> Int { s.size }

pub fn graph_color_welsh_buffer_get(s : GraphcolorwelshBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_color_welsh_buffer_set(s : GraphcolorwelshBuffer, i : Int, v : Double) -> GraphcolorwelshBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_color_welsh_buffer_sum(s : GraphcolorwelshBuffer) -> Double { @_common.sum(s.data) }

pub fn graph_color_welsh_buffer_mean(s : GraphcolorwelshBuffer) -> Double { @_common.mean(s.data) }

pub fn graph_color_welsh_buffer_scale(s : GraphcolorwelshBuffer, f : Double) -> GraphcolorwelshBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_color_welsh_buffer_add(a : GraphcolorwelshBuffer, b : GraphcolorwelshBuffer) -> GraphcolorwelshBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_color_welsh_buffer_copy(s : GraphcolorwelshBuffer) -> GraphcolorwelshBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_color_welsh_buffer_fill(s : GraphcolorwelshBuffer, v : Double) -> GraphcolorwelshBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_color_welsh_buffer_min(s : GraphcolorwelshBuffer) -> Double { @_common.min(s.data) }

pub fn graph_color_welsh_buffer_max(s : GraphcolorwelshBuffer) -> Double { @_common.max(s.data) }

pub fn graph_color_welsh_buffer_to_string(s : GraphcolorwelshBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphcolorwelshCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_color_welsh_cursor_make(size : Int) -> GraphcolorwelshCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_color_welsh_cursor_len(s : GraphcolorwelshCursor) -> Int { s.size }

pub fn graph_color_welsh_cursor_get(s : GraphcolorwelshCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_color_welsh_cursor_set(s : GraphcolorwelshCursor, i : Int, v : Double) -> GraphcolorwelshCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_color_welsh_cursor_sum(s : GraphcolorwelshCursor) -> Double { @_common.sum(s.data) }

pub fn graph_color_welsh_cursor_mean(s : GraphcolorwelshCursor) -> Double { @_common.mean(s.data) }

pub fn graph_color_welsh_cursor_scale(s : GraphcolorwelshCursor, f : Double) -> GraphcolorwelshCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_color_welsh_cursor_add(a : GraphcolorwelshCursor, b : GraphcolorwelshCursor) -> GraphcolorwelshCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_color_welsh_cursor_copy(s : GraphcolorwelshCursor) -> GraphcolorwelshCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_color_welsh_cursor_fill(s : GraphcolorwelshCursor, v : Double) -> GraphcolorwelshCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_color_welsh_cursor_min(s : GraphcolorwelshCursor) -> Double { @_common.min(s.data) }

pub fn graph_color_welsh_cursor_max(s : GraphcolorwelshCursor) -> Double { @_common.max(s.data) }

pub fn graph_color_welsh_cursor_to_string(s : GraphcolorwelshCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphcolorwelshView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_color_welsh_view_make(size : Int) -> GraphcolorwelshView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_color_welsh_view_len(s : GraphcolorwelshView) -> Int { s.size }

pub fn graph_color_welsh_view_get(s : GraphcolorwelshView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_color_welsh_view_set(s : GraphcolorwelshView, i : Int, v : Double) -> GraphcolorwelshView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_color_welsh_view_sum(s : GraphcolorwelshView) -> Double { @_common.sum(s.data) }

pub fn graph_color_welsh_view_mean(s : GraphcolorwelshView) -> Double { @_common.mean(s.data) }

pub fn graph_color_welsh_view_scale(s : GraphcolorwelshView, f : Double) -> GraphcolorwelshView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_color_welsh_view_add(a : GraphcolorwelshView, b : GraphcolorwelshView) -> GraphcolorwelshView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_color_welsh_view_copy(s : GraphcolorwelshView) -> GraphcolorwelshView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_color_welsh_view_fill(s : GraphcolorwelshView, v : Double) -> GraphcolorwelshView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_color_welsh_view_min(s : GraphcolorwelshView) -> Double { @_common.min(s.data) }

pub fn graph_color_welsh_view_max(s : GraphcolorwelshView) -> Double { @_common.max(s.data) }

pub fn graph_color_welsh_view_to_string(s : GraphcolorwelshView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphcolorwelshRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_color_welsh_range_make(size : Int) -> GraphcolorwelshRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_color_welsh_range_len(s : GraphcolorwelshRange) -> Int { s.size }

pub fn graph_color_welsh_range_get(s : GraphcolorwelshRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_color_welsh_range_set(s : GraphcolorwelshRange, i : Int, v : Double) -> GraphcolorwelshRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_color_welsh_range_sum(s : GraphcolorwelshRange) -> Double { @_common.sum(s.data) }

pub fn graph_color_welsh_range_mean(s : GraphcolorwelshRange) -> Double { @_common.mean(s.data) }

pub fn graph_color_welsh_range_scale(s : GraphcolorwelshRange, f : Double) -> GraphcolorwelshRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_color_welsh_range_add(a : GraphcolorwelshRange, b : GraphcolorwelshRange) -> GraphcolorwelshRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_color_welsh_range_copy(s : GraphcolorwelshRange) -> GraphcolorwelshRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_color_welsh_range_fill(s : GraphcolorwelshRange, v : Double) -> GraphcolorwelshRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_color_welsh_range_min(s : GraphcolorwelshRange) -> Double { @_common.min(s.data) }

pub fn graph_color_welsh_range_max(s : GraphcolorwelshRange) -> Double { @_common.max(s.data) }

pub fn graph_color_welsh_range_to_string(s : GraphcolorwelshRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphcolorwelshSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_color_welsh_slice_make(size : Int) -> GraphcolorwelshSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_color_welsh_slice_len(s : GraphcolorwelshSlice) -> Int { s.size }

pub fn graph_color_welsh_slice_get(s : GraphcolorwelshSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_color_welsh_slice_set(s : GraphcolorwelshSlice, i : Int, v : Double) -> GraphcolorwelshSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_color_welsh_slice_sum(s : GraphcolorwelshSlice) -> Double { @_common.sum(s.data) }

pub fn graph_color_welsh_slice_mean(s : GraphcolorwelshSlice) -> Double { @_common.mean(s.data) }

pub fn graph_color_welsh_slice_scale(s : GraphcolorwelshSlice, f : Double) -> GraphcolorwelshSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_color_welsh_slice_add(a : GraphcolorwelshSlice, b : GraphcolorwelshSlice) -> GraphcolorwelshSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_color_welsh_slice_copy(s : GraphcolorwelshSlice) -> GraphcolorwelshSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_color_welsh_slice_fill(s : GraphcolorwelshSlice, v : Double) -> GraphcolorwelshSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_color_welsh_slice_min(s : GraphcolorwelshSlice) -> Double { @_common.min(s.data) }

pub fn graph_color_welsh_slice_max(s : GraphcolorwelshSlice) -> Double { @_common.max(s.data) }

pub fn graph_color_welsh_slice_to_string(s : GraphcolorwelshSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

