///===
/// extcore/math_special_bessel

pub(all) struct MathspecialbesselPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn math_special_bessel_make_point(x : Double, y : Double) -> MathspecialbesselPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn math_special_bessel_make_point3(x : Double, y : Double, z : Double) -> MathspecialbesselPoint {
  { x, y, z, label: 0 }
}

pub fn MathspecialbesselPoint::x(self : MathspecialbesselPoint) -> Double { self.x }

pub fn MathspecialbesselPoint::y(self : MathspecialbesselPoint) -> Double { self.y }

pub fn MathspecialbesselPoint::z(self : MathspecialbesselPoint) -> Double { self.z }

pub fn MathspecialbesselPoint::label(self : MathspecialbesselPoint) -> Int { self.label }

pub fn MathspecialbesselPoint::dist(self : MathspecialbesselPoint, other : MathspecialbesselPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn MathspecialbesselPoint::add(self : MathspecialbesselPoint, other : MathspecialbesselPoint) -> MathspecialbesselPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn MathspecialbesselPoint::sub(self : MathspecialbesselPoint, other : MathspecialbesselPoint) -> MathspecialbesselPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn MathspecialbesselPoint::scale(self : MathspecialbesselPoint, s : Double) -> MathspecialbesselPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn MathspecialbesselPoint::dot(self : MathspecialbesselPoint, other : MathspecialbesselPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn MathspecialbesselPoint::cross(self : MathspecialbesselPoint, other : MathspecialbesselPoint) -> MathspecialbesselPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn MathspecialbesselPoint::norm(self : MathspecialbesselPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn MathspecialbesselPoint::normalize(self : MathspecialbesselPoint) -> MathspecialbesselPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn MathspecialbesselPoint::negate(self : MathspecialbesselPoint) -> MathspecialbesselPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn MathspecialbesselPoint::mid(self : MathspecialbesselPoint, other : MathspecialbesselPoint) -> MathspecialbesselPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn MathspecialbesselPoint::lerp(self : MathspecialbesselPoint, other : MathspecialbesselPoint, t : Double) -> MathspecialbesselPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn MathspecialbesselPoint::to_string(self : MathspecialbesselPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct MathspecialbesselSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn math_special_bessel_make_series(vals : Array[Double], name : String) -> MathspecialbesselSeries {
  { vals, name, meta: 0 }
}

pub fn MathspecialbesselSeries::len(self : MathspecialbesselSeries) -> Int { self.vals.length() }

pub fn MathspecialbesselSeries::sum(self : MathspecialbesselSeries) -> Double { @_common.sum(self.vals) }

pub fn MathspecialbesselSeries::mean(self : MathspecialbesselSeries) -> Double { @_common.mean(self.vals) }

pub fn MathspecialbesselSeries::min(self : MathspecialbesselSeries) -> Double { @_common.min(self.vals) }

pub fn MathspecialbesselSeries::max(self : MathspecialbesselSeries) -> Double { @_common.max(self.vals) }

pub fn MathspecialbesselSeries::range(self : MathspecialbesselSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn MathspecialbesselSeries::variance(self : MathspecialbesselSeries) -> Double { @_common.variance(self.vals) }

pub fn MathspecialbesselSeries::std(self : MathspecialbesselSeries) -> Double { @_common.std(self.vals) }

pub fn MathspecialbesselSeries::median(self : MathspecialbesselSeries) -> Double { @_common.median(self.vals) }

pub fn MathspecialbesselSeries::scale(self : MathspecialbesselSeries, f : Double) -> MathspecialbesselSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn MathspecialbesselSeries::add(self : MathspecialbesselSeries, other : MathspecialbesselSeries) -> MathspecialbesselSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn MathspecialbesselSeries::sub(self : MathspecialbesselSeries, other : MathspecialbesselSeries) -> MathspecialbesselSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn MathspecialbesselSeries::normalize(self : MathspecialbesselSeries) -> MathspecialbesselSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn MathspecialbesselSeries::cumsum(self : MathspecialbesselSeries) -> MathspecialbesselSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn MathspecialbesselSeries::to_string(self : MathspecialbesselSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct MathspecialbesselMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn math_special_bessel_make_matrix(rows : Int, cols : Int, val : Double) -> MathspecialbesselMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn math_special_bessel_matrix_identity(n : Int) -> MathspecialbesselMatrix {
  let m = math_special_bessel_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn MathspecialbesselMatrix::get(self : MathspecialbesselMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn MathspecialbesselMatrix::transpose(self : MathspecialbesselMatrix) -> MathspecialbesselMatrix {
  let result = math_special_bessel_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn MathspecialbesselMatrix::add(self : MathspecialbesselMatrix, other : MathspecialbesselMatrix) -> MathspecialbesselMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = math_special_bessel_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn MathspecialbesselMatrix::scale(self : MathspecialbesselMatrix, s : Double) -> MathspecialbesselMatrix {
  let result = math_special_bessel_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn MathspecialbesselMatrix::multiply(self : MathspecialbesselMatrix, other : MathspecialbesselMatrix) -> MathspecialbesselMatrix {
  if self.cols != other.rows { return math_special_bessel_make_matrix(self.rows, other.cols, 0.0) }
  let result = math_special_bessel_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn MathspecialbesselMatrix::trace(self : MathspecialbesselMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn MathspecialbesselMatrix::det(self : MathspecialbesselMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn MathspecialbesselMatrix::norm(self : MathspecialbesselMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn MathspecialbesselMatrix::to_string(self : MathspecialbesselMatrix) -> String {
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

pub(all) struct MathspecialbesselVector {
  comps : Array[Double]
  dim : Int
}

pub fn math_special_bessel_make_vector(comps : Array[Double]) -> MathspecialbesselVector {
  { comps, dim: comps.length() }
}

pub fn math_special_bessel_vector_zero(dim : Int) -> MathspecialbesselVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn MathspecialbesselVector::add(self : MathspecialbesselVector, other : MathspecialbesselVector) -> MathspecialbesselVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn MathspecialbesselVector::sub(self : MathspecialbesselVector, other : MathspecialbesselVector) -> MathspecialbesselVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn MathspecialbesselVector::scale(self : MathspecialbesselVector, s : Double) -> MathspecialbesselVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn MathspecialbesselVector::dot(self : MathspecialbesselVector, other : MathspecialbesselVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn MathspecialbesselVector::norm(self : MathspecialbesselVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn MathspecialbesselVector::normalize(self : MathspecialbesselVector) -> MathspecialbesselVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn MathspecialbesselVector::dist(self : MathspecialbesselVector, other : MathspecialbesselVector) -> Double {
  self.sub(other).norm()
}

pub fn MathspecialbesselVector::to_string(self : MathspecialbesselVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn math_special_bessel_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn math_special_bessel_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn math_special_bessel_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn math_special_bessel_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn math_special_bessel_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn math_special_bessel_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn math_special_bessel_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn math_special_bessel_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn math_special_bessel_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn math_special_bessel_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn math_special_bessel_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn math_special_bessel_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn math_special_bessel_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn math_special_bessel_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn math_special_bessel_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn math_special_bessel_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn math_special_bessel_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn math_special_bessel_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn math_special_bessel_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn math_special_bessel_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn math_special_bessel_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn math_special_bessel_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn math_special_bessel_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn math_special_bessel_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn math_special_bessel_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn math_special_bessel_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn math_special_bessel_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn math_special_bessel_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn math_special_bessel_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct MathspecialbesselFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_special_bessel_frame_make(size : Int) -> MathspecialbesselFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_special_bessel_frame_len(s : MathspecialbesselFrame) -> Int { s.size }

pub fn math_special_bessel_frame_get(s : MathspecialbesselFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_special_bessel_frame_set(s : MathspecialbesselFrame, i : Int, v : Double) -> MathspecialbesselFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_special_bessel_frame_sum(s : MathspecialbesselFrame) -> Double { @_common.sum(s.data) }

pub fn math_special_bessel_frame_mean(s : MathspecialbesselFrame) -> Double { @_common.mean(s.data) }

pub fn math_special_bessel_frame_scale(s : MathspecialbesselFrame, f : Double) -> MathspecialbesselFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_special_bessel_frame_add(a : MathspecialbesselFrame, b : MathspecialbesselFrame) -> MathspecialbesselFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_special_bessel_frame_copy(s : MathspecialbesselFrame) -> MathspecialbesselFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_special_bessel_frame_fill(s : MathspecialbesselFrame, v : Double) -> MathspecialbesselFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_special_bessel_frame_min(s : MathspecialbesselFrame) -> Double { @_common.min(s.data) }

pub fn math_special_bessel_frame_max(s : MathspecialbesselFrame) -> Double { @_common.max(s.data) }

pub fn math_special_bessel_frame_to_string(s : MathspecialbesselFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathspecialbesselTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_special_bessel_table_make(size : Int) -> MathspecialbesselTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_special_bessel_table_len(s : MathspecialbesselTable) -> Int { s.size }

pub fn math_special_bessel_table_get(s : MathspecialbesselTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_special_bessel_table_set(s : MathspecialbesselTable, i : Int, v : Double) -> MathspecialbesselTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_special_bessel_table_sum(s : MathspecialbesselTable) -> Double { @_common.sum(s.data) }

pub fn math_special_bessel_table_mean(s : MathspecialbesselTable) -> Double { @_common.mean(s.data) }

pub fn math_special_bessel_table_scale(s : MathspecialbesselTable, f : Double) -> MathspecialbesselTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_special_bessel_table_add(a : MathspecialbesselTable, b : MathspecialbesselTable) -> MathspecialbesselTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_special_bessel_table_copy(s : MathspecialbesselTable) -> MathspecialbesselTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_special_bessel_table_fill(s : MathspecialbesselTable, v : Double) -> MathspecialbesselTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_special_bessel_table_min(s : MathspecialbesselTable) -> Double { @_common.min(s.data) }

pub fn math_special_bessel_table_max(s : MathspecialbesselTable) -> Double { @_common.max(s.data) }

pub fn math_special_bessel_table_to_string(s : MathspecialbesselTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathspecialbesselGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_special_bessel_graphn_make(size : Int) -> MathspecialbesselGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_special_bessel_graphn_len(s : MathspecialbesselGraphN) -> Int { s.size }

pub fn math_special_bessel_graphn_get(s : MathspecialbesselGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_special_bessel_graphn_set(s : MathspecialbesselGraphN, i : Int, v : Double) -> MathspecialbesselGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_special_bessel_graphn_sum(s : MathspecialbesselGraphN) -> Double { @_common.sum(s.data) }

pub fn math_special_bessel_graphn_mean(s : MathspecialbesselGraphN) -> Double { @_common.mean(s.data) }

pub fn math_special_bessel_graphn_scale(s : MathspecialbesselGraphN, f : Double) -> MathspecialbesselGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_special_bessel_graphn_add(a : MathspecialbesselGraphN, b : MathspecialbesselGraphN) -> MathspecialbesselGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_special_bessel_graphn_copy(s : MathspecialbesselGraphN) -> MathspecialbesselGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_special_bessel_graphn_fill(s : MathspecialbesselGraphN, v : Double) -> MathspecialbesselGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_special_bessel_graphn_min(s : MathspecialbesselGraphN) -> Double { @_common.min(s.data) }

pub fn math_special_bessel_graphn_max(s : MathspecialbesselGraphN) -> Double { @_common.max(s.data) }

pub fn math_special_bessel_graphn_to_string(s : MathspecialbesselGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathspecialbesselNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_special_bessel_node_make(size : Int) -> MathspecialbesselNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_special_bessel_node_len(s : MathspecialbesselNode) -> Int { s.size }

pub fn math_special_bessel_node_get(s : MathspecialbesselNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_special_bessel_node_set(s : MathspecialbesselNode, i : Int, v : Double) -> MathspecialbesselNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_special_bessel_node_sum(s : MathspecialbesselNode) -> Double { @_common.sum(s.data) }

pub fn math_special_bessel_node_mean(s : MathspecialbesselNode) -> Double { @_common.mean(s.data) }

pub fn math_special_bessel_node_scale(s : MathspecialbesselNode, f : Double) -> MathspecialbesselNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_special_bessel_node_add(a : MathspecialbesselNode, b : MathspecialbesselNode) -> MathspecialbesselNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_special_bessel_node_copy(s : MathspecialbesselNode) -> MathspecialbesselNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_special_bessel_node_fill(s : MathspecialbesselNode, v : Double) -> MathspecialbesselNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_special_bessel_node_min(s : MathspecialbesselNode) -> Double { @_common.min(s.data) }

pub fn math_special_bessel_node_max(s : MathspecialbesselNode) -> Double { @_common.max(s.data) }

pub fn math_special_bessel_node_to_string(s : MathspecialbesselNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathspecialbesselEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_special_bessel_edge_make(size : Int) -> MathspecialbesselEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_special_bessel_edge_len(s : MathspecialbesselEdge) -> Int { s.size }

pub fn math_special_bessel_edge_get(s : MathspecialbesselEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_special_bessel_edge_set(s : MathspecialbesselEdge, i : Int, v : Double) -> MathspecialbesselEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_special_bessel_edge_sum(s : MathspecialbesselEdge) -> Double { @_common.sum(s.data) }

pub fn math_special_bessel_edge_mean(s : MathspecialbesselEdge) -> Double { @_common.mean(s.data) }

pub fn math_special_bessel_edge_scale(s : MathspecialbesselEdge, f : Double) -> MathspecialbesselEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_special_bessel_edge_add(a : MathspecialbesselEdge, b : MathspecialbesselEdge) -> MathspecialbesselEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_special_bessel_edge_copy(s : MathspecialbesselEdge) -> MathspecialbesselEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_special_bessel_edge_fill(s : MathspecialbesselEdge, v : Double) -> MathspecialbesselEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_special_bessel_edge_min(s : MathspecialbesselEdge) -> Double { @_common.min(s.data) }

pub fn math_special_bessel_edge_max(s : MathspecialbesselEdge) -> Double { @_common.max(s.data) }

pub fn math_special_bessel_edge_to_string(s : MathspecialbesselEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathspecialbesselPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_special_bessel_path_make(size : Int) -> MathspecialbesselPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_special_bessel_path_len(s : MathspecialbesselPath) -> Int { s.size }

pub fn math_special_bessel_path_get(s : MathspecialbesselPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_special_bessel_path_set(s : MathspecialbesselPath, i : Int, v : Double) -> MathspecialbesselPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_special_bessel_path_sum(s : MathspecialbesselPath) -> Double { @_common.sum(s.data) }

pub fn math_special_bessel_path_mean(s : MathspecialbesselPath) -> Double { @_common.mean(s.data) }

pub fn math_special_bessel_path_scale(s : MathspecialbesselPath, f : Double) -> MathspecialbesselPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_special_bessel_path_add(a : MathspecialbesselPath, b : MathspecialbesselPath) -> MathspecialbesselPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_special_bessel_path_copy(s : MathspecialbesselPath) -> MathspecialbesselPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_special_bessel_path_fill(s : MathspecialbesselPath, v : Double) -> MathspecialbesselPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_special_bessel_path_min(s : MathspecialbesselPath) -> Double { @_common.min(s.data) }

pub fn math_special_bessel_path_max(s : MathspecialbesselPath) -> Double { @_common.max(s.data) }

pub fn math_special_bessel_path_to_string(s : MathspecialbesselPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathspecialbesselCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_special_bessel_cluster_make(size : Int) -> MathspecialbesselCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_special_bessel_cluster_len(s : MathspecialbesselCluster) -> Int { s.size }

pub fn math_special_bessel_cluster_get(s : MathspecialbesselCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_special_bessel_cluster_set(s : MathspecialbesselCluster, i : Int, v : Double) -> MathspecialbesselCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_special_bessel_cluster_sum(s : MathspecialbesselCluster) -> Double { @_common.sum(s.data) }

pub fn math_special_bessel_cluster_mean(s : MathspecialbesselCluster) -> Double { @_common.mean(s.data) }

pub fn math_special_bessel_cluster_scale(s : MathspecialbesselCluster, f : Double) -> MathspecialbesselCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_special_bessel_cluster_add(a : MathspecialbesselCluster, b : MathspecialbesselCluster) -> MathspecialbesselCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_special_bessel_cluster_copy(s : MathspecialbesselCluster) -> MathspecialbesselCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_special_bessel_cluster_fill(s : MathspecialbesselCluster, v : Double) -> MathspecialbesselCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_special_bessel_cluster_min(s : MathspecialbesselCluster) -> Double { @_common.min(s.data) }

pub fn math_special_bessel_cluster_max(s : MathspecialbesselCluster) -> Double { @_common.max(s.data) }

pub fn math_special_bessel_cluster_to_string(s : MathspecialbesselCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathspecialbesselModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_special_bessel_model_make(size : Int) -> MathspecialbesselModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_special_bessel_model_len(s : MathspecialbesselModel) -> Int { s.size }

pub fn math_special_bessel_model_get(s : MathspecialbesselModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_special_bessel_model_set(s : MathspecialbesselModel, i : Int, v : Double) -> MathspecialbesselModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_special_bessel_model_sum(s : MathspecialbesselModel) -> Double { @_common.sum(s.data) }

pub fn math_special_bessel_model_mean(s : MathspecialbesselModel) -> Double { @_common.mean(s.data) }

pub fn math_special_bessel_model_scale(s : MathspecialbesselModel, f : Double) -> MathspecialbesselModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_special_bessel_model_add(a : MathspecialbesselModel, b : MathspecialbesselModel) -> MathspecialbesselModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_special_bessel_model_copy(s : MathspecialbesselModel) -> MathspecialbesselModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_special_bessel_model_fill(s : MathspecialbesselModel, v : Double) -> MathspecialbesselModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_special_bessel_model_min(s : MathspecialbesselModel) -> Double { @_common.min(s.data) }

pub fn math_special_bessel_model_max(s : MathspecialbesselModel) -> Double { @_common.max(s.data) }

pub fn math_special_bessel_model_to_string(s : MathspecialbesselModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathspecialbesselLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_special_bessel_layer_make(size : Int) -> MathspecialbesselLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_special_bessel_layer_len(s : MathspecialbesselLayer) -> Int { s.size }

pub fn math_special_bessel_layer_get(s : MathspecialbesselLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_special_bessel_layer_set(s : MathspecialbesselLayer, i : Int, v : Double) -> MathspecialbesselLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_special_bessel_layer_sum(s : MathspecialbesselLayer) -> Double { @_common.sum(s.data) }

pub fn math_special_bessel_layer_mean(s : MathspecialbesselLayer) -> Double { @_common.mean(s.data) }

pub fn math_special_bessel_layer_scale(s : MathspecialbesselLayer, f : Double) -> MathspecialbesselLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_special_bessel_layer_add(a : MathspecialbesselLayer, b : MathspecialbesselLayer) -> MathspecialbesselLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_special_bessel_layer_copy(s : MathspecialbesselLayer) -> MathspecialbesselLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_special_bessel_layer_fill(s : MathspecialbesselLayer, v : Double) -> MathspecialbesselLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_special_bessel_layer_min(s : MathspecialbesselLayer) -> Double { @_common.min(s.data) }

pub fn math_special_bessel_layer_max(s : MathspecialbesselLayer) -> Double { @_common.max(s.data) }

pub fn math_special_bessel_layer_to_string(s : MathspecialbesselLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathspecialbesselBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_special_bessel_buffer_make(size : Int) -> MathspecialbesselBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_special_bessel_buffer_len(s : MathspecialbesselBuffer) -> Int { s.size }

pub fn math_special_bessel_buffer_get(s : MathspecialbesselBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_special_bessel_buffer_set(s : MathspecialbesselBuffer, i : Int, v : Double) -> MathspecialbesselBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_special_bessel_buffer_sum(s : MathspecialbesselBuffer) -> Double { @_common.sum(s.data) }

pub fn math_special_bessel_buffer_mean(s : MathspecialbesselBuffer) -> Double { @_common.mean(s.data) }

pub fn math_special_bessel_buffer_scale(s : MathspecialbesselBuffer, f : Double) -> MathspecialbesselBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_special_bessel_buffer_add(a : MathspecialbesselBuffer, b : MathspecialbesselBuffer) -> MathspecialbesselBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_special_bessel_buffer_copy(s : MathspecialbesselBuffer) -> MathspecialbesselBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_special_bessel_buffer_fill(s : MathspecialbesselBuffer, v : Double) -> MathspecialbesselBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_special_bessel_buffer_min(s : MathspecialbesselBuffer) -> Double { @_common.min(s.data) }

pub fn math_special_bessel_buffer_max(s : MathspecialbesselBuffer) -> Double { @_common.max(s.data) }

pub fn math_special_bessel_buffer_to_string(s : MathspecialbesselBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathspecialbesselCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_special_bessel_cursor_make(size : Int) -> MathspecialbesselCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_special_bessel_cursor_len(s : MathspecialbesselCursor) -> Int { s.size }

pub fn math_special_bessel_cursor_get(s : MathspecialbesselCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_special_bessel_cursor_set(s : MathspecialbesselCursor, i : Int, v : Double) -> MathspecialbesselCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_special_bessel_cursor_sum(s : MathspecialbesselCursor) -> Double { @_common.sum(s.data) }

pub fn math_special_bessel_cursor_mean(s : MathspecialbesselCursor) -> Double { @_common.mean(s.data) }

pub fn math_special_bessel_cursor_scale(s : MathspecialbesselCursor, f : Double) -> MathspecialbesselCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_special_bessel_cursor_add(a : MathspecialbesselCursor, b : MathspecialbesselCursor) -> MathspecialbesselCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_special_bessel_cursor_copy(s : MathspecialbesselCursor) -> MathspecialbesselCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_special_bessel_cursor_fill(s : MathspecialbesselCursor, v : Double) -> MathspecialbesselCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_special_bessel_cursor_min(s : MathspecialbesselCursor) -> Double { @_common.min(s.data) }

pub fn math_special_bessel_cursor_max(s : MathspecialbesselCursor) -> Double { @_common.max(s.data) }

pub fn math_special_bessel_cursor_to_string(s : MathspecialbesselCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathspecialbesselView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_special_bessel_view_make(size : Int) -> MathspecialbesselView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_special_bessel_view_len(s : MathspecialbesselView) -> Int { s.size }

pub fn math_special_bessel_view_get(s : MathspecialbesselView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_special_bessel_view_set(s : MathspecialbesselView, i : Int, v : Double) -> MathspecialbesselView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_special_bessel_view_sum(s : MathspecialbesselView) -> Double { @_common.sum(s.data) }

pub fn math_special_bessel_view_mean(s : MathspecialbesselView) -> Double { @_common.mean(s.data) }

pub fn math_special_bessel_view_scale(s : MathspecialbesselView, f : Double) -> MathspecialbesselView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_special_bessel_view_add(a : MathspecialbesselView, b : MathspecialbesselView) -> MathspecialbesselView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_special_bessel_view_copy(s : MathspecialbesselView) -> MathspecialbesselView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_special_bessel_view_fill(s : MathspecialbesselView, v : Double) -> MathspecialbesselView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_special_bessel_view_min(s : MathspecialbesselView) -> Double { @_common.min(s.data) }

pub fn math_special_bessel_view_max(s : MathspecialbesselView) -> Double { @_common.max(s.data) }

pub fn math_special_bessel_view_to_string(s : MathspecialbesselView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathspecialbesselRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_special_bessel_range_make(size : Int) -> MathspecialbesselRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_special_bessel_range_len(s : MathspecialbesselRange) -> Int { s.size }

pub fn math_special_bessel_range_get(s : MathspecialbesselRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_special_bessel_range_set(s : MathspecialbesselRange, i : Int, v : Double) -> MathspecialbesselRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_special_bessel_range_sum(s : MathspecialbesselRange) -> Double { @_common.sum(s.data) }

pub fn math_special_bessel_range_mean(s : MathspecialbesselRange) -> Double { @_common.mean(s.data) }

pub fn math_special_bessel_range_scale(s : MathspecialbesselRange, f : Double) -> MathspecialbesselRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_special_bessel_range_add(a : MathspecialbesselRange, b : MathspecialbesselRange) -> MathspecialbesselRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_special_bessel_range_copy(s : MathspecialbesselRange) -> MathspecialbesselRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_special_bessel_range_fill(s : MathspecialbesselRange, v : Double) -> MathspecialbesselRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_special_bessel_range_min(s : MathspecialbesselRange) -> Double { @_common.min(s.data) }

pub fn math_special_bessel_range_max(s : MathspecialbesselRange) -> Double { @_common.max(s.data) }

pub fn math_special_bessel_range_to_string(s : MathspecialbesselRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathspecialbesselSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_special_bessel_slice_make(size : Int) -> MathspecialbesselSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_special_bessel_slice_len(s : MathspecialbesselSlice) -> Int { s.size }

pub fn math_special_bessel_slice_get(s : MathspecialbesselSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_special_bessel_slice_set(s : MathspecialbesselSlice, i : Int, v : Double) -> MathspecialbesselSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_special_bessel_slice_sum(s : MathspecialbesselSlice) -> Double { @_common.sum(s.data) }

pub fn math_special_bessel_slice_mean(s : MathspecialbesselSlice) -> Double { @_common.mean(s.data) }

pub fn math_special_bessel_slice_scale(s : MathspecialbesselSlice, f : Double) -> MathspecialbesselSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_special_bessel_slice_add(a : MathspecialbesselSlice, b : MathspecialbesselSlice) -> MathspecialbesselSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_special_bessel_slice_copy(s : MathspecialbesselSlice) -> MathspecialbesselSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_special_bessel_slice_fill(s : MathspecialbesselSlice, v : Double) -> MathspecialbesselSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_special_bessel_slice_min(s : MathspecialbesselSlice) -> Double { @_common.min(s.data) }

pub fn math_special_bessel_slice_max(s : MathspecialbesselSlice) -> Double { @_common.max(s.data) }

pub fn math_special_bessel_slice_to_string(s : MathspecialbesselSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

