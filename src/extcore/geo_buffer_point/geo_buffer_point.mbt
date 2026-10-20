///===
/// extcore/geo_buffer_point

pub(all) struct GeobufferpointPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn geo_buffer_point_make_point(x : Double, y : Double) -> GeobufferpointPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn geo_buffer_point_make_point3(x : Double, y : Double, z : Double) -> GeobufferpointPoint {
  { x, y, z, label: 0 }
}

pub fn GeobufferpointPoint::x(self : GeobufferpointPoint) -> Double { self.x }

pub fn GeobufferpointPoint::y(self : GeobufferpointPoint) -> Double { self.y }

pub fn GeobufferpointPoint::z(self : GeobufferpointPoint) -> Double { self.z }

pub fn GeobufferpointPoint::label(self : GeobufferpointPoint) -> Int { self.label }

pub fn GeobufferpointPoint::dist(self : GeobufferpointPoint, other : GeobufferpointPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn GeobufferpointPoint::add(self : GeobufferpointPoint, other : GeobufferpointPoint) -> GeobufferpointPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn GeobufferpointPoint::sub(self : GeobufferpointPoint, other : GeobufferpointPoint) -> GeobufferpointPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn GeobufferpointPoint::scale(self : GeobufferpointPoint, s : Double) -> GeobufferpointPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn GeobufferpointPoint::dot(self : GeobufferpointPoint, other : GeobufferpointPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn GeobufferpointPoint::cross(self : GeobufferpointPoint, other : GeobufferpointPoint) -> GeobufferpointPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn GeobufferpointPoint::norm(self : GeobufferpointPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn GeobufferpointPoint::normalize(self : GeobufferpointPoint) -> GeobufferpointPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn GeobufferpointPoint::negate(self : GeobufferpointPoint) -> GeobufferpointPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn GeobufferpointPoint::mid(self : GeobufferpointPoint, other : GeobufferpointPoint) -> GeobufferpointPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn GeobufferpointPoint::lerp(self : GeobufferpointPoint, other : GeobufferpointPoint, t : Double) -> GeobufferpointPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn GeobufferpointPoint::to_string(self : GeobufferpointPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct GeobufferpointSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn geo_buffer_point_make_series(vals : Array[Double], name : String) -> GeobufferpointSeries {
  { vals, name, meta: 0 }
}

pub fn GeobufferpointSeries::len(self : GeobufferpointSeries) -> Int { self.vals.length() }

pub fn GeobufferpointSeries::sum(self : GeobufferpointSeries) -> Double { @_common.sum(self.vals) }

pub fn GeobufferpointSeries::mean(self : GeobufferpointSeries) -> Double { @_common.mean(self.vals) }

pub fn GeobufferpointSeries::min(self : GeobufferpointSeries) -> Double { @_common.min(self.vals) }

pub fn GeobufferpointSeries::max(self : GeobufferpointSeries) -> Double { @_common.max(self.vals) }

pub fn GeobufferpointSeries::range(self : GeobufferpointSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn GeobufferpointSeries::variance(self : GeobufferpointSeries) -> Double { @_common.variance(self.vals) }

pub fn GeobufferpointSeries::std(self : GeobufferpointSeries) -> Double { @_common.std(self.vals) }

pub fn GeobufferpointSeries::median(self : GeobufferpointSeries) -> Double { @_common.median(self.vals) }

pub fn GeobufferpointSeries::scale(self : GeobufferpointSeries, f : Double) -> GeobufferpointSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn GeobufferpointSeries::add(self : GeobufferpointSeries, other : GeobufferpointSeries) -> GeobufferpointSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn GeobufferpointSeries::sub(self : GeobufferpointSeries, other : GeobufferpointSeries) -> GeobufferpointSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn GeobufferpointSeries::normalize(self : GeobufferpointSeries) -> GeobufferpointSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn GeobufferpointSeries::cumsum(self : GeobufferpointSeries) -> GeobufferpointSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn GeobufferpointSeries::to_string(self : GeobufferpointSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct GeobufferpointMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn geo_buffer_point_make_matrix(rows : Int, cols : Int, val : Double) -> GeobufferpointMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn geo_buffer_point_matrix_identity(n : Int) -> GeobufferpointMatrix {
  let m = geo_buffer_point_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn GeobufferpointMatrix::get(self : GeobufferpointMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn GeobufferpointMatrix::transpose(self : GeobufferpointMatrix) -> GeobufferpointMatrix {
  let result = geo_buffer_point_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn GeobufferpointMatrix::add(self : GeobufferpointMatrix, other : GeobufferpointMatrix) -> GeobufferpointMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = geo_buffer_point_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn GeobufferpointMatrix::scale(self : GeobufferpointMatrix, s : Double) -> GeobufferpointMatrix {
  let result = geo_buffer_point_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn GeobufferpointMatrix::multiply(self : GeobufferpointMatrix, other : GeobufferpointMatrix) -> GeobufferpointMatrix {
  if self.cols != other.rows { return geo_buffer_point_make_matrix(self.rows, other.cols, 0.0) }
  let result = geo_buffer_point_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn GeobufferpointMatrix::trace(self : GeobufferpointMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn GeobufferpointMatrix::det(self : GeobufferpointMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn GeobufferpointMatrix::norm(self : GeobufferpointMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn GeobufferpointMatrix::to_string(self : GeobufferpointMatrix) -> String {
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

pub(all) struct GeobufferpointVector {
  comps : Array[Double]
  dim : Int
}

pub fn geo_buffer_point_make_vector(comps : Array[Double]) -> GeobufferpointVector {
  { comps, dim: comps.length() }
}

pub fn geo_buffer_point_vector_zero(dim : Int) -> GeobufferpointVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn GeobufferpointVector::add(self : GeobufferpointVector, other : GeobufferpointVector) -> GeobufferpointVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn GeobufferpointVector::sub(self : GeobufferpointVector, other : GeobufferpointVector) -> GeobufferpointVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn GeobufferpointVector::scale(self : GeobufferpointVector, s : Double) -> GeobufferpointVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn GeobufferpointVector::dot(self : GeobufferpointVector, other : GeobufferpointVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn GeobufferpointVector::norm(self : GeobufferpointVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn GeobufferpointVector::normalize(self : GeobufferpointVector) -> GeobufferpointVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn GeobufferpointVector::dist(self : GeobufferpointVector, other : GeobufferpointVector) -> Double {
  self.sub(other).norm()
}

pub fn GeobufferpointVector::to_string(self : GeobufferpointVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn geo_buffer_point_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn geo_buffer_point_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn geo_buffer_point_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn geo_buffer_point_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn geo_buffer_point_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn geo_buffer_point_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn geo_buffer_point_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn geo_buffer_point_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn geo_buffer_point_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn geo_buffer_point_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn geo_buffer_point_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn geo_buffer_point_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn geo_buffer_point_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn geo_buffer_point_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn geo_buffer_point_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn geo_buffer_point_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn geo_buffer_point_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn geo_buffer_point_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn geo_buffer_point_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn geo_buffer_point_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn geo_buffer_point_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn geo_buffer_point_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn geo_buffer_point_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn geo_buffer_point_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn geo_buffer_point_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn geo_buffer_point_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn geo_buffer_point_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn geo_buffer_point_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn geo_buffer_point_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct GeobufferpointFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_buffer_point_frame_make(size : Int) -> GeobufferpointFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_buffer_point_frame_len(s : GeobufferpointFrame) -> Int { s.size }

pub fn geo_buffer_point_frame_get(s : GeobufferpointFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_buffer_point_frame_set(s : GeobufferpointFrame, i : Int, v : Double) -> GeobufferpointFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn geo_buffer_point_frame_sum(s : GeobufferpointFrame) -> Double { @_common.sum(s.data) }

pub fn geo_buffer_point_frame_mean(s : GeobufferpointFrame) -> Double { @_common.mean(s.data) }

pub fn geo_buffer_point_frame_scale(s : GeobufferpointFrame, f : Double) -> GeobufferpointFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_buffer_point_frame_add(a : GeobufferpointFrame, b : GeobufferpointFrame) -> GeobufferpointFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_buffer_point_frame_copy(s : GeobufferpointFrame) -> GeobufferpointFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_buffer_point_frame_fill(s : GeobufferpointFrame, v : Double) -> GeobufferpointFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_buffer_point_frame_min(s : GeobufferpointFrame) -> Double { @_common.min(s.data) }

pub fn geo_buffer_point_frame_max(s : GeobufferpointFrame) -> Double { @_common.max(s.data) }

pub fn geo_buffer_point_frame_to_string(s : GeobufferpointFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeobufferpointTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_buffer_point_table_make(size : Int) -> GeobufferpointTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_buffer_point_table_len(s : GeobufferpointTable) -> Int { s.size }

pub fn geo_buffer_point_table_get(s : GeobufferpointTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_buffer_point_table_set(s : GeobufferpointTable, i : Int, v : Double) -> GeobufferpointTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn geo_buffer_point_table_sum(s : GeobufferpointTable) -> Double { @_common.sum(s.data) }

pub fn geo_buffer_point_table_mean(s : GeobufferpointTable) -> Double { @_common.mean(s.data) }

pub fn geo_buffer_point_table_scale(s : GeobufferpointTable, f : Double) -> GeobufferpointTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_buffer_point_table_add(a : GeobufferpointTable, b : GeobufferpointTable) -> GeobufferpointTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_buffer_point_table_copy(s : GeobufferpointTable) -> GeobufferpointTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_buffer_point_table_fill(s : GeobufferpointTable, v : Double) -> GeobufferpointTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_buffer_point_table_min(s : GeobufferpointTable) -> Double { @_common.min(s.data) }

pub fn geo_buffer_point_table_max(s : GeobufferpointTable) -> Double { @_common.max(s.data) }

pub fn geo_buffer_point_table_to_string(s : GeobufferpointTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeobufferpointGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_buffer_point_graphn_make(size : Int) -> GeobufferpointGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_buffer_point_graphn_len(s : GeobufferpointGraphN) -> Int { s.size }

pub fn geo_buffer_point_graphn_get(s : GeobufferpointGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_buffer_point_graphn_set(s : GeobufferpointGraphN, i : Int, v : Double) -> GeobufferpointGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn geo_buffer_point_graphn_sum(s : GeobufferpointGraphN) -> Double { @_common.sum(s.data) }

pub fn geo_buffer_point_graphn_mean(s : GeobufferpointGraphN) -> Double { @_common.mean(s.data) }

pub fn geo_buffer_point_graphn_scale(s : GeobufferpointGraphN, f : Double) -> GeobufferpointGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_buffer_point_graphn_add(a : GeobufferpointGraphN, b : GeobufferpointGraphN) -> GeobufferpointGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_buffer_point_graphn_copy(s : GeobufferpointGraphN) -> GeobufferpointGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_buffer_point_graphn_fill(s : GeobufferpointGraphN, v : Double) -> GeobufferpointGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_buffer_point_graphn_min(s : GeobufferpointGraphN) -> Double { @_common.min(s.data) }

pub fn geo_buffer_point_graphn_max(s : GeobufferpointGraphN) -> Double { @_common.max(s.data) }

pub fn geo_buffer_point_graphn_to_string(s : GeobufferpointGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeobufferpointNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_buffer_point_node_make(size : Int) -> GeobufferpointNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_buffer_point_node_len(s : GeobufferpointNode) -> Int { s.size }

pub fn geo_buffer_point_node_get(s : GeobufferpointNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_buffer_point_node_set(s : GeobufferpointNode, i : Int, v : Double) -> GeobufferpointNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn geo_buffer_point_node_sum(s : GeobufferpointNode) -> Double { @_common.sum(s.data) }

pub fn geo_buffer_point_node_mean(s : GeobufferpointNode) -> Double { @_common.mean(s.data) }

pub fn geo_buffer_point_node_scale(s : GeobufferpointNode, f : Double) -> GeobufferpointNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_buffer_point_node_add(a : GeobufferpointNode, b : GeobufferpointNode) -> GeobufferpointNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_buffer_point_node_copy(s : GeobufferpointNode) -> GeobufferpointNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_buffer_point_node_fill(s : GeobufferpointNode, v : Double) -> GeobufferpointNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_buffer_point_node_min(s : GeobufferpointNode) -> Double { @_common.min(s.data) }

pub fn geo_buffer_point_node_max(s : GeobufferpointNode) -> Double { @_common.max(s.data) }

pub fn geo_buffer_point_node_to_string(s : GeobufferpointNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeobufferpointEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_buffer_point_edge_make(size : Int) -> GeobufferpointEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_buffer_point_edge_len(s : GeobufferpointEdge) -> Int { s.size }

pub fn geo_buffer_point_edge_get(s : GeobufferpointEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_buffer_point_edge_set(s : GeobufferpointEdge, i : Int, v : Double) -> GeobufferpointEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn geo_buffer_point_edge_sum(s : GeobufferpointEdge) -> Double { @_common.sum(s.data) }

pub fn geo_buffer_point_edge_mean(s : GeobufferpointEdge) -> Double { @_common.mean(s.data) }

pub fn geo_buffer_point_edge_scale(s : GeobufferpointEdge, f : Double) -> GeobufferpointEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_buffer_point_edge_add(a : GeobufferpointEdge, b : GeobufferpointEdge) -> GeobufferpointEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_buffer_point_edge_copy(s : GeobufferpointEdge) -> GeobufferpointEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_buffer_point_edge_fill(s : GeobufferpointEdge, v : Double) -> GeobufferpointEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_buffer_point_edge_min(s : GeobufferpointEdge) -> Double { @_common.min(s.data) }

pub fn geo_buffer_point_edge_max(s : GeobufferpointEdge) -> Double { @_common.max(s.data) }

pub fn geo_buffer_point_edge_to_string(s : GeobufferpointEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeobufferpointPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_buffer_point_path_make(size : Int) -> GeobufferpointPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_buffer_point_path_len(s : GeobufferpointPath) -> Int { s.size }

pub fn geo_buffer_point_path_get(s : GeobufferpointPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_buffer_point_path_set(s : GeobufferpointPath, i : Int, v : Double) -> GeobufferpointPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn geo_buffer_point_path_sum(s : GeobufferpointPath) -> Double { @_common.sum(s.data) }

pub fn geo_buffer_point_path_mean(s : GeobufferpointPath) -> Double { @_common.mean(s.data) }

pub fn geo_buffer_point_path_scale(s : GeobufferpointPath, f : Double) -> GeobufferpointPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_buffer_point_path_add(a : GeobufferpointPath, b : GeobufferpointPath) -> GeobufferpointPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_buffer_point_path_copy(s : GeobufferpointPath) -> GeobufferpointPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_buffer_point_path_fill(s : GeobufferpointPath, v : Double) -> GeobufferpointPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_buffer_point_path_min(s : GeobufferpointPath) -> Double { @_common.min(s.data) }

pub fn geo_buffer_point_path_max(s : GeobufferpointPath) -> Double { @_common.max(s.data) }

pub fn geo_buffer_point_path_to_string(s : GeobufferpointPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeobufferpointCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_buffer_point_cluster_make(size : Int) -> GeobufferpointCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_buffer_point_cluster_len(s : GeobufferpointCluster) -> Int { s.size }

pub fn geo_buffer_point_cluster_get(s : GeobufferpointCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_buffer_point_cluster_set(s : GeobufferpointCluster, i : Int, v : Double) -> GeobufferpointCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn geo_buffer_point_cluster_sum(s : GeobufferpointCluster) -> Double { @_common.sum(s.data) }

pub fn geo_buffer_point_cluster_mean(s : GeobufferpointCluster) -> Double { @_common.mean(s.data) }

pub fn geo_buffer_point_cluster_scale(s : GeobufferpointCluster, f : Double) -> GeobufferpointCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_buffer_point_cluster_add(a : GeobufferpointCluster, b : GeobufferpointCluster) -> GeobufferpointCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_buffer_point_cluster_copy(s : GeobufferpointCluster) -> GeobufferpointCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_buffer_point_cluster_fill(s : GeobufferpointCluster, v : Double) -> GeobufferpointCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_buffer_point_cluster_min(s : GeobufferpointCluster) -> Double { @_common.min(s.data) }

pub fn geo_buffer_point_cluster_max(s : GeobufferpointCluster) -> Double { @_common.max(s.data) }

pub fn geo_buffer_point_cluster_to_string(s : GeobufferpointCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeobufferpointModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_buffer_point_model_make(size : Int) -> GeobufferpointModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_buffer_point_model_len(s : GeobufferpointModel) -> Int { s.size }

pub fn geo_buffer_point_model_get(s : GeobufferpointModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_buffer_point_model_set(s : GeobufferpointModel, i : Int, v : Double) -> GeobufferpointModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn geo_buffer_point_model_sum(s : GeobufferpointModel) -> Double { @_common.sum(s.data) }

pub fn geo_buffer_point_model_mean(s : GeobufferpointModel) -> Double { @_common.mean(s.data) }

pub fn geo_buffer_point_model_scale(s : GeobufferpointModel, f : Double) -> GeobufferpointModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_buffer_point_model_add(a : GeobufferpointModel, b : GeobufferpointModel) -> GeobufferpointModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_buffer_point_model_copy(s : GeobufferpointModel) -> GeobufferpointModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_buffer_point_model_fill(s : GeobufferpointModel, v : Double) -> GeobufferpointModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_buffer_point_model_min(s : GeobufferpointModel) -> Double { @_common.min(s.data) }

pub fn geo_buffer_point_model_max(s : GeobufferpointModel) -> Double { @_common.max(s.data) }

pub fn geo_buffer_point_model_to_string(s : GeobufferpointModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeobufferpointLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_buffer_point_layer_make(size : Int) -> GeobufferpointLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_buffer_point_layer_len(s : GeobufferpointLayer) -> Int { s.size }

pub fn geo_buffer_point_layer_get(s : GeobufferpointLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_buffer_point_layer_set(s : GeobufferpointLayer, i : Int, v : Double) -> GeobufferpointLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn geo_buffer_point_layer_sum(s : GeobufferpointLayer) -> Double { @_common.sum(s.data) }

pub fn geo_buffer_point_layer_mean(s : GeobufferpointLayer) -> Double { @_common.mean(s.data) }

pub fn geo_buffer_point_layer_scale(s : GeobufferpointLayer, f : Double) -> GeobufferpointLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_buffer_point_layer_add(a : GeobufferpointLayer, b : GeobufferpointLayer) -> GeobufferpointLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_buffer_point_layer_copy(s : GeobufferpointLayer) -> GeobufferpointLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_buffer_point_layer_fill(s : GeobufferpointLayer, v : Double) -> GeobufferpointLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_buffer_point_layer_min(s : GeobufferpointLayer) -> Double { @_common.min(s.data) }

pub fn geo_buffer_point_layer_max(s : GeobufferpointLayer) -> Double { @_common.max(s.data) }

pub fn geo_buffer_point_layer_to_string(s : GeobufferpointLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeobufferpointBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_buffer_point_buffer_make(size : Int) -> GeobufferpointBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_buffer_point_buffer_len(s : GeobufferpointBuffer) -> Int { s.size }

pub fn geo_buffer_point_buffer_get(s : GeobufferpointBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_buffer_point_buffer_set(s : GeobufferpointBuffer, i : Int, v : Double) -> GeobufferpointBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn geo_buffer_point_buffer_sum(s : GeobufferpointBuffer) -> Double { @_common.sum(s.data) }

pub fn geo_buffer_point_buffer_mean(s : GeobufferpointBuffer) -> Double { @_common.mean(s.data) }

pub fn geo_buffer_point_buffer_scale(s : GeobufferpointBuffer, f : Double) -> GeobufferpointBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_buffer_point_buffer_add(a : GeobufferpointBuffer, b : GeobufferpointBuffer) -> GeobufferpointBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_buffer_point_buffer_copy(s : GeobufferpointBuffer) -> GeobufferpointBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_buffer_point_buffer_fill(s : GeobufferpointBuffer, v : Double) -> GeobufferpointBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_buffer_point_buffer_min(s : GeobufferpointBuffer) -> Double { @_common.min(s.data) }

pub fn geo_buffer_point_buffer_max(s : GeobufferpointBuffer) -> Double { @_common.max(s.data) }

pub fn geo_buffer_point_buffer_to_string(s : GeobufferpointBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeobufferpointCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_buffer_point_cursor_make(size : Int) -> GeobufferpointCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_buffer_point_cursor_len(s : GeobufferpointCursor) -> Int { s.size }

pub fn geo_buffer_point_cursor_get(s : GeobufferpointCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_buffer_point_cursor_set(s : GeobufferpointCursor, i : Int, v : Double) -> GeobufferpointCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn geo_buffer_point_cursor_sum(s : GeobufferpointCursor) -> Double { @_common.sum(s.data) }

pub fn geo_buffer_point_cursor_mean(s : GeobufferpointCursor) -> Double { @_common.mean(s.data) }

pub fn geo_buffer_point_cursor_scale(s : GeobufferpointCursor, f : Double) -> GeobufferpointCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_buffer_point_cursor_add(a : GeobufferpointCursor, b : GeobufferpointCursor) -> GeobufferpointCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_buffer_point_cursor_copy(s : GeobufferpointCursor) -> GeobufferpointCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_buffer_point_cursor_fill(s : GeobufferpointCursor, v : Double) -> GeobufferpointCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_buffer_point_cursor_min(s : GeobufferpointCursor) -> Double { @_common.min(s.data) }

pub fn geo_buffer_point_cursor_max(s : GeobufferpointCursor) -> Double { @_common.max(s.data) }

pub fn geo_buffer_point_cursor_to_string(s : GeobufferpointCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeobufferpointView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_buffer_point_view_make(size : Int) -> GeobufferpointView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_buffer_point_view_len(s : GeobufferpointView) -> Int { s.size }

pub fn geo_buffer_point_view_get(s : GeobufferpointView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_buffer_point_view_set(s : GeobufferpointView, i : Int, v : Double) -> GeobufferpointView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn geo_buffer_point_view_sum(s : GeobufferpointView) -> Double { @_common.sum(s.data) }

pub fn geo_buffer_point_view_mean(s : GeobufferpointView) -> Double { @_common.mean(s.data) }

pub fn geo_buffer_point_view_scale(s : GeobufferpointView, f : Double) -> GeobufferpointView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_buffer_point_view_add(a : GeobufferpointView, b : GeobufferpointView) -> GeobufferpointView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_buffer_point_view_copy(s : GeobufferpointView) -> GeobufferpointView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_buffer_point_view_fill(s : GeobufferpointView, v : Double) -> GeobufferpointView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_buffer_point_view_min(s : GeobufferpointView) -> Double { @_common.min(s.data) }

pub fn geo_buffer_point_view_max(s : GeobufferpointView) -> Double { @_common.max(s.data) }

pub fn geo_buffer_point_view_to_string(s : GeobufferpointView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeobufferpointRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_buffer_point_range_make(size : Int) -> GeobufferpointRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_buffer_point_range_len(s : GeobufferpointRange) -> Int { s.size }

pub fn geo_buffer_point_range_get(s : GeobufferpointRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_buffer_point_range_set(s : GeobufferpointRange, i : Int, v : Double) -> GeobufferpointRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn geo_buffer_point_range_sum(s : GeobufferpointRange) -> Double { @_common.sum(s.data) }

pub fn geo_buffer_point_range_mean(s : GeobufferpointRange) -> Double { @_common.mean(s.data) }

pub fn geo_buffer_point_range_scale(s : GeobufferpointRange, f : Double) -> GeobufferpointRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_buffer_point_range_add(a : GeobufferpointRange, b : GeobufferpointRange) -> GeobufferpointRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_buffer_point_range_copy(s : GeobufferpointRange) -> GeobufferpointRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_buffer_point_range_fill(s : GeobufferpointRange, v : Double) -> GeobufferpointRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_buffer_point_range_min(s : GeobufferpointRange) -> Double { @_common.min(s.data) }

pub fn geo_buffer_point_range_max(s : GeobufferpointRange) -> Double { @_common.max(s.data) }

pub fn geo_buffer_point_range_to_string(s : GeobufferpointRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeobufferpointSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_buffer_point_slice_make(size : Int) -> GeobufferpointSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_buffer_point_slice_len(s : GeobufferpointSlice) -> Int { s.size }

pub fn geo_buffer_point_slice_get(s : GeobufferpointSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_buffer_point_slice_set(s : GeobufferpointSlice, i : Int, v : Double) -> GeobufferpointSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn geo_buffer_point_slice_sum(s : GeobufferpointSlice) -> Double { @_common.sum(s.data) }

pub fn geo_buffer_point_slice_mean(s : GeobufferpointSlice) -> Double { @_common.mean(s.data) }

pub fn geo_buffer_point_slice_scale(s : GeobufferpointSlice, f : Double) -> GeobufferpointSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_buffer_point_slice_add(a : GeobufferpointSlice, b : GeobufferpointSlice) -> GeobufferpointSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_buffer_point_slice_copy(s : GeobufferpointSlice) -> GeobufferpointSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_buffer_point_slice_fill(s : GeobufferpointSlice, v : Double) -> GeobufferpointSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_buffer_point_slice_min(s : GeobufferpointSlice) -> Double { @_common.min(s.data) }

pub fn geo_buffer_point_slice_max(s : GeobufferpointSlice) -> Double { @_common.max(s.data) }

pub fn geo_buffer_point_slice_to_string(s : GeobufferpointSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

