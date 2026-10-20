///===
/// extcore/sort_hybrid_timsort

pub(all) struct SorthybridtimsortPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn sort_hybrid_timsort_make_point(x : Double, y : Double) -> SorthybridtimsortPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn sort_hybrid_timsort_make_point3(x : Double, y : Double, z : Double) -> SorthybridtimsortPoint {
  { x, y, z, label: 0 }
}

pub fn SorthybridtimsortPoint::x(self : SorthybridtimsortPoint) -> Double { self.x }

pub fn SorthybridtimsortPoint::y(self : SorthybridtimsortPoint) -> Double { self.y }

pub fn SorthybridtimsortPoint::z(self : SorthybridtimsortPoint) -> Double { self.z }

pub fn SorthybridtimsortPoint::label(self : SorthybridtimsortPoint) -> Int { self.label }

pub fn SorthybridtimsortPoint::dist(self : SorthybridtimsortPoint, other : SorthybridtimsortPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn SorthybridtimsortPoint::add(self : SorthybridtimsortPoint, other : SorthybridtimsortPoint) -> SorthybridtimsortPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn SorthybridtimsortPoint::sub(self : SorthybridtimsortPoint, other : SorthybridtimsortPoint) -> SorthybridtimsortPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn SorthybridtimsortPoint::scale(self : SorthybridtimsortPoint, s : Double) -> SorthybridtimsortPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn SorthybridtimsortPoint::dot(self : SorthybridtimsortPoint, other : SorthybridtimsortPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn SorthybridtimsortPoint::cross(self : SorthybridtimsortPoint, other : SorthybridtimsortPoint) -> SorthybridtimsortPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn SorthybridtimsortPoint::norm(self : SorthybridtimsortPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn SorthybridtimsortPoint::normalize(self : SorthybridtimsortPoint) -> SorthybridtimsortPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn SorthybridtimsortPoint::negate(self : SorthybridtimsortPoint) -> SorthybridtimsortPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn SorthybridtimsortPoint::mid(self : SorthybridtimsortPoint, other : SorthybridtimsortPoint) -> SorthybridtimsortPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn SorthybridtimsortPoint::lerp(self : SorthybridtimsortPoint, other : SorthybridtimsortPoint, t : Double) -> SorthybridtimsortPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn SorthybridtimsortPoint::to_string(self : SorthybridtimsortPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct SorthybridtimsortSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn sort_hybrid_timsort_make_series(vals : Array[Double], name : String) -> SorthybridtimsortSeries {
  { vals, name, meta: 0 }
}

pub fn SorthybridtimsortSeries::len(self : SorthybridtimsortSeries) -> Int { self.vals.length() }

pub fn SorthybridtimsortSeries::sum(self : SorthybridtimsortSeries) -> Double { @_common.sum(self.vals) }

pub fn SorthybridtimsortSeries::mean(self : SorthybridtimsortSeries) -> Double { @_common.mean(self.vals) }

pub fn SorthybridtimsortSeries::min(self : SorthybridtimsortSeries) -> Double { @_common.min(self.vals) }

pub fn SorthybridtimsortSeries::max(self : SorthybridtimsortSeries) -> Double { @_common.max(self.vals) }

pub fn SorthybridtimsortSeries::range(self : SorthybridtimsortSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn SorthybridtimsortSeries::variance(self : SorthybridtimsortSeries) -> Double { @_common.variance(self.vals) }

pub fn SorthybridtimsortSeries::std(self : SorthybridtimsortSeries) -> Double { @_common.std(self.vals) }

pub fn SorthybridtimsortSeries::median(self : SorthybridtimsortSeries) -> Double { @_common.median(self.vals) }

pub fn SorthybridtimsortSeries::scale(self : SorthybridtimsortSeries, f : Double) -> SorthybridtimsortSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn SorthybridtimsortSeries::add(self : SorthybridtimsortSeries, other : SorthybridtimsortSeries) -> SorthybridtimsortSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn SorthybridtimsortSeries::sub(self : SorthybridtimsortSeries, other : SorthybridtimsortSeries) -> SorthybridtimsortSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn SorthybridtimsortSeries::normalize(self : SorthybridtimsortSeries) -> SorthybridtimsortSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn SorthybridtimsortSeries::cumsum(self : SorthybridtimsortSeries) -> SorthybridtimsortSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn SorthybridtimsortSeries::to_string(self : SorthybridtimsortSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct SorthybridtimsortMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn sort_hybrid_timsort_make_matrix(rows : Int, cols : Int, val : Double) -> SorthybridtimsortMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn sort_hybrid_timsort_matrix_identity(n : Int) -> SorthybridtimsortMatrix {
  let m = sort_hybrid_timsort_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn SorthybridtimsortMatrix::get(self : SorthybridtimsortMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn SorthybridtimsortMatrix::transpose(self : SorthybridtimsortMatrix) -> SorthybridtimsortMatrix {
  let result = sort_hybrid_timsort_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn SorthybridtimsortMatrix::add(self : SorthybridtimsortMatrix, other : SorthybridtimsortMatrix) -> SorthybridtimsortMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = sort_hybrid_timsort_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn SorthybridtimsortMatrix::scale(self : SorthybridtimsortMatrix, s : Double) -> SorthybridtimsortMatrix {
  let result = sort_hybrid_timsort_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn SorthybridtimsortMatrix::multiply(self : SorthybridtimsortMatrix, other : SorthybridtimsortMatrix) -> SorthybridtimsortMatrix {
  if self.cols != other.rows { return sort_hybrid_timsort_make_matrix(self.rows, other.cols, 0.0) }
  let result = sort_hybrid_timsort_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn SorthybridtimsortMatrix::trace(self : SorthybridtimsortMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn SorthybridtimsortMatrix::det(self : SorthybridtimsortMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn SorthybridtimsortMatrix::norm(self : SorthybridtimsortMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn SorthybridtimsortMatrix::to_string(self : SorthybridtimsortMatrix) -> String {
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

pub(all) struct SorthybridtimsortVector {
  comps : Array[Double]
  dim : Int
}

pub fn sort_hybrid_timsort_make_vector(comps : Array[Double]) -> SorthybridtimsortVector {
  { comps, dim: comps.length() }
}

pub fn sort_hybrid_timsort_vector_zero(dim : Int) -> SorthybridtimsortVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn SorthybridtimsortVector::add(self : SorthybridtimsortVector, other : SorthybridtimsortVector) -> SorthybridtimsortVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn SorthybridtimsortVector::sub(self : SorthybridtimsortVector, other : SorthybridtimsortVector) -> SorthybridtimsortVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn SorthybridtimsortVector::scale(self : SorthybridtimsortVector, s : Double) -> SorthybridtimsortVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn SorthybridtimsortVector::dot(self : SorthybridtimsortVector, other : SorthybridtimsortVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn SorthybridtimsortVector::norm(self : SorthybridtimsortVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn SorthybridtimsortVector::normalize(self : SorthybridtimsortVector) -> SorthybridtimsortVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn SorthybridtimsortVector::dist(self : SorthybridtimsortVector, other : SorthybridtimsortVector) -> Double {
  self.sub(other).norm()
}

pub fn SorthybridtimsortVector::to_string(self : SorthybridtimsortVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn sort_hybrid_timsort_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn sort_hybrid_timsort_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn sort_hybrid_timsort_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn sort_hybrid_timsort_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn sort_hybrid_timsort_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn sort_hybrid_timsort_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn sort_hybrid_timsort_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn sort_hybrid_timsort_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn sort_hybrid_timsort_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn sort_hybrid_timsort_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn sort_hybrid_timsort_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn sort_hybrid_timsort_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn sort_hybrid_timsort_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn sort_hybrid_timsort_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn sort_hybrid_timsort_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn sort_hybrid_timsort_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn sort_hybrid_timsort_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn sort_hybrid_timsort_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn sort_hybrid_timsort_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn sort_hybrid_timsort_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn sort_hybrid_timsort_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn sort_hybrid_timsort_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn sort_hybrid_timsort_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn sort_hybrid_timsort_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn sort_hybrid_timsort_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn sort_hybrid_timsort_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn sort_hybrid_timsort_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn sort_hybrid_timsort_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn sort_hybrid_timsort_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct SorthybridtimsortFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_hybrid_timsort_frame_make(size : Int) -> SorthybridtimsortFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_hybrid_timsort_frame_len(s : SorthybridtimsortFrame) -> Int { s.size }

pub fn sort_hybrid_timsort_frame_get(s : SorthybridtimsortFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_hybrid_timsort_frame_set(s : SorthybridtimsortFrame, i : Int, v : Double) -> SorthybridtimsortFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_hybrid_timsort_frame_sum(s : SorthybridtimsortFrame) -> Double { @_common.sum(s.data) }

pub fn sort_hybrid_timsort_frame_mean(s : SorthybridtimsortFrame) -> Double { @_common.mean(s.data) }

pub fn sort_hybrid_timsort_frame_scale(s : SorthybridtimsortFrame, f : Double) -> SorthybridtimsortFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_hybrid_timsort_frame_add(a : SorthybridtimsortFrame, b : SorthybridtimsortFrame) -> SorthybridtimsortFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_hybrid_timsort_frame_copy(s : SorthybridtimsortFrame) -> SorthybridtimsortFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_hybrid_timsort_frame_fill(s : SorthybridtimsortFrame, v : Double) -> SorthybridtimsortFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_hybrid_timsort_frame_min(s : SorthybridtimsortFrame) -> Double { @_common.min(s.data) }

pub fn sort_hybrid_timsort_frame_max(s : SorthybridtimsortFrame) -> Double { @_common.max(s.data) }

pub fn sort_hybrid_timsort_frame_to_string(s : SorthybridtimsortFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SorthybridtimsortTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_hybrid_timsort_table_make(size : Int) -> SorthybridtimsortTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_hybrid_timsort_table_len(s : SorthybridtimsortTable) -> Int { s.size }

pub fn sort_hybrid_timsort_table_get(s : SorthybridtimsortTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_hybrid_timsort_table_set(s : SorthybridtimsortTable, i : Int, v : Double) -> SorthybridtimsortTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_hybrid_timsort_table_sum(s : SorthybridtimsortTable) -> Double { @_common.sum(s.data) }

pub fn sort_hybrid_timsort_table_mean(s : SorthybridtimsortTable) -> Double { @_common.mean(s.data) }

pub fn sort_hybrid_timsort_table_scale(s : SorthybridtimsortTable, f : Double) -> SorthybridtimsortTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_hybrid_timsort_table_add(a : SorthybridtimsortTable, b : SorthybridtimsortTable) -> SorthybridtimsortTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_hybrid_timsort_table_copy(s : SorthybridtimsortTable) -> SorthybridtimsortTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_hybrid_timsort_table_fill(s : SorthybridtimsortTable, v : Double) -> SorthybridtimsortTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_hybrid_timsort_table_min(s : SorthybridtimsortTable) -> Double { @_common.min(s.data) }

pub fn sort_hybrid_timsort_table_max(s : SorthybridtimsortTable) -> Double { @_common.max(s.data) }

pub fn sort_hybrid_timsort_table_to_string(s : SorthybridtimsortTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SorthybridtimsortGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_hybrid_timsort_graphn_make(size : Int) -> SorthybridtimsortGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_hybrid_timsort_graphn_len(s : SorthybridtimsortGraphN) -> Int { s.size }

pub fn sort_hybrid_timsort_graphn_get(s : SorthybridtimsortGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_hybrid_timsort_graphn_set(s : SorthybridtimsortGraphN, i : Int, v : Double) -> SorthybridtimsortGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_hybrid_timsort_graphn_sum(s : SorthybridtimsortGraphN) -> Double { @_common.sum(s.data) }

pub fn sort_hybrid_timsort_graphn_mean(s : SorthybridtimsortGraphN) -> Double { @_common.mean(s.data) }

pub fn sort_hybrid_timsort_graphn_scale(s : SorthybridtimsortGraphN, f : Double) -> SorthybridtimsortGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_hybrid_timsort_graphn_add(a : SorthybridtimsortGraphN, b : SorthybridtimsortGraphN) -> SorthybridtimsortGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_hybrid_timsort_graphn_copy(s : SorthybridtimsortGraphN) -> SorthybridtimsortGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_hybrid_timsort_graphn_fill(s : SorthybridtimsortGraphN, v : Double) -> SorthybridtimsortGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_hybrid_timsort_graphn_min(s : SorthybridtimsortGraphN) -> Double { @_common.min(s.data) }

pub fn sort_hybrid_timsort_graphn_max(s : SorthybridtimsortGraphN) -> Double { @_common.max(s.data) }

pub fn sort_hybrid_timsort_graphn_to_string(s : SorthybridtimsortGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SorthybridtimsortNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_hybrid_timsort_node_make(size : Int) -> SorthybridtimsortNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_hybrid_timsort_node_len(s : SorthybridtimsortNode) -> Int { s.size }

pub fn sort_hybrid_timsort_node_get(s : SorthybridtimsortNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_hybrid_timsort_node_set(s : SorthybridtimsortNode, i : Int, v : Double) -> SorthybridtimsortNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_hybrid_timsort_node_sum(s : SorthybridtimsortNode) -> Double { @_common.sum(s.data) }

pub fn sort_hybrid_timsort_node_mean(s : SorthybridtimsortNode) -> Double { @_common.mean(s.data) }

pub fn sort_hybrid_timsort_node_scale(s : SorthybridtimsortNode, f : Double) -> SorthybridtimsortNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_hybrid_timsort_node_add(a : SorthybridtimsortNode, b : SorthybridtimsortNode) -> SorthybridtimsortNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_hybrid_timsort_node_copy(s : SorthybridtimsortNode) -> SorthybridtimsortNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_hybrid_timsort_node_fill(s : SorthybridtimsortNode, v : Double) -> SorthybridtimsortNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_hybrid_timsort_node_min(s : SorthybridtimsortNode) -> Double { @_common.min(s.data) }

pub fn sort_hybrid_timsort_node_max(s : SorthybridtimsortNode) -> Double { @_common.max(s.data) }

pub fn sort_hybrid_timsort_node_to_string(s : SorthybridtimsortNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SorthybridtimsortEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_hybrid_timsort_edge_make(size : Int) -> SorthybridtimsortEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_hybrid_timsort_edge_len(s : SorthybridtimsortEdge) -> Int { s.size }

pub fn sort_hybrid_timsort_edge_get(s : SorthybridtimsortEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_hybrid_timsort_edge_set(s : SorthybridtimsortEdge, i : Int, v : Double) -> SorthybridtimsortEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_hybrid_timsort_edge_sum(s : SorthybridtimsortEdge) -> Double { @_common.sum(s.data) }

pub fn sort_hybrid_timsort_edge_mean(s : SorthybridtimsortEdge) -> Double { @_common.mean(s.data) }

pub fn sort_hybrid_timsort_edge_scale(s : SorthybridtimsortEdge, f : Double) -> SorthybridtimsortEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_hybrid_timsort_edge_add(a : SorthybridtimsortEdge, b : SorthybridtimsortEdge) -> SorthybridtimsortEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_hybrid_timsort_edge_copy(s : SorthybridtimsortEdge) -> SorthybridtimsortEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_hybrid_timsort_edge_fill(s : SorthybridtimsortEdge, v : Double) -> SorthybridtimsortEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_hybrid_timsort_edge_min(s : SorthybridtimsortEdge) -> Double { @_common.min(s.data) }

pub fn sort_hybrid_timsort_edge_max(s : SorthybridtimsortEdge) -> Double { @_common.max(s.data) }

pub fn sort_hybrid_timsort_edge_to_string(s : SorthybridtimsortEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SorthybridtimsortPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_hybrid_timsort_path_make(size : Int) -> SorthybridtimsortPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_hybrid_timsort_path_len(s : SorthybridtimsortPath) -> Int { s.size }

pub fn sort_hybrid_timsort_path_get(s : SorthybridtimsortPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_hybrid_timsort_path_set(s : SorthybridtimsortPath, i : Int, v : Double) -> SorthybridtimsortPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_hybrid_timsort_path_sum(s : SorthybridtimsortPath) -> Double { @_common.sum(s.data) }

pub fn sort_hybrid_timsort_path_mean(s : SorthybridtimsortPath) -> Double { @_common.mean(s.data) }

pub fn sort_hybrid_timsort_path_scale(s : SorthybridtimsortPath, f : Double) -> SorthybridtimsortPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_hybrid_timsort_path_add(a : SorthybridtimsortPath, b : SorthybridtimsortPath) -> SorthybridtimsortPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_hybrid_timsort_path_copy(s : SorthybridtimsortPath) -> SorthybridtimsortPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_hybrid_timsort_path_fill(s : SorthybridtimsortPath, v : Double) -> SorthybridtimsortPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_hybrid_timsort_path_min(s : SorthybridtimsortPath) -> Double { @_common.min(s.data) }

pub fn sort_hybrid_timsort_path_max(s : SorthybridtimsortPath) -> Double { @_common.max(s.data) }

pub fn sort_hybrid_timsort_path_to_string(s : SorthybridtimsortPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SorthybridtimsortCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_hybrid_timsort_cluster_make(size : Int) -> SorthybridtimsortCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_hybrid_timsort_cluster_len(s : SorthybridtimsortCluster) -> Int { s.size }

pub fn sort_hybrid_timsort_cluster_get(s : SorthybridtimsortCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_hybrid_timsort_cluster_set(s : SorthybridtimsortCluster, i : Int, v : Double) -> SorthybridtimsortCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_hybrid_timsort_cluster_sum(s : SorthybridtimsortCluster) -> Double { @_common.sum(s.data) }

pub fn sort_hybrid_timsort_cluster_mean(s : SorthybridtimsortCluster) -> Double { @_common.mean(s.data) }

pub fn sort_hybrid_timsort_cluster_scale(s : SorthybridtimsortCluster, f : Double) -> SorthybridtimsortCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_hybrid_timsort_cluster_add(a : SorthybridtimsortCluster, b : SorthybridtimsortCluster) -> SorthybridtimsortCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_hybrid_timsort_cluster_copy(s : SorthybridtimsortCluster) -> SorthybridtimsortCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_hybrid_timsort_cluster_fill(s : SorthybridtimsortCluster, v : Double) -> SorthybridtimsortCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_hybrid_timsort_cluster_min(s : SorthybridtimsortCluster) -> Double { @_common.min(s.data) }

pub fn sort_hybrid_timsort_cluster_max(s : SorthybridtimsortCluster) -> Double { @_common.max(s.data) }

pub fn sort_hybrid_timsort_cluster_to_string(s : SorthybridtimsortCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SorthybridtimsortModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_hybrid_timsort_model_make(size : Int) -> SorthybridtimsortModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_hybrid_timsort_model_len(s : SorthybridtimsortModel) -> Int { s.size }

pub fn sort_hybrid_timsort_model_get(s : SorthybridtimsortModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_hybrid_timsort_model_set(s : SorthybridtimsortModel, i : Int, v : Double) -> SorthybridtimsortModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_hybrid_timsort_model_sum(s : SorthybridtimsortModel) -> Double { @_common.sum(s.data) }

pub fn sort_hybrid_timsort_model_mean(s : SorthybridtimsortModel) -> Double { @_common.mean(s.data) }

pub fn sort_hybrid_timsort_model_scale(s : SorthybridtimsortModel, f : Double) -> SorthybridtimsortModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_hybrid_timsort_model_add(a : SorthybridtimsortModel, b : SorthybridtimsortModel) -> SorthybridtimsortModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_hybrid_timsort_model_copy(s : SorthybridtimsortModel) -> SorthybridtimsortModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_hybrid_timsort_model_fill(s : SorthybridtimsortModel, v : Double) -> SorthybridtimsortModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_hybrid_timsort_model_min(s : SorthybridtimsortModel) -> Double { @_common.min(s.data) }

pub fn sort_hybrid_timsort_model_max(s : SorthybridtimsortModel) -> Double { @_common.max(s.data) }

pub fn sort_hybrid_timsort_model_to_string(s : SorthybridtimsortModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SorthybridtimsortLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_hybrid_timsort_layer_make(size : Int) -> SorthybridtimsortLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_hybrid_timsort_layer_len(s : SorthybridtimsortLayer) -> Int { s.size }

pub fn sort_hybrid_timsort_layer_get(s : SorthybridtimsortLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_hybrid_timsort_layer_set(s : SorthybridtimsortLayer, i : Int, v : Double) -> SorthybridtimsortLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_hybrid_timsort_layer_sum(s : SorthybridtimsortLayer) -> Double { @_common.sum(s.data) }

pub fn sort_hybrid_timsort_layer_mean(s : SorthybridtimsortLayer) -> Double { @_common.mean(s.data) }

pub fn sort_hybrid_timsort_layer_scale(s : SorthybridtimsortLayer, f : Double) -> SorthybridtimsortLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_hybrid_timsort_layer_add(a : SorthybridtimsortLayer, b : SorthybridtimsortLayer) -> SorthybridtimsortLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_hybrid_timsort_layer_copy(s : SorthybridtimsortLayer) -> SorthybridtimsortLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_hybrid_timsort_layer_fill(s : SorthybridtimsortLayer, v : Double) -> SorthybridtimsortLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_hybrid_timsort_layer_min(s : SorthybridtimsortLayer) -> Double { @_common.min(s.data) }

pub fn sort_hybrid_timsort_layer_max(s : SorthybridtimsortLayer) -> Double { @_common.max(s.data) }

pub fn sort_hybrid_timsort_layer_to_string(s : SorthybridtimsortLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SorthybridtimsortBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_hybrid_timsort_buffer_make(size : Int) -> SorthybridtimsortBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_hybrid_timsort_buffer_len(s : SorthybridtimsortBuffer) -> Int { s.size }

pub fn sort_hybrid_timsort_buffer_get(s : SorthybridtimsortBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_hybrid_timsort_buffer_set(s : SorthybridtimsortBuffer, i : Int, v : Double) -> SorthybridtimsortBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_hybrid_timsort_buffer_sum(s : SorthybridtimsortBuffer) -> Double { @_common.sum(s.data) }

pub fn sort_hybrid_timsort_buffer_mean(s : SorthybridtimsortBuffer) -> Double { @_common.mean(s.data) }

pub fn sort_hybrid_timsort_buffer_scale(s : SorthybridtimsortBuffer, f : Double) -> SorthybridtimsortBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_hybrid_timsort_buffer_add(a : SorthybridtimsortBuffer, b : SorthybridtimsortBuffer) -> SorthybridtimsortBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_hybrid_timsort_buffer_copy(s : SorthybridtimsortBuffer) -> SorthybridtimsortBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_hybrid_timsort_buffer_fill(s : SorthybridtimsortBuffer, v : Double) -> SorthybridtimsortBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_hybrid_timsort_buffer_min(s : SorthybridtimsortBuffer) -> Double { @_common.min(s.data) }

pub fn sort_hybrid_timsort_buffer_max(s : SorthybridtimsortBuffer) -> Double { @_common.max(s.data) }

pub fn sort_hybrid_timsort_buffer_to_string(s : SorthybridtimsortBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SorthybridtimsortCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_hybrid_timsort_cursor_make(size : Int) -> SorthybridtimsortCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_hybrid_timsort_cursor_len(s : SorthybridtimsortCursor) -> Int { s.size }

pub fn sort_hybrid_timsort_cursor_get(s : SorthybridtimsortCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_hybrid_timsort_cursor_set(s : SorthybridtimsortCursor, i : Int, v : Double) -> SorthybridtimsortCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_hybrid_timsort_cursor_sum(s : SorthybridtimsortCursor) -> Double { @_common.sum(s.data) }

pub fn sort_hybrid_timsort_cursor_mean(s : SorthybridtimsortCursor) -> Double { @_common.mean(s.data) }

pub fn sort_hybrid_timsort_cursor_scale(s : SorthybridtimsortCursor, f : Double) -> SorthybridtimsortCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_hybrid_timsort_cursor_add(a : SorthybridtimsortCursor, b : SorthybridtimsortCursor) -> SorthybridtimsortCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_hybrid_timsort_cursor_copy(s : SorthybridtimsortCursor) -> SorthybridtimsortCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_hybrid_timsort_cursor_fill(s : SorthybridtimsortCursor, v : Double) -> SorthybridtimsortCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_hybrid_timsort_cursor_min(s : SorthybridtimsortCursor) -> Double { @_common.min(s.data) }

pub fn sort_hybrid_timsort_cursor_max(s : SorthybridtimsortCursor) -> Double { @_common.max(s.data) }

pub fn sort_hybrid_timsort_cursor_to_string(s : SorthybridtimsortCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SorthybridtimsortView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_hybrid_timsort_view_make(size : Int) -> SorthybridtimsortView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_hybrid_timsort_view_len(s : SorthybridtimsortView) -> Int { s.size }

pub fn sort_hybrid_timsort_view_get(s : SorthybridtimsortView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_hybrid_timsort_view_set(s : SorthybridtimsortView, i : Int, v : Double) -> SorthybridtimsortView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_hybrid_timsort_view_sum(s : SorthybridtimsortView) -> Double { @_common.sum(s.data) }

pub fn sort_hybrid_timsort_view_mean(s : SorthybridtimsortView) -> Double { @_common.mean(s.data) }

pub fn sort_hybrid_timsort_view_scale(s : SorthybridtimsortView, f : Double) -> SorthybridtimsortView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_hybrid_timsort_view_add(a : SorthybridtimsortView, b : SorthybridtimsortView) -> SorthybridtimsortView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_hybrid_timsort_view_copy(s : SorthybridtimsortView) -> SorthybridtimsortView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_hybrid_timsort_view_fill(s : SorthybridtimsortView, v : Double) -> SorthybridtimsortView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_hybrid_timsort_view_min(s : SorthybridtimsortView) -> Double { @_common.min(s.data) }

pub fn sort_hybrid_timsort_view_max(s : SorthybridtimsortView) -> Double { @_common.max(s.data) }

pub fn sort_hybrid_timsort_view_to_string(s : SorthybridtimsortView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SorthybridtimsortRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_hybrid_timsort_range_make(size : Int) -> SorthybridtimsortRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_hybrid_timsort_range_len(s : SorthybridtimsortRange) -> Int { s.size }

pub fn sort_hybrid_timsort_range_get(s : SorthybridtimsortRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_hybrid_timsort_range_set(s : SorthybridtimsortRange, i : Int, v : Double) -> SorthybridtimsortRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_hybrid_timsort_range_sum(s : SorthybridtimsortRange) -> Double { @_common.sum(s.data) }

pub fn sort_hybrid_timsort_range_mean(s : SorthybridtimsortRange) -> Double { @_common.mean(s.data) }

pub fn sort_hybrid_timsort_range_scale(s : SorthybridtimsortRange, f : Double) -> SorthybridtimsortRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_hybrid_timsort_range_add(a : SorthybridtimsortRange, b : SorthybridtimsortRange) -> SorthybridtimsortRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_hybrid_timsort_range_copy(s : SorthybridtimsortRange) -> SorthybridtimsortRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_hybrid_timsort_range_fill(s : SorthybridtimsortRange, v : Double) -> SorthybridtimsortRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_hybrid_timsort_range_min(s : SorthybridtimsortRange) -> Double { @_common.min(s.data) }

pub fn sort_hybrid_timsort_range_max(s : SorthybridtimsortRange) -> Double { @_common.max(s.data) }

pub fn sort_hybrid_timsort_range_to_string(s : SorthybridtimsortRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SorthybridtimsortSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_hybrid_timsort_slice_make(size : Int) -> SorthybridtimsortSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_hybrid_timsort_slice_len(s : SorthybridtimsortSlice) -> Int { s.size }

pub fn sort_hybrid_timsort_slice_get(s : SorthybridtimsortSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_hybrid_timsort_slice_set(s : SorthybridtimsortSlice, i : Int, v : Double) -> SorthybridtimsortSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_hybrid_timsort_slice_sum(s : SorthybridtimsortSlice) -> Double { @_common.sum(s.data) }

pub fn sort_hybrid_timsort_slice_mean(s : SorthybridtimsortSlice) -> Double { @_common.mean(s.data) }

pub fn sort_hybrid_timsort_slice_scale(s : SorthybridtimsortSlice, f : Double) -> SorthybridtimsortSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_hybrid_timsort_slice_add(a : SorthybridtimsortSlice, b : SorthybridtimsortSlice) -> SorthybridtimsortSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_hybrid_timsort_slice_copy(s : SorthybridtimsortSlice) -> SorthybridtimsortSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_hybrid_timsort_slice_fill(s : SorthybridtimsortSlice, v : Double) -> SorthybridtimsortSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_hybrid_timsort_slice_min(s : SorthybridtimsortSlice) -> Double { @_common.min(s.data) }

pub fn sort_hybrid_timsort_slice_max(s : SorthybridtimsortSlice) -> Double { @_common.max(s.data) }

pub fn sort_hybrid_timsort_slice_to_string(s : SorthybridtimsortSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

