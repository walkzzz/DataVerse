///===
/// extcore/geo_dist_rhumb

pub(all) struct GeodistrhumbPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn geo_dist_rhumb_make_point(x : Double, y : Double) -> GeodistrhumbPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn geo_dist_rhumb_make_point3(x : Double, y : Double, z : Double) -> GeodistrhumbPoint {
  { x, y, z, label: 0 }
}

pub fn GeodistrhumbPoint::x(self : GeodistrhumbPoint) -> Double { self.x }

pub fn GeodistrhumbPoint::y(self : GeodistrhumbPoint) -> Double { self.y }

pub fn GeodistrhumbPoint::z(self : GeodistrhumbPoint) -> Double { self.z }

pub fn GeodistrhumbPoint::label(self : GeodistrhumbPoint) -> Int { self.label }

pub fn GeodistrhumbPoint::dist(self : GeodistrhumbPoint, other : GeodistrhumbPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn GeodistrhumbPoint::add(self : GeodistrhumbPoint, other : GeodistrhumbPoint) -> GeodistrhumbPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn GeodistrhumbPoint::sub(self : GeodistrhumbPoint, other : GeodistrhumbPoint) -> GeodistrhumbPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn GeodistrhumbPoint::scale(self : GeodistrhumbPoint, s : Double) -> GeodistrhumbPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn GeodistrhumbPoint::dot(self : GeodistrhumbPoint, other : GeodistrhumbPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn GeodistrhumbPoint::cross(self : GeodistrhumbPoint, other : GeodistrhumbPoint) -> GeodistrhumbPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn GeodistrhumbPoint::norm(self : GeodistrhumbPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn GeodistrhumbPoint::normalize(self : GeodistrhumbPoint) -> GeodistrhumbPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn GeodistrhumbPoint::negate(self : GeodistrhumbPoint) -> GeodistrhumbPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn GeodistrhumbPoint::mid(self : GeodistrhumbPoint, other : GeodistrhumbPoint) -> GeodistrhumbPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn GeodistrhumbPoint::lerp(self : GeodistrhumbPoint, other : GeodistrhumbPoint, t : Double) -> GeodistrhumbPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn GeodistrhumbPoint::to_string(self : GeodistrhumbPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct GeodistrhumbSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn geo_dist_rhumb_make_series(vals : Array[Double], name : String) -> GeodistrhumbSeries {
  { vals, name, meta: 0 }
}

pub fn GeodistrhumbSeries::len(self : GeodistrhumbSeries) -> Int { self.vals.length() }

pub fn GeodistrhumbSeries::sum(self : GeodistrhumbSeries) -> Double { @_common.sum(self.vals) }

pub fn GeodistrhumbSeries::mean(self : GeodistrhumbSeries) -> Double { @_common.mean(self.vals) }

pub fn GeodistrhumbSeries::min(self : GeodistrhumbSeries) -> Double { @_common.min(self.vals) }

pub fn GeodistrhumbSeries::max(self : GeodistrhumbSeries) -> Double { @_common.max(self.vals) }

pub fn GeodistrhumbSeries::range(self : GeodistrhumbSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn GeodistrhumbSeries::variance(self : GeodistrhumbSeries) -> Double { @_common.variance(self.vals) }

pub fn GeodistrhumbSeries::std(self : GeodistrhumbSeries) -> Double { @_common.std(self.vals) }

pub fn GeodistrhumbSeries::median(self : GeodistrhumbSeries) -> Double { @_common.median(self.vals) }

pub fn GeodistrhumbSeries::scale(self : GeodistrhumbSeries, f : Double) -> GeodistrhumbSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn GeodistrhumbSeries::add(self : GeodistrhumbSeries, other : GeodistrhumbSeries) -> GeodistrhumbSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn GeodistrhumbSeries::sub(self : GeodistrhumbSeries, other : GeodistrhumbSeries) -> GeodistrhumbSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn GeodistrhumbSeries::normalize(self : GeodistrhumbSeries) -> GeodistrhumbSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn GeodistrhumbSeries::cumsum(self : GeodistrhumbSeries) -> GeodistrhumbSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn GeodistrhumbSeries::to_string(self : GeodistrhumbSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct GeodistrhumbMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn geo_dist_rhumb_make_matrix(rows : Int, cols : Int, val : Double) -> GeodistrhumbMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn geo_dist_rhumb_matrix_identity(n : Int) -> GeodistrhumbMatrix {
  let m = geo_dist_rhumb_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn GeodistrhumbMatrix::get(self : GeodistrhumbMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn GeodistrhumbMatrix::transpose(self : GeodistrhumbMatrix) -> GeodistrhumbMatrix {
  let result = geo_dist_rhumb_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn GeodistrhumbMatrix::add(self : GeodistrhumbMatrix, other : GeodistrhumbMatrix) -> GeodistrhumbMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = geo_dist_rhumb_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn GeodistrhumbMatrix::scale(self : GeodistrhumbMatrix, s : Double) -> GeodistrhumbMatrix {
  let result = geo_dist_rhumb_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn GeodistrhumbMatrix::multiply(self : GeodistrhumbMatrix, other : GeodistrhumbMatrix) -> GeodistrhumbMatrix {
  if self.cols != other.rows { return geo_dist_rhumb_make_matrix(self.rows, other.cols, 0.0) }
  let result = geo_dist_rhumb_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn GeodistrhumbMatrix::trace(self : GeodistrhumbMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn GeodistrhumbMatrix::det(self : GeodistrhumbMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn GeodistrhumbMatrix::norm(self : GeodistrhumbMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn GeodistrhumbMatrix::to_string(self : GeodistrhumbMatrix) -> String {
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

pub(all) struct GeodistrhumbVector {
  comps : Array[Double]
  dim : Int
}

pub fn geo_dist_rhumb_make_vector(comps : Array[Double]) -> GeodistrhumbVector {
  { comps, dim: comps.length() }
}

pub fn geo_dist_rhumb_vector_zero(dim : Int) -> GeodistrhumbVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn GeodistrhumbVector::add(self : GeodistrhumbVector, other : GeodistrhumbVector) -> GeodistrhumbVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn GeodistrhumbVector::sub(self : GeodistrhumbVector, other : GeodistrhumbVector) -> GeodistrhumbVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn GeodistrhumbVector::scale(self : GeodistrhumbVector, s : Double) -> GeodistrhumbVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn GeodistrhumbVector::dot(self : GeodistrhumbVector, other : GeodistrhumbVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn GeodistrhumbVector::norm(self : GeodistrhumbVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn GeodistrhumbVector::normalize(self : GeodistrhumbVector) -> GeodistrhumbVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn GeodistrhumbVector::dist(self : GeodistrhumbVector, other : GeodistrhumbVector) -> Double {
  self.sub(other).norm()
}

pub fn GeodistrhumbVector::to_string(self : GeodistrhumbVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn geo_dist_rhumb_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn geo_dist_rhumb_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn geo_dist_rhumb_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn geo_dist_rhumb_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn geo_dist_rhumb_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn geo_dist_rhumb_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn geo_dist_rhumb_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn geo_dist_rhumb_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn geo_dist_rhumb_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn geo_dist_rhumb_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn geo_dist_rhumb_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn geo_dist_rhumb_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn geo_dist_rhumb_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn geo_dist_rhumb_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn geo_dist_rhumb_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn geo_dist_rhumb_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn geo_dist_rhumb_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn geo_dist_rhumb_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn geo_dist_rhumb_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn geo_dist_rhumb_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn geo_dist_rhumb_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn geo_dist_rhumb_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn geo_dist_rhumb_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn geo_dist_rhumb_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn geo_dist_rhumb_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn geo_dist_rhumb_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn geo_dist_rhumb_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn geo_dist_rhumb_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn geo_dist_rhumb_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct GeodistrhumbFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_dist_rhumb_frame_make(size : Int) -> GeodistrhumbFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_dist_rhumb_frame_len(s : GeodistrhumbFrame) -> Int { s.size }

pub fn geo_dist_rhumb_frame_get(s : GeodistrhumbFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_dist_rhumb_frame_set(s : GeodistrhumbFrame, i : Int, v : Double) -> GeodistrhumbFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn geo_dist_rhumb_frame_sum(s : GeodistrhumbFrame) -> Double { @_common.sum(s.data) }

pub fn geo_dist_rhumb_frame_mean(s : GeodistrhumbFrame) -> Double { @_common.mean(s.data) }

pub fn geo_dist_rhumb_frame_scale(s : GeodistrhumbFrame, f : Double) -> GeodistrhumbFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_dist_rhumb_frame_add(a : GeodistrhumbFrame, b : GeodistrhumbFrame) -> GeodistrhumbFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_dist_rhumb_frame_copy(s : GeodistrhumbFrame) -> GeodistrhumbFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_dist_rhumb_frame_fill(s : GeodistrhumbFrame, v : Double) -> GeodistrhumbFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_dist_rhumb_frame_min(s : GeodistrhumbFrame) -> Double { @_common.min(s.data) }

pub fn geo_dist_rhumb_frame_max(s : GeodistrhumbFrame) -> Double { @_common.max(s.data) }

pub fn geo_dist_rhumb_frame_to_string(s : GeodistrhumbFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeodistrhumbTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_dist_rhumb_table_make(size : Int) -> GeodistrhumbTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_dist_rhumb_table_len(s : GeodistrhumbTable) -> Int { s.size }

pub fn geo_dist_rhumb_table_get(s : GeodistrhumbTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_dist_rhumb_table_set(s : GeodistrhumbTable, i : Int, v : Double) -> GeodistrhumbTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn geo_dist_rhumb_table_sum(s : GeodistrhumbTable) -> Double { @_common.sum(s.data) }

pub fn geo_dist_rhumb_table_mean(s : GeodistrhumbTable) -> Double { @_common.mean(s.data) }

pub fn geo_dist_rhumb_table_scale(s : GeodistrhumbTable, f : Double) -> GeodistrhumbTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_dist_rhumb_table_add(a : GeodistrhumbTable, b : GeodistrhumbTable) -> GeodistrhumbTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_dist_rhumb_table_copy(s : GeodistrhumbTable) -> GeodistrhumbTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_dist_rhumb_table_fill(s : GeodistrhumbTable, v : Double) -> GeodistrhumbTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_dist_rhumb_table_min(s : GeodistrhumbTable) -> Double { @_common.min(s.data) }

pub fn geo_dist_rhumb_table_max(s : GeodistrhumbTable) -> Double { @_common.max(s.data) }

pub fn geo_dist_rhumb_table_to_string(s : GeodistrhumbTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeodistrhumbGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_dist_rhumb_graphn_make(size : Int) -> GeodistrhumbGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_dist_rhumb_graphn_len(s : GeodistrhumbGraphN) -> Int { s.size }

pub fn geo_dist_rhumb_graphn_get(s : GeodistrhumbGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_dist_rhumb_graphn_set(s : GeodistrhumbGraphN, i : Int, v : Double) -> GeodistrhumbGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn geo_dist_rhumb_graphn_sum(s : GeodistrhumbGraphN) -> Double { @_common.sum(s.data) }

pub fn geo_dist_rhumb_graphn_mean(s : GeodistrhumbGraphN) -> Double { @_common.mean(s.data) }

pub fn geo_dist_rhumb_graphn_scale(s : GeodistrhumbGraphN, f : Double) -> GeodistrhumbGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_dist_rhumb_graphn_add(a : GeodistrhumbGraphN, b : GeodistrhumbGraphN) -> GeodistrhumbGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_dist_rhumb_graphn_copy(s : GeodistrhumbGraphN) -> GeodistrhumbGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_dist_rhumb_graphn_fill(s : GeodistrhumbGraphN, v : Double) -> GeodistrhumbGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_dist_rhumb_graphn_min(s : GeodistrhumbGraphN) -> Double { @_common.min(s.data) }

pub fn geo_dist_rhumb_graphn_max(s : GeodistrhumbGraphN) -> Double { @_common.max(s.data) }

pub fn geo_dist_rhumb_graphn_to_string(s : GeodistrhumbGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeodistrhumbNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_dist_rhumb_node_make(size : Int) -> GeodistrhumbNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_dist_rhumb_node_len(s : GeodistrhumbNode) -> Int { s.size }

pub fn geo_dist_rhumb_node_get(s : GeodistrhumbNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_dist_rhumb_node_set(s : GeodistrhumbNode, i : Int, v : Double) -> GeodistrhumbNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn geo_dist_rhumb_node_sum(s : GeodistrhumbNode) -> Double { @_common.sum(s.data) }

pub fn geo_dist_rhumb_node_mean(s : GeodistrhumbNode) -> Double { @_common.mean(s.data) }

pub fn geo_dist_rhumb_node_scale(s : GeodistrhumbNode, f : Double) -> GeodistrhumbNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_dist_rhumb_node_add(a : GeodistrhumbNode, b : GeodistrhumbNode) -> GeodistrhumbNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_dist_rhumb_node_copy(s : GeodistrhumbNode) -> GeodistrhumbNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_dist_rhumb_node_fill(s : GeodistrhumbNode, v : Double) -> GeodistrhumbNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_dist_rhumb_node_min(s : GeodistrhumbNode) -> Double { @_common.min(s.data) }

pub fn geo_dist_rhumb_node_max(s : GeodistrhumbNode) -> Double { @_common.max(s.data) }

pub fn geo_dist_rhumb_node_to_string(s : GeodistrhumbNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeodistrhumbEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_dist_rhumb_edge_make(size : Int) -> GeodistrhumbEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_dist_rhumb_edge_len(s : GeodistrhumbEdge) -> Int { s.size }

pub fn geo_dist_rhumb_edge_get(s : GeodistrhumbEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_dist_rhumb_edge_set(s : GeodistrhumbEdge, i : Int, v : Double) -> GeodistrhumbEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn geo_dist_rhumb_edge_sum(s : GeodistrhumbEdge) -> Double { @_common.sum(s.data) }

pub fn geo_dist_rhumb_edge_mean(s : GeodistrhumbEdge) -> Double { @_common.mean(s.data) }

pub fn geo_dist_rhumb_edge_scale(s : GeodistrhumbEdge, f : Double) -> GeodistrhumbEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_dist_rhumb_edge_add(a : GeodistrhumbEdge, b : GeodistrhumbEdge) -> GeodistrhumbEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_dist_rhumb_edge_copy(s : GeodistrhumbEdge) -> GeodistrhumbEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_dist_rhumb_edge_fill(s : GeodistrhumbEdge, v : Double) -> GeodistrhumbEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_dist_rhumb_edge_min(s : GeodistrhumbEdge) -> Double { @_common.min(s.data) }

pub fn geo_dist_rhumb_edge_max(s : GeodistrhumbEdge) -> Double { @_common.max(s.data) }

pub fn geo_dist_rhumb_edge_to_string(s : GeodistrhumbEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeodistrhumbPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_dist_rhumb_path_make(size : Int) -> GeodistrhumbPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_dist_rhumb_path_len(s : GeodistrhumbPath) -> Int { s.size }

pub fn geo_dist_rhumb_path_get(s : GeodistrhumbPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_dist_rhumb_path_set(s : GeodistrhumbPath, i : Int, v : Double) -> GeodistrhumbPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn geo_dist_rhumb_path_sum(s : GeodistrhumbPath) -> Double { @_common.sum(s.data) }

pub fn geo_dist_rhumb_path_mean(s : GeodistrhumbPath) -> Double { @_common.mean(s.data) }

pub fn geo_dist_rhumb_path_scale(s : GeodistrhumbPath, f : Double) -> GeodistrhumbPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_dist_rhumb_path_add(a : GeodistrhumbPath, b : GeodistrhumbPath) -> GeodistrhumbPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_dist_rhumb_path_copy(s : GeodistrhumbPath) -> GeodistrhumbPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_dist_rhumb_path_fill(s : GeodistrhumbPath, v : Double) -> GeodistrhumbPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_dist_rhumb_path_min(s : GeodistrhumbPath) -> Double { @_common.min(s.data) }

pub fn geo_dist_rhumb_path_max(s : GeodistrhumbPath) -> Double { @_common.max(s.data) }

pub fn geo_dist_rhumb_path_to_string(s : GeodistrhumbPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeodistrhumbCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_dist_rhumb_cluster_make(size : Int) -> GeodistrhumbCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_dist_rhumb_cluster_len(s : GeodistrhumbCluster) -> Int { s.size }

pub fn geo_dist_rhumb_cluster_get(s : GeodistrhumbCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_dist_rhumb_cluster_set(s : GeodistrhumbCluster, i : Int, v : Double) -> GeodistrhumbCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn geo_dist_rhumb_cluster_sum(s : GeodistrhumbCluster) -> Double { @_common.sum(s.data) }

pub fn geo_dist_rhumb_cluster_mean(s : GeodistrhumbCluster) -> Double { @_common.mean(s.data) }

pub fn geo_dist_rhumb_cluster_scale(s : GeodistrhumbCluster, f : Double) -> GeodistrhumbCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_dist_rhumb_cluster_add(a : GeodistrhumbCluster, b : GeodistrhumbCluster) -> GeodistrhumbCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_dist_rhumb_cluster_copy(s : GeodistrhumbCluster) -> GeodistrhumbCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_dist_rhumb_cluster_fill(s : GeodistrhumbCluster, v : Double) -> GeodistrhumbCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_dist_rhumb_cluster_min(s : GeodistrhumbCluster) -> Double { @_common.min(s.data) }

pub fn geo_dist_rhumb_cluster_max(s : GeodistrhumbCluster) -> Double { @_common.max(s.data) }

pub fn geo_dist_rhumb_cluster_to_string(s : GeodistrhumbCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeodistrhumbModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_dist_rhumb_model_make(size : Int) -> GeodistrhumbModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_dist_rhumb_model_len(s : GeodistrhumbModel) -> Int { s.size }

pub fn geo_dist_rhumb_model_get(s : GeodistrhumbModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_dist_rhumb_model_set(s : GeodistrhumbModel, i : Int, v : Double) -> GeodistrhumbModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn geo_dist_rhumb_model_sum(s : GeodistrhumbModel) -> Double { @_common.sum(s.data) }

pub fn geo_dist_rhumb_model_mean(s : GeodistrhumbModel) -> Double { @_common.mean(s.data) }

pub fn geo_dist_rhumb_model_scale(s : GeodistrhumbModel, f : Double) -> GeodistrhumbModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_dist_rhumb_model_add(a : GeodistrhumbModel, b : GeodistrhumbModel) -> GeodistrhumbModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_dist_rhumb_model_copy(s : GeodistrhumbModel) -> GeodistrhumbModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_dist_rhumb_model_fill(s : GeodistrhumbModel, v : Double) -> GeodistrhumbModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_dist_rhumb_model_min(s : GeodistrhumbModel) -> Double { @_common.min(s.data) }

pub fn geo_dist_rhumb_model_max(s : GeodistrhumbModel) -> Double { @_common.max(s.data) }

pub fn geo_dist_rhumb_model_to_string(s : GeodistrhumbModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeodistrhumbLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_dist_rhumb_layer_make(size : Int) -> GeodistrhumbLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_dist_rhumb_layer_len(s : GeodistrhumbLayer) -> Int { s.size }

pub fn geo_dist_rhumb_layer_get(s : GeodistrhumbLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_dist_rhumb_layer_set(s : GeodistrhumbLayer, i : Int, v : Double) -> GeodistrhumbLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn geo_dist_rhumb_layer_sum(s : GeodistrhumbLayer) -> Double { @_common.sum(s.data) }

pub fn geo_dist_rhumb_layer_mean(s : GeodistrhumbLayer) -> Double { @_common.mean(s.data) }

pub fn geo_dist_rhumb_layer_scale(s : GeodistrhumbLayer, f : Double) -> GeodistrhumbLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_dist_rhumb_layer_add(a : GeodistrhumbLayer, b : GeodistrhumbLayer) -> GeodistrhumbLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_dist_rhumb_layer_copy(s : GeodistrhumbLayer) -> GeodistrhumbLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_dist_rhumb_layer_fill(s : GeodistrhumbLayer, v : Double) -> GeodistrhumbLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_dist_rhumb_layer_min(s : GeodistrhumbLayer) -> Double { @_common.min(s.data) }

pub fn geo_dist_rhumb_layer_max(s : GeodistrhumbLayer) -> Double { @_common.max(s.data) }

pub fn geo_dist_rhumb_layer_to_string(s : GeodistrhumbLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeodistrhumbBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_dist_rhumb_buffer_make(size : Int) -> GeodistrhumbBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_dist_rhumb_buffer_len(s : GeodistrhumbBuffer) -> Int { s.size }

pub fn geo_dist_rhumb_buffer_get(s : GeodistrhumbBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_dist_rhumb_buffer_set(s : GeodistrhumbBuffer, i : Int, v : Double) -> GeodistrhumbBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn geo_dist_rhumb_buffer_sum(s : GeodistrhumbBuffer) -> Double { @_common.sum(s.data) }

pub fn geo_dist_rhumb_buffer_mean(s : GeodistrhumbBuffer) -> Double { @_common.mean(s.data) }

pub fn geo_dist_rhumb_buffer_scale(s : GeodistrhumbBuffer, f : Double) -> GeodistrhumbBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_dist_rhumb_buffer_add(a : GeodistrhumbBuffer, b : GeodistrhumbBuffer) -> GeodistrhumbBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_dist_rhumb_buffer_copy(s : GeodistrhumbBuffer) -> GeodistrhumbBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_dist_rhumb_buffer_fill(s : GeodistrhumbBuffer, v : Double) -> GeodistrhumbBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_dist_rhumb_buffer_min(s : GeodistrhumbBuffer) -> Double { @_common.min(s.data) }

pub fn geo_dist_rhumb_buffer_max(s : GeodistrhumbBuffer) -> Double { @_common.max(s.data) }

pub fn geo_dist_rhumb_buffer_to_string(s : GeodistrhumbBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeodistrhumbCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_dist_rhumb_cursor_make(size : Int) -> GeodistrhumbCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_dist_rhumb_cursor_len(s : GeodistrhumbCursor) -> Int { s.size }

pub fn geo_dist_rhumb_cursor_get(s : GeodistrhumbCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_dist_rhumb_cursor_set(s : GeodistrhumbCursor, i : Int, v : Double) -> GeodistrhumbCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn geo_dist_rhumb_cursor_sum(s : GeodistrhumbCursor) -> Double { @_common.sum(s.data) }

pub fn geo_dist_rhumb_cursor_mean(s : GeodistrhumbCursor) -> Double { @_common.mean(s.data) }

pub fn geo_dist_rhumb_cursor_scale(s : GeodistrhumbCursor, f : Double) -> GeodistrhumbCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_dist_rhumb_cursor_add(a : GeodistrhumbCursor, b : GeodistrhumbCursor) -> GeodistrhumbCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_dist_rhumb_cursor_copy(s : GeodistrhumbCursor) -> GeodistrhumbCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_dist_rhumb_cursor_fill(s : GeodistrhumbCursor, v : Double) -> GeodistrhumbCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_dist_rhumb_cursor_min(s : GeodistrhumbCursor) -> Double { @_common.min(s.data) }

pub fn geo_dist_rhumb_cursor_max(s : GeodistrhumbCursor) -> Double { @_common.max(s.data) }

pub fn geo_dist_rhumb_cursor_to_string(s : GeodistrhumbCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeodistrhumbView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_dist_rhumb_view_make(size : Int) -> GeodistrhumbView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_dist_rhumb_view_len(s : GeodistrhumbView) -> Int { s.size }

pub fn geo_dist_rhumb_view_get(s : GeodistrhumbView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_dist_rhumb_view_set(s : GeodistrhumbView, i : Int, v : Double) -> GeodistrhumbView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn geo_dist_rhumb_view_sum(s : GeodistrhumbView) -> Double { @_common.sum(s.data) }

pub fn geo_dist_rhumb_view_mean(s : GeodistrhumbView) -> Double { @_common.mean(s.data) }

pub fn geo_dist_rhumb_view_scale(s : GeodistrhumbView, f : Double) -> GeodistrhumbView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_dist_rhumb_view_add(a : GeodistrhumbView, b : GeodistrhumbView) -> GeodistrhumbView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_dist_rhumb_view_copy(s : GeodistrhumbView) -> GeodistrhumbView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_dist_rhumb_view_fill(s : GeodistrhumbView, v : Double) -> GeodistrhumbView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_dist_rhumb_view_min(s : GeodistrhumbView) -> Double { @_common.min(s.data) }

pub fn geo_dist_rhumb_view_max(s : GeodistrhumbView) -> Double { @_common.max(s.data) }

pub fn geo_dist_rhumb_view_to_string(s : GeodistrhumbView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeodistrhumbRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_dist_rhumb_range_make(size : Int) -> GeodistrhumbRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_dist_rhumb_range_len(s : GeodistrhumbRange) -> Int { s.size }

pub fn geo_dist_rhumb_range_get(s : GeodistrhumbRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_dist_rhumb_range_set(s : GeodistrhumbRange, i : Int, v : Double) -> GeodistrhumbRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn geo_dist_rhumb_range_sum(s : GeodistrhumbRange) -> Double { @_common.sum(s.data) }

pub fn geo_dist_rhumb_range_mean(s : GeodistrhumbRange) -> Double { @_common.mean(s.data) }

pub fn geo_dist_rhumb_range_scale(s : GeodistrhumbRange, f : Double) -> GeodistrhumbRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_dist_rhumb_range_add(a : GeodistrhumbRange, b : GeodistrhumbRange) -> GeodistrhumbRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_dist_rhumb_range_copy(s : GeodistrhumbRange) -> GeodistrhumbRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_dist_rhumb_range_fill(s : GeodistrhumbRange, v : Double) -> GeodistrhumbRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_dist_rhumb_range_min(s : GeodistrhumbRange) -> Double { @_common.min(s.data) }

pub fn geo_dist_rhumb_range_max(s : GeodistrhumbRange) -> Double { @_common.max(s.data) }

pub fn geo_dist_rhumb_range_to_string(s : GeodistrhumbRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeodistrhumbSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_dist_rhumb_slice_make(size : Int) -> GeodistrhumbSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_dist_rhumb_slice_len(s : GeodistrhumbSlice) -> Int { s.size }

pub fn geo_dist_rhumb_slice_get(s : GeodistrhumbSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_dist_rhumb_slice_set(s : GeodistrhumbSlice, i : Int, v : Double) -> GeodistrhumbSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn geo_dist_rhumb_slice_sum(s : GeodistrhumbSlice) -> Double { @_common.sum(s.data) }

pub fn geo_dist_rhumb_slice_mean(s : GeodistrhumbSlice) -> Double { @_common.mean(s.data) }

pub fn geo_dist_rhumb_slice_scale(s : GeodistrhumbSlice, f : Double) -> GeodistrhumbSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_dist_rhumb_slice_add(a : GeodistrhumbSlice, b : GeodistrhumbSlice) -> GeodistrhumbSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_dist_rhumb_slice_copy(s : GeodistrhumbSlice) -> GeodistrhumbSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_dist_rhumb_slice_fill(s : GeodistrhumbSlice, v : Double) -> GeodistrhumbSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_dist_rhumb_slice_min(s : GeodistrhumbSlice) -> Double { @_common.min(s.data) }

pub fn geo_dist_rhumb_slice_max(s : GeodistrhumbSlice) -> Double { @_common.max(s.data) }

pub fn geo_dist_rhumb_slice_to_string(s : GeodistrhumbSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

