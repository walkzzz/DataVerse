///===
/// extcore/net_flow_window

pub(all) struct NetflowwindowPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn net_flow_window_make_point(x : Double, y : Double) -> NetflowwindowPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn net_flow_window_make_point3(x : Double, y : Double, z : Double) -> NetflowwindowPoint {
  { x, y, z, label: 0 }
}

pub fn NetflowwindowPoint::x(self : NetflowwindowPoint) -> Double { self.x }

pub fn NetflowwindowPoint::y(self : NetflowwindowPoint) -> Double { self.y }

pub fn NetflowwindowPoint::z(self : NetflowwindowPoint) -> Double { self.z }

pub fn NetflowwindowPoint::label(self : NetflowwindowPoint) -> Int { self.label }

pub fn NetflowwindowPoint::dist(self : NetflowwindowPoint, other : NetflowwindowPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn NetflowwindowPoint::add(self : NetflowwindowPoint, other : NetflowwindowPoint) -> NetflowwindowPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn NetflowwindowPoint::sub(self : NetflowwindowPoint, other : NetflowwindowPoint) -> NetflowwindowPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn NetflowwindowPoint::scale(self : NetflowwindowPoint, s : Double) -> NetflowwindowPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn NetflowwindowPoint::dot(self : NetflowwindowPoint, other : NetflowwindowPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn NetflowwindowPoint::cross(self : NetflowwindowPoint, other : NetflowwindowPoint) -> NetflowwindowPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn NetflowwindowPoint::norm(self : NetflowwindowPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn NetflowwindowPoint::normalize(self : NetflowwindowPoint) -> NetflowwindowPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn NetflowwindowPoint::negate(self : NetflowwindowPoint) -> NetflowwindowPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn NetflowwindowPoint::mid(self : NetflowwindowPoint, other : NetflowwindowPoint) -> NetflowwindowPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn NetflowwindowPoint::lerp(self : NetflowwindowPoint, other : NetflowwindowPoint, t : Double) -> NetflowwindowPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn NetflowwindowPoint::to_string(self : NetflowwindowPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct NetflowwindowSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn net_flow_window_make_series(vals : Array[Double], name : String) -> NetflowwindowSeries {
  { vals, name, meta: 0 }
}

pub fn NetflowwindowSeries::len(self : NetflowwindowSeries) -> Int { self.vals.length() }

pub fn NetflowwindowSeries::sum(self : NetflowwindowSeries) -> Double { @_common.sum(self.vals) }

pub fn NetflowwindowSeries::mean(self : NetflowwindowSeries) -> Double { @_common.mean(self.vals) }

pub fn NetflowwindowSeries::min(self : NetflowwindowSeries) -> Double { @_common.min(self.vals) }

pub fn NetflowwindowSeries::max(self : NetflowwindowSeries) -> Double { @_common.max(self.vals) }

pub fn NetflowwindowSeries::range(self : NetflowwindowSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn NetflowwindowSeries::variance(self : NetflowwindowSeries) -> Double { @_common.variance(self.vals) }

pub fn NetflowwindowSeries::std(self : NetflowwindowSeries) -> Double { @_common.std(self.vals) }

pub fn NetflowwindowSeries::median(self : NetflowwindowSeries) -> Double { @_common.median(self.vals) }

pub fn NetflowwindowSeries::scale(self : NetflowwindowSeries, f : Double) -> NetflowwindowSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn NetflowwindowSeries::add(self : NetflowwindowSeries, other : NetflowwindowSeries) -> NetflowwindowSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn NetflowwindowSeries::sub(self : NetflowwindowSeries, other : NetflowwindowSeries) -> NetflowwindowSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn NetflowwindowSeries::normalize(self : NetflowwindowSeries) -> NetflowwindowSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn NetflowwindowSeries::cumsum(self : NetflowwindowSeries) -> NetflowwindowSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn NetflowwindowSeries::to_string(self : NetflowwindowSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct NetflowwindowMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn net_flow_window_make_matrix(rows : Int, cols : Int, val : Double) -> NetflowwindowMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn net_flow_window_matrix_identity(n : Int) -> NetflowwindowMatrix {
  let m = net_flow_window_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn NetflowwindowMatrix::get(self : NetflowwindowMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn NetflowwindowMatrix::transpose(self : NetflowwindowMatrix) -> NetflowwindowMatrix {
  let result = net_flow_window_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn NetflowwindowMatrix::add(self : NetflowwindowMatrix, other : NetflowwindowMatrix) -> NetflowwindowMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = net_flow_window_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn NetflowwindowMatrix::scale(self : NetflowwindowMatrix, s : Double) -> NetflowwindowMatrix {
  let result = net_flow_window_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn NetflowwindowMatrix::multiply(self : NetflowwindowMatrix, other : NetflowwindowMatrix) -> NetflowwindowMatrix {
  if self.cols != other.rows { return net_flow_window_make_matrix(self.rows, other.cols, 0.0) }
  let result = net_flow_window_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn NetflowwindowMatrix::trace(self : NetflowwindowMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn NetflowwindowMatrix::det(self : NetflowwindowMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn NetflowwindowMatrix::norm(self : NetflowwindowMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn NetflowwindowMatrix::to_string(self : NetflowwindowMatrix) -> String {
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

pub(all) struct NetflowwindowVector {
  comps : Array[Double]
  dim : Int
}

pub fn net_flow_window_make_vector(comps : Array[Double]) -> NetflowwindowVector {
  { comps, dim: comps.length() }
}

pub fn net_flow_window_vector_zero(dim : Int) -> NetflowwindowVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn NetflowwindowVector::add(self : NetflowwindowVector, other : NetflowwindowVector) -> NetflowwindowVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn NetflowwindowVector::sub(self : NetflowwindowVector, other : NetflowwindowVector) -> NetflowwindowVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn NetflowwindowVector::scale(self : NetflowwindowVector, s : Double) -> NetflowwindowVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn NetflowwindowVector::dot(self : NetflowwindowVector, other : NetflowwindowVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn NetflowwindowVector::norm(self : NetflowwindowVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn NetflowwindowVector::normalize(self : NetflowwindowVector) -> NetflowwindowVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn NetflowwindowVector::dist(self : NetflowwindowVector, other : NetflowwindowVector) -> Double {
  self.sub(other).norm()
}

pub fn NetflowwindowVector::to_string(self : NetflowwindowVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn net_flow_window_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn net_flow_window_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn net_flow_window_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn net_flow_window_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn net_flow_window_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn net_flow_window_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn net_flow_window_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn net_flow_window_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn net_flow_window_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn net_flow_window_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn net_flow_window_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn net_flow_window_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn net_flow_window_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn net_flow_window_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn net_flow_window_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn net_flow_window_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn net_flow_window_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn net_flow_window_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn net_flow_window_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn net_flow_window_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn net_flow_window_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn net_flow_window_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn net_flow_window_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn net_flow_window_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn net_flow_window_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn net_flow_window_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn net_flow_window_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn net_flow_window_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn net_flow_window_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct NetflowwindowFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_flow_window_frame_make(size : Int) -> NetflowwindowFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_flow_window_frame_len(s : NetflowwindowFrame) -> Int { s.size }

pub fn net_flow_window_frame_get(s : NetflowwindowFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_flow_window_frame_set(s : NetflowwindowFrame, i : Int, v : Double) -> NetflowwindowFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn net_flow_window_frame_sum(s : NetflowwindowFrame) -> Double { @_common.sum(s.data) }

pub fn net_flow_window_frame_mean(s : NetflowwindowFrame) -> Double { @_common.mean(s.data) }

pub fn net_flow_window_frame_scale(s : NetflowwindowFrame, f : Double) -> NetflowwindowFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_flow_window_frame_add(a : NetflowwindowFrame, b : NetflowwindowFrame) -> NetflowwindowFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_flow_window_frame_copy(s : NetflowwindowFrame) -> NetflowwindowFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_flow_window_frame_fill(s : NetflowwindowFrame, v : Double) -> NetflowwindowFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_flow_window_frame_min(s : NetflowwindowFrame) -> Double { @_common.min(s.data) }

pub fn net_flow_window_frame_max(s : NetflowwindowFrame) -> Double { @_common.max(s.data) }

pub fn net_flow_window_frame_to_string(s : NetflowwindowFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetflowwindowTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_flow_window_table_make(size : Int) -> NetflowwindowTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_flow_window_table_len(s : NetflowwindowTable) -> Int { s.size }

pub fn net_flow_window_table_get(s : NetflowwindowTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_flow_window_table_set(s : NetflowwindowTable, i : Int, v : Double) -> NetflowwindowTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn net_flow_window_table_sum(s : NetflowwindowTable) -> Double { @_common.sum(s.data) }

pub fn net_flow_window_table_mean(s : NetflowwindowTable) -> Double { @_common.mean(s.data) }

pub fn net_flow_window_table_scale(s : NetflowwindowTable, f : Double) -> NetflowwindowTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_flow_window_table_add(a : NetflowwindowTable, b : NetflowwindowTable) -> NetflowwindowTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_flow_window_table_copy(s : NetflowwindowTable) -> NetflowwindowTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_flow_window_table_fill(s : NetflowwindowTable, v : Double) -> NetflowwindowTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_flow_window_table_min(s : NetflowwindowTable) -> Double { @_common.min(s.data) }

pub fn net_flow_window_table_max(s : NetflowwindowTable) -> Double { @_common.max(s.data) }

pub fn net_flow_window_table_to_string(s : NetflowwindowTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetflowwindowGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_flow_window_graphn_make(size : Int) -> NetflowwindowGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_flow_window_graphn_len(s : NetflowwindowGraphN) -> Int { s.size }

pub fn net_flow_window_graphn_get(s : NetflowwindowGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_flow_window_graphn_set(s : NetflowwindowGraphN, i : Int, v : Double) -> NetflowwindowGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn net_flow_window_graphn_sum(s : NetflowwindowGraphN) -> Double { @_common.sum(s.data) }

pub fn net_flow_window_graphn_mean(s : NetflowwindowGraphN) -> Double { @_common.mean(s.data) }

pub fn net_flow_window_graphn_scale(s : NetflowwindowGraphN, f : Double) -> NetflowwindowGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_flow_window_graphn_add(a : NetflowwindowGraphN, b : NetflowwindowGraphN) -> NetflowwindowGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_flow_window_graphn_copy(s : NetflowwindowGraphN) -> NetflowwindowGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_flow_window_graphn_fill(s : NetflowwindowGraphN, v : Double) -> NetflowwindowGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_flow_window_graphn_min(s : NetflowwindowGraphN) -> Double { @_common.min(s.data) }

pub fn net_flow_window_graphn_max(s : NetflowwindowGraphN) -> Double { @_common.max(s.data) }

pub fn net_flow_window_graphn_to_string(s : NetflowwindowGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetflowwindowNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_flow_window_node_make(size : Int) -> NetflowwindowNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_flow_window_node_len(s : NetflowwindowNode) -> Int { s.size }

pub fn net_flow_window_node_get(s : NetflowwindowNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_flow_window_node_set(s : NetflowwindowNode, i : Int, v : Double) -> NetflowwindowNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn net_flow_window_node_sum(s : NetflowwindowNode) -> Double { @_common.sum(s.data) }

pub fn net_flow_window_node_mean(s : NetflowwindowNode) -> Double { @_common.mean(s.data) }

pub fn net_flow_window_node_scale(s : NetflowwindowNode, f : Double) -> NetflowwindowNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_flow_window_node_add(a : NetflowwindowNode, b : NetflowwindowNode) -> NetflowwindowNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_flow_window_node_copy(s : NetflowwindowNode) -> NetflowwindowNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_flow_window_node_fill(s : NetflowwindowNode, v : Double) -> NetflowwindowNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_flow_window_node_min(s : NetflowwindowNode) -> Double { @_common.min(s.data) }

pub fn net_flow_window_node_max(s : NetflowwindowNode) -> Double { @_common.max(s.data) }

pub fn net_flow_window_node_to_string(s : NetflowwindowNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetflowwindowEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_flow_window_edge_make(size : Int) -> NetflowwindowEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_flow_window_edge_len(s : NetflowwindowEdge) -> Int { s.size }

pub fn net_flow_window_edge_get(s : NetflowwindowEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_flow_window_edge_set(s : NetflowwindowEdge, i : Int, v : Double) -> NetflowwindowEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn net_flow_window_edge_sum(s : NetflowwindowEdge) -> Double { @_common.sum(s.data) }

pub fn net_flow_window_edge_mean(s : NetflowwindowEdge) -> Double { @_common.mean(s.data) }

pub fn net_flow_window_edge_scale(s : NetflowwindowEdge, f : Double) -> NetflowwindowEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_flow_window_edge_add(a : NetflowwindowEdge, b : NetflowwindowEdge) -> NetflowwindowEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_flow_window_edge_copy(s : NetflowwindowEdge) -> NetflowwindowEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_flow_window_edge_fill(s : NetflowwindowEdge, v : Double) -> NetflowwindowEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_flow_window_edge_min(s : NetflowwindowEdge) -> Double { @_common.min(s.data) }

pub fn net_flow_window_edge_max(s : NetflowwindowEdge) -> Double { @_common.max(s.data) }

pub fn net_flow_window_edge_to_string(s : NetflowwindowEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetflowwindowPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_flow_window_path_make(size : Int) -> NetflowwindowPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_flow_window_path_len(s : NetflowwindowPath) -> Int { s.size }

pub fn net_flow_window_path_get(s : NetflowwindowPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_flow_window_path_set(s : NetflowwindowPath, i : Int, v : Double) -> NetflowwindowPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn net_flow_window_path_sum(s : NetflowwindowPath) -> Double { @_common.sum(s.data) }

pub fn net_flow_window_path_mean(s : NetflowwindowPath) -> Double { @_common.mean(s.data) }

pub fn net_flow_window_path_scale(s : NetflowwindowPath, f : Double) -> NetflowwindowPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_flow_window_path_add(a : NetflowwindowPath, b : NetflowwindowPath) -> NetflowwindowPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_flow_window_path_copy(s : NetflowwindowPath) -> NetflowwindowPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_flow_window_path_fill(s : NetflowwindowPath, v : Double) -> NetflowwindowPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_flow_window_path_min(s : NetflowwindowPath) -> Double { @_common.min(s.data) }

pub fn net_flow_window_path_max(s : NetflowwindowPath) -> Double { @_common.max(s.data) }

pub fn net_flow_window_path_to_string(s : NetflowwindowPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetflowwindowCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_flow_window_cluster_make(size : Int) -> NetflowwindowCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_flow_window_cluster_len(s : NetflowwindowCluster) -> Int { s.size }

pub fn net_flow_window_cluster_get(s : NetflowwindowCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_flow_window_cluster_set(s : NetflowwindowCluster, i : Int, v : Double) -> NetflowwindowCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn net_flow_window_cluster_sum(s : NetflowwindowCluster) -> Double { @_common.sum(s.data) }

pub fn net_flow_window_cluster_mean(s : NetflowwindowCluster) -> Double { @_common.mean(s.data) }

pub fn net_flow_window_cluster_scale(s : NetflowwindowCluster, f : Double) -> NetflowwindowCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_flow_window_cluster_add(a : NetflowwindowCluster, b : NetflowwindowCluster) -> NetflowwindowCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_flow_window_cluster_copy(s : NetflowwindowCluster) -> NetflowwindowCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_flow_window_cluster_fill(s : NetflowwindowCluster, v : Double) -> NetflowwindowCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_flow_window_cluster_min(s : NetflowwindowCluster) -> Double { @_common.min(s.data) }

pub fn net_flow_window_cluster_max(s : NetflowwindowCluster) -> Double { @_common.max(s.data) }

pub fn net_flow_window_cluster_to_string(s : NetflowwindowCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetflowwindowModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_flow_window_model_make(size : Int) -> NetflowwindowModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_flow_window_model_len(s : NetflowwindowModel) -> Int { s.size }

pub fn net_flow_window_model_get(s : NetflowwindowModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_flow_window_model_set(s : NetflowwindowModel, i : Int, v : Double) -> NetflowwindowModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn net_flow_window_model_sum(s : NetflowwindowModel) -> Double { @_common.sum(s.data) }

pub fn net_flow_window_model_mean(s : NetflowwindowModel) -> Double { @_common.mean(s.data) }

pub fn net_flow_window_model_scale(s : NetflowwindowModel, f : Double) -> NetflowwindowModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_flow_window_model_add(a : NetflowwindowModel, b : NetflowwindowModel) -> NetflowwindowModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_flow_window_model_copy(s : NetflowwindowModel) -> NetflowwindowModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_flow_window_model_fill(s : NetflowwindowModel, v : Double) -> NetflowwindowModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_flow_window_model_min(s : NetflowwindowModel) -> Double { @_common.min(s.data) }

pub fn net_flow_window_model_max(s : NetflowwindowModel) -> Double { @_common.max(s.data) }

pub fn net_flow_window_model_to_string(s : NetflowwindowModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetflowwindowLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_flow_window_layer_make(size : Int) -> NetflowwindowLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_flow_window_layer_len(s : NetflowwindowLayer) -> Int { s.size }

pub fn net_flow_window_layer_get(s : NetflowwindowLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_flow_window_layer_set(s : NetflowwindowLayer, i : Int, v : Double) -> NetflowwindowLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn net_flow_window_layer_sum(s : NetflowwindowLayer) -> Double { @_common.sum(s.data) }

pub fn net_flow_window_layer_mean(s : NetflowwindowLayer) -> Double { @_common.mean(s.data) }

pub fn net_flow_window_layer_scale(s : NetflowwindowLayer, f : Double) -> NetflowwindowLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_flow_window_layer_add(a : NetflowwindowLayer, b : NetflowwindowLayer) -> NetflowwindowLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_flow_window_layer_copy(s : NetflowwindowLayer) -> NetflowwindowLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_flow_window_layer_fill(s : NetflowwindowLayer, v : Double) -> NetflowwindowLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_flow_window_layer_min(s : NetflowwindowLayer) -> Double { @_common.min(s.data) }

pub fn net_flow_window_layer_max(s : NetflowwindowLayer) -> Double { @_common.max(s.data) }

pub fn net_flow_window_layer_to_string(s : NetflowwindowLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetflowwindowBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_flow_window_buffer_make(size : Int) -> NetflowwindowBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_flow_window_buffer_len(s : NetflowwindowBuffer) -> Int { s.size }

pub fn net_flow_window_buffer_get(s : NetflowwindowBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_flow_window_buffer_set(s : NetflowwindowBuffer, i : Int, v : Double) -> NetflowwindowBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn net_flow_window_buffer_sum(s : NetflowwindowBuffer) -> Double { @_common.sum(s.data) }

pub fn net_flow_window_buffer_mean(s : NetflowwindowBuffer) -> Double { @_common.mean(s.data) }

pub fn net_flow_window_buffer_scale(s : NetflowwindowBuffer, f : Double) -> NetflowwindowBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_flow_window_buffer_add(a : NetflowwindowBuffer, b : NetflowwindowBuffer) -> NetflowwindowBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_flow_window_buffer_copy(s : NetflowwindowBuffer) -> NetflowwindowBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_flow_window_buffer_fill(s : NetflowwindowBuffer, v : Double) -> NetflowwindowBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_flow_window_buffer_min(s : NetflowwindowBuffer) -> Double { @_common.min(s.data) }

pub fn net_flow_window_buffer_max(s : NetflowwindowBuffer) -> Double { @_common.max(s.data) }

pub fn net_flow_window_buffer_to_string(s : NetflowwindowBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetflowwindowCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_flow_window_cursor_make(size : Int) -> NetflowwindowCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_flow_window_cursor_len(s : NetflowwindowCursor) -> Int { s.size }

pub fn net_flow_window_cursor_get(s : NetflowwindowCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_flow_window_cursor_set(s : NetflowwindowCursor, i : Int, v : Double) -> NetflowwindowCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn net_flow_window_cursor_sum(s : NetflowwindowCursor) -> Double { @_common.sum(s.data) }

pub fn net_flow_window_cursor_mean(s : NetflowwindowCursor) -> Double { @_common.mean(s.data) }

pub fn net_flow_window_cursor_scale(s : NetflowwindowCursor, f : Double) -> NetflowwindowCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_flow_window_cursor_add(a : NetflowwindowCursor, b : NetflowwindowCursor) -> NetflowwindowCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_flow_window_cursor_copy(s : NetflowwindowCursor) -> NetflowwindowCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_flow_window_cursor_fill(s : NetflowwindowCursor, v : Double) -> NetflowwindowCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_flow_window_cursor_min(s : NetflowwindowCursor) -> Double { @_common.min(s.data) }

pub fn net_flow_window_cursor_max(s : NetflowwindowCursor) -> Double { @_common.max(s.data) }

pub fn net_flow_window_cursor_to_string(s : NetflowwindowCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetflowwindowView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_flow_window_view_make(size : Int) -> NetflowwindowView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_flow_window_view_len(s : NetflowwindowView) -> Int { s.size }

pub fn net_flow_window_view_get(s : NetflowwindowView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_flow_window_view_set(s : NetflowwindowView, i : Int, v : Double) -> NetflowwindowView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn net_flow_window_view_sum(s : NetflowwindowView) -> Double { @_common.sum(s.data) }

pub fn net_flow_window_view_mean(s : NetflowwindowView) -> Double { @_common.mean(s.data) }

pub fn net_flow_window_view_scale(s : NetflowwindowView, f : Double) -> NetflowwindowView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_flow_window_view_add(a : NetflowwindowView, b : NetflowwindowView) -> NetflowwindowView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_flow_window_view_copy(s : NetflowwindowView) -> NetflowwindowView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_flow_window_view_fill(s : NetflowwindowView, v : Double) -> NetflowwindowView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_flow_window_view_min(s : NetflowwindowView) -> Double { @_common.min(s.data) }

pub fn net_flow_window_view_max(s : NetflowwindowView) -> Double { @_common.max(s.data) }

pub fn net_flow_window_view_to_string(s : NetflowwindowView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetflowwindowRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_flow_window_range_make(size : Int) -> NetflowwindowRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_flow_window_range_len(s : NetflowwindowRange) -> Int { s.size }

pub fn net_flow_window_range_get(s : NetflowwindowRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_flow_window_range_set(s : NetflowwindowRange, i : Int, v : Double) -> NetflowwindowRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn net_flow_window_range_sum(s : NetflowwindowRange) -> Double { @_common.sum(s.data) }

pub fn net_flow_window_range_mean(s : NetflowwindowRange) -> Double { @_common.mean(s.data) }

pub fn net_flow_window_range_scale(s : NetflowwindowRange, f : Double) -> NetflowwindowRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_flow_window_range_add(a : NetflowwindowRange, b : NetflowwindowRange) -> NetflowwindowRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_flow_window_range_copy(s : NetflowwindowRange) -> NetflowwindowRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_flow_window_range_fill(s : NetflowwindowRange, v : Double) -> NetflowwindowRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_flow_window_range_min(s : NetflowwindowRange) -> Double { @_common.min(s.data) }

pub fn net_flow_window_range_max(s : NetflowwindowRange) -> Double { @_common.max(s.data) }

pub fn net_flow_window_range_to_string(s : NetflowwindowRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetflowwindowSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_flow_window_slice_make(size : Int) -> NetflowwindowSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_flow_window_slice_len(s : NetflowwindowSlice) -> Int { s.size }

pub fn net_flow_window_slice_get(s : NetflowwindowSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_flow_window_slice_set(s : NetflowwindowSlice, i : Int, v : Double) -> NetflowwindowSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn net_flow_window_slice_sum(s : NetflowwindowSlice) -> Double { @_common.sum(s.data) }

pub fn net_flow_window_slice_mean(s : NetflowwindowSlice) -> Double { @_common.mean(s.data) }

pub fn net_flow_window_slice_scale(s : NetflowwindowSlice, f : Double) -> NetflowwindowSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_flow_window_slice_add(a : NetflowwindowSlice, b : NetflowwindowSlice) -> NetflowwindowSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_flow_window_slice_copy(s : NetflowwindowSlice) -> NetflowwindowSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_flow_window_slice_fill(s : NetflowwindowSlice, v : Double) -> NetflowwindowSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_flow_window_slice_min(s : NetflowwindowSlice) -> Double { @_common.min(s.data) }

pub fn net_flow_window_slice_max(s : NetflowwindowSlice) -> Double { @_common.max(s.data) }

pub fn net_flow_window_slice_to_string(s : NetflowwindowSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

