///===
/// extcore/math_approx_rational

pub(all) struct MathapproxrationalPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn math_approx_rational_make_point(x : Double, y : Double) -> MathapproxrationalPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn math_approx_rational_make_point3(x : Double, y : Double, z : Double) -> MathapproxrationalPoint {
  { x, y, z, label: 0 }
}

pub fn MathapproxrationalPoint::x(self : MathapproxrationalPoint) -> Double { self.x }

pub fn MathapproxrationalPoint::y(self : MathapproxrationalPoint) -> Double { self.y }

pub fn MathapproxrationalPoint::z(self : MathapproxrationalPoint) -> Double { self.z }

pub fn MathapproxrationalPoint::label(self : MathapproxrationalPoint) -> Int { self.label }

pub fn MathapproxrationalPoint::dist(self : MathapproxrationalPoint, other : MathapproxrationalPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn MathapproxrationalPoint::add(self : MathapproxrationalPoint, other : MathapproxrationalPoint) -> MathapproxrationalPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn MathapproxrationalPoint::sub(self : MathapproxrationalPoint, other : MathapproxrationalPoint) -> MathapproxrationalPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn MathapproxrationalPoint::scale(self : MathapproxrationalPoint, s : Double) -> MathapproxrationalPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn MathapproxrationalPoint::dot(self : MathapproxrationalPoint, other : MathapproxrationalPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn MathapproxrationalPoint::cross(self : MathapproxrationalPoint, other : MathapproxrationalPoint) -> MathapproxrationalPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn MathapproxrationalPoint::norm(self : MathapproxrationalPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn MathapproxrationalPoint::normalize(self : MathapproxrationalPoint) -> MathapproxrationalPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn MathapproxrationalPoint::negate(self : MathapproxrationalPoint) -> MathapproxrationalPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn MathapproxrationalPoint::mid(self : MathapproxrationalPoint, other : MathapproxrationalPoint) -> MathapproxrationalPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn MathapproxrationalPoint::lerp(self : MathapproxrationalPoint, other : MathapproxrationalPoint, t : Double) -> MathapproxrationalPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn MathapproxrationalPoint::to_string(self : MathapproxrationalPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct MathapproxrationalSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn math_approx_rational_make_series(vals : Array[Double], name : String) -> MathapproxrationalSeries {
  { vals, name, meta: 0 }
}

pub fn MathapproxrationalSeries::len(self : MathapproxrationalSeries) -> Int { self.vals.length() }

pub fn MathapproxrationalSeries::sum(self : MathapproxrationalSeries) -> Double { @_common.sum(self.vals) }

pub fn MathapproxrationalSeries::mean(self : MathapproxrationalSeries) -> Double { @_common.mean(self.vals) }

pub fn MathapproxrationalSeries::min(self : MathapproxrationalSeries) -> Double { @_common.min(self.vals) }

pub fn MathapproxrationalSeries::max(self : MathapproxrationalSeries) -> Double { @_common.max(self.vals) }

pub fn MathapproxrationalSeries::range(self : MathapproxrationalSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn MathapproxrationalSeries::variance(self : MathapproxrationalSeries) -> Double { @_common.variance(self.vals) }

pub fn MathapproxrationalSeries::std(self : MathapproxrationalSeries) -> Double { @_common.std(self.vals) }

pub fn MathapproxrationalSeries::median(self : MathapproxrationalSeries) -> Double { @_common.median(self.vals) }

pub fn MathapproxrationalSeries::scale(self : MathapproxrationalSeries, f : Double) -> MathapproxrationalSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn MathapproxrationalSeries::add(self : MathapproxrationalSeries, other : MathapproxrationalSeries) -> MathapproxrationalSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn MathapproxrationalSeries::sub(self : MathapproxrationalSeries, other : MathapproxrationalSeries) -> MathapproxrationalSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn MathapproxrationalSeries::normalize(self : MathapproxrationalSeries) -> MathapproxrationalSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn MathapproxrationalSeries::cumsum(self : MathapproxrationalSeries) -> MathapproxrationalSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn MathapproxrationalSeries::to_string(self : MathapproxrationalSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct MathapproxrationalMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn math_approx_rational_make_matrix(rows : Int, cols : Int, val : Double) -> MathapproxrationalMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn math_approx_rational_matrix_identity(n : Int) -> MathapproxrationalMatrix {
  let m = math_approx_rational_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn MathapproxrationalMatrix::get(self : MathapproxrationalMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn MathapproxrationalMatrix::transpose(self : MathapproxrationalMatrix) -> MathapproxrationalMatrix {
  let result = math_approx_rational_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn MathapproxrationalMatrix::add(self : MathapproxrationalMatrix, other : MathapproxrationalMatrix) -> MathapproxrationalMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = math_approx_rational_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn MathapproxrationalMatrix::scale(self : MathapproxrationalMatrix, s : Double) -> MathapproxrationalMatrix {
  let result = math_approx_rational_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn MathapproxrationalMatrix::multiply(self : MathapproxrationalMatrix, other : MathapproxrationalMatrix) -> MathapproxrationalMatrix {
  if self.cols != other.rows { return math_approx_rational_make_matrix(self.rows, other.cols, 0.0) }
  let result = math_approx_rational_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn MathapproxrationalMatrix::trace(self : MathapproxrationalMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn MathapproxrationalMatrix::det(self : MathapproxrationalMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn MathapproxrationalMatrix::norm(self : MathapproxrationalMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn MathapproxrationalMatrix::to_string(self : MathapproxrationalMatrix) -> String {
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

pub(all) struct MathapproxrationalVector {
  comps : Array[Double]
  dim : Int
}

pub fn math_approx_rational_make_vector(comps : Array[Double]) -> MathapproxrationalVector {
  { comps, dim: comps.length() }
}

pub fn math_approx_rational_vector_zero(dim : Int) -> MathapproxrationalVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn MathapproxrationalVector::add(self : MathapproxrationalVector, other : MathapproxrationalVector) -> MathapproxrationalVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn MathapproxrationalVector::sub(self : MathapproxrationalVector, other : MathapproxrationalVector) -> MathapproxrationalVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn MathapproxrationalVector::scale(self : MathapproxrationalVector, s : Double) -> MathapproxrationalVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn MathapproxrationalVector::dot(self : MathapproxrationalVector, other : MathapproxrationalVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn MathapproxrationalVector::norm(self : MathapproxrationalVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn MathapproxrationalVector::normalize(self : MathapproxrationalVector) -> MathapproxrationalVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn MathapproxrationalVector::dist(self : MathapproxrationalVector, other : MathapproxrationalVector) -> Double {
  self.sub(other).norm()
}

pub fn MathapproxrationalVector::to_string(self : MathapproxrationalVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn math_approx_rational_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn math_approx_rational_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn math_approx_rational_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn math_approx_rational_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn math_approx_rational_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn math_approx_rational_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn math_approx_rational_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn math_approx_rational_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn math_approx_rational_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn math_approx_rational_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn math_approx_rational_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn math_approx_rational_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn math_approx_rational_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn math_approx_rational_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn math_approx_rational_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn math_approx_rational_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn math_approx_rational_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn math_approx_rational_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn math_approx_rational_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn math_approx_rational_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn math_approx_rational_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn math_approx_rational_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn math_approx_rational_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn math_approx_rational_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn math_approx_rational_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn math_approx_rational_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn math_approx_rational_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn math_approx_rational_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn math_approx_rational_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct MathapproxrationalFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_approx_rational_frame_make(size : Int) -> MathapproxrationalFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_approx_rational_frame_len(s : MathapproxrationalFrame) -> Int { s.size }

pub fn math_approx_rational_frame_get(s : MathapproxrationalFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_approx_rational_frame_set(s : MathapproxrationalFrame, i : Int, v : Double) -> MathapproxrationalFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_approx_rational_frame_sum(s : MathapproxrationalFrame) -> Double { @_common.sum(s.data) }

pub fn math_approx_rational_frame_mean(s : MathapproxrationalFrame) -> Double { @_common.mean(s.data) }

pub fn math_approx_rational_frame_scale(s : MathapproxrationalFrame, f : Double) -> MathapproxrationalFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_approx_rational_frame_add(a : MathapproxrationalFrame, b : MathapproxrationalFrame) -> MathapproxrationalFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_approx_rational_frame_copy(s : MathapproxrationalFrame) -> MathapproxrationalFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_approx_rational_frame_fill(s : MathapproxrationalFrame, v : Double) -> MathapproxrationalFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_approx_rational_frame_min(s : MathapproxrationalFrame) -> Double { @_common.min(s.data) }

pub fn math_approx_rational_frame_max(s : MathapproxrationalFrame) -> Double { @_common.max(s.data) }

pub fn math_approx_rational_frame_to_string(s : MathapproxrationalFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathapproxrationalTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_approx_rational_table_make(size : Int) -> MathapproxrationalTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_approx_rational_table_len(s : MathapproxrationalTable) -> Int { s.size }

pub fn math_approx_rational_table_get(s : MathapproxrationalTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_approx_rational_table_set(s : MathapproxrationalTable, i : Int, v : Double) -> MathapproxrationalTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_approx_rational_table_sum(s : MathapproxrationalTable) -> Double { @_common.sum(s.data) }

pub fn math_approx_rational_table_mean(s : MathapproxrationalTable) -> Double { @_common.mean(s.data) }

pub fn math_approx_rational_table_scale(s : MathapproxrationalTable, f : Double) -> MathapproxrationalTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_approx_rational_table_add(a : MathapproxrationalTable, b : MathapproxrationalTable) -> MathapproxrationalTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_approx_rational_table_copy(s : MathapproxrationalTable) -> MathapproxrationalTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_approx_rational_table_fill(s : MathapproxrationalTable, v : Double) -> MathapproxrationalTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_approx_rational_table_min(s : MathapproxrationalTable) -> Double { @_common.min(s.data) }

pub fn math_approx_rational_table_max(s : MathapproxrationalTable) -> Double { @_common.max(s.data) }

pub fn math_approx_rational_table_to_string(s : MathapproxrationalTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathapproxrationalGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_approx_rational_graphn_make(size : Int) -> MathapproxrationalGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_approx_rational_graphn_len(s : MathapproxrationalGraphN) -> Int { s.size }

pub fn math_approx_rational_graphn_get(s : MathapproxrationalGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_approx_rational_graphn_set(s : MathapproxrationalGraphN, i : Int, v : Double) -> MathapproxrationalGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_approx_rational_graphn_sum(s : MathapproxrationalGraphN) -> Double { @_common.sum(s.data) }

pub fn math_approx_rational_graphn_mean(s : MathapproxrationalGraphN) -> Double { @_common.mean(s.data) }

pub fn math_approx_rational_graphn_scale(s : MathapproxrationalGraphN, f : Double) -> MathapproxrationalGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_approx_rational_graphn_add(a : MathapproxrationalGraphN, b : MathapproxrationalGraphN) -> MathapproxrationalGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_approx_rational_graphn_copy(s : MathapproxrationalGraphN) -> MathapproxrationalGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_approx_rational_graphn_fill(s : MathapproxrationalGraphN, v : Double) -> MathapproxrationalGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_approx_rational_graphn_min(s : MathapproxrationalGraphN) -> Double { @_common.min(s.data) }

pub fn math_approx_rational_graphn_max(s : MathapproxrationalGraphN) -> Double { @_common.max(s.data) }

pub fn math_approx_rational_graphn_to_string(s : MathapproxrationalGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathapproxrationalNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_approx_rational_node_make(size : Int) -> MathapproxrationalNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_approx_rational_node_len(s : MathapproxrationalNode) -> Int { s.size }

pub fn math_approx_rational_node_get(s : MathapproxrationalNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_approx_rational_node_set(s : MathapproxrationalNode, i : Int, v : Double) -> MathapproxrationalNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_approx_rational_node_sum(s : MathapproxrationalNode) -> Double { @_common.sum(s.data) }

pub fn math_approx_rational_node_mean(s : MathapproxrationalNode) -> Double { @_common.mean(s.data) }

pub fn math_approx_rational_node_scale(s : MathapproxrationalNode, f : Double) -> MathapproxrationalNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_approx_rational_node_add(a : MathapproxrationalNode, b : MathapproxrationalNode) -> MathapproxrationalNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_approx_rational_node_copy(s : MathapproxrationalNode) -> MathapproxrationalNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_approx_rational_node_fill(s : MathapproxrationalNode, v : Double) -> MathapproxrationalNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_approx_rational_node_min(s : MathapproxrationalNode) -> Double { @_common.min(s.data) }

pub fn math_approx_rational_node_max(s : MathapproxrationalNode) -> Double { @_common.max(s.data) }

pub fn math_approx_rational_node_to_string(s : MathapproxrationalNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathapproxrationalEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_approx_rational_edge_make(size : Int) -> MathapproxrationalEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_approx_rational_edge_len(s : MathapproxrationalEdge) -> Int { s.size }

pub fn math_approx_rational_edge_get(s : MathapproxrationalEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_approx_rational_edge_set(s : MathapproxrationalEdge, i : Int, v : Double) -> MathapproxrationalEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_approx_rational_edge_sum(s : MathapproxrationalEdge) -> Double { @_common.sum(s.data) }

pub fn math_approx_rational_edge_mean(s : MathapproxrationalEdge) -> Double { @_common.mean(s.data) }

pub fn math_approx_rational_edge_scale(s : MathapproxrationalEdge, f : Double) -> MathapproxrationalEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_approx_rational_edge_add(a : MathapproxrationalEdge, b : MathapproxrationalEdge) -> MathapproxrationalEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_approx_rational_edge_copy(s : MathapproxrationalEdge) -> MathapproxrationalEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_approx_rational_edge_fill(s : MathapproxrationalEdge, v : Double) -> MathapproxrationalEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_approx_rational_edge_min(s : MathapproxrationalEdge) -> Double { @_common.min(s.data) }

pub fn math_approx_rational_edge_max(s : MathapproxrationalEdge) -> Double { @_common.max(s.data) }

pub fn math_approx_rational_edge_to_string(s : MathapproxrationalEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathapproxrationalPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_approx_rational_path_make(size : Int) -> MathapproxrationalPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_approx_rational_path_len(s : MathapproxrationalPath) -> Int { s.size }

pub fn math_approx_rational_path_get(s : MathapproxrationalPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_approx_rational_path_set(s : MathapproxrationalPath, i : Int, v : Double) -> MathapproxrationalPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_approx_rational_path_sum(s : MathapproxrationalPath) -> Double { @_common.sum(s.data) }

pub fn math_approx_rational_path_mean(s : MathapproxrationalPath) -> Double { @_common.mean(s.data) }

pub fn math_approx_rational_path_scale(s : MathapproxrationalPath, f : Double) -> MathapproxrationalPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_approx_rational_path_add(a : MathapproxrationalPath, b : MathapproxrationalPath) -> MathapproxrationalPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_approx_rational_path_copy(s : MathapproxrationalPath) -> MathapproxrationalPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_approx_rational_path_fill(s : MathapproxrationalPath, v : Double) -> MathapproxrationalPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_approx_rational_path_min(s : MathapproxrationalPath) -> Double { @_common.min(s.data) }

pub fn math_approx_rational_path_max(s : MathapproxrationalPath) -> Double { @_common.max(s.data) }

pub fn math_approx_rational_path_to_string(s : MathapproxrationalPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathapproxrationalCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_approx_rational_cluster_make(size : Int) -> MathapproxrationalCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_approx_rational_cluster_len(s : MathapproxrationalCluster) -> Int { s.size }

pub fn math_approx_rational_cluster_get(s : MathapproxrationalCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_approx_rational_cluster_set(s : MathapproxrationalCluster, i : Int, v : Double) -> MathapproxrationalCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_approx_rational_cluster_sum(s : MathapproxrationalCluster) -> Double { @_common.sum(s.data) }

pub fn math_approx_rational_cluster_mean(s : MathapproxrationalCluster) -> Double { @_common.mean(s.data) }

pub fn math_approx_rational_cluster_scale(s : MathapproxrationalCluster, f : Double) -> MathapproxrationalCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_approx_rational_cluster_add(a : MathapproxrationalCluster, b : MathapproxrationalCluster) -> MathapproxrationalCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_approx_rational_cluster_copy(s : MathapproxrationalCluster) -> MathapproxrationalCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_approx_rational_cluster_fill(s : MathapproxrationalCluster, v : Double) -> MathapproxrationalCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_approx_rational_cluster_min(s : MathapproxrationalCluster) -> Double { @_common.min(s.data) }

pub fn math_approx_rational_cluster_max(s : MathapproxrationalCluster) -> Double { @_common.max(s.data) }

pub fn math_approx_rational_cluster_to_string(s : MathapproxrationalCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathapproxrationalModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_approx_rational_model_make(size : Int) -> MathapproxrationalModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_approx_rational_model_len(s : MathapproxrationalModel) -> Int { s.size }

pub fn math_approx_rational_model_get(s : MathapproxrationalModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_approx_rational_model_set(s : MathapproxrationalModel, i : Int, v : Double) -> MathapproxrationalModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_approx_rational_model_sum(s : MathapproxrationalModel) -> Double { @_common.sum(s.data) }

pub fn math_approx_rational_model_mean(s : MathapproxrationalModel) -> Double { @_common.mean(s.data) }

pub fn math_approx_rational_model_scale(s : MathapproxrationalModel, f : Double) -> MathapproxrationalModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_approx_rational_model_add(a : MathapproxrationalModel, b : MathapproxrationalModel) -> MathapproxrationalModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_approx_rational_model_copy(s : MathapproxrationalModel) -> MathapproxrationalModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_approx_rational_model_fill(s : MathapproxrationalModel, v : Double) -> MathapproxrationalModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_approx_rational_model_min(s : MathapproxrationalModel) -> Double { @_common.min(s.data) }

pub fn math_approx_rational_model_max(s : MathapproxrationalModel) -> Double { @_common.max(s.data) }

pub fn math_approx_rational_model_to_string(s : MathapproxrationalModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathapproxrationalLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_approx_rational_layer_make(size : Int) -> MathapproxrationalLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_approx_rational_layer_len(s : MathapproxrationalLayer) -> Int { s.size }

pub fn math_approx_rational_layer_get(s : MathapproxrationalLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_approx_rational_layer_set(s : MathapproxrationalLayer, i : Int, v : Double) -> MathapproxrationalLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_approx_rational_layer_sum(s : MathapproxrationalLayer) -> Double { @_common.sum(s.data) }

pub fn math_approx_rational_layer_mean(s : MathapproxrationalLayer) -> Double { @_common.mean(s.data) }

pub fn math_approx_rational_layer_scale(s : MathapproxrationalLayer, f : Double) -> MathapproxrationalLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_approx_rational_layer_add(a : MathapproxrationalLayer, b : MathapproxrationalLayer) -> MathapproxrationalLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_approx_rational_layer_copy(s : MathapproxrationalLayer) -> MathapproxrationalLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_approx_rational_layer_fill(s : MathapproxrationalLayer, v : Double) -> MathapproxrationalLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_approx_rational_layer_min(s : MathapproxrationalLayer) -> Double { @_common.min(s.data) }

pub fn math_approx_rational_layer_max(s : MathapproxrationalLayer) -> Double { @_common.max(s.data) }

pub fn math_approx_rational_layer_to_string(s : MathapproxrationalLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathapproxrationalBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_approx_rational_buffer_make(size : Int) -> MathapproxrationalBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_approx_rational_buffer_len(s : MathapproxrationalBuffer) -> Int { s.size }

pub fn math_approx_rational_buffer_get(s : MathapproxrationalBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_approx_rational_buffer_set(s : MathapproxrationalBuffer, i : Int, v : Double) -> MathapproxrationalBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_approx_rational_buffer_sum(s : MathapproxrationalBuffer) -> Double { @_common.sum(s.data) }

pub fn math_approx_rational_buffer_mean(s : MathapproxrationalBuffer) -> Double { @_common.mean(s.data) }

pub fn math_approx_rational_buffer_scale(s : MathapproxrationalBuffer, f : Double) -> MathapproxrationalBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_approx_rational_buffer_add(a : MathapproxrationalBuffer, b : MathapproxrationalBuffer) -> MathapproxrationalBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_approx_rational_buffer_copy(s : MathapproxrationalBuffer) -> MathapproxrationalBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_approx_rational_buffer_fill(s : MathapproxrationalBuffer, v : Double) -> MathapproxrationalBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_approx_rational_buffer_min(s : MathapproxrationalBuffer) -> Double { @_common.min(s.data) }

pub fn math_approx_rational_buffer_max(s : MathapproxrationalBuffer) -> Double { @_common.max(s.data) }

pub fn math_approx_rational_buffer_to_string(s : MathapproxrationalBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathapproxrationalCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_approx_rational_cursor_make(size : Int) -> MathapproxrationalCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_approx_rational_cursor_len(s : MathapproxrationalCursor) -> Int { s.size }

pub fn math_approx_rational_cursor_get(s : MathapproxrationalCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_approx_rational_cursor_set(s : MathapproxrationalCursor, i : Int, v : Double) -> MathapproxrationalCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_approx_rational_cursor_sum(s : MathapproxrationalCursor) -> Double { @_common.sum(s.data) }

pub fn math_approx_rational_cursor_mean(s : MathapproxrationalCursor) -> Double { @_common.mean(s.data) }

pub fn math_approx_rational_cursor_scale(s : MathapproxrationalCursor, f : Double) -> MathapproxrationalCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_approx_rational_cursor_add(a : MathapproxrationalCursor, b : MathapproxrationalCursor) -> MathapproxrationalCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_approx_rational_cursor_copy(s : MathapproxrationalCursor) -> MathapproxrationalCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_approx_rational_cursor_fill(s : MathapproxrationalCursor, v : Double) -> MathapproxrationalCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_approx_rational_cursor_min(s : MathapproxrationalCursor) -> Double { @_common.min(s.data) }

pub fn math_approx_rational_cursor_max(s : MathapproxrationalCursor) -> Double { @_common.max(s.data) }

pub fn math_approx_rational_cursor_to_string(s : MathapproxrationalCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathapproxrationalView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_approx_rational_view_make(size : Int) -> MathapproxrationalView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_approx_rational_view_len(s : MathapproxrationalView) -> Int { s.size }

pub fn math_approx_rational_view_get(s : MathapproxrationalView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_approx_rational_view_set(s : MathapproxrationalView, i : Int, v : Double) -> MathapproxrationalView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_approx_rational_view_sum(s : MathapproxrationalView) -> Double { @_common.sum(s.data) }

pub fn math_approx_rational_view_mean(s : MathapproxrationalView) -> Double { @_common.mean(s.data) }

pub fn math_approx_rational_view_scale(s : MathapproxrationalView, f : Double) -> MathapproxrationalView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_approx_rational_view_add(a : MathapproxrationalView, b : MathapproxrationalView) -> MathapproxrationalView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_approx_rational_view_copy(s : MathapproxrationalView) -> MathapproxrationalView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_approx_rational_view_fill(s : MathapproxrationalView, v : Double) -> MathapproxrationalView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_approx_rational_view_min(s : MathapproxrationalView) -> Double { @_common.min(s.data) }

pub fn math_approx_rational_view_max(s : MathapproxrationalView) -> Double { @_common.max(s.data) }

pub fn math_approx_rational_view_to_string(s : MathapproxrationalView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathapproxrationalRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_approx_rational_range_make(size : Int) -> MathapproxrationalRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_approx_rational_range_len(s : MathapproxrationalRange) -> Int { s.size }

pub fn math_approx_rational_range_get(s : MathapproxrationalRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_approx_rational_range_set(s : MathapproxrationalRange, i : Int, v : Double) -> MathapproxrationalRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_approx_rational_range_sum(s : MathapproxrationalRange) -> Double { @_common.sum(s.data) }

pub fn math_approx_rational_range_mean(s : MathapproxrationalRange) -> Double { @_common.mean(s.data) }

pub fn math_approx_rational_range_scale(s : MathapproxrationalRange, f : Double) -> MathapproxrationalRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_approx_rational_range_add(a : MathapproxrationalRange, b : MathapproxrationalRange) -> MathapproxrationalRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_approx_rational_range_copy(s : MathapproxrationalRange) -> MathapproxrationalRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_approx_rational_range_fill(s : MathapproxrationalRange, v : Double) -> MathapproxrationalRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_approx_rational_range_min(s : MathapproxrationalRange) -> Double { @_common.min(s.data) }

pub fn math_approx_rational_range_max(s : MathapproxrationalRange) -> Double { @_common.max(s.data) }

pub fn math_approx_rational_range_to_string(s : MathapproxrationalRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathapproxrationalSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_approx_rational_slice_make(size : Int) -> MathapproxrationalSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_approx_rational_slice_len(s : MathapproxrationalSlice) -> Int { s.size }

pub fn math_approx_rational_slice_get(s : MathapproxrationalSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_approx_rational_slice_set(s : MathapproxrationalSlice, i : Int, v : Double) -> MathapproxrationalSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_approx_rational_slice_sum(s : MathapproxrationalSlice) -> Double { @_common.sum(s.data) }

pub fn math_approx_rational_slice_mean(s : MathapproxrationalSlice) -> Double { @_common.mean(s.data) }

pub fn math_approx_rational_slice_scale(s : MathapproxrationalSlice, f : Double) -> MathapproxrationalSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_approx_rational_slice_add(a : MathapproxrationalSlice, b : MathapproxrationalSlice) -> MathapproxrationalSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_approx_rational_slice_copy(s : MathapproxrationalSlice) -> MathapproxrationalSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_approx_rational_slice_fill(s : MathapproxrationalSlice, v : Double) -> MathapproxrationalSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_approx_rational_slice_min(s : MathapproxrationalSlice) -> Double { @_common.min(s.data) }

pub fn math_approx_rational_slice_max(s : MathapproxrationalSlice) -> Double { @_common.max(s.data) }

pub fn math_approx_rational_slice_to_string(s : MathapproxrationalSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

