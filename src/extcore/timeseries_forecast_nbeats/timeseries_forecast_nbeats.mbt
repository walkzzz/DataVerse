///===
/// extcore/timeseries_forecast_nbeats

pub(all) struct TimeseriesforecastnbeatsPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn timeseries_forecast_nbeats_make_point(x : Double, y : Double) -> TimeseriesforecastnbeatsPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn timeseries_forecast_nbeats_make_point3(x : Double, y : Double, z : Double) -> TimeseriesforecastnbeatsPoint {
  { x, y, z, label: 0 }
}

pub fn TimeseriesforecastnbeatsPoint::x(self : TimeseriesforecastnbeatsPoint) -> Double { self.x }

pub fn TimeseriesforecastnbeatsPoint::y(self : TimeseriesforecastnbeatsPoint) -> Double { self.y }

pub fn TimeseriesforecastnbeatsPoint::z(self : TimeseriesforecastnbeatsPoint) -> Double { self.z }

pub fn TimeseriesforecastnbeatsPoint::label(self : TimeseriesforecastnbeatsPoint) -> Int { self.label }

pub fn TimeseriesforecastnbeatsPoint::dist(self : TimeseriesforecastnbeatsPoint, other : TimeseriesforecastnbeatsPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn TimeseriesforecastnbeatsPoint::add(self : TimeseriesforecastnbeatsPoint, other : TimeseriesforecastnbeatsPoint) -> TimeseriesforecastnbeatsPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn TimeseriesforecastnbeatsPoint::sub(self : TimeseriesforecastnbeatsPoint, other : TimeseriesforecastnbeatsPoint) -> TimeseriesforecastnbeatsPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn TimeseriesforecastnbeatsPoint::scale(self : TimeseriesforecastnbeatsPoint, s : Double) -> TimeseriesforecastnbeatsPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn TimeseriesforecastnbeatsPoint::dot(self : TimeseriesforecastnbeatsPoint, other : TimeseriesforecastnbeatsPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn TimeseriesforecastnbeatsPoint::cross(self : TimeseriesforecastnbeatsPoint, other : TimeseriesforecastnbeatsPoint) -> TimeseriesforecastnbeatsPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn TimeseriesforecastnbeatsPoint::norm(self : TimeseriesforecastnbeatsPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn TimeseriesforecastnbeatsPoint::normalize(self : TimeseriesforecastnbeatsPoint) -> TimeseriesforecastnbeatsPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn TimeseriesforecastnbeatsPoint::negate(self : TimeseriesforecastnbeatsPoint) -> TimeseriesforecastnbeatsPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn TimeseriesforecastnbeatsPoint::mid(self : TimeseriesforecastnbeatsPoint, other : TimeseriesforecastnbeatsPoint) -> TimeseriesforecastnbeatsPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn TimeseriesforecastnbeatsPoint::lerp(self : TimeseriesforecastnbeatsPoint, other : TimeseriesforecastnbeatsPoint, t : Double) -> TimeseriesforecastnbeatsPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn TimeseriesforecastnbeatsPoint::to_string(self : TimeseriesforecastnbeatsPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct TimeseriesforecastnbeatsSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn timeseries_forecast_nbeats_make_series(vals : Array[Double], name : String) -> TimeseriesforecastnbeatsSeries {
  { vals, name, meta: 0 }
}

pub fn TimeseriesforecastnbeatsSeries::len(self : TimeseriesforecastnbeatsSeries) -> Int { self.vals.length() }

pub fn TimeseriesforecastnbeatsSeries::sum(self : TimeseriesforecastnbeatsSeries) -> Double { @_common.sum(self.vals) }

pub fn TimeseriesforecastnbeatsSeries::mean(self : TimeseriesforecastnbeatsSeries) -> Double { @_common.mean(self.vals) }

pub fn TimeseriesforecastnbeatsSeries::min(self : TimeseriesforecastnbeatsSeries) -> Double { @_common.min(self.vals) }

pub fn TimeseriesforecastnbeatsSeries::max(self : TimeseriesforecastnbeatsSeries) -> Double { @_common.max(self.vals) }

pub fn TimeseriesforecastnbeatsSeries::range(self : TimeseriesforecastnbeatsSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn TimeseriesforecastnbeatsSeries::variance(self : TimeseriesforecastnbeatsSeries) -> Double { @_common.variance(self.vals) }

pub fn TimeseriesforecastnbeatsSeries::std(self : TimeseriesforecastnbeatsSeries) -> Double { @_common.std(self.vals) }

pub fn TimeseriesforecastnbeatsSeries::median(self : TimeseriesforecastnbeatsSeries) -> Double { @_common.median(self.vals) }

pub fn TimeseriesforecastnbeatsSeries::scale(self : TimeseriesforecastnbeatsSeries, f : Double) -> TimeseriesforecastnbeatsSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn TimeseriesforecastnbeatsSeries::add(self : TimeseriesforecastnbeatsSeries, other : TimeseriesforecastnbeatsSeries) -> TimeseriesforecastnbeatsSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn TimeseriesforecastnbeatsSeries::sub(self : TimeseriesforecastnbeatsSeries, other : TimeseriesforecastnbeatsSeries) -> TimeseriesforecastnbeatsSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn TimeseriesforecastnbeatsSeries::normalize(self : TimeseriesforecastnbeatsSeries) -> TimeseriesforecastnbeatsSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn TimeseriesforecastnbeatsSeries::cumsum(self : TimeseriesforecastnbeatsSeries) -> TimeseriesforecastnbeatsSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn TimeseriesforecastnbeatsSeries::to_string(self : TimeseriesforecastnbeatsSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct TimeseriesforecastnbeatsMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn timeseries_forecast_nbeats_make_matrix(rows : Int, cols : Int, val : Double) -> TimeseriesforecastnbeatsMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn timeseries_forecast_nbeats_matrix_identity(n : Int) -> TimeseriesforecastnbeatsMatrix {
  let m = timeseries_forecast_nbeats_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn TimeseriesforecastnbeatsMatrix::get(self : TimeseriesforecastnbeatsMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn TimeseriesforecastnbeatsMatrix::transpose(self : TimeseriesforecastnbeatsMatrix) -> TimeseriesforecastnbeatsMatrix {
  let result = timeseries_forecast_nbeats_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn TimeseriesforecastnbeatsMatrix::add(self : TimeseriesforecastnbeatsMatrix, other : TimeseriesforecastnbeatsMatrix) -> TimeseriesforecastnbeatsMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = timeseries_forecast_nbeats_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn TimeseriesforecastnbeatsMatrix::scale(self : TimeseriesforecastnbeatsMatrix, s : Double) -> TimeseriesforecastnbeatsMatrix {
  let result = timeseries_forecast_nbeats_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn TimeseriesforecastnbeatsMatrix::multiply(self : TimeseriesforecastnbeatsMatrix, other : TimeseriesforecastnbeatsMatrix) -> TimeseriesforecastnbeatsMatrix {
  if self.cols != other.rows { return timeseries_forecast_nbeats_make_matrix(self.rows, other.cols, 0.0) }
  let result = timeseries_forecast_nbeats_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn TimeseriesforecastnbeatsMatrix::trace(self : TimeseriesforecastnbeatsMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn TimeseriesforecastnbeatsMatrix::det(self : TimeseriesforecastnbeatsMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn TimeseriesforecastnbeatsMatrix::norm(self : TimeseriesforecastnbeatsMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn TimeseriesforecastnbeatsMatrix::to_string(self : TimeseriesforecastnbeatsMatrix) -> String {
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

pub(all) struct TimeseriesforecastnbeatsVector {
  comps : Array[Double]
  dim : Int
}

pub fn timeseries_forecast_nbeats_make_vector(comps : Array[Double]) -> TimeseriesforecastnbeatsVector {
  { comps, dim: comps.length() }
}

pub fn timeseries_forecast_nbeats_vector_zero(dim : Int) -> TimeseriesforecastnbeatsVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn TimeseriesforecastnbeatsVector::add(self : TimeseriesforecastnbeatsVector, other : TimeseriesforecastnbeatsVector) -> TimeseriesforecastnbeatsVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn TimeseriesforecastnbeatsVector::sub(self : TimeseriesforecastnbeatsVector, other : TimeseriesforecastnbeatsVector) -> TimeseriesforecastnbeatsVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn TimeseriesforecastnbeatsVector::scale(self : TimeseriesforecastnbeatsVector, s : Double) -> TimeseriesforecastnbeatsVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn TimeseriesforecastnbeatsVector::dot(self : TimeseriesforecastnbeatsVector, other : TimeseriesforecastnbeatsVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn TimeseriesforecastnbeatsVector::norm(self : TimeseriesforecastnbeatsVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn TimeseriesforecastnbeatsVector::normalize(self : TimeseriesforecastnbeatsVector) -> TimeseriesforecastnbeatsVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn TimeseriesforecastnbeatsVector::dist(self : TimeseriesforecastnbeatsVector, other : TimeseriesforecastnbeatsVector) -> Double {
  self.sub(other).norm()
}

pub fn TimeseriesforecastnbeatsVector::to_string(self : TimeseriesforecastnbeatsVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn timeseries_forecast_nbeats_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn timeseries_forecast_nbeats_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn timeseries_forecast_nbeats_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn timeseries_forecast_nbeats_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn timeseries_forecast_nbeats_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn timeseries_forecast_nbeats_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn timeseries_forecast_nbeats_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn timeseries_forecast_nbeats_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn timeseries_forecast_nbeats_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn timeseries_forecast_nbeats_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn timeseries_forecast_nbeats_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn timeseries_forecast_nbeats_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn timeseries_forecast_nbeats_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn timeseries_forecast_nbeats_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn timeseries_forecast_nbeats_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn timeseries_forecast_nbeats_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn timeseries_forecast_nbeats_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn timeseries_forecast_nbeats_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn timeseries_forecast_nbeats_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn timeseries_forecast_nbeats_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn timeseries_forecast_nbeats_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn timeseries_forecast_nbeats_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn timeseries_forecast_nbeats_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn timeseries_forecast_nbeats_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn timeseries_forecast_nbeats_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn timeseries_forecast_nbeats_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn timeseries_forecast_nbeats_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn timeseries_forecast_nbeats_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn timeseries_forecast_nbeats_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct TimeseriesforecastnbeatsFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_forecast_nbeats_frame_make(size : Int) -> TimeseriesforecastnbeatsFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn TimeseriesforecastnbeatsFrame::len(self : TimeseriesforecastnbeatsFrame) -> Int { self.size }

pub fn TimeseriesforecastnbeatsFrame::get(self : TimeseriesforecastnbeatsFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn TimeseriesforecastnbeatsFrame::set(self : TimeseriesforecastnbeatsFrame, i : Int, v : Double) -> TimeseriesforecastnbeatsFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn TimeseriesforecastnbeatsFrame::sum(self : TimeseriesforecastnbeatsFrame) -> Double { @_common.sum(self.data) }

pub fn TimeseriesforecastnbeatsFrame::mean(self : TimeseriesforecastnbeatsFrame) -> Double { @_common.mean(self.data) }

pub fn TimeseriesforecastnbeatsFrame::scale(self : TimeseriesforecastnbeatsFrame, f : Double) -> TimeseriesforecastnbeatsFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn TimeseriesforecastnbeatsFrame::add(self : TimeseriesforecastnbeatsFrame, other : TimeseriesforecastnbeatsFrame) -> TimeseriesforecastnbeatsFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn TimeseriesforecastnbeatsFrame::copy(self : TimeseriesforecastnbeatsFrame) -> TimeseriesforecastnbeatsFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn TimeseriesforecastnbeatsFrame::fill(self : TimeseriesforecastnbeatsFrame, v : Double) -> TimeseriesforecastnbeatsFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn TimeseriesforecastnbeatsFrame::min(self : TimeseriesforecastnbeatsFrame) -> Double { @_common.min(self.data) }

pub fn TimeseriesforecastnbeatsFrame::max(self : TimeseriesforecastnbeatsFrame) -> Double { @_common.max(self.data) }

pub fn TimeseriesforecastnbeatsFrame::to_string(self : TimeseriesforecastnbeatsFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct TimeseriesforecastnbeatsTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_forecast_nbeats_table_make(size : Int) -> TimeseriesforecastnbeatsTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn TimeseriesforecastnbeatsTable::len(self : TimeseriesforecastnbeatsTable) -> Int { self.size }

pub fn TimeseriesforecastnbeatsTable::get(self : TimeseriesforecastnbeatsTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn TimeseriesforecastnbeatsTable::set(self : TimeseriesforecastnbeatsTable, i : Int, v : Double) -> TimeseriesforecastnbeatsTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn TimeseriesforecastnbeatsTable::sum(self : TimeseriesforecastnbeatsTable) -> Double { @_common.sum(self.data) }

pub fn TimeseriesforecastnbeatsTable::mean(self : TimeseriesforecastnbeatsTable) -> Double { @_common.mean(self.data) }

pub fn TimeseriesforecastnbeatsTable::scale(self : TimeseriesforecastnbeatsTable, f : Double) -> TimeseriesforecastnbeatsTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn TimeseriesforecastnbeatsTable::add(self : TimeseriesforecastnbeatsTable, other : TimeseriesforecastnbeatsTable) -> TimeseriesforecastnbeatsTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn TimeseriesforecastnbeatsTable::copy(self : TimeseriesforecastnbeatsTable) -> TimeseriesforecastnbeatsTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn TimeseriesforecastnbeatsTable::fill(self : TimeseriesforecastnbeatsTable, v : Double) -> TimeseriesforecastnbeatsTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn TimeseriesforecastnbeatsTable::min(self : TimeseriesforecastnbeatsTable) -> Double { @_common.min(self.data) }

pub fn TimeseriesforecastnbeatsTable::max(self : TimeseriesforecastnbeatsTable) -> Double { @_common.max(self.data) }

pub fn TimeseriesforecastnbeatsTable::to_string(self : TimeseriesforecastnbeatsTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct TimeseriesforecastnbeatsGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_forecast_nbeats_graphn_make(size : Int) -> TimeseriesforecastnbeatsGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn TimeseriesforecastnbeatsGraphN::len(self : TimeseriesforecastnbeatsGraphN) -> Int { self.size }

pub fn TimeseriesforecastnbeatsGraphN::get(self : TimeseriesforecastnbeatsGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn TimeseriesforecastnbeatsGraphN::set(self : TimeseriesforecastnbeatsGraphN, i : Int, v : Double) -> TimeseriesforecastnbeatsGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn TimeseriesforecastnbeatsGraphN::sum(self : TimeseriesforecastnbeatsGraphN) -> Double { @_common.sum(self.data) }

pub fn TimeseriesforecastnbeatsGraphN::mean(self : TimeseriesforecastnbeatsGraphN) -> Double { @_common.mean(self.data) }

pub fn TimeseriesforecastnbeatsGraphN::scale(self : TimeseriesforecastnbeatsGraphN, f : Double) -> TimeseriesforecastnbeatsGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn TimeseriesforecastnbeatsGraphN::add(self : TimeseriesforecastnbeatsGraphN, other : TimeseriesforecastnbeatsGraphN) -> TimeseriesforecastnbeatsGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn TimeseriesforecastnbeatsGraphN::copy(self : TimeseriesforecastnbeatsGraphN) -> TimeseriesforecastnbeatsGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn TimeseriesforecastnbeatsGraphN::fill(self : TimeseriesforecastnbeatsGraphN, v : Double) -> TimeseriesforecastnbeatsGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn TimeseriesforecastnbeatsGraphN::min(self : TimeseriesforecastnbeatsGraphN) -> Double { @_common.min(self.data) }

pub fn TimeseriesforecastnbeatsGraphN::max(self : TimeseriesforecastnbeatsGraphN) -> Double { @_common.max(self.data) }

pub fn TimeseriesforecastnbeatsGraphN::to_string(self : TimeseriesforecastnbeatsGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct TimeseriesforecastnbeatsNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_forecast_nbeats_node_make(size : Int) -> TimeseriesforecastnbeatsNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn TimeseriesforecastnbeatsNode::len(self : TimeseriesforecastnbeatsNode) -> Int { self.size }

pub fn TimeseriesforecastnbeatsNode::get(self : TimeseriesforecastnbeatsNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn TimeseriesforecastnbeatsNode::set(self : TimeseriesforecastnbeatsNode, i : Int, v : Double) -> TimeseriesforecastnbeatsNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn TimeseriesforecastnbeatsNode::sum(self : TimeseriesforecastnbeatsNode) -> Double { @_common.sum(self.data) }

pub fn TimeseriesforecastnbeatsNode::mean(self : TimeseriesforecastnbeatsNode) -> Double { @_common.mean(self.data) }

pub fn TimeseriesforecastnbeatsNode::scale(self : TimeseriesforecastnbeatsNode, f : Double) -> TimeseriesforecastnbeatsNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn TimeseriesforecastnbeatsNode::add(self : TimeseriesforecastnbeatsNode, other : TimeseriesforecastnbeatsNode) -> TimeseriesforecastnbeatsNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn TimeseriesforecastnbeatsNode::copy(self : TimeseriesforecastnbeatsNode) -> TimeseriesforecastnbeatsNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn TimeseriesforecastnbeatsNode::fill(self : TimeseriesforecastnbeatsNode, v : Double) -> TimeseriesforecastnbeatsNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn TimeseriesforecastnbeatsNode::min(self : TimeseriesforecastnbeatsNode) -> Double { @_common.min(self.data) }

pub fn TimeseriesforecastnbeatsNode::max(self : TimeseriesforecastnbeatsNode) -> Double { @_common.max(self.data) }

pub fn TimeseriesforecastnbeatsNode::to_string(self : TimeseriesforecastnbeatsNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct TimeseriesforecastnbeatsEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_forecast_nbeats_edge_make(size : Int) -> TimeseriesforecastnbeatsEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn TimeseriesforecastnbeatsEdge::len(self : TimeseriesforecastnbeatsEdge) -> Int { self.size }

pub fn TimeseriesforecastnbeatsEdge::get(self : TimeseriesforecastnbeatsEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn TimeseriesforecastnbeatsEdge::set(self : TimeseriesforecastnbeatsEdge, i : Int, v : Double) -> TimeseriesforecastnbeatsEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn TimeseriesforecastnbeatsEdge::sum(self : TimeseriesforecastnbeatsEdge) -> Double { @_common.sum(self.data) }

pub fn TimeseriesforecastnbeatsEdge::mean(self : TimeseriesforecastnbeatsEdge) -> Double { @_common.mean(self.data) }

pub fn TimeseriesforecastnbeatsEdge::scale(self : TimeseriesforecastnbeatsEdge, f : Double) -> TimeseriesforecastnbeatsEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn TimeseriesforecastnbeatsEdge::add(self : TimeseriesforecastnbeatsEdge, other : TimeseriesforecastnbeatsEdge) -> TimeseriesforecastnbeatsEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn TimeseriesforecastnbeatsEdge::copy(self : TimeseriesforecastnbeatsEdge) -> TimeseriesforecastnbeatsEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn TimeseriesforecastnbeatsEdge::fill(self : TimeseriesforecastnbeatsEdge, v : Double) -> TimeseriesforecastnbeatsEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn TimeseriesforecastnbeatsEdge::min(self : TimeseriesforecastnbeatsEdge) -> Double { @_common.min(self.data) }

pub fn TimeseriesforecastnbeatsEdge::max(self : TimeseriesforecastnbeatsEdge) -> Double { @_common.max(self.data) }

pub fn TimeseriesforecastnbeatsEdge::to_string(self : TimeseriesforecastnbeatsEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct TimeseriesforecastnbeatsPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_forecast_nbeats_path_make(size : Int) -> TimeseriesforecastnbeatsPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn TimeseriesforecastnbeatsPath::len(self : TimeseriesforecastnbeatsPath) -> Int { self.size }

pub fn TimeseriesforecastnbeatsPath::get(self : TimeseriesforecastnbeatsPath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn TimeseriesforecastnbeatsPath::set(self : TimeseriesforecastnbeatsPath, i : Int, v : Double) -> TimeseriesforecastnbeatsPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn TimeseriesforecastnbeatsPath::sum(self : TimeseriesforecastnbeatsPath) -> Double { @_common.sum(self.data) }

pub fn TimeseriesforecastnbeatsPath::mean(self : TimeseriesforecastnbeatsPath) -> Double { @_common.mean(self.data) }

pub fn TimeseriesforecastnbeatsPath::scale(self : TimeseriesforecastnbeatsPath, f : Double) -> TimeseriesforecastnbeatsPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn TimeseriesforecastnbeatsPath::add(self : TimeseriesforecastnbeatsPath, other : TimeseriesforecastnbeatsPath) -> TimeseriesforecastnbeatsPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn TimeseriesforecastnbeatsPath::copy(self : TimeseriesforecastnbeatsPath) -> TimeseriesforecastnbeatsPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn TimeseriesforecastnbeatsPath::fill(self : TimeseriesforecastnbeatsPath, v : Double) -> TimeseriesforecastnbeatsPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn TimeseriesforecastnbeatsPath::min(self : TimeseriesforecastnbeatsPath) -> Double { @_common.min(self.data) }

pub fn TimeseriesforecastnbeatsPath::max(self : TimeseriesforecastnbeatsPath) -> Double { @_common.max(self.data) }

pub fn TimeseriesforecastnbeatsPath::to_string(self : TimeseriesforecastnbeatsPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct TimeseriesforecastnbeatsCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_forecast_nbeats_cluster_make(size : Int) -> TimeseriesforecastnbeatsCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn TimeseriesforecastnbeatsCluster::len(self : TimeseriesforecastnbeatsCluster) -> Int { self.size }

pub fn TimeseriesforecastnbeatsCluster::get(self : TimeseriesforecastnbeatsCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn TimeseriesforecastnbeatsCluster::set(self : TimeseriesforecastnbeatsCluster, i : Int, v : Double) -> TimeseriesforecastnbeatsCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn TimeseriesforecastnbeatsCluster::sum(self : TimeseriesforecastnbeatsCluster) -> Double { @_common.sum(self.data) }

pub fn TimeseriesforecastnbeatsCluster::mean(self : TimeseriesforecastnbeatsCluster) -> Double { @_common.mean(self.data) }

pub fn TimeseriesforecastnbeatsCluster::scale(self : TimeseriesforecastnbeatsCluster, f : Double) -> TimeseriesforecastnbeatsCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn TimeseriesforecastnbeatsCluster::add(self : TimeseriesforecastnbeatsCluster, other : TimeseriesforecastnbeatsCluster) -> TimeseriesforecastnbeatsCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn TimeseriesforecastnbeatsCluster::copy(self : TimeseriesforecastnbeatsCluster) -> TimeseriesforecastnbeatsCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn TimeseriesforecastnbeatsCluster::fill(self : TimeseriesforecastnbeatsCluster, v : Double) -> TimeseriesforecastnbeatsCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn TimeseriesforecastnbeatsCluster::min(self : TimeseriesforecastnbeatsCluster) -> Double { @_common.min(self.data) }

pub fn TimeseriesforecastnbeatsCluster::max(self : TimeseriesforecastnbeatsCluster) -> Double { @_common.max(self.data) }

pub fn TimeseriesforecastnbeatsCluster::to_string(self : TimeseriesforecastnbeatsCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct TimeseriesforecastnbeatsModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_forecast_nbeats_model_make(size : Int) -> TimeseriesforecastnbeatsModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn TimeseriesforecastnbeatsModel::len(self : TimeseriesforecastnbeatsModel) -> Int { self.size }

pub fn TimeseriesforecastnbeatsModel::get(self : TimeseriesforecastnbeatsModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn TimeseriesforecastnbeatsModel::set(self : TimeseriesforecastnbeatsModel, i : Int, v : Double) -> TimeseriesforecastnbeatsModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn TimeseriesforecastnbeatsModel::sum(self : TimeseriesforecastnbeatsModel) -> Double { @_common.sum(self.data) }

pub fn TimeseriesforecastnbeatsModel::mean(self : TimeseriesforecastnbeatsModel) -> Double { @_common.mean(self.data) }

pub fn TimeseriesforecastnbeatsModel::scale(self : TimeseriesforecastnbeatsModel, f : Double) -> TimeseriesforecastnbeatsModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn TimeseriesforecastnbeatsModel::add(self : TimeseriesforecastnbeatsModel, other : TimeseriesforecastnbeatsModel) -> TimeseriesforecastnbeatsModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn TimeseriesforecastnbeatsModel::copy(self : TimeseriesforecastnbeatsModel) -> TimeseriesforecastnbeatsModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn TimeseriesforecastnbeatsModel::fill(self : TimeseriesforecastnbeatsModel, v : Double) -> TimeseriesforecastnbeatsModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn TimeseriesforecastnbeatsModel::min(self : TimeseriesforecastnbeatsModel) -> Double { @_common.min(self.data) }

pub fn TimeseriesforecastnbeatsModel::max(self : TimeseriesforecastnbeatsModel) -> Double { @_common.max(self.data) }

pub fn TimeseriesforecastnbeatsModel::to_string(self : TimeseriesforecastnbeatsModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct TimeseriesforecastnbeatsLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_forecast_nbeats_layer_make(size : Int) -> TimeseriesforecastnbeatsLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn TimeseriesforecastnbeatsLayer::len(self : TimeseriesforecastnbeatsLayer) -> Int { self.size }

pub fn TimeseriesforecastnbeatsLayer::get(self : TimeseriesforecastnbeatsLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn TimeseriesforecastnbeatsLayer::set(self : TimeseriesforecastnbeatsLayer, i : Int, v : Double) -> TimeseriesforecastnbeatsLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn TimeseriesforecastnbeatsLayer::sum(self : TimeseriesforecastnbeatsLayer) -> Double { @_common.sum(self.data) }

pub fn TimeseriesforecastnbeatsLayer::mean(self : TimeseriesforecastnbeatsLayer) -> Double { @_common.mean(self.data) }

pub fn TimeseriesforecastnbeatsLayer::scale(self : TimeseriesforecastnbeatsLayer, f : Double) -> TimeseriesforecastnbeatsLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn TimeseriesforecastnbeatsLayer::add(self : TimeseriesforecastnbeatsLayer, other : TimeseriesforecastnbeatsLayer) -> TimeseriesforecastnbeatsLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn TimeseriesforecastnbeatsLayer::copy(self : TimeseriesforecastnbeatsLayer) -> TimeseriesforecastnbeatsLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn TimeseriesforecastnbeatsLayer::fill(self : TimeseriesforecastnbeatsLayer, v : Double) -> TimeseriesforecastnbeatsLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn TimeseriesforecastnbeatsLayer::min(self : TimeseriesforecastnbeatsLayer) -> Double { @_common.min(self.data) }

pub fn TimeseriesforecastnbeatsLayer::max(self : TimeseriesforecastnbeatsLayer) -> Double { @_common.max(self.data) }

pub fn TimeseriesforecastnbeatsLayer::to_string(self : TimeseriesforecastnbeatsLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct TimeseriesforecastnbeatsBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_forecast_nbeats_buffer_make(size : Int) -> TimeseriesforecastnbeatsBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn TimeseriesforecastnbeatsBuffer::len(self : TimeseriesforecastnbeatsBuffer) -> Int { self.size }

pub fn TimeseriesforecastnbeatsBuffer::get(self : TimeseriesforecastnbeatsBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn TimeseriesforecastnbeatsBuffer::set(self : TimeseriesforecastnbeatsBuffer, i : Int, v : Double) -> TimeseriesforecastnbeatsBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn TimeseriesforecastnbeatsBuffer::sum(self : TimeseriesforecastnbeatsBuffer) -> Double { @_common.sum(self.data) }

pub fn TimeseriesforecastnbeatsBuffer::mean(self : TimeseriesforecastnbeatsBuffer) -> Double { @_common.mean(self.data) }

pub fn TimeseriesforecastnbeatsBuffer::scale(self : TimeseriesforecastnbeatsBuffer, f : Double) -> TimeseriesforecastnbeatsBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn TimeseriesforecastnbeatsBuffer::add(self : TimeseriesforecastnbeatsBuffer, other : TimeseriesforecastnbeatsBuffer) -> TimeseriesforecastnbeatsBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn TimeseriesforecastnbeatsBuffer::copy(self : TimeseriesforecastnbeatsBuffer) -> TimeseriesforecastnbeatsBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn TimeseriesforecastnbeatsBuffer::fill(self : TimeseriesforecastnbeatsBuffer, v : Double) -> TimeseriesforecastnbeatsBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn TimeseriesforecastnbeatsBuffer::min(self : TimeseriesforecastnbeatsBuffer) -> Double { @_common.min(self.data) }

pub fn TimeseriesforecastnbeatsBuffer::max(self : TimeseriesforecastnbeatsBuffer) -> Double { @_common.max(self.data) }

pub fn TimeseriesforecastnbeatsBuffer::to_string(self : TimeseriesforecastnbeatsBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct TimeseriesforecastnbeatsCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_forecast_nbeats_cursor_make(size : Int) -> TimeseriesforecastnbeatsCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn TimeseriesforecastnbeatsCursor::len(self : TimeseriesforecastnbeatsCursor) -> Int { self.size }

pub fn TimeseriesforecastnbeatsCursor::get(self : TimeseriesforecastnbeatsCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn TimeseriesforecastnbeatsCursor::set(self : TimeseriesforecastnbeatsCursor, i : Int, v : Double) -> TimeseriesforecastnbeatsCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn TimeseriesforecastnbeatsCursor::sum(self : TimeseriesforecastnbeatsCursor) -> Double { @_common.sum(self.data) }

pub fn TimeseriesforecastnbeatsCursor::mean(self : TimeseriesforecastnbeatsCursor) -> Double { @_common.mean(self.data) }

pub fn TimeseriesforecastnbeatsCursor::scale(self : TimeseriesforecastnbeatsCursor, f : Double) -> TimeseriesforecastnbeatsCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn TimeseriesforecastnbeatsCursor::add(self : TimeseriesforecastnbeatsCursor, other : TimeseriesforecastnbeatsCursor) -> TimeseriesforecastnbeatsCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn TimeseriesforecastnbeatsCursor::copy(self : TimeseriesforecastnbeatsCursor) -> TimeseriesforecastnbeatsCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn TimeseriesforecastnbeatsCursor::fill(self : TimeseriesforecastnbeatsCursor, v : Double) -> TimeseriesforecastnbeatsCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn TimeseriesforecastnbeatsCursor::min(self : TimeseriesforecastnbeatsCursor) -> Double { @_common.min(self.data) }

pub fn TimeseriesforecastnbeatsCursor::max(self : TimeseriesforecastnbeatsCursor) -> Double { @_common.max(self.data) }

pub fn TimeseriesforecastnbeatsCursor::to_string(self : TimeseriesforecastnbeatsCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct TimeseriesforecastnbeatsView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_forecast_nbeats_view_make(size : Int) -> TimeseriesforecastnbeatsView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn TimeseriesforecastnbeatsView::len(self : TimeseriesforecastnbeatsView) -> Int { self.size }

pub fn TimeseriesforecastnbeatsView::get(self : TimeseriesforecastnbeatsView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn TimeseriesforecastnbeatsView::set(self : TimeseriesforecastnbeatsView, i : Int, v : Double) -> TimeseriesforecastnbeatsView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn TimeseriesforecastnbeatsView::sum(self : TimeseriesforecastnbeatsView) -> Double { @_common.sum(self.data) }

pub fn TimeseriesforecastnbeatsView::mean(self : TimeseriesforecastnbeatsView) -> Double { @_common.mean(self.data) }

pub fn TimeseriesforecastnbeatsView::scale(self : TimeseriesforecastnbeatsView, f : Double) -> TimeseriesforecastnbeatsView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn TimeseriesforecastnbeatsView::add(self : TimeseriesforecastnbeatsView, other : TimeseriesforecastnbeatsView) -> TimeseriesforecastnbeatsView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn TimeseriesforecastnbeatsView::copy(self : TimeseriesforecastnbeatsView) -> TimeseriesforecastnbeatsView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn TimeseriesforecastnbeatsView::fill(self : TimeseriesforecastnbeatsView, v : Double) -> TimeseriesforecastnbeatsView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn TimeseriesforecastnbeatsView::min(self : TimeseriesforecastnbeatsView) -> Double { @_common.min(self.data) }

pub fn TimeseriesforecastnbeatsView::max(self : TimeseriesforecastnbeatsView) -> Double { @_common.max(self.data) }

pub fn TimeseriesforecastnbeatsView::to_string(self : TimeseriesforecastnbeatsView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct TimeseriesforecastnbeatsRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_forecast_nbeats_range_make(size : Int) -> TimeseriesforecastnbeatsRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn TimeseriesforecastnbeatsRange::len(self : TimeseriesforecastnbeatsRange) -> Int { self.size }

pub fn TimeseriesforecastnbeatsRange::get(self : TimeseriesforecastnbeatsRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn TimeseriesforecastnbeatsRange::set(self : TimeseriesforecastnbeatsRange, i : Int, v : Double) -> TimeseriesforecastnbeatsRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn TimeseriesforecastnbeatsRange::sum(self : TimeseriesforecastnbeatsRange) -> Double { @_common.sum(self.data) }

pub fn TimeseriesforecastnbeatsRange::mean(self : TimeseriesforecastnbeatsRange) -> Double { @_common.mean(self.data) }

pub fn TimeseriesforecastnbeatsRange::scale(self : TimeseriesforecastnbeatsRange, f : Double) -> TimeseriesforecastnbeatsRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn TimeseriesforecastnbeatsRange::add(self : TimeseriesforecastnbeatsRange, other : TimeseriesforecastnbeatsRange) -> TimeseriesforecastnbeatsRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn TimeseriesforecastnbeatsRange::copy(self : TimeseriesforecastnbeatsRange) -> TimeseriesforecastnbeatsRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn TimeseriesforecastnbeatsRange::fill(self : TimeseriesforecastnbeatsRange, v : Double) -> TimeseriesforecastnbeatsRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn TimeseriesforecastnbeatsRange::min(self : TimeseriesforecastnbeatsRange) -> Double { @_common.min(self.data) }

pub fn TimeseriesforecastnbeatsRange::max(self : TimeseriesforecastnbeatsRange) -> Double { @_common.max(self.data) }

pub fn TimeseriesforecastnbeatsRange::to_string(self : TimeseriesforecastnbeatsRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct TimeseriesforecastnbeatsSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_forecast_nbeats_slice_make(size : Int) -> TimeseriesforecastnbeatsSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn TimeseriesforecastnbeatsSlice::len(self : TimeseriesforecastnbeatsSlice) -> Int { self.size }

pub fn TimeseriesforecastnbeatsSlice::get(self : TimeseriesforecastnbeatsSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn TimeseriesforecastnbeatsSlice::set(self : TimeseriesforecastnbeatsSlice, i : Int, v : Double) -> TimeseriesforecastnbeatsSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn TimeseriesforecastnbeatsSlice::sum(self : TimeseriesforecastnbeatsSlice) -> Double { @_common.sum(self.data) }

pub fn TimeseriesforecastnbeatsSlice::mean(self : TimeseriesforecastnbeatsSlice) -> Double { @_common.mean(self.data) }

pub fn TimeseriesforecastnbeatsSlice::scale(self : TimeseriesforecastnbeatsSlice, f : Double) -> TimeseriesforecastnbeatsSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn TimeseriesforecastnbeatsSlice::add(self : TimeseriesforecastnbeatsSlice, other : TimeseriesforecastnbeatsSlice) -> TimeseriesforecastnbeatsSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn TimeseriesforecastnbeatsSlice::copy(self : TimeseriesforecastnbeatsSlice) -> TimeseriesforecastnbeatsSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn TimeseriesforecastnbeatsSlice::fill(self : TimeseriesforecastnbeatsSlice, v : Double) -> TimeseriesforecastnbeatsSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn TimeseriesforecastnbeatsSlice::min(self : TimeseriesforecastnbeatsSlice) -> Double { @_common.min(self.data) }

pub fn TimeseriesforecastnbeatsSlice::max(self : TimeseriesforecastnbeatsSlice) -> Double { @_common.max(self.data) }

pub fn TimeseriesforecastnbeatsSlice::to_string(self : TimeseriesforecastnbeatsSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

