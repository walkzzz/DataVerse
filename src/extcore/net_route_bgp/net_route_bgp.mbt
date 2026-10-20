///===
/// extcore/net_route_bgp

pub(all) struct NetroutebgpPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn net_route_bgp_make_point(x : Double, y : Double) -> NetroutebgpPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn net_route_bgp_make_point3(x : Double, y : Double, z : Double) -> NetroutebgpPoint {
  { x, y, z, label: 0 }
}

pub fn NetroutebgpPoint::x(self : NetroutebgpPoint) -> Double { self.x }

pub fn NetroutebgpPoint::y(self : NetroutebgpPoint) -> Double { self.y }

pub fn NetroutebgpPoint::z(self : NetroutebgpPoint) -> Double { self.z }

pub fn NetroutebgpPoint::label(self : NetroutebgpPoint) -> Int { self.label }

pub fn NetroutebgpPoint::dist(self : NetroutebgpPoint, other : NetroutebgpPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn NetroutebgpPoint::add(self : NetroutebgpPoint, other : NetroutebgpPoint) -> NetroutebgpPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn NetroutebgpPoint::sub(self : NetroutebgpPoint, other : NetroutebgpPoint) -> NetroutebgpPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn NetroutebgpPoint::scale(self : NetroutebgpPoint, s : Double) -> NetroutebgpPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn NetroutebgpPoint::dot(self : NetroutebgpPoint, other : NetroutebgpPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn NetroutebgpPoint::cross(self : NetroutebgpPoint, other : NetroutebgpPoint) -> NetroutebgpPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn NetroutebgpPoint::norm(self : NetroutebgpPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn NetroutebgpPoint::normalize(self : NetroutebgpPoint) -> NetroutebgpPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn NetroutebgpPoint::negate(self : NetroutebgpPoint) -> NetroutebgpPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn NetroutebgpPoint::mid(self : NetroutebgpPoint, other : NetroutebgpPoint) -> NetroutebgpPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn NetroutebgpPoint::lerp(self : NetroutebgpPoint, other : NetroutebgpPoint, t : Double) -> NetroutebgpPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn NetroutebgpPoint::to_string(self : NetroutebgpPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct NetroutebgpSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn net_route_bgp_make_series(vals : Array[Double], name : String) -> NetroutebgpSeries {
  { vals, name, meta: 0 }
}

pub fn NetroutebgpSeries::len(self : NetroutebgpSeries) -> Int { self.vals.length() }

pub fn NetroutebgpSeries::sum(self : NetroutebgpSeries) -> Double { @_common.sum(self.vals) }

pub fn NetroutebgpSeries::mean(self : NetroutebgpSeries) -> Double { @_common.mean(self.vals) }

pub fn NetroutebgpSeries::min(self : NetroutebgpSeries) -> Double { @_common.min(self.vals) }

pub fn NetroutebgpSeries::max(self : NetroutebgpSeries) -> Double { @_common.max(self.vals) }

pub fn NetroutebgpSeries::range(self : NetroutebgpSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn NetroutebgpSeries::variance(self : NetroutebgpSeries) -> Double { @_common.variance(self.vals) }

pub fn NetroutebgpSeries::std(self : NetroutebgpSeries) -> Double { @_common.std(self.vals) }

pub fn NetroutebgpSeries::median(self : NetroutebgpSeries) -> Double { @_common.median(self.vals) }

pub fn NetroutebgpSeries::scale(self : NetroutebgpSeries, f : Double) -> NetroutebgpSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn NetroutebgpSeries::add(self : NetroutebgpSeries, other : NetroutebgpSeries) -> NetroutebgpSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn NetroutebgpSeries::sub(self : NetroutebgpSeries, other : NetroutebgpSeries) -> NetroutebgpSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn NetroutebgpSeries::normalize(self : NetroutebgpSeries) -> NetroutebgpSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn NetroutebgpSeries::cumsum(self : NetroutebgpSeries) -> NetroutebgpSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn NetroutebgpSeries::to_string(self : NetroutebgpSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct NetroutebgpMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn net_route_bgp_make_matrix(rows : Int, cols : Int, val : Double) -> NetroutebgpMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn net_route_bgp_matrix_identity(n : Int) -> NetroutebgpMatrix {
  let m = net_route_bgp_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn NetroutebgpMatrix::get(self : NetroutebgpMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn NetroutebgpMatrix::transpose(self : NetroutebgpMatrix) -> NetroutebgpMatrix {
  let result = net_route_bgp_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn NetroutebgpMatrix::add(self : NetroutebgpMatrix, other : NetroutebgpMatrix) -> NetroutebgpMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = net_route_bgp_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn NetroutebgpMatrix::scale(self : NetroutebgpMatrix, s : Double) -> NetroutebgpMatrix {
  let result = net_route_bgp_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn NetroutebgpMatrix::multiply(self : NetroutebgpMatrix, other : NetroutebgpMatrix) -> NetroutebgpMatrix {
  if self.cols != other.rows { return net_route_bgp_make_matrix(self.rows, other.cols, 0.0) }
  let result = net_route_bgp_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn NetroutebgpMatrix::trace(self : NetroutebgpMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn NetroutebgpMatrix::det(self : NetroutebgpMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn NetroutebgpMatrix::norm(self : NetroutebgpMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn NetroutebgpMatrix::to_string(self : NetroutebgpMatrix) -> String {
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

pub(all) struct NetroutebgpVector {
  comps : Array[Double]
  dim : Int
}

pub fn net_route_bgp_make_vector(comps : Array[Double]) -> NetroutebgpVector {
  { comps, dim: comps.length() }
}

pub fn net_route_bgp_vector_zero(dim : Int) -> NetroutebgpVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn NetroutebgpVector::add(self : NetroutebgpVector, other : NetroutebgpVector) -> NetroutebgpVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn NetroutebgpVector::sub(self : NetroutebgpVector, other : NetroutebgpVector) -> NetroutebgpVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn NetroutebgpVector::scale(self : NetroutebgpVector, s : Double) -> NetroutebgpVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn NetroutebgpVector::dot(self : NetroutebgpVector, other : NetroutebgpVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn NetroutebgpVector::norm(self : NetroutebgpVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn NetroutebgpVector::normalize(self : NetroutebgpVector) -> NetroutebgpVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn NetroutebgpVector::dist(self : NetroutebgpVector, other : NetroutebgpVector) -> Double {
  self.sub(other).norm()
}

pub fn NetroutebgpVector::to_string(self : NetroutebgpVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn net_route_bgp_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn net_route_bgp_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn net_route_bgp_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn net_route_bgp_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn net_route_bgp_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn net_route_bgp_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn net_route_bgp_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn net_route_bgp_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn net_route_bgp_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn net_route_bgp_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn net_route_bgp_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn net_route_bgp_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn net_route_bgp_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn net_route_bgp_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn net_route_bgp_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn net_route_bgp_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn net_route_bgp_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn net_route_bgp_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn net_route_bgp_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn net_route_bgp_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn net_route_bgp_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn net_route_bgp_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn net_route_bgp_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn net_route_bgp_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn net_route_bgp_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn net_route_bgp_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn net_route_bgp_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn net_route_bgp_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn net_route_bgp_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct NetroutebgpFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_route_bgp_frame_make(size : Int) -> NetroutebgpFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_route_bgp_frame_len(s : NetroutebgpFrame) -> Int { s.size }

pub fn net_route_bgp_frame_get(s : NetroutebgpFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_route_bgp_frame_set(s : NetroutebgpFrame, i : Int, v : Double) -> NetroutebgpFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn net_route_bgp_frame_sum(s : NetroutebgpFrame) -> Double { @_common.sum(s.data) }

pub fn net_route_bgp_frame_mean(s : NetroutebgpFrame) -> Double { @_common.mean(s.data) }

pub fn net_route_bgp_frame_scale(s : NetroutebgpFrame, f : Double) -> NetroutebgpFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_route_bgp_frame_add(a : NetroutebgpFrame, b : NetroutebgpFrame) -> NetroutebgpFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_route_bgp_frame_copy(s : NetroutebgpFrame) -> NetroutebgpFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_route_bgp_frame_fill(s : NetroutebgpFrame, v : Double) -> NetroutebgpFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_route_bgp_frame_min(s : NetroutebgpFrame) -> Double { @_common.min(s.data) }

pub fn net_route_bgp_frame_max(s : NetroutebgpFrame) -> Double { @_common.max(s.data) }

pub fn net_route_bgp_frame_to_string(s : NetroutebgpFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetroutebgpTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_route_bgp_table_make(size : Int) -> NetroutebgpTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_route_bgp_table_len(s : NetroutebgpTable) -> Int { s.size }

pub fn net_route_bgp_table_get(s : NetroutebgpTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_route_bgp_table_set(s : NetroutebgpTable, i : Int, v : Double) -> NetroutebgpTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn net_route_bgp_table_sum(s : NetroutebgpTable) -> Double { @_common.sum(s.data) }

pub fn net_route_bgp_table_mean(s : NetroutebgpTable) -> Double { @_common.mean(s.data) }

pub fn net_route_bgp_table_scale(s : NetroutebgpTable, f : Double) -> NetroutebgpTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_route_bgp_table_add(a : NetroutebgpTable, b : NetroutebgpTable) -> NetroutebgpTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_route_bgp_table_copy(s : NetroutebgpTable) -> NetroutebgpTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_route_bgp_table_fill(s : NetroutebgpTable, v : Double) -> NetroutebgpTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_route_bgp_table_min(s : NetroutebgpTable) -> Double { @_common.min(s.data) }

pub fn net_route_bgp_table_max(s : NetroutebgpTable) -> Double { @_common.max(s.data) }

pub fn net_route_bgp_table_to_string(s : NetroutebgpTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetroutebgpGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_route_bgp_graphn_make(size : Int) -> NetroutebgpGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_route_bgp_graphn_len(s : NetroutebgpGraphN) -> Int { s.size }

pub fn net_route_bgp_graphn_get(s : NetroutebgpGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_route_bgp_graphn_set(s : NetroutebgpGraphN, i : Int, v : Double) -> NetroutebgpGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn net_route_bgp_graphn_sum(s : NetroutebgpGraphN) -> Double { @_common.sum(s.data) }

pub fn net_route_bgp_graphn_mean(s : NetroutebgpGraphN) -> Double { @_common.mean(s.data) }

pub fn net_route_bgp_graphn_scale(s : NetroutebgpGraphN, f : Double) -> NetroutebgpGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_route_bgp_graphn_add(a : NetroutebgpGraphN, b : NetroutebgpGraphN) -> NetroutebgpGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_route_bgp_graphn_copy(s : NetroutebgpGraphN) -> NetroutebgpGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_route_bgp_graphn_fill(s : NetroutebgpGraphN, v : Double) -> NetroutebgpGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_route_bgp_graphn_min(s : NetroutebgpGraphN) -> Double { @_common.min(s.data) }

pub fn net_route_bgp_graphn_max(s : NetroutebgpGraphN) -> Double { @_common.max(s.data) }

pub fn net_route_bgp_graphn_to_string(s : NetroutebgpGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetroutebgpNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_route_bgp_node_make(size : Int) -> NetroutebgpNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_route_bgp_node_len(s : NetroutebgpNode) -> Int { s.size }

pub fn net_route_bgp_node_get(s : NetroutebgpNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_route_bgp_node_set(s : NetroutebgpNode, i : Int, v : Double) -> NetroutebgpNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn net_route_bgp_node_sum(s : NetroutebgpNode) -> Double { @_common.sum(s.data) }

pub fn net_route_bgp_node_mean(s : NetroutebgpNode) -> Double { @_common.mean(s.data) }

pub fn net_route_bgp_node_scale(s : NetroutebgpNode, f : Double) -> NetroutebgpNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_route_bgp_node_add(a : NetroutebgpNode, b : NetroutebgpNode) -> NetroutebgpNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_route_bgp_node_copy(s : NetroutebgpNode) -> NetroutebgpNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_route_bgp_node_fill(s : NetroutebgpNode, v : Double) -> NetroutebgpNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_route_bgp_node_min(s : NetroutebgpNode) -> Double { @_common.min(s.data) }

pub fn net_route_bgp_node_max(s : NetroutebgpNode) -> Double { @_common.max(s.data) }

pub fn net_route_bgp_node_to_string(s : NetroutebgpNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetroutebgpEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_route_bgp_edge_make(size : Int) -> NetroutebgpEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_route_bgp_edge_len(s : NetroutebgpEdge) -> Int { s.size }

pub fn net_route_bgp_edge_get(s : NetroutebgpEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_route_bgp_edge_set(s : NetroutebgpEdge, i : Int, v : Double) -> NetroutebgpEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn net_route_bgp_edge_sum(s : NetroutebgpEdge) -> Double { @_common.sum(s.data) }

pub fn net_route_bgp_edge_mean(s : NetroutebgpEdge) -> Double { @_common.mean(s.data) }

pub fn net_route_bgp_edge_scale(s : NetroutebgpEdge, f : Double) -> NetroutebgpEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_route_bgp_edge_add(a : NetroutebgpEdge, b : NetroutebgpEdge) -> NetroutebgpEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_route_bgp_edge_copy(s : NetroutebgpEdge) -> NetroutebgpEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_route_bgp_edge_fill(s : NetroutebgpEdge, v : Double) -> NetroutebgpEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_route_bgp_edge_min(s : NetroutebgpEdge) -> Double { @_common.min(s.data) }

pub fn net_route_bgp_edge_max(s : NetroutebgpEdge) -> Double { @_common.max(s.data) }

pub fn net_route_bgp_edge_to_string(s : NetroutebgpEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetroutebgpPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_route_bgp_path_make(size : Int) -> NetroutebgpPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_route_bgp_path_len(s : NetroutebgpPath) -> Int { s.size }

pub fn net_route_bgp_path_get(s : NetroutebgpPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_route_bgp_path_set(s : NetroutebgpPath, i : Int, v : Double) -> NetroutebgpPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn net_route_bgp_path_sum(s : NetroutebgpPath) -> Double { @_common.sum(s.data) }

pub fn net_route_bgp_path_mean(s : NetroutebgpPath) -> Double { @_common.mean(s.data) }

pub fn net_route_bgp_path_scale(s : NetroutebgpPath, f : Double) -> NetroutebgpPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_route_bgp_path_add(a : NetroutebgpPath, b : NetroutebgpPath) -> NetroutebgpPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_route_bgp_path_copy(s : NetroutebgpPath) -> NetroutebgpPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_route_bgp_path_fill(s : NetroutebgpPath, v : Double) -> NetroutebgpPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_route_bgp_path_min(s : NetroutebgpPath) -> Double { @_common.min(s.data) }

pub fn net_route_bgp_path_max(s : NetroutebgpPath) -> Double { @_common.max(s.data) }

pub fn net_route_bgp_path_to_string(s : NetroutebgpPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetroutebgpCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_route_bgp_cluster_make(size : Int) -> NetroutebgpCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_route_bgp_cluster_len(s : NetroutebgpCluster) -> Int { s.size }

pub fn net_route_bgp_cluster_get(s : NetroutebgpCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_route_bgp_cluster_set(s : NetroutebgpCluster, i : Int, v : Double) -> NetroutebgpCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn net_route_bgp_cluster_sum(s : NetroutebgpCluster) -> Double { @_common.sum(s.data) }

pub fn net_route_bgp_cluster_mean(s : NetroutebgpCluster) -> Double { @_common.mean(s.data) }

pub fn net_route_bgp_cluster_scale(s : NetroutebgpCluster, f : Double) -> NetroutebgpCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_route_bgp_cluster_add(a : NetroutebgpCluster, b : NetroutebgpCluster) -> NetroutebgpCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_route_bgp_cluster_copy(s : NetroutebgpCluster) -> NetroutebgpCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_route_bgp_cluster_fill(s : NetroutebgpCluster, v : Double) -> NetroutebgpCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_route_bgp_cluster_min(s : NetroutebgpCluster) -> Double { @_common.min(s.data) }

pub fn net_route_bgp_cluster_max(s : NetroutebgpCluster) -> Double { @_common.max(s.data) }

pub fn net_route_bgp_cluster_to_string(s : NetroutebgpCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetroutebgpModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_route_bgp_model_make(size : Int) -> NetroutebgpModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_route_bgp_model_len(s : NetroutebgpModel) -> Int { s.size }

pub fn net_route_bgp_model_get(s : NetroutebgpModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_route_bgp_model_set(s : NetroutebgpModel, i : Int, v : Double) -> NetroutebgpModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn net_route_bgp_model_sum(s : NetroutebgpModel) -> Double { @_common.sum(s.data) }

pub fn net_route_bgp_model_mean(s : NetroutebgpModel) -> Double { @_common.mean(s.data) }

pub fn net_route_bgp_model_scale(s : NetroutebgpModel, f : Double) -> NetroutebgpModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_route_bgp_model_add(a : NetroutebgpModel, b : NetroutebgpModel) -> NetroutebgpModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_route_bgp_model_copy(s : NetroutebgpModel) -> NetroutebgpModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_route_bgp_model_fill(s : NetroutebgpModel, v : Double) -> NetroutebgpModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_route_bgp_model_min(s : NetroutebgpModel) -> Double { @_common.min(s.data) }

pub fn net_route_bgp_model_max(s : NetroutebgpModel) -> Double { @_common.max(s.data) }

pub fn net_route_bgp_model_to_string(s : NetroutebgpModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetroutebgpLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_route_bgp_layer_make(size : Int) -> NetroutebgpLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_route_bgp_layer_len(s : NetroutebgpLayer) -> Int { s.size }

pub fn net_route_bgp_layer_get(s : NetroutebgpLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_route_bgp_layer_set(s : NetroutebgpLayer, i : Int, v : Double) -> NetroutebgpLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn net_route_bgp_layer_sum(s : NetroutebgpLayer) -> Double { @_common.sum(s.data) }

pub fn net_route_bgp_layer_mean(s : NetroutebgpLayer) -> Double { @_common.mean(s.data) }

pub fn net_route_bgp_layer_scale(s : NetroutebgpLayer, f : Double) -> NetroutebgpLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_route_bgp_layer_add(a : NetroutebgpLayer, b : NetroutebgpLayer) -> NetroutebgpLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_route_bgp_layer_copy(s : NetroutebgpLayer) -> NetroutebgpLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_route_bgp_layer_fill(s : NetroutebgpLayer, v : Double) -> NetroutebgpLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_route_bgp_layer_min(s : NetroutebgpLayer) -> Double { @_common.min(s.data) }

pub fn net_route_bgp_layer_max(s : NetroutebgpLayer) -> Double { @_common.max(s.data) }

pub fn net_route_bgp_layer_to_string(s : NetroutebgpLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetroutebgpBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_route_bgp_buffer_make(size : Int) -> NetroutebgpBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_route_bgp_buffer_len(s : NetroutebgpBuffer) -> Int { s.size }

pub fn net_route_bgp_buffer_get(s : NetroutebgpBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_route_bgp_buffer_set(s : NetroutebgpBuffer, i : Int, v : Double) -> NetroutebgpBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn net_route_bgp_buffer_sum(s : NetroutebgpBuffer) -> Double { @_common.sum(s.data) }

pub fn net_route_bgp_buffer_mean(s : NetroutebgpBuffer) -> Double { @_common.mean(s.data) }

pub fn net_route_bgp_buffer_scale(s : NetroutebgpBuffer, f : Double) -> NetroutebgpBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_route_bgp_buffer_add(a : NetroutebgpBuffer, b : NetroutebgpBuffer) -> NetroutebgpBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_route_bgp_buffer_copy(s : NetroutebgpBuffer) -> NetroutebgpBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_route_bgp_buffer_fill(s : NetroutebgpBuffer, v : Double) -> NetroutebgpBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_route_bgp_buffer_min(s : NetroutebgpBuffer) -> Double { @_common.min(s.data) }

pub fn net_route_bgp_buffer_max(s : NetroutebgpBuffer) -> Double { @_common.max(s.data) }

pub fn net_route_bgp_buffer_to_string(s : NetroutebgpBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetroutebgpCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_route_bgp_cursor_make(size : Int) -> NetroutebgpCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_route_bgp_cursor_len(s : NetroutebgpCursor) -> Int { s.size }

pub fn net_route_bgp_cursor_get(s : NetroutebgpCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_route_bgp_cursor_set(s : NetroutebgpCursor, i : Int, v : Double) -> NetroutebgpCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn net_route_bgp_cursor_sum(s : NetroutebgpCursor) -> Double { @_common.sum(s.data) }

pub fn net_route_bgp_cursor_mean(s : NetroutebgpCursor) -> Double { @_common.mean(s.data) }

pub fn net_route_bgp_cursor_scale(s : NetroutebgpCursor, f : Double) -> NetroutebgpCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_route_bgp_cursor_add(a : NetroutebgpCursor, b : NetroutebgpCursor) -> NetroutebgpCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_route_bgp_cursor_copy(s : NetroutebgpCursor) -> NetroutebgpCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_route_bgp_cursor_fill(s : NetroutebgpCursor, v : Double) -> NetroutebgpCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_route_bgp_cursor_min(s : NetroutebgpCursor) -> Double { @_common.min(s.data) }

pub fn net_route_bgp_cursor_max(s : NetroutebgpCursor) -> Double { @_common.max(s.data) }

pub fn net_route_bgp_cursor_to_string(s : NetroutebgpCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetroutebgpView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_route_bgp_view_make(size : Int) -> NetroutebgpView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_route_bgp_view_len(s : NetroutebgpView) -> Int { s.size }

pub fn net_route_bgp_view_get(s : NetroutebgpView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_route_bgp_view_set(s : NetroutebgpView, i : Int, v : Double) -> NetroutebgpView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn net_route_bgp_view_sum(s : NetroutebgpView) -> Double { @_common.sum(s.data) }

pub fn net_route_bgp_view_mean(s : NetroutebgpView) -> Double { @_common.mean(s.data) }

pub fn net_route_bgp_view_scale(s : NetroutebgpView, f : Double) -> NetroutebgpView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_route_bgp_view_add(a : NetroutebgpView, b : NetroutebgpView) -> NetroutebgpView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_route_bgp_view_copy(s : NetroutebgpView) -> NetroutebgpView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_route_bgp_view_fill(s : NetroutebgpView, v : Double) -> NetroutebgpView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_route_bgp_view_min(s : NetroutebgpView) -> Double { @_common.min(s.data) }

pub fn net_route_bgp_view_max(s : NetroutebgpView) -> Double { @_common.max(s.data) }

pub fn net_route_bgp_view_to_string(s : NetroutebgpView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetroutebgpRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_route_bgp_range_make(size : Int) -> NetroutebgpRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_route_bgp_range_len(s : NetroutebgpRange) -> Int { s.size }

pub fn net_route_bgp_range_get(s : NetroutebgpRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_route_bgp_range_set(s : NetroutebgpRange, i : Int, v : Double) -> NetroutebgpRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn net_route_bgp_range_sum(s : NetroutebgpRange) -> Double { @_common.sum(s.data) }

pub fn net_route_bgp_range_mean(s : NetroutebgpRange) -> Double { @_common.mean(s.data) }

pub fn net_route_bgp_range_scale(s : NetroutebgpRange, f : Double) -> NetroutebgpRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_route_bgp_range_add(a : NetroutebgpRange, b : NetroutebgpRange) -> NetroutebgpRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_route_bgp_range_copy(s : NetroutebgpRange) -> NetroutebgpRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_route_bgp_range_fill(s : NetroutebgpRange, v : Double) -> NetroutebgpRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_route_bgp_range_min(s : NetroutebgpRange) -> Double { @_common.min(s.data) }

pub fn net_route_bgp_range_max(s : NetroutebgpRange) -> Double { @_common.max(s.data) }

pub fn net_route_bgp_range_to_string(s : NetroutebgpRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetroutebgpSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_route_bgp_slice_make(size : Int) -> NetroutebgpSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_route_bgp_slice_len(s : NetroutebgpSlice) -> Int { s.size }

pub fn net_route_bgp_slice_get(s : NetroutebgpSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_route_bgp_slice_set(s : NetroutebgpSlice, i : Int, v : Double) -> NetroutebgpSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn net_route_bgp_slice_sum(s : NetroutebgpSlice) -> Double { @_common.sum(s.data) }

pub fn net_route_bgp_slice_mean(s : NetroutebgpSlice) -> Double { @_common.mean(s.data) }

pub fn net_route_bgp_slice_scale(s : NetroutebgpSlice, f : Double) -> NetroutebgpSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_route_bgp_slice_add(a : NetroutebgpSlice, b : NetroutebgpSlice) -> NetroutebgpSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_route_bgp_slice_copy(s : NetroutebgpSlice) -> NetroutebgpSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_route_bgp_slice_fill(s : NetroutebgpSlice, v : Double) -> NetroutebgpSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_route_bgp_slice_min(s : NetroutebgpSlice) -> Double { @_common.min(s.data) }

pub fn net_route_bgp_slice_max(s : NetroutebgpSlice) -> Double { @_common.max(s.data) }

pub fn net_route_bgp_slice_to_string(s : NetroutebgpSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

