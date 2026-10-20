///===
/// extcore/ml_regress_poly

pub(all) struct MlregresspolyPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn ml_regress_poly_make_point(x : Double, y : Double) -> MlregresspolyPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn ml_regress_poly_make_point3(x : Double, y : Double, z : Double) -> MlregresspolyPoint {
  { x, y, z, label: 0 }
}

pub fn MlregresspolyPoint::x(self : MlregresspolyPoint) -> Double { self.x }

pub fn MlregresspolyPoint::y(self : MlregresspolyPoint) -> Double { self.y }

pub fn MlregresspolyPoint::z(self : MlregresspolyPoint) -> Double { self.z }

pub fn MlregresspolyPoint::label(self : MlregresspolyPoint) -> Int { self.label }

pub fn MlregresspolyPoint::dist(self : MlregresspolyPoint, other : MlregresspolyPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn MlregresspolyPoint::add(self : MlregresspolyPoint, other : MlregresspolyPoint) -> MlregresspolyPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn MlregresspolyPoint::sub(self : MlregresspolyPoint, other : MlregresspolyPoint) -> MlregresspolyPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn MlregresspolyPoint::scale(self : MlregresspolyPoint, s : Double) -> MlregresspolyPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn MlregresspolyPoint::dot(self : MlregresspolyPoint, other : MlregresspolyPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn MlregresspolyPoint::cross(self : MlregresspolyPoint, other : MlregresspolyPoint) -> MlregresspolyPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn MlregresspolyPoint::norm(self : MlregresspolyPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn MlregresspolyPoint::normalize(self : MlregresspolyPoint) -> MlregresspolyPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn MlregresspolyPoint::negate(self : MlregresspolyPoint) -> MlregresspolyPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn MlregresspolyPoint::mid(self : MlregresspolyPoint, other : MlregresspolyPoint) -> MlregresspolyPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn MlregresspolyPoint::lerp(self : MlregresspolyPoint, other : MlregresspolyPoint, t : Double) -> MlregresspolyPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn MlregresspolyPoint::to_string(self : MlregresspolyPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct MlregresspolySeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn ml_regress_poly_make_series(vals : Array[Double], name : String) -> MlregresspolySeries {
  { vals, name, meta: 0 }
}

pub fn MlregresspolySeries::len(self : MlregresspolySeries) -> Int { self.vals.length() }

pub fn MlregresspolySeries::sum(self : MlregresspolySeries) -> Double { @_common.sum(self.vals) }

pub fn MlregresspolySeries::mean(self : MlregresspolySeries) -> Double { @_common.mean(self.vals) }

pub fn MlregresspolySeries::min(self : MlregresspolySeries) -> Double { @_common.min(self.vals) }

pub fn MlregresspolySeries::max(self : MlregresspolySeries) -> Double { @_common.max(self.vals) }

pub fn MlregresspolySeries::range(self : MlregresspolySeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn MlregresspolySeries::variance(self : MlregresspolySeries) -> Double { @_common.variance(self.vals) }

pub fn MlregresspolySeries::std(self : MlregresspolySeries) -> Double { @_common.std(self.vals) }

pub fn MlregresspolySeries::median(self : MlregresspolySeries) -> Double { @_common.median(self.vals) }

pub fn MlregresspolySeries::scale(self : MlregresspolySeries, f : Double) -> MlregresspolySeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn MlregresspolySeries::add(self : MlregresspolySeries, other : MlregresspolySeries) -> MlregresspolySeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn MlregresspolySeries::sub(self : MlregresspolySeries, other : MlregresspolySeries) -> MlregresspolySeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn MlregresspolySeries::normalize(self : MlregresspolySeries) -> MlregresspolySeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn MlregresspolySeries::cumsum(self : MlregresspolySeries) -> MlregresspolySeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn MlregresspolySeries::to_string(self : MlregresspolySeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct MlregresspolyMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn ml_regress_poly_make_matrix(rows : Int, cols : Int, val : Double) -> MlregresspolyMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn ml_regress_poly_matrix_identity(n : Int) -> MlregresspolyMatrix {
  let m = ml_regress_poly_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn MlregresspolyMatrix::get(self : MlregresspolyMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn MlregresspolyMatrix::transpose(self : MlregresspolyMatrix) -> MlregresspolyMatrix {
  let result = ml_regress_poly_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn MlregresspolyMatrix::add(self : MlregresspolyMatrix, other : MlregresspolyMatrix) -> MlregresspolyMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = ml_regress_poly_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn MlregresspolyMatrix::scale(self : MlregresspolyMatrix, s : Double) -> MlregresspolyMatrix {
  let result = ml_regress_poly_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn MlregresspolyMatrix::multiply(self : MlregresspolyMatrix, other : MlregresspolyMatrix) -> MlregresspolyMatrix {
  if self.cols != other.rows { return ml_regress_poly_make_matrix(self.rows, other.cols, 0.0) }
  let result = ml_regress_poly_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn MlregresspolyMatrix::trace(self : MlregresspolyMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn MlregresspolyMatrix::det(self : MlregresspolyMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn MlregresspolyMatrix::norm(self : MlregresspolyMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn MlregresspolyMatrix::to_string(self : MlregresspolyMatrix) -> String {
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

pub(all) struct MlregresspolyVector {
  comps : Array[Double]
  dim : Int
}

pub fn ml_regress_poly_make_vector(comps : Array[Double]) -> MlregresspolyVector {
  { comps, dim: comps.length() }
}

pub fn ml_regress_poly_vector_zero(dim : Int) -> MlregresspolyVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn MlregresspolyVector::add(self : MlregresspolyVector, other : MlregresspolyVector) -> MlregresspolyVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn MlregresspolyVector::sub(self : MlregresspolyVector, other : MlregresspolyVector) -> MlregresspolyVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn MlregresspolyVector::scale(self : MlregresspolyVector, s : Double) -> MlregresspolyVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn MlregresspolyVector::dot(self : MlregresspolyVector, other : MlregresspolyVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn MlregresspolyVector::norm(self : MlregresspolyVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn MlregresspolyVector::normalize(self : MlregresspolyVector) -> MlregresspolyVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn MlregresspolyVector::dist(self : MlregresspolyVector, other : MlregresspolyVector) -> Double {
  self.sub(other).norm()
}

pub fn MlregresspolyVector::to_string(self : MlregresspolyVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn ml_regress_poly_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn ml_regress_poly_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn ml_regress_poly_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn ml_regress_poly_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn ml_regress_poly_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn ml_regress_poly_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn ml_regress_poly_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn ml_regress_poly_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn ml_regress_poly_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn ml_regress_poly_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn ml_regress_poly_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn ml_regress_poly_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn ml_regress_poly_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn ml_regress_poly_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn ml_regress_poly_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn ml_regress_poly_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn ml_regress_poly_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn ml_regress_poly_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn ml_regress_poly_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn ml_regress_poly_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn ml_regress_poly_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn ml_regress_poly_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn ml_regress_poly_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn ml_regress_poly_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn ml_regress_poly_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn ml_regress_poly_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn ml_regress_poly_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn ml_regress_poly_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn ml_regress_poly_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct MlregresspolyFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_regress_poly_frame_make(size : Int) -> MlregresspolyFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_regress_poly_frame_len(s : MlregresspolyFrame) -> Int { s.size }

pub fn ml_regress_poly_frame_get(s : MlregresspolyFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_regress_poly_frame_set(s : MlregresspolyFrame, i : Int, v : Double) -> MlregresspolyFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_regress_poly_frame_sum(s : MlregresspolyFrame) -> Double { @_common.sum(s.data) }

pub fn ml_regress_poly_frame_mean(s : MlregresspolyFrame) -> Double { @_common.mean(s.data) }

pub fn ml_regress_poly_frame_scale(s : MlregresspolyFrame, f : Double) -> MlregresspolyFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_regress_poly_frame_add(a : MlregresspolyFrame, b : MlregresspolyFrame) -> MlregresspolyFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_regress_poly_frame_copy(s : MlregresspolyFrame) -> MlregresspolyFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_regress_poly_frame_fill(s : MlregresspolyFrame, v : Double) -> MlregresspolyFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_regress_poly_frame_min(s : MlregresspolyFrame) -> Double { @_common.min(s.data) }

pub fn ml_regress_poly_frame_max(s : MlregresspolyFrame) -> Double { @_common.max(s.data) }

pub fn ml_regress_poly_frame_to_string(s : MlregresspolyFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlregresspolyTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_regress_poly_table_make(size : Int) -> MlregresspolyTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_regress_poly_table_len(s : MlregresspolyTable) -> Int { s.size }

pub fn ml_regress_poly_table_get(s : MlregresspolyTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_regress_poly_table_set(s : MlregresspolyTable, i : Int, v : Double) -> MlregresspolyTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_regress_poly_table_sum(s : MlregresspolyTable) -> Double { @_common.sum(s.data) }

pub fn ml_regress_poly_table_mean(s : MlregresspolyTable) -> Double { @_common.mean(s.data) }

pub fn ml_regress_poly_table_scale(s : MlregresspolyTable, f : Double) -> MlregresspolyTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_regress_poly_table_add(a : MlregresspolyTable, b : MlregresspolyTable) -> MlregresspolyTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_regress_poly_table_copy(s : MlregresspolyTable) -> MlregresspolyTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_regress_poly_table_fill(s : MlregresspolyTable, v : Double) -> MlregresspolyTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_regress_poly_table_min(s : MlregresspolyTable) -> Double { @_common.min(s.data) }

pub fn ml_regress_poly_table_max(s : MlregresspolyTable) -> Double { @_common.max(s.data) }

pub fn ml_regress_poly_table_to_string(s : MlregresspolyTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlregresspolyGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_regress_poly_graphn_make(size : Int) -> MlregresspolyGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_regress_poly_graphn_len(s : MlregresspolyGraphN) -> Int { s.size }

pub fn ml_regress_poly_graphn_get(s : MlregresspolyGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_regress_poly_graphn_set(s : MlregresspolyGraphN, i : Int, v : Double) -> MlregresspolyGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_regress_poly_graphn_sum(s : MlregresspolyGraphN) -> Double { @_common.sum(s.data) }

pub fn ml_regress_poly_graphn_mean(s : MlregresspolyGraphN) -> Double { @_common.mean(s.data) }

pub fn ml_regress_poly_graphn_scale(s : MlregresspolyGraphN, f : Double) -> MlregresspolyGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_regress_poly_graphn_add(a : MlregresspolyGraphN, b : MlregresspolyGraphN) -> MlregresspolyGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_regress_poly_graphn_copy(s : MlregresspolyGraphN) -> MlregresspolyGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_regress_poly_graphn_fill(s : MlregresspolyGraphN, v : Double) -> MlregresspolyGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_regress_poly_graphn_min(s : MlregresspolyGraphN) -> Double { @_common.min(s.data) }

pub fn ml_regress_poly_graphn_max(s : MlregresspolyGraphN) -> Double { @_common.max(s.data) }

pub fn ml_regress_poly_graphn_to_string(s : MlregresspolyGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlregresspolyNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_regress_poly_node_make(size : Int) -> MlregresspolyNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_regress_poly_node_len(s : MlregresspolyNode) -> Int { s.size }

pub fn ml_regress_poly_node_get(s : MlregresspolyNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_regress_poly_node_set(s : MlregresspolyNode, i : Int, v : Double) -> MlregresspolyNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_regress_poly_node_sum(s : MlregresspolyNode) -> Double { @_common.sum(s.data) }

pub fn ml_regress_poly_node_mean(s : MlregresspolyNode) -> Double { @_common.mean(s.data) }

pub fn ml_regress_poly_node_scale(s : MlregresspolyNode, f : Double) -> MlregresspolyNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_regress_poly_node_add(a : MlregresspolyNode, b : MlregresspolyNode) -> MlregresspolyNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_regress_poly_node_copy(s : MlregresspolyNode) -> MlregresspolyNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_regress_poly_node_fill(s : MlregresspolyNode, v : Double) -> MlregresspolyNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_regress_poly_node_min(s : MlregresspolyNode) -> Double { @_common.min(s.data) }

pub fn ml_regress_poly_node_max(s : MlregresspolyNode) -> Double { @_common.max(s.data) }

pub fn ml_regress_poly_node_to_string(s : MlregresspolyNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlregresspolyEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_regress_poly_edge_make(size : Int) -> MlregresspolyEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_regress_poly_edge_len(s : MlregresspolyEdge) -> Int { s.size }

pub fn ml_regress_poly_edge_get(s : MlregresspolyEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_regress_poly_edge_set(s : MlregresspolyEdge, i : Int, v : Double) -> MlregresspolyEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_regress_poly_edge_sum(s : MlregresspolyEdge) -> Double { @_common.sum(s.data) }

pub fn ml_regress_poly_edge_mean(s : MlregresspolyEdge) -> Double { @_common.mean(s.data) }

pub fn ml_regress_poly_edge_scale(s : MlregresspolyEdge, f : Double) -> MlregresspolyEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_regress_poly_edge_add(a : MlregresspolyEdge, b : MlregresspolyEdge) -> MlregresspolyEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_regress_poly_edge_copy(s : MlregresspolyEdge) -> MlregresspolyEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_regress_poly_edge_fill(s : MlregresspolyEdge, v : Double) -> MlregresspolyEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_regress_poly_edge_min(s : MlregresspolyEdge) -> Double { @_common.min(s.data) }

pub fn ml_regress_poly_edge_max(s : MlregresspolyEdge) -> Double { @_common.max(s.data) }

pub fn ml_regress_poly_edge_to_string(s : MlregresspolyEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlregresspolyPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_regress_poly_path_make(size : Int) -> MlregresspolyPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_regress_poly_path_len(s : MlregresspolyPath) -> Int { s.size }

pub fn ml_regress_poly_path_get(s : MlregresspolyPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_regress_poly_path_set(s : MlregresspolyPath, i : Int, v : Double) -> MlregresspolyPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_regress_poly_path_sum(s : MlregresspolyPath) -> Double { @_common.sum(s.data) }

pub fn ml_regress_poly_path_mean(s : MlregresspolyPath) -> Double { @_common.mean(s.data) }

pub fn ml_regress_poly_path_scale(s : MlregresspolyPath, f : Double) -> MlregresspolyPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_regress_poly_path_add(a : MlregresspolyPath, b : MlregresspolyPath) -> MlregresspolyPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_regress_poly_path_copy(s : MlregresspolyPath) -> MlregresspolyPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_regress_poly_path_fill(s : MlregresspolyPath, v : Double) -> MlregresspolyPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_regress_poly_path_min(s : MlregresspolyPath) -> Double { @_common.min(s.data) }

pub fn ml_regress_poly_path_max(s : MlregresspolyPath) -> Double { @_common.max(s.data) }

pub fn ml_regress_poly_path_to_string(s : MlregresspolyPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlregresspolyCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_regress_poly_cluster_make(size : Int) -> MlregresspolyCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_regress_poly_cluster_len(s : MlregresspolyCluster) -> Int { s.size }

pub fn ml_regress_poly_cluster_get(s : MlregresspolyCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_regress_poly_cluster_set(s : MlregresspolyCluster, i : Int, v : Double) -> MlregresspolyCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_regress_poly_cluster_sum(s : MlregresspolyCluster) -> Double { @_common.sum(s.data) }

pub fn ml_regress_poly_cluster_mean(s : MlregresspolyCluster) -> Double { @_common.mean(s.data) }

pub fn ml_regress_poly_cluster_scale(s : MlregresspolyCluster, f : Double) -> MlregresspolyCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_regress_poly_cluster_add(a : MlregresspolyCluster, b : MlregresspolyCluster) -> MlregresspolyCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_regress_poly_cluster_copy(s : MlregresspolyCluster) -> MlregresspolyCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_regress_poly_cluster_fill(s : MlregresspolyCluster, v : Double) -> MlregresspolyCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_regress_poly_cluster_min(s : MlregresspolyCluster) -> Double { @_common.min(s.data) }

pub fn ml_regress_poly_cluster_max(s : MlregresspolyCluster) -> Double { @_common.max(s.data) }

pub fn ml_regress_poly_cluster_to_string(s : MlregresspolyCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlregresspolyModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_regress_poly_model_make(size : Int) -> MlregresspolyModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_regress_poly_model_len(s : MlregresspolyModel) -> Int { s.size }

pub fn ml_regress_poly_model_get(s : MlregresspolyModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_regress_poly_model_set(s : MlregresspolyModel, i : Int, v : Double) -> MlregresspolyModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_regress_poly_model_sum(s : MlregresspolyModel) -> Double { @_common.sum(s.data) }

pub fn ml_regress_poly_model_mean(s : MlregresspolyModel) -> Double { @_common.mean(s.data) }

pub fn ml_regress_poly_model_scale(s : MlregresspolyModel, f : Double) -> MlregresspolyModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_regress_poly_model_add(a : MlregresspolyModel, b : MlregresspolyModel) -> MlregresspolyModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_regress_poly_model_copy(s : MlregresspolyModel) -> MlregresspolyModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_regress_poly_model_fill(s : MlregresspolyModel, v : Double) -> MlregresspolyModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_regress_poly_model_min(s : MlregresspolyModel) -> Double { @_common.min(s.data) }

pub fn ml_regress_poly_model_max(s : MlregresspolyModel) -> Double { @_common.max(s.data) }

pub fn ml_regress_poly_model_to_string(s : MlregresspolyModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlregresspolyLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_regress_poly_layer_make(size : Int) -> MlregresspolyLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_regress_poly_layer_len(s : MlregresspolyLayer) -> Int { s.size }

pub fn ml_regress_poly_layer_get(s : MlregresspolyLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_regress_poly_layer_set(s : MlregresspolyLayer, i : Int, v : Double) -> MlregresspolyLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_regress_poly_layer_sum(s : MlregresspolyLayer) -> Double { @_common.sum(s.data) }

pub fn ml_regress_poly_layer_mean(s : MlregresspolyLayer) -> Double { @_common.mean(s.data) }

pub fn ml_regress_poly_layer_scale(s : MlregresspolyLayer, f : Double) -> MlregresspolyLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_regress_poly_layer_add(a : MlregresspolyLayer, b : MlregresspolyLayer) -> MlregresspolyLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_regress_poly_layer_copy(s : MlregresspolyLayer) -> MlregresspolyLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_regress_poly_layer_fill(s : MlregresspolyLayer, v : Double) -> MlregresspolyLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_regress_poly_layer_min(s : MlregresspolyLayer) -> Double { @_common.min(s.data) }

pub fn ml_regress_poly_layer_max(s : MlregresspolyLayer) -> Double { @_common.max(s.data) }

pub fn ml_regress_poly_layer_to_string(s : MlregresspolyLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlregresspolyBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_regress_poly_buffer_make(size : Int) -> MlregresspolyBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_regress_poly_buffer_len(s : MlregresspolyBuffer) -> Int { s.size }

pub fn ml_regress_poly_buffer_get(s : MlregresspolyBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_regress_poly_buffer_set(s : MlregresspolyBuffer, i : Int, v : Double) -> MlregresspolyBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_regress_poly_buffer_sum(s : MlregresspolyBuffer) -> Double { @_common.sum(s.data) }

pub fn ml_regress_poly_buffer_mean(s : MlregresspolyBuffer) -> Double { @_common.mean(s.data) }

pub fn ml_regress_poly_buffer_scale(s : MlregresspolyBuffer, f : Double) -> MlregresspolyBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_regress_poly_buffer_add(a : MlregresspolyBuffer, b : MlregresspolyBuffer) -> MlregresspolyBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_regress_poly_buffer_copy(s : MlregresspolyBuffer) -> MlregresspolyBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_regress_poly_buffer_fill(s : MlregresspolyBuffer, v : Double) -> MlregresspolyBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_regress_poly_buffer_min(s : MlregresspolyBuffer) -> Double { @_common.min(s.data) }

pub fn ml_regress_poly_buffer_max(s : MlregresspolyBuffer) -> Double { @_common.max(s.data) }

pub fn ml_regress_poly_buffer_to_string(s : MlregresspolyBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlregresspolyCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_regress_poly_cursor_make(size : Int) -> MlregresspolyCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_regress_poly_cursor_len(s : MlregresspolyCursor) -> Int { s.size }

pub fn ml_regress_poly_cursor_get(s : MlregresspolyCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_regress_poly_cursor_set(s : MlregresspolyCursor, i : Int, v : Double) -> MlregresspolyCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_regress_poly_cursor_sum(s : MlregresspolyCursor) -> Double { @_common.sum(s.data) }

pub fn ml_regress_poly_cursor_mean(s : MlregresspolyCursor) -> Double { @_common.mean(s.data) }

pub fn ml_regress_poly_cursor_scale(s : MlregresspolyCursor, f : Double) -> MlregresspolyCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_regress_poly_cursor_add(a : MlregresspolyCursor, b : MlregresspolyCursor) -> MlregresspolyCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_regress_poly_cursor_copy(s : MlregresspolyCursor) -> MlregresspolyCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_regress_poly_cursor_fill(s : MlregresspolyCursor, v : Double) -> MlregresspolyCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_regress_poly_cursor_min(s : MlregresspolyCursor) -> Double { @_common.min(s.data) }

pub fn ml_regress_poly_cursor_max(s : MlregresspolyCursor) -> Double { @_common.max(s.data) }

pub fn ml_regress_poly_cursor_to_string(s : MlregresspolyCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlregresspolyView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_regress_poly_view_make(size : Int) -> MlregresspolyView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_regress_poly_view_len(s : MlregresspolyView) -> Int { s.size }

pub fn ml_regress_poly_view_get(s : MlregresspolyView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_regress_poly_view_set(s : MlregresspolyView, i : Int, v : Double) -> MlregresspolyView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_regress_poly_view_sum(s : MlregresspolyView) -> Double { @_common.sum(s.data) }

pub fn ml_regress_poly_view_mean(s : MlregresspolyView) -> Double { @_common.mean(s.data) }

pub fn ml_regress_poly_view_scale(s : MlregresspolyView, f : Double) -> MlregresspolyView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_regress_poly_view_add(a : MlregresspolyView, b : MlregresspolyView) -> MlregresspolyView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_regress_poly_view_copy(s : MlregresspolyView) -> MlregresspolyView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_regress_poly_view_fill(s : MlregresspolyView, v : Double) -> MlregresspolyView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_regress_poly_view_min(s : MlregresspolyView) -> Double { @_common.min(s.data) }

pub fn ml_regress_poly_view_max(s : MlregresspolyView) -> Double { @_common.max(s.data) }

pub fn ml_regress_poly_view_to_string(s : MlregresspolyView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlregresspolyRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_regress_poly_range_make(size : Int) -> MlregresspolyRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_regress_poly_range_len(s : MlregresspolyRange) -> Int { s.size }

pub fn ml_regress_poly_range_get(s : MlregresspolyRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_regress_poly_range_set(s : MlregresspolyRange, i : Int, v : Double) -> MlregresspolyRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_regress_poly_range_sum(s : MlregresspolyRange) -> Double { @_common.sum(s.data) }

pub fn ml_regress_poly_range_mean(s : MlregresspolyRange) -> Double { @_common.mean(s.data) }

pub fn ml_regress_poly_range_scale(s : MlregresspolyRange, f : Double) -> MlregresspolyRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_regress_poly_range_add(a : MlregresspolyRange, b : MlregresspolyRange) -> MlregresspolyRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_regress_poly_range_copy(s : MlregresspolyRange) -> MlregresspolyRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_regress_poly_range_fill(s : MlregresspolyRange, v : Double) -> MlregresspolyRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_regress_poly_range_min(s : MlregresspolyRange) -> Double { @_common.min(s.data) }

pub fn ml_regress_poly_range_max(s : MlregresspolyRange) -> Double { @_common.max(s.data) }

pub fn ml_regress_poly_range_to_string(s : MlregresspolyRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlregresspolySlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_regress_poly_slice_make(size : Int) -> MlregresspolySlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_regress_poly_slice_len(s : MlregresspolySlice) -> Int { s.size }

pub fn ml_regress_poly_slice_get(s : MlregresspolySlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_regress_poly_slice_set(s : MlregresspolySlice, i : Int, v : Double) -> MlregresspolySlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_regress_poly_slice_sum(s : MlregresspolySlice) -> Double { @_common.sum(s.data) }

pub fn ml_regress_poly_slice_mean(s : MlregresspolySlice) -> Double { @_common.mean(s.data) }

pub fn ml_regress_poly_slice_scale(s : MlregresspolySlice, f : Double) -> MlregresspolySlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_regress_poly_slice_add(a : MlregresspolySlice, b : MlregresspolySlice) -> MlregresspolySlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_regress_poly_slice_copy(s : MlregresspolySlice) -> MlregresspolySlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_regress_poly_slice_fill(s : MlregresspolySlice, v : Double) -> MlregresspolySlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_regress_poly_slice_min(s : MlregresspolySlice) -> Double { @_common.min(s.data) }

pub fn ml_regress_poly_slice_max(s : MlregresspolySlice) -> Double { @_common.max(s.data) }

pub fn ml_regress_poly_slice_to_string(s : MlregresspolySlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

