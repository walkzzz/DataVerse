///===
/// extcore/stats_dist_beta

pub(all) struct StatsdistbetaPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn stats_dist_beta_make_point(x : Double, y : Double) -> StatsdistbetaPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn stats_dist_beta_make_point3(x : Double, y : Double, z : Double) -> StatsdistbetaPoint {
  { x, y, z, label: 0 }
}

pub fn StatsdistbetaPoint::x(self : StatsdistbetaPoint) -> Double { self.x }

pub fn StatsdistbetaPoint::y(self : StatsdistbetaPoint) -> Double { self.y }

pub fn StatsdistbetaPoint::z(self : StatsdistbetaPoint) -> Double { self.z }

pub fn StatsdistbetaPoint::label(self : StatsdistbetaPoint) -> Int { self.label }

pub fn StatsdistbetaPoint::dist(self : StatsdistbetaPoint, other : StatsdistbetaPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn StatsdistbetaPoint::add(self : StatsdistbetaPoint, other : StatsdistbetaPoint) -> StatsdistbetaPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn StatsdistbetaPoint::sub(self : StatsdistbetaPoint, other : StatsdistbetaPoint) -> StatsdistbetaPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn StatsdistbetaPoint::scale(self : StatsdistbetaPoint, s : Double) -> StatsdistbetaPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn StatsdistbetaPoint::dot(self : StatsdistbetaPoint, other : StatsdistbetaPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn StatsdistbetaPoint::cross(self : StatsdistbetaPoint, other : StatsdistbetaPoint) -> StatsdistbetaPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn StatsdistbetaPoint::norm(self : StatsdistbetaPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn StatsdistbetaPoint::normalize(self : StatsdistbetaPoint) -> StatsdistbetaPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn StatsdistbetaPoint::negate(self : StatsdistbetaPoint) -> StatsdistbetaPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn StatsdistbetaPoint::mid(self : StatsdistbetaPoint, other : StatsdistbetaPoint) -> StatsdistbetaPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn StatsdistbetaPoint::lerp(self : StatsdistbetaPoint, other : StatsdistbetaPoint, t : Double) -> StatsdistbetaPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn StatsdistbetaPoint::to_string(self : StatsdistbetaPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct StatsdistbetaSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn stats_dist_beta_make_series(vals : Array[Double], name : String) -> StatsdistbetaSeries {
  { vals, name, meta: 0 }
}

pub fn StatsdistbetaSeries::len(self : StatsdistbetaSeries) -> Int { self.vals.length() }

pub fn StatsdistbetaSeries::sum(self : StatsdistbetaSeries) -> Double { @_common.sum(self.vals) }

pub fn StatsdistbetaSeries::mean(self : StatsdistbetaSeries) -> Double { @_common.mean(self.vals) }

pub fn StatsdistbetaSeries::min(self : StatsdistbetaSeries) -> Double { @_common.min(self.vals) }

pub fn StatsdistbetaSeries::max(self : StatsdistbetaSeries) -> Double { @_common.max(self.vals) }

pub fn StatsdistbetaSeries::range(self : StatsdistbetaSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn StatsdistbetaSeries::variance(self : StatsdistbetaSeries) -> Double { @_common.variance(self.vals) }

pub fn StatsdistbetaSeries::std(self : StatsdistbetaSeries) -> Double { @_common.std(self.vals) }

pub fn StatsdistbetaSeries::median(self : StatsdistbetaSeries) -> Double { @_common.median(self.vals) }

pub fn StatsdistbetaSeries::scale(self : StatsdistbetaSeries, f : Double) -> StatsdistbetaSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn StatsdistbetaSeries::add(self : StatsdistbetaSeries, other : StatsdistbetaSeries) -> StatsdistbetaSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn StatsdistbetaSeries::sub(self : StatsdistbetaSeries, other : StatsdistbetaSeries) -> StatsdistbetaSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn StatsdistbetaSeries::normalize(self : StatsdistbetaSeries) -> StatsdistbetaSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn StatsdistbetaSeries::cumsum(self : StatsdistbetaSeries) -> StatsdistbetaSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn StatsdistbetaSeries::to_string(self : StatsdistbetaSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct StatsdistbetaMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn stats_dist_beta_make_matrix(rows : Int, cols : Int, val : Double) -> StatsdistbetaMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn stats_dist_beta_matrix_identity(n : Int) -> StatsdistbetaMatrix {
  let m = stats_dist_beta_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn StatsdistbetaMatrix::get(self : StatsdistbetaMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn StatsdistbetaMatrix::transpose(self : StatsdistbetaMatrix) -> StatsdistbetaMatrix {
  let result = stats_dist_beta_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn StatsdistbetaMatrix::add(self : StatsdistbetaMatrix, other : StatsdistbetaMatrix) -> StatsdistbetaMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = stats_dist_beta_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn StatsdistbetaMatrix::scale(self : StatsdistbetaMatrix, s : Double) -> StatsdistbetaMatrix {
  let result = stats_dist_beta_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn StatsdistbetaMatrix::multiply(self : StatsdistbetaMatrix, other : StatsdistbetaMatrix) -> StatsdistbetaMatrix {
  if self.cols != other.rows { return stats_dist_beta_make_matrix(self.rows, other.cols, 0.0) }
  let result = stats_dist_beta_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn StatsdistbetaMatrix::trace(self : StatsdistbetaMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn StatsdistbetaMatrix::det(self : StatsdistbetaMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn StatsdistbetaMatrix::norm(self : StatsdistbetaMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn StatsdistbetaMatrix::to_string(self : StatsdistbetaMatrix) -> String {
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

pub(all) struct StatsdistbetaVector {
  comps : Array[Double]
  dim : Int
}

pub fn stats_dist_beta_make_vector(comps : Array[Double]) -> StatsdistbetaVector {
  { comps, dim: comps.length() }
}

pub fn stats_dist_beta_vector_zero(dim : Int) -> StatsdistbetaVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn StatsdistbetaVector::add(self : StatsdistbetaVector, other : StatsdistbetaVector) -> StatsdistbetaVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn StatsdistbetaVector::sub(self : StatsdistbetaVector, other : StatsdistbetaVector) -> StatsdistbetaVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn StatsdistbetaVector::scale(self : StatsdistbetaVector, s : Double) -> StatsdistbetaVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn StatsdistbetaVector::dot(self : StatsdistbetaVector, other : StatsdistbetaVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn StatsdistbetaVector::norm(self : StatsdistbetaVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn StatsdistbetaVector::normalize(self : StatsdistbetaVector) -> StatsdistbetaVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn StatsdistbetaVector::dist(self : StatsdistbetaVector, other : StatsdistbetaVector) -> Double {
  self.sub(other).norm()
}

pub fn StatsdistbetaVector::to_string(self : StatsdistbetaVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn stats_dist_beta_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn stats_dist_beta_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn stats_dist_beta_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn stats_dist_beta_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn stats_dist_beta_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn stats_dist_beta_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn stats_dist_beta_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn stats_dist_beta_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn stats_dist_beta_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn stats_dist_beta_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn stats_dist_beta_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn stats_dist_beta_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn stats_dist_beta_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn stats_dist_beta_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn stats_dist_beta_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn stats_dist_beta_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn stats_dist_beta_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn stats_dist_beta_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn stats_dist_beta_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn stats_dist_beta_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn stats_dist_beta_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn stats_dist_beta_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn stats_dist_beta_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn stats_dist_beta_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn stats_dist_beta_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn stats_dist_beta_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn stats_dist_beta_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn stats_dist_beta_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn stats_dist_beta_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct StatsdistbetaFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_beta_frame_make(size : Int) -> StatsdistbetaFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_beta_frame_len(s : StatsdistbetaFrame) -> Int { s.size }

pub fn stats_dist_beta_frame_get(s : StatsdistbetaFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_beta_frame_set(s : StatsdistbetaFrame, i : Int, v : Double) -> StatsdistbetaFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_dist_beta_frame_sum(s : StatsdistbetaFrame) -> Double { @_common.sum(s.data) }

pub fn stats_dist_beta_frame_mean(s : StatsdistbetaFrame) -> Double { @_common.mean(s.data) }

pub fn stats_dist_beta_frame_scale(s : StatsdistbetaFrame, f : Double) -> StatsdistbetaFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_dist_beta_frame_add(a : StatsdistbetaFrame, b : StatsdistbetaFrame) -> StatsdistbetaFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_dist_beta_frame_copy(s : StatsdistbetaFrame) -> StatsdistbetaFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_dist_beta_frame_fill(s : StatsdistbetaFrame, v : Double) -> StatsdistbetaFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_dist_beta_frame_min(s : StatsdistbetaFrame) -> Double { @_common.min(s.data) }

pub fn stats_dist_beta_frame_max(s : StatsdistbetaFrame) -> Double { @_common.max(s.data) }

pub fn stats_dist_beta_frame_to_string(s : StatsdistbetaFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdistbetaTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_beta_table_make(size : Int) -> StatsdistbetaTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_beta_table_len(s : StatsdistbetaTable) -> Int { s.size }

pub fn stats_dist_beta_table_get(s : StatsdistbetaTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_beta_table_set(s : StatsdistbetaTable, i : Int, v : Double) -> StatsdistbetaTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_dist_beta_table_sum(s : StatsdistbetaTable) -> Double { @_common.sum(s.data) }

pub fn stats_dist_beta_table_mean(s : StatsdistbetaTable) -> Double { @_common.mean(s.data) }

pub fn stats_dist_beta_table_scale(s : StatsdistbetaTable, f : Double) -> StatsdistbetaTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_dist_beta_table_add(a : StatsdistbetaTable, b : StatsdistbetaTable) -> StatsdistbetaTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_dist_beta_table_copy(s : StatsdistbetaTable) -> StatsdistbetaTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_dist_beta_table_fill(s : StatsdistbetaTable, v : Double) -> StatsdistbetaTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_dist_beta_table_min(s : StatsdistbetaTable) -> Double { @_common.min(s.data) }

pub fn stats_dist_beta_table_max(s : StatsdistbetaTable) -> Double { @_common.max(s.data) }

pub fn stats_dist_beta_table_to_string(s : StatsdistbetaTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdistbetaGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_beta_graphn_make(size : Int) -> StatsdistbetaGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_beta_graphn_len(s : StatsdistbetaGraphN) -> Int { s.size }

pub fn stats_dist_beta_graphn_get(s : StatsdistbetaGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_beta_graphn_set(s : StatsdistbetaGraphN, i : Int, v : Double) -> StatsdistbetaGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_dist_beta_graphn_sum(s : StatsdistbetaGraphN) -> Double { @_common.sum(s.data) }

pub fn stats_dist_beta_graphn_mean(s : StatsdistbetaGraphN) -> Double { @_common.mean(s.data) }

pub fn stats_dist_beta_graphn_scale(s : StatsdistbetaGraphN, f : Double) -> StatsdistbetaGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_dist_beta_graphn_add(a : StatsdistbetaGraphN, b : StatsdistbetaGraphN) -> StatsdistbetaGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_dist_beta_graphn_copy(s : StatsdistbetaGraphN) -> StatsdistbetaGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_dist_beta_graphn_fill(s : StatsdistbetaGraphN, v : Double) -> StatsdistbetaGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_dist_beta_graphn_min(s : StatsdistbetaGraphN) -> Double { @_common.min(s.data) }

pub fn stats_dist_beta_graphn_max(s : StatsdistbetaGraphN) -> Double { @_common.max(s.data) }

pub fn stats_dist_beta_graphn_to_string(s : StatsdistbetaGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdistbetaNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_beta_node_make(size : Int) -> StatsdistbetaNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_beta_node_len(s : StatsdistbetaNode) -> Int { s.size }

pub fn stats_dist_beta_node_get(s : StatsdistbetaNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_beta_node_set(s : StatsdistbetaNode, i : Int, v : Double) -> StatsdistbetaNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_dist_beta_node_sum(s : StatsdistbetaNode) -> Double { @_common.sum(s.data) }

pub fn stats_dist_beta_node_mean(s : StatsdistbetaNode) -> Double { @_common.mean(s.data) }

pub fn stats_dist_beta_node_scale(s : StatsdistbetaNode, f : Double) -> StatsdistbetaNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_dist_beta_node_add(a : StatsdistbetaNode, b : StatsdistbetaNode) -> StatsdistbetaNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_dist_beta_node_copy(s : StatsdistbetaNode) -> StatsdistbetaNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_dist_beta_node_fill(s : StatsdistbetaNode, v : Double) -> StatsdistbetaNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_dist_beta_node_min(s : StatsdistbetaNode) -> Double { @_common.min(s.data) }

pub fn stats_dist_beta_node_max(s : StatsdistbetaNode) -> Double { @_common.max(s.data) }

pub fn stats_dist_beta_node_to_string(s : StatsdistbetaNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdistbetaEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_beta_edge_make(size : Int) -> StatsdistbetaEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_beta_edge_len(s : StatsdistbetaEdge) -> Int { s.size }

pub fn stats_dist_beta_edge_get(s : StatsdistbetaEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_beta_edge_set(s : StatsdistbetaEdge, i : Int, v : Double) -> StatsdistbetaEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_dist_beta_edge_sum(s : StatsdistbetaEdge) -> Double { @_common.sum(s.data) }

pub fn stats_dist_beta_edge_mean(s : StatsdistbetaEdge) -> Double { @_common.mean(s.data) }

pub fn stats_dist_beta_edge_scale(s : StatsdistbetaEdge, f : Double) -> StatsdistbetaEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_dist_beta_edge_add(a : StatsdistbetaEdge, b : StatsdistbetaEdge) -> StatsdistbetaEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_dist_beta_edge_copy(s : StatsdistbetaEdge) -> StatsdistbetaEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_dist_beta_edge_fill(s : StatsdistbetaEdge, v : Double) -> StatsdistbetaEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_dist_beta_edge_min(s : StatsdistbetaEdge) -> Double { @_common.min(s.data) }

pub fn stats_dist_beta_edge_max(s : StatsdistbetaEdge) -> Double { @_common.max(s.data) }

pub fn stats_dist_beta_edge_to_string(s : StatsdistbetaEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdistbetaPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_beta_path_make(size : Int) -> StatsdistbetaPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_beta_path_len(s : StatsdistbetaPath) -> Int { s.size }

pub fn stats_dist_beta_path_get(s : StatsdistbetaPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_beta_path_set(s : StatsdistbetaPath, i : Int, v : Double) -> StatsdistbetaPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_dist_beta_path_sum(s : StatsdistbetaPath) -> Double { @_common.sum(s.data) }

pub fn stats_dist_beta_path_mean(s : StatsdistbetaPath) -> Double { @_common.mean(s.data) }

pub fn stats_dist_beta_path_scale(s : StatsdistbetaPath, f : Double) -> StatsdistbetaPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_dist_beta_path_add(a : StatsdistbetaPath, b : StatsdistbetaPath) -> StatsdistbetaPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_dist_beta_path_copy(s : StatsdistbetaPath) -> StatsdistbetaPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_dist_beta_path_fill(s : StatsdistbetaPath, v : Double) -> StatsdistbetaPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_dist_beta_path_min(s : StatsdistbetaPath) -> Double { @_common.min(s.data) }

pub fn stats_dist_beta_path_max(s : StatsdistbetaPath) -> Double { @_common.max(s.data) }

pub fn stats_dist_beta_path_to_string(s : StatsdistbetaPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdistbetaCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_beta_cluster_make(size : Int) -> StatsdistbetaCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_beta_cluster_len(s : StatsdistbetaCluster) -> Int { s.size }

pub fn stats_dist_beta_cluster_get(s : StatsdistbetaCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_beta_cluster_set(s : StatsdistbetaCluster, i : Int, v : Double) -> StatsdistbetaCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_dist_beta_cluster_sum(s : StatsdistbetaCluster) -> Double { @_common.sum(s.data) }

pub fn stats_dist_beta_cluster_mean(s : StatsdistbetaCluster) -> Double { @_common.mean(s.data) }

pub fn stats_dist_beta_cluster_scale(s : StatsdistbetaCluster, f : Double) -> StatsdistbetaCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_dist_beta_cluster_add(a : StatsdistbetaCluster, b : StatsdistbetaCluster) -> StatsdistbetaCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_dist_beta_cluster_copy(s : StatsdistbetaCluster) -> StatsdistbetaCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_dist_beta_cluster_fill(s : StatsdistbetaCluster, v : Double) -> StatsdistbetaCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_dist_beta_cluster_min(s : StatsdistbetaCluster) -> Double { @_common.min(s.data) }

pub fn stats_dist_beta_cluster_max(s : StatsdistbetaCluster) -> Double { @_common.max(s.data) }

pub fn stats_dist_beta_cluster_to_string(s : StatsdistbetaCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdistbetaModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_beta_model_make(size : Int) -> StatsdistbetaModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_beta_model_len(s : StatsdistbetaModel) -> Int { s.size }

pub fn stats_dist_beta_model_get(s : StatsdistbetaModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_beta_model_set(s : StatsdistbetaModel, i : Int, v : Double) -> StatsdistbetaModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_dist_beta_model_sum(s : StatsdistbetaModel) -> Double { @_common.sum(s.data) }

pub fn stats_dist_beta_model_mean(s : StatsdistbetaModel) -> Double { @_common.mean(s.data) }

pub fn stats_dist_beta_model_scale(s : StatsdistbetaModel, f : Double) -> StatsdistbetaModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_dist_beta_model_add(a : StatsdistbetaModel, b : StatsdistbetaModel) -> StatsdistbetaModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_dist_beta_model_copy(s : StatsdistbetaModel) -> StatsdistbetaModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_dist_beta_model_fill(s : StatsdistbetaModel, v : Double) -> StatsdistbetaModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_dist_beta_model_min(s : StatsdistbetaModel) -> Double { @_common.min(s.data) }

pub fn stats_dist_beta_model_max(s : StatsdistbetaModel) -> Double { @_common.max(s.data) }

pub fn stats_dist_beta_model_to_string(s : StatsdistbetaModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdistbetaLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_beta_layer_make(size : Int) -> StatsdistbetaLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_beta_layer_len(s : StatsdistbetaLayer) -> Int { s.size }

pub fn stats_dist_beta_layer_get(s : StatsdistbetaLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_beta_layer_set(s : StatsdistbetaLayer, i : Int, v : Double) -> StatsdistbetaLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_dist_beta_layer_sum(s : StatsdistbetaLayer) -> Double { @_common.sum(s.data) }

pub fn stats_dist_beta_layer_mean(s : StatsdistbetaLayer) -> Double { @_common.mean(s.data) }

pub fn stats_dist_beta_layer_scale(s : StatsdistbetaLayer, f : Double) -> StatsdistbetaLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_dist_beta_layer_add(a : StatsdistbetaLayer, b : StatsdistbetaLayer) -> StatsdistbetaLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_dist_beta_layer_copy(s : StatsdistbetaLayer) -> StatsdistbetaLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_dist_beta_layer_fill(s : StatsdistbetaLayer, v : Double) -> StatsdistbetaLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_dist_beta_layer_min(s : StatsdistbetaLayer) -> Double { @_common.min(s.data) }

pub fn stats_dist_beta_layer_max(s : StatsdistbetaLayer) -> Double { @_common.max(s.data) }

pub fn stats_dist_beta_layer_to_string(s : StatsdistbetaLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdistbetaBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_beta_buffer_make(size : Int) -> StatsdistbetaBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_beta_buffer_len(s : StatsdistbetaBuffer) -> Int { s.size }

pub fn stats_dist_beta_buffer_get(s : StatsdistbetaBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_beta_buffer_set(s : StatsdistbetaBuffer, i : Int, v : Double) -> StatsdistbetaBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_dist_beta_buffer_sum(s : StatsdistbetaBuffer) -> Double { @_common.sum(s.data) }

pub fn stats_dist_beta_buffer_mean(s : StatsdistbetaBuffer) -> Double { @_common.mean(s.data) }

pub fn stats_dist_beta_buffer_scale(s : StatsdistbetaBuffer, f : Double) -> StatsdistbetaBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_dist_beta_buffer_add(a : StatsdistbetaBuffer, b : StatsdistbetaBuffer) -> StatsdistbetaBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_dist_beta_buffer_copy(s : StatsdistbetaBuffer) -> StatsdistbetaBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_dist_beta_buffer_fill(s : StatsdistbetaBuffer, v : Double) -> StatsdistbetaBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_dist_beta_buffer_min(s : StatsdistbetaBuffer) -> Double { @_common.min(s.data) }

pub fn stats_dist_beta_buffer_max(s : StatsdistbetaBuffer) -> Double { @_common.max(s.data) }

pub fn stats_dist_beta_buffer_to_string(s : StatsdistbetaBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdistbetaCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_beta_cursor_make(size : Int) -> StatsdistbetaCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_beta_cursor_len(s : StatsdistbetaCursor) -> Int { s.size }

pub fn stats_dist_beta_cursor_get(s : StatsdistbetaCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_beta_cursor_set(s : StatsdistbetaCursor, i : Int, v : Double) -> StatsdistbetaCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_dist_beta_cursor_sum(s : StatsdistbetaCursor) -> Double { @_common.sum(s.data) }

pub fn stats_dist_beta_cursor_mean(s : StatsdistbetaCursor) -> Double { @_common.mean(s.data) }

pub fn stats_dist_beta_cursor_scale(s : StatsdistbetaCursor, f : Double) -> StatsdistbetaCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_dist_beta_cursor_add(a : StatsdistbetaCursor, b : StatsdistbetaCursor) -> StatsdistbetaCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_dist_beta_cursor_copy(s : StatsdistbetaCursor) -> StatsdistbetaCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_dist_beta_cursor_fill(s : StatsdistbetaCursor, v : Double) -> StatsdistbetaCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_dist_beta_cursor_min(s : StatsdistbetaCursor) -> Double { @_common.min(s.data) }

pub fn stats_dist_beta_cursor_max(s : StatsdistbetaCursor) -> Double { @_common.max(s.data) }

pub fn stats_dist_beta_cursor_to_string(s : StatsdistbetaCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdistbetaView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_beta_view_make(size : Int) -> StatsdistbetaView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_beta_view_len(s : StatsdistbetaView) -> Int { s.size }

pub fn stats_dist_beta_view_get(s : StatsdistbetaView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_beta_view_set(s : StatsdistbetaView, i : Int, v : Double) -> StatsdistbetaView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_dist_beta_view_sum(s : StatsdistbetaView) -> Double { @_common.sum(s.data) }

pub fn stats_dist_beta_view_mean(s : StatsdistbetaView) -> Double { @_common.mean(s.data) }

pub fn stats_dist_beta_view_scale(s : StatsdistbetaView, f : Double) -> StatsdistbetaView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_dist_beta_view_add(a : StatsdistbetaView, b : StatsdistbetaView) -> StatsdistbetaView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_dist_beta_view_copy(s : StatsdistbetaView) -> StatsdistbetaView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_dist_beta_view_fill(s : StatsdistbetaView, v : Double) -> StatsdistbetaView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_dist_beta_view_min(s : StatsdistbetaView) -> Double { @_common.min(s.data) }

pub fn stats_dist_beta_view_max(s : StatsdistbetaView) -> Double { @_common.max(s.data) }

pub fn stats_dist_beta_view_to_string(s : StatsdistbetaView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdistbetaRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_beta_range_make(size : Int) -> StatsdistbetaRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_beta_range_len(s : StatsdistbetaRange) -> Int { s.size }

pub fn stats_dist_beta_range_get(s : StatsdistbetaRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_beta_range_set(s : StatsdistbetaRange, i : Int, v : Double) -> StatsdistbetaRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_dist_beta_range_sum(s : StatsdistbetaRange) -> Double { @_common.sum(s.data) }

pub fn stats_dist_beta_range_mean(s : StatsdistbetaRange) -> Double { @_common.mean(s.data) }

pub fn stats_dist_beta_range_scale(s : StatsdistbetaRange, f : Double) -> StatsdistbetaRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_dist_beta_range_add(a : StatsdistbetaRange, b : StatsdistbetaRange) -> StatsdistbetaRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_dist_beta_range_copy(s : StatsdistbetaRange) -> StatsdistbetaRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_dist_beta_range_fill(s : StatsdistbetaRange, v : Double) -> StatsdistbetaRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_dist_beta_range_min(s : StatsdistbetaRange) -> Double { @_common.min(s.data) }

pub fn stats_dist_beta_range_max(s : StatsdistbetaRange) -> Double { @_common.max(s.data) }

pub fn stats_dist_beta_range_to_string(s : StatsdistbetaRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdistbetaSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_beta_slice_make(size : Int) -> StatsdistbetaSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_beta_slice_len(s : StatsdistbetaSlice) -> Int { s.size }

pub fn stats_dist_beta_slice_get(s : StatsdistbetaSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_beta_slice_set(s : StatsdistbetaSlice, i : Int, v : Double) -> StatsdistbetaSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_dist_beta_slice_sum(s : StatsdistbetaSlice) -> Double { @_common.sum(s.data) }

pub fn stats_dist_beta_slice_mean(s : StatsdistbetaSlice) -> Double { @_common.mean(s.data) }

pub fn stats_dist_beta_slice_scale(s : StatsdistbetaSlice, f : Double) -> StatsdistbetaSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_dist_beta_slice_add(a : StatsdistbetaSlice, b : StatsdistbetaSlice) -> StatsdistbetaSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_dist_beta_slice_copy(s : StatsdistbetaSlice) -> StatsdistbetaSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_dist_beta_slice_fill(s : StatsdistbetaSlice, v : Double) -> StatsdistbetaSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_dist_beta_slice_min(s : StatsdistbetaSlice) -> Double { @_common.min(s.data) }

pub fn stats_dist_beta_slice_max(s : StatsdistbetaSlice) -> Double { @_common.max(s.data) }

pub fn stats_dist_beta_slice_to_string(s : StatsdistbetaSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

