///===
/// extcore/math_eigenvalue

pub(all) struct MatheigenvaluePoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn math_eigenvalue_make_point(x : Double, y : Double) -> MatheigenvaluePoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn math_eigenvalue_make_point3(x : Double, y : Double, z : Double) -> MatheigenvaluePoint {
  { x, y, z, label: 0 }
}

pub fn MatheigenvaluePoint::x(self : MatheigenvaluePoint) -> Double { self.x }

pub fn MatheigenvaluePoint::y(self : MatheigenvaluePoint) -> Double { self.y }

pub fn MatheigenvaluePoint::z(self : MatheigenvaluePoint) -> Double { self.z }

pub fn MatheigenvaluePoint::label(self : MatheigenvaluePoint) -> Int { self.label }

pub fn MatheigenvaluePoint::dist(self : MatheigenvaluePoint, other : MatheigenvaluePoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn MatheigenvaluePoint::add(self : MatheigenvaluePoint, other : MatheigenvaluePoint) -> MatheigenvaluePoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn MatheigenvaluePoint::sub(self : MatheigenvaluePoint, other : MatheigenvaluePoint) -> MatheigenvaluePoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn MatheigenvaluePoint::scale(self : MatheigenvaluePoint, s : Double) -> MatheigenvaluePoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn MatheigenvaluePoint::dot(self : MatheigenvaluePoint, other : MatheigenvaluePoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn MatheigenvaluePoint::cross(self : MatheigenvaluePoint, other : MatheigenvaluePoint) -> MatheigenvaluePoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn MatheigenvaluePoint::norm(self : MatheigenvaluePoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn MatheigenvaluePoint::normalize(self : MatheigenvaluePoint) -> MatheigenvaluePoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn MatheigenvaluePoint::negate(self : MatheigenvaluePoint) -> MatheigenvaluePoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn MatheigenvaluePoint::mid(self : MatheigenvaluePoint, other : MatheigenvaluePoint) -> MatheigenvaluePoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn MatheigenvaluePoint::lerp(self : MatheigenvaluePoint, other : MatheigenvaluePoint, t : Double) -> MatheigenvaluePoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn MatheigenvaluePoint::to_string(self : MatheigenvaluePoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct MatheigenvalueSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn math_eigenvalue_make_series(vals : Array[Double], name : String) -> MatheigenvalueSeries {
  { vals, name, meta: 0 }
}

pub fn MatheigenvalueSeries::len(self : MatheigenvalueSeries) -> Int { self.vals.length() }

pub fn MatheigenvalueSeries::sum(self : MatheigenvalueSeries) -> Double { @_common.sum(self.vals) }

pub fn MatheigenvalueSeries::mean(self : MatheigenvalueSeries) -> Double { @_common.mean(self.vals) }

pub fn MatheigenvalueSeries::min(self : MatheigenvalueSeries) -> Double { @_common.min(self.vals) }

pub fn MatheigenvalueSeries::max(self : MatheigenvalueSeries) -> Double { @_common.max(self.vals) }

pub fn MatheigenvalueSeries::range(self : MatheigenvalueSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn MatheigenvalueSeries::variance(self : MatheigenvalueSeries) -> Double { @_common.variance(self.vals) }

pub fn MatheigenvalueSeries::std(self : MatheigenvalueSeries) -> Double { @_common.std(self.vals) }

pub fn MatheigenvalueSeries::median(self : MatheigenvalueSeries) -> Double { @_common.median(self.vals) }

pub fn MatheigenvalueSeries::scale(self : MatheigenvalueSeries, f : Double) -> MatheigenvalueSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn MatheigenvalueSeries::add(self : MatheigenvalueSeries, other : MatheigenvalueSeries) -> MatheigenvalueSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn MatheigenvalueSeries::sub(self : MatheigenvalueSeries, other : MatheigenvalueSeries) -> MatheigenvalueSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn MatheigenvalueSeries::normalize(self : MatheigenvalueSeries) -> MatheigenvalueSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn MatheigenvalueSeries::cumsum(self : MatheigenvalueSeries) -> MatheigenvalueSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn MatheigenvalueSeries::to_string(self : MatheigenvalueSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct MatheigenvalueMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn math_eigenvalue_make_matrix(rows : Int, cols : Int, val : Double) -> MatheigenvalueMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn math_eigenvalue_matrix_identity(n : Int) -> MatheigenvalueMatrix {
  let m = math_eigenvalue_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn MatheigenvalueMatrix::get(self : MatheigenvalueMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn MatheigenvalueMatrix::transpose(self : MatheigenvalueMatrix) -> MatheigenvalueMatrix {
  let result = math_eigenvalue_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn MatheigenvalueMatrix::add(self : MatheigenvalueMatrix, other : MatheigenvalueMatrix) -> MatheigenvalueMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = math_eigenvalue_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn MatheigenvalueMatrix::scale(self : MatheigenvalueMatrix, s : Double) -> MatheigenvalueMatrix {
  let result = math_eigenvalue_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn MatheigenvalueMatrix::multiply(self : MatheigenvalueMatrix, other : MatheigenvalueMatrix) -> MatheigenvalueMatrix {
  if self.cols != other.rows { return math_eigenvalue_make_matrix(self.rows, other.cols, 0.0) }
  let result = math_eigenvalue_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn MatheigenvalueMatrix::trace(self : MatheigenvalueMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn MatheigenvalueMatrix::det(self : MatheigenvalueMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn MatheigenvalueMatrix::norm(self : MatheigenvalueMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn MatheigenvalueMatrix::to_string(self : MatheigenvalueMatrix) -> String {
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

pub(all) struct MatheigenvalueVector {
  comps : Array[Double]
  dim : Int
}

pub fn math_eigenvalue_make_vector(comps : Array[Double]) -> MatheigenvalueVector {
  { comps, dim: comps.length() }
}

pub fn math_eigenvalue_vector_zero(dim : Int) -> MatheigenvalueVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn MatheigenvalueVector::add(self : MatheigenvalueVector, other : MatheigenvalueVector) -> MatheigenvalueVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn MatheigenvalueVector::sub(self : MatheigenvalueVector, other : MatheigenvalueVector) -> MatheigenvalueVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn MatheigenvalueVector::scale(self : MatheigenvalueVector, s : Double) -> MatheigenvalueVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn MatheigenvalueVector::dot(self : MatheigenvalueVector, other : MatheigenvalueVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn MatheigenvalueVector::norm(self : MatheigenvalueVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn MatheigenvalueVector::normalize(self : MatheigenvalueVector) -> MatheigenvalueVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn MatheigenvalueVector::dist(self : MatheigenvalueVector, other : MatheigenvalueVector) -> Double {
  self.sub(other).norm()
}

pub fn MatheigenvalueVector::to_string(self : MatheigenvalueVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn math_eigenvalue_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn math_eigenvalue_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn math_eigenvalue_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn math_eigenvalue_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn math_eigenvalue_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn math_eigenvalue_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn math_eigenvalue_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn math_eigenvalue_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn math_eigenvalue_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn math_eigenvalue_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn math_eigenvalue_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn math_eigenvalue_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn math_eigenvalue_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn math_eigenvalue_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn math_eigenvalue_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn math_eigenvalue_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn math_eigenvalue_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn math_eigenvalue_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn math_eigenvalue_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn math_eigenvalue_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn math_eigenvalue_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn math_eigenvalue_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn math_eigenvalue_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn math_eigenvalue_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn math_eigenvalue_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn math_eigenvalue_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn math_eigenvalue_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn math_eigenvalue_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn math_eigenvalue_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct MatheigenvalueFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_eigenvalue_frame_make(size : Int) -> MatheigenvalueFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_eigenvalue_frame_len(s : MatheigenvalueFrame) -> Int { s.size }

pub fn math_eigenvalue_frame_get(s : MatheigenvalueFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_eigenvalue_frame_set(s : MatheigenvalueFrame, i : Int, v : Double) -> MatheigenvalueFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_eigenvalue_frame_sum(s : MatheigenvalueFrame) -> Double { @_common.sum(s.data) }

pub fn math_eigenvalue_frame_mean(s : MatheigenvalueFrame) -> Double { @_common.mean(s.data) }

pub fn math_eigenvalue_frame_scale(s : MatheigenvalueFrame, f : Double) -> MatheigenvalueFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_eigenvalue_frame_add(a : MatheigenvalueFrame, b : MatheigenvalueFrame) -> MatheigenvalueFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_eigenvalue_frame_copy(s : MatheigenvalueFrame) -> MatheigenvalueFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_eigenvalue_frame_fill(s : MatheigenvalueFrame, v : Double) -> MatheigenvalueFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_eigenvalue_frame_min(s : MatheigenvalueFrame) -> Double { @_common.min(s.data) }

pub fn math_eigenvalue_frame_max(s : MatheigenvalueFrame) -> Double { @_common.max(s.data) }

pub fn math_eigenvalue_frame_to_string(s : MatheigenvalueFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MatheigenvalueTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_eigenvalue_table_make(size : Int) -> MatheigenvalueTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_eigenvalue_table_len(s : MatheigenvalueTable) -> Int { s.size }

pub fn math_eigenvalue_table_get(s : MatheigenvalueTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_eigenvalue_table_set(s : MatheigenvalueTable, i : Int, v : Double) -> MatheigenvalueTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_eigenvalue_table_sum(s : MatheigenvalueTable) -> Double { @_common.sum(s.data) }

pub fn math_eigenvalue_table_mean(s : MatheigenvalueTable) -> Double { @_common.mean(s.data) }

pub fn math_eigenvalue_table_scale(s : MatheigenvalueTable, f : Double) -> MatheigenvalueTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_eigenvalue_table_add(a : MatheigenvalueTable, b : MatheigenvalueTable) -> MatheigenvalueTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_eigenvalue_table_copy(s : MatheigenvalueTable) -> MatheigenvalueTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_eigenvalue_table_fill(s : MatheigenvalueTable, v : Double) -> MatheigenvalueTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_eigenvalue_table_min(s : MatheigenvalueTable) -> Double { @_common.min(s.data) }

pub fn math_eigenvalue_table_max(s : MatheigenvalueTable) -> Double { @_common.max(s.data) }

pub fn math_eigenvalue_table_to_string(s : MatheigenvalueTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MatheigenvalueGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_eigenvalue_graphn_make(size : Int) -> MatheigenvalueGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_eigenvalue_graphn_len(s : MatheigenvalueGraphN) -> Int { s.size }

pub fn math_eigenvalue_graphn_get(s : MatheigenvalueGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_eigenvalue_graphn_set(s : MatheigenvalueGraphN, i : Int, v : Double) -> MatheigenvalueGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_eigenvalue_graphn_sum(s : MatheigenvalueGraphN) -> Double { @_common.sum(s.data) }

pub fn math_eigenvalue_graphn_mean(s : MatheigenvalueGraphN) -> Double { @_common.mean(s.data) }

pub fn math_eigenvalue_graphn_scale(s : MatheigenvalueGraphN, f : Double) -> MatheigenvalueGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_eigenvalue_graphn_add(a : MatheigenvalueGraphN, b : MatheigenvalueGraphN) -> MatheigenvalueGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_eigenvalue_graphn_copy(s : MatheigenvalueGraphN) -> MatheigenvalueGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_eigenvalue_graphn_fill(s : MatheigenvalueGraphN, v : Double) -> MatheigenvalueGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_eigenvalue_graphn_min(s : MatheigenvalueGraphN) -> Double { @_common.min(s.data) }

pub fn math_eigenvalue_graphn_max(s : MatheigenvalueGraphN) -> Double { @_common.max(s.data) }

pub fn math_eigenvalue_graphn_to_string(s : MatheigenvalueGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MatheigenvalueNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_eigenvalue_node_make(size : Int) -> MatheigenvalueNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_eigenvalue_node_len(s : MatheigenvalueNode) -> Int { s.size }

pub fn math_eigenvalue_node_get(s : MatheigenvalueNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_eigenvalue_node_set(s : MatheigenvalueNode, i : Int, v : Double) -> MatheigenvalueNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_eigenvalue_node_sum(s : MatheigenvalueNode) -> Double { @_common.sum(s.data) }

pub fn math_eigenvalue_node_mean(s : MatheigenvalueNode) -> Double { @_common.mean(s.data) }

pub fn math_eigenvalue_node_scale(s : MatheigenvalueNode, f : Double) -> MatheigenvalueNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_eigenvalue_node_add(a : MatheigenvalueNode, b : MatheigenvalueNode) -> MatheigenvalueNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_eigenvalue_node_copy(s : MatheigenvalueNode) -> MatheigenvalueNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_eigenvalue_node_fill(s : MatheigenvalueNode, v : Double) -> MatheigenvalueNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_eigenvalue_node_min(s : MatheigenvalueNode) -> Double { @_common.min(s.data) }

pub fn math_eigenvalue_node_max(s : MatheigenvalueNode) -> Double { @_common.max(s.data) }

pub fn math_eigenvalue_node_to_string(s : MatheigenvalueNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MatheigenvalueEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_eigenvalue_edge_make(size : Int) -> MatheigenvalueEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_eigenvalue_edge_len(s : MatheigenvalueEdge) -> Int { s.size }

pub fn math_eigenvalue_edge_get(s : MatheigenvalueEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_eigenvalue_edge_set(s : MatheigenvalueEdge, i : Int, v : Double) -> MatheigenvalueEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_eigenvalue_edge_sum(s : MatheigenvalueEdge) -> Double { @_common.sum(s.data) }

pub fn math_eigenvalue_edge_mean(s : MatheigenvalueEdge) -> Double { @_common.mean(s.data) }

pub fn math_eigenvalue_edge_scale(s : MatheigenvalueEdge, f : Double) -> MatheigenvalueEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_eigenvalue_edge_add(a : MatheigenvalueEdge, b : MatheigenvalueEdge) -> MatheigenvalueEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_eigenvalue_edge_copy(s : MatheigenvalueEdge) -> MatheigenvalueEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_eigenvalue_edge_fill(s : MatheigenvalueEdge, v : Double) -> MatheigenvalueEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_eigenvalue_edge_min(s : MatheigenvalueEdge) -> Double { @_common.min(s.data) }

pub fn math_eigenvalue_edge_max(s : MatheigenvalueEdge) -> Double { @_common.max(s.data) }

pub fn math_eigenvalue_edge_to_string(s : MatheigenvalueEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MatheigenvaluePath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_eigenvalue_path_make(size : Int) -> MatheigenvaluePath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_eigenvalue_path_len(s : MatheigenvaluePath) -> Int { s.size }

pub fn math_eigenvalue_path_get(s : MatheigenvaluePath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_eigenvalue_path_set(s : MatheigenvaluePath, i : Int, v : Double) -> MatheigenvaluePath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_eigenvalue_path_sum(s : MatheigenvaluePath) -> Double { @_common.sum(s.data) }

pub fn math_eigenvalue_path_mean(s : MatheigenvaluePath) -> Double { @_common.mean(s.data) }

pub fn math_eigenvalue_path_scale(s : MatheigenvaluePath, f : Double) -> MatheigenvaluePath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_eigenvalue_path_add(a : MatheigenvaluePath, b : MatheigenvaluePath) -> MatheigenvaluePath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_eigenvalue_path_copy(s : MatheigenvaluePath) -> MatheigenvaluePath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_eigenvalue_path_fill(s : MatheigenvaluePath, v : Double) -> MatheigenvaluePath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_eigenvalue_path_min(s : MatheigenvaluePath) -> Double { @_common.min(s.data) }

pub fn math_eigenvalue_path_max(s : MatheigenvaluePath) -> Double { @_common.max(s.data) }

pub fn math_eigenvalue_path_to_string(s : MatheigenvaluePath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MatheigenvalueCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_eigenvalue_cluster_make(size : Int) -> MatheigenvalueCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_eigenvalue_cluster_len(s : MatheigenvalueCluster) -> Int { s.size }

pub fn math_eigenvalue_cluster_get(s : MatheigenvalueCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_eigenvalue_cluster_set(s : MatheigenvalueCluster, i : Int, v : Double) -> MatheigenvalueCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_eigenvalue_cluster_sum(s : MatheigenvalueCluster) -> Double { @_common.sum(s.data) }

pub fn math_eigenvalue_cluster_mean(s : MatheigenvalueCluster) -> Double { @_common.mean(s.data) }

pub fn math_eigenvalue_cluster_scale(s : MatheigenvalueCluster, f : Double) -> MatheigenvalueCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_eigenvalue_cluster_add(a : MatheigenvalueCluster, b : MatheigenvalueCluster) -> MatheigenvalueCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_eigenvalue_cluster_copy(s : MatheigenvalueCluster) -> MatheigenvalueCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_eigenvalue_cluster_fill(s : MatheigenvalueCluster, v : Double) -> MatheigenvalueCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_eigenvalue_cluster_min(s : MatheigenvalueCluster) -> Double { @_common.min(s.data) }

pub fn math_eigenvalue_cluster_max(s : MatheigenvalueCluster) -> Double { @_common.max(s.data) }

pub fn math_eigenvalue_cluster_to_string(s : MatheigenvalueCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MatheigenvalueModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_eigenvalue_model_make(size : Int) -> MatheigenvalueModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_eigenvalue_model_len(s : MatheigenvalueModel) -> Int { s.size }

pub fn math_eigenvalue_model_get(s : MatheigenvalueModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_eigenvalue_model_set(s : MatheigenvalueModel, i : Int, v : Double) -> MatheigenvalueModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_eigenvalue_model_sum(s : MatheigenvalueModel) -> Double { @_common.sum(s.data) }

pub fn math_eigenvalue_model_mean(s : MatheigenvalueModel) -> Double { @_common.mean(s.data) }

pub fn math_eigenvalue_model_scale(s : MatheigenvalueModel, f : Double) -> MatheigenvalueModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_eigenvalue_model_add(a : MatheigenvalueModel, b : MatheigenvalueModel) -> MatheigenvalueModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_eigenvalue_model_copy(s : MatheigenvalueModel) -> MatheigenvalueModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_eigenvalue_model_fill(s : MatheigenvalueModel, v : Double) -> MatheigenvalueModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_eigenvalue_model_min(s : MatheigenvalueModel) -> Double { @_common.min(s.data) }

pub fn math_eigenvalue_model_max(s : MatheigenvalueModel) -> Double { @_common.max(s.data) }

pub fn math_eigenvalue_model_to_string(s : MatheigenvalueModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MatheigenvalueLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_eigenvalue_layer_make(size : Int) -> MatheigenvalueLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_eigenvalue_layer_len(s : MatheigenvalueLayer) -> Int { s.size }

pub fn math_eigenvalue_layer_get(s : MatheigenvalueLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_eigenvalue_layer_set(s : MatheigenvalueLayer, i : Int, v : Double) -> MatheigenvalueLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_eigenvalue_layer_sum(s : MatheigenvalueLayer) -> Double { @_common.sum(s.data) }

pub fn math_eigenvalue_layer_mean(s : MatheigenvalueLayer) -> Double { @_common.mean(s.data) }

pub fn math_eigenvalue_layer_scale(s : MatheigenvalueLayer, f : Double) -> MatheigenvalueLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_eigenvalue_layer_add(a : MatheigenvalueLayer, b : MatheigenvalueLayer) -> MatheigenvalueLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_eigenvalue_layer_copy(s : MatheigenvalueLayer) -> MatheigenvalueLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_eigenvalue_layer_fill(s : MatheigenvalueLayer, v : Double) -> MatheigenvalueLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_eigenvalue_layer_min(s : MatheigenvalueLayer) -> Double { @_common.min(s.data) }

pub fn math_eigenvalue_layer_max(s : MatheigenvalueLayer) -> Double { @_common.max(s.data) }

pub fn math_eigenvalue_layer_to_string(s : MatheigenvalueLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MatheigenvalueBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_eigenvalue_buffer_make(size : Int) -> MatheigenvalueBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_eigenvalue_buffer_len(s : MatheigenvalueBuffer) -> Int { s.size }

pub fn math_eigenvalue_buffer_get(s : MatheigenvalueBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_eigenvalue_buffer_set(s : MatheigenvalueBuffer, i : Int, v : Double) -> MatheigenvalueBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_eigenvalue_buffer_sum(s : MatheigenvalueBuffer) -> Double { @_common.sum(s.data) }

pub fn math_eigenvalue_buffer_mean(s : MatheigenvalueBuffer) -> Double { @_common.mean(s.data) }

pub fn math_eigenvalue_buffer_scale(s : MatheigenvalueBuffer, f : Double) -> MatheigenvalueBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_eigenvalue_buffer_add(a : MatheigenvalueBuffer, b : MatheigenvalueBuffer) -> MatheigenvalueBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_eigenvalue_buffer_copy(s : MatheigenvalueBuffer) -> MatheigenvalueBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_eigenvalue_buffer_fill(s : MatheigenvalueBuffer, v : Double) -> MatheigenvalueBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_eigenvalue_buffer_min(s : MatheigenvalueBuffer) -> Double { @_common.min(s.data) }

pub fn math_eigenvalue_buffer_max(s : MatheigenvalueBuffer) -> Double { @_common.max(s.data) }

pub fn math_eigenvalue_buffer_to_string(s : MatheigenvalueBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MatheigenvalueCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_eigenvalue_cursor_make(size : Int) -> MatheigenvalueCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_eigenvalue_cursor_len(s : MatheigenvalueCursor) -> Int { s.size }

pub fn math_eigenvalue_cursor_get(s : MatheigenvalueCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_eigenvalue_cursor_set(s : MatheigenvalueCursor, i : Int, v : Double) -> MatheigenvalueCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_eigenvalue_cursor_sum(s : MatheigenvalueCursor) -> Double { @_common.sum(s.data) }

pub fn math_eigenvalue_cursor_mean(s : MatheigenvalueCursor) -> Double { @_common.mean(s.data) }

pub fn math_eigenvalue_cursor_scale(s : MatheigenvalueCursor, f : Double) -> MatheigenvalueCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_eigenvalue_cursor_add(a : MatheigenvalueCursor, b : MatheigenvalueCursor) -> MatheigenvalueCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_eigenvalue_cursor_copy(s : MatheigenvalueCursor) -> MatheigenvalueCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_eigenvalue_cursor_fill(s : MatheigenvalueCursor, v : Double) -> MatheigenvalueCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_eigenvalue_cursor_min(s : MatheigenvalueCursor) -> Double { @_common.min(s.data) }

pub fn math_eigenvalue_cursor_max(s : MatheigenvalueCursor) -> Double { @_common.max(s.data) }

pub fn math_eigenvalue_cursor_to_string(s : MatheigenvalueCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MatheigenvalueView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_eigenvalue_view_make(size : Int) -> MatheigenvalueView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_eigenvalue_view_len(s : MatheigenvalueView) -> Int { s.size }

pub fn math_eigenvalue_view_get(s : MatheigenvalueView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_eigenvalue_view_set(s : MatheigenvalueView, i : Int, v : Double) -> MatheigenvalueView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_eigenvalue_view_sum(s : MatheigenvalueView) -> Double { @_common.sum(s.data) }

pub fn math_eigenvalue_view_mean(s : MatheigenvalueView) -> Double { @_common.mean(s.data) }

pub fn math_eigenvalue_view_scale(s : MatheigenvalueView, f : Double) -> MatheigenvalueView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_eigenvalue_view_add(a : MatheigenvalueView, b : MatheigenvalueView) -> MatheigenvalueView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_eigenvalue_view_copy(s : MatheigenvalueView) -> MatheigenvalueView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_eigenvalue_view_fill(s : MatheigenvalueView, v : Double) -> MatheigenvalueView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_eigenvalue_view_min(s : MatheigenvalueView) -> Double { @_common.min(s.data) }

pub fn math_eigenvalue_view_max(s : MatheigenvalueView) -> Double { @_common.max(s.data) }

pub fn math_eigenvalue_view_to_string(s : MatheigenvalueView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MatheigenvalueRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_eigenvalue_range_make(size : Int) -> MatheigenvalueRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_eigenvalue_range_len(s : MatheigenvalueRange) -> Int { s.size }

pub fn math_eigenvalue_range_get(s : MatheigenvalueRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_eigenvalue_range_set(s : MatheigenvalueRange, i : Int, v : Double) -> MatheigenvalueRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_eigenvalue_range_sum(s : MatheigenvalueRange) -> Double { @_common.sum(s.data) }

pub fn math_eigenvalue_range_mean(s : MatheigenvalueRange) -> Double { @_common.mean(s.data) }

pub fn math_eigenvalue_range_scale(s : MatheigenvalueRange, f : Double) -> MatheigenvalueRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_eigenvalue_range_add(a : MatheigenvalueRange, b : MatheigenvalueRange) -> MatheigenvalueRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_eigenvalue_range_copy(s : MatheigenvalueRange) -> MatheigenvalueRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_eigenvalue_range_fill(s : MatheigenvalueRange, v : Double) -> MatheigenvalueRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_eigenvalue_range_min(s : MatheigenvalueRange) -> Double { @_common.min(s.data) }

pub fn math_eigenvalue_range_max(s : MatheigenvalueRange) -> Double { @_common.max(s.data) }

pub fn math_eigenvalue_range_to_string(s : MatheigenvalueRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MatheigenvalueSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_eigenvalue_slice_make(size : Int) -> MatheigenvalueSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_eigenvalue_slice_len(s : MatheigenvalueSlice) -> Int { s.size }

pub fn math_eigenvalue_slice_get(s : MatheigenvalueSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_eigenvalue_slice_set(s : MatheigenvalueSlice, i : Int, v : Double) -> MatheigenvalueSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_eigenvalue_slice_sum(s : MatheigenvalueSlice) -> Double { @_common.sum(s.data) }

pub fn math_eigenvalue_slice_mean(s : MatheigenvalueSlice) -> Double { @_common.mean(s.data) }

pub fn math_eigenvalue_slice_scale(s : MatheigenvalueSlice, f : Double) -> MatheigenvalueSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_eigenvalue_slice_add(a : MatheigenvalueSlice, b : MatheigenvalueSlice) -> MatheigenvalueSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_eigenvalue_slice_copy(s : MatheigenvalueSlice) -> MatheigenvalueSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_eigenvalue_slice_fill(s : MatheigenvalueSlice, v : Double) -> MatheigenvalueSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_eigenvalue_slice_min(s : MatheigenvalueSlice) -> Double { @_common.min(s.data) }

pub fn math_eigenvalue_slice_max(s : MatheigenvalueSlice) -> Double { @_common.max(s.data) }

pub fn math_eigenvalue_slice_to_string(s : MatheigenvalueSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

