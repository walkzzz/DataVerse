///===
/// extcore/timeseries_exponential

pub(all) struct TimeseriesexponentialPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn timeseries_exponential_make_point(x : Double, y : Double) -> TimeseriesexponentialPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn timeseries_exponential_make_point3(x : Double, y : Double, z : Double) -> TimeseriesexponentialPoint {
  { x, y, z, label: 0 }
}

pub fn TimeseriesexponentialPoint::x(self : TimeseriesexponentialPoint) -> Double { self.x }

pub fn TimeseriesexponentialPoint::y(self : TimeseriesexponentialPoint) -> Double { self.y }

pub fn TimeseriesexponentialPoint::z(self : TimeseriesexponentialPoint) -> Double { self.z }

pub fn TimeseriesexponentialPoint::label(self : TimeseriesexponentialPoint) -> Int { self.label }

pub fn TimeseriesexponentialPoint::dist(self : TimeseriesexponentialPoint, other : TimeseriesexponentialPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn TimeseriesexponentialPoint::add(self : TimeseriesexponentialPoint, other : TimeseriesexponentialPoint) -> TimeseriesexponentialPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn TimeseriesexponentialPoint::sub(self : TimeseriesexponentialPoint, other : TimeseriesexponentialPoint) -> TimeseriesexponentialPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn TimeseriesexponentialPoint::scale(self : TimeseriesexponentialPoint, s : Double) -> TimeseriesexponentialPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn TimeseriesexponentialPoint::dot(self : TimeseriesexponentialPoint, other : TimeseriesexponentialPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn TimeseriesexponentialPoint::cross(self : TimeseriesexponentialPoint, other : TimeseriesexponentialPoint) -> TimeseriesexponentialPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn TimeseriesexponentialPoint::norm(self : TimeseriesexponentialPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn TimeseriesexponentialPoint::normalize(self : TimeseriesexponentialPoint) -> TimeseriesexponentialPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn TimeseriesexponentialPoint::negate(self : TimeseriesexponentialPoint) -> TimeseriesexponentialPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn TimeseriesexponentialPoint::mid(self : TimeseriesexponentialPoint, other : TimeseriesexponentialPoint) -> TimeseriesexponentialPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn TimeseriesexponentialPoint::lerp(self : TimeseriesexponentialPoint, other : TimeseriesexponentialPoint, t : Double) -> TimeseriesexponentialPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn TimeseriesexponentialPoint::to_string(self : TimeseriesexponentialPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct TimeseriesexponentialSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn timeseries_exponential_make_series(vals : Array[Double], name : String) -> TimeseriesexponentialSeries {
  { vals, name, meta: 0 }
}

pub fn TimeseriesexponentialSeries::len(self : TimeseriesexponentialSeries) -> Int { self.vals.length() }

pub fn TimeseriesexponentialSeries::sum(self : TimeseriesexponentialSeries) -> Double { @_common.sum(self.vals) }

pub fn TimeseriesexponentialSeries::mean(self : TimeseriesexponentialSeries) -> Double { @_common.mean(self.vals) }

pub fn TimeseriesexponentialSeries::min(self : TimeseriesexponentialSeries) -> Double { @_common.min(self.vals) }

pub fn TimeseriesexponentialSeries::max(self : TimeseriesexponentialSeries) -> Double { @_common.max(self.vals) }

pub fn TimeseriesexponentialSeries::range(self : TimeseriesexponentialSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn TimeseriesexponentialSeries::variance(self : TimeseriesexponentialSeries) -> Double { @_common.variance(self.vals) }

pub fn TimeseriesexponentialSeries::std(self : TimeseriesexponentialSeries) -> Double { @_common.std(self.vals) }

pub fn TimeseriesexponentialSeries::median(self : TimeseriesexponentialSeries) -> Double { @_common.median(self.vals) }

pub fn TimeseriesexponentialSeries::scale(self : TimeseriesexponentialSeries, f : Double) -> TimeseriesexponentialSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn TimeseriesexponentialSeries::add(self : TimeseriesexponentialSeries, other : TimeseriesexponentialSeries) -> TimeseriesexponentialSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn TimeseriesexponentialSeries::sub(self : TimeseriesexponentialSeries, other : TimeseriesexponentialSeries) -> TimeseriesexponentialSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn TimeseriesexponentialSeries::normalize(self : TimeseriesexponentialSeries) -> TimeseriesexponentialSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn TimeseriesexponentialSeries::cumsum(self : TimeseriesexponentialSeries) -> TimeseriesexponentialSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn TimeseriesexponentialSeries::to_string(self : TimeseriesexponentialSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct TimeseriesexponentialMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn timeseries_exponential_make_matrix(rows : Int, cols : Int, val : Double) -> TimeseriesexponentialMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn timeseries_exponential_matrix_identity(n : Int) -> TimeseriesexponentialMatrix {
  let m = timeseries_exponential_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn TimeseriesexponentialMatrix::get(self : TimeseriesexponentialMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn TimeseriesexponentialMatrix::transpose(self : TimeseriesexponentialMatrix) -> TimeseriesexponentialMatrix {
  let result = timeseries_exponential_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn TimeseriesexponentialMatrix::add(self : TimeseriesexponentialMatrix, other : TimeseriesexponentialMatrix) -> TimeseriesexponentialMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = timeseries_exponential_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn TimeseriesexponentialMatrix::scale(self : TimeseriesexponentialMatrix, s : Double) -> TimeseriesexponentialMatrix {
  let result = timeseries_exponential_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn TimeseriesexponentialMatrix::multiply(self : TimeseriesexponentialMatrix, other : TimeseriesexponentialMatrix) -> TimeseriesexponentialMatrix {
  if self.cols != other.rows { return timeseries_exponential_make_matrix(self.rows, other.cols, 0.0) }
  let result = timeseries_exponential_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn TimeseriesexponentialMatrix::trace(self : TimeseriesexponentialMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn TimeseriesexponentialMatrix::det(self : TimeseriesexponentialMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn TimeseriesexponentialMatrix::norm(self : TimeseriesexponentialMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn TimeseriesexponentialMatrix::to_string(self : TimeseriesexponentialMatrix) -> String {
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

pub(all) struct TimeseriesexponentialVector {
  comps : Array[Double]
  dim : Int
}

pub fn timeseries_exponential_make_vector(comps : Array[Double]) -> TimeseriesexponentialVector {
  { comps, dim: comps.length() }
}

pub fn timeseries_exponential_vector_zero(dim : Int) -> TimeseriesexponentialVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn TimeseriesexponentialVector::add(self : TimeseriesexponentialVector, other : TimeseriesexponentialVector) -> TimeseriesexponentialVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn TimeseriesexponentialVector::sub(self : TimeseriesexponentialVector, other : TimeseriesexponentialVector) -> TimeseriesexponentialVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn TimeseriesexponentialVector::scale(self : TimeseriesexponentialVector, s : Double) -> TimeseriesexponentialVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn TimeseriesexponentialVector::dot(self : TimeseriesexponentialVector, other : TimeseriesexponentialVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn TimeseriesexponentialVector::norm(self : TimeseriesexponentialVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn TimeseriesexponentialVector::normalize(self : TimeseriesexponentialVector) -> TimeseriesexponentialVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn TimeseriesexponentialVector::dist(self : TimeseriesexponentialVector, other : TimeseriesexponentialVector) -> Double {
  self.sub(other).norm()
}

pub fn TimeseriesexponentialVector::to_string(self : TimeseriesexponentialVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn timeseries_exponential_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn timeseries_exponential_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn timeseries_exponential_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn timeseries_exponential_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn timeseries_exponential_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn timeseries_exponential_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn timeseries_exponential_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn timeseries_exponential_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn timeseries_exponential_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn timeseries_exponential_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn timeseries_exponential_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn timeseries_exponential_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn timeseries_exponential_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn timeseries_exponential_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn timeseries_exponential_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn timeseries_exponential_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn timeseries_exponential_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn timeseries_exponential_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn timeseries_exponential_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn timeseries_exponential_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn timeseries_exponential_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn timeseries_exponential_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn timeseries_exponential_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn timeseries_exponential_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn timeseries_exponential_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn timeseries_exponential_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn timeseries_exponential_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn timeseries_exponential_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn timeseries_exponential_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct TimeseriesexponentialFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_exponential_frame_make(size : Int) -> TimeseriesexponentialFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_exponential_frame_len(s : TimeseriesexponentialFrame) -> Int { s.size }

pub fn timeseries_exponential_frame_get(s : TimeseriesexponentialFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_exponential_frame_set(s : TimeseriesexponentialFrame, i : Int, v : Double) -> TimeseriesexponentialFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_exponential_frame_sum(s : TimeseriesexponentialFrame) -> Double { @_common.sum(s.data) }

pub fn timeseries_exponential_frame_mean(s : TimeseriesexponentialFrame) -> Double { @_common.mean(s.data) }

pub fn timeseries_exponential_frame_scale(s : TimeseriesexponentialFrame, f : Double) -> TimeseriesexponentialFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_exponential_frame_add(a : TimeseriesexponentialFrame, b : TimeseriesexponentialFrame) -> TimeseriesexponentialFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_exponential_frame_copy(s : TimeseriesexponentialFrame) -> TimeseriesexponentialFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_exponential_frame_fill(s : TimeseriesexponentialFrame, v : Double) -> TimeseriesexponentialFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_exponential_frame_min(s : TimeseriesexponentialFrame) -> Double { @_common.min(s.data) }

pub fn timeseries_exponential_frame_max(s : TimeseriesexponentialFrame) -> Double { @_common.max(s.data) }

pub fn timeseries_exponential_frame_to_string(s : TimeseriesexponentialFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesexponentialTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_exponential_table_make(size : Int) -> TimeseriesexponentialTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_exponential_table_len(s : TimeseriesexponentialTable) -> Int { s.size }

pub fn timeseries_exponential_table_get(s : TimeseriesexponentialTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_exponential_table_set(s : TimeseriesexponentialTable, i : Int, v : Double) -> TimeseriesexponentialTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_exponential_table_sum(s : TimeseriesexponentialTable) -> Double { @_common.sum(s.data) }

pub fn timeseries_exponential_table_mean(s : TimeseriesexponentialTable) -> Double { @_common.mean(s.data) }

pub fn timeseries_exponential_table_scale(s : TimeseriesexponentialTable, f : Double) -> TimeseriesexponentialTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_exponential_table_add(a : TimeseriesexponentialTable, b : TimeseriesexponentialTable) -> TimeseriesexponentialTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_exponential_table_copy(s : TimeseriesexponentialTable) -> TimeseriesexponentialTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_exponential_table_fill(s : TimeseriesexponentialTable, v : Double) -> TimeseriesexponentialTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_exponential_table_min(s : TimeseriesexponentialTable) -> Double { @_common.min(s.data) }

pub fn timeseries_exponential_table_max(s : TimeseriesexponentialTable) -> Double { @_common.max(s.data) }

pub fn timeseries_exponential_table_to_string(s : TimeseriesexponentialTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesexponentialGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_exponential_graphn_make(size : Int) -> TimeseriesexponentialGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_exponential_graphn_len(s : TimeseriesexponentialGraphN) -> Int { s.size }

pub fn timeseries_exponential_graphn_get(s : TimeseriesexponentialGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_exponential_graphn_set(s : TimeseriesexponentialGraphN, i : Int, v : Double) -> TimeseriesexponentialGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_exponential_graphn_sum(s : TimeseriesexponentialGraphN) -> Double { @_common.sum(s.data) }

pub fn timeseries_exponential_graphn_mean(s : TimeseriesexponentialGraphN) -> Double { @_common.mean(s.data) }

pub fn timeseries_exponential_graphn_scale(s : TimeseriesexponentialGraphN, f : Double) -> TimeseriesexponentialGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_exponential_graphn_add(a : TimeseriesexponentialGraphN, b : TimeseriesexponentialGraphN) -> TimeseriesexponentialGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_exponential_graphn_copy(s : TimeseriesexponentialGraphN) -> TimeseriesexponentialGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_exponential_graphn_fill(s : TimeseriesexponentialGraphN, v : Double) -> TimeseriesexponentialGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_exponential_graphn_min(s : TimeseriesexponentialGraphN) -> Double { @_common.min(s.data) }

pub fn timeseries_exponential_graphn_max(s : TimeseriesexponentialGraphN) -> Double { @_common.max(s.data) }

pub fn timeseries_exponential_graphn_to_string(s : TimeseriesexponentialGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesexponentialNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_exponential_node_make(size : Int) -> TimeseriesexponentialNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_exponential_node_len(s : TimeseriesexponentialNode) -> Int { s.size }

pub fn timeseries_exponential_node_get(s : TimeseriesexponentialNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_exponential_node_set(s : TimeseriesexponentialNode, i : Int, v : Double) -> TimeseriesexponentialNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_exponential_node_sum(s : TimeseriesexponentialNode) -> Double { @_common.sum(s.data) }

pub fn timeseries_exponential_node_mean(s : TimeseriesexponentialNode) -> Double { @_common.mean(s.data) }

pub fn timeseries_exponential_node_scale(s : TimeseriesexponentialNode, f : Double) -> TimeseriesexponentialNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_exponential_node_add(a : TimeseriesexponentialNode, b : TimeseriesexponentialNode) -> TimeseriesexponentialNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_exponential_node_copy(s : TimeseriesexponentialNode) -> TimeseriesexponentialNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_exponential_node_fill(s : TimeseriesexponentialNode, v : Double) -> TimeseriesexponentialNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_exponential_node_min(s : TimeseriesexponentialNode) -> Double { @_common.min(s.data) }

pub fn timeseries_exponential_node_max(s : TimeseriesexponentialNode) -> Double { @_common.max(s.data) }

pub fn timeseries_exponential_node_to_string(s : TimeseriesexponentialNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesexponentialEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_exponential_edge_make(size : Int) -> TimeseriesexponentialEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_exponential_edge_len(s : TimeseriesexponentialEdge) -> Int { s.size }

pub fn timeseries_exponential_edge_get(s : TimeseriesexponentialEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_exponential_edge_set(s : TimeseriesexponentialEdge, i : Int, v : Double) -> TimeseriesexponentialEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_exponential_edge_sum(s : TimeseriesexponentialEdge) -> Double { @_common.sum(s.data) }

pub fn timeseries_exponential_edge_mean(s : TimeseriesexponentialEdge) -> Double { @_common.mean(s.data) }

pub fn timeseries_exponential_edge_scale(s : TimeseriesexponentialEdge, f : Double) -> TimeseriesexponentialEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_exponential_edge_add(a : TimeseriesexponentialEdge, b : TimeseriesexponentialEdge) -> TimeseriesexponentialEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_exponential_edge_copy(s : TimeseriesexponentialEdge) -> TimeseriesexponentialEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_exponential_edge_fill(s : TimeseriesexponentialEdge, v : Double) -> TimeseriesexponentialEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_exponential_edge_min(s : TimeseriesexponentialEdge) -> Double { @_common.min(s.data) }

pub fn timeseries_exponential_edge_max(s : TimeseriesexponentialEdge) -> Double { @_common.max(s.data) }

pub fn timeseries_exponential_edge_to_string(s : TimeseriesexponentialEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesexponentialPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_exponential_path_make(size : Int) -> TimeseriesexponentialPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_exponential_path_len(s : TimeseriesexponentialPath) -> Int { s.size }

pub fn timeseries_exponential_path_get(s : TimeseriesexponentialPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_exponential_path_set(s : TimeseriesexponentialPath, i : Int, v : Double) -> TimeseriesexponentialPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_exponential_path_sum(s : TimeseriesexponentialPath) -> Double { @_common.sum(s.data) }

pub fn timeseries_exponential_path_mean(s : TimeseriesexponentialPath) -> Double { @_common.mean(s.data) }

pub fn timeseries_exponential_path_scale(s : TimeseriesexponentialPath, f : Double) -> TimeseriesexponentialPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_exponential_path_add(a : TimeseriesexponentialPath, b : TimeseriesexponentialPath) -> TimeseriesexponentialPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_exponential_path_copy(s : TimeseriesexponentialPath) -> TimeseriesexponentialPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_exponential_path_fill(s : TimeseriesexponentialPath, v : Double) -> TimeseriesexponentialPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_exponential_path_min(s : TimeseriesexponentialPath) -> Double { @_common.min(s.data) }

pub fn timeseries_exponential_path_max(s : TimeseriesexponentialPath) -> Double { @_common.max(s.data) }

pub fn timeseries_exponential_path_to_string(s : TimeseriesexponentialPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesexponentialCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_exponential_cluster_make(size : Int) -> TimeseriesexponentialCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_exponential_cluster_len(s : TimeseriesexponentialCluster) -> Int { s.size }

pub fn timeseries_exponential_cluster_get(s : TimeseriesexponentialCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_exponential_cluster_set(s : TimeseriesexponentialCluster, i : Int, v : Double) -> TimeseriesexponentialCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_exponential_cluster_sum(s : TimeseriesexponentialCluster) -> Double { @_common.sum(s.data) }

pub fn timeseries_exponential_cluster_mean(s : TimeseriesexponentialCluster) -> Double { @_common.mean(s.data) }

pub fn timeseries_exponential_cluster_scale(s : TimeseriesexponentialCluster, f : Double) -> TimeseriesexponentialCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_exponential_cluster_add(a : TimeseriesexponentialCluster, b : TimeseriesexponentialCluster) -> TimeseriesexponentialCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_exponential_cluster_copy(s : TimeseriesexponentialCluster) -> TimeseriesexponentialCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_exponential_cluster_fill(s : TimeseriesexponentialCluster, v : Double) -> TimeseriesexponentialCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_exponential_cluster_min(s : TimeseriesexponentialCluster) -> Double { @_common.min(s.data) }

pub fn timeseries_exponential_cluster_max(s : TimeseriesexponentialCluster) -> Double { @_common.max(s.data) }

pub fn timeseries_exponential_cluster_to_string(s : TimeseriesexponentialCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesexponentialModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_exponential_model_make(size : Int) -> TimeseriesexponentialModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_exponential_model_len(s : TimeseriesexponentialModel) -> Int { s.size }

pub fn timeseries_exponential_model_get(s : TimeseriesexponentialModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_exponential_model_set(s : TimeseriesexponentialModel, i : Int, v : Double) -> TimeseriesexponentialModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_exponential_model_sum(s : TimeseriesexponentialModel) -> Double { @_common.sum(s.data) }

pub fn timeseries_exponential_model_mean(s : TimeseriesexponentialModel) -> Double { @_common.mean(s.data) }

pub fn timeseries_exponential_model_scale(s : TimeseriesexponentialModel, f : Double) -> TimeseriesexponentialModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_exponential_model_add(a : TimeseriesexponentialModel, b : TimeseriesexponentialModel) -> TimeseriesexponentialModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_exponential_model_copy(s : TimeseriesexponentialModel) -> TimeseriesexponentialModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_exponential_model_fill(s : TimeseriesexponentialModel, v : Double) -> TimeseriesexponentialModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_exponential_model_min(s : TimeseriesexponentialModel) -> Double { @_common.min(s.data) }

pub fn timeseries_exponential_model_max(s : TimeseriesexponentialModel) -> Double { @_common.max(s.data) }

pub fn timeseries_exponential_model_to_string(s : TimeseriesexponentialModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesexponentialLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_exponential_layer_make(size : Int) -> TimeseriesexponentialLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_exponential_layer_len(s : TimeseriesexponentialLayer) -> Int { s.size }

pub fn timeseries_exponential_layer_get(s : TimeseriesexponentialLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_exponential_layer_set(s : TimeseriesexponentialLayer, i : Int, v : Double) -> TimeseriesexponentialLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_exponential_layer_sum(s : TimeseriesexponentialLayer) -> Double { @_common.sum(s.data) }

pub fn timeseries_exponential_layer_mean(s : TimeseriesexponentialLayer) -> Double { @_common.mean(s.data) }

pub fn timeseries_exponential_layer_scale(s : TimeseriesexponentialLayer, f : Double) -> TimeseriesexponentialLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_exponential_layer_add(a : TimeseriesexponentialLayer, b : TimeseriesexponentialLayer) -> TimeseriesexponentialLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_exponential_layer_copy(s : TimeseriesexponentialLayer) -> TimeseriesexponentialLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_exponential_layer_fill(s : TimeseriesexponentialLayer, v : Double) -> TimeseriesexponentialLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_exponential_layer_min(s : TimeseriesexponentialLayer) -> Double { @_common.min(s.data) }

pub fn timeseries_exponential_layer_max(s : TimeseriesexponentialLayer) -> Double { @_common.max(s.data) }

pub fn timeseries_exponential_layer_to_string(s : TimeseriesexponentialLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesexponentialBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_exponential_buffer_make(size : Int) -> TimeseriesexponentialBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_exponential_buffer_len(s : TimeseriesexponentialBuffer) -> Int { s.size }

pub fn timeseries_exponential_buffer_get(s : TimeseriesexponentialBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_exponential_buffer_set(s : TimeseriesexponentialBuffer, i : Int, v : Double) -> TimeseriesexponentialBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_exponential_buffer_sum(s : TimeseriesexponentialBuffer) -> Double { @_common.sum(s.data) }

pub fn timeseries_exponential_buffer_mean(s : TimeseriesexponentialBuffer) -> Double { @_common.mean(s.data) }

pub fn timeseries_exponential_buffer_scale(s : TimeseriesexponentialBuffer, f : Double) -> TimeseriesexponentialBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_exponential_buffer_add(a : TimeseriesexponentialBuffer, b : TimeseriesexponentialBuffer) -> TimeseriesexponentialBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_exponential_buffer_copy(s : TimeseriesexponentialBuffer) -> TimeseriesexponentialBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_exponential_buffer_fill(s : TimeseriesexponentialBuffer, v : Double) -> TimeseriesexponentialBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_exponential_buffer_min(s : TimeseriesexponentialBuffer) -> Double { @_common.min(s.data) }

pub fn timeseries_exponential_buffer_max(s : TimeseriesexponentialBuffer) -> Double { @_common.max(s.data) }

pub fn timeseries_exponential_buffer_to_string(s : TimeseriesexponentialBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesexponentialCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_exponential_cursor_make(size : Int) -> TimeseriesexponentialCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_exponential_cursor_len(s : TimeseriesexponentialCursor) -> Int { s.size }

pub fn timeseries_exponential_cursor_get(s : TimeseriesexponentialCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_exponential_cursor_set(s : TimeseriesexponentialCursor, i : Int, v : Double) -> TimeseriesexponentialCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_exponential_cursor_sum(s : TimeseriesexponentialCursor) -> Double { @_common.sum(s.data) }

pub fn timeseries_exponential_cursor_mean(s : TimeseriesexponentialCursor) -> Double { @_common.mean(s.data) }

pub fn timeseries_exponential_cursor_scale(s : TimeseriesexponentialCursor, f : Double) -> TimeseriesexponentialCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_exponential_cursor_add(a : TimeseriesexponentialCursor, b : TimeseriesexponentialCursor) -> TimeseriesexponentialCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_exponential_cursor_copy(s : TimeseriesexponentialCursor) -> TimeseriesexponentialCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_exponential_cursor_fill(s : TimeseriesexponentialCursor, v : Double) -> TimeseriesexponentialCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_exponential_cursor_min(s : TimeseriesexponentialCursor) -> Double { @_common.min(s.data) }

pub fn timeseries_exponential_cursor_max(s : TimeseriesexponentialCursor) -> Double { @_common.max(s.data) }

pub fn timeseries_exponential_cursor_to_string(s : TimeseriesexponentialCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesexponentialView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_exponential_view_make(size : Int) -> TimeseriesexponentialView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_exponential_view_len(s : TimeseriesexponentialView) -> Int { s.size }

pub fn timeseries_exponential_view_get(s : TimeseriesexponentialView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_exponential_view_set(s : TimeseriesexponentialView, i : Int, v : Double) -> TimeseriesexponentialView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_exponential_view_sum(s : TimeseriesexponentialView) -> Double { @_common.sum(s.data) }

pub fn timeseries_exponential_view_mean(s : TimeseriesexponentialView) -> Double { @_common.mean(s.data) }

pub fn timeseries_exponential_view_scale(s : TimeseriesexponentialView, f : Double) -> TimeseriesexponentialView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_exponential_view_add(a : TimeseriesexponentialView, b : TimeseriesexponentialView) -> TimeseriesexponentialView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_exponential_view_copy(s : TimeseriesexponentialView) -> TimeseriesexponentialView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_exponential_view_fill(s : TimeseriesexponentialView, v : Double) -> TimeseriesexponentialView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_exponential_view_min(s : TimeseriesexponentialView) -> Double { @_common.min(s.data) }

pub fn timeseries_exponential_view_max(s : TimeseriesexponentialView) -> Double { @_common.max(s.data) }

pub fn timeseries_exponential_view_to_string(s : TimeseriesexponentialView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesexponentialRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_exponential_range_make(size : Int) -> TimeseriesexponentialRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_exponential_range_len(s : TimeseriesexponentialRange) -> Int { s.size }

pub fn timeseries_exponential_range_get(s : TimeseriesexponentialRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_exponential_range_set(s : TimeseriesexponentialRange, i : Int, v : Double) -> TimeseriesexponentialRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_exponential_range_sum(s : TimeseriesexponentialRange) -> Double { @_common.sum(s.data) }

pub fn timeseries_exponential_range_mean(s : TimeseriesexponentialRange) -> Double { @_common.mean(s.data) }

pub fn timeseries_exponential_range_scale(s : TimeseriesexponentialRange, f : Double) -> TimeseriesexponentialRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_exponential_range_add(a : TimeseriesexponentialRange, b : TimeseriesexponentialRange) -> TimeseriesexponentialRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_exponential_range_copy(s : TimeseriesexponentialRange) -> TimeseriesexponentialRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_exponential_range_fill(s : TimeseriesexponentialRange, v : Double) -> TimeseriesexponentialRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_exponential_range_min(s : TimeseriesexponentialRange) -> Double { @_common.min(s.data) }

pub fn timeseries_exponential_range_max(s : TimeseriesexponentialRange) -> Double { @_common.max(s.data) }

pub fn timeseries_exponential_range_to_string(s : TimeseriesexponentialRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesexponentialSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_exponential_slice_make(size : Int) -> TimeseriesexponentialSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_exponential_slice_len(s : TimeseriesexponentialSlice) -> Int { s.size }

pub fn timeseries_exponential_slice_get(s : TimeseriesexponentialSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_exponential_slice_set(s : TimeseriesexponentialSlice, i : Int, v : Double) -> TimeseriesexponentialSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_exponential_slice_sum(s : TimeseriesexponentialSlice) -> Double { @_common.sum(s.data) }

pub fn timeseries_exponential_slice_mean(s : TimeseriesexponentialSlice) -> Double { @_common.mean(s.data) }

pub fn timeseries_exponential_slice_scale(s : TimeseriesexponentialSlice, f : Double) -> TimeseriesexponentialSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_exponential_slice_add(a : TimeseriesexponentialSlice, b : TimeseriesexponentialSlice) -> TimeseriesexponentialSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_exponential_slice_copy(s : TimeseriesexponentialSlice) -> TimeseriesexponentialSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_exponential_slice_fill(s : TimeseriesexponentialSlice, v : Double) -> TimeseriesexponentialSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_exponential_slice_min(s : TimeseriesexponentialSlice) -> Double { @_common.min(s.data) }

pub fn timeseries_exponential_slice_max(s : TimeseriesexponentialSlice) -> Double { @_common.max(s.data) }

pub fn timeseries_exponential_slice_to_string(s : TimeseriesexponentialSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

