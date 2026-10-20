///===
/// extcore/net_sec_tls

pub(all) struct NetsectlsPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn net_sec_tls_make_point(x : Double, y : Double) -> NetsectlsPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn net_sec_tls_make_point3(x : Double, y : Double, z : Double) -> NetsectlsPoint {
  { x, y, z, label: 0 }
}

pub fn NetsectlsPoint::x(self : NetsectlsPoint) -> Double { self.x }

pub fn NetsectlsPoint::y(self : NetsectlsPoint) -> Double { self.y }

pub fn NetsectlsPoint::z(self : NetsectlsPoint) -> Double { self.z }

pub fn NetsectlsPoint::label(self : NetsectlsPoint) -> Int { self.label }

pub fn NetsectlsPoint::dist(self : NetsectlsPoint, other : NetsectlsPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn NetsectlsPoint::add(self : NetsectlsPoint, other : NetsectlsPoint) -> NetsectlsPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn NetsectlsPoint::sub(self : NetsectlsPoint, other : NetsectlsPoint) -> NetsectlsPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn NetsectlsPoint::scale(self : NetsectlsPoint, s : Double) -> NetsectlsPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn NetsectlsPoint::dot(self : NetsectlsPoint, other : NetsectlsPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn NetsectlsPoint::cross(self : NetsectlsPoint, other : NetsectlsPoint) -> NetsectlsPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn NetsectlsPoint::norm(self : NetsectlsPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn NetsectlsPoint::normalize(self : NetsectlsPoint) -> NetsectlsPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn NetsectlsPoint::negate(self : NetsectlsPoint) -> NetsectlsPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn NetsectlsPoint::mid(self : NetsectlsPoint, other : NetsectlsPoint) -> NetsectlsPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn NetsectlsPoint::lerp(self : NetsectlsPoint, other : NetsectlsPoint, t : Double) -> NetsectlsPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn NetsectlsPoint::to_string(self : NetsectlsPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct NetsectlsSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn net_sec_tls_make_series(vals : Array[Double], name : String) -> NetsectlsSeries {
  { vals, name, meta: 0 }
}

pub fn NetsectlsSeries::len(self : NetsectlsSeries) -> Int { self.vals.length() }

pub fn NetsectlsSeries::sum(self : NetsectlsSeries) -> Double { @_common.sum(self.vals) }

pub fn NetsectlsSeries::mean(self : NetsectlsSeries) -> Double { @_common.mean(self.vals) }

pub fn NetsectlsSeries::min(self : NetsectlsSeries) -> Double { @_common.min(self.vals) }

pub fn NetsectlsSeries::max(self : NetsectlsSeries) -> Double { @_common.max(self.vals) }

pub fn NetsectlsSeries::range(self : NetsectlsSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn NetsectlsSeries::variance(self : NetsectlsSeries) -> Double { @_common.variance(self.vals) }

pub fn NetsectlsSeries::std(self : NetsectlsSeries) -> Double { @_common.std(self.vals) }

pub fn NetsectlsSeries::median(self : NetsectlsSeries) -> Double { @_common.median(self.vals) }

pub fn NetsectlsSeries::scale(self : NetsectlsSeries, f : Double) -> NetsectlsSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn NetsectlsSeries::add(self : NetsectlsSeries, other : NetsectlsSeries) -> NetsectlsSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn NetsectlsSeries::sub(self : NetsectlsSeries, other : NetsectlsSeries) -> NetsectlsSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn NetsectlsSeries::normalize(self : NetsectlsSeries) -> NetsectlsSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn NetsectlsSeries::cumsum(self : NetsectlsSeries) -> NetsectlsSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn NetsectlsSeries::to_string(self : NetsectlsSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct NetsectlsMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn net_sec_tls_make_matrix(rows : Int, cols : Int, val : Double) -> NetsectlsMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn net_sec_tls_matrix_identity(n : Int) -> NetsectlsMatrix {
  let m = net_sec_tls_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn NetsectlsMatrix::get(self : NetsectlsMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn NetsectlsMatrix::transpose(self : NetsectlsMatrix) -> NetsectlsMatrix {
  let result = net_sec_tls_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn NetsectlsMatrix::add(self : NetsectlsMatrix, other : NetsectlsMatrix) -> NetsectlsMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = net_sec_tls_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn NetsectlsMatrix::scale(self : NetsectlsMatrix, s : Double) -> NetsectlsMatrix {
  let result = net_sec_tls_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn NetsectlsMatrix::multiply(self : NetsectlsMatrix, other : NetsectlsMatrix) -> NetsectlsMatrix {
  if self.cols != other.rows { return net_sec_tls_make_matrix(self.rows, other.cols, 0.0) }
  let result = net_sec_tls_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn NetsectlsMatrix::trace(self : NetsectlsMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn NetsectlsMatrix::det(self : NetsectlsMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn NetsectlsMatrix::norm(self : NetsectlsMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn NetsectlsMatrix::to_string(self : NetsectlsMatrix) -> String {
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

pub(all) struct NetsectlsVector {
  comps : Array[Double]
  dim : Int
}

pub fn net_sec_tls_make_vector(comps : Array[Double]) -> NetsectlsVector {
  { comps, dim: comps.length() }
}

pub fn net_sec_tls_vector_zero(dim : Int) -> NetsectlsVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn NetsectlsVector::add(self : NetsectlsVector, other : NetsectlsVector) -> NetsectlsVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn NetsectlsVector::sub(self : NetsectlsVector, other : NetsectlsVector) -> NetsectlsVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn NetsectlsVector::scale(self : NetsectlsVector, s : Double) -> NetsectlsVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn NetsectlsVector::dot(self : NetsectlsVector, other : NetsectlsVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn NetsectlsVector::norm(self : NetsectlsVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn NetsectlsVector::normalize(self : NetsectlsVector) -> NetsectlsVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn NetsectlsVector::dist(self : NetsectlsVector, other : NetsectlsVector) -> Double {
  self.sub(other).norm()
}

pub fn NetsectlsVector::to_string(self : NetsectlsVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn net_sec_tls_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn net_sec_tls_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn net_sec_tls_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn net_sec_tls_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn net_sec_tls_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn net_sec_tls_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn net_sec_tls_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn net_sec_tls_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn net_sec_tls_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn net_sec_tls_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn net_sec_tls_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn net_sec_tls_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn net_sec_tls_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn net_sec_tls_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn net_sec_tls_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn net_sec_tls_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn net_sec_tls_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn net_sec_tls_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn net_sec_tls_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn net_sec_tls_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn net_sec_tls_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn net_sec_tls_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn net_sec_tls_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn net_sec_tls_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn net_sec_tls_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn net_sec_tls_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn net_sec_tls_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn net_sec_tls_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn net_sec_tls_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct NetsectlsFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_sec_tls_frame_make(size : Int) -> NetsectlsFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_sec_tls_frame_len(s : NetsectlsFrame) -> Int { s.size }

pub fn net_sec_tls_frame_get(s : NetsectlsFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_sec_tls_frame_set(s : NetsectlsFrame, i : Int, v : Double) -> NetsectlsFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn net_sec_tls_frame_sum(s : NetsectlsFrame) -> Double { @_common.sum(s.data) }

pub fn net_sec_tls_frame_mean(s : NetsectlsFrame) -> Double { @_common.mean(s.data) }

pub fn net_sec_tls_frame_scale(s : NetsectlsFrame, f : Double) -> NetsectlsFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_sec_tls_frame_add(a : NetsectlsFrame, b : NetsectlsFrame) -> NetsectlsFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_sec_tls_frame_copy(s : NetsectlsFrame) -> NetsectlsFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_sec_tls_frame_fill(s : NetsectlsFrame, v : Double) -> NetsectlsFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_sec_tls_frame_min(s : NetsectlsFrame) -> Double { @_common.min(s.data) }

pub fn net_sec_tls_frame_max(s : NetsectlsFrame) -> Double { @_common.max(s.data) }

pub fn net_sec_tls_frame_to_string(s : NetsectlsFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetsectlsTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_sec_tls_table_make(size : Int) -> NetsectlsTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_sec_tls_table_len(s : NetsectlsTable) -> Int { s.size }

pub fn net_sec_tls_table_get(s : NetsectlsTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_sec_tls_table_set(s : NetsectlsTable, i : Int, v : Double) -> NetsectlsTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn net_sec_tls_table_sum(s : NetsectlsTable) -> Double { @_common.sum(s.data) }

pub fn net_sec_tls_table_mean(s : NetsectlsTable) -> Double { @_common.mean(s.data) }

pub fn net_sec_tls_table_scale(s : NetsectlsTable, f : Double) -> NetsectlsTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_sec_tls_table_add(a : NetsectlsTable, b : NetsectlsTable) -> NetsectlsTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_sec_tls_table_copy(s : NetsectlsTable) -> NetsectlsTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_sec_tls_table_fill(s : NetsectlsTable, v : Double) -> NetsectlsTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_sec_tls_table_min(s : NetsectlsTable) -> Double { @_common.min(s.data) }

pub fn net_sec_tls_table_max(s : NetsectlsTable) -> Double { @_common.max(s.data) }

pub fn net_sec_tls_table_to_string(s : NetsectlsTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetsectlsGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_sec_tls_graphn_make(size : Int) -> NetsectlsGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_sec_tls_graphn_len(s : NetsectlsGraphN) -> Int { s.size }

pub fn net_sec_tls_graphn_get(s : NetsectlsGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_sec_tls_graphn_set(s : NetsectlsGraphN, i : Int, v : Double) -> NetsectlsGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn net_sec_tls_graphn_sum(s : NetsectlsGraphN) -> Double { @_common.sum(s.data) }

pub fn net_sec_tls_graphn_mean(s : NetsectlsGraphN) -> Double { @_common.mean(s.data) }

pub fn net_sec_tls_graphn_scale(s : NetsectlsGraphN, f : Double) -> NetsectlsGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_sec_tls_graphn_add(a : NetsectlsGraphN, b : NetsectlsGraphN) -> NetsectlsGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_sec_tls_graphn_copy(s : NetsectlsGraphN) -> NetsectlsGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_sec_tls_graphn_fill(s : NetsectlsGraphN, v : Double) -> NetsectlsGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_sec_tls_graphn_min(s : NetsectlsGraphN) -> Double { @_common.min(s.data) }

pub fn net_sec_tls_graphn_max(s : NetsectlsGraphN) -> Double { @_common.max(s.data) }

pub fn net_sec_tls_graphn_to_string(s : NetsectlsGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetsectlsNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_sec_tls_node_make(size : Int) -> NetsectlsNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_sec_tls_node_len(s : NetsectlsNode) -> Int { s.size }

pub fn net_sec_tls_node_get(s : NetsectlsNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_sec_tls_node_set(s : NetsectlsNode, i : Int, v : Double) -> NetsectlsNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn net_sec_tls_node_sum(s : NetsectlsNode) -> Double { @_common.sum(s.data) }

pub fn net_sec_tls_node_mean(s : NetsectlsNode) -> Double { @_common.mean(s.data) }

pub fn net_sec_tls_node_scale(s : NetsectlsNode, f : Double) -> NetsectlsNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_sec_tls_node_add(a : NetsectlsNode, b : NetsectlsNode) -> NetsectlsNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_sec_tls_node_copy(s : NetsectlsNode) -> NetsectlsNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_sec_tls_node_fill(s : NetsectlsNode, v : Double) -> NetsectlsNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_sec_tls_node_min(s : NetsectlsNode) -> Double { @_common.min(s.data) }

pub fn net_sec_tls_node_max(s : NetsectlsNode) -> Double { @_common.max(s.data) }

pub fn net_sec_tls_node_to_string(s : NetsectlsNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetsectlsEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_sec_tls_edge_make(size : Int) -> NetsectlsEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_sec_tls_edge_len(s : NetsectlsEdge) -> Int { s.size }

pub fn net_sec_tls_edge_get(s : NetsectlsEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_sec_tls_edge_set(s : NetsectlsEdge, i : Int, v : Double) -> NetsectlsEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn net_sec_tls_edge_sum(s : NetsectlsEdge) -> Double { @_common.sum(s.data) }

pub fn net_sec_tls_edge_mean(s : NetsectlsEdge) -> Double { @_common.mean(s.data) }

pub fn net_sec_tls_edge_scale(s : NetsectlsEdge, f : Double) -> NetsectlsEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_sec_tls_edge_add(a : NetsectlsEdge, b : NetsectlsEdge) -> NetsectlsEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_sec_tls_edge_copy(s : NetsectlsEdge) -> NetsectlsEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_sec_tls_edge_fill(s : NetsectlsEdge, v : Double) -> NetsectlsEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_sec_tls_edge_min(s : NetsectlsEdge) -> Double { @_common.min(s.data) }

pub fn net_sec_tls_edge_max(s : NetsectlsEdge) -> Double { @_common.max(s.data) }

pub fn net_sec_tls_edge_to_string(s : NetsectlsEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetsectlsPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_sec_tls_path_make(size : Int) -> NetsectlsPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_sec_tls_path_len(s : NetsectlsPath) -> Int { s.size }

pub fn net_sec_tls_path_get(s : NetsectlsPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_sec_tls_path_set(s : NetsectlsPath, i : Int, v : Double) -> NetsectlsPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn net_sec_tls_path_sum(s : NetsectlsPath) -> Double { @_common.sum(s.data) }

pub fn net_sec_tls_path_mean(s : NetsectlsPath) -> Double { @_common.mean(s.data) }

pub fn net_sec_tls_path_scale(s : NetsectlsPath, f : Double) -> NetsectlsPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_sec_tls_path_add(a : NetsectlsPath, b : NetsectlsPath) -> NetsectlsPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_sec_tls_path_copy(s : NetsectlsPath) -> NetsectlsPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_sec_tls_path_fill(s : NetsectlsPath, v : Double) -> NetsectlsPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_sec_tls_path_min(s : NetsectlsPath) -> Double { @_common.min(s.data) }

pub fn net_sec_tls_path_max(s : NetsectlsPath) -> Double { @_common.max(s.data) }

pub fn net_sec_tls_path_to_string(s : NetsectlsPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetsectlsCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_sec_tls_cluster_make(size : Int) -> NetsectlsCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_sec_tls_cluster_len(s : NetsectlsCluster) -> Int { s.size }

pub fn net_sec_tls_cluster_get(s : NetsectlsCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_sec_tls_cluster_set(s : NetsectlsCluster, i : Int, v : Double) -> NetsectlsCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn net_sec_tls_cluster_sum(s : NetsectlsCluster) -> Double { @_common.sum(s.data) }

pub fn net_sec_tls_cluster_mean(s : NetsectlsCluster) -> Double { @_common.mean(s.data) }

pub fn net_sec_tls_cluster_scale(s : NetsectlsCluster, f : Double) -> NetsectlsCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_sec_tls_cluster_add(a : NetsectlsCluster, b : NetsectlsCluster) -> NetsectlsCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_sec_tls_cluster_copy(s : NetsectlsCluster) -> NetsectlsCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_sec_tls_cluster_fill(s : NetsectlsCluster, v : Double) -> NetsectlsCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_sec_tls_cluster_min(s : NetsectlsCluster) -> Double { @_common.min(s.data) }

pub fn net_sec_tls_cluster_max(s : NetsectlsCluster) -> Double { @_common.max(s.data) }

pub fn net_sec_tls_cluster_to_string(s : NetsectlsCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetsectlsModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_sec_tls_model_make(size : Int) -> NetsectlsModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_sec_tls_model_len(s : NetsectlsModel) -> Int { s.size }

pub fn net_sec_tls_model_get(s : NetsectlsModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_sec_tls_model_set(s : NetsectlsModel, i : Int, v : Double) -> NetsectlsModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn net_sec_tls_model_sum(s : NetsectlsModel) -> Double { @_common.sum(s.data) }

pub fn net_sec_tls_model_mean(s : NetsectlsModel) -> Double { @_common.mean(s.data) }

pub fn net_sec_tls_model_scale(s : NetsectlsModel, f : Double) -> NetsectlsModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_sec_tls_model_add(a : NetsectlsModel, b : NetsectlsModel) -> NetsectlsModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_sec_tls_model_copy(s : NetsectlsModel) -> NetsectlsModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_sec_tls_model_fill(s : NetsectlsModel, v : Double) -> NetsectlsModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_sec_tls_model_min(s : NetsectlsModel) -> Double { @_common.min(s.data) }

pub fn net_sec_tls_model_max(s : NetsectlsModel) -> Double { @_common.max(s.data) }

pub fn net_sec_tls_model_to_string(s : NetsectlsModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetsectlsLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_sec_tls_layer_make(size : Int) -> NetsectlsLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_sec_tls_layer_len(s : NetsectlsLayer) -> Int { s.size }

pub fn net_sec_tls_layer_get(s : NetsectlsLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_sec_tls_layer_set(s : NetsectlsLayer, i : Int, v : Double) -> NetsectlsLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn net_sec_tls_layer_sum(s : NetsectlsLayer) -> Double { @_common.sum(s.data) }

pub fn net_sec_tls_layer_mean(s : NetsectlsLayer) -> Double { @_common.mean(s.data) }

pub fn net_sec_tls_layer_scale(s : NetsectlsLayer, f : Double) -> NetsectlsLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_sec_tls_layer_add(a : NetsectlsLayer, b : NetsectlsLayer) -> NetsectlsLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_sec_tls_layer_copy(s : NetsectlsLayer) -> NetsectlsLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_sec_tls_layer_fill(s : NetsectlsLayer, v : Double) -> NetsectlsLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_sec_tls_layer_min(s : NetsectlsLayer) -> Double { @_common.min(s.data) }

pub fn net_sec_tls_layer_max(s : NetsectlsLayer) -> Double { @_common.max(s.data) }

pub fn net_sec_tls_layer_to_string(s : NetsectlsLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetsectlsBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_sec_tls_buffer_make(size : Int) -> NetsectlsBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_sec_tls_buffer_len(s : NetsectlsBuffer) -> Int { s.size }

pub fn net_sec_tls_buffer_get(s : NetsectlsBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_sec_tls_buffer_set(s : NetsectlsBuffer, i : Int, v : Double) -> NetsectlsBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn net_sec_tls_buffer_sum(s : NetsectlsBuffer) -> Double { @_common.sum(s.data) }

pub fn net_sec_tls_buffer_mean(s : NetsectlsBuffer) -> Double { @_common.mean(s.data) }

pub fn net_sec_tls_buffer_scale(s : NetsectlsBuffer, f : Double) -> NetsectlsBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_sec_tls_buffer_add(a : NetsectlsBuffer, b : NetsectlsBuffer) -> NetsectlsBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_sec_tls_buffer_copy(s : NetsectlsBuffer) -> NetsectlsBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_sec_tls_buffer_fill(s : NetsectlsBuffer, v : Double) -> NetsectlsBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_sec_tls_buffer_min(s : NetsectlsBuffer) -> Double { @_common.min(s.data) }

pub fn net_sec_tls_buffer_max(s : NetsectlsBuffer) -> Double { @_common.max(s.data) }

pub fn net_sec_tls_buffer_to_string(s : NetsectlsBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetsectlsCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_sec_tls_cursor_make(size : Int) -> NetsectlsCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_sec_tls_cursor_len(s : NetsectlsCursor) -> Int { s.size }

pub fn net_sec_tls_cursor_get(s : NetsectlsCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_sec_tls_cursor_set(s : NetsectlsCursor, i : Int, v : Double) -> NetsectlsCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn net_sec_tls_cursor_sum(s : NetsectlsCursor) -> Double { @_common.sum(s.data) }

pub fn net_sec_tls_cursor_mean(s : NetsectlsCursor) -> Double { @_common.mean(s.data) }

pub fn net_sec_tls_cursor_scale(s : NetsectlsCursor, f : Double) -> NetsectlsCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_sec_tls_cursor_add(a : NetsectlsCursor, b : NetsectlsCursor) -> NetsectlsCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_sec_tls_cursor_copy(s : NetsectlsCursor) -> NetsectlsCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_sec_tls_cursor_fill(s : NetsectlsCursor, v : Double) -> NetsectlsCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_sec_tls_cursor_min(s : NetsectlsCursor) -> Double { @_common.min(s.data) }

pub fn net_sec_tls_cursor_max(s : NetsectlsCursor) -> Double { @_common.max(s.data) }

pub fn net_sec_tls_cursor_to_string(s : NetsectlsCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetsectlsView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_sec_tls_view_make(size : Int) -> NetsectlsView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_sec_tls_view_len(s : NetsectlsView) -> Int { s.size }

pub fn net_sec_tls_view_get(s : NetsectlsView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_sec_tls_view_set(s : NetsectlsView, i : Int, v : Double) -> NetsectlsView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn net_sec_tls_view_sum(s : NetsectlsView) -> Double { @_common.sum(s.data) }

pub fn net_sec_tls_view_mean(s : NetsectlsView) -> Double { @_common.mean(s.data) }

pub fn net_sec_tls_view_scale(s : NetsectlsView, f : Double) -> NetsectlsView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_sec_tls_view_add(a : NetsectlsView, b : NetsectlsView) -> NetsectlsView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_sec_tls_view_copy(s : NetsectlsView) -> NetsectlsView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_sec_tls_view_fill(s : NetsectlsView, v : Double) -> NetsectlsView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_sec_tls_view_min(s : NetsectlsView) -> Double { @_common.min(s.data) }

pub fn net_sec_tls_view_max(s : NetsectlsView) -> Double { @_common.max(s.data) }

pub fn net_sec_tls_view_to_string(s : NetsectlsView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetsectlsRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_sec_tls_range_make(size : Int) -> NetsectlsRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_sec_tls_range_len(s : NetsectlsRange) -> Int { s.size }

pub fn net_sec_tls_range_get(s : NetsectlsRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_sec_tls_range_set(s : NetsectlsRange, i : Int, v : Double) -> NetsectlsRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn net_sec_tls_range_sum(s : NetsectlsRange) -> Double { @_common.sum(s.data) }

pub fn net_sec_tls_range_mean(s : NetsectlsRange) -> Double { @_common.mean(s.data) }

pub fn net_sec_tls_range_scale(s : NetsectlsRange, f : Double) -> NetsectlsRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_sec_tls_range_add(a : NetsectlsRange, b : NetsectlsRange) -> NetsectlsRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_sec_tls_range_copy(s : NetsectlsRange) -> NetsectlsRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_sec_tls_range_fill(s : NetsectlsRange, v : Double) -> NetsectlsRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_sec_tls_range_min(s : NetsectlsRange) -> Double { @_common.min(s.data) }

pub fn net_sec_tls_range_max(s : NetsectlsRange) -> Double { @_common.max(s.data) }

pub fn net_sec_tls_range_to_string(s : NetsectlsRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetsectlsSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_sec_tls_slice_make(size : Int) -> NetsectlsSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_sec_tls_slice_len(s : NetsectlsSlice) -> Int { s.size }

pub fn net_sec_tls_slice_get(s : NetsectlsSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_sec_tls_slice_set(s : NetsectlsSlice, i : Int, v : Double) -> NetsectlsSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn net_sec_tls_slice_sum(s : NetsectlsSlice) -> Double { @_common.sum(s.data) }

pub fn net_sec_tls_slice_mean(s : NetsectlsSlice) -> Double { @_common.mean(s.data) }

pub fn net_sec_tls_slice_scale(s : NetsectlsSlice, f : Double) -> NetsectlsSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_sec_tls_slice_add(a : NetsectlsSlice, b : NetsectlsSlice) -> NetsectlsSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_sec_tls_slice_copy(s : NetsectlsSlice) -> NetsectlsSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_sec_tls_slice_fill(s : NetsectlsSlice, v : Double) -> NetsectlsSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_sec_tls_slice_min(s : NetsectlsSlice) -> Double { @_common.min(s.data) }

pub fn net_sec_tls_slice_max(s : NetsectlsSlice) -> Double { @_common.max(s.data) }

pub fn net_sec_tls_slice_to_string(s : NetsectlsSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

