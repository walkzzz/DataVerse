///===
/// extcore/math_cholesky

pub(all) struct MathcholeskyPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn math_cholesky_make_point(x : Double, y : Double) -> MathcholeskyPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn math_cholesky_make_point3(x : Double, y : Double, z : Double) -> MathcholeskyPoint {
  { x, y, z, label: 0 }
}

pub fn MathcholeskyPoint::x(self : MathcholeskyPoint) -> Double { self.x }

pub fn MathcholeskyPoint::y(self : MathcholeskyPoint) -> Double { self.y }

pub fn MathcholeskyPoint::z(self : MathcholeskyPoint) -> Double { self.z }

pub fn MathcholeskyPoint::label(self : MathcholeskyPoint) -> Int { self.label }

pub fn MathcholeskyPoint::dist(self : MathcholeskyPoint, other : MathcholeskyPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn MathcholeskyPoint::add(self : MathcholeskyPoint, other : MathcholeskyPoint) -> MathcholeskyPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn MathcholeskyPoint::sub(self : MathcholeskyPoint, other : MathcholeskyPoint) -> MathcholeskyPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn MathcholeskyPoint::scale(self : MathcholeskyPoint, s : Double) -> MathcholeskyPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn MathcholeskyPoint::dot(self : MathcholeskyPoint, other : MathcholeskyPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn MathcholeskyPoint::cross(self : MathcholeskyPoint, other : MathcholeskyPoint) -> MathcholeskyPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn MathcholeskyPoint::norm(self : MathcholeskyPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn MathcholeskyPoint::normalize(self : MathcholeskyPoint) -> MathcholeskyPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn MathcholeskyPoint::negate(self : MathcholeskyPoint) -> MathcholeskyPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn MathcholeskyPoint::mid(self : MathcholeskyPoint, other : MathcholeskyPoint) -> MathcholeskyPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn MathcholeskyPoint::lerp(self : MathcholeskyPoint, other : MathcholeskyPoint, t : Double) -> MathcholeskyPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn MathcholeskyPoint::to_string(self : MathcholeskyPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct MathcholeskySeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn math_cholesky_make_series(vals : Array[Double], name : String) -> MathcholeskySeries {
  { vals, name, meta: 0 }
}

pub fn MathcholeskySeries::len(self : MathcholeskySeries) -> Int { self.vals.length() }

pub fn MathcholeskySeries::sum(self : MathcholeskySeries) -> Double { @_common.sum(self.vals) }

pub fn MathcholeskySeries::mean(self : MathcholeskySeries) -> Double { @_common.mean(self.vals) }

pub fn MathcholeskySeries::min(self : MathcholeskySeries) -> Double { @_common.min(self.vals) }

pub fn MathcholeskySeries::max(self : MathcholeskySeries) -> Double { @_common.max(self.vals) }

pub fn MathcholeskySeries::range(self : MathcholeskySeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn MathcholeskySeries::variance(self : MathcholeskySeries) -> Double { @_common.variance(self.vals) }

pub fn MathcholeskySeries::std(self : MathcholeskySeries) -> Double { @_common.std(self.vals) }

pub fn MathcholeskySeries::median(self : MathcholeskySeries) -> Double { @_common.median(self.vals) }

pub fn MathcholeskySeries::scale(self : MathcholeskySeries, f : Double) -> MathcholeskySeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn MathcholeskySeries::add(self : MathcholeskySeries, other : MathcholeskySeries) -> MathcholeskySeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn MathcholeskySeries::sub(self : MathcholeskySeries, other : MathcholeskySeries) -> MathcholeskySeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn MathcholeskySeries::normalize(self : MathcholeskySeries) -> MathcholeskySeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn MathcholeskySeries::cumsum(self : MathcholeskySeries) -> MathcholeskySeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn MathcholeskySeries::to_string(self : MathcholeskySeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct MathcholeskyMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn math_cholesky_make_matrix(rows : Int, cols : Int, val : Double) -> MathcholeskyMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn math_cholesky_matrix_identity(n : Int) -> MathcholeskyMatrix {
  let m = math_cholesky_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn MathcholeskyMatrix::get(self : MathcholeskyMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn MathcholeskyMatrix::transpose(self : MathcholeskyMatrix) -> MathcholeskyMatrix {
  let result = math_cholesky_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn MathcholeskyMatrix::add(self : MathcholeskyMatrix, other : MathcholeskyMatrix) -> MathcholeskyMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = math_cholesky_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn MathcholeskyMatrix::scale(self : MathcholeskyMatrix, s : Double) -> MathcholeskyMatrix {
  let result = math_cholesky_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn MathcholeskyMatrix::multiply(self : MathcholeskyMatrix, other : MathcholeskyMatrix) -> MathcholeskyMatrix {
  if self.cols != other.rows { return math_cholesky_make_matrix(self.rows, other.cols, 0.0) }
  let result = math_cholesky_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn MathcholeskyMatrix::trace(self : MathcholeskyMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn MathcholeskyMatrix::det(self : MathcholeskyMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn MathcholeskyMatrix::norm(self : MathcholeskyMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn MathcholeskyMatrix::to_string(self : MathcholeskyMatrix) -> String {
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

pub(all) struct MathcholeskyVector {
  comps : Array[Double]
  dim : Int
}

pub fn math_cholesky_make_vector(comps : Array[Double]) -> MathcholeskyVector {
  { comps, dim: comps.length() }
}

pub fn math_cholesky_vector_zero(dim : Int) -> MathcholeskyVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn MathcholeskyVector::add(self : MathcholeskyVector, other : MathcholeskyVector) -> MathcholeskyVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn MathcholeskyVector::sub(self : MathcholeskyVector, other : MathcholeskyVector) -> MathcholeskyVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn MathcholeskyVector::scale(self : MathcholeskyVector, s : Double) -> MathcholeskyVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn MathcholeskyVector::dot(self : MathcholeskyVector, other : MathcholeskyVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn MathcholeskyVector::norm(self : MathcholeskyVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn MathcholeskyVector::normalize(self : MathcholeskyVector) -> MathcholeskyVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn MathcholeskyVector::dist(self : MathcholeskyVector, other : MathcholeskyVector) -> Double {
  self.sub(other).norm()
}

pub fn MathcholeskyVector::to_string(self : MathcholeskyVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn math_cholesky_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn math_cholesky_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn math_cholesky_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn math_cholesky_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn math_cholesky_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn math_cholesky_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn math_cholesky_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn math_cholesky_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn math_cholesky_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn math_cholesky_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn math_cholesky_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn math_cholesky_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn math_cholesky_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn math_cholesky_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn math_cholesky_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn math_cholesky_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn math_cholesky_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn math_cholesky_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn math_cholesky_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn math_cholesky_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn math_cholesky_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn math_cholesky_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn math_cholesky_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn math_cholesky_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn math_cholesky_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn math_cholesky_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn math_cholesky_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn math_cholesky_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn math_cholesky_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct MathcholeskyFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_cholesky_frame_make(size : Int) -> MathcholeskyFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_cholesky_frame_len(s : MathcholeskyFrame) -> Int { s.size }

pub fn math_cholesky_frame_get(s : MathcholeskyFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_cholesky_frame_set(s : MathcholeskyFrame, i : Int, v : Double) -> MathcholeskyFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_cholesky_frame_sum(s : MathcholeskyFrame) -> Double { @_common.sum(s.data) }

pub fn math_cholesky_frame_mean(s : MathcholeskyFrame) -> Double { @_common.mean(s.data) }

pub fn math_cholesky_frame_scale(s : MathcholeskyFrame, f : Double) -> MathcholeskyFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_cholesky_frame_add(a : MathcholeskyFrame, b : MathcholeskyFrame) -> MathcholeskyFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_cholesky_frame_copy(s : MathcholeskyFrame) -> MathcholeskyFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_cholesky_frame_fill(s : MathcholeskyFrame, v : Double) -> MathcholeskyFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_cholesky_frame_min(s : MathcholeskyFrame) -> Double { @_common.min(s.data) }

pub fn math_cholesky_frame_max(s : MathcholeskyFrame) -> Double { @_common.max(s.data) }

pub fn math_cholesky_frame_to_string(s : MathcholeskyFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathcholeskyTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_cholesky_table_make(size : Int) -> MathcholeskyTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_cholesky_table_len(s : MathcholeskyTable) -> Int { s.size }

pub fn math_cholesky_table_get(s : MathcholeskyTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_cholesky_table_set(s : MathcholeskyTable, i : Int, v : Double) -> MathcholeskyTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_cholesky_table_sum(s : MathcholeskyTable) -> Double { @_common.sum(s.data) }

pub fn math_cholesky_table_mean(s : MathcholeskyTable) -> Double { @_common.mean(s.data) }

pub fn math_cholesky_table_scale(s : MathcholeskyTable, f : Double) -> MathcholeskyTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_cholesky_table_add(a : MathcholeskyTable, b : MathcholeskyTable) -> MathcholeskyTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_cholesky_table_copy(s : MathcholeskyTable) -> MathcholeskyTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_cholesky_table_fill(s : MathcholeskyTable, v : Double) -> MathcholeskyTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_cholesky_table_min(s : MathcholeskyTable) -> Double { @_common.min(s.data) }

pub fn math_cholesky_table_max(s : MathcholeskyTable) -> Double { @_common.max(s.data) }

pub fn math_cholesky_table_to_string(s : MathcholeskyTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathcholeskyGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_cholesky_graphn_make(size : Int) -> MathcholeskyGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_cholesky_graphn_len(s : MathcholeskyGraphN) -> Int { s.size }

pub fn math_cholesky_graphn_get(s : MathcholeskyGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_cholesky_graphn_set(s : MathcholeskyGraphN, i : Int, v : Double) -> MathcholeskyGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_cholesky_graphn_sum(s : MathcholeskyGraphN) -> Double { @_common.sum(s.data) }

pub fn math_cholesky_graphn_mean(s : MathcholeskyGraphN) -> Double { @_common.mean(s.data) }

pub fn math_cholesky_graphn_scale(s : MathcholeskyGraphN, f : Double) -> MathcholeskyGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_cholesky_graphn_add(a : MathcholeskyGraphN, b : MathcholeskyGraphN) -> MathcholeskyGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_cholesky_graphn_copy(s : MathcholeskyGraphN) -> MathcholeskyGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_cholesky_graphn_fill(s : MathcholeskyGraphN, v : Double) -> MathcholeskyGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_cholesky_graphn_min(s : MathcholeskyGraphN) -> Double { @_common.min(s.data) }

pub fn math_cholesky_graphn_max(s : MathcholeskyGraphN) -> Double { @_common.max(s.data) }

pub fn math_cholesky_graphn_to_string(s : MathcholeskyGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathcholeskyNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_cholesky_node_make(size : Int) -> MathcholeskyNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_cholesky_node_len(s : MathcholeskyNode) -> Int { s.size }

pub fn math_cholesky_node_get(s : MathcholeskyNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_cholesky_node_set(s : MathcholeskyNode, i : Int, v : Double) -> MathcholeskyNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_cholesky_node_sum(s : MathcholeskyNode) -> Double { @_common.sum(s.data) }

pub fn math_cholesky_node_mean(s : MathcholeskyNode) -> Double { @_common.mean(s.data) }

pub fn math_cholesky_node_scale(s : MathcholeskyNode, f : Double) -> MathcholeskyNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_cholesky_node_add(a : MathcholeskyNode, b : MathcholeskyNode) -> MathcholeskyNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_cholesky_node_copy(s : MathcholeskyNode) -> MathcholeskyNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_cholesky_node_fill(s : MathcholeskyNode, v : Double) -> MathcholeskyNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_cholesky_node_min(s : MathcholeskyNode) -> Double { @_common.min(s.data) }

pub fn math_cholesky_node_max(s : MathcholeskyNode) -> Double { @_common.max(s.data) }

pub fn math_cholesky_node_to_string(s : MathcholeskyNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathcholeskyEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_cholesky_edge_make(size : Int) -> MathcholeskyEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_cholesky_edge_len(s : MathcholeskyEdge) -> Int { s.size }

pub fn math_cholesky_edge_get(s : MathcholeskyEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_cholesky_edge_set(s : MathcholeskyEdge, i : Int, v : Double) -> MathcholeskyEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_cholesky_edge_sum(s : MathcholeskyEdge) -> Double { @_common.sum(s.data) }

pub fn math_cholesky_edge_mean(s : MathcholeskyEdge) -> Double { @_common.mean(s.data) }

pub fn math_cholesky_edge_scale(s : MathcholeskyEdge, f : Double) -> MathcholeskyEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_cholesky_edge_add(a : MathcholeskyEdge, b : MathcholeskyEdge) -> MathcholeskyEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_cholesky_edge_copy(s : MathcholeskyEdge) -> MathcholeskyEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_cholesky_edge_fill(s : MathcholeskyEdge, v : Double) -> MathcholeskyEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_cholesky_edge_min(s : MathcholeskyEdge) -> Double { @_common.min(s.data) }

pub fn math_cholesky_edge_max(s : MathcholeskyEdge) -> Double { @_common.max(s.data) }

pub fn math_cholesky_edge_to_string(s : MathcholeskyEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathcholeskyPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_cholesky_path_make(size : Int) -> MathcholeskyPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_cholesky_path_len(s : MathcholeskyPath) -> Int { s.size }

pub fn math_cholesky_path_get(s : MathcholeskyPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_cholesky_path_set(s : MathcholeskyPath, i : Int, v : Double) -> MathcholeskyPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_cholesky_path_sum(s : MathcholeskyPath) -> Double { @_common.sum(s.data) }

pub fn math_cholesky_path_mean(s : MathcholeskyPath) -> Double { @_common.mean(s.data) }

pub fn math_cholesky_path_scale(s : MathcholeskyPath, f : Double) -> MathcholeskyPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_cholesky_path_add(a : MathcholeskyPath, b : MathcholeskyPath) -> MathcholeskyPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_cholesky_path_copy(s : MathcholeskyPath) -> MathcholeskyPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_cholesky_path_fill(s : MathcholeskyPath, v : Double) -> MathcholeskyPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_cholesky_path_min(s : MathcholeskyPath) -> Double { @_common.min(s.data) }

pub fn math_cholesky_path_max(s : MathcholeskyPath) -> Double { @_common.max(s.data) }

pub fn math_cholesky_path_to_string(s : MathcholeskyPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathcholeskyCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_cholesky_cluster_make(size : Int) -> MathcholeskyCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_cholesky_cluster_len(s : MathcholeskyCluster) -> Int { s.size }

pub fn math_cholesky_cluster_get(s : MathcholeskyCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_cholesky_cluster_set(s : MathcholeskyCluster, i : Int, v : Double) -> MathcholeskyCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_cholesky_cluster_sum(s : MathcholeskyCluster) -> Double { @_common.sum(s.data) }

pub fn math_cholesky_cluster_mean(s : MathcholeskyCluster) -> Double { @_common.mean(s.data) }

pub fn math_cholesky_cluster_scale(s : MathcholeskyCluster, f : Double) -> MathcholeskyCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_cholesky_cluster_add(a : MathcholeskyCluster, b : MathcholeskyCluster) -> MathcholeskyCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_cholesky_cluster_copy(s : MathcholeskyCluster) -> MathcholeskyCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_cholesky_cluster_fill(s : MathcholeskyCluster, v : Double) -> MathcholeskyCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_cholesky_cluster_min(s : MathcholeskyCluster) -> Double { @_common.min(s.data) }

pub fn math_cholesky_cluster_max(s : MathcholeskyCluster) -> Double { @_common.max(s.data) }

pub fn math_cholesky_cluster_to_string(s : MathcholeskyCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathcholeskyModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_cholesky_model_make(size : Int) -> MathcholeskyModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_cholesky_model_len(s : MathcholeskyModel) -> Int { s.size }

pub fn math_cholesky_model_get(s : MathcholeskyModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_cholesky_model_set(s : MathcholeskyModel, i : Int, v : Double) -> MathcholeskyModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_cholesky_model_sum(s : MathcholeskyModel) -> Double { @_common.sum(s.data) }

pub fn math_cholesky_model_mean(s : MathcholeskyModel) -> Double { @_common.mean(s.data) }

pub fn math_cholesky_model_scale(s : MathcholeskyModel, f : Double) -> MathcholeskyModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_cholesky_model_add(a : MathcholeskyModel, b : MathcholeskyModel) -> MathcholeskyModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_cholesky_model_copy(s : MathcholeskyModel) -> MathcholeskyModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_cholesky_model_fill(s : MathcholeskyModel, v : Double) -> MathcholeskyModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_cholesky_model_min(s : MathcholeskyModel) -> Double { @_common.min(s.data) }

pub fn math_cholesky_model_max(s : MathcholeskyModel) -> Double { @_common.max(s.data) }

pub fn math_cholesky_model_to_string(s : MathcholeskyModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathcholeskyLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_cholesky_layer_make(size : Int) -> MathcholeskyLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_cholesky_layer_len(s : MathcholeskyLayer) -> Int { s.size }

pub fn math_cholesky_layer_get(s : MathcholeskyLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_cholesky_layer_set(s : MathcholeskyLayer, i : Int, v : Double) -> MathcholeskyLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_cholesky_layer_sum(s : MathcholeskyLayer) -> Double { @_common.sum(s.data) }

pub fn math_cholesky_layer_mean(s : MathcholeskyLayer) -> Double { @_common.mean(s.data) }

pub fn math_cholesky_layer_scale(s : MathcholeskyLayer, f : Double) -> MathcholeskyLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_cholesky_layer_add(a : MathcholeskyLayer, b : MathcholeskyLayer) -> MathcholeskyLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_cholesky_layer_copy(s : MathcholeskyLayer) -> MathcholeskyLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_cholesky_layer_fill(s : MathcholeskyLayer, v : Double) -> MathcholeskyLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_cholesky_layer_min(s : MathcholeskyLayer) -> Double { @_common.min(s.data) }

pub fn math_cholesky_layer_max(s : MathcholeskyLayer) -> Double { @_common.max(s.data) }

pub fn math_cholesky_layer_to_string(s : MathcholeskyLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathcholeskyBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_cholesky_buffer_make(size : Int) -> MathcholeskyBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_cholesky_buffer_len(s : MathcholeskyBuffer) -> Int { s.size }

pub fn math_cholesky_buffer_get(s : MathcholeskyBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_cholesky_buffer_set(s : MathcholeskyBuffer, i : Int, v : Double) -> MathcholeskyBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_cholesky_buffer_sum(s : MathcholeskyBuffer) -> Double { @_common.sum(s.data) }

pub fn math_cholesky_buffer_mean(s : MathcholeskyBuffer) -> Double { @_common.mean(s.data) }

pub fn math_cholesky_buffer_scale(s : MathcholeskyBuffer, f : Double) -> MathcholeskyBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_cholesky_buffer_add(a : MathcholeskyBuffer, b : MathcholeskyBuffer) -> MathcholeskyBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_cholesky_buffer_copy(s : MathcholeskyBuffer) -> MathcholeskyBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_cholesky_buffer_fill(s : MathcholeskyBuffer, v : Double) -> MathcholeskyBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_cholesky_buffer_min(s : MathcholeskyBuffer) -> Double { @_common.min(s.data) }

pub fn math_cholesky_buffer_max(s : MathcholeskyBuffer) -> Double { @_common.max(s.data) }

pub fn math_cholesky_buffer_to_string(s : MathcholeskyBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathcholeskyCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_cholesky_cursor_make(size : Int) -> MathcholeskyCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_cholesky_cursor_len(s : MathcholeskyCursor) -> Int { s.size }

pub fn math_cholesky_cursor_get(s : MathcholeskyCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_cholesky_cursor_set(s : MathcholeskyCursor, i : Int, v : Double) -> MathcholeskyCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_cholesky_cursor_sum(s : MathcholeskyCursor) -> Double { @_common.sum(s.data) }

pub fn math_cholesky_cursor_mean(s : MathcholeskyCursor) -> Double { @_common.mean(s.data) }

pub fn math_cholesky_cursor_scale(s : MathcholeskyCursor, f : Double) -> MathcholeskyCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_cholesky_cursor_add(a : MathcholeskyCursor, b : MathcholeskyCursor) -> MathcholeskyCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_cholesky_cursor_copy(s : MathcholeskyCursor) -> MathcholeskyCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_cholesky_cursor_fill(s : MathcholeskyCursor, v : Double) -> MathcholeskyCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_cholesky_cursor_min(s : MathcholeskyCursor) -> Double { @_common.min(s.data) }

pub fn math_cholesky_cursor_max(s : MathcholeskyCursor) -> Double { @_common.max(s.data) }

pub fn math_cholesky_cursor_to_string(s : MathcholeskyCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathcholeskyView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_cholesky_view_make(size : Int) -> MathcholeskyView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_cholesky_view_len(s : MathcholeskyView) -> Int { s.size }

pub fn math_cholesky_view_get(s : MathcholeskyView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_cholesky_view_set(s : MathcholeskyView, i : Int, v : Double) -> MathcholeskyView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_cholesky_view_sum(s : MathcholeskyView) -> Double { @_common.sum(s.data) }

pub fn math_cholesky_view_mean(s : MathcholeskyView) -> Double { @_common.mean(s.data) }

pub fn math_cholesky_view_scale(s : MathcholeskyView, f : Double) -> MathcholeskyView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_cholesky_view_add(a : MathcholeskyView, b : MathcholeskyView) -> MathcholeskyView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_cholesky_view_copy(s : MathcholeskyView) -> MathcholeskyView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_cholesky_view_fill(s : MathcholeskyView, v : Double) -> MathcholeskyView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_cholesky_view_min(s : MathcholeskyView) -> Double { @_common.min(s.data) }

pub fn math_cholesky_view_max(s : MathcholeskyView) -> Double { @_common.max(s.data) }

pub fn math_cholesky_view_to_string(s : MathcholeskyView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathcholeskyRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_cholesky_range_make(size : Int) -> MathcholeskyRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_cholesky_range_len(s : MathcholeskyRange) -> Int { s.size }

pub fn math_cholesky_range_get(s : MathcholeskyRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_cholesky_range_set(s : MathcholeskyRange, i : Int, v : Double) -> MathcholeskyRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_cholesky_range_sum(s : MathcholeskyRange) -> Double { @_common.sum(s.data) }

pub fn math_cholesky_range_mean(s : MathcholeskyRange) -> Double { @_common.mean(s.data) }

pub fn math_cholesky_range_scale(s : MathcholeskyRange, f : Double) -> MathcholeskyRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_cholesky_range_add(a : MathcholeskyRange, b : MathcholeskyRange) -> MathcholeskyRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_cholesky_range_copy(s : MathcholeskyRange) -> MathcholeskyRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_cholesky_range_fill(s : MathcholeskyRange, v : Double) -> MathcholeskyRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_cholesky_range_min(s : MathcholeskyRange) -> Double { @_common.min(s.data) }

pub fn math_cholesky_range_max(s : MathcholeskyRange) -> Double { @_common.max(s.data) }

pub fn math_cholesky_range_to_string(s : MathcholeskyRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathcholeskySlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_cholesky_slice_make(size : Int) -> MathcholeskySlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_cholesky_slice_len(s : MathcholeskySlice) -> Int { s.size }

pub fn math_cholesky_slice_get(s : MathcholeskySlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_cholesky_slice_set(s : MathcholeskySlice, i : Int, v : Double) -> MathcholeskySlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_cholesky_slice_sum(s : MathcholeskySlice) -> Double { @_common.sum(s.data) }

pub fn math_cholesky_slice_mean(s : MathcholeskySlice) -> Double { @_common.mean(s.data) }

pub fn math_cholesky_slice_scale(s : MathcholeskySlice, f : Double) -> MathcholeskySlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_cholesky_slice_add(a : MathcholeskySlice, b : MathcholeskySlice) -> MathcholeskySlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_cholesky_slice_copy(s : MathcholeskySlice) -> MathcholeskySlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_cholesky_slice_fill(s : MathcholeskySlice, v : Double) -> MathcholeskySlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_cholesky_slice_min(s : MathcholeskySlice) -> Double { @_common.min(s.data) }

pub fn math_cholesky_slice_max(s : MathcholeskySlice) -> Double { @_common.max(s.data) }

pub fn math_cholesky_slice_to_string(s : MathcholeskySlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

