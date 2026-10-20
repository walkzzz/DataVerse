///===
/// extcore/timeseries_forecast_theta

pub(all) struct TimeseriesforecastthetaPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn timeseries_forecast_theta_make_point(x : Double, y : Double) -> TimeseriesforecastthetaPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn timeseries_forecast_theta_make_point3(x : Double, y : Double, z : Double) -> TimeseriesforecastthetaPoint {
  { x, y, z, label: 0 }
}

pub fn TimeseriesforecastthetaPoint::x(self : TimeseriesforecastthetaPoint) -> Double { self.x }

pub fn TimeseriesforecastthetaPoint::y(self : TimeseriesforecastthetaPoint) -> Double { self.y }

pub fn TimeseriesforecastthetaPoint::z(self : TimeseriesforecastthetaPoint) -> Double { self.z }

pub fn TimeseriesforecastthetaPoint::label(self : TimeseriesforecastthetaPoint) -> Int { self.label }

pub fn TimeseriesforecastthetaPoint::dist(self : TimeseriesforecastthetaPoint, other : TimeseriesforecastthetaPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn TimeseriesforecastthetaPoint::add(self : TimeseriesforecastthetaPoint, other : TimeseriesforecastthetaPoint) -> TimeseriesforecastthetaPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn TimeseriesforecastthetaPoint::sub(self : TimeseriesforecastthetaPoint, other : TimeseriesforecastthetaPoint) -> TimeseriesforecastthetaPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn TimeseriesforecastthetaPoint::scale(self : TimeseriesforecastthetaPoint, s : Double) -> TimeseriesforecastthetaPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn TimeseriesforecastthetaPoint::dot(self : TimeseriesforecastthetaPoint, other : TimeseriesforecastthetaPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn TimeseriesforecastthetaPoint::cross(self : TimeseriesforecastthetaPoint, other : TimeseriesforecastthetaPoint) -> TimeseriesforecastthetaPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn TimeseriesforecastthetaPoint::norm(self : TimeseriesforecastthetaPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn TimeseriesforecastthetaPoint::normalize(self : TimeseriesforecastthetaPoint) -> TimeseriesforecastthetaPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn TimeseriesforecastthetaPoint::negate(self : TimeseriesforecastthetaPoint) -> TimeseriesforecastthetaPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn TimeseriesforecastthetaPoint::mid(self : TimeseriesforecastthetaPoint, other : TimeseriesforecastthetaPoint) -> TimeseriesforecastthetaPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn TimeseriesforecastthetaPoint::lerp(self : TimeseriesforecastthetaPoint, other : TimeseriesforecastthetaPoint, t : Double) -> TimeseriesforecastthetaPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn TimeseriesforecastthetaPoint::to_string(self : TimeseriesforecastthetaPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct TimeseriesforecastthetaSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn timeseries_forecast_theta_make_series(vals : Array[Double], name : String) -> TimeseriesforecastthetaSeries {
  { vals, name, meta: 0 }
}

pub fn TimeseriesforecastthetaSeries::len(self : TimeseriesforecastthetaSeries) -> Int { self.vals.length() }

pub fn TimeseriesforecastthetaSeries::sum(self : TimeseriesforecastthetaSeries) -> Double { @_common.sum(self.vals) }

pub fn TimeseriesforecastthetaSeries::mean(self : TimeseriesforecastthetaSeries) -> Double { @_common.mean(self.vals) }

pub fn TimeseriesforecastthetaSeries::min(self : TimeseriesforecastthetaSeries) -> Double { @_common.min(self.vals) }

pub fn TimeseriesforecastthetaSeries::max(self : TimeseriesforecastthetaSeries) -> Double { @_common.max(self.vals) }

pub fn TimeseriesforecastthetaSeries::range(self : TimeseriesforecastthetaSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn TimeseriesforecastthetaSeries::variance(self : TimeseriesforecastthetaSeries) -> Double { @_common.variance(self.vals) }

pub fn TimeseriesforecastthetaSeries::std(self : TimeseriesforecastthetaSeries) -> Double { @_common.std(self.vals) }

pub fn TimeseriesforecastthetaSeries::median(self : TimeseriesforecastthetaSeries) -> Double { @_common.median(self.vals) }

pub fn TimeseriesforecastthetaSeries::scale(self : TimeseriesforecastthetaSeries, f : Double) -> TimeseriesforecastthetaSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn TimeseriesforecastthetaSeries::add(self : TimeseriesforecastthetaSeries, other : TimeseriesforecastthetaSeries) -> TimeseriesforecastthetaSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn TimeseriesforecastthetaSeries::sub(self : TimeseriesforecastthetaSeries, other : TimeseriesforecastthetaSeries) -> TimeseriesforecastthetaSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn TimeseriesforecastthetaSeries::normalize(self : TimeseriesforecastthetaSeries) -> TimeseriesforecastthetaSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn TimeseriesforecastthetaSeries::cumsum(self : TimeseriesforecastthetaSeries) -> TimeseriesforecastthetaSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn TimeseriesforecastthetaSeries::to_string(self : TimeseriesforecastthetaSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct TimeseriesforecastthetaMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn timeseries_forecast_theta_make_matrix(rows : Int, cols : Int, val : Double) -> TimeseriesforecastthetaMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn timeseries_forecast_theta_matrix_identity(n : Int) -> TimeseriesforecastthetaMatrix {
  let m = timeseries_forecast_theta_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn TimeseriesforecastthetaMatrix::get(self : TimeseriesforecastthetaMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn TimeseriesforecastthetaMatrix::transpose(self : TimeseriesforecastthetaMatrix) -> TimeseriesforecastthetaMatrix {
  let result = timeseries_forecast_theta_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn TimeseriesforecastthetaMatrix::add(self : TimeseriesforecastthetaMatrix, other : TimeseriesforecastthetaMatrix) -> TimeseriesforecastthetaMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = timeseries_forecast_theta_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn TimeseriesforecastthetaMatrix::scale(self : TimeseriesforecastthetaMatrix, s : Double) -> TimeseriesforecastthetaMatrix {
  let result = timeseries_forecast_theta_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn TimeseriesforecastthetaMatrix::multiply(self : TimeseriesforecastthetaMatrix, other : TimeseriesforecastthetaMatrix) -> TimeseriesforecastthetaMatrix {
  if self.cols != other.rows { return timeseries_forecast_theta_make_matrix(self.rows, other.cols, 0.0) }
  let result = timeseries_forecast_theta_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn TimeseriesforecastthetaMatrix::trace(self : TimeseriesforecastthetaMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn TimeseriesforecastthetaMatrix::det(self : TimeseriesforecastthetaMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn TimeseriesforecastthetaMatrix::norm(self : TimeseriesforecastthetaMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn TimeseriesforecastthetaMatrix::to_string(self : TimeseriesforecastthetaMatrix) -> String {
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

pub(all) struct TimeseriesforecastthetaVector {
  comps : Array[Double]
  dim : Int
}

pub fn timeseries_forecast_theta_make_vector(comps : Array[Double]) -> TimeseriesforecastthetaVector {
  { comps, dim: comps.length() }
}

pub fn timeseries_forecast_theta_vector_zero(dim : Int) -> TimeseriesforecastthetaVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn TimeseriesforecastthetaVector::add(self : TimeseriesforecastthetaVector, other : TimeseriesforecastthetaVector) -> TimeseriesforecastthetaVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn TimeseriesforecastthetaVector::sub(self : TimeseriesforecastthetaVector, other : TimeseriesforecastthetaVector) -> TimeseriesforecastthetaVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn TimeseriesforecastthetaVector::scale(self : TimeseriesforecastthetaVector, s : Double) -> TimeseriesforecastthetaVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn TimeseriesforecastthetaVector::dot(self : TimeseriesforecastthetaVector, other : TimeseriesforecastthetaVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn TimeseriesforecastthetaVector::norm(self : TimeseriesforecastthetaVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn TimeseriesforecastthetaVector::normalize(self : TimeseriesforecastthetaVector) -> TimeseriesforecastthetaVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn TimeseriesforecastthetaVector::dist(self : TimeseriesforecastthetaVector, other : TimeseriesforecastthetaVector) -> Double {
  self.sub(other).norm()
}

pub fn TimeseriesforecastthetaVector::to_string(self : TimeseriesforecastthetaVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn timeseries_forecast_theta_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn timeseries_forecast_theta_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn timeseries_forecast_theta_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn timeseries_forecast_theta_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn timeseries_forecast_theta_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn timeseries_forecast_theta_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn timeseries_forecast_theta_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn timeseries_forecast_theta_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn timeseries_forecast_theta_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn timeseries_forecast_theta_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn timeseries_forecast_theta_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn timeseries_forecast_theta_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn timeseries_forecast_theta_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn timeseries_forecast_theta_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn timeseries_forecast_theta_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn timeseries_forecast_theta_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn timeseries_forecast_theta_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn timeseries_forecast_theta_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn timeseries_forecast_theta_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn timeseries_forecast_theta_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn timeseries_forecast_theta_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn timeseries_forecast_theta_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn timeseries_forecast_theta_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn timeseries_forecast_theta_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn timeseries_forecast_theta_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn timeseries_forecast_theta_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn timeseries_forecast_theta_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn timeseries_forecast_theta_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn timeseries_forecast_theta_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct TimeseriesforecastthetaFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_forecast_theta_frame_make(size : Int) -> TimeseriesforecastthetaFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_forecast_theta_frame_len(s : TimeseriesforecastthetaFrame) -> Int { s.size }

pub fn timeseries_forecast_theta_frame_get(s : TimeseriesforecastthetaFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_forecast_theta_frame_set(s : TimeseriesforecastthetaFrame, i : Int, v : Double) -> TimeseriesforecastthetaFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_theta_frame_sum(s : TimeseriesforecastthetaFrame) -> Double { @_common.sum(s.data) }

pub fn timeseries_forecast_theta_frame_mean(s : TimeseriesforecastthetaFrame) -> Double { @_common.mean(s.data) }

pub fn timeseries_forecast_theta_frame_scale(s : TimeseriesforecastthetaFrame, f : Double) -> TimeseriesforecastthetaFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_theta_frame_add(a : TimeseriesforecastthetaFrame, b : TimeseriesforecastthetaFrame) -> TimeseriesforecastthetaFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_forecast_theta_frame_copy(s : TimeseriesforecastthetaFrame) -> TimeseriesforecastthetaFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_theta_frame_fill(s : TimeseriesforecastthetaFrame, v : Double) -> TimeseriesforecastthetaFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_theta_frame_min(s : TimeseriesforecastthetaFrame) -> Double { @_common.min(s.data) }

pub fn timeseries_forecast_theta_frame_max(s : TimeseriesforecastthetaFrame) -> Double { @_common.max(s.data) }

pub fn timeseries_forecast_theta_frame_to_string(s : TimeseriesforecastthetaFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesforecastthetaTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_forecast_theta_table_make(size : Int) -> TimeseriesforecastthetaTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_forecast_theta_table_len(s : TimeseriesforecastthetaTable) -> Int { s.size }

pub fn timeseries_forecast_theta_table_get(s : TimeseriesforecastthetaTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_forecast_theta_table_set(s : TimeseriesforecastthetaTable, i : Int, v : Double) -> TimeseriesforecastthetaTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_theta_table_sum(s : TimeseriesforecastthetaTable) -> Double { @_common.sum(s.data) }

pub fn timeseries_forecast_theta_table_mean(s : TimeseriesforecastthetaTable) -> Double { @_common.mean(s.data) }

pub fn timeseries_forecast_theta_table_scale(s : TimeseriesforecastthetaTable, f : Double) -> TimeseriesforecastthetaTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_theta_table_add(a : TimeseriesforecastthetaTable, b : TimeseriesforecastthetaTable) -> TimeseriesforecastthetaTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_forecast_theta_table_copy(s : TimeseriesforecastthetaTable) -> TimeseriesforecastthetaTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_theta_table_fill(s : TimeseriesforecastthetaTable, v : Double) -> TimeseriesforecastthetaTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_theta_table_min(s : TimeseriesforecastthetaTable) -> Double { @_common.min(s.data) }

pub fn timeseries_forecast_theta_table_max(s : TimeseriesforecastthetaTable) -> Double { @_common.max(s.data) }

pub fn timeseries_forecast_theta_table_to_string(s : TimeseriesforecastthetaTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesforecastthetaGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_forecast_theta_graphn_make(size : Int) -> TimeseriesforecastthetaGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_forecast_theta_graphn_len(s : TimeseriesforecastthetaGraphN) -> Int { s.size }

pub fn timeseries_forecast_theta_graphn_get(s : TimeseriesforecastthetaGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_forecast_theta_graphn_set(s : TimeseriesforecastthetaGraphN, i : Int, v : Double) -> TimeseriesforecastthetaGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_theta_graphn_sum(s : TimeseriesforecastthetaGraphN) -> Double { @_common.sum(s.data) }

pub fn timeseries_forecast_theta_graphn_mean(s : TimeseriesforecastthetaGraphN) -> Double { @_common.mean(s.data) }

pub fn timeseries_forecast_theta_graphn_scale(s : TimeseriesforecastthetaGraphN, f : Double) -> TimeseriesforecastthetaGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_theta_graphn_add(a : TimeseriesforecastthetaGraphN, b : TimeseriesforecastthetaGraphN) -> TimeseriesforecastthetaGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_forecast_theta_graphn_copy(s : TimeseriesforecastthetaGraphN) -> TimeseriesforecastthetaGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_theta_graphn_fill(s : TimeseriesforecastthetaGraphN, v : Double) -> TimeseriesforecastthetaGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_theta_graphn_min(s : TimeseriesforecastthetaGraphN) -> Double { @_common.min(s.data) }

pub fn timeseries_forecast_theta_graphn_max(s : TimeseriesforecastthetaGraphN) -> Double { @_common.max(s.data) }

pub fn timeseries_forecast_theta_graphn_to_string(s : TimeseriesforecastthetaGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesforecastthetaNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_forecast_theta_node_make(size : Int) -> TimeseriesforecastthetaNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_forecast_theta_node_len(s : TimeseriesforecastthetaNode) -> Int { s.size }

pub fn timeseries_forecast_theta_node_get(s : TimeseriesforecastthetaNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_forecast_theta_node_set(s : TimeseriesforecastthetaNode, i : Int, v : Double) -> TimeseriesforecastthetaNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_theta_node_sum(s : TimeseriesforecastthetaNode) -> Double { @_common.sum(s.data) }

pub fn timeseries_forecast_theta_node_mean(s : TimeseriesforecastthetaNode) -> Double { @_common.mean(s.data) }

pub fn timeseries_forecast_theta_node_scale(s : TimeseriesforecastthetaNode, f : Double) -> TimeseriesforecastthetaNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_theta_node_add(a : TimeseriesforecastthetaNode, b : TimeseriesforecastthetaNode) -> TimeseriesforecastthetaNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_forecast_theta_node_copy(s : TimeseriesforecastthetaNode) -> TimeseriesforecastthetaNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_theta_node_fill(s : TimeseriesforecastthetaNode, v : Double) -> TimeseriesforecastthetaNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_theta_node_min(s : TimeseriesforecastthetaNode) -> Double { @_common.min(s.data) }

pub fn timeseries_forecast_theta_node_max(s : TimeseriesforecastthetaNode) -> Double { @_common.max(s.data) }

pub fn timeseries_forecast_theta_node_to_string(s : TimeseriesforecastthetaNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesforecastthetaEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_forecast_theta_edge_make(size : Int) -> TimeseriesforecastthetaEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_forecast_theta_edge_len(s : TimeseriesforecastthetaEdge) -> Int { s.size }

pub fn timeseries_forecast_theta_edge_get(s : TimeseriesforecastthetaEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_forecast_theta_edge_set(s : TimeseriesforecastthetaEdge, i : Int, v : Double) -> TimeseriesforecastthetaEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_theta_edge_sum(s : TimeseriesforecastthetaEdge) -> Double { @_common.sum(s.data) }

pub fn timeseries_forecast_theta_edge_mean(s : TimeseriesforecastthetaEdge) -> Double { @_common.mean(s.data) }

pub fn timeseries_forecast_theta_edge_scale(s : TimeseriesforecastthetaEdge, f : Double) -> TimeseriesforecastthetaEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_theta_edge_add(a : TimeseriesforecastthetaEdge, b : TimeseriesforecastthetaEdge) -> TimeseriesforecastthetaEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_forecast_theta_edge_copy(s : TimeseriesforecastthetaEdge) -> TimeseriesforecastthetaEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_theta_edge_fill(s : TimeseriesforecastthetaEdge, v : Double) -> TimeseriesforecastthetaEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_theta_edge_min(s : TimeseriesforecastthetaEdge) -> Double { @_common.min(s.data) }

pub fn timeseries_forecast_theta_edge_max(s : TimeseriesforecastthetaEdge) -> Double { @_common.max(s.data) }

pub fn timeseries_forecast_theta_edge_to_string(s : TimeseriesforecastthetaEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesforecastthetaPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_forecast_theta_path_make(size : Int) -> TimeseriesforecastthetaPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_forecast_theta_path_len(s : TimeseriesforecastthetaPath) -> Int { s.size }

pub fn timeseries_forecast_theta_path_get(s : TimeseriesforecastthetaPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_forecast_theta_path_set(s : TimeseriesforecastthetaPath, i : Int, v : Double) -> TimeseriesforecastthetaPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_theta_path_sum(s : TimeseriesforecastthetaPath) -> Double { @_common.sum(s.data) }

pub fn timeseries_forecast_theta_path_mean(s : TimeseriesforecastthetaPath) -> Double { @_common.mean(s.data) }

pub fn timeseries_forecast_theta_path_scale(s : TimeseriesforecastthetaPath, f : Double) -> TimeseriesforecastthetaPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_theta_path_add(a : TimeseriesforecastthetaPath, b : TimeseriesforecastthetaPath) -> TimeseriesforecastthetaPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_forecast_theta_path_copy(s : TimeseriesforecastthetaPath) -> TimeseriesforecastthetaPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_theta_path_fill(s : TimeseriesforecastthetaPath, v : Double) -> TimeseriesforecastthetaPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_theta_path_min(s : TimeseriesforecastthetaPath) -> Double { @_common.min(s.data) }

pub fn timeseries_forecast_theta_path_max(s : TimeseriesforecastthetaPath) -> Double { @_common.max(s.data) }

pub fn timeseries_forecast_theta_path_to_string(s : TimeseriesforecastthetaPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesforecastthetaCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_forecast_theta_cluster_make(size : Int) -> TimeseriesforecastthetaCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_forecast_theta_cluster_len(s : TimeseriesforecastthetaCluster) -> Int { s.size }

pub fn timeseries_forecast_theta_cluster_get(s : TimeseriesforecastthetaCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_forecast_theta_cluster_set(s : TimeseriesforecastthetaCluster, i : Int, v : Double) -> TimeseriesforecastthetaCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_theta_cluster_sum(s : TimeseriesforecastthetaCluster) -> Double { @_common.sum(s.data) }

pub fn timeseries_forecast_theta_cluster_mean(s : TimeseriesforecastthetaCluster) -> Double { @_common.mean(s.data) }

pub fn timeseries_forecast_theta_cluster_scale(s : TimeseriesforecastthetaCluster, f : Double) -> TimeseriesforecastthetaCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_theta_cluster_add(a : TimeseriesforecastthetaCluster, b : TimeseriesforecastthetaCluster) -> TimeseriesforecastthetaCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_forecast_theta_cluster_copy(s : TimeseriesforecastthetaCluster) -> TimeseriesforecastthetaCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_theta_cluster_fill(s : TimeseriesforecastthetaCluster, v : Double) -> TimeseriesforecastthetaCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_theta_cluster_min(s : TimeseriesforecastthetaCluster) -> Double { @_common.min(s.data) }

pub fn timeseries_forecast_theta_cluster_max(s : TimeseriesforecastthetaCluster) -> Double { @_common.max(s.data) }

pub fn timeseries_forecast_theta_cluster_to_string(s : TimeseriesforecastthetaCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesforecastthetaModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_forecast_theta_model_make(size : Int) -> TimeseriesforecastthetaModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_forecast_theta_model_len(s : TimeseriesforecastthetaModel) -> Int { s.size }

pub fn timeseries_forecast_theta_model_get(s : TimeseriesforecastthetaModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_forecast_theta_model_set(s : TimeseriesforecastthetaModel, i : Int, v : Double) -> TimeseriesforecastthetaModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_theta_model_sum(s : TimeseriesforecastthetaModel) -> Double { @_common.sum(s.data) }

pub fn timeseries_forecast_theta_model_mean(s : TimeseriesforecastthetaModel) -> Double { @_common.mean(s.data) }

pub fn timeseries_forecast_theta_model_scale(s : TimeseriesforecastthetaModel, f : Double) -> TimeseriesforecastthetaModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_theta_model_add(a : TimeseriesforecastthetaModel, b : TimeseriesforecastthetaModel) -> TimeseriesforecastthetaModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_forecast_theta_model_copy(s : TimeseriesforecastthetaModel) -> TimeseriesforecastthetaModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_theta_model_fill(s : TimeseriesforecastthetaModel, v : Double) -> TimeseriesforecastthetaModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_theta_model_min(s : TimeseriesforecastthetaModel) -> Double { @_common.min(s.data) }

pub fn timeseries_forecast_theta_model_max(s : TimeseriesforecastthetaModel) -> Double { @_common.max(s.data) }

pub fn timeseries_forecast_theta_model_to_string(s : TimeseriesforecastthetaModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesforecastthetaLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_forecast_theta_layer_make(size : Int) -> TimeseriesforecastthetaLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_forecast_theta_layer_len(s : TimeseriesforecastthetaLayer) -> Int { s.size }

pub fn timeseries_forecast_theta_layer_get(s : TimeseriesforecastthetaLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_forecast_theta_layer_set(s : TimeseriesforecastthetaLayer, i : Int, v : Double) -> TimeseriesforecastthetaLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_theta_layer_sum(s : TimeseriesforecastthetaLayer) -> Double { @_common.sum(s.data) }

pub fn timeseries_forecast_theta_layer_mean(s : TimeseriesforecastthetaLayer) -> Double { @_common.mean(s.data) }

pub fn timeseries_forecast_theta_layer_scale(s : TimeseriesforecastthetaLayer, f : Double) -> TimeseriesforecastthetaLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_theta_layer_add(a : TimeseriesforecastthetaLayer, b : TimeseriesforecastthetaLayer) -> TimeseriesforecastthetaLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_forecast_theta_layer_copy(s : TimeseriesforecastthetaLayer) -> TimeseriesforecastthetaLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_theta_layer_fill(s : TimeseriesforecastthetaLayer, v : Double) -> TimeseriesforecastthetaLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_theta_layer_min(s : TimeseriesforecastthetaLayer) -> Double { @_common.min(s.data) }

pub fn timeseries_forecast_theta_layer_max(s : TimeseriesforecastthetaLayer) -> Double { @_common.max(s.data) }

pub fn timeseries_forecast_theta_layer_to_string(s : TimeseriesforecastthetaLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesforecastthetaBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_forecast_theta_buffer_make(size : Int) -> TimeseriesforecastthetaBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_forecast_theta_buffer_len(s : TimeseriesforecastthetaBuffer) -> Int { s.size }

pub fn timeseries_forecast_theta_buffer_get(s : TimeseriesforecastthetaBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_forecast_theta_buffer_set(s : TimeseriesforecastthetaBuffer, i : Int, v : Double) -> TimeseriesforecastthetaBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_theta_buffer_sum(s : TimeseriesforecastthetaBuffer) -> Double { @_common.sum(s.data) }

pub fn timeseries_forecast_theta_buffer_mean(s : TimeseriesforecastthetaBuffer) -> Double { @_common.mean(s.data) }

pub fn timeseries_forecast_theta_buffer_scale(s : TimeseriesforecastthetaBuffer, f : Double) -> TimeseriesforecastthetaBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_theta_buffer_add(a : TimeseriesforecastthetaBuffer, b : TimeseriesforecastthetaBuffer) -> TimeseriesforecastthetaBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_forecast_theta_buffer_copy(s : TimeseriesforecastthetaBuffer) -> TimeseriesforecastthetaBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_theta_buffer_fill(s : TimeseriesforecastthetaBuffer, v : Double) -> TimeseriesforecastthetaBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_theta_buffer_min(s : TimeseriesforecastthetaBuffer) -> Double { @_common.min(s.data) }

pub fn timeseries_forecast_theta_buffer_max(s : TimeseriesforecastthetaBuffer) -> Double { @_common.max(s.data) }

pub fn timeseries_forecast_theta_buffer_to_string(s : TimeseriesforecastthetaBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesforecastthetaCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_forecast_theta_cursor_make(size : Int) -> TimeseriesforecastthetaCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_forecast_theta_cursor_len(s : TimeseriesforecastthetaCursor) -> Int { s.size }

pub fn timeseries_forecast_theta_cursor_get(s : TimeseriesforecastthetaCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_forecast_theta_cursor_set(s : TimeseriesforecastthetaCursor, i : Int, v : Double) -> TimeseriesforecastthetaCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_theta_cursor_sum(s : TimeseriesforecastthetaCursor) -> Double { @_common.sum(s.data) }

pub fn timeseries_forecast_theta_cursor_mean(s : TimeseriesforecastthetaCursor) -> Double { @_common.mean(s.data) }

pub fn timeseries_forecast_theta_cursor_scale(s : TimeseriesforecastthetaCursor, f : Double) -> TimeseriesforecastthetaCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_theta_cursor_add(a : TimeseriesforecastthetaCursor, b : TimeseriesforecastthetaCursor) -> TimeseriesforecastthetaCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_forecast_theta_cursor_copy(s : TimeseriesforecastthetaCursor) -> TimeseriesforecastthetaCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_theta_cursor_fill(s : TimeseriesforecastthetaCursor, v : Double) -> TimeseriesforecastthetaCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_theta_cursor_min(s : TimeseriesforecastthetaCursor) -> Double { @_common.min(s.data) }

pub fn timeseries_forecast_theta_cursor_max(s : TimeseriesforecastthetaCursor) -> Double { @_common.max(s.data) }

pub fn timeseries_forecast_theta_cursor_to_string(s : TimeseriesforecastthetaCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesforecastthetaView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_forecast_theta_view_make(size : Int) -> TimeseriesforecastthetaView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_forecast_theta_view_len(s : TimeseriesforecastthetaView) -> Int { s.size }

pub fn timeseries_forecast_theta_view_get(s : TimeseriesforecastthetaView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_forecast_theta_view_set(s : TimeseriesforecastthetaView, i : Int, v : Double) -> TimeseriesforecastthetaView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_theta_view_sum(s : TimeseriesforecastthetaView) -> Double { @_common.sum(s.data) }

pub fn timeseries_forecast_theta_view_mean(s : TimeseriesforecastthetaView) -> Double { @_common.mean(s.data) }

pub fn timeseries_forecast_theta_view_scale(s : TimeseriesforecastthetaView, f : Double) -> TimeseriesforecastthetaView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_theta_view_add(a : TimeseriesforecastthetaView, b : TimeseriesforecastthetaView) -> TimeseriesforecastthetaView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_forecast_theta_view_copy(s : TimeseriesforecastthetaView) -> TimeseriesforecastthetaView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_theta_view_fill(s : TimeseriesforecastthetaView, v : Double) -> TimeseriesforecastthetaView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_theta_view_min(s : TimeseriesforecastthetaView) -> Double { @_common.min(s.data) }

pub fn timeseries_forecast_theta_view_max(s : TimeseriesforecastthetaView) -> Double { @_common.max(s.data) }

pub fn timeseries_forecast_theta_view_to_string(s : TimeseriesforecastthetaView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesforecastthetaRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_forecast_theta_range_make(size : Int) -> TimeseriesforecastthetaRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_forecast_theta_range_len(s : TimeseriesforecastthetaRange) -> Int { s.size }

pub fn timeseries_forecast_theta_range_get(s : TimeseriesforecastthetaRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_forecast_theta_range_set(s : TimeseriesforecastthetaRange, i : Int, v : Double) -> TimeseriesforecastthetaRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_theta_range_sum(s : TimeseriesforecastthetaRange) -> Double { @_common.sum(s.data) }

pub fn timeseries_forecast_theta_range_mean(s : TimeseriesforecastthetaRange) -> Double { @_common.mean(s.data) }

pub fn timeseries_forecast_theta_range_scale(s : TimeseriesforecastthetaRange, f : Double) -> TimeseriesforecastthetaRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_theta_range_add(a : TimeseriesforecastthetaRange, b : TimeseriesforecastthetaRange) -> TimeseriesforecastthetaRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_forecast_theta_range_copy(s : TimeseriesforecastthetaRange) -> TimeseriesforecastthetaRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_theta_range_fill(s : TimeseriesforecastthetaRange, v : Double) -> TimeseriesforecastthetaRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_theta_range_min(s : TimeseriesforecastthetaRange) -> Double { @_common.min(s.data) }

pub fn timeseries_forecast_theta_range_max(s : TimeseriesforecastthetaRange) -> Double { @_common.max(s.data) }

pub fn timeseries_forecast_theta_range_to_string(s : TimeseriesforecastthetaRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesforecastthetaSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_forecast_theta_slice_make(size : Int) -> TimeseriesforecastthetaSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_forecast_theta_slice_len(s : TimeseriesforecastthetaSlice) -> Int { s.size }

pub fn timeseries_forecast_theta_slice_get(s : TimeseriesforecastthetaSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_forecast_theta_slice_set(s : TimeseriesforecastthetaSlice, i : Int, v : Double) -> TimeseriesforecastthetaSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_theta_slice_sum(s : TimeseriesforecastthetaSlice) -> Double { @_common.sum(s.data) }

pub fn timeseries_forecast_theta_slice_mean(s : TimeseriesforecastthetaSlice) -> Double { @_common.mean(s.data) }

pub fn timeseries_forecast_theta_slice_scale(s : TimeseriesforecastthetaSlice, f : Double) -> TimeseriesforecastthetaSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_theta_slice_add(a : TimeseriesforecastthetaSlice, b : TimeseriesforecastthetaSlice) -> TimeseriesforecastthetaSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_forecast_theta_slice_copy(s : TimeseriesforecastthetaSlice) -> TimeseriesforecastthetaSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_theta_slice_fill(s : TimeseriesforecastthetaSlice, v : Double) -> TimeseriesforecastthetaSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_theta_slice_min(s : TimeseriesforecastthetaSlice) -> Double { @_common.min(s.data) }

pub fn timeseries_forecast_theta_slice_max(s : TimeseriesforecastthetaSlice) -> Double { @_common.max(s.data) }

pub fn timeseries_forecast_theta_slice_to_string(s : TimeseriesforecastthetaSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

