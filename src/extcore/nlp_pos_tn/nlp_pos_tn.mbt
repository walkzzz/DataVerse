///===
/// extcore/nlp_pos_tn

pub(all) struct NlppostnPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn nlp_pos_tn_make_point(x : Double, y : Double) -> NlppostnPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn nlp_pos_tn_make_point3(x : Double, y : Double, z : Double) -> NlppostnPoint {
  { x, y, z, label: 0 }
}

pub fn NlppostnPoint::x(self : NlppostnPoint) -> Double { self.x }

pub fn NlppostnPoint::y(self : NlppostnPoint) -> Double { self.y }

pub fn NlppostnPoint::z(self : NlppostnPoint) -> Double { self.z }

pub fn NlppostnPoint::label(self : NlppostnPoint) -> Int { self.label }

pub fn NlppostnPoint::dist(self : NlppostnPoint, other : NlppostnPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn NlppostnPoint::add(self : NlppostnPoint, other : NlppostnPoint) -> NlppostnPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn NlppostnPoint::sub(self : NlppostnPoint, other : NlppostnPoint) -> NlppostnPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn NlppostnPoint::scale(self : NlppostnPoint, s : Double) -> NlppostnPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn NlppostnPoint::dot(self : NlppostnPoint, other : NlppostnPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn NlppostnPoint::cross(self : NlppostnPoint, other : NlppostnPoint) -> NlppostnPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn NlppostnPoint::norm(self : NlppostnPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn NlppostnPoint::normalize(self : NlppostnPoint) -> NlppostnPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn NlppostnPoint::negate(self : NlppostnPoint) -> NlppostnPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn NlppostnPoint::mid(self : NlppostnPoint, other : NlppostnPoint) -> NlppostnPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn NlppostnPoint::lerp(self : NlppostnPoint, other : NlppostnPoint, t : Double) -> NlppostnPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn NlppostnPoint::to_string(self : NlppostnPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct NlppostnSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn nlp_pos_tn_make_series(vals : Array[Double], name : String) -> NlppostnSeries {
  { vals, name, meta: 0 }
}

pub fn NlppostnSeries::len(self : NlppostnSeries) -> Int { self.vals.length() }

pub fn NlppostnSeries::sum(self : NlppostnSeries) -> Double { @_common.sum(self.vals) }

pub fn NlppostnSeries::mean(self : NlppostnSeries) -> Double { @_common.mean(self.vals) }

pub fn NlppostnSeries::min(self : NlppostnSeries) -> Double { @_common.min(self.vals) }

pub fn NlppostnSeries::max(self : NlppostnSeries) -> Double { @_common.max(self.vals) }

pub fn NlppostnSeries::range(self : NlppostnSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn NlppostnSeries::variance(self : NlppostnSeries) -> Double { @_common.variance(self.vals) }

pub fn NlppostnSeries::std(self : NlppostnSeries) -> Double { @_common.std(self.vals) }

pub fn NlppostnSeries::median(self : NlppostnSeries) -> Double { @_common.median(self.vals) }

pub fn NlppostnSeries::scale(self : NlppostnSeries, f : Double) -> NlppostnSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn NlppostnSeries::add(self : NlppostnSeries, other : NlppostnSeries) -> NlppostnSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn NlppostnSeries::sub(self : NlppostnSeries, other : NlppostnSeries) -> NlppostnSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn NlppostnSeries::normalize(self : NlppostnSeries) -> NlppostnSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn NlppostnSeries::cumsum(self : NlppostnSeries) -> NlppostnSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn NlppostnSeries::to_string(self : NlppostnSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct NlppostnMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn nlp_pos_tn_make_matrix(rows : Int, cols : Int, val : Double) -> NlppostnMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn nlp_pos_tn_matrix_identity(n : Int) -> NlppostnMatrix {
  let m = nlp_pos_tn_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn NlppostnMatrix::get(self : NlppostnMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn NlppostnMatrix::transpose(self : NlppostnMatrix) -> NlppostnMatrix {
  let result = nlp_pos_tn_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn NlppostnMatrix::add(self : NlppostnMatrix, other : NlppostnMatrix) -> NlppostnMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = nlp_pos_tn_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn NlppostnMatrix::scale(self : NlppostnMatrix, s : Double) -> NlppostnMatrix {
  let result = nlp_pos_tn_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn NlppostnMatrix::multiply(self : NlppostnMatrix, other : NlppostnMatrix) -> NlppostnMatrix {
  if self.cols != other.rows { return nlp_pos_tn_make_matrix(self.rows, other.cols, 0.0) }
  let result = nlp_pos_tn_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn NlppostnMatrix::trace(self : NlppostnMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn NlppostnMatrix::det(self : NlppostnMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn NlppostnMatrix::norm(self : NlppostnMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn NlppostnMatrix::to_string(self : NlppostnMatrix) -> String {
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

pub(all) struct NlppostnVector {
  comps : Array[Double]
  dim : Int
}

pub fn nlp_pos_tn_make_vector(comps : Array[Double]) -> NlppostnVector {
  { comps, dim: comps.length() }
}

pub fn nlp_pos_tn_vector_zero(dim : Int) -> NlppostnVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn NlppostnVector::add(self : NlppostnVector, other : NlppostnVector) -> NlppostnVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn NlppostnVector::sub(self : NlppostnVector, other : NlppostnVector) -> NlppostnVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn NlppostnVector::scale(self : NlppostnVector, s : Double) -> NlppostnVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn NlppostnVector::dot(self : NlppostnVector, other : NlppostnVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn NlppostnVector::norm(self : NlppostnVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn NlppostnVector::normalize(self : NlppostnVector) -> NlppostnVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn NlppostnVector::dist(self : NlppostnVector, other : NlppostnVector) -> Double {
  self.sub(other).norm()
}

pub fn NlppostnVector::to_string(self : NlppostnVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn nlp_pos_tn_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn nlp_pos_tn_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn nlp_pos_tn_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn nlp_pos_tn_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn nlp_pos_tn_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn nlp_pos_tn_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn nlp_pos_tn_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn nlp_pos_tn_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn nlp_pos_tn_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn nlp_pos_tn_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn nlp_pos_tn_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn nlp_pos_tn_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn nlp_pos_tn_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn nlp_pos_tn_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn nlp_pos_tn_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn nlp_pos_tn_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn nlp_pos_tn_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn nlp_pos_tn_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn nlp_pos_tn_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn nlp_pos_tn_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn nlp_pos_tn_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn nlp_pos_tn_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn nlp_pos_tn_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn nlp_pos_tn_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn nlp_pos_tn_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn nlp_pos_tn_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn nlp_pos_tn_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn nlp_pos_tn_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn nlp_pos_tn_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct NlppostnFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_pos_tn_frame_make(size : Int) -> NlppostnFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_pos_tn_frame_len(s : NlppostnFrame) -> Int { s.size }

pub fn nlp_pos_tn_frame_get(s : NlppostnFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_pos_tn_frame_set(s : NlppostnFrame, i : Int, v : Double) -> NlppostnFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_pos_tn_frame_sum(s : NlppostnFrame) -> Double { @_common.sum(s.data) }

pub fn nlp_pos_tn_frame_mean(s : NlppostnFrame) -> Double { @_common.mean(s.data) }

pub fn nlp_pos_tn_frame_scale(s : NlppostnFrame, f : Double) -> NlppostnFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_pos_tn_frame_add(a : NlppostnFrame, b : NlppostnFrame) -> NlppostnFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_pos_tn_frame_copy(s : NlppostnFrame) -> NlppostnFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_pos_tn_frame_fill(s : NlppostnFrame, v : Double) -> NlppostnFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_pos_tn_frame_min(s : NlppostnFrame) -> Double { @_common.min(s.data) }

pub fn nlp_pos_tn_frame_max(s : NlppostnFrame) -> Double { @_common.max(s.data) }

pub fn nlp_pos_tn_frame_to_string(s : NlppostnFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlppostnTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_pos_tn_table_make(size : Int) -> NlppostnTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_pos_tn_table_len(s : NlppostnTable) -> Int { s.size }

pub fn nlp_pos_tn_table_get(s : NlppostnTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_pos_tn_table_set(s : NlppostnTable, i : Int, v : Double) -> NlppostnTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_pos_tn_table_sum(s : NlppostnTable) -> Double { @_common.sum(s.data) }

pub fn nlp_pos_tn_table_mean(s : NlppostnTable) -> Double { @_common.mean(s.data) }

pub fn nlp_pos_tn_table_scale(s : NlppostnTable, f : Double) -> NlppostnTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_pos_tn_table_add(a : NlppostnTable, b : NlppostnTable) -> NlppostnTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_pos_tn_table_copy(s : NlppostnTable) -> NlppostnTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_pos_tn_table_fill(s : NlppostnTable, v : Double) -> NlppostnTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_pos_tn_table_min(s : NlppostnTable) -> Double { @_common.min(s.data) }

pub fn nlp_pos_tn_table_max(s : NlppostnTable) -> Double { @_common.max(s.data) }

pub fn nlp_pos_tn_table_to_string(s : NlppostnTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlppostnGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_pos_tn_graphn_make(size : Int) -> NlppostnGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_pos_tn_graphn_len(s : NlppostnGraphN) -> Int { s.size }

pub fn nlp_pos_tn_graphn_get(s : NlppostnGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_pos_tn_graphn_set(s : NlppostnGraphN, i : Int, v : Double) -> NlppostnGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_pos_tn_graphn_sum(s : NlppostnGraphN) -> Double { @_common.sum(s.data) }

pub fn nlp_pos_tn_graphn_mean(s : NlppostnGraphN) -> Double { @_common.mean(s.data) }

pub fn nlp_pos_tn_graphn_scale(s : NlppostnGraphN, f : Double) -> NlppostnGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_pos_tn_graphn_add(a : NlppostnGraphN, b : NlppostnGraphN) -> NlppostnGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_pos_tn_graphn_copy(s : NlppostnGraphN) -> NlppostnGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_pos_tn_graphn_fill(s : NlppostnGraphN, v : Double) -> NlppostnGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_pos_tn_graphn_min(s : NlppostnGraphN) -> Double { @_common.min(s.data) }

pub fn nlp_pos_tn_graphn_max(s : NlppostnGraphN) -> Double { @_common.max(s.data) }

pub fn nlp_pos_tn_graphn_to_string(s : NlppostnGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlppostnNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_pos_tn_node_make(size : Int) -> NlppostnNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_pos_tn_node_len(s : NlppostnNode) -> Int { s.size }

pub fn nlp_pos_tn_node_get(s : NlppostnNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_pos_tn_node_set(s : NlppostnNode, i : Int, v : Double) -> NlppostnNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_pos_tn_node_sum(s : NlppostnNode) -> Double { @_common.sum(s.data) }

pub fn nlp_pos_tn_node_mean(s : NlppostnNode) -> Double { @_common.mean(s.data) }

pub fn nlp_pos_tn_node_scale(s : NlppostnNode, f : Double) -> NlppostnNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_pos_tn_node_add(a : NlppostnNode, b : NlppostnNode) -> NlppostnNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_pos_tn_node_copy(s : NlppostnNode) -> NlppostnNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_pos_tn_node_fill(s : NlppostnNode, v : Double) -> NlppostnNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_pos_tn_node_min(s : NlppostnNode) -> Double { @_common.min(s.data) }

pub fn nlp_pos_tn_node_max(s : NlppostnNode) -> Double { @_common.max(s.data) }

pub fn nlp_pos_tn_node_to_string(s : NlppostnNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlppostnEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_pos_tn_edge_make(size : Int) -> NlppostnEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_pos_tn_edge_len(s : NlppostnEdge) -> Int { s.size }

pub fn nlp_pos_tn_edge_get(s : NlppostnEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_pos_tn_edge_set(s : NlppostnEdge, i : Int, v : Double) -> NlppostnEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_pos_tn_edge_sum(s : NlppostnEdge) -> Double { @_common.sum(s.data) }

pub fn nlp_pos_tn_edge_mean(s : NlppostnEdge) -> Double { @_common.mean(s.data) }

pub fn nlp_pos_tn_edge_scale(s : NlppostnEdge, f : Double) -> NlppostnEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_pos_tn_edge_add(a : NlppostnEdge, b : NlppostnEdge) -> NlppostnEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_pos_tn_edge_copy(s : NlppostnEdge) -> NlppostnEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_pos_tn_edge_fill(s : NlppostnEdge, v : Double) -> NlppostnEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_pos_tn_edge_min(s : NlppostnEdge) -> Double { @_common.min(s.data) }

pub fn nlp_pos_tn_edge_max(s : NlppostnEdge) -> Double { @_common.max(s.data) }

pub fn nlp_pos_tn_edge_to_string(s : NlppostnEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlppostnPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_pos_tn_path_make(size : Int) -> NlppostnPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_pos_tn_path_len(s : NlppostnPath) -> Int { s.size }

pub fn nlp_pos_tn_path_get(s : NlppostnPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_pos_tn_path_set(s : NlppostnPath, i : Int, v : Double) -> NlppostnPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_pos_tn_path_sum(s : NlppostnPath) -> Double { @_common.sum(s.data) }

pub fn nlp_pos_tn_path_mean(s : NlppostnPath) -> Double { @_common.mean(s.data) }

pub fn nlp_pos_tn_path_scale(s : NlppostnPath, f : Double) -> NlppostnPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_pos_tn_path_add(a : NlppostnPath, b : NlppostnPath) -> NlppostnPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_pos_tn_path_copy(s : NlppostnPath) -> NlppostnPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_pos_tn_path_fill(s : NlppostnPath, v : Double) -> NlppostnPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_pos_tn_path_min(s : NlppostnPath) -> Double { @_common.min(s.data) }

pub fn nlp_pos_tn_path_max(s : NlppostnPath) -> Double { @_common.max(s.data) }

pub fn nlp_pos_tn_path_to_string(s : NlppostnPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlppostnCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_pos_tn_cluster_make(size : Int) -> NlppostnCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_pos_tn_cluster_len(s : NlppostnCluster) -> Int { s.size }

pub fn nlp_pos_tn_cluster_get(s : NlppostnCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_pos_tn_cluster_set(s : NlppostnCluster, i : Int, v : Double) -> NlppostnCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_pos_tn_cluster_sum(s : NlppostnCluster) -> Double { @_common.sum(s.data) }

pub fn nlp_pos_tn_cluster_mean(s : NlppostnCluster) -> Double { @_common.mean(s.data) }

pub fn nlp_pos_tn_cluster_scale(s : NlppostnCluster, f : Double) -> NlppostnCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_pos_tn_cluster_add(a : NlppostnCluster, b : NlppostnCluster) -> NlppostnCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_pos_tn_cluster_copy(s : NlppostnCluster) -> NlppostnCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_pos_tn_cluster_fill(s : NlppostnCluster, v : Double) -> NlppostnCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_pos_tn_cluster_min(s : NlppostnCluster) -> Double { @_common.min(s.data) }

pub fn nlp_pos_tn_cluster_max(s : NlppostnCluster) -> Double { @_common.max(s.data) }

pub fn nlp_pos_tn_cluster_to_string(s : NlppostnCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlppostnModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_pos_tn_model_make(size : Int) -> NlppostnModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_pos_tn_model_len(s : NlppostnModel) -> Int { s.size }

pub fn nlp_pos_tn_model_get(s : NlppostnModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_pos_tn_model_set(s : NlppostnModel, i : Int, v : Double) -> NlppostnModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_pos_tn_model_sum(s : NlppostnModel) -> Double { @_common.sum(s.data) }

pub fn nlp_pos_tn_model_mean(s : NlppostnModel) -> Double { @_common.mean(s.data) }

pub fn nlp_pos_tn_model_scale(s : NlppostnModel, f : Double) -> NlppostnModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_pos_tn_model_add(a : NlppostnModel, b : NlppostnModel) -> NlppostnModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_pos_tn_model_copy(s : NlppostnModel) -> NlppostnModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_pos_tn_model_fill(s : NlppostnModel, v : Double) -> NlppostnModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_pos_tn_model_min(s : NlppostnModel) -> Double { @_common.min(s.data) }

pub fn nlp_pos_tn_model_max(s : NlppostnModel) -> Double { @_common.max(s.data) }

pub fn nlp_pos_tn_model_to_string(s : NlppostnModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlppostnLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_pos_tn_layer_make(size : Int) -> NlppostnLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_pos_tn_layer_len(s : NlppostnLayer) -> Int { s.size }

pub fn nlp_pos_tn_layer_get(s : NlppostnLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_pos_tn_layer_set(s : NlppostnLayer, i : Int, v : Double) -> NlppostnLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_pos_tn_layer_sum(s : NlppostnLayer) -> Double { @_common.sum(s.data) }

pub fn nlp_pos_tn_layer_mean(s : NlppostnLayer) -> Double { @_common.mean(s.data) }

pub fn nlp_pos_tn_layer_scale(s : NlppostnLayer, f : Double) -> NlppostnLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_pos_tn_layer_add(a : NlppostnLayer, b : NlppostnLayer) -> NlppostnLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_pos_tn_layer_copy(s : NlppostnLayer) -> NlppostnLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_pos_tn_layer_fill(s : NlppostnLayer, v : Double) -> NlppostnLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_pos_tn_layer_min(s : NlppostnLayer) -> Double { @_common.min(s.data) }

pub fn nlp_pos_tn_layer_max(s : NlppostnLayer) -> Double { @_common.max(s.data) }

pub fn nlp_pos_tn_layer_to_string(s : NlppostnLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlppostnBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_pos_tn_buffer_make(size : Int) -> NlppostnBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_pos_tn_buffer_len(s : NlppostnBuffer) -> Int { s.size }

pub fn nlp_pos_tn_buffer_get(s : NlppostnBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_pos_tn_buffer_set(s : NlppostnBuffer, i : Int, v : Double) -> NlppostnBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_pos_tn_buffer_sum(s : NlppostnBuffer) -> Double { @_common.sum(s.data) }

pub fn nlp_pos_tn_buffer_mean(s : NlppostnBuffer) -> Double { @_common.mean(s.data) }

pub fn nlp_pos_tn_buffer_scale(s : NlppostnBuffer, f : Double) -> NlppostnBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_pos_tn_buffer_add(a : NlppostnBuffer, b : NlppostnBuffer) -> NlppostnBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_pos_tn_buffer_copy(s : NlppostnBuffer) -> NlppostnBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_pos_tn_buffer_fill(s : NlppostnBuffer, v : Double) -> NlppostnBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_pos_tn_buffer_min(s : NlppostnBuffer) -> Double { @_common.min(s.data) }

pub fn nlp_pos_tn_buffer_max(s : NlppostnBuffer) -> Double { @_common.max(s.data) }

pub fn nlp_pos_tn_buffer_to_string(s : NlppostnBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlppostnCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_pos_tn_cursor_make(size : Int) -> NlppostnCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_pos_tn_cursor_len(s : NlppostnCursor) -> Int { s.size }

pub fn nlp_pos_tn_cursor_get(s : NlppostnCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_pos_tn_cursor_set(s : NlppostnCursor, i : Int, v : Double) -> NlppostnCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_pos_tn_cursor_sum(s : NlppostnCursor) -> Double { @_common.sum(s.data) }

pub fn nlp_pos_tn_cursor_mean(s : NlppostnCursor) -> Double { @_common.mean(s.data) }

pub fn nlp_pos_tn_cursor_scale(s : NlppostnCursor, f : Double) -> NlppostnCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_pos_tn_cursor_add(a : NlppostnCursor, b : NlppostnCursor) -> NlppostnCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_pos_tn_cursor_copy(s : NlppostnCursor) -> NlppostnCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_pos_tn_cursor_fill(s : NlppostnCursor, v : Double) -> NlppostnCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_pos_tn_cursor_min(s : NlppostnCursor) -> Double { @_common.min(s.data) }

pub fn nlp_pos_tn_cursor_max(s : NlppostnCursor) -> Double { @_common.max(s.data) }

pub fn nlp_pos_tn_cursor_to_string(s : NlppostnCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlppostnView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_pos_tn_view_make(size : Int) -> NlppostnView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_pos_tn_view_len(s : NlppostnView) -> Int { s.size }

pub fn nlp_pos_tn_view_get(s : NlppostnView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_pos_tn_view_set(s : NlppostnView, i : Int, v : Double) -> NlppostnView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_pos_tn_view_sum(s : NlppostnView) -> Double { @_common.sum(s.data) }

pub fn nlp_pos_tn_view_mean(s : NlppostnView) -> Double { @_common.mean(s.data) }

pub fn nlp_pos_tn_view_scale(s : NlppostnView, f : Double) -> NlppostnView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_pos_tn_view_add(a : NlppostnView, b : NlppostnView) -> NlppostnView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_pos_tn_view_copy(s : NlppostnView) -> NlppostnView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_pos_tn_view_fill(s : NlppostnView, v : Double) -> NlppostnView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_pos_tn_view_min(s : NlppostnView) -> Double { @_common.min(s.data) }

pub fn nlp_pos_tn_view_max(s : NlppostnView) -> Double { @_common.max(s.data) }

pub fn nlp_pos_tn_view_to_string(s : NlppostnView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlppostnRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_pos_tn_range_make(size : Int) -> NlppostnRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_pos_tn_range_len(s : NlppostnRange) -> Int { s.size }

pub fn nlp_pos_tn_range_get(s : NlppostnRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_pos_tn_range_set(s : NlppostnRange, i : Int, v : Double) -> NlppostnRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_pos_tn_range_sum(s : NlppostnRange) -> Double { @_common.sum(s.data) }

pub fn nlp_pos_tn_range_mean(s : NlppostnRange) -> Double { @_common.mean(s.data) }

pub fn nlp_pos_tn_range_scale(s : NlppostnRange, f : Double) -> NlppostnRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_pos_tn_range_add(a : NlppostnRange, b : NlppostnRange) -> NlppostnRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_pos_tn_range_copy(s : NlppostnRange) -> NlppostnRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_pos_tn_range_fill(s : NlppostnRange, v : Double) -> NlppostnRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_pos_tn_range_min(s : NlppostnRange) -> Double { @_common.min(s.data) }

pub fn nlp_pos_tn_range_max(s : NlppostnRange) -> Double { @_common.max(s.data) }

pub fn nlp_pos_tn_range_to_string(s : NlppostnRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlppostnSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_pos_tn_slice_make(size : Int) -> NlppostnSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_pos_tn_slice_len(s : NlppostnSlice) -> Int { s.size }

pub fn nlp_pos_tn_slice_get(s : NlppostnSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_pos_tn_slice_set(s : NlppostnSlice, i : Int, v : Double) -> NlppostnSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_pos_tn_slice_sum(s : NlppostnSlice) -> Double { @_common.sum(s.data) }

pub fn nlp_pos_tn_slice_mean(s : NlppostnSlice) -> Double { @_common.mean(s.data) }

pub fn nlp_pos_tn_slice_scale(s : NlppostnSlice, f : Double) -> NlppostnSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_pos_tn_slice_add(a : NlppostnSlice, b : NlppostnSlice) -> NlppostnSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_pos_tn_slice_copy(s : NlppostnSlice) -> NlppostnSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_pos_tn_slice_fill(s : NlppostnSlice, v : Double) -> NlppostnSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_pos_tn_slice_min(s : NlppostnSlice) -> Double { @_common.min(s.data) }

pub fn nlp_pos_tn_slice_max(s : NlppostnSlice) -> Double { @_common.max(s.data) }

pub fn nlp_pos_tn_slice_to_string(s : NlppostnSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

