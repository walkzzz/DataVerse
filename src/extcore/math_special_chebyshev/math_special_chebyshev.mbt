///===
/// extcore/math_special_chebyshev

pub(all) struct MathspecialchebyshevPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn math_special_chebyshev_make_point(x : Double, y : Double) -> MathspecialchebyshevPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn math_special_chebyshev_make_point3(x : Double, y : Double, z : Double) -> MathspecialchebyshevPoint {
  { x, y, z, label: 0 }
}

pub fn MathspecialchebyshevPoint::x(self : MathspecialchebyshevPoint) -> Double { self.x }

pub fn MathspecialchebyshevPoint::y(self : MathspecialchebyshevPoint) -> Double { self.y }

pub fn MathspecialchebyshevPoint::z(self : MathspecialchebyshevPoint) -> Double { self.z }

pub fn MathspecialchebyshevPoint::label(self : MathspecialchebyshevPoint) -> Int { self.label }

pub fn MathspecialchebyshevPoint::dist(self : MathspecialchebyshevPoint, other : MathspecialchebyshevPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn MathspecialchebyshevPoint::add(self : MathspecialchebyshevPoint, other : MathspecialchebyshevPoint) -> MathspecialchebyshevPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn MathspecialchebyshevPoint::sub(self : MathspecialchebyshevPoint, other : MathspecialchebyshevPoint) -> MathspecialchebyshevPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn MathspecialchebyshevPoint::scale(self : MathspecialchebyshevPoint, s : Double) -> MathspecialchebyshevPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn MathspecialchebyshevPoint::dot(self : MathspecialchebyshevPoint, other : MathspecialchebyshevPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn MathspecialchebyshevPoint::cross(self : MathspecialchebyshevPoint, other : MathspecialchebyshevPoint) -> MathspecialchebyshevPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn MathspecialchebyshevPoint::norm(self : MathspecialchebyshevPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn MathspecialchebyshevPoint::normalize(self : MathspecialchebyshevPoint) -> MathspecialchebyshevPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn MathspecialchebyshevPoint::negate(self : MathspecialchebyshevPoint) -> MathspecialchebyshevPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn MathspecialchebyshevPoint::mid(self : MathspecialchebyshevPoint, other : MathspecialchebyshevPoint) -> MathspecialchebyshevPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn MathspecialchebyshevPoint::lerp(self : MathspecialchebyshevPoint, other : MathspecialchebyshevPoint, t : Double) -> MathspecialchebyshevPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn MathspecialchebyshevPoint::to_string(self : MathspecialchebyshevPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct MathspecialchebyshevSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn math_special_chebyshev_make_series(vals : Array[Double], name : String) -> MathspecialchebyshevSeries {
  { vals, name, meta: 0 }
}

pub fn MathspecialchebyshevSeries::len(self : MathspecialchebyshevSeries) -> Int { self.vals.length() }

pub fn MathspecialchebyshevSeries::sum(self : MathspecialchebyshevSeries) -> Double { @_common.sum(self.vals) }

pub fn MathspecialchebyshevSeries::mean(self : MathspecialchebyshevSeries) -> Double { @_common.mean(self.vals) }

pub fn MathspecialchebyshevSeries::min(self : MathspecialchebyshevSeries) -> Double { @_common.min(self.vals) }

pub fn MathspecialchebyshevSeries::max(self : MathspecialchebyshevSeries) -> Double { @_common.max(self.vals) }

pub fn MathspecialchebyshevSeries::range(self : MathspecialchebyshevSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn MathspecialchebyshevSeries::variance(self : MathspecialchebyshevSeries) -> Double { @_common.variance(self.vals) }

pub fn MathspecialchebyshevSeries::std(self : MathspecialchebyshevSeries) -> Double { @_common.std(self.vals) }

pub fn MathspecialchebyshevSeries::median(self : MathspecialchebyshevSeries) -> Double { @_common.median(self.vals) }

pub fn MathspecialchebyshevSeries::scale(self : MathspecialchebyshevSeries, f : Double) -> MathspecialchebyshevSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn MathspecialchebyshevSeries::add(self : MathspecialchebyshevSeries, other : MathspecialchebyshevSeries) -> MathspecialchebyshevSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn MathspecialchebyshevSeries::sub(self : MathspecialchebyshevSeries, other : MathspecialchebyshevSeries) -> MathspecialchebyshevSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn MathspecialchebyshevSeries::normalize(self : MathspecialchebyshevSeries) -> MathspecialchebyshevSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn MathspecialchebyshevSeries::cumsum(self : MathspecialchebyshevSeries) -> MathspecialchebyshevSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn MathspecialchebyshevSeries::to_string(self : MathspecialchebyshevSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct MathspecialchebyshevMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn math_special_chebyshev_make_matrix(rows : Int, cols : Int, val : Double) -> MathspecialchebyshevMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn math_special_chebyshev_matrix_identity(n : Int) -> MathspecialchebyshevMatrix {
  let m = math_special_chebyshev_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn MathspecialchebyshevMatrix::get(self : MathspecialchebyshevMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn MathspecialchebyshevMatrix::transpose(self : MathspecialchebyshevMatrix) -> MathspecialchebyshevMatrix {
  let result = math_special_chebyshev_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn MathspecialchebyshevMatrix::add(self : MathspecialchebyshevMatrix, other : MathspecialchebyshevMatrix) -> MathspecialchebyshevMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = math_special_chebyshev_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn MathspecialchebyshevMatrix::scale(self : MathspecialchebyshevMatrix, s : Double) -> MathspecialchebyshevMatrix {
  let result = math_special_chebyshev_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn MathspecialchebyshevMatrix::multiply(self : MathspecialchebyshevMatrix, other : MathspecialchebyshevMatrix) -> MathspecialchebyshevMatrix {
  if self.cols != other.rows { return math_special_chebyshev_make_matrix(self.rows, other.cols, 0.0) }
  let result = math_special_chebyshev_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn MathspecialchebyshevMatrix::trace(self : MathspecialchebyshevMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn MathspecialchebyshevMatrix::det(self : MathspecialchebyshevMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn MathspecialchebyshevMatrix::norm(self : MathspecialchebyshevMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn MathspecialchebyshevMatrix::to_string(self : MathspecialchebyshevMatrix) -> String {
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

pub(all) struct MathspecialchebyshevVector {
  comps : Array[Double]
  dim : Int
}

pub fn math_special_chebyshev_make_vector(comps : Array[Double]) -> MathspecialchebyshevVector {
  { comps, dim: comps.length() }
}

pub fn math_special_chebyshev_vector_zero(dim : Int) -> MathspecialchebyshevVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn MathspecialchebyshevVector::add(self : MathspecialchebyshevVector, other : MathspecialchebyshevVector) -> MathspecialchebyshevVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn MathspecialchebyshevVector::sub(self : MathspecialchebyshevVector, other : MathspecialchebyshevVector) -> MathspecialchebyshevVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn MathspecialchebyshevVector::scale(self : MathspecialchebyshevVector, s : Double) -> MathspecialchebyshevVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn MathspecialchebyshevVector::dot(self : MathspecialchebyshevVector, other : MathspecialchebyshevVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn MathspecialchebyshevVector::norm(self : MathspecialchebyshevVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn MathspecialchebyshevVector::normalize(self : MathspecialchebyshevVector) -> MathspecialchebyshevVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn MathspecialchebyshevVector::dist(self : MathspecialchebyshevVector, other : MathspecialchebyshevVector) -> Double {
  self.sub(other).norm()
}

pub fn MathspecialchebyshevVector::to_string(self : MathspecialchebyshevVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn math_special_chebyshev_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn math_special_chebyshev_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn math_special_chebyshev_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn math_special_chebyshev_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn math_special_chebyshev_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn math_special_chebyshev_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn math_special_chebyshev_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn math_special_chebyshev_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn math_special_chebyshev_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn math_special_chebyshev_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn math_special_chebyshev_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn math_special_chebyshev_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn math_special_chebyshev_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn math_special_chebyshev_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn math_special_chebyshev_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn math_special_chebyshev_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn math_special_chebyshev_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn math_special_chebyshev_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn math_special_chebyshev_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn math_special_chebyshev_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn math_special_chebyshev_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn math_special_chebyshev_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn math_special_chebyshev_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn math_special_chebyshev_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn math_special_chebyshev_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn math_special_chebyshev_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn math_special_chebyshev_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn math_special_chebyshev_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn math_special_chebyshev_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct MathspecialchebyshevFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_special_chebyshev_frame_make(size : Int) -> MathspecialchebyshevFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_special_chebyshev_frame_len(s : MathspecialchebyshevFrame) -> Int { s.size }

pub fn math_special_chebyshev_frame_get(s : MathspecialchebyshevFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_special_chebyshev_frame_set(s : MathspecialchebyshevFrame, i : Int, v : Double) -> MathspecialchebyshevFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_special_chebyshev_frame_sum(s : MathspecialchebyshevFrame) -> Double { @_common.sum(s.data) }

pub fn math_special_chebyshev_frame_mean(s : MathspecialchebyshevFrame) -> Double { @_common.mean(s.data) }

pub fn math_special_chebyshev_frame_scale(s : MathspecialchebyshevFrame, f : Double) -> MathspecialchebyshevFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_special_chebyshev_frame_add(a : MathspecialchebyshevFrame, b : MathspecialchebyshevFrame) -> MathspecialchebyshevFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_special_chebyshev_frame_copy(s : MathspecialchebyshevFrame) -> MathspecialchebyshevFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_special_chebyshev_frame_fill(s : MathspecialchebyshevFrame, v : Double) -> MathspecialchebyshevFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_special_chebyshev_frame_min(s : MathspecialchebyshevFrame) -> Double { @_common.min(s.data) }

pub fn math_special_chebyshev_frame_max(s : MathspecialchebyshevFrame) -> Double { @_common.max(s.data) }

pub fn math_special_chebyshev_frame_to_string(s : MathspecialchebyshevFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathspecialchebyshevTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_special_chebyshev_table_make(size : Int) -> MathspecialchebyshevTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_special_chebyshev_table_len(s : MathspecialchebyshevTable) -> Int { s.size }

pub fn math_special_chebyshev_table_get(s : MathspecialchebyshevTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_special_chebyshev_table_set(s : MathspecialchebyshevTable, i : Int, v : Double) -> MathspecialchebyshevTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_special_chebyshev_table_sum(s : MathspecialchebyshevTable) -> Double { @_common.sum(s.data) }

pub fn math_special_chebyshev_table_mean(s : MathspecialchebyshevTable) -> Double { @_common.mean(s.data) }

pub fn math_special_chebyshev_table_scale(s : MathspecialchebyshevTable, f : Double) -> MathspecialchebyshevTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_special_chebyshev_table_add(a : MathspecialchebyshevTable, b : MathspecialchebyshevTable) -> MathspecialchebyshevTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_special_chebyshev_table_copy(s : MathspecialchebyshevTable) -> MathspecialchebyshevTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_special_chebyshev_table_fill(s : MathspecialchebyshevTable, v : Double) -> MathspecialchebyshevTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_special_chebyshev_table_min(s : MathspecialchebyshevTable) -> Double { @_common.min(s.data) }

pub fn math_special_chebyshev_table_max(s : MathspecialchebyshevTable) -> Double { @_common.max(s.data) }

pub fn math_special_chebyshev_table_to_string(s : MathspecialchebyshevTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathspecialchebyshevGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_special_chebyshev_graphn_make(size : Int) -> MathspecialchebyshevGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_special_chebyshev_graphn_len(s : MathspecialchebyshevGraphN) -> Int { s.size }

pub fn math_special_chebyshev_graphn_get(s : MathspecialchebyshevGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_special_chebyshev_graphn_set(s : MathspecialchebyshevGraphN, i : Int, v : Double) -> MathspecialchebyshevGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_special_chebyshev_graphn_sum(s : MathspecialchebyshevGraphN) -> Double { @_common.sum(s.data) }

pub fn math_special_chebyshev_graphn_mean(s : MathspecialchebyshevGraphN) -> Double { @_common.mean(s.data) }

pub fn math_special_chebyshev_graphn_scale(s : MathspecialchebyshevGraphN, f : Double) -> MathspecialchebyshevGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_special_chebyshev_graphn_add(a : MathspecialchebyshevGraphN, b : MathspecialchebyshevGraphN) -> MathspecialchebyshevGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_special_chebyshev_graphn_copy(s : MathspecialchebyshevGraphN) -> MathspecialchebyshevGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_special_chebyshev_graphn_fill(s : MathspecialchebyshevGraphN, v : Double) -> MathspecialchebyshevGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_special_chebyshev_graphn_min(s : MathspecialchebyshevGraphN) -> Double { @_common.min(s.data) }

pub fn math_special_chebyshev_graphn_max(s : MathspecialchebyshevGraphN) -> Double { @_common.max(s.data) }

pub fn math_special_chebyshev_graphn_to_string(s : MathspecialchebyshevGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathspecialchebyshevNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_special_chebyshev_node_make(size : Int) -> MathspecialchebyshevNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_special_chebyshev_node_len(s : MathspecialchebyshevNode) -> Int { s.size }

pub fn math_special_chebyshev_node_get(s : MathspecialchebyshevNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_special_chebyshev_node_set(s : MathspecialchebyshevNode, i : Int, v : Double) -> MathspecialchebyshevNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_special_chebyshev_node_sum(s : MathspecialchebyshevNode) -> Double { @_common.sum(s.data) }

pub fn math_special_chebyshev_node_mean(s : MathspecialchebyshevNode) -> Double { @_common.mean(s.data) }

pub fn math_special_chebyshev_node_scale(s : MathspecialchebyshevNode, f : Double) -> MathspecialchebyshevNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_special_chebyshev_node_add(a : MathspecialchebyshevNode, b : MathspecialchebyshevNode) -> MathspecialchebyshevNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_special_chebyshev_node_copy(s : MathspecialchebyshevNode) -> MathspecialchebyshevNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_special_chebyshev_node_fill(s : MathspecialchebyshevNode, v : Double) -> MathspecialchebyshevNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_special_chebyshev_node_min(s : MathspecialchebyshevNode) -> Double { @_common.min(s.data) }

pub fn math_special_chebyshev_node_max(s : MathspecialchebyshevNode) -> Double { @_common.max(s.data) }

pub fn math_special_chebyshev_node_to_string(s : MathspecialchebyshevNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathspecialchebyshevEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_special_chebyshev_edge_make(size : Int) -> MathspecialchebyshevEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_special_chebyshev_edge_len(s : MathspecialchebyshevEdge) -> Int { s.size }

pub fn math_special_chebyshev_edge_get(s : MathspecialchebyshevEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_special_chebyshev_edge_set(s : MathspecialchebyshevEdge, i : Int, v : Double) -> MathspecialchebyshevEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_special_chebyshev_edge_sum(s : MathspecialchebyshevEdge) -> Double { @_common.sum(s.data) }

pub fn math_special_chebyshev_edge_mean(s : MathspecialchebyshevEdge) -> Double { @_common.mean(s.data) }

pub fn math_special_chebyshev_edge_scale(s : MathspecialchebyshevEdge, f : Double) -> MathspecialchebyshevEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_special_chebyshev_edge_add(a : MathspecialchebyshevEdge, b : MathspecialchebyshevEdge) -> MathspecialchebyshevEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_special_chebyshev_edge_copy(s : MathspecialchebyshevEdge) -> MathspecialchebyshevEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_special_chebyshev_edge_fill(s : MathspecialchebyshevEdge, v : Double) -> MathspecialchebyshevEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_special_chebyshev_edge_min(s : MathspecialchebyshevEdge) -> Double { @_common.min(s.data) }

pub fn math_special_chebyshev_edge_max(s : MathspecialchebyshevEdge) -> Double { @_common.max(s.data) }

pub fn math_special_chebyshev_edge_to_string(s : MathspecialchebyshevEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathspecialchebyshevPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_special_chebyshev_path_make(size : Int) -> MathspecialchebyshevPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_special_chebyshev_path_len(s : MathspecialchebyshevPath) -> Int { s.size }

pub fn math_special_chebyshev_path_get(s : MathspecialchebyshevPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_special_chebyshev_path_set(s : MathspecialchebyshevPath, i : Int, v : Double) -> MathspecialchebyshevPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_special_chebyshev_path_sum(s : MathspecialchebyshevPath) -> Double { @_common.sum(s.data) }

pub fn math_special_chebyshev_path_mean(s : MathspecialchebyshevPath) -> Double { @_common.mean(s.data) }

pub fn math_special_chebyshev_path_scale(s : MathspecialchebyshevPath, f : Double) -> MathspecialchebyshevPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_special_chebyshev_path_add(a : MathspecialchebyshevPath, b : MathspecialchebyshevPath) -> MathspecialchebyshevPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_special_chebyshev_path_copy(s : MathspecialchebyshevPath) -> MathspecialchebyshevPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_special_chebyshev_path_fill(s : MathspecialchebyshevPath, v : Double) -> MathspecialchebyshevPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_special_chebyshev_path_min(s : MathspecialchebyshevPath) -> Double { @_common.min(s.data) }

pub fn math_special_chebyshev_path_max(s : MathspecialchebyshevPath) -> Double { @_common.max(s.data) }

pub fn math_special_chebyshev_path_to_string(s : MathspecialchebyshevPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathspecialchebyshevCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_special_chebyshev_cluster_make(size : Int) -> MathspecialchebyshevCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_special_chebyshev_cluster_len(s : MathspecialchebyshevCluster) -> Int { s.size }

pub fn math_special_chebyshev_cluster_get(s : MathspecialchebyshevCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_special_chebyshev_cluster_set(s : MathspecialchebyshevCluster, i : Int, v : Double) -> MathspecialchebyshevCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_special_chebyshev_cluster_sum(s : MathspecialchebyshevCluster) -> Double { @_common.sum(s.data) }

pub fn math_special_chebyshev_cluster_mean(s : MathspecialchebyshevCluster) -> Double { @_common.mean(s.data) }

pub fn math_special_chebyshev_cluster_scale(s : MathspecialchebyshevCluster, f : Double) -> MathspecialchebyshevCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_special_chebyshev_cluster_add(a : MathspecialchebyshevCluster, b : MathspecialchebyshevCluster) -> MathspecialchebyshevCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_special_chebyshev_cluster_copy(s : MathspecialchebyshevCluster) -> MathspecialchebyshevCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_special_chebyshev_cluster_fill(s : MathspecialchebyshevCluster, v : Double) -> MathspecialchebyshevCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_special_chebyshev_cluster_min(s : MathspecialchebyshevCluster) -> Double { @_common.min(s.data) }

pub fn math_special_chebyshev_cluster_max(s : MathspecialchebyshevCluster) -> Double { @_common.max(s.data) }

pub fn math_special_chebyshev_cluster_to_string(s : MathspecialchebyshevCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathspecialchebyshevModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_special_chebyshev_model_make(size : Int) -> MathspecialchebyshevModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_special_chebyshev_model_len(s : MathspecialchebyshevModel) -> Int { s.size }

pub fn math_special_chebyshev_model_get(s : MathspecialchebyshevModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_special_chebyshev_model_set(s : MathspecialchebyshevModel, i : Int, v : Double) -> MathspecialchebyshevModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_special_chebyshev_model_sum(s : MathspecialchebyshevModel) -> Double { @_common.sum(s.data) }

pub fn math_special_chebyshev_model_mean(s : MathspecialchebyshevModel) -> Double { @_common.mean(s.data) }

pub fn math_special_chebyshev_model_scale(s : MathspecialchebyshevModel, f : Double) -> MathspecialchebyshevModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_special_chebyshev_model_add(a : MathspecialchebyshevModel, b : MathspecialchebyshevModel) -> MathspecialchebyshevModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_special_chebyshev_model_copy(s : MathspecialchebyshevModel) -> MathspecialchebyshevModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_special_chebyshev_model_fill(s : MathspecialchebyshevModel, v : Double) -> MathspecialchebyshevModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_special_chebyshev_model_min(s : MathspecialchebyshevModel) -> Double { @_common.min(s.data) }

pub fn math_special_chebyshev_model_max(s : MathspecialchebyshevModel) -> Double { @_common.max(s.data) }

pub fn math_special_chebyshev_model_to_string(s : MathspecialchebyshevModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathspecialchebyshevLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_special_chebyshev_layer_make(size : Int) -> MathspecialchebyshevLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_special_chebyshev_layer_len(s : MathspecialchebyshevLayer) -> Int { s.size }

pub fn math_special_chebyshev_layer_get(s : MathspecialchebyshevLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_special_chebyshev_layer_set(s : MathspecialchebyshevLayer, i : Int, v : Double) -> MathspecialchebyshevLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_special_chebyshev_layer_sum(s : MathspecialchebyshevLayer) -> Double { @_common.sum(s.data) }

pub fn math_special_chebyshev_layer_mean(s : MathspecialchebyshevLayer) -> Double { @_common.mean(s.data) }

pub fn math_special_chebyshev_layer_scale(s : MathspecialchebyshevLayer, f : Double) -> MathspecialchebyshevLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_special_chebyshev_layer_add(a : MathspecialchebyshevLayer, b : MathspecialchebyshevLayer) -> MathspecialchebyshevLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_special_chebyshev_layer_copy(s : MathspecialchebyshevLayer) -> MathspecialchebyshevLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_special_chebyshev_layer_fill(s : MathspecialchebyshevLayer, v : Double) -> MathspecialchebyshevLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_special_chebyshev_layer_min(s : MathspecialchebyshevLayer) -> Double { @_common.min(s.data) }

pub fn math_special_chebyshev_layer_max(s : MathspecialchebyshevLayer) -> Double { @_common.max(s.data) }

pub fn math_special_chebyshev_layer_to_string(s : MathspecialchebyshevLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathspecialchebyshevBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_special_chebyshev_buffer_make(size : Int) -> MathspecialchebyshevBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_special_chebyshev_buffer_len(s : MathspecialchebyshevBuffer) -> Int { s.size }

pub fn math_special_chebyshev_buffer_get(s : MathspecialchebyshevBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_special_chebyshev_buffer_set(s : MathspecialchebyshevBuffer, i : Int, v : Double) -> MathspecialchebyshevBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_special_chebyshev_buffer_sum(s : MathspecialchebyshevBuffer) -> Double { @_common.sum(s.data) }

pub fn math_special_chebyshev_buffer_mean(s : MathspecialchebyshevBuffer) -> Double { @_common.mean(s.data) }

pub fn math_special_chebyshev_buffer_scale(s : MathspecialchebyshevBuffer, f : Double) -> MathspecialchebyshevBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_special_chebyshev_buffer_add(a : MathspecialchebyshevBuffer, b : MathspecialchebyshevBuffer) -> MathspecialchebyshevBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_special_chebyshev_buffer_copy(s : MathspecialchebyshevBuffer) -> MathspecialchebyshevBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_special_chebyshev_buffer_fill(s : MathspecialchebyshevBuffer, v : Double) -> MathspecialchebyshevBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_special_chebyshev_buffer_min(s : MathspecialchebyshevBuffer) -> Double { @_common.min(s.data) }

pub fn math_special_chebyshev_buffer_max(s : MathspecialchebyshevBuffer) -> Double { @_common.max(s.data) }

pub fn math_special_chebyshev_buffer_to_string(s : MathspecialchebyshevBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathspecialchebyshevCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_special_chebyshev_cursor_make(size : Int) -> MathspecialchebyshevCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_special_chebyshev_cursor_len(s : MathspecialchebyshevCursor) -> Int { s.size }

pub fn math_special_chebyshev_cursor_get(s : MathspecialchebyshevCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_special_chebyshev_cursor_set(s : MathspecialchebyshevCursor, i : Int, v : Double) -> MathspecialchebyshevCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_special_chebyshev_cursor_sum(s : MathspecialchebyshevCursor) -> Double { @_common.sum(s.data) }

pub fn math_special_chebyshev_cursor_mean(s : MathspecialchebyshevCursor) -> Double { @_common.mean(s.data) }

pub fn math_special_chebyshev_cursor_scale(s : MathspecialchebyshevCursor, f : Double) -> MathspecialchebyshevCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_special_chebyshev_cursor_add(a : MathspecialchebyshevCursor, b : MathspecialchebyshevCursor) -> MathspecialchebyshevCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_special_chebyshev_cursor_copy(s : MathspecialchebyshevCursor) -> MathspecialchebyshevCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_special_chebyshev_cursor_fill(s : MathspecialchebyshevCursor, v : Double) -> MathspecialchebyshevCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_special_chebyshev_cursor_min(s : MathspecialchebyshevCursor) -> Double { @_common.min(s.data) }

pub fn math_special_chebyshev_cursor_max(s : MathspecialchebyshevCursor) -> Double { @_common.max(s.data) }

pub fn math_special_chebyshev_cursor_to_string(s : MathspecialchebyshevCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathspecialchebyshevView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_special_chebyshev_view_make(size : Int) -> MathspecialchebyshevView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_special_chebyshev_view_len(s : MathspecialchebyshevView) -> Int { s.size }

pub fn math_special_chebyshev_view_get(s : MathspecialchebyshevView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_special_chebyshev_view_set(s : MathspecialchebyshevView, i : Int, v : Double) -> MathspecialchebyshevView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_special_chebyshev_view_sum(s : MathspecialchebyshevView) -> Double { @_common.sum(s.data) }

pub fn math_special_chebyshev_view_mean(s : MathspecialchebyshevView) -> Double { @_common.mean(s.data) }

pub fn math_special_chebyshev_view_scale(s : MathspecialchebyshevView, f : Double) -> MathspecialchebyshevView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_special_chebyshev_view_add(a : MathspecialchebyshevView, b : MathspecialchebyshevView) -> MathspecialchebyshevView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_special_chebyshev_view_copy(s : MathspecialchebyshevView) -> MathspecialchebyshevView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_special_chebyshev_view_fill(s : MathspecialchebyshevView, v : Double) -> MathspecialchebyshevView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_special_chebyshev_view_min(s : MathspecialchebyshevView) -> Double { @_common.min(s.data) }

pub fn math_special_chebyshev_view_max(s : MathspecialchebyshevView) -> Double { @_common.max(s.data) }

pub fn math_special_chebyshev_view_to_string(s : MathspecialchebyshevView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathspecialchebyshevRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_special_chebyshev_range_make(size : Int) -> MathspecialchebyshevRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_special_chebyshev_range_len(s : MathspecialchebyshevRange) -> Int { s.size }

pub fn math_special_chebyshev_range_get(s : MathspecialchebyshevRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_special_chebyshev_range_set(s : MathspecialchebyshevRange, i : Int, v : Double) -> MathspecialchebyshevRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_special_chebyshev_range_sum(s : MathspecialchebyshevRange) -> Double { @_common.sum(s.data) }

pub fn math_special_chebyshev_range_mean(s : MathspecialchebyshevRange) -> Double { @_common.mean(s.data) }

pub fn math_special_chebyshev_range_scale(s : MathspecialchebyshevRange, f : Double) -> MathspecialchebyshevRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_special_chebyshev_range_add(a : MathspecialchebyshevRange, b : MathspecialchebyshevRange) -> MathspecialchebyshevRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_special_chebyshev_range_copy(s : MathspecialchebyshevRange) -> MathspecialchebyshevRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_special_chebyshev_range_fill(s : MathspecialchebyshevRange, v : Double) -> MathspecialchebyshevRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_special_chebyshev_range_min(s : MathspecialchebyshevRange) -> Double { @_common.min(s.data) }

pub fn math_special_chebyshev_range_max(s : MathspecialchebyshevRange) -> Double { @_common.max(s.data) }

pub fn math_special_chebyshev_range_to_string(s : MathspecialchebyshevRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathspecialchebyshevSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_special_chebyshev_slice_make(size : Int) -> MathspecialchebyshevSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_special_chebyshev_slice_len(s : MathspecialchebyshevSlice) -> Int { s.size }

pub fn math_special_chebyshev_slice_get(s : MathspecialchebyshevSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_special_chebyshev_slice_set(s : MathspecialchebyshevSlice, i : Int, v : Double) -> MathspecialchebyshevSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_special_chebyshev_slice_sum(s : MathspecialchebyshevSlice) -> Double { @_common.sum(s.data) }

pub fn math_special_chebyshev_slice_mean(s : MathspecialchebyshevSlice) -> Double { @_common.mean(s.data) }

pub fn math_special_chebyshev_slice_scale(s : MathspecialchebyshevSlice, f : Double) -> MathspecialchebyshevSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_special_chebyshev_slice_add(a : MathspecialchebyshevSlice, b : MathspecialchebyshevSlice) -> MathspecialchebyshevSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_special_chebyshev_slice_copy(s : MathspecialchebyshevSlice) -> MathspecialchebyshevSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_special_chebyshev_slice_fill(s : MathspecialchebyshevSlice, v : Double) -> MathspecialchebyshevSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_special_chebyshev_slice_min(s : MathspecialchebyshevSlice) -> Double { @_common.min(s.data) }

pub fn math_special_chebyshev_slice_max(s : MathspecialchebyshevSlice) -> Double { @_common.max(s.data) }

pub fn math_special_chebyshev_slice_to_string(s : MathspecialchebyshevSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

