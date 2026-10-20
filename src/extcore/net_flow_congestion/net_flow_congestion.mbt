///===
/// extcore/net_flow_congestion

pub(all) struct NetflowcongestionPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn net_flow_congestion_make_point(x : Double, y : Double) -> NetflowcongestionPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn net_flow_congestion_make_point3(x : Double, y : Double, z : Double) -> NetflowcongestionPoint {
  { x, y, z, label: 0 }
}

pub fn NetflowcongestionPoint::x(self : NetflowcongestionPoint) -> Double { self.x }

pub fn NetflowcongestionPoint::y(self : NetflowcongestionPoint) -> Double { self.y }

pub fn NetflowcongestionPoint::z(self : NetflowcongestionPoint) -> Double { self.z }

pub fn NetflowcongestionPoint::label(self : NetflowcongestionPoint) -> Int { self.label }

pub fn NetflowcongestionPoint::dist(self : NetflowcongestionPoint, other : NetflowcongestionPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn NetflowcongestionPoint::add(self : NetflowcongestionPoint, other : NetflowcongestionPoint) -> NetflowcongestionPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn NetflowcongestionPoint::sub(self : NetflowcongestionPoint, other : NetflowcongestionPoint) -> NetflowcongestionPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn NetflowcongestionPoint::scale(self : NetflowcongestionPoint, s : Double) -> NetflowcongestionPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn NetflowcongestionPoint::dot(self : NetflowcongestionPoint, other : NetflowcongestionPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn NetflowcongestionPoint::cross(self : NetflowcongestionPoint, other : NetflowcongestionPoint) -> NetflowcongestionPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn NetflowcongestionPoint::norm(self : NetflowcongestionPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn NetflowcongestionPoint::normalize(self : NetflowcongestionPoint) -> NetflowcongestionPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn NetflowcongestionPoint::negate(self : NetflowcongestionPoint) -> NetflowcongestionPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn NetflowcongestionPoint::mid(self : NetflowcongestionPoint, other : NetflowcongestionPoint) -> NetflowcongestionPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn NetflowcongestionPoint::lerp(self : NetflowcongestionPoint, other : NetflowcongestionPoint, t : Double) -> NetflowcongestionPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn NetflowcongestionPoint::to_string(self : NetflowcongestionPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct NetflowcongestionSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn net_flow_congestion_make_series(vals : Array[Double], name : String) -> NetflowcongestionSeries {
  { vals, name, meta: 0 }
}

pub fn NetflowcongestionSeries::len(self : NetflowcongestionSeries) -> Int { self.vals.length() }

pub fn NetflowcongestionSeries::sum(self : NetflowcongestionSeries) -> Double { @_common.sum(self.vals) }

pub fn NetflowcongestionSeries::mean(self : NetflowcongestionSeries) -> Double { @_common.mean(self.vals) }

pub fn NetflowcongestionSeries::min(self : NetflowcongestionSeries) -> Double { @_common.min(self.vals) }

pub fn NetflowcongestionSeries::max(self : NetflowcongestionSeries) -> Double { @_common.max(self.vals) }

pub fn NetflowcongestionSeries::range(self : NetflowcongestionSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn NetflowcongestionSeries::variance(self : NetflowcongestionSeries) -> Double { @_common.variance(self.vals) }

pub fn NetflowcongestionSeries::std(self : NetflowcongestionSeries) -> Double { @_common.std(self.vals) }

pub fn NetflowcongestionSeries::median(self : NetflowcongestionSeries) -> Double { @_common.median(self.vals) }

pub fn NetflowcongestionSeries::scale(self : NetflowcongestionSeries, f : Double) -> NetflowcongestionSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn NetflowcongestionSeries::add(self : NetflowcongestionSeries, other : NetflowcongestionSeries) -> NetflowcongestionSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn NetflowcongestionSeries::sub(self : NetflowcongestionSeries, other : NetflowcongestionSeries) -> NetflowcongestionSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn NetflowcongestionSeries::normalize(self : NetflowcongestionSeries) -> NetflowcongestionSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn NetflowcongestionSeries::cumsum(self : NetflowcongestionSeries) -> NetflowcongestionSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn NetflowcongestionSeries::to_string(self : NetflowcongestionSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct NetflowcongestionMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn net_flow_congestion_make_matrix(rows : Int, cols : Int, val : Double) -> NetflowcongestionMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn net_flow_congestion_matrix_identity(n : Int) -> NetflowcongestionMatrix {
  let m = net_flow_congestion_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn NetflowcongestionMatrix::get(self : NetflowcongestionMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn NetflowcongestionMatrix::transpose(self : NetflowcongestionMatrix) -> NetflowcongestionMatrix {
  let result = net_flow_congestion_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn NetflowcongestionMatrix::add(self : NetflowcongestionMatrix, other : NetflowcongestionMatrix) -> NetflowcongestionMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = net_flow_congestion_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn NetflowcongestionMatrix::scale(self : NetflowcongestionMatrix, s : Double) -> NetflowcongestionMatrix {
  let result = net_flow_congestion_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn NetflowcongestionMatrix::multiply(self : NetflowcongestionMatrix, other : NetflowcongestionMatrix) -> NetflowcongestionMatrix {
  if self.cols != other.rows { return net_flow_congestion_make_matrix(self.rows, other.cols, 0.0) }
  let result = net_flow_congestion_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn NetflowcongestionMatrix::trace(self : NetflowcongestionMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn NetflowcongestionMatrix::det(self : NetflowcongestionMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn NetflowcongestionMatrix::norm(self : NetflowcongestionMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn NetflowcongestionMatrix::to_string(self : NetflowcongestionMatrix) -> String {
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

pub(all) struct NetflowcongestionVector {
  comps : Array[Double]
  dim : Int
}

pub fn net_flow_congestion_make_vector(comps : Array[Double]) -> NetflowcongestionVector {
  { comps, dim: comps.length() }
}

pub fn net_flow_congestion_vector_zero(dim : Int) -> NetflowcongestionVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn NetflowcongestionVector::add(self : NetflowcongestionVector, other : NetflowcongestionVector) -> NetflowcongestionVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn NetflowcongestionVector::sub(self : NetflowcongestionVector, other : NetflowcongestionVector) -> NetflowcongestionVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn NetflowcongestionVector::scale(self : NetflowcongestionVector, s : Double) -> NetflowcongestionVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn NetflowcongestionVector::dot(self : NetflowcongestionVector, other : NetflowcongestionVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn NetflowcongestionVector::norm(self : NetflowcongestionVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn NetflowcongestionVector::normalize(self : NetflowcongestionVector) -> NetflowcongestionVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn NetflowcongestionVector::dist(self : NetflowcongestionVector, other : NetflowcongestionVector) -> Double {
  self.sub(other).norm()
}

pub fn NetflowcongestionVector::to_string(self : NetflowcongestionVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn net_flow_congestion_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn net_flow_congestion_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn net_flow_congestion_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn net_flow_congestion_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn net_flow_congestion_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn net_flow_congestion_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn net_flow_congestion_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn net_flow_congestion_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn net_flow_congestion_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn net_flow_congestion_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn net_flow_congestion_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn net_flow_congestion_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn net_flow_congestion_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn net_flow_congestion_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn net_flow_congestion_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn net_flow_congestion_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn net_flow_congestion_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn net_flow_congestion_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn net_flow_congestion_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn net_flow_congestion_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn net_flow_congestion_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn net_flow_congestion_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn net_flow_congestion_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn net_flow_congestion_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn net_flow_congestion_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn net_flow_congestion_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn net_flow_congestion_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn net_flow_congestion_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn net_flow_congestion_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct NetflowcongestionFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_flow_congestion_frame_make(size : Int) -> NetflowcongestionFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_flow_congestion_frame_len(s : NetflowcongestionFrame) -> Int { s.size }

pub fn net_flow_congestion_frame_get(s : NetflowcongestionFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_flow_congestion_frame_set(s : NetflowcongestionFrame, i : Int, v : Double) -> NetflowcongestionFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn net_flow_congestion_frame_sum(s : NetflowcongestionFrame) -> Double { @_common.sum(s.data) }

pub fn net_flow_congestion_frame_mean(s : NetflowcongestionFrame) -> Double { @_common.mean(s.data) }

pub fn net_flow_congestion_frame_scale(s : NetflowcongestionFrame, f : Double) -> NetflowcongestionFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_flow_congestion_frame_add(a : NetflowcongestionFrame, b : NetflowcongestionFrame) -> NetflowcongestionFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_flow_congestion_frame_copy(s : NetflowcongestionFrame) -> NetflowcongestionFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_flow_congestion_frame_fill(s : NetflowcongestionFrame, v : Double) -> NetflowcongestionFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_flow_congestion_frame_min(s : NetflowcongestionFrame) -> Double { @_common.min(s.data) }

pub fn net_flow_congestion_frame_max(s : NetflowcongestionFrame) -> Double { @_common.max(s.data) }

pub fn net_flow_congestion_frame_to_string(s : NetflowcongestionFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetflowcongestionTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_flow_congestion_table_make(size : Int) -> NetflowcongestionTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_flow_congestion_table_len(s : NetflowcongestionTable) -> Int { s.size }

pub fn net_flow_congestion_table_get(s : NetflowcongestionTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_flow_congestion_table_set(s : NetflowcongestionTable, i : Int, v : Double) -> NetflowcongestionTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn net_flow_congestion_table_sum(s : NetflowcongestionTable) -> Double { @_common.sum(s.data) }

pub fn net_flow_congestion_table_mean(s : NetflowcongestionTable) -> Double { @_common.mean(s.data) }

pub fn net_flow_congestion_table_scale(s : NetflowcongestionTable, f : Double) -> NetflowcongestionTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_flow_congestion_table_add(a : NetflowcongestionTable, b : NetflowcongestionTable) -> NetflowcongestionTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_flow_congestion_table_copy(s : NetflowcongestionTable) -> NetflowcongestionTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_flow_congestion_table_fill(s : NetflowcongestionTable, v : Double) -> NetflowcongestionTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_flow_congestion_table_min(s : NetflowcongestionTable) -> Double { @_common.min(s.data) }

pub fn net_flow_congestion_table_max(s : NetflowcongestionTable) -> Double { @_common.max(s.data) }

pub fn net_flow_congestion_table_to_string(s : NetflowcongestionTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetflowcongestionGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_flow_congestion_graphn_make(size : Int) -> NetflowcongestionGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_flow_congestion_graphn_len(s : NetflowcongestionGraphN) -> Int { s.size }

pub fn net_flow_congestion_graphn_get(s : NetflowcongestionGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_flow_congestion_graphn_set(s : NetflowcongestionGraphN, i : Int, v : Double) -> NetflowcongestionGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn net_flow_congestion_graphn_sum(s : NetflowcongestionGraphN) -> Double { @_common.sum(s.data) }

pub fn net_flow_congestion_graphn_mean(s : NetflowcongestionGraphN) -> Double { @_common.mean(s.data) }

pub fn net_flow_congestion_graphn_scale(s : NetflowcongestionGraphN, f : Double) -> NetflowcongestionGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_flow_congestion_graphn_add(a : NetflowcongestionGraphN, b : NetflowcongestionGraphN) -> NetflowcongestionGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_flow_congestion_graphn_copy(s : NetflowcongestionGraphN) -> NetflowcongestionGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_flow_congestion_graphn_fill(s : NetflowcongestionGraphN, v : Double) -> NetflowcongestionGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_flow_congestion_graphn_min(s : NetflowcongestionGraphN) -> Double { @_common.min(s.data) }

pub fn net_flow_congestion_graphn_max(s : NetflowcongestionGraphN) -> Double { @_common.max(s.data) }

pub fn net_flow_congestion_graphn_to_string(s : NetflowcongestionGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetflowcongestionNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_flow_congestion_node_make(size : Int) -> NetflowcongestionNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_flow_congestion_node_len(s : NetflowcongestionNode) -> Int { s.size }

pub fn net_flow_congestion_node_get(s : NetflowcongestionNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_flow_congestion_node_set(s : NetflowcongestionNode, i : Int, v : Double) -> NetflowcongestionNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn net_flow_congestion_node_sum(s : NetflowcongestionNode) -> Double { @_common.sum(s.data) }

pub fn net_flow_congestion_node_mean(s : NetflowcongestionNode) -> Double { @_common.mean(s.data) }

pub fn net_flow_congestion_node_scale(s : NetflowcongestionNode, f : Double) -> NetflowcongestionNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_flow_congestion_node_add(a : NetflowcongestionNode, b : NetflowcongestionNode) -> NetflowcongestionNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_flow_congestion_node_copy(s : NetflowcongestionNode) -> NetflowcongestionNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_flow_congestion_node_fill(s : NetflowcongestionNode, v : Double) -> NetflowcongestionNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_flow_congestion_node_min(s : NetflowcongestionNode) -> Double { @_common.min(s.data) }

pub fn net_flow_congestion_node_max(s : NetflowcongestionNode) -> Double { @_common.max(s.data) }

pub fn net_flow_congestion_node_to_string(s : NetflowcongestionNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetflowcongestionEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_flow_congestion_edge_make(size : Int) -> NetflowcongestionEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_flow_congestion_edge_len(s : NetflowcongestionEdge) -> Int { s.size }

pub fn net_flow_congestion_edge_get(s : NetflowcongestionEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_flow_congestion_edge_set(s : NetflowcongestionEdge, i : Int, v : Double) -> NetflowcongestionEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn net_flow_congestion_edge_sum(s : NetflowcongestionEdge) -> Double { @_common.sum(s.data) }

pub fn net_flow_congestion_edge_mean(s : NetflowcongestionEdge) -> Double { @_common.mean(s.data) }

pub fn net_flow_congestion_edge_scale(s : NetflowcongestionEdge, f : Double) -> NetflowcongestionEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_flow_congestion_edge_add(a : NetflowcongestionEdge, b : NetflowcongestionEdge) -> NetflowcongestionEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_flow_congestion_edge_copy(s : NetflowcongestionEdge) -> NetflowcongestionEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_flow_congestion_edge_fill(s : NetflowcongestionEdge, v : Double) -> NetflowcongestionEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_flow_congestion_edge_min(s : NetflowcongestionEdge) -> Double { @_common.min(s.data) }

pub fn net_flow_congestion_edge_max(s : NetflowcongestionEdge) -> Double { @_common.max(s.data) }

pub fn net_flow_congestion_edge_to_string(s : NetflowcongestionEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetflowcongestionPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_flow_congestion_path_make(size : Int) -> NetflowcongestionPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_flow_congestion_path_len(s : NetflowcongestionPath) -> Int { s.size }

pub fn net_flow_congestion_path_get(s : NetflowcongestionPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_flow_congestion_path_set(s : NetflowcongestionPath, i : Int, v : Double) -> NetflowcongestionPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn net_flow_congestion_path_sum(s : NetflowcongestionPath) -> Double { @_common.sum(s.data) }

pub fn net_flow_congestion_path_mean(s : NetflowcongestionPath) -> Double { @_common.mean(s.data) }

pub fn net_flow_congestion_path_scale(s : NetflowcongestionPath, f : Double) -> NetflowcongestionPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_flow_congestion_path_add(a : NetflowcongestionPath, b : NetflowcongestionPath) -> NetflowcongestionPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_flow_congestion_path_copy(s : NetflowcongestionPath) -> NetflowcongestionPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_flow_congestion_path_fill(s : NetflowcongestionPath, v : Double) -> NetflowcongestionPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_flow_congestion_path_min(s : NetflowcongestionPath) -> Double { @_common.min(s.data) }

pub fn net_flow_congestion_path_max(s : NetflowcongestionPath) -> Double { @_common.max(s.data) }

pub fn net_flow_congestion_path_to_string(s : NetflowcongestionPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetflowcongestionCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_flow_congestion_cluster_make(size : Int) -> NetflowcongestionCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_flow_congestion_cluster_len(s : NetflowcongestionCluster) -> Int { s.size }

pub fn net_flow_congestion_cluster_get(s : NetflowcongestionCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_flow_congestion_cluster_set(s : NetflowcongestionCluster, i : Int, v : Double) -> NetflowcongestionCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn net_flow_congestion_cluster_sum(s : NetflowcongestionCluster) -> Double { @_common.sum(s.data) }

pub fn net_flow_congestion_cluster_mean(s : NetflowcongestionCluster) -> Double { @_common.mean(s.data) }

pub fn net_flow_congestion_cluster_scale(s : NetflowcongestionCluster, f : Double) -> NetflowcongestionCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_flow_congestion_cluster_add(a : NetflowcongestionCluster, b : NetflowcongestionCluster) -> NetflowcongestionCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_flow_congestion_cluster_copy(s : NetflowcongestionCluster) -> NetflowcongestionCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_flow_congestion_cluster_fill(s : NetflowcongestionCluster, v : Double) -> NetflowcongestionCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_flow_congestion_cluster_min(s : NetflowcongestionCluster) -> Double { @_common.min(s.data) }

pub fn net_flow_congestion_cluster_max(s : NetflowcongestionCluster) -> Double { @_common.max(s.data) }

pub fn net_flow_congestion_cluster_to_string(s : NetflowcongestionCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetflowcongestionModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_flow_congestion_model_make(size : Int) -> NetflowcongestionModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_flow_congestion_model_len(s : NetflowcongestionModel) -> Int { s.size }

pub fn net_flow_congestion_model_get(s : NetflowcongestionModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_flow_congestion_model_set(s : NetflowcongestionModel, i : Int, v : Double) -> NetflowcongestionModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn net_flow_congestion_model_sum(s : NetflowcongestionModel) -> Double { @_common.sum(s.data) }

pub fn net_flow_congestion_model_mean(s : NetflowcongestionModel) -> Double { @_common.mean(s.data) }

pub fn net_flow_congestion_model_scale(s : NetflowcongestionModel, f : Double) -> NetflowcongestionModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_flow_congestion_model_add(a : NetflowcongestionModel, b : NetflowcongestionModel) -> NetflowcongestionModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_flow_congestion_model_copy(s : NetflowcongestionModel) -> NetflowcongestionModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_flow_congestion_model_fill(s : NetflowcongestionModel, v : Double) -> NetflowcongestionModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_flow_congestion_model_min(s : NetflowcongestionModel) -> Double { @_common.min(s.data) }

pub fn net_flow_congestion_model_max(s : NetflowcongestionModel) -> Double { @_common.max(s.data) }

pub fn net_flow_congestion_model_to_string(s : NetflowcongestionModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetflowcongestionLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_flow_congestion_layer_make(size : Int) -> NetflowcongestionLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_flow_congestion_layer_len(s : NetflowcongestionLayer) -> Int { s.size }

pub fn net_flow_congestion_layer_get(s : NetflowcongestionLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_flow_congestion_layer_set(s : NetflowcongestionLayer, i : Int, v : Double) -> NetflowcongestionLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn net_flow_congestion_layer_sum(s : NetflowcongestionLayer) -> Double { @_common.sum(s.data) }

pub fn net_flow_congestion_layer_mean(s : NetflowcongestionLayer) -> Double { @_common.mean(s.data) }

pub fn net_flow_congestion_layer_scale(s : NetflowcongestionLayer, f : Double) -> NetflowcongestionLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_flow_congestion_layer_add(a : NetflowcongestionLayer, b : NetflowcongestionLayer) -> NetflowcongestionLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_flow_congestion_layer_copy(s : NetflowcongestionLayer) -> NetflowcongestionLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_flow_congestion_layer_fill(s : NetflowcongestionLayer, v : Double) -> NetflowcongestionLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_flow_congestion_layer_min(s : NetflowcongestionLayer) -> Double { @_common.min(s.data) }

pub fn net_flow_congestion_layer_max(s : NetflowcongestionLayer) -> Double { @_common.max(s.data) }

pub fn net_flow_congestion_layer_to_string(s : NetflowcongestionLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetflowcongestionBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_flow_congestion_buffer_make(size : Int) -> NetflowcongestionBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_flow_congestion_buffer_len(s : NetflowcongestionBuffer) -> Int { s.size }

pub fn net_flow_congestion_buffer_get(s : NetflowcongestionBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_flow_congestion_buffer_set(s : NetflowcongestionBuffer, i : Int, v : Double) -> NetflowcongestionBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn net_flow_congestion_buffer_sum(s : NetflowcongestionBuffer) -> Double { @_common.sum(s.data) }

pub fn net_flow_congestion_buffer_mean(s : NetflowcongestionBuffer) -> Double { @_common.mean(s.data) }

pub fn net_flow_congestion_buffer_scale(s : NetflowcongestionBuffer, f : Double) -> NetflowcongestionBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_flow_congestion_buffer_add(a : NetflowcongestionBuffer, b : NetflowcongestionBuffer) -> NetflowcongestionBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_flow_congestion_buffer_copy(s : NetflowcongestionBuffer) -> NetflowcongestionBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_flow_congestion_buffer_fill(s : NetflowcongestionBuffer, v : Double) -> NetflowcongestionBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_flow_congestion_buffer_min(s : NetflowcongestionBuffer) -> Double { @_common.min(s.data) }

pub fn net_flow_congestion_buffer_max(s : NetflowcongestionBuffer) -> Double { @_common.max(s.data) }

pub fn net_flow_congestion_buffer_to_string(s : NetflowcongestionBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetflowcongestionCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_flow_congestion_cursor_make(size : Int) -> NetflowcongestionCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_flow_congestion_cursor_len(s : NetflowcongestionCursor) -> Int { s.size }

pub fn net_flow_congestion_cursor_get(s : NetflowcongestionCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_flow_congestion_cursor_set(s : NetflowcongestionCursor, i : Int, v : Double) -> NetflowcongestionCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn net_flow_congestion_cursor_sum(s : NetflowcongestionCursor) -> Double { @_common.sum(s.data) }

pub fn net_flow_congestion_cursor_mean(s : NetflowcongestionCursor) -> Double { @_common.mean(s.data) }

pub fn net_flow_congestion_cursor_scale(s : NetflowcongestionCursor, f : Double) -> NetflowcongestionCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_flow_congestion_cursor_add(a : NetflowcongestionCursor, b : NetflowcongestionCursor) -> NetflowcongestionCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_flow_congestion_cursor_copy(s : NetflowcongestionCursor) -> NetflowcongestionCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_flow_congestion_cursor_fill(s : NetflowcongestionCursor, v : Double) -> NetflowcongestionCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_flow_congestion_cursor_min(s : NetflowcongestionCursor) -> Double { @_common.min(s.data) }

pub fn net_flow_congestion_cursor_max(s : NetflowcongestionCursor) -> Double { @_common.max(s.data) }

pub fn net_flow_congestion_cursor_to_string(s : NetflowcongestionCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetflowcongestionView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_flow_congestion_view_make(size : Int) -> NetflowcongestionView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_flow_congestion_view_len(s : NetflowcongestionView) -> Int { s.size }

pub fn net_flow_congestion_view_get(s : NetflowcongestionView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_flow_congestion_view_set(s : NetflowcongestionView, i : Int, v : Double) -> NetflowcongestionView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn net_flow_congestion_view_sum(s : NetflowcongestionView) -> Double { @_common.sum(s.data) }

pub fn net_flow_congestion_view_mean(s : NetflowcongestionView) -> Double { @_common.mean(s.data) }

pub fn net_flow_congestion_view_scale(s : NetflowcongestionView, f : Double) -> NetflowcongestionView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_flow_congestion_view_add(a : NetflowcongestionView, b : NetflowcongestionView) -> NetflowcongestionView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_flow_congestion_view_copy(s : NetflowcongestionView) -> NetflowcongestionView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_flow_congestion_view_fill(s : NetflowcongestionView, v : Double) -> NetflowcongestionView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_flow_congestion_view_min(s : NetflowcongestionView) -> Double { @_common.min(s.data) }

pub fn net_flow_congestion_view_max(s : NetflowcongestionView) -> Double { @_common.max(s.data) }

pub fn net_flow_congestion_view_to_string(s : NetflowcongestionView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetflowcongestionRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_flow_congestion_range_make(size : Int) -> NetflowcongestionRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_flow_congestion_range_len(s : NetflowcongestionRange) -> Int { s.size }

pub fn net_flow_congestion_range_get(s : NetflowcongestionRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_flow_congestion_range_set(s : NetflowcongestionRange, i : Int, v : Double) -> NetflowcongestionRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn net_flow_congestion_range_sum(s : NetflowcongestionRange) -> Double { @_common.sum(s.data) }

pub fn net_flow_congestion_range_mean(s : NetflowcongestionRange) -> Double { @_common.mean(s.data) }

pub fn net_flow_congestion_range_scale(s : NetflowcongestionRange, f : Double) -> NetflowcongestionRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_flow_congestion_range_add(a : NetflowcongestionRange, b : NetflowcongestionRange) -> NetflowcongestionRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_flow_congestion_range_copy(s : NetflowcongestionRange) -> NetflowcongestionRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_flow_congestion_range_fill(s : NetflowcongestionRange, v : Double) -> NetflowcongestionRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_flow_congestion_range_min(s : NetflowcongestionRange) -> Double { @_common.min(s.data) }

pub fn net_flow_congestion_range_max(s : NetflowcongestionRange) -> Double { @_common.max(s.data) }

pub fn net_flow_congestion_range_to_string(s : NetflowcongestionRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetflowcongestionSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_flow_congestion_slice_make(size : Int) -> NetflowcongestionSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_flow_congestion_slice_len(s : NetflowcongestionSlice) -> Int { s.size }

pub fn net_flow_congestion_slice_get(s : NetflowcongestionSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_flow_congestion_slice_set(s : NetflowcongestionSlice, i : Int, v : Double) -> NetflowcongestionSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn net_flow_congestion_slice_sum(s : NetflowcongestionSlice) -> Double { @_common.sum(s.data) }

pub fn net_flow_congestion_slice_mean(s : NetflowcongestionSlice) -> Double { @_common.mean(s.data) }

pub fn net_flow_congestion_slice_scale(s : NetflowcongestionSlice, f : Double) -> NetflowcongestionSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_flow_congestion_slice_add(a : NetflowcongestionSlice, b : NetflowcongestionSlice) -> NetflowcongestionSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_flow_congestion_slice_copy(s : NetflowcongestionSlice) -> NetflowcongestionSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_flow_congestion_slice_fill(s : NetflowcongestionSlice, v : Double) -> NetflowcongestionSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_flow_congestion_slice_min(s : NetflowcongestionSlice) -> Double { @_common.min(s.data) }

pub fn net_flow_congestion_slice_max(s : NetflowcongestionSlice) -> Double { @_common.max(s.data) }

pub fn net_flow_congestion_slice_to_string(s : NetflowcongestionSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

