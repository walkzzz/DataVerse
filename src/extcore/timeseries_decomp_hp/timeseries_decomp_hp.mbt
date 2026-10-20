///===
/// extcore/timeseries_decomp_hp

pub(all) struct TimeseriesdecomphpPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn timeseries_decomp_hp_make_point(x : Double, y : Double) -> TimeseriesdecomphpPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn timeseries_decomp_hp_make_point3(x : Double, y : Double, z : Double) -> TimeseriesdecomphpPoint {
  { x, y, z, label: 0 }
}

pub fn TimeseriesdecomphpPoint::x(self : TimeseriesdecomphpPoint) -> Double { self.x }

pub fn TimeseriesdecomphpPoint::y(self : TimeseriesdecomphpPoint) -> Double { self.y }

pub fn TimeseriesdecomphpPoint::z(self : TimeseriesdecomphpPoint) -> Double { self.z }

pub fn TimeseriesdecomphpPoint::label(self : TimeseriesdecomphpPoint) -> Int { self.label }

pub fn TimeseriesdecomphpPoint::dist(self : TimeseriesdecomphpPoint, other : TimeseriesdecomphpPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn TimeseriesdecomphpPoint::add(self : TimeseriesdecomphpPoint, other : TimeseriesdecomphpPoint) -> TimeseriesdecomphpPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn TimeseriesdecomphpPoint::sub(self : TimeseriesdecomphpPoint, other : TimeseriesdecomphpPoint) -> TimeseriesdecomphpPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn TimeseriesdecomphpPoint::scale(self : TimeseriesdecomphpPoint, s : Double) -> TimeseriesdecomphpPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn TimeseriesdecomphpPoint::dot(self : TimeseriesdecomphpPoint, other : TimeseriesdecomphpPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn TimeseriesdecomphpPoint::cross(self : TimeseriesdecomphpPoint, other : TimeseriesdecomphpPoint) -> TimeseriesdecomphpPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn TimeseriesdecomphpPoint::norm(self : TimeseriesdecomphpPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn TimeseriesdecomphpPoint::normalize(self : TimeseriesdecomphpPoint) -> TimeseriesdecomphpPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn TimeseriesdecomphpPoint::negate(self : TimeseriesdecomphpPoint) -> TimeseriesdecomphpPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn TimeseriesdecomphpPoint::mid(self : TimeseriesdecomphpPoint, other : TimeseriesdecomphpPoint) -> TimeseriesdecomphpPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn TimeseriesdecomphpPoint::lerp(self : TimeseriesdecomphpPoint, other : TimeseriesdecomphpPoint, t : Double) -> TimeseriesdecomphpPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn TimeseriesdecomphpPoint::to_string(self : TimeseriesdecomphpPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct TimeseriesdecomphpSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn timeseries_decomp_hp_make_series(vals : Array[Double], name : String) -> TimeseriesdecomphpSeries {
  { vals, name, meta: 0 }
}

pub fn TimeseriesdecomphpSeries::len(self : TimeseriesdecomphpSeries) -> Int { self.vals.length() }

pub fn TimeseriesdecomphpSeries::sum(self : TimeseriesdecomphpSeries) -> Double { @_common.sum(self.vals) }

pub fn TimeseriesdecomphpSeries::mean(self : TimeseriesdecomphpSeries) -> Double { @_common.mean(self.vals) }

pub fn TimeseriesdecomphpSeries::min(self : TimeseriesdecomphpSeries) -> Double { @_common.min(self.vals) }

pub fn TimeseriesdecomphpSeries::max(self : TimeseriesdecomphpSeries) -> Double { @_common.max(self.vals) }

pub fn TimeseriesdecomphpSeries::range(self : TimeseriesdecomphpSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn TimeseriesdecomphpSeries::variance(self : TimeseriesdecomphpSeries) -> Double { @_common.variance(self.vals) }

pub fn TimeseriesdecomphpSeries::std(self : TimeseriesdecomphpSeries) -> Double { @_common.std(self.vals) }

pub fn TimeseriesdecomphpSeries::median(self : TimeseriesdecomphpSeries) -> Double { @_common.median(self.vals) }

pub fn TimeseriesdecomphpSeries::scale(self : TimeseriesdecomphpSeries, f : Double) -> TimeseriesdecomphpSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn TimeseriesdecomphpSeries::add(self : TimeseriesdecomphpSeries, other : TimeseriesdecomphpSeries) -> TimeseriesdecomphpSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn TimeseriesdecomphpSeries::sub(self : TimeseriesdecomphpSeries, other : TimeseriesdecomphpSeries) -> TimeseriesdecomphpSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn TimeseriesdecomphpSeries::normalize(self : TimeseriesdecomphpSeries) -> TimeseriesdecomphpSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn TimeseriesdecomphpSeries::cumsum(self : TimeseriesdecomphpSeries) -> TimeseriesdecomphpSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn TimeseriesdecomphpSeries::to_string(self : TimeseriesdecomphpSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct TimeseriesdecomphpMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn timeseries_decomp_hp_make_matrix(rows : Int, cols : Int, val : Double) -> TimeseriesdecomphpMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn timeseries_decomp_hp_matrix_identity(n : Int) -> TimeseriesdecomphpMatrix {
  let m = timeseries_decomp_hp_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn TimeseriesdecomphpMatrix::get(self : TimeseriesdecomphpMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn TimeseriesdecomphpMatrix::transpose(self : TimeseriesdecomphpMatrix) -> TimeseriesdecomphpMatrix {
  let result = timeseries_decomp_hp_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn TimeseriesdecomphpMatrix::add(self : TimeseriesdecomphpMatrix, other : TimeseriesdecomphpMatrix) -> TimeseriesdecomphpMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = timeseries_decomp_hp_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn TimeseriesdecomphpMatrix::scale(self : TimeseriesdecomphpMatrix, s : Double) -> TimeseriesdecomphpMatrix {
  let result = timeseries_decomp_hp_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn TimeseriesdecomphpMatrix::multiply(self : TimeseriesdecomphpMatrix, other : TimeseriesdecomphpMatrix) -> TimeseriesdecomphpMatrix {
  if self.cols != other.rows { return timeseries_decomp_hp_make_matrix(self.rows, other.cols, 0.0) }
  let result = timeseries_decomp_hp_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn TimeseriesdecomphpMatrix::trace(self : TimeseriesdecomphpMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn TimeseriesdecomphpMatrix::det(self : TimeseriesdecomphpMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn TimeseriesdecomphpMatrix::norm(self : TimeseriesdecomphpMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn TimeseriesdecomphpMatrix::to_string(self : TimeseriesdecomphpMatrix) -> String {
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

pub(all) struct TimeseriesdecomphpVector {
  comps : Array[Double]
  dim : Int
}

pub fn timeseries_decomp_hp_make_vector(comps : Array[Double]) -> TimeseriesdecomphpVector {
  { comps, dim: comps.length() }
}

pub fn timeseries_decomp_hp_vector_zero(dim : Int) -> TimeseriesdecomphpVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn TimeseriesdecomphpVector::add(self : TimeseriesdecomphpVector, other : TimeseriesdecomphpVector) -> TimeseriesdecomphpVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn TimeseriesdecomphpVector::sub(self : TimeseriesdecomphpVector, other : TimeseriesdecomphpVector) -> TimeseriesdecomphpVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn TimeseriesdecomphpVector::scale(self : TimeseriesdecomphpVector, s : Double) -> TimeseriesdecomphpVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn TimeseriesdecomphpVector::dot(self : TimeseriesdecomphpVector, other : TimeseriesdecomphpVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn TimeseriesdecomphpVector::norm(self : TimeseriesdecomphpVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn TimeseriesdecomphpVector::normalize(self : TimeseriesdecomphpVector) -> TimeseriesdecomphpVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn TimeseriesdecomphpVector::dist(self : TimeseriesdecomphpVector, other : TimeseriesdecomphpVector) -> Double {
  self.sub(other).norm()
}

pub fn TimeseriesdecomphpVector::to_string(self : TimeseriesdecomphpVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn timeseries_decomp_hp_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn timeseries_decomp_hp_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn timeseries_decomp_hp_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn timeseries_decomp_hp_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn timeseries_decomp_hp_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn timeseries_decomp_hp_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn timeseries_decomp_hp_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn timeseries_decomp_hp_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn timeseries_decomp_hp_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn timeseries_decomp_hp_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn timeseries_decomp_hp_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn timeseries_decomp_hp_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn timeseries_decomp_hp_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn timeseries_decomp_hp_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn timeseries_decomp_hp_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn timeseries_decomp_hp_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn timeseries_decomp_hp_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn timeseries_decomp_hp_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn timeseries_decomp_hp_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn timeseries_decomp_hp_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn timeseries_decomp_hp_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn timeseries_decomp_hp_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn timeseries_decomp_hp_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn timeseries_decomp_hp_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn timeseries_decomp_hp_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn timeseries_decomp_hp_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn timeseries_decomp_hp_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn timeseries_decomp_hp_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn timeseries_decomp_hp_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct TimeseriesdecomphpFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_decomp_hp_frame_make(size : Int) -> TimeseriesdecomphpFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_decomp_hp_frame_len(s : TimeseriesdecomphpFrame) -> Int { s.size }

pub fn timeseries_decomp_hp_frame_get(s : TimeseriesdecomphpFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_decomp_hp_frame_set(s : TimeseriesdecomphpFrame, i : Int, v : Double) -> TimeseriesdecomphpFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_hp_frame_sum(s : TimeseriesdecomphpFrame) -> Double { @_common.sum(s.data) }

pub fn timeseries_decomp_hp_frame_mean(s : TimeseriesdecomphpFrame) -> Double { @_common.mean(s.data) }

pub fn timeseries_decomp_hp_frame_scale(s : TimeseriesdecomphpFrame, f : Double) -> TimeseriesdecomphpFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_hp_frame_add(a : TimeseriesdecomphpFrame, b : TimeseriesdecomphpFrame) -> TimeseriesdecomphpFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_decomp_hp_frame_copy(s : TimeseriesdecomphpFrame) -> TimeseriesdecomphpFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_hp_frame_fill(s : TimeseriesdecomphpFrame, v : Double) -> TimeseriesdecomphpFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_hp_frame_min(s : TimeseriesdecomphpFrame) -> Double { @_common.min(s.data) }

pub fn timeseries_decomp_hp_frame_max(s : TimeseriesdecomphpFrame) -> Double { @_common.max(s.data) }

pub fn timeseries_decomp_hp_frame_to_string(s : TimeseriesdecomphpFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesdecomphpTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_decomp_hp_table_make(size : Int) -> TimeseriesdecomphpTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_decomp_hp_table_len(s : TimeseriesdecomphpTable) -> Int { s.size }

pub fn timeseries_decomp_hp_table_get(s : TimeseriesdecomphpTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_decomp_hp_table_set(s : TimeseriesdecomphpTable, i : Int, v : Double) -> TimeseriesdecomphpTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_hp_table_sum(s : TimeseriesdecomphpTable) -> Double { @_common.sum(s.data) }

pub fn timeseries_decomp_hp_table_mean(s : TimeseriesdecomphpTable) -> Double { @_common.mean(s.data) }

pub fn timeseries_decomp_hp_table_scale(s : TimeseriesdecomphpTable, f : Double) -> TimeseriesdecomphpTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_hp_table_add(a : TimeseriesdecomphpTable, b : TimeseriesdecomphpTable) -> TimeseriesdecomphpTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_decomp_hp_table_copy(s : TimeseriesdecomphpTable) -> TimeseriesdecomphpTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_hp_table_fill(s : TimeseriesdecomphpTable, v : Double) -> TimeseriesdecomphpTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_hp_table_min(s : TimeseriesdecomphpTable) -> Double { @_common.min(s.data) }

pub fn timeseries_decomp_hp_table_max(s : TimeseriesdecomphpTable) -> Double { @_common.max(s.data) }

pub fn timeseries_decomp_hp_table_to_string(s : TimeseriesdecomphpTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesdecomphpGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_decomp_hp_graphn_make(size : Int) -> TimeseriesdecomphpGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_decomp_hp_graphn_len(s : TimeseriesdecomphpGraphN) -> Int { s.size }

pub fn timeseries_decomp_hp_graphn_get(s : TimeseriesdecomphpGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_decomp_hp_graphn_set(s : TimeseriesdecomphpGraphN, i : Int, v : Double) -> TimeseriesdecomphpGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_hp_graphn_sum(s : TimeseriesdecomphpGraphN) -> Double { @_common.sum(s.data) }

pub fn timeseries_decomp_hp_graphn_mean(s : TimeseriesdecomphpGraphN) -> Double { @_common.mean(s.data) }

pub fn timeseries_decomp_hp_graphn_scale(s : TimeseriesdecomphpGraphN, f : Double) -> TimeseriesdecomphpGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_hp_graphn_add(a : TimeseriesdecomphpGraphN, b : TimeseriesdecomphpGraphN) -> TimeseriesdecomphpGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_decomp_hp_graphn_copy(s : TimeseriesdecomphpGraphN) -> TimeseriesdecomphpGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_hp_graphn_fill(s : TimeseriesdecomphpGraphN, v : Double) -> TimeseriesdecomphpGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_hp_graphn_min(s : TimeseriesdecomphpGraphN) -> Double { @_common.min(s.data) }

pub fn timeseries_decomp_hp_graphn_max(s : TimeseriesdecomphpGraphN) -> Double { @_common.max(s.data) }

pub fn timeseries_decomp_hp_graphn_to_string(s : TimeseriesdecomphpGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesdecomphpNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_decomp_hp_node_make(size : Int) -> TimeseriesdecomphpNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_decomp_hp_node_len(s : TimeseriesdecomphpNode) -> Int { s.size }

pub fn timeseries_decomp_hp_node_get(s : TimeseriesdecomphpNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_decomp_hp_node_set(s : TimeseriesdecomphpNode, i : Int, v : Double) -> TimeseriesdecomphpNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_hp_node_sum(s : TimeseriesdecomphpNode) -> Double { @_common.sum(s.data) }

pub fn timeseries_decomp_hp_node_mean(s : TimeseriesdecomphpNode) -> Double { @_common.mean(s.data) }

pub fn timeseries_decomp_hp_node_scale(s : TimeseriesdecomphpNode, f : Double) -> TimeseriesdecomphpNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_hp_node_add(a : TimeseriesdecomphpNode, b : TimeseriesdecomphpNode) -> TimeseriesdecomphpNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_decomp_hp_node_copy(s : TimeseriesdecomphpNode) -> TimeseriesdecomphpNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_hp_node_fill(s : TimeseriesdecomphpNode, v : Double) -> TimeseriesdecomphpNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_hp_node_min(s : TimeseriesdecomphpNode) -> Double { @_common.min(s.data) }

pub fn timeseries_decomp_hp_node_max(s : TimeseriesdecomphpNode) -> Double { @_common.max(s.data) }

pub fn timeseries_decomp_hp_node_to_string(s : TimeseriesdecomphpNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesdecomphpEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_decomp_hp_edge_make(size : Int) -> TimeseriesdecomphpEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_decomp_hp_edge_len(s : TimeseriesdecomphpEdge) -> Int { s.size }

pub fn timeseries_decomp_hp_edge_get(s : TimeseriesdecomphpEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_decomp_hp_edge_set(s : TimeseriesdecomphpEdge, i : Int, v : Double) -> TimeseriesdecomphpEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_hp_edge_sum(s : TimeseriesdecomphpEdge) -> Double { @_common.sum(s.data) }

pub fn timeseries_decomp_hp_edge_mean(s : TimeseriesdecomphpEdge) -> Double { @_common.mean(s.data) }

pub fn timeseries_decomp_hp_edge_scale(s : TimeseriesdecomphpEdge, f : Double) -> TimeseriesdecomphpEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_hp_edge_add(a : TimeseriesdecomphpEdge, b : TimeseriesdecomphpEdge) -> TimeseriesdecomphpEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_decomp_hp_edge_copy(s : TimeseriesdecomphpEdge) -> TimeseriesdecomphpEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_hp_edge_fill(s : TimeseriesdecomphpEdge, v : Double) -> TimeseriesdecomphpEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_hp_edge_min(s : TimeseriesdecomphpEdge) -> Double { @_common.min(s.data) }

pub fn timeseries_decomp_hp_edge_max(s : TimeseriesdecomphpEdge) -> Double { @_common.max(s.data) }

pub fn timeseries_decomp_hp_edge_to_string(s : TimeseriesdecomphpEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesdecomphpPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_decomp_hp_path_make(size : Int) -> TimeseriesdecomphpPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_decomp_hp_path_len(s : TimeseriesdecomphpPath) -> Int { s.size }

pub fn timeseries_decomp_hp_path_get(s : TimeseriesdecomphpPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_decomp_hp_path_set(s : TimeseriesdecomphpPath, i : Int, v : Double) -> TimeseriesdecomphpPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_hp_path_sum(s : TimeseriesdecomphpPath) -> Double { @_common.sum(s.data) }

pub fn timeseries_decomp_hp_path_mean(s : TimeseriesdecomphpPath) -> Double { @_common.mean(s.data) }

pub fn timeseries_decomp_hp_path_scale(s : TimeseriesdecomphpPath, f : Double) -> TimeseriesdecomphpPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_hp_path_add(a : TimeseriesdecomphpPath, b : TimeseriesdecomphpPath) -> TimeseriesdecomphpPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_decomp_hp_path_copy(s : TimeseriesdecomphpPath) -> TimeseriesdecomphpPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_hp_path_fill(s : TimeseriesdecomphpPath, v : Double) -> TimeseriesdecomphpPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_hp_path_min(s : TimeseriesdecomphpPath) -> Double { @_common.min(s.data) }

pub fn timeseries_decomp_hp_path_max(s : TimeseriesdecomphpPath) -> Double { @_common.max(s.data) }

pub fn timeseries_decomp_hp_path_to_string(s : TimeseriesdecomphpPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesdecomphpCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_decomp_hp_cluster_make(size : Int) -> TimeseriesdecomphpCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_decomp_hp_cluster_len(s : TimeseriesdecomphpCluster) -> Int { s.size }

pub fn timeseries_decomp_hp_cluster_get(s : TimeseriesdecomphpCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_decomp_hp_cluster_set(s : TimeseriesdecomphpCluster, i : Int, v : Double) -> TimeseriesdecomphpCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_hp_cluster_sum(s : TimeseriesdecomphpCluster) -> Double { @_common.sum(s.data) }

pub fn timeseries_decomp_hp_cluster_mean(s : TimeseriesdecomphpCluster) -> Double { @_common.mean(s.data) }

pub fn timeseries_decomp_hp_cluster_scale(s : TimeseriesdecomphpCluster, f : Double) -> TimeseriesdecomphpCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_hp_cluster_add(a : TimeseriesdecomphpCluster, b : TimeseriesdecomphpCluster) -> TimeseriesdecomphpCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_decomp_hp_cluster_copy(s : TimeseriesdecomphpCluster) -> TimeseriesdecomphpCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_hp_cluster_fill(s : TimeseriesdecomphpCluster, v : Double) -> TimeseriesdecomphpCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_hp_cluster_min(s : TimeseriesdecomphpCluster) -> Double { @_common.min(s.data) }

pub fn timeseries_decomp_hp_cluster_max(s : TimeseriesdecomphpCluster) -> Double { @_common.max(s.data) }

pub fn timeseries_decomp_hp_cluster_to_string(s : TimeseriesdecomphpCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesdecomphpModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_decomp_hp_model_make(size : Int) -> TimeseriesdecomphpModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_decomp_hp_model_len(s : TimeseriesdecomphpModel) -> Int { s.size }

pub fn timeseries_decomp_hp_model_get(s : TimeseriesdecomphpModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_decomp_hp_model_set(s : TimeseriesdecomphpModel, i : Int, v : Double) -> TimeseriesdecomphpModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_hp_model_sum(s : TimeseriesdecomphpModel) -> Double { @_common.sum(s.data) }

pub fn timeseries_decomp_hp_model_mean(s : TimeseriesdecomphpModel) -> Double { @_common.mean(s.data) }

pub fn timeseries_decomp_hp_model_scale(s : TimeseriesdecomphpModel, f : Double) -> TimeseriesdecomphpModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_hp_model_add(a : TimeseriesdecomphpModel, b : TimeseriesdecomphpModel) -> TimeseriesdecomphpModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_decomp_hp_model_copy(s : TimeseriesdecomphpModel) -> TimeseriesdecomphpModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_hp_model_fill(s : TimeseriesdecomphpModel, v : Double) -> TimeseriesdecomphpModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_hp_model_min(s : TimeseriesdecomphpModel) -> Double { @_common.min(s.data) }

pub fn timeseries_decomp_hp_model_max(s : TimeseriesdecomphpModel) -> Double { @_common.max(s.data) }

pub fn timeseries_decomp_hp_model_to_string(s : TimeseriesdecomphpModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesdecomphpLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_decomp_hp_layer_make(size : Int) -> TimeseriesdecomphpLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_decomp_hp_layer_len(s : TimeseriesdecomphpLayer) -> Int { s.size }

pub fn timeseries_decomp_hp_layer_get(s : TimeseriesdecomphpLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_decomp_hp_layer_set(s : TimeseriesdecomphpLayer, i : Int, v : Double) -> TimeseriesdecomphpLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_hp_layer_sum(s : TimeseriesdecomphpLayer) -> Double { @_common.sum(s.data) }

pub fn timeseries_decomp_hp_layer_mean(s : TimeseriesdecomphpLayer) -> Double { @_common.mean(s.data) }

pub fn timeseries_decomp_hp_layer_scale(s : TimeseriesdecomphpLayer, f : Double) -> TimeseriesdecomphpLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_hp_layer_add(a : TimeseriesdecomphpLayer, b : TimeseriesdecomphpLayer) -> TimeseriesdecomphpLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_decomp_hp_layer_copy(s : TimeseriesdecomphpLayer) -> TimeseriesdecomphpLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_hp_layer_fill(s : TimeseriesdecomphpLayer, v : Double) -> TimeseriesdecomphpLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_hp_layer_min(s : TimeseriesdecomphpLayer) -> Double { @_common.min(s.data) }

pub fn timeseries_decomp_hp_layer_max(s : TimeseriesdecomphpLayer) -> Double { @_common.max(s.data) }

pub fn timeseries_decomp_hp_layer_to_string(s : TimeseriesdecomphpLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesdecomphpBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_decomp_hp_buffer_make(size : Int) -> TimeseriesdecomphpBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_decomp_hp_buffer_len(s : TimeseriesdecomphpBuffer) -> Int { s.size }

pub fn timeseries_decomp_hp_buffer_get(s : TimeseriesdecomphpBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_decomp_hp_buffer_set(s : TimeseriesdecomphpBuffer, i : Int, v : Double) -> TimeseriesdecomphpBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_hp_buffer_sum(s : TimeseriesdecomphpBuffer) -> Double { @_common.sum(s.data) }

pub fn timeseries_decomp_hp_buffer_mean(s : TimeseriesdecomphpBuffer) -> Double { @_common.mean(s.data) }

pub fn timeseries_decomp_hp_buffer_scale(s : TimeseriesdecomphpBuffer, f : Double) -> TimeseriesdecomphpBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_hp_buffer_add(a : TimeseriesdecomphpBuffer, b : TimeseriesdecomphpBuffer) -> TimeseriesdecomphpBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_decomp_hp_buffer_copy(s : TimeseriesdecomphpBuffer) -> TimeseriesdecomphpBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_hp_buffer_fill(s : TimeseriesdecomphpBuffer, v : Double) -> TimeseriesdecomphpBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_hp_buffer_min(s : TimeseriesdecomphpBuffer) -> Double { @_common.min(s.data) }

pub fn timeseries_decomp_hp_buffer_max(s : TimeseriesdecomphpBuffer) -> Double { @_common.max(s.data) }

pub fn timeseries_decomp_hp_buffer_to_string(s : TimeseriesdecomphpBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesdecomphpCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_decomp_hp_cursor_make(size : Int) -> TimeseriesdecomphpCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_decomp_hp_cursor_len(s : TimeseriesdecomphpCursor) -> Int { s.size }

pub fn timeseries_decomp_hp_cursor_get(s : TimeseriesdecomphpCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_decomp_hp_cursor_set(s : TimeseriesdecomphpCursor, i : Int, v : Double) -> TimeseriesdecomphpCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_hp_cursor_sum(s : TimeseriesdecomphpCursor) -> Double { @_common.sum(s.data) }

pub fn timeseries_decomp_hp_cursor_mean(s : TimeseriesdecomphpCursor) -> Double { @_common.mean(s.data) }

pub fn timeseries_decomp_hp_cursor_scale(s : TimeseriesdecomphpCursor, f : Double) -> TimeseriesdecomphpCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_hp_cursor_add(a : TimeseriesdecomphpCursor, b : TimeseriesdecomphpCursor) -> TimeseriesdecomphpCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_decomp_hp_cursor_copy(s : TimeseriesdecomphpCursor) -> TimeseriesdecomphpCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_hp_cursor_fill(s : TimeseriesdecomphpCursor, v : Double) -> TimeseriesdecomphpCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_hp_cursor_min(s : TimeseriesdecomphpCursor) -> Double { @_common.min(s.data) }

pub fn timeseries_decomp_hp_cursor_max(s : TimeseriesdecomphpCursor) -> Double { @_common.max(s.data) }

pub fn timeseries_decomp_hp_cursor_to_string(s : TimeseriesdecomphpCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesdecomphpView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_decomp_hp_view_make(size : Int) -> TimeseriesdecomphpView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_decomp_hp_view_len(s : TimeseriesdecomphpView) -> Int { s.size }

pub fn timeseries_decomp_hp_view_get(s : TimeseriesdecomphpView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_decomp_hp_view_set(s : TimeseriesdecomphpView, i : Int, v : Double) -> TimeseriesdecomphpView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_hp_view_sum(s : TimeseriesdecomphpView) -> Double { @_common.sum(s.data) }

pub fn timeseries_decomp_hp_view_mean(s : TimeseriesdecomphpView) -> Double { @_common.mean(s.data) }

pub fn timeseries_decomp_hp_view_scale(s : TimeseriesdecomphpView, f : Double) -> TimeseriesdecomphpView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_hp_view_add(a : TimeseriesdecomphpView, b : TimeseriesdecomphpView) -> TimeseriesdecomphpView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_decomp_hp_view_copy(s : TimeseriesdecomphpView) -> TimeseriesdecomphpView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_hp_view_fill(s : TimeseriesdecomphpView, v : Double) -> TimeseriesdecomphpView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_hp_view_min(s : TimeseriesdecomphpView) -> Double { @_common.min(s.data) }

pub fn timeseries_decomp_hp_view_max(s : TimeseriesdecomphpView) -> Double { @_common.max(s.data) }

pub fn timeseries_decomp_hp_view_to_string(s : TimeseriesdecomphpView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesdecomphpRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_decomp_hp_range_make(size : Int) -> TimeseriesdecomphpRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_decomp_hp_range_len(s : TimeseriesdecomphpRange) -> Int { s.size }

pub fn timeseries_decomp_hp_range_get(s : TimeseriesdecomphpRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_decomp_hp_range_set(s : TimeseriesdecomphpRange, i : Int, v : Double) -> TimeseriesdecomphpRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_hp_range_sum(s : TimeseriesdecomphpRange) -> Double { @_common.sum(s.data) }

pub fn timeseries_decomp_hp_range_mean(s : TimeseriesdecomphpRange) -> Double { @_common.mean(s.data) }

pub fn timeseries_decomp_hp_range_scale(s : TimeseriesdecomphpRange, f : Double) -> TimeseriesdecomphpRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_hp_range_add(a : TimeseriesdecomphpRange, b : TimeseriesdecomphpRange) -> TimeseriesdecomphpRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_decomp_hp_range_copy(s : TimeseriesdecomphpRange) -> TimeseriesdecomphpRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_hp_range_fill(s : TimeseriesdecomphpRange, v : Double) -> TimeseriesdecomphpRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_hp_range_min(s : TimeseriesdecomphpRange) -> Double { @_common.min(s.data) }

pub fn timeseries_decomp_hp_range_max(s : TimeseriesdecomphpRange) -> Double { @_common.max(s.data) }

pub fn timeseries_decomp_hp_range_to_string(s : TimeseriesdecomphpRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesdecomphpSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_decomp_hp_slice_make(size : Int) -> TimeseriesdecomphpSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_decomp_hp_slice_len(s : TimeseriesdecomphpSlice) -> Int { s.size }

pub fn timeseries_decomp_hp_slice_get(s : TimeseriesdecomphpSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_decomp_hp_slice_set(s : TimeseriesdecomphpSlice, i : Int, v : Double) -> TimeseriesdecomphpSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_hp_slice_sum(s : TimeseriesdecomphpSlice) -> Double { @_common.sum(s.data) }

pub fn timeseries_decomp_hp_slice_mean(s : TimeseriesdecomphpSlice) -> Double { @_common.mean(s.data) }

pub fn timeseries_decomp_hp_slice_scale(s : TimeseriesdecomphpSlice, f : Double) -> TimeseriesdecomphpSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_hp_slice_add(a : TimeseriesdecomphpSlice, b : TimeseriesdecomphpSlice) -> TimeseriesdecomphpSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_decomp_hp_slice_copy(s : TimeseriesdecomphpSlice) -> TimeseriesdecomphpSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_hp_slice_fill(s : TimeseriesdecomphpSlice, v : Double) -> TimeseriesdecomphpSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_hp_slice_min(s : TimeseriesdecomphpSlice) -> Double { @_common.min(s.data) }

pub fn timeseries_decomp_hp_slice_max(s : TimeseriesdecomphpSlice) -> Double { @_common.max(s.data) }

pub fn timeseries_decomp_hp_slice_to_string(s : TimeseriesdecomphpSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

