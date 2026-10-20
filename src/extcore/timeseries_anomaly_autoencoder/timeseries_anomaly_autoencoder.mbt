///===
/// extcore/timeseries_anomaly_autoencoder

pub(all) struct TimeseriesanomalyautoencoderPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn timeseries_anomaly_autoencoder_make_point(x : Double, y : Double) -> TimeseriesanomalyautoencoderPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn timeseries_anomaly_autoencoder_make_point3(x : Double, y : Double, z : Double) -> TimeseriesanomalyautoencoderPoint {
  { x, y, z, label: 0 }
}

pub fn TimeseriesanomalyautoencoderPoint::x(self : TimeseriesanomalyautoencoderPoint) -> Double { self.x }

pub fn TimeseriesanomalyautoencoderPoint::y(self : TimeseriesanomalyautoencoderPoint) -> Double { self.y }

pub fn TimeseriesanomalyautoencoderPoint::z(self : TimeseriesanomalyautoencoderPoint) -> Double { self.z }

pub fn TimeseriesanomalyautoencoderPoint::label(self : TimeseriesanomalyautoencoderPoint) -> Int { self.label }

pub fn TimeseriesanomalyautoencoderPoint::dist(self : TimeseriesanomalyautoencoderPoint, other : TimeseriesanomalyautoencoderPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn TimeseriesanomalyautoencoderPoint::add(self : TimeseriesanomalyautoencoderPoint, other : TimeseriesanomalyautoencoderPoint) -> TimeseriesanomalyautoencoderPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn TimeseriesanomalyautoencoderPoint::sub(self : TimeseriesanomalyautoencoderPoint, other : TimeseriesanomalyautoencoderPoint) -> TimeseriesanomalyautoencoderPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn TimeseriesanomalyautoencoderPoint::scale(self : TimeseriesanomalyautoencoderPoint, s : Double) -> TimeseriesanomalyautoencoderPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn TimeseriesanomalyautoencoderPoint::dot(self : TimeseriesanomalyautoencoderPoint, other : TimeseriesanomalyautoencoderPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn TimeseriesanomalyautoencoderPoint::cross(self : TimeseriesanomalyautoencoderPoint, other : TimeseriesanomalyautoencoderPoint) -> TimeseriesanomalyautoencoderPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn TimeseriesanomalyautoencoderPoint::norm(self : TimeseriesanomalyautoencoderPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn TimeseriesanomalyautoencoderPoint::normalize(self : TimeseriesanomalyautoencoderPoint) -> TimeseriesanomalyautoencoderPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn TimeseriesanomalyautoencoderPoint::negate(self : TimeseriesanomalyautoencoderPoint) -> TimeseriesanomalyautoencoderPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn TimeseriesanomalyautoencoderPoint::mid(self : TimeseriesanomalyautoencoderPoint, other : TimeseriesanomalyautoencoderPoint) -> TimeseriesanomalyautoencoderPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn TimeseriesanomalyautoencoderPoint::lerp(self : TimeseriesanomalyautoencoderPoint, other : TimeseriesanomalyautoencoderPoint, t : Double) -> TimeseriesanomalyautoencoderPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn TimeseriesanomalyautoencoderPoint::to_string(self : TimeseriesanomalyautoencoderPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct TimeseriesanomalyautoencoderSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn timeseries_anomaly_autoencoder_make_series(vals : Array[Double], name : String) -> TimeseriesanomalyautoencoderSeries {
  { vals, name, meta: 0 }
}

pub fn TimeseriesanomalyautoencoderSeries::len(self : TimeseriesanomalyautoencoderSeries) -> Int { self.vals.length() }

pub fn TimeseriesanomalyautoencoderSeries::sum(self : TimeseriesanomalyautoencoderSeries) -> Double { @_common.sum(self.vals) }

pub fn TimeseriesanomalyautoencoderSeries::mean(self : TimeseriesanomalyautoencoderSeries) -> Double { @_common.mean(self.vals) }

pub fn TimeseriesanomalyautoencoderSeries::min(self : TimeseriesanomalyautoencoderSeries) -> Double { @_common.min(self.vals) }

pub fn TimeseriesanomalyautoencoderSeries::max(self : TimeseriesanomalyautoencoderSeries) -> Double { @_common.max(self.vals) }

pub fn TimeseriesanomalyautoencoderSeries::range(self : TimeseriesanomalyautoencoderSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn TimeseriesanomalyautoencoderSeries::variance(self : TimeseriesanomalyautoencoderSeries) -> Double { @_common.variance(self.vals) }

pub fn TimeseriesanomalyautoencoderSeries::std(self : TimeseriesanomalyautoencoderSeries) -> Double { @_common.std(self.vals) }

pub fn TimeseriesanomalyautoencoderSeries::median(self : TimeseriesanomalyautoencoderSeries) -> Double { @_common.median(self.vals) }

pub fn TimeseriesanomalyautoencoderSeries::scale(self : TimeseriesanomalyautoencoderSeries, f : Double) -> TimeseriesanomalyautoencoderSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn TimeseriesanomalyautoencoderSeries::add(self : TimeseriesanomalyautoencoderSeries, other : TimeseriesanomalyautoencoderSeries) -> TimeseriesanomalyautoencoderSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn TimeseriesanomalyautoencoderSeries::sub(self : TimeseriesanomalyautoencoderSeries, other : TimeseriesanomalyautoencoderSeries) -> TimeseriesanomalyautoencoderSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn TimeseriesanomalyautoencoderSeries::normalize(self : TimeseriesanomalyautoencoderSeries) -> TimeseriesanomalyautoencoderSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn TimeseriesanomalyautoencoderSeries::cumsum(self : TimeseriesanomalyautoencoderSeries) -> TimeseriesanomalyautoencoderSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn TimeseriesanomalyautoencoderSeries::to_string(self : TimeseriesanomalyautoencoderSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct TimeseriesanomalyautoencoderMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn timeseries_anomaly_autoencoder_make_matrix(rows : Int, cols : Int, val : Double) -> TimeseriesanomalyautoencoderMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn timeseries_anomaly_autoencoder_matrix_identity(n : Int) -> TimeseriesanomalyautoencoderMatrix {
  let m = timeseries_anomaly_autoencoder_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn TimeseriesanomalyautoencoderMatrix::get(self : TimeseriesanomalyautoencoderMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn TimeseriesanomalyautoencoderMatrix::transpose(self : TimeseriesanomalyautoencoderMatrix) -> TimeseriesanomalyautoencoderMatrix {
  let result = timeseries_anomaly_autoencoder_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn TimeseriesanomalyautoencoderMatrix::add(self : TimeseriesanomalyautoencoderMatrix, other : TimeseriesanomalyautoencoderMatrix) -> TimeseriesanomalyautoencoderMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = timeseries_anomaly_autoencoder_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn TimeseriesanomalyautoencoderMatrix::scale(self : TimeseriesanomalyautoencoderMatrix, s : Double) -> TimeseriesanomalyautoencoderMatrix {
  let result = timeseries_anomaly_autoencoder_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn TimeseriesanomalyautoencoderMatrix::multiply(self : TimeseriesanomalyautoencoderMatrix, other : TimeseriesanomalyautoencoderMatrix) -> TimeseriesanomalyautoencoderMatrix {
  if self.cols != other.rows { return timeseries_anomaly_autoencoder_make_matrix(self.rows, other.cols, 0.0) }
  let result = timeseries_anomaly_autoencoder_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn TimeseriesanomalyautoencoderMatrix::trace(self : TimeseriesanomalyautoencoderMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn TimeseriesanomalyautoencoderMatrix::det(self : TimeseriesanomalyautoencoderMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn TimeseriesanomalyautoencoderMatrix::norm(self : TimeseriesanomalyautoencoderMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn TimeseriesanomalyautoencoderMatrix::to_string(self : TimeseriesanomalyautoencoderMatrix) -> String {
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

pub(all) struct TimeseriesanomalyautoencoderVector {
  comps : Array[Double]
  dim : Int
}

pub fn timeseries_anomaly_autoencoder_make_vector(comps : Array[Double]) -> TimeseriesanomalyautoencoderVector {
  { comps, dim: comps.length() }
}

pub fn timeseries_anomaly_autoencoder_vector_zero(dim : Int) -> TimeseriesanomalyautoencoderVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn TimeseriesanomalyautoencoderVector::add(self : TimeseriesanomalyautoencoderVector, other : TimeseriesanomalyautoencoderVector) -> TimeseriesanomalyautoencoderVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn TimeseriesanomalyautoencoderVector::sub(self : TimeseriesanomalyautoencoderVector, other : TimeseriesanomalyautoencoderVector) -> TimeseriesanomalyautoencoderVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn TimeseriesanomalyautoencoderVector::scale(self : TimeseriesanomalyautoencoderVector, s : Double) -> TimeseriesanomalyautoencoderVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn TimeseriesanomalyautoencoderVector::dot(self : TimeseriesanomalyautoencoderVector, other : TimeseriesanomalyautoencoderVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn TimeseriesanomalyautoencoderVector::norm(self : TimeseriesanomalyautoencoderVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn TimeseriesanomalyautoencoderVector::normalize(self : TimeseriesanomalyautoencoderVector) -> TimeseriesanomalyautoencoderVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn TimeseriesanomalyautoencoderVector::dist(self : TimeseriesanomalyautoencoderVector, other : TimeseriesanomalyautoencoderVector) -> Double {
  self.sub(other).norm()
}

pub fn TimeseriesanomalyautoencoderVector::to_string(self : TimeseriesanomalyautoencoderVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn timeseries_anomaly_autoencoder_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn timeseries_anomaly_autoencoder_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn timeseries_anomaly_autoencoder_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn timeseries_anomaly_autoencoder_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn timeseries_anomaly_autoencoder_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn timeseries_anomaly_autoencoder_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn timeseries_anomaly_autoencoder_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn timeseries_anomaly_autoencoder_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn timeseries_anomaly_autoencoder_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn timeseries_anomaly_autoencoder_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn timeseries_anomaly_autoencoder_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn timeseries_anomaly_autoencoder_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn timeseries_anomaly_autoencoder_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn timeseries_anomaly_autoencoder_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn timeseries_anomaly_autoencoder_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn timeseries_anomaly_autoencoder_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn timeseries_anomaly_autoencoder_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn timeseries_anomaly_autoencoder_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn timeseries_anomaly_autoencoder_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn timeseries_anomaly_autoencoder_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn timeseries_anomaly_autoencoder_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn timeseries_anomaly_autoencoder_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn timeseries_anomaly_autoencoder_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn timeseries_anomaly_autoencoder_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn timeseries_anomaly_autoencoder_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn timeseries_anomaly_autoencoder_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn timeseries_anomaly_autoencoder_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn timeseries_anomaly_autoencoder_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn timeseries_anomaly_autoencoder_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct TimeseriesanomalyautoencoderFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_anomaly_autoencoder_frame_make(size : Int) -> TimeseriesanomalyautoencoderFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn TimeseriesanomalyautoencoderFrame::len(self : TimeseriesanomalyautoencoderFrame) -> Int { self.size }

pub fn TimeseriesanomalyautoencoderFrame::get(self : TimeseriesanomalyautoencoderFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn TimeseriesanomalyautoencoderFrame::set(self : TimeseriesanomalyautoencoderFrame, i : Int, v : Double) -> TimeseriesanomalyautoencoderFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn TimeseriesanomalyautoencoderFrame::sum(self : TimeseriesanomalyautoencoderFrame) -> Double { @_common.sum(self.data) }

pub fn TimeseriesanomalyautoencoderFrame::mean(self : TimeseriesanomalyautoencoderFrame) -> Double { @_common.mean(self.data) }

pub fn TimeseriesanomalyautoencoderFrame::scale(self : TimeseriesanomalyautoencoderFrame, f : Double) -> TimeseriesanomalyautoencoderFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn TimeseriesanomalyautoencoderFrame::add(self : TimeseriesanomalyautoencoderFrame, other : TimeseriesanomalyautoencoderFrame) -> TimeseriesanomalyautoencoderFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn TimeseriesanomalyautoencoderFrame::copy(self : TimeseriesanomalyautoencoderFrame) -> TimeseriesanomalyautoencoderFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn TimeseriesanomalyautoencoderFrame::fill(self : TimeseriesanomalyautoencoderFrame, v : Double) -> TimeseriesanomalyautoencoderFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn TimeseriesanomalyautoencoderFrame::min(self : TimeseriesanomalyautoencoderFrame) -> Double { @_common.min(self.data) }

pub fn TimeseriesanomalyautoencoderFrame::max(self : TimeseriesanomalyautoencoderFrame) -> Double { @_common.max(self.data) }

pub fn TimeseriesanomalyautoencoderFrame::to_string(self : TimeseriesanomalyautoencoderFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct TimeseriesanomalyautoencoderTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_anomaly_autoencoder_table_make(size : Int) -> TimeseriesanomalyautoencoderTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn TimeseriesanomalyautoencoderTable::len(self : TimeseriesanomalyautoencoderTable) -> Int { self.size }

pub fn TimeseriesanomalyautoencoderTable::get(self : TimeseriesanomalyautoencoderTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn TimeseriesanomalyautoencoderTable::set(self : TimeseriesanomalyautoencoderTable, i : Int, v : Double) -> TimeseriesanomalyautoencoderTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn TimeseriesanomalyautoencoderTable::sum(self : TimeseriesanomalyautoencoderTable) -> Double { @_common.sum(self.data) }

pub fn TimeseriesanomalyautoencoderTable::mean(self : TimeseriesanomalyautoencoderTable) -> Double { @_common.mean(self.data) }

pub fn TimeseriesanomalyautoencoderTable::scale(self : TimeseriesanomalyautoencoderTable, f : Double) -> TimeseriesanomalyautoencoderTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn TimeseriesanomalyautoencoderTable::add(self : TimeseriesanomalyautoencoderTable, other : TimeseriesanomalyautoencoderTable) -> TimeseriesanomalyautoencoderTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn TimeseriesanomalyautoencoderTable::copy(self : TimeseriesanomalyautoencoderTable) -> TimeseriesanomalyautoencoderTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn TimeseriesanomalyautoencoderTable::fill(self : TimeseriesanomalyautoencoderTable, v : Double) -> TimeseriesanomalyautoencoderTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn TimeseriesanomalyautoencoderTable::min(self : TimeseriesanomalyautoencoderTable) -> Double { @_common.min(self.data) }

pub fn TimeseriesanomalyautoencoderTable::max(self : TimeseriesanomalyautoencoderTable) -> Double { @_common.max(self.data) }

pub fn TimeseriesanomalyautoencoderTable::to_string(self : TimeseriesanomalyautoencoderTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct TimeseriesanomalyautoencoderGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_anomaly_autoencoder_graphn_make(size : Int) -> TimeseriesanomalyautoencoderGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn TimeseriesanomalyautoencoderGraphN::len(self : TimeseriesanomalyautoencoderGraphN) -> Int { self.size }

pub fn TimeseriesanomalyautoencoderGraphN::get(self : TimeseriesanomalyautoencoderGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn TimeseriesanomalyautoencoderGraphN::set(self : TimeseriesanomalyautoencoderGraphN, i : Int, v : Double) -> TimeseriesanomalyautoencoderGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn TimeseriesanomalyautoencoderGraphN::sum(self : TimeseriesanomalyautoencoderGraphN) -> Double { @_common.sum(self.data) }

pub fn TimeseriesanomalyautoencoderGraphN::mean(self : TimeseriesanomalyautoencoderGraphN) -> Double { @_common.mean(self.data) }

pub fn TimeseriesanomalyautoencoderGraphN::scale(self : TimeseriesanomalyautoencoderGraphN, f : Double) -> TimeseriesanomalyautoencoderGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn TimeseriesanomalyautoencoderGraphN::add(self : TimeseriesanomalyautoencoderGraphN, other : TimeseriesanomalyautoencoderGraphN) -> TimeseriesanomalyautoencoderGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn TimeseriesanomalyautoencoderGraphN::copy(self : TimeseriesanomalyautoencoderGraphN) -> TimeseriesanomalyautoencoderGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn TimeseriesanomalyautoencoderGraphN::fill(self : TimeseriesanomalyautoencoderGraphN, v : Double) -> TimeseriesanomalyautoencoderGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn TimeseriesanomalyautoencoderGraphN::min(self : TimeseriesanomalyautoencoderGraphN) -> Double { @_common.min(self.data) }

pub fn TimeseriesanomalyautoencoderGraphN::max(self : TimeseriesanomalyautoencoderGraphN) -> Double { @_common.max(self.data) }

pub fn TimeseriesanomalyautoencoderGraphN::to_string(self : TimeseriesanomalyautoencoderGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct TimeseriesanomalyautoencoderNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_anomaly_autoencoder_node_make(size : Int) -> TimeseriesanomalyautoencoderNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn TimeseriesanomalyautoencoderNode::len(self : TimeseriesanomalyautoencoderNode) -> Int { self.size }

pub fn TimeseriesanomalyautoencoderNode::get(self : TimeseriesanomalyautoencoderNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn TimeseriesanomalyautoencoderNode::set(self : TimeseriesanomalyautoencoderNode, i : Int, v : Double) -> TimeseriesanomalyautoencoderNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn TimeseriesanomalyautoencoderNode::sum(self : TimeseriesanomalyautoencoderNode) -> Double { @_common.sum(self.data) }

pub fn TimeseriesanomalyautoencoderNode::mean(self : TimeseriesanomalyautoencoderNode) -> Double { @_common.mean(self.data) }

pub fn TimeseriesanomalyautoencoderNode::scale(self : TimeseriesanomalyautoencoderNode, f : Double) -> TimeseriesanomalyautoencoderNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn TimeseriesanomalyautoencoderNode::add(self : TimeseriesanomalyautoencoderNode, other : TimeseriesanomalyautoencoderNode) -> TimeseriesanomalyautoencoderNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn TimeseriesanomalyautoencoderNode::copy(self : TimeseriesanomalyautoencoderNode) -> TimeseriesanomalyautoencoderNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn TimeseriesanomalyautoencoderNode::fill(self : TimeseriesanomalyautoencoderNode, v : Double) -> TimeseriesanomalyautoencoderNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn TimeseriesanomalyautoencoderNode::min(self : TimeseriesanomalyautoencoderNode) -> Double { @_common.min(self.data) }

pub fn TimeseriesanomalyautoencoderNode::max(self : TimeseriesanomalyautoencoderNode) -> Double { @_common.max(self.data) }

pub fn TimeseriesanomalyautoencoderNode::to_string(self : TimeseriesanomalyautoencoderNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct TimeseriesanomalyautoencoderEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_anomaly_autoencoder_edge_make(size : Int) -> TimeseriesanomalyautoencoderEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn TimeseriesanomalyautoencoderEdge::len(self : TimeseriesanomalyautoencoderEdge) -> Int { self.size }

pub fn TimeseriesanomalyautoencoderEdge::get(self : TimeseriesanomalyautoencoderEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn TimeseriesanomalyautoencoderEdge::set(self : TimeseriesanomalyautoencoderEdge, i : Int, v : Double) -> TimeseriesanomalyautoencoderEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn TimeseriesanomalyautoencoderEdge::sum(self : TimeseriesanomalyautoencoderEdge) -> Double { @_common.sum(self.data) }

pub fn TimeseriesanomalyautoencoderEdge::mean(self : TimeseriesanomalyautoencoderEdge) -> Double { @_common.mean(self.data) }

pub fn TimeseriesanomalyautoencoderEdge::scale(self : TimeseriesanomalyautoencoderEdge, f : Double) -> TimeseriesanomalyautoencoderEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn TimeseriesanomalyautoencoderEdge::add(self : TimeseriesanomalyautoencoderEdge, other : TimeseriesanomalyautoencoderEdge) -> TimeseriesanomalyautoencoderEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn TimeseriesanomalyautoencoderEdge::copy(self : TimeseriesanomalyautoencoderEdge) -> TimeseriesanomalyautoencoderEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn TimeseriesanomalyautoencoderEdge::fill(self : TimeseriesanomalyautoencoderEdge, v : Double) -> TimeseriesanomalyautoencoderEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn TimeseriesanomalyautoencoderEdge::min(self : TimeseriesanomalyautoencoderEdge) -> Double { @_common.min(self.data) }

pub fn TimeseriesanomalyautoencoderEdge::max(self : TimeseriesanomalyautoencoderEdge) -> Double { @_common.max(self.data) }

pub fn TimeseriesanomalyautoencoderEdge::to_string(self : TimeseriesanomalyautoencoderEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct TimeseriesanomalyautoencoderPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_anomaly_autoencoder_path_make(size : Int) -> TimeseriesanomalyautoencoderPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn TimeseriesanomalyautoencoderPath::len(self : TimeseriesanomalyautoencoderPath) -> Int { self.size }

pub fn TimeseriesanomalyautoencoderPath::get(self : TimeseriesanomalyautoencoderPath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn TimeseriesanomalyautoencoderPath::set(self : TimeseriesanomalyautoencoderPath, i : Int, v : Double) -> TimeseriesanomalyautoencoderPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn TimeseriesanomalyautoencoderPath::sum(self : TimeseriesanomalyautoencoderPath) -> Double { @_common.sum(self.data) }

pub fn TimeseriesanomalyautoencoderPath::mean(self : TimeseriesanomalyautoencoderPath) -> Double { @_common.mean(self.data) }

pub fn TimeseriesanomalyautoencoderPath::scale(self : TimeseriesanomalyautoencoderPath, f : Double) -> TimeseriesanomalyautoencoderPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn TimeseriesanomalyautoencoderPath::add(self : TimeseriesanomalyautoencoderPath, other : TimeseriesanomalyautoencoderPath) -> TimeseriesanomalyautoencoderPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn TimeseriesanomalyautoencoderPath::copy(self : TimeseriesanomalyautoencoderPath) -> TimeseriesanomalyautoencoderPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn TimeseriesanomalyautoencoderPath::fill(self : TimeseriesanomalyautoencoderPath, v : Double) -> TimeseriesanomalyautoencoderPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn TimeseriesanomalyautoencoderPath::min(self : TimeseriesanomalyautoencoderPath) -> Double { @_common.min(self.data) }

pub fn TimeseriesanomalyautoencoderPath::max(self : TimeseriesanomalyautoencoderPath) -> Double { @_common.max(self.data) }

pub fn TimeseriesanomalyautoencoderPath::to_string(self : TimeseriesanomalyautoencoderPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct TimeseriesanomalyautoencoderCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_anomaly_autoencoder_cluster_make(size : Int) -> TimeseriesanomalyautoencoderCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn TimeseriesanomalyautoencoderCluster::len(self : TimeseriesanomalyautoencoderCluster) -> Int { self.size }

pub fn TimeseriesanomalyautoencoderCluster::get(self : TimeseriesanomalyautoencoderCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn TimeseriesanomalyautoencoderCluster::set(self : TimeseriesanomalyautoencoderCluster, i : Int, v : Double) -> TimeseriesanomalyautoencoderCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn TimeseriesanomalyautoencoderCluster::sum(self : TimeseriesanomalyautoencoderCluster) -> Double { @_common.sum(self.data) }

pub fn TimeseriesanomalyautoencoderCluster::mean(self : TimeseriesanomalyautoencoderCluster) -> Double { @_common.mean(self.data) }

pub fn TimeseriesanomalyautoencoderCluster::scale(self : TimeseriesanomalyautoencoderCluster, f : Double) -> TimeseriesanomalyautoencoderCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn TimeseriesanomalyautoencoderCluster::add(self : TimeseriesanomalyautoencoderCluster, other : TimeseriesanomalyautoencoderCluster) -> TimeseriesanomalyautoencoderCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn TimeseriesanomalyautoencoderCluster::copy(self : TimeseriesanomalyautoencoderCluster) -> TimeseriesanomalyautoencoderCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn TimeseriesanomalyautoencoderCluster::fill(self : TimeseriesanomalyautoencoderCluster, v : Double) -> TimeseriesanomalyautoencoderCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn TimeseriesanomalyautoencoderCluster::min(self : TimeseriesanomalyautoencoderCluster) -> Double { @_common.min(self.data) }

pub fn TimeseriesanomalyautoencoderCluster::max(self : TimeseriesanomalyautoencoderCluster) -> Double { @_common.max(self.data) }

pub fn TimeseriesanomalyautoencoderCluster::to_string(self : TimeseriesanomalyautoencoderCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct TimeseriesanomalyautoencoderModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_anomaly_autoencoder_model_make(size : Int) -> TimeseriesanomalyautoencoderModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn TimeseriesanomalyautoencoderModel::len(self : TimeseriesanomalyautoencoderModel) -> Int { self.size }

pub fn TimeseriesanomalyautoencoderModel::get(self : TimeseriesanomalyautoencoderModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn TimeseriesanomalyautoencoderModel::set(self : TimeseriesanomalyautoencoderModel, i : Int, v : Double) -> TimeseriesanomalyautoencoderModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn TimeseriesanomalyautoencoderModel::sum(self : TimeseriesanomalyautoencoderModel) -> Double { @_common.sum(self.data) }

pub fn TimeseriesanomalyautoencoderModel::mean(self : TimeseriesanomalyautoencoderModel) -> Double { @_common.mean(self.data) }

pub fn TimeseriesanomalyautoencoderModel::scale(self : TimeseriesanomalyautoencoderModel, f : Double) -> TimeseriesanomalyautoencoderModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn TimeseriesanomalyautoencoderModel::add(self : TimeseriesanomalyautoencoderModel, other : TimeseriesanomalyautoencoderModel) -> TimeseriesanomalyautoencoderModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn TimeseriesanomalyautoencoderModel::copy(self : TimeseriesanomalyautoencoderModel) -> TimeseriesanomalyautoencoderModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn TimeseriesanomalyautoencoderModel::fill(self : TimeseriesanomalyautoencoderModel, v : Double) -> TimeseriesanomalyautoencoderModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn TimeseriesanomalyautoencoderModel::min(self : TimeseriesanomalyautoencoderModel) -> Double { @_common.min(self.data) }

pub fn TimeseriesanomalyautoencoderModel::max(self : TimeseriesanomalyautoencoderModel) -> Double { @_common.max(self.data) }

pub fn TimeseriesanomalyautoencoderModel::to_string(self : TimeseriesanomalyautoencoderModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct TimeseriesanomalyautoencoderLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_anomaly_autoencoder_layer_make(size : Int) -> TimeseriesanomalyautoencoderLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn TimeseriesanomalyautoencoderLayer::len(self : TimeseriesanomalyautoencoderLayer) -> Int { self.size }

pub fn TimeseriesanomalyautoencoderLayer::get(self : TimeseriesanomalyautoencoderLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn TimeseriesanomalyautoencoderLayer::set(self : TimeseriesanomalyautoencoderLayer, i : Int, v : Double) -> TimeseriesanomalyautoencoderLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn TimeseriesanomalyautoencoderLayer::sum(self : TimeseriesanomalyautoencoderLayer) -> Double { @_common.sum(self.data) }

pub fn TimeseriesanomalyautoencoderLayer::mean(self : TimeseriesanomalyautoencoderLayer) -> Double { @_common.mean(self.data) }

pub fn TimeseriesanomalyautoencoderLayer::scale(self : TimeseriesanomalyautoencoderLayer, f : Double) -> TimeseriesanomalyautoencoderLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn TimeseriesanomalyautoencoderLayer::add(self : TimeseriesanomalyautoencoderLayer, other : TimeseriesanomalyautoencoderLayer) -> TimeseriesanomalyautoencoderLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn TimeseriesanomalyautoencoderLayer::copy(self : TimeseriesanomalyautoencoderLayer) -> TimeseriesanomalyautoencoderLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn TimeseriesanomalyautoencoderLayer::fill(self : TimeseriesanomalyautoencoderLayer, v : Double) -> TimeseriesanomalyautoencoderLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn TimeseriesanomalyautoencoderLayer::min(self : TimeseriesanomalyautoencoderLayer) -> Double { @_common.min(self.data) }

pub fn TimeseriesanomalyautoencoderLayer::max(self : TimeseriesanomalyautoencoderLayer) -> Double { @_common.max(self.data) }

pub fn TimeseriesanomalyautoencoderLayer::to_string(self : TimeseriesanomalyautoencoderLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct TimeseriesanomalyautoencoderBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_anomaly_autoencoder_buffer_make(size : Int) -> TimeseriesanomalyautoencoderBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn TimeseriesanomalyautoencoderBuffer::len(self : TimeseriesanomalyautoencoderBuffer) -> Int { self.size }

pub fn TimeseriesanomalyautoencoderBuffer::get(self : TimeseriesanomalyautoencoderBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn TimeseriesanomalyautoencoderBuffer::set(self : TimeseriesanomalyautoencoderBuffer, i : Int, v : Double) -> TimeseriesanomalyautoencoderBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn TimeseriesanomalyautoencoderBuffer::sum(self : TimeseriesanomalyautoencoderBuffer) -> Double { @_common.sum(self.data) }

pub fn TimeseriesanomalyautoencoderBuffer::mean(self : TimeseriesanomalyautoencoderBuffer) -> Double { @_common.mean(self.data) }

pub fn TimeseriesanomalyautoencoderBuffer::scale(self : TimeseriesanomalyautoencoderBuffer, f : Double) -> TimeseriesanomalyautoencoderBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn TimeseriesanomalyautoencoderBuffer::add(self : TimeseriesanomalyautoencoderBuffer, other : TimeseriesanomalyautoencoderBuffer) -> TimeseriesanomalyautoencoderBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn TimeseriesanomalyautoencoderBuffer::copy(self : TimeseriesanomalyautoencoderBuffer) -> TimeseriesanomalyautoencoderBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn TimeseriesanomalyautoencoderBuffer::fill(self : TimeseriesanomalyautoencoderBuffer, v : Double) -> TimeseriesanomalyautoencoderBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn TimeseriesanomalyautoencoderBuffer::min(self : TimeseriesanomalyautoencoderBuffer) -> Double { @_common.min(self.data) }

pub fn TimeseriesanomalyautoencoderBuffer::max(self : TimeseriesanomalyautoencoderBuffer) -> Double { @_common.max(self.data) }

pub fn TimeseriesanomalyautoencoderBuffer::to_string(self : TimeseriesanomalyautoencoderBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct TimeseriesanomalyautoencoderCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_anomaly_autoencoder_cursor_make(size : Int) -> TimeseriesanomalyautoencoderCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn TimeseriesanomalyautoencoderCursor::len(self : TimeseriesanomalyautoencoderCursor) -> Int { self.size }

pub fn TimeseriesanomalyautoencoderCursor::get(self : TimeseriesanomalyautoencoderCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn TimeseriesanomalyautoencoderCursor::set(self : TimeseriesanomalyautoencoderCursor, i : Int, v : Double) -> TimeseriesanomalyautoencoderCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn TimeseriesanomalyautoencoderCursor::sum(self : TimeseriesanomalyautoencoderCursor) -> Double { @_common.sum(self.data) }

pub fn TimeseriesanomalyautoencoderCursor::mean(self : TimeseriesanomalyautoencoderCursor) -> Double { @_common.mean(self.data) }

pub fn TimeseriesanomalyautoencoderCursor::scale(self : TimeseriesanomalyautoencoderCursor, f : Double) -> TimeseriesanomalyautoencoderCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn TimeseriesanomalyautoencoderCursor::add(self : TimeseriesanomalyautoencoderCursor, other : TimeseriesanomalyautoencoderCursor) -> TimeseriesanomalyautoencoderCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn TimeseriesanomalyautoencoderCursor::copy(self : TimeseriesanomalyautoencoderCursor) -> TimeseriesanomalyautoencoderCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn TimeseriesanomalyautoencoderCursor::fill(self : TimeseriesanomalyautoencoderCursor, v : Double) -> TimeseriesanomalyautoencoderCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn TimeseriesanomalyautoencoderCursor::min(self : TimeseriesanomalyautoencoderCursor) -> Double { @_common.min(self.data) }

pub fn TimeseriesanomalyautoencoderCursor::max(self : TimeseriesanomalyautoencoderCursor) -> Double { @_common.max(self.data) }

pub fn TimeseriesanomalyautoencoderCursor::to_string(self : TimeseriesanomalyautoencoderCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct TimeseriesanomalyautoencoderView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_anomaly_autoencoder_view_make(size : Int) -> TimeseriesanomalyautoencoderView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn TimeseriesanomalyautoencoderView::len(self : TimeseriesanomalyautoencoderView) -> Int { self.size }

pub fn TimeseriesanomalyautoencoderView::get(self : TimeseriesanomalyautoencoderView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn TimeseriesanomalyautoencoderView::set(self : TimeseriesanomalyautoencoderView, i : Int, v : Double) -> TimeseriesanomalyautoencoderView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn TimeseriesanomalyautoencoderView::sum(self : TimeseriesanomalyautoencoderView) -> Double { @_common.sum(self.data) }

pub fn TimeseriesanomalyautoencoderView::mean(self : TimeseriesanomalyautoencoderView) -> Double { @_common.mean(self.data) }

pub fn TimeseriesanomalyautoencoderView::scale(self : TimeseriesanomalyautoencoderView, f : Double) -> TimeseriesanomalyautoencoderView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn TimeseriesanomalyautoencoderView::add(self : TimeseriesanomalyautoencoderView, other : TimeseriesanomalyautoencoderView) -> TimeseriesanomalyautoencoderView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn TimeseriesanomalyautoencoderView::copy(self : TimeseriesanomalyautoencoderView) -> TimeseriesanomalyautoencoderView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn TimeseriesanomalyautoencoderView::fill(self : TimeseriesanomalyautoencoderView, v : Double) -> TimeseriesanomalyautoencoderView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn TimeseriesanomalyautoencoderView::min(self : TimeseriesanomalyautoencoderView) -> Double { @_common.min(self.data) }

pub fn TimeseriesanomalyautoencoderView::max(self : TimeseriesanomalyautoencoderView) -> Double { @_common.max(self.data) }

pub fn TimeseriesanomalyautoencoderView::to_string(self : TimeseriesanomalyautoencoderView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct TimeseriesanomalyautoencoderRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_anomaly_autoencoder_range_make(size : Int) -> TimeseriesanomalyautoencoderRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn TimeseriesanomalyautoencoderRange::len(self : TimeseriesanomalyautoencoderRange) -> Int { self.size }

pub fn TimeseriesanomalyautoencoderRange::get(self : TimeseriesanomalyautoencoderRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn TimeseriesanomalyautoencoderRange::set(self : TimeseriesanomalyautoencoderRange, i : Int, v : Double) -> TimeseriesanomalyautoencoderRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn TimeseriesanomalyautoencoderRange::sum(self : TimeseriesanomalyautoencoderRange) -> Double { @_common.sum(self.data) }

pub fn TimeseriesanomalyautoencoderRange::mean(self : TimeseriesanomalyautoencoderRange) -> Double { @_common.mean(self.data) }

pub fn TimeseriesanomalyautoencoderRange::scale(self : TimeseriesanomalyautoencoderRange, f : Double) -> TimeseriesanomalyautoencoderRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn TimeseriesanomalyautoencoderRange::add(self : TimeseriesanomalyautoencoderRange, other : TimeseriesanomalyautoencoderRange) -> TimeseriesanomalyautoencoderRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn TimeseriesanomalyautoencoderRange::copy(self : TimeseriesanomalyautoencoderRange) -> TimeseriesanomalyautoencoderRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn TimeseriesanomalyautoencoderRange::fill(self : TimeseriesanomalyautoencoderRange, v : Double) -> TimeseriesanomalyautoencoderRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn TimeseriesanomalyautoencoderRange::min(self : TimeseriesanomalyautoencoderRange) -> Double { @_common.min(self.data) }

pub fn TimeseriesanomalyautoencoderRange::max(self : TimeseriesanomalyautoencoderRange) -> Double { @_common.max(self.data) }

pub fn TimeseriesanomalyautoencoderRange::to_string(self : TimeseriesanomalyautoencoderRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct TimeseriesanomalyautoencoderSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_anomaly_autoencoder_slice_make(size : Int) -> TimeseriesanomalyautoencoderSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn TimeseriesanomalyautoencoderSlice::len(self : TimeseriesanomalyautoencoderSlice) -> Int { self.size }

pub fn TimeseriesanomalyautoencoderSlice::get(self : TimeseriesanomalyautoencoderSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn TimeseriesanomalyautoencoderSlice::set(self : TimeseriesanomalyautoencoderSlice, i : Int, v : Double) -> TimeseriesanomalyautoencoderSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn TimeseriesanomalyautoencoderSlice::sum(self : TimeseriesanomalyautoencoderSlice) -> Double { @_common.sum(self.data) }

pub fn TimeseriesanomalyautoencoderSlice::mean(self : TimeseriesanomalyautoencoderSlice) -> Double { @_common.mean(self.data) }

pub fn TimeseriesanomalyautoencoderSlice::scale(self : TimeseriesanomalyautoencoderSlice, f : Double) -> TimeseriesanomalyautoencoderSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn TimeseriesanomalyautoencoderSlice::add(self : TimeseriesanomalyautoencoderSlice, other : TimeseriesanomalyautoencoderSlice) -> TimeseriesanomalyautoencoderSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn TimeseriesanomalyautoencoderSlice::copy(self : TimeseriesanomalyautoencoderSlice) -> TimeseriesanomalyautoencoderSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn TimeseriesanomalyautoencoderSlice::fill(self : TimeseriesanomalyautoencoderSlice, v : Double) -> TimeseriesanomalyautoencoderSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn TimeseriesanomalyautoencoderSlice::min(self : TimeseriesanomalyautoencoderSlice) -> Double { @_common.min(self.data) }

pub fn TimeseriesanomalyautoencoderSlice::max(self : TimeseriesanomalyautoencoderSlice) -> Double { @_common.max(self.data) }

pub fn TimeseriesanomalyautoencoderSlice::to_string(self : TimeseriesanomalyautoencoderSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

