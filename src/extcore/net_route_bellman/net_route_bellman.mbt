///===
/// extcore/net_route_bellman

pub(all) struct NetroutebellmanPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn net_route_bellman_make_point(x : Double, y : Double) -> NetroutebellmanPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn net_route_bellman_make_point3(x : Double, y : Double, z : Double) -> NetroutebellmanPoint {
  { x, y, z, label: 0 }
}

pub fn NetroutebellmanPoint::x(self : NetroutebellmanPoint) -> Double { self.x }

pub fn NetroutebellmanPoint::y(self : NetroutebellmanPoint) -> Double { self.y }

pub fn NetroutebellmanPoint::z(self : NetroutebellmanPoint) -> Double { self.z }

pub fn NetroutebellmanPoint::label(self : NetroutebellmanPoint) -> Int { self.label }

pub fn NetroutebellmanPoint::dist(self : NetroutebellmanPoint, other : NetroutebellmanPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn NetroutebellmanPoint::add(self : NetroutebellmanPoint, other : NetroutebellmanPoint) -> NetroutebellmanPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn NetroutebellmanPoint::sub(self : NetroutebellmanPoint, other : NetroutebellmanPoint) -> NetroutebellmanPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn NetroutebellmanPoint::scale(self : NetroutebellmanPoint, s : Double) -> NetroutebellmanPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn NetroutebellmanPoint::dot(self : NetroutebellmanPoint, other : NetroutebellmanPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn NetroutebellmanPoint::cross(self : NetroutebellmanPoint, other : NetroutebellmanPoint) -> NetroutebellmanPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn NetroutebellmanPoint::norm(self : NetroutebellmanPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn NetroutebellmanPoint::normalize(self : NetroutebellmanPoint) -> NetroutebellmanPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn NetroutebellmanPoint::negate(self : NetroutebellmanPoint) -> NetroutebellmanPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn NetroutebellmanPoint::mid(self : NetroutebellmanPoint, other : NetroutebellmanPoint) -> NetroutebellmanPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn NetroutebellmanPoint::lerp(self : NetroutebellmanPoint, other : NetroutebellmanPoint, t : Double) -> NetroutebellmanPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn NetroutebellmanPoint::to_string(self : NetroutebellmanPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct NetroutebellmanSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn net_route_bellman_make_series(vals : Array[Double], name : String) -> NetroutebellmanSeries {
  { vals, name, meta: 0 }
}

pub fn NetroutebellmanSeries::len(self : NetroutebellmanSeries) -> Int { self.vals.length() }

pub fn NetroutebellmanSeries::sum(self : NetroutebellmanSeries) -> Double { @_common.sum(self.vals) }

pub fn NetroutebellmanSeries::mean(self : NetroutebellmanSeries) -> Double { @_common.mean(self.vals) }

pub fn NetroutebellmanSeries::min(self : NetroutebellmanSeries) -> Double { @_common.min(self.vals) }

pub fn NetroutebellmanSeries::max(self : NetroutebellmanSeries) -> Double { @_common.max(self.vals) }

pub fn NetroutebellmanSeries::range(self : NetroutebellmanSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn NetroutebellmanSeries::variance(self : NetroutebellmanSeries) -> Double { @_common.variance(self.vals) }

pub fn NetroutebellmanSeries::std(self : NetroutebellmanSeries) -> Double { @_common.std(self.vals) }

pub fn NetroutebellmanSeries::median(self : NetroutebellmanSeries) -> Double { @_common.median(self.vals) }

pub fn NetroutebellmanSeries::scale(self : NetroutebellmanSeries, f : Double) -> NetroutebellmanSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn NetroutebellmanSeries::add(self : NetroutebellmanSeries, other : NetroutebellmanSeries) -> NetroutebellmanSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn NetroutebellmanSeries::sub(self : NetroutebellmanSeries, other : NetroutebellmanSeries) -> NetroutebellmanSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn NetroutebellmanSeries::normalize(self : NetroutebellmanSeries) -> NetroutebellmanSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn NetroutebellmanSeries::cumsum(self : NetroutebellmanSeries) -> NetroutebellmanSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn NetroutebellmanSeries::to_string(self : NetroutebellmanSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct NetroutebellmanMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn net_route_bellman_make_matrix(rows : Int, cols : Int, val : Double) -> NetroutebellmanMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn net_route_bellman_matrix_identity(n : Int) -> NetroutebellmanMatrix {
  let m = net_route_bellman_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn NetroutebellmanMatrix::get(self : NetroutebellmanMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn NetroutebellmanMatrix::transpose(self : NetroutebellmanMatrix) -> NetroutebellmanMatrix {
  let result = net_route_bellman_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn NetroutebellmanMatrix::add(self : NetroutebellmanMatrix, other : NetroutebellmanMatrix) -> NetroutebellmanMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = net_route_bellman_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn NetroutebellmanMatrix::scale(self : NetroutebellmanMatrix, s : Double) -> NetroutebellmanMatrix {
  let result = net_route_bellman_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn NetroutebellmanMatrix::multiply(self : NetroutebellmanMatrix, other : NetroutebellmanMatrix) -> NetroutebellmanMatrix {
  if self.cols != other.rows { return net_route_bellman_make_matrix(self.rows, other.cols, 0.0) }
  let result = net_route_bellman_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn NetroutebellmanMatrix::trace(self : NetroutebellmanMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn NetroutebellmanMatrix::det(self : NetroutebellmanMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn NetroutebellmanMatrix::norm(self : NetroutebellmanMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn NetroutebellmanMatrix::to_string(self : NetroutebellmanMatrix) -> String {
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

pub(all) struct NetroutebellmanVector {
  comps : Array[Double]
  dim : Int
}

pub fn net_route_bellman_make_vector(comps : Array[Double]) -> NetroutebellmanVector {
  { comps, dim: comps.length() }
}

pub fn net_route_bellman_vector_zero(dim : Int) -> NetroutebellmanVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn NetroutebellmanVector::add(self : NetroutebellmanVector, other : NetroutebellmanVector) -> NetroutebellmanVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn NetroutebellmanVector::sub(self : NetroutebellmanVector, other : NetroutebellmanVector) -> NetroutebellmanVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn NetroutebellmanVector::scale(self : NetroutebellmanVector, s : Double) -> NetroutebellmanVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn NetroutebellmanVector::dot(self : NetroutebellmanVector, other : NetroutebellmanVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn NetroutebellmanVector::norm(self : NetroutebellmanVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn NetroutebellmanVector::normalize(self : NetroutebellmanVector) -> NetroutebellmanVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn NetroutebellmanVector::dist(self : NetroutebellmanVector, other : NetroutebellmanVector) -> Double {
  self.sub(other).norm()
}

pub fn NetroutebellmanVector::to_string(self : NetroutebellmanVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn net_route_bellman_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn net_route_bellman_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn net_route_bellman_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn net_route_bellman_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn net_route_bellman_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn net_route_bellman_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn net_route_bellman_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn net_route_bellman_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn net_route_bellman_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn net_route_bellman_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn net_route_bellman_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn net_route_bellman_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn net_route_bellman_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn net_route_bellman_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn net_route_bellman_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn net_route_bellman_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn net_route_bellman_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn net_route_bellman_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn net_route_bellman_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn net_route_bellman_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn net_route_bellman_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn net_route_bellman_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn net_route_bellman_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn net_route_bellman_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn net_route_bellman_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn net_route_bellman_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn net_route_bellman_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn net_route_bellman_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn net_route_bellman_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct NetroutebellmanFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_route_bellman_frame_make(size : Int) -> NetroutebellmanFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_route_bellman_frame_len(s : NetroutebellmanFrame) -> Int { s.size }

pub fn net_route_bellman_frame_get(s : NetroutebellmanFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_route_bellman_frame_set(s : NetroutebellmanFrame, i : Int, v : Double) -> NetroutebellmanFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn net_route_bellman_frame_sum(s : NetroutebellmanFrame) -> Double { @_common.sum(s.data) }

pub fn net_route_bellman_frame_mean(s : NetroutebellmanFrame) -> Double { @_common.mean(s.data) }

pub fn net_route_bellman_frame_scale(s : NetroutebellmanFrame, f : Double) -> NetroutebellmanFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_route_bellman_frame_add(a : NetroutebellmanFrame, b : NetroutebellmanFrame) -> NetroutebellmanFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_route_bellman_frame_copy(s : NetroutebellmanFrame) -> NetroutebellmanFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_route_bellman_frame_fill(s : NetroutebellmanFrame, v : Double) -> NetroutebellmanFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_route_bellman_frame_min(s : NetroutebellmanFrame) -> Double { @_common.min(s.data) }

pub fn net_route_bellman_frame_max(s : NetroutebellmanFrame) -> Double { @_common.max(s.data) }

pub fn net_route_bellman_frame_to_string(s : NetroutebellmanFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetroutebellmanTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_route_bellman_table_make(size : Int) -> NetroutebellmanTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_route_bellman_table_len(s : NetroutebellmanTable) -> Int { s.size }

pub fn net_route_bellman_table_get(s : NetroutebellmanTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_route_bellman_table_set(s : NetroutebellmanTable, i : Int, v : Double) -> NetroutebellmanTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn net_route_bellman_table_sum(s : NetroutebellmanTable) -> Double { @_common.sum(s.data) }

pub fn net_route_bellman_table_mean(s : NetroutebellmanTable) -> Double { @_common.mean(s.data) }

pub fn net_route_bellman_table_scale(s : NetroutebellmanTable, f : Double) -> NetroutebellmanTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_route_bellman_table_add(a : NetroutebellmanTable, b : NetroutebellmanTable) -> NetroutebellmanTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_route_bellman_table_copy(s : NetroutebellmanTable) -> NetroutebellmanTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_route_bellman_table_fill(s : NetroutebellmanTable, v : Double) -> NetroutebellmanTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_route_bellman_table_min(s : NetroutebellmanTable) -> Double { @_common.min(s.data) }

pub fn net_route_bellman_table_max(s : NetroutebellmanTable) -> Double { @_common.max(s.data) }

pub fn net_route_bellman_table_to_string(s : NetroutebellmanTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetroutebellmanGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_route_bellman_graphn_make(size : Int) -> NetroutebellmanGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_route_bellman_graphn_len(s : NetroutebellmanGraphN) -> Int { s.size }

pub fn net_route_bellman_graphn_get(s : NetroutebellmanGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_route_bellman_graphn_set(s : NetroutebellmanGraphN, i : Int, v : Double) -> NetroutebellmanGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn net_route_bellman_graphn_sum(s : NetroutebellmanGraphN) -> Double { @_common.sum(s.data) }

pub fn net_route_bellman_graphn_mean(s : NetroutebellmanGraphN) -> Double { @_common.mean(s.data) }

pub fn net_route_bellman_graphn_scale(s : NetroutebellmanGraphN, f : Double) -> NetroutebellmanGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_route_bellman_graphn_add(a : NetroutebellmanGraphN, b : NetroutebellmanGraphN) -> NetroutebellmanGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_route_bellman_graphn_copy(s : NetroutebellmanGraphN) -> NetroutebellmanGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_route_bellman_graphn_fill(s : NetroutebellmanGraphN, v : Double) -> NetroutebellmanGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_route_bellman_graphn_min(s : NetroutebellmanGraphN) -> Double { @_common.min(s.data) }

pub fn net_route_bellman_graphn_max(s : NetroutebellmanGraphN) -> Double { @_common.max(s.data) }

pub fn net_route_bellman_graphn_to_string(s : NetroutebellmanGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetroutebellmanNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_route_bellman_node_make(size : Int) -> NetroutebellmanNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_route_bellman_node_len(s : NetroutebellmanNode) -> Int { s.size }

pub fn net_route_bellman_node_get(s : NetroutebellmanNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_route_bellman_node_set(s : NetroutebellmanNode, i : Int, v : Double) -> NetroutebellmanNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn net_route_bellman_node_sum(s : NetroutebellmanNode) -> Double { @_common.sum(s.data) }

pub fn net_route_bellman_node_mean(s : NetroutebellmanNode) -> Double { @_common.mean(s.data) }

pub fn net_route_bellman_node_scale(s : NetroutebellmanNode, f : Double) -> NetroutebellmanNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_route_bellman_node_add(a : NetroutebellmanNode, b : NetroutebellmanNode) -> NetroutebellmanNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_route_bellman_node_copy(s : NetroutebellmanNode) -> NetroutebellmanNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_route_bellman_node_fill(s : NetroutebellmanNode, v : Double) -> NetroutebellmanNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_route_bellman_node_min(s : NetroutebellmanNode) -> Double { @_common.min(s.data) }

pub fn net_route_bellman_node_max(s : NetroutebellmanNode) -> Double { @_common.max(s.data) }

pub fn net_route_bellman_node_to_string(s : NetroutebellmanNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetroutebellmanEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_route_bellman_edge_make(size : Int) -> NetroutebellmanEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_route_bellman_edge_len(s : NetroutebellmanEdge) -> Int { s.size }

pub fn net_route_bellman_edge_get(s : NetroutebellmanEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_route_bellman_edge_set(s : NetroutebellmanEdge, i : Int, v : Double) -> NetroutebellmanEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn net_route_bellman_edge_sum(s : NetroutebellmanEdge) -> Double { @_common.sum(s.data) }

pub fn net_route_bellman_edge_mean(s : NetroutebellmanEdge) -> Double { @_common.mean(s.data) }

pub fn net_route_bellman_edge_scale(s : NetroutebellmanEdge, f : Double) -> NetroutebellmanEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_route_bellman_edge_add(a : NetroutebellmanEdge, b : NetroutebellmanEdge) -> NetroutebellmanEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_route_bellman_edge_copy(s : NetroutebellmanEdge) -> NetroutebellmanEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_route_bellman_edge_fill(s : NetroutebellmanEdge, v : Double) -> NetroutebellmanEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_route_bellman_edge_min(s : NetroutebellmanEdge) -> Double { @_common.min(s.data) }

pub fn net_route_bellman_edge_max(s : NetroutebellmanEdge) -> Double { @_common.max(s.data) }

pub fn net_route_bellman_edge_to_string(s : NetroutebellmanEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetroutebellmanPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_route_bellman_path_make(size : Int) -> NetroutebellmanPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_route_bellman_path_len(s : NetroutebellmanPath) -> Int { s.size }

pub fn net_route_bellman_path_get(s : NetroutebellmanPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_route_bellman_path_set(s : NetroutebellmanPath, i : Int, v : Double) -> NetroutebellmanPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn net_route_bellman_path_sum(s : NetroutebellmanPath) -> Double { @_common.sum(s.data) }

pub fn net_route_bellman_path_mean(s : NetroutebellmanPath) -> Double { @_common.mean(s.data) }

pub fn net_route_bellman_path_scale(s : NetroutebellmanPath, f : Double) -> NetroutebellmanPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_route_bellman_path_add(a : NetroutebellmanPath, b : NetroutebellmanPath) -> NetroutebellmanPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_route_bellman_path_copy(s : NetroutebellmanPath) -> NetroutebellmanPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_route_bellman_path_fill(s : NetroutebellmanPath, v : Double) -> NetroutebellmanPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_route_bellman_path_min(s : NetroutebellmanPath) -> Double { @_common.min(s.data) }

pub fn net_route_bellman_path_max(s : NetroutebellmanPath) -> Double { @_common.max(s.data) }

pub fn net_route_bellman_path_to_string(s : NetroutebellmanPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetroutebellmanCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_route_bellman_cluster_make(size : Int) -> NetroutebellmanCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_route_bellman_cluster_len(s : NetroutebellmanCluster) -> Int { s.size }

pub fn net_route_bellman_cluster_get(s : NetroutebellmanCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_route_bellman_cluster_set(s : NetroutebellmanCluster, i : Int, v : Double) -> NetroutebellmanCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn net_route_bellman_cluster_sum(s : NetroutebellmanCluster) -> Double { @_common.sum(s.data) }

pub fn net_route_bellman_cluster_mean(s : NetroutebellmanCluster) -> Double { @_common.mean(s.data) }

pub fn net_route_bellman_cluster_scale(s : NetroutebellmanCluster, f : Double) -> NetroutebellmanCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_route_bellman_cluster_add(a : NetroutebellmanCluster, b : NetroutebellmanCluster) -> NetroutebellmanCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_route_bellman_cluster_copy(s : NetroutebellmanCluster) -> NetroutebellmanCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_route_bellman_cluster_fill(s : NetroutebellmanCluster, v : Double) -> NetroutebellmanCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_route_bellman_cluster_min(s : NetroutebellmanCluster) -> Double { @_common.min(s.data) }

pub fn net_route_bellman_cluster_max(s : NetroutebellmanCluster) -> Double { @_common.max(s.data) }

pub fn net_route_bellman_cluster_to_string(s : NetroutebellmanCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetroutebellmanModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_route_bellman_model_make(size : Int) -> NetroutebellmanModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_route_bellman_model_len(s : NetroutebellmanModel) -> Int { s.size }

pub fn net_route_bellman_model_get(s : NetroutebellmanModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_route_bellman_model_set(s : NetroutebellmanModel, i : Int, v : Double) -> NetroutebellmanModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn net_route_bellman_model_sum(s : NetroutebellmanModel) -> Double { @_common.sum(s.data) }

pub fn net_route_bellman_model_mean(s : NetroutebellmanModel) -> Double { @_common.mean(s.data) }

pub fn net_route_bellman_model_scale(s : NetroutebellmanModel, f : Double) -> NetroutebellmanModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_route_bellman_model_add(a : NetroutebellmanModel, b : NetroutebellmanModel) -> NetroutebellmanModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_route_bellman_model_copy(s : NetroutebellmanModel) -> NetroutebellmanModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_route_bellman_model_fill(s : NetroutebellmanModel, v : Double) -> NetroutebellmanModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_route_bellman_model_min(s : NetroutebellmanModel) -> Double { @_common.min(s.data) }

pub fn net_route_bellman_model_max(s : NetroutebellmanModel) -> Double { @_common.max(s.data) }

pub fn net_route_bellman_model_to_string(s : NetroutebellmanModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetroutebellmanLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_route_bellman_layer_make(size : Int) -> NetroutebellmanLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_route_bellman_layer_len(s : NetroutebellmanLayer) -> Int { s.size }

pub fn net_route_bellman_layer_get(s : NetroutebellmanLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_route_bellman_layer_set(s : NetroutebellmanLayer, i : Int, v : Double) -> NetroutebellmanLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn net_route_bellman_layer_sum(s : NetroutebellmanLayer) -> Double { @_common.sum(s.data) }

pub fn net_route_bellman_layer_mean(s : NetroutebellmanLayer) -> Double { @_common.mean(s.data) }

pub fn net_route_bellman_layer_scale(s : NetroutebellmanLayer, f : Double) -> NetroutebellmanLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_route_bellman_layer_add(a : NetroutebellmanLayer, b : NetroutebellmanLayer) -> NetroutebellmanLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_route_bellman_layer_copy(s : NetroutebellmanLayer) -> NetroutebellmanLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_route_bellman_layer_fill(s : NetroutebellmanLayer, v : Double) -> NetroutebellmanLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_route_bellman_layer_min(s : NetroutebellmanLayer) -> Double { @_common.min(s.data) }

pub fn net_route_bellman_layer_max(s : NetroutebellmanLayer) -> Double { @_common.max(s.data) }

pub fn net_route_bellman_layer_to_string(s : NetroutebellmanLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetroutebellmanBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_route_bellman_buffer_make(size : Int) -> NetroutebellmanBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_route_bellman_buffer_len(s : NetroutebellmanBuffer) -> Int { s.size }

pub fn net_route_bellman_buffer_get(s : NetroutebellmanBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_route_bellman_buffer_set(s : NetroutebellmanBuffer, i : Int, v : Double) -> NetroutebellmanBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn net_route_bellman_buffer_sum(s : NetroutebellmanBuffer) -> Double { @_common.sum(s.data) }

pub fn net_route_bellman_buffer_mean(s : NetroutebellmanBuffer) -> Double { @_common.mean(s.data) }

pub fn net_route_bellman_buffer_scale(s : NetroutebellmanBuffer, f : Double) -> NetroutebellmanBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_route_bellman_buffer_add(a : NetroutebellmanBuffer, b : NetroutebellmanBuffer) -> NetroutebellmanBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_route_bellman_buffer_copy(s : NetroutebellmanBuffer) -> NetroutebellmanBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_route_bellman_buffer_fill(s : NetroutebellmanBuffer, v : Double) -> NetroutebellmanBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_route_bellman_buffer_min(s : NetroutebellmanBuffer) -> Double { @_common.min(s.data) }

pub fn net_route_bellman_buffer_max(s : NetroutebellmanBuffer) -> Double { @_common.max(s.data) }

pub fn net_route_bellman_buffer_to_string(s : NetroutebellmanBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetroutebellmanCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_route_bellman_cursor_make(size : Int) -> NetroutebellmanCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_route_bellman_cursor_len(s : NetroutebellmanCursor) -> Int { s.size }

pub fn net_route_bellman_cursor_get(s : NetroutebellmanCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_route_bellman_cursor_set(s : NetroutebellmanCursor, i : Int, v : Double) -> NetroutebellmanCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn net_route_bellman_cursor_sum(s : NetroutebellmanCursor) -> Double { @_common.sum(s.data) }

pub fn net_route_bellman_cursor_mean(s : NetroutebellmanCursor) -> Double { @_common.mean(s.data) }

pub fn net_route_bellman_cursor_scale(s : NetroutebellmanCursor, f : Double) -> NetroutebellmanCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_route_bellman_cursor_add(a : NetroutebellmanCursor, b : NetroutebellmanCursor) -> NetroutebellmanCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_route_bellman_cursor_copy(s : NetroutebellmanCursor) -> NetroutebellmanCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_route_bellman_cursor_fill(s : NetroutebellmanCursor, v : Double) -> NetroutebellmanCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_route_bellman_cursor_min(s : NetroutebellmanCursor) -> Double { @_common.min(s.data) }

pub fn net_route_bellman_cursor_max(s : NetroutebellmanCursor) -> Double { @_common.max(s.data) }

pub fn net_route_bellman_cursor_to_string(s : NetroutebellmanCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetroutebellmanView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_route_bellman_view_make(size : Int) -> NetroutebellmanView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_route_bellman_view_len(s : NetroutebellmanView) -> Int { s.size }

pub fn net_route_bellman_view_get(s : NetroutebellmanView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_route_bellman_view_set(s : NetroutebellmanView, i : Int, v : Double) -> NetroutebellmanView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn net_route_bellman_view_sum(s : NetroutebellmanView) -> Double { @_common.sum(s.data) }

pub fn net_route_bellman_view_mean(s : NetroutebellmanView) -> Double { @_common.mean(s.data) }

pub fn net_route_bellman_view_scale(s : NetroutebellmanView, f : Double) -> NetroutebellmanView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_route_bellman_view_add(a : NetroutebellmanView, b : NetroutebellmanView) -> NetroutebellmanView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_route_bellman_view_copy(s : NetroutebellmanView) -> NetroutebellmanView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_route_bellman_view_fill(s : NetroutebellmanView, v : Double) -> NetroutebellmanView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_route_bellman_view_min(s : NetroutebellmanView) -> Double { @_common.min(s.data) }

pub fn net_route_bellman_view_max(s : NetroutebellmanView) -> Double { @_common.max(s.data) }

pub fn net_route_bellman_view_to_string(s : NetroutebellmanView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetroutebellmanRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_route_bellman_range_make(size : Int) -> NetroutebellmanRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_route_bellman_range_len(s : NetroutebellmanRange) -> Int { s.size }

pub fn net_route_bellman_range_get(s : NetroutebellmanRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_route_bellman_range_set(s : NetroutebellmanRange, i : Int, v : Double) -> NetroutebellmanRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn net_route_bellman_range_sum(s : NetroutebellmanRange) -> Double { @_common.sum(s.data) }

pub fn net_route_bellman_range_mean(s : NetroutebellmanRange) -> Double { @_common.mean(s.data) }

pub fn net_route_bellman_range_scale(s : NetroutebellmanRange, f : Double) -> NetroutebellmanRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_route_bellman_range_add(a : NetroutebellmanRange, b : NetroutebellmanRange) -> NetroutebellmanRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_route_bellman_range_copy(s : NetroutebellmanRange) -> NetroutebellmanRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_route_bellman_range_fill(s : NetroutebellmanRange, v : Double) -> NetroutebellmanRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_route_bellman_range_min(s : NetroutebellmanRange) -> Double { @_common.min(s.data) }

pub fn net_route_bellman_range_max(s : NetroutebellmanRange) -> Double { @_common.max(s.data) }

pub fn net_route_bellman_range_to_string(s : NetroutebellmanRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetroutebellmanSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_route_bellman_slice_make(size : Int) -> NetroutebellmanSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_route_bellman_slice_len(s : NetroutebellmanSlice) -> Int { s.size }

pub fn net_route_bellman_slice_get(s : NetroutebellmanSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_route_bellman_slice_set(s : NetroutebellmanSlice, i : Int, v : Double) -> NetroutebellmanSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn net_route_bellman_slice_sum(s : NetroutebellmanSlice) -> Double { @_common.sum(s.data) }

pub fn net_route_bellman_slice_mean(s : NetroutebellmanSlice) -> Double { @_common.mean(s.data) }

pub fn net_route_bellman_slice_scale(s : NetroutebellmanSlice, f : Double) -> NetroutebellmanSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_route_bellman_slice_add(a : NetroutebellmanSlice, b : NetroutebellmanSlice) -> NetroutebellmanSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_route_bellman_slice_copy(s : NetroutebellmanSlice) -> NetroutebellmanSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_route_bellman_slice_fill(s : NetroutebellmanSlice, v : Double) -> NetroutebellmanSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_route_bellman_slice_min(s : NetroutebellmanSlice) -> Double { @_common.min(s.data) }

pub fn net_route_bellman_slice_max(s : NetroutebellmanSlice) -> Double { @_common.max(s.data) }

pub fn net_route_bellman_slice_to_string(s : NetroutebellmanSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

