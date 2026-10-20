///===
/// extcore/net_sec_ips

pub(all) struct NetsecipsPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn net_sec_ips_make_point(x : Double, y : Double) -> NetsecipsPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn net_sec_ips_make_point3(x : Double, y : Double, z : Double) -> NetsecipsPoint {
  { x, y, z, label: 0 }
}

pub fn NetsecipsPoint::x(self : NetsecipsPoint) -> Double { self.x }

pub fn NetsecipsPoint::y(self : NetsecipsPoint) -> Double { self.y }

pub fn NetsecipsPoint::z(self : NetsecipsPoint) -> Double { self.z }

pub fn NetsecipsPoint::label(self : NetsecipsPoint) -> Int { self.label }

pub fn NetsecipsPoint::dist(self : NetsecipsPoint, other : NetsecipsPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn NetsecipsPoint::add(self : NetsecipsPoint, other : NetsecipsPoint) -> NetsecipsPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn NetsecipsPoint::sub(self : NetsecipsPoint, other : NetsecipsPoint) -> NetsecipsPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn NetsecipsPoint::scale(self : NetsecipsPoint, s : Double) -> NetsecipsPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn NetsecipsPoint::dot(self : NetsecipsPoint, other : NetsecipsPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn NetsecipsPoint::cross(self : NetsecipsPoint, other : NetsecipsPoint) -> NetsecipsPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn NetsecipsPoint::norm(self : NetsecipsPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn NetsecipsPoint::normalize(self : NetsecipsPoint) -> NetsecipsPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn NetsecipsPoint::negate(self : NetsecipsPoint) -> NetsecipsPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn NetsecipsPoint::mid(self : NetsecipsPoint, other : NetsecipsPoint) -> NetsecipsPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn NetsecipsPoint::lerp(self : NetsecipsPoint, other : NetsecipsPoint, t : Double) -> NetsecipsPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn NetsecipsPoint::to_string(self : NetsecipsPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct NetsecipsSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn net_sec_ips_make_series(vals : Array[Double], name : String) -> NetsecipsSeries {
  { vals, name, meta: 0 }
}

pub fn NetsecipsSeries::len(self : NetsecipsSeries) -> Int { self.vals.length() }

pub fn NetsecipsSeries::sum(self : NetsecipsSeries) -> Double { @_common.sum(self.vals) }

pub fn NetsecipsSeries::mean(self : NetsecipsSeries) -> Double { @_common.mean(self.vals) }

pub fn NetsecipsSeries::min(self : NetsecipsSeries) -> Double { @_common.min(self.vals) }

pub fn NetsecipsSeries::max(self : NetsecipsSeries) -> Double { @_common.max(self.vals) }

pub fn NetsecipsSeries::range(self : NetsecipsSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn NetsecipsSeries::variance(self : NetsecipsSeries) -> Double { @_common.variance(self.vals) }

pub fn NetsecipsSeries::std(self : NetsecipsSeries) -> Double { @_common.std(self.vals) }

pub fn NetsecipsSeries::median(self : NetsecipsSeries) -> Double { @_common.median(self.vals) }

pub fn NetsecipsSeries::scale(self : NetsecipsSeries, f : Double) -> NetsecipsSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn NetsecipsSeries::add(self : NetsecipsSeries, other : NetsecipsSeries) -> NetsecipsSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn NetsecipsSeries::sub(self : NetsecipsSeries, other : NetsecipsSeries) -> NetsecipsSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn NetsecipsSeries::normalize(self : NetsecipsSeries) -> NetsecipsSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn NetsecipsSeries::cumsum(self : NetsecipsSeries) -> NetsecipsSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn NetsecipsSeries::to_string(self : NetsecipsSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct NetsecipsMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn net_sec_ips_make_matrix(rows : Int, cols : Int, val : Double) -> NetsecipsMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn net_sec_ips_matrix_identity(n : Int) -> NetsecipsMatrix {
  let m = net_sec_ips_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn NetsecipsMatrix::get(self : NetsecipsMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn NetsecipsMatrix::transpose(self : NetsecipsMatrix) -> NetsecipsMatrix {
  let result = net_sec_ips_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn NetsecipsMatrix::add(self : NetsecipsMatrix, other : NetsecipsMatrix) -> NetsecipsMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = net_sec_ips_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn NetsecipsMatrix::scale(self : NetsecipsMatrix, s : Double) -> NetsecipsMatrix {
  let result = net_sec_ips_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn NetsecipsMatrix::multiply(self : NetsecipsMatrix, other : NetsecipsMatrix) -> NetsecipsMatrix {
  if self.cols != other.rows { return net_sec_ips_make_matrix(self.rows, other.cols, 0.0) }
  let result = net_sec_ips_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn NetsecipsMatrix::trace(self : NetsecipsMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn NetsecipsMatrix::det(self : NetsecipsMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn NetsecipsMatrix::norm(self : NetsecipsMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn NetsecipsMatrix::to_string(self : NetsecipsMatrix) -> String {
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

pub(all) struct NetsecipsVector {
  comps : Array[Double]
  dim : Int
}

pub fn net_sec_ips_make_vector(comps : Array[Double]) -> NetsecipsVector {
  { comps, dim: comps.length() }
}

pub fn net_sec_ips_vector_zero(dim : Int) -> NetsecipsVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn NetsecipsVector::add(self : NetsecipsVector, other : NetsecipsVector) -> NetsecipsVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn NetsecipsVector::sub(self : NetsecipsVector, other : NetsecipsVector) -> NetsecipsVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn NetsecipsVector::scale(self : NetsecipsVector, s : Double) -> NetsecipsVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn NetsecipsVector::dot(self : NetsecipsVector, other : NetsecipsVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn NetsecipsVector::norm(self : NetsecipsVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn NetsecipsVector::normalize(self : NetsecipsVector) -> NetsecipsVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn NetsecipsVector::dist(self : NetsecipsVector, other : NetsecipsVector) -> Double {
  self.sub(other).norm()
}

pub fn NetsecipsVector::to_string(self : NetsecipsVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn net_sec_ips_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn net_sec_ips_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn net_sec_ips_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn net_sec_ips_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn net_sec_ips_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn net_sec_ips_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn net_sec_ips_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn net_sec_ips_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn net_sec_ips_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn net_sec_ips_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn net_sec_ips_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn net_sec_ips_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn net_sec_ips_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn net_sec_ips_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn net_sec_ips_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn net_sec_ips_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn net_sec_ips_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn net_sec_ips_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn net_sec_ips_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn net_sec_ips_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn net_sec_ips_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn net_sec_ips_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn net_sec_ips_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn net_sec_ips_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn net_sec_ips_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn net_sec_ips_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn net_sec_ips_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn net_sec_ips_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn net_sec_ips_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct NetsecipsFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_sec_ips_frame_make(size : Int) -> NetsecipsFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_sec_ips_frame_len(s : NetsecipsFrame) -> Int { s.size }

pub fn net_sec_ips_frame_get(s : NetsecipsFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_sec_ips_frame_set(s : NetsecipsFrame, i : Int, v : Double) -> NetsecipsFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn net_sec_ips_frame_sum(s : NetsecipsFrame) -> Double { @_common.sum(s.data) }

pub fn net_sec_ips_frame_mean(s : NetsecipsFrame) -> Double { @_common.mean(s.data) }

pub fn net_sec_ips_frame_scale(s : NetsecipsFrame, f : Double) -> NetsecipsFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_sec_ips_frame_add(a : NetsecipsFrame, b : NetsecipsFrame) -> NetsecipsFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_sec_ips_frame_copy(s : NetsecipsFrame) -> NetsecipsFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_sec_ips_frame_fill(s : NetsecipsFrame, v : Double) -> NetsecipsFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_sec_ips_frame_min(s : NetsecipsFrame) -> Double { @_common.min(s.data) }

pub fn net_sec_ips_frame_max(s : NetsecipsFrame) -> Double { @_common.max(s.data) }

pub fn net_sec_ips_frame_to_string(s : NetsecipsFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetsecipsTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_sec_ips_table_make(size : Int) -> NetsecipsTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_sec_ips_table_len(s : NetsecipsTable) -> Int { s.size }

pub fn net_sec_ips_table_get(s : NetsecipsTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_sec_ips_table_set(s : NetsecipsTable, i : Int, v : Double) -> NetsecipsTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn net_sec_ips_table_sum(s : NetsecipsTable) -> Double { @_common.sum(s.data) }

pub fn net_sec_ips_table_mean(s : NetsecipsTable) -> Double { @_common.mean(s.data) }

pub fn net_sec_ips_table_scale(s : NetsecipsTable, f : Double) -> NetsecipsTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_sec_ips_table_add(a : NetsecipsTable, b : NetsecipsTable) -> NetsecipsTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_sec_ips_table_copy(s : NetsecipsTable) -> NetsecipsTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_sec_ips_table_fill(s : NetsecipsTable, v : Double) -> NetsecipsTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_sec_ips_table_min(s : NetsecipsTable) -> Double { @_common.min(s.data) }

pub fn net_sec_ips_table_max(s : NetsecipsTable) -> Double { @_common.max(s.data) }

pub fn net_sec_ips_table_to_string(s : NetsecipsTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetsecipsGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_sec_ips_graphn_make(size : Int) -> NetsecipsGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_sec_ips_graphn_len(s : NetsecipsGraphN) -> Int { s.size }

pub fn net_sec_ips_graphn_get(s : NetsecipsGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_sec_ips_graphn_set(s : NetsecipsGraphN, i : Int, v : Double) -> NetsecipsGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn net_sec_ips_graphn_sum(s : NetsecipsGraphN) -> Double { @_common.sum(s.data) }

pub fn net_sec_ips_graphn_mean(s : NetsecipsGraphN) -> Double { @_common.mean(s.data) }

pub fn net_sec_ips_graphn_scale(s : NetsecipsGraphN, f : Double) -> NetsecipsGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_sec_ips_graphn_add(a : NetsecipsGraphN, b : NetsecipsGraphN) -> NetsecipsGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_sec_ips_graphn_copy(s : NetsecipsGraphN) -> NetsecipsGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_sec_ips_graphn_fill(s : NetsecipsGraphN, v : Double) -> NetsecipsGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_sec_ips_graphn_min(s : NetsecipsGraphN) -> Double { @_common.min(s.data) }

pub fn net_sec_ips_graphn_max(s : NetsecipsGraphN) -> Double { @_common.max(s.data) }

pub fn net_sec_ips_graphn_to_string(s : NetsecipsGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetsecipsNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_sec_ips_node_make(size : Int) -> NetsecipsNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_sec_ips_node_len(s : NetsecipsNode) -> Int { s.size }

pub fn net_sec_ips_node_get(s : NetsecipsNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_sec_ips_node_set(s : NetsecipsNode, i : Int, v : Double) -> NetsecipsNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn net_sec_ips_node_sum(s : NetsecipsNode) -> Double { @_common.sum(s.data) }

pub fn net_sec_ips_node_mean(s : NetsecipsNode) -> Double { @_common.mean(s.data) }

pub fn net_sec_ips_node_scale(s : NetsecipsNode, f : Double) -> NetsecipsNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_sec_ips_node_add(a : NetsecipsNode, b : NetsecipsNode) -> NetsecipsNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_sec_ips_node_copy(s : NetsecipsNode) -> NetsecipsNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_sec_ips_node_fill(s : NetsecipsNode, v : Double) -> NetsecipsNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_sec_ips_node_min(s : NetsecipsNode) -> Double { @_common.min(s.data) }

pub fn net_sec_ips_node_max(s : NetsecipsNode) -> Double { @_common.max(s.data) }

pub fn net_sec_ips_node_to_string(s : NetsecipsNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetsecipsEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_sec_ips_edge_make(size : Int) -> NetsecipsEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_sec_ips_edge_len(s : NetsecipsEdge) -> Int { s.size }

pub fn net_sec_ips_edge_get(s : NetsecipsEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_sec_ips_edge_set(s : NetsecipsEdge, i : Int, v : Double) -> NetsecipsEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn net_sec_ips_edge_sum(s : NetsecipsEdge) -> Double { @_common.sum(s.data) }

pub fn net_sec_ips_edge_mean(s : NetsecipsEdge) -> Double { @_common.mean(s.data) }

pub fn net_sec_ips_edge_scale(s : NetsecipsEdge, f : Double) -> NetsecipsEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_sec_ips_edge_add(a : NetsecipsEdge, b : NetsecipsEdge) -> NetsecipsEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_sec_ips_edge_copy(s : NetsecipsEdge) -> NetsecipsEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_sec_ips_edge_fill(s : NetsecipsEdge, v : Double) -> NetsecipsEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_sec_ips_edge_min(s : NetsecipsEdge) -> Double { @_common.min(s.data) }

pub fn net_sec_ips_edge_max(s : NetsecipsEdge) -> Double { @_common.max(s.data) }

pub fn net_sec_ips_edge_to_string(s : NetsecipsEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetsecipsPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_sec_ips_path_make(size : Int) -> NetsecipsPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_sec_ips_path_len(s : NetsecipsPath) -> Int { s.size }

pub fn net_sec_ips_path_get(s : NetsecipsPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_sec_ips_path_set(s : NetsecipsPath, i : Int, v : Double) -> NetsecipsPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn net_sec_ips_path_sum(s : NetsecipsPath) -> Double { @_common.sum(s.data) }

pub fn net_sec_ips_path_mean(s : NetsecipsPath) -> Double { @_common.mean(s.data) }

pub fn net_sec_ips_path_scale(s : NetsecipsPath, f : Double) -> NetsecipsPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_sec_ips_path_add(a : NetsecipsPath, b : NetsecipsPath) -> NetsecipsPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_sec_ips_path_copy(s : NetsecipsPath) -> NetsecipsPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_sec_ips_path_fill(s : NetsecipsPath, v : Double) -> NetsecipsPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_sec_ips_path_min(s : NetsecipsPath) -> Double { @_common.min(s.data) }

pub fn net_sec_ips_path_max(s : NetsecipsPath) -> Double { @_common.max(s.data) }

pub fn net_sec_ips_path_to_string(s : NetsecipsPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetsecipsCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_sec_ips_cluster_make(size : Int) -> NetsecipsCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_sec_ips_cluster_len(s : NetsecipsCluster) -> Int { s.size }

pub fn net_sec_ips_cluster_get(s : NetsecipsCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_sec_ips_cluster_set(s : NetsecipsCluster, i : Int, v : Double) -> NetsecipsCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn net_sec_ips_cluster_sum(s : NetsecipsCluster) -> Double { @_common.sum(s.data) }

pub fn net_sec_ips_cluster_mean(s : NetsecipsCluster) -> Double { @_common.mean(s.data) }

pub fn net_sec_ips_cluster_scale(s : NetsecipsCluster, f : Double) -> NetsecipsCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_sec_ips_cluster_add(a : NetsecipsCluster, b : NetsecipsCluster) -> NetsecipsCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_sec_ips_cluster_copy(s : NetsecipsCluster) -> NetsecipsCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_sec_ips_cluster_fill(s : NetsecipsCluster, v : Double) -> NetsecipsCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_sec_ips_cluster_min(s : NetsecipsCluster) -> Double { @_common.min(s.data) }

pub fn net_sec_ips_cluster_max(s : NetsecipsCluster) -> Double { @_common.max(s.data) }

pub fn net_sec_ips_cluster_to_string(s : NetsecipsCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetsecipsModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_sec_ips_model_make(size : Int) -> NetsecipsModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_sec_ips_model_len(s : NetsecipsModel) -> Int { s.size }

pub fn net_sec_ips_model_get(s : NetsecipsModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_sec_ips_model_set(s : NetsecipsModel, i : Int, v : Double) -> NetsecipsModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn net_sec_ips_model_sum(s : NetsecipsModel) -> Double { @_common.sum(s.data) }

pub fn net_sec_ips_model_mean(s : NetsecipsModel) -> Double { @_common.mean(s.data) }

pub fn net_sec_ips_model_scale(s : NetsecipsModel, f : Double) -> NetsecipsModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_sec_ips_model_add(a : NetsecipsModel, b : NetsecipsModel) -> NetsecipsModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_sec_ips_model_copy(s : NetsecipsModel) -> NetsecipsModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_sec_ips_model_fill(s : NetsecipsModel, v : Double) -> NetsecipsModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_sec_ips_model_min(s : NetsecipsModel) -> Double { @_common.min(s.data) }

pub fn net_sec_ips_model_max(s : NetsecipsModel) -> Double { @_common.max(s.data) }

pub fn net_sec_ips_model_to_string(s : NetsecipsModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetsecipsLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_sec_ips_layer_make(size : Int) -> NetsecipsLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_sec_ips_layer_len(s : NetsecipsLayer) -> Int { s.size }

pub fn net_sec_ips_layer_get(s : NetsecipsLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_sec_ips_layer_set(s : NetsecipsLayer, i : Int, v : Double) -> NetsecipsLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn net_sec_ips_layer_sum(s : NetsecipsLayer) -> Double { @_common.sum(s.data) }

pub fn net_sec_ips_layer_mean(s : NetsecipsLayer) -> Double { @_common.mean(s.data) }

pub fn net_sec_ips_layer_scale(s : NetsecipsLayer, f : Double) -> NetsecipsLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_sec_ips_layer_add(a : NetsecipsLayer, b : NetsecipsLayer) -> NetsecipsLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_sec_ips_layer_copy(s : NetsecipsLayer) -> NetsecipsLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_sec_ips_layer_fill(s : NetsecipsLayer, v : Double) -> NetsecipsLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_sec_ips_layer_min(s : NetsecipsLayer) -> Double { @_common.min(s.data) }

pub fn net_sec_ips_layer_max(s : NetsecipsLayer) -> Double { @_common.max(s.data) }

pub fn net_sec_ips_layer_to_string(s : NetsecipsLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetsecipsBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_sec_ips_buffer_make(size : Int) -> NetsecipsBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_sec_ips_buffer_len(s : NetsecipsBuffer) -> Int { s.size }

pub fn net_sec_ips_buffer_get(s : NetsecipsBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_sec_ips_buffer_set(s : NetsecipsBuffer, i : Int, v : Double) -> NetsecipsBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn net_sec_ips_buffer_sum(s : NetsecipsBuffer) -> Double { @_common.sum(s.data) }

pub fn net_sec_ips_buffer_mean(s : NetsecipsBuffer) -> Double { @_common.mean(s.data) }

pub fn net_sec_ips_buffer_scale(s : NetsecipsBuffer, f : Double) -> NetsecipsBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_sec_ips_buffer_add(a : NetsecipsBuffer, b : NetsecipsBuffer) -> NetsecipsBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_sec_ips_buffer_copy(s : NetsecipsBuffer) -> NetsecipsBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_sec_ips_buffer_fill(s : NetsecipsBuffer, v : Double) -> NetsecipsBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_sec_ips_buffer_min(s : NetsecipsBuffer) -> Double { @_common.min(s.data) }

pub fn net_sec_ips_buffer_max(s : NetsecipsBuffer) -> Double { @_common.max(s.data) }

pub fn net_sec_ips_buffer_to_string(s : NetsecipsBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetsecipsCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_sec_ips_cursor_make(size : Int) -> NetsecipsCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_sec_ips_cursor_len(s : NetsecipsCursor) -> Int { s.size }

pub fn net_sec_ips_cursor_get(s : NetsecipsCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_sec_ips_cursor_set(s : NetsecipsCursor, i : Int, v : Double) -> NetsecipsCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn net_sec_ips_cursor_sum(s : NetsecipsCursor) -> Double { @_common.sum(s.data) }

pub fn net_sec_ips_cursor_mean(s : NetsecipsCursor) -> Double { @_common.mean(s.data) }

pub fn net_sec_ips_cursor_scale(s : NetsecipsCursor, f : Double) -> NetsecipsCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_sec_ips_cursor_add(a : NetsecipsCursor, b : NetsecipsCursor) -> NetsecipsCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_sec_ips_cursor_copy(s : NetsecipsCursor) -> NetsecipsCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_sec_ips_cursor_fill(s : NetsecipsCursor, v : Double) -> NetsecipsCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_sec_ips_cursor_min(s : NetsecipsCursor) -> Double { @_common.min(s.data) }

pub fn net_sec_ips_cursor_max(s : NetsecipsCursor) -> Double { @_common.max(s.data) }

pub fn net_sec_ips_cursor_to_string(s : NetsecipsCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetsecipsView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_sec_ips_view_make(size : Int) -> NetsecipsView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_sec_ips_view_len(s : NetsecipsView) -> Int { s.size }

pub fn net_sec_ips_view_get(s : NetsecipsView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_sec_ips_view_set(s : NetsecipsView, i : Int, v : Double) -> NetsecipsView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn net_sec_ips_view_sum(s : NetsecipsView) -> Double { @_common.sum(s.data) }

pub fn net_sec_ips_view_mean(s : NetsecipsView) -> Double { @_common.mean(s.data) }

pub fn net_sec_ips_view_scale(s : NetsecipsView, f : Double) -> NetsecipsView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_sec_ips_view_add(a : NetsecipsView, b : NetsecipsView) -> NetsecipsView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_sec_ips_view_copy(s : NetsecipsView) -> NetsecipsView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_sec_ips_view_fill(s : NetsecipsView, v : Double) -> NetsecipsView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_sec_ips_view_min(s : NetsecipsView) -> Double { @_common.min(s.data) }

pub fn net_sec_ips_view_max(s : NetsecipsView) -> Double { @_common.max(s.data) }

pub fn net_sec_ips_view_to_string(s : NetsecipsView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetsecipsRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_sec_ips_range_make(size : Int) -> NetsecipsRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_sec_ips_range_len(s : NetsecipsRange) -> Int { s.size }

pub fn net_sec_ips_range_get(s : NetsecipsRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_sec_ips_range_set(s : NetsecipsRange, i : Int, v : Double) -> NetsecipsRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn net_sec_ips_range_sum(s : NetsecipsRange) -> Double { @_common.sum(s.data) }

pub fn net_sec_ips_range_mean(s : NetsecipsRange) -> Double { @_common.mean(s.data) }

pub fn net_sec_ips_range_scale(s : NetsecipsRange, f : Double) -> NetsecipsRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_sec_ips_range_add(a : NetsecipsRange, b : NetsecipsRange) -> NetsecipsRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_sec_ips_range_copy(s : NetsecipsRange) -> NetsecipsRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_sec_ips_range_fill(s : NetsecipsRange, v : Double) -> NetsecipsRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_sec_ips_range_min(s : NetsecipsRange) -> Double { @_common.min(s.data) }

pub fn net_sec_ips_range_max(s : NetsecipsRange) -> Double { @_common.max(s.data) }

pub fn net_sec_ips_range_to_string(s : NetsecipsRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetsecipsSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_sec_ips_slice_make(size : Int) -> NetsecipsSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_sec_ips_slice_len(s : NetsecipsSlice) -> Int { s.size }

pub fn net_sec_ips_slice_get(s : NetsecipsSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_sec_ips_slice_set(s : NetsecipsSlice, i : Int, v : Double) -> NetsecipsSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn net_sec_ips_slice_sum(s : NetsecipsSlice) -> Double { @_common.sum(s.data) }

pub fn net_sec_ips_slice_mean(s : NetsecipsSlice) -> Double { @_common.mean(s.data) }

pub fn net_sec_ips_slice_scale(s : NetsecipsSlice, f : Double) -> NetsecipsSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_sec_ips_slice_add(a : NetsecipsSlice, b : NetsecipsSlice) -> NetsecipsSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_sec_ips_slice_copy(s : NetsecipsSlice) -> NetsecipsSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_sec_ips_slice_fill(s : NetsecipsSlice, v : Double) -> NetsecipsSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_sec_ips_slice_min(s : NetsecipsSlice) -> Double { @_common.min(s.data) }

pub fn net_sec_ips_slice_max(s : NetsecipsSlice) -> Double { @_common.max(s.data) }

pub fn net_sec_ips_slice_to_string(s : NetsecipsSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

