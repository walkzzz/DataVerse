///===
/// extcore/timeseries_arch

pub(all) struct TimeseriesarchPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn timeseries_arch_make_point(x : Double, y : Double) -> TimeseriesarchPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn timeseries_arch_make_point3(x : Double, y : Double, z : Double) -> TimeseriesarchPoint {
  { x, y, z, label: 0 }
}

pub fn TimeseriesarchPoint::x(self : TimeseriesarchPoint) -> Double { self.x }

pub fn TimeseriesarchPoint::y(self : TimeseriesarchPoint) -> Double { self.y }

pub fn TimeseriesarchPoint::z(self : TimeseriesarchPoint) -> Double { self.z }

pub fn TimeseriesarchPoint::label(self : TimeseriesarchPoint) -> Int { self.label }

pub fn TimeseriesarchPoint::dist(self : TimeseriesarchPoint, other : TimeseriesarchPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn TimeseriesarchPoint::add(self : TimeseriesarchPoint, other : TimeseriesarchPoint) -> TimeseriesarchPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn TimeseriesarchPoint::sub(self : TimeseriesarchPoint, other : TimeseriesarchPoint) -> TimeseriesarchPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn TimeseriesarchPoint::scale(self : TimeseriesarchPoint, s : Double) -> TimeseriesarchPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn TimeseriesarchPoint::dot(self : TimeseriesarchPoint, other : TimeseriesarchPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn TimeseriesarchPoint::cross(self : TimeseriesarchPoint, other : TimeseriesarchPoint) -> TimeseriesarchPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn TimeseriesarchPoint::norm(self : TimeseriesarchPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn TimeseriesarchPoint::normalize(self : TimeseriesarchPoint) -> TimeseriesarchPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn TimeseriesarchPoint::negate(self : TimeseriesarchPoint) -> TimeseriesarchPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn TimeseriesarchPoint::mid(self : TimeseriesarchPoint, other : TimeseriesarchPoint) -> TimeseriesarchPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn TimeseriesarchPoint::lerp(self : TimeseriesarchPoint, other : TimeseriesarchPoint, t : Double) -> TimeseriesarchPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn TimeseriesarchPoint::to_string(self : TimeseriesarchPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct TimeseriesarchSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn timeseries_arch_make_series(vals : Array[Double], name : String) -> TimeseriesarchSeries {
  { vals, name, meta: 0 }
}

pub fn TimeseriesarchSeries::len(self : TimeseriesarchSeries) -> Int { self.vals.length() }

pub fn TimeseriesarchSeries::sum(self : TimeseriesarchSeries) -> Double { @_common.sum(self.vals) }

pub fn TimeseriesarchSeries::mean(self : TimeseriesarchSeries) -> Double { @_common.mean(self.vals) }

pub fn TimeseriesarchSeries::min(self : TimeseriesarchSeries) -> Double { @_common.min(self.vals) }

pub fn TimeseriesarchSeries::max(self : TimeseriesarchSeries) -> Double { @_common.max(self.vals) }

pub fn TimeseriesarchSeries::range(self : TimeseriesarchSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn TimeseriesarchSeries::variance(self : TimeseriesarchSeries) -> Double { @_common.variance(self.vals) }

pub fn TimeseriesarchSeries::std(self : TimeseriesarchSeries) -> Double { @_common.std(self.vals) }

pub fn TimeseriesarchSeries::median(self : TimeseriesarchSeries) -> Double { @_common.median(self.vals) }

pub fn TimeseriesarchSeries::scale(self : TimeseriesarchSeries, f : Double) -> TimeseriesarchSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn TimeseriesarchSeries::add(self : TimeseriesarchSeries, other : TimeseriesarchSeries) -> TimeseriesarchSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn TimeseriesarchSeries::sub(self : TimeseriesarchSeries, other : TimeseriesarchSeries) -> TimeseriesarchSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn TimeseriesarchSeries::normalize(self : TimeseriesarchSeries) -> TimeseriesarchSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn TimeseriesarchSeries::cumsum(self : TimeseriesarchSeries) -> TimeseriesarchSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn TimeseriesarchSeries::to_string(self : TimeseriesarchSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct TimeseriesarchMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn timeseries_arch_make_matrix(rows : Int, cols : Int, val : Double) -> TimeseriesarchMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn timeseries_arch_matrix_identity(n : Int) -> TimeseriesarchMatrix {
  let m = timeseries_arch_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn TimeseriesarchMatrix::get(self : TimeseriesarchMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn TimeseriesarchMatrix::transpose(self : TimeseriesarchMatrix) -> TimeseriesarchMatrix {
  let result = timeseries_arch_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn TimeseriesarchMatrix::add(self : TimeseriesarchMatrix, other : TimeseriesarchMatrix) -> TimeseriesarchMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = timeseries_arch_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn TimeseriesarchMatrix::scale(self : TimeseriesarchMatrix, s : Double) -> TimeseriesarchMatrix {
  let result = timeseries_arch_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn TimeseriesarchMatrix::multiply(self : TimeseriesarchMatrix, other : TimeseriesarchMatrix) -> TimeseriesarchMatrix {
  if self.cols != other.rows { return timeseries_arch_make_matrix(self.rows, other.cols, 0.0) }
  let result = timeseries_arch_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn TimeseriesarchMatrix::trace(self : TimeseriesarchMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn TimeseriesarchMatrix::det(self : TimeseriesarchMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn TimeseriesarchMatrix::norm(self : TimeseriesarchMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn TimeseriesarchMatrix::to_string(self : TimeseriesarchMatrix) -> String {
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

pub(all) struct TimeseriesarchVector {
  comps : Array[Double]
  dim : Int
}

pub fn timeseries_arch_make_vector(comps : Array[Double]) -> TimeseriesarchVector {
  { comps, dim: comps.length() }
}

pub fn timeseries_arch_vector_zero(dim : Int) -> TimeseriesarchVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn TimeseriesarchVector::add(self : TimeseriesarchVector, other : TimeseriesarchVector) -> TimeseriesarchVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn TimeseriesarchVector::sub(self : TimeseriesarchVector, other : TimeseriesarchVector) -> TimeseriesarchVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn TimeseriesarchVector::scale(self : TimeseriesarchVector, s : Double) -> TimeseriesarchVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn TimeseriesarchVector::dot(self : TimeseriesarchVector, other : TimeseriesarchVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn TimeseriesarchVector::norm(self : TimeseriesarchVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn TimeseriesarchVector::normalize(self : TimeseriesarchVector) -> TimeseriesarchVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn TimeseriesarchVector::dist(self : TimeseriesarchVector, other : TimeseriesarchVector) -> Double {
  self.sub(other).norm()
}

pub fn TimeseriesarchVector::to_string(self : TimeseriesarchVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn timeseries_arch_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn timeseries_arch_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn timeseries_arch_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn timeseries_arch_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn timeseries_arch_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn timeseries_arch_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn timeseries_arch_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn timeseries_arch_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn timeseries_arch_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn timeseries_arch_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn timeseries_arch_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn timeseries_arch_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn timeseries_arch_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn timeseries_arch_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn timeseries_arch_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn timeseries_arch_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn timeseries_arch_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn timeseries_arch_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn timeseries_arch_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn timeseries_arch_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn timeseries_arch_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn timeseries_arch_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn timeseries_arch_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn timeseries_arch_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn timeseries_arch_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn timeseries_arch_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn timeseries_arch_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn timeseries_arch_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn timeseries_arch_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct TimeseriesarchFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_arch_frame_make(size : Int) -> TimeseriesarchFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_arch_frame_len(s : TimeseriesarchFrame) -> Int { s.size }

pub fn timeseries_arch_frame_get(s : TimeseriesarchFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_arch_frame_set(s : TimeseriesarchFrame, i : Int, v : Double) -> TimeseriesarchFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_arch_frame_sum(s : TimeseriesarchFrame) -> Double { @_common.sum(s.data) }

pub fn timeseries_arch_frame_mean(s : TimeseriesarchFrame) -> Double { @_common.mean(s.data) }

pub fn timeseries_arch_frame_scale(s : TimeseriesarchFrame, f : Double) -> TimeseriesarchFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_arch_frame_add(a : TimeseriesarchFrame, b : TimeseriesarchFrame) -> TimeseriesarchFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_arch_frame_copy(s : TimeseriesarchFrame) -> TimeseriesarchFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_arch_frame_fill(s : TimeseriesarchFrame, v : Double) -> TimeseriesarchFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_arch_frame_min(s : TimeseriesarchFrame) -> Double { @_common.min(s.data) }

pub fn timeseries_arch_frame_max(s : TimeseriesarchFrame) -> Double { @_common.max(s.data) }

pub fn timeseries_arch_frame_to_string(s : TimeseriesarchFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesarchTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_arch_table_make(size : Int) -> TimeseriesarchTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_arch_table_len(s : TimeseriesarchTable) -> Int { s.size }

pub fn timeseries_arch_table_get(s : TimeseriesarchTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_arch_table_set(s : TimeseriesarchTable, i : Int, v : Double) -> TimeseriesarchTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_arch_table_sum(s : TimeseriesarchTable) -> Double { @_common.sum(s.data) }

pub fn timeseries_arch_table_mean(s : TimeseriesarchTable) -> Double { @_common.mean(s.data) }

pub fn timeseries_arch_table_scale(s : TimeseriesarchTable, f : Double) -> TimeseriesarchTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_arch_table_add(a : TimeseriesarchTable, b : TimeseriesarchTable) -> TimeseriesarchTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_arch_table_copy(s : TimeseriesarchTable) -> TimeseriesarchTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_arch_table_fill(s : TimeseriesarchTable, v : Double) -> TimeseriesarchTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_arch_table_min(s : TimeseriesarchTable) -> Double { @_common.min(s.data) }

pub fn timeseries_arch_table_max(s : TimeseriesarchTable) -> Double { @_common.max(s.data) }

pub fn timeseries_arch_table_to_string(s : TimeseriesarchTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesarchGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_arch_graphn_make(size : Int) -> TimeseriesarchGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_arch_graphn_len(s : TimeseriesarchGraphN) -> Int { s.size }

pub fn timeseries_arch_graphn_get(s : TimeseriesarchGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_arch_graphn_set(s : TimeseriesarchGraphN, i : Int, v : Double) -> TimeseriesarchGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_arch_graphn_sum(s : TimeseriesarchGraphN) -> Double { @_common.sum(s.data) }

pub fn timeseries_arch_graphn_mean(s : TimeseriesarchGraphN) -> Double { @_common.mean(s.data) }

pub fn timeseries_arch_graphn_scale(s : TimeseriesarchGraphN, f : Double) -> TimeseriesarchGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_arch_graphn_add(a : TimeseriesarchGraphN, b : TimeseriesarchGraphN) -> TimeseriesarchGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_arch_graphn_copy(s : TimeseriesarchGraphN) -> TimeseriesarchGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_arch_graphn_fill(s : TimeseriesarchGraphN, v : Double) -> TimeseriesarchGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_arch_graphn_min(s : TimeseriesarchGraphN) -> Double { @_common.min(s.data) }

pub fn timeseries_arch_graphn_max(s : TimeseriesarchGraphN) -> Double { @_common.max(s.data) }

pub fn timeseries_arch_graphn_to_string(s : TimeseriesarchGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesarchNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_arch_node_make(size : Int) -> TimeseriesarchNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_arch_node_len(s : TimeseriesarchNode) -> Int { s.size }

pub fn timeseries_arch_node_get(s : TimeseriesarchNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_arch_node_set(s : TimeseriesarchNode, i : Int, v : Double) -> TimeseriesarchNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_arch_node_sum(s : TimeseriesarchNode) -> Double { @_common.sum(s.data) }

pub fn timeseries_arch_node_mean(s : TimeseriesarchNode) -> Double { @_common.mean(s.data) }

pub fn timeseries_arch_node_scale(s : TimeseriesarchNode, f : Double) -> TimeseriesarchNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_arch_node_add(a : TimeseriesarchNode, b : TimeseriesarchNode) -> TimeseriesarchNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_arch_node_copy(s : TimeseriesarchNode) -> TimeseriesarchNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_arch_node_fill(s : TimeseriesarchNode, v : Double) -> TimeseriesarchNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_arch_node_min(s : TimeseriesarchNode) -> Double { @_common.min(s.data) }

pub fn timeseries_arch_node_max(s : TimeseriesarchNode) -> Double { @_common.max(s.data) }

pub fn timeseries_arch_node_to_string(s : TimeseriesarchNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesarchEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_arch_edge_make(size : Int) -> TimeseriesarchEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_arch_edge_len(s : TimeseriesarchEdge) -> Int { s.size }

pub fn timeseries_arch_edge_get(s : TimeseriesarchEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_arch_edge_set(s : TimeseriesarchEdge, i : Int, v : Double) -> TimeseriesarchEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_arch_edge_sum(s : TimeseriesarchEdge) -> Double { @_common.sum(s.data) }

pub fn timeseries_arch_edge_mean(s : TimeseriesarchEdge) -> Double { @_common.mean(s.data) }

pub fn timeseries_arch_edge_scale(s : TimeseriesarchEdge, f : Double) -> TimeseriesarchEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_arch_edge_add(a : TimeseriesarchEdge, b : TimeseriesarchEdge) -> TimeseriesarchEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_arch_edge_copy(s : TimeseriesarchEdge) -> TimeseriesarchEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_arch_edge_fill(s : TimeseriesarchEdge, v : Double) -> TimeseriesarchEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_arch_edge_min(s : TimeseriesarchEdge) -> Double { @_common.min(s.data) }

pub fn timeseries_arch_edge_max(s : TimeseriesarchEdge) -> Double { @_common.max(s.data) }

pub fn timeseries_arch_edge_to_string(s : TimeseriesarchEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesarchPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_arch_path_make(size : Int) -> TimeseriesarchPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_arch_path_len(s : TimeseriesarchPath) -> Int { s.size }

pub fn timeseries_arch_path_get(s : TimeseriesarchPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_arch_path_set(s : TimeseriesarchPath, i : Int, v : Double) -> TimeseriesarchPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_arch_path_sum(s : TimeseriesarchPath) -> Double { @_common.sum(s.data) }

pub fn timeseries_arch_path_mean(s : TimeseriesarchPath) -> Double { @_common.mean(s.data) }

pub fn timeseries_arch_path_scale(s : TimeseriesarchPath, f : Double) -> TimeseriesarchPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_arch_path_add(a : TimeseriesarchPath, b : TimeseriesarchPath) -> TimeseriesarchPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_arch_path_copy(s : TimeseriesarchPath) -> TimeseriesarchPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_arch_path_fill(s : TimeseriesarchPath, v : Double) -> TimeseriesarchPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_arch_path_min(s : TimeseriesarchPath) -> Double { @_common.min(s.data) }

pub fn timeseries_arch_path_max(s : TimeseriesarchPath) -> Double { @_common.max(s.data) }

pub fn timeseries_arch_path_to_string(s : TimeseriesarchPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesarchCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_arch_cluster_make(size : Int) -> TimeseriesarchCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_arch_cluster_len(s : TimeseriesarchCluster) -> Int { s.size }

pub fn timeseries_arch_cluster_get(s : TimeseriesarchCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_arch_cluster_set(s : TimeseriesarchCluster, i : Int, v : Double) -> TimeseriesarchCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_arch_cluster_sum(s : TimeseriesarchCluster) -> Double { @_common.sum(s.data) }

pub fn timeseries_arch_cluster_mean(s : TimeseriesarchCluster) -> Double { @_common.mean(s.data) }

pub fn timeseries_arch_cluster_scale(s : TimeseriesarchCluster, f : Double) -> TimeseriesarchCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_arch_cluster_add(a : TimeseriesarchCluster, b : TimeseriesarchCluster) -> TimeseriesarchCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_arch_cluster_copy(s : TimeseriesarchCluster) -> TimeseriesarchCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_arch_cluster_fill(s : TimeseriesarchCluster, v : Double) -> TimeseriesarchCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_arch_cluster_min(s : TimeseriesarchCluster) -> Double { @_common.min(s.data) }

pub fn timeseries_arch_cluster_max(s : TimeseriesarchCluster) -> Double { @_common.max(s.data) }

pub fn timeseries_arch_cluster_to_string(s : TimeseriesarchCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesarchModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_arch_model_make(size : Int) -> TimeseriesarchModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_arch_model_len(s : TimeseriesarchModel) -> Int { s.size }

pub fn timeseries_arch_model_get(s : TimeseriesarchModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_arch_model_set(s : TimeseriesarchModel, i : Int, v : Double) -> TimeseriesarchModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_arch_model_sum(s : TimeseriesarchModel) -> Double { @_common.sum(s.data) }

pub fn timeseries_arch_model_mean(s : TimeseriesarchModel) -> Double { @_common.mean(s.data) }

pub fn timeseries_arch_model_scale(s : TimeseriesarchModel, f : Double) -> TimeseriesarchModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_arch_model_add(a : TimeseriesarchModel, b : TimeseriesarchModel) -> TimeseriesarchModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_arch_model_copy(s : TimeseriesarchModel) -> TimeseriesarchModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_arch_model_fill(s : TimeseriesarchModel, v : Double) -> TimeseriesarchModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_arch_model_min(s : TimeseriesarchModel) -> Double { @_common.min(s.data) }

pub fn timeseries_arch_model_max(s : TimeseriesarchModel) -> Double { @_common.max(s.data) }

pub fn timeseries_arch_model_to_string(s : TimeseriesarchModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesarchLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_arch_layer_make(size : Int) -> TimeseriesarchLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_arch_layer_len(s : TimeseriesarchLayer) -> Int { s.size }

pub fn timeseries_arch_layer_get(s : TimeseriesarchLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_arch_layer_set(s : TimeseriesarchLayer, i : Int, v : Double) -> TimeseriesarchLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_arch_layer_sum(s : TimeseriesarchLayer) -> Double { @_common.sum(s.data) }

pub fn timeseries_arch_layer_mean(s : TimeseriesarchLayer) -> Double { @_common.mean(s.data) }

pub fn timeseries_arch_layer_scale(s : TimeseriesarchLayer, f : Double) -> TimeseriesarchLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_arch_layer_add(a : TimeseriesarchLayer, b : TimeseriesarchLayer) -> TimeseriesarchLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_arch_layer_copy(s : TimeseriesarchLayer) -> TimeseriesarchLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_arch_layer_fill(s : TimeseriesarchLayer, v : Double) -> TimeseriesarchLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_arch_layer_min(s : TimeseriesarchLayer) -> Double { @_common.min(s.data) }

pub fn timeseries_arch_layer_max(s : TimeseriesarchLayer) -> Double { @_common.max(s.data) }

pub fn timeseries_arch_layer_to_string(s : TimeseriesarchLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesarchBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_arch_buffer_make(size : Int) -> TimeseriesarchBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_arch_buffer_len(s : TimeseriesarchBuffer) -> Int { s.size }

pub fn timeseries_arch_buffer_get(s : TimeseriesarchBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_arch_buffer_set(s : TimeseriesarchBuffer, i : Int, v : Double) -> TimeseriesarchBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_arch_buffer_sum(s : TimeseriesarchBuffer) -> Double { @_common.sum(s.data) }

pub fn timeseries_arch_buffer_mean(s : TimeseriesarchBuffer) -> Double { @_common.mean(s.data) }

pub fn timeseries_arch_buffer_scale(s : TimeseriesarchBuffer, f : Double) -> TimeseriesarchBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_arch_buffer_add(a : TimeseriesarchBuffer, b : TimeseriesarchBuffer) -> TimeseriesarchBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_arch_buffer_copy(s : TimeseriesarchBuffer) -> TimeseriesarchBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_arch_buffer_fill(s : TimeseriesarchBuffer, v : Double) -> TimeseriesarchBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_arch_buffer_min(s : TimeseriesarchBuffer) -> Double { @_common.min(s.data) }

pub fn timeseries_arch_buffer_max(s : TimeseriesarchBuffer) -> Double { @_common.max(s.data) }

pub fn timeseries_arch_buffer_to_string(s : TimeseriesarchBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesarchCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_arch_cursor_make(size : Int) -> TimeseriesarchCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_arch_cursor_len(s : TimeseriesarchCursor) -> Int { s.size }

pub fn timeseries_arch_cursor_get(s : TimeseriesarchCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_arch_cursor_set(s : TimeseriesarchCursor, i : Int, v : Double) -> TimeseriesarchCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_arch_cursor_sum(s : TimeseriesarchCursor) -> Double { @_common.sum(s.data) }

pub fn timeseries_arch_cursor_mean(s : TimeseriesarchCursor) -> Double { @_common.mean(s.data) }

pub fn timeseries_arch_cursor_scale(s : TimeseriesarchCursor, f : Double) -> TimeseriesarchCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_arch_cursor_add(a : TimeseriesarchCursor, b : TimeseriesarchCursor) -> TimeseriesarchCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_arch_cursor_copy(s : TimeseriesarchCursor) -> TimeseriesarchCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_arch_cursor_fill(s : TimeseriesarchCursor, v : Double) -> TimeseriesarchCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_arch_cursor_min(s : TimeseriesarchCursor) -> Double { @_common.min(s.data) }

pub fn timeseries_arch_cursor_max(s : TimeseriesarchCursor) -> Double { @_common.max(s.data) }

pub fn timeseries_arch_cursor_to_string(s : TimeseriesarchCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesarchView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_arch_view_make(size : Int) -> TimeseriesarchView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_arch_view_len(s : TimeseriesarchView) -> Int { s.size }

pub fn timeseries_arch_view_get(s : TimeseriesarchView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_arch_view_set(s : TimeseriesarchView, i : Int, v : Double) -> TimeseriesarchView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_arch_view_sum(s : TimeseriesarchView) -> Double { @_common.sum(s.data) }

pub fn timeseries_arch_view_mean(s : TimeseriesarchView) -> Double { @_common.mean(s.data) }

pub fn timeseries_arch_view_scale(s : TimeseriesarchView, f : Double) -> TimeseriesarchView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_arch_view_add(a : TimeseriesarchView, b : TimeseriesarchView) -> TimeseriesarchView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_arch_view_copy(s : TimeseriesarchView) -> TimeseriesarchView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_arch_view_fill(s : TimeseriesarchView, v : Double) -> TimeseriesarchView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_arch_view_min(s : TimeseriesarchView) -> Double { @_common.min(s.data) }

pub fn timeseries_arch_view_max(s : TimeseriesarchView) -> Double { @_common.max(s.data) }

pub fn timeseries_arch_view_to_string(s : TimeseriesarchView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesarchRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_arch_range_make(size : Int) -> TimeseriesarchRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_arch_range_len(s : TimeseriesarchRange) -> Int { s.size }

pub fn timeseries_arch_range_get(s : TimeseriesarchRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_arch_range_set(s : TimeseriesarchRange, i : Int, v : Double) -> TimeseriesarchRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_arch_range_sum(s : TimeseriesarchRange) -> Double { @_common.sum(s.data) }

pub fn timeseries_arch_range_mean(s : TimeseriesarchRange) -> Double { @_common.mean(s.data) }

pub fn timeseries_arch_range_scale(s : TimeseriesarchRange, f : Double) -> TimeseriesarchRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_arch_range_add(a : TimeseriesarchRange, b : TimeseriesarchRange) -> TimeseriesarchRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_arch_range_copy(s : TimeseriesarchRange) -> TimeseriesarchRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_arch_range_fill(s : TimeseriesarchRange, v : Double) -> TimeseriesarchRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_arch_range_min(s : TimeseriesarchRange) -> Double { @_common.min(s.data) }

pub fn timeseries_arch_range_max(s : TimeseriesarchRange) -> Double { @_common.max(s.data) }

pub fn timeseries_arch_range_to_string(s : TimeseriesarchRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesarchSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_arch_slice_make(size : Int) -> TimeseriesarchSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_arch_slice_len(s : TimeseriesarchSlice) -> Int { s.size }

pub fn timeseries_arch_slice_get(s : TimeseriesarchSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_arch_slice_set(s : TimeseriesarchSlice, i : Int, v : Double) -> TimeseriesarchSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_arch_slice_sum(s : TimeseriesarchSlice) -> Double { @_common.sum(s.data) }

pub fn timeseries_arch_slice_mean(s : TimeseriesarchSlice) -> Double { @_common.mean(s.data) }

pub fn timeseries_arch_slice_scale(s : TimeseriesarchSlice, f : Double) -> TimeseriesarchSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_arch_slice_add(a : TimeseriesarchSlice, b : TimeseriesarchSlice) -> TimeseriesarchSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_arch_slice_copy(s : TimeseriesarchSlice) -> TimeseriesarchSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_arch_slice_fill(s : TimeseriesarchSlice, v : Double) -> TimeseriesarchSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_arch_slice_min(s : TimeseriesarchSlice) -> Double { @_common.min(s.data) }

pub fn timeseries_arch_slice_max(s : TimeseriesarchSlice) -> Double { @_common.max(s.data) }

pub fn timeseries_arch_slice_to_string(s : TimeseriesarchSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

