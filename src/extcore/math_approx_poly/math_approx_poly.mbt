///===
/// extcore/math_approx_poly

pub(all) struct MathapproxpolyPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn math_approx_poly_make_point(x : Double, y : Double) -> MathapproxpolyPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn math_approx_poly_make_point3(x : Double, y : Double, z : Double) -> MathapproxpolyPoint {
  { x, y, z, label: 0 }
}

pub fn MathapproxpolyPoint::x(self : MathapproxpolyPoint) -> Double { self.x }

pub fn MathapproxpolyPoint::y(self : MathapproxpolyPoint) -> Double { self.y }

pub fn MathapproxpolyPoint::z(self : MathapproxpolyPoint) -> Double { self.z }

pub fn MathapproxpolyPoint::label(self : MathapproxpolyPoint) -> Int { self.label }

pub fn MathapproxpolyPoint::dist(self : MathapproxpolyPoint, other : MathapproxpolyPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn MathapproxpolyPoint::add(self : MathapproxpolyPoint, other : MathapproxpolyPoint) -> MathapproxpolyPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn MathapproxpolyPoint::sub(self : MathapproxpolyPoint, other : MathapproxpolyPoint) -> MathapproxpolyPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn MathapproxpolyPoint::scale(self : MathapproxpolyPoint, s : Double) -> MathapproxpolyPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn MathapproxpolyPoint::dot(self : MathapproxpolyPoint, other : MathapproxpolyPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn MathapproxpolyPoint::cross(self : MathapproxpolyPoint, other : MathapproxpolyPoint) -> MathapproxpolyPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn MathapproxpolyPoint::norm(self : MathapproxpolyPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn MathapproxpolyPoint::normalize(self : MathapproxpolyPoint) -> MathapproxpolyPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn MathapproxpolyPoint::negate(self : MathapproxpolyPoint) -> MathapproxpolyPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn MathapproxpolyPoint::mid(self : MathapproxpolyPoint, other : MathapproxpolyPoint) -> MathapproxpolyPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn MathapproxpolyPoint::lerp(self : MathapproxpolyPoint, other : MathapproxpolyPoint, t : Double) -> MathapproxpolyPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn MathapproxpolyPoint::to_string(self : MathapproxpolyPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct MathapproxpolySeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn math_approx_poly_make_series(vals : Array[Double], name : String) -> MathapproxpolySeries {
  { vals, name, meta: 0 }
}

pub fn MathapproxpolySeries::len(self : MathapproxpolySeries) -> Int { self.vals.length() }

pub fn MathapproxpolySeries::sum(self : MathapproxpolySeries) -> Double { @_common.sum(self.vals) }

pub fn MathapproxpolySeries::mean(self : MathapproxpolySeries) -> Double { @_common.mean(self.vals) }

pub fn MathapproxpolySeries::min(self : MathapproxpolySeries) -> Double { @_common.min(self.vals) }

pub fn MathapproxpolySeries::max(self : MathapproxpolySeries) -> Double { @_common.max(self.vals) }

pub fn MathapproxpolySeries::range(self : MathapproxpolySeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn MathapproxpolySeries::variance(self : MathapproxpolySeries) -> Double { @_common.variance(self.vals) }

pub fn MathapproxpolySeries::std(self : MathapproxpolySeries) -> Double { @_common.std(self.vals) }

pub fn MathapproxpolySeries::median(self : MathapproxpolySeries) -> Double { @_common.median(self.vals) }

pub fn MathapproxpolySeries::scale(self : MathapproxpolySeries, f : Double) -> MathapproxpolySeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn MathapproxpolySeries::add(self : MathapproxpolySeries, other : MathapproxpolySeries) -> MathapproxpolySeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn MathapproxpolySeries::sub(self : MathapproxpolySeries, other : MathapproxpolySeries) -> MathapproxpolySeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn MathapproxpolySeries::normalize(self : MathapproxpolySeries) -> MathapproxpolySeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn MathapproxpolySeries::cumsum(self : MathapproxpolySeries) -> MathapproxpolySeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn MathapproxpolySeries::to_string(self : MathapproxpolySeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct MathapproxpolyMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn math_approx_poly_make_matrix(rows : Int, cols : Int, val : Double) -> MathapproxpolyMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn math_approx_poly_matrix_identity(n : Int) -> MathapproxpolyMatrix {
  let m = math_approx_poly_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn MathapproxpolyMatrix::get(self : MathapproxpolyMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn MathapproxpolyMatrix::transpose(self : MathapproxpolyMatrix) -> MathapproxpolyMatrix {
  let result = math_approx_poly_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn MathapproxpolyMatrix::add(self : MathapproxpolyMatrix, other : MathapproxpolyMatrix) -> MathapproxpolyMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = math_approx_poly_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn MathapproxpolyMatrix::scale(self : MathapproxpolyMatrix, s : Double) -> MathapproxpolyMatrix {
  let result = math_approx_poly_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn MathapproxpolyMatrix::multiply(self : MathapproxpolyMatrix, other : MathapproxpolyMatrix) -> MathapproxpolyMatrix {
  if self.cols != other.rows { return math_approx_poly_make_matrix(self.rows, other.cols, 0.0) }
  let result = math_approx_poly_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn MathapproxpolyMatrix::trace(self : MathapproxpolyMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn MathapproxpolyMatrix::det(self : MathapproxpolyMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn MathapproxpolyMatrix::norm(self : MathapproxpolyMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn MathapproxpolyMatrix::to_string(self : MathapproxpolyMatrix) -> String {
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

pub(all) struct MathapproxpolyVector {
  comps : Array[Double]
  dim : Int
}

pub fn math_approx_poly_make_vector(comps : Array[Double]) -> MathapproxpolyVector {
  { comps, dim: comps.length() }
}

pub fn math_approx_poly_vector_zero(dim : Int) -> MathapproxpolyVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn MathapproxpolyVector::add(self : MathapproxpolyVector, other : MathapproxpolyVector) -> MathapproxpolyVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn MathapproxpolyVector::sub(self : MathapproxpolyVector, other : MathapproxpolyVector) -> MathapproxpolyVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn MathapproxpolyVector::scale(self : MathapproxpolyVector, s : Double) -> MathapproxpolyVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn MathapproxpolyVector::dot(self : MathapproxpolyVector, other : MathapproxpolyVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn MathapproxpolyVector::norm(self : MathapproxpolyVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn MathapproxpolyVector::normalize(self : MathapproxpolyVector) -> MathapproxpolyVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn MathapproxpolyVector::dist(self : MathapproxpolyVector, other : MathapproxpolyVector) -> Double {
  self.sub(other).norm()
}

pub fn MathapproxpolyVector::to_string(self : MathapproxpolyVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn math_approx_poly_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn math_approx_poly_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn math_approx_poly_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn math_approx_poly_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn math_approx_poly_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn math_approx_poly_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn math_approx_poly_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn math_approx_poly_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn math_approx_poly_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn math_approx_poly_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn math_approx_poly_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn math_approx_poly_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn math_approx_poly_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn math_approx_poly_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn math_approx_poly_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn math_approx_poly_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn math_approx_poly_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn math_approx_poly_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn math_approx_poly_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn math_approx_poly_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn math_approx_poly_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn math_approx_poly_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn math_approx_poly_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn math_approx_poly_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn math_approx_poly_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn math_approx_poly_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn math_approx_poly_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn math_approx_poly_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn math_approx_poly_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct MathapproxpolyFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_approx_poly_frame_make(size : Int) -> MathapproxpolyFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_approx_poly_frame_len(s : MathapproxpolyFrame) -> Int { s.size }

pub fn math_approx_poly_frame_get(s : MathapproxpolyFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_approx_poly_frame_set(s : MathapproxpolyFrame, i : Int, v : Double) -> MathapproxpolyFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_approx_poly_frame_sum(s : MathapproxpolyFrame) -> Double { @_common.sum(s.data) }

pub fn math_approx_poly_frame_mean(s : MathapproxpolyFrame) -> Double { @_common.mean(s.data) }

pub fn math_approx_poly_frame_scale(s : MathapproxpolyFrame, f : Double) -> MathapproxpolyFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_approx_poly_frame_add(a : MathapproxpolyFrame, b : MathapproxpolyFrame) -> MathapproxpolyFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_approx_poly_frame_copy(s : MathapproxpolyFrame) -> MathapproxpolyFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_approx_poly_frame_fill(s : MathapproxpolyFrame, v : Double) -> MathapproxpolyFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_approx_poly_frame_min(s : MathapproxpolyFrame) -> Double { @_common.min(s.data) }

pub fn math_approx_poly_frame_max(s : MathapproxpolyFrame) -> Double { @_common.max(s.data) }

pub fn math_approx_poly_frame_to_string(s : MathapproxpolyFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathapproxpolyTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_approx_poly_table_make(size : Int) -> MathapproxpolyTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_approx_poly_table_len(s : MathapproxpolyTable) -> Int { s.size }

pub fn math_approx_poly_table_get(s : MathapproxpolyTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_approx_poly_table_set(s : MathapproxpolyTable, i : Int, v : Double) -> MathapproxpolyTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_approx_poly_table_sum(s : MathapproxpolyTable) -> Double { @_common.sum(s.data) }

pub fn math_approx_poly_table_mean(s : MathapproxpolyTable) -> Double { @_common.mean(s.data) }

pub fn math_approx_poly_table_scale(s : MathapproxpolyTable, f : Double) -> MathapproxpolyTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_approx_poly_table_add(a : MathapproxpolyTable, b : MathapproxpolyTable) -> MathapproxpolyTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_approx_poly_table_copy(s : MathapproxpolyTable) -> MathapproxpolyTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_approx_poly_table_fill(s : MathapproxpolyTable, v : Double) -> MathapproxpolyTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_approx_poly_table_min(s : MathapproxpolyTable) -> Double { @_common.min(s.data) }

pub fn math_approx_poly_table_max(s : MathapproxpolyTable) -> Double { @_common.max(s.data) }

pub fn math_approx_poly_table_to_string(s : MathapproxpolyTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathapproxpolyGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_approx_poly_graphn_make(size : Int) -> MathapproxpolyGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_approx_poly_graphn_len(s : MathapproxpolyGraphN) -> Int { s.size }

pub fn math_approx_poly_graphn_get(s : MathapproxpolyGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_approx_poly_graphn_set(s : MathapproxpolyGraphN, i : Int, v : Double) -> MathapproxpolyGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_approx_poly_graphn_sum(s : MathapproxpolyGraphN) -> Double { @_common.sum(s.data) }

pub fn math_approx_poly_graphn_mean(s : MathapproxpolyGraphN) -> Double { @_common.mean(s.data) }

pub fn math_approx_poly_graphn_scale(s : MathapproxpolyGraphN, f : Double) -> MathapproxpolyGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_approx_poly_graphn_add(a : MathapproxpolyGraphN, b : MathapproxpolyGraphN) -> MathapproxpolyGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_approx_poly_graphn_copy(s : MathapproxpolyGraphN) -> MathapproxpolyGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_approx_poly_graphn_fill(s : MathapproxpolyGraphN, v : Double) -> MathapproxpolyGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_approx_poly_graphn_min(s : MathapproxpolyGraphN) -> Double { @_common.min(s.data) }

pub fn math_approx_poly_graphn_max(s : MathapproxpolyGraphN) -> Double { @_common.max(s.data) }

pub fn math_approx_poly_graphn_to_string(s : MathapproxpolyGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathapproxpolyNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_approx_poly_node_make(size : Int) -> MathapproxpolyNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_approx_poly_node_len(s : MathapproxpolyNode) -> Int { s.size }

pub fn math_approx_poly_node_get(s : MathapproxpolyNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_approx_poly_node_set(s : MathapproxpolyNode, i : Int, v : Double) -> MathapproxpolyNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_approx_poly_node_sum(s : MathapproxpolyNode) -> Double { @_common.sum(s.data) }

pub fn math_approx_poly_node_mean(s : MathapproxpolyNode) -> Double { @_common.mean(s.data) }

pub fn math_approx_poly_node_scale(s : MathapproxpolyNode, f : Double) -> MathapproxpolyNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_approx_poly_node_add(a : MathapproxpolyNode, b : MathapproxpolyNode) -> MathapproxpolyNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_approx_poly_node_copy(s : MathapproxpolyNode) -> MathapproxpolyNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_approx_poly_node_fill(s : MathapproxpolyNode, v : Double) -> MathapproxpolyNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_approx_poly_node_min(s : MathapproxpolyNode) -> Double { @_common.min(s.data) }

pub fn math_approx_poly_node_max(s : MathapproxpolyNode) -> Double { @_common.max(s.data) }

pub fn math_approx_poly_node_to_string(s : MathapproxpolyNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathapproxpolyEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_approx_poly_edge_make(size : Int) -> MathapproxpolyEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_approx_poly_edge_len(s : MathapproxpolyEdge) -> Int { s.size }

pub fn math_approx_poly_edge_get(s : MathapproxpolyEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_approx_poly_edge_set(s : MathapproxpolyEdge, i : Int, v : Double) -> MathapproxpolyEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_approx_poly_edge_sum(s : MathapproxpolyEdge) -> Double { @_common.sum(s.data) }

pub fn math_approx_poly_edge_mean(s : MathapproxpolyEdge) -> Double { @_common.mean(s.data) }

pub fn math_approx_poly_edge_scale(s : MathapproxpolyEdge, f : Double) -> MathapproxpolyEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_approx_poly_edge_add(a : MathapproxpolyEdge, b : MathapproxpolyEdge) -> MathapproxpolyEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_approx_poly_edge_copy(s : MathapproxpolyEdge) -> MathapproxpolyEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_approx_poly_edge_fill(s : MathapproxpolyEdge, v : Double) -> MathapproxpolyEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_approx_poly_edge_min(s : MathapproxpolyEdge) -> Double { @_common.min(s.data) }

pub fn math_approx_poly_edge_max(s : MathapproxpolyEdge) -> Double { @_common.max(s.data) }

pub fn math_approx_poly_edge_to_string(s : MathapproxpolyEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathapproxpolyPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_approx_poly_path_make(size : Int) -> MathapproxpolyPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_approx_poly_path_len(s : MathapproxpolyPath) -> Int { s.size }

pub fn math_approx_poly_path_get(s : MathapproxpolyPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_approx_poly_path_set(s : MathapproxpolyPath, i : Int, v : Double) -> MathapproxpolyPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_approx_poly_path_sum(s : MathapproxpolyPath) -> Double { @_common.sum(s.data) }

pub fn math_approx_poly_path_mean(s : MathapproxpolyPath) -> Double { @_common.mean(s.data) }

pub fn math_approx_poly_path_scale(s : MathapproxpolyPath, f : Double) -> MathapproxpolyPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_approx_poly_path_add(a : MathapproxpolyPath, b : MathapproxpolyPath) -> MathapproxpolyPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_approx_poly_path_copy(s : MathapproxpolyPath) -> MathapproxpolyPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_approx_poly_path_fill(s : MathapproxpolyPath, v : Double) -> MathapproxpolyPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_approx_poly_path_min(s : MathapproxpolyPath) -> Double { @_common.min(s.data) }

pub fn math_approx_poly_path_max(s : MathapproxpolyPath) -> Double { @_common.max(s.data) }

pub fn math_approx_poly_path_to_string(s : MathapproxpolyPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathapproxpolyCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_approx_poly_cluster_make(size : Int) -> MathapproxpolyCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_approx_poly_cluster_len(s : MathapproxpolyCluster) -> Int { s.size }

pub fn math_approx_poly_cluster_get(s : MathapproxpolyCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_approx_poly_cluster_set(s : MathapproxpolyCluster, i : Int, v : Double) -> MathapproxpolyCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_approx_poly_cluster_sum(s : MathapproxpolyCluster) -> Double { @_common.sum(s.data) }

pub fn math_approx_poly_cluster_mean(s : MathapproxpolyCluster) -> Double { @_common.mean(s.data) }

pub fn math_approx_poly_cluster_scale(s : MathapproxpolyCluster, f : Double) -> MathapproxpolyCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_approx_poly_cluster_add(a : MathapproxpolyCluster, b : MathapproxpolyCluster) -> MathapproxpolyCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_approx_poly_cluster_copy(s : MathapproxpolyCluster) -> MathapproxpolyCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_approx_poly_cluster_fill(s : MathapproxpolyCluster, v : Double) -> MathapproxpolyCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_approx_poly_cluster_min(s : MathapproxpolyCluster) -> Double { @_common.min(s.data) }

pub fn math_approx_poly_cluster_max(s : MathapproxpolyCluster) -> Double { @_common.max(s.data) }

pub fn math_approx_poly_cluster_to_string(s : MathapproxpolyCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathapproxpolyModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_approx_poly_model_make(size : Int) -> MathapproxpolyModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_approx_poly_model_len(s : MathapproxpolyModel) -> Int { s.size }

pub fn math_approx_poly_model_get(s : MathapproxpolyModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_approx_poly_model_set(s : MathapproxpolyModel, i : Int, v : Double) -> MathapproxpolyModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_approx_poly_model_sum(s : MathapproxpolyModel) -> Double { @_common.sum(s.data) }

pub fn math_approx_poly_model_mean(s : MathapproxpolyModel) -> Double { @_common.mean(s.data) }

pub fn math_approx_poly_model_scale(s : MathapproxpolyModel, f : Double) -> MathapproxpolyModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_approx_poly_model_add(a : MathapproxpolyModel, b : MathapproxpolyModel) -> MathapproxpolyModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_approx_poly_model_copy(s : MathapproxpolyModel) -> MathapproxpolyModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_approx_poly_model_fill(s : MathapproxpolyModel, v : Double) -> MathapproxpolyModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_approx_poly_model_min(s : MathapproxpolyModel) -> Double { @_common.min(s.data) }

pub fn math_approx_poly_model_max(s : MathapproxpolyModel) -> Double { @_common.max(s.data) }

pub fn math_approx_poly_model_to_string(s : MathapproxpolyModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathapproxpolyLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_approx_poly_layer_make(size : Int) -> MathapproxpolyLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_approx_poly_layer_len(s : MathapproxpolyLayer) -> Int { s.size }

pub fn math_approx_poly_layer_get(s : MathapproxpolyLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_approx_poly_layer_set(s : MathapproxpolyLayer, i : Int, v : Double) -> MathapproxpolyLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_approx_poly_layer_sum(s : MathapproxpolyLayer) -> Double { @_common.sum(s.data) }

pub fn math_approx_poly_layer_mean(s : MathapproxpolyLayer) -> Double { @_common.mean(s.data) }

pub fn math_approx_poly_layer_scale(s : MathapproxpolyLayer, f : Double) -> MathapproxpolyLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_approx_poly_layer_add(a : MathapproxpolyLayer, b : MathapproxpolyLayer) -> MathapproxpolyLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_approx_poly_layer_copy(s : MathapproxpolyLayer) -> MathapproxpolyLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_approx_poly_layer_fill(s : MathapproxpolyLayer, v : Double) -> MathapproxpolyLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_approx_poly_layer_min(s : MathapproxpolyLayer) -> Double { @_common.min(s.data) }

pub fn math_approx_poly_layer_max(s : MathapproxpolyLayer) -> Double { @_common.max(s.data) }

pub fn math_approx_poly_layer_to_string(s : MathapproxpolyLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathapproxpolyBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_approx_poly_buffer_make(size : Int) -> MathapproxpolyBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_approx_poly_buffer_len(s : MathapproxpolyBuffer) -> Int { s.size }

pub fn math_approx_poly_buffer_get(s : MathapproxpolyBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_approx_poly_buffer_set(s : MathapproxpolyBuffer, i : Int, v : Double) -> MathapproxpolyBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_approx_poly_buffer_sum(s : MathapproxpolyBuffer) -> Double { @_common.sum(s.data) }

pub fn math_approx_poly_buffer_mean(s : MathapproxpolyBuffer) -> Double { @_common.mean(s.data) }

pub fn math_approx_poly_buffer_scale(s : MathapproxpolyBuffer, f : Double) -> MathapproxpolyBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_approx_poly_buffer_add(a : MathapproxpolyBuffer, b : MathapproxpolyBuffer) -> MathapproxpolyBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_approx_poly_buffer_copy(s : MathapproxpolyBuffer) -> MathapproxpolyBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_approx_poly_buffer_fill(s : MathapproxpolyBuffer, v : Double) -> MathapproxpolyBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_approx_poly_buffer_min(s : MathapproxpolyBuffer) -> Double { @_common.min(s.data) }

pub fn math_approx_poly_buffer_max(s : MathapproxpolyBuffer) -> Double { @_common.max(s.data) }

pub fn math_approx_poly_buffer_to_string(s : MathapproxpolyBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathapproxpolyCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_approx_poly_cursor_make(size : Int) -> MathapproxpolyCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_approx_poly_cursor_len(s : MathapproxpolyCursor) -> Int { s.size }

pub fn math_approx_poly_cursor_get(s : MathapproxpolyCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_approx_poly_cursor_set(s : MathapproxpolyCursor, i : Int, v : Double) -> MathapproxpolyCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_approx_poly_cursor_sum(s : MathapproxpolyCursor) -> Double { @_common.sum(s.data) }

pub fn math_approx_poly_cursor_mean(s : MathapproxpolyCursor) -> Double { @_common.mean(s.data) }

pub fn math_approx_poly_cursor_scale(s : MathapproxpolyCursor, f : Double) -> MathapproxpolyCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_approx_poly_cursor_add(a : MathapproxpolyCursor, b : MathapproxpolyCursor) -> MathapproxpolyCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_approx_poly_cursor_copy(s : MathapproxpolyCursor) -> MathapproxpolyCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_approx_poly_cursor_fill(s : MathapproxpolyCursor, v : Double) -> MathapproxpolyCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_approx_poly_cursor_min(s : MathapproxpolyCursor) -> Double { @_common.min(s.data) }

pub fn math_approx_poly_cursor_max(s : MathapproxpolyCursor) -> Double { @_common.max(s.data) }

pub fn math_approx_poly_cursor_to_string(s : MathapproxpolyCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathapproxpolyView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_approx_poly_view_make(size : Int) -> MathapproxpolyView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_approx_poly_view_len(s : MathapproxpolyView) -> Int { s.size }

pub fn math_approx_poly_view_get(s : MathapproxpolyView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_approx_poly_view_set(s : MathapproxpolyView, i : Int, v : Double) -> MathapproxpolyView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_approx_poly_view_sum(s : MathapproxpolyView) -> Double { @_common.sum(s.data) }

pub fn math_approx_poly_view_mean(s : MathapproxpolyView) -> Double { @_common.mean(s.data) }

pub fn math_approx_poly_view_scale(s : MathapproxpolyView, f : Double) -> MathapproxpolyView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_approx_poly_view_add(a : MathapproxpolyView, b : MathapproxpolyView) -> MathapproxpolyView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_approx_poly_view_copy(s : MathapproxpolyView) -> MathapproxpolyView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_approx_poly_view_fill(s : MathapproxpolyView, v : Double) -> MathapproxpolyView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_approx_poly_view_min(s : MathapproxpolyView) -> Double { @_common.min(s.data) }

pub fn math_approx_poly_view_max(s : MathapproxpolyView) -> Double { @_common.max(s.data) }

pub fn math_approx_poly_view_to_string(s : MathapproxpolyView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathapproxpolyRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_approx_poly_range_make(size : Int) -> MathapproxpolyRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_approx_poly_range_len(s : MathapproxpolyRange) -> Int { s.size }

pub fn math_approx_poly_range_get(s : MathapproxpolyRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_approx_poly_range_set(s : MathapproxpolyRange, i : Int, v : Double) -> MathapproxpolyRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_approx_poly_range_sum(s : MathapproxpolyRange) -> Double { @_common.sum(s.data) }

pub fn math_approx_poly_range_mean(s : MathapproxpolyRange) -> Double { @_common.mean(s.data) }

pub fn math_approx_poly_range_scale(s : MathapproxpolyRange, f : Double) -> MathapproxpolyRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_approx_poly_range_add(a : MathapproxpolyRange, b : MathapproxpolyRange) -> MathapproxpolyRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_approx_poly_range_copy(s : MathapproxpolyRange) -> MathapproxpolyRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_approx_poly_range_fill(s : MathapproxpolyRange, v : Double) -> MathapproxpolyRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_approx_poly_range_min(s : MathapproxpolyRange) -> Double { @_common.min(s.data) }

pub fn math_approx_poly_range_max(s : MathapproxpolyRange) -> Double { @_common.max(s.data) }

pub fn math_approx_poly_range_to_string(s : MathapproxpolyRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathapproxpolySlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_approx_poly_slice_make(size : Int) -> MathapproxpolySlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_approx_poly_slice_len(s : MathapproxpolySlice) -> Int { s.size }

pub fn math_approx_poly_slice_get(s : MathapproxpolySlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_approx_poly_slice_set(s : MathapproxpolySlice, i : Int, v : Double) -> MathapproxpolySlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_approx_poly_slice_sum(s : MathapproxpolySlice) -> Double { @_common.sum(s.data) }

pub fn math_approx_poly_slice_mean(s : MathapproxpolySlice) -> Double { @_common.mean(s.data) }

pub fn math_approx_poly_slice_scale(s : MathapproxpolySlice, f : Double) -> MathapproxpolySlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_approx_poly_slice_add(a : MathapproxpolySlice, b : MathapproxpolySlice) -> MathapproxpolySlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_approx_poly_slice_copy(s : MathapproxpolySlice) -> MathapproxpolySlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_approx_poly_slice_fill(s : MathapproxpolySlice, v : Double) -> MathapproxpolySlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_approx_poly_slice_min(s : MathapproxpolySlice) -> Double { @_common.min(s.data) }

pub fn math_approx_poly_slice_max(s : MathapproxpolySlice) -> Double { @_common.max(s.data) }

pub fn math_approx_poly_slice_to_string(s : MathapproxpolySlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

