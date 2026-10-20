///===
/// extcore/geo_buffer_segment

pub(all) struct GeobuffersegmentPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn geo_buffer_segment_make_point(x : Double, y : Double) -> GeobuffersegmentPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn geo_buffer_segment_make_point3(x : Double, y : Double, z : Double) -> GeobuffersegmentPoint {
  { x, y, z, label: 0 }
}

pub fn GeobuffersegmentPoint::x(self : GeobuffersegmentPoint) -> Double { self.x }

pub fn GeobuffersegmentPoint::y(self : GeobuffersegmentPoint) -> Double { self.y }

pub fn GeobuffersegmentPoint::z(self : GeobuffersegmentPoint) -> Double { self.z }

pub fn GeobuffersegmentPoint::label(self : GeobuffersegmentPoint) -> Int { self.label }

pub fn GeobuffersegmentPoint::dist(self : GeobuffersegmentPoint, other : GeobuffersegmentPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn GeobuffersegmentPoint::add(self : GeobuffersegmentPoint, other : GeobuffersegmentPoint) -> GeobuffersegmentPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn GeobuffersegmentPoint::sub(self : GeobuffersegmentPoint, other : GeobuffersegmentPoint) -> GeobuffersegmentPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn GeobuffersegmentPoint::scale(self : GeobuffersegmentPoint, s : Double) -> GeobuffersegmentPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn GeobuffersegmentPoint::dot(self : GeobuffersegmentPoint, other : GeobuffersegmentPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn GeobuffersegmentPoint::cross(self : GeobuffersegmentPoint, other : GeobuffersegmentPoint) -> GeobuffersegmentPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn GeobuffersegmentPoint::norm(self : GeobuffersegmentPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn GeobuffersegmentPoint::normalize(self : GeobuffersegmentPoint) -> GeobuffersegmentPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn GeobuffersegmentPoint::negate(self : GeobuffersegmentPoint) -> GeobuffersegmentPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn GeobuffersegmentPoint::mid(self : GeobuffersegmentPoint, other : GeobuffersegmentPoint) -> GeobuffersegmentPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn GeobuffersegmentPoint::lerp(self : GeobuffersegmentPoint, other : GeobuffersegmentPoint, t : Double) -> GeobuffersegmentPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn GeobuffersegmentPoint::to_string(self : GeobuffersegmentPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct GeobuffersegmentSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn geo_buffer_segment_make_series(vals : Array[Double], name : String) -> GeobuffersegmentSeries {
  { vals, name, meta: 0 }
}

pub fn GeobuffersegmentSeries::len(self : GeobuffersegmentSeries) -> Int { self.vals.length() }

pub fn GeobuffersegmentSeries::sum(self : GeobuffersegmentSeries) -> Double { @_common.sum(self.vals) }

pub fn GeobuffersegmentSeries::mean(self : GeobuffersegmentSeries) -> Double { @_common.mean(self.vals) }

pub fn GeobuffersegmentSeries::min(self : GeobuffersegmentSeries) -> Double { @_common.min(self.vals) }

pub fn GeobuffersegmentSeries::max(self : GeobuffersegmentSeries) -> Double { @_common.max(self.vals) }

pub fn GeobuffersegmentSeries::range(self : GeobuffersegmentSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn GeobuffersegmentSeries::variance(self : GeobuffersegmentSeries) -> Double { @_common.variance(self.vals) }

pub fn GeobuffersegmentSeries::std(self : GeobuffersegmentSeries) -> Double { @_common.std(self.vals) }

pub fn GeobuffersegmentSeries::median(self : GeobuffersegmentSeries) -> Double { @_common.median(self.vals) }

pub fn GeobuffersegmentSeries::scale(self : GeobuffersegmentSeries, f : Double) -> GeobuffersegmentSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn GeobuffersegmentSeries::add(self : GeobuffersegmentSeries, other : GeobuffersegmentSeries) -> GeobuffersegmentSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn GeobuffersegmentSeries::sub(self : GeobuffersegmentSeries, other : GeobuffersegmentSeries) -> GeobuffersegmentSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn GeobuffersegmentSeries::normalize(self : GeobuffersegmentSeries) -> GeobuffersegmentSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn GeobuffersegmentSeries::cumsum(self : GeobuffersegmentSeries) -> GeobuffersegmentSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn GeobuffersegmentSeries::to_string(self : GeobuffersegmentSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct GeobuffersegmentMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn geo_buffer_segment_make_matrix(rows : Int, cols : Int, val : Double) -> GeobuffersegmentMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn geo_buffer_segment_matrix_identity(n : Int) -> GeobuffersegmentMatrix {
  let m = geo_buffer_segment_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn GeobuffersegmentMatrix::get(self : GeobuffersegmentMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn GeobuffersegmentMatrix::transpose(self : GeobuffersegmentMatrix) -> GeobuffersegmentMatrix {
  let result = geo_buffer_segment_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn GeobuffersegmentMatrix::add(self : GeobuffersegmentMatrix, other : GeobuffersegmentMatrix) -> GeobuffersegmentMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = geo_buffer_segment_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn GeobuffersegmentMatrix::scale(self : GeobuffersegmentMatrix, s : Double) -> GeobuffersegmentMatrix {
  let result = geo_buffer_segment_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn GeobuffersegmentMatrix::multiply(self : GeobuffersegmentMatrix, other : GeobuffersegmentMatrix) -> GeobuffersegmentMatrix {
  if self.cols != other.rows { return geo_buffer_segment_make_matrix(self.rows, other.cols, 0.0) }
  let result = geo_buffer_segment_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn GeobuffersegmentMatrix::trace(self : GeobuffersegmentMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn GeobuffersegmentMatrix::det(self : GeobuffersegmentMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn GeobuffersegmentMatrix::norm(self : GeobuffersegmentMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn GeobuffersegmentMatrix::to_string(self : GeobuffersegmentMatrix) -> String {
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

pub(all) struct GeobuffersegmentVector {
  comps : Array[Double]
  dim : Int
}

pub fn geo_buffer_segment_make_vector(comps : Array[Double]) -> GeobuffersegmentVector {
  { comps, dim: comps.length() }
}

pub fn geo_buffer_segment_vector_zero(dim : Int) -> GeobuffersegmentVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn GeobuffersegmentVector::add(self : GeobuffersegmentVector, other : GeobuffersegmentVector) -> GeobuffersegmentVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn GeobuffersegmentVector::sub(self : GeobuffersegmentVector, other : GeobuffersegmentVector) -> GeobuffersegmentVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn GeobuffersegmentVector::scale(self : GeobuffersegmentVector, s : Double) -> GeobuffersegmentVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn GeobuffersegmentVector::dot(self : GeobuffersegmentVector, other : GeobuffersegmentVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn GeobuffersegmentVector::norm(self : GeobuffersegmentVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn GeobuffersegmentVector::normalize(self : GeobuffersegmentVector) -> GeobuffersegmentVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn GeobuffersegmentVector::dist(self : GeobuffersegmentVector, other : GeobuffersegmentVector) -> Double {
  self.sub(other).norm()
}

pub fn GeobuffersegmentVector::to_string(self : GeobuffersegmentVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn geo_buffer_segment_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn geo_buffer_segment_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn geo_buffer_segment_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn geo_buffer_segment_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn geo_buffer_segment_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn geo_buffer_segment_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn geo_buffer_segment_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn geo_buffer_segment_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn geo_buffer_segment_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn geo_buffer_segment_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn geo_buffer_segment_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn geo_buffer_segment_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn geo_buffer_segment_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn geo_buffer_segment_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn geo_buffer_segment_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn geo_buffer_segment_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn geo_buffer_segment_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn geo_buffer_segment_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn geo_buffer_segment_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn geo_buffer_segment_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn geo_buffer_segment_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn geo_buffer_segment_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn geo_buffer_segment_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn geo_buffer_segment_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn geo_buffer_segment_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn geo_buffer_segment_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn geo_buffer_segment_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn geo_buffer_segment_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn geo_buffer_segment_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct GeobuffersegmentFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_buffer_segment_frame_make(size : Int) -> GeobuffersegmentFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_buffer_segment_frame_len(s : GeobuffersegmentFrame) -> Int { s.size }

pub fn geo_buffer_segment_frame_get(s : GeobuffersegmentFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_buffer_segment_frame_set(s : GeobuffersegmentFrame, i : Int, v : Double) -> GeobuffersegmentFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn geo_buffer_segment_frame_sum(s : GeobuffersegmentFrame) -> Double { @_common.sum(s.data) }

pub fn geo_buffer_segment_frame_mean(s : GeobuffersegmentFrame) -> Double { @_common.mean(s.data) }

pub fn geo_buffer_segment_frame_scale(s : GeobuffersegmentFrame, f : Double) -> GeobuffersegmentFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_buffer_segment_frame_add(a : GeobuffersegmentFrame, b : GeobuffersegmentFrame) -> GeobuffersegmentFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_buffer_segment_frame_copy(s : GeobuffersegmentFrame) -> GeobuffersegmentFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_buffer_segment_frame_fill(s : GeobuffersegmentFrame, v : Double) -> GeobuffersegmentFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_buffer_segment_frame_min(s : GeobuffersegmentFrame) -> Double { @_common.min(s.data) }

pub fn geo_buffer_segment_frame_max(s : GeobuffersegmentFrame) -> Double { @_common.max(s.data) }

pub fn geo_buffer_segment_frame_to_string(s : GeobuffersegmentFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeobuffersegmentTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_buffer_segment_table_make(size : Int) -> GeobuffersegmentTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_buffer_segment_table_len(s : GeobuffersegmentTable) -> Int { s.size }

pub fn geo_buffer_segment_table_get(s : GeobuffersegmentTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_buffer_segment_table_set(s : GeobuffersegmentTable, i : Int, v : Double) -> GeobuffersegmentTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn geo_buffer_segment_table_sum(s : GeobuffersegmentTable) -> Double { @_common.sum(s.data) }

pub fn geo_buffer_segment_table_mean(s : GeobuffersegmentTable) -> Double { @_common.mean(s.data) }

pub fn geo_buffer_segment_table_scale(s : GeobuffersegmentTable, f : Double) -> GeobuffersegmentTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_buffer_segment_table_add(a : GeobuffersegmentTable, b : GeobuffersegmentTable) -> GeobuffersegmentTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_buffer_segment_table_copy(s : GeobuffersegmentTable) -> GeobuffersegmentTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_buffer_segment_table_fill(s : GeobuffersegmentTable, v : Double) -> GeobuffersegmentTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_buffer_segment_table_min(s : GeobuffersegmentTable) -> Double { @_common.min(s.data) }

pub fn geo_buffer_segment_table_max(s : GeobuffersegmentTable) -> Double { @_common.max(s.data) }

pub fn geo_buffer_segment_table_to_string(s : GeobuffersegmentTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeobuffersegmentGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_buffer_segment_graphn_make(size : Int) -> GeobuffersegmentGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_buffer_segment_graphn_len(s : GeobuffersegmentGraphN) -> Int { s.size }

pub fn geo_buffer_segment_graphn_get(s : GeobuffersegmentGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_buffer_segment_graphn_set(s : GeobuffersegmentGraphN, i : Int, v : Double) -> GeobuffersegmentGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn geo_buffer_segment_graphn_sum(s : GeobuffersegmentGraphN) -> Double { @_common.sum(s.data) }

pub fn geo_buffer_segment_graphn_mean(s : GeobuffersegmentGraphN) -> Double { @_common.mean(s.data) }

pub fn geo_buffer_segment_graphn_scale(s : GeobuffersegmentGraphN, f : Double) -> GeobuffersegmentGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_buffer_segment_graphn_add(a : GeobuffersegmentGraphN, b : GeobuffersegmentGraphN) -> GeobuffersegmentGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_buffer_segment_graphn_copy(s : GeobuffersegmentGraphN) -> GeobuffersegmentGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_buffer_segment_graphn_fill(s : GeobuffersegmentGraphN, v : Double) -> GeobuffersegmentGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_buffer_segment_graphn_min(s : GeobuffersegmentGraphN) -> Double { @_common.min(s.data) }

pub fn geo_buffer_segment_graphn_max(s : GeobuffersegmentGraphN) -> Double { @_common.max(s.data) }

pub fn geo_buffer_segment_graphn_to_string(s : GeobuffersegmentGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeobuffersegmentNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_buffer_segment_node_make(size : Int) -> GeobuffersegmentNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_buffer_segment_node_len(s : GeobuffersegmentNode) -> Int { s.size }

pub fn geo_buffer_segment_node_get(s : GeobuffersegmentNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_buffer_segment_node_set(s : GeobuffersegmentNode, i : Int, v : Double) -> GeobuffersegmentNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn geo_buffer_segment_node_sum(s : GeobuffersegmentNode) -> Double { @_common.sum(s.data) }

pub fn geo_buffer_segment_node_mean(s : GeobuffersegmentNode) -> Double { @_common.mean(s.data) }

pub fn geo_buffer_segment_node_scale(s : GeobuffersegmentNode, f : Double) -> GeobuffersegmentNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_buffer_segment_node_add(a : GeobuffersegmentNode, b : GeobuffersegmentNode) -> GeobuffersegmentNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_buffer_segment_node_copy(s : GeobuffersegmentNode) -> GeobuffersegmentNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_buffer_segment_node_fill(s : GeobuffersegmentNode, v : Double) -> GeobuffersegmentNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_buffer_segment_node_min(s : GeobuffersegmentNode) -> Double { @_common.min(s.data) }

pub fn geo_buffer_segment_node_max(s : GeobuffersegmentNode) -> Double { @_common.max(s.data) }

pub fn geo_buffer_segment_node_to_string(s : GeobuffersegmentNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeobuffersegmentEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_buffer_segment_edge_make(size : Int) -> GeobuffersegmentEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_buffer_segment_edge_len(s : GeobuffersegmentEdge) -> Int { s.size }

pub fn geo_buffer_segment_edge_get(s : GeobuffersegmentEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_buffer_segment_edge_set(s : GeobuffersegmentEdge, i : Int, v : Double) -> GeobuffersegmentEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn geo_buffer_segment_edge_sum(s : GeobuffersegmentEdge) -> Double { @_common.sum(s.data) }

pub fn geo_buffer_segment_edge_mean(s : GeobuffersegmentEdge) -> Double { @_common.mean(s.data) }

pub fn geo_buffer_segment_edge_scale(s : GeobuffersegmentEdge, f : Double) -> GeobuffersegmentEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_buffer_segment_edge_add(a : GeobuffersegmentEdge, b : GeobuffersegmentEdge) -> GeobuffersegmentEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_buffer_segment_edge_copy(s : GeobuffersegmentEdge) -> GeobuffersegmentEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_buffer_segment_edge_fill(s : GeobuffersegmentEdge, v : Double) -> GeobuffersegmentEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_buffer_segment_edge_min(s : GeobuffersegmentEdge) -> Double { @_common.min(s.data) }

pub fn geo_buffer_segment_edge_max(s : GeobuffersegmentEdge) -> Double { @_common.max(s.data) }

pub fn geo_buffer_segment_edge_to_string(s : GeobuffersegmentEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeobuffersegmentPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_buffer_segment_path_make(size : Int) -> GeobuffersegmentPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_buffer_segment_path_len(s : GeobuffersegmentPath) -> Int { s.size }

pub fn geo_buffer_segment_path_get(s : GeobuffersegmentPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_buffer_segment_path_set(s : GeobuffersegmentPath, i : Int, v : Double) -> GeobuffersegmentPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn geo_buffer_segment_path_sum(s : GeobuffersegmentPath) -> Double { @_common.sum(s.data) }

pub fn geo_buffer_segment_path_mean(s : GeobuffersegmentPath) -> Double { @_common.mean(s.data) }

pub fn geo_buffer_segment_path_scale(s : GeobuffersegmentPath, f : Double) -> GeobuffersegmentPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_buffer_segment_path_add(a : GeobuffersegmentPath, b : GeobuffersegmentPath) -> GeobuffersegmentPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_buffer_segment_path_copy(s : GeobuffersegmentPath) -> GeobuffersegmentPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_buffer_segment_path_fill(s : GeobuffersegmentPath, v : Double) -> GeobuffersegmentPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_buffer_segment_path_min(s : GeobuffersegmentPath) -> Double { @_common.min(s.data) }

pub fn geo_buffer_segment_path_max(s : GeobuffersegmentPath) -> Double { @_common.max(s.data) }

pub fn geo_buffer_segment_path_to_string(s : GeobuffersegmentPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeobuffersegmentCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_buffer_segment_cluster_make(size : Int) -> GeobuffersegmentCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_buffer_segment_cluster_len(s : GeobuffersegmentCluster) -> Int { s.size }

pub fn geo_buffer_segment_cluster_get(s : GeobuffersegmentCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_buffer_segment_cluster_set(s : GeobuffersegmentCluster, i : Int, v : Double) -> GeobuffersegmentCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn geo_buffer_segment_cluster_sum(s : GeobuffersegmentCluster) -> Double { @_common.sum(s.data) }

pub fn geo_buffer_segment_cluster_mean(s : GeobuffersegmentCluster) -> Double { @_common.mean(s.data) }

pub fn geo_buffer_segment_cluster_scale(s : GeobuffersegmentCluster, f : Double) -> GeobuffersegmentCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_buffer_segment_cluster_add(a : GeobuffersegmentCluster, b : GeobuffersegmentCluster) -> GeobuffersegmentCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_buffer_segment_cluster_copy(s : GeobuffersegmentCluster) -> GeobuffersegmentCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_buffer_segment_cluster_fill(s : GeobuffersegmentCluster, v : Double) -> GeobuffersegmentCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_buffer_segment_cluster_min(s : GeobuffersegmentCluster) -> Double { @_common.min(s.data) }

pub fn geo_buffer_segment_cluster_max(s : GeobuffersegmentCluster) -> Double { @_common.max(s.data) }

pub fn geo_buffer_segment_cluster_to_string(s : GeobuffersegmentCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeobuffersegmentModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_buffer_segment_model_make(size : Int) -> GeobuffersegmentModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_buffer_segment_model_len(s : GeobuffersegmentModel) -> Int { s.size }

pub fn geo_buffer_segment_model_get(s : GeobuffersegmentModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_buffer_segment_model_set(s : GeobuffersegmentModel, i : Int, v : Double) -> GeobuffersegmentModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn geo_buffer_segment_model_sum(s : GeobuffersegmentModel) -> Double { @_common.sum(s.data) }

pub fn geo_buffer_segment_model_mean(s : GeobuffersegmentModel) -> Double { @_common.mean(s.data) }

pub fn geo_buffer_segment_model_scale(s : GeobuffersegmentModel, f : Double) -> GeobuffersegmentModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_buffer_segment_model_add(a : GeobuffersegmentModel, b : GeobuffersegmentModel) -> GeobuffersegmentModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_buffer_segment_model_copy(s : GeobuffersegmentModel) -> GeobuffersegmentModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_buffer_segment_model_fill(s : GeobuffersegmentModel, v : Double) -> GeobuffersegmentModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_buffer_segment_model_min(s : GeobuffersegmentModel) -> Double { @_common.min(s.data) }

pub fn geo_buffer_segment_model_max(s : GeobuffersegmentModel) -> Double { @_common.max(s.data) }

pub fn geo_buffer_segment_model_to_string(s : GeobuffersegmentModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeobuffersegmentLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_buffer_segment_layer_make(size : Int) -> GeobuffersegmentLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_buffer_segment_layer_len(s : GeobuffersegmentLayer) -> Int { s.size }

pub fn geo_buffer_segment_layer_get(s : GeobuffersegmentLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_buffer_segment_layer_set(s : GeobuffersegmentLayer, i : Int, v : Double) -> GeobuffersegmentLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn geo_buffer_segment_layer_sum(s : GeobuffersegmentLayer) -> Double { @_common.sum(s.data) }

pub fn geo_buffer_segment_layer_mean(s : GeobuffersegmentLayer) -> Double { @_common.mean(s.data) }

pub fn geo_buffer_segment_layer_scale(s : GeobuffersegmentLayer, f : Double) -> GeobuffersegmentLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_buffer_segment_layer_add(a : GeobuffersegmentLayer, b : GeobuffersegmentLayer) -> GeobuffersegmentLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_buffer_segment_layer_copy(s : GeobuffersegmentLayer) -> GeobuffersegmentLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_buffer_segment_layer_fill(s : GeobuffersegmentLayer, v : Double) -> GeobuffersegmentLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_buffer_segment_layer_min(s : GeobuffersegmentLayer) -> Double { @_common.min(s.data) }

pub fn geo_buffer_segment_layer_max(s : GeobuffersegmentLayer) -> Double { @_common.max(s.data) }

pub fn geo_buffer_segment_layer_to_string(s : GeobuffersegmentLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeobuffersegmentBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_buffer_segment_buffer_make(size : Int) -> GeobuffersegmentBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_buffer_segment_buffer_len(s : GeobuffersegmentBuffer) -> Int { s.size }

pub fn geo_buffer_segment_buffer_get(s : GeobuffersegmentBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_buffer_segment_buffer_set(s : GeobuffersegmentBuffer, i : Int, v : Double) -> GeobuffersegmentBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn geo_buffer_segment_buffer_sum(s : GeobuffersegmentBuffer) -> Double { @_common.sum(s.data) }

pub fn geo_buffer_segment_buffer_mean(s : GeobuffersegmentBuffer) -> Double { @_common.mean(s.data) }

pub fn geo_buffer_segment_buffer_scale(s : GeobuffersegmentBuffer, f : Double) -> GeobuffersegmentBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_buffer_segment_buffer_add(a : GeobuffersegmentBuffer, b : GeobuffersegmentBuffer) -> GeobuffersegmentBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_buffer_segment_buffer_copy(s : GeobuffersegmentBuffer) -> GeobuffersegmentBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_buffer_segment_buffer_fill(s : GeobuffersegmentBuffer, v : Double) -> GeobuffersegmentBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_buffer_segment_buffer_min(s : GeobuffersegmentBuffer) -> Double { @_common.min(s.data) }

pub fn geo_buffer_segment_buffer_max(s : GeobuffersegmentBuffer) -> Double { @_common.max(s.data) }

pub fn geo_buffer_segment_buffer_to_string(s : GeobuffersegmentBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeobuffersegmentCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_buffer_segment_cursor_make(size : Int) -> GeobuffersegmentCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_buffer_segment_cursor_len(s : GeobuffersegmentCursor) -> Int { s.size }

pub fn geo_buffer_segment_cursor_get(s : GeobuffersegmentCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_buffer_segment_cursor_set(s : GeobuffersegmentCursor, i : Int, v : Double) -> GeobuffersegmentCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn geo_buffer_segment_cursor_sum(s : GeobuffersegmentCursor) -> Double { @_common.sum(s.data) }

pub fn geo_buffer_segment_cursor_mean(s : GeobuffersegmentCursor) -> Double { @_common.mean(s.data) }

pub fn geo_buffer_segment_cursor_scale(s : GeobuffersegmentCursor, f : Double) -> GeobuffersegmentCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_buffer_segment_cursor_add(a : GeobuffersegmentCursor, b : GeobuffersegmentCursor) -> GeobuffersegmentCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_buffer_segment_cursor_copy(s : GeobuffersegmentCursor) -> GeobuffersegmentCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_buffer_segment_cursor_fill(s : GeobuffersegmentCursor, v : Double) -> GeobuffersegmentCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_buffer_segment_cursor_min(s : GeobuffersegmentCursor) -> Double { @_common.min(s.data) }

pub fn geo_buffer_segment_cursor_max(s : GeobuffersegmentCursor) -> Double { @_common.max(s.data) }

pub fn geo_buffer_segment_cursor_to_string(s : GeobuffersegmentCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeobuffersegmentView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_buffer_segment_view_make(size : Int) -> GeobuffersegmentView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_buffer_segment_view_len(s : GeobuffersegmentView) -> Int { s.size }

pub fn geo_buffer_segment_view_get(s : GeobuffersegmentView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_buffer_segment_view_set(s : GeobuffersegmentView, i : Int, v : Double) -> GeobuffersegmentView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn geo_buffer_segment_view_sum(s : GeobuffersegmentView) -> Double { @_common.sum(s.data) }

pub fn geo_buffer_segment_view_mean(s : GeobuffersegmentView) -> Double { @_common.mean(s.data) }

pub fn geo_buffer_segment_view_scale(s : GeobuffersegmentView, f : Double) -> GeobuffersegmentView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_buffer_segment_view_add(a : GeobuffersegmentView, b : GeobuffersegmentView) -> GeobuffersegmentView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_buffer_segment_view_copy(s : GeobuffersegmentView) -> GeobuffersegmentView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_buffer_segment_view_fill(s : GeobuffersegmentView, v : Double) -> GeobuffersegmentView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_buffer_segment_view_min(s : GeobuffersegmentView) -> Double { @_common.min(s.data) }

pub fn geo_buffer_segment_view_max(s : GeobuffersegmentView) -> Double { @_common.max(s.data) }

pub fn geo_buffer_segment_view_to_string(s : GeobuffersegmentView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeobuffersegmentRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_buffer_segment_range_make(size : Int) -> GeobuffersegmentRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_buffer_segment_range_len(s : GeobuffersegmentRange) -> Int { s.size }

pub fn geo_buffer_segment_range_get(s : GeobuffersegmentRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_buffer_segment_range_set(s : GeobuffersegmentRange, i : Int, v : Double) -> GeobuffersegmentRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn geo_buffer_segment_range_sum(s : GeobuffersegmentRange) -> Double { @_common.sum(s.data) }

pub fn geo_buffer_segment_range_mean(s : GeobuffersegmentRange) -> Double { @_common.mean(s.data) }

pub fn geo_buffer_segment_range_scale(s : GeobuffersegmentRange, f : Double) -> GeobuffersegmentRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_buffer_segment_range_add(a : GeobuffersegmentRange, b : GeobuffersegmentRange) -> GeobuffersegmentRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_buffer_segment_range_copy(s : GeobuffersegmentRange) -> GeobuffersegmentRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_buffer_segment_range_fill(s : GeobuffersegmentRange, v : Double) -> GeobuffersegmentRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_buffer_segment_range_min(s : GeobuffersegmentRange) -> Double { @_common.min(s.data) }

pub fn geo_buffer_segment_range_max(s : GeobuffersegmentRange) -> Double { @_common.max(s.data) }

pub fn geo_buffer_segment_range_to_string(s : GeobuffersegmentRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeobuffersegmentSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_buffer_segment_slice_make(size : Int) -> GeobuffersegmentSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_buffer_segment_slice_len(s : GeobuffersegmentSlice) -> Int { s.size }

pub fn geo_buffer_segment_slice_get(s : GeobuffersegmentSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_buffer_segment_slice_set(s : GeobuffersegmentSlice, i : Int, v : Double) -> GeobuffersegmentSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn geo_buffer_segment_slice_sum(s : GeobuffersegmentSlice) -> Double { @_common.sum(s.data) }

pub fn geo_buffer_segment_slice_mean(s : GeobuffersegmentSlice) -> Double { @_common.mean(s.data) }

pub fn geo_buffer_segment_slice_scale(s : GeobuffersegmentSlice, f : Double) -> GeobuffersegmentSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_buffer_segment_slice_add(a : GeobuffersegmentSlice, b : GeobuffersegmentSlice) -> GeobuffersegmentSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_buffer_segment_slice_copy(s : GeobuffersegmentSlice) -> GeobuffersegmentSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_buffer_segment_slice_fill(s : GeobuffersegmentSlice, v : Double) -> GeobuffersegmentSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_buffer_segment_slice_min(s : GeobuffersegmentSlice) -> Double { @_common.min(s.data) }

pub fn geo_buffer_segment_slice_max(s : GeobuffersegmentSlice) -> Double { @_common.max(s.data) }

pub fn geo_buffer_segment_slice_to_string(s : GeobuffersegmentSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

