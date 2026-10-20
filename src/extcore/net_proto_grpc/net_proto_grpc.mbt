///===
/// extcore/net_proto_grpc

pub(all) struct NetprotogrpcPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn net_proto_grpc_make_point(x : Double, y : Double) -> NetprotogrpcPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn net_proto_grpc_make_point3(x : Double, y : Double, z : Double) -> NetprotogrpcPoint {
  { x, y, z, label: 0 }
}

pub fn NetprotogrpcPoint::x(self : NetprotogrpcPoint) -> Double { self.x }

pub fn NetprotogrpcPoint::y(self : NetprotogrpcPoint) -> Double { self.y }

pub fn NetprotogrpcPoint::z(self : NetprotogrpcPoint) -> Double { self.z }

pub fn NetprotogrpcPoint::label(self : NetprotogrpcPoint) -> Int { self.label }

pub fn NetprotogrpcPoint::dist(self : NetprotogrpcPoint, other : NetprotogrpcPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn NetprotogrpcPoint::add(self : NetprotogrpcPoint, other : NetprotogrpcPoint) -> NetprotogrpcPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn NetprotogrpcPoint::sub(self : NetprotogrpcPoint, other : NetprotogrpcPoint) -> NetprotogrpcPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn NetprotogrpcPoint::scale(self : NetprotogrpcPoint, s : Double) -> NetprotogrpcPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn NetprotogrpcPoint::dot(self : NetprotogrpcPoint, other : NetprotogrpcPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn NetprotogrpcPoint::cross(self : NetprotogrpcPoint, other : NetprotogrpcPoint) -> NetprotogrpcPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn NetprotogrpcPoint::norm(self : NetprotogrpcPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn NetprotogrpcPoint::normalize(self : NetprotogrpcPoint) -> NetprotogrpcPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn NetprotogrpcPoint::negate(self : NetprotogrpcPoint) -> NetprotogrpcPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn NetprotogrpcPoint::mid(self : NetprotogrpcPoint, other : NetprotogrpcPoint) -> NetprotogrpcPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn NetprotogrpcPoint::lerp(self : NetprotogrpcPoint, other : NetprotogrpcPoint, t : Double) -> NetprotogrpcPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn NetprotogrpcPoint::to_string(self : NetprotogrpcPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct NetprotogrpcSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn net_proto_grpc_make_series(vals : Array[Double], name : String) -> NetprotogrpcSeries {
  { vals, name, meta: 0 }
}

pub fn NetprotogrpcSeries::len(self : NetprotogrpcSeries) -> Int { self.vals.length() }

pub fn NetprotogrpcSeries::sum(self : NetprotogrpcSeries) -> Double { @_common.sum(self.vals) }

pub fn NetprotogrpcSeries::mean(self : NetprotogrpcSeries) -> Double { @_common.mean(self.vals) }

pub fn NetprotogrpcSeries::min(self : NetprotogrpcSeries) -> Double { @_common.min(self.vals) }

pub fn NetprotogrpcSeries::max(self : NetprotogrpcSeries) -> Double { @_common.max(self.vals) }

pub fn NetprotogrpcSeries::range(self : NetprotogrpcSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn NetprotogrpcSeries::variance(self : NetprotogrpcSeries) -> Double { @_common.variance(self.vals) }

pub fn NetprotogrpcSeries::std(self : NetprotogrpcSeries) -> Double { @_common.std(self.vals) }

pub fn NetprotogrpcSeries::median(self : NetprotogrpcSeries) -> Double { @_common.median(self.vals) }

pub fn NetprotogrpcSeries::scale(self : NetprotogrpcSeries, f : Double) -> NetprotogrpcSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn NetprotogrpcSeries::add(self : NetprotogrpcSeries, other : NetprotogrpcSeries) -> NetprotogrpcSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn NetprotogrpcSeries::sub(self : NetprotogrpcSeries, other : NetprotogrpcSeries) -> NetprotogrpcSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn NetprotogrpcSeries::normalize(self : NetprotogrpcSeries) -> NetprotogrpcSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn NetprotogrpcSeries::cumsum(self : NetprotogrpcSeries) -> NetprotogrpcSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn NetprotogrpcSeries::to_string(self : NetprotogrpcSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct NetprotogrpcMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn net_proto_grpc_make_matrix(rows : Int, cols : Int, val : Double) -> NetprotogrpcMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn net_proto_grpc_matrix_identity(n : Int) -> NetprotogrpcMatrix {
  let m = net_proto_grpc_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn NetprotogrpcMatrix::get(self : NetprotogrpcMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn NetprotogrpcMatrix::transpose(self : NetprotogrpcMatrix) -> NetprotogrpcMatrix {
  let result = net_proto_grpc_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn NetprotogrpcMatrix::add(self : NetprotogrpcMatrix, other : NetprotogrpcMatrix) -> NetprotogrpcMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = net_proto_grpc_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn NetprotogrpcMatrix::scale(self : NetprotogrpcMatrix, s : Double) -> NetprotogrpcMatrix {
  let result = net_proto_grpc_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn NetprotogrpcMatrix::multiply(self : NetprotogrpcMatrix, other : NetprotogrpcMatrix) -> NetprotogrpcMatrix {
  if self.cols != other.rows { return net_proto_grpc_make_matrix(self.rows, other.cols, 0.0) }
  let result = net_proto_grpc_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn NetprotogrpcMatrix::trace(self : NetprotogrpcMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn NetprotogrpcMatrix::det(self : NetprotogrpcMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn NetprotogrpcMatrix::norm(self : NetprotogrpcMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn NetprotogrpcMatrix::to_string(self : NetprotogrpcMatrix) -> String {
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

pub(all) struct NetprotogrpcVector {
  comps : Array[Double]
  dim : Int
}

pub fn net_proto_grpc_make_vector(comps : Array[Double]) -> NetprotogrpcVector {
  { comps, dim: comps.length() }
}

pub fn net_proto_grpc_vector_zero(dim : Int) -> NetprotogrpcVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn NetprotogrpcVector::add(self : NetprotogrpcVector, other : NetprotogrpcVector) -> NetprotogrpcVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn NetprotogrpcVector::sub(self : NetprotogrpcVector, other : NetprotogrpcVector) -> NetprotogrpcVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn NetprotogrpcVector::scale(self : NetprotogrpcVector, s : Double) -> NetprotogrpcVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn NetprotogrpcVector::dot(self : NetprotogrpcVector, other : NetprotogrpcVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn NetprotogrpcVector::norm(self : NetprotogrpcVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn NetprotogrpcVector::normalize(self : NetprotogrpcVector) -> NetprotogrpcVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn NetprotogrpcVector::dist(self : NetprotogrpcVector, other : NetprotogrpcVector) -> Double {
  self.sub(other).norm()
}

pub fn NetprotogrpcVector::to_string(self : NetprotogrpcVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn net_proto_grpc_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn net_proto_grpc_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn net_proto_grpc_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn net_proto_grpc_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn net_proto_grpc_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn net_proto_grpc_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn net_proto_grpc_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn net_proto_grpc_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn net_proto_grpc_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn net_proto_grpc_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn net_proto_grpc_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn net_proto_grpc_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn net_proto_grpc_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn net_proto_grpc_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn net_proto_grpc_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn net_proto_grpc_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn net_proto_grpc_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn net_proto_grpc_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn net_proto_grpc_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn net_proto_grpc_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn net_proto_grpc_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn net_proto_grpc_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn net_proto_grpc_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn net_proto_grpc_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn net_proto_grpc_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn net_proto_grpc_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn net_proto_grpc_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn net_proto_grpc_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn net_proto_grpc_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct NetprotogrpcFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_proto_grpc_frame_make(size : Int) -> NetprotogrpcFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_proto_grpc_frame_len(s : NetprotogrpcFrame) -> Int { s.size }

pub fn net_proto_grpc_frame_get(s : NetprotogrpcFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_proto_grpc_frame_set(s : NetprotogrpcFrame, i : Int, v : Double) -> NetprotogrpcFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn net_proto_grpc_frame_sum(s : NetprotogrpcFrame) -> Double { @_common.sum(s.data) }

pub fn net_proto_grpc_frame_mean(s : NetprotogrpcFrame) -> Double { @_common.mean(s.data) }

pub fn net_proto_grpc_frame_scale(s : NetprotogrpcFrame, f : Double) -> NetprotogrpcFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_proto_grpc_frame_add(a : NetprotogrpcFrame, b : NetprotogrpcFrame) -> NetprotogrpcFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_proto_grpc_frame_copy(s : NetprotogrpcFrame) -> NetprotogrpcFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_proto_grpc_frame_fill(s : NetprotogrpcFrame, v : Double) -> NetprotogrpcFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_proto_grpc_frame_min(s : NetprotogrpcFrame) -> Double { @_common.min(s.data) }

pub fn net_proto_grpc_frame_max(s : NetprotogrpcFrame) -> Double { @_common.max(s.data) }

pub fn net_proto_grpc_frame_to_string(s : NetprotogrpcFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetprotogrpcTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_proto_grpc_table_make(size : Int) -> NetprotogrpcTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_proto_grpc_table_len(s : NetprotogrpcTable) -> Int { s.size }

pub fn net_proto_grpc_table_get(s : NetprotogrpcTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_proto_grpc_table_set(s : NetprotogrpcTable, i : Int, v : Double) -> NetprotogrpcTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn net_proto_grpc_table_sum(s : NetprotogrpcTable) -> Double { @_common.sum(s.data) }

pub fn net_proto_grpc_table_mean(s : NetprotogrpcTable) -> Double { @_common.mean(s.data) }

pub fn net_proto_grpc_table_scale(s : NetprotogrpcTable, f : Double) -> NetprotogrpcTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_proto_grpc_table_add(a : NetprotogrpcTable, b : NetprotogrpcTable) -> NetprotogrpcTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_proto_grpc_table_copy(s : NetprotogrpcTable) -> NetprotogrpcTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_proto_grpc_table_fill(s : NetprotogrpcTable, v : Double) -> NetprotogrpcTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_proto_grpc_table_min(s : NetprotogrpcTable) -> Double { @_common.min(s.data) }

pub fn net_proto_grpc_table_max(s : NetprotogrpcTable) -> Double { @_common.max(s.data) }

pub fn net_proto_grpc_table_to_string(s : NetprotogrpcTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetprotogrpcGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_proto_grpc_graphn_make(size : Int) -> NetprotogrpcGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_proto_grpc_graphn_len(s : NetprotogrpcGraphN) -> Int { s.size }

pub fn net_proto_grpc_graphn_get(s : NetprotogrpcGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_proto_grpc_graphn_set(s : NetprotogrpcGraphN, i : Int, v : Double) -> NetprotogrpcGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn net_proto_grpc_graphn_sum(s : NetprotogrpcGraphN) -> Double { @_common.sum(s.data) }

pub fn net_proto_grpc_graphn_mean(s : NetprotogrpcGraphN) -> Double { @_common.mean(s.data) }

pub fn net_proto_grpc_graphn_scale(s : NetprotogrpcGraphN, f : Double) -> NetprotogrpcGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_proto_grpc_graphn_add(a : NetprotogrpcGraphN, b : NetprotogrpcGraphN) -> NetprotogrpcGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_proto_grpc_graphn_copy(s : NetprotogrpcGraphN) -> NetprotogrpcGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_proto_grpc_graphn_fill(s : NetprotogrpcGraphN, v : Double) -> NetprotogrpcGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_proto_grpc_graphn_min(s : NetprotogrpcGraphN) -> Double { @_common.min(s.data) }

pub fn net_proto_grpc_graphn_max(s : NetprotogrpcGraphN) -> Double { @_common.max(s.data) }

pub fn net_proto_grpc_graphn_to_string(s : NetprotogrpcGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetprotogrpcNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_proto_grpc_node_make(size : Int) -> NetprotogrpcNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_proto_grpc_node_len(s : NetprotogrpcNode) -> Int { s.size }

pub fn net_proto_grpc_node_get(s : NetprotogrpcNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_proto_grpc_node_set(s : NetprotogrpcNode, i : Int, v : Double) -> NetprotogrpcNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn net_proto_grpc_node_sum(s : NetprotogrpcNode) -> Double { @_common.sum(s.data) }

pub fn net_proto_grpc_node_mean(s : NetprotogrpcNode) -> Double { @_common.mean(s.data) }

pub fn net_proto_grpc_node_scale(s : NetprotogrpcNode, f : Double) -> NetprotogrpcNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_proto_grpc_node_add(a : NetprotogrpcNode, b : NetprotogrpcNode) -> NetprotogrpcNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_proto_grpc_node_copy(s : NetprotogrpcNode) -> NetprotogrpcNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_proto_grpc_node_fill(s : NetprotogrpcNode, v : Double) -> NetprotogrpcNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_proto_grpc_node_min(s : NetprotogrpcNode) -> Double { @_common.min(s.data) }

pub fn net_proto_grpc_node_max(s : NetprotogrpcNode) -> Double { @_common.max(s.data) }

pub fn net_proto_grpc_node_to_string(s : NetprotogrpcNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetprotogrpcEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_proto_grpc_edge_make(size : Int) -> NetprotogrpcEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_proto_grpc_edge_len(s : NetprotogrpcEdge) -> Int { s.size }

pub fn net_proto_grpc_edge_get(s : NetprotogrpcEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_proto_grpc_edge_set(s : NetprotogrpcEdge, i : Int, v : Double) -> NetprotogrpcEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn net_proto_grpc_edge_sum(s : NetprotogrpcEdge) -> Double { @_common.sum(s.data) }

pub fn net_proto_grpc_edge_mean(s : NetprotogrpcEdge) -> Double { @_common.mean(s.data) }

pub fn net_proto_grpc_edge_scale(s : NetprotogrpcEdge, f : Double) -> NetprotogrpcEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_proto_grpc_edge_add(a : NetprotogrpcEdge, b : NetprotogrpcEdge) -> NetprotogrpcEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_proto_grpc_edge_copy(s : NetprotogrpcEdge) -> NetprotogrpcEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_proto_grpc_edge_fill(s : NetprotogrpcEdge, v : Double) -> NetprotogrpcEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_proto_grpc_edge_min(s : NetprotogrpcEdge) -> Double { @_common.min(s.data) }

pub fn net_proto_grpc_edge_max(s : NetprotogrpcEdge) -> Double { @_common.max(s.data) }

pub fn net_proto_grpc_edge_to_string(s : NetprotogrpcEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetprotogrpcPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_proto_grpc_path_make(size : Int) -> NetprotogrpcPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_proto_grpc_path_len(s : NetprotogrpcPath) -> Int { s.size }

pub fn net_proto_grpc_path_get(s : NetprotogrpcPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_proto_grpc_path_set(s : NetprotogrpcPath, i : Int, v : Double) -> NetprotogrpcPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn net_proto_grpc_path_sum(s : NetprotogrpcPath) -> Double { @_common.sum(s.data) }

pub fn net_proto_grpc_path_mean(s : NetprotogrpcPath) -> Double { @_common.mean(s.data) }

pub fn net_proto_grpc_path_scale(s : NetprotogrpcPath, f : Double) -> NetprotogrpcPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_proto_grpc_path_add(a : NetprotogrpcPath, b : NetprotogrpcPath) -> NetprotogrpcPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_proto_grpc_path_copy(s : NetprotogrpcPath) -> NetprotogrpcPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_proto_grpc_path_fill(s : NetprotogrpcPath, v : Double) -> NetprotogrpcPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_proto_grpc_path_min(s : NetprotogrpcPath) -> Double { @_common.min(s.data) }

pub fn net_proto_grpc_path_max(s : NetprotogrpcPath) -> Double { @_common.max(s.data) }

pub fn net_proto_grpc_path_to_string(s : NetprotogrpcPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetprotogrpcCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_proto_grpc_cluster_make(size : Int) -> NetprotogrpcCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_proto_grpc_cluster_len(s : NetprotogrpcCluster) -> Int { s.size }

pub fn net_proto_grpc_cluster_get(s : NetprotogrpcCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_proto_grpc_cluster_set(s : NetprotogrpcCluster, i : Int, v : Double) -> NetprotogrpcCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn net_proto_grpc_cluster_sum(s : NetprotogrpcCluster) -> Double { @_common.sum(s.data) }

pub fn net_proto_grpc_cluster_mean(s : NetprotogrpcCluster) -> Double { @_common.mean(s.data) }

pub fn net_proto_grpc_cluster_scale(s : NetprotogrpcCluster, f : Double) -> NetprotogrpcCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_proto_grpc_cluster_add(a : NetprotogrpcCluster, b : NetprotogrpcCluster) -> NetprotogrpcCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_proto_grpc_cluster_copy(s : NetprotogrpcCluster) -> NetprotogrpcCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_proto_grpc_cluster_fill(s : NetprotogrpcCluster, v : Double) -> NetprotogrpcCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_proto_grpc_cluster_min(s : NetprotogrpcCluster) -> Double { @_common.min(s.data) }

pub fn net_proto_grpc_cluster_max(s : NetprotogrpcCluster) -> Double { @_common.max(s.data) }

pub fn net_proto_grpc_cluster_to_string(s : NetprotogrpcCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetprotogrpcModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_proto_grpc_model_make(size : Int) -> NetprotogrpcModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_proto_grpc_model_len(s : NetprotogrpcModel) -> Int { s.size }

pub fn net_proto_grpc_model_get(s : NetprotogrpcModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_proto_grpc_model_set(s : NetprotogrpcModel, i : Int, v : Double) -> NetprotogrpcModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn net_proto_grpc_model_sum(s : NetprotogrpcModel) -> Double { @_common.sum(s.data) }

pub fn net_proto_grpc_model_mean(s : NetprotogrpcModel) -> Double { @_common.mean(s.data) }

pub fn net_proto_grpc_model_scale(s : NetprotogrpcModel, f : Double) -> NetprotogrpcModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_proto_grpc_model_add(a : NetprotogrpcModel, b : NetprotogrpcModel) -> NetprotogrpcModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_proto_grpc_model_copy(s : NetprotogrpcModel) -> NetprotogrpcModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_proto_grpc_model_fill(s : NetprotogrpcModel, v : Double) -> NetprotogrpcModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_proto_grpc_model_min(s : NetprotogrpcModel) -> Double { @_common.min(s.data) }

pub fn net_proto_grpc_model_max(s : NetprotogrpcModel) -> Double { @_common.max(s.data) }

pub fn net_proto_grpc_model_to_string(s : NetprotogrpcModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetprotogrpcLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_proto_grpc_layer_make(size : Int) -> NetprotogrpcLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_proto_grpc_layer_len(s : NetprotogrpcLayer) -> Int { s.size }

pub fn net_proto_grpc_layer_get(s : NetprotogrpcLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_proto_grpc_layer_set(s : NetprotogrpcLayer, i : Int, v : Double) -> NetprotogrpcLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn net_proto_grpc_layer_sum(s : NetprotogrpcLayer) -> Double { @_common.sum(s.data) }

pub fn net_proto_grpc_layer_mean(s : NetprotogrpcLayer) -> Double { @_common.mean(s.data) }

pub fn net_proto_grpc_layer_scale(s : NetprotogrpcLayer, f : Double) -> NetprotogrpcLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_proto_grpc_layer_add(a : NetprotogrpcLayer, b : NetprotogrpcLayer) -> NetprotogrpcLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_proto_grpc_layer_copy(s : NetprotogrpcLayer) -> NetprotogrpcLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_proto_grpc_layer_fill(s : NetprotogrpcLayer, v : Double) -> NetprotogrpcLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_proto_grpc_layer_min(s : NetprotogrpcLayer) -> Double { @_common.min(s.data) }

pub fn net_proto_grpc_layer_max(s : NetprotogrpcLayer) -> Double { @_common.max(s.data) }

pub fn net_proto_grpc_layer_to_string(s : NetprotogrpcLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetprotogrpcBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_proto_grpc_buffer_make(size : Int) -> NetprotogrpcBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_proto_grpc_buffer_len(s : NetprotogrpcBuffer) -> Int { s.size }

pub fn net_proto_grpc_buffer_get(s : NetprotogrpcBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_proto_grpc_buffer_set(s : NetprotogrpcBuffer, i : Int, v : Double) -> NetprotogrpcBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn net_proto_grpc_buffer_sum(s : NetprotogrpcBuffer) -> Double { @_common.sum(s.data) }

pub fn net_proto_grpc_buffer_mean(s : NetprotogrpcBuffer) -> Double { @_common.mean(s.data) }

pub fn net_proto_grpc_buffer_scale(s : NetprotogrpcBuffer, f : Double) -> NetprotogrpcBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_proto_grpc_buffer_add(a : NetprotogrpcBuffer, b : NetprotogrpcBuffer) -> NetprotogrpcBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_proto_grpc_buffer_copy(s : NetprotogrpcBuffer) -> NetprotogrpcBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_proto_grpc_buffer_fill(s : NetprotogrpcBuffer, v : Double) -> NetprotogrpcBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_proto_grpc_buffer_min(s : NetprotogrpcBuffer) -> Double { @_common.min(s.data) }

pub fn net_proto_grpc_buffer_max(s : NetprotogrpcBuffer) -> Double { @_common.max(s.data) }

pub fn net_proto_grpc_buffer_to_string(s : NetprotogrpcBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetprotogrpcCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_proto_grpc_cursor_make(size : Int) -> NetprotogrpcCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_proto_grpc_cursor_len(s : NetprotogrpcCursor) -> Int { s.size }

pub fn net_proto_grpc_cursor_get(s : NetprotogrpcCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_proto_grpc_cursor_set(s : NetprotogrpcCursor, i : Int, v : Double) -> NetprotogrpcCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn net_proto_grpc_cursor_sum(s : NetprotogrpcCursor) -> Double { @_common.sum(s.data) }

pub fn net_proto_grpc_cursor_mean(s : NetprotogrpcCursor) -> Double { @_common.mean(s.data) }

pub fn net_proto_grpc_cursor_scale(s : NetprotogrpcCursor, f : Double) -> NetprotogrpcCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_proto_grpc_cursor_add(a : NetprotogrpcCursor, b : NetprotogrpcCursor) -> NetprotogrpcCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_proto_grpc_cursor_copy(s : NetprotogrpcCursor) -> NetprotogrpcCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_proto_grpc_cursor_fill(s : NetprotogrpcCursor, v : Double) -> NetprotogrpcCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_proto_grpc_cursor_min(s : NetprotogrpcCursor) -> Double { @_common.min(s.data) }

pub fn net_proto_grpc_cursor_max(s : NetprotogrpcCursor) -> Double { @_common.max(s.data) }

pub fn net_proto_grpc_cursor_to_string(s : NetprotogrpcCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetprotogrpcView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_proto_grpc_view_make(size : Int) -> NetprotogrpcView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_proto_grpc_view_len(s : NetprotogrpcView) -> Int { s.size }

pub fn net_proto_grpc_view_get(s : NetprotogrpcView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_proto_grpc_view_set(s : NetprotogrpcView, i : Int, v : Double) -> NetprotogrpcView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn net_proto_grpc_view_sum(s : NetprotogrpcView) -> Double { @_common.sum(s.data) }

pub fn net_proto_grpc_view_mean(s : NetprotogrpcView) -> Double { @_common.mean(s.data) }

pub fn net_proto_grpc_view_scale(s : NetprotogrpcView, f : Double) -> NetprotogrpcView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_proto_grpc_view_add(a : NetprotogrpcView, b : NetprotogrpcView) -> NetprotogrpcView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_proto_grpc_view_copy(s : NetprotogrpcView) -> NetprotogrpcView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_proto_grpc_view_fill(s : NetprotogrpcView, v : Double) -> NetprotogrpcView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_proto_grpc_view_min(s : NetprotogrpcView) -> Double { @_common.min(s.data) }

pub fn net_proto_grpc_view_max(s : NetprotogrpcView) -> Double { @_common.max(s.data) }

pub fn net_proto_grpc_view_to_string(s : NetprotogrpcView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetprotogrpcRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_proto_grpc_range_make(size : Int) -> NetprotogrpcRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_proto_grpc_range_len(s : NetprotogrpcRange) -> Int { s.size }

pub fn net_proto_grpc_range_get(s : NetprotogrpcRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_proto_grpc_range_set(s : NetprotogrpcRange, i : Int, v : Double) -> NetprotogrpcRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn net_proto_grpc_range_sum(s : NetprotogrpcRange) -> Double { @_common.sum(s.data) }

pub fn net_proto_grpc_range_mean(s : NetprotogrpcRange) -> Double { @_common.mean(s.data) }

pub fn net_proto_grpc_range_scale(s : NetprotogrpcRange, f : Double) -> NetprotogrpcRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_proto_grpc_range_add(a : NetprotogrpcRange, b : NetprotogrpcRange) -> NetprotogrpcRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_proto_grpc_range_copy(s : NetprotogrpcRange) -> NetprotogrpcRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_proto_grpc_range_fill(s : NetprotogrpcRange, v : Double) -> NetprotogrpcRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_proto_grpc_range_min(s : NetprotogrpcRange) -> Double { @_common.min(s.data) }

pub fn net_proto_grpc_range_max(s : NetprotogrpcRange) -> Double { @_common.max(s.data) }

pub fn net_proto_grpc_range_to_string(s : NetprotogrpcRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetprotogrpcSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_proto_grpc_slice_make(size : Int) -> NetprotogrpcSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_proto_grpc_slice_len(s : NetprotogrpcSlice) -> Int { s.size }

pub fn net_proto_grpc_slice_get(s : NetprotogrpcSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_proto_grpc_slice_set(s : NetprotogrpcSlice, i : Int, v : Double) -> NetprotogrpcSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn net_proto_grpc_slice_sum(s : NetprotogrpcSlice) -> Double { @_common.sum(s.data) }

pub fn net_proto_grpc_slice_mean(s : NetprotogrpcSlice) -> Double { @_common.mean(s.data) }

pub fn net_proto_grpc_slice_scale(s : NetprotogrpcSlice, f : Double) -> NetprotogrpcSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_proto_grpc_slice_add(a : NetprotogrpcSlice, b : NetprotogrpcSlice) -> NetprotogrpcSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_proto_grpc_slice_copy(s : NetprotogrpcSlice) -> NetprotogrpcSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_proto_grpc_slice_fill(s : NetprotogrpcSlice, v : Double) -> NetprotogrpcSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_proto_grpc_slice_min(s : NetprotogrpcSlice) -> Double { @_common.min(s.data) }

pub fn net_proto_grpc_slice_max(s : NetprotogrpcSlice) -> Double { @_common.max(s.data) }

pub fn net_proto_grpc_slice_to_string(s : NetprotogrpcSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

