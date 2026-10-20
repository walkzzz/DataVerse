///===
/// extcore/math_nonlinear_prog

pub(all) struct MathnonlinearprogPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn math_nonlinear_prog_make_point(x : Double, y : Double) -> MathnonlinearprogPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn math_nonlinear_prog_make_point3(x : Double, y : Double, z : Double) -> MathnonlinearprogPoint {
  { x, y, z, label: 0 }
}

pub fn MathnonlinearprogPoint::x(self : MathnonlinearprogPoint) -> Double { self.x }

pub fn MathnonlinearprogPoint::y(self : MathnonlinearprogPoint) -> Double { self.y }

pub fn MathnonlinearprogPoint::z(self : MathnonlinearprogPoint) -> Double { self.z }

pub fn MathnonlinearprogPoint::label(self : MathnonlinearprogPoint) -> Int { self.label }

pub fn MathnonlinearprogPoint::dist(self : MathnonlinearprogPoint, other : MathnonlinearprogPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn MathnonlinearprogPoint::add(self : MathnonlinearprogPoint, other : MathnonlinearprogPoint) -> MathnonlinearprogPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn MathnonlinearprogPoint::sub(self : MathnonlinearprogPoint, other : MathnonlinearprogPoint) -> MathnonlinearprogPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn MathnonlinearprogPoint::scale(self : MathnonlinearprogPoint, s : Double) -> MathnonlinearprogPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn MathnonlinearprogPoint::dot(self : MathnonlinearprogPoint, other : MathnonlinearprogPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn MathnonlinearprogPoint::cross(self : MathnonlinearprogPoint, other : MathnonlinearprogPoint) -> MathnonlinearprogPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn MathnonlinearprogPoint::norm(self : MathnonlinearprogPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn MathnonlinearprogPoint::normalize(self : MathnonlinearprogPoint) -> MathnonlinearprogPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn MathnonlinearprogPoint::negate(self : MathnonlinearprogPoint) -> MathnonlinearprogPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn MathnonlinearprogPoint::mid(self : MathnonlinearprogPoint, other : MathnonlinearprogPoint) -> MathnonlinearprogPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn MathnonlinearprogPoint::lerp(self : MathnonlinearprogPoint, other : MathnonlinearprogPoint, t : Double) -> MathnonlinearprogPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn MathnonlinearprogPoint::to_string(self : MathnonlinearprogPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct MathnonlinearprogSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn math_nonlinear_prog_make_series(vals : Array[Double], name : String) -> MathnonlinearprogSeries {
  { vals, name, meta: 0 }
}

pub fn MathnonlinearprogSeries::len(self : MathnonlinearprogSeries) -> Int { self.vals.length() }

pub fn MathnonlinearprogSeries::sum(self : MathnonlinearprogSeries) -> Double { @_common.sum(self.vals) }

pub fn MathnonlinearprogSeries::mean(self : MathnonlinearprogSeries) -> Double { @_common.mean(self.vals) }

pub fn MathnonlinearprogSeries::min(self : MathnonlinearprogSeries) -> Double { @_common.min(self.vals) }

pub fn MathnonlinearprogSeries::max(self : MathnonlinearprogSeries) -> Double { @_common.max(self.vals) }

pub fn MathnonlinearprogSeries::range(self : MathnonlinearprogSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn MathnonlinearprogSeries::variance(self : MathnonlinearprogSeries) -> Double { @_common.variance(self.vals) }

pub fn MathnonlinearprogSeries::std(self : MathnonlinearprogSeries) -> Double { @_common.std(self.vals) }

pub fn MathnonlinearprogSeries::median(self : MathnonlinearprogSeries) -> Double { @_common.median(self.vals) }

pub fn MathnonlinearprogSeries::scale(self : MathnonlinearprogSeries, f : Double) -> MathnonlinearprogSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn MathnonlinearprogSeries::add(self : MathnonlinearprogSeries, other : MathnonlinearprogSeries) -> MathnonlinearprogSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn MathnonlinearprogSeries::sub(self : MathnonlinearprogSeries, other : MathnonlinearprogSeries) -> MathnonlinearprogSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn MathnonlinearprogSeries::normalize(self : MathnonlinearprogSeries) -> MathnonlinearprogSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn MathnonlinearprogSeries::cumsum(self : MathnonlinearprogSeries) -> MathnonlinearprogSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn MathnonlinearprogSeries::to_string(self : MathnonlinearprogSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct MathnonlinearprogMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn math_nonlinear_prog_make_matrix(rows : Int, cols : Int, val : Double) -> MathnonlinearprogMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn math_nonlinear_prog_matrix_identity(n : Int) -> MathnonlinearprogMatrix {
  let m = math_nonlinear_prog_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn MathnonlinearprogMatrix::get(self : MathnonlinearprogMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn MathnonlinearprogMatrix::transpose(self : MathnonlinearprogMatrix) -> MathnonlinearprogMatrix {
  let result = math_nonlinear_prog_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn MathnonlinearprogMatrix::add(self : MathnonlinearprogMatrix, other : MathnonlinearprogMatrix) -> MathnonlinearprogMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = math_nonlinear_prog_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn MathnonlinearprogMatrix::scale(self : MathnonlinearprogMatrix, s : Double) -> MathnonlinearprogMatrix {
  let result = math_nonlinear_prog_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn MathnonlinearprogMatrix::multiply(self : MathnonlinearprogMatrix, other : MathnonlinearprogMatrix) -> MathnonlinearprogMatrix {
  if self.cols != other.rows { return math_nonlinear_prog_make_matrix(self.rows, other.cols, 0.0) }
  let result = math_nonlinear_prog_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn MathnonlinearprogMatrix::trace(self : MathnonlinearprogMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn MathnonlinearprogMatrix::det(self : MathnonlinearprogMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn MathnonlinearprogMatrix::norm(self : MathnonlinearprogMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn MathnonlinearprogMatrix::to_string(self : MathnonlinearprogMatrix) -> String {
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

pub(all) struct MathnonlinearprogVector {
  comps : Array[Double]
  dim : Int
}

pub fn math_nonlinear_prog_make_vector(comps : Array[Double]) -> MathnonlinearprogVector {
  { comps, dim: comps.length() }
}

pub fn math_nonlinear_prog_vector_zero(dim : Int) -> MathnonlinearprogVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn MathnonlinearprogVector::add(self : MathnonlinearprogVector, other : MathnonlinearprogVector) -> MathnonlinearprogVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn MathnonlinearprogVector::sub(self : MathnonlinearprogVector, other : MathnonlinearprogVector) -> MathnonlinearprogVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn MathnonlinearprogVector::scale(self : MathnonlinearprogVector, s : Double) -> MathnonlinearprogVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn MathnonlinearprogVector::dot(self : MathnonlinearprogVector, other : MathnonlinearprogVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn MathnonlinearprogVector::norm(self : MathnonlinearprogVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn MathnonlinearprogVector::normalize(self : MathnonlinearprogVector) -> MathnonlinearprogVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn MathnonlinearprogVector::dist(self : MathnonlinearprogVector, other : MathnonlinearprogVector) -> Double {
  self.sub(other).norm()
}

pub fn MathnonlinearprogVector::to_string(self : MathnonlinearprogVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn math_nonlinear_prog_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn math_nonlinear_prog_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn math_nonlinear_prog_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn math_nonlinear_prog_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn math_nonlinear_prog_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn math_nonlinear_prog_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn math_nonlinear_prog_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn math_nonlinear_prog_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn math_nonlinear_prog_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn math_nonlinear_prog_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn math_nonlinear_prog_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn math_nonlinear_prog_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn math_nonlinear_prog_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn math_nonlinear_prog_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn math_nonlinear_prog_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn math_nonlinear_prog_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn math_nonlinear_prog_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn math_nonlinear_prog_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn math_nonlinear_prog_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn math_nonlinear_prog_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn math_nonlinear_prog_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn math_nonlinear_prog_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn math_nonlinear_prog_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn math_nonlinear_prog_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn math_nonlinear_prog_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn math_nonlinear_prog_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn math_nonlinear_prog_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn math_nonlinear_prog_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn math_nonlinear_prog_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct MathnonlinearprogFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_nonlinear_prog_frame_make(size : Int) -> MathnonlinearprogFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_nonlinear_prog_frame_len(s : MathnonlinearprogFrame) -> Int { s.size }

pub fn math_nonlinear_prog_frame_get(s : MathnonlinearprogFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_nonlinear_prog_frame_set(s : MathnonlinearprogFrame, i : Int, v : Double) -> MathnonlinearprogFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_nonlinear_prog_frame_sum(s : MathnonlinearprogFrame) -> Double { @_common.sum(s.data) }

pub fn math_nonlinear_prog_frame_mean(s : MathnonlinearprogFrame) -> Double { @_common.mean(s.data) }

pub fn math_nonlinear_prog_frame_scale(s : MathnonlinearprogFrame, f : Double) -> MathnonlinearprogFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_nonlinear_prog_frame_add(a : MathnonlinearprogFrame, b : MathnonlinearprogFrame) -> MathnonlinearprogFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_nonlinear_prog_frame_copy(s : MathnonlinearprogFrame) -> MathnonlinearprogFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_nonlinear_prog_frame_fill(s : MathnonlinearprogFrame, v : Double) -> MathnonlinearprogFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_nonlinear_prog_frame_min(s : MathnonlinearprogFrame) -> Double { @_common.min(s.data) }

pub fn math_nonlinear_prog_frame_max(s : MathnonlinearprogFrame) -> Double { @_common.max(s.data) }

pub fn math_nonlinear_prog_frame_to_string(s : MathnonlinearprogFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathnonlinearprogTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_nonlinear_prog_table_make(size : Int) -> MathnonlinearprogTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_nonlinear_prog_table_len(s : MathnonlinearprogTable) -> Int { s.size }

pub fn math_nonlinear_prog_table_get(s : MathnonlinearprogTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_nonlinear_prog_table_set(s : MathnonlinearprogTable, i : Int, v : Double) -> MathnonlinearprogTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_nonlinear_prog_table_sum(s : MathnonlinearprogTable) -> Double { @_common.sum(s.data) }

pub fn math_nonlinear_prog_table_mean(s : MathnonlinearprogTable) -> Double { @_common.mean(s.data) }

pub fn math_nonlinear_prog_table_scale(s : MathnonlinearprogTable, f : Double) -> MathnonlinearprogTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_nonlinear_prog_table_add(a : MathnonlinearprogTable, b : MathnonlinearprogTable) -> MathnonlinearprogTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_nonlinear_prog_table_copy(s : MathnonlinearprogTable) -> MathnonlinearprogTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_nonlinear_prog_table_fill(s : MathnonlinearprogTable, v : Double) -> MathnonlinearprogTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_nonlinear_prog_table_min(s : MathnonlinearprogTable) -> Double { @_common.min(s.data) }

pub fn math_nonlinear_prog_table_max(s : MathnonlinearprogTable) -> Double { @_common.max(s.data) }

pub fn math_nonlinear_prog_table_to_string(s : MathnonlinearprogTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathnonlinearprogGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_nonlinear_prog_graphn_make(size : Int) -> MathnonlinearprogGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_nonlinear_prog_graphn_len(s : MathnonlinearprogGraphN) -> Int { s.size }

pub fn math_nonlinear_prog_graphn_get(s : MathnonlinearprogGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_nonlinear_prog_graphn_set(s : MathnonlinearprogGraphN, i : Int, v : Double) -> MathnonlinearprogGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_nonlinear_prog_graphn_sum(s : MathnonlinearprogGraphN) -> Double { @_common.sum(s.data) }

pub fn math_nonlinear_prog_graphn_mean(s : MathnonlinearprogGraphN) -> Double { @_common.mean(s.data) }

pub fn math_nonlinear_prog_graphn_scale(s : MathnonlinearprogGraphN, f : Double) -> MathnonlinearprogGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_nonlinear_prog_graphn_add(a : MathnonlinearprogGraphN, b : MathnonlinearprogGraphN) -> MathnonlinearprogGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_nonlinear_prog_graphn_copy(s : MathnonlinearprogGraphN) -> MathnonlinearprogGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_nonlinear_prog_graphn_fill(s : MathnonlinearprogGraphN, v : Double) -> MathnonlinearprogGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_nonlinear_prog_graphn_min(s : MathnonlinearprogGraphN) -> Double { @_common.min(s.data) }

pub fn math_nonlinear_prog_graphn_max(s : MathnonlinearprogGraphN) -> Double { @_common.max(s.data) }

pub fn math_nonlinear_prog_graphn_to_string(s : MathnonlinearprogGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathnonlinearprogNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_nonlinear_prog_node_make(size : Int) -> MathnonlinearprogNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_nonlinear_prog_node_len(s : MathnonlinearprogNode) -> Int { s.size }

pub fn math_nonlinear_prog_node_get(s : MathnonlinearprogNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_nonlinear_prog_node_set(s : MathnonlinearprogNode, i : Int, v : Double) -> MathnonlinearprogNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_nonlinear_prog_node_sum(s : MathnonlinearprogNode) -> Double { @_common.sum(s.data) }

pub fn math_nonlinear_prog_node_mean(s : MathnonlinearprogNode) -> Double { @_common.mean(s.data) }

pub fn math_nonlinear_prog_node_scale(s : MathnonlinearprogNode, f : Double) -> MathnonlinearprogNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_nonlinear_prog_node_add(a : MathnonlinearprogNode, b : MathnonlinearprogNode) -> MathnonlinearprogNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_nonlinear_prog_node_copy(s : MathnonlinearprogNode) -> MathnonlinearprogNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_nonlinear_prog_node_fill(s : MathnonlinearprogNode, v : Double) -> MathnonlinearprogNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_nonlinear_prog_node_min(s : MathnonlinearprogNode) -> Double { @_common.min(s.data) }

pub fn math_nonlinear_prog_node_max(s : MathnonlinearprogNode) -> Double { @_common.max(s.data) }

pub fn math_nonlinear_prog_node_to_string(s : MathnonlinearprogNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathnonlinearprogEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_nonlinear_prog_edge_make(size : Int) -> MathnonlinearprogEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_nonlinear_prog_edge_len(s : MathnonlinearprogEdge) -> Int { s.size }

pub fn math_nonlinear_prog_edge_get(s : MathnonlinearprogEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_nonlinear_prog_edge_set(s : MathnonlinearprogEdge, i : Int, v : Double) -> MathnonlinearprogEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_nonlinear_prog_edge_sum(s : MathnonlinearprogEdge) -> Double { @_common.sum(s.data) }

pub fn math_nonlinear_prog_edge_mean(s : MathnonlinearprogEdge) -> Double { @_common.mean(s.data) }

pub fn math_nonlinear_prog_edge_scale(s : MathnonlinearprogEdge, f : Double) -> MathnonlinearprogEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_nonlinear_prog_edge_add(a : MathnonlinearprogEdge, b : MathnonlinearprogEdge) -> MathnonlinearprogEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_nonlinear_prog_edge_copy(s : MathnonlinearprogEdge) -> MathnonlinearprogEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_nonlinear_prog_edge_fill(s : MathnonlinearprogEdge, v : Double) -> MathnonlinearprogEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_nonlinear_prog_edge_min(s : MathnonlinearprogEdge) -> Double { @_common.min(s.data) }

pub fn math_nonlinear_prog_edge_max(s : MathnonlinearprogEdge) -> Double { @_common.max(s.data) }

pub fn math_nonlinear_prog_edge_to_string(s : MathnonlinearprogEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathnonlinearprogPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_nonlinear_prog_path_make(size : Int) -> MathnonlinearprogPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_nonlinear_prog_path_len(s : MathnonlinearprogPath) -> Int { s.size }

pub fn math_nonlinear_prog_path_get(s : MathnonlinearprogPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_nonlinear_prog_path_set(s : MathnonlinearprogPath, i : Int, v : Double) -> MathnonlinearprogPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_nonlinear_prog_path_sum(s : MathnonlinearprogPath) -> Double { @_common.sum(s.data) }

pub fn math_nonlinear_prog_path_mean(s : MathnonlinearprogPath) -> Double { @_common.mean(s.data) }

pub fn math_nonlinear_prog_path_scale(s : MathnonlinearprogPath, f : Double) -> MathnonlinearprogPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_nonlinear_prog_path_add(a : MathnonlinearprogPath, b : MathnonlinearprogPath) -> MathnonlinearprogPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_nonlinear_prog_path_copy(s : MathnonlinearprogPath) -> MathnonlinearprogPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_nonlinear_prog_path_fill(s : MathnonlinearprogPath, v : Double) -> MathnonlinearprogPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_nonlinear_prog_path_min(s : MathnonlinearprogPath) -> Double { @_common.min(s.data) }

pub fn math_nonlinear_prog_path_max(s : MathnonlinearprogPath) -> Double { @_common.max(s.data) }

pub fn math_nonlinear_prog_path_to_string(s : MathnonlinearprogPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathnonlinearprogCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_nonlinear_prog_cluster_make(size : Int) -> MathnonlinearprogCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_nonlinear_prog_cluster_len(s : MathnonlinearprogCluster) -> Int { s.size }

pub fn math_nonlinear_prog_cluster_get(s : MathnonlinearprogCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_nonlinear_prog_cluster_set(s : MathnonlinearprogCluster, i : Int, v : Double) -> MathnonlinearprogCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_nonlinear_prog_cluster_sum(s : MathnonlinearprogCluster) -> Double { @_common.sum(s.data) }

pub fn math_nonlinear_prog_cluster_mean(s : MathnonlinearprogCluster) -> Double { @_common.mean(s.data) }

pub fn math_nonlinear_prog_cluster_scale(s : MathnonlinearprogCluster, f : Double) -> MathnonlinearprogCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_nonlinear_prog_cluster_add(a : MathnonlinearprogCluster, b : MathnonlinearprogCluster) -> MathnonlinearprogCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_nonlinear_prog_cluster_copy(s : MathnonlinearprogCluster) -> MathnonlinearprogCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_nonlinear_prog_cluster_fill(s : MathnonlinearprogCluster, v : Double) -> MathnonlinearprogCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_nonlinear_prog_cluster_min(s : MathnonlinearprogCluster) -> Double { @_common.min(s.data) }

pub fn math_nonlinear_prog_cluster_max(s : MathnonlinearprogCluster) -> Double { @_common.max(s.data) }

pub fn math_nonlinear_prog_cluster_to_string(s : MathnonlinearprogCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathnonlinearprogModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_nonlinear_prog_model_make(size : Int) -> MathnonlinearprogModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_nonlinear_prog_model_len(s : MathnonlinearprogModel) -> Int { s.size }

pub fn math_nonlinear_prog_model_get(s : MathnonlinearprogModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_nonlinear_prog_model_set(s : MathnonlinearprogModel, i : Int, v : Double) -> MathnonlinearprogModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_nonlinear_prog_model_sum(s : MathnonlinearprogModel) -> Double { @_common.sum(s.data) }

pub fn math_nonlinear_prog_model_mean(s : MathnonlinearprogModel) -> Double { @_common.mean(s.data) }

pub fn math_nonlinear_prog_model_scale(s : MathnonlinearprogModel, f : Double) -> MathnonlinearprogModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_nonlinear_prog_model_add(a : MathnonlinearprogModel, b : MathnonlinearprogModel) -> MathnonlinearprogModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_nonlinear_prog_model_copy(s : MathnonlinearprogModel) -> MathnonlinearprogModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_nonlinear_prog_model_fill(s : MathnonlinearprogModel, v : Double) -> MathnonlinearprogModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_nonlinear_prog_model_min(s : MathnonlinearprogModel) -> Double { @_common.min(s.data) }

pub fn math_nonlinear_prog_model_max(s : MathnonlinearprogModel) -> Double { @_common.max(s.data) }

pub fn math_nonlinear_prog_model_to_string(s : MathnonlinearprogModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathnonlinearprogLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_nonlinear_prog_layer_make(size : Int) -> MathnonlinearprogLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_nonlinear_prog_layer_len(s : MathnonlinearprogLayer) -> Int { s.size }

pub fn math_nonlinear_prog_layer_get(s : MathnonlinearprogLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_nonlinear_prog_layer_set(s : MathnonlinearprogLayer, i : Int, v : Double) -> MathnonlinearprogLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_nonlinear_prog_layer_sum(s : MathnonlinearprogLayer) -> Double { @_common.sum(s.data) }

pub fn math_nonlinear_prog_layer_mean(s : MathnonlinearprogLayer) -> Double { @_common.mean(s.data) }

pub fn math_nonlinear_prog_layer_scale(s : MathnonlinearprogLayer, f : Double) -> MathnonlinearprogLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_nonlinear_prog_layer_add(a : MathnonlinearprogLayer, b : MathnonlinearprogLayer) -> MathnonlinearprogLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_nonlinear_prog_layer_copy(s : MathnonlinearprogLayer) -> MathnonlinearprogLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_nonlinear_prog_layer_fill(s : MathnonlinearprogLayer, v : Double) -> MathnonlinearprogLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_nonlinear_prog_layer_min(s : MathnonlinearprogLayer) -> Double { @_common.min(s.data) }

pub fn math_nonlinear_prog_layer_max(s : MathnonlinearprogLayer) -> Double { @_common.max(s.data) }

pub fn math_nonlinear_prog_layer_to_string(s : MathnonlinearprogLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathnonlinearprogBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_nonlinear_prog_buffer_make(size : Int) -> MathnonlinearprogBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_nonlinear_prog_buffer_len(s : MathnonlinearprogBuffer) -> Int { s.size }

pub fn math_nonlinear_prog_buffer_get(s : MathnonlinearprogBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_nonlinear_prog_buffer_set(s : MathnonlinearprogBuffer, i : Int, v : Double) -> MathnonlinearprogBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_nonlinear_prog_buffer_sum(s : MathnonlinearprogBuffer) -> Double { @_common.sum(s.data) }

pub fn math_nonlinear_prog_buffer_mean(s : MathnonlinearprogBuffer) -> Double { @_common.mean(s.data) }

pub fn math_nonlinear_prog_buffer_scale(s : MathnonlinearprogBuffer, f : Double) -> MathnonlinearprogBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_nonlinear_prog_buffer_add(a : MathnonlinearprogBuffer, b : MathnonlinearprogBuffer) -> MathnonlinearprogBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_nonlinear_prog_buffer_copy(s : MathnonlinearprogBuffer) -> MathnonlinearprogBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_nonlinear_prog_buffer_fill(s : MathnonlinearprogBuffer, v : Double) -> MathnonlinearprogBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_nonlinear_prog_buffer_min(s : MathnonlinearprogBuffer) -> Double { @_common.min(s.data) }

pub fn math_nonlinear_prog_buffer_max(s : MathnonlinearprogBuffer) -> Double { @_common.max(s.data) }

pub fn math_nonlinear_prog_buffer_to_string(s : MathnonlinearprogBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathnonlinearprogCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_nonlinear_prog_cursor_make(size : Int) -> MathnonlinearprogCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_nonlinear_prog_cursor_len(s : MathnonlinearprogCursor) -> Int { s.size }

pub fn math_nonlinear_prog_cursor_get(s : MathnonlinearprogCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_nonlinear_prog_cursor_set(s : MathnonlinearprogCursor, i : Int, v : Double) -> MathnonlinearprogCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_nonlinear_prog_cursor_sum(s : MathnonlinearprogCursor) -> Double { @_common.sum(s.data) }

pub fn math_nonlinear_prog_cursor_mean(s : MathnonlinearprogCursor) -> Double { @_common.mean(s.data) }

pub fn math_nonlinear_prog_cursor_scale(s : MathnonlinearprogCursor, f : Double) -> MathnonlinearprogCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_nonlinear_prog_cursor_add(a : MathnonlinearprogCursor, b : MathnonlinearprogCursor) -> MathnonlinearprogCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_nonlinear_prog_cursor_copy(s : MathnonlinearprogCursor) -> MathnonlinearprogCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_nonlinear_prog_cursor_fill(s : MathnonlinearprogCursor, v : Double) -> MathnonlinearprogCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_nonlinear_prog_cursor_min(s : MathnonlinearprogCursor) -> Double { @_common.min(s.data) }

pub fn math_nonlinear_prog_cursor_max(s : MathnonlinearprogCursor) -> Double { @_common.max(s.data) }

pub fn math_nonlinear_prog_cursor_to_string(s : MathnonlinearprogCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathnonlinearprogView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_nonlinear_prog_view_make(size : Int) -> MathnonlinearprogView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_nonlinear_prog_view_len(s : MathnonlinearprogView) -> Int { s.size }

pub fn math_nonlinear_prog_view_get(s : MathnonlinearprogView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_nonlinear_prog_view_set(s : MathnonlinearprogView, i : Int, v : Double) -> MathnonlinearprogView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_nonlinear_prog_view_sum(s : MathnonlinearprogView) -> Double { @_common.sum(s.data) }

pub fn math_nonlinear_prog_view_mean(s : MathnonlinearprogView) -> Double { @_common.mean(s.data) }

pub fn math_nonlinear_prog_view_scale(s : MathnonlinearprogView, f : Double) -> MathnonlinearprogView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_nonlinear_prog_view_add(a : MathnonlinearprogView, b : MathnonlinearprogView) -> MathnonlinearprogView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_nonlinear_prog_view_copy(s : MathnonlinearprogView) -> MathnonlinearprogView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_nonlinear_prog_view_fill(s : MathnonlinearprogView, v : Double) -> MathnonlinearprogView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_nonlinear_prog_view_min(s : MathnonlinearprogView) -> Double { @_common.min(s.data) }

pub fn math_nonlinear_prog_view_max(s : MathnonlinearprogView) -> Double { @_common.max(s.data) }

pub fn math_nonlinear_prog_view_to_string(s : MathnonlinearprogView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathnonlinearprogRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_nonlinear_prog_range_make(size : Int) -> MathnonlinearprogRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_nonlinear_prog_range_len(s : MathnonlinearprogRange) -> Int { s.size }

pub fn math_nonlinear_prog_range_get(s : MathnonlinearprogRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_nonlinear_prog_range_set(s : MathnonlinearprogRange, i : Int, v : Double) -> MathnonlinearprogRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_nonlinear_prog_range_sum(s : MathnonlinearprogRange) -> Double { @_common.sum(s.data) }

pub fn math_nonlinear_prog_range_mean(s : MathnonlinearprogRange) -> Double { @_common.mean(s.data) }

pub fn math_nonlinear_prog_range_scale(s : MathnonlinearprogRange, f : Double) -> MathnonlinearprogRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_nonlinear_prog_range_add(a : MathnonlinearprogRange, b : MathnonlinearprogRange) -> MathnonlinearprogRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_nonlinear_prog_range_copy(s : MathnonlinearprogRange) -> MathnonlinearprogRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_nonlinear_prog_range_fill(s : MathnonlinearprogRange, v : Double) -> MathnonlinearprogRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_nonlinear_prog_range_min(s : MathnonlinearprogRange) -> Double { @_common.min(s.data) }

pub fn math_nonlinear_prog_range_max(s : MathnonlinearprogRange) -> Double { @_common.max(s.data) }

pub fn math_nonlinear_prog_range_to_string(s : MathnonlinearprogRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathnonlinearprogSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_nonlinear_prog_slice_make(size : Int) -> MathnonlinearprogSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_nonlinear_prog_slice_len(s : MathnonlinearprogSlice) -> Int { s.size }

pub fn math_nonlinear_prog_slice_get(s : MathnonlinearprogSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_nonlinear_prog_slice_set(s : MathnonlinearprogSlice, i : Int, v : Double) -> MathnonlinearprogSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_nonlinear_prog_slice_sum(s : MathnonlinearprogSlice) -> Double { @_common.sum(s.data) }

pub fn math_nonlinear_prog_slice_mean(s : MathnonlinearprogSlice) -> Double { @_common.mean(s.data) }

pub fn math_nonlinear_prog_slice_scale(s : MathnonlinearprogSlice, f : Double) -> MathnonlinearprogSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_nonlinear_prog_slice_add(a : MathnonlinearprogSlice, b : MathnonlinearprogSlice) -> MathnonlinearprogSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_nonlinear_prog_slice_copy(s : MathnonlinearprogSlice) -> MathnonlinearprogSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_nonlinear_prog_slice_fill(s : MathnonlinearprogSlice, v : Double) -> MathnonlinearprogSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_nonlinear_prog_slice_min(s : MathnonlinearprogSlice) -> Double { @_common.min(s.data) }

pub fn math_nonlinear_prog_slice_max(s : MathnonlinearprogSlice) -> Double { @_common.max(s.data) }

pub fn math_nonlinear_prog_slice_to_string(s : MathnonlinearprogSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

