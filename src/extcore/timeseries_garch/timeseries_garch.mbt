///===
/// extcore/timeseries_garch

pub(all) struct TimeseriesgarchPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn timeseries_garch_make_point(x : Double, y : Double) -> TimeseriesgarchPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn timeseries_garch_make_point3(x : Double, y : Double, z : Double) -> TimeseriesgarchPoint {
  { x, y, z, label: 0 }
}

pub fn TimeseriesgarchPoint::x(self : TimeseriesgarchPoint) -> Double { self.x }

pub fn TimeseriesgarchPoint::y(self : TimeseriesgarchPoint) -> Double { self.y }

pub fn TimeseriesgarchPoint::z(self : TimeseriesgarchPoint) -> Double { self.z }

pub fn TimeseriesgarchPoint::label(self : TimeseriesgarchPoint) -> Int { self.label }

pub fn TimeseriesgarchPoint::dist(self : TimeseriesgarchPoint, other : TimeseriesgarchPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn TimeseriesgarchPoint::add(self : TimeseriesgarchPoint, other : TimeseriesgarchPoint) -> TimeseriesgarchPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn TimeseriesgarchPoint::sub(self : TimeseriesgarchPoint, other : TimeseriesgarchPoint) -> TimeseriesgarchPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn TimeseriesgarchPoint::scale(self : TimeseriesgarchPoint, s : Double) -> TimeseriesgarchPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn TimeseriesgarchPoint::dot(self : TimeseriesgarchPoint, other : TimeseriesgarchPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn TimeseriesgarchPoint::cross(self : TimeseriesgarchPoint, other : TimeseriesgarchPoint) -> TimeseriesgarchPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn TimeseriesgarchPoint::norm(self : TimeseriesgarchPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn TimeseriesgarchPoint::normalize(self : TimeseriesgarchPoint) -> TimeseriesgarchPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn TimeseriesgarchPoint::negate(self : TimeseriesgarchPoint) -> TimeseriesgarchPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn TimeseriesgarchPoint::mid(self : TimeseriesgarchPoint, other : TimeseriesgarchPoint) -> TimeseriesgarchPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn TimeseriesgarchPoint::lerp(self : TimeseriesgarchPoint, other : TimeseriesgarchPoint, t : Double) -> TimeseriesgarchPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn TimeseriesgarchPoint::to_string(self : TimeseriesgarchPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct TimeseriesgarchSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn timeseries_garch_make_series(vals : Array[Double], name : String) -> TimeseriesgarchSeries {
  { vals, name, meta: 0 }
}

pub fn TimeseriesgarchSeries::len(self : TimeseriesgarchSeries) -> Int { self.vals.length() }

pub fn TimeseriesgarchSeries::sum(self : TimeseriesgarchSeries) -> Double { @_common.sum(self.vals) }

pub fn TimeseriesgarchSeries::mean(self : TimeseriesgarchSeries) -> Double { @_common.mean(self.vals) }

pub fn TimeseriesgarchSeries::min(self : TimeseriesgarchSeries) -> Double { @_common.min(self.vals) }

pub fn TimeseriesgarchSeries::max(self : TimeseriesgarchSeries) -> Double { @_common.max(self.vals) }

pub fn TimeseriesgarchSeries::range(self : TimeseriesgarchSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn TimeseriesgarchSeries::variance(self : TimeseriesgarchSeries) -> Double { @_common.variance(self.vals) }

pub fn TimeseriesgarchSeries::std(self : TimeseriesgarchSeries) -> Double { @_common.std(self.vals) }

pub fn TimeseriesgarchSeries::median(self : TimeseriesgarchSeries) -> Double { @_common.median(self.vals) }

pub fn TimeseriesgarchSeries::scale(self : TimeseriesgarchSeries, f : Double) -> TimeseriesgarchSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn TimeseriesgarchSeries::add(self : TimeseriesgarchSeries, other : TimeseriesgarchSeries) -> TimeseriesgarchSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn TimeseriesgarchSeries::sub(self : TimeseriesgarchSeries, other : TimeseriesgarchSeries) -> TimeseriesgarchSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn TimeseriesgarchSeries::normalize(self : TimeseriesgarchSeries) -> TimeseriesgarchSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn TimeseriesgarchSeries::cumsum(self : TimeseriesgarchSeries) -> TimeseriesgarchSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn TimeseriesgarchSeries::to_string(self : TimeseriesgarchSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct TimeseriesgarchMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn timeseries_garch_make_matrix(rows : Int, cols : Int, val : Double) -> TimeseriesgarchMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn timeseries_garch_matrix_identity(n : Int) -> TimeseriesgarchMatrix {
  let m = timeseries_garch_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn TimeseriesgarchMatrix::get(self : TimeseriesgarchMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn TimeseriesgarchMatrix::transpose(self : TimeseriesgarchMatrix) -> TimeseriesgarchMatrix {
  let result = timeseries_garch_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn TimeseriesgarchMatrix::add(self : TimeseriesgarchMatrix, other : TimeseriesgarchMatrix) -> TimeseriesgarchMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = timeseries_garch_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn TimeseriesgarchMatrix::scale(self : TimeseriesgarchMatrix, s : Double) -> TimeseriesgarchMatrix {
  let result = timeseries_garch_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn TimeseriesgarchMatrix::multiply(self : TimeseriesgarchMatrix, other : TimeseriesgarchMatrix) -> TimeseriesgarchMatrix {
  if self.cols != other.rows { return timeseries_garch_make_matrix(self.rows, other.cols, 0.0) }
  let result = timeseries_garch_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn TimeseriesgarchMatrix::trace(self : TimeseriesgarchMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn TimeseriesgarchMatrix::det(self : TimeseriesgarchMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn TimeseriesgarchMatrix::norm(self : TimeseriesgarchMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn TimeseriesgarchMatrix::to_string(self : TimeseriesgarchMatrix) -> String {
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

pub(all) struct TimeseriesgarchVector {
  comps : Array[Double]
  dim : Int
}

pub fn timeseries_garch_make_vector(comps : Array[Double]) -> TimeseriesgarchVector {
  { comps, dim: comps.length() }
}

pub fn timeseries_garch_vector_zero(dim : Int) -> TimeseriesgarchVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn TimeseriesgarchVector::add(self : TimeseriesgarchVector, other : TimeseriesgarchVector) -> TimeseriesgarchVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn TimeseriesgarchVector::sub(self : TimeseriesgarchVector, other : TimeseriesgarchVector) -> TimeseriesgarchVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn TimeseriesgarchVector::scale(self : TimeseriesgarchVector, s : Double) -> TimeseriesgarchVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn TimeseriesgarchVector::dot(self : TimeseriesgarchVector, other : TimeseriesgarchVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn TimeseriesgarchVector::norm(self : TimeseriesgarchVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn TimeseriesgarchVector::normalize(self : TimeseriesgarchVector) -> TimeseriesgarchVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn TimeseriesgarchVector::dist(self : TimeseriesgarchVector, other : TimeseriesgarchVector) -> Double {
  self.sub(other).norm()
}

pub fn TimeseriesgarchVector::to_string(self : TimeseriesgarchVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn timeseries_garch_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn timeseries_garch_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn timeseries_garch_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn timeseries_garch_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn timeseries_garch_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn timeseries_garch_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn timeseries_garch_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn timeseries_garch_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn timeseries_garch_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn timeseries_garch_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn timeseries_garch_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn timeseries_garch_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn timeseries_garch_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn timeseries_garch_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn timeseries_garch_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn timeseries_garch_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn timeseries_garch_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn timeseries_garch_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn timeseries_garch_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn timeseries_garch_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn timeseries_garch_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn timeseries_garch_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn timeseries_garch_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn timeseries_garch_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn timeseries_garch_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn timeseries_garch_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn timeseries_garch_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn timeseries_garch_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn timeseries_garch_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct TimeseriesgarchFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_garch_frame_make(size : Int) -> TimeseriesgarchFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_garch_frame_len(s : TimeseriesgarchFrame) -> Int { s.size }

pub fn timeseries_garch_frame_get(s : TimeseriesgarchFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_garch_frame_set(s : TimeseriesgarchFrame, i : Int, v : Double) -> TimeseriesgarchFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_garch_frame_sum(s : TimeseriesgarchFrame) -> Double { @_common.sum(s.data) }

pub fn timeseries_garch_frame_mean(s : TimeseriesgarchFrame) -> Double { @_common.mean(s.data) }

pub fn timeseries_garch_frame_scale(s : TimeseriesgarchFrame, f : Double) -> TimeseriesgarchFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_garch_frame_add(a : TimeseriesgarchFrame, b : TimeseriesgarchFrame) -> TimeseriesgarchFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_garch_frame_copy(s : TimeseriesgarchFrame) -> TimeseriesgarchFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_garch_frame_fill(s : TimeseriesgarchFrame, v : Double) -> TimeseriesgarchFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_garch_frame_min(s : TimeseriesgarchFrame) -> Double { @_common.min(s.data) }

pub fn timeseries_garch_frame_max(s : TimeseriesgarchFrame) -> Double { @_common.max(s.data) }

pub fn timeseries_garch_frame_to_string(s : TimeseriesgarchFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesgarchTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_garch_table_make(size : Int) -> TimeseriesgarchTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_garch_table_len(s : TimeseriesgarchTable) -> Int { s.size }

pub fn timeseries_garch_table_get(s : TimeseriesgarchTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_garch_table_set(s : TimeseriesgarchTable, i : Int, v : Double) -> TimeseriesgarchTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_garch_table_sum(s : TimeseriesgarchTable) -> Double { @_common.sum(s.data) }

pub fn timeseries_garch_table_mean(s : TimeseriesgarchTable) -> Double { @_common.mean(s.data) }

pub fn timeseries_garch_table_scale(s : TimeseriesgarchTable, f : Double) -> TimeseriesgarchTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_garch_table_add(a : TimeseriesgarchTable, b : TimeseriesgarchTable) -> TimeseriesgarchTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_garch_table_copy(s : TimeseriesgarchTable) -> TimeseriesgarchTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_garch_table_fill(s : TimeseriesgarchTable, v : Double) -> TimeseriesgarchTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_garch_table_min(s : TimeseriesgarchTable) -> Double { @_common.min(s.data) }

pub fn timeseries_garch_table_max(s : TimeseriesgarchTable) -> Double { @_common.max(s.data) }

pub fn timeseries_garch_table_to_string(s : TimeseriesgarchTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesgarchGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_garch_graphn_make(size : Int) -> TimeseriesgarchGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_garch_graphn_len(s : TimeseriesgarchGraphN) -> Int { s.size }

pub fn timeseries_garch_graphn_get(s : TimeseriesgarchGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_garch_graphn_set(s : TimeseriesgarchGraphN, i : Int, v : Double) -> TimeseriesgarchGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_garch_graphn_sum(s : TimeseriesgarchGraphN) -> Double { @_common.sum(s.data) }

pub fn timeseries_garch_graphn_mean(s : TimeseriesgarchGraphN) -> Double { @_common.mean(s.data) }

pub fn timeseries_garch_graphn_scale(s : TimeseriesgarchGraphN, f : Double) -> TimeseriesgarchGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_garch_graphn_add(a : TimeseriesgarchGraphN, b : TimeseriesgarchGraphN) -> TimeseriesgarchGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_garch_graphn_copy(s : TimeseriesgarchGraphN) -> TimeseriesgarchGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_garch_graphn_fill(s : TimeseriesgarchGraphN, v : Double) -> TimeseriesgarchGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_garch_graphn_min(s : TimeseriesgarchGraphN) -> Double { @_common.min(s.data) }

pub fn timeseries_garch_graphn_max(s : TimeseriesgarchGraphN) -> Double { @_common.max(s.data) }

pub fn timeseries_garch_graphn_to_string(s : TimeseriesgarchGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesgarchNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_garch_node_make(size : Int) -> TimeseriesgarchNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_garch_node_len(s : TimeseriesgarchNode) -> Int { s.size }

pub fn timeseries_garch_node_get(s : TimeseriesgarchNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_garch_node_set(s : TimeseriesgarchNode, i : Int, v : Double) -> TimeseriesgarchNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_garch_node_sum(s : TimeseriesgarchNode) -> Double { @_common.sum(s.data) }

pub fn timeseries_garch_node_mean(s : TimeseriesgarchNode) -> Double { @_common.mean(s.data) }

pub fn timeseries_garch_node_scale(s : TimeseriesgarchNode, f : Double) -> TimeseriesgarchNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_garch_node_add(a : TimeseriesgarchNode, b : TimeseriesgarchNode) -> TimeseriesgarchNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_garch_node_copy(s : TimeseriesgarchNode) -> TimeseriesgarchNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_garch_node_fill(s : TimeseriesgarchNode, v : Double) -> TimeseriesgarchNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_garch_node_min(s : TimeseriesgarchNode) -> Double { @_common.min(s.data) }

pub fn timeseries_garch_node_max(s : TimeseriesgarchNode) -> Double { @_common.max(s.data) }

pub fn timeseries_garch_node_to_string(s : TimeseriesgarchNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesgarchEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_garch_edge_make(size : Int) -> TimeseriesgarchEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_garch_edge_len(s : TimeseriesgarchEdge) -> Int { s.size }

pub fn timeseries_garch_edge_get(s : TimeseriesgarchEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_garch_edge_set(s : TimeseriesgarchEdge, i : Int, v : Double) -> TimeseriesgarchEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_garch_edge_sum(s : TimeseriesgarchEdge) -> Double { @_common.sum(s.data) }

pub fn timeseries_garch_edge_mean(s : TimeseriesgarchEdge) -> Double { @_common.mean(s.data) }

pub fn timeseries_garch_edge_scale(s : TimeseriesgarchEdge, f : Double) -> TimeseriesgarchEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_garch_edge_add(a : TimeseriesgarchEdge, b : TimeseriesgarchEdge) -> TimeseriesgarchEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_garch_edge_copy(s : TimeseriesgarchEdge) -> TimeseriesgarchEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_garch_edge_fill(s : TimeseriesgarchEdge, v : Double) -> TimeseriesgarchEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_garch_edge_min(s : TimeseriesgarchEdge) -> Double { @_common.min(s.data) }

pub fn timeseries_garch_edge_max(s : TimeseriesgarchEdge) -> Double { @_common.max(s.data) }

pub fn timeseries_garch_edge_to_string(s : TimeseriesgarchEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesgarchPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_garch_path_make(size : Int) -> TimeseriesgarchPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_garch_path_len(s : TimeseriesgarchPath) -> Int { s.size }

pub fn timeseries_garch_path_get(s : TimeseriesgarchPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_garch_path_set(s : TimeseriesgarchPath, i : Int, v : Double) -> TimeseriesgarchPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_garch_path_sum(s : TimeseriesgarchPath) -> Double { @_common.sum(s.data) }

pub fn timeseries_garch_path_mean(s : TimeseriesgarchPath) -> Double { @_common.mean(s.data) }

pub fn timeseries_garch_path_scale(s : TimeseriesgarchPath, f : Double) -> TimeseriesgarchPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_garch_path_add(a : TimeseriesgarchPath, b : TimeseriesgarchPath) -> TimeseriesgarchPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_garch_path_copy(s : TimeseriesgarchPath) -> TimeseriesgarchPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_garch_path_fill(s : TimeseriesgarchPath, v : Double) -> TimeseriesgarchPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_garch_path_min(s : TimeseriesgarchPath) -> Double { @_common.min(s.data) }

pub fn timeseries_garch_path_max(s : TimeseriesgarchPath) -> Double { @_common.max(s.data) }

pub fn timeseries_garch_path_to_string(s : TimeseriesgarchPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesgarchCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_garch_cluster_make(size : Int) -> TimeseriesgarchCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_garch_cluster_len(s : TimeseriesgarchCluster) -> Int { s.size }

pub fn timeseries_garch_cluster_get(s : TimeseriesgarchCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_garch_cluster_set(s : TimeseriesgarchCluster, i : Int, v : Double) -> TimeseriesgarchCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_garch_cluster_sum(s : TimeseriesgarchCluster) -> Double { @_common.sum(s.data) }

pub fn timeseries_garch_cluster_mean(s : TimeseriesgarchCluster) -> Double { @_common.mean(s.data) }

pub fn timeseries_garch_cluster_scale(s : TimeseriesgarchCluster, f : Double) -> TimeseriesgarchCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_garch_cluster_add(a : TimeseriesgarchCluster, b : TimeseriesgarchCluster) -> TimeseriesgarchCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_garch_cluster_copy(s : TimeseriesgarchCluster) -> TimeseriesgarchCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_garch_cluster_fill(s : TimeseriesgarchCluster, v : Double) -> TimeseriesgarchCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_garch_cluster_min(s : TimeseriesgarchCluster) -> Double { @_common.min(s.data) }

pub fn timeseries_garch_cluster_max(s : TimeseriesgarchCluster) -> Double { @_common.max(s.data) }

pub fn timeseries_garch_cluster_to_string(s : TimeseriesgarchCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesgarchModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_garch_model_make(size : Int) -> TimeseriesgarchModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_garch_model_len(s : TimeseriesgarchModel) -> Int { s.size }

pub fn timeseries_garch_model_get(s : TimeseriesgarchModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_garch_model_set(s : TimeseriesgarchModel, i : Int, v : Double) -> TimeseriesgarchModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_garch_model_sum(s : TimeseriesgarchModel) -> Double { @_common.sum(s.data) }

pub fn timeseries_garch_model_mean(s : TimeseriesgarchModel) -> Double { @_common.mean(s.data) }

pub fn timeseries_garch_model_scale(s : TimeseriesgarchModel, f : Double) -> TimeseriesgarchModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_garch_model_add(a : TimeseriesgarchModel, b : TimeseriesgarchModel) -> TimeseriesgarchModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_garch_model_copy(s : TimeseriesgarchModel) -> TimeseriesgarchModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_garch_model_fill(s : TimeseriesgarchModel, v : Double) -> TimeseriesgarchModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_garch_model_min(s : TimeseriesgarchModel) -> Double { @_common.min(s.data) }

pub fn timeseries_garch_model_max(s : TimeseriesgarchModel) -> Double { @_common.max(s.data) }

pub fn timeseries_garch_model_to_string(s : TimeseriesgarchModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesgarchLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_garch_layer_make(size : Int) -> TimeseriesgarchLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_garch_layer_len(s : TimeseriesgarchLayer) -> Int { s.size }

pub fn timeseries_garch_layer_get(s : TimeseriesgarchLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_garch_layer_set(s : TimeseriesgarchLayer, i : Int, v : Double) -> TimeseriesgarchLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_garch_layer_sum(s : TimeseriesgarchLayer) -> Double { @_common.sum(s.data) }

pub fn timeseries_garch_layer_mean(s : TimeseriesgarchLayer) -> Double { @_common.mean(s.data) }

pub fn timeseries_garch_layer_scale(s : TimeseriesgarchLayer, f : Double) -> TimeseriesgarchLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_garch_layer_add(a : TimeseriesgarchLayer, b : TimeseriesgarchLayer) -> TimeseriesgarchLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_garch_layer_copy(s : TimeseriesgarchLayer) -> TimeseriesgarchLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_garch_layer_fill(s : TimeseriesgarchLayer, v : Double) -> TimeseriesgarchLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_garch_layer_min(s : TimeseriesgarchLayer) -> Double { @_common.min(s.data) }

pub fn timeseries_garch_layer_max(s : TimeseriesgarchLayer) -> Double { @_common.max(s.data) }

pub fn timeseries_garch_layer_to_string(s : TimeseriesgarchLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesgarchBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_garch_buffer_make(size : Int) -> TimeseriesgarchBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_garch_buffer_len(s : TimeseriesgarchBuffer) -> Int { s.size }

pub fn timeseries_garch_buffer_get(s : TimeseriesgarchBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_garch_buffer_set(s : TimeseriesgarchBuffer, i : Int, v : Double) -> TimeseriesgarchBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_garch_buffer_sum(s : TimeseriesgarchBuffer) -> Double { @_common.sum(s.data) }

pub fn timeseries_garch_buffer_mean(s : TimeseriesgarchBuffer) -> Double { @_common.mean(s.data) }

pub fn timeseries_garch_buffer_scale(s : TimeseriesgarchBuffer, f : Double) -> TimeseriesgarchBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_garch_buffer_add(a : TimeseriesgarchBuffer, b : TimeseriesgarchBuffer) -> TimeseriesgarchBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_garch_buffer_copy(s : TimeseriesgarchBuffer) -> TimeseriesgarchBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_garch_buffer_fill(s : TimeseriesgarchBuffer, v : Double) -> TimeseriesgarchBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_garch_buffer_min(s : TimeseriesgarchBuffer) -> Double { @_common.min(s.data) }

pub fn timeseries_garch_buffer_max(s : TimeseriesgarchBuffer) -> Double { @_common.max(s.data) }

pub fn timeseries_garch_buffer_to_string(s : TimeseriesgarchBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesgarchCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_garch_cursor_make(size : Int) -> TimeseriesgarchCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_garch_cursor_len(s : TimeseriesgarchCursor) -> Int { s.size }

pub fn timeseries_garch_cursor_get(s : TimeseriesgarchCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_garch_cursor_set(s : TimeseriesgarchCursor, i : Int, v : Double) -> TimeseriesgarchCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_garch_cursor_sum(s : TimeseriesgarchCursor) -> Double { @_common.sum(s.data) }

pub fn timeseries_garch_cursor_mean(s : TimeseriesgarchCursor) -> Double { @_common.mean(s.data) }

pub fn timeseries_garch_cursor_scale(s : TimeseriesgarchCursor, f : Double) -> TimeseriesgarchCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_garch_cursor_add(a : TimeseriesgarchCursor, b : TimeseriesgarchCursor) -> TimeseriesgarchCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_garch_cursor_copy(s : TimeseriesgarchCursor) -> TimeseriesgarchCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_garch_cursor_fill(s : TimeseriesgarchCursor, v : Double) -> TimeseriesgarchCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_garch_cursor_min(s : TimeseriesgarchCursor) -> Double { @_common.min(s.data) }

pub fn timeseries_garch_cursor_max(s : TimeseriesgarchCursor) -> Double { @_common.max(s.data) }

pub fn timeseries_garch_cursor_to_string(s : TimeseriesgarchCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesgarchView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_garch_view_make(size : Int) -> TimeseriesgarchView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_garch_view_len(s : TimeseriesgarchView) -> Int { s.size }

pub fn timeseries_garch_view_get(s : TimeseriesgarchView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_garch_view_set(s : TimeseriesgarchView, i : Int, v : Double) -> TimeseriesgarchView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_garch_view_sum(s : TimeseriesgarchView) -> Double { @_common.sum(s.data) }

pub fn timeseries_garch_view_mean(s : TimeseriesgarchView) -> Double { @_common.mean(s.data) }

pub fn timeseries_garch_view_scale(s : TimeseriesgarchView, f : Double) -> TimeseriesgarchView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_garch_view_add(a : TimeseriesgarchView, b : TimeseriesgarchView) -> TimeseriesgarchView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_garch_view_copy(s : TimeseriesgarchView) -> TimeseriesgarchView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_garch_view_fill(s : TimeseriesgarchView, v : Double) -> TimeseriesgarchView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_garch_view_min(s : TimeseriesgarchView) -> Double { @_common.min(s.data) }

pub fn timeseries_garch_view_max(s : TimeseriesgarchView) -> Double { @_common.max(s.data) }

pub fn timeseries_garch_view_to_string(s : TimeseriesgarchView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesgarchRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_garch_range_make(size : Int) -> TimeseriesgarchRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_garch_range_len(s : TimeseriesgarchRange) -> Int { s.size }

pub fn timeseries_garch_range_get(s : TimeseriesgarchRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_garch_range_set(s : TimeseriesgarchRange, i : Int, v : Double) -> TimeseriesgarchRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_garch_range_sum(s : TimeseriesgarchRange) -> Double { @_common.sum(s.data) }

pub fn timeseries_garch_range_mean(s : TimeseriesgarchRange) -> Double { @_common.mean(s.data) }

pub fn timeseries_garch_range_scale(s : TimeseriesgarchRange, f : Double) -> TimeseriesgarchRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_garch_range_add(a : TimeseriesgarchRange, b : TimeseriesgarchRange) -> TimeseriesgarchRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_garch_range_copy(s : TimeseriesgarchRange) -> TimeseriesgarchRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_garch_range_fill(s : TimeseriesgarchRange, v : Double) -> TimeseriesgarchRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_garch_range_min(s : TimeseriesgarchRange) -> Double { @_common.min(s.data) }

pub fn timeseries_garch_range_max(s : TimeseriesgarchRange) -> Double { @_common.max(s.data) }

pub fn timeseries_garch_range_to_string(s : TimeseriesgarchRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesgarchSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_garch_slice_make(size : Int) -> TimeseriesgarchSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_garch_slice_len(s : TimeseriesgarchSlice) -> Int { s.size }

pub fn timeseries_garch_slice_get(s : TimeseriesgarchSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_garch_slice_set(s : TimeseriesgarchSlice, i : Int, v : Double) -> TimeseriesgarchSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_garch_slice_sum(s : TimeseriesgarchSlice) -> Double { @_common.sum(s.data) }

pub fn timeseries_garch_slice_mean(s : TimeseriesgarchSlice) -> Double { @_common.mean(s.data) }

pub fn timeseries_garch_slice_scale(s : TimeseriesgarchSlice, f : Double) -> TimeseriesgarchSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_garch_slice_add(a : TimeseriesgarchSlice, b : TimeseriesgarchSlice) -> TimeseriesgarchSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_garch_slice_copy(s : TimeseriesgarchSlice) -> TimeseriesgarchSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_garch_slice_fill(s : TimeseriesgarchSlice, v : Double) -> TimeseriesgarchSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_garch_slice_min(s : TimeseriesgarchSlice) -> Double { @_common.min(s.data) }

pub fn timeseries_garch_slice_max(s : TimeseriesgarchSlice) -> Double { @_common.max(s.data) }

pub fn timeseries_garch_slice_to_string(s : TimeseriesgarchSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

