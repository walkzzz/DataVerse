///===
/// extcore/net_sec_ids

pub(all) struct NetsecidsPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn net_sec_ids_make_point(x : Double, y : Double) -> NetsecidsPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn net_sec_ids_make_point3(x : Double, y : Double, z : Double) -> NetsecidsPoint {
  { x, y, z, label: 0 }
}

pub fn NetsecidsPoint::x(self : NetsecidsPoint) -> Double { self.x }

pub fn NetsecidsPoint::y(self : NetsecidsPoint) -> Double { self.y }

pub fn NetsecidsPoint::z(self : NetsecidsPoint) -> Double { self.z }

pub fn NetsecidsPoint::label(self : NetsecidsPoint) -> Int { self.label }

pub fn NetsecidsPoint::dist(self : NetsecidsPoint, other : NetsecidsPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn NetsecidsPoint::add(self : NetsecidsPoint, other : NetsecidsPoint) -> NetsecidsPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn NetsecidsPoint::sub(self : NetsecidsPoint, other : NetsecidsPoint) -> NetsecidsPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn NetsecidsPoint::scale(self : NetsecidsPoint, s : Double) -> NetsecidsPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn NetsecidsPoint::dot(self : NetsecidsPoint, other : NetsecidsPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn NetsecidsPoint::cross(self : NetsecidsPoint, other : NetsecidsPoint) -> NetsecidsPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn NetsecidsPoint::norm(self : NetsecidsPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn NetsecidsPoint::normalize(self : NetsecidsPoint) -> NetsecidsPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn NetsecidsPoint::negate(self : NetsecidsPoint) -> NetsecidsPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn NetsecidsPoint::mid(self : NetsecidsPoint, other : NetsecidsPoint) -> NetsecidsPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn NetsecidsPoint::lerp(self : NetsecidsPoint, other : NetsecidsPoint, t : Double) -> NetsecidsPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn NetsecidsPoint::to_string(self : NetsecidsPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct NetsecidsSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn net_sec_ids_make_series(vals : Array[Double], name : String) -> NetsecidsSeries {
  { vals, name, meta: 0 }
}

pub fn NetsecidsSeries::len(self : NetsecidsSeries) -> Int { self.vals.length() }

pub fn NetsecidsSeries::sum(self : NetsecidsSeries) -> Double { @_common.sum(self.vals) }

pub fn NetsecidsSeries::mean(self : NetsecidsSeries) -> Double { @_common.mean(self.vals) }

pub fn NetsecidsSeries::min(self : NetsecidsSeries) -> Double { @_common.min(self.vals) }

pub fn NetsecidsSeries::max(self : NetsecidsSeries) -> Double { @_common.max(self.vals) }

pub fn NetsecidsSeries::range(self : NetsecidsSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn NetsecidsSeries::variance(self : NetsecidsSeries) -> Double { @_common.variance(self.vals) }

pub fn NetsecidsSeries::std(self : NetsecidsSeries) -> Double { @_common.std(self.vals) }

pub fn NetsecidsSeries::median(self : NetsecidsSeries) -> Double { @_common.median(self.vals) }

pub fn NetsecidsSeries::scale(self : NetsecidsSeries, f : Double) -> NetsecidsSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn NetsecidsSeries::add(self : NetsecidsSeries, other : NetsecidsSeries) -> NetsecidsSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn NetsecidsSeries::sub(self : NetsecidsSeries, other : NetsecidsSeries) -> NetsecidsSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn NetsecidsSeries::normalize(self : NetsecidsSeries) -> NetsecidsSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn NetsecidsSeries::cumsum(self : NetsecidsSeries) -> NetsecidsSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn NetsecidsSeries::to_string(self : NetsecidsSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct NetsecidsMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn net_sec_ids_make_matrix(rows : Int, cols : Int, val : Double) -> NetsecidsMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn net_sec_ids_matrix_identity(n : Int) -> NetsecidsMatrix {
  let m = net_sec_ids_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn NetsecidsMatrix::get(self : NetsecidsMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn NetsecidsMatrix::transpose(self : NetsecidsMatrix) -> NetsecidsMatrix {
  let result = net_sec_ids_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn NetsecidsMatrix::add(self : NetsecidsMatrix, other : NetsecidsMatrix) -> NetsecidsMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = net_sec_ids_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn NetsecidsMatrix::scale(self : NetsecidsMatrix, s : Double) -> NetsecidsMatrix {
  let result = net_sec_ids_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn NetsecidsMatrix::multiply(self : NetsecidsMatrix, other : NetsecidsMatrix) -> NetsecidsMatrix {
  if self.cols != other.rows { return net_sec_ids_make_matrix(self.rows, other.cols, 0.0) }
  let result = net_sec_ids_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn NetsecidsMatrix::trace(self : NetsecidsMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn NetsecidsMatrix::det(self : NetsecidsMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn NetsecidsMatrix::norm(self : NetsecidsMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn NetsecidsMatrix::to_string(self : NetsecidsMatrix) -> String {
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

pub(all) struct NetsecidsVector {
  comps : Array[Double]
  dim : Int
}

pub fn net_sec_ids_make_vector(comps : Array[Double]) -> NetsecidsVector {
  { comps, dim: comps.length() }
}

pub fn net_sec_ids_vector_zero(dim : Int) -> NetsecidsVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn NetsecidsVector::add(self : NetsecidsVector, other : NetsecidsVector) -> NetsecidsVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn NetsecidsVector::sub(self : NetsecidsVector, other : NetsecidsVector) -> NetsecidsVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn NetsecidsVector::scale(self : NetsecidsVector, s : Double) -> NetsecidsVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn NetsecidsVector::dot(self : NetsecidsVector, other : NetsecidsVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn NetsecidsVector::norm(self : NetsecidsVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn NetsecidsVector::normalize(self : NetsecidsVector) -> NetsecidsVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn NetsecidsVector::dist(self : NetsecidsVector, other : NetsecidsVector) -> Double {
  self.sub(other).norm()
}

pub fn NetsecidsVector::to_string(self : NetsecidsVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn net_sec_ids_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn net_sec_ids_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn net_sec_ids_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn net_sec_ids_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn net_sec_ids_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn net_sec_ids_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn net_sec_ids_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn net_sec_ids_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn net_sec_ids_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn net_sec_ids_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn net_sec_ids_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn net_sec_ids_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn net_sec_ids_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn net_sec_ids_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn net_sec_ids_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn net_sec_ids_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn net_sec_ids_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn net_sec_ids_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn net_sec_ids_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn net_sec_ids_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn net_sec_ids_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn net_sec_ids_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn net_sec_ids_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn net_sec_ids_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn net_sec_ids_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn net_sec_ids_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn net_sec_ids_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn net_sec_ids_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn net_sec_ids_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct NetsecidsFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_sec_ids_frame_make(size : Int) -> NetsecidsFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_sec_ids_frame_len(s : NetsecidsFrame) -> Int { s.size }

pub fn net_sec_ids_frame_get(s : NetsecidsFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_sec_ids_frame_set(s : NetsecidsFrame, i : Int, v : Double) -> NetsecidsFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn net_sec_ids_frame_sum(s : NetsecidsFrame) -> Double { @_common.sum(s.data) }

pub fn net_sec_ids_frame_mean(s : NetsecidsFrame) -> Double { @_common.mean(s.data) }

pub fn net_sec_ids_frame_scale(s : NetsecidsFrame, f : Double) -> NetsecidsFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_sec_ids_frame_add(a : NetsecidsFrame, b : NetsecidsFrame) -> NetsecidsFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_sec_ids_frame_copy(s : NetsecidsFrame) -> NetsecidsFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_sec_ids_frame_fill(s : NetsecidsFrame, v : Double) -> NetsecidsFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_sec_ids_frame_min(s : NetsecidsFrame) -> Double { @_common.min(s.data) }

pub fn net_sec_ids_frame_max(s : NetsecidsFrame) -> Double { @_common.max(s.data) }

pub fn net_sec_ids_frame_to_string(s : NetsecidsFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetsecidsTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_sec_ids_table_make(size : Int) -> NetsecidsTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_sec_ids_table_len(s : NetsecidsTable) -> Int { s.size }

pub fn net_sec_ids_table_get(s : NetsecidsTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_sec_ids_table_set(s : NetsecidsTable, i : Int, v : Double) -> NetsecidsTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn net_sec_ids_table_sum(s : NetsecidsTable) -> Double { @_common.sum(s.data) }

pub fn net_sec_ids_table_mean(s : NetsecidsTable) -> Double { @_common.mean(s.data) }

pub fn net_sec_ids_table_scale(s : NetsecidsTable, f : Double) -> NetsecidsTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_sec_ids_table_add(a : NetsecidsTable, b : NetsecidsTable) -> NetsecidsTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_sec_ids_table_copy(s : NetsecidsTable) -> NetsecidsTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_sec_ids_table_fill(s : NetsecidsTable, v : Double) -> NetsecidsTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_sec_ids_table_min(s : NetsecidsTable) -> Double { @_common.min(s.data) }

pub fn net_sec_ids_table_max(s : NetsecidsTable) -> Double { @_common.max(s.data) }

pub fn net_sec_ids_table_to_string(s : NetsecidsTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetsecidsGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_sec_ids_graphn_make(size : Int) -> NetsecidsGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_sec_ids_graphn_len(s : NetsecidsGraphN) -> Int { s.size }

pub fn net_sec_ids_graphn_get(s : NetsecidsGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_sec_ids_graphn_set(s : NetsecidsGraphN, i : Int, v : Double) -> NetsecidsGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn net_sec_ids_graphn_sum(s : NetsecidsGraphN) -> Double { @_common.sum(s.data) }

pub fn net_sec_ids_graphn_mean(s : NetsecidsGraphN) -> Double { @_common.mean(s.data) }

pub fn net_sec_ids_graphn_scale(s : NetsecidsGraphN, f : Double) -> NetsecidsGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_sec_ids_graphn_add(a : NetsecidsGraphN, b : NetsecidsGraphN) -> NetsecidsGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_sec_ids_graphn_copy(s : NetsecidsGraphN) -> NetsecidsGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_sec_ids_graphn_fill(s : NetsecidsGraphN, v : Double) -> NetsecidsGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_sec_ids_graphn_min(s : NetsecidsGraphN) -> Double { @_common.min(s.data) }

pub fn net_sec_ids_graphn_max(s : NetsecidsGraphN) -> Double { @_common.max(s.data) }

pub fn net_sec_ids_graphn_to_string(s : NetsecidsGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetsecidsNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_sec_ids_node_make(size : Int) -> NetsecidsNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_sec_ids_node_len(s : NetsecidsNode) -> Int { s.size }

pub fn net_sec_ids_node_get(s : NetsecidsNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_sec_ids_node_set(s : NetsecidsNode, i : Int, v : Double) -> NetsecidsNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn net_sec_ids_node_sum(s : NetsecidsNode) -> Double { @_common.sum(s.data) }

pub fn net_sec_ids_node_mean(s : NetsecidsNode) -> Double { @_common.mean(s.data) }

pub fn net_sec_ids_node_scale(s : NetsecidsNode, f : Double) -> NetsecidsNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_sec_ids_node_add(a : NetsecidsNode, b : NetsecidsNode) -> NetsecidsNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_sec_ids_node_copy(s : NetsecidsNode) -> NetsecidsNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_sec_ids_node_fill(s : NetsecidsNode, v : Double) -> NetsecidsNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_sec_ids_node_min(s : NetsecidsNode) -> Double { @_common.min(s.data) }

pub fn net_sec_ids_node_max(s : NetsecidsNode) -> Double { @_common.max(s.data) }

pub fn net_sec_ids_node_to_string(s : NetsecidsNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetsecidsEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_sec_ids_edge_make(size : Int) -> NetsecidsEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_sec_ids_edge_len(s : NetsecidsEdge) -> Int { s.size }

pub fn net_sec_ids_edge_get(s : NetsecidsEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_sec_ids_edge_set(s : NetsecidsEdge, i : Int, v : Double) -> NetsecidsEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn net_sec_ids_edge_sum(s : NetsecidsEdge) -> Double { @_common.sum(s.data) }

pub fn net_sec_ids_edge_mean(s : NetsecidsEdge) -> Double { @_common.mean(s.data) }

pub fn net_sec_ids_edge_scale(s : NetsecidsEdge, f : Double) -> NetsecidsEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_sec_ids_edge_add(a : NetsecidsEdge, b : NetsecidsEdge) -> NetsecidsEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_sec_ids_edge_copy(s : NetsecidsEdge) -> NetsecidsEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_sec_ids_edge_fill(s : NetsecidsEdge, v : Double) -> NetsecidsEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_sec_ids_edge_min(s : NetsecidsEdge) -> Double { @_common.min(s.data) }

pub fn net_sec_ids_edge_max(s : NetsecidsEdge) -> Double { @_common.max(s.data) }

pub fn net_sec_ids_edge_to_string(s : NetsecidsEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetsecidsPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_sec_ids_path_make(size : Int) -> NetsecidsPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_sec_ids_path_len(s : NetsecidsPath) -> Int { s.size }

pub fn net_sec_ids_path_get(s : NetsecidsPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_sec_ids_path_set(s : NetsecidsPath, i : Int, v : Double) -> NetsecidsPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn net_sec_ids_path_sum(s : NetsecidsPath) -> Double { @_common.sum(s.data) }

pub fn net_sec_ids_path_mean(s : NetsecidsPath) -> Double { @_common.mean(s.data) }

pub fn net_sec_ids_path_scale(s : NetsecidsPath, f : Double) -> NetsecidsPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_sec_ids_path_add(a : NetsecidsPath, b : NetsecidsPath) -> NetsecidsPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_sec_ids_path_copy(s : NetsecidsPath) -> NetsecidsPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_sec_ids_path_fill(s : NetsecidsPath, v : Double) -> NetsecidsPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_sec_ids_path_min(s : NetsecidsPath) -> Double { @_common.min(s.data) }

pub fn net_sec_ids_path_max(s : NetsecidsPath) -> Double { @_common.max(s.data) }

pub fn net_sec_ids_path_to_string(s : NetsecidsPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetsecidsCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_sec_ids_cluster_make(size : Int) -> NetsecidsCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_sec_ids_cluster_len(s : NetsecidsCluster) -> Int { s.size }

pub fn net_sec_ids_cluster_get(s : NetsecidsCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_sec_ids_cluster_set(s : NetsecidsCluster, i : Int, v : Double) -> NetsecidsCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn net_sec_ids_cluster_sum(s : NetsecidsCluster) -> Double { @_common.sum(s.data) }

pub fn net_sec_ids_cluster_mean(s : NetsecidsCluster) -> Double { @_common.mean(s.data) }

pub fn net_sec_ids_cluster_scale(s : NetsecidsCluster, f : Double) -> NetsecidsCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_sec_ids_cluster_add(a : NetsecidsCluster, b : NetsecidsCluster) -> NetsecidsCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_sec_ids_cluster_copy(s : NetsecidsCluster) -> NetsecidsCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_sec_ids_cluster_fill(s : NetsecidsCluster, v : Double) -> NetsecidsCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_sec_ids_cluster_min(s : NetsecidsCluster) -> Double { @_common.min(s.data) }

pub fn net_sec_ids_cluster_max(s : NetsecidsCluster) -> Double { @_common.max(s.data) }

pub fn net_sec_ids_cluster_to_string(s : NetsecidsCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetsecidsModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_sec_ids_model_make(size : Int) -> NetsecidsModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_sec_ids_model_len(s : NetsecidsModel) -> Int { s.size }

pub fn net_sec_ids_model_get(s : NetsecidsModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_sec_ids_model_set(s : NetsecidsModel, i : Int, v : Double) -> NetsecidsModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn net_sec_ids_model_sum(s : NetsecidsModel) -> Double { @_common.sum(s.data) }

pub fn net_sec_ids_model_mean(s : NetsecidsModel) -> Double { @_common.mean(s.data) }

pub fn net_sec_ids_model_scale(s : NetsecidsModel, f : Double) -> NetsecidsModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_sec_ids_model_add(a : NetsecidsModel, b : NetsecidsModel) -> NetsecidsModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_sec_ids_model_copy(s : NetsecidsModel) -> NetsecidsModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_sec_ids_model_fill(s : NetsecidsModel, v : Double) -> NetsecidsModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_sec_ids_model_min(s : NetsecidsModel) -> Double { @_common.min(s.data) }

pub fn net_sec_ids_model_max(s : NetsecidsModel) -> Double { @_common.max(s.data) }

pub fn net_sec_ids_model_to_string(s : NetsecidsModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetsecidsLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_sec_ids_layer_make(size : Int) -> NetsecidsLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_sec_ids_layer_len(s : NetsecidsLayer) -> Int { s.size }

pub fn net_sec_ids_layer_get(s : NetsecidsLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_sec_ids_layer_set(s : NetsecidsLayer, i : Int, v : Double) -> NetsecidsLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn net_sec_ids_layer_sum(s : NetsecidsLayer) -> Double { @_common.sum(s.data) }

pub fn net_sec_ids_layer_mean(s : NetsecidsLayer) -> Double { @_common.mean(s.data) }

pub fn net_sec_ids_layer_scale(s : NetsecidsLayer, f : Double) -> NetsecidsLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_sec_ids_layer_add(a : NetsecidsLayer, b : NetsecidsLayer) -> NetsecidsLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_sec_ids_layer_copy(s : NetsecidsLayer) -> NetsecidsLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_sec_ids_layer_fill(s : NetsecidsLayer, v : Double) -> NetsecidsLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_sec_ids_layer_min(s : NetsecidsLayer) -> Double { @_common.min(s.data) }

pub fn net_sec_ids_layer_max(s : NetsecidsLayer) -> Double { @_common.max(s.data) }

pub fn net_sec_ids_layer_to_string(s : NetsecidsLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetsecidsBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_sec_ids_buffer_make(size : Int) -> NetsecidsBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_sec_ids_buffer_len(s : NetsecidsBuffer) -> Int { s.size }

pub fn net_sec_ids_buffer_get(s : NetsecidsBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_sec_ids_buffer_set(s : NetsecidsBuffer, i : Int, v : Double) -> NetsecidsBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn net_sec_ids_buffer_sum(s : NetsecidsBuffer) -> Double { @_common.sum(s.data) }

pub fn net_sec_ids_buffer_mean(s : NetsecidsBuffer) -> Double { @_common.mean(s.data) }

pub fn net_sec_ids_buffer_scale(s : NetsecidsBuffer, f : Double) -> NetsecidsBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_sec_ids_buffer_add(a : NetsecidsBuffer, b : NetsecidsBuffer) -> NetsecidsBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_sec_ids_buffer_copy(s : NetsecidsBuffer) -> NetsecidsBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_sec_ids_buffer_fill(s : NetsecidsBuffer, v : Double) -> NetsecidsBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_sec_ids_buffer_min(s : NetsecidsBuffer) -> Double { @_common.min(s.data) }

pub fn net_sec_ids_buffer_max(s : NetsecidsBuffer) -> Double { @_common.max(s.data) }

pub fn net_sec_ids_buffer_to_string(s : NetsecidsBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetsecidsCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_sec_ids_cursor_make(size : Int) -> NetsecidsCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_sec_ids_cursor_len(s : NetsecidsCursor) -> Int { s.size }

pub fn net_sec_ids_cursor_get(s : NetsecidsCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_sec_ids_cursor_set(s : NetsecidsCursor, i : Int, v : Double) -> NetsecidsCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn net_sec_ids_cursor_sum(s : NetsecidsCursor) -> Double { @_common.sum(s.data) }

pub fn net_sec_ids_cursor_mean(s : NetsecidsCursor) -> Double { @_common.mean(s.data) }

pub fn net_sec_ids_cursor_scale(s : NetsecidsCursor, f : Double) -> NetsecidsCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_sec_ids_cursor_add(a : NetsecidsCursor, b : NetsecidsCursor) -> NetsecidsCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_sec_ids_cursor_copy(s : NetsecidsCursor) -> NetsecidsCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_sec_ids_cursor_fill(s : NetsecidsCursor, v : Double) -> NetsecidsCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_sec_ids_cursor_min(s : NetsecidsCursor) -> Double { @_common.min(s.data) }

pub fn net_sec_ids_cursor_max(s : NetsecidsCursor) -> Double { @_common.max(s.data) }

pub fn net_sec_ids_cursor_to_string(s : NetsecidsCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetsecidsView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_sec_ids_view_make(size : Int) -> NetsecidsView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_sec_ids_view_len(s : NetsecidsView) -> Int { s.size }

pub fn net_sec_ids_view_get(s : NetsecidsView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_sec_ids_view_set(s : NetsecidsView, i : Int, v : Double) -> NetsecidsView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn net_sec_ids_view_sum(s : NetsecidsView) -> Double { @_common.sum(s.data) }

pub fn net_sec_ids_view_mean(s : NetsecidsView) -> Double { @_common.mean(s.data) }

pub fn net_sec_ids_view_scale(s : NetsecidsView, f : Double) -> NetsecidsView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_sec_ids_view_add(a : NetsecidsView, b : NetsecidsView) -> NetsecidsView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_sec_ids_view_copy(s : NetsecidsView) -> NetsecidsView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_sec_ids_view_fill(s : NetsecidsView, v : Double) -> NetsecidsView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_sec_ids_view_min(s : NetsecidsView) -> Double { @_common.min(s.data) }

pub fn net_sec_ids_view_max(s : NetsecidsView) -> Double { @_common.max(s.data) }

pub fn net_sec_ids_view_to_string(s : NetsecidsView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetsecidsRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_sec_ids_range_make(size : Int) -> NetsecidsRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_sec_ids_range_len(s : NetsecidsRange) -> Int { s.size }

pub fn net_sec_ids_range_get(s : NetsecidsRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_sec_ids_range_set(s : NetsecidsRange, i : Int, v : Double) -> NetsecidsRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn net_sec_ids_range_sum(s : NetsecidsRange) -> Double { @_common.sum(s.data) }

pub fn net_sec_ids_range_mean(s : NetsecidsRange) -> Double { @_common.mean(s.data) }

pub fn net_sec_ids_range_scale(s : NetsecidsRange, f : Double) -> NetsecidsRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_sec_ids_range_add(a : NetsecidsRange, b : NetsecidsRange) -> NetsecidsRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_sec_ids_range_copy(s : NetsecidsRange) -> NetsecidsRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_sec_ids_range_fill(s : NetsecidsRange, v : Double) -> NetsecidsRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_sec_ids_range_min(s : NetsecidsRange) -> Double { @_common.min(s.data) }

pub fn net_sec_ids_range_max(s : NetsecidsRange) -> Double { @_common.max(s.data) }

pub fn net_sec_ids_range_to_string(s : NetsecidsRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetsecidsSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_sec_ids_slice_make(size : Int) -> NetsecidsSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_sec_ids_slice_len(s : NetsecidsSlice) -> Int { s.size }

pub fn net_sec_ids_slice_get(s : NetsecidsSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_sec_ids_slice_set(s : NetsecidsSlice, i : Int, v : Double) -> NetsecidsSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn net_sec_ids_slice_sum(s : NetsecidsSlice) -> Double { @_common.sum(s.data) }

pub fn net_sec_ids_slice_mean(s : NetsecidsSlice) -> Double { @_common.mean(s.data) }

pub fn net_sec_ids_slice_scale(s : NetsecidsSlice, f : Double) -> NetsecidsSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_sec_ids_slice_add(a : NetsecidsSlice, b : NetsecidsSlice) -> NetsecidsSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_sec_ids_slice_copy(s : NetsecidsSlice) -> NetsecidsSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_sec_ids_slice_fill(s : NetsecidsSlice, v : Double) -> NetsecidsSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_sec_ids_slice_min(s : NetsecidsSlice) -> Double { @_common.min(s.data) }

pub fn net_sec_ids_slice_max(s : NetsecidsSlice) -> Double { @_common.max(s.data) }

pub fn net_sec_ids_slice_to_string(s : NetsecidsSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

