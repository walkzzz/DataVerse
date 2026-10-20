///===
/// extcore/timeseries_decomp_beveridge

pub(all) struct TimeseriesdecompbeveridgePoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn timeseries_decomp_beveridge_make_point(x : Double, y : Double) -> TimeseriesdecompbeveridgePoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn timeseries_decomp_beveridge_make_point3(x : Double, y : Double, z : Double) -> TimeseriesdecompbeveridgePoint {
  { x, y, z, label: 0 }
}

pub fn TimeseriesdecompbeveridgePoint::x(self : TimeseriesdecompbeveridgePoint) -> Double { self.x }

pub fn TimeseriesdecompbeveridgePoint::y(self : TimeseriesdecompbeveridgePoint) -> Double { self.y }

pub fn TimeseriesdecompbeveridgePoint::z(self : TimeseriesdecompbeveridgePoint) -> Double { self.z }

pub fn TimeseriesdecompbeveridgePoint::label(self : TimeseriesdecompbeveridgePoint) -> Int { self.label }

pub fn TimeseriesdecompbeveridgePoint::dist(self : TimeseriesdecompbeveridgePoint, other : TimeseriesdecompbeveridgePoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn TimeseriesdecompbeveridgePoint::add(self : TimeseriesdecompbeveridgePoint, other : TimeseriesdecompbeveridgePoint) -> TimeseriesdecompbeveridgePoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn TimeseriesdecompbeveridgePoint::sub(self : TimeseriesdecompbeveridgePoint, other : TimeseriesdecompbeveridgePoint) -> TimeseriesdecompbeveridgePoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn TimeseriesdecompbeveridgePoint::scale(self : TimeseriesdecompbeveridgePoint, s : Double) -> TimeseriesdecompbeveridgePoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn TimeseriesdecompbeveridgePoint::dot(self : TimeseriesdecompbeveridgePoint, other : TimeseriesdecompbeveridgePoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn TimeseriesdecompbeveridgePoint::cross(self : TimeseriesdecompbeveridgePoint, other : TimeseriesdecompbeveridgePoint) -> TimeseriesdecompbeveridgePoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn TimeseriesdecompbeveridgePoint::norm(self : TimeseriesdecompbeveridgePoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn TimeseriesdecompbeveridgePoint::normalize(self : TimeseriesdecompbeveridgePoint) -> TimeseriesdecompbeveridgePoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn TimeseriesdecompbeveridgePoint::negate(self : TimeseriesdecompbeveridgePoint) -> TimeseriesdecompbeveridgePoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn TimeseriesdecompbeveridgePoint::mid(self : TimeseriesdecompbeveridgePoint, other : TimeseriesdecompbeveridgePoint) -> TimeseriesdecompbeveridgePoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn TimeseriesdecompbeveridgePoint::lerp(self : TimeseriesdecompbeveridgePoint, other : TimeseriesdecompbeveridgePoint, t : Double) -> TimeseriesdecompbeveridgePoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn TimeseriesdecompbeveridgePoint::to_string(self : TimeseriesdecompbeveridgePoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct TimeseriesdecompbeveridgeSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn timeseries_decomp_beveridge_make_series(vals : Array[Double], name : String) -> TimeseriesdecompbeveridgeSeries {
  { vals, name, meta: 0 }
}

pub fn TimeseriesdecompbeveridgeSeries::len(self : TimeseriesdecompbeveridgeSeries) -> Int { self.vals.length() }

pub fn TimeseriesdecompbeveridgeSeries::sum(self : TimeseriesdecompbeveridgeSeries) -> Double { @_common.sum(self.vals) }

pub fn TimeseriesdecompbeveridgeSeries::mean(self : TimeseriesdecompbeveridgeSeries) -> Double { @_common.mean(self.vals) }

pub fn TimeseriesdecompbeveridgeSeries::min(self : TimeseriesdecompbeveridgeSeries) -> Double { @_common.min(self.vals) }

pub fn TimeseriesdecompbeveridgeSeries::max(self : TimeseriesdecompbeveridgeSeries) -> Double { @_common.max(self.vals) }

pub fn TimeseriesdecompbeveridgeSeries::range(self : TimeseriesdecompbeveridgeSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn TimeseriesdecompbeveridgeSeries::variance(self : TimeseriesdecompbeveridgeSeries) -> Double { @_common.variance(self.vals) }

pub fn TimeseriesdecompbeveridgeSeries::std(self : TimeseriesdecompbeveridgeSeries) -> Double { @_common.std(self.vals) }

pub fn TimeseriesdecompbeveridgeSeries::median(self : TimeseriesdecompbeveridgeSeries) -> Double { @_common.median(self.vals) }

pub fn TimeseriesdecompbeveridgeSeries::scale(self : TimeseriesdecompbeveridgeSeries, f : Double) -> TimeseriesdecompbeveridgeSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn TimeseriesdecompbeveridgeSeries::add(self : TimeseriesdecompbeveridgeSeries, other : TimeseriesdecompbeveridgeSeries) -> TimeseriesdecompbeveridgeSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn TimeseriesdecompbeveridgeSeries::sub(self : TimeseriesdecompbeveridgeSeries, other : TimeseriesdecompbeveridgeSeries) -> TimeseriesdecompbeveridgeSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn TimeseriesdecompbeveridgeSeries::normalize(self : TimeseriesdecompbeveridgeSeries) -> TimeseriesdecompbeveridgeSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn TimeseriesdecompbeveridgeSeries::cumsum(self : TimeseriesdecompbeveridgeSeries) -> TimeseriesdecompbeveridgeSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn TimeseriesdecompbeveridgeSeries::to_string(self : TimeseriesdecompbeveridgeSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct TimeseriesdecompbeveridgeMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn timeseries_decomp_beveridge_make_matrix(rows : Int, cols : Int, val : Double) -> TimeseriesdecompbeveridgeMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn timeseries_decomp_beveridge_matrix_identity(n : Int) -> TimeseriesdecompbeveridgeMatrix {
  let m = timeseries_decomp_beveridge_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn TimeseriesdecompbeveridgeMatrix::get(self : TimeseriesdecompbeveridgeMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn TimeseriesdecompbeveridgeMatrix::transpose(self : TimeseriesdecompbeveridgeMatrix) -> TimeseriesdecompbeveridgeMatrix {
  let result = timeseries_decomp_beveridge_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn TimeseriesdecompbeveridgeMatrix::add(self : TimeseriesdecompbeveridgeMatrix, other : TimeseriesdecompbeveridgeMatrix) -> TimeseriesdecompbeveridgeMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = timeseries_decomp_beveridge_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn TimeseriesdecompbeveridgeMatrix::scale(self : TimeseriesdecompbeveridgeMatrix, s : Double) -> TimeseriesdecompbeveridgeMatrix {
  let result = timeseries_decomp_beveridge_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn TimeseriesdecompbeveridgeMatrix::multiply(self : TimeseriesdecompbeveridgeMatrix, other : TimeseriesdecompbeveridgeMatrix) -> TimeseriesdecompbeveridgeMatrix {
  if self.cols != other.rows { return timeseries_decomp_beveridge_make_matrix(self.rows, other.cols, 0.0) }
  let result = timeseries_decomp_beveridge_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn TimeseriesdecompbeveridgeMatrix::trace(self : TimeseriesdecompbeveridgeMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn TimeseriesdecompbeveridgeMatrix::det(self : TimeseriesdecompbeveridgeMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn TimeseriesdecompbeveridgeMatrix::norm(self : TimeseriesdecompbeveridgeMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn TimeseriesdecompbeveridgeMatrix::to_string(self : TimeseriesdecompbeveridgeMatrix) -> String {
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

pub(all) struct TimeseriesdecompbeveridgeVector {
  comps : Array[Double]
  dim : Int
}

pub fn timeseries_decomp_beveridge_make_vector(comps : Array[Double]) -> TimeseriesdecompbeveridgeVector {
  { comps, dim: comps.length() }
}

pub fn timeseries_decomp_beveridge_vector_zero(dim : Int) -> TimeseriesdecompbeveridgeVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn TimeseriesdecompbeveridgeVector::add(self : TimeseriesdecompbeveridgeVector, other : TimeseriesdecompbeveridgeVector) -> TimeseriesdecompbeveridgeVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn TimeseriesdecompbeveridgeVector::sub(self : TimeseriesdecompbeveridgeVector, other : TimeseriesdecompbeveridgeVector) -> TimeseriesdecompbeveridgeVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn TimeseriesdecompbeveridgeVector::scale(self : TimeseriesdecompbeveridgeVector, s : Double) -> TimeseriesdecompbeveridgeVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn TimeseriesdecompbeveridgeVector::dot(self : TimeseriesdecompbeveridgeVector, other : TimeseriesdecompbeveridgeVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn TimeseriesdecompbeveridgeVector::norm(self : TimeseriesdecompbeveridgeVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn TimeseriesdecompbeveridgeVector::normalize(self : TimeseriesdecompbeveridgeVector) -> TimeseriesdecompbeveridgeVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn TimeseriesdecompbeveridgeVector::dist(self : TimeseriesdecompbeveridgeVector, other : TimeseriesdecompbeveridgeVector) -> Double {
  self.sub(other).norm()
}

pub fn TimeseriesdecompbeveridgeVector::to_string(self : TimeseriesdecompbeveridgeVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn timeseries_decomp_beveridge_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn timeseries_decomp_beveridge_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn timeseries_decomp_beveridge_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn timeseries_decomp_beveridge_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn timeseries_decomp_beveridge_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn timeseries_decomp_beveridge_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn timeseries_decomp_beveridge_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn timeseries_decomp_beveridge_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn timeseries_decomp_beveridge_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn timeseries_decomp_beveridge_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn timeseries_decomp_beveridge_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn timeseries_decomp_beveridge_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn timeseries_decomp_beveridge_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn timeseries_decomp_beveridge_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn timeseries_decomp_beveridge_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn timeseries_decomp_beveridge_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn timeseries_decomp_beveridge_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn timeseries_decomp_beveridge_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn timeseries_decomp_beveridge_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn timeseries_decomp_beveridge_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn timeseries_decomp_beveridge_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn timeseries_decomp_beveridge_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn timeseries_decomp_beveridge_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn timeseries_decomp_beveridge_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn timeseries_decomp_beveridge_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn timeseries_decomp_beveridge_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn timeseries_decomp_beveridge_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn timeseries_decomp_beveridge_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn timeseries_decomp_beveridge_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct TimeseriesdecompbeveridgeFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_decomp_beveridge_frame_make(size : Int) -> TimeseriesdecompbeveridgeFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_decomp_beveridge_frame_len(s : TimeseriesdecompbeveridgeFrame) -> Int { s.size }

pub fn timeseries_decomp_beveridge_frame_get(s : TimeseriesdecompbeveridgeFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_decomp_beveridge_frame_set(s : TimeseriesdecompbeveridgeFrame, i : Int, v : Double) -> TimeseriesdecompbeveridgeFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_beveridge_frame_sum(s : TimeseriesdecompbeveridgeFrame) -> Double { @_common.sum(s.data) }

pub fn timeseries_decomp_beveridge_frame_mean(s : TimeseriesdecompbeveridgeFrame) -> Double { @_common.mean(s.data) }

pub fn timeseries_decomp_beveridge_frame_scale(s : TimeseriesdecompbeveridgeFrame, f : Double) -> TimeseriesdecompbeveridgeFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_beveridge_frame_add(a : TimeseriesdecompbeveridgeFrame, b : TimeseriesdecompbeveridgeFrame) -> TimeseriesdecompbeveridgeFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_decomp_beveridge_frame_copy(s : TimeseriesdecompbeveridgeFrame) -> TimeseriesdecompbeveridgeFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_beveridge_frame_fill(s : TimeseriesdecompbeveridgeFrame, v : Double) -> TimeseriesdecompbeveridgeFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_beveridge_frame_min(s : TimeseriesdecompbeveridgeFrame) -> Double { @_common.min(s.data) }

pub fn timeseries_decomp_beveridge_frame_max(s : TimeseriesdecompbeveridgeFrame) -> Double { @_common.max(s.data) }

pub fn timeseries_decomp_beveridge_frame_to_string(s : TimeseriesdecompbeveridgeFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesdecompbeveridgeTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_decomp_beveridge_table_make(size : Int) -> TimeseriesdecompbeveridgeTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_decomp_beveridge_table_len(s : TimeseriesdecompbeveridgeTable) -> Int { s.size }

pub fn timeseries_decomp_beveridge_table_get(s : TimeseriesdecompbeveridgeTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_decomp_beveridge_table_set(s : TimeseriesdecompbeveridgeTable, i : Int, v : Double) -> TimeseriesdecompbeveridgeTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_beveridge_table_sum(s : TimeseriesdecompbeveridgeTable) -> Double { @_common.sum(s.data) }

pub fn timeseries_decomp_beveridge_table_mean(s : TimeseriesdecompbeveridgeTable) -> Double { @_common.mean(s.data) }

pub fn timeseries_decomp_beveridge_table_scale(s : TimeseriesdecompbeveridgeTable, f : Double) -> TimeseriesdecompbeveridgeTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_beveridge_table_add(a : TimeseriesdecompbeveridgeTable, b : TimeseriesdecompbeveridgeTable) -> TimeseriesdecompbeveridgeTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_decomp_beveridge_table_copy(s : TimeseriesdecompbeveridgeTable) -> TimeseriesdecompbeveridgeTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_beveridge_table_fill(s : TimeseriesdecompbeveridgeTable, v : Double) -> TimeseriesdecompbeveridgeTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_beveridge_table_min(s : TimeseriesdecompbeveridgeTable) -> Double { @_common.min(s.data) }

pub fn timeseries_decomp_beveridge_table_max(s : TimeseriesdecompbeveridgeTable) -> Double { @_common.max(s.data) }

pub fn timeseries_decomp_beveridge_table_to_string(s : TimeseriesdecompbeveridgeTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesdecompbeveridgeGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_decomp_beveridge_graphn_make(size : Int) -> TimeseriesdecompbeveridgeGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_decomp_beveridge_graphn_len(s : TimeseriesdecompbeveridgeGraphN) -> Int { s.size }

pub fn timeseries_decomp_beveridge_graphn_get(s : TimeseriesdecompbeveridgeGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_decomp_beveridge_graphn_set(s : TimeseriesdecompbeveridgeGraphN, i : Int, v : Double) -> TimeseriesdecompbeveridgeGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_beveridge_graphn_sum(s : TimeseriesdecompbeveridgeGraphN) -> Double { @_common.sum(s.data) }

pub fn timeseries_decomp_beveridge_graphn_mean(s : TimeseriesdecompbeveridgeGraphN) -> Double { @_common.mean(s.data) }

pub fn timeseries_decomp_beveridge_graphn_scale(s : TimeseriesdecompbeveridgeGraphN, f : Double) -> TimeseriesdecompbeveridgeGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_beveridge_graphn_add(a : TimeseriesdecompbeveridgeGraphN, b : TimeseriesdecompbeveridgeGraphN) -> TimeseriesdecompbeveridgeGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_decomp_beveridge_graphn_copy(s : TimeseriesdecompbeveridgeGraphN) -> TimeseriesdecompbeveridgeGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_beveridge_graphn_fill(s : TimeseriesdecompbeveridgeGraphN, v : Double) -> TimeseriesdecompbeveridgeGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_beveridge_graphn_min(s : TimeseriesdecompbeveridgeGraphN) -> Double { @_common.min(s.data) }

pub fn timeseries_decomp_beveridge_graphn_max(s : TimeseriesdecompbeveridgeGraphN) -> Double { @_common.max(s.data) }

pub fn timeseries_decomp_beveridge_graphn_to_string(s : TimeseriesdecompbeveridgeGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesdecompbeveridgeNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_decomp_beveridge_node_make(size : Int) -> TimeseriesdecompbeveridgeNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_decomp_beveridge_node_len(s : TimeseriesdecompbeveridgeNode) -> Int { s.size }

pub fn timeseries_decomp_beveridge_node_get(s : TimeseriesdecompbeveridgeNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_decomp_beveridge_node_set(s : TimeseriesdecompbeveridgeNode, i : Int, v : Double) -> TimeseriesdecompbeveridgeNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_beveridge_node_sum(s : TimeseriesdecompbeveridgeNode) -> Double { @_common.sum(s.data) }

pub fn timeseries_decomp_beveridge_node_mean(s : TimeseriesdecompbeveridgeNode) -> Double { @_common.mean(s.data) }

pub fn timeseries_decomp_beveridge_node_scale(s : TimeseriesdecompbeveridgeNode, f : Double) -> TimeseriesdecompbeveridgeNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_beveridge_node_add(a : TimeseriesdecompbeveridgeNode, b : TimeseriesdecompbeveridgeNode) -> TimeseriesdecompbeveridgeNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_decomp_beveridge_node_copy(s : TimeseriesdecompbeveridgeNode) -> TimeseriesdecompbeveridgeNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_beveridge_node_fill(s : TimeseriesdecompbeveridgeNode, v : Double) -> TimeseriesdecompbeveridgeNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_beveridge_node_min(s : TimeseriesdecompbeveridgeNode) -> Double { @_common.min(s.data) }

pub fn timeseries_decomp_beveridge_node_max(s : TimeseriesdecompbeveridgeNode) -> Double { @_common.max(s.data) }

pub fn timeseries_decomp_beveridge_node_to_string(s : TimeseriesdecompbeveridgeNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesdecompbeveridgeEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_decomp_beveridge_edge_make(size : Int) -> TimeseriesdecompbeveridgeEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_decomp_beveridge_edge_len(s : TimeseriesdecompbeveridgeEdge) -> Int { s.size }

pub fn timeseries_decomp_beveridge_edge_get(s : TimeseriesdecompbeveridgeEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_decomp_beveridge_edge_set(s : TimeseriesdecompbeveridgeEdge, i : Int, v : Double) -> TimeseriesdecompbeveridgeEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_beveridge_edge_sum(s : TimeseriesdecompbeveridgeEdge) -> Double { @_common.sum(s.data) }

pub fn timeseries_decomp_beveridge_edge_mean(s : TimeseriesdecompbeveridgeEdge) -> Double { @_common.mean(s.data) }

pub fn timeseries_decomp_beveridge_edge_scale(s : TimeseriesdecompbeveridgeEdge, f : Double) -> TimeseriesdecompbeveridgeEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_beveridge_edge_add(a : TimeseriesdecompbeveridgeEdge, b : TimeseriesdecompbeveridgeEdge) -> TimeseriesdecompbeveridgeEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_decomp_beveridge_edge_copy(s : TimeseriesdecompbeveridgeEdge) -> TimeseriesdecompbeveridgeEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_beveridge_edge_fill(s : TimeseriesdecompbeveridgeEdge, v : Double) -> TimeseriesdecompbeveridgeEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_beveridge_edge_min(s : TimeseriesdecompbeveridgeEdge) -> Double { @_common.min(s.data) }

pub fn timeseries_decomp_beveridge_edge_max(s : TimeseriesdecompbeveridgeEdge) -> Double { @_common.max(s.data) }

pub fn timeseries_decomp_beveridge_edge_to_string(s : TimeseriesdecompbeveridgeEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesdecompbeveridgePath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_decomp_beveridge_path_make(size : Int) -> TimeseriesdecompbeveridgePath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_decomp_beveridge_path_len(s : TimeseriesdecompbeveridgePath) -> Int { s.size }

pub fn timeseries_decomp_beveridge_path_get(s : TimeseriesdecompbeveridgePath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_decomp_beveridge_path_set(s : TimeseriesdecompbeveridgePath, i : Int, v : Double) -> TimeseriesdecompbeveridgePath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_beveridge_path_sum(s : TimeseriesdecompbeveridgePath) -> Double { @_common.sum(s.data) }

pub fn timeseries_decomp_beveridge_path_mean(s : TimeseriesdecompbeveridgePath) -> Double { @_common.mean(s.data) }

pub fn timeseries_decomp_beveridge_path_scale(s : TimeseriesdecompbeveridgePath, f : Double) -> TimeseriesdecompbeveridgePath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_beveridge_path_add(a : TimeseriesdecompbeveridgePath, b : TimeseriesdecompbeveridgePath) -> TimeseriesdecompbeveridgePath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_decomp_beveridge_path_copy(s : TimeseriesdecompbeveridgePath) -> TimeseriesdecompbeveridgePath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_beveridge_path_fill(s : TimeseriesdecompbeveridgePath, v : Double) -> TimeseriesdecompbeveridgePath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_beveridge_path_min(s : TimeseriesdecompbeveridgePath) -> Double { @_common.min(s.data) }

pub fn timeseries_decomp_beveridge_path_max(s : TimeseriesdecompbeveridgePath) -> Double { @_common.max(s.data) }

pub fn timeseries_decomp_beveridge_path_to_string(s : TimeseriesdecompbeveridgePath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesdecompbeveridgeCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_decomp_beveridge_cluster_make(size : Int) -> TimeseriesdecompbeveridgeCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_decomp_beveridge_cluster_len(s : TimeseriesdecompbeveridgeCluster) -> Int { s.size }

pub fn timeseries_decomp_beveridge_cluster_get(s : TimeseriesdecompbeveridgeCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_decomp_beveridge_cluster_set(s : TimeseriesdecompbeveridgeCluster, i : Int, v : Double) -> TimeseriesdecompbeveridgeCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_beveridge_cluster_sum(s : TimeseriesdecompbeveridgeCluster) -> Double { @_common.sum(s.data) }

pub fn timeseries_decomp_beveridge_cluster_mean(s : TimeseriesdecompbeveridgeCluster) -> Double { @_common.mean(s.data) }

pub fn timeseries_decomp_beveridge_cluster_scale(s : TimeseriesdecompbeveridgeCluster, f : Double) -> TimeseriesdecompbeveridgeCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_beveridge_cluster_add(a : TimeseriesdecompbeveridgeCluster, b : TimeseriesdecompbeveridgeCluster) -> TimeseriesdecompbeveridgeCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_decomp_beveridge_cluster_copy(s : TimeseriesdecompbeveridgeCluster) -> TimeseriesdecompbeveridgeCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_beveridge_cluster_fill(s : TimeseriesdecompbeveridgeCluster, v : Double) -> TimeseriesdecompbeveridgeCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_beveridge_cluster_min(s : TimeseriesdecompbeveridgeCluster) -> Double { @_common.min(s.data) }

pub fn timeseries_decomp_beveridge_cluster_max(s : TimeseriesdecompbeveridgeCluster) -> Double { @_common.max(s.data) }

pub fn timeseries_decomp_beveridge_cluster_to_string(s : TimeseriesdecompbeveridgeCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesdecompbeveridgeModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_decomp_beveridge_model_make(size : Int) -> TimeseriesdecompbeveridgeModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_decomp_beveridge_model_len(s : TimeseriesdecompbeveridgeModel) -> Int { s.size }

pub fn timeseries_decomp_beveridge_model_get(s : TimeseriesdecompbeveridgeModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_decomp_beveridge_model_set(s : TimeseriesdecompbeveridgeModel, i : Int, v : Double) -> TimeseriesdecompbeveridgeModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_beveridge_model_sum(s : TimeseriesdecompbeveridgeModel) -> Double { @_common.sum(s.data) }

pub fn timeseries_decomp_beveridge_model_mean(s : TimeseriesdecompbeveridgeModel) -> Double { @_common.mean(s.data) }

pub fn timeseries_decomp_beveridge_model_scale(s : TimeseriesdecompbeveridgeModel, f : Double) -> TimeseriesdecompbeveridgeModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_beveridge_model_add(a : TimeseriesdecompbeveridgeModel, b : TimeseriesdecompbeveridgeModel) -> TimeseriesdecompbeveridgeModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_decomp_beveridge_model_copy(s : TimeseriesdecompbeveridgeModel) -> TimeseriesdecompbeveridgeModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_beveridge_model_fill(s : TimeseriesdecompbeveridgeModel, v : Double) -> TimeseriesdecompbeveridgeModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_beveridge_model_min(s : TimeseriesdecompbeveridgeModel) -> Double { @_common.min(s.data) }

pub fn timeseries_decomp_beveridge_model_max(s : TimeseriesdecompbeveridgeModel) -> Double { @_common.max(s.data) }

pub fn timeseries_decomp_beveridge_model_to_string(s : TimeseriesdecompbeveridgeModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesdecompbeveridgeLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_decomp_beveridge_layer_make(size : Int) -> TimeseriesdecompbeveridgeLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_decomp_beveridge_layer_len(s : TimeseriesdecompbeveridgeLayer) -> Int { s.size }

pub fn timeseries_decomp_beveridge_layer_get(s : TimeseriesdecompbeveridgeLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_decomp_beveridge_layer_set(s : TimeseriesdecompbeveridgeLayer, i : Int, v : Double) -> TimeseriesdecompbeveridgeLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_beveridge_layer_sum(s : TimeseriesdecompbeveridgeLayer) -> Double { @_common.sum(s.data) }

pub fn timeseries_decomp_beveridge_layer_mean(s : TimeseriesdecompbeveridgeLayer) -> Double { @_common.mean(s.data) }

pub fn timeseries_decomp_beveridge_layer_scale(s : TimeseriesdecompbeveridgeLayer, f : Double) -> TimeseriesdecompbeveridgeLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_beveridge_layer_add(a : TimeseriesdecompbeveridgeLayer, b : TimeseriesdecompbeveridgeLayer) -> TimeseriesdecompbeveridgeLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_decomp_beveridge_layer_copy(s : TimeseriesdecompbeveridgeLayer) -> TimeseriesdecompbeveridgeLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_beveridge_layer_fill(s : TimeseriesdecompbeveridgeLayer, v : Double) -> TimeseriesdecompbeveridgeLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_beveridge_layer_min(s : TimeseriesdecompbeveridgeLayer) -> Double { @_common.min(s.data) }

pub fn timeseries_decomp_beveridge_layer_max(s : TimeseriesdecompbeveridgeLayer) -> Double { @_common.max(s.data) }

pub fn timeseries_decomp_beveridge_layer_to_string(s : TimeseriesdecompbeveridgeLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesdecompbeveridgeBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_decomp_beveridge_buffer_make(size : Int) -> TimeseriesdecompbeveridgeBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_decomp_beveridge_buffer_len(s : TimeseriesdecompbeveridgeBuffer) -> Int { s.size }

pub fn timeseries_decomp_beveridge_buffer_get(s : TimeseriesdecompbeveridgeBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_decomp_beveridge_buffer_set(s : TimeseriesdecompbeveridgeBuffer, i : Int, v : Double) -> TimeseriesdecompbeveridgeBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_beveridge_buffer_sum(s : TimeseriesdecompbeveridgeBuffer) -> Double { @_common.sum(s.data) }

pub fn timeseries_decomp_beveridge_buffer_mean(s : TimeseriesdecompbeveridgeBuffer) -> Double { @_common.mean(s.data) }

pub fn timeseries_decomp_beveridge_buffer_scale(s : TimeseriesdecompbeveridgeBuffer, f : Double) -> TimeseriesdecompbeveridgeBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_beveridge_buffer_add(a : TimeseriesdecompbeveridgeBuffer, b : TimeseriesdecompbeveridgeBuffer) -> TimeseriesdecompbeveridgeBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_decomp_beveridge_buffer_copy(s : TimeseriesdecompbeveridgeBuffer) -> TimeseriesdecompbeveridgeBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_beveridge_buffer_fill(s : TimeseriesdecompbeveridgeBuffer, v : Double) -> TimeseriesdecompbeveridgeBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_beveridge_buffer_min(s : TimeseriesdecompbeveridgeBuffer) -> Double { @_common.min(s.data) }

pub fn timeseries_decomp_beveridge_buffer_max(s : TimeseriesdecompbeveridgeBuffer) -> Double { @_common.max(s.data) }

pub fn timeseries_decomp_beveridge_buffer_to_string(s : TimeseriesdecompbeveridgeBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesdecompbeveridgeCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_decomp_beveridge_cursor_make(size : Int) -> TimeseriesdecompbeveridgeCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_decomp_beveridge_cursor_len(s : TimeseriesdecompbeveridgeCursor) -> Int { s.size }

pub fn timeseries_decomp_beveridge_cursor_get(s : TimeseriesdecompbeveridgeCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_decomp_beveridge_cursor_set(s : TimeseriesdecompbeveridgeCursor, i : Int, v : Double) -> TimeseriesdecompbeveridgeCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_beveridge_cursor_sum(s : TimeseriesdecompbeveridgeCursor) -> Double { @_common.sum(s.data) }

pub fn timeseries_decomp_beveridge_cursor_mean(s : TimeseriesdecompbeveridgeCursor) -> Double { @_common.mean(s.data) }

pub fn timeseries_decomp_beveridge_cursor_scale(s : TimeseriesdecompbeveridgeCursor, f : Double) -> TimeseriesdecompbeveridgeCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_beveridge_cursor_add(a : TimeseriesdecompbeveridgeCursor, b : TimeseriesdecompbeveridgeCursor) -> TimeseriesdecompbeveridgeCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_decomp_beveridge_cursor_copy(s : TimeseriesdecompbeveridgeCursor) -> TimeseriesdecompbeveridgeCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_beveridge_cursor_fill(s : TimeseriesdecompbeveridgeCursor, v : Double) -> TimeseriesdecompbeveridgeCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_beveridge_cursor_min(s : TimeseriesdecompbeveridgeCursor) -> Double { @_common.min(s.data) }

pub fn timeseries_decomp_beveridge_cursor_max(s : TimeseriesdecompbeveridgeCursor) -> Double { @_common.max(s.data) }

pub fn timeseries_decomp_beveridge_cursor_to_string(s : TimeseriesdecompbeveridgeCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesdecompbeveridgeView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_decomp_beveridge_view_make(size : Int) -> TimeseriesdecompbeveridgeView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_decomp_beveridge_view_len(s : TimeseriesdecompbeveridgeView) -> Int { s.size }

pub fn timeseries_decomp_beveridge_view_get(s : TimeseriesdecompbeveridgeView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_decomp_beveridge_view_set(s : TimeseriesdecompbeveridgeView, i : Int, v : Double) -> TimeseriesdecompbeveridgeView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_beveridge_view_sum(s : TimeseriesdecompbeveridgeView) -> Double { @_common.sum(s.data) }

pub fn timeseries_decomp_beveridge_view_mean(s : TimeseriesdecompbeveridgeView) -> Double { @_common.mean(s.data) }

pub fn timeseries_decomp_beveridge_view_scale(s : TimeseriesdecompbeveridgeView, f : Double) -> TimeseriesdecompbeveridgeView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_beveridge_view_add(a : TimeseriesdecompbeveridgeView, b : TimeseriesdecompbeveridgeView) -> TimeseriesdecompbeveridgeView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_decomp_beveridge_view_copy(s : TimeseriesdecompbeveridgeView) -> TimeseriesdecompbeveridgeView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_beveridge_view_fill(s : TimeseriesdecompbeveridgeView, v : Double) -> TimeseriesdecompbeveridgeView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_beveridge_view_min(s : TimeseriesdecompbeveridgeView) -> Double { @_common.min(s.data) }

pub fn timeseries_decomp_beveridge_view_max(s : TimeseriesdecompbeveridgeView) -> Double { @_common.max(s.data) }

pub fn timeseries_decomp_beveridge_view_to_string(s : TimeseriesdecompbeveridgeView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesdecompbeveridgeRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_decomp_beveridge_range_make(size : Int) -> TimeseriesdecompbeveridgeRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_decomp_beveridge_range_len(s : TimeseriesdecompbeveridgeRange) -> Int { s.size }

pub fn timeseries_decomp_beveridge_range_get(s : TimeseriesdecompbeveridgeRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_decomp_beveridge_range_set(s : TimeseriesdecompbeveridgeRange, i : Int, v : Double) -> TimeseriesdecompbeveridgeRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_beveridge_range_sum(s : TimeseriesdecompbeveridgeRange) -> Double { @_common.sum(s.data) }

pub fn timeseries_decomp_beveridge_range_mean(s : TimeseriesdecompbeveridgeRange) -> Double { @_common.mean(s.data) }

pub fn timeseries_decomp_beveridge_range_scale(s : TimeseriesdecompbeveridgeRange, f : Double) -> TimeseriesdecompbeveridgeRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_beveridge_range_add(a : TimeseriesdecompbeveridgeRange, b : TimeseriesdecompbeveridgeRange) -> TimeseriesdecompbeveridgeRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_decomp_beveridge_range_copy(s : TimeseriesdecompbeveridgeRange) -> TimeseriesdecompbeveridgeRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_beveridge_range_fill(s : TimeseriesdecompbeveridgeRange, v : Double) -> TimeseriesdecompbeveridgeRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_beveridge_range_min(s : TimeseriesdecompbeveridgeRange) -> Double { @_common.min(s.data) }

pub fn timeseries_decomp_beveridge_range_max(s : TimeseriesdecompbeveridgeRange) -> Double { @_common.max(s.data) }

pub fn timeseries_decomp_beveridge_range_to_string(s : TimeseriesdecompbeveridgeRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesdecompbeveridgeSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_decomp_beveridge_slice_make(size : Int) -> TimeseriesdecompbeveridgeSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_decomp_beveridge_slice_len(s : TimeseriesdecompbeveridgeSlice) -> Int { s.size }

pub fn timeseries_decomp_beveridge_slice_get(s : TimeseriesdecompbeveridgeSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_decomp_beveridge_slice_set(s : TimeseriesdecompbeveridgeSlice, i : Int, v : Double) -> TimeseriesdecompbeveridgeSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_beveridge_slice_sum(s : TimeseriesdecompbeveridgeSlice) -> Double { @_common.sum(s.data) }

pub fn timeseries_decomp_beveridge_slice_mean(s : TimeseriesdecompbeveridgeSlice) -> Double { @_common.mean(s.data) }

pub fn timeseries_decomp_beveridge_slice_scale(s : TimeseriesdecompbeveridgeSlice, f : Double) -> TimeseriesdecompbeveridgeSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_beveridge_slice_add(a : TimeseriesdecompbeveridgeSlice, b : TimeseriesdecompbeveridgeSlice) -> TimeseriesdecompbeveridgeSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_decomp_beveridge_slice_copy(s : TimeseriesdecompbeveridgeSlice) -> TimeseriesdecompbeveridgeSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_beveridge_slice_fill(s : TimeseriesdecompbeveridgeSlice, v : Double) -> TimeseriesdecompbeveridgeSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_beveridge_slice_min(s : TimeseriesdecompbeveridgeSlice) -> Double { @_common.min(s.data) }

pub fn timeseries_decomp_beveridge_slice_max(s : TimeseriesdecompbeveridgeSlice) -> Double { @_common.max(s.data) }

pub fn timeseries_decomp_beveridge_slice_to_string(s : TimeseriesdecompbeveridgeSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

