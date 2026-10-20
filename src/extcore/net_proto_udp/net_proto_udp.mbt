///===
/// extcore/net_proto_udp

pub(all) struct NetprotoudpPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn net_proto_udp_make_point(x : Double, y : Double) -> NetprotoudpPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn net_proto_udp_make_point3(x : Double, y : Double, z : Double) -> NetprotoudpPoint {
  { x, y, z, label: 0 }
}

pub fn NetprotoudpPoint::x(self : NetprotoudpPoint) -> Double { self.x }

pub fn NetprotoudpPoint::y(self : NetprotoudpPoint) -> Double { self.y }

pub fn NetprotoudpPoint::z(self : NetprotoudpPoint) -> Double { self.z }

pub fn NetprotoudpPoint::label(self : NetprotoudpPoint) -> Int { self.label }

pub fn NetprotoudpPoint::dist(self : NetprotoudpPoint, other : NetprotoudpPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn NetprotoudpPoint::add(self : NetprotoudpPoint, other : NetprotoudpPoint) -> NetprotoudpPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn NetprotoudpPoint::sub(self : NetprotoudpPoint, other : NetprotoudpPoint) -> NetprotoudpPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn NetprotoudpPoint::scale(self : NetprotoudpPoint, s : Double) -> NetprotoudpPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn NetprotoudpPoint::dot(self : NetprotoudpPoint, other : NetprotoudpPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn NetprotoudpPoint::cross(self : NetprotoudpPoint, other : NetprotoudpPoint) -> NetprotoudpPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn NetprotoudpPoint::norm(self : NetprotoudpPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn NetprotoudpPoint::normalize(self : NetprotoudpPoint) -> NetprotoudpPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn NetprotoudpPoint::negate(self : NetprotoudpPoint) -> NetprotoudpPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn NetprotoudpPoint::mid(self : NetprotoudpPoint, other : NetprotoudpPoint) -> NetprotoudpPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn NetprotoudpPoint::lerp(self : NetprotoudpPoint, other : NetprotoudpPoint, t : Double) -> NetprotoudpPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn NetprotoudpPoint::to_string(self : NetprotoudpPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct NetprotoudpSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn net_proto_udp_make_series(vals : Array[Double], name : String) -> NetprotoudpSeries {
  { vals, name, meta: 0 }
}

pub fn NetprotoudpSeries::len(self : NetprotoudpSeries) -> Int { self.vals.length() }

pub fn NetprotoudpSeries::sum(self : NetprotoudpSeries) -> Double { @_common.sum(self.vals) }

pub fn NetprotoudpSeries::mean(self : NetprotoudpSeries) -> Double { @_common.mean(self.vals) }

pub fn NetprotoudpSeries::min(self : NetprotoudpSeries) -> Double { @_common.min(self.vals) }

pub fn NetprotoudpSeries::max(self : NetprotoudpSeries) -> Double { @_common.max(self.vals) }

pub fn NetprotoudpSeries::range(self : NetprotoudpSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn NetprotoudpSeries::variance(self : NetprotoudpSeries) -> Double { @_common.variance(self.vals) }

pub fn NetprotoudpSeries::std(self : NetprotoudpSeries) -> Double { @_common.std(self.vals) }

pub fn NetprotoudpSeries::median(self : NetprotoudpSeries) -> Double { @_common.median(self.vals) }

pub fn NetprotoudpSeries::scale(self : NetprotoudpSeries, f : Double) -> NetprotoudpSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn NetprotoudpSeries::add(self : NetprotoudpSeries, other : NetprotoudpSeries) -> NetprotoudpSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn NetprotoudpSeries::sub(self : NetprotoudpSeries, other : NetprotoudpSeries) -> NetprotoudpSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn NetprotoudpSeries::normalize(self : NetprotoudpSeries) -> NetprotoudpSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn NetprotoudpSeries::cumsum(self : NetprotoudpSeries) -> NetprotoudpSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn NetprotoudpSeries::to_string(self : NetprotoudpSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct NetprotoudpMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn net_proto_udp_make_matrix(rows : Int, cols : Int, val : Double) -> NetprotoudpMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn net_proto_udp_matrix_identity(n : Int) -> NetprotoudpMatrix {
  let m = net_proto_udp_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn NetprotoudpMatrix::get(self : NetprotoudpMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn NetprotoudpMatrix::transpose(self : NetprotoudpMatrix) -> NetprotoudpMatrix {
  let result = net_proto_udp_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn NetprotoudpMatrix::add(self : NetprotoudpMatrix, other : NetprotoudpMatrix) -> NetprotoudpMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = net_proto_udp_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn NetprotoudpMatrix::scale(self : NetprotoudpMatrix, s : Double) -> NetprotoudpMatrix {
  let result = net_proto_udp_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn NetprotoudpMatrix::multiply(self : NetprotoudpMatrix, other : NetprotoudpMatrix) -> NetprotoudpMatrix {
  if self.cols != other.rows { return net_proto_udp_make_matrix(self.rows, other.cols, 0.0) }
  let result = net_proto_udp_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn NetprotoudpMatrix::trace(self : NetprotoudpMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn NetprotoudpMatrix::det(self : NetprotoudpMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn NetprotoudpMatrix::norm(self : NetprotoudpMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn NetprotoudpMatrix::to_string(self : NetprotoudpMatrix) -> String {
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

pub(all) struct NetprotoudpVector {
  comps : Array[Double]
  dim : Int
}

pub fn net_proto_udp_make_vector(comps : Array[Double]) -> NetprotoudpVector {
  { comps, dim: comps.length() }
}

pub fn net_proto_udp_vector_zero(dim : Int) -> NetprotoudpVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn NetprotoudpVector::add(self : NetprotoudpVector, other : NetprotoudpVector) -> NetprotoudpVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn NetprotoudpVector::sub(self : NetprotoudpVector, other : NetprotoudpVector) -> NetprotoudpVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn NetprotoudpVector::scale(self : NetprotoudpVector, s : Double) -> NetprotoudpVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn NetprotoudpVector::dot(self : NetprotoudpVector, other : NetprotoudpVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn NetprotoudpVector::norm(self : NetprotoudpVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn NetprotoudpVector::normalize(self : NetprotoudpVector) -> NetprotoudpVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn NetprotoudpVector::dist(self : NetprotoudpVector, other : NetprotoudpVector) -> Double {
  self.sub(other).norm()
}

pub fn NetprotoudpVector::to_string(self : NetprotoudpVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn net_proto_udp_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn net_proto_udp_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn net_proto_udp_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn net_proto_udp_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn net_proto_udp_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn net_proto_udp_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn net_proto_udp_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn net_proto_udp_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn net_proto_udp_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn net_proto_udp_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn net_proto_udp_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn net_proto_udp_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn net_proto_udp_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn net_proto_udp_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn net_proto_udp_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn net_proto_udp_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn net_proto_udp_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn net_proto_udp_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn net_proto_udp_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn net_proto_udp_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn net_proto_udp_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn net_proto_udp_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn net_proto_udp_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn net_proto_udp_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn net_proto_udp_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn net_proto_udp_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn net_proto_udp_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn net_proto_udp_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn net_proto_udp_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct NetprotoudpFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_proto_udp_frame_make(size : Int) -> NetprotoudpFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_proto_udp_frame_len(s : NetprotoudpFrame) -> Int { s.size }

pub fn net_proto_udp_frame_get(s : NetprotoudpFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_proto_udp_frame_set(s : NetprotoudpFrame, i : Int, v : Double) -> NetprotoudpFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn net_proto_udp_frame_sum(s : NetprotoudpFrame) -> Double { @_common.sum(s.data) }

pub fn net_proto_udp_frame_mean(s : NetprotoudpFrame) -> Double { @_common.mean(s.data) }

pub fn net_proto_udp_frame_scale(s : NetprotoudpFrame, f : Double) -> NetprotoudpFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_proto_udp_frame_add(a : NetprotoudpFrame, b : NetprotoudpFrame) -> NetprotoudpFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_proto_udp_frame_copy(s : NetprotoudpFrame) -> NetprotoudpFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_proto_udp_frame_fill(s : NetprotoudpFrame, v : Double) -> NetprotoudpFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_proto_udp_frame_min(s : NetprotoudpFrame) -> Double { @_common.min(s.data) }

pub fn net_proto_udp_frame_max(s : NetprotoudpFrame) -> Double { @_common.max(s.data) }

pub fn net_proto_udp_frame_to_string(s : NetprotoudpFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetprotoudpTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_proto_udp_table_make(size : Int) -> NetprotoudpTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_proto_udp_table_len(s : NetprotoudpTable) -> Int { s.size }

pub fn net_proto_udp_table_get(s : NetprotoudpTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_proto_udp_table_set(s : NetprotoudpTable, i : Int, v : Double) -> NetprotoudpTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn net_proto_udp_table_sum(s : NetprotoudpTable) -> Double { @_common.sum(s.data) }

pub fn net_proto_udp_table_mean(s : NetprotoudpTable) -> Double { @_common.mean(s.data) }

pub fn net_proto_udp_table_scale(s : NetprotoudpTable, f : Double) -> NetprotoudpTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_proto_udp_table_add(a : NetprotoudpTable, b : NetprotoudpTable) -> NetprotoudpTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_proto_udp_table_copy(s : NetprotoudpTable) -> NetprotoudpTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_proto_udp_table_fill(s : NetprotoudpTable, v : Double) -> NetprotoudpTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_proto_udp_table_min(s : NetprotoudpTable) -> Double { @_common.min(s.data) }

pub fn net_proto_udp_table_max(s : NetprotoudpTable) -> Double { @_common.max(s.data) }

pub fn net_proto_udp_table_to_string(s : NetprotoudpTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetprotoudpGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_proto_udp_graphn_make(size : Int) -> NetprotoudpGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_proto_udp_graphn_len(s : NetprotoudpGraphN) -> Int { s.size }

pub fn net_proto_udp_graphn_get(s : NetprotoudpGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_proto_udp_graphn_set(s : NetprotoudpGraphN, i : Int, v : Double) -> NetprotoudpGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn net_proto_udp_graphn_sum(s : NetprotoudpGraphN) -> Double { @_common.sum(s.data) }

pub fn net_proto_udp_graphn_mean(s : NetprotoudpGraphN) -> Double { @_common.mean(s.data) }

pub fn net_proto_udp_graphn_scale(s : NetprotoudpGraphN, f : Double) -> NetprotoudpGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_proto_udp_graphn_add(a : NetprotoudpGraphN, b : NetprotoudpGraphN) -> NetprotoudpGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_proto_udp_graphn_copy(s : NetprotoudpGraphN) -> NetprotoudpGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_proto_udp_graphn_fill(s : NetprotoudpGraphN, v : Double) -> NetprotoudpGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_proto_udp_graphn_min(s : NetprotoudpGraphN) -> Double { @_common.min(s.data) }

pub fn net_proto_udp_graphn_max(s : NetprotoudpGraphN) -> Double { @_common.max(s.data) }

pub fn net_proto_udp_graphn_to_string(s : NetprotoudpGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetprotoudpNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_proto_udp_node_make(size : Int) -> NetprotoudpNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_proto_udp_node_len(s : NetprotoudpNode) -> Int { s.size }

pub fn net_proto_udp_node_get(s : NetprotoudpNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_proto_udp_node_set(s : NetprotoudpNode, i : Int, v : Double) -> NetprotoudpNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn net_proto_udp_node_sum(s : NetprotoudpNode) -> Double { @_common.sum(s.data) }

pub fn net_proto_udp_node_mean(s : NetprotoudpNode) -> Double { @_common.mean(s.data) }

pub fn net_proto_udp_node_scale(s : NetprotoudpNode, f : Double) -> NetprotoudpNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_proto_udp_node_add(a : NetprotoudpNode, b : NetprotoudpNode) -> NetprotoudpNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_proto_udp_node_copy(s : NetprotoudpNode) -> NetprotoudpNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_proto_udp_node_fill(s : NetprotoudpNode, v : Double) -> NetprotoudpNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_proto_udp_node_min(s : NetprotoudpNode) -> Double { @_common.min(s.data) }

pub fn net_proto_udp_node_max(s : NetprotoudpNode) -> Double { @_common.max(s.data) }

pub fn net_proto_udp_node_to_string(s : NetprotoudpNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetprotoudpEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_proto_udp_edge_make(size : Int) -> NetprotoudpEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_proto_udp_edge_len(s : NetprotoudpEdge) -> Int { s.size }

pub fn net_proto_udp_edge_get(s : NetprotoudpEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_proto_udp_edge_set(s : NetprotoudpEdge, i : Int, v : Double) -> NetprotoudpEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn net_proto_udp_edge_sum(s : NetprotoudpEdge) -> Double { @_common.sum(s.data) }

pub fn net_proto_udp_edge_mean(s : NetprotoudpEdge) -> Double { @_common.mean(s.data) }

pub fn net_proto_udp_edge_scale(s : NetprotoudpEdge, f : Double) -> NetprotoudpEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_proto_udp_edge_add(a : NetprotoudpEdge, b : NetprotoudpEdge) -> NetprotoudpEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_proto_udp_edge_copy(s : NetprotoudpEdge) -> NetprotoudpEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_proto_udp_edge_fill(s : NetprotoudpEdge, v : Double) -> NetprotoudpEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_proto_udp_edge_min(s : NetprotoudpEdge) -> Double { @_common.min(s.data) }

pub fn net_proto_udp_edge_max(s : NetprotoudpEdge) -> Double { @_common.max(s.data) }

pub fn net_proto_udp_edge_to_string(s : NetprotoudpEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetprotoudpPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_proto_udp_path_make(size : Int) -> NetprotoudpPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_proto_udp_path_len(s : NetprotoudpPath) -> Int { s.size }

pub fn net_proto_udp_path_get(s : NetprotoudpPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_proto_udp_path_set(s : NetprotoudpPath, i : Int, v : Double) -> NetprotoudpPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn net_proto_udp_path_sum(s : NetprotoudpPath) -> Double { @_common.sum(s.data) }

pub fn net_proto_udp_path_mean(s : NetprotoudpPath) -> Double { @_common.mean(s.data) }

pub fn net_proto_udp_path_scale(s : NetprotoudpPath, f : Double) -> NetprotoudpPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_proto_udp_path_add(a : NetprotoudpPath, b : NetprotoudpPath) -> NetprotoudpPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_proto_udp_path_copy(s : NetprotoudpPath) -> NetprotoudpPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_proto_udp_path_fill(s : NetprotoudpPath, v : Double) -> NetprotoudpPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_proto_udp_path_min(s : NetprotoudpPath) -> Double { @_common.min(s.data) }

pub fn net_proto_udp_path_max(s : NetprotoudpPath) -> Double { @_common.max(s.data) }

pub fn net_proto_udp_path_to_string(s : NetprotoudpPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetprotoudpCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_proto_udp_cluster_make(size : Int) -> NetprotoudpCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_proto_udp_cluster_len(s : NetprotoudpCluster) -> Int { s.size }

pub fn net_proto_udp_cluster_get(s : NetprotoudpCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_proto_udp_cluster_set(s : NetprotoudpCluster, i : Int, v : Double) -> NetprotoudpCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn net_proto_udp_cluster_sum(s : NetprotoudpCluster) -> Double { @_common.sum(s.data) }

pub fn net_proto_udp_cluster_mean(s : NetprotoudpCluster) -> Double { @_common.mean(s.data) }

pub fn net_proto_udp_cluster_scale(s : NetprotoudpCluster, f : Double) -> NetprotoudpCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_proto_udp_cluster_add(a : NetprotoudpCluster, b : NetprotoudpCluster) -> NetprotoudpCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_proto_udp_cluster_copy(s : NetprotoudpCluster) -> NetprotoudpCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_proto_udp_cluster_fill(s : NetprotoudpCluster, v : Double) -> NetprotoudpCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_proto_udp_cluster_min(s : NetprotoudpCluster) -> Double { @_common.min(s.data) }

pub fn net_proto_udp_cluster_max(s : NetprotoudpCluster) -> Double { @_common.max(s.data) }

pub fn net_proto_udp_cluster_to_string(s : NetprotoudpCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetprotoudpModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_proto_udp_model_make(size : Int) -> NetprotoudpModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_proto_udp_model_len(s : NetprotoudpModel) -> Int { s.size }

pub fn net_proto_udp_model_get(s : NetprotoudpModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_proto_udp_model_set(s : NetprotoudpModel, i : Int, v : Double) -> NetprotoudpModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn net_proto_udp_model_sum(s : NetprotoudpModel) -> Double { @_common.sum(s.data) }

pub fn net_proto_udp_model_mean(s : NetprotoudpModel) -> Double { @_common.mean(s.data) }

pub fn net_proto_udp_model_scale(s : NetprotoudpModel, f : Double) -> NetprotoudpModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_proto_udp_model_add(a : NetprotoudpModel, b : NetprotoudpModel) -> NetprotoudpModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_proto_udp_model_copy(s : NetprotoudpModel) -> NetprotoudpModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_proto_udp_model_fill(s : NetprotoudpModel, v : Double) -> NetprotoudpModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_proto_udp_model_min(s : NetprotoudpModel) -> Double { @_common.min(s.data) }

pub fn net_proto_udp_model_max(s : NetprotoudpModel) -> Double { @_common.max(s.data) }

pub fn net_proto_udp_model_to_string(s : NetprotoudpModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetprotoudpLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_proto_udp_layer_make(size : Int) -> NetprotoudpLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_proto_udp_layer_len(s : NetprotoudpLayer) -> Int { s.size }

pub fn net_proto_udp_layer_get(s : NetprotoudpLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_proto_udp_layer_set(s : NetprotoudpLayer, i : Int, v : Double) -> NetprotoudpLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn net_proto_udp_layer_sum(s : NetprotoudpLayer) -> Double { @_common.sum(s.data) }

pub fn net_proto_udp_layer_mean(s : NetprotoudpLayer) -> Double { @_common.mean(s.data) }

pub fn net_proto_udp_layer_scale(s : NetprotoudpLayer, f : Double) -> NetprotoudpLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_proto_udp_layer_add(a : NetprotoudpLayer, b : NetprotoudpLayer) -> NetprotoudpLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_proto_udp_layer_copy(s : NetprotoudpLayer) -> NetprotoudpLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_proto_udp_layer_fill(s : NetprotoudpLayer, v : Double) -> NetprotoudpLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_proto_udp_layer_min(s : NetprotoudpLayer) -> Double { @_common.min(s.data) }

pub fn net_proto_udp_layer_max(s : NetprotoudpLayer) -> Double { @_common.max(s.data) }

pub fn net_proto_udp_layer_to_string(s : NetprotoudpLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetprotoudpBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_proto_udp_buffer_make(size : Int) -> NetprotoudpBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_proto_udp_buffer_len(s : NetprotoudpBuffer) -> Int { s.size }

pub fn net_proto_udp_buffer_get(s : NetprotoudpBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_proto_udp_buffer_set(s : NetprotoudpBuffer, i : Int, v : Double) -> NetprotoudpBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn net_proto_udp_buffer_sum(s : NetprotoudpBuffer) -> Double { @_common.sum(s.data) }

pub fn net_proto_udp_buffer_mean(s : NetprotoudpBuffer) -> Double { @_common.mean(s.data) }

pub fn net_proto_udp_buffer_scale(s : NetprotoudpBuffer, f : Double) -> NetprotoudpBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_proto_udp_buffer_add(a : NetprotoudpBuffer, b : NetprotoudpBuffer) -> NetprotoudpBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_proto_udp_buffer_copy(s : NetprotoudpBuffer) -> NetprotoudpBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_proto_udp_buffer_fill(s : NetprotoudpBuffer, v : Double) -> NetprotoudpBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_proto_udp_buffer_min(s : NetprotoudpBuffer) -> Double { @_common.min(s.data) }

pub fn net_proto_udp_buffer_max(s : NetprotoudpBuffer) -> Double { @_common.max(s.data) }

pub fn net_proto_udp_buffer_to_string(s : NetprotoudpBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetprotoudpCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_proto_udp_cursor_make(size : Int) -> NetprotoudpCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_proto_udp_cursor_len(s : NetprotoudpCursor) -> Int { s.size }

pub fn net_proto_udp_cursor_get(s : NetprotoudpCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_proto_udp_cursor_set(s : NetprotoudpCursor, i : Int, v : Double) -> NetprotoudpCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn net_proto_udp_cursor_sum(s : NetprotoudpCursor) -> Double { @_common.sum(s.data) }

pub fn net_proto_udp_cursor_mean(s : NetprotoudpCursor) -> Double { @_common.mean(s.data) }

pub fn net_proto_udp_cursor_scale(s : NetprotoudpCursor, f : Double) -> NetprotoudpCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_proto_udp_cursor_add(a : NetprotoudpCursor, b : NetprotoudpCursor) -> NetprotoudpCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_proto_udp_cursor_copy(s : NetprotoudpCursor) -> NetprotoudpCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_proto_udp_cursor_fill(s : NetprotoudpCursor, v : Double) -> NetprotoudpCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_proto_udp_cursor_min(s : NetprotoudpCursor) -> Double { @_common.min(s.data) }

pub fn net_proto_udp_cursor_max(s : NetprotoudpCursor) -> Double { @_common.max(s.data) }

pub fn net_proto_udp_cursor_to_string(s : NetprotoudpCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetprotoudpView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_proto_udp_view_make(size : Int) -> NetprotoudpView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_proto_udp_view_len(s : NetprotoudpView) -> Int { s.size }

pub fn net_proto_udp_view_get(s : NetprotoudpView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_proto_udp_view_set(s : NetprotoudpView, i : Int, v : Double) -> NetprotoudpView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn net_proto_udp_view_sum(s : NetprotoudpView) -> Double { @_common.sum(s.data) }

pub fn net_proto_udp_view_mean(s : NetprotoudpView) -> Double { @_common.mean(s.data) }

pub fn net_proto_udp_view_scale(s : NetprotoudpView, f : Double) -> NetprotoudpView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_proto_udp_view_add(a : NetprotoudpView, b : NetprotoudpView) -> NetprotoudpView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_proto_udp_view_copy(s : NetprotoudpView) -> NetprotoudpView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_proto_udp_view_fill(s : NetprotoudpView, v : Double) -> NetprotoudpView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_proto_udp_view_min(s : NetprotoudpView) -> Double { @_common.min(s.data) }

pub fn net_proto_udp_view_max(s : NetprotoudpView) -> Double { @_common.max(s.data) }

pub fn net_proto_udp_view_to_string(s : NetprotoudpView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetprotoudpRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_proto_udp_range_make(size : Int) -> NetprotoudpRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_proto_udp_range_len(s : NetprotoudpRange) -> Int { s.size }

pub fn net_proto_udp_range_get(s : NetprotoudpRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_proto_udp_range_set(s : NetprotoudpRange, i : Int, v : Double) -> NetprotoudpRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn net_proto_udp_range_sum(s : NetprotoudpRange) -> Double { @_common.sum(s.data) }

pub fn net_proto_udp_range_mean(s : NetprotoudpRange) -> Double { @_common.mean(s.data) }

pub fn net_proto_udp_range_scale(s : NetprotoudpRange, f : Double) -> NetprotoudpRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_proto_udp_range_add(a : NetprotoudpRange, b : NetprotoudpRange) -> NetprotoudpRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_proto_udp_range_copy(s : NetprotoudpRange) -> NetprotoudpRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_proto_udp_range_fill(s : NetprotoudpRange, v : Double) -> NetprotoudpRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_proto_udp_range_min(s : NetprotoudpRange) -> Double { @_common.min(s.data) }

pub fn net_proto_udp_range_max(s : NetprotoudpRange) -> Double { @_common.max(s.data) }

pub fn net_proto_udp_range_to_string(s : NetprotoudpRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetprotoudpSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_proto_udp_slice_make(size : Int) -> NetprotoudpSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_proto_udp_slice_len(s : NetprotoudpSlice) -> Int { s.size }

pub fn net_proto_udp_slice_get(s : NetprotoudpSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_proto_udp_slice_set(s : NetprotoudpSlice, i : Int, v : Double) -> NetprotoudpSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn net_proto_udp_slice_sum(s : NetprotoudpSlice) -> Double { @_common.sum(s.data) }

pub fn net_proto_udp_slice_mean(s : NetprotoudpSlice) -> Double { @_common.mean(s.data) }

pub fn net_proto_udp_slice_scale(s : NetprotoudpSlice, f : Double) -> NetprotoudpSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_proto_udp_slice_add(a : NetprotoudpSlice, b : NetprotoudpSlice) -> NetprotoudpSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_proto_udp_slice_copy(s : NetprotoudpSlice) -> NetprotoudpSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_proto_udp_slice_fill(s : NetprotoudpSlice, v : Double) -> NetprotoudpSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_proto_udp_slice_min(s : NetprotoudpSlice) -> Double { @_common.min(s.data) }

pub fn net_proto_udp_slice_max(s : NetprotoudpSlice) -> Double { @_common.max(s.data) }

pub fn net_proto_udp_slice_to_string(s : NetprotoudpSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

