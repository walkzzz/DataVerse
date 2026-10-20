///===
/// extcore/graph_color_lawler

pub(all) struct GraphcolorlawlerPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn graph_color_lawler_make_point(x : Double, y : Double) -> GraphcolorlawlerPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn graph_color_lawler_make_point3(x : Double, y : Double, z : Double) -> GraphcolorlawlerPoint {
  { x, y, z, label: 0 }
}

pub fn GraphcolorlawlerPoint::x(self : GraphcolorlawlerPoint) -> Double { self.x }

pub fn GraphcolorlawlerPoint::y(self : GraphcolorlawlerPoint) -> Double { self.y }

pub fn GraphcolorlawlerPoint::z(self : GraphcolorlawlerPoint) -> Double { self.z }

pub fn GraphcolorlawlerPoint::label(self : GraphcolorlawlerPoint) -> Int { self.label }

pub fn GraphcolorlawlerPoint::dist(self : GraphcolorlawlerPoint, other : GraphcolorlawlerPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn GraphcolorlawlerPoint::add(self : GraphcolorlawlerPoint, other : GraphcolorlawlerPoint) -> GraphcolorlawlerPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn GraphcolorlawlerPoint::sub(self : GraphcolorlawlerPoint, other : GraphcolorlawlerPoint) -> GraphcolorlawlerPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn GraphcolorlawlerPoint::scale(self : GraphcolorlawlerPoint, s : Double) -> GraphcolorlawlerPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn GraphcolorlawlerPoint::dot(self : GraphcolorlawlerPoint, other : GraphcolorlawlerPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn GraphcolorlawlerPoint::cross(self : GraphcolorlawlerPoint, other : GraphcolorlawlerPoint) -> GraphcolorlawlerPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn GraphcolorlawlerPoint::norm(self : GraphcolorlawlerPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn GraphcolorlawlerPoint::normalize(self : GraphcolorlawlerPoint) -> GraphcolorlawlerPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn GraphcolorlawlerPoint::negate(self : GraphcolorlawlerPoint) -> GraphcolorlawlerPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn GraphcolorlawlerPoint::mid(self : GraphcolorlawlerPoint, other : GraphcolorlawlerPoint) -> GraphcolorlawlerPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn GraphcolorlawlerPoint::lerp(self : GraphcolorlawlerPoint, other : GraphcolorlawlerPoint, t : Double) -> GraphcolorlawlerPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn GraphcolorlawlerPoint::to_string(self : GraphcolorlawlerPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct GraphcolorlawlerSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn graph_color_lawler_make_series(vals : Array[Double], name : String) -> GraphcolorlawlerSeries {
  { vals, name, meta: 0 }
}

pub fn GraphcolorlawlerSeries::len(self : GraphcolorlawlerSeries) -> Int { self.vals.length() }

pub fn GraphcolorlawlerSeries::sum(self : GraphcolorlawlerSeries) -> Double { @_common.sum(self.vals) }

pub fn GraphcolorlawlerSeries::mean(self : GraphcolorlawlerSeries) -> Double { @_common.mean(self.vals) }

pub fn GraphcolorlawlerSeries::min(self : GraphcolorlawlerSeries) -> Double { @_common.min(self.vals) }

pub fn GraphcolorlawlerSeries::max(self : GraphcolorlawlerSeries) -> Double { @_common.max(self.vals) }

pub fn GraphcolorlawlerSeries::range(self : GraphcolorlawlerSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn GraphcolorlawlerSeries::variance(self : GraphcolorlawlerSeries) -> Double { @_common.variance(self.vals) }

pub fn GraphcolorlawlerSeries::std(self : GraphcolorlawlerSeries) -> Double { @_common.std(self.vals) }

pub fn GraphcolorlawlerSeries::median(self : GraphcolorlawlerSeries) -> Double { @_common.median(self.vals) }

pub fn GraphcolorlawlerSeries::scale(self : GraphcolorlawlerSeries, f : Double) -> GraphcolorlawlerSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn GraphcolorlawlerSeries::add(self : GraphcolorlawlerSeries, other : GraphcolorlawlerSeries) -> GraphcolorlawlerSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn GraphcolorlawlerSeries::sub(self : GraphcolorlawlerSeries, other : GraphcolorlawlerSeries) -> GraphcolorlawlerSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn GraphcolorlawlerSeries::normalize(self : GraphcolorlawlerSeries) -> GraphcolorlawlerSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn GraphcolorlawlerSeries::cumsum(self : GraphcolorlawlerSeries) -> GraphcolorlawlerSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn GraphcolorlawlerSeries::to_string(self : GraphcolorlawlerSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct GraphcolorlawlerMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn graph_color_lawler_make_matrix(rows : Int, cols : Int, val : Double) -> GraphcolorlawlerMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn graph_color_lawler_matrix_identity(n : Int) -> GraphcolorlawlerMatrix {
  let m = graph_color_lawler_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn GraphcolorlawlerMatrix::get(self : GraphcolorlawlerMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn GraphcolorlawlerMatrix::transpose(self : GraphcolorlawlerMatrix) -> GraphcolorlawlerMatrix {
  let result = graph_color_lawler_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn GraphcolorlawlerMatrix::add(self : GraphcolorlawlerMatrix, other : GraphcolorlawlerMatrix) -> GraphcolorlawlerMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = graph_color_lawler_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn GraphcolorlawlerMatrix::scale(self : GraphcolorlawlerMatrix, s : Double) -> GraphcolorlawlerMatrix {
  let result = graph_color_lawler_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn GraphcolorlawlerMatrix::multiply(self : GraphcolorlawlerMatrix, other : GraphcolorlawlerMatrix) -> GraphcolorlawlerMatrix {
  if self.cols != other.rows { return graph_color_lawler_make_matrix(self.rows, other.cols, 0.0) }
  let result = graph_color_lawler_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn GraphcolorlawlerMatrix::trace(self : GraphcolorlawlerMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn GraphcolorlawlerMatrix::det(self : GraphcolorlawlerMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn GraphcolorlawlerMatrix::norm(self : GraphcolorlawlerMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn GraphcolorlawlerMatrix::to_string(self : GraphcolorlawlerMatrix) -> String {
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

pub(all) struct GraphcolorlawlerVector {
  comps : Array[Double]
  dim : Int
}

pub fn graph_color_lawler_make_vector(comps : Array[Double]) -> GraphcolorlawlerVector {
  { comps, dim: comps.length() }
}

pub fn graph_color_lawler_vector_zero(dim : Int) -> GraphcolorlawlerVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn GraphcolorlawlerVector::add(self : GraphcolorlawlerVector, other : GraphcolorlawlerVector) -> GraphcolorlawlerVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn GraphcolorlawlerVector::sub(self : GraphcolorlawlerVector, other : GraphcolorlawlerVector) -> GraphcolorlawlerVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn GraphcolorlawlerVector::scale(self : GraphcolorlawlerVector, s : Double) -> GraphcolorlawlerVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn GraphcolorlawlerVector::dot(self : GraphcolorlawlerVector, other : GraphcolorlawlerVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn GraphcolorlawlerVector::norm(self : GraphcolorlawlerVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn GraphcolorlawlerVector::normalize(self : GraphcolorlawlerVector) -> GraphcolorlawlerVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn GraphcolorlawlerVector::dist(self : GraphcolorlawlerVector, other : GraphcolorlawlerVector) -> Double {
  self.sub(other).norm()
}

pub fn GraphcolorlawlerVector::to_string(self : GraphcolorlawlerVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn graph_color_lawler_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn graph_color_lawler_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn graph_color_lawler_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn graph_color_lawler_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn graph_color_lawler_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn graph_color_lawler_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn graph_color_lawler_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn graph_color_lawler_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn graph_color_lawler_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn graph_color_lawler_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn graph_color_lawler_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn graph_color_lawler_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn graph_color_lawler_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn graph_color_lawler_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn graph_color_lawler_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn graph_color_lawler_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn graph_color_lawler_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn graph_color_lawler_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn graph_color_lawler_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn graph_color_lawler_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn graph_color_lawler_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn graph_color_lawler_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn graph_color_lawler_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn graph_color_lawler_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn graph_color_lawler_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn graph_color_lawler_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn graph_color_lawler_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn graph_color_lawler_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn graph_color_lawler_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct GraphcolorlawlerFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_color_lawler_frame_make(size : Int) -> GraphcolorlawlerFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_color_lawler_frame_len(s : GraphcolorlawlerFrame) -> Int { s.size }

pub fn graph_color_lawler_frame_get(s : GraphcolorlawlerFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_color_lawler_frame_set(s : GraphcolorlawlerFrame, i : Int, v : Double) -> GraphcolorlawlerFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_color_lawler_frame_sum(s : GraphcolorlawlerFrame) -> Double { @_common.sum(s.data) }

pub fn graph_color_lawler_frame_mean(s : GraphcolorlawlerFrame) -> Double { @_common.mean(s.data) }

pub fn graph_color_lawler_frame_scale(s : GraphcolorlawlerFrame, f : Double) -> GraphcolorlawlerFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_color_lawler_frame_add(a : GraphcolorlawlerFrame, b : GraphcolorlawlerFrame) -> GraphcolorlawlerFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_color_lawler_frame_copy(s : GraphcolorlawlerFrame) -> GraphcolorlawlerFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_color_lawler_frame_fill(s : GraphcolorlawlerFrame, v : Double) -> GraphcolorlawlerFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_color_lawler_frame_min(s : GraphcolorlawlerFrame) -> Double { @_common.min(s.data) }

pub fn graph_color_lawler_frame_max(s : GraphcolorlawlerFrame) -> Double { @_common.max(s.data) }

pub fn graph_color_lawler_frame_to_string(s : GraphcolorlawlerFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphcolorlawlerTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_color_lawler_table_make(size : Int) -> GraphcolorlawlerTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_color_lawler_table_len(s : GraphcolorlawlerTable) -> Int { s.size }

pub fn graph_color_lawler_table_get(s : GraphcolorlawlerTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_color_lawler_table_set(s : GraphcolorlawlerTable, i : Int, v : Double) -> GraphcolorlawlerTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_color_lawler_table_sum(s : GraphcolorlawlerTable) -> Double { @_common.sum(s.data) }

pub fn graph_color_lawler_table_mean(s : GraphcolorlawlerTable) -> Double { @_common.mean(s.data) }

pub fn graph_color_lawler_table_scale(s : GraphcolorlawlerTable, f : Double) -> GraphcolorlawlerTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_color_lawler_table_add(a : GraphcolorlawlerTable, b : GraphcolorlawlerTable) -> GraphcolorlawlerTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_color_lawler_table_copy(s : GraphcolorlawlerTable) -> GraphcolorlawlerTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_color_lawler_table_fill(s : GraphcolorlawlerTable, v : Double) -> GraphcolorlawlerTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_color_lawler_table_min(s : GraphcolorlawlerTable) -> Double { @_common.min(s.data) }

pub fn graph_color_lawler_table_max(s : GraphcolorlawlerTable) -> Double { @_common.max(s.data) }

pub fn graph_color_lawler_table_to_string(s : GraphcolorlawlerTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphcolorlawlerGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_color_lawler_graphn_make(size : Int) -> GraphcolorlawlerGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_color_lawler_graphn_len(s : GraphcolorlawlerGraphN) -> Int { s.size }

pub fn graph_color_lawler_graphn_get(s : GraphcolorlawlerGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_color_lawler_graphn_set(s : GraphcolorlawlerGraphN, i : Int, v : Double) -> GraphcolorlawlerGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_color_lawler_graphn_sum(s : GraphcolorlawlerGraphN) -> Double { @_common.sum(s.data) }

pub fn graph_color_lawler_graphn_mean(s : GraphcolorlawlerGraphN) -> Double { @_common.mean(s.data) }

pub fn graph_color_lawler_graphn_scale(s : GraphcolorlawlerGraphN, f : Double) -> GraphcolorlawlerGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_color_lawler_graphn_add(a : GraphcolorlawlerGraphN, b : GraphcolorlawlerGraphN) -> GraphcolorlawlerGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_color_lawler_graphn_copy(s : GraphcolorlawlerGraphN) -> GraphcolorlawlerGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_color_lawler_graphn_fill(s : GraphcolorlawlerGraphN, v : Double) -> GraphcolorlawlerGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_color_lawler_graphn_min(s : GraphcolorlawlerGraphN) -> Double { @_common.min(s.data) }

pub fn graph_color_lawler_graphn_max(s : GraphcolorlawlerGraphN) -> Double { @_common.max(s.data) }

pub fn graph_color_lawler_graphn_to_string(s : GraphcolorlawlerGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphcolorlawlerNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_color_lawler_node_make(size : Int) -> GraphcolorlawlerNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_color_lawler_node_len(s : GraphcolorlawlerNode) -> Int { s.size }

pub fn graph_color_lawler_node_get(s : GraphcolorlawlerNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_color_lawler_node_set(s : GraphcolorlawlerNode, i : Int, v : Double) -> GraphcolorlawlerNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_color_lawler_node_sum(s : GraphcolorlawlerNode) -> Double { @_common.sum(s.data) }

pub fn graph_color_lawler_node_mean(s : GraphcolorlawlerNode) -> Double { @_common.mean(s.data) }

pub fn graph_color_lawler_node_scale(s : GraphcolorlawlerNode, f : Double) -> GraphcolorlawlerNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_color_lawler_node_add(a : GraphcolorlawlerNode, b : GraphcolorlawlerNode) -> GraphcolorlawlerNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_color_lawler_node_copy(s : GraphcolorlawlerNode) -> GraphcolorlawlerNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_color_lawler_node_fill(s : GraphcolorlawlerNode, v : Double) -> GraphcolorlawlerNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_color_lawler_node_min(s : GraphcolorlawlerNode) -> Double { @_common.min(s.data) }

pub fn graph_color_lawler_node_max(s : GraphcolorlawlerNode) -> Double { @_common.max(s.data) }

pub fn graph_color_lawler_node_to_string(s : GraphcolorlawlerNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphcolorlawlerEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_color_lawler_edge_make(size : Int) -> GraphcolorlawlerEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_color_lawler_edge_len(s : GraphcolorlawlerEdge) -> Int { s.size }

pub fn graph_color_lawler_edge_get(s : GraphcolorlawlerEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_color_lawler_edge_set(s : GraphcolorlawlerEdge, i : Int, v : Double) -> GraphcolorlawlerEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_color_lawler_edge_sum(s : GraphcolorlawlerEdge) -> Double { @_common.sum(s.data) }

pub fn graph_color_lawler_edge_mean(s : GraphcolorlawlerEdge) -> Double { @_common.mean(s.data) }

pub fn graph_color_lawler_edge_scale(s : GraphcolorlawlerEdge, f : Double) -> GraphcolorlawlerEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_color_lawler_edge_add(a : GraphcolorlawlerEdge, b : GraphcolorlawlerEdge) -> GraphcolorlawlerEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_color_lawler_edge_copy(s : GraphcolorlawlerEdge) -> GraphcolorlawlerEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_color_lawler_edge_fill(s : GraphcolorlawlerEdge, v : Double) -> GraphcolorlawlerEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_color_lawler_edge_min(s : GraphcolorlawlerEdge) -> Double { @_common.min(s.data) }

pub fn graph_color_lawler_edge_max(s : GraphcolorlawlerEdge) -> Double { @_common.max(s.data) }

pub fn graph_color_lawler_edge_to_string(s : GraphcolorlawlerEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphcolorlawlerPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_color_lawler_path_make(size : Int) -> GraphcolorlawlerPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_color_lawler_path_len(s : GraphcolorlawlerPath) -> Int { s.size }

pub fn graph_color_lawler_path_get(s : GraphcolorlawlerPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_color_lawler_path_set(s : GraphcolorlawlerPath, i : Int, v : Double) -> GraphcolorlawlerPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_color_lawler_path_sum(s : GraphcolorlawlerPath) -> Double { @_common.sum(s.data) }

pub fn graph_color_lawler_path_mean(s : GraphcolorlawlerPath) -> Double { @_common.mean(s.data) }

pub fn graph_color_lawler_path_scale(s : GraphcolorlawlerPath, f : Double) -> GraphcolorlawlerPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_color_lawler_path_add(a : GraphcolorlawlerPath, b : GraphcolorlawlerPath) -> GraphcolorlawlerPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_color_lawler_path_copy(s : GraphcolorlawlerPath) -> GraphcolorlawlerPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_color_lawler_path_fill(s : GraphcolorlawlerPath, v : Double) -> GraphcolorlawlerPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_color_lawler_path_min(s : GraphcolorlawlerPath) -> Double { @_common.min(s.data) }

pub fn graph_color_lawler_path_max(s : GraphcolorlawlerPath) -> Double { @_common.max(s.data) }

pub fn graph_color_lawler_path_to_string(s : GraphcolorlawlerPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphcolorlawlerCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_color_lawler_cluster_make(size : Int) -> GraphcolorlawlerCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_color_lawler_cluster_len(s : GraphcolorlawlerCluster) -> Int { s.size }

pub fn graph_color_lawler_cluster_get(s : GraphcolorlawlerCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_color_lawler_cluster_set(s : GraphcolorlawlerCluster, i : Int, v : Double) -> GraphcolorlawlerCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_color_lawler_cluster_sum(s : GraphcolorlawlerCluster) -> Double { @_common.sum(s.data) }

pub fn graph_color_lawler_cluster_mean(s : GraphcolorlawlerCluster) -> Double { @_common.mean(s.data) }

pub fn graph_color_lawler_cluster_scale(s : GraphcolorlawlerCluster, f : Double) -> GraphcolorlawlerCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_color_lawler_cluster_add(a : GraphcolorlawlerCluster, b : GraphcolorlawlerCluster) -> GraphcolorlawlerCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_color_lawler_cluster_copy(s : GraphcolorlawlerCluster) -> GraphcolorlawlerCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_color_lawler_cluster_fill(s : GraphcolorlawlerCluster, v : Double) -> GraphcolorlawlerCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_color_lawler_cluster_min(s : GraphcolorlawlerCluster) -> Double { @_common.min(s.data) }

pub fn graph_color_lawler_cluster_max(s : GraphcolorlawlerCluster) -> Double { @_common.max(s.data) }

pub fn graph_color_lawler_cluster_to_string(s : GraphcolorlawlerCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphcolorlawlerModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_color_lawler_model_make(size : Int) -> GraphcolorlawlerModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_color_lawler_model_len(s : GraphcolorlawlerModel) -> Int { s.size }

pub fn graph_color_lawler_model_get(s : GraphcolorlawlerModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_color_lawler_model_set(s : GraphcolorlawlerModel, i : Int, v : Double) -> GraphcolorlawlerModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_color_lawler_model_sum(s : GraphcolorlawlerModel) -> Double { @_common.sum(s.data) }

pub fn graph_color_lawler_model_mean(s : GraphcolorlawlerModel) -> Double { @_common.mean(s.data) }

pub fn graph_color_lawler_model_scale(s : GraphcolorlawlerModel, f : Double) -> GraphcolorlawlerModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_color_lawler_model_add(a : GraphcolorlawlerModel, b : GraphcolorlawlerModel) -> GraphcolorlawlerModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_color_lawler_model_copy(s : GraphcolorlawlerModel) -> GraphcolorlawlerModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_color_lawler_model_fill(s : GraphcolorlawlerModel, v : Double) -> GraphcolorlawlerModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_color_lawler_model_min(s : GraphcolorlawlerModel) -> Double { @_common.min(s.data) }

pub fn graph_color_lawler_model_max(s : GraphcolorlawlerModel) -> Double { @_common.max(s.data) }

pub fn graph_color_lawler_model_to_string(s : GraphcolorlawlerModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphcolorlawlerLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_color_lawler_layer_make(size : Int) -> GraphcolorlawlerLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_color_lawler_layer_len(s : GraphcolorlawlerLayer) -> Int { s.size }

pub fn graph_color_lawler_layer_get(s : GraphcolorlawlerLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_color_lawler_layer_set(s : GraphcolorlawlerLayer, i : Int, v : Double) -> GraphcolorlawlerLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_color_lawler_layer_sum(s : GraphcolorlawlerLayer) -> Double { @_common.sum(s.data) }

pub fn graph_color_lawler_layer_mean(s : GraphcolorlawlerLayer) -> Double { @_common.mean(s.data) }

pub fn graph_color_lawler_layer_scale(s : GraphcolorlawlerLayer, f : Double) -> GraphcolorlawlerLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_color_lawler_layer_add(a : GraphcolorlawlerLayer, b : GraphcolorlawlerLayer) -> GraphcolorlawlerLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_color_lawler_layer_copy(s : GraphcolorlawlerLayer) -> GraphcolorlawlerLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_color_lawler_layer_fill(s : GraphcolorlawlerLayer, v : Double) -> GraphcolorlawlerLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_color_lawler_layer_min(s : GraphcolorlawlerLayer) -> Double { @_common.min(s.data) }

pub fn graph_color_lawler_layer_max(s : GraphcolorlawlerLayer) -> Double { @_common.max(s.data) }

pub fn graph_color_lawler_layer_to_string(s : GraphcolorlawlerLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphcolorlawlerBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_color_lawler_buffer_make(size : Int) -> GraphcolorlawlerBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_color_lawler_buffer_len(s : GraphcolorlawlerBuffer) -> Int { s.size }

pub fn graph_color_lawler_buffer_get(s : GraphcolorlawlerBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_color_lawler_buffer_set(s : GraphcolorlawlerBuffer, i : Int, v : Double) -> GraphcolorlawlerBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_color_lawler_buffer_sum(s : GraphcolorlawlerBuffer) -> Double { @_common.sum(s.data) }

pub fn graph_color_lawler_buffer_mean(s : GraphcolorlawlerBuffer) -> Double { @_common.mean(s.data) }

pub fn graph_color_lawler_buffer_scale(s : GraphcolorlawlerBuffer, f : Double) -> GraphcolorlawlerBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_color_lawler_buffer_add(a : GraphcolorlawlerBuffer, b : GraphcolorlawlerBuffer) -> GraphcolorlawlerBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_color_lawler_buffer_copy(s : GraphcolorlawlerBuffer) -> GraphcolorlawlerBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_color_lawler_buffer_fill(s : GraphcolorlawlerBuffer, v : Double) -> GraphcolorlawlerBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_color_lawler_buffer_min(s : GraphcolorlawlerBuffer) -> Double { @_common.min(s.data) }

pub fn graph_color_lawler_buffer_max(s : GraphcolorlawlerBuffer) -> Double { @_common.max(s.data) }

pub fn graph_color_lawler_buffer_to_string(s : GraphcolorlawlerBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphcolorlawlerCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_color_lawler_cursor_make(size : Int) -> GraphcolorlawlerCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_color_lawler_cursor_len(s : GraphcolorlawlerCursor) -> Int { s.size }

pub fn graph_color_lawler_cursor_get(s : GraphcolorlawlerCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_color_lawler_cursor_set(s : GraphcolorlawlerCursor, i : Int, v : Double) -> GraphcolorlawlerCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_color_lawler_cursor_sum(s : GraphcolorlawlerCursor) -> Double { @_common.sum(s.data) }

pub fn graph_color_lawler_cursor_mean(s : GraphcolorlawlerCursor) -> Double { @_common.mean(s.data) }

pub fn graph_color_lawler_cursor_scale(s : GraphcolorlawlerCursor, f : Double) -> GraphcolorlawlerCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_color_lawler_cursor_add(a : GraphcolorlawlerCursor, b : GraphcolorlawlerCursor) -> GraphcolorlawlerCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_color_lawler_cursor_copy(s : GraphcolorlawlerCursor) -> GraphcolorlawlerCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_color_lawler_cursor_fill(s : GraphcolorlawlerCursor, v : Double) -> GraphcolorlawlerCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_color_lawler_cursor_min(s : GraphcolorlawlerCursor) -> Double { @_common.min(s.data) }

pub fn graph_color_lawler_cursor_max(s : GraphcolorlawlerCursor) -> Double { @_common.max(s.data) }

pub fn graph_color_lawler_cursor_to_string(s : GraphcolorlawlerCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphcolorlawlerView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_color_lawler_view_make(size : Int) -> GraphcolorlawlerView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_color_lawler_view_len(s : GraphcolorlawlerView) -> Int { s.size }

pub fn graph_color_lawler_view_get(s : GraphcolorlawlerView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_color_lawler_view_set(s : GraphcolorlawlerView, i : Int, v : Double) -> GraphcolorlawlerView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_color_lawler_view_sum(s : GraphcolorlawlerView) -> Double { @_common.sum(s.data) }

pub fn graph_color_lawler_view_mean(s : GraphcolorlawlerView) -> Double { @_common.mean(s.data) }

pub fn graph_color_lawler_view_scale(s : GraphcolorlawlerView, f : Double) -> GraphcolorlawlerView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_color_lawler_view_add(a : GraphcolorlawlerView, b : GraphcolorlawlerView) -> GraphcolorlawlerView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_color_lawler_view_copy(s : GraphcolorlawlerView) -> GraphcolorlawlerView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_color_lawler_view_fill(s : GraphcolorlawlerView, v : Double) -> GraphcolorlawlerView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_color_lawler_view_min(s : GraphcolorlawlerView) -> Double { @_common.min(s.data) }

pub fn graph_color_lawler_view_max(s : GraphcolorlawlerView) -> Double { @_common.max(s.data) }

pub fn graph_color_lawler_view_to_string(s : GraphcolorlawlerView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphcolorlawlerRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_color_lawler_range_make(size : Int) -> GraphcolorlawlerRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_color_lawler_range_len(s : GraphcolorlawlerRange) -> Int { s.size }

pub fn graph_color_lawler_range_get(s : GraphcolorlawlerRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_color_lawler_range_set(s : GraphcolorlawlerRange, i : Int, v : Double) -> GraphcolorlawlerRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_color_lawler_range_sum(s : GraphcolorlawlerRange) -> Double { @_common.sum(s.data) }

pub fn graph_color_lawler_range_mean(s : GraphcolorlawlerRange) -> Double { @_common.mean(s.data) }

pub fn graph_color_lawler_range_scale(s : GraphcolorlawlerRange, f : Double) -> GraphcolorlawlerRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_color_lawler_range_add(a : GraphcolorlawlerRange, b : GraphcolorlawlerRange) -> GraphcolorlawlerRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_color_lawler_range_copy(s : GraphcolorlawlerRange) -> GraphcolorlawlerRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_color_lawler_range_fill(s : GraphcolorlawlerRange, v : Double) -> GraphcolorlawlerRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_color_lawler_range_min(s : GraphcolorlawlerRange) -> Double { @_common.min(s.data) }

pub fn graph_color_lawler_range_max(s : GraphcolorlawlerRange) -> Double { @_common.max(s.data) }

pub fn graph_color_lawler_range_to_string(s : GraphcolorlawlerRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphcolorlawlerSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_color_lawler_slice_make(size : Int) -> GraphcolorlawlerSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_color_lawler_slice_len(s : GraphcolorlawlerSlice) -> Int { s.size }

pub fn graph_color_lawler_slice_get(s : GraphcolorlawlerSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_color_lawler_slice_set(s : GraphcolorlawlerSlice, i : Int, v : Double) -> GraphcolorlawlerSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_color_lawler_slice_sum(s : GraphcolorlawlerSlice) -> Double { @_common.sum(s.data) }

pub fn graph_color_lawler_slice_mean(s : GraphcolorlawlerSlice) -> Double { @_common.mean(s.data) }

pub fn graph_color_lawler_slice_scale(s : GraphcolorlawlerSlice, f : Double) -> GraphcolorlawlerSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_color_lawler_slice_add(a : GraphcolorlawlerSlice, b : GraphcolorlawlerSlice) -> GraphcolorlawlerSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_color_lawler_slice_copy(s : GraphcolorlawlerSlice) -> GraphcolorlawlerSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_color_lawler_slice_fill(s : GraphcolorlawlerSlice, v : Double) -> GraphcolorlawlerSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_color_lawler_slice_min(s : GraphcolorlawlerSlice) -> Double { @_common.min(s.data) }

pub fn graph_color_lawler_slice_max(s : GraphcolorlawlerSlice) -> Double { @_common.max(s.data) }

pub fn graph_color_lawler_slice_to_string(s : GraphcolorlawlerSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

