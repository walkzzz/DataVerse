///===
/// extcore/net_proto_mqtt

pub(all) struct NetprotomqttPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn net_proto_mqtt_make_point(x : Double, y : Double) -> NetprotomqttPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn net_proto_mqtt_make_point3(x : Double, y : Double, z : Double) -> NetprotomqttPoint {
  { x, y, z, label: 0 }
}

pub fn NetprotomqttPoint::x(self : NetprotomqttPoint) -> Double { self.x }

pub fn NetprotomqttPoint::y(self : NetprotomqttPoint) -> Double { self.y }

pub fn NetprotomqttPoint::z(self : NetprotomqttPoint) -> Double { self.z }

pub fn NetprotomqttPoint::label(self : NetprotomqttPoint) -> Int { self.label }

pub fn NetprotomqttPoint::dist(self : NetprotomqttPoint, other : NetprotomqttPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn NetprotomqttPoint::add(self : NetprotomqttPoint, other : NetprotomqttPoint) -> NetprotomqttPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn NetprotomqttPoint::sub(self : NetprotomqttPoint, other : NetprotomqttPoint) -> NetprotomqttPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn NetprotomqttPoint::scale(self : NetprotomqttPoint, s : Double) -> NetprotomqttPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn NetprotomqttPoint::dot(self : NetprotomqttPoint, other : NetprotomqttPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn NetprotomqttPoint::cross(self : NetprotomqttPoint, other : NetprotomqttPoint) -> NetprotomqttPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn NetprotomqttPoint::norm(self : NetprotomqttPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn NetprotomqttPoint::normalize(self : NetprotomqttPoint) -> NetprotomqttPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn NetprotomqttPoint::negate(self : NetprotomqttPoint) -> NetprotomqttPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn NetprotomqttPoint::mid(self : NetprotomqttPoint, other : NetprotomqttPoint) -> NetprotomqttPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn NetprotomqttPoint::lerp(self : NetprotomqttPoint, other : NetprotomqttPoint, t : Double) -> NetprotomqttPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn NetprotomqttPoint::to_string(self : NetprotomqttPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct NetprotomqttSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn net_proto_mqtt_make_series(vals : Array[Double], name : String) -> NetprotomqttSeries {
  { vals, name, meta: 0 }
}

pub fn NetprotomqttSeries::len(self : NetprotomqttSeries) -> Int { self.vals.length() }

pub fn NetprotomqttSeries::sum(self : NetprotomqttSeries) -> Double { @_common.sum(self.vals) }

pub fn NetprotomqttSeries::mean(self : NetprotomqttSeries) -> Double { @_common.mean(self.vals) }

pub fn NetprotomqttSeries::min(self : NetprotomqttSeries) -> Double { @_common.min(self.vals) }

pub fn NetprotomqttSeries::max(self : NetprotomqttSeries) -> Double { @_common.max(self.vals) }

pub fn NetprotomqttSeries::range(self : NetprotomqttSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn NetprotomqttSeries::variance(self : NetprotomqttSeries) -> Double { @_common.variance(self.vals) }

pub fn NetprotomqttSeries::std(self : NetprotomqttSeries) -> Double { @_common.std(self.vals) }

pub fn NetprotomqttSeries::median(self : NetprotomqttSeries) -> Double { @_common.median(self.vals) }

pub fn NetprotomqttSeries::scale(self : NetprotomqttSeries, f : Double) -> NetprotomqttSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn NetprotomqttSeries::add(self : NetprotomqttSeries, other : NetprotomqttSeries) -> NetprotomqttSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn NetprotomqttSeries::sub(self : NetprotomqttSeries, other : NetprotomqttSeries) -> NetprotomqttSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn NetprotomqttSeries::normalize(self : NetprotomqttSeries) -> NetprotomqttSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn NetprotomqttSeries::cumsum(self : NetprotomqttSeries) -> NetprotomqttSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn NetprotomqttSeries::to_string(self : NetprotomqttSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct NetprotomqttMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn net_proto_mqtt_make_matrix(rows : Int, cols : Int, val : Double) -> NetprotomqttMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn net_proto_mqtt_matrix_identity(n : Int) -> NetprotomqttMatrix {
  let m = net_proto_mqtt_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn NetprotomqttMatrix::get(self : NetprotomqttMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn NetprotomqttMatrix::transpose(self : NetprotomqttMatrix) -> NetprotomqttMatrix {
  let result = net_proto_mqtt_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn NetprotomqttMatrix::add(self : NetprotomqttMatrix, other : NetprotomqttMatrix) -> NetprotomqttMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = net_proto_mqtt_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn NetprotomqttMatrix::scale(self : NetprotomqttMatrix, s : Double) -> NetprotomqttMatrix {
  let result = net_proto_mqtt_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn NetprotomqttMatrix::multiply(self : NetprotomqttMatrix, other : NetprotomqttMatrix) -> NetprotomqttMatrix {
  if self.cols != other.rows { return net_proto_mqtt_make_matrix(self.rows, other.cols, 0.0) }
  let result = net_proto_mqtt_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn NetprotomqttMatrix::trace(self : NetprotomqttMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn NetprotomqttMatrix::det(self : NetprotomqttMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn NetprotomqttMatrix::norm(self : NetprotomqttMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn NetprotomqttMatrix::to_string(self : NetprotomqttMatrix) -> String {
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

pub(all) struct NetprotomqttVector {
  comps : Array[Double]
  dim : Int
}

pub fn net_proto_mqtt_make_vector(comps : Array[Double]) -> NetprotomqttVector {
  { comps, dim: comps.length() }
}

pub fn net_proto_mqtt_vector_zero(dim : Int) -> NetprotomqttVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn NetprotomqttVector::add(self : NetprotomqttVector, other : NetprotomqttVector) -> NetprotomqttVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn NetprotomqttVector::sub(self : NetprotomqttVector, other : NetprotomqttVector) -> NetprotomqttVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn NetprotomqttVector::scale(self : NetprotomqttVector, s : Double) -> NetprotomqttVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn NetprotomqttVector::dot(self : NetprotomqttVector, other : NetprotomqttVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn NetprotomqttVector::norm(self : NetprotomqttVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn NetprotomqttVector::normalize(self : NetprotomqttVector) -> NetprotomqttVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn NetprotomqttVector::dist(self : NetprotomqttVector, other : NetprotomqttVector) -> Double {
  self.sub(other).norm()
}

pub fn NetprotomqttVector::to_string(self : NetprotomqttVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn net_proto_mqtt_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn net_proto_mqtt_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn net_proto_mqtt_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn net_proto_mqtt_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn net_proto_mqtt_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn net_proto_mqtt_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn net_proto_mqtt_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn net_proto_mqtt_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn net_proto_mqtt_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn net_proto_mqtt_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn net_proto_mqtt_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn net_proto_mqtt_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn net_proto_mqtt_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn net_proto_mqtt_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn net_proto_mqtt_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn net_proto_mqtt_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn net_proto_mqtt_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn net_proto_mqtt_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn net_proto_mqtt_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn net_proto_mqtt_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn net_proto_mqtt_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn net_proto_mqtt_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn net_proto_mqtt_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn net_proto_mqtt_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn net_proto_mqtt_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn net_proto_mqtt_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn net_proto_mqtt_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn net_proto_mqtt_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn net_proto_mqtt_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct NetprotomqttFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_proto_mqtt_frame_make(size : Int) -> NetprotomqttFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_proto_mqtt_frame_len(s : NetprotomqttFrame) -> Int { s.size }

pub fn net_proto_mqtt_frame_get(s : NetprotomqttFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_proto_mqtt_frame_set(s : NetprotomqttFrame, i : Int, v : Double) -> NetprotomqttFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn net_proto_mqtt_frame_sum(s : NetprotomqttFrame) -> Double { @_common.sum(s.data) }

pub fn net_proto_mqtt_frame_mean(s : NetprotomqttFrame) -> Double { @_common.mean(s.data) }

pub fn net_proto_mqtt_frame_scale(s : NetprotomqttFrame, f : Double) -> NetprotomqttFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_proto_mqtt_frame_add(a : NetprotomqttFrame, b : NetprotomqttFrame) -> NetprotomqttFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_proto_mqtt_frame_copy(s : NetprotomqttFrame) -> NetprotomqttFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_proto_mqtt_frame_fill(s : NetprotomqttFrame, v : Double) -> NetprotomqttFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_proto_mqtt_frame_min(s : NetprotomqttFrame) -> Double { @_common.min(s.data) }

pub fn net_proto_mqtt_frame_max(s : NetprotomqttFrame) -> Double { @_common.max(s.data) }

pub fn net_proto_mqtt_frame_to_string(s : NetprotomqttFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetprotomqttTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_proto_mqtt_table_make(size : Int) -> NetprotomqttTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_proto_mqtt_table_len(s : NetprotomqttTable) -> Int { s.size }

pub fn net_proto_mqtt_table_get(s : NetprotomqttTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_proto_mqtt_table_set(s : NetprotomqttTable, i : Int, v : Double) -> NetprotomqttTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn net_proto_mqtt_table_sum(s : NetprotomqttTable) -> Double { @_common.sum(s.data) }

pub fn net_proto_mqtt_table_mean(s : NetprotomqttTable) -> Double { @_common.mean(s.data) }

pub fn net_proto_mqtt_table_scale(s : NetprotomqttTable, f : Double) -> NetprotomqttTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_proto_mqtt_table_add(a : NetprotomqttTable, b : NetprotomqttTable) -> NetprotomqttTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_proto_mqtt_table_copy(s : NetprotomqttTable) -> NetprotomqttTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_proto_mqtt_table_fill(s : NetprotomqttTable, v : Double) -> NetprotomqttTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_proto_mqtt_table_min(s : NetprotomqttTable) -> Double { @_common.min(s.data) }

pub fn net_proto_mqtt_table_max(s : NetprotomqttTable) -> Double { @_common.max(s.data) }

pub fn net_proto_mqtt_table_to_string(s : NetprotomqttTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetprotomqttGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_proto_mqtt_graphn_make(size : Int) -> NetprotomqttGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_proto_mqtt_graphn_len(s : NetprotomqttGraphN) -> Int { s.size }

pub fn net_proto_mqtt_graphn_get(s : NetprotomqttGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_proto_mqtt_graphn_set(s : NetprotomqttGraphN, i : Int, v : Double) -> NetprotomqttGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn net_proto_mqtt_graphn_sum(s : NetprotomqttGraphN) -> Double { @_common.sum(s.data) }

pub fn net_proto_mqtt_graphn_mean(s : NetprotomqttGraphN) -> Double { @_common.mean(s.data) }

pub fn net_proto_mqtt_graphn_scale(s : NetprotomqttGraphN, f : Double) -> NetprotomqttGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_proto_mqtt_graphn_add(a : NetprotomqttGraphN, b : NetprotomqttGraphN) -> NetprotomqttGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_proto_mqtt_graphn_copy(s : NetprotomqttGraphN) -> NetprotomqttGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_proto_mqtt_graphn_fill(s : NetprotomqttGraphN, v : Double) -> NetprotomqttGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_proto_mqtt_graphn_min(s : NetprotomqttGraphN) -> Double { @_common.min(s.data) }

pub fn net_proto_mqtt_graphn_max(s : NetprotomqttGraphN) -> Double { @_common.max(s.data) }

pub fn net_proto_mqtt_graphn_to_string(s : NetprotomqttGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetprotomqttNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_proto_mqtt_node_make(size : Int) -> NetprotomqttNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_proto_mqtt_node_len(s : NetprotomqttNode) -> Int { s.size }

pub fn net_proto_mqtt_node_get(s : NetprotomqttNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_proto_mqtt_node_set(s : NetprotomqttNode, i : Int, v : Double) -> NetprotomqttNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn net_proto_mqtt_node_sum(s : NetprotomqttNode) -> Double { @_common.sum(s.data) }

pub fn net_proto_mqtt_node_mean(s : NetprotomqttNode) -> Double { @_common.mean(s.data) }

pub fn net_proto_mqtt_node_scale(s : NetprotomqttNode, f : Double) -> NetprotomqttNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_proto_mqtt_node_add(a : NetprotomqttNode, b : NetprotomqttNode) -> NetprotomqttNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_proto_mqtt_node_copy(s : NetprotomqttNode) -> NetprotomqttNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_proto_mqtt_node_fill(s : NetprotomqttNode, v : Double) -> NetprotomqttNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_proto_mqtt_node_min(s : NetprotomqttNode) -> Double { @_common.min(s.data) }

pub fn net_proto_mqtt_node_max(s : NetprotomqttNode) -> Double { @_common.max(s.data) }

pub fn net_proto_mqtt_node_to_string(s : NetprotomqttNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetprotomqttEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_proto_mqtt_edge_make(size : Int) -> NetprotomqttEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_proto_mqtt_edge_len(s : NetprotomqttEdge) -> Int { s.size }

pub fn net_proto_mqtt_edge_get(s : NetprotomqttEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_proto_mqtt_edge_set(s : NetprotomqttEdge, i : Int, v : Double) -> NetprotomqttEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn net_proto_mqtt_edge_sum(s : NetprotomqttEdge) -> Double { @_common.sum(s.data) }

pub fn net_proto_mqtt_edge_mean(s : NetprotomqttEdge) -> Double { @_common.mean(s.data) }

pub fn net_proto_mqtt_edge_scale(s : NetprotomqttEdge, f : Double) -> NetprotomqttEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_proto_mqtt_edge_add(a : NetprotomqttEdge, b : NetprotomqttEdge) -> NetprotomqttEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_proto_mqtt_edge_copy(s : NetprotomqttEdge) -> NetprotomqttEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_proto_mqtt_edge_fill(s : NetprotomqttEdge, v : Double) -> NetprotomqttEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_proto_mqtt_edge_min(s : NetprotomqttEdge) -> Double { @_common.min(s.data) }

pub fn net_proto_mqtt_edge_max(s : NetprotomqttEdge) -> Double { @_common.max(s.data) }

pub fn net_proto_mqtt_edge_to_string(s : NetprotomqttEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetprotomqttPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_proto_mqtt_path_make(size : Int) -> NetprotomqttPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_proto_mqtt_path_len(s : NetprotomqttPath) -> Int { s.size }

pub fn net_proto_mqtt_path_get(s : NetprotomqttPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_proto_mqtt_path_set(s : NetprotomqttPath, i : Int, v : Double) -> NetprotomqttPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn net_proto_mqtt_path_sum(s : NetprotomqttPath) -> Double { @_common.sum(s.data) }

pub fn net_proto_mqtt_path_mean(s : NetprotomqttPath) -> Double { @_common.mean(s.data) }

pub fn net_proto_mqtt_path_scale(s : NetprotomqttPath, f : Double) -> NetprotomqttPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_proto_mqtt_path_add(a : NetprotomqttPath, b : NetprotomqttPath) -> NetprotomqttPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_proto_mqtt_path_copy(s : NetprotomqttPath) -> NetprotomqttPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_proto_mqtt_path_fill(s : NetprotomqttPath, v : Double) -> NetprotomqttPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_proto_mqtt_path_min(s : NetprotomqttPath) -> Double { @_common.min(s.data) }

pub fn net_proto_mqtt_path_max(s : NetprotomqttPath) -> Double { @_common.max(s.data) }

pub fn net_proto_mqtt_path_to_string(s : NetprotomqttPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetprotomqttCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_proto_mqtt_cluster_make(size : Int) -> NetprotomqttCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_proto_mqtt_cluster_len(s : NetprotomqttCluster) -> Int { s.size }

pub fn net_proto_mqtt_cluster_get(s : NetprotomqttCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_proto_mqtt_cluster_set(s : NetprotomqttCluster, i : Int, v : Double) -> NetprotomqttCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn net_proto_mqtt_cluster_sum(s : NetprotomqttCluster) -> Double { @_common.sum(s.data) }

pub fn net_proto_mqtt_cluster_mean(s : NetprotomqttCluster) -> Double { @_common.mean(s.data) }

pub fn net_proto_mqtt_cluster_scale(s : NetprotomqttCluster, f : Double) -> NetprotomqttCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_proto_mqtt_cluster_add(a : NetprotomqttCluster, b : NetprotomqttCluster) -> NetprotomqttCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_proto_mqtt_cluster_copy(s : NetprotomqttCluster) -> NetprotomqttCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_proto_mqtt_cluster_fill(s : NetprotomqttCluster, v : Double) -> NetprotomqttCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_proto_mqtt_cluster_min(s : NetprotomqttCluster) -> Double { @_common.min(s.data) }

pub fn net_proto_mqtt_cluster_max(s : NetprotomqttCluster) -> Double { @_common.max(s.data) }

pub fn net_proto_mqtt_cluster_to_string(s : NetprotomqttCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetprotomqttModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_proto_mqtt_model_make(size : Int) -> NetprotomqttModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_proto_mqtt_model_len(s : NetprotomqttModel) -> Int { s.size }

pub fn net_proto_mqtt_model_get(s : NetprotomqttModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_proto_mqtt_model_set(s : NetprotomqttModel, i : Int, v : Double) -> NetprotomqttModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn net_proto_mqtt_model_sum(s : NetprotomqttModel) -> Double { @_common.sum(s.data) }

pub fn net_proto_mqtt_model_mean(s : NetprotomqttModel) -> Double { @_common.mean(s.data) }

pub fn net_proto_mqtt_model_scale(s : NetprotomqttModel, f : Double) -> NetprotomqttModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_proto_mqtt_model_add(a : NetprotomqttModel, b : NetprotomqttModel) -> NetprotomqttModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_proto_mqtt_model_copy(s : NetprotomqttModel) -> NetprotomqttModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_proto_mqtt_model_fill(s : NetprotomqttModel, v : Double) -> NetprotomqttModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_proto_mqtt_model_min(s : NetprotomqttModel) -> Double { @_common.min(s.data) }

pub fn net_proto_mqtt_model_max(s : NetprotomqttModel) -> Double { @_common.max(s.data) }

pub fn net_proto_mqtt_model_to_string(s : NetprotomqttModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetprotomqttLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_proto_mqtt_layer_make(size : Int) -> NetprotomqttLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_proto_mqtt_layer_len(s : NetprotomqttLayer) -> Int { s.size }

pub fn net_proto_mqtt_layer_get(s : NetprotomqttLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_proto_mqtt_layer_set(s : NetprotomqttLayer, i : Int, v : Double) -> NetprotomqttLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn net_proto_mqtt_layer_sum(s : NetprotomqttLayer) -> Double { @_common.sum(s.data) }

pub fn net_proto_mqtt_layer_mean(s : NetprotomqttLayer) -> Double { @_common.mean(s.data) }

pub fn net_proto_mqtt_layer_scale(s : NetprotomqttLayer, f : Double) -> NetprotomqttLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_proto_mqtt_layer_add(a : NetprotomqttLayer, b : NetprotomqttLayer) -> NetprotomqttLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_proto_mqtt_layer_copy(s : NetprotomqttLayer) -> NetprotomqttLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_proto_mqtt_layer_fill(s : NetprotomqttLayer, v : Double) -> NetprotomqttLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_proto_mqtt_layer_min(s : NetprotomqttLayer) -> Double { @_common.min(s.data) }

pub fn net_proto_mqtt_layer_max(s : NetprotomqttLayer) -> Double { @_common.max(s.data) }

pub fn net_proto_mqtt_layer_to_string(s : NetprotomqttLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetprotomqttBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_proto_mqtt_buffer_make(size : Int) -> NetprotomqttBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_proto_mqtt_buffer_len(s : NetprotomqttBuffer) -> Int { s.size }

pub fn net_proto_mqtt_buffer_get(s : NetprotomqttBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_proto_mqtt_buffer_set(s : NetprotomqttBuffer, i : Int, v : Double) -> NetprotomqttBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn net_proto_mqtt_buffer_sum(s : NetprotomqttBuffer) -> Double { @_common.sum(s.data) }

pub fn net_proto_mqtt_buffer_mean(s : NetprotomqttBuffer) -> Double { @_common.mean(s.data) }

pub fn net_proto_mqtt_buffer_scale(s : NetprotomqttBuffer, f : Double) -> NetprotomqttBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_proto_mqtt_buffer_add(a : NetprotomqttBuffer, b : NetprotomqttBuffer) -> NetprotomqttBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_proto_mqtt_buffer_copy(s : NetprotomqttBuffer) -> NetprotomqttBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_proto_mqtt_buffer_fill(s : NetprotomqttBuffer, v : Double) -> NetprotomqttBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_proto_mqtt_buffer_min(s : NetprotomqttBuffer) -> Double { @_common.min(s.data) }

pub fn net_proto_mqtt_buffer_max(s : NetprotomqttBuffer) -> Double { @_common.max(s.data) }

pub fn net_proto_mqtt_buffer_to_string(s : NetprotomqttBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetprotomqttCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_proto_mqtt_cursor_make(size : Int) -> NetprotomqttCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_proto_mqtt_cursor_len(s : NetprotomqttCursor) -> Int { s.size }

pub fn net_proto_mqtt_cursor_get(s : NetprotomqttCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_proto_mqtt_cursor_set(s : NetprotomqttCursor, i : Int, v : Double) -> NetprotomqttCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn net_proto_mqtt_cursor_sum(s : NetprotomqttCursor) -> Double { @_common.sum(s.data) }

pub fn net_proto_mqtt_cursor_mean(s : NetprotomqttCursor) -> Double { @_common.mean(s.data) }

pub fn net_proto_mqtt_cursor_scale(s : NetprotomqttCursor, f : Double) -> NetprotomqttCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_proto_mqtt_cursor_add(a : NetprotomqttCursor, b : NetprotomqttCursor) -> NetprotomqttCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_proto_mqtt_cursor_copy(s : NetprotomqttCursor) -> NetprotomqttCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_proto_mqtt_cursor_fill(s : NetprotomqttCursor, v : Double) -> NetprotomqttCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_proto_mqtt_cursor_min(s : NetprotomqttCursor) -> Double { @_common.min(s.data) }

pub fn net_proto_mqtt_cursor_max(s : NetprotomqttCursor) -> Double { @_common.max(s.data) }

pub fn net_proto_mqtt_cursor_to_string(s : NetprotomqttCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetprotomqttView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_proto_mqtt_view_make(size : Int) -> NetprotomqttView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_proto_mqtt_view_len(s : NetprotomqttView) -> Int { s.size }

pub fn net_proto_mqtt_view_get(s : NetprotomqttView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_proto_mqtt_view_set(s : NetprotomqttView, i : Int, v : Double) -> NetprotomqttView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn net_proto_mqtt_view_sum(s : NetprotomqttView) -> Double { @_common.sum(s.data) }

pub fn net_proto_mqtt_view_mean(s : NetprotomqttView) -> Double { @_common.mean(s.data) }

pub fn net_proto_mqtt_view_scale(s : NetprotomqttView, f : Double) -> NetprotomqttView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_proto_mqtt_view_add(a : NetprotomqttView, b : NetprotomqttView) -> NetprotomqttView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_proto_mqtt_view_copy(s : NetprotomqttView) -> NetprotomqttView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_proto_mqtt_view_fill(s : NetprotomqttView, v : Double) -> NetprotomqttView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_proto_mqtt_view_min(s : NetprotomqttView) -> Double { @_common.min(s.data) }

pub fn net_proto_mqtt_view_max(s : NetprotomqttView) -> Double { @_common.max(s.data) }

pub fn net_proto_mqtt_view_to_string(s : NetprotomqttView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetprotomqttRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_proto_mqtt_range_make(size : Int) -> NetprotomqttRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_proto_mqtt_range_len(s : NetprotomqttRange) -> Int { s.size }

pub fn net_proto_mqtt_range_get(s : NetprotomqttRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_proto_mqtt_range_set(s : NetprotomqttRange, i : Int, v : Double) -> NetprotomqttRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn net_proto_mqtt_range_sum(s : NetprotomqttRange) -> Double { @_common.sum(s.data) }

pub fn net_proto_mqtt_range_mean(s : NetprotomqttRange) -> Double { @_common.mean(s.data) }

pub fn net_proto_mqtt_range_scale(s : NetprotomqttRange, f : Double) -> NetprotomqttRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_proto_mqtt_range_add(a : NetprotomqttRange, b : NetprotomqttRange) -> NetprotomqttRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_proto_mqtt_range_copy(s : NetprotomqttRange) -> NetprotomqttRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_proto_mqtt_range_fill(s : NetprotomqttRange, v : Double) -> NetprotomqttRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_proto_mqtt_range_min(s : NetprotomqttRange) -> Double { @_common.min(s.data) }

pub fn net_proto_mqtt_range_max(s : NetprotomqttRange) -> Double { @_common.max(s.data) }

pub fn net_proto_mqtt_range_to_string(s : NetprotomqttRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetprotomqttSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_proto_mqtt_slice_make(size : Int) -> NetprotomqttSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_proto_mqtt_slice_len(s : NetprotomqttSlice) -> Int { s.size }

pub fn net_proto_mqtt_slice_get(s : NetprotomqttSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_proto_mqtt_slice_set(s : NetprotomqttSlice, i : Int, v : Double) -> NetprotomqttSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn net_proto_mqtt_slice_sum(s : NetprotomqttSlice) -> Double { @_common.sum(s.data) }

pub fn net_proto_mqtt_slice_mean(s : NetprotomqttSlice) -> Double { @_common.mean(s.data) }

pub fn net_proto_mqtt_slice_scale(s : NetprotomqttSlice, f : Double) -> NetprotomqttSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_proto_mqtt_slice_add(a : NetprotomqttSlice, b : NetprotomqttSlice) -> NetprotomqttSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_proto_mqtt_slice_copy(s : NetprotomqttSlice) -> NetprotomqttSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_proto_mqtt_slice_fill(s : NetprotomqttSlice, v : Double) -> NetprotomqttSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_proto_mqtt_slice_min(s : NetprotomqttSlice) -> Double { @_common.min(s.data) }

pub fn net_proto_mqtt_slice_max(s : NetprotomqttSlice) -> Double { @_common.max(s.data) }

pub fn net_proto_mqtt_slice_to_string(s : NetprotomqttSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

