///===
/// extcore/timeseries_decomp_classical

pub(all) struct TimeseriesdecompclassicalPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn timeseries_decomp_classical_make_point(x : Double, y : Double) -> TimeseriesdecompclassicalPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn timeseries_decomp_classical_make_point3(x : Double, y : Double, z : Double) -> TimeseriesdecompclassicalPoint {
  { x, y, z, label: 0 }
}

pub fn TimeseriesdecompclassicalPoint::x(self : TimeseriesdecompclassicalPoint) -> Double { self.x }

pub fn TimeseriesdecompclassicalPoint::y(self : TimeseriesdecompclassicalPoint) -> Double { self.y }

pub fn TimeseriesdecompclassicalPoint::z(self : TimeseriesdecompclassicalPoint) -> Double { self.z }

pub fn TimeseriesdecompclassicalPoint::label(self : TimeseriesdecompclassicalPoint) -> Int { self.label }

pub fn TimeseriesdecompclassicalPoint::dist(self : TimeseriesdecompclassicalPoint, other : TimeseriesdecompclassicalPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn TimeseriesdecompclassicalPoint::add(self : TimeseriesdecompclassicalPoint, other : TimeseriesdecompclassicalPoint) -> TimeseriesdecompclassicalPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn TimeseriesdecompclassicalPoint::sub(self : TimeseriesdecompclassicalPoint, other : TimeseriesdecompclassicalPoint) -> TimeseriesdecompclassicalPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn TimeseriesdecompclassicalPoint::scale(self : TimeseriesdecompclassicalPoint, s : Double) -> TimeseriesdecompclassicalPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn TimeseriesdecompclassicalPoint::dot(self : TimeseriesdecompclassicalPoint, other : TimeseriesdecompclassicalPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn TimeseriesdecompclassicalPoint::cross(self : TimeseriesdecompclassicalPoint, other : TimeseriesdecompclassicalPoint) -> TimeseriesdecompclassicalPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn TimeseriesdecompclassicalPoint::norm(self : TimeseriesdecompclassicalPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn TimeseriesdecompclassicalPoint::normalize(self : TimeseriesdecompclassicalPoint) -> TimeseriesdecompclassicalPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn TimeseriesdecompclassicalPoint::negate(self : TimeseriesdecompclassicalPoint) -> TimeseriesdecompclassicalPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn TimeseriesdecompclassicalPoint::mid(self : TimeseriesdecompclassicalPoint, other : TimeseriesdecompclassicalPoint) -> TimeseriesdecompclassicalPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn TimeseriesdecompclassicalPoint::lerp(self : TimeseriesdecompclassicalPoint, other : TimeseriesdecompclassicalPoint, t : Double) -> TimeseriesdecompclassicalPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn TimeseriesdecompclassicalPoint::to_string(self : TimeseriesdecompclassicalPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct TimeseriesdecompclassicalSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn timeseries_decomp_classical_make_series(vals : Array[Double], name : String) -> TimeseriesdecompclassicalSeries {
  { vals, name, meta: 0 }
}

pub fn TimeseriesdecompclassicalSeries::len(self : TimeseriesdecompclassicalSeries) -> Int { self.vals.length() }

pub fn TimeseriesdecompclassicalSeries::sum(self : TimeseriesdecompclassicalSeries) -> Double { @_common.sum(self.vals) }

pub fn TimeseriesdecompclassicalSeries::mean(self : TimeseriesdecompclassicalSeries) -> Double { @_common.mean(self.vals) }

pub fn TimeseriesdecompclassicalSeries::min(self : TimeseriesdecompclassicalSeries) -> Double { @_common.min(self.vals) }

pub fn TimeseriesdecompclassicalSeries::max(self : TimeseriesdecompclassicalSeries) -> Double { @_common.max(self.vals) }

pub fn TimeseriesdecompclassicalSeries::range(self : TimeseriesdecompclassicalSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn TimeseriesdecompclassicalSeries::variance(self : TimeseriesdecompclassicalSeries) -> Double { @_common.variance(self.vals) }

pub fn TimeseriesdecompclassicalSeries::std(self : TimeseriesdecompclassicalSeries) -> Double { @_common.std(self.vals) }

pub fn TimeseriesdecompclassicalSeries::median(self : TimeseriesdecompclassicalSeries) -> Double { @_common.median(self.vals) }

pub fn TimeseriesdecompclassicalSeries::scale(self : TimeseriesdecompclassicalSeries, f : Double) -> TimeseriesdecompclassicalSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn TimeseriesdecompclassicalSeries::add(self : TimeseriesdecompclassicalSeries, other : TimeseriesdecompclassicalSeries) -> TimeseriesdecompclassicalSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn TimeseriesdecompclassicalSeries::sub(self : TimeseriesdecompclassicalSeries, other : TimeseriesdecompclassicalSeries) -> TimeseriesdecompclassicalSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn TimeseriesdecompclassicalSeries::normalize(self : TimeseriesdecompclassicalSeries) -> TimeseriesdecompclassicalSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn TimeseriesdecompclassicalSeries::cumsum(self : TimeseriesdecompclassicalSeries) -> TimeseriesdecompclassicalSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn TimeseriesdecompclassicalSeries::to_string(self : TimeseriesdecompclassicalSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct TimeseriesdecompclassicalMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn timeseries_decomp_classical_make_matrix(rows : Int, cols : Int, val : Double) -> TimeseriesdecompclassicalMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn timeseries_decomp_classical_matrix_identity(n : Int) -> TimeseriesdecompclassicalMatrix {
  let m = timeseries_decomp_classical_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn TimeseriesdecompclassicalMatrix::get(self : TimeseriesdecompclassicalMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn TimeseriesdecompclassicalMatrix::transpose(self : TimeseriesdecompclassicalMatrix) -> TimeseriesdecompclassicalMatrix {
  let result = timeseries_decomp_classical_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn TimeseriesdecompclassicalMatrix::add(self : TimeseriesdecompclassicalMatrix, other : TimeseriesdecompclassicalMatrix) -> TimeseriesdecompclassicalMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = timeseries_decomp_classical_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn TimeseriesdecompclassicalMatrix::scale(self : TimeseriesdecompclassicalMatrix, s : Double) -> TimeseriesdecompclassicalMatrix {
  let result = timeseries_decomp_classical_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn TimeseriesdecompclassicalMatrix::multiply(self : TimeseriesdecompclassicalMatrix, other : TimeseriesdecompclassicalMatrix) -> TimeseriesdecompclassicalMatrix {
  if self.cols != other.rows { return timeseries_decomp_classical_make_matrix(self.rows, other.cols, 0.0) }
  let result = timeseries_decomp_classical_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn TimeseriesdecompclassicalMatrix::trace(self : TimeseriesdecompclassicalMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn TimeseriesdecompclassicalMatrix::det(self : TimeseriesdecompclassicalMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn TimeseriesdecompclassicalMatrix::norm(self : TimeseriesdecompclassicalMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn TimeseriesdecompclassicalMatrix::to_string(self : TimeseriesdecompclassicalMatrix) -> String {
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

pub(all) struct TimeseriesdecompclassicalVector {
  comps : Array[Double]
  dim : Int
}

pub fn timeseries_decomp_classical_make_vector(comps : Array[Double]) -> TimeseriesdecompclassicalVector {
  { comps, dim: comps.length() }
}

pub fn timeseries_decomp_classical_vector_zero(dim : Int) -> TimeseriesdecompclassicalVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn TimeseriesdecompclassicalVector::add(self : TimeseriesdecompclassicalVector, other : TimeseriesdecompclassicalVector) -> TimeseriesdecompclassicalVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn TimeseriesdecompclassicalVector::sub(self : TimeseriesdecompclassicalVector, other : TimeseriesdecompclassicalVector) -> TimeseriesdecompclassicalVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn TimeseriesdecompclassicalVector::scale(self : TimeseriesdecompclassicalVector, s : Double) -> TimeseriesdecompclassicalVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn TimeseriesdecompclassicalVector::dot(self : TimeseriesdecompclassicalVector, other : TimeseriesdecompclassicalVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn TimeseriesdecompclassicalVector::norm(self : TimeseriesdecompclassicalVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn TimeseriesdecompclassicalVector::normalize(self : TimeseriesdecompclassicalVector) -> TimeseriesdecompclassicalVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn TimeseriesdecompclassicalVector::dist(self : TimeseriesdecompclassicalVector, other : TimeseriesdecompclassicalVector) -> Double {
  self.sub(other).norm()
}

pub fn TimeseriesdecompclassicalVector::to_string(self : TimeseriesdecompclassicalVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn timeseries_decomp_classical_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn timeseries_decomp_classical_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn timeseries_decomp_classical_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn timeseries_decomp_classical_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn timeseries_decomp_classical_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn timeseries_decomp_classical_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn timeseries_decomp_classical_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn timeseries_decomp_classical_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn timeseries_decomp_classical_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn timeseries_decomp_classical_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn timeseries_decomp_classical_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn timeseries_decomp_classical_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn timeseries_decomp_classical_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn timeseries_decomp_classical_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn timeseries_decomp_classical_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn timeseries_decomp_classical_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn timeseries_decomp_classical_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn timeseries_decomp_classical_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn timeseries_decomp_classical_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn timeseries_decomp_classical_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn timeseries_decomp_classical_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn timeseries_decomp_classical_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn timeseries_decomp_classical_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn timeseries_decomp_classical_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn timeseries_decomp_classical_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn timeseries_decomp_classical_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn timeseries_decomp_classical_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn timeseries_decomp_classical_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn timeseries_decomp_classical_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct TimeseriesdecompclassicalFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_decomp_classical_frame_make(size : Int) -> TimeseriesdecompclassicalFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_decomp_classical_frame_len(s : TimeseriesdecompclassicalFrame) -> Int { s.size }

pub fn timeseries_decomp_classical_frame_get(s : TimeseriesdecompclassicalFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_decomp_classical_frame_set(s : TimeseriesdecompclassicalFrame, i : Int, v : Double) -> TimeseriesdecompclassicalFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_classical_frame_sum(s : TimeseriesdecompclassicalFrame) -> Double { @_common.sum(s.data) }

pub fn timeseries_decomp_classical_frame_mean(s : TimeseriesdecompclassicalFrame) -> Double { @_common.mean(s.data) }

pub fn timeseries_decomp_classical_frame_scale(s : TimeseriesdecompclassicalFrame, f : Double) -> TimeseriesdecompclassicalFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_classical_frame_add(a : TimeseriesdecompclassicalFrame, b : TimeseriesdecompclassicalFrame) -> TimeseriesdecompclassicalFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_decomp_classical_frame_copy(s : TimeseriesdecompclassicalFrame) -> TimeseriesdecompclassicalFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_classical_frame_fill(s : TimeseriesdecompclassicalFrame, v : Double) -> TimeseriesdecompclassicalFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_classical_frame_min(s : TimeseriesdecompclassicalFrame) -> Double { @_common.min(s.data) }

pub fn timeseries_decomp_classical_frame_max(s : TimeseriesdecompclassicalFrame) -> Double { @_common.max(s.data) }

pub fn timeseries_decomp_classical_frame_to_string(s : TimeseriesdecompclassicalFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesdecompclassicalTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_decomp_classical_table_make(size : Int) -> TimeseriesdecompclassicalTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_decomp_classical_table_len(s : TimeseriesdecompclassicalTable) -> Int { s.size }

pub fn timeseries_decomp_classical_table_get(s : TimeseriesdecompclassicalTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_decomp_classical_table_set(s : TimeseriesdecompclassicalTable, i : Int, v : Double) -> TimeseriesdecompclassicalTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_classical_table_sum(s : TimeseriesdecompclassicalTable) -> Double { @_common.sum(s.data) }

pub fn timeseries_decomp_classical_table_mean(s : TimeseriesdecompclassicalTable) -> Double { @_common.mean(s.data) }

pub fn timeseries_decomp_classical_table_scale(s : TimeseriesdecompclassicalTable, f : Double) -> TimeseriesdecompclassicalTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_classical_table_add(a : TimeseriesdecompclassicalTable, b : TimeseriesdecompclassicalTable) -> TimeseriesdecompclassicalTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_decomp_classical_table_copy(s : TimeseriesdecompclassicalTable) -> TimeseriesdecompclassicalTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_classical_table_fill(s : TimeseriesdecompclassicalTable, v : Double) -> TimeseriesdecompclassicalTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_classical_table_min(s : TimeseriesdecompclassicalTable) -> Double { @_common.min(s.data) }

pub fn timeseries_decomp_classical_table_max(s : TimeseriesdecompclassicalTable) -> Double { @_common.max(s.data) }

pub fn timeseries_decomp_classical_table_to_string(s : TimeseriesdecompclassicalTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesdecompclassicalGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_decomp_classical_graphn_make(size : Int) -> TimeseriesdecompclassicalGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_decomp_classical_graphn_len(s : TimeseriesdecompclassicalGraphN) -> Int { s.size }

pub fn timeseries_decomp_classical_graphn_get(s : TimeseriesdecompclassicalGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_decomp_classical_graphn_set(s : TimeseriesdecompclassicalGraphN, i : Int, v : Double) -> TimeseriesdecompclassicalGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_classical_graphn_sum(s : TimeseriesdecompclassicalGraphN) -> Double { @_common.sum(s.data) }

pub fn timeseries_decomp_classical_graphn_mean(s : TimeseriesdecompclassicalGraphN) -> Double { @_common.mean(s.data) }

pub fn timeseries_decomp_classical_graphn_scale(s : TimeseriesdecompclassicalGraphN, f : Double) -> TimeseriesdecompclassicalGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_classical_graphn_add(a : TimeseriesdecompclassicalGraphN, b : TimeseriesdecompclassicalGraphN) -> TimeseriesdecompclassicalGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_decomp_classical_graphn_copy(s : TimeseriesdecompclassicalGraphN) -> TimeseriesdecompclassicalGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_classical_graphn_fill(s : TimeseriesdecompclassicalGraphN, v : Double) -> TimeseriesdecompclassicalGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_classical_graphn_min(s : TimeseriesdecompclassicalGraphN) -> Double { @_common.min(s.data) }

pub fn timeseries_decomp_classical_graphn_max(s : TimeseriesdecompclassicalGraphN) -> Double { @_common.max(s.data) }

pub fn timeseries_decomp_classical_graphn_to_string(s : TimeseriesdecompclassicalGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesdecompclassicalNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_decomp_classical_node_make(size : Int) -> TimeseriesdecompclassicalNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_decomp_classical_node_len(s : TimeseriesdecompclassicalNode) -> Int { s.size }

pub fn timeseries_decomp_classical_node_get(s : TimeseriesdecompclassicalNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_decomp_classical_node_set(s : TimeseriesdecompclassicalNode, i : Int, v : Double) -> TimeseriesdecompclassicalNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_classical_node_sum(s : TimeseriesdecompclassicalNode) -> Double { @_common.sum(s.data) }

pub fn timeseries_decomp_classical_node_mean(s : TimeseriesdecompclassicalNode) -> Double { @_common.mean(s.data) }

pub fn timeseries_decomp_classical_node_scale(s : TimeseriesdecompclassicalNode, f : Double) -> TimeseriesdecompclassicalNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_classical_node_add(a : TimeseriesdecompclassicalNode, b : TimeseriesdecompclassicalNode) -> TimeseriesdecompclassicalNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_decomp_classical_node_copy(s : TimeseriesdecompclassicalNode) -> TimeseriesdecompclassicalNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_classical_node_fill(s : TimeseriesdecompclassicalNode, v : Double) -> TimeseriesdecompclassicalNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_classical_node_min(s : TimeseriesdecompclassicalNode) -> Double { @_common.min(s.data) }

pub fn timeseries_decomp_classical_node_max(s : TimeseriesdecompclassicalNode) -> Double { @_common.max(s.data) }

pub fn timeseries_decomp_classical_node_to_string(s : TimeseriesdecompclassicalNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesdecompclassicalEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_decomp_classical_edge_make(size : Int) -> TimeseriesdecompclassicalEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_decomp_classical_edge_len(s : TimeseriesdecompclassicalEdge) -> Int { s.size }

pub fn timeseries_decomp_classical_edge_get(s : TimeseriesdecompclassicalEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_decomp_classical_edge_set(s : TimeseriesdecompclassicalEdge, i : Int, v : Double) -> TimeseriesdecompclassicalEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_classical_edge_sum(s : TimeseriesdecompclassicalEdge) -> Double { @_common.sum(s.data) }

pub fn timeseries_decomp_classical_edge_mean(s : TimeseriesdecompclassicalEdge) -> Double { @_common.mean(s.data) }

pub fn timeseries_decomp_classical_edge_scale(s : TimeseriesdecompclassicalEdge, f : Double) -> TimeseriesdecompclassicalEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_classical_edge_add(a : TimeseriesdecompclassicalEdge, b : TimeseriesdecompclassicalEdge) -> TimeseriesdecompclassicalEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_decomp_classical_edge_copy(s : TimeseriesdecompclassicalEdge) -> TimeseriesdecompclassicalEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_classical_edge_fill(s : TimeseriesdecompclassicalEdge, v : Double) -> TimeseriesdecompclassicalEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_classical_edge_min(s : TimeseriesdecompclassicalEdge) -> Double { @_common.min(s.data) }

pub fn timeseries_decomp_classical_edge_max(s : TimeseriesdecompclassicalEdge) -> Double { @_common.max(s.data) }

pub fn timeseries_decomp_classical_edge_to_string(s : TimeseriesdecompclassicalEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesdecompclassicalPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_decomp_classical_path_make(size : Int) -> TimeseriesdecompclassicalPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_decomp_classical_path_len(s : TimeseriesdecompclassicalPath) -> Int { s.size }

pub fn timeseries_decomp_classical_path_get(s : TimeseriesdecompclassicalPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_decomp_classical_path_set(s : TimeseriesdecompclassicalPath, i : Int, v : Double) -> TimeseriesdecompclassicalPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_classical_path_sum(s : TimeseriesdecompclassicalPath) -> Double { @_common.sum(s.data) }

pub fn timeseries_decomp_classical_path_mean(s : TimeseriesdecompclassicalPath) -> Double { @_common.mean(s.data) }

pub fn timeseries_decomp_classical_path_scale(s : TimeseriesdecompclassicalPath, f : Double) -> TimeseriesdecompclassicalPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_classical_path_add(a : TimeseriesdecompclassicalPath, b : TimeseriesdecompclassicalPath) -> TimeseriesdecompclassicalPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_decomp_classical_path_copy(s : TimeseriesdecompclassicalPath) -> TimeseriesdecompclassicalPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_classical_path_fill(s : TimeseriesdecompclassicalPath, v : Double) -> TimeseriesdecompclassicalPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_classical_path_min(s : TimeseriesdecompclassicalPath) -> Double { @_common.min(s.data) }

pub fn timeseries_decomp_classical_path_max(s : TimeseriesdecompclassicalPath) -> Double { @_common.max(s.data) }

pub fn timeseries_decomp_classical_path_to_string(s : TimeseriesdecompclassicalPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesdecompclassicalCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_decomp_classical_cluster_make(size : Int) -> TimeseriesdecompclassicalCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_decomp_classical_cluster_len(s : TimeseriesdecompclassicalCluster) -> Int { s.size }

pub fn timeseries_decomp_classical_cluster_get(s : TimeseriesdecompclassicalCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_decomp_classical_cluster_set(s : TimeseriesdecompclassicalCluster, i : Int, v : Double) -> TimeseriesdecompclassicalCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_classical_cluster_sum(s : TimeseriesdecompclassicalCluster) -> Double { @_common.sum(s.data) }

pub fn timeseries_decomp_classical_cluster_mean(s : TimeseriesdecompclassicalCluster) -> Double { @_common.mean(s.data) }

pub fn timeseries_decomp_classical_cluster_scale(s : TimeseriesdecompclassicalCluster, f : Double) -> TimeseriesdecompclassicalCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_classical_cluster_add(a : TimeseriesdecompclassicalCluster, b : TimeseriesdecompclassicalCluster) -> TimeseriesdecompclassicalCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_decomp_classical_cluster_copy(s : TimeseriesdecompclassicalCluster) -> TimeseriesdecompclassicalCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_classical_cluster_fill(s : TimeseriesdecompclassicalCluster, v : Double) -> TimeseriesdecompclassicalCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_classical_cluster_min(s : TimeseriesdecompclassicalCluster) -> Double { @_common.min(s.data) }

pub fn timeseries_decomp_classical_cluster_max(s : TimeseriesdecompclassicalCluster) -> Double { @_common.max(s.data) }

pub fn timeseries_decomp_classical_cluster_to_string(s : TimeseriesdecompclassicalCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesdecompclassicalModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_decomp_classical_model_make(size : Int) -> TimeseriesdecompclassicalModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_decomp_classical_model_len(s : TimeseriesdecompclassicalModel) -> Int { s.size }

pub fn timeseries_decomp_classical_model_get(s : TimeseriesdecompclassicalModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_decomp_classical_model_set(s : TimeseriesdecompclassicalModel, i : Int, v : Double) -> TimeseriesdecompclassicalModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_classical_model_sum(s : TimeseriesdecompclassicalModel) -> Double { @_common.sum(s.data) }

pub fn timeseries_decomp_classical_model_mean(s : TimeseriesdecompclassicalModel) -> Double { @_common.mean(s.data) }

pub fn timeseries_decomp_classical_model_scale(s : TimeseriesdecompclassicalModel, f : Double) -> TimeseriesdecompclassicalModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_classical_model_add(a : TimeseriesdecompclassicalModel, b : TimeseriesdecompclassicalModel) -> TimeseriesdecompclassicalModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_decomp_classical_model_copy(s : TimeseriesdecompclassicalModel) -> TimeseriesdecompclassicalModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_classical_model_fill(s : TimeseriesdecompclassicalModel, v : Double) -> TimeseriesdecompclassicalModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_classical_model_min(s : TimeseriesdecompclassicalModel) -> Double { @_common.min(s.data) }

pub fn timeseries_decomp_classical_model_max(s : TimeseriesdecompclassicalModel) -> Double { @_common.max(s.data) }

pub fn timeseries_decomp_classical_model_to_string(s : TimeseriesdecompclassicalModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesdecompclassicalLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_decomp_classical_layer_make(size : Int) -> TimeseriesdecompclassicalLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_decomp_classical_layer_len(s : TimeseriesdecompclassicalLayer) -> Int { s.size }

pub fn timeseries_decomp_classical_layer_get(s : TimeseriesdecompclassicalLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_decomp_classical_layer_set(s : TimeseriesdecompclassicalLayer, i : Int, v : Double) -> TimeseriesdecompclassicalLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_classical_layer_sum(s : TimeseriesdecompclassicalLayer) -> Double { @_common.sum(s.data) }

pub fn timeseries_decomp_classical_layer_mean(s : TimeseriesdecompclassicalLayer) -> Double { @_common.mean(s.data) }

pub fn timeseries_decomp_classical_layer_scale(s : TimeseriesdecompclassicalLayer, f : Double) -> TimeseriesdecompclassicalLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_classical_layer_add(a : TimeseriesdecompclassicalLayer, b : TimeseriesdecompclassicalLayer) -> TimeseriesdecompclassicalLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_decomp_classical_layer_copy(s : TimeseriesdecompclassicalLayer) -> TimeseriesdecompclassicalLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_classical_layer_fill(s : TimeseriesdecompclassicalLayer, v : Double) -> TimeseriesdecompclassicalLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_classical_layer_min(s : TimeseriesdecompclassicalLayer) -> Double { @_common.min(s.data) }

pub fn timeseries_decomp_classical_layer_max(s : TimeseriesdecompclassicalLayer) -> Double { @_common.max(s.data) }

pub fn timeseries_decomp_classical_layer_to_string(s : TimeseriesdecompclassicalLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesdecompclassicalBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_decomp_classical_buffer_make(size : Int) -> TimeseriesdecompclassicalBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_decomp_classical_buffer_len(s : TimeseriesdecompclassicalBuffer) -> Int { s.size }

pub fn timeseries_decomp_classical_buffer_get(s : TimeseriesdecompclassicalBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_decomp_classical_buffer_set(s : TimeseriesdecompclassicalBuffer, i : Int, v : Double) -> TimeseriesdecompclassicalBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_classical_buffer_sum(s : TimeseriesdecompclassicalBuffer) -> Double { @_common.sum(s.data) }

pub fn timeseries_decomp_classical_buffer_mean(s : TimeseriesdecompclassicalBuffer) -> Double { @_common.mean(s.data) }

pub fn timeseries_decomp_classical_buffer_scale(s : TimeseriesdecompclassicalBuffer, f : Double) -> TimeseriesdecompclassicalBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_classical_buffer_add(a : TimeseriesdecompclassicalBuffer, b : TimeseriesdecompclassicalBuffer) -> TimeseriesdecompclassicalBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_decomp_classical_buffer_copy(s : TimeseriesdecompclassicalBuffer) -> TimeseriesdecompclassicalBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_classical_buffer_fill(s : TimeseriesdecompclassicalBuffer, v : Double) -> TimeseriesdecompclassicalBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_classical_buffer_min(s : TimeseriesdecompclassicalBuffer) -> Double { @_common.min(s.data) }

pub fn timeseries_decomp_classical_buffer_max(s : TimeseriesdecompclassicalBuffer) -> Double { @_common.max(s.data) }

pub fn timeseries_decomp_classical_buffer_to_string(s : TimeseriesdecompclassicalBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesdecompclassicalCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_decomp_classical_cursor_make(size : Int) -> TimeseriesdecompclassicalCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_decomp_classical_cursor_len(s : TimeseriesdecompclassicalCursor) -> Int { s.size }

pub fn timeseries_decomp_classical_cursor_get(s : TimeseriesdecompclassicalCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_decomp_classical_cursor_set(s : TimeseriesdecompclassicalCursor, i : Int, v : Double) -> TimeseriesdecompclassicalCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_classical_cursor_sum(s : TimeseriesdecompclassicalCursor) -> Double { @_common.sum(s.data) }

pub fn timeseries_decomp_classical_cursor_mean(s : TimeseriesdecompclassicalCursor) -> Double { @_common.mean(s.data) }

pub fn timeseries_decomp_classical_cursor_scale(s : TimeseriesdecompclassicalCursor, f : Double) -> TimeseriesdecompclassicalCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_classical_cursor_add(a : TimeseriesdecompclassicalCursor, b : TimeseriesdecompclassicalCursor) -> TimeseriesdecompclassicalCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_decomp_classical_cursor_copy(s : TimeseriesdecompclassicalCursor) -> TimeseriesdecompclassicalCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_classical_cursor_fill(s : TimeseriesdecompclassicalCursor, v : Double) -> TimeseriesdecompclassicalCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_classical_cursor_min(s : TimeseriesdecompclassicalCursor) -> Double { @_common.min(s.data) }

pub fn timeseries_decomp_classical_cursor_max(s : TimeseriesdecompclassicalCursor) -> Double { @_common.max(s.data) }

pub fn timeseries_decomp_classical_cursor_to_string(s : TimeseriesdecompclassicalCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesdecompclassicalView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_decomp_classical_view_make(size : Int) -> TimeseriesdecompclassicalView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_decomp_classical_view_len(s : TimeseriesdecompclassicalView) -> Int { s.size }

pub fn timeseries_decomp_classical_view_get(s : TimeseriesdecompclassicalView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_decomp_classical_view_set(s : TimeseriesdecompclassicalView, i : Int, v : Double) -> TimeseriesdecompclassicalView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_classical_view_sum(s : TimeseriesdecompclassicalView) -> Double { @_common.sum(s.data) }

pub fn timeseries_decomp_classical_view_mean(s : TimeseriesdecompclassicalView) -> Double { @_common.mean(s.data) }

pub fn timeseries_decomp_classical_view_scale(s : TimeseriesdecompclassicalView, f : Double) -> TimeseriesdecompclassicalView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_classical_view_add(a : TimeseriesdecompclassicalView, b : TimeseriesdecompclassicalView) -> TimeseriesdecompclassicalView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_decomp_classical_view_copy(s : TimeseriesdecompclassicalView) -> TimeseriesdecompclassicalView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_classical_view_fill(s : TimeseriesdecompclassicalView, v : Double) -> TimeseriesdecompclassicalView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_classical_view_min(s : TimeseriesdecompclassicalView) -> Double { @_common.min(s.data) }

pub fn timeseries_decomp_classical_view_max(s : TimeseriesdecompclassicalView) -> Double { @_common.max(s.data) }

pub fn timeseries_decomp_classical_view_to_string(s : TimeseriesdecompclassicalView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesdecompclassicalRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_decomp_classical_range_make(size : Int) -> TimeseriesdecompclassicalRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_decomp_classical_range_len(s : TimeseriesdecompclassicalRange) -> Int { s.size }

pub fn timeseries_decomp_classical_range_get(s : TimeseriesdecompclassicalRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_decomp_classical_range_set(s : TimeseriesdecompclassicalRange, i : Int, v : Double) -> TimeseriesdecompclassicalRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_classical_range_sum(s : TimeseriesdecompclassicalRange) -> Double { @_common.sum(s.data) }

pub fn timeseries_decomp_classical_range_mean(s : TimeseriesdecompclassicalRange) -> Double { @_common.mean(s.data) }

pub fn timeseries_decomp_classical_range_scale(s : TimeseriesdecompclassicalRange, f : Double) -> TimeseriesdecompclassicalRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_classical_range_add(a : TimeseriesdecompclassicalRange, b : TimeseriesdecompclassicalRange) -> TimeseriesdecompclassicalRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_decomp_classical_range_copy(s : TimeseriesdecompclassicalRange) -> TimeseriesdecompclassicalRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_classical_range_fill(s : TimeseriesdecompclassicalRange, v : Double) -> TimeseriesdecompclassicalRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_classical_range_min(s : TimeseriesdecompclassicalRange) -> Double { @_common.min(s.data) }

pub fn timeseries_decomp_classical_range_max(s : TimeseriesdecompclassicalRange) -> Double { @_common.max(s.data) }

pub fn timeseries_decomp_classical_range_to_string(s : TimeseriesdecompclassicalRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct TimeseriesdecompclassicalSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_decomp_classical_slice_make(size : Int) -> TimeseriesdecompclassicalSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn timeseries_decomp_classical_slice_len(s : TimeseriesdecompclassicalSlice) -> Int { s.size }

pub fn timeseries_decomp_classical_slice_get(s : TimeseriesdecompclassicalSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn timeseries_decomp_classical_slice_set(s : TimeseriesdecompclassicalSlice, i : Int, v : Double) -> TimeseriesdecompclassicalSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_classical_slice_sum(s : TimeseriesdecompclassicalSlice) -> Double { @_common.sum(s.data) }

pub fn timeseries_decomp_classical_slice_mean(s : TimeseriesdecompclassicalSlice) -> Double { @_common.mean(s.data) }

pub fn timeseries_decomp_classical_slice_scale(s : TimeseriesdecompclassicalSlice, f : Double) -> TimeseriesdecompclassicalSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_classical_slice_add(a : TimeseriesdecompclassicalSlice, b : TimeseriesdecompclassicalSlice) -> TimeseriesdecompclassicalSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn timeseries_decomp_classical_slice_copy(s : TimeseriesdecompclassicalSlice) -> TimeseriesdecompclassicalSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_classical_slice_fill(s : TimeseriesdecompclassicalSlice, v : Double) -> TimeseriesdecompclassicalSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn timeseries_decomp_classical_slice_min(s : TimeseriesdecompclassicalSlice) -> Double { @_common.min(s.data) }

pub fn timeseries_decomp_classical_slice_max(s : TimeseriesdecompclassicalSlice) -> Double { @_common.max(s.data) }

pub fn timeseries_decomp_classical_slice_to_string(s : TimeseriesdecompclassicalSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

