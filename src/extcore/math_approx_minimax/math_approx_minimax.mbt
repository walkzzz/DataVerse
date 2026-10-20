///===
/// extcore/math_approx_minimax

pub(all) struct MathapproxminimaxPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn math_approx_minimax_make_point(x : Double, y : Double) -> MathapproxminimaxPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn math_approx_minimax_make_point3(x : Double, y : Double, z : Double) -> MathapproxminimaxPoint {
  { x, y, z, label: 0 }
}

pub fn MathapproxminimaxPoint::x(self : MathapproxminimaxPoint) -> Double { self.x }

pub fn MathapproxminimaxPoint::y(self : MathapproxminimaxPoint) -> Double { self.y }

pub fn MathapproxminimaxPoint::z(self : MathapproxminimaxPoint) -> Double { self.z }

pub fn MathapproxminimaxPoint::label(self : MathapproxminimaxPoint) -> Int { self.label }

pub fn MathapproxminimaxPoint::dist(self : MathapproxminimaxPoint, other : MathapproxminimaxPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn MathapproxminimaxPoint::add(self : MathapproxminimaxPoint, other : MathapproxminimaxPoint) -> MathapproxminimaxPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn MathapproxminimaxPoint::sub(self : MathapproxminimaxPoint, other : MathapproxminimaxPoint) -> MathapproxminimaxPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn MathapproxminimaxPoint::scale(self : MathapproxminimaxPoint, s : Double) -> MathapproxminimaxPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn MathapproxminimaxPoint::dot(self : MathapproxminimaxPoint, other : MathapproxminimaxPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn MathapproxminimaxPoint::cross(self : MathapproxminimaxPoint, other : MathapproxminimaxPoint) -> MathapproxminimaxPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn MathapproxminimaxPoint::norm(self : MathapproxminimaxPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn MathapproxminimaxPoint::normalize(self : MathapproxminimaxPoint) -> MathapproxminimaxPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn MathapproxminimaxPoint::negate(self : MathapproxminimaxPoint) -> MathapproxminimaxPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn MathapproxminimaxPoint::mid(self : MathapproxminimaxPoint, other : MathapproxminimaxPoint) -> MathapproxminimaxPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn MathapproxminimaxPoint::lerp(self : MathapproxminimaxPoint, other : MathapproxminimaxPoint, t : Double) -> MathapproxminimaxPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn MathapproxminimaxPoint::to_string(self : MathapproxminimaxPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct MathapproxminimaxSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn math_approx_minimax_make_series(vals : Array[Double], name : String) -> MathapproxminimaxSeries {
  { vals, name, meta: 0 }
}

pub fn MathapproxminimaxSeries::len(self : MathapproxminimaxSeries) -> Int { self.vals.length() }

pub fn MathapproxminimaxSeries::sum(self : MathapproxminimaxSeries) -> Double { @_common.sum(self.vals) }

pub fn MathapproxminimaxSeries::mean(self : MathapproxminimaxSeries) -> Double { @_common.mean(self.vals) }

pub fn MathapproxminimaxSeries::min(self : MathapproxminimaxSeries) -> Double { @_common.min(self.vals) }

pub fn MathapproxminimaxSeries::max(self : MathapproxminimaxSeries) -> Double { @_common.max(self.vals) }

pub fn MathapproxminimaxSeries::range(self : MathapproxminimaxSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn MathapproxminimaxSeries::variance(self : MathapproxminimaxSeries) -> Double { @_common.variance(self.vals) }

pub fn MathapproxminimaxSeries::std(self : MathapproxminimaxSeries) -> Double { @_common.std(self.vals) }

pub fn MathapproxminimaxSeries::median(self : MathapproxminimaxSeries) -> Double { @_common.median(self.vals) }

pub fn MathapproxminimaxSeries::scale(self : MathapproxminimaxSeries, f : Double) -> MathapproxminimaxSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn MathapproxminimaxSeries::add(self : MathapproxminimaxSeries, other : MathapproxminimaxSeries) -> MathapproxminimaxSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn MathapproxminimaxSeries::sub(self : MathapproxminimaxSeries, other : MathapproxminimaxSeries) -> MathapproxminimaxSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn MathapproxminimaxSeries::normalize(self : MathapproxminimaxSeries) -> MathapproxminimaxSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn MathapproxminimaxSeries::cumsum(self : MathapproxminimaxSeries) -> MathapproxminimaxSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn MathapproxminimaxSeries::to_string(self : MathapproxminimaxSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct MathapproxminimaxMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn math_approx_minimax_make_matrix(rows : Int, cols : Int, val : Double) -> MathapproxminimaxMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn math_approx_minimax_matrix_identity(n : Int) -> MathapproxminimaxMatrix {
  let m = math_approx_minimax_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn MathapproxminimaxMatrix::get(self : MathapproxminimaxMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn MathapproxminimaxMatrix::transpose(self : MathapproxminimaxMatrix) -> MathapproxminimaxMatrix {
  let result = math_approx_minimax_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn MathapproxminimaxMatrix::add(self : MathapproxminimaxMatrix, other : MathapproxminimaxMatrix) -> MathapproxminimaxMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = math_approx_minimax_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn MathapproxminimaxMatrix::scale(self : MathapproxminimaxMatrix, s : Double) -> MathapproxminimaxMatrix {
  let result = math_approx_minimax_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn MathapproxminimaxMatrix::multiply(self : MathapproxminimaxMatrix, other : MathapproxminimaxMatrix) -> MathapproxminimaxMatrix {
  if self.cols != other.rows { return math_approx_minimax_make_matrix(self.rows, other.cols, 0.0) }
  let result = math_approx_minimax_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn MathapproxminimaxMatrix::trace(self : MathapproxminimaxMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn MathapproxminimaxMatrix::det(self : MathapproxminimaxMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn MathapproxminimaxMatrix::norm(self : MathapproxminimaxMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn MathapproxminimaxMatrix::to_string(self : MathapproxminimaxMatrix) -> String {
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

pub(all) struct MathapproxminimaxVector {
  comps : Array[Double]
  dim : Int
}

pub fn math_approx_minimax_make_vector(comps : Array[Double]) -> MathapproxminimaxVector {
  { comps, dim: comps.length() }
}

pub fn math_approx_minimax_vector_zero(dim : Int) -> MathapproxminimaxVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn MathapproxminimaxVector::add(self : MathapproxminimaxVector, other : MathapproxminimaxVector) -> MathapproxminimaxVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn MathapproxminimaxVector::sub(self : MathapproxminimaxVector, other : MathapproxminimaxVector) -> MathapproxminimaxVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn MathapproxminimaxVector::scale(self : MathapproxminimaxVector, s : Double) -> MathapproxminimaxVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn MathapproxminimaxVector::dot(self : MathapproxminimaxVector, other : MathapproxminimaxVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn MathapproxminimaxVector::norm(self : MathapproxminimaxVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn MathapproxminimaxVector::normalize(self : MathapproxminimaxVector) -> MathapproxminimaxVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn MathapproxminimaxVector::dist(self : MathapproxminimaxVector, other : MathapproxminimaxVector) -> Double {
  self.sub(other).norm()
}

pub fn MathapproxminimaxVector::to_string(self : MathapproxminimaxVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn math_approx_minimax_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn math_approx_minimax_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn math_approx_minimax_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn math_approx_minimax_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn math_approx_minimax_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn math_approx_minimax_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn math_approx_minimax_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn math_approx_minimax_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn math_approx_minimax_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn math_approx_minimax_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn math_approx_minimax_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn math_approx_minimax_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn math_approx_minimax_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn math_approx_minimax_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn math_approx_minimax_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn math_approx_minimax_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn math_approx_minimax_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn math_approx_minimax_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn math_approx_minimax_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn math_approx_minimax_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn math_approx_minimax_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn math_approx_minimax_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn math_approx_minimax_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn math_approx_minimax_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn math_approx_minimax_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn math_approx_minimax_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn math_approx_minimax_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn math_approx_minimax_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn math_approx_minimax_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct MathapproxminimaxFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_approx_minimax_frame_make(size : Int) -> MathapproxminimaxFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_approx_minimax_frame_len(s : MathapproxminimaxFrame) -> Int { s.size }

pub fn math_approx_minimax_frame_get(s : MathapproxminimaxFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_approx_minimax_frame_set(s : MathapproxminimaxFrame, i : Int, v : Double) -> MathapproxminimaxFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_approx_minimax_frame_sum(s : MathapproxminimaxFrame) -> Double { @_common.sum(s.data) }

pub fn math_approx_minimax_frame_mean(s : MathapproxminimaxFrame) -> Double { @_common.mean(s.data) }

pub fn math_approx_minimax_frame_scale(s : MathapproxminimaxFrame, f : Double) -> MathapproxminimaxFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_approx_minimax_frame_add(a : MathapproxminimaxFrame, b : MathapproxminimaxFrame) -> MathapproxminimaxFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_approx_minimax_frame_copy(s : MathapproxminimaxFrame) -> MathapproxminimaxFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_approx_minimax_frame_fill(s : MathapproxminimaxFrame, v : Double) -> MathapproxminimaxFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_approx_minimax_frame_min(s : MathapproxminimaxFrame) -> Double { @_common.min(s.data) }

pub fn math_approx_minimax_frame_max(s : MathapproxminimaxFrame) -> Double { @_common.max(s.data) }

pub fn math_approx_minimax_frame_to_string(s : MathapproxminimaxFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathapproxminimaxTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_approx_minimax_table_make(size : Int) -> MathapproxminimaxTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_approx_minimax_table_len(s : MathapproxminimaxTable) -> Int { s.size }

pub fn math_approx_minimax_table_get(s : MathapproxminimaxTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_approx_minimax_table_set(s : MathapproxminimaxTable, i : Int, v : Double) -> MathapproxminimaxTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_approx_minimax_table_sum(s : MathapproxminimaxTable) -> Double { @_common.sum(s.data) }

pub fn math_approx_minimax_table_mean(s : MathapproxminimaxTable) -> Double { @_common.mean(s.data) }

pub fn math_approx_minimax_table_scale(s : MathapproxminimaxTable, f : Double) -> MathapproxminimaxTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_approx_minimax_table_add(a : MathapproxminimaxTable, b : MathapproxminimaxTable) -> MathapproxminimaxTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_approx_minimax_table_copy(s : MathapproxminimaxTable) -> MathapproxminimaxTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_approx_minimax_table_fill(s : MathapproxminimaxTable, v : Double) -> MathapproxminimaxTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_approx_minimax_table_min(s : MathapproxminimaxTable) -> Double { @_common.min(s.data) }

pub fn math_approx_minimax_table_max(s : MathapproxminimaxTable) -> Double { @_common.max(s.data) }

pub fn math_approx_minimax_table_to_string(s : MathapproxminimaxTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathapproxminimaxGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_approx_minimax_graphn_make(size : Int) -> MathapproxminimaxGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_approx_minimax_graphn_len(s : MathapproxminimaxGraphN) -> Int { s.size }

pub fn math_approx_minimax_graphn_get(s : MathapproxminimaxGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_approx_minimax_graphn_set(s : MathapproxminimaxGraphN, i : Int, v : Double) -> MathapproxminimaxGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_approx_minimax_graphn_sum(s : MathapproxminimaxGraphN) -> Double { @_common.sum(s.data) }

pub fn math_approx_minimax_graphn_mean(s : MathapproxminimaxGraphN) -> Double { @_common.mean(s.data) }

pub fn math_approx_minimax_graphn_scale(s : MathapproxminimaxGraphN, f : Double) -> MathapproxminimaxGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_approx_minimax_graphn_add(a : MathapproxminimaxGraphN, b : MathapproxminimaxGraphN) -> MathapproxminimaxGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_approx_minimax_graphn_copy(s : MathapproxminimaxGraphN) -> MathapproxminimaxGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_approx_minimax_graphn_fill(s : MathapproxminimaxGraphN, v : Double) -> MathapproxminimaxGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_approx_minimax_graphn_min(s : MathapproxminimaxGraphN) -> Double { @_common.min(s.data) }

pub fn math_approx_minimax_graphn_max(s : MathapproxminimaxGraphN) -> Double { @_common.max(s.data) }

pub fn math_approx_minimax_graphn_to_string(s : MathapproxminimaxGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathapproxminimaxNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_approx_minimax_node_make(size : Int) -> MathapproxminimaxNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_approx_minimax_node_len(s : MathapproxminimaxNode) -> Int { s.size }

pub fn math_approx_minimax_node_get(s : MathapproxminimaxNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_approx_minimax_node_set(s : MathapproxminimaxNode, i : Int, v : Double) -> MathapproxminimaxNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_approx_minimax_node_sum(s : MathapproxminimaxNode) -> Double { @_common.sum(s.data) }

pub fn math_approx_minimax_node_mean(s : MathapproxminimaxNode) -> Double { @_common.mean(s.data) }

pub fn math_approx_minimax_node_scale(s : MathapproxminimaxNode, f : Double) -> MathapproxminimaxNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_approx_minimax_node_add(a : MathapproxminimaxNode, b : MathapproxminimaxNode) -> MathapproxminimaxNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_approx_minimax_node_copy(s : MathapproxminimaxNode) -> MathapproxminimaxNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_approx_minimax_node_fill(s : MathapproxminimaxNode, v : Double) -> MathapproxminimaxNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_approx_minimax_node_min(s : MathapproxminimaxNode) -> Double { @_common.min(s.data) }

pub fn math_approx_minimax_node_max(s : MathapproxminimaxNode) -> Double { @_common.max(s.data) }

pub fn math_approx_minimax_node_to_string(s : MathapproxminimaxNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathapproxminimaxEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_approx_minimax_edge_make(size : Int) -> MathapproxminimaxEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_approx_minimax_edge_len(s : MathapproxminimaxEdge) -> Int { s.size }

pub fn math_approx_minimax_edge_get(s : MathapproxminimaxEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_approx_minimax_edge_set(s : MathapproxminimaxEdge, i : Int, v : Double) -> MathapproxminimaxEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_approx_minimax_edge_sum(s : MathapproxminimaxEdge) -> Double { @_common.sum(s.data) }

pub fn math_approx_minimax_edge_mean(s : MathapproxminimaxEdge) -> Double { @_common.mean(s.data) }

pub fn math_approx_minimax_edge_scale(s : MathapproxminimaxEdge, f : Double) -> MathapproxminimaxEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_approx_minimax_edge_add(a : MathapproxminimaxEdge, b : MathapproxminimaxEdge) -> MathapproxminimaxEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_approx_minimax_edge_copy(s : MathapproxminimaxEdge) -> MathapproxminimaxEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_approx_minimax_edge_fill(s : MathapproxminimaxEdge, v : Double) -> MathapproxminimaxEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_approx_minimax_edge_min(s : MathapproxminimaxEdge) -> Double { @_common.min(s.data) }

pub fn math_approx_minimax_edge_max(s : MathapproxminimaxEdge) -> Double { @_common.max(s.data) }

pub fn math_approx_minimax_edge_to_string(s : MathapproxminimaxEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathapproxminimaxPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_approx_minimax_path_make(size : Int) -> MathapproxminimaxPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_approx_minimax_path_len(s : MathapproxminimaxPath) -> Int { s.size }

pub fn math_approx_minimax_path_get(s : MathapproxminimaxPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_approx_minimax_path_set(s : MathapproxminimaxPath, i : Int, v : Double) -> MathapproxminimaxPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_approx_minimax_path_sum(s : MathapproxminimaxPath) -> Double { @_common.sum(s.data) }

pub fn math_approx_minimax_path_mean(s : MathapproxminimaxPath) -> Double { @_common.mean(s.data) }

pub fn math_approx_minimax_path_scale(s : MathapproxminimaxPath, f : Double) -> MathapproxminimaxPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_approx_minimax_path_add(a : MathapproxminimaxPath, b : MathapproxminimaxPath) -> MathapproxminimaxPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_approx_minimax_path_copy(s : MathapproxminimaxPath) -> MathapproxminimaxPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_approx_minimax_path_fill(s : MathapproxminimaxPath, v : Double) -> MathapproxminimaxPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_approx_minimax_path_min(s : MathapproxminimaxPath) -> Double { @_common.min(s.data) }

pub fn math_approx_minimax_path_max(s : MathapproxminimaxPath) -> Double { @_common.max(s.data) }

pub fn math_approx_minimax_path_to_string(s : MathapproxminimaxPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathapproxminimaxCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_approx_minimax_cluster_make(size : Int) -> MathapproxminimaxCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_approx_minimax_cluster_len(s : MathapproxminimaxCluster) -> Int { s.size }

pub fn math_approx_minimax_cluster_get(s : MathapproxminimaxCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_approx_minimax_cluster_set(s : MathapproxminimaxCluster, i : Int, v : Double) -> MathapproxminimaxCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_approx_minimax_cluster_sum(s : MathapproxminimaxCluster) -> Double { @_common.sum(s.data) }

pub fn math_approx_minimax_cluster_mean(s : MathapproxminimaxCluster) -> Double { @_common.mean(s.data) }

pub fn math_approx_minimax_cluster_scale(s : MathapproxminimaxCluster, f : Double) -> MathapproxminimaxCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_approx_minimax_cluster_add(a : MathapproxminimaxCluster, b : MathapproxminimaxCluster) -> MathapproxminimaxCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_approx_minimax_cluster_copy(s : MathapproxminimaxCluster) -> MathapproxminimaxCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_approx_minimax_cluster_fill(s : MathapproxminimaxCluster, v : Double) -> MathapproxminimaxCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_approx_minimax_cluster_min(s : MathapproxminimaxCluster) -> Double { @_common.min(s.data) }

pub fn math_approx_minimax_cluster_max(s : MathapproxminimaxCluster) -> Double { @_common.max(s.data) }

pub fn math_approx_minimax_cluster_to_string(s : MathapproxminimaxCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathapproxminimaxModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_approx_minimax_model_make(size : Int) -> MathapproxminimaxModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_approx_minimax_model_len(s : MathapproxminimaxModel) -> Int { s.size }

pub fn math_approx_minimax_model_get(s : MathapproxminimaxModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_approx_minimax_model_set(s : MathapproxminimaxModel, i : Int, v : Double) -> MathapproxminimaxModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_approx_minimax_model_sum(s : MathapproxminimaxModel) -> Double { @_common.sum(s.data) }

pub fn math_approx_minimax_model_mean(s : MathapproxminimaxModel) -> Double { @_common.mean(s.data) }

pub fn math_approx_minimax_model_scale(s : MathapproxminimaxModel, f : Double) -> MathapproxminimaxModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_approx_minimax_model_add(a : MathapproxminimaxModel, b : MathapproxminimaxModel) -> MathapproxminimaxModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_approx_minimax_model_copy(s : MathapproxminimaxModel) -> MathapproxminimaxModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_approx_minimax_model_fill(s : MathapproxminimaxModel, v : Double) -> MathapproxminimaxModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_approx_minimax_model_min(s : MathapproxminimaxModel) -> Double { @_common.min(s.data) }

pub fn math_approx_minimax_model_max(s : MathapproxminimaxModel) -> Double { @_common.max(s.data) }

pub fn math_approx_minimax_model_to_string(s : MathapproxminimaxModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathapproxminimaxLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_approx_minimax_layer_make(size : Int) -> MathapproxminimaxLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_approx_minimax_layer_len(s : MathapproxminimaxLayer) -> Int { s.size }

pub fn math_approx_minimax_layer_get(s : MathapproxminimaxLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_approx_minimax_layer_set(s : MathapproxminimaxLayer, i : Int, v : Double) -> MathapproxminimaxLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_approx_minimax_layer_sum(s : MathapproxminimaxLayer) -> Double { @_common.sum(s.data) }

pub fn math_approx_minimax_layer_mean(s : MathapproxminimaxLayer) -> Double { @_common.mean(s.data) }

pub fn math_approx_minimax_layer_scale(s : MathapproxminimaxLayer, f : Double) -> MathapproxminimaxLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_approx_minimax_layer_add(a : MathapproxminimaxLayer, b : MathapproxminimaxLayer) -> MathapproxminimaxLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_approx_minimax_layer_copy(s : MathapproxminimaxLayer) -> MathapproxminimaxLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_approx_minimax_layer_fill(s : MathapproxminimaxLayer, v : Double) -> MathapproxminimaxLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_approx_minimax_layer_min(s : MathapproxminimaxLayer) -> Double { @_common.min(s.data) }

pub fn math_approx_minimax_layer_max(s : MathapproxminimaxLayer) -> Double { @_common.max(s.data) }

pub fn math_approx_minimax_layer_to_string(s : MathapproxminimaxLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathapproxminimaxBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_approx_minimax_buffer_make(size : Int) -> MathapproxminimaxBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_approx_minimax_buffer_len(s : MathapproxminimaxBuffer) -> Int { s.size }

pub fn math_approx_minimax_buffer_get(s : MathapproxminimaxBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_approx_minimax_buffer_set(s : MathapproxminimaxBuffer, i : Int, v : Double) -> MathapproxminimaxBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_approx_minimax_buffer_sum(s : MathapproxminimaxBuffer) -> Double { @_common.sum(s.data) }

pub fn math_approx_minimax_buffer_mean(s : MathapproxminimaxBuffer) -> Double { @_common.mean(s.data) }

pub fn math_approx_minimax_buffer_scale(s : MathapproxminimaxBuffer, f : Double) -> MathapproxminimaxBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_approx_minimax_buffer_add(a : MathapproxminimaxBuffer, b : MathapproxminimaxBuffer) -> MathapproxminimaxBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_approx_minimax_buffer_copy(s : MathapproxminimaxBuffer) -> MathapproxminimaxBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_approx_minimax_buffer_fill(s : MathapproxminimaxBuffer, v : Double) -> MathapproxminimaxBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_approx_minimax_buffer_min(s : MathapproxminimaxBuffer) -> Double { @_common.min(s.data) }

pub fn math_approx_minimax_buffer_max(s : MathapproxminimaxBuffer) -> Double { @_common.max(s.data) }

pub fn math_approx_minimax_buffer_to_string(s : MathapproxminimaxBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathapproxminimaxCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_approx_minimax_cursor_make(size : Int) -> MathapproxminimaxCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_approx_minimax_cursor_len(s : MathapproxminimaxCursor) -> Int { s.size }

pub fn math_approx_minimax_cursor_get(s : MathapproxminimaxCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_approx_minimax_cursor_set(s : MathapproxminimaxCursor, i : Int, v : Double) -> MathapproxminimaxCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_approx_minimax_cursor_sum(s : MathapproxminimaxCursor) -> Double { @_common.sum(s.data) }

pub fn math_approx_minimax_cursor_mean(s : MathapproxminimaxCursor) -> Double { @_common.mean(s.data) }

pub fn math_approx_minimax_cursor_scale(s : MathapproxminimaxCursor, f : Double) -> MathapproxminimaxCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_approx_minimax_cursor_add(a : MathapproxminimaxCursor, b : MathapproxminimaxCursor) -> MathapproxminimaxCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_approx_minimax_cursor_copy(s : MathapproxminimaxCursor) -> MathapproxminimaxCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_approx_minimax_cursor_fill(s : MathapproxminimaxCursor, v : Double) -> MathapproxminimaxCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_approx_minimax_cursor_min(s : MathapproxminimaxCursor) -> Double { @_common.min(s.data) }

pub fn math_approx_minimax_cursor_max(s : MathapproxminimaxCursor) -> Double { @_common.max(s.data) }

pub fn math_approx_minimax_cursor_to_string(s : MathapproxminimaxCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathapproxminimaxView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_approx_minimax_view_make(size : Int) -> MathapproxminimaxView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_approx_minimax_view_len(s : MathapproxminimaxView) -> Int { s.size }

pub fn math_approx_minimax_view_get(s : MathapproxminimaxView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_approx_minimax_view_set(s : MathapproxminimaxView, i : Int, v : Double) -> MathapproxminimaxView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_approx_minimax_view_sum(s : MathapproxminimaxView) -> Double { @_common.sum(s.data) }

pub fn math_approx_minimax_view_mean(s : MathapproxminimaxView) -> Double { @_common.mean(s.data) }

pub fn math_approx_minimax_view_scale(s : MathapproxminimaxView, f : Double) -> MathapproxminimaxView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_approx_minimax_view_add(a : MathapproxminimaxView, b : MathapproxminimaxView) -> MathapproxminimaxView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_approx_minimax_view_copy(s : MathapproxminimaxView) -> MathapproxminimaxView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_approx_minimax_view_fill(s : MathapproxminimaxView, v : Double) -> MathapproxminimaxView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_approx_minimax_view_min(s : MathapproxminimaxView) -> Double { @_common.min(s.data) }

pub fn math_approx_minimax_view_max(s : MathapproxminimaxView) -> Double { @_common.max(s.data) }

pub fn math_approx_minimax_view_to_string(s : MathapproxminimaxView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathapproxminimaxRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_approx_minimax_range_make(size : Int) -> MathapproxminimaxRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_approx_minimax_range_len(s : MathapproxminimaxRange) -> Int { s.size }

pub fn math_approx_minimax_range_get(s : MathapproxminimaxRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_approx_minimax_range_set(s : MathapproxminimaxRange, i : Int, v : Double) -> MathapproxminimaxRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_approx_minimax_range_sum(s : MathapproxminimaxRange) -> Double { @_common.sum(s.data) }

pub fn math_approx_minimax_range_mean(s : MathapproxminimaxRange) -> Double { @_common.mean(s.data) }

pub fn math_approx_minimax_range_scale(s : MathapproxminimaxRange, f : Double) -> MathapproxminimaxRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_approx_minimax_range_add(a : MathapproxminimaxRange, b : MathapproxminimaxRange) -> MathapproxminimaxRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_approx_minimax_range_copy(s : MathapproxminimaxRange) -> MathapproxminimaxRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_approx_minimax_range_fill(s : MathapproxminimaxRange, v : Double) -> MathapproxminimaxRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_approx_minimax_range_min(s : MathapproxminimaxRange) -> Double { @_common.min(s.data) }

pub fn math_approx_minimax_range_max(s : MathapproxminimaxRange) -> Double { @_common.max(s.data) }

pub fn math_approx_minimax_range_to_string(s : MathapproxminimaxRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathapproxminimaxSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_approx_minimax_slice_make(size : Int) -> MathapproxminimaxSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_approx_minimax_slice_len(s : MathapproxminimaxSlice) -> Int { s.size }

pub fn math_approx_minimax_slice_get(s : MathapproxminimaxSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_approx_minimax_slice_set(s : MathapproxminimaxSlice, i : Int, v : Double) -> MathapproxminimaxSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_approx_minimax_slice_sum(s : MathapproxminimaxSlice) -> Double { @_common.sum(s.data) }

pub fn math_approx_minimax_slice_mean(s : MathapproxminimaxSlice) -> Double { @_common.mean(s.data) }

pub fn math_approx_minimax_slice_scale(s : MathapproxminimaxSlice, f : Double) -> MathapproxminimaxSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_approx_minimax_slice_add(a : MathapproxminimaxSlice, b : MathapproxminimaxSlice) -> MathapproxminimaxSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_approx_minimax_slice_copy(s : MathapproxminimaxSlice) -> MathapproxminimaxSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_approx_minimax_slice_fill(s : MathapproxminimaxSlice, v : Double) -> MathapproxminimaxSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_approx_minimax_slice_min(s : MathapproxminimaxSlice) -> Double { @_common.min(s.data) }

pub fn math_approx_minimax_slice_max(s : MathapproxminimaxSlice) -> Double { @_common.max(s.data) }

pub fn math_approx_minimax_slice_to_string(s : MathapproxminimaxSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

