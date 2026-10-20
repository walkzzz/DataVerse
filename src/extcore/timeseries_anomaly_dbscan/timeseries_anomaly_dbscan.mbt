///===
/// extcore/timeseries_anomaly_dbscan

pub(all) struct TimeseriesanomalydbscanPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn timeseries_anomaly_dbscan_make_point(x : Double, y : Double) -> TimeseriesanomalydbscanPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn timeseries_anomaly_dbscan_make_point3(x : Double, y : Double, z : Double) -> TimeseriesanomalydbscanPoint {
  { x, y, z, label: 0 }
}

pub fn TimeseriesanomalydbscanPoint::x(self : TimeseriesanomalydbscanPoint) -> Double { self.x }

pub fn TimeseriesanomalydbscanPoint::y(self : TimeseriesanomalydbscanPoint) -> Double { self.y }

pub fn TimeseriesanomalydbscanPoint::z(self : TimeseriesanomalydbscanPoint) -> Double { self.z }

pub fn TimeseriesanomalydbscanPoint::label(self : TimeseriesanomalydbscanPoint) -> Int { self.label }

pub fn TimeseriesanomalydbscanPoint::dist(self : TimeseriesanomalydbscanPoint, other : TimeseriesanomalydbscanPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn TimeseriesanomalydbscanPoint::add(self : TimeseriesanomalydbscanPoint, other : TimeseriesanomalydbscanPoint) -> TimeseriesanomalydbscanPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn TimeseriesanomalydbscanPoint::sub(self : TimeseriesanomalydbscanPoint, other : TimeseriesanomalydbscanPoint) -> TimeseriesanomalydbscanPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn TimeseriesanomalydbscanPoint::scale(self : TimeseriesanomalydbscanPoint, s : Double) -> TimeseriesanomalydbscanPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn TimeseriesanomalydbscanPoint::dot(self : TimeseriesanomalydbscanPoint, other : TimeseriesanomalydbscanPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn TimeseriesanomalydbscanPoint::cross(self : TimeseriesanomalydbscanPoint, other : TimeseriesanomalydbscanPoint) -> TimeseriesanomalydbscanPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn TimeseriesanomalydbscanPoint::norm(self : TimeseriesanomalydbscanPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn TimeseriesanomalydbscanPoint::normalize(self : TimeseriesanomalydbscanPoint) -> TimeseriesanomalydbscanPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn TimeseriesanomalydbscanPoint::negate(self : TimeseriesanomalydbscanPoint) -> TimeseriesanomalydbscanPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn TimeseriesanomalydbscanPoint::mid(self : TimeseriesanomalydbscanPoint, other : TimeseriesanomalydbscanPoint) -> TimeseriesanomalydbscanPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn TimeseriesanomalydbscanPoint::lerp(self : TimeseriesanomalydbscanPoint, other : TimeseriesanomalydbscanPoint, t : Double) -> TimeseriesanomalydbscanPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn TimeseriesanomalydbscanPoint::to_string(self : TimeseriesanomalydbscanPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct TimeseriesanomalydbscanSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn timeseries_anomaly_dbscan_make_series(vals : Array[Double], name : String) -> TimeseriesanomalydbscanSeries {
  { vals, name, meta: 0 }
}

pub fn TimeseriesanomalydbscanSeries::len(self : TimeseriesanomalydbscanSeries) -> Int { self.vals.length() }

pub fn TimeseriesanomalydbscanSeries::sum(self : TimeseriesanomalydbscanSeries) -> Double { @_common.sum(self.vals) }

pub fn TimeseriesanomalydbscanSeries::mean(self : TimeseriesanomalydbscanSeries) -> Double { @_common.mean(self.vals) }

pub fn TimeseriesanomalydbscanSeries::min(self : TimeseriesanomalydbscanSeries) -> Double { @_common.min(self.vals) }

pub fn TimeseriesanomalydbscanSeries::max(self : TimeseriesanomalydbscanSeries) -> Double { @_common.max(self.vals) }

pub fn TimeseriesanomalydbscanSeries::range(self : TimeseriesanomalydbscanSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn TimeseriesanomalydbscanSeries::variance(self : TimeseriesanomalydbscanSeries) -> Double { @_common.variance(self.vals) }

pub fn TimeseriesanomalydbscanSeries::std(self : TimeseriesanomalydbscanSeries) -> Double { @_common.std(self.vals) }

pub fn TimeseriesanomalydbscanSeries::median(self : TimeseriesanomalydbscanSeries) -> Double { @_common.median(self.vals) }

pub fn TimeseriesanomalydbscanSeries::scale(self : TimeseriesanomalydbscanSeries, f : Double) -> TimeseriesanomalydbscanSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn TimeseriesanomalydbscanSeries::add(self : TimeseriesanomalydbscanSeries, other : TimeseriesanomalydbscanSeries) -> TimeseriesanomalydbscanSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn TimeseriesanomalydbscanSeries::sub(self : TimeseriesanomalydbscanSeries, other : TimeseriesanomalydbscanSeries) -> TimeseriesanomalydbscanSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn TimeseriesanomalydbscanSeries::normalize(self : TimeseriesanomalydbscanSeries) -> TimeseriesanomalydbscanSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn TimeseriesanomalydbscanSeries::cumsum(self : TimeseriesanomalydbscanSeries) -> TimeseriesanomalydbscanSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn TimeseriesanomalydbscanSeries::to_string(self : TimeseriesanomalydbscanSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct TimeseriesanomalydbscanMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn timeseries_anomaly_dbscan_make_matrix(rows : Int, cols : Int, val : Double) -> TimeseriesanomalydbscanMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn timeseries_anomaly_dbscan_matrix_identity(n : Int) -> TimeseriesanomalydbscanMatrix {
  let m = timeseries_anomaly_dbscan_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn TimeseriesanomalydbscanMatrix::get(self : TimeseriesanomalydbscanMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn TimeseriesanomalydbscanMatrix::transpose(self : TimeseriesanomalydbscanMatrix) -> TimeseriesanomalydbscanMatrix {
  let result = timeseries_anomaly_dbscan_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn TimeseriesanomalydbscanMatrix::add(self : TimeseriesanomalydbscanMatrix, other : TimeseriesanomalydbscanMatrix) -> TimeseriesanomalydbscanMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = timeseries_anomaly_dbscan_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn TimeseriesanomalydbscanMatrix::scale(self : TimeseriesanomalydbscanMatrix, s : Double) -> TimeseriesanomalydbscanMatrix {
  let result = timeseries_anomaly_dbscan_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn TimeseriesanomalydbscanMatrix::multiply(self : TimeseriesanomalydbscanMatrix, other : TimeseriesanomalydbscanMatrix) -> TimeseriesanomalydbscanMatrix {
  if self.cols != other.rows { return timeseries_anomaly_dbscan_make_matrix(self.rows, other.cols, 0.0) }
  let result = timeseries_anomaly_dbscan_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn TimeseriesanomalydbscanMatrix::trace(self : TimeseriesanomalydbscanMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn TimeseriesanomalydbscanMatrix::det(self : TimeseriesanomalydbscanMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn TimeseriesanomalydbscanMatrix::norm(self : TimeseriesanomalydbscanMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn TimeseriesanomalydbscanMatrix::to_string(self : TimeseriesanomalydbscanMatrix) -> String {
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

pub(all) struct TimeseriesanomalydbscanVector {
  comps : Array[Double]
  dim : Int
}

pub fn timeseries_anomaly_dbscan_make_vector(comps : Array[Double]) -> TimeseriesanomalydbscanVector {
  { comps, dim: comps.length() }
}

pub fn timeseries_anomaly_dbscan_vector_zero(dim : Int) -> TimeseriesanomalydbscanVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn TimeseriesanomalydbscanVector::add(self : TimeseriesanomalydbscanVector, other : TimeseriesanomalydbscanVector) -> TimeseriesanomalydbscanVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn TimeseriesanomalydbscanVector::sub(self : TimeseriesanomalydbscanVector, other : TimeseriesanomalydbscanVector) -> TimeseriesanomalydbscanVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn TimeseriesanomalydbscanVector::scale(self : TimeseriesanomalydbscanVector, s : Double) -> TimeseriesanomalydbscanVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn TimeseriesanomalydbscanVector::dot(self : TimeseriesanomalydbscanVector, other : TimeseriesanomalydbscanVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn TimeseriesanomalydbscanVector::norm(self : TimeseriesanomalydbscanVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn TimeseriesanomalydbscanVector::normalize(self : TimeseriesanomalydbscanVector) -> TimeseriesanomalydbscanVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn TimeseriesanomalydbscanVector::dist(self : TimeseriesanomalydbscanVector, other : TimeseriesanomalydbscanVector) -> Double {
  self.sub(other).norm()
}

pub fn TimeseriesanomalydbscanVector::to_string(self : TimeseriesanomalydbscanVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn timeseries_anomaly_dbscan_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn timeseries_anomaly_dbscan_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn timeseries_anomaly_dbscan_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn timeseries_anomaly_dbscan_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn timeseries_anomaly_dbscan_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn timeseries_anomaly_dbscan_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn timeseries_anomaly_dbscan_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn timeseries_anomaly_dbscan_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn timeseries_anomaly_dbscan_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn timeseries_anomaly_dbscan_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn timeseries_anomaly_dbscan_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn timeseries_anomaly_dbscan_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn timeseries_anomaly_dbscan_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn timeseries_anomaly_dbscan_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn timeseries_anomaly_dbscan_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn timeseries_anomaly_dbscan_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn timeseries_anomaly_dbscan_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn timeseries_anomaly_dbscan_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn timeseries_anomaly_dbscan_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn timeseries_anomaly_dbscan_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn timeseries_anomaly_dbscan_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn timeseries_anomaly_dbscan_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn timeseries_anomaly_dbscan_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn timeseries_anomaly_dbscan_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn timeseries_anomaly_dbscan_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn timeseries_anomaly_dbscan_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn timeseries_anomaly_dbscan_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn timeseries_anomaly_dbscan_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn timeseries_anomaly_dbscan_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct TimeseriesanomalydbscanFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_anomaly_dbscan_frame_make(size : Int) -> TimeseriesanomalydbscanFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_anomaly_dbscan_frame_len(s : TimeseriesanomalydbscanFrame) -> Int { s.size }

pub fn timeseries_anomaly_dbscan_frame_get(s : TimeseriesanomalydbscanFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_anomaly_dbscan_frame_set(s : TimeseriesanomalydbscanFrame, i : Int, v : Double) -> TimeseriesanomalydbscanFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_dbscan_frame_sum(s : TimeseriesanomalydbscanFrame) -> Double { @_common.sum(s.data) }

pub fn timeseries_anomaly_dbscan_frame_mean(s : TimeseriesanomalydbscanFrame) -> Double { @_common.mean(s.data) }

pub fn timeseries_anomaly_dbscan_frame_scale(s : TimeseriesanomalydbscanFrame, f : Double) -> TimeseriesanomalydbscanFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_dbscan_frame_add(a : TimeseriesanomalydbscanFrame, b : TimeseriesanomalydbscanFrame) -> TimeseriesanomalydbscanFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_anomaly_dbscan_frame_copy(s : TimeseriesanomalydbscanFrame) -> TimeseriesanomalydbscanFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_dbscan_frame_fill(s : TimeseriesanomalydbscanFrame, v : Double) -> TimeseriesanomalydbscanFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_dbscan_frame_min(s : TimeseriesanomalydbscanFrame) -> Double { @_common.min(s.data) }

pub fn timeseries_anomaly_dbscan_frame_max(s : TimeseriesanomalydbscanFrame) -> Double { @_common.max(s.data) }

pub fn timeseries_anomaly_dbscan_frame_to_string(s : TimeseriesanomalydbscanFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesanomalydbscanTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_anomaly_dbscan_table_make(size : Int) -> TimeseriesanomalydbscanTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_anomaly_dbscan_table_len(s : TimeseriesanomalydbscanTable) -> Int { s.size }

pub fn timeseries_anomaly_dbscan_table_get(s : TimeseriesanomalydbscanTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_anomaly_dbscan_table_set(s : TimeseriesanomalydbscanTable, i : Int, v : Double) -> TimeseriesanomalydbscanTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_dbscan_table_sum(s : TimeseriesanomalydbscanTable) -> Double { @_common.sum(s.data) }

pub fn timeseries_anomaly_dbscan_table_mean(s : TimeseriesanomalydbscanTable) -> Double { @_common.mean(s.data) }

pub fn timeseries_anomaly_dbscan_table_scale(s : TimeseriesanomalydbscanTable, f : Double) -> TimeseriesanomalydbscanTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_dbscan_table_add(a : TimeseriesanomalydbscanTable, b : TimeseriesanomalydbscanTable) -> TimeseriesanomalydbscanTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_anomaly_dbscan_table_copy(s : TimeseriesanomalydbscanTable) -> TimeseriesanomalydbscanTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_dbscan_table_fill(s : TimeseriesanomalydbscanTable, v : Double) -> TimeseriesanomalydbscanTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_dbscan_table_min(s : TimeseriesanomalydbscanTable) -> Double { @_common.min(s.data) }

pub fn timeseries_anomaly_dbscan_table_max(s : TimeseriesanomalydbscanTable) -> Double { @_common.max(s.data) }

pub fn timeseries_anomaly_dbscan_table_to_string(s : TimeseriesanomalydbscanTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesanomalydbscanGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_anomaly_dbscan_graphn_make(size : Int) -> TimeseriesanomalydbscanGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_anomaly_dbscan_graphn_len(s : TimeseriesanomalydbscanGraphN) -> Int { s.size }

pub fn timeseries_anomaly_dbscan_graphn_get(s : TimeseriesanomalydbscanGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_anomaly_dbscan_graphn_set(s : TimeseriesanomalydbscanGraphN, i : Int, v : Double) -> TimeseriesanomalydbscanGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_dbscan_graphn_sum(s : TimeseriesanomalydbscanGraphN) -> Double { @_common.sum(s.data) }

pub fn timeseries_anomaly_dbscan_graphn_mean(s : TimeseriesanomalydbscanGraphN) -> Double { @_common.mean(s.data) }

pub fn timeseries_anomaly_dbscan_graphn_scale(s : TimeseriesanomalydbscanGraphN, f : Double) -> TimeseriesanomalydbscanGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_dbscan_graphn_add(a : TimeseriesanomalydbscanGraphN, b : TimeseriesanomalydbscanGraphN) -> TimeseriesanomalydbscanGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_anomaly_dbscan_graphn_copy(s : TimeseriesanomalydbscanGraphN) -> TimeseriesanomalydbscanGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_dbscan_graphn_fill(s : TimeseriesanomalydbscanGraphN, v : Double) -> TimeseriesanomalydbscanGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_dbscan_graphn_min(s : TimeseriesanomalydbscanGraphN) -> Double { @_common.min(s.data) }

pub fn timeseries_anomaly_dbscan_graphn_max(s : TimeseriesanomalydbscanGraphN) -> Double { @_common.max(s.data) }

pub fn timeseries_anomaly_dbscan_graphn_to_string(s : TimeseriesanomalydbscanGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesanomalydbscanNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_anomaly_dbscan_node_make(size : Int) -> TimeseriesanomalydbscanNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_anomaly_dbscan_node_len(s : TimeseriesanomalydbscanNode) -> Int { s.size }

pub fn timeseries_anomaly_dbscan_node_get(s : TimeseriesanomalydbscanNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_anomaly_dbscan_node_set(s : TimeseriesanomalydbscanNode, i : Int, v : Double) -> TimeseriesanomalydbscanNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_dbscan_node_sum(s : TimeseriesanomalydbscanNode) -> Double { @_common.sum(s.data) }

pub fn timeseries_anomaly_dbscan_node_mean(s : TimeseriesanomalydbscanNode) -> Double { @_common.mean(s.data) }

pub fn timeseries_anomaly_dbscan_node_scale(s : TimeseriesanomalydbscanNode, f : Double) -> TimeseriesanomalydbscanNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_dbscan_node_add(a : TimeseriesanomalydbscanNode, b : TimeseriesanomalydbscanNode) -> TimeseriesanomalydbscanNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_anomaly_dbscan_node_copy(s : TimeseriesanomalydbscanNode) -> TimeseriesanomalydbscanNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_dbscan_node_fill(s : TimeseriesanomalydbscanNode, v : Double) -> TimeseriesanomalydbscanNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_dbscan_node_min(s : TimeseriesanomalydbscanNode) -> Double { @_common.min(s.data) }

pub fn timeseries_anomaly_dbscan_node_max(s : TimeseriesanomalydbscanNode) -> Double { @_common.max(s.data) }

pub fn timeseries_anomaly_dbscan_node_to_string(s : TimeseriesanomalydbscanNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesanomalydbscanEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_anomaly_dbscan_edge_make(size : Int) -> TimeseriesanomalydbscanEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_anomaly_dbscan_edge_len(s : TimeseriesanomalydbscanEdge) -> Int { s.size }

pub fn timeseries_anomaly_dbscan_edge_get(s : TimeseriesanomalydbscanEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_anomaly_dbscan_edge_set(s : TimeseriesanomalydbscanEdge, i : Int, v : Double) -> TimeseriesanomalydbscanEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_dbscan_edge_sum(s : TimeseriesanomalydbscanEdge) -> Double { @_common.sum(s.data) }

pub fn timeseries_anomaly_dbscan_edge_mean(s : TimeseriesanomalydbscanEdge) -> Double { @_common.mean(s.data) }

pub fn timeseries_anomaly_dbscan_edge_scale(s : TimeseriesanomalydbscanEdge, f : Double) -> TimeseriesanomalydbscanEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_dbscan_edge_add(a : TimeseriesanomalydbscanEdge, b : TimeseriesanomalydbscanEdge) -> TimeseriesanomalydbscanEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_anomaly_dbscan_edge_copy(s : TimeseriesanomalydbscanEdge) -> TimeseriesanomalydbscanEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_dbscan_edge_fill(s : TimeseriesanomalydbscanEdge, v : Double) -> TimeseriesanomalydbscanEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_dbscan_edge_min(s : TimeseriesanomalydbscanEdge) -> Double { @_common.min(s.data) }

pub fn timeseries_anomaly_dbscan_edge_max(s : TimeseriesanomalydbscanEdge) -> Double { @_common.max(s.data) }

pub fn timeseries_anomaly_dbscan_edge_to_string(s : TimeseriesanomalydbscanEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesanomalydbscanPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_anomaly_dbscan_path_make(size : Int) -> TimeseriesanomalydbscanPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_anomaly_dbscan_path_len(s : TimeseriesanomalydbscanPath) -> Int { s.size }

pub fn timeseries_anomaly_dbscan_path_get(s : TimeseriesanomalydbscanPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_anomaly_dbscan_path_set(s : TimeseriesanomalydbscanPath, i : Int, v : Double) -> TimeseriesanomalydbscanPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_dbscan_path_sum(s : TimeseriesanomalydbscanPath) -> Double { @_common.sum(s.data) }

pub fn timeseries_anomaly_dbscan_path_mean(s : TimeseriesanomalydbscanPath) -> Double { @_common.mean(s.data) }

pub fn timeseries_anomaly_dbscan_path_scale(s : TimeseriesanomalydbscanPath, f : Double) -> TimeseriesanomalydbscanPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_dbscan_path_add(a : TimeseriesanomalydbscanPath, b : TimeseriesanomalydbscanPath) -> TimeseriesanomalydbscanPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_anomaly_dbscan_path_copy(s : TimeseriesanomalydbscanPath) -> TimeseriesanomalydbscanPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_dbscan_path_fill(s : TimeseriesanomalydbscanPath, v : Double) -> TimeseriesanomalydbscanPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_dbscan_path_min(s : TimeseriesanomalydbscanPath) -> Double { @_common.min(s.data) }

pub fn timeseries_anomaly_dbscan_path_max(s : TimeseriesanomalydbscanPath) -> Double { @_common.max(s.data) }

pub fn timeseries_anomaly_dbscan_path_to_string(s : TimeseriesanomalydbscanPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesanomalydbscanCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_anomaly_dbscan_cluster_make(size : Int) -> TimeseriesanomalydbscanCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_anomaly_dbscan_cluster_len(s : TimeseriesanomalydbscanCluster) -> Int { s.size }

pub fn timeseries_anomaly_dbscan_cluster_get(s : TimeseriesanomalydbscanCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_anomaly_dbscan_cluster_set(s : TimeseriesanomalydbscanCluster, i : Int, v : Double) -> TimeseriesanomalydbscanCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_dbscan_cluster_sum(s : TimeseriesanomalydbscanCluster) -> Double { @_common.sum(s.data) }

pub fn timeseries_anomaly_dbscan_cluster_mean(s : TimeseriesanomalydbscanCluster) -> Double { @_common.mean(s.data) }

pub fn timeseries_anomaly_dbscan_cluster_scale(s : TimeseriesanomalydbscanCluster, f : Double) -> TimeseriesanomalydbscanCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_dbscan_cluster_add(a : TimeseriesanomalydbscanCluster, b : TimeseriesanomalydbscanCluster) -> TimeseriesanomalydbscanCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_anomaly_dbscan_cluster_copy(s : TimeseriesanomalydbscanCluster) -> TimeseriesanomalydbscanCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_dbscan_cluster_fill(s : TimeseriesanomalydbscanCluster, v : Double) -> TimeseriesanomalydbscanCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_dbscan_cluster_min(s : TimeseriesanomalydbscanCluster) -> Double { @_common.min(s.data) }

pub fn timeseries_anomaly_dbscan_cluster_max(s : TimeseriesanomalydbscanCluster) -> Double { @_common.max(s.data) }

pub fn timeseries_anomaly_dbscan_cluster_to_string(s : TimeseriesanomalydbscanCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesanomalydbscanModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_anomaly_dbscan_model_make(size : Int) -> TimeseriesanomalydbscanModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_anomaly_dbscan_model_len(s : TimeseriesanomalydbscanModel) -> Int { s.size }

pub fn timeseries_anomaly_dbscan_model_get(s : TimeseriesanomalydbscanModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_anomaly_dbscan_model_set(s : TimeseriesanomalydbscanModel, i : Int, v : Double) -> TimeseriesanomalydbscanModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_dbscan_model_sum(s : TimeseriesanomalydbscanModel) -> Double { @_common.sum(s.data) }

pub fn timeseries_anomaly_dbscan_model_mean(s : TimeseriesanomalydbscanModel) -> Double { @_common.mean(s.data) }

pub fn timeseries_anomaly_dbscan_model_scale(s : TimeseriesanomalydbscanModel, f : Double) -> TimeseriesanomalydbscanModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_dbscan_model_add(a : TimeseriesanomalydbscanModel, b : TimeseriesanomalydbscanModel) -> TimeseriesanomalydbscanModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_anomaly_dbscan_model_copy(s : TimeseriesanomalydbscanModel) -> TimeseriesanomalydbscanModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_dbscan_model_fill(s : TimeseriesanomalydbscanModel, v : Double) -> TimeseriesanomalydbscanModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_dbscan_model_min(s : TimeseriesanomalydbscanModel) -> Double { @_common.min(s.data) }

pub fn timeseries_anomaly_dbscan_model_max(s : TimeseriesanomalydbscanModel) -> Double { @_common.max(s.data) }

pub fn timeseries_anomaly_dbscan_model_to_string(s : TimeseriesanomalydbscanModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesanomalydbscanLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_anomaly_dbscan_layer_make(size : Int) -> TimeseriesanomalydbscanLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_anomaly_dbscan_layer_len(s : TimeseriesanomalydbscanLayer) -> Int { s.size }

pub fn timeseries_anomaly_dbscan_layer_get(s : TimeseriesanomalydbscanLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_anomaly_dbscan_layer_set(s : TimeseriesanomalydbscanLayer, i : Int, v : Double) -> TimeseriesanomalydbscanLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_dbscan_layer_sum(s : TimeseriesanomalydbscanLayer) -> Double { @_common.sum(s.data) }

pub fn timeseries_anomaly_dbscan_layer_mean(s : TimeseriesanomalydbscanLayer) -> Double { @_common.mean(s.data) }

pub fn timeseries_anomaly_dbscan_layer_scale(s : TimeseriesanomalydbscanLayer, f : Double) -> TimeseriesanomalydbscanLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_dbscan_layer_add(a : TimeseriesanomalydbscanLayer, b : TimeseriesanomalydbscanLayer) -> TimeseriesanomalydbscanLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_anomaly_dbscan_layer_copy(s : TimeseriesanomalydbscanLayer) -> TimeseriesanomalydbscanLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_dbscan_layer_fill(s : TimeseriesanomalydbscanLayer, v : Double) -> TimeseriesanomalydbscanLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_dbscan_layer_min(s : TimeseriesanomalydbscanLayer) -> Double { @_common.min(s.data) }

pub fn timeseries_anomaly_dbscan_layer_max(s : TimeseriesanomalydbscanLayer) -> Double { @_common.max(s.data) }

pub fn timeseries_anomaly_dbscan_layer_to_string(s : TimeseriesanomalydbscanLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesanomalydbscanBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_anomaly_dbscan_buffer_make(size : Int) -> TimeseriesanomalydbscanBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_anomaly_dbscan_buffer_len(s : TimeseriesanomalydbscanBuffer) -> Int { s.size }

pub fn timeseries_anomaly_dbscan_buffer_get(s : TimeseriesanomalydbscanBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_anomaly_dbscan_buffer_set(s : TimeseriesanomalydbscanBuffer, i : Int, v : Double) -> TimeseriesanomalydbscanBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_dbscan_buffer_sum(s : TimeseriesanomalydbscanBuffer) -> Double { @_common.sum(s.data) }

pub fn timeseries_anomaly_dbscan_buffer_mean(s : TimeseriesanomalydbscanBuffer) -> Double { @_common.mean(s.data) }

pub fn timeseries_anomaly_dbscan_buffer_scale(s : TimeseriesanomalydbscanBuffer, f : Double) -> TimeseriesanomalydbscanBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_dbscan_buffer_add(a : TimeseriesanomalydbscanBuffer, b : TimeseriesanomalydbscanBuffer) -> TimeseriesanomalydbscanBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_anomaly_dbscan_buffer_copy(s : TimeseriesanomalydbscanBuffer) -> TimeseriesanomalydbscanBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_dbscan_buffer_fill(s : TimeseriesanomalydbscanBuffer, v : Double) -> TimeseriesanomalydbscanBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_dbscan_buffer_min(s : TimeseriesanomalydbscanBuffer) -> Double { @_common.min(s.data) }

pub fn timeseries_anomaly_dbscan_buffer_max(s : TimeseriesanomalydbscanBuffer) -> Double { @_common.max(s.data) }

pub fn timeseries_anomaly_dbscan_buffer_to_string(s : TimeseriesanomalydbscanBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesanomalydbscanCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_anomaly_dbscan_cursor_make(size : Int) -> TimeseriesanomalydbscanCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_anomaly_dbscan_cursor_len(s : TimeseriesanomalydbscanCursor) -> Int { s.size }

pub fn timeseries_anomaly_dbscan_cursor_get(s : TimeseriesanomalydbscanCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_anomaly_dbscan_cursor_set(s : TimeseriesanomalydbscanCursor, i : Int, v : Double) -> TimeseriesanomalydbscanCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_dbscan_cursor_sum(s : TimeseriesanomalydbscanCursor) -> Double { @_common.sum(s.data) }

pub fn timeseries_anomaly_dbscan_cursor_mean(s : TimeseriesanomalydbscanCursor) -> Double { @_common.mean(s.data) }

pub fn timeseries_anomaly_dbscan_cursor_scale(s : TimeseriesanomalydbscanCursor, f : Double) -> TimeseriesanomalydbscanCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_dbscan_cursor_add(a : TimeseriesanomalydbscanCursor, b : TimeseriesanomalydbscanCursor) -> TimeseriesanomalydbscanCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_anomaly_dbscan_cursor_copy(s : TimeseriesanomalydbscanCursor) -> TimeseriesanomalydbscanCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_dbscan_cursor_fill(s : TimeseriesanomalydbscanCursor, v : Double) -> TimeseriesanomalydbscanCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_dbscan_cursor_min(s : TimeseriesanomalydbscanCursor) -> Double { @_common.min(s.data) }

pub fn timeseries_anomaly_dbscan_cursor_max(s : TimeseriesanomalydbscanCursor) -> Double { @_common.max(s.data) }

pub fn timeseries_anomaly_dbscan_cursor_to_string(s : TimeseriesanomalydbscanCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesanomalydbscanView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_anomaly_dbscan_view_make(size : Int) -> TimeseriesanomalydbscanView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_anomaly_dbscan_view_len(s : TimeseriesanomalydbscanView) -> Int { s.size }

pub fn timeseries_anomaly_dbscan_view_get(s : TimeseriesanomalydbscanView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_anomaly_dbscan_view_set(s : TimeseriesanomalydbscanView, i : Int, v : Double) -> TimeseriesanomalydbscanView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_dbscan_view_sum(s : TimeseriesanomalydbscanView) -> Double { @_common.sum(s.data) }

pub fn timeseries_anomaly_dbscan_view_mean(s : TimeseriesanomalydbscanView) -> Double { @_common.mean(s.data) }

pub fn timeseries_anomaly_dbscan_view_scale(s : TimeseriesanomalydbscanView, f : Double) -> TimeseriesanomalydbscanView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_dbscan_view_add(a : TimeseriesanomalydbscanView, b : TimeseriesanomalydbscanView) -> TimeseriesanomalydbscanView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_anomaly_dbscan_view_copy(s : TimeseriesanomalydbscanView) -> TimeseriesanomalydbscanView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_dbscan_view_fill(s : TimeseriesanomalydbscanView, v : Double) -> TimeseriesanomalydbscanView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_dbscan_view_min(s : TimeseriesanomalydbscanView) -> Double { @_common.min(s.data) }

pub fn timeseries_anomaly_dbscan_view_max(s : TimeseriesanomalydbscanView) -> Double { @_common.max(s.data) }

pub fn timeseries_anomaly_dbscan_view_to_string(s : TimeseriesanomalydbscanView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesanomalydbscanRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_anomaly_dbscan_range_make(size : Int) -> TimeseriesanomalydbscanRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_anomaly_dbscan_range_len(s : TimeseriesanomalydbscanRange) -> Int { s.size }

pub fn timeseries_anomaly_dbscan_range_get(s : TimeseriesanomalydbscanRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_anomaly_dbscan_range_set(s : TimeseriesanomalydbscanRange, i : Int, v : Double) -> TimeseriesanomalydbscanRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_dbscan_range_sum(s : TimeseriesanomalydbscanRange) -> Double { @_common.sum(s.data) }

pub fn timeseries_anomaly_dbscan_range_mean(s : TimeseriesanomalydbscanRange) -> Double { @_common.mean(s.data) }

pub fn timeseries_anomaly_dbscan_range_scale(s : TimeseriesanomalydbscanRange, f : Double) -> TimeseriesanomalydbscanRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_dbscan_range_add(a : TimeseriesanomalydbscanRange, b : TimeseriesanomalydbscanRange) -> TimeseriesanomalydbscanRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_anomaly_dbscan_range_copy(s : TimeseriesanomalydbscanRange) -> TimeseriesanomalydbscanRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_dbscan_range_fill(s : TimeseriesanomalydbscanRange, v : Double) -> TimeseriesanomalydbscanRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_dbscan_range_min(s : TimeseriesanomalydbscanRange) -> Double { @_common.min(s.data) }

pub fn timeseries_anomaly_dbscan_range_max(s : TimeseriesanomalydbscanRange) -> Double { @_common.max(s.data) }

pub fn timeseries_anomaly_dbscan_range_to_string(s : TimeseriesanomalydbscanRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesanomalydbscanSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_anomaly_dbscan_slice_make(size : Int) -> TimeseriesanomalydbscanSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_anomaly_dbscan_slice_len(s : TimeseriesanomalydbscanSlice) -> Int { s.size }

pub fn timeseries_anomaly_dbscan_slice_get(s : TimeseriesanomalydbscanSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_anomaly_dbscan_slice_set(s : TimeseriesanomalydbscanSlice, i : Int, v : Double) -> TimeseriesanomalydbscanSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_dbscan_slice_sum(s : TimeseriesanomalydbscanSlice) -> Double { @_common.sum(s.data) }

pub fn timeseries_anomaly_dbscan_slice_mean(s : TimeseriesanomalydbscanSlice) -> Double { @_common.mean(s.data) }

pub fn timeseries_anomaly_dbscan_slice_scale(s : TimeseriesanomalydbscanSlice, f : Double) -> TimeseriesanomalydbscanSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_dbscan_slice_add(a : TimeseriesanomalydbscanSlice, b : TimeseriesanomalydbscanSlice) -> TimeseriesanomalydbscanSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_anomaly_dbscan_slice_copy(s : TimeseriesanomalydbscanSlice) -> TimeseriesanomalydbscanSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_dbscan_slice_fill(s : TimeseriesanomalydbscanSlice, v : Double) -> TimeseriesanomalydbscanSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_dbscan_slice_min(s : TimeseriesanomalydbscanSlice) -> Double { @_common.min(s.data) }

pub fn timeseries_anomaly_dbscan_slice_max(s : TimeseriesanomalydbscanSlice) -> Double { @_common.max(s.data) }

pub fn timeseries_anomaly_dbscan_slice_to_string(s : TimeseriesanomalydbscanSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

