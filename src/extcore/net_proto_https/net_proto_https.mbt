///===
/// extcore/net_proto_https

pub(all) struct NetprotohttpsPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn net_proto_https_make_point(x : Double, y : Double) -> NetprotohttpsPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn net_proto_https_make_point3(x : Double, y : Double, z : Double) -> NetprotohttpsPoint {
  { x, y, z, label: 0 }
}

pub fn NetprotohttpsPoint::x(self : NetprotohttpsPoint) -> Double { self.x }

pub fn NetprotohttpsPoint::y(self : NetprotohttpsPoint) -> Double { self.y }

pub fn NetprotohttpsPoint::z(self : NetprotohttpsPoint) -> Double { self.z }

pub fn NetprotohttpsPoint::label(self : NetprotohttpsPoint) -> Int { self.label }

pub fn NetprotohttpsPoint::dist(self : NetprotohttpsPoint, other : NetprotohttpsPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn NetprotohttpsPoint::add(self : NetprotohttpsPoint, other : NetprotohttpsPoint) -> NetprotohttpsPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn NetprotohttpsPoint::sub(self : NetprotohttpsPoint, other : NetprotohttpsPoint) -> NetprotohttpsPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn NetprotohttpsPoint::scale(self : NetprotohttpsPoint, s : Double) -> NetprotohttpsPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn NetprotohttpsPoint::dot(self : NetprotohttpsPoint, other : NetprotohttpsPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn NetprotohttpsPoint::cross(self : NetprotohttpsPoint, other : NetprotohttpsPoint) -> NetprotohttpsPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn NetprotohttpsPoint::norm(self : NetprotohttpsPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn NetprotohttpsPoint::normalize(self : NetprotohttpsPoint) -> NetprotohttpsPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn NetprotohttpsPoint::negate(self : NetprotohttpsPoint) -> NetprotohttpsPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn NetprotohttpsPoint::mid(self : NetprotohttpsPoint, other : NetprotohttpsPoint) -> NetprotohttpsPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn NetprotohttpsPoint::lerp(self : NetprotohttpsPoint, other : NetprotohttpsPoint, t : Double) -> NetprotohttpsPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn NetprotohttpsPoint::to_string(self : NetprotohttpsPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct NetprotohttpsSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn net_proto_https_make_series(vals : Array[Double], name : String) -> NetprotohttpsSeries {
  { vals, name, meta: 0 }
}

pub fn NetprotohttpsSeries::len(self : NetprotohttpsSeries) -> Int { self.vals.length() }

pub fn NetprotohttpsSeries::sum(self : NetprotohttpsSeries) -> Double { @_common.sum(self.vals) }

pub fn NetprotohttpsSeries::mean(self : NetprotohttpsSeries) -> Double { @_common.mean(self.vals) }

pub fn NetprotohttpsSeries::min(self : NetprotohttpsSeries) -> Double { @_common.min(self.vals) }

pub fn NetprotohttpsSeries::max(self : NetprotohttpsSeries) -> Double { @_common.max(self.vals) }

pub fn NetprotohttpsSeries::range(self : NetprotohttpsSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn NetprotohttpsSeries::variance(self : NetprotohttpsSeries) -> Double { @_common.variance(self.vals) }

pub fn NetprotohttpsSeries::std(self : NetprotohttpsSeries) -> Double { @_common.std(self.vals) }

pub fn NetprotohttpsSeries::median(self : NetprotohttpsSeries) -> Double { @_common.median(self.vals) }

pub fn NetprotohttpsSeries::scale(self : NetprotohttpsSeries, f : Double) -> NetprotohttpsSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn NetprotohttpsSeries::add(self : NetprotohttpsSeries, other : NetprotohttpsSeries) -> NetprotohttpsSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn NetprotohttpsSeries::sub(self : NetprotohttpsSeries, other : NetprotohttpsSeries) -> NetprotohttpsSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn NetprotohttpsSeries::normalize(self : NetprotohttpsSeries) -> NetprotohttpsSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn NetprotohttpsSeries::cumsum(self : NetprotohttpsSeries) -> NetprotohttpsSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn NetprotohttpsSeries::to_string(self : NetprotohttpsSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct NetprotohttpsMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn net_proto_https_make_matrix(rows : Int, cols : Int, val : Double) -> NetprotohttpsMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn net_proto_https_matrix_identity(n : Int) -> NetprotohttpsMatrix {
  let m = net_proto_https_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn NetprotohttpsMatrix::get(self : NetprotohttpsMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn NetprotohttpsMatrix::transpose(self : NetprotohttpsMatrix) -> NetprotohttpsMatrix {
  let result = net_proto_https_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn NetprotohttpsMatrix::add(self : NetprotohttpsMatrix, other : NetprotohttpsMatrix) -> NetprotohttpsMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = net_proto_https_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn NetprotohttpsMatrix::scale(self : NetprotohttpsMatrix, s : Double) -> NetprotohttpsMatrix {
  let result = net_proto_https_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn NetprotohttpsMatrix::multiply(self : NetprotohttpsMatrix, other : NetprotohttpsMatrix) -> NetprotohttpsMatrix {
  if self.cols != other.rows { return net_proto_https_make_matrix(self.rows, other.cols, 0.0) }
  let result = net_proto_https_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn NetprotohttpsMatrix::trace(self : NetprotohttpsMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn NetprotohttpsMatrix::det(self : NetprotohttpsMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn NetprotohttpsMatrix::norm(self : NetprotohttpsMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn NetprotohttpsMatrix::to_string(self : NetprotohttpsMatrix) -> String {
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

pub(all) struct NetprotohttpsVector {
  comps : Array[Double]
  dim : Int
}

pub fn net_proto_https_make_vector(comps : Array[Double]) -> NetprotohttpsVector {
  { comps, dim: comps.length() }
}

pub fn net_proto_https_vector_zero(dim : Int) -> NetprotohttpsVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn NetprotohttpsVector::add(self : NetprotohttpsVector, other : NetprotohttpsVector) -> NetprotohttpsVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn NetprotohttpsVector::sub(self : NetprotohttpsVector, other : NetprotohttpsVector) -> NetprotohttpsVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn NetprotohttpsVector::scale(self : NetprotohttpsVector, s : Double) -> NetprotohttpsVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn NetprotohttpsVector::dot(self : NetprotohttpsVector, other : NetprotohttpsVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn NetprotohttpsVector::norm(self : NetprotohttpsVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn NetprotohttpsVector::normalize(self : NetprotohttpsVector) -> NetprotohttpsVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn NetprotohttpsVector::dist(self : NetprotohttpsVector, other : NetprotohttpsVector) -> Double {
  self.sub(other).norm()
}

pub fn NetprotohttpsVector::to_string(self : NetprotohttpsVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn net_proto_https_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn net_proto_https_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn net_proto_https_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn net_proto_https_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn net_proto_https_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn net_proto_https_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn net_proto_https_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn net_proto_https_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn net_proto_https_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn net_proto_https_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn net_proto_https_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn net_proto_https_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn net_proto_https_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn net_proto_https_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn net_proto_https_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn net_proto_https_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn net_proto_https_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn net_proto_https_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn net_proto_https_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn net_proto_https_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn net_proto_https_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn net_proto_https_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn net_proto_https_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn net_proto_https_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn net_proto_https_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn net_proto_https_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn net_proto_https_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn net_proto_https_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn net_proto_https_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct NetprotohttpsFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_proto_https_frame_make(size : Int) -> NetprotohttpsFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NetprotohttpsFrame::len(self : NetprotohttpsFrame) -> Int { self.size }

pub fn NetprotohttpsFrame::get(self : NetprotohttpsFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NetprotohttpsFrame::set(self : NetprotohttpsFrame, i : Int, v : Double) -> NetprotohttpsFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NetprotohttpsFrame::sum(self : NetprotohttpsFrame) -> Double { @_common.sum(self.data) }

pub fn NetprotohttpsFrame::mean(self : NetprotohttpsFrame) -> Double { @_common.mean(self.data) }

pub fn NetprotohttpsFrame::scale(self : NetprotohttpsFrame, f : Double) -> NetprotohttpsFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NetprotohttpsFrame::add(self : NetprotohttpsFrame, other : NetprotohttpsFrame) -> NetprotohttpsFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NetprotohttpsFrame::copy(self : NetprotohttpsFrame) -> NetprotohttpsFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NetprotohttpsFrame::fill(self : NetprotohttpsFrame, v : Double) -> NetprotohttpsFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NetprotohttpsFrame::min(self : NetprotohttpsFrame) -> Double { @_common.min(self.data) }

pub fn NetprotohttpsFrame::max(self : NetprotohttpsFrame) -> Double { @_common.max(self.data) }

pub fn NetprotohttpsFrame::to_string(self : NetprotohttpsFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NetprotohttpsTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_proto_https_table_make(size : Int) -> NetprotohttpsTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NetprotohttpsTable::len(self : NetprotohttpsTable) -> Int { self.size }

pub fn NetprotohttpsTable::get(self : NetprotohttpsTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NetprotohttpsTable::set(self : NetprotohttpsTable, i : Int, v : Double) -> NetprotohttpsTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NetprotohttpsTable::sum(self : NetprotohttpsTable) -> Double { @_common.sum(self.data) }

pub fn NetprotohttpsTable::mean(self : NetprotohttpsTable) -> Double { @_common.mean(self.data) }

pub fn NetprotohttpsTable::scale(self : NetprotohttpsTable, f : Double) -> NetprotohttpsTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NetprotohttpsTable::add(self : NetprotohttpsTable, other : NetprotohttpsTable) -> NetprotohttpsTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NetprotohttpsTable::copy(self : NetprotohttpsTable) -> NetprotohttpsTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NetprotohttpsTable::fill(self : NetprotohttpsTable, v : Double) -> NetprotohttpsTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NetprotohttpsTable::min(self : NetprotohttpsTable) -> Double { @_common.min(self.data) }

pub fn NetprotohttpsTable::max(self : NetprotohttpsTable) -> Double { @_common.max(self.data) }

pub fn NetprotohttpsTable::to_string(self : NetprotohttpsTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NetprotohttpsGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_proto_https_graphn_make(size : Int) -> NetprotohttpsGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NetprotohttpsGraphN::len(self : NetprotohttpsGraphN) -> Int { self.size }

pub fn NetprotohttpsGraphN::get(self : NetprotohttpsGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NetprotohttpsGraphN::set(self : NetprotohttpsGraphN, i : Int, v : Double) -> NetprotohttpsGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NetprotohttpsGraphN::sum(self : NetprotohttpsGraphN) -> Double { @_common.sum(self.data) }

pub fn NetprotohttpsGraphN::mean(self : NetprotohttpsGraphN) -> Double { @_common.mean(self.data) }

pub fn NetprotohttpsGraphN::scale(self : NetprotohttpsGraphN, f : Double) -> NetprotohttpsGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NetprotohttpsGraphN::add(self : NetprotohttpsGraphN, other : NetprotohttpsGraphN) -> NetprotohttpsGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NetprotohttpsGraphN::copy(self : NetprotohttpsGraphN) -> NetprotohttpsGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NetprotohttpsGraphN::fill(self : NetprotohttpsGraphN, v : Double) -> NetprotohttpsGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NetprotohttpsGraphN::min(self : NetprotohttpsGraphN) -> Double { @_common.min(self.data) }

pub fn NetprotohttpsGraphN::max(self : NetprotohttpsGraphN) -> Double { @_common.max(self.data) }

pub fn NetprotohttpsGraphN::to_string(self : NetprotohttpsGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NetprotohttpsNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_proto_https_node_make(size : Int) -> NetprotohttpsNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NetprotohttpsNode::len(self : NetprotohttpsNode) -> Int { self.size }

pub fn NetprotohttpsNode::get(self : NetprotohttpsNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NetprotohttpsNode::set(self : NetprotohttpsNode, i : Int, v : Double) -> NetprotohttpsNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NetprotohttpsNode::sum(self : NetprotohttpsNode) -> Double { @_common.sum(self.data) }

pub fn NetprotohttpsNode::mean(self : NetprotohttpsNode) -> Double { @_common.mean(self.data) }

pub fn NetprotohttpsNode::scale(self : NetprotohttpsNode, f : Double) -> NetprotohttpsNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NetprotohttpsNode::add(self : NetprotohttpsNode, other : NetprotohttpsNode) -> NetprotohttpsNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NetprotohttpsNode::copy(self : NetprotohttpsNode) -> NetprotohttpsNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NetprotohttpsNode::fill(self : NetprotohttpsNode, v : Double) -> NetprotohttpsNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NetprotohttpsNode::min(self : NetprotohttpsNode) -> Double { @_common.min(self.data) }

pub fn NetprotohttpsNode::max(self : NetprotohttpsNode) -> Double { @_common.max(self.data) }

pub fn NetprotohttpsNode::to_string(self : NetprotohttpsNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NetprotohttpsEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_proto_https_edge_make(size : Int) -> NetprotohttpsEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NetprotohttpsEdge::len(self : NetprotohttpsEdge) -> Int { self.size }

pub fn NetprotohttpsEdge::get(self : NetprotohttpsEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NetprotohttpsEdge::set(self : NetprotohttpsEdge, i : Int, v : Double) -> NetprotohttpsEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NetprotohttpsEdge::sum(self : NetprotohttpsEdge) -> Double { @_common.sum(self.data) }

pub fn NetprotohttpsEdge::mean(self : NetprotohttpsEdge) -> Double { @_common.mean(self.data) }

pub fn NetprotohttpsEdge::scale(self : NetprotohttpsEdge, f : Double) -> NetprotohttpsEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NetprotohttpsEdge::add(self : NetprotohttpsEdge, other : NetprotohttpsEdge) -> NetprotohttpsEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NetprotohttpsEdge::copy(self : NetprotohttpsEdge) -> NetprotohttpsEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NetprotohttpsEdge::fill(self : NetprotohttpsEdge, v : Double) -> NetprotohttpsEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NetprotohttpsEdge::min(self : NetprotohttpsEdge) -> Double { @_common.min(self.data) }

pub fn NetprotohttpsEdge::max(self : NetprotohttpsEdge) -> Double { @_common.max(self.data) }

pub fn NetprotohttpsEdge::to_string(self : NetprotohttpsEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NetprotohttpsPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_proto_https_path_make(size : Int) -> NetprotohttpsPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NetprotohttpsPath::len(self : NetprotohttpsPath) -> Int { self.size }

pub fn NetprotohttpsPath::get(self : NetprotohttpsPath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NetprotohttpsPath::set(self : NetprotohttpsPath, i : Int, v : Double) -> NetprotohttpsPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NetprotohttpsPath::sum(self : NetprotohttpsPath) -> Double { @_common.sum(self.data) }

pub fn NetprotohttpsPath::mean(self : NetprotohttpsPath) -> Double { @_common.mean(self.data) }

pub fn NetprotohttpsPath::scale(self : NetprotohttpsPath, f : Double) -> NetprotohttpsPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NetprotohttpsPath::add(self : NetprotohttpsPath, other : NetprotohttpsPath) -> NetprotohttpsPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NetprotohttpsPath::copy(self : NetprotohttpsPath) -> NetprotohttpsPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NetprotohttpsPath::fill(self : NetprotohttpsPath, v : Double) -> NetprotohttpsPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NetprotohttpsPath::min(self : NetprotohttpsPath) -> Double { @_common.min(self.data) }

pub fn NetprotohttpsPath::max(self : NetprotohttpsPath) -> Double { @_common.max(self.data) }

pub fn NetprotohttpsPath::to_string(self : NetprotohttpsPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NetprotohttpsCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_proto_https_cluster_make(size : Int) -> NetprotohttpsCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NetprotohttpsCluster::len(self : NetprotohttpsCluster) -> Int { self.size }

pub fn NetprotohttpsCluster::get(self : NetprotohttpsCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NetprotohttpsCluster::set(self : NetprotohttpsCluster, i : Int, v : Double) -> NetprotohttpsCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NetprotohttpsCluster::sum(self : NetprotohttpsCluster) -> Double { @_common.sum(self.data) }

pub fn NetprotohttpsCluster::mean(self : NetprotohttpsCluster) -> Double { @_common.mean(self.data) }

pub fn NetprotohttpsCluster::scale(self : NetprotohttpsCluster, f : Double) -> NetprotohttpsCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NetprotohttpsCluster::add(self : NetprotohttpsCluster, other : NetprotohttpsCluster) -> NetprotohttpsCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NetprotohttpsCluster::copy(self : NetprotohttpsCluster) -> NetprotohttpsCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NetprotohttpsCluster::fill(self : NetprotohttpsCluster, v : Double) -> NetprotohttpsCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NetprotohttpsCluster::min(self : NetprotohttpsCluster) -> Double { @_common.min(self.data) }

pub fn NetprotohttpsCluster::max(self : NetprotohttpsCluster) -> Double { @_common.max(self.data) }

pub fn NetprotohttpsCluster::to_string(self : NetprotohttpsCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NetprotohttpsModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_proto_https_model_make(size : Int) -> NetprotohttpsModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NetprotohttpsModel::len(self : NetprotohttpsModel) -> Int { self.size }

pub fn NetprotohttpsModel::get(self : NetprotohttpsModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NetprotohttpsModel::set(self : NetprotohttpsModel, i : Int, v : Double) -> NetprotohttpsModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NetprotohttpsModel::sum(self : NetprotohttpsModel) -> Double { @_common.sum(self.data) }

pub fn NetprotohttpsModel::mean(self : NetprotohttpsModel) -> Double { @_common.mean(self.data) }

pub fn NetprotohttpsModel::scale(self : NetprotohttpsModel, f : Double) -> NetprotohttpsModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NetprotohttpsModel::add(self : NetprotohttpsModel, other : NetprotohttpsModel) -> NetprotohttpsModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NetprotohttpsModel::copy(self : NetprotohttpsModel) -> NetprotohttpsModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NetprotohttpsModel::fill(self : NetprotohttpsModel, v : Double) -> NetprotohttpsModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NetprotohttpsModel::min(self : NetprotohttpsModel) -> Double { @_common.min(self.data) }

pub fn NetprotohttpsModel::max(self : NetprotohttpsModel) -> Double { @_common.max(self.data) }

pub fn NetprotohttpsModel::to_string(self : NetprotohttpsModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NetprotohttpsLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_proto_https_layer_make(size : Int) -> NetprotohttpsLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NetprotohttpsLayer::len(self : NetprotohttpsLayer) -> Int { self.size }

pub fn NetprotohttpsLayer::get(self : NetprotohttpsLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NetprotohttpsLayer::set(self : NetprotohttpsLayer, i : Int, v : Double) -> NetprotohttpsLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NetprotohttpsLayer::sum(self : NetprotohttpsLayer) -> Double { @_common.sum(self.data) }

pub fn NetprotohttpsLayer::mean(self : NetprotohttpsLayer) -> Double { @_common.mean(self.data) }

pub fn NetprotohttpsLayer::scale(self : NetprotohttpsLayer, f : Double) -> NetprotohttpsLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NetprotohttpsLayer::add(self : NetprotohttpsLayer, other : NetprotohttpsLayer) -> NetprotohttpsLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NetprotohttpsLayer::copy(self : NetprotohttpsLayer) -> NetprotohttpsLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NetprotohttpsLayer::fill(self : NetprotohttpsLayer, v : Double) -> NetprotohttpsLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NetprotohttpsLayer::min(self : NetprotohttpsLayer) -> Double { @_common.min(self.data) }

pub fn NetprotohttpsLayer::max(self : NetprotohttpsLayer) -> Double { @_common.max(self.data) }

pub fn NetprotohttpsLayer::to_string(self : NetprotohttpsLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NetprotohttpsBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_proto_https_buffer_make(size : Int) -> NetprotohttpsBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NetprotohttpsBuffer::len(self : NetprotohttpsBuffer) -> Int { self.size }

pub fn NetprotohttpsBuffer::get(self : NetprotohttpsBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NetprotohttpsBuffer::set(self : NetprotohttpsBuffer, i : Int, v : Double) -> NetprotohttpsBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NetprotohttpsBuffer::sum(self : NetprotohttpsBuffer) -> Double { @_common.sum(self.data) }

pub fn NetprotohttpsBuffer::mean(self : NetprotohttpsBuffer) -> Double { @_common.mean(self.data) }

pub fn NetprotohttpsBuffer::scale(self : NetprotohttpsBuffer, f : Double) -> NetprotohttpsBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NetprotohttpsBuffer::add(self : NetprotohttpsBuffer, other : NetprotohttpsBuffer) -> NetprotohttpsBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NetprotohttpsBuffer::copy(self : NetprotohttpsBuffer) -> NetprotohttpsBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NetprotohttpsBuffer::fill(self : NetprotohttpsBuffer, v : Double) -> NetprotohttpsBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NetprotohttpsBuffer::min(self : NetprotohttpsBuffer) -> Double { @_common.min(self.data) }

pub fn NetprotohttpsBuffer::max(self : NetprotohttpsBuffer) -> Double { @_common.max(self.data) }

pub fn NetprotohttpsBuffer::to_string(self : NetprotohttpsBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NetprotohttpsCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_proto_https_cursor_make(size : Int) -> NetprotohttpsCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NetprotohttpsCursor::len(self : NetprotohttpsCursor) -> Int { self.size }

pub fn NetprotohttpsCursor::get(self : NetprotohttpsCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NetprotohttpsCursor::set(self : NetprotohttpsCursor, i : Int, v : Double) -> NetprotohttpsCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NetprotohttpsCursor::sum(self : NetprotohttpsCursor) -> Double { @_common.sum(self.data) }

pub fn NetprotohttpsCursor::mean(self : NetprotohttpsCursor) -> Double { @_common.mean(self.data) }

pub fn NetprotohttpsCursor::scale(self : NetprotohttpsCursor, f : Double) -> NetprotohttpsCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NetprotohttpsCursor::add(self : NetprotohttpsCursor, other : NetprotohttpsCursor) -> NetprotohttpsCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NetprotohttpsCursor::copy(self : NetprotohttpsCursor) -> NetprotohttpsCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NetprotohttpsCursor::fill(self : NetprotohttpsCursor, v : Double) -> NetprotohttpsCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NetprotohttpsCursor::min(self : NetprotohttpsCursor) -> Double { @_common.min(self.data) }

pub fn NetprotohttpsCursor::max(self : NetprotohttpsCursor) -> Double { @_common.max(self.data) }

pub fn NetprotohttpsCursor::to_string(self : NetprotohttpsCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NetprotohttpsView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_proto_https_view_make(size : Int) -> NetprotohttpsView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NetprotohttpsView::len(self : NetprotohttpsView) -> Int { self.size }

pub fn NetprotohttpsView::get(self : NetprotohttpsView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NetprotohttpsView::set(self : NetprotohttpsView, i : Int, v : Double) -> NetprotohttpsView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NetprotohttpsView::sum(self : NetprotohttpsView) -> Double { @_common.sum(self.data) }

pub fn NetprotohttpsView::mean(self : NetprotohttpsView) -> Double { @_common.mean(self.data) }

pub fn NetprotohttpsView::scale(self : NetprotohttpsView, f : Double) -> NetprotohttpsView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NetprotohttpsView::add(self : NetprotohttpsView, other : NetprotohttpsView) -> NetprotohttpsView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NetprotohttpsView::copy(self : NetprotohttpsView) -> NetprotohttpsView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NetprotohttpsView::fill(self : NetprotohttpsView, v : Double) -> NetprotohttpsView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NetprotohttpsView::min(self : NetprotohttpsView) -> Double { @_common.min(self.data) }

pub fn NetprotohttpsView::max(self : NetprotohttpsView) -> Double { @_common.max(self.data) }

pub fn NetprotohttpsView::to_string(self : NetprotohttpsView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NetprotohttpsRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_proto_https_range_make(size : Int) -> NetprotohttpsRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NetprotohttpsRange::len(self : NetprotohttpsRange) -> Int { self.size }

pub fn NetprotohttpsRange::get(self : NetprotohttpsRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NetprotohttpsRange::set(self : NetprotohttpsRange, i : Int, v : Double) -> NetprotohttpsRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NetprotohttpsRange::sum(self : NetprotohttpsRange) -> Double { @_common.sum(self.data) }

pub fn NetprotohttpsRange::mean(self : NetprotohttpsRange) -> Double { @_common.mean(self.data) }

pub fn NetprotohttpsRange::scale(self : NetprotohttpsRange, f : Double) -> NetprotohttpsRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NetprotohttpsRange::add(self : NetprotohttpsRange, other : NetprotohttpsRange) -> NetprotohttpsRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NetprotohttpsRange::copy(self : NetprotohttpsRange) -> NetprotohttpsRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NetprotohttpsRange::fill(self : NetprotohttpsRange, v : Double) -> NetprotohttpsRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NetprotohttpsRange::min(self : NetprotohttpsRange) -> Double { @_common.min(self.data) }

pub fn NetprotohttpsRange::max(self : NetprotohttpsRange) -> Double { @_common.max(self.data) }

pub fn NetprotohttpsRange::to_string(self : NetprotohttpsRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NetprotohttpsSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_proto_https_slice_make(size : Int) -> NetprotohttpsSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NetprotohttpsSlice::len(self : NetprotohttpsSlice) -> Int { self.size }

pub fn NetprotohttpsSlice::get(self : NetprotohttpsSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NetprotohttpsSlice::set(self : NetprotohttpsSlice, i : Int, v : Double) -> NetprotohttpsSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NetprotohttpsSlice::sum(self : NetprotohttpsSlice) -> Double { @_common.sum(self.data) }

pub fn NetprotohttpsSlice::mean(self : NetprotohttpsSlice) -> Double { @_common.mean(self.data) }

pub fn NetprotohttpsSlice::scale(self : NetprotohttpsSlice, f : Double) -> NetprotohttpsSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NetprotohttpsSlice::add(self : NetprotohttpsSlice, other : NetprotohttpsSlice) -> NetprotohttpsSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NetprotohttpsSlice::copy(self : NetprotohttpsSlice) -> NetprotohttpsSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NetprotohttpsSlice::fill(self : NetprotohttpsSlice, v : Double) -> NetprotohttpsSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NetprotohttpsSlice::min(self : NetprotohttpsSlice) -> Double { @_common.min(self.data) }

pub fn NetprotohttpsSlice::max(self : NetprotohttpsSlice) -> Double { @_common.max(self.data) }

pub fn NetprotohttpsSlice::to_string(self : NetprotohttpsSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

