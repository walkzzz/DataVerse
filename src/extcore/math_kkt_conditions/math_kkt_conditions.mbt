///===
/// extcore/math_kkt_conditions

pub(all) struct MathkktconditionsPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn math_kkt_conditions_make_point(x : Double, y : Double) -> MathkktconditionsPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn math_kkt_conditions_make_point3(x : Double, y : Double, z : Double) -> MathkktconditionsPoint {
  { x, y, z, label: 0 }
}

pub fn MathkktconditionsPoint::x(self : MathkktconditionsPoint) -> Double { self.x }

pub fn MathkktconditionsPoint::y(self : MathkktconditionsPoint) -> Double { self.y }

pub fn MathkktconditionsPoint::z(self : MathkktconditionsPoint) -> Double { self.z }

pub fn MathkktconditionsPoint::label(self : MathkktconditionsPoint) -> Int { self.label }

pub fn MathkktconditionsPoint::dist(self : MathkktconditionsPoint, other : MathkktconditionsPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn MathkktconditionsPoint::add(self : MathkktconditionsPoint, other : MathkktconditionsPoint) -> MathkktconditionsPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn MathkktconditionsPoint::sub(self : MathkktconditionsPoint, other : MathkktconditionsPoint) -> MathkktconditionsPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn MathkktconditionsPoint::scale(self : MathkktconditionsPoint, s : Double) -> MathkktconditionsPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn MathkktconditionsPoint::dot(self : MathkktconditionsPoint, other : MathkktconditionsPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn MathkktconditionsPoint::cross(self : MathkktconditionsPoint, other : MathkktconditionsPoint) -> MathkktconditionsPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn MathkktconditionsPoint::norm(self : MathkktconditionsPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn MathkktconditionsPoint::normalize(self : MathkktconditionsPoint) -> MathkktconditionsPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn MathkktconditionsPoint::negate(self : MathkktconditionsPoint) -> MathkktconditionsPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn MathkktconditionsPoint::mid(self : MathkktconditionsPoint, other : MathkktconditionsPoint) -> MathkktconditionsPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn MathkktconditionsPoint::lerp(self : MathkktconditionsPoint, other : MathkktconditionsPoint, t : Double) -> MathkktconditionsPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn MathkktconditionsPoint::to_string(self : MathkktconditionsPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct MathkktconditionsSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn math_kkt_conditions_make_series(vals : Array[Double], name : String) -> MathkktconditionsSeries {
  { vals, name, meta: 0 }
}

pub fn MathkktconditionsSeries::len(self : MathkktconditionsSeries) -> Int { self.vals.length() }

pub fn MathkktconditionsSeries::sum(self : MathkktconditionsSeries) -> Double { @_common.sum(self.vals) }

pub fn MathkktconditionsSeries::mean(self : MathkktconditionsSeries) -> Double { @_common.mean(self.vals) }

pub fn MathkktconditionsSeries::min(self : MathkktconditionsSeries) -> Double { @_common.min(self.vals) }

pub fn MathkktconditionsSeries::max(self : MathkktconditionsSeries) -> Double { @_common.max(self.vals) }

pub fn MathkktconditionsSeries::range(self : MathkktconditionsSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn MathkktconditionsSeries::variance(self : MathkktconditionsSeries) -> Double { @_common.variance(self.vals) }

pub fn MathkktconditionsSeries::std(self : MathkktconditionsSeries) -> Double { @_common.std(self.vals) }

pub fn MathkktconditionsSeries::median(self : MathkktconditionsSeries) -> Double { @_common.median(self.vals) }

pub fn MathkktconditionsSeries::scale(self : MathkktconditionsSeries, f : Double) -> MathkktconditionsSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn MathkktconditionsSeries::add(self : MathkktconditionsSeries, other : MathkktconditionsSeries) -> MathkktconditionsSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn MathkktconditionsSeries::sub(self : MathkktconditionsSeries, other : MathkktconditionsSeries) -> MathkktconditionsSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn MathkktconditionsSeries::normalize(self : MathkktconditionsSeries) -> MathkktconditionsSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn MathkktconditionsSeries::cumsum(self : MathkktconditionsSeries) -> MathkktconditionsSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn MathkktconditionsSeries::to_string(self : MathkktconditionsSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct MathkktconditionsMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn math_kkt_conditions_make_matrix(rows : Int, cols : Int, val : Double) -> MathkktconditionsMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn math_kkt_conditions_matrix_identity(n : Int) -> MathkktconditionsMatrix {
  let m = math_kkt_conditions_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn MathkktconditionsMatrix::get(self : MathkktconditionsMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn MathkktconditionsMatrix::transpose(self : MathkktconditionsMatrix) -> MathkktconditionsMatrix {
  let result = math_kkt_conditions_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn MathkktconditionsMatrix::add(self : MathkktconditionsMatrix, other : MathkktconditionsMatrix) -> MathkktconditionsMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = math_kkt_conditions_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn MathkktconditionsMatrix::scale(self : MathkktconditionsMatrix, s : Double) -> MathkktconditionsMatrix {
  let result = math_kkt_conditions_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn MathkktconditionsMatrix::multiply(self : MathkktconditionsMatrix, other : MathkktconditionsMatrix) -> MathkktconditionsMatrix {
  if self.cols != other.rows { return math_kkt_conditions_make_matrix(self.rows, other.cols, 0.0) }
  let result = math_kkt_conditions_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn MathkktconditionsMatrix::trace(self : MathkktconditionsMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn MathkktconditionsMatrix::det(self : MathkktconditionsMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn MathkktconditionsMatrix::norm(self : MathkktconditionsMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn MathkktconditionsMatrix::to_string(self : MathkktconditionsMatrix) -> String {
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

pub(all) struct MathkktconditionsVector {
  comps : Array[Double]
  dim : Int
}

pub fn math_kkt_conditions_make_vector(comps : Array[Double]) -> MathkktconditionsVector {
  { comps, dim: comps.length() }
}

pub fn math_kkt_conditions_vector_zero(dim : Int) -> MathkktconditionsVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn MathkktconditionsVector::add(self : MathkktconditionsVector, other : MathkktconditionsVector) -> MathkktconditionsVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn MathkktconditionsVector::sub(self : MathkktconditionsVector, other : MathkktconditionsVector) -> MathkktconditionsVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn MathkktconditionsVector::scale(self : MathkktconditionsVector, s : Double) -> MathkktconditionsVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn MathkktconditionsVector::dot(self : MathkktconditionsVector, other : MathkktconditionsVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn MathkktconditionsVector::norm(self : MathkktconditionsVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn MathkktconditionsVector::normalize(self : MathkktconditionsVector) -> MathkktconditionsVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn MathkktconditionsVector::dist(self : MathkktconditionsVector, other : MathkktconditionsVector) -> Double {
  self.sub(other).norm()
}

pub fn MathkktconditionsVector::to_string(self : MathkktconditionsVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn math_kkt_conditions_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn math_kkt_conditions_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn math_kkt_conditions_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn math_kkt_conditions_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn math_kkt_conditions_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn math_kkt_conditions_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn math_kkt_conditions_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn math_kkt_conditions_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn math_kkt_conditions_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn math_kkt_conditions_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn math_kkt_conditions_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn math_kkt_conditions_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn math_kkt_conditions_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn math_kkt_conditions_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn math_kkt_conditions_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn math_kkt_conditions_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn math_kkt_conditions_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn math_kkt_conditions_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn math_kkt_conditions_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn math_kkt_conditions_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn math_kkt_conditions_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn math_kkt_conditions_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn math_kkt_conditions_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn math_kkt_conditions_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn math_kkt_conditions_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn math_kkt_conditions_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn math_kkt_conditions_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn math_kkt_conditions_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn math_kkt_conditions_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct MathkktconditionsFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_kkt_conditions_frame_make(size : Int) -> MathkktconditionsFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_kkt_conditions_frame_len(s : MathkktconditionsFrame) -> Int { s.size }

pub fn math_kkt_conditions_frame_get(s : MathkktconditionsFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_kkt_conditions_frame_set(s : MathkktconditionsFrame, i : Int, v : Double) -> MathkktconditionsFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_kkt_conditions_frame_sum(s : MathkktconditionsFrame) -> Double { @_common.sum(s.data) }

pub fn math_kkt_conditions_frame_mean(s : MathkktconditionsFrame) -> Double { @_common.mean(s.data) }

pub fn math_kkt_conditions_frame_scale(s : MathkktconditionsFrame, f : Double) -> MathkktconditionsFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_kkt_conditions_frame_add(a : MathkktconditionsFrame, b : MathkktconditionsFrame) -> MathkktconditionsFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_kkt_conditions_frame_copy(s : MathkktconditionsFrame) -> MathkktconditionsFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_kkt_conditions_frame_fill(s : MathkktconditionsFrame, v : Double) -> MathkktconditionsFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_kkt_conditions_frame_min(s : MathkktconditionsFrame) -> Double { @_common.min(s.data) }

pub fn math_kkt_conditions_frame_max(s : MathkktconditionsFrame) -> Double { @_common.max(s.data) }

pub fn math_kkt_conditions_frame_to_string(s : MathkktconditionsFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathkktconditionsTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_kkt_conditions_table_make(size : Int) -> MathkktconditionsTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_kkt_conditions_table_len(s : MathkktconditionsTable) -> Int { s.size }

pub fn math_kkt_conditions_table_get(s : MathkktconditionsTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_kkt_conditions_table_set(s : MathkktconditionsTable, i : Int, v : Double) -> MathkktconditionsTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_kkt_conditions_table_sum(s : MathkktconditionsTable) -> Double { @_common.sum(s.data) }

pub fn math_kkt_conditions_table_mean(s : MathkktconditionsTable) -> Double { @_common.mean(s.data) }

pub fn math_kkt_conditions_table_scale(s : MathkktconditionsTable, f : Double) -> MathkktconditionsTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_kkt_conditions_table_add(a : MathkktconditionsTable, b : MathkktconditionsTable) -> MathkktconditionsTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_kkt_conditions_table_copy(s : MathkktconditionsTable) -> MathkktconditionsTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_kkt_conditions_table_fill(s : MathkktconditionsTable, v : Double) -> MathkktconditionsTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_kkt_conditions_table_min(s : MathkktconditionsTable) -> Double { @_common.min(s.data) }

pub fn math_kkt_conditions_table_max(s : MathkktconditionsTable) -> Double { @_common.max(s.data) }

pub fn math_kkt_conditions_table_to_string(s : MathkktconditionsTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathkktconditionsGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_kkt_conditions_graphn_make(size : Int) -> MathkktconditionsGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_kkt_conditions_graphn_len(s : MathkktconditionsGraphN) -> Int { s.size }

pub fn math_kkt_conditions_graphn_get(s : MathkktconditionsGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_kkt_conditions_graphn_set(s : MathkktconditionsGraphN, i : Int, v : Double) -> MathkktconditionsGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_kkt_conditions_graphn_sum(s : MathkktconditionsGraphN) -> Double { @_common.sum(s.data) }

pub fn math_kkt_conditions_graphn_mean(s : MathkktconditionsGraphN) -> Double { @_common.mean(s.data) }

pub fn math_kkt_conditions_graphn_scale(s : MathkktconditionsGraphN, f : Double) -> MathkktconditionsGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_kkt_conditions_graphn_add(a : MathkktconditionsGraphN, b : MathkktconditionsGraphN) -> MathkktconditionsGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_kkt_conditions_graphn_copy(s : MathkktconditionsGraphN) -> MathkktconditionsGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_kkt_conditions_graphn_fill(s : MathkktconditionsGraphN, v : Double) -> MathkktconditionsGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_kkt_conditions_graphn_min(s : MathkktconditionsGraphN) -> Double { @_common.min(s.data) }

pub fn math_kkt_conditions_graphn_max(s : MathkktconditionsGraphN) -> Double { @_common.max(s.data) }

pub fn math_kkt_conditions_graphn_to_string(s : MathkktconditionsGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathkktconditionsNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_kkt_conditions_node_make(size : Int) -> MathkktconditionsNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_kkt_conditions_node_len(s : MathkktconditionsNode) -> Int { s.size }

pub fn math_kkt_conditions_node_get(s : MathkktconditionsNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_kkt_conditions_node_set(s : MathkktconditionsNode, i : Int, v : Double) -> MathkktconditionsNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_kkt_conditions_node_sum(s : MathkktconditionsNode) -> Double { @_common.sum(s.data) }

pub fn math_kkt_conditions_node_mean(s : MathkktconditionsNode) -> Double { @_common.mean(s.data) }

pub fn math_kkt_conditions_node_scale(s : MathkktconditionsNode, f : Double) -> MathkktconditionsNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_kkt_conditions_node_add(a : MathkktconditionsNode, b : MathkktconditionsNode) -> MathkktconditionsNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_kkt_conditions_node_copy(s : MathkktconditionsNode) -> MathkktconditionsNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_kkt_conditions_node_fill(s : MathkktconditionsNode, v : Double) -> MathkktconditionsNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_kkt_conditions_node_min(s : MathkktconditionsNode) -> Double { @_common.min(s.data) }

pub fn math_kkt_conditions_node_max(s : MathkktconditionsNode) -> Double { @_common.max(s.data) }

pub fn math_kkt_conditions_node_to_string(s : MathkktconditionsNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathkktconditionsEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_kkt_conditions_edge_make(size : Int) -> MathkktconditionsEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_kkt_conditions_edge_len(s : MathkktconditionsEdge) -> Int { s.size }

pub fn math_kkt_conditions_edge_get(s : MathkktconditionsEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_kkt_conditions_edge_set(s : MathkktconditionsEdge, i : Int, v : Double) -> MathkktconditionsEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_kkt_conditions_edge_sum(s : MathkktconditionsEdge) -> Double { @_common.sum(s.data) }

pub fn math_kkt_conditions_edge_mean(s : MathkktconditionsEdge) -> Double { @_common.mean(s.data) }

pub fn math_kkt_conditions_edge_scale(s : MathkktconditionsEdge, f : Double) -> MathkktconditionsEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_kkt_conditions_edge_add(a : MathkktconditionsEdge, b : MathkktconditionsEdge) -> MathkktconditionsEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_kkt_conditions_edge_copy(s : MathkktconditionsEdge) -> MathkktconditionsEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_kkt_conditions_edge_fill(s : MathkktconditionsEdge, v : Double) -> MathkktconditionsEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_kkt_conditions_edge_min(s : MathkktconditionsEdge) -> Double { @_common.min(s.data) }

pub fn math_kkt_conditions_edge_max(s : MathkktconditionsEdge) -> Double { @_common.max(s.data) }

pub fn math_kkt_conditions_edge_to_string(s : MathkktconditionsEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathkktconditionsPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_kkt_conditions_path_make(size : Int) -> MathkktconditionsPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_kkt_conditions_path_len(s : MathkktconditionsPath) -> Int { s.size }

pub fn math_kkt_conditions_path_get(s : MathkktconditionsPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_kkt_conditions_path_set(s : MathkktconditionsPath, i : Int, v : Double) -> MathkktconditionsPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_kkt_conditions_path_sum(s : MathkktconditionsPath) -> Double { @_common.sum(s.data) }

pub fn math_kkt_conditions_path_mean(s : MathkktconditionsPath) -> Double { @_common.mean(s.data) }

pub fn math_kkt_conditions_path_scale(s : MathkktconditionsPath, f : Double) -> MathkktconditionsPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_kkt_conditions_path_add(a : MathkktconditionsPath, b : MathkktconditionsPath) -> MathkktconditionsPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_kkt_conditions_path_copy(s : MathkktconditionsPath) -> MathkktconditionsPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_kkt_conditions_path_fill(s : MathkktconditionsPath, v : Double) -> MathkktconditionsPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_kkt_conditions_path_min(s : MathkktconditionsPath) -> Double { @_common.min(s.data) }

pub fn math_kkt_conditions_path_max(s : MathkktconditionsPath) -> Double { @_common.max(s.data) }

pub fn math_kkt_conditions_path_to_string(s : MathkktconditionsPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathkktconditionsCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_kkt_conditions_cluster_make(size : Int) -> MathkktconditionsCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_kkt_conditions_cluster_len(s : MathkktconditionsCluster) -> Int { s.size }

pub fn math_kkt_conditions_cluster_get(s : MathkktconditionsCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_kkt_conditions_cluster_set(s : MathkktconditionsCluster, i : Int, v : Double) -> MathkktconditionsCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_kkt_conditions_cluster_sum(s : MathkktconditionsCluster) -> Double { @_common.sum(s.data) }

pub fn math_kkt_conditions_cluster_mean(s : MathkktconditionsCluster) -> Double { @_common.mean(s.data) }

pub fn math_kkt_conditions_cluster_scale(s : MathkktconditionsCluster, f : Double) -> MathkktconditionsCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_kkt_conditions_cluster_add(a : MathkktconditionsCluster, b : MathkktconditionsCluster) -> MathkktconditionsCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_kkt_conditions_cluster_copy(s : MathkktconditionsCluster) -> MathkktconditionsCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_kkt_conditions_cluster_fill(s : MathkktconditionsCluster, v : Double) -> MathkktconditionsCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_kkt_conditions_cluster_min(s : MathkktconditionsCluster) -> Double { @_common.min(s.data) }

pub fn math_kkt_conditions_cluster_max(s : MathkktconditionsCluster) -> Double { @_common.max(s.data) }

pub fn math_kkt_conditions_cluster_to_string(s : MathkktconditionsCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathkktconditionsModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_kkt_conditions_model_make(size : Int) -> MathkktconditionsModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_kkt_conditions_model_len(s : MathkktconditionsModel) -> Int { s.size }

pub fn math_kkt_conditions_model_get(s : MathkktconditionsModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_kkt_conditions_model_set(s : MathkktconditionsModel, i : Int, v : Double) -> MathkktconditionsModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_kkt_conditions_model_sum(s : MathkktconditionsModel) -> Double { @_common.sum(s.data) }

pub fn math_kkt_conditions_model_mean(s : MathkktconditionsModel) -> Double { @_common.mean(s.data) }

pub fn math_kkt_conditions_model_scale(s : MathkktconditionsModel, f : Double) -> MathkktconditionsModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_kkt_conditions_model_add(a : MathkktconditionsModel, b : MathkktconditionsModel) -> MathkktconditionsModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_kkt_conditions_model_copy(s : MathkktconditionsModel) -> MathkktconditionsModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_kkt_conditions_model_fill(s : MathkktconditionsModel, v : Double) -> MathkktconditionsModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_kkt_conditions_model_min(s : MathkktconditionsModel) -> Double { @_common.min(s.data) }

pub fn math_kkt_conditions_model_max(s : MathkktconditionsModel) -> Double { @_common.max(s.data) }

pub fn math_kkt_conditions_model_to_string(s : MathkktconditionsModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathkktconditionsLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_kkt_conditions_layer_make(size : Int) -> MathkktconditionsLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_kkt_conditions_layer_len(s : MathkktconditionsLayer) -> Int { s.size }

pub fn math_kkt_conditions_layer_get(s : MathkktconditionsLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_kkt_conditions_layer_set(s : MathkktconditionsLayer, i : Int, v : Double) -> MathkktconditionsLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_kkt_conditions_layer_sum(s : MathkktconditionsLayer) -> Double { @_common.sum(s.data) }

pub fn math_kkt_conditions_layer_mean(s : MathkktconditionsLayer) -> Double { @_common.mean(s.data) }

pub fn math_kkt_conditions_layer_scale(s : MathkktconditionsLayer, f : Double) -> MathkktconditionsLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_kkt_conditions_layer_add(a : MathkktconditionsLayer, b : MathkktconditionsLayer) -> MathkktconditionsLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_kkt_conditions_layer_copy(s : MathkktconditionsLayer) -> MathkktconditionsLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_kkt_conditions_layer_fill(s : MathkktconditionsLayer, v : Double) -> MathkktconditionsLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_kkt_conditions_layer_min(s : MathkktconditionsLayer) -> Double { @_common.min(s.data) }

pub fn math_kkt_conditions_layer_max(s : MathkktconditionsLayer) -> Double { @_common.max(s.data) }

pub fn math_kkt_conditions_layer_to_string(s : MathkktconditionsLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathkktconditionsBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_kkt_conditions_buffer_make(size : Int) -> MathkktconditionsBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_kkt_conditions_buffer_len(s : MathkktconditionsBuffer) -> Int { s.size }

pub fn math_kkt_conditions_buffer_get(s : MathkktconditionsBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_kkt_conditions_buffer_set(s : MathkktconditionsBuffer, i : Int, v : Double) -> MathkktconditionsBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_kkt_conditions_buffer_sum(s : MathkktconditionsBuffer) -> Double { @_common.sum(s.data) }

pub fn math_kkt_conditions_buffer_mean(s : MathkktconditionsBuffer) -> Double { @_common.mean(s.data) }

pub fn math_kkt_conditions_buffer_scale(s : MathkktconditionsBuffer, f : Double) -> MathkktconditionsBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_kkt_conditions_buffer_add(a : MathkktconditionsBuffer, b : MathkktconditionsBuffer) -> MathkktconditionsBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_kkt_conditions_buffer_copy(s : MathkktconditionsBuffer) -> MathkktconditionsBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_kkt_conditions_buffer_fill(s : MathkktconditionsBuffer, v : Double) -> MathkktconditionsBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_kkt_conditions_buffer_min(s : MathkktconditionsBuffer) -> Double { @_common.min(s.data) }

pub fn math_kkt_conditions_buffer_max(s : MathkktconditionsBuffer) -> Double { @_common.max(s.data) }

pub fn math_kkt_conditions_buffer_to_string(s : MathkktconditionsBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathkktconditionsCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_kkt_conditions_cursor_make(size : Int) -> MathkktconditionsCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_kkt_conditions_cursor_len(s : MathkktconditionsCursor) -> Int { s.size }

pub fn math_kkt_conditions_cursor_get(s : MathkktconditionsCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_kkt_conditions_cursor_set(s : MathkktconditionsCursor, i : Int, v : Double) -> MathkktconditionsCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_kkt_conditions_cursor_sum(s : MathkktconditionsCursor) -> Double { @_common.sum(s.data) }

pub fn math_kkt_conditions_cursor_mean(s : MathkktconditionsCursor) -> Double { @_common.mean(s.data) }

pub fn math_kkt_conditions_cursor_scale(s : MathkktconditionsCursor, f : Double) -> MathkktconditionsCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_kkt_conditions_cursor_add(a : MathkktconditionsCursor, b : MathkktconditionsCursor) -> MathkktconditionsCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_kkt_conditions_cursor_copy(s : MathkktconditionsCursor) -> MathkktconditionsCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_kkt_conditions_cursor_fill(s : MathkktconditionsCursor, v : Double) -> MathkktconditionsCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_kkt_conditions_cursor_min(s : MathkktconditionsCursor) -> Double { @_common.min(s.data) }

pub fn math_kkt_conditions_cursor_max(s : MathkktconditionsCursor) -> Double { @_common.max(s.data) }

pub fn math_kkt_conditions_cursor_to_string(s : MathkktconditionsCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathkktconditionsView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_kkt_conditions_view_make(size : Int) -> MathkktconditionsView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_kkt_conditions_view_len(s : MathkktconditionsView) -> Int { s.size }

pub fn math_kkt_conditions_view_get(s : MathkktconditionsView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_kkt_conditions_view_set(s : MathkktconditionsView, i : Int, v : Double) -> MathkktconditionsView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_kkt_conditions_view_sum(s : MathkktconditionsView) -> Double { @_common.sum(s.data) }

pub fn math_kkt_conditions_view_mean(s : MathkktconditionsView) -> Double { @_common.mean(s.data) }

pub fn math_kkt_conditions_view_scale(s : MathkktconditionsView, f : Double) -> MathkktconditionsView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_kkt_conditions_view_add(a : MathkktconditionsView, b : MathkktconditionsView) -> MathkktconditionsView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_kkt_conditions_view_copy(s : MathkktconditionsView) -> MathkktconditionsView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_kkt_conditions_view_fill(s : MathkktconditionsView, v : Double) -> MathkktconditionsView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_kkt_conditions_view_min(s : MathkktconditionsView) -> Double { @_common.min(s.data) }

pub fn math_kkt_conditions_view_max(s : MathkktconditionsView) -> Double { @_common.max(s.data) }

pub fn math_kkt_conditions_view_to_string(s : MathkktconditionsView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathkktconditionsRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_kkt_conditions_range_make(size : Int) -> MathkktconditionsRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_kkt_conditions_range_len(s : MathkktconditionsRange) -> Int { s.size }

pub fn math_kkt_conditions_range_get(s : MathkktconditionsRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_kkt_conditions_range_set(s : MathkktconditionsRange, i : Int, v : Double) -> MathkktconditionsRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_kkt_conditions_range_sum(s : MathkktconditionsRange) -> Double { @_common.sum(s.data) }

pub fn math_kkt_conditions_range_mean(s : MathkktconditionsRange) -> Double { @_common.mean(s.data) }

pub fn math_kkt_conditions_range_scale(s : MathkktconditionsRange, f : Double) -> MathkktconditionsRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_kkt_conditions_range_add(a : MathkktconditionsRange, b : MathkktconditionsRange) -> MathkktconditionsRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_kkt_conditions_range_copy(s : MathkktconditionsRange) -> MathkktconditionsRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_kkt_conditions_range_fill(s : MathkktconditionsRange, v : Double) -> MathkktconditionsRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_kkt_conditions_range_min(s : MathkktconditionsRange) -> Double { @_common.min(s.data) }

pub fn math_kkt_conditions_range_max(s : MathkktconditionsRange) -> Double { @_common.max(s.data) }

pub fn math_kkt_conditions_range_to_string(s : MathkktconditionsRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathkktconditionsSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_kkt_conditions_slice_make(size : Int) -> MathkktconditionsSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_kkt_conditions_slice_len(s : MathkktconditionsSlice) -> Int { s.size }

pub fn math_kkt_conditions_slice_get(s : MathkktconditionsSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_kkt_conditions_slice_set(s : MathkktconditionsSlice, i : Int, v : Double) -> MathkktconditionsSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_kkt_conditions_slice_sum(s : MathkktconditionsSlice) -> Double { @_common.sum(s.data) }

pub fn math_kkt_conditions_slice_mean(s : MathkktconditionsSlice) -> Double { @_common.mean(s.data) }

pub fn math_kkt_conditions_slice_scale(s : MathkktconditionsSlice, f : Double) -> MathkktconditionsSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_kkt_conditions_slice_add(a : MathkktconditionsSlice, b : MathkktconditionsSlice) -> MathkktconditionsSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_kkt_conditions_slice_copy(s : MathkktconditionsSlice) -> MathkktconditionsSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_kkt_conditions_slice_fill(s : MathkktconditionsSlice, v : Double) -> MathkktconditionsSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_kkt_conditions_slice_min(s : MathkktconditionsSlice) -> Double { @_common.min(s.data) }

pub fn math_kkt_conditions_slice_max(s : MathkktconditionsSlice) -> Double { @_common.max(s.data) }

pub fn math_kkt_conditions_slice_to_string(s : MathkktconditionsSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

