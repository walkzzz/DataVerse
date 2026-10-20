///===
/// extcore/sort_hybrid_blitsort

pub(all) struct SorthybridblitsortPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn sort_hybrid_blitsort_make_point(x : Double, y : Double) -> SorthybridblitsortPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn sort_hybrid_blitsort_make_point3(x : Double, y : Double, z : Double) -> SorthybridblitsortPoint {
  { x, y, z, label: 0 }
}

pub fn SorthybridblitsortPoint::x(self : SorthybridblitsortPoint) -> Double { self.x }

pub fn SorthybridblitsortPoint::y(self : SorthybridblitsortPoint) -> Double { self.y }

pub fn SorthybridblitsortPoint::z(self : SorthybridblitsortPoint) -> Double { self.z }

pub fn SorthybridblitsortPoint::label(self : SorthybridblitsortPoint) -> Int { self.label }

pub fn SorthybridblitsortPoint::dist(self : SorthybridblitsortPoint, other : SorthybridblitsortPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn SorthybridblitsortPoint::add(self : SorthybridblitsortPoint, other : SorthybridblitsortPoint) -> SorthybridblitsortPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn SorthybridblitsortPoint::sub(self : SorthybridblitsortPoint, other : SorthybridblitsortPoint) -> SorthybridblitsortPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn SorthybridblitsortPoint::scale(self : SorthybridblitsortPoint, s : Double) -> SorthybridblitsortPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn SorthybridblitsortPoint::dot(self : SorthybridblitsortPoint, other : SorthybridblitsortPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn SorthybridblitsortPoint::cross(self : SorthybridblitsortPoint, other : SorthybridblitsortPoint) -> SorthybridblitsortPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn SorthybridblitsortPoint::norm(self : SorthybridblitsortPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn SorthybridblitsortPoint::normalize(self : SorthybridblitsortPoint) -> SorthybridblitsortPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn SorthybridblitsortPoint::negate(self : SorthybridblitsortPoint) -> SorthybridblitsortPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn SorthybridblitsortPoint::mid(self : SorthybridblitsortPoint, other : SorthybridblitsortPoint) -> SorthybridblitsortPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn SorthybridblitsortPoint::lerp(self : SorthybridblitsortPoint, other : SorthybridblitsortPoint, t : Double) -> SorthybridblitsortPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn SorthybridblitsortPoint::to_string(self : SorthybridblitsortPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct SorthybridblitsortSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn sort_hybrid_blitsort_make_series(vals : Array[Double], name : String) -> SorthybridblitsortSeries {
  { vals, name, meta: 0 }
}

pub fn SorthybridblitsortSeries::len(self : SorthybridblitsortSeries) -> Int { self.vals.length() }

pub fn SorthybridblitsortSeries::sum(self : SorthybridblitsortSeries) -> Double { @_common.sum(self.vals) }

pub fn SorthybridblitsortSeries::mean(self : SorthybridblitsortSeries) -> Double { @_common.mean(self.vals) }

pub fn SorthybridblitsortSeries::min(self : SorthybridblitsortSeries) -> Double { @_common.min(self.vals) }

pub fn SorthybridblitsortSeries::max(self : SorthybridblitsortSeries) -> Double { @_common.max(self.vals) }

pub fn SorthybridblitsortSeries::range(self : SorthybridblitsortSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn SorthybridblitsortSeries::variance(self : SorthybridblitsortSeries) -> Double { @_common.variance(self.vals) }

pub fn SorthybridblitsortSeries::std(self : SorthybridblitsortSeries) -> Double { @_common.std(self.vals) }

pub fn SorthybridblitsortSeries::median(self : SorthybridblitsortSeries) -> Double { @_common.median(self.vals) }

pub fn SorthybridblitsortSeries::scale(self : SorthybridblitsortSeries, f : Double) -> SorthybridblitsortSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn SorthybridblitsortSeries::add(self : SorthybridblitsortSeries, other : SorthybridblitsortSeries) -> SorthybridblitsortSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn SorthybridblitsortSeries::sub(self : SorthybridblitsortSeries, other : SorthybridblitsortSeries) -> SorthybridblitsortSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn SorthybridblitsortSeries::normalize(self : SorthybridblitsortSeries) -> SorthybridblitsortSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn SorthybridblitsortSeries::cumsum(self : SorthybridblitsortSeries) -> SorthybridblitsortSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn SorthybridblitsortSeries::to_string(self : SorthybridblitsortSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct SorthybridblitsortMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn sort_hybrid_blitsort_make_matrix(rows : Int, cols : Int, val : Double) -> SorthybridblitsortMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn sort_hybrid_blitsort_matrix_identity(n : Int) -> SorthybridblitsortMatrix {
  let m = sort_hybrid_blitsort_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn SorthybridblitsortMatrix::get(self : SorthybridblitsortMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn SorthybridblitsortMatrix::transpose(self : SorthybridblitsortMatrix) -> SorthybridblitsortMatrix {
  let result = sort_hybrid_blitsort_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn SorthybridblitsortMatrix::add(self : SorthybridblitsortMatrix, other : SorthybridblitsortMatrix) -> SorthybridblitsortMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = sort_hybrid_blitsort_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn SorthybridblitsortMatrix::scale(self : SorthybridblitsortMatrix, s : Double) -> SorthybridblitsortMatrix {
  let result = sort_hybrid_blitsort_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn SorthybridblitsortMatrix::multiply(self : SorthybridblitsortMatrix, other : SorthybridblitsortMatrix) -> SorthybridblitsortMatrix {
  if self.cols != other.rows { return sort_hybrid_blitsort_make_matrix(self.rows, other.cols, 0.0) }
  let result = sort_hybrid_blitsort_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn SorthybridblitsortMatrix::trace(self : SorthybridblitsortMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn SorthybridblitsortMatrix::det(self : SorthybridblitsortMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn SorthybridblitsortMatrix::norm(self : SorthybridblitsortMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn SorthybridblitsortMatrix::to_string(self : SorthybridblitsortMatrix) -> String {
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

pub(all) struct SorthybridblitsortVector {
  comps : Array[Double]
  dim : Int
}

pub fn sort_hybrid_blitsort_make_vector(comps : Array[Double]) -> SorthybridblitsortVector {
  { comps, dim: comps.length() }
}

pub fn sort_hybrid_blitsort_vector_zero(dim : Int) -> SorthybridblitsortVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn SorthybridblitsortVector::add(self : SorthybridblitsortVector, other : SorthybridblitsortVector) -> SorthybridblitsortVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn SorthybridblitsortVector::sub(self : SorthybridblitsortVector, other : SorthybridblitsortVector) -> SorthybridblitsortVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn SorthybridblitsortVector::scale(self : SorthybridblitsortVector, s : Double) -> SorthybridblitsortVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn SorthybridblitsortVector::dot(self : SorthybridblitsortVector, other : SorthybridblitsortVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn SorthybridblitsortVector::norm(self : SorthybridblitsortVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn SorthybridblitsortVector::normalize(self : SorthybridblitsortVector) -> SorthybridblitsortVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn SorthybridblitsortVector::dist(self : SorthybridblitsortVector, other : SorthybridblitsortVector) -> Double {
  self.sub(other).norm()
}

pub fn SorthybridblitsortVector::to_string(self : SorthybridblitsortVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn sort_hybrid_blitsort_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn sort_hybrid_blitsort_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn sort_hybrid_blitsort_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn sort_hybrid_blitsort_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn sort_hybrid_blitsort_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn sort_hybrid_blitsort_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn sort_hybrid_blitsort_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn sort_hybrid_blitsort_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn sort_hybrid_blitsort_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn sort_hybrid_blitsort_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn sort_hybrid_blitsort_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn sort_hybrid_blitsort_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn sort_hybrid_blitsort_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn sort_hybrid_blitsort_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn sort_hybrid_blitsort_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn sort_hybrid_blitsort_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn sort_hybrid_blitsort_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn sort_hybrid_blitsort_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn sort_hybrid_blitsort_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn sort_hybrid_blitsort_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn sort_hybrid_blitsort_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn sort_hybrid_blitsort_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn sort_hybrid_blitsort_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn sort_hybrid_blitsort_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn sort_hybrid_blitsort_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn sort_hybrid_blitsort_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn sort_hybrid_blitsort_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn sort_hybrid_blitsort_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn sort_hybrid_blitsort_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct SorthybridblitsortFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_hybrid_blitsort_frame_make(size : Int) -> SorthybridblitsortFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_hybrid_blitsort_frame_len(s : SorthybridblitsortFrame) -> Int { s.size }

pub fn sort_hybrid_blitsort_frame_get(s : SorthybridblitsortFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_hybrid_blitsort_frame_set(s : SorthybridblitsortFrame, i : Int, v : Double) -> SorthybridblitsortFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_hybrid_blitsort_frame_sum(s : SorthybridblitsortFrame) -> Double { @_common.sum(s.data) }

pub fn sort_hybrid_blitsort_frame_mean(s : SorthybridblitsortFrame) -> Double { @_common.mean(s.data) }

pub fn sort_hybrid_blitsort_frame_scale(s : SorthybridblitsortFrame, f : Double) -> SorthybridblitsortFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_hybrid_blitsort_frame_add(a : SorthybridblitsortFrame, b : SorthybridblitsortFrame) -> SorthybridblitsortFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_hybrid_blitsort_frame_copy(s : SorthybridblitsortFrame) -> SorthybridblitsortFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_hybrid_blitsort_frame_fill(s : SorthybridblitsortFrame, v : Double) -> SorthybridblitsortFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_hybrid_blitsort_frame_min(s : SorthybridblitsortFrame) -> Double { @_common.min(s.data) }

pub fn sort_hybrid_blitsort_frame_max(s : SorthybridblitsortFrame) -> Double { @_common.max(s.data) }

pub fn sort_hybrid_blitsort_frame_to_string(s : SorthybridblitsortFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SorthybridblitsortTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_hybrid_blitsort_table_make(size : Int) -> SorthybridblitsortTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_hybrid_blitsort_table_len(s : SorthybridblitsortTable) -> Int { s.size }

pub fn sort_hybrid_blitsort_table_get(s : SorthybridblitsortTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_hybrid_blitsort_table_set(s : SorthybridblitsortTable, i : Int, v : Double) -> SorthybridblitsortTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_hybrid_blitsort_table_sum(s : SorthybridblitsortTable) -> Double { @_common.sum(s.data) }

pub fn sort_hybrid_blitsort_table_mean(s : SorthybridblitsortTable) -> Double { @_common.mean(s.data) }

pub fn sort_hybrid_blitsort_table_scale(s : SorthybridblitsortTable, f : Double) -> SorthybridblitsortTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_hybrid_blitsort_table_add(a : SorthybridblitsortTable, b : SorthybridblitsortTable) -> SorthybridblitsortTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_hybrid_blitsort_table_copy(s : SorthybridblitsortTable) -> SorthybridblitsortTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_hybrid_blitsort_table_fill(s : SorthybridblitsortTable, v : Double) -> SorthybridblitsortTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_hybrid_blitsort_table_min(s : SorthybridblitsortTable) -> Double { @_common.min(s.data) }

pub fn sort_hybrid_blitsort_table_max(s : SorthybridblitsortTable) -> Double { @_common.max(s.data) }

pub fn sort_hybrid_blitsort_table_to_string(s : SorthybridblitsortTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SorthybridblitsortGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_hybrid_blitsort_graphn_make(size : Int) -> SorthybridblitsortGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_hybrid_blitsort_graphn_len(s : SorthybridblitsortGraphN) -> Int { s.size }

pub fn sort_hybrid_blitsort_graphn_get(s : SorthybridblitsortGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_hybrid_blitsort_graphn_set(s : SorthybridblitsortGraphN, i : Int, v : Double) -> SorthybridblitsortGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_hybrid_blitsort_graphn_sum(s : SorthybridblitsortGraphN) -> Double { @_common.sum(s.data) }

pub fn sort_hybrid_blitsort_graphn_mean(s : SorthybridblitsortGraphN) -> Double { @_common.mean(s.data) }

pub fn sort_hybrid_blitsort_graphn_scale(s : SorthybridblitsortGraphN, f : Double) -> SorthybridblitsortGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_hybrid_blitsort_graphn_add(a : SorthybridblitsortGraphN, b : SorthybridblitsortGraphN) -> SorthybridblitsortGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_hybrid_blitsort_graphn_copy(s : SorthybridblitsortGraphN) -> SorthybridblitsortGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_hybrid_blitsort_graphn_fill(s : SorthybridblitsortGraphN, v : Double) -> SorthybridblitsortGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_hybrid_blitsort_graphn_min(s : SorthybridblitsortGraphN) -> Double { @_common.min(s.data) }

pub fn sort_hybrid_blitsort_graphn_max(s : SorthybridblitsortGraphN) -> Double { @_common.max(s.data) }

pub fn sort_hybrid_blitsort_graphn_to_string(s : SorthybridblitsortGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SorthybridblitsortNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_hybrid_blitsort_node_make(size : Int) -> SorthybridblitsortNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_hybrid_blitsort_node_len(s : SorthybridblitsortNode) -> Int { s.size }

pub fn sort_hybrid_blitsort_node_get(s : SorthybridblitsortNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_hybrid_blitsort_node_set(s : SorthybridblitsortNode, i : Int, v : Double) -> SorthybridblitsortNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_hybrid_blitsort_node_sum(s : SorthybridblitsortNode) -> Double { @_common.sum(s.data) }

pub fn sort_hybrid_blitsort_node_mean(s : SorthybridblitsortNode) -> Double { @_common.mean(s.data) }

pub fn sort_hybrid_blitsort_node_scale(s : SorthybridblitsortNode, f : Double) -> SorthybridblitsortNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_hybrid_blitsort_node_add(a : SorthybridblitsortNode, b : SorthybridblitsortNode) -> SorthybridblitsortNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_hybrid_blitsort_node_copy(s : SorthybridblitsortNode) -> SorthybridblitsortNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_hybrid_blitsort_node_fill(s : SorthybridblitsortNode, v : Double) -> SorthybridblitsortNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_hybrid_blitsort_node_min(s : SorthybridblitsortNode) -> Double { @_common.min(s.data) }

pub fn sort_hybrid_blitsort_node_max(s : SorthybridblitsortNode) -> Double { @_common.max(s.data) }

pub fn sort_hybrid_blitsort_node_to_string(s : SorthybridblitsortNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SorthybridblitsortEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_hybrid_blitsort_edge_make(size : Int) -> SorthybridblitsortEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_hybrid_blitsort_edge_len(s : SorthybridblitsortEdge) -> Int { s.size }

pub fn sort_hybrid_blitsort_edge_get(s : SorthybridblitsortEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_hybrid_blitsort_edge_set(s : SorthybridblitsortEdge, i : Int, v : Double) -> SorthybridblitsortEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_hybrid_blitsort_edge_sum(s : SorthybridblitsortEdge) -> Double { @_common.sum(s.data) }

pub fn sort_hybrid_blitsort_edge_mean(s : SorthybridblitsortEdge) -> Double { @_common.mean(s.data) }

pub fn sort_hybrid_blitsort_edge_scale(s : SorthybridblitsortEdge, f : Double) -> SorthybridblitsortEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_hybrid_blitsort_edge_add(a : SorthybridblitsortEdge, b : SorthybridblitsortEdge) -> SorthybridblitsortEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_hybrid_blitsort_edge_copy(s : SorthybridblitsortEdge) -> SorthybridblitsortEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_hybrid_blitsort_edge_fill(s : SorthybridblitsortEdge, v : Double) -> SorthybridblitsortEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_hybrid_blitsort_edge_min(s : SorthybridblitsortEdge) -> Double { @_common.min(s.data) }

pub fn sort_hybrid_blitsort_edge_max(s : SorthybridblitsortEdge) -> Double { @_common.max(s.data) }

pub fn sort_hybrid_blitsort_edge_to_string(s : SorthybridblitsortEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SorthybridblitsortPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_hybrid_blitsort_path_make(size : Int) -> SorthybridblitsortPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_hybrid_blitsort_path_len(s : SorthybridblitsortPath) -> Int { s.size }

pub fn sort_hybrid_blitsort_path_get(s : SorthybridblitsortPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_hybrid_blitsort_path_set(s : SorthybridblitsortPath, i : Int, v : Double) -> SorthybridblitsortPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_hybrid_blitsort_path_sum(s : SorthybridblitsortPath) -> Double { @_common.sum(s.data) }

pub fn sort_hybrid_blitsort_path_mean(s : SorthybridblitsortPath) -> Double { @_common.mean(s.data) }

pub fn sort_hybrid_blitsort_path_scale(s : SorthybridblitsortPath, f : Double) -> SorthybridblitsortPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_hybrid_blitsort_path_add(a : SorthybridblitsortPath, b : SorthybridblitsortPath) -> SorthybridblitsortPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_hybrid_blitsort_path_copy(s : SorthybridblitsortPath) -> SorthybridblitsortPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_hybrid_blitsort_path_fill(s : SorthybridblitsortPath, v : Double) -> SorthybridblitsortPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_hybrid_blitsort_path_min(s : SorthybridblitsortPath) -> Double { @_common.min(s.data) }

pub fn sort_hybrid_blitsort_path_max(s : SorthybridblitsortPath) -> Double { @_common.max(s.data) }

pub fn sort_hybrid_blitsort_path_to_string(s : SorthybridblitsortPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SorthybridblitsortCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_hybrid_blitsort_cluster_make(size : Int) -> SorthybridblitsortCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_hybrid_blitsort_cluster_len(s : SorthybridblitsortCluster) -> Int { s.size }

pub fn sort_hybrid_blitsort_cluster_get(s : SorthybridblitsortCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_hybrid_blitsort_cluster_set(s : SorthybridblitsortCluster, i : Int, v : Double) -> SorthybridblitsortCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_hybrid_blitsort_cluster_sum(s : SorthybridblitsortCluster) -> Double { @_common.sum(s.data) }

pub fn sort_hybrid_blitsort_cluster_mean(s : SorthybridblitsortCluster) -> Double { @_common.mean(s.data) }

pub fn sort_hybrid_blitsort_cluster_scale(s : SorthybridblitsortCluster, f : Double) -> SorthybridblitsortCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_hybrid_blitsort_cluster_add(a : SorthybridblitsortCluster, b : SorthybridblitsortCluster) -> SorthybridblitsortCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_hybrid_blitsort_cluster_copy(s : SorthybridblitsortCluster) -> SorthybridblitsortCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_hybrid_blitsort_cluster_fill(s : SorthybridblitsortCluster, v : Double) -> SorthybridblitsortCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_hybrid_blitsort_cluster_min(s : SorthybridblitsortCluster) -> Double { @_common.min(s.data) }

pub fn sort_hybrid_blitsort_cluster_max(s : SorthybridblitsortCluster) -> Double { @_common.max(s.data) }

pub fn sort_hybrid_blitsort_cluster_to_string(s : SorthybridblitsortCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SorthybridblitsortModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_hybrid_blitsort_model_make(size : Int) -> SorthybridblitsortModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_hybrid_blitsort_model_len(s : SorthybridblitsortModel) -> Int { s.size }

pub fn sort_hybrid_blitsort_model_get(s : SorthybridblitsortModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_hybrid_blitsort_model_set(s : SorthybridblitsortModel, i : Int, v : Double) -> SorthybridblitsortModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_hybrid_blitsort_model_sum(s : SorthybridblitsortModel) -> Double { @_common.sum(s.data) }

pub fn sort_hybrid_blitsort_model_mean(s : SorthybridblitsortModel) -> Double { @_common.mean(s.data) }

pub fn sort_hybrid_blitsort_model_scale(s : SorthybridblitsortModel, f : Double) -> SorthybridblitsortModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_hybrid_blitsort_model_add(a : SorthybridblitsortModel, b : SorthybridblitsortModel) -> SorthybridblitsortModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_hybrid_blitsort_model_copy(s : SorthybridblitsortModel) -> SorthybridblitsortModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_hybrid_blitsort_model_fill(s : SorthybridblitsortModel, v : Double) -> SorthybridblitsortModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_hybrid_blitsort_model_min(s : SorthybridblitsortModel) -> Double { @_common.min(s.data) }

pub fn sort_hybrid_blitsort_model_max(s : SorthybridblitsortModel) -> Double { @_common.max(s.data) }

pub fn sort_hybrid_blitsort_model_to_string(s : SorthybridblitsortModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SorthybridblitsortLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_hybrid_blitsort_layer_make(size : Int) -> SorthybridblitsortLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_hybrid_blitsort_layer_len(s : SorthybridblitsortLayer) -> Int { s.size }

pub fn sort_hybrid_blitsort_layer_get(s : SorthybridblitsortLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_hybrid_blitsort_layer_set(s : SorthybridblitsortLayer, i : Int, v : Double) -> SorthybridblitsortLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_hybrid_blitsort_layer_sum(s : SorthybridblitsortLayer) -> Double { @_common.sum(s.data) }

pub fn sort_hybrid_blitsort_layer_mean(s : SorthybridblitsortLayer) -> Double { @_common.mean(s.data) }

pub fn sort_hybrid_blitsort_layer_scale(s : SorthybridblitsortLayer, f : Double) -> SorthybridblitsortLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_hybrid_blitsort_layer_add(a : SorthybridblitsortLayer, b : SorthybridblitsortLayer) -> SorthybridblitsortLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_hybrid_blitsort_layer_copy(s : SorthybridblitsortLayer) -> SorthybridblitsortLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_hybrid_blitsort_layer_fill(s : SorthybridblitsortLayer, v : Double) -> SorthybridblitsortLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_hybrid_blitsort_layer_min(s : SorthybridblitsortLayer) -> Double { @_common.min(s.data) }

pub fn sort_hybrid_blitsort_layer_max(s : SorthybridblitsortLayer) -> Double { @_common.max(s.data) }

pub fn sort_hybrid_blitsort_layer_to_string(s : SorthybridblitsortLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SorthybridblitsortBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_hybrid_blitsort_buffer_make(size : Int) -> SorthybridblitsortBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_hybrid_blitsort_buffer_len(s : SorthybridblitsortBuffer) -> Int { s.size }

pub fn sort_hybrid_blitsort_buffer_get(s : SorthybridblitsortBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_hybrid_blitsort_buffer_set(s : SorthybridblitsortBuffer, i : Int, v : Double) -> SorthybridblitsortBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_hybrid_blitsort_buffer_sum(s : SorthybridblitsortBuffer) -> Double { @_common.sum(s.data) }

pub fn sort_hybrid_blitsort_buffer_mean(s : SorthybridblitsortBuffer) -> Double { @_common.mean(s.data) }

pub fn sort_hybrid_blitsort_buffer_scale(s : SorthybridblitsortBuffer, f : Double) -> SorthybridblitsortBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_hybrid_blitsort_buffer_add(a : SorthybridblitsortBuffer, b : SorthybridblitsortBuffer) -> SorthybridblitsortBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_hybrid_blitsort_buffer_copy(s : SorthybridblitsortBuffer) -> SorthybridblitsortBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_hybrid_blitsort_buffer_fill(s : SorthybridblitsortBuffer, v : Double) -> SorthybridblitsortBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_hybrid_blitsort_buffer_min(s : SorthybridblitsortBuffer) -> Double { @_common.min(s.data) }

pub fn sort_hybrid_blitsort_buffer_max(s : SorthybridblitsortBuffer) -> Double { @_common.max(s.data) }

pub fn sort_hybrid_blitsort_buffer_to_string(s : SorthybridblitsortBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SorthybridblitsortCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_hybrid_blitsort_cursor_make(size : Int) -> SorthybridblitsortCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_hybrid_blitsort_cursor_len(s : SorthybridblitsortCursor) -> Int { s.size }

pub fn sort_hybrid_blitsort_cursor_get(s : SorthybridblitsortCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_hybrid_blitsort_cursor_set(s : SorthybridblitsortCursor, i : Int, v : Double) -> SorthybridblitsortCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_hybrid_blitsort_cursor_sum(s : SorthybridblitsortCursor) -> Double { @_common.sum(s.data) }

pub fn sort_hybrid_blitsort_cursor_mean(s : SorthybridblitsortCursor) -> Double { @_common.mean(s.data) }

pub fn sort_hybrid_blitsort_cursor_scale(s : SorthybridblitsortCursor, f : Double) -> SorthybridblitsortCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_hybrid_blitsort_cursor_add(a : SorthybridblitsortCursor, b : SorthybridblitsortCursor) -> SorthybridblitsortCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_hybrid_blitsort_cursor_copy(s : SorthybridblitsortCursor) -> SorthybridblitsortCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_hybrid_blitsort_cursor_fill(s : SorthybridblitsortCursor, v : Double) -> SorthybridblitsortCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_hybrid_blitsort_cursor_min(s : SorthybridblitsortCursor) -> Double { @_common.min(s.data) }

pub fn sort_hybrid_blitsort_cursor_max(s : SorthybridblitsortCursor) -> Double { @_common.max(s.data) }

pub fn sort_hybrid_blitsort_cursor_to_string(s : SorthybridblitsortCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SorthybridblitsortView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_hybrid_blitsort_view_make(size : Int) -> SorthybridblitsortView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_hybrid_blitsort_view_len(s : SorthybridblitsortView) -> Int { s.size }

pub fn sort_hybrid_blitsort_view_get(s : SorthybridblitsortView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_hybrid_blitsort_view_set(s : SorthybridblitsortView, i : Int, v : Double) -> SorthybridblitsortView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_hybrid_blitsort_view_sum(s : SorthybridblitsortView) -> Double { @_common.sum(s.data) }

pub fn sort_hybrid_blitsort_view_mean(s : SorthybridblitsortView) -> Double { @_common.mean(s.data) }

pub fn sort_hybrid_blitsort_view_scale(s : SorthybridblitsortView, f : Double) -> SorthybridblitsortView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_hybrid_blitsort_view_add(a : SorthybridblitsortView, b : SorthybridblitsortView) -> SorthybridblitsortView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_hybrid_blitsort_view_copy(s : SorthybridblitsortView) -> SorthybridblitsortView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_hybrid_blitsort_view_fill(s : SorthybridblitsortView, v : Double) -> SorthybridblitsortView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_hybrid_blitsort_view_min(s : SorthybridblitsortView) -> Double { @_common.min(s.data) }

pub fn sort_hybrid_blitsort_view_max(s : SorthybridblitsortView) -> Double { @_common.max(s.data) }

pub fn sort_hybrid_blitsort_view_to_string(s : SorthybridblitsortView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SorthybridblitsortRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_hybrid_blitsort_range_make(size : Int) -> SorthybridblitsortRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_hybrid_blitsort_range_len(s : SorthybridblitsortRange) -> Int { s.size }

pub fn sort_hybrid_blitsort_range_get(s : SorthybridblitsortRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_hybrid_blitsort_range_set(s : SorthybridblitsortRange, i : Int, v : Double) -> SorthybridblitsortRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_hybrid_blitsort_range_sum(s : SorthybridblitsortRange) -> Double { @_common.sum(s.data) }

pub fn sort_hybrid_blitsort_range_mean(s : SorthybridblitsortRange) -> Double { @_common.mean(s.data) }

pub fn sort_hybrid_blitsort_range_scale(s : SorthybridblitsortRange, f : Double) -> SorthybridblitsortRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_hybrid_blitsort_range_add(a : SorthybridblitsortRange, b : SorthybridblitsortRange) -> SorthybridblitsortRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_hybrid_blitsort_range_copy(s : SorthybridblitsortRange) -> SorthybridblitsortRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_hybrid_blitsort_range_fill(s : SorthybridblitsortRange, v : Double) -> SorthybridblitsortRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_hybrid_blitsort_range_min(s : SorthybridblitsortRange) -> Double { @_common.min(s.data) }

pub fn sort_hybrid_blitsort_range_max(s : SorthybridblitsortRange) -> Double { @_common.max(s.data) }

pub fn sort_hybrid_blitsort_range_to_string(s : SorthybridblitsortRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SorthybridblitsortSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_hybrid_blitsort_slice_make(size : Int) -> SorthybridblitsortSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_hybrid_blitsort_slice_len(s : SorthybridblitsortSlice) -> Int { s.size }

pub fn sort_hybrid_blitsort_slice_get(s : SorthybridblitsortSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_hybrid_blitsort_slice_set(s : SorthybridblitsortSlice, i : Int, v : Double) -> SorthybridblitsortSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_hybrid_blitsort_slice_sum(s : SorthybridblitsortSlice) -> Double { @_common.sum(s.data) }

pub fn sort_hybrid_blitsort_slice_mean(s : SorthybridblitsortSlice) -> Double { @_common.mean(s.data) }

pub fn sort_hybrid_blitsort_slice_scale(s : SorthybridblitsortSlice, f : Double) -> SorthybridblitsortSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_hybrid_blitsort_slice_add(a : SorthybridblitsortSlice, b : SorthybridblitsortSlice) -> SorthybridblitsortSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_hybrid_blitsort_slice_copy(s : SorthybridblitsortSlice) -> SorthybridblitsortSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_hybrid_blitsort_slice_fill(s : SorthybridblitsortSlice, v : Double) -> SorthybridblitsortSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_hybrid_blitsort_slice_min(s : SorthybridblitsortSlice) -> Double { @_common.min(s.data) }

pub fn sort_hybrid_blitsort_slice_max(s : SorthybridblitsortSlice) -> Double { @_common.max(s.data) }

pub fn sort_hybrid_blitsort_slice_to_string(s : SorthybridblitsortSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

