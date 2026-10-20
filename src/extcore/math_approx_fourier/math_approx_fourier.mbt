///===
/// extcore/math_approx_fourier

pub(all) struct MathapproxfourierPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn math_approx_fourier_make_point(x : Double, y : Double) -> MathapproxfourierPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn math_approx_fourier_make_point3(x : Double, y : Double, z : Double) -> MathapproxfourierPoint {
  { x, y, z, label: 0 }
}

pub fn MathapproxfourierPoint::x(self : MathapproxfourierPoint) -> Double { self.x }

pub fn MathapproxfourierPoint::y(self : MathapproxfourierPoint) -> Double { self.y }

pub fn MathapproxfourierPoint::z(self : MathapproxfourierPoint) -> Double { self.z }

pub fn MathapproxfourierPoint::label(self : MathapproxfourierPoint) -> Int { self.label }

pub fn MathapproxfourierPoint::dist(self : MathapproxfourierPoint, other : MathapproxfourierPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn MathapproxfourierPoint::add(self : MathapproxfourierPoint, other : MathapproxfourierPoint) -> MathapproxfourierPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn MathapproxfourierPoint::sub(self : MathapproxfourierPoint, other : MathapproxfourierPoint) -> MathapproxfourierPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn MathapproxfourierPoint::scale(self : MathapproxfourierPoint, s : Double) -> MathapproxfourierPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn MathapproxfourierPoint::dot(self : MathapproxfourierPoint, other : MathapproxfourierPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn MathapproxfourierPoint::cross(self : MathapproxfourierPoint, other : MathapproxfourierPoint) -> MathapproxfourierPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn MathapproxfourierPoint::norm(self : MathapproxfourierPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn MathapproxfourierPoint::normalize(self : MathapproxfourierPoint) -> MathapproxfourierPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn MathapproxfourierPoint::negate(self : MathapproxfourierPoint) -> MathapproxfourierPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn MathapproxfourierPoint::mid(self : MathapproxfourierPoint, other : MathapproxfourierPoint) -> MathapproxfourierPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn MathapproxfourierPoint::lerp(self : MathapproxfourierPoint, other : MathapproxfourierPoint, t : Double) -> MathapproxfourierPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn MathapproxfourierPoint::to_string(self : MathapproxfourierPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct MathapproxfourierSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn math_approx_fourier_make_series(vals : Array[Double], name : String) -> MathapproxfourierSeries {
  { vals, name, meta: 0 }
}

pub fn MathapproxfourierSeries::len(self : MathapproxfourierSeries) -> Int { self.vals.length() }

pub fn MathapproxfourierSeries::sum(self : MathapproxfourierSeries) -> Double { @_common.sum(self.vals) }

pub fn MathapproxfourierSeries::mean(self : MathapproxfourierSeries) -> Double { @_common.mean(self.vals) }

pub fn MathapproxfourierSeries::min(self : MathapproxfourierSeries) -> Double { @_common.min(self.vals) }

pub fn MathapproxfourierSeries::max(self : MathapproxfourierSeries) -> Double { @_common.max(self.vals) }

pub fn MathapproxfourierSeries::range(self : MathapproxfourierSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn MathapproxfourierSeries::variance(self : MathapproxfourierSeries) -> Double { @_common.variance(self.vals) }

pub fn MathapproxfourierSeries::std(self : MathapproxfourierSeries) -> Double { @_common.std(self.vals) }

pub fn MathapproxfourierSeries::median(self : MathapproxfourierSeries) -> Double { @_common.median(self.vals) }

pub fn MathapproxfourierSeries::scale(self : MathapproxfourierSeries, f : Double) -> MathapproxfourierSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn MathapproxfourierSeries::add(self : MathapproxfourierSeries, other : MathapproxfourierSeries) -> MathapproxfourierSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn MathapproxfourierSeries::sub(self : MathapproxfourierSeries, other : MathapproxfourierSeries) -> MathapproxfourierSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn MathapproxfourierSeries::normalize(self : MathapproxfourierSeries) -> MathapproxfourierSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn MathapproxfourierSeries::cumsum(self : MathapproxfourierSeries) -> MathapproxfourierSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn MathapproxfourierSeries::to_string(self : MathapproxfourierSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct MathapproxfourierMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn math_approx_fourier_make_matrix(rows : Int, cols : Int, val : Double) -> MathapproxfourierMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn math_approx_fourier_matrix_identity(n : Int) -> MathapproxfourierMatrix {
  let m = math_approx_fourier_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn MathapproxfourierMatrix::get(self : MathapproxfourierMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn MathapproxfourierMatrix::transpose(self : MathapproxfourierMatrix) -> MathapproxfourierMatrix {
  let result = math_approx_fourier_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn MathapproxfourierMatrix::add(self : MathapproxfourierMatrix, other : MathapproxfourierMatrix) -> MathapproxfourierMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = math_approx_fourier_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn MathapproxfourierMatrix::scale(self : MathapproxfourierMatrix, s : Double) -> MathapproxfourierMatrix {
  let result = math_approx_fourier_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn MathapproxfourierMatrix::multiply(self : MathapproxfourierMatrix, other : MathapproxfourierMatrix) -> MathapproxfourierMatrix {
  if self.cols != other.rows { return math_approx_fourier_make_matrix(self.rows, other.cols, 0.0) }
  let result = math_approx_fourier_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn MathapproxfourierMatrix::trace(self : MathapproxfourierMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn MathapproxfourierMatrix::det(self : MathapproxfourierMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn MathapproxfourierMatrix::norm(self : MathapproxfourierMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn MathapproxfourierMatrix::to_string(self : MathapproxfourierMatrix) -> String {
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

pub(all) struct MathapproxfourierVector {
  comps : Array[Double]
  dim : Int
}

pub fn math_approx_fourier_make_vector(comps : Array[Double]) -> MathapproxfourierVector {
  { comps, dim: comps.length() }
}

pub fn math_approx_fourier_vector_zero(dim : Int) -> MathapproxfourierVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn MathapproxfourierVector::add(self : MathapproxfourierVector, other : MathapproxfourierVector) -> MathapproxfourierVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn MathapproxfourierVector::sub(self : MathapproxfourierVector, other : MathapproxfourierVector) -> MathapproxfourierVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn MathapproxfourierVector::scale(self : MathapproxfourierVector, s : Double) -> MathapproxfourierVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn MathapproxfourierVector::dot(self : MathapproxfourierVector, other : MathapproxfourierVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn MathapproxfourierVector::norm(self : MathapproxfourierVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn MathapproxfourierVector::normalize(self : MathapproxfourierVector) -> MathapproxfourierVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn MathapproxfourierVector::dist(self : MathapproxfourierVector, other : MathapproxfourierVector) -> Double {
  self.sub(other).norm()
}

pub fn MathapproxfourierVector::to_string(self : MathapproxfourierVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn math_approx_fourier_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn math_approx_fourier_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn math_approx_fourier_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn math_approx_fourier_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn math_approx_fourier_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn math_approx_fourier_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn math_approx_fourier_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn math_approx_fourier_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn math_approx_fourier_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn math_approx_fourier_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn math_approx_fourier_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn math_approx_fourier_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn math_approx_fourier_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn math_approx_fourier_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn math_approx_fourier_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn math_approx_fourier_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn math_approx_fourier_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn math_approx_fourier_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn math_approx_fourier_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn math_approx_fourier_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn math_approx_fourier_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn math_approx_fourier_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn math_approx_fourier_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn math_approx_fourier_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn math_approx_fourier_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn math_approx_fourier_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn math_approx_fourier_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn math_approx_fourier_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn math_approx_fourier_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct MathapproxfourierFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_approx_fourier_frame_make(size : Int) -> MathapproxfourierFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_approx_fourier_frame_len(s : MathapproxfourierFrame) -> Int { s.size }

pub fn math_approx_fourier_frame_get(s : MathapproxfourierFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_approx_fourier_frame_set(s : MathapproxfourierFrame, i : Int, v : Double) -> MathapproxfourierFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_approx_fourier_frame_sum(s : MathapproxfourierFrame) -> Double { @_common.sum(s.data) }

pub fn math_approx_fourier_frame_mean(s : MathapproxfourierFrame) -> Double { @_common.mean(s.data) }

pub fn math_approx_fourier_frame_scale(s : MathapproxfourierFrame, f : Double) -> MathapproxfourierFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_approx_fourier_frame_add(a : MathapproxfourierFrame, b : MathapproxfourierFrame) -> MathapproxfourierFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_approx_fourier_frame_copy(s : MathapproxfourierFrame) -> MathapproxfourierFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_approx_fourier_frame_fill(s : MathapproxfourierFrame, v : Double) -> MathapproxfourierFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_approx_fourier_frame_min(s : MathapproxfourierFrame) -> Double { @_common.min(s.data) }

pub fn math_approx_fourier_frame_max(s : MathapproxfourierFrame) -> Double { @_common.max(s.data) }

pub fn math_approx_fourier_frame_to_string(s : MathapproxfourierFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathapproxfourierTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_approx_fourier_table_make(size : Int) -> MathapproxfourierTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_approx_fourier_table_len(s : MathapproxfourierTable) -> Int { s.size }

pub fn math_approx_fourier_table_get(s : MathapproxfourierTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_approx_fourier_table_set(s : MathapproxfourierTable, i : Int, v : Double) -> MathapproxfourierTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_approx_fourier_table_sum(s : MathapproxfourierTable) -> Double { @_common.sum(s.data) }

pub fn math_approx_fourier_table_mean(s : MathapproxfourierTable) -> Double { @_common.mean(s.data) }

pub fn math_approx_fourier_table_scale(s : MathapproxfourierTable, f : Double) -> MathapproxfourierTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_approx_fourier_table_add(a : MathapproxfourierTable, b : MathapproxfourierTable) -> MathapproxfourierTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_approx_fourier_table_copy(s : MathapproxfourierTable) -> MathapproxfourierTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_approx_fourier_table_fill(s : MathapproxfourierTable, v : Double) -> MathapproxfourierTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_approx_fourier_table_min(s : MathapproxfourierTable) -> Double { @_common.min(s.data) }

pub fn math_approx_fourier_table_max(s : MathapproxfourierTable) -> Double { @_common.max(s.data) }

pub fn math_approx_fourier_table_to_string(s : MathapproxfourierTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathapproxfourierGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_approx_fourier_graphn_make(size : Int) -> MathapproxfourierGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_approx_fourier_graphn_len(s : MathapproxfourierGraphN) -> Int { s.size }

pub fn math_approx_fourier_graphn_get(s : MathapproxfourierGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_approx_fourier_graphn_set(s : MathapproxfourierGraphN, i : Int, v : Double) -> MathapproxfourierGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_approx_fourier_graphn_sum(s : MathapproxfourierGraphN) -> Double { @_common.sum(s.data) }

pub fn math_approx_fourier_graphn_mean(s : MathapproxfourierGraphN) -> Double { @_common.mean(s.data) }

pub fn math_approx_fourier_graphn_scale(s : MathapproxfourierGraphN, f : Double) -> MathapproxfourierGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_approx_fourier_graphn_add(a : MathapproxfourierGraphN, b : MathapproxfourierGraphN) -> MathapproxfourierGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_approx_fourier_graphn_copy(s : MathapproxfourierGraphN) -> MathapproxfourierGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_approx_fourier_graphn_fill(s : MathapproxfourierGraphN, v : Double) -> MathapproxfourierGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_approx_fourier_graphn_min(s : MathapproxfourierGraphN) -> Double { @_common.min(s.data) }

pub fn math_approx_fourier_graphn_max(s : MathapproxfourierGraphN) -> Double { @_common.max(s.data) }

pub fn math_approx_fourier_graphn_to_string(s : MathapproxfourierGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathapproxfourierNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_approx_fourier_node_make(size : Int) -> MathapproxfourierNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_approx_fourier_node_len(s : MathapproxfourierNode) -> Int { s.size }

pub fn math_approx_fourier_node_get(s : MathapproxfourierNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_approx_fourier_node_set(s : MathapproxfourierNode, i : Int, v : Double) -> MathapproxfourierNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_approx_fourier_node_sum(s : MathapproxfourierNode) -> Double { @_common.sum(s.data) }

pub fn math_approx_fourier_node_mean(s : MathapproxfourierNode) -> Double { @_common.mean(s.data) }

pub fn math_approx_fourier_node_scale(s : MathapproxfourierNode, f : Double) -> MathapproxfourierNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_approx_fourier_node_add(a : MathapproxfourierNode, b : MathapproxfourierNode) -> MathapproxfourierNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_approx_fourier_node_copy(s : MathapproxfourierNode) -> MathapproxfourierNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_approx_fourier_node_fill(s : MathapproxfourierNode, v : Double) -> MathapproxfourierNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_approx_fourier_node_min(s : MathapproxfourierNode) -> Double { @_common.min(s.data) }

pub fn math_approx_fourier_node_max(s : MathapproxfourierNode) -> Double { @_common.max(s.data) }

pub fn math_approx_fourier_node_to_string(s : MathapproxfourierNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathapproxfourierEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_approx_fourier_edge_make(size : Int) -> MathapproxfourierEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_approx_fourier_edge_len(s : MathapproxfourierEdge) -> Int { s.size }

pub fn math_approx_fourier_edge_get(s : MathapproxfourierEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_approx_fourier_edge_set(s : MathapproxfourierEdge, i : Int, v : Double) -> MathapproxfourierEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_approx_fourier_edge_sum(s : MathapproxfourierEdge) -> Double { @_common.sum(s.data) }

pub fn math_approx_fourier_edge_mean(s : MathapproxfourierEdge) -> Double { @_common.mean(s.data) }

pub fn math_approx_fourier_edge_scale(s : MathapproxfourierEdge, f : Double) -> MathapproxfourierEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_approx_fourier_edge_add(a : MathapproxfourierEdge, b : MathapproxfourierEdge) -> MathapproxfourierEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_approx_fourier_edge_copy(s : MathapproxfourierEdge) -> MathapproxfourierEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_approx_fourier_edge_fill(s : MathapproxfourierEdge, v : Double) -> MathapproxfourierEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_approx_fourier_edge_min(s : MathapproxfourierEdge) -> Double { @_common.min(s.data) }

pub fn math_approx_fourier_edge_max(s : MathapproxfourierEdge) -> Double { @_common.max(s.data) }

pub fn math_approx_fourier_edge_to_string(s : MathapproxfourierEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathapproxfourierPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_approx_fourier_path_make(size : Int) -> MathapproxfourierPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_approx_fourier_path_len(s : MathapproxfourierPath) -> Int { s.size }

pub fn math_approx_fourier_path_get(s : MathapproxfourierPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_approx_fourier_path_set(s : MathapproxfourierPath, i : Int, v : Double) -> MathapproxfourierPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_approx_fourier_path_sum(s : MathapproxfourierPath) -> Double { @_common.sum(s.data) }

pub fn math_approx_fourier_path_mean(s : MathapproxfourierPath) -> Double { @_common.mean(s.data) }

pub fn math_approx_fourier_path_scale(s : MathapproxfourierPath, f : Double) -> MathapproxfourierPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_approx_fourier_path_add(a : MathapproxfourierPath, b : MathapproxfourierPath) -> MathapproxfourierPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_approx_fourier_path_copy(s : MathapproxfourierPath) -> MathapproxfourierPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_approx_fourier_path_fill(s : MathapproxfourierPath, v : Double) -> MathapproxfourierPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_approx_fourier_path_min(s : MathapproxfourierPath) -> Double { @_common.min(s.data) }

pub fn math_approx_fourier_path_max(s : MathapproxfourierPath) -> Double { @_common.max(s.data) }

pub fn math_approx_fourier_path_to_string(s : MathapproxfourierPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathapproxfourierCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_approx_fourier_cluster_make(size : Int) -> MathapproxfourierCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_approx_fourier_cluster_len(s : MathapproxfourierCluster) -> Int { s.size }

pub fn math_approx_fourier_cluster_get(s : MathapproxfourierCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_approx_fourier_cluster_set(s : MathapproxfourierCluster, i : Int, v : Double) -> MathapproxfourierCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_approx_fourier_cluster_sum(s : MathapproxfourierCluster) -> Double { @_common.sum(s.data) }

pub fn math_approx_fourier_cluster_mean(s : MathapproxfourierCluster) -> Double { @_common.mean(s.data) }

pub fn math_approx_fourier_cluster_scale(s : MathapproxfourierCluster, f : Double) -> MathapproxfourierCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_approx_fourier_cluster_add(a : MathapproxfourierCluster, b : MathapproxfourierCluster) -> MathapproxfourierCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_approx_fourier_cluster_copy(s : MathapproxfourierCluster) -> MathapproxfourierCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_approx_fourier_cluster_fill(s : MathapproxfourierCluster, v : Double) -> MathapproxfourierCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_approx_fourier_cluster_min(s : MathapproxfourierCluster) -> Double { @_common.min(s.data) }

pub fn math_approx_fourier_cluster_max(s : MathapproxfourierCluster) -> Double { @_common.max(s.data) }

pub fn math_approx_fourier_cluster_to_string(s : MathapproxfourierCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathapproxfourierModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_approx_fourier_model_make(size : Int) -> MathapproxfourierModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_approx_fourier_model_len(s : MathapproxfourierModel) -> Int { s.size }

pub fn math_approx_fourier_model_get(s : MathapproxfourierModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_approx_fourier_model_set(s : MathapproxfourierModel, i : Int, v : Double) -> MathapproxfourierModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_approx_fourier_model_sum(s : MathapproxfourierModel) -> Double { @_common.sum(s.data) }

pub fn math_approx_fourier_model_mean(s : MathapproxfourierModel) -> Double { @_common.mean(s.data) }

pub fn math_approx_fourier_model_scale(s : MathapproxfourierModel, f : Double) -> MathapproxfourierModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_approx_fourier_model_add(a : MathapproxfourierModel, b : MathapproxfourierModel) -> MathapproxfourierModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_approx_fourier_model_copy(s : MathapproxfourierModel) -> MathapproxfourierModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_approx_fourier_model_fill(s : MathapproxfourierModel, v : Double) -> MathapproxfourierModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_approx_fourier_model_min(s : MathapproxfourierModel) -> Double { @_common.min(s.data) }

pub fn math_approx_fourier_model_max(s : MathapproxfourierModel) -> Double { @_common.max(s.data) }

pub fn math_approx_fourier_model_to_string(s : MathapproxfourierModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathapproxfourierLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_approx_fourier_layer_make(size : Int) -> MathapproxfourierLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_approx_fourier_layer_len(s : MathapproxfourierLayer) -> Int { s.size }

pub fn math_approx_fourier_layer_get(s : MathapproxfourierLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_approx_fourier_layer_set(s : MathapproxfourierLayer, i : Int, v : Double) -> MathapproxfourierLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_approx_fourier_layer_sum(s : MathapproxfourierLayer) -> Double { @_common.sum(s.data) }

pub fn math_approx_fourier_layer_mean(s : MathapproxfourierLayer) -> Double { @_common.mean(s.data) }

pub fn math_approx_fourier_layer_scale(s : MathapproxfourierLayer, f : Double) -> MathapproxfourierLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_approx_fourier_layer_add(a : MathapproxfourierLayer, b : MathapproxfourierLayer) -> MathapproxfourierLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_approx_fourier_layer_copy(s : MathapproxfourierLayer) -> MathapproxfourierLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_approx_fourier_layer_fill(s : MathapproxfourierLayer, v : Double) -> MathapproxfourierLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_approx_fourier_layer_min(s : MathapproxfourierLayer) -> Double { @_common.min(s.data) }

pub fn math_approx_fourier_layer_max(s : MathapproxfourierLayer) -> Double { @_common.max(s.data) }

pub fn math_approx_fourier_layer_to_string(s : MathapproxfourierLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathapproxfourierBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_approx_fourier_buffer_make(size : Int) -> MathapproxfourierBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_approx_fourier_buffer_len(s : MathapproxfourierBuffer) -> Int { s.size }

pub fn math_approx_fourier_buffer_get(s : MathapproxfourierBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_approx_fourier_buffer_set(s : MathapproxfourierBuffer, i : Int, v : Double) -> MathapproxfourierBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_approx_fourier_buffer_sum(s : MathapproxfourierBuffer) -> Double { @_common.sum(s.data) }

pub fn math_approx_fourier_buffer_mean(s : MathapproxfourierBuffer) -> Double { @_common.mean(s.data) }

pub fn math_approx_fourier_buffer_scale(s : MathapproxfourierBuffer, f : Double) -> MathapproxfourierBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_approx_fourier_buffer_add(a : MathapproxfourierBuffer, b : MathapproxfourierBuffer) -> MathapproxfourierBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_approx_fourier_buffer_copy(s : MathapproxfourierBuffer) -> MathapproxfourierBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_approx_fourier_buffer_fill(s : MathapproxfourierBuffer, v : Double) -> MathapproxfourierBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_approx_fourier_buffer_min(s : MathapproxfourierBuffer) -> Double { @_common.min(s.data) }

pub fn math_approx_fourier_buffer_max(s : MathapproxfourierBuffer) -> Double { @_common.max(s.data) }

pub fn math_approx_fourier_buffer_to_string(s : MathapproxfourierBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathapproxfourierCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_approx_fourier_cursor_make(size : Int) -> MathapproxfourierCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_approx_fourier_cursor_len(s : MathapproxfourierCursor) -> Int { s.size }

pub fn math_approx_fourier_cursor_get(s : MathapproxfourierCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_approx_fourier_cursor_set(s : MathapproxfourierCursor, i : Int, v : Double) -> MathapproxfourierCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_approx_fourier_cursor_sum(s : MathapproxfourierCursor) -> Double { @_common.sum(s.data) }

pub fn math_approx_fourier_cursor_mean(s : MathapproxfourierCursor) -> Double { @_common.mean(s.data) }

pub fn math_approx_fourier_cursor_scale(s : MathapproxfourierCursor, f : Double) -> MathapproxfourierCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_approx_fourier_cursor_add(a : MathapproxfourierCursor, b : MathapproxfourierCursor) -> MathapproxfourierCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_approx_fourier_cursor_copy(s : MathapproxfourierCursor) -> MathapproxfourierCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_approx_fourier_cursor_fill(s : MathapproxfourierCursor, v : Double) -> MathapproxfourierCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_approx_fourier_cursor_min(s : MathapproxfourierCursor) -> Double { @_common.min(s.data) }

pub fn math_approx_fourier_cursor_max(s : MathapproxfourierCursor) -> Double { @_common.max(s.data) }

pub fn math_approx_fourier_cursor_to_string(s : MathapproxfourierCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathapproxfourierView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_approx_fourier_view_make(size : Int) -> MathapproxfourierView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_approx_fourier_view_len(s : MathapproxfourierView) -> Int { s.size }

pub fn math_approx_fourier_view_get(s : MathapproxfourierView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_approx_fourier_view_set(s : MathapproxfourierView, i : Int, v : Double) -> MathapproxfourierView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_approx_fourier_view_sum(s : MathapproxfourierView) -> Double { @_common.sum(s.data) }

pub fn math_approx_fourier_view_mean(s : MathapproxfourierView) -> Double { @_common.mean(s.data) }

pub fn math_approx_fourier_view_scale(s : MathapproxfourierView, f : Double) -> MathapproxfourierView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_approx_fourier_view_add(a : MathapproxfourierView, b : MathapproxfourierView) -> MathapproxfourierView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_approx_fourier_view_copy(s : MathapproxfourierView) -> MathapproxfourierView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_approx_fourier_view_fill(s : MathapproxfourierView, v : Double) -> MathapproxfourierView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_approx_fourier_view_min(s : MathapproxfourierView) -> Double { @_common.min(s.data) }

pub fn math_approx_fourier_view_max(s : MathapproxfourierView) -> Double { @_common.max(s.data) }

pub fn math_approx_fourier_view_to_string(s : MathapproxfourierView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathapproxfourierRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_approx_fourier_range_make(size : Int) -> MathapproxfourierRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_approx_fourier_range_len(s : MathapproxfourierRange) -> Int { s.size }

pub fn math_approx_fourier_range_get(s : MathapproxfourierRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_approx_fourier_range_set(s : MathapproxfourierRange, i : Int, v : Double) -> MathapproxfourierRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_approx_fourier_range_sum(s : MathapproxfourierRange) -> Double { @_common.sum(s.data) }

pub fn math_approx_fourier_range_mean(s : MathapproxfourierRange) -> Double { @_common.mean(s.data) }

pub fn math_approx_fourier_range_scale(s : MathapproxfourierRange, f : Double) -> MathapproxfourierRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_approx_fourier_range_add(a : MathapproxfourierRange, b : MathapproxfourierRange) -> MathapproxfourierRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_approx_fourier_range_copy(s : MathapproxfourierRange) -> MathapproxfourierRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_approx_fourier_range_fill(s : MathapproxfourierRange, v : Double) -> MathapproxfourierRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_approx_fourier_range_min(s : MathapproxfourierRange) -> Double { @_common.min(s.data) }

pub fn math_approx_fourier_range_max(s : MathapproxfourierRange) -> Double { @_common.max(s.data) }

pub fn math_approx_fourier_range_to_string(s : MathapproxfourierRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathapproxfourierSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_approx_fourier_slice_make(size : Int) -> MathapproxfourierSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_approx_fourier_slice_len(s : MathapproxfourierSlice) -> Int { s.size }

pub fn math_approx_fourier_slice_get(s : MathapproxfourierSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_approx_fourier_slice_set(s : MathapproxfourierSlice, i : Int, v : Double) -> MathapproxfourierSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_approx_fourier_slice_sum(s : MathapproxfourierSlice) -> Double { @_common.sum(s.data) }

pub fn math_approx_fourier_slice_mean(s : MathapproxfourierSlice) -> Double { @_common.mean(s.data) }

pub fn math_approx_fourier_slice_scale(s : MathapproxfourierSlice, f : Double) -> MathapproxfourierSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_approx_fourier_slice_add(a : MathapproxfourierSlice, b : MathapproxfourierSlice) -> MathapproxfourierSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_approx_fourier_slice_copy(s : MathapproxfourierSlice) -> MathapproxfourierSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_approx_fourier_slice_fill(s : MathapproxfourierSlice, v : Double) -> MathapproxfourierSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_approx_fourier_slice_min(s : MathapproxfourierSlice) -> Double { @_common.min(s.data) }

pub fn math_approx_fourier_slice_max(s : MathapproxfourierSlice) -> Double { @_common.max(s.data) }

pub fn math_approx_fourier_slice_to_string(s : MathapproxfourierSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

