///===
/// extcore/timeseries_decomp_moving

pub(all) struct TimeseriesdecompmovingPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn timeseries_decomp_moving_make_point(x : Double, y : Double) -> TimeseriesdecompmovingPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn timeseries_decomp_moving_make_point3(x : Double, y : Double, z : Double) -> TimeseriesdecompmovingPoint {
  { x, y, z, label: 0 }
}

pub fn TimeseriesdecompmovingPoint::x(self : TimeseriesdecompmovingPoint) -> Double { self.x }

pub fn TimeseriesdecompmovingPoint::y(self : TimeseriesdecompmovingPoint) -> Double { self.y }

pub fn TimeseriesdecompmovingPoint::z(self : TimeseriesdecompmovingPoint) -> Double { self.z }

pub fn TimeseriesdecompmovingPoint::label(self : TimeseriesdecompmovingPoint) -> Int { self.label }

pub fn TimeseriesdecompmovingPoint::dist(self : TimeseriesdecompmovingPoint, other : TimeseriesdecompmovingPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn TimeseriesdecompmovingPoint::add(self : TimeseriesdecompmovingPoint, other : TimeseriesdecompmovingPoint) -> TimeseriesdecompmovingPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn TimeseriesdecompmovingPoint::sub(self : TimeseriesdecompmovingPoint, other : TimeseriesdecompmovingPoint) -> TimeseriesdecompmovingPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn TimeseriesdecompmovingPoint::scale(self : TimeseriesdecompmovingPoint, s : Double) -> TimeseriesdecompmovingPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn TimeseriesdecompmovingPoint::dot(self : TimeseriesdecompmovingPoint, other : TimeseriesdecompmovingPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn TimeseriesdecompmovingPoint::cross(self : TimeseriesdecompmovingPoint, other : TimeseriesdecompmovingPoint) -> TimeseriesdecompmovingPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn TimeseriesdecompmovingPoint::norm(self : TimeseriesdecompmovingPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn TimeseriesdecompmovingPoint::normalize(self : TimeseriesdecompmovingPoint) -> TimeseriesdecompmovingPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn TimeseriesdecompmovingPoint::negate(self : TimeseriesdecompmovingPoint) -> TimeseriesdecompmovingPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn TimeseriesdecompmovingPoint::mid(self : TimeseriesdecompmovingPoint, other : TimeseriesdecompmovingPoint) -> TimeseriesdecompmovingPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn TimeseriesdecompmovingPoint::lerp(self : TimeseriesdecompmovingPoint, other : TimeseriesdecompmovingPoint, t : Double) -> TimeseriesdecompmovingPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn TimeseriesdecompmovingPoint::to_string(self : TimeseriesdecompmovingPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct TimeseriesdecompmovingSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn timeseries_decomp_moving_make_series(vals : Array[Double], name : String) -> TimeseriesdecompmovingSeries {
  { vals, name, meta: 0 }
}

pub fn TimeseriesdecompmovingSeries::len(self : TimeseriesdecompmovingSeries) -> Int { self.vals.length() }

pub fn TimeseriesdecompmovingSeries::sum(self : TimeseriesdecompmovingSeries) -> Double { @_common.sum(self.vals) }

pub fn TimeseriesdecompmovingSeries::mean(self : TimeseriesdecompmovingSeries) -> Double { @_common.mean(self.vals) }

pub fn TimeseriesdecompmovingSeries::min(self : TimeseriesdecompmovingSeries) -> Double { @_common.min(self.vals) }

pub fn TimeseriesdecompmovingSeries::max(self : TimeseriesdecompmovingSeries) -> Double { @_common.max(self.vals) }

pub fn TimeseriesdecompmovingSeries::range(self : TimeseriesdecompmovingSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn TimeseriesdecompmovingSeries::variance(self : TimeseriesdecompmovingSeries) -> Double { @_common.variance(self.vals) }

pub fn TimeseriesdecompmovingSeries::std(self : TimeseriesdecompmovingSeries) -> Double { @_common.std(self.vals) }

pub fn TimeseriesdecompmovingSeries::median(self : TimeseriesdecompmovingSeries) -> Double { @_common.median(self.vals) }

pub fn TimeseriesdecompmovingSeries::scale(self : TimeseriesdecompmovingSeries, f : Double) -> TimeseriesdecompmovingSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn TimeseriesdecompmovingSeries::add(self : TimeseriesdecompmovingSeries, other : TimeseriesdecompmovingSeries) -> TimeseriesdecompmovingSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn TimeseriesdecompmovingSeries::sub(self : TimeseriesdecompmovingSeries, other : TimeseriesdecompmovingSeries) -> TimeseriesdecompmovingSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn TimeseriesdecompmovingSeries::normalize(self : TimeseriesdecompmovingSeries) -> TimeseriesdecompmovingSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn TimeseriesdecompmovingSeries::cumsum(self : TimeseriesdecompmovingSeries) -> TimeseriesdecompmovingSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn TimeseriesdecompmovingSeries::to_string(self : TimeseriesdecompmovingSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct TimeseriesdecompmovingMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn timeseries_decomp_moving_make_matrix(rows : Int, cols : Int, val : Double) -> TimeseriesdecompmovingMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn timeseries_decomp_moving_matrix_identity(n : Int) -> TimeseriesdecompmovingMatrix {
  let m = timeseries_decomp_moving_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn TimeseriesdecompmovingMatrix::get(self : TimeseriesdecompmovingMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn TimeseriesdecompmovingMatrix::transpose(self : TimeseriesdecompmovingMatrix) -> TimeseriesdecompmovingMatrix {
  let result = timeseries_decomp_moving_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn TimeseriesdecompmovingMatrix::add(self : TimeseriesdecompmovingMatrix, other : TimeseriesdecompmovingMatrix) -> TimeseriesdecompmovingMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = timeseries_decomp_moving_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn TimeseriesdecompmovingMatrix::scale(self : TimeseriesdecompmovingMatrix, s : Double) -> TimeseriesdecompmovingMatrix {
  let result = timeseries_decomp_moving_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn TimeseriesdecompmovingMatrix::multiply(self : TimeseriesdecompmovingMatrix, other : TimeseriesdecompmovingMatrix) -> TimeseriesdecompmovingMatrix {
  if self.cols != other.rows { return timeseries_decomp_moving_make_matrix(self.rows, other.cols, 0.0) }
  let result = timeseries_decomp_moving_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn TimeseriesdecompmovingMatrix::trace(self : TimeseriesdecompmovingMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn TimeseriesdecompmovingMatrix::det(self : TimeseriesdecompmovingMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn TimeseriesdecompmovingMatrix::norm(self : TimeseriesdecompmovingMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn TimeseriesdecompmovingMatrix::to_string(self : TimeseriesdecompmovingMatrix) -> String {
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

pub(all) struct TimeseriesdecompmovingVector {
  comps : Array[Double]
  dim : Int
}

pub fn timeseries_decomp_moving_make_vector(comps : Array[Double]) -> TimeseriesdecompmovingVector {
  { comps, dim: comps.length() }
}

pub fn timeseries_decomp_moving_vector_zero(dim : Int) -> TimeseriesdecompmovingVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn TimeseriesdecompmovingVector::add(self : TimeseriesdecompmovingVector, other : TimeseriesdecompmovingVector) -> TimeseriesdecompmovingVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn TimeseriesdecompmovingVector::sub(self : TimeseriesdecompmovingVector, other : TimeseriesdecompmovingVector) -> TimeseriesdecompmovingVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn TimeseriesdecompmovingVector::scale(self : TimeseriesdecompmovingVector, s : Double) -> TimeseriesdecompmovingVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn TimeseriesdecompmovingVector::dot(self : TimeseriesdecompmovingVector, other : TimeseriesdecompmovingVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn TimeseriesdecompmovingVector::norm(self : TimeseriesdecompmovingVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn TimeseriesdecompmovingVector::normalize(self : TimeseriesdecompmovingVector) -> TimeseriesdecompmovingVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn TimeseriesdecompmovingVector::dist(self : TimeseriesdecompmovingVector, other : TimeseriesdecompmovingVector) -> Double {
  self.sub(other).norm()
}

pub fn TimeseriesdecompmovingVector::to_string(self : TimeseriesdecompmovingVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn timeseries_decomp_moving_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn timeseries_decomp_moving_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn timeseries_decomp_moving_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn timeseries_decomp_moving_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn timeseries_decomp_moving_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn timeseries_decomp_moving_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn timeseries_decomp_moving_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn timeseries_decomp_moving_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn timeseries_decomp_moving_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn timeseries_decomp_moving_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn timeseries_decomp_moving_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn timeseries_decomp_moving_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn timeseries_decomp_moving_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn timeseries_decomp_moving_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn timeseries_decomp_moving_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn timeseries_decomp_moving_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn timeseries_decomp_moving_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn timeseries_decomp_moving_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn timeseries_decomp_moving_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn timeseries_decomp_moving_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn timeseries_decomp_moving_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn timeseries_decomp_moving_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn timeseries_decomp_moving_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn timeseries_decomp_moving_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn timeseries_decomp_moving_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn timeseries_decomp_moving_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn timeseries_decomp_moving_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn timeseries_decomp_moving_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn timeseries_decomp_moving_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct TimeseriesdecompmovingFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_decomp_moving_frame_make(size : Int) -> TimeseriesdecompmovingFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_decomp_moving_frame_len(s : TimeseriesdecompmovingFrame) -> Int { s.size }

pub fn timeseries_decomp_moving_frame_get(s : TimeseriesdecompmovingFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_decomp_moving_frame_set(s : TimeseriesdecompmovingFrame, i : Int, v : Double) -> TimeseriesdecompmovingFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_moving_frame_sum(s : TimeseriesdecompmovingFrame) -> Double { @_common.sum(s.data) }

pub fn timeseries_decomp_moving_frame_mean(s : TimeseriesdecompmovingFrame) -> Double { @_common.mean(s.data) }

pub fn timeseries_decomp_moving_frame_scale(s : TimeseriesdecompmovingFrame, f : Double) -> TimeseriesdecompmovingFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_moving_frame_add(a : TimeseriesdecompmovingFrame, b : TimeseriesdecompmovingFrame) -> TimeseriesdecompmovingFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_decomp_moving_frame_copy(s : TimeseriesdecompmovingFrame) -> TimeseriesdecompmovingFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_moving_frame_fill(s : TimeseriesdecompmovingFrame, v : Double) -> TimeseriesdecompmovingFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_moving_frame_min(s : TimeseriesdecompmovingFrame) -> Double { @_common.min(s.data) }

pub fn timeseries_decomp_moving_frame_max(s : TimeseriesdecompmovingFrame) -> Double { @_common.max(s.data) }

pub fn timeseries_decomp_moving_frame_to_string(s : TimeseriesdecompmovingFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesdecompmovingTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_decomp_moving_table_make(size : Int) -> TimeseriesdecompmovingTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_decomp_moving_table_len(s : TimeseriesdecompmovingTable) -> Int { s.size }

pub fn timeseries_decomp_moving_table_get(s : TimeseriesdecompmovingTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_decomp_moving_table_set(s : TimeseriesdecompmovingTable, i : Int, v : Double) -> TimeseriesdecompmovingTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_moving_table_sum(s : TimeseriesdecompmovingTable) -> Double { @_common.sum(s.data) }

pub fn timeseries_decomp_moving_table_mean(s : TimeseriesdecompmovingTable) -> Double { @_common.mean(s.data) }

pub fn timeseries_decomp_moving_table_scale(s : TimeseriesdecompmovingTable, f : Double) -> TimeseriesdecompmovingTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_moving_table_add(a : TimeseriesdecompmovingTable, b : TimeseriesdecompmovingTable) -> TimeseriesdecompmovingTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_decomp_moving_table_copy(s : TimeseriesdecompmovingTable) -> TimeseriesdecompmovingTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_moving_table_fill(s : TimeseriesdecompmovingTable, v : Double) -> TimeseriesdecompmovingTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_moving_table_min(s : TimeseriesdecompmovingTable) -> Double { @_common.min(s.data) }

pub fn timeseries_decomp_moving_table_max(s : TimeseriesdecompmovingTable) -> Double { @_common.max(s.data) }

pub fn timeseries_decomp_moving_table_to_string(s : TimeseriesdecompmovingTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesdecompmovingGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_decomp_moving_graphn_make(size : Int) -> TimeseriesdecompmovingGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_decomp_moving_graphn_len(s : TimeseriesdecompmovingGraphN) -> Int { s.size }

pub fn timeseries_decomp_moving_graphn_get(s : TimeseriesdecompmovingGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_decomp_moving_graphn_set(s : TimeseriesdecompmovingGraphN, i : Int, v : Double) -> TimeseriesdecompmovingGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_moving_graphn_sum(s : TimeseriesdecompmovingGraphN) -> Double { @_common.sum(s.data) }

pub fn timeseries_decomp_moving_graphn_mean(s : TimeseriesdecompmovingGraphN) -> Double { @_common.mean(s.data) }

pub fn timeseries_decomp_moving_graphn_scale(s : TimeseriesdecompmovingGraphN, f : Double) -> TimeseriesdecompmovingGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_moving_graphn_add(a : TimeseriesdecompmovingGraphN, b : TimeseriesdecompmovingGraphN) -> TimeseriesdecompmovingGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_decomp_moving_graphn_copy(s : TimeseriesdecompmovingGraphN) -> TimeseriesdecompmovingGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_moving_graphn_fill(s : TimeseriesdecompmovingGraphN, v : Double) -> TimeseriesdecompmovingGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_moving_graphn_min(s : TimeseriesdecompmovingGraphN) -> Double { @_common.min(s.data) }

pub fn timeseries_decomp_moving_graphn_max(s : TimeseriesdecompmovingGraphN) -> Double { @_common.max(s.data) }

pub fn timeseries_decomp_moving_graphn_to_string(s : TimeseriesdecompmovingGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesdecompmovingNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_decomp_moving_node_make(size : Int) -> TimeseriesdecompmovingNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_decomp_moving_node_len(s : TimeseriesdecompmovingNode) -> Int { s.size }

pub fn timeseries_decomp_moving_node_get(s : TimeseriesdecompmovingNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_decomp_moving_node_set(s : TimeseriesdecompmovingNode, i : Int, v : Double) -> TimeseriesdecompmovingNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_moving_node_sum(s : TimeseriesdecompmovingNode) -> Double { @_common.sum(s.data) }

pub fn timeseries_decomp_moving_node_mean(s : TimeseriesdecompmovingNode) -> Double { @_common.mean(s.data) }

pub fn timeseries_decomp_moving_node_scale(s : TimeseriesdecompmovingNode, f : Double) -> TimeseriesdecompmovingNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_moving_node_add(a : TimeseriesdecompmovingNode, b : TimeseriesdecompmovingNode) -> TimeseriesdecompmovingNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_decomp_moving_node_copy(s : TimeseriesdecompmovingNode) -> TimeseriesdecompmovingNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_moving_node_fill(s : TimeseriesdecompmovingNode, v : Double) -> TimeseriesdecompmovingNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_moving_node_min(s : TimeseriesdecompmovingNode) -> Double { @_common.min(s.data) }

pub fn timeseries_decomp_moving_node_max(s : TimeseriesdecompmovingNode) -> Double { @_common.max(s.data) }

pub fn timeseries_decomp_moving_node_to_string(s : TimeseriesdecompmovingNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesdecompmovingEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_decomp_moving_edge_make(size : Int) -> TimeseriesdecompmovingEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_decomp_moving_edge_len(s : TimeseriesdecompmovingEdge) -> Int { s.size }

pub fn timeseries_decomp_moving_edge_get(s : TimeseriesdecompmovingEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_decomp_moving_edge_set(s : TimeseriesdecompmovingEdge, i : Int, v : Double) -> TimeseriesdecompmovingEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_moving_edge_sum(s : TimeseriesdecompmovingEdge) -> Double { @_common.sum(s.data) }

pub fn timeseries_decomp_moving_edge_mean(s : TimeseriesdecompmovingEdge) -> Double { @_common.mean(s.data) }

pub fn timeseries_decomp_moving_edge_scale(s : TimeseriesdecompmovingEdge, f : Double) -> TimeseriesdecompmovingEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_moving_edge_add(a : TimeseriesdecompmovingEdge, b : TimeseriesdecompmovingEdge) -> TimeseriesdecompmovingEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_decomp_moving_edge_copy(s : TimeseriesdecompmovingEdge) -> TimeseriesdecompmovingEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_moving_edge_fill(s : TimeseriesdecompmovingEdge, v : Double) -> TimeseriesdecompmovingEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_moving_edge_min(s : TimeseriesdecompmovingEdge) -> Double { @_common.min(s.data) }

pub fn timeseries_decomp_moving_edge_max(s : TimeseriesdecompmovingEdge) -> Double { @_common.max(s.data) }

pub fn timeseries_decomp_moving_edge_to_string(s : TimeseriesdecompmovingEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesdecompmovingPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_decomp_moving_path_make(size : Int) -> TimeseriesdecompmovingPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_decomp_moving_path_len(s : TimeseriesdecompmovingPath) -> Int { s.size }

pub fn timeseries_decomp_moving_path_get(s : TimeseriesdecompmovingPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_decomp_moving_path_set(s : TimeseriesdecompmovingPath, i : Int, v : Double) -> TimeseriesdecompmovingPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_moving_path_sum(s : TimeseriesdecompmovingPath) -> Double { @_common.sum(s.data) }

pub fn timeseries_decomp_moving_path_mean(s : TimeseriesdecompmovingPath) -> Double { @_common.mean(s.data) }

pub fn timeseries_decomp_moving_path_scale(s : TimeseriesdecompmovingPath, f : Double) -> TimeseriesdecompmovingPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_moving_path_add(a : TimeseriesdecompmovingPath, b : TimeseriesdecompmovingPath) -> TimeseriesdecompmovingPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_decomp_moving_path_copy(s : TimeseriesdecompmovingPath) -> TimeseriesdecompmovingPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_moving_path_fill(s : TimeseriesdecompmovingPath, v : Double) -> TimeseriesdecompmovingPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_moving_path_min(s : TimeseriesdecompmovingPath) -> Double { @_common.min(s.data) }

pub fn timeseries_decomp_moving_path_max(s : TimeseriesdecompmovingPath) -> Double { @_common.max(s.data) }

pub fn timeseries_decomp_moving_path_to_string(s : TimeseriesdecompmovingPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesdecompmovingCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_decomp_moving_cluster_make(size : Int) -> TimeseriesdecompmovingCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_decomp_moving_cluster_len(s : TimeseriesdecompmovingCluster) -> Int { s.size }

pub fn timeseries_decomp_moving_cluster_get(s : TimeseriesdecompmovingCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_decomp_moving_cluster_set(s : TimeseriesdecompmovingCluster, i : Int, v : Double) -> TimeseriesdecompmovingCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_moving_cluster_sum(s : TimeseriesdecompmovingCluster) -> Double { @_common.sum(s.data) }

pub fn timeseries_decomp_moving_cluster_mean(s : TimeseriesdecompmovingCluster) -> Double { @_common.mean(s.data) }

pub fn timeseries_decomp_moving_cluster_scale(s : TimeseriesdecompmovingCluster, f : Double) -> TimeseriesdecompmovingCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_moving_cluster_add(a : TimeseriesdecompmovingCluster, b : TimeseriesdecompmovingCluster) -> TimeseriesdecompmovingCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_decomp_moving_cluster_copy(s : TimeseriesdecompmovingCluster) -> TimeseriesdecompmovingCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_moving_cluster_fill(s : TimeseriesdecompmovingCluster, v : Double) -> TimeseriesdecompmovingCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_moving_cluster_min(s : TimeseriesdecompmovingCluster) -> Double { @_common.min(s.data) }

pub fn timeseries_decomp_moving_cluster_max(s : TimeseriesdecompmovingCluster) -> Double { @_common.max(s.data) }

pub fn timeseries_decomp_moving_cluster_to_string(s : TimeseriesdecompmovingCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesdecompmovingModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_decomp_moving_model_make(size : Int) -> TimeseriesdecompmovingModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_decomp_moving_model_len(s : TimeseriesdecompmovingModel) -> Int { s.size }

pub fn timeseries_decomp_moving_model_get(s : TimeseriesdecompmovingModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_decomp_moving_model_set(s : TimeseriesdecompmovingModel, i : Int, v : Double) -> TimeseriesdecompmovingModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_moving_model_sum(s : TimeseriesdecompmovingModel) -> Double { @_common.sum(s.data) }

pub fn timeseries_decomp_moving_model_mean(s : TimeseriesdecompmovingModel) -> Double { @_common.mean(s.data) }

pub fn timeseries_decomp_moving_model_scale(s : TimeseriesdecompmovingModel, f : Double) -> TimeseriesdecompmovingModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_moving_model_add(a : TimeseriesdecompmovingModel, b : TimeseriesdecompmovingModel) -> TimeseriesdecompmovingModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_decomp_moving_model_copy(s : TimeseriesdecompmovingModel) -> TimeseriesdecompmovingModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_moving_model_fill(s : TimeseriesdecompmovingModel, v : Double) -> TimeseriesdecompmovingModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_moving_model_min(s : TimeseriesdecompmovingModel) -> Double { @_common.min(s.data) }

pub fn timeseries_decomp_moving_model_max(s : TimeseriesdecompmovingModel) -> Double { @_common.max(s.data) }

pub fn timeseries_decomp_moving_model_to_string(s : TimeseriesdecompmovingModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesdecompmovingLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_decomp_moving_layer_make(size : Int) -> TimeseriesdecompmovingLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_decomp_moving_layer_len(s : TimeseriesdecompmovingLayer) -> Int { s.size }

pub fn timeseries_decomp_moving_layer_get(s : TimeseriesdecompmovingLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_decomp_moving_layer_set(s : TimeseriesdecompmovingLayer, i : Int, v : Double) -> TimeseriesdecompmovingLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_moving_layer_sum(s : TimeseriesdecompmovingLayer) -> Double { @_common.sum(s.data) }

pub fn timeseries_decomp_moving_layer_mean(s : TimeseriesdecompmovingLayer) -> Double { @_common.mean(s.data) }

pub fn timeseries_decomp_moving_layer_scale(s : TimeseriesdecompmovingLayer, f : Double) -> TimeseriesdecompmovingLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_moving_layer_add(a : TimeseriesdecompmovingLayer, b : TimeseriesdecompmovingLayer) -> TimeseriesdecompmovingLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_decomp_moving_layer_copy(s : TimeseriesdecompmovingLayer) -> TimeseriesdecompmovingLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_moving_layer_fill(s : TimeseriesdecompmovingLayer, v : Double) -> TimeseriesdecompmovingLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_moving_layer_min(s : TimeseriesdecompmovingLayer) -> Double { @_common.min(s.data) }

pub fn timeseries_decomp_moving_layer_max(s : TimeseriesdecompmovingLayer) -> Double { @_common.max(s.data) }

pub fn timeseries_decomp_moving_layer_to_string(s : TimeseriesdecompmovingLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesdecompmovingBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_decomp_moving_buffer_make(size : Int) -> TimeseriesdecompmovingBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_decomp_moving_buffer_len(s : TimeseriesdecompmovingBuffer) -> Int { s.size }

pub fn timeseries_decomp_moving_buffer_get(s : TimeseriesdecompmovingBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_decomp_moving_buffer_set(s : TimeseriesdecompmovingBuffer, i : Int, v : Double) -> TimeseriesdecompmovingBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_moving_buffer_sum(s : TimeseriesdecompmovingBuffer) -> Double { @_common.sum(s.data) }

pub fn timeseries_decomp_moving_buffer_mean(s : TimeseriesdecompmovingBuffer) -> Double { @_common.mean(s.data) }

pub fn timeseries_decomp_moving_buffer_scale(s : TimeseriesdecompmovingBuffer, f : Double) -> TimeseriesdecompmovingBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_moving_buffer_add(a : TimeseriesdecompmovingBuffer, b : TimeseriesdecompmovingBuffer) -> TimeseriesdecompmovingBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_decomp_moving_buffer_copy(s : TimeseriesdecompmovingBuffer) -> TimeseriesdecompmovingBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_moving_buffer_fill(s : TimeseriesdecompmovingBuffer, v : Double) -> TimeseriesdecompmovingBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_moving_buffer_min(s : TimeseriesdecompmovingBuffer) -> Double { @_common.min(s.data) }

pub fn timeseries_decomp_moving_buffer_max(s : TimeseriesdecompmovingBuffer) -> Double { @_common.max(s.data) }

pub fn timeseries_decomp_moving_buffer_to_string(s : TimeseriesdecompmovingBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesdecompmovingCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_decomp_moving_cursor_make(size : Int) -> TimeseriesdecompmovingCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_decomp_moving_cursor_len(s : TimeseriesdecompmovingCursor) -> Int { s.size }

pub fn timeseries_decomp_moving_cursor_get(s : TimeseriesdecompmovingCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_decomp_moving_cursor_set(s : TimeseriesdecompmovingCursor, i : Int, v : Double) -> TimeseriesdecompmovingCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_moving_cursor_sum(s : TimeseriesdecompmovingCursor) -> Double { @_common.sum(s.data) }

pub fn timeseries_decomp_moving_cursor_mean(s : TimeseriesdecompmovingCursor) -> Double { @_common.mean(s.data) }

pub fn timeseries_decomp_moving_cursor_scale(s : TimeseriesdecompmovingCursor, f : Double) -> TimeseriesdecompmovingCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_moving_cursor_add(a : TimeseriesdecompmovingCursor, b : TimeseriesdecompmovingCursor) -> TimeseriesdecompmovingCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_decomp_moving_cursor_copy(s : TimeseriesdecompmovingCursor) -> TimeseriesdecompmovingCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_moving_cursor_fill(s : TimeseriesdecompmovingCursor, v : Double) -> TimeseriesdecompmovingCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_moving_cursor_min(s : TimeseriesdecompmovingCursor) -> Double { @_common.min(s.data) }

pub fn timeseries_decomp_moving_cursor_max(s : TimeseriesdecompmovingCursor) -> Double { @_common.max(s.data) }

pub fn timeseries_decomp_moving_cursor_to_string(s : TimeseriesdecompmovingCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesdecompmovingView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_decomp_moving_view_make(size : Int) -> TimeseriesdecompmovingView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_decomp_moving_view_len(s : TimeseriesdecompmovingView) -> Int { s.size }

pub fn timeseries_decomp_moving_view_get(s : TimeseriesdecompmovingView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_decomp_moving_view_set(s : TimeseriesdecompmovingView, i : Int, v : Double) -> TimeseriesdecompmovingView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_moving_view_sum(s : TimeseriesdecompmovingView) -> Double { @_common.sum(s.data) }

pub fn timeseries_decomp_moving_view_mean(s : TimeseriesdecompmovingView) -> Double { @_common.mean(s.data) }

pub fn timeseries_decomp_moving_view_scale(s : TimeseriesdecompmovingView, f : Double) -> TimeseriesdecompmovingView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_moving_view_add(a : TimeseriesdecompmovingView, b : TimeseriesdecompmovingView) -> TimeseriesdecompmovingView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_decomp_moving_view_copy(s : TimeseriesdecompmovingView) -> TimeseriesdecompmovingView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_moving_view_fill(s : TimeseriesdecompmovingView, v : Double) -> TimeseriesdecompmovingView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_moving_view_min(s : TimeseriesdecompmovingView) -> Double { @_common.min(s.data) }

pub fn timeseries_decomp_moving_view_max(s : TimeseriesdecompmovingView) -> Double { @_common.max(s.data) }

pub fn timeseries_decomp_moving_view_to_string(s : TimeseriesdecompmovingView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesdecompmovingRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_decomp_moving_range_make(size : Int) -> TimeseriesdecompmovingRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_decomp_moving_range_len(s : TimeseriesdecompmovingRange) -> Int { s.size }

pub fn timeseries_decomp_moving_range_get(s : TimeseriesdecompmovingRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_decomp_moving_range_set(s : TimeseriesdecompmovingRange, i : Int, v : Double) -> TimeseriesdecompmovingRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_moving_range_sum(s : TimeseriesdecompmovingRange) -> Double { @_common.sum(s.data) }

pub fn timeseries_decomp_moving_range_mean(s : TimeseriesdecompmovingRange) -> Double { @_common.mean(s.data) }

pub fn timeseries_decomp_moving_range_scale(s : TimeseriesdecompmovingRange, f : Double) -> TimeseriesdecompmovingRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_moving_range_add(a : TimeseriesdecompmovingRange, b : TimeseriesdecompmovingRange) -> TimeseriesdecompmovingRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_decomp_moving_range_copy(s : TimeseriesdecompmovingRange) -> TimeseriesdecompmovingRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_moving_range_fill(s : TimeseriesdecompmovingRange, v : Double) -> TimeseriesdecompmovingRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_moving_range_min(s : TimeseriesdecompmovingRange) -> Double { @_common.min(s.data) }

pub fn timeseries_decomp_moving_range_max(s : TimeseriesdecompmovingRange) -> Double { @_common.max(s.data) }

pub fn timeseries_decomp_moving_range_to_string(s : TimeseriesdecompmovingRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesdecompmovingSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_decomp_moving_slice_make(size : Int) -> TimeseriesdecompmovingSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_decomp_moving_slice_len(s : TimeseriesdecompmovingSlice) -> Int { s.size }

pub fn timeseries_decomp_moving_slice_get(s : TimeseriesdecompmovingSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_decomp_moving_slice_set(s : TimeseriesdecompmovingSlice, i : Int, v : Double) -> TimeseriesdecompmovingSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_moving_slice_sum(s : TimeseriesdecompmovingSlice) -> Double { @_common.sum(s.data) }

pub fn timeseries_decomp_moving_slice_mean(s : TimeseriesdecompmovingSlice) -> Double { @_common.mean(s.data) }

pub fn timeseries_decomp_moving_slice_scale(s : TimeseriesdecompmovingSlice, f : Double) -> TimeseriesdecompmovingSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_moving_slice_add(a : TimeseriesdecompmovingSlice, b : TimeseriesdecompmovingSlice) -> TimeseriesdecompmovingSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_decomp_moving_slice_copy(s : TimeseriesdecompmovingSlice) -> TimeseriesdecompmovingSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_moving_slice_fill(s : TimeseriesdecompmovingSlice, v : Double) -> TimeseriesdecompmovingSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_moving_slice_min(s : TimeseriesdecompmovingSlice) -> Double { @_common.min(s.data) }

pub fn timeseries_decomp_moving_slice_max(s : TimeseriesdecompmovingSlice) -> Double { @_common.max(s.data) }

pub fn timeseries_decomp_moving_slice_to_string(s : TimeseriesdecompmovingSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

