///===
/// extcore/net_route_policy

pub(all) struct NetroutepolicyPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn net_route_policy_make_point(x : Double, y : Double) -> NetroutepolicyPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn net_route_policy_make_point3(x : Double, y : Double, z : Double) -> NetroutepolicyPoint {
  { x, y, z, label: 0 }
}

pub fn NetroutepolicyPoint::x(self : NetroutepolicyPoint) -> Double { self.x }

pub fn NetroutepolicyPoint::y(self : NetroutepolicyPoint) -> Double { self.y }

pub fn NetroutepolicyPoint::z(self : NetroutepolicyPoint) -> Double { self.z }

pub fn NetroutepolicyPoint::label(self : NetroutepolicyPoint) -> Int { self.label }

pub fn NetroutepolicyPoint::dist(self : NetroutepolicyPoint, other : NetroutepolicyPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn NetroutepolicyPoint::add(self : NetroutepolicyPoint, other : NetroutepolicyPoint) -> NetroutepolicyPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn NetroutepolicyPoint::sub(self : NetroutepolicyPoint, other : NetroutepolicyPoint) -> NetroutepolicyPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn NetroutepolicyPoint::scale(self : NetroutepolicyPoint, s : Double) -> NetroutepolicyPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn NetroutepolicyPoint::dot(self : NetroutepolicyPoint, other : NetroutepolicyPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn NetroutepolicyPoint::cross(self : NetroutepolicyPoint, other : NetroutepolicyPoint) -> NetroutepolicyPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn NetroutepolicyPoint::norm(self : NetroutepolicyPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn NetroutepolicyPoint::normalize(self : NetroutepolicyPoint) -> NetroutepolicyPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn NetroutepolicyPoint::negate(self : NetroutepolicyPoint) -> NetroutepolicyPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn NetroutepolicyPoint::mid(self : NetroutepolicyPoint, other : NetroutepolicyPoint) -> NetroutepolicyPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn NetroutepolicyPoint::lerp(self : NetroutepolicyPoint, other : NetroutepolicyPoint, t : Double) -> NetroutepolicyPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn NetroutepolicyPoint::to_string(self : NetroutepolicyPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct NetroutepolicySeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn net_route_policy_make_series(vals : Array[Double], name : String) -> NetroutepolicySeries {
  { vals, name, meta: 0 }
}

pub fn NetroutepolicySeries::len(self : NetroutepolicySeries) -> Int { self.vals.length() }

pub fn NetroutepolicySeries::sum(self : NetroutepolicySeries) -> Double { @_common.sum(self.vals) }

pub fn NetroutepolicySeries::mean(self : NetroutepolicySeries) -> Double { @_common.mean(self.vals) }

pub fn NetroutepolicySeries::min(self : NetroutepolicySeries) -> Double { @_common.min(self.vals) }

pub fn NetroutepolicySeries::max(self : NetroutepolicySeries) -> Double { @_common.max(self.vals) }

pub fn NetroutepolicySeries::range(self : NetroutepolicySeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn NetroutepolicySeries::variance(self : NetroutepolicySeries) -> Double { @_common.variance(self.vals) }

pub fn NetroutepolicySeries::std(self : NetroutepolicySeries) -> Double { @_common.std(self.vals) }

pub fn NetroutepolicySeries::median(self : NetroutepolicySeries) -> Double { @_common.median(self.vals) }

pub fn NetroutepolicySeries::scale(self : NetroutepolicySeries, f : Double) -> NetroutepolicySeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn NetroutepolicySeries::add(self : NetroutepolicySeries, other : NetroutepolicySeries) -> NetroutepolicySeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn NetroutepolicySeries::sub(self : NetroutepolicySeries, other : NetroutepolicySeries) -> NetroutepolicySeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn NetroutepolicySeries::normalize(self : NetroutepolicySeries) -> NetroutepolicySeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn NetroutepolicySeries::cumsum(self : NetroutepolicySeries) -> NetroutepolicySeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn NetroutepolicySeries::to_string(self : NetroutepolicySeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct NetroutepolicyMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn net_route_policy_make_matrix(rows : Int, cols : Int, val : Double) -> NetroutepolicyMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn net_route_policy_matrix_identity(n : Int) -> NetroutepolicyMatrix {
  let m = net_route_policy_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn NetroutepolicyMatrix::get(self : NetroutepolicyMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn NetroutepolicyMatrix::transpose(self : NetroutepolicyMatrix) -> NetroutepolicyMatrix {
  let result = net_route_policy_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn NetroutepolicyMatrix::add(self : NetroutepolicyMatrix, other : NetroutepolicyMatrix) -> NetroutepolicyMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = net_route_policy_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn NetroutepolicyMatrix::scale(self : NetroutepolicyMatrix, s : Double) -> NetroutepolicyMatrix {
  let result = net_route_policy_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn NetroutepolicyMatrix::multiply(self : NetroutepolicyMatrix, other : NetroutepolicyMatrix) -> NetroutepolicyMatrix {
  if self.cols != other.rows { return net_route_policy_make_matrix(self.rows, other.cols, 0.0) }
  let result = net_route_policy_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn NetroutepolicyMatrix::trace(self : NetroutepolicyMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn NetroutepolicyMatrix::det(self : NetroutepolicyMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn NetroutepolicyMatrix::norm(self : NetroutepolicyMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn NetroutepolicyMatrix::to_string(self : NetroutepolicyMatrix) -> String {
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

pub(all) struct NetroutepolicyVector {
  comps : Array[Double]
  dim : Int
}

pub fn net_route_policy_make_vector(comps : Array[Double]) -> NetroutepolicyVector {
  { comps, dim: comps.length() }
}

pub fn net_route_policy_vector_zero(dim : Int) -> NetroutepolicyVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn NetroutepolicyVector::add(self : NetroutepolicyVector, other : NetroutepolicyVector) -> NetroutepolicyVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn NetroutepolicyVector::sub(self : NetroutepolicyVector, other : NetroutepolicyVector) -> NetroutepolicyVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn NetroutepolicyVector::scale(self : NetroutepolicyVector, s : Double) -> NetroutepolicyVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn NetroutepolicyVector::dot(self : NetroutepolicyVector, other : NetroutepolicyVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn NetroutepolicyVector::norm(self : NetroutepolicyVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn NetroutepolicyVector::normalize(self : NetroutepolicyVector) -> NetroutepolicyVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn NetroutepolicyVector::dist(self : NetroutepolicyVector, other : NetroutepolicyVector) -> Double {
  self.sub(other).norm()
}

pub fn NetroutepolicyVector::to_string(self : NetroutepolicyVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn net_route_policy_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn net_route_policy_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn net_route_policy_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn net_route_policy_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn net_route_policy_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn net_route_policy_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn net_route_policy_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn net_route_policy_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn net_route_policy_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn net_route_policy_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn net_route_policy_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn net_route_policy_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn net_route_policy_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn net_route_policy_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn net_route_policy_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn net_route_policy_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn net_route_policy_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn net_route_policy_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn net_route_policy_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn net_route_policy_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn net_route_policy_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn net_route_policy_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn net_route_policy_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn net_route_policy_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn net_route_policy_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn net_route_policy_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn net_route_policy_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn net_route_policy_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn net_route_policy_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct NetroutepolicyFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_route_policy_frame_make(size : Int) -> NetroutepolicyFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_route_policy_frame_len(s : NetroutepolicyFrame) -> Int { s.size }

pub fn net_route_policy_frame_get(s : NetroutepolicyFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_route_policy_frame_set(s : NetroutepolicyFrame, i : Int, v : Double) -> NetroutepolicyFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn net_route_policy_frame_sum(s : NetroutepolicyFrame) -> Double { @_common.sum(s.data) }

pub fn net_route_policy_frame_mean(s : NetroutepolicyFrame) -> Double { @_common.mean(s.data) }

pub fn net_route_policy_frame_scale(s : NetroutepolicyFrame, f : Double) -> NetroutepolicyFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_route_policy_frame_add(a : NetroutepolicyFrame, b : NetroutepolicyFrame) -> NetroutepolicyFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_route_policy_frame_copy(s : NetroutepolicyFrame) -> NetroutepolicyFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_route_policy_frame_fill(s : NetroutepolicyFrame, v : Double) -> NetroutepolicyFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_route_policy_frame_min(s : NetroutepolicyFrame) -> Double { @_common.min(s.data) }

pub fn net_route_policy_frame_max(s : NetroutepolicyFrame) -> Double { @_common.max(s.data) }

pub fn net_route_policy_frame_to_string(s : NetroutepolicyFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetroutepolicyTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_route_policy_table_make(size : Int) -> NetroutepolicyTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_route_policy_table_len(s : NetroutepolicyTable) -> Int { s.size }

pub fn net_route_policy_table_get(s : NetroutepolicyTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_route_policy_table_set(s : NetroutepolicyTable, i : Int, v : Double) -> NetroutepolicyTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn net_route_policy_table_sum(s : NetroutepolicyTable) -> Double { @_common.sum(s.data) }

pub fn net_route_policy_table_mean(s : NetroutepolicyTable) -> Double { @_common.mean(s.data) }

pub fn net_route_policy_table_scale(s : NetroutepolicyTable, f : Double) -> NetroutepolicyTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_route_policy_table_add(a : NetroutepolicyTable, b : NetroutepolicyTable) -> NetroutepolicyTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_route_policy_table_copy(s : NetroutepolicyTable) -> NetroutepolicyTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_route_policy_table_fill(s : NetroutepolicyTable, v : Double) -> NetroutepolicyTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_route_policy_table_min(s : NetroutepolicyTable) -> Double { @_common.min(s.data) }

pub fn net_route_policy_table_max(s : NetroutepolicyTable) -> Double { @_common.max(s.data) }

pub fn net_route_policy_table_to_string(s : NetroutepolicyTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetroutepolicyGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_route_policy_graphn_make(size : Int) -> NetroutepolicyGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_route_policy_graphn_len(s : NetroutepolicyGraphN) -> Int { s.size }

pub fn net_route_policy_graphn_get(s : NetroutepolicyGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_route_policy_graphn_set(s : NetroutepolicyGraphN, i : Int, v : Double) -> NetroutepolicyGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn net_route_policy_graphn_sum(s : NetroutepolicyGraphN) -> Double { @_common.sum(s.data) }

pub fn net_route_policy_graphn_mean(s : NetroutepolicyGraphN) -> Double { @_common.mean(s.data) }

pub fn net_route_policy_graphn_scale(s : NetroutepolicyGraphN, f : Double) -> NetroutepolicyGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_route_policy_graphn_add(a : NetroutepolicyGraphN, b : NetroutepolicyGraphN) -> NetroutepolicyGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_route_policy_graphn_copy(s : NetroutepolicyGraphN) -> NetroutepolicyGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_route_policy_graphn_fill(s : NetroutepolicyGraphN, v : Double) -> NetroutepolicyGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_route_policy_graphn_min(s : NetroutepolicyGraphN) -> Double { @_common.min(s.data) }

pub fn net_route_policy_graphn_max(s : NetroutepolicyGraphN) -> Double { @_common.max(s.data) }

pub fn net_route_policy_graphn_to_string(s : NetroutepolicyGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetroutepolicyNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_route_policy_node_make(size : Int) -> NetroutepolicyNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_route_policy_node_len(s : NetroutepolicyNode) -> Int { s.size }

pub fn net_route_policy_node_get(s : NetroutepolicyNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_route_policy_node_set(s : NetroutepolicyNode, i : Int, v : Double) -> NetroutepolicyNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn net_route_policy_node_sum(s : NetroutepolicyNode) -> Double { @_common.sum(s.data) }

pub fn net_route_policy_node_mean(s : NetroutepolicyNode) -> Double { @_common.mean(s.data) }

pub fn net_route_policy_node_scale(s : NetroutepolicyNode, f : Double) -> NetroutepolicyNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_route_policy_node_add(a : NetroutepolicyNode, b : NetroutepolicyNode) -> NetroutepolicyNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_route_policy_node_copy(s : NetroutepolicyNode) -> NetroutepolicyNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_route_policy_node_fill(s : NetroutepolicyNode, v : Double) -> NetroutepolicyNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_route_policy_node_min(s : NetroutepolicyNode) -> Double { @_common.min(s.data) }

pub fn net_route_policy_node_max(s : NetroutepolicyNode) -> Double { @_common.max(s.data) }

pub fn net_route_policy_node_to_string(s : NetroutepolicyNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetroutepolicyEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_route_policy_edge_make(size : Int) -> NetroutepolicyEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_route_policy_edge_len(s : NetroutepolicyEdge) -> Int { s.size }

pub fn net_route_policy_edge_get(s : NetroutepolicyEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_route_policy_edge_set(s : NetroutepolicyEdge, i : Int, v : Double) -> NetroutepolicyEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn net_route_policy_edge_sum(s : NetroutepolicyEdge) -> Double { @_common.sum(s.data) }

pub fn net_route_policy_edge_mean(s : NetroutepolicyEdge) -> Double { @_common.mean(s.data) }

pub fn net_route_policy_edge_scale(s : NetroutepolicyEdge, f : Double) -> NetroutepolicyEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_route_policy_edge_add(a : NetroutepolicyEdge, b : NetroutepolicyEdge) -> NetroutepolicyEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_route_policy_edge_copy(s : NetroutepolicyEdge) -> NetroutepolicyEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_route_policy_edge_fill(s : NetroutepolicyEdge, v : Double) -> NetroutepolicyEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_route_policy_edge_min(s : NetroutepolicyEdge) -> Double { @_common.min(s.data) }

pub fn net_route_policy_edge_max(s : NetroutepolicyEdge) -> Double { @_common.max(s.data) }

pub fn net_route_policy_edge_to_string(s : NetroutepolicyEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetroutepolicyPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_route_policy_path_make(size : Int) -> NetroutepolicyPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_route_policy_path_len(s : NetroutepolicyPath) -> Int { s.size }

pub fn net_route_policy_path_get(s : NetroutepolicyPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_route_policy_path_set(s : NetroutepolicyPath, i : Int, v : Double) -> NetroutepolicyPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn net_route_policy_path_sum(s : NetroutepolicyPath) -> Double { @_common.sum(s.data) }

pub fn net_route_policy_path_mean(s : NetroutepolicyPath) -> Double { @_common.mean(s.data) }

pub fn net_route_policy_path_scale(s : NetroutepolicyPath, f : Double) -> NetroutepolicyPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_route_policy_path_add(a : NetroutepolicyPath, b : NetroutepolicyPath) -> NetroutepolicyPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_route_policy_path_copy(s : NetroutepolicyPath) -> NetroutepolicyPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_route_policy_path_fill(s : NetroutepolicyPath, v : Double) -> NetroutepolicyPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_route_policy_path_min(s : NetroutepolicyPath) -> Double { @_common.min(s.data) }

pub fn net_route_policy_path_max(s : NetroutepolicyPath) -> Double { @_common.max(s.data) }

pub fn net_route_policy_path_to_string(s : NetroutepolicyPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetroutepolicyCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_route_policy_cluster_make(size : Int) -> NetroutepolicyCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_route_policy_cluster_len(s : NetroutepolicyCluster) -> Int { s.size }

pub fn net_route_policy_cluster_get(s : NetroutepolicyCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_route_policy_cluster_set(s : NetroutepolicyCluster, i : Int, v : Double) -> NetroutepolicyCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn net_route_policy_cluster_sum(s : NetroutepolicyCluster) -> Double { @_common.sum(s.data) }

pub fn net_route_policy_cluster_mean(s : NetroutepolicyCluster) -> Double { @_common.mean(s.data) }

pub fn net_route_policy_cluster_scale(s : NetroutepolicyCluster, f : Double) -> NetroutepolicyCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_route_policy_cluster_add(a : NetroutepolicyCluster, b : NetroutepolicyCluster) -> NetroutepolicyCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_route_policy_cluster_copy(s : NetroutepolicyCluster) -> NetroutepolicyCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_route_policy_cluster_fill(s : NetroutepolicyCluster, v : Double) -> NetroutepolicyCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_route_policy_cluster_min(s : NetroutepolicyCluster) -> Double { @_common.min(s.data) }

pub fn net_route_policy_cluster_max(s : NetroutepolicyCluster) -> Double { @_common.max(s.data) }

pub fn net_route_policy_cluster_to_string(s : NetroutepolicyCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetroutepolicyModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_route_policy_model_make(size : Int) -> NetroutepolicyModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_route_policy_model_len(s : NetroutepolicyModel) -> Int { s.size }

pub fn net_route_policy_model_get(s : NetroutepolicyModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_route_policy_model_set(s : NetroutepolicyModel, i : Int, v : Double) -> NetroutepolicyModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn net_route_policy_model_sum(s : NetroutepolicyModel) -> Double { @_common.sum(s.data) }

pub fn net_route_policy_model_mean(s : NetroutepolicyModel) -> Double { @_common.mean(s.data) }

pub fn net_route_policy_model_scale(s : NetroutepolicyModel, f : Double) -> NetroutepolicyModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_route_policy_model_add(a : NetroutepolicyModel, b : NetroutepolicyModel) -> NetroutepolicyModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_route_policy_model_copy(s : NetroutepolicyModel) -> NetroutepolicyModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_route_policy_model_fill(s : NetroutepolicyModel, v : Double) -> NetroutepolicyModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_route_policy_model_min(s : NetroutepolicyModel) -> Double { @_common.min(s.data) }

pub fn net_route_policy_model_max(s : NetroutepolicyModel) -> Double { @_common.max(s.data) }

pub fn net_route_policy_model_to_string(s : NetroutepolicyModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetroutepolicyLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_route_policy_layer_make(size : Int) -> NetroutepolicyLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_route_policy_layer_len(s : NetroutepolicyLayer) -> Int { s.size }

pub fn net_route_policy_layer_get(s : NetroutepolicyLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_route_policy_layer_set(s : NetroutepolicyLayer, i : Int, v : Double) -> NetroutepolicyLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn net_route_policy_layer_sum(s : NetroutepolicyLayer) -> Double { @_common.sum(s.data) }

pub fn net_route_policy_layer_mean(s : NetroutepolicyLayer) -> Double { @_common.mean(s.data) }

pub fn net_route_policy_layer_scale(s : NetroutepolicyLayer, f : Double) -> NetroutepolicyLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_route_policy_layer_add(a : NetroutepolicyLayer, b : NetroutepolicyLayer) -> NetroutepolicyLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_route_policy_layer_copy(s : NetroutepolicyLayer) -> NetroutepolicyLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_route_policy_layer_fill(s : NetroutepolicyLayer, v : Double) -> NetroutepolicyLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_route_policy_layer_min(s : NetroutepolicyLayer) -> Double { @_common.min(s.data) }

pub fn net_route_policy_layer_max(s : NetroutepolicyLayer) -> Double { @_common.max(s.data) }

pub fn net_route_policy_layer_to_string(s : NetroutepolicyLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetroutepolicyBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_route_policy_buffer_make(size : Int) -> NetroutepolicyBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_route_policy_buffer_len(s : NetroutepolicyBuffer) -> Int { s.size }

pub fn net_route_policy_buffer_get(s : NetroutepolicyBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_route_policy_buffer_set(s : NetroutepolicyBuffer, i : Int, v : Double) -> NetroutepolicyBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn net_route_policy_buffer_sum(s : NetroutepolicyBuffer) -> Double { @_common.sum(s.data) }

pub fn net_route_policy_buffer_mean(s : NetroutepolicyBuffer) -> Double { @_common.mean(s.data) }

pub fn net_route_policy_buffer_scale(s : NetroutepolicyBuffer, f : Double) -> NetroutepolicyBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_route_policy_buffer_add(a : NetroutepolicyBuffer, b : NetroutepolicyBuffer) -> NetroutepolicyBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_route_policy_buffer_copy(s : NetroutepolicyBuffer) -> NetroutepolicyBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_route_policy_buffer_fill(s : NetroutepolicyBuffer, v : Double) -> NetroutepolicyBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_route_policy_buffer_min(s : NetroutepolicyBuffer) -> Double { @_common.min(s.data) }

pub fn net_route_policy_buffer_max(s : NetroutepolicyBuffer) -> Double { @_common.max(s.data) }

pub fn net_route_policy_buffer_to_string(s : NetroutepolicyBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetroutepolicyCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_route_policy_cursor_make(size : Int) -> NetroutepolicyCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_route_policy_cursor_len(s : NetroutepolicyCursor) -> Int { s.size }

pub fn net_route_policy_cursor_get(s : NetroutepolicyCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_route_policy_cursor_set(s : NetroutepolicyCursor, i : Int, v : Double) -> NetroutepolicyCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn net_route_policy_cursor_sum(s : NetroutepolicyCursor) -> Double { @_common.sum(s.data) }

pub fn net_route_policy_cursor_mean(s : NetroutepolicyCursor) -> Double { @_common.mean(s.data) }

pub fn net_route_policy_cursor_scale(s : NetroutepolicyCursor, f : Double) -> NetroutepolicyCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_route_policy_cursor_add(a : NetroutepolicyCursor, b : NetroutepolicyCursor) -> NetroutepolicyCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_route_policy_cursor_copy(s : NetroutepolicyCursor) -> NetroutepolicyCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_route_policy_cursor_fill(s : NetroutepolicyCursor, v : Double) -> NetroutepolicyCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_route_policy_cursor_min(s : NetroutepolicyCursor) -> Double { @_common.min(s.data) }

pub fn net_route_policy_cursor_max(s : NetroutepolicyCursor) -> Double { @_common.max(s.data) }

pub fn net_route_policy_cursor_to_string(s : NetroutepolicyCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetroutepolicyView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_route_policy_view_make(size : Int) -> NetroutepolicyView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_route_policy_view_len(s : NetroutepolicyView) -> Int { s.size }

pub fn net_route_policy_view_get(s : NetroutepolicyView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_route_policy_view_set(s : NetroutepolicyView, i : Int, v : Double) -> NetroutepolicyView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn net_route_policy_view_sum(s : NetroutepolicyView) -> Double { @_common.sum(s.data) }

pub fn net_route_policy_view_mean(s : NetroutepolicyView) -> Double { @_common.mean(s.data) }

pub fn net_route_policy_view_scale(s : NetroutepolicyView, f : Double) -> NetroutepolicyView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_route_policy_view_add(a : NetroutepolicyView, b : NetroutepolicyView) -> NetroutepolicyView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_route_policy_view_copy(s : NetroutepolicyView) -> NetroutepolicyView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_route_policy_view_fill(s : NetroutepolicyView, v : Double) -> NetroutepolicyView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_route_policy_view_min(s : NetroutepolicyView) -> Double { @_common.min(s.data) }

pub fn net_route_policy_view_max(s : NetroutepolicyView) -> Double { @_common.max(s.data) }

pub fn net_route_policy_view_to_string(s : NetroutepolicyView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetroutepolicyRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_route_policy_range_make(size : Int) -> NetroutepolicyRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_route_policy_range_len(s : NetroutepolicyRange) -> Int { s.size }

pub fn net_route_policy_range_get(s : NetroutepolicyRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_route_policy_range_set(s : NetroutepolicyRange, i : Int, v : Double) -> NetroutepolicyRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn net_route_policy_range_sum(s : NetroutepolicyRange) -> Double { @_common.sum(s.data) }

pub fn net_route_policy_range_mean(s : NetroutepolicyRange) -> Double { @_common.mean(s.data) }

pub fn net_route_policy_range_scale(s : NetroutepolicyRange, f : Double) -> NetroutepolicyRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_route_policy_range_add(a : NetroutepolicyRange, b : NetroutepolicyRange) -> NetroutepolicyRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_route_policy_range_copy(s : NetroutepolicyRange) -> NetroutepolicyRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_route_policy_range_fill(s : NetroutepolicyRange, v : Double) -> NetroutepolicyRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_route_policy_range_min(s : NetroutepolicyRange) -> Double { @_common.min(s.data) }

pub fn net_route_policy_range_max(s : NetroutepolicyRange) -> Double { @_common.max(s.data) }

pub fn net_route_policy_range_to_string(s : NetroutepolicyRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetroutepolicySlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_route_policy_slice_make(size : Int) -> NetroutepolicySlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_route_policy_slice_len(s : NetroutepolicySlice) -> Int { s.size }

pub fn net_route_policy_slice_get(s : NetroutepolicySlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_route_policy_slice_set(s : NetroutepolicySlice, i : Int, v : Double) -> NetroutepolicySlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn net_route_policy_slice_sum(s : NetroutepolicySlice) -> Double { @_common.sum(s.data) }

pub fn net_route_policy_slice_mean(s : NetroutepolicySlice) -> Double { @_common.mean(s.data) }

pub fn net_route_policy_slice_scale(s : NetroutepolicySlice, f : Double) -> NetroutepolicySlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_route_policy_slice_add(a : NetroutepolicySlice, b : NetroutepolicySlice) -> NetroutepolicySlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_route_policy_slice_copy(s : NetroutepolicySlice) -> NetroutepolicySlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_route_policy_slice_fill(s : NetroutepolicySlice, v : Double) -> NetroutepolicySlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_route_policy_slice_min(s : NetroutepolicySlice) -> Double { @_common.min(s.data) }

pub fn net_route_policy_slice_max(s : NetroutepolicySlice) -> Double { @_common.max(s.data) }

pub fn net_route_policy_slice_to_string(s : NetroutepolicySlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

