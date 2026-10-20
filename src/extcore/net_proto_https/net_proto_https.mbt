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

pub fn net_proto_https_frame_len(s : NetprotohttpsFrame) -> Int { s.size }

pub fn net_proto_https_frame_get(s : NetprotohttpsFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_proto_https_frame_set(s : NetprotohttpsFrame, i : Int, v : Double) -> NetprotohttpsFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn net_proto_https_frame_sum(s : NetprotohttpsFrame) -> Double { @_common.sum(s.data) }

pub fn net_proto_https_frame_mean(s : NetprotohttpsFrame) -> Double { @_common.mean(s.data) }

pub fn net_proto_https_frame_scale(s : NetprotohttpsFrame, f : Double) -> NetprotohttpsFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_proto_https_frame_add(a : NetprotohttpsFrame, b : NetprotohttpsFrame) -> NetprotohttpsFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_proto_https_frame_copy(s : NetprotohttpsFrame) -> NetprotohttpsFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_proto_https_frame_fill(s : NetprotohttpsFrame, v : Double) -> NetprotohttpsFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_proto_https_frame_min(s : NetprotohttpsFrame) -> Double { @_common.min(s.data) }

pub fn net_proto_https_frame_max(s : NetprotohttpsFrame) -> Double { @_common.max(s.data) }

pub fn net_proto_https_frame_to_string(s : NetprotohttpsFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetprotohttpsTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_proto_https_table_make(size : Int) -> NetprotohttpsTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_proto_https_table_len(s : NetprotohttpsTable) -> Int { s.size }

pub fn net_proto_https_table_get(s : NetprotohttpsTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_proto_https_table_set(s : NetprotohttpsTable, i : Int, v : Double) -> NetprotohttpsTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn net_proto_https_table_sum(s : NetprotohttpsTable) -> Double { @_common.sum(s.data) }

pub fn net_proto_https_table_mean(s : NetprotohttpsTable) -> Double { @_common.mean(s.data) }

pub fn net_proto_https_table_scale(s : NetprotohttpsTable, f : Double) -> NetprotohttpsTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_proto_https_table_add(a : NetprotohttpsTable, b : NetprotohttpsTable) -> NetprotohttpsTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_proto_https_table_copy(s : NetprotohttpsTable) -> NetprotohttpsTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_proto_https_table_fill(s : NetprotohttpsTable, v : Double) -> NetprotohttpsTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_proto_https_table_min(s : NetprotohttpsTable) -> Double { @_common.min(s.data) }

pub fn net_proto_https_table_max(s : NetprotohttpsTable) -> Double { @_common.max(s.data) }

pub fn net_proto_https_table_to_string(s : NetprotohttpsTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetprotohttpsGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_proto_https_graphn_make(size : Int) -> NetprotohttpsGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_proto_https_graphn_len(s : NetprotohttpsGraphN) -> Int { s.size }

pub fn net_proto_https_graphn_get(s : NetprotohttpsGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_proto_https_graphn_set(s : NetprotohttpsGraphN, i : Int, v : Double) -> NetprotohttpsGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn net_proto_https_graphn_sum(s : NetprotohttpsGraphN) -> Double { @_common.sum(s.data) }

pub fn net_proto_https_graphn_mean(s : NetprotohttpsGraphN) -> Double { @_common.mean(s.data) }

pub fn net_proto_https_graphn_scale(s : NetprotohttpsGraphN, f : Double) -> NetprotohttpsGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_proto_https_graphn_add(a : NetprotohttpsGraphN, b : NetprotohttpsGraphN) -> NetprotohttpsGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_proto_https_graphn_copy(s : NetprotohttpsGraphN) -> NetprotohttpsGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_proto_https_graphn_fill(s : NetprotohttpsGraphN, v : Double) -> NetprotohttpsGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_proto_https_graphn_min(s : NetprotohttpsGraphN) -> Double { @_common.min(s.data) }

pub fn net_proto_https_graphn_max(s : NetprotohttpsGraphN) -> Double { @_common.max(s.data) }

pub fn net_proto_https_graphn_to_string(s : NetprotohttpsGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetprotohttpsNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_proto_https_node_make(size : Int) -> NetprotohttpsNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_proto_https_node_len(s : NetprotohttpsNode) -> Int { s.size }

pub fn net_proto_https_node_get(s : NetprotohttpsNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_proto_https_node_set(s : NetprotohttpsNode, i : Int, v : Double) -> NetprotohttpsNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn net_proto_https_node_sum(s : NetprotohttpsNode) -> Double { @_common.sum(s.data) }

pub fn net_proto_https_node_mean(s : NetprotohttpsNode) -> Double { @_common.mean(s.data) }

pub fn net_proto_https_node_scale(s : NetprotohttpsNode, f : Double) -> NetprotohttpsNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_proto_https_node_add(a : NetprotohttpsNode, b : NetprotohttpsNode) -> NetprotohttpsNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_proto_https_node_copy(s : NetprotohttpsNode) -> NetprotohttpsNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_proto_https_node_fill(s : NetprotohttpsNode, v : Double) -> NetprotohttpsNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_proto_https_node_min(s : NetprotohttpsNode) -> Double { @_common.min(s.data) }

pub fn net_proto_https_node_max(s : NetprotohttpsNode) -> Double { @_common.max(s.data) }

pub fn net_proto_https_node_to_string(s : NetprotohttpsNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetprotohttpsEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_proto_https_edge_make(size : Int) -> NetprotohttpsEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_proto_https_edge_len(s : NetprotohttpsEdge) -> Int { s.size }

pub fn net_proto_https_edge_get(s : NetprotohttpsEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_proto_https_edge_set(s : NetprotohttpsEdge, i : Int, v : Double) -> NetprotohttpsEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn net_proto_https_edge_sum(s : NetprotohttpsEdge) -> Double { @_common.sum(s.data) }

pub fn net_proto_https_edge_mean(s : NetprotohttpsEdge) -> Double { @_common.mean(s.data) }

pub fn net_proto_https_edge_scale(s : NetprotohttpsEdge, f : Double) -> NetprotohttpsEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_proto_https_edge_add(a : NetprotohttpsEdge, b : NetprotohttpsEdge) -> NetprotohttpsEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_proto_https_edge_copy(s : NetprotohttpsEdge) -> NetprotohttpsEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_proto_https_edge_fill(s : NetprotohttpsEdge, v : Double) -> NetprotohttpsEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_proto_https_edge_min(s : NetprotohttpsEdge) -> Double { @_common.min(s.data) }

pub fn net_proto_https_edge_max(s : NetprotohttpsEdge) -> Double { @_common.max(s.data) }

pub fn net_proto_https_edge_to_string(s : NetprotohttpsEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetprotohttpsPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_proto_https_path_make(size : Int) -> NetprotohttpsPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_proto_https_path_len(s : NetprotohttpsPath) -> Int { s.size }

pub fn net_proto_https_path_get(s : NetprotohttpsPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_proto_https_path_set(s : NetprotohttpsPath, i : Int, v : Double) -> NetprotohttpsPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn net_proto_https_path_sum(s : NetprotohttpsPath) -> Double { @_common.sum(s.data) }

pub fn net_proto_https_path_mean(s : NetprotohttpsPath) -> Double { @_common.mean(s.data) }

pub fn net_proto_https_path_scale(s : NetprotohttpsPath, f : Double) -> NetprotohttpsPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_proto_https_path_add(a : NetprotohttpsPath, b : NetprotohttpsPath) -> NetprotohttpsPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_proto_https_path_copy(s : NetprotohttpsPath) -> NetprotohttpsPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_proto_https_path_fill(s : NetprotohttpsPath, v : Double) -> NetprotohttpsPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_proto_https_path_min(s : NetprotohttpsPath) -> Double { @_common.min(s.data) }

pub fn net_proto_https_path_max(s : NetprotohttpsPath) -> Double { @_common.max(s.data) }

pub fn net_proto_https_path_to_string(s : NetprotohttpsPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetprotohttpsCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_proto_https_cluster_make(size : Int) -> NetprotohttpsCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_proto_https_cluster_len(s : NetprotohttpsCluster) -> Int { s.size }

pub fn net_proto_https_cluster_get(s : NetprotohttpsCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_proto_https_cluster_set(s : NetprotohttpsCluster, i : Int, v : Double) -> NetprotohttpsCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn net_proto_https_cluster_sum(s : NetprotohttpsCluster) -> Double { @_common.sum(s.data) }

pub fn net_proto_https_cluster_mean(s : NetprotohttpsCluster) -> Double { @_common.mean(s.data) }

pub fn net_proto_https_cluster_scale(s : NetprotohttpsCluster, f : Double) -> NetprotohttpsCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_proto_https_cluster_add(a : NetprotohttpsCluster, b : NetprotohttpsCluster) -> NetprotohttpsCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_proto_https_cluster_copy(s : NetprotohttpsCluster) -> NetprotohttpsCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_proto_https_cluster_fill(s : NetprotohttpsCluster, v : Double) -> NetprotohttpsCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_proto_https_cluster_min(s : NetprotohttpsCluster) -> Double { @_common.min(s.data) }

pub fn net_proto_https_cluster_max(s : NetprotohttpsCluster) -> Double { @_common.max(s.data) }

pub fn net_proto_https_cluster_to_string(s : NetprotohttpsCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetprotohttpsModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_proto_https_model_make(size : Int) -> NetprotohttpsModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_proto_https_model_len(s : NetprotohttpsModel) -> Int { s.size }

pub fn net_proto_https_model_get(s : NetprotohttpsModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_proto_https_model_set(s : NetprotohttpsModel, i : Int, v : Double) -> NetprotohttpsModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn net_proto_https_model_sum(s : NetprotohttpsModel) -> Double { @_common.sum(s.data) }

pub fn net_proto_https_model_mean(s : NetprotohttpsModel) -> Double { @_common.mean(s.data) }

pub fn net_proto_https_model_scale(s : NetprotohttpsModel, f : Double) -> NetprotohttpsModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_proto_https_model_add(a : NetprotohttpsModel, b : NetprotohttpsModel) -> NetprotohttpsModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_proto_https_model_copy(s : NetprotohttpsModel) -> NetprotohttpsModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_proto_https_model_fill(s : NetprotohttpsModel, v : Double) -> NetprotohttpsModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_proto_https_model_min(s : NetprotohttpsModel) -> Double { @_common.min(s.data) }

pub fn net_proto_https_model_max(s : NetprotohttpsModel) -> Double { @_common.max(s.data) }

pub fn net_proto_https_model_to_string(s : NetprotohttpsModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetprotohttpsLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_proto_https_layer_make(size : Int) -> NetprotohttpsLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_proto_https_layer_len(s : NetprotohttpsLayer) -> Int { s.size }

pub fn net_proto_https_layer_get(s : NetprotohttpsLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_proto_https_layer_set(s : NetprotohttpsLayer, i : Int, v : Double) -> NetprotohttpsLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn net_proto_https_layer_sum(s : NetprotohttpsLayer) -> Double { @_common.sum(s.data) }

pub fn net_proto_https_layer_mean(s : NetprotohttpsLayer) -> Double { @_common.mean(s.data) }

pub fn net_proto_https_layer_scale(s : NetprotohttpsLayer, f : Double) -> NetprotohttpsLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_proto_https_layer_add(a : NetprotohttpsLayer, b : NetprotohttpsLayer) -> NetprotohttpsLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_proto_https_layer_copy(s : NetprotohttpsLayer) -> NetprotohttpsLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_proto_https_layer_fill(s : NetprotohttpsLayer, v : Double) -> NetprotohttpsLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_proto_https_layer_min(s : NetprotohttpsLayer) -> Double { @_common.min(s.data) }

pub fn net_proto_https_layer_max(s : NetprotohttpsLayer) -> Double { @_common.max(s.data) }

pub fn net_proto_https_layer_to_string(s : NetprotohttpsLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetprotohttpsBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_proto_https_buffer_make(size : Int) -> NetprotohttpsBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_proto_https_buffer_len(s : NetprotohttpsBuffer) -> Int { s.size }

pub fn net_proto_https_buffer_get(s : NetprotohttpsBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_proto_https_buffer_set(s : NetprotohttpsBuffer, i : Int, v : Double) -> NetprotohttpsBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn net_proto_https_buffer_sum(s : NetprotohttpsBuffer) -> Double { @_common.sum(s.data) }

pub fn net_proto_https_buffer_mean(s : NetprotohttpsBuffer) -> Double { @_common.mean(s.data) }

pub fn net_proto_https_buffer_scale(s : NetprotohttpsBuffer, f : Double) -> NetprotohttpsBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_proto_https_buffer_add(a : NetprotohttpsBuffer, b : NetprotohttpsBuffer) -> NetprotohttpsBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_proto_https_buffer_copy(s : NetprotohttpsBuffer) -> NetprotohttpsBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_proto_https_buffer_fill(s : NetprotohttpsBuffer, v : Double) -> NetprotohttpsBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_proto_https_buffer_min(s : NetprotohttpsBuffer) -> Double { @_common.min(s.data) }

pub fn net_proto_https_buffer_max(s : NetprotohttpsBuffer) -> Double { @_common.max(s.data) }

pub fn net_proto_https_buffer_to_string(s : NetprotohttpsBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetprotohttpsCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_proto_https_cursor_make(size : Int) -> NetprotohttpsCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_proto_https_cursor_len(s : NetprotohttpsCursor) -> Int { s.size }

pub fn net_proto_https_cursor_get(s : NetprotohttpsCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_proto_https_cursor_set(s : NetprotohttpsCursor, i : Int, v : Double) -> NetprotohttpsCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn net_proto_https_cursor_sum(s : NetprotohttpsCursor) -> Double { @_common.sum(s.data) }

pub fn net_proto_https_cursor_mean(s : NetprotohttpsCursor) -> Double { @_common.mean(s.data) }

pub fn net_proto_https_cursor_scale(s : NetprotohttpsCursor, f : Double) -> NetprotohttpsCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_proto_https_cursor_add(a : NetprotohttpsCursor, b : NetprotohttpsCursor) -> NetprotohttpsCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_proto_https_cursor_copy(s : NetprotohttpsCursor) -> NetprotohttpsCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_proto_https_cursor_fill(s : NetprotohttpsCursor, v : Double) -> NetprotohttpsCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_proto_https_cursor_min(s : NetprotohttpsCursor) -> Double { @_common.min(s.data) }

pub fn net_proto_https_cursor_max(s : NetprotohttpsCursor) -> Double { @_common.max(s.data) }

pub fn net_proto_https_cursor_to_string(s : NetprotohttpsCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetprotohttpsView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_proto_https_view_make(size : Int) -> NetprotohttpsView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_proto_https_view_len(s : NetprotohttpsView) -> Int { s.size }

pub fn net_proto_https_view_get(s : NetprotohttpsView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_proto_https_view_set(s : NetprotohttpsView, i : Int, v : Double) -> NetprotohttpsView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn net_proto_https_view_sum(s : NetprotohttpsView) -> Double { @_common.sum(s.data) }

pub fn net_proto_https_view_mean(s : NetprotohttpsView) -> Double { @_common.mean(s.data) }

pub fn net_proto_https_view_scale(s : NetprotohttpsView, f : Double) -> NetprotohttpsView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_proto_https_view_add(a : NetprotohttpsView, b : NetprotohttpsView) -> NetprotohttpsView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_proto_https_view_copy(s : NetprotohttpsView) -> NetprotohttpsView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_proto_https_view_fill(s : NetprotohttpsView, v : Double) -> NetprotohttpsView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_proto_https_view_min(s : NetprotohttpsView) -> Double { @_common.min(s.data) }

pub fn net_proto_https_view_max(s : NetprotohttpsView) -> Double { @_common.max(s.data) }

pub fn net_proto_https_view_to_string(s : NetprotohttpsView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetprotohttpsRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_proto_https_range_make(size : Int) -> NetprotohttpsRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_proto_https_range_len(s : NetprotohttpsRange) -> Int { s.size }

pub fn net_proto_https_range_get(s : NetprotohttpsRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_proto_https_range_set(s : NetprotohttpsRange, i : Int, v : Double) -> NetprotohttpsRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn net_proto_https_range_sum(s : NetprotohttpsRange) -> Double { @_common.sum(s.data) }

pub fn net_proto_https_range_mean(s : NetprotohttpsRange) -> Double { @_common.mean(s.data) }

pub fn net_proto_https_range_scale(s : NetprotohttpsRange, f : Double) -> NetprotohttpsRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_proto_https_range_add(a : NetprotohttpsRange, b : NetprotohttpsRange) -> NetprotohttpsRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_proto_https_range_copy(s : NetprotohttpsRange) -> NetprotohttpsRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_proto_https_range_fill(s : NetprotohttpsRange, v : Double) -> NetprotohttpsRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_proto_https_range_min(s : NetprotohttpsRange) -> Double { @_common.min(s.data) }

pub fn net_proto_https_range_max(s : NetprotohttpsRange) -> Double { @_common.max(s.data) }

pub fn net_proto_https_range_to_string(s : NetprotohttpsRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetprotohttpsSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_proto_https_slice_make(size : Int) -> NetprotohttpsSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_proto_https_slice_len(s : NetprotohttpsSlice) -> Int { s.size }

pub fn net_proto_https_slice_get(s : NetprotohttpsSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_proto_https_slice_set(s : NetprotohttpsSlice, i : Int, v : Double) -> NetprotohttpsSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn net_proto_https_slice_sum(s : NetprotohttpsSlice) -> Double { @_common.sum(s.data) }

pub fn net_proto_https_slice_mean(s : NetprotohttpsSlice) -> Double { @_common.mean(s.data) }

pub fn net_proto_https_slice_scale(s : NetprotohttpsSlice, f : Double) -> NetprotohttpsSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_proto_https_slice_add(a : NetprotohttpsSlice, b : NetprotohttpsSlice) -> NetprotohttpsSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_proto_https_slice_copy(s : NetprotohttpsSlice) -> NetprotohttpsSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_proto_https_slice_fill(s : NetprotohttpsSlice, v : Double) -> NetprotohttpsSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_proto_https_slice_min(s : NetprotohttpsSlice) -> Double { @_common.min(s.data) }

pub fn net_proto_https_slice_max(s : NetprotohttpsSlice) -> Double { @_common.max(s.data) }

pub fn net_proto_https_slice_to_string(s : NetprotohttpsSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

