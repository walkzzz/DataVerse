///===
/// extcore/math_stochastic_prog

pub(all) struct MathstochasticprogPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn math_stochastic_prog_make_point(x : Double, y : Double) -> MathstochasticprogPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn math_stochastic_prog_make_point3(x : Double, y : Double, z : Double) -> MathstochasticprogPoint {
  { x, y, z, label: 0 }
}

pub fn MathstochasticprogPoint::x(self : MathstochasticprogPoint) -> Double { self.x }

pub fn MathstochasticprogPoint::y(self : MathstochasticprogPoint) -> Double { self.y }

pub fn MathstochasticprogPoint::z(self : MathstochasticprogPoint) -> Double { self.z }

pub fn MathstochasticprogPoint::label(self : MathstochasticprogPoint) -> Int { self.label }

pub fn MathstochasticprogPoint::dist(self : MathstochasticprogPoint, other : MathstochasticprogPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn MathstochasticprogPoint::add(self : MathstochasticprogPoint, other : MathstochasticprogPoint) -> MathstochasticprogPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn MathstochasticprogPoint::sub(self : MathstochasticprogPoint, other : MathstochasticprogPoint) -> MathstochasticprogPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn MathstochasticprogPoint::scale(self : MathstochasticprogPoint, s : Double) -> MathstochasticprogPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn MathstochasticprogPoint::dot(self : MathstochasticprogPoint, other : MathstochasticprogPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn MathstochasticprogPoint::cross(self : MathstochasticprogPoint, other : MathstochasticprogPoint) -> MathstochasticprogPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn MathstochasticprogPoint::norm(self : MathstochasticprogPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn MathstochasticprogPoint::normalize(self : MathstochasticprogPoint) -> MathstochasticprogPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn MathstochasticprogPoint::negate(self : MathstochasticprogPoint) -> MathstochasticprogPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn MathstochasticprogPoint::mid(self : MathstochasticprogPoint, other : MathstochasticprogPoint) -> MathstochasticprogPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn MathstochasticprogPoint::lerp(self : MathstochasticprogPoint, other : MathstochasticprogPoint, t : Double) -> MathstochasticprogPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn MathstochasticprogPoint::to_string(self : MathstochasticprogPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct MathstochasticprogSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn math_stochastic_prog_make_series(vals : Array[Double], name : String) -> MathstochasticprogSeries {
  { vals, name, meta: 0 }
}

pub fn MathstochasticprogSeries::len(self : MathstochasticprogSeries) -> Int { self.vals.length() }

pub fn MathstochasticprogSeries::sum(self : MathstochasticprogSeries) -> Double { @_common.sum(self.vals) }

pub fn MathstochasticprogSeries::mean(self : MathstochasticprogSeries) -> Double { @_common.mean(self.vals) }

pub fn MathstochasticprogSeries::min(self : MathstochasticprogSeries) -> Double { @_common.min(self.vals) }

pub fn MathstochasticprogSeries::max(self : MathstochasticprogSeries) -> Double { @_common.max(self.vals) }

pub fn MathstochasticprogSeries::range(self : MathstochasticprogSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn MathstochasticprogSeries::variance(self : MathstochasticprogSeries) -> Double { @_common.variance(self.vals) }

pub fn MathstochasticprogSeries::std(self : MathstochasticprogSeries) -> Double { @_common.std(self.vals) }

pub fn MathstochasticprogSeries::median(self : MathstochasticprogSeries) -> Double { @_common.median(self.vals) }

pub fn MathstochasticprogSeries::scale(self : MathstochasticprogSeries, f : Double) -> MathstochasticprogSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn MathstochasticprogSeries::add(self : MathstochasticprogSeries, other : MathstochasticprogSeries) -> MathstochasticprogSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn MathstochasticprogSeries::sub(self : MathstochasticprogSeries, other : MathstochasticprogSeries) -> MathstochasticprogSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn MathstochasticprogSeries::normalize(self : MathstochasticprogSeries) -> MathstochasticprogSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn MathstochasticprogSeries::cumsum(self : MathstochasticprogSeries) -> MathstochasticprogSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn MathstochasticprogSeries::to_string(self : MathstochasticprogSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct MathstochasticprogMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn math_stochastic_prog_make_matrix(rows : Int, cols : Int, val : Double) -> MathstochasticprogMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn math_stochastic_prog_matrix_identity(n : Int) -> MathstochasticprogMatrix {
  let m = math_stochastic_prog_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn MathstochasticprogMatrix::get(self : MathstochasticprogMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn MathstochasticprogMatrix::transpose(self : MathstochasticprogMatrix) -> MathstochasticprogMatrix {
  let result = math_stochastic_prog_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn MathstochasticprogMatrix::add(self : MathstochasticprogMatrix, other : MathstochasticprogMatrix) -> MathstochasticprogMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = math_stochastic_prog_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn MathstochasticprogMatrix::scale(self : MathstochasticprogMatrix, s : Double) -> MathstochasticprogMatrix {
  let result = math_stochastic_prog_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn MathstochasticprogMatrix::multiply(self : MathstochasticprogMatrix, other : MathstochasticprogMatrix) -> MathstochasticprogMatrix {
  if self.cols != other.rows { return math_stochastic_prog_make_matrix(self.rows, other.cols, 0.0) }
  let result = math_stochastic_prog_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn MathstochasticprogMatrix::trace(self : MathstochasticprogMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn MathstochasticprogMatrix::det(self : MathstochasticprogMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn MathstochasticprogMatrix::norm(self : MathstochasticprogMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn MathstochasticprogMatrix::to_string(self : MathstochasticprogMatrix) -> String {
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

pub(all) struct MathstochasticprogVector {
  comps : Array[Double]
  dim : Int
}

pub fn math_stochastic_prog_make_vector(comps : Array[Double]) -> MathstochasticprogVector {
  { comps, dim: comps.length() }
}

pub fn math_stochastic_prog_vector_zero(dim : Int) -> MathstochasticprogVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn MathstochasticprogVector::add(self : MathstochasticprogVector, other : MathstochasticprogVector) -> MathstochasticprogVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn MathstochasticprogVector::sub(self : MathstochasticprogVector, other : MathstochasticprogVector) -> MathstochasticprogVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn MathstochasticprogVector::scale(self : MathstochasticprogVector, s : Double) -> MathstochasticprogVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn MathstochasticprogVector::dot(self : MathstochasticprogVector, other : MathstochasticprogVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn MathstochasticprogVector::norm(self : MathstochasticprogVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn MathstochasticprogVector::normalize(self : MathstochasticprogVector) -> MathstochasticprogVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn MathstochasticprogVector::dist(self : MathstochasticprogVector, other : MathstochasticprogVector) -> Double {
  self.sub(other).norm()
}

pub fn MathstochasticprogVector::to_string(self : MathstochasticprogVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn math_stochastic_prog_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn math_stochastic_prog_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn math_stochastic_prog_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn math_stochastic_prog_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn math_stochastic_prog_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn math_stochastic_prog_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn math_stochastic_prog_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn math_stochastic_prog_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn math_stochastic_prog_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn math_stochastic_prog_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn math_stochastic_prog_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn math_stochastic_prog_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn math_stochastic_prog_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn math_stochastic_prog_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn math_stochastic_prog_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn math_stochastic_prog_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn math_stochastic_prog_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn math_stochastic_prog_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn math_stochastic_prog_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn math_stochastic_prog_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn math_stochastic_prog_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn math_stochastic_prog_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn math_stochastic_prog_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn math_stochastic_prog_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn math_stochastic_prog_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn math_stochastic_prog_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn math_stochastic_prog_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn math_stochastic_prog_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn math_stochastic_prog_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct MathstochasticprogFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_stochastic_prog_frame_make(size : Int) -> MathstochasticprogFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_stochastic_prog_frame_len(s : MathstochasticprogFrame) -> Int { s.size }

pub fn math_stochastic_prog_frame_get(s : MathstochasticprogFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_stochastic_prog_frame_set(s : MathstochasticprogFrame, i : Int, v : Double) -> MathstochasticprogFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_stochastic_prog_frame_sum(s : MathstochasticprogFrame) -> Double { @_common.sum(s.data) }

pub fn math_stochastic_prog_frame_mean(s : MathstochasticprogFrame) -> Double { @_common.mean(s.data) }

pub fn math_stochastic_prog_frame_scale(s : MathstochasticprogFrame, f : Double) -> MathstochasticprogFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_stochastic_prog_frame_add(a : MathstochasticprogFrame, b : MathstochasticprogFrame) -> MathstochasticprogFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_stochastic_prog_frame_copy(s : MathstochasticprogFrame) -> MathstochasticprogFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_stochastic_prog_frame_fill(s : MathstochasticprogFrame, v : Double) -> MathstochasticprogFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_stochastic_prog_frame_min(s : MathstochasticprogFrame) -> Double { @_common.min(s.data) }

pub fn math_stochastic_prog_frame_max(s : MathstochasticprogFrame) -> Double { @_common.max(s.data) }

pub fn math_stochastic_prog_frame_to_string(s : MathstochasticprogFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathstochasticprogTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_stochastic_prog_table_make(size : Int) -> MathstochasticprogTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_stochastic_prog_table_len(s : MathstochasticprogTable) -> Int { s.size }

pub fn math_stochastic_prog_table_get(s : MathstochasticprogTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_stochastic_prog_table_set(s : MathstochasticprogTable, i : Int, v : Double) -> MathstochasticprogTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_stochastic_prog_table_sum(s : MathstochasticprogTable) -> Double { @_common.sum(s.data) }

pub fn math_stochastic_prog_table_mean(s : MathstochasticprogTable) -> Double { @_common.mean(s.data) }

pub fn math_stochastic_prog_table_scale(s : MathstochasticprogTable, f : Double) -> MathstochasticprogTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_stochastic_prog_table_add(a : MathstochasticprogTable, b : MathstochasticprogTable) -> MathstochasticprogTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_stochastic_prog_table_copy(s : MathstochasticprogTable) -> MathstochasticprogTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_stochastic_prog_table_fill(s : MathstochasticprogTable, v : Double) -> MathstochasticprogTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_stochastic_prog_table_min(s : MathstochasticprogTable) -> Double { @_common.min(s.data) }

pub fn math_stochastic_prog_table_max(s : MathstochasticprogTable) -> Double { @_common.max(s.data) }

pub fn math_stochastic_prog_table_to_string(s : MathstochasticprogTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathstochasticprogGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_stochastic_prog_graphn_make(size : Int) -> MathstochasticprogGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_stochastic_prog_graphn_len(s : MathstochasticprogGraphN) -> Int { s.size }

pub fn math_stochastic_prog_graphn_get(s : MathstochasticprogGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_stochastic_prog_graphn_set(s : MathstochasticprogGraphN, i : Int, v : Double) -> MathstochasticprogGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_stochastic_prog_graphn_sum(s : MathstochasticprogGraphN) -> Double { @_common.sum(s.data) }

pub fn math_stochastic_prog_graphn_mean(s : MathstochasticprogGraphN) -> Double { @_common.mean(s.data) }

pub fn math_stochastic_prog_graphn_scale(s : MathstochasticprogGraphN, f : Double) -> MathstochasticprogGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_stochastic_prog_graphn_add(a : MathstochasticprogGraphN, b : MathstochasticprogGraphN) -> MathstochasticprogGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_stochastic_prog_graphn_copy(s : MathstochasticprogGraphN) -> MathstochasticprogGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_stochastic_prog_graphn_fill(s : MathstochasticprogGraphN, v : Double) -> MathstochasticprogGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_stochastic_prog_graphn_min(s : MathstochasticprogGraphN) -> Double { @_common.min(s.data) }

pub fn math_stochastic_prog_graphn_max(s : MathstochasticprogGraphN) -> Double { @_common.max(s.data) }

pub fn math_stochastic_prog_graphn_to_string(s : MathstochasticprogGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathstochasticprogNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_stochastic_prog_node_make(size : Int) -> MathstochasticprogNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_stochastic_prog_node_len(s : MathstochasticprogNode) -> Int { s.size }

pub fn math_stochastic_prog_node_get(s : MathstochasticprogNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_stochastic_prog_node_set(s : MathstochasticprogNode, i : Int, v : Double) -> MathstochasticprogNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_stochastic_prog_node_sum(s : MathstochasticprogNode) -> Double { @_common.sum(s.data) }

pub fn math_stochastic_prog_node_mean(s : MathstochasticprogNode) -> Double { @_common.mean(s.data) }

pub fn math_stochastic_prog_node_scale(s : MathstochasticprogNode, f : Double) -> MathstochasticprogNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_stochastic_prog_node_add(a : MathstochasticprogNode, b : MathstochasticprogNode) -> MathstochasticprogNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_stochastic_prog_node_copy(s : MathstochasticprogNode) -> MathstochasticprogNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_stochastic_prog_node_fill(s : MathstochasticprogNode, v : Double) -> MathstochasticprogNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_stochastic_prog_node_min(s : MathstochasticprogNode) -> Double { @_common.min(s.data) }

pub fn math_stochastic_prog_node_max(s : MathstochasticprogNode) -> Double { @_common.max(s.data) }

pub fn math_stochastic_prog_node_to_string(s : MathstochasticprogNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathstochasticprogEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_stochastic_prog_edge_make(size : Int) -> MathstochasticprogEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_stochastic_prog_edge_len(s : MathstochasticprogEdge) -> Int { s.size }

pub fn math_stochastic_prog_edge_get(s : MathstochasticprogEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_stochastic_prog_edge_set(s : MathstochasticprogEdge, i : Int, v : Double) -> MathstochasticprogEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_stochastic_prog_edge_sum(s : MathstochasticprogEdge) -> Double { @_common.sum(s.data) }

pub fn math_stochastic_prog_edge_mean(s : MathstochasticprogEdge) -> Double { @_common.mean(s.data) }

pub fn math_stochastic_prog_edge_scale(s : MathstochasticprogEdge, f : Double) -> MathstochasticprogEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_stochastic_prog_edge_add(a : MathstochasticprogEdge, b : MathstochasticprogEdge) -> MathstochasticprogEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_stochastic_prog_edge_copy(s : MathstochasticprogEdge) -> MathstochasticprogEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_stochastic_prog_edge_fill(s : MathstochasticprogEdge, v : Double) -> MathstochasticprogEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_stochastic_prog_edge_min(s : MathstochasticprogEdge) -> Double { @_common.min(s.data) }

pub fn math_stochastic_prog_edge_max(s : MathstochasticprogEdge) -> Double { @_common.max(s.data) }

pub fn math_stochastic_prog_edge_to_string(s : MathstochasticprogEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathstochasticprogPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_stochastic_prog_path_make(size : Int) -> MathstochasticprogPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_stochastic_prog_path_len(s : MathstochasticprogPath) -> Int { s.size }

pub fn math_stochastic_prog_path_get(s : MathstochasticprogPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_stochastic_prog_path_set(s : MathstochasticprogPath, i : Int, v : Double) -> MathstochasticprogPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_stochastic_prog_path_sum(s : MathstochasticprogPath) -> Double { @_common.sum(s.data) }

pub fn math_stochastic_prog_path_mean(s : MathstochasticprogPath) -> Double { @_common.mean(s.data) }

pub fn math_stochastic_prog_path_scale(s : MathstochasticprogPath, f : Double) -> MathstochasticprogPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_stochastic_prog_path_add(a : MathstochasticprogPath, b : MathstochasticprogPath) -> MathstochasticprogPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_stochastic_prog_path_copy(s : MathstochasticprogPath) -> MathstochasticprogPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_stochastic_prog_path_fill(s : MathstochasticprogPath, v : Double) -> MathstochasticprogPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_stochastic_prog_path_min(s : MathstochasticprogPath) -> Double { @_common.min(s.data) }

pub fn math_stochastic_prog_path_max(s : MathstochasticprogPath) -> Double { @_common.max(s.data) }

pub fn math_stochastic_prog_path_to_string(s : MathstochasticprogPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathstochasticprogCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_stochastic_prog_cluster_make(size : Int) -> MathstochasticprogCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_stochastic_prog_cluster_len(s : MathstochasticprogCluster) -> Int { s.size }

pub fn math_stochastic_prog_cluster_get(s : MathstochasticprogCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_stochastic_prog_cluster_set(s : MathstochasticprogCluster, i : Int, v : Double) -> MathstochasticprogCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_stochastic_prog_cluster_sum(s : MathstochasticprogCluster) -> Double { @_common.sum(s.data) }

pub fn math_stochastic_prog_cluster_mean(s : MathstochasticprogCluster) -> Double { @_common.mean(s.data) }

pub fn math_stochastic_prog_cluster_scale(s : MathstochasticprogCluster, f : Double) -> MathstochasticprogCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_stochastic_prog_cluster_add(a : MathstochasticprogCluster, b : MathstochasticprogCluster) -> MathstochasticprogCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_stochastic_prog_cluster_copy(s : MathstochasticprogCluster) -> MathstochasticprogCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_stochastic_prog_cluster_fill(s : MathstochasticprogCluster, v : Double) -> MathstochasticprogCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_stochastic_prog_cluster_min(s : MathstochasticprogCluster) -> Double { @_common.min(s.data) }

pub fn math_stochastic_prog_cluster_max(s : MathstochasticprogCluster) -> Double { @_common.max(s.data) }

pub fn math_stochastic_prog_cluster_to_string(s : MathstochasticprogCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathstochasticprogModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_stochastic_prog_model_make(size : Int) -> MathstochasticprogModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_stochastic_prog_model_len(s : MathstochasticprogModel) -> Int { s.size }

pub fn math_stochastic_prog_model_get(s : MathstochasticprogModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_stochastic_prog_model_set(s : MathstochasticprogModel, i : Int, v : Double) -> MathstochasticprogModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_stochastic_prog_model_sum(s : MathstochasticprogModel) -> Double { @_common.sum(s.data) }

pub fn math_stochastic_prog_model_mean(s : MathstochasticprogModel) -> Double { @_common.mean(s.data) }

pub fn math_stochastic_prog_model_scale(s : MathstochasticprogModel, f : Double) -> MathstochasticprogModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_stochastic_prog_model_add(a : MathstochasticprogModel, b : MathstochasticprogModel) -> MathstochasticprogModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_stochastic_prog_model_copy(s : MathstochasticprogModel) -> MathstochasticprogModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_stochastic_prog_model_fill(s : MathstochasticprogModel, v : Double) -> MathstochasticprogModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_stochastic_prog_model_min(s : MathstochasticprogModel) -> Double { @_common.min(s.data) }

pub fn math_stochastic_prog_model_max(s : MathstochasticprogModel) -> Double { @_common.max(s.data) }

pub fn math_stochastic_prog_model_to_string(s : MathstochasticprogModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathstochasticprogLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_stochastic_prog_layer_make(size : Int) -> MathstochasticprogLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_stochastic_prog_layer_len(s : MathstochasticprogLayer) -> Int { s.size }

pub fn math_stochastic_prog_layer_get(s : MathstochasticprogLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_stochastic_prog_layer_set(s : MathstochasticprogLayer, i : Int, v : Double) -> MathstochasticprogLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_stochastic_prog_layer_sum(s : MathstochasticprogLayer) -> Double { @_common.sum(s.data) }

pub fn math_stochastic_prog_layer_mean(s : MathstochasticprogLayer) -> Double { @_common.mean(s.data) }

pub fn math_stochastic_prog_layer_scale(s : MathstochasticprogLayer, f : Double) -> MathstochasticprogLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_stochastic_prog_layer_add(a : MathstochasticprogLayer, b : MathstochasticprogLayer) -> MathstochasticprogLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_stochastic_prog_layer_copy(s : MathstochasticprogLayer) -> MathstochasticprogLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_stochastic_prog_layer_fill(s : MathstochasticprogLayer, v : Double) -> MathstochasticprogLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_stochastic_prog_layer_min(s : MathstochasticprogLayer) -> Double { @_common.min(s.data) }

pub fn math_stochastic_prog_layer_max(s : MathstochasticprogLayer) -> Double { @_common.max(s.data) }

pub fn math_stochastic_prog_layer_to_string(s : MathstochasticprogLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathstochasticprogBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_stochastic_prog_buffer_make(size : Int) -> MathstochasticprogBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_stochastic_prog_buffer_len(s : MathstochasticprogBuffer) -> Int { s.size }

pub fn math_stochastic_prog_buffer_get(s : MathstochasticprogBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_stochastic_prog_buffer_set(s : MathstochasticprogBuffer, i : Int, v : Double) -> MathstochasticprogBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_stochastic_prog_buffer_sum(s : MathstochasticprogBuffer) -> Double { @_common.sum(s.data) }

pub fn math_stochastic_prog_buffer_mean(s : MathstochasticprogBuffer) -> Double { @_common.mean(s.data) }

pub fn math_stochastic_prog_buffer_scale(s : MathstochasticprogBuffer, f : Double) -> MathstochasticprogBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_stochastic_prog_buffer_add(a : MathstochasticprogBuffer, b : MathstochasticprogBuffer) -> MathstochasticprogBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_stochastic_prog_buffer_copy(s : MathstochasticprogBuffer) -> MathstochasticprogBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_stochastic_prog_buffer_fill(s : MathstochasticprogBuffer, v : Double) -> MathstochasticprogBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_stochastic_prog_buffer_min(s : MathstochasticprogBuffer) -> Double { @_common.min(s.data) }

pub fn math_stochastic_prog_buffer_max(s : MathstochasticprogBuffer) -> Double { @_common.max(s.data) }

pub fn math_stochastic_prog_buffer_to_string(s : MathstochasticprogBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathstochasticprogCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_stochastic_prog_cursor_make(size : Int) -> MathstochasticprogCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_stochastic_prog_cursor_len(s : MathstochasticprogCursor) -> Int { s.size }

pub fn math_stochastic_prog_cursor_get(s : MathstochasticprogCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_stochastic_prog_cursor_set(s : MathstochasticprogCursor, i : Int, v : Double) -> MathstochasticprogCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_stochastic_prog_cursor_sum(s : MathstochasticprogCursor) -> Double { @_common.sum(s.data) }

pub fn math_stochastic_prog_cursor_mean(s : MathstochasticprogCursor) -> Double { @_common.mean(s.data) }

pub fn math_stochastic_prog_cursor_scale(s : MathstochasticprogCursor, f : Double) -> MathstochasticprogCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_stochastic_prog_cursor_add(a : MathstochasticprogCursor, b : MathstochasticprogCursor) -> MathstochasticprogCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_stochastic_prog_cursor_copy(s : MathstochasticprogCursor) -> MathstochasticprogCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_stochastic_prog_cursor_fill(s : MathstochasticprogCursor, v : Double) -> MathstochasticprogCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_stochastic_prog_cursor_min(s : MathstochasticprogCursor) -> Double { @_common.min(s.data) }

pub fn math_stochastic_prog_cursor_max(s : MathstochasticprogCursor) -> Double { @_common.max(s.data) }

pub fn math_stochastic_prog_cursor_to_string(s : MathstochasticprogCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathstochasticprogView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_stochastic_prog_view_make(size : Int) -> MathstochasticprogView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_stochastic_prog_view_len(s : MathstochasticprogView) -> Int { s.size }

pub fn math_stochastic_prog_view_get(s : MathstochasticprogView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_stochastic_prog_view_set(s : MathstochasticprogView, i : Int, v : Double) -> MathstochasticprogView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_stochastic_prog_view_sum(s : MathstochasticprogView) -> Double { @_common.sum(s.data) }

pub fn math_stochastic_prog_view_mean(s : MathstochasticprogView) -> Double { @_common.mean(s.data) }

pub fn math_stochastic_prog_view_scale(s : MathstochasticprogView, f : Double) -> MathstochasticprogView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_stochastic_prog_view_add(a : MathstochasticprogView, b : MathstochasticprogView) -> MathstochasticprogView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_stochastic_prog_view_copy(s : MathstochasticprogView) -> MathstochasticprogView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_stochastic_prog_view_fill(s : MathstochasticprogView, v : Double) -> MathstochasticprogView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_stochastic_prog_view_min(s : MathstochasticprogView) -> Double { @_common.min(s.data) }

pub fn math_stochastic_prog_view_max(s : MathstochasticprogView) -> Double { @_common.max(s.data) }

pub fn math_stochastic_prog_view_to_string(s : MathstochasticprogView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathstochasticprogRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_stochastic_prog_range_make(size : Int) -> MathstochasticprogRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_stochastic_prog_range_len(s : MathstochasticprogRange) -> Int { s.size }

pub fn math_stochastic_prog_range_get(s : MathstochasticprogRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_stochastic_prog_range_set(s : MathstochasticprogRange, i : Int, v : Double) -> MathstochasticprogRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_stochastic_prog_range_sum(s : MathstochasticprogRange) -> Double { @_common.sum(s.data) }

pub fn math_stochastic_prog_range_mean(s : MathstochasticprogRange) -> Double { @_common.mean(s.data) }

pub fn math_stochastic_prog_range_scale(s : MathstochasticprogRange, f : Double) -> MathstochasticprogRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_stochastic_prog_range_add(a : MathstochasticprogRange, b : MathstochasticprogRange) -> MathstochasticprogRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_stochastic_prog_range_copy(s : MathstochasticprogRange) -> MathstochasticprogRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_stochastic_prog_range_fill(s : MathstochasticprogRange, v : Double) -> MathstochasticprogRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_stochastic_prog_range_min(s : MathstochasticprogRange) -> Double { @_common.min(s.data) }

pub fn math_stochastic_prog_range_max(s : MathstochasticprogRange) -> Double { @_common.max(s.data) }

pub fn math_stochastic_prog_range_to_string(s : MathstochasticprogRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathstochasticprogSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_stochastic_prog_slice_make(size : Int) -> MathstochasticprogSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_stochastic_prog_slice_len(s : MathstochasticprogSlice) -> Int { s.size }

pub fn math_stochastic_prog_slice_get(s : MathstochasticprogSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_stochastic_prog_slice_set(s : MathstochasticprogSlice, i : Int, v : Double) -> MathstochasticprogSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_stochastic_prog_slice_sum(s : MathstochasticprogSlice) -> Double { @_common.sum(s.data) }

pub fn math_stochastic_prog_slice_mean(s : MathstochasticprogSlice) -> Double { @_common.mean(s.data) }

pub fn math_stochastic_prog_slice_scale(s : MathstochasticprogSlice, f : Double) -> MathstochasticprogSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_stochastic_prog_slice_add(a : MathstochasticprogSlice, b : MathstochasticprogSlice) -> MathstochasticprogSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_stochastic_prog_slice_copy(s : MathstochasticprogSlice) -> MathstochasticprogSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_stochastic_prog_slice_fill(s : MathstochasticprogSlice, v : Double) -> MathstochasticprogSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_stochastic_prog_slice_min(s : MathstochasticprogSlice) -> Double { @_common.min(s.data) }

pub fn math_stochastic_prog_slice_max(s : MathstochasticprogSlice) -> Double { @_common.max(s.data) }

pub fn math_stochastic_prog_slice_to_string(s : MathstochasticprogSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

