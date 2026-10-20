///===
/// extcore/math_approx_chebyshev

pub(all) struct MathapproxchebyshevPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn math_approx_chebyshev_make_point(x : Double, y : Double) -> MathapproxchebyshevPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn math_approx_chebyshev_make_point3(x : Double, y : Double, z : Double) -> MathapproxchebyshevPoint {
  { x, y, z, label: 0 }
}

pub fn MathapproxchebyshevPoint::x(self : MathapproxchebyshevPoint) -> Double { self.x }

pub fn MathapproxchebyshevPoint::y(self : MathapproxchebyshevPoint) -> Double { self.y }

pub fn MathapproxchebyshevPoint::z(self : MathapproxchebyshevPoint) -> Double { self.z }

pub fn MathapproxchebyshevPoint::label(self : MathapproxchebyshevPoint) -> Int { self.label }

pub fn MathapproxchebyshevPoint::dist(self : MathapproxchebyshevPoint, other : MathapproxchebyshevPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn MathapproxchebyshevPoint::add(self : MathapproxchebyshevPoint, other : MathapproxchebyshevPoint) -> MathapproxchebyshevPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn MathapproxchebyshevPoint::sub(self : MathapproxchebyshevPoint, other : MathapproxchebyshevPoint) -> MathapproxchebyshevPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn MathapproxchebyshevPoint::scale(self : MathapproxchebyshevPoint, s : Double) -> MathapproxchebyshevPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn MathapproxchebyshevPoint::dot(self : MathapproxchebyshevPoint, other : MathapproxchebyshevPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn MathapproxchebyshevPoint::cross(self : MathapproxchebyshevPoint, other : MathapproxchebyshevPoint) -> MathapproxchebyshevPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn MathapproxchebyshevPoint::norm(self : MathapproxchebyshevPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn MathapproxchebyshevPoint::normalize(self : MathapproxchebyshevPoint) -> MathapproxchebyshevPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn MathapproxchebyshevPoint::negate(self : MathapproxchebyshevPoint) -> MathapproxchebyshevPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn MathapproxchebyshevPoint::mid(self : MathapproxchebyshevPoint, other : MathapproxchebyshevPoint) -> MathapproxchebyshevPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn MathapproxchebyshevPoint::lerp(self : MathapproxchebyshevPoint, other : MathapproxchebyshevPoint, t : Double) -> MathapproxchebyshevPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn MathapproxchebyshevPoint::to_string(self : MathapproxchebyshevPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct MathapproxchebyshevSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn math_approx_chebyshev_make_series(vals : Array[Double], name : String) -> MathapproxchebyshevSeries {
  { vals, name, meta: 0 }
}

pub fn MathapproxchebyshevSeries::len(self : MathapproxchebyshevSeries) -> Int { self.vals.length() }

pub fn MathapproxchebyshevSeries::sum(self : MathapproxchebyshevSeries) -> Double { @_common.sum(self.vals) }

pub fn MathapproxchebyshevSeries::mean(self : MathapproxchebyshevSeries) -> Double { @_common.mean(self.vals) }

pub fn MathapproxchebyshevSeries::min(self : MathapproxchebyshevSeries) -> Double { @_common.min(self.vals) }

pub fn MathapproxchebyshevSeries::max(self : MathapproxchebyshevSeries) -> Double { @_common.max(self.vals) }

pub fn MathapproxchebyshevSeries::range(self : MathapproxchebyshevSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn MathapproxchebyshevSeries::variance(self : MathapproxchebyshevSeries) -> Double { @_common.variance(self.vals) }

pub fn MathapproxchebyshevSeries::std(self : MathapproxchebyshevSeries) -> Double { @_common.std(self.vals) }

pub fn MathapproxchebyshevSeries::median(self : MathapproxchebyshevSeries) -> Double { @_common.median(self.vals) }

pub fn MathapproxchebyshevSeries::scale(self : MathapproxchebyshevSeries, f : Double) -> MathapproxchebyshevSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn MathapproxchebyshevSeries::add(self : MathapproxchebyshevSeries, other : MathapproxchebyshevSeries) -> MathapproxchebyshevSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn MathapproxchebyshevSeries::sub(self : MathapproxchebyshevSeries, other : MathapproxchebyshevSeries) -> MathapproxchebyshevSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn MathapproxchebyshevSeries::normalize(self : MathapproxchebyshevSeries) -> MathapproxchebyshevSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn MathapproxchebyshevSeries::cumsum(self : MathapproxchebyshevSeries) -> MathapproxchebyshevSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn MathapproxchebyshevSeries::to_string(self : MathapproxchebyshevSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct MathapproxchebyshevMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn math_approx_chebyshev_make_matrix(rows : Int, cols : Int, val : Double) -> MathapproxchebyshevMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn math_approx_chebyshev_matrix_identity(n : Int) -> MathapproxchebyshevMatrix {
  let m = math_approx_chebyshev_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn MathapproxchebyshevMatrix::get(self : MathapproxchebyshevMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn MathapproxchebyshevMatrix::transpose(self : MathapproxchebyshevMatrix) -> MathapproxchebyshevMatrix {
  let result = math_approx_chebyshev_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn MathapproxchebyshevMatrix::add(self : MathapproxchebyshevMatrix, other : MathapproxchebyshevMatrix) -> MathapproxchebyshevMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = math_approx_chebyshev_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn MathapproxchebyshevMatrix::scale(self : MathapproxchebyshevMatrix, s : Double) -> MathapproxchebyshevMatrix {
  let result = math_approx_chebyshev_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn MathapproxchebyshevMatrix::multiply(self : MathapproxchebyshevMatrix, other : MathapproxchebyshevMatrix) -> MathapproxchebyshevMatrix {
  if self.cols != other.rows { return math_approx_chebyshev_make_matrix(self.rows, other.cols, 0.0) }
  let result = math_approx_chebyshev_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn MathapproxchebyshevMatrix::trace(self : MathapproxchebyshevMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn MathapproxchebyshevMatrix::det(self : MathapproxchebyshevMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn MathapproxchebyshevMatrix::norm(self : MathapproxchebyshevMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn MathapproxchebyshevMatrix::to_string(self : MathapproxchebyshevMatrix) -> String {
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

pub(all) struct MathapproxchebyshevVector {
  comps : Array[Double]
  dim : Int
}

pub fn math_approx_chebyshev_make_vector(comps : Array[Double]) -> MathapproxchebyshevVector {
  { comps, dim: comps.length() }
}

pub fn math_approx_chebyshev_vector_zero(dim : Int) -> MathapproxchebyshevVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn MathapproxchebyshevVector::add(self : MathapproxchebyshevVector, other : MathapproxchebyshevVector) -> MathapproxchebyshevVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn MathapproxchebyshevVector::sub(self : MathapproxchebyshevVector, other : MathapproxchebyshevVector) -> MathapproxchebyshevVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn MathapproxchebyshevVector::scale(self : MathapproxchebyshevVector, s : Double) -> MathapproxchebyshevVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn MathapproxchebyshevVector::dot(self : MathapproxchebyshevVector, other : MathapproxchebyshevVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn MathapproxchebyshevVector::norm(self : MathapproxchebyshevVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn MathapproxchebyshevVector::normalize(self : MathapproxchebyshevVector) -> MathapproxchebyshevVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn MathapproxchebyshevVector::dist(self : MathapproxchebyshevVector, other : MathapproxchebyshevVector) -> Double {
  self.sub(other).norm()
}

pub fn MathapproxchebyshevVector::to_string(self : MathapproxchebyshevVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn math_approx_chebyshev_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn math_approx_chebyshev_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn math_approx_chebyshev_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn math_approx_chebyshev_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn math_approx_chebyshev_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn math_approx_chebyshev_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn math_approx_chebyshev_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn math_approx_chebyshev_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn math_approx_chebyshev_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn math_approx_chebyshev_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn math_approx_chebyshev_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn math_approx_chebyshev_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn math_approx_chebyshev_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn math_approx_chebyshev_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn math_approx_chebyshev_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn math_approx_chebyshev_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn math_approx_chebyshev_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn math_approx_chebyshev_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn math_approx_chebyshev_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn math_approx_chebyshev_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn math_approx_chebyshev_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn math_approx_chebyshev_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn math_approx_chebyshev_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn math_approx_chebyshev_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn math_approx_chebyshev_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn math_approx_chebyshev_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn math_approx_chebyshev_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn math_approx_chebyshev_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn math_approx_chebyshev_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct MathapproxchebyshevFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_approx_chebyshev_frame_make(size : Int) -> MathapproxchebyshevFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_approx_chebyshev_frame_len(s : MathapproxchebyshevFrame) -> Int { s.size }

pub fn math_approx_chebyshev_frame_get(s : MathapproxchebyshevFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_approx_chebyshev_frame_set(s : MathapproxchebyshevFrame, i : Int, v : Double) -> MathapproxchebyshevFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_approx_chebyshev_frame_sum(s : MathapproxchebyshevFrame) -> Double { @_common.sum(s.data) }

pub fn math_approx_chebyshev_frame_mean(s : MathapproxchebyshevFrame) -> Double { @_common.mean(s.data) }

pub fn math_approx_chebyshev_frame_scale(s : MathapproxchebyshevFrame, f : Double) -> MathapproxchebyshevFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_approx_chebyshev_frame_add(a : MathapproxchebyshevFrame, b : MathapproxchebyshevFrame) -> MathapproxchebyshevFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_approx_chebyshev_frame_copy(s : MathapproxchebyshevFrame) -> MathapproxchebyshevFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_approx_chebyshev_frame_fill(s : MathapproxchebyshevFrame, v : Double) -> MathapproxchebyshevFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_approx_chebyshev_frame_min(s : MathapproxchebyshevFrame) -> Double { @_common.min(s.data) }

pub fn math_approx_chebyshev_frame_max(s : MathapproxchebyshevFrame) -> Double { @_common.max(s.data) }

pub fn math_approx_chebyshev_frame_to_string(s : MathapproxchebyshevFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathapproxchebyshevTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_approx_chebyshev_table_make(size : Int) -> MathapproxchebyshevTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_approx_chebyshev_table_len(s : MathapproxchebyshevTable) -> Int { s.size }

pub fn math_approx_chebyshev_table_get(s : MathapproxchebyshevTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_approx_chebyshev_table_set(s : MathapproxchebyshevTable, i : Int, v : Double) -> MathapproxchebyshevTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_approx_chebyshev_table_sum(s : MathapproxchebyshevTable) -> Double { @_common.sum(s.data) }

pub fn math_approx_chebyshev_table_mean(s : MathapproxchebyshevTable) -> Double { @_common.mean(s.data) }

pub fn math_approx_chebyshev_table_scale(s : MathapproxchebyshevTable, f : Double) -> MathapproxchebyshevTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_approx_chebyshev_table_add(a : MathapproxchebyshevTable, b : MathapproxchebyshevTable) -> MathapproxchebyshevTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_approx_chebyshev_table_copy(s : MathapproxchebyshevTable) -> MathapproxchebyshevTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_approx_chebyshev_table_fill(s : MathapproxchebyshevTable, v : Double) -> MathapproxchebyshevTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_approx_chebyshev_table_min(s : MathapproxchebyshevTable) -> Double { @_common.min(s.data) }

pub fn math_approx_chebyshev_table_max(s : MathapproxchebyshevTable) -> Double { @_common.max(s.data) }

pub fn math_approx_chebyshev_table_to_string(s : MathapproxchebyshevTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathapproxchebyshevGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_approx_chebyshev_graphn_make(size : Int) -> MathapproxchebyshevGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_approx_chebyshev_graphn_len(s : MathapproxchebyshevGraphN) -> Int { s.size }

pub fn math_approx_chebyshev_graphn_get(s : MathapproxchebyshevGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_approx_chebyshev_graphn_set(s : MathapproxchebyshevGraphN, i : Int, v : Double) -> MathapproxchebyshevGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_approx_chebyshev_graphn_sum(s : MathapproxchebyshevGraphN) -> Double { @_common.sum(s.data) }

pub fn math_approx_chebyshev_graphn_mean(s : MathapproxchebyshevGraphN) -> Double { @_common.mean(s.data) }

pub fn math_approx_chebyshev_graphn_scale(s : MathapproxchebyshevGraphN, f : Double) -> MathapproxchebyshevGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_approx_chebyshev_graphn_add(a : MathapproxchebyshevGraphN, b : MathapproxchebyshevGraphN) -> MathapproxchebyshevGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_approx_chebyshev_graphn_copy(s : MathapproxchebyshevGraphN) -> MathapproxchebyshevGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_approx_chebyshev_graphn_fill(s : MathapproxchebyshevGraphN, v : Double) -> MathapproxchebyshevGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_approx_chebyshev_graphn_min(s : MathapproxchebyshevGraphN) -> Double { @_common.min(s.data) }

pub fn math_approx_chebyshev_graphn_max(s : MathapproxchebyshevGraphN) -> Double { @_common.max(s.data) }

pub fn math_approx_chebyshev_graphn_to_string(s : MathapproxchebyshevGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathapproxchebyshevNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_approx_chebyshev_node_make(size : Int) -> MathapproxchebyshevNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_approx_chebyshev_node_len(s : MathapproxchebyshevNode) -> Int { s.size }

pub fn math_approx_chebyshev_node_get(s : MathapproxchebyshevNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_approx_chebyshev_node_set(s : MathapproxchebyshevNode, i : Int, v : Double) -> MathapproxchebyshevNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_approx_chebyshev_node_sum(s : MathapproxchebyshevNode) -> Double { @_common.sum(s.data) }

pub fn math_approx_chebyshev_node_mean(s : MathapproxchebyshevNode) -> Double { @_common.mean(s.data) }

pub fn math_approx_chebyshev_node_scale(s : MathapproxchebyshevNode, f : Double) -> MathapproxchebyshevNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_approx_chebyshev_node_add(a : MathapproxchebyshevNode, b : MathapproxchebyshevNode) -> MathapproxchebyshevNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_approx_chebyshev_node_copy(s : MathapproxchebyshevNode) -> MathapproxchebyshevNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_approx_chebyshev_node_fill(s : MathapproxchebyshevNode, v : Double) -> MathapproxchebyshevNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_approx_chebyshev_node_min(s : MathapproxchebyshevNode) -> Double { @_common.min(s.data) }

pub fn math_approx_chebyshev_node_max(s : MathapproxchebyshevNode) -> Double { @_common.max(s.data) }

pub fn math_approx_chebyshev_node_to_string(s : MathapproxchebyshevNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathapproxchebyshevEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_approx_chebyshev_edge_make(size : Int) -> MathapproxchebyshevEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_approx_chebyshev_edge_len(s : MathapproxchebyshevEdge) -> Int { s.size }

pub fn math_approx_chebyshev_edge_get(s : MathapproxchebyshevEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_approx_chebyshev_edge_set(s : MathapproxchebyshevEdge, i : Int, v : Double) -> MathapproxchebyshevEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_approx_chebyshev_edge_sum(s : MathapproxchebyshevEdge) -> Double { @_common.sum(s.data) }

pub fn math_approx_chebyshev_edge_mean(s : MathapproxchebyshevEdge) -> Double { @_common.mean(s.data) }

pub fn math_approx_chebyshev_edge_scale(s : MathapproxchebyshevEdge, f : Double) -> MathapproxchebyshevEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_approx_chebyshev_edge_add(a : MathapproxchebyshevEdge, b : MathapproxchebyshevEdge) -> MathapproxchebyshevEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_approx_chebyshev_edge_copy(s : MathapproxchebyshevEdge) -> MathapproxchebyshevEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_approx_chebyshev_edge_fill(s : MathapproxchebyshevEdge, v : Double) -> MathapproxchebyshevEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_approx_chebyshev_edge_min(s : MathapproxchebyshevEdge) -> Double { @_common.min(s.data) }

pub fn math_approx_chebyshev_edge_max(s : MathapproxchebyshevEdge) -> Double { @_common.max(s.data) }

pub fn math_approx_chebyshev_edge_to_string(s : MathapproxchebyshevEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathapproxchebyshevPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_approx_chebyshev_path_make(size : Int) -> MathapproxchebyshevPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_approx_chebyshev_path_len(s : MathapproxchebyshevPath) -> Int { s.size }

pub fn math_approx_chebyshev_path_get(s : MathapproxchebyshevPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_approx_chebyshev_path_set(s : MathapproxchebyshevPath, i : Int, v : Double) -> MathapproxchebyshevPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_approx_chebyshev_path_sum(s : MathapproxchebyshevPath) -> Double { @_common.sum(s.data) }

pub fn math_approx_chebyshev_path_mean(s : MathapproxchebyshevPath) -> Double { @_common.mean(s.data) }

pub fn math_approx_chebyshev_path_scale(s : MathapproxchebyshevPath, f : Double) -> MathapproxchebyshevPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_approx_chebyshev_path_add(a : MathapproxchebyshevPath, b : MathapproxchebyshevPath) -> MathapproxchebyshevPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_approx_chebyshev_path_copy(s : MathapproxchebyshevPath) -> MathapproxchebyshevPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_approx_chebyshev_path_fill(s : MathapproxchebyshevPath, v : Double) -> MathapproxchebyshevPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_approx_chebyshev_path_min(s : MathapproxchebyshevPath) -> Double { @_common.min(s.data) }

pub fn math_approx_chebyshev_path_max(s : MathapproxchebyshevPath) -> Double { @_common.max(s.data) }

pub fn math_approx_chebyshev_path_to_string(s : MathapproxchebyshevPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathapproxchebyshevCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_approx_chebyshev_cluster_make(size : Int) -> MathapproxchebyshevCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_approx_chebyshev_cluster_len(s : MathapproxchebyshevCluster) -> Int { s.size }

pub fn math_approx_chebyshev_cluster_get(s : MathapproxchebyshevCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_approx_chebyshev_cluster_set(s : MathapproxchebyshevCluster, i : Int, v : Double) -> MathapproxchebyshevCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_approx_chebyshev_cluster_sum(s : MathapproxchebyshevCluster) -> Double { @_common.sum(s.data) }

pub fn math_approx_chebyshev_cluster_mean(s : MathapproxchebyshevCluster) -> Double { @_common.mean(s.data) }

pub fn math_approx_chebyshev_cluster_scale(s : MathapproxchebyshevCluster, f : Double) -> MathapproxchebyshevCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_approx_chebyshev_cluster_add(a : MathapproxchebyshevCluster, b : MathapproxchebyshevCluster) -> MathapproxchebyshevCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_approx_chebyshev_cluster_copy(s : MathapproxchebyshevCluster) -> MathapproxchebyshevCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_approx_chebyshev_cluster_fill(s : MathapproxchebyshevCluster, v : Double) -> MathapproxchebyshevCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_approx_chebyshev_cluster_min(s : MathapproxchebyshevCluster) -> Double { @_common.min(s.data) }

pub fn math_approx_chebyshev_cluster_max(s : MathapproxchebyshevCluster) -> Double { @_common.max(s.data) }

pub fn math_approx_chebyshev_cluster_to_string(s : MathapproxchebyshevCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathapproxchebyshevModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_approx_chebyshev_model_make(size : Int) -> MathapproxchebyshevModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_approx_chebyshev_model_len(s : MathapproxchebyshevModel) -> Int { s.size }

pub fn math_approx_chebyshev_model_get(s : MathapproxchebyshevModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_approx_chebyshev_model_set(s : MathapproxchebyshevModel, i : Int, v : Double) -> MathapproxchebyshevModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_approx_chebyshev_model_sum(s : MathapproxchebyshevModel) -> Double { @_common.sum(s.data) }

pub fn math_approx_chebyshev_model_mean(s : MathapproxchebyshevModel) -> Double { @_common.mean(s.data) }

pub fn math_approx_chebyshev_model_scale(s : MathapproxchebyshevModel, f : Double) -> MathapproxchebyshevModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_approx_chebyshev_model_add(a : MathapproxchebyshevModel, b : MathapproxchebyshevModel) -> MathapproxchebyshevModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_approx_chebyshev_model_copy(s : MathapproxchebyshevModel) -> MathapproxchebyshevModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_approx_chebyshev_model_fill(s : MathapproxchebyshevModel, v : Double) -> MathapproxchebyshevModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_approx_chebyshev_model_min(s : MathapproxchebyshevModel) -> Double { @_common.min(s.data) }

pub fn math_approx_chebyshev_model_max(s : MathapproxchebyshevModel) -> Double { @_common.max(s.data) }

pub fn math_approx_chebyshev_model_to_string(s : MathapproxchebyshevModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathapproxchebyshevLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_approx_chebyshev_layer_make(size : Int) -> MathapproxchebyshevLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_approx_chebyshev_layer_len(s : MathapproxchebyshevLayer) -> Int { s.size }

pub fn math_approx_chebyshev_layer_get(s : MathapproxchebyshevLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_approx_chebyshev_layer_set(s : MathapproxchebyshevLayer, i : Int, v : Double) -> MathapproxchebyshevLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_approx_chebyshev_layer_sum(s : MathapproxchebyshevLayer) -> Double { @_common.sum(s.data) }

pub fn math_approx_chebyshev_layer_mean(s : MathapproxchebyshevLayer) -> Double { @_common.mean(s.data) }

pub fn math_approx_chebyshev_layer_scale(s : MathapproxchebyshevLayer, f : Double) -> MathapproxchebyshevLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_approx_chebyshev_layer_add(a : MathapproxchebyshevLayer, b : MathapproxchebyshevLayer) -> MathapproxchebyshevLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_approx_chebyshev_layer_copy(s : MathapproxchebyshevLayer) -> MathapproxchebyshevLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_approx_chebyshev_layer_fill(s : MathapproxchebyshevLayer, v : Double) -> MathapproxchebyshevLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_approx_chebyshev_layer_min(s : MathapproxchebyshevLayer) -> Double { @_common.min(s.data) }

pub fn math_approx_chebyshev_layer_max(s : MathapproxchebyshevLayer) -> Double { @_common.max(s.data) }

pub fn math_approx_chebyshev_layer_to_string(s : MathapproxchebyshevLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathapproxchebyshevBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_approx_chebyshev_buffer_make(size : Int) -> MathapproxchebyshevBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_approx_chebyshev_buffer_len(s : MathapproxchebyshevBuffer) -> Int { s.size }

pub fn math_approx_chebyshev_buffer_get(s : MathapproxchebyshevBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_approx_chebyshev_buffer_set(s : MathapproxchebyshevBuffer, i : Int, v : Double) -> MathapproxchebyshevBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_approx_chebyshev_buffer_sum(s : MathapproxchebyshevBuffer) -> Double { @_common.sum(s.data) }

pub fn math_approx_chebyshev_buffer_mean(s : MathapproxchebyshevBuffer) -> Double { @_common.mean(s.data) }

pub fn math_approx_chebyshev_buffer_scale(s : MathapproxchebyshevBuffer, f : Double) -> MathapproxchebyshevBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_approx_chebyshev_buffer_add(a : MathapproxchebyshevBuffer, b : MathapproxchebyshevBuffer) -> MathapproxchebyshevBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_approx_chebyshev_buffer_copy(s : MathapproxchebyshevBuffer) -> MathapproxchebyshevBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_approx_chebyshev_buffer_fill(s : MathapproxchebyshevBuffer, v : Double) -> MathapproxchebyshevBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_approx_chebyshev_buffer_min(s : MathapproxchebyshevBuffer) -> Double { @_common.min(s.data) }

pub fn math_approx_chebyshev_buffer_max(s : MathapproxchebyshevBuffer) -> Double { @_common.max(s.data) }

pub fn math_approx_chebyshev_buffer_to_string(s : MathapproxchebyshevBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathapproxchebyshevCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_approx_chebyshev_cursor_make(size : Int) -> MathapproxchebyshevCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_approx_chebyshev_cursor_len(s : MathapproxchebyshevCursor) -> Int { s.size }

pub fn math_approx_chebyshev_cursor_get(s : MathapproxchebyshevCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_approx_chebyshev_cursor_set(s : MathapproxchebyshevCursor, i : Int, v : Double) -> MathapproxchebyshevCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_approx_chebyshev_cursor_sum(s : MathapproxchebyshevCursor) -> Double { @_common.sum(s.data) }

pub fn math_approx_chebyshev_cursor_mean(s : MathapproxchebyshevCursor) -> Double { @_common.mean(s.data) }

pub fn math_approx_chebyshev_cursor_scale(s : MathapproxchebyshevCursor, f : Double) -> MathapproxchebyshevCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_approx_chebyshev_cursor_add(a : MathapproxchebyshevCursor, b : MathapproxchebyshevCursor) -> MathapproxchebyshevCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_approx_chebyshev_cursor_copy(s : MathapproxchebyshevCursor) -> MathapproxchebyshevCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_approx_chebyshev_cursor_fill(s : MathapproxchebyshevCursor, v : Double) -> MathapproxchebyshevCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_approx_chebyshev_cursor_min(s : MathapproxchebyshevCursor) -> Double { @_common.min(s.data) }

pub fn math_approx_chebyshev_cursor_max(s : MathapproxchebyshevCursor) -> Double { @_common.max(s.data) }

pub fn math_approx_chebyshev_cursor_to_string(s : MathapproxchebyshevCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathapproxchebyshevView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_approx_chebyshev_view_make(size : Int) -> MathapproxchebyshevView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_approx_chebyshev_view_len(s : MathapproxchebyshevView) -> Int { s.size }

pub fn math_approx_chebyshev_view_get(s : MathapproxchebyshevView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_approx_chebyshev_view_set(s : MathapproxchebyshevView, i : Int, v : Double) -> MathapproxchebyshevView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_approx_chebyshev_view_sum(s : MathapproxchebyshevView) -> Double { @_common.sum(s.data) }

pub fn math_approx_chebyshev_view_mean(s : MathapproxchebyshevView) -> Double { @_common.mean(s.data) }

pub fn math_approx_chebyshev_view_scale(s : MathapproxchebyshevView, f : Double) -> MathapproxchebyshevView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_approx_chebyshev_view_add(a : MathapproxchebyshevView, b : MathapproxchebyshevView) -> MathapproxchebyshevView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_approx_chebyshev_view_copy(s : MathapproxchebyshevView) -> MathapproxchebyshevView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_approx_chebyshev_view_fill(s : MathapproxchebyshevView, v : Double) -> MathapproxchebyshevView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_approx_chebyshev_view_min(s : MathapproxchebyshevView) -> Double { @_common.min(s.data) }

pub fn math_approx_chebyshev_view_max(s : MathapproxchebyshevView) -> Double { @_common.max(s.data) }

pub fn math_approx_chebyshev_view_to_string(s : MathapproxchebyshevView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathapproxchebyshevRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_approx_chebyshev_range_make(size : Int) -> MathapproxchebyshevRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_approx_chebyshev_range_len(s : MathapproxchebyshevRange) -> Int { s.size }

pub fn math_approx_chebyshev_range_get(s : MathapproxchebyshevRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_approx_chebyshev_range_set(s : MathapproxchebyshevRange, i : Int, v : Double) -> MathapproxchebyshevRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_approx_chebyshev_range_sum(s : MathapproxchebyshevRange) -> Double { @_common.sum(s.data) }

pub fn math_approx_chebyshev_range_mean(s : MathapproxchebyshevRange) -> Double { @_common.mean(s.data) }

pub fn math_approx_chebyshev_range_scale(s : MathapproxchebyshevRange, f : Double) -> MathapproxchebyshevRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_approx_chebyshev_range_add(a : MathapproxchebyshevRange, b : MathapproxchebyshevRange) -> MathapproxchebyshevRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_approx_chebyshev_range_copy(s : MathapproxchebyshevRange) -> MathapproxchebyshevRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_approx_chebyshev_range_fill(s : MathapproxchebyshevRange, v : Double) -> MathapproxchebyshevRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_approx_chebyshev_range_min(s : MathapproxchebyshevRange) -> Double { @_common.min(s.data) }

pub fn math_approx_chebyshev_range_max(s : MathapproxchebyshevRange) -> Double { @_common.max(s.data) }

pub fn math_approx_chebyshev_range_to_string(s : MathapproxchebyshevRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathapproxchebyshevSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_approx_chebyshev_slice_make(size : Int) -> MathapproxchebyshevSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_approx_chebyshev_slice_len(s : MathapproxchebyshevSlice) -> Int { s.size }

pub fn math_approx_chebyshev_slice_get(s : MathapproxchebyshevSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_approx_chebyshev_slice_set(s : MathapproxchebyshevSlice, i : Int, v : Double) -> MathapproxchebyshevSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_approx_chebyshev_slice_sum(s : MathapproxchebyshevSlice) -> Double { @_common.sum(s.data) }

pub fn math_approx_chebyshev_slice_mean(s : MathapproxchebyshevSlice) -> Double { @_common.mean(s.data) }

pub fn math_approx_chebyshev_slice_scale(s : MathapproxchebyshevSlice, f : Double) -> MathapproxchebyshevSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_approx_chebyshev_slice_add(a : MathapproxchebyshevSlice, b : MathapproxchebyshevSlice) -> MathapproxchebyshevSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_approx_chebyshev_slice_copy(s : MathapproxchebyshevSlice) -> MathapproxchebyshevSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_approx_chebyshev_slice_fill(s : MathapproxchebyshevSlice, v : Double) -> MathapproxchebyshevSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_approx_chebyshev_slice_min(s : MathapproxchebyshevSlice) -> Double { @_common.min(s.data) }

pub fn math_approx_chebyshev_slice_max(s : MathapproxchebyshevSlice) -> Double { @_common.max(s.data) }

pub fn math_approx_chebyshev_slice_to_string(s : MathapproxchebyshevSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

