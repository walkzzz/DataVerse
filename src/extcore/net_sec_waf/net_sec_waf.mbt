///===
/// extcore/net_sec_waf

pub(all) struct NetsecwafPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn net_sec_waf_make_point(x : Double, y : Double) -> NetsecwafPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn net_sec_waf_make_point3(x : Double, y : Double, z : Double) -> NetsecwafPoint {
  { x, y, z, label: 0 }
}

pub fn NetsecwafPoint::x(self : NetsecwafPoint) -> Double { self.x }

pub fn NetsecwafPoint::y(self : NetsecwafPoint) -> Double { self.y }

pub fn NetsecwafPoint::z(self : NetsecwafPoint) -> Double { self.z }

pub fn NetsecwafPoint::label(self : NetsecwafPoint) -> Int { self.label }

pub fn NetsecwafPoint::dist(self : NetsecwafPoint, other : NetsecwafPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn NetsecwafPoint::add(self : NetsecwafPoint, other : NetsecwafPoint) -> NetsecwafPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn NetsecwafPoint::sub(self : NetsecwafPoint, other : NetsecwafPoint) -> NetsecwafPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn NetsecwafPoint::scale(self : NetsecwafPoint, s : Double) -> NetsecwafPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn NetsecwafPoint::dot(self : NetsecwafPoint, other : NetsecwafPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn NetsecwafPoint::cross(self : NetsecwafPoint, other : NetsecwafPoint) -> NetsecwafPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn NetsecwafPoint::norm(self : NetsecwafPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn NetsecwafPoint::normalize(self : NetsecwafPoint) -> NetsecwafPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn NetsecwafPoint::negate(self : NetsecwafPoint) -> NetsecwafPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn NetsecwafPoint::mid(self : NetsecwafPoint, other : NetsecwafPoint) -> NetsecwafPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn NetsecwafPoint::lerp(self : NetsecwafPoint, other : NetsecwafPoint, t : Double) -> NetsecwafPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn NetsecwafPoint::to_string(self : NetsecwafPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct NetsecwafSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn net_sec_waf_make_series(vals : Array[Double], name : String) -> NetsecwafSeries {
  { vals, name, meta: 0 }
}

pub fn NetsecwafSeries::len(self : NetsecwafSeries) -> Int { self.vals.length() }

pub fn NetsecwafSeries::sum(self : NetsecwafSeries) -> Double { @_common.sum(self.vals) }

pub fn NetsecwafSeries::mean(self : NetsecwafSeries) -> Double { @_common.mean(self.vals) }

pub fn NetsecwafSeries::min(self : NetsecwafSeries) -> Double { @_common.min(self.vals) }

pub fn NetsecwafSeries::max(self : NetsecwafSeries) -> Double { @_common.max(self.vals) }

pub fn NetsecwafSeries::range(self : NetsecwafSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn NetsecwafSeries::variance(self : NetsecwafSeries) -> Double { @_common.variance(self.vals) }

pub fn NetsecwafSeries::std(self : NetsecwafSeries) -> Double { @_common.std(self.vals) }

pub fn NetsecwafSeries::median(self : NetsecwafSeries) -> Double { @_common.median(self.vals) }

pub fn NetsecwafSeries::scale(self : NetsecwafSeries, f : Double) -> NetsecwafSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn NetsecwafSeries::add(self : NetsecwafSeries, other : NetsecwafSeries) -> NetsecwafSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn NetsecwafSeries::sub(self : NetsecwafSeries, other : NetsecwafSeries) -> NetsecwafSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn NetsecwafSeries::normalize(self : NetsecwafSeries) -> NetsecwafSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn NetsecwafSeries::cumsum(self : NetsecwafSeries) -> NetsecwafSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn NetsecwafSeries::to_string(self : NetsecwafSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct NetsecwafMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn net_sec_waf_make_matrix(rows : Int, cols : Int, val : Double) -> NetsecwafMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn net_sec_waf_matrix_identity(n : Int) -> NetsecwafMatrix {
  let m = net_sec_waf_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn NetsecwafMatrix::get(self : NetsecwafMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn NetsecwafMatrix::transpose(self : NetsecwafMatrix) -> NetsecwafMatrix {
  let result = net_sec_waf_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn NetsecwafMatrix::add(self : NetsecwafMatrix, other : NetsecwafMatrix) -> NetsecwafMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = net_sec_waf_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn NetsecwafMatrix::scale(self : NetsecwafMatrix, s : Double) -> NetsecwafMatrix {
  let result = net_sec_waf_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn NetsecwafMatrix::multiply(self : NetsecwafMatrix, other : NetsecwafMatrix) -> NetsecwafMatrix {
  if self.cols != other.rows { return net_sec_waf_make_matrix(self.rows, other.cols, 0.0) }
  let result = net_sec_waf_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn NetsecwafMatrix::trace(self : NetsecwafMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn NetsecwafMatrix::det(self : NetsecwafMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn NetsecwafMatrix::norm(self : NetsecwafMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn NetsecwafMatrix::to_string(self : NetsecwafMatrix) -> String {
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

pub(all) struct NetsecwafVector {
  comps : Array[Double]
  dim : Int
}

pub fn net_sec_waf_make_vector(comps : Array[Double]) -> NetsecwafVector {
  { comps, dim: comps.length() }
}

pub fn net_sec_waf_vector_zero(dim : Int) -> NetsecwafVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn NetsecwafVector::add(self : NetsecwafVector, other : NetsecwafVector) -> NetsecwafVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn NetsecwafVector::sub(self : NetsecwafVector, other : NetsecwafVector) -> NetsecwafVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn NetsecwafVector::scale(self : NetsecwafVector, s : Double) -> NetsecwafVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn NetsecwafVector::dot(self : NetsecwafVector, other : NetsecwafVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn NetsecwafVector::norm(self : NetsecwafVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn NetsecwafVector::normalize(self : NetsecwafVector) -> NetsecwafVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn NetsecwafVector::dist(self : NetsecwafVector, other : NetsecwafVector) -> Double {
  self.sub(other).norm()
}

pub fn NetsecwafVector::to_string(self : NetsecwafVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn net_sec_waf_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn net_sec_waf_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn net_sec_waf_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn net_sec_waf_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn net_sec_waf_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn net_sec_waf_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn net_sec_waf_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn net_sec_waf_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn net_sec_waf_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn net_sec_waf_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn net_sec_waf_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn net_sec_waf_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn net_sec_waf_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn net_sec_waf_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn net_sec_waf_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn net_sec_waf_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn net_sec_waf_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn net_sec_waf_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn net_sec_waf_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn net_sec_waf_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn net_sec_waf_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn net_sec_waf_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn net_sec_waf_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn net_sec_waf_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn net_sec_waf_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn net_sec_waf_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn net_sec_waf_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn net_sec_waf_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn net_sec_waf_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct NetsecwafFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_sec_waf_frame_make(size : Int) -> NetsecwafFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_sec_waf_frame_len(s : NetsecwafFrame) -> Int { s.size }

pub fn net_sec_waf_frame_get(s : NetsecwafFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_sec_waf_frame_set(s : NetsecwafFrame, i : Int, v : Double) -> NetsecwafFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn net_sec_waf_frame_sum(s : NetsecwafFrame) -> Double { @_common.sum(s.data) }

pub fn net_sec_waf_frame_mean(s : NetsecwafFrame) -> Double { @_common.mean(s.data) }

pub fn net_sec_waf_frame_scale(s : NetsecwafFrame, f : Double) -> NetsecwafFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_sec_waf_frame_add(a : NetsecwafFrame, b : NetsecwafFrame) -> NetsecwafFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_sec_waf_frame_copy(s : NetsecwafFrame) -> NetsecwafFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_sec_waf_frame_fill(s : NetsecwafFrame, v : Double) -> NetsecwafFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_sec_waf_frame_min(s : NetsecwafFrame) -> Double { @_common.min(s.data) }

pub fn net_sec_waf_frame_max(s : NetsecwafFrame) -> Double { @_common.max(s.data) }

pub fn net_sec_waf_frame_to_string(s : NetsecwafFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetsecwafTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_sec_waf_table_make(size : Int) -> NetsecwafTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_sec_waf_table_len(s : NetsecwafTable) -> Int { s.size }

pub fn net_sec_waf_table_get(s : NetsecwafTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_sec_waf_table_set(s : NetsecwafTable, i : Int, v : Double) -> NetsecwafTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn net_sec_waf_table_sum(s : NetsecwafTable) -> Double { @_common.sum(s.data) }

pub fn net_sec_waf_table_mean(s : NetsecwafTable) -> Double { @_common.mean(s.data) }

pub fn net_sec_waf_table_scale(s : NetsecwafTable, f : Double) -> NetsecwafTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_sec_waf_table_add(a : NetsecwafTable, b : NetsecwafTable) -> NetsecwafTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_sec_waf_table_copy(s : NetsecwafTable) -> NetsecwafTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_sec_waf_table_fill(s : NetsecwafTable, v : Double) -> NetsecwafTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_sec_waf_table_min(s : NetsecwafTable) -> Double { @_common.min(s.data) }

pub fn net_sec_waf_table_max(s : NetsecwafTable) -> Double { @_common.max(s.data) }

pub fn net_sec_waf_table_to_string(s : NetsecwafTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetsecwafGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_sec_waf_graphn_make(size : Int) -> NetsecwafGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_sec_waf_graphn_len(s : NetsecwafGraphN) -> Int { s.size }

pub fn net_sec_waf_graphn_get(s : NetsecwafGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_sec_waf_graphn_set(s : NetsecwafGraphN, i : Int, v : Double) -> NetsecwafGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn net_sec_waf_graphn_sum(s : NetsecwafGraphN) -> Double { @_common.sum(s.data) }

pub fn net_sec_waf_graphn_mean(s : NetsecwafGraphN) -> Double { @_common.mean(s.data) }

pub fn net_sec_waf_graphn_scale(s : NetsecwafGraphN, f : Double) -> NetsecwafGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_sec_waf_graphn_add(a : NetsecwafGraphN, b : NetsecwafGraphN) -> NetsecwafGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_sec_waf_graphn_copy(s : NetsecwafGraphN) -> NetsecwafGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_sec_waf_graphn_fill(s : NetsecwafGraphN, v : Double) -> NetsecwafGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_sec_waf_graphn_min(s : NetsecwafGraphN) -> Double { @_common.min(s.data) }

pub fn net_sec_waf_graphn_max(s : NetsecwafGraphN) -> Double { @_common.max(s.data) }

pub fn net_sec_waf_graphn_to_string(s : NetsecwafGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetsecwafNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_sec_waf_node_make(size : Int) -> NetsecwafNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_sec_waf_node_len(s : NetsecwafNode) -> Int { s.size }

pub fn net_sec_waf_node_get(s : NetsecwafNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_sec_waf_node_set(s : NetsecwafNode, i : Int, v : Double) -> NetsecwafNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn net_sec_waf_node_sum(s : NetsecwafNode) -> Double { @_common.sum(s.data) }

pub fn net_sec_waf_node_mean(s : NetsecwafNode) -> Double { @_common.mean(s.data) }

pub fn net_sec_waf_node_scale(s : NetsecwafNode, f : Double) -> NetsecwafNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_sec_waf_node_add(a : NetsecwafNode, b : NetsecwafNode) -> NetsecwafNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_sec_waf_node_copy(s : NetsecwafNode) -> NetsecwafNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_sec_waf_node_fill(s : NetsecwafNode, v : Double) -> NetsecwafNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_sec_waf_node_min(s : NetsecwafNode) -> Double { @_common.min(s.data) }

pub fn net_sec_waf_node_max(s : NetsecwafNode) -> Double { @_common.max(s.data) }

pub fn net_sec_waf_node_to_string(s : NetsecwafNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetsecwafEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_sec_waf_edge_make(size : Int) -> NetsecwafEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_sec_waf_edge_len(s : NetsecwafEdge) -> Int { s.size }

pub fn net_sec_waf_edge_get(s : NetsecwafEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_sec_waf_edge_set(s : NetsecwafEdge, i : Int, v : Double) -> NetsecwafEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn net_sec_waf_edge_sum(s : NetsecwafEdge) -> Double { @_common.sum(s.data) }

pub fn net_sec_waf_edge_mean(s : NetsecwafEdge) -> Double { @_common.mean(s.data) }

pub fn net_sec_waf_edge_scale(s : NetsecwafEdge, f : Double) -> NetsecwafEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_sec_waf_edge_add(a : NetsecwafEdge, b : NetsecwafEdge) -> NetsecwafEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_sec_waf_edge_copy(s : NetsecwafEdge) -> NetsecwafEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_sec_waf_edge_fill(s : NetsecwafEdge, v : Double) -> NetsecwafEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_sec_waf_edge_min(s : NetsecwafEdge) -> Double { @_common.min(s.data) }

pub fn net_sec_waf_edge_max(s : NetsecwafEdge) -> Double { @_common.max(s.data) }

pub fn net_sec_waf_edge_to_string(s : NetsecwafEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetsecwafPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_sec_waf_path_make(size : Int) -> NetsecwafPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_sec_waf_path_len(s : NetsecwafPath) -> Int { s.size }

pub fn net_sec_waf_path_get(s : NetsecwafPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_sec_waf_path_set(s : NetsecwafPath, i : Int, v : Double) -> NetsecwafPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn net_sec_waf_path_sum(s : NetsecwafPath) -> Double { @_common.sum(s.data) }

pub fn net_sec_waf_path_mean(s : NetsecwafPath) -> Double { @_common.mean(s.data) }

pub fn net_sec_waf_path_scale(s : NetsecwafPath, f : Double) -> NetsecwafPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_sec_waf_path_add(a : NetsecwafPath, b : NetsecwafPath) -> NetsecwafPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_sec_waf_path_copy(s : NetsecwafPath) -> NetsecwafPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_sec_waf_path_fill(s : NetsecwafPath, v : Double) -> NetsecwafPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_sec_waf_path_min(s : NetsecwafPath) -> Double { @_common.min(s.data) }

pub fn net_sec_waf_path_max(s : NetsecwafPath) -> Double { @_common.max(s.data) }

pub fn net_sec_waf_path_to_string(s : NetsecwafPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetsecwafCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_sec_waf_cluster_make(size : Int) -> NetsecwafCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_sec_waf_cluster_len(s : NetsecwafCluster) -> Int { s.size }

pub fn net_sec_waf_cluster_get(s : NetsecwafCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_sec_waf_cluster_set(s : NetsecwafCluster, i : Int, v : Double) -> NetsecwafCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn net_sec_waf_cluster_sum(s : NetsecwafCluster) -> Double { @_common.sum(s.data) }

pub fn net_sec_waf_cluster_mean(s : NetsecwafCluster) -> Double { @_common.mean(s.data) }

pub fn net_sec_waf_cluster_scale(s : NetsecwafCluster, f : Double) -> NetsecwafCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_sec_waf_cluster_add(a : NetsecwafCluster, b : NetsecwafCluster) -> NetsecwafCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_sec_waf_cluster_copy(s : NetsecwafCluster) -> NetsecwafCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_sec_waf_cluster_fill(s : NetsecwafCluster, v : Double) -> NetsecwafCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_sec_waf_cluster_min(s : NetsecwafCluster) -> Double { @_common.min(s.data) }

pub fn net_sec_waf_cluster_max(s : NetsecwafCluster) -> Double { @_common.max(s.data) }

pub fn net_sec_waf_cluster_to_string(s : NetsecwafCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetsecwafModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_sec_waf_model_make(size : Int) -> NetsecwafModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_sec_waf_model_len(s : NetsecwafModel) -> Int { s.size }

pub fn net_sec_waf_model_get(s : NetsecwafModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_sec_waf_model_set(s : NetsecwafModel, i : Int, v : Double) -> NetsecwafModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn net_sec_waf_model_sum(s : NetsecwafModel) -> Double { @_common.sum(s.data) }

pub fn net_sec_waf_model_mean(s : NetsecwafModel) -> Double { @_common.mean(s.data) }

pub fn net_sec_waf_model_scale(s : NetsecwafModel, f : Double) -> NetsecwafModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_sec_waf_model_add(a : NetsecwafModel, b : NetsecwafModel) -> NetsecwafModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_sec_waf_model_copy(s : NetsecwafModel) -> NetsecwafModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_sec_waf_model_fill(s : NetsecwafModel, v : Double) -> NetsecwafModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_sec_waf_model_min(s : NetsecwafModel) -> Double { @_common.min(s.data) }

pub fn net_sec_waf_model_max(s : NetsecwafModel) -> Double { @_common.max(s.data) }

pub fn net_sec_waf_model_to_string(s : NetsecwafModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetsecwafLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_sec_waf_layer_make(size : Int) -> NetsecwafLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_sec_waf_layer_len(s : NetsecwafLayer) -> Int { s.size }

pub fn net_sec_waf_layer_get(s : NetsecwafLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_sec_waf_layer_set(s : NetsecwafLayer, i : Int, v : Double) -> NetsecwafLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn net_sec_waf_layer_sum(s : NetsecwafLayer) -> Double { @_common.sum(s.data) }

pub fn net_sec_waf_layer_mean(s : NetsecwafLayer) -> Double { @_common.mean(s.data) }

pub fn net_sec_waf_layer_scale(s : NetsecwafLayer, f : Double) -> NetsecwafLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_sec_waf_layer_add(a : NetsecwafLayer, b : NetsecwafLayer) -> NetsecwafLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_sec_waf_layer_copy(s : NetsecwafLayer) -> NetsecwafLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_sec_waf_layer_fill(s : NetsecwafLayer, v : Double) -> NetsecwafLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_sec_waf_layer_min(s : NetsecwafLayer) -> Double { @_common.min(s.data) }

pub fn net_sec_waf_layer_max(s : NetsecwafLayer) -> Double { @_common.max(s.data) }

pub fn net_sec_waf_layer_to_string(s : NetsecwafLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetsecwafBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_sec_waf_buffer_make(size : Int) -> NetsecwafBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_sec_waf_buffer_len(s : NetsecwafBuffer) -> Int { s.size }

pub fn net_sec_waf_buffer_get(s : NetsecwafBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_sec_waf_buffer_set(s : NetsecwafBuffer, i : Int, v : Double) -> NetsecwafBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn net_sec_waf_buffer_sum(s : NetsecwafBuffer) -> Double { @_common.sum(s.data) }

pub fn net_sec_waf_buffer_mean(s : NetsecwafBuffer) -> Double { @_common.mean(s.data) }

pub fn net_sec_waf_buffer_scale(s : NetsecwafBuffer, f : Double) -> NetsecwafBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_sec_waf_buffer_add(a : NetsecwafBuffer, b : NetsecwafBuffer) -> NetsecwafBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_sec_waf_buffer_copy(s : NetsecwafBuffer) -> NetsecwafBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_sec_waf_buffer_fill(s : NetsecwafBuffer, v : Double) -> NetsecwafBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_sec_waf_buffer_min(s : NetsecwafBuffer) -> Double { @_common.min(s.data) }

pub fn net_sec_waf_buffer_max(s : NetsecwafBuffer) -> Double { @_common.max(s.data) }

pub fn net_sec_waf_buffer_to_string(s : NetsecwafBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetsecwafCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_sec_waf_cursor_make(size : Int) -> NetsecwafCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_sec_waf_cursor_len(s : NetsecwafCursor) -> Int { s.size }

pub fn net_sec_waf_cursor_get(s : NetsecwafCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_sec_waf_cursor_set(s : NetsecwafCursor, i : Int, v : Double) -> NetsecwafCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn net_sec_waf_cursor_sum(s : NetsecwafCursor) -> Double { @_common.sum(s.data) }

pub fn net_sec_waf_cursor_mean(s : NetsecwafCursor) -> Double { @_common.mean(s.data) }

pub fn net_sec_waf_cursor_scale(s : NetsecwafCursor, f : Double) -> NetsecwafCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_sec_waf_cursor_add(a : NetsecwafCursor, b : NetsecwafCursor) -> NetsecwafCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_sec_waf_cursor_copy(s : NetsecwafCursor) -> NetsecwafCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_sec_waf_cursor_fill(s : NetsecwafCursor, v : Double) -> NetsecwafCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_sec_waf_cursor_min(s : NetsecwafCursor) -> Double { @_common.min(s.data) }

pub fn net_sec_waf_cursor_max(s : NetsecwafCursor) -> Double { @_common.max(s.data) }

pub fn net_sec_waf_cursor_to_string(s : NetsecwafCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetsecwafView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_sec_waf_view_make(size : Int) -> NetsecwafView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_sec_waf_view_len(s : NetsecwafView) -> Int { s.size }

pub fn net_sec_waf_view_get(s : NetsecwafView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_sec_waf_view_set(s : NetsecwafView, i : Int, v : Double) -> NetsecwafView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn net_sec_waf_view_sum(s : NetsecwafView) -> Double { @_common.sum(s.data) }

pub fn net_sec_waf_view_mean(s : NetsecwafView) -> Double { @_common.mean(s.data) }

pub fn net_sec_waf_view_scale(s : NetsecwafView, f : Double) -> NetsecwafView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_sec_waf_view_add(a : NetsecwafView, b : NetsecwafView) -> NetsecwafView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_sec_waf_view_copy(s : NetsecwafView) -> NetsecwafView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_sec_waf_view_fill(s : NetsecwafView, v : Double) -> NetsecwafView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_sec_waf_view_min(s : NetsecwafView) -> Double { @_common.min(s.data) }

pub fn net_sec_waf_view_max(s : NetsecwafView) -> Double { @_common.max(s.data) }

pub fn net_sec_waf_view_to_string(s : NetsecwafView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetsecwafRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_sec_waf_range_make(size : Int) -> NetsecwafRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_sec_waf_range_len(s : NetsecwafRange) -> Int { s.size }

pub fn net_sec_waf_range_get(s : NetsecwafRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_sec_waf_range_set(s : NetsecwafRange, i : Int, v : Double) -> NetsecwafRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn net_sec_waf_range_sum(s : NetsecwafRange) -> Double { @_common.sum(s.data) }

pub fn net_sec_waf_range_mean(s : NetsecwafRange) -> Double { @_common.mean(s.data) }

pub fn net_sec_waf_range_scale(s : NetsecwafRange, f : Double) -> NetsecwafRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_sec_waf_range_add(a : NetsecwafRange, b : NetsecwafRange) -> NetsecwafRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_sec_waf_range_copy(s : NetsecwafRange) -> NetsecwafRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_sec_waf_range_fill(s : NetsecwafRange, v : Double) -> NetsecwafRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_sec_waf_range_min(s : NetsecwafRange) -> Double { @_common.min(s.data) }

pub fn net_sec_waf_range_max(s : NetsecwafRange) -> Double { @_common.max(s.data) }

pub fn net_sec_waf_range_to_string(s : NetsecwafRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetsecwafSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_sec_waf_slice_make(size : Int) -> NetsecwafSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_sec_waf_slice_len(s : NetsecwafSlice) -> Int { s.size }

pub fn net_sec_waf_slice_get(s : NetsecwafSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_sec_waf_slice_set(s : NetsecwafSlice, i : Int, v : Double) -> NetsecwafSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn net_sec_waf_slice_sum(s : NetsecwafSlice) -> Double { @_common.sum(s.data) }

pub fn net_sec_waf_slice_mean(s : NetsecwafSlice) -> Double { @_common.mean(s.data) }

pub fn net_sec_waf_slice_scale(s : NetsecwafSlice, f : Double) -> NetsecwafSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_sec_waf_slice_add(a : NetsecwafSlice, b : NetsecwafSlice) -> NetsecwafSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_sec_waf_slice_copy(s : NetsecwafSlice) -> NetsecwafSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_sec_waf_slice_fill(s : NetsecwafSlice, v : Double) -> NetsecwafSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_sec_waf_slice_min(s : NetsecwafSlice) -> Double { @_common.min(s.data) }

pub fn net_sec_waf_slice_max(s : NetsecwafSlice) -> Double { @_common.max(s.data) }

pub fn net_sec_waf_slice_to_string(s : NetsecwafSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

