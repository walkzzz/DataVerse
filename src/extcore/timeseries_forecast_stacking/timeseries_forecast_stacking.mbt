///===
/// extcore/timeseries_forecast_stacking

pub(all) struct TimeseriesforecaststackingPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn timeseries_forecast_stacking_make_point(x : Double, y : Double) -> TimeseriesforecaststackingPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn timeseries_forecast_stacking_make_point3(x : Double, y : Double, z : Double) -> TimeseriesforecaststackingPoint {
  { x, y, z, label: 0 }
}

pub fn TimeseriesforecaststackingPoint::x(self : TimeseriesforecaststackingPoint) -> Double { self.x }

pub fn TimeseriesforecaststackingPoint::y(self : TimeseriesforecaststackingPoint) -> Double { self.y }

pub fn TimeseriesforecaststackingPoint::z(self : TimeseriesforecaststackingPoint) -> Double { self.z }

pub fn TimeseriesforecaststackingPoint::label(self : TimeseriesforecaststackingPoint) -> Int { self.label }

pub fn TimeseriesforecaststackingPoint::dist(self : TimeseriesforecaststackingPoint, other : TimeseriesforecaststackingPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn TimeseriesforecaststackingPoint::add(self : TimeseriesforecaststackingPoint, other : TimeseriesforecaststackingPoint) -> TimeseriesforecaststackingPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn TimeseriesforecaststackingPoint::sub(self : TimeseriesforecaststackingPoint, other : TimeseriesforecaststackingPoint) -> TimeseriesforecaststackingPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn TimeseriesforecaststackingPoint::scale(self : TimeseriesforecaststackingPoint, s : Double) -> TimeseriesforecaststackingPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn TimeseriesforecaststackingPoint::dot(self : TimeseriesforecaststackingPoint, other : TimeseriesforecaststackingPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn TimeseriesforecaststackingPoint::cross(self : TimeseriesforecaststackingPoint, other : TimeseriesforecaststackingPoint) -> TimeseriesforecaststackingPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn TimeseriesforecaststackingPoint::norm(self : TimeseriesforecaststackingPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn TimeseriesforecaststackingPoint::normalize(self : TimeseriesforecaststackingPoint) -> TimeseriesforecaststackingPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn TimeseriesforecaststackingPoint::negate(self : TimeseriesforecaststackingPoint) -> TimeseriesforecaststackingPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn TimeseriesforecaststackingPoint::mid(self : TimeseriesforecaststackingPoint, other : TimeseriesforecaststackingPoint) -> TimeseriesforecaststackingPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn TimeseriesforecaststackingPoint::lerp(self : TimeseriesforecaststackingPoint, other : TimeseriesforecaststackingPoint, t : Double) -> TimeseriesforecaststackingPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn TimeseriesforecaststackingPoint::to_string(self : TimeseriesforecaststackingPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct TimeseriesforecaststackingSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn timeseries_forecast_stacking_make_series(vals : Array[Double], name : String) -> TimeseriesforecaststackingSeries {
  { vals, name, meta: 0 }
}

pub fn TimeseriesforecaststackingSeries::len(self : TimeseriesforecaststackingSeries) -> Int { self.vals.length() }

pub fn TimeseriesforecaststackingSeries::sum(self : TimeseriesforecaststackingSeries) -> Double { @_common.sum(self.vals) }

pub fn TimeseriesforecaststackingSeries::mean(self : TimeseriesforecaststackingSeries) -> Double { @_common.mean(self.vals) }

pub fn TimeseriesforecaststackingSeries::min(self : TimeseriesforecaststackingSeries) -> Double { @_common.min(self.vals) }

pub fn TimeseriesforecaststackingSeries::max(self : TimeseriesforecaststackingSeries) -> Double { @_common.max(self.vals) }

pub fn TimeseriesforecaststackingSeries::range(self : TimeseriesforecaststackingSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn TimeseriesforecaststackingSeries::variance(self : TimeseriesforecaststackingSeries) -> Double { @_common.variance(self.vals) }

pub fn TimeseriesforecaststackingSeries::std(self : TimeseriesforecaststackingSeries) -> Double { @_common.std(self.vals) }

pub fn TimeseriesforecaststackingSeries::median(self : TimeseriesforecaststackingSeries) -> Double { @_common.median(self.vals) }

pub fn TimeseriesforecaststackingSeries::scale(self : TimeseriesforecaststackingSeries, f : Double) -> TimeseriesforecaststackingSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn TimeseriesforecaststackingSeries::add(self : TimeseriesforecaststackingSeries, other : TimeseriesforecaststackingSeries) -> TimeseriesforecaststackingSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn TimeseriesforecaststackingSeries::sub(self : TimeseriesforecaststackingSeries, other : TimeseriesforecaststackingSeries) -> TimeseriesforecaststackingSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn TimeseriesforecaststackingSeries::normalize(self : TimeseriesforecaststackingSeries) -> TimeseriesforecaststackingSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn TimeseriesforecaststackingSeries::cumsum(self : TimeseriesforecaststackingSeries) -> TimeseriesforecaststackingSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn TimeseriesforecaststackingSeries::to_string(self : TimeseriesforecaststackingSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct TimeseriesforecaststackingMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn timeseries_forecast_stacking_make_matrix(rows : Int, cols : Int, val : Double) -> TimeseriesforecaststackingMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn timeseries_forecast_stacking_matrix_identity(n : Int) -> TimeseriesforecaststackingMatrix {
  let m = timeseries_forecast_stacking_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn TimeseriesforecaststackingMatrix::get(self : TimeseriesforecaststackingMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn TimeseriesforecaststackingMatrix::transpose(self : TimeseriesforecaststackingMatrix) -> TimeseriesforecaststackingMatrix {
  let result = timeseries_forecast_stacking_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn TimeseriesforecaststackingMatrix::add(self : TimeseriesforecaststackingMatrix, other : TimeseriesforecaststackingMatrix) -> TimeseriesforecaststackingMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = timeseries_forecast_stacking_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn TimeseriesforecaststackingMatrix::scale(self : TimeseriesforecaststackingMatrix, s : Double) -> TimeseriesforecaststackingMatrix {
  let result = timeseries_forecast_stacking_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn TimeseriesforecaststackingMatrix::multiply(self : TimeseriesforecaststackingMatrix, other : TimeseriesforecaststackingMatrix) -> TimeseriesforecaststackingMatrix {
  if self.cols != other.rows { return timeseries_forecast_stacking_make_matrix(self.rows, other.cols, 0.0) }
  let result = timeseries_forecast_stacking_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn TimeseriesforecaststackingMatrix::trace(self : TimeseriesforecaststackingMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn TimeseriesforecaststackingMatrix::det(self : TimeseriesforecaststackingMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn TimeseriesforecaststackingMatrix::norm(self : TimeseriesforecaststackingMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn TimeseriesforecaststackingMatrix::to_string(self : TimeseriesforecaststackingMatrix) -> String {
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

pub(all) struct TimeseriesforecaststackingVector {
  comps : Array[Double]
  dim : Int
}

pub fn timeseries_forecast_stacking_make_vector(comps : Array[Double]) -> TimeseriesforecaststackingVector {
  { comps, dim: comps.length() }
}

pub fn timeseries_forecast_stacking_vector_zero(dim : Int) -> TimeseriesforecaststackingVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn TimeseriesforecaststackingVector::add(self : TimeseriesforecaststackingVector, other : TimeseriesforecaststackingVector) -> TimeseriesforecaststackingVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn TimeseriesforecaststackingVector::sub(self : TimeseriesforecaststackingVector, other : TimeseriesforecaststackingVector) -> TimeseriesforecaststackingVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn TimeseriesforecaststackingVector::scale(self : TimeseriesforecaststackingVector, s : Double) -> TimeseriesforecaststackingVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn TimeseriesforecaststackingVector::dot(self : TimeseriesforecaststackingVector, other : TimeseriesforecaststackingVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn TimeseriesforecaststackingVector::norm(self : TimeseriesforecaststackingVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn TimeseriesforecaststackingVector::normalize(self : TimeseriesforecaststackingVector) -> TimeseriesforecaststackingVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn TimeseriesforecaststackingVector::dist(self : TimeseriesforecaststackingVector, other : TimeseriesforecaststackingVector) -> Double {
  self.sub(other).norm()
}

pub fn TimeseriesforecaststackingVector::to_string(self : TimeseriesforecaststackingVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn timeseries_forecast_stacking_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn timeseries_forecast_stacking_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn timeseries_forecast_stacking_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn timeseries_forecast_stacking_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn timeseries_forecast_stacking_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn timeseries_forecast_stacking_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn timeseries_forecast_stacking_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn timeseries_forecast_stacking_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn timeseries_forecast_stacking_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn timeseries_forecast_stacking_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn timeseries_forecast_stacking_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn timeseries_forecast_stacking_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn timeseries_forecast_stacking_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn timeseries_forecast_stacking_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn timeseries_forecast_stacking_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn timeseries_forecast_stacking_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn timeseries_forecast_stacking_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn timeseries_forecast_stacking_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn timeseries_forecast_stacking_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn timeseries_forecast_stacking_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn timeseries_forecast_stacking_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn timeseries_forecast_stacking_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn timeseries_forecast_stacking_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn timeseries_forecast_stacking_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn timeseries_forecast_stacking_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn timeseries_forecast_stacking_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn timeseries_forecast_stacking_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn timeseries_forecast_stacking_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn timeseries_forecast_stacking_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct TimeseriesforecaststackingFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_forecast_stacking_frame_make(size : Int) -> TimeseriesforecaststackingFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_forecast_stacking_frame_len(s : TimeseriesforecaststackingFrame) -> Int { s.size }

pub fn timeseries_forecast_stacking_frame_get(s : TimeseriesforecaststackingFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_forecast_stacking_frame_set(s : TimeseriesforecaststackingFrame, i : Int, v : Double) -> TimeseriesforecaststackingFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_stacking_frame_sum(s : TimeseriesforecaststackingFrame) -> Double { @_common.sum(s.data) }

pub fn timeseries_forecast_stacking_frame_mean(s : TimeseriesforecaststackingFrame) -> Double { @_common.mean(s.data) }

pub fn timeseries_forecast_stacking_frame_scale(s : TimeseriesforecaststackingFrame, f : Double) -> TimeseriesforecaststackingFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_stacking_frame_add(a : TimeseriesforecaststackingFrame, b : TimeseriesforecaststackingFrame) -> TimeseriesforecaststackingFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_forecast_stacking_frame_copy(s : TimeseriesforecaststackingFrame) -> TimeseriesforecaststackingFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_stacking_frame_fill(s : TimeseriesforecaststackingFrame, v : Double) -> TimeseriesforecaststackingFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_stacking_frame_min(s : TimeseriesforecaststackingFrame) -> Double { @_common.min(s.data) }

pub fn timeseries_forecast_stacking_frame_max(s : TimeseriesforecaststackingFrame) -> Double { @_common.max(s.data) }

pub fn timeseries_forecast_stacking_frame_to_string(s : TimeseriesforecaststackingFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesforecaststackingTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_forecast_stacking_table_make(size : Int) -> TimeseriesforecaststackingTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_forecast_stacking_table_len(s : TimeseriesforecaststackingTable) -> Int { s.size }

pub fn timeseries_forecast_stacking_table_get(s : TimeseriesforecaststackingTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_forecast_stacking_table_set(s : TimeseriesforecaststackingTable, i : Int, v : Double) -> TimeseriesforecaststackingTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_stacking_table_sum(s : TimeseriesforecaststackingTable) -> Double { @_common.sum(s.data) }

pub fn timeseries_forecast_stacking_table_mean(s : TimeseriesforecaststackingTable) -> Double { @_common.mean(s.data) }

pub fn timeseries_forecast_stacking_table_scale(s : TimeseriesforecaststackingTable, f : Double) -> TimeseriesforecaststackingTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_stacking_table_add(a : TimeseriesforecaststackingTable, b : TimeseriesforecaststackingTable) -> TimeseriesforecaststackingTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_forecast_stacking_table_copy(s : TimeseriesforecaststackingTable) -> TimeseriesforecaststackingTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_stacking_table_fill(s : TimeseriesforecaststackingTable, v : Double) -> TimeseriesforecaststackingTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_stacking_table_min(s : TimeseriesforecaststackingTable) -> Double { @_common.min(s.data) }

pub fn timeseries_forecast_stacking_table_max(s : TimeseriesforecaststackingTable) -> Double { @_common.max(s.data) }

pub fn timeseries_forecast_stacking_table_to_string(s : TimeseriesforecaststackingTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesforecaststackingGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_forecast_stacking_graphn_make(size : Int) -> TimeseriesforecaststackingGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_forecast_stacking_graphn_len(s : TimeseriesforecaststackingGraphN) -> Int { s.size }

pub fn timeseries_forecast_stacking_graphn_get(s : TimeseriesforecaststackingGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_forecast_stacking_graphn_set(s : TimeseriesforecaststackingGraphN, i : Int, v : Double) -> TimeseriesforecaststackingGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_stacking_graphn_sum(s : TimeseriesforecaststackingGraphN) -> Double { @_common.sum(s.data) }

pub fn timeseries_forecast_stacking_graphn_mean(s : TimeseriesforecaststackingGraphN) -> Double { @_common.mean(s.data) }

pub fn timeseries_forecast_stacking_graphn_scale(s : TimeseriesforecaststackingGraphN, f : Double) -> TimeseriesforecaststackingGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_stacking_graphn_add(a : TimeseriesforecaststackingGraphN, b : TimeseriesforecaststackingGraphN) -> TimeseriesforecaststackingGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_forecast_stacking_graphn_copy(s : TimeseriesforecaststackingGraphN) -> TimeseriesforecaststackingGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_stacking_graphn_fill(s : TimeseriesforecaststackingGraphN, v : Double) -> TimeseriesforecaststackingGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_stacking_graphn_min(s : TimeseriesforecaststackingGraphN) -> Double { @_common.min(s.data) }

pub fn timeseries_forecast_stacking_graphn_max(s : TimeseriesforecaststackingGraphN) -> Double { @_common.max(s.data) }

pub fn timeseries_forecast_stacking_graphn_to_string(s : TimeseriesforecaststackingGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesforecaststackingNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_forecast_stacking_node_make(size : Int) -> TimeseriesforecaststackingNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_forecast_stacking_node_len(s : TimeseriesforecaststackingNode) -> Int { s.size }

pub fn timeseries_forecast_stacking_node_get(s : TimeseriesforecaststackingNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_forecast_stacking_node_set(s : TimeseriesforecaststackingNode, i : Int, v : Double) -> TimeseriesforecaststackingNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_stacking_node_sum(s : TimeseriesforecaststackingNode) -> Double { @_common.sum(s.data) }

pub fn timeseries_forecast_stacking_node_mean(s : TimeseriesforecaststackingNode) -> Double { @_common.mean(s.data) }

pub fn timeseries_forecast_stacking_node_scale(s : TimeseriesforecaststackingNode, f : Double) -> TimeseriesforecaststackingNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_stacking_node_add(a : TimeseriesforecaststackingNode, b : TimeseriesforecaststackingNode) -> TimeseriesforecaststackingNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_forecast_stacking_node_copy(s : TimeseriesforecaststackingNode) -> TimeseriesforecaststackingNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_stacking_node_fill(s : TimeseriesforecaststackingNode, v : Double) -> TimeseriesforecaststackingNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_stacking_node_min(s : TimeseriesforecaststackingNode) -> Double { @_common.min(s.data) }

pub fn timeseries_forecast_stacking_node_max(s : TimeseriesforecaststackingNode) -> Double { @_common.max(s.data) }

pub fn timeseries_forecast_stacking_node_to_string(s : TimeseriesforecaststackingNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesforecaststackingEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_forecast_stacking_edge_make(size : Int) -> TimeseriesforecaststackingEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_forecast_stacking_edge_len(s : TimeseriesforecaststackingEdge) -> Int { s.size }

pub fn timeseries_forecast_stacking_edge_get(s : TimeseriesforecaststackingEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_forecast_stacking_edge_set(s : TimeseriesforecaststackingEdge, i : Int, v : Double) -> TimeseriesforecaststackingEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_stacking_edge_sum(s : TimeseriesforecaststackingEdge) -> Double { @_common.sum(s.data) }

pub fn timeseries_forecast_stacking_edge_mean(s : TimeseriesforecaststackingEdge) -> Double { @_common.mean(s.data) }

pub fn timeseries_forecast_stacking_edge_scale(s : TimeseriesforecaststackingEdge, f : Double) -> TimeseriesforecaststackingEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_stacking_edge_add(a : TimeseriesforecaststackingEdge, b : TimeseriesforecaststackingEdge) -> TimeseriesforecaststackingEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_forecast_stacking_edge_copy(s : TimeseriesforecaststackingEdge) -> TimeseriesforecaststackingEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_stacking_edge_fill(s : TimeseriesforecaststackingEdge, v : Double) -> TimeseriesforecaststackingEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_stacking_edge_min(s : TimeseriesforecaststackingEdge) -> Double { @_common.min(s.data) }

pub fn timeseries_forecast_stacking_edge_max(s : TimeseriesforecaststackingEdge) -> Double { @_common.max(s.data) }

pub fn timeseries_forecast_stacking_edge_to_string(s : TimeseriesforecaststackingEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesforecaststackingPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_forecast_stacking_path_make(size : Int) -> TimeseriesforecaststackingPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_forecast_stacking_path_len(s : TimeseriesforecaststackingPath) -> Int { s.size }

pub fn timeseries_forecast_stacking_path_get(s : TimeseriesforecaststackingPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_forecast_stacking_path_set(s : TimeseriesforecaststackingPath, i : Int, v : Double) -> TimeseriesforecaststackingPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_stacking_path_sum(s : TimeseriesforecaststackingPath) -> Double { @_common.sum(s.data) }

pub fn timeseries_forecast_stacking_path_mean(s : TimeseriesforecaststackingPath) -> Double { @_common.mean(s.data) }

pub fn timeseries_forecast_stacking_path_scale(s : TimeseriesforecaststackingPath, f : Double) -> TimeseriesforecaststackingPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_stacking_path_add(a : TimeseriesforecaststackingPath, b : TimeseriesforecaststackingPath) -> TimeseriesforecaststackingPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_forecast_stacking_path_copy(s : TimeseriesforecaststackingPath) -> TimeseriesforecaststackingPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_stacking_path_fill(s : TimeseriesforecaststackingPath, v : Double) -> TimeseriesforecaststackingPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_stacking_path_min(s : TimeseriesforecaststackingPath) -> Double { @_common.min(s.data) }

pub fn timeseries_forecast_stacking_path_max(s : TimeseriesforecaststackingPath) -> Double { @_common.max(s.data) }

pub fn timeseries_forecast_stacking_path_to_string(s : TimeseriesforecaststackingPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesforecaststackingCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_forecast_stacking_cluster_make(size : Int) -> TimeseriesforecaststackingCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_forecast_stacking_cluster_len(s : TimeseriesforecaststackingCluster) -> Int { s.size }

pub fn timeseries_forecast_stacking_cluster_get(s : TimeseriesforecaststackingCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_forecast_stacking_cluster_set(s : TimeseriesforecaststackingCluster, i : Int, v : Double) -> TimeseriesforecaststackingCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_stacking_cluster_sum(s : TimeseriesforecaststackingCluster) -> Double { @_common.sum(s.data) }

pub fn timeseries_forecast_stacking_cluster_mean(s : TimeseriesforecaststackingCluster) -> Double { @_common.mean(s.data) }

pub fn timeseries_forecast_stacking_cluster_scale(s : TimeseriesforecaststackingCluster, f : Double) -> TimeseriesforecaststackingCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_stacking_cluster_add(a : TimeseriesforecaststackingCluster, b : TimeseriesforecaststackingCluster) -> TimeseriesforecaststackingCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_forecast_stacking_cluster_copy(s : TimeseriesforecaststackingCluster) -> TimeseriesforecaststackingCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_stacking_cluster_fill(s : TimeseriesforecaststackingCluster, v : Double) -> TimeseriesforecaststackingCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_stacking_cluster_min(s : TimeseriesforecaststackingCluster) -> Double { @_common.min(s.data) }

pub fn timeseries_forecast_stacking_cluster_max(s : TimeseriesforecaststackingCluster) -> Double { @_common.max(s.data) }

pub fn timeseries_forecast_stacking_cluster_to_string(s : TimeseriesforecaststackingCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesforecaststackingModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_forecast_stacking_model_make(size : Int) -> TimeseriesforecaststackingModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_forecast_stacking_model_len(s : TimeseriesforecaststackingModel) -> Int { s.size }

pub fn timeseries_forecast_stacking_model_get(s : TimeseriesforecaststackingModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_forecast_stacking_model_set(s : TimeseriesforecaststackingModel, i : Int, v : Double) -> TimeseriesforecaststackingModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_stacking_model_sum(s : TimeseriesforecaststackingModel) -> Double { @_common.sum(s.data) }

pub fn timeseries_forecast_stacking_model_mean(s : TimeseriesforecaststackingModel) -> Double { @_common.mean(s.data) }

pub fn timeseries_forecast_stacking_model_scale(s : TimeseriesforecaststackingModel, f : Double) -> TimeseriesforecaststackingModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_stacking_model_add(a : TimeseriesforecaststackingModel, b : TimeseriesforecaststackingModel) -> TimeseriesforecaststackingModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_forecast_stacking_model_copy(s : TimeseriesforecaststackingModel) -> TimeseriesforecaststackingModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_stacking_model_fill(s : TimeseriesforecaststackingModel, v : Double) -> TimeseriesforecaststackingModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_stacking_model_min(s : TimeseriesforecaststackingModel) -> Double { @_common.min(s.data) }

pub fn timeseries_forecast_stacking_model_max(s : TimeseriesforecaststackingModel) -> Double { @_common.max(s.data) }

pub fn timeseries_forecast_stacking_model_to_string(s : TimeseriesforecaststackingModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesforecaststackingLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_forecast_stacking_layer_make(size : Int) -> TimeseriesforecaststackingLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_forecast_stacking_layer_len(s : TimeseriesforecaststackingLayer) -> Int { s.size }

pub fn timeseries_forecast_stacking_layer_get(s : TimeseriesforecaststackingLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_forecast_stacking_layer_set(s : TimeseriesforecaststackingLayer, i : Int, v : Double) -> TimeseriesforecaststackingLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_stacking_layer_sum(s : TimeseriesforecaststackingLayer) -> Double { @_common.sum(s.data) }

pub fn timeseries_forecast_stacking_layer_mean(s : TimeseriesforecaststackingLayer) -> Double { @_common.mean(s.data) }

pub fn timeseries_forecast_stacking_layer_scale(s : TimeseriesforecaststackingLayer, f : Double) -> TimeseriesforecaststackingLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_stacking_layer_add(a : TimeseriesforecaststackingLayer, b : TimeseriesforecaststackingLayer) -> TimeseriesforecaststackingLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_forecast_stacking_layer_copy(s : TimeseriesforecaststackingLayer) -> TimeseriesforecaststackingLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_stacking_layer_fill(s : TimeseriesforecaststackingLayer, v : Double) -> TimeseriesforecaststackingLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_stacking_layer_min(s : TimeseriesforecaststackingLayer) -> Double { @_common.min(s.data) }

pub fn timeseries_forecast_stacking_layer_max(s : TimeseriesforecaststackingLayer) -> Double { @_common.max(s.data) }

pub fn timeseries_forecast_stacking_layer_to_string(s : TimeseriesforecaststackingLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesforecaststackingBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_forecast_stacking_buffer_make(size : Int) -> TimeseriesforecaststackingBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_forecast_stacking_buffer_len(s : TimeseriesforecaststackingBuffer) -> Int { s.size }

pub fn timeseries_forecast_stacking_buffer_get(s : TimeseriesforecaststackingBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_forecast_stacking_buffer_set(s : TimeseriesforecaststackingBuffer, i : Int, v : Double) -> TimeseriesforecaststackingBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_stacking_buffer_sum(s : TimeseriesforecaststackingBuffer) -> Double { @_common.sum(s.data) }

pub fn timeseries_forecast_stacking_buffer_mean(s : TimeseriesforecaststackingBuffer) -> Double { @_common.mean(s.data) }

pub fn timeseries_forecast_stacking_buffer_scale(s : TimeseriesforecaststackingBuffer, f : Double) -> TimeseriesforecaststackingBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_stacking_buffer_add(a : TimeseriesforecaststackingBuffer, b : TimeseriesforecaststackingBuffer) -> TimeseriesforecaststackingBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_forecast_stacking_buffer_copy(s : TimeseriesforecaststackingBuffer) -> TimeseriesforecaststackingBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_stacking_buffer_fill(s : TimeseriesforecaststackingBuffer, v : Double) -> TimeseriesforecaststackingBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_stacking_buffer_min(s : TimeseriesforecaststackingBuffer) -> Double { @_common.min(s.data) }

pub fn timeseries_forecast_stacking_buffer_max(s : TimeseriesforecaststackingBuffer) -> Double { @_common.max(s.data) }

pub fn timeseries_forecast_stacking_buffer_to_string(s : TimeseriesforecaststackingBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesforecaststackingCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_forecast_stacking_cursor_make(size : Int) -> TimeseriesforecaststackingCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_forecast_stacking_cursor_len(s : TimeseriesforecaststackingCursor) -> Int { s.size }

pub fn timeseries_forecast_stacking_cursor_get(s : TimeseriesforecaststackingCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_forecast_stacking_cursor_set(s : TimeseriesforecaststackingCursor, i : Int, v : Double) -> TimeseriesforecaststackingCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_stacking_cursor_sum(s : TimeseriesforecaststackingCursor) -> Double { @_common.sum(s.data) }

pub fn timeseries_forecast_stacking_cursor_mean(s : TimeseriesforecaststackingCursor) -> Double { @_common.mean(s.data) }

pub fn timeseries_forecast_stacking_cursor_scale(s : TimeseriesforecaststackingCursor, f : Double) -> TimeseriesforecaststackingCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_stacking_cursor_add(a : TimeseriesforecaststackingCursor, b : TimeseriesforecaststackingCursor) -> TimeseriesforecaststackingCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_forecast_stacking_cursor_copy(s : TimeseriesforecaststackingCursor) -> TimeseriesforecaststackingCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_stacking_cursor_fill(s : TimeseriesforecaststackingCursor, v : Double) -> TimeseriesforecaststackingCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_stacking_cursor_min(s : TimeseriesforecaststackingCursor) -> Double { @_common.min(s.data) }

pub fn timeseries_forecast_stacking_cursor_max(s : TimeseriesforecaststackingCursor) -> Double { @_common.max(s.data) }

pub fn timeseries_forecast_stacking_cursor_to_string(s : TimeseriesforecaststackingCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesforecaststackingView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_forecast_stacking_view_make(size : Int) -> TimeseriesforecaststackingView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_forecast_stacking_view_len(s : TimeseriesforecaststackingView) -> Int { s.size }

pub fn timeseries_forecast_stacking_view_get(s : TimeseriesforecaststackingView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_forecast_stacking_view_set(s : TimeseriesforecaststackingView, i : Int, v : Double) -> TimeseriesforecaststackingView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_stacking_view_sum(s : TimeseriesforecaststackingView) -> Double { @_common.sum(s.data) }

pub fn timeseries_forecast_stacking_view_mean(s : TimeseriesforecaststackingView) -> Double { @_common.mean(s.data) }

pub fn timeseries_forecast_stacking_view_scale(s : TimeseriesforecaststackingView, f : Double) -> TimeseriesforecaststackingView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_stacking_view_add(a : TimeseriesforecaststackingView, b : TimeseriesforecaststackingView) -> TimeseriesforecaststackingView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_forecast_stacking_view_copy(s : TimeseriesforecaststackingView) -> TimeseriesforecaststackingView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_stacking_view_fill(s : TimeseriesforecaststackingView, v : Double) -> TimeseriesforecaststackingView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_stacking_view_min(s : TimeseriesforecaststackingView) -> Double { @_common.min(s.data) }

pub fn timeseries_forecast_stacking_view_max(s : TimeseriesforecaststackingView) -> Double { @_common.max(s.data) }

pub fn timeseries_forecast_stacking_view_to_string(s : TimeseriesforecaststackingView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesforecaststackingRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_forecast_stacking_range_make(size : Int) -> TimeseriesforecaststackingRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_forecast_stacking_range_len(s : TimeseriesforecaststackingRange) -> Int { s.size }

pub fn timeseries_forecast_stacking_range_get(s : TimeseriesforecaststackingRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_forecast_stacking_range_set(s : TimeseriesforecaststackingRange, i : Int, v : Double) -> TimeseriesforecaststackingRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_stacking_range_sum(s : TimeseriesforecaststackingRange) -> Double { @_common.sum(s.data) }

pub fn timeseries_forecast_stacking_range_mean(s : TimeseriesforecaststackingRange) -> Double { @_common.mean(s.data) }

pub fn timeseries_forecast_stacking_range_scale(s : TimeseriesforecaststackingRange, f : Double) -> TimeseriesforecaststackingRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_stacking_range_add(a : TimeseriesforecaststackingRange, b : TimeseriesforecaststackingRange) -> TimeseriesforecaststackingRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_forecast_stacking_range_copy(s : TimeseriesforecaststackingRange) -> TimeseriesforecaststackingRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_stacking_range_fill(s : TimeseriesforecaststackingRange, v : Double) -> TimeseriesforecaststackingRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_stacking_range_min(s : TimeseriesforecaststackingRange) -> Double { @_common.min(s.data) }

pub fn timeseries_forecast_stacking_range_max(s : TimeseriesforecaststackingRange) -> Double { @_common.max(s.data) }

pub fn timeseries_forecast_stacking_range_to_string(s : TimeseriesforecaststackingRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesforecaststackingSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_forecast_stacking_slice_make(size : Int) -> TimeseriesforecaststackingSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_forecast_stacking_slice_len(s : TimeseriesforecaststackingSlice) -> Int { s.size }

pub fn timeseries_forecast_stacking_slice_get(s : TimeseriesforecaststackingSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_forecast_stacking_slice_set(s : TimeseriesforecaststackingSlice, i : Int, v : Double) -> TimeseriesforecaststackingSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_stacking_slice_sum(s : TimeseriesforecaststackingSlice) -> Double { @_common.sum(s.data) }

pub fn timeseries_forecast_stacking_slice_mean(s : TimeseriesforecaststackingSlice) -> Double { @_common.mean(s.data) }

pub fn timeseries_forecast_stacking_slice_scale(s : TimeseriesforecaststackingSlice, f : Double) -> TimeseriesforecaststackingSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_stacking_slice_add(a : TimeseriesforecaststackingSlice, b : TimeseriesforecaststackingSlice) -> TimeseriesforecaststackingSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_forecast_stacking_slice_copy(s : TimeseriesforecaststackingSlice) -> TimeseriesforecaststackingSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_stacking_slice_fill(s : TimeseriesforecaststackingSlice, v : Double) -> TimeseriesforecaststackingSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_forecast_stacking_slice_min(s : TimeseriesforecaststackingSlice) -> Double { @_common.min(s.data) }

pub fn timeseries_forecast_stacking_slice_max(s : TimeseriesforecaststackingSlice) -> Double { @_common.max(s.data) }

pub fn timeseries_forecast_stacking_slice_to_string(s : TimeseriesforecaststackingSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

