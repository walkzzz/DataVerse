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

pub fn NetflowwindowFrame::len(self : NetflowwindowFrame) -> Int { self.size }

pub fn NetflowwindowFrame::get(self : NetflowwindowFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NetflowwindowFrame::set(self : NetflowwindowFrame, i : Int, v : Double) -> NetflowwindowFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NetflowwindowFrame::sum(self : NetflowwindowFrame) -> Double { @_common.sum(self.data) }

pub fn NetflowwindowFrame::mean(self : NetflowwindowFrame) -> Double { @_common.mean(self.data) }

pub fn NetflowwindowFrame::scale(self : NetflowwindowFrame, f : Double) -> NetflowwindowFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NetflowwindowFrame::add(self : NetflowwindowFrame, other : NetflowwindowFrame) -> NetflowwindowFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NetflowwindowFrame::copy(self : NetflowwindowFrame) -> NetflowwindowFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NetflowwindowFrame::fill(self : NetflowwindowFrame, v : Double) -> NetflowwindowFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NetflowwindowFrame::min(self : NetflowwindowFrame) -> Double { @_common.min(self.data) }

pub fn NetflowwindowFrame::max(self : NetflowwindowFrame) -> Double { @_common.max(self.data) }

pub fn NetflowwindowFrame::to_string(self : NetflowwindowFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NetflowwindowTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_flow_window_table_make(size : Int) -> NetflowwindowTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NetflowwindowTable::len(self : NetflowwindowTable) -> Int { self.size }

pub fn NetflowwindowTable::get(self : NetflowwindowTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NetflowwindowTable::set(self : NetflowwindowTable, i : Int, v : Double) -> NetflowwindowTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NetflowwindowTable::sum(self : NetflowwindowTable) -> Double { @_common.sum(self.data) }

pub fn NetflowwindowTable::mean(self : NetflowwindowTable) -> Double { @_common.mean(self.data) }

pub fn NetflowwindowTable::scale(self : NetflowwindowTable, f : Double) -> NetflowwindowTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NetflowwindowTable::add(self : NetflowwindowTable, other : NetflowwindowTable) -> NetflowwindowTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NetflowwindowTable::copy(self : NetflowwindowTable) -> NetflowwindowTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NetflowwindowTable::fill(self : NetflowwindowTable, v : Double) -> NetflowwindowTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NetflowwindowTable::min(self : NetflowwindowTable) -> Double { @_common.min(self.data) }

pub fn NetflowwindowTable::max(self : NetflowwindowTable) -> Double { @_common.max(self.data) }

pub fn NetflowwindowTable::to_string(self : NetflowwindowTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NetflowwindowGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_flow_window_graphn_make(size : Int) -> NetflowwindowGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NetflowwindowGraphN::len(self : NetflowwindowGraphN) -> Int { self.size }

pub fn NetflowwindowGraphN::get(self : NetflowwindowGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NetflowwindowGraphN::set(self : NetflowwindowGraphN, i : Int, v : Double) -> NetflowwindowGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NetflowwindowGraphN::sum(self : NetflowwindowGraphN) -> Double { @_common.sum(self.data) }

pub fn NetflowwindowGraphN::mean(self : NetflowwindowGraphN) -> Double { @_common.mean(self.data) }

pub fn NetflowwindowGraphN::scale(self : NetflowwindowGraphN, f : Double) -> NetflowwindowGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NetflowwindowGraphN::add(self : NetflowwindowGraphN, other : NetflowwindowGraphN) -> NetflowwindowGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NetflowwindowGraphN::copy(self : NetflowwindowGraphN) -> NetflowwindowGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NetflowwindowGraphN::fill(self : NetflowwindowGraphN, v : Double) -> NetflowwindowGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NetflowwindowGraphN::min(self : NetflowwindowGraphN) -> Double { @_common.min(self.data) }

pub fn NetflowwindowGraphN::max(self : NetflowwindowGraphN) -> Double { @_common.max(self.data) }

pub fn NetflowwindowGraphN::to_string(self : NetflowwindowGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NetflowwindowNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_flow_window_node_make(size : Int) -> NetflowwindowNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NetflowwindowNode::len(self : NetflowwindowNode) -> Int { self.size }

pub fn NetflowwindowNode::get(self : NetflowwindowNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NetflowwindowNode::set(self : NetflowwindowNode, i : Int, v : Double) -> NetflowwindowNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NetflowwindowNode::sum(self : NetflowwindowNode) -> Double { @_common.sum(self.data) }

pub fn NetflowwindowNode::mean(self : NetflowwindowNode) -> Double { @_common.mean(self.data) }

pub fn NetflowwindowNode::scale(self : NetflowwindowNode, f : Double) -> NetflowwindowNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NetflowwindowNode::add(self : NetflowwindowNode, other : NetflowwindowNode) -> NetflowwindowNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NetflowwindowNode::copy(self : NetflowwindowNode) -> NetflowwindowNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NetflowwindowNode::fill(self : NetflowwindowNode, v : Double) -> NetflowwindowNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NetflowwindowNode::min(self : NetflowwindowNode) -> Double { @_common.min(self.data) }

pub fn NetflowwindowNode::max(self : NetflowwindowNode) -> Double { @_common.max(self.data) }

pub fn NetflowwindowNode::to_string(self : NetflowwindowNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NetflowwindowEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_flow_window_edge_make(size : Int) -> NetflowwindowEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NetflowwindowEdge::len(self : NetflowwindowEdge) -> Int { self.size }

pub fn NetflowwindowEdge::get(self : NetflowwindowEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NetflowwindowEdge::set(self : NetflowwindowEdge, i : Int, v : Double) -> NetflowwindowEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NetflowwindowEdge::sum(self : NetflowwindowEdge) -> Double { @_common.sum(self.data) }

pub fn NetflowwindowEdge::mean(self : NetflowwindowEdge) -> Double { @_common.mean(self.data) }

pub fn NetflowwindowEdge::scale(self : NetflowwindowEdge, f : Double) -> NetflowwindowEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NetflowwindowEdge::add(self : NetflowwindowEdge, other : NetflowwindowEdge) -> NetflowwindowEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NetflowwindowEdge::copy(self : NetflowwindowEdge) -> NetflowwindowEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NetflowwindowEdge::fill(self : NetflowwindowEdge, v : Double) -> NetflowwindowEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NetflowwindowEdge::min(self : NetflowwindowEdge) -> Double { @_common.min(self.data) }

pub fn NetflowwindowEdge::max(self : NetflowwindowEdge) -> Double { @_common.max(self.data) }

pub fn NetflowwindowEdge::to_string(self : NetflowwindowEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NetflowwindowPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_flow_window_path_make(size : Int) -> NetflowwindowPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NetflowwindowPath::len(self : NetflowwindowPath) -> Int { self.size }

pub fn NetflowwindowPath::get(self : NetflowwindowPath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NetflowwindowPath::set(self : NetflowwindowPath, i : Int, v : Double) -> NetflowwindowPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NetflowwindowPath::sum(self : NetflowwindowPath) -> Double { @_common.sum(self.data) }

pub fn NetflowwindowPath::mean(self : NetflowwindowPath) -> Double { @_common.mean(self.data) }

pub fn NetflowwindowPath::scale(self : NetflowwindowPath, f : Double) -> NetflowwindowPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NetflowwindowPath::add(self : NetflowwindowPath, other : NetflowwindowPath) -> NetflowwindowPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NetflowwindowPath::copy(self : NetflowwindowPath) -> NetflowwindowPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NetflowwindowPath::fill(self : NetflowwindowPath, v : Double) -> NetflowwindowPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NetflowwindowPath::min(self : NetflowwindowPath) -> Double { @_common.min(self.data) }

pub fn NetflowwindowPath::max(self : NetflowwindowPath) -> Double { @_common.max(self.data) }

pub fn NetflowwindowPath::to_string(self : NetflowwindowPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NetflowwindowCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_flow_window_cluster_make(size : Int) -> NetflowwindowCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NetflowwindowCluster::len(self : NetflowwindowCluster) -> Int { self.size }

pub fn NetflowwindowCluster::get(self : NetflowwindowCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NetflowwindowCluster::set(self : NetflowwindowCluster, i : Int, v : Double) -> NetflowwindowCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NetflowwindowCluster::sum(self : NetflowwindowCluster) -> Double { @_common.sum(self.data) }

pub fn NetflowwindowCluster::mean(self : NetflowwindowCluster) -> Double { @_common.mean(self.data) }

pub fn NetflowwindowCluster::scale(self : NetflowwindowCluster, f : Double) -> NetflowwindowCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NetflowwindowCluster::add(self : NetflowwindowCluster, other : NetflowwindowCluster) -> NetflowwindowCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NetflowwindowCluster::copy(self : NetflowwindowCluster) -> NetflowwindowCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NetflowwindowCluster::fill(self : NetflowwindowCluster, v : Double) -> NetflowwindowCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NetflowwindowCluster::min(self : NetflowwindowCluster) -> Double { @_common.min(self.data) }

pub fn NetflowwindowCluster::max(self : NetflowwindowCluster) -> Double { @_common.max(self.data) }

pub fn NetflowwindowCluster::to_string(self : NetflowwindowCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NetflowwindowModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_flow_window_model_make(size : Int) -> NetflowwindowModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NetflowwindowModel::len(self : NetflowwindowModel) -> Int { self.size }

pub fn NetflowwindowModel::get(self : NetflowwindowModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NetflowwindowModel::set(self : NetflowwindowModel, i : Int, v : Double) -> NetflowwindowModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NetflowwindowModel::sum(self : NetflowwindowModel) -> Double { @_common.sum(self.data) }

pub fn NetflowwindowModel::mean(self : NetflowwindowModel) -> Double { @_common.mean(self.data) }

pub fn NetflowwindowModel::scale(self : NetflowwindowModel, f : Double) -> NetflowwindowModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NetflowwindowModel::add(self : NetflowwindowModel, other : NetflowwindowModel) -> NetflowwindowModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NetflowwindowModel::copy(self : NetflowwindowModel) -> NetflowwindowModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NetflowwindowModel::fill(self : NetflowwindowModel, v : Double) -> NetflowwindowModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NetflowwindowModel::min(self : NetflowwindowModel) -> Double { @_common.min(self.data) }

pub fn NetflowwindowModel::max(self : NetflowwindowModel) -> Double { @_common.max(self.data) }

pub fn NetflowwindowModel::to_string(self : NetflowwindowModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NetflowwindowLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_flow_window_layer_make(size : Int) -> NetflowwindowLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NetflowwindowLayer::len(self : NetflowwindowLayer) -> Int { self.size }

pub fn NetflowwindowLayer::get(self : NetflowwindowLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NetflowwindowLayer::set(self : NetflowwindowLayer, i : Int, v : Double) -> NetflowwindowLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NetflowwindowLayer::sum(self : NetflowwindowLayer) -> Double { @_common.sum(self.data) }

pub fn NetflowwindowLayer::mean(self : NetflowwindowLayer) -> Double { @_common.mean(self.data) }

pub fn NetflowwindowLayer::scale(self : NetflowwindowLayer, f : Double) -> NetflowwindowLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NetflowwindowLayer::add(self : NetflowwindowLayer, other : NetflowwindowLayer) -> NetflowwindowLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NetflowwindowLayer::copy(self : NetflowwindowLayer) -> NetflowwindowLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NetflowwindowLayer::fill(self : NetflowwindowLayer, v : Double) -> NetflowwindowLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NetflowwindowLayer::min(self : NetflowwindowLayer) -> Double { @_common.min(self.data) }

pub fn NetflowwindowLayer::max(self : NetflowwindowLayer) -> Double { @_common.max(self.data) }

pub fn NetflowwindowLayer::to_string(self : NetflowwindowLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NetflowwindowBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_flow_window_buffer_make(size : Int) -> NetflowwindowBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NetflowwindowBuffer::len(self : NetflowwindowBuffer) -> Int { self.size }

pub fn NetflowwindowBuffer::get(self : NetflowwindowBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NetflowwindowBuffer::set(self : NetflowwindowBuffer, i : Int, v : Double) -> NetflowwindowBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NetflowwindowBuffer::sum(self : NetflowwindowBuffer) -> Double { @_common.sum(self.data) }

pub fn NetflowwindowBuffer::mean(self : NetflowwindowBuffer) -> Double { @_common.mean(self.data) }

pub fn NetflowwindowBuffer::scale(self : NetflowwindowBuffer, f : Double) -> NetflowwindowBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NetflowwindowBuffer::add(self : NetflowwindowBuffer, other : NetflowwindowBuffer) -> NetflowwindowBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NetflowwindowBuffer::copy(self : NetflowwindowBuffer) -> NetflowwindowBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NetflowwindowBuffer::fill(self : NetflowwindowBuffer, v : Double) -> NetflowwindowBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NetflowwindowBuffer::min(self : NetflowwindowBuffer) -> Double { @_common.min(self.data) }

pub fn NetflowwindowBuffer::max(self : NetflowwindowBuffer) -> Double { @_common.max(self.data) }

pub fn NetflowwindowBuffer::to_string(self : NetflowwindowBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NetflowwindowCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_flow_window_cursor_make(size : Int) -> NetflowwindowCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NetflowwindowCursor::len(self : NetflowwindowCursor) -> Int { self.size }

pub fn NetflowwindowCursor::get(self : NetflowwindowCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NetflowwindowCursor::set(self : NetflowwindowCursor, i : Int, v : Double) -> NetflowwindowCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NetflowwindowCursor::sum(self : NetflowwindowCursor) -> Double { @_common.sum(self.data) }

pub fn NetflowwindowCursor::mean(self : NetflowwindowCursor) -> Double { @_common.mean(self.data) }

pub fn NetflowwindowCursor::scale(self : NetflowwindowCursor, f : Double) -> NetflowwindowCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NetflowwindowCursor::add(self : NetflowwindowCursor, other : NetflowwindowCursor) -> NetflowwindowCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NetflowwindowCursor::copy(self : NetflowwindowCursor) -> NetflowwindowCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NetflowwindowCursor::fill(self : NetflowwindowCursor, v : Double) -> NetflowwindowCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NetflowwindowCursor::min(self : NetflowwindowCursor) -> Double { @_common.min(self.data) }

pub fn NetflowwindowCursor::max(self : NetflowwindowCursor) -> Double { @_common.max(self.data) }

pub fn NetflowwindowCursor::to_string(self : NetflowwindowCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NetflowwindowView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_flow_window_view_make(size : Int) -> NetflowwindowView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NetflowwindowView::len(self : NetflowwindowView) -> Int { self.size }

pub fn NetflowwindowView::get(self : NetflowwindowView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NetflowwindowView::set(self : NetflowwindowView, i : Int, v : Double) -> NetflowwindowView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NetflowwindowView::sum(self : NetflowwindowView) -> Double { @_common.sum(self.data) }

pub fn NetflowwindowView::mean(self : NetflowwindowView) -> Double { @_common.mean(self.data) }

pub fn NetflowwindowView::scale(self : NetflowwindowView, f : Double) -> NetflowwindowView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NetflowwindowView::add(self : NetflowwindowView, other : NetflowwindowView) -> NetflowwindowView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NetflowwindowView::copy(self : NetflowwindowView) -> NetflowwindowView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NetflowwindowView::fill(self : NetflowwindowView, v : Double) -> NetflowwindowView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NetflowwindowView::min(self : NetflowwindowView) -> Double { @_common.min(self.data) }

pub fn NetflowwindowView::max(self : NetflowwindowView) -> Double { @_common.max(self.data) }

pub fn NetflowwindowView::to_string(self : NetflowwindowView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NetflowwindowRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_flow_window_range_make(size : Int) -> NetflowwindowRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NetflowwindowRange::len(self : NetflowwindowRange) -> Int { self.size }

pub fn NetflowwindowRange::get(self : NetflowwindowRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NetflowwindowRange::set(self : NetflowwindowRange, i : Int, v : Double) -> NetflowwindowRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NetflowwindowRange::sum(self : NetflowwindowRange) -> Double { @_common.sum(self.data) }

pub fn NetflowwindowRange::mean(self : NetflowwindowRange) -> Double { @_common.mean(self.data) }

pub fn NetflowwindowRange::scale(self : NetflowwindowRange, f : Double) -> NetflowwindowRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NetflowwindowRange::add(self : NetflowwindowRange, other : NetflowwindowRange) -> NetflowwindowRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NetflowwindowRange::copy(self : NetflowwindowRange) -> NetflowwindowRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NetflowwindowRange::fill(self : NetflowwindowRange, v : Double) -> NetflowwindowRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NetflowwindowRange::min(self : NetflowwindowRange) -> Double { @_common.min(self.data) }

pub fn NetflowwindowRange::max(self : NetflowwindowRange) -> Double { @_common.max(self.data) }

pub fn NetflowwindowRange::to_string(self : NetflowwindowRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NetflowwindowSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_flow_window_slice_make(size : Int) -> NetflowwindowSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NetflowwindowSlice::len(self : NetflowwindowSlice) -> Int { self.size }

pub fn NetflowwindowSlice::get(self : NetflowwindowSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NetflowwindowSlice::set(self : NetflowwindowSlice, i : Int, v : Double) -> NetflowwindowSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NetflowwindowSlice::sum(self : NetflowwindowSlice) -> Double { @_common.sum(self.data) }

pub fn NetflowwindowSlice::mean(self : NetflowwindowSlice) -> Double { @_common.mean(self.data) }

pub fn NetflowwindowSlice::scale(self : NetflowwindowSlice, f : Double) -> NetflowwindowSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NetflowwindowSlice::add(self : NetflowwindowSlice, other : NetflowwindowSlice) -> NetflowwindowSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NetflowwindowSlice::copy(self : NetflowwindowSlice) -> NetflowwindowSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NetflowwindowSlice::fill(self : NetflowwindowSlice, v : Double) -> NetflowwindowSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NetflowwindowSlice::min(self : NetflowwindowSlice) -> Double { @_common.min(self.data) }

pub fn NetflowwindowSlice::max(self : NetflowwindowSlice) -> Double { @_common.max(self.data) }

pub fn NetflowwindowSlice::to_string(self : NetflowwindowSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

