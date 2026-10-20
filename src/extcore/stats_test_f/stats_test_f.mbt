///===
/// extcore/stats_test_f

pub(all) struct StatstestfPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn stats_test_f_make_point(x : Double, y : Double) -> StatstestfPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn stats_test_f_make_point3(x : Double, y : Double, z : Double) -> StatstestfPoint {
  { x, y, z, label: 0 }
}

pub fn StatstestfPoint::x(self : StatstestfPoint) -> Double { self.x }

pub fn StatstestfPoint::y(self : StatstestfPoint) -> Double { self.y }

pub fn StatstestfPoint::z(self : StatstestfPoint) -> Double { self.z }

pub fn StatstestfPoint::label(self : StatstestfPoint) -> Int { self.label }

pub fn StatstestfPoint::dist(self : StatstestfPoint, other : StatstestfPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn StatstestfPoint::add(self : StatstestfPoint, other : StatstestfPoint) -> StatstestfPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn StatstestfPoint::sub(self : StatstestfPoint, other : StatstestfPoint) -> StatstestfPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn StatstestfPoint::scale(self : StatstestfPoint, s : Double) -> StatstestfPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn StatstestfPoint::dot(self : StatstestfPoint, other : StatstestfPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn StatstestfPoint::cross(self : StatstestfPoint, other : StatstestfPoint) -> StatstestfPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn StatstestfPoint::norm(self : StatstestfPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn StatstestfPoint::normalize(self : StatstestfPoint) -> StatstestfPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn StatstestfPoint::negate(self : StatstestfPoint) -> StatstestfPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn StatstestfPoint::mid(self : StatstestfPoint, other : StatstestfPoint) -> StatstestfPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn StatstestfPoint::lerp(self : StatstestfPoint, other : StatstestfPoint, t : Double) -> StatstestfPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn StatstestfPoint::to_string(self : StatstestfPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct StatstestfSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn stats_test_f_make_series(vals : Array[Double], name : String) -> StatstestfSeries {
  { vals, name, meta: 0 }
}

pub fn StatstestfSeries::len(self : StatstestfSeries) -> Int { self.vals.length() }

pub fn StatstestfSeries::sum(self : StatstestfSeries) -> Double { @_common.sum(self.vals) }

pub fn StatstestfSeries::mean(self : StatstestfSeries) -> Double { @_common.mean(self.vals) }

pub fn StatstestfSeries::min(self : StatstestfSeries) -> Double { @_common.min(self.vals) }

pub fn StatstestfSeries::max(self : StatstestfSeries) -> Double { @_common.max(self.vals) }

pub fn StatstestfSeries::range(self : StatstestfSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn StatstestfSeries::variance(self : StatstestfSeries) -> Double { @_common.variance(self.vals) }

pub fn StatstestfSeries::std(self : StatstestfSeries) -> Double { @_common.std(self.vals) }

pub fn StatstestfSeries::median(self : StatstestfSeries) -> Double { @_common.median(self.vals) }

pub fn StatstestfSeries::scale(self : StatstestfSeries, f : Double) -> StatstestfSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn StatstestfSeries::add(self : StatstestfSeries, other : StatstestfSeries) -> StatstestfSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn StatstestfSeries::sub(self : StatstestfSeries, other : StatstestfSeries) -> StatstestfSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn StatstestfSeries::normalize(self : StatstestfSeries) -> StatstestfSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn StatstestfSeries::cumsum(self : StatstestfSeries) -> StatstestfSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn StatstestfSeries::to_string(self : StatstestfSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct StatstestfMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn stats_test_f_make_matrix(rows : Int, cols : Int, val : Double) -> StatstestfMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn stats_test_f_matrix_identity(n : Int) -> StatstestfMatrix {
  let m = stats_test_f_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn StatstestfMatrix::get(self : StatstestfMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn StatstestfMatrix::transpose(self : StatstestfMatrix) -> StatstestfMatrix {
  let result = stats_test_f_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn StatstestfMatrix::add(self : StatstestfMatrix, other : StatstestfMatrix) -> StatstestfMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = stats_test_f_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn StatstestfMatrix::scale(self : StatstestfMatrix, s : Double) -> StatstestfMatrix {
  let result = stats_test_f_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn StatstestfMatrix::multiply(self : StatstestfMatrix, other : StatstestfMatrix) -> StatstestfMatrix {
  if self.cols != other.rows { return stats_test_f_make_matrix(self.rows, other.cols, 0.0) }
  let result = stats_test_f_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn StatstestfMatrix::trace(self : StatstestfMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn StatstestfMatrix::det(self : StatstestfMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn StatstestfMatrix::norm(self : StatstestfMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn StatstestfMatrix::to_string(self : StatstestfMatrix) -> String {
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

pub(all) struct StatstestfVector {
  comps : Array[Double]
  dim : Int
}

pub fn stats_test_f_make_vector(comps : Array[Double]) -> StatstestfVector {
  { comps, dim: comps.length() }
}

pub fn stats_test_f_vector_zero(dim : Int) -> StatstestfVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn StatstestfVector::add(self : StatstestfVector, other : StatstestfVector) -> StatstestfVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn StatstestfVector::sub(self : StatstestfVector, other : StatstestfVector) -> StatstestfVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn StatstestfVector::scale(self : StatstestfVector, s : Double) -> StatstestfVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn StatstestfVector::dot(self : StatstestfVector, other : StatstestfVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn StatstestfVector::norm(self : StatstestfVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn StatstestfVector::normalize(self : StatstestfVector) -> StatstestfVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn StatstestfVector::dist(self : StatstestfVector, other : StatstestfVector) -> Double {
  self.sub(other).norm()
}

pub fn StatstestfVector::to_string(self : StatstestfVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn stats_test_f_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn stats_test_f_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn stats_test_f_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn stats_test_f_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn stats_test_f_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn stats_test_f_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn stats_test_f_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn stats_test_f_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn stats_test_f_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn stats_test_f_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn stats_test_f_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn stats_test_f_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn stats_test_f_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn stats_test_f_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn stats_test_f_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn stats_test_f_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn stats_test_f_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn stats_test_f_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn stats_test_f_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn stats_test_f_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn stats_test_f_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn stats_test_f_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn stats_test_f_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn stats_test_f_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn stats_test_f_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn stats_test_f_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn stats_test_f_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn stats_test_f_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn stats_test_f_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct StatstestfFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_test_f_frame_make(size : Int) -> StatstestfFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_test_f_frame_len(s : StatstestfFrame) -> Int { s.size }

pub fn stats_test_f_frame_get(s : StatstestfFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_test_f_frame_set(s : StatstestfFrame, i : Int, v : Double) -> StatstestfFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_test_f_frame_sum(s : StatstestfFrame) -> Double { @_common.sum(s.data) }

pub fn stats_test_f_frame_mean(s : StatstestfFrame) -> Double { @_common.mean(s.data) }

pub fn stats_test_f_frame_scale(s : StatstestfFrame, f : Double) -> StatstestfFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_test_f_frame_add(a : StatstestfFrame, b : StatstestfFrame) -> StatstestfFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_test_f_frame_copy(s : StatstestfFrame) -> StatstestfFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_test_f_frame_fill(s : StatstestfFrame, v : Double) -> StatstestfFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_test_f_frame_min(s : StatstestfFrame) -> Double { @_common.min(s.data) }

pub fn stats_test_f_frame_max(s : StatstestfFrame) -> Double { @_common.max(s.data) }

pub fn stats_test_f_frame_to_string(s : StatstestfFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatstestfTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_test_f_table_make(size : Int) -> StatstestfTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_test_f_table_len(s : StatstestfTable) -> Int { s.size }

pub fn stats_test_f_table_get(s : StatstestfTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_test_f_table_set(s : StatstestfTable, i : Int, v : Double) -> StatstestfTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_test_f_table_sum(s : StatstestfTable) -> Double { @_common.sum(s.data) }

pub fn stats_test_f_table_mean(s : StatstestfTable) -> Double { @_common.mean(s.data) }

pub fn stats_test_f_table_scale(s : StatstestfTable, f : Double) -> StatstestfTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_test_f_table_add(a : StatstestfTable, b : StatstestfTable) -> StatstestfTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_test_f_table_copy(s : StatstestfTable) -> StatstestfTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_test_f_table_fill(s : StatstestfTable, v : Double) -> StatstestfTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_test_f_table_min(s : StatstestfTable) -> Double { @_common.min(s.data) }

pub fn stats_test_f_table_max(s : StatstestfTable) -> Double { @_common.max(s.data) }

pub fn stats_test_f_table_to_string(s : StatstestfTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatstestfGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_test_f_graphn_make(size : Int) -> StatstestfGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_test_f_graphn_len(s : StatstestfGraphN) -> Int { s.size }

pub fn stats_test_f_graphn_get(s : StatstestfGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_test_f_graphn_set(s : StatstestfGraphN, i : Int, v : Double) -> StatstestfGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_test_f_graphn_sum(s : StatstestfGraphN) -> Double { @_common.sum(s.data) }

pub fn stats_test_f_graphn_mean(s : StatstestfGraphN) -> Double { @_common.mean(s.data) }

pub fn stats_test_f_graphn_scale(s : StatstestfGraphN, f : Double) -> StatstestfGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_test_f_graphn_add(a : StatstestfGraphN, b : StatstestfGraphN) -> StatstestfGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_test_f_graphn_copy(s : StatstestfGraphN) -> StatstestfGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_test_f_graphn_fill(s : StatstestfGraphN, v : Double) -> StatstestfGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_test_f_graphn_min(s : StatstestfGraphN) -> Double { @_common.min(s.data) }

pub fn stats_test_f_graphn_max(s : StatstestfGraphN) -> Double { @_common.max(s.data) }

pub fn stats_test_f_graphn_to_string(s : StatstestfGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatstestfNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_test_f_node_make(size : Int) -> StatstestfNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_test_f_node_len(s : StatstestfNode) -> Int { s.size }

pub fn stats_test_f_node_get(s : StatstestfNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_test_f_node_set(s : StatstestfNode, i : Int, v : Double) -> StatstestfNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_test_f_node_sum(s : StatstestfNode) -> Double { @_common.sum(s.data) }

pub fn stats_test_f_node_mean(s : StatstestfNode) -> Double { @_common.mean(s.data) }

pub fn stats_test_f_node_scale(s : StatstestfNode, f : Double) -> StatstestfNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_test_f_node_add(a : StatstestfNode, b : StatstestfNode) -> StatstestfNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_test_f_node_copy(s : StatstestfNode) -> StatstestfNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_test_f_node_fill(s : StatstestfNode, v : Double) -> StatstestfNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_test_f_node_min(s : StatstestfNode) -> Double { @_common.min(s.data) }

pub fn stats_test_f_node_max(s : StatstestfNode) -> Double { @_common.max(s.data) }

pub fn stats_test_f_node_to_string(s : StatstestfNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatstestfEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_test_f_edge_make(size : Int) -> StatstestfEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_test_f_edge_len(s : StatstestfEdge) -> Int { s.size }

pub fn stats_test_f_edge_get(s : StatstestfEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_test_f_edge_set(s : StatstestfEdge, i : Int, v : Double) -> StatstestfEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_test_f_edge_sum(s : StatstestfEdge) -> Double { @_common.sum(s.data) }

pub fn stats_test_f_edge_mean(s : StatstestfEdge) -> Double { @_common.mean(s.data) }

pub fn stats_test_f_edge_scale(s : StatstestfEdge, f : Double) -> StatstestfEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_test_f_edge_add(a : StatstestfEdge, b : StatstestfEdge) -> StatstestfEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_test_f_edge_copy(s : StatstestfEdge) -> StatstestfEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_test_f_edge_fill(s : StatstestfEdge, v : Double) -> StatstestfEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_test_f_edge_min(s : StatstestfEdge) -> Double { @_common.min(s.data) }

pub fn stats_test_f_edge_max(s : StatstestfEdge) -> Double { @_common.max(s.data) }

pub fn stats_test_f_edge_to_string(s : StatstestfEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatstestfPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_test_f_path_make(size : Int) -> StatstestfPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_test_f_path_len(s : StatstestfPath) -> Int { s.size }

pub fn stats_test_f_path_get(s : StatstestfPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_test_f_path_set(s : StatstestfPath, i : Int, v : Double) -> StatstestfPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_test_f_path_sum(s : StatstestfPath) -> Double { @_common.sum(s.data) }

pub fn stats_test_f_path_mean(s : StatstestfPath) -> Double { @_common.mean(s.data) }

pub fn stats_test_f_path_scale(s : StatstestfPath, f : Double) -> StatstestfPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_test_f_path_add(a : StatstestfPath, b : StatstestfPath) -> StatstestfPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_test_f_path_copy(s : StatstestfPath) -> StatstestfPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_test_f_path_fill(s : StatstestfPath, v : Double) -> StatstestfPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_test_f_path_min(s : StatstestfPath) -> Double { @_common.min(s.data) }

pub fn stats_test_f_path_max(s : StatstestfPath) -> Double { @_common.max(s.data) }

pub fn stats_test_f_path_to_string(s : StatstestfPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatstestfCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_test_f_cluster_make(size : Int) -> StatstestfCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_test_f_cluster_len(s : StatstestfCluster) -> Int { s.size }

pub fn stats_test_f_cluster_get(s : StatstestfCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_test_f_cluster_set(s : StatstestfCluster, i : Int, v : Double) -> StatstestfCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_test_f_cluster_sum(s : StatstestfCluster) -> Double { @_common.sum(s.data) }

pub fn stats_test_f_cluster_mean(s : StatstestfCluster) -> Double { @_common.mean(s.data) }

pub fn stats_test_f_cluster_scale(s : StatstestfCluster, f : Double) -> StatstestfCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_test_f_cluster_add(a : StatstestfCluster, b : StatstestfCluster) -> StatstestfCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_test_f_cluster_copy(s : StatstestfCluster) -> StatstestfCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_test_f_cluster_fill(s : StatstestfCluster, v : Double) -> StatstestfCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_test_f_cluster_min(s : StatstestfCluster) -> Double { @_common.min(s.data) }

pub fn stats_test_f_cluster_max(s : StatstestfCluster) -> Double { @_common.max(s.data) }

pub fn stats_test_f_cluster_to_string(s : StatstestfCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatstestfModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_test_f_model_make(size : Int) -> StatstestfModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_test_f_model_len(s : StatstestfModel) -> Int { s.size }

pub fn stats_test_f_model_get(s : StatstestfModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_test_f_model_set(s : StatstestfModel, i : Int, v : Double) -> StatstestfModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_test_f_model_sum(s : StatstestfModel) -> Double { @_common.sum(s.data) }

pub fn stats_test_f_model_mean(s : StatstestfModel) -> Double { @_common.mean(s.data) }

pub fn stats_test_f_model_scale(s : StatstestfModel, f : Double) -> StatstestfModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_test_f_model_add(a : StatstestfModel, b : StatstestfModel) -> StatstestfModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_test_f_model_copy(s : StatstestfModel) -> StatstestfModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_test_f_model_fill(s : StatstestfModel, v : Double) -> StatstestfModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_test_f_model_min(s : StatstestfModel) -> Double { @_common.min(s.data) }

pub fn stats_test_f_model_max(s : StatstestfModel) -> Double { @_common.max(s.data) }

pub fn stats_test_f_model_to_string(s : StatstestfModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatstestfLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_test_f_layer_make(size : Int) -> StatstestfLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_test_f_layer_len(s : StatstestfLayer) -> Int { s.size }

pub fn stats_test_f_layer_get(s : StatstestfLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_test_f_layer_set(s : StatstestfLayer, i : Int, v : Double) -> StatstestfLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_test_f_layer_sum(s : StatstestfLayer) -> Double { @_common.sum(s.data) }

pub fn stats_test_f_layer_mean(s : StatstestfLayer) -> Double { @_common.mean(s.data) }

pub fn stats_test_f_layer_scale(s : StatstestfLayer, f : Double) -> StatstestfLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_test_f_layer_add(a : StatstestfLayer, b : StatstestfLayer) -> StatstestfLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_test_f_layer_copy(s : StatstestfLayer) -> StatstestfLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_test_f_layer_fill(s : StatstestfLayer, v : Double) -> StatstestfLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_test_f_layer_min(s : StatstestfLayer) -> Double { @_common.min(s.data) }

pub fn stats_test_f_layer_max(s : StatstestfLayer) -> Double { @_common.max(s.data) }

pub fn stats_test_f_layer_to_string(s : StatstestfLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatstestfBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_test_f_buffer_make(size : Int) -> StatstestfBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_test_f_buffer_len(s : StatstestfBuffer) -> Int { s.size }

pub fn stats_test_f_buffer_get(s : StatstestfBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_test_f_buffer_set(s : StatstestfBuffer, i : Int, v : Double) -> StatstestfBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_test_f_buffer_sum(s : StatstestfBuffer) -> Double { @_common.sum(s.data) }

pub fn stats_test_f_buffer_mean(s : StatstestfBuffer) -> Double { @_common.mean(s.data) }

pub fn stats_test_f_buffer_scale(s : StatstestfBuffer, f : Double) -> StatstestfBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_test_f_buffer_add(a : StatstestfBuffer, b : StatstestfBuffer) -> StatstestfBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_test_f_buffer_copy(s : StatstestfBuffer) -> StatstestfBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_test_f_buffer_fill(s : StatstestfBuffer, v : Double) -> StatstestfBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_test_f_buffer_min(s : StatstestfBuffer) -> Double { @_common.min(s.data) }

pub fn stats_test_f_buffer_max(s : StatstestfBuffer) -> Double { @_common.max(s.data) }

pub fn stats_test_f_buffer_to_string(s : StatstestfBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatstestfCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_test_f_cursor_make(size : Int) -> StatstestfCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_test_f_cursor_len(s : StatstestfCursor) -> Int { s.size }

pub fn stats_test_f_cursor_get(s : StatstestfCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_test_f_cursor_set(s : StatstestfCursor, i : Int, v : Double) -> StatstestfCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_test_f_cursor_sum(s : StatstestfCursor) -> Double { @_common.sum(s.data) }

pub fn stats_test_f_cursor_mean(s : StatstestfCursor) -> Double { @_common.mean(s.data) }

pub fn stats_test_f_cursor_scale(s : StatstestfCursor, f : Double) -> StatstestfCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_test_f_cursor_add(a : StatstestfCursor, b : StatstestfCursor) -> StatstestfCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_test_f_cursor_copy(s : StatstestfCursor) -> StatstestfCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_test_f_cursor_fill(s : StatstestfCursor, v : Double) -> StatstestfCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_test_f_cursor_min(s : StatstestfCursor) -> Double { @_common.min(s.data) }

pub fn stats_test_f_cursor_max(s : StatstestfCursor) -> Double { @_common.max(s.data) }

pub fn stats_test_f_cursor_to_string(s : StatstestfCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatstestfView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_test_f_view_make(size : Int) -> StatstestfView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_test_f_view_len(s : StatstestfView) -> Int { s.size }

pub fn stats_test_f_view_get(s : StatstestfView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_test_f_view_set(s : StatstestfView, i : Int, v : Double) -> StatstestfView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_test_f_view_sum(s : StatstestfView) -> Double { @_common.sum(s.data) }

pub fn stats_test_f_view_mean(s : StatstestfView) -> Double { @_common.mean(s.data) }

pub fn stats_test_f_view_scale(s : StatstestfView, f : Double) -> StatstestfView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_test_f_view_add(a : StatstestfView, b : StatstestfView) -> StatstestfView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_test_f_view_copy(s : StatstestfView) -> StatstestfView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_test_f_view_fill(s : StatstestfView, v : Double) -> StatstestfView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_test_f_view_min(s : StatstestfView) -> Double { @_common.min(s.data) }

pub fn stats_test_f_view_max(s : StatstestfView) -> Double { @_common.max(s.data) }

pub fn stats_test_f_view_to_string(s : StatstestfView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatstestfRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_test_f_range_make(size : Int) -> StatstestfRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_test_f_range_len(s : StatstestfRange) -> Int { s.size }

pub fn stats_test_f_range_get(s : StatstestfRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_test_f_range_set(s : StatstestfRange, i : Int, v : Double) -> StatstestfRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_test_f_range_sum(s : StatstestfRange) -> Double { @_common.sum(s.data) }

pub fn stats_test_f_range_mean(s : StatstestfRange) -> Double { @_common.mean(s.data) }

pub fn stats_test_f_range_scale(s : StatstestfRange, f : Double) -> StatstestfRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_test_f_range_add(a : StatstestfRange, b : StatstestfRange) -> StatstestfRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_test_f_range_copy(s : StatstestfRange) -> StatstestfRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_test_f_range_fill(s : StatstestfRange, v : Double) -> StatstestfRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_test_f_range_min(s : StatstestfRange) -> Double { @_common.min(s.data) }

pub fn stats_test_f_range_max(s : StatstestfRange) -> Double { @_common.max(s.data) }

pub fn stats_test_f_range_to_string(s : StatstestfRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatstestfSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_test_f_slice_make(size : Int) -> StatstestfSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_test_f_slice_len(s : StatstestfSlice) -> Int { s.size }

pub fn stats_test_f_slice_get(s : StatstestfSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_test_f_slice_set(s : StatstestfSlice, i : Int, v : Double) -> StatstestfSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_test_f_slice_sum(s : StatstestfSlice) -> Double { @_common.sum(s.data) }

pub fn stats_test_f_slice_mean(s : StatstestfSlice) -> Double { @_common.mean(s.data) }

pub fn stats_test_f_slice_scale(s : StatstestfSlice, f : Double) -> StatstestfSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_test_f_slice_add(a : StatstestfSlice, b : StatstestfSlice) -> StatstestfSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_test_f_slice_copy(s : StatstestfSlice) -> StatstestfSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_test_f_slice_fill(s : StatstestfSlice, v : Double) -> StatstestfSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_test_f_slice_min(s : StatstestfSlice) -> Double { @_common.min(s.data) }

pub fn stats_test_f_slice_max(s : StatstestfSlice) -> Double { @_common.max(s.data) }

pub fn stats_test_f_slice_to_string(s : StatstestfSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

