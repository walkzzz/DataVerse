///===
/// extcore/stats_dist_f

pub(all) struct StatsdistfPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn stats_dist_f_make_point(x : Double, y : Double) -> StatsdistfPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn stats_dist_f_make_point3(x : Double, y : Double, z : Double) -> StatsdistfPoint {
  { x, y, z, label: 0 }
}

pub fn StatsdistfPoint::x(self : StatsdistfPoint) -> Double { self.x }

pub fn StatsdistfPoint::y(self : StatsdistfPoint) -> Double { self.y }

pub fn StatsdistfPoint::z(self : StatsdistfPoint) -> Double { self.z }

pub fn StatsdistfPoint::label(self : StatsdistfPoint) -> Int { self.label }

pub fn StatsdistfPoint::dist(self : StatsdistfPoint, other : StatsdistfPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn StatsdistfPoint::add(self : StatsdistfPoint, other : StatsdistfPoint) -> StatsdistfPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn StatsdistfPoint::sub(self : StatsdistfPoint, other : StatsdistfPoint) -> StatsdistfPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn StatsdistfPoint::scale(self : StatsdistfPoint, s : Double) -> StatsdistfPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn StatsdistfPoint::dot(self : StatsdistfPoint, other : StatsdistfPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn StatsdistfPoint::cross(self : StatsdistfPoint, other : StatsdistfPoint) -> StatsdistfPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn StatsdistfPoint::norm(self : StatsdistfPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn StatsdistfPoint::normalize(self : StatsdistfPoint) -> StatsdistfPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn StatsdistfPoint::negate(self : StatsdistfPoint) -> StatsdistfPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn StatsdistfPoint::mid(self : StatsdistfPoint, other : StatsdistfPoint) -> StatsdistfPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn StatsdistfPoint::lerp(self : StatsdistfPoint, other : StatsdistfPoint, t : Double) -> StatsdistfPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn StatsdistfPoint::to_string(self : StatsdistfPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct StatsdistfSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn stats_dist_f_make_series(vals : Array[Double], name : String) -> StatsdistfSeries {
  { vals, name, meta: 0 }
}

pub fn StatsdistfSeries::len(self : StatsdistfSeries) -> Int { self.vals.length() }

pub fn StatsdistfSeries::sum(self : StatsdistfSeries) -> Double { @_common.sum(self.vals) }

pub fn StatsdistfSeries::mean(self : StatsdistfSeries) -> Double { @_common.mean(self.vals) }

pub fn StatsdistfSeries::min(self : StatsdistfSeries) -> Double { @_common.min(self.vals) }

pub fn StatsdistfSeries::max(self : StatsdistfSeries) -> Double { @_common.max(self.vals) }

pub fn StatsdistfSeries::range(self : StatsdistfSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn StatsdistfSeries::variance(self : StatsdistfSeries) -> Double { @_common.variance(self.vals) }

pub fn StatsdistfSeries::std(self : StatsdistfSeries) -> Double { @_common.std(self.vals) }

pub fn StatsdistfSeries::median(self : StatsdistfSeries) -> Double { @_common.median(self.vals) }

pub fn StatsdistfSeries::scale(self : StatsdistfSeries, f : Double) -> StatsdistfSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn StatsdistfSeries::add(self : StatsdistfSeries, other : StatsdistfSeries) -> StatsdistfSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn StatsdistfSeries::sub(self : StatsdistfSeries, other : StatsdistfSeries) -> StatsdistfSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn StatsdistfSeries::normalize(self : StatsdistfSeries) -> StatsdistfSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn StatsdistfSeries::cumsum(self : StatsdistfSeries) -> StatsdistfSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn StatsdistfSeries::to_string(self : StatsdistfSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct StatsdistfMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn stats_dist_f_make_matrix(rows : Int, cols : Int, val : Double) -> StatsdistfMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn stats_dist_f_matrix_identity(n : Int) -> StatsdistfMatrix {
  let m = stats_dist_f_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn StatsdistfMatrix::get(self : StatsdistfMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn StatsdistfMatrix::transpose(self : StatsdistfMatrix) -> StatsdistfMatrix {
  let result = stats_dist_f_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn StatsdistfMatrix::add(self : StatsdistfMatrix, other : StatsdistfMatrix) -> StatsdistfMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = stats_dist_f_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn StatsdistfMatrix::scale(self : StatsdistfMatrix, s : Double) -> StatsdistfMatrix {
  let result = stats_dist_f_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn StatsdistfMatrix::multiply(self : StatsdistfMatrix, other : StatsdistfMatrix) -> StatsdistfMatrix {
  if self.cols != other.rows { return stats_dist_f_make_matrix(self.rows, other.cols, 0.0) }
  let result = stats_dist_f_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn StatsdistfMatrix::trace(self : StatsdistfMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn StatsdistfMatrix::det(self : StatsdistfMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn StatsdistfMatrix::norm(self : StatsdistfMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn StatsdistfMatrix::to_string(self : StatsdistfMatrix) -> String {
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

pub(all) struct StatsdistfVector {
  comps : Array[Double]
  dim : Int
}

pub fn stats_dist_f_make_vector(comps : Array[Double]) -> StatsdistfVector {
  { comps, dim: comps.length() }
}

pub fn stats_dist_f_vector_zero(dim : Int) -> StatsdistfVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn StatsdistfVector::add(self : StatsdistfVector, other : StatsdistfVector) -> StatsdistfVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn StatsdistfVector::sub(self : StatsdistfVector, other : StatsdistfVector) -> StatsdistfVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn StatsdistfVector::scale(self : StatsdistfVector, s : Double) -> StatsdistfVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn StatsdistfVector::dot(self : StatsdistfVector, other : StatsdistfVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn StatsdistfVector::norm(self : StatsdistfVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn StatsdistfVector::normalize(self : StatsdistfVector) -> StatsdistfVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn StatsdistfVector::dist(self : StatsdistfVector, other : StatsdistfVector) -> Double {
  self.sub(other).norm()
}

pub fn StatsdistfVector::to_string(self : StatsdistfVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn stats_dist_f_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn stats_dist_f_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn stats_dist_f_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn stats_dist_f_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn stats_dist_f_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn stats_dist_f_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn stats_dist_f_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn stats_dist_f_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn stats_dist_f_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn stats_dist_f_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn stats_dist_f_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn stats_dist_f_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn stats_dist_f_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn stats_dist_f_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn stats_dist_f_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn stats_dist_f_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn stats_dist_f_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn stats_dist_f_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn stats_dist_f_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn stats_dist_f_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn stats_dist_f_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn stats_dist_f_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn stats_dist_f_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn stats_dist_f_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn stats_dist_f_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn stats_dist_f_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn stats_dist_f_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn stats_dist_f_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn stats_dist_f_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct StatsdistfFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_f_frame_make(size : Int) -> StatsdistfFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_f_frame_len(s : StatsdistfFrame) -> Int { s.size }

pub fn stats_dist_f_frame_get(s : StatsdistfFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_f_frame_set(s : StatsdistfFrame, i : Int, v : Double) -> StatsdistfFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_dist_f_frame_sum(s : StatsdistfFrame) -> Double { @_common.sum(s.data) }

pub fn stats_dist_f_frame_mean(s : StatsdistfFrame) -> Double { @_common.mean(s.data) }

pub fn stats_dist_f_frame_scale(s : StatsdistfFrame, f : Double) -> StatsdistfFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_dist_f_frame_add(a : StatsdistfFrame, b : StatsdistfFrame) -> StatsdistfFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_dist_f_frame_copy(s : StatsdistfFrame) -> StatsdistfFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_dist_f_frame_fill(s : StatsdistfFrame, v : Double) -> StatsdistfFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_dist_f_frame_min(s : StatsdistfFrame) -> Double { @_common.min(s.data) }

pub fn stats_dist_f_frame_max(s : StatsdistfFrame) -> Double { @_common.max(s.data) }

pub fn stats_dist_f_frame_to_string(s : StatsdistfFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdistfTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_f_table_make(size : Int) -> StatsdistfTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_f_table_len(s : StatsdistfTable) -> Int { s.size }

pub fn stats_dist_f_table_get(s : StatsdistfTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_f_table_set(s : StatsdistfTable, i : Int, v : Double) -> StatsdistfTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_dist_f_table_sum(s : StatsdistfTable) -> Double { @_common.sum(s.data) }

pub fn stats_dist_f_table_mean(s : StatsdistfTable) -> Double { @_common.mean(s.data) }

pub fn stats_dist_f_table_scale(s : StatsdistfTable, f : Double) -> StatsdistfTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_dist_f_table_add(a : StatsdistfTable, b : StatsdistfTable) -> StatsdistfTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_dist_f_table_copy(s : StatsdistfTable) -> StatsdistfTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_dist_f_table_fill(s : StatsdistfTable, v : Double) -> StatsdistfTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_dist_f_table_min(s : StatsdistfTable) -> Double { @_common.min(s.data) }

pub fn stats_dist_f_table_max(s : StatsdistfTable) -> Double { @_common.max(s.data) }

pub fn stats_dist_f_table_to_string(s : StatsdistfTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdistfGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_f_graphn_make(size : Int) -> StatsdistfGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_f_graphn_len(s : StatsdistfGraphN) -> Int { s.size }

pub fn stats_dist_f_graphn_get(s : StatsdistfGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_f_graphn_set(s : StatsdistfGraphN, i : Int, v : Double) -> StatsdistfGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_dist_f_graphn_sum(s : StatsdistfGraphN) -> Double { @_common.sum(s.data) }

pub fn stats_dist_f_graphn_mean(s : StatsdistfGraphN) -> Double { @_common.mean(s.data) }

pub fn stats_dist_f_graphn_scale(s : StatsdistfGraphN, f : Double) -> StatsdistfGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_dist_f_graphn_add(a : StatsdistfGraphN, b : StatsdistfGraphN) -> StatsdistfGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_dist_f_graphn_copy(s : StatsdistfGraphN) -> StatsdistfGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_dist_f_graphn_fill(s : StatsdistfGraphN, v : Double) -> StatsdistfGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_dist_f_graphn_min(s : StatsdistfGraphN) -> Double { @_common.min(s.data) }

pub fn stats_dist_f_graphn_max(s : StatsdistfGraphN) -> Double { @_common.max(s.data) }

pub fn stats_dist_f_graphn_to_string(s : StatsdistfGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdistfNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_f_node_make(size : Int) -> StatsdistfNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_f_node_len(s : StatsdistfNode) -> Int { s.size }

pub fn stats_dist_f_node_get(s : StatsdistfNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_f_node_set(s : StatsdistfNode, i : Int, v : Double) -> StatsdistfNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_dist_f_node_sum(s : StatsdistfNode) -> Double { @_common.sum(s.data) }

pub fn stats_dist_f_node_mean(s : StatsdistfNode) -> Double { @_common.mean(s.data) }

pub fn stats_dist_f_node_scale(s : StatsdistfNode, f : Double) -> StatsdistfNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_dist_f_node_add(a : StatsdistfNode, b : StatsdistfNode) -> StatsdistfNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_dist_f_node_copy(s : StatsdistfNode) -> StatsdistfNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_dist_f_node_fill(s : StatsdistfNode, v : Double) -> StatsdistfNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_dist_f_node_min(s : StatsdistfNode) -> Double { @_common.min(s.data) }

pub fn stats_dist_f_node_max(s : StatsdistfNode) -> Double { @_common.max(s.data) }

pub fn stats_dist_f_node_to_string(s : StatsdistfNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdistfEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_f_edge_make(size : Int) -> StatsdistfEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_f_edge_len(s : StatsdistfEdge) -> Int { s.size }

pub fn stats_dist_f_edge_get(s : StatsdistfEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_f_edge_set(s : StatsdistfEdge, i : Int, v : Double) -> StatsdistfEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_dist_f_edge_sum(s : StatsdistfEdge) -> Double { @_common.sum(s.data) }

pub fn stats_dist_f_edge_mean(s : StatsdistfEdge) -> Double { @_common.mean(s.data) }

pub fn stats_dist_f_edge_scale(s : StatsdistfEdge, f : Double) -> StatsdistfEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_dist_f_edge_add(a : StatsdistfEdge, b : StatsdistfEdge) -> StatsdistfEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_dist_f_edge_copy(s : StatsdistfEdge) -> StatsdistfEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_dist_f_edge_fill(s : StatsdistfEdge, v : Double) -> StatsdistfEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_dist_f_edge_min(s : StatsdistfEdge) -> Double { @_common.min(s.data) }

pub fn stats_dist_f_edge_max(s : StatsdistfEdge) -> Double { @_common.max(s.data) }

pub fn stats_dist_f_edge_to_string(s : StatsdistfEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdistfPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_f_path_make(size : Int) -> StatsdistfPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_f_path_len(s : StatsdistfPath) -> Int { s.size }

pub fn stats_dist_f_path_get(s : StatsdistfPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_f_path_set(s : StatsdistfPath, i : Int, v : Double) -> StatsdistfPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_dist_f_path_sum(s : StatsdistfPath) -> Double { @_common.sum(s.data) }

pub fn stats_dist_f_path_mean(s : StatsdistfPath) -> Double { @_common.mean(s.data) }

pub fn stats_dist_f_path_scale(s : StatsdistfPath, f : Double) -> StatsdistfPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_dist_f_path_add(a : StatsdistfPath, b : StatsdistfPath) -> StatsdistfPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_dist_f_path_copy(s : StatsdistfPath) -> StatsdistfPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_dist_f_path_fill(s : StatsdistfPath, v : Double) -> StatsdistfPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_dist_f_path_min(s : StatsdistfPath) -> Double { @_common.min(s.data) }

pub fn stats_dist_f_path_max(s : StatsdistfPath) -> Double { @_common.max(s.data) }

pub fn stats_dist_f_path_to_string(s : StatsdistfPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdistfCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_f_cluster_make(size : Int) -> StatsdistfCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_f_cluster_len(s : StatsdistfCluster) -> Int { s.size }

pub fn stats_dist_f_cluster_get(s : StatsdistfCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_f_cluster_set(s : StatsdistfCluster, i : Int, v : Double) -> StatsdistfCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_dist_f_cluster_sum(s : StatsdistfCluster) -> Double { @_common.sum(s.data) }

pub fn stats_dist_f_cluster_mean(s : StatsdistfCluster) -> Double { @_common.mean(s.data) }

pub fn stats_dist_f_cluster_scale(s : StatsdistfCluster, f : Double) -> StatsdistfCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_dist_f_cluster_add(a : StatsdistfCluster, b : StatsdistfCluster) -> StatsdistfCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_dist_f_cluster_copy(s : StatsdistfCluster) -> StatsdistfCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_dist_f_cluster_fill(s : StatsdistfCluster, v : Double) -> StatsdistfCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_dist_f_cluster_min(s : StatsdistfCluster) -> Double { @_common.min(s.data) }

pub fn stats_dist_f_cluster_max(s : StatsdistfCluster) -> Double { @_common.max(s.data) }

pub fn stats_dist_f_cluster_to_string(s : StatsdistfCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdistfModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_f_model_make(size : Int) -> StatsdistfModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_f_model_len(s : StatsdistfModel) -> Int { s.size }

pub fn stats_dist_f_model_get(s : StatsdistfModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_f_model_set(s : StatsdistfModel, i : Int, v : Double) -> StatsdistfModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_dist_f_model_sum(s : StatsdistfModel) -> Double { @_common.sum(s.data) }

pub fn stats_dist_f_model_mean(s : StatsdistfModel) -> Double { @_common.mean(s.data) }

pub fn stats_dist_f_model_scale(s : StatsdistfModel, f : Double) -> StatsdistfModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_dist_f_model_add(a : StatsdistfModel, b : StatsdistfModel) -> StatsdistfModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_dist_f_model_copy(s : StatsdistfModel) -> StatsdistfModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_dist_f_model_fill(s : StatsdistfModel, v : Double) -> StatsdistfModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_dist_f_model_min(s : StatsdistfModel) -> Double { @_common.min(s.data) }

pub fn stats_dist_f_model_max(s : StatsdistfModel) -> Double { @_common.max(s.data) }

pub fn stats_dist_f_model_to_string(s : StatsdistfModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdistfLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_f_layer_make(size : Int) -> StatsdistfLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_f_layer_len(s : StatsdistfLayer) -> Int { s.size }

pub fn stats_dist_f_layer_get(s : StatsdistfLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_f_layer_set(s : StatsdistfLayer, i : Int, v : Double) -> StatsdistfLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_dist_f_layer_sum(s : StatsdistfLayer) -> Double { @_common.sum(s.data) }

pub fn stats_dist_f_layer_mean(s : StatsdistfLayer) -> Double { @_common.mean(s.data) }

pub fn stats_dist_f_layer_scale(s : StatsdistfLayer, f : Double) -> StatsdistfLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_dist_f_layer_add(a : StatsdistfLayer, b : StatsdistfLayer) -> StatsdistfLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_dist_f_layer_copy(s : StatsdistfLayer) -> StatsdistfLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_dist_f_layer_fill(s : StatsdistfLayer, v : Double) -> StatsdistfLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_dist_f_layer_min(s : StatsdistfLayer) -> Double { @_common.min(s.data) }

pub fn stats_dist_f_layer_max(s : StatsdistfLayer) -> Double { @_common.max(s.data) }

pub fn stats_dist_f_layer_to_string(s : StatsdistfLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdistfBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_f_buffer_make(size : Int) -> StatsdistfBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_f_buffer_len(s : StatsdistfBuffer) -> Int { s.size }

pub fn stats_dist_f_buffer_get(s : StatsdistfBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_f_buffer_set(s : StatsdistfBuffer, i : Int, v : Double) -> StatsdistfBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_dist_f_buffer_sum(s : StatsdistfBuffer) -> Double { @_common.sum(s.data) }

pub fn stats_dist_f_buffer_mean(s : StatsdistfBuffer) -> Double { @_common.mean(s.data) }

pub fn stats_dist_f_buffer_scale(s : StatsdistfBuffer, f : Double) -> StatsdistfBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_dist_f_buffer_add(a : StatsdistfBuffer, b : StatsdistfBuffer) -> StatsdistfBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_dist_f_buffer_copy(s : StatsdistfBuffer) -> StatsdistfBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_dist_f_buffer_fill(s : StatsdistfBuffer, v : Double) -> StatsdistfBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_dist_f_buffer_min(s : StatsdistfBuffer) -> Double { @_common.min(s.data) }

pub fn stats_dist_f_buffer_max(s : StatsdistfBuffer) -> Double { @_common.max(s.data) }

pub fn stats_dist_f_buffer_to_string(s : StatsdistfBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdistfCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_f_cursor_make(size : Int) -> StatsdistfCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_f_cursor_len(s : StatsdistfCursor) -> Int { s.size }

pub fn stats_dist_f_cursor_get(s : StatsdistfCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_f_cursor_set(s : StatsdistfCursor, i : Int, v : Double) -> StatsdistfCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_dist_f_cursor_sum(s : StatsdistfCursor) -> Double { @_common.sum(s.data) }

pub fn stats_dist_f_cursor_mean(s : StatsdistfCursor) -> Double { @_common.mean(s.data) }

pub fn stats_dist_f_cursor_scale(s : StatsdistfCursor, f : Double) -> StatsdistfCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_dist_f_cursor_add(a : StatsdistfCursor, b : StatsdistfCursor) -> StatsdistfCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_dist_f_cursor_copy(s : StatsdistfCursor) -> StatsdistfCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_dist_f_cursor_fill(s : StatsdistfCursor, v : Double) -> StatsdistfCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_dist_f_cursor_min(s : StatsdistfCursor) -> Double { @_common.min(s.data) }

pub fn stats_dist_f_cursor_max(s : StatsdistfCursor) -> Double { @_common.max(s.data) }

pub fn stats_dist_f_cursor_to_string(s : StatsdistfCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdistfView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_f_view_make(size : Int) -> StatsdistfView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_f_view_len(s : StatsdistfView) -> Int { s.size }

pub fn stats_dist_f_view_get(s : StatsdistfView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_f_view_set(s : StatsdistfView, i : Int, v : Double) -> StatsdistfView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_dist_f_view_sum(s : StatsdistfView) -> Double { @_common.sum(s.data) }

pub fn stats_dist_f_view_mean(s : StatsdistfView) -> Double { @_common.mean(s.data) }

pub fn stats_dist_f_view_scale(s : StatsdistfView, f : Double) -> StatsdistfView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_dist_f_view_add(a : StatsdistfView, b : StatsdistfView) -> StatsdistfView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_dist_f_view_copy(s : StatsdistfView) -> StatsdistfView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_dist_f_view_fill(s : StatsdistfView, v : Double) -> StatsdistfView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_dist_f_view_min(s : StatsdistfView) -> Double { @_common.min(s.data) }

pub fn stats_dist_f_view_max(s : StatsdistfView) -> Double { @_common.max(s.data) }

pub fn stats_dist_f_view_to_string(s : StatsdistfView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdistfRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_f_range_make(size : Int) -> StatsdistfRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_f_range_len(s : StatsdistfRange) -> Int { s.size }

pub fn stats_dist_f_range_get(s : StatsdistfRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_f_range_set(s : StatsdistfRange, i : Int, v : Double) -> StatsdistfRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_dist_f_range_sum(s : StatsdistfRange) -> Double { @_common.sum(s.data) }

pub fn stats_dist_f_range_mean(s : StatsdistfRange) -> Double { @_common.mean(s.data) }

pub fn stats_dist_f_range_scale(s : StatsdistfRange, f : Double) -> StatsdistfRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_dist_f_range_add(a : StatsdistfRange, b : StatsdistfRange) -> StatsdistfRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_dist_f_range_copy(s : StatsdistfRange) -> StatsdistfRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_dist_f_range_fill(s : StatsdistfRange, v : Double) -> StatsdistfRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_dist_f_range_min(s : StatsdistfRange) -> Double { @_common.min(s.data) }

pub fn stats_dist_f_range_max(s : StatsdistfRange) -> Double { @_common.max(s.data) }

pub fn stats_dist_f_range_to_string(s : StatsdistfRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdistfSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_f_slice_make(size : Int) -> StatsdistfSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_f_slice_len(s : StatsdistfSlice) -> Int { s.size }

pub fn stats_dist_f_slice_get(s : StatsdistfSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_f_slice_set(s : StatsdistfSlice, i : Int, v : Double) -> StatsdistfSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_dist_f_slice_sum(s : StatsdistfSlice) -> Double { @_common.sum(s.data) }

pub fn stats_dist_f_slice_mean(s : StatsdistfSlice) -> Double { @_common.mean(s.data) }

pub fn stats_dist_f_slice_scale(s : StatsdistfSlice, f : Double) -> StatsdistfSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_dist_f_slice_add(a : StatsdistfSlice, b : StatsdistfSlice) -> StatsdistfSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_dist_f_slice_copy(s : StatsdistfSlice) -> StatsdistfSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_dist_f_slice_fill(s : StatsdistfSlice, v : Double) -> StatsdistfSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_dist_f_slice_min(s : StatsdistfSlice) -> Double { @_common.min(s.data) }

pub fn stats_dist_f_slice_max(s : StatsdistfSlice) -> Double { @_common.max(s.data) }

pub fn stats_dist_f_slice_to_string(s : StatsdistfSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

