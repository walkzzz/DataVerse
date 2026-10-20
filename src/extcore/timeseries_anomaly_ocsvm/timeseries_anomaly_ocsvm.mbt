///===
/// extcore/timeseries_anomaly_ocsvm

pub(all) struct TimeseriesanomalyocsvmPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn timeseries_anomaly_ocsvm_make_point(x : Double, y : Double) -> TimeseriesanomalyocsvmPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn timeseries_anomaly_ocsvm_make_point3(x : Double, y : Double, z : Double) -> TimeseriesanomalyocsvmPoint {
  { x, y, z, label: 0 }
}

pub fn TimeseriesanomalyocsvmPoint::x(self : TimeseriesanomalyocsvmPoint) -> Double { self.x }

pub fn TimeseriesanomalyocsvmPoint::y(self : TimeseriesanomalyocsvmPoint) -> Double { self.y }

pub fn TimeseriesanomalyocsvmPoint::z(self : TimeseriesanomalyocsvmPoint) -> Double { self.z }

pub fn TimeseriesanomalyocsvmPoint::label(self : TimeseriesanomalyocsvmPoint) -> Int { self.label }

pub fn TimeseriesanomalyocsvmPoint::dist(self : TimeseriesanomalyocsvmPoint, other : TimeseriesanomalyocsvmPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn TimeseriesanomalyocsvmPoint::add(self : TimeseriesanomalyocsvmPoint, other : TimeseriesanomalyocsvmPoint) -> TimeseriesanomalyocsvmPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn TimeseriesanomalyocsvmPoint::sub(self : TimeseriesanomalyocsvmPoint, other : TimeseriesanomalyocsvmPoint) -> TimeseriesanomalyocsvmPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn TimeseriesanomalyocsvmPoint::scale(self : TimeseriesanomalyocsvmPoint, s : Double) -> TimeseriesanomalyocsvmPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn TimeseriesanomalyocsvmPoint::dot(self : TimeseriesanomalyocsvmPoint, other : TimeseriesanomalyocsvmPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn TimeseriesanomalyocsvmPoint::cross(self : TimeseriesanomalyocsvmPoint, other : TimeseriesanomalyocsvmPoint) -> TimeseriesanomalyocsvmPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn TimeseriesanomalyocsvmPoint::norm(self : TimeseriesanomalyocsvmPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn TimeseriesanomalyocsvmPoint::normalize(self : TimeseriesanomalyocsvmPoint) -> TimeseriesanomalyocsvmPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn TimeseriesanomalyocsvmPoint::negate(self : TimeseriesanomalyocsvmPoint) -> TimeseriesanomalyocsvmPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn TimeseriesanomalyocsvmPoint::mid(self : TimeseriesanomalyocsvmPoint, other : TimeseriesanomalyocsvmPoint) -> TimeseriesanomalyocsvmPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn TimeseriesanomalyocsvmPoint::lerp(self : TimeseriesanomalyocsvmPoint, other : TimeseriesanomalyocsvmPoint, t : Double) -> TimeseriesanomalyocsvmPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn TimeseriesanomalyocsvmPoint::to_string(self : TimeseriesanomalyocsvmPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct TimeseriesanomalyocsvmSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn timeseries_anomaly_ocsvm_make_series(vals : Array[Double], name : String) -> TimeseriesanomalyocsvmSeries {
  { vals, name, meta: 0 }
}

pub fn TimeseriesanomalyocsvmSeries::len(self : TimeseriesanomalyocsvmSeries) -> Int { self.vals.length() }

pub fn TimeseriesanomalyocsvmSeries::sum(self : TimeseriesanomalyocsvmSeries) -> Double { @_common.sum(self.vals) }

pub fn TimeseriesanomalyocsvmSeries::mean(self : TimeseriesanomalyocsvmSeries) -> Double { @_common.mean(self.vals) }

pub fn TimeseriesanomalyocsvmSeries::min(self : TimeseriesanomalyocsvmSeries) -> Double { @_common.min(self.vals) }

pub fn TimeseriesanomalyocsvmSeries::max(self : TimeseriesanomalyocsvmSeries) -> Double { @_common.max(self.vals) }

pub fn TimeseriesanomalyocsvmSeries::range(self : TimeseriesanomalyocsvmSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn TimeseriesanomalyocsvmSeries::variance(self : TimeseriesanomalyocsvmSeries) -> Double { @_common.variance(self.vals) }

pub fn TimeseriesanomalyocsvmSeries::std(self : TimeseriesanomalyocsvmSeries) -> Double { @_common.std(self.vals) }

pub fn TimeseriesanomalyocsvmSeries::median(self : TimeseriesanomalyocsvmSeries) -> Double { @_common.median(self.vals) }

pub fn TimeseriesanomalyocsvmSeries::scale(self : TimeseriesanomalyocsvmSeries, f : Double) -> TimeseriesanomalyocsvmSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn TimeseriesanomalyocsvmSeries::add(self : TimeseriesanomalyocsvmSeries, other : TimeseriesanomalyocsvmSeries) -> TimeseriesanomalyocsvmSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn TimeseriesanomalyocsvmSeries::sub(self : TimeseriesanomalyocsvmSeries, other : TimeseriesanomalyocsvmSeries) -> TimeseriesanomalyocsvmSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn TimeseriesanomalyocsvmSeries::normalize(self : TimeseriesanomalyocsvmSeries) -> TimeseriesanomalyocsvmSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn TimeseriesanomalyocsvmSeries::cumsum(self : TimeseriesanomalyocsvmSeries) -> TimeseriesanomalyocsvmSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn TimeseriesanomalyocsvmSeries::to_string(self : TimeseriesanomalyocsvmSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct TimeseriesanomalyocsvmMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn timeseries_anomaly_ocsvm_make_matrix(rows : Int, cols : Int, val : Double) -> TimeseriesanomalyocsvmMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn timeseries_anomaly_ocsvm_matrix_identity(n : Int) -> TimeseriesanomalyocsvmMatrix {
  let m = timeseries_anomaly_ocsvm_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn TimeseriesanomalyocsvmMatrix::get(self : TimeseriesanomalyocsvmMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn TimeseriesanomalyocsvmMatrix::transpose(self : TimeseriesanomalyocsvmMatrix) -> TimeseriesanomalyocsvmMatrix {
  let result = timeseries_anomaly_ocsvm_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn TimeseriesanomalyocsvmMatrix::add(self : TimeseriesanomalyocsvmMatrix, other : TimeseriesanomalyocsvmMatrix) -> TimeseriesanomalyocsvmMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = timeseries_anomaly_ocsvm_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn TimeseriesanomalyocsvmMatrix::scale(self : TimeseriesanomalyocsvmMatrix, s : Double) -> TimeseriesanomalyocsvmMatrix {
  let result = timeseries_anomaly_ocsvm_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn TimeseriesanomalyocsvmMatrix::multiply(self : TimeseriesanomalyocsvmMatrix, other : TimeseriesanomalyocsvmMatrix) -> TimeseriesanomalyocsvmMatrix {
  if self.cols != other.rows { return timeseries_anomaly_ocsvm_make_matrix(self.rows, other.cols, 0.0) }
  let result = timeseries_anomaly_ocsvm_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn TimeseriesanomalyocsvmMatrix::trace(self : TimeseriesanomalyocsvmMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn TimeseriesanomalyocsvmMatrix::det(self : TimeseriesanomalyocsvmMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn TimeseriesanomalyocsvmMatrix::norm(self : TimeseriesanomalyocsvmMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn TimeseriesanomalyocsvmMatrix::to_string(self : TimeseriesanomalyocsvmMatrix) -> String {
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

pub(all) struct TimeseriesanomalyocsvmVector {
  comps : Array[Double]
  dim : Int
}

pub fn timeseries_anomaly_ocsvm_make_vector(comps : Array[Double]) -> TimeseriesanomalyocsvmVector {
  { comps, dim: comps.length() }
}

pub fn timeseries_anomaly_ocsvm_vector_zero(dim : Int) -> TimeseriesanomalyocsvmVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn TimeseriesanomalyocsvmVector::add(self : TimeseriesanomalyocsvmVector, other : TimeseriesanomalyocsvmVector) -> TimeseriesanomalyocsvmVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn TimeseriesanomalyocsvmVector::sub(self : TimeseriesanomalyocsvmVector, other : TimeseriesanomalyocsvmVector) -> TimeseriesanomalyocsvmVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn TimeseriesanomalyocsvmVector::scale(self : TimeseriesanomalyocsvmVector, s : Double) -> TimeseriesanomalyocsvmVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn TimeseriesanomalyocsvmVector::dot(self : TimeseriesanomalyocsvmVector, other : TimeseriesanomalyocsvmVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn TimeseriesanomalyocsvmVector::norm(self : TimeseriesanomalyocsvmVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn TimeseriesanomalyocsvmVector::normalize(self : TimeseriesanomalyocsvmVector) -> TimeseriesanomalyocsvmVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn TimeseriesanomalyocsvmVector::dist(self : TimeseriesanomalyocsvmVector, other : TimeseriesanomalyocsvmVector) -> Double {
  self.sub(other).norm()
}

pub fn TimeseriesanomalyocsvmVector::to_string(self : TimeseriesanomalyocsvmVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn timeseries_anomaly_ocsvm_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn timeseries_anomaly_ocsvm_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn timeseries_anomaly_ocsvm_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn timeseries_anomaly_ocsvm_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn timeseries_anomaly_ocsvm_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn timeseries_anomaly_ocsvm_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn timeseries_anomaly_ocsvm_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn timeseries_anomaly_ocsvm_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn timeseries_anomaly_ocsvm_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn timeseries_anomaly_ocsvm_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn timeseries_anomaly_ocsvm_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn timeseries_anomaly_ocsvm_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn timeseries_anomaly_ocsvm_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn timeseries_anomaly_ocsvm_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn timeseries_anomaly_ocsvm_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn timeseries_anomaly_ocsvm_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn timeseries_anomaly_ocsvm_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn timeseries_anomaly_ocsvm_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn timeseries_anomaly_ocsvm_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn timeseries_anomaly_ocsvm_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn timeseries_anomaly_ocsvm_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn timeseries_anomaly_ocsvm_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn timeseries_anomaly_ocsvm_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn timeseries_anomaly_ocsvm_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn timeseries_anomaly_ocsvm_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn timeseries_anomaly_ocsvm_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn timeseries_anomaly_ocsvm_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn timeseries_anomaly_ocsvm_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn timeseries_anomaly_ocsvm_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct TimeseriesanomalyocsvmFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_anomaly_ocsvm_frame_make(size : Int) -> TimeseriesanomalyocsvmFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_anomaly_ocsvm_frame_len(s : TimeseriesanomalyocsvmFrame) -> Int { s.size }

pub fn timeseries_anomaly_ocsvm_frame_get(s : TimeseriesanomalyocsvmFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_anomaly_ocsvm_frame_set(s : TimeseriesanomalyocsvmFrame, i : Int, v : Double) -> TimeseriesanomalyocsvmFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_ocsvm_frame_sum(s : TimeseriesanomalyocsvmFrame) -> Double { @_common.sum(s.data) }

pub fn timeseries_anomaly_ocsvm_frame_mean(s : TimeseriesanomalyocsvmFrame) -> Double { @_common.mean(s.data) }

pub fn timeseries_anomaly_ocsvm_frame_scale(s : TimeseriesanomalyocsvmFrame, f : Double) -> TimeseriesanomalyocsvmFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_ocsvm_frame_add(a : TimeseriesanomalyocsvmFrame, b : TimeseriesanomalyocsvmFrame) -> TimeseriesanomalyocsvmFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_anomaly_ocsvm_frame_copy(s : TimeseriesanomalyocsvmFrame) -> TimeseriesanomalyocsvmFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_ocsvm_frame_fill(s : TimeseriesanomalyocsvmFrame, v : Double) -> TimeseriesanomalyocsvmFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_ocsvm_frame_min(s : TimeseriesanomalyocsvmFrame) -> Double { @_common.min(s.data) }

pub fn timeseries_anomaly_ocsvm_frame_max(s : TimeseriesanomalyocsvmFrame) -> Double { @_common.max(s.data) }

pub fn timeseries_anomaly_ocsvm_frame_to_string(s : TimeseriesanomalyocsvmFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesanomalyocsvmTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_anomaly_ocsvm_table_make(size : Int) -> TimeseriesanomalyocsvmTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_anomaly_ocsvm_table_len(s : TimeseriesanomalyocsvmTable) -> Int { s.size }

pub fn timeseries_anomaly_ocsvm_table_get(s : TimeseriesanomalyocsvmTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_anomaly_ocsvm_table_set(s : TimeseriesanomalyocsvmTable, i : Int, v : Double) -> TimeseriesanomalyocsvmTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_ocsvm_table_sum(s : TimeseriesanomalyocsvmTable) -> Double { @_common.sum(s.data) }

pub fn timeseries_anomaly_ocsvm_table_mean(s : TimeseriesanomalyocsvmTable) -> Double { @_common.mean(s.data) }

pub fn timeseries_anomaly_ocsvm_table_scale(s : TimeseriesanomalyocsvmTable, f : Double) -> TimeseriesanomalyocsvmTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_ocsvm_table_add(a : TimeseriesanomalyocsvmTable, b : TimeseriesanomalyocsvmTable) -> TimeseriesanomalyocsvmTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_anomaly_ocsvm_table_copy(s : TimeseriesanomalyocsvmTable) -> TimeseriesanomalyocsvmTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_ocsvm_table_fill(s : TimeseriesanomalyocsvmTable, v : Double) -> TimeseriesanomalyocsvmTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_ocsvm_table_min(s : TimeseriesanomalyocsvmTable) -> Double { @_common.min(s.data) }

pub fn timeseries_anomaly_ocsvm_table_max(s : TimeseriesanomalyocsvmTable) -> Double { @_common.max(s.data) }

pub fn timeseries_anomaly_ocsvm_table_to_string(s : TimeseriesanomalyocsvmTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesanomalyocsvmGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_anomaly_ocsvm_graphn_make(size : Int) -> TimeseriesanomalyocsvmGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_anomaly_ocsvm_graphn_len(s : TimeseriesanomalyocsvmGraphN) -> Int { s.size }

pub fn timeseries_anomaly_ocsvm_graphn_get(s : TimeseriesanomalyocsvmGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_anomaly_ocsvm_graphn_set(s : TimeseriesanomalyocsvmGraphN, i : Int, v : Double) -> TimeseriesanomalyocsvmGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_ocsvm_graphn_sum(s : TimeseriesanomalyocsvmGraphN) -> Double { @_common.sum(s.data) }

pub fn timeseries_anomaly_ocsvm_graphn_mean(s : TimeseriesanomalyocsvmGraphN) -> Double { @_common.mean(s.data) }

pub fn timeseries_anomaly_ocsvm_graphn_scale(s : TimeseriesanomalyocsvmGraphN, f : Double) -> TimeseriesanomalyocsvmGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_ocsvm_graphn_add(a : TimeseriesanomalyocsvmGraphN, b : TimeseriesanomalyocsvmGraphN) -> TimeseriesanomalyocsvmGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_anomaly_ocsvm_graphn_copy(s : TimeseriesanomalyocsvmGraphN) -> TimeseriesanomalyocsvmGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_ocsvm_graphn_fill(s : TimeseriesanomalyocsvmGraphN, v : Double) -> TimeseriesanomalyocsvmGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_ocsvm_graphn_min(s : TimeseriesanomalyocsvmGraphN) -> Double { @_common.min(s.data) }

pub fn timeseries_anomaly_ocsvm_graphn_max(s : TimeseriesanomalyocsvmGraphN) -> Double { @_common.max(s.data) }

pub fn timeseries_anomaly_ocsvm_graphn_to_string(s : TimeseriesanomalyocsvmGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesanomalyocsvmNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_anomaly_ocsvm_node_make(size : Int) -> TimeseriesanomalyocsvmNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_anomaly_ocsvm_node_len(s : TimeseriesanomalyocsvmNode) -> Int { s.size }

pub fn timeseries_anomaly_ocsvm_node_get(s : TimeseriesanomalyocsvmNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_anomaly_ocsvm_node_set(s : TimeseriesanomalyocsvmNode, i : Int, v : Double) -> TimeseriesanomalyocsvmNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_ocsvm_node_sum(s : TimeseriesanomalyocsvmNode) -> Double { @_common.sum(s.data) }

pub fn timeseries_anomaly_ocsvm_node_mean(s : TimeseriesanomalyocsvmNode) -> Double { @_common.mean(s.data) }

pub fn timeseries_anomaly_ocsvm_node_scale(s : TimeseriesanomalyocsvmNode, f : Double) -> TimeseriesanomalyocsvmNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_ocsvm_node_add(a : TimeseriesanomalyocsvmNode, b : TimeseriesanomalyocsvmNode) -> TimeseriesanomalyocsvmNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_anomaly_ocsvm_node_copy(s : TimeseriesanomalyocsvmNode) -> TimeseriesanomalyocsvmNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_ocsvm_node_fill(s : TimeseriesanomalyocsvmNode, v : Double) -> TimeseriesanomalyocsvmNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_ocsvm_node_min(s : TimeseriesanomalyocsvmNode) -> Double { @_common.min(s.data) }

pub fn timeseries_anomaly_ocsvm_node_max(s : TimeseriesanomalyocsvmNode) -> Double { @_common.max(s.data) }

pub fn timeseries_anomaly_ocsvm_node_to_string(s : TimeseriesanomalyocsvmNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesanomalyocsvmEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_anomaly_ocsvm_edge_make(size : Int) -> TimeseriesanomalyocsvmEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_anomaly_ocsvm_edge_len(s : TimeseriesanomalyocsvmEdge) -> Int { s.size }

pub fn timeseries_anomaly_ocsvm_edge_get(s : TimeseriesanomalyocsvmEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_anomaly_ocsvm_edge_set(s : TimeseriesanomalyocsvmEdge, i : Int, v : Double) -> TimeseriesanomalyocsvmEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_ocsvm_edge_sum(s : TimeseriesanomalyocsvmEdge) -> Double { @_common.sum(s.data) }

pub fn timeseries_anomaly_ocsvm_edge_mean(s : TimeseriesanomalyocsvmEdge) -> Double { @_common.mean(s.data) }

pub fn timeseries_anomaly_ocsvm_edge_scale(s : TimeseriesanomalyocsvmEdge, f : Double) -> TimeseriesanomalyocsvmEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_ocsvm_edge_add(a : TimeseriesanomalyocsvmEdge, b : TimeseriesanomalyocsvmEdge) -> TimeseriesanomalyocsvmEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_anomaly_ocsvm_edge_copy(s : TimeseriesanomalyocsvmEdge) -> TimeseriesanomalyocsvmEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_ocsvm_edge_fill(s : TimeseriesanomalyocsvmEdge, v : Double) -> TimeseriesanomalyocsvmEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_ocsvm_edge_min(s : TimeseriesanomalyocsvmEdge) -> Double { @_common.min(s.data) }

pub fn timeseries_anomaly_ocsvm_edge_max(s : TimeseriesanomalyocsvmEdge) -> Double { @_common.max(s.data) }

pub fn timeseries_anomaly_ocsvm_edge_to_string(s : TimeseriesanomalyocsvmEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesanomalyocsvmPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_anomaly_ocsvm_path_make(size : Int) -> TimeseriesanomalyocsvmPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_anomaly_ocsvm_path_len(s : TimeseriesanomalyocsvmPath) -> Int { s.size }

pub fn timeseries_anomaly_ocsvm_path_get(s : TimeseriesanomalyocsvmPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_anomaly_ocsvm_path_set(s : TimeseriesanomalyocsvmPath, i : Int, v : Double) -> TimeseriesanomalyocsvmPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_ocsvm_path_sum(s : TimeseriesanomalyocsvmPath) -> Double { @_common.sum(s.data) }

pub fn timeseries_anomaly_ocsvm_path_mean(s : TimeseriesanomalyocsvmPath) -> Double { @_common.mean(s.data) }

pub fn timeseries_anomaly_ocsvm_path_scale(s : TimeseriesanomalyocsvmPath, f : Double) -> TimeseriesanomalyocsvmPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_ocsvm_path_add(a : TimeseriesanomalyocsvmPath, b : TimeseriesanomalyocsvmPath) -> TimeseriesanomalyocsvmPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_anomaly_ocsvm_path_copy(s : TimeseriesanomalyocsvmPath) -> TimeseriesanomalyocsvmPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_ocsvm_path_fill(s : TimeseriesanomalyocsvmPath, v : Double) -> TimeseriesanomalyocsvmPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_ocsvm_path_min(s : TimeseriesanomalyocsvmPath) -> Double { @_common.min(s.data) }

pub fn timeseries_anomaly_ocsvm_path_max(s : TimeseriesanomalyocsvmPath) -> Double { @_common.max(s.data) }

pub fn timeseries_anomaly_ocsvm_path_to_string(s : TimeseriesanomalyocsvmPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesanomalyocsvmCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_anomaly_ocsvm_cluster_make(size : Int) -> TimeseriesanomalyocsvmCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_anomaly_ocsvm_cluster_len(s : TimeseriesanomalyocsvmCluster) -> Int { s.size }

pub fn timeseries_anomaly_ocsvm_cluster_get(s : TimeseriesanomalyocsvmCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_anomaly_ocsvm_cluster_set(s : TimeseriesanomalyocsvmCluster, i : Int, v : Double) -> TimeseriesanomalyocsvmCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_ocsvm_cluster_sum(s : TimeseriesanomalyocsvmCluster) -> Double { @_common.sum(s.data) }

pub fn timeseries_anomaly_ocsvm_cluster_mean(s : TimeseriesanomalyocsvmCluster) -> Double { @_common.mean(s.data) }

pub fn timeseries_anomaly_ocsvm_cluster_scale(s : TimeseriesanomalyocsvmCluster, f : Double) -> TimeseriesanomalyocsvmCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_ocsvm_cluster_add(a : TimeseriesanomalyocsvmCluster, b : TimeseriesanomalyocsvmCluster) -> TimeseriesanomalyocsvmCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_anomaly_ocsvm_cluster_copy(s : TimeseriesanomalyocsvmCluster) -> TimeseriesanomalyocsvmCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_ocsvm_cluster_fill(s : TimeseriesanomalyocsvmCluster, v : Double) -> TimeseriesanomalyocsvmCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_ocsvm_cluster_min(s : TimeseriesanomalyocsvmCluster) -> Double { @_common.min(s.data) }

pub fn timeseries_anomaly_ocsvm_cluster_max(s : TimeseriesanomalyocsvmCluster) -> Double { @_common.max(s.data) }

pub fn timeseries_anomaly_ocsvm_cluster_to_string(s : TimeseriesanomalyocsvmCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesanomalyocsvmModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_anomaly_ocsvm_model_make(size : Int) -> TimeseriesanomalyocsvmModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_anomaly_ocsvm_model_len(s : TimeseriesanomalyocsvmModel) -> Int { s.size }

pub fn timeseries_anomaly_ocsvm_model_get(s : TimeseriesanomalyocsvmModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_anomaly_ocsvm_model_set(s : TimeseriesanomalyocsvmModel, i : Int, v : Double) -> TimeseriesanomalyocsvmModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_ocsvm_model_sum(s : TimeseriesanomalyocsvmModel) -> Double { @_common.sum(s.data) }

pub fn timeseries_anomaly_ocsvm_model_mean(s : TimeseriesanomalyocsvmModel) -> Double { @_common.mean(s.data) }

pub fn timeseries_anomaly_ocsvm_model_scale(s : TimeseriesanomalyocsvmModel, f : Double) -> TimeseriesanomalyocsvmModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_ocsvm_model_add(a : TimeseriesanomalyocsvmModel, b : TimeseriesanomalyocsvmModel) -> TimeseriesanomalyocsvmModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_anomaly_ocsvm_model_copy(s : TimeseriesanomalyocsvmModel) -> TimeseriesanomalyocsvmModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_ocsvm_model_fill(s : TimeseriesanomalyocsvmModel, v : Double) -> TimeseriesanomalyocsvmModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_ocsvm_model_min(s : TimeseriesanomalyocsvmModel) -> Double { @_common.min(s.data) }

pub fn timeseries_anomaly_ocsvm_model_max(s : TimeseriesanomalyocsvmModel) -> Double { @_common.max(s.data) }

pub fn timeseries_anomaly_ocsvm_model_to_string(s : TimeseriesanomalyocsvmModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesanomalyocsvmLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_anomaly_ocsvm_layer_make(size : Int) -> TimeseriesanomalyocsvmLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_anomaly_ocsvm_layer_len(s : TimeseriesanomalyocsvmLayer) -> Int { s.size }

pub fn timeseries_anomaly_ocsvm_layer_get(s : TimeseriesanomalyocsvmLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_anomaly_ocsvm_layer_set(s : TimeseriesanomalyocsvmLayer, i : Int, v : Double) -> TimeseriesanomalyocsvmLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_ocsvm_layer_sum(s : TimeseriesanomalyocsvmLayer) -> Double { @_common.sum(s.data) }

pub fn timeseries_anomaly_ocsvm_layer_mean(s : TimeseriesanomalyocsvmLayer) -> Double { @_common.mean(s.data) }

pub fn timeseries_anomaly_ocsvm_layer_scale(s : TimeseriesanomalyocsvmLayer, f : Double) -> TimeseriesanomalyocsvmLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_ocsvm_layer_add(a : TimeseriesanomalyocsvmLayer, b : TimeseriesanomalyocsvmLayer) -> TimeseriesanomalyocsvmLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_anomaly_ocsvm_layer_copy(s : TimeseriesanomalyocsvmLayer) -> TimeseriesanomalyocsvmLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_ocsvm_layer_fill(s : TimeseriesanomalyocsvmLayer, v : Double) -> TimeseriesanomalyocsvmLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_ocsvm_layer_min(s : TimeseriesanomalyocsvmLayer) -> Double { @_common.min(s.data) }

pub fn timeseries_anomaly_ocsvm_layer_max(s : TimeseriesanomalyocsvmLayer) -> Double { @_common.max(s.data) }

pub fn timeseries_anomaly_ocsvm_layer_to_string(s : TimeseriesanomalyocsvmLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesanomalyocsvmBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_anomaly_ocsvm_buffer_make(size : Int) -> TimeseriesanomalyocsvmBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_anomaly_ocsvm_buffer_len(s : TimeseriesanomalyocsvmBuffer) -> Int { s.size }

pub fn timeseries_anomaly_ocsvm_buffer_get(s : TimeseriesanomalyocsvmBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_anomaly_ocsvm_buffer_set(s : TimeseriesanomalyocsvmBuffer, i : Int, v : Double) -> TimeseriesanomalyocsvmBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_ocsvm_buffer_sum(s : TimeseriesanomalyocsvmBuffer) -> Double { @_common.sum(s.data) }

pub fn timeseries_anomaly_ocsvm_buffer_mean(s : TimeseriesanomalyocsvmBuffer) -> Double { @_common.mean(s.data) }

pub fn timeseries_anomaly_ocsvm_buffer_scale(s : TimeseriesanomalyocsvmBuffer, f : Double) -> TimeseriesanomalyocsvmBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_ocsvm_buffer_add(a : TimeseriesanomalyocsvmBuffer, b : TimeseriesanomalyocsvmBuffer) -> TimeseriesanomalyocsvmBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_anomaly_ocsvm_buffer_copy(s : TimeseriesanomalyocsvmBuffer) -> TimeseriesanomalyocsvmBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_ocsvm_buffer_fill(s : TimeseriesanomalyocsvmBuffer, v : Double) -> TimeseriesanomalyocsvmBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_ocsvm_buffer_min(s : TimeseriesanomalyocsvmBuffer) -> Double { @_common.min(s.data) }

pub fn timeseries_anomaly_ocsvm_buffer_max(s : TimeseriesanomalyocsvmBuffer) -> Double { @_common.max(s.data) }

pub fn timeseries_anomaly_ocsvm_buffer_to_string(s : TimeseriesanomalyocsvmBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesanomalyocsvmCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_anomaly_ocsvm_cursor_make(size : Int) -> TimeseriesanomalyocsvmCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_anomaly_ocsvm_cursor_len(s : TimeseriesanomalyocsvmCursor) -> Int { s.size }

pub fn timeseries_anomaly_ocsvm_cursor_get(s : TimeseriesanomalyocsvmCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_anomaly_ocsvm_cursor_set(s : TimeseriesanomalyocsvmCursor, i : Int, v : Double) -> TimeseriesanomalyocsvmCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_ocsvm_cursor_sum(s : TimeseriesanomalyocsvmCursor) -> Double { @_common.sum(s.data) }

pub fn timeseries_anomaly_ocsvm_cursor_mean(s : TimeseriesanomalyocsvmCursor) -> Double { @_common.mean(s.data) }

pub fn timeseries_anomaly_ocsvm_cursor_scale(s : TimeseriesanomalyocsvmCursor, f : Double) -> TimeseriesanomalyocsvmCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_ocsvm_cursor_add(a : TimeseriesanomalyocsvmCursor, b : TimeseriesanomalyocsvmCursor) -> TimeseriesanomalyocsvmCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_anomaly_ocsvm_cursor_copy(s : TimeseriesanomalyocsvmCursor) -> TimeseriesanomalyocsvmCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_ocsvm_cursor_fill(s : TimeseriesanomalyocsvmCursor, v : Double) -> TimeseriesanomalyocsvmCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_ocsvm_cursor_min(s : TimeseriesanomalyocsvmCursor) -> Double { @_common.min(s.data) }

pub fn timeseries_anomaly_ocsvm_cursor_max(s : TimeseriesanomalyocsvmCursor) -> Double { @_common.max(s.data) }

pub fn timeseries_anomaly_ocsvm_cursor_to_string(s : TimeseriesanomalyocsvmCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesanomalyocsvmView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_anomaly_ocsvm_view_make(size : Int) -> TimeseriesanomalyocsvmView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_anomaly_ocsvm_view_len(s : TimeseriesanomalyocsvmView) -> Int { s.size }

pub fn timeseries_anomaly_ocsvm_view_get(s : TimeseriesanomalyocsvmView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_anomaly_ocsvm_view_set(s : TimeseriesanomalyocsvmView, i : Int, v : Double) -> TimeseriesanomalyocsvmView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_ocsvm_view_sum(s : TimeseriesanomalyocsvmView) -> Double { @_common.sum(s.data) }

pub fn timeseries_anomaly_ocsvm_view_mean(s : TimeseriesanomalyocsvmView) -> Double { @_common.mean(s.data) }

pub fn timeseries_anomaly_ocsvm_view_scale(s : TimeseriesanomalyocsvmView, f : Double) -> TimeseriesanomalyocsvmView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_ocsvm_view_add(a : TimeseriesanomalyocsvmView, b : TimeseriesanomalyocsvmView) -> TimeseriesanomalyocsvmView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_anomaly_ocsvm_view_copy(s : TimeseriesanomalyocsvmView) -> TimeseriesanomalyocsvmView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_ocsvm_view_fill(s : TimeseriesanomalyocsvmView, v : Double) -> TimeseriesanomalyocsvmView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_ocsvm_view_min(s : TimeseriesanomalyocsvmView) -> Double { @_common.min(s.data) }

pub fn timeseries_anomaly_ocsvm_view_max(s : TimeseriesanomalyocsvmView) -> Double { @_common.max(s.data) }

pub fn timeseries_anomaly_ocsvm_view_to_string(s : TimeseriesanomalyocsvmView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesanomalyocsvmRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_anomaly_ocsvm_range_make(size : Int) -> TimeseriesanomalyocsvmRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_anomaly_ocsvm_range_len(s : TimeseriesanomalyocsvmRange) -> Int { s.size }

pub fn timeseries_anomaly_ocsvm_range_get(s : TimeseriesanomalyocsvmRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_anomaly_ocsvm_range_set(s : TimeseriesanomalyocsvmRange, i : Int, v : Double) -> TimeseriesanomalyocsvmRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_ocsvm_range_sum(s : TimeseriesanomalyocsvmRange) -> Double { @_common.sum(s.data) }

pub fn timeseries_anomaly_ocsvm_range_mean(s : TimeseriesanomalyocsvmRange) -> Double { @_common.mean(s.data) }

pub fn timeseries_anomaly_ocsvm_range_scale(s : TimeseriesanomalyocsvmRange, f : Double) -> TimeseriesanomalyocsvmRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_ocsvm_range_add(a : TimeseriesanomalyocsvmRange, b : TimeseriesanomalyocsvmRange) -> TimeseriesanomalyocsvmRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_anomaly_ocsvm_range_copy(s : TimeseriesanomalyocsvmRange) -> TimeseriesanomalyocsvmRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_ocsvm_range_fill(s : TimeseriesanomalyocsvmRange, v : Double) -> TimeseriesanomalyocsvmRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_ocsvm_range_min(s : TimeseriesanomalyocsvmRange) -> Double { @_common.min(s.data) }

pub fn timeseries_anomaly_ocsvm_range_max(s : TimeseriesanomalyocsvmRange) -> Double { @_common.max(s.data) }

pub fn timeseries_anomaly_ocsvm_range_to_string(s : TimeseriesanomalyocsvmRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesanomalyocsvmSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_anomaly_ocsvm_slice_make(size : Int) -> TimeseriesanomalyocsvmSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_anomaly_ocsvm_slice_len(s : TimeseriesanomalyocsvmSlice) -> Int { s.size }

pub fn timeseries_anomaly_ocsvm_slice_get(s : TimeseriesanomalyocsvmSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_anomaly_ocsvm_slice_set(s : TimeseriesanomalyocsvmSlice, i : Int, v : Double) -> TimeseriesanomalyocsvmSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_ocsvm_slice_sum(s : TimeseriesanomalyocsvmSlice) -> Double { @_common.sum(s.data) }

pub fn timeseries_anomaly_ocsvm_slice_mean(s : TimeseriesanomalyocsvmSlice) -> Double { @_common.mean(s.data) }

pub fn timeseries_anomaly_ocsvm_slice_scale(s : TimeseriesanomalyocsvmSlice, f : Double) -> TimeseriesanomalyocsvmSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_ocsvm_slice_add(a : TimeseriesanomalyocsvmSlice, b : TimeseriesanomalyocsvmSlice) -> TimeseriesanomalyocsvmSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_anomaly_ocsvm_slice_copy(s : TimeseriesanomalyocsvmSlice) -> TimeseriesanomalyocsvmSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_ocsvm_slice_fill(s : TimeseriesanomalyocsvmSlice, v : Double) -> TimeseriesanomalyocsvmSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_ocsvm_slice_min(s : TimeseriesanomalyocsvmSlice) -> Double { @_common.min(s.data) }

pub fn timeseries_anomaly_ocsvm_slice_max(s : TimeseriesanomalyocsvmSlice) -> Double { @_common.max(s.data) }

pub fn timeseries_anomaly_ocsvm_slice_to_string(s : TimeseriesanomalyocsvmSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

