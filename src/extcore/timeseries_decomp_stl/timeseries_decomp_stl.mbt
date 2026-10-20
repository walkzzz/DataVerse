///===
/// extcore/timeseries_decomp_stl

pub(all) struct TimeseriesdecompstlPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn timeseries_decomp_stl_make_point(x : Double, y : Double) -> TimeseriesdecompstlPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn timeseries_decomp_stl_make_point3(x : Double, y : Double, z : Double) -> TimeseriesdecompstlPoint {
  { x, y, z, label: 0 }
}

pub fn TimeseriesdecompstlPoint::x(self : TimeseriesdecompstlPoint) -> Double { self.x }

pub fn TimeseriesdecompstlPoint::y(self : TimeseriesdecompstlPoint) -> Double { self.y }

pub fn TimeseriesdecompstlPoint::z(self : TimeseriesdecompstlPoint) -> Double { self.z }

pub fn TimeseriesdecompstlPoint::label(self : TimeseriesdecompstlPoint) -> Int { self.label }

pub fn TimeseriesdecompstlPoint::dist(self : TimeseriesdecompstlPoint, other : TimeseriesdecompstlPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn TimeseriesdecompstlPoint::add(self : TimeseriesdecompstlPoint, other : TimeseriesdecompstlPoint) -> TimeseriesdecompstlPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn TimeseriesdecompstlPoint::sub(self : TimeseriesdecompstlPoint, other : TimeseriesdecompstlPoint) -> TimeseriesdecompstlPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn TimeseriesdecompstlPoint::scale(self : TimeseriesdecompstlPoint, s : Double) -> TimeseriesdecompstlPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn TimeseriesdecompstlPoint::dot(self : TimeseriesdecompstlPoint, other : TimeseriesdecompstlPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn TimeseriesdecompstlPoint::cross(self : TimeseriesdecompstlPoint, other : TimeseriesdecompstlPoint) -> TimeseriesdecompstlPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn TimeseriesdecompstlPoint::norm(self : TimeseriesdecompstlPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn TimeseriesdecompstlPoint::normalize(self : TimeseriesdecompstlPoint) -> TimeseriesdecompstlPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn TimeseriesdecompstlPoint::negate(self : TimeseriesdecompstlPoint) -> TimeseriesdecompstlPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn TimeseriesdecompstlPoint::mid(self : TimeseriesdecompstlPoint, other : TimeseriesdecompstlPoint) -> TimeseriesdecompstlPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn TimeseriesdecompstlPoint::lerp(self : TimeseriesdecompstlPoint, other : TimeseriesdecompstlPoint, t : Double) -> TimeseriesdecompstlPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn TimeseriesdecompstlPoint::to_string(self : TimeseriesdecompstlPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct TimeseriesdecompstlSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn timeseries_decomp_stl_make_series(vals : Array[Double], name : String) -> TimeseriesdecompstlSeries {
  { vals, name, meta: 0 }
}

pub fn TimeseriesdecompstlSeries::len(self : TimeseriesdecompstlSeries) -> Int { self.vals.length() }

pub fn TimeseriesdecompstlSeries::sum(self : TimeseriesdecompstlSeries) -> Double { @_common.sum(self.vals) }

pub fn TimeseriesdecompstlSeries::mean(self : TimeseriesdecompstlSeries) -> Double { @_common.mean(self.vals) }

pub fn TimeseriesdecompstlSeries::min(self : TimeseriesdecompstlSeries) -> Double { @_common.min(self.vals) }

pub fn TimeseriesdecompstlSeries::max(self : TimeseriesdecompstlSeries) -> Double { @_common.max(self.vals) }

pub fn TimeseriesdecompstlSeries::range(self : TimeseriesdecompstlSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn TimeseriesdecompstlSeries::variance(self : TimeseriesdecompstlSeries) -> Double { @_common.variance(self.vals) }

pub fn TimeseriesdecompstlSeries::std(self : TimeseriesdecompstlSeries) -> Double { @_common.std(self.vals) }

pub fn TimeseriesdecompstlSeries::median(self : TimeseriesdecompstlSeries) -> Double { @_common.median(self.vals) }

pub fn TimeseriesdecompstlSeries::scale(self : TimeseriesdecompstlSeries, f : Double) -> TimeseriesdecompstlSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn TimeseriesdecompstlSeries::add(self : TimeseriesdecompstlSeries, other : TimeseriesdecompstlSeries) -> TimeseriesdecompstlSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn TimeseriesdecompstlSeries::sub(self : TimeseriesdecompstlSeries, other : TimeseriesdecompstlSeries) -> TimeseriesdecompstlSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn TimeseriesdecompstlSeries::normalize(self : TimeseriesdecompstlSeries) -> TimeseriesdecompstlSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn TimeseriesdecompstlSeries::cumsum(self : TimeseriesdecompstlSeries) -> TimeseriesdecompstlSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn TimeseriesdecompstlSeries::to_string(self : TimeseriesdecompstlSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct TimeseriesdecompstlMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn timeseries_decomp_stl_make_matrix(rows : Int, cols : Int, val : Double) -> TimeseriesdecompstlMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn timeseries_decomp_stl_matrix_identity(n : Int) -> TimeseriesdecompstlMatrix {
  let m = timeseries_decomp_stl_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn TimeseriesdecompstlMatrix::get(self : TimeseriesdecompstlMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn TimeseriesdecompstlMatrix::transpose(self : TimeseriesdecompstlMatrix) -> TimeseriesdecompstlMatrix {
  let result = timeseries_decomp_stl_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn TimeseriesdecompstlMatrix::add(self : TimeseriesdecompstlMatrix, other : TimeseriesdecompstlMatrix) -> TimeseriesdecompstlMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = timeseries_decomp_stl_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn TimeseriesdecompstlMatrix::scale(self : TimeseriesdecompstlMatrix, s : Double) -> TimeseriesdecompstlMatrix {
  let result = timeseries_decomp_stl_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn TimeseriesdecompstlMatrix::multiply(self : TimeseriesdecompstlMatrix, other : TimeseriesdecompstlMatrix) -> TimeseriesdecompstlMatrix {
  if self.cols != other.rows { return timeseries_decomp_stl_make_matrix(self.rows, other.cols, 0.0) }
  let result = timeseries_decomp_stl_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn TimeseriesdecompstlMatrix::trace(self : TimeseriesdecompstlMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn TimeseriesdecompstlMatrix::det(self : TimeseriesdecompstlMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn TimeseriesdecompstlMatrix::norm(self : TimeseriesdecompstlMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn TimeseriesdecompstlMatrix::to_string(self : TimeseriesdecompstlMatrix) -> String {
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

pub(all) struct TimeseriesdecompstlVector {
  comps : Array[Double]
  dim : Int
}

pub fn timeseries_decomp_stl_make_vector(comps : Array[Double]) -> TimeseriesdecompstlVector {
  { comps, dim: comps.length() }
}

pub fn timeseries_decomp_stl_vector_zero(dim : Int) -> TimeseriesdecompstlVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn TimeseriesdecompstlVector::add(self : TimeseriesdecompstlVector, other : TimeseriesdecompstlVector) -> TimeseriesdecompstlVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn TimeseriesdecompstlVector::sub(self : TimeseriesdecompstlVector, other : TimeseriesdecompstlVector) -> TimeseriesdecompstlVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn TimeseriesdecompstlVector::scale(self : TimeseriesdecompstlVector, s : Double) -> TimeseriesdecompstlVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn TimeseriesdecompstlVector::dot(self : TimeseriesdecompstlVector, other : TimeseriesdecompstlVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn TimeseriesdecompstlVector::norm(self : TimeseriesdecompstlVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn TimeseriesdecompstlVector::normalize(self : TimeseriesdecompstlVector) -> TimeseriesdecompstlVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn TimeseriesdecompstlVector::dist(self : TimeseriesdecompstlVector, other : TimeseriesdecompstlVector) -> Double {
  self.sub(other).norm()
}

pub fn TimeseriesdecompstlVector::to_string(self : TimeseriesdecompstlVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn timeseries_decomp_stl_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn timeseries_decomp_stl_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn timeseries_decomp_stl_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn timeseries_decomp_stl_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn timeseries_decomp_stl_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn timeseries_decomp_stl_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn timeseries_decomp_stl_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn timeseries_decomp_stl_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn timeseries_decomp_stl_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn timeseries_decomp_stl_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn timeseries_decomp_stl_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn timeseries_decomp_stl_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn timeseries_decomp_stl_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn timeseries_decomp_stl_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn timeseries_decomp_stl_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn timeseries_decomp_stl_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn timeseries_decomp_stl_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn timeseries_decomp_stl_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn timeseries_decomp_stl_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn timeseries_decomp_stl_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn timeseries_decomp_stl_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn timeseries_decomp_stl_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn timeseries_decomp_stl_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn timeseries_decomp_stl_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn timeseries_decomp_stl_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn timeseries_decomp_stl_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn timeseries_decomp_stl_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn timeseries_decomp_stl_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn timeseries_decomp_stl_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct TimeseriesdecompstlFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_decomp_stl_frame_make(size : Int) -> TimeseriesdecompstlFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_decomp_stl_frame_len(s : TimeseriesdecompstlFrame) -> Int { s.size }

pub fn timeseries_decomp_stl_frame_get(s : TimeseriesdecompstlFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_decomp_stl_frame_set(s : TimeseriesdecompstlFrame, i : Int, v : Double) -> TimeseriesdecompstlFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_stl_frame_sum(s : TimeseriesdecompstlFrame) -> Double { @_common.sum(s.data) }

pub fn timeseries_decomp_stl_frame_mean(s : TimeseriesdecompstlFrame) -> Double { @_common.mean(s.data) }

pub fn timeseries_decomp_stl_frame_scale(s : TimeseriesdecompstlFrame, f : Double) -> TimeseriesdecompstlFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_stl_frame_add(a : TimeseriesdecompstlFrame, b : TimeseriesdecompstlFrame) -> TimeseriesdecompstlFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_decomp_stl_frame_copy(s : TimeseriesdecompstlFrame) -> TimeseriesdecompstlFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_stl_frame_fill(s : TimeseriesdecompstlFrame, v : Double) -> TimeseriesdecompstlFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_stl_frame_min(s : TimeseriesdecompstlFrame) -> Double { @_common.min(s.data) }

pub fn timeseries_decomp_stl_frame_max(s : TimeseriesdecompstlFrame) -> Double { @_common.max(s.data) }

pub fn timeseries_decomp_stl_frame_to_string(s : TimeseriesdecompstlFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesdecompstlTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_decomp_stl_table_make(size : Int) -> TimeseriesdecompstlTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_decomp_stl_table_len(s : TimeseriesdecompstlTable) -> Int { s.size }

pub fn timeseries_decomp_stl_table_get(s : TimeseriesdecompstlTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_decomp_stl_table_set(s : TimeseriesdecompstlTable, i : Int, v : Double) -> TimeseriesdecompstlTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_stl_table_sum(s : TimeseriesdecompstlTable) -> Double { @_common.sum(s.data) }

pub fn timeseries_decomp_stl_table_mean(s : TimeseriesdecompstlTable) -> Double { @_common.mean(s.data) }

pub fn timeseries_decomp_stl_table_scale(s : TimeseriesdecompstlTable, f : Double) -> TimeseriesdecompstlTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_stl_table_add(a : TimeseriesdecompstlTable, b : TimeseriesdecompstlTable) -> TimeseriesdecompstlTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_decomp_stl_table_copy(s : TimeseriesdecompstlTable) -> TimeseriesdecompstlTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_stl_table_fill(s : TimeseriesdecompstlTable, v : Double) -> TimeseriesdecompstlTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_stl_table_min(s : TimeseriesdecompstlTable) -> Double { @_common.min(s.data) }

pub fn timeseries_decomp_stl_table_max(s : TimeseriesdecompstlTable) -> Double { @_common.max(s.data) }

pub fn timeseries_decomp_stl_table_to_string(s : TimeseriesdecompstlTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesdecompstlGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_decomp_stl_graphn_make(size : Int) -> TimeseriesdecompstlGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_decomp_stl_graphn_len(s : TimeseriesdecompstlGraphN) -> Int { s.size }

pub fn timeseries_decomp_stl_graphn_get(s : TimeseriesdecompstlGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_decomp_stl_graphn_set(s : TimeseriesdecompstlGraphN, i : Int, v : Double) -> TimeseriesdecompstlGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_stl_graphn_sum(s : TimeseriesdecompstlGraphN) -> Double { @_common.sum(s.data) }

pub fn timeseries_decomp_stl_graphn_mean(s : TimeseriesdecompstlGraphN) -> Double { @_common.mean(s.data) }

pub fn timeseries_decomp_stl_graphn_scale(s : TimeseriesdecompstlGraphN, f : Double) -> TimeseriesdecompstlGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_stl_graphn_add(a : TimeseriesdecompstlGraphN, b : TimeseriesdecompstlGraphN) -> TimeseriesdecompstlGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_decomp_stl_graphn_copy(s : TimeseriesdecompstlGraphN) -> TimeseriesdecompstlGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_stl_graphn_fill(s : TimeseriesdecompstlGraphN, v : Double) -> TimeseriesdecompstlGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_stl_graphn_min(s : TimeseriesdecompstlGraphN) -> Double { @_common.min(s.data) }

pub fn timeseries_decomp_stl_graphn_max(s : TimeseriesdecompstlGraphN) -> Double { @_common.max(s.data) }

pub fn timeseries_decomp_stl_graphn_to_string(s : TimeseriesdecompstlGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesdecompstlNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_decomp_stl_node_make(size : Int) -> TimeseriesdecompstlNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_decomp_stl_node_len(s : TimeseriesdecompstlNode) -> Int { s.size }

pub fn timeseries_decomp_stl_node_get(s : TimeseriesdecompstlNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_decomp_stl_node_set(s : TimeseriesdecompstlNode, i : Int, v : Double) -> TimeseriesdecompstlNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_stl_node_sum(s : TimeseriesdecompstlNode) -> Double { @_common.sum(s.data) }

pub fn timeseries_decomp_stl_node_mean(s : TimeseriesdecompstlNode) -> Double { @_common.mean(s.data) }

pub fn timeseries_decomp_stl_node_scale(s : TimeseriesdecompstlNode, f : Double) -> TimeseriesdecompstlNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_stl_node_add(a : TimeseriesdecompstlNode, b : TimeseriesdecompstlNode) -> TimeseriesdecompstlNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_decomp_stl_node_copy(s : TimeseriesdecompstlNode) -> TimeseriesdecompstlNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_stl_node_fill(s : TimeseriesdecompstlNode, v : Double) -> TimeseriesdecompstlNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_stl_node_min(s : TimeseriesdecompstlNode) -> Double { @_common.min(s.data) }

pub fn timeseries_decomp_stl_node_max(s : TimeseriesdecompstlNode) -> Double { @_common.max(s.data) }

pub fn timeseries_decomp_stl_node_to_string(s : TimeseriesdecompstlNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesdecompstlEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_decomp_stl_edge_make(size : Int) -> TimeseriesdecompstlEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_decomp_stl_edge_len(s : TimeseriesdecompstlEdge) -> Int { s.size }

pub fn timeseries_decomp_stl_edge_get(s : TimeseriesdecompstlEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_decomp_stl_edge_set(s : TimeseriesdecompstlEdge, i : Int, v : Double) -> TimeseriesdecompstlEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_stl_edge_sum(s : TimeseriesdecompstlEdge) -> Double { @_common.sum(s.data) }

pub fn timeseries_decomp_stl_edge_mean(s : TimeseriesdecompstlEdge) -> Double { @_common.mean(s.data) }

pub fn timeseries_decomp_stl_edge_scale(s : TimeseriesdecompstlEdge, f : Double) -> TimeseriesdecompstlEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_stl_edge_add(a : TimeseriesdecompstlEdge, b : TimeseriesdecompstlEdge) -> TimeseriesdecompstlEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_decomp_stl_edge_copy(s : TimeseriesdecompstlEdge) -> TimeseriesdecompstlEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_stl_edge_fill(s : TimeseriesdecompstlEdge, v : Double) -> TimeseriesdecompstlEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_stl_edge_min(s : TimeseriesdecompstlEdge) -> Double { @_common.min(s.data) }

pub fn timeseries_decomp_stl_edge_max(s : TimeseriesdecompstlEdge) -> Double { @_common.max(s.data) }

pub fn timeseries_decomp_stl_edge_to_string(s : TimeseriesdecompstlEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesdecompstlPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_decomp_stl_path_make(size : Int) -> TimeseriesdecompstlPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_decomp_stl_path_len(s : TimeseriesdecompstlPath) -> Int { s.size }

pub fn timeseries_decomp_stl_path_get(s : TimeseriesdecompstlPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_decomp_stl_path_set(s : TimeseriesdecompstlPath, i : Int, v : Double) -> TimeseriesdecompstlPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_stl_path_sum(s : TimeseriesdecompstlPath) -> Double { @_common.sum(s.data) }

pub fn timeseries_decomp_stl_path_mean(s : TimeseriesdecompstlPath) -> Double { @_common.mean(s.data) }

pub fn timeseries_decomp_stl_path_scale(s : TimeseriesdecompstlPath, f : Double) -> TimeseriesdecompstlPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_stl_path_add(a : TimeseriesdecompstlPath, b : TimeseriesdecompstlPath) -> TimeseriesdecompstlPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_decomp_stl_path_copy(s : TimeseriesdecompstlPath) -> TimeseriesdecompstlPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_stl_path_fill(s : TimeseriesdecompstlPath, v : Double) -> TimeseriesdecompstlPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_stl_path_min(s : TimeseriesdecompstlPath) -> Double { @_common.min(s.data) }

pub fn timeseries_decomp_stl_path_max(s : TimeseriesdecompstlPath) -> Double { @_common.max(s.data) }

pub fn timeseries_decomp_stl_path_to_string(s : TimeseriesdecompstlPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesdecompstlCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_decomp_stl_cluster_make(size : Int) -> TimeseriesdecompstlCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_decomp_stl_cluster_len(s : TimeseriesdecompstlCluster) -> Int { s.size }

pub fn timeseries_decomp_stl_cluster_get(s : TimeseriesdecompstlCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_decomp_stl_cluster_set(s : TimeseriesdecompstlCluster, i : Int, v : Double) -> TimeseriesdecompstlCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_stl_cluster_sum(s : TimeseriesdecompstlCluster) -> Double { @_common.sum(s.data) }

pub fn timeseries_decomp_stl_cluster_mean(s : TimeseriesdecompstlCluster) -> Double { @_common.mean(s.data) }

pub fn timeseries_decomp_stl_cluster_scale(s : TimeseriesdecompstlCluster, f : Double) -> TimeseriesdecompstlCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_stl_cluster_add(a : TimeseriesdecompstlCluster, b : TimeseriesdecompstlCluster) -> TimeseriesdecompstlCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_decomp_stl_cluster_copy(s : TimeseriesdecompstlCluster) -> TimeseriesdecompstlCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_stl_cluster_fill(s : TimeseriesdecompstlCluster, v : Double) -> TimeseriesdecompstlCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_stl_cluster_min(s : TimeseriesdecompstlCluster) -> Double { @_common.min(s.data) }

pub fn timeseries_decomp_stl_cluster_max(s : TimeseriesdecompstlCluster) -> Double { @_common.max(s.data) }

pub fn timeseries_decomp_stl_cluster_to_string(s : TimeseriesdecompstlCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesdecompstlModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_decomp_stl_model_make(size : Int) -> TimeseriesdecompstlModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_decomp_stl_model_len(s : TimeseriesdecompstlModel) -> Int { s.size }

pub fn timeseries_decomp_stl_model_get(s : TimeseriesdecompstlModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_decomp_stl_model_set(s : TimeseriesdecompstlModel, i : Int, v : Double) -> TimeseriesdecompstlModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_stl_model_sum(s : TimeseriesdecompstlModel) -> Double { @_common.sum(s.data) }

pub fn timeseries_decomp_stl_model_mean(s : TimeseriesdecompstlModel) -> Double { @_common.mean(s.data) }

pub fn timeseries_decomp_stl_model_scale(s : TimeseriesdecompstlModel, f : Double) -> TimeseriesdecompstlModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_stl_model_add(a : TimeseriesdecompstlModel, b : TimeseriesdecompstlModel) -> TimeseriesdecompstlModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_decomp_stl_model_copy(s : TimeseriesdecompstlModel) -> TimeseriesdecompstlModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_stl_model_fill(s : TimeseriesdecompstlModel, v : Double) -> TimeseriesdecompstlModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_stl_model_min(s : TimeseriesdecompstlModel) -> Double { @_common.min(s.data) }

pub fn timeseries_decomp_stl_model_max(s : TimeseriesdecompstlModel) -> Double { @_common.max(s.data) }

pub fn timeseries_decomp_stl_model_to_string(s : TimeseriesdecompstlModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesdecompstlLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_decomp_stl_layer_make(size : Int) -> TimeseriesdecompstlLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_decomp_stl_layer_len(s : TimeseriesdecompstlLayer) -> Int { s.size }

pub fn timeseries_decomp_stl_layer_get(s : TimeseriesdecompstlLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_decomp_stl_layer_set(s : TimeseriesdecompstlLayer, i : Int, v : Double) -> TimeseriesdecompstlLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_stl_layer_sum(s : TimeseriesdecompstlLayer) -> Double { @_common.sum(s.data) }

pub fn timeseries_decomp_stl_layer_mean(s : TimeseriesdecompstlLayer) -> Double { @_common.mean(s.data) }

pub fn timeseries_decomp_stl_layer_scale(s : TimeseriesdecompstlLayer, f : Double) -> TimeseriesdecompstlLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_stl_layer_add(a : TimeseriesdecompstlLayer, b : TimeseriesdecompstlLayer) -> TimeseriesdecompstlLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_decomp_stl_layer_copy(s : TimeseriesdecompstlLayer) -> TimeseriesdecompstlLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_stl_layer_fill(s : TimeseriesdecompstlLayer, v : Double) -> TimeseriesdecompstlLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_stl_layer_min(s : TimeseriesdecompstlLayer) -> Double { @_common.min(s.data) }

pub fn timeseries_decomp_stl_layer_max(s : TimeseriesdecompstlLayer) -> Double { @_common.max(s.data) }

pub fn timeseries_decomp_stl_layer_to_string(s : TimeseriesdecompstlLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesdecompstlBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_decomp_stl_buffer_make(size : Int) -> TimeseriesdecompstlBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_decomp_stl_buffer_len(s : TimeseriesdecompstlBuffer) -> Int { s.size }

pub fn timeseries_decomp_stl_buffer_get(s : TimeseriesdecompstlBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_decomp_stl_buffer_set(s : TimeseriesdecompstlBuffer, i : Int, v : Double) -> TimeseriesdecompstlBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_stl_buffer_sum(s : TimeseriesdecompstlBuffer) -> Double { @_common.sum(s.data) }

pub fn timeseries_decomp_stl_buffer_mean(s : TimeseriesdecompstlBuffer) -> Double { @_common.mean(s.data) }

pub fn timeseries_decomp_stl_buffer_scale(s : TimeseriesdecompstlBuffer, f : Double) -> TimeseriesdecompstlBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_stl_buffer_add(a : TimeseriesdecompstlBuffer, b : TimeseriesdecompstlBuffer) -> TimeseriesdecompstlBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_decomp_stl_buffer_copy(s : TimeseriesdecompstlBuffer) -> TimeseriesdecompstlBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_stl_buffer_fill(s : TimeseriesdecompstlBuffer, v : Double) -> TimeseriesdecompstlBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_stl_buffer_min(s : TimeseriesdecompstlBuffer) -> Double { @_common.min(s.data) }

pub fn timeseries_decomp_stl_buffer_max(s : TimeseriesdecompstlBuffer) -> Double { @_common.max(s.data) }

pub fn timeseries_decomp_stl_buffer_to_string(s : TimeseriesdecompstlBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesdecompstlCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_decomp_stl_cursor_make(size : Int) -> TimeseriesdecompstlCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_decomp_stl_cursor_len(s : TimeseriesdecompstlCursor) -> Int { s.size }

pub fn timeseries_decomp_stl_cursor_get(s : TimeseriesdecompstlCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_decomp_stl_cursor_set(s : TimeseriesdecompstlCursor, i : Int, v : Double) -> TimeseriesdecompstlCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_stl_cursor_sum(s : TimeseriesdecompstlCursor) -> Double { @_common.sum(s.data) }

pub fn timeseries_decomp_stl_cursor_mean(s : TimeseriesdecompstlCursor) -> Double { @_common.mean(s.data) }

pub fn timeseries_decomp_stl_cursor_scale(s : TimeseriesdecompstlCursor, f : Double) -> TimeseriesdecompstlCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_stl_cursor_add(a : TimeseriesdecompstlCursor, b : TimeseriesdecompstlCursor) -> TimeseriesdecompstlCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_decomp_stl_cursor_copy(s : TimeseriesdecompstlCursor) -> TimeseriesdecompstlCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_stl_cursor_fill(s : TimeseriesdecompstlCursor, v : Double) -> TimeseriesdecompstlCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_stl_cursor_min(s : TimeseriesdecompstlCursor) -> Double { @_common.min(s.data) }

pub fn timeseries_decomp_stl_cursor_max(s : TimeseriesdecompstlCursor) -> Double { @_common.max(s.data) }

pub fn timeseries_decomp_stl_cursor_to_string(s : TimeseriesdecompstlCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesdecompstlView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_decomp_stl_view_make(size : Int) -> TimeseriesdecompstlView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_decomp_stl_view_len(s : TimeseriesdecompstlView) -> Int { s.size }

pub fn timeseries_decomp_stl_view_get(s : TimeseriesdecompstlView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_decomp_stl_view_set(s : TimeseriesdecompstlView, i : Int, v : Double) -> TimeseriesdecompstlView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_stl_view_sum(s : TimeseriesdecompstlView) -> Double { @_common.sum(s.data) }

pub fn timeseries_decomp_stl_view_mean(s : TimeseriesdecompstlView) -> Double { @_common.mean(s.data) }

pub fn timeseries_decomp_stl_view_scale(s : TimeseriesdecompstlView, f : Double) -> TimeseriesdecompstlView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_stl_view_add(a : TimeseriesdecompstlView, b : TimeseriesdecompstlView) -> TimeseriesdecompstlView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_decomp_stl_view_copy(s : TimeseriesdecompstlView) -> TimeseriesdecompstlView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_stl_view_fill(s : TimeseriesdecompstlView, v : Double) -> TimeseriesdecompstlView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_stl_view_min(s : TimeseriesdecompstlView) -> Double { @_common.min(s.data) }

pub fn timeseries_decomp_stl_view_max(s : TimeseriesdecompstlView) -> Double { @_common.max(s.data) }

pub fn timeseries_decomp_stl_view_to_string(s : TimeseriesdecompstlView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesdecompstlRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_decomp_stl_range_make(size : Int) -> TimeseriesdecompstlRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_decomp_stl_range_len(s : TimeseriesdecompstlRange) -> Int { s.size }

pub fn timeseries_decomp_stl_range_get(s : TimeseriesdecompstlRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_decomp_stl_range_set(s : TimeseriesdecompstlRange, i : Int, v : Double) -> TimeseriesdecompstlRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_stl_range_sum(s : TimeseriesdecompstlRange) -> Double { @_common.sum(s.data) }

pub fn timeseries_decomp_stl_range_mean(s : TimeseriesdecompstlRange) -> Double { @_common.mean(s.data) }

pub fn timeseries_decomp_stl_range_scale(s : TimeseriesdecompstlRange, f : Double) -> TimeseriesdecompstlRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_stl_range_add(a : TimeseriesdecompstlRange, b : TimeseriesdecompstlRange) -> TimeseriesdecompstlRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_decomp_stl_range_copy(s : TimeseriesdecompstlRange) -> TimeseriesdecompstlRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_stl_range_fill(s : TimeseriesdecompstlRange, v : Double) -> TimeseriesdecompstlRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_stl_range_min(s : TimeseriesdecompstlRange) -> Double { @_common.min(s.data) }

pub fn timeseries_decomp_stl_range_max(s : TimeseriesdecompstlRange) -> Double { @_common.max(s.data) }

pub fn timeseries_decomp_stl_range_to_string(s : TimeseriesdecompstlRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesdecompstlSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_decomp_stl_slice_make(size : Int) -> TimeseriesdecompstlSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_decomp_stl_slice_len(s : TimeseriesdecompstlSlice) -> Int { s.size }

pub fn timeseries_decomp_stl_slice_get(s : TimeseriesdecompstlSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_decomp_stl_slice_set(s : TimeseriesdecompstlSlice, i : Int, v : Double) -> TimeseriesdecompstlSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_stl_slice_sum(s : TimeseriesdecompstlSlice) -> Double { @_common.sum(s.data) }

pub fn timeseries_decomp_stl_slice_mean(s : TimeseriesdecompstlSlice) -> Double { @_common.mean(s.data) }

pub fn timeseries_decomp_stl_slice_scale(s : TimeseriesdecompstlSlice, f : Double) -> TimeseriesdecompstlSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_stl_slice_add(a : TimeseriesdecompstlSlice, b : TimeseriesdecompstlSlice) -> TimeseriesdecompstlSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_decomp_stl_slice_copy(s : TimeseriesdecompstlSlice) -> TimeseriesdecompstlSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_stl_slice_fill(s : TimeseriesdecompstlSlice, v : Double) -> TimeseriesdecompstlSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_stl_slice_min(s : TimeseriesdecompstlSlice) -> Double { @_common.min(s.data) }

pub fn timeseries_decomp_stl_slice_max(s : TimeseriesdecompstlSlice) -> Double { @_common.max(s.data) }

pub fn timeseries_decomp_stl_slice_to_string(s : TimeseriesdecompstlSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

