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

pub fn TimeseriesanomalyprophetFrame::len(self : TimeseriesanomalyprophetFrame) -> Int { self.size }

pub fn TimeseriesanomalyprophetFrame::get(self : TimeseriesanomalyprophetFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn TimeseriesanomalyprophetFrame::set(self : TimeseriesanomalyprophetFrame, i : Int, v : Double) -> TimeseriesanomalyprophetFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn TimeseriesanomalyprophetFrame::sum(self : TimeseriesanomalyprophetFrame) -> Double { @_common.sum(self.data) }

pub fn TimeseriesanomalyprophetFrame::mean(self : TimeseriesanomalyprophetFrame) -> Double { @_common.mean(self.data) }

pub fn TimeseriesanomalyprophetFrame::scale(self : TimeseriesanomalyprophetFrame, f : Double) -> TimeseriesanomalyprophetFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn TimeseriesanomalyprophetFrame::add(self : TimeseriesanomalyprophetFrame, other : TimeseriesanomalyprophetFrame) -> TimeseriesanomalyprophetFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn TimeseriesanomalyprophetFrame::copy(self : TimeseriesanomalyprophetFrame) -> TimeseriesanomalyprophetFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn TimeseriesanomalyprophetFrame::fill(self : TimeseriesanomalyprophetFrame, v : Double) -> TimeseriesanomalyprophetFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn TimeseriesanomalyprophetFrame::min(self : TimeseriesanomalyprophetFrame) -> Double { @_common.min(self.data) }

pub fn TimeseriesanomalyprophetFrame::max(self : TimeseriesanomalyprophetFrame) -> Double { @_common.max(self.data) }

pub fn TimeseriesanomalyprophetFrame::to_string(self : TimeseriesanomalyprophetFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct TimeseriesanomalyprophetTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_anomaly_prophet_table_make(size : Int) -> TimeseriesanomalyprophetTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn TimeseriesanomalyprophetTable::len(self : TimeseriesanomalyprophetTable) -> Int { self.size }

pub fn TimeseriesanomalyprophetTable::get(self : TimeseriesanomalyprophetTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn TimeseriesanomalyprophetTable::set(self : TimeseriesanomalyprophetTable, i : Int, v : Double) -> TimeseriesanomalyprophetTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn TimeseriesanomalyprophetTable::sum(self : TimeseriesanomalyprophetTable) -> Double { @_common.sum(self.data) }

pub fn TimeseriesanomalyprophetTable::mean(self : TimeseriesanomalyprophetTable) -> Double { @_common.mean(self.data) }

pub fn TimeseriesanomalyprophetTable::scale(self : TimeseriesanomalyprophetTable, f : Double) -> TimeseriesanomalyprophetTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn TimeseriesanomalyprophetTable::add(self : TimeseriesanomalyprophetTable, other : TimeseriesanomalyprophetTable) -> TimeseriesanomalyprophetTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn TimeseriesanomalyprophetTable::copy(self : TimeseriesanomalyprophetTable) -> TimeseriesanomalyprophetTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn TimeseriesanomalyprophetTable::fill(self : TimeseriesanomalyprophetTable, v : Double) -> TimeseriesanomalyprophetTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn TimeseriesanomalyprophetTable::min(self : TimeseriesanomalyprophetTable) -> Double { @_common.min(self.data) }

pub fn TimeseriesanomalyprophetTable::max(self : TimeseriesanomalyprophetTable) -> Double { @_common.max(self.data) }

pub fn TimeseriesanomalyprophetTable::to_string(self : TimeseriesanomalyprophetTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct TimeseriesanomalyprophetGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_anomaly_prophet_graphn_make(size : Int) -> TimeseriesanomalyprophetGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn TimeseriesanomalyprophetGraphN::len(self : TimeseriesanomalyprophetGraphN) -> Int { self.size }

pub fn TimeseriesanomalyprophetGraphN::get(self : TimeseriesanomalyprophetGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn TimeseriesanomalyprophetGraphN::set(self : TimeseriesanomalyprophetGraphN, i : Int, v : Double) -> TimeseriesanomalyprophetGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn TimeseriesanomalyprophetGraphN::sum(self : TimeseriesanomalyprophetGraphN) -> Double { @_common.sum(self.data) }

pub fn TimeseriesanomalyprophetGraphN::mean(self : TimeseriesanomalyprophetGraphN) -> Double { @_common.mean(self.data) }

pub fn TimeseriesanomalyprophetGraphN::scale(self : TimeseriesanomalyprophetGraphN, f : Double) -> TimeseriesanomalyprophetGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn TimeseriesanomalyprophetGraphN::add(self : TimeseriesanomalyprophetGraphN, other : TimeseriesanomalyprophetGraphN) -> TimeseriesanomalyprophetGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn TimeseriesanomalyprophetGraphN::copy(self : TimeseriesanomalyprophetGraphN) -> TimeseriesanomalyprophetGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn TimeseriesanomalyprophetGraphN::fill(self : TimeseriesanomalyprophetGraphN, v : Double) -> TimeseriesanomalyprophetGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn TimeseriesanomalyprophetGraphN::min(self : TimeseriesanomalyprophetGraphN) -> Double { @_common.min(self.data) }

pub fn TimeseriesanomalyprophetGraphN::max(self : TimeseriesanomalyprophetGraphN) -> Double { @_common.max(self.data) }

pub fn TimeseriesanomalyprophetGraphN::to_string(self : TimeseriesanomalyprophetGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct TimeseriesanomalyprophetNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_anomaly_prophet_node_make(size : Int) -> TimeseriesanomalyprophetNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn TimeseriesanomalyprophetNode::len(self : TimeseriesanomalyprophetNode) -> Int { self.size }

pub fn TimeseriesanomalyprophetNode::get(self : TimeseriesanomalyprophetNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn TimeseriesanomalyprophetNode::set(self : TimeseriesanomalyprophetNode, i : Int, v : Double) -> TimeseriesanomalyprophetNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn TimeseriesanomalyprophetNode::sum(self : TimeseriesanomalyprophetNode) -> Double { @_common.sum(self.data) }

pub fn TimeseriesanomalyprophetNode::mean(self : TimeseriesanomalyprophetNode) -> Double { @_common.mean(self.data) }

pub fn TimeseriesanomalyprophetNode::scale(self : TimeseriesanomalyprophetNode, f : Double) -> TimeseriesanomalyprophetNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn TimeseriesanomalyprophetNode::add(self : TimeseriesanomalyprophetNode, other : TimeseriesanomalyprophetNode) -> TimeseriesanomalyprophetNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn TimeseriesanomalyprophetNode::copy(self : TimeseriesanomalyprophetNode) -> TimeseriesanomalyprophetNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn TimeseriesanomalyprophetNode::fill(self : TimeseriesanomalyprophetNode, v : Double) -> TimeseriesanomalyprophetNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn TimeseriesanomalyprophetNode::min(self : TimeseriesanomalyprophetNode) -> Double { @_common.min(self.data) }

pub fn TimeseriesanomalyprophetNode::max(self : TimeseriesanomalyprophetNode) -> Double { @_common.max(self.data) }

pub fn TimeseriesanomalyprophetNode::to_string(self : TimeseriesanomalyprophetNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct TimeseriesanomalyprophetEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_anomaly_prophet_edge_make(size : Int) -> TimeseriesanomalyprophetEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn TimeseriesanomalyprophetEdge::len(self : TimeseriesanomalyprophetEdge) -> Int { self.size }

pub fn TimeseriesanomalyprophetEdge::get(self : TimeseriesanomalyprophetEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn TimeseriesanomalyprophetEdge::set(self : TimeseriesanomalyprophetEdge, i : Int, v : Double) -> TimeseriesanomalyprophetEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn TimeseriesanomalyprophetEdge::sum(self : TimeseriesanomalyprophetEdge) -> Double { @_common.sum(self.data) }

pub fn TimeseriesanomalyprophetEdge::mean(self : TimeseriesanomalyprophetEdge) -> Double { @_common.mean(self.data) }

pub fn TimeseriesanomalyprophetEdge::scale(self : TimeseriesanomalyprophetEdge, f : Double) -> TimeseriesanomalyprophetEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn TimeseriesanomalyprophetEdge::add(self : TimeseriesanomalyprophetEdge, other : TimeseriesanomalyprophetEdge) -> TimeseriesanomalyprophetEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn TimeseriesanomalyprophetEdge::copy(self : TimeseriesanomalyprophetEdge) -> TimeseriesanomalyprophetEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn TimeseriesanomalyprophetEdge::fill(self : TimeseriesanomalyprophetEdge, v : Double) -> TimeseriesanomalyprophetEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn TimeseriesanomalyprophetEdge::min(self : TimeseriesanomalyprophetEdge) -> Double { @_common.min(self.data) }

pub fn TimeseriesanomalyprophetEdge::max(self : TimeseriesanomalyprophetEdge) -> Double { @_common.max(self.data) }

pub fn TimeseriesanomalyprophetEdge::to_string(self : TimeseriesanomalyprophetEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct TimeseriesanomalyprophetPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_anomaly_prophet_path_make(size : Int) -> TimeseriesanomalyprophetPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn TimeseriesanomalyprophetPath::len(self : TimeseriesanomalyprophetPath) -> Int { self.size }

pub fn TimeseriesanomalyprophetPath::get(self : TimeseriesanomalyprophetPath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn TimeseriesanomalyprophetPath::set(self : TimeseriesanomalyprophetPath, i : Int, v : Double) -> TimeseriesanomalyprophetPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn TimeseriesanomalyprophetPath::sum(self : TimeseriesanomalyprophetPath) -> Double { @_common.sum(self.data) }

pub fn TimeseriesanomalyprophetPath::mean(self : TimeseriesanomalyprophetPath) -> Double { @_common.mean(self.data) }

pub fn TimeseriesanomalyprophetPath::scale(self : TimeseriesanomalyprophetPath, f : Double) -> TimeseriesanomalyprophetPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn TimeseriesanomalyprophetPath::add(self : TimeseriesanomalyprophetPath, other : TimeseriesanomalyprophetPath) -> TimeseriesanomalyprophetPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn TimeseriesanomalyprophetPath::copy(self : TimeseriesanomalyprophetPath) -> TimeseriesanomalyprophetPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn TimeseriesanomalyprophetPath::fill(self : TimeseriesanomalyprophetPath, v : Double) -> TimeseriesanomalyprophetPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn TimeseriesanomalyprophetPath::min(self : TimeseriesanomalyprophetPath) -> Double { @_common.min(self.data) }

pub fn TimeseriesanomalyprophetPath::max(self : TimeseriesanomalyprophetPath) -> Double { @_common.max(self.data) }

pub fn TimeseriesanomalyprophetPath::to_string(self : TimeseriesanomalyprophetPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct TimeseriesanomalyprophetCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_anomaly_prophet_cluster_make(size : Int) -> TimeseriesanomalyprophetCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn TimeseriesanomalyprophetCluster::len(self : TimeseriesanomalyprophetCluster) -> Int { self.size }

pub fn TimeseriesanomalyprophetCluster::get(self : TimeseriesanomalyprophetCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn TimeseriesanomalyprophetCluster::set(self : TimeseriesanomalyprophetCluster, i : Int, v : Double) -> TimeseriesanomalyprophetCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn TimeseriesanomalyprophetCluster::sum(self : TimeseriesanomalyprophetCluster) -> Double { @_common.sum(self.data) }

pub fn TimeseriesanomalyprophetCluster::mean(self : TimeseriesanomalyprophetCluster) -> Double { @_common.mean(self.data) }

pub fn TimeseriesanomalyprophetCluster::scale(self : TimeseriesanomalyprophetCluster, f : Double) -> TimeseriesanomalyprophetCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn TimeseriesanomalyprophetCluster::add(self : TimeseriesanomalyprophetCluster, other : TimeseriesanomalyprophetCluster) -> TimeseriesanomalyprophetCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn TimeseriesanomalyprophetCluster::copy(self : TimeseriesanomalyprophetCluster) -> TimeseriesanomalyprophetCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn TimeseriesanomalyprophetCluster::fill(self : TimeseriesanomalyprophetCluster, v : Double) -> TimeseriesanomalyprophetCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn TimeseriesanomalyprophetCluster::min(self : TimeseriesanomalyprophetCluster) -> Double { @_common.min(self.data) }

pub fn TimeseriesanomalyprophetCluster::max(self : TimeseriesanomalyprophetCluster) -> Double { @_common.max(self.data) }

pub fn TimeseriesanomalyprophetCluster::to_string(self : TimeseriesanomalyprophetCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct TimeseriesanomalyprophetModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_anomaly_prophet_model_make(size : Int) -> TimeseriesanomalyprophetModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn TimeseriesanomalyprophetModel::len(self : TimeseriesanomalyprophetModel) -> Int { self.size }

pub fn TimeseriesanomalyprophetModel::get(self : TimeseriesanomalyprophetModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn TimeseriesanomalyprophetModel::set(self : TimeseriesanomalyprophetModel, i : Int, v : Double) -> TimeseriesanomalyprophetModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn TimeseriesanomalyprophetModel::sum(self : TimeseriesanomalyprophetModel) -> Double { @_common.sum(self.data) }

pub fn TimeseriesanomalyprophetModel::mean(self : TimeseriesanomalyprophetModel) -> Double { @_common.mean(self.data) }

pub fn TimeseriesanomalyprophetModel::scale(self : TimeseriesanomalyprophetModel, f : Double) -> TimeseriesanomalyprophetModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn TimeseriesanomalyprophetModel::add(self : TimeseriesanomalyprophetModel, other : TimeseriesanomalyprophetModel) -> TimeseriesanomalyprophetModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn TimeseriesanomalyprophetModel::copy(self : TimeseriesanomalyprophetModel) -> TimeseriesanomalyprophetModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn TimeseriesanomalyprophetModel::fill(self : TimeseriesanomalyprophetModel, v : Double) -> TimeseriesanomalyprophetModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn TimeseriesanomalyprophetModel::min(self : TimeseriesanomalyprophetModel) -> Double { @_common.min(self.data) }

pub fn TimeseriesanomalyprophetModel::max(self : TimeseriesanomalyprophetModel) -> Double { @_common.max(self.data) }

pub fn TimeseriesanomalyprophetModel::to_string(self : TimeseriesanomalyprophetModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct TimeseriesanomalyprophetLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_anomaly_prophet_layer_make(size : Int) -> TimeseriesanomalyprophetLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn TimeseriesanomalyprophetLayer::len(self : TimeseriesanomalyprophetLayer) -> Int { self.size }

pub fn TimeseriesanomalyprophetLayer::get(self : TimeseriesanomalyprophetLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn TimeseriesanomalyprophetLayer::set(self : TimeseriesanomalyprophetLayer, i : Int, v : Double) -> TimeseriesanomalyprophetLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn TimeseriesanomalyprophetLayer::sum(self : TimeseriesanomalyprophetLayer) -> Double { @_common.sum(self.data) }

pub fn TimeseriesanomalyprophetLayer::mean(self : TimeseriesanomalyprophetLayer) -> Double { @_common.mean(self.data) }

pub fn TimeseriesanomalyprophetLayer::scale(self : TimeseriesanomalyprophetLayer, f : Double) -> TimeseriesanomalyprophetLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn TimeseriesanomalyprophetLayer::add(self : TimeseriesanomalyprophetLayer, other : TimeseriesanomalyprophetLayer) -> TimeseriesanomalyprophetLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn TimeseriesanomalyprophetLayer::copy(self : TimeseriesanomalyprophetLayer) -> TimeseriesanomalyprophetLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn TimeseriesanomalyprophetLayer::fill(self : TimeseriesanomalyprophetLayer, v : Double) -> TimeseriesanomalyprophetLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn TimeseriesanomalyprophetLayer::min(self : TimeseriesanomalyprophetLayer) -> Double { @_common.min(self.data) }

pub fn TimeseriesanomalyprophetLayer::max(self : TimeseriesanomalyprophetLayer) -> Double { @_common.max(self.data) }

pub fn TimeseriesanomalyprophetLayer::to_string(self : TimeseriesanomalyprophetLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct TimeseriesanomalyprophetBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_anomaly_prophet_buffer_make(size : Int) -> TimeseriesanomalyprophetBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn TimeseriesanomalyprophetBuffer::len(self : TimeseriesanomalyprophetBuffer) -> Int { self.size }

pub fn TimeseriesanomalyprophetBuffer::get(self : TimeseriesanomalyprophetBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn TimeseriesanomalyprophetBuffer::set(self : TimeseriesanomalyprophetBuffer, i : Int, v : Double) -> TimeseriesanomalyprophetBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn TimeseriesanomalyprophetBuffer::sum(self : TimeseriesanomalyprophetBuffer) -> Double { @_common.sum(self.data) }

pub fn TimeseriesanomalyprophetBuffer::mean(self : TimeseriesanomalyprophetBuffer) -> Double { @_common.mean(self.data) }

pub fn TimeseriesanomalyprophetBuffer::scale(self : TimeseriesanomalyprophetBuffer, f : Double) -> TimeseriesanomalyprophetBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn TimeseriesanomalyprophetBuffer::add(self : TimeseriesanomalyprophetBuffer, other : TimeseriesanomalyprophetBuffer) -> TimeseriesanomalyprophetBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn TimeseriesanomalyprophetBuffer::copy(self : TimeseriesanomalyprophetBuffer) -> TimeseriesanomalyprophetBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn TimeseriesanomalyprophetBuffer::fill(self : TimeseriesanomalyprophetBuffer, v : Double) -> TimeseriesanomalyprophetBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn TimeseriesanomalyprophetBuffer::min(self : TimeseriesanomalyprophetBuffer) -> Double { @_common.min(self.data) }

pub fn TimeseriesanomalyprophetBuffer::max(self : TimeseriesanomalyprophetBuffer) -> Double { @_common.max(self.data) }

pub fn TimeseriesanomalyprophetBuffer::to_string(self : TimeseriesanomalyprophetBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct TimeseriesanomalyprophetCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_anomaly_prophet_cursor_make(size : Int) -> TimeseriesanomalyprophetCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn TimeseriesanomalyprophetCursor::len(self : TimeseriesanomalyprophetCursor) -> Int { self.size }

pub fn TimeseriesanomalyprophetCursor::get(self : TimeseriesanomalyprophetCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn TimeseriesanomalyprophetCursor::set(self : TimeseriesanomalyprophetCursor, i : Int, v : Double) -> TimeseriesanomalyprophetCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn TimeseriesanomalyprophetCursor::sum(self : TimeseriesanomalyprophetCursor) -> Double { @_common.sum(self.data) }

pub fn TimeseriesanomalyprophetCursor::mean(self : TimeseriesanomalyprophetCursor) -> Double { @_common.mean(self.data) }

pub fn TimeseriesanomalyprophetCursor::scale(self : TimeseriesanomalyprophetCursor, f : Double) -> TimeseriesanomalyprophetCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn TimeseriesanomalyprophetCursor::add(self : TimeseriesanomalyprophetCursor, other : TimeseriesanomalyprophetCursor) -> TimeseriesanomalyprophetCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn TimeseriesanomalyprophetCursor::copy(self : TimeseriesanomalyprophetCursor) -> TimeseriesanomalyprophetCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn TimeseriesanomalyprophetCursor::fill(self : TimeseriesanomalyprophetCursor, v : Double) -> TimeseriesanomalyprophetCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn TimeseriesanomalyprophetCursor::min(self : TimeseriesanomalyprophetCursor) -> Double { @_common.min(self.data) }

pub fn TimeseriesanomalyprophetCursor::max(self : TimeseriesanomalyprophetCursor) -> Double { @_common.max(self.data) }

pub fn TimeseriesanomalyprophetCursor::to_string(self : TimeseriesanomalyprophetCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct TimeseriesanomalyprophetView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_anomaly_prophet_view_make(size : Int) -> TimeseriesanomalyprophetView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn TimeseriesanomalyprophetView::len(self : TimeseriesanomalyprophetView) -> Int { self.size }

pub fn TimeseriesanomalyprophetView::get(self : TimeseriesanomalyprophetView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn TimeseriesanomalyprophetView::set(self : TimeseriesanomalyprophetView, i : Int, v : Double) -> TimeseriesanomalyprophetView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn TimeseriesanomalyprophetView::sum(self : TimeseriesanomalyprophetView) -> Double { @_common.sum(self.data) }

pub fn TimeseriesanomalyprophetView::mean(self : TimeseriesanomalyprophetView) -> Double { @_common.mean(self.data) }

pub fn TimeseriesanomalyprophetView::scale(self : TimeseriesanomalyprophetView, f : Double) -> TimeseriesanomalyprophetView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn TimeseriesanomalyprophetView::add(self : TimeseriesanomalyprophetView, other : TimeseriesanomalyprophetView) -> TimeseriesanomalyprophetView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn TimeseriesanomalyprophetView::copy(self : TimeseriesanomalyprophetView) -> TimeseriesanomalyprophetView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn TimeseriesanomalyprophetView::fill(self : TimeseriesanomalyprophetView, v : Double) -> TimeseriesanomalyprophetView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn TimeseriesanomalyprophetView::min(self : TimeseriesanomalyprophetView) -> Double { @_common.min(self.data) }

pub fn TimeseriesanomalyprophetView::max(self : TimeseriesanomalyprophetView) -> Double { @_common.max(self.data) }

pub fn TimeseriesanomalyprophetView::to_string(self : TimeseriesanomalyprophetView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct TimeseriesanomalyprophetRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_anomaly_prophet_range_make(size : Int) -> TimeseriesanomalyprophetRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn TimeseriesanomalyprophetRange::len(self : TimeseriesanomalyprophetRange) -> Int { self.size }

pub fn TimeseriesanomalyprophetRange::get(self : TimeseriesanomalyprophetRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn TimeseriesanomalyprophetRange::set(self : TimeseriesanomalyprophetRange, i : Int, v : Double) -> TimeseriesanomalyprophetRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn TimeseriesanomalyprophetRange::sum(self : TimeseriesanomalyprophetRange) -> Double { @_common.sum(self.data) }

pub fn TimeseriesanomalyprophetRange::mean(self : TimeseriesanomalyprophetRange) -> Double { @_common.mean(self.data) }

pub fn TimeseriesanomalyprophetRange::scale(self : TimeseriesanomalyprophetRange, f : Double) -> TimeseriesanomalyprophetRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn TimeseriesanomalyprophetRange::add(self : TimeseriesanomalyprophetRange, other : TimeseriesanomalyprophetRange) -> TimeseriesanomalyprophetRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn TimeseriesanomalyprophetRange::copy(self : TimeseriesanomalyprophetRange) -> TimeseriesanomalyprophetRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn TimeseriesanomalyprophetRange::fill(self : TimeseriesanomalyprophetRange, v : Double) -> TimeseriesanomalyprophetRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn TimeseriesanomalyprophetRange::min(self : TimeseriesanomalyprophetRange) -> Double { @_common.min(self.data) }

pub fn TimeseriesanomalyprophetRange::max(self : TimeseriesanomalyprophetRange) -> Double { @_common.max(self.data) }

pub fn TimeseriesanomalyprophetRange::to_string(self : TimeseriesanomalyprophetRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct TimeseriesanomalyprophetSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_anomaly_prophet_slice_make(size : Int) -> TimeseriesanomalyprophetSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn TimeseriesanomalyprophetSlice::len(self : TimeseriesanomalyprophetSlice) -> Int { self.size }

pub fn TimeseriesanomalyprophetSlice::get(self : TimeseriesanomalyprophetSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn TimeseriesanomalyprophetSlice::set(self : TimeseriesanomalyprophetSlice, i : Int, v : Double) -> TimeseriesanomalyprophetSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn TimeseriesanomalyprophetSlice::sum(self : TimeseriesanomalyprophetSlice) -> Double { @_common.sum(self.data) }

pub fn TimeseriesanomalyprophetSlice::mean(self : TimeseriesanomalyprophetSlice) -> Double { @_common.mean(self.data) }

pub fn TimeseriesanomalyprophetSlice::scale(self : TimeseriesanomalyprophetSlice, f : Double) -> TimeseriesanomalyprophetSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn TimeseriesanomalyprophetSlice::add(self : TimeseriesanomalyprophetSlice, other : TimeseriesanomalyprophetSlice) -> TimeseriesanomalyprophetSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn TimeseriesanomalyprophetSlice::copy(self : TimeseriesanomalyprophetSlice) -> TimeseriesanomalyprophetSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn TimeseriesanomalyprophetSlice::fill(self : TimeseriesanomalyprophetSlice, v : Double) -> TimeseriesanomalyprophetSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn TimeseriesanomalyprophetSlice::min(self : TimeseriesanomalyprophetSlice) -> Double { @_common.min(self.data) }

pub fn TimeseriesanomalyprophetSlice::max(self : TimeseriesanomalyprophetSlice) -> Double { @_common.max(self.data) }

pub fn TimeseriesanomalyprophetSlice::to_string(self : TimeseriesanomalyprophetSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

