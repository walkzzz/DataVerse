///===
/// extcore/math_special_gamma

pub(all) struct MathspecialgammaPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn math_special_gamma_make_point(x : Double, y : Double) -> MathspecialgammaPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn math_special_gamma_make_point3(x : Double, y : Double, z : Double) -> MathspecialgammaPoint {
  { x, y, z, label: 0 }
}

pub fn MathspecialgammaPoint::x(self : MathspecialgammaPoint) -> Double { self.x }

pub fn MathspecialgammaPoint::y(self : MathspecialgammaPoint) -> Double { self.y }

pub fn MathspecialgammaPoint::z(self : MathspecialgammaPoint) -> Double { self.z }

pub fn MathspecialgammaPoint::label(self : MathspecialgammaPoint) -> Int { self.label }

pub fn MathspecialgammaPoint::dist(self : MathspecialgammaPoint, other : MathspecialgammaPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn MathspecialgammaPoint::add(self : MathspecialgammaPoint, other : MathspecialgammaPoint) -> MathspecialgammaPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn MathspecialgammaPoint::sub(self : MathspecialgammaPoint, other : MathspecialgammaPoint) -> MathspecialgammaPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn MathspecialgammaPoint::scale(self : MathspecialgammaPoint, s : Double) -> MathspecialgammaPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn MathspecialgammaPoint::dot(self : MathspecialgammaPoint, other : MathspecialgammaPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn MathspecialgammaPoint::cross(self : MathspecialgammaPoint, other : MathspecialgammaPoint) -> MathspecialgammaPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn MathspecialgammaPoint::norm(self : MathspecialgammaPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn MathspecialgammaPoint::normalize(self : MathspecialgammaPoint) -> MathspecialgammaPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn MathspecialgammaPoint::negate(self : MathspecialgammaPoint) -> MathspecialgammaPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn MathspecialgammaPoint::mid(self : MathspecialgammaPoint, other : MathspecialgammaPoint) -> MathspecialgammaPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn MathspecialgammaPoint::lerp(self : MathspecialgammaPoint, other : MathspecialgammaPoint, t : Double) -> MathspecialgammaPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn MathspecialgammaPoint::to_string(self : MathspecialgammaPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct MathspecialgammaSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn math_special_gamma_make_series(vals : Array[Double], name : String) -> MathspecialgammaSeries {
  { vals, name, meta: 0 }
}

pub fn MathspecialgammaSeries::len(self : MathspecialgammaSeries) -> Int { self.vals.length() }

pub fn MathspecialgammaSeries::sum(self : MathspecialgammaSeries) -> Double { @_common.sum(self.vals) }

pub fn MathspecialgammaSeries::mean(self : MathspecialgammaSeries) -> Double { @_common.mean(self.vals) }

pub fn MathspecialgammaSeries::min(self : MathspecialgammaSeries) -> Double { @_common.min(self.vals) }

pub fn MathspecialgammaSeries::max(self : MathspecialgammaSeries) -> Double { @_common.max(self.vals) }

pub fn MathspecialgammaSeries::range(self : MathspecialgammaSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn MathspecialgammaSeries::variance(self : MathspecialgammaSeries) -> Double { @_common.variance(self.vals) }

pub fn MathspecialgammaSeries::std(self : MathspecialgammaSeries) -> Double { @_common.std(self.vals) }

pub fn MathspecialgammaSeries::median(self : MathspecialgammaSeries) -> Double { @_common.median(self.vals) }

pub fn MathspecialgammaSeries::scale(self : MathspecialgammaSeries, f : Double) -> MathspecialgammaSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn MathspecialgammaSeries::add(self : MathspecialgammaSeries, other : MathspecialgammaSeries) -> MathspecialgammaSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn MathspecialgammaSeries::sub(self : MathspecialgammaSeries, other : MathspecialgammaSeries) -> MathspecialgammaSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn MathspecialgammaSeries::normalize(self : MathspecialgammaSeries) -> MathspecialgammaSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn MathspecialgammaSeries::cumsum(self : MathspecialgammaSeries) -> MathspecialgammaSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn MathspecialgammaSeries::to_string(self : MathspecialgammaSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct MathspecialgammaMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn math_special_gamma_make_matrix(rows : Int, cols : Int, val : Double) -> MathspecialgammaMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn math_special_gamma_matrix_identity(n : Int) -> MathspecialgammaMatrix {
  let m = math_special_gamma_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn MathspecialgammaMatrix::get(self : MathspecialgammaMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn MathspecialgammaMatrix::transpose(self : MathspecialgammaMatrix) -> MathspecialgammaMatrix {
  let result = math_special_gamma_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn MathspecialgammaMatrix::add(self : MathspecialgammaMatrix, other : MathspecialgammaMatrix) -> MathspecialgammaMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = math_special_gamma_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn MathspecialgammaMatrix::scale(self : MathspecialgammaMatrix, s : Double) -> MathspecialgammaMatrix {
  let result = math_special_gamma_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn MathspecialgammaMatrix::multiply(self : MathspecialgammaMatrix, other : MathspecialgammaMatrix) -> MathspecialgammaMatrix {
  if self.cols != other.rows { return math_special_gamma_make_matrix(self.rows, other.cols, 0.0) }
  let result = math_special_gamma_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn MathspecialgammaMatrix::trace(self : MathspecialgammaMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn MathspecialgammaMatrix::det(self : MathspecialgammaMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn MathspecialgammaMatrix::norm(self : MathspecialgammaMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn MathspecialgammaMatrix::to_string(self : MathspecialgammaMatrix) -> String {
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

pub(all) struct MathspecialgammaVector {
  comps : Array[Double]
  dim : Int
}

pub fn math_special_gamma_make_vector(comps : Array[Double]) -> MathspecialgammaVector {
  { comps, dim: comps.length() }
}

pub fn math_special_gamma_vector_zero(dim : Int) -> MathspecialgammaVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn MathspecialgammaVector::add(self : MathspecialgammaVector, other : MathspecialgammaVector) -> MathspecialgammaVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn MathspecialgammaVector::sub(self : MathspecialgammaVector, other : MathspecialgammaVector) -> MathspecialgammaVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn MathspecialgammaVector::scale(self : MathspecialgammaVector, s : Double) -> MathspecialgammaVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn MathspecialgammaVector::dot(self : MathspecialgammaVector, other : MathspecialgammaVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn MathspecialgammaVector::norm(self : MathspecialgammaVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn MathspecialgammaVector::normalize(self : MathspecialgammaVector) -> MathspecialgammaVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn MathspecialgammaVector::dist(self : MathspecialgammaVector, other : MathspecialgammaVector) -> Double {
  self.sub(other).norm()
}

pub fn MathspecialgammaVector::to_string(self : MathspecialgammaVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn math_special_gamma_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn math_special_gamma_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn math_special_gamma_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn math_special_gamma_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn math_special_gamma_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn math_special_gamma_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn math_special_gamma_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn math_special_gamma_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn math_special_gamma_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn math_special_gamma_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn math_special_gamma_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn math_special_gamma_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn math_special_gamma_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn math_special_gamma_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn math_special_gamma_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn math_special_gamma_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn math_special_gamma_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn math_special_gamma_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn math_special_gamma_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn math_special_gamma_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn math_special_gamma_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn math_special_gamma_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn math_special_gamma_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn math_special_gamma_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn math_special_gamma_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn math_special_gamma_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn math_special_gamma_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn math_special_gamma_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn math_special_gamma_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct MathspecialgammaFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_special_gamma_frame_make(size : Int) -> MathspecialgammaFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_special_gamma_frame_len(s : MathspecialgammaFrame) -> Int { s.size }

pub fn math_special_gamma_frame_get(s : MathspecialgammaFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_special_gamma_frame_set(s : MathspecialgammaFrame, i : Int, v : Double) -> MathspecialgammaFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_special_gamma_frame_sum(s : MathspecialgammaFrame) -> Double { @_common.sum(s.data) }

pub fn math_special_gamma_frame_mean(s : MathspecialgammaFrame) -> Double { @_common.mean(s.data) }

pub fn math_special_gamma_frame_scale(s : MathspecialgammaFrame, f : Double) -> MathspecialgammaFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_special_gamma_frame_add(a : MathspecialgammaFrame, b : MathspecialgammaFrame) -> MathspecialgammaFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_special_gamma_frame_copy(s : MathspecialgammaFrame) -> MathspecialgammaFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_special_gamma_frame_fill(s : MathspecialgammaFrame, v : Double) -> MathspecialgammaFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_special_gamma_frame_min(s : MathspecialgammaFrame) -> Double { @_common.min(s.data) }

pub fn math_special_gamma_frame_max(s : MathspecialgammaFrame) -> Double { @_common.max(s.data) }

pub fn math_special_gamma_frame_to_string(s : MathspecialgammaFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathspecialgammaTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_special_gamma_table_make(size : Int) -> MathspecialgammaTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_special_gamma_table_len(s : MathspecialgammaTable) -> Int { s.size }

pub fn math_special_gamma_table_get(s : MathspecialgammaTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_special_gamma_table_set(s : MathspecialgammaTable, i : Int, v : Double) -> MathspecialgammaTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_special_gamma_table_sum(s : MathspecialgammaTable) -> Double { @_common.sum(s.data) }

pub fn math_special_gamma_table_mean(s : MathspecialgammaTable) -> Double { @_common.mean(s.data) }

pub fn math_special_gamma_table_scale(s : MathspecialgammaTable, f : Double) -> MathspecialgammaTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_special_gamma_table_add(a : MathspecialgammaTable, b : MathspecialgammaTable) -> MathspecialgammaTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_special_gamma_table_copy(s : MathspecialgammaTable) -> MathspecialgammaTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_special_gamma_table_fill(s : MathspecialgammaTable, v : Double) -> MathspecialgammaTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_special_gamma_table_min(s : MathspecialgammaTable) -> Double { @_common.min(s.data) }

pub fn math_special_gamma_table_max(s : MathspecialgammaTable) -> Double { @_common.max(s.data) }

pub fn math_special_gamma_table_to_string(s : MathspecialgammaTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathspecialgammaGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_special_gamma_graphn_make(size : Int) -> MathspecialgammaGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_special_gamma_graphn_len(s : MathspecialgammaGraphN) -> Int { s.size }

pub fn math_special_gamma_graphn_get(s : MathspecialgammaGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_special_gamma_graphn_set(s : MathspecialgammaGraphN, i : Int, v : Double) -> MathspecialgammaGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_special_gamma_graphn_sum(s : MathspecialgammaGraphN) -> Double { @_common.sum(s.data) }

pub fn math_special_gamma_graphn_mean(s : MathspecialgammaGraphN) -> Double { @_common.mean(s.data) }

pub fn math_special_gamma_graphn_scale(s : MathspecialgammaGraphN, f : Double) -> MathspecialgammaGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_special_gamma_graphn_add(a : MathspecialgammaGraphN, b : MathspecialgammaGraphN) -> MathspecialgammaGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_special_gamma_graphn_copy(s : MathspecialgammaGraphN) -> MathspecialgammaGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_special_gamma_graphn_fill(s : MathspecialgammaGraphN, v : Double) -> MathspecialgammaGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_special_gamma_graphn_min(s : MathspecialgammaGraphN) -> Double { @_common.min(s.data) }

pub fn math_special_gamma_graphn_max(s : MathspecialgammaGraphN) -> Double { @_common.max(s.data) }

pub fn math_special_gamma_graphn_to_string(s : MathspecialgammaGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathspecialgammaNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_special_gamma_node_make(size : Int) -> MathspecialgammaNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_special_gamma_node_len(s : MathspecialgammaNode) -> Int { s.size }

pub fn math_special_gamma_node_get(s : MathspecialgammaNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_special_gamma_node_set(s : MathspecialgammaNode, i : Int, v : Double) -> MathspecialgammaNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_special_gamma_node_sum(s : MathspecialgammaNode) -> Double { @_common.sum(s.data) }

pub fn math_special_gamma_node_mean(s : MathspecialgammaNode) -> Double { @_common.mean(s.data) }

pub fn math_special_gamma_node_scale(s : MathspecialgammaNode, f : Double) -> MathspecialgammaNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_special_gamma_node_add(a : MathspecialgammaNode, b : MathspecialgammaNode) -> MathspecialgammaNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_special_gamma_node_copy(s : MathspecialgammaNode) -> MathspecialgammaNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_special_gamma_node_fill(s : MathspecialgammaNode, v : Double) -> MathspecialgammaNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_special_gamma_node_min(s : MathspecialgammaNode) -> Double { @_common.min(s.data) }

pub fn math_special_gamma_node_max(s : MathspecialgammaNode) -> Double { @_common.max(s.data) }

pub fn math_special_gamma_node_to_string(s : MathspecialgammaNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathspecialgammaEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_special_gamma_edge_make(size : Int) -> MathspecialgammaEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_special_gamma_edge_len(s : MathspecialgammaEdge) -> Int { s.size }

pub fn math_special_gamma_edge_get(s : MathspecialgammaEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_special_gamma_edge_set(s : MathspecialgammaEdge, i : Int, v : Double) -> MathspecialgammaEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_special_gamma_edge_sum(s : MathspecialgammaEdge) -> Double { @_common.sum(s.data) }

pub fn math_special_gamma_edge_mean(s : MathspecialgammaEdge) -> Double { @_common.mean(s.data) }

pub fn math_special_gamma_edge_scale(s : MathspecialgammaEdge, f : Double) -> MathspecialgammaEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_special_gamma_edge_add(a : MathspecialgammaEdge, b : MathspecialgammaEdge) -> MathspecialgammaEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_special_gamma_edge_copy(s : MathspecialgammaEdge) -> MathspecialgammaEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_special_gamma_edge_fill(s : MathspecialgammaEdge, v : Double) -> MathspecialgammaEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_special_gamma_edge_min(s : MathspecialgammaEdge) -> Double { @_common.min(s.data) }

pub fn math_special_gamma_edge_max(s : MathspecialgammaEdge) -> Double { @_common.max(s.data) }

pub fn math_special_gamma_edge_to_string(s : MathspecialgammaEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathspecialgammaPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_special_gamma_path_make(size : Int) -> MathspecialgammaPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_special_gamma_path_len(s : MathspecialgammaPath) -> Int { s.size }

pub fn math_special_gamma_path_get(s : MathspecialgammaPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_special_gamma_path_set(s : MathspecialgammaPath, i : Int, v : Double) -> MathspecialgammaPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_special_gamma_path_sum(s : MathspecialgammaPath) -> Double { @_common.sum(s.data) }

pub fn math_special_gamma_path_mean(s : MathspecialgammaPath) -> Double { @_common.mean(s.data) }

pub fn math_special_gamma_path_scale(s : MathspecialgammaPath, f : Double) -> MathspecialgammaPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_special_gamma_path_add(a : MathspecialgammaPath, b : MathspecialgammaPath) -> MathspecialgammaPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_special_gamma_path_copy(s : MathspecialgammaPath) -> MathspecialgammaPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_special_gamma_path_fill(s : MathspecialgammaPath, v : Double) -> MathspecialgammaPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_special_gamma_path_min(s : MathspecialgammaPath) -> Double { @_common.min(s.data) }

pub fn math_special_gamma_path_max(s : MathspecialgammaPath) -> Double { @_common.max(s.data) }

pub fn math_special_gamma_path_to_string(s : MathspecialgammaPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathspecialgammaCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_special_gamma_cluster_make(size : Int) -> MathspecialgammaCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_special_gamma_cluster_len(s : MathspecialgammaCluster) -> Int { s.size }

pub fn math_special_gamma_cluster_get(s : MathspecialgammaCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_special_gamma_cluster_set(s : MathspecialgammaCluster, i : Int, v : Double) -> MathspecialgammaCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_special_gamma_cluster_sum(s : MathspecialgammaCluster) -> Double { @_common.sum(s.data) }

pub fn math_special_gamma_cluster_mean(s : MathspecialgammaCluster) -> Double { @_common.mean(s.data) }

pub fn math_special_gamma_cluster_scale(s : MathspecialgammaCluster, f : Double) -> MathspecialgammaCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_special_gamma_cluster_add(a : MathspecialgammaCluster, b : MathspecialgammaCluster) -> MathspecialgammaCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_special_gamma_cluster_copy(s : MathspecialgammaCluster) -> MathspecialgammaCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_special_gamma_cluster_fill(s : MathspecialgammaCluster, v : Double) -> MathspecialgammaCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_special_gamma_cluster_min(s : MathspecialgammaCluster) -> Double { @_common.min(s.data) }

pub fn math_special_gamma_cluster_max(s : MathspecialgammaCluster) -> Double { @_common.max(s.data) }

pub fn math_special_gamma_cluster_to_string(s : MathspecialgammaCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathspecialgammaModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_special_gamma_model_make(size : Int) -> MathspecialgammaModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_special_gamma_model_len(s : MathspecialgammaModel) -> Int { s.size }

pub fn math_special_gamma_model_get(s : MathspecialgammaModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_special_gamma_model_set(s : MathspecialgammaModel, i : Int, v : Double) -> MathspecialgammaModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_special_gamma_model_sum(s : MathspecialgammaModel) -> Double { @_common.sum(s.data) }

pub fn math_special_gamma_model_mean(s : MathspecialgammaModel) -> Double { @_common.mean(s.data) }

pub fn math_special_gamma_model_scale(s : MathspecialgammaModel, f : Double) -> MathspecialgammaModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_special_gamma_model_add(a : MathspecialgammaModel, b : MathspecialgammaModel) -> MathspecialgammaModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_special_gamma_model_copy(s : MathspecialgammaModel) -> MathspecialgammaModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_special_gamma_model_fill(s : MathspecialgammaModel, v : Double) -> MathspecialgammaModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_special_gamma_model_min(s : MathspecialgammaModel) -> Double { @_common.min(s.data) }

pub fn math_special_gamma_model_max(s : MathspecialgammaModel) -> Double { @_common.max(s.data) }

pub fn math_special_gamma_model_to_string(s : MathspecialgammaModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathspecialgammaLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_special_gamma_layer_make(size : Int) -> MathspecialgammaLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_special_gamma_layer_len(s : MathspecialgammaLayer) -> Int { s.size }

pub fn math_special_gamma_layer_get(s : MathspecialgammaLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_special_gamma_layer_set(s : MathspecialgammaLayer, i : Int, v : Double) -> MathspecialgammaLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_special_gamma_layer_sum(s : MathspecialgammaLayer) -> Double { @_common.sum(s.data) }

pub fn math_special_gamma_layer_mean(s : MathspecialgammaLayer) -> Double { @_common.mean(s.data) }

pub fn math_special_gamma_layer_scale(s : MathspecialgammaLayer, f : Double) -> MathspecialgammaLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_special_gamma_layer_add(a : MathspecialgammaLayer, b : MathspecialgammaLayer) -> MathspecialgammaLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_special_gamma_layer_copy(s : MathspecialgammaLayer) -> MathspecialgammaLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_special_gamma_layer_fill(s : MathspecialgammaLayer, v : Double) -> MathspecialgammaLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_special_gamma_layer_min(s : MathspecialgammaLayer) -> Double { @_common.min(s.data) }

pub fn math_special_gamma_layer_max(s : MathspecialgammaLayer) -> Double { @_common.max(s.data) }

pub fn math_special_gamma_layer_to_string(s : MathspecialgammaLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathspecialgammaBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_special_gamma_buffer_make(size : Int) -> MathspecialgammaBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_special_gamma_buffer_len(s : MathspecialgammaBuffer) -> Int { s.size }

pub fn math_special_gamma_buffer_get(s : MathspecialgammaBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_special_gamma_buffer_set(s : MathspecialgammaBuffer, i : Int, v : Double) -> MathspecialgammaBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_special_gamma_buffer_sum(s : MathspecialgammaBuffer) -> Double { @_common.sum(s.data) }

pub fn math_special_gamma_buffer_mean(s : MathspecialgammaBuffer) -> Double { @_common.mean(s.data) }

pub fn math_special_gamma_buffer_scale(s : MathspecialgammaBuffer, f : Double) -> MathspecialgammaBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_special_gamma_buffer_add(a : MathspecialgammaBuffer, b : MathspecialgammaBuffer) -> MathspecialgammaBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_special_gamma_buffer_copy(s : MathspecialgammaBuffer) -> MathspecialgammaBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_special_gamma_buffer_fill(s : MathspecialgammaBuffer, v : Double) -> MathspecialgammaBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_special_gamma_buffer_min(s : MathspecialgammaBuffer) -> Double { @_common.min(s.data) }

pub fn math_special_gamma_buffer_max(s : MathspecialgammaBuffer) -> Double { @_common.max(s.data) }

pub fn math_special_gamma_buffer_to_string(s : MathspecialgammaBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathspecialgammaCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_special_gamma_cursor_make(size : Int) -> MathspecialgammaCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_special_gamma_cursor_len(s : MathspecialgammaCursor) -> Int { s.size }

pub fn math_special_gamma_cursor_get(s : MathspecialgammaCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_special_gamma_cursor_set(s : MathspecialgammaCursor, i : Int, v : Double) -> MathspecialgammaCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_special_gamma_cursor_sum(s : MathspecialgammaCursor) -> Double { @_common.sum(s.data) }

pub fn math_special_gamma_cursor_mean(s : MathspecialgammaCursor) -> Double { @_common.mean(s.data) }

pub fn math_special_gamma_cursor_scale(s : MathspecialgammaCursor, f : Double) -> MathspecialgammaCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_special_gamma_cursor_add(a : MathspecialgammaCursor, b : MathspecialgammaCursor) -> MathspecialgammaCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_special_gamma_cursor_copy(s : MathspecialgammaCursor) -> MathspecialgammaCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_special_gamma_cursor_fill(s : MathspecialgammaCursor, v : Double) -> MathspecialgammaCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_special_gamma_cursor_min(s : MathspecialgammaCursor) -> Double { @_common.min(s.data) }

pub fn math_special_gamma_cursor_max(s : MathspecialgammaCursor) -> Double { @_common.max(s.data) }

pub fn math_special_gamma_cursor_to_string(s : MathspecialgammaCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathspecialgammaView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_special_gamma_view_make(size : Int) -> MathspecialgammaView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_special_gamma_view_len(s : MathspecialgammaView) -> Int { s.size }

pub fn math_special_gamma_view_get(s : MathspecialgammaView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_special_gamma_view_set(s : MathspecialgammaView, i : Int, v : Double) -> MathspecialgammaView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_special_gamma_view_sum(s : MathspecialgammaView) -> Double { @_common.sum(s.data) }

pub fn math_special_gamma_view_mean(s : MathspecialgammaView) -> Double { @_common.mean(s.data) }

pub fn math_special_gamma_view_scale(s : MathspecialgammaView, f : Double) -> MathspecialgammaView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_special_gamma_view_add(a : MathspecialgammaView, b : MathspecialgammaView) -> MathspecialgammaView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_special_gamma_view_copy(s : MathspecialgammaView) -> MathspecialgammaView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_special_gamma_view_fill(s : MathspecialgammaView, v : Double) -> MathspecialgammaView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_special_gamma_view_min(s : MathspecialgammaView) -> Double { @_common.min(s.data) }

pub fn math_special_gamma_view_max(s : MathspecialgammaView) -> Double { @_common.max(s.data) }

pub fn math_special_gamma_view_to_string(s : MathspecialgammaView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathspecialgammaRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_special_gamma_range_make(size : Int) -> MathspecialgammaRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_special_gamma_range_len(s : MathspecialgammaRange) -> Int { s.size }

pub fn math_special_gamma_range_get(s : MathspecialgammaRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_special_gamma_range_set(s : MathspecialgammaRange, i : Int, v : Double) -> MathspecialgammaRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_special_gamma_range_sum(s : MathspecialgammaRange) -> Double { @_common.sum(s.data) }

pub fn math_special_gamma_range_mean(s : MathspecialgammaRange) -> Double { @_common.mean(s.data) }

pub fn math_special_gamma_range_scale(s : MathspecialgammaRange, f : Double) -> MathspecialgammaRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_special_gamma_range_add(a : MathspecialgammaRange, b : MathspecialgammaRange) -> MathspecialgammaRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_special_gamma_range_copy(s : MathspecialgammaRange) -> MathspecialgammaRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_special_gamma_range_fill(s : MathspecialgammaRange, v : Double) -> MathspecialgammaRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_special_gamma_range_min(s : MathspecialgammaRange) -> Double { @_common.min(s.data) }

pub fn math_special_gamma_range_max(s : MathspecialgammaRange) -> Double { @_common.max(s.data) }

pub fn math_special_gamma_range_to_string(s : MathspecialgammaRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathspecialgammaSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_special_gamma_slice_make(size : Int) -> MathspecialgammaSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_special_gamma_slice_len(s : MathspecialgammaSlice) -> Int { s.size }

pub fn math_special_gamma_slice_get(s : MathspecialgammaSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_special_gamma_slice_set(s : MathspecialgammaSlice, i : Int, v : Double) -> MathspecialgammaSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_special_gamma_slice_sum(s : MathspecialgammaSlice) -> Double { @_common.sum(s.data) }

pub fn math_special_gamma_slice_mean(s : MathspecialgammaSlice) -> Double { @_common.mean(s.data) }

pub fn math_special_gamma_slice_scale(s : MathspecialgammaSlice, f : Double) -> MathspecialgammaSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_special_gamma_slice_add(a : MathspecialgammaSlice, b : MathspecialgammaSlice) -> MathspecialgammaSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_special_gamma_slice_copy(s : MathspecialgammaSlice) -> MathspecialgammaSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_special_gamma_slice_fill(s : MathspecialgammaSlice, v : Double) -> MathspecialgammaSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_special_gamma_slice_min(s : MathspecialgammaSlice) -> Double { @_common.min(s.data) }

pub fn math_special_gamma_slice_max(s : MathspecialgammaSlice) -> Double { @_common.max(s.data) }

pub fn math_special_gamma_slice_to_string(s : MathspecialgammaSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

