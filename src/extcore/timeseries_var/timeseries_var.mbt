///===
/// extcore/timeseries_var

pub(all) struct TimeseriesvarPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn timeseries_var_make_point(x : Double, y : Double) -> TimeseriesvarPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn timeseries_var_make_point3(x : Double, y : Double, z : Double) -> TimeseriesvarPoint {
  { x, y, z, label: 0 }
}

pub fn TimeseriesvarPoint::x(self : TimeseriesvarPoint) -> Double { self.x }

pub fn TimeseriesvarPoint::y(self : TimeseriesvarPoint) -> Double { self.y }

pub fn TimeseriesvarPoint::z(self : TimeseriesvarPoint) -> Double { self.z }

pub fn TimeseriesvarPoint::label(self : TimeseriesvarPoint) -> Int { self.label }

pub fn TimeseriesvarPoint::dist(self : TimeseriesvarPoint, other : TimeseriesvarPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn TimeseriesvarPoint::add(self : TimeseriesvarPoint, other : TimeseriesvarPoint) -> TimeseriesvarPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn TimeseriesvarPoint::sub(self : TimeseriesvarPoint, other : TimeseriesvarPoint) -> TimeseriesvarPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn TimeseriesvarPoint::scale(self : TimeseriesvarPoint, s : Double) -> TimeseriesvarPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn TimeseriesvarPoint::dot(self : TimeseriesvarPoint, other : TimeseriesvarPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn TimeseriesvarPoint::cross(self : TimeseriesvarPoint, other : TimeseriesvarPoint) -> TimeseriesvarPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn TimeseriesvarPoint::norm(self : TimeseriesvarPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn TimeseriesvarPoint::normalize(self : TimeseriesvarPoint) -> TimeseriesvarPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn TimeseriesvarPoint::negate(self : TimeseriesvarPoint) -> TimeseriesvarPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn TimeseriesvarPoint::mid(self : TimeseriesvarPoint, other : TimeseriesvarPoint) -> TimeseriesvarPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn TimeseriesvarPoint::lerp(self : TimeseriesvarPoint, other : TimeseriesvarPoint, t : Double) -> TimeseriesvarPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn TimeseriesvarPoint::to_string(self : TimeseriesvarPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct TimeseriesvarSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn timeseries_var_make_series(vals : Array[Double], name : String) -> TimeseriesvarSeries {
  { vals, name, meta: 0 }
}

pub fn TimeseriesvarSeries::len(self : TimeseriesvarSeries) -> Int { self.vals.length() }

pub fn TimeseriesvarSeries::sum(self : TimeseriesvarSeries) -> Double { @_common.sum(self.vals) }

pub fn TimeseriesvarSeries::mean(self : TimeseriesvarSeries) -> Double { @_common.mean(self.vals) }

pub fn TimeseriesvarSeries::min(self : TimeseriesvarSeries) -> Double { @_common.min(self.vals) }

pub fn TimeseriesvarSeries::max(self : TimeseriesvarSeries) -> Double { @_common.max(self.vals) }

pub fn TimeseriesvarSeries::range(self : TimeseriesvarSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn TimeseriesvarSeries::variance(self : TimeseriesvarSeries) -> Double { @_common.variance(self.vals) }

pub fn TimeseriesvarSeries::std(self : TimeseriesvarSeries) -> Double { @_common.std(self.vals) }

pub fn TimeseriesvarSeries::median(self : TimeseriesvarSeries) -> Double { @_common.median(self.vals) }

pub fn TimeseriesvarSeries::scale(self : TimeseriesvarSeries, f : Double) -> TimeseriesvarSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn TimeseriesvarSeries::add(self : TimeseriesvarSeries, other : TimeseriesvarSeries) -> TimeseriesvarSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn TimeseriesvarSeries::sub(self : TimeseriesvarSeries, other : TimeseriesvarSeries) -> TimeseriesvarSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn TimeseriesvarSeries::normalize(self : TimeseriesvarSeries) -> TimeseriesvarSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn TimeseriesvarSeries::cumsum(self : TimeseriesvarSeries) -> TimeseriesvarSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn TimeseriesvarSeries::to_string(self : TimeseriesvarSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct TimeseriesvarMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn timeseries_var_make_matrix(rows : Int, cols : Int, val : Double) -> TimeseriesvarMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn timeseries_var_matrix_identity(n : Int) -> TimeseriesvarMatrix {
  let m = timeseries_var_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn TimeseriesvarMatrix::get(self : TimeseriesvarMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn TimeseriesvarMatrix::transpose(self : TimeseriesvarMatrix) -> TimeseriesvarMatrix {
  let result = timeseries_var_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn TimeseriesvarMatrix::add(self : TimeseriesvarMatrix, other : TimeseriesvarMatrix) -> TimeseriesvarMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = timeseries_var_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn TimeseriesvarMatrix::scale(self : TimeseriesvarMatrix, s : Double) -> TimeseriesvarMatrix {
  let result = timeseries_var_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn TimeseriesvarMatrix::multiply(self : TimeseriesvarMatrix, other : TimeseriesvarMatrix) -> TimeseriesvarMatrix {
  if self.cols != other.rows { return timeseries_var_make_matrix(self.rows, other.cols, 0.0) }
  let result = timeseries_var_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn TimeseriesvarMatrix::trace(self : TimeseriesvarMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn TimeseriesvarMatrix::det(self : TimeseriesvarMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn TimeseriesvarMatrix::norm(self : TimeseriesvarMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn TimeseriesvarMatrix::to_string(self : TimeseriesvarMatrix) -> String {
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

pub(all) struct TimeseriesvarVector {
  comps : Array[Double]
  dim : Int
}

pub fn timeseries_var_make_vector(comps : Array[Double]) -> TimeseriesvarVector {
  { comps, dim: comps.length() }
}

pub fn timeseries_var_vector_zero(dim : Int) -> TimeseriesvarVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn TimeseriesvarVector::add(self : TimeseriesvarVector, other : TimeseriesvarVector) -> TimeseriesvarVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn TimeseriesvarVector::sub(self : TimeseriesvarVector, other : TimeseriesvarVector) -> TimeseriesvarVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn TimeseriesvarVector::scale(self : TimeseriesvarVector, s : Double) -> TimeseriesvarVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn TimeseriesvarVector::dot(self : TimeseriesvarVector, other : TimeseriesvarVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn TimeseriesvarVector::norm(self : TimeseriesvarVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn TimeseriesvarVector::normalize(self : TimeseriesvarVector) -> TimeseriesvarVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn TimeseriesvarVector::dist(self : TimeseriesvarVector, other : TimeseriesvarVector) -> Double {
  self.sub(other).norm()
}

pub fn TimeseriesvarVector::to_string(self : TimeseriesvarVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn timeseries_var_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn timeseries_var_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn timeseries_var_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn timeseries_var_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn timeseries_var_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn timeseries_var_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn timeseries_var_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn timeseries_var_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn timeseries_var_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn timeseries_var_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn timeseries_var_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn timeseries_var_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn timeseries_var_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn timeseries_var_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn timeseries_var_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn timeseries_var_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn timeseries_var_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn timeseries_var_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn timeseries_var_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn timeseries_var_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn timeseries_var_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn timeseries_var_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn timeseries_var_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn timeseries_var_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn timeseries_var_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn timeseries_var_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn timeseries_var_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn timeseries_var_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn timeseries_var_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct TimeseriesvarFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_var_frame_make(size : Int) -> TimeseriesvarFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_var_frame_len(s : TimeseriesvarFrame) -> Int { s.size }

pub fn timeseries_var_frame_get(s : TimeseriesvarFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_var_frame_set(s : TimeseriesvarFrame, i : Int, v : Double) -> TimeseriesvarFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_var_frame_sum(s : TimeseriesvarFrame) -> Double { @_common.sum(s.data) }

pub fn timeseries_var_frame_mean(s : TimeseriesvarFrame) -> Double { @_common.mean(s.data) }

pub fn timeseries_var_frame_scale(s : TimeseriesvarFrame, f : Double) -> TimeseriesvarFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_var_frame_add(a : TimeseriesvarFrame, b : TimeseriesvarFrame) -> TimeseriesvarFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_var_frame_copy(s : TimeseriesvarFrame) -> TimeseriesvarFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_var_frame_fill(s : TimeseriesvarFrame, v : Double) -> TimeseriesvarFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_var_frame_min(s : TimeseriesvarFrame) -> Double { @_common.min(s.data) }

pub fn timeseries_var_frame_max(s : TimeseriesvarFrame) -> Double { @_common.max(s.data) }

pub fn timeseries_var_frame_to_string(s : TimeseriesvarFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesvarTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_var_table_make(size : Int) -> TimeseriesvarTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_var_table_len(s : TimeseriesvarTable) -> Int { s.size }

pub fn timeseries_var_table_get(s : TimeseriesvarTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_var_table_set(s : TimeseriesvarTable, i : Int, v : Double) -> TimeseriesvarTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_var_table_sum(s : TimeseriesvarTable) -> Double { @_common.sum(s.data) }

pub fn timeseries_var_table_mean(s : TimeseriesvarTable) -> Double { @_common.mean(s.data) }

pub fn timeseries_var_table_scale(s : TimeseriesvarTable, f : Double) -> TimeseriesvarTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_var_table_add(a : TimeseriesvarTable, b : TimeseriesvarTable) -> TimeseriesvarTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_var_table_copy(s : TimeseriesvarTable) -> TimeseriesvarTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_var_table_fill(s : TimeseriesvarTable, v : Double) -> TimeseriesvarTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_var_table_min(s : TimeseriesvarTable) -> Double { @_common.min(s.data) }

pub fn timeseries_var_table_max(s : TimeseriesvarTable) -> Double { @_common.max(s.data) }

pub fn timeseries_var_table_to_string(s : TimeseriesvarTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesvarGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_var_graphn_make(size : Int) -> TimeseriesvarGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_var_graphn_len(s : TimeseriesvarGraphN) -> Int { s.size }

pub fn timeseries_var_graphn_get(s : TimeseriesvarGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_var_graphn_set(s : TimeseriesvarGraphN, i : Int, v : Double) -> TimeseriesvarGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_var_graphn_sum(s : TimeseriesvarGraphN) -> Double { @_common.sum(s.data) }

pub fn timeseries_var_graphn_mean(s : TimeseriesvarGraphN) -> Double { @_common.mean(s.data) }

pub fn timeseries_var_graphn_scale(s : TimeseriesvarGraphN, f : Double) -> TimeseriesvarGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_var_graphn_add(a : TimeseriesvarGraphN, b : TimeseriesvarGraphN) -> TimeseriesvarGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_var_graphn_copy(s : TimeseriesvarGraphN) -> TimeseriesvarGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_var_graphn_fill(s : TimeseriesvarGraphN, v : Double) -> TimeseriesvarGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_var_graphn_min(s : TimeseriesvarGraphN) -> Double { @_common.min(s.data) }

pub fn timeseries_var_graphn_max(s : TimeseriesvarGraphN) -> Double { @_common.max(s.data) }

pub fn timeseries_var_graphn_to_string(s : TimeseriesvarGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesvarNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_var_node_make(size : Int) -> TimeseriesvarNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_var_node_len(s : TimeseriesvarNode) -> Int { s.size }

pub fn timeseries_var_node_get(s : TimeseriesvarNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_var_node_set(s : TimeseriesvarNode, i : Int, v : Double) -> TimeseriesvarNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_var_node_sum(s : TimeseriesvarNode) -> Double { @_common.sum(s.data) }

pub fn timeseries_var_node_mean(s : TimeseriesvarNode) -> Double { @_common.mean(s.data) }

pub fn timeseries_var_node_scale(s : TimeseriesvarNode, f : Double) -> TimeseriesvarNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_var_node_add(a : TimeseriesvarNode, b : TimeseriesvarNode) -> TimeseriesvarNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_var_node_copy(s : TimeseriesvarNode) -> TimeseriesvarNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_var_node_fill(s : TimeseriesvarNode, v : Double) -> TimeseriesvarNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_var_node_min(s : TimeseriesvarNode) -> Double { @_common.min(s.data) }

pub fn timeseries_var_node_max(s : TimeseriesvarNode) -> Double { @_common.max(s.data) }

pub fn timeseries_var_node_to_string(s : TimeseriesvarNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesvarEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_var_edge_make(size : Int) -> TimeseriesvarEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_var_edge_len(s : TimeseriesvarEdge) -> Int { s.size }

pub fn timeseries_var_edge_get(s : TimeseriesvarEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_var_edge_set(s : TimeseriesvarEdge, i : Int, v : Double) -> TimeseriesvarEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_var_edge_sum(s : TimeseriesvarEdge) -> Double { @_common.sum(s.data) }

pub fn timeseries_var_edge_mean(s : TimeseriesvarEdge) -> Double { @_common.mean(s.data) }

pub fn timeseries_var_edge_scale(s : TimeseriesvarEdge, f : Double) -> TimeseriesvarEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_var_edge_add(a : TimeseriesvarEdge, b : TimeseriesvarEdge) -> TimeseriesvarEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_var_edge_copy(s : TimeseriesvarEdge) -> TimeseriesvarEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_var_edge_fill(s : TimeseriesvarEdge, v : Double) -> TimeseriesvarEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_var_edge_min(s : TimeseriesvarEdge) -> Double { @_common.min(s.data) }

pub fn timeseries_var_edge_max(s : TimeseriesvarEdge) -> Double { @_common.max(s.data) }

pub fn timeseries_var_edge_to_string(s : TimeseriesvarEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesvarPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_var_path_make(size : Int) -> TimeseriesvarPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_var_path_len(s : TimeseriesvarPath) -> Int { s.size }

pub fn timeseries_var_path_get(s : TimeseriesvarPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_var_path_set(s : TimeseriesvarPath, i : Int, v : Double) -> TimeseriesvarPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_var_path_sum(s : TimeseriesvarPath) -> Double { @_common.sum(s.data) }

pub fn timeseries_var_path_mean(s : TimeseriesvarPath) -> Double { @_common.mean(s.data) }

pub fn timeseries_var_path_scale(s : TimeseriesvarPath, f : Double) -> TimeseriesvarPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_var_path_add(a : TimeseriesvarPath, b : TimeseriesvarPath) -> TimeseriesvarPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_var_path_copy(s : TimeseriesvarPath) -> TimeseriesvarPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_var_path_fill(s : TimeseriesvarPath, v : Double) -> TimeseriesvarPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_var_path_min(s : TimeseriesvarPath) -> Double { @_common.min(s.data) }

pub fn timeseries_var_path_max(s : TimeseriesvarPath) -> Double { @_common.max(s.data) }

pub fn timeseries_var_path_to_string(s : TimeseriesvarPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesvarCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_var_cluster_make(size : Int) -> TimeseriesvarCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_var_cluster_len(s : TimeseriesvarCluster) -> Int { s.size }

pub fn timeseries_var_cluster_get(s : TimeseriesvarCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_var_cluster_set(s : TimeseriesvarCluster, i : Int, v : Double) -> TimeseriesvarCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_var_cluster_sum(s : TimeseriesvarCluster) -> Double { @_common.sum(s.data) }

pub fn timeseries_var_cluster_mean(s : TimeseriesvarCluster) -> Double { @_common.mean(s.data) }

pub fn timeseries_var_cluster_scale(s : TimeseriesvarCluster, f : Double) -> TimeseriesvarCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_var_cluster_add(a : TimeseriesvarCluster, b : TimeseriesvarCluster) -> TimeseriesvarCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_var_cluster_copy(s : TimeseriesvarCluster) -> TimeseriesvarCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_var_cluster_fill(s : TimeseriesvarCluster, v : Double) -> TimeseriesvarCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_var_cluster_min(s : TimeseriesvarCluster) -> Double { @_common.min(s.data) }

pub fn timeseries_var_cluster_max(s : TimeseriesvarCluster) -> Double { @_common.max(s.data) }

pub fn timeseries_var_cluster_to_string(s : TimeseriesvarCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesvarModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_var_model_make(size : Int) -> TimeseriesvarModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_var_model_len(s : TimeseriesvarModel) -> Int { s.size }

pub fn timeseries_var_model_get(s : TimeseriesvarModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_var_model_set(s : TimeseriesvarModel, i : Int, v : Double) -> TimeseriesvarModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_var_model_sum(s : TimeseriesvarModel) -> Double { @_common.sum(s.data) }

pub fn timeseries_var_model_mean(s : TimeseriesvarModel) -> Double { @_common.mean(s.data) }

pub fn timeseries_var_model_scale(s : TimeseriesvarModel, f : Double) -> TimeseriesvarModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_var_model_add(a : TimeseriesvarModel, b : TimeseriesvarModel) -> TimeseriesvarModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_var_model_copy(s : TimeseriesvarModel) -> TimeseriesvarModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_var_model_fill(s : TimeseriesvarModel, v : Double) -> TimeseriesvarModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_var_model_min(s : TimeseriesvarModel) -> Double { @_common.min(s.data) }

pub fn timeseries_var_model_max(s : TimeseriesvarModel) -> Double { @_common.max(s.data) }

pub fn timeseries_var_model_to_string(s : TimeseriesvarModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesvarLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_var_layer_make(size : Int) -> TimeseriesvarLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_var_layer_len(s : TimeseriesvarLayer) -> Int { s.size }

pub fn timeseries_var_layer_get(s : TimeseriesvarLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_var_layer_set(s : TimeseriesvarLayer, i : Int, v : Double) -> TimeseriesvarLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_var_layer_sum(s : TimeseriesvarLayer) -> Double { @_common.sum(s.data) }

pub fn timeseries_var_layer_mean(s : TimeseriesvarLayer) -> Double { @_common.mean(s.data) }

pub fn timeseries_var_layer_scale(s : TimeseriesvarLayer, f : Double) -> TimeseriesvarLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_var_layer_add(a : TimeseriesvarLayer, b : TimeseriesvarLayer) -> TimeseriesvarLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_var_layer_copy(s : TimeseriesvarLayer) -> TimeseriesvarLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_var_layer_fill(s : TimeseriesvarLayer, v : Double) -> TimeseriesvarLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_var_layer_min(s : TimeseriesvarLayer) -> Double { @_common.min(s.data) }

pub fn timeseries_var_layer_max(s : TimeseriesvarLayer) -> Double { @_common.max(s.data) }

pub fn timeseries_var_layer_to_string(s : TimeseriesvarLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesvarBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_var_buffer_make(size : Int) -> TimeseriesvarBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_var_buffer_len(s : TimeseriesvarBuffer) -> Int { s.size }

pub fn timeseries_var_buffer_get(s : TimeseriesvarBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_var_buffer_set(s : TimeseriesvarBuffer, i : Int, v : Double) -> TimeseriesvarBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_var_buffer_sum(s : TimeseriesvarBuffer) -> Double { @_common.sum(s.data) }

pub fn timeseries_var_buffer_mean(s : TimeseriesvarBuffer) -> Double { @_common.mean(s.data) }

pub fn timeseries_var_buffer_scale(s : TimeseriesvarBuffer, f : Double) -> TimeseriesvarBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_var_buffer_add(a : TimeseriesvarBuffer, b : TimeseriesvarBuffer) -> TimeseriesvarBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_var_buffer_copy(s : TimeseriesvarBuffer) -> TimeseriesvarBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_var_buffer_fill(s : TimeseriesvarBuffer, v : Double) -> TimeseriesvarBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_var_buffer_min(s : TimeseriesvarBuffer) -> Double { @_common.min(s.data) }

pub fn timeseries_var_buffer_max(s : TimeseriesvarBuffer) -> Double { @_common.max(s.data) }

pub fn timeseries_var_buffer_to_string(s : TimeseriesvarBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesvarCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_var_cursor_make(size : Int) -> TimeseriesvarCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_var_cursor_len(s : TimeseriesvarCursor) -> Int { s.size }

pub fn timeseries_var_cursor_get(s : TimeseriesvarCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_var_cursor_set(s : TimeseriesvarCursor, i : Int, v : Double) -> TimeseriesvarCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_var_cursor_sum(s : TimeseriesvarCursor) -> Double { @_common.sum(s.data) }

pub fn timeseries_var_cursor_mean(s : TimeseriesvarCursor) -> Double { @_common.mean(s.data) }

pub fn timeseries_var_cursor_scale(s : TimeseriesvarCursor, f : Double) -> TimeseriesvarCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_var_cursor_add(a : TimeseriesvarCursor, b : TimeseriesvarCursor) -> TimeseriesvarCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_var_cursor_copy(s : TimeseriesvarCursor) -> TimeseriesvarCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_var_cursor_fill(s : TimeseriesvarCursor, v : Double) -> TimeseriesvarCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_var_cursor_min(s : TimeseriesvarCursor) -> Double { @_common.min(s.data) }

pub fn timeseries_var_cursor_max(s : TimeseriesvarCursor) -> Double { @_common.max(s.data) }

pub fn timeseries_var_cursor_to_string(s : TimeseriesvarCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesvarView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_var_view_make(size : Int) -> TimeseriesvarView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_var_view_len(s : TimeseriesvarView) -> Int { s.size }

pub fn timeseries_var_view_get(s : TimeseriesvarView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_var_view_set(s : TimeseriesvarView, i : Int, v : Double) -> TimeseriesvarView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_var_view_sum(s : TimeseriesvarView) -> Double { @_common.sum(s.data) }

pub fn timeseries_var_view_mean(s : TimeseriesvarView) -> Double { @_common.mean(s.data) }

pub fn timeseries_var_view_scale(s : TimeseriesvarView, f : Double) -> TimeseriesvarView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_var_view_add(a : TimeseriesvarView, b : TimeseriesvarView) -> TimeseriesvarView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_var_view_copy(s : TimeseriesvarView) -> TimeseriesvarView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_var_view_fill(s : TimeseriesvarView, v : Double) -> TimeseriesvarView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_var_view_min(s : TimeseriesvarView) -> Double { @_common.min(s.data) }

pub fn timeseries_var_view_max(s : TimeseriesvarView) -> Double { @_common.max(s.data) }

pub fn timeseries_var_view_to_string(s : TimeseriesvarView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesvarRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_var_range_make(size : Int) -> TimeseriesvarRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_var_range_len(s : TimeseriesvarRange) -> Int { s.size }

pub fn timeseries_var_range_get(s : TimeseriesvarRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_var_range_set(s : TimeseriesvarRange, i : Int, v : Double) -> TimeseriesvarRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_var_range_sum(s : TimeseriesvarRange) -> Double { @_common.sum(s.data) }

pub fn timeseries_var_range_mean(s : TimeseriesvarRange) -> Double { @_common.mean(s.data) }

pub fn timeseries_var_range_scale(s : TimeseriesvarRange, f : Double) -> TimeseriesvarRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_var_range_add(a : TimeseriesvarRange, b : TimeseriesvarRange) -> TimeseriesvarRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_var_range_copy(s : TimeseriesvarRange) -> TimeseriesvarRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_var_range_fill(s : TimeseriesvarRange, v : Double) -> TimeseriesvarRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_var_range_min(s : TimeseriesvarRange) -> Double { @_common.min(s.data) }

pub fn timeseries_var_range_max(s : TimeseriesvarRange) -> Double { @_common.max(s.data) }

pub fn timeseries_var_range_to_string(s : TimeseriesvarRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesvarSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_var_slice_make(size : Int) -> TimeseriesvarSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_var_slice_len(s : TimeseriesvarSlice) -> Int { s.size }

pub fn timeseries_var_slice_get(s : TimeseriesvarSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_var_slice_set(s : TimeseriesvarSlice, i : Int, v : Double) -> TimeseriesvarSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_var_slice_sum(s : TimeseriesvarSlice) -> Double { @_common.sum(s.data) }

pub fn timeseries_var_slice_mean(s : TimeseriesvarSlice) -> Double { @_common.mean(s.data) }

pub fn timeseries_var_slice_scale(s : TimeseriesvarSlice, f : Double) -> TimeseriesvarSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_var_slice_add(a : TimeseriesvarSlice, b : TimeseriesvarSlice) -> TimeseriesvarSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_var_slice_copy(s : TimeseriesvarSlice) -> TimeseriesvarSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_var_slice_fill(s : TimeseriesvarSlice, v : Double) -> TimeseriesvarSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_var_slice_min(s : TimeseriesvarSlice) -> Double { @_common.min(s.data) }

pub fn timeseries_var_slice_max(s : TimeseriesvarSlice) -> Double { @_common.max(s.data) }

pub fn timeseries_var_slice_to_string(s : TimeseriesvarSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

