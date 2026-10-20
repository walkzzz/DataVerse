///===
/// extcore/timeseries_forecast_comb

pub(all) struct TimeseriesforecastcombPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn timeseries_forecast_comb_make_point(x : Double, y : Double) -> TimeseriesforecastcombPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn timeseries_forecast_comb_make_point3(x : Double, y : Double, z : Double) -> TimeseriesforecastcombPoint {
  { x, y, z, label: 0 }
}

pub fn TimeseriesforecastcombPoint::x(self : TimeseriesforecastcombPoint) -> Double { self.x }

pub fn TimeseriesforecastcombPoint::y(self : TimeseriesforecastcombPoint) -> Double { self.y }

pub fn TimeseriesforecastcombPoint::z(self : TimeseriesforecastcombPoint) -> Double { self.z }

pub fn TimeseriesforecastcombPoint::label(self : TimeseriesforecastcombPoint) -> Int { self.label }

pub fn TimeseriesforecastcombPoint::dist(self : TimeseriesforecastcombPoint, other : TimeseriesforecastcombPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn TimeseriesforecastcombPoint::add(self : TimeseriesforecastcombPoint, other : TimeseriesforecastcombPoint) -> TimeseriesforecastcombPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn TimeseriesforecastcombPoint::sub(self : TimeseriesforecastcombPoint, other : TimeseriesforecastcombPoint) -> TimeseriesforecastcombPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn TimeseriesforecastcombPoint::scale(self : TimeseriesforecastcombPoint, s : Double) -> TimeseriesforecastcombPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn TimeseriesforecastcombPoint::dot(self : TimeseriesforecastcombPoint, other : TimeseriesforecastcombPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn TimeseriesforecastcombPoint::cross(self : TimeseriesforecastcombPoint, other : TimeseriesforecastcombPoint) -> TimeseriesforecastcombPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn TimeseriesforecastcombPoint::norm(self : TimeseriesforecastcombPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn TimeseriesforecastcombPoint::normalize(self : TimeseriesforecastcombPoint) -> TimeseriesforecastcombPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn TimeseriesforecastcombPoint::negate(self : TimeseriesforecastcombPoint) -> TimeseriesforecastcombPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn TimeseriesforecastcombPoint::mid(self : TimeseriesforecastcombPoint, other : TimeseriesforecastcombPoint) -> TimeseriesforecastcombPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn TimeseriesforecastcombPoint::lerp(self : TimeseriesforecastcombPoint, other : TimeseriesforecastcombPoint, t : Double) -> TimeseriesforecastcombPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn TimeseriesforecastcombPoint::to_string(self : TimeseriesforecastcombPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct TimeseriesforecastcombSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn timeseries_forecast_comb_make_series(vals : Array[Double], name : String) -> TimeseriesforecastcombSeries {
  { vals, name, meta: 0 }
}

pub fn TimeseriesforecastcombSeries::len(self : TimeseriesforecastcombSeries) -> Int { self.vals.length() }

pub fn TimeseriesforecastcombSeries::sum(self : TimeseriesforecastcombSeries) -> Double { @_common.sum(self.vals) }

pub fn TimeseriesforecastcombSeries::mean(self : TimeseriesforecastcombSeries) -> Double { @_common.mean(self.vals) }

pub fn TimeseriesforecastcombSeries::min(self : TimeseriesforecastcombSeries) -> Double { @_common.min(self.vals) }

pub fn TimeseriesforecastcombSeries::max(self : TimeseriesforecastcombSeries) -> Double { @_common.max(self.vals) }

pub fn TimeseriesforecastcombSeries::range(self : TimeseriesforecastcombSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn TimeseriesforecastcombSeries::variance(self : TimeseriesforecastcombSeries) -> Double { @_common.variance(self.vals) }

pub fn TimeseriesforecastcombSeries::std(self : TimeseriesforecastcombSeries) -> Double { @_common.std(self.vals) }

pub fn TimeseriesforecastcombSeries::median(self : TimeseriesforecastcombSeries) -> Double { @_common.median(self.vals) }

pub fn TimeseriesforecastcombSeries::scale(self : TimeseriesforecastcombSeries, f : Double) -> TimeseriesforecastcombSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn TimeseriesforecastcombSeries::add(self : TimeseriesforecastcombSeries, other : TimeseriesforecastcombSeries) -> TimeseriesforecastcombSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn TimeseriesforecastcombSeries::sub(self : TimeseriesforecastcombSeries, other : TimeseriesforecastcombSeries) -> TimeseriesforecastcombSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn TimeseriesforecastcombSeries::normalize(self : TimeseriesforecastcombSeries) -> TimeseriesforecastcombSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn TimeseriesforecastcombSeries::cumsum(self : TimeseriesforecastcombSeries) -> TimeseriesforecastcombSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn TimeseriesforecastcombSeries::to_string(self : TimeseriesforecastcombSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct TimeseriesforecastcombMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn timeseries_forecast_comb_make_matrix(rows : Int, cols : Int, val : Double) -> TimeseriesforecastcombMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn timeseries_forecast_comb_matrix_identity(n : Int) -> TimeseriesforecastcombMatrix {
  let m = timeseries_forecast_comb_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn TimeseriesforecastcombMatrix::get(self : TimeseriesforecastcombMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn TimeseriesforecastcombMatrix::transpose(self : TimeseriesforecastcombMatrix) -> TimeseriesforecastcombMatrix {
  let result = timeseries_forecast_comb_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn TimeseriesforecastcombMatrix::add(self : TimeseriesforecastcombMatrix, other : TimeseriesforecastcombMatrix) -> TimeseriesforecastcombMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = timeseries_forecast_comb_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn TimeseriesforecastcombMatrix::scale(self : TimeseriesforecastcombMatrix, s : Double) -> TimeseriesforecastcombMatrix {
  let result = timeseries_forecast_comb_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn TimeseriesforecastcombMatrix::multiply(self : TimeseriesforecastcombMatrix, other : TimeseriesforecastcombMatrix) -> TimeseriesforecastcombMatrix {
  if self.cols != other.rows { return timeseries_forecast_comb_make_matrix(self.rows, other.cols, 0.0) }
  let result = timeseries_forecast_comb_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn TimeseriesforecastcombMatrix::trace(self : TimeseriesforecastcombMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn TimeseriesforecastcombMatrix::det(self : TimeseriesforecastcombMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn TimeseriesforecastcombMatrix::norm(self : TimeseriesforecastcombMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn TimeseriesforecastcombMatrix::to_string(self : TimeseriesforecastcombMatrix) -> String {
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

pub(all) struct TimeseriesforecastcombVector {
  comps : Array[Double]
  dim : Int
}

pub fn timeseries_forecast_comb_make_vector(comps : Array[Double]) -> TimeseriesforecastcombVector {
  { comps, dim: comps.length() }
}

pub fn timeseries_forecast_comb_vector_zero(dim : Int) -> TimeseriesforecastcombVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn TimeseriesforecastcombVector::add(self : TimeseriesforecastcombVector, other : TimeseriesforecastcombVector) -> TimeseriesforecastcombVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn TimeseriesforecastcombVector::sub(self : TimeseriesforecastcombVector, other : TimeseriesforecastcombVector) -> TimeseriesforecastcombVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn TimeseriesforecastcombVector::scale(self : TimeseriesforecastcombVector, s : Double) -> TimeseriesforecastcombVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn TimeseriesforecastcombVector::dot(self : TimeseriesforecastcombVector, other : TimeseriesforecastcombVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn TimeseriesforecastcombVector::norm(self : TimeseriesforecastcombVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn TimeseriesforecastcombVector::normalize(self : TimeseriesforecastcombVector) -> TimeseriesforecastcombVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn TimeseriesforecastcombVector::dist(self : TimeseriesforecastcombVector, other : TimeseriesforecastcombVector) -> Double {
  self.sub(other).norm()
}

pub fn TimeseriesforecastcombVector::to_string(self : TimeseriesforecastcombVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn timeseries_forecast_comb_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn timeseries_forecast_comb_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn timeseries_forecast_comb_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn timeseries_forecast_comb_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn timeseries_forecast_comb_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn timeseries_forecast_comb_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn timeseries_forecast_comb_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn timeseries_forecast_comb_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn timeseries_forecast_comb_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn timeseries_forecast_comb_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn timeseries_forecast_comb_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn timeseries_forecast_comb_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn timeseries_forecast_comb_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn timeseries_forecast_comb_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn timeseries_forecast_comb_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn timeseries_forecast_comb_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn timeseries_forecast_comb_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn timeseries_forecast_comb_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn timeseries_forecast_comb_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn timeseries_forecast_comb_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn timeseries_forecast_comb_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn timeseries_forecast_comb_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn timeseries_forecast_comb_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn timeseries_forecast_comb_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn timeseries_forecast_comb_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn timeseries_forecast_comb_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn timeseries_forecast_comb_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn timeseries_forecast_comb_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn timeseries_forecast_comb_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct TimeseriesforecastcombFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_forecast_comb_frame_make(size : Int) -> TimeseriesforecastcombFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_forecast_comb_frame_len(s : TimeseriesforecastcombFrame) -> Int { s.size }

pub fn timeseries_forecast_comb_frame_get(s : TimeseriesforecastcombFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_forecast_comb_frame_set(s : TimeseriesforecastcombFrame, i : Int, v : Double) -> TimeseriesforecastcombFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_comb_frame_sum(s : TimeseriesforecastcombFrame) -> Double { @_common.sum(s.data) }

pub fn timeseries_forecast_comb_frame_mean(s : TimeseriesforecastcombFrame) -> Double { @_common.mean(s.data) }

pub fn timeseries_forecast_comb_frame_scale(s : TimeseriesforecastcombFrame, f : Double) -> TimeseriesforecastcombFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_comb_frame_add(a : TimeseriesforecastcombFrame, b : TimeseriesforecastcombFrame) -> TimeseriesforecastcombFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_forecast_comb_frame_copy(s : TimeseriesforecastcombFrame) -> TimeseriesforecastcombFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_comb_frame_fill(s : TimeseriesforecastcombFrame, v : Double) -> TimeseriesforecastcombFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_comb_frame_min(s : TimeseriesforecastcombFrame) -> Double { @_common.min(s.data) }

pub fn timeseries_forecast_comb_frame_max(s : TimeseriesforecastcombFrame) -> Double { @_common.max(s.data) }

pub fn timeseries_forecast_comb_frame_to_string(s : TimeseriesforecastcombFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesforecastcombTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_forecast_comb_table_make(size : Int) -> TimeseriesforecastcombTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_forecast_comb_table_len(s : TimeseriesforecastcombTable) -> Int { s.size }

pub fn timeseries_forecast_comb_table_get(s : TimeseriesforecastcombTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_forecast_comb_table_set(s : TimeseriesforecastcombTable, i : Int, v : Double) -> TimeseriesforecastcombTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_comb_table_sum(s : TimeseriesforecastcombTable) -> Double { @_common.sum(s.data) }

pub fn timeseries_forecast_comb_table_mean(s : TimeseriesforecastcombTable) -> Double { @_common.mean(s.data) }

pub fn timeseries_forecast_comb_table_scale(s : TimeseriesforecastcombTable, f : Double) -> TimeseriesforecastcombTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_comb_table_add(a : TimeseriesforecastcombTable, b : TimeseriesforecastcombTable) -> TimeseriesforecastcombTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_forecast_comb_table_copy(s : TimeseriesforecastcombTable) -> TimeseriesforecastcombTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_comb_table_fill(s : TimeseriesforecastcombTable, v : Double) -> TimeseriesforecastcombTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_comb_table_min(s : TimeseriesforecastcombTable) -> Double { @_common.min(s.data) }

pub fn timeseries_forecast_comb_table_max(s : TimeseriesforecastcombTable) -> Double { @_common.max(s.data) }

pub fn timeseries_forecast_comb_table_to_string(s : TimeseriesforecastcombTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesforecastcombGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_forecast_comb_graphn_make(size : Int) -> TimeseriesforecastcombGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_forecast_comb_graphn_len(s : TimeseriesforecastcombGraphN) -> Int { s.size }

pub fn timeseries_forecast_comb_graphn_get(s : TimeseriesforecastcombGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_forecast_comb_graphn_set(s : TimeseriesforecastcombGraphN, i : Int, v : Double) -> TimeseriesforecastcombGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_comb_graphn_sum(s : TimeseriesforecastcombGraphN) -> Double { @_common.sum(s.data) }

pub fn timeseries_forecast_comb_graphn_mean(s : TimeseriesforecastcombGraphN) -> Double { @_common.mean(s.data) }

pub fn timeseries_forecast_comb_graphn_scale(s : TimeseriesforecastcombGraphN, f : Double) -> TimeseriesforecastcombGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_comb_graphn_add(a : TimeseriesforecastcombGraphN, b : TimeseriesforecastcombGraphN) -> TimeseriesforecastcombGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_forecast_comb_graphn_copy(s : TimeseriesforecastcombGraphN) -> TimeseriesforecastcombGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_comb_graphn_fill(s : TimeseriesforecastcombGraphN, v : Double) -> TimeseriesforecastcombGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_comb_graphn_min(s : TimeseriesforecastcombGraphN) -> Double { @_common.min(s.data) }

pub fn timeseries_forecast_comb_graphn_max(s : TimeseriesforecastcombGraphN) -> Double { @_common.max(s.data) }

pub fn timeseries_forecast_comb_graphn_to_string(s : TimeseriesforecastcombGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesforecastcombNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_forecast_comb_node_make(size : Int) -> TimeseriesforecastcombNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_forecast_comb_node_len(s : TimeseriesforecastcombNode) -> Int { s.size }

pub fn timeseries_forecast_comb_node_get(s : TimeseriesforecastcombNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_forecast_comb_node_set(s : TimeseriesforecastcombNode, i : Int, v : Double) -> TimeseriesforecastcombNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_comb_node_sum(s : TimeseriesforecastcombNode) -> Double { @_common.sum(s.data) }

pub fn timeseries_forecast_comb_node_mean(s : TimeseriesforecastcombNode) -> Double { @_common.mean(s.data) }

pub fn timeseries_forecast_comb_node_scale(s : TimeseriesforecastcombNode, f : Double) -> TimeseriesforecastcombNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_comb_node_add(a : TimeseriesforecastcombNode, b : TimeseriesforecastcombNode) -> TimeseriesforecastcombNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_forecast_comb_node_copy(s : TimeseriesforecastcombNode) -> TimeseriesforecastcombNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_comb_node_fill(s : TimeseriesforecastcombNode, v : Double) -> TimeseriesforecastcombNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_comb_node_min(s : TimeseriesforecastcombNode) -> Double { @_common.min(s.data) }

pub fn timeseries_forecast_comb_node_max(s : TimeseriesforecastcombNode) -> Double { @_common.max(s.data) }

pub fn timeseries_forecast_comb_node_to_string(s : TimeseriesforecastcombNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesforecastcombEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_forecast_comb_edge_make(size : Int) -> TimeseriesforecastcombEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_forecast_comb_edge_len(s : TimeseriesforecastcombEdge) -> Int { s.size }

pub fn timeseries_forecast_comb_edge_get(s : TimeseriesforecastcombEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_forecast_comb_edge_set(s : TimeseriesforecastcombEdge, i : Int, v : Double) -> TimeseriesforecastcombEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_comb_edge_sum(s : TimeseriesforecastcombEdge) -> Double { @_common.sum(s.data) }

pub fn timeseries_forecast_comb_edge_mean(s : TimeseriesforecastcombEdge) -> Double { @_common.mean(s.data) }

pub fn timeseries_forecast_comb_edge_scale(s : TimeseriesforecastcombEdge, f : Double) -> TimeseriesforecastcombEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_comb_edge_add(a : TimeseriesforecastcombEdge, b : TimeseriesforecastcombEdge) -> TimeseriesforecastcombEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_forecast_comb_edge_copy(s : TimeseriesforecastcombEdge) -> TimeseriesforecastcombEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_comb_edge_fill(s : TimeseriesforecastcombEdge, v : Double) -> TimeseriesforecastcombEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_comb_edge_min(s : TimeseriesforecastcombEdge) -> Double { @_common.min(s.data) }

pub fn timeseries_forecast_comb_edge_max(s : TimeseriesforecastcombEdge) -> Double { @_common.max(s.data) }

pub fn timeseries_forecast_comb_edge_to_string(s : TimeseriesforecastcombEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesforecastcombPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_forecast_comb_path_make(size : Int) -> TimeseriesforecastcombPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_forecast_comb_path_len(s : TimeseriesforecastcombPath) -> Int { s.size }

pub fn timeseries_forecast_comb_path_get(s : TimeseriesforecastcombPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_forecast_comb_path_set(s : TimeseriesforecastcombPath, i : Int, v : Double) -> TimeseriesforecastcombPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_comb_path_sum(s : TimeseriesforecastcombPath) -> Double { @_common.sum(s.data) }

pub fn timeseries_forecast_comb_path_mean(s : TimeseriesforecastcombPath) -> Double { @_common.mean(s.data) }

pub fn timeseries_forecast_comb_path_scale(s : TimeseriesforecastcombPath, f : Double) -> TimeseriesforecastcombPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_comb_path_add(a : TimeseriesforecastcombPath, b : TimeseriesforecastcombPath) -> TimeseriesforecastcombPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_forecast_comb_path_copy(s : TimeseriesforecastcombPath) -> TimeseriesforecastcombPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_comb_path_fill(s : TimeseriesforecastcombPath, v : Double) -> TimeseriesforecastcombPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_comb_path_min(s : TimeseriesforecastcombPath) -> Double { @_common.min(s.data) }

pub fn timeseries_forecast_comb_path_max(s : TimeseriesforecastcombPath) -> Double { @_common.max(s.data) }

pub fn timeseries_forecast_comb_path_to_string(s : TimeseriesforecastcombPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesforecastcombCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_forecast_comb_cluster_make(size : Int) -> TimeseriesforecastcombCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_forecast_comb_cluster_len(s : TimeseriesforecastcombCluster) -> Int { s.size }

pub fn timeseries_forecast_comb_cluster_get(s : TimeseriesforecastcombCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_forecast_comb_cluster_set(s : TimeseriesforecastcombCluster, i : Int, v : Double) -> TimeseriesforecastcombCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_comb_cluster_sum(s : TimeseriesforecastcombCluster) -> Double { @_common.sum(s.data) }

pub fn timeseries_forecast_comb_cluster_mean(s : TimeseriesforecastcombCluster) -> Double { @_common.mean(s.data) }

pub fn timeseries_forecast_comb_cluster_scale(s : TimeseriesforecastcombCluster, f : Double) -> TimeseriesforecastcombCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_comb_cluster_add(a : TimeseriesforecastcombCluster, b : TimeseriesforecastcombCluster) -> TimeseriesforecastcombCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_forecast_comb_cluster_copy(s : TimeseriesforecastcombCluster) -> TimeseriesforecastcombCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_comb_cluster_fill(s : TimeseriesforecastcombCluster, v : Double) -> TimeseriesforecastcombCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_comb_cluster_min(s : TimeseriesforecastcombCluster) -> Double { @_common.min(s.data) }

pub fn timeseries_forecast_comb_cluster_max(s : TimeseriesforecastcombCluster) -> Double { @_common.max(s.data) }

pub fn timeseries_forecast_comb_cluster_to_string(s : TimeseriesforecastcombCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesforecastcombModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_forecast_comb_model_make(size : Int) -> TimeseriesforecastcombModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_forecast_comb_model_len(s : TimeseriesforecastcombModel) -> Int { s.size }

pub fn timeseries_forecast_comb_model_get(s : TimeseriesforecastcombModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_forecast_comb_model_set(s : TimeseriesforecastcombModel, i : Int, v : Double) -> TimeseriesforecastcombModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_comb_model_sum(s : TimeseriesforecastcombModel) -> Double { @_common.sum(s.data) }

pub fn timeseries_forecast_comb_model_mean(s : TimeseriesforecastcombModel) -> Double { @_common.mean(s.data) }

pub fn timeseries_forecast_comb_model_scale(s : TimeseriesforecastcombModel, f : Double) -> TimeseriesforecastcombModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_comb_model_add(a : TimeseriesforecastcombModel, b : TimeseriesforecastcombModel) -> TimeseriesforecastcombModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_forecast_comb_model_copy(s : TimeseriesforecastcombModel) -> TimeseriesforecastcombModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_comb_model_fill(s : TimeseriesforecastcombModel, v : Double) -> TimeseriesforecastcombModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_comb_model_min(s : TimeseriesforecastcombModel) -> Double { @_common.min(s.data) }

pub fn timeseries_forecast_comb_model_max(s : TimeseriesforecastcombModel) -> Double { @_common.max(s.data) }

pub fn timeseries_forecast_comb_model_to_string(s : TimeseriesforecastcombModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesforecastcombLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_forecast_comb_layer_make(size : Int) -> TimeseriesforecastcombLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_forecast_comb_layer_len(s : TimeseriesforecastcombLayer) -> Int { s.size }

pub fn timeseries_forecast_comb_layer_get(s : TimeseriesforecastcombLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_forecast_comb_layer_set(s : TimeseriesforecastcombLayer, i : Int, v : Double) -> TimeseriesforecastcombLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_comb_layer_sum(s : TimeseriesforecastcombLayer) -> Double { @_common.sum(s.data) }

pub fn timeseries_forecast_comb_layer_mean(s : TimeseriesforecastcombLayer) -> Double { @_common.mean(s.data) }

pub fn timeseries_forecast_comb_layer_scale(s : TimeseriesforecastcombLayer, f : Double) -> TimeseriesforecastcombLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_comb_layer_add(a : TimeseriesforecastcombLayer, b : TimeseriesforecastcombLayer) -> TimeseriesforecastcombLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_forecast_comb_layer_copy(s : TimeseriesforecastcombLayer) -> TimeseriesforecastcombLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_comb_layer_fill(s : TimeseriesforecastcombLayer, v : Double) -> TimeseriesforecastcombLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_comb_layer_min(s : TimeseriesforecastcombLayer) -> Double { @_common.min(s.data) }

pub fn timeseries_forecast_comb_layer_max(s : TimeseriesforecastcombLayer) -> Double { @_common.max(s.data) }

pub fn timeseries_forecast_comb_layer_to_string(s : TimeseriesforecastcombLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesforecastcombBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_forecast_comb_buffer_make(size : Int) -> TimeseriesforecastcombBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_forecast_comb_buffer_len(s : TimeseriesforecastcombBuffer) -> Int { s.size }

pub fn timeseries_forecast_comb_buffer_get(s : TimeseriesforecastcombBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_forecast_comb_buffer_set(s : TimeseriesforecastcombBuffer, i : Int, v : Double) -> TimeseriesforecastcombBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_comb_buffer_sum(s : TimeseriesforecastcombBuffer) -> Double { @_common.sum(s.data) }

pub fn timeseries_forecast_comb_buffer_mean(s : TimeseriesforecastcombBuffer) -> Double { @_common.mean(s.data) }

pub fn timeseries_forecast_comb_buffer_scale(s : TimeseriesforecastcombBuffer, f : Double) -> TimeseriesforecastcombBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_comb_buffer_add(a : TimeseriesforecastcombBuffer, b : TimeseriesforecastcombBuffer) -> TimeseriesforecastcombBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_forecast_comb_buffer_copy(s : TimeseriesforecastcombBuffer) -> TimeseriesforecastcombBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_comb_buffer_fill(s : TimeseriesforecastcombBuffer, v : Double) -> TimeseriesforecastcombBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_comb_buffer_min(s : TimeseriesforecastcombBuffer) -> Double { @_common.min(s.data) }

pub fn timeseries_forecast_comb_buffer_max(s : TimeseriesforecastcombBuffer) -> Double { @_common.max(s.data) }

pub fn timeseries_forecast_comb_buffer_to_string(s : TimeseriesforecastcombBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesforecastcombCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_forecast_comb_cursor_make(size : Int) -> TimeseriesforecastcombCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_forecast_comb_cursor_len(s : TimeseriesforecastcombCursor) -> Int { s.size }

pub fn timeseries_forecast_comb_cursor_get(s : TimeseriesforecastcombCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_forecast_comb_cursor_set(s : TimeseriesforecastcombCursor, i : Int, v : Double) -> TimeseriesforecastcombCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_comb_cursor_sum(s : TimeseriesforecastcombCursor) -> Double { @_common.sum(s.data) }

pub fn timeseries_forecast_comb_cursor_mean(s : TimeseriesforecastcombCursor) -> Double { @_common.mean(s.data) }

pub fn timeseries_forecast_comb_cursor_scale(s : TimeseriesforecastcombCursor, f : Double) -> TimeseriesforecastcombCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_comb_cursor_add(a : TimeseriesforecastcombCursor, b : TimeseriesforecastcombCursor) -> TimeseriesforecastcombCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_forecast_comb_cursor_copy(s : TimeseriesforecastcombCursor) -> TimeseriesforecastcombCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_comb_cursor_fill(s : TimeseriesforecastcombCursor, v : Double) -> TimeseriesforecastcombCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_comb_cursor_min(s : TimeseriesforecastcombCursor) -> Double { @_common.min(s.data) }

pub fn timeseries_forecast_comb_cursor_max(s : TimeseriesforecastcombCursor) -> Double { @_common.max(s.data) }

pub fn timeseries_forecast_comb_cursor_to_string(s : TimeseriesforecastcombCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesforecastcombView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_forecast_comb_view_make(size : Int) -> TimeseriesforecastcombView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_forecast_comb_view_len(s : TimeseriesforecastcombView) -> Int { s.size }

pub fn timeseries_forecast_comb_view_get(s : TimeseriesforecastcombView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_forecast_comb_view_set(s : TimeseriesforecastcombView, i : Int, v : Double) -> TimeseriesforecastcombView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_comb_view_sum(s : TimeseriesforecastcombView) -> Double { @_common.sum(s.data) }

pub fn timeseries_forecast_comb_view_mean(s : TimeseriesforecastcombView) -> Double { @_common.mean(s.data) }

pub fn timeseries_forecast_comb_view_scale(s : TimeseriesforecastcombView, f : Double) -> TimeseriesforecastcombView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_comb_view_add(a : TimeseriesforecastcombView, b : TimeseriesforecastcombView) -> TimeseriesforecastcombView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_forecast_comb_view_copy(s : TimeseriesforecastcombView) -> TimeseriesforecastcombView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_comb_view_fill(s : TimeseriesforecastcombView, v : Double) -> TimeseriesforecastcombView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_comb_view_min(s : TimeseriesforecastcombView) -> Double { @_common.min(s.data) }

pub fn timeseries_forecast_comb_view_max(s : TimeseriesforecastcombView) -> Double { @_common.max(s.data) }

pub fn timeseries_forecast_comb_view_to_string(s : TimeseriesforecastcombView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesforecastcombRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_forecast_comb_range_make(size : Int) -> TimeseriesforecastcombRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_forecast_comb_range_len(s : TimeseriesforecastcombRange) -> Int { s.size }

pub fn timeseries_forecast_comb_range_get(s : TimeseriesforecastcombRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_forecast_comb_range_set(s : TimeseriesforecastcombRange, i : Int, v : Double) -> TimeseriesforecastcombRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_comb_range_sum(s : TimeseriesforecastcombRange) -> Double { @_common.sum(s.data) }

pub fn timeseries_forecast_comb_range_mean(s : TimeseriesforecastcombRange) -> Double { @_common.mean(s.data) }

pub fn timeseries_forecast_comb_range_scale(s : TimeseriesforecastcombRange, f : Double) -> TimeseriesforecastcombRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_comb_range_add(a : TimeseriesforecastcombRange, b : TimeseriesforecastcombRange) -> TimeseriesforecastcombRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_forecast_comb_range_copy(s : TimeseriesforecastcombRange) -> TimeseriesforecastcombRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_comb_range_fill(s : TimeseriesforecastcombRange, v : Double) -> TimeseriesforecastcombRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_comb_range_min(s : TimeseriesforecastcombRange) -> Double { @_common.min(s.data) }

pub fn timeseries_forecast_comb_range_max(s : TimeseriesforecastcombRange) -> Double { @_common.max(s.data) }

pub fn timeseries_forecast_comb_range_to_string(s : TimeseriesforecastcombRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesforecastcombSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_forecast_comb_slice_make(size : Int) -> TimeseriesforecastcombSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_forecast_comb_slice_len(s : TimeseriesforecastcombSlice) -> Int { s.size }

pub fn timeseries_forecast_comb_slice_get(s : TimeseriesforecastcombSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_forecast_comb_slice_set(s : TimeseriesforecastcombSlice, i : Int, v : Double) -> TimeseriesforecastcombSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_comb_slice_sum(s : TimeseriesforecastcombSlice) -> Double { @_common.sum(s.data) }

pub fn timeseries_forecast_comb_slice_mean(s : TimeseriesforecastcombSlice) -> Double { @_common.mean(s.data) }

pub fn timeseries_forecast_comb_slice_scale(s : TimeseriesforecastcombSlice, f : Double) -> TimeseriesforecastcombSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_comb_slice_add(a : TimeseriesforecastcombSlice, b : TimeseriesforecastcombSlice) -> TimeseriesforecastcombSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_forecast_comb_slice_copy(s : TimeseriesforecastcombSlice) -> TimeseriesforecastcombSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_comb_slice_fill(s : TimeseriesforecastcombSlice, v : Double) -> TimeseriesforecastcombSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_comb_slice_min(s : TimeseriesforecastcombSlice) -> Double { @_common.min(s.data) }

pub fn timeseries_forecast_comb_slice_max(s : TimeseriesforecastcombSlice) -> Double { @_common.max(s.data) }

pub fn timeseries_forecast_comb_slice_to_string(s : TimeseriesforecastcombSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

