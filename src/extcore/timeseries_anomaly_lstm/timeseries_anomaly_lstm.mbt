///===
/// extcore/timeseries_anomaly_lstm

pub(all) struct TimeseriesanomalylstmPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn timeseries_anomaly_lstm_make_point(x : Double, y : Double) -> TimeseriesanomalylstmPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn timeseries_anomaly_lstm_make_point3(x : Double, y : Double, z : Double) -> TimeseriesanomalylstmPoint {
  { x, y, z, label: 0 }
}

pub fn TimeseriesanomalylstmPoint::x(self : TimeseriesanomalylstmPoint) -> Double { self.x }

pub fn TimeseriesanomalylstmPoint::y(self : TimeseriesanomalylstmPoint) -> Double { self.y }

pub fn TimeseriesanomalylstmPoint::z(self : TimeseriesanomalylstmPoint) -> Double { self.z }

pub fn TimeseriesanomalylstmPoint::label(self : TimeseriesanomalylstmPoint) -> Int { self.label }

pub fn TimeseriesanomalylstmPoint::dist(self : TimeseriesanomalylstmPoint, other : TimeseriesanomalylstmPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn TimeseriesanomalylstmPoint::add(self : TimeseriesanomalylstmPoint, other : TimeseriesanomalylstmPoint) -> TimeseriesanomalylstmPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn TimeseriesanomalylstmPoint::sub(self : TimeseriesanomalylstmPoint, other : TimeseriesanomalylstmPoint) -> TimeseriesanomalylstmPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn TimeseriesanomalylstmPoint::scale(self : TimeseriesanomalylstmPoint, s : Double) -> TimeseriesanomalylstmPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn TimeseriesanomalylstmPoint::dot(self : TimeseriesanomalylstmPoint, other : TimeseriesanomalylstmPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn TimeseriesanomalylstmPoint::cross(self : TimeseriesanomalylstmPoint, other : TimeseriesanomalylstmPoint) -> TimeseriesanomalylstmPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn TimeseriesanomalylstmPoint::norm(self : TimeseriesanomalylstmPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn TimeseriesanomalylstmPoint::normalize(self : TimeseriesanomalylstmPoint) -> TimeseriesanomalylstmPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn TimeseriesanomalylstmPoint::negate(self : TimeseriesanomalylstmPoint) -> TimeseriesanomalylstmPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn TimeseriesanomalylstmPoint::mid(self : TimeseriesanomalylstmPoint, other : TimeseriesanomalylstmPoint) -> TimeseriesanomalylstmPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn TimeseriesanomalylstmPoint::lerp(self : TimeseriesanomalylstmPoint, other : TimeseriesanomalylstmPoint, t : Double) -> TimeseriesanomalylstmPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn TimeseriesanomalylstmPoint::to_string(self : TimeseriesanomalylstmPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct TimeseriesanomalylstmSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn timeseries_anomaly_lstm_make_series(vals : Array[Double], name : String) -> TimeseriesanomalylstmSeries {
  { vals, name, meta: 0 }
}

pub fn TimeseriesanomalylstmSeries::len(self : TimeseriesanomalylstmSeries) -> Int { self.vals.length() }

pub fn TimeseriesanomalylstmSeries::sum(self : TimeseriesanomalylstmSeries) -> Double { @_common.sum(self.vals) }

pub fn TimeseriesanomalylstmSeries::mean(self : TimeseriesanomalylstmSeries) -> Double { @_common.mean(self.vals) }

pub fn TimeseriesanomalylstmSeries::min(self : TimeseriesanomalylstmSeries) -> Double { @_common.min(self.vals) }

pub fn TimeseriesanomalylstmSeries::max(self : TimeseriesanomalylstmSeries) -> Double { @_common.max(self.vals) }

pub fn TimeseriesanomalylstmSeries::range(self : TimeseriesanomalylstmSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn TimeseriesanomalylstmSeries::variance(self : TimeseriesanomalylstmSeries) -> Double { @_common.variance(self.vals) }

pub fn TimeseriesanomalylstmSeries::std(self : TimeseriesanomalylstmSeries) -> Double { @_common.std(self.vals) }

pub fn TimeseriesanomalylstmSeries::median(self : TimeseriesanomalylstmSeries) -> Double { @_common.median(self.vals) }

pub fn TimeseriesanomalylstmSeries::scale(self : TimeseriesanomalylstmSeries, f : Double) -> TimeseriesanomalylstmSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn TimeseriesanomalylstmSeries::add(self : TimeseriesanomalylstmSeries, other : TimeseriesanomalylstmSeries) -> TimeseriesanomalylstmSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn TimeseriesanomalylstmSeries::sub(self : TimeseriesanomalylstmSeries, other : TimeseriesanomalylstmSeries) -> TimeseriesanomalylstmSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn TimeseriesanomalylstmSeries::normalize(self : TimeseriesanomalylstmSeries) -> TimeseriesanomalylstmSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn TimeseriesanomalylstmSeries::cumsum(self : TimeseriesanomalylstmSeries) -> TimeseriesanomalylstmSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn TimeseriesanomalylstmSeries::to_string(self : TimeseriesanomalylstmSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct TimeseriesanomalylstmMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn timeseries_anomaly_lstm_make_matrix(rows : Int, cols : Int, val : Double) -> TimeseriesanomalylstmMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn timeseries_anomaly_lstm_matrix_identity(n : Int) -> TimeseriesanomalylstmMatrix {
  let m = timeseries_anomaly_lstm_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn TimeseriesanomalylstmMatrix::get(self : TimeseriesanomalylstmMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn TimeseriesanomalylstmMatrix::transpose(self : TimeseriesanomalylstmMatrix) -> TimeseriesanomalylstmMatrix {
  let result = timeseries_anomaly_lstm_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn TimeseriesanomalylstmMatrix::add(self : TimeseriesanomalylstmMatrix, other : TimeseriesanomalylstmMatrix) -> TimeseriesanomalylstmMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = timeseries_anomaly_lstm_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn TimeseriesanomalylstmMatrix::scale(self : TimeseriesanomalylstmMatrix, s : Double) -> TimeseriesanomalylstmMatrix {
  let result = timeseries_anomaly_lstm_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn TimeseriesanomalylstmMatrix::multiply(self : TimeseriesanomalylstmMatrix, other : TimeseriesanomalylstmMatrix) -> TimeseriesanomalylstmMatrix {
  if self.cols != other.rows { return timeseries_anomaly_lstm_make_matrix(self.rows, other.cols, 0.0) }
  let result = timeseries_anomaly_lstm_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn TimeseriesanomalylstmMatrix::trace(self : TimeseriesanomalylstmMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn TimeseriesanomalylstmMatrix::det(self : TimeseriesanomalylstmMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn TimeseriesanomalylstmMatrix::norm(self : TimeseriesanomalylstmMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn TimeseriesanomalylstmMatrix::to_string(self : TimeseriesanomalylstmMatrix) -> String {
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

pub(all) struct TimeseriesanomalylstmVector {
  comps : Array[Double]
  dim : Int
}

pub fn timeseries_anomaly_lstm_make_vector(comps : Array[Double]) -> TimeseriesanomalylstmVector {
  { comps, dim: comps.length() }
}

pub fn timeseries_anomaly_lstm_vector_zero(dim : Int) -> TimeseriesanomalylstmVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn TimeseriesanomalylstmVector::add(self : TimeseriesanomalylstmVector, other : TimeseriesanomalylstmVector) -> TimeseriesanomalylstmVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn TimeseriesanomalylstmVector::sub(self : TimeseriesanomalylstmVector, other : TimeseriesanomalylstmVector) -> TimeseriesanomalylstmVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn TimeseriesanomalylstmVector::scale(self : TimeseriesanomalylstmVector, s : Double) -> TimeseriesanomalylstmVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn TimeseriesanomalylstmVector::dot(self : TimeseriesanomalylstmVector, other : TimeseriesanomalylstmVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn TimeseriesanomalylstmVector::norm(self : TimeseriesanomalylstmVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn TimeseriesanomalylstmVector::normalize(self : TimeseriesanomalylstmVector) -> TimeseriesanomalylstmVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn TimeseriesanomalylstmVector::dist(self : TimeseriesanomalylstmVector, other : TimeseriesanomalylstmVector) -> Double {
  self.sub(other).norm()
}

pub fn TimeseriesanomalylstmVector::to_string(self : TimeseriesanomalylstmVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn timeseries_anomaly_lstm_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn timeseries_anomaly_lstm_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn timeseries_anomaly_lstm_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn timeseries_anomaly_lstm_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn timeseries_anomaly_lstm_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn timeseries_anomaly_lstm_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn timeseries_anomaly_lstm_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn timeseries_anomaly_lstm_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn timeseries_anomaly_lstm_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn timeseries_anomaly_lstm_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn timeseries_anomaly_lstm_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn timeseries_anomaly_lstm_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn timeseries_anomaly_lstm_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn timeseries_anomaly_lstm_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn timeseries_anomaly_lstm_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn timeseries_anomaly_lstm_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn timeseries_anomaly_lstm_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn timeseries_anomaly_lstm_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn timeseries_anomaly_lstm_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn timeseries_anomaly_lstm_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn timeseries_anomaly_lstm_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn timeseries_anomaly_lstm_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn timeseries_anomaly_lstm_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn timeseries_anomaly_lstm_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn timeseries_anomaly_lstm_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn timeseries_anomaly_lstm_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn timeseries_anomaly_lstm_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn timeseries_anomaly_lstm_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn timeseries_anomaly_lstm_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct TimeseriesanomalylstmFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_anomaly_lstm_frame_make(size : Int) -> TimeseriesanomalylstmFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_anomaly_lstm_frame_len(s : TimeseriesanomalylstmFrame) -> Int { s.size }

pub fn timeseries_anomaly_lstm_frame_get(s : TimeseriesanomalylstmFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_anomaly_lstm_frame_set(s : TimeseriesanomalylstmFrame, i : Int, v : Double) -> TimeseriesanomalylstmFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_lstm_frame_sum(s : TimeseriesanomalylstmFrame) -> Double { @_common.sum(s.data) }

pub fn timeseries_anomaly_lstm_frame_mean(s : TimeseriesanomalylstmFrame) -> Double { @_common.mean(s.data) }

pub fn timeseries_anomaly_lstm_frame_scale(s : TimeseriesanomalylstmFrame, f : Double) -> TimeseriesanomalylstmFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_lstm_frame_add(a : TimeseriesanomalylstmFrame, b : TimeseriesanomalylstmFrame) -> TimeseriesanomalylstmFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_anomaly_lstm_frame_copy(s : TimeseriesanomalylstmFrame) -> TimeseriesanomalylstmFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_lstm_frame_fill(s : TimeseriesanomalylstmFrame, v : Double) -> TimeseriesanomalylstmFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_lstm_frame_min(s : TimeseriesanomalylstmFrame) -> Double { @_common.min(s.data) }

pub fn timeseries_anomaly_lstm_frame_max(s : TimeseriesanomalylstmFrame) -> Double { @_common.max(s.data) }

pub fn timeseries_anomaly_lstm_frame_to_string(s : TimeseriesanomalylstmFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesanomalylstmTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_anomaly_lstm_table_make(size : Int) -> TimeseriesanomalylstmTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_anomaly_lstm_table_len(s : TimeseriesanomalylstmTable) -> Int { s.size }

pub fn timeseries_anomaly_lstm_table_get(s : TimeseriesanomalylstmTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_anomaly_lstm_table_set(s : TimeseriesanomalylstmTable, i : Int, v : Double) -> TimeseriesanomalylstmTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_lstm_table_sum(s : TimeseriesanomalylstmTable) -> Double { @_common.sum(s.data) }

pub fn timeseries_anomaly_lstm_table_mean(s : TimeseriesanomalylstmTable) -> Double { @_common.mean(s.data) }

pub fn timeseries_anomaly_lstm_table_scale(s : TimeseriesanomalylstmTable, f : Double) -> TimeseriesanomalylstmTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_lstm_table_add(a : TimeseriesanomalylstmTable, b : TimeseriesanomalylstmTable) -> TimeseriesanomalylstmTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_anomaly_lstm_table_copy(s : TimeseriesanomalylstmTable) -> TimeseriesanomalylstmTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_lstm_table_fill(s : TimeseriesanomalylstmTable, v : Double) -> TimeseriesanomalylstmTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_lstm_table_min(s : TimeseriesanomalylstmTable) -> Double { @_common.min(s.data) }

pub fn timeseries_anomaly_lstm_table_max(s : TimeseriesanomalylstmTable) -> Double { @_common.max(s.data) }

pub fn timeseries_anomaly_lstm_table_to_string(s : TimeseriesanomalylstmTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesanomalylstmGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_anomaly_lstm_graphn_make(size : Int) -> TimeseriesanomalylstmGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_anomaly_lstm_graphn_len(s : TimeseriesanomalylstmGraphN) -> Int { s.size }

pub fn timeseries_anomaly_lstm_graphn_get(s : TimeseriesanomalylstmGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_anomaly_lstm_graphn_set(s : TimeseriesanomalylstmGraphN, i : Int, v : Double) -> TimeseriesanomalylstmGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_lstm_graphn_sum(s : TimeseriesanomalylstmGraphN) -> Double { @_common.sum(s.data) }

pub fn timeseries_anomaly_lstm_graphn_mean(s : TimeseriesanomalylstmGraphN) -> Double { @_common.mean(s.data) }

pub fn timeseries_anomaly_lstm_graphn_scale(s : TimeseriesanomalylstmGraphN, f : Double) -> TimeseriesanomalylstmGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_lstm_graphn_add(a : TimeseriesanomalylstmGraphN, b : TimeseriesanomalylstmGraphN) -> TimeseriesanomalylstmGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_anomaly_lstm_graphn_copy(s : TimeseriesanomalylstmGraphN) -> TimeseriesanomalylstmGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_lstm_graphn_fill(s : TimeseriesanomalylstmGraphN, v : Double) -> TimeseriesanomalylstmGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_lstm_graphn_min(s : TimeseriesanomalylstmGraphN) -> Double { @_common.min(s.data) }

pub fn timeseries_anomaly_lstm_graphn_max(s : TimeseriesanomalylstmGraphN) -> Double { @_common.max(s.data) }

pub fn timeseries_anomaly_lstm_graphn_to_string(s : TimeseriesanomalylstmGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesanomalylstmNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_anomaly_lstm_node_make(size : Int) -> TimeseriesanomalylstmNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_anomaly_lstm_node_len(s : TimeseriesanomalylstmNode) -> Int { s.size }

pub fn timeseries_anomaly_lstm_node_get(s : TimeseriesanomalylstmNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_anomaly_lstm_node_set(s : TimeseriesanomalylstmNode, i : Int, v : Double) -> TimeseriesanomalylstmNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_lstm_node_sum(s : TimeseriesanomalylstmNode) -> Double { @_common.sum(s.data) }

pub fn timeseries_anomaly_lstm_node_mean(s : TimeseriesanomalylstmNode) -> Double { @_common.mean(s.data) }

pub fn timeseries_anomaly_lstm_node_scale(s : TimeseriesanomalylstmNode, f : Double) -> TimeseriesanomalylstmNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_lstm_node_add(a : TimeseriesanomalylstmNode, b : TimeseriesanomalylstmNode) -> TimeseriesanomalylstmNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_anomaly_lstm_node_copy(s : TimeseriesanomalylstmNode) -> TimeseriesanomalylstmNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_lstm_node_fill(s : TimeseriesanomalylstmNode, v : Double) -> TimeseriesanomalylstmNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_lstm_node_min(s : TimeseriesanomalylstmNode) -> Double { @_common.min(s.data) }

pub fn timeseries_anomaly_lstm_node_max(s : TimeseriesanomalylstmNode) -> Double { @_common.max(s.data) }

pub fn timeseries_anomaly_lstm_node_to_string(s : TimeseriesanomalylstmNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesanomalylstmEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_anomaly_lstm_edge_make(size : Int) -> TimeseriesanomalylstmEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_anomaly_lstm_edge_len(s : TimeseriesanomalylstmEdge) -> Int { s.size }

pub fn timeseries_anomaly_lstm_edge_get(s : TimeseriesanomalylstmEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_anomaly_lstm_edge_set(s : TimeseriesanomalylstmEdge, i : Int, v : Double) -> TimeseriesanomalylstmEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_lstm_edge_sum(s : TimeseriesanomalylstmEdge) -> Double { @_common.sum(s.data) }

pub fn timeseries_anomaly_lstm_edge_mean(s : TimeseriesanomalylstmEdge) -> Double { @_common.mean(s.data) }

pub fn timeseries_anomaly_lstm_edge_scale(s : TimeseriesanomalylstmEdge, f : Double) -> TimeseriesanomalylstmEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_lstm_edge_add(a : TimeseriesanomalylstmEdge, b : TimeseriesanomalylstmEdge) -> TimeseriesanomalylstmEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_anomaly_lstm_edge_copy(s : TimeseriesanomalylstmEdge) -> TimeseriesanomalylstmEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_lstm_edge_fill(s : TimeseriesanomalylstmEdge, v : Double) -> TimeseriesanomalylstmEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_lstm_edge_min(s : TimeseriesanomalylstmEdge) -> Double { @_common.min(s.data) }

pub fn timeseries_anomaly_lstm_edge_max(s : TimeseriesanomalylstmEdge) -> Double { @_common.max(s.data) }

pub fn timeseries_anomaly_lstm_edge_to_string(s : TimeseriesanomalylstmEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesanomalylstmPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_anomaly_lstm_path_make(size : Int) -> TimeseriesanomalylstmPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_anomaly_lstm_path_len(s : TimeseriesanomalylstmPath) -> Int { s.size }

pub fn timeseries_anomaly_lstm_path_get(s : TimeseriesanomalylstmPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_anomaly_lstm_path_set(s : TimeseriesanomalylstmPath, i : Int, v : Double) -> TimeseriesanomalylstmPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_lstm_path_sum(s : TimeseriesanomalylstmPath) -> Double { @_common.sum(s.data) }

pub fn timeseries_anomaly_lstm_path_mean(s : TimeseriesanomalylstmPath) -> Double { @_common.mean(s.data) }

pub fn timeseries_anomaly_lstm_path_scale(s : TimeseriesanomalylstmPath, f : Double) -> TimeseriesanomalylstmPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_lstm_path_add(a : TimeseriesanomalylstmPath, b : TimeseriesanomalylstmPath) -> TimeseriesanomalylstmPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_anomaly_lstm_path_copy(s : TimeseriesanomalylstmPath) -> TimeseriesanomalylstmPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_lstm_path_fill(s : TimeseriesanomalylstmPath, v : Double) -> TimeseriesanomalylstmPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_lstm_path_min(s : TimeseriesanomalylstmPath) -> Double { @_common.min(s.data) }

pub fn timeseries_anomaly_lstm_path_max(s : TimeseriesanomalylstmPath) -> Double { @_common.max(s.data) }

pub fn timeseries_anomaly_lstm_path_to_string(s : TimeseriesanomalylstmPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesanomalylstmCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_anomaly_lstm_cluster_make(size : Int) -> TimeseriesanomalylstmCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_anomaly_lstm_cluster_len(s : TimeseriesanomalylstmCluster) -> Int { s.size }

pub fn timeseries_anomaly_lstm_cluster_get(s : TimeseriesanomalylstmCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_anomaly_lstm_cluster_set(s : TimeseriesanomalylstmCluster, i : Int, v : Double) -> TimeseriesanomalylstmCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_lstm_cluster_sum(s : TimeseriesanomalylstmCluster) -> Double { @_common.sum(s.data) }

pub fn timeseries_anomaly_lstm_cluster_mean(s : TimeseriesanomalylstmCluster) -> Double { @_common.mean(s.data) }

pub fn timeseries_anomaly_lstm_cluster_scale(s : TimeseriesanomalylstmCluster, f : Double) -> TimeseriesanomalylstmCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_lstm_cluster_add(a : TimeseriesanomalylstmCluster, b : TimeseriesanomalylstmCluster) -> TimeseriesanomalylstmCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_anomaly_lstm_cluster_copy(s : TimeseriesanomalylstmCluster) -> TimeseriesanomalylstmCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_lstm_cluster_fill(s : TimeseriesanomalylstmCluster, v : Double) -> TimeseriesanomalylstmCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_lstm_cluster_min(s : TimeseriesanomalylstmCluster) -> Double { @_common.min(s.data) }

pub fn timeseries_anomaly_lstm_cluster_max(s : TimeseriesanomalylstmCluster) -> Double { @_common.max(s.data) }

pub fn timeseries_anomaly_lstm_cluster_to_string(s : TimeseriesanomalylstmCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesanomalylstmModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_anomaly_lstm_model_make(size : Int) -> TimeseriesanomalylstmModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_anomaly_lstm_model_len(s : TimeseriesanomalylstmModel) -> Int { s.size }

pub fn timeseries_anomaly_lstm_model_get(s : TimeseriesanomalylstmModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_anomaly_lstm_model_set(s : TimeseriesanomalylstmModel, i : Int, v : Double) -> TimeseriesanomalylstmModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_lstm_model_sum(s : TimeseriesanomalylstmModel) -> Double { @_common.sum(s.data) }

pub fn timeseries_anomaly_lstm_model_mean(s : TimeseriesanomalylstmModel) -> Double { @_common.mean(s.data) }

pub fn timeseries_anomaly_lstm_model_scale(s : TimeseriesanomalylstmModel, f : Double) -> TimeseriesanomalylstmModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_lstm_model_add(a : TimeseriesanomalylstmModel, b : TimeseriesanomalylstmModel) -> TimeseriesanomalylstmModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_anomaly_lstm_model_copy(s : TimeseriesanomalylstmModel) -> TimeseriesanomalylstmModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_lstm_model_fill(s : TimeseriesanomalylstmModel, v : Double) -> TimeseriesanomalylstmModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_lstm_model_min(s : TimeseriesanomalylstmModel) -> Double { @_common.min(s.data) }

pub fn timeseries_anomaly_lstm_model_max(s : TimeseriesanomalylstmModel) -> Double { @_common.max(s.data) }

pub fn timeseries_anomaly_lstm_model_to_string(s : TimeseriesanomalylstmModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesanomalylstmLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_anomaly_lstm_layer_make(size : Int) -> TimeseriesanomalylstmLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_anomaly_lstm_layer_len(s : TimeseriesanomalylstmLayer) -> Int { s.size }

pub fn timeseries_anomaly_lstm_layer_get(s : TimeseriesanomalylstmLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_anomaly_lstm_layer_set(s : TimeseriesanomalylstmLayer, i : Int, v : Double) -> TimeseriesanomalylstmLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_lstm_layer_sum(s : TimeseriesanomalylstmLayer) -> Double { @_common.sum(s.data) }

pub fn timeseries_anomaly_lstm_layer_mean(s : TimeseriesanomalylstmLayer) -> Double { @_common.mean(s.data) }

pub fn timeseries_anomaly_lstm_layer_scale(s : TimeseriesanomalylstmLayer, f : Double) -> TimeseriesanomalylstmLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_lstm_layer_add(a : TimeseriesanomalylstmLayer, b : TimeseriesanomalylstmLayer) -> TimeseriesanomalylstmLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_anomaly_lstm_layer_copy(s : TimeseriesanomalylstmLayer) -> TimeseriesanomalylstmLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_lstm_layer_fill(s : TimeseriesanomalylstmLayer, v : Double) -> TimeseriesanomalylstmLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_lstm_layer_min(s : TimeseriesanomalylstmLayer) -> Double { @_common.min(s.data) }

pub fn timeseries_anomaly_lstm_layer_max(s : TimeseriesanomalylstmLayer) -> Double { @_common.max(s.data) }

pub fn timeseries_anomaly_lstm_layer_to_string(s : TimeseriesanomalylstmLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesanomalylstmBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_anomaly_lstm_buffer_make(size : Int) -> TimeseriesanomalylstmBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_anomaly_lstm_buffer_len(s : TimeseriesanomalylstmBuffer) -> Int { s.size }

pub fn timeseries_anomaly_lstm_buffer_get(s : TimeseriesanomalylstmBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_anomaly_lstm_buffer_set(s : TimeseriesanomalylstmBuffer, i : Int, v : Double) -> TimeseriesanomalylstmBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_lstm_buffer_sum(s : TimeseriesanomalylstmBuffer) -> Double { @_common.sum(s.data) }

pub fn timeseries_anomaly_lstm_buffer_mean(s : TimeseriesanomalylstmBuffer) -> Double { @_common.mean(s.data) }

pub fn timeseries_anomaly_lstm_buffer_scale(s : TimeseriesanomalylstmBuffer, f : Double) -> TimeseriesanomalylstmBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_lstm_buffer_add(a : TimeseriesanomalylstmBuffer, b : TimeseriesanomalylstmBuffer) -> TimeseriesanomalylstmBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_anomaly_lstm_buffer_copy(s : TimeseriesanomalylstmBuffer) -> TimeseriesanomalylstmBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_lstm_buffer_fill(s : TimeseriesanomalylstmBuffer, v : Double) -> TimeseriesanomalylstmBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_lstm_buffer_min(s : TimeseriesanomalylstmBuffer) -> Double { @_common.min(s.data) }

pub fn timeseries_anomaly_lstm_buffer_max(s : TimeseriesanomalylstmBuffer) -> Double { @_common.max(s.data) }

pub fn timeseries_anomaly_lstm_buffer_to_string(s : TimeseriesanomalylstmBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesanomalylstmCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_anomaly_lstm_cursor_make(size : Int) -> TimeseriesanomalylstmCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_anomaly_lstm_cursor_len(s : TimeseriesanomalylstmCursor) -> Int { s.size }

pub fn timeseries_anomaly_lstm_cursor_get(s : TimeseriesanomalylstmCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_anomaly_lstm_cursor_set(s : TimeseriesanomalylstmCursor, i : Int, v : Double) -> TimeseriesanomalylstmCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_lstm_cursor_sum(s : TimeseriesanomalylstmCursor) -> Double { @_common.sum(s.data) }

pub fn timeseries_anomaly_lstm_cursor_mean(s : TimeseriesanomalylstmCursor) -> Double { @_common.mean(s.data) }

pub fn timeseries_anomaly_lstm_cursor_scale(s : TimeseriesanomalylstmCursor, f : Double) -> TimeseriesanomalylstmCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_lstm_cursor_add(a : TimeseriesanomalylstmCursor, b : TimeseriesanomalylstmCursor) -> TimeseriesanomalylstmCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_anomaly_lstm_cursor_copy(s : TimeseriesanomalylstmCursor) -> TimeseriesanomalylstmCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_lstm_cursor_fill(s : TimeseriesanomalylstmCursor, v : Double) -> TimeseriesanomalylstmCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_lstm_cursor_min(s : TimeseriesanomalylstmCursor) -> Double { @_common.min(s.data) }

pub fn timeseries_anomaly_lstm_cursor_max(s : TimeseriesanomalylstmCursor) -> Double { @_common.max(s.data) }

pub fn timeseries_anomaly_lstm_cursor_to_string(s : TimeseriesanomalylstmCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesanomalylstmView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_anomaly_lstm_view_make(size : Int) -> TimeseriesanomalylstmView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_anomaly_lstm_view_len(s : TimeseriesanomalylstmView) -> Int { s.size }

pub fn timeseries_anomaly_lstm_view_get(s : TimeseriesanomalylstmView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_anomaly_lstm_view_set(s : TimeseriesanomalylstmView, i : Int, v : Double) -> TimeseriesanomalylstmView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_lstm_view_sum(s : TimeseriesanomalylstmView) -> Double { @_common.sum(s.data) }

pub fn timeseries_anomaly_lstm_view_mean(s : TimeseriesanomalylstmView) -> Double { @_common.mean(s.data) }

pub fn timeseries_anomaly_lstm_view_scale(s : TimeseriesanomalylstmView, f : Double) -> TimeseriesanomalylstmView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_lstm_view_add(a : TimeseriesanomalylstmView, b : TimeseriesanomalylstmView) -> TimeseriesanomalylstmView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_anomaly_lstm_view_copy(s : TimeseriesanomalylstmView) -> TimeseriesanomalylstmView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_lstm_view_fill(s : TimeseriesanomalylstmView, v : Double) -> TimeseriesanomalylstmView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_lstm_view_min(s : TimeseriesanomalylstmView) -> Double { @_common.min(s.data) }

pub fn timeseries_anomaly_lstm_view_max(s : TimeseriesanomalylstmView) -> Double { @_common.max(s.data) }

pub fn timeseries_anomaly_lstm_view_to_string(s : TimeseriesanomalylstmView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesanomalylstmRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_anomaly_lstm_range_make(size : Int) -> TimeseriesanomalylstmRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_anomaly_lstm_range_len(s : TimeseriesanomalylstmRange) -> Int { s.size }

pub fn timeseries_anomaly_lstm_range_get(s : TimeseriesanomalylstmRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_anomaly_lstm_range_set(s : TimeseriesanomalylstmRange, i : Int, v : Double) -> TimeseriesanomalylstmRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_lstm_range_sum(s : TimeseriesanomalylstmRange) -> Double { @_common.sum(s.data) }

pub fn timeseries_anomaly_lstm_range_mean(s : TimeseriesanomalylstmRange) -> Double { @_common.mean(s.data) }

pub fn timeseries_anomaly_lstm_range_scale(s : TimeseriesanomalylstmRange, f : Double) -> TimeseriesanomalylstmRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_lstm_range_add(a : TimeseriesanomalylstmRange, b : TimeseriesanomalylstmRange) -> TimeseriesanomalylstmRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_anomaly_lstm_range_copy(s : TimeseriesanomalylstmRange) -> TimeseriesanomalylstmRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_lstm_range_fill(s : TimeseriesanomalylstmRange, v : Double) -> TimeseriesanomalylstmRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_lstm_range_min(s : TimeseriesanomalylstmRange) -> Double { @_common.min(s.data) }

pub fn timeseries_anomaly_lstm_range_max(s : TimeseriesanomalylstmRange) -> Double { @_common.max(s.data) }

pub fn timeseries_anomaly_lstm_range_to_string(s : TimeseriesanomalylstmRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesanomalylstmSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_anomaly_lstm_slice_make(size : Int) -> TimeseriesanomalylstmSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_anomaly_lstm_slice_len(s : TimeseriesanomalylstmSlice) -> Int { s.size }

pub fn timeseries_anomaly_lstm_slice_get(s : TimeseriesanomalylstmSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_anomaly_lstm_slice_set(s : TimeseriesanomalylstmSlice, i : Int, v : Double) -> TimeseriesanomalylstmSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_lstm_slice_sum(s : TimeseriesanomalylstmSlice) -> Double { @_common.sum(s.data) }

pub fn timeseries_anomaly_lstm_slice_mean(s : TimeseriesanomalylstmSlice) -> Double { @_common.mean(s.data) }

pub fn timeseries_anomaly_lstm_slice_scale(s : TimeseriesanomalylstmSlice, f : Double) -> TimeseriesanomalylstmSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_lstm_slice_add(a : TimeseriesanomalylstmSlice, b : TimeseriesanomalylstmSlice) -> TimeseriesanomalylstmSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_anomaly_lstm_slice_copy(s : TimeseriesanomalylstmSlice) -> TimeseriesanomalylstmSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_lstm_slice_fill(s : TimeseriesanomalylstmSlice, v : Double) -> TimeseriesanomalylstmSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_lstm_slice_min(s : TimeseriesanomalylstmSlice) -> Double { @_common.min(s.data) }

pub fn timeseries_anomaly_lstm_slice_max(s : TimeseriesanomalylstmSlice) -> Double { @_common.max(s.data) }

pub fn timeseries_anomaly_lstm_slice_to_string(s : TimeseriesanomalylstmSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

