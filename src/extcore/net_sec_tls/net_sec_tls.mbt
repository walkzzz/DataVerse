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

pub fn NetsectlsFrame::len(self : NetsectlsFrame) -> Int { self.size }

pub fn NetsectlsFrame::get(self : NetsectlsFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NetsectlsFrame::set(self : NetsectlsFrame, i : Int, v : Double) -> NetsectlsFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NetsectlsFrame::sum(self : NetsectlsFrame) -> Double { @_common.sum(self.data) }

pub fn NetsectlsFrame::mean(self : NetsectlsFrame) -> Double { @_common.mean(self.data) }

pub fn NetsectlsFrame::scale(self : NetsectlsFrame, f : Double) -> NetsectlsFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NetsectlsFrame::add(self : NetsectlsFrame, other : NetsectlsFrame) -> NetsectlsFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NetsectlsFrame::copy(self : NetsectlsFrame) -> NetsectlsFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NetsectlsFrame::fill(self : NetsectlsFrame, v : Double) -> NetsectlsFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NetsectlsFrame::min(self : NetsectlsFrame) -> Double { @_common.min(self.data) }

pub fn NetsectlsFrame::max(self : NetsectlsFrame) -> Double { @_common.max(self.data) }

pub fn NetsectlsFrame::to_string(self : NetsectlsFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NetsectlsTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_sec_tls_table_make(size : Int) -> NetsectlsTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NetsectlsTable::len(self : NetsectlsTable) -> Int { self.size }

pub fn NetsectlsTable::get(self : NetsectlsTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NetsectlsTable::set(self : NetsectlsTable, i : Int, v : Double) -> NetsectlsTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NetsectlsTable::sum(self : NetsectlsTable) -> Double { @_common.sum(self.data) }

pub fn NetsectlsTable::mean(self : NetsectlsTable) -> Double { @_common.mean(self.data) }

pub fn NetsectlsTable::scale(self : NetsectlsTable, f : Double) -> NetsectlsTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NetsectlsTable::add(self : NetsectlsTable, other : NetsectlsTable) -> NetsectlsTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NetsectlsTable::copy(self : NetsectlsTable) -> NetsectlsTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NetsectlsTable::fill(self : NetsectlsTable, v : Double) -> NetsectlsTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NetsectlsTable::min(self : NetsectlsTable) -> Double { @_common.min(self.data) }

pub fn NetsectlsTable::max(self : NetsectlsTable) -> Double { @_common.max(self.data) }

pub fn NetsectlsTable::to_string(self : NetsectlsTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NetsectlsGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_sec_tls_graphn_make(size : Int) -> NetsectlsGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NetsectlsGraphN::len(self : NetsectlsGraphN) -> Int { self.size }

pub fn NetsectlsGraphN::get(self : NetsectlsGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NetsectlsGraphN::set(self : NetsectlsGraphN, i : Int, v : Double) -> NetsectlsGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NetsectlsGraphN::sum(self : NetsectlsGraphN) -> Double { @_common.sum(self.data) }

pub fn NetsectlsGraphN::mean(self : NetsectlsGraphN) -> Double { @_common.mean(self.data) }

pub fn NetsectlsGraphN::scale(self : NetsectlsGraphN, f : Double) -> NetsectlsGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NetsectlsGraphN::add(self : NetsectlsGraphN, other : NetsectlsGraphN) -> NetsectlsGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NetsectlsGraphN::copy(self : NetsectlsGraphN) -> NetsectlsGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NetsectlsGraphN::fill(self : NetsectlsGraphN, v : Double) -> NetsectlsGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NetsectlsGraphN::min(self : NetsectlsGraphN) -> Double { @_common.min(self.data) }

pub fn NetsectlsGraphN::max(self : NetsectlsGraphN) -> Double { @_common.max(self.data) }

pub fn NetsectlsGraphN::to_string(self : NetsectlsGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NetsectlsNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_sec_tls_node_make(size : Int) -> NetsectlsNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NetsectlsNode::len(self : NetsectlsNode) -> Int { self.size }

pub fn NetsectlsNode::get(self : NetsectlsNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NetsectlsNode::set(self : NetsectlsNode, i : Int, v : Double) -> NetsectlsNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NetsectlsNode::sum(self : NetsectlsNode) -> Double { @_common.sum(self.data) }

pub fn NetsectlsNode::mean(self : NetsectlsNode) -> Double { @_common.mean(self.data) }

pub fn NetsectlsNode::scale(self : NetsectlsNode, f : Double) -> NetsectlsNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NetsectlsNode::add(self : NetsectlsNode, other : NetsectlsNode) -> NetsectlsNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NetsectlsNode::copy(self : NetsectlsNode) -> NetsectlsNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NetsectlsNode::fill(self : NetsectlsNode, v : Double) -> NetsectlsNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NetsectlsNode::min(self : NetsectlsNode) -> Double { @_common.min(self.data) }

pub fn NetsectlsNode::max(self : NetsectlsNode) -> Double { @_common.max(self.data) }

pub fn NetsectlsNode::to_string(self : NetsectlsNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NetsectlsEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_sec_tls_edge_make(size : Int) -> NetsectlsEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NetsectlsEdge::len(self : NetsectlsEdge) -> Int { self.size }

pub fn NetsectlsEdge::get(self : NetsectlsEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NetsectlsEdge::set(self : NetsectlsEdge, i : Int, v : Double) -> NetsectlsEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NetsectlsEdge::sum(self : NetsectlsEdge) -> Double { @_common.sum(self.data) }

pub fn NetsectlsEdge::mean(self : NetsectlsEdge) -> Double { @_common.mean(self.data) }

pub fn NetsectlsEdge::scale(self : NetsectlsEdge, f : Double) -> NetsectlsEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NetsectlsEdge::add(self : NetsectlsEdge, other : NetsectlsEdge) -> NetsectlsEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NetsectlsEdge::copy(self : NetsectlsEdge) -> NetsectlsEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NetsectlsEdge::fill(self : NetsectlsEdge, v : Double) -> NetsectlsEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NetsectlsEdge::min(self : NetsectlsEdge) -> Double { @_common.min(self.data) }

pub fn NetsectlsEdge::max(self : NetsectlsEdge) -> Double { @_common.max(self.data) }

pub fn NetsectlsEdge::to_string(self : NetsectlsEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NetsectlsPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_sec_tls_path_make(size : Int) -> NetsectlsPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NetsectlsPath::len(self : NetsectlsPath) -> Int { self.size }

pub fn NetsectlsPath::get(self : NetsectlsPath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NetsectlsPath::set(self : NetsectlsPath, i : Int, v : Double) -> NetsectlsPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NetsectlsPath::sum(self : NetsectlsPath) -> Double { @_common.sum(self.data) }

pub fn NetsectlsPath::mean(self : NetsectlsPath) -> Double { @_common.mean(self.data) }

pub fn NetsectlsPath::scale(self : NetsectlsPath, f : Double) -> NetsectlsPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NetsectlsPath::add(self : NetsectlsPath, other : NetsectlsPath) -> NetsectlsPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NetsectlsPath::copy(self : NetsectlsPath) -> NetsectlsPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NetsectlsPath::fill(self : NetsectlsPath, v : Double) -> NetsectlsPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NetsectlsPath::min(self : NetsectlsPath) -> Double { @_common.min(self.data) }

pub fn NetsectlsPath::max(self : NetsectlsPath) -> Double { @_common.max(self.data) }

pub fn NetsectlsPath::to_string(self : NetsectlsPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NetsectlsCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_sec_tls_cluster_make(size : Int) -> NetsectlsCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NetsectlsCluster::len(self : NetsectlsCluster) -> Int { self.size }

pub fn NetsectlsCluster::get(self : NetsectlsCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NetsectlsCluster::set(self : NetsectlsCluster, i : Int, v : Double) -> NetsectlsCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NetsectlsCluster::sum(self : NetsectlsCluster) -> Double { @_common.sum(self.data) }

pub fn NetsectlsCluster::mean(self : NetsectlsCluster) -> Double { @_common.mean(self.data) }

pub fn NetsectlsCluster::scale(self : NetsectlsCluster, f : Double) -> NetsectlsCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NetsectlsCluster::add(self : NetsectlsCluster, other : NetsectlsCluster) -> NetsectlsCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NetsectlsCluster::copy(self : NetsectlsCluster) -> NetsectlsCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NetsectlsCluster::fill(self : NetsectlsCluster, v : Double) -> NetsectlsCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NetsectlsCluster::min(self : NetsectlsCluster) -> Double { @_common.min(self.data) }

pub fn NetsectlsCluster::max(self : NetsectlsCluster) -> Double { @_common.max(self.data) }

pub fn NetsectlsCluster::to_string(self : NetsectlsCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NetsectlsModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_sec_tls_model_make(size : Int) -> NetsectlsModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NetsectlsModel::len(self : NetsectlsModel) -> Int { self.size }

pub fn NetsectlsModel::get(self : NetsectlsModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NetsectlsModel::set(self : NetsectlsModel, i : Int, v : Double) -> NetsectlsModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NetsectlsModel::sum(self : NetsectlsModel) -> Double { @_common.sum(self.data) }

pub fn NetsectlsModel::mean(self : NetsectlsModel) -> Double { @_common.mean(self.data) }

pub fn NetsectlsModel::scale(self : NetsectlsModel, f : Double) -> NetsectlsModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NetsectlsModel::add(self : NetsectlsModel, other : NetsectlsModel) -> NetsectlsModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NetsectlsModel::copy(self : NetsectlsModel) -> NetsectlsModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NetsectlsModel::fill(self : NetsectlsModel, v : Double) -> NetsectlsModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NetsectlsModel::min(self : NetsectlsModel) -> Double { @_common.min(self.data) }

pub fn NetsectlsModel::max(self : NetsectlsModel) -> Double { @_common.max(self.data) }

pub fn NetsectlsModel::to_string(self : NetsectlsModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NetsectlsLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_sec_tls_layer_make(size : Int) -> NetsectlsLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NetsectlsLayer::len(self : NetsectlsLayer) -> Int { self.size }

pub fn NetsectlsLayer::get(self : NetsectlsLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NetsectlsLayer::set(self : NetsectlsLayer, i : Int, v : Double) -> NetsectlsLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NetsectlsLayer::sum(self : NetsectlsLayer) -> Double { @_common.sum(self.data) }

pub fn NetsectlsLayer::mean(self : NetsectlsLayer) -> Double { @_common.mean(self.data) }

pub fn NetsectlsLayer::scale(self : NetsectlsLayer, f : Double) -> NetsectlsLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NetsectlsLayer::add(self : NetsectlsLayer, other : NetsectlsLayer) -> NetsectlsLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NetsectlsLayer::copy(self : NetsectlsLayer) -> NetsectlsLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NetsectlsLayer::fill(self : NetsectlsLayer, v : Double) -> NetsectlsLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NetsectlsLayer::min(self : NetsectlsLayer) -> Double { @_common.min(self.data) }

pub fn NetsectlsLayer::max(self : NetsectlsLayer) -> Double { @_common.max(self.data) }

pub fn NetsectlsLayer::to_string(self : NetsectlsLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NetsectlsBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_sec_tls_buffer_make(size : Int) -> NetsectlsBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NetsectlsBuffer::len(self : NetsectlsBuffer) -> Int { self.size }

pub fn NetsectlsBuffer::get(self : NetsectlsBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NetsectlsBuffer::set(self : NetsectlsBuffer, i : Int, v : Double) -> NetsectlsBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NetsectlsBuffer::sum(self : NetsectlsBuffer) -> Double { @_common.sum(self.data) }

pub fn NetsectlsBuffer::mean(self : NetsectlsBuffer) -> Double { @_common.mean(self.data) }

pub fn NetsectlsBuffer::scale(self : NetsectlsBuffer, f : Double) -> NetsectlsBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NetsectlsBuffer::add(self : NetsectlsBuffer, other : NetsectlsBuffer) -> NetsectlsBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NetsectlsBuffer::copy(self : NetsectlsBuffer) -> NetsectlsBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NetsectlsBuffer::fill(self : NetsectlsBuffer, v : Double) -> NetsectlsBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NetsectlsBuffer::min(self : NetsectlsBuffer) -> Double { @_common.min(self.data) }

pub fn NetsectlsBuffer::max(self : NetsectlsBuffer) -> Double { @_common.max(self.data) }

pub fn NetsectlsBuffer::to_string(self : NetsectlsBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NetsectlsCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_sec_tls_cursor_make(size : Int) -> NetsectlsCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NetsectlsCursor::len(self : NetsectlsCursor) -> Int { self.size }

pub fn NetsectlsCursor::get(self : NetsectlsCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NetsectlsCursor::set(self : NetsectlsCursor, i : Int, v : Double) -> NetsectlsCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NetsectlsCursor::sum(self : NetsectlsCursor) -> Double { @_common.sum(self.data) }

pub fn NetsectlsCursor::mean(self : NetsectlsCursor) -> Double { @_common.mean(self.data) }

pub fn NetsectlsCursor::scale(self : NetsectlsCursor, f : Double) -> NetsectlsCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NetsectlsCursor::add(self : NetsectlsCursor, other : NetsectlsCursor) -> NetsectlsCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NetsectlsCursor::copy(self : NetsectlsCursor) -> NetsectlsCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NetsectlsCursor::fill(self : NetsectlsCursor, v : Double) -> NetsectlsCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NetsectlsCursor::min(self : NetsectlsCursor) -> Double { @_common.min(self.data) }

pub fn NetsectlsCursor::max(self : NetsectlsCursor) -> Double { @_common.max(self.data) }

pub fn NetsectlsCursor::to_string(self : NetsectlsCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NetsectlsView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_sec_tls_view_make(size : Int) -> NetsectlsView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NetsectlsView::len(self : NetsectlsView) -> Int { self.size }

pub fn NetsectlsView::get(self : NetsectlsView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NetsectlsView::set(self : NetsectlsView, i : Int, v : Double) -> NetsectlsView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NetsectlsView::sum(self : NetsectlsView) -> Double { @_common.sum(self.data) }

pub fn NetsectlsView::mean(self : NetsectlsView) -> Double { @_common.mean(self.data) }

pub fn NetsectlsView::scale(self : NetsectlsView, f : Double) -> NetsectlsView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NetsectlsView::add(self : NetsectlsView, other : NetsectlsView) -> NetsectlsView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NetsectlsView::copy(self : NetsectlsView) -> NetsectlsView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NetsectlsView::fill(self : NetsectlsView, v : Double) -> NetsectlsView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NetsectlsView::min(self : NetsectlsView) -> Double { @_common.min(self.data) }

pub fn NetsectlsView::max(self : NetsectlsView) -> Double { @_common.max(self.data) }

pub fn NetsectlsView::to_string(self : NetsectlsView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NetsectlsRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_sec_tls_range_make(size : Int) -> NetsectlsRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NetsectlsRange::len(self : NetsectlsRange) -> Int { self.size }

pub fn NetsectlsRange::get(self : NetsectlsRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NetsectlsRange::set(self : NetsectlsRange, i : Int, v : Double) -> NetsectlsRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NetsectlsRange::sum(self : NetsectlsRange) -> Double { @_common.sum(self.data) }

pub fn NetsectlsRange::mean(self : NetsectlsRange) -> Double { @_common.mean(self.data) }

pub fn NetsectlsRange::scale(self : NetsectlsRange, f : Double) -> NetsectlsRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NetsectlsRange::add(self : NetsectlsRange, other : NetsectlsRange) -> NetsectlsRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NetsectlsRange::copy(self : NetsectlsRange) -> NetsectlsRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NetsectlsRange::fill(self : NetsectlsRange, v : Double) -> NetsectlsRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NetsectlsRange::min(self : NetsectlsRange) -> Double { @_common.min(self.data) }

pub fn NetsectlsRange::max(self : NetsectlsRange) -> Double { @_common.max(self.data) }

pub fn NetsectlsRange::to_string(self : NetsectlsRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NetsectlsSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_sec_tls_slice_make(size : Int) -> NetsectlsSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NetsectlsSlice::len(self : NetsectlsSlice) -> Int { self.size }

pub fn NetsectlsSlice::get(self : NetsectlsSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NetsectlsSlice::set(self : NetsectlsSlice, i : Int, v : Double) -> NetsectlsSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NetsectlsSlice::sum(self : NetsectlsSlice) -> Double { @_common.sum(self.data) }

pub fn NetsectlsSlice::mean(self : NetsectlsSlice) -> Double { @_common.mean(self.data) }

pub fn NetsectlsSlice::scale(self : NetsectlsSlice, f : Double) -> NetsectlsSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NetsectlsSlice::add(self : NetsectlsSlice, other : NetsectlsSlice) -> NetsectlsSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NetsectlsSlice::copy(self : NetsectlsSlice) -> NetsectlsSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NetsectlsSlice::fill(self : NetsectlsSlice, v : Double) -> NetsectlsSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NetsectlsSlice::min(self : NetsectlsSlice) -> Double { @_common.min(self.data) }

pub fn NetsectlsSlice::max(self : NetsectlsSlice) -> Double { @_common.max(self.data) }

pub fn NetsectlsSlice::to_string(self : NetsectlsSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

