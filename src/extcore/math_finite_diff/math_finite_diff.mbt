///===
/// extcore/math_finite_diff

pub(all) struct MathfinitediffPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn math_finite_diff_make_point(x : Double, y : Double) -> MathfinitediffPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn math_finite_diff_make_point3(x : Double, y : Double, z : Double) -> MathfinitediffPoint {
  { x, y, z, label: 0 }
}

pub fn MathfinitediffPoint::x(self : MathfinitediffPoint) -> Double { self.x }

pub fn MathfinitediffPoint::y(self : MathfinitediffPoint) -> Double { self.y }

pub fn MathfinitediffPoint::z(self : MathfinitediffPoint) -> Double { self.z }

pub fn MathfinitediffPoint::label(self : MathfinitediffPoint) -> Int { self.label }

pub fn MathfinitediffPoint::dist(self : MathfinitediffPoint, other : MathfinitediffPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn MathfinitediffPoint::add(self : MathfinitediffPoint, other : MathfinitediffPoint) -> MathfinitediffPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn MathfinitediffPoint::sub(self : MathfinitediffPoint, other : MathfinitediffPoint) -> MathfinitediffPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn MathfinitediffPoint::scale(self : MathfinitediffPoint, s : Double) -> MathfinitediffPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn MathfinitediffPoint::dot(self : MathfinitediffPoint, other : MathfinitediffPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn MathfinitediffPoint::cross(self : MathfinitediffPoint, other : MathfinitediffPoint) -> MathfinitediffPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn MathfinitediffPoint::norm(self : MathfinitediffPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn MathfinitediffPoint::normalize(self : MathfinitediffPoint) -> MathfinitediffPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn MathfinitediffPoint::negate(self : MathfinitediffPoint) -> MathfinitediffPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn MathfinitediffPoint::mid(self : MathfinitediffPoint, other : MathfinitediffPoint) -> MathfinitediffPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn MathfinitediffPoint::lerp(self : MathfinitediffPoint, other : MathfinitediffPoint, t : Double) -> MathfinitediffPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn MathfinitediffPoint::to_string(self : MathfinitediffPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct MathfinitediffSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn math_finite_diff_make_series(vals : Array[Double], name : String) -> MathfinitediffSeries {
  { vals, name, meta: 0 }
}

pub fn MathfinitediffSeries::len(self : MathfinitediffSeries) -> Int { self.vals.length() }

pub fn MathfinitediffSeries::sum(self : MathfinitediffSeries) -> Double { @_common.sum(self.vals) }

pub fn MathfinitediffSeries::mean(self : MathfinitediffSeries) -> Double { @_common.mean(self.vals) }

pub fn MathfinitediffSeries::min(self : MathfinitediffSeries) -> Double { @_common.min(self.vals) }

pub fn MathfinitediffSeries::max(self : MathfinitediffSeries) -> Double { @_common.max(self.vals) }

pub fn MathfinitediffSeries::range(self : MathfinitediffSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn MathfinitediffSeries::variance(self : MathfinitediffSeries) -> Double { @_common.variance(self.vals) }

pub fn MathfinitediffSeries::std(self : MathfinitediffSeries) -> Double { @_common.std(self.vals) }

pub fn MathfinitediffSeries::median(self : MathfinitediffSeries) -> Double { @_common.median(self.vals) }

pub fn MathfinitediffSeries::scale(self : MathfinitediffSeries, f : Double) -> MathfinitediffSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn MathfinitediffSeries::add(self : MathfinitediffSeries, other : MathfinitediffSeries) -> MathfinitediffSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn MathfinitediffSeries::sub(self : MathfinitediffSeries, other : MathfinitediffSeries) -> MathfinitediffSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn MathfinitediffSeries::normalize(self : MathfinitediffSeries) -> MathfinitediffSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn MathfinitediffSeries::cumsum(self : MathfinitediffSeries) -> MathfinitediffSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn MathfinitediffSeries::to_string(self : MathfinitediffSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct MathfinitediffMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn math_finite_diff_make_matrix(rows : Int, cols : Int, val : Double) -> MathfinitediffMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn math_finite_diff_matrix_identity(n : Int) -> MathfinitediffMatrix {
  let m = math_finite_diff_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn MathfinitediffMatrix::get(self : MathfinitediffMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn MathfinitediffMatrix::transpose(self : MathfinitediffMatrix) -> MathfinitediffMatrix {
  let result = math_finite_diff_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn MathfinitediffMatrix::add(self : MathfinitediffMatrix, other : MathfinitediffMatrix) -> MathfinitediffMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = math_finite_diff_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn MathfinitediffMatrix::scale(self : MathfinitediffMatrix, s : Double) -> MathfinitediffMatrix {
  let result = math_finite_diff_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn MathfinitediffMatrix::multiply(self : MathfinitediffMatrix, other : MathfinitediffMatrix) -> MathfinitediffMatrix {
  if self.cols != other.rows { return math_finite_diff_make_matrix(self.rows, other.cols, 0.0) }
  let result = math_finite_diff_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn MathfinitediffMatrix::trace(self : MathfinitediffMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn MathfinitediffMatrix::det(self : MathfinitediffMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn MathfinitediffMatrix::norm(self : MathfinitediffMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn MathfinitediffMatrix::to_string(self : MathfinitediffMatrix) -> String {
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

pub(all) struct MathfinitediffVector {
  comps : Array[Double]
  dim : Int
}

pub fn math_finite_diff_make_vector(comps : Array[Double]) -> MathfinitediffVector {
  { comps, dim: comps.length() }
}

pub fn math_finite_diff_vector_zero(dim : Int) -> MathfinitediffVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn MathfinitediffVector::add(self : MathfinitediffVector, other : MathfinitediffVector) -> MathfinitediffVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn MathfinitediffVector::sub(self : MathfinitediffVector, other : MathfinitediffVector) -> MathfinitediffVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn MathfinitediffVector::scale(self : MathfinitediffVector, s : Double) -> MathfinitediffVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn MathfinitediffVector::dot(self : MathfinitediffVector, other : MathfinitediffVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn MathfinitediffVector::norm(self : MathfinitediffVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn MathfinitediffVector::normalize(self : MathfinitediffVector) -> MathfinitediffVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn MathfinitediffVector::dist(self : MathfinitediffVector, other : MathfinitediffVector) -> Double {
  self.sub(other).norm()
}

pub fn MathfinitediffVector::to_string(self : MathfinitediffVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn math_finite_diff_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn math_finite_diff_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn math_finite_diff_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn math_finite_diff_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn math_finite_diff_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn math_finite_diff_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn math_finite_diff_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn math_finite_diff_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn math_finite_diff_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn math_finite_diff_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn math_finite_diff_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn math_finite_diff_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn math_finite_diff_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn math_finite_diff_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn math_finite_diff_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn math_finite_diff_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn math_finite_diff_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn math_finite_diff_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn math_finite_diff_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn math_finite_diff_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn math_finite_diff_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn math_finite_diff_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn math_finite_diff_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn math_finite_diff_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn math_finite_diff_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn math_finite_diff_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn math_finite_diff_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn math_finite_diff_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn math_finite_diff_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct MathfinitediffFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_finite_diff_frame_make(size : Int) -> MathfinitediffFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_finite_diff_frame_len(s : MathfinitediffFrame) -> Int { s.size }

pub fn math_finite_diff_frame_get(s : MathfinitediffFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_finite_diff_frame_set(s : MathfinitediffFrame, i : Int, v : Double) -> MathfinitediffFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_finite_diff_frame_sum(s : MathfinitediffFrame) -> Double { @_common.sum(s.data) }

pub fn math_finite_diff_frame_mean(s : MathfinitediffFrame) -> Double { @_common.mean(s.data) }

pub fn math_finite_diff_frame_scale(s : MathfinitediffFrame, f : Double) -> MathfinitediffFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_finite_diff_frame_add(a : MathfinitediffFrame, b : MathfinitediffFrame) -> MathfinitediffFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_finite_diff_frame_copy(s : MathfinitediffFrame) -> MathfinitediffFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_finite_diff_frame_fill(s : MathfinitediffFrame, v : Double) -> MathfinitediffFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_finite_diff_frame_min(s : MathfinitediffFrame) -> Double { @_common.min(s.data) }

pub fn math_finite_diff_frame_max(s : MathfinitediffFrame) -> Double { @_common.max(s.data) }

pub fn math_finite_diff_frame_to_string(s : MathfinitediffFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathfinitediffTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_finite_diff_table_make(size : Int) -> MathfinitediffTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_finite_diff_table_len(s : MathfinitediffTable) -> Int { s.size }

pub fn math_finite_diff_table_get(s : MathfinitediffTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_finite_diff_table_set(s : MathfinitediffTable, i : Int, v : Double) -> MathfinitediffTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_finite_diff_table_sum(s : MathfinitediffTable) -> Double { @_common.sum(s.data) }

pub fn math_finite_diff_table_mean(s : MathfinitediffTable) -> Double { @_common.mean(s.data) }

pub fn math_finite_diff_table_scale(s : MathfinitediffTable, f : Double) -> MathfinitediffTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_finite_diff_table_add(a : MathfinitediffTable, b : MathfinitediffTable) -> MathfinitediffTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_finite_diff_table_copy(s : MathfinitediffTable) -> MathfinitediffTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_finite_diff_table_fill(s : MathfinitediffTable, v : Double) -> MathfinitediffTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_finite_diff_table_min(s : MathfinitediffTable) -> Double { @_common.min(s.data) }

pub fn math_finite_diff_table_max(s : MathfinitediffTable) -> Double { @_common.max(s.data) }

pub fn math_finite_diff_table_to_string(s : MathfinitediffTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathfinitediffGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_finite_diff_graphn_make(size : Int) -> MathfinitediffGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_finite_diff_graphn_len(s : MathfinitediffGraphN) -> Int { s.size }

pub fn math_finite_diff_graphn_get(s : MathfinitediffGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_finite_diff_graphn_set(s : MathfinitediffGraphN, i : Int, v : Double) -> MathfinitediffGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_finite_diff_graphn_sum(s : MathfinitediffGraphN) -> Double { @_common.sum(s.data) }

pub fn math_finite_diff_graphn_mean(s : MathfinitediffGraphN) -> Double { @_common.mean(s.data) }

pub fn math_finite_diff_graphn_scale(s : MathfinitediffGraphN, f : Double) -> MathfinitediffGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_finite_diff_graphn_add(a : MathfinitediffGraphN, b : MathfinitediffGraphN) -> MathfinitediffGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_finite_diff_graphn_copy(s : MathfinitediffGraphN) -> MathfinitediffGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_finite_diff_graphn_fill(s : MathfinitediffGraphN, v : Double) -> MathfinitediffGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_finite_diff_graphn_min(s : MathfinitediffGraphN) -> Double { @_common.min(s.data) }

pub fn math_finite_diff_graphn_max(s : MathfinitediffGraphN) -> Double { @_common.max(s.data) }

pub fn math_finite_diff_graphn_to_string(s : MathfinitediffGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathfinitediffNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_finite_diff_node_make(size : Int) -> MathfinitediffNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_finite_diff_node_len(s : MathfinitediffNode) -> Int { s.size }

pub fn math_finite_diff_node_get(s : MathfinitediffNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_finite_diff_node_set(s : MathfinitediffNode, i : Int, v : Double) -> MathfinitediffNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_finite_diff_node_sum(s : MathfinitediffNode) -> Double { @_common.sum(s.data) }

pub fn math_finite_diff_node_mean(s : MathfinitediffNode) -> Double { @_common.mean(s.data) }

pub fn math_finite_diff_node_scale(s : MathfinitediffNode, f : Double) -> MathfinitediffNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_finite_diff_node_add(a : MathfinitediffNode, b : MathfinitediffNode) -> MathfinitediffNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_finite_diff_node_copy(s : MathfinitediffNode) -> MathfinitediffNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_finite_diff_node_fill(s : MathfinitediffNode, v : Double) -> MathfinitediffNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_finite_diff_node_min(s : MathfinitediffNode) -> Double { @_common.min(s.data) }

pub fn math_finite_diff_node_max(s : MathfinitediffNode) -> Double { @_common.max(s.data) }

pub fn math_finite_diff_node_to_string(s : MathfinitediffNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathfinitediffEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_finite_diff_edge_make(size : Int) -> MathfinitediffEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_finite_diff_edge_len(s : MathfinitediffEdge) -> Int { s.size }

pub fn math_finite_diff_edge_get(s : MathfinitediffEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_finite_diff_edge_set(s : MathfinitediffEdge, i : Int, v : Double) -> MathfinitediffEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_finite_diff_edge_sum(s : MathfinitediffEdge) -> Double { @_common.sum(s.data) }

pub fn math_finite_diff_edge_mean(s : MathfinitediffEdge) -> Double { @_common.mean(s.data) }

pub fn math_finite_diff_edge_scale(s : MathfinitediffEdge, f : Double) -> MathfinitediffEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_finite_diff_edge_add(a : MathfinitediffEdge, b : MathfinitediffEdge) -> MathfinitediffEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_finite_diff_edge_copy(s : MathfinitediffEdge) -> MathfinitediffEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_finite_diff_edge_fill(s : MathfinitediffEdge, v : Double) -> MathfinitediffEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_finite_diff_edge_min(s : MathfinitediffEdge) -> Double { @_common.min(s.data) }

pub fn math_finite_diff_edge_max(s : MathfinitediffEdge) -> Double { @_common.max(s.data) }

pub fn math_finite_diff_edge_to_string(s : MathfinitediffEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathfinitediffPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_finite_diff_path_make(size : Int) -> MathfinitediffPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_finite_diff_path_len(s : MathfinitediffPath) -> Int { s.size }

pub fn math_finite_diff_path_get(s : MathfinitediffPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_finite_diff_path_set(s : MathfinitediffPath, i : Int, v : Double) -> MathfinitediffPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_finite_diff_path_sum(s : MathfinitediffPath) -> Double { @_common.sum(s.data) }

pub fn math_finite_diff_path_mean(s : MathfinitediffPath) -> Double { @_common.mean(s.data) }

pub fn math_finite_diff_path_scale(s : MathfinitediffPath, f : Double) -> MathfinitediffPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_finite_diff_path_add(a : MathfinitediffPath, b : MathfinitediffPath) -> MathfinitediffPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_finite_diff_path_copy(s : MathfinitediffPath) -> MathfinitediffPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_finite_diff_path_fill(s : MathfinitediffPath, v : Double) -> MathfinitediffPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_finite_diff_path_min(s : MathfinitediffPath) -> Double { @_common.min(s.data) }

pub fn math_finite_diff_path_max(s : MathfinitediffPath) -> Double { @_common.max(s.data) }

pub fn math_finite_diff_path_to_string(s : MathfinitediffPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathfinitediffCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_finite_diff_cluster_make(size : Int) -> MathfinitediffCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_finite_diff_cluster_len(s : MathfinitediffCluster) -> Int { s.size }

pub fn math_finite_diff_cluster_get(s : MathfinitediffCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_finite_diff_cluster_set(s : MathfinitediffCluster, i : Int, v : Double) -> MathfinitediffCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_finite_diff_cluster_sum(s : MathfinitediffCluster) -> Double { @_common.sum(s.data) }

pub fn math_finite_diff_cluster_mean(s : MathfinitediffCluster) -> Double { @_common.mean(s.data) }

pub fn math_finite_diff_cluster_scale(s : MathfinitediffCluster, f : Double) -> MathfinitediffCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_finite_diff_cluster_add(a : MathfinitediffCluster, b : MathfinitediffCluster) -> MathfinitediffCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_finite_diff_cluster_copy(s : MathfinitediffCluster) -> MathfinitediffCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_finite_diff_cluster_fill(s : MathfinitediffCluster, v : Double) -> MathfinitediffCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_finite_diff_cluster_min(s : MathfinitediffCluster) -> Double { @_common.min(s.data) }

pub fn math_finite_diff_cluster_max(s : MathfinitediffCluster) -> Double { @_common.max(s.data) }

pub fn math_finite_diff_cluster_to_string(s : MathfinitediffCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathfinitediffModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_finite_diff_model_make(size : Int) -> MathfinitediffModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_finite_diff_model_len(s : MathfinitediffModel) -> Int { s.size }

pub fn math_finite_diff_model_get(s : MathfinitediffModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_finite_diff_model_set(s : MathfinitediffModel, i : Int, v : Double) -> MathfinitediffModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_finite_diff_model_sum(s : MathfinitediffModel) -> Double { @_common.sum(s.data) }

pub fn math_finite_diff_model_mean(s : MathfinitediffModel) -> Double { @_common.mean(s.data) }

pub fn math_finite_diff_model_scale(s : MathfinitediffModel, f : Double) -> MathfinitediffModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_finite_diff_model_add(a : MathfinitediffModel, b : MathfinitediffModel) -> MathfinitediffModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_finite_diff_model_copy(s : MathfinitediffModel) -> MathfinitediffModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_finite_diff_model_fill(s : MathfinitediffModel, v : Double) -> MathfinitediffModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_finite_diff_model_min(s : MathfinitediffModel) -> Double { @_common.min(s.data) }

pub fn math_finite_diff_model_max(s : MathfinitediffModel) -> Double { @_common.max(s.data) }

pub fn math_finite_diff_model_to_string(s : MathfinitediffModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathfinitediffLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_finite_diff_layer_make(size : Int) -> MathfinitediffLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_finite_diff_layer_len(s : MathfinitediffLayer) -> Int { s.size }

pub fn math_finite_diff_layer_get(s : MathfinitediffLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_finite_diff_layer_set(s : MathfinitediffLayer, i : Int, v : Double) -> MathfinitediffLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_finite_diff_layer_sum(s : MathfinitediffLayer) -> Double { @_common.sum(s.data) }

pub fn math_finite_diff_layer_mean(s : MathfinitediffLayer) -> Double { @_common.mean(s.data) }

pub fn math_finite_diff_layer_scale(s : MathfinitediffLayer, f : Double) -> MathfinitediffLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_finite_diff_layer_add(a : MathfinitediffLayer, b : MathfinitediffLayer) -> MathfinitediffLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_finite_diff_layer_copy(s : MathfinitediffLayer) -> MathfinitediffLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_finite_diff_layer_fill(s : MathfinitediffLayer, v : Double) -> MathfinitediffLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_finite_diff_layer_min(s : MathfinitediffLayer) -> Double { @_common.min(s.data) }

pub fn math_finite_diff_layer_max(s : MathfinitediffLayer) -> Double { @_common.max(s.data) }

pub fn math_finite_diff_layer_to_string(s : MathfinitediffLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathfinitediffBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_finite_diff_buffer_make(size : Int) -> MathfinitediffBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_finite_diff_buffer_len(s : MathfinitediffBuffer) -> Int { s.size }

pub fn math_finite_diff_buffer_get(s : MathfinitediffBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_finite_diff_buffer_set(s : MathfinitediffBuffer, i : Int, v : Double) -> MathfinitediffBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_finite_diff_buffer_sum(s : MathfinitediffBuffer) -> Double { @_common.sum(s.data) }

pub fn math_finite_diff_buffer_mean(s : MathfinitediffBuffer) -> Double { @_common.mean(s.data) }

pub fn math_finite_diff_buffer_scale(s : MathfinitediffBuffer, f : Double) -> MathfinitediffBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_finite_diff_buffer_add(a : MathfinitediffBuffer, b : MathfinitediffBuffer) -> MathfinitediffBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_finite_diff_buffer_copy(s : MathfinitediffBuffer) -> MathfinitediffBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_finite_diff_buffer_fill(s : MathfinitediffBuffer, v : Double) -> MathfinitediffBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_finite_diff_buffer_min(s : MathfinitediffBuffer) -> Double { @_common.min(s.data) }

pub fn math_finite_diff_buffer_max(s : MathfinitediffBuffer) -> Double { @_common.max(s.data) }

pub fn math_finite_diff_buffer_to_string(s : MathfinitediffBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathfinitediffCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_finite_diff_cursor_make(size : Int) -> MathfinitediffCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_finite_diff_cursor_len(s : MathfinitediffCursor) -> Int { s.size }

pub fn math_finite_diff_cursor_get(s : MathfinitediffCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_finite_diff_cursor_set(s : MathfinitediffCursor, i : Int, v : Double) -> MathfinitediffCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_finite_diff_cursor_sum(s : MathfinitediffCursor) -> Double { @_common.sum(s.data) }

pub fn math_finite_diff_cursor_mean(s : MathfinitediffCursor) -> Double { @_common.mean(s.data) }

pub fn math_finite_diff_cursor_scale(s : MathfinitediffCursor, f : Double) -> MathfinitediffCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_finite_diff_cursor_add(a : MathfinitediffCursor, b : MathfinitediffCursor) -> MathfinitediffCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_finite_diff_cursor_copy(s : MathfinitediffCursor) -> MathfinitediffCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_finite_diff_cursor_fill(s : MathfinitediffCursor, v : Double) -> MathfinitediffCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_finite_diff_cursor_min(s : MathfinitediffCursor) -> Double { @_common.min(s.data) }

pub fn math_finite_diff_cursor_max(s : MathfinitediffCursor) -> Double { @_common.max(s.data) }

pub fn math_finite_diff_cursor_to_string(s : MathfinitediffCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathfinitediffView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_finite_diff_view_make(size : Int) -> MathfinitediffView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_finite_diff_view_len(s : MathfinitediffView) -> Int { s.size }

pub fn math_finite_diff_view_get(s : MathfinitediffView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_finite_diff_view_set(s : MathfinitediffView, i : Int, v : Double) -> MathfinitediffView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_finite_diff_view_sum(s : MathfinitediffView) -> Double { @_common.sum(s.data) }

pub fn math_finite_diff_view_mean(s : MathfinitediffView) -> Double { @_common.mean(s.data) }

pub fn math_finite_diff_view_scale(s : MathfinitediffView, f : Double) -> MathfinitediffView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_finite_diff_view_add(a : MathfinitediffView, b : MathfinitediffView) -> MathfinitediffView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_finite_diff_view_copy(s : MathfinitediffView) -> MathfinitediffView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_finite_diff_view_fill(s : MathfinitediffView, v : Double) -> MathfinitediffView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_finite_diff_view_min(s : MathfinitediffView) -> Double { @_common.min(s.data) }

pub fn math_finite_diff_view_max(s : MathfinitediffView) -> Double { @_common.max(s.data) }

pub fn math_finite_diff_view_to_string(s : MathfinitediffView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathfinitediffRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_finite_diff_range_make(size : Int) -> MathfinitediffRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_finite_diff_range_len(s : MathfinitediffRange) -> Int { s.size }

pub fn math_finite_diff_range_get(s : MathfinitediffRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_finite_diff_range_set(s : MathfinitediffRange, i : Int, v : Double) -> MathfinitediffRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_finite_diff_range_sum(s : MathfinitediffRange) -> Double { @_common.sum(s.data) }

pub fn math_finite_diff_range_mean(s : MathfinitediffRange) -> Double { @_common.mean(s.data) }

pub fn math_finite_diff_range_scale(s : MathfinitediffRange, f : Double) -> MathfinitediffRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_finite_diff_range_add(a : MathfinitediffRange, b : MathfinitediffRange) -> MathfinitediffRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_finite_diff_range_copy(s : MathfinitediffRange) -> MathfinitediffRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_finite_diff_range_fill(s : MathfinitediffRange, v : Double) -> MathfinitediffRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_finite_diff_range_min(s : MathfinitediffRange) -> Double { @_common.min(s.data) }

pub fn math_finite_diff_range_max(s : MathfinitediffRange) -> Double { @_common.max(s.data) }

pub fn math_finite_diff_range_to_string(s : MathfinitediffRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathfinitediffSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_finite_diff_slice_make(size : Int) -> MathfinitediffSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_finite_diff_slice_len(s : MathfinitediffSlice) -> Int { s.size }

pub fn math_finite_diff_slice_get(s : MathfinitediffSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_finite_diff_slice_set(s : MathfinitediffSlice, i : Int, v : Double) -> MathfinitediffSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_finite_diff_slice_sum(s : MathfinitediffSlice) -> Double { @_common.sum(s.data) }

pub fn math_finite_diff_slice_mean(s : MathfinitediffSlice) -> Double { @_common.mean(s.data) }

pub fn math_finite_diff_slice_scale(s : MathfinitediffSlice, f : Double) -> MathfinitediffSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_finite_diff_slice_add(a : MathfinitediffSlice, b : MathfinitediffSlice) -> MathfinitediffSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_finite_diff_slice_copy(s : MathfinitediffSlice) -> MathfinitediffSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_finite_diff_slice_fill(s : MathfinitediffSlice, v : Double) -> MathfinitediffSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_finite_diff_slice_min(s : MathfinitediffSlice) -> Double { @_common.min(s.data) }

pub fn math_finite_diff_slice_max(s : MathfinitediffSlice) -> Double { @_common.max(s.data) }

pub fn math_finite_diff_slice_to_string(s : MathfinitediffSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

