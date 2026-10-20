///===
/// extcore/timeseries_anomaly_iqr

pub(all) struct TimeseriesanomalyiqrPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn timeseries_anomaly_iqr_make_point(x : Double, y : Double) -> TimeseriesanomalyiqrPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn timeseries_anomaly_iqr_make_point3(x : Double, y : Double, z : Double) -> TimeseriesanomalyiqrPoint {
  { x, y, z, label: 0 }
}

pub fn TimeseriesanomalyiqrPoint::x(self : TimeseriesanomalyiqrPoint) -> Double { self.x }

pub fn TimeseriesanomalyiqrPoint::y(self : TimeseriesanomalyiqrPoint) -> Double { self.y }

pub fn TimeseriesanomalyiqrPoint::z(self : TimeseriesanomalyiqrPoint) -> Double { self.z }

pub fn TimeseriesanomalyiqrPoint::label(self : TimeseriesanomalyiqrPoint) -> Int { self.label }

pub fn TimeseriesanomalyiqrPoint::dist(self : TimeseriesanomalyiqrPoint, other : TimeseriesanomalyiqrPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn TimeseriesanomalyiqrPoint::add(self : TimeseriesanomalyiqrPoint, other : TimeseriesanomalyiqrPoint) -> TimeseriesanomalyiqrPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn TimeseriesanomalyiqrPoint::sub(self : TimeseriesanomalyiqrPoint, other : TimeseriesanomalyiqrPoint) -> TimeseriesanomalyiqrPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn TimeseriesanomalyiqrPoint::scale(self : TimeseriesanomalyiqrPoint, s : Double) -> TimeseriesanomalyiqrPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn TimeseriesanomalyiqrPoint::dot(self : TimeseriesanomalyiqrPoint, other : TimeseriesanomalyiqrPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn TimeseriesanomalyiqrPoint::cross(self : TimeseriesanomalyiqrPoint, other : TimeseriesanomalyiqrPoint) -> TimeseriesanomalyiqrPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn TimeseriesanomalyiqrPoint::norm(self : TimeseriesanomalyiqrPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn TimeseriesanomalyiqrPoint::normalize(self : TimeseriesanomalyiqrPoint) -> TimeseriesanomalyiqrPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn TimeseriesanomalyiqrPoint::negate(self : TimeseriesanomalyiqrPoint) -> TimeseriesanomalyiqrPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn TimeseriesanomalyiqrPoint::mid(self : TimeseriesanomalyiqrPoint, other : TimeseriesanomalyiqrPoint) -> TimeseriesanomalyiqrPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn TimeseriesanomalyiqrPoint::lerp(self : TimeseriesanomalyiqrPoint, other : TimeseriesanomalyiqrPoint, t : Double) -> TimeseriesanomalyiqrPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn TimeseriesanomalyiqrPoint::to_string(self : TimeseriesanomalyiqrPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct TimeseriesanomalyiqrSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn timeseries_anomaly_iqr_make_series(vals : Array[Double], name : String) -> TimeseriesanomalyiqrSeries {
  { vals, name, meta: 0 }
}

pub fn TimeseriesanomalyiqrSeries::len(self : TimeseriesanomalyiqrSeries) -> Int { self.vals.length() }

pub fn TimeseriesanomalyiqrSeries::sum(self : TimeseriesanomalyiqrSeries) -> Double { @_common.sum(self.vals) }

pub fn TimeseriesanomalyiqrSeries::mean(self : TimeseriesanomalyiqrSeries) -> Double { @_common.mean(self.vals) }

pub fn TimeseriesanomalyiqrSeries::min(self : TimeseriesanomalyiqrSeries) -> Double { @_common.min(self.vals) }

pub fn TimeseriesanomalyiqrSeries::max(self : TimeseriesanomalyiqrSeries) -> Double { @_common.max(self.vals) }

pub fn TimeseriesanomalyiqrSeries::range(self : TimeseriesanomalyiqrSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn TimeseriesanomalyiqrSeries::variance(self : TimeseriesanomalyiqrSeries) -> Double { @_common.variance(self.vals) }

pub fn TimeseriesanomalyiqrSeries::std(self : TimeseriesanomalyiqrSeries) -> Double { @_common.std(self.vals) }

pub fn TimeseriesanomalyiqrSeries::median(self : TimeseriesanomalyiqrSeries) -> Double { @_common.median(self.vals) }

pub fn TimeseriesanomalyiqrSeries::scale(self : TimeseriesanomalyiqrSeries, f : Double) -> TimeseriesanomalyiqrSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn TimeseriesanomalyiqrSeries::add(self : TimeseriesanomalyiqrSeries, other : TimeseriesanomalyiqrSeries) -> TimeseriesanomalyiqrSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn TimeseriesanomalyiqrSeries::sub(self : TimeseriesanomalyiqrSeries, other : TimeseriesanomalyiqrSeries) -> TimeseriesanomalyiqrSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn TimeseriesanomalyiqrSeries::normalize(self : TimeseriesanomalyiqrSeries) -> TimeseriesanomalyiqrSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn TimeseriesanomalyiqrSeries::cumsum(self : TimeseriesanomalyiqrSeries) -> TimeseriesanomalyiqrSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn TimeseriesanomalyiqrSeries::to_string(self : TimeseriesanomalyiqrSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct TimeseriesanomalyiqrMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn timeseries_anomaly_iqr_make_matrix(rows : Int, cols : Int, val : Double) -> TimeseriesanomalyiqrMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn timeseries_anomaly_iqr_matrix_identity(n : Int) -> TimeseriesanomalyiqrMatrix {
  let m = timeseries_anomaly_iqr_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn TimeseriesanomalyiqrMatrix::get(self : TimeseriesanomalyiqrMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn TimeseriesanomalyiqrMatrix::transpose(self : TimeseriesanomalyiqrMatrix) -> TimeseriesanomalyiqrMatrix {
  let result = timeseries_anomaly_iqr_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn TimeseriesanomalyiqrMatrix::add(self : TimeseriesanomalyiqrMatrix, other : TimeseriesanomalyiqrMatrix) -> TimeseriesanomalyiqrMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = timeseries_anomaly_iqr_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn TimeseriesanomalyiqrMatrix::scale(self : TimeseriesanomalyiqrMatrix, s : Double) -> TimeseriesanomalyiqrMatrix {
  let result = timeseries_anomaly_iqr_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn TimeseriesanomalyiqrMatrix::multiply(self : TimeseriesanomalyiqrMatrix, other : TimeseriesanomalyiqrMatrix) -> TimeseriesanomalyiqrMatrix {
  if self.cols != other.rows { return timeseries_anomaly_iqr_make_matrix(self.rows, other.cols, 0.0) }
  let result = timeseries_anomaly_iqr_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn TimeseriesanomalyiqrMatrix::trace(self : TimeseriesanomalyiqrMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn TimeseriesanomalyiqrMatrix::det(self : TimeseriesanomalyiqrMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn TimeseriesanomalyiqrMatrix::norm(self : TimeseriesanomalyiqrMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn TimeseriesanomalyiqrMatrix::to_string(self : TimeseriesanomalyiqrMatrix) -> String {
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

pub(all) struct TimeseriesanomalyiqrVector {
  comps : Array[Double]
  dim : Int
}

pub fn timeseries_anomaly_iqr_make_vector(comps : Array[Double]) -> TimeseriesanomalyiqrVector {
  { comps, dim: comps.length() }
}

pub fn timeseries_anomaly_iqr_vector_zero(dim : Int) -> TimeseriesanomalyiqrVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn TimeseriesanomalyiqrVector::add(self : TimeseriesanomalyiqrVector, other : TimeseriesanomalyiqrVector) -> TimeseriesanomalyiqrVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn TimeseriesanomalyiqrVector::sub(self : TimeseriesanomalyiqrVector, other : TimeseriesanomalyiqrVector) -> TimeseriesanomalyiqrVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn TimeseriesanomalyiqrVector::scale(self : TimeseriesanomalyiqrVector, s : Double) -> TimeseriesanomalyiqrVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn TimeseriesanomalyiqrVector::dot(self : TimeseriesanomalyiqrVector, other : TimeseriesanomalyiqrVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn TimeseriesanomalyiqrVector::norm(self : TimeseriesanomalyiqrVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn TimeseriesanomalyiqrVector::normalize(self : TimeseriesanomalyiqrVector) -> TimeseriesanomalyiqrVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn TimeseriesanomalyiqrVector::dist(self : TimeseriesanomalyiqrVector, other : TimeseriesanomalyiqrVector) -> Double {
  self.sub(other).norm()
}

pub fn TimeseriesanomalyiqrVector::to_string(self : TimeseriesanomalyiqrVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn timeseries_anomaly_iqr_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn timeseries_anomaly_iqr_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn timeseries_anomaly_iqr_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn timeseries_anomaly_iqr_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn timeseries_anomaly_iqr_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn timeseries_anomaly_iqr_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn timeseries_anomaly_iqr_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn timeseries_anomaly_iqr_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn timeseries_anomaly_iqr_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn timeseries_anomaly_iqr_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn timeseries_anomaly_iqr_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn timeseries_anomaly_iqr_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn timeseries_anomaly_iqr_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn timeseries_anomaly_iqr_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn timeseries_anomaly_iqr_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn timeseries_anomaly_iqr_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn timeseries_anomaly_iqr_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn timeseries_anomaly_iqr_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn timeseries_anomaly_iqr_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn timeseries_anomaly_iqr_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn timeseries_anomaly_iqr_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn timeseries_anomaly_iqr_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn timeseries_anomaly_iqr_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn timeseries_anomaly_iqr_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn timeseries_anomaly_iqr_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn timeseries_anomaly_iqr_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn timeseries_anomaly_iqr_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn timeseries_anomaly_iqr_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn timeseries_anomaly_iqr_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct TimeseriesanomalyiqrFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_anomaly_iqr_frame_make(size : Int) -> TimeseriesanomalyiqrFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_anomaly_iqr_frame_len(s : TimeseriesanomalyiqrFrame) -> Int { s.size }

pub fn timeseries_anomaly_iqr_frame_get(s : TimeseriesanomalyiqrFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_anomaly_iqr_frame_set(s : TimeseriesanomalyiqrFrame, i : Int, v : Double) -> TimeseriesanomalyiqrFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_iqr_frame_sum(s : TimeseriesanomalyiqrFrame) -> Double { @_common.sum(s.data) }

pub fn timeseries_anomaly_iqr_frame_mean(s : TimeseriesanomalyiqrFrame) -> Double { @_common.mean(s.data) }

pub fn timeseries_anomaly_iqr_frame_scale(s : TimeseriesanomalyiqrFrame, f : Double) -> TimeseriesanomalyiqrFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_iqr_frame_add(a : TimeseriesanomalyiqrFrame, b : TimeseriesanomalyiqrFrame) -> TimeseriesanomalyiqrFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_anomaly_iqr_frame_copy(s : TimeseriesanomalyiqrFrame) -> TimeseriesanomalyiqrFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_iqr_frame_fill(s : TimeseriesanomalyiqrFrame, v : Double) -> TimeseriesanomalyiqrFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_iqr_frame_min(s : TimeseriesanomalyiqrFrame) -> Double { @_common.min(s.data) }

pub fn timeseries_anomaly_iqr_frame_max(s : TimeseriesanomalyiqrFrame) -> Double { @_common.max(s.data) }

pub fn timeseries_anomaly_iqr_frame_to_string(s : TimeseriesanomalyiqrFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesanomalyiqrTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_anomaly_iqr_table_make(size : Int) -> TimeseriesanomalyiqrTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_anomaly_iqr_table_len(s : TimeseriesanomalyiqrTable) -> Int { s.size }

pub fn timeseries_anomaly_iqr_table_get(s : TimeseriesanomalyiqrTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_anomaly_iqr_table_set(s : TimeseriesanomalyiqrTable, i : Int, v : Double) -> TimeseriesanomalyiqrTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_iqr_table_sum(s : TimeseriesanomalyiqrTable) -> Double { @_common.sum(s.data) }

pub fn timeseries_anomaly_iqr_table_mean(s : TimeseriesanomalyiqrTable) -> Double { @_common.mean(s.data) }

pub fn timeseries_anomaly_iqr_table_scale(s : TimeseriesanomalyiqrTable, f : Double) -> TimeseriesanomalyiqrTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_iqr_table_add(a : TimeseriesanomalyiqrTable, b : TimeseriesanomalyiqrTable) -> TimeseriesanomalyiqrTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_anomaly_iqr_table_copy(s : TimeseriesanomalyiqrTable) -> TimeseriesanomalyiqrTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_iqr_table_fill(s : TimeseriesanomalyiqrTable, v : Double) -> TimeseriesanomalyiqrTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_iqr_table_min(s : TimeseriesanomalyiqrTable) -> Double { @_common.min(s.data) }

pub fn timeseries_anomaly_iqr_table_max(s : TimeseriesanomalyiqrTable) -> Double { @_common.max(s.data) }

pub fn timeseries_anomaly_iqr_table_to_string(s : TimeseriesanomalyiqrTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesanomalyiqrGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_anomaly_iqr_graphn_make(size : Int) -> TimeseriesanomalyiqrGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_anomaly_iqr_graphn_len(s : TimeseriesanomalyiqrGraphN) -> Int { s.size }

pub fn timeseries_anomaly_iqr_graphn_get(s : TimeseriesanomalyiqrGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_anomaly_iqr_graphn_set(s : TimeseriesanomalyiqrGraphN, i : Int, v : Double) -> TimeseriesanomalyiqrGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_iqr_graphn_sum(s : TimeseriesanomalyiqrGraphN) -> Double { @_common.sum(s.data) }

pub fn timeseries_anomaly_iqr_graphn_mean(s : TimeseriesanomalyiqrGraphN) -> Double { @_common.mean(s.data) }

pub fn timeseries_anomaly_iqr_graphn_scale(s : TimeseriesanomalyiqrGraphN, f : Double) -> TimeseriesanomalyiqrGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_iqr_graphn_add(a : TimeseriesanomalyiqrGraphN, b : TimeseriesanomalyiqrGraphN) -> TimeseriesanomalyiqrGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_anomaly_iqr_graphn_copy(s : TimeseriesanomalyiqrGraphN) -> TimeseriesanomalyiqrGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_iqr_graphn_fill(s : TimeseriesanomalyiqrGraphN, v : Double) -> TimeseriesanomalyiqrGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_iqr_graphn_min(s : TimeseriesanomalyiqrGraphN) -> Double { @_common.min(s.data) }

pub fn timeseries_anomaly_iqr_graphn_max(s : TimeseriesanomalyiqrGraphN) -> Double { @_common.max(s.data) }

pub fn timeseries_anomaly_iqr_graphn_to_string(s : TimeseriesanomalyiqrGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesanomalyiqrNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_anomaly_iqr_node_make(size : Int) -> TimeseriesanomalyiqrNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_anomaly_iqr_node_len(s : TimeseriesanomalyiqrNode) -> Int { s.size }

pub fn timeseries_anomaly_iqr_node_get(s : TimeseriesanomalyiqrNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_anomaly_iqr_node_set(s : TimeseriesanomalyiqrNode, i : Int, v : Double) -> TimeseriesanomalyiqrNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_iqr_node_sum(s : TimeseriesanomalyiqrNode) -> Double { @_common.sum(s.data) }

pub fn timeseries_anomaly_iqr_node_mean(s : TimeseriesanomalyiqrNode) -> Double { @_common.mean(s.data) }

pub fn timeseries_anomaly_iqr_node_scale(s : TimeseriesanomalyiqrNode, f : Double) -> TimeseriesanomalyiqrNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_iqr_node_add(a : TimeseriesanomalyiqrNode, b : TimeseriesanomalyiqrNode) -> TimeseriesanomalyiqrNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_anomaly_iqr_node_copy(s : TimeseriesanomalyiqrNode) -> TimeseriesanomalyiqrNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_iqr_node_fill(s : TimeseriesanomalyiqrNode, v : Double) -> TimeseriesanomalyiqrNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_iqr_node_min(s : TimeseriesanomalyiqrNode) -> Double { @_common.min(s.data) }

pub fn timeseries_anomaly_iqr_node_max(s : TimeseriesanomalyiqrNode) -> Double { @_common.max(s.data) }

pub fn timeseries_anomaly_iqr_node_to_string(s : TimeseriesanomalyiqrNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesanomalyiqrEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_anomaly_iqr_edge_make(size : Int) -> TimeseriesanomalyiqrEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_anomaly_iqr_edge_len(s : TimeseriesanomalyiqrEdge) -> Int { s.size }

pub fn timeseries_anomaly_iqr_edge_get(s : TimeseriesanomalyiqrEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_anomaly_iqr_edge_set(s : TimeseriesanomalyiqrEdge, i : Int, v : Double) -> TimeseriesanomalyiqrEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_iqr_edge_sum(s : TimeseriesanomalyiqrEdge) -> Double { @_common.sum(s.data) }

pub fn timeseries_anomaly_iqr_edge_mean(s : TimeseriesanomalyiqrEdge) -> Double { @_common.mean(s.data) }

pub fn timeseries_anomaly_iqr_edge_scale(s : TimeseriesanomalyiqrEdge, f : Double) -> TimeseriesanomalyiqrEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_iqr_edge_add(a : TimeseriesanomalyiqrEdge, b : TimeseriesanomalyiqrEdge) -> TimeseriesanomalyiqrEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_anomaly_iqr_edge_copy(s : TimeseriesanomalyiqrEdge) -> TimeseriesanomalyiqrEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_iqr_edge_fill(s : TimeseriesanomalyiqrEdge, v : Double) -> TimeseriesanomalyiqrEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_iqr_edge_min(s : TimeseriesanomalyiqrEdge) -> Double { @_common.min(s.data) }

pub fn timeseries_anomaly_iqr_edge_max(s : TimeseriesanomalyiqrEdge) -> Double { @_common.max(s.data) }

pub fn timeseries_anomaly_iqr_edge_to_string(s : TimeseriesanomalyiqrEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesanomalyiqrPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_anomaly_iqr_path_make(size : Int) -> TimeseriesanomalyiqrPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_anomaly_iqr_path_len(s : TimeseriesanomalyiqrPath) -> Int { s.size }

pub fn timeseries_anomaly_iqr_path_get(s : TimeseriesanomalyiqrPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_anomaly_iqr_path_set(s : TimeseriesanomalyiqrPath, i : Int, v : Double) -> TimeseriesanomalyiqrPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_iqr_path_sum(s : TimeseriesanomalyiqrPath) -> Double { @_common.sum(s.data) }

pub fn timeseries_anomaly_iqr_path_mean(s : TimeseriesanomalyiqrPath) -> Double { @_common.mean(s.data) }

pub fn timeseries_anomaly_iqr_path_scale(s : TimeseriesanomalyiqrPath, f : Double) -> TimeseriesanomalyiqrPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_iqr_path_add(a : TimeseriesanomalyiqrPath, b : TimeseriesanomalyiqrPath) -> TimeseriesanomalyiqrPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_anomaly_iqr_path_copy(s : TimeseriesanomalyiqrPath) -> TimeseriesanomalyiqrPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_iqr_path_fill(s : TimeseriesanomalyiqrPath, v : Double) -> TimeseriesanomalyiqrPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_iqr_path_min(s : TimeseriesanomalyiqrPath) -> Double { @_common.min(s.data) }

pub fn timeseries_anomaly_iqr_path_max(s : TimeseriesanomalyiqrPath) -> Double { @_common.max(s.data) }

pub fn timeseries_anomaly_iqr_path_to_string(s : TimeseriesanomalyiqrPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesanomalyiqrCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_anomaly_iqr_cluster_make(size : Int) -> TimeseriesanomalyiqrCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_anomaly_iqr_cluster_len(s : TimeseriesanomalyiqrCluster) -> Int { s.size }

pub fn timeseries_anomaly_iqr_cluster_get(s : TimeseriesanomalyiqrCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_anomaly_iqr_cluster_set(s : TimeseriesanomalyiqrCluster, i : Int, v : Double) -> TimeseriesanomalyiqrCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_iqr_cluster_sum(s : TimeseriesanomalyiqrCluster) -> Double { @_common.sum(s.data) }

pub fn timeseries_anomaly_iqr_cluster_mean(s : TimeseriesanomalyiqrCluster) -> Double { @_common.mean(s.data) }

pub fn timeseries_anomaly_iqr_cluster_scale(s : TimeseriesanomalyiqrCluster, f : Double) -> TimeseriesanomalyiqrCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_iqr_cluster_add(a : TimeseriesanomalyiqrCluster, b : TimeseriesanomalyiqrCluster) -> TimeseriesanomalyiqrCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_anomaly_iqr_cluster_copy(s : TimeseriesanomalyiqrCluster) -> TimeseriesanomalyiqrCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_iqr_cluster_fill(s : TimeseriesanomalyiqrCluster, v : Double) -> TimeseriesanomalyiqrCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_iqr_cluster_min(s : TimeseriesanomalyiqrCluster) -> Double { @_common.min(s.data) }

pub fn timeseries_anomaly_iqr_cluster_max(s : TimeseriesanomalyiqrCluster) -> Double { @_common.max(s.data) }

pub fn timeseries_anomaly_iqr_cluster_to_string(s : TimeseriesanomalyiqrCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesanomalyiqrModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_anomaly_iqr_model_make(size : Int) -> TimeseriesanomalyiqrModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_anomaly_iqr_model_len(s : TimeseriesanomalyiqrModel) -> Int { s.size }

pub fn timeseries_anomaly_iqr_model_get(s : TimeseriesanomalyiqrModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_anomaly_iqr_model_set(s : TimeseriesanomalyiqrModel, i : Int, v : Double) -> TimeseriesanomalyiqrModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_iqr_model_sum(s : TimeseriesanomalyiqrModel) -> Double { @_common.sum(s.data) }

pub fn timeseries_anomaly_iqr_model_mean(s : TimeseriesanomalyiqrModel) -> Double { @_common.mean(s.data) }

pub fn timeseries_anomaly_iqr_model_scale(s : TimeseriesanomalyiqrModel, f : Double) -> TimeseriesanomalyiqrModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_iqr_model_add(a : TimeseriesanomalyiqrModel, b : TimeseriesanomalyiqrModel) -> TimeseriesanomalyiqrModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_anomaly_iqr_model_copy(s : TimeseriesanomalyiqrModel) -> TimeseriesanomalyiqrModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_iqr_model_fill(s : TimeseriesanomalyiqrModel, v : Double) -> TimeseriesanomalyiqrModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_iqr_model_min(s : TimeseriesanomalyiqrModel) -> Double { @_common.min(s.data) }

pub fn timeseries_anomaly_iqr_model_max(s : TimeseriesanomalyiqrModel) -> Double { @_common.max(s.data) }

pub fn timeseries_anomaly_iqr_model_to_string(s : TimeseriesanomalyiqrModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesanomalyiqrLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_anomaly_iqr_layer_make(size : Int) -> TimeseriesanomalyiqrLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_anomaly_iqr_layer_len(s : TimeseriesanomalyiqrLayer) -> Int { s.size }

pub fn timeseries_anomaly_iqr_layer_get(s : TimeseriesanomalyiqrLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_anomaly_iqr_layer_set(s : TimeseriesanomalyiqrLayer, i : Int, v : Double) -> TimeseriesanomalyiqrLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_iqr_layer_sum(s : TimeseriesanomalyiqrLayer) -> Double { @_common.sum(s.data) }

pub fn timeseries_anomaly_iqr_layer_mean(s : TimeseriesanomalyiqrLayer) -> Double { @_common.mean(s.data) }

pub fn timeseries_anomaly_iqr_layer_scale(s : TimeseriesanomalyiqrLayer, f : Double) -> TimeseriesanomalyiqrLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_iqr_layer_add(a : TimeseriesanomalyiqrLayer, b : TimeseriesanomalyiqrLayer) -> TimeseriesanomalyiqrLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_anomaly_iqr_layer_copy(s : TimeseriesanomalyiqrLayer) -> TimeseriesanomalyiqrLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_iqr_layer_fill(s : TimeseriesanomalyiqrLayer, v : Double) -> TimeseriesanomalyiqrLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_iqr_layer_min(s : TimeseriesanomalyiqrLayer) -> Double { @_common.min(s.data) }

pub fn timeseries_anomaly_iqr_layer_max(s : TimeseriesanomalyiqrLayer) -> Double { @_common.max(s.data) }

pub fn timeseries_anomaly_iqr_layer_to_string(s : TimeseriesanomalyiqrLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesanomalyiqrBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_anomaly_iqr_buffer_make(size : Int) -> TimeseriesanomalyiqrBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_anomaly_iqr_buffer_len(s : TimeseriesanomalyiqrBuffer) -> Int { s.size }

pub fn timeseries_anomaly_iqr_buffer_get(s : TimeseriesanomalyiqrBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_anomaly_iqr_buffer_set(s : TimeseriesanomalyiqrBuffer, i : Int, v : Double) -> TimeseriesanomalyiqrBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_iqr_buffer_sum(s : TimeseriesanomalyiqrBuffer) -> Double { @_common.sum(s.data) }

pub fn timeseries_anomaly_iqr_buffer_mean(s : TimeseriesanomalyiqrBuffer) -> Double { @_common.mean(s.data) }

pub fn timeseries_anomaly_iqr_buffer_scale(s : TimeseriesanomalyiqrBuffer, f : Double) -> TimeseriesanomalyiqrBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_iqr_buffer_add(a : TimeseriesanomalyiqrBuffer, b : TimeseriesanomalyiqrBuffer) -> TimeseriesanomalyiqrBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_anomaly_iqr_buffer_copy(s : TimeseriesanomalyiqrBuffer) -> TimeseriesanomalyiqrBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_iqr_buffer_fill(s : TimeseriesanomalyiqrBuffer, v : Double) -> TimeseriesanomalyiqrBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_iqr_buffer_min(s : TimeseriesanomalyiqrBuffer) -> Double { @_common.min(s.data) }

pub fn timeseries_anomaly_iqr_buffer_max(s : TimeseriesanomalyiqrBuffer) -> Double { @_common.max(s.data) }

pub fn timeseries_anomaly_iqr_buffer_to_string(s : TimeseriesanomalyiqrBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesanomalyiqrCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_anomaly_iqr_cursor_make(size : Int) -> TimeseriesanomalyiqrCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_anomaly_iqr_cursor_len(s : TimeseriesanomalyiqrCursor) -> Int { s.size }

pub fn timeseries_anomaly_iqr_cursor_get(s : TimeseriesanomalyiqrCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_anomaly_iqr_cursor_set(s : TimeseriesanomalyiqrCursor, i : Int, v : Double) -> TimeseriesanomalyiqrCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_iqr_cursor_sum(s : TimeseriesanomalyiqrCursor) -> Double { @_common.sum(s.data) }

pub fn timeseries_anomaly_iqr_cursor_mean(s : TimeseriesanomalyiqrCursor) -> Double { @_common.mean(s.data) }

pub fn timeseries_anomaly_iqr_cursor_scale(s : TimeseriesanomalyiqrCursor, f : Double) -> TimeseriesanomalyiqrCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_iqr_cursor_add(a : TimeseriesanomalyiqrCursor, b : TimeseriesanomalyiqrCursor) -> TimeseriesanomalyiqrCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_anomaly_iqr_cursor_copy(s : TimeseriesanomalyiqrCursor) -> TimeseriesanomalyiqrCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_iqr_cursor_fill(s : TimeseriesanomalyiqrCursor, v : Double) -> TimeseriesanomalyiqrCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_iqr_cursor_min(s : TimeseriesanomalyiqrCursor) -> Double { @_common.min(s.data) }

pub fn timeseries_anomaly_iqr_cursor_max(s : TimeseriesanomalyiqrCursor) -> Double { @_common.max(s.data) }

pub fn timeseries_anomaly_iqr_cursor_to_string(s : TimeseriesanomalyiqrCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesanomalyiqrView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_anomaly_iqr_view_make(size : Int) -> TimeseriesanomalyiqrView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_anomaly_iqr_view_len(s : TimeseriesanomalyiqrView) -> Int { s.size }

pub fn timeseries_anomaly_iqr_view_get(s : TimeseriesanomalyiqrView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_anomaly_iqr_view_set(s : TimeseriesanomalyiqrView, i : Int, v : Double) -> TimeseriesanomalyiqrView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_iqr_view_sum(s : TimeseriesanomalyiqrView) -> Double { @_common.sum(s.data) }

pub fn timeseries_anomaly_iqr_view_mean(s : TimeseriesanomalyiqrView) -> Double { @_common.mean(s.data) }

pub fn timeseries_anomaly_iqr_view_scale(s : TimeseriesanomalyiqrView, f : Double) -> TimeseriesanomalyiqrView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_iqr_view_add(a : TimeseriesanomalyiqrView, b : TimeseriesanomalyiqrView) -> TimeseriesanomalyiqrView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_anomaly_iqr_view_copy(s : TimeseriesanomalyiqrView) -> TimeseriesanomalyiqrView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_iqr_view_fill(s : TimeseriesanomalyiqrView, v : Double) -> TimeseriesanomalyiqrView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_iqr_view_min(s : TimeseriesanomalyiqrView) -> Double { @_common.min(s.data) }

pub fn timeseries_anomaly_iqr_view_max(s : TimeseriesanomalyiqrView) -> Double { @_common.max(s.data) }

pub fn timeseries_anomaly_iqr_view_to_string(s : TimeseriesanomalyiqrView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesanomalyiqrRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_anomaly_iqr_range_make(size : Int) -> TimeseriesanomalyiqrRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_anomaly_iqr_range_len(s : TimeseriesanomalyiqrRange) -> Int { s.size }

pub fn timeseries_anomaly_iqr_range_get(s : TimeseriesanomalyiqrRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_anomaly_iqr_range_set(s : TimeseriesanomalyiqrRange, i : Int, v : Double) -> TimeseriesanomalyiqrRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_iqr_range_sum(s : TimeseriesanomalyiqrRange) -> Double { @_common.sum(s.data) }

pub fn timeseries_anomaly_iqr_range_mean(s : TimeseriesanomalyiqrRange) -> Double { @_common.mean(s.data) }

pub fn timeseries_anomaly_iqr_range_scale(s : TimeseriesanomalyiqrRange, f : Double) -> TimeseriesanomalyiqrRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_iqr_range_add(a : TimeseriesanomalyiqrRange, b : TimeseriesanomalyiqrRange) -> TimeseriesanomalyiqrRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_anomaly_iqr_range_copy(s : TimeseriesanomalyiqrRange) -> TimeseriesanomalyiqrRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_iqr_range_fill(s : TimeseriesanomalyiqrRange, v : Double) -> TimeseriesanomalyiqrRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_iqr_range_min(s : TimeseriesanomalyiqrRange) -> Double { @_common.min(s.data) }

pub fn timeseries_anomaly_iqr_range_max(s : TimeseriesanomalyiqrRange) -> Double { @_common.max(s.data) }

pub fn timeseries_anomaly_iqr_range_to_string(s : TimeseriesanomalyiqrRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesanomalyiqrSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_anomaly_iqr_slice_make(size : Int) -> TimeseriesanomalyiqrSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_anomaly_iqr_slice_len(s : TimeseriesanomalyiqrSlice) -> Int { s.size }

pub fn timeseries_anomaly_iqr_slice_get(s : TimeseriesanomalyiqrSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_anomaly_iqr_slice_set(s : TimeseriesanomalyiqrSlice, i : Int, v : Double) -> TimeseriesanomalyiqrSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_iqr_slice_sum(s : TimeseriesanomalyiqrSlice) -> Double { @_common.sum(s.data) }

pub fn timeseries_anomaly_iqr_slice_mean(s : TimeseriesanomalyiqrSlice) -> Double { @_common.mean(s.data) }

pub fn timeseries_anomaly_iqr_slice_scale(s : TimeseriesanomalyiqrSlice, f : Double) -> TimeseriesanomalyiqrSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_iqr_slice_add(a : TimeseriesanomalyiqrSlice, b : TimeseriesanomalyiqrSlice) -> TimeseriesanomalyiqrSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_anomaly_iqr_slice_copy(s : TimeseriesanomalyiqrSlice) -> TimeseriesanomalyiqrSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_iqr_slice_fill(s : TimeseriesanomalyiqrSlice, v : Double) -> TimeseriesanomalyiqrSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_iqr_slice_min(s : TimeseriesanomalyiqrSlice) -> Double { @_common.min(s.data) }

pub fn timeseries_anomaly_iqr_slice_max(s : TimeseriesanomalyiqrSlice) -> Double { @_common.max(s.data) }

pub fn timeseries_anomaly_iqr_slice_to_string(s : TimeseriesanomalyiqrSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

