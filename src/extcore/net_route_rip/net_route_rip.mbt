///===
/// extcore/net_route_rip

pub(all) struct NetrouteripPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn net_route_rip_make_point(x : Double, y : Double) -> NetrouteripPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn net_route_rip_make_point3(x : Double, y : Double, z : Double) -> NetrouteripPoint {
  { x, y, z, label: 0 }
}

pub fn NetrouteripPoint::x(self : NetrouteripPoint) -> Double { self.x }

pub fn NetrouteripPoint::y(self : NetrouteripPoint) -> Double { self.y }

pub fn NetrouteripPoint::z(self : NetrouteripPoint) -> Double { self.z }

pub fn NetrouteripPoint::label(self : NetrouteripPoint) -> Int { self.label }

pub fn NetrouteripPoint::dist(self : NetrouteripPoint, other : NetrouteripPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn NetrouteripPoint::add(self : NetrouteripPoint, other : NetrouteripPoint) -> NetrouteripPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn NetrouteripPoint::sub(self : NetrouteripPoint, other : NetrouteripPoint) -> NetrouteripPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn NetrouteripPoint::scale(self : NetrouteripPoint, s : Double) -> NetrouteripPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn NetrouteripPoint::dot(self : NetrouteripPoint, other : NetrouteripPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn NetrouteripPoint::cross(self : NetrouteripPoint, other : NetrouteripPoint) -> NetrouteripPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn NetrouteripPoint::norm(self : NetrouteripPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn NetrouteripPoint::normalize(self : NetrouteripPoint) -> NetrouteripPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn NetrouteripPoint::negate(self : NetrouteripPoint) -> NetrouteripPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn NetrouteripPoint::mid(self : NetrouteripPoint, other : NetrouteripPoint) -> NetrouteripPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn NetrouteripPoint::lerp(self : NetrouteripPoint, other : NetrouteripPoint, t : Double) -> NetrouteripPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn NetrouteripPoint::to_string(self : NetrouteripPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct NetrouteripSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn net_route_rip_make_series(vals : Array[Double], name : String) -> NetrouteripSeries {
  { vals, name, meta: 0 }
}

pub fn NetrouteripSeries::len(self : NetrouteripSeries) -> Int { self.vals.length() }

pub fn NetrouteripSeries::sum(self : NetrouteripSeries) -> Double { @_common.sum(self.vals) }

pub fn NetrouteripSeries::mean(self : NetrouteripSeries) -> Double { @_common.mean(self.vals) }

pub fn NetrouteripSeries::min(self : NetrouteripSeries) -> Double { @_common.min(self.vals) }

pub fn NetrouteripSeries::max(self : NetrouteripSeries) -> Double { @_common.max(self.vals) }

pub fn NetrouteripSeries::range(self : NetrouteripSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn NetrouteripSeries::variance(self : NetrouteripSeries) -> Double { @_common.variance(self.vals) }

pub fn NetrouteripSeries::std(self : NetrouteripSeries) -> Double { @_common.std(self.vals) }

pub fn NetrouteripSeries::median(self : NetrouteripSeries) -> Double { @_common.median(self.vals) }

pub fn NetrouteripSeries::scale(self : NetrouteripSeries, f : Double) -> NetrouteripSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn NetrouteripSeries::add(self : NetrouteripSeries, other : NetrouteripSeries) -> NetrouteripSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn NetrouteripSeries::sub(self : NetrouteripSeries, other : NetrouteripSeries) -> NetrouteripSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn NetrouteripSeries::normalize(self : NetrouteripSeries) -> NetrouteripSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn NetrouteripSeries::cumsum(self : NetrouteripSeries) -> NetrouteripSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn NetrouteripSeries::to_string(self : NetrouteripSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct NetrouteripMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn net_route_rip_make_matrix(rows : Int, cols : Int, val : Double) -> NetrouteripMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn net_route_rip_matrix_identity(n : Int) -> NetrouteripMatrix {
  let m = net_route_rip_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn NetrouteripMatrix::get(self : NetrouteripMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn NetrouteripMatrix::transpose(self : NetrouteripMatrix) -> NetrouteripMatrix {
  let result = net_route_rip_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn NetrouteripMatrix::add(self : NetrouteripMatrix, other : NetrouteripMatrix) -> NetrouteripMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = net_route_rip_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn NetrouteripMatrix::scale(self : NetrouteripMatrix, s : Double) -> NetrouteripMatrix {
  let result = net_route_rip_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn NetrouteripMatrix::multiply(self : NetrouteripMatrix, other : NetrouteripMatrix) -> NetrouteripMatrix {
  if self.cols != other.rows { return net_route_rip_make_matrix(self.rows, other.cols, 0.0) }
  let result = net_route_rip_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn NetrouteripMatrix::trace(self : NetrouteripMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn NetrouteripMatrix::det(self : NetrouteripMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn NetrouteripMatrix::norm(self : NetrouteripMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn NetrouteripMatrix::to_string(self : NetrouteripMatrix) -> String {
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

pub(all) struct NetrouteripVector {
  comps : Array[Double]
  dim : Int
}

pub fn net_route_rip_make_vector(comps : Array[Double]) -> NetrouteripVector {
  { comps, dim: comps.length() }
}

pub fn net_route_rip_vector_zero(dim : Int) -> NetrouteripVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn NetrouteripVector::add(self : NetrouteripVector, other : NetrouteripVector) -> NetrouteripVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn NetrouteripVector::sub(self : NetrouteripVector, other : NetrouteripVector) -> NetrouteripVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn NetrouteripVector::scale(self : NetrouteripVector, s : Double) -> NetrouteripVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn NetrouteripVector::dot(self : NetrouteripVector, other : NetrouteripVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn NetrouteripVector::norm(self : NetrouteripVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn NetrouteripVector::normalize(self : NetrouteripVector) -> NetrouteripVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn NetrouteripVector::dist(self : NetrouteripVector, other : NetrouteripVector) -> Double {
  self.sub(other).norm()
}

pub fn NetrouteripVector::to_string(self : NetrouteripVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn net_route_rip_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn net_route_rip_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn net_route_rip_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn net_route_rip_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn net_route_rip_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn net_route_rip_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn net_route_rip_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn net_route_rip_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn net_route_rip_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn net_route_rip_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn net_route_rip_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn net_route_rip_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn net_route_rip_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn net_route_rip_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn net_route_rip_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn net_route_rip_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn net_route_rip_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn net_route_rip_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn net_route_rip_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn net_route_rip_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn net_route_rip_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn net_route_rip_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn net_route_rip_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn net_route_rip_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn net_route_rip_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn net_route_rip_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn net_route_rip_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn net_route_rip_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn net_route_rip_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct NetrouteripFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_route_rip_frame_make(size : Int) -> NetrouteripFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_route_rip_frame_len(s : NetrouteripFrame) -> Int { s.size }

pub fn net_route_rip_frame_get(s : NetrouteripFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_route_rip_frame_set(s : NetrouteripFrame, i : Int, v : Double) -> NetrouteripFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn net_route_rip_frame_sum(s : NetrouteripFrame) -> Double { @_common.sum(s.data) }

pub fn net_route_rip_frame_mean(s : NetrouteripFrame) -> Double { @_common.mean(s.data) }

pub fn net_route_rip_frame_scale(s : NetrouteripFrame, f : Double) -> NetrouteripFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_route_rip_frame_add(a : NetrouteripFrame, b : NetrouteripFrame) -> NetrouteripFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_route_rip_frame_copy(s : NetrouteripFrame) -> NetrouteripFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_route_rip_frame_fill(s : NetrouteripFrame, v : Double) -> NetrouteripFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_route_rip_frame_min(s : NetrouteripFrame) -> Double { @_common.min(s.data) }

pub fn net_route_rip_frame_max(s : NetrouteripFrame) -> Double { @_common.max(s.data) }

pub fn net_route_rip_frame_to_string(s : NetrouteripFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetrouteripTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_route_rip_table_make(size : Int) -> NetrouteripTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_route_rip_table_len(s : NetrouteripTable) -> Int { s.size }

pub fn net_route_rip_table_get(s : NetrouteripTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_route_rip_table_set(s : NetrouteripTable, i : Int, v : Double) -> NetrouteripTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn net_route_rip_table_sum(s : NetrouteripTable) -> Double { @_common.sum(s.data) }

pub fn net_route_rip_table_mean(s : NetrouteripTable) -> Double { @_common.mean(s.data) }

pub fn net_route_rip_table_scale(s : NetrouteripTable, f : Double) -> NetrouteripTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_route_rip_table_add(a : NetrouteripTable, b : NetrouteripTable) -> NetrouteripTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_route_rip_table_copy(s : NetrouteripTable) -> NetrouteripTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_route_rip_table_fill(s : NetrouteripTable, v : Double) -> NetrouteripTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_route_rip_table_min(s : NetrouteripTable) -> Double { @_common.min(s.data) }

pub fn net_route_rip_table_max(s : NetrouteripTable) -> Double { @_common.max(s.data) }

pub fn net_route_rip_table_to_string(s : NetrouteripTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetrouteripGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_route_rip_graphn_make(size : Int) -> NetrouteripGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_route_rip_graphn_len(s : NetrouteripGraphN) -> Int { s.size }

pub fn net_route_rip_graphn_get(s : NetrouteripGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_route_rip_graphn_set(s : NetrouteripGraphN, i : Int, v : Double) -> NetrouteripGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn net_route_rip_graphn_sum(s : NetrouteripGraphN) -> Double { @_common.sum(s.data) }

pub fn net_route_rip_graphn_mean(s : NetrouteripGraphN) -> Double { @_common.mean(s.data) }

pub fn net_route_rip_graphn_scale(s : NetrouteripGraphN, f : Double) -> NetrouteripGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_route_rip_graphn_add(a : NetrouteripGraphN, b : NetrouteripGraphN) -> NetrouteripGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_route_rip_graphn_copy(s : NetrouteripGraphN) -> NetrouteripGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_route_rip_graphn_fill(s : NetrouteripGraphN, v : Double) -> NetrouteripGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_route_rip_graphn_min(s : NetrouteripGraphN) -> Double { @_common.min(s.data) }

pub fn net_route_rip_graphn_max(s : NetrouteripGraphN) -> Double { @_common.max(s.data) }

pub fn net_route_rip_graphn_to_string(s : NetrouteripGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetrouteripNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_route_rip_node_make(size : Int) -> NetrouteripNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_route_rip_node_len(s : NetrouteripNode) -> Int { s.size }

pub fn net_route_rip_node_get(s : NetrouteripNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_route_rip_node_set(s : NetrouteripNode, i : Int, v : Double) -> NetrouteripNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn net_route_rip_node_sum(s : NetrouteripNode) -> Double { @_common.sum(s.data) }

pub fn net_route_rip_node_mean(s : NetrouteripNode) -> Double { @_common.mean(s.data) }

pub fn net_route_rip_node_scale(s : NetrouteripNode, f : Double) -> NetrouteripNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_route_rip_node_add(a : NetrouteripNode, b : NetrouteripNode) -> NetrouteripNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_route_rip_node_copy(s : NetrouteripNode) -> NetrouteripNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_route_rip_node_fill(s : NetrouteripNode, v : Double) -> NetrouteripNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_route_rip_node_min(s : NetrouteripNode) -> Double { @_common.min(s.data) }

pub fn net_route_rip_node_max(s : NetrouteripNode) -> Double { @_common.max(s.data) }

pub fn net_route_rip_node_to_string(s : NetrouteripNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetrouteripEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_route_rip_edge_make(size : Int) -> NetrouteripEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_route_rip_edge_len(s : NetrouteripEdge) -> Int { s.size }

pub fn net_route_rip_edge_get(s : NetrouteripEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_route_rip_edge_set(s : NetrouteripEdge, i : Int, v : Double) -> NetrouteripEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn net_route_rip_edge_sum(s : NetrouteripEdge) -> Double { @_common.sum(s.data) }

pub fn net_route_rip_edge_mean(s : NetrouteripEdge) -> Double { @_common.mean(s.data) }

pub fn net_route_rip_edge_scale(s : NetrouteripEdge, f : Double) -> NetrouteripEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_route_rip_edge_add(a : NetrouteripEdge, b : NetrouteripEdge) -> NetrouteripEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_route_rip_edge_copy(s : NetrouteripEdge) -> NetrouteripEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_route_rip_edge_fill(s : NetrouteripEdge, v : Double) -> NetrouteripEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_route_rip_edge_min(s : NetrouteripEdge) -> Double { @_common.min(s.data) }

pub fn net_route_rip_edge_max(s : NetrouteripEdge) -> Double { @_common.max(s.data) }

pub fn net_route_rip_edge_to_string(s : NetrouteripEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetrouteripPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_route_rip_path_make(size : Int) -> NetrouteripPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_route_rip_path_len(s : NetrouteripPath) -> Int { s.size }

pub fn net_route_rip_path_get(s : NetrouteripPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_route_rip_path_set(s : NetrouteripPath, i : Int, v : Double) -> NetrouteripPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn net_route_rip_path_sum(s : NetrouteripPath) -> Double { @_common.sum(s.data) }

pub fn net_route_rip_path_mean(s : NetrouteripPath) -> Double { @_common.mean(s.data) }

pub fn net_route_rip_path_scale(s : NetrouteripPath, f : Double) -> NetrouteripPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_route_rip_path_add(a : NetrouteripPath, b : NetrouteripPath) -> NetrouteripPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_route_rip_path_copy(s : NetrouteripPath) -> NetrouteripPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_route_rip_path_fill(s : NetrouteripPath, v : Double) -> NetrouteripPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_route_rip_path_min(s : NetrouteripPath) -> Double { @_common.min(s.data) }

pub fn net_route_rip_path_max(s : NetrouteripPath) -> Double { @_common.max(s.data) }

pub fn net_route_rip_path_to_string(s : NetrouteripPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetrouteripCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_route_rip_cluster_make(size : Int) -> NetrouteripCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_route_rip_cluster_len(s : NetrouteripCluster) -> Int { s.size }

pub fn net_route_rip_cluster_get(s : NetrouteripCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_route_rip_cluster_set(s : NetrouteripCluster, i : Int, v : Double) -> NetrouteripCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn net_route_rip_cluster_sum(s : NetrouteripCluster) -> Double { @_common.sum(s.data) }

pub fn net_route_rip_cluster_mean(s : NetrouteripCluster) -> Double { @_common.mean(s.data) }

pub fn net_route_rip_cluster_scale(s : NetrouteripCluster, f : Double) -> NetrouteripCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_route_rip_cluster_add(a : NetrouteripCluster, b : NetrouteripCluster) -> NetrouteripCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_route_rip_cluster_copy(s : NetrouteripCluster) -> NetrouteripCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_route_rip_cluster_fill(s : NetrouteripCluster, v : Double) -> NetrouteripCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_route_rip_cluster_min(s : NetrouteripCluster) -> Double { @_common.min(s.data) }

pub fn net_route_rip_cluster_max(s : NetrouteripCluster) -> Double { @_common.max(s.data) }

pub fn net_route_rip_cluster_to_string(s : NetrouteripCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetrouteripModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_route_rip_model_make(size : Int) -> NetrouteripModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_route_rip_model_len(s : NetrouteripModel) -> Int { s.size }

pub fn net_route_rip_model_get(s : NetrouteripModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_route_rip_model_set(s : NetrouteripModel, i : Int, v : Double) -> NetrouteripModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn net_route_rip_model_sum(s : NetrouteripModel) -> Double { @_common.sum(s.data) }

pub fn net_route_rip_model_mean(s : NetrouteripModel) -> Double { @_common.mean(s.data) }

pub fn net_route_rip_model_scale(s : NetrouteripModel, f : Double) -> NetrouteripModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_route_rip_model_add(a : NetrouteripModel, b : NetrouteripModel) -> NetrouteripModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_route_rip_model_copy(s : NetrouteripModel) -> NetrouteripModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_route_rip_model_fill(s : NetrouteripModel, v : Double) -> NetrouteripModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_route_rip_model_min(s : NetrouteripModel) -> Double { @_common.min(s.data) }

pub fn net_route_rip_model_max(s : NetrouteripModel) -> Double { @_common.max(s.data) }

pub fn net_route_rip_model_to_string(s : NetrouteripModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetrouteripLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_route_rip_layer_make(size : Int) -> NetrouteripLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_route_rip_layer_len(s : NetrouteripLayer) -> Int { s.size }

pub fn net_route_rip_layer_get(s : NetrouteripLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_route_rip_layer_set(s : NetrouteripLayer, i : Int, v : Double) -> NetrouteripLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn net_route_rip_layer_sum(s : NetrouteripLayer) -> Double { @_common.sum(s.data) }

pub fn net_route_rip_layer_mean(s : NetrouteripLayer) -> Double { @_common.mean(s.data) }

pub fn net_route_rip_layer_scale(s : NetrouteripLayer, f : Double) -> NetrouteripLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_route_rip_layer_add(a : NetrouteripLayer, b : NetrouteripLayer) -> NetrouteripLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_route_rip_layer_copy(s : NetrouteripLayer) -> NetrouteripLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_route_rip_layer_fill(s : NetrouteripLayer, v : Double) -> NetrouteripLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_route_rip_layer_min(s : NetrouteripLayer) -> Double { @_common.min(s.data) }

pub fn net_route_rip_layer_max(s : NetrouteripLayer) -> Double { @_common.max(s.data) }

pub fn net_route_rip_layer_to_string(s : NetrouteripLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetrouteripBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_route_rip_buffer_make(size : Int) -> NetrouteripBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_route_rip_buffer_len(s : NetrouteripBuffer) -> Int { s.size }

pub fn net_route_rip_buffer_get(s : NetrouteripBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_route_rip_buffer_set(s : NetrouteripBuffer, i : Int, v : Double) -> NetrouteripBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn net_route_rip_buffer_sum(s : NetrouteripBuffer) -> Double { @_common.sum(s.data) }

pub fn net_route_rip_buffer_mean(s : NetrouteripBuffer) -> Double { @_common.mean(s.data) }

pub fn net_route_rip_buffer_scale(s : NetrouteripBuffer, f : Double) -> NetrouteripBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_route_rip_buffer_add(a : NetrouteripBuffer, b : NetrouteripBuffer) -> NetrouteripBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_route_rip_buffer_copy(s : NetrouteripBuffer) -> NetrouteripBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_route_rip_buffer_fill(s : NetrouteripBuffer, v : Double) -> NetrouteripBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_route_rip_buffer_min(s : NetrouteripBuffer) -> Double { @_common.min(s.data) }

pub fn net_route_rip_buffer_max(s : NetrouteripBuffer) -> Double { @_common.max(s.data) }

pub fn net_route_rip_buffer_to_string(s : NetrouteripBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetrouteripCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_route_rip_cursor_make(size : Int) -> NetrouteripCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_route_rip_cursor_len(s : NetrouteripCursor) -> Int { s.size }

pub fn net_route_rip_cursor_get(s : NetrouteripCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_route_rip_cursor_set(s : NetrouteripCursor, i : Int, v : Double) -> NetrouteripCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn net_route_rip_cursor_sum(s : NetrouteripCursor) -> Double { @_common.sum(s.data) }

pub fn net_route_rip_cursor_mean(s : NetrouteripCursor) -> Double { @_common.mean(s.data) }

pub fn net_route_rip_cursor_scale(s : NetrouteripCursor, f : Double) -> NetrouteripCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_route_rip_cursor_add(a : NetrouteripCursor, b : NetrouteripCursor) -> NetrouteripCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_route_rip_cursor_copy(s : NetrouteripCursor) -> NetrouteripCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_route_rip_cursor_fill(s : NetrouteripCursor, v : Double) -> NetrouteripCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_route_rip_cursor_min(s : NetrouteripCursor) -> Double { @_common.min(s.data) }

pub fn net_route_rip_cursor_max(s : NetrouteripCursor) -> Double { @_common.max(s.data) }

pub fn net_route_rip_cursor_to_string(s : NetrouteripCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetrouteripView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_route_rip_view_make(size : Int) -> NetrouteripView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_route_rip_view_len(s : NetrouteripView) -> Int { s.size }

pub fn net_route_rip_view_get(s : NetrouteripView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_route_rip_view_set(s : NetrouteripView, i : Int, v : Double) -> NetrouteripView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn net_route_rip_view_sum(s : NetrouteripView) -> Double { @_common.sum(s.data) }

pub fn net_route_rip_view_mean(s : NetrouteripView) -> Double { @_common.mean(s.data) }

pub fn net_route_rip_view_scale(s : NetrouteripView, f : Double) -> NetrouteripView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_route_rip_view_add(a : NetrouteripView, b : NetrouteripView) -> NetrouteripView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_route_rip_view_copy(s : NetrouteripView) -> NetrouteripView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_route_rip_view_fill(s : NetrouteripView, v : Double) -> NetrouteripView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_route_rip_view_min(s : NetrouteripView) -> Double { @_common.min(s.data) }

pub fn net_route_rip_view_max(s : NetrouteripView) -> Double { @_common.max(s.data) }

pub fn net_route_rip_view_to_string(s : NetrouteripView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetrouteripRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_route_rip_range_make(size : Int) -> NetrouteripRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_route_rip_range_len(s : NetrouteripRange) -> Int { s.size }

pub fn net_route_rip_range_get(s : NetrouteripRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_route_rip_range_set(s : NetrouteripRange, i : Int, v : Double) -> NetrouteripRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn net_route_rip_range_sum(s : NetrouteripRange) -> Double { @_common.sum(s.data) }

pub fn net_route_rip_range_mean(s : NetrouteripRange) -> Double { @_common.mean(s.data) }

pub fn net_route_rip_range_scale(s : NetrouteripRange, f : Double) -> NetrouteripRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_route_rip_range_add(a : NetrouteripRange, b : NetrouteripRange) -> NetrouteripRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_route_rip_range_copy(s : NetrouteripRange) -> NetrouteripRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_route_rip_range_fill(s : NetrouteripRange, v : Double) -> NetrouteripRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_route_rip_range_min(s : NetrouteripRange) -> Double { @_common.min(s.data) }

pub fn net_route_rip_range_max(s : NetrouteripRange) -> Double { @_common.max(s.data) }

pub fn net_route_rip_range_to_string(s : NetrouteripRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetrouteripSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_route_rip_slice_make(size : Int) -> NetrouteripSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_route_rip_slice_len(s : NetrouteripSlice) -> Int { s.size }

pub fn net_route_rip_slice_get(s : NetrouteripSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_route_rip_slice_set(s : NetrouteripSlice, i : Int, v : Double) -> NetrouteripSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn net_route_rip_slice_sum(s : NetrouteripSlice) -> Double { @_common.sum(s.data) }

pub fn net_route_rip_slice_mean(s : NetrouteripSlice) -> Double { @_common.mean(s.data) }

pub fn net_route_rip_slice_scale(s : NetrouteripSlice, f : Double) -> NetrouteripSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_route_rip_slice_add(a : NetrouteripSlice, b : NetrouteripSlice) -> NetrouteripSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_route_rip_slice_copy(s : NetrouteripSlice) -> NetrouteripSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_route_rip_slice_fill(s : NetrouteripSlice, v : Double) -> NetrouteripSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_route_rip_slice_min(s : NetrouteripSlice) -> Double { @_common.min(s.data) }

pub fn net_route_rip_slice_max(s : NetrouteripSlice) -> Double { @_common.max(s.data) }

pub fn net_route_rip_slice_to_string(s : NetrouteripSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

