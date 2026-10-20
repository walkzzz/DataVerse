///===
/// extcore/math_approx_least_sq

pub(all) struct MathapproxleastsqPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn math_approx_least_sq_make_point(x : Double, y : Double) -> MathapproxleastsqPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn math_approx_least_sq_make_point3(x : Double, y : Double, z : Double) -> MathapproxleastsqPoint {
  { x, y, z, label: 0 }
}

pub fn MathapproxleastsqPoint::x(self : MathapproxleastsqPoint) -> Double { self.x }

pub fn MathapproxleastsqPoint::y(self : MathapproxleastsqPoint) -> Double { self.y }

pub fn MathapproxleastsqPoint::z(self : MathapproxleastsqPoint) -> Double { self.z }

pub fn MathapproxleastsqPoint::label(self : MathapproxleastsqPoint) -> Int { self.label }

pub fn MathapproxleastsqPoint::dist(self : MathapproxleastsqPoint, other : MathapproxleastsqPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn MathapproxleastsqPoint::add(self : MathapproxleastsqPoint, other : MathapproxleastsqPoint) -> MathapproxleastsqPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn MathapproxleastsqPoint::sub(self : MathapproxleastsqPoint, other : MathapproxleastsqPoint) -> MathapproxleastsqPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn MathapproxleastsqPoint::scale(self : MathapproxleastsqPoint, s : Double) -> MathapproxleastsqPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn MathapproxleastsqPoint::dot(self : MathapproxleastsqPoint, other : MathapproxleastsqPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn MathapproxleastsqPoint::cross(self : MathapproxleastsqPoint, other : MathapproxleastsqPoint) -> MathapproxleastsqPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn MathapproxleastsqPoint::norm(self : MathapproxleastsqPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn MathapproxleastsqPoint::normalize(self : MathapproxleastsqPoint) -> MathapproxleastsqPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn MathapproxleastsqPoint::negate(self : MathapproxleastsqPoint) -> MathapproxleastsqPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn MathapproxleastsqPoint::mid(self : MathapproxleastsqPoint, other : MathapproxleastsqPoint) -> MathapproxleastsqPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn MathapproxleastsqPoint::lerp(self : MathapproxleastsqPoint, other : MathapproxleastsqPoint, t : Double) -> MathapproxleastsqPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn MathapproxleastsqPoint::to_string(self : MathapproxleastsqPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct MathapproxleastsqSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn math_approx_least_sq_make_series(vals : Array[Double], name : String) -> MathapproxleastsqSeries {
  { vals, name, meta: 0 }
}

pub fn MathapproxleastsqSeries::len(self : MathapproxleastsqSeries) -> Int { self.vals.length() }

pub fn MathapproxleastsqSeries::sum(self : MathapproxleastsqSeries) -> Double { @_common.sum(self.vals) }

pub fn MathapproxleastsqSeries::mean(self : MathapproxleastsqSeries) -> Double { @_common.mean(self.vals) }

pub fn MathapproxleastsqSeries::min(self : MathapproxleastsqSeries) -> Double { @_common.min(self.vals) }

pub fn MathapproxleastsqSeries::max(self : MathapproxleastsqSeries) -> Double { @_common.max(self.vals) }

pub fn MathapproxleastsqSeries::range(self : MathapproxleastsqSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn MathapproxleastsqSeries::variance(self : MathapproxleastsqSeries) -> Double { @_common.variance(self.vals) }

pub fn MathapproxleastsqSeries::std(self : MathapproxleastsqSeries) -> Double { @_common.std(self.vals) }

pub fn MathapproxleastsqSeries::median(self : MathapproxleastsqSeries) -> Double { @_common.median(self.vals) }

pub fn MathapproxleastsqSeries::scale(self : MathapproxleastsqSeries, f : Double) -> MathapproxleastsqSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn MathapproxleastsqSeries::add(self : MathapproxleastsqSeries, other : MathapproxleastsqSeries) -> MathapproxleastsqSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn MathapproxleastsqSeries::sub(self : MathapproxleastsqSeries, other : MathapproxleastsqSeries) -> MathapproxleastsqSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn MathapproxleastsqSeries::normalize(self : MathapproxleastsqSeries) -> MathapproxleastsqSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn MathapproxleastsqSeries::cumsum(self : MathapproxleastsqSeries) -> MathapproxleastsqSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn MathapproxleastsqSeries::to_string(self : MathapproxleastsqSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct MathapproxleastsqMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn math_approx_least_sq_make_matrix(rows : Int, cols : Int, val : Double) -> MathapproxleastsqMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn math_approx_least_sq_matrix_identity(n : Int) -> MathapproxleastsqMatrix {
  let m = math_approx_least_sq_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn MathapproxleastsqMatrix::get(self : MathapproxleastsqMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn MathapproxleastsqMatrix::transpose(self : MathapproxleastsqMatrix) -> MathapproxleastsqMatrix {
  let result = math_approx_least_sq_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn MathapproxleastsqMatrix::add(self : MathapproxleastsqMatrix, other : MathapproxleastsqMatrix) -> MathapproxleastsqMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = math_approx_least_sq_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn MathapproxleastsqMatrix::scale(self : MathapproxleastsqMatrix, s : Double) -> MathapproxleastsqMatrix {
  let result = math_approx_least_sq_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn MathapproxleastsqMatrix::multiply(self : MathapproxleastsqMatrix, other : MathapproxleastsqMatrix) -> MathapproxleastsqMatrix {
  if self.cols != other.rows { return math_approx_least_sq_make_matrix(self.rows, other.cols, 0.0) }
  let result = math_approx_least_sq_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn MathapproxleastsqMatrix::trace(self : MathapproxleastsqMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn MathapproxleastsqMatrix::det(self : MathapproxleastsqMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn MathapproxleastsqMatrix::norm(self : MathapproxleastsqMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn MathapproxleastsqMatrix::to_string(self : MathapproxleastsqMatrix) -> String {
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

pub(all) struct MathapproxleastsqVector {
  comps : Array[Double]
  dim : Int
}

pub fn math_approx_least_sq_make_vector(comps : Array[Double]) -> MathapproxleastsqVector {
  { comps, dim: comps.length() }
}

pub fn math_approx_least_sq_vector_zero(dim : Int) -> MathapproxleastsqVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn MathapproxleastsqVector::add(self : MathapproxleastsqVector, other : MathapproxleastsqVector) -> MathapproxleastsqVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn MathapproxleastsqVector::sub(self : MathapproxleastsqVector, other : MathapproxleastsqVector) -> MathapproxleastsqVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn MathapproxleastsqVector::scale(self : MathapproxleastsqVector, s : Double) -> MathapproxleastsqVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn MathapproxleastsqVector::dot(self : MathapproxleastsqVector, other : MathapproxleastsqVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn MathapproxleastsqVector::norm(self : MathapproxleastsqVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn MathapproxleastsqVector::normalize(self : MathapproxleastsqVector) -> MathapproxleastsqVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn MathapproxleastsqVector::dist(self : MathapproxleastsqVector, other : MathapproxleastsqVector) -> Double {
  self.sub(other).norm()
}

pub fn MathapproxleastsqVector::to_string(self : MathapproxleastsqVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn math_approx_least_sq_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn math_approx_least_sq_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn math_approx_least_sq_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn math_approx_least_sq_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn math_approx_least_sq_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn math_approx_least_sq_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn math_approx_least_sq_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn math_approx_least_sq_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn math_approx_least_sq_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn math_approx_least_sq_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn math_approx_least_sq_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn math_approx_least_sq_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn math_approx_least_sq_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn math_approx_least_sq_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn math_approx_least_sq_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn math_approx_least_sq_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn math_approx_least_sq_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn math_approx_least_sq_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn math_approx_least_sq_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn math_approx_least_sq_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn math_approx_least_sq_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn math_approx_least_sq_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn math_approx_least_sq_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn math_approx_least_sq_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn math_approx_least_sq_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn math_approx_least_sq_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn math_approx_least_sq_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn math_approx_least_sq_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn math_approx_least_sq_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct MathapproxleastsqFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_approx_least_sq_frame_make(size : Int) -> MathapproxleastsqFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_approx_least_sq_frame_len(s : MathapproxleastsqFrame) -> Int { s.size }

pub fn math_approx_least_sq_frame_get(s : MathapproxleastsqFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_approx_least_sq_frame_set(s : MathapproxleastsqFrame, i : Int, v : Double) -> MathapproxleastsqFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_approx_least_sq_frame_sum(s : MathapproxleastsqFrame) -> Double { @_common.sum(s.data) }

pub fn math_approx_least_sq_frame_mean(s : MathapproxleastsqFrame) -> Double { @_common.mean(s.data) }

pub fn math_approx_least_sq_frame_scale(s : MathapproxleastsqFrame, f : Double) -> MathapproxleastsqFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_approx_least_sq_frame_add(a : MathapproxleastsqFrame, b : MathapproxleastsqFrame) -> MathapproxleastsqFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_approx_least_sq_frame_copy(s : MathapproxleastsqFrame) -> MathapproxleastsqFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_approx_least_sq_frame_fill(s : MathapproxleastsqFrame, v : Double) -> MathapproxleastsqFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_approx_least_sq_frame_min(s : MathapproxleastsqFrame) -> Double { @_common.min(s.data) }

pub fn math_approx_least_sq_frame_max(s : MathapproxleastsqFrame) -> Double { @_common.max(s.data) }

pub fn math_approx_least_sq_frame_to_string(s : MathapproxleastsqFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathapproxleastsqTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_approx_least_sq_table_make(size : Int) -> MathapproxleastsqTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_approx_least_sq_table_len(s : MathapproxleastsqTable) -> Int { s.size }

pub fn math_approx_least_sq_table_get(s : MathapproxleastsqTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_approx_least_sq_table_set(s : MathapproxleastsqTable, i : Int, v : Double) -> MathapproxleastsqTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_approx_least_sq_table_sum(s : MathapproxleastsqTable) -> Double { @_common.sum(s.data) }

pub fn math_approx_least_sq_table_mean(s : MathapproxleastsqTable) -> Double { @_common.mean(s.data) }

pub fn math_approx_least_sq_table_scale(s : MathapproxleastsqTable, f : Double) -> MathapproxleastsqTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_approx_least_sq_table_add(a : MathapproxleastsqTable, b : MathapproxleastsqTable) -> MathapproxleastsqTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_approx_least_sq_table_copy(s : MathapproxleastsqTable) -> MathapproxleastsqTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_approx_least_sq_table_fill(s : MathapproxleastsqTable, v : Double) -> MathapproxleastsqTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_approx_least_sq_table_min(s : MathapproxleastsqTable) -> Double { @_common.min(s.data) }

pub fn math_approx_least_sq_table_max(s : MathapproxleastsqTable) -> Double { @_common.max(s.data) }

pub fn math_approx_least_sq_table_to_string(s : MathapproxleastsqTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathapproxleastsqGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_approx_least_sq_graphn_make(size : Int) -> MathapproxleastsqGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_approx_least_sq_graphn_len(s : MathapproxleastsqGraphN) -> Int { s.size }

pub fn math_approx_least_sq_graphn_get(s : MathapproxleastsqGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_approx_least_sq_graphn_set(s : MathapproxleastsqGraphN, i : Int, v : Double) -> MathapproxleastsqGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_approx_least_sq_graphn_sum(s : MathapproxleastsqGraphN) -> Double { @_common.sum(s.data) }

pub fn math_approx_least_sq_graphn_mean(s : MathapproxleastsqGraphN) -> Double { @_common.mean(s.data) }

pub fn math_approx_least_sq_graphn_scale(s : MathapproxleastsqGraphN, f : Double) -> MathapproxleastsqGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_approx_least_sq_graphn_add(a : MathapproxleastsqGraphN, b : MathapproxleastsqGraphN) -> MathapproxleastsqGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_approx_least_sq_graphn_copy(s : MathapproxleastsqGraphN) -> MathapproxleastsqGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_approx_least_sq_graphn_fill(s : MathapproxleastsqGraphN, v : Double) -> MathapproxleastsqGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_approx_least_sq_graphn_min(s : MathapproxleastsqGraphN) -> Double { @_common.min(s.data) }

pub fn math_approx_least_sq_graphn_max(s : MathapproxleastsqGraphN) -> Double { @_common.max(s.data) }

pub fn math_approx_least_sq_graphn_to_string(s : MathapproxleastsqGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathapproxleastsqNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_approx_least_sq_node_make(size : Int) -> MathapproxleastsqNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_approx_least_sq_node_len(s : MathapproxleastsqNode) -> Int { s.size }

pub fn math_approx_least_sq_node_get(s : MathapproxleastsqNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_approx_least_sq_node_set(s : MathapproxleastsqNode, i : Int, v : Double) -> MathapproxleastsqNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_approx_least_sq_node_sum(s : MathapproxleastsqNode) -> Double { @_common.sum(s.data) }

pub fn math_approx_least_sq_node_mean(s : MathapproxleastsqNode) -> Double { @_common.mean(s.data) }

pub fn math_approx_least_sq_node_scale(s : MathapproxleastsqNode, f : Double) -> MathapproxleastsqNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_approx_least_sq_node_add(a : MathapproxleastsqNode, b : MathapproxleastsqNode) -> MathapproxleastsqNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_approx_least_sq_node_copy(s : MathapproxleastsqNode) -> MathapproxleastsqNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_approx_least_sq_node_fill(s : MathapproxleastsqNode, v : Double) -> MathapproxleastsqNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_approx_least_sq_node_min(s : MathapproxleastsqNode) -> Double { @_common.min(s.data) }

pub fn math_approx_least_sq_node_max(s : MathapproxleastsqNode) -> Double { @_common.max(s.data) }

pub fn math_approx_least_sq_node_to_string(s : MathapproxleastsqNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathapproxleastsqEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_approx_least_sq_edge_make(size : Int) -> MathapproxleastsqEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_approx_least_sq_edge_len(s : MathapproxleastsqEdge) -> Int { s.size }

pub fn math_approx_least_sq_edge_get(s : MathapproxleastsqEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_approx_least_sq_edge_set(s : MathapproxleastsqEdge, i : Int, v : Double) -> MathapproxleastsqEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_approx_least_sq_edge_sum(s : MathapproxleastsqEdge) -> Double { @_common.sum(s.data) }

pub fn math_approx_least_sq_edge_mean(s : MathapproxleastsqEdge) -> Double { @_common.mean(s.data) }

pub fn math_approx_least_sq_edge_scale(s : MathapproxleastsqEdge, f : Double) -> MathapproxleastsqEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_approx_least_sq_edge_add(a : MathapproxleastsqEdge, b : MathapproxleastsqEdge) -> MathapproxleastsqEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_approx_least_sq_edge_copy(s : MathapproxleastsqEdge) -> MathapproxleastsqEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_approx_least_sq_edge_fill(s : MathapproxleastsqEdge, v : Double) -> MathapproxleastsqEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_approx_least_sq_edge_min(s : MathapproxleastsqEdge) -> Double { @_common.min(s.data) }

pub fn math_approx_least_sq_edge_max(s : MathapproxleastsqEdge) -> Double { @_common.max(s.data) }

pub fn math_approx_least_sq_edge_to_string(s : MathapproxleastsqEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathapproxleastsqPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_approx_least_sq_path_make(size : Int) -> MathapproxleastsqPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_approx_least_sq_path_len(s : MathapproxleastsqPath) -> Int { s.size }

pub fn math_approx_least_sq_path_get(s : MathapproxleastsqPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_approx_least_sq_path_set(s : MathapproxleastsqPath, i : Int, v : Double) -> MathapproxleastsqPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_approx_least_sq_path_sum(s : MathapproxleastsqPath) -> Double { @_common.sum(s.data) }

pub fn math_approx_least_sq_path_mean(s : MathapproxleastsqPath) -> Double { @_common.mean(s.data) }

pub fn math_approx_least_sq_path_scale(s : MathapproxleastsqPath, f : Double) -> MathapproxleastsqPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_approx_least_sq_path_add(a : MathapproxleastsqPath, b : MathapproxleastsqPath) -> MathapproxleastsqPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_approx_least_sq_path_copy(s : MathapproxleastsqPath) -> MathapproxleastsqPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_approx_least_sq_path_fill(s : MathapproxleastsqPath, v : Double) -> MathapproxleastsqPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_approx_least_sq_path_min(s : MathapproxleastsqPath) -> Double { @_common.min(s.data) }

pub fn math_approx_least_sq_path_max(s : MathapproxleastsqPath) -> Double { @_common.max(s.data) }

pub fn math_approx_least_sq_path_to_string(s : MathapproxleastsqPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathapproxleastsqCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_approx_least_sq_cluster_make(size : Int) -> MathapproxleastsqCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_approx_least_sq_cluster_len(s : MathapproxleastsqCluster) -> Int { s.size }

pub fn math_approx_least_sq_cluster_get(s : MathapproxleastsqCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_approx_least_sq_cluster_set(s : MathapproxleastsqCluster, i : Int, v : Double) -> MathapproxleastsqCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_approx_least_sq_cluster_sum(s : MathapproxleastsqCluster) -> Double { @_common.sum(s.data) }

pub fn math_approx_least_sq_cluster_mean(s : MathapproxleastsqCluster) -> Double { @_common.mean(s.data) }

pub fn math_approx_least_sq_cluster_scale(s : MathapproxleastsqCluster, f : Double) -> MathapproxleastsqCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_approx_least_sq_cluster_add(a : MathapproxleastsqCluster, b : MathapproxleastsqCluster) -> MathapproxleastsqCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_approx_least_sq_cluster_copy(s : MathapproxleastsqCluster) -> MathapproxleastsqCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_approx_least_sq_cluster_fill(s : MathapproxleastsqCluster, v : Double) -> MathapproxleastsqCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_approx_least_sq_cluster_min(s : MathapproxleastsqCluster) -> Double { @_common.min(s.data) }

pub fn math_approx_least_sq_cluster_max(s : MathapproxleastsqCluster) -> Double { @_common.max(s.data) }

pub fn math_approx_least_sq_cluster_to_string(s : MathapproxleastsqCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathapproxleastsqModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_approx_least_sq_model_make(size : Int) -> MathapproxleastsqModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_approx_least_sq_model_len(s : MathapproxleastsqModel) -> Int { s.size }

pub fn math_approx_least_sq_model_get(s : MathapproxleastsqModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_approx_least_sq_model_set(s : MathapproxleastsqModel, i : Int, v : Double) -> MathapproxleastsqModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_approx_least_sq_model_sum(s : MathapproxleastsqModel) -> Double { @_common.sum(s.data) }

pub fn math_approx_least_sq_model_mean(s : MathapproxleastsqModel) -> Double { @_common.mean(s.data) }

pub fn math_approx_least_sq_model_scale(s : MathapproxleastsqModel, f : Double) -> MathapproxleastsqModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_approx_least_sq_model_add(a : MathapproxleastsqModel, b : MathapproxleastsqModel) -> MathapproxleastsqModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_approx_least_sq_model_copy(s : MathapproxleastsqModel) -> MathapproxleastsqModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_approx_least_sq_model_fill(s : MathapproxleastsqModel, v : Double) -> MathapproxleastsqModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_approx_least_sq_model_min(s : MathapproxleastsqModel) -> Double { @_common.min(s.data) }

pub fn math_approx_least_sq_model_max(s : MathapproxleastsqModel) -> Double { @_common.max(s.data) }

pub fn math_approx_least_sq_model_to_string(s : MathapproxleastsqModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathapproxleastsqLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_approx_least_sq_layer_make(size : Int) -> MathapproxleastsqLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_approx_least_sq_layer_len(s : MathapproxleastsqLayer) -> Int { s.size }

pub fn math_approx_least_sq_layer_get(s : MathapproxleastsqLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_approx_least_sq_layer_set(s : MathapproxleastsqLayer, i : Int, v : Double) -> MathapproxleastsqLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_approx_least_sq_layer_sum(s : MathapproxleastsqLayer) -> Double { @_common.sum(s.data) }

pub fn math_approx_least_sq_layer_mean(s : MathapproxleastsqLayer) -> Double { @_common.mean(s.data) }

pub fn math_approx_least_sq_layer_scale(s : MathapproxleastsqLayer, f : Double) -> MathapproxleastsqLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_approx_least_sq_layer_add(a : MathapproxleastsqLayer, b : MathapproxleastsqLayer) -> MathapproxleastsqLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_approx_least_sq_layer_copy(s : MathapproxleastsqLayer) -> MathapproxleastsqLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_approx_least_sq_layer_fill(s : MathapproxleastsqLayer, v : Double) -> MathapproxleastsqLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_approx_least_sq_layer_min(s : MathapproxleastsqLayer) -> Double { @_common.min(s.data) }

pub fn math_approx_least_sq_layer_max(s : MathapproxleastsqLayer) -> Double { @_common.max(s.data) }

pub fn math_approx_least_sq_layer_to_string(s : MathapproxleastsqLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathapproxleastsqBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_approx_least_sq_buffer_make(size : Int) -> MathapproxleastsqBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_approx_least_sq_buffer_len(s : MathapproxleastsqBuffer) -> Int { s.size }

pub fn math_approx_least_sq_buffer_get(s : MathapproxleastsqBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_approx_least_sq_buffer_set(s : MathapproxleastsqBuffer, i : Int, v : Double) -> MathapproxleastsqBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_approx_least_sq_buffer_sum(s : MathapproxleastsqBuffer) -> Double { @_common.sum(s.data) }

pub fn math_approx_least_sq_buffer_mean(s : MathapproxleastsqBuffer) -> Double { @_common.mean(s.data) }

pub fn math_approx_least_sq_buffer_scale(s : MathapproxleastsqBuffer, f : Double) -> MathapproxleastsqBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_approx_least_sq_buffer_add(a : MathapproxleastsqBuffer, b : MathapproxleastsqBuffer) -> MathapproxleastsqBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_approx_least_sq_buffer_copy(s : MathapproxleastsqBuffer) -> MathapproxleastsqBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_approx_least_sq_buffer_fill(s : MathapproxleastsqBuffer, v : Double) -> MathapproxleastsqBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_approx_least_sq_buffer_min(s : MathapproxleastsqBuffer) -> Double { @_common.min(s.data) }

pub fn math_approx_least_sq_buffer_max(s : MathapproxleastsqBuffer) -> Double { @_common.max(s.data) }

pub fn math_approx_least_sq_buffer_to_string(s : MathapproxleastsqBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathapproxleastsqCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_approx_least_sq_cursor_make(size : Int) -> MathapproxleastsqCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_approx_least_sq_cursor_len(s : MathapproxleastsqCursor) -> Int { s.size }

pub fn math_approx_least_sq_cursor_get(s : MathapproxleastsqCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_approx_least_sq_cursor_set(s : MathapproxleastsqCursor, i : Int, v : Double) -> MathapproxleastsqCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_approx_least_sq_cursor_sum(s : MathapproxleastsqCursor) -> Double { @_common.sum(s.data) }

pub fn math_approx_least_sq_cursor_mean(s : MathapproxleastsqCursor) -> Double { @_common.mean(s.data) }

pub fn math_approx_least_sq_cursor_scale(s : MathapproxleastsqCursor, f : Double) -> MathapproxleastsqCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_approx_least_sq_cursor_add(a : MathapproxleastsqCursor, b : MathapproxleastsqCursor) -> MathapproxleastsqCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_approx_least_sq_cursor_copy(s : MathapproxleastsqCursor) -> MathapproxleastsqCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_approx_least_sq_cursor_fill(s : MathapproxleastsqCursor, v : Double) -> MathapproxleastsqCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_approx_least_sq_cursor_min(s : MathapproxleastsqCursor) -> Double { @_common.min(s.data) }

pub fn math_approx_least_sq_cursor_max(s : MathapproxleastsqCursor) -> Double { @_common.max(s.data) }

pub fn math_approx_least_sq_cursor_to_string(s : MathapproxleastsqCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathapproxleastsqView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_approx_least_sq_view_make(size : Int) -> MathapproxleastsqView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_approx_least_sq_view_len(s : MathapproxleastsqView) -> Int { s.size }

pub fn math_approx_least_sq_view_get(s : MathapproxleastsqView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_approx_least_sq_view_set(s : MathapproxleastsqView, i : Int, v : Double) -> MathapproxleastsqView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_approx_least_sq_view_sum(s : MathapproxleastsqView) -> Double { @_common.sum(s.data) }

pub fn math_approx_least_sq_view_mean(s : MathapproxleastsqView) -> Double { @_common.mean(s.data) }

pub fn math_approx_least_sq_view_scale(s : MathapproxleastsqView, f : Double) -> MathapproxleastsqView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_approx_least_sq_view_add(a : MathapproxleastsqView, b : MathapproxleastsqView) -> MathapproxleastsqView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_approx_least_sq_view_copy(s : MathapproxleastsqView) -> MathapproxleastsqView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_approx_least_sq_view_fill(s : MathapproxleastsqView, v : Double) -> MathapproxleastsqView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_approx_least_sq_view_min(s : MathapproxleastsqView) -> Double { @_common.min(s.data) }

pub fn math_approx_least_sq_view_max(s : MathapproxleastsqView) -> Double { @_common.max(s.data) }

pub fn math_approx_least_sq_view_to_string(s : MathapproxleastsqView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathapproxleastsqRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_approx_least_sq_range_make(size : Int) -> MathapproxleastsqRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_approx_least_sq_range_len(s : MathapproxleastsqRange) -> Int { s.size }

pub fn math_approx_least_sq_range_get(s : MathapproxleastsqRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_approx_least_sq_range_set(s : MathapproxleastsqRange, i : Int, v : Double) -> MathapproxleastsqRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_approx_least_sq_range_sum(s : MathapproxleastsqRange) -> Double { @_common.sum(s.data) }

pub fn math_approx_least_sq_range_mean(s : MathapproxleastsqRange) -> Double { @_common.mean(s.data) }

pub fn math_approx_least_sq_range_scale(s : MathapproxleastsqRange, f : Double) -> MathapproxleastsqRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_approx_least_sq_range_add(a : MathapproxleastsqRange, b : MathapproxleastsqRange) -> MathapproxleastsqRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_approx_least_sq_range_copy(s : MathapproxleastsqRange) -> MathapproxleastsqRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_approx_least_sq_range_fill(s : MathapproxleastsqRange, v : Double) -> MathapproxleastsqRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_approx_least_sq_range_min(s : MathapproxleastsqRange) -> Double { @_common.min(s.data) }

pub fn math_approx_least_sq_range_max(s : MathapproxleastsqRange) -> Double { @_common.max(s.data) }

pub fn math_approx_least_sq_range_to_string(s : MathapproxleastsqRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathapproxleastsqSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_approx_least_sq_slice_make(size : Int) -> MathapproxleastsqSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_approx_least_sq_slice_len(s : MathapproxleastsqSlice) -> Int { s.size }

pub fn math_approx_least_sq_slice_get(s : MathapproxleastsqSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_approx_least_sq_slice_set(s : MathapproxleastsqSlice, i : Int, v : Double) -> MathapproxleastsqSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_approx_least_sq_slice_sum(s : MathapproxleastsqSlice) -> Double { @_common.sum(s.data) }

pub fn math_approx_least_sq_slice_mean(s : MathapproxleastsqSlice) -> Double { @_common.mean(s.data) }

pub fn math_approx_least_sq_slice_scale(s : MathapproxleastsqSlice, f : Double) -> MathapproxleastsqSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_approx_least_sq_slice_add(a : MathapproxleastsqSlice, b : MathapproxleastsqSlice) -> MathapproxleastsqSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_approx_least_sq_slice_copy(s : MathapproxleastsqSlice) -> MathapproxleastsqSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_approx_least_sq_slice_fill(s : MathapproxleastsqSlice, v : Double) -> MathapproxleastsqSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_approx_least_sq_slice_min(s : MathapproxleastsqSlice) -> Double { @_common.min(s.data) }

pub fn math_approx_least_sq_slice_max(s : MathapproxleastsqSlice) -> Double { @_common.max(s.data) }

pub fn math_approx_least_sq_slice_to_string(s : MathapproxleastsqSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

