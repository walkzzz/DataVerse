///===
/// extcore/net_flow_admission

pub(all) struct NetflowadmissionPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn net_flow_admission_make_point(x : Double, y : Double) -> NetflowadmissionPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn net_flow_admission_make_point3(x : Double, y : Double, z : Double) -> NetflowadmissionPoint {
  { x, y, z, label: 0 }
}

pub fn NetflowadmissionPoint::x(self : NetflowadmissionPoint) -> Double { self.x }

pub fn NetflowadmissionPoint::y(self : NetflowadmissionPoint) -> Double { self.y }

pub fn NetflowadmissionPoint::z(self : NetflowadmissionPoint) -> Double { self.z }

pub fn NetflowadmissionPoint::label(self : NetflowadmissionPoint) -> Int { self.label }

pub fn NetflowadmissionPoint::dist(self : NetflowadmissionPoint, other : NetflowadmissionPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn NetflowadmissionPoint::add(self : NetflowadmissionPoint, other : NetflowadmissionPoint) -> NetflowadmissionPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn NetflowadmissionPoint::sub(self : NetflowadmissionPoint, other : NetflowadmissionPoint) -> NetflowadmissionPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn NetflowadmissionPoint::scale(self : NetflowadmissionPoint, s : Double) -> NetflowadmissionPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn NetflowadmissionPoint::dot(self : NetflowadmissionPoint, other : NetflowadmissionPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn NetflowadmissionPoint::cross(self : NetflowadmissionPoint, other : NetflowadmissionPoint) -> NetflowadmissionPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn NetflowadmissionPoint::norm(self : NetflowadmissionPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn NetflowadmissionPoint::normalize(self : NetflowadmissionPoint) -> NetflowadmissionPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn NetflowadmissionPoint::negate(self : NetflowadmissionPoint) -> NetflowadmissionPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn NetflowadmissionPoint::mid(self : NetflowadmissionPoint, other : NetflowadmissionPoint) -> NetflowadmissionPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn NetflowadmissionPoint::lerp(self : NetflowadmissionPoint, other : NetflowadmissionPoint, t : Double) -> NetflowadmissionPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn NetflowadmissionPoint::to_string(self : NetflowadmissionPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct NetflowadmissionSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn net_flow_admission_make_series(vals : Array[Double], name : String) -> NetflowadmissionSeries {
  { vals, name, meta: 0 }
}

pub fn NetflowadmissionSeries::len(self : NetflowadmissionSeries) -> Int { self.vals.length() }

pub fn NetflowadmissionSeries::sum(self : NetflowadmissionSeries) -> Double { @_common.sum(self.vals) }

pub fn NetflowadmissionSeries::mean(self : NetflowadmissionSeries) -> Double { @_common.mean(self.vals) }

pub fn NetflowadmissionSeries::min(self : NetflowadmissionSeries) -> Double { @_common.min(self.vals) }

pub fn NetflowadmissionSeries::max(self : NetflowadmissionSeries) -> Double { @_common.max(self.vals) }

pub fn NetflowadmissionSeries::range(self : NetflowadmissionSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn NetflowadmissionSeries::variance(self : NetflowadmissionSeries) -> Double { @_common.variance(self.vals) }

pub fn NetflowadmissionSeries::std(self : NetflowadmissionSeries) -> Double { @_common.std(self.vals) }

pub fn NetflowadmissionSeries::median(self : NetflowadmissionSeries) -> Double { @_common.median(self.vals) }

pub fn NetflowadmissionSeries::scale(self : NetflowadmissionSeries, f : Double) -> NetflowadmissionSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn NetflowadmissionSeries::add(self : NetflowadmissionSeries, other : NetflowadmissionSeries) -> NetflowadmissionSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn NetflowadmissionSeries::sub(self : NetflowadmissionSeries, other : NetflowadmissionSeries) -> NetflowadmissionSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn NetflowadmissionSeries::normalize(self : NetflowadmissionSeries) -> NetflowadmissionSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn NetflowadmissionSeries::cumsum(self : NetflowadmissionSeries) -> NetflowadmissionSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn NetflowadmissionSeries::to_string(self : NetflowadmissionSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct NetflowadmissionMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn net_flow_admission_make_matrix(rows : Int, cols : Int, val : Double) -> NetflowadmissionMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn net_flow_admission_matrix_identity(n : Int) -> NetflowadmissionMatrix {
  let m = net_flow_admission_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn NetflowadmissionMatrix::get(self : NetflowadmissionMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn NetflowadmissionMatrix::transpose(self : NetflowadmissionMatrix) -> NetflowadmissionMatrix {
  let result = net_flow_admission_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn NetflowadmissionMatrix::add(self : NetflowadmissionMatrix, other : NetflowadmissionMatrix) -> NetflowadmissionMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = net_flow_admission_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn NetflowadmissionMatrix::scale(self : NetflowadmissionMatrix, s : Double) -> NetflowadmissionMatrix {
  let result = net_flow_admission_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn NetflowadmissionMatrix::multiply(self : NetflowadmissionMatrix, other : NetflowadmissionMatrix) -> NetflowadmissionMatrix {
  if self.cols != other.rows { return net_flow_admission_make_matrix(self.rows, other.cols, 0.0) }
  let result = net_flow_admission_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn NetflowadmissionMatrix::trace(self : NetflowadmissionMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn NetflowadmissionMatrix::det(self : NetflowadmissionMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn NetflowadmissionMatrix::norm(self : NetflowadmissionMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn NetflowadmissionMatrix::to_string(self : NetflowadmissionMatrix) -> String {
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

pub(all) struct NetflowadmissionVector {
  comps : Array[Double]
  dim : Int
}

pub fn net_flow_admission_make_vector(comps : Array[Double]) -> NetflowadmissionVector {
  { comps, dim: comps.length() }
}

pub fn net_flow_admission_vector_zero(dim : Int) -> NetflowadmissionVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn NetflowadmissionVector::add(self : NetflowadmissionVector, other : NetflowadmissionVector) -> NetflowadmissionVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn NetflowadmissionVector::sub(self : NetflowadmissionVector, other : NetflowadmissionVector) -> NetflowadmissionVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn NetflowadmissionVector::scale(self : NetflowadmissionVector, s : Double) -> NetflowadmissionVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn NetflowadmissionVector::dot(self : NetflowadmissionVector, other : NetflowadmissionVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn NetflowadmissionVector::norm(self : NetflowadmissionVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn NetflowadmissionVector::normalize(self : NetflowadmissionVector) -> NetflowadmissionVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn NetflowadmissionVector::dist(self : NetflowadmissionVector, other : NetflowadmissionVector) -> Double {
  self.sub(other).norm()
}

pub fn NetflowadmissionVector::to_string(self : NetflowadmissionVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn net_flow_admission_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn net_flow_admission_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn net_flow_admission_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn net_flow_admission_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn net_flow_admission_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn net_flow_admission_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn net_flow_admission_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn net_flow_admission_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn net_flow_admission_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn net_flow_admission_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn net_flow_admission_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn net_flow_admission_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn net_flow_admission_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn net_flow_admission_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn net_flow_admission_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn net_flow_admission_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn net_flow_admission_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn net_flow_admission_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn net_flow_admission_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn net_flow_admission_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn net_flow_admission_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn net_flow_admission_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn net_flow_admission_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn net_flow_admission_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn net_flow_admission_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn net_flow_admission_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn net_flow_admission_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn net_flow_admission_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn net_flow_admission_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct NetflowadmissionFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_flow_admission_frame_make(size : Int) -> NetflowadmissionFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_flow_admission_frame_len(s : NetflowadmissionFrame) -> Int { s.size }

pub fn net_flow_admission_frame_get(s : NetflowadmissionFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_flow_admission_frame_set(s : NetflowadmissionFrame, i : Int, v : Double) -> NetflowadmissionFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn net_flow_admission_frame_sum(s : NetflowadmissionFrame) -> Double { @_common.sum(s.data) }

pub fn net_flow_admission_frame_mean(s : NetflowadmissionFrame) -> Double { @_common.mean(s.data) }

pub fn net_flow_admission_frame_scale(s : NetflowadmissionFrame, f : Double) -> NetflowadmissionFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_flow_admission_frame_add(a : NetflowadmissionFrame, b : NetflowadmissionFrame) -> NetflowadmissionFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_flow_admission_frame_copy(s : NetflowadmissionFrame) -> NetflowadmissionFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_flow_admission_frame_fill(s : NetflowadmissionFrame, v : Double) -> NetflowadmissionFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_flow_admission_frame_min(s : NetflowadmissionFrame) -> Double { @_common.min(s.data) }

pub fn net_flow_admission_frame_max(s : NetflowadmissionFrame) -> Double { @_common.max(s.data) }

pub fn net_flow_admission_frame_to_string(s : NetflowadmissionFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetflowadmissionTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_flow_admission_table_make(size : Int) -> NetflowadmissionTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_flow_admission_table_len(s : NetflowadmissionTable) -> Int { s.size }

pub fn net_flow_admission_table_get(s : NetflowadmissionTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_flow_admission_table_set(s : NetflowadmissionTable, i : Int, v : Double) -> NetflowadmissionTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn net_flow_admission_table_sum(s : NetflowadmissionTable) -> Double { @_common.sum(s.data) }

pub fn net_flow_admission_table_mean(s : NetflowadmissionTable) -> Double { @_common.mean(s.data) }

pub fn net_flow_admission_table_scale(s : NetflowadmissionTable, f : Double) -> NetflowadmissionTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_flow_admission_table_add(a : NetflowadmissionTable, b : NetflowadmissionTable) -> NetflowadmissionTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_flow_admission_table_copy(s : NetflowadmissionTable) -> NetflowadmissionTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_flow_admission_table_fill(s : NetflowadmissionTable, v : Double) -> NetflowadmissionTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_flow_admission_table_min(s : NetflowadmissionTable) -> Double { @_common.min(s.data) }

pub fn net_flow_admission_table_max(s : NetflowadmissionTable) -> Double { @_common.max(s.data) }

pub fn net_flow_admission_table_to_string(s : NetflowadmissionTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetflowadmissionGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_flow_admission_graphn_make(size : Int) -> NetflowadmissionGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_flow_admission_graphn_len(s : NetflowadmissionGraphN) -> Int { s.size }

pub fn net_flow_admission_graphn_get(s : NetflowadmissionGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_flow_admission_graphn_set(s : NetflowadmissionGraphN, i : Int, v : Double) -> NetflowadmissionGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn net_flow_admission_graphn_sum(s : NetflowadmissionGraphN) -> Double { @_common.sum(s.data) }

pub fn net_flow_admission_graphn_mean(s : NetflowadmissionGraphN) -> Double { @_common.mean(s.data) }

pub fn net_flow_admission_graphn_scale(s : NetflowadmissionGraphN, f : Double) -> NetflowadmissionGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_flow_admission_graphn_add(a : NetflowadmissionGraphN, b : NetflowadmissionGraphN) -> NetflowadmissionGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_flow_admission_graphn_copy(s : NetflowadmissionGraphN) -> NetflowadmissionGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_flow_admission_graphn_fill(s : NetflowadmissionGraphN, v : Double) -> NetflowadmissionGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_flow_admission_graphn_min(s : NetflowadmissionGraphN) -> Double { @_common.min(s.data) }

pub fn net_flow_admission_graphn_max(s : NetflowadmissionGraphN) -> Double { @_common.max(s.data) }

pub fn net_flow_admission_graphn_to_string(s : NetflowadmissionGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetflowadmissionNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_flow_admission_node_make(size : Int) -> NetflowadmissionNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_flow_admission_node_len(s : NetflowadmissionNode) -> Int { s.size }

pub fn net_flow_admission_node_get(s : NetflowadmissionNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_flow_admission_node_set(s : NetflowadmissionNode, i : Int, v : Double) -> NetflowadmissionNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn net_flow_admission_node_sum(s : NetflowadmissionNode) -> Double { @_common.sum(s.data) }

pub fn net_flow_admission_node_mean(s : NetflowadmissionNode) -> Double { @_common.mean(s.data) }

pub fn net_flow_admission_node_scale(s : NetflowadmissionNode, f : Double) -> NetflowadmissionNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_flow_admission_node_add(a : NetflowadmissionNode, b : NetflowadmissionNode) -> NetflowadmissionNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_flow_admission_node_copy(s : NetflowadmissionNode) -> NetflowadmissionNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_flow_admission_node_fill(s : NetflowadmissionNode, v : Double) -> NetflowadmissionNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_flow_admission_node_min(s : NetflowadmissionNode) -> Double { @_common.min(s.data) }

pub fn net_flow_admission_node_max(s : NetflowadmissionNode) -> Double { @_common.max(s.data) }

pub fn net_flow_admission_node_to_string(s : NetflowadmissionNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetflowadmissionEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_flow_admission_edge_make(size : Int) -> NetflowadmissionEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_flow_admission_edge_len(s : NetflowadmissionEdge) -> Int { s.size }

pub fn net_flow_admission_edge_get(s : NetflowadmissionEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_flow_admission_edge_set(s : NetflowadmissionEdge, i : Int, v : Double) -> NetflowadmissionEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn net_flow_admission_edge_sum(s : NetflowadmissionEdge) -> Double { @_common.sum(s.data) }

pub fn net_flow_admission_edge_mean(s : NetflowadmissionEdge) -> Double { @_common.mean(s.data) }

pub fn net_flow_admission_edge_scale(s : NetflowadmissionEdge, f : Double) -> NetflowadmissionEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_flow_admission_edge_add(a : NetflowadmissionEdge, b : NetflowadmissionEdge) -> NetflowadmissionEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_flow_admission_edge_copy(s : NetflowadmissionEdge) -> NetflowadmissionEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_flow_admission_edge_fill(s : NetflowadmissionEdge, v : Double) -> NetflowadmissionEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_flow_admission_edge_min(s : NetflowadmissionEdge) -> Double { @_common.min(s.data) }

pub fn net_flow_admission_edge_max(s : NetflowadmissionEdge) -> Double { @_common.max(s.data) }

pub fn net_flow_admission_edge_to_string(s : NetflowadmissionEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetflowadmissionPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_flow_admission_path_make(size : Int) -> NetflowadmissionPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_flow_admission_path_len(s : NetflowadmissionPath) -> Int { s.size }

pub fn net_flow_admission_path_get(s : NetflowadmissionPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_flow_admission_path_set(s : NetflowadmissionPath, i : Int, v : Double) -> NetflowadmissionPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn net_flow_admission_path_sum(s : NetflowadmissionPath) -> Double { @_common.sum(s.data) }

pub fn net_flow_admission_path_mean(s : NetflowadmissionPath) -> Double { @_common.mean(s.data) }

pub fn net_flow_admission_path_scale(s : NetflowadmissionPath, f : Double) -> NetflowadmissionPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_flow_admission_path_add(a : NetflowadmissionPath, b : NetflowadmissionPath) -> NetflowadmissionPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_flow_admission_path_copy(s : NetflowadmissionPath) -> NetflowadmissionPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_flow_admission_path_fill(s : NetflowadmissionPath, v : Double) -> NetflowadmissionPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_flow_admission_path_min(s : NetflowadmissionPath) -> Double { @_common.min(s.data) }

pub fn net_flow_admission_path_max(s : NetflowadmissionPath) -> Double { @_common.max(s.data) }

pub fn net_flow_admission_path_to_string(s : NetflowadmissionPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetflowadmissionCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_flow_admission_cluster_make(size : Int) -> NetflowadmissionCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_flow_admission_cluster_len(s : NetflowadmissionCluster) -> Int { s.size }

pub fn net_flow_admission_cluster_get(s : NetflowadmissionCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_flow_admission_cluster_set(s : NetflowadmissionCluster, i : Int, v : Double) -> NetflowadmissionCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn net_flow_admission_cluster_sum(s : NetflowadmissionCluster) -> Double { @_common.sum(s.data) }

pub fn net_flow_admission_cluster_mean(s : NetflowadmissionCluster) -> Double { @_common.mean(s.data) }

pub fn net_flow_admission_cluster_scale(s : NetflowadmissionCluster, f : Double) -> NetflowadmissionCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_flow_admission_cluster_add(a : NetflowadmissionCluster, b : NetflowadmissionCluster) -> NetflowadmissionCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_flow_admission_cluster_copy(s : NetflowadmissionCluster) -> NetflowadmissionCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_flow_admission_cluster_fill(s : NetflowadmissionCluster, v : Double) -> NetflowadmissionCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_flow_admission_cluster_min(s : NetflowadmissionCluster) -> Double { @_common.min(s.data) }

pub fn net_flow_admission_cluster_max(s : NetflowadmissionCluster) -> Double { @_common.max(s.data) }

pub fn net_flow_admission_cluster_to_string(s : NetflowadmissionCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetflowadmissionModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_flow_admission_model_make(size : Int) -> NetflowadmissionModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_flow_admission_model_len(s : NetflowadmissionModel) -> Int { s.size }

pub fn net_flow_admission_model_get(s : NetflowadmissionModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_flow_admission_model_set(s : NetflowadmissionModel, i : Int, v : Double) -> NetflowadmissionModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn net_flow_admission_model_sum(s : NetflowadmissionModel) -> Double { @_common.sum(s.data) }

pub fn net_flow_admission_model_mean(s : NetflowadmissionModel) -> Double { @_common.mean(s.data) }

pub fn net_flow_admission_model_scale(s : NetflowadmissionModel, f : Double) -> NetflowadmissionModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_flow_admission_model_add(a : NetflowadmissionModel, b : NetflowadmissionModel) -> NetflowadmissionModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_flow_admission_model_copy(s : NetflowadmissionModel) -> NetflowadmissionModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_flow_admission_model_fill(s : NetflowadmissionModel, v : Double) -> NetflowadmissionModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_flow_admission_model_min(s : NetflowadmissionModel) -> Double { @_common.min(s.data) }

pub fn net_flow_admission_model_max(s : NetflowadmissionModel) -> Double { @_common.max(s.data) }

pub fn net_flow_admission_model_to_string(s : NetflowadmissionModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetflowadmissionLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_flow_admission_layer_make(size : Int) -> NetflowadmissionLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_flow_admission_layer_len(s : NetflowadmissionLayer) -> Int { s.size }

pub fn net_flow_admission_layer_get(s : NetflowadmissionLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_flow_admission_layer_set(s : NetflowadmissionLayer, i : Int, v : Double) -> NetflowadmissionLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn net_flow_admission_layer_sum(s : NetflowadmissionLayer) -> Double { @_common.sum(s.data) }

pub fn net_flow_admission_layer_mean(s : NetflowadmissionLayer) -> Double { @_common.mean(s.data) }

pub fn net_flow_admission_layer_scale(s : NetflowadmissionLayer, f : Double) -> NetflowadmissionLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_flow_admission_layer_add(a : NetflowadmissionLayer, b : NetflowadmissionLayer) -> NetflowadmissionLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_flow_admission_layer_copy(s : NetflowadmissionLayer) -> NetflowadmissionLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_flow_admission_layer_fill(s : NetflowadmissionLayer, v : Double) -> NetflowadmissionLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_flow_admission_layer_min(s : NetflowadmissionLayer) -> Double { @_common.min(s.data) }

pub fn net_flow_admission_layer_max(s : NetflowadmissionLayer) -> Double { @_common.max(s.data) }

pub fn net_flow_admission_layer_to_string(s : NetflowadmissionLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetflowadmissionBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_flow_admission_buffer_make(size : Int) -> NetflowadmissionBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_flow_admission_buffer_len(s : NetflowadmissionBuffer) -> Int { s.size }

pub fn net_flow_admission_buffer_get(s : NetflowadmissionBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_flow_admission_buffer_set(s : NetflowadmissionBuffer, i : Int, v : Double) -> NetflowadmissionBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn net_flow_admission_buffer_sum(s : NetflowadmissionBuffer) -> Double { @_common.sum(s.data) }

pub fn net_flow_admission_buffer_mean(s : NetflowadmissionBuffer) -> Double { @_common.mean(s.data) }

pub fn net_flow_admission_buffer_scale(s : NetflowadmissionBuffer, f : Double) -> NetflowadmissionBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_flow_admission_buffer_add(a : NetflowadmissionBuffer, b : NetflowadmissionBuffer) -> NetflowadmissionBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_flow_admission_buffer_copy(s : NetflowadmissionBuffer) -> NetflowadmissionBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_flow_admission_buffer_fill(s : NetflowadmissionBuffer, v : Double) -> NetflowadmissionBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_flow_admission_buffer_min(s : NetflowadmissionBuffer) -> Double { @_common.min(s.data) }

pub fn net_flow_admission_buffer_max(s : NetflowadmissionBuffer) -> Double { @_common.max(s.data) }

pub fn net_flow_admission_buffer_to_string(s : NetflowadmissionBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetflowadmissionCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_flow_admission_cursor_make(size : Int) -> NetflowadmissionCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_flow_admission_cursor_len(s : NetflowadmissionCursor) -> Int { s.size }

pub fn net_flow_admission_cursor_get(s : NetflowadmissionCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_flow_admission_cursor_set(s : NetflowadmissionCursor, i : Int, v : Double) -> NetflowadmissionCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn net_flow_admission_cursor_sum(s : NetflowadmissionCursor) -> Double { @_common.sum(s.data) }

pub fn net_flow_admission_cursor_mean(s : NetflowadmissionCursor) -> Double { @_common.mean(s.data) }

pub fn net_flow_admission_cursor_scale(s : NetflowadmissionCursor, f : Double) -> NetflowadmissionCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_flow_admission_cursor_add(a : NetflowadmissionCursor, b : NetflowadmissionCursor) -> NetflowadmissionCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_flow_admission_cursor_copy(s : NetflowadmissionCursor) -> NetflowadmissionCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_flow_admission_cursor_fill(s : NetflowadmissionCursor, v : Double) -> NetflowadmissionCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_flow_admission_cursor_min(s : NetflowadmissionCursor) -> Double { @_common.min(s.data) }

pub fn net_flow_admission_cursor_max(s : NetflowadmissionCursor) -> Double { @_common.max(s.data) }

pub fn net_flow_admission_cursor_to_string(s : NetflowadmissionCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetflowadmissionView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_flow_admission_view_make(size : Int) -> NetflowadmissionView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_flow_admission_view_len(s : NetflowadmissionView) -> Int { s.size }

pub fn net_flow_admission_view_get(s : NetflowadmissionView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_flow_admission_view_set(s : NetflowadmissionView, i : Int, v : Double) -> NetflowadmissionView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn net_flow_admission_view_sum(s : NetflowadmissionView) -> Double { @_common.sum(s.data) }

pub fn net_flow_admission_view_mean(s : NetflowadmissionView) -> Double { @_common.mean(s.data) }

pub fn net_flow_admission_view_scale(s : NetflowadmissionView, f : Double) -> NetflowadmissionView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_flow_admission_view_add(a : NetflowadmissionView, b : NetflowadmissionView) -> NetflowadmissionView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_flow_admission_view_copy(s : NetflowadmissionView) -> NetflowadmissionView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_flow_admission_view_fill(s : NetflowadmissionView, v : Double) -> NetflowadmissionView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_flow_admission_view_min(s : NetflowadmissionView) -> Double { @_common.min(s.data) }

pub fn net_flow_admission_view_max(s : NetflowadmissionView) -> Double { @_common.max(s.data) }

pub fn net_flow_admission_view_to_string(s : NetflowadmissionView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetflowadmissionRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_flow_admission_range_make(size : Int) -> NetflowadmissionRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_flow_admission_range_len(s : NetflowadmissionRange) -> Int { s.size }

pub fn net_flow_admission_range_get(s : NetflowadmissionRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_flow_admission_range_set(s : NetflowadmissionRange, i : Int, v : Double) -> NetflowadmissionRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn net_flow_admission_range_sum(s : NetflowadmissionRange) -> Double { @_common.sum(s.data) }

pub fn net_flow_admission_range_mean(s : NetflowadmissionRange) -> Double { @_common.mean(s.data) }

pub fn net_flow_admission_range_scale(s : NetflowadmissionRange, f : Double) -> NetflowadmissionRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_flow_admission_range_add(a : NetflowadmissionRange, b : NetflowadmissionRange) -> NetflowadmissionRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_flow_admission_range_copy(s : NetflowadmissionRange) -> NetflowadmissionRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_flow_admission_range_fill(s : NetflowadmissionRange, v : Double) -> NetflowadmissionRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_flow_admission_range_min(s : NetflowadmissionRange) -> Double { @_common.min(s.data) }

pub fn net_flow_admission_range_max(s : NetflowadmissionRange) -> Double { @_common.max(s.data) }

pub fn net_flow_admission_range_to_string(s : NetflowadmissionRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetflowadmissionSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_flow_admission_slice_make(size : Int) -> NetflowadmissionSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_flow_admission_slice_len(s : NetflowadmissionSlice) -> Int { s.size }

pub fn net_flow_admission_slice_get(s : NetflowadmissionSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_flow_admission_slice_set(s : NetflowadmissionSlice, i : Int, v : Double) -> NetflowadmissionSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn net_flow_admission_slice_sum(s : NetflowadmissionSlice) -> Double { @_common.sum(s.data) }

pub fn net_flow_admission_slice_mean(s : NetflowadmissionSlice) -> Double { @_common.mean(s.data) }

pub fn net_flow_admission_slice_scale(s : NetflowadmissionSlice, f : Double) -> NetflowadmissionSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_flow_admission_slice_add(a : NetflowadmissionSlice, b : NetflowadmissionSlice) -> NetflowadmissionSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_flow_admission_slice_copy(s : NetflowadmissionSlice) -> NetflowadmissionSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_flow_admission_slice_fill(s : NetflowadmissionSlice, v : Double) -> NetflowadmissionSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_flow_admission_slice_min(s : NetflowadmissionSlice) -> Double { @_common.min(s.data) }

pub fn net_flow_admission_slice_max(s : NetflowadmissionSlice) -> Double { @_common.max(s.data) }

pub fn net_flow_admission_slice_to_string(s : NetflowadmissionSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

