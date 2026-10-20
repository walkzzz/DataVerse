///===
/// extcore/net_flow_scheduling

pub(all) struct NetflowschedulingPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn net_flow_scheduling_make_point(x : Double, y : Double) -> NetflowschedulingPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn net_flow_scheduling_make_point3(x : Double, y : Double, z : Double) -> NetflowschedulingPoint {
  { x, y, z, label: 0 }
}

pub fn NetflowschedulingPoint::x(self : NetflowschedulingPoint) -> Double { self.x }

pub fn NetflowschedulingPoint::y(self : NetflowschedulingPoint) -> Double { self.y }

pub fn NetflowschedulingPoint::z(self : NetflowschedulingPoint) -> Double { self.z }

pub fn NetflowschedulingPoint::label(self : NetflowschedulingPoint) -> Int { self.label }

pub fn NetflowschedulingPoint::dist(self : NetflowschedulingPoint, other : NetflowschedulingPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn NetflowschedulingPoint::add(self : NetflowschedulingPoint, other : NetflowschedulingPoint) -> NetflowschedulingPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn NetflowschedulingPoint::sub(self : NetflowschedulingPoint, other : NetflowschedulingPoint) -> NetflowschedulingPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn NetflowschedulingPoint::scale(self : NetflowschedulingPoint, s : Double) -> NetflowschedulingPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn NetflowschedulingPoint::dot(self : NetflowschedulingPoint, other : NetflowschedulingPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn NetflowschedulingPoint::cross(self : NetflowschedulingPoint, other : NetflowschedulingPoint) -> NetflowschedulingPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn NetflowschedulingPoint::norm(self : NetflowschedulingPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn NetflowschedulingPoint::normalize(self : NetflowschedulingPoint) -> NetflowschedulingPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn NetflowschedulingPoint::negate(self : NetflowschedulingPoint) -> NetflowschedulingPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn NetflowschedulingPoint::mid(self : NetflowschedulingPoint, other : NetflowschedulingPoint) -> NetflowschedulingPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn NetflowschedulingPoint::lerp(self : NetflowschedulingPoint, other : NetflowschedulingPoint, t : Double) -> NetflowschedulingPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn NetflowschedulingPoint::to_string(self : NetflowschedulingPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct NetflowschedulingSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn net_flow_scheduling_make_series(vals : Array[Double], name : String) -> NetflowschedulingSeries {
  { vals, name, meta: 0 }
}

pub fn NetflowschedulingSeries::len(self : NetflowschedulingSeries) -> Int { self.vals.length() }

pub fn NetflowschedulingSeries::sum(self : NetflowschedulingSeries) -> Double { @_common.sum(self.vals) }

pub fn NetflowschedulingSeries::mean(self : NetflowschedulingSeries) -> Double { @_common.mean(self.vals) }

pub fn NetflowschedulingSeries::min(self : NetflowschedulingSeries) -> Double { @_common.min(self.vals) }

pub fn NetflowschedulingSeries::max(self : NetflowschedulingSeries) -> Double { @_common.max(self.vals) }

pub fn NetflowschedulingSeries::range(self : NetflowschedulingSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn NetflowschedulingSeries::variance(self : NetflowschedulingSeries) -> Double { @_common.variance(self.vals) }

pub fn NetflowschedulingSeries::std(self : NetflowschedulingSeries) -> Double { @_common.std(self.vals) }

pub fn NetflowschedulingSeries::median(self : NetflowschedulingSeries) -> Double { @_common.median(self.vals) }

pub fn NetflowschedulingSeries::scale(self : NetflowschedulingSeries, f : Double) -> NetflowschedulingSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn NetflowschedulingSeries::add(self : NetflowschedulingSeries, other : NetflowschedulingSeries) -> NetflowschedulingSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn NetflowschedulingSeries::sub(self : NetflowschedulingSeries, other : NetflowschedulingSeries) -> NetflowschedulingSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn NetflowschedulingSeries::normalize(self : NetflowschedulingSeries) -> NetflowschedulingSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn NetflowschedulingSeries::cumsum(self : NetflowschedulingSeries) -> NetflowschedulingSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn NetflowschedulingSeries::to_string(self : NetflowschedulingSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct NetflowschedulingMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn net_flow_scheduling_make_matrix(rows : Int, cols : Int, val : Double) -> NetflowschedulingMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn net_flow_scheduling_matrix_identity(n : Int) -> NetflowschedulingMatrix {
  let m = net_flow_scheduling_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn NetflowschedulingMatrix::get(self : NetflowschedulingMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn NetflowschedulingMatrix::transpose(self : NetflowschedulingMatrix) -> NetflowschedulingMatrix {
  let result = net_flow_scheduling_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn NetflowschedulingMatrix::add(self : NetflowschedulingMatrix, other : NetflowschedulingMatrix) -> NetflowschedulingMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = net_flow_scheduling_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn NetflowschedulingMatrix::scale(self : NetflowschedulingMatrix, s : Double) -> NetflowschedulingMatrix {
  let result = net_flow_scheduling_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn NetflowschedulingMatrix::multiply(self : NetflowschedulingMatrix, other : NetflowschedulingMatrix) -> NetflowschedulingMatrix {
  if self.cols != other.rows { return net_flow_scheduling_make_matrix(self.rows, other.cols, 0.0) }
  let result = net_flow_scheduling_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn NetflowschedulingMatrix::trace(self : NetflowschedulingMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn NetflowschedulingMatrix::det(self : NetflowschedulingMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn NetflowschedulingMatrix::norm(self : NetflowschedulingMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn NetflowschedulingMatrix::to_string(self : NetflowschedulingMatrix) -> String {
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

pub(all) struct NetflowschedulingVector {
  comps : Array[Double]
  dim : Int
}

pub fn net_flow_scheduling_make_vector(comps : Array[Double]) -> NetflowschedulingVector {
  { comps, dim: comps.length() }
}

pub fn net_flow_scheduling_vector_zero(dim : Int) -> NetflowschedulingVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn NetflowschedulingVector::add(self : NetflowschedulingVector, other : NetflowschedulingVector) -> NetflowschedulingVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn NetflowschedulingVector::sub(self : NetflowschedulingVector, other : NetflowschedulingVector) -> NetflowschedulingVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn NetflowschedulingVector::scale(self : NetflowschedulingVector, s : Double) -> NetflowschedulingVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn NetflowschedulingVector::dot(self : NetflowschedulingVector, other : NetflowschedulingVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn NetflowschedulingVector::norm(self : NetflowschedulingVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn NetflowschedulingVector::normalize(self : NetflowschedulingVector) -> NetflowschedulingVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn NetflowschedulingVector::dist(self : NetflowschedulingVector, other : NetflowschedulingVector) -> Double {
  self.sub(other).norm()
}

pub fn NetflowschedulingVector::to_string(self : NetflowschedulingVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn net_flow_scheduling_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn net_flow_scheduling_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn net_flow_scheduling_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn net_flow_scheduling_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn net_flow_scheduling_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn net_flow_scheduling_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn net_flow_scheduling_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn net_flow_scheduling_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn net_flow_scheduling_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn net_flow_scheduling_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn net_flow_scheduling_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn net_flow_scheduling_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn net_flow_scheduling_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn net_flow_scheduling_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn net_flow_scheduling_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn net_flow_scheduling_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn net_flow_scheduling_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn net_flow_scheduling_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn net_flow_scheduling_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn net_flow_scheduling_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn net_flow_scheduling_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn net_flow_scheduling_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn net_flow_scheduling_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn net_flow_scheduling_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn net_flow_scheduling_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn net_flow_scheduling_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn net_flow_scheduling_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn net_flow_scheduling_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn net_flow_scheduling_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct NetflowschedulingFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_flow_scheduling_frame_make(size : Int) -> NetflowschedulingFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_flow_scheduling_frame_len(s : NetflowschedulingFrame) -> Int { s.size }

pub fn net_flow_scheduling_frame_get(s : NetflowschedulingFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_flow_scheduling_frame_set(s : NetflowschedulingFrame, i : Int, v : Double) -> NetflowschedulingFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn net_flow_scheduling_frame_sum(s : NetflowschedulingFrame) -> Double { @_common.sum(s.data) }

pub fn net_flow_scheduling_frame_mean(s : NetflowschedulingFrame) -> Double { @_common.mean(s.data) }

pub fn net_flow_scheduling_frame_scale(s : NetflowschedulingFrame, f : Double) -> NetflowschedulingFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_flow_scheduling_frame_add(a : NetflowschedulingFrame, b : NetflowschedulingFrame) -> NetflowschedulingFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_flow_scheduling_frame_copy(s : NetflowschedulingFrame) -> NetflowschedulingFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_flow_scheduling_frame_fill(s : NetflowschedulingFrame, v : Double) -> NetflowschedulingFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_flow_scheduling_frame_min(s : NetflowschedulingFrame) -> Double { @_common.min(s.data) }

pub fn net_flow_scheduling_frame_max(s : NetflowschedulingFrame) -> Double { @_common.max(s.data) }

pub fn net_flow_scheduling_frame_to_string(s : NetflowschedulingFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetflowschedulingTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_flow_scheduling_table_make(size : Int) -> NetflowschedulingTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_flow_scheduling_table_len(s : NetflowschedulingTable) -> Int { s.size }

pub fn net_flow_scheduling_table_get(s : NetflowschedulingTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_flow_scheduling_table_set(s : NetflowschedulingTable, i : Int, v : Double) -> NetflowschedulingTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn net_flow_scheduling_table_sum(s : NetflowschedulingTable) -> Double { @_common.sum(s.data) }

pub fn net_flow_scheduling_table_mean(s : NetflowschedulingTable) -> Double { @_common.mean(s.data) }

pub fn net_flow_scheduling_table_scale(s : NetflowschedulingTable, f : Double) -> NetflowschedulingTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_flow_scheduling_table_add(a : NetflowschedulingTable, b : NetflowschedulingTable) -> NetflowschedulingTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_flow_scheduling_table_copy(s : NetflowschedulingTable) -> NetflowschedulingTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_flow_scheduling_table_fill(s : NetflowschedulingTable, v : Double) -> NetflowschedulingTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_flow_scheduling_table_min(s : NetflowschedulingTable) -> Double { @_common.min(s.data) }

pub fn net_flow_scheduling_table_max(s : NetflowschedulingTable) -> Double { @_common.max(s.data) }

pub fn net_flow_scheduling_table_to_string(s : NetflowschedulingTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetflowschedulingGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_flow_scheduling_graphn_make(size : Int) -> NetflowschedulingGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_flow_scheduling_graphn_len(s : NetflowschedulingGraphN) -> Int { s.size }

pub fn net_flow_scheduling_graphn_get(s : NetflowschedulingGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_flow_scheduling_graphn_set(s : NetflowschedulingGraphN, i : Int, v : Double) -> NetflowschedulingGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn net_flow_scheduling_graphn_sum(s : NetflowschedulingGraphN) -> Double { @_common.sum(s.data) }

pub fn net_flow_scheduling_graphn_mean(s : NetflowschedulingGraphN) -> Double { @_common.mean(s.data) }

pub fn net_flow_scheduling_graphn_scale(s : NetflowschedulingGraphN, f : Double) -> NetflowschedulingGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_flow_scheduling_graphn_add(a : NetflowschedulingGraphN, b : NetflowschedulingGraphN) -> NetflowschedulingGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_flow_scheduling_graphn_copy(s : NetflowschedulingGraphN) -> NetflowschedulingGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_flow_scheduling_graphn_fill(s : NetflowschedulingGraphN, v : Double) -> NetflowschedulingGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_flow_scheduling_graphn_min(s : NetflowschedulingGraphN) -> Double { @_common.min(s.data) }

pub fn net_flow_scheduling_graphn_max(s : NetflowschedulingGraphN) -> Double { @_common.max(s.data) }

pub fn net_flow_scheduling_graphn_to_string(s : NetflowschedulingGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetflowschedulingNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_flow_scheduling_node_make(size : Int) -> NetflowschedulingNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_flow_scheduling_node_len(s : NetflowschedulingNode) -> Int { s.size }

pub fn net_flow_scheduling_node_get(s : NetflowschedulingNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_flow_scheduling_node_set(s : NetflowschedulingNode, i : Int, v : Double) -> NetflowschedulingNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn net_flow_scheduling_node_sum(s : NetflowschedulingNode) -> Double { @_common.sum(s.data) }

pub fn net_flow_scheduling_node_mean(s : NetflowschedulingNode) -> Double { @_common.mean(s.data) }

pub fn net_flow_scheduling_node_scale(s : NetflowschedulingNode, f : Double) -> NetflowschedulingNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_flow_scheduling_node_add(a : NetflowschedulingNode, b : NetflowschedulingNode) -> NetflowschedulingNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_flow_scheduling_node_copy(s : NetflowschedulingNode) -> NetflowschedulingNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_flow_scheduling_node_fill(s : NetflowschedulingNode, v : Double) -> NetflowschedulingNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_flow_scheduling_node_min(s : NetflowschedulingNode) -> Double { @_common.min(s.data) }

pub fn net_flow_scheduling_node_max(s : NetflowschedulingNode) -> Double { @_common.max(s.data) }

pub fn net_flow_scheduling_node_to_string(s : NetflowschedulingNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetflowschedulingEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_flow_scheduling_edge_make(size : Int) -> NetflowschedulingEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_flow_scheduling_edge_len(s : NetflowschedulingEdge) -> Int { s.size }

pub fn net_flow_scheduling_edge_get(s : NetflowschedulingEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_flow_scheduling_edge_set(s : NetflowschedulingEdge, i : Int, v : Double) -> NetflowschedulingEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn net_flow_scheduling_edge_sum(s : NetflowschedulingEdge) -> Double { @_common.sum(s.data) }

pub fn net_flow_scheduling_edge_mean(s : NetflowschedulingEdge) -> Double { @_common.mean(s.data) }

pub fn net_flow_scheduling_edge_scale(s : NetflowschedulingEdge, f : Double) -> NetflowschedulingEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_flow_scheduling_edge_add(a : NetflowschedulingEdge, b : NetflowschedulingEdge) -> NetflowschedulingEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_flow_scheduling_edge_copy(s : NetflowschedulingEdge) -> NetflowschedulingEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_flow_scheduling_edge_fill(s : NetflowschedulingEdge, v : Double) -> NetflowschedulingEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_flow_scheduling_edge_min(s : NetflowschedulingEdge) -> Double { @_common.min(s.data) }

pub fn net_flow_scheduling_edge_max(s : NetflowschedulingEdge) -> Double { @_common.max(s.data) }

pub fn net_flow_scheduling_edge_to_string(s : NetflowschedulingEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetflowschedulingPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_flow_scheduling_path_make(size : Int) -> NetflowschedulingPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_flow_scheduling_path_len(s : NetflowschedulingPath) -> Int { s.size }

pub fn net_flow_scheduling_path_get(s : NetflowschedulingPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_flow_scheduling_path_set(s : NetflowschedulingPath, i : Int, v : Double) -> NetflowschedulingPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn net_flow_scheduling_path_sum(s : NetflowschedulingPath) -> Double { @_common.sum(s.data) }

pub fn net_flow_scheduling_path_mean(s : NetflowschedulingPath) -> Double { @_common.mean(s.data) }

pub fn net_flow_scheduling_path_scale(s : NetflowschedulingPath, f : Double) -> NetflowschedulingPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_flow_scheduling_path_add(a : NetflowschedulingPath, b : NetflowschedulingPath) -> NetflowschedulingPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_flow_scheduling_path_copy(s : NetflowschedulingPath) -> NetflowschedulingPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_flow_scheduling_path_fill(s : NetflowschedulingPath, v : Double) -> NetflowschedulingPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_flow_scheduling_path_min(s : NetflowschedulingPath) -> Double { @_common.min(s.data) }

pub fn net_flow_scheduling_path_max(s : NetflowschedulingPath) -> Double { @_common.max(s.data) }

pub fn net_flow_scheduling_path_to_string(s : NetflowschedulingPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetflowschedulingCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_flow_scheduling_cluster_make(size : Int) -> NetflowschedulingCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_flow_scheduling_cluster_len(s : NetflowschedulingCluster) -> Int { s.size }

pub fn net_flow_scheduling_cluster_get(s : NetflowschedulingCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_flow_scheduling_cluster_set(s : NetflowschedulingCluster, i : Int, v : Double) -> NetflowschedulingCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn net_flow_scheduling_cluster_sum(s : NetflowschedulingCluster) -> Double { @_common.sum(s.data) }

pub fn net_flow_scheduling_cluster_mean(s : NetflowschedulingCluster) -> Double { @_common.mean(s.data) }

pub fn net_flow_scheduling_cluster_scale(s : NetflowschedulingCluster, f : Double) -> NetflowschedulingCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_flow_scheduling_cluster_add(a : NetflowschedulingCluster, b : NetflowschedulingCluster) -> NetflowschedulingCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_flow_scheduling_cluster_copy(s : NetflowschedulingCluster) -> NetflowschedulingCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_flow_scheduling_cluster_fill(s : NetflowschedulingCluster, v : Double) -> NetflowschedulingCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_flow_scheduling_cluster_min(s : NetflowschedulingCluster) -> Double { @_common.min(s.data) }

pub fn net_flow_scheduling_cluster_max(s : NetflowschedulingCluster) -> Double { @_common.max(s.data) }

pub fn net_flow_scheduling_cluster_to_string(s : NetflowschedulingCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetflowschedulingModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_flow_scheduling_model_make(size : Int) -> NetflowschedulingModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_flow_scheduling_model_len(s : NetflowschedulingModel) -> Int { s.size }

pub fn net_flow_scheduling_model_get(s : NetflowschedulingModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_flow_scheduling_model_set(s : NetflowschedulingModel, i : Int, v : Double) -> NetflowschedulingModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn net_flow_scheduling_model_sum(s : NetflowschedulingModel) -> Double { @_common.sum(s.data) }

pub fn net_flow_scheduling_model_mean(s : NetflowschedulingModel) -> Double { @_common.mean(s.data) }

pub fn net_flow_scheduling_model_scale(s : NetflowschedulingModel, f : Double) -> NetflowschedulingModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_flow_scheduling_model_add(a : NetflowschedulingModel, b : NetflowschedulingModel) -> NetflowschedulingModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_flow_scheduling_model_copy(s : NetflowschedulingModel) -> NetflowschedulingModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_flow_scheduling_model_fill(s : NetflowschedulingModel, v : Double) -> NetflowschedulingModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_flow_scheduling_model_min(s : NetflowschedulingModel) -> Double { @_common.min(s.data) }

pub fn net_flow_scheduling_model_max(s : NetflowschedulingModel) -> Double { @_common.max(s.data) }

pub fn net_flow_scheduling_model_to_string(s : NetflowschedulingModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetflowschedulingLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_flow_scheduling_layer_make(size : Int) -> NetflowschedulingLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_flow_scheduling_layer_len(s : NetflowschedulingLayer) -> Int { s.size }

pub fn net_flow_scheduling_layer_get(s : NetflowschedulingLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_flow_scheduling_layer_set(s : NetflowschedulingLayer, i : Int, v : Double) -> NetflowschedulingLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn net_flow_scheduling_layer_sum(s : NetflowschedulingLayer) -> Double { @_common.sum(s.data) }

pub fn net_flow_scheduling_layer_mean(s : NetflowschedulingLayer) -> Double { @_common.mean(s.data) }

pub fn net_flow_scheduling_layer_scale(s : NetflowschedulingLayer, f : Double) -> NetflowschedulingLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_flow_scheduling_layer_add(a : NetflowschedulingLayer, b : NetflowschedulingLayer) -> NetflowschedulingLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_flow_scheduling_layer_copy(s : NetflowschedulingLayer) -> NetflowschedulingLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_flow_scheduling_layer_fill(s : NetflowschedulingLayer, v : Double) -> NetflowschedulingLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_flow_scheduling_layer_min(s : NetflowschedulingLayer) -> Double { @_common.min(s.data) }

pub fn net_flow_scheduling_layer_max(s : NetflowschedulingLayer) -> Double { @_common.max(s.data) }

pub fn net_flow_scheduling_layer_to_string(s : NetflowschedulingLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetflowschedulingBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_flow_scheduling_buffer_make(size : Int) -> NetflowschedulingBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_flow_scheduling_buffer_len(s : NetflowschedulingBuffer) -> Int { s.size }

pub fn net_flow_scheduling_buffer_get(s : NetflowschedulingBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_flow_scheduling_buffer_set(s : NetflowschedulingBuffer, i : Int, v : Double) -> NetflowschedulingBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn net_flow_scheduling_buffer_sum(s : NetflowschedulingBuffer) -> Double { @_common.sum(s.data) }

pub fn net_flow_scheduling_buffer_mean(s : NetflowschedulingBuffer) -> Double { @_common.mean(s.data) }

pub fn net_flow_scheduling_buffer_scale(s : NetflowschedulingBuffer, f : Double) -> NetflowschedulingBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_flow_scheduling_buffer_add(a : NetflowschedulingBuffer, b : NetflowschedulingBuffer) -> NetflowschedulingBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_flow_scheduling_buffer_copy(s : NetflowschedulingBuffer) -> NetflowschedulingBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_flow_scheduling_buffer_fill(s : NetflowschedulingBuffer, v : Double) -> NetflowschedulingBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_flow_scheduling_buffer_min(s : NetflowschedulingBuffer) -> Double { @_common.min(s.data) }

pub fn net_flow_scheduling_buffer_max(s : NetflowschedulingBuffer) -> Double { @_common.max(s.data) }

pub fn net_flow_scheduling_buffer_to_string(s : NetflowschedulingBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetflowschedulingCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_flow_scheduling_cursor_make(size : Int) -> NetflowschedulingCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_flow_scheduling_cursor_len(s : NetflowschedulingCursor) -> Int { s.size }

pub fn net_flow_scheduling_cursor_get(s : NetflowschedulingCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_flow_scheduling_cursor_set(s : NetflowschedulingCursor, i : Int, v : Double) -> NetflowschedulingCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn net_flow_scheduling_cursor_sum(s : NetflowschedulingCursor) -> Double { @_common.sum(s.data) }

pub fn net_flow_scheduling_cursor_mean(s : NetflowschedulingCursor) -> Double { @_common.mean(s.data) }

pub fn net_flow_scheduling_cursor_scale(s : NetflowschedulingCursor, f : Double) -> NetflowschedulingCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_flow_scheduling_cursor_add(a : NetflowschedulingCursor, b : NetflowschedulingCursor) -> NetflowschedulingCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_flow_scheduling_cursor_copy(s : NetflowschedulingCursor) -> NetflowschedulingCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_flow_scheduling_cursor_fill(s : NetflowschedulingCursor, v : Double) -> NetflowschedulingCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_flow_scheduling_cursor_min(s : NetflowschedulingCursor) -> Double { @_common.min(s.data) }

pub fn net_flow_scheduling_cursor_max(s : NetflowschedulingCursor) -> Double { @_common.max(s.data) }

pub fn net_flow_scheduling_cursor_to_string(s : NetflowschedulingCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetflowschedulingView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_flow_scheduling_view_make(size : Int) -> NetflowschedulingView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_flow_scheduling_view_len(s : NetflowschedulingView) -> Int { s.size }

pub fn net_flow_scheduling_view_get(s : NetflowschedulingView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_flow_scheduling_view_set(s : NetflowschedulingView, i : Int, v : Double) -> NetflowschedulingView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn net_flow_scheduling_view_sum(s : NetflowschedulingView) -> Double { @_common.sum(s.data) }

pub fn net_flow_scheduling_view_mean(s : NetflowschedulingView) -> Double { @_common.mean(s.data) }

pub fn net_flow_scheduling_view_scale(s : NetflowschedulingView, f : Double) -> NetflowschedulingView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_flow_scheduling_view_add(a : NetflowschedulingView, b : NetflowschedulingView) -> NetflowschedulingView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_flow_scheduling_view_copy(s : NetflowschedulingView) -> NetflowschedulingView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_flow_scheduling_view_fill(s : NetflowschedulingView, v : Double) -> NetflowschedulingView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_flow_scheduling_view_min(s : NetflowschedulingView) -> Double { @_common.min(s.data) }

pub fn net_flow_scheduling_view_max(s : NetflowschedulingView) -> Double { @_common.max(s.data) }

pub fn net_flow_scheduling_view_to_string(s : NetflowschedulingView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetflowschedulingRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_flow_scheduling_range_make(size : Int) -> NetflowschedulingRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_flow_scheduling_range_len(s : NetflowschedulingRange) -> Int { s.size }

pub fn net_flow_scheduling_range_get(s : NetflowschedulingRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_flow_scheduling_range_set(s : NetflowschedulingRange, i : Int, v : Double) -> NetflowschedulingRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn net_flow_scheduling_range_sum(s : NetflowschedulingRange) -> Double { @_common.sum(s.data) }

pub fn net_flow_scheduling_range_mean(s : NetflowschedulingRange) -> Double { @_common.mean(s.data) }

pub fn net_flow_scheduling_range_scale(s : NetflowschedulingRange, f : Double) -> NetflowschedulingRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_flow_scheduling_range_add(a : NetflowschedulingRange, b : NetflowschedulingRange) -> NetflowschedulingRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_flow_scheduling_range_copy(s : NetflowschedulingRange) -> NetflowschedulingRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_flow_scheduling_range_fill(s : NetflowschedulingRange, v : Double) -> NetflowschedulingRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_flow_scheduling_range_min(s : NetflowschedulingRange) -> Double { @_common.min(s.data) }

pub fn net_flow_scheduling_range_max(s : NetflowschedulingRange) -> Double { @_common.max(s.data) }

pub fn net_flow_scheduling_range_to_string(s : NetflowschedulingRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetflowschedulingSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_flow_scheduling_slice_make(size : Int) -> NetflowschedulingSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_flow_scheduling_slice_len(s : NetflowschedulingSlice) -> Int { s.size }

pub fn net_flow_scheduling_slice_get(s : NetflowschedulingSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_flow_scheduling_slice_set(s : NetflowschedulingSlice, i : Int, v : Double) -> NetflowschedulingSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn net_flow_scheduling_slice_sum(s : NetflowschedulingSlice) -> Double { @_common.sum(s.data) }

pub fn net_flow_scheduling_slice_mean(s : NetflowschedulingSlice) -> Double { @_common.mean(s.data) }

pub fn net_flow_scheduling_slice_scale(s : NetflowschedulingSlice, f : Double) -> NetflowschedulingSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_flow_scheduling_slice_add(a : NetflowschedulingSlice, b : NetflowschedulingSlice) -> NetflowschedulingSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_flow_scheduling_slice_copy(s : NetflowschedulingSlice) -> NetflowschedulingSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_flow_scheduling_slice_fill(s : NetflowschedulingSlice, v : Double) -> NetflowschedulingSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_flow_scheduling_slice_min(s : NetflowschedulingSlice) -> Double { @_common.min(s.data) }

pub fn net_flow_scheduling_slice_max(s : NetflowschedulingSlice) -> Double { @_common.max(s.data) }

pub fn net_flow_scheduling_slice_to_string(s : NetflowschedulingSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

