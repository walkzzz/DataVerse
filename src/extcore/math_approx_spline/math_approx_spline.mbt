///===
/// extcore/math_approx_spline

pub(all) struct MathapproxsplinePoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn math_approx_spline_make_point(x : Double, y : Double) -> MathapproxsplinePoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn math_approx_spline_make_point3(x : Double, y : Double, z : Double) -> MathapproxsplinePoint {
  { x, y, z, label: 0 }
}

pub fn MathapproxsplinePoint::x(self : MathapproxsplinePoint) -> Double { self.x }

pub fn MathapproxsplinePoint::y(self : MathapproxsplinePoint) -> Double { self.y }

pub fn MathapproxsplinePoint::z(self : MathapproxsplinePoint) -> Double { self.z }

pub fn MathapproxsplinePoint::label(self : MathapproxsplinePoint) -> Int { self.label }

pub fn MathapproxsplinePoint::dist(self : MathapproxsplinePoint, other : MathapproxsplinePoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn MathapproxsplinePoint::add(self : MathapproxsplinePoint, other : MathapproxsplinePoint) -> MathapproxsplinePoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn MathapproxsplinePoint::sub(self : MathapproxsplinePoint, other : MathapproxsplinePoint) -> MathapproxsplinePoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn MathapproxsplinePoint::scale(self : MathapproxsplinePoint, s : Double) -> MathapproxsplinePoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn MathapproxsplinePoint::dot(self : MathapproxsplinePoint, other : MathapproxsplinePoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn MathapproxsplinePoint::cross(self : MathapproxsplinePoint, other : MathapproxsplinePoint) -> MathapproxsplinePoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn MathapproxsplinePoint::norm(self : MathapproxsplinePoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn MathapproxsplinePoint::normalize(self : MathapproxsplinePoint) -> MathapproxsplinePoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn MathapproxsplinePoint::negate(self : MathapproxsplinePoint) -> MathapproxsplinePoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn MathapproxsplinePoint::mid(self : MathapproxsplinePoint, other : MathapproxsplinePoint) -> MathapproxsplinePoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn MathapproxsplinePoint::lerp(self : MathapproxsplinePoint, other : MathapproxsplinePoint, t : Double) -> MathapproxsplinePoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn MathapproxsplinePoint::to_string(self : MathapproxsplinePoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct MathapproxsplineSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn math_approx_spline_make_series(vals : Array[Double], name : String) -> MathapproxsplineSeries {
  { vals, name, meta: 0 }
}

pub fn MathapproxsplineSeries::len(self : MathapproxsplineSeries) -> Int { self.vals.length() }

pub fn MathapproxsplineSeries::sum(self : MathapproxsplineSeries) -> Double { @_common.sum(self.vals) }

pub fn MathapproxsplineSeries::mean(self : MathapproxsplineSeries) -> Double { @_common.mean(self.vals) }

pub fn MathapproxsplineSeries::min(self : MathapproxsplineSeries) -> Double { @_common.min(self.vals) }

pub fn MathapproxsplineSeries::max(self : MathapproxsplineSeries) -> Double { @_common.max(self.vals) }

pub fn MathapproxsplineSeries::range(self : MathapproxsplineSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn MathapproxsplineSeries::variance(self : MathapproxsplineSeries) -> Double { @_common.variance(self.vals) }

pub fn MathapproxsplineSeries::std(self : MathapproxsplineSeries) -> Double { @_common.std(self.vals) }

pub fn MathapproxsplineSeries::median(self : MathapproxsplineSeries) -> Double { @_common.median(self.vals) }

pub fn MathapproxsplineSeries::scale(self : MathapproxsplineSeries, f : Double) -> MathapproxsplineSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn MathapproxsplineSeries::add(self : MathapproxsplineSeries, other : MathapproxsplineSeries) -> MathapproxsplineSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn MathapproxsplineSeries::sub(self : MathapproxsplineSeries, other : MathapproxsplineSeries) -> MathapproxsplineSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn MathapproxsplineSeries::normalize(self : MathapproxsplineSeries) -> MathapproxsplineSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn MathapproxsplineSeries::cumsum(self : MathapproxsplineSeries) -> MathapproxsplineSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn MathapproxsplineSeries::to_string(self : MathapproxsplineSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct MathapproxsplineMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn math_approx_spline_make_matrix(rows : Int, cols : Int, val : Double) -> MathapproxsplineMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn math_approx_spline_matrix_identity(n : Int) -> MathapproxsplineMatrix {
  let m = math_approx_spline_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn MathapproxsplineMatrix::get(self : MathapproxsplineMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn MathapproxsplineMatrix::transpose(self : MathapproxsplineMatrix) -> MathapproxsplineMatrix {
  let result = math_approx_spline_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn MathapproxsplineMatrix::add(self : MathapproxsplineMatrix, other : MathapproxsplineMatrix) -> MathapproxsplineMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = math_approx_spline_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn MathapproxsplineMatrix::scale(self : MathapproxsplineMatrix, s : Double) -> MathapproxsplineMatrix {
  let result = math_approx_spline_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn MathapproxsplineMatrix::multiply(self : MathapproxsplineMatrix, other : MathapproxsplineMatrix) -> MathapproxsplineMatrix {
  if self.cols != other.rows { return math_approx_spline_make_matrix(self.rows, other.cols, 0.0) }
  let result = math_approx_spline_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn MathapproxsplineMatrix::trace(self : MathapproxsplineMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn MathapproxsplineMatrix::det(self : MathapproxsplineMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn MathapproxsplineMatrix::norm(self : MathapproxsplineMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn MathapproxsplineMatrix::to_string(self : MathapproxsplineMatrix) -> String {
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

pub(all) struct MathapproxsplineVector {
  comps : Array[Double]
  dim : Int
}

pub fn math_approx_spline_make_vector(comps : Array[Double]) -> MathapproxsplineVector {
  { comps, dim: comps.length() }
}

pub fn math_approx_spline_vector_zero(dim : Int) -> MathapproxsplineVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn MathapproxsplineVector::add(self : MathapproxsplineVector, other : MathapproxsplineVector) -> MathapproxsplineVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn MathapproxsplineVector::sub(self : MathapproxsplineVector, other : MathapproxsplineVector) -> MathapproxsplineVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn MathapproxsplineVector::scale(self : MathapproxsplineVector, s : Double) -> MathapproxsplineVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn MathapproxsplineVector::dot(self : MathapproxsplineVector, other : MathapproxsplineVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn MathapproxsplineVector::norm(self : MathapproxsplineVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn MathapproxsplineVector::normalize(self : MathapproxsplineVector) -> MathapproxsplineVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn MathapproxsplineVector::dist(self : MathapproxsplineVector, other : MathapproxsplineVector) -> Double {
  self.sub(other).norm()
}

pub fn MathapproxsplineVector::to_string(self : MathapproxsplineVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn math_approx_spline_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn math_approx_spline_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn math_approx_spline_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn math_approx_spline_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn math_approx_spline_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn math_approx_spline_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn math_approx_spline_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn math_approx_spline_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn math_approx_spline_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn math_approx_spline_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn math_approx_spline_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn math_approx_spline_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn math_approx_spline_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn math_approx_spline_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn math_approx_spline_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn math_approx_spline_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn math_approx_spline_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn math_approx_spline_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn math_approx_spline_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn math_approx_spline_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn math_approx_spline_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn math_approx_spline_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn math_approx_spline_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn math_approx_spline_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn math_approx_spline_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn math_approx_spline_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn math_approx_spline_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn math_approx_spline_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn math_approx_spline_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct MathapproxsplineFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_approx_spline_frame_make(size : Int) -> MathapproxsplineFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_approx_spline_frame_len(s : MathapproxsplineFrame) -> Int { s.size }

pub fn math_approx_spline_frame_get(s : MathapproxsplineFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_approx_spline_frame_set(s : MathapproxsplineFrame, i : Int, v : Double) -> MathapproxsplineFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_approx_spline_frame_sum(s : MathapproxsplineFrame) -> Double { @_common.sum(s.data) }

pub fn math_approx_spline_frame_mean(s : MathapproxsplineFrame) -> Double { @_common.mean(s.data) }

pub fn math_approx_spline_frame_scale(s : MathapproxsplineFrame, f : Double) -> MathapproxsplineFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_approx_spline_frame_add(a : MathapproxsplineFrame, b : MathapproxsplineFrame) -> MathapproxsplineFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_approx_spline_frame_copy(s : MathapproxsplineFrame) -> MathapproxsplineFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_approx_spline_frame_fill(s : MathapproxsplineFrame, v : Double) -> MathapproxsplineFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_approx_spline_frame_min(s : MathapproxsplineFrame) -> Double { @_common.min(s.data) }

pub fn math_approx_spline_frame_max(s : MathapproxsplineFrame) -> Double { @_common.max(s.data) }

pub fn math_approx_spline_frame_to_string(s : MathapproxsplineFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathapproxsplineTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_approx_spline_table_make(size : Int) -> MathapproxsplineTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_approx_spline_table_len(s : MathapproxsplineTable) -> Int { s.size }

pub fn math_approx_spline_table_get(s : MathapproxsplineTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_approx_spline_table_set(s : MathapproxsplineTable, i : Int, v : Double) -> MathapproxsplineTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_approx_spline_table_sum(s : MathapproxsplineTable) -> Double { @_common.sum(s.data) }

pub fn math_approx_spline_table_mean(s : MathapproxsplineTable) -> Double { @_common.mean(s.data) }

pub fn math_approx_spline_table_scale(s : MathapproxsplineTable, f : Double) -> MathapproxsplineTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_approx_spline_table_add(a : MathapproxsplineTable, b : MathapproxsplineTable) -> MathapproxsplineTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_approx_spline_table_copy(s : MathapproxsplineTable) -> MathapproxsplineTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_approx_spline_table_fill(s : MathapproxsplineTable, v : Double) -> MathapproxsplineTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_approx_spline_table_min(s : MathapproxsplineTable) -> Double { @_common.min(s.data) }

pub fn math_approx_spline_table_max(s : MathapproxsplineTable) -> Double { @_common.max(s.data) }

pub fn math_approx_spline_table_to_string(s : MathapproxsplineTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathapproxsplineGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_approx_spline_graphn_make(size : Int) -> MathapproxsplineGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_approx_spline_graphn_len(s : MathapproxsplineGraphN) -> Int { s.size }

pub fn math_approx_spline_graphn_get(s : MathapproxsplineGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_approx_spline_graphn_set(s : MathapproxsplineGraphN, i : Int, v : Double) -> MathapproxsplineGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_approx_spline_graphn_sum(s : MathapproxsplineGraphN) -> Double { @_common.sum(s.data) }

pub fn math_approx_spline_graphn_mean(s : MathapproxsplineGraphN) -> Double { @_common.mean(s.data) }

pub fn math_approx_spline_graphn_scale(s : MathapproxsplineGraphN, f : Double) -> MathapproxsplineGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_approx_spline_graphn_add(a : MathapproxsplineGraphN, b : MathapproxsplineGraphN) -> MathapproxsplineGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_approx_spline_graphn_copy(s : MathapproxsplineGraphN) -> MathapproxsplineGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_approx_spline_graphn_fill(s : MathapproxsplineGraphN, v : Double) -> MathapproxsplineGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_approx_spline_graphn_min(s : MathapproxsplineGraphN) -> Double { @_common.min(s.data) }

pub fn math_approx_spline_graphn_max(s : MathapproxsplineGraphN) -> Double { @_common.max(s.data) }

pub fn math_approx_spline_graphn_to_string(s : MathapproxsplineGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathapproxsplineNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_approx_spline_node_make(size : Int) -> MathapproxsplineNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_approx_spline_node_len(s : MathapproxsplineNode) -> Int { s.size }

pub fn math_approx_spline_node_get(s : MathapproxsplineNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_approx_spline_node_set(s : MathapproxsplineNode, i : Int, v : Double) -> MathapproxsplineNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_approx_spline_node_sum(s : MathapproxsplineNode) -> Double { @_common.sum(s.data) }

pub fn math_approx_spline_node_mean(s : MathapproxsplineNode) -> Double { @_common.mean(s.data) }

pub fn math_approx_spline_node_scale(s : MathapproxsplineNode, f : Double) -> MathapproxsplineNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_approx_spline_node_add(a : MathapproxsplineNode, b : MathapproxsplineNode) -> MathapproxsplineNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_approx_spline_node_copy(s : MathapproxsplineNode) -> MathapproxsplineNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_approx_spline_node_fill(s : MathapproxsplineNode, v : Double) -> MathapproxsplineNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_approx_spline_node_min(s : MathapproxsplineNode) -> Double { @_common.min(s.data) }

pub fn math_approx_spline_node_max(s : MathapproxsplineNode) -> Double { @_common.max(s.data) }

pub fn math_approx_spline_node_to_string(s : MathapproxsplineNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathapproxsplineEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_approx_spline_edge_make(size : Int) -> MathapproxsplineEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_approx_spline_edge_len(s : MathapproxsplineEdge) -> Int { s.size }

pub fn math_approx_spline_edge_get(s : MathapproxsplineEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_approx_spline_edge_set(s : MathapproxsplineEdge, i : Int, v : Double) -> MathapproxsplineEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_approx_spline_edge_sum(s : MathapproxsplineEdge) -> Double { @_common.sum(s.data) }

pub fn math_approx_spline_edge_mean(s : MathapproxsplineEdge) -> Double { @_common.mean(s.data) }

pub fn math_approx_spline_edge_scale(s : MathapproxsplineEdge, f : Double) -> MathapproxsplineEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_approx_spline_edge_add(a : MathapproxsplineEdge, b : MathapproxsplineEdge) -> MathapproxsplineEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_approx_spline_edge_copy(s : MathapproxsplineEdge) -> MathapproxsplineEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_approx_spline_edge_fill(s : MathapproxsplineEdge, v : Double) -> MathapproxsplineEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_approx_spline_edge_min(s : MathapproxsplineEdge) -> Double { @_common.min(s.data) }

pub fn math_approx_spline_edge_max(s : MathapproxsplineEdge) -> Double { @_common.max(s.data) }

pub fn math_approx_spline_edge_to_string(s : MathapproxsplineEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathapproxsplinePath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_approx_spline_path_make(size : Int) -> MathapproxsplinePath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_approx_spline_path_len(s : MathapproxsplinePath) -> Int { s.size }

pub fn math_approx_spline_path_get(s : MathapproxsplinePath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_approx_spline_path_set(s : MathapproxsplinePath, i : Int, v : Double) -> MathapproxsplinePath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_approx_spline_path_sum(s : MathapproxsplinePath) -> Double { @_common.sum(s.data) }

pub fn math_approx_spline_path_mean(s : MathapproxsplinePath) -> Double { @_common.mean(s.data) }

pub fn math_approx_spline_path_scale(s : MathapproxsplinePath, f : Double) -> MathapproxsplinePath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_approx_spline_path_add(a : MathapproxsplinePath, b : MathapproxsplinePath) -> MathapproxsplinePath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_approx_spline_path_copy(s : MathapproxsplinePath) -> MathapproxsplinePath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_approx_spline_path_fill(s : MathapproxsplinePath, v : Double) -> MathapproxsplinePath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_approx_spline_path_min(s : MathapproxsplinePath) -> Double { @_common.min(s.data) }

pub fn math_approx_spline_path_max(s : MathapproxsplinePath) -> Double { @_common.max(s.data) }

pub fn math_approx_spline_path_to_string(s : MathapproxsplinePath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathapproxsplineCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_approx_spline_cluster_make(size : Int) -> MathapproxsplineCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_approx_spline_cluster_len(s : MathapproxsplineCluster) -> Int { s.size }

pub fn math_approx_spline_cluster_get(s : MathapproxsplineCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_approx_spline_cluster_set(s : MathapproxsplineCluster, i : Int, v : Double) -> MathapproxsplineCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_approx_spline_cluster_sum(s : MathapproxsplineCluster) -> Double { @_common.sum(s.data) }

pub fn math_approx_spline_cluster_mean(s : MathapproxsplineCluster) -> Double { @_common.mean(s.data) }

pub fn math_approx_spline_cluster_scale(s : MathapproxsplineCluster, f : Double) -> MathapproxsplineCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_approx_spline_cluster_add(a : MathapproxsplineCluster, b : MathapproxsplineCluster) -> MathapproxsplineCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_approx_spline_cluster_copy(s : MathapproxsplineCluster) -> MathapproxsplineCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_approx_spline_cluster_fill(s : MathapproxsplineCluster, v : Double) -> MathapproxsplineCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_approx_spline_cluster_min(s : MathapproxsplineCluster) -> Double { @_common.min(s.data) }

pub fn math_approx_spline_cluster_max(s : MathapproxsplineCluster) -> Double { @_common.max(s.data) }

pub fn math_approx_spline_cluster_to_string(s : MathapproxsplineCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathapproxsplineModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_approx_spline_model_make(size : Int) -> MathapproxsplineModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_approx_spline_model_len(s : MathapproxsplineModel) -> Int { s.size }

pub fn math_approx_spline_model_get(s : MathapproxsplineModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_approx_spline_model_set(s : MathapproxsplineModel, i : Int, v : Double) -> MathapproxsplineModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_approx_spline_model_sum(s : MathapproxsplineModel) -> Double { @_common.sum(s.data) }

pub fn math_approx_spline_model_mean(s : MathapproxsplineModel) -> Double { @_common.mean(s.data) }

pub fn math_approx_spline_model_scale(s : MathapproxsplineModel, f : Double) -> MathapproxsplineModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_approx_spline_model_add(a : MathapproxsplineModel, b : MathapproxsplineModel) -> MathapproxsplineModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_approx_spline_model_copy(s : MathapproxsplineModel) -> MathapproxsplineModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_approx_spline_model_fill(s : MathapproxsplineModel, v : Double) -> MathapproxsplineModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_approx_spline_model_min(s : MathapproxsplineModel) -> Double { @_common.min(s.data) }

pub fn math_approx_spline_model_max(s : MathapproxsplineModel) -> Double { @_common.max(s.data) }

pub fn math_approx_spline_model_to_string(s : MathapproxsplineModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathapproxsplineLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_approx_spline_layer_make(size : Int) -> MathapproxsplineLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_approx_spline_layer_len(s : MathapproxsplineLayer) -> Int { s.size }

pub fn math_approx_spline_layer_get(s : MathapproxsplineLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_approx_spline_layer_set(s : MathapproxsplineLayer, i : Int, v : Double) -> MathapproxsplineLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_approx_spline_layer_sum(s : MathapproxsplineLayer) -> Double { @_common.sum(s.data) }

pub fn math_approx_spline_layer_mean(s : MathapproxsplineLayer) -> Double { @_common.mean(s.data) }

pub fn math_approx_spline_layer_scale(s : MathapproxsplineLayer, f : Double) -> MathapproxsplineLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_approx_spline_layer_add(a : MathapproxsplineLayer, b : MathapproxsplineLayer) -> MathapproxsplineLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_approx_spline_layer_copy(s : MathapproxsplineLayer) -> MathapproxsplineLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_approx_spline_layer_fill(s : MathapproxsplineLayer, v : Double) -> MathapproxsplineLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_approx_spline_layer_min(s : MathapproxsplineLayer) -> Double { @_common.min(s.data) }

pub fn math_approx_spline_layer_max(s : MathapproxsplineLayer) -> Double { @_common.max(s.data) }

pub fn math_approx_spline_layer_to_string(s : MathapproxsplineLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathapproxsplineBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_approx_spline_buffer_make(size : Int) -> MathapproxsplineBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_approx_spline_buffer_len(s : MathapproxsplineBuffer) -> Int { s.size }

pub fn math_approx_spline_buffer_get(s : MathapproxsplineBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_approx_spline_buffer_set(s : MathapproxsplineBuffer, i : Int, v : Double) -> MathapproxsplineBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_approx_spline_buffer_sum(s : MathapproxsplineBuffer) -> Double { @_common.sum(s.data) }

pub fn math_approx_spline_buffer_mean(s : MathapproxsplineBuffer) -> Double { @_common.mean(s.data) }

pub fn math_approx_spline_buffer_scale(s : MathapproxsplineBuffer, f : Double) -> MathapproxsplineBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_approx_spline_buffer_add(a : MathapproxsplineBuffer, b : MathapproxsplineBuffer) -> MathapproxsplineBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_approx_spline_buffer_copy(s : MathapproxsplineBuffer) -> MathapproxsplineBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_approx_spline_buffer_fill(s : MathapproxsplineBuffer, v : Double) -> MathapproxsplineBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_approx_spline_buffer_min(s : MathapproxsplineBuffer) -> Double { @_common.min(s.data) }

pub fn math_approx_spline_buffer_max(s : MathapproxsplineBuffer) -> Double { @_common.max(s.data) }

pub fn math_approx_spline_buffer_to_string(s : MathapproxsplineBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathapproxsplineCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_approx_spline_cursor_make(size : Int) -> MathapproxsplineCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_approx_spline_cursor_len(s : MathapproxsplineCursor) -> Int { s.size }

pub fn math_approx_spline_cursor_get(s : MathapproxsplineCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_approx_spline_cursor_set(s : MathapproxsplineCursor, i : Int, v : Double) -> MathapproxsplineCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_approx_spline_cursor_sum(s : MathapproxsplineCursor) -> Double { @_common.sum(s.data) }

pub fn math_approx_spline_cursor_mean(s : MathapproxsplineCursor) -> Double { @_common.mean(s.data) }

pub fn math_approx_spline_cursor_scale(s : MathapproxsplineCursor, f : Double) -> MathapproxsplineCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_approx_spline_cursor_add(a : MathapproxsplineCursor, b : MathapproxsplineCursor) -> MathapproxsplineCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_approx_spline_cursor_copy(s : MathapproxsplineCursor) -> MathapproxsplineCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_approx_spline_cursor_fill(s : MathapproxsplineCursor, v : Double) -> MathapproxsplineCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_approx_spline_cursor_min(s : MathapproxsplineCursor) -> Double { @_common.min(s.data) }

pub fn math_approx_spline_cursor_max(s : MathapproxsplineCursor) -> Double { @_common.max(s.data) }

pub fn math_approx_spline_cursor_to_string(s : MathapproxsplineCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathapproxsplineView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_approx_spline_view_make(size : Int) -> MathapproxsplineView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_approx_spline_view_len(s : MathapproxsplineView) -> Int { s.size }

pub fn math_approx_spline_view_get(s : MathapproxsplineView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_approx_spline_view_set(s : MathapproxsplineView, i : Int, v : Double) -> MathapproxsplineView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_approx_spline_view_sum(s : MathapproxsplineView) -> Double { @_common.sum(s.data) }

pub fn math_approx_spline_view_mean(s : MathapproxsplineView) -> Double { @_common.mean(s.data) }

pub fn math_approx_spline_view_scale(s : MathapproxsplineView, f : Double) -> MathapproxsplineView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_approx_spline_view_add(a : MathapproxsplineView, b : MathapproxsplineView) -> MathapproxsplineView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_approx_spline_view_copy(s : MathapproxsplineView) -> MathapproxsplineView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_approx_spline_view_fill(s : MathapproxsplineView, v : Double) -> MathapproxsplineView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_approx_spline_view_min(s : MathapproxsplineView) -> Double { @_common.min(s.data) }

pub fn math_approx_spline_view_max(s : MathapproxsplineView) -> Double { @_common.max(s.data) }

pub fn math_approx_spline_view_to_string(s : MathapproxsplineView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathapproxsplineRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_approx_spline_range_make(size : Int) -> MathapproxsplineRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_approx_spline_range_len(s : MathapproxsplineRange) -> Int { s.size }

pub fn math_approx_spline_range_get(s : MathapproxsplineRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_approx_spline_range_set(s : MathapproxsplineRange, i : Int, v : Double) -> MathapproxsplineRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_approx_spline_range_sum(s : MathapproxsplineRange) -> Double { @_common.sum(s.data) }

pub fn math_approx_spline_range_mean(s : MathapproxsplineRange) -> Double { @_common.mean(s.data) }

pub fn math_approx_spline_range_scale(s : MathapproxsplineRange, f : Double) -> MathapproxsplineRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_approx_spline_range_add(a : MathapproxsplineRange, b : MathapproxsplineRange) -> MathapproxsplineRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_approx_spline_range_copy(s : MathapproxsplineRange) -> MathapproxsplineRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_approx_spline_range_fill(s : MathapproxsplineRange, v : Double) -> MathapproxsplineRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_approx_spline_range_min(s : MathapproxsplineRange) -> Double { @_common.min(s.data) }

pub fn math_approx_spline_range_max(s : MathapproxsplineRange) -> Double { @_common.max(s.data) }

pub fn math_approx_spline_range_to_string(s : MathapproxsplineRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathapproxsplineSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_approx_spline_slice_make(size : Int) -> MathapproxsplineSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_approx_spline_slice_len(s : MathapproxsplineSlice) -> Int { s.size }

pub fn math_approx_spline_slice_get(s : MathapproxsplineSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_approx_spline_slice_set(s : MathapproxsplineSlice, i : Int, v : Double) -> MathapproxsplineSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_approx_spline_slice_sum(s : MathapproxsplineSlice) -> Double { @_common.sum(s.data) }

pub fn math_approx_spline_slice_mean(s : MathapproxsplineSlice) -> Double { @_common.mean(s.data) }

pub fn math_approx_spline_slice_scale(s : MathapproxsplineSlice, f : Double) -> MathapproxsplineSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_approx_spline_slice_add(a : MathapproxsplineSlice, b : MathapproxsplineSlice) -> MathapproxsplineSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_approx_spline_slice_copy(s : MathapproxsplineSlice) -> MathapproxsplineSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_approx_spline_slice_fill(s : MathapproxsplineSlice, v : Double) -> MathapproxsplineSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_approx_spline_slice_min(s : MathapproxsplineSlice) -> Double { @_common.min(s.data) }

pub fn math_approx_spline_slice_max(s : MathapproxsplineSlice) -> Double { @_common.max(s.data) }

pub fn math_approx_spline_slice_to_string(s : MathapproxsplineSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

