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

pub fn timeseries_anomaly_autoencoder_frame_len(s : TimeseriesanomalyautoencoderFrame) -> Int { s.size }

pub fn timeseries_anomaly_autoencoder_frame_get(s : TimeseriesanomalyautoencoderFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_anomaly_autoencoder_frame_set(s : TimeseriesanomalyautoencoderFrame, i : Int, v : Double) -> TimeseriesanomalyautoencoderFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_autoencoder_frame_sum(s : TimeseriesanomalyautoencoderFrame) -> Double { @_common.sum(s.data) }

pub fn timeseries_anomaly_autoencoder_frame_mean(s : TimeseriesanomalyautoencoderFrame) -> Double { @_common.mean(s.data) }

pub fn timeseries_anomaly_autoencoder_frame_scale(s : TimeseriesanomalyautoencoderFrame, f : Double) -> TimeseriesanomalyautoencoderFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_autoencoder_frame_add(a : TimeseriesanomalyautoencoderFrame, b : TimeseriesanomalyautoencoderFrame) -> TimeseriesanomalyautoencoderFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_anomaly_autoencoder_frame_copy(s : TimeseriesanomalyautoencoderFrame) -> TimeseriesanomalyautoencoderFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_autoencoder_frame_fill(s : TimeseriesanomalyautoencoderFrame, v : Double) -> TimeseriesanomalyautoencoderFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_autoencoder_frame_min(s : TimeseriesanomalyautoencoderFrame) -> Double { @_common.min(s.data) }

pub fn timeseries_anomaly_autoencoder_frame_max(s : TimeseriesanomalyautoencoderFrame) -> Double { @_common.max(s.data) }

pub fn timeseries_anomaly_autoencoder_frame_to_string(s : TimeseriesanomalyautoencoderFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesanomalyautoencoderTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_anomaly_autoencoder_table_make(size : Int) -> TimeseriesanomalyautoencoderTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_anomaly_autoencoder_table_len(s : TimeseriesanomalyautoencoderTable) -> Int { s.size }

pub fn timeseries_anomaly_autoencoder_table_get(s : TimeseriesanomalyautoencoderTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_anomaly_autoencoder_table_set(s : TimeseriesanomalyautoencoderTable, i : Int, v : Double) -> TimeseriesanomalyautoencoderTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_autoencoder_table_sum(s : TimeseriesanomalyautoencoderTable) -> Double { @_common.sum(s.data) }

pub fn timeseries_anomaly_autoencoder_table_mean(s : TimeseriesanomalyautoencoderTable) -> Double { @_common.mean(s.data) }

pub fn timeseries_anomaly_autoencoder_table_scale(s : TimeseriesanomalyautoencoderTable, f : Double) -> TimeseriesanomalyautoencoderTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_autoencoder_table_add(a : TimeseriesanomalyautoencoderTable, b : TimeseriesanomalyautoencoderTable) -> TimeseriesanomalyautoencoderTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_anomaly_autoencoder_table_copy(s : TimeseriesanomalyautoencoderTable) -> TimeseriesanomalyautoencoderTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_autoencoder_table_fill(s : TimeseriesanomalyautoencoderTable, v : Double) -> TimeseriesanomalyautoencoderTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_autoencoder_table_min(s : TimeseriesanomalyautoencoderTable) -> Double { @_common.min(s.data) }

pub fn timeseries_anomaly_autoencoder_table_max(s : TimeseriesanomalyautoencoderTable) -> Double { @_common.max(s.data) }

pub fn timeseries_anomaly_autoencoder_table_to_string(s : TimeseriesanomalyautoencoderTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesanomalyautoencoderGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_anomaly_autoencoder_graphn_make(size : Int) -> TimeseriesanomalyautoencoderGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_anomaly_autoencoder_graphn_len(s : TimeseriesanomalyautoencoderGraphN) -> Int { s.size }

pub fn timeseries_anomaly_autoencoder_graphn_get(s : TimeseriesanomalyautoencoderGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_anomaly_autoencoder_graphn_set(s : TimeseriesanomalyautoencoderGraphN, i : Int, v : Double) -> TimeseriesanomalyautoencoderGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_autoencoder_graphn_sum(s : TimeseriesanomalyautoencoderGraphN) -> Double { @_common.sum(s.data) }

pub fn timeseries_anomaly_autoencoder_graphn_mean(s : TimeseriesanomalyautoencoderGraphN) -> Double { @_common.mean(s.data) }

pub fn timeseries_anomaly_autoencoder_graphn_scale(s : TimeseriesanomalyautoencoderGraphN, f : Double) -> TimeseriesanomalyautoencoderGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_autoencoder_graphn_add(a : TimeseriesanomalyautoencoderGraphN, b : TimeseriesanomalyautoencoderGraphN) -> TimeseriesanomalyautoencoderGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_anomaly_autoencoder_graphn_copy(s : TimeseriesanomalyautoencoderGraphN) -> TimeseriesanomalyautoencoderGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_autoencoder_graphn_fill(s : TimeseriesanomalyautoencoderGraphN, v : Double) -> TimeseriesanomalyautoencoderGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_autoencoder_graphn_min(s : TimeseriesanomalyautoencoderGraphN) -> Double { @_common.min(s.data) }

pub fn timeseries_anomaly_autoencoder_graphn_max(s : TimeseriesanomalyautoencoderGraphN) -> Double { @_common.max(s.data) }

pub fn timeseries_anomaly_autoencoder_graphn_to_string(s : TimeseriesanomalyautoencoderGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesanomalyautoencoderNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_anomaly_autoencoder_node_make(size : Int) -> TimeseriesanomalyautoencoderNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_anomaly_autoencoder_node_len(s : TimeseriesanomalyautoencoderNode) -> Int { s.size }

pub fn timeseries_anomaly_autoencoder_node_get(s : TimeseriesanomalyautoencoderNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_anomaly_autoencoder_node_set(s : TimeseriesanomalyautoencoderNode, i : Int, v : Double) -> TimeseriesanomalyautoencoderNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_autoencoder_node_sum(s : TimeseriesanomalyautoencoderNode) -> Double { @_common.sum(s.data) }

pub fn timeseries_anomaly_autoencoder_node_mean(s : TimeseriesanomalyautoencoderNode) -> Double { @_common.mean(s.data) }

pub fn timeseries_anomaly_autoencoder_node_scale(s : TimeseriesanomalyautoencoderNode, f : Double) -> TimeseriesanomalyautoencoderNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_autoencoder_node_add(a : TimeseriesanomalyautoencoderNode, b : TimeseriesanomalyautoencoderNode) -> TimeseriesanomalyautoencoderNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_anomaly_autoencoder_node_copy(s : TimeseriesanomalyautoencoderNode) -> TimeseriesanomalyautoencoderNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_autoencoder_node_fill(s : TimeseriesanomalyautoencoderNode, v : Double) -> TimeseriesanomalyautoencoderNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_autoencoder_node_min(s : TimeseriesanomalyautoencoderNode) -> Double { @_common.min(s.data) }

pub fn timeseries_anomaly_autoencoder_node_max(s : TimeseriesanomalyautoencoderNode) -> Double { @_common.max(s.data) }

pub fn timeseries_anomaly_autoencoder_node_to_string(s : TimeseriesanomalyautoencoderNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesanomalyautoencoderEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_anomaly_autoencoder_edge_make(size : Int) -> TimeseriesanomalyautoencoderEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_anomaly_autoencoder_edge_len(s : TimeseriesanomalyautoencoderEdge) -> Int { s.size }

pub fn timeseries_anomaly_autoencoder_edge_get(s : TimeseriesanomalyautoencoderEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_anomaly_autoencoder_edge_set(s : TimeseriesanomalyautoencoderEdge, i : Int, v : Double) -> TimeseriesanomalyautoencoderEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_autoencoder_edge_sum(s : TimeseriesanomalyautoencoderEdge) -> Double { @_common.sum(s.data) }

pub fn timeseries_anomaly_autoencoder_edge_mean(s : TimeseriesanomalyautoencoderEdge) -> Double { @_common.mean(s.data) }

pub fn timeseries_anomaly_autoencoder_edge_scale(s : TimeseriesanomalyautoencoderEdge, f : Double) -> TimeseriesanomalyautoencoderEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_autoencoder_edge_add(a : TimeseriesanomalyautoencoderEdge, b : TimeseriesanomalyautoencoderEdge) -> TimeseriesanomalyautoencoderEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_anomaly_autoencoder_edge_copy(s : TimeseriesanomalyautoencoderEdge) -> TimeseriesanomalyautoencoderEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_autoencoder_edge_fill(s : TimeseriesanomalyautoencoderEdge, v : Double) -> TimeseriesanomalyautoencoderEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_autoencoder_edge_min(s : TimeseriesanomalyautoencoderEdge) -> Double { @_common.min(s.data) }

pub fn timeseries_anomaly_autoencoder_edge_max(s : TimeseriesanomalyautoencoderEdge) -> Double { @_common.max(s.data) }

pub fn timeseries_anomaly_autoencoder_edge_to_string(s : TimeseriesanomalyautoencoderEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesanomalyautoencoderPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_anomaly_autoencoder_path_make(size : Int) -> TimeseriesanomalyautoencoderPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_anomaly_autoencoder_path_len(s : TimeseriesanomalyautoencoderPath) -> Int { s.size }

pub fn timeseries_anomaly_autoencoder_path_get(s : TimeseriesanomalyautoencoderPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_anomaly_autoencoder_path_set(s : TimeseriesanomalyautoencoderPath, i : Int, v : Double) -> TimeseriesanomalyautoencoderPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_autoencoder_path_sum(s : TimeseriesanomalyautoencoderPath) -> Double { @_common.sum(s.data) }

pub fn timeseries_anomaly_autoencoder_path_mean(s : TimeseriesanomalyautoencoderPath) -> Double { @_common.mean(s.data) }

pub fn timeseries_anomaly_autoencoder_path_scale(s : TimeseriesanomalyautoencoderPath, f : Double) -> TimeseriesanomalyautoencoderPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_autoencoder_path_add(a : TimeseriesanomalyautoencoderPath, b : TimeseriesanomalyautoencoderPath) -> TimeseriesanomalyautoencoderPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_anomaly_autoencoder_path_copy(s : TimeseriesanomalyautoencoderPath) -> TimeseriesanomalyautoencoderPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_autoencoder_path_fill(s : TimeseriesanomalyautoencoderPath, v : Double) -> TimeseriesanomalyautoencoderPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_autoencoder_path_min(s : TimeseriesanomalyautoencoderPath) -> Double { @_common.min(s.data) }

pub fn timeseries_anomaly_autoencoder_path_max(s : TimeseriesanomalyautoencoderPath) -> Double { @_common.max(s.data) }

pub fn timeseries_anomaly_autoencoder_path_to_string(s : TimeseriesanomalyautoencoderPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesanomalyautoencoderCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_anomaly_autoencoder_cluster_make(size : Int) -> TimeseriesanomalyautoencoderCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_anomaly_autoencoder_cluster_len(s : TimeseriesanomalyautoencoderCluster) -> Int { s.size }

pub fn timeseries_anomaly_autoencoder_cluster_get(s : TimeseriesanomalyautoencoderCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_anomaly_autoencoder_cluster_set(s : TimeseriesanomalyautoencoderCluster, i : Int, v : Double) -> TimeseriesanomalyautoencoderCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_autoencoder_cluster_sum(s : TimeseriesanomalyautoencoderCluster) -> Double { @_common.sum(s.data) }

pub fn timeseries_anomaly_autoencoder_cluster_mean(s : TimeseriesanomalyautoencoderCluster) -> Double { @_common.mean(s.data) }

pub fn timeseries_anomaly_autoencoder_cluster_scale(s : TimeseriesanomalyautoencoderCluster, f : Double) -> TimeseriesanomalyautoencoderCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_autoencoder_cluster_add(a : TimeseriesanomalyautoencoderCluster, b : TimeseriesanomalyautoencoderCluster) -> TimeseriesanomalyautoencoderCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_anomaly_autoencoder_cluster_copy(s : TimeseriesanomalyautoencoderCluster) -> TimeseriesanomalyautoencoderCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_autoencoder_cluster_fill(s : TimeseriesanomalyautoencoderCluster, v : Double) -> TimeseriesanomalyautoencoderCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_autoencoder_cluster_min(s : TimeseriesanomalyautoencoderCluster) -> Double { @_common.min(s.data) }

pub fn timeseries_anomaly_autoencoder_cluster_max(s : TimeseriesanomalyautoencoderCluster) -> Double { @_common.max(s.data) }

pub fn timeseries_anomaly_autoencoder_cluster_to_string(s : TimeseriesanomalyautoencoderCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesanomalyautoencoderModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_anomaly_autoencoder_model_make(size : Int) -> TimeseriesanomalyautoencoderModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_anomaly_autoencoder_model_len(s : TimeseriesanomalyautoencoderModel) -> Int { s.size }

pub fn timeseries_anomaly_autoencoder_model_get(s : TimeseriesanomalyautoencoderModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_anomaly_autoencoder_model_set(s : TimeseriesanomalyautoencoderModel, i : Int, v : Double) -> TimeseriesanomalyautoencoderModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_autoencoder_model_sum(s : TimeseriesanomalyautoencoderModel) -> Double { @_common.sum(s.data) }

pub fn timeseries_anomaly_autoencoder_model_mean(s : TimeseriesanomalyautoencoderModel) -> Double { @_common.mean(s.data) }

pub fn timeseries_anomaly_autoencoder_model_scale(s : TimeseriesanomalyautoencoderModel, f : Double) -> TimeseriesanomalyautoencoderModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_autoencoder_model_add(a : TimeseriesanomalyautoencoderModel, b : TimeseriesanomalyautoencoderModel) -> TimeseriesanomalyautoencoderModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_anomaly_autoencoder_model_copy(s : TimeseriesanomalyautoencoderModel) -> TimeseriesanomalyautoencoderModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_autoencoder_model_fill(s : TimeseriesanomalyautoencoderModel, v : Double) -> TimeseriesanomalyautoencoderModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_autoencoder_model_min(s : TimeseriesanomalyautoencoderModel) -> Double { @_common.min(s.data) }

pub fn timeseries_anomaly_autoencoder_model_max(s : TimeseriesanomalyautoencoderModel) -> Double { @_common.max(s.data) }

pub fn timeseries_anomaly_autoencoder_model_to_string(s : TimeseriesanomalyautoencoderModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesanomalyautoencoderLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_anomaly_autoencoder_layer_make(size : Int) -> TimeseriesanomalyautoencoderLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_anomaly_autoencoder_layer_len(s : TimeseriesanomalyautoencoderLayer) -> Int { s.size }

pub fn timeseries_anomaly_autoencoder_layer_get(s : TimeseriesanomalyautoencoderLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_anomaly_autoencoder_layer_set(s : TimeseriesanomalyautoencoderLayer, i : Int, v : Double) -> TimeseriesanomalyautoencoderLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_autoencoder_layer_sum(s : TimeseriesanomalyautoencoderLayer) -> Double { @_common.sum(s.data) }

pub fn timeseries_anomaly_autoencoder_layer_mean(s : TimeseriesanomalyautoencoderLayer) -> Double { @_common.mean(s.data) }

pub fn timeseries_anomaly_autoencoder_layer_scale(s : TimeseriesanomalyautoencoderLayer, f : Double) -> TimeseriesanomalyautoencoderLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_autoencoder_layer_add(a : TimeseriesanomalyautoencoderLayer, b : TimeseriesanomalyautoencoderLayer) -> TimeseriesanomalyautoencoderLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_anomaly_autoencoder_layer_copy(s : TimeseriesanomalyautoencoderLayer) -> TimeseriesanomalyautoencoderLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_autoencoder_layer_fill(s : TimeseriesanomalyautoencoderLayer, v : Double) -> TimeseriesanomalyautoencoderLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_autoencoder_layer_min(s : TimeseriesanomalyautoencoderLayer) -> Double { @_common.min(s.data) }

pub fn timeseries_anomaly_autoencoder_layer_max(s : TimeseriesanomalyautoencoderLayer) -> Double { @_common.max(s.data) }

pub fn timeseries_anomaly_autoencoder_layer_to_string(s : TimeseriesanomalyautoencoderLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesanomalyautoencoderBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_anomaly_autoencoder_buffer_make(size : Int) -> TimeseriesanomalyautoencoderBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_anomaly_autoencoder_buffer_len(s : TimeseriesanomalyautoencoderBuffer) -> Int { s.size }

pub fn timeseries_anomaly_autoencoder_buffer_get(s : TimeseriesanomalyautoencoderBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_anomaly_autoencoder_buffer_set(s : TimeseriesanomalyautoencoderBuffer, i : Int, v : Double) -> TimeseriesanomalyautoencoderBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_autoencoder_buffer_sum(s : TimeseriesanomalyautoencoderBuffer) -> Double { @_common.sum(s.data) }

pub fn timeseries_anomaly_autoencoder_buffer_mean(s : TimeseriesanomalyautoencoderBuffer) -> Double { @_common.mean(s.data) }

pub fn timeseries_anomaly_autoencoder_buffer_scale(s : TimeseriesanomalyautoencoderBuffer, f : Double) -> TimeseriesanomalyautoencoderBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_autoencoder_buffer_add(a : TimeseriesanomalyautoencoderBuffer, b : TimeseriesanomalyautoencoderBuffer) -> TimeseriesanomalyautoencoderBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_anomaly_autoencoder_buffer_copy(s : TimeseriesanomalyautoencoderBuffer) -> TimeseriesanomalyautoencoderBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_autoencoder_buffer_fill(s : TimeseriesanomalyautoencoderBuffer, v : Double) -> TimeseriesanomalyautoencoderBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_autoencoder_buffer_min(s : TimeseriesanomalyautoencoderBuffer) -> Double { @_common.min(s.data) }

pub fn timeseries_anomaly_autoencoder_buffer_max(s : TimeseriesanomalyautoencoderBuffer) -> Double { @_common.max(s.data) }

pub fn timeseries_anomaly_autoencoder_buffer_to_string(s : TimeseriesanomalyautoencoderBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesanomalyautoencoderCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_anomaly_autoencoder_cursor_make(size : Int) -> TimeseriesanomalyautoencoderCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_anomaly_autoencoder_cursor_len(s : TimeseriesanomalyautoencoderCursor) -> Int { s.size }

pub fn timeseries_anomaly_autoencoder_cursor_get(s : TimeseriesanomalyautoencoderCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_anomaly_autoencoder_cursor_set(s : TimeseriesanomalyautoencoderCursor, i : Int, v : Double) -> TimeseriesanomalyautoencoderCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_autoencoder_cursor_sum(s : TimeseriesanomalyautoencoderCursor) -> Double { @_common.sum(s.data) }

pub fn timeseries_anomaly_autoencoder_cursor_mean(s : TimeseriesanomalyautoencoderCursor) -> Double { @_common.mean(s.data) }

pub fn timeseries_anomaly_autoencoder_cursor_scale(s : TimeseriesanomalyautoencoderCursor, f : Double) -> TimeseriesanomalyautoencoderCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_autoencoder_cursor_add(a : TimeseriesanomalyautoencoderCursor, b : TimeseriesanomalyautoencoderCursor) -> TimeseriesanomalyautoencoderCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_anomaly_autoencoder_cursor_copy(s : TimeseriesanomalyautoencoderCursor) -> TimeseriesanomalyautoencoderCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_autoencoder_cursor_fill(s : TimeseriesanomalyautoencoderCursor, v : Double) -> TimeseriesanomalyautoencoderCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_autoencoder_cursor_min(s : TimeseriesanomalyautoencoderCursor) -> Double { @_common.min(s.data) }

pub fn timeseries_anomaly_autoencoder_cursor_max(s : TimeseriesanomalyautoencoderCursor) -> Double { @_common.max(s.data) }

pub fn timeseries_anomaly_autoencoder_cursor_to_string(s : TimeseriesanomalyautoencoderCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesanomalyautoencoderView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_anomaly_autoencoder_view_make(size : Int) -> TimeseriesanomalyautoencoderView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_anomaly_autoencoder_view_len(s : TimeseriesanomalyautoencoderView) -> Int { s.size }

pub fn timeseries_anomaly_autoencoder_view_get(s : TimeseriesanomalyautoencoderView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_anomaly_autoencoder_view_set(s : TimeseriesanomalyautoencoderView, i : Int, v : Double) -> TimeseriesanomalyautoencoderView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_autoencoder_view_sum(s : TimeseriesanomalyautoencoderView) -> Double { @_common.sum(s.data) }

pub fn timeseries_anomaly_autoencoder_view_mean(s : TimeseriesanomalyautoencoderView) -> Double { @_common.mean(s.data) }

pub fn timeseries_anomaly_autoencoder_view_scale(s : TimeseriesanomalyautoencoderView, f : Double) -> TimeseriesanomalyautoencoderView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_autoencoder_view_add(a : TimeseriesanomalyautoencoderView, b : TimeseriesanomalyautoencoderView) -> TimeseriesanomalyautoencoderView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_anomaly_autoencoder_view_copy(s : TimeseriesanomalyautoencoderView) -> TimeseriesanomalyautoencoderView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_autoencoder_view_fill(s : TimeseriesanomalyautoencoderView, v : Double) -> TimeseriesanomalyautoencoderView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_autoencoder_view_min(s : TimeseriesanomalyautoencoderView) -> Double { @_common.min(s.data) }

pub fn timeseries_anomaly_autoencoder_view_max(s : TimeseriesanomalyautoencoderView) -> Double { @_common.max(s.data) }

pub fn timeseries_anomaly_autoencoder_view_to_string(s : TimeseriesanomalyautoencoderView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesanomalyautoencoderRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_anomaly_autoencoder_range_make(size : Int) -> TimeseriesanomalyautoencoderRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_anomaly_autoencoder_range_len(s : TimeseriesanomalyautoencoderRange) -> Int { s.size }

pub fn timeseries_anomaly_autoencoder_range_get(s : TimeseriesanomalyautoencoderRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_anomaly_autoencoder_range_set(s : TimeseriesanomalyautoencoderRange, i : Int, v : Double) -> TimeseriesanomalyautoencoderRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_autoencoder_range_sum(s : TimeseriesanomalyautoencoderRange) -> Double { @_common.sum(s.data) }

pub fn timeseries_anomaly_autoencoder_range_mean(s : TimeseriesanomalyautoencoderRange) -> Double { @_common.mean(s.data) }

pub fn timeseries_anomaly_autoencoder_range_scale(s : TimeseriesanomalyautoencoderRange, f : Double) -> TimeseriesanomalyautoencoderRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_autoencoder_range_add(a : TimeseriesanomalyautoencoderRange, b : TimeseriesanomalyautoencoderRange) -> TimeseriesanomalyautoencoderRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_anomaly_autoencoder_range_copy(s : TimeseriesanomalyautoencoderRange) -> TimeseriesanomalyautoencoderRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_autoencoder_range_fill(s : TimeseriesanomalyautoencoderRange, v : Double) -> TimeseriesanomalyautoencoderRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_autoencoder_range_min(s : TimeseriesanomalyautoencoderRange) -> Double { @_common.min(s.data) }

pub fn timeseries_anomaly_autoencoder_range_max(s : TimeseriesanomalyautoencoderRange) -> Double { @_common.max(s.data) }

pub fn timeseries_anomaly_autoencoder_range_to_string(s : TimeseriesanomalyautoencoderRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesanomalyautoencoderSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_anomaly_autoencoder_slice_make(size : Int) -> TimeseriesanomalyautoencoderSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_anomaly_autoencoder_slice_len(s : TimeseriesanomalyautoencoderSlice) -> Int { s.size }

pub fn timeseries_anomaly_autoencoder_slice_get(s : TimeseriesanomalyautoencoderSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_anomaly_autoencoder_slice_set(s : TimeseriesanomalyautoencoderSlice, i : Int, v : Double) -> TimeseriesanomalyautoencoderSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_autoencoder_slice_sum(s : TimeseriesanomalyautoencoderSlice) -> Double { @_common.sum(s.data) }

pub fn timeseries_anomaly_autoencoder_slice_mean(s : TimeseriesanomalyautoencoderSlice) -> Double { @_common.mean(s.data) }

pub fn timeseries_anomaly_autoencoder_slice_scale(s : TimeseriesanomalyautoencoderSlice, f : Double) -> TimeseriesanomalyautoencoderSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_autoencoder_slice_add(a : TimeseriesanomalyautoencoderSlice, b : TimeseriesanomalyautoencoderSlice) -> TimeseriesanomalyautoencoderSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_anomaly_autoencoder_slice_copy(s : TimeseriesanomalyautoencoderSlice) -> TimeseriesanomalyautoencoderSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_autoencoder_slice_fill(s : TimeseriesanomalyautoencoderSlice, v : Double) -> TimeseriesanomalyautoencoderSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_anomaly_autoencoder_slice_min(s : TimeseriesanomalyautoencoderSlice) -> Double { @_common.min(s.data) }

pub fn timeseries_anomaly_autoencoder_slice_max(s : TimeseriesanomalyautoencoderSlice) -> Double { @_common.max(s.data) }

pub fn timeseries_anomaly_autoencoder_slice_to_string(s : TimeseriesanomalyautoencoderSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

