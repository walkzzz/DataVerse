///===
/// extcore/timeseries_forecast_naive

pub(all) struct TimeseriesforecastnaivePoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn timeseries_forecast_naive_make_point(x : Double, y : Double) -> TimeseriesforecastnaivePoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn timeseries_forecast_naive_make_point3(x : Double, y : Double, z : Double) -> TimeseriesforecastnaivePoint {
  { x, y, z, label: 0 }
}

pub fn TimeseriesforecastnaivePoint::x(self : TimeseriesforecastnaivePoint) -> Double { self.x }

pub fn TimeseriesforecastnaivePoint::y(self : TimeseriesforecastnaivePoint) -> Double { self.y }

pub fn TimeseriesforecastnaivePoint::z(self : TimeseriesforecastnaivePoint) -> Double { self.z }

pub fn TimeseriesforecastnaivePoint::label(self : TimeseriesforecastnaivePoint) -> Int { self.label }

pub fn TimeseriesforecastnaivePoint::dist(self : TimeseriesforecastnaivePoint, other : TimeseriesforecastnaivePoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn TimeseriesforecastnaivePoint::add(self : TimeseriesforecastnaivePoint, other : TimeseriesforecastnaivePoint) -> TimeseriesforecastnaivePoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn TimeseriesforecastnaivePoint::sub(self : TimeseriesforecastnaivePoint, other : TimeseriesforecastnaivePoint) -> TimeseriesforecastnaivePoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn TimeseriesforecastnaivePoint::scale(self : TimeseriesforecastnaivePoint, s : Double) -> TimeseriesforecastnaivePoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn TimeseriesforecastnaivePoint::dot(self : TimeseriesforecastnaivePoint, other : TimeseriesforecastnaivePoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn TimeseriesforecastnaivePoint::cross(self : TimeseriesforecastnaivePoint, other : TimeseriesforecastnaivePoint) -> TimeseriesforecastnaivePoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn TimeseriesforecastnaivePoint::norm(self : TimeseriesforecastnaivePoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn TimeseriesforecastnaivePoint::normalize(self : TimeseriesforecastnaivePoint) -> TimeseriesforecastnaivePoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn TimeseriesforecastnaivePoint::negate(self : TimeseriesforecastnaivePoint) -> TimeseriesforecastnaivePoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn TimeseriesforecastnaivePoint::mid(self : TimeseriesforecastnaivePoint, other : TimeseriesforecastnaivePoint) -> TimeseriesforecastnaivePoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn TimeseriesforecastnaivePoint::lerp(self : TimeseriesforecastnaivePoint, other : TimeseriesforecastnaivePoint, t : Double) -> TimeseriesforecastnaivePoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn TimeseriesforecastnaivePoint::to_string(self : TimeseriesforecastnaivePoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct TimeseriesforecastnaiveSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn timeseries_forecast_naive_make_series(vals : Array[Double], name : String) -> TimeseriesforecastnaiveSeries {
  { vals, name, meta: 0 }
}

pub fn TimeseriesforecastnaiveSeries::len(self : TimeseriesforecastnaiveSeries) -> Int { self.vals.length() }

pub fn TimeseriesforecastnaiveSeries::sum(self : TimeseriesforecastnaiveSeries) -> Double { @_common.sum(self.vals) }

pub fn TimeseriesforecastnaiveSeries::mean(self : TimeseriesforecastnaiveSeries) -> Double { @_common.mean(self.vals) }

pub fn TimeseriesforecastnaiveSeries::min(self : TimeseriesforecastnaiveSeries) -> Double { @_common.min(self.vals) }

pub fn TimeseriesforecastnaiveSeries::max(self : TimeseriesforecastnaiveSeries) -> Double { @_common.max(self.vals) }

pub fn TimeseriesforecastnaiveSeries::range(self : TimeseriesforecastnaiveSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn TimeseriesforecastnaiveSeries::variance(self : TimeseriesforecastnaiveSeries) -> Double { @_common.variance(self.vals) }

pub fn TimeseriesforecastnaiveSeries::std(self : TimeseriesforecastnaiveSeries) -> Double { @_common.std(self.vals) }

pub fn TimeseriesforecastnaiveSeries::median(self : TimeseriesforecastnaiveSeries) -> Double { @_common.median(self.vals) }

pub fn TimeseriesforecastnaiveSeries::scale(self : TimeseriesforecastnaiveSeries, f : Double) -> TimeseriesforecastnaiveSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn TimeseriesforecastnaiveSeries::add(self : TimeseriesforecastnaiveSeries, other : TimeseriesforecastnaiveSeries) -> TimeseriesforecastnaiveSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn TimeseriesforecastnaiveSeries::sub(self : TimeseriesforecastnaiveSeries, other : TimeseriesforecastnaiveSeries) -> TimeseriesforecastnaiveSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn TimeseriesforecastnaiveSeries::normalize(self : TimeseriesforecastnaiveSeries) -> TimeseriesforecastnaiveSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn TimeseriesforecastnaiveSeries::cumsum(self : TimeseriesforecastnaiveSeries) -> TimeseriesforecastnaiveSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn TimeseriesforecastnaiveSeries::to_string(self : TimeseriesforecastnaiveSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct TimeseriesforecastnaiveMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn timeseries_forecast_naive_make_matrix(rows : Int, cols : Int, val : Double) -> TimeseriesforecastnaiveMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn timeseries_forecast_naive_matrix_identity(n : Int) -> TimeseriesforecastnaiveMatrix {
  let m = timeseries_forecast_naive_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn TimeseriesforecastnaiveMatrix::get(self : TimeseriesforecastnaiveMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn TimeseriesforecastnaiveMatrix::transpose(self : TimeseriesforecastnaiveMatrix) -> TimeseriesforecastnaiveMatrix {
  let result = timeseries_forecast_naive_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn TimeseriesforecastnaiveMatrix::add(self : TimeseriesforecastnaiveMatrix, other : TimeseriesforecastnaiveMatrix) -> TimeseriesforecastnaiveMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = timeseries_forecast_naive_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn TimeseriesforecastnaiveMatrix::scale(self : TimeseriesforecastnaiveMatrix, s : Double) -> TimeseriesforecastnaiveMatrix {
  let result = timeseries_forecast_naive_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn TimeseriesforecastnaiveMatrix::multiply(self : TimeseriesforecastnaiveMatrix, other : TimeseriesforecastnaiveMatrix) -> TimeseriesforecastnaiveMatrix {
  if self.cols != other.rows { return timeseries_forecast_naive_make_matrix(self.rows, other.cols, 0.0) }
  let result = timeseries_forecast_naive_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn TimeseriesforecastnaiveMatrix::trace(self : TimeseriesforecastnaiveMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn TimeseriesforecastnaiveMatrix::det(self : TimeseriesforecastnaiveMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn TimeseriesforecastnaiveMatrix::norm(self : TimeseriesforecastnaiveMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn TimeseriesforecastnaiveMatrix::to_string(self : TimeseriesforecastnaiveMatrix) -> String {
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

pub(all) struct TimeseriesforecastnaiveVector {
  comps : Array[Double]
  dim : Int
}

pub fn timeseries_forecast_naive_make_vector(comps : Array[Double]) -> TimeseriesforecastnaiveVector {
  { comps, dim: comps.length() }
}

pub fn timeseries_forecast_naive_vector_zero(dim : Int) -> TimeseriesforecastnaiveVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn TimeseriesforecastnaiveVector::add(self : TimeseriesforecastnaiveVector, other : TimeseriesforecastnaiveVector) -> TimeseriesforecastnaiveVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn TimeseriesforecastnaiveVector::sub(self : TimeseriesforecastnaiveVector, other : TimeseriesforecastnaiveVector) -> TimeseriesforecastnaiveVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn TimeseriesforecastnaiveVector::scale(self : TimeseriesforecastnaiveVector, s : Double) -> TimeseriesforecastnaiveVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn TimeseriesforecastnaiveVector::dot(self : TimeseriesforecastnaiveVector, other : TimeseriesforecastnaiveVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn TimeseriesforecastnaiveVector::norm(self : TimeseriesforecastnaiveVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn TimeseriesforecastnaiveVector::normalize(self : TimeseriesforecastnaiveVector) -> TimeseriesforecastnaiveVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn TimeseriesforecastnaiveVector::dist(self : TimeseriesforecastnaiveVector, other : TimeseriesforecastnaiveVector) -> Double {
  self.sub(other).norm()
}

pub fn TimeseriesforecastnaiveVector::to_string(self : TimeseriesforecastnaiveVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn timeseries_forecast_naive_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn timeseries_forecast_naive_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn timeseries_forecast_naive_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn timeseries_forecast_naive_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn timeseries_forecast_naive_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn timeseries_forecast_naive_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn timeseries_forecast_naive_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn timeseries_forecast_naive_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn timeseries_forecast_naive_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn timeseries_forecast_naive_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn timeseries_forecast_naive_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn timeseries_forecast_naive_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn timeseries_forecast_naive_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn timeseries_forecast_naive_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn timeseries_forecast_naive_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn timeseries_forecast_naive_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn timeseries_forecast_naive_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn timeseries_forecast_naive_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn timeseries_forecast_naive_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn timeseries_forecast_naive_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn timeseries_forecast_naive_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn timeseries_forecast_naive_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn timeseries_forecast_naive_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn timeseries_forecast_naive_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn timeseries_forecast_naive_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn timeseries_forecast_naive_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn timeseries_forecast_naive_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn timeseries_forecast_naive_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn timeseries_forecast_naive_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct TimeseriesforecastnaiveFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_forecast_naive_frame_make(size : Int) -> TimeseriesforecastnaiveFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_forecast_naive_frame_len(s : TimeseriesforecastnaiveFrame) -> Int { s.size }

pub fn timeseries_forecast_naive_frame_get(s : TimeseriesforecastnaiveFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_forecast_naive_frame_set(s : TimeseriesforecastnaiveFrame, i : Int, v : Double) -> TimeseriesforecastnaiveFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_naive_frame_sum(s : TimeseriesforecastnaiveFrame) -> Double { @_common.sum(s.data) }

pub fn timeseries_forecast_naive_frame_mean(s : TimeseriesforecastnaiveFrame) -> Double { @_common.mean(s.data) }

pub fn timeseries_forecast_naive_frame_scale(s : TimeseriesforecastnaiveFrame, f : Double) -> TimeseriesforecastnaiveFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_naive_frame_add(a : TimeseriesforecastnaiveFrame, b : TimeseriesforecastnaiveFrame) -> TimeseriesforecastnaiveFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_forecast_naive_frame_copy(s : TimeseriesforecastnaiveFrame) -> TimeseriesforecastnaiveFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_naive_frame_fill(s : TimeseriesforecastnaiveFrame, v : Double) -> TimeseriesforecastnaiveFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_naive_frame_min(s : TimeseriesforecastnaiveFrame) -> Double { @_common.min(s.data) }

pub fn timeseries_forecast_naive_frame_max(s : TimeseriesforecastnaiveFrame) -> Double { @_common.max(s.data) }

pub fn timeseries_forecast_naive_frame_to_string(s : TimeseriesforecastnaiveFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesforecastnaiveTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_forecast_naive_table_make(size : Int) -> TimeseriesforecastnaiveTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_forecast_naive_table_len(s : TimeseriesforecastnaiveTable) -> Int { s.size }

pub fn timeseries_forecast_naive_table_get(s : TimeseriesforecastnaiveTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_forecast_naive_table_set(s : TimeseriesforecastnaiveTable, i : Int, v : Double) -> TimeseriesforecastnaiveTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_naive_table_sum(s : TimeseriesforecastnaiveTable) -> Double { @_common.sum(s.data) }

pub fn timeseries_forecast_naive_table_mean(s : TimeseriesforecastnaiveTable) -> Double { @_common.mean(s.data) }

pub fn timeseries_forecast_naive_table_scale(s : TimeseriesforecastnaiveTable, f : Double) -> TimeseriesforecastnaiveTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_naive_table_add(a : TimeseriesforecastnaiveTable, b : TimeseriesforecastnaiveTable) -> TimeseriesforecastnaiveTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_forecast_naive_table_copy(s : TimeseriesforecastnaiveTable) -> TimeseriesforecastnaiveTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_naive_table_fill(s : TimeseriesforecastnaiveTable, v : Double) -> TimeseriesforecastnaiveTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_naive_table_min(s : TimeseriesforecastnaiveTable) -> Double { @_common.min(s.data) }

pub fn timeseries_forecast_naive_table_max(s : TimeseriesforecastnaiveTable) -> Double { @_common.max(s.data) }

pub fn timeseries_forecast_naive_table_to_string(s : TimeseriesforecastnaiveTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesforecastnaiveGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_forecast_naive_graphn_make(size : Int) -> TimeseriesforecastnaiveGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_forecast_naive_graphn_len(s : TimeseriesforecastnaiveGraphN) -> Int { s.size }

pub fn timeseries_forecast_naive_graphn_get(s : TimeseriesforecastnaiveGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_forecast_naive_graphn_set(s : TimeseriesforecastnaiveGraphN, i : Int, v : Double) -> TimeseriesforecastnaiveGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_naive_graphn_sum(s : TimeseriesforecastnaiveGraphN) -> Double { @_common.sum(s.data) }

pub fn timeseries_forecast_naive_graphn_mean(s : TimeseriesforecastnaiveGraphN) -> Double { @_common.mean(s.data) }

pub fn timeseries_forecast_naive_graphn_scale(s : TimeseriesforecastnaiveGraphN, f : Double) -> TimeseriesforecastnaiveGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_naive_graphn_add(a : TimeseriesforecastnaiveGraphN, b : TimeseriesforecastnaiveGraphN) -> TimeseriesforecastnaiveGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_forecast_naive_graphn_copy(s : TimeseriesforecastnaiveGraphN) -> TimeseriesforecastnaiveGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_naive_graphn_fill(s : TimeseriesforecastnaiveGraphN, v : Double) -> TimeseriesforecastnaiveGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_naive_graphn_min(s : TimeseriesforecastnaiveGraphN) -> Double { @_common.min(s.data) }

pub fn timeseries_forecast_naive_graphn_max(s : TimeseriesforecastnaiveGraphN) -> Double { @_common.max(s.data) }

pub fn timeseries_forecast_naive_graphn_to_string(s : TimeseriesforecastnaiveGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesforecastnaiveNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_forecast_naive_node_make(size : Int) -> TimeseriesforecastnaiveNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_forecast_naive_node_len(s : TimeseriesforecastnaiveNode) -> Int { s.size }

pub fn timeseries_forecast_naive_node_get(s : TimeseriesforecastnaiveNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_forecast_naive_node_set(s : TimeseriesforecastnaiveNode, i : Int, v : Double) -> TimeseriesforecastnaiveNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_naive_node_sum(s : TimeseriesforecastnaiveNode) -> Double { @_common.sum(s.data) }

pub fn timeseries_forecast_naive_node_mean(s : TimeseriesforecastnaiveNode) -> Double { @_common.mean(s.data) }

pub fn timeseries_forecast_naive_node_scale(s : TimeseriesforecastnaiveNode, f : Double) -> TimeseriesforecastnaiveNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_naive_node_add(a : TimeseriesforecastnaiveNode, b : TimeseriesforecastnaiveNode) -> TimeseriesforecastnaiveNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_forecast_naive_node_copy(s : TimeseriesforecastnaiveNode) -> TimeseriesforecastnaiveNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_naive_node_fill(s : TimeseriesforecastnaiveNode, v : Double) -> TimeseriesforecastnaiveNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_naive_node_min(s : TimeseriesforecastnaiveNode) -> Double { @_common.min(s.data) }

pub fn timeseries_forecast_naive_node_max(s : TimeseriesforecastnaiveNode) -> Double { @_common.max(s.data) }

pub fn timeseries_forecast_naive_node_to_string(s : TimeseriesforecastnaiveNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesforecastnaiveEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_forecast_naive_edge_make(size : Int) -> TimeseriesforecastnaiveEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_forecast_naive_edge_len(s : TimeseriesforecastnaiveEdge) -> Int { s.size }

pub fn timeseries_forecast_naive_edge_get(s : TimeseriesforecastnaiveEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_forecast_naive_edge_set(s : TimeseriesforecastnaiveEdge, i : Int, v : Double) -> TimeseriesforecastnaiveEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_naive_edge_sum(s : TimeseriesforecastnaiveEdge) -> Double { @_common.sum(s.data) }

pub fn timeseries_forecast_naive_edge_mean(s : TimeseriesforecastnaiveEdge) -> Double { @_common.mean(s.data) }

pub fn timeseries_forecast_naive_edge_scale(s : TimeseriesforecastnaiveEdge, f : Double) -> TimeseriesforecastnaiveEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_naive_edge_add(a : TimeseriesforecastnaiveEdge, b : TimeseriesforecastnaiveEdge) -> TimeseriesforecastnaiveEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_forecast_naive_edge_copy(s : TimeseriesforecastnaiveEdge) -> TimeseriesforecastnaiveEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_naive_edge_fill(s : TimeseriesforecastnaiveEdge, v : Double) -> TimeseriesforecastnaiveEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_naive_edge_min(s : TimeseriesforecastnaiveEdge) -> Double { @_common.min(s.data) }

pub fn timeseries_forecast_naive_edge_max(s : TimeseriesforecastnaiveEdge) -> Double { @_common.max(s.data) }

pub fn timeseries_forecast_naive_edge_to_string(s : TimeseriesforecastnaiveEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesforecastnaivePath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_forecast_naive_path_make(size : Int) -> TimeseriesforecastnaivePath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_forecast_naive_path_len(s : TimeseriesforecastnaivePath) -> Int { s.size }

pub fn timeseries_forecast_naive_path_get(s : TimeseriesforecastnaivePath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_forecast_naive_path_set(s : TimeseriesforecastnaivePath, i : Int, v : Double) -> TimeseriesforecastnaivePath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_naive_path_sum(s : TimeseriesforecastnaivePath) -> Double { @_common.sum(s.data) }

pub fn timeseries_forecast_naive_path_mean(s : TimeseriesforecastnaivePath) -> Double { @_common.mean(s.data) }

pub fn timeseries_forecast_naive_path_scale(s : TimeseriesforecastnaivePath, f : Double) -> TimeseriesforecastnaivePath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_naive_path_add(a : TimeseriesforecastnaivePath, b : TimeseriesforecastnaivePath) -> TimeseriesforecastnaivePath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_forecast_naive_path_copy(s : TimeseriesforecastnaivePath) -> TimeseriesforecastnaivePath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_naive_path_fill(s : TimeseriesforecastnaivePath, v : Double) -> TimeseriesforecastnaivePath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_naive_path_min(s : TimeseriesforecastnaivePath) -> Double { @_common.min(s.data) }

pub fn timeseries_forecast_naive_path_max(s : TimeseriesforecastnaivePath) -> Double { @_common.max(s.data) }

pub fn timeseries_forecast_naive_path_to_string(s : TimeseriesforecastnaivePath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesforecastnaiveCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_forecast_naive_cluster_make(size : Int) -> TimeseriesforecastnaiveCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_forecast_naive_cluster_len(s : TimeseriesforecastnaiveCluster) -> Int { s.size }

pub fn timeseries_forecast_naive_cluster_get(s : TimeseriesforecastnaiveCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_forecast_naive_cluster_set(s : TimeseriesforecastnaiveCluster, i : Int, v : Double) -> TimeseriesforecastnaiveCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_naive_cluster_sum(s : TimeseriesforecastnaiveCluster) -> Double { @_common.sum(s.data) }

pub fn timeseries_forecast_naive_cluster_mean(s : TimeseriesforecastnaiveCluster) -> Double { @_common.mean(s.data) }

pub fn timeseries_forecast_naive_cluster_scale(s : TimeseriesforecastnaiveCluster, f : Double) -> TimeseriesforecastnaiveCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_naive_cluster_add(a : TimeseriesforecastnaiveCluster, b : TimeseriesforecastnaiveCluster) -> TimeseriesforecastnaiveCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_forecast_naive_cluster_copy(s : TimeseriesforecastnaiveCluster) -> TimeseriesforecastnaiveCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_naive_cluster_fill(s : TimeseriesforecastnaiveCluster, v : Double) -> TimeseriesforecastnaiveCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_naive_cluster_min(s : TimeseriesforecastnaiveCluster) -> Double { @_common.min(s.data) }

pub fn timeseries_forecast_naive_cluster_max(s : TimeseriesforecastnaiveCluster) -> Double { @_common.max(s.data) }

pub fn timeseries_forecast_naive_cluster_to_string(s : TimeseriesforecastnaiveCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesforecastnaiveModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_forecast_naive_model_make(size : Int) -> TimeseriesforecastnaiveModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_forecast_naive_model_len(s : TimeseriesforecastnaiveModel) -> Int { s.size }

pub fn timeseries_forecast_naive_model_get(s : TimeseriesforecastnaiveModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_forecast_naive_model_set(s : TimeseriesforecastnaiveModel, i : Int, v : Double) -> TimeseriesforecastnaiveModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_naive_model_sum(s : TimeseriesforecastnaiveModel) -> Double { @_common.sum(s.data) }

pub fn timeseries_forecast_naive_model_mean(s : TimeseriesforecastnaiveModel) -> Double { @_common.mean(s.data) }

pub fn timeseries_forecast_naive_model_scale(s : TimeseriesforecastnaiveModel, f : Double) -> TimeseriesforecastnaiveModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_naive_model_add(a : TimeseriesforecastnaiveModel, b : TimeseriesforecastnaiveModel) -> TimeseriesforecastnaiveModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_forecast_naive_model_copy(s : TimeseriesforecastnaiveModel) -> TimeseriesforecastnaiveModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_naive_model_fill(s : TimeseriesforecastnaiveModel, v : Double) -> TimeseriesforecastnaiveModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_naive_model_min(s : TimeseriesforecastnaiveModel) -> Double { @_common.min(s.data) }

pub fn timeseries_forecast_naive_model_max(s : TimeseriesforecastnaiveModel) -> Double { @_common.max(s.data) }

pub fn timeseries_forecast_naive_model_to_string(s : TimeseriesforecastnaiveModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesforecastnaiveLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_forecast_naive_layer_make(size : Int) -> TimeseriesforecastnaiveLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_forecast_naive_layer_len(s : TimeseriesforecastnaiveLayer) -> Int { s.size }

pub fn timeseries_forecast_naive_layer_get(s : TimeseriesforecastnaiveLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_forecast_naive_layer_set(s : TimeseriesforecastnaiveLayer, i : Int, v : Double) -> TimeseriesforecastnaiveLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_naive_layer_sum(s : TimeseriesforecastnaiveLayer) -> Double { @_common.sum(s.data) }

pub fn timeseries_forecast_naive_layer_mean(s : TimeseriesforecastnaiveLayer) -> Double { @_common.mean(s.data) }

pub fn timeseries_forecast_naive_layer_scale(s : TimeseriesforecastnaiveLayer, f : Double) -> TimeseriesforecastnaiveLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_naive_layer_add(a : TimeseriesforecastnaiveLayer, b : TimeseriesforecastnaiveLayer) -> TimeseriesforecastnaiveLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_forecast_naive_layer_copy(s : TimeseriesforecastnaiveLayer) -> TimeseriesforecastnaiveLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_naive_layer_fill(s : TimeseriesforecastnaiveLayer, v : Double) -> TimeseriesforecastnaiveLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_naive_layer_min(s : TimeseriesforecastnaiveLayer) -> Double { @_common.min(s.data) }

pub fn timeseries_forecast_naive_layer_max(s : TimeseriesforecastnaiveLayer) -> Double { @_common.max(s.data) }

pub fn timeseries_forecast_naive_layer_to_string(s : TimeseriesforecastnaiveLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesforecastnaiveBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_forecast_naive_buffer_make(size : Int) -> TimeseriesforecastnaiveBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_forecast_naive_buffer_len(s : TimeseriesforecastnaiveBuffer) -> Int { s.size }

pub fn timeseries_forecast_naive_buffer_get(s : TimeseriesforecastnaiveBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_forecast_naive_buffer_set(s : TimeseriesforecastnaiveBuffer, i : Int, v : Double) -> TimeseriesforecastnaiveBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_naive_buffer_sum(s : TimeseriesforecastnaiveBuffer) -> Double { @_common.sum(s.data) }

pub fn timeseries_forecast_naive_buffer_mean(s : TimeseriesforecastnaiveBuffer) -> Double { @_common.mean(s.data) }

pub fn timeseries_forecast_naive_buffer_scale(s : TimeseriesforecastnaiveBuffer, f : Double) -> TimeseriesforecastnaiveBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_naive_buffer_add(a : TimeseriesforecastnaiveBuffer, b : TimeseriesforecastnaiveBuffer) -> TimeseriesforecastnaiveBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_forecast_naive_buffer_copy(s : TimeseriesforecastnaiveBuffer) -> TimeseriesforecastnaiveBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_naive_buffer_fill(s : TimeseriesforecastnaiveBuffer, v : Double) -> TimeseriesforecastnaiveBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_naive_buffer_min(s : TimeseriesforecastnaiveBuffer) -> Double { @_common.min(s.data) }

pub fn timeseries_forecast_naive_buffer_max(s : TimeseriesforecastnaiveBuffer) -> Double { @_common.max(s.data) }

pub fn timeseries_forecast_naive_buffer_to_string(s : TimeseriesforecastnaiveBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesforecastnaiveCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_forecast_naive_cursor_make(size : Int) -> TimeseriesforecastnaiveCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_forecast_naive_cursor_len(s : TimeseriesforecastnaiveCursor) -> Int { s.size }

pub fn timeseries_forecast_naive_cursor_get(s : TimeseriesforecastnaiveCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_forecast_naive_cursor_set(s : TimeseriesforecastnaiveCursor, i : Int, v : Double) -> TimeseriesforecastnaiveCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_naive_cursor_sum(s : TimeseriesforecastnaiveCursor) -> Double { @_common.sum(s.data) }

pub fn timeseries_forecast_naive_cursor_mean(s : TimeseriesforecastnaiveCursor) -> Double { @_common.mean(s.data) }

pub fn timeseries_forecast_naive_cursor_scale(s : TimeseriesforecastnaiveCursor, f : Double) -> TimeseriesforecastnaiveCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_naive_cursor_add(a : TimeseriesforecastnaiveCursor, b : TimeseriesforecastnaiveCursor) -> TimeseriesforecastnaiveCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_forecast_naive_cursor_copy(s : TimeseriesforecastnaiveCursor) -> TimeseriesforecastnaiveCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_naive_cursor_fill(s : TimeseriesforecastnaiveCursor, v : Double) -> TimeseriesforecastnaiveCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_naive_cursor_min(s : TimeseriesforecastnaiveCursor) -> Double { @_common.min(s.data) }

pub fn timeseries_forecast_naive_cursor_max(s : TimeseriesforecastnaiveCursor) -> Double { @_common.max(s.data) }

pub fn timeseries_forecast_naive_cursor_to_string(s : TimeseriesforecastnaiveCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesforecastnaiveView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_forecast_naive_view_make(size : Int) -> TimeseriesforecastnaiveView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_forecast_naive_view_len(s : TimeseriesforecastnaiveView) -> Int { s.size }

pub fn timeseries_forecast_naive_view_get(s : TimeseriesforecastnaiveView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_forecast_naive_view_set(s : TimeseriesforecastnaiveView, i : Int, v : Double) -> TimeseriesforecastnaiveView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_naive_view_sum(s : TimeseriesforecastnaiveView) -> Double { @_common.sum(s.data) }

pub fn timeseries_forecast_naive_view_mean(s : TimeseriesforecastnaiveView) -> Double { @_common.mean(s.data) }

pub fn timeseries_forecast_naive_view_scale(s : TimeseriesforecastnaiveView, f : Double) -> TimeseriesforecastnaiveView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_naive_view_add(a : TimeseriesforecastnaiveView, b : TimeseriesforecastnaiveView) -> TimeseriesforecastnaiveView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_forecast_naive_view_copy(s : TimeseriesforecastnaiveView) -> TimeseriesforecastnaiveView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_naive_view_fill(s : TimeseriesforecastnaiveView, v : Double) -> TimeseriesforecastnaiveView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_naive_view_min(s : TimeseriesforecastnaiveView) -> Double { @_common.min(s.data) }

pub fn timeseries_forecast_naive_view_max(s : TimeseriesforecastnaiveView) -> Double { @_common.max(s.data) }

pub fn timeseries_forecast_naive_view_to_string(s : TimeseriesforecastnaiveView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesforecastnaiveRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_forecast_naive_range_make(size : Int) -> TimeseriesforecastnaiveRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_forecast_naive_range_len(s : TimeseriesforecastnaiveRange) -> Int { s.size }

pub fn timeseries_forecast_naive_range_get(s : TimeseriesforecastnaiveRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_forecast_naive_range_set(s : TimeseriesforecastnaiveRange, i : Int, v : Double) -> TimeseriesforecastnaiveRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_naive_range_sum(s : TimeseriesforecastnaiveRange) -> Double { @_common.sum(s.data) }

pub fn timeseries_forecast_naive_range_mean(s : TimeseriesforecastnaiveRange) -> Double { @_common.mean(s.data) }

pub fn timeseries_forecast_naive_range_scale(s : TimeseriesforecastnaiveRange, f : Double) -> TimeseriesforecastnaiveRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_naive_range_add(a : TimeseriesforecastnaiveRange, b : TimeseriesforecastnaiveRange) -> TimeseriesforecastnaiveRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_forecast_naive_range_copy(s : TimeseriesforecastnaiveRange) -> TimeseriesforecastnaiveRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_naive_range_fill(s : TimeseriesforecastnaiveRange, v : Double) -> TimeseriesforecastnaiveRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_naive_range_min(s : TimeseriesforecastnaiveRange) -> Double { @_common.min(s.data) }

pub fn timeseries_forecast_naive_range_max(s : TimeseriesforecastnaiveRange) -> Double { @_common.max(s.data) }

pub fn timeseries_forecast_naive_range_to_string(s : TimeseriesforecastnaiveRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesforecastnaiveSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_forecast_naive_slice_make(size : Int) -> TimeseriesforecastnaiveSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_forecast_naive_slice_len(s : TimeseriesforecastnaiveSlice) -> Int { s.size }

pub fn timeseries_forecast_naive_slice_get(s : TimeseriesforecastnaiveSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_forecast_naive_slice_set(s : TimeseriesforecastnaiveSlice, i : Int, v : Double) -> TimeseriesforecastnaiveSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_naive_slice_sum(s : TimeseriesforecastnaiveSlice) -> Double { @_common.sum(s.data) }

pub fn timeseries_forecast_naive_slice_mean(s : TimeseriesforecastnaiveSlice) -> Double { @_common.mean(s.data) }

pub fn timeseries_forecast_naive_slice_scale(s : TimeseriesforecastnaiveSlice, f : Double) -> TimeseriesforecastnaiveSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_naive_slice_add(a : TimeseriesforecastnaiveSlice, b : TimeseriesforecastnaiveSlice) -> TimeseriesforecastnaiveSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_forecast_naive_slice_copy(s : TimeseriesforecastnaiveSlice) -> TimeseriesforecastnaiveSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_naive_slice_fill(s : TimeseriesforecastnaiveSlice, v : Double) -> TimeseriesforecastnaiveSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_naive_slice_min(s : TimeseriesforecastnaiveSlice) -> Double { @_common.min(s.data) }

pub fn timeseries_forecast_naive_slice_max(s : TimeseriesforecastnaiveSlice) -> Double { @_common.max(s.data) }

pub fn timeseries_forecast_naive_slice_to_string(s : TimeseriesforecastnaiveSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

