///===
/// extcore/net_sec_auth

pub(all) struct NetsecauthPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn net_sec_auth_make_point(x : Double, y : Double) -> NetsecauthPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn net_sec_auth_make_point3(x : Double, y : Double, z : Double) -> NetsecauthPoint {
  { x, y, z, label: 0 }
}

pub fn NetsecauthPoint::x(self : NetsecauthPoint) -> Double { self.x }

pub fn NetsecauthPoint::y(self : NetsecauthPoint) -> Double { self.y }

pub fn NetsecauthPoint::z(self : NetsecauthPoint) -> Double { self.z }

pub fn NetsecauthPoint::label(self : NetsecauthPoint) -> Int { self.label }

pub fn NetsecauthPoint::dist(self : NetsecauthPoint, other : NetsecauthPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn NetsecauthPoint::add(self : NetsecauthPoint, other : NetsecauthPoint) -> NetsecauthPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn NetsecauthPoint::sub(self : NetsecauthPoint, other : NetsecauthPoint) -> NetsecauthPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn NetsecauthPoint::scale(self : NetsecauthPoint, s : Double) -> NetsecauthPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn NetsecauthPoint::dot(self : NetsecauthPoint, other : NetsecauthPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn NetsecauthPoint::cross(self : NetsecauthPoint, other : NetsecauthPoint) -> NetsecauthPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn NetsecauthPoint::norm(self : NetsecauthPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn NetsecauthPoint::normalize(self : NetsecauthPoint) -> NetsecauthPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn NetsecauthPoint::negate(self : NetsecauthPoint) -> NetsecauthPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn NetsecauthPoint::mid(self : NetsecauthPoint, other : NetsecauthPoint) -> NetsecauthPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn NetsecauthPoint::lerp(self : NetsecauthPoint, other : NetsecauthPoint, t : Double) -> NetsecauthPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn NetsecauthPoint::to_string(self : NetsecauthPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct NetsecauthSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn net_sec_auth_make_series(vals : Array[Double], name : String) -> NetsecauthSeries {
  { vals, name, meta: 0 }
}

pub fn NetsecauthSeries::len(self : NetsecauthSeries) -> Int { self.vals.length() }

pub fn NetsecauthSeries::sum(self : NetsecauthSeries) -> Double { @_common.sum(self.vals) }

pub fn NetsecauthSeries::mean(self : NetsecauthSeries) -> Double { @_common.mean(self.vals) }

pub fn NetsecauthSeries::min(self : NetsecauthSeries) -> Double { @_common.min(self.vals) }

pub fn NetsecauthSeries::max(self : NetsecauthSeries) -> Double { @_common.max(self.vals) }

pub fn NetsecauthSeries::range(self : NetsecauthSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn NetsecauthSeries::variance(self : NetsecauthSeries) -> Double { @_common.variance(self.vals) }

pub fn NetsecauthSeries::std(self : NetsecauthSeries) -> Double { @_common.std(self.vals) }

pub fn NetsecauthSeries::median(self : NetsecauthSeries) -> Double { @_common.median(self.vals) }

pub fn NetsecauthSeries::scale(self : NetsecauthSeries, f : Double) -> NetsecauthSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn NetsecauthSeries::add(self : NetsecauthSeries, other : NetsecauthSeries) -> NetsecauthSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn NetsecauthSeries::sub(self : NetsecauthSeries, other : NetsecauthSeries) -> NetsecauthSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn NetsecauthSeries::normalize(self : NetsecauthSeries) -> NetsecauthSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn NetsecauthSeries::cumsum(self : NetsecauthSeries) -> NetsecauthSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn NetsecauthSeries::to_string(self : NetsecauthSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct NetsecauthMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn net_sec_auth_make_matrix(rows : Int, cols : Int, val : Double) -> NetsecauthMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn net_sec_auth_matrix_identity(n : Int) -> NetsecauthMatrix {
  let m = net_sec_auth_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn NetsecauthMatrix::get(self : NetsecauthMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn NetsecauthMatrix::transpose(self : NetsecauthMatrix) -> NetsecauthMatrix {
  let result = net_sec_auth_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn NetsecauthMatrix::add(self : NetsecauthMatrix, other : NetsecauthMatrix) -> NetsecauthMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = net_sec_auth_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn NetsecauthMatrix::scale(self : NetsecauthMatrix, s : Double) -> NetsecauthMatrix {
  let result = net_sec_auth_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn NetsecauthMatrix::multiply(self : NetsecauthMatrix, other : NetsecauthMatrix) -> NetsecauthMatrix {
  if self.cols != other.rows { return net_sec_auth_make_matrix(self.rows, other.cols, 0.0) }
  let result = net_sec_auth_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn NetsecauthMatrix::trace(self : NetsecauthMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn NetsecauthMatrix::det(self : NetsecauthMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn NetsecauthMatrix::norm(self : NetsecauthMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn NetsecauthMatrix::to_string(self : NetsecauthMatrix) -> String {
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

pub(all) struct NetsecauthVector {
  comps : Array[Double]
  dim : Int
}

pub fn net_sec_auth_make_vector(comps : Array[Double]) -> NetsecauthVector {
  { comps, dim: comps.length() }
}

pub fn net_sec_auth_vector_zero(dim : Int) -> NetsecauthVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn NetsecauthVector::add(self : NetsecauthVector, other : NetsecauthVector) -> NetsecauthVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn NetsecauthVector::sub(self : NetsecauthVector, other : NetsecauthVector) -> NetsecauthVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn NetsecauthVector::scale(self : NetsecauthVector, s : Double) -> NetsecauthVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn NetsecauthVector::dot(self : NetsecauthVector, other : NetsecauthVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn NetsecauthVector::norm(self : NetsecauthVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn NetsecauthVector::normalize(self : NetsecauthVector) -> NetsecauthVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn NetsecauthVector::dist(self : NetsecauthVector, other : NetsecauthVector) -> Double {
  self.sub(other).norm()
}

pub fn NetsecauthVector::to_string(self : NetsecauthVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn net_sec_auth_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn net_sec_auth_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn net_sec_auth_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn net_sec_auth_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn net_sec_auth_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn net_sec_auth_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn net_sec_auth_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn net_sec_auth_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn net_sec_auth_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn net_sec_auth_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn net_sec_auth_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn net_sec_auth_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn net_sec_auth_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn net_sec_auth_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn net_sec_auth_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn net_sec_auth_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn net_sec_auth_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn net_sec_auth_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn net_sec_auth_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn net_sec_auth_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn net_sec_auth_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn net_sec_auth_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn net_sec_auth_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn net_sec_auth_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn net_sec_auth_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn net_sec_auth_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn net_sec_auth_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn net_sec_auth_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn net_sec_auth_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct NetsecauthFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_sec_auth_frame_make(size : Int) -> NetsecauthFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_sec_auth_frame_len(s : NetsecauthFrame) -> Int { s.size }

pub fn net_sec_auth_frame_get(s : NetsecauthFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_sec_auth_frame_set(s : NetsecauthFrame, i : Int, v : Double) -> NetsecauthFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn net_sec_auth_frame_sum(s : NetsecauthFrame) -> Double { @_common.sum(s.data) }

pub fn net_sec_auth_frame_mean(s : NetsecauthFrame) -> Double { @_common.mean(s.data) }

pub fn net_sec_auth_frame_scale(s : NetsecauthFrame, f : Double) -> NetsecauthFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_sec_auth_frame_add(a : NetsecauthFrame, b : NetsecauthFrame) -> NetsecauthFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_sec_auth_frame_copy(s : NetsecauthFrame) -> NetsecauthFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_sec_auth_frame_fill(s : NetsecauthFrame, v : Double) -> NetsecauthFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_sec_auth_frame_min(s : NetsecauthFrame) -> Double { @_common.min(s.data) }

pub fn net_sec_auth_frame_max(s : NetsecauthFrame) -> Double { @_common.max(s.data) }

pub fn net_sec_auth_frame_to_string(s : NetsecauthFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetsecauthTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_sec_auth_table_make(size : Int) -> NetsecauthTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_sec_auth_table_len(s : NetsecauthTable) -> Int { s.size }

pub fn net_sec_auth_table_get(s : NetsecauthTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_sec_auth_table_set(s : NetsecauthTable, i : Int, v : Double) -> NetsecauthTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn net_sec_auth_table_sum(s : NetsecauthTable) -> Double { @_common.sum(s.data) }

pub fn net_sec_auth_table_mean(s : NetsecauthTable) -> Double { @_common.mean(s.data) }

pub fn net_sec_auth_table_scale(s : NetsecauthTable, f : Double) -> NetsecauthTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_sec_auth_table_add(a : NetsecauthTable, b : NetsecauthTable) -> NetsecauthTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_sec_auth_table_copy(s : NetsecauthTable) -> NetsecauthTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_sec_auth_table_fill(s : NetsecauthTable, v : Double) -> NetsecauthTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_sec_auth_table_min(s : NetsecauthTable) -> Double { @_common.min(s.data) }

pub fn net_sec_auth_table_max(s : NetsecauthTable) -> Double { @_common.max(s.data) }

pub fn net_sec_auth_table_to_string(s : NetsecauthTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetsecauthGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_sec_auth_graphn_make(size : Int) -> NetsecauthGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_sec_auth_graphn_len(s : NetsecauthGraphN) -> Int { s.size }

pub fn net_sec_auth_graphn_get(s : NetsecauthGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_sec_auth_graphn_set(s : NetsecauthGraphN, i : Int, v : Double) -> NetsecauthGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn net_sec_auth_graphn_sum(s : NetsecauthGraphN) -> Double { @_common.sum(s.data) }

pub fn net_sec_auth_graphn_mean(s : NetsecauthGraphN) -> Double { @_common.mean(s.data) }

pub fn net_sec_auth_graphn_scale(s : NetsecauthGraphN, f : Double) -> NetsecauthGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_sec_auth_graphn_add(a : NetsecauthGraphN, b : NetsecauthGraphN) -> NetsecauthGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_sec_auth_graphn_copy(s : NetsecauthGraphN) -> NetsecauthGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_sec_auth_graphn_fill(s : NetsecauthGraphN, v : Double) -> NetsecauthGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_sec_auth_graphn_min(s : NetsecauthGraphN) -> Double { @_common.min(s.data) }

pub fn net_sec_auth_graphn_max(s : NetsecauthGraphN) -> Double { @_common.max(s.data) }

pub fn net_sec_auth_graphn_to_string(s : NetsecauthGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetsecauthNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_sec_auth_node_make(size : Int) -> NetsecauthNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_sec_auth_node_len(s : NetsecauthNode) -> Int { s.size }

pub fn net_sec_auth_node_get(s : NetsecauthNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_sec_auth_node_set(s : NetsecauthNode, i : Int, v : Double) -> NetsecauthNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn net_sec_auth_node_sum(s : NetsecauthNode) -> Double { @_common.sum(s.data) }

pub fn net_sec_auth_node_mean(s : NetsecauthNode) -> Double { @_common.mean(s.data) }

pub fn net_sec_auth_node_scale(s : NetsecauthNode, f : Double) -> NetsecauthNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_sec_auth_node_add(a : NetsecauthNode, b : NetsecauthNode) -> NetsecauthNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_sec_auth_node_copy(s : NetsecauthNode) -> NetsecauthNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_sec_auth_node_fill(s : NetsecauthNode, v : Double) -> NetsecauthNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_sec_auth_node_min(s : NetsecauthNode) -> Double { @_common.min(s.data) }

pub fn net_sec_auth_node_max(s : NetsecauthNode) -> Double { @_common.max(s.data) }

pub fn net_sec_auth_node_to_string(s : NetsecauthNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetsecauthEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_sec_auth_edge_make(size : Int) -> NetsecauthEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_sec_auth_edge_len(s : NetsecauthEdge) -> Int { s.size }

pub fn net_sec_auth_edge_get(s : NetsecauthEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_sec_auth_edge_set(s : NetsecauthEdge, i : Int, v : Double) -> NetsecauthEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn net_sec_auth_edge_sum(s : NetsecauthEdge) -> Double { @_common.sum(s.data) }

pub fn net_sec_auth_edge_mean(s : NetsecauthEdge) -> Double { @_common.mean(s.data) }

pub fn net_sec_auth_edge_scale(s : NetsecauthEdge, f : Double) -> NetsecauthEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_sec_auth_edge_add(a : NetsecauthEdge, b : NetsecauthEdge) -> NetsecauthEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_sec_auth_edge_copy(s : NetsecauthEdge) -> NetsecauthEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_sec_auth_edge_fill(s : NetsecauthEdge, v : Double) -> NetsecauthEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_sec_auth_edge_min(s : NetsecauthEdge) -> Double { @_common.min(s.data) }

pub fn net_sec_auth_edge_max(s : NetsecauthEdge) -> Double { @_common.max(s.data) }

pub fn net_sec_auth_edge_to_string(s : NetsecauthEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetsecauthPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_sec_auth_path_make(size : Int) -> NetsecauthPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_sec_auth_path_len(s : NetsecauthPath) -> Int { s.size }

pub fn net_sec_auth_path_get(s : NetsecauthPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_sec_auth_path_set(s : NetsecauthPath, i : Int, v : Double) -> NetsecauthPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn net_sec_auth_path_sum(s : NetsecauthPath) -> Double { @_common.sum(s.data) }

pub fn net_sec_auth_path_mean(s : NetsecauthPath) -> Double { @_common.mean(s.data) }

pub fn net_sec_auth_path_scale(s : NetsecauthPath, f : Double) -> NetsecauthPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_sec_auth_path_add(a : NetsecauthPath, b : NetsecauthPath) -> NetsecauthPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_sec_auth_path_copy(s : NetsecauthPath) -> NetsecauthPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_sec_auth_path_fill(s : NetsecauthPath, v : Double) -> NetsecauthPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_sec_auth_path_min(s : NetsecauthPath) -> Double { @_common.min(s.data) }

pub fn net_sec_auth_path_max(s : NetsecauthPath) -> Double { @_common.max(s.data) }

pub fn net_sec_auth_path_to_string(s : NetsecauthPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetsecauthCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_sec_auth_cluster_make(size : Int) -> NetsecauthCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_sec_auth_cluster_len(s : NetsecauthCluster) -> Int { s.size }

pub fn net_sec_auth_cluster_get(s : NetsecauthCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_sec_auth_cluster_set(s : NetsecauthCluster, i : Int, v : Double) -> NetsecauthCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn net_sec_auth_cluster_sum(s : NetsecauthCluster) -> Double { @_common.sum(s.data) }

pub fn net_sec_auth_cluster_mean(s : NetsecauthCluster) -> Double { @_common.mean(s.data) }

pub fn net_sec_auth_cluster_scale(s : NetsecauthCluster, f : Double) -> NetsecauthCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_sec_auth_cluster_add(a : NetsecauthCluster, b : NetsecauthCluster) -> NetsecauthCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_sec_auth_cluster_copy(s : NetsecauthCluster) -> NetsecauthCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_sec_auth_cluster_fill(s : NetsecauthCluster, v : Double) -> NetsecauthCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_sec_auth_cluster_min(s : NetsecauthCluster) -> Double { @_common.min(s.data) }

pub fn net_sec_auth_cluster_max(s : NetsecauthCluster) -> Double { @_common.max(s.data) }

pub fn net_sec_auth_cluster_to_string(s : NetsecauthCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetsecauthModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_sec_auth_model_make(size : Int) -> NetsecauthModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_sec_auth_model_len(s : NetsecauthModel) -> Int { s.size }

pub fn net_sec_auth_model_get(s : NetsecauthModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_sec_auth_model_set(s : NetsecauthModel, i : Int, v : Double) -> NetsecauthModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn net_sec_auth_model_sum(s : NetsecauthModel) -> Double { @_common.sum(s.data) }

pub fn net_sec_auth_model_mean(s : NetsecauthModel) -> Double { @_common.mean(s.data) }

pub fn net_sec_auth_model_scale(s : NetsecauthModel, f : Double) -> NetsecauthModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_sec_auth_model_add(a : NetsecauthModel, b : NetsecauthModel) -> NetsecauthModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_sec_auth_model_copy(s : NetsecauthModel) -> NetsecauthModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_sec_auth_model_fill(s : NetsecauthModel, v : Double) -> NetsecauthModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_sec_auth_model_min(s : NetsecauthModel) -> Double { @_common.min(s.data) }

pub fn net_sec_auth_model_max(s : NetsecauthModel) -> Double { @_common.max(s.data) }

pub fn net_sec_auth_model_to_string(s : NetsecauthModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetsecauthLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_sec_auth_layer_make(size : Int) -> NetsecauthLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_sec_auth_layer_len(s : NetsecauthLayer) -> Int { s.size }

pub fn net_sec_auth_layer_get(s : NetsecauthLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_sec_auth_layer_set(s : NetsecauthLayer, i : Int, v : Double) -> NetsecauthLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn net_sec_auth_layer_sum(s : NetsecauthLayer) -> Double { @_common.sum(s.data) }

pub fn net_sec_auth_layer_mean(s : NetsecauthLayer) -> Double { @_common.mean(s.data) }

pub fn net_sec_auth_layer_scale(s : NetsecauthLayer, f : Double) -> NetsecauthLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_sec_auth_layer_add(a : NetsecauthLayer, b : NetsecauthLayer) -> NetsecauthLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_sec_auth_layer_copy(s : NetsecauthLayer) -> NetsecauthLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_sec_auth_layer_fill(s : NetsecauthLayer, v : Double) -> NetsecauthLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_sec_auth_layer_min(s : NetsecauthLayer) -> Double { @_common.min(s.data) }

pub fn net_sec_auth_layer_max(s : NetsecauthLayer) -> Double { @_common.max(s.data) }

pub fn net_sec_auth_layer_to_string(s : NetsecauthLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetsecauthBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_sec_auth_buffer_make(size : Int) -> NetsecauthBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_sec_auth_buffer_len(s : NetsecauthBuffer) -> Int { s.size }

pub fn net_sec_auth_buffer_get(s : NetsecauthBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_sec_auth_buffer_set(s : NetsecauthBuffer, i : Int, v : Double) -> NetsecauthBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn net_sec_auth_buffer_sum(s : NetsecauthBuffer) -> Double { @_common.sum(s.data) }

pub fn net_sec_auth_buffer_mean(s : NetsecauthBuffer) -> Double { @_common.mean(s.data) }

pub fn net_sec_auth_buffer_scale(s : NetsecauthBuffer, f : Double) -> NetsecauthBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_sec_auth_buffer_add(a : NetsecauthBuffer, b : NetsecauthBuffer) -> NetsecauthBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_sec_auth_buffer_copy(s : NetsecauthBuffer) -> NetsecauthBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_sec_auth_buffer_fill(s : NetsecauthBuffer, v : Double) -> NetsecauthBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_sec_auth_buffer_min(s : NetsecauthBuffer) -> Double { @_common.min(s.data) }

pub fn net_sec_auth_buffer_max(s : NetsecauthBuffer) -> Double { @_common.max(s.data) }

pub fn net_sec_auth_buffer_to_string(s : NetsecauthBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetsecauthCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_sec_auth_cursor_make(size : Int) -> NetsecauthCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_sec_auth_cursor_len(s : NetsecauthCursor) -> Int { s.size }

pub fn net_sec_auth_cursor_get(s : NetsecauthCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_sec_auth_cursor_set(s : NetsecauthCursor, i : Int, v : Double) -> NetsecauthCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn net_sec_auth_cursor_sum(s : NetsecauthCursor) -> Double { @_common.sum(s.data) }

pub fn net_sec_auth_cursor_mean(s : NetsecauthCursor) -> Double { @_common.mean(s.data) }

pub fn net_sec_auth_cursor_scale(s : NetsecauthCursor, f : Double) -> NetsecauthCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_sec_auth_cursor_add(a : NetsecauthCursor, b : NetsecauthCursor) -> NetsecauthCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_sec_auth_cursor_copy(s : NetsecauthCursor) -> NetsecauthCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_sec_auth_cursor_fill(s : NetsecauthCursor, v : Double) -> NetsecauthCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_sec_auth_cursor_min(s : NetsecauthCursor) -> Double { @_common.min(s.data) }

pub fn net_sec_auth_cursor_max(s : NetsecauthCursor) -> Double { @_common.max(s.data) }

pub fn net_sec_auth_cursor_to_string(s : NetsecauthCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetsecauthView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_sec_auth_view_make(size : Int) -> NetsecauthView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_sec_auth_view_len(s : NetsecauthView) -> Int { s.size }

pub fn net_sec_auth_view_get(s : NetsecauthView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_sec_auth_view_set(s : NetsecauthView, i : Int, v : Double) -> NetsecauthView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn net_sec_auth_view_sum(s : NetsecauthView) -> Double { @_common.sum(s.data) }

pub fn net_sec_auth_view_mean(s : NetsecauthView) -> Double { @_common.mean(s.data) }

pub fn net_sec_auth_view_scale(s : NetsecauthView, f : Double) -> NetsecauthView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_sec_auth_view_add(a : NetsecauthView, b : NetsecauthView) -> NetsecauthView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_sec_auth_view_copy(s : NetsecauthView) -> NetsecauthView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_sec_auth_view_fill(s : NetsecauthView, v : Double) -> NetsecauthView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_sec_auth_view_min(s : NetsecauthView) -> Double { @_common.min(s.data) }

pub fn net_sec_auth_view_max(s : NetsecauthView) -> Double { @_common.max(s.data) }

pub fn net_sec_auth_view_to_string(s : NetsecauthView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetsecauthRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_sec_auth_range_make(size : Int) -> NetsecauthRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_sec_auth_range_len(s : NetsecauthRange) -> Int { s.size }

pub fn net_sec_auth_range_get(s : NetsecauthRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_sec_auth_range_set(s : NetsecauthRange, i : Int, v : Double) -> NetsecauthRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn net_sec_auth_range_sum(s : NetsecauthRange) -> Double { @_common.sum(s.data) }

pub fn net_sec_auth_range_mean(s : NetsecauthRange) -> Double { @_common.mean(s.data) }

pub fn net_sec_auth_range_scale(s : NetsecauthRange, f : Double) -> NetsecauthRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_sec_auth_range_add(a : NetsecauthRange, b : NetsecauthRange) -> NetsecauthRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_sec_auth_range_copy(s : NetsecauthRange) -> NetsecauthRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_sec_auth_range_fill(s : NetsecauthRange, v : Double) -> NetsecauthRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_sec_auth_range_min(s : NetsecauthRange) -> Double { @_common.min(s.data) }

pub fn net_sec_auth_range_max(s : NetsecauthRange) -> Double { @_common.max(s.data) }

pub fn net_sec_auth_range_to_string(s : NetsecauthRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetsecauthSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_sec_auth_slice_make(size : Int) -> NetsecauthSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_sec_auth_slice_len(s : NetsecauthSlice) -> Int { s.size }

pub fn net_sec_auth_slice_get(s : NetsecauthSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_sec_auth_slice_set(s : NetsecauthSlice, i : Int, v : Double) -> NetsecauthSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn net_sec_auth_slice_sum(s : NetsecauthSlice) -> Double { @_common.sum(s.data) }

pub fn net_sec_auth_slice_mean(s : NetsecauthSlice) -> Double { @_common.mean(s.data) }

pub fn net_sec_auth_slice_scale(s : NetsecauthSlice, f : Double) -> NetsecauthSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_sec_auth_slice_add(a : NetsecauthSlice, b : NetsecauthSlice) -> NetsecauthSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_sec_auth_slice_copy(s : NetsecauthSlice) -> NetsecauthSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_sec_auth_slice_fill(s : NetsecauthSlice, v : Double) -> NetsecauthSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_sec_auth_slice_min(s : NetsecauthSlice) -> Double { @_common.min(s.data) }

pub fn net_sec_auth_slice_max(s : NetsecauthSlice) -> Double { @_common.max(s.data) }

pub fn net_sec_auth_slice_to_string(s : NetsecauthSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

