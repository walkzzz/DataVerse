///===
/// extcore/math_approx_interp

pub(all) struct MathapproxinterpPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn math_approx_interp_make_point(x : Double, y : Double) -> MathapproxinterpPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn math_approx_interp_make_point3(x : Double, y : Double, z : Double) -> MathapproxinterpPoint {
  { x, y, z, label: 0 }
}

pub fn MathapproxinterpPoint::x(self : MathapproxinterpPoint) -> Double { self.x }

pub fn MathapproxinterpPoint::y(self : MathapproxinterpPoint) -> Double { self.y }

pub fn MathapproxinterpPoint::z(self : MathapproxinterpPoint) -> Double { self.z }

pub fn MathapproxinterpPoint::label(self : MathapproxinterpPoint) -> Int { self.label }

pub fn MathapproxinterpPoint::dist(self : MathapproxinterpPoint, other : MathapproxinterpPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn MathapproxinterpPoint::add(self : MathapproxinterpPoint, other : MathapproxinterpPoint) -> MathapproxinterpPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn MathapproxinterpPoint::sub(self : MathapproxinterpPoint, other : MathapproxinterpPoint) -> MathapproxinterpPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn MathapproxinterpPoint::scale(self : MathapproxinterpPoint, s : Double) -> MathapproxinterpPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn MathapproxinterpPoint::dot(self : MathapproxinterpPoint, other : MathapproxinterpPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn MathapproxinterpPoint::cross(self : MathapproxinterpPoint, other : MathapproxinterpPoint) -> MathapproxinterpPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn MathapproxinterpPoint::norm(self : MathapproxinterpPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn MathapproxinterpPoint::normalize(self : MathapproxinterpPoint) -> MathapproxinterpPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn MathapproxinterpPoint::negate(self : MathapproxinterpPoint) -> MathapproxinterpPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn MathapproxinterpPoint::mid(self : MathapproxinterpPoint, other : MathapproxinterpPoint) -> MathapproxinterpPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn MathapproxinterpPoint::lerp(self : MathapproxinterpPoint, other : MathapproxinterpPoint, t : Double) -> MathapproxinterpPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn MathapproxinterpPoint::to_string(self : MathapproxinterpPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct MathapproxinterpSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn math_approx_interp_make_series(vals : Array[Double], name : String) -> MathapproxinterpSeries {
  { vals, name, meta: 0 }
}

pub fn MathapproxinterpSeries::len(self : MathapproxinterpSeries) -> Int { self.vals.length() }

pub fn MathapproxinterpSeries::sum(self : MathapproxinterpSeries) -> Double { @_common.sum(self.vals) }

pub fn MathapproxinterpSeries::mean(self : MathapproxinterpSeries) -> Double { @_common.mean(self.vals) }

pub fn MathapproxinterpSeries::min(self : MathapproxinterpSeries) -> Double { @_common.min(self.vals) }

pub fn MathapproxinterpSeries::max(self : MathapproxinterpSeries) -> Double { @_common.max(self.vals) }

pub fn MathapproxinterpSeries::range(self : MathapproxinterpSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn MathapproxinterpSeries::variance(self : MathapproxinterpSeries) -> Double { @_common.variance(self.vals) }

pub fn MathapproxinterpSeries::std(self : MathapproxinterpSeries) -> Double { @_common.std(self.vals) }

pub fn MathapproxinterpSeries::median(self : MathapproxinterpSeries) -> Double { @_common.median(self.vals) }

pub fn MathapproxinterpSeries::scale(self : MathapproxinterpSeries, f : Double) -> MathapproxinterpSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn MathapproxinterpSeries::add(self : MathapproxinterpSeries, other : MathapproxinterpSeries) -> MathapproxinterpSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn MathapproxinterpSeries::sub(self : MathapproxinterpSeries, other : MathapproxinterpSeries) -> MathapproxinterpSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn MathapproxinterpSeries::normalize(self : MathapproxinterpSeries) -> MathapproxinterpSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn MathapproxinterpSeries::cumsum(self : MathapproxinterpSeries) -> MathapproxinterpSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn MathapproxinterpSeries::to_string(self : MathapproxinterpSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct MathapproxinterpMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn math_approx_interp_make_matrix(rows : Int, cols : Int, val : Double) -> MathapproxinterpMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn math_approx_interp_matrix_identity(n : Int) -> MathapproxinterpMatrix {
  let m = math_approx_interp_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn MathapproxinterpMatrix::get(self : MathapproxinterpMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn MathapproxinterpMatrix::transpose(self : MathapproxinterpMatrix) -> MathapproxinterpMatrix {
  let result = math_approx_interp_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn MathapproxinterpMatrix::add(self : MathapproxinterpMatrix, other : MathapproxinterpMatrix) -> MathapproxinterpMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = math_approx_interp_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn MathapproxinterpMatrix::scale(self : MathapproxinterpMatrix, s : Double) -> MathapproxinterpMatrix {
  let result = math_approx_interp_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn MathapproxinterpMatrix::multiply(self : MathapproxinterpMatrix, other : MathapproxinterpMatrix) -> MathapproxinterpMatrix {
  if self.cols != other.rows { return math_approx_interp_make_matrix(self.rows, other.cols, 0.0) }
  let result = math_approx_interp_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn MathapproxinterpMatrix::trace(self : MathapproxinterpMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn MathapproxinterpMatrix::det(self : MathapproxinterpMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn MathapproxinterpMatrix::norm(self : MathapproxinterpMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn MathapproxinterpMatrix::to_string(self : MathapproxinterpMatrix) -> String {
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

pub(all) struct MathapproxinterpVector {
  comps : Array[Double]
  dim : Int
}

pub fn math_approx_interp_make_vector(comps : Array[Double]) -> MathapproxinterpVector {
  { comps, dim: comps.length() }
}

pub fn math_approx_interp_vector_zero(dim : Int) -> MathapproxinterpVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn MathapproxinterpVector::add(self : MathapproxinterpVector, other : MathapproxinterpVector) -> MathapproxinterpVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn MathapproxinterpVector::sub(self : MathapproxinterpVector, other : MathapproxinterpVector) -> MathapproxinterpVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn MathapproxinterpVector::scale(self : MathapproxinterpVector, s : Double) -> MathapproxinterpVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn MathapproxinterpVector::dot(self : MathapproxinterpVector, other : MathapproxinterpVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn MathapproxinterpVector::norm(self : MathapproxinterpVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn MathapproxinterpVector::normalize(self : MathapproxinterpVector) -> MathapproxinterpVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn MathapproxinterpVector::dist(self : MathapproxinterpVector, other : MathapproxinterpVector) -> Double {
  self.sub(other).norm()
}

pub fn MathapproxinterpVector::to_string(self : MathapproxinterpVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn math_approx_interp_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn math_approx_interp_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn math_approx_interp_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn math_approx_interp_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn math_approx_interp_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn math_approx_interp_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn math_approx_interp_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn math_approx_interp_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn math_approx_interp_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn math_approx_interp_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn math_approx_interp_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn math_approx_interp_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn math_approx_interp_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn math_approx_interp_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn math_approx_interp_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn math_approx_interp_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn math_approx_interp_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn math_approx_interp_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn math_approx_interp_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn math_approx_interp_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn math_approx_interp_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn math_approx_interp_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn math_approx_interp_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn math_approx_interp_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn math_approx_interp_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn math_approx_interp_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn math_approx_interp_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn math_approx_interp_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn math_approx_interp_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct MathapproxinterpFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_approx_interp_frame_make(size : Int) -> MathapproxinterpFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_approx_interp_frame_len(s : MathapproxinterpFrame) -> Int { s.size }

pub fn math_approx_interp_frame_get(s : MathapproxinterpFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_approx_interp_frame_set(s : MathapproxinterpFrame, i : Int, v : Double) -> MathapproxinterpFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_approx_interp_frame_sum(s : MathapproxinterpFrame) -> Double { @_common.sum(s.data) }

pub fn math_approx_interp_frame_mean(s : MathapproxinterpFrame) -> Double { @_common.mean(s.data) }

pub fn math_approx_interp_frame_scale(s : MathapproxinterpFrame, f : Double) -> MathapproxinterpFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_approx_interp_frame_add(a : MathapproxinterpFrame, b : MathapproxinterpFrame) -> MathapproxinterpFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_approx_interp_frame_copy(s : MathapproxinterpFrame) -> MathapproxinterpFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_approx_interp_frame_fill(s : MathapproxinterpFrame, v : Double) -> MathapproxinterpFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_approx_interp_frame_min(s : MathapproxinterpFrame) -> Double { @_common.min(s.data) }

pub fn math_approx_interp_frame_max(s : MathapproxinterpFrame) -> Double { @_common.max(s.data) }

pub fn math_approx_interp_frame_to_string(s : MathapproxinterpFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathapproxinterpTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_approx_interp_table_make(size : Int) -> MathapproxinterpTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_approx_interp_table_len(s : MathapproxinterpTable) -> Int { s.size }

pub fn math_approx_interp_table_get(s : MathapproxinterpTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_approx_interp_table_set(s : MathapproxinterpTable, i : Int, v : Double) -> MathapproxinterpTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_approx_interp_table_sum(s : MathapproxinterpTable) -> Double { @_common.sum(s.data) }

pub fn math_approx_interp_table_mean(s : MathapproxinterpTable) -> Double { @_common.mean(s.data) }

pub fn math_approx_interp_table_scale(s : MathapproxinterpTable, f : Double) -> MathapproxinterpTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_approx_interp_table_add(a : MathapproxinterpTable, b : MathapproxinterpTable) -> MathapproxinterpTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_approx_interp_table_copy(s : MathapproxinterpTable) -> MathapproxinterpTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_approx_interp_table_fill(s : MathapproxinterpTable, v : Double) -> MathapproxinterpTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_approx_interp_table_min(s : MathapproxinterpTable) -> Double { @_common.min(s.data) }

pub fn math_approx_interp_table_max(s : MathapproxinterpTable) -> Double { @_common.max(s.data) }

pub fn math_approx_interp_table_to_string(s : MathapproxinterpTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathapproxinterpGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_approx_interp_graphn_make(size : Int) -> MathapproxinterpGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_approx_interp_graphn_len(s : MathapproxinterpGraphN) -> Int { s.size }

pub fn math_approx_interp_graphn_get(s : MathapproxinterpGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_approx_interp_graphn_set(s : MathapproxinterpGraphN, i : Int, v : Double) -> MathapproxinterpGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_approx_interp_graphn_sum(s : MathapproxinterpGraphN) -> Double { @_common.sum(s.data) }

pub fn math_approx_interp_graphn_mean(s : MathapproxinterpGraphN) -> Double { @_common.mean(s.data) }

pub fn math_approx_interp_graphn_scale(s : MathapproxinterpGraphN, f : Double) -> MathapproxinterpGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_approx_interp_graphn_add(a : MathapproxinterpGraphN, b : MathapproxinterpGraphN) -> MathapproxinterpGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_approx_interp_graphn_copy(s : MathapproxinterpGraphN) -> MathapproxinterpGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_approx_interp_graphn_fill(s : MathapproxinterpGraphN, v : Double) -> MathapproxinterpGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_approx_interp_graphn_min(s : MathapproxinterpGraphN) -> Double { @_common.min(s.data) }

pub fn math_approx_interp_graphn_max(s : MathapproxinterpGraphN) -> Double { @_common.max(s.data) }

pub fn math_approx_interp_graphn_to_string(s : MathapproxinterpGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathapproxinterpNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_approx_interp_node_make(size : Int) -> MathapproxinterpNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_approx_interp_node_len(s : MathapproxinterpNode) -> Int { s.size }

pub fn math_approx_interp_node_get(s : MathapproxinterpNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_approx_interp_node_set(s : MathapproxinterpNode, i : Int, v : Double) -> MathapproxinterpNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_approx_interp_node_sum(s : MathapproxinterpNode) -> Double { @_common.sum(s.data) }

pub fn math_approx_interp_node_mean(s : MathapproxinterpNode) -> Double { @_common.mean(s.data) }

pub fn math_approx_interp_node_scale(s : MathapproxinterpNode, f : Double) -> MathapproxinterpNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_approx_interp_node_add(a : MathapproxinterpNode, b : MathapproxinterpNode) -> MathapproxinterpNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_approx_interp_node_copy(s : MathapproxinterpNode) -> MathapproxinterpNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_approx_interp_node_fill(s : MathapproxinterpNode, v : Double) -> MathapproxinterpNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_approx_interp_node_min(s : MathapproxinterpNode) -> Double { @_common.min(s.data) }

pub fn math_approx_interp_node_max(s : MathapproxinterpNode) -> Double { @_common.max(s.data) }

pub fn math_approx_interp_node_to_string(s : MathapproxinterpNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathapproxinterpEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_approx_interp_edge_make(size : Int) -> MathapproxinterpEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_approx_interp_edge_len(s : MathapproxinterpEdge) -> Int { s.size }

pub fn math_approx_interp_edge_get(s : MathapproxinterpEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_approx_interp_edge_set(s : MathapproxinterpEdge, i : Int, v : Double) -> MathapproxinterpEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_approx_interp_edge_sum(s : MathapproxinterpEdge) -> Double { @_common.sum(s.data) }

pub fn math_approx_interp_edge_mean(s : MathapproxinterpEdge) -> Double { @_common.mean(s.data) }

pub fn math_approx_interp_edge_scale(s : MathapproxinterpEdge, f : Double) -> MathapproxinterpEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_approx_interp_edge_add(a : MathapproxinterpEdge, b : MathapproxinterpEdge) -> MathapproxinterpEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_approx_interp_edge_copy(s : MathapproxinterpEdge) -> MathapproxinterpEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_approx_interp_edge_fill(s : MathapproxinterpEdge, v : Double) -> MathapproxinterpEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_approx_interp_edge_min(s : MathapproxinterpEdge) -> Double { @_common.min(s.data) }

pub fn math_approx_interp_edge_max(s : MathapproxinterpEdge) -> Double { @_common.max(s.data) }

pub fn math_approx_interp_edge_to_string(s : MathapproxinterpEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathapproxinterpPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_approx_interp_path_make(size : Int) -> MathapproxinterpPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_approx_interp_path_len(s : MathapproxinterpPath) -> Int { s.size }

pub fn math_approx_interp_path_get(s : MathapproxinterpPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_approx_interp_path_set(s : MathapproxinterpPath, i : Int, v : Double) -> MathapproxinterpPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_approx_interp_path_sum(s : MathapproxinterpPath) -> Double { @_common.sum(s.data) }

pub fn math_approx_interp_path_mean(s : MathapproxinterpPath) -> Double { @_common.mean(s.data) }

pub fn math_approx_interp_path_scale(s : MathapproxinterpPath, f : Double) -> MathapproxinterpPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_approx_interp_path_add(a : MathapproxinterpPath, b : MathapproxinterpPath) -> MathapproxinterpPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_approx_interp_path_copy(s : MathapproxinterpPath) -> MathapproxinterpPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_approx_interp_path_fill(s : MathapproxinterpPath, v : Double) -> MathapproxinterpPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_approx_interp_path_min(s : MathapproxinterpPath) -> Double { @_common.min(s.data) }

pub fn math_approx_interp_path_max(s : MathapproxinterpPath) -> Double { @_common.max(s.data) }

pub fn math_approx_interp_path_to_string(s : MathapproxinterpPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathapproxinterpCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_approx_interp_cluster_make(size : Int) -> MathapproxinterpCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_approx_interp_cluster_len(s : MathapproxinterpCluster) -> Int { s.size }

pub fn math_approx_interp_cluster_get(s : MathapproxinterpCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_approx_interp_cluster_set(s : MathapproxinterpCluster, i : Int, v : Double) -> MathapproxinterpCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_approx_interp_cluster_sum(s : MathapproxinterpCluster) -> Double { @_common.sum(s.data) }

pub fn math_approx_interp_cluster_mean(s : MathapproxinterpCluster) -> Double { @_common.mean(s.data) }

pub fn math_approx_interp_cluster_scale(s : MathapproxinterpCluster, f : Double) -> MathapproxinterpCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_approx_interp_cluster_add(a : MathapproxinterpCluster, b : MathapproxinterpCluster) -> MathapproxinterpCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_approx_interp_cluster_copy(s : MathapproxinterpCluster) -> MathapproxinterpCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_approx_interp_cluster_fill(s : MathapproxinterpCluster, v : Double) -> MathapproxinterpCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_approx_interp_cluster_min(s : MathapproxinterpCluster) -> Double { @_common.min(s.data) }

pub fn math_approx_interp_cluster_max(s : MathapproxinterpCluster) -> Double { @_common.max(s.data) }

pub fn math_approx_interp_cluster_to_string(s : MathapproxinterpCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathapproxinterpModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_approx_interp_model_make(size : Int) -> MathapproxinterpModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_approx_interp_model_len(s : MathapproxinterpModel) -> Int { s.size }

pub fn math_approx_interp_model_get(s : MathapproxinterpModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_approx_interp_model_set(s : MathapproxinterpModel, i : Int, v : Double) -> MathapproxinterpModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_approx_interp_model_sum(s : MathapproxinterpModel) -> Double { @_common.sum(s.data) }

pub fn math_approx_interp_model_mean(s : MathapproxinterpModel) -> Double { @_common.mean(s.data) }

pub fn math_approx_interp_model_scale(s : MathapproxinterpModel, f : Double) -> MathapproxinterpModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_approx_interp_model_add(a : MathapproxinterpModel, b : MathapproxinterpModel) -> MathapproxinterpModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_approx_interp_model_copy(s : MathapproxinterpModel) -> MathapproxinterpModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_approx_interp_model_fill(s : MathapproxinterpModel, v : Double) -> MathapproxinterpModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_approx_interp_model_min(s : MathapproxinterpModel) -> Double { @_common.min(s.data) }

pub fn math_approx_interp_model_max(s : MathapproxinterpModel) -> Double { @_common.max(s.data) }

pub fn math_approx_interp_model_to_string(s : MathapproxinterpModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathapproxinterpLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_approx_interp_layer_make(size : Int) -> MathapproxinterpLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_approx_interp_layer_len(s : MathapproxinterpLayer) -> Int { s.size }

pub fn math_approx_interp_layer_get(s : MathapproxinterpLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_approx_interp_layer_set(s : MathapproxinterpLayer, i : Int, v : Double) -> MathapproxinterpLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_approx_interp_layer_sum(s : MathapproxinterpLayer) -> Double { @_common.sum(s.data) }

pub fn math_approx_interp_layer_mean(s : MathapproxinterpLayer) -> Double { @_common.mean(s.data) }

pub fn math_approx_interp_layer_scale(s : MathapproxinterpLayer, f : Double) -> MathapproxinterpLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_approx_interp_layer_add(a : MathapproxinterpLayer, b : MathapproxinterpLayer) -> MathapproxinterpLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_approx_interp_layer_copy(s : MathapproxinterpLayer) -> MathapproxinterpLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_approx_interp_layer_fill(s : MathapproxinterpLayer, v : Double) -> MathapproxinterpLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_approx_interp_layer_min(s : MathapproxinterpLayer) -> Double { @_common.min(s.data) }

pub fn math_approx_interp_layer_max(s : MathapproxinterpLayer) -> Double { @_common.max(s.data) }

pub fn math_approx_interp_layer_to_string(s : MathapproxinterpLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathapproxinterpBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_approx_interp_buffer_make(size : Int) -> MathapproxinterpBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_approx_interp_buffer_len(s : MathapproxinterpBuffer) -> Int { s.size }

pub fn math_approx_interp_buffer_get(s : MathapproxinterpBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_approx_interp_buffer_set(s : MathapproxinterpBuffer, i : Int, v : Double) -> MathapproxinterpBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_approx_interp_buffer_sum(s : MathapproxinterpBuffer) -> Double { @_common.sum(s.data) }

pub fn math_approx_interp_buffer_mean(s : MathapproxinterpBuffer) -> Double { @_common.mean(s.data) }

pub fn math_approx_interp_buffer_scale(s : MathapproxinterpBuffer, f : Double) -> MathapproxinterpBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_approx_interp_buffer_add(a : MathapproxinterpBuffer, b : MathapproxinterpBuffer) -> MathapproxinterpBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_approx_interp_buffer_copy(s : MathapproxinterpBuffer) -> MathapproxinterpBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_approx_interp_buffer_fill(s : MathapproxinterpBuffer, v : Double) -> MathapproxinterpBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_approx_interp_buffer_min(s : MathapproxinterpBuffer) -> Double { @_common.min(s.data) }

pub fn math_approx_interp_buffer_max(s : MathapproxinterpBuffer) -> Double { @_common.max(s.data) }

pub fn math_approx_interp_buffer_to_string(s : MathapproxinterpBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathapproxinterpCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_approx_interp_cursor_make(size : Int) -> MathapproxinterpCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_approx_interp_cursor_len(s : MathapproxinterpCursor) -> Int { s.size }

pub fn math_approx_interp_cursor_get(s : MathapproxinterpCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_approx_interp_cursor_set(s : MathapproxinterpCursor, i : Int, v : Double) -> MathapproxinterpCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_approx_interp_cursor_sum(s : MathapproxinterpCursor) -> Double { @_common.sum(s.data) }

pub fn math_approx_interp_cursor_mean(s : MathapproxinterpCursor) -> Double { @_common.mean(s.data) }

pub fn math_approx_interp_cursor_scale(s : MathapproxinterpCursor, f : Double) -> MathapproxinterpCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_approx_interp_cursor_add(a : MathapproxinterpCursor, b : MathapproxinterpCursor) -> MathapproxinterpCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_approx_interp_cursor_copy(s : MathapproxinterpCursor) -> MathapproxinterpCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_approx_interp_cursor_fill(s : MathapproxinterpCursor, v : Double) -> MathapproxinterpCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_approx_interp_cursor_min(s : MathapproxinterpCursor) -> Double { @_common.min(s.data) }

pub fn math_approx_interp_cursor_max(s : MathapproxinterpCursor) -> Double { @_common.max(s.data) }

pub fn math_approx_interp_cursor_to_string(s : MathapproxinterpCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathapproxinterpView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_approx_interp_view_make(size : Int) -> MathapproxinterpView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_approx_interp_view_len(s : MathapproxinterpView) -> Int { s.size }

pub fn math_approx_interp_view_get(s : MathapproxinterpView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_approx_interp_view_set(s : MathapproxinterpView, i : Int, v : Double) -> MathapproxinterpView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_approx_interp_view_sum(s : MathapproxinterpView) -> Double { @_common.sum(s.data) }

pub fn math_approx_interp_view_mean(s : MathapproxinterpView) -> Double { @_common.mean(s.data) }

pub fn math_approx_interp_view_scale(s : MathapproxinterpView, f : Double) -> MathapproxinterpView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_approx_interp_view_add(a : MathapproxinterpView, b : MathapproxinterpView) -> MathapproxinterpView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_approx_interp_view_copy(s : MathapproxinterpView) -> MathapproxinterpView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_approx_interp_view_fill(s : MathapproxinterpView, v : Double) -> MathapproxinterpView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_approx_interp_view_min(s : MathapproxinterpView) -> Double { @_common.min(s.data) }

pub fn math_approx_interp_view_max(s : MathapproxinterpView) -> Double { @_common.max(s.data) }

pub fn math_approx_interp_view_to_string(s : MathapproxinterpView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathapproxinterpRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_approx_interp_range_make(size : Int) -> MathapproxinterpRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_approx_interp_range_len(s : MathapproxinterpRange) -> Int { s.size }

pub fn math_approx_interp_range_get(s : MathapproxinterpRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_approx_interp_range_set(s : MathapproxinterpRange, i : Int, v : Double) -> MathapproxinterpRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_approx_interp_range_sum(s : MathapproxinterpRange) -> Double { @_common.sum(s.data) }

pub fn math_approx_interp_range_mean(s : MathapproxinterpRange) -> Double { @_common.mean(s.data) }

pub fn math_approx_interp_range_scale(s : MathapproxinterpRange, f : Double) -> MathapproxinterpRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_approx_interp_range_add(a : MathapproxinterpRange, b : MathapproxinterpRange) -> MathapproxinterpRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_approx_interp_range_copy(s : MathapproxinterpRange) -> MathapproxinterpRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_approx_interp_range_fill(s : MathapproxinterpRange, v : Double) -> MathapproxinterpRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_approx_interp_range_min(s : MathapproxinterpRange) -> Double { @_common.min(s.data) }

pub fn math_approx_interp_range_max(s : MathapproxinterpRange) -> Double { @_common.max(s.data) }

pub fn math_approx_interp_range_to_string(s : MathapproxinterpRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathapproxinterpSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_approx_interp_slice_make(size : Int) -> MathapproxinterpSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_approx_interp_slice_len(s : MathapproxinterpSlice) -> Int { s.size }

pub fn math_approx_interp_slice_get(s : MathapproxinterpSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_approx_interp_slice_set(s : MathapproxinterpSlice, i : Int, v : Double) -> MathapproxinterpSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_approx_interp_slice_sum(s : MathapproxinterpSlice) -> Double { @_common.sum(s.data) }

pub fn math_approx_interp_slice_mean(s : MathapproxinterpSlice) -> Double { @_common.mean(s.data) }

pub fn math_approx_interp_slice_scale(s : MathapproxinterpSlice, f : Double) -> MathapproxinterpSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_approx_interp_slice_add(a : MathapproxinterpSlice, b : MathapproxinterpSlice) -> MathapproxinterpSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_approx_interp_slice_copy(s : MathapproxinterpSlice) -> MathapproxinterpSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_approx_interp_slice_fill(s : MathapproxinterpSlice, v : Double) -> MathapproxinterpSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_approx_interp_slice_min(s : MathapproxinterpSlice) -> Double { @_common.min(s.data) }

pub fn math_approx_interp_slice_max(s : MathapproxinterpSlice) -> Double { @_common.max(s.data) }

pub fn math_approx_interp_slice_to_string(s : MathapproxinterpSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

