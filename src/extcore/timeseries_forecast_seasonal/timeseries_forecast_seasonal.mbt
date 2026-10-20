///===
/// extcore/timeseries_forecast_seasonal

pub(all) struct TimeseriesforecastseasonalPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn timeseries_forecast_seasonal_make_point(x : Double, y : Double) -> TimeseriesforecastseasonalPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn timeseries_forecast_seasonal_make_point3(x : Double, y : Double, z : Double) -> TimeseriesforecastseasonalPoint {
  { x, y, z, label: 0 }
}

pub fn TimeseriesforecastseasonalPoint::x(self : TimeseriesforecastseasonalPoint) -> Double { self.x }

pub fn TimeseriesforecastseasonalPoint::y(self : TimeseriesforecastseasonalPoint) -> Double { self.y }

pub fn TimeseriesforecastseasonalPoint::z(self : TimeseriesforecastseasonalPoint) -> Double { self.z }

pub fn TimeseriesforecastseasonalPoint::label(self : TimeseriesforecastseasonalPoint) -> Int { self.label }

pub fn TimeseriesforecastseasonalPoint::dist(self : TimeseriesforecastseasonalPoint, other : TimeseriesforecastseasonalPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn TimeseriesforecastseasonalPoint::add(self : TimeseriesforecastseasonalPoint, other : TimeseriesforecastseasonalPoint) -> TimeseriesforecastseasonalPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn TimeseriesforecastseasonalPoint::sub(self : TimeseriesforecastseasonalPoint, other : TimeseriesforecastseasonalPoint) -> TimeseriesforecastseasonalPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn TimeseriesforecastseasonalPoint::scale(self : TimeseriesforecastseasonalPoint, s : Double) -> TimeseriesforecastseasonalPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn TimeseriesforecastseasonalPoint::dot(self : TimeseriesforecastseasonalPoint, other : TimeseriesforecastseasonalPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn TimeseriesforecastseasonalPoint::cross(self : TimeseriesforecastseasonalPoint, other : TimeseriesforecastseasonalPoint) -> TimeseriesforecastseasonalPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn TimeseriesforecastseasonalPoint::norm(self : TimeseriesforecastseasonalPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn TimeseriesforecastseasonalPoint::normalize(self : TimeseriesforecastseasonalPoint) -> TimeseriesforecastseasonalPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn TimeseriesforecastseasonalPoint::negate(self : TimeseriesforecastseasonalPoint) -> TimeseriesforecastseasonalPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn TimeseriesforecastseasonalPoint::mid(self : TimeseriesforecastseasonalPoint, other : TimeseriesforecastseasonalPoint) -> TimeseriesforecastseasonalPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn TimeseriesforecastseasonalPoint::lerp(self : TimeseriesforecastseasonalPoint, other : TimeseriesforecastseasonalPoint, t : Double) -> TimeseriesforecastseasonalPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn TimeseriesforecastseasonalPoint::to_string(self : TimeseriesforecastseasonalPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct TimeseriesforecastseasonalSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn timeseries_forecast_seasonal_make_series(vals : Array[Double], name : String) -> TimeseriesforecastseasonalSeries {
  { vals, name, meta: 0 }
}

pub fn TimeseriesforecastseasonalSeries::len(self : TimeseriesforecastseasonalSeries) -> Int { self.vals.length() }

pub fn TimeseriesforecastseasonalSeries::sum(self : TimeseriesforecastseasonalSeries) -> Double { @_common.sum(self.vals) }

pub fn TimeseriesforecastseasonalSeries::mean(self : TimeseriesforecastseasonalSeries) -> Double { @_common.mean(self.vals) }

pub fn TimeseriesforecastseasonalSeries::min(self : TimeseriesforecastseasonalSeries) -> Double { @_common.min(self.vals) }

pub fn TimeseriesforecastseasonalSeries::max(self : TimeseriesforecastseasonalSeries) -> Double { @_common.max(self.vals) }

pub fn TimeseriesforecastseasonalSeries::range(self : TimeseriesforecastseasonalSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn TimeseriesforecastseasonalSeries::variance(self : TimeseriesforecastseasonalSeries) -> Double { @_common.variance(self.vals) }

pub fn TimeseriesforecastseasonalSeries::std(self : TimeseriesforecastseasonalSeries) -> Double { @_common.std(self.vals) }

pub fn TimeseriesforecastseasonalSeries::median(self : TimeseriesforecastseasonalSeries) -> Double { @_common.median(self.vals) }

pub fn TimeseriesforecastseasonalSeries::scale(self : TimeseriesforecastseasonalSeries, f : Double) -> TimeseriesforecastseasonalSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn TimeseriesforecastseasonalSeries::add(self : TimeseriesforecastseasonalSeries, other : TimeseriesforecastseasonalSeries) -> TimeseriesforecastseasonalSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn TimeseriesforecastseasonalSeries::sub(self : TimeseriesforecastseasonalSeries, other : TimeseriesforecastseasonalSeries) -> TimeseriesforecastseasonalSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn TimeseriesforecastseasonalSeries::normalize(self : TimeseriesforecastseasonalSeries) -> TimeseriesforecastseasonalSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn TimeseriesforecastseasonalSeries::cumsum(self : TimeseriesforecastseasonalSeries) -> TimeseriesforecastseasonalSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn TimeseriesforecastseasonalSeries::to_string(self : TimeseriesforecastseasonalSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct TimeseriesforecastseasonalMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn timeseries_forecast_seasonal_make_matrix(rows : Int, cols : Int, val : Double) -> TimeseriesforecastseasonalMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn timeseries_forecast_seasonal_matrix_identity(n : Int) -> TimeseriesforecastseasonalMatrix {
  let m = timeseries_forecast_seasonal_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn TimeseriesforecastseasonalMatrix::get(self : TimeseriesforecastseasonalMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn TimeseriesforecastseasonalMatrix::transpose(self : TimeseriesforecastseasonalMatrix) -> TimeseriesforecastseasonalMatrix {
  let result = timeseries_forecast_seasonal_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn TimeseriesforecastseasonalMatrix::add(self : TimeseriesforecastseasonalMatrix, other : TimeseriesforecastseasonalMatrix) -> TimeseriesforecastseasonalMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = timeseries_forecast_seasonal_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn TimeseriesforecastseasonalMatrix::scale(self : TimeseriesforecastseasonalMatrix, s : Double) -> TimeseriesforecastseasonalMatrix {
  let result = timeseries_forecast_seasonal_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn TimeseriesforecastseasonalMatrix::multiply(self : TimeseriesforecastseasonalMatrix, other : TimeseriesforecastseasonalMatrix) -> TimeseriesforecastseasonalMatrix {
  if self.cols != other.rows { return timeseries_forecast_seasonal_make_matrix(self.rows, other.cols, 0.0) }
  let result = timeseries_forecast_seasonal_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn TimeseriesforecastseasonalMatrix::trace(self : TimeseriesforecastseasonalMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn TimeseriesforecastseasonalMatrix::det(self : TimeseriesforecastseasonalMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn TimeseriesforecastseasonalMatrix::norm(self : TimeseriesforecastseasonalMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn TimeseriesforecastseasonalMatrix::to_string(self : TimeseriesforecastseasonalMatrix) -> String {
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

pub(all) struct TimeseriesforecastseasonalVector {
  comps : Array[Double]
  dim : Int
}

pub fn timeseries_forecast_seasonal_make_vector(comps : Array[Double]) -> TimeseriesforecastseasonalVector {
  { comps, dim: comps.length() }
}

pub fn timeseries_forecast_seasonal_vector_zero(dim : Int) -> TimeseriesforecastseasonalVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn TimeseriesforecastseasonalVector::add(self : TimeseriesforecastseasonalVector, other : TimeseriesforecastseasonalVector) -> TimeseriesforecastseasonalVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn TimeseriesforecastseasonalVector::sub(self : TimeseriesforecastseasonalVector, other : TimeseriesforecastseasonalVector) -> TimeseriesforecastseasonalVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn TimeseriesforecastseasonalVector::scale(self : TimeseriesforecastseasonalVector, s : Double) -> TimeseriesforecastseasonalVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn TimeseriesforecastseasonalVector::dot(self : TimeseriesforecastseasonalVector, other : TimeseriesforecastseasonalVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn TimeseriesforecastseasonalVector::norm(self : TimeseriesforecastseasonalVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn TimeseriesforecastseasonalVector::normalize(self : TimeseriesforecastseasonalVector) -> TimeseriesforecastseasonalVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn TimeseriesforecastseasonalVector::dist(self : TimeseriesforecastseasonalVector, other : TimeseriesforecastseasonalVector) -> Double {
  self.sub(other).norm()
}

pub fn TimeseriesforecastseasonalVector::to_string(self : TimeseriesforecastseasonalVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn timeseries_forecast_seasonal_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn timeseries_forecast_seasonal_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn timeseries_forecast_seasonal_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn timeseries_forecast_seasonal_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn timeseries_forecast_seasonal_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn timeseries_forecast_seasonal_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn timeseries_forecast_seasonal_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn timeseries_forecast_seasonal_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn timeseries_forecast_seasonal_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn timeseries_forecast_seasonal_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn timeseries_forecast_seasonal_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn timeseries_forecast_seasonal_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn timeseries_forecast_seasonal_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn timeseries_forecast_seasonal_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn timeseries_forecast_seasonal_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn timeseries_forecast_seasonal_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn timeseries_forecast_seasonal_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn timeseries_forecast_seasonal_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn timeseries_forecast_seasonal_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn timeseries_forecast_seasonal_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn timeseries_forecast_seasonal_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn timeseries_forecast_seasonal_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn timeseries_forecast_seasonal_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn timeseries_forecast_seasonal_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn timeseries_forecast_seasonal_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn timeseries_forecast_seasonal_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn timeseries_forecast_seasonal_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn timeseries_forecast_seasonal_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn timeseries_forecast_seasonal_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct TimeseriesforecastseasonalFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_forecast_seasonal_frame_make(size : Int) -> TimeseriesforecastseasonalFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_forecast_seasonal_frame_len(s : TimeseriesforecastseasonalFrame) -> Int { s.size }

pub fn timeseries_forecast_seasonal_frame_get(s : TimeseriesforecastseasonalFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_forecast_seasonal_frame_set(s : TimeseriesforecastseasonalFrame, i : Int, v : Double) -> TimeseriesforecastseasonalFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_seasonal_frame_sum(s : TimeseriesforecastseasonalFrame) -> Double { @_common.sum(s.data) }

pub fn timeseries_forecast_seasonal_frame_mean(s : TimeseriesforecastseasonalFrame) -> Double { @_common.mean(s.data) }

pub fn timeseries_forecast_seasonal_frame_scale(s : TimeseriesforecastseasonalFrame, f : Double) -> TimeseriesforecastseasonalFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_seasonal_frame_add(a : TimeseriesforecastseasonalFrame, b : TimeseriesforecastseasonalFrame) -> TimeseriesforecastseasonalFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_forecast_seasonal_frame_copy(s : TimeseriesforecastseasonalFrame) -> TimeseriesforecastseasonalFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_seasonal_frame_fill(s : TimeseriesforecastseasonalFrame, v : Double) -> TimeseriesforecastseasonalFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_seasonal_frame_min(s : TimeseriesforecastseasonalFrame) -> Double { @_common.min(s.data) }

pub fn timeseries_forecast_seasonal_frame_max(s : TimeseriesforecastseasonalFrame) -> Double { @_common.max(s.data) }

pub fn timeseries_forecast_seasonal_frame_to_string(s : TimeseriesforecastseasonalFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesforecastseasonalTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_forecast_seasonal_table_make(size : Int) -> TimeseriesforecastseasonalTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_forecast_seasonal_table_len(s : TimeseriesforecastseasonalTable) -> Int { s.size }

pub fn timeseries_forecast_seasonal_table_get(s : TimeseriesforecastseasonalTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_forecast_seasonal_table_set(s : TimeseriesforecastseasonalTable, i : Int, v : Double) -> TimeseriesforecastseasonalTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_seasonal_table_sum(s : TimeseriesforecastseasonalTable) -> Double { @_common.sum(s.data) }

pub fn timeseries_forecast_seasonal_table_mean(s : TimeseriesforecastseasonalTable) -> Double { @_common.mean(s.data) }

pub fn timeseries_forecast_seasonal_table_scale(s : TimeseriesforecastseasonalTable, f : Double) -> TimeseriesforecastseasonalTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_seasonal_table_add(a : TimeseriesforecastseasonalTable, b : TimeseriesforecastseasonalTable) -> TimeseriesforecastseasonalTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_forecast_seasonal_table_copy(s : TimeseriesforecastseasonalTable) -> TimeseriesforecastseasonalTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_seasonal_table_fill(s : TimeseriesforecastseasonalTable, v : Double) -> TimeseriesforecastseasonalTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_seasonal_table_min(s : TimeseriesforecastseasonalTable) -> Double { @_common.min(s.data) }

pub fn timeseries_forecast_seasonal_table_max(s : TimeseriesforecastseasonalTable) -> Double { @_common.max(s.data) }

pub fn timeseries_forecast_seasonal_table_to_string(s : TimeseriesforecastseasonalTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesforecastseasonalGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_forecast_seasonal_graphn_make(size : Int) -> TimeseriesforecastseasonalGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_forecast_seasonal_graphn_len(s : TimeseriesforecastseasonalGraphN) -> Int { s.size }

pub fn timeseries_forecast_seasonal_graphn_get(s : TimeseriesforecastseasonalGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_forecast_seasonal_graphn_set(s : TimeseriesforecastseasonalGraphN, i : Int, v : Double) -> TimeseriesforecastseasonalGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_seasonal_graphn_sum(s : TimeseriesforecastseasonalGraphN) -> Double { @_common.sum(s.data) }

pub fn timeseries_forecast_seasonal_graphn_mean(s : TimeseriesforecastseasonalGraphN) -> Double { @_common.mean(s.data) }

pub fn timeseries_forecast_seasonal_graphn_scale(s : TimeseriesforecastseasonalGraphN, f : Double) -> TimeseriesforecastseasonalGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_seasonal_graphn_add(a : TimeseriesforecastseasonalGraphN, b : TimeseriesforecastseasonalGraphN) -> TimeseriesforecastseasonalGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_forecast_seasonal_graphn_copy(s : TimeseriesforecastseasonalGraphN) -> TimeseriesforecastseasonalGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_seasonal_graphn_fill(s : TimeseriesforecastseasonalGraphN, v : Double) -> TimeseriesforecastseasonalGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_seasonal_graphn_min(s : TimeseriesforecastseasonalGraphN) -> Double { @_common.min(s.data) }

pub fn timeseries_forecast_seasonal_graphn_max(s : TimeseriesforecastseasonalGraphN) -> Double { @_common.max(s.data) }

pub fn timeseries_forecast_seasonal_graphn_to_string(s : TimeseriesforecastseasonalGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesforecastseasonalNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_forecast_seasonal_node_make(size : Int) -> TimeseriesforecastseasonalNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_forecast_seasonal_node_len(s : TimeseriesforecastseasonalNode) -> Int { s.size }

pub fn timeseries_forecast_seasonal_node_get(s : TimeseriesforecastseasonalNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_forecast_seasonal_node_set(s : TimeseriesforecastseasonalNode, i : Int, v : Double) -> TimeseriesforecastseasonalNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_seasonal_node_sum(s : TimeseriesforecastseasonalNode) -> Double { @_common.sum(s.data) }

pub fn timeseries_forecast_seasonal_node_mean(s : TimeseriesforecastseasonalNode) -> Double { @_common.mean(s.data) }

pub fn timeseries_forecast_seasonal_node_scale(s : TimeseriesforecastseasonalNode, f : Double) -> TimeseriesforecastseasonalNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_seasonal_node_add(a : TimeseriesforecastseasonalNode, b : TimeseriesforecastseasonalNode) -> TimeseriesforecastseasonalNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_forecast_seasonal_node_copy(s : TimeseriesforecastseasonalNode) -> TimeseriesforecastseasonalNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_seasonal_node_fill(s : TimeseriesforecastseasonalNode, v : Double) -> TimeseriesforecastseasonalNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_seasonal_node_min(s : TimeseriesforecastseasonalNode) -> Double { @_common.min(s.data) }

pub fn timeseries_forecast_seasonal_node_max(s : TimeseriesforecastseasonalNode) -> Double { @_common.max(s.data) }

pub fn timeseries_forecast_seasonal_node_to_string(s : TimeseriesforecastseasonalNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesforecastseasonalEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_forecast_seasonal_edge_make(size : Int) -> TimeseriesforecastseasonalEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_forecast_seasonal_edge_len(s : TimeseriesforecastseasonalEdge) -> Int { s.size }

pub fn timeseries_forecast_seasonal_edge_get(s : TimeseriesforecastseasonalEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_forecast_seasonal_edge_set(s : TimeseriesforecastseasonalEdge, i : Int, v : Double) -> TimeseriesforecastseasonalEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_seasonal_edge_sum(s : TimeseriesforecastseasonalEdge) -> Double { @_common.sum(s.data) }

pub fn timeseries_forecast_seasonal_edge_mean(s : TimeseriesforecastseasonalEdge) -> Double { @_common.mean(s.data) }

pub fn timeseries_forecast_seasonal_edge_scale(s : TimeseriesforecastseasonalEdge, f : Double) -> TimeseriesforecastseasonalEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_seasonal_edge_add(a : TimeseriesforecastseasonalEdge, b : TimeseriesforecastseasonalEdge) -> TimeseriesforecastseasonalEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_forecast_seasonal_edge_copy(s : TimeseriesforecastseasonalEdge) -> TimeseriesforecastseasonalEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_seasonal_edge_fill(s : TimeseriesforecastseasonalEdge, v : Double) -> TimeseriesforecastseasonalEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_seasonal_edge_min(s : TimeseriesforecastseasonalEdge) -> Double { @_common.min(s.data) }

pub fn timeseries_forecast_seasonal_edge_max(s : TimeseriesforecastseasonalEdge) -> Double { @_common.max(s.data) }

pub fn timeseries_forecast_seasonal_edge_to_string(s : TimeseriesforecastseasonalEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesforecastseasonalPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_forecast_seasonal_path_make(size : Int) -> TimeseriesforecastseasonalPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_forecast_seasonal_path_len(s : TimeseriesforecastseasonalPath) -> Int { s.size }

pub fn timeseries_forecast_seasonal_path_get(s : TimeseriesforecastseasonalPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_forecast_seasonal_path_set(s : TimeseriesforecastseasonalPath, i : Int, v : Double) -> TimeseriesforecastseasonalPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_seasonal_path_sum(s : TimeseriesforecastseasonalPath) -> Double { @_common.sum(s.data) }

pub fn timeseries_forecast_seasonal_path_mean(s : TimeseriesforecastseasonalPath) -> Double { @_common.mean(s.data) }

pub fn timeseries_forecast_seasonal_path_scale(s : TimeseriesforecastseasonalPath, f : Double) -> TimeseriesforecastseasonalPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_seasonal_path_add(a : TimeseriesforecastseasonalPath, b : TimeseriesforecastseasonalPath) -> TimeseriesforecastseasonalPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_forecast_seasonal_path_copy(s : TimeseriesforecastseasonalPath) -> TimeseriesforecastseasonalPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_seasonal_path_fill(s : TimeseriesforecastseasonalPath, v : Double) -> TimeseriesforecastseasonalPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_seasonal_path_min(s : TimeseriesforecastseasonalPath) -> Double { @_common.min(s.data) }

pub fn timeseries_forecast_seasonal_path_max(s : TimeseriesforecastseasonalPath) -> Double { @_common.max(s.data) }

pub fn timeseries_forecast_seasonal_path_to_string(s : TimeseriesforecastseasonalPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesforecastseasonalCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_forecast_seasonal_cluster_make(size : Int) -> TimeseriesforecastseasonalCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_forecast_seasonal_cluster_len(s : TimeseriesforecastseasonalCluster) -> Int { s.size }

pub fn timeseries_forecast_seasonal_cluster_get(s : TimeseriesforecastseasonalCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_forecast_seasonal_cluster_set(s : TimeseriesforecastseasonalCluster, i : Int, v : Double) -> TimeseriesforecastseasonalCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_seasonal_cluster_sum(s : TimeseriesforecastseasonalCluster) -> Double { @_common.sum(s.data) }

pub fn timeseries_forecast_seasonal_cluster_mean(s : TimeseriesforecastseasonalCluster) -> Double { @_common.mean(s.data) }

pub fn timeseries_forecast_seasonal_cluster_scale(s : TimeseriesforecastseasonalCluster, f : Double) -> TimeseriesforecastseasonalCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_seasonal_cluster_add(a : TimeseriesforecastseasonalCluster, b : TimeseriesforecastseasonalCluster) -> TimeseriesforecastseasonalCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_forecast_seasonal_cluster_copy(s : TimeseriesforecastseasonalCluster) -> TimeseriesforecastseasonalCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_seasonal_cluster_fill(s : TimeseriesforecastseasonalCluster, v : Double) -> TimeseriesforecastseasonalCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_seasonal_cluster_min(s : TimeseriesforecastseasonalCluster) -> Double { @_common.min(s.data) }

pub fn timeseries_forecast_seasonal_cluster_max(s : TimeseriesforecastseasonalCluster) -> Double { @_common.max(s.data) }

pub fn timeseries_forecast_seasonal_cluster_to_string(s : TimeseriesforecastseasonalCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesforecastseasonalModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_forecast_seasonal_model_make(size : Int) -> TimeseriesforecastseasonalModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_forecast_seasonal_model_len(s : TimeseriesforecastseasonalModel) -> Int { s.size }

pub fn timeseries_forecast_seasonal_model_get(s : TimeseriesforecastseasonalModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_forecast_seasonal_model_set(s : TimeseriesforecastseasonalModel, i : Int, v : Double) -> TimeseriesforecastseasonalModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_seasonal_model_sum(s : TimeseriesforecastseasonalModel) -> Double { @_common.sum(s.data) }

pub fn timeseries_forecast_seasonal_model_mean(s : TimeseriesforecastseasonalModel) -> Double { @_common.mean(s.data) }

pub fn timeseries_forecast_seasonal_model_scale(s : TimeseriesforecastseasonalModel, f : Double) -> TimeseriesforecastseasonalModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_seasonal_model_add(a : TimeseriesforecastseasonalModel, b : TimeseriesforecastseasonalModel) -> TimeseriesforecastseasonalModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_forecast_seasonal_model_copy(s : TimeseriesforecastseasonalModel) -> TimeseriesforecastseasonalModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_seasonal_model_fill(s : TimeseriesforecastseasonalModel, v : Double) -> TimeseriesforecastseasonalModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_seasonal_model_min(s : TimeseriesforecastseasonalModel) -> Double { @_common.min(s.data) }

pub fn timeseries_forecast_seasonal_model_max(s : TimeseriesforecastseasonalModel) -> Double { @_common.max(s.data) }

pub fn timeseries_forecast_seasonal_model_to_string(s : TimeseriesforecastseasonalModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesforecastseasonalLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_forecast_seasonal_layer_make(size : Int) -> TimeseriesforecastseasonalLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_forecast_seasonal_layer_len(s : TimeseriesforecastseasonalLayer) -> Int { s.size }

pub fn timeseries_forecast_seasonal_layer_get(s : TimeseriesforecastseasonalLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_forecast_seasonal_layer_set(s : TimeseriesforecastseasonalLayer, i : Int, v : Double) -> TimeseriesforecastseasonalLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_seasonal_layer_sum(s : TimeseriesforecastseasonalLayer) -> Double { @_common.sum(s.data) }

pub fn timeseries_forecast_seasonal_layer_mean(s : TimeseriesforecastseasonalLayer) -> Double { @_common.mean(s.data) }

pub fn timeseries_forecast_seasonal_layer_scale(s : TimeseriesforecastseasonalLayer, f : Double) -> TimeseriesforecastseasonalLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_seasonal_layer_add(a : TimeseriesforecastseasonalLayer, b : TimeseriesforecastseasonalLayer) -> TimeseriesforecastseasonalLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_forecast_seasonal_layer_copy(s : TimeseriesforecastseasonalLayer) -> TimeseriesforecastseasonalLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_seasonal_layer_fill(s : TimeseriesforecastseasonalLayer, v : Double) -> TimeseriesforecastseasonalLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_seasonal_layer_min(s : TimeseriesforecastseasonalLayer) -> Double { @_common.min(s.data) }

pub fn timeseries_forecast_seasonal_layer_max(s : TimeseriesforecastseasonalLayer) -> Double { @_common.max(s.data) }

pub fn timeseries_forecast_seasonal_layer_to_string(s : TimeseriesforecastseasonalLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesforecastseasonalBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_forecast_seasonal_buffer_make(size : Int) -> TimeseriesforecastseasonalBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_forecast_seasonal_buffer_len(s : TimeseriesforecastseasonalBuffer) -> Int { s.size }

pub fn timeseries_forecast_seasonal_buffer_get(s : TimeseriesforecastseasonalBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_forecast_seasonal_buffer_set(s : TimeseriesforecastseasonalBuffer, i : Int, v : Double) -> TimeseriesforecastseasonalBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_seasonal_buffer_sum(s : TimeseriesforecastseasonalBuffer) -> Double { @_common.sum(s.data) }

pub fn timeseries_forecast_seasonal_buffer_mean(s : TimeseriesforecastseasonalBuffer) -> Double { @_common.mean(s.data) }

pub fn timeseries_forecast_seasonal_buffer_scale(s : TimeseriesforecastseasonalBuffer, f : Double) -> TimeseriesforecastseasonalBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_seasonal_buffer_add(a : TimeseriesforecastseasonalBuffer, b : TimeseriesforecastseasonalBuffer) -> TimeseriesforecastseasonalBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_forecast_seasonal_buffer_copy(s : TimeseriesforecastseasonalBuffer) -> TimeseriesforecastseasonalBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_seasonal_buffer_fill(s : TimeseriesforecastseasonalBuffer, v : Double) -> TimeseriesforecastseasonalBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_seasonal_buffer_min(s : TimeseriesforecastseasonalBuffer) -> Double { @_common.min(s.data) }

pub fn timeseries_forecast_seasonal_buffer_max(s : TimeseriesforecastseasonalBuffer) -> Double { @_common.max(s.data) }

pub fn timeseries_forecast_seasonal_buffer_to_string(s : TimeseriesforecastseasonalBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesforecastseasonalCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_forecast_seasonal_cursor_make(size : Int) -> TimeseriesforecastseasonalCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_forecast_seasonal_cursor_len(s : TimeseriesforecastseasonalCursor) -> Int { s.size }

pub fn timeseries_forecast_seasonal_cursor_get(s : TimeseriesforecastseasonalCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_forecast_seasonal_cursor_set(s : TimeseriesforecastseasonalCursor, i : Int, v : Double) -> TimeseriesforecastseasonalCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_seasonal_cursor_sum(s : TimeseriesforecastseasonalCursor) -> Double { @_common.sum(s.data) }

pub fn timeseries_forecast_seasonal_cursor_mean(s : TimeseriesforecastseasonalCursor) -> Double { @_common.mean(s.data) }

pub fn timeseries_forecast_seasonal_cursor_scale(s : TimeseriesforecastseasonalCursor, f : Double) -> TimeseriesforecastseasonalCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_seasonal_cursor_add(a : TimeseriesforecastseasonalCursor, b : TimeseriesforecastseasonalCursor) -> TimeseriesforecastseasonalCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_forecast_seasonal_cursor_copy(s : TimeseriesforecastseasonalCursor) -> TimeseriesforecastseasonalCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_seasonal_cursor_fill(s : TimeseriesforecastseasonalCursor, v : Double) -> TimeseriesforecastseasonalCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_seasonal_cursor_min(s : TimeseriesforecastseasonalCursor) -> Double { @_common.min(s.data) }

pub fn timeseries_forecast_seasonal_cursor_max(s : TimeseriesforecastseasonalCursor) -> Double { @_common.max(s.data) }

pub fn timeseries_forecast_seasonal_cursor_to_string(s : TimeseriesforecastseasonalCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesforecastseasonalView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_forecast_seasonal_view_make(size : Int) -> TimeseriesforecastseasonalView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_forecast_seasonal_view_len(s : TimeseriesforecastseasonalView) -> Int { s.size }

pub fn timeseries_forecast_seasonal_view_get(s : TimeseriesforecastseasonalView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_forecast_seasonal_view_set(s : TimeseriesforecastseasonalView, i : Int, v : Double) -> TimeseriesforecastseasonalView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_seasonal_view_sum(s : TimeseriesforecastseasonalView) -> Double { @_common.sum(s.data) }

pub fn timeseries_forecast_seasonal_view_mean(s : TimeseriesforecastseasonalView) -> Double { @_common.mean(s.data) }

pub fn timeseries_forecast_seasonal_view_scale(s : TimeseriesforecastseasonalView, f : Double) -> TimeseriesforecastseasonalView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_seasonal_view_add(a : TimeseriesforecastseasonalView, b : TimeseriesforecastseasonalView) -> TimeseriesforecastseasonalView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_forecast_seasonal_view_copy(s : TimeseriesforecastseasonalView) -> TimeseriesforecastseasonalView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_seasonal_view_fill(s : TimeseriesforecastseasonalView, v : Double) -> TimeseriesforecastseasonalView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_seasonal_view_min(s : TimeseriesforecastseasonalView) -> Double { @_common.min(s.data) }

pub fn timeseries_forecast_seasonal_view_max(s : TimeseriesforecastseasonalView) -> Double { @_common.max(s.data) }

pub fn timeseries_forecast_seasonal_view_to_string(s : TimeseriesforecastseasonalView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesforecastseasonalRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_forecast_seasonal_range_make(size : Int) -> TimeseriesforecastseasonalRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_forecast_seasonal_range_len(s : TimeseriesforecastseasonalRange) -> Int { s.size }

pub fn timeseries_forecast_seasonal_range_get(s : TimeseriesforecastseasonalRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_forecast_seasonal_range_set(s : TimeseriesforecastseasonalRange, i : Int, v : Double) -> TimeseriesforecastseasonalRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_seasonal_range_sum(s : TimeseriesforecastseasonalRange) -> Double { @_common.sum(s.data) }

pub fn timeseries_forecast_seasonal_range_mean(s : TimeseriesforecastseasonalRange) -> Double { @_common.mean(s.data) }

pub fn timeseries_forecast_seasonal_range_scale(s : TimeseriesforecastseasonalRange, f : Double) -> TimeseriesforecastseasonalRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_seasonal_range_add(a : TimeseriesforecastseasonalRange, b : TimeseriesforecastseasonalRange) -> TimeseriesforecastseasonalRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_forecast_seasonal_range_copy(s : TimeseriesforecastseasonalRange) -> TimeseriesforecastseasonalRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_seasonal_range_fill(s : TimeseriesforecastseasonalRange, v : Double) -> TimeseriesforecastseasonalRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_seasonal_range_min(s : TimeseriesforecastseasonalRange) -> Double { @_common.min(s.data) }

pub fn timeseries_forecast_seasonal_range_max(s : TimeseriesforecastseasonalRange) -> Double { @_common.max(s.data) }

pub fn timeseries_forecast_seasonal_range_to_string(s : TimeseriesforecastseasonalRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesforecastseasonalSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_forecast_seasonal_slice_make(size : Int) -> TimeseriesforecastseasonalSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_forecast_seasonal_slice_len(s : TimeseriesforecastseasonalSlice) -> Int { s.size }

pub fn timeseries_forecast_seasonal_slice_get(s : TimeseriesforecastseasonalSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_forecast_seasonal_slice_set(s : TimeseriesforecastseasonalSlice, i : Int, v : Double) -> TimeseriesforecastseasonalSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_seasonal_slice_sum(s : TimeseriesforecastseasonalSlice) -> Double { @_common.sum(s.data) }

pub fn timeseries_forecast_seasonal_slice_mean(s : TimeseriesforecastseasonalSlice) -> Double { @_common.mean(s.data) }

pub fn timeseries_forecast_seasonal_slice_scale(s : TimeseriesforecastseasonalSlice, f : Double) -> TimeseriesforecastseasonalSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_seasonal_slice_add(a : TimeseriesforecastseasonalSlice, b : TimeseriesforecastseasonalSlice) -> TimeseriesforecastseasonalSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_forecast_seasonal_slice_copy(s : TimeseriesforecastseasonalSlice) -> TimeseriesforecastseasonalSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_seasonal_slice_fill(s : TimeseriesforecastseasonalSlice, v : Double) -> TimeseriesforecastseasonalSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_seasonal_slice_min(s : TimeseriesforecastseasonalSlice) -> Double { @_common.min(s.data) }

pub fn timeseries_forecast_seasonal_slice_max(s : TimeseriesforecastseasonalSlice) -> Double { @_common.max(s.data) }

pub fn timeseries_forecast_seasonal_slice_to_string(s : TimeseriesforecastseasonalSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

