///===
/// extcore/math_special_hermite

pub(all) struct MathspecialhermitePoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn math_special_hermite_make_point(x : Double, y : Double) -> MathspecialhermitePoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn math_special_hermite_make_point3(x : Double, y : Double, z : Double) -> MathspecialhermitePoint {
  { x, y, z, label: 0 }
}

pub fn MathspecialhermitePoint::x(self : MathspecialhermitePoint) -> Double { self.x }

pub fn MathspecialhermitePoint::y(self : MathspecialhermitePoint) -> Double { self.y }

pub fn MathspecialhermitePoint::z(self : MathspecialhermitePoint) -> Double { self.z }

pub fn MathspecialhermitePoint::label(self : MathspecialhermitePoint) -> Int { self.label }

pub fn MathspecialhermitePoint::dist(self : MathspecialhermitePoint, other : MathspecialhermitePoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn MathspecialhermitePoint::add(self : MathspecialhermitePoint, other : MathspecialhermitePoint) -> MathspecialhermitePoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn MathspecialhermitePoint::sub(self : MathspecialhermitePoint, other : MathspecialhermitePoint) -> MathspecialhermitePoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn MathspecialhermitePoint::scale(self : MathspecialhermitePoint, s : Double) -> MathspecialhermitePoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn MathspecialhermitePoint::dot(self : MathspecialhermitePoint, other : MathspecialhermitePoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn MathspecialhermitePoint::cross(self : MathspecialhermitePoint, other : MathspecialhermitePoint) -> MathspecialhermitePoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn MathspecialhermitePoint::norm(self : MathspecialhermitePoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn MathspecialhermitePoint::normalize(self : MathspecialhermitePoint) -> MathspecialhermitePoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn MathspecialhermitePoint::negate(self : MathspecialhermitePoint) -> MathspecialhermitePoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn MathspecialhermitePoint::mid(self : MathspecialhermitePoint, other : MathspecialhermitePoint) -> MathspecialhermitePoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn MathspecialhermitePoint::lerp(self : MathspecialhermitePoint, other : MathspecialhermitePoint, t : Double) -> MathspecialhermitePoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn MathspecialhermitePoint::to_string(self : MathspecialhermitePoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct MathspecialhermiteSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn math_special_hermite_make_series(vals : Array[Double], name : String) -> MathspecialhermiteSeries {
  { vals, name, meta: 0 }
}

pub fn MathspecialhermiteSeries::len(self : MathspecialhermiteSeries) -> Int { self.vals.length() }

pub fn MathspecialhermiteSeries::sum(self : MathspecialhermiteSeries) -> Double { @_common.sum(self.vals) }

pub fn MathspecialhermiteSeries::mean(self : MathspecialhermiteSeries) -> Double { @_common.mean(self.vals) }

pub fn MathspecialhermiteSeries::min(self : MathspecialhermiteSeries) -> Double { @_common.min(self.vals) }

pub fn MathspecialhermiteSeries::max(self : MathspecialhermiteSeries) -> Double { @_common.max(self.vals) }

pub fn MathspecialhermiteSeries::range(self : MathspecialhermiteSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn MathspecialhermiteSeries::variance(self : MathspecialhermiteSeries) -> Double { @_common.variance(self.vals) }

pub fn MathspecialhermiteSeries::std(self : MathspecialhermiteSeries) -> Double { @_common.std(self.vals) }

pub fn MathspecialhermiteSeries::median(self : MathspecialhermiteSeries) -> Double { @_common.median(self.vals) }

pub fn MathspecialhermiteSeries::scale(self : MathspecialhermiteSeries, f : Double) -> MathspecialhermiteSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn MathspecialhermiteSeries::add(self : MathspecialhermiteSeries, other : MathspecialhermiteSeries) -> MathspecialhermiteSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn MathspecialhermiteSeries::sub(self : MathspecialhermiteSeries, other : MathspecialhermiteSeries) -> MathspecialhermiteSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn MathspecialhermiteSeries::normalize(self : MathspecialhermiteSeries) -> MathspecialhermiteSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn MathspecialhermiteSeries::cumsum(self : MathspecialhermiteSeries) -> MathspecialhermiteSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn MathspecialhermiteSeries::to_string(self : MathspecialhermiteSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct MathspecialhermiteMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn math_special_hermite_make_matrix(rows : Int, cols : Int, val : Double) -> MathspecialhermiteMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn math_special_hermite_matrix_identity(n : Int) -> MathspecialhermiteMatrix {
  let m = math_special_hermite_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn MathspecialhermiteMatrix::get(self : MathspecialhermiteMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn MathspecialhermiteMatrix::transpose(self : MathspecialhermiteMatrix) -> MathspecialhermiteMatrix {
  let result = math_special_hermite_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn MathspecialhermiteMatrix::add(self : MathspecialhermiteMatrix, other : MathspecialhermiteMatrix) -> MathspecialhermiteMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = math_special_hermite_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn MathspecialhermiteMatrix::scale(self : MathspecialhermiteMatrix, s : Double) -> MathspecialhermiteMatrix {
  let result = math_special_hermite_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn MathspecialhermiteMatrix::multiply(self : MathspecialhermiteMatrix, other : MathspecialhermiteMatrix) -> MathspecialhermiteMatrix {
  if self.cols != other.rows { return math_special_hermite_make_matrix(self.rows, other.cols, 0.0) }
  let result = math_special_hermite_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn MathspecialhermiteMatrix::trace(self : MathspecialhermiteMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn MathspecialhermiteMatrix::det(self : MathspecialhermiteMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn MathspecialhermiteMatrix::norm(self : MathspecialhermiteMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn MathspecialhermiteMatrix::to_string(self : MathspecialhermiteMatrix) -> String {
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

pub(all) struct MathspecialhermiteVector {
  comps : Array[Double]
  dim : Int
}

pub fn math_special_hermite_make_vector(comps : Array[Double]) -> MathspecialhermiteVector {
  { comps, dim: comps.length() }
}

pub fn math_special_hermite_vector_zero(dim : Int) -> MathspecialhermiteVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn MathspecialhermiteVector::add(self : MathspecialhermiteVector, other : MathspecialhermiteVector) -> MathspecialhermiteVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn MathspecialhermiteVector::sub(self : MathspecialhermiteVector, other : MathspecialhermiteVector) -> MathspecialhermiteVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn MathspecialhermiteVector::scale(self : MathspecialhermiteVector, s : Double) -> MathspecialhermiteVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn MathspecialhermiteVector::dot(self : MathspecialhermiteVector, other : MathspecialhermiteVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn MathspecialhermiteVector::norm(self : MathspecialhermiteVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn MathspecialhermiteVector::normalize(self : MathspecialhermiteVector) -> MathspecialhermiteVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn MathspecialhermiteVector::dist(self : MathspecialhermiteVector, other : MathspecialhermiteVector) -> Double {
  self.sub(other).norm()
}

pub fn MathspecialhermiteVector::to_string(self : MathspecialhermiteVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn math_special_hermite_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn math_special_hermite_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn math_special_hermite_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn math_special_hermite_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn math_special_hermite_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn math_special_hermite_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn math_special_hermite_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn math_special_hermite_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn math_special_hermite_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn math_special_hermite_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn math_special_hermite_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn math_special_hermite_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn math_special_hermite_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn math_special_hermite_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn math_special_hermite_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn math_special_hermite_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn math_special_hermite_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn math_special_hermite_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn math_special_hermite_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn math_special_hermite_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn math_special_hermite_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn math_special_hermite_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn math_special_hermite_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn math_special_hermite_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn math_special_hermite_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn math_special_hermite_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn math_special_hermite_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn math_special_hermite_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn math_special_hermite_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct MathspecialhermiteFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_special_hermite_frame_make(size : Int) -> MathspecialhermiteFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_special_hermite_frame_len(s : MathspecialhermiteFrame) -> Int { s.size }

pub fn math_special_hermite_frame_get(s : MathspecialhermiteFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_special_hermite_frame_set(s : MathspecialhermiteFrame, i : Int, v : Double) -> MathspecialhermiteFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_special_hermite_frame_sum(s : MathspecialhermiteFrame) -> Double { @_common.sum(s.data) }

pub fn math_special_hermite_frame_mean(s : MathspecialhermiteFrame) -> Double { @_common.mean(s.data) }

pub fn math_special_hermite_frame_scale(s : MathspecialhermiteFrame, f : Double) -> MathspecialhermiteFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_special_hermite_frame_add(a : MathspecialhermiteFrame, b : MathspecialhermiteFrame) -> MathspecialhermiteFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_special_hermite_frame_copy(s : MathspecialhermiteFrame) -> MathspecialhermiteFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_special_hermite_frame_fill(s : MathspecialhermiteFrame, v : Double) -> MathspecialhermiteFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_special_hermite_frame_min(s : MathspecialhermiteFrame) -> Double { @_common.min(s.data) }

pub fn math_special_hermite_frame_max(s : MathspecialhermiteFrame) -> Double { @_common.max(s.data) }

pub fn math_special_hermite_frame_to_string(s : MathspecialhermiteFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathspecialhermiteTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_special_hermite_table_make(size : Int) -> MathspecialhermiteTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_special_hermite_table_len(s : MathspecialhermiteTable) -> Int { s.size }

pub fn math_special_hermite_table_get(s : MathspecialhermiteTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_special_hermite_table_set(s : MathspecialhermiteTable, i : Int, v : Double) -> MathspecialhermiteTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_special_hermite_table_sum(s : MathspecialhermiteTable) -> Double { @_common.sum(s.data) }

pub fn math_special_hermite_table_mean(s : MathspecialhermiteTable) -> Double { @_common.mean(s.data) }

pub fn math_special_hermite_table_scale(s : MathspecialhermiteTable, f : Double) -> MathspecialhermiteTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_special_hermite_table_add(a : MathspecialhermiteTable, b : MathspecialhermiteTable) -> MathspecialhermiteTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_special_hermite_table_copy(s : MathspecialhermiteTable) -> MathspecialhermiteTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_special_hermite_table_fill(s : MathspecialhermiteTable, v : Double) -> MathspecialhermiteTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_special_hermite_table_min(s : MathspecialhermiteTable) -> Double { @_common.min(s.data) }

pub fn math_special_hermite_table_max(s : MathspecialhermiteTable) -> Double { @_common.max(s.data) }

pub fn math_special_hermite_table_to_string(s : MathspecialhermiteTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathspecialhermiteGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_special_hermite_graphn_make(size : Int) -> MathspecialhermiteGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_special_hermite_graphn_len(s : MathspecialhermiteGraphN) -> Int { s.size }

pub fn math_special_hermite_graphn_get(s : MathspecialhermiteGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_special_hermite_graphn_set(s : MathspecialhermiteGraphN, i : Int, v : Double) -> MathspecialhermiteGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_special_hermite_graphn_sum(s : MathspecialhermiteGraphN) -> Double { @_common.sum(s.data) }

pub fn math_special_hermite_graphn_mean(s : MathspecialhermiteGraphN) -> Double { @_common.mean(s.data) }

pub fn math_special_hermite_graphn_scale(s : MathspecialhermiteGraphN, f : Double) -> MathspecialhermiteGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_special_hermite_graphn_add(a : MathspecialhermiteGraphN, b : MathspecialhermiteGraphN) -> MathspecialhermiteGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_special_hermite_graphn_copy(s : MathspecialhermiteGraphN) -> MathspecialhermiteGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_special_hermite_graphn_fill(s : MathspecialhermiteGraphN, v : Double) -> MathspecialhermiteGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_special_hermite_graphn_min(s : MathspecialhermiteGraphN) -> Double { @_common.min(s.data) }

pub fn math_special_hermite_graphn_max(s : MathspecialhermiteGraphN) -> Double { @_common.max(s.data) }

pub fn math_special_hermite_graphn_to_string(s : MathspecialhermiteGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathspecialhermiteNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_special_hermite_node_make(size : Int) -> MathspecialhermiteNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_special_hermite_node_len(s : MathspecialhermiteNode) -> Int { s.size }

pub fn math_special_hermite_node_get(s : MathspecialhermiteNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_special_hermite_node_set(s : MathspecialhermiteNode, i : Int, v : Double) -> MathspecialhermiteNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_special_hermite_node_sum(s : MathspecialhermiteNode) -> Double { @_common.sum(s.data) }

pub fn math_special_hermite_node_mean(s : MathspecialhermiteNode) -> Double { @_common.mean(s.data) }

pub fn math_special_hermite_node_scale(s : MathspecialhermiteNode, f : Double) -> MathspecialhermiteNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_special_hermite_node_add(a : MathspecialhermiteNode, b : MathspecialhermiteNode) -> MathspecialhermiteNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_special_hermite_node_copy(s : MathspecialhermiteNode) -> MathspecialhermiteNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_special_hermite_node_fill(s : MathspecialhermiteNode, v : Double) -> MathspecialhermiteNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_special_hermite_node_min(s : MathspecialhermiteNode) -> Double { @_common.min(s.data) }

pub fn math_special_hermite_node_max(s : MathspecialhermiteNode) -> Double { @_common.max(s.data) }

pub fn math_special_hermite_node_to_string(s : MathspecialhermiteNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathspecialhermiteEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_special_hermite_edge_make(size : Int) -> MathspecialhermiteEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_special_hermite_edge_len(s : MathspecialhermiteEdge) -> Int { s.size }

pub fn math_special_hermite_edge_get(s : MathspecialhermiteEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_special_hermite_edge_set(s : MathspecialhermiteEdge, i : Int, v : Double) -> MathspecialhermiteEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_special_hermite_edge_sum(s : MathspecialhermiteEdge) -> Double { @_common.sum(s.data) }

pub fn math_special_hermite_edge_mean(s : MathspecialhermiteEdge) -> Double { @_common.mean(s.data) }

pub fn math_special_hermite_edge_scale(s : MathspecialhermiteEdge, f : Double) -> MathspecialhermiteEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_special_hermite_edge_add(a : MathspecialhermiteEdge, b : MathspecialhermiteEdge) -> MathspecialhermiteEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_special_hermite_edge_copy(s : MathspecialhermiteEdge) -> MathspecialhermiteEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_special_hermite_edge_fill(s : MathspecialhermiteEdge, v : Double) -> MathspecialhermiteEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_special_hermite_edge_min(s : MathspecialhermiteEdge) -> Double { @_common.min(s.data) }

pub fn math_special_hermite_edge_max(s : MathspecialhermiteEdge) -> Double { @_common.max(s.data) }

pub fn math_special_hermite_edge_to_string(s : MathspecialhermiteEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathspecialhermitePath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_special_hermite_path_make(size : Int) -> MathspecialhermitePath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_special_hermite_path_len(s : MathspecialhermitePath) -> Int { s.size }

pub fn math_special_hermite_path_get(s : MathspecialhermitePath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_special_hermite_path_set(s : MathspecialhermitePath, i : Int, v : Double) -> MathspecialhermitePath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_special_hermite_path_sum(s : MathspecialhermitePath) -> Double { @_common.sum(s.data) }

pub fn math_special_hermite_path_mean(s : MathspecialhermitePath) -> Double { @_common.mean(s.data) }

pub fn math_special_hermite_path_scale(s : MathspecialhermitePath, f : Double) -> MathspecialhermitePath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_special_hermite_path_add(a : MathspecialhermitePath, b : MathspecialhermitePath) -> MathspecialhermitePath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_special_hermite_path_copy(s : MathspecialhermitePath) -> MathspecialhermitePath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_special_hermite_path_fill(s : MathspecialhermitePath, v : Double) -> MathspecialhermitePath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_special_hermite_path_min(s : MathspecialhermitePath) -> Double { @_common.min(s.data) }

pub fn math_special_hermite_path_max(s : MathspecialhermitePath) -> Double { @_common.max(s.data) }

pub fn math_special_hermite_path_to_string(s : MathspecialhermitePath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathspecialhermiteCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_special_hermite_cluster_make(size : Int) -> MathspecialhermiteCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_special_hermite_cluster_len(s : MathspecialhermiteCluster) -> Int { s.size }

pub fn math_special_hermite_cluster_get(s : MathspecialhermiteCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_special_hermite_cluster_set(s : MathspecialhermiteCluster, i : Int, v : Double) -> MathspecialhermiteCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_special_hermite_cluster_sum(s : MathspecialhermiteCluster) -> Double { @_common.sum(s.data) }

pub fn math_special_hermite_cluster_mean(s : MathspecialhermiteCluster) -> Double { @_common.mean(s.data) }

pub fn math_special_hermite_cluster_scale(s : MathspecialhermiteCluster, f : Double) -> MathspecialhermiteCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_special_hermite_cluster_add(a : MathspecialhermiteCluster, b : MathspecialhermiteCluster) -> MathspecialhermiteCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_special_hermite_cluster_copy(s : MathspecialhermiteCluster) -> MathspecialhermiteCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_special_hermite_cluster_fill(s : MathspecialhermiteCluster, v : Double) -> MathspecialhermiteCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_special_hermite_cluster_min(s : MathspecialhermiteCluster) -> Double { @_common.min(s.data) }

pub fn math_special_hermite_cluster_max(s : MathspecialhermiteCluster) -> Double { @_common.max(s.data) }

pub fn math_special_hermite_cluster_to_string(s : MathspecialhermiteCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathspecialhermiteModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_special_hermite_model_make(size : Int) -> MathspecialhermiteModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_special_hermite_model_len(s : MathspecialhermiteModel) -> Int { s.size }

pub fn math_special_hermite_model_get(s : MathspecialhermiteModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_special_hermite_model_set(s : MathspecialhermiteModel, i : Int, v : Double) -> MathspecialhermiteModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_special_hermite_model_sum(s : MathspecialhermiteModel) -> Double { @_common.sum(s.data) }

pub fn math_special_hermite_model_mean(s : MathspecialhermiteModel) -> Double { @_common.mean(s.data) }

pub fn math_special_hermite_model_scale(s : MathspecialhermiteModel, f : Double) -> MathspecialhermiteModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_special_hermite_model_add(a : MathspecialhermiteModel, b : MathspecialhermiteModel) -> MathspecialhermiteModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_special_hermite_model_copy(s : MathspecialhermiteModel) -> MathspecialhermiteModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_special_hermite_model_fill(s : MathspecialhermiteModel, v : Double) -> MathspecialhermiteModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_special_hermite_model_min(s : MathspecialhermiteModel) -> Double { @_common.min(s.data) }

pub fn math_special_hermite_model_max(s : MathspecialhermiteModel) -> Double { @_common.max(s.data) }

pub fn math_special_hermite_model_to_string(s : MathspecialhermiteModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathspecialhermiteLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_special_hermite_layer_make(size : Int) -> MathspecialhermiteLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_special_hermite_layer_len(s : MathspecialhermiteLayer) -> Int { s.size }

pub fn math_special_hermite_layer_get(s : MathspecialhermiteLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_special_hermite_layer_set(s : MathspecialhermiteLayer, i : Int, v : Double) -> MathspecialhermiteLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_special_hermite_layer_sum(s : MathspecialhermiteLayer) -> Double { @_common.sum(s.data) }

pub fn math_special_hermite_layer_mean(s : MathspecialhermiteLayer) -> Double { @_common.mean(s.data) }

pub fn math_special_hermite_layer_scale(s : MathspecialhermiteLayer, f : Double) -> MathspecialhermiteLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_special_hermite_layer_add(a : MathspecialhermiteLayer, b : MathspecialhermiteLayer) -> MathspecialhermiteLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_special_hermite_layer_copy(s : MathspecialhermiteLayer) -> MathspecialhermiteLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_special_hermite_layer_fill(s : MathspecialhermiteLayer, v : Double) -> MathspecialhermiteLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_special_hermite_layer_min(s : MathspecialhermiteLayer) -> Double { @_common.min(s.data) }

pub fn math_special_hermite_layer_max(s : MathspecialhermiteLayer) -> Double { @_common.max(s.data) }

pub fn math_special_hermite_layer_to_string(s : MathspecialhermiteLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathspecialhermiteBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_special_hermite_buffer_make(size : Int) -> MathspecialhermiteBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_special_hermite_buffer_len(s : MathspecialhermiteBuffer) -> Int { s.size }

pub fn math_special_hermite_buffer_get(s : MathspecialhermiteBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_special_hermite_buffer_set(s : MathspecialhermiteBuffer, i : Int, v : Double) -> MathspecialhermiteBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_special_hermite_buffer_sum(s : MathspecialhermiteBuffer) -> Double { @_common.sum(s.data) }

pub fn math_special_hermite_buffer_mean(s : MathspecialhermiteBuffer) -> Double { @_common.mean(s.data) }

pub fn math_special_hermite_buffer_scale(s : MathspecialhermiteBuffer, f : Double) -> MathspecialhermiteBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_special_hermite_buffer_add(a : MathspecialhermiteBuffer, b : MathspecialhermiteBuffer) -> MathspecialhermiteBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_special_hermite_buffer_copy(s : MathspecialhermiteBuffer) -> MathspecialhermiteBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_special_hermite_buffer_fill(s : MathspecialhermiteBuffer, v : Double) -> MathspecialhermiteBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_special_hermite_buffer_min(s : MathspecialhermiteBuffer) -> Double { @_common.min(s.data) }

pub fn math_special_hermite_buffer_max(s : MathspecialhermiteBuffer) -> Double { @_common.max(s.data) }

pub fn math_special_hermite_buffer_to_string(s : MathspecialhermiteBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathspecialhermiteCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_special_hermite_cursor_make(size : Int) -> MathspecialhermiteCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_special_hermite_cursor_len(s : MathspecialhermiteCursor) -> Int { s.size }

pub fn math_special_hermite_cursor_get(s : MathspecialhermiteCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_special_hermite_cursor_set(s : MathspecialhermiteCursor, i : Int, v : Double) -> MathspecialhermiteCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_special_hermite_cursor_sum(s : MathspecialhermiteCursor) -> Double { @_common.sum(s.data) }

pub fn math_special_hermite_cursor_mean(s : MathspecialhermiteCursor) -> Double { @_common.mean(s.data) }

pub fn math_special_hermite_cursor_scale(s : MathspecialhermiteCursor, f : Double) -> MathspecialhermiteCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_special_hermite_cursor_add(a : MathspecialhermiteCursor, b : MathspecialhermiteCursor) -> MathspecialhermiteCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_special_hermite_cursor_copy(s : MathspecialhermiteCursor) -> MathspecialhermiteCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_special_hermite_cursor_fill(s : MathspecialhermiteCursor, v : Double) -> MathspecialhermiteCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_special_hermite_cursor_min(s : MathspecialhermiteCursor) -> Double { @_common.min(s.data) }

pub fn math_special_hermite_cursor_max(s : MathspecialhermiteCursor) -> Double { @_common.max(s.data) }

pub fn math_special_hermite_cursor_to_string(s : MathspecialhermiteCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathspecialhermiteView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_special_hermite_view_make(size : Int) -> MathspecialhermiteView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_special_hermite_view_len(s : MathspecialhermiteView) -> Int { s.size }

pub fn math_special_hermite_view_get(s : MathspecialhermiteView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_special_hermite_view_set(s : MathspecialhermiteView, i : Int, v : Double) -> MathspecialhermiteView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_special_hermite_view_sum(s : MathspecialhermiteView) -> Double { @_common.sum(s.data) }

pub fn math_special_hermite_view_mean(s : MathspecialhermiteView) -> Double { @_common.mean(s.data) }

pub fn math_special_hermite_view_scale(s : MathspecialhermiteView, f : Double) -> MathspecialhermiteView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_special_hermite_view_add(a : MathspecialhermiteView, b : MathspecialhermiteView) -> MathspecialhermiteView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_special_hermite_view_copy(s : MathspecialhermiteView) -> MathspecialhermiteView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_special_hermite_view_fill(s : MathspecialhermiteView, v : Double) -> MathspecialhermiteView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_special_hermite_view_min(s : MathspecialhermiteView) -> Double { @_common.min(s.data) }

pub fn math_special_hermite_view_max(s : MathspecialhermiteView) -> Double { @_common.max(s.data) }

pub fn math_special_hermite_view_to_string(s : MathspecialhermiteView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathspecialhermiteRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_special_hermite_range_make(size : Int) -> MathspecialhermiteRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_special_hermite_range_len(s : MathspecialhermiteRange) -> Int { s.size }

pub fn math_special_hermite_range_get(s : MathspecialhermiteRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_special_hermite_range_set(s : MathspecialhermiteRange, i : Int, v : Double) -> MathspecialhermiteRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_special_hermite_range_sum(s : MathspecialhermiteRange) -> Double { @_common.sum(s.data) }

pub fn math_special_hermite_range_mean(s : MathspecialhermiteRange) -> Double { @_common.mean(s.data) }

pub fn math_special_hermite_range_scale(s : MathspecialhermiteRange, f : Double) -> MathspecialhermiteRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_special_hermite_range_add(a : MathspecialhermiteRange, b : MathspecialhermiteRange) -> MathspecialhermiteRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_special_hermite_range_copy(s : MathspecialhermiteRange) -> MathspecialhermiteRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_special_hermite_range_fill(s : MathspecialhermiteRange, v : Double) -> MathspecialhermiteRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_special_hermite_range_min(s : MathspecialhermiteRange) -> Double { @_common.min(s.data) }

pub fn math_special_hermite_range_max(s : MathspecialhermiteRange) -> Double { @_common.max(s.data) }

pub fn math_special_hermite_range_to_string(s : MathspecialhermiteRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathspecialhermiteSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_special_hermite_slice_make(size : Int) -> MathspecialhermiteSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_special_hermite_slice_len(s : MathspecialhermiteSlice) -> Int { s.size }

pub fn math_special_hermite_slice_get(s : MathspecialhermiteSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_special_hermite_slice_set(s : MathspecialhermiteSlice, i : Int, v : Double) -> MathspecialhermiteSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_special_hermite_slice_sum(s : MathspecialhermiteSlice) -> Double { @_common.sum(s.data) }

pub fn math_special_hermite_slice_mean(s : MathspecialhermiteSlice) -> Double { @_common.mean(s.data) }

pub fn math_special_hermite_slice_scale(s : MathspecialhermiteSlice, f : Double) -> MathspecialhermiteSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_special_hermite_slice_add(a : MathspecialhermiteSlice, b : MathspecialhermiteSlice) -> MathspecialhermiteSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_special_hermite_slice_copy(s : MathspecialhermiteSlice) -> MathspecialhermiteSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_special_hermite_slice_fill(s : MathspecialhermiteSlice, v : Double) -> MathspecialhermiteSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_special_hermite_slice_min(s : MathspecialhermiteSlice) -> Double { @_common.min(s.data) }

pub fn math_special_hermite_slice_max(s : MathspecialhermiteSlice) -> Double { @_common.max(s.data) }

pub fn math_special_hermite_slice_to_string(s : MathspecialhermiteSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

