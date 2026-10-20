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

pub fn TimeseriesanomalydbscanFrame::len(self : TimeseriesanomalydbscanFrame) -> Int { self.size }

pub fn TimeseriesanomalydbscanFrame::get(self : TimeseriesanomalydbscanFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn TimeseriesanomalydbscanFrame::set(self : TimeseriesanomalydbscanFrame, i : Int, v : Double) -> TimeseriesanomalydbscanFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn TimeseriesanomalydbscanFrame::sum(self : TimeseriesanomalydbscanFrame) -> Double { @_common.sum(self.data) }

pub fn TimeseriesanomalydbscanFrame::mean(self : TimeseriesanomalydbscanFrame) -> Double { @_common.mean(self.data) }

pub fn TimeseriesanomalydbscanFrame::scale(self : TimeseriesanomalydbscanFrame, f : Double) -> TimeseriesanomalydbscanFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn TimeseriesanomalydbscanFrame::add(self : TimeseriesanomalydbscanFrame, other : TimeseriesanomalydbscanFrame) -> TimeseriesanomalydbscanFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn TimeseriesanomalydbscanFrame::copy(self : TimeseriesanomalydbscanFrame) -> TimeseriesanomalydbscanFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn TimeseriesanomalydbscanFrame::fill(self : TimeseriesanomalydbscanFrame, v : Double) -> TimeseriesanomalydbscanFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn TimeseriesanomalydbscanFrame::min(self : TimeseriesanomalydbscanFrame) -> Double { @_common.min(self.data) }

pub fn TimeseriesanomalydbscanFrame::max(self : TimeseriesanomalydbscanFrame) -> Double { @_common.max(self.data) }

pub fn TimeseriesanomalydbscanFrame::to_string(self : TimeseriesanomalydbscanFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct TimeseriesanomalydbscanTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_anomaly_dbscan_table_make(size : Int) -> TimeseriesanomalydbscanTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn TimeseriesanomalydbscanTable::len(self : TimeseriesanomalydbscanTable) -> Int { self.size }

pub fn TimeseriesanomalydbscanTable::get(self : TimeseriesanomalydbscanTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn TimeseriesanomalydbscanTable::set(self : TimeseriesanomalydbscanTable, i : Int, v : Double) -> TimeseriesanomalydbscanTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn TimeseriesanomalydbscanTable::sum(self : TimeseriesanomalydbscanTable) -> Double { @_common.sum(self.data) }

pub fn TimeseriesanomalydbscanTable::mean(self : TimeseriesanomalydbscanTable) -> Double { @_common.mean(self.data) }

pub fn TimeseriesanomalydbscanTable::scale(self : TimeseriesanomalydbscanTable, f : Double) -> TimeseriesanomalydbscanTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn TimeseriesanomalydbscanTable::add(self : TimeseriesanomalydbscanTable, other : TimeseriesanomalydbscanTable) -> TimeseriesanomalydbscanTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn TimeseriesanomalydbscanTable::copy(self : TimeseriesanomalydbscanTable) -> TimeseriesanomalydbscanTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn TimeseriesanomalydbscanTable::fill(self : TimeseriesanomalydbscanTable, v : Double) -> TimeseriesanomalydbscanTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn TimeseriesanomalydbscanTable::min(self : TimeseriesanomalydbscanTable) -> Double { @_common.min(self.data) }

pub fn TimeseriesanomalydbscanTable::max(self : TimeseriesanomalydbscanTable) -> Double { @_common.max(self.data) }

pub fn TimeseriesanomalydbscanTable::to_string(self : TimeseriesanomalydbscanTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct TimeseriesanomalydbscanGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_anomaly_dbscan_graphn_make(size : Int) -> TimeseriesanomalydbscanGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn TimeseriesanomalydbscanGraphN::len(self : TimeseriesanomalydbscanGraphN) -> Int { self.size }

pub fn TimeseriesanomalydbscanGraphN::get(self : TimeseriesanomalydbscanGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn TimeseriesanomalydbscanGraphN::set(self : TimeseriesanomalydbscanGraphN, i : Int, v : Double) -> TimeseriesanomalydbscanGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn TimeseriesanomalydbscanGraphN::sum(self : TimeseriesanomalydbscanGraphN) -> Double { @_common.sum(self.data) }

pub fn TimeseriesanomalydbscanGraphN::mean(self : TimeseriesanomalydbscanGraphN) -> Double { @_common.mean(self.data) }

pub fn TimeseriesanomalydbscanGraphN::scale(self : TimeseriesanomalydbscanGraphN, f : Double) -> TimeseriesanomalydbscanGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn TimeseriesanomalydbscanGraphN::add(self : TimeseriesanomalydbscanGraphN, other : TimeseriesanomalydbscanGraphN) -> TimeseriesanomalydbscanGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn TimeseriesanomalydbscanGraphN::copy(self : TimeseriesanomalydbscanGraphN) -> TimeseriesanomalydbscanGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn TimeseriesanomalydbscanGraphN::fill(self : TimeseriesanomalydbscanGraphN, v : Double) -> TimeseriesanomalydbscanGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn TimeseriesanomalydbscanGraphN::min(self : TimeseriesanomalydbscanGraphN) -> Double { @_common.min(self.data) }

pub fn TimeseriesanomalydbscanGraphN::max(self : TimeseriesanomalydbscanGraphN) -> Double { @_common.max(self.data) }

pub fn TimeseriesanomalydbscanGraphN::to_string(self : TimeseriesanomalydbscanGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct TimeseriesanomalydbscanNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_anomaly_dbscan_node_make(size : Int) -> TimeseriesanomalydbscanNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn TimeseriesanomalydbscanNode::len(self : TimeseriesanomalydbscanNode) -> Int { self.size }

pub fn TimeseriesanomalydbscanNode::get(self : TimeseriesanomalydbscanNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn TimeseriesanomalydbscanNode::set(self : TimeseriesanomalydbscanNode, i : Int, v : Double) -> TimeseriesanomalydbscanNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn TimeseriesanomalydbscanNode::sum(self : TimeseriesanomalydbscanNode) -> Double { @_common.sum(self.data) }

pub fn TimeseriesanomalydbscanNode::mean(self : TimeseriesanomalydbscanNode) -> Double { @_common.mean(self.data) }

pub fn TimeseriesanomalydbscanNode::scale(self : TimeseriesanomalydbscanNode, f : Double) -> TimeseriesanomalydbscanNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn TimeseriesanomalydbscanNode::add(self : TimeseriesanomalydbscanNode, other : TimeseriesanomalydbscanNode) -> TimeseriesanomalydbscanNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn TimeseriesanomalydbscanNode::copy(self : TimeseriesanomalydbscanNode) -> TimeseriesanomalydbscanNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn TimeseriesanomalydbscanNode::fill(self : TimeseriesanomalydbscanNode, v : Double) -> TimeseriesanomalydbscanNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn TimeseriesanomalydbscanNode::min(self : TimeseriesanomalydbscanNode) -> Double { @_common.min(self.data) }

pub fn TimeseriesanomalydbscanNode::max(self : TimeseriesanomalydbscanNode) -> Double { @_common.max(self.data) }

pub fn TimeseriesanomalydbscanNode::to_string(self : TimeseriesanomalydbscanNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct TimeseriesanomalydbscanEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_anomaly_dbscan_edge_make(size : Int) -> TimeseriesanomalydbscanEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn TimeseriesanomalydbscanEdge::len(self : TimeseriesanomalydbscanEdge) -> Int { self.size }

pub fn TimeseriesanomalydbscanEdge::get(self : TimeseriesanomalydbscanEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn TimeseriesanomalydbscanEdge::set(self : TimeseriesanomalydbscanEdge, i : Int, v : Double) -> TimeseriesanomalydbscanEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn TimeseriesanomalydbscanEdge::sum(self : TimeseriesanomalydbscanEdge) -> Double { @_common.sum(self.data) }

pub fn TimeseriesanomalydbscanEdge::mean(self : TimeseriesanomalydbscanEdge) -> Double { @_common.mean(self.data) }

pub fn TimeseriesanomalydbscanEdge::scale(self : TimeseriesanomalydbscanEdge, f : Double) -> TimeseriesanomalydbscanEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn TimeseriesanomalydbscanEdge::add(self : TimeseriesanomalydbscanEdge, other : TimeseriesanomalydbscanEdge) -> TimeseriesanomalydbscanEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn TimeseriesanomalydbscanEdge::copy(self : TimeseriesanomalydbscanEdge) -> TimeseriesanomalydbscanEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn TimeseriesanomalydbscanEdge::fill(self : TimeseriesanomalydbscanEdge, v : Double) -> TimeseriesanomalydbscanEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn TimeseriesanomalydbscanEdge::min(self : TimeseriesanomalydbscanEdge) -> Double { @_common.min(self.data) }

pub fn TimeseriesanomalydbscanEdge::max(self : TimeseriesanomalydbscanEdge) -> Double { @_common.max(self.data) }

pub fn TimeseriesanomalydbscanEdge::to_string(self : TimeseriesanomalydbscanEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct TimeseriesanomalydbscanPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_anomaly_dbscan_path_make(size : Int) -> TimeseriesanomalydbscanPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn TimeseriesanomalydbscanPath::len(self : TimeseriesanomalydbscanPath) -> Int { self.size }

pub fn TimeseriesanomalydbscanPath::get(self : TimeseriesanomalydbscanPath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn TimeseriesanomalydbscanPath::set(self : TimeseriesanomalydbscanPath, i : Int, v : Double) -> TimeseriesanomalydbscanPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn TimeseriesanomalydbscanPath::sum(self : TimeseriesanomalydbscanPath) -> Double { @_common.sum(self.data) }

pub fn TimeseriesanomalydbscanPath::mean(self : TimeseriesanomalydbscanPath) -> Double { @_common.mean(self.data) }

pub fn TimeseriesanomalydbscanPath::scale(self : TimeseriesanomalydbscanPath, f : Double) -> TimeseriesanomalydbscanPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn TimeseriesanomalydbscanPath::add(self : TimeseriesanomalydbscanPath, other : TimeseriesanomalydbscanPath) -> TimeseriesanomalydbscanPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn TimeseriesanomalydbscanPath::copy(self : TimeseriesanomalydbscanPath) -> TimeseriesanomalydbscanPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn TimeseriesanomalydbscanPath::fill(self : TimeseriesanomalydbscanPath, v : Double) -> TimeseriesanomalydbscanPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn TimeseriesanomalydbscanPath::min(self : TimeseriesanomalydbscanPath) -> Double { @_common.min(self.data) }

pub fn TimeseriesanomalydbscanPath::max(self : TimeseriesanomalydbscanPath) -> Double { @_common.max(self.data) }

pub fn TimeseriesanomalydbscanPath::to_string(self : TimeseriesanomalydbscanPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct TimeseriesanomalydbscanCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_anomaly_dbscan_cluster_make(size : Int) -> TimeseriesanomalydbscanCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn TimeseriesanomalydbscanCluster::len(self : TimeseriesanomalydbscanCluster) -> Int { self.size }

pub fn TimeseriesanomalydbscanCluster::get(self : TimeseriesanomalydbscanCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn TimeseriesanomalydbscanCluster::set(self : TimeseriesanomalydbscanCluster, i : Int, v : Double) -> TimeseriesanomalydbscanCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn TimeseriesanomalydbscanCluster::sum(self : TimeseriesanomalydbscanCluster) -> Double { @_common.sum(self.data) }

pub fn TimeseriesanomalydbscanCluster::mean(self : TimeseriesanomalydbscanCluster) -> Double { @_common.mean(self.data) }

pub fn TimeseriesanomalydbscanCluster::scale(self : TimeseriesanomalydbscanCluster, f : Double) -> TimeseriesanomalydbscanCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn TimeseriesanomalydbscanCluster::add(self : TimeseriesanomalydbscanCluster, other : TimeseriesanomalydbscanCluster) -> TimeseriesanomalydbscanCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn TimeseriesanomalydbscanCluster::copy(self : TimeseriesanomalydbscanCluster) -> TimeseriesanomalydbscanCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn TimeseriesanomalydbscanCluster::fill(self : TimeseriesanomalydbscanCluster, v : Double) -> TimeseriesanomalydbscanCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn TimeseriesanomalydbscanCluster::min(self : TimeseriesanomalydbscanCluster) -> Double { @_common.min(self.data) }

pub fn TimeseriesanomalydbscanCluster::max(self : TimeseriesanomalydbscanCluster) -> Double { @_common.max(self.data) }

pub fn TimeseriesanomalydbscanCluster::to_string(self : TimeseriesanomalydbscanCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct TimeseriesanomalydbscanModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_anomaly_dbscan_model_make(size : Int) -> TimeseriesanomalydbscanModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn TimeseriesanomalydbscanModel::len(self : TimeseriesanomalydbscanModel) -> Int { self.size }

pub fn TimeseriesanomalydbscanModel::get(self : TimeseriesanomalydbscanModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn TimeseriesanomalydbscanModel::set(self : TimeseriesanomalydbscanModel, i : Int, v : Double) -> TimeseriesanomalydbscanModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn TimeseriesanomalydbscanModel::sum(self : TimeseriesanomalydbscanModel) -> Double { @_common.sum(self.data) }

pub fn TimeseriesanomalydbscanModel::mean(self : TimeseriesanomalydbscanModel) -> Double { @_common.mean(self.data) }

pub fn TimeseriesanomalydbscanModel::scale(self : TimeseriesanomalydbscanModel, f : Double) -> TimeseriesanomalydbscanModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn TimeseriesanomalydbscanModel::add(self : TimeseriesanomalydbscanModel, other : TimeseriesanomalydbscanModel) -> TimeseriesanomalydbscanModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn TimeseriesanomalydbscanModel::copy(self : TimeseriesanomalydbscanModel) -> TimeseriesanomalydbscanModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn TimeseriesanomalydbscanModel::fill(self : TimeseriesanomalydbscanModel, v : Double) -> TimeseriesanomalydbscanModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn TimeseriesanomalydbscanModel::min(self : TimeseriesanomalydbscanModel) -> Double { @_common.min(self.data) }

pub fn TimeseriesanomalydbscanModel::max(self : TimeseriesanomalydbscanModel) -> Double { @_common.max(self.data) }

pub fn TimeseriesanomalydbscanModel::to_string(self : TimeseriesanomalydbscanModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct TimeseriesanomalydbscanLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_anomaly_dbscan_layer_make(size : Int) -> TimeseriesanomalydbscanLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn TimeseriesanomalydbscanLayer::len(self : TimeseriesanomalydbscanLayer) -> Int { self.size }

pub fn TimeseriesanomalydbscanLayer::get(self : TimeseriesanomalydbscanLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn TimeseriesanomalydbscanLayer::set(self : TimeseriesanomalydbscanLayer, i : Int, v : Double) -> TimeseriesanomalydbscanLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn TimeseriesanomalydbscanLayer::sum(self : TimeseriesanomalydbscanLayer) -> Double { @_common.sum(self.data) }

pub fn TimeseriesanomalydbscanLayer::mean(self : TimeseriesanomalydbscanLayer) -> Double { @_common.mean(self.data) }

pub fn TimeseriesanomalydbscanLayer::scale(self : TimeseriesanomalydbscanLayer, f : Double) -> TimeseriesanomalydbscanLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn TimeseriesanomalydbscanLayer::add(self : TimeseriesanomalydbscanLayer, other : TimeseriesanomalydbscanLayer) -> TimeseriesanomalydbscanLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn TimeseriesanomalydbscanLayer::copy(self : TimeseriesanomalydbscanLayer) -> TimeseriesanomalydbscanLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn TimeseriesanomalydbscanLayer::fill(self : TimeseriesanomalydbscanLayer, v : Double) -> TimeseriesanomalydbscanLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn TimeseriesanomalydbscanLayer::min(self : TimeseriesanomalydbscanLayer) -> Double { @_common.min(self.data) }

pub fn TimeseriesanomalydbscanLayer::max(self : TimeseriesanomalydbscanLayer) -> Double { @_common.max(self.data) }

pub fn TimeseriesanomalydbscanLayer::to_string(self : TimeseriesanomalydbscanLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct TimeseriesanomalydbscanBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_anomaly_dbscan_buffer_make(size : Int) -> TimeseriesanomalydbscanBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn TimeseriesanomalydbscanBuffer::len(self : TimeseriesanomalydbscanBuffer) -> Int { self.size }

pub fn TimeseriesanomalydbscanBuffer::get(self : TimeseriesanomalydbscanBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn TimeseriesanomalydbscanBuffer::set(self : TimeseriesanomalydbscanBuffer, i : Int, v : Double) -> TimeseriesanomalydbscanBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn TimeseriesanomalydbscanBuffer::sum(self : TimeseriesanomalydbscanBuffer) -> Double { @_common.sum(self.data) }

pub fn TimeseriesanomalydbscanBuffer::mean(self : TimeseriesanomalydbscanBuffer) -> Double { @_common.mean(self.data) }

pub fn TimeseriesanomalydbscanBuffer::scale(self : TimeseriesanomalydbscanBuffer, f : Double) -> TimeseriesanomalydbscanBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn TimeseriesanomalydbscanBuffer::add(self : TimeseriesanomalydbscanBuffer, other : TimeseriesanomalydbscanBuffer) -> TimeseriesanomalydbscanBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn TimeseriesanomalydbscanBuffer::copy(self : TimeseriesanomalydbscanBuffer) -> TimeseriesanomalydbscanBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn TimeseriesanomalydbscanBuffer::fill(self : TimeseriesanomalydbscanBuffer, v : Double) -> TimeseriesanomalydbscanBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn TimeseriesanomalydbscanBuffer::min(self : TimeseriesanomalydbscanBuffer) -> Double { @_common.min(self.data) }

pub fn TimeseriesanomalydbscanBuffer::max(self : TimeseriesanomalydbscanBuffer) -> Double { @_common.max(self.data) }

pub fn TimeseriesanomalydbscanBuffer::to_string(self : TimeseriesanomalydbscanBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct TimeseriesanomalydbscanCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_anomaly_dbscan_cursor_make(size : Int) -> TimeseriesanomalydbscanCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn TimeseriesanomalydbscanCursor::len(self : TimeseriesanomalydbscanCursor) -> Int { self.size }

pub fn TimeseriesanomalydbscanCursor::get(self : TimeseriesanomalydbscanCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn TimeseriesanomalydbscanCursor::set(self : TimeseriesanomalydbscanCursor, i : Int, v : Double) -> TimeseriesanomalydbscanCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn TimeseriesanomalydbscanCursor::sum(self : TimeseriesanomalydbscanCursor) -> Double { @_common.sum(self.data) }

pub fn TimeseriesanomalydbscanCursor::mean(self : TimeseriesanomalydbscanCursor) -> Double { @_common.mean(self.data) }

pub fn TimeseriesanomalydbscanCursor::scale(self : TimeseriesanomalydbscanCursor, f : Double) -> TimeseriesanomalydbscanCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn TimeseriesanomalydbscanCursor::add(self : TimeseriesanomalydbscanCursor, other : TimeseriesanomalydbscanCursor) -> TimeseriesanomalydbscanCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn TimeseriesanomalydbscanCursor::copy(self : TimeseriesanomalydbscanCursor) -> TimeseriesanomalydbscanCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn TimeseriesanomalydbscanCursor::fill(self : TimeseriesanomalydbscanCursor, v : Double) -> TimeseriesanomalydbscanCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn TimeseriesanomalydbscanCursor::min(self : TimeseriesanomalydbscanCursor) -> Double { @_common.min(self.data) }

pub fn TimeseriesanomalydbscanCursor::max(self : TimeseriesanomalydbscanCursor) -> Double { @_common.max(self.data) }

pub fn TimeseriesanomalydbscanCursor::to_string(self : TimeseriesanomalydbscanCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct TimeseriesanomalydbscanView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_anomaly_dbscan_view_make(size : Int) -> TimeseriesanomalydbscanView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn TimeseriesanomalydbscanView::len(self : TimeseriesanomalydbscanView) -> Int { self.size }

pub fn TimeseriesanomalydbscanView::get(self : TimeseriesanomalydbscanView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn TimeseriesanomalydbscanView::set(self : TimeseriesanomalydbscanView, i : Int, v : Double) -> TimeseriesanomalydbscanView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn TimeseriesanomalydbscanView::sum(self : TimeseriesanomalydbscanView) -> Double { @_common.sum(self.data) }

pub fn TimeseriesanomalydbscanView::mean(self : TimeseriesanomalydbscanView) -> Double { @_common.mean(self.data) }

pub fn TimeseriesanomalydbscanView::scale(self : TimeseriesanomalydbscanView, f : Double) -> TimeseriesanomalydbscanView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn TimeseriesanomalydbscanView::add(self : TimeseriesanomalydbscanView, other : TimeseriesanomalydbscanView) -> TimeseriesanomalydbscanView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn TimeseriesanomalydbscanView::copy(self : TimeseriesanomalydbscanView) -> TimeseriesanomalydbscanView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn TimeseriesanomalydbscanView::fill(self : TimeseriesanomalydbscanView, v : Double) -> TimeseriesanomalydbscanView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn TimeseriesanomalydbscanView::min(self : TimeseriesanomalydbscanView) -> Double { @_common.min(self.data) }

pub fn TimeseriesanomalydbscanView::max(self : TimeseriesanomalydbscanView) -> Double { @_common.max(self.data) }

pub fn TimeseriesanomalydbscanView::to_string(self : TimeseriesanomalydbscanView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct TimeseriesanomalydbscanRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_anomaly_dbscan_range_make(size : Int) -> TimeseriesanomalydbscanRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn TimeseriesanomalydbscanRange::len(self : TimeseriesanomalydbscanRange) -> Int { self.size }

pub fn TimeseriesanomalydbscanRange::get(self : TimeseriesanomalydbscanRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn TimeseriesanomalydbscanRange::set(self : TimeseriesanomalydbscanRange, i : Int, v : Double) -> TimeseriesanomalydbscanRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn TimeseriesanomalydbscanRange::sum(self : TimeseriesanomalydbscanRange) -> Double { @_common.sum(self.data) }

pub fn TimeseriesanomalydbscanRange::mean(self : TimeseriesanomalydbscanRange) -> Double { @_common.mean(self.data) }

pub fn TimeseriesanomalydbscanRange::scale(self : TimeseriesanomalydbscanRange, f : Double) -> TimeseriesanomalydbscanRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn TimeseriesanomalydbscanRange::add(self : TimeseriesanomalydbscanRange, other : TimeseriesanomalydbscanRange) -> TimeseriesanomalydbscanRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn TimeseriesanomalydbscanRange::copy(self : TimeseriesanomalydbscanRange) -> TimeseriesanomalydbscanRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn TimeseriesanomalydbscanRange::fill(self : TimeseriesanomalydbscanRange, v : Double) -> TimeseriesanomalydbscanRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn TimeseriesanomalydbscanRange::min(self : TimeseriesanomalydbscanRange) -> Double { @_common.min(self.data) }

pub fn TimeseriesanomalydbscanRange::max(self : TimeseriesanomalydbscanRange) -> Double { @_common.max(self.data) }

pub fn TimeseriesanomalydbscanRange::to_string(self : TimeseriesanomalydbscanRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct TimeseriesanomalydbscanSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_anomaly_dbscan_slice_make(size : Int) -> TimeseriesanomalydbscanSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn TimeseriesanomalydbscanSlice::len(self : TimeseriesanomalydbscanSlice) -> Int { self.size }

pub fn TimeseriesanomalydbscanSlice::get(self : TimeseriesanomalydbscanSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn TimeseriesanomalydbscanSlice::set(self : TimeseriesanomalydbscanSlice, i : Int, v : Double) -> TimeseriesanomalydbscanSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn TimeseriesanomalydbscanSlice::sum(self : TimeseriesanomalydbscanSlice) -> Double { @_common.sum(self.data) }

pub fn TimeseriesanomalydbscanSlice::mean(self : TimeseriesanomalydbscanSlice) -> Double { @_common.mean(self.data) }

pub fn TimeseriesanomalydbscanSlice::scale(self : TimeseriesanomalydbscanSlice, f : Double) -> TimeseriesanomalydbscanSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn TimeseriesanomalydbscanSlice::add(self : TimeseriesanomalydbscanSlice, other : TimeseriesanomalydbscanSlice) -> TimeseriesanomalydbscanSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn TimeseriesanomalydbscanSlice::copy(self : TimeseriesanomalydbscanSlice) -> TimeseriesanomalydbscanSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn TimeseriesanomalydbscanSlice::fill(self : TimeseriesanomalydbscanSlice, v : Double) -> TimeseriesanomalydbscanSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn TimeseriesanomalydbscanSlice::min(self : TimeseriesanomalydbscanSlice) -> Double { @_common.min(self.data) }

pub fn TimeseriesanomalydbscanSlice::max(self : TimeseriesanomalydbscanSlice) -> Double { @_common.max(self.data) }

pub fn TimeseriesanomalydbscanSlice::to_string(self : TimeseriesanomalydbscanSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

