///===
/// extcore/math_special_beta

pub(all) struct MathspecialbetaPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn math_special_beta_make_point(x : Double, y : Double) -> MathspecialbetaPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn math_special_beta_make_point3(x : Double, y : Double, z : Double) -> MathspecialbetaPoint {
  { x, y, z, label: 0 }
}

pub fn MathspecialbetaPoint::x(self : MathspecialbetaPoint) -> Double { self.x }

pub fn MathspecialbetaPoint::y(self : MathspecialbetaPoint) -> Double { self.y }

pub fn MathspecialbetaPoint::z(self : MathspecialbetaPoint) -> Double { self.z }

pub fn MathspecialbetaPoint::label(self : MathspecialbetaPoint) -> Int { self.label }

pub fn MathspecialbetaPoint::dist(self : MathspecialbetaPoint, other : MathspecialbetaPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn MathspecialbetaPoint::add(self : MathspecialbetaPoint, other : MathspecialbetaPoint) -> MathspecialbetaPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn MathspecialbetaPoint::sub(self : MathspecialbetaPoint, other : MathspecialbetaPoint) -> MathspecialbetaPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn MathspecialbetaPoint::scale(self : MathspecialbetaPoint, s : Double) -> MathspecialbetaPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn MathspecialbetaPoint::dot(self : MathspecialbetaPoint, other : MathspecialbetaPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn MathspecialbetaPoint::cross(self : MathspecialbetaPoint, other : MathspecialbetaPoint) -> MathspecialbetaPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn MathspecialbetaPoint::norm(self : MathspecialbetaPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn MathspecialbetaPoint::normalize(self : MathspecialbetaPoint) -> MathspecialbetaPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn MathspecialbetaPoint::negate(self : MathspecialbetaPoint) -> MathspecialbetaPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn MathspecialbetaPoint::mid(self : MathspecialbetaPoint, other : MathspecialbetaPoint) -> MathspecialbetaPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn MathspecialbetaPoint::lerp(self : MathspecialbetaPoint, other : MathspecialbetaPoint, t : Double) -> MathspecialbetaPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn MathspecialbetaPoint::to_string(self : MathspecialbetaPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct MathspecialbetaSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn math_special_beta_make_series(vals : Array[Double], name : String) -> MathspecialbetaSeries {
  { vals, name, meta: 0 }
}

pub fn MathspecialbetaSeries::len(self : MathspecialbetaSeries) -> Int { self.vals.length() }

pub fn MathspecialbetaSeries::sum(self : MathspecialbetaSeries) -> Double { @_common.sum(self.vals) }

pub fn MathspecialbetaSeries::mean(self : MathspecialbetaSeries) -> Double { @_common.mean(self.vals) }

pub fn MathspecialbetaSeries::min(self : MathspecialbetaSeries) -> Double { @_common.min(self.vals) }

pub fn MathspecialbetaSeries::max(self : MathspecialbetaSeries) -> Double { @_common.max(self.vals) }

pub fn MathspecialbetaSeries::range(self : MathspecialbetaSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn MathspecialbetaSeries::variance(self : MathspecialbetaSeries) -> Double { @_common.variance(self.vals) }

pub fn MathspecialbetaSeries::std(self : MathspecialbetaSeries) -> Double { @_common.std(self.vals) }

pub fn MathspecialbetaSeries::median(self : MathspecialbetaSeries) -> Double { @_common.median(self.vals) }

pub fn MathspecialbetaSeries::scale(self : MathspecialbetaSeries, f : Double) -> MathspecialbetaSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn MathspecialbetaSeries::add(self : MathspecialbetaSeries, other : MathspecialbetaSeries) -> MathspecialbetaSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn MathspecialbetaSeries::sub(self : MathspecialbetaSeries, other : MathspecialbetaSeries) -> MathspecialbetaSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn MathspecialbetaSeries::normalize(self : MathspecialbetaSeries) -> MathspecialbetaSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn MathspecialbetaSeries::cumsum(self : MathspecialbetaSeries) -> MathspecialbetaSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn MathspecialbetaSeries::to_string(self : MathspecialbetaSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct MathspecialbetaMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn math_special_beta_make_matrix(rows : Int, cols : Int, val : Double) -> MathspecialbetaMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn math_special_beta_matrix_identity(n : Int) -> MathspecialbetaMatrix {
  let m = math_special_beta_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn MathspecialbetaMatrix::get(self : MathspecialbetaMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn MathspecialbetaMatrix::transpose(self : MathspecialbetaMatrix) -> MathspecialbetaMatrix {
  let result = math_special_beta_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn MathspecialbetaMatrix::add(self : MathspecialbetaMatrix, other : MathspecialbetaMatrix) -> MathspecialbetaMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = math_special_beta_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn MathspecialbetaMatrix::scale(self : MathspecialbetaMatrix, s : Double) -> MathspecialbetaMatrix {
  let result = math_special_beta_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn MathspecialbetaMatrix::multiply(self : MathspecialbetaMatrix, other : MathspecialbetaMatrix) -> MathspecialbetaMatrix {
  if self.cols != other.rows { return math_special_beta_make_matrix(self.rows, other.cols, 0.0) }
  let result = math_special_beta_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn MathspecialbetaMatrix::trace(self : MathspecialbetaMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn MathspecialbetaMatrix::det(self : MathspecialbetaMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn MathspecialbetaMatrix::norm(self : MathspecialbetaMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn MathspecialbetaMatrix::to_string(self : MathspecialbetaMatrix) -> String {
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

pub(all) struct MathspecialbetaVector {
  comps : Array[Double]
  dim : Int
}

pub fn math_special_beta_make_vector(comps : Array[Double]) -> MathspecialbetaVector {
  { comps, dim: comps.length() }
}

pub fn math_special_beta_vector_zero(dim : Int) -> MathspecialbetaVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn MathspecialbetaVector::add(self : MathspecialbetaVector, other : MathspecialbetaVector) -> MathspecialbetaVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn MathspecialbetaVector::sub(self : MathspecialbetaVector, other : MathspecialbetaVector) -> MathspecialbetaVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn MathspecialbetaVector::scale(self : MathspecialbetaVector, s : Double) -> MathspecialbetaVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn MathspecialbetaVector::dot(self : MathspecialbetaVector, other : MathspecialbetaVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn MathspecialbetaVector::norm(self : MathspecialbetaVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn MathspecialbetaVector::normalize(self : MathspecialbetaVector) -> MathspecialbetaVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn MathspecialbetaVector::dist(self : MathspecialbetaVector, other : MathspecialbetaVector) -> Double {
  self.sub(other).norm()
}

pub fn MathspecialbetaVector::to_string(self : MathspecialbetaVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn math_special_beta_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn math_special_beta_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn math_special_beta_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn math_special_beta_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn math_special_beta_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn math_special_beta_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn math_special_beta_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn math_special_beta_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn math_special_beta_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn math_special_beta_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn math_special_beta_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn math_special_beta_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn math_special_beta_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn math_special_beta_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn math_special_beta_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn math_special_beta_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn math_special_beta_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn math_special_beta_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn math_special_beta_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn math_special_beta_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn math_special_beta_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn math_special_beta_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn math_special_beta_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn math_special_beta_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn math_special_beta_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn math_special_beta_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn math_special_beta_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn math_special_beta_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn math_special_beta_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct MathspecialbetaFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_special_beta_frame_make(size : Int) -> MathspecialbetaFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_special_beta_frame_len(s : MathspecialbetaFrame) -> Int { s.size }

pub fn math_special_beta_frame_get(s : MathspecialbetaFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_special_beta_frame_set(s : MathspecialbetaFrame, i : Int, v : Double) -> MathspecialbetaFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_special_beta_frame_sum(s : MathspecialbetaFrame) -> Double { @_common.sum(s.data) }

pub fn math_special_beta_frame_mean(s : MathspecialbetaFrame) -> Double { @_common.mean(s.data) }

pub fn math_special_beta_frame_scale(s : MathspecialbetaFrame, f : Double) -> MathspecialbetaFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_special_beta_frame_add(a : MathspecialbetaFrame, b : MathspecialbetaFrame) -> MathspecialbetaFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_special_beta_frame_copy(s : MathspecialbetaFrame) -> MathspecialbetaFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_special_beta_frame_fill(s : MathspecialbetaFrame, v : Double) -> MathspecialbetaFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_special_beta_frame_min(s : MathspecialbetaFrame) -> Double { @_common.min(s.data) }

pub fn math_special_beta_frame_max(s : MathspecialbetaFrame) -> Double { @_common.max(s.data) }

pub fn math_special_beta_frame_to_string(s : MathspecialbetaFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathspecialbetaTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_special_beta_table_make(size : Int) -> MathspecialbetaTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_special_beta_table_len(s : MathspecialbetaTable) -> Int { s.size }

pub fn math_special_beta_table_get(s : MathspecialbetaTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_special_beta_table_set(s : MathspecialbetaTable, i : Int, v : Double) -> MathspecialbetaTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_special_beta_table_sum(s : MathspecialbetaTable) -> Double { @_common.sum(s.data) }

pub fn math_special_beta_table_mean(s : MathspecialbetaTable) -> Double { @_common.mean(s.data) }

pub fn math_special_beta_table_scale(s : MathspecialbetaTable, f : Double) -> MathspecialbetaTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_special_beta_table_add(a : MathspecialbetaTable, b : MathspecialbetaTable) -> MathspecialbetaTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_special_beta_table_copy(s : MathspecialbetaTable) -> MathspecialbetaTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_special_beta_table_fill(s : MathspecialbetaTable, v : Double) -> MathspecialbetaTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_special_beta_table_min(s : MathspecialbetaTable) -> Double { @_common.min(s.data) }

pub fn math_special_beta_table_max(s : MathspecialbetaTable) -> Double { @_common.max(s.data) }

pub fn math_special_beta_table_to_string(s : MathspecialbetaTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathspecialbetaGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_special_beta_graphn_make(size : Int) -> MathspecialbetaGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_special_beta_graphn_len(s : MathspecialbetaGraphN) -> Int { s.size }

pub fn math_special_beta_graphn_get(s : MathspecialbetaGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_special_beta_graphn_set(s : MathspecialbetaGraphN, i : Int, v : Double) -> MathspecialbetaGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_special_beta_graphn_sum(s : MathspecialbetaGraphN) -> Double { @_common.sum(s.data) }

pub fn math_special_beta_graphn_mean(s : MathspecialbetaGraphN) -> Double { @_common.mean(s.data) }

pub fn math_special_beta_graphn_scale(s : MathspecialbetaGraphN, f : Double) -> MathspecialbetaGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_special_beta_graphn_add(a : MathspecialbetaGraphN, b : MathspecialbetaGraphN) -> MathspecialbetaGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_special_beta_graphn_copy(s : MathspecialbetaGraphN) -> MathspecialbetaGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_special_beta_graphn_fill(s : MathspecialbetaGraphN, v : Double) -> MathspecialbetaGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_special_beta_graphn_min(s : MathspecialbetaGraphN) -> Double { @_common.min(s.data) }

pub fn math_special_beta_graphn_max(s : MathspecialbetaGraphN) -> Double { @_common.max(s.data) }

pub fn math_special_beta_graphn_to_string(s : MathspecialbetaGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathspecialbetaNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_special_beta_node_make(size : Int) -> MathspecialbetaNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_special_beta_node_len(s : MathspecialbetaNode) -> Int { s.size }

pub fn math_special_beta_node_get(s : MathspecialbetaNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_special_beta_node_set(s : MathspecialbetaNode, i : Int, v : Double) -> MathspecialbetaNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_special_beta_node_sum(s : MathspecialbetaNode) -> Double { @_common.sum(s.data) }

pub fn math_special_beta_node_mean(s : MathspecialbetaNode) -> Double { @_common.mean(s.data) }

pub fn math_special_beta_node_scale(s : MathspecialbetaNode, f : Double) -> MathspecialbetaNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_special_beta_node_add(a : MathspecialbetaNode, b : MathspecialbetaNode) -> MathspecialbetaNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_special_beta_node_copy(s : MathspecialbetaNode) -> MathspecialbetaNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_special_beta_node_fill(s : MathspecialbetaNode, v : Double) -> MathspecialbetaNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_special_beta_node_min(s : MathspecialbetaNode) -> Double { @_common.min(s.data) }

pub fn math_special_beta_node_max(s : MathspecialbetaNode) -> Double { @_common.max(s.data) }

pub fn math_special_beta_node_to_string(s : MathspecialbetaNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathspecialbetaEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_special_beta_edge_make(size : Int) -> MathspecialbetaEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_special_beta_edge_len(s : MathspecialbetaEdge) -> Int { s.size }

pub fn math_special_beta_edge_get(s : MathspecialbetaEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_special_beta_edge_set(s : MathspecialbetaEdge, i : Int, v : Double) -> MathspecialbetaEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_special_beta_edge_sum(s : MathspecialbetaEdge) -> Double { @_common.sum(s.data) }

pub fn math_special_beta_edge_mean(s : MathspecialbetaEdge) -> Double { @_common.mean(s.data) }

pub fn math_special_beta_edge_scale(s : MathspecialbetaEdge, f : Double) -> MathspecialbetaEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_special_beta_edge_add(a : MathspecialbetaEdge, b : MathspecialbetaEdge) -> MathspecialbetaEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_special_beta_edge_copy(s : MathspecialbetaEdge) -> MathspecialbetaEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_special_beta_edge_fill(s : MathspecialbetaEdge, v : Double) -> MathspecialbetaEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_special_beta_edge_min(s : MathspecialbetaEdge) -> Double { @_common.min(s.data) }

pub fn math_special_beta_edge_max(s : MathspecialbetaEdge) -> Double { @_common.max(s.data) }

pub fn math_special_beta_edge_to_string(s : MathspecialbetaEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathspecialbetaPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_special_beta_path_make(size : Int) -> MathspecialbetaPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_special_beta_path_len(s : MathspecialbetaPath) -> Int { s.size }

pub fn math_special_beta_path_get(s : MathspecialbetaPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_special_beta_path_set(s : MathspecialbetaPath, i : Int, v : Double) -> MathspecialbetaPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_special_beta_path_sum(s : MathspecialbetaPath) -> Double { @_common.sum(s.data) }

pub fn math_special_beta_path_mean(s : MathspecialbetaPath) -> Double { @_common.mean(s.data) }

pub fn math_special_beta_path_scale(s : MathspecialbetaPath, f : Double) -> MathspecialbetaPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_special_beta_path_add(a : MathspecialbetaPath, b : MathspecialbetaPath) -> MathspecialbetaPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_special_beta_path_copy(s : MathspecialbetaPath) -> MathspecialbetaPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_special_beta_path_fill(s : MathspecialbetaPath, v : Double) -> MathspecialbetaPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_special_beta_path_min(s : MathspecialbetaPath) -> Double { @_common.min(s.data) }

pub fn math_special_beta_path_max(s : MathspecialbetaPath) -> Double { @_common.max(s.data) }

pub fn math_special_beta_path_to_string(s : MathspecialbetaPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathspecialbetaCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_special_beta_cluster_make(size : Int) -> MathspecialbetaCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_special_beta_cluster_len(s : MathspecialbetaCluster) -> Int { s.size }

pub fn math_special_beta_cluster_get(s : MathspecialbetaCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_special_beta_cluster_set(s : MathspecialbetaCluster, i : Int, v : Double) -> MathspecialbetaCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_special_beta_cluster_sum(s : MathspecialbetaCluster) -> Double { @_common.sum(s.data) }

pub fn math_special_beta_cluster_mean(s : MathspecialbetaCluster) -> Double { @_common.mean(s.data) }

pub fn math_special_beta_cluster_scale(s : MathspecialbetaCluster, f : Double) -> MathspecialbetaCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_special_beta_cluster_add(a : MathspecialbetaCluster, b : MathspecialbetaCluster) -> MathspecialbetaCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_special_beta_cluster_copy(s : MathspecialbetaCluster) -> MathspecialbetaCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_special_beta_cluster_fill(s : MathspecialbetaCluster, v : Double) -> MathspecialbetaCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_special_beta_cluster_min(s : MathspecialbetaCluster) -> Double { @_common.min(s.data) }

pub fn math_special_beta_cluster_max(s : MathspecialbetaCluster) -> Double { @_common.max(s.data) }

pub fn math_special_beta_cluster_to_string(s : MathspecialbetaCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathspecialbetaModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_special_beta_model_make(size : Int) -> MathspecialbetaModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_special_beta_model_len(s : MathspecialbetaModel) -> Int { s.size }

pub fn math_special_beta_model_get(s : MathspecialbetaModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_special_beta_model_set(s : MathspecialbetaModel, i : Int, v : Double) -> MathspecialbetaModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_special_beta_model_sum(s : MathspecialbetaModel) -> Double { @_common.sum(s.data) }

pub fn math_special_beta_model_mean(s : MathspecialbetaModel) -> Double { @_common.mean(s.data) }

pub fn math_special_beta_model_scale(s : MathspecialbetaModel, f : Double) -> MathspecialbetaModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_special_beta_model_add(a : MathspecialbetaModel, b : MathspecialbetaModel) -> MathspecialbetaModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_special_beta_model_copy(s : MathspecialbetaModel) -> MathspecialbetaModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_special_beta_model_fill(s : MathspecialbetaModel, v : Double) -> MathspecialbetaModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_special_beta_model_min(s : MathspecialbetaModel) -> Double { @_common.min(s.data) }

pub fn math_special_beta_model_max(s : MathspecialbetaModel) -> Double { @_common.max(s.data) }

pub fn math_special_beta_model_to_string(s : MathspecialbetaModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathspecialbetaLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_special_beta_layer_make(size : Int) -> MathspecialbetaLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_special_beta_layer_len(s : MathspecialbetaLayer) -> Int { s.size }

pub fn math_special_beta_layer_get(s : MathspecialbetaLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_special_beta_layer_set(s : MathspecialbetaLayer, i : Int, v : Double) -> MathspecialbetaLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_special_beta_layer_sum(s : MathspecialbetaLayer) -> Double { @_common.sum(s.data) }

pub fn math_special_beta_layer_mean(s : MathspecialbetaLayer) -> Double { @_common.mean(s.data) }

pub fn math_special_beta_layer_scale(s : MathspecialbetaLayer, f : Double) -> MathspecialbetaLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_special_beta_layer_add(a : MathspecialbetaLayer, b : MathspecialbetaLayer) -> MathspecialbetaLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_special_beta_layer_copy(s : MathspecialbetaLayer) -> MathspecialbetaLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_special_beta_layer_fill(s : MathspecialbetaLayer, v : Double) -> MathspecialbetaLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_special_beta_layer_min(s : MathspecialbetaLayer) -> Double { @_common.min(s.data) }

pub fn math_special_beta_layer_max(s : MathspecialbetaLayer) -> Double { @_common.max(s.data) }

pub fn math_special_beta_layer_to_string(s : MathspecialbetaLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathspecialbetaBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_special_beta_buffer_make(size : Int) -> MathspecialbetaBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_special_beta_buffer_len(s : MathspecialbetaBuffer) -> Int { s.size }

pub fn math_special_beta_buffer_get(s : MathspecialbetaBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_special_beta_buffer_set(s : MathspecialbetaBuffer, i : Int, v : Double) -> MathspecialbetaBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_special_beta_buffer_sum(s : MathspecialbetaBuffer) -> Double { @_common.sum(s.data) }

pub fn math_special_beta_buffer_mean(s : MathspecialbetaBuffer) -> Double { @_common.mean(s.data) }

pub fn math_special_beta_buffer_scale(s : MathspecialbetaBuffer, f : Double) -> MathspecialbetaBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_special_beta_buffer_add(a : MathspecialbetaBuffer, b : MathspecialbetaBuffer) -> MathspecialbetaBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_special_beta_buffer_copy(s : MathspecialbetaBuffer) -> MathspecialbetaBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_special_beta_buffer_fill(s : MathspecialbetaBuffer, v : Double) -> MathspecialbetaBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_special_beta_buffer_min(s : MathspecialbetaBuffer) -> Double { @_common.min(s.data) }

pub fn math_special_beta_buffer_max(s : MathspecialbetaBuffer) -> Double { @_common.max(s.data) }

pub fn math_special_beta_buffer_to_string(s : MathspecialbetaBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathspecialbetaCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_special_beta_cursor_make(size : Int) -> MathspecialbetaCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_special_beta_cursor_len(s : MathspecialbetaCursor) -> Int { s.size }

pub fn math_special_beta_cursor_get(s : MathspecialbetaCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_special_beta_cursor_set(s : MathspecialbetaCursor, i : Int, v : Double) -> MathspecialbetaCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_special_beta_cursor_sum(s : MathspecialbetaCursor) -> Double { @_common.sum(s.data) }

pub fn math_special_beta_cursor_mean(s : MathspecialbetaCursor) -> Double { @_common.mean(s.data) }

pub fn math_special_beta_cursor_scale(s : MathspecialbetaCursor, f : Double) -> MathspecialbetaCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_special_beta_cursor_add(a : MathspecialbetaCursor, b : MathspecialbetaCursor) -> MathspecialbetaCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_special_beta_cursor_copy(s : MathspecialbetaCursor) -> MathspecialbetaCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_special_beta_cursor_fill(s : MathspecialbetaCursor, v : Double) -> MathspecialbetaCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_special_beta_cursor_min(s : MathspecialbetaCursor) -> Double { @_common.min(s.data) }

pub fn math_special_beta_cursor_max(s : MathspecialbetaCursor) -> Double { @_common.max(s.data) }

pub fn math_special_beta_cursor_to_string(s : MathspecialbetaCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathspecialbetaView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_special_beta_view_make(size : Int) -> MathspecialbetaView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_special_beta_view_len(s : MathspecialbetaView) -> Int { s.size }

pub fn math_special_beta_view_get(s : MathspecialbetaView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_special_beta_view_set(s : MathspecialbetaView, i : Int, v : Double) -> MathspecialbetaView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_special_beta_view_sum(s : MathspecialbetaView) -> Double { @_common.sum(s.data) }

pub fn math_special_beta_view_mean(s : MathspecialbetaView) -> Double { @_common.mean(s.data) }

pub fn math_special_beta_view_scale(s : MathspecialbetaView, f : Double) -> MathspecialbetaView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_special_beta_view_add(a : MathspecialbetaView, b : MathspecialbetaView) -> MathspecialbetaView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_special_beta_view_copy(s : MathspecialbetaView) -> MathspecialbetaView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_special_beta_view_fill(s : MathspecialbetaView, v : Double) -> MathspecialbetaView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_special_beta_view_min(s : MathspecialbetaView) -> Double { @_common.min(s.data) }

pub fn math_special_beta_view_max(s : MathspecialbetaView) -> Double { @_common.max(s.data) }

pub fn math_special_beta_view_to_string(s : MathspecialbetaView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathspecialbetaRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_special_beta_range_make(size : Int) -> MathspecialbetaRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_special_beta_range_len(s : MathspecialbetaRange) -> Int { s.size }

pub fn math_special_beta_range_get(s : MathspecialbetaRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_special_beta_range_set(s : MathspecialbetaRange, i : Int, v : Double) -> MathspecialbetaRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_special_beta_range_sum(s : MathspecialbetaRange) -> Double { @_common.sum(s.data) }

pub fn math_special_beta_range_mean(s : MathspecialbetaRange) -> Double { @_common.mean(s.data) }

pub fn math_special_beta_range_scale(s : MathspecialbetaRange, f : Double) -> MathspecialbetaRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_special_beta_range_add(a : MathspecialbetaRange, b : MathspecialbetaRange) -> MathspecialbetaRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_special_beta_range_copy(s : MathspecialbetaRange) -> MathspecialbetaRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_special_beta_range_fill(s : MathspecialbetaRange, v : Double) -> MathspecialbetaRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_special_beta_range_min(s : MathspecialbetaRange) -> Double { @_common.min(s.data) }

pub fn math_special_beta_range_max(s : MathspecialbetaRange) -> Double { @_common.max(s.data) }

pub fn math_special_beta_range_to_string(s : MathspecialbetaRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathspecialbetaSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_special_beta_slice_make(size : Int) -> MathspecialbetaSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_special_beta_slice_len(s : MathspecialbetaSlice) -> Int { s.size }

pub fn math_special_beta_slice_get(s : MathspecialbetaSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_special_beta_slice_set(s : MathspecialbetaSlice, i : Int, v : Double) -> MathspecialbetaSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_special_beta_slice_sum(s : MathspecialbetaSlice) -> Double { @_common.sum(s.data) }

pub fn math_special_beta_slice_mean(s : MathspecialbetaSlice) -> Double { @_common.mean(s.data) }

pub fn math_special_beta_slice_scale(s : MathspecialbetaSlice, f : Double) -> MathspecialbetaSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_special_beta_slice_add(a : MathspecialbetaSlice, b : MathspecialbetaSlice) -> MathspecialbetaSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_special_beta_slice_copy(s : MathspecialbetaSlice) -> MathspecialbetaSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_special_beta_slice_fill(s : MathspecialbetaSlice, v : Double) -> MathspecialbetaSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_special_beta_slice_min(s : MathspecialbetaSlice) -> Double { @_common.min(s.data) }

pub fn math_special_beta_slice_max(s : MathspecialbetaSlice) -> Double { @_common.max(s.data) }

pub fn math_special_beta_slice_to_string(s : MathspecialbetaSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

