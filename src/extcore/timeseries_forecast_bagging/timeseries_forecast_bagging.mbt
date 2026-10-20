///===
/// extcore/timeseries_forecast_bagging

pub(all) struct TimeseriesforecastbaggingPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn timeseries_forecast_bagging_make_point(x : Double, y : Double) -> TimeseriesforecastbaggingPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn timeseries_forecast_bagging_make_point3(x : Double, y : Double, z : Double) -> TimeseriesforecastbaggingPoint {
  { x, y, z, label: 0 }
}

pub fn TimeseriesforecastbaggingPoint::x(self : TimeseriesforecastbaggingPoint) -> Double { self.x }

pub fn TimeseriesforecastbaggingPoint::y(self : TimeseriesforecastbaggingPoint) -> Double { self.y }

pub fn TimeseriesforecastbaggingPoint::z(self : TimeseriesforecastbaggingPoint) -> Double { self.z }

pub fn TimeseriesforecastbaggingPoint::label(self : TimeseriesforecastbaggingPoint) -> Int { self.label }

pub fn TimeseriesforecastbaggingPoint::dist(self : TimeseriesforecastbaggingPoint, other : TimeseriesforecastbaggingPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn TimeseriesforecastbaggingPoint::add(self : TimeseriesforecastbaggingPoint, other : TimeseriesforecastbaggingPoint) -> TimeseriesforecastbaggingPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn TimeseriesforecastbaggingPoint::sub(self : TimeseriesforecastbaggingPoint, other : TimeseriesforecastbaggingPoint) -> TimeseriesforecastbaggingPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn TimeseriesforecastbaggingPoint::scale(self : TimeseriesforecastbaggingPoint, s : Double) -> TimeseriesforecastbaggingPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn TimeseriesforecastbaggingPoint::dot(self : TimeseriesforecastbaggingPoint, other : TimeseriesforecastbaggingPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn TimeseriesforecastbaggingPoint::cross(self : TimeseriesforecastbaggingPoint, other : TimeseriesforecastbaggingPoint) -> TimeseriesforecastbaggingPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn TimeseriesforecastbaggingPoint::norm(self : TimeseriesforecastbaggingPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn TimeseriesforecastbaggingPoint::normalize(self : TimeseriesforecastbaggingPoint) -> TimeseriesforecastbaggingPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn TimeseriesforecastbaggingPoint::negate(self : TimeseriesforecastbaggingPoint) -> TimeseriesforecastbaggingPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn TimeseriesforecastbaggingPoint::mid(self : TimeseriesforecastbaggingPoint, other : TimeseriesforecastbaggingPoint) -> TimeseriesforecastbaggingPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn TimeseriesforecastbaggingPoint::lerp(self : TimeseriesforecastbaggingPoint, other : TimeseriesforecastbaggingPoint, t : Double) -> TimeseriesforecastbaggingPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn TimeseriesforecastbaggingPoint::to_string(self : TimeseriesforecastbaggingPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct TimeseriesforecastbaggingSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn timeseries_forecast_bagging_make_series(vals : Array[Double], name : String) -> TimeseriesforecastbaggingSeries {
  { vals, name, meta: 0 }
}

pub fn TimeseriesforecastbaggingSeries::len(self : TimeseriesforecastbaggingSeries) -> Int { self.vals.length() }

pub fn TimeseriesforecastbaggingSeries::sum(self : TimeseriesforecastbaggingSeries) -> Double { @_common.sum(self.vals) }

pub fn TimeseriesforecastbaggingSeries::mean(self : TimeseriesforecastbaggingSeries) -> Double { @_common.mean(self.vals) }

pub fn TimeseriesforecastbaggingSeries::min(self : TimeseriesforecastbaggingSeries) -> Double { @_common.min(self.vals) }

pub fn TimeseriesforecastbaggingSeries::max(self : TimeseriesforecastbaggingSeries) -> Double { @_common.max(self.vals) }

pub fn TimeseriesforecastbaggingSeries::range(self : TimeseriesforecastbaggingSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn TimeseriesforecastbaggingSeries::variance(self : TimeseriesforecastbaggingSeries) -> Double { @_common.variance(self.vals) }

pub fn TimeseriesforecastbaggingSeries::std(self : TimeseriesforecastbaggingSeries) -> Double { @_common.std(self.vals) }

pub fn TimeseriesforecastbaggingSeries::median(self : TimeseriesforecastbaggingSeries) -> Double { @_common.median(self.vals) }

pub fn TimeseriesforecastbaggingSeries::scale(self : TimeseriesforecastbaggingSeries, f : Double) -> TimeseriesforecastbaggingSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn TimeseriesforecastbaggingSeries::add(self : TimeseriesforecastbaggingSeries, other : TimeseriesforecastbaggingSeries) -> TimeseriesforecastbaggingSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn TimeseriesforecastbaggingSeries::sub(self : TimeseriesforecastbaggingSeries, other : TimeseriesforecastbaggingSeries) -> TimeseriesforecastbaggingSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn TimeseriesforecastbaggingSeries::normalize(self : TimeseriesforecastbaggingSeries) -> TimeseriesforecastbaggingSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn TimeseriesforecastbaggingSeries::cumsum(self : TimeseriesforecastbaggingSeries) -> TimeseriesforecastbaggingSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn TimeseriesforecastbaggingSeries::to_string(self : TimeseriesforecastbaggingSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct TimeseriesforecastbaggingMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn timeseries_forecast_bagging_make_matrix(rows : Int, cols : Int, val : Double) -> TimeseriesforecastbaggingMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn timeseries_forecast_bagging_matrix_identity(n : Int) -> TimeseriesforecastbaggingMatrix {
  let m = timeseries_forecast_bagging_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn TimeseriesforecastbaggingMatrix::get(self : TimeseriesforecastbaggingMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn TimeseriesforecastbaggingMatrix::transpose(self : TimeseriesforecastbaggingMatrix) -> TimeseriesforecastbaggingMatrix {
  let result = timeseries_forecast_bagging_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn TimeseriesforecastbaggingMatrix::add(self : TimeseriesforecastbaggingMatrix, other : TimeseriesforecastbaggingMatrix) -> TimeseriesforecastbaggingMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = timeseries_forecast_bagging_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn TimeseriesforecastbaggingMatrix::scale(self : TimeseriesforecastbaggingMatrix, s : Double) -> TimeseriesforecastbaggingMatrix {
  let result = timeseries_forecast_bagging_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn TimeseriesforecastbaggingMatrix::multiply(self : TimeseriesforecastbaggingMatrix, other : TimeseriesforecastbaggingMatrix) -> TimeseriesforecastbaggingMatrix {
  if self.cols != other.rows { return timeseries_forecast_bagging_make_matrix(self.rows, other.cols, 0.0) }
  let result = timeseries_forecast_bagging_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn TimeseriesforecastbaggingMatrix::trace(self : TimeseriesforecastbaggingMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn TimeseriesforecastbaggingMatrix::det(self : TimeseriesforecastbaggingMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn TimeseriesforecastbaggingMatrix::norm(self : TimeseriesforecastbaggingMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn TimeseriesforecastbaggingMatrix::to_string(self : TimeseriesforecastbaggingMatrix) -> String {
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

pub(all) struct TimeseriesforecastbaggingVector {
  comps : Array[Double]
  dim : Int
}

pub fn timeseries_forecast_bagging_make_vector(comps : Array[Double]) -> TimeseriesforecastbaggingVector {
  { comps, dim: comps.length() }
}

pub fn timeseries_forecast_bagging_vector_zero(dim : Int) -> TimeseriesforecastbaggingVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn TimeseriesforecastbaggingVector::add(self : TimeseriesforecastbaggingVector, other : TimeseriesforecastbaggingVector) -> TimeseriesforecastbaggingVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn TimeseriesforecastbaggingVector::sub(self : TimeseriesforecastbaggingVector, other : TimeseriesforecastbaggingVector) -> TimeseriesforecastbaggingVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn TimeseriesforecastbaggingVector::scale(self : TimeseriesforecastbaggingVector, s : Double) -> TimeseriesforecastbaggingVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn TimeseriesforecastbaggingVector::dot(self : TimeseriesforecastbaggingVector, other : TimeseriesforecastbaggingVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn TimeseriesforecastbaggingVector::norm(self : TimeseriesforecastbaggingVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn TimeseriesforecastbaggingVector::normalize(self : TimeseriesforecastbaggingVector) -> TimeseriesforecastbaggingVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn TimeseriesforecastbaggingVector::dist(self : TimeseriesforecastbaggingVector, other : TimeseriesforecastbaggingVector) -> Double {
  self.sub(other).norm()
}

pub fn TimeseriesforecastbaggingVector::to_string(self : TimeseriesforecastbaggingVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn timeseries_forecast_bagging_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn timeseries_forecast_bagging_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn timeseries_forecast_bagging_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn timeseries_forecast_bagging_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn timeseries_forecast_bagging_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn timeseries_forecast_bagging_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn timeseries_forecast_bagging_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn timeseries_forecast_bagging_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn timeseries_forecast_bagging_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn timeseries_forecast_bagging_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn timeseries_forecast_bagging_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn timeseries_forecast_bagging_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn timeseries_forecast_bagging_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn timeseries_forecast_bagging_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn timeseries_forecast_bagging_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn timeseries_forecast_bagging_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn timeseries_forecast_bagging_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn timeseries_forecast_bagging_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn timeseries_forecast_bagging_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn timeseries_forecast_bagging_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn timeseries_forecast_bagging_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn timeseries_forecast_bagging_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn timeseries_forecast_bagging_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn timeseries_forecast_bagging_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn timeseries_forecast_bagging_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn timeseries_forecast_bagging_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn timeseries_forecast_bagging_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn timeseries_forecast_bagging_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn timeseries_forecast_bagging_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct TimeseriesforecastbaggingFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_forecast_bagging_frame_make(size : Int) -> TimeseriesforecastbaggingFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_forecast_bagging_frame_len(s : TimeseriesforecastbaggingFrame) -> Int { s.size }

pub fn timeseries_forecast_bagging_frame_get(s : TimeseriesforecastbaggingFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_forecast_bagging_frame_set(s : TimeseriesforecastbaggingFrame, i : Int, v : Double) -> TimeseriesforecastbaggingFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_bagging_frame_sum(s : TimeseriesforecastbaggingFrame) -> Double { @_common.sum(s.data) }

pub fn timeseries_forecast_bagging_frame_mean(s : TimeseriesforecastbaggingFrame) -> Double { @_common.mean(s.data) }

pub fn timeseries_forecast_bagging_frame_scale(s : TimeseriesforecastbaggingFrame, f : Double) -> TimeseriesforecastbaggingFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_bagging_frame_add(a : TimeseriesforecastbaggingFrame, b : TimeseriesforecastbaggingFrame) -> TimeseriesforecastbaggingFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_forecast_bagging_frame_copy(s : TimeseriesforecastbaggingFrame) -> TimeseriesforecastbaggingFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_bagging_frame_fill(s : TimeseriesforecastbaggingFrame, v : Double) -> TimeseriesforecastbaggingFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_bagging_frame_min(s : TimeseriesforecastbaggingFrame) -> Double { @_common.min(s.data) }

pub fn timeseries_forecast_bagging_frame_max(s : TimeseriesforecastbaggingFrame) -> Double { @_common.max(s.data) }

pub fn timeseries_forecast_bagging_frame_to_string(s : TimeseriesforecastbaggingFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesforecastbaggingTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_forecast_bagging_table_make(size : Int) -> TimeseriesforecastbaggingTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_forecast_bagging_table_len(s : TimeseriesforecastbaggingTable) -> Int { s.size }

pub fn timeseries_forecast_bagging_table_get(s : TimeseriesforecastbaggingTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_forecast_bagging_table_set(s : TimeseriesforecastbaggingTable, i : Int, v : Double) -> TimeseriesforecastbaggingTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_bagging_table_sum(s : TimeseriesforecastbaggingTable) -> Double { @_common.sum(s.data) }

pub fn timeseries_forecast_bagging_table_mean(s : TimeseriesforecastbaggingTable) -> Double { @_common.mean(s.data) }

pub fn timeseries_forecast_bagging_table_scale(s : TimeseriesforecastbaggingTable, f : Double) -> TimeseriesforecastbaggingTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_bagging_table_add(a : TimeseriesforecastbaggingTable, b : TimeseriesforecastbaggingTable) -> TimeseriesforecastbaggingTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_forecast_bagging_table_copy(s : TimeseriesforecastbaggingTable) -> TimeseriesforecastbaggingTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_bagging_table_fill(s : TimeseriesforecastbaggingTable, v : Double) -> TimeseriesforecastbaggingTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_bagging_table_min(s : TimeseriesforecastbaggingTable) -> Double { @_common.min(s.data) }

pub fn timeseries_forecast_bagging_table_max(s : TimeseriesforecastbaggingTable) -> Double { @_common.max(s.data) }

pub fn timeseries_forecast_bagging_table_to_string(s : TimeseriesforecastbaggingTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesforecastbaggingGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_forecast_bagging_graphn_make(size : Int) -> TimeseriesforecastbaggingGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_forecast_bagging_graphn_len(s : TimeseriesforecastbaggingGraphN) -> Int { s.size }

pub fn timeseries_forecast_bagging_graphn_get(s : TimeseriesforecastbaggingGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_forecast_bagging_graphn_set(s : TimeseriesforecastbaggingGraphN, i : Int, v : Double) -> TimeseriesforecastbaggingGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_bagging_graphn_sum(s : TimeseriesforecastbaggingGraphN) -> Double { @_common.sum(s.data) }

pub fn timeseries_forecast_bagging_graphn_mean(s : TimeseriesforecastbaggingGraphN) -> Double { @_common.mean(s.data) }

pub fn timeseries_forecast_bagging_graphn_scale(s : TimeseriesforecastbaggingGraphN, f : Double) -> TimeseriesforecastbaggingGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_bagging_graphn_add(a : TimeseriesforecastbaggingGraphN, b : TimeseriesforecastbaggingGraphN) -> TimeseriesforecastbaggingGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_forecast_bagging_graphn_copy(s : TimeseriesforecastbaggingGraphN) -> TimeseriesforecastbaggingGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_bagging_graphn_fill(s : TimeseriesforecastbaggingGraphN, v : Double) -> TimeseriesforecastbaggingGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_bagging_graphn_min(s : TimeseriesforecastbaggingGraphN) -> Double { @_common.min(s.data) }

pub fn timeseries_forecast_bagging_graphn_max(s : TimeseriesforecastbaggingGraphN) -> Double { @_common.max(s.data) }

pub fn timeseries_forecast_bagging_graphn_to_string(s : TimeseriesforecastbaggingGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesforecastbaggingNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_forecast_bagging_node_make(size : Int) -> TimeseriesforecastbaggingNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_forecast_bagging_node_len(s : TimeseriesforecastbaggingNode) -> Int { s.size }

pub fn timeseries_forecast_bagging_node_get(s : TimeseriesforecastbaggingNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_forecast_bagging_node_set(s : TimeseriesforecastbaggingNode, i : Int, v : Double) -> TimeseriesforecastbaggingNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_bagging_node_sum(s : TimeseriesforecastbaggingNode) -> Double { @_common.sum(s.data) }

pub fn timeseries_forecast_bagging_node_mean(s : TimeseriesforecastbaggingNode) -> Double { @_common.mean(s.data) }

pub fn timeseries_forecast_bagging_node_scale(s : TimeseriesforecastbaggingNode, f : Double) -> TimeseriesforecastbaggingNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_bagging_node_add(a : TimeseriesforecastbaggingNode, b : TimeseriesforecastbaggingNode) -> TimeseriesforecastbaggingNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_forecast_bagging_node_copy(s : TimeseriesforecastbaggingNode) -> TimeseriesforecastbaggingNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_bagging_node_fill(s : TimeseriesforecastbaggingNode, v : Double) -> TimeseriesforecastbaggingNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_bagging_node_min(s : TimeseriesforecastbaggingNode) -> Double { @_common.min(s.data) }

pub fn timeseries_forecast_bagging_node_max(s : TimeseriesforecastbaggingNode) -> Double { @_common.max(s.data) }

pub fn timeseries_forecast_bagging_node_to_string(s : TimeseriesforecastbaggingNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesforecastbaggingEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_forecast_bagging_edge_make(size : Int) -> TimeseriesforecastbaggingEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_forecast_bagging_edge_len(s : TimeseriesforecastbaggingEdge) -> Int { s.size }

pub fn timeseries_forecast_bagging_edge_get(s : TimeseriesforecastbaggingEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_forecast_bagging_edge_set(s : TimeseriesforecastbaggingEdge, i : Int, v : Double) -> TimeseriesforecastbaggingEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_bagging_edge_sum(s : TimeseriesforecastbaggingEdge) -> Double { @_common.sum(s.data) }

pub fn timeseries_forecast_bagging_edge_mean(s : TimeseriesforecastbaggingEdge) -> Double { @_common.mean(s.data) }

pub fn timeseries_forecast_bagging_edge_scale(s : TimeseriesforecastbaggingEdge, f : Double) -> TimeseriesforecastbaggingEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_bagging_edge_add(a : TimeseriesforecastbaggingEdge, b : TimeseriesforecastbaggingEdge) -> TimeseriesforecastbaggingEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_forecast_bagging_edge_copy(s : TimeseriesforecastbaggingEdge) -> TimeseriesforecastbaggingEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_bagging_edge_fill(s : TimeseriesforecastbaggingEdge, v : Double) -> TimeseriesforecastbaggingEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_bagging_edge_min(s : TimeseriesforecastbaggingEdge) -> Double { @_common.min(s.data) }

pub fn timeseries_forecast_bagging_edge_max(s : TimeseriesforecastbaggingEdge) -> Double { @_common.max(s.data) }

pub fn timeseries_forecast_bagging_edge_to_string(s : TimeseriesforecastbaggingEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesforecastbaggingPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_forecast_bagging_path_make(size : Int) -> TimeseriesforecastbaggingPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_forecast_bagging_path_len(s : TimeseriesforecastbaggingPath) -> Int { s.size }

pub fn timeseries_forecast_bagging_path_get(s : TimeseriesforecastbaggingPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_forecast_bagging_path_set(s : TimeseriesforecastbaggingPath, i : Int, v : Double) -> TimeseriesforecastbaggingPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_bagging_path_sum(s : TimeseriesforecastbaggingPath) -> Double { @_common.sum(s.data) }

pub fn timeseries_forecast_bagging_path_mean(s : TimeseriesforecastbaggingPath) -> Double { @_common.mean(s.data) }

pub fn timeseries_forecast_bagging_path_scale(s : TimeseriesforecastbaggingPath, f : Double) -> TimeseriesforecastbaggingPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_bagging_path_add(a : TimeseriesforecastbaggingPath, b : TimeseriesforecastbaggingPath) -> TimeseriesforecastbaggingPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_forecast_bagging_path_copy(s : TimeseriesforecastbaggingPath) -> TimeseriesforecastbaggingPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_bagging_path_fill(s : TimeseriesforecastbaggingPath, v : Double) -> TimeseriesforecastbaggingPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_bagging_path_min(s : TimeseriesforecastbaggingPath) -> Double { @_common.min(s.data) }

pub fn timeseries_forecast_bagging_path_max(s : TimeseriesforecastbaggingPath) -> Double { @_common.max(s.data) }

pub fn timeseries_forecast_bagging_path_to_string(s : TimeseriesforecastbaggingPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesforecastbaggingCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_forecast_bagging_cluster_make(size : Int) -> TimeseriesforecastbaggingCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_forecast_bagging_cluster_len(s : TimeseriesforecastbaggingCluster) -> Int { s.size }

pub fn timeseries_forecast_bagging_cluster_get(s : TimeseriesforecastbaggingCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_forecast_bagging_cluster_set(s : TimeseriesforecastbaggingCluster, i : Int, v : Double) -> TimeseriesforecastbaggingCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_bagging_cluster_sum(s : TimeseriesforecastbaggingCluster) -> Double { @_common.sum(s.data) }

pub fn timeseries_forecast_bagging_cluster_mean(s : TimeseriesforecastbaggingCluster) -> Double { @_common.mean(s.data) }

pub fn timeseries_forecast_bagging_cluster_scale(s : TimeseriesforecastbaggingCluster, f : Double) -> TimeseriesforecastbaggingCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_bagging_cluster_add(a : TimeseriesforecastbaggingCluster, b : TimeseriesforecastbaggingCluster) -> TimeseriesforecastbaggingCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_forecast_bagging_cluster_copy(s : TimeseriesforecastbaggingCluster) -> TimeseriesforecastbaggingCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_bagging_cluster_fill(s : TimeseriesforecastbaggingCluster, v : Double) -> TimeseriesforecastbaggingCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_bagging_cluster_min(s : TimeseriesforecastbaggingCluster) -> Double { @_common.min(s.data) }

pub fn timeseries_forecast_bagging_cluster_max(s : TimeseriesforecastbaggingCluster) -> Double { @_common.max(s.data) }

pub fn timeseries_forecast_bagging_cluster_to_string(s : TimeseriesforecastbaggingCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesforecastbaggingModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_forecast_bagging_model_make(size : Int) -> TimeseriesforecastbaggingModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_forecast_bagging_model_len(s : TimeseriesforecastbaggingModel) -> Int { s.size }

pub fn timeseries_forecast_bagging_model_get(s : TimeseriesforecastbaggingModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_forecast_bagging_model_set(s : TimeseriesforecastbaggingModel, i : Int, v : Double) -> TimeseriesforecastbaggingModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_bagging_model_sum(s : TimeseriesforecastbaggingModel) -> Double { @_common.sum(s.data) }

pub fn timeseries_forecast_bagging_model_mean(s : TimeseriesforecastbaggingModel) -> Double { @_common.mean(s.data) }

pub fn timeseries_forecast_bagging_model_scale(s : TimeseriesforecastbaggingModel, f : Double) -> TimeseriesforecastbaggingModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_bagging_model_add(a : TimeseriesforecastbaggingModel, b : TimeseriesforecastbaggingModel) -> TimeseriesforecastbaggingModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_forecast_bagging_model_copy(s : TimeseriesforecastbaggingModel) -> TimeseriesforecastbaggingModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_bagging_model_fill(s : TimeseriesforecastbaggingModel, v : Double) -> TimeseriesforecastbaggingModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_bagging_model_min(s : TimeseriesforecastbaggingModel) -> Double { @_common.min(s.data) }

pub fn timeseries_forecast_bagging_model_max(s : TimeseriesforecastbaggingModel) -> Double { @_common.max(s.data) }

pub fn timeseries_forecast_bagging_model_to_string(s : TimeseriesforecastbaggingModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesforecastbaggingLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_forecast_bagging_layer_make(size : Int) -> TimeseriesforecastbaggingLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_forecast_bagging_layer_len(s : TimeseriesforecastbaggingLayer) -> Int { s.size }

pub fn timeseries_forecast_bagging_layer_get(s : TimeseriesforecastbaggingLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_forecast_bagging_layer_set(s : TimeseriesforecastbaggingLayer, i : Int, v : Double) -> TimeseriesforecastbaggingLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_bagging_layer_sum(s : TimeseriesforecastbaggingLayer) -> Double { @_common.sum(s.data) }

pub fn timeseries_forecast_bagging_layer_mean(s : TimeseriesforecastbaggingLayer) -> Double { @_common.mean(s.data) }

pub fn timeseries_forecast_bagging_layer_scale(s : TimeseriesforecastbaggingLayer, f : Double) -> TimeseriesforecastbaggingLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_bagging_layer_add(a : TimeseriesforecastbaggingLayer, b : TimeseriesforecastbaggingLayer) -> TimeseriesforecastbaggingLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_forecast_bagging_layer_copy(s : TimeseriesforecastbaggingLayer) -> TimeseriesforecastbaggingLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_bagging_layer_fill(s : TimeseriesforecastbaggingLayer, v : Double) -> TimeseriesforecastbaggingLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_bagging_layer_min(s : TimeseriesforecastbaggingLayer) -> Double { @_common.min(s.data) }

pub fn timeseries_forecast_bagging_layer_max(s : TimeseriesforecastbaggingLayer) -> Double { @_common.max(s.data) }

pub fn timeseries_forecast_bagging_layer_to_string(s : TimeseriesforecastbaggingLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesforecastbaggingBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_forecast_bagging_buffer_make(size : Int) -> TimeseriesforecastbaggingBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_forecast_bagging_buffer_len(s : TimeseriesforecastbaggingBuffer) -> Int { s.size }

pub fn timeseries_forecast_bagging_buffer_get(s : TimeseriesforecastbaggingBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_forecast_bagging_buffer_set(s : TimeseriesforecastbaggingBuffer, i : Int, v : Double) -> TimeseriesforecastbaggingBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_bagging_buffer_sum(s : TimeseriesforecastbaggingBuffer) -> Double { @_common.sum(s.data) }

pub fn timeseries_forecast_bagging_buffer_mean(s : TimeseriesforecastbaggingBuffer) -> Double { @_common.mean(s.data) }

pub fn timeseries_forecast_bagging_buffer_scale(s : TimeseriesforecastbaggingBuffer, f : Double) -> TimeseriesforecastbaggingBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_bagging_buffer_add(a : TimeseriesforecastbaggingBuffer, b : TimeseriesforecastbaggingBuffer) -> TimeseriesforecastbaggingBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_forecast_bagging_buffer_copy(s : TimeseriesforecastbaggingBuffer) -> TimeseriesforecastbaggingBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_bagging_buffer_fill(s : TimeseriesforecastbaggingBuffer, v : Double) -> TimeseriesforecastbaggingBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_bagging_buffer_min(s : TimeseriesforecastbaggingBuffer) -> Double { @_common.min(s.data) }

pub fn timeseries_forecast_bagging_buffer_max(s : TimeseriesforecastbaggingBuffer) -> Double { @_common.max(s.data) }

pub fn timeseries_forecast_bagging_buffer_to_string(s : TimeseriesforecastbaggingBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesforecastbaggingCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_forecast_bagging_cursor_make(size : Int) -> TimeseriesforecastbaggingCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_forecast_bagging_cursor_len(s : TimeseriesforecastbaggingCursor) -> Int { s.size }

pub fn timeseries_forecast_bagging_cursor_get(s : TimeseriesforecastbaggingCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_forecast_bagging_cursor_set(s : TimeseriesforecastbaggingCursor, i : Int, v : Double) -> TimeseriesforecastbaggingCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_bagging_cursor_sum(s : TimeseriesforecastbaggingCursor) -> Double { @_common.sum(s.data) }

pub fn timeseries_forecast_bagging_cursor_mean(s : TimeseriesforecastbaggingCursor) -> Double { @_common.mean(s.data) }

pub fn timeseries_forecast_bagging_cursor_scale(s : TimeseriesforecastbaggingCursor, f : Double) -> TimeseriesforecastbaggingCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_bagging_cursor_add(a : TimeseriesforecastbaggingCursor, b : TimeseriesforecastbaggingCursor) -> TimeseriesforecastbaggingCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_forecast_bagging_cursor_copy(s : TimeseriesforecastbaggingCursor) -> TimeseriesforecastbaggingCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_bagging_cursor_fill(s : TimeseriesforecastbaggingCursor, v : Double) -> TimeseriesforecastbaggingCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_bagging_cursor_min(s : TimeseriesforecastbaggingCursor) -> Double { @_common.min(s.data) }

pub fn timeseries_forecast_bagging_cursor_max(s : TimeseriesforecastbaggingCursor) -> Double { @_common.max(s.data) }

pub fn timeseries_forecast_bagging_cursor_to_string(s : TimeseriesforecastbaggingCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesforecastbaggingView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_forecast_bagging_view_make(size : Int) -> TimeseriesforecastbaggingView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_forecast_bagging_view_len(s : TimeseriesforecastbaggingView) -> Int { s.size }

pub fn timeseries_forecast_bagging_view_get(s : TimeseriesforecastbaggingView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_forecast_bagging_view_set(s : TimeseriesforecastbaggingView, i : Int, v : Double) -> TimeseriesforecastbaggingView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_bagging_view_sum(s : TimeseriesforecastbaggingView) -> Double { @_common.sum(s.data) }

pub fn timeseries_forecast_bagging_view_mean(s : TimeseriesforecastbaggingView) -> Double { @_common.mean(s.data) }

pub fn timeseries_forecast_bagging_view_scale(s : TimeseriesforecastbaggingView, f : Double) -> TimeseriesforecastbaggingView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_bagging_view_add(a : TimeseriesforecastbaggingView, b : TimeseriesforecastbaggingView) -> TimeseriesforecastbaggingView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_forecast_bagging_view_copy(s : TimeseriesforecastbaggingView) -> TimeseriesforecastbaggingView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_bagging_view_fill(s : TimeseriesforecastbaggingView, v : Double) -> TimeseriesforecastbaggingView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_bagging_view_min(s : TimeseriesforecastbaggingView) -> Double { @_common.min(s.data) }

pub fn timeseries_forecast_bagging_view_max(s : TimeseriesforecastbaggingView) -> Double { @_common.max(s.data) }

pub fn timeseries_forecast_bagging_view_to_string(s : TimeseriesforecastbaggingView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesforecastbaggingRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_forecast_bagging_range_make(size : Int) -> TimeseriesforecastbaggingRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_forecast_bagging_range_len(s : TimeseriesforecastbaggingRange) -> Int { s.size }

pub fn timeseries_forecast_bagging_range_get(s : TimeseriesforecastbaggingRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_forecast_bagging_range_set(s : TimeseriesforecastbaggingRange, i : Int, v : Double) -> TimeseriesforecastbaggingRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_bagging_range_sum(s : TimeseriesforecastbaggingRange) -> Double { @_common.sum(s.data) }

pub fn timeseries_forecast_bagging_range_mean(s : TimeseriesforecastbaggingRange) -> Double { @_common.mean(s.data) }

pub fn timeseries_forecast_bagging_range_scale(s : TimeseriesforecastbaggingRange, f : Double) -> TimeseriesforecastbaggingRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_bagging_range_add(a : TimeseriesforecastbaggingRange, b : TimeseriesforecastbaggingRange) -> TimeseriesforecastbaggingRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_forecast_bagging_range_copy(s : TimeseriesforecastbaggingRange) -> TimeseriesforecastbaggingRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_bagging_range_fill(s : TimeseriesforecastbaggingRange, v : Double) -> TimeseriesforecastbaggingRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_bagging_range_min(s : TimeseriesforecastbaggingRange) -> Double { @_common.min(s.data) }

pub fn timeseries_forecast_bagging_range_max(s : TimeseriesforecastbaggingRange) -> Double { @_common.max(s.data) }

pub fn timeseries_forecast_bagging_range_to_string(s : TimeseriesforecastbaggingRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesforecastbaggingSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_forecast_bagging_slice_make(size : Int) -> TimeseriesforecastbaggingSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_forecast_bagging_slice_len(s : TimeseriesforecastbaggingSlice) -> Int { s.size }

pub fn timeseries_forecast_bagging_slice_get(s : TimeseriesforecastbaggingSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_forecast_bagging_slice_set(s : TimeseriesforecastbaggingSlice, i : Int, v : Double) -> TimeseriesforecastbaggingSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_bagging_slice_sum(s : TimeseriesforecastbaggingSlice) -> Double { @_common.sum(s.data) }

pub fn timeseries_forecast_bagging_slice_mean(s : TimeseriesforecastbaggingSlice) -> Double { @_common.mean(s.data) }

pub fn timeseries_forecast_bagging_slice_scale(s : TimeseriesforecastbaggingSlice, f : Double) -> TimeseriesforecastbaggingSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_bagging_slice_add(a : TimeseriesforecastbaggingSlice, b : TimeseriesforecastbaggingSlice) -> TimeseriesforecastbaggingSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_forecast_bagging_slice_copy(s : TimeseriesforecastbaggingSlice) -> TimeseriesforecastbaggingSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_bagging_slice_fill(s : TimeseriesforecastbaggingSlice, v : Double) -> TimeseriesforecastbaggingSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_bagging_slice_min(s : TimeseriesforecastbaggingSlice) -> Double { @_common.min(s.data) }

pub fn timeseries_forecast_bagging_slice_max(s : TimeseriesforecastbaggingSlice) -> Double { @_common.max(s.data) }

pub fn timeseries_forecast_bagging_slice_to_string(s : TimeseriesforecastbaggingSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

