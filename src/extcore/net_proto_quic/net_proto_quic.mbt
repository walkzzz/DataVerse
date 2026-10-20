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

pub fn NetprotoquicFrame::len(self : NetprotoquicFrame) -> Int { self.size }

pub fn NetprotoquicFrame::get(self : NetprotoquicFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NetprotoquicFrame::set(self : NetprotoquicFrame, i : Int, v : Double) -> NetprotoquicFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NetprotoquicFrame::sum(self : NetprotoquicFrame) -> Double { @_common.sum(self.data) }

pub fn NetprotoquicFrame::mean(self : NetprotoquicFrame) -> Double { @_common.mean(self.data) }

pub fn NetprotoquicFrame::scale(self : NetprotoquicFrame, f : Double) -> NetprotoquicFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NetprotoquicFrame::add(self : NetprotoquicFrame, other : NetprotoquicFrame) -> NetprotoquicFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NetprotoquicFrame::copy(self : NetprotoquicFrame) -> NetprotoquicFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NetprotoquicFrame::fill(self : NetprotoquicFrame, v : Double) -> NetprotoquicFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NetprotoquicFrame::min(self : NetprotoquicFrame) -> Double { @_common.min(self.data) }

pub fn NetprotoquicFrame::max(self : NetprotoquicFrame) -> Double { @_common.max(self.data) }

pub fn NetprotoquicFrame::to_string(self : NetprotoquicFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NetprotoquicTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_proto_quic_table_make(size : Int) -> NetprotoquicTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NetprotoquicTable::len(self : NetprotoquicTable) -> Int { self.size }

pub fn NetprotoquicTable::get(self : NetprotoquicTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NetprotoquicTable::set(self : NetprotoquicTable, i : Int, v : Double) -> NetprotoquicTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NetprotoquicTable::sum(self : NetprotoquicTable) -> Double { @_common.sum(self.data) }

pub fn NetprotoquicTable::mean(self : NetprotoquicTable) -> Double { @_common.mean(self.data) }

pub fn NetprotoquicTable::scale(self : NetprotoquicTable, f : Double) -> NetprotoquicTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NetprotoquicTable::add(self : NetprotoquicTable, other : NetprotoquicTable) -> NetprotoquicTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NetprotoquicTable::copy(self : NetprotoquicTable) -> NetprotoquicTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NetprotoquicTable::fill(self : NetprotoquicTable, v : Double) -> NetprotoquicTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NetprotoquicTable::min(self : NetprotoquicTable) -> Double { @_common.min(self.data) }

pub fn NetprotoquicTable::max(self : NetprotoquicTable) -> Double { @_common.max(self.data) }

pub fn NetprotoquicTable::to_string(self : NetprotoquicTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NetprotoquicGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_proto_quic_graphn_make(size : Int) -> NetprotoquicGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NetprotoquicGraphN::len(self : NetprotoquicGraphN) -> Int { self.size }

pub fn NetprotoquicGraphN::get(self : NetprotoquicGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NetprotoquicGraphN::set(self : NetprotoquicGraphN, i : Int, v : Double) -> NetprotoquicGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NetprotoquicGraphN::sum(self : NetprotoquicGraphN) -> Double { @_common.sum(self.data) }

pub fn NetprotoquicGraphN::mean(self : NetprotoquicGraphN) -> Double { @_common.mean(self.data) }

pub fn NetprotoquicGraphN::scale(self : NetprotoquicGraphN, f : Double) -> NetprotoquicGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NetprotoquicGraphN::add(self : NetprotoquicGraphN, other : NetprotoquicGraphN) -> NetprotoquicGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NetprotoquicGraphN::copy(self : NetprotoquicGraphN) -> NetprotoquicGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NetprotoquicGraphN::fill(self : NetprotoquicGraphN, v : Double) -> NetprotoquicGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NetprotoquicGraphN::min(self : NetprotoquicGraphN) -> Double { @_common.min(self.data) }

pub fn NetprotoquicGraphN::max(self : NetprotoquicGraphN) -> Double { @_common.max(self.data) }

pub fn NetprotoquicGraphN::to_string(self : NetprotoquicGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NetprotoquicNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_proto_quic_node_make(size : Int) -> NetprotoquicNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NetprotoquicNode::len(self : NetprotoquicNode) -> Int { self.size }

pub fn NetprotoquicNode::get(self : NetprotoquicNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NetprotoquicNode::set(self : NetprotoquicNode, i : Int, v : Double) -> NetprotoquicNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NetprotoquicNode::sum(self : NetprotoquicNode) -> Double { @_common.sum(self.data) }

pub fn NetprotoquicNode::mean(self : NetprotoquicNode) -> Double { @_common.mean(self.data) }

pub fn NetprotoquicNode::scale(self : NetprotoquicNode, f : Double) -> NetprotoquicNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NetprotoquicNode::add(self : NetprotoquicNode, other : NetprotoquicNode) -> NetprotoquicNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NetprotoquicNode::copy(self : NetprotoquicNode) -> NetprotoquicNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NetprotoquicNode::fill(self : NetprotoquicNode, v : Double) -> NetprotoquicNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NetprotoquicNode::min(self : NetprotoquicNode) -> Double { @_common.min(self.data) }

pub fn NetprotoquicNode::max(self : NetprotoquicNode) -> Double { @_common.max(self.data) }

pub fn NetprotoquicNode::to_string(self : NetprotoquicNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NetprotoquicEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_proto_quic_edge_make(size : Int) -> NetprotoquicEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NetprotoquicEdge::len(self : NetprotoquicEdge) -> Int { self.size }

pub fn NetprotoquicEdge::get(self : NetprotoquicEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NetprotoquicEdge::set(self : NetprotoquicEdge, i : Int, v : Double) -> NetprotoquicEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NetprotoquicEdge::sum(self : NetprotoquicEdge) -> Double { @_common.sum(self.data) }

pub fn NetprotoquicEdge::mean(self : NetprotoquicEdge) -> Double { @_common.mean(self.data) }

pub fn NetprotoquicEdge::scale(self : NetprotoquicEdge, f : Double) -> NetprotoquicEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NetprotoquicEdge::add(self : NetprotoquicEdge, other : NetprotoquicEdge) -> NetprotoquicEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NetprotoquicEdge::copy(self : NetprotoquicEdge) -> NetprotoquicEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NetprotoquicEdge::fill(self : NetprotoquicEdge, v : Double) -> NetprotoquicEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NetprotoquicEdge::min(self : NetprotoquicEdge) -> Double { @_common.min(self.data) }

pub fn NetprotoquicEdge::max(self : NetprotoquicEdge) -> Double { @_common.max(self.data) }

pub fn NetprotoquicEdge::to_string(self : NetprotoquicEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NetprotoquicPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_proto_quic_path_make(size : Int) -> NetprotoquicPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NetprotoquicPath::len(self : NetprotoquicPath) -> Int { self.size }

pub fn NetprotoquicPath::get(self : NetprotoquicPath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NetprotoquicPath::set(self : NetprotoquicPath, i : Int, v : Double) -> NetprotoquicPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NetprotoquicPath::sum(self : NetprotoquicPath) -> Double { @_common.sum(self.data) }

pub fn NetprotoquicPath::mean(self : NetprotoquicPath) -> Double { @_common.mean(self.data) }

pub fn NetprotoquicPath::scale(self : NetprotoquicPath, f : Double) -> NetprotoquicPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NetprotoquicPath::add(self : NetprotoquicPath, other : NetprotoquicPath) -> NetprotoquicPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NetprotoquicPath::copy(self : NetprotoquicPath) -> NetprotoquicPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NetprotoquicPath::fill(self : NetprotoquicPath, v : Double) -> NetprotoquicPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NetprotoquicPath::min(self : NetprotoquicPath) -> Double { @_common.min(self.data) }

pub fn NetprotoquicPath::max(self : NetprotoquicPath) -> Double { @_common.max(self.data) }

pub fn NetprotoquicPath::to_string(self : NetprotoquicPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NetprotoquicCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_proto_quic_cluster_make(size : Int) -> NetprotoquicCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NetprotoquicCluster::len(self : NetprotoquicCluster) -> Int { self.size }

pub fn NetprotoquicCluster::get(self : NetprotoquicCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NetprotoquicCluster::set(self : NetprotoquicCluster, i : Int, v : Double) -> NetprotoquicCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NetprotoquicCluster::sum(self : NetprotoquicCluster) -> Double { @_common.sum(self.data) }

pub fn NetprotoquicCluster::mean(self : NetprotoquicCluster) -> Double { @_common.mean(self.data) }

pub fn NetprotoquicCluster::scale(self : NetprotoquicCluster, f : Double) -> NetprotoquicCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NetprotoquicCluster::add(self : NetprotoquicCluster, other : NetprotoquicCluster) -> NetprotoquicCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NetprotoquicCluster::copy(self : NetprotoquicCluster) -> NetprotoquicCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NetprotoquicCluster::fill(self : NetprotoquicCluster, v : Double) -> NetprotoquicCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NetprotoquicCluster::min(self : NetprotoquicCluster) -> Double { @_common.min(self.data) }

pub fn NetprotoquicCluster::max(self : NetprotoquicCluster) -> Double { @_common.max(self.data) }

pub fn NetprotoquicCluster::to_string(self : NetprotoquicCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NetprotoquicModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_proto_quic_model_make(size : Int) -> NetprotoquicModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NetprotoquicModel::len(self : NetprotoquicModel) -> Int { self.size }

pub fn NetprotoquicModel::get(self : NetprotoquicModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NetprotoquicModel::set(self : NetprotoquicModel, i : Int, v : Double) -> NetprotoquicModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NetprotoquicModel::sum(self : NetprotoquicModel) -> Double { @_common.sum(self.data) }

pub fn NetprotoquicModel::mean(self : NetprotoquicModel) -> Double { @_common.mean(self.data) }

pub fn NetprotoquicModel::scale(self : NetprotoquicModel, f : Double) -> NetprotoquicModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NetprotoquicModel::add(self : NetprotoquicModel, other : NetprotoquicModel) -> NetprotoquicModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NetprotoquicModel::copy(self : NetprotoquicModel) -> NetprotoquicModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NetprotoquicModel::fill(self : NetprotoquicModel, v : Double) -> NetprotoquicModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NetprotoquicModel::min(self : NetprotoquicModel) -> Double { @_common.min(self.data) }

pub fn NetprotoquicModel::max(self : NetprotoquicModel) -> Double { @_common.max(self.data) }

pub fn NetprotoquicModel::to_string(self : NetprotoquicModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NetprotoquicLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_proto_quic_layer_make(size : Int) -> NetprotoquicLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NetprotoquicLayer::len(self : NetprotoquicLayer) -> Int { self.size }

pub fn NetprotoquicLayer::get(self : NetprotoquicLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NetprotoquicLayer::set(self : NetprotoquicLayer, i : Int, v : Double) -> NetprotoquicLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NetprotoquicLayer::sum(self : NetprotoquicLayer) -> Double { @_common.sum(self.data) }

pub fn NetprotoquicLayer::mean(self : NetprotoquicLayer) -> Double { @_common.mean(self.data) }

pub fn NetprotoquicLayer::scale(self : NetprotoquicLayer, f : Double) -> NetprotoquicLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NetprotoquicLayer::add(self : NetprotoquicLayer, other : NetprotoquicLayer) -> NetprotoquicLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NetprotoquicLayer::copy(self : NetprotoquicLayer) -> NetprotoquicLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NetprotoquicLayer::fill(self : NetprotoquicLayer, v : Double) -> NetprotoquicLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NetprotoquicLayer::min(self : NetprotoquicLayer) -> Double { @_common.min(self.data) }

pub fn NetprotoquicLayer::max(self : NetprotoquicLayer) -> Double { @_common.max(self.data) }

pub fn NetprotoquicLayer::to_string(self : NetprotoquicLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NetprotoquicBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_proto_quic_buffer_make(size : Int) -> NetprotoquicBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NetprotoquicBuffer::len(self : NetprotoquicBuffer) -> Int { self.size }

pub fn NetprotoquicBuffer::get(self : NetprotoquicBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NetprotoquicBuffer::set(self : NetprotoquicBuffer, i : Int, v : Double) -> NetprotoquicBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NetprotoquicBuffer::sum(self : NetprotoquicBuffer) -> Double { @_common.sum(self.data) }

pub fn NetprotoquicBuffer::mean(self : NetprotoquicBuffer) -> Double { @_common.mean(self.data) }

pub fn NetprotoquicBuffer::scale(self : NetprotoquicBuffer, f : Double) -> NetprotoquicBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NetprotoquicBuffer::add(self : NetprotoquicBuffer, other : NetprotoquicBuffer) -> NetprotoquicBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NetprotoquicBuffer::copy(self : NetprotoquicBuffer) -> NetprotoquicBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NetprotoquicBuffer::fill(self : NetprotoquicBuffer, v : Double) -> NetprotoquicBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NetprotoquicBuffer::min(self : NetprotoquicBuffer) -> Double { @_common.min(self.data) }

pub fn NetprotoquicBuffer::max(self : NetprotoquicBuffer) -> Double { @_common.max(self.data) }

pub fn NetprotoquicBuffer::to_string(self : NetprotoquicBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NetprotoquicCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_proto_quic_cursor_make(size : Int) -> NetprotoquicCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NetprotoquicCursor::len(self : NetprotoquicCursor) -> Int { self.size }

pub fn NetprotoquicCursor::get(self : NetprotoquicCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NetprotoquicCursor::set(self : NetprotoquicCursor, i : Int, v : Double) -> NetprotoquicCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NetprotoquicCursor::sum(self : NetprotoquicCursor) -> Double { @_common.sum(self.data) }

pub fn NetprotoquicCursor::mean(self : NetprotoquicCursor) -> Double { @_common.mean(self.data) }

pub fn NetprotoquicCursor::scale(self : NetprotoquicCursor, f : Double) -> NetprotoquicCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NetprotoquicCursor::add(self : NetprotoquicCursor, other : NetprotoquicCursor) -> NetprotoquicCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NetprotoquicCursor::copy(self : NetprotoquicCursor) -> NetprotoquicCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NetprotoquicCursor::fill(self : NetprotoquicCursor, v : Double) -> NetprotoquicCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NetprotoquicCursor::min(self : NetprotoquicCursor) -> Double { @_common.min(self.data) }

pub fn NetprotoquicCursor::max(self : NetprotoquicCursor) -> Double { @_common.max(self.data) }

pub fn NetprotoquicCursor::to_string(self : NetprotoquicCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NetprotoquicView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_proto_quic_view_make(size : Int) -> NetprotoquicView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NetprotoquicView::len(self : NetprotoquicView) -> Int { self.size }

pub fn NetprotoquicView::get(self : NetprotoquicView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NetprotoquicView::set(self : NetprotoquicView, i : Int, v : Double) -> NetprotoquicView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NetprotoquicView::sum(self : NetprotoquicView) -> Double { @_common.sum(self.data) }

pub fn NetprotoquicView::mean(self : NetprotoquicView) -> Double { @_common.mean(self.data) }

pub fn NetprotoquicView::scale(self : NetprotoquicView, f : Double) -> NetprotoquicView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NetprotoquicView::add(self : NetprotoquicView, other : NetprotoquicView) -> NetprotoquicView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NetprotoquicView::copy(self : NetprotoquicView) -> NetprotoquicView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NetprotoquicView::fill(self : NetprotoquicView, v : Double) -> NetprotoquicView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NetprotoquicView::min(self : NetprotoquicView) -> Double { @_common.min(self.data) }

pub fn NetprotoquicView::max(self : NetprotoquicView) -> Double { @_common.max(self.data) }

pub fn NetprotoquicView::to_string(self : NetprotoquicView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NetprotoquicRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_proto_quic_range_make(size : Int) -> NetprotoquicRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NetprotoquicRange::len(self : NetprotoquicRange) -> Int { self.size }

pub fn NetprotoquicRange::get(self : NetprotoquicRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NetprotoquicRange::set(self : NetprotoquicRange, i : Int, v : Double) -> NetprotoquicRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NetprotoquicRange::sum(self : NetprotoquicRange) -> Double { @_common.sum(self.data) }

pub fn NetprotoquicRange::mean(self : NetprotoquicRange) -> Double { @_common.mean(self.data) }

pub fn NetprotoquicRange::scale(self : NetprotoquicRange, f : Double) -> NetprotoquicRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NetprotoquicRange::add(self : NetprotoquicRange, other : NetprotoquicRange) -> NetprotoquicRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NetprotoquicRange::copy(self : NetprotoquicRange) -> NetprotoquicRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NetprotoquicRange::fill(self : NetprotoquicRange, v : Double) -> NetprotoquicRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NetprotoquicRange::min(self : NetprotoquicRange) -> Double { @_common.min(self.data) }

pub fn NetprotoquicRange::max(self : NetprotoquicRange) -> Double { @_common.max(self.data) }

pub fn NetprotoquicRange::to_string(self : NetprotoquicRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NetprotoquicSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_proto_quic_slice_make(size : Int) -> NetprotoquicSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NetprotoquicSlice::len(self : NetprotoquicSlice) -> Int { self.size }

pub fn NetprotoquicSlice::get(self : NetprotoquicSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NetprotoquicSlice::set(self : NetprotoquicSlice, i : Int, v : Double) -> NetprotoquicSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NetprotoquicSlice::sum(self : NetprotoquicSlice) -> Double { @_common.sum(self.data) }

pub fn NetprotoquicSlice::mean(self : NetprotoquicSlice) -> Double { @_common.mean(self.data) }

pub fn NetprotoquicSlice::scale(self : NetprotoquicSlice, f : Double) -> NetprotoquicSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NetprotoquicSlice::add(self : NetprotoquicSlice, other : NetprotoquicSlice) -> NetprotoquicSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NetprotoquicSlice::copy(self : NetprotoquicSlice) -> NetprotoquicSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NetprotoquicSlice::fill(self : NetprotoquicSlice, v : Double) -> NetprotoquicSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NetprotoquicSlice::min(self : NetprotoquicSlice) -> Double { @_common.min(self.data) }

pub fn NetprotoquicSlice::max(self : NetprotoquicSlice) -> Double { @_common.max(self.data) }

pub fn NetprotoquicSlice::to_string(self : NetprotoquicSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

