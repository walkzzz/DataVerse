///===
/// extcore/math_quadratic_prog

pub(all) struct MathquadraticprogPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn math_quadratic_prog_make_point(x : Double, y : Double) -> MathquadraticprogPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn math_quadratic_prog_make_point3(x : Double, y : Double, z : Double) -> MathquadraticprogPoint {
  { x, y, z, label: 0 }
}

pub fn MathquadraticprogPoint::x(self : MathquadraticprogPoint) -> Double { self.x }

pub fn MathquadraticprogPoint::y(self : MathquadraticprogPoint) -> Double { self.y }

pub fn MathquadraticprogPoint::z(self : MathquadraticprogPoint) -> Double { self.z }

pub fn MathquadraticprogPoint::label(self : MathquadraticprogPoint) -> Int { self.label }

pub fn MathquadraticprogPoint::dist(self : MathquadraticprogPoint, other : MathquadraticprogPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn MathquadraticprogPoint::add(self : MathquadraticprogPoint, other : MathquadraticprogPoint) -> MathquadraticprogPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn MathquadraticprogPoint::sub(self : MathquadraticprogPoint, other : MathquadraticprogPoint) -> MathquadraticprogPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn MathquadraticprogPoint::scale(self : MathquadraticprogPoint, s : Double) -> MathquadraticprogPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn MathquadraticprogPoint::dot(self : MathquadraticprogPoint, other : MathquadraticprogPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn MathquadraticprogPoint::cross(self : MathquadraticprogPoint, other : MathquadraticprogPoint) -> MathquadraticprogPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn MathquadraticprogPoint::norm(self : MathquadraticprogPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn MathquadraticprogPoint::normalize(self : MathquadraticprogPoint) -> MathquadraticprogPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn MathquadraticprogPoint::negate(self : MathquadraticprogPoint) -> MathquadraticprogPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn MathquadraticprogPoint::mid(self : MathquadraticprogPoint, other : MathquadraticprogPoint) -> MathquadraticprogPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn MathquadraticprogPoint::lerp(self : MathquadraticprogPoint, other : MathquadraticprogPoint, t : Double) -> MathquadraticprogPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn MathquadraticprogPoint::to_string(self : MathquadraticprogPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct MathquadraticprogSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn math_quadratic_prog_make_series(vals : Array[Double], name : String) -> MathquadraticprogSeries {
  { vals, name, meta: 0 }
}

pub fn MathquadraticprogSeries::len(self : MathquadraticprogSeries) -> Int { self.vals.length() }

pub fn MathquadraticprogSeries::sum(self : MathquadraticprogSeries) -> Double { @_common.sum(self.vals) }

pub fn MathquadraticprogSeries::mean(self : MathquadraticprogSeries) -> Double { @_common.mean(self.vals) }

pub fn MathquadraticprogSeries::min(self : MathquadraticprogSeries) -> Double { @_common.min(self.vals) }

pub fn MathquadraticprogSeries::max(self : MathquadraticprogSeries) -> Double { @_common.max(self.vals) }

pub fn MathquadraticprogSeries::range(self : MathquadraticprogSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn MathquadraticprogSeries::variance(self : MathquadraticprogSeries) -> Double { @_common.variance(self.vals) }

pub fn MathquadraticprogSeries::std(self : MathquadraticprogSeries) -> Double { @_common.std(self.vals) }

pub fn MathquadraticprogSeries::median(self : MathquadraticprogSeries) -> Double { @_common.median(self.vals) }

pub fn MathquadraticprogSeries::scale(self : MathquadraticprogSeries, f : Double) -> MathquadraticprogSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn MathquadraticprogSeries::add(self : MathquadraticprogSeries, other : MathquadraticprogSeries) -> MathquadraticprogSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn MathquadraticprogSeries::sub(self : MathquadraticprogSeries, other : MathquadraticprogSeries) -> MathquadraticprogSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn MathquadraticprogSeries::normalize(self : MathquadraticprogSeries) -> MathquadraticprogSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn MathquadraticprogSeries::cumsum(self : MathquadraticprogSeries) -> MathquadraticprogSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn MathquadraticprogSeries::to_string(self : MathquadraticprogSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct MathquadraticprogMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn math_quadratic_prog_make_matrix(rows : Int, cols : Int, val : Double) -> MathquadraticprogMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn math_quadratic_prog_matrix_identity(n : Int) -> MathquadraticprogMatrix {
  let m = math_quadratic_prog_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn MathquadraticprogMatrix::get(self : MathquadraticprogMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn MathquadraticprogMatrix::transpose(self : MathquadraticprogMatrix) -> MathquadraticprogMatrix {
  let result = math_quadratic_prog_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn MathquadraticprogMatrix::add(self : MathquadraticprogMatrix, other : MathquadraticprogMatrix) -> MathquadraticprogMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = math_quadratic_prog_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn MathquadraticprogMatrix::scale(self : MathquadraticprogMatrix, s : Double) -> MathquadraticprogMatrix {
  let result = math_quadratic_prog_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn MathquadraticprogMatrix::multiply(self : MathquadraticprogMatrix, other : MathquadraticprogMatrix) -> MathquadraticprogMatrix {
  if self.cols != other.rows { return math_quadratic_prog_make_matrix(self.rows, other.cols, 0.0) }
  let result = math_quadratic_prog_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn MathquadraticprogMatrix::trace(self : MathquadraticprogMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn MathquadraticprogMatrix::det(self : MathquadraticprogMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn MathquadraticprogMatrix::norm(self : MathquadraticprogMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn MathquadraticprogMatrix::to_string(self : MathquadraticprogMatrix) -> String {
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

pub(all) struct MathquadraticprogVector {
  comps : Array[Double]
  dim : Int
}

pub fn math_quadratic_prog_make_vector(comps : Array[Double]) -> MathquadraticprogVector {
  { comps, dim: comps.length() }
}

pub fn math_quadratic_prog_vector_zero(dim : Int) -> MathquadraticprogVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn MathquadraticprogVector::add(self : MathquadraticprogVector, other : MathquadraticprogVector) -> MathquadraticprogVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn MathquadraticprogVector::sub(self : MathquadraticprogVector, other : MathquadraticprogVector) -> MathquadraticprogVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn MathquadraticprogVector::scale(self : MathquadraticprogVector, s : Double) -> MathquadraticprogVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn MathquadraticprogVector::dot(self : MathquadraticprogVector, other : MathquadraticprogVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn MathquadraticprogVector::norm(self : MathquadraticprogVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn MathquadraticprogVector::normalize(self : MathquadraticprogVector) -> MathquadraticprogVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn MathquadraticprogVector::dist(self : MathquadraticprogVector, other : MathquadraticprogVector) -> Double {
  self.sub(other).norm()
}

pub fn MathquadraticprogVector::to_string(self : MathquadraticprogVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn math_quadratic_prog_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn math_quadratic_prog_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn math_quadratic_prog_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn math_quadratic_prog_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn math_quadratic_prog_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn math_quadratic_prog_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn math_quadratic_prog_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn math_quadratic_prog_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn math_quadratic_prog_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn math_quadratic_prog_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn math_quadratic_prog_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn math_quadratic_prog_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn math_quadratic_prog_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn math_quadratic_prog_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn math_quadratic_prog_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn math_quadratic_prog_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn math_quadratic_prog_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn math_quadratic_prog_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn math_quadratic_prog_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn math_quadratic_prog_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn math_quadratic_prog_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn math_quadratic_prog_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn math_quadratic_prog_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn math_quadratic_prog_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn math_quadratic_prog_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn math_quadratic_prog_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn math_quadratic_prog_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn math_quadratic_prog_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn math_quadratic_prog_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct MathquadraticprogFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_quadratic_prog_frame_make(size : Int) -> MathquadraticprogFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_quadratic_prog_frame_len(s : MathquadraticprogFrame) -> Int { s.size }

pub fn math_quadratic_prog_frame_get(s : MathquadraticprogFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_quadratic_prog_frame_set(s : MathquadraticprogFrame, i : Int, v : Double) -> MathquadraticprogFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_quadratic_prog_frame_sum(s : MathquadraticprogFrame) -> Double { @_common.sum(s.data) }

pub fn math_quadratic_prog_frame_mean(s : MathquadraticprogFrame) -> Double { @_common.mean(s.data) }

pub fn math_quadratic_prog_frame_scale(s : MathquadraticprogFrame, f : Double) -> MathquadraticprogFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_quadratic_prog_frame_add(a : MathquadraticprogFrame, b : MathquadraticprogFrame) -> MathquadraticprogFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_quadratic_prog_frame_copy(s : MathquadraticprogFrame) -> MathquadraticprogFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_quadratic_prog_frame_fill(s : MathquadraticprogFrame, v : Double) -> MathquadraticprogFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_quadratic_prog_frame_min(s : MathquadraticprogFrame) -> Double { @_common.min(s.data) }

pub fn math_quadratic_prog_frame_max(s : MathquadraticprogFrame) -> Double { @_common.max(s.data) }

pub fn math_quadratic_prog_frame_to_string(s : MathquadraticprogFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathquadraticprogTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_quadratic_prog_table_make(size : Int) -> MathquadraticprogTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_quadratic_prog_table_len(s : MathquadraticprogTable) -> Int { s.size }

pub fn math_quadratic_prog_table_get(s : MathquadraticprogTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_quadratic_prog_table_set(s : MathquadraticprogTable, i : Int, v : Double) -> MathquadraticprogTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_quadratic_prog_table_sum(s : MathquadraticprogTable) -> Double { @_common.sum(s.data) }

pub fn math_quadratic_prog_table_mean(s : MathquadraticprogTable) -> Double { @_common.mean(s.data) }

pub fn math_quadratic_prog_table_scale(s : MathquadraticprogTable, f : Double) -> MathquadraticprogTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_quadratic_prog_table_add(a : MathquadraticprogTable, b : MathquadraticprogTable) -> MathquadraticprogTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_quadratic_prog_table_copy(s : MathquadraticprogTable) -> MathquadraticprogTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_quadratic_prog_table_fill(s : MathquadraticprogTable, v : Double) -> MathquadraticprogTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_quadratic_prog_table_min(s : MathquadraticprogTable) -> Double { @_common.min(s.data) }

pub fn math_quadratic_prog_table_max(s : MathquadraticprogTable) -> Double { @_common.max(s.data) }

pub fn math_quadratic_prog_table_to_string(s : MathquadraticprogTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathquadraticprogGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_quadratic_prog_graphn_make(size : Int) -> MathquadraticprogGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_quadratic_prog_graphn_len(s : MathquadraticprogGraphN) -> Int { s.size }

pub fn math_quadratic_prog_graphn_get(s : MathquadraticprogGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_quadratic_prog_graphn_set(s : MathquadraticprogGraphN, i : Int, v : Double) -> MathquadraticprogGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_quadratic_prog_graphn_sum(s : MathquadraticprogGraphN) -> Double { @_common.sum(s.data) }

pub fn math_quadratic_prog_graphn_mean(s : MathquadraticprogGraphN) -> Double { @_common.mean(s.data) }

pub fn math_quadratic_prog_graphn_scale(s : MathquadraticprogGraphN, f : Double) -> MathquadraticprogGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_quadratic_prog_graphn_add(a : MathquadraticprogGraphN, b : MathquadraticprogGraphN) -> MathquadraticprogGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_quadratic_prog_graphn_copy(s : MathquadraticprogGraphN) -> MathquadraticprogGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_quadratic_prog_graphn_fill(s : MathquadraticprogGraphN, v : Double) -> MathquadraticprogGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_quadratic_prog_graphn_min(s : MathquadraticprogGraphN) -> Double { @_common.min(s.data) }

pub fn math_quadratic_prog_graphn_max(s : MathquadraticprogGraphN) -> Double { @_common.max(s.data) }

pub fn math_quadratic_prog_graphn_to_string(s : MathquadraticprogGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathquadraticprogNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_quadratic_prog_node_make(size : Int) -> MathquadraticprogNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_quadratic_prog_node_len(s : MathquadraticprogNode) -> Int { s.size }

pub fn math_quadratic_prog_node_get(s : MathquadraticprogNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_quadratic_prog_node_set(s : MathquadraticprogNode, i : Int, v : Double) -> MathquadraticprogNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_quadratic_prog_node_sum(s : MathquadraticprogNode) -> Double { @_common.sum(s.data) }

pub fn math_quadratic_prog_node_mean(s : MathquadraticprogNode) -> Double { @_common.mean(s.data) }

pub fn math_quadratic_prog_node_scale(s : MathquadraticprogNode, f : Double) -> MathquadraticprogNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_quadratic_prog_node_add(a : MathquadraticprogNode, b : MathquadraticprogNode) -> MathquadraticprogNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_quadratic_prog_node_copy(s : MathquadraticprogNode) -> MathquadraticprogNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_quadratic_prog_node_fill(s : MathquadraticprogNode, v : Double) -> MathquadraticprogNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_quadratic_prog_node_min(s : MathquadraticprogNode) -> Double { @_common.min(s.data) }

pub fn math_quadratic_prog_node_max(s : MathquadraticprogNode) -> Double { @_common.max(s.data) }

pub fn math_quadratic_prog_node_to_string(s : MathquadraticprogNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathquadraticprogEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_quadratic_prog_edge_make(size : Int) -> MathquadraticprogEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_quadratic_prog_edge_len(s : MathquadraticprogEdge) -> Int { s.size }

pub fn math_quadratic_prog_edge_get(s : MathquadraticprogEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_quadratic_prog_edge_set(s : MathquadraticprogEdge, i : Int, v : Double) -> MathquadraticprogEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_quadratic_prog_edge_sum(s : MathquadraticprogEdge) -> Double { @_common.sum(s.data) }

pub fn math_quadratic_prog_edge_mean(s : MathquadraticprogEdge) -> Double { @_common.mean(s.data) }

pub fn math_quadratic_prog_edge_scale(s : MathquadraticprogEdge, f : Double) -> MathquadraticprogEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_quadratic_prog_edge_add(a : MathquadraticprogEdge, b : MathquadraticprogEdge) -> MathquadraticprogEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_quadratic_prog_edge_copy(s : MathquadraticprogEdge) -> MathquadraticprogEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_quadratic_prog_edge_fill(s : MathquadraticprogEdge, v : Double) -> MathquadraticprogEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_quadratic_prog_edge_min(s : MathquadraticprogEdge) -> Double { @_common.min(s.data) }

pub fn math_quadratic_prog_edge_max(s : MathquadraticprogEdge) -> Double { @_common.max(s.data) }

pub fn math_quadratic_prog_edge_to_string(s : MathquadraticprogEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathquadraticprogPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_quadratic_prog_path_make(size : Int) -> MathquadraticprogPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_quadratic_prog_path_len(s : MathquadraticprogPath) -> Int { s.size }

pub fn math_quadratic_prog_path_get(s : MathquadraticprogPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_quadratic_prog_path_set(s : MathquadraticprogPath, i : Int, v : Double) -> MathquadraticprogPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_quadratic_prog_path_sum(s : MathquadraticprogPath) -> Double { @_common.sum(s.data) }

pub fn math_quadratic_prog_path_mean(s : MathquadraticprogPath) -> Double { @_common.mean(s.data) }

pub fn math_quadratic_prog_path_scale(s : MathquadraticprogPath, f : Double) -> MathquadraticprogPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_quadratic_prog_path_add(a : MathquadraticprogPath, b : MathquadraticprogPath) -> MathquadraticprogPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_quadratic_prog_path_copy(s : MathquadraticprogPath) -> MathquadraticprogPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_quadratic_prog_path_fill(s : MathquadraticprogPath, v : Double) -> MathquadraticprogPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_quadratic_prog_path_min(s : MathquadraticprogPath) -> Double { @_common.min(s.data) }

pub fn math_quadratic_prog_path_max(s : MathquadraticprogPath) -> Double { @_common.max(s.data) }

pub fn math_quadratic_prog_path_to_string(s : MathquadraticprogPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathquadraticprogCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_quadratic_prog_cluster_make(size : Int) -> MathquadraticprogCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_quadratic_prog_cluster_len(s : MathquadraticprogCluster) -> Int { s.size }

pub fn math_quadratic_prog_cluster_get(s : MathquadraticprogCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_quadratic_prog_cluster_set(s : MathquadraticprogCluster, i : Int, v : Double) -> MathquadraticprogCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_quadratic_prog_cluster_sum(s : MathquadraticprogCluster) -> Double { @_common.sum(s.data) }

pub fn math_quadratic_prog_cluster_mean(s : MathquadraticprogCluster) -> Double { @_common.mean(s.data) }

pub fn math_quadratic_prog_cluster_scale(s : MathquadraticprogCluster, f : Double) -> MathquadraticprogCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_quadratic_prog_cluster_add(a : MathquadraticprogCluster, b : MathquadraticprogCluster) -> MathquadraticprogCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_quadratic_prog_cluster_copy(s : MathquadraticprogCluster) -> MathquadraticprogCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_quadratic_prog_cluster_fill(s : MathquadraticprogCluster, v : Double) -> MathquadraticprogCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_quadratic_prog_cluster_min(s : MathquadraticprogCluster) -> Double { @_common.min(s.data) }

pub fn math_quadratic_prog_cluster_max(s : MathquadraticprogCluster) -> Double { @_common.max(s.data) }

pub fn math_quadratic_prog_cluster_to_string(s : MathquadraticprogCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathquadraticprogModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_quadratic_prog_model_make(size : Int) -> MathquadraticprogModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_quadratic_prog_model_len(s : MathquadraticprogModel) -> Int { s.size }

pub fn math_quadratic_prog_model_get(s : MathquadraticprogModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_quadratic_prog_model_set(s : MathquadraticprogModel, i : Int, v : Double) -> MathquadraticprogModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_quadratic_prog_model_sum(s : MathquadraticprogModel) -> Double { @_common.sum(s.data) }

pub fn math_quadratic_prog_model_mean(s : MathquadraticprogModel) -> Double { @_common.mean(s.data) }

pub fn math_quadratic_prog_model_scale(s : MathquadraticprogModel, f : Double) -> MathquadraticprogModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_quadratic_prog_model_add(a : MathquadraticprogModel, b : MathquadraticprogModel) -> MathquadraticprogModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_quadratic_prog_model_copy(s : MathquadraticprogModel) -> MathquadraticprogModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_quadratic_prog_model_fill(s : MathquadraticprogModel, v : Double) -> MathquadraticprogModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_quadratic_prog_model_min(s : MathquadraticprogModel) -> Double { @_common.min(s.data) }

pub fn math_quadratic_prog_model_max(s : MathquadraticprogModel) -> Double { @_common.max(s.data) }

pub fn math_quadratic_prog_model_to_string(s : MathquadraticprogModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathquadraticprogLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_quadratic_prog_layer_make(size : Int) -> MathquadraticprogLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_quadratic_prog_layer_len(s : MathquadraticprogLayer) -> Int { s.size }

pub fn math_quadratic_prog_layer_get(s : MathquadraticprogLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_quadratic_prog_layer_set(s : MathquadraticprogLayer, i : Int, v : Double) -> MathquadraticprogLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_quadratic_prog_layer_sum(s : MathquadraticprogLayer) -> Double { @_common.sum(s.data) }

pub fn math_quadratic_prog_layer_mean(s : MathquadraticprogLayer) -> Double { @_common.mean(s.data) }

pub fn math_quadratic_prog_layer_scale(s : MathquadraticprogLayer, f : Double) -> MathquadraticprogLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_quadratic_prog_layer_add(a : MathquadraticprogLayer, b : MathquadraticprogLayer) -> MathquadraticprogLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_quadratic_prog_layer_copy(s : MathquadraticprogLayer) -> MathquadraticprogLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_quadratic_prog_layer_fill(s : MathquadraticprogLayer, v : Double) -> MathquadraticprogLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_quadratic_prog_layer_min(s : MathquadraticprogLayer) -> Double { @_common.min(s.data) }

pub fn math_quadratic_prog_layer_max(s : MathquadraticprogLayer) -> Double { @_common.max(s.data) }

pub fn math_quadratic_prog_layer_to_string(s : MathquadraticprogLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathquadraticprogBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_quadratic_prog_buffer_make(size : Int) -> MathquadraticprogBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_quadratic_prog_buffer_len(s : MathquadraticprogBuffer) -> Int { s.size }

pub fn math_quadratic_prog_buffer_get(s : MathquadraticprogBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_quadratic_prog_buffer_set(s : MathquadraticprogBuffer, i : Int, v : Double) -> MathquadraticprogBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_quadratic_prog_buffer_sum(s : MathquadraticprogBuffer) -> Double { @_common.sum(s.data) }

pub fn math_quadratic_prog_buffer_mean(s : MathquadraticprogBuffer) -> Double { @_common.mean(s.data) }

pub fn math_quadratic_prog_buffer_scale(s : MathquadraticprogBuffer, f : Double) -> MathquadraticprogBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_quadratic_prog_buffer_add(a : MathquadraticprogBuffer, b : MathquadraticprogBuffer) -> MathquadraticprogBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_quadratic_prog_buffer_copy(s : MathquadraticprogBuffer) -> MathquadraticprogBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_quadratic_prog_buffer_fill(s : MathquadraticprogBuffer, v : Double) -> MathquadraticprogBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_quadratic_prog_buffer_min(s : MathquadraticprogBuffer) -> Double { @_common.min(s.data) }

pub fn math_quadratic_prog_buffer_max(s : MathquadraticprogBuffer) -> Double { @_common.max(s.data) }

pub fn math_quadratic_prog_buffer_to_string(s : MathquadraticprogBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathquadraticprogCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_quadratic_prog_cursor_make(size : Int) -> MathquadraticprogCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_quadratic_prog_cursor_len(s : MathquadraticprogCursor) -> Int { s.size }

pub fn math_quadratic_prog_cursor_get(s : MathquadraticprogCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_quadratic_prog_cursor_set(s : MathquadraticprogCursor, i : Int, v : Double) -> MathquadraticprogCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_quadratic_prog_cursor_sum(s : MathquadraticprogCursor) -> Double { @_common.sum(s.data) }

pub fn math_quadratic_prog_cursor_mean(s : MathquadraticprogCursor) -> Double { @_common.mean(s.data) }

pub fn math_quadratic_prog_cursor_scale(s : MathquadraticprogCursor, f : Double) -> MathquadraticprogCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_quadratic_prog_cursor_add(a : MathquadraticprogCursor, b : MathquadraticprogCursor) -> MathquadraticprogCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_quadratic_prog_cursor_copy(s : MathquadraticprogCursor) -> MathquadraticprogCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_quadratic_prog_cursor_fill(s : MathquadraticprogCursor, v : Double) -> MathquadraticprogCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_quadratic_prog_cursor_min(s : MathquadraticprogCursor) -> Double { @_common.min(s.data) }

pub fn math_quadratic_prog_cursor_max(s : MathquadraticprogCursor) -> Double { @_common.max(s.data) }

pub fn math_quadratic_prog_cursor_to_string(s : MathquadraticprogCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathquadraticprogView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_quadratic_prog_view_make(size : Int) -> MathquadraticprogView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_quadratic_prog_view_len(s : MathquadraticprogView) -> Int { s.size }

pub fn math_quadratic_prog_view_get(s : MathquadraticprogView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_quadratic_prog_view_set(s : MathquadraticprogView, i : Int, v : Double) -> MathquadraticprogView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_quadratic_prog_view_sum(s : MathquadraticprogView) -> Double { @_common.sum(s.data) }

pub fn math_quadratic_prog_view_mean(s : MathquadraticprogView) -> Double { @_common.mean(s.data) }

pub fn math_quadratic_prog_view_scale(s : MathquadraticprogView, f : Double) -> MathquadraticprogView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_quadratic_prog_view_add(a : MathquadraticprogView, b : MathquadraticprogView) -> MathquadraticprogView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_quadratic_prog_view_copy(s : MathquadraticprogView) -> MathquadraticprogView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_quadratic_prog_view_fill(s : MathquadraticprogView, v : Double) -> MathquadraticprogView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_quadratic_prog_view_min(s : MathquadraticprogView) -> Double { @_common.min(s.data) }

pub fn math_quadratic_prog_view_max(s : MathquadraticprogView) -> Double { @_common.max(s.data) }

pub fn math_quadratic_prog_view_to_string(s : MathquadraticprogView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathquadraticprogRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_quadratic_prog_range_make(size : Int) -> MathquadraticprogRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_quadratic_prog_range_len(s : MathquadraticprogRange) -> Int { s.size }

pub fn math_quadratic_prog_range_get(s : MathquadraticprogRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_quadratic_prog_range_set(s : MathquadraticprogRange, i : Int, v : Double) -> MathquadraticprogRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_quadratic_prog_range_sum(s : MathquadraticprogRange) -> Double { @_common.sum(s.data) }

pub fn math_quadratic_prog_range_mean(s : MathquadraticprogRange) -> Double { @_common.mean(s.data) }

pub fn math_quadratic_prog_range_scale(s : MathquadraticprogRange, f : Double) -> MathquadraticprogRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_quadratic_prog_range_add(a : MathquadraticprogRange, b : MathquadraticprogRange) -> MathquadraticprogRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_quadratic_prog_range_copy(s : MathquadraticprogRange) -> MathquadraticprogRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_quadratic_prog_range_fill(s : MathquadraticprogRange, v : Double) -> MathquadraticprogRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_quadratic_prog_range_min(s : MathquadraticprogRange) -> Double { @_common.min(s.data) }

pub fn math_quadratic_prog_range_max(s : MathquadraticprogRange) -> Double { @_common.max(s.data) }

pub fn math_quadratic_prog_range_to_string(s : MathquadraticprogRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathquadraticprogSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_quadratic_prog_slice_make(size : Int) -> MathquadraticprogSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_quadratic_prog_slice_len(s : MathquadraticprogSlice) -> Int { s.size }

pub fn math_quadratic_prog_slice_get(s : MathquadraticprogSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_quadratic_prog_slice_set(s : MathquadraticprogSlice, i : Int, v : Double) -> MathquadraticprogSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_quadratic_prog_slice_sum(s : MathquadraticprogSlice) -> Double { @_common.sum(s.data) }

pub fn math_quadratic_prog_slice_mean(s : MathquadraticprogSlice) -> Double { @_common.mean(s.data) }

pub fn math_quadratic_prog_slice_scale(s : MathquadraticprogSlice, f : Double) -> MathquadraticprogSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_quadratic_prog_slice_add(a : MathquadraticprogSlice, b : MathquadraticprogSlice) -> MathquadraticprogSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_quadratic_prog_slice_copy(s : MathquadraticprogSlice) -> MathquadraticprogSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_quadratic_prog_slice_fill(s : MathquadraticprogSlice, v : Double) -> MathquadraticprogSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_quadratic_prog_slice_min(s : MathquadraticprogSlice) -> Double { @_common.min(s.data) }

pub fn math_quadratic_prog_slice_max(s : MathquadraticprogSlice) -> Double { @_common.max(s.data) }

pub fn math_quadratic_prog_slice_to_string(s : MathquadraticprogSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

