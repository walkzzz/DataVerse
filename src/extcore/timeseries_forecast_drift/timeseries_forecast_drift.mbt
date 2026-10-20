///===
/// extcore/timeseries_forecast_drift

pub(all) struct TimeseriesforecastdriftPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn timeseries_forecast_drift_make_point(x : Double, y : Double) -> TimeseriesforecastdriftPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn timeseries_forecast_drift_make_point3(x : Double, y : Double, z : Double) -> TimeseriesforecastdriftPoint {
  { x, y, z, label: 0 }
}

pub fn TimeseriesforecastdriftPoint::x(self : TimeseriesforecastdriftPoint) -> Double { self.x }

pub fn TimeseriesforecastdriftPoint::y(self : TimeseriesforecastdriftPoint) -> Double { self.y }

pub fn TimeseriesforecastdriftPoint::z(self : TimeseriesforecastdriftPoint) -> Double { self.z }

pub fn TimeseriesforecastdriftPoint::label(self : TimeseriesforecastdriftPoint) -> Int { self.label }

pub fn TimeseriesforecastdriftPoint::dist(self : TimeseriesforecastdriftPoint, other : TimeseriesforecastdriftPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn TimeseriesforecastdriftPoint::add(self : TimeseriesforecastdriftPoint, other : TimeseriesforecastdriftPoint) -> TimeseriesforecastdriftPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn TimeseriesforecastdriftPoint::sub(self : TimeseriesforecastdriftPoint, other : TimeseriesforecastdriftPoint) -> TimeseriesforecastdriftPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn TimeseriesforecastdriftPoint::scale(self : TimeseriesforecastdriftPoint, s : Double) -> TimeseriesforecastdriftPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn TimeseriesforecastdriftPoint::dot(self : TimeseriesforecastdriftPoint, other : TimeseriesforecastdriftPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn TimeseriesforecastdriftPoint::cross(self : TimeseriesforecastdriftPoint, other : TimeseriesforecastdriftPoint) -> TimeseriesforecastdriftPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn TimeseriesforecastdriftPoint::norm(self : TimeseriesforecastdriftPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn TimeseriesforecastdriftPoint::normalize(self : TimeseriesforecastdriftPoint) -> TimeseriesforecastdriftPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn TimeseriesforecastdriftPoint::negate(self : TimeseriesforecastdriftPoint) -> TimeseriesforecastdriftPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn TimeseriesforecastdriftPoint::mid(self : TimeseriesforecastdriftPoint, other : TimeseriesforecastdriftPoint) -> TimeseriesforecastdriftPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn TimeseriesforecastdriftPoint::lerp(self : TimeseriesforecastdriftPoint, other : TimeseriesforecastdriftPoint, t : Double) -> TimeseriesforecastdriftPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn TimeseriesforecastdriftPoint::to_string(self : TimeseriesforecastdriftPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct TimeseriesforecastdriftSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn timeseries_forecast_drift_make_series(vals : Array[Double], name : String) -> TimeseriesforecastdriftSeries {
  { vals, name, meta: 0 }
}

pub fn TimeseriesforecastdriftSeries::len(self : TimeseriesforecastdriftSeries) -> Int { self.vals.length() }

pub fn TimeseriesforecastdriftSeries::sum(self : TimeseriesforecastdriftSeries) -> Double { @_common.sum(self.vals) }

pub fn TimeseriesforecastdriftSeries::mean(self : TimeseriesforecastdriftSeries) -> Double { @_common.mean(self.vals) }

pub fn TimeseriesforecastdriftSeries::min(self : TimeseriesforecastdriftSeries) -> Double { @_common.min(self.vals) }

pub fn TimeseriesforecastdriftSeries::max(self : TimeseriesforecastdriftSeries) -> Double { @_common.max(self.vals) }

pub fn TimeseriesforecastdriftSeries::range(self : TimeseriesforecastdriftSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn TimeseriesforecastdriftSeries::variance(self : TimeseriesforecastdriftSeries) -> Double { @_common.variance(self.vals) }

pub fn TimeseriesforecastdriftSeries::std(self : TimeseriesforecastdriftSeries) -> Double { @_common.std(self.vals) }

pub fn TimeseriesforecastdriftSeries::median(self : TimeseriesforecastdriftSeries) -> Double { @_common.median(self.vals) }

pub fn TimeseriesforecastdriftSeries::scale(self : TimeseriesforecastdriftSeries, f : Double) -> TimeseriesforecastdriftSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn TimeseriesforecastdriftSeries::add(self : TimeseriesforecastdriftSeries, other : TimeseriesforecastdriftSeries) -> TimeseriesforecastdriftSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn TimeseriesforecastdriftSeries::sub(self : TimeseriesforecastdriftSeries, other : TimeseriesforecastdriftSeries) -> TimeseriesforecastdriftSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn TimeseriesforecastdriftSeries::normalize(self : TimeseriesforecastdriftSeries) -> TimeseriesforecastdriftSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn TimeseriesforecastdriftSeries::cumsum(self : TimeseriesforecastdriftSeries) -> TimeseriesforecastdriftSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn TimeseriesforecastdriftSeries::to_string(self : TimeseriesforecastdriftSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct TimeseriesforecastdriftMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn timeseries_forecast_drift_make_matrix(rows : Int, cols : Int, val : Double) -> TimeseriesforecastdriftMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn timeseries_forecast_drift_matrix_identity(n : Int) -> TimeseriesforecastdriftMatrix {
  let m = timeseries_forecast_drift_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn TimeseriesforecastdriftMatrix::get(self : TimeseriesforecastdriftMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn TimeseriesforecastdriftMatrix::transpose(self : TimeseriesforecastdriftMatrix) -> TimeseriesforecastdriftMatrix {
  let result = timeseries_forecast_drift_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn TimeseriesforecastdriftMatrix::add(self : TimeseriesforecastdriftMatrix, other : TimeseriesforecastdriftMatrix) -> TimeseriesforecastdriftMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = timeseries_forecast_drift_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn TimeseriesforecastdriftMatrix::scale(self : TimeseriesforecastdriftMatrix, s : Double) -> TimeseriesforecastdriftMatrix {
  let result = timeseries_forecast_drift_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn TimeseriesforecastdriftMatrix::multiply(self : TimeseriesforecastdriftMatrix, other : TimeseriesforecastdriftMatrix) -> TimeseriesforecastdriftMatrix {
  if self.cols != other.rows { return timeseries_forecast_drift_make_matrix(self.rows, other.cols, 0.0) }
  let result = timeseries_forecast_drift_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn TimeseriesforecastdriftMatrix::trace(self : TimeseriesforecastdriftMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn TimeseriesforecastdriftMatrix::det(self : TimeseriesforecastdriftMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn TimeseriesforecastdriftMatrix::norm(self : TimeseriesforecastdriftMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn TimeseriesforecastdriftMatrix::to_string(self : TimeseriesforecastdriftMatrix) -> String {
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

pub(all) struct TimeseriesforecastdriftVector {
  comps : Array[Double]
  dim : Int
}

pub fn timeseries_forecast_drift_make_vector(comps : Array[Double]) -> TimeseriesforecastdriftVector {
  { comps, dim: comps.length() }
}

pub fn timeseries_forecast_drift_vector_zero(dim : Int) -> TimeseriesforecastdriftVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn TimeseriesforecastdriftVector::add(self : TimeseriesforecastdriftVector, other : TimeseriesforecastdriftVector) -> TimeseriesforecastdriftVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn TimeseriesforecastdriftVector::sub(self : TimeseriesforecastdriftVector, other : TimeseriesforecastdriftVector) -> TimeseriesforecastdriftVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn TimeseriesforecastdriftVector::scale(self : TimeseriesforecastdriftVector, s : Double) -> TimeseriesforecastdriftVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn TimeseriesforecastdriftVector::dot(self : TimeseriesforecastdriftVector, other : TimeseriesforecastdriftVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn TimeseriesforecastdriftVector::norm(self : TimeseriesforecastdriftVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn TimeseriesforecastdriftVector::normalize(self : TimeseriesforecastdriftVector) -> TimeseriesforecastdriftVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn TimeseriesforecastdriftVector::dist(self : TimeseriesforecastdriftVector, other : TimeseriesforecastdriftVector) -> Double {
  self.sub(other).norm()
}

pub fn TimeseriesforecastdriftVector::to_string(self : TimeseriesforecastdriftVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn timeseries_forecast_drift_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn timeseries_forecast_drift_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn timeseries_forecast_drift_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn timeseries_forecast_drift_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn timeseries_forecast_drift_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn timeseries_forecast_drift_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn timeseries_forecast_drift_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn timeseries_forecast_drift_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn timeseries_forecast_drift_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn timeseries_forecast_drift_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn timeseries_forecast_drift_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn timeseries_forecast_drift_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn timeseries_forecast_drift_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn timeseries_forecast_drift_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn timeseries_forecast_drift_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn timeseries_forecast_drift_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn timeseries_forecast_drift_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn timeseries_forecast_drift_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn timeseries_forecast_drift_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn timeseries_forecast_drift_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn timeseries_forecast_drift_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn timeseries_forecast_drift_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn timeseries_forecast_drift_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn timeseries_forecast_drift_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn timeseries_forecast_drift_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn timeseries_forecast_drift_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn timeseries_forecast_drift_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn timeseries_forecast_drift_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn timeseries_forecast_drift_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct TimeseriesforecastdriftFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_forecast_drift_frame_make(size : Int) -> TimeseriesforecastdriftFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_forecast_drift_frame_len(s : TimeseriesforecastdriftFrame) -> Int { s.size }

pub fn timeseries_forecast_drift_frame_get(s : TimeseriesforecastdriftFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_forecast_drift_frame_set(s : TimeseriesforecastdriftFrame, i : Int, v : Double) -> TimeseriesforecastdriftFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_drift_frame_sum(s : TimeseriesforecastdriftFrame) -> Double { @_common.sum(s.data) }

pub fn timeseries_forecast_drift_frame_mean(s : TimeseriesforecastdriftFrame) -> Double { @_common.mean(s.data) }

pub fn timeseries_forecast_drift_frame_scale(s : TimeseriesforecastdriftFrame, f : Double) -> TimeseriesforecastdriftFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_drift_frame_add(a : TimeseriesforecastdriftFrame, b : TimeseriesforecastdriftFrame) -> TimeseriesforecastdriftFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_forecast_drift_frame_copy(s : TimeseriesforecastdriftFrame) -> TimeseriesforecastdriftFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_drift_frame_fill(s : TimeseriesforecastdriftFrame, v : Double) -> TimeseriesforecastdriftFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_drift_frame_min(s : TimeseriesforecastdriftFrame) -> Double { @_common.min(s.data) }

pub fn timeseries_forecast_drift_frame_max(s : TimeseriesforecastdriftFrame) -> Double { @_common.max(s.data) }

pub fn timeseries_forecast_drift_frame_to_string(s : TimeseriesforecastdriftFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesforecastdriftTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_forecast_drift_table_make(size : Int) -> TimeseriesforecastdriftTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_forecast_drift_table_len(s : TimeseriesforecastdriftTable) -> Int { s.size }

pub fn timeseries_forecast_drift_table_get(s : TimeseriesforecastdriftTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_forecast_drift_table_set(s : TimeseriesforecastdriftTable, i : Int, v : Double) -> TimeseriesforecastdriftTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_drift_table_sum(s : TimeseriesforecastdriftTable) -> Double { @_common.sum(s.data) }

pub fn timeseries_forecast_drift_table_mean(s : TimeseriesforecastdriftTable) -> Double { @_common.mean(s.data) }

pub fn timeseries_forecast_drift_table_scale(s : TimeseriesforecastdriftTable, f : Double) -> TimeseriesforecastdriftTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_drift_table_add(a : TimeseriesforecastdriftTable, b : TimeseriesforecastdriftTable) -> TimeseriesforecastdriftTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_forecast_drift_table_copy(s : TimeseriesforecastdriftTable) -> TimeseriesforecastdriftTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_drift_table_fill(s : TimeseriesforecastdriftTable, v : Double) -> TimeseriesforecastdriftTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_drift_table_min(s : TimeseriesforecastdriftTable) -> Double { @_common.min(s.data) }

pub fn timeseries_forecast_drift_table_max(s : TimeseriesforecastdriftTable) -> Double { @_common.max(s.data) }

pub fn timeseries_forecast_drift_table_to_string(s : TimeseriesforecastdriftTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesforecastdriftGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_forecast_drift_graphn_make(size : Int) -> TimeseriesforecastdriftGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_forecast_drift_graphn_len(s : TimeseriesforecastdriftGraphN) -> Int { s.size }

pub fn timeseries_forecast_drift_graphn_get(s : TimeseriesforecastdriftGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_forecast_drift_graphn_set(s : TimeseriesforecastdriftGraphN, i : Int, v : Double) -> TimeseriesforecastdriftGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_drift_graphn_sum(s : TimeseriesforecastdriftGraphN) -> Double { @_common.sum(s.data) }

pub fn timeseries_forecast_drift_graphn_mean(s : TimeseriesforecastdriftGraphN) -> Double { @_common.mean(s.data) }

pub fn timeseries_forecast_drift_graphn_scale(s : TimeseriesforecastdriftGraphN, f : Double) -> TimeseriesforecastdriftGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_drift_graphn_add(a : TimeseriesforecastdriftGraphN, b : TimeseriesforecastdriftGraphN) -> TimeseriesforecastdriftGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_forecast_drift_graphn_copy(s : TimeseriesforecastdriftGraphN) -> TimeseriesforecastdriftGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_drift_graphn_fill(s : TimeseriesforecastdriftGraphN, v : Double) -> TimeseriesforecastdriftGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_drift_graphn_min(s : TimeseriesforecastdriftGraphN) -> Double { @_common.min(s.data) }

pub fn timeseries_forecast_drift_graphn_max(s : TimeseriesforecastdriftGraphN) -> Double { @_common.max(s.data) }

pub fn timeseries_forecast_drift_graphn_to_string(s : TimeseriesforecastdriftGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesforecastdriftNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_forecast_drift_node_make(size : Int) -> TimeseriesforecastdriftNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_forecast_drift_node_len(s : TimeseriesforecastdriftNode) -> Int { s.size }

pub fn timeseries_forecast_drift_node_get(s : TimeseriesforecastdriftNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_forecast_drift_node_set(s : TimeseriesforecastdriftNode, i : Int, v : Double) -> TimeseriesforecastdriftNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_drift_node_sum(s : TimeseriesforecastdriftNode) -> Double { @_common.sum(s.data) }

pub fn timeseries_forecast_drift_node_mean(s : TimeseriesforecastdriftNode) -> Double { @_common.mean(s.data) }

pub fn timeseries_forecast_drift_node_scale(s : TimeseriesforecastdriftNode, f : Double) -> TimeseriesforecastdriftNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_drift_node_add(a : TimeseriesforecastdriftNode, b : TimeseriesforecastdriftNode) -> TimeseriesforecastdriftNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_forecast_drift_node_copy(s : TimeseriesforecastdriftNode) -> TimeseriesforecastdriftNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_drift_node_fill(s : TimeseriesforecastdriftNode, v : Double) -> TimeseriesforecastdriftNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_drift_node_min(s : TimeseriesforecastdriftNode) -> Double { @_common.min(s.data) }

pub fn timeseries_forecast_drift_node_max(s : TimeseriesforecastdriftNode) -> Double { @_common.max(s.data) }

pub fn timeseries_forecast_drift_node_to_string(s : TimeseriesforecastdriftNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesforecastdriftEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_forecast_drift_edge_make(size : Int) -> TimeseriesforecastdriftEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_forecast_drift_edge_len(s : TimeseriesforecastdriftEdge) -> Int { s.size }

pub fn timeseries_forecast_drift_edge_get(s : TimeseriesforecastdriftEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_forecast_drift_edge_set(s : TimeseriesforecastdriftEdge, i : Int, v : Double) -> TimeseriesforecastdriftEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_drift_edge_sum(s : TimeseriesforecastdriftEdge) -> Double { @_common.sum(s.data) }

pub fn timeseries_forecast_drift_edge_mean(s : TimeseriesforecastdriftEdge) -> Double { @_common.mean(s.data) }

pub fn timeseries_forecast_drift_edge_scale(s : TimeseriesforecastdriftEdge, f : Double) -> TimeseriesforecastdriftEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_drift_edge_add(a : TimeseriesforecastdriftEdge, b : TimeseriesforecastdriftEdge) -> TimeseriesforecastdriftEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_forecast_drift_edge_copy(s : TimeseriesforecastdriftEdge) -> TimeseriesforecastdriftEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_drift_edge_fill(s : TimeseriesforecastdriftEdge, v : Double) -> TimeseriesforecastdriftEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_drift_edge_min(s : TimeseriesforecastdriftEdge) -> Double { @_common.min(s.data) }

pub fn timeseries_forecast_drift_edge_max(s : TimeseriesforecastdriftEdge) -> Double { @_common.max(s.data) }

pub fn timeseries_forecast_drift_edge_to_string(s : TimeseriesforecastdriftEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesforecastdriftPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_forecast_drift_path_make(size : Int) -> TimeseriesforecastdriftPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_forecast_drift_path_len(s : TimeseriesforecastdriftPath) -> Int { s.size }

pub fn timeseries_forecast_drift_path_get(s : TimeseriesforecastdriftPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_forecast_drift_path_set(s : TimeseriesforecastdriftPath, i : Int, v : Double) -> TimeseriesforecastdriftPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_drift_path_sum(s : TimeseriesforecastdriftPath) -> Double { @_common.sum(s.data) }

pub fn timeseries_forecast_drift_path_mean(s : TimeseriesforecastdriftPath) -> Double { @_common.mean(s.data) }

pub fn timeseries_forecast_drift_path_scale(s : TimeseriesforecastdriftPath, f : Double) -> TimeseriesforecastdriftPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_drift_path_add(a : TimeseriesforecastdriftPath, b : TimeseriesforecastdriftPath) -> TimeseriesforecastdriftPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_forecast_drift_path_copy(s : TimeseriesforecastdriftPath) -> TimeseriesforecastdriftPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_drift_path_fill(s : TimeseriesforecastdriftPath, v : Double) -> TimeseriesforecastdriftPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_drift_path_min(s : TimeseriesforecastdriftPath) -> Double { @_common.min(s.data) }

pub fn timeseries_forecast_drift_path_max(s : TimeseriesforecastdriftPath) -> Double { @_common.max(s.data) }

pub fn timeseries_forecast_drift_path_to_string(s : TimeseriesforecastdriftPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesforecastdriftCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_forecast_drift_cluster_make(size : Int) -> TimeseriesforecastdriftCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_forecast_drift_cluster_len(s : TimeseriesforecastdriftCluster) -> Int { s.size }

pub fn timeseries_forecast_drift_cluster_get(s : TimeseriesforecastdriftCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_forecast_drift_cluster_set(s : TimeseriesforecastdriftCluster, i : Int, v : Double) -> TimeseriesforecastdriftCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_drift_cluster_sum(s : TimeseriesforecastdriftCluster) -> Double { @_common.sum(s.data) }

pub fn timeseries_forecast_drift_cluster_mean(s : TimeseriesforecastdriftCluster) -> Double { @_common.mean(s.data) }

pub fn timeseries_forecast_drift_cluster_scale(s : TimeseriesforecastdriftCluster, f : Double) -> TimeseriesforecastdriftCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_drift_cluster_add(a : TimeseriesforecastdriftCluster, b : TimeseriesforecastdriftCluster) -> TimeseriesforecastdriftCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_forecast_drift_cluster_copy(s : TimeseriesforecastdriftCluster) -> TimeseriesforecastdriftCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_drift_cluster_fill(s : TimeseriesforecastdriftCluster, v : Double) -> TimeseriesforecastdriftCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_drift_cluster_min(s : TimeseriesforecastdriftCluster) -> Double { @_common.min(s.data) }

pub fn timeseries_forecast_drift_cluster_max(s : TimeseriesforecastdriftCluster) -> Double { @_common.max(s.data) }

pub fn timeseries_forecast_drift_cluster_to_string(s : TimeseriesforecastdriftCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesforecastdriftModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_forecast_drift_model_make(size : Int) -> TimeseriesforecastdriftModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_forecast_drift_model_len(s : TimeseriesforecastdriftModel) -> Int { s.size }

pub fn timeseries_forecast_drift_model_get(s : TimeseriesforecastdriftModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_forecast_drift_model_set(s : TimeseriesforecastdriftModel, i : Int, v : Double) -> TimeseriesforecastdriftModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_drift_model_sum(s : TimeseriesforecastdriftModel) -> Double { @_common.sum(s.data) }

pub fn timeseries_forecast_drift_model_mean(s : TimeseriesforecastdriftModel) -> Double { @_common.mean(s.data) }

pub fn timeseries_forecast_drift_model_scale(s : TimeseriesforecastdriftModel, f : Double) -> TimeseriesforecastdriftModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_drift_model_add(a : TimeseriesforecastdriftModel, b : TimeseriesforecastdriftModel) -> TimeseriesforecastdriftModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_forecast_drift_model_copy(s : TimeseriesforecastdriftModel) -> TimeseriesforecastdriftModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_drift_model_fill(s : TimeseriesforecastdriftModel, v : Double) -> TimeseriesforecastdriftModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_drift_model_min(s : TimeseriesforecastdriftModel) -> Double { @_common.min(s.data) }

pub fn timeseries_forecast_drift_model_max(s : TimeseriesforecastdriftModel) -> Double { @_common.max(s.data) }

pub fn timeseries_forecast_drift_model_to_string(s : TimeseriesforecastdriftModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesforecastdriftLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_forecast_drift_layer_make(size : Int) -> TimeseriesforecastdriftLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_forecast_drift_layer_len(s : TimeseriesforecastdriftLayer) -> Int { s.size }

pub fn timeseries_forecast_drift_layer_get(s : TimeseriesforecastdriftLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_forecast_drift_layer_set(s : TimeseriesforecastdriftLayer, i : Int, v : Double) -> TimeseriesforecastdriftLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_drift_layer_sum(s : TimeseriesforecastdriftLayer) -> Double { @_common.sum(s.data) }

pub fn timeseries_forecast_drift_layer_mean(s : TimeseriesforecastdriftLayer) -> Double { @_common.mean(s.data) }

pub fn timeseries_forecast_drift_layer_scale(s : TimeseriesforecastdriftLayer, f : Double) -> TimeseriesforecastdriftLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_drift_layer_add(a : TimeseriesforecastdriftLayer, b : TimeseriesforecastdriftLayer) -> TimeseriesforecastdriftLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_forecast_drift_layer_copy(s : TimeseriesforecastdriftLayer) -> TimeseriesforecastdriftLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_drift_layer_fill(s : TimeseriesforecastdriftLayer, v : Double) -> TimeseriesforecastdriftLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_drift_layer_min(s : TimeseriesforecastdriftLayer) -> Double { @_common.min(s.data) }

pub fn timeseries_forecast_drift_layer_max(s : TimeseriesforecastdriftLayer) -> Double { @_common.max(s.data) }

pub fn timeseries_forecast_drift_layer_to_string(s : TimeseriesforecastdriftLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesforecastdriftBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_forecast_drift_buffer_make(size : Int) -> TimeseriesforecastdriftBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_forecast_drift_buffer_len(s : TimeseriesforecastdriftBuffer) -> Int { s.size }

pub fn timeseries_forecast_drift_buffer_get(s : TimeseriesforecastdriftBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_forecast_drift_buffer_set(s : TimeseriesforecastdriftBuffer, i : Int, v : Double) -> TimeseriesforecastdriftBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_drift_buffer_sum(s : TimeseriesforecastdriftBuffer) -> Double { @_common.sum(s.data) }

pub fn timeseries_forecast_drift_buffer_mean(s : TimeseriesforecastdriftBuffer) -> Double { @_common.mean(s.data) }

pub fn timeseries_forecast_drift_buffer_scale(s : TimeseriesforecastdriftBuffer, f : Double) -> TimeseriesforecastdriftBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_drift_buffer_add(a : TimeseriesforecastdriftBuffer, b : TimeseriesforecastdriftBuffer) -> TimeseriesforecastdriftBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_forecast_drift_buffer_copy(s : TimeseriesforecastdriftBuffer) -> TimeseriesforecastdriftBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_drift_buffer_fill(s : TimeseriesforecastdriftBuffer, v : Double) -> TimeseriesforecastdriftBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_drift_buffer_min(s : TimeseriesforecastdriftBuffer) -> Double { @_common.min(s.data) }

pub fn timeseries_forecast_drift_buffer_max(s : TimeseriesforecastdriftBuffer) -> Double { @_common.max(s.data) }

pub fn timeseries_forecast_drift_buffer_to_string(s : TimeseriesforecastdriftBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesforecastdriftCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_forecast_drift_cursor_make(size : Int) -> TimeseriesforecastdriftCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_forecast_drift_cursor_len(s : TimeseriesforecastdriftCursor) -> Int { s.size }

pub fn timeseries_forecast_drift_cursor_get(s : TimeseriesforecastdriftCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_forecast_drift_cursor_set(s : TimeseriesforecastdriftCursor, i : Int, v : Double) -> TimeseriesforecastdriftCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_drift_cursor_sum(s : TimeseriesforecastdriftCursor) -> Double { @_common.sum(s.data) }

pub fn timeseries_forecast_drift_cursor_mean(s : TimeseriesforecastdriftCursor) -> Double { @_common.mean(s.data) }

pub fn timeseries_forecast_drift_cursor_scale(s : TimeseriesforecastdriftCursor, f : Double) -> TimeseriesforecastdriftCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_drift_cursor_add(a : TimeseriesforecastdriftCursor, b : TimeseriesforecastdriftCursor) -> TimeseriesforecastdriftCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_forecast_drift_cursor_copy(s : TimeseriesforecastdriftCursor) -> TimeseriesforecastdriftCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_drift_cursor_fill(s : TimeseriesforecastdriftCursor, v : Double) -> TimeseriesforecastdriftCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_drift_cursor_min(s : TimeseriesforecastdriftCursor) -> Double { @_common.min(s.data) }

pub fn timeseries_forecast_drift_cursor_max(s : TimeseriesforecastdriftCursor) -> Double { @_common.max(s.data) }

pub fn timeseries_forecast_drift_cursor_to_string(s : TimeseriesforecastdriftCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesforecastdriftView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_forecast_drift_view_make(size : Int) -> TimeseriesforecastdriftView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_forecast_drift_view_len(s : TimeseriesforecastdriftView) -> Int { s.size }

pub fn timeseries_forecast_drift_view_get(s : TimeseriesforecastdriftView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_forecast_drift_view_set(s : TimeseriesforecastdriftView, i : Int, v : Double) -> TimeseriesforecastdriftView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_drift_view_sum(s : TimeseriesforecastdriftView) -> Double { @_common.sum(s.data) }

pub fn timeseries_forecast_drift_view_mean(s : TimeseriesforecastdriftView) -> Double { @_common.mean(s.data) }

pub fn timeseries_forecast_drift_view_scale(s : TimeseriesforecastdriftView, f : Double) -> TimeseriesforecastdriftView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_drift_view_add(a : TimeseriesforecastdriftView, b : TimeseriesforecastdriftView) -> TimeseriesforecastdriftView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_forecast_drift_view_copy(s : TimeseriesforecastdriftView) -> TimeseriesforecastdriftView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_drift_view_fill(s : TimeseriesforecastdriftView, v : Double) -> TimeseriesforecastdriftView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_drift_view_min(s : TimeseriesforecastdriftView) -> Double { @_common.min(s.data) }

pub fn timeseries_forecast_drift_view_max(s : TimeseriesforecastdriftView) -> Double { @_common.max(s.data) }

pub fn timeseries_forecast_drift_view_to_string(s : TimeseriesforecastdriftView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesforecastdriftRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_forecast_drift_range_make(size : Int) -> TimeseriesforecastdriftRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_forecast_drift_range_len(s : TimeseriesforecastdriftRange) -> Int { s.size }

pub fn timeseries_forecast_drift_range_get(s : TimeseriesforecastdriftRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_forecast_drift_range_set(s : TimeseriesforecastdriftRange, i : Int, v : Double) -> TimeseriesforecastdriftRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_drift_range_sum(s : TimeseriesforecastdriftRange) -> Double { @_common.sum(s.data) }

pub fn timeseries_forecast_drift_range_mean(s : TimeseriesforecastdriftRange) -> Double { @_common.mean(s.data) }

pub fn timeseries_forecast_drift_range_scale(s : TimeseriesforecastdriftRange, f : Double) -> TimeseriesforecastdriftRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_drift_range_add(a : TimeseriesforecastdriftRange, b : TimeseriesforecastdriftRange) -> TimeseriesforecastdriftRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_forecast_drift_range_copy(s : TimeseriesforecastdriftRange) -> TimeseriesforecastdriftRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_drift_range_fill(s : TimeseriesforecastdriftRange, v : Double) -> TimeseriesforecastdriftRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_drift_range_min(s : TimeseriesforecastdriftRange) -> Double { @_common.min(s.data) }

pub fn timeseries_forecast_drift_range_max(s : TimeseriesforecastdriftRange) -> Double { @_common.max(s.data) }

pub fn timeseries_forecast_drift_range_to_string(s : TimeseriesforecastdriftRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesforecastdriftSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_forecast_drift_slice_make(size : Int) -> TimeseriesforecastdriftSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_forecast_drift_slice_len(s : TimeseriesforecastdriftSlice) -> Int { s.size }

pub fn timeseries_forecast_drift_slice_get(s : TimeseriesforecastdriftSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_forecast_drift_slice_set(s : TimeseriesforecastdriftSlice, i : Int, v : Double) -> TimeseriesforecastdriftSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_drift_slice_sum(s : TimeseriesforecastdriftSlice) -> Double { @_common.sum(s.data) }

pub fn timeseries_forecast_drift_slice_mean(s : TimeseriesforecastdriftSlice) -> Double { @_common.mean(s.data) }

pub fn timeseries_forecast_drift_slice_scale(s : TimeseriesforecastdriftSlice, f : Double) -> TimeseriesforecastdriftSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_drift_slice_add(a : TimeseriesforecastdriftSlice, b : TimeseriesforecastdriftSlice) -> TimeseriesforecastdriftSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_forecast_drift_slice_copy(s : TimeseriesforecastdriftSlice) -> TimeseriesforecastdriftSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_drift_slice_fill(s : TimeseriesforecastdriftSlice, v : Double) -> TimeseriesforecastdriftSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_drift_slice_min(s : TimeseriesforecastdriftSlice) -> Double { @_common.min(s.data) }

pub fn timeseries_forecast_drift_slice_max(s : TimeseriesforecastdriftSlice) -> Double { @_common.max(s.data) }

pub fn timeseries_forecast_drift_slice_to_string(s : TimeseriesforecastdriftSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

