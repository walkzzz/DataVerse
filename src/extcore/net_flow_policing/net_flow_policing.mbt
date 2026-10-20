///===
/// extcore/net_flow_policing

pub(all) struct NetflowpolicingPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn net_flow_policing_make_point(x : Double, y : Double) -> NetflowpolicingPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn net_flow_policing_make_point3(x : Double, y : Double, z : Double) -> NetflowpolicingPoint {
  { x, y, z, label: 0 }
}

pub fn NetflowpolicingPoint::x(self : NetflowpolicingPoint) -> Double { self.x }

pub fn NetflowpolicingPoint::y(self : NetflowpolicingPoint) -> Double { self.y }

pub fn NetflowpolicingPoint::z(self : NetflowpolicingPoint) -> Double { self.z }

pub fn NetflowpolicingPoint::label(self : NetflowpolicingPoint) -> Int { self.label }

pub fn NetflowpolicingPoint::dist(self : NetflowpolicingPoint, other : NetflowpolicingPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn NetflowpolicingPoint::add(self : NetflowpolicingPoint, other : NetflowpolicingPoint) -> NetflowpolicingPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn NetflowpolicingPoint::sub(self : NetflowpolicingPoint, other : NetflowpolicingPoint) -> NetflowpolicingPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn NetflowpolicingPoint::scale(self : NetflowpolicingPoint, s : Double) -> NetflowpolicingPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn NetflowpolicingPoint::dot(self : NetflowpolicingPoint, other : NetflowpolicingPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn NetflowpolicingPoint::cross(self : NetflowpolicingPoint, other : NetflowpolicingPoint) -> NetflowpolicingPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn NetflowpolicingPoint::norm(self : NetflowpolicingPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn NetflowpolicingPoint::normalize(self : NetflowpolicingPoint) -> NetflowpolicingPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn NetflowpolicingPoint::negate(self : NetflowpolicingPoint) -> NetflowpolicingPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn NetflowpolicingPoint::mid(self : NetflowpolicingPoint, other : NetflowpolicingPoint) -> NetflowpolicingPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn NetflowpolicingPoint::lerp(self : NetflowpolicingPoint, other : NetflowpolicingPoint, t : Double) -> NetflowpolicingPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn NetflowpolicingPoint::to_string(self : NetflowpolicingPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct NetflowpolicingSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn net_flow_policing_make_series(vals : Array[Double], name : String) -> NetflowpolicingSeries {
  { vals, name, meta: 0 }
}

pub fn NetflowpolicingSeries::len(self : NetflowpolicingSeries) -> Int { self.vals.length() }

pub fn NetflowpolicingSeries::sum(self : NetflowpolicingSeries) -> Double { @_common.sum(self.vals) }

pub fn NetflowpolicingSeries::mean(self : NetflowpolicingSeries) -> Double { @_common.mean(self.vals) }

pub fn NetflowpolicingSeries::min(self : NetflowpolicingSeries) -> Double { @_common.min(self.vals) }

pub fn NetflowpolicingSeries::max(self : NetflowpolicingSeries) -> Double { @_common.max(self.vals) }

pub fn NetflowpolicingSeries::range(self : NetflowpolicingSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn NetflowpolicingSeries::variance(self : NetflowpolicingSeries) -> Double { @_common.variance(self.vals) }

pub fn NetflowpolicingSeries::std(self : NetflowpolicingSeries) -> Double { @_common.std(self.vals) }

pub fn NetflowpolicingSeries::median(self : NetflowpolicingSeries) -> Double { @_common.median(self.vals) }

pub fn NetflowpolicingSeries::scale(self : NetflowpolicingSeries, f : Double) -> NetflowpolicingSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn NetflowpolicingSeries::add(self : NetflowpolicingSeries, other : NetflowpolicingSeries) -> NetflowpolicingSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn NetflowpolicingSeries::sub(self : NetflowpolicingSeries, other : NetflowpolicingSeries) -> NetflowpolicingSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn NetflowpolicingSeries::normalize(self : NetflowpolicingSeries) -> NetflowpolicingSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn NetflowpolicingSeries::cumsum(self : NetflowpolicingSeries) -> NetflowpolicingSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn NetflowpolicingSeries::to_string(self : NetflowpolicingSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct NetflowpolicingMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn net_flow_policing_make_matrix(rows : Int, cols : Int, val : Double) -> NetflowpolicingMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn net_flow_policing_matrix_identity(n : Int) -> NetflowpolicingMatrix {
  let m = net_flow_policing_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn NetflowpolicingMatrix::get(self : NetflowpolicingMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn NetflowpolicingMatrix::transpose(self : NetflowpolicingMatrix) -> NetflowpolicingMatrix {
  let result = net_flow_policing_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn NetflowpolicingMatrix::add(self : NetflowpolicingMatrix, other : NetflowpolicingMatrix) -> NetflowpolicingMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = net_flow_policing_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn NetflowpolicingMatrix::scale(self : NetflowpolicingMatrix, s : Double) -> NetflowpolicingMatrix {
  let result = net_flow_policing_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn NetflowpolicingMatrix::multiply(self : NetflowpolicingMatrix, other : NetflowpolicingMatrix) -> NetflowpolicingMatrix {
  if self.cols != other.rows { return net_flow_policing_make_matrix(self.rows, other.cols, 0.0) }
  let result = net_flow_policing_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn NetflowpolicingMatrix::trace(self : NetflowpolicingMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn NetflowpolicingMatrix::det(self : NetflowpolicingMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn NetflowpolicingMatrix::norm(self : NetflowpolicingMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn NetflowpolicingMatrix::to_string(self : NetflowpolicingMatrix) -> String {
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

pub(all) struct NetflowpolicingVector {
  comps : Array[Double]
  dim : Int
}

pub fn net_flow_policing_make_vector(comps : Array[Double]) -> NetflowpolicingVector {
  { comps, dim: comps.length() }
}

pub fn net_flow_policing_vector_zero(dim : Int) -> NetflowpolicingVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn NetflowpolicingVector::add(self : NetflowpolicingVector, other : NetflowpolicingVector) -> NetflowpolicingVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn NetflowpolicingVector::sub(self : NetflowpolicingVector, other : NetflowpolicingVector) -> NetflowpolicingVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn NetflowpolicingVector::scale(self : NetflowpolicingVector, s : Double) -> NetflowpolicingVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn NetflowpolicingVector::dot(self : NetflowpolicingVector, other : NetflowpolicingVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn NetflowpolicingVector::norm(self : NetflowpolicingVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn NetflowpolicingVector::normalize(self : NetflowpolicingVector) -> NetflowpolicingVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn NetflowpolicingVector::dist(self : NetflowpolicingVector, other : NetflowpolicingVector) -> Double {
  self.sub(other).norm()
}

pub fn NetflowpolicingVector::to_string(self : NetflowpolicingVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn net_flow_policing_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn net_flow_policing_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn net_flow_policing_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn net_flow_policing_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn net_flow_policing_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn net_flow_policing_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn net_flow_policing_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn net_flow_policing_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn net_flow_policing_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn net_flow_policing_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn net_flow_policing_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn net_flow_policing_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn net_flow_policing_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn net_flow_policing_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn net_flow_policing_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn net_flow_policing_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn net_flow_policing_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn net_flow_policing_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn net_flow_policing_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn net_flow_policing_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn net_flow_policing_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn net_flow_policing_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn net_flow_policing_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn net_flow_policing_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn net_flow_policing_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn net_flow_policing_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn net_flow_policing_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn net_flow_policing_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn net_flow_policing_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct NetflowpolicingFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_flow_policing_frame_make(size : Int) -> NetflowpolicingFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_flow_policing_frame_len(s : NetflowpolicingFrame) -> Int { s.size }

pub fn net_flow_policing_frame_get(s : NetflowpolicingFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_flow_policing_frame_set(s : NetflowpolicingFrame, i : Int, v : Double) -> NetflowpolicingFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn net_flow_policing_frame_sum(s : NetflowpolicingFrame) -> Double { @_common.sum(s.data) }

pub fn net_flow_policing_frame_mean(s : NetflowpolicingFrame) -> Double { @_common.mean(s.data) }

pub fn net_flow_policing_frame_scale(s : NetflowpolicingFrame, f : Double) -> NetflowpolicingFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_flow_policing_frame_add(a : NetflowpolicingFrame, b : NetflowpolicingFrame) -> NetflowpolicingFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_flow_policing_frame_copy(s : NetflowpolicingFrame) -> NetflowpolicingFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_flow_policing_frame_fill(s : NetflowpolicingFrame, v : Double) -> NetflowpolicingFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_flow_policing_frame_min(s : NetflowpolicingFrame) -> Double { @_common.min(s.data) }

pub fn net_flow_policing_frame_max(s : NetflowpolicingFrame) -> Double { @_common.max(s.data) }

pub fn net_flow_policing_frame_to_string(s : NetflowpolicingFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetflowpolicingTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_flow_policing_table_make(size : Int) -> NetflowpolicingTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_flow_policing_table_len(s : NetflowpolicingTable) -> Int { s.size }

pub fn net_flow_policing_table_get(s : NetflowpolicingTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_flow_policing_table_set(s : NetflowpolicingTable, i : Int, v : Double) -> NetflowpolicingTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn net_flow_policing_table_sum(s : NetflowpolicingTable) -> Double { @_common.sum(s.data) }

pub fn net_flow_policing_table_mean(s : NetflowpolicingTable) -> Double { @_common.mean(s.data) }

pub fn net_flow_policing_table_scale(s : NetflowpolicingTable, f : Double) -> NetflowpolicingTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_flow_policing_table_add(a : NetflowpolicingTable, b : NetflowpolicingTable) -> NetflowpolicingTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_flow_policing_table_copy(s : NetflowpolicingTable) -> NetflowpolicingTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_flow_policing_table_fill(s : NetflowpolicingTable, v : Double) -> NetflowpolicingTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_flow_policing_table_min(s : NetflowpolicingTable) -> Double { @_common.min(s.data) }

pub fn net_flow_policing_table_max(s : NetflowpolicingTable) -> Double { @_common.max(s.data) }

pub fn net_flow_policing_table_to_string(s : NetflowpolicingTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetflowpolicingGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_flow_policing_graphn_make(size : Int) -> NetflowpolicingGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_flow_policing_graphn_len(s : NetflowpolicingGraphN) -> Int { s.size }

pub fn net_flow_policing_graphn_get(s : NetflowpolicingGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_flow_policing_graphn_set(s : NetflowpolicingGraphN, i : Int, v : Double) -> NetflowpolicingGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn net_flow_policing_graphn_sum(s : NetflowpolicingGraphN) -> Double { @_common.sum(s.data) }

pub fn net_flow_policing_graphn_mean(s : NetflowpolicingGraphN) -> Double { @_common.mean(s.data) }

pub fn net_flow_policing_graphn_scale(s : NetflowpolicingGraphN, f : Double) -> NetflowpolicingGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_flow_policing_graphn_add(a : NetflowpolicingGraphN, b : NetflowpolicingGraphN) -> NetflowpolicingGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_flow_policing_graphn_copy(s : NetflowpolicingGraphN) -> NetflowpolicingGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_flow_policing_graphn_fill(s : NetflowpolicingGraphN, v : Double) -> NetflowpolicingGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_flow_policing_graphn_min(s : NetflowpolicingGraphN) -> Double { @_common.min(s.data) }

pub fn net_flow_policing_graphn_max(s : NetflowpolicingGraphN) -> Double { @_common.max(s.data) }

pub fn net_flow_policing_graphn_to_string(s : NetflowpolicingGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetflowpolicingNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_flow_policing_node_make(size : Int) -> NetflowpolicingNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_flow_policing_node_len(s : NetflowpolicingNode) -> Int { s.size }

pub fn net_flow_policing_node_get(s : NetflowpolicingNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_flow_policing_node_set(s : NetflowpolicingNode, i : Int, v : Double) -> NetflowpolicingNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn net_flow_policing_node_sum(s : NetflowpolicingNode) -> Double { @_common.sum(s.data) }

pub fn net_flow_policing_node_mean(s : NetflowpolicingNode) -> Double { @_common.mean(s.data) }

pub fn net_flow_policing_node_scale(s : NetflowpolicingNode, f : Double) -> NetflowpolicingNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_flow_policing_node_add(a : NetflowpolicingNode, b : NetflowpolicingNode) -> NetflowpolicingNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_flow_policing_node_copy(s : NetflowpolicingNode) -> NetflowpolicingNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_flow_policing_node_fill(s : NetflowpolicingNode, v : Double) -> NetflowpolicingNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_flow_policing_node_min(s : NetflowpolicingNode) -> Double { @_common.min(s.data) }

pub fn net_flow_policing_node_max(s : NetflowpolicingNode) -> Double { @_common.max(s.data) }

pub fn net_flow_policing_node_to_string(s : NetflowpolicingNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetflowpolicingEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_flow_policing_edge_make(size : Int) -> NetflowpolicingEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_flow_policing_edge_len(s : NetflowpolicingEdge) -> Int { s.size }

pub fn net_flow_policing_edge_get(s : NetflowpolicingEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_flow_policing_edge_set(s : NetflowpolicingEdge, i : Int, v : Double) -> NetflowpolicingEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn net_flow_policing_edge_sum(s : NetflowpolicingEdge) -> Double { @_common.sum(s.data) }

pub fn net_flow_policing_edge_mean(s : NetflowpolicingEdge) -> Double { @_common.mean(s.data) }

pub fn net_flow_policing_edge_scale(s : NetflowpolicingEdge, f : Double) -> NetflowpolicingEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_flow_policing_edge_add(a : NetflowpolicingEdge, b : NetflowpolicingEdge) -> NetflowpolicingEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_flow_policing_edge_copy(s : NetflowpolicingEdge) -> NetflowpolicingEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_flow_policing_edge_fill(s : NetflowpolicingEdge, v : Double) -> NetflowpolicingEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_flow_policing_edge_min(s : NetflowpolicingEdge) -> Double { @_common.min(s.data) }

pub fn net_flow_policing_edge_max(s : NetflowpolicingEdge) -> Double { @_common.max(s.data) }

pub fn net_flow_policing_edge_to_string(s : NetflowpolicingEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetflowpolicingPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_flow_policing_path_make(size : Int) -> NetflowpolicingPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_flow_policing_path_len(s : NetflowpolicingPath) -> Int { s.size }

pub fn net_flow_policing_path_get(s : NetflowpolicingPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_flow_policing_path_set(s : NetflowpolicingPath, i : Int, v : Double) -> NetflowpolicingPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn net_flow_policing_path_sum(s : NetflowpolicingPath) -> Double { @_common.sum(s.data) }

pub fn net_flow_policing_path_mean(s : NetflowpolicingPath) -> Double { @_common.mean(s.data) }

pub fn net_flow_policing_path_scale(s : NetflowpolicingPath, f : Double) -> NetflowpolicingPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_flow_policing_path_add(a : NetflowpolicingPath, b : NetflowpolicingPath) -> NetflowpolicingPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_flow_policing_path_copy(s : NetflowpolicingPath) -> NetflowpolicingPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_flow_policing_path_fill(s : NetflowpolicingPath, v : Double) -> NetflowpolicingPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_flow_policing_path_min(s : NetflowpolicingPath) -> Double { @_common.min(s.data) }

pub fn net_flow_policing_path_max(s : NetflowpolicingPath) -> Double { @_common.max(s.data) }

pub fn net_flow_policing_path_to_string(s : NetflowpolicingPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetflowpolicingCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_flow_policing_cluster_make(size : Int) -> NetflowpolicingCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_flow_policing_cluster_len(s : NetflowpolicingCluster) -> Int { s.size }

pub fn net_flow_policing_cluster_get(s : NetflowpolicingCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_flow_policing_cluster_set(s : NetflowpolicingCluster, i : Int, v : Double) -> NetflowpolicingCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn net_flow_policing_cluster_sum(s : NetflowpolicingCluster) -> Double { @_common.sum(s.data) }

pub fn net_flow_policing_cluster_mean(s : NetflowpolicingCluster) -> Double { @_common.mean(s.data) }

pub fn net_flow_policing_cluster_scale(s : NetflowpolicingCluster, f : Double) -> NetflowpolicingCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_flow_policing_cluster_add(a : NetflowpolicingCluster, b : NetflowpolicingCluster) -> NetflowpolicingCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_flow_policing_cluster_copy(s : NetflowpolicingCluster) -> NetflowpolicingCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_flow_policing_cluster_fill(s : NetflowpolicingCluster, v : Double) -> NetflowpolicingCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_flow_policing_cluster_min(s : NetflowpolicingCluster) -> Double { @_common.min(s.data) }

pub fn net_flow_policing_cluster_max(s : NetflowpolicingCluster) -> Double { @_common.max(s.data) }

pub fn net_flow_policing_cluster_to_string(s : NetflowpolicingCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetflowpolicingModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_flow_policing_model_make(size : Int) -> NetflowpolicingModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_flow_policing_model_len(s : NetflowpolicingModel) -> Int { s.size }

pub fn net_flow_policing_model_get(s : NetflowpolicingModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_flow_policing_model_set(s : NetflowpolicingModel, i : Int, v : Double) -> NetflowpolicingModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn net_flow_policing_model_sum(s : NetflowpolicingModel) -> Double { @_common.sum(s.data) }

pub fn net_flow_policing_model_mean(s : NetflowpolicingModel) -> Double { @_common.mean(s.data) }

pub fn net_flow_policing_model_scale(s : NetflowpolicingModel, f : Double) -> NetflowpolicingModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_flow_policing_model_add(a : NetflowpolicingModel, b : NetflowpolicingModel) -> NetflowpolicingModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_flow_policing_model_copy(s : NetflowpolicingModel) -> NetflowpolicingModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_flow_policing_model_fill(s : NetflowpolicingModel, v : Double) -> NetflowpolicingModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_flow_policing_model_min(s : NetflowpolicingModel) -> Double { @_common.min(s.data) }

pub fn net_flow_policing_model_max(s : NetflowpolicingModel) -> Double { @_common.max(s.data) }

pub fn net_flow_policing_model_to_string(s : NetflowpolicingModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetflowpolicingLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_flow_policing_layer_make(size : Int) -> NetflowpolicingLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_flow_policing_layer_len(s : NetflowpolicingLayer) -> Int { s.size }

pub fn net_flow_policing_layer_get(s : NetflowpolicingLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_flow_policing_layer_set(s : NetflowpolicingLayer, i : Int, v : Double) -> NetflowpolicingLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn net_flow_policing_layer_sum(s : NetflowpolicingLayer) -> Double { @_common.sum(s.data) }

pub fn net_flow_policing_layer_mean(s : NetflowpolicingLayer) -> Double { @_common.mean(s.data) }

pub fn net_flow_policing_layer_scale(s : NetflowpolicingLayer, f : Double) -> NetflowpolicingLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_flow_policing_layer_add(a : NetflowpolicingLayer, b : NetflowpolicingLayer) -> NetflowpolicingLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_flow_policing_layer_copy(s : NetflowpolicingLayer) -> NetflowpolicingLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_flow_policing_layer_fill(s : NetflowpolicingLayer, v : Double) -> NetflowpolicingLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_flow_policing_layer_min(s : NetflowpolicingLayer) -> Double { @_common.min(s.data) }

pub fn net_flow_policing_layer_max(s : NetflowpolicingLayer) -> Double { @_common.max(s.data) }

pub fn net_flow_policing_layer_to_string(s : NetflowpolicingLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetflowpolicingBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_flow_policing_buffer_make(size : Int) -> NetflowpolicingBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_flow_policing_buffer_len(s : NetflowpolicingBuffer) -> Int { s.size }

pub fn net_flow_policing_buffer_get(s : NetflowpolicingBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_flow_policing_buffer_set(s : NetflowpolicingBuffer, i : Int, v : Double) -> NetflowpolicingBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn net_flow_policing_buffer_sum(s : NetflowpolicingBuffer) -> Double { @_common.sum(s.data) }

pub fn net_flow_policing_buffer_mean(s : NetflowpolicingBuffer) -> Double { @_common.mean(s.data) }

pub fn net_flow_policing_buffer_scale(s : NetflowpolicingBuffer, f : Double) -> NetflowpolicingBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_flow_policing_buffer_add(a : NetflowpolicingBuffer, b : NetflowpolicingBuffer) -> NetflowpolicingBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_flow_policing_buffer_copy(s : NetflowpolicingBuffer) -> NetflowpolicingBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_flow_policing_buffer_fill(s : NetflowpolicingBuffer, v : Double) -> NetflowpolicingBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_flow_policing_buffer_min(s : NetflowpolicingBuffer) -> Double { @_common.min(s.data) }

pub fn net_flow_policing_buffer_max(s : NetflowpolicingBuffer) -> Double { @_common.max(s.data) }

pub fn net_flow_policing_buffer_to_string(s : NetflowpolicingBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetflowpolicingCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_flow_policing_cursor_make(size : Int) -> NetflowpolicingCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_flow_policing_cursor_len(s : NetflowpolicingCursor) -> Int { s.size }

pub fn net_flow_policing_cursor_get(s : NetflowpolicingCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_flow_policing_cursor_set(s : NetflowpolicingCursor, i : Int, v : Double) -> NetflowpolicingCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn net_flow_policing_cursor_sum(s : NetflowpolicingCursor) -> Double { @_common.sum(s.data) }

pub fn net_flow_policing_cursor_mean(s : NetflowpolicingCursor) -> Double { @_common.mean(s.data) }

pub fn net_flow_policing_cursor_scale(s : NetflowpolicingCursor, f : Double) -> NetflowpolicingCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_flow_policing_cursor_add(a : NetflowpolicingCursor, b : NetflowpolicingCursor) -> NetflowpolicingCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_flow_policing_cursor_copy(s : NetflowpolicingCursor) -> NetflowpolicingCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_flow_policing_cursor_fill(s : NetflowpolicingCursor, v : Double) -> NetflowpolicingCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_flow_policing_cursor_min(s : NetflowpolicingCursor) -> Double { @_common.min(s.data) }

pub fn net_flow_policing_cursor_max(s : NetflowpolicingCursor) -> Double { @_common.max(s.data) }

pub fn net_flow_policing_cursor_to_string(s : NetflowpolicingCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetflowpolicingView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_flow_policing_view_make(size : Int) -> NetflowpolicingView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_flow_policing_view_len(s : NetflowpolicingView) -> Int { s.size }

pub fn net_flow_policing_view_get(s : NetflowpolicingView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_flow_policing_view_set(s : NetflowpolicingView, i : Int, v : Double) -> NetflowpolicingView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn net_flow_policing_view_sum(s : NetflowpolicingView) -> Double { @_common.sum(s.data) }

pub fn net_flow_policing_view_mean(s : NetflowpolicingView) -> Double { @_common.mean(s.data) }

pub fn net_flow_policing_view_scale(s : NetflowpolicingView, f : Double) -> NetflowpolicingView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_flow_policing_view_add(a : NetflowpolicingView, b : NetflowpolicingView) -> NetflowpolicingView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_flow_policing_view_copy(s : NetflowpolicingView) -> NetflowpolicingView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_flow_policing_view_fill(s : NetflowpolicingView, v : Double) -> NetflowpolicingView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_flow_policing_view_min(s : NetflowpolicingView) -> Double { @_common.min(s.data) }

pub fn net_flow_policing_view_max(s : NetflowpolicingView) -> Double { @_common.max(s.data) }

pub fn net_flow_policing_view_to_string(s : NetflowpolicingView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetflowpolicingRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_flow_policing_range_make(size : Int) -> NetflowpolicingRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_flow_policing_range_len(s : NetflowpolicingRange) -> Int { s.size }

pub fn net_flow_policing_range_get(s : NetflowpolicingRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_flow_policing_range_set(s : NetflowpolicingRange, i : Int, v : Double) -> NetflowpolicingRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn net_flow_policing_range_sum(s : NetflowpolicingRange) -> Double { @_common.sum(s.data) }

pub fn net_flow_policing_range_mean(s : NetflowpolicingRange) -> Double { @_common.mean(s.data) }

pub fn net_flow_policing_range_scale(s : NetflowpolicingRange, f : Double) -> NetflowpolicingRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_flow_policing_range_add(a : NetflowpolicingRange, b : NetflowpolicingRange) -> NetflowpolicingRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_flow_policing_range_copy(s : NetflowpolicingRange) -> NetflowpolicingRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_flow_policing_range_fill(s : NetflowpolicingRange, v : Double) -> NetflowpolicingRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_flow_policing_range_min(s : NetflowpolicingRange) -> Double { @_common.min(s.data) }

pub fn net_flow_policing_range_max(s : NetflowpolicingRange) -> Double { @_common.max(s.data) }

pub fn net_flow_policing_range_to_string(s : NetflowpolicingRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetflowpolicingSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_flow_policing_slice_make(size : Int) -> NetflowpolicingSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_flow_policing_slice_len(s : NetflowpolicingSlice) -> Int { s.size }

pub fn net_flow_policing_slice_get(s : NetflowpolicingSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_flow_policing_slice_set(s : NetflowpolicingSlice, i : Int, v : Double) -> NetflowpolicingSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn net_flow_policing_slice_sum(s : NetflowpolicingSlice) -> Double { @_common.sum(s.data) }

pub fn net_flow_policing_slice_mean(s : NetflowpolicingSlice) -> Double { @_common.mean(s.data) }

pub fn net_flow_policing_slice_scale(s : NetflowpolicingSlice, f : Double) -> NetflowpolicingSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_flow_policing_slice_add(a : NetflowpolicingSlice, b : NetflowpolicingSlice) -> NetflowpolicingSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_flow_policing_slice_copy(s : NetflowpolicingSlice) -> NetflowpolicingSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_flow_policing_slice_fill(s : NetflowpolicingSlice, v : Double) -> NetflowpolicingSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_flow_policing_slice_min(s : NetflowpolicingSlice) -> Double { @_common.min(s.data) }

pub fn net_flow_policing_slice_max(s : NetflowpolicingSlice) -> Double { @_common.max(s.data) }

pub fn net_flow_policing_slice_to_string(s : NetflowpolicingSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

