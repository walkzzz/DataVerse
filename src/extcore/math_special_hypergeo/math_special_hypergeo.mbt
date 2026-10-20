///===
/// extcore/math_special_hypergeo

pub(all) struct MathspecialhypergeoPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn math_special_hypergeo_make_point(x : Double, y : Double) -> MathspecialhypergeoPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn math_special_hypergeo_make_point3(x : Double, y : Double, z : Double) -> MathspecialhypergeoPoint {
  { x, y, z, label: 0 }
}

pub fn MathspecialhypergeoPoint::x(self : MathspecialhypergeoPoint) -> Double { self.x }

pub fn MathspecialhypergeoPoint::y(self : MathspecialhypergeoPoint) -> Double { self.y }

pub fn MathspecialhypergeoPoint::z(self : MathspecialhypergeoPoint) -> Double { self.z }

pub fn MathspecialhypergeoPoint::label(self : MathspecialhypergeoPoint) -> Int { self.label }

pub fn MathspecialhypergeoPoint::dist(self : MathspecialhypergeoPoint, other : MathspecialhypergeoPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn MathspecialhypergeoPoint::add(self : MathspecialhypergeoPoint, other : MathspecialhypergeoPoint) -> MathspecialhypergeoPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn MathspecialhypergeoPoint::sub(self : MathspecialhypergeoPoint, other : MathspecialhypergeoPoint) -> MathspecialhypergeoPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn MathspecialhypergeoPoint::scale(self : MathspecialhypergeoPoint, s : Double) -> MathspecialhypergeoPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn MathspecialhypergeoPoint::dot(self : MathspecialhypergeoPoint, other : MathspecialhypergeoPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn MathspecialhypergeoPoint::cross(self : MathspecialhypergeoPoint, other : MathspecialhypergeoPoint) -> MathspecialhypergeoPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn MathspecialhypergeoPoint::norm(self : MathspecialhypergeoPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn MathspecialhypergeoPoint::normalize(self : MathspecialhypergeoPoint) -> MathspecialhypergeoPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn MathspecialhypergeoPoint::negate(self : MathspecialhypergeoPoint) -> MathspecialhypergeoPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn MathspecialhypergeoPoint::mid(self : MathspecialhypergeoPoint, other : MathspecialhypergeoPoint) -> MathspecialhypergeoPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn MathspecialhypergeoPoint::lerp(self : MathspecialhypergeoPoint, other : MathspecialhypergeoPoint, t : Double) -> MathspecialhypergeoPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn MathspecialhypergeoPoint::to_string(self : MathspecialhypergeoPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct MathspecialhypergeoSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn math_special_hypergeo_make_series(vals : Array[Double], name : String) -> MathspecialhypergeoSeries {
  { vals, name, meta: 0 }
}

pub fn MathspecialhypergeoSeries::len(self : MathspecialhypergeoSeries) -> Int { self.vals.length() }

pub fn MathspecialhypergeoSeries::sum(self : MathspecialhypergeoSeries) -> Double { @_common.sum(self.vals) }

pub fn MathspecialhypergeoSeries::mean(self : MathspecialhypergeoSeries) -> Double { @_common.mean(self.vals) }

pub fn MathspecialhypergeoSeries::min(self : MathspecialhypergeoSeries) -> Double { @_common.min(self.vals) }

pub fn MathspecialhypergeoSeries::max(self : MathspecialhypergeoSeries) -> Double { @_common.max(self.vals) }

pub fn MathspecialhypergeoSeries::range(self : MathspecialhypergeoSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn MathspecialhypergeoSeries::variance(self : MathspecialhypergeoSeries) -> Double { @_common.variance(self.vals) }

pub fn MathspecialhypergeoSeries::std(self : MathspecialhypergeoSeries) -> Double { @_common.std(self.vals) }

pub fn MathspecialhypergeoSeries::median(self : MathspecialhypergeoSeries) -> Double { @_common.median(self.vals) }

pub fn MathspecialhypergeoSeries::scale(self : MathspecialhypergeoSeries, f : Double) -> MathspecialhypergeoSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn MathspecialhypergeoSeries::add(self : MathspecialhypergeoSeries, other : MathspecialhypergeoSeries) -> MathspecialhypergeoSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn MathspecialhypergeoSeries::sub(self : MathspecialhypergeoSeries, other : MathspecialhypergeoSeries) -> MathspecialhypergeoSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn MathspecialhypergeoSeries::normalize(self : MathspecialhypergeoSeries) -> MathspecialhypergeoSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn MathspecialhypergeoSeries::cumsum(self : MathspecialhypergeoSeries) -> MathspecialhypergeoSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn MathspecialhypergeoSeries::to_string(self : MathspecialhypergeoSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct MathspecialhypergeoMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn math_special_hypergeo_make_matrix(rows : Int, cols : Int, val : Double) -> MathspecialhypergeoMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn math_special_hypergeo_matrix_identity(n : Int) -> MathspecialhypergeoMatrix {
  let m = math_special_hypergeo_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn MathspecialhypergeoMatrix::get(self : MathspecialhypergeoMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn MathspecialhypergeoMatrix::transpose(self : MathspecialhypergeoMatrix) -> MathspecialhypergeoMatrix {
  let result = math_special_hypergeo_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn MathspecialhypergeoMatrix::add(self : MathspecialhypergeoMatrix, other : MathspecialhypergeoMatrix) -> MathspecialhypergeoMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = math_special_hypergeo_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn MathspecialhypergeoMatrix::scale(self : MathspecialhypergeoMatrix, s : Double) -> MathspecialhypergeoMatrix {
  let result = math_special_hypergeo_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn MathspecialhypergeoMatrix::multiply(self : MathspecialhypergeoMatrix, other : MathspecialhypergeoMatrix) -> MathspecialhypergeoMatrix {
  if self.cols != other.rows { return math_special_hypergeo_make_matrix(self.rows, other.cols, 0.0) }
  let result = math_special_hypergeo_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn MathspecialhypergeoMatrix::trace(self : MathspecialhypergeoMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn MathspecialhypergeoMatrix::det(self : MathspecialhypergeoMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn MathspecialhypergeoMatrix::norm(self : MathspecialhypergeoMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn MathspecialhypergeoMatrix::to_string(self : MathspecialhypergeoMatrix) -> String {
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

pub(all) struct MathspecialhypergeoVector {
  comps : Array[Double]
  dim : Int
}

pub fn math_special_hypergeo_make_vector(comps : Array[Double]) -> MathspecialhypergeoVector {
  { comps, dim: comps.length() }
}

pub fn math_special_hypergeo_vector_zero(dim : Int) -> MathspecialhypergeoVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn MathspecialhypergeoVector::add(self : MathspecialhypergeoVector, other : MathspecialhypergeoVector) -> MathspecialhypergeoVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn MathspecialhypergeoVector::sub(self : MathspecialhypergeoVector, other : MathspecialhypergeoVector) -> MathspecialhypergeoVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn MathspecialhypergeoVector::scale(self : MathspecialhypergeoVector, s : Double) -> MathspecialhypergeoVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn MathspecialhypergeoVector::dot(self : MathspecialhypergeoVector, other : MathspecialhypergeoVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn MathspecialhypergeoVector::norm(self : MathspecialhypergeoVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn MathspecialhypergeoVector::normalize(self : MathspecialhypergeoVector) -> MathspecialhypergeoVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn MathspecialhypergeoVector::dist(self : MathspecialhypergeoVector, other : MathspecialhypergeoVector) -> Double {
  self.sub(other).norm()
}

pub fn MathspecialhypergeoVector::to_string(self : MathspecialhypergeoVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn math_special_hypergeo_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn math_special_hypergeo_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn math_special_hypergeo_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn math_special_hypergeo_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn math_special_hypergeo_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn math_special_hypergeo_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn math_special_hypergeo_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn math_special_hypergeo_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn math_special_hypergeo_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn math_special_hypergeo_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn math_special_hypergeo_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn math_special_hypergeo_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn math_special_hypergeo_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn math_special_hypergeo_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn math_special_hypergeo_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn math_special_hypergeo_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn math_special_hypergeo_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn math_special_hypergeo_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn math_special_hypergeo_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn math_special_hypergeo_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn math_special_hypergeo_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn math_special_hypergeo_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn math_special_hypergeo_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn math_special_hypergeo_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn math_special_hypergeo_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn math_special_hypergeo_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn math_special_hypergeo_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn math_special_hypergeo_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn math_special_hypergeo_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct MathspecialhypergeoFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_special_hypergeo_frame_make(size : Int) -> MathspecialhypergeoFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_special_hypergeo_frame_len(s : MathspecialhypergeoFrame) -> Int { s.size }

pub fn math_special_hypergeo_frame_get(s : MathspecialhypergeoFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_special_hypergeo_frame_set(s : MathspecialhypergeoFrame, i : Int, v : Double) -> MathspecialhypergeoFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_special_hypergeo_frame_sum(s : MathspecialhypergeoFrame) -> Double { @_common.sum(s.data) }

pub fn math_special_hypergeo_frame_mean(s : MathspecialhypergeoFrame) -> Double { @_common.mean(s.data) }

pub fn math_special_hypergeo_frame_scale(s : MathspecialhypergeoFrame, f : Double) -> MathspecialhypergeoFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_special_hypergeo_frame_add(a : MathspecialhypergeoFrame, b : MathspecialhypergeoFrame) -> MathspecialhypergeoFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_special_hypergeo_frame_copy(s : MathspecialhypergeoFrame) -> MathspecialhypergeoFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_special_hypergeo_frame_fill(s : MathspecialhypergeoFrame, v : Double) -> MathspecialhypergeoFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_special_hypergeo_frame_min(s : MathspecialhypergeoFrame) -> Double { @_common.min(s.data) }

pub fn math_special_hypergeo_frame_max(s : MathspecialhypergeoFrame) -> Double { @_common.max(s.data) }

pub fn math_special_hypergeo_frame_to_string(s : MathspecialhypergeoFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathspecialhypergeoTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_special_hypergeo_table_make(size : Int) -> MathspecialhypergeoTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_special_hypergeo_table_len(s : MathspecialhypergeoTable) -> Int { s.size }

pub fn math_special_hypergeo_table_get(s : MathspecialhypergeoTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_special_hypergeo_table_set(s : MathspecialhypergeoTable, i : Int, v : Double) -> MathspecialhypergeoTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_special_hypergeo_table_sum(s : MathspecialhypergeoTable) -> Double { @_common.sum(s.data) }

pub fn math_special_hypergeo_table_mean(s : MathspecialhypergeoTable) -> Double { @_common.mean(s.data) }

pub fn math_special_hypergeo_table_scale(s : MathspecialhypergeoTable, f : Double) -> MathspecialhypergeoTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_special_hypergeo_table_add(a : MathspecialhypergeoTable, b : MathspecialhypergeoTable) -> MathspecialhypergeoTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_special_hypergeo_table_copy(s : MathspecialhypergeoTable) -> MathspecialhypergeoTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_special_hypergeo_table_fill(s : MathspecialhypergeoTable, v : Double) -> MathspecialhypergeoTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_special_hypergeo_table_min(s : MathspecialhypergeoTable) -> Double { @_common.min(s.data) }

pub fn math_special_hypergeo_table_max(s : MathspecialhypergeoTable) -> Double { @_common.max(s.data) }

pub fn math_special_hypergeo_table_to_string(s : MathspecialhypergeoTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathspecialhypergeoGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_special_hypergeo_graphn_make(size : Int) -> MathspecialhypergeoGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_special_hypergeo_graphn_len(s : MathspecialhypergeoGraphN) -> Int { s.size }

pub fn math_special_hypergeo_graphn_get(s : MathspecialhypergeoGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_special_hypergeo_graphn_set(s : MathspecialhypergeoGraphN, i : Int, v : Double) -> MathspecialhypergeoGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_special_hypergeo_graphn_sum(s : MathspecialhypergeoGraphN) -> Double { @_common.sum(s.data) }

pub fn math_special_hypergeo_graphn_mean(s : MathspecialhypergeoGraphN) -> Double { @_common.mean(s.data) }

pub fn math_special_hypergeo_graphn_scale(s : MathspecialhypergeoGraphN, f : Double) -> MathspecialhypergeoGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_special_hypergeo_graphn_add(a : MathspecialhypergeoGraphN, b : MathspecialhypergeoGraphN) -> MathspecialhypergeoGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_special_hypergeo_graphn_copy(s : MathspecialhypergeoGraphN) -> MathspecialhypergeoGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_special_hypergeo_graphn_fill(s : MathspecialhypergeoGraphN, v : Double) -> MathspecialhypergeoGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_special_hypergeo_graphn_min(s : MathspecialhypergeoGraphN) -> Double { @_common.min(s.data) }

pub fn math_special_hypergeo_graphn_max(s : MathspecialhypergeoGraphN) -> Double { @_common.max(s.data) }

pub fn math_special_hypergeo_graphn_to_string(s : MathspecialhypergeoGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathspecialhypergeoNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_special_hypergeo_node_make(size : Int) -> MathspecialhypergeoNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_special_hypergeo_node_len(s : MathspecialhypergeoNode) -> Int { s.size }

pub fn math_special_hypergeo_node_get(s : MathspecialhypergeoNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_special_hypergeo_node_set(s : MathspecialhypergeoNode, i : Int, v : Double) -> MathspecialhypergeoNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_special_hypergeo_node_sum(s : MathspecialhypergeoNode) -> Double { @_common.sum(s.data) }

pub fn math_special_hypergeo_node_mean(s : MathspecialhypergeoNode) -> Double { @_common.mean(s.data) }

pub fn math_special_hypergeo_node_scale(s : MathspecialhypergeoNode, f : Double) -> MathspecialhypergeoNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_special_hypergeo_node_add(a : MathspecialhypergeoNode, b : MathspecialhypergeoNode) -> MathspecialhypergeoNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_special_hypergeo_node_copy(s : MathspecialhypergeoNode) -> MathspecialhypergeoNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_special_hypergeo_node_fill(s : MathspecialhypergeoNode, v : Double) -> MathspecialhypergeoNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_special_hypergeo_node_min(s : MathspecialhypergeoNode) -> Double { @_common.min(s.data) }

pub fn math_special_hypergeo_node_max(s : MathspecialhypergeoNode) -> Double { @_common.max(s.data) }

pub fn math_special_hypergeo_node_to_string(s : MathspecialhypergeoNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathspecialhypergeoEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_special_hypergeo_edge_make(size : Int) -> MathspecialhypergeoEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_special_hypergeo_edge_len(s : MathspecialhypergeoEdge) -> Int { s.size }

pub fn math_special_hypergeo_edge_get(s : MathspecialhypergeoEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_special_hypergeo_edge_set(s : MathspecialhypergeoEdge, i : Int, v : Double) -> MathspecialhypergeoEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_special_hypergeo_edge_sum(s : MathspecialhypergeoEdge) -> Double { @_common.sum(s.data) }

pub fn math_special_hypergeo_edge_mean(s : MathspecialhypergeoEdge) -> Double { @_common.mean(s.data) }

pub fn math_special_hypergeo_edge_scale(s : MathspecialhypergeoEdge, f : Double) -> MathspecialhypergeoEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_special_hypergeo_edge_add(a : MathspecialhypergeoEdge, b : MathspecialhypergeoEdge) -> MathspecialhypergeoEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_special_hypergeo_edge_copy(s : MathspecialhypergeoEdge) -> MathspecialhypergeoEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_special_hypergeo_edge_fill(s : MathspecialhypergeoEdge, v : Double) -> MathspecialhypergeoEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_special_hypergeo_edge_min(s : MathspecialhypergeoEdge) -> Double { @_common.min(s.data) }

pub fn math_special_hypergeo_edge_max(s : MathspecialhypergeoEdge) -> Double { @_common.max(s.data) }

pub fn math_special_hypergeo_edge_to_string(s : MathspecialhypergeoEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathspecialhypergeoPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_special_hypergeo_path_make(size : Int) -> MathspecialhypergeoPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_special_hypergeo_path_len(s : MathspecialhypergeoPath) -> Int { s.size }

pub fn math_special_hypergeo_path_get(s : MathspecialhypergeoPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_special_hypergeo_path_set(s : MathspecialhypergeoPath, i : Int, v : Double) -> MathspecialhypergeoPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_special_hypergeo_path_sum(s : MathspecialhypergeoPath) -> Double { @_common.sum(s.data) }

pub fn math_special_hypergeo_path_mean(s : MathspecialhypergeoPath) -> Double { @_common.mean(s.data) }

pub fn math_special_hypergeo_path_scale(s : MathspecialhypergeoPath, f : Double) -> MathspecialhypergeoPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_special_hypergeo_path_add(a : MathspecialhypergeoPath, b : MathspecialhypergeoPath) -> MathspecialhypergeoPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_special_hypergeo_path_copy(s : MathspecialhypergeoPath) -> MathspecialhypergeoPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_special_hypergeo_path_fill(s : MathspecialhypergeoPath, v : Double) -> MathspecialhypergeoPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_special_hypergeo_path_min(s : MathspecialhypergeoPath) -> Double { @_common.min(s.data) }

pub fn math_special_hypergeo_path_max(s : MathspecialhypergeoPath) -> Double { @_common.max(s.data) }

pub fn math_special_hypergeo_path_to_string(s : MathspecialhypergeoPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathspecialhypergeoCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_special_hypergeo_cluster_make(size : Int) -> MathspecialhypergeoCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_special_hypergeo_cluster_len(s : MathspecialhypergeoCluster) -> Int { s.size }

pub fn math_special_hypergeo_cluster_get(s : MathspecialhypergeoCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_special_hypergeo_cluster_set(s : MathspecialhypergeoCluster, i : Int, v : Double) -> MathspecialhypergeoCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_special_hypergeo_cluster_sum(s : MathspecialhypergeoCluster) -> Double { @_common.sum(s.data) }

pub fn math_special_hypergeo_cluster_mean(s : MathspecialhypergeoCluster) -> Double { @_common.mean(s.data) }

pub fn math_special_hypergeo_cluster_scale(s : MathspecialhypergeoCluster, f : Double) -> MathspecialhypergeoCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_special_hypergeo_cluster_add(a : MathspecialhypergeoCluster, b : MathspecialhypergeoCluster) -> MathspecialhypergeoCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_special_hypergeo_cluster_copy(s : MathspecialhypergeoCluster) -> MathspecialhypergeoCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_special_hypergeo_cluster_fill(s : MathspecialhypergeoCluster, v : Double) -> MathspecialhypergeoCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_special_hypergeo_cluster_min(s : MathspecialhypergeoCluster) -> Double { @_common.min(s.data) }

pub fn math_special_hypergeo_cluster_max(s : MathspecialhypergeoCluster) -> Double { @_common.max(s.data) }

pub fn math_special_hypergeo_cluster_to_string(s : MathspecialhypergeoCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathspecialhypergeoModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_special_hypergeo_model_make(size : Int) -> MathspecialhypergeoModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_special_hypergeo_model_len(s : MathspecialhypergeoModel) -> Int { s.size }

pub fn math_special_hypergeo_model_get(s : MathspecialhypergeoModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_special_hypergeo_model_set(s : MathspecialhypergeoModel, i : Int, v : Double) -> MathspecialhypergeoModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_special_hypergeo_model_sum(s : MathspecialhypergeoModel) -> Double { @_common.sum(s.data) }

pub fn math_special_hypergeo_model_mean(s : MathspecialhypergeoModel) -> Double { @_common.mean(s.data) }

pub fn math_special_hypergeo_model_scale(s : MathspecialhypergeoModel, f : Double) -> MathspecialhypergeoModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_special_hypergeo_model_add(a : MathspecialhypergeoModel, b : MathspecialhypergeoModel) -> MathspecialhypergeoModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_special_hypergeo_model_copy(s : MathspecialhypergeoModel) -> MathspecialhypergeoModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_special_hypergeo_model_fill(s : MathspecialhypergeoModel, v : Double) -> MathspecialhypergeoModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_special_hypergeo_model_min(s : MathspecialhypergeoModel) -> Double { @_common.min(s.data) }

pub fn math_special_hypergeo_model_max(s : MathspecialhypergeoModel) -> Double { @_common.max(s.data) }

pub fn math_special_hypergeo_model_to_string(s : MathspecialhypergeoModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathspecialhypergeoLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_special_hypergeo_layer_make(size : Int) -> MathspecialhypergeoLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_special_hypergeo_layer_len(s : MathspecialhypergeoLayer) -> Int { s.size }

pub fn math_special_hypergeo_layer_get(s : MathspecialhypergeoLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_special_hypergeo_layer_set(s : MathspecialhypergeoLayer, i : Int, v : Double) -> MathspecialhypergeoLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_special_hypergeo_layer_sum(s : MathspecialhypergeoLayer) -> Double { @_common.sum(s.data) }

pub fn math_special_hypergeo_layer_mean(s : MathspecialhypergeoLayer) -> Double { @_common.mean(s.data) }

pub fn math_special_hypergeo_layer_scale(s : MathspecialhypergeoLayer, f : Double) -> MathspecialhypergeoLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_special_hypergeo_layer_add(a : MathspecialhypergeoLayer, b : MathspecialhypergeoLayer) -> MathspecialhypergeoLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_special_hypergeo_layer_copy(s : MathspecialhypergeoLayer) -> MathspecialhypergeoLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_special_hypergeo_layer_fill(s : MathspecialhypergeoLayer, v : Double) -> MathspecialhypergeoLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_special_hypergeo_layer_min(s : MathspecialhypergeoLayer) -> Double { @_common.min(s.data) }

pub fn math_special_hypergeo_layer_max(s : MathspecialhypergeoLayer) -> Double { @_common.max(s.data) }

pub fn math_special_hypergeo_layer_to_string(s : MathspecialhypergeoLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathspecialhypergeoBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_special_hypergeo_buffer_make(size : Int) -> MathspecialhypergeoBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_special_hypergeo_buffer_len(s : MathspecialhypergeoBuffer) -> Int { s.size }

pub fn math_special_hypergeo_buffer_get(s : MathspecialhypergeoBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_special_hypergeo_buffer_set(s : MathspecialhypergeoBuffer, i : Int, v : Double) -> MathspecialhypergeoBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_special_hypergeo_buffer_sum(s : MathspecialhypergeoBuffer) -> Double { @_common.sum(s.data) }

pub fn math_special_hypergeo_buffer_mean(s : MathspecialhypergeoBuffer) -> Double { @_common.mean(s.data) }

pub fn math_special_hypergeo_buffer_scale(s : MathspecialhypergeoBuffer, f : Double) -> MathspecialhypergeoBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_special_hypergeo_buffer_add(a : MathspecialhypergeoBuffer, b : MathspecialhypergeoBuffer) -> MathspecialhypergeoBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_special_hypergeo_buffer_copy(s : MathspecialhypergeoBuffer) -> MathspecialhypergeoBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_special_hypergeo_buffer_fill(s : MathspecialhypergeoBuffer, v : Double) -> MathspecialhypergeoBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_special_hypergeo_buffer_min(s : MathspecialhypergeoBuffer) -> Double { @_common.min(s.data) }

pub fn math_special_hypergeo_buffer_max(s : MathspecialhypergeoBuffer) -> Double { @_common.max(s.data) }

pub fn math_special_hypergeo_buffer_to_string(s : MathspecialhypergeoBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathspecialhypergeoCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_special_hypergeo_cursor_make(size : Int) -> MathspecialhypergeoCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_special_hypergeo_cursor_len(s : MathspecialhypergeoCursor) -> Int { s.size }

pub fn math_special_hypergeo_cursor_get(s : MathspecialhypergeoCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_special_hypergeo_cursor_set(s : MathspecialhypergeoCursor, i : Int, v : Double) -> MathspecialhypergeoCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_special_hypergeo_cursor_sum(s : MathspecialhypergeoCursor) -> Double { @_common.sum(s.data) }

pub fn math_special_hypergeo_cursor_mean(s : MathspecialhypergeoCursor) -> Double { @_common.mean(s.data) }

pub fn math_special_hypergeo_cursor_scale(s : MathspecialhypergeoCursor, f : Double) -> MathspecialhypergeoCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_special_hypergeo_cursor_add(a : MathspecialhypergeoCursor, b : MathspecialhypergeoCursor) -> MathspecialhypergeoCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_special_hypergeo_cursor_copy(s : MathspecialhypergeoCursor) -> MathspecialhypergeoCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_special_hypergeo_cursor_fill(s : MathspecialhypergeoCursor, v : Double) -> MathspecialhypergeoCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_special_hypergeo_cursor_min(s : MathspecialhypergeoCursor) -> Double { @_common.min(s.data) }

pub fn math_special_hypergeo_cursor_max(s : MathspecialhypergeoCursor) -> Double { @_common.max(s.data) }

pub fn math_special_hypergeo_cursor_to_string(s : MathspecialhypergeoCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathspecialhypergeoView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_special_hypergeo_view_make(size : Int) -> MathspecialhypergeoView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_special_hypergeo_view_len(s : MathspecialhypergeoView) -> Int { s.size }

pub fn math_special_hypergeo_view_get(s : MathspecialhypergeoView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_special_hypergeo_view_set(s : MathspecialhypergeoView, i : Int, v : Double) -> MathspecialhypergeoView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_special_hypergeo_view_sum(s : MathspecialhypergeoView) -> Double { @_common.sum(s.data) }

pub fn math_special_hypergeo_view_mean(s : MathspecialhypergeoView) -> Double { @_common.mean(s.data) }

pub fn math_special_hypergeo_view_scale(s : MathspecialhypergeoView, f : Double) -> MathspecialhypergeoView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_special_hypergeo_view_add(a : MathspecialhypergeoView, b : MathspecialhypergeoView) -> MathspecialhypergeoView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_special_hypergeo_view_copy(s : MathspecialhypergeoView) -> MathspecialhypergeoView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_special_hypergeo_view_fill(s : MathspecialhypergeoView, v : Double) -> MathspecialhypergeoView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_special_hypergeo_view_min(s : MathspecialhypergeoView) -> Double { @_common.min(s.data) }

pub fn math_special_hypergeo_view_max(s : MathspecialhypergeoView) -> Double { @_common.max(s.data) }

pub fn math_special_hypergeo_view_to_string(s : MathspecialhypergeoView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathspecialhypergeoRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_special_hypergeo_range_make(size : Int) -> MathspecialhypergeoRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_special_hypergeo_range_len(s : MathspecialhypergeoRange) -> Int { s.size }

pub fn math_special_hypergeo_range_get(s : MathspecialhypergeoRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_special_hypergeo_range_set(s : MathspecialhypergeoRange, i : Int, v : Double) -> MathspecialhypergeoRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_special_hypergeo_range_sum(s : MathspecialhypergeoRange) -> Double { @_common.sum(s.data) }

pub fn math_special_hypergeo_range_mean(s : MathspecialhypergeoRange) -> Double { @_common.mean(s.data) }

pub fn math_special_hypergeo_range_scale(s : MathspecialhypergeoRange, f : Double) -> MathspecialhypergeoRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_special_hypergeo_range_add(a : MathspecialhypergeoRange, b : MathspecialhypergeoRange) -> MathspecialhypergeoRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_special_hypergeo_range_copy(s : MathspecialhypergeoRange) -> MathspecialhypergeoRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_special_hypergeo_range_fill(s : MathspecialhypergeoRange, v : Double) -> MathspecialhypergeoRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_special_hypergeo_range_min(s : MathspecialhypergeoRange) -> Double { @_common.min(s.data) }

pub fn math_special_hypergeo_range_max(s : MathspecialhypergeoRange) -> Double { @_common.max(s.data) }

pub fn math_special_hypergeo_range_to_string(s : MathspecialhypergeoRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathspecialhypergeoSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_special_hypergeo_slice_make(size : Int) -> MathspecialhypergeoSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_special_hypergeo_slice_len(s : MathspecialhypergeoSlice) -> Int { s.size }

pub fn math_special_hypergeo_slice_get(s : MathspecialhypergeoSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_special_hypergeo_slice_set(s : MathspecialhypergeoSlice, i : Int, v : Double) -> MathspecialhypergeoSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_special_hypergeo_slice_sum(s : MathspecialhypergeoSlice) -> Double { @_common.sum(s.data) }

pub fn math_special_hypergeo_slice_mean(s : MathspecialhypergeoSlice) -> Double { @_common.mean(s.data) }

pub fn math_special_hypergeo_slice_scale(s : MathspecialhypergeoSlice, f : Double) -> MathspecialhypergeoSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_special_hypergeo_slice_add(a : MathspecialhypergeoSlice, b : MathspecialhypergeoSlice) -> MathspecialhypergeoSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_special_hypergeo_slice_copy(s : MathspecialhypergeoSlice) -> MathspecialhypergeoSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_special_hypergeo_slice_fill(s : MathspecialhypergeoSlice, v : Double) -> MathspecialhypergeoSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_special_hypergeo_slice_min(s : MathspecialhypergeoSlice) -> Double { @_common.min(s.data) }

pub fn math_special_hypergeo_slice_max(s : MathspecialhypergeoSlice) -> Double { @_common.max(s.data) }

pub fn math_special_hypergeo_slice_to_string(s : MathspecialhypergeoSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

