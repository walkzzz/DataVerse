///===
/// extcore/net_flow_shaping

pub(all) struct NetflowshapingPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn net_flow_shaping_make_point(x : Double, y : Double) -> NetflowshapingPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn net_flow_shaping_make_point3(x : Double, y : Double, z : Double) -> NetflowshapingPoint {
  { x, y, z, label: 0 }
}

pub fn NetflowshapingPoint::x(self : NetflowshapingPoint) -> Double { self.x }

pub fn NetflowshapingPoint::y(self : NetflowshapingPoint) -> Double { self.y }

pub fn NetflowshapingPoint::z(self : NetflowshapingPoint) -> Double { self.z }

pub fn NetflowshapingPoint::label(self : NetflowshapingPoint) -> Int { self.label }

pub fn NetflowshapingPoint::dist(self : NetflowshapingPoint, other : NetflowshapingPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn NetflowshapingPoint::add(self : NetflowshapingPoint, other : NetflowshapingPoint) -> NetflowshapingPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn NetflowshapingPoint::sub(self : NetflowshapingPoint, other : NetflowshapingPoint) -> NetflowshapingPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn NetflowshapingPoint::scale(self : NetflowshapingPoint, s : Double) -> NetflowshapingPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn NetflowshapingPoint::dot(self : NetflowshapingPoint, other : NetflowshapingPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn NetflowshapingPoint::cross(self : NetflowshapingPoint, other : NetflowshapingPoint) -> NetflowshapingPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn NetflowshapingPoint::norm(self : NetflowshapingPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn NetflowshapingPoint::normalize(self : NetflowshapingPoint) -> NetflowshapingPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn NetflowshapingPoint::negate(self : NetflowshapingPoint) -> NetflowshapingPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn NetflowshapingPoint::mid(self : NetflowshapingPoint, other : NetflowshapingPoint) -> NetflowshapingPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn NetflowshapingPoint::lerp(self : NetflowshapingPoint, other : NetflowshapingPoint, t : Double) -> NetflowshapingPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn NetflowshapingPoint::to_string(self : NetflowshapingPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct NetflowshapingSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn net_flow_shaping_make_series(vals : Array[Double], name : String) -> NetflowshapingSeries {
  { vals, name, meta: 0 }
}

pub fn NetflowshapingSeries::len(self : NetflowshapingSeries) -> Int { self.vals.length() }

pub fn NetflowshapingSeries::sum(self : NetflowshapingSeries) -> Double { @_common.sum(self.vals) }

pub fn NetflowshapingSeries::mean(self : NetflowshapingSeries) -> Double { @_common.mean(self.vals) }

pub fn NetflowshapingSeries::min(self : NetflowshapingSeries) -> Double { @_common.min(self.vals) }

pub fn NetflowshapingSeries::max(self : NetflowshapingSeries) -> Double { @_common.max(self.vals) }

pub fn NetflowshapingSeries::range(self : NetflowshapingSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn NetflowshapingSeries::variance(self : NetflowshapingSeries) -> Double { @_common.variance(self.vals) }

pub fn NetflowshapingSeries::std(self : NetflowshapingSeries) -> Double { @_common.std(self.vals) }

pub fn NetflowshapingSeries::median(self : NetflowshapingSeries) -> Double { @_common.median(self.vals) }

pub fn NetflowshapingSeries::scale(self : NetflowshapingSeries, f : Double) -> NetflowshapingSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn NetflowshapingSeries::add(self : NetflowshapingSeries, other : NetflowshapingSeries) -> NetflowshapingSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn NetflowshapingSeries::sub(self : NetflowshapingSeries, other : NetflowshapingSeries) -> NetflowshapingSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn NetflowshapingSeries::normalize(self : NetflowshapingSeries) -> NetflowshapingSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn NetflowshapingSeries::cumsum(self : NetflowshapingSeries) -> NetflowshapingSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn NetflowshapingSeries::to_string(self : NetflowshapingSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct NetflowshapingMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn net_flow_shaping_make_matrix(rows : Int, cols : Int, val : Double) -> NetflowshapingMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn net_flow_shaping_matrix_identity(n : Int) -> NetflowshapingMatrix {
  let m = net_flow_shaping_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn NetflowshapingMatrix::get(self : NetflowshapingMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn NetflowshapingMatrix::transpose(self : NetflowshapingMatrix) -> NetflowshapingMatrix {
  let result = net_flow_shaping_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn NetflowshapingMatrix::add(self : NetflowshapingMatrix, other : NetflowshapingMatrix) -> NetflowshapingMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = net_flow_shaping_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn NetflowshapingMatrix::scale(self : NetflowshapingMatrix, s : Double) -> NetflowshapingMatrix {
  let result = net_flow_shaping_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn NetflowshapingMatrix::multiply(self : NetflowshapingMatrix, other : NetflowshapingMatrix) -> NetflowshapingMatrix {
  if self.cols != other.rows { return net_flow_shaping_make_matrix(self.rows, other.cols, 0.0) }
  let result = net_flow_shaping_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn NetflowshapingMatrix::trace(self : NetflowshapingMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn NetflowshapingMatrix::det(self : NetflowshapingMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn NetflowshapingMatrix::norm(self : NetflowshapingMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn NetflowshapingMatrix::to_string(self : NetflowshapingMatrix) -> String {
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

pub(all) struct NetflowshapingVector {
  comps : Array[Double]
  dim : Int
}

pub fn net_flow_shaping_make_vector(comps : Array[Double]) -> NetflowshapingVector {
  { comps, dim: comps.length() }
}

pub fn net_flow_shaping_vector_zero(dim : Int) -> NetflowshapingVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn NetflowshapingVector::add(self : NetflowshapingVector, other : NetflowshapingVector) -> NetflowshapingVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn NetflowshapingVector::sub(self : NetflowshapingVector, other : NetflowshapingVector) -> NetflowshapingVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn NetflowshapingVector::scale(self : NetflowshapingVector, s : Double) -> NetflowshapingVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn NetflowshapingVector::dot(self : NetflowshapingVector, other : NetflowshapingVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn NetflowshapingVector::norm(self : NetflowshapingVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn NetflowshapingVector::normalize(self : NetflowshapingVector) -> NetflowshapingVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn NetflowshapingVector::dist(self : NetflowshapingVector, other : NetflowshapingVector) -> Double {
  self.sub(other).norm()
}

pub fn NetflowshapingVector::to_string(self : NetflowshapingVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn net_flow_shaping_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn net_flow_shaping_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn net_flow_shaping_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn net_flow_shaping_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn net_flow_shaping_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn net_flow_shaping_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn net_flow_shaping_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn net_flow_shaping_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn net_flow_shaping_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn net_flow_shaping_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn net_flow_shaping_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn net_flow_shaping_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn net_flow_shaping_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn net_flow_shaping_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn net_flow_shaping_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn net_flow_shaping_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn net_flow_shaping_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn net_flow_shaping_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn net_flow_shaping_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn net_flow_shaping_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn net_flow_shaping_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn net_flow_shaping_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn net_flow_shaping_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn net_flow_shaping_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn net_flow_shaping_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn net_flow_shaping_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn net_flow_shaping_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn net_flow_shaping_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn net_flow_shaping_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct NetflowshapingFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_flow_shaping_frame_make(size : Int) -> NetflowshapingFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_flow_shaping_frame_len(s : NetflowshapingFrame) -> Int { s.size }

pub fn net_flow_shaping_frame_get(s : NetflowshapingFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_flow_shaping_frame_set(s : NetflowshapingFrame, i : Int, v : Double) -> NetflowshapingFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn net_flow_shaping_frame_sum(s : NetflowshapingFrame) -> Double { @_common.sum(s.data) }

pub fn net_flow_shaping_frame_mean(s : NetflowshapingFrame) -> Double { @_common.mean(s.data) }

pub fn net_flow_shaping_frame_scale(s : NetflowshapingFrame, f : Double) -> NetflowshapingFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_flow_shaping_frame_add(a : NetflowshapingFrame, b : NetflowshapingFrame) -> NetflowshapingFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_flow_shaping_frame_copy(s : NetflowshapingFrame) -> NetflowshapingFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_flow_shaping_frame_fill(s : NetflowshapingFrame, v : Double) -> NetflowshapingFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_flow_shaping_frame_min(s : NetflowshapingFrame) -> Double { @_common.min(s.data) }

pub fn net_flow_shaping_frame_max(s : NetflowshapingFrame) -> Double { @_common.max(s.data) }

pub fn net_flow_shaping_frame_to_string(s : NetflowshapingFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetflowshapingTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_flow_shaping_table_make(size : Int) -> NetflowshapingTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_flow_shaping_table_len(s : NetflowshapingTable) -> Int { s.size }

pub fn net_flow_shaping_table_get(s : NetflowshapingTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_flow_shaping_table_set(s : NetflowshapingTable, i : Int, v : Double) -> NetflowshapingTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn net_flow_shaping_table_sum(s : NetflowshapingTable) -> Double { @_common.sum(s.data) }

pub fn net_flow_shaping_table_mean(s : NetflowshapingTable) -> Double { @_common.mean(s.data) }

pub fn net_flow_shaping_table_scale(s : NetflowshapingTable, f : Double) -> NetflowshapingTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_flow_shaping_table_add(a : NetflowshapingTable, b : NetflowshapingTable) -> NetflowshapingTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_flow_shaping_table_copy(s : NetflowshapingTable) -> NetflowshapingTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_flow_shaping_table_fill(s : NetflowshapingTable, v : Double) -> NetflowshapingTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_flow_shaping_table_min(s : NetflowshapingTable) -> Double { @_common.min(s.data) }

pub fn net_flow_shaping_table_max(s : NetflowshapingTable) -> Double { @_common.max(s.data) }

pub fn net_flow_shaping_table_to_string(s : NetflowshapingTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetflowshapingGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_flow_shaping_graphn_make(size : Int) -> NetflowshapingGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_flow_shaping_graphn_len(s : NetflowshapingGraphN) -> Int { s.size }

pub fn net_flow_shaping_graphn_get(s : NetflowshapingGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_flow_shaping_graphn_set(s : NetflowshapingGraphN, i : Int, v : Double) -> NetflowshapingGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn net_flow_shaping_graphn_sum(s : NetflowshapingGraphN) -> Double { @_common.sum(s.data) }

pub fn net_flow_shaping_graphn_mean(s : NetflowshapingGraphN) -> Double { @_common.mean(s.data) }

pub fn net_flow_shaping_graphn_scale(s : NetflowshapingGraphN, f : Double) -> NetflowshapingGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_flow_shaping_graphn_add(a : NetflowshapingGraphN, b : NetflowshapingGraphN) -> NetflowshapingGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_flow_shaping_graphn_copy(s : NetflowshapingGraphN) -> NetflowshapingGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_flow_shaping_graphn_fill(s : NetflowshapingGraphN, v : Double) -> NetflowshapingGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_flow_shaping_graphn_min(s : NetflowshapingGraphN) -> Double { @_common.min(s.data) }

pub fn net_flow_shaping_graphn_max(s : NetflowshapingGraphN) -> Double { @_common.max(s.data) }

pub fn net_flow_shaping_graphn_to_string(s : NetflowshapingGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetflowshapingNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_flow_shaping_node_make(size : Int) -> NetflowshapingNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_flow_shaping_node_len(s : NetflowshapingNode) -> Int { s.size }

pub fn net_flow_shaping_node_get(s : NetflowshapingNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_flow_shaping_node_set(s : NetflowshapingNode, i : Int, v : Double) -> NetflowshapingNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn net_flow_shaping_node_sum(s : NetflowshapingNode) -> Double { @_common.sum(s.data) }

pub fn net_flow_shaping_node_mean(s : NetflowshapingNode) -> Double { @_common.mean(s.data) }

pub fn net_flow_shaping_node_scale(s : NetflowshapingNode, f : Double) -> NetflowshapingNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_flow_shaping_node_add(a : NetflowshapingNode, b : NetflowshapingNode) -> NetflowshapingNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_flow_shaping_node_copy(s : NetflowshapingNode) -> NetflowshapingNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_flow_shaping_node_fill(s : NetflowshapingNode, v : Double) -> NetflowshapingNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_flow_shaping_node_min(s : NetflowshapingNode) -> Double { @_common.min(s.data) }

pub fn net_flow_shaping_node_max(s : NetflowshapingNode) -> Double { @_common.max(s.data) }

pub fn net_flow_shaping_node_to_string(s : NetflowshapingNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetflowshapingEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_flow_shaping_edge_make(size : Int) -> NetflowshapingEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_flow_shaping_edge_len(s : NetflowshapingEdge) -> Int { s.size }

pub fn net_flow_shaping_edge_get(s : NetflowshapingEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_flow_shaping_edge_set(s : NetflowshapingEdge, i : Int, v : Double) -> NetflowshapingEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn net_flow_shaping_edge_sum(s : NetflowshapingEdge) -> Double { @_common.sum(s.data) }

pub fn net_flow_shaping_edge_mean(s : NetflowshapingEdge) -> Double { @_common.mean(s.data) }

pub fn net_flow_shaping_edge_scale(s : NetflowshapingEdge, f : Double) -> NetflowshapingEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_flow_shaping_edge_add(a : NetflowshapingEdge, b : NetflowshapingEdge) -> NetflowshapingEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_flow_shaping_edge_copy(s : NetflowshapingEdge) -> NetflowshapingEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_flow_shaping_edge_fill(s : NetflowshapingEdge, v : Double) -> NetflowshapingEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_flow_shaping_edge_min(s : NetflowshapingEdge) -> Double { @_common.min(s.data) }

pub fn net_flow_shaping_edge_max(s : NetflowshapingEdge) -> Double { @_common.max(s.data) }

pub fn net_flow_shaping_edge_to_string(s : NetflowshapingEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetflowshapingPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_flow_shaping_path_make(size : Int) -> NetflowshapingPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_flow_shaping_path_len(s : NetflowshapingPath) -> Int { s.size }

pub fn net_flow_shaping_path_get(s : NetflowshapingPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_flow_shaping_path_set(s : NetflowshapingPath, i : Int, v : Double) -> NetflowshapingPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn net_flow_shaping_path_sum(s : NetflowshapingPath) -> Double { @_common.sum(s.data) }

pub fn net_flow_shaping_path_mean(s : NetflowshapingPath) -> Double { @_common.mean(s.data) }

pub fn net_flow_shaping_path_scale(s : NetflowshapingPath, f : Double) -> NetflowshapingPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_flow_shaping_path_add(a : NetflowshapingPath, b : NetflowshapingPath) -> NetflowshapingPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_flow_shaping_path_copy(s : NetflowshapingPath) -> NetflowshapingPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_flow_shaping_path_fill(s : NetflowshapingPath, v : Double) -> NetflowshapingPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_flow_shaping_path_min(s : NetflowshapingPath) -> Double { @_common.min(s.data) }

pub fn net_flow_shaping_path_max(s : NetflowshapingPath) -> Double { @_common.max(s.data) }

pub fn net_flow_shaping_path_to_string(s : NetflowshapingPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetflowshapingCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_flow_shaping_cluster_make(size : Int) -> NetflowshapingCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_flow_shaping_cluster_len(s : NetflowshapingCluster) -> Int { s.size }

pub fn net_flow_shaping_cluster_get(s : NetflowshapingCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_flow_shaping_cluster_set(s : NetflowshapingCluster, i : Int, v : Double) -> NetflowshapingCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn net_flow_shaping_cluster_sum(s : NetflowshapingCluster) -> Double { @_common.sum(s.data) }

pub fn net_flow_shaping_cluster_mean(s : NetflowshapingCluster) -> Double { @_common.mean(s.data) }

pub fn net_flow_shaping_cluster_scale(s : NetflowshapingCluster, f : Double) -> NetflowshapingCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_flow_shaping_cluster_add(a : NetflowshapingCluster, b : NetflowshapingCluster) -> NetflowshapingCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_flow_shaping_cluster_copy(s : NetflowshapingCluster) -> NetflowshapingCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_flow_shaping_cluster_fill(s : NetflowshapingCluster, v : Double) -> NetflowshapingCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_flow_shaping_cluster_min(s : NetflowshapingCluster) -> Double { @_common.min(s.data) }

pub fn net_flow_shaping_cluster_max(s : NetflowshapingCluster) -> Double { @_common.max(s.data) }

pub fn net_flow_shaping_cluster_to_string(s : NetflowshapingCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetflowshapingModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_flow_shaping_model_make(size : Int) -> NetflowshapingModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_flow_shaping_model_len(s : NetflowshapingModel) -> Int { s.size }

pub fn net_flow_shaping_model_get(s : NetflowshapingModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_flow_shaping_model_set(s : NetflowshapingModel, i : Int, v : Double) -> NetflowshapingModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn net_flow_shaping_model_sum(s : NetflowshapingModel) -> Double { @_common.sum(s.data) }

pub fn net_flow_shaping_model_mean(s : NetflowshapingModel) -> Double { @_common.mean(s.data) }

pub fn net_flow_shaping_model_scale(s : NetflowshapingModel, f : Double) -> NetflowshapingModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_flow_shaping_model_add(a : NetflowshapingModel, b : NetflowshapingModel) -> NetflowshapingModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_flow_shaping_model_copy(s : NetflowshapingModel) -> NetflowshapingModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_flow_shaping_model_fill(s : NetflowshapingModel, v : Double) -> NetflowshapingModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_flow_shaping_model_min(s : NetflowshapingModel) -> Double { @_common.min(s.data) }

pub fn net_flow_shaping_model_max(s : NetflowshapingModel) -> Double { @_common.max(s.data) }

pub fn net_flow_shaping_model_to_string(s : NetflowshapingModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetflowshapingLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_flow_shaping_layer_make(size : Int) -> NetflowshapingLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_flow_shaping_layer_len(s : NetflowshapingLayer) -> Int { s.size }

pub fn net_flow_shaping_layer_get(s : NetflowshapingLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_flow_shaping_layer_set(s : NetflowshapingLayer, i : Int, v : Double) -> NetflowshapingLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn net_flow_shaping_layer_sum(s : NetflowshapingLayer) -> Double { @_common.sum(s.data) }

pub fn net_flow_shaping_layer_mean(s : NetflowshapingLayer) -> Double { @_common.mean(s.data) }

pub fn net_flow_shaping_layer_scale(s : NetflowshapingLayer, f : Double) -> NetflowshapingLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_flow_shaping_layer_add(a : NetflowshapingLayer, b : NetflowshapingLayer) -> NetflowshapingLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_flow_shaping_layer_copy(s : NetflowshapingLayer) -> NetflowshapingLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_flow_shaping_layer_fill(s : NetflowshapingLayer, v : Double) -> NetflowshapingLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_flow_shaping_layer_min(s : NetflowshapingLayer) -> Double { @_common.min(s.data) }

pub fn net_flow_shaping_layer_max(s : NetflowshapingLayer) -> Double { @_common.max(s.data) }

pub fn net_flow_shaping_layer_to_string(s : NetflowshapingLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetflowshapingBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_flow_shaping_buffer_make(size : Int) -> NetflowshapingBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_flow_shaping_buffer_len(s : NetflowshapingBuffer) -> Int { s.size }

pub fn net_flow_shaping_buffer_get(s : NetflowshapingBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_flow_shaping_buffer_set(s : NetflowshapingBuffer, i : Int, v : Double) -> NetflowshapingBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn net_flow_shaping_buffer_sum(s : NetflowshapingBuffer) -> Double { @_common.sum(s.data) }

pub fn net_flow_shaping_buffer_mean(s : NetflowshapingBuffer) -> Double { @_common.mean(s.data) }

pub fn net_flow_shaping_buffer_scale(s : NetflowshapingBuffer, f : Double) -> NetflowshapingBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_flow_shaping_buffer_add(a : NetflowshapingBuffer, b : NetflowshapingBuffer) -> NetflowshapingBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_flow_shaping_buffer_copy(s : NetflowshapingBuffer) -> NetflowshapingBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_flow_shaping_buffer_fill(s : NetflowshapingBuffer, v : Double) -> NetflowshapingBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_flow_shaping_buffer_min(s : NetflowshapingBuffer) -> Double { @_common.min(s.data) }

pub fn net_flow_shaping_buffer_max(s : NetflowshapingBuffer) -> Double { @_common.max(s.data) }

pub fn net_flow_shaping_buffer_to_string(s : NetflowshapingBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetflowshapingCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_flow_shaping_cursor_make(size : Int) -> NetflowshapingCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_flow_shaping_cursor_len(s : NetflowshapingCursor) -> Int { s.size }

pub fn net_flow_shaping_cursor_get(s : NetflowshapingCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_flow_shaping_cursor_set(s : NetflowshapingCursor, i : Int, v : Double) -> NetflowshapingCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn net_flow_shaping_cursor_sum(s : NetflowshapingCursor) -> Double { @_common.sum(s.data) }

pub fn net_flow_shaping_cursor_mean(s : NetflowshapingCursor) -> Double { @_common.mean(s.data) }

pub fn net_flow_shaping_cursor_scale(s : NetflowshapingCursor, f : Double) -> NetflowshapingCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_flow_shaping_cursor_add(a : NetflowshapingCursor, b : NetflowshapingCursor) -> NetflowshapingCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_flow_shaping_cursor_copy(s : NetflowshapingCursor) -> NetflowshapingCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_flow_shaping_cursor_fill(s : NetflowshapingCursor, v : Double) -> NetflowshapingCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_flow_shaping_cursor_min(s : NetflowshapingCursor) -> Double { @_common.min(s.data) }

pub fn net_flow_shaping_cursor_max(s : NetflowshapingCursor) -> Double { @_common.max(s.data) }

pub fn net_flow_shaping_cursor_to_string(s : NetflowshapingCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetflowshapingView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_flow_shaping_view_make(size : Int) -> NetflowshapingView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_flow_shaping_view_len(s : NetflowshapingView) -> Int { s.size }

pub fn net_flow_shaping_view_get(s : NetflowshapingView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_flow_shaping_view_set(s : NetflowshapingView, i : Int, v : Double) -> NetflowshapingView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn net_flow_shaping_view_sum(s : NetflowshapingView) -> Double { @_common.sum(s.data) }

pub fn net_flow_shaping_view_mean(s : NetflowshapingView) -> Double { @_common.mean(s.data) }

pub fn net_flow_shaping_view_scale(s : NetflowshapingView, f : Double) -> NetflowshapingView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_flow_shaping_view_add(a : NetflowshapingView, b : NetflowshapingView) -> NetflowshapingView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_flow_shaping_view_copy(s : NetflowshapingView) -> NetflowshapingView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_flow_shaping_view_fill(s : NetflowshapingView, v : Double) -> NetflowshapingView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_flow_shaping_view_min(s : NetflowshapingView) -> Double { @_common.min(s.data) }

pub fn net_flow_shaping_view_max(s : NetflowshapingView) -> Double { @_common.max(s.data) }

pub fn net_flow_shaping_view_to_string(s : NetflowshapingView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetflowshapingRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_flow_shaping_range_make(size : Int) -> NetflowshapingRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_flow_shaping_range_len(s : NetflowshapingRange) -> Int { s.size }

pub fn net_flow_shaping_range_get(s : NetflowshapingRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_flow_shaping_range_set(s : NetflowshapingRange, i : Int, v : Double) -> NetflowshapingRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn net_flow_shaping_range_sum(s : NetflowshapingRange) -> Double { @_common.sum(s.data) }

pub fn net_flow_shaping_range_mean(s : NetflowshapingRange) -> Double { @_common.mean(s.data) }

pub fn net_flow_shaping_range_scale(s : NetflowshapingRange, f : Double) -> NetflowshapingRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_flow_shaping_range_add(a : NetflowshapingRange, b : NetflowshapingRange) -> NetflowshapingRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_flow_shaping_range_copy(s : NetflowshapingRange) -> NetflowshapingRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_flow_shaping_range_fill(s : NetflowshapingRange, v : Double) -> NetflowshapingRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_flow_shaping_range_min(s : NetflowshapingRange) -> Double { @_common.min(s.data) }

pub fn net_flow_shaping_range_max(s : NetflowshapingRange) -> Double { @_common.max(s.data) }

pub fn net_flow_shaping_range_to_string(s : NetflowshapingRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetflowshapingSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_flow_shaping_slice_make(size : Int) -> NetflowshapingSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_flow_shaping_slice_len(s : NetflowshapingSlice) -> Int { s.size }

pub fn net_flow_shaping_slice_get(s : NetflowshapingSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_flow_shaping_slice_set(s : NetflowshapingSlice, i : Int, v : Double) -> NetflowshapingSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn net_flow_shaping_slice_sum(s : NetflowshapingSlice) -> Double { @_common.sum(s.data) }

pub fn net_flow_shaping_slice_mean(s : NetflowshapingSlice) -> Double { @_common.mean(s.data) }

pub fn net_flow_shaping_slice_scale(s : NetflowshapingSlice, f : Double) -> NetflowshapingSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_flow_shaping_slice_add(a : NetflowshapingSlice, b : NetflowshapingSlice) -> NetflowshapingSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_flow_shaping_slice_copy(s : NetflowshapingSlice) -> NetflowshapingSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_flow_shaping_slice_fill(s : NetflowshapingSlice, v : Double) -> NetflowshapingSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_flow_shaping_slice_min(s : NetflowshapingSlice) -> Double { @_common.min(s.data) }

pub fn net_flow_shaping_slice_max(s : NetflowshapingSlice) -> Double { @_common.max(s.data) }

pub fn net_flow_shaping_slice_to_string(s : NetflowshapingSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

