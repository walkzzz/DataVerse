///===
/// extcore/timeseries_anomaly_prophet

pub(all) struct TimeseriesanomalyprophetPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn timeseries_anomaly_prophet_make_point(x : Double, y : Double) -> TimeseriesanomalyprophetPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn timeseries_anomaly_prophet_make_point3(x : Double, y : Double, z : Double) -> TimeseriesanomalyprophetPoint {
  { x, y, z, label: 0 }
}

pub fn TimeseriesanomalyprophetPoint::x(self : TimeseriesanomalyprophetPoint) -> Double { self.x }

pub fn TimeseriesanomalyprophetPoint::y(self : TimeseriesanomalyprophetPoint) -> Double { self.y }

pub fn TimeseriesanomalyprophetPoint::z(self : TimeseriesanomalyprophetPoint) -> Double { self.z }

pub fn TimeseriesanomalyprophetPoint::label(self : TimeseriesanomalyprophetPoint) -> Int { self.label }

pub fn TimeseriesanomalyprophetPoint::dist(self : TimeseriesanomalyprophetPoint, other : TimeseriesanomalyprophetPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn TimeseriesanomalyprophetPoint::add(self : TimeseriesanomalyprophetPoint, other : TimeseriesanomalyprophetPoint) -> TimeseriesanomalyprophetPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn TimeseriesanomalyprophetPoint::sub(self : TimeseriesanomalyprophetPoint, other : TimeseriesanomalyprophetPoint) -> TimeseriesanomalyprophetPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn TimeseriesanomalyprophetPoint::scale(self : TimeseriesanomalyprophetPoint, s : Double) -> TimeseriesanomalyprophetPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn TimeseriesanomalyprophetPoint::dot(self : TimeseriesanomalyprophetPoint, other : TimeseriesanomalyprophetPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn TimeseriesanomalyprophetPoint::cross(self : TimeseriesanomalyprophetPoint, other : TimeseriesanomalyprophetPoint) -> TimeseriesanomalyprophetPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn TimeseriesanomalyprophetPoint::norm(self : TimeseriesanomalyprophetPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn TimeseriesanomalyprophetPoint::normalize(self : TimeseriesanomalyprophetPoint) -> TimeseriesanomalyprophetPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn TimeseriesanomalyprophetPoint::negate(self : TimeseriesanomalyprophetPoint) -> TimeseriesanomalyprophetPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn TimeseriesanomalyprophetPoint::mid(self : TimeseriesanomalyprophetPoint, other : TimeseriesanomalyprophetPoint) -> TimeseriesanomalyprophetPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn TimeseriesanomalyprophetPoint::lerp(self : TimeseriesanomalyprophetPoint, other : TimeseriesanomalyprophetPoint, t : Double) -> TimeseriesanomalyprophetPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn TimeseriesanomalyprophetPoint::to_string(self : TimeseriesanomalyprophetPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct TimeseriesanomalyprophetSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn timeseries_anomaly_prophet_make_series(vals : Array[Double], name : String) -> TimeseriesanomalyprophetSeries {
  { vals, name, meta: 0 }
}

pub fn TimeseriesanomalyprophetSeries::len(self : TimeseriesanomalyprophetSeries) -> Int { self.vals.length() }

pub fn TimeseriesanomalyprophetSeries::sum(self : TimeseriesanomalyprophetSeries) -> Double { @_common.sum(self.vals) }

pub fn TimeseriesanomalyprophetSeries::mean(self : TimeseriesanomalyprophetSeries) -> Double { @_common.mean(self.vals) }

pub fn TimeseriesanomalyprophetSeries::min(self : TimeseriesanomalyprophetSeries) -> Double { @_common.min(self.vals) }

pub fn TimeseriesanomalyprophetSeries::max(self : TimeseriesanomalyprophetSeries) -> Double { @_common.max(self.vals) }

pub fn TimeseriesanomalyprophetSeries::range(self : TimeseriesanomalyprophetSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn TimeseriesanomalyprophetSeries::variance(self : TimeseriesanomalyprophetSeries) -> Double { @_common.variance(self.vals) }

pub fn TimeseriesanomalyprophetSeries::std(self : TimeseriesanomalyprophetSeries) -> Double { @_common.std(self.vals) }

pub fn TimeseriesanomalyprophetSeries::median(self : TimeseriesanomalyprophetSeries) -> Double { @_common.median(self.vals) }

pub fn TimeseriesanomalyprophetSeries::scale(self : TimeseriesanomalyprophetSeries, f : Double) -> TimeseriesanomalyprophetSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn TimeseriesanomalyprophetSeries::add(self : TimeseriesanomalyprophetSeries, other : TimeseriesanomalyprophetSeries) -> TimeseriesanomalyprophetSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn TimeseriesanomalyprophetSeries::sub(self : TimeseriesanomalyprophetSeries, other : TimeseriesanomalyprophetSeries) -> TimeseriesanomalyprophetSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn TimeseriesanomalyprophetSeries::normalize(self : TimeseriesanomalyprophetSeries) -> TimeseriesanomalyprophetSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn TimeseriesanomalyprophetSeries::cumsum(self : TimeseriesanomalyprophetSeries) -> TimeseriesanomalyprophetSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn TimeseriesanomalyprophetSeries::to_string(self : TimeseriesanomalyprophetSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct TimeseriesanomalyprophetMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn timeseries_anomaly_prophet_make_matrix(rows : Int, cols : Int, val : Double) -> TimeseriesanomalyprophetMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn timeseries_anomaly_prophet_matrix_identity(n : Int) -> TimeseriesanomalyprophetMatrix {
  let m = timeseries_anomaly_prophet_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn TimeseriesanomalyprophetMatrix::get(self : TimeseriesanomalyprophetMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn TimeseriesanomalyprophetMatrix::transpose(self : TimeseriesanomalyprophetMatrix) -> TimeseriesanomalyprophetMatrix {
  let result = timeseries_anomaly_prophet_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn TimeseriesanomalyprophetMatrix::add(self : TimeseriesanomalyprophetMatrix, other : TimeseriesanomalyprophetMatrix) -> TimeseriesanomalyprophetMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = timeseries_anomaly_prophet_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn TimeseriesanomalyprophetMatrix::scale(self : TimeseriesanomalyprophetMatrix, s : Double) -> TimeseriesanomalyprophetMatrix {
  let result = timeseries_anomaly_prophet_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn TimeseriesanomalyprophetMatrix::multiply(self : TimeseriesanomalyprophetMatrix, other : TimeseriesanomalyprophetMatrix) -> TimeseriesanomalyprophetMatrix {
  if self.cols != other.rows { return timeseries_anomaly_prophet_make_matrix(self.rows, other.cols, 0.0) }
  let result = timeseries_anomaly_prophet_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn TimeseriesanomalyprophetMatrix::trace(self : TimeseriesanomalyprophetMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn TimeseriesanomalyprophetMatrix::det(self : TimeseriesanomalyprophetMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn TimeseriesanomalyprophetMatrix::norm(self : TimeseriesanomalyprophetMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn TimeseriesanomalyprophetMatrix::to_string(self : TimeseriesanomalyprophetMatrix) -> String {
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

pub(all) struct TimeseriesanomalyprophetVector {
  comps : Array[Double]
  dim : Int
}

pub fn timeseries_anomaly_prophet_make_vector(comps : Array[Double]) -> TimeseriesanomalyprophetVector {
  { comps, dim: comps.length() }
}

pub fn timeseries_anomaly_prophet_vector_zero(dim : Int) -> TimeseriesanomalyprophetVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn TimeseriesanomalyprophetVector::add(self : TimeseriesanomalyprophetVector, other : TimeseriesanomalyprophetVector) -> TimeseriesanomalyprophetVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn TimeseriesanomalyprophetVector::sub(self : TimeseriesanomalyprophetVector, other : TimeseriesanomalyprophetVector) -> TimeseriesanomalyprophetVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn TimeseriesanomalyprophetVector::scale(self : TimeseriesanomalyprophetVector, s : Double) -> TimeseriesanomalyprophetVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn TimeseriesanomalyprophetVector::dot(self : TimeseriesanomalyprophetVector, other : TimeseriesanomalyprophetVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn TimeseriesanomalyprophetVector::norm(self : TimeseriesanomalyprophetVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn TimeseriesanomalyprophetVector::normalize(self : TimeseriesanomalyprophetVector) -> TimeseriesanomalyprophetVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn TimeseriesanomalyprophetVector::dist(self : TimeseriesanomalyprophetVector, other : TimeseriesanomalyprophetVector) -> Double {
  self.sub(other).norm()
}

pub fn TimeseriesanomalyprophetVector::to_string(self : TimeseriesanomalyprophetVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn timeseries_anomaly_prophet_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn timeseries_anomaly_prophet_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn timeseries_anomaly_prophet_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn timeseries_anomaly_prophet_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn timeseries_anomaly_prophet_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn timeseries_anomaly_prophet_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn timeseries_anomaly_prophet_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn timeseries_anomaly_prophet_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn timeseries_anomaly_prophet_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn timeseries_anomaly_prophet_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn timeseries_anomaly_prophet_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn timeseries_anomaly_prophet_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn timeseries_anomaly_prophet_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn timeseries_anomaly_prophet_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn timeseries_anomaly_prophet_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn timeseries_anomaly_prophet_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn timeseries_anomaly_prophet_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn timeseries_anomaly_prophet_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn timeseries_anomaly_prophet_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn timeseries_anomaly_prophet_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn timeseries_anomaly_prophet_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn timeseries_anomaly_prophet_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn timeseries_anomaly_prophet_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn timeseries_anomaly_prophet_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn timeseries_anomaly_prophet_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn timeseries_anomaly_prophet_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn timeseries_anomaly_prophet_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn timeseries_anomaly_prophet_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn timeseries_anomaly_prophet_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct TimeseriesanomalyprophetFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_anomaly_prophet_frame_make(size : Int) -> TimeseriesanomalyprophetFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_anomaly_prophet_frame_len(s : TimeseriesanomalyprophetFrame) -> Int { s.size }

pub fn timeseries_anomaly_prophet_frame_get(s : TimeseriesanomalyprophetFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_anomaly_prophet_frame_set(s : TimeseriesanomalyprophetFrame, i : Int, v : Double) -> TimeseriesanomalyprophetFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_prophet_frame_sum(s : TimeseriesanomalyprophetFrame) -> Double { @_common.sum(s.data) }

pub fn timeseries_anomaly_prophet_frame_mean(s : TimeseriesanomalyprophetFrame) -> Double { @_common.mean(s.data) }

pub fn timeseries_anomaly_prophet_frame_scale(s : TimeseriesanomalyprophetFrame, f : Double) -> TimeseriesanomalyprophetFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_prophet_frame_add(a : TimeseriesanomalyprophetFrame, b : TimeseriesanomalyprophetFrame) -> TimeseriesanomalyprophetFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_anomaly_prophet_frame_copy(s : TimeseriesanomalyprophetFrame) -> TimeseriesanomalyprophetFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_prophet_frame_fill(s : TimeseriesanomalyprophetFrame, v : Double) -> TimeseriesanomalyprophetFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_prophet_frame_min(s : TimeseriesanomalyprophetFrame) -> Double { @_common.min(s.data) }

pub fn timeseries_anomaly_prophet_frame_max(s : TimeseriesanomalyprophetFrame) -> Double { @_common.max(s.data) }

pub fn timeseries_anomaly_prophet_frame_to_string(s : TimeseriesanomalyprophetFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesanomalyprophetTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_anomaly_prophet_table_make(size : Int) -> TimeseriesanomalyprophetTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_anomaly_prophet_table_len(s : TimeseriesanomalyprophetTable) -> Int { s.size }

pub fn timeseries_anomaly_prophet_table_get(s : TimeseriesanomalyprophetTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_anomaly_prophet_table_set(s : TimeseriesanomalyprophetTable, i : Int, v : Double) -> TimeseriesanomalyprophetTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_prophet_table_sum(s : TimeseriesanomalyprophetTable) -> Double { @_common.sum(s.data) }

pub fn timeseries_anomaly_prophet_table_mean(s : TimeseriesanomalyprophetTable) -> Double { @_common.mean(s.data) }

pub fn timeseries_anomaly_prophet_table_scale(s : TimeseriesanomalyprophetTable, f : Double) -> TimeseriesanomalyprophetTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_prophet_table_add(a : TimeseriesanomalyprophetTable, b : TimeseriesanomalyprophetTable) -> TimeseriesanomalyprophetTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_anomaly_prophet_table_copy(s : TimeseriesanomalyprophetTable) -> TimeseriesanomalyprophetTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_prophet_table_fill(s : TimeseriesanomalyprophetTable, v : Double) -> TimeseriesanomalyprophetTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_prophet_table_min(s : TimeseriesanomalyprophetTable) -> Double { @_common.min(s.data) }

pub fn timeseries_anomaly_prophet_table_max(s : TimeseriesanomalyprophetTable) -> Double { @_common.max(s.data) }

pub fn timeseries_anomaly_prophet_table_to_string(s : TimeseriesanomalyprophetTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesanomalyprophetGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_anomaly_prophet_graphn_make(size : Int) -> TimeseriesanomalyprophetGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_anomaly_prophet_graphn_len(s : TimeseriesanomalyprophetGraphN) -> Int { s.size }

pub fn timeseries_anomaly_prophet_graphn_get(s : TimeseriesanomalyprophetGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_anomaly_prophet_graphn_set(s : TimeseriesanomalyprophetGraphN, i : Int, v : Double) -> TimeseriesanomalyprophetGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_prophet_graphn_sum(s : TimeseriesanomalyprophetGraphN) -> Double { @_common.sum(s.data) }

pub fn timeseries_anomaly_prophet_graphn_mean(s : TimeseriesanomalyprophetGraphN) -> Double { @_common.mean(s.data) }

pub fn timeseries_anomaly_prophet_graphn_scale(s : TimeseriesanomalyprophetGraphN, f : Double) -> TimeseriesanomalyprophetGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_prophet_graphn_add(a : TimeseriesanomalyprophetGraphN, b : TimeseriesanomalyprophetGraphN) -> TimeseriesanomalyprophetGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_anomaly_prophet_graphn_copy(s : TimeseriesanomalyprophetGraphN) -> TimeseriesanomalyprophetGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_prophet_graphn_fill(s : TimeseriesanomalyprophetGraphN, v : Double) -> TimeseriesanomalyprophetGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_prophet_graphn_min(s : TimeseriesanomalyprophetGraphN) -> Double { @_common.min(s.data) }

pub fn timeseries_anomaly_prophet_graphn_max(s : TimeseriesanomalyprophetGraphN) -> Double { @_common.max(s.data) }

pub fn timeseries_anomaly_prophet_graphn_to_string(s : TimeseriesanomalyprophetGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesanomalyprophetNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_anomaly_prophet_node_make(size : Int) -> TimeseriesanomalyprophetNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_anomaly_prophet_node_len(s : TimeseriesanomalyprophetNode) -> Int { s.size }

pub fn timeseries_anomaly_prophet_node_get(s : TimeseriesanomalyprophetNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_anomaly_prophet_node_set(s : TimeseriesanomalyprophetNode, i : Int, v : Double) -> TimeseriesanomalyprophetNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_prophet_node_sum(s : TimeseriesanomalyprophetNode) -> Double { @_common.sum(s.data) }

pub fn timeseries_anomaly_prophet_node_mean(s : TimeseriesanomalyprophetNode) -> Double { @_common.mean(s.data) }

pub fn timeseries_anomaly_prophet_node_scale(s : TimeseriesanomalyprophetNode, f : Double) -> TimeseriesanomalyprophetNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_prophet_node_add(a : TimeseriesanomalyprophetNode, b : TimeseriesanomalyprophetNode) -> TimeseriesanomalyprophetNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_anomaly_prophet_node_copy(s : TimeseriesanomalyprophetNode) -> TimeseriesanomalyprophetNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_prophet_node_fill(s : TimeseriesanomalyprophetNode, v : Double) -> TimeseriesanomalyprophetNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_prophet_node_min(s : TimeseriesanomalyprophetNode) -> Double { @_common.min(s.data) }

pub fn timeseries_anomaly_prophet_node_max(s : TimeseriesanomalyprophetNode) -> Double { @_common.max(s.data) }

pub fn timeseries_anomaly_prophet_node_to_string(s : TimeseriesanomalyprophetNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesanomalyprophetEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_anomaly_prophet_edge_make(size : Int) -> TimeseriesanomalyprophetEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_anomaly_prophet_edge_len(s : TimeseriesanomalyprophetEdge) -> Int { s.size }

pub fn timeseries_anomaly_prophet_edge_get(s : TimeseriesanomalyprophetEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_anomaly_prophet_edge_set(s : TimeseriesanomalyprophetEdge, i : Int, v : Double) -> TimeseriesanomalyprophetEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_prophet_edge_sum(s : TimeseriesanomalyprophetEdge) -> Double { @_common.sum(s.data) }

pub fn timeseries_anomaly_prophet_edge_mean(s : TimeseriesanomalyprophetEdge) -> Double { @_common.mean(s.data) }

pub fn timeseries_anomaly_prophet_edge_scale(s : TimeseriesanomalyprophetEdge, f : Double) -> TimeseriesanomalyprophetEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_prophet_edge_add(a : TimeseriesanomalyprophetEdge, b : TimeseriesanomalyprophetEdge) -> TimeseriesanomalyprophetEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_anomaly_prophet_edge_copy(s : TimeseriesanomalyprophetEdge) -> TimeseriesanomalyprophetEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_prophet_edge_fill(s : TimeseriesanomalyprophetEdge, v : Double) -> TimeseriesanomalyprophetEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_prophet_edge_min(s : TimeseriesanomalyprophetEdge) -> Double { @_common.min(s.data) }

pub fn timeseries_anomaly_prophet_edge_max(s : TimeseriesanomalyprophetEdge) -> Double { @_common.max(s.data) }

pub fn timeseries_anomaly_prophet_edge_to_string(s : TimeseriesanomalyprophetEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesanomalyprophetPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_anomaly_prophet_path_make(size : Int) -> TimeseriesanomalyprophetPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_anomaly_prophet_path_len(s : TimeseriesanomalyprophetPath) -> Int { s.size }

pub fn timeseries_anomaly_prophet_path_get(s : TimeseriesanomalyprophetPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_anomaly_prophet_path_set(s : TimeseriesanomalyprophetPath, i : Int, v : Double) -> TimeseriesanomalyprophetPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_prophet_path_sum(s : TimeseriesanomalyprophetPath) -> Double { @_common.sum(s.data) }

pub fn timeseries_anomaly_prophet_path_mean(s : TimeseriesanomalyprophetPath) -> Double { @_common.mean(s.data) }

pub fn timeseries_anomaly_prophet_path_scale(s : TimeseriesanomalyprophetPath, f : Double) -> TimeseriesanomalyprophetPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_prophet_path_add(a : TimeseriesanomalyprophetPath, b : TimeseriesanomalyprophetPath) -> TimeseriesanomalyprophetPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_anomaly_prophet_path_copy(s : TimeseriesanomalyprophetPath) -> TimeseriesanomalyprophetPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_prophet_path_fill(s : TimeseriesanomalyprophetPath, v : Double) -> TimeseriesanomalyprophetPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_prophet_path_min(s : TimeseriesanomalyprophetPath) -> Double { @_common.min(s.data) }

pub fn timeseries_anomaly_prophet_path_max(s : TimeseriesanomalyprophetPath) -> Double { @_common.max(s.data) }

pub fn timeseries_anomaly_prophet_path_to_string(s : TimeseriesanomalyprophetPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesanomalyprophetCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_anomaly_prophet_cluster_make(size : Int) -> TimeseriesanomalyprophetCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_anomaly_prophet_cluster_len(s : TimeseriesanomalyprophetCluster) -> Int { s.size }

pub fn timeseries_anomaly_prophet_cluster_get(s : TimeseriesanomalyprophetCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_anomaly_prophet_cluster_set(s : TimeseriesanomalyprophetCluster, i : Int, v : Double) -> TimeseriesanomalyprophetCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_prophet_cluster_sum(s : TimeseriesanomalyprophetCluster) -> Double { @_common.sum(s.data) }

pub fn timeseries_anomaly_prophet_cluster_mean(s : TimeseriesanomalyprophetCluster) -> Double { @_common.mean(s.data) }

pub fn timeseries_anomaly_prophet_cluster_scale(s : TimeseriesanomalyprophetCluster, f : Double) -> TimeseriesanomalyprophetCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_prophet_cluster_add(a : TimeseriesanomalyprophetCluster, b : TimeseriesanomalyprophetCluster) -> TimeseriesanomalyprophetCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_anomaly_prophet_cluster_copy(s : TimeseriesanomalyprophetCluster) -> TimeseriesanomalyprophetCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_prophet_cluster_fill(s : TimeseriesanomalyprophetCluster, v : Double) -> TimeseriesanomalyprophetCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_prophet_cluster_min(s : TimeseriesanomalyprophetCluster) -> Double { @_common.min(s.data) }

pub fn timeseries_anomaly_prophet_cluster_max(s : TimeseriesanomalyprophetCluster) -> Double { @_common.max(s.data) }

pub fn timeseries_anomaly_prophet_cluster_to_string(s : TimeseriesanomalyprophetCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesanomalyprophetModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_anomaly_prophet_model_make(size : Int) -> TimeseriesanomalyprophetModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_anomaly_prophet_model_len(s : TimeseriesanomalyprophetModel) -> Int { s.size }

pub fn timeseries_anomaly_prophet_model_get(s : TimeseriesanomalyprophetModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_anomaly_prophet_model_set(s : TimeseriesanomalyprophetModel, i : Int, v : Double) -> TimeseriesanomalyprophetModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_prophet_model_sum(s : TimeseriesanomalyprophetModel) -> Double { @_common.sum(s.data) }

pub fn timeseries_anomaly_prophet_model_mean(s : TimeseriesanomalyprophetModel) -> Double { @_common.mean(s.data) }

pub fn timeseries_anomaly_prophet_model_scale(s : TimeseriesanomalyprophetModel, f : Double) -> TimeseriesanomalyprophetModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_prophet_model_add(a : TimeseriesanomalyprophetModel, b : TimeseriesanomalyprophetModel) -> TimeseriesanomalyprophetModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_anomaly_prophet_model_copy(s : TimeseriesanomalyprophetModel) -> TimeseriesanomalyprophetModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_prophet_model_fill(s : TimeseriesanomalyprophetModel, v : Double) -> TimeseriesanomalyprophetModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_prophet_model_min(s : TimeseriesanomalyprophetModel) -> Double { @_common.min(s.data) }

pub fn timeseries_anomaly_prophet_model_max(s : TimeseriesanomalyprophetModel) -> Double { @_common.max(s.data) }

pub fn timeseries_anomaly_prophet_model_to_string(s : TimeseriesanomalyprophetModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesanomalyprophetLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_anomaly_prophet_layer_make(size : Int) -> TimeseriesanomalyprophetLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_anomaly_prophet_layer_len(s : TimeseriesanomalyprophetLayer) -> Int { s.size }

pub fn timeseries_anomaly_prophet_layer_get(s : TimeseriesanomalyprophetLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_anomaly_prophet_layer_set(s : TimeseriesanomalyprophetLayer, i : Int, v : Double) -> TimeseriesanomalyprophetLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_prophet_layer_sum(s : TimeseriesanomalyprophetLayer) -> Double { @_common.sum(s.data) }

pub fn timeseries_anomaly_prophet_layer_mean(s : TimeseriesanomalyprophetLayer) -> Double { @_common.mean(s.data) }

pub fn timeseries_anomaly_prophet_layer_scale(s : TimeseriesanomalyprophetLayer, f : Double) -> TimeseriesanomalyprophetLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_prophet_layer_add(a : TimeseriesanomalyprophetLayer, b : TimeseriesanomalyprophetLayer) -> TimeseriesanomalyprophetLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_anomaly_prophet_layer_copy(s : TimeseriesanomalyprophetLayer) -> TimeseriesanomalyprophetLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_prophet_layer_fill(s : TimeseriesanomalyprophetLayer, v : Double) -> TimeseriesanomalyprophetLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_prophet_layer_min(s : TimeseriesanomalyprophetLayer) -> Double { @_common.min(s.data) }

pub fn timeseries_anomaly_prophet_layer_max(s : TimeseriesanomalyprophetLayer) -> Double { @_common.max(s.data) }

pub fn timeseries_anomaly_prophet_layer_to_string(s : TimeseriesanomalyprophetLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesanomalyprophetBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_anomaly_prophet_buffer_make(size : Int) -> TimeseriesanomalyprophetBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_anomaly_prophet_buffer_len(s : TimeseriesanomalyprophetBuffer) -> Int { s.size }

pub fn timeseries_anomaly_prophet_buffer_get(s : TimeseriesanomalyprophetBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_anomaly_prophet_buffer_set(s : TimeseriesanomalyprophetBuffer, i : Int, v : Double) -> TimeseriesanomalyprophetBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_prophet_buffer_sum(s : TimeseriesanomalyprophetBuffer) -> Double { @_common.sum(s.data) }

pub fn timeseries_anomaly_prophet_buffer_mean(s : TimeseriesanomalyprophetBuffer) -> Double { @_common.mean(s.data) }

pub fn timeseries_anomaly_prophet_buffer_scale(s : TimeseriesanomalyprophetBuffer, f : Double) -> TimeseriesanomalyprophetBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_prophet_buffer_add(a : TimeseriesanomalyprophetBuffer, b : TimeseriesanomalyprophetBuffer) -> TimeseriesanomalyprophetBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_anomaly_prophet_buffer_copy(s : TimeseriesanomalyprophetBuffer) -> TimeseriesanomalyprophetBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_prophet_buffer_fill(s : TimeseriesanomalyprophetBuffer, v : Double) -> TimeseriesanomalyprophetBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_prophet_buffer_min(s : TimeseriesanomalyprophetBuffer) -> Double { @_common.min(s.data) }

pub fn timeseries_anomaly_prophet_buffer_max(s : TimeseriesanomalyprophetBuffer) -> Double { @_common.max(s.data) }

pub fn timeseries_anomaly_prophet_buffer_to_string(s : TimeseriesanomalyprophetBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesanomalyprophetCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_anomaly_prophet_cursor_make(size : Int) -> TimeseriesanomalyprophetCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_anomaly_prophet_cursor_len(s : TimeseriesanomalyprophetCursor) -> Int { s.size }

pub fn timeseries_anomaly_prophet_cursor_get(s : TimeseriesanomalyprophetCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_anomaly_prophet_cursor_set(s : TimeseriesanomalyprophetCursor, i : Int, v : Double) -> TimeseriesanomalyprophetCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_prophet_cursor_sum(s : TimeseriesanomalyprophetCursor) -> Double { @_common.sum(s.data) }

pub fn timeseries_anomaly_prophet_cursor_mean(s : TimeseriesanomalyprophetCursor) -> Double { @_common.mean(s.data) }

pub fn timeseries_anomaly_prophet_cursor_scale(s : TimeseriesanomalyprophetCursor, f : Double) -> TimeseriesanomalyprophetCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_prophet_cursor_add(a : TimeseriesanomalyprophetCursor, b : TimeseriesanomalyprophetCursor) -> TimeseriesanomalyprophetCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_anomaly_prophet_cursor_copy(s : TimeseriesanomalyprophetCursor) -> TimeseriesanomalyprophetCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_prophet_cursor_fill(s : TimeseriesanomalyprophetCursor, v : Double) -> TimeseriesanomalyprophetCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_prophet_cursor_min(s : TimeseriesanomalyprophetCursor) -> Double { @_common.min(s.data) }

pub fn timeseries_anomaly_prophet_cursor_max(s : TimeseriesanomalyprophetCursor) -> Double { @_common.max(s.data) }

pub fn timeseries_anomaly_prophet_cursor_to_string(s : TimeseriesanomalyprophetCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesanomalyprophetView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_anomaly_prophet_view_make(size : Int) -> TimeseriesanomalyprophetView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_anomaly_prophet_view_len(s : TimeseriesanomalyprophetView) -> Int { s.size }

pub fn timeseries_anomaly_prophet_view_get(s : TimeseriesanomalyprophetView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_anomaly_prophet_view_set(s : TimeseriesanomalyprophetView, i : Int, v : Double) -> TimeseriesanomalyprophetView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_prophet_view_sum(s : TimeseriesanomalyprophetView) -> Double { @_common.sum(s.data) }

pub fn timeseries_anomaly_prophet_view_mean(s : TimeseriesanomalyprophetView) -> Double { @_common.mean(s.data) }

pub fn timeseries_anomaly_prophet_view_scale(s : TimeseriesanomalyprophetView, f : Double) -> TimeseriesanomalyprophetView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_prophet_view_add(a : TimeseriesanomalyprophetView, b : TimeseriesanomalyprophetView) -> TimeseriesanomalyprophetView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_anomaly_prophet_view_copy(s : TimeseriesanomalyprophetView) -> TimeseriesanomalyprophetView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_prophet_view_fill(s : TimeseriesanomalyprophetView, v : Double) -> TimeseriesanomalyprophetView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_prophet_view_min(s : TimeseriesanomalyprophetView) -> Double { @_common.min(s.data) }

pub fn timeseries_anomaly_prophet_view_max(s : TimeseriesanomalyprophetView) -> Double { @_common.max(s.data) }

pub fn timeseries_anomaly_prophet_view_to_string(s : TimeseriesanomalyprophetView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesanomalyprophetRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_anomaly_prophet_range_make(size : Int) -> TimeseriesanomalyprophetRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_anomaly_prophet_range_len(s : TimeseriesanomalyprophetRange) -> Int { s.size }

pub fn timeseries_anomaly_prophet_range_get(s : TimeseriesanomalyprophetRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_anomaly_prophet_range_set(s : TimeseriesanomalyprophetRange, i : Int, v : Double) -> TimeseriesanomalyprophetRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_prophet_range_sum(s : TimeseriesanomalyprophetRange) -> Double { @_common.sum(s.data) }

pub fn timeseries_anomaly_prophet_range_mean(s : TimeseriesanomalyprophetRange) -> Double { @_common.mean(s.data) }

pub fn timeseries_anomaly_prophet_range_scale(s : TimeseriesanomalyprophetRange, f : Double) -> TimeseriesanomalyprophetRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_prophet_range_add(a : TimeseriesanomalyprophetRange, b : TimeseriesanomalyprophetRange) -> TimeseriesanomalyprophetRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_anomaly_prophet_range_copy(s : TimeseriesanomalyprophetRange) -> TimeseriesanomalyprophetRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_prophet_range_fill(s : TimeseriesanomalyprophetRange, v : Double) -> TimeseriesanomalyprophetRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_prophet_range_min(s : TimeseriesanomalyprophetRange) -> Double { @_common.min(s.data) }

pub fn timeseries_anomaly_prophet_range_max(s : TimeseriesanomalyprophetRange) -> Double { @_common.max(s.data) }

pub fn timeseries_anomaly_prophet_range_to_string(s : TimeseriesanomalyprophetRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesanomalyprophetSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_anomaly_prophet_slice_make(size : Int) -> TimeseriesanomalyprophetSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_anomaly_prophet_slice_len(s : TimeseriesanomalyprophetSlice) -> Int { s.size }

pub fn timeseries_anomaly_prophet_slice_get(s : TimeseriesanomalyprophetSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_anomaly_prophet_slice_set(s : TimeseriesanomalyprophetSlice, i : Int, v : Double) -> TimeseriesanomalyprophetSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_prophet_slice_sum(s : TimeseriesanomalyprophetSlice) -> Double { @_common.sum(s.data) }

pub fn timeseries_anomaly_prophet_slice_mean(s : TimeseriesanomalyprophetSlice) -> Double { @_common.mean(s.data) }

pub fn timeseries_anomaly_prophet_slice_scale(s : TimeseriesanomalyprophetSlice, f : Double) -> TimeseriesanomalyprophetSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_prophet_slice_add(a : TimeseriesanomalyprophetSlice, b : TimeseriesanomalyprophetSlice) -> TimeseriesanomalyprophetSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_anomaly_prophet_slice_copy(s : TimeseriesanomalyprophetSlice) -> TimeseriesanomalyprophetSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_prophet_slice_fill(s : TimeseriesanomalyprophetSlice, v : Double) -> TimeseriesanomalyprophetSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_prophet_slice_min(s : TimeseriesanomalyprophetSlice) -> Double { @_common.min(s.data) }

pub fn timeseries_anomaly_prophet_slice_max(s : TimeseriesanomalyprophetSlice) -> Double { @_common.max(s.data) }

pub fn timeseries_anomaly_prophet_slice_to_string(s : TimeseriesanomalyprophetSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

