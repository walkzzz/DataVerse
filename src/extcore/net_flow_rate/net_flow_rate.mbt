///===
/// extcore/net_flow_rate

pub(all) struct NetflowratePoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn net_flow_rate_make_point(x : Double, y : Double) -> NetflowratePoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn net_flow_rate_make_point3(x : Double, y : Double, z : Double) -> NetflowratePoint {
  { x, y, z, label: 0 }
}

pub fn NetflowratePoint::x(self : NetflowratePoint) -> Double { self.x }

pub fn NetflowratePoint::y(self : NetflowratePoint) -> Double { self.y }

pub fn NetflowratePoint::z(self : NetflowratePoint) -> Double { self.z }

pub fn NetflowratePoint::label(self : NetflowratePoint) -> Int { self.label }

pub fn NetflowratePoint::dist(self : NetflowratePoint, other : NetflowratePoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn NetflowratePoint::add(self : NetflowratePoint, other : NetflowratePoint) -> NetflowratePoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn NetflowratePoint::sub(self : NetflowratePoint, other : NetflowratePoint) -> NetflowratePoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn NetflowratePoint::scale(self : NetflowratePoint, s : Double) -> NetflowratePoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn NetflowratePoint::dot(self : NetflowratePoint, other : NetflowratePoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn NetflowratePoint::cross(self : NetflowratePoint, other : NetflowratePoint) -> NetflowratePoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn NetflowratePoint::norm(self : NetflowratePoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn NetflowratePoint::normalize(self : NetflowratePoint) -> NetflowratePoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn NetflowratePoint::negate(self : NetflowratePoint) -> NetflowratePoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn NetflowratePoint::mid(self : NetflowratePoint, other : NetflowratePoint) -> NetflowratePoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn NetflowratePoint::lerp(self : NetflowratePoint, other : NetflowratePoint, t : Double) -> NetflowratePoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn NetflowratePoint::to_string(self : NetflowratePoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct NetflowrateSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn net_flow_rate_make_series(vals : Array[Double], name : String) -> NetflowrateSeries {
  { vals, name, meta: 0 }
}

pub fn NetflowrateSeries::len(self : NetflowrateSeries) -> Int { self.vals.length() }

pub fn NetflowrateSeries::sum(self : NetflowrateSeries) -> Double { @_common.sum(self.vals) }

pub fn NetflowrateSeries::mean(self : NetflowrateSeries) -> Double { @_common.mean(self.vals) }

pub fn NetflowrateSeries::min(self : NetflowrateSeries) -> Double { @_common.min(self.vals) }

pub fn NetflowrateSeries::max(self : NetflowrateSeries) -> Double { @_common.max(self.vals) }

pub fn NetflowrateSeries::range(self : NetflowrateSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn NetflowrateSeries::variance(self : NetflowrateSeries) -> Double { @_common.variance(self.vals) }

pub fn NetflowrateSeries::std(self : NetflowrateSeries) -> Double { @_common.std(self.vals) }

pub fn NetflowrateSeries::median(self : NetflowrateSeries) -> Double { @_common.median(self.vals) }

pub fn NetflowrateSeries::scale(self : NetflowrateSeries, f : Double) -> NetflowrateSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn NetflowrateSeries::add(self : NetflowrateSeries, other : NetflowrateSeries) -> NetflowrateSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn NetflowrateSeries::sub(self : NetflowrateSeries, other : NetflowrateSeries) -> NetflowrateSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn NetflowrateSeries::normalize(self : NetflowrateSeries) -> NetflowrateSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn NetflowrateSeries::cumsum(self : NetflowrateSeries) -> NetflowrateSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn NetflowrateSeries::to_string(self : NetflowrateSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct NetflowrateMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn net_flow_rate_make_matrix(rows : Int, cols : Int, val : Double) -> NetflowrateMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn net_flow_rate_matrix_identity(n : Int) -> NetflowrateMatrix {
  let m = net_flow_rate_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn NetflowrateMatrix::get(self : NetflowrateMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn NetflowrateMatrix::transpose(self : NetflowrateMatrix) -> NetflowrateMatrix {
  let result = net_flow_rate_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn NetflowrateMatrix::add(self : NetflowrateMatrix, other : NetflowrateMatrix) -> NetflowrateMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = net_flow_rate_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn NetflowrateMatrix::scale(self : NetflowrateMatrix, s : Double) -> NetflowrateMatrix {
  let result = net_flow_rate_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn NetflowrateMatrix::multiply(self : NetflowrateMatrix, other : NetflowrateMatrix) -> NetflowrateMatrix {
  if self.cols != other.rows { return net_flow_rate_make_matrix(self.rows, other.cols, 0.0) }
  let result = net_flow_rate_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn NetflowrateMatrix::trace(self : NetflowrateMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn NetflowrateMatrix::det(self : NetflowrateMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn NetflowrateMatrix::norm(self : NetflowrateMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn NetflowrateMatrix::to_string(self : NetflowrateMatrix) -> String {
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

pub(all) struct NetflowrateVector {
  comps : Array[Double]
  dim : Int
}

pub fn net_flow_rate_make_vector(comps : Array[Double]) -> NetflowrateVector {
  { comps, dim: comps.length() }
}

pub fn net_flow_rate_vector_zero(dim : Int) -> NetflowrateVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn NetflowrateVector::add(self : NetflowrateVector, other : NetflowrateVector) -> NetflowrateVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn NetflowrateVector::sub(self : NetflowrateVector, other : NetflowrateVector) -> NetflowrateVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn NetflowrateVector::scale(self : NetflowrateVector, s : Double) -> NetflowrateVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn NetflowrateVector::dot(self : NetflowrateVector, other : NetflowrateVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn NetflowrateVector::norm(self : NetflowrateVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn NetflowrateVector::normalize(self : NetflowrateVector) -> NetflowrateVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn NetflowrateVector::dist(self : NetflowrateVector, other : NetflowrateVector) -> Double {
  self.sub(other).norm()
}

pub fn NetflowrateVector::to_string(self : NetflowrateVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn net_flow_rate_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn net_flow_rate_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn net_flow_rate_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn net_flow_rate_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn net_flow_rate_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn net_flow_rate_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn net_flow_rate_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn net_flow_rate_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn net_flow_rate_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn net_flow_rate_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn net_flow_rate_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn net_flow_rate_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn net_flow_rate_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn net_flow_rate_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn net_flow_rate_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn net_flow_rate_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn net_flow_rate_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn net_flow_rate_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn net_flow_rate_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn net_flow_rate_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn net_flow_rate_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn net_flow_rate_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn net_flow_rate_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn net_flow_rate_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn net_flow_rate_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn net_flow_rate_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn net_flow_rate_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn net_flow_rate_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn net_flow_rate_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct NetflowrateFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_flow_rate_frame_make(size : Int) -> NetflowrateFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_flow_rate_frame_len(s : NetflowrateFrame) -> Int { s.size }

pub fn net_flow_rate_frame_get(s : NetflowrateFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_flow_rate_frame_set(s : NetflowrateFrame, i : Int, v : Double) -> NetflowrateFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn net_flow_rate_frame_sum(s : NetflowrateFrame) -> Double { @_common.sum(s.data) }

pub fn net_flow_rate_frame_mean(s : NetflowrateFrame) -> Double { @_common.mean(s.data) }

pub fn net_flow_rate_frame_scale(s : NetflowrateFrame, f : Double) -> NetflowrateFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_flow_rate_frame_add(a : NetflowrateFrame, b : NetflowrateFrame) -> NetflowrateFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_flow_rate_frame_copy(s : NetflowrateFrame) -> NetflowrateFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_flow_rate_frame_fill(s : NetflowrateFrame, v : Double) -> NetflowrateFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_flow_rate_frame_min(s : NetflowrateFrame) -> Double { @_common.min(s.data) }

pub fn net_flow_rate_frame_max(s : NetflowrateFrame) -> Double { @_common.max(s.data) }

pub fn net_flow_rate_frame_to_string(s : NetflowrateFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetflowrateTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_flow_rate_table_make(size : Int) -> NetflowrateTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_flow_rate_table_len(s : NetflowrateTable) -> Int { s.size }

pub fn net_flow_rate_table_get(s : NetflowrateTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_flow_rate_table_set(s : NetflowrateTable, i : Int, v : Double) -> NetflowrateTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn net_flow_rate_table_sum(s : NetflowrateTable) -> Double { @_common.sum(s.data) }

pub fn net_flow_rate_table_mean(s : NetflowrateTable) -> Double { @_common.mean(s.data) }

pub fn net_flow_rate_table_scale(s : NetflowrateTable, f : Double) -> NetflowrateTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_flow_rate_table_add(a : NetflowrateTable, b : NetflowrateTable) -> NetflowrateTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_flow_rate_table_copy(s : NetflowrateTable) -> NetflowrateTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_flow_rate_table_fill(s : NetflowrateTable, v : Double) -> NetflowrateTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_flow_rate_table_min(s : NetflowrateTable) -> Double { @_common.min(s.data) }

pub fn net_flow_rate_table_max(s : NetflowrateTable) -> Double { @_common.max(s.data) }

pub fn net_flow_rate_table_to_string(s : NetflowrateTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetflowrateGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_flow_rate_graphn_make(size : Int) -> NetflowrateGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_flow_rate_graphn_len(s : NetflowrateGraphN) -> Int { s.size }

pub fn net_flow_rate_graphn_get(s : NetflowrateGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_flow_rate_graphn_set(s : NetflowrateGraphN, i : Int, v : Double) -> NetflowrateGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn net_flow_rate_graphn_sum(s : NetflowrateGraphN) -> Double { @_common.sum(s.data) }

pub fn net_flow_rate_graphn_mean(s : NetflowrateGraphN) -> Double { @_common.mean(s.data) }

pub fn net_flow_rate_graphn_scale(s : NetflowrateGraphN, f : Double) -> NetflowrateGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_flow_rate_graphn_add(a : NetflowrateGraphN, b : NetflowrateGraphN) -> NetflowrateGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_flow_rate_graphn_copy(s : NetflowrateGraphN) -> NetflowrateGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_flow_rate_graphn_fill(s : NetflowrateGraphN, v : Double) -> NetflowrateGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_flow_rate_graphn_min(s : NetflowrateGraphN) -> Double { @_common.min(s.data) }

pub fn net_flow_rate_graphn_max(s : NetflowrateGraphN) -> Double { @_common.max(s.data) }

pub fn net_flow_rate_graphn_to_string(s : NetflowrateGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetflowrateNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_flow_rate_node_make(size : Int) -> NetflowrateNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_flow_rate_node_len(s : NetflowrateNode) -> Int { s.size }

pub fn net_flow_rate_node_get(s : NetflowrateNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_flow_rate_node_set(s : NetflowrateNode, i : Int, v : Double) -> NetflowrateNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn net_flow_rate_node_sum(s : NetflowrateNode) -> Double { @_common.sum(s.data) }

pub fn net_flow_rate_node_mean(s : NetflowrateNode) -> Double { @_common.mean(s.data) }

pub fn net_flow_rate_node_scale(s : NetflowrateNode, f : Double) -> NetflowrateNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_flow_rate_node_add(a : NetflowrateNode, b : NetflowrateNode) -> NetflowrateNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_flow_rate_node_copy(s : NetflowrateNode) -> NetflowrateNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_flow_rate_node_fill(s : NetflowrateNode, v : Double) -> NetflowrateNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_flow_rate_node_min(s : NetflowrateNode) -> Double { @_common.min(s.data) }

pub fn net_flow_rate_node_max(s : NetflowrateNode) -> Double { @_common.max(s.data) }

pub fn net_flow_rate_node_to_string(s : NetflowrateNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetflowrateEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_flow_rate_edge_make(size : Int) -> NetflowrateEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_flow_rate_edge_len(s : NetflowrateEdge) -> Int { s.size }

pub fn net_flow_rate_edge_get(s : NetflowrateEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_flow_rate_edge_set(s : NetflowrateEdge, i : Int, v : Double) -> NetflowrateEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn net_flow_rate_edge_sum(s : NetflowrateEdge) -> Double { @_common.sum(s.data) }

pub fn net_flow_rate_edge_mean(s : NetflowrateEdge) -> Double { @_common.mean(s.data) }

pub fn net_flow_rate_edge_scale(s : NetflowrateEdge, f : Double) -> NetflowrateEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_flow_rate_edge_add(a : NetflowrateEdge, b : NetflowrateEdge) -> NetflowrateEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_flow_rate_edge_copy(s : NetflowrateEdge) -> NetflowrateEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_flow_rate_edge_fill(s : NetflowrateEdge, v : Double) -> NetflowrateEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_flow_rate_edge_min(s : NetflowrateEdge) -> Double { @_common.min(s.data) }

pub fn net_flow_rate_edge_max(s : NetflowrateEdge) -> Double { @_common.max(s.data) }

pub fn net_flow_rate_edge_to_string(s : NetflowrateEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetflowratePath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_flow_rate_path_make(size : Int) -> NetflowratePath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_flow_rate_path_len(s : NetflowratePath) -> Int { s.size }

pub fn net_flow_rate_path_get(s : NetflowratePath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_flow_rate_path_set(s : NetflowratePath, i : Int, v : Double) -> NetflowratePath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn net_flow_rate_path_sum(s : NetflowratePath) -> Double { @_common.sum(s.data) }

pub fn net_flow_rate_path_mean(s : NetflowratePath) -> Double { @_common.mean(s.data) }

pub fn net_flow_rate_path_scale(s : NetflowratePath, f : Double) -> NetflowratePath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_flow_rate_path_add(a : NetflowratePath, b : NetflowratePath) -> NetflowratePath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_flow_rate_path_copy(s : NetflowratePath) -> NetflowratePath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_flow_rate_path_fill(s : NetflowratePath, v : Double) -> NetflowratePath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_flow_rate_path_min(s : NetflowratePath) -> Double { @_common.min(s.data) }

pub fn net_flow_rate_path_max(s : NetflowratePath) -> Double { @_common.max(s.data) }

pub fn net_flow_rate_path_to_string(s : NetflowratePath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetflowrateCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_flow_rate_cluster_make(size : Int) -> NetflowrateCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_flow_rate_cluster_len(s : NetflowrateCluster) -> Int { s.size }

pub fn net_flow_rate_cluster_get(s : NetflowrateCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_flow_rate_cluster_set(s : NetflowrateCluster, i : Int, v : Double) -> NetflowrateCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn net_flow_rate_cluster_sum(s : NetflowrateCluster) -> Double { @_common.sum(s.data) }

pub fn net_flow_rate_cluster_mean(s : NetflowrateCluster) -> Double { @_common.mean(s.data) }

pub fn net_flow_rate_cluster_scale(s : NetflowrateCluster, f : Double) -> NetflowrateCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_flow_rate_cluster_add(a : NetflowrateCluster, b : NetflowrateCluster) -> NetflowrateCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_flow_rate_cluster_copy(s : NetflowrateCluster) -> NetflowrateCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_flow_rate_cluster_fill(s : NetflowrateCluster, v : Double) -> NetflowrateCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_flow_rate_cluster_min(s : NetflowrateCluster) -> Double { @_common.min(s.data) }

pub fn net_flow_rate_cluster_max(s : NetflowrateCluster) -> Double { @_common.max(s.data) }

pub fn net_flow_rate_cluster_to_string(s : NetflowrateCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetflowrateModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_flow_rate_model_make(size : Int) -> NetflowrateModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_flow_rate_model_len(s : NetflowrateModel) -> Int { s.size }

pub fn net_flow_rate_model_get(s : NetflowrateModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_flow_rate_model_set(s : NetflowrateModel, i : Int, v : Double) -> NetflowrateModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn net_flow_rate_model_sum(s : NetflowrateModel) -> Double { @_common.sum(s.data) }

pub fn net_flow_rate_model_mean(s : NetflowrateModel) -> Double { @_common.mean(s.data) }

pub fn net_flow_rate_model_scale(s : NetflowrateModel, f : Double) -> NetflowrateModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_flow_rate_model_add(a : NetflowrateModel, b : NetflowrateModel) -> NetflowrateModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_flow_rate_model_copy(s : NetflowrateModel) -> NetflowrateModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_flow_rate_model_fill(s : NetflowrateModel, v : Double) -> NetflowrateModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_flow_rate_model_min(s : NetflowrateModel) -> Double { @_common.min(s.data) }

pub fn net_flow_rate_model_max(s : NetflowrateModel) -> Double { @_common.max(s.data) }

pub fn net_flow_rate_model_to_string(s : NetflowrateModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetflowrateLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_flow_rate_layer_make(size : Int) -> NetflowrateLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_flow_rate_layer_len(s : NetflowrateLayer) -> Int { s.size }

pub fn net_flow_rate_layer_get(s : NetflowrateLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_flow_rate_layer_set(s : NetflowrateLayer, i : Int, v : Double) -> NetflowrateLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn net_flow_rate_layer_sum(s : NetflowrateLayer) -> Double { @_common.sum(s.data) }

pub fn net_flow_rate_layer_mean(s : NetflowrateLayer) -> Double { @_common.mean(s.data) }

pub fn net_flow_rate_layer_scale(s : NetflowrateLayer, f : Double) -> NetflowrateLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_flow_rate_layer_add(a : NetflowrateLayer, b : NetflowrateLayer) -> NetflowrateLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_flow_rate_layer_copy(s : NetflowrateLayer) -> NetflowrateLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_flow_rate_layer_fill(s : NetflowrateLayer, v : Double) -> NetflowrateLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_flow_rate_layer_min(s : NetflowrateLayer) -> Double { @_common.min(s.data) }

pub fn net_flow_rate_layer_max(s : NetflowrateLayer) -> Double { @_common.max(s.data) }

pub fn net_flow_rate_layer_to_string(s : NetflowrateLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetflowrateBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_flow_rate_buffer_make(size : Int) -> NetflowrateBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_flow_rate_buffer_len(s : NetflowrateBuffer) -> Int { s.size }

pub fn net_flow_rate_buffer_get(s : NetflowrateBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_flow_rate_buffer_set(s : NetflowrateBuffer, i : Int, v : Double) -> NetflowrateBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn net_flow_rate_buffer_sum(s : NetflowrateBuffer) -> Double { @_common.sum(s.data) }

pub fn net_flow_rate_buffer_mean(s : NetflowrateBuffer) -> Double { @_common.mean(s.data) }

pub fn net_flow_rate_buffer_scale(s : NetflowrateBuffer, f : Double) -> NetflowrateBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_flow_rate_buffer_add(a : NetflowrateBuffer, b : NetflowrateBuffer) -> NetflowrateBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_flow_rate_buffer_copy(s : NetflowrateBuffer) -> NetflowrateBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_flow_rate_buffer_fill(s : NetflowrateBuffer, v : Double) -> NetflowrateBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_flow_rate_buffer_min(s : NetflowrateBuffer) -> Double { @_common.min(s.data) }

pub fn net_flow_rate_buffer_max(s : NetflowrateBuffer) -> Double { @_common.max(s.data) }

pub fn net_flow_rate_buffer_to_string(s : NetflowrateBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetflowrateCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_flow_rate_cursor_make(size : Int) -> NetflowrateCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_flow_rate_cursor_len(s : NetflowrateCursor) -> Int { s.size }

pub fn net_flow_rate_cursor_get(s : NetflowrateCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_flow_rate_cursor_set(s : NetflowrateCursor, i : Int, v : Double) -> NetflowrateCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn net_flow_rate_cursor_sum(s : NetflowrateCursor) -> Double { @_common.sum(s.data) }

pub fn net_flow_rate_cursor_mean(s : NetflowrateCursor) -> Double { @_common.mean(s.data) }

pub fn net_flow_rate_cursor_scale(s : NetflowrateCursor, f : Double) -> NetflowrateCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_flow_rate_cursor_add(a : NetflowrateCursor, b : NetflowrateCursor) -> NetflowrateCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_flow_rate_cursor_copy(s : NetflowrateCursor) -> NetflowrateCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_flow_rate_cursor_fill(s : NetflowrateCursor, v : Double) -> NetflowrateCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_flow_rate_cursor_min(s : NetflowrateCursor) -> Double { @_common.min(s.data) }

pub fn net_flow_rate_cursor_max(s : NetflowrateCursor) -> Double { @_common.max(s.data) }

pub fn net_flow_rate_cursor_to_string(s : NetflowrateCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetflowrateView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_flow_rate_view_make(size : Int) -> NetflowrateView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_flow_rate_view_len(s : NetflowrateView) -> Int { s.size }

pub fn net_flow_rate_view_get(s : NetflowrateView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_flow_rate_view_set(s : NetflowrateView, i : Int, v : Double) -> NetflowrateView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn net_flow_rate_view_sum(s : NetflowrateView) -> Double { @_common.sum(s.data) }

pub fn net_flow_rate_view_mean(s : NetflowrateView) -> Double { @_common.mean(s.data) }

pub fn net_flow_rate_view_scale(s : NetflowrateView, f : Double) -> NetflowrateView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_flow_rate_view_add(a : NetflowrateView, b : NetflowrateView) -> NetflowrateView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_flow_rate_view_copy(s : NetflowrateView) -> NetflowrateView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_flow_rate_view_fill(s : NetflowrateView, v : Double) -> NetflowrateView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_flow_rate_view_min(s : NetflowrateView) -> Double { @_common.min(s.data) }

pub fn net_flow_rate_view_max(s : NetflowrateView) -> Double { @_common.max(s.data) }

pub fn net_flow_rate_view_to_string(s : NetflowrateView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetflowrateRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_flow_rate_range_make(size : Int) -> NetflowrateRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_flow_rate_range_len(s : NetflowrateRange) -> Int { s.size }

pub fn net_flow_rate_range_get(s : NetflowrateRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_flow_rate_range_set(s : NetflowrateRange, i : Int, v : Double) -> NetflowrateRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn net_flow_rate_range_sum(s : NetflowrateRange) -> Double { @_common.sum(s.data) }

pub fn net_flow_rate_range_mean(s : NetflowrateRange) -> Double { @_common.mean(s.data) }

pub fn net_flow_rate_range_scale(s : NetflowrateRange, f : Double) -> NetflowrateRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_flow_rate_range_add(a : NetflowrateRange, b : NetflowrateRange) -> NetflowrateRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_flow_rate_range_copy(s : NetflowrateRange) -> NetflowrateRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_flow_rate_range_fill(s : NetflowrateRange, v : Double) -> NetflowrateRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_flow_rate_range_min(s : NetflowrateRange) -> Double { @_common.min(s.data) }

pub fn net_flow_rate_range_max(s : NetflowrateRange) -> Double { @_common.max(s.data) }

pub fn net_flow_rate_range_to_string(s : NetflowrateRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetflowrateSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_flow_rate_slice_make(size : Int) -> NetflowrateSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_flow_rate_slice_len(s : NetflowrateSlice) -> Int { s.size }

pub fn net_flow_rate_slice_get(s : NetflowrateSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_flow_rate_slice_set(s : NetflowrateSlice, i : Int, v : Double) -> NetflowrateSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn net_flow_rate_slice_sum(s : NetflowrateSlice) -> Double { @_common.sum(s.data) }

pub fn net_flow_rate_slice_mean(s : NetflowrateSlice) -> Double { @_common.mean(s.data) }

pub fn net_flow_rate_slice_scale(s : NetflowrateSlice, f : Double) -> NetflowrateSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_flow_rate_slice_add(a : NetflowrateSlice, b : NetflowrateSlice) -> NetflowrateSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_flow_rate_slice_copy(s : NetflowrateSlice) -> NetflowrateSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_flow_rate_slice_fill(s : NetflowrateSlice, v : Double) -> NetflowrateSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_flow_rate_slice_min(s : NetflowrateSlice) -> Double { @_common.min(s.data) }

pub fn net_flow_rate_slice_max(s : NetflowrateSlice) -> Double { @_common.max(s.data) }

pub fn net_flow_rate_slice_to_string(s : NetflowrateSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

