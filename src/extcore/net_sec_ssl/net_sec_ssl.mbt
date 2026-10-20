///===
/// extcore/net_sec_ssl

pub(all) struct NetsecsslPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn net_sec_ssl_make_point(x : Double, y : Double) -> NetsecsslPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn net_sec_ssl_make_point3(x : Double, y : Double, z : Double) -> NetsecsslPoint {
  { x, y, z, label: 0 }
}

pub fn NetsecsslPoint::x(self : NetsecsslPoint) -> Double { self.x }

pub fn NetsecsslPoint::y(self : NetsecsslPoint) -> Double { self.y }

pub fn NetsecsslPoint::z(self : NetsecsslPoint) -> Double { self.z }

pub fn NetsecsslPoint::label(self : NetsecsslPoint) -> Int { self.label }

pub fn NetsecsslPoint::dist(self : NetsecsslPoint, other : NetsecsslPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn NetsecsslPoint::add(self : NetsecsslPoint, other : NetsecsslPoint) -> NetsecsslPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn NetsecsslPoint::sub(self : NetsecsslPoint, other : NetsecsslPoint) -> NetsecsslPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn NetsecsslPoint::scale(self : NetsecsslPoint, s : Double) -> NetsecsslPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn NetsecsslPoint::dot(self : NetsecsslPoint, other : NetsecsslPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn NetsecsslPoint::cross(self : NetsecsslPoint, other : NetsecsslPoint) -> NetsecsslPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn NetsecsslPoint::norm(self : NetsecsslPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn NetsecsslPoint::normalize(self : NetsecsslPoint) -> NetsecsslPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn NetsecsslPoint::negate(self : NetsecsslPoint) -> NetsecsslPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn NetsecsslPoint::mid(self : NetsecsslPoint, other : NetsecsslPoint) -> NetsecsslPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn NetsecsslPoint::lerp(self : NetsecsslPoint, other : NetsecsslPoint, t : Double) -> NetsecsslPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn NetsecsslPoint::to_string(self : NetsecsslPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct NetsecsslSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn net_sec_ssl_make_series(vals : Array[Double], name : String) -> NetsecsslSeries {
  { vals, name, meta: 0 }
}

pub fn NetsecsslSeries::len(self : NetsecsslSeries) -> Int { self.vals.length() }

pub fn NetsecsslSeries::sum(self : NetsecsslSeries) -> Double { @_common.sum(self.vals) }

pub fn NetsecsslSeries::mean(self : NetsecsslSeries) -> Double { @_common.mean(self.vals) }

pub fn NetsecsslSeries::min(self : NetsecsslSeries) -> Double { @_common.min(self.vals) }

pub fn NetsecsslSeries::max(self : NetsecsslSeries) -> Double { @_common.max(self.vals) }

pub fn NetsecsslSeries::range(self : NetsecsslSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn NetsecsslSeries::variance(self : NetsecsslSeries) -> Double { @_common.variance(self.vals) }

pub fn NetsecsslSeries::std(self : NetsecsslSeries) -> Double { @_common.std(self.vals) }

pub fn NetsecsslSeries::median(self : NetsecsslSeries) -> Double { @_common.median(self.vals) }

pub fn NetsecsslSeries::scale(self : NetsecsslSeries, f : Double) -> NetsecsslSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn NetsecsslSeries::add(self : NetsecsslSeries, other : NetsecsslSeries) -> NetsecsslSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn NetsecsslSeries::sub(self : NetsecsslSeries, other : NetsecsslSeries) -> NetsecsslSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn NetsecsslSeries::normalize(self : NetsecsslSeries) -> NetsecsslSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn NetsecsslSeries::cumsum(self : NetsecsslSeries) -> NetsecsslSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn NetsecsslSeries::to_string(self : NetsecsslSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct NetsecsslMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn net_sec_ssl_make_matrix(rows : Int, cols : Int, val : Double) -> NetsecsslMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn net_sec_ssl_matrix_identity(n : Int) -> NetsecsslMatrix {
  let m = net_sec_ssl_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn NetsecsslMatrix::get(self : NetsecsslMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn NetsecsslMatrix::transpose(self : NetsecsslMatrix) -> NetsecsslMatrix {
  let result = net_sec_ssl_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn NetsecsslMatrix::add(self : NetsecsslMatrix, other : NetsecsslMatrix) -> NetsecsslMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = net_sec_ssl_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn NetsecsslMatrix::scale(self : NetsecsslMatrix, s : Double) -> NetsecsslMatrix {
  let result = net_sec_ssl_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn NetsecsslMatrix::multiply(self : NetsecsslMatrix, other : NetsecsslMatrix) -> NetsecsslMatrix {
  if self.cols != other.rows { return net_sec_ssl_make_matrix(self.rows, other.cols, 0.0) }
  let result = net_sec_ssl_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn NetsecsslMatrix::trace(self : NetsecsslMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn NetsecsslMatrix::det(self : NetsecsslMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn NetsecsslMatrix::norm(self : NetsecsslMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn NetsecsslMatrix::to_string(self : NetsecsslMatrix) -> String {
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

pub(all) struct NetsecsslVector {
  comps : Array[Double]
  dim : Int
}

pub fn net_sec_ssl_make_vector(comps : Array[Double]) -> NetsecsslVector {
  { comps, dim: comps.length() }
}

pub fn net_sec_ssl_vector_zero(dim : Int) -> NetsecsslVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn NetsecsslVector::add(self : NetsecsslVector, other : NetsecsslVector) -> NetsecsslVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn NetsecsslVector::sub(self : NetsecsslVector, other : NetsecsslVector) -> NetsecsslVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn NetsecsslVector::scale(self : NetsecsslVector, s : Double) -> NetsecsslVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn NetsecsslVector::dot(self : NetsecsslVector, other : NetsecsslVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn NetsecsslVector::norm(self : NetsecsslVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn NetsecsslVector::normalize(self : NetsecsslVector) -> NetsecsslVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn NetsecsslVector::dist(self : NetsecsslVector, other : NetsecsslVector) -> Double {
  self.sub(other).norm()
}

pub fn NetsecsslVector::to_string(self : NetsecsslVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn net_sec_ssl_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn net_sec_ssl_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn net_sec_ssl_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn net_sec_ssl_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn net_sec_ssl_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn net_sec_ssl_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn net_sec_ssl_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn net_sec_ssl_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn net_sec_ssl_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn net_sec_ssl_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn net_sec_ssl_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn net_sec_ssl_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn net_sec_ssl_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn net_sec_ssl_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn net_sec_ssl_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn net_sec_ssl_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn net_sec_ssl_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn net_sec_ssl_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn net_sec_ssl_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn net_sec_ssl_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn net_sec_ssl_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn net_sec_ssl_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn net_sec_ssl_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn net_sec_ssl_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn net_sec_ssl_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn net_sec_ssl_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn net_sec_ssl_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn net_sec_ssl_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn net_sec_ssl_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct NetsecsslFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_sec_ssl_frame_make(size : Int) -> NetsecsslFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_sec_ssl_frame_len(s : NetsecsslFrame) -> Int { s.size }

pub fn net_sec_ssl_frame_get(s : NetsecsslFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_sec_ssl_frame_set(s : NetsecsslFrame, i : Int, v : Double) -> NetsecsslFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn net_sec_ssl_frame_sum(s : NetsecsslFrame) -> Double { @_common.sum(s.data) }

pub fn net_sec_ssl_frame_mean(s : NetsecsslFrame) -> Double { @_common.mean(s.data) }

pub fn net_sec_ssl_frame_scale(s : NetsecsslFrame, f : Double) -> NetsecsslFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_sec_ssl_frame_add(a : NetsecsslFrame, b : NetsecsslFrame) -> NetsecsslFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_sec_ssl_frame_copy(s : NetsecsslFrame) -> NetsecsslFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_sec_ssl_frame_fill(s : NetsecsslFrame, v : Double) -> NetsecsslFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_sec_ssl_frame_min(s : NetsecsslFrame) -> Double { @_common.min(s.data) }

pub fn net_sec_ssl_frame_max(s : NetsecsslFrame) -> Double { @_common.max(s.data) }

pub fn net_sec_ssl_frame_to_string(s : NetsecsslFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetsecsslTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_sec_ssl_table_make(size : Int) -> NetsecsslTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_sec_ssl_table_len(s : NetsecsslTable) -> Int { s.size }

pub fn net_sec_ssl_table_get(s : NetsecsslTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_sec_ssl_table_set(s : NetsecsslTable, i : Int, v : Double) -> NetsecsslTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn net_sec_ssl_table_sum(s : NetsecsslTable) -> Double { @_common.sum(s.data) }

pub fn net_sec_ssl_table_mean(s : NetsecsslTable) -> Double { @_common.mean(s.data) }

pub fn net_sec_ssl_table_scale(s : NetsecsslTable, f : Double) -> NetsecsslTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_sec_ssl_table_add(a : NetsecsslTable, b : NetsecsslTable) -> NetsecsslTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_sec_ssl_table_copy(s : NetsecsslTable) -> NetsecsslTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_sec_ssl_table_fill(s : NetsecsslTable, v : Double) -> NetsecsslTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_sec_ssl_table_min(s : NetsecsslTable) -> Double { @_common.min(s.data) }

pub fn net_sec_ssl_table_max(s : NetsecsslTable) -> Double { @_common.max(s.data) }

pub fn net_sec_ssl_table_to_string(s : NetsecsslTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetsecsslGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_sec_ssl_graphn_make(size : Int) -> NetsecsslGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_sec_ssl_graphn_len(s : NetsecsslGraphN) -> Int { s.size }

pub fn net_sec_ssl_graphn_get(s : NetsecsslGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_sec_ssl_graphn_set(s : NetsecsslGraphN, i : Int, v : Double) -> NetsecsslGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn net_sec_ssl_graphn_sum(s : NetsecsslGraphN) -> Double { @_common.sum(s.data) }

pub fn net_sec_ssl_graphn_mean(s : NetsecsslGraphN) -> Double { @_common.mean(s.data) }

pub fn net_sec_ssl_graphn_scale(s : NetsecsslGraphN, f : Double) -> NetsecsslGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_sec_ssl_graphn_add(a : NetsecsslGraphN, b : NetsecsslGraphN) -> NetsecsslGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_sec_ssl_graphn_copy(s : NetsecsslGraphN) -> NetsecsslGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_sec_ssl_graphn_fill(s : NetsecsslGraphN, v : Double) -> NetsecsslGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_sec_ssl_graphn_min(s : NetsecsslGraphN) -> Double { @_common.min(s.data) }

pub fn net_sec_ssl_graphn_max(s : NetsecsslGraphN) -> Double { @_common.max(s.data) }

pub fn net_sec_ssl_graphn_to_string(s : NetsecsslGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetsecsslNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_sec_ssl_node_make(size : Int) -> NetsecsslNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_sec_ssl_node_len(s : NetsecsslNode) -> Int { s.size }

pub fn net_sec_ssl_node_get(s : NetsecsslNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_sec_ssl_node_set(s : NetsecsslNode, i : Int, v : Double) -> NetsecsslNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn net_sec_ssl_node_sum(s : NetsecsslNode) -> Double { @_common.sum(s.data) }

pub fn net_sec_ssl_node_mean(s : NetsecsslNode) -> Double { @_common.mean(s.data) }

pub fn net_sec_ssl_node_scale(s : NetsecsslNode, f : Double) -> NetsecsslNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_sec_ssl_node_add(a : NetsecsslNode, b : NetsecsslNode) -> NetsecsslNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_sec_ssl_node_copy(s : NetsecsslNode) -> NetsecsslNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_sec_ssl_node_fill(s : NetsecsslNode, v : Double) -> NetsecsslNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_sec_ssl_node_min(s : NetsecsslNode) -> Double { @_common.min(s.data) }

pub fn net_sec_ssl_node_max(s : NetsecsslNode) -> Double { @_common.max(s.data) }

pub fn net_sec_ssl_node_to_string(s : NetsecsslNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetsecsslEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_sec_ssl_edge_make(size : Int) -> NetsecsslEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_sec_ssl_edge_len(s : NetsecsslEdge) -> Int { s.size }

pub fn net_sec_ssl_edge_get(s : NetsecsslEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_sec_ssl_edge_set(s : NetsecsslEdge, i : Int, v : Double) -> NetsecsslEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn net_sec_ssl_edge_sum(s : NetsecsslEdge) -> Double { @_common.sum(s.data) }

pub fn net_sec_ssl_edge_mean(s : NetsecsslEdge) -> Double { @_common.mean(s.data) }

pub fn net_sec_ssl_edge_scale(s : NetsecsslEdge, f : Double) -> NetsecsslEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_sec_ssl_edge_add(a : NetsecsslEdge, b : NetsecsslEdge) -> NetsecsslEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_sec_ssl_edge_copy(s : NetsecsslEdge) -> NetsecsslEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_sec_ssl_edge_fill(s : NetsecsslEdge, v : Double) -> NetsecsslEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_sec_ssl_edge_min(s : NetsecsslEdge) -> Double { @_common.min(s.data) }

pub fn net_sec_ssl_edge_max(s : NetsecsslEdge) -> Double { @_common.max(s.data) }

pub fn net_sec_ssl_edge_to_string(s : NetsecsslEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetsecsslPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_sec_ssl_path_make(size : Int) -> NetsecsslPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_sec_ssl_path_len(s : NetsecsslPath) -> Int { s.size }

pub fn net_sec_ssl_path_get(s : NetsecsslPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_sec_ssl_path_set(s : NetsecsslPath, i : Int, v : Double) -> NetsecsslPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn net_sec_ssl_path_sum(s : NetsecsslPath) -> Double { @_common.sum(s.data) }

pub fn net_sec_ssl_path_mean(s : NetsecsslPath) -> Double { @_common.mean(s.data) }

pub fn net_sec_ssl_path_scale(s : NetsecsslPath, f : Double) -> NetsecsslPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_sec_ssl_path_add(a : NetsecsslPath, b : NetsecsslPath) -> NetsecsslPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_sec_ssl_path_copy(s : NetsecsslPath) -> NetsecsslPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_sec_ssl_path_fill(s : NetsecsslPath, v : Double) -> NetsecsslPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_sec_ssl_path_min(s : NetsecsslPath) -> Double { @_common.min(s.data) }

pub fn net_sec_ssl_path_max(s : NetsecsslPath) -> Double { @_common.max(s.data) }

pub fn net_sec_ssl_path_to_string(s : NetsecsslPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetsecsslCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_sec_ssl_cluster_make(size : Int) -> NetsecsslCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_sec_ssl_cluster_len(s : NetsecsslCluster) -> Int { s.size }

pub fn net_sec_ssl_cluster_get(s : NetsecsslCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_sec_ssl_cluster_set(s : NetsecsslCluster, i : Int, v : Double) -> NetsecsslCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn net_sec_ssl_cluster_sum(s : NetsecsslCluster) -> Double { @_common.sum(s.data) }

pub fn net_sec_ssl_cluster_mean(s : NetsecsslCluster) -> Double { @_common.mean(s.data) }

pub fn net_sec_ssl_cluster_scale(s : NetsecsslCluster, f : Double) -> NetsecsslCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_sec_ssl_cluster_add(a : NetsecsslCluster, b : NetsecsslCluster) -> NetsecsslCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_sec_ssl_cluster_copy(s : NetsecsslCluster) -> NetsecsslCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_sec_ssl_cluster_fill(s : NetsecsslCluster, v : Double) -> NetsecsslCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_sec_ssl_cluster_min(s : NetsecsslCluster) -> Double { @_common.min(s.data) }

pub fn net_sec_ssl_cluster_max(s : NetsecsslCluster) -> Double { @_common.max(s.data) }

pub fn net_sec_ssl_cluster_to_string(s : NetsecsslCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetsecsslModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_sec_ssl_model_make(size : Int) -> NetsecsslModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_sec_ssl_model_len(s : NetsecsslModel) -> Int { s.size }

pub fn net_sec_ssl_model_get(s : NetsecsslModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_sec_ssl_model_set(s : NetsecsslModel, i : Int, v : Double) -> NetsecsslModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn net_sec_ssl_model_sum(s : NetsecsslModel) -> Double { @_common.sum(s.data) }

pub fn net_sec_ssl_model_mean(s : NetsecsslModel) -> Double { @_common.mean(s.data) }

pub fn net_sec_ssl_model_scale(s : NetsecsslModel, f : Double) -> NetsecsslModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_sec_ssl_model_add(a : NetsecsslModel, b : NetsecsslModel) -> NetsecsslModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_sec_ssl_model_copy(s : NetsecsslModel) -> NetsecsslModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_sec_ssl_model_fill(s : NetsecsslModel, v : Double) -> NetsecsslModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_sec_ssl_model_min(s : NetsecsslModel) -> Double { @_common.min(s.data) }

pub fn net_sec_ssl_model_max(s : NetsecsslModel) -> Double { @_common.max(s.data) }

pub fn net_sec_ssl_model_to_string(s : NetsecsslModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetsecsslLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_sec_ssl_layer_make(size : Int) -> NetsecsslLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_sec_ssl_layer_len(s : NetsecsslLayer) -> Int { s.size }

pub fn net_sec_ssl_layer_get(s : NetsecsslLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_sec_ssl_layer_set(s : NetsecsslLayer, i : Int, v : Double) -> NetsecsslLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn net_sec_ssl_layer_sum(s : NetsecsslLayer) -> Double { @_common.sum(s.data) }

pub fn net_sec_ssl_layer_mean(s : NetsecsslLayer) -> Double { @_common.mean(s.data) }

pub fn net_sec_ssl_layer_scale(s : NetsecsslLayer, f : Double) -> NetsecsslLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_sec_ssl_layer_add(a : NetsecsslLayer, b : NetsecsslLayer) -> NetsecsslLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_sec_ssl_layer_copy(s : NetsecsslLayer) -> NetsecsslLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_sec_ssl_layer_fill(s : NetsecsslLayer, v : Double) -> NetsecsslLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_sec_ssl_layer_min(s : NetsecsslLayer) -> Double { @_common.min(s.data) }

pub fn net_sec_ssl_layer_max(s : NetsecsslLayer) -> Double { @_common.max(s.data) }

pub fn net_sec_ssl_layer_to_string(s : NetsecsslLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetsecsslBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_sec_ssl_buffer_make(size : Int) -> NetsecsslBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_sec_ssl_buffer_len(s : NetsecsslBuffer) -> Int { s.size }

pub fn net_sec_ssl_buffer_get(s : NetsecsslBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_sec_ssl_buffer_set(s : NetsecsslBuffer, i : Int, v : Double) -> NetsecsslBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn net_sec_ssl_buffer_sum(s : NetsecsslBuffer) -> Double { @_common.sum(s.data) }

pub fn net_sec_ssl_buffer_mean(s : NetsecsslBuffer) -> Double { @_common.mean(s.data) }

pub fn net_sec_ssl_buffer_scale(s : NetsecsslBuffer, f : Double) -> NetsecsslBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_sec_ssl_buffer_add(a : NetsecsslBuffer, b : NetsecsslBuffer) -> NetsecsslBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_sec_ssl_buffer_copy(s : NetsecsslBuffer) -> NetsecsslBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_sec_ssl_buffer_fill(s : NetsecsslBuffer, v : Double) -> NetsecsslBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_sec_ssl_buffer_min(s : NetsecsslBuffer) -> Double { @_common.min(s.data) }

pub fn net_sec_ssl_buffer_max(s : NetsecsslBuffer) -> Double { @_common.max(s.data) }

pub fn net_sec_ssl_buffer_to_string(s : NetsecsslBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetsecsslCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_sec_ssl_cursor_make(size : Int) -> NetsecsslCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_sec_ssl_cursor_len(s : NetsecsslCursor) -> Int { s.size }

pub fn net_sec_ssl_cursor_get(s : NetsecsslCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_sec_ssl_cursor_set(s : NetsecsslCursor, i : Int, v : Double) -> NetsecsslCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn net_sec_ssl_cursor_sum(s : NetsecsslCursor) -> Double { @_common.sum(s.data) }

pub fn net_sec_ssl_cursor_mean(s : NetsecsslCursor) -> Double { @_common.mean(s.data) }

pub fn net_sec_ssl_cursor_scale(s : NetsecsslCursor, f : Double) -> NetsecsslCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_sec_ssl_cursor_add(a : NetsecsslCursor, b : NetsecsslCursor) -> NetsecsslCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_sec_ssl_cursor_copy(s : NetsecsslCursor) -> NetsecsslCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_sec_ssl_cursor_fill(s : NetsecsslCursor, v : Double) -> NetsecsslCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_sec_ssl_cursor_min(s : NetsecsslCursor) -> Double { @_common.min(s.data) }

pub fn net_sec_ssl_cursor_max(s : NetsecsslCursor) -> Double { @_common.max(s.data) }

pub fn net_sec_ssl_cursor_to_string(s : NetsecsslCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetsecsslView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_sec_ssl_view_make(size : Int) -> NetsecsslView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_sec_ssl_view_len(s : NetsecsslView) -> Int { s.size }

pub fn net_sec_ssl_view_get(s : NetsecsslView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_sec_ssl_view_set(s : NetsecsslView, i : Int, v : Double) -> NetsecsslView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn net_sec_ssl_view_sum(s : NetsecsslView) -> Double { @_common.sum(s.data) }

pub fn net_sec_ssl_view_mean(s : NetsecsslView) -> Double { @_common.mean(s.data) }

pub fn net_sec_ssl_view_scale(s : NetsecsslView, f : Double) -> NetsecsslView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_sec_ssl_view_add(a : NetsecsslView, b : NetsecsslView) -> NetsecsslView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_sec_ssl_view_copy(s : NetsecsslView) -> NetsecsslView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_sec_ssl_view_fill(s : NetsecsslView, v : Double) -> NetsecsslView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_sec_ssl_view_min(s : NetsecsslView) -> Double { @_common.min(s.data) }

pub fn net_sec_ssl_view_max(s : NetsecsslView) -> Double { @_common.max(s.data) }

pub fn net_sec_ssl_view_to_string(s : NetsecsslView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetsecsslRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_sec_ssl_range_make(size : Int) -> NetsecsslRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_sec_ssl_range_len(s : NetsecsslRange) -> Int { s.size }

pub fn net_sec_ssl_range_get(s : NetsecsslRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_sec_ssl_range_set(s : NetsecsslRange, i : Int, v : Double) -> NetsecsslRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn net_sec_ssl_range_sum(s : NetsecsslRange) -> Double { @_common.sum(s.data) }

pub fn net_sec_ssl_range_mean(s : NetsecsslRange) -> Double { @_common.mean(s.data) }

pub fn net_sec_ssl_range_scale(s : NetsecsslRange, f : Double) -> NetsecsslRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_sec_ssl_range_add(a : NetsecsslRange, b : NetsecsslRange) -> NetsecsslRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_sec_ssl_range_copy(s : NetsecsslRange) -> NetsecsslRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_sec_ssl_range_fill(s : NetsecsslRange, v : Double) -> NetsecsslRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_sec_ssl_range_min(s : NetsecsslRange) -> Double { @_common.min(s.data) }

pub fn net_sec_ssl_range_max(s : NetsecsslRange) -> Double { @_common.max(s.data) }

pub fn net_sec_ssl_range_to_string(s : NetsecsslRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetsecsslSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_sec_ssl_slice_make(size : Int) -> NetsecsslSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_sec_ssl_slice_len(s : NetsecsslSlice) -> Int { s.size }

pub fn net_sec_ssl_slice_get(s : NetsecsslSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_sec_ssl_slice_set(s : NetsecsslSlice, i : Int, v : Double) -> NetsecsslSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn net_sec_ssl_slice_sum(s : NetsecsslSlice) -> Double { @_common.sum(s.data) }

pub fn net_sec_ssl_slice_mean(s : NetsecsslSlice) -> Double { @_common.mean(s.data) }

pub fn net_sec_ssl_slice_scale(s : NetsecsslSlice, f : Double) -> NetsecsslSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_sec_ssl_slice_add(a : NetsecsslSlice, b : NetsecsslSlice) -> NetsecsslSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_sec_ssl_slice_copy(s : NetsecsslSlice) -> NetsecsslSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_sec_ssl_slice_fill(s : NetsecsslSlice, v : Double) -> NetsecsslSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_sec_ssl_slice_min(s : NetsecsslSlice) -> Double { @_common.min(s.data) }

pub fn net_sec_ssl_slice_max(s : NetsecsslSlice) -> Double { @_common.max(s.data) }

pub fn net_sec_ssl_slice_to_string(s : NetsecsslSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

