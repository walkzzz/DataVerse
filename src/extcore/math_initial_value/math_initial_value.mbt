///===
/// extcore/math_initial_value

pub(all) struct MathinitialvaluePoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn math_initial_value_make_point(x : Double, y : Double) -> MathinitialvaluePoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn math_initial_value_make_point3(x : Double, y : Double, z : Double) -> MathinitialvaluePoint {
  { x, y, z, label: 0 }
}

pub fn MathinitialvaluePoint::x(self : MathinitialvaluePoint) -> Double { self.x }

pub fn MathinitialvaluePoint::y(self : MathinitialvaluePoint) -> Double { self.y }

pub fn MathinitialvaluePoint::z(self : MathinitialvaluePoint) -> Double { self.z }

pub fn MathinitialvaluePoint::label(self : MathinitialvaluePoint) -> Int { self.label }

pub fn MathinitialvaluePoint::dist(self : MathinitialvaluePoint, other : MathinitialvaluePoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn MathinitialvaluePoint::add(self : MathinitialvaluePoint, other : MathinitialvaluePoint) -> MathinitialvaluePoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn MathinitialvaluePoint::sub(self : MathinitialvaluePoint, other : MathinitialvaluePoint) -> MathinitialvaluePoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn MathinitialvaluePoint::scale(self : MathinitialvaluePoint, s : Double) -> MathinitialvaluePoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn MathinitialvaluePoint::dot(self : MathinitialvaluePoint, other : MathinitialvaluePoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn MathinitialvaluePoint::cross(self : MathinitialvaluePoint, other : MathinitialvaluePoint) -> MathinitialvaluePoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn MathinitialvaluePoint::norm(self : MathinitialvaluePoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn MathinitialvaluePoint::normalize(self : MathinitialvaluePoint) -> MathinitialvaluePoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn MathinitialvaluePoint::negate(self : MathinitialvaluePoint) -> MathinitialvaluePoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn MathinitialvaluePoint::mid(self : MathinitialvaluePoint, other : MathinitialvaluePoint) -> MathinitialvaluePoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn MathinitialvaluePoint::lerp(self : MathinitialvaluePoint, other : MathinitialvaluePoint, t : Double) -> MathinitialvaluePoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn MathinitialvaluePoint::to_string(self : MathinitialvaluePoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct MathinitialvalueSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn math_initial_value_make_series(vals : Array[Double], name : String) -> MathinitialvalueSeries {
  { vals, name, meta: 0 }
}

pub fn MathinitialvalueSeries::len(self : MathinitialvalueSeries) -> Int { self.vals.length() }

pub fn MathinitialvalueSeries::sum(self : MathinitialvalueSeries) -> Double { @_common.sum(self.vals) }

pub fn MathinitialvalueSeries::mean(self : MathinitialvalueSeries) -> Double { @_common.mean(self.vals) }

pub fn MathinitialvalueSeries::min(self : MathinitialvalueSeries) -> Double { @_common.min(self.vals) }

pub fn MathinitialvalueSeries::max(self : MathinitialvalueSeries) -> Double { @_common.max(self.vals) }

pub fn MathinitialvalueSeries::range(self : MathinitialvalueSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn MathinitialvalueSeries::variance(self : MathinitialvalueSeries) -> Double { @_common.variance(self.vals) }

pub fn MathinitialvalueSeries::std(self : MathinitialvalueSeries) -> Double { @_common.std(self.vals) }

pub fn MathinitialvalueSeries::median(self : MathinitialvalueSeries) -> Double { @_common.median(self.vals) }

pub fn MathinitialvalueSeries::scale(self : MathinitialvalueSeries, f : Double) -> MathinitialvalueSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn MathinitialvalueSeries::add(self : MathinitialvalueSeries, other : MathinitialvalueSeries) -> MathinitialvalueSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn MathinitialvalueSeries::sub(self : MathinitialvalueSeries, other : MathinitialvalueSeries) -> MathinitialvalueSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn MathinitialvalueSeries::normalize(self : MathinitialvalueSeries) -> MathinitialvalueSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn MathinitialvalueSeries::cumsum(self : MathinitialvalueSeries) -> MathinitialvalueSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn MathinitialvalueSeries::to_string(self : MathinitialvalueSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct MathinitialvalueMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn math_initial_value_make_matrix(rows : Int, cols : Int, val : Double) -> MathinitialvalueMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn math_initial_value_matrix_identity(n : Int) -> MathinitialvalueMatrix {
  let m = math_initial_value_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn MathinitialvalueMatrix::get(self : MathinitialvalueMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn MathinitialvalueMatrix::transpose(self : MathinitialvalueMatrix) -> MathinitialvalueMatrix {
  let result = math_initial_value_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn MathinitialvalueMatrix::add(self : MathinitialvalueMatrix, other : MathinitialvalueMatrix) -> MathinitialvalueMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = math_initial_value_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn MathinitialvalueMatrix::scale(self : MathinitialvalueMatrix, s : Double) -> MathinitialvalueMatrix {
  let result = math_initial_value_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn MathinitialvalueMatrix::multiply(self : MathinitialvalueMatrix, other : MathinitialvalueMatrix) -> MathinitialvalueMatrix {
  if self.cols != other.rows { return math_initial_value_make_matrix(self.rows, other.cols, 0.0) }
  let result = math_initial_value_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn MathinitialvalueMatrix::trace(self : MathinitialvalueMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn MathinitialvalueMatrix::det(self : MathinitialvalueMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn MathinitialvalueMatrix::norm(self : MathinitialvalueMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn MathinitialvalueMatrix::to_string(self : MathinitialvalueMatrix) -> String {
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

pub(all) struct MathinitialvalueVector {
  comps : Array[Double]
  dim : Int
}

pub fn math_initial_value_make_vector(comps : Array[Double]) -> MathinitialvalueVector {
  { comps, dim: comps.length() }
}

pub fn math_initial_value_vector_zero(dim : Int) -> MathinitialvalueVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn MathinitialvalueVector::add(self : MathinitialvalueVector, other : MathinitialvalueVector) -> MathinitialvalueVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn MathinitialvalueVector::sub(self : MathinitialvalueVector, other : MathinitialvalueVector) -> MathinitialvalueVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn MathinitialvalueVector::scale(self : MathinitialvalueVector, s : Double) -> MathinitialvalueVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn MathinitialvalueVector::dot(self : MathinitialvalueVector, other : MathinitialvalueVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn MathinitialvalueVector::norm(self : MathinitialvalueVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn MathinitialvalueVector::normalize(self : MathinitialvalueVector) -> MathinitialvalueVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn MathinitialvalueVector::dist(self : MathinitialvalueVector, other : MathinitialvalueVector) -> Double {
  self.sub(other).norm()
}

pub fn MathinitialvalueVector::to_string(self : MathinitialvalueVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn math_initial_value_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn math_initial_value_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn math_initial_value_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn math_initial_value_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn math_initial_value_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn math_initial_value_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn math_initial_value_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn math_initial_value_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn math_initial_value_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn math_initial_value_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn math_initial_value_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn math_initial_value_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn math_initial_value_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn math_initial_value_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn math_initial_value_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn math_initial_value_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn math_initial_value_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn math_initial_value_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn math_initial_value_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn math_initial_value_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn math_initial_value_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn math_initial_value_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn math_initial_value_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn math_initial_value_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn math_initial_value_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn math_initial_value_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn math_initial_value_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn math_initial_value_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn math_initial_value_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct MathinitialvalueFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_initial_value_frame_make(size : Int) -> MathinitialvalueFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_initial_value_frame_len(s : MathinitialvalueFrame) -> Int { s.size }

pub fn math_initial_value_frame_get(s : MathinitialvalueFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_initial_value_frame_set(s : MathinitialvalueFrame, i : Int, v : Double) -> MathinitialvalueFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_initial_value_frame_sum(s : MathinitialvalueFrame) -> Double { @_common.sum(s.data) }

pub fn math_initial_value_frame_mean(s : MathinitialvalueFrame) -> Double { @_common.mean(s.data) }

pub fn math_initial_value_frame_scale(s : MathinitialvalueFrame, f : Double) -> MathinitialvalueFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_initial_value_frame_add(a : MathinitialvalueFrame, b : MathinitialvalueFrame) -> MathinitialvalueFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_initial_value_frame_copy(s : MathinitialvalueFrame) -> MathinitialvalueFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_initial_value_frame_fill(s : MathinitialvalueFrame, v : Double) -> MathinitialvalueFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_initial_value_frame_min(s : MathinitialvalueFrame) -> Double { @_common.min(s.data) }

pub fn math_initial_value_frame_max(s : MathinitialvalueFrame) -> Double { @_common.max(s.data) }

pub fn math_initial_value_frame_to_string(s : MathinitialvalueFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathinitialvalueTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_initial_value_table_make(size : Int) -> MathinitialvalueTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_initial_value_table_len(s : MathinitialvalueTable) -> Int { s.size }

pub fn math_initial_value_table_get(s : MathinitialvalueTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_initial_value_table_set(s : MathinitialvalueTable, i : Int, v : Double) -> MathinitialvalueTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_initial_value_table_sum(s : MathinitialvalueTable) -> Double { @_common.sum(s.data) }

pub fn math_initial_value_table_mean(s : MathinitialvalueTable) -> Double { @_common.mean(s.data) }

pub fn math_initial_value_table_scale(s : MathinitialvalueTable, f : Double) -> MathinitialvalueTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_initial_value_table_add(a : MathinitialvalueTable, b : MathinitialvalueTable) -> MathinitialvalueTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_initial_value_table_copy(s : MathinitialvalueTable) -> MathinitialvalueTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_initial_value_table_fill(s : MathinitialvalueTable, v : Double) -> MathinitialvalueTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_initial_value_table_min(s : MathinitialvalueTable) -> Double { @_common.min(s.data) }

pub fn math_initial_value_table_max(s : MathinitialvalueTable) -> Double { @_common.max(s.data) }

pub fn math_initial_value_table_to_string(s : MathinitialvalueTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathinitialvalueGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_initial_value_graphn_make(size : Int) -> MathinitialvalueGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_initial_value_graphn_len(s : MathinitialvalueGraphN) -> Int { s.size }

pub fn math_initial_value_graphn_get(s : MathinitialvalueGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_initial_value_graphn_set(s : MathinitialvalueGraphN, i : Int, v : Double) -> MathinitialvalueGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_initial_value_graphn_sum(s : MathinitialvalueGraphN) -> Double { @_common.sum(s.data) }

pub fn math_initial_value_graphn_mean(s : MathinitialvalueGraphN) -> Double { @_common.mean(s.data) }

pub fn math_initial_value_graphn_scale(s : MathinitialvalueGraphN, f : Double) -> MathinitialvalueGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_initial_value_graphn_add(a : MathinitialvalueGraphN, b : MathinitialvalueGraphN) -> MathinitialvalueGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_initial_value_graphn_copy(s : MathinitialvalueGraphN) -> MathinitialvalueGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_initial_value_graphn_fill(s : MathinitialvalueGraphN, v : Double) -> MathinitialvalueGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_initial_value_graphn_min(s : MathinitialvalueGraphN) -> Double { @_common.min(s.data) }

pub fn math_initial_value_graphn_max(s : MathinitialvalueGraphN) -> Double { @_common.max(s.data) }

pub fn math_initial_value_graphn_to_string(s : MathinitialvalueGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathinitialvalueNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_initial_value_node_make(size : Int) -> MathinitialvalueNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_initial_value_node_len(s : MathinitialvalueNode) -> Int { s.size }

pub fn math_initial_value_node_get(s : MathinitialvalueNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_initial_value_node_set(s : MathinitialvalueNode, i : Int, v : Double) -> MathinitialvalueNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_initial_value_node_sum(s : MathinitialvalueNode) -> Double { @_common.sum(s.data) }

pub fn math_initial_value_node_mean(s : MathinitialvalueNode) -> Double { @_common.mean(s.data) }

pub fn math_initial_value_node_scale(s : MathinitialvalueNode, f : Double) -> MathinitialvalueNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_initial_value_node_add(a : MathinitialvalueNode, b : MathinitialvalueNode) -> MathinitialvalueNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_initial_value_node_copy(s : MathinitialvalueNode) -> MathinitialvalueNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_initial_value_node_fill(s : MathinitialvalueNode, v : Double) -> MathinitialvalueNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_initial_value_node_min(s : MathinitialvalueNode) -> Double { @_common.min(s.data) }

pub fn math_initial_value_node_max(s : MathinitialvalueNode) -> Double { @_common.max(s.data) }

pub fn math_initial_value_node_to_string(s : MathinitialvalueNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathinitialvalueEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_initial_value_edge_make(size : Int) -> MathinitialvalueEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_initial_value_edge_len(s : MathinitialvalueEdge) -> Int { s.size }

pub fn math_initial_value_edge_get(s : MathinitialvalueEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_initial_value_edge_set(s : MathinitialvalueEdge, i : Int, v : Double) -> MathinitialvalueEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_initial_value_edge_sum(s : MathinitialvalueEdge) -> Double { @_common.sum(s.data) }

pub fn math_initial_value_edge_mean(s : MathinitialvalueEdge) -> Double { @_common.mean(s.data) }

pub fn math_initial_value_edge_scale(s : MathinitialvalueEdge, f : Double) -> MathinitialvalueEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_initial_value_edge_add(a : MathinitialvalueEdge, b : MathinitialvalueEdge) -> MathinitialvalueEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_initial_value_edge_copy(s : MathinitialvalueEdge) -> MathinitialvalueEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_initial_value_edge_fill(s : MathinitialvalueEdge, v : Double) -> MathinitialvalueEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_initial_value_edge_min(s : MathinitialvalueEdge) -> Double { @_common.min(s.data) }

pub fn math_initial_value_edge_max(s : MathinitialvalueEdge) -> Double { @_common.max(s.data) }

pub fn math_initial_value_edge_to_string(s : MathinitialvalueEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathinitialvaluePath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_initial_value_path_make(size : Int) -> MathinitialvaluePath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_initial_value_path_len(s : MathinitialvaluePath) -> Int { s.size }

pub fn math_initial_value_path_get(s : MathinitialvaluePath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_initial_value_path_set(s : MathinitialvaluePath, i : Int, v : Double) -> MathinitialvaluePath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_initial_value_path_sum(s : MathinitialvaluePath) -> Double { @_common.sum(s.data) }

pub fn math_initial_value_path_mean(s : MathinitialvaluePath) -> Double { @_common.mean(s.data) }

pub fn math_initial_value_path_scale(s : MathinitialvaluePath, f : Double) -> MathinitialvaluePath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_initial_value_path_add(a : MathinitialvaluePath, b : MathinitialvaluePath) -> MathinitialvaluePath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_initial_value_path_copy(s : MathinitialvaluePath) -> MathinitialvaluePath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_initial_value_path_fill(s : MathinitialvaluePath, v : Double) -> MathinitialvaluePath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_initial_value_path_min(s : MathinitialvaluePath) -> Double { @_common.min(s.data) }

pub fn math_initial_value_path_max(s : MathinitialvaluePath) -> Double { @_common.max(s.data) }

pub fn math_initial_value_path_to_string(s : MathinitialvaluePath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathinitialvalueCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_initial_value_cluster_make(size : Int) -> MathinitialvalueCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_initial_value_cluster_len(s : MathinitialvalueCluster) -> Int { s.size }

pub fn math_initial_value_cluster_get(s : MathinitialvalueCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_initial_value_cluster_set(s : MathinitialvalueCluster, i : Int, v : Double) -> MathinitialvalueCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_initial_value_cluster_sum(s : MathinitialvalueCluster) -> Double { @_common.sum(s.data) }

pub fn math_initial_value_cluster_mean(s : MathinitialvalueCluster) -> Double { @_common.mean(s.data) }

pub fn math_initial_value_cluster_scale(s : MathinitialvalueCluster, f : Double) -> MathinitialvalueCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_initial_value_cluster_add(a : MathinitialvalueCluster, b : MathinitialvalueCluster) -> MathinitialvalueCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_initial_value_cluster_copy(s : MathinitialvalueCluster) -> MathinitialvalueCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_initial_value_cluster_fill(s : MathinitialvalueCluster, v : Double) -> MathinitialvalueCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_initial_value_cluster_min(s : MathinitialvalueCluster) -> Double { @_common.min(s.data) }

pub fn math_initial_value_cluster_max(s : MathinitialvalueCluster) -> Double { @_common.max(s.data) }

pub fn math_initial_value_cluster_to_string(s : MathinitialvalueCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathinitialvalueModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_initial_value_model_make(size : Int) -> MathinitialvalueModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_initial_value_model_len(s : MathinitialvalueModel) -> Int { s.size }

pub fn math_initial_value_model_get(s : MathinitialvalueModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_initial_value_model_set(s : MathinitialvalueModel, i : Int, v : Double) -> MathinitialvalueModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_initial_value_model_sum(s : MathinitialvalueModel) -> Double { @_common.sum(s.data) }

pub fn math_initial_value_model_mean(s : MathinitialvalueModel) -> Double { @_common.mean(s.data) }

pub fn math_initial_value_model_scale(s : MathinitialvalueModel, f : Double) -> MathinitialvalueModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_initial_value_model_add(a : MathinitialvalueModel, b : MathinitialvalueModel) -> MathinitialvalueModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_initial_value_model_copy(s : MathinitialvalueModel) -> MathinitialvalueModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_initial_value_model_fill(s : MathinitialvalueModel, v : Double) -> MathinitialvalueModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_initial_value_model_min(s : MathinitialvalueModel) -> Double { @_common.min(s.data) }

pub fn math_initial_value_model_max(s : MathinitialvalueModel) -> Double { @_common.max(s.data) }

pub fn math_initial_value_model_to_string(s : MathinitialvalueModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathinitialvalueLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_initial_value_layer_make(size : Int) -> MathinitialvalueLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_initial_value_layer_len(s : MathinitialvalueLayer) -> Int { s.size }

pub fn math_initial_value_layer_get(s : MathinitialvalueLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_initial_value_layer_set(s : MathinitialvalueLayer, i : Int, v : Double) -> MathinitialvalueLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_initial_value_layer_sum(s : MathinitialvalueLayer) -> Double { @_common.sum(s.data) }

pub fn math_initial_value_layer_mean(s : MathinitialvalueLayer) -> Double { @_common.mean(s.data) }

pub fn math_initial_value_layer_scale(s : MathinitialvalueLayer, f : Double) -> MathinitialvalueLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_initial_value_layer_add(a : MathinitialvalueLayer, b : MathinitialvalueLayer) -> MathinitialvalueLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_initial_value_layer_copy(s : MathinitialvalueLayer) -> MathinitialvalueLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_initial_value_layer_fill(s : MathinitialvalueLayer, v : Double) -> MathinitialvalueLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_initial_value_layer_min(s : MathinitialvalueLayer) -> Double { @_common.min(s.data) }

pub fn math_initial_value_layer_max(s : MathinitialvalueLayer) -> Double { @_common.max(s.data) }

pub fn math_initial_value_layer_to_string(s : MathinitialvalueLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathinitialvalueBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_initial_value_buffer_make(size : Int) -> MathinitialvalueBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_initial_value_buffer_len(s : MathinitialvalueBuffer) -> Int { s.size }

pub fn math_initial_value_buffer_get(s : MathinitialvalueBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_initial_value_buffer_set(s : MathinitialvalueBuffer, i : Int, v : Double) -> MathinitialvalueBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_initial_value_buffer_sum(s : MathinitialvalueBuffer) -> Double { @_common.sum(s.data) }

pub fn math_initial_value_buffer_mean(s : MathinitialvalueBuffer) -> Double { @_common.mean(s.data) }

pub fn math_initial_value_buffer_scale(s : MathinitialvalueBuffer, f : Double) -> MathinitialvalueBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_initial_value_buffer_add(a : MathinitialvalueBuffer, b : MathinitialvalueBuffer) -> MathinitialvalueBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_initial_value_buffer_copy(s : MathinitialvalueBuffer) -> MathinitialvalueBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_initial_value_buffer_fill(s : MathinitialvalueBuffer, v : Double) -> MathinitialvalueBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_initial_value_buffer_min(s : MathinitialvalueBuffer) -> Double { @_common.min(s.data) }

pub fn math_initial_value_buffer_max(s : MathinitialvalueBuffer) -> Double { @_common.max(s.data) }

pub fn math_initial_value_buffer_to_string(s : MathinitialvalueBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathinitialvalueCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_initial_value_cursor_make(size : Int) -> MathinitialvalueCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_initial_value_cursor_len(s : MathinitialvalueCursor) -> Int { s.size }

pub fn math_initial_value_cursor_get(s : MathinitialvalueCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_initial_value_cursor_set(s : MathinitialvalueCursor, i : Int, v : Double) -> MathinitialvalueCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_initial_value_cursor_sum(s : MathinitialvalueCursor) -> Double { @_common.sum(s.data) }

pub fn math_initial_value_cursor_mean(s : MathinitialvalueCursor) -> Double { @_common.mean(s.data) }

pub fn math_initial_value_cursor_scale(s : MathinitialvalueCursor, f : Double) -> MathinitialvalueCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_initial_value_cursor_add(a : MathinitialvalueCursor, b : MathinitialvalueCursor) -> MathinitialvalueCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_initial_value_cursor_copy(s : MathinitialvalueCursor) -> MathinitialvalueCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_initial_value_cursor_fill(s : MathinitialvalueCursor, v : Double) -> MathinitialvalueCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_initial_value_cursor_min(s : MathinitialvalueCursor) -> Double { @_common.min(s.data) }

pub fn math_initial_value_cursor_max(s : MathinitialvalueCursor) -> Double { @_common.max(s.data) }

pub fn math_initial_value_cursor_to_string(s : MathinitialvalueCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathinitialvalueView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_initial_value_view_make(size : Int) -> MathinitialvalueView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_initial_value_view_len(s : MathinitialvalueView) -> Int { s.size }

pub fn math_initial_value_view_get(s : MathinitialvalueView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_initial_value_view_set(s : MathinitialvalueView, i : Int, v : Double) -> MathinitialvalueView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_initial_value_view_sum(s : MathinitialvalueView) -> Double { @_common.sum(s.data) }

pub fn math_initial_value_view_mean(s : MathinitialvalueView) -> Double { @_common.mean(s.data) }

pub fn math_initial_value_view_scale(s : MathinitialvalueView, f : Double) -> MathinitialvalueView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_initial_value_view_add(a : MathinitialvalueView, b : MathinitialvalueView) -> MathinitialvalueView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_initial_value_view_copy(s : MathinitialvalueView) -> MathinitialvalueView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_initial_value_view_fill(s : MathinitialvalueView, v : Double) -> MathinitialvalueView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_initial_value_view_min(s : MathinitialvalueView) -> Double { @_common.min(s.data) }

pub fn math_initial_value_view_max(s : MathinitialvalueView) -> Double { @_common.max(s.data) }

pub fn math_initial_value_view_to_string(s : MathinitialvalueView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathinitialvalueRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_initial_value_range_make(size : Int) -> MathinitialvalueRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_initial_value_range_len(s : MathinitialvalueRange) -> Int { s.size }

pub fn math_initial_value_range_get(s : MathinitialvalueRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_initial_value_range_set(s : MathinitialvalueRange, i : Int, v : Double) -> MathinitialvalueRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_initial_value_range_sum(s : MathinitialvalueRange) -> Double { @_common.sum(s.data) }

pub fn math_initial_value_range_mean(s : MathinitialvalueRange) -> Double { @_common.mean(s.data) }

pub fn math_initial_value_range_scale(s : MathinitialvalueRange, f : Double) -> MathinitialvalueRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_initial_value_range_add(a : MathinitialvalueRange, b : MathinitialvalueRange) -> MathinitialvalueRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_initial_value_range_copy(s : MathinitialvalueRange) -> MathinitialvalueRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_initial_value_range_fill(s : MathinitialvalueRange, v : Double) -> MathinitialvalueRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_initial_value_range_min(s : MathinitialvalueRange) -> Double { @_common.min(s.data) }

pub fn math_initial_value_range_max(s : MathinitialvalueRange) -> Double { @_common.max(s.data) }

pub fn math_initial_value_range_to_string(s : MathinitialvalueRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathinitialvalueSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_initial_value_slice_make(size : Int) -> MathinitialvalueSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_initial_value_slice_len(s : MathinitialvalueSlice) -> Int { s.size }

pub fn math_initial_value_slice_get(s : MathinitialvalueSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_initial_value_slice_set(s : MathinitialvalueSlice, i : Int, v : Double) -> MathinitialvalueSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_initial_value_slice_sum(s : MathinitialvalueSlice) -> Double { @_common.sum(s.data) }

pub fn math_initial_value_slice_mean(s : MathinitialvalueSlice) -> Double { @_common.mean(s.data) }

pub fn math_initial_value_slice_scale(s : MathinitialvalueSlice, f : Double) -> MathinitialvalueSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_initial_value_slice_add(a : MathinitialvalueSlice, b : MathinitialvalueSlice) -> MathinitialvalueSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_initial_value_slice_copy(s : MathinitialvalueSlice) -> MathinitialvalueSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_initial_value_slice_fill(s : MathinitialvalueSlice, v : Double) -> MathinitialvalueSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_initial_value_slice_min(s : MathinitialvalueSlice) -> Double { @_common.min(s.data) }

pub fn math_initial_value_slice_max(s : MathinitialvalueSlice) -> Double { @_common.max(s.data) }

pub fn math_initial_value_slice_to_string(s : MathinitialvalueSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

