///===
/// extcore/geo_buffer_collection

pub(all) struct GeobuffercollectionPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn geo_buffer_collection_make_point(x : Double, y : Double) -> GeobuffercollectionPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn geo_buffer_collection_make_point3(x : Double, y : Double, z : Double) -> GeobuffercollectionPoint {
  { x, y, z, label: 0 }
}

pub fn GeobuffercollectionPoint::x(self : GeobuffercollectionPoint) -> Double { self.x }

pub fn GeobuffercollectionPoint::y(self : GeobuffercollectionPoint) -> Double { self.y }

pub fn GeobuffercollectionPoint::z(self : GeobuffercollectionPoint) -> Double { self.z }

pub fn GeobuffercollectionPoint::label(self : GeobuffercollectionPoint) -> Int { self.label }

pub fn GeobuffercollectionPoint::dist(self : GeobuffercollectionPoint, other : GeobuffercollectionPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn GeobuffercollectionPoint::add(self : GeobuffercollectionPoint, other : GeobuffercollectionPoint) -> GeobuffercollectionPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn GeobuffercollectionPoint::sub(self : GeobuffercollectionPoint, other : GeobuffercollectionPoint) -> GeobuffercollectionPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn GeobuffercollectionPoint::scale(self : GeobuffercollectionPoint, s : Double) -> GeobuffercollectionPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn GeobuffercollectionPoint::dot(self : GeobuffercollectionPoint, other : GeobuffercollectionPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn GeobuffercollectionPoint::cross(self : GeobuffercollectionPoint, other : GeobuffercollectionPoint) -> GeobuffercollectionPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn GeobuffercollectionPoint::norm(self : GeobuffercollectionPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn GeobuffercollectionPoint::normalize(self : GeobuffercollectionPoint) -> GeobuffercollectionPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn GeobuffercollectionPoint::negate(self : GeobuffercollectionPoint) -> GeobuffercollectionPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn GeobuffercollectionPoint::mid(self : GeobuffercollectionPoint, other : GeobuffercollectionPoint) -> GeobuffercollectionPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn GeobuffercollectionPoint::lerp(self : GeobuffercollectionPoint, other : GeobuffercollectionPoint, t : Double) -> GeobuffercollectionPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn GeobuffercollectionPoint::to_string(self : GeobuffercollectionPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct GeobuffercollectionSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn geo_buffer_collection_make_series(vals : Array[Double], name : String) -> GeobuffercollectionSeries {
  { vals, name, meta: 0 }
}

pub fn GeobuffercollectionSeries::len(self : GeobuffercollectionSeries) -> Int { self.vals.length() }

pub fn GeobuffercollectionSeries::sum(self : GeobuffercollectionSeries) -> Double { @_common.sum(self.vals) }

pub fn GeobuffercollectionSeries::mean(self : GeobuffercollectionSeries) -> Double { @_common.mean(self.vals) }

pub fn GeobuffercollectionSeries::min(self : GeobuffercollectionSeries) -> Double { @_common.min(self.vals) }

pub fn GeobuffercollectionSeries::max(self : GeobuffercollectionSeries) -> Double { @_common.max(self.vals) }

pub fn GeobuffercollectionSeries::range(self : GeobuffercollectionSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn GeobuffercollectionSeries::variance(self : GeobuffercollectionSeries) -> Double { @_common.variance(self.vals) }

pub fn GeobuffercollectionSeries::std(self : GeobuffercollectionSeries) -> Double { @_common.std(self.vals) }

pub fn GeobuffercollectionSeries::median(self : GeobuffercollectionSeries) -> Double { @_common.median(self.vals) }

pub fn GeobuffercollectionSeries::scale(self : GeobuffercollectionSeries, f : Double) -> GeobuffercollectionSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn GeobuffercollectionSeries::add(self : GeobuffercollectionSeries, other : GeobuffercollectionSeries) -> GeobuffercollectionSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn GeobuffercollectionSeries::sub(self : GeobuffercollectionSeries, other : GeobuffercollectionSeries) -> GeobuffercollectionSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn GeobuffercollectionSeries::normalize(self : GeobuffercollectionSeries) -> GeobuffercollectionSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn GeobuffercollectionSeries::cumsum(self : GeobuffercollectionSeries) -> GeobuffercollectionSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn GeobuffercollectionSeries::to_string(self : GeobuffercollectionSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct GeobuffercollectionMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn geo_buffer_collection_make_matrix(rows : Int, cols : Int, val : Double) -> GeobuffercollectionMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn geo_buffer_collection_matrix_identity(n : Int) -> GeobuffercollectionMatrix {
  let m = geo_buffer_collection_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn GeobuffercollectionMatrix::get(self : GeobuffercollectionMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn GeobuffercollectionMatrix::transpose(self : GeobuffercollectionMatrix) -> GeobuffercollectionMatrix {
  let result = geo_buffer_collection_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn GeobuffercollectionMatrix::add(self : GeobuffercollectionMatrix, other : GeobuffercollectionMatrix) -> GeobuffercollectionMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = geo_buffer_collection_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn GeobuffercollectionMatrix::scale(self : GeobuffercollectionMatrix, s : Double) -> GeobuffercollectionMatrix {
  let result = geo_buffer_collection_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn GeobuffercollectionMatrix::multiply(self : GeobuffercollectionMatrix, other : GeobuffercollectionMatrix) -> GeobuffercollectionMatrix {
  if self.cols != other.rows { return geo_buffer_collection_make_matrix(self.rows, other.cols, 0.0) }
  let result = geo_buffer_collection_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn GeobuffercollectionMatrix::trace(self : GeobuffercollectionMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn GeobuffercollectionMatrix::det(self : GeobuffercollectionMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn GeobuffercollectionMatrix::norm(self : GeobuffercollectionMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn GeobuffercollectionMatrix::to_string(self : GeobuffercollectionMatrix) -> String {
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

pub(all) struct GeobuffercollectionVector {
  comps : Array[Double]
  dim : Int
}

pub fn geo_buffer_collection_make_vector(comps : Array[Double]) -> GeobuffercollectionVector {
  { comps, dim: comps.length() }
}

pub fn geo_buffer_collection_vector_zero(dim : Int) -> GeobuffercollectionVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn GeobuffercollectionVector::add(self : GeobuffercollectionVector, other : GeobuffercollectionVector) -> GeobuffercollectionVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn GeobuffercollectionVector::sub(self : GeobuffercollectionVector, other : GeobuffercollectionVector) -> GeobuffercollectionVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn GeobuffercollectionVector::scale(self : GeobuffercollectionVector, s : Double) -> GeobuffercollectionVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn GeobuffercollectionVector::dot(self : GeobuffercollectionVector, other : GeobuffercollectionVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn GeobuffercollectionVector::norm(self : GeobuffercollectionVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn GeobuffercollectionVector::normalize(self : GeobuffercollectionVector) -> GeobuffercollectionVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn GeobuffercollectionVector::dist(self : GeobuffercollectionVector, other : GeobuffercollectionVector) -> Double {
  self.sub(other).norm()
}

pub fn GeobuffercollectionVector::to_string(self : GeobuffercollectionVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn geo_buffer_collection_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn geo_buffer_collection_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn geo_buffer_collection_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn geo_buffer_collection_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn geo_buffer_collection_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn geo_buffer_collection_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn geo_buffer_collection_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn geo_buffer_collection_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn geo_buffer_collection_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn geo_buffer_collection_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn geo_buffer_collection_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn geo_buffer_collection_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn geo_buffer_collection_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn geo_buffer_collection_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn geo_buffer_collection_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn geo_buffer_collection_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn geo_buffer_collection_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn geo_buffer_collection_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn geo_buffer_collection_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn geo_buffer_collection_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn geo_buffer_collection_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn geo_buffer_collection_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn geo_buffer_collection_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn geo_buffer_collection_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn geo_buffer_collection_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn geo_buffer_collection_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn geo_buffer_collection_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn geo_buffer_collection_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn geo_buffer_collection_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct GeobuffercollectionFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_buffer_collection_frame_make(size : Int) -> GeobuffercollectionFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_buffer_collection_frame_len(s : GeobuffercollectionFrame) -> Int { s.size }

pub fn geo_buffer_collection_frame_get(s : GeobuffercollectionFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_buffer_collection_frame_set(s : GeobuffercollectionFrame, i : Int, v : Double) -> GeobuffercollectionFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn geo_buffer_collection_frame_sum(s : GeobuffercollectionFrame) -> Double { @_common.sum(s.data) }

pub fn geo_buffer_collection_frame_mean(s : GeobuffercollectionFrame) -> Double { @_common.mean(s.data) }

pub fn geo_buffer_collection_frame_scale(s : GeobuffercollectionFrame, f : Double) -> GeobuffercollectionFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_buffer_collection_frame_add(a : GeobuffercollectionFrame, b : GeobuffercollectionFrame) -> GeobuffercollectionFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_buffer_collection_frame_copy(s : GeobuffercollectionFrame) -> GeobuffercollectionFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_buffer_collection_frame_fill(s : GeobuffercollectionFrame, v : Double) -> GeobuffercollectionFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_buffer_collection_frame_min(s : GeobuffercollectionFrame) -> Double { @_common.min(s.data) }

pub fn geo_buffer_collection_frame_max(s : GeobuffercollectionFrame) -> Double { @_common.max(s.data) }

pub fn geo_buffer_collection_frame_to_string(s : GeobuffercollectionFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeobuffercollectionTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_buffer_collection_table_make(size : Int) -> GeobuffercollectionTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_buffer_collection_table_len(s : GeobuffercollectionTable) -> Int { s.size }

pub fn geo_buffer_collection_table_get(s : GeobuffercollectionTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_buffer_collection_table_set(s : GeobuffercollectionTable, i : Int, v : Double) -> GeobuffercollectionTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn geo_buffer_collection_table_sum(s : GeobuffercollectionTable) -> Double { @_common.sum(s.data) }

pub fn geo_buffer_collection_table_mean(s : GeobuffercollectionTable) -> Double { @_common.mean(s.data) }

pub fn geo_buffer_collection_table_scale(s : GeobuffercollectionTable, f : Double) -> GeobuffercollectionTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_buffer_collection_table_add(a : GeobuffercollectionTable, b : GeobuffercollectionTable) -> GeobuffercollectionTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_buffer_collection_table_copy(s : GeobuffercollectionTable) -> GeobuffercollectionTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_buffer_collection_table_fill(s : GeobuffercollectionTable, v : Double) -> GeobuffercollectionTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_buffer_collection_table_min(s : GeobuffercollectionTable) -> Double { @_common.min(s.data) }

pub fn geo_buffer_collection_table_max(s : GeobuffercollectionTable) -> Double { @_common.max(s.data) }

pub fn geo_buffer_collection_table_to_string(s : GeobuffercollectionTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeobuffercollectionGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_buffer_collection_graphn_make(size : Int) -> GeobuffercollectionGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_buffer_collection_graphn_len(s : GeobuffercollectionGraphN) -> Int { s.size }

pub fn geo_buffer_collection_graphn_get(s : GeobuffercollectionGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_buffer_collection_graphn_set(s : GeobuffercollectionGraphN, i : Int, v : Double) -> GeobuffercollectionGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn geo_buffer_collection_graphn_sum(s : GeobuffercollectionGraphN) -> Double { @_common.sum(s.data) }

pub fn geo_buffer_collection_graphn_mean(s : GeobuffercollectionGraphN) -> Double { @_common.mean(s.data) }

pub fn geo_buffer_collection_graphn_scale(s : GeobuffercollectionGraphN, f : Double) -> GeobuffercollectionGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_buffer_collection_graphn_add(a : GeobuffercollectionGraphN, b : GeobuffercollectionGraphN) -> GeobuffercollectionGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_buffer_collection_graphn_copy(s : GeobuffercollectionGraphN) -> GeobuffercollectionGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_buffer_collection_graphn_fill(s : GeobuffercollectionGraphN, v : Double) -> GeobuffercollectionGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_buffer_collection_graphn_min(s : GeobuffercollectionGraphN) -> Double { @_common.min(s.data) }

pub fn geo_buffer_collection_graphn_max(s : GeobuffercollectionGraphN) -> Double { @_common.max(s.data) }

pub fn geo_buffer_collection_graphn_to_string(s : GeobuffercollectionGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeobuffercollectionNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_buffer_collection_node_make(size : Int) -> GeobuffercollectionNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_buffer_collection_node_len(s : GeobuffercollectionNode) -> Int { s.size }

pub fn geo_buffer_collection_node_get(s : GeobuffercollectionNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_buffer_collection_node_set(s : GeobuffercollectionNode, i : Int, v : Double) -> GeobuffercollectionNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn geo_buffer_collection_node_sum(s : GeobuffercollectionNode) -> Double { @_common.sum(s.data) }

pub fn geo_buffer_collection_node_mean(s : GeobuffercollectionNode) -> Double { @_common.mean(s.data) }

pub fn geo_buffer_collection_node_scale(s : GeobuffercollectionNode, f : Double) -> GeobuffercollectionNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_buffer_collection_node_add(a : GeobuffercollectionNode, b : GeobuffercollectionNode) -> GeobuffercollectionNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_buffer_collection_node_copy(s : GeobuffercollectionNode) -> GeobuffercollectionNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_buffer_collection_node_fill(s : GeobuffercollectionNode, v : Double) -> GeobuffercollectionNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_buffer_collection_node_min(s : GeobuffercollectionNode) -> Double { @_common.min(s.data) }

pub fn geo_buffer_collection_node_max(s : GeobuffercollectionNode) -> Double { @_common.max(s.data) }

pub fn geo_buffer_collection_node_to_string(s : GeobuffercollectionNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeobuffercollectionEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_buffer_collection_edge_make(size : Int) -> GeobuffercollectionEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_buffer_collection_edge_len(s : GeobuffercollectionEdge) -> Int { s.size }

pub fn geo_buffer_collection_edge_get(s : GeobuffercollectionEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_buffer_collection_edge_set(s : GeobuffercollectionEdge, i : Int, v : Double) -> GeobuffercollectionEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn geo_buffer_collection_edge_sum(s : GeobuffercollectionEdge) -> Double { @_common.sum(s.data) }

pub fn geo_buffer_collection_edge_mean(s : GeobuffercollectionEdge) -> Double { @_common.mean(s.data) }

pub fn geo_buffer_collection_edge_scale(s : GeobuffercollectionEdge, f : Double) -> GeobuffercollectionEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_buffer_collection_edge_add(a : GeobuffercollectionEdge, b : GeobuffercollectionEdge) -> GeobuffercollectionEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_buffer_collection_edge_copy(s : GeobuffercollectionEdge) -> GeobuffercollectionEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_buffer_collection_edge_fill(s : GeobuffercollectionEdge, v : Double) -> GeobuffercollectionEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_buffer_collection_edge_min(s : GeobuffercollectionEdge) -> Double { @_common.min(s.data) }

pub fn geo_buffer_collection_edge_max(s : GeobuffercollectionEdge) -> Double { @_common.max(s.data) }

pub fn geo_buffer_collection_edge_to_string(s : GeobuffercollectionEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeobuffercollectionPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_buffer_collection_path_make(size : Int) -> GeobuffercollectionPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_buffer_collection_path_len(s : GeobuffercollectionPath) -> Int { s.size }

pub fn geo_buffer_collection_path_get(s : GeobuffercollectionPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_buffer_collection_path_set(s : GeobuffercollectionPath, i : Int, v : Double) -> GeobuffercollectionPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn geo_buffer_collection_path_sum(s : GeobuffercollectionPath) -> Double { @_common.sum(s.data) }

pub fn geo_buffer_collection_path_mean(s : GeobuffercollectionPath) -> Double { @_common.mean(s.data) }

pub fn geo_buffer_collection_path_scale(s : GeobuffercollectionPath, f : Double) -> GeobuffercollectionPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_buffer_collection_path_add(a : GeobuffercollectionPath, b : GeobuffercollectionPath) -> GeobuffercollectionPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_buffer_collection_path_copy(s : GeobuffercollectionPath) -> GeobuffercollectionPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_buffer_collection_path_fill(s : GeobuffercollectionPath, v : Double) -> GeobuffercollectionPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_buffer_collection_path_min(s : GeobuffercollectionPath) -> Double { @_common.min(s.data) }

pub fn geo_buffer_collection_path_max(s : GeobuffercollectionPath) -> Double { @_common.max(s.data) }

pub fn geo_buffer_collection_path_to_string(s : GeobuffercollectionPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeobuffercollectionCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_buffer_collection_cluster_make(size : Int) -> GeobuffercollectionCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_buffer_collection_cluster_len(s : GeobuffercollectionCluster) -> Int { s.size }

pub fn geo_buffer_collection_cluster_get(s : GeobuffercollectionCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_buffer_collection_cluster_set(s : GeobuffercollectionCluster, i : Int, v : Double) -> GeobuffercollectionCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn geo_buffer_collection_cluster_sum(s : GeobuffercollectionCluster) -> Double { @_common.sum(s.data) }

pub fn geo_buffer_collection_cluster_mean(s : GeobuffercollectionCluster) -> Double { @_common.mean(s.data) }

pub fn geo_buffer_collection_cluster_scale(s : GeobuffercollectionCluster, f : Double) -> GeobuffercollectionCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_buffer_collection_cluster_add(a : GeobuffercollectionCluster, b : GeobuffercollectionCluster) -> GeobuffercollectionCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_buffer_collection_cluster_copy(s : GeobuffercollectionCluster) -> GeobuffercollectionCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_buffer_collection_cluster_fill(s : GeobuffercollectionCluster, v : Double) -> GeobuffercollectionCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_buffer_collection_cluster_min(s : GeobuffercollectionCluster) -> Double { @_common.min(s.data) }

pub fn geo_buffer_collection_cluster_max(s : GeobuffercollectionCluster) -> Double { @_common.max(s.data) }

pub fn geo_buffer_collection_cluster_to_string(s : GeobuffercollectionCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeobuffercollectionModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_buffer_collection_model_make(size : Int) -> GeobuffercollectionModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_buffer_collection_model_len(s : GeobuffercollectionModel) -> Int { s.size }

pub fn geo_buffer_collection_model_get(s : GeobuffercollectionModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_buffer_collection_model_set(s : GeobuffercollectionModel, i : Int, v : Double) -> GeobuffercollectionModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn geo_buffer_collection_model_sum(s : GeobuffercollectionModel) -> Double { @_common.sum(s.data) }

pub fn geo_buffer_collection_model_mean(s : GeobuffercollectionModel) -> Double { @_common.mean(s.data) }

pub fn geo_buffer_collection_model_scale(s : GeobuffercollectionModel, f : Double) -> GeobuffercollectionModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_buffer_collection_model_add(a : GeobuffercollectionModel, b : GeobuffercollectionModel) -> GeobuffercollectionModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_buffer_collection_model_copy(s : GeobuffercollectionModel) -> GeobuffercollectionModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_buffer_collection_model_fill(s : GeobuffercollectionModel, v : Double) -> GeobuffercollectionModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_buffer_collection_model_min(s : GeobuffercollectionModel) -> Double { @_common.min(s.data) }

pub fn geo_buffer_collection_model_max(s : GeobuffercollectionModel) -> Double { @_common.max(s.data) }

pub fn geo_buffer_collection_model_to_string(s : GeobuffercollectionModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeobuffercollectionLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_buffer_collection_layer_make(size : Int) -> GeobuffercollectionLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_buffer_collection_layer_len(s : GeobuffercollectionLayer) -> Int { s.size }

pub fn geo_buffer_collection_layer_get(s : GeobuffercollectionLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_buffer_collection_layer_set(s : GeobuffercollectionLayer, i : Int, v : Double) -> GeobuffercollectionLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn geo_buffer_collection_layer_sum(s : GeobuffercollectionLayer) -> Double { @_common.sum(s.data) }

pub fn geo_buffer_collection_layer_mean(s : GeobuffercollectionLayer) -> Double { @_common.mean(s.data) }

pub fn geo_buffer_collection_layer_scale(s : GeobuffercollectionLayer, f : Double) -> GeobuffercollectionLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_buffer_collection_layer_add(a : GeobuffercollectionLayer, b : GeobuffercollectionLayer) -> GeobuffercollectionLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_buffer_collection_layer_copy(s : GeobuffercollectionLayer) -> GeobuffercollectionLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_buffer_collection_layer_fill(s : GeobuffercollectionLayer, v : Double) -> GeobuffercollectionLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_buffer_collection_layer_min(s : GeobuffercollectionLayer) -> Double { @_common.min(s.data) }

pub fn geo_buffer_collection_layer_max(s : GeobuffercollectionLayer) -> Double { @_common.max(s.data) }

pub fn geo_buffer_collection_layer_to_string(s : GeobuffercollectionLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeobuffercollectionBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_buffer_collection_buffer_make(size : Int) -> GeobuffercollectionBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_buffer_collection_buffer_len(s : GeobuffercollectionBuffer) -> Int { s.size }

pub fn geo_buffer_collection_buffer_get(s : GeobuffercollectionBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_buffer_collection_buffer_set(s : GeobuffercollectionBuffer, i : Int, v : Double) -> GeobuffercollectionBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn geo_buffer_collection_buffer_sum(s : GeobuffercollectionBuffer) -> Double { @_common.sum(s.data) }

pub fn geo_buffer_collection_buffer_mean(s : GeobuffercollectionBuffer) -> Double { @_common.mean(s.data) }

pub fn geo_buffer_collection_buffer_scale(s : GeobuffercollectionBuffer, f : Double) -> GeobuffercollectionBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_buffer_collection_buffer_add(a : GeobuffercollectionBuffer, b : GeobuffercollectionBuffer) -> GeobuffercollectionBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_buffer_collection_buffer_copy(s : GeobuffercollectionBuffer) -> GeobuffercollectionBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_buffer_collection_buffer_fill(s : GeobuffercollectionBuffer, v : Double) -> GeobuffercollectionBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_buffer_collection_buffer_min(s : GeobuffercollectionBuffer) -> Double { @_common.min(s.data) }

pub fn geo_buffer_collection_buffer_max(s : GeobuffercollectionBuffer) -> Double { @_common.max(s.data) }

pub fn geo_buffer_collection_buffer_to_string(s : GeobuffercollectionBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeobuffercollectionCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_buffer_collection_cursor_make(size : Int) -> GeobuffercollectionCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_buffer_collection_cursor_len(s : GeobuffercollectionCursor) -> Int { s.size }

pub fn geo_buffer_collection_cursor_get(s : GeobuffercollectionCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_buffer_collection_cursor_set(s : GeobuffercollectionCursor, i : Int, v : Double) -> GeobuffercollectionCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn geo_buffer_collection_cursor_sum(s : GeobuffercollectionCursor) -> Double { @_common.sum(s.data) }

pub fn geo_buffer_collection_cursor_mean(s : GeobuffercollectionCursor) -> Double { @_common.mean(s.data) }

pub fn geo_buffer_collection_cursor_scale(s : GeobuffercollectionCursor, f : Double) -> GeobuffercollectionCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_buffer_collection_cursor_add(a : GeobuffercollectionCursor, b : GeobuffercollectionCursor) -> GeobuffercollectionCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_buffer_collection_cursor_copy(s : GeobuffercollectionCursor) -> GeobuffercollectionCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_buffer_collection_cursor_fill(s : GeobuffercollectionCursor, v : Double) -> GeobuffercollectionCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_buffer_collection_cursor_min(s : GeobuffercollectionCursor) -> Double { @_common.min(s.data) }

pub fn geo_buffer_collection_cursor_max(s : GeobuffercollectionCursor) -> Double { @_common.max(s.data) }

pub fn geo_buffer_collection_cursor_to_string(s : GeobuffercollectionCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeobuffercollectionView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_buffer_collection_view_make(size : Int) -> GeobuffercollectionView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_buffer_collection_view_len(s : GeobuffercollectionView) -> Int { s.size }

pub fn geo_buffer_collection_view_get(s : GeobuffercollectionView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_buffer_collection_view_set(s : GeobuffercollectionView, i : Int, v : Double) -> GeobuffercollectionView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn geo_buffer_collection_view_sum(s : GeobuffercollectionView) -> Double { @_common.sum(s.data) }

pub fn geo_buffer_collection_view_mean(s : GeobuffercollectionView) -> Double { @_common.mean(s.data) }

pub fn geo_buffer_collection_view_scale(s : GeobuffercollectionView, f : Double) -> GeobuffercollectionView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_buffer_collection_view_add(a : GeobuffercollectionView, b : GeobuffercollectionView) -> GeobuffercollectionView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_buffer_collection_view_copy(s : GeobuffercollectionView) -> GeobuffercollectionView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_buffer_collection_view_fill(s : GeobuffercollectionView, v : Double) -> GeobuffercollectionView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_buffer_collection_view_min(s : GeobuffercollectionView) -> Double { @_common.min(s.data) }

pub fn geo_buffer_collection_view_max(s : GeobuffercollectionView) -> Double { @_common.max(s.data) }

pub fn geo_buffer_collection_view_to_string(s : GeobuffercollectionView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeobuffercollectionRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_buffer_collection_range_make(size : Int) -> GeobuffercollectionRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_buffer_collection_range_len(s : GeobuffercollectionRange) -> Int { s.size }

pub fn geo_buffer_collection_range_get(s : GeobuffercollectionRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_buffer_collection_range_set(s : GeobuffercollectionRange, i : Int, v : Double) -> GeobuffercollectionRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn geo_buffer_collection_range_sum(s : GeobuffercollectionRange) -> Double { @_common.sum(s.data) }

pub fn geo_buffer_collection_range_mean(s : GeobuffercollectionRange) -> Double { @_common.mean(s.data) }

pub fn geo_buffer_collection_range_scale(s : GeobuffercollectionRange, f : Double) -> GeobuffercollectionRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_buffer_collection_range_add(a : GeobuffercollectionRange, b : GeobuffercollectionRange) -> GeobuffercollectionRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_buffer_collection_range_copy(s : GeobuffercollectionRange) -> GeobuffercollectionRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_buffer_collection_range_fill(s : GeobuffercollectionRange, v : Double) -> GeobuffercollectionRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_buffer_collection_range_min(s : GeobuffercollectionRange) -> Double { @_common.min(s.data) }

pub fn geo_buffer_collection_range_max(s : GeobuffercollectionRange) -> Double { @_common.max(s.data) }

pub fn geo_buffer_collection_range_to_string(s : GeobuffercollectionRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeobuffercollectionSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_buffer_collection_slice_make(size : Int) -> GeobuffercollectionSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_buffer_collection_slice_len(s : GeobuffercollectionSlice) -> Int { s.size }

pub fn geo_buffer_collection_slice_get(s : GeobuffercollectionSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_buffer_collection_slice_set(s : GeobuffercollectionSlice, i : Int, v : Double) -> GeobuffercollectionSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn geo_buffer_collection_slice_sum(s : GeobuffercollectionSlice) -> Double { @_common.sum(s.data) }

pub fn geo_buffer_collection_slice_mean(s : GeobuffercollectionSlice) -> Double { @_common.mean(s.data) }

pub fn geo_buffer_collection_slice_scale(s : GeobuffercollectionSlice, f : Double) -> GeobuffercollectionSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_buffer_collection_slice_add(a : GeobuffercollectionSlice, b : GeobuffercollectionSlice) -> GeobuffercollectionSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_buffer_collection_slice_copy(s : GeobuffercollectionSlice) -> GeobuffercollectionSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_buffer_collection_slice_fill(s : GeobuffercollectionSlice, v : Double) -> GeobuffercollectionSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_buffer_collection_slice_min(s : GeobuffercollectionSlice) -> Double { @_common.min(s.data) }

pub fn geo_buffer_collection_slice_max(s : GeobuffercollectionSlice) -> Double { @_common.max(s.data) }

pub fn geo_buffer_collection_slice_to_string(s : GeobuffercollectionSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

