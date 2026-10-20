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

pub fn NetsecipsFrame::len(self : NetsecipsFrame) -> Int { self.size }

pub fn NetsecipsFrame::get(self : NetsecipsFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NetsecipsFrame::set(self : NetsecipsFrame, i : Int, v : Double) -> NetsecipsFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NetsecipsFrame::sum(self : NetsecipsFrame) -> Double { @_common.sum(self.data) }

pub fn NetsecipsFrame::mean(self : NetsecipsFrame) -> Double { @_common.mean(self.data) }

pub fn NetsecipsFrame::scale(self : NetsecipsFrame, f : Double) -> NetsecipsFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NetsecipsFrame::add(self : NetsecipsFrame, other : NetsecipsFrame) -> NetsecipsFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NetsecipsFrame::copy(self : NetsecipsFrame) -> NetsecipsFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NetsecipsFrame::fill(self : NetsecipsFrame, v : Double) -> NetsecipsFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NetsecipsFrame::min(self : NetsecipsFrame) -> Double { @_common.min(self.data) }

pub fn NetsecipsFrame::max(self : NetsecipsFrame) -> Double { @_common.max(self.data) }

pub fn NetsecipsFrame::to_string(self : NetsecipsFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NetsecipsTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_sec_ips_table_make(size : Int) -> NetsecipsTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NetsecipsTable::len(self : NetsecipsTable) -> Int { self.size }

pub fn NetsecipsTable::get(self : NetsecipsTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NetsecipsTable::set(self : NetsecipsTable, i : Int, v : Double) -> NetsecipsTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NetsecipsTable::sum(self : NetsecipsTable) -> Double { @_common.sum(self.data) }

pub fn NetsecipsTable::mean(self : NetsecipsTable) -> Double { @_common.mean(self.data) }

pub fn NetsecipsTable::scale(self : NetsecipsTable, f : Double) -> NetsecipsTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NetsecipsTable::add(self : NetsecipsTable, other : NetsecipsTable) -> NetsecipsTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NetsecipsTable::copy(self : NetsecipsTable) -> NetsecipsTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NetsecipsTable::fill(self : NetsecipsTable, v : Double) -> NetsecipsTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NetsecipsTable::min(self : NetsecipsTable) -> Double { @_common.min(self.data) }

pub fn NetsecipsTable::max(self : NetsecipsTable) -> Double { @_common.max(self.data) }

pub fn NetsecipsTable::to_string(self : NetsecipsTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NetsecipsGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_sec_ips_graphn_make(size : Int) -> NetsecipsGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NetsecipsGraphN::len(self : NetsecipsGraphN) -> Int { self.size }

pub fn NetsecipsGraphN::get(self : NetsecipsGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NetsecipsGraphN::set(self : NetsecipsGraphN, i : Int, v : Double) -> NetsecipsGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NetsecipsGraphN::sum(self : NetsecipsGraphN) -> Double { @_common.sum(self.data) }

pub fn NetsecipsGraphN::mean(self : NetsecipsGraphN) -> Double { @_common.mean(self.data) }

pub fn NetsecipsGraphN::scale(self : NetsecipsGraphN, f : Double) -> NetsecipsGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NetsecipsGraphN::add(self : NetsecipsGraphN, other : NetsecipsGraphN) -> NetsecipsGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NetsecipsGraphN::copy(self : NetsecipsGraphN) -> NetsecipsGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NetsecipsGraphN::fill(self : NetsecipsGraphN, v : Double) -> NetsecipsGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NetsecipsGraphN::min(self : NetsecipsGraphN) -> Double { @_common.min(self.data) }

pub fn NetsecipsGraphN::max(self : NetsecipsGraphN) -> Double { @_common.max(self.data) }

pub fn NetsecipsGraphN::to_string(self : NetsecipsGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NetsecipsNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_sec_ips_node_make(size : Int) -> NetsecipsNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NetsecipsNode::len(self : NetsecipsNode) -> Int { self.size }

pub fn NetsecipsNode::get(self : NetsecipsNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NetsecipsNode::set(self : NetsecipsNode, i : Int, v : Double) -> NetsecipsNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NetsecipsNode::sum(self : NetsecipsNode) -> Double { @_common.sum(self.data) }

pub fn NetsecipsNode::mean(self : NetsecipsNode) -> Double { @_common.mean(self.data) }

pub fn NetsecipsNode::scale(self : NetsecipsNode, f : Double) -> NetsecipsNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NetsecipsNode::add(self : NetsecipsNode, other : NetsecipsNode) -> NetsecipsNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NetsecipsNode::copy(self : NetsecipsNode) -> NetsecipsNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NetsecipsNode::fill(self : NetsecipsNode, v : Double) -> NetsecipsNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NetsecipsNode::min(self : NetsecipsNode) -> Double { @_common.min(self.data) }

pub fn NetsecipsNode::max(self : NetsecipsNode) -> Double { @_common.max(self.data) }

pub fn NetsecipsNode::to_string(self : NetsecipsNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NetsecipsEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_sec_ips_edge_make(size : Int) -> NetsecipsEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NetsecipsEdge::len(self : NetsecipsEdge) -> Int { self.size }

pub fn NetsecipsEdge::get(self : NetsecipsEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NetsecipsEdge::set(self : NetsecipsEdge, i : Int, v : Double) -> NetsecipsEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NetsecipsEdge::sum(self : NetsecipsEdge) -> Double { @_common.sum(self.data) }

pub fn NetsecipsEdge::mean(self : NetsecipsEdge) -> Double { @_common.mean(self.data) }

pub fn NetsecipsEdge::scale(self : NetsecipsEdge, f : Double) -> NetsecipsEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NetsecipsEdge::add(self : NetsecipsEdge, other : NetsecipsEdge) -> NetsecipsEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NetsecipsEdge::copy(self : NetsecipsEdge) -> NetsecipsEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NetsecipsEdge::fill(self : NetsecipsEdge, v : Double) -> NetsecipsEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NetsecipsEdge::min(self : NetsecipsEdge) -> Double { @_common.min(self.data) }

pub fn NetsecipsEdge::max(self : NetsecipsEdge) -> Double { @_common.max(self.data) }

pub fn NetsecipsEdge::to_string(self : NetsecipsEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NetsecipsPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_sec_ips_path_make(size : Int) -> NetsecipsPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NetsecipsPath::len(self : NetsecipsPath) -> Int { self.size }

pub fn NetsecipsPath::get(self : NetsecipsPath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NetsecipsPath::set(self : NetsecipsPath, i : Int, v : Double) -> NetsecipsPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NetsecipsPath::sum(self : NetsecipsPath) -> Double { @_common.sum(self.data) }

pub fn NetsecipsPath::mean(self : NetsecipsPath) -> Double { @_common.mean(self.data) }

pub fn NetsecipsPath::scale(self : NetsecipsPath, f : Double) -> NetsecipsPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NetsecipsPath::add(self : NetsecipsPath, other : NetsecipsPath) -> NetsecipsPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NetsecipsPath::copy(self : NetsecipsPath) -> NetsecipsPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NetsecipsPath::fill(self : NetsecipsPath, v : Double) -> NetsecipsPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NetsecipsPath::min(self : NetsecipsPath) -> Double { @_common.min(self.data) }

pub fn NetsecipsPath::max(self : NetsecipsPath) -> Double { @_common.max(self.data) }

pub fn NetsecipsPath::to_string(self : NetsecipsPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NetsecipsCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_sec_ips_cluster_make(size : Int) -> NetsecipsCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NetsecipsCluster::len(self : NetsecipsCluster) -> Int { self.size }

pub fn NetsecipsCluster::get(self : NetsecipsCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NetsecipsCluster::set(self : NetsecipsCluster, i : Int, v : Double) -> NetsecipsCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NetsecipsCluster::sum(self : NetsecipsCluster) -> Double { @_common.sum(self.data) }

pub fn NetsecipsCluster::mean(self : NetsecipsCluster) -> Double { @_common.mean(self.data) }

pub fn NetsecipsCluster::scale(self : NetsecipsCluster, f : Double) -> NetsecipsCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NetsecipsCluster::add(self : NetsecipsCluster, other : NetsecipsCluster) -> NetsecipsCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NetsecipsCluster::copy(self : NetsecipsCluster) -> NetsecipsCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NetsecipsCluster::fill(self : NetsecipsCluster, v : Double) -> NetsecipsCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NetsecipsCluster::min(self : NetsecipsCluster) -> Double { @_common.min(self.data) }

pub fn NetsecipsCluster::max(self : NetsecipsCluster) -> Double { @_common.max(self.data) }

pub fn NetsecipsCluster::to_string(self : NetsecipsCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NetsecipsModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_sec_ips_model_make(size : Int) -> NetsecipsModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NetsecipsModel::len(self : NetsecipsModel) -> Int { self.size }

pub fn NetsecipsModel::get(self : NetsecipsModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NetsecipsModel::set(self : NetsecipsModel, i : Int, v : Double) -> NetsecipsModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NetsecipsModel::sum(self : NetsecipsModel) -> Double { @_common.sum(self.data) }

pub fn NetsecipsModel::mean(self : NetsecipsModel) -> Double { @_common.mean(self.data) }

pub fn NetsecipsModel::scale(self : NetsecipsModel, f : Double) -> NetsecipsModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NetsecipsModel::add(self : NetsecipsModel, other : NetsecipsModel) -> NetsecipsModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NetsecipsModel::copy(self : NetsecipsModel) -> NetsecipsModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NetsecipsModel::fill(self : NetsecipsModel, v : Double) -> NetsecipsModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NetsecipsModel::min(self : NetsecipsModel) -> Double { @_common.min(self.data) }

pub fn NetsecipsModel::max(self : NetsecipsModel) -> Double { @_common.max(self.data) }

pub fn NetsecipsModel::to_string(self : NetsecipsModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NetsecipsLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_sec_ips_layer_make(size : Int) -> NetsecipsLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NetsecipsLayer::len(self : NetsecipsLayer) -> Int { self.size }

pub fn NetsecipsLayer::get(self : NetsecipsLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NetsecipsLayer::set(self : NetsecipsLayer, i : Int, v : Double) -> NetsecipsLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NetsecipsLayer::sum(self : NetsecipsLayer) -> Double { @_common.sum(self.data) }

pub fn NetsecipsLayer::mean(self : NetsecipsLayer) -> Double { @_common.mean(self.data) }

pub fn NetsecipsLayer::scale(self : NetsecipsLayer, f : Double) -> NetsecipsLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NetsecipsLayer::add(self : NetsecipsLayer, other : NetsecipsLayer) -> NetsecipsLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NetsecipsLayer::copy(self : NetsecipsLayer) -> NetsecipsLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NetsecipsLayer::fill(self : NetsecipsLayer, v : Double) -> NetsecipsLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NetsecipsLayer::min(self : NetsecipsLayer) -> Double { @_common.min(self.data) }

pub fn NetsecipsLayer::max(self : NetsecipsLayer) -> Double { @_common.max(self.data) }

pub fn NetsecipsLayer::to_string(self : NetsecipsLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NetsecipsBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_sec_ips_buffer_make(size : Int) -> NetsecipsBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NetsecipsBuffer::len(self : NetsecipsBuffer) -> Int { self.size }

pub fn NetsecipsBuffer::get(self : NetsecipsBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NetsecipsBuffer::set(self : NetsecipsBuffer, i : Int, v : Double) -> NetsecipsBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NetsecipsBuffer::sum(self : NetsecipsBuffer) -> Double { @_common.sum(self.data) }

pub fn NetsecipsBuffer::mean(self : NetsecipsBuffer) -> Double { @_common.mean(self.data) }

pub fn NetsecipsBuffer::scale(self : NetsecipsBuffer, f : Double) -> NetsecipsBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NetsecipsBuffer::add(self : NetsecipsBuffer, other : NetsecipsBuffer) -> NetsecipsBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NetsecipsBuffer::copy(self : NetsecipsBuffer) -> NetsecipsBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NetsecipsBuffer::fill(self : NetsecipsBuffer, v : Double) -> NetsecipsBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NetsecipsBuffer::min(self : NetsecipsBuffer) -> Double { @_common.min(self.data) }

pub fn NetsecipsBuffer::max(self : NetsecipsBuffer) -> Double { @_common.max(self.data) }

pub fn NetsecipsBuffer::to_string(self : NetsecipsBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NetsecipsCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_sec_ips_cursor_make(size : Int) -> NetsecipsCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NetsecipsCursor::len(self : NetsecipsCursor) -> Int { self.size }

pub fn NetsecipsCursor::get(self : NetsecipsCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NetsecipsCursor::set(self : NetsecipsCursor, i : Int, v : Double) -> NetsecipsCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NetsecipsCursor::sum(self : NetsecipsCursor) -> Double { @_common.sum(self.data) }

pub fn NetsecipsCursor::mean(self : NetsecipsCursor) -> Double { @_common.mean(self.data) }

pub fn NetsecipsCursor::scale(self : NetsecipsCursor, f : Double) -> NetsecipsCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NetsecipsCursor::add(self : NetsecipsCursor, other : NetsecipsCursor) -> NetsecipsCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NetsecipsCursor::copy(self : NetsecipsCursor) -> NetsecipsCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NetsecipsCursor::fill(self : NetsecipsCursor, v : Double) -> NetsecipsCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NetsecipsCursor::min(self : NetsecipsCursor) -> Double { @_common.min(self.data) }

pub fn NetsecipsCursor::max(self : NetsecipsCursor) -> Double { @_common.max(self.data) }

pub fn NetsecipsCursor::to_string(self : NetsecipsCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NetsecipsView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_sec_ips_view_make(size : Int) -> NetsecipsView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NetsecipsView::len(self : NetsecipsView) -> Int { self.size }

pub fn NetsecipsView::get(self : NetsecipsView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NetsecipsView::set(self : NetsecipsView, i : Int, v : Double) -> NetsecipsView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NetsecipsView::sum(self : NetsecipsView) -> Double { @_common.sum(self.data) }

pub fn NetsecipsView::mean(self : NetsecipsView) -> Double { @_common.mean(self.data) }

pub fn NetsecipsView::scale(self : NetsecipsView, f : Double) -> NetsecipsView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NetsecipsView::add(self : NetsecipsView, other : NetsecipsView) -> NetsecipsView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NetsecipsView::copy(self : NetsecipsView) -> NetsecipsView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NetsecipsView::fill(self : NetsecipsView, v : Double) -> NetsecipsView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NetsecipsView::min(self : NetsecipsView) -> Double { @_common.min(self.data) }

pub fn NetsecipsView::max(self : NetsecipsView) -> Double { @_common.max(self.data) }

pub fn NetsecipsView::to_string(self : NetsecipsView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NetsecipsRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_sec_ips_range_make(size : Int) -> NetsecipsRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NetsecipsRange::len(self : NetsecipsRange) -> Int { self.size }

pub fn NetsecipsRange::get(self : NetsecipsRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NetsecipsRange::set(self : NetsecipsRange, i : Int, v : Double) -> NetsecipsRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NetsecipsRange::sum(self : NetsecipsRange) -> Double { @_common.sum(self.data) }

pub fn NetsecipsRange::mean(self : NetsecipsRange) -> Double { @_common.mean(self.data) }

pub fn NetsecipsRange::scale(self : NetsecipsRange, f : Double) -> NetsecipsRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NetsecipsRange::add(self : NetsecipsRange, other : NetsecipsRange) -> NetsecipsRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NetsecipsRange::copy(self : NetsecipsRange) -> NetsecipsRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NetsecipsRange::fill(self : NetsecipsRange, v : Double) -> NetsecipsRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NetsecipsRange::min(self : NetsecipsRange) -> Double { @_common.min(self.data) }

pub fn NetsecipsRange::max(self : NetsecipsRange) -> Double { @_common.max(self.data) }

pub fn NetsecipsRange::to_string(self : NetsecipsRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NetsecipsSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_sec_ips_slice_make(size : Int) -> NetsecipsSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NetsecipsSlice::len(self : NetsecipsSlice) -> Int { self.size }

pub fn NetsecipsSlice::get(self : NetsecipsSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NetsecipsSlice::set(self : NetsecipsSlice, i : Int, v : Double) -> NetsecipsSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NetsecipsSlice::sum(self : NetsecipsSlice) -> Double { @_common.sum(self.data) }

pub fn NetsecipsSlice::mean(self : NetsecipsSlice) -> Double { @_common.mean(self.data) }

pub fn NetsecipsSlice::scale(self : NetsecipsSlice, f : Double) -> NetsecipsSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NetsecipsSlice::add(self : NetsecipsSlice, other : NetsecipsSlice) -> NetsecipsSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NetsecipsSlice::copy(self : NetsecipsSlice) -> NetsecipsSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NetsecipsSlice::fill(self : NetsecipsSlice, v : Double) -> NetsecipsSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NetsecipsSlice::min(self : NetsecipsSlice) -> Double { @_common.min(self.data) }

pub fn NetsecipsSlice::max(self : NetsecipsSlice) -> Double { @_common.max(self.data) }

pub fn NetsecipsSlice::to_string(self : NetsecipsSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

