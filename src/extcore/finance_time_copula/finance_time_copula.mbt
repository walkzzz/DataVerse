///===
/// extcore/finance_time_copula

pub(all) struct FinancetimecopulaPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn finance_time_copula_make_point(x : Double, y : Double) -> FinancetimecopulaPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn finance_time_copula_make_point3(x : Double, y : Double, z : Double) -> FinancetimecopulaPoint {
  { x, y, z, label: 0 }
}

pub fn FinancetimecopulaPoint::x(self : FinancetimecopulaPoint) -> Double { self.x }

pub fn FinancetimecopulaPoint::y(self : FinancetimecopulaPoint) -> Double { self.y }

pub fn FinancetimecopulaPoint::z(self : FinancetimecopulaPoint) -> Double { self.z }

pub fn FinancetimecopulaPoint::label(self : FinancetimecopulaPoint) -> Int { self.label }

pub fn FinancetimecopulaPoint::dist(self : FinancetimecopulaPoint, other : FinancetimecopulaPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn FinancetimecopulaPoint::add(self : FinancetimecopulaPoint, other : FinancetimecopulaPoint) -> FinancetimecopulaPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn FinancetimecopulaPoint::sub(self : FinancetimecopulaPoint, other : FinancetimecopulaPoint) -> FinancetimecopulaPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn FinancetimecopulaPoint::scale(self : FinancetimecopulaPoint, s : Double) -> FinancetimecopulaPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn FinancetimecopulaPoint::dot(self : FinancetimecopulaPoint, other : FinancetimecopulaPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn FinancetimecopulaPoint::cross(self : FinancetimecopulaPoint, other : FinancetimecopulaPoint) -> FinancetimecopulaPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn FinancetimecopulaPoint::norm(self : FinancetimecopulaPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn FinancetimecopulaPoint::normalize(self : FinancetimecopulaPoint) -> FinancetimecopulaPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn FinancetimecopulaPoint::negate(self : FinancetimecopulaPoint) -> FinancetimecopulaPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn FinancetimecopulaPoint::mid(self : FinancetimecopulaPoint, other : FinancetimecopulaPoint) -> FinancetimecopulaPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn FinancetimecopulaPoint::lerp(self : FinancetimecopulaPoint, other : FinancetimecopulaPoint, t : Double) -> FinancetimecopulaPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn FinancetimecopulaPoint::to_string(self : FinancetimecopulaPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct FinancetimecopulaSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn finance_time_copula_make_series(vals : Array[Double], name : String) -> FinancetimecopulaSeries {
  { vals, name, meta: 0 }
}

pub fn FinancetimecopulaSeries::len(self : FinancetimecopulaSeries) -> Int { self.vals.length() }

pub fn FinancetimecopulaSeries::sum(self : FinancetimecopulaSeries) -> Double { @_common.sum(self.vals) }

pub fn FinancetimecopulaSeries::mean(self : FinancetimecopulaSeries) -> Double { @_common.mean(self.vals) }

pub fn FinancetimecopulaSeries::min(self : FinancetimecopulaSeries) -> Double { @_common.min(self.vals) }

pub fn FinancetimecopulaSeries::max(self : FinancetimecopulaSeries) -> Double { @_common.max(self.vals) }

pub fn FinancetimecopulaSeries::range(self : FinancetimecopulaSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn FinancetimecopulaSeries::variance(self : FinancetimecopulaSeries) -> Double { @_common.variance(self.vals) }

pub fn FinancetimecopulaSeries::std(self : FinancetimecopulaSeries) -> Double { @_common.std(self.vals) }

pub fn FinancetimecopulaSeries::median(self : FinancetimecopulaSeries) -> Double { @_common.median(self.vals) }

pub fn FinancetimecopulaSeries::scale(self : FinancetimecopulaSeries, f : Double) -> FinancetimecopulaSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn FinancetimecopulaSeries::add(self : FinancetimecopulaSeries, other : FinancetimecopulaSeries) -> FinancetimecopulaSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn FinancetimecopulaSeries::sub(self : FinancetimecopulaSeries, other : FinancetimecopulaSeries) -> FinancetimecopulaSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn FinancetimecopulaSeries::normalize(self : FinancetimecopulaSeries) -> FinancetimecopulaSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn FinancetimecopulaSeries::cumsum(self : FinancetimecopulaSeries) -> FinancetimecopulaSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn FinancetimecopulaSeries::to_string(self : FinancetimecopulaSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct FinancetimecopulaMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn finance_time_copula_make_matrix(rows : Int, cols : Int, val : Double) -> FinancetimecopulaMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn finance_time_copula_matrix_identity(n : Int) -> FinancetimecopulaMatrix {
  let m = finance_time_copula_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn FinancetimecopulaMatrix::get(self : FinancetimecopulaMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn FinancetimecopulaMatrix::transpose(self : FinancetimecopulaMatrix) -> FinancetimecopulaMatrix {
  let result = finance_time_copula_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn FinancetimecopulaMatrix::add(self : FinancetimecopulaMatrix, other : FinancetimecopulaMatrix) -> FinancetimecopulaMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = finance_time_copula_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn FinancetimecopulaMatrix::scale(self : FinancetimecopulaMatrix, s : Double) -> FinancetimecopulaMatrix {
  let result = finance_time_copula_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn FinancetimecopulaMatrix::multiply(self : FinancetimecopulaMatrix, other : FinancetimecopulaMatrix) -> FinancetimecopulaMatrix {
  if self.cols != other.rows { return finance_time_copula_make_matrix(self.rows, other.cols, 0.0) }
  let result = finance_time_copula_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn FinancetimecopulaMatrix::trace(self : FinancetimecopulaMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn FinancetimecopulaMatrix::det(self : FinancetimecopulaMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn FinancetimecopulaMatrix::norm(self : FinancetimecopulaMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn FinancetimecopulaMatrix::to_string(self : FinancetimecopulaMatrix) -> String {
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

pub(all) struct FinancetimecopulaVector {
  comps : Array[Double]
  dim : Int
}

pub fn finance_time_copula_make_vector(comps : Array[Double]) -> FinancetimecopulaVector {
  { comps, dim: comps.length() }
}

pub fn finance_time_copula_vector_zero(dim : Int) -> FinancetimecopulaVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn FinancetimecopulaVector::add(self : FinancetimecopulaVector, other : FinancetimecopulaVector) -> FinancetimecopulaVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn FinancetimecopulaVector::sub(self : FinancetimecopulaVector, other : FinancetimecopulaVector) -> FinancetimecopulaVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn FinancetimecopulaVector::scale(self : FinancetimecopulaVector, s : Double) -> FinancetimecopulaVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn FinancetimecopulaVector::dot(self : FinancetimecopulaVector, other : FinancetimecopulaVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn FinancetimecopulaVector::norm(self : FinancetimecopulaVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn FinancetimecopulaVector::normalize(self : FinancetimecopulaVector) -> FinancetimecopulaVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn FinancetimecopulaVector::dist(self : FinancetimecopulaVector, other : FinancetimecopulaVector) -> Double {
  self.sub(other).norm()
}

pub fn FinancetimecopulaVector::to_string(self : FinancetimecopulaVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn finance_time_copula_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn finance_time_copula_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn finance_time_copula_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn finance_time_copula_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn finance_time_copula_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn finance_time_copula_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn finance_time_copula_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn finance_time_copula_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn finance_time_copula_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn finance_time_copula_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn finance_time_copula_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn finance_time_copula_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn finance_time_copula_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn finance_time_copula_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn finance_time_copula_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn finance_time_copula_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn finance_time_copula_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn finance_time_copula_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn finance_time_copula_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn finance_time_copula_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn finance_time_copula_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn finance_time_copula_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn finance_time_copula_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn finance_time_copula_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn finance_time_copula_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn finance_time_copula_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn finance_time_copula_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn finance_time_copula_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn finance_time_copula_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct FinancetimecopulaFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_time_copula_frame_make(size : Int) -> FinancetimecopulaFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_time_copula_frame_len(s : FinancetimecopulaFrame) -> Int { s.size }

pub fn finance_time_copula_frame_get(s : FinancetimecopulaFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_time_copula_frame_set(s : FinancetimecopulaFrame, i : Int, v : Double) -> FinancetimecopulaFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_time_copula_frame_sum(s : FinancetimecopulaFrame) -> Double { @_common.sum(s.data) }

pub fn finance_time_copula_frame_mean(s : FinancetimecopulaFrame) -> Double { @_common.mean(s.data) }

pub fn finance_time_copula_frame_scale(s : FinancetimecopulaFrame, f : Double) -> FinancetimecopulaFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_time_copula_frame_add(a : FinancetimecopulaFrame, b : FinancetimecopulaFrame) -> FinancetimecopulaFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_time_copula_frame_copy(s : FinancetimecopulaFrame) -> FinancetimecopulaFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_time_copula_frame_fill(s : FinancetimecopulaFrame, v : Double) -> FinancetimecopulaFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_time_copula_frame_min(s : FinancetimecopulaFrame) -> Double { @_common.min(s.data) }

pub fn finance_time_copula_frame_max(s : FinancetimecopulaFrame) -> Double { @_common.max(s.data) }

pub fn finance_time_copula_frame_to_string(s : FinancetimecopulaFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinancetimecopulaTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_time_copula_table_make(size : Int) -> FinancetimecopulaTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_time_copula_table_len(s : FinancetimecopulaTable) -> Int { s.size }

pub fn finance_time_copula_table_get(s : FinancetimecopulaTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_time_copula_table_set(s : FinancetimecopulaTable, i : Int, v : Double) -> FinancetimecopulaTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_time_copula_table_sum(s : FinancetimecopulaTable) -> Double { @_common.sum(s.data) }

pub fn finance_time_copula_table_mean(s : FinancetimecopulaTable) -> Double { @_common.mean(s.data) }

pub fn finance_time_copula_table_scale(s : FinancetimecopulaTable, f : Double) -> FinancetimecopulaTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_time_copula_table_add(a : FinancetimecopulaTable, b : FinancetimecopulaTable) -> FinancetimecopulaTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_time_copula_table_copy(s : FinancetimecopulaTable) -> FinancetimecopulaTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_time_copula_table_fill(s : FinancetimecopulaTable, v : Double) -> FinancetimecopulaTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_time_copula_table_min(s : FinancetimecopulaTable) -> Double { @_common.min(s.data) }

pub fn finance_time_copula_table_max(s : FinancetimecopulaTable) -> Double { @_common.max(s.data) }

pub fn finance_time_copula_table_to_string(s : FinancetimecopulaTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinancetimecopulaGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_time_copula_graphn_make(size : Int) -> FinancetimecopulaGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_time_copula_graphn_len(s : FinancetimecopulaGraphN) -> Int { s.size }

pub fn finance_time_copula_graphn_get(s : FinancetimecopulaGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_time_copula_graphn_set(s : FinancetimecopulaGraphN, i : Int, v : Double) -> FinancetimecopulaGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_time_copula_graphn_sum(s : FinancetimecopulaGraphN) -> Double { @_common.sum(s.data) }

pub fn finance_time_copula_graphn_mean(s : FinancetimecopulaGraphN) -> Double { @_common.mean(s.data) }

pub fn finance_time_copula_graphn_scale(s : FinancetimecopulaGraphN, f : Double) -> FinancetimecopulaGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_time_copula_graphn_add(a : FinancetimecopulaGraphN, b : FinancetimecopulaGraphN) -> FinancetimecopulaGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_time_copula_graphn_copy(s : FinancetimecopulaGraphN) -> FinancetimecopulaGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_time_copula_graphn_fill(s : FinancetimecopulaGraphN, v : Double) -> FinancetimecopulaGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_time_copula_graphn_min(s : FinancetimecopulaGraphN) -> Double { @_common.min(s.data) }

pub fn finance_time_copula_graphn_max(s : FinancetimecopulaGraphN) -> Double { @_common.max(s.data) }

pub fn finance_time_copula_graphn_to_string(s : FinancetimecopulaGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinancetimecopulaNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_time_copula_node_make(size : Int) -> FinancetimecopulaNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_time_copula_node_len(s : FinancetimecopulaNode) -> Int { s.size }

pub fn finance_time_copula_node_get(s : FinancetimecopulaNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_time_copula_node_set(s : FinancetimecopulaNode, i : Int, v : Double) -> FinancetimecopulaNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_time_copula_node_sum(s : FinancetimecopulaNode) -> Double { @_common.sum(s.data) }

pub fn finance_time_copula_node_mean(s : FinancetimecopulaNode) -> Double { @_common.mean(s.data) }

pub fn finance_time_copula_node_scale(s : FinancetimecopulaNode, f : Double) -> FinancetimecopulaNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_time_copula_node_add(a : FinancetimecopulaNode, b : FinancetimecopulaNode) -> FinancetimecopulaNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_time_copula_node_copy(s : FinancetimecopulaNode) -> FinancetimecopulaNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_time_copula_node_fill(s : FinancetimecopulaNode, v : Double) -> FinancetimecopulaNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_time_copula_node_min(s : FinancetimecopulaNode) -> Double { @_common.min(s.data) }

pub fn finance_time_copula_node_max(s : FinancetimecopulaNode) -> Double { @_common.max(s.data) }

pub fn finance_time_copula_node_to_string(s : FinancetimecopulaNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinancetimecopulaEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_time_copula_edge_make(size : Int) -> FinancetimecopulaEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_time_copula_edge_len(s : FinancetimecopulaEdge) -> Int { s.size }

pub fn finance_time_copula_edge_get(s : FinancetimecopulaEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_time_copula_edge_set(s : FinancetimecopulaEdge, i : Int, v : Double) -> FinancetimecopulaEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_time_copula_edge_sum(s : FinancetimecopulaEdge) -> Double { @_common.sum(s.data) }

pub fn finance_time_copula_edge_mean(s : FinancetimecopulaEdge) -> Double { @_common.mean(s.data) }

pub fn finance_time_copula_edge_scale(s : FinancetimecopulaEdge, f : Double) -> FinancetimecopulaEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_time_copula_edge_add(a : FinancetimecopulaEdge, b : FinancetimecopulaEdge) -> FinancetimecopulaEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_time_copula_edge_copy(s : FinancetimecopulaEdge) -> FinancetimecopulaEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_time_copula_edge_fill(s : FinancetimecopulaEdge, v : Double) -> FinancetimecopulaEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_time_copula_edge_min(s : FinancetimecopulaEdge) -> Double { @_common.min(s.data) }

pub fn finance_time_copula_edge_max(s : FinancetimecopulaEdge) -> Double { @_common.max(s.data) }

pub fn finance_time_copula_edge_to_string(s : FinancetimecopulaEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinancetimecopulaPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_time_copula_path_make(size : Int) -> FinancetimecopulaPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_time_copula_path_len(s : FinancetimecopulaPath) -> Int { s.size }

pub fn finance_time_copula_path_get(s : FinancetimecopulaPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_time_copula_path_set(s : FinancetimecopulaPath, i : Int, v : Double) -> FinancetimecopulaPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_time_copula_path_sum(s : FinancetimecopulaPath) -> Double { @_common.sum(s.data) }

pub fn finance_time_copula_path_mean(s : FinancetimecopulaPath) -> Double { @_common.mean(s.data) }

pub fn finance_time_copula_path_scale(s : FinancetimecopulaPath, f : Double) -> FinancetimecopulaPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_time_copula_path_add(a : FinancetimecopulaPath, b : FinancetimecopulaPath) -> FinancetimecopulaPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_time_copula_path_copy(s : FinancetimecopulaPath) -> FinancetimecopulaPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_time_copula_path_fill(s : FinancetimecopulaPath, v : Double) -> FinancetimecopulaPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_time_copula_path_min(s : FinancetimecopulaPath) -> Double { @_common.min(s.data) }

pub fn finance_time_copula_path_max(s : FinancetimecopulaPath) -> Double { @_common.max(s.data) }

pub fn finance_time_copula_path_to_string(s : FinancetimecopulaPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinancetimecopulaCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_time_copula_cluster_make(size : Int) -> FinancetimecopulaCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_time_copula_cluster_len(s : FinancetimecopulaCluster) -> Int { s.size }

pub fn finance_time_copula_cluster_get(s : FinancetimecopulaCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_time_copula_cluster_set(s : FinancetimecopulaCluster, i : Int, v : Double) -> FinancetimecopulaCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_time_copula_cluster_sum(s : FinancetimecopulaCluster) -> Double { @_common.sum(s.data) }

pub fn finance_time_copula_cluster_mean(s : FinancetimecopulaCluster) -> Double { @_common.mean(s.data) }

pub fn finance_time_copula_cluster_scale(s : FinancetimecopulaCluster, f : Double) -> FinancetimecopulaCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_time_copula_cluster_add(a : FinancetimecopulaCluster, b : FinancetimecopulaCluster) -> FinancetimecopulaCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_time_copula_cluster_copy(s : FinancetimecopulaCluster) -> FinancetimecopulaCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_time_copula_cluster_fill(s : FinancetimecopulaCluster, v : Double) -> FinancetimecopulaCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_time_copula_cluster_min(s : FinancetimecopulaCluster) -> Double { @_common.min(s.data) }

pub fn finance_time_copula_cluster_max(s : FinancetimecopulaCluster) -> Double { @_common.max(s.data) }

pub fn finance_time_copula_cluster_to_string(s : FinancetimecopulaCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinancetimecopulaModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_time_copula_model_make(size : Int) -> FinancetimecopulaModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_time_copula_model_len(s : FinancetimecopulaModel) -> Int { s.size }

pub fn finance_time_copula_model_get(s : FinancetimecopulaModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_time_copula_model_set(s : FinancetimecopulaModel, i : Int, v : Double) -> FinancetimecopulaModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_time_copula_model_sum(s : FinancetimecopulaModel) -> Double { @_common.sum(s.data) }

pub fn finance_time_copula_model_mean(s : FinancetimecopulaModel) -> Double { @_common.mean(s.data) }

pub fn finance_time_copula_model_scale(s : FinancetimecopulaModel, f : Double) -> FinancetimecopulaModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_time_copula_model_add(a : FinancetimecopulaModel, b : FinancetimecopulaModel) -> FinancetimecopulaModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_time_copula_model_copy(s : FinancetimecopulaModel) -> FinancetimecopulaModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_time_copula_model_fill(s : FinancetimecopulaModel, v : Double) -> FinancetimecopulaModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_time_copula_model_min(s : FinancetimecopulaModel) -> Double { @_common.min(s.data) }

pub fn finance_time_copula_model_max(s : FinancetimecopulaModel) -> Double { @_common.max(s.data) }

pub fn finance_time_copula_model_to_string(s : FinancetimecopulaModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinancetimecopulaLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_time_copula_layer_make(size : Int) -> FinancetimecopulaLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_time_copula_layer_len(s : FinancetimecopulaLayer) -> Int { s.size }

pub fn finance_time_copula_layer_get(s : FinancetimecopulaLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_time_copula_layer_set(s : FinancetimecopulaLayer, i : Int, v : Double) -> FinancetimecopulaLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_time_copula_layer_sum(s : FinancetimecopulaLayer) -> Double { @_common.sum(s.data) }

pub fn finance_time_copula_layer_mean(s : FinancetimecopulaLayer) -> Double { @_common.mean(s.data) }

pub fn finance_time_copula_layer_scale(s : FinancetimecopulaLayer, f : Double) -> FinancetimecopulaLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_time_copula_layer_add(a : FinancetimecopulaLayer, b : FinancetimecopulaLayer) -> FinancetimecopulaLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_time_copula_layer_copy(s : FinancetimecopulaLayer) -> FinancetimecopulaLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_time_copula_layer_fill(s : FinancetimecopulaLayer, v : Double) -> FinancetimecopulaLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_time_copula_layer_min(s : FinancetimecopulaLayer) -> Double { @_common.min(s.data) }

pub fn finance_time_copula_layer_max(s : FinancetimecopulaLayer) -> Double { @_common.max(s.data) }

pub fn finance_time_copula_layer_to_string(s : FinancetimecopulaLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinancetimecopulaBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_time_copula_buffer_make(size : Int) -> FinancetimecopulaBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_time_copula_buffer_len(s : FinancetimecopulaBuffer) -> Int { s.size }

pub fn finance_time_copula_buffer_get(s : FinancetimecopulaBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_time_copula_buffer_set(s : FinancetimecopulaBuffer, i : Int, v : Double) -> FinancetimecopulaBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_time_copula_buffer_sum(s : FinancetimecopulaBuffer) -> Double { @_common.sum(s.data) }

pub fn finance_time_copula_buffer_mean(s : FinancetimecopulaBuffer) -> Double { @_common.mean(s.data) }

pub fn finance_time_copula_buffer_scale(s : FinancetimecopulaBuffer, f : Double) -> FinancetimecopulaBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_time_copula_buffer_add(a : FinancetimecopulaBuffer, b : FinancetimecopulaBuffer) -> FinancetimecopulaBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_time_copula_buffer_copy(s : FinancetimecopulaBuffer) -> FinancetimecopulaBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_time_copula_buffer_fill(s : FinancetimecopulaBuffer, v : Double) -> FinancetimecopulaBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_time_copula_buffer_min(s : FinancetimecopulaBuffer) -> Double { @_common.min(s.data) }

pub fn finance_time_copula_buffer_max(s : FinancetimecopulaBuffer) -> Double { @_common.max(s.data) }

pub fn finance_time_copula_buffer_to_string(s : FinancetimecopulaBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinancetimecopulaCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_time_copula_cursor_make(size : Int) -> FinancetimecopulaCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_time_copula_cursor_len(s : FinancetimecopulaCursor) -> Int { s.size }

pub fn finance_time_copula_cursor_get(s : FinancetimecopulaCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_time_copula_cursor_set(s : FinancetimecopulaCursor, i : Int, v : Double) -> FinancetimecopulaCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_time_copula_cursor_sum(s : FinancetimecopulaCursor) -> Double { @_common.sum(s.data) }

pub fn finance_time_copula_cursor_mean(s : FinancetimecopulaCursor) -> Double { @_common.mean(s.data) }

pub fn finance_time_copula_cursor_scale(s : FinancetimecopulaCursor, f : Double) -> FinancetimecopulaCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_time_copula_cursor_add(a : FinancetimecopulaCursor, b : FinancetimecopulaCursor) -> FinancetimecopulaCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_time_copula_cursor_copy(s : FinancetimecopulaCursor) -> FinancetimecopulaCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_time_copula_cursor_fill(s : FinancetimecopulaCursor, v : Double) -> FinancetimecopulaCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_time_copula_cursor_min(s : FinancetimecopulaCursor) -> Double { @_common.min(s.data) }

pub fn finance_time_copula_cursor_max(s : FinancetimecopulaCursor) -> Double { @_common.max(s.data) }

pub fn finance_time_copula_cursor_to_string(s : FinancetimecopulaCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinancetimecopulaView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_time_copula_view_make(size : Int) -> FinancetimecopulaView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_time_copula_view_len(s : FinancetimecopulaView) -> Int { s.size }

pub fn finance_time_copula_view_get(s : FinancetimecopulaView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_time_copula_view_set(s : FinancetimecopulaView, i : Int, v : Double) -> FinancetimecopulaView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_time_copula_view_sum(s : FinancetimecopulaView) -> Double { @_common.sum(s.data) }

pub fn finance_time_copula_view_mean(s : FinancetimecopulaView) -> Double { @_common.mean(s.data) }

pub fn finance_time_copula_view_scale(s : FinancetimecopulaView, f : Double) -> FinancetimecopulaView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_time_copula_view_add(a : FinancetimecopulaView, b : FinancetimecopulaView) -> FinancetimecopulaView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_time_copula_view_copy(s : FinancetimecopulaView) -> FinancetimecopulaView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_time_copula_view_fill(s : FinancetimecopulaView, v : Double) -> FinancetimecopulaView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_time_copula_view_min(s : FinancetimecopulaView) -> Double { @_common.min(s.data) }

pub fn finance_time_copula_view_max(s : FinancetimecopulaView) -> Double { @_common.max(s.data) }

pub fn finance_time_copula_view_to_string(s : FinancetimecopulaView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinancetimecopulaRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_time_copula_range_make(size : Int) -> FinancetimecopulaRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_time_copula_range_len(s : FinancetimecopulaRange) -> Int { s.size }

pub fn finance_time_copula_range_get(s : FinancetimecopulaRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_time_copula_range_set(s : FinancetimecopulaRange, i : Int, v : Double) -> FinancetimecopulaRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_time_copula_range_sum(s : FinancetimecopulaRange) -> Double { @_common.sum(s.data) }

pub fn finance_time_copula_range_mean(s : FinancetimecopulaRange) -> Double { @_common.mean(s.data) }

pub fn finance_time_copula_range_scale(s : FinancetimecopulaRange, f : Double) -> FinancetimecopulaRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_time_copula_range_add(a : FinancetimecopulaRange, b : FinancetimecopulaRange) -> FinancetimecopulaRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_time_copula_range_copy(s : FinancetimecopulaRange) -> FinancetimecopulaRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_time_copula_range_fill(s : FinancetimecopulaRange, v : Double) -> FinancetimecopulaRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_time_copula_range_min(s : FinancetimecopulaRange) -> Double { @_common.min(s.data) }

pub fn finance_time_copula_range_max(s : FinancetimecopulaRange) -> Double { @_common.max(s.data) }

pub fn finance_time_copula_range_to_string(s : FinancetimecopulaRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinancetimecopulaSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_time_copula_slice_make(size : Int) -> FinancetimecopulaSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_time_copula_slice_len(s : FinancetimecopulaSlice) -> Int { s.size }

pub fn finance_time_copula_slice_get(s : FinancetimecopulaSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_time_copula_slice_set(s : FinancetimecopulaSlice, i : Int, v : Double) -> FinancetimecopulaSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn finance_time_copula_slice_sum(s : FinancetimecopulaSlice) -> Double { @_common.sum(s.data) }

pub fn finance_time_copula_slice_mean(s : FinancetimecopulaSlice) -> Double { @_common.mean(s.data) }

pub fn finance_time_copula_slice_scale(s : FinancetimecopulaSlice, f : Double) -> FinancetimecopulaSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn finance_time_copula_slice_add(a : FinancetimecopulaSlice, b : FinancetimecopulaSlice) -> FinancetimecopulaSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn finance_time_copula_slice_copy(s : FinancetimecopulaSlice) -> FinancetimecopulaSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn finance_time_copula_slice_fill(s : FinancetimecopulaSlice, v : Double) -> FinancetimecopulaSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn finance_time_copula_slice_min(s : FinancetimecopulaSlice) -> Double { @_common.min(s.data) }

pub fn finance_time_copula_slice_max(s : FinancetimecopulaSlice) -> Double { @_common.max(s.data) }

pub fn finance_time_copula_slice_to_string(s : FinancetimecopulaSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

