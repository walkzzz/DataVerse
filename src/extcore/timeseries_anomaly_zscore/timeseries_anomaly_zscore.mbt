///===
/// extcore/timeseries_anomaly_zscore

pub(all) struct TimeseriesanomalyzscorePoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn timeseries_anomaly_zscore_make_point(x : Double, y : Double) -> TimeseriesanomalyzscorePoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn timeseries_anomaly_zscore_make_point3(x : Double, y : Double, z : Double) -> TimeseriesanomalyzscorePoint {
  { x, y, z, label: 0 }
}

pub fn TimeseriesanomalyzscorePoint::x(self : TimeseriesanomalyzscorePoint) -> Double { self.x }

pub fn TimeseriesanomalyzscorePoint::y(self : TimeseriesanomalyzscorePoint) -> Double { self.y }

pub fn TimeseriesanomalyzscorePoint::z(self : TimeseriesanomalyzscorePoint) -> Double { self.z }

pub fn TimeseriesanomalyzscorePoint::label(self : TimeseriesanomalyzscorePoint) -> Int { self.label }

pub fn TimeseriesanomalyzscorePoint::dist(self : TimeseriesanomalyzscorePoint, other : TimeseriesanomalyzscorePoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn TimeseriesanomalyzscorePoint::add(self : TimeseriesanomalyzscorePoint, other : TimeseriesanomalyzscorePoint) -> TimeseriesanomalyzscorePoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn TimeseriesanomalyzscorePoint::sub(self : TimeseriesanomalyzscorePoint, other : TimeseriesanomalyzscorePoint) -> TimeseriesanomalyzscorePoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn TimeseriesanomalyzscorePoint::scale(self : TimeseriesanomalyzscorePoint, s : Double) -> TimeseriesanomalyzscorePoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn TimeseriesanomalyzscorePoint::dot(self : TimeseriesanomalyzscorePoint, other : TimeseriesanomalyzscorePoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn TimeseriesanomalyzscorePoint::cross(self : TimeseriesanomalyzscorePoint, other : TimeseriesanomalyzscorePoint) -> TimeseriesanomalyzscorePoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn TimeseriesanomalyzscorePoint::norm(self : TimeseriesanomalyzscorePoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn TimeseriesanomalyzscorePoint::normalize(self : TimeseriesanomalyzscorePoint) -> TimeseriesanomalyzscorePoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn TimeseriesanomalyzscorePoint::negate(self : TimeseriesanomalyzscorePoint) -> TimeseriesanomalyzscorePoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn TimeseriesanomalyzscorePoint::mid(self : TimeseriesanomalyzscorePoint, other : TimeseriesanomalyzscorePoint) -> TimeseriesanomalyzscorePoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn TimeseriesanomalyzscorePoint::lerp(self : TimeseriesanomalyzscorePoint, other : TimeseriesanomalyzscorePoint, t : Double) -> TimeseriesanomalyzscorePoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn TimeseriesanomalyzscorePoint::to_string(self : TimeseriesanomalyzscorePoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct TimeseriesanomalyzscoreSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn timeseries_anomaly_zscore_make_series(vals : Array[Double], name : String) -> TimeseriesanomalyzscoreSeries {
  { vals, name, meta: 0 }
}

pub fn TimeseriesanomalyzscoreSeries::len(self : TimeseriesanomalyzscoreSeries) -> Int { self.vals.length() }

pub fn TimeseriesanomalyzscoreSeries::sum(self : TimeseriesanomalyzscoreSeries) -> Double { @_common.sum(self.vals) }

pub fn TimeseriesanomalyzscoreSeries::mean(self : TimeseriesanomalyzscoreSeries) -> Double { @_common.mean(self.vals) }

pub fn TimeseriesanomalyzscoreSeries::min(self : TimeseriesanomalyzscoreSeries) -> Double { @_common.min(self.vals) }

pub fn TimeseriesanomalyzscoreSeries::max(self : TimeseriesanomalyzscoreSeries) -> Double { @_common.max(self.vals) }

pub fn TimeseriesanomalyzscoreSeries::range(self : TimeseriesanomalyzscoreSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn TimeseriesanomalyzscoreSeries::variance(self : TimeseriesanomalyzscoreSeries) -> Double { @_common.variance(self.vals) }

pub fn TimeseriesanomalyzscoreSeries::std(self : TimeseriesanomalyzscoreSeries) -> Double { @_common.std(self.vals) }

pub fn TimeseriesanomalyzscoreSeries::median(self : TimeseriesanomalyzscoreSeries) -> Double { @_common.median(self.vals) }

pub fn TimeseriesanomalyzscoreSeries::scale(self : TimeseriesanomalyzscoreSeries, f : Double) -> TimeseriesanomalyzscoreSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn TimeseriesanomalyzscoreSeries::add(self : TimeseriesanomalyzscoreSeries, other : TimeseriesanomalyzscoreSeries) -> TimeseriesanomalyzscoreSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn TimeseriesanomalyzscoreSeries::sub(self : TimeseriesanomalyzscoreSeries, other : TimeseriesanomalyzscoreSeries) -> TimeseriesanomalyzscoreSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn TimeseriesanomalyzscoreSeries::normalize(self : TimeseriesanomalyzscoreSeries) -> TimeseriesanomalyzscoreSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn TimeseriesanomalyzscoreSeries::cumsum(self : TimeseriesanomalyzscoreSeries) -> TimeseriesanomalyzscoreSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn TimeseriesanomalyzscoreSeries::to_string(self : TimeseriesanomalyzscoreSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct TimeseriesanomalyzscoreMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn timeseries_anomaly_zscore_make_matrix(rows : Int, cols : Int, val : Double) -> TimeseriesanomalyzscoreMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn timeseries_anomaly_zscore_matrix_identity(n : Int) -> TimeseriesanomalyzscoreMatrix {
  let m = timeseries_anomaly_zscore_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn TimeseriesanomalyzscoreMatrix::get(self : TimeseriesanomalyzscoreMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn TimeseriesanomalyzscoreMatrix::transpose(self : TimeseriesanomalyzscoreMatrix) -> TimeseriesanomalyzscoreMatrix {
  let result = timeseries_anomaly_zscore_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn TimeseriesanomalyzscoreMatrix::add(self : TimeseriesanomalyzscoreMatrix, other : TimeseriesanomalyzscoreMatrix) -> TimeseriesanomalyzscoreMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = timeseries_anomaly_zscore_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn TimeseriesanomalyzscoreMatrix::scale(self : TimeseriesanomalyzscoreMatrix, s : Double) -> TimeseriesanomalyzscoreMatrix {
  let result = timeseries_anomaly_zscore_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn TimeseriesanomalyzscoreMatrix::multiply(self : TimeseriesanomalyzscoreMatrix, other : TimeseriesanomalyzscoreMatrix) -> TimeseriesanomalyzscoreMatrix {
  if self.cols != other.rows { return timeseries_anomaly_zscore_make_matrix(self.rows, other.cols, 0.0) }
  let result = timeseries_anomaly_zscore_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn TimeseriesanomalyzscoreMatrix::trace(self : TimeseriesanomalyzscoreMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn TimeseriesanomalyzscoreMatrix::det(self : TimeseriesanomalyzscoreMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn TimeseriesanomalyzscoreMatrix::norm(self : TimeseriesanomalyzscoreMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn TimeseriesanomalyzscoreMatrix::to_string(self : TimeseriesanomalyzscoreMatrix) -> String {
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

pub(all) struct TimeseriesanomalyzscoreVector {
  comps : Array[Double]
  dim : Int
}

pub fn timeseries_anomaly_zscore_make_vector(comps : Array[Double]) -> TimeseriesanomalyzscoreVector {
  { comps, dim: comps.length() }
}

pub fn timeseries_anomaly_zscore_vector_zero(dim : Int) -> TimeseriesanomalyzscoreVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn TimeseriesanomalyzscoreVector::add(self : TimeseriesanomalyzscoreVector, other : TimeseriesanomalyzscoreVector) -> TimeseriesanomalyzscoreVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn TimeseriesanomalyzscoreVector::sub(self : TimeseriesanomalyzscoreVector, other : TimeseriesanomalyzscoreVector) -> TimeseriesanomalyzscoreVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn TimeseriesanomalyzscoreVector::scale(self : TimeseriesanomalyzscoreVector, s : Double) -> TimeseriesanomalyzscoreVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn TimeseriesanomalyzscoreVector::dot(self : TimeseriesanomalyzscoreVector, other : TimeseriesanomalyzscoreVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn TimeseriesanomalyzscoreVector::norm(self : TimeseriesanomalyzscoreVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn TimeseriesanomalyzscoreVector::normalize(self : TimeseriesanomalyzscoreVector) -> TimeseriesanomalyzscoreVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn TimeseriesanomalyzscoreVector::dist(self : TimeseriesanomalyzscoreVector, other : TimeseriesanomalyzscoreVector) -> Double {
  self.sub(other).norm()
}

pub fn TimeseriesanomalyzscoreVector::to_string(self : TimeseriesanomalyzscoreVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn timeseries_anomaly_zscore_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn timeseries_anomaly_zscore_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn timeseries_anomaly_zscore_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn timeseries_anomaly_zscore_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn timeseries_anomaly_zscore_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn timeseries_anomaly_zscore_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn timeseries_anomaly_zscore_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn timeseries_anomaly_zscore_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn timeseries_anomaly_zscore_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn timeseries_anomaly_zscore_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn timeseries_anomaly_zscore_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn timeseries_anomaly_zscore_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn timeseries_anomaly_zscore_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn timeseries_anomaly_zscore_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn timeseries_anomaly_zscore_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn timeseries_anomaly_zscore_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn timeseries_anomaly_zscore_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn timeseries_anomaly_zscore_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn timeseries_anomaly_zscore_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn timeseries_anomaly_zscore_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn timeseries_anomaly_zscore_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn timeseries_anomaly_zscore_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn timeseries_anomaly_zscore_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn timeseries_anomaly_zscore_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn timeseries_anomaly_zscore_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn timeseries_anomaly_zscore_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn timeseries_anomaly_zscore_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn timeseries_anomaly_zscore_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn timeseries_anomaly_zscore_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct TimeseriesanomalyzscoreFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_anomaly_zscore_frame_make(size : Int) -> TimeseriesanomalyzscoreFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_anomaly_zscore_frame_len(s : TimeseriesanomalyzscoreFrame) -> Int { s.size }

pub fn timeseries_anomaly_zscore_frame_get(s : TimeseriesanomalyzscoreFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_anomaly_zscore_frame_set(s : TimeseriesanomalyzscoreFrame, i : Int, v : Double) -> TimeseriesanomalyzscoreFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_zscore_frame_sum(s : TimeseriesanomalyzscoreFrame) -> Double { @_common.sum(s.data) }

pub fn timeseries_anomaly_zscore_frame_mean(s : TimeseriesanomalyzscoreFrame) -> Double { @_common.mean(s.data) }

pub fn timeseries_anomaly_zscore_frame_scale(s : TimeseriesanomalyzscoreFrame, f : Double) -> TimeseriesanomalyzscoreFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_zscore_frame_add(a : TimeseriesanomalyzscoreFrame, b : TimeseriesanomalyzscoreFrame) -> TimeseriesanomalyzscoreFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_anomaly_zscore_frame_copy(s : TimeseriesanomalyzscoreFrame) -> TimeseriesanomalyzscoreFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_zscore_frame_fill(s : TimeseriesanomalyzscoreFrame, v : Double) -> TimeseriesanomalyzscoreFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_zscore_frame_min(s : TimeseriesanomalyzscoreFrame) -> Double { @_common.min(s.data) }

pub fn timeseries_anomaly_zscore_frame_max(s : TimeseriesanomalyzscoreFrame) -> Double { @_common.max(s.data) }

pub fn timeseries_anomaly_zscore_frame_to_string(s : TimeseriesanomalyzscoreFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesanomalyzscoreTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_anomaly_zscore_table_make(size : Int) -> TimeseriesanomalyzscoreTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_anomaly_zscore_table_len(s : TimeseriesanomalyzscoreTable) -> Int { s.size }

pub fn timeseries_anomaly_zscore_table_get(s : TimeseriesanomalyzscoreTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_anomaly_zscore_table_set(s : TimeseriesanomalyzscoreTable, i : Int, v : Double) -> TimeseriesanomalyzscoreTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_zscore_table_sum(s : TimeseriesanomalyzscoreTable) -> Double { @_common.sum(s.data) }

pub fn timeseries_anomaly_zscore_table_mean(s : TimeseriesanomalyzscoreTable) -> Double { @_common.mean(s.data) }

pub fn timeseries_anomaly_zscore_table_scale(s : TimeseriesanomalyzscoreTable, f : Double) -> TimeseriesanomalyzscoreTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_zscore_table_add(a : TimeseriesanomalyzscoreTable, b : TimeseriesanomalyzscoreTable) -> TimeseriesanomalyzscoreTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_anomaly_zscore_table_copy(s : TimeseriesanomalyzscoreTable) -> TimeseriesanomalyzscoreTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_zscore_table_fill(s : TimeseriesanomalyzscoreTable, v : Double) -> TimeseriesanomalyzscoreTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_zscore_table_min(s : TimeseriesanomalyzscoreTable) -> Double { @_common.min(s.data) }

pub fn timeseries_anomaly_zscore_table_max(s : TimeseriesanomalyzscoreTable) -> Double { @_common.max(s.data) }

pub fn timeseries_anomaly_zscore_table_to_string(s : TimeseriesanomalyzscoreTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesanomalyzscoreGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_anomaly_zscore_graphn_make(size : Int) -> TimeseriesanomalyzscoreGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_anomaly_zscore_graphn_len(s : TimeseriesanomalyzscoreGraphN) -> Int { s.size }

pub fn timeseries_anomaly_zscore_graphn_get(s : TimeseriesanomalyzscoreGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_anomaly_zscore_graphn_set(s : TimeseriesanomalyzscoreGraphN, i : Int, v : Double) -> TimeseriesanomalyzscoreGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_zscore_graphn_sum(s : TimeseriesanomalyzscoreGraphN) -> Double { @_common.sum(s.data) }

pub fn timeseries_anomaly_zscore_graphn_mean(s : TimeseriesanomalyzscoreGraphN) -> Double { @_common.mean(s.data) }

pub fn timeseries_anomaly_zscore_graphn_scale(s : TimeseriesanomalyzscoreGraphN, f : Double) -> TimeseriesanomalyzscoreGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_zscore_graphn_add(a : TimeseriesanomalyzscoreGraphN, b : TimeseriesanomalyzscoreGraphN) -> TimeseriesanomalyzscoreGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_anomaly_zscore_graphn_copy(s : TimeseriesanomalyzscoreGraphN) -> TimeseriesanomalyzscoreGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_zscore_graphn_fill(s : TimeseriesanomalyzscoreGraphN, v : Double) -> TimeseriesanomalyzscoreGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_zscore_graphn_min(s : TimeseriesanomalyzscoreGraphN) -> Double { @_common.min(s.data) }

pub fn timeseries_anomaly_zscore_graphn_max(s : TimeseriesanomalyzscoreGraphN) -> Double { @_common.max(s.data) }

pub fn timeseries_anomaly_zscore_graphn_to_string(s : TimeseriesanomalyzscoreGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesanomalyzscoreNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_anomaly_zscore_node_make(size : Int) -> TimeseriesanomalyzscoreNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_anomaly_zscore_node_len(s : TimeseriesanomalyzscoreNode) -> Int { s.size }

pub fn timeseries_anomaly_zscore_node_get(s : TimeseriesanomalyzscoreNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_anomaly_zscore_node_set(s : TimeseriesanomalyzscoreNode, i : Int, v : Double) -> TimeseriesanomalyzscoreNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_zscore_node_sum(s : TimeseriesanomalyzscoreNode) -> Double { @_common.sum(s.data) }

pub fn timeseries_anomaly_zscore_node_mean(s : TimeseriesanomalyzscoreNode) -> Double { @_common.mean(s.data) }

pub fn timeseries_anomaly_zscore_node_scale(s : TimeseriesanomalyzscoreNode, f : Double) -> TimeseriesanomalyzscoreNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_zscore_node_add(a : TimeseriesanomalyzscoreNode, b : TimeseriesanomalyzscoreNode) -> TimeseriesanomalyzscoreNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_anomaly_zscore_node_copy(s : TimeseriesanomalyzscoreNode) -> TimeseriesanomalyzscoreNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_zscore_node_fill(s : TimeseriesanomalyzscoreNode, v : Double) -> TimeseriesanomalyzscoreNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_zscore_node_min(s : TimeseriesanomalyzscoreNode) -> Double { @_common.min(s.data) }

pub fn timeseries_anomaly_zscore_node_max(s : TimeseriesanomalyzscoreNode) -> Double { @_common.max(s.data) }

pub fn timeseries_anomaly_zscore_node_to_string(s : TimeseriesanomalyzscoreNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesanomalyzscoreEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_anomaly_zscore_edge_make(size : Int) -> TimeseriesanomalyzscoreEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_anomaly_zscore_edge_len(s : TimeseriesanomalyzscoreEdge) -> Int { s.size }

pub fn timeseries_anomaly_zscore_edge_get(s : TimeseriesanomalyzscoreEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_anomaly_zscore_edge_set(s : TimeseriesanomalyzscoreEdge, i : Int, v : Double) -> TimeseriesanomalyzscoreEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_zscore_edge_sum(s : TimeseriesanomalyzscoreEdge) -> Double { @_common.sum(s.data) }

pub fn timeseries_anomaly_zscore_edge_mean(s : TimeseriesanomalyzscoreEdge) -> Double { @_common.mean(s.data) }

pub fn timeseries_anomaly_zscore_edge_scale(s : TimeseriesanomalyzscoreEdge, f : Double) -> TimeseriesanomalyzscoreEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_zscore_edge_add(a : TimeseriesanomalyzscoreEdge, b : TimeseriesanomalyzscoreEdge) -> TimeseriesanomalyzscoreEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_anomaly_zscore_edge_copy(s : TimeseriesanomalyzscoreEdge) -> TimeseriesanomalyzscoreEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_zscore_edge_fill(s : TimeseriesanomalyzscoreEdge, v : Double) -> TimeseriesanomalyzscoreEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_zscore_edge_min(s : TimeseriesanomalyzscoreEdge) -> Double { @_common.min(s.data) }

pub fn timeseries_anomaly_zscore_edge_max(s : TimeseriesanomalyzscoreEdge) -> Double { @_common.max(s.data) }

pub fn timeseries_anomaly_zscore_edge_to_string(s : TimeseriesanomalyzscoreEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesanomalyzscorePath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_anomaly_zscore_path_make(size : Int) -> TimeseriesanomalyzscorePath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_anomaly_zscore_path_len(s : TimeseriesanomalyzscorePath) -> Int { s.size }

pub fn timeseries_anomaly_zscore_path_get(s : TimeseriesanomalyzscorePath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_anomaly_zscore_path_set(s : TimeseriesanomalyzscorePath, i : Int, v : Double) -> TimeseriesanomalyzscorePath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_zscore_path_sum(s : TimeseriesanomalyzscorePath) -> Double { @_common.sum(s.data) }

pub fn timeseries_anomaly_zscore_path_mean(s : TimeseriesanomalyzscorePath) -> Double { @_common.mean(s.data) }

pub fn timeseries_anomaly_zscore_path_scale(s : TimeseriesanomalyzscorePath, f : Double) -> TimeseriesanomalyzscorePath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_zscore_path_add(a : TimeseriesanomalyzscorePath, b : TimeseriesanomalyzscorePath) -> TimeseriesanomalyzscorePath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_anomaly_zscore_path_copy(s : TimeseriesanomalyzscorePath) -> TimeseriesanomalyzscorePath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_zscore_path_fill(s : TimeseriesanomalyzscorePath, v : Double) -> TimeseriesanomalyzscorePath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_zscore_path_min(s : TimeseriesanomalyzscorePath) -> Double { @_common.min(s.data) }

pub fn timeseries_anomaly_zscore_path_max(s : TimeseriesanomalyzscorePath) -> Double { @_common.max(s.data) }

pub fn timeseries_anomaly_zscore_path_to_string(s : TimeseriesanomalyzscorePath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesanomalyzscoreCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_anomaly_zscore_cluster_make(size : Int) -> TimeseriesanomalyzscoreCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_anomaly_zscore_cluster_len(s : TimeseriesanomalyzscoreCluster) -> Int { s.size }

pub fn timeseries_anomaly_zscore_cluster_get(s : TimeseriesanomalyzscoreCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_anomaly_zscore_cluster_set(s : TimeseriesanomalyzscoreCluster, i : Int, v : Double) -> TimeseriesanomalyzscoreCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_zscore_cluster_sum(s : TimeseriesanomalyzscoreCluster) -> Double { @_common.sum(s.data) }

pub fn timeseries_anomaly_zscore_cluster_mean(s : TimeseriesanomalyzscoreCluster) -> Double { @_common.mean(s.data) }

pub fn timeseries_anomaly_zscore_cluster_scale(s : TimeseriesanomalyzscoreCluster, f : Double) -> TimeseriesanomalyzscoreCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_zscore_cluster_add(a : TimeseriesanomalyzscoreCluster, b : TimeseriesanomalyzscoreCluster) -> TimeseriesanomalyzscoreCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_anomaly_zscore_cluster_copy(s : TimeseriesanomalyzscoreCluster) -> TimeseriesanomalyzscoreCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_zscore_cluster_fill(s : TimeseriesanomalyzscoreCluster, v : Double) -> TimeseriesanomalyzscoreCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_zscore_cluster_min(s : TimeseriesanomalyzscoreCluster) -> Double { @_common.min(s.data) }

pub fn timeseries_anomaly_zscore_cluster_max(s : TimeseriesanomalyzscoreCluster) -> Double { @_common.max(s.data) }

pub fn timeseries_anomaly_zscore_cluster_to_string(s : TimeseriesanomalyzscoreCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesanomalyzscoreModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_anomaly_zscore_model_make(size : Int) -> TimeseriesanomalyzscoreModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_anomaly_zscore_model_len(s : TimeseriesanomalyzscoreModel) -> Int { s.size }

pub fn timeseries_anomaly_zscore_model_get(s : TimeseriesanomalyzscoreModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_anomaly_zscore_model_set(s : TimeseriesanomalyzscoreModel, i : Int, v : Double) -> TimeseriesanomalyzscoreModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_zscore_model_sum(s : TimeseriesanomalyzscoreModel) -> Double { @_common.sum(s.data) }

pub fn timeseries_anomaly_zscore_model_mean(s : TimeseriesanomalyzscoreModel) -> Double { @_common.mean(s.data) }

pub fn timeseries_anomaly_zscore_model_scale(s : TimeseriesanomalyzscoreModel, f : Double) -> TimeseriesanomalyzscoreModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_zscore_model_add(a : TimeseriesanomalyzscoreModel, b : TimeseriesanomalyzscoreModel) -> TimeseriesanomalyzscoreModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_anomaly_zscore_model_copy(s : TimeseriesanomalyzscoreModel) -> TimeseriesanomalyzscoreModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_zscore_model_fill(s : TimeseriesanomalyzscoreModel, v : Double) -> TimeseriesanomalyzscoreModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_zscore_model_min(s : TimeseriesanomalyzscoreModel) -> Double { @_common.min(s.data) }

pub fn timeseries_anomaly_zscore_model_max(s : TimeseriesanomalyzscoreModel) -> Double { @_common.max(s.data) }

pub fn timeseries_anomaly_zscore_model_to_string(s : TimeseriesanomalyzscoreModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesanomalyzscoreLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_anomaly_zscore_layer_make(size : Int) -> TimeseriesanomalyzscoreLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_anomaly_zscore_layer_len(s : TimeseriesanomalyzscoreLayer) -> Int { s.size }

pub fn timeseries_anomaly_zscore_layer_get(s : TimeseriesanomalyzscoreLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_anomaly_zscore_layer_set(s : TimeseriesanomalyzscoreLayer, i : Int, v : Double) -> TimeseriesanomalyzscoreLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_zscore_layer_sum(s : TimeseriesanomalyzscoreLayer) -> Double { @_common.sum(s.data) }

pub fn timeseries_anomaly_zscore_layer_mean(s : TimeseriesanomalyzscoreLayer) -> Double { @_common.mean(s.data) }

pub fn timeseries_anomaly_zscore_layer_scale(s : TimeseriesanomalyzscoreLayer, f : Double) -> TimeseriesanomalyzscoreLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_zscore_layer_add(a : TimeseriesanomalyzscoreLayer, b : TimeseriesanomalyzscoreLayer) -> TimeseriesanomalyzscoreLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_anomaly_zscore_layer_copy(s : TimeseriesanomalyzscoreLayer) -> TimeseriesanomalyzscoreLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_zscore_layer_fill(s : TimeseriesanomalyzscoreLayer, v : Double) -> TimeseriesanomalyzscoreLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_zscore_layer_min(s : TimeseriesanomalyzscoreLayer) -> Double { @_common.min(s.data) }

pub fn timeseries_anomaly_zscore_layer_max(s : TimeseriesanomalyzscoreLayer) -> Double { @_common.max(s.data) }

pub fn timeseries_anomaly_zscore_layer_to_string(s : TimeseriesanomalyzscoreLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesanomalyzscoreBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_anomaly_zscore_buffer_make(size : Int) -> TimeseriesanomalyzscoreBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_anomaly_zscore_buffer_len(s : TimeseriesanomalyzscoreBuffer) -> Int { s.size }

pub fn timeseries_anomaly_zscore_buffer_get(s : TimeseriesanomalyzscoreBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_anomaly_zscore_buffer_set(s : TimeseriesanomalyzscoreBuffer, i : Int, v : Double) -> TimeseriesanomalyzscoreBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_zscore_buffer_sum(s : TimeseriesanomalyzscoreBuffer) -> Double { @_common.sum(s.data) }

pub fn timeseries_anomaly_zscore_buffer_mean(s : TimeseriesanomalyzscoreBuffer) -> Double { @_common.mean(s.data) }

pub fn timeseries_anomaly_zscore_buffer_scale(s : TimeseriesanomalyzscoreBuffer, f : Double) -> TimeseriesanomalyzscoreBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_zscore_buffer_add(a : TimeseriesanomalyzscoreBuffer, b : TimeseriesanomalyzscoreBuffer) -> TimeseriesanomalyzscoreBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_anomaly_zscore_buffer_copy(s : TimeseriesanomalyzscoreBuffer) -> TimeseriesanomalyzscoreBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_zscore_buffer_fill(s : TimeseriesanomalyzscoreBuffer, v : Double) -> TimeseriesanomalyzscoreBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_zscore_buffer_min(s : TimeseriesanomalyzscoreBuffer) -> Double { @_common.min(s.data) }

pub fn timeseries_anomaly_zscore_buffer_max(s : TimeseriesanomalyzscoreBuffer) -> Double { @_common.max(s.data) }

pub fn timeseries_anomaly_zscore_buffer_to_string(s : TimeseriesanomalyzscoreBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesanomalyzscoreCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_anomaly_zscore_cursor_make(size : Int) -> TimeseriesanomalyzscoreCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_anomaly_zscore_cursor_len(s : TimeseriesanomalyzscoreCursor) -> Int { s.size }

pub fn timeseries_anomaly_zscore_cursor_get(s : TimeseriesanomalyzscoreCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_anomaly_zscore_cursor_set(s : TimeseriesanomalyzscoreCursor, i : Int, v : Double) -> TimeseriesanomalyzscoreCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_zscore_cursor_sum(s : TimeseriesanomalyzscoreCursor) -> Double { @_common.sum(s.data) }

pub fn timeseries_anomaly_zscore_cursor_mean(s : TimeseriesanomalyzscoreCursor) -> Double { @_common.mean(s.data) }

pub fn timeseries_anomaly_zscore_cursor_scale(s : TimeseriesanomalyzscoreCursor, f : Double) -> TimeseriesanomalyzscoreCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_zscore_cursor_add(a : TimeseriesanomalyzscoreCursor, b : TimeseriesanomalyzscoreCursor) -> TimeseriesanomalyzscoreCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_anomaly_zscore_cursor_copy(s : TimeseriesanomalyzscoreCursor) -> TimeseriesanomalyzscoreCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_zscore_cursor_fill(s : TimeseriesanomalyzscoreCursor, v : Double) -> TimeseriesanomalyzscoreCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_zscore_cursor_min(s : TimeseriesanomalyzscoreCursor) -> Double { @_common.min(s.data) }

pub fn timeseries_anomaly_zscore_cursor_max(s : TimeseriesanomalyzscoreCursor) -> Double { @_common.max(s.data) }

pub fn timeseries_anomaly_zscore_cursor_to_string(s : TimeseriesanomalyzscoreCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesanomalyzscoreView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_anomaly_zscore_view_make(size : Int) -> TimeseriesanomalyzscoreView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_anomaly_zscore_view_len(s : TimeseriesanomalyzscoreView) -> Int { s.size }

pub fn timeseries_anomaly_zscore_view_get(s : TimeseriesanomalyzscoreView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_anomaly_zscore_view_set(s : TimeseriesanomalyzscoreView, i : Int, v : Double) -> TimeseriesanomalyzscoreView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_zscore_view_sum(s : TimeseriesanomalyzscoreView) -> Double { @_common.sum(s.data) }

pub fn timeseries_anomaly_zscore_view_mean(s : TimeseriesanomalyzscoreView) -> Double { @_common.mean(s.data) }

pub fn timeseries_anomaly_zscore_view_scale(s : TimeseriesanomalyzscoreView, f : Double) -> TimeseriesanomalyzscoreView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_zscore_view_add(a : TimeseriesanomalyzscoreView, b : TimeseriesanomalyzscoreView) -> TimeseriesanomalyzscoreView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_anomaly_zscore_view_copy(s : TimeseriesanomalyzscoreView) -> TimeseriesanomalyzscoreView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_zscore_view_fill(s : TimeseriesanomalyzscoreView, v : Double) -> TimeseriesanomalyzscoreView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_zscore_view_min(s : TimeseriesanomalyzscoreView) -> Double { @_common.min(s.data) }

pub fn timeseries_anomaly_zscore_view_max(s : TimeseriesanomalyzscoreView) -> Double { @_common.max(s.data) }

pub fn timeseries_anomaly_zscore_view_to_string(s : TimeseriesanomalyzscoreView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesanomalyzscoreRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_anomaly_zscore_range_make(size : Int) -> TimeseriesanomalyzscoreRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_anomaly_zscore_range_len(s : TimeseriesanomalyzscoreRange) -> Int { s.size }

pub fn timeseries_anomaly_zscore_range_get(s : TimeseriesanomalyzscoreRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_anomaly_zscore_range_set(s : TimeseriesanomalyzscoreRange, i : Int, v : Double) -> TimeseriesanomalyzscoreRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_zscore_range_sum(s : TimeseriesanomalyzscoreRange) -> Double { @_common.sum(s.data) }

pub fn timeseries_anomaly_zscore_range_mean(s : TimeseriesanomalyzscoreRange) -> Double { @_common.mean(s.data) }

pub fn timeseries_anomaly_zscore_range_scale(s : TimeseriesanomalyzscoreRange, f : Double) -> TimeseriesanomalyzscoreRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_zscore_range_add(a : TimeseriesanomalyzscoreRange, b : TimeseriesanomalyzscoreRange) -> TimeseriesanomalyzscoreRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_anomaly_zscore_range_copy(s : TimeseriesanomalyzscoreRange) -> TimeseriesanomalyzscoreRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_zscore_range_fill(s : TimeseriesanomalyzscoreRange, v : Double) -> TimeseriesanomalyzscoreRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_zscore_range_min(s : TimeseriesanomalyzscoreRange) -> Double { @_common.min(s.data) }

pub fn timeseries_anomaly_zscore_range_max(s : TimeseriesanomalyzscoreRange) -> Double { @_common.max(s.data) }

pub fn timeseries_anomaly_zscore_range_to_string(s : TimeseriesanomalyzscoreRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesanomalyzscoreSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_anomaly_zscore_slice_make(size : Int) -> TimeseriesanomalyzscoreSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_anomaly_zscore_slice_len(s : TimeseriesanomalyzscoreSlice) -> Int { s.size }

pub fn timeseries_anomaly_zscore_slice_get(s : TimeseriesanomalyzscoreSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_anomaly_zscore_slice_set(s : TimeseriesanomalyzscoreSlice, i : Int, v : Double) -> TimeseriesanomalyzscoreSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_zscore_slice_sum(s : TimeseriesanomalyzscoreSlice) -> Double { @_common.sum(s.data) }

pub fn timeseries_anomaly_zscore_slice_mean(s : TimeseriesanomalyzscoreSlice) -> Double { @_common.mean(s.data) }

pub fn timeseries_anomaly_zscore_slice_scale(s : TimeseriesanomalyzscoreSlice, f : Double) -> TimeseriesanomalyzscoreSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_zscore_slice_add(a : TimeseriesanomalyzscoreSlice, b : TimeseriesanomalyzscoreSlice) -> TimeseriesanomalyzscoreSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_anomaly_zscore_slice_copy(s : TimeseriesanomalyzscoreSlice) -> TimeseriesanomalyzscoreSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_zscore_slice_fill(s : TimeseriesanomalyzscoreSlice, v : Double) -> TimeseriesanomalyzscoreSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_zscore_slice_min(s : TimeseriesanomalyzscoreSlice) -> Double { @_common.min(s.data) }

pub fn timeseries_anomaly_zscore_slice_max(s : TimeseriesanomalyzscoreSlice) -> Double { @_common.max(s.data) }

pub fn timeseries_anomaly_zscore_slice_to_string(s : TimeseriesanomalyzscoreSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

