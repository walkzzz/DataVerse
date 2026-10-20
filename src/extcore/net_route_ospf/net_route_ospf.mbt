///===
/// extcore/net_route_ospf

pub(all) struct NetrouteospfPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn net_route_ospf_make_point(x : Double, y : Double) -> NetrouteospfPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn net_route_ospf_make_point3(x : Double, y : Double, z : Double) -> NetrouteospfPoint {
  { x, y, z, label: 0 }
}

pub fn NetrouteospfPoint::x(self : NetrouteospfPoint) -> Double { self.x }

pub fn NetrouteospfPoint::y(self : NetrouteospfPoint) -> Double { self.y }

pub fn NetrouteospfPoint::z(self : NetrouteospfPoint) -> Double { self.z }

pub fn NetrouteospfPoint::label(self : NetrouteospfPoint) -> Int { self.label }

pub fn NetrouteospfPoint::dist(self : NetrouteospfPoint, other : NetrouteospfPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn NetrouteospfPoint::add(self : NetrouteospfPoint, other : NetrouteospfPoint) -> NetrouteospfPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn NetrouteospfPoint::sub(self : NetrouteospfPoint, other : NetrouteospfPoint) -> NetrouteospfPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn NetrouteospfPoint::scale(self : NetrouteospfPoint, s : Double) -> NetrouteospfPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn NetrouteospfPoint::dot(self : NetrouteospfPoint, other : NetrouteospfPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn NetrouteospfPoint::cross(self : NetrouteospfPoint, other : NetrouteospfPoint) -> NetrouteospfPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn NetrouteospfPoint::norm(self : NetrouteospfPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn NetrouteospfPoint::normalize(self : NetrouteospfPoint) -> NetrouteospfPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn NetrouteospfPoint::negate(self : NetrouteospfPoint) -> NetrouteospfPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn NetrouteospfPoint::mid(self : NetrouteospfPoint, other : NetrouteospfPoint) -> NetrouteospfPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn NetrouteospfPoint::lerp(self : NetrouteospfPoint, other : NetrouteospfPoint, t : Double) -> NetrouteospfPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn NetrouteospfPoint::to_string(self : NetrouteospfPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct NetrouteospfSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn net_route_ospf_make_series(vals : Array[Double], name : String) -> NetrouteospfSeries {
  { vals, name, meta: 0 }
}

pub fn NetrouteospfSeries::len(self : NetrouteospfSeries) -> Int { self.vals.length() }

pub fn NetrouteospfSeries::sum(self : NetrouteospfSeries) -> Double { @_common.sum(self.vals) }

pub fn NetrouteospfSeries::mean(self : NetrouteospfSeries) -> Double { @_common.mean(self.vals) }

pub fn NetrouteospfSeries::min(self : NetrouteospfSeries) -> Double { @_common.min(self.vals) }

pub fn NetrouteospfSeries::max(self : NetrouteospfSeries) -> Double { @_common.max(self.vals) }

pub fn NetrouteospfSeries::range(self : NetrouteospfSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn NetrouteospfSeries::variance(self : NetrouteospfSeries) -> Double { @_common.variance(self.vals) }

pub fn NetrouteospfSeries::std(self : NetrouteospfSeries) -> Double { @_common.std(self.vals) }

pub fn NetrouteospfSeries::median(self : NetrouteospfSeries) -> Double { @_common.median(self.vals) }

pub fn NetrouteospfSeries::scale(self : NetrouteospfSeries, f : Double) -> NetrouteospfSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn NetrouteospfSeries::add(self : NetrouteospfSeries, other : NetrouteospfSeries) -> NetrouteospfSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn NetrouteospfSeries::sub(self : NetrouteospfSeries, other : NetrouteospfSeries) -> NetrouteospfSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn NetrouteospfSeries::normalize(self : NetrouteospfSeries) -> NetrouteospfSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn NetrouteospfSeries::cumsum(self : NetrouteospfSeries) -> NetrouteospfSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn NetrouteospfSeries::to_string(self : NetrouteospfSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct NetrouteospfMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn net_route_ospf_make_matrix(rows : Int, cols : Int, val : Double) -> NetrouteospfMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn net_route_ospf_matrix_identity(n : Int) -> NetrouteospfMatrix {
  let m = net_route_ospf_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn NetrouteospfMatrix::get(self : NetrouteospfMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn NetrouteospfMatrix::transpose(self : NetrouteospfMatrix) -> NetrouteospfMatrix {
  let result = net_route_ospf_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn NetrouteospfMatrix::add(self : NetrouteospfMatrix, other : NetrouteospfMatrix) -> NetrouteospfMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = net_route_ospf_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn NetrouteospfMatrix::scale(self : NetrouteospfMatrix, s : Double) -> NetrouteospfMatrix {
  let result = net_route_ospf_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn NetrouteospfMatrix::multiply(self : NetrouteospfMatrix, other : NetrouteospfMatrix) -> NetrouteospfMatrix {
  if self.cols != other.rows { return net_route_ospf_make_matrix(self.rows, other.cols, 0.0) }
  let result = net_route_ospf_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn NetrouteospfMatrix::trace(self : NetrouteospfMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn NetrouteospfMatrix::det(self : NetrouteospfMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn NetrouteospfMatrix::norm(self : NetrouteospfMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn NetrouteospfMatrix::to_string(self : NetrouteospfMatrix) -> String {
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

pub(all) struct NetrouteospfVector {
  comps : Array[Double]
  dim : Int
}

pub fn net_route_ospf_make_vector(comps : Array[Double]) -> NetrouteospfVector {
  { comps, dim: comps.length() }
}

pub fn net_route_ospf_vector_zero(dim : Int) -> NetrouteospfVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn NetrouteospfVector::add(self : NetrouteospfVector, other : NetrouteospfVector) -> NetrouteospfVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn NetrouteospfVector::sub(self : NetrouteospfVector, other : NetrouteospfVector) -> NetrouteospfVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn NetrouteospfVector::scale(self : NetrouteospfVector, s : Double) -> NetrouteospfVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn NetrouteospfVector::dot(self : NetrouteospfVector, other : NetrouteospfVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn NetrouteospfVector::norm(self : NetrouteospfVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn NetrouteospfVector::normalize(self : NetrouteospfVector) -> NetrouteospfVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn NetrouteospfVector::dist(self : NetrouteospfVector, other : NetrouteospfVector) -> Double {
  self.sub(other).norm()
}

pub fn NetrouteospfVector::to_string(self : NetrouteospfVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn net_route_ospf_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn net_route_ospf_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn net_route_ospf_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn net_route_ospf_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn net_route_ospf_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn net_route_ospf_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn net_route_ospf_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn net_route_ospf_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn net_route_ospf_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn net_route_ospf_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn net_route_ospf_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn net_route_ospf_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn net_route_ospf_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn net_route_ospf_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn net_route_ospf_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn net_route_ospf_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn net_route_ospf_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn net_route_ospf_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn net_route_ospf_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn net_route_ospf_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn net_route_ospf_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn net_route_ospf_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn net_route_ospf_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn net_route_ospf_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn net_route_ospf_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn net_route_ospf_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn net_route_ospf_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn net_route_ospf_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn net_route_ospf_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct NetrouteospfFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_route_ospf_frame_make(size : Int) -> NetrouteospfFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_route_ospf_frame_len(s : NetrouteospfFrame) -> Int { s.size }

pub fn net_route_ospf_frame_get(s : NetrouteospfFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_route_ospf_frame_set(s : NetrouteospfFrame, i : Int, v : Double) -> NetrouteospfFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn net_route_ospf_frame_sum(s : NetrouteospfFrame) -> Double { @_common.sum(s.data) }

pub fn net_route_ospf_frame_mean(s : NetrouteospfFrame) -> Double { @_common.mean(s.data) }

pub fn net_route_ospf_frame_scale(s : NetrouteospfFrame, f : Double) -> NetrouteospfFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_route_ospf_frame_add(a : NetrouteospfFrame, b : NetrouteospfFrame) -> NetrouteospfFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_route_ospf_frame_copy(s : NetrouteospfFrame) -> NetrouteospfFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_route_ospf_frame_fill(s : NetrouteospfFrame, v : Double) -> NetrouteospfFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_route_ospf_frame_min(s : NetrouteospfFrame) -> Double { @_common.min(s.data) }

pub fn net_route_ospf_frame_max(s : NetrouteospfFrame) -> Double { @_common.max(s.data) }

pub fn net_route_ospf_frame_to_string(s : NetrouteospfFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetrouteospfTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_route_ospf_table_make(size : Int) -> NetrouteospfTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_route_ospf_table_len(s : NetrouteospfTable) -> Int { s.size }

pub fn net_route_ospf_table_get(s : NetrouteospfTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_route_ospf_table_set(s : NetrouteospfTable, i : Int, v : Double) -> NetrouteospfTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn net_route_ospf_table_sum(s : NetrouteospfTable) -> Double { @_common.sum(s.data) }

pub fn net_route_ospf_table_mean(s : NetrouteospfTable) -> Double { @_common.mean(s.data) }

pub fn net_route_ospf_table_scale(s : NetrouteospfTable, f : Double) -> NetrouteospfTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_route_ospf_table_add(a : NetrouteospfTable, b : NetrouteospfTable) -> NetrouteospfTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_route_ospf_table_copy(s : NetrouteospfTable) -> NetrouteospfTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_route_ospf_table_fill(s : NetrouteospfTable, v : Double) -> NetrouteospfTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_route_ospf_table_min(s : NetrouteospfTable) -> Double { @_common.min(s.data) }

pub fn net_route_ospf_table_max(s : NetrouteospfTable) -> Double { @_common.max(s.data) }

pub fn net_route_ospf_table_to_string(s : NetrouteospfTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetrouteospfGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_route_ospf_graphn_make(size : Int) -> NetrouteospfGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_route_ospf_graphn_len(s : NetrouteospfGraphN) -> Int { s.size }

pub fn net_route_ospf_graphn_get(s : NetrouteospfGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_route_ospf_graphn_set(s : NetrouteospfGraphN, i : Int, v : Double) -> NetrouteospfGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn net_route_ospf_graphn_sum(s : NetrouteospfGraphN) -> Double { @_common.sum(s.data) }

pub fn net_route_ospf_graphn_mean(s : NetrouteospfGraphN) -> Double { @_common.mean(s.data) }

pub fn net_route_ospf_graphn_scale(s : NetrouteospfGraphN, f : Double) -> NetrouteospfGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_route_ospf_graphn_add(a : NetrouteospfGraphN, b : NetrouteospfGraphN) -> NetrouteospfGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_route_ospf_graphn_copy(s : NetrouteospfGraphN) -> NetrouteospfGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_route_ospf_graphn_fill(s : NetrouteospfGraphN, v : Double) -> NetrouteospfGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_route_ospf_graphn_min(s : NetrouteospfGraphN) -> Double { @_common.min(s.data) }

pub fn net_route_ospf_graphn_max(s : NetrouteospfGraphN) -> Double { @_common.max(s.data) }

pub fn net_route_ospf_graphn_to_string(s : NetrouteospfGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetrouteospfNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_route_ospf_node_make(size : Int) -> NetrouteospfNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_route_ospf_node_len(s : NetrouteospfNode) -> Int { s.size }

pub fn net_route_ospf_node_get(s : NetrouteospfNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_route_ospf_node_set(s : NetrouteospfNode, i : Int, v : Double) -> NetrouteospfNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn net_route_ospf_node_sum(s : NetrouteospfNode) -> Double { @_common.sum(s.data) }

pub fn net_route_ospf_node_mean(s : NetrouteospfNode) -> Double { @_common.mean(s.data) }

pub fn net_route_ospf_node_scale(s : NetrouteospfNode, f : Double) -> NetrouteospfNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_route_ospf_node_add(a : NetrouteospfNode, b : NetrouteospfNode) -> NetrouteospfNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_route_ospf_node_copy(s : NetrouteospfNode) -> NetrouteospfNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_route_ospf_node_fill(s : NetrouteospfNode, v : Double) -> NetrouteospfNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_route_ospf_node_min(s : NetrouteospfNode) -> Double { @_common.min(s.data) }

pub fn net_route_ospf_node_max(s : NetrouteospfNode) -> Double { @_common.max(s.data) }

pub fn net_route_ospf_node_to_string(s : NetrouteospfNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetrouteospfEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_route_ospf_edge_make(size : Int) -> NetrouteospfEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_route_ospf_edge_len(s : NetrouteospfEdge) -> Int { s.size }

pub fn net_route_ospf_edge_get(s : NetrouteospfEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_route_ospf_edge_set(s : NetrouteospfEdge, i : Int, v : Double) -> NetrouteospfEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn net_route_ospf_edge_sum(s : NetrouteospfEdge) -> Double { @_common.sum(s.data) }

pub fn net_route_ospf_edge_mean(s : NetrouteospfEdge) -> Double { @_common.mean(s.data) }

pub fn net_route_ospf_edge_scale(s : NetrouteospfEdge, f : Double) -> NetrouteospfEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_route_ospf_edge_add(a : NetrouteospfEdge, b : NetrouteospfEdge) -> NetrouteospfEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_route_ospf_edge_copy(s : NetrouteospfEdge) -> NetrouteospfEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_route_ospf_edge_fill(s : NetrouteospfEdge, v : Double) -> NetrouteospfEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_route_ospf_edge_min(s : NetrouteospfEdge) -> Double { @_common.min(s.data) }

pub fn net_route_ospf_edge_max(s : NetrouteospfEdge) -> Double { @_common.max(s.data) }

pub fn net_route_ospf_edge_to_string(s : NetrouteospfEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetrouteospfPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_route_ospf_path_make(size : Int) -> NetrouteospfPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_route_ospf_path_len(s : NetrouteospfPath) -> Int { s.size }

pub fn net_route_ospf_path_get(s : NetrouteospfPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_route_ospf_path_set(s : NetrouteospfPath, i : Int, v : Double) -> NetrouteospfPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn net_route_ospf_path_sum(s : NetrouteospfPath) -> Double { @_common.sum(s.data) }

pub fn net_route_ospf_path_mean(s : NetrouteospfPath) -> Double { @_common.mean(s.data) }

pub fn net_route_ospf_path_scale(s : NetrouteospfPath, f : Double) -> NetrouteospfPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_route_ospf_path_add(a : NetrouteospfPath, b : NetrouteospfPath) -> NetrouteospfPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_route_ospf_path_copy(s : NetrouteospfPath) -> NetrouteospfPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_route_ospf_path_fill(s : NetrouteospfPath, v : Double) -> NetrouteospfPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_route_ospf_path_min(s : NetrouteospfPath) -> Double { @_common.min(s.data) }

pub fn net_route_ospf_path_max(s : NetrouteospfPath) -> Double { @_common.max(s.data) }

pub fn net_route_ospf_path_to_string(s : NetrouteospfPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetrouteospfCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_route_ospf_cluster_make(size : Int) -> NetrouteospfCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_route_ospf_cluster_len(s : NetrouteospfCluster) -> Int { s.size }

pub fn net_route_ospf_cluster_get(s : NetrouteospfCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_route_ospf_cluster_set(s : NetrouteospfCluster, i : Int, v : Double) -> NetrouteospfCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn net_route_ospf_cluster_sum(s : NetrouteospfCluster) -> Double { @_common.sum(s.data) }

pub fn net_route_ospf_cluster_mean(s : NetrouteospfCluster) -> Double { @_common.mean(s.data) }

pub fn net_route_ospf_cluster_scale(s : NetrouteospfCluster, f : Double) -> NetrouteospfCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_route_ospf_cluster_add(a : NetrouteospfCluster, b : NetrouteospfCluster) -> NetrouteospfCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_route_ospf_cluster_copy(s : NetrouteospfCluster) -> NetrouteospfCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_route_ospf_cluster_fill(s : NetrouteospfCluster, v : Double) -> NetrouteospfCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_route_ospf_cluster_min(s : NetrouteospfCluster) -> Double { @_common.min(s.data) }

pub fn net_route_ospf_cluster_max(s : NetrouteospfCluster) -> Double { @_common.max(s.data) }

pub fn net_route_ospf_cluster_to_string(s : NetrouteospfCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetrouteospfModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_route_ospf_model_make(size : Int) -> NetrouteospfModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_route_ospf_model_len(s : NetrouteospfModel) -> Int { s.size }

pub fn net_route_ospf_model_get(s : NetrouteospfModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_route_ospf_model_set(s : NetrouteospfModel, i : Int, v : Double) -> NetrouteospfModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn net_route_ospf_model_sum(s : NetrouteospfModel) -> Double { @_common.sum(s.data) }

pub fn net_route_ospf_model_mean(s : NetrouteospfModel) -> Double { @_common.mean(s.data) }

pub fn net_route_ospf_model_scale(s : NetrouteospfModel, f : Double) -> NetrouteospfModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_route_ospf_model_add(a : NetrouteospfModel, b : NetrouteospfModel) -> NetrouteospfModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_route_ospf_model_copy(s : NetrouteospfModel) -> NetrouteospfModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_route_ospf_model_fill(s : NetrouteospfModel, v : Double) -> NetrouteospfModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_route_ospf_model_min(s : NetrouteospfModel) -> Double { @_common.min(s.data) }

pub fn net_route_ospf_model_max(s : NetrouteospfModel) -> Double { @_common.max(s.data) }

pub fn net_route_ospf_model_to_string(s : NetrouteospfModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetrouteospfLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_route_ospf_layer_make(size : Int) -> NetrouteospfLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_route_ospf_layer_len(s : NetrouteospfLayer) -> Int { s.size }

pub fn net_route_ospf_layer_get(s : NetrouteospfLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_route_ospf_layer_set(s : NetrouteospfLayer, i : Int, v : Double) -> NetrouteospfLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn net_route_ospf_layer_sum(s : NetrouteospfLayer) -> Double { @_common.sum(s.data) }

pub fn net_route_ospf_layer_mean(s : NetrouteospfLayer) -> Double { @_common.mean(s.data) }

pub fn net_route_ospf_layer_scale(s : NetrouteospfLayer, f : Double) -> NetrouteospfLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_route_ospf_layer_add(a : NetrouteospfLayer, b : NetrouteospfLayer) -> NetrouteospfLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_route_ospf_layer_copy(s : NetrouteospfLayer) -> NetrouteospfLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_route_ospf_layer_fill(s : NetrouteospfLayer, v : Double) -> NetrouteospfLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_route_ospf_layer_min(s : NetrouteospfLayer) -> Double { @_common.min(s.data) }

pub fn net_route_ospf_layer_max(s : NetrouteospfLayer) -> Double { @_common.max(s.data) }

pub fn net_route_ospf_layer_to_string(s : NetrouteospfLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetrouteospfBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_route_ospf_buffer_make(size : Int) -> NetrouteospfBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_route_ospf_buffer_len(s : NetrouteospfBuffer) -> Int { s.size }

pub fn net_route_ospf_buffer_get(s : NetrouteospfBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_route_ospf_buffer_set(s : NetrouteospfBuffer, i : Int, v : Double) -> NetrouteospfBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn net_route_ospf_buffer_sum(s : NetrouteospfBuffer) -> Double { @_common.sum(s.data) }

pub fn net_route_ospf_buffer_mean(s : NetrouteospfBuffer) -> Double { @_common.mean(s.data) }

pub fn net_route_ospf_buffer_scale(s : NetrouteospfBuffer, f : Double) -> NetrouteospfBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_route_ospf_buffer_add(a : NetrouteospfBuffer, b : NetrouteospfBuffer) -> NetrouteospfBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_route_ospf_buffer_copy(s : NetrouteospfBuffer) -> NetrouteospfBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_route_ospf_buffer_fill(s : NetrouteospfBuffer, v : Double) -> NetrouteospfBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_route_ospf_buffer_min(s : NetrouteospfBuffer) -> Double { @_common.min(s.data) }

pub fn net_route_ospf_buffer_max(s : NetrouteospfBuffer) -> Double { @_common.max(s.data) }

pub fn net_route_ospf_buffer_to_string(s : NetrouteospfBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetrouteospfCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_route_ospf_cursor_make(size : Int) -> NetrouteospfCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_route_ospf_cursor_len(s : NetrouteospfCursor) -> Int { s.size }

pub fn net_route_ospf_cursor_get(s : NetrouteospfCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_route_ospf_cursor_set(s : NetrouteospfCursor, i : Int, v : Double) -> NetrouteospfCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn net_route_ospf_cursor_sum(s : NetrouteospfCursor) -> Double { @_common.sum(s.data) }

pub fn net_route_ospf_cursor_mean(s : NetrouteospfCursor) -> Double { @_common.mean(s.data) }

pub fn net_route_ospf_cursor_scale(s : NetrouteospfCursor, f : Double) -> NetrouteospfCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_route_ospf_cursor_add(a : NetrouteospfCursor, b : NetrouteospfCursor) -> NetrouteospfCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_route_ospf_cursor_copy(s : NetrouteospfCursor) -> NetrouteospfCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_route_ospf_cursor_fill(s : NetrouteospfCursor, v : Double) -> NetrouteospfCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_route_ospf_cursor_min(s : NetrouteospfCursor) -> Double { @_common.min(s.data) }

pub fn net_route_ospf_cursor_max(s : NetrouteospfCursor) -> Double { @_common.max(s.data) }

pub fn net_route_ospf_cursor_to_string(s : NetrouteospfCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetrouteospfView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_route_ospf_view_make(size : Int) -> NetrouteospfView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_route_ospf_view_len(s : NetrouteospfView) -> Int { s.size }

pub fn net_route_ospf_view_get(s : NetrouteospfView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_route_ospf_view_set(s : NetrouteospfView, i : Int, v : Double) -> NetrouteospfView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn net_route_ospf_view_sum(s : NetrouteospfView) -> Double { @_common.sum(s.data) }

pub fn net_route_ospf_view_mean(s : NetrouteospfView) -> Double { @_common.mean(s.data) }

pub fn net_route_ospf_view_scale(s : NetrouteospfView, f : Double) -> NetrouteospfView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_route_ospf_view_add(a : NetrouteospfView, b : NetrouteospfView) -> NetrouteospfView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_route_ospf_view_copy(s : NetrouteospfView) -> NetrouteospfView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_route_ospf_view_fill(s : NetrouteospfView, v : Double) -> NetrouteospfView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_route_ospf_view_min(s : NetrouteospfView) -> Double { @_common.min(s.data) }

pub fn net_route_ospf_view_max(s : NetrouteospfView) -> Double { @_common.max(s.data) }

pub fn net_route_ospf_view_to_string(s : NetrouteospfView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetrouteospfRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_route_ospf_range_make(size : Int) -> NetrouteospfRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_route_ospf_range_len(s : NetrouteospfRange) -> Int { s.size }

pub fn net_route_ospf_range_get(s : NetrouteospfRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_route_ospf_range_set(s : NetrouteospfRange, i : Int, v : Double) -> NetrouteospfRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn net_route_ospf_range_sum(s : NetrouteospfRange) -> Double { @_common.sum(s.data) }

pub fn net_route_ospf_range_mean(s : NetrouteospfRange) -> Double { @_common.mean(s.data) }

pub fn net_route_ospf_range_scale(s : NetrouteospfRange, f : Double) -> NetrouteospfRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_route_ospf_range_add(a : NetrouteospfRange, b : NetrouteospfRange) -> NetrouteospfRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_route_ospf_range_copy(s : NetrouteospfRange) -> NetrouteospfRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_route_ospf_range_fill(s : NetrouteospfRange, v : Double) -> NetrouteospfRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_route_ospf_range_min(s : NetrouteospfRange) -> Double { @_common.min(s.data) }

pub fn net_route_ospf_range_max(s : NetrouteospfRange) -> Double { @_common.max(s.data) }

pub fn net_route_ospf_range_to_string(s : NetrouteospfRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetrouteospfSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_route_ospf_slice_make(size : Int) -> NetrouteospfSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_route_ospf_slice_len(s : NetrouteospfSlice) -> Int { s.size }

pub fn net_route_ospf_slice_get(s : NetrouteospfSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_route_ospf_slice_set(s : NetrouteospfSlice, i : Int, v : Double) -> NetrouteospfSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn net_route_ospf_slice_sum(s : NetrouteospfSlice) -> Double { @_common.sum(s.data) }

pub fn net_route_ospf_slice_mean(s : NetrouteospfSlice) -> Double { @_common.mean(s.data) }

pub fn net_route_ospf_slice_scale(s : NetrouteospfSlice, f : Double) -> NetrouteospfSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn net_route_ospf_slice_add(a : NetrouteospfSlice, b : NetrouteospfSlice) -> NetrouteospfSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn net_route_ospf_slice_copy(s : NetrouteospfSlice) -> NetrouteospfSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn net_route_ospf_slice_fill(s : NetrouteospfSlice, v : Double) -> NetrouteospfSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn net_route_ospf_slice_min(s : NetrouteospfSlice) -> Double { @_common.min(s.data) }

pub fn net_route_ospf_slice_max(s : NetrouteospfSlice) -> Double { @_common.max(s.data) }

pub fn net_route_ospf_slice_to_string(s : NetrouteospfSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

