///===
/// extcore/sort_hybrid_grailsort

pub(all) struct SorthybridgrailsortPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn sort_hybrid_grailsort_make_point(x : Double, y : Double) -> SorthybridgrailsortPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn sort_hybrid_grailsort_make_point3(x : Double, y : Double, z : Double) -> SorthybridgrailsortPoint {
  { x, y, z, label: 0 }
}

pub fn SorthybridgrailsortPoint::x(self : SorthybridgrailsortPoint) -> Double { self.x }

pub fn SorthybridgrailsortPoint::y(self : SorthybridgrailsortPoint) -> Double { self.y }

pub fn SorthybridgrailsortPoint::z(self : SorthybridgrailsortPoint) -> Double { self.z }

pub fn SorthybridgrailsortPoint::label(self : SorthybridgrailsortPoint) -> Int { self.label }

pub fn SorthybridgrailsortPoint::dist(self : SorthybridgrailsortPoint, other : SorthybridgrailsortPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn SorthybridgrailsortPoint::add(self : SorthybridgrailsortPoint, other : SorthybridgrailsortPoint) -> SorthybridgrailsortPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn SorthybridgrailsortPoint::sub(self : SorthybridgrailsortPoint, other : SorthybridgrailsortPoint) -> SorthybridgrailsortPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn SorthybridgrailsortPoint::scale(self : SorthybridgrailsortPoint, s : Double) -> SorthybridgrailsortPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn SorthybridgrailsortPoint::dot(self : SorthybridgrailsortPoint, other : SorthybridgrailsortPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn SorthybridgrailsortPoint::cross(self : SorthybridgrailsortPoint, other : SorthybridgrailsortPoint) -> SorthybridgrailsortPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn SorthybridgrailsortPoint::norm(self : SorthybridgrailsortPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn SorthybridgrailsortPoint::normalize(self : SorthybridgrailsortPoint) -> SorthybridgrailsortPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn SorthybridgrailsortPoint::negate(self : SorthybridgrailsortPoint) -> SorthybridgrailsortPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn SorthybridgrailsortPoint::mid(self : SorthybridgrailsortPoint, other : SorthybridgrailsortPoint) -> SorthybridgrailsortPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn SorthybridgrailsortPoint::lerp(self : SorthybridgrailsortPoint, other : SorthybridgrailsortPoint, t : Double) -> SorthybridgrailsortPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn SorthybridgrailsortPoint::to_string(self : SorthybridgrailsortPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct SorthybridgrailsortSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn sort_hybrid_grailsort_make_series(vals : Array[Double], name : String) -> SorthybridgrailsortSeries {
  { vals, name, meta: 0 }
}

pub fn SorthybridgrailsortSeries::len(self : SorthybridgrailsortSeries) -> Int { self.vals.length() }

pub fn SorthybridgrailsortSeries::sum(self : SorthybridgrailsortSeries) -> Double { @_common.sum(self.vals) }

pub fn SorthybridgrailsortSeries::mean(self : SorthybridgrailsortSeries) -> Double { @_common.mean(self.vals) }

pub fn SorthybridgrailsortSeries::min(self : SorthybridgrailsortSeries) -> Double { @_common.min(self.vals) }

pub fn SorthybridgrailsortSeries::max(self : SorthybridgrailsortSeries) -> Double { @_common.max(self.vals) }

pub fn SorthybridgrailsortSeries::range(self : SorthybridgrailsortSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn SorthybridgrailsortSeries::variance(self : SorthybridgrailsortSeries) -> Double { @_common.variance(self.vals) }

pub fn SorthybridgrailsortSeries::std(self : SorthybridgrailsortSeries) -> Double { @_common.std(self.vals) }

pub fn SorthybridgrailsortSeries::median(self : SorthybridgrailsortSeries) -> Double { @_common.median(self.vals) }

pub fn SorthybridgrailsortSeries::scale(self : SorthybridgrailsortSeries, f : Double) -> SorthybridgrailsortSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn SorthybridgrailsortSeries::add(self : SorthybridgrailsortSeries, other : SorthybridgrailsortSeries) -> SorthybridgrailsortSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn SorthybridgrailsortSeries::sub(self : SorthybridgrailsortSeries, other : SorthybridgrailsortSeries) -> SorthybridgrailsortSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn SorthybridgrailsortSeries::normalize(self : SorthybridgrailsortSeries) -> SorthybridgrailsortSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn SorthybridgrailsortSeries::cumsum(self : SorthybridgrailsortSeries) -> SorthybridgrailsortSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn SorthybridgrailsortSeries::to_string(self : SorthybridgrailsortSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct SorthybridgrailsortMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn sort_hybrid_grailsort_make_matrix(rows : Int, cols : Int, val : Double) -> SorthybridgrailsortMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn sort_hybrid_grailsort_matrix_identity(n : Int) -> SorthybridgrailsortMatrix {
  let m = sort_hybrid_grailsort_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn SorthybridgrailsortMatrix::get(self : SorthybridgrailsortMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn SorthybridgrailsortMatrix::transpose(self : SorthybridgrailsortMatrix) -> SorthybridgrailsortMatrix {
  let result = sort_hybrid_grailsort_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn SorthybridgrailsortMatrix::add(self : SorthybridgrailsortMatrix, other : SorthybridgrailsortMatrix) -> SorthybridgrailsortMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = sort_hybrid_grailsort_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn SorthybridgrailsortMatrix::scale(self : SorthybridgrailsortMatrix, s : Double) -> SorthybridgrailsortMatrix {
  let result = sort_hybrid_grailsort_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn SorthybridgrailsortMatrix::multiply(self : SorthybridgrailsortMatrix, other : SorthybridgrailsortMatrix) -> SorthybridgrailsortMatrix {
  if self.cols != other.rows { return sort_hybrid_grailsort_make_matrix(self.rows, other.cols, 0.0) }
  let result = sort_hybrid_grailsort_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn SorthybridgrailsortMatrix::trace(self : SorthybridgrailsortMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn SorthybridgrailsortMatrix::det(self : SorthybridgrailsortMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn SorthybridgrailsortMatrix::norm(self : SorthybridgrailsortMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn SorthybridgrailsortMatrix::to_string(self : SorthybridgrailsortMatrix) -> String {
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

pub(all) struct SorthybridgrailsortVector {
  comps : Array[Double]
  dim : Int
}

pub fn sort_hybrid_grailsort_make_vector(comps : Array[Double]) -> SorthybridgrailsortVector {
  { comps, dim: comps.length() }
}

pub fn sort_hybrid_grailsort_vector_zero(dim : Int) -> SorthybridgrailsortVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn SorthybridgrailsortVector::add(self : SorthybridgrailsortVector, other : SorthybridgrailsortVector) -> SorthybridgrailsortVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn SorthybridgrailsortVector::sub(self : SorthybridgrailsortVector, other : SorthybridgrailsortVector) -> SorthybridgrailsortVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn SorthybridgrailsortVector::scale(self : SorthybridgrailsortVector, s : Double) -> SorthybridgrailsortVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn SorthybridgrailsortVector::dot(self : SorthybridgrailsortVector, other : SorthybridgrailsortVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn SorthybridgrailsortVector::norm(self : SorthybridgrailsortVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn SorthybridgrailsortVector::normalize(self : SorthybridgrailsortVector) -> SorthybridgrailsortVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn SorthybridgrailsortVector::dist(self : SorthybridgrailsortVector, other : SorthybridgrailsortVector) -> Double {
  self.sub(other).norm()
}

pub fn SorthybridgrailsortVector::to_string(self : SorthybridgrailsortVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn sort_hybrid_grailsort_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn sort_hybrid_grailsort_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn sort_hybrid_grailsort_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn sort_hybrid_grailsort_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn sort_hybrid_grailsort_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn sort_hybrid_grailsort_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn sort_hybrid_grailsort_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn sort_hybrid_grailsort_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn sort_hybrid_grailsort_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn sort_hybrid_grailsort_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn sort_hybrid_grailsort_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn sort_hybrid_grailsort_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn sort_hybrid_grailsort_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn sort_hybrid_grailsort_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn sort_hybrid_grailsort_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn sort_hybrid_grailsort_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn sort_hybrid_grailsort_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn sort_hybrid_grailsort_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn sort_hybrid_grailsort_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn sort_hybrid_grailsort_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn sort_hybrid_grailsort_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn sort_hybrid_grailsort_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn sort_hybrid_grailsort_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn sort_hybrid_grailsort_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn sort_hybrid_grailsort_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn sort_hybrid_grailsort_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn sort_hybrid_grailsort_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn sort_hybrid_grailsort_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn sort_hybrid_grailsort_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct SorthybridgrailsortFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_hybrid_grailsort_frame_make(size : Int) -> SorthybridgrailsortFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_hybrid_grailsort_frame_len(s : SorthybridgrailsortFrame) -> Int { s.size }

pub fn sort_hybrid_grailsort_frame_get(s : SorthybridgrailsortFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_hybrid_grailsort_frame_set(s : SorthybridgrailsortFrame, i : Int, v : Double) -> SorthybridgrailsortFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_hybrid_grailsort_frame_sum(s : SorthybridgrailsortFrame) -> Double { @_common.sum(s.data) }

pub fn sort_hybrid_grailsort_frame_mean(s : SorthybridgrailsortFrame) -> Double { @_common.mean(s.data) }

pub fn sort_hybrid_grailsort_frame_scale(s : SorthybridgrailsortFrame, f : Double) -> SorthybridgrailsortFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_hybrid_grailsort_frame_add(a : SorthybridgrailsortFrame, b : SorthybridgrailsortFrame) -> SorthybridgrailsortFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_hybrid_grailsort_frame_copy(s : SorthybridgrailsortFrame) -> SorthybridgrailsortFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_hybrid_grailsort_frame_fill(s : SorthybridgrailsortFrame, v : Double) -> SorthybridgrailsortFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_hybrid_grailsort_frame_min(s : SorthybridgrailsortFrame) -> Double { @_common.min(s.data) }

pub fn sort_hybrid_grailsort_frame_max(s : SorthybridgrailsortFrame) -> Double { @_common.max(s.data) }

pub fn sort_hybrid_grailsort_frame_to_string(s : SorthybridgrailsortFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SorthybridgrailsortTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_hybrid_grailsort_table_make(size : Int) -> SorthybridgrailsortTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_hybrid_grailsort_table_len(s : SorthybridgrailsortTable) -> Int { s.size }

pub fn sort_hybrid_grailsort_table_get(s : SorthybridgrailsortTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_hybrid_grailsort_table_set(s : SorthybridgrailsortTable, i : Int, v : Double) -> SorthybridgrailsortTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_hybrid_grailsort_table_sum(s : SorthybridgrailsortTable) -> Double { @_common.sum(s.data) }

pub fn sort_hybrid_grailsort_table_mean(s : SorthybridgrailsortTable) -> Double { @_common.mean(s.data) }

pub fn sort_hybrid_grailsort_table_scale(s : SorthybridgrailsortTable, f : Double) -> SorthybridgrailsortTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_hybrid_grailsort_table_add(a : SorthybridgrailsortTable, b : SorthybridgrailsortTable) -> SorthybridgrailsortTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_hybrid_grailsort_table_copy(s : SorthybridgrailsortTable) -> SorthybridgrailsortTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_hybrid_grailsort_table_fill(s : SorthybridgrailsortTable, v : Double) -> SorthybridgrailsortTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_hybrid_grailsort_table_min(s : SorthybridgrailsortTable) -> Double { @_common.min(s.data) }

pub fn sort_hybrid_grailsort_table_max(s : SorthybridgrailsortTable) -> Double { @_common.max(s.data) }

pub fn sort_hybrid_grailsort_table_to_string(s : SorthybridgrailsortTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SorthybridgrailsortGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_hybrid_grailsort_graphn_make(size : Int) -> SorthybridgrailsortGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_hybrid_grailsort_graphn_len(s : SorthybridgrailsortGraphN) -> Int { s.size }

pub fn sort_hybrid_grailsort_graphn_get(s : SorthybridgrailsortGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_hybrid_grailsort_graphn_set(s : SorthybridgrailsortGraphN, i : Int, v : Double) -> SorthybridgrailsortGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_hybrid_grailsort_graphn_sum(s : SorthybridgrailsortGraphN) -> Double { @_common.sum(s.data) }

pub fn sort_hybrid_grailsort_graphn_mean(s : SorthybridgrailsortGraphN) -> Double { @_common.mean(s.data) }

pub fn sort_hybrid_grailsort_graphn_scale(s : SorthybridgrailsortGraphN, f : Double) -> SorthybridgrailsortGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_hybrid_grailsort_graphn_add(a : SorthybridgrailsortGraphN, b : SorthybridgrailsortGraphN) -> SorthybridgrailsortGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_hybrid_grailsort_graphn_copy(s : SorthybridgrailsortGraphN) -> SorthybridgrailsortGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_hybrid_grailsort_graphn_fill(s : SorthybridgrailsortGraphN, v : Double) -> SorthybridgrailsortGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_hybrid_grailsort_graphn_min(s : SorthybridgrailsortGraphN) -> Double { @_common.min(s.data) }

pub fn sort_hybrid_grailsort_graphn_max(s : SorthybridgrailsortGraphN) -> Double { @_common.max(s.data) }

pub fn sort_hybrid_grailsort_graphn_to_string(s : SorthybridgrailsortGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SorthybridgrailsortNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_hybrid_grailsort_node_make(size : Int) -> SorthybridgrailsortNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_hybrid_grailsort_node_len(s : SorthybridgrailsortNode) -> Int { s.size }

pub fn sort_hybrid_grailsort_node_get(s : SorthybridgrailsortNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_hybrid_grailsort_node_set(s : SorthybridgrailsortNode, i : Int, v : Double) -> SorthybridgrailsortNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_hybrid_grailsort_node_sum(s : SorthybridgrailsortNode) -> Double { @_common.sum(s.data) }

pub fn sort_hybrid_grailsort_node_mean(s : SorthybridgrailsortNode) -> Double { @_common.mean(s.data) }

pub fn sort_hybrid_grailsort_node_scale(s : SorthybridgrailsortNode, f : Double) -> SorthybridgrailsortNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_hybrid_grailsort_node_add(a : SorthybridgrailsortNode, b : SorthybridgrailsortNode) -> SorthybridgrailsortNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_hybrid_grailsort_node_copy(s : SorthybridgrailsortNode) -> SorthybridgrailsortNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_hybrid_grailsort_node_fill(s : SorthybridgrailsortNode, v : Double) -> SorthybridgrailsortNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_hybrid_grailsort_node_min(s : SorthybridgrailsortNode) -> Double { @_common.min(s.data) }

pub fn sort_hybrid_grailsort_node_max(s : SorthybridgrailsortNode) -> Double { @_common.max(s.data) }

pub fn sort_hybrid_grailsort_node_to_string(s : SorthybridgrailsortNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SorthybridgrailsortEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_hybrid_grailsort_edge_make(size : Int) -> SorthybridgrailsortEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_hybrid_grailsort_edge_len(s : SorthybridgrailsortEdge) -> Int { s.size }

pub fn sort_hybrid_grailsort_edge_get(s : SorthybridgrailsortEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_hybrid_grailsort_edge_set(s : SorthybridgrailsortEdge, i : Int, v : Double) -> SorthybridgrailsortEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_hybrid_grailsort_edge_sum(s : SorthybridgrailsortEdge) -> Double { @_common.sum(s.data) }

pub fn sort_hybrid_grailsort_edge_mean(s : SorthybridgrailsortEdge) -> Double { @_common.mean(s.data) }

pub fn sort_hybrid_grailsort_edge_scale(s : SorthybridgrailsortEdge, f : Double) -> SorthybridgrailsortEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_hybrid_grailsort_edge_add(a : SorthybridgrailsortEdge, b : SorthybridgrailsortEdge) -> SorthybridgrailsortEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_hybrid_grailsort_edge_copy(s : SorthybridgrailsortEdge) -> SorthybridgrailsortEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_hybrid_grailsort_edge_fill(s : SorthybridgrailsortEdge, v : Double) -> SorthybridgrailsortEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_hybrid_grailsort_edge_min(s : SorthybridgrailsortEdge) -> Double { @_common.min(s.data) }

pub fn sort_hybrid_grailsort_edge_max(s : SorthybridgrailsortEdge) -> Double { @_common.max(s.data) }

pub fn sort_hybrid_grailsort_edge_to_string(s : SorthybridgrailsortEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SorthybridgrailsortPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_hybrid_grailsort_path_make(size : Int) -> SorthybridgrailsortPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_hybrid_grailsort_path_len(s : SorthybridgrailsortPath) -> Int { s.size }

pub fn sort_hybrid_grailsort_path_get(s : SorthybridgrailsortPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_hybrid_grailsort_path_set(s : SorthybridgrailsortPath, i : Int, v : Double) -> SorthybridgrailsortPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_hybrid_grailsort_path_sum(s : SorthybridgrailsortPath) -> Double { @_common.sum(s.data) }

pub fn sort_hybrid_grailsort_path_mean(s : SorthybridgrailsortPath) -> Double { @_common.mean(s.data) }

pub fn sort_hybrid_grailsort_path_scale(s : SorthybridgrailsortPath, f : Double) -> SorthybridgrailsortPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_hybrid_grailsort_path_add(a : SorthybridgrailsortPath, b : SorthybridgrailsortPath) -> SorthybridgrailsortPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_hybrid_grailsort_path_copy(s : SorthybridgrailsortPath) -> SorthybridgrailsortPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_hybrid_grailsort_path_fill(s : SorthybridgrailsortPath, v : Double) -> SorthybridgrailsortPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_hybrid_grailsort_path_min(s : SorthybridgrailsortPath) -> Double { @_common.min(s.data) }

pub fn sort_hybrid_grailsort_path_max(s : SorthybridgrailsortPath) -> Double { @_common.max(s.data) }

pub fn sort_hybrid_grailsort_path_to_string(s : SorthybridgrailsortPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SorthybridgrailsortCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_hybrid_grailsort_cluster_make(size : Int) -> SorthybridgrailsortCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_hybrid_grailsort_cluster_len(s : SorthybridgrailsortCluster) -> Int { s.size }

pub fn sort_hybrid_grailsort_cluster_get(s : SorthybridgrailsortCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_hybrid_grailsort_cluster_set(s : SorthybridgrailsortCluster, i : Int, v : Double) -> SorthybridgrailsortCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_hybrid_grailsort_cluster_sum(s : SorthybridgrailsortCluster) -> Double { @_common.sum(s.data) }

pub fn sort_hybrid_grailsort_cluster_mean(s : SorthybridgrailsortCluster) -> Double { @_common.mean(s.data) }

pub fn sort_hybrid_grailsort_cluster_scale(s : SorthybridgrailsortCluster, f : Double) -> SorthybridgrailsortCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_hybrid_grailsort_cluster_add(a : SorthybridgrailsortCluster, b : SorthybridgrailsortCluster) -> SorthybridgrailsortCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_hybrid_grailsort_cluster_copy(s : SorthybridgrailsortCluster) -> SorthybridgrailsortCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_hybrid_grailsort_cluster_fill(s : SorthybridgrailsortCluster, v : Double) -> SorthybridgrailsortCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_hybrid_grailsort_cluster_min(s : SorthybridgrailsortCluster) -> Double { @_common.min(s.data) }

pub fn sort_hybrid_grailsort_cluster_max(s : SorthybridgrailsortCluster) -> Double { @_common.max(s.data) }

pub fn sort_hybrid_grailsort_cluster_to_string(s : SorthybridgrailsortCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SorthybridgrailsortModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_hybrid_grailsort_model_make(size : Int) -> SorthybridgrailsortModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_hybrid_grailsort_model_len(s : SorthybridgrailsortModel) -> Int { s.size }

pub fn sort_hybrid_grailsort_model_get(s : SorthybridgrailsortModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_hybrid_grailsort_model_set(s : SorthybridgrailsortModel, i : Int, v : Double) -> SorthybridgrailsortModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_hybrid_grailsort_model_sum(s : SorthybridgrailsortModel) -> Double { @_common.sum(s.data) }

pub fn sort_hybrid_grailsort_model_mean(s : SorthybridgrailsortModel) -> Double { @_common.mean(s.data) }

pub fn sort_hybrid_grailsort_model_scale(s : SorthybridgrailsortModel, f : Double) -> SorthybridgrailsortModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_hybrid_grailsort_model_add(a : SorthybridgrailsortModel, b : SorthybridgrailsortModel) -> SorthybridgrailsortModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_hybrid_grailsort_model_copy(s : SorthybridgrailsortModel) -> SorthybridgrailsortModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_hybrid_grailsort_model_fill(s : SorthybridgrailsortModel, v : Double) -> SorthybridgrailsortModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_hybrid_grailsort_model_min(s : SorthybridgrailsortModel) -> Double { @_common.min(s.data) }

pub fn sort_hybrid_grailsort_model_max(s : SorthybridgrailsortModel) -> Double { @_common.max(s.data) }

pub fn sort_hybrid_grailsort_model_to_string(s : SorthybridgrailsortModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SorthybridgrailsortLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_hybrid_grailsort_layer_make(size : Int) -> SorthybridgrailsortLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_hybrid_grailsort_layer_len(s : SorthybridgrailsortLayer) -> Int { s.size }

pub fn sort_hybrid_grailsort_layer_get(s : SorthybridgrailsortLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_hybrid_grailsort_layer_set(s : SorthybridgrailsortLayer, i : Int, v : Double) -> SorthybridgrailsortLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_hybrid_grailsort_layer_sum(s : SorthybridgrailsortLayer) -> Double { @_common.sum(s.data) }

pub fn sort_hybrid_grailsort_layer_mean(s : SorthybridgrailsortLayer) -> Double { @_common.mean(s.data) }

pub fn sort_hybrid_grailsort_layer_scale(s : SorthybridgrailsortLayer, f : Double) -> SorthybridgrailsortLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_hybrid_grailsort_layer_add(a : SorthybridgrailsortLayer, b : SorthybridgrailsortLayer) -> SorthybridgrailsortLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_hybrid_grailsort_layer_copy(s : SorthybridgrailsortLayer) -> SorthybridgrailsortLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_hybrid_grailsort_layer_fill(s : SorthybridgrailsortLayer, v : Double) -> SorthybridgrailsortLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_hybrid_grailsort_layer_min(s : SorthybridgrailsortLayer) -> Double { @_common.min(s.data) }

pub fn sort_hybrid_grailsort_layer_max(s : SorthybridgrailsortLayer) -> Double { @_common.max(s.data) }

pub fn sort_hybrid_grailsort_layer_to_string(s : SorthybridgrailsortLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SorthybridgrailsortBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_hybrid_grailsort_buffer_make(size : Int) -> SorthybridgrailsortBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_hybrid_grailsort_buffer_len(s : SorthybridgrailsortBuffer) -> Int { s.size }

pub fn sort_hybrid_grailsort_buffer_get(s : SorthybridgrailsortBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_hybrid_grailsort_buffer_set(s : SorthybridgrailsortBuffer, i : Int, v : Double) -> SorthybridgrailsortBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_hybrid_grailsort_buffer_sum(s : SorthybridgrailsortBuffer) -> Double { @_common.sum(s.data) }

pub fn sort_hybrid_grailsort_buffer_mean(s : SorthybridgrailsortBuffer) -> Double { @_common.mean(s.data) }

pub fn sort_hybrid_grailsort_buffer_scale(s : SorthybridgrailsortBuffer, f : Double) -> SorthybridgrailsortBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_hybrid_grailsort_buffer_add(a : SorthybridgrailsortBuffer, b : SorthybridgrailsortBuffer) -> SorthybridgrailsortBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_hybrid_grailsort_buffer_copy(s : SorthybridgrailsortBuffer) -> SorthybridgrailsortBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_hybrid_grailsort_buffer_fill(s : SorthybridgrailsortBuffer, v : Double) -> SorthybridgrailsortBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_hybrid_grailsort_buffer_min(s : SorthybridgrailsortBuffer) -> Double { @_common.min(s.data) }

pub fn sort_hybrid_grailsort_buffer_max(s : SorthybridgrailsortBuffer) -> Double { @_common.max(s.data) }

pub fn sort_hybrid_grailsort_buffer_to_string(s : SorthybridgrailsortBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SorthybridgrailsortCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_hybrid_grailsort_cursor_make(size : Int) -> SorthybridgrailsortCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_hybrid_grailsort_cursor_len(s : SorthybridgrailsortCursor) -> Int { s.size }

pub fn sort_hybrid_grailsort_cursor_get(s : SorthybridgrailsortCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_hybrid_grailsort_cursor_set(s : SorthybridgrailsortCursor, i : Int, v : Double) -> SorthybridgrailsortCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_hybrid_grailsort_cursor_sum(s : SorthybridgrailsortCursor) -> Double { @_common.sum(s.data) }

pub fn sort_hybrid_grailsort_cursor_mean(s : SorthybridgrailsortCursor) -> Double { @_common.mean(s.data) }

pub fn sort_hybrid_grailsort_cursor_scale(s : SorthybridgrailsortCursor, f : Double) -> SorthybridgrailsortCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_hybrid_grailsort_cursor_add(a : SorthybridgrailsortCursor, b : SorthybridgrailsortCursor) -> SorthybridgrailsortCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_hybrid_grailsort_cursor_copy(s : SorthybridgrailsortCursor) -> SorthybridgrailsortCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_hybrid_grailsort_cursor_fill(s : SorthybridgrailsortCursor, v : Double) -> SorthybridgrailsortCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_hybrid_grailsort_cursor_min(s : SorthybridgrailsortCursor) -> Double { @_common.min(s.data) }

pub fn sort_hybrid_grailsort_cursor_max(s : SorthybridgrailsortCursor) -> Double { @_common.max(s.data) }

pub fn sort_hybrid_grailsort_cursor_to_string(s : SorthybridgrailsortCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SorthybridgrailsortView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_hybrid_grailsort_view_make(size : Int) -> SorthybridgrailsortView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_hybrid_grailsort_view_len(s : SorthybridgrailsortView) -> Int { s.size }

pub fn sort_hybrid_grailsort_view_get(s : SorthybridgrailsortView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_hybrid_grailsort_view_set(s : SorthybridgrailsortView, i : Int, v : Double) -> SorthybridgrailsortView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_hybrid_grailsort_view_sum(s : SorthybridgrailsortView) -> Double { @_common.sum(s.data) }

pub fn sort_hybrid_grailsort_view_mean(s : SorthybridgrailsortView) -> Double { @_common.mean(s.data) }

pub fn sort_hybrid_grailsort_view_scale(s : SorthybridgrailsortView, f : Double) -> SorthybridgrailsortView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_hybrid_grailsort_view_add(a : SorthybridgrailsortView, b : SorthybridgrailsortView) -> SorthybridgrailsortView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_hybrid_grailsort_view_copy(s : SorthybridgrailsortView) -> SorthybridgrailsortView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_hybrid_grailsort_view_fill(s : SorthybridgrailsortView, v : Double) -> SorthybridgrailsortView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_hybrid_grailsort_view_min(s : SorthybridgrailsortView) -> Double { @_common.min(s.data) }

pub fn sort_hybrid_grailsort_view_max(s : SorthybridgrailsortView) -> Double { @_common.max(s.data) }

pub fn sort_hybrid_grailsort_view_to_string(s : SorthybridgrailsortView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SorthybridgrailsortRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_hybrid_grailsort_range_make(size : Int) -> SorthybridgrailsortRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_hybrid_grailsort_range_len(s : SorthybridgrailsortRange) -> Int { s.size }

pub fn sort_hybrid_grailsort_range_get(s : SorthybridgrailsortRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_hybrid_grailsort_range_set(s : SorthybridgrailsortRange, i : Int, v : Double) -> SorthybridgrailsortRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_hybrid_grailsort_range_sum(s : SorthybridgrailsortRange) -> Double { @_common.sum(s.data) }

pub fn sort_hybrid_grailsort_range_mean(s : SorthybridgrailsortRange) -> Double { @_common.mean(s.data) }

pub fn sort_hybrid_grailsort_range_scale(s : SorthybridgrailsortRange, f : Double) -> SorthybridgrailsortRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_hybrid_grailsort_range_add(a : SorthybridgrailsortRange, b : SorthybridgrailsortRange) -> SorthybridgrailsortRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_hybrid_grailsort_range_copy(s : SorthybridgrailsortRange) -> SorthybridgrailsortRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_hybrid_grailsort_range_fill(s : SorthybridgrailsortRange, v : Double) -> SorthybridgrailsortRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_hybrid_grailsort_range_min(s : SorthybridgrailsortRange) -> Double { @_common.min(s.data) }

pub fn sort_hybrid_grailsort_range_max(s : SorthybridgrailsortRange) -> Double { @_common.max(s.data) }

pub fn sort_hybrid_grailsort_range_to_string(s : SorthybridgrailsortRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SorthybridgrailsortSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_hybrid_grailsort_slice_make(size : Int) -> SorthybridgrailsortSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_hybrid_grailsort_slice_len(s : SorthybridgrailsortSlice) -> Int { s.size }

pub fn sort_hybrid_grailsort_slice_get(s : SorthybridgrailsortSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_hybrid_grailsort_slice_set(s : SorthybridgrailsortSlice, i : Int, v : Double) -> SorthybridgrailsortSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_hybrid_grailsort_slice_sum(s : SorthybridgrailsortSlice) -> Double { @_common.sum(s.data) }

pub fn sort_hybrid_grailsort_slice_mean(s : SorthybridgrailsortSlice) -> Double { @_common.mean(s.data) }

pub fn sort_hybrid_grailsort_slice_scale(s : SorthybridgrailsortSlice, f : Double) -> SorthybridgrailsortSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_hybrid_grailsort_slice_add(a : SorthybridgrailsortSlice, b : SorthybridgrailsortSlice) -> SorthybridgrailsortSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_hybrid_grailsort_slice_copy(s : SorthybridgrailsortSlice) -> SorthybridgrailsortSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_hybrid_grailsort_slice_fill(s : SorthybridgrailsortSlice, v : Double) -> SorthybridgrailsortSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_hybrid_grailsort_slice_min(s : SorthybridgrailsortSlice) -> Double { @_common.min(s.data) }

pub fn sort_hybrid_grailsort_slice_max(s : SorthybridgrailsortSlice) -> Double { @_common.max(s.data) }

pub fn sort_hybrid_grailsort_slice_to_string(s : SorthybridgrailsortSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

