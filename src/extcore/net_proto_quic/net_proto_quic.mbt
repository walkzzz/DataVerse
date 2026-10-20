///===
/// extcore/net_proto_quic

pub(all) struct NetprotoquicPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn net_proto_quic_make_point(x : Double, y : Double) -> NetprotoquicPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn net_proto_quic_make_point3(x : Double, y : Double, z : Double) -> NetprotoquicPoint {
  { x, y, z, label: 0 }
}

pub fn NetprotoquicPoint::x(self : NetprotoquicPoint) -> Double { self.x }

pub fn NetprotoquicPoint::y(self : NetprotoquicPoint) -> Double { self.y }

pub fn NetprotoquicPoint::z(self : NetprotoquicPoint) -> Double { self.z }

pub fn NetprotoquicPoint::label(self : NetprotoquicPoint) -> Int { self.label }

pub fn NetprotoquicPoint::dist(self : NetprotoquicPoint, other : NetprotoquicPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn NetprotoquicPoint::add(self : NetprotoquicPoint, other : NetprotoquicPoint) -> NetprotoquicPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn NetprotoquicPoint::sub(self : NetprotoquicPoint, other : NetprotoquicPoint) -> NetprotoquicPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn NetprotoquicPoint::scale(self : NetprotoquicPoint, s : Double) -> NetprotoquicPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn NetprotoquicPoint::dot(self : NetprotoquicPoint, other : NetprotoquicPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn NetprotoquicPoint::cross(self : NetprotoquicPoint, other : NetprotoquicPoint) -> NetprotoquicPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn NetprotoquicPoint::norm(self : NetprotoquicPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn NetprotoquicPoint::normalize(self : NetprotoquicPoint) -> NetprotoquicPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn NetprotoquicPoint::negate(self : NetprotoquicPoint) -> NetprotoquicPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn NetprotoquicPoint::mid(self : NetprotoquicPoint, other : NetprotoquicPoint) -> NetprotoquicPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn NetprotoquicPoint::lerp(self : NetprotoquicPoint, other : NetprotoquicPoint, t : Double) -> NetprotoquicPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn NetprotoquicPoint::to_string(self : NetprotoquicPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct NetprotoquicSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn net_proto_quic_make_series(vals : Array[Double], name : String) -> NetprotoquicSeries {
  { vals, name, meta: 0 }
}

pub fn NetprotoquicSeries::len(self : NetprotoquicSeries) -> Int { self.vals.length() }

pub fn NetprotoquicSeries::sum(self : NetprotoquicSeries) -> Double { @_common.sum(self.vals) }

pub fn NetprotoquicSeries::mean(self : NetprotoquicSeries) -> Double { @_common.mean(self.vals) }

pub fn NetprotoquicSeries::min(self : NetprotoquicSeries) -> Double { @_common.min(self.vals) }

pub fn NetprotoquicSeries::max(self : NetprotoquicSeries) -> Double { @_common.max(self.vals) }

pub fn NetprotoquicSeries::range(self : NetprotoquicSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn NetprotoquicSeries::variance(self : NetprotoquicSeries) -> Double { @_common.variance(self.vals) }

pub fn NetprotoquicSeries::std(self : NetprotoquicSeries) -> Double { @_common.std(self.vals) }

pub fn NetprotoquicSeries::median(self : NetprotoquicSeries) -> Double { @_common.median(self.vals) }

pub fn NetprotoquicSeries::scale(self : NetprotoquicSeries, f : Double) -> NetprotoquicSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn NetprotoquicSeries::add(self : NetprotoquicSeries, other : NetprotoquicSeries) -> NetprotoquicSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn NetprotoquicSeries::sub(self : NetprotoquicSeries, other : NetprotoquicSeries) -> NetprotoquicSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn NetprotoquicSeries::normalize(self : NetprotoquicSeries) -> NetprotoquicSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn NetprotoquicSeries::cumsum(self : NetprotoquicSeries) -> NetprotoquicSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn NetprotoquicSeries::to_string(self : NetprotoquicSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct NetprotoquicMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn net_proto_quic_make_matrix(rows : Int, cols : Int, val : Double) -> NetprotoquicMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn net_proto_quic_matrix_identity(n : Int) -> NetprotoquicMatrix {
  let m = net_proto_quic_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn NetprotoquicMatrix::get(self : NetprotoquicMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn NetprotoquicMatrix::transpose(self : NetprotoquicMatrix) -> NetprotoquicMatrix {
  let result = net_proto_quic_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn NetprotoquicMatrix::add(self : NetprotoquicMatrix, other : NetprotoquicMatrix) -> NetprotoquicMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = net_proto_quic_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn NetprotoquicMatrix::scale(self : NetprotoquicMatrix, s : Double) -> NetprotoquicMatrix {
  let result = net_proto_quic_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn NetprotoquicMatrix::multiply(self : NetprotoquicMatrix, other : NetprotoquicMatrix) -> NetprotoquicMatrix {
  if self.cols != other.rows { return net_proto_quic_make_matrix(self.rows, other.cols, 0.0) }
  let result = net_proto_quic_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn NetprotoquicMatrix::trace(self : NetprotoquicMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn NetprotoquicMatrix::det(self : NetprotoquicMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn NetprotoquicMatrix::norm(self : NetprotoquicMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn NetprotoquicMatrix::to_string(self : NetprotoquicMatrix) -> String {
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

pub(all) struct NetprotoquicVector {
  comps : Array[Double]
  dim : Int
}

pub fn net_proto_quic_make_vector(comps : Array[Double]) -> NetprotoquicVector {
  { comps, dim: comps.length() }
}

pub fn net_proto_quic_vector_zero(dim : Int) -> NetprotoquicVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn NetprotoquicVector::add(self : NetprotoquicVector, other : NetprotoquicVector) -> NetprotoquicVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn NetprotoquicVector::sub(self : NetprotoquicVector, other : NetprotoquicVector) -> NetprotoquicVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn NetprotoquicVector::scale(self : NetprotoquicVector, s : Double) -> NetprotoquicVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn NetprotoquicVector::dot(self : NetprotoquicVector, other : NetprotoquicVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn NetprotoquicVector::norm(self : NetprotoquicVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn NetprotoquicVector::normalize(self : NetprotoquicVector) -> NetprotoquicVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn NetprotoquicVector::dist(self : NetprotoquicVector, other : NetprotoquicVector) -> Double {
  self.sub(other).norm()
}

pub fn NetprotoquicVector::to_string(self : NetprotoquicVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn net_proto_quic_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn net_proto_quic_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn net_proto_quic_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn net_proto_quic_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn net_proto_quic_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn net_proto_quic_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn net_proto_quic_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn net_proto_quic_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn net_proto_quic_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn net_proto_quic_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn net_proto_quic_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn net_proto_quic_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn net_proto_quic_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn net_proto_quic_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn net_proto_quic_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn net_proto_quic_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn net_proto_quic_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn net_proto_quic_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn net_proto_quic_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn net_proto_quic_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn net_proto_quic_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn net_proto_quic_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn net_proto_quic_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn net_proto_quic_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn net_proto_quic_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn net_proto_quic_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn net_proto_quic_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn net_proto_quic_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn net_proto_quic_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct NetprotoquicFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_proto_quic_frame_make(size : Int) -> NetprotoquicFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_proto_quic_frame_len(s : NetprotoquicFrame) -> Int { s.size }

pub fn net_proto_quic_frame_get(s : NetprotoquicFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_proto_quic_frame_set(s : NetprotoquicFrame, i : Int, v : Double) -> NetprotoquicFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn net_proto_quic_frame_sum(s : NetprotoquicFrame) -> Double { @_common.sum(s.data) }

pub fn net_proto_quic_frame_mean(s : NetprotoquicFrame) -> Double { @_common.mean(s.data) }

pub fn net_proto_quic_frame_scale(s : NetprotoquicFrame, f : Double) -> NetprotoquicFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_proto_quic_frame_add(a : NetprotoquicFrame, b : NetprotoquicFrame) -> NetprotoquicFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_proto_quic_frame_copy(s : NetprotoquicFrame) -> NetprotoquicFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_proto_quic_frame_fill(s : NetprotoquicFrame, v : Double) -> NetprotoquicFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_proto_quic_frame_min(s : NetprotoquicFrame) -> Double { @_common.min(s.data) }

pub fn net_proto_quic_frame_max(s : NetprotoquicFrame) -> Double { @_common.max(s.data) }

pub fn net_proto_quic_frame_to_string(s : NetprotoquicFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetprotoquicTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_proto_quic_table_make(size : Int) -> NetprotoquicTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_proto_quic_table_len(s : NetprotoquicTable) -> Int { s.size }

pub fn net_proto_quic_table_get(s : NetprotoquicTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_proto_quic_table_set(s : NetprotoquicTable, i : Int, v : Double) -> NetprotoquicTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn net_proto_quic_table_sum(s : NetprotoquicTable) -> Double { @_common.sum(s.data) }

pub fn net_proto_quic_table_mean(s : NetprotoquicTable) -> Double { @_common.mean(s.data) }

pub fn net_proto_quic_table_scale(s : NetprotoquicTable, f : Double) -> NetprotoquicTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_proto_quic_table_add(a : NetprotoquicTable, b : NetprotoquicTable) -> NetprotoquicTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_proto_quic_table_copy(s : NetprotoquicTable) -> NetprotoquicTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_proto_quic_table_fill(s : NetprotoquicTable, v : Double) -> NetprotoquicTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_proto_quic_table_min(s : NetprotoquicTable) -> Double { @_common.min(s.data) }

pub fn net_proto_quic_table_max(s : NetprotoquicTable) -> Double { @_common.max(s.data) }

pub fn net_proto_quic_table_to_string(s : NetprotoquicTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetprotoquicGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_proto_quic_graphn_make(size : Int) -> NetprotoquicGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_proto_quic_graphn_len(s : NetprotoquicGraphN) -> Int { s.size }

pub fn net_proto_quic_graphn_get(s : NetprotoquicGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_proto_quic_graphn_set(s : NetprotoquicGraphN, i : Int, v : Double) -> NetprotoquicGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn net_proto_quic_graphn_sum(s : NetprotoquicGraphN) -> Double { @_common.sum(s.data) }

pub fn net_proto_quic_graphn_mean(s : NetprotoquicGraphN) -> Double { @_common.mean(s.data) }

pub fn net_proto_quic_graphn_scale(s : NetprotoquicGraphN, f : Double) -> NetprotoquicGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_proto_quic_graphn_add(a : NetprotoquicGraphN, b : NetprotoquicGraphN) -> NetprotoquicGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_proto_quic_graphn_copy(s : NetprotoquicGraphN) -> NetprotoquicGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_proto_quic_graphn_fill(s : NetprotoquicGraphN, v : Double) -> NetprotoquicGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_proto_quic_graphn_min(s : NetprotoquicGraphN) -> Double { @_common.min(s.data) }

pub fn net_proto_quic_graphn_max(s : NetprotoquicGraphN) -> Double { @_common.max(s.data) }

pub fn net_proto_quic_graphn_to_string(s : NetprotoquicGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetprotoquicNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_proto_quic_node_make(size : Int) -> NetprotoquicNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_proto_quic_node_len(s : NetprotoquicNode) -> Int { s.size }

pub fn net_proto_quic_node_get(s : NetprotoquicNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_proto_quic_node_set(s : NetprotoquicNode, i : Int, v : Double) -> NetprotoquicNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn net_proto_quic_node_sum(s : NetprotoquicNode) -> Double { @_common.sum(s.data) }

pub fn net_proto_quic_node_mean(s : NetprotoquicNode) -> Double { @_common.mean(s.data) }

pub fn net_proto_quic_node_scale(s : NetprotoquicNode, f : Double) -> NetprotoquicNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_proto_quic_node_add(a : NetprotoquicNode, b : NetprotoquicNode) -> NetprotoquicNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_proto_quic_node_copy(s : NetprotoquicNode) -> NetprotoquicNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_proto_quic_node_fill(s : NetprotoquicNode, v : Double) -> NetprotoquicNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_proto_quic_node_min(s : NetprotoquicNode) -> Double { @_common.min(s.data) }

pub fn net_proto_quic_node_max(s : NetprotoquicNode) -> Double { @_common.max(s.data) }

pub fn net_proto_quic_node_to_string(s : NetprotoquicNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetprotoquicEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_proto_quic_edge_make(size : Int) -> NetprotoquicEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_proto_quic_edge_len(s : NetprotoquicEdge) -> Int { s.size }

pub fn net_proto_quic_edge_get(s : NetprotoquicEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_proto_quic_edge_set(s : NetprotoquicEdge, i : Int, v : Double) -> NetprotoquicEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn net_proto_quic_edge_sum(s : NetprotoquicEdge) -> Double { @_common.sum(s.data) }

pub fn net_proto_quic_edge_mean(s : NetprotoquicEdge) -> Double { @_common.mean(s.data) }

pub fn net_proto_quic_edge_scale(s : NetprotoquicEdge, f : Double) -> NetprotoquicEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_proto_quic_edge_add(a : NetprotoquicEdge, b : NetprotoquicEdge) -> NetprotoquicEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_proto_quic_edge_copy(s : NetprotoquicEdge) -> NetprotoquicEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_proto_quic_edge_fill(s : NetprotoquicEdge, v : Double) -> NetprotoquicEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_proto_quic_edge_min(s : NetprotoquicEdge) -> Double { @_common.min(s.data) }

pub fn net_proto_quic_edge_max(s : NetprotoquicEdge) -> Double { @_common.max(s.data) }

pub fn net_proto_quic_edge_to_string(s : NetprotoquicEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetprotoquicPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_proto_quic_path_make(size : Int) -> NetprotoquicPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_proto_quic_path_len(s : NetprotoquicPath) -> Int { s.size }

pub fn net_proto_quic_path_get(s : NetprotoquicPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_proto_quic_path_set(s : NetprotoquicPath, i : Int, v : Double) -> NetprotoquicPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn net_proto_quic_path_sum(s : NetprotoquicPath) -> Double { @_common.sum(s.data) }

pub fn net_proto_quic_path_mean(s : NetprotoquicPath) -> Double { @_common.mean(s.data) }

pub fn net_proto_quic_path_scale(s : NetprotoquicPath, f : Double) -> NetprotoquicPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_proto_quic_path_add(a : NetprotoquicPath, b : NetprotoquicPath) -> NetprotoquicPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_proto_quic_path_copy(s : NetprotoquicPath) -> NetprotoquicPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_proto_quic_path_fill(s : NetprotoquicPath, v : Double) -> NetprotoquicPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_proto_quic_path_min(s : NetprotoquicPath) -> Double { @_common.min(s.data) }

pub fn net_proto_quic_path_max(s : NetprotoquicPath) -> Double { @_common.max(s.data) }

pub fn net_proto_quic_path_to_string(s : NetprotoquicPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetprotoquicCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_proto_quic_cluster_make(size : Int) -> NetprotoquicCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_proto_quic_cluster_len(s : NetprotoquicCluster) -> Int { s.size }

pub fn net_proto_quic_cluster_get(s : NetprotoquicCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_proto_quic_cluster_set(s : NetprotoquicCluster, i : Int, v : Double) -> NetprotoquicCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn net_proto_quic_cluster_sum(s : NetprotoquicCluster) -> Double { @_common.sum(s.data) }

pub fn net_proto_quic_cluster_mean(s : NetprotoquicCluster) -> Double { @_common.mean(s.data) }

pub fn net_proto_quic_cluster_scale(s : NetprotoquicCluster, f : Double) -> NetprotoquicCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_proto_quic_cluster_add(a : NetprotoquicCluster, b : NetprotoquicCluster) -> NetprotoquicCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_proto_quic_cluster_copy(s : NetprotoquicCluster) -> NetprotoquicCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_proto_quic_cluster_fill(s : NetprotoquicCluster, v : Double) -> NetprotoquicCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_proto_quic_cluster_min(s : NetprotoquicCluster) -> Double { @_common.min(s.data) }

pub fn net_proto_quic_cluster_max(s : NetprotoquicCluster) -> Double { @_common.max(s.data) }

pub fn net_proto_quic_cluster_to_string(s : NetprotoquicCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetprotoquicModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_proto_quic_model_make(size : Int) -> NetprotoquicModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_proto_quic_model_len(s : NetprotoquicModel) -> Int { s.size }

pub fn net_proto_quic_model_get(s : NetprotoquicModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_proto_quic_model_set(s : NetprotoquicModel, i : Int, v : Double) -> NetprotoquicModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn net_proto_quic_model_sum(s : NetprotoquicModel) -> Double { @_common.sum(s.data) }

pub fn net_proto_quic_model_mean(s : NetprotoquicModel) -> Double { @_common.mean(s.data) }

pub fn net_proto_quic_model_scale(s : NetprotoquicModel, f : Double) -> NetprotoquicModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_proto_quic_model_add(a : NetprotoquicModel, b : NetprotoquicModel) -> NetprotoquicModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_proto_quic_model_copy(s : NetprotoquicModel) -> NetprotoquicModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_proto_quic_model_fill(s : NetprotoquicModel, v : Double) -> NetprotoquicModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_proto_quic_model_min(s : NetprotoquicModel) -> Double { @_common.min(s.data) }

pub fn net_proto_quic_model_max(s : NetprotoquicModel) -> Double { @_common.max(s.data) }

pub fn net_proto_quic_model_to_string(s : NetprotoquicModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetprotoquicLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_proto_quic_layer_make(size : Int) -> NetprotoquicLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_proto_quic_layer_len(s : NetprotoquicLayer) -> Int { s.size }

pub fn net_proto_quic_layer_get(s : NetprotoquicLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_proto_quic_layer_set(s : NetprotoquicLayer, i : Int, v : Double) -> NetprotoquicLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn net_proto_quic_layer_sum(s : NetprotoquicLayer) -> Double { @_common.sum(s.data) }

pub fn net_proto_quic_layer_mean(s : NetprotoquicLayer) -> Double { @_common.mean(s.data) }

pub fn net_proto_quic_layer_scale(s : NetprotoquicLayer, f : Double) -> NetprotoquicLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_proto_quic_layer_add(a : NetprotoquicLayer, b : NetprotoquicLayer) -> NetprotoquicLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_proto_quic_layer_copy(s : NetprotoquicLayer) -> NetprotoquicLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_proto_quic_layer_fill(s : NetprotoquicLayer, v : Double) -> NetprotoquicLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_proto_quic_layer_min(s : NetprotoquicLayer) -> Double { @_common.min(s.data) }

pub fn net_proto_quic_layer_max(s : NetprotoquicLayer) -> Double { @_common.max(s.data) }

pub fn net_proto_quic_layer_to_string(s : NetprotoquicLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetprotoquicBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_proto_quic_buffer_make(size : Int) -> NetprotoquicBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_proto_quic_buffer_len(s : NetprotoquicBuffer) -> Int { s.size }

pub fn net_proto_quic_buffer_get(s : NetprotoquicBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_proto_quic_buffer_set(s : NetprotoquicBuffer, i : Int, v : Double) -> NetprotoquicBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn net_proto_quic_buffer_sum(s : NetprotoquicBuffer) -> Double { @_common.sum(s.data) }

pub fn net_proto_quic_buffer_mean(s : NetprotoquicBuffer) -> Double { @_common.mean(s.data) }

pub fn net_proto_quic_buffer_scale(s : NetprotoquicBuffer, f : Double) -> NetprotoquicBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_proto_quic_buffer_add(a : NetprotoquicBuffer, b : NetprotoquicBuffer) -> NetprotoquicBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_proto_quic_buffer_copy(s : NetprotoquicBuffer) -> NetprotoquicBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_proto_quic_buffer_fill(s : NetprotoquicBuffer, v : Double) -> NetprotoquicBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_proto_quic_buffer_min(s : NetprotoquicBuffer) -> Double { @_common.min(s.data) }

pub fn net_proto_quic_buffer_max(s : NetprotoquicBuffer) -> Double { @_common.max(s.data) }

pub fn net_proto_quic_buffer_to_string(s : NetprotoquicBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetprotoquicCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_proto_quic_cursor_make(size : Int) -> NetprotoquicCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_proto_quic_cursor_len(s : NetprotoquicCursor) -> Int { s.size }

pub fn net_proto_quic_cursor_get(s : NetprotoquicCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_proto_quic_cursor_set(s : NetprotoquicCursor, i : Int, v : Double) -> NetprotoquicCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn net_proto_quic_cursor_sum(s : NetprotoquicCursor) -> Double { @_common.sum(s.data) }

pub fn net_proto_quic_cursor_mean(s : NetprotoquicCursor) -> Double { @_common.mean(s.data) }

pub fn net_proto_quic_cursor_scale(s : NetprotoquicCursor, f : Double) -> NetprotoquicCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_proto_quic_cursor_add(a : NetprotoquicCursor, b : NetprotoquicCursor) -> NetprotoquicCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_proto_quic_cursor_copy(s : NetprotoquicCursor) -> NetprotoquicCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_proto_quic_cursor_fill(s : NetprotoquicCursor, v : Double) -> NetprotoquicCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_proto_quic_cursor_min(s : NetprotoquicCursor) -> Double { @_common.min(s.data) }

pub fn net_proto_quic_cursor_max(s : NetprotoquicCursor) -> Double { @_common.max(s.data) }

pub fn net_proto_quic_cursor_to_string(s : NetprotoquicCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetprotoquicView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_proto_quic_view_make(size : Int) -> NetprotoquicView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_proto_quic_view_len(s : NetprotoquicView) -> Int { s.size }

pub fn net_proto_quic_view_get(s : NetprotoquicView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_proto_quic_view_set(s : NetprotoquicView, i : Int, v : Double) -> NetprotoquicView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn net_proto_quic_view_sum(s : NetprotoquicView) -> Double { @_common.sum(s.data) }

pub fn net_proto_quic_view_mean(s : NetprotoquicView) -> Double { @_common.mean(s.data) }

pub fn net_proto_quic_view_scale(s : NetprotoquicView, f : Double) -> NetprotoquicView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_proto_quic_view_add(a : NetprotoquicView, b : NetprotoquicView) -> NetprotoquicView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_proto_quic_view_copy(s : NetprotoquicView) -> NetprotoquicView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_proto_quic_view_fill(s : NetprotoquicView, v : Double) -> NetprotoquicView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_proto_quic_view_min(s : NetprotoquicView) -> Double { @_common.min(s.data) }

pub fn net_proto_quic_view_max(s : NetprotoquicView) -> Double { @_common.max(s.data) }

pub fn net_proto_quic_view_to_string(s : NetprotoquicView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetprotoquicRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_proto_quic_range_make(size : Int) -> NetprotoquicRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_proto_quic_range_len(s : NetprotoquicRange) -> Int { s.size }

pub fn net_proto_quic_range_get(s : NetprotoquicRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_proto_quic_range_set(s : NetprotoquicRange, i : Int, v : Double) -> NetprotoquicRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn net_proto_quic_range_sum(s : NetprotoquicRange) -> Double { @_common.sum(s.data) }

pub fn net_proto_quic_range_mean(s : NetprotoquicRange) -> Double { @_common.mean(s.data) }

pub fn net_proto_quic_range_scale(s : NetprotoquicRange, f : Double) -> NetprotoquicRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_proto_quic_range_add(a : NetprotoquicRange, b : NetprotoquicRange) -> NetprotoquicRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_proto_quic_range_copy(s : NetprotoquicRange) -> NetprotoquicRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_proto_quic_range_fill(s : NetprotoquicRange, v : Double) -> NetprotoquicRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_proto_quic_range_min(s : NetprotoquicRange) -> Double { @_common.min(s.data) }

pub fn net_proto_quic_range_max(s : NetprotoquicRange) -> Double { @_common.max(s.data) }

pub fn net_proto_quic_range_to_string(s : NetprotoquicRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetprotoquicSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_proto_quic_slice_make(size : Int) -> NetprotoquicSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_proto_quic_slice_len(s : NetprotoquicSlice) -> Int { s.size }

pub fn net_proto_quic_slice_get(s : NetprotoquicSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_proto_quic_slice_set(s : NetprotoquicSlice, i : Int, v : Double) -> NetprotoquicSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn net_proto_quic_slice_sum(s : NetprotoquicSlice) -> Double { @_common.sum(s.data) }

pub fn net_proto_quic_slice_mean(s : NetprotoquicSlice) -> Double { @_common.mean(s.data) }

pub fn net_proto_quic_slice_scale(s : NetprotoquicSlice, f : Double) -> NetprotoquicSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_proto_quic_slice_add(a : NetprotoquicSlice, b : NetprotoquicSlice) -> NetprotoquicSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_proto_quic_slice_copy(s : NetprotoquicSlice) -> NetprotoquicSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_proto_quic_slice_fill(s : NetprotoquicSlice, v : Double) -> NetprotoquicSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_proto_quic_slice_min(s : NetprotoquicSlice) -> Double { @_common.min(s.data) }

pub fn net_proto_quic_slice_max(s : NetprotoquicSlice) -> Double { @_common.max(s.data) }

pub fn net_proto_quic_slice_to_string(s : NetprotoquicSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

