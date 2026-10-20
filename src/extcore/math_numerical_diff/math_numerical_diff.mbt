///===
/// extcore/math_numerical_diff

pub(all) struct MathnumericaldiffPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn math_numerical_diff_make_point(x : Double, y : Double) -> MathnumericaldiffPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn math_numerical_diff_make_point3(x : Double, y : Double, z : Double) -> MathnumericaldiffPoint {
  { x, y, z, label: 0 }
}

pub fn MathnumericaldiffPoint::x(self : MathnumericaldiffPoint) -> Double { self.x }

pub fn MathnumericaldiffPoint::y(self : MathnumericaldiffPoint) -> Double { self.y }

pub fn MathnumericaldiffPoint::z(self : MathnumericaldiffPoint) -> Double { self.z }

pub fn MathnumericaldiffPoint::label(self : MathnumericaldiffPoint) -> Int { self.label }

pub fn MathnumericaldiffPoint::dist(self : MathnumericaldiffPoint, other : MathnumericaldiffPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn MathnumericaldiffPoint::add(self : MathnumericaldiffPoint, other : MathnumericaldiffPoint) -> MathnumericaldiffPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn MathnumericaldiffPoint::sub(self : MathnumericaldiffPoint, other : MathnumericaldiffPoint) -> MathnumericaldiffPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn MathnumericaldiffPoint::scale(self : MathnumericaldiffPoint, s : Double) -> MathnumericaldiffPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn MathnumericaldiffPoint::dot(self : MathnumericaldiffPoint, other : MathnumericaldiffPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn MathnumericaldiffPoint::cross(self : MathnumericaldiffPoint, other : MathnumericaldiffPoint) -> MathnumericaldiffPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn MathnumericaldiffPoint::norm(self : MathnumericaldiffPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn MathnumericaldiffPoint::normalize(self : MathnumericaldiffPoint) -> MathnumericaldiffPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn MathnumericaldiffPoint::negate(self : MathnumericaldiffPoint) -> MathnumericaldiffPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn MathnumericaldiffPoint::mid(self : MathnumericaldiffPoint, other : MathnumericaldiffPoint) -> MathnumericaldiffPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn MathnumericaldiffPoint::lerp(self : MathnumericaldiffPoint, other : MathnumericaldiffPoint, t : Double) -> MathnumericaldiffPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn MathnumericaldiffPoint::to_string(self : MathnumericaldiffPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct MathnumericaldiffSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn math_numerical_diff_make_series(vals : Array[Double], name : String) -> MathnumericaldiffSeries {
  { vals, name, meta: 0 }
}

pub fn MathnumericaldiffSeries::len(self : MathnumericaldiffSeries) -> Int { self.vals.length() }

pub fn MathnumericaldiffSeries::sum(self : MathnumericaldiffSeries) -> Double { @_common.sum(self.vals) }

pub fn MathnumericaldiffSeries::mean(self : MathnumericaldiffSeries) -> Double { @_common.mean(self.vals) }

pub fn MathnumericaldiffSeries::min(self : MathnumericaldiffSeries) -> Double { @_common.min(self.vals) }

pub fn MathnumericaldiffSeries::max(self : MathnumericaldiffSeries) -> Double { @_common.max(self.vals) }

pub fn MathnumericaldiffSeries::range(self : MathnumericaldiffSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn MathnumericaldiffSeries::variance(self : MathnumericaldiffSeries) -> Double { @_common.variance(self.vals) }

pub fn MathnumericaldiffSeries::std(self : MathnumericaldiffSeries) -> Double { @_common.std(self.vals) }

pub fn MathnumericaldiffSeries::median(self : MathnumericaldiffSeries) -> Double { @_common.median(self.vals) }

pub fn MathnumericaldiffSeries::scale(self : MathnumericaldiffSeries, f : Double) -> MathnumericaldiffSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn MathnumericaldiffSeries::add(self : MathnumericaldiffSeries, other : MathnumericaldiffSeries) -> MathnumericaldiffSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn MathnumericaldiffSeries::sub(self : MathnumericaldiffSeries, other : MathnumericaldiffSeries) -> MathnumericaldiffSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn MathnumericaldiffSeries::normalize(self : MathnumericaldiffSeries) -> MathnumericaldiffSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn MathnumericaldiffSeries::cumsum(self : MathnumericaldiffSeries) -> MathnumericaldiffSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn MathnumericaldiffSeries::to_string(self : MathnumericaldiffSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct MathnumericaldiffMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn math_numerical_diff_make_matrix(rows : Int, cols : Int, val : Double) -> MathnumericaldiffMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn math_numerical_diff_matrix_identity(n : Int) -> MathnumericaldiffMatrix {
  let m = math_numerical_diff_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn MathnumericaldiffMatrix::get(self : MathnumericaldiffMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn MathnumericaldiffMatrix::transpose(self : MathnumericaldiffMatrix) -> MathnumericaldiffMatrix {
  let result = math_numerical_diff_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn MathnumericaldiffMatrix::add(self : MathnumericaldiffMatrix, other : MathnumericaldiffMatrix) -> MathnumericaldiffMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = math_numerical_diff_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn MathnumericaldiffMatrix::scale(self : MathnumericaldiffMatrix, s : Double) -> MathnumericaldiffMatrix {
  let result = math_numerical_diff_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn MathnumericaldiffMatrix::multiply(self : MathnumericaldiffMatrix, other : MathnumericaldiffMatrix) -> MathnumericaldiffMatrix {
  if self.cols != other.rows { return math_numerical_diff_make_matrix(self.rows, other.cols, 0.0) }
  let result = math_numerical_diff_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn MathnumericaldiffMatrix::trace(self : MathnumericaldiffMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn MathnumericaldiffMatrix::det(self : MathnumericaldiffMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn MathnumericaldiffMatrix::norm(self : MathnumericaldiffMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn MathnumericaldiffMatrix::to_string(self : MathnumericaldiffMatrix) -> String {
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

pub(all) struct MathnumericaldiffVector {
  comps : Array[Double]
  dim : Int
}

pub fn math_numerical_diff_make_vector(comps : Array[Double]) -> MathnumericaldiffVector {
  { comps, dim: comps.length() }
}

pub fn math_numerical_diff_vector_zero(dim : Int) -> MathnumericaldiffVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn MathnumericaldiffVector::add(self : MathnumericaldiffVector, other : MathnumericaldiffVector) -> MathnumericaldiffVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn MathnumericaldiffVector::sub(self : MathnumericaldiffVector, other : MathnumericaldiffVector) -> MathnumericaldiffVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn MathnumericaldiffVector::scale(self : MathnumericaldiffVector, s : Double) -> MathnumericaldiffVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn MathnumericaldiffVector::dot(self : MathnumericaldiffVector, other : MathnumericaldiffVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn MathnumericaldiffVector::norm(self : MathnumericaldiffVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn MathnumericaldiffVector::normalize(self : MathnumericaldiffVector) -> MathnumericaldiffVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn MathnumericaldiffVector::dist(self : MathnumericaldiffVector, other : MathnumericaldiffVector) -> Double {
  self.sub(other).norm()
}

pub fn MathnumericaldiffVector::to_string(self : MathnumericaldiffVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn math_numerical_diff_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn math_numerical_diff_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn math_numerical_diff_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn math_numerical_diff_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn math_numerical_diff_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn math_numerical_diff_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn math_numerical_diff_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn math_numerical_diff_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn math_numerical_diff_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn math_numerical_diff_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn math_numerical_diff_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn math_numerical_diff_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn math_numerical_diff_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn math_numerical_diff_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn math_numerical_diff_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn math_numerical_diff_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn math_numerical_diff_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn math_numerical_diff_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn math_numerical_diff_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn math_numerical_diff_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn math_numerical_diff_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn math_numerical_diff_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn math_numerical_diff_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn math_numerical_diff_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn math_numerical_diff_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn math_numerical_diff_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn math_numerical_diff_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn math_numerical_diff_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn math_numerical_diff_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct MathnumericaldiffFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_numerical_diff_frame_make(size : Int) -> MathnumericaldiffFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_numerical_diff_frame_len(s : MathnumericaldiffFrame) -> Int { s.size }

pub fn math_numerical_diff_frame_get(s : MathnumericaldiffFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_numerical_diff_frame_set(s : MathnumericaldiffFrame, i : Int, v : Double) -> MathnumericaldiffFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_numerical_diff_frame_sum(s : MathnumericaldiffFrame) -> Double { @_common.sum(s.data) }

pub fn math_numerical_diff_frame_mean(s : MathnumericaldiffFrame) -> Double { @_common.mean(s.data) }

pub fn math_numerical_diff_frame_scale(s : MathnumericaldiffFrame, f : Double) -> MathnumericaldiffFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_numerical_diff_frame_add(a : MathnumericaldiffFrame, b : MathnumericaldiffFrame) -> MathnumericaldiffFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_numerical_diff_frame_copy(s : MathnumericaldiffFrame) -> MathnumericaldiffFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_numerical_diff_frame_fill(s : MathnumericaldiffFrame, v : Double) -> MathnumericaldiffFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_numerical_diff_frame_min(s : MathnumericaldiffFrame) -> Double { @_common.min(s.data) }

pub fn math_numerical_diff_frame_max(s : MathnumericaldiffFrame) -> Double { @_common.max(s.data) }

pub fn math_numerical_diff_frame_to_string(s : MathnumericaldiffFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathnumericaldiffTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_numerical_diff_table_make(size : Int) -> MathnumericaldiffTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_numerical_diff_table_len(s : MathnumericaldiffTable) -> Int { s.size }

pub fn math_numerical_diff_table_get(s : MathnumericaldiffTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_numerical_diff_table_set(s : MathnumericaldiffTable, i : Int, v : Double) -> MathnumericaldiffTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_numerical_diff_table_sum(s : MathnumericaldiffTable) -> Double { @_common.sum(s.data) }

pub fn math_numerical_diff_table_mean(s : MathnumericaldiffTable) -> Double { @_common.mean(s.data) }

pub fn math_numerical_diff_table_scale(s : MathnumericaldiffTable, f : Double) -> MathnumericaldiffTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_numerical_diff_table_add(a : MathnumericaldiffTable, b : MathnumericaldiffTable) -> MathnumericaldiffTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_numerical_diff_table_copy(s : MathnumericaldiffTable) -> MathnumericaldiffTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_numerical_diff_table_fill(s : MathnumericaldiffTable, v : Double) -> MathnumericaldiffTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_numerical_diff_table_min(s : MathnumericaldiffTable) -> Double { @_common.min(s.data) }

pub fn math_numerical_diff_table_max(s : MathnumericaldiffTable) -> Double { @_common.max(s.data) }

pub fn math_numerical_diff_table_to_string(s : MathnumericaldiffTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathnumericaldiffGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_numerical_diff_graphn_make(size : Int) -> MathnumericaldiffGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_numerical_diff_graphn_len(s : MathnumericaldiffGraphN) -> Int { s.size }

pub fn math_numerical_diff_graphn_get(s : MathnumericaldiffGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_numerical_diff_graphn_set(s : MathnumericaldiffGraphN, i : Int, v : Double) -> MathnumericaldiffGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_numerical_diff_graphn_sum(s : MathnumericaldiffGraphN) -> Double { @_common.sum(s.data) }

pub fn math_numerical_diff_graphn_mean(s : MathnumericaldiffGraphN) -> Double { @_common.mean(s.data) }

pub fn math_numerical_diff_graphn_scale(s : MathnumericaldiffGraphN, f : Double) -> MathnumericaldiffGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_numerical_diff_graphn_add(a : MathnumericaldiffGraphN, b : MathnumericaldiffGraphN) -> MathnumericaldiffGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_numerical_diff_graphn_copy(s : MathnumericaldiffGraphN) -> MathnumericaldiffGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_numerical_diff_graphn_fill(s : MathnumericaldiffGraphN, v : Double) -> MathnumericaldiffGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_numerical_diff_graphn_min(s : MathnumericaldiffGraphN) -> Double { @_common.min(s.data) }

pub fn math_numerical_diff_graphn_max(s : MathnumericaldiffGraphN) -> Double { @_common.max(s.data) }

pub fn math_numerical_diff_graphn_to_string(s : MathnumericaldiffGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathnumericaldiffNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_numerical_diff_node_make(size : Int) -> MathnumericaldiffNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_numerical_diff_node_len(s : MathnumericaldiffNode) -> Int { s.size }

pub fn math_numerical_diff_node_get(s : MathnumericaldiffNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_numerical_diff_node_set(s : MathnumericaldiffNode, i : Int, v : Double) -> MathnumericaldiffNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_numerical_diff_node_sum(s : MathnumericaldiffNode) -> Double { @_common.sum(s.data) }

pub fn math_numerical_diff_node_mean(s : MathnumericaldiffNode) -> Double { @_common.mean(s.data) }

pub fn math_numerical_diff_node_scale(s : MathnumericaldiffNode, f : Double) -> MathnumericaldiffNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_numerical_diff_node_add(a : MathnumericaldiffNode, b : MathnumericaldiffNode) -> MathnumericaldiffNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_numerical_diff_node_copy(s : MathnumericaldiffNode) -> MathnumericaldiffNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_numerical_diff_node_fill(s : MathnumericaldiffNode, v : Double) -> MathnumericaldiffNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_numerical_diff_node_min(s : MathnumericaldiffNode) -> Double { @_common.min(s.data) }

pub fn math_numerical_diff_node_max(s : MathnumericaldiffNode) -> Double { @_common.max(s.data) }

pub fn math_numerical_diff_node_to_string(s : MathnumericaldiffNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathnumericaldiffEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_numerical_diff_edge_make(size : Int) -> MathnumericaldiffEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_numerical_diff_edge_len(s : MathnumericaldiffEdge) -> Int { s.size }

pub fn math_numerical_diff_edge_get(s : MathnumericaldiffEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_numerical_diff_edge_set(s : MathnumericaldiffEdge, i : Int, v : Double) -> MathnumericaldiffEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_numerical_diff_edge_sum(s : MathnumericaldiffEdge) -> Double { @_common.sum(s.data) }

pub fn math_numerical_diff_edge_mean(s : MathnumericaldiffEdge) -> Double { @_common.mean(s.data) }

pub fn math_numerical_diff_edge_scale(s : MathnumericaldiffEdge, f : Double) -> MathnumericaldiffEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_numerical_diff_edge_add(a : MathnumericaldiffEdge, b : MathnumericaldiffEdge) -> MathnumericaldiffEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_numerical_diff_edge_copy(s : MathnumericaldiffEdge) -> MathnumericaldiffEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_numerical_diff_edge_fill(s : MathnumericaldiffEdge, v : Double) -> MathnumericaldiffEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_numerical_diff_edge_min(s : MathnumericaldiffEdge) -> Double { @_common.min(s.data) }

pub fn math_numerical_diff_edge_max(s : MathnumericaldiffEdge) -> Double { @_common.max(s.data) }

pub fn math_numerical_diff_edge_to_string(s : MathnumericaldiffEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathnumericaldiffPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_numerical_diff_path_make(size : Int) -> MathnumericaldiffPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_numerical_diff_path_len(s : MathnumericaldiffPath) -> Int { s.size }

pub fn math_numerical_diff_path_get(s : MathnumericaldiffPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_numerical_diff_path_set(s : MathnumericaldiffPath, i : Int, v : Double) -> MathnumericaldiffPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_numerical_diff_path_sum(s : MathnumericaldiffPath) -> Double { @_common.sum(s.data) }

pub fn math_numerical_diff_path_mean(s : MathnumericaldiffPath) -> Double { @_common.mean(s.data) }

pub fn math_numerical_diff_path_scale(s : MathnumericaldiffPath, f : Double) -> MathnumericaldiffPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_numerical_diff_path_add(a : MathnumericaldiffPath, b : MathnumericaldiffPath) -> MathnumericaldiffPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_numerical_diff_path_copy(s : MathnumericaldiffPath) -> MathnumericaldiffPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_numerical_diff_path_fill(s : MathnumericaldiffPath, v : Double) -> MathnumericaldiffPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_numerical_diff_path_min(s : MathnumericaldiffPath) -> Double { @_common.min(s.data) }

pub fn math_numerical_diff_path_max(s : MathnumericaldiffPath) -> Double { @_common.max(s.data) }

pub fn math_numerical_diff_path_to_string(s : MathnumericaldiffPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathnumericaldiffCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_numerical_diff_cluster_make(size : Int) -> MathnumericaldiffCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_numerical_diff_cluster_len(s : MathnumericaldiffCluster) -> Int { s.size }

pub fn math_numerical_diff_cluster_get(s : MathnumericaldiffCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_numerical_diff_cluster_set(s : MathnumericaldiffCluster, i : Int, v : Double) -> MathnumericaldiffCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_numerical_diff_cluster_sum(s : MathnumericaldiffCluster) -> Double { @_common.sum(s.data) }

pub fn math_numerical_diff_cluster_mean(s : MathnumericaldiffCluster) -> Double { @_common.mean(s.data) }

pub fn math_numerical_diff_cluster_scale(s : MathnumericaldiffCluster, f : Double) -> MathnumericaldiffCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_numerical_diff_cluster_add(a : MathnumericaldiffCluster, b : MathnumericaldiffCluster) -> MathnumericaldiffCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_numerical_diff_cluster_copy(s : MathnumericaldiffCluster) -> MathnumericaldiffCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_numerical_diff_cluster_fill(s : MathnumericaldiffCluster, v : Double) -> MathnumericaldiffCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_numerical_diff_cluster_min(s : MathnumericaldiffCluster) -> Double { @_common.min(s.data) }

pub fn math_numerical_diff_cluster_max(s : MathnumericaldiffCluster) -> Double { @_common.max(s.data) }

pub fn math_numerical_diff_cluster_to_string(s : MathnumericaldiffCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathnumericaldiffModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_numerical_diff_model_make(size : Int) -> MathnumericaldiffModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_numerical_diff_model_len(s : MathnumericaldiffModel) -> Int { s.size }

pub fn math_numerical_diff_model_get(s : MathnumericaldiffModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_numerical_diff_model_set(s : MathnumericaldiffModel, i : Int, v : Double) -> MathnumericaldiffModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_numerical_diff_model_sum(s : MathnumericaldiffModel) -> Double { @_common.sum(s.data) }

pub fn math_numerical_diff_model_mean(s : MathnumericaldiffModel) -> Double { @_common.mean(s.data) }

pub fn math_numerical_diff_model_scale(s : MathnumericaldiffModel, f : Double) -> MathnumericaldiffModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_numerical_diff_model_add(a : MathnumericaldiffModel, b : MathnumericaldiffModel) -> MathnumericaldiffModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_numerical_diff_model_copy(s : MathnumericaldiffModel) -> MathnumericaldiffModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_numerical_diff_model_fill(s : MathnumericaldiffModel, v : Double) -> MathnumericaldiffModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_numerical_diff_model_min(s : MathnumericaldiffModel) -> Double { @_common.min(s.data) }

pub fn math_numerical_diff_model_max(s : MathnumericaldiffModel) -> Double { @_common.max(s.data) }

pub fn math_numerical_diff_model_to_string(s : MathnumericaldiffModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathnumericaldiffLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_numerical_diff_layer_make(size : Int) -> MathnumericaldiffLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_numerical_diff_layer_len(s : MathnumericaldiffLayer) -> Int { s.size }

pub fn math_numerical_diff_layer_get(s : MathnumericaldiffLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_numerical_diff_layer_set(s : MathnumericaldiffLayer, i : Int, v : Double) -> MathnumericaldiffLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_numerical_diff_layer_sum(s : MathnumericaldiffLayer) -> Double { @_common.sum(s.data) }

pub fn math_numerical_diff_layer_mean(s : MathnumericaldiffLayer) -> Double { @_common.mean(s.data) }

pub fn math_numerical_diff_layer_scale(s : MathnumericaldiffLayer, f : Double) -> MathnumericaldiffLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_numerical_diff_layer_add(a : MathnumericaldiffLayer, b : MathnumericaldiffLayer) -> MathnumericaldiffLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_numerical_diff_layer_copy(s : MathnumericaldiffLayer) -> MathnumericaldiffLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_numerical_diff_layer_fill(s : MathnumericaldiffLayer, v : Double) -> MathnumericaldiffLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_numerical_diff_layer_min(s : MathnumericaldiffLayer) -> Double { @_common.min(s.data) }

pub fn math_numerical_diff_layer_max(s : MathnumericaldiffLayer) -> Double { @_common.max(s.data) }

pub fn math_numerical_diff_layer_to_string(s : MathnumericaldiffLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathnumericaldiffBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_numerical_diff_buffer_make(size : Int) -> MathnumericaldiffBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_numerical_diff_buffer_len(s : MathnumericaldiffBuffer) -> Int { s.size }

pub fn math_numerical_diff_buffer_get(s : MathnumericaldiffBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_numerical_diff_buffer_set(s : MathnumericaldiffBuffer, i : Int, v : Double) -> MathnumericaldiffBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_numerical_diff_buffer_sum(s : MathnumericaldiffBuffer) -> Double { @_common.sum(s.data) }

pub fn math_numerical_diff_buffer_mean(s : MathnumericaldiffBuffer) -> Double { @_common.mean(s.data) }

pub fn math_numerical_diff_buffer_scale(s : MathnumericaldiffBuffer, f : Double) -> MathnumericaldiffBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_numerical_diff_buffer_add(a : MathnumericaldiffBuffer, b : MathnumericaldiffBuffer) -> MathnumericaldiffBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_numerical_diff_buffer_copy(s : MathnumericaldiffBuffer) -> MathnumericaldiffBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_numerical_diff_buffer_fill(s : MathnumericaldiffBuffer, v : Double) -> MathnumericaldiffBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_numerical_diff_buffer_min(s : MathnumericaldiffBuffer) -> Double { @_common.min(s.data) }

pub fn math_numerical_diff_buffer_max(s : MathnumericaldiffBuffer) -> Double { @_common.max(s.data) }

pub fn math_numerical_diff_buffer_to_string(s : MathnumericaldiffBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathnumericaldiffCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_numerical_diff_cursor_make(size : Int) -> MathnumericaldiffCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_numerical_diff_cursor_len(s : MathnumericaldiffCursor) -> Int { s.size }

pub fn math_numerical_diff_cursor_get(s : MathnumericaldiffCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_numerical_diff_cursor_set(s : MathnumericaldiffCursor, i : Int, v : Double) -> MathnumericaldiffCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_numerical_diff_cursor_sum(s : MathnumericaldiffCursor) -> Double { @_common.sum(s.data) }

pub fn math_numerical_diff_cursor_mean(s : MathnumericaldiffCursor) -> Double { @_common.mean(s.data) }

pub fn math_numerical_diff_cursor_scale(s : MathnumericaldiffCursor, f : Double) -> MathnumericaldiffCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_numerical_diff_cursor_add(a : MathnumericaldiffCursor, b : MathnumericaldiffCursor) -> MathnumericaldiffCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_numerical_diff_cursor_copy(s : MathnumericaldiffCursor) -> MathnumericaldiffCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_numerical_diff_cursor_fill(s : MathnumericaldiffCursor, v : Double) -> MathnumericaldiffCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_numerical_diff_cursor_min(s : MathnumericaldiffCursor) -> Double { @_common.min(s.data) }

pub fn math_numerical_diff_cursor_max(s : MathnumericaldiffCursor) -> Double { @_common.max(s.data) }

pub fn math_numerical_diff_cursor_to_string(s : MathnumericaldiffCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathnumericaldiffView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_numerical_diff_view_make(size : Int) -> MathnumericaldiffView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_numerical_diff_view_len(s : MathnumericaldiffView) -> Int { s.size }

pub fn math_numerical_diff_view_get(s : MathnumericaldiffView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_numerical_diff_view_set(s : MathnumericaldiffView, i : Int, v : Double) -> MathnumericaldiffView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_numerical_diff_view_sum(s : MathnumericaldiffView) -> Double { @_common.sum(s.data) }

pub fn math_numerical_diff_view_mean(s : MathnumericaldiffView) -> Double { @_common.mean(s.data) }

pub fn math_numerical_diff_view_scale(s : MathnumericaldiffView, f : Double) -> MathnumericaldiffView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_numerical_diff_view_add(a : MathnumericaldiffView, b : MathnumericaldiffView) -> MathnumericaldiffView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_numerical_diff_view_copy(s : MathnumericaldiffView) -> MathnumericaldiffView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_numerical_diff_view_fill(s : MathnumericaldiffView, v : Double) -> MathnumericaldiffView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_numerical_diff_view_min(s : MathnumericaldiffView) -> Double { @_common.min(s.data) }

pub fn math_numerical_diff_view_max(s : MathnumericaldiffView) -> Double { @_common.max(s.data) }

pub fn math_numerical_diff_view_to_string(s : MathnumericaldiffView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathnumericaldiffRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_numerical_diff_range_make(size : Int) -> MathnumericaldiffRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_numerical_diff_range_len(s : MathnumericaldiffRange) -> Int { s.size }

pub fn math_numerical_diff_range_get(s : MathnumericaldiffRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_numerical_diff_range_set(s : MathnumericaldiffRange, i : Int, v : Double) -> MathnumericaldiffRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_numerical_diff_range_sum(s : MathnumericaldiffRange) -> Double { @_common.sum(s.data) }

pub fn math_numerical_diff_range_mean(s : MathnumericaldiffRange) -> Double { @_common.mean(s.data) }

pub fn math_numerical_diff_range_scale(s : MathnumericaldiffRange, f : Double) -> MathnumericaldiffRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_numerical_diff_range_add(a : MathnumericaldiffRange, b : MathnumericaldiffRange) -> MathnumericaldiffRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_numerical_diff_range_copy(s : MathnumericaldiffRange) -> MathnumericaldiffRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_numerical_diff_range_fill(s : MathnumericaldiffRange, v : Double) -> MathnumericaldiffRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_numerical_diff_range_min(s : MathnumericaldiffRange) -> Double { @_common.min(s.data) }

pub fn math_numerical_diff_range_max(s : MathnumericaldiffRange) -> Double { @_common.max(s.data) }

pub fn math_numerical_diff_range_to_string(s : MathnumericaldiffRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathnumericaldiffSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_numerical_diff_slice_make(size : Int) -> MathnumericaldiffSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_numerical_diff_slice_len(s : MathnumericaldiffSlice) -> Int { s.size }

pub fn math_numerical_diff_slice_get(s : MathnumericaldiffSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_numerical_diff_slice_set(s : MathnumericaldiffSlice, i : Int, v : Double) -> MathnumericaldiffSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_numerical_diff_slice_sum(s : MathnumericaldiffSlice) -> Double { @_common.sum(s.data) }

pub fn math_numerical_diff_slice_mean(s : MathnumericaldiffSlice) -> Double { @_common.mean(s.data) }

pub fn math_numerical_diff_slice_scale(s : MathnumericaldiffSlice, f : Double) -> MathnumericaldiffSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_numerical_diff_slice_add(a : MathnumericaldiffSlice, b : MathnumericaldiffSlice) -> MathnumericaldiffSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_numerical_diff_slice_copy(s : MathnumericaldiffSlice) -> MathnumericaldiffSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_numerical_diff_slice_fill(s : MathnumericaldiffSlice, v : Double) -> MathnumericaldiffSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_numerical_diff_slice_min(s : MathnumericaldiffSlice) -> Double { @_common.min(s.data) }

pub fn math_numerical_diff_slice_max(s : MathnumericaldiffSlice) -> Double { @_common.max(s.data) }

pub fn math_numerical_diff_slice_to_string(s : MathnumericaldiffSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

