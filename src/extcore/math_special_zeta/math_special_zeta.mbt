///===
/// extcore/math_special_zeta

pub(all) struct MathspecialzetaPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn math_special_zeta_make_point(x : Double, y : Double) -> MathspecialzetaPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn math_special_zeta_make_point3(x : Double, y : Double, z : Double) -> MathspecialzetaPoint {
  { x, y, z, label: 0 }
}

pub fn MathspecialzetaPoint::x(self : MathspecialzetaPoint) -> Double { self.x }

pub fn MathspecialzetaPoint::y(self : MathspecialzetaPoint) -> Double { self.y }

pub fn MathspecialzetaPoint::z(self : MathspecialzetaPoint) -> Double { self.z }

pub fn MathspecialzetaPoint::label(self : MathspecialzetaPoint) -> Int { self.label }

pub fn MathspecialzetaPoint::dist(self : MathspecialzetaPoint, other : MathspecialzetaPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn MathspecialzetaPoint::add(self : MathspecialzetaPoint, other : MathspecialzetaPoint) -> MathspecialzetaPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn MathspecialzetaPoint::sub(self : MathspecialzetaPoint, other : MathspecialzetaPoint) -> MathspecialzetaPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn MathspecialzetaPoint::scale(self : MathspecialzetaPoint, s : Double) -> MathspecialzetaPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn MathspecialzetaPoint::dot(self : MathspecialzetaPoint, other : MathspecialzetaPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn MathspecialzetaPoint::cross(self : MathspecialzetaPoint, other : MathspecialzetaPoint) -> MathspecialzetaPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn MathspecialzetaPoint::norm(self : MathspecialzetaPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn MathspecialzetaPoint::normalize(self : MathspecialzetaPoint) -> MathspecialzetaPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn MathspecialzetaPoint::negate(self : MathspecialzetaPoint) -> MathspecialzetaPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn MathspecialzetaPoint::mid(self : MathspecialzetaPoint, other : MathspecialzetaPoint) -> MathspecialzetaPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn MathspecialzetaPoint::lerp(self : MathspecialzetaPoint, other : MathspecialzetaPoint, t : Double) -> MathspecialzetaPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn MathspecialzetaPoint::to_string(self : MathspecialzetaPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct MathspecialzetaSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn math_special_zeta_make_series(vals : Array[Double], name : String) -> MathspecialzetaSeries {
  { vals, name, meta: 0 }
}

pub fn MathspecialzetaSeries::len(self : MathspecialzetaSeries) -> Int { self.vals.length() }

pub fn MathspecialzetaSeries::sum(self : MathspecialzetaSeries) -> Double { @_common.sum(self.vals) }

pub fn MathspecialzetaSeries::mean(self : MathspecialzetaSeries) -> Double { @_common.mean(self.vals) }

pub fn MathspecialzetaSeries::min(self : MathspecialzetaSeries) -> Double { @_common.min(self.vals) }

pub fn MathspecialzetaSeries::max(self : MathspecialzetaSeries) -> Double { @_common.max(self.vals) }

pub fn MathspecialzetaSeries::range(self : MathspecialzetaSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn MathspecialzetaSeries::variance(self : MathspecialzetaSeries) -> Double { @_common.variance(self.vals) }

pub fn MathspecialzetaSeries::std(self : MathspecialzetaSeries) -> Double { @_common.std(self.vals) }

pub fn MathspecialzetaSeries::median(self : MathspecialzetaSeries) -> Double { @_common.median(self.vals) }

pub fn MathspecialzetaSeries::scale(self : MathspecialzetaSeries, f : Double) -> MathspecialzetaSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn MathspecialzetaSeries::add(self : MathspecialzetaSeries, other : MathspecialzetaSeries) -> MathspecialzetaSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn MathspecialzetaSeries::sub(self : MathspecialzetaSeries, other : MathspecialzetaSeries) -> MathspecialzetaSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn MathspecialzetaSeries::normalize(self : MathspecialzetaSeries) -> MathspecialzetaSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn MathspecialzetaSeries::cumsum(self : MathspecialzetaSeries) -> MathspecialzetaSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn MathspecialzetaSeries::to_string(self : MathspecialzetaSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct MathspecialzetaMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn math_special_zeta_make_matrix(rows : Int, cols : Int, val : Double) -> MathspecialzetaMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn math_special_zeta_matrix_identity(n : Int) -> MathspecialzetaMatrix {
  let m = math_special_zeta_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn MathspecialzetaMatrix::get(self : MathspecialzetaMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn MathspecialzetaMatrix::transpose(self : MathspecialzetaMatrix) -> MathspecialzetaMatrix {
  let result = math_special_zeta_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn MathspecialzetaMatrix::add(self : MathspecialzetaMatrix, other : MathspecialzetaMatrix) -> MathspecialzetaMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = math_special_zeta_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn MathspecialzetaMatrix::scale(self : MathspecialzetaMatrix, s : Double) -> MathspecialzetaMatrix {
  let result = math_special_zeta_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn MathspecialzetaMatrix::multiply(self : MathspecialzetaMatrix, other : MathspecialzetaMatrix) -> MathspecialzetaMatrix {
  if self.cols != other.rows { return math_special_zeta_make_matrix(self.rows, other.cols, 0.0) }
  let result = math_special_zeta_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn MathspecialzetaMatrix::trace(self : MathspecialzetaMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn MathspecialzetaMatrix::det(self : MathspecialzetaMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn MathspecialzetaMatrix::norm(self : MathspecialzetaMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn MathspecialzetaMatrix::to_string(self : MathspecialzetaMatrix) -> String {
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

pub(all) struct MathspecialzetaVector {
  comps : Array[Double]
  dim : Int
}

pub fn math_special_zeta_make_vector(comps : Array[Double]) -> MathspecialzetaVector {
  { comps, dim: comps.length() }
}

pub fn math_special_zeta_vector_zero(dim : Int) -> MathspecialzetaVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn MathspecialzetaVector::add(self : MathspecialzetaVector, other : MathspecialzetaVector) -> MathspecialzetaVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn MathspecialzetaVector::sub(self : MathspecialzetaVector, other : MathspecialzetaVector) -> MathspecialzetaVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn MathspecialzetaVector::scale(self : MathspecialzetaVector, s : Double) -> MathspecialzetaVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn MathspecialzetaVector::dot(self : MathspecialzetaVector, other : MathspecialzetaVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn MathspecialzetaVector::norm(self : MathspecialzetaVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn MathspecialzetaVector::normalize(self : MathspecialzetaVector) -> MathspecialzetaVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn MathspecialzetaVector::dist(self : MathspecialzetaVector, other : MathspecialzetaVector) -> Double {
  self.sub(other).norm()
}

pub fn MathspecialzetaVector::to_string(self : MathspecialzetaVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn math_special_zeta_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn math_special_zeta_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn math_special_zeta_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn math_special_zeta_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn math_special_zeta_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn math_special_zeta_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn math_special_zeta_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn math_special_zeta_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn math_special_zeta_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn math_special_zeta_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn math_special_zeta_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn math_special_zeta_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn math_special_zeta_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn math_special_zeta_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn math_special_zeta_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn math_special_zeta_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn math_special_zeta_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn math_special_zeta_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn math_special_zeta_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn math_special_zeta_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn math_special_zeta_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn math_special_zeta_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn math_special_zeta_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn math_special_zeta_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn math_special_zeta_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn math_special_zeta_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn math_special_zeta_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn math_special_zeta_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn math_special_zeta_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct MathspecialzetaFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_special_zeta_frame_make(size : Int) -> MathspecialzetaFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_special_zeta_frame_len(s : MathspecialzetaFrame) -> Int { s.size }

pub fn math_special_zeta_frame_get(s : MathspecialzetaFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_special_zeta_frame_set(s : MathspecialzetaFrame, i : Int, v : Double) -> MathspecialzetaFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_special_zeta_frame_sum(s : MathspecialzetaFrame) -> Double { @_common.sum(s.data) }

pub fn math_special_zeta_frame_mean(s : MathspecialzetaFrame) -> Double { @_common.mean(s.data) }

pub fn math_special_zeta_frame_scale(s : MathspecialzetaFrame, f : Double) -> MathspecialzetaFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_special_zeta_frame_add(a : MathspecialzetaFrame, b : MathspecialzetaFrame) -> MathspecialzetaFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_special_zeta_frame_copy(s : MathspecialzetaFrame) -> MathspecialzetaFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_special_zeta_frame_fill(s : MathspecialzetaFrame, v : Double) -> MathspecialzetaFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_special_zeta_frame_min(s : MathspecialzetaFrame) -> Double { @_common.min(s.data) }

pub fn math_special_zeta_frame_max(s : MathspecialzetaFrame) -> Double { @_common.max(s.data) }

pub fn math_special_zeta_frame_to_string(s : MathspecialzetaFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathspecialzetaTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_special_zeta_table_make(size : Int) -> MathspecialzetaTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_special_zeta_table_len(s : MathspecialzetaTable) -> Int { s.size }

pub fn math_special_zeta_table_get(s : MathspecialzetaTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_special_zeta_table_set(s : MathspecialzetaTable, i : Int, v : Double) -> MathspecialzetaTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_special_zeta_table_sum(s : MathspecialzetaTable) -> Double { @_common.sum(s.data) }

pub fn math_special_zeta_table_mean(s : MathspecialzetaTable) -> Double { @_common.mean(s.data) }

pub fn math_special_zeta_table_scale(s : MathspecialzetaTable, f : Double) -> MathspecialzetaTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_special_zeta_table_add(a : MathspecialzetaTable, b : MathspecialzetaTable) -> MathspecialzetaTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_special_zeta_table_copy(s : MathspecialzetaTable) -> MathspecialzetaTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_special_zeta_table_fill(s : MathspecialzetaTable, v : Double) -> MathspecialzetaTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_special_zeta_table_min(s : MathspecialzetaTable) -> Double { @_common.min(s.data) }

pub fn math_special_zeta_table_max(s : MathspecialzetaTable) -> Double { @_common.max(s.data) }

pub fn math_special_zeta_table_to_string(s : MathspecialzetaTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathspecialzetaGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_special_zeta_graphn_make(size : Int) -> MathspecialzetaGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_special_zeta_graphn_len(s : MathspecialzetaGraphN) -> Int { s.size }

pub fn math_special_zeta_graphn_get(s : MathspecialzetaGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_special_zeta_graphn_set(s : MathspecialzetaGraphN, i : Int, v : Double) -> MathspecialzetaGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_special_zeta_graphn_sum(s : MathspecialzetaGraphN) -> Double { @_common.sum(s.data) }

pub fn math_special_zeta_graphn_mean(s : MathspecialzetaGraphN) -> Double { @_common.mean(s.data) }

pub fn math_special_zeta_graphn_scale(s : MathspecialzetaGraphN, f : Double) -> MathspecialzetaGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_special_zeta_graphn_add(a : MathspecialzetaGraphN, b : MathspecialzetaGraphN) -> MathspecialzetaGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_special_zeta_graphn_copy(s : MathspecialzetaGraphN) -> MathspecialzetaGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_special_zeta_graphn_fill(s : MathspecialzetaGraphN, v : Double) -> MathspecialzetaGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_special_zeta_graphn_min(s : MathspecialzetaGraphN) -> Double { @_common.min(s.data) }

pub fn math_special_zeta_graphn_max(s : MathspecialzetaGraphN) -> Double { @_common.max(s.data) }

pub fn math_special_zeta_graphn_to_string(s : MathspecialzetaGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathspecialzetaNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_special_zeta_node_make(size : Int) -> MathspecialzetaNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_special_zeta_node_len(s : MathspecialzetaNode) -> Int { s.size }

pub fn math_special_zeta_node_get(s : MathspecialzetaNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_special_zeta_node_set(s : MathspecialzetaNode, i : Int, v : Double) -> MathspecialzetaNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_special_zeta_node_sum(s : MathspecialzetaNode) -> Double { @_common.sum(s.data) }

pub fn math_special_zeta_node_mean(s : MathspecialzetaNode) -> Double { @_common.mean(s.data) }

pub fn math_special_zeta_node_scale(s : MathspecialzetaNode, f : Double) -> MathspecialzetaNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_special_zeta_node_add(a : MathspecialzetaNode, b : MathspecialzetaNode) -> MathspecialzetaNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_special_zeta_node_copy(s : MathspecialzetaNode) -> MathspecialzetaNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_special_zeta_node_fill(s : MathspecialzetaNode, v : Double) -> MathspecialzetaNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_special_zeta_node_min(s : MathspecialzetaNode) -> Double { @_common.min(s.data) }

pub fn math_special_zeta_node_max(s : MathspecialzetaNode) -> Double { @_common.max(s.data) }

pub fn math_special_zeta_node_to_string(s : MathspecialzetaNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathspecialzetaEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_special_zeta_edge_make(size : Int) -> MathspecialzetaEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_special_zeta_edge_len(s : MathspecialzetaEdge) -> Int { s.size }

pub fn math_special_zeta_edge_get(s : MathspecialzetaEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_special_zeta_edge_set(s : MathspecialzetaEdge, i : Int, v : Double) -> MathspecialzetaEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_special_zeta_edge_sum(s : MathspecialzetaEdge) -> Double { @_common.sum(s.data) }

pub fn math_special_zeta_edge_mean(s : MathspecialzetaEdge) -> Double { @_common.mean(s.data) }

pub fn math_special_zeta_edge_scale(s : MathspecialzetaEdge, f : Double) -> MathspecialzetaEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_special_zeta_edge_add(a : MathspecialzetaEdge, b : MathspecialzetaEdge) -> MathspecialzetaEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_special_zeta_edge_copy(s : MathspecialzetaEdge) -> MathspecialzetaEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_special_zeta_edge_fill(s : MathspecialzetaEdge, v : Double) -> MathspecialzetaEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_special_zeta_edge_min(s : MathspecialzetaEdge) -> Double { @_common.min(s.data) }

pub fn math_special_zeta_edge_max(s : MathspecialzetaEdge) -> Double { @_common.max(s.data) }

pub fn math_special_zeta_edge_to_string(s : MathspecialzetaEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathspecialzetaPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_special_zeta_path_make(size : Int) -> MathspecialzetaPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_special_zeta_path_len(s : MathspecialzetaPath) -> Int { s.size }

pub fn math_special_zeta_path_get(s : MathspecialzetaPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_special_zeta_path_set(s : MathspecialzetaPath, i : Int, v : Double) -> MathspecialzetaPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_special_zeta_path_sum(s : MathspecialzetaPath) -> Double { @_common.sum(s.data) }

pub fn math_special_zeta_path_mean(s : MathspecialzetaPath) -> Double { @_common.mean(s.data) }

pub fn math_special_zeta_path_scale(s : MathspecialzetaPath, f : Double) -> MathspecialzetaPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_special_zeta_path_add(a : MathspecialzetaPath, b : MathspecialzetaPath) -> MathspecialzetaPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_special_zeta_path_copy(s : MathspecialzetaPath) -> MathspecialzetaPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_special_zeta_path_fill(s : MathspecialzetaPath, v : Double) -> MathspecialzetaPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_special_zeta_path_min(s : MathspecialzetaPath) -> Double { @_common.min(s.data) }

pub fn math_special_zeta_path_max(s : MathspecialzetaPath) -> Double { @_common.max(s.data) }

pub fn math_special_zeta_path_to_string(s : MathspecialzetaPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathspecialzetaCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_special_zeta_cluster_make(size : Int) -> MathspecialzetaCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_special_zeta_cluster_len(s : MathspecialzetaCluster) -> Int { s.size }

pub fn math_special_zeta_cluster_get(s : MathspecialzetaCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_special_zeta_cluster_set(s : MathspecialzetaCluster, i : Int, v : Double) -> MathspecialzetaCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_special_zeta_cluster_sum(s : MathspecialzetaCluster) -> Double { @_common.sum(s.data) }

pub fn math_special_zeta_cluster_mean(s : MathspecialzetaCluster) -> Double { @_common.mean(s.data) }

pub fn math_special_zeta_cluster_scale(s : MathspecialzetaCluster, f : Double) -> MathspecialzetaCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_special_zeta_cluster_add(a : MathspecialzetaCluster, b : MathspecialzetaCluster) -> MathspecialzetaCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_special_zeta_cluster_copy(s : MathspecialzetaCluster) -> MathspecialzetaCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_special_zeta_cluster_fill(s : MathspecialzetaCluster, v : Double) -> MathspecialzetaCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_special_zeta_cluster_min(s : MathspecialzetaCluster) -> Double { @_common.min(s.data) }

pub fn math_special_zeta_cluster_max(s : MathspecialzetaCluster) -> Double { @_common.max(s.data) }

pub fn math_special_zeta_cluster_to_string(s : MathspecialzetaCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathspecialzetaModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_special_zeta_model_make(size : Int) -> MathspecialzetaModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_special_zeta_model_len(s : MathspecialzetaModel) -> Int { s.size }

pub fn math_special_zeta_model_get(s : MathspecialzetaModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_special_zeta_model_set(s : MathspecialzetaModel, i : Int, v : Double) -> MathspecialzetaModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_special_zeta_model_sum(s : MathspecialzetaModel) -> Double { @_common.sum(s.data) }

pub fn math_special_zeta_model_mean(s : MathspecialzetaModel) -> Double { @_common.mean(s.data) }

pub fn math_special_zeta_model_scale(s : MathspecialzetaModel, f : Double) -> MathspecialzetaModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_special_zeta_model_add(a : MathspecialzetaModel, b : MathspecialzetaModel) -> MathspecialzetaModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_special_zeta_model_copy(s : MathspecialzetaModel) -> MathspecialzetaModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_special_zeta_model_fill(s : MathspecialzetaModel, v : Double) -> MathspecialzetaModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_special_zeta_model_min(s : MathspecialzetaModel) -> Double { @_common.min(s.data) }

pub fn math_special_zeta_model_max(s : MathspecialzetaModel) -> Double { @_common.max(s.data) }

pub fn math_special_zeta_model_to_string(s : MathspecialzetaModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathspecialzetaLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_special_zeta_layer_make(size : Int) -> MathspecialzetaLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_special_zeta_layer_len(s : MathspecialzetaLayer) -> Int { s.size }

pub fn math_special_zeta_layer_get(s : MathspecialzetaLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_special_zeta_layer_set(s : MathspecialzetaLayer, i : Int, v : Double) -> MathspecialzetaLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_special_zeta_layer_sum(s : MathspecialzetaLayer) -> Double { @_common.sum(s.data) }

pub fn math_special_zeta_layer_mean(s : MathspecialzetaLayer) -> Double { @_common.mean(s.data) }

pub fn math_special_zeta_layer_scale(s : MathspecialzetaLayer, f : Double) -> MathspecialzetaLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_special_zeta_layer_add(a : MathspecialzetaLayer, b : MathspecialzetaLayer) -> MathspecialzetaLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_special_zeta_layer_copy(s : MathspecialzetaLayer) -> MathspecialzetaLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_special_zeta_layer_fill(s : MathspecialzetaLayer, v : Double) -> MathspecialzetaLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_special_zeta_layer_min(s : MathspecialzetaLayer) -> Double { @_common.min(s.data) }

pub fn math_special_zeta_layer_max(s : MathspecialzetaLayer) -> Double { @_common.max(s.data) }

pub fn math_special_zeta_layer_to_string(s : MathspecialzetaLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathspecialzetaBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_special_zeta_buffer_make(size : Int) -> MathspecialzetaBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_special_zeta_buffer_len(s : MathspecialzetaBuffer) -> Int { s.size }

pub fn math_special_zeta_buffer_get(s : MathspecialzetaBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_special_zeta_buffer_set(s : MathspecialzetaBuffer, i : Int, v : Double) -> MathspecialzetaBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_special_zeta_buffer_sum(s : MathspecialzetaBuffer) -> Double { @_common.sum(s.data) }

pub fn math_special_zeta_buffer_mean(s : MathspecialzetaBuffer) -> Double { @_common.mean(s.data) }

pub fn math_special_zeta_buffer_scale(s : MathspecialzetaBuffer, f : Double) -> MathspecialzetaBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_special_zeta_buffer_add(a : MathspecialzetaBuffer, b : MathspecialzetaBuffer) -> MathspecialzetaBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_special_zeta_buffer_copy(s : MathspecialzetaBuffer) -> MathspecialzetaBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_special_zeta_buffer_fill(s : MathspecialzetaBuffer, v : Double) -> MathspecialzetaBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_special_zeta_buffer_min(s : MathspecialzetaBuffer) -> Double { @_common.min(s.data) }

pub fn math_special_zeta_buffer_max(s : MathspecialzetaBuffer) -> Double { @_common.max(s.data) }

pub fn math_special_zeta_buffer_to_string(s : MathspecialzetaBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathspecialzetaCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_special_zeta_cursor_make(size : Int) -> MathspecialzetaCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_special_zeta_cursor_len(s : MathspecialzetaCursor) -> Int { s.size }

pub fn math_special_zeta_cursor_get(s : MathspecialzetaCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_special_zeta_cursor_set(s : MathspecialzetaCursor, i : Int, v : Double) -> MathspecialzetaCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_special_zeta_cursor_sum(s : MathspecialzetaCursor) -> Double { @_common.sum(s.data) }

pub fn math_special_zeta_cursor_mean(s : MathspecialzetaCursor) -> Double { @_common.mean(s.data) }

pub fn math_special_zeta_cursor_scale(s : MathspecialzetaCursor, f : Double) -> MathspecialzetaCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_special_zeta_cursor_add(a : MathspecialzetaCursor, b : MathspecialzetaCursor) -> MathspecialzetaCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_special_zeta_cursor_copy(s : MathspecialzetaCursor) -> MathspecialzetaCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_special_zeta_cursor_fill(s : MathspecialzetaCursor, v : Double) -> MathspecialzetaCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_special_zeta_cursor_min(s : MathspecialzetaCursor) -> Double { @_common.min(s.data) }

pub fn math_special_zeta_cursor_max(s : MathspecialzetaCursor) -> Double { @_common.max(s.data) }

pub fn math_special_zeta_cursor_to_string(s : MathspecialzetaCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathspecialzetaView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_special_zeta_view_make(size : Int) -> MathspecialzetaView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_special_zeta_view_len(s : MathspecialzetaView) -> Int { s.size }

pub fn math_special_zeta_view_get(s : MathspecialzetaView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_special_zeta_view_set(s : MathspecialzetaView, i : Int, v : Double) -> MathspecialzetaView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_special_zeta_view_sum(s : MathspecialzetaView) -> Double { @_common.sum(s.data) }

pub fn math_special_zeta_view_mean(s : MathspecialzetaView) -> Double { @_common.mean(s.data) }

pub fn math_special_zeta_view_scale(s : MathspecialzetaView, f : Double) -> MathspecialzetaView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_special_zeta_view_add(a : MathspecialzetaView, b : MathspecialzetaView) -> MathspecialzetaView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_special_zeta_view_copy(s : MathspecialzetaView) -> MathspecialzetaView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_special_zeta_view_fill(s : MathspecialzetaView, v : Double) -> MathspecialzetaView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_special_zeta_view_min(s : MathspecialzetaView) -> Double { @_common.min(s.data) }

pub fn math_special_zeta_view_max(s : MathspecialzetaView) -> Double { @_common.max(s.data) }

pub fn math_special_zeta_view_to_string(s : MathspecialzetaView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathspecialzetaRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_special_zeta_range_make(size : Int) -> MathspecialzetaRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_special_zeta_range_len(s : MathspecialzetaRange) -> Int { s.size }

pub fn math_special_zeta_range_get(s : MathspecialzetaRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_special_zeta_range_set(s : MathspecialzetaRange, i : Int, v : Double) -> MathspecialzetaRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_special_zeta_range_sum(s : MathspecialzetaRange) -> Double { @_common.sum(s.data) }

pub fn math_special_zeta_range_mean(s : MathspecialzetaRange) -> Double { @_common.mean(s.data) }

pub fn math_special_zeta_range_scale(s : MathspecialzetaRange, f : Double) -> MathspecialzetaRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_special_zeta_range_add(a : MathspecialzetaRange, b : MathspecialzetaRange) -> MathspecialzetaRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_special_zeta_range_copy(s : MathspecialzetaRange) -> MathspecialzetaRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_special_zeta_range_fill(s : MathspecialzetaRange, v : Double) -> MathspecialzetaRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_special_zeta_range_min(s : MathspecialzetaRange) -> Double { @_common.min(s.data) }

pub fn math_special_zeta_range_max(s : MathspecialzetaRange) -> Double { @_common.max(s.data) }

pub fn math_special_zeta_range_to_string(s : MathspecialzetaRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathspecialzetaSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_special_zeta_slice_make(size : Int) -> MathspecialzetaSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_special_zeta_slice_len(s : MathspecialzetaSlice) -> Int { s.size }

pub fn math_special_zeta_slice_get(s : MathspecialzetaSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_special_zeta_slice_set(s : MathspecialzetaSlice, i : Int, v : Double) -> MathspecialzetaSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_special_zeta_slice_sum(s : MathspecialzetaSlice) -> Double { @_common.sum(s.data) }

pub fn math_special_zeta_slice_mean(s : MathspecialzetaSlice) -> Double { @_common.mean(s.data) }

pub fn math_special_zeta_slice_scale(s : MathspecialzetaSlice, f : Double) -> MathspecialzetaSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_special_zeta_slice_add(a : MathspecialzetaSlice, b : MathspecialzetaSlice) -> MathspecialzetaSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_special_zeta_slice_copy(s : MathspecialzetaSlice) -> MathspecialzetaSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_special_zeta_slice_fill(s : MathspecialzetaSlice, v : Double) -> MathspecialzetaSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_special_zeta_slice_min(s : MathspecialzetaSlice) -> Double { @_common.min(s.data) }

pub fn math_special_zeta_slice_max(s : MathspecialzetaSlice) -> Double { @_common.max(s.data) }

pub fn math_special_zeta_slice_to_string(s : MathspecialzetaSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

