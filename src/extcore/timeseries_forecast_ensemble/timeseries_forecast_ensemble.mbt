///===
/// extcore/timeseries_forecast_ensemble

pub(all) struct TimeseriesforecastensemblePoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn timeseries_forecast_ensemble_make_point(x : Double, y : Double) -> TimeseriesforecastensemblePoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn timeseries_forecast_ensemble_make_point3(x : Double, y : Double, z : Double) -> TimeseriesforecastensemblePoint {
  { x, y, z, label: 0 }
}

pub fn TimeseriesforecastensemblePoint::x(self : TimeseriesforecastensemblePoint) -> Double { self.x }

pub fn TimeseriesforecastensemblePoint::y(self : TimeseriesforecastensemblePoint) -> Double { self.y }

pub fn TimeseriesforecastensemblePoint::z(self : TimeseriesforecastensemblePoint) -> Double { self.z }

pub fn TimeseriesforecastensemblePoint::label(self : TimeseriesforecastensemblePoint) -> Int { self.label }

pub fn TimeseriesforecastensemblePoint::dist(self : TimeseriesforecastensemblePoint, other : TimeseriesforecastensemblePoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn TimeseriesforecastensemblePoint::add(self : TimeseriesforecastensemblePoint, other : TimeseriesforecastensemblePoint) -> TimeseriesforecastensemblePoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn TimeseriesforecastensemblePoint::sub(self : TimeseriesforecastensemblePoint, other : TimeseriesforecastensemblePoint) -> TimeseriesforecastensemblePoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn TimeseriesforecastensemblePoint::scale(self : TimeseriesforecastensemblePoint, s : Double) -> TimeseriesforecastensemblePoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn TimeseriesforecastensemblePoint::dot(self : TimeseriesforecastensemblePoint, other : TimeseriesforecastensemblePoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn TimeseriesforecastensemblePoint::cross(self : TimeseriesforecastensemblePoint, other : TimeseriesforecastensemblePoint) -> TimeseriesforecastensemblePoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn TimeseriesforecastensemblePoint::norm(self : TimeseriesforecastensemblePoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn TimeseriesforecastensemblePoint::normalize(self : TimeseriesforecastensemblePoint) -> TimeseriesforecastensemblePoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn TimeseriesforecastensemblePoint::negate(self : TimeseriesforecastensemblePoint) -> TimeseriesforecastensemblePoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn TimeseriesforecastensemblePoint::mid(self : TimeseriesforecastensemblePoint, other : TimeseriesforecastensemblePoint) -> TimeseriesforecastensemblePoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn TimeseriesforecastensemblePoint::lerp(self : TimeseriesforecastensemblePoint, other : TimeseriesforecastensemblePoint, t : Double) -> TimeseriesforecastensemblePoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn TimeseriesforecastensemblePoint::to_string(self : TimeseriesforecastensemblePoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct TimeseriesforecastensembleSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn timeseries_forecast_ensemble_make_series(vals : Array[Double], name : String) -> TimeseriesforecastensembleSeries {
  { vals, name, meta: 0 }
}

pub fn TimeseriesforecastensembleSeries::len(self : TimeseriesforecastensembleSeries) -> Int { self.vals.length() }

pub fn TimeseriesforecastensembleSeries::sum(self : TimeseriesforecastensembleSeries) -> Double { @_common.sum(self.vals) }

pub fn TimeseriesforecastensembleSeries::mean(self : TimeseriesforecastensembleSeries) -> Double { @_common.mean(self.vals) }

pub fn TimeseriesforecastensembleSeries::min(self : TimeseriesforecastensembleSeries) -> Double { @_common.min(self.vals) }

pub fn TimeseriesforecastensembleSeries::max(self : TimeseriesforecastensembleSeries) -> Double { @_common.max(self.vals) }

pub fn TimeseriesforecastensembleSeries::range(self : TimeseriesforecastensembleSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn TimeseriesforecastensembleSeries::variance(self : TimeseriesforecastensembleSeries) -> Double { @_common.variance(self.vals) }

pub fn TimeseriesforecastensembleSeries::std(self : TimeseriesforecastensembleSeries) -> Double { @_common.std(self.vals) }

pub fn TimeseriesforecastensembleSeries::median(self : TimeseriesforecastensembleSeries) -> Double { @_common.median(self.vals) }

pub fn TimeseriesforecastensembleSeries::scale(self : TimeseriesforecastensembleSeries, f : Double) -> TimeseriesforecastensembleSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn TimeseriesforecastensembleSeries::add(self : TimeseriesforecastensembleSeries, other : TimeseriesforecastensembleSeries) -> TimeseriesforecastensembleSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn TimeseriesforecastensembleSeries::sub(self : TimeseriesforecastensembleSeries, other : TimeseriesforecastensembleSeries) -> TimeseriesforecastensembleSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn TimeseriesforecastensembleSeries::normalize(self : TimeseriesforecastensembleSeries) -> TimeseriesforecastensembleSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn TimeseriesforecastensembleSeries::cumsum(self : TimeseriesforecastensembleSeries) -> TimeseriesforecastensembleSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn TimeseriesforecastensembleSeries::to_string(self : TimeseriesforecastensembleSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct TimeseriesforecastensembleMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn timeseries_forecast_ensemble_make_matrix(rows : Int, cols : Int, val : Double) -> TimeseriesforecastensembleMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn timeseries_forecast_ensemble_matrix_identity(n : Int) -> TimeseriesforecastensembleMatrix {
  let m = timeseries_forecast_ensemble_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn TimeseriesforecastensembleMatrix::get(self : TimeseriesforecastensembleMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn TimeseriesforecastensembleMatrix::transpose(self : TimeseriesforecastensembleMatrix) -> TimeseriesforecastensembleMatrix {
  let result = timeseries_forecast_ensemble_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn TimeseriesforecastensembleMatrix::add(self : TimeseriesforecastensembleMatrix, other : TimeseriesforecastensembleMatrix) -> TimeseriesforecastensembleMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = timeseries_forecast_ensemble_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn TimeseriesforecastensembleMatrix::scale(self : TimeseriesforecastensembleMatrix, s : Double) -> TimeseriesforecastensembleMatrix {
  let result = timeseries_forecast_ensemble_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn TimeseriesforecastensembleMatrix::multiply(self : TimeseriesforecastensembleMatrix, other : TimeseriesforecastensembleMatrix) -> TimeseriesforecastensembleMatrix {
  if self.cols != other.rows { return timeseries_forecast_ensemble_make_matrix(self.rows, other.cols, 0.0) }
  let result = timeseries_forecast_ensemble_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn TimeseriesforecastensembleMatrix::trace(self : TimeseriesforecastensembleMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn TimeseriesforecastensembleMatrix::det(self : TimeseriesforecastensembleMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn TimeseriesforecastensembleMatrix::norm(self : TimeseriesforecastensembleMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn TimeseriesforecastensembleMatrix::to_string(self : TimeseriesforecastensembleMatrix) -> String {
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

pub(all) struct TimeseriesforecastensembleVector {
  comps : Array[Double]
  dim : Int
}

pub fn timeseries_forecast_ensemble_make_vector(comps : Array[Double]) -> TimeseriesforecastensembleVector {
  { comps, dim: comps.length() }
}

pub fn timeseries_forecast_ensemble_vector_zero(dim : Int) -> TimeseriesforecastensembleVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn TimeseriesforecastensembleVector::add(self : TimeseriesforecastensembleVector, other : TimeseriesforecastensembleVector) -> TimeseriesforecastensembleVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn TimeseriesforecastensembleVector::sub(self : TimeseriesforecastensembleVector, other : TimeseriesforecastensembleVector) -> TimeseriesforecastensembleVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn TimeseriesforecastensembleVector::scale(self : TimeseriesforecastensembleVector, s : Double) -> TimeseriesforecastensembleVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn TimeseriesforecastensembleVector::dot(self : TimeseriesforecastensembleVector, other : TimeseriesforecastensembleVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn TimeseriesforecastensembleVector::norm(self : TimeseriesforecastensembleVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn TimeseriesforecastensembleVector::normalize(self : TimeseriesforecastensembleVector) -> TimeseriesforecastensembleVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn TimeseriesforecastensembleVector::dist(self : TimeseriesforecastensembleVector, other : TimeseriesforecastensembleVector) -> Double {
  self.sub(other).norm()
}

pub fn TimeseriesforecastensembleVector::to_string(self : TimeseriesforecastensembleVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn timeseries_forecast_ensemble_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn timeseries_forecast_ensemble_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn timeseries_forecast_ensemble_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn timeseries_forecast_ensemble_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn timeseries_forecast_ensemble_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn timeseries_forecast_ensemble_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn timeseries_forecast_ensemble_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn timeseries_forecast_ensemble_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn timeseries_forecast_ensemble_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn timeseries_forecast_ensemble_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn timeseries_forecast_ensemble_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn timeseries_forecast_ensemble_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn timeseries_forecast_ensemble_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn timeseries_forecast_ensemble_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn timeseries_forecast_ensemble_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn timeseries_forecast_ensemble_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn timeseries_forecast_ensemble_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn timeseries_forecast_ensemble_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn timeseries_forecast_ensemble_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn timeseries_forecast_ensemble_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn timeseries_forecast_ensemble_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn timeseries_forecast_ensemble_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn timeseries_forecast_ensemble_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn timeseries_forecast_ensemble_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn timeseries_forecast_ensemble_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn timeseries_forecast_ensemble_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn timeseries_forecast_ensemble_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn timeseries_forecast_ensemble_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn timeseries_forecast_ensemble_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct TimeseriesforecastensembleFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_forecast_ensemble_frame_make(size : Int) -> TimeseriesforecastensembleFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_forecast_ensemble_frame_len(s : TimeseriesforecastensembleFrame) -> Int { s.size }

pub fn timeseries_forecast_ensemble_frame_get(s : TimeseriesforecastensembleFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_forecast_ensemble_frame_set(s : TimeseriesforecastensembleFrame, i : Int, v : Double) -> TimeseriesforecastensembleFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_ensemble_frame_sum(s : TimeseriesforecastensembleFrame) -> Double { @_common.sum(s.data) }

pub fn timeseries_forecast_ensemble_frame_mean(s : TimeseriesforecastensembleFrame) -> Double { @_common.mean(s.data) }

pub fn timeseries_forecast_ensemble_frame_scale(s : TimeseriesforecastensembleFrame, f : Double) -> TimeseriesforecastensembleFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_ensemble_frame_add(a : TimeseriesforecastensembleFrame, b : TimeseriesforecastensembleFrame) -> TimeseriesforecastensembleFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_forecast_ensemble_frame_copy(s : TimeseriesforecastensembleFrame) -> TimeseriesforecastensembleFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_ensemble_frame_fill(s : TimeseriesforecastensembleFrame, v : Double) -> TimeseriesforecastensembleFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_ensemble_frame_min(s : TimeseriesforecastensembleFrame) -> Double { @_common.min(s.data) }

pub fn timeseries_forecast_ensemble_frame_max(s : TimeseriesforecastensembleFrame) -> Double { @_common.max(s.data) }

pub fn timeseries_forecast_ensemble_frame_to_string(s : TimeseriesforecastensembleFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesforecastensembleTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_forecast_ensemble_table_make(size : Int) -> TimeseriesforecastensembleTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_forecast_ensemble_table_len(s : TimeseriesforecastensembleTable) -> Int { s.size }

pub fn timeseries_forecast_ensemble_table_get(s : TimeseriesforecastensembleTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_forecast_ensemble_table_set(s : TimeseriesforecastensembleTable, i : Int, v : Double) -> TimeseriesforecastensembleTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_ensemble_table_sum(s : TimeseriesforecastensembleTable) -> Double { @_common.sum(s.data) }

pub fn timeseries_forecast_ensemble_table_mean(s : TimeseriesforecastensembleTable) -> Double { @_common.mean(s.data) }

pub fn timeseries_forecast_ensemble_table_scale(s : TimeseriesforecastensembleTable, f : Double) -> TimeseriesforecastensembleTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_ensemble_table_add(a : TimeseriesforecastensembleTable, b : TimeseriesforecastensembleTable) -> TimeseriesforecastensembleTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_forecast_ensemble_table_copy(s : TimeseriesforecastensembleTable) -> TimeseriesforecastensembleTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_ensemble_table_fill(s : TimeseriesforecastensembleTable, v : Double) -> TimeseriesforecastensembleTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_ensemble_table_min(s : TimeseriesforecastensembleTable) -> Double { @_common.min(s.data) }

pub fn timeseries_forecast_ensemble_table_max(s : TimeseriesforecastensembleTable) -> Double { @_common.max(s.data) }

pub fn timeseries_forecast_ensemble_table_to_string(s : TimeseriesforecastensembleTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesforecastensembleGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_forecast_ensemble_graphn_make(size : Int) -> TimeseriesforecastensembleGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_forecast_ensemble_graphn_len(s : TimeseriesforecastensembleGraphN) -> Int { s.size }

pub fn timeseries_forecast_ensemble_graphn_get(s : TimeseriesforecastensembleGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_forecast_ensemble_graphn_set(s : TimeseriesforecastensembleGraphN, i : Int, v : Double) -> TimeseriesforecastensembleGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_ensemble_graphn_sum(s : TimeseriesforecastensembleGraphN) -> Double { @_common.sum(s.data) }

pub fn timeseries_forecast_ensemble_graphn_mean(s : TimeseriesforecastensembleGraphN) -> Double { @_common.mean(s.data) }

pub fn timeseries_forecast_ensemble_graphn_scale(s : TimeseriesforecastensembleGraphN, f : Double) -> TimeseriesforecastensembleGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_ensemble_graphn_add(a : TimeseriesforecastensembleGraphN, b : TimeseriesforecastensembleGraphN) -> TimeseriesforecastensembleGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_forecast_ensemble_graphn_copy(s : TimeseriesforecastensembleGraphN) -> TimeseriesforecastensembleGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_ensemble_graphn_fill(s : TimeseriesforecastensembleGraphN, v : Double) -> TimeseriesforecastensembleGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_ensemble_graphn_min(s : TimeseriesforecastensembleGraphN) -> Double { @_common.min(s.data) }

pub fn timeseries_forecast_ensemble_graphn_max(s : TimeseriesforecastensembleGraphN) -> Double { @_common.max(s.data) }

pub fn timeseries_forecast_ensemble_graphn_to_string(s : TimeseriesforecastensembleGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesforecastensembleNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_forecast_ensemble_node_make(size : Int) -> TimeseriesforecastensembleNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_forecast_ensemble_node_len(s : TimeseriesforecastensembleNode) -> Int { s.size }

pub fn timeseries_forecast_ensemble_node_get(s : TimeseriesforecastensembleNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_forecast_ensemble_node_set(s : TimeseriesforecastensembleNode, i : Int, v : Double) -> TimeseriesforecastensembleNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_ensemble_node_sum(s : TimeseriesforecastensembleNode) -> Double { @_common.sum(s.data) }

pub fn timeseries_forecast_ensemble_node_mean(s : TimeseriesforecastensembleNode) -> Double { @_common.mean(s.data) }

pub fn timeseries_forecast_ensemble_node_scale(s : TimeseriesforecastensembleNode, f : Double) -> TimeseriesforecastensembleNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_ensemble_node_add(a : TimeseriesforecastensembleNode, b : TimeseriesforecastensembleNode) -> TimeseriesforecastensembleNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_forecast_ensemble_node_copy(s : TimeseriesforecastensembleNode) -> TimeseriesforecastensembleNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_ensemble_node_fill(s : TimeseriesforecastensembleNode, v : Double) -> TimeseriesforecastensembleNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_ensemble_node_min(s : TimeseriesforecastensembleNode) -> Double { @_common.min(s.data) }

pub fn timeseries_forecast_ensemble_node_max(s : TimeseriesforecastensembleNode) -> Double { @_common.max(s.data) }

pub fn timeseries_forecast_ensemble_node_to_string(s : TimeseriesforecastensembleNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesforecastensembleEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_forecast_ensemble_edge_make(size : Int) -> TimeseriesforecastensembleEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_forecast_ensemble_edge_len(s : TimeseriesforecastensembleEdge) -> Int { s.size }

pub fn timeseries_forecast_ensemble_edge_get(s : TimeseriesforecastensembleEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_forecast_ensemble_edge_set(s : TimeseriesforecastensembleEdge, i : Int, v : Double) -> TimeseriesforecastensembleEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_ensemble_edge_sum(s : TimeseriesforecastensembleEdge) -> Double { @_common.sum(s.data) }

pub fn timeseries_forecast_ensemble_edge_mean(s : TimeseriesforecastensembleEdge) -> Double { @_common.mean(s.data) }

pub fn timeseries_forecast_ensemble_edge_scale(s : TimeseriesforecastensembleEdge, f : Double) -> TimeseriesforecastensembleEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_ensemble_edge_add(a : TimeseriesforecastensembleEdge, b : TimeseriesforecastensembleEdge) -> TimeseriesforecastensembleEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_forecast_ensemble_edge_copy(s : TimeseriesforecastensembleEdge) -> TimeseriesforecastensembleEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_ensemble_edge_fill(s : TimeseriesforecastensembleEdge, v : Double) -> TimeseriesforecastensembleEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_ensemble_edge_min(s : TimeseriesforecastensembleEdge) -> Double { @_common.min(s.data) }

pub fn timeseries_forecast_ensemble_edge_max(s : TimeseriesforecastensembleEdge) -> Double { @_common.max(s.data) }

pub fn timeseries_forecast_ensemble_edge_to_string(s : TimeseriesforecastensembleEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesforecastensemblePath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_forecast_ensemble_path_make(size : Int) -> TimeseriesforecastensemblePath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_forecast_ensemble_path_len(s : TimeseriesforecastensemblePath) -> Int { s.size }

pub fn timeseries_forecast_ensemble_path_get(s : TimeseriesforecastensemblePath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_forecast_ensemble_path_set(s : TimeseriesforecastensemblePath, i : Int, v : Double) -> TimeseriesforecastensemblePath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_ensemble_path_sum(s : TimeseriesforecastensemblePath) -> Double { @_common.sum(s.data) }

pub fn timeseries_forecast_ensemble_path_mean(s : TimeseriesforecastensemblePath) -> Double { @_common.mean(s.data) }

pub fn timeseries_forecast_ensemble_path_scale(s : TimeseriesforecastensemblePath, f : Double) -> TimeseriesforecastensemblePath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_ensemble_path_add(a : TimeseriesforecastensemblePath, b : TimeseriesforecastensemblePath) -> TimeseriesforecastensemblePath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_forecast_ensemble_path_copy(s : TimeseriesforecastensemblePath) -> TimeseriesforecastensemblePath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_ensemble_path_fill(s : TimeseriesforecastensemblePath, v : Double) -> TimeseriesforecastensemblePath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_ensemble_path_min(s : TimeseriesforecastensemblePath) -> Double { @_common.min(s.data) }

pub fn timeseries_forecast_ensemble_path_max(s : TimeseriesforecastensemblePath) -> Double { @_common.max(s.data) }

pub fn timeseries_forecast_ensemble_path_to_string(s : TimeseriesforecastensemblePath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesforecastensembleCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_forecast_ensemble_cluster_make(size : Int) -> TimeseriesforecastensembleCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_forecast_ensemble_cluster_len(s : TimeseriesforecastensembleCluster) -> Int { s.size }

pub fn timeseries_forecast_ensemble_cluster_get(s : TimeseriesforecastensembleCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_forecast_ensemble_cluster_set(s : TimeseriesforecastensembleCluster, i : Int, v : Double) -> TimeseriesforecastensembleCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_ensemble_cluster_sum(s : TimeseriesforecastensembleCluster) -> Double { @_common.sum(s.data) }

pub fn timeseries_forecast_ensemble_cluster_mean(s : TimeseriesforecastensembleCluster) -> Double { @_common.mean(s.data) }

pub fn timeseries_forecast_ensemble_cluster_scale(s : TimeseriesforecastensembleCluster, f : Double) -> TimeseriesforecastensembleCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_ensemble_cluster_add(a : TimeseriesforecastensembleCluster, b : TimeseriesforecastensembleCluster) -> TimeseriesforecastensembleCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_forecast_ensemble_cluster_copy(s : TimeseriesforecastensembleCluster) -> TimeseriesforecastensembleCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_ensemble_cluster_fill(s : TimeseriesforecastensembleCluster, v : Double) -> TimeseriesforecastensembleCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_ensemble_cluster_min(s : TimeseriesforecastensembleCluster) -> Double { @_common.min(s.data) }

pub fn timeseries_forecast_ensemble_cluster_max(s : TimeseriesforecastensembleCluster) -> Double { @_common.max(s.data) }

pub fn timeseries_forecast_ensemble_cluster_to_string(s : TimeseriesforecastensembleCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesforecastensembleModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_forecast_ensemble_model_make(size : Int) -> TimeseriesforecastensembleModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_forecast_ensemble_model_len(s : TimeseriesforecastensembleModel) -> Int { s.size }

pub fn timeseries_forecast_ensemble_model_get(s : TimeseriesforecastensembleModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_forecast_ensemble_model_set(s : TimeseriesforecastensembleModel, i : Int, v : Double) -> TimeseriesforecastensembleModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_ensemble_model_sum(s : TimeseriesforecastensembleModel) -> Double { @_common.sum(s.data) }

pub fn timeseries_forecast_ensemble_model_mean(s : TimeseriesforecastensembleModel) -> Double { @_common.mean(s.data) }

pub fn timeseries_forecast_ensemble_model_scale(s : TimeseriesforecastensembleModel, f : Double) -> TimeseriesforecastensembleModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_ensemble_model_add(a : TimeseriesforecastensembleModel, b : TimeseriesforecastensembleModel) -> TimeseriesforecastensembleModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_forecast_ensemble_model_copy(s : TimeseriesforecastensembleModel) -> TimeseriesforecastensembleModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_ensemble_model_fill(s : TimeseriesforecastensembleModel, v : Double) -> TimeseriesforecastensembleModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_ensemble_model_min(s : TimeseriesforecastensembleModel) -> Double { @_common.min(s.data) }

pub fn timeseries_forecast_ensemble_model_max(s : TimeseriesforecastensembleModel) -> Double { @_common.max(s.data) }

pub fn timeseries_forecast_ensemble_model_to_string(s : TimeseriesforecastensembleModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesforecastensembleLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_forecast_ensemble_layer_make(size : Int) -> TimeseriesforecastensembleLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_forecast_ensemble_layer_len(s : TimeseriesforecastensembleLayer) -> Int { s.size }

pub fn timeseries_forecast_ensemble_layer_get(s : TimeseriesforecastensembleLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_forecast_ensemble_layer_set(s : TimeseriesforecastensembleLayer, i : Int, v : Double) -> TimeseriesforecastensembleLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_ensemble_layer_sum(s : TimeseriesforecastensembleLayer) -> Double { @_common.sum(s.data) }

pub fn timeseries_forecast_ensemble_layer_mean(s : TimeseriesforecastensembleLayer) -> Double { @_common.mean(s.data) }

pub fn timeseries_forecast_ensemble_layer_scale(s : TimeseriesforecastensembleLayer, f : Double) -> TimeseriesforecastensembleLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_ensemble_layer_add(a : TimeseriesforecastensembleLayer, b : TimeseriesforecastensembleLayer) -> TimeseriesforecastensembleLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_forecast_ensemble_layer_copy(s : TimeseriesforecastensembleLayer) -> TimeseriesforecastensembleLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_ensemble_layer_fill(s : TimeseriesforecastensembleLayer, v : Double) -> TimeseriesforecastensembleLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_ensemble_layer_min(s : TimeseriesforecastensembleLayer) -> Double { @_common.min(s.data) }

pub fn timeseries_forecast_ensemble_layer_max(s : TimeseriesforecastensembleLayer) -> Double { @_common.max(s.data) }

pub fn timeseries_forecast_ensemble_layer_to_string(s : TimeseriesforecastensembleLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesforecastensembleBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_forecast_ensemble_buffer_make(size : Int) -> TimeseriesforecastensembleBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_forecast_ensemble_buffer_len(s : TimeseriesforecastensembleBuffer) -> Int { s.size }

pub fn timeseries_forecast_ensemble_buffer_get(s : TimeseriesforecastensembleBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_forecast_ensemble_buffer_set(s : TimeseriesforecastensembleBuffer, i : Int, v : Double) -> TimeseriesforecastensembleBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_ensemble_buffer_sum(s : TimeseriesforecastensembleBuffer) -> Double { @_common.sum(s.data) }

pub fn timeseries_forecast_ensemble_buffer_mean(s : TimeseriesforecastensembleBuffer) -> Double { @_common.mean(s.data) }

pub fn timeseries_forecast_ensemble_buffer_scale(s : TimeseriesforecastensembleBuffer, f : Double) -> TimeseriesforecastensembleBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_ensemble_buffer_add(a : TimeseriesforecastensembleBuffer, b : TimeseriesforecastensembleBuffer) -> TimeseriesforecastensembleBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_forecast_ensemble_buffer_copy(s : TimeseriesforecastensembleBuffer) -> TimeseriesforecastensembleBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_ensemble_buffer_fill(s : TimeseriesforecastensembleBuffer, v : Double) -> TimeseriesforecastensembleBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_ensemble_buffer_min(s : TimeseriesforecastensembleBuffer) -> Double { @_common.min(s.data) }

pub fn timeseries_forecast_ensemble_buffer_max(s : TimeseriesforecastensembleBuffer) -> Double { @_common.max(s.data) }

pub fn timeseries_forecast_ensemble_buffer_to_string(s : TimeseriesforecastensembleBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesforecastensembleCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_forecast_ensemble_cursor_make(size : Int) -> TimeseriesforecastensembleCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_forecast_ensemble_cursor_len(s : TimeseriesforecastensembleCursor) -> Int { s.size }

pub fn timeseries_forecast_ensemble_cursor_get(s : TimeseriesforecastensembleCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_forecast_ensemble_cursor_set(s : TimeseriesforecastensembleCursor, i : Int, v : Double) -> TimeseriesforecastensembleCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_ensemble_cursor_sum(s : TimeseriesforecastensembleCursor) -> Double { @_common.sum(s.data) }

pub fn timeseries_forecast_ensemble_cursor_mean(s : TimeseriesforecastensembleCursor) -> Double { @_common.mean(s.data) }

pub fn timeseries_forecast_ensemble_cursor_scale(s : TimeseriesforecastensembleCursor, f : Double) -> TimeseriesforecastensembleCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_ensemble_cursor_add(a : TimeseriesforecastensembleCursor, b : TimeseriesforecastensembleCursor) -> TimeseriesforecastensembleCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_forecast_ensemble_cursor_copy(s : TimeseriesforecastensembleCursor) -> TimeseriesforecastensembleCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_ensemble_cursor_fill(s : TimeseriesforecastensembleCursor, v : Double) -> TimeseriesforecastensembleCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_ensemble_cursor_min(s : TimeseriesforecastensembleCursor) -> Double { @_common.min(s.data) }

pub fn timeseries_forecast_ensemble_cursor_max(s : TimeseriesforecastensembleCursor) -> Double { @_common.max(s.data) }

pub fn timeseries_forecast_ensemble_cursor_to_string(s : TimeseriesforecastensembleCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesforecastensembleView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_forecast_ensemble_view_make(size : Int) -> TimeseriesforecastensembleView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_forecast_ensemble_view_len(s : TimeseriesforecastensembleView) -> Int { s.size }

pub fn timeseries_forecast_ensemble_view_get(s : TimeseriesforecastensembleView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_forecast_ensemble_view_set(s : TimeseriesforecastensembleView, i : Int, v : Double) -> TimeseriesforecastensembleView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_ensemble_view_sum(s : TimeseriesforecastensembleView) -> Double { @_common.sum(s.data) }

pub fn timeseries_forecast_ensemble_view_mean(s : TimeseriesforecastensembleView) -> Double { @_common.mean(s.data) }

pub fn timeseries_forecast_ensemble_view_scale(s : TimeseriesforecastensembleView, f : Double) -> TimeseriesforecastensembleView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_ensemble_view_add(a : TimeseriesforecastensembleView, b : TimeseriesforecastensembleView) -> TimeseriesforecastensembleView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_forecast_ensemble_view_copy(s : TimeseriesforecastensembleView) -> TimeseriesforecastensembleView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_ensemble_view_fill(s : TimeseriesforecastensembleView, v : Double) -> TimeseriesforecastensembleView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_ensemble_view_min(s : TimeseriesforecastensembleView) -> Double { @_common.min(s.data) }

pub fn timeseries_forecast_ensemble_view_max(s : TimeseriesforecastensembleView) -> Double { @_common.max(s.data) }

pub fn timeseries_forecast_ensemble_view_to_string(s : TimeseriesforecastensembleView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesforecastensembleRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_forecast_ensemble_range_make(size : Int) -> TimeseriesforecastensembleRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_forecast_ensemble_range_len(s : TimeseriesforecastensembleRange) -> Int { s.size }

pub fn timeseries_forecast_ensemble_range_get(s : TimeseriesforecastensembleRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_forecast_ensemble_range_set(s : TimeseriesforecastensembleRange, i : Int, v : Double) -> TimeseriesforecastensembleRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_ensemble_range_sum(s : TimeseriesforecastensembleRange) -> Double { @_common.sum(s.data) }

pub fn timeseries_forecast_ensemble_range_mean(s : TimeseriesforecastensembleRange) -> Double { @_common.mean(s.data) }

pub fn timeseries_forecast_ensemble_range_scale(s : TimeseriesforecastensembleRange, f : Double) -> TimeseriesforecastensembleRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_ensemble_range_add(a : TimeseriesforecastensembleRange, b : TimeseriesforecastensembleRange) -> TimeseriesforecastensembleRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_forecast_ensemble_range_copy(s : TimeseriesforecastensembleRange) -> TimeseriesforecastensembleRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_ensemble_range_fill(s : TimeseriesforecastensembleRange, v : Double) -> TimeseriesforecastensembleRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_ensemble_range_min(s : TimeseriesforecastensembleRange) -> Double { @_common.min(s.data) }

pub fn timeseries_forecast_ensemble_range_max(s : TimeseriesforecastensembleRange) -> Double { @_common.max(s.data) }

pub fn timeseries_forecast_ensemble_range_to_string(s : TimeseriesforecastensembleRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesforecastensembleSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_forecast_ensemble_slice_make(size : Int) -> TimeseriesforecastensembleSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_forecast_ensemble_slice_len(s : TimeseriesforecastensembleSlice) -> Int { s.size }

pub fn timeseries_forecast_ensemble_slice_get(s : TimeseriesforecastensembleSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_forecast_ensemble_slice_set(s : TimeseriesforecastensembleSlice, i : Int, v : Double) -> TimeseriesforecastensembleSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_ensemble_slice_sum(s : TimeseriesforecastensembleSlice) -> Double { @_common.sum(s.data) }

pub fn timeseries_forecast_ensemble_slice_mean(s : TimeseriesforecastensembleSlice) -> Double { @_common.mean(s.data) }

pub fn timeseries_forecast_ensemble_slice_scale(s : TimeseriesforecastensembleSlice, f : Double) -> TimeseriesforecastensembleSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_ensemble_slice_add(a : TimeseriesforecastensembleSlice, b : TimeseriesforecastensembleSlice) -> TimeseriesforecastensembleSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_forecast_ensemble_slice_copy(s : TimeseriesforecastensembleSlice) -> TimeseriesforecastensembleSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_ensemble_slice_fill(s : TimeseriesforecastensembleSlice, v : Double) -> TimeseriesforecastensembleSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_ensemble_slice_min(s : TimeseriesforecastensembleSlice) -> Double { @_common.min(s.data) }

pub fn timeseries_forecast_ensemble_slice_max(s : TimeseriesforecastensembleSlice) -> Double { @_common.max(s.data) }

pub fn timeseries_forecast_ensemble_slice_to_string(s : TimeseriesforecastensembleSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

