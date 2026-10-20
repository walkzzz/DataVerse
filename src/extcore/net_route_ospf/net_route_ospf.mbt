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

pub fn NetrouteospfFrame::len(self : NetrouteospfFrame) -> Int { self.size }

pub fn NetrouteospfFrame::get(self : NetrouteospfFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NetrouteospfFrame::set(self : NetrouteospfFrame, i : Int, v : Double) -> NetrouteospfFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NetrouteospfFrame::sum(self : NetrouteospfFrame) -> Double { @_common.sum(self.data) }

pub fn NetrouteospfFrame::mean(self : NetrouteospfFrame) -> Double { @_common.mean(self.data) }

pub fn NetrouteospfFrame::scale(self : NetrouteospfFrame, f : Double) -> NetrouteospfFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NetrouteospfFrame::add(self : NetrouteospfFrame, other : NetrouteospfFrame) -> NetrouteospfFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NetrouteospfFrame::copy(self : NetrouteospfFrame) -> NetrouteospfFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NetrouteospfFrame::fill(self : NetrouteospfFrame, v : Double) -> NetrouteospfFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NetrouteospfFrame::min(self : NetrouteospfFrame) -> Double { @_common.min(self.data) }

pub fn NetrouteospfFrame::max(self : NetrouteospfFrame) -> Double { @_common.max(self.data) }

pub fn NetrouteospfFrame::to_string(self : NetrouteospfFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NetrouteospfTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_route_ospf_table_make(size : Int) -> NetrouteospfTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NetrouteospfTable::len(self : NetrouteospfTable) -> Int { self.size }

pub fn NetrouteospfTable::get(self : NetrouteospfTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NetrouteospfTable::set(self : NetrouteospfTable, i : Int, v : Double) -> NetrouteospfTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NetrouteospfTable::sum(self : NetrouteospfTable) -> Double { @_common.sum(self.data) }

pub fn NetrouteospfTable::mean(self : NetrouteospfTable) -> Double { @_common.mean(self.data) }

pub fn NetrouteospfTable::scale(self : NetrouteospfTable, f : Double) -> NetrouteospfTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NetrouteospfTable::add(self : NetrouteospfTable, other : NetrouteospfTable) -> NetrouteospfTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NetrouteospfTable::copy(self : NetrouteospfTable) -> NetrouteospfTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NetrouteospfTable::fill(self : NetrouteospfTable, v : Double) -> NetrouteospfTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NetrouteospfTable::min(self : NetrouteospfTable) -> Double { @_common.min(self.data) }

pub fn NetrouteospfTable::max(self : NetrouteospfTable) -> Double { @_common.max(self.data) }

pub fn NetrouteospfTable::to_string(self : NetrouteospfTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NetrouteospfGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_route_ospf_graphn_make(size : Int) -> NetrouteospfGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NetrouteospfGraphN::len(self : NetrouteospfGraphN) -> Int { self.size }

pub fn NetrouteospfGraphN::get(self : NetrouteospfGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NetrouteospfGraphN::set(self : NetrouteospfGraphN, i : Int, v : Double) -> NetrouteospfGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NetrouteospfGraphN::sum(self : NetrouteospfGraphN) -> Double { @_common.sum(self.data) }

pub fn NetrouteospfGraphN::mean(self : NetrouteospfGraphN) -> Double { @_common.mean(self.data) }

pub fn NetrouteospfGraphN::scale(self : NetrouteospfGraphN, f : Double) -> NetrouteospfGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NetrouteospfGraphN::add(self : NetrouteospfGraphN, other : NetrouteospfGraphN) -> NetrouteospfGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NetrouteospfGraphN::copy(self : NetrouteospfGraphN) -> NetrouteospfGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NetrouteospfGraphN::fill(self : NetrouteospfGraphN, v : Double) -> NetrouteospfGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NetrouteospfGraphN::min(self : NetrouteospfGraphN) -> Double { @_common.min(self.data) }

pub fn NetrouteospfGraphN::max(self : NetrouteospfGraphN) -> Double { @_common.max(self.data) }

pub fn NetrouteospfGraphN::to_string(self : NetrouteospfGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NetrouteospfNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_route_ospf_node_make(size : Int) -> NetrouteospfNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NetrouteospfNode::len(self : NetrouteospfNode) -> Int { self.size }

pub fn NetrouteospfNode::get(self : NetrouteospfNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NetrouteospfNode::set(self : NetrouteospfNode, i : Int, v : Double) -> NetrouteospfNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NetrouteospfNode::sum(self : NetrouteospfNode) -> Double { @_common.sum(self.data) }

pub fn NetrouteospfNode::mean(self : NetrouteospfNode) -> Double { @_common.mean(self.data) }

pub fn NetrouteospfNode::scale(self : NetrouteospfNode, f : Double) -> NetrouteospfNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NetrouteospfNode::add(self : NetrouteospfNode, other : NetrouteospfNode) -> NetrouteospfNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NetrouteospfNode::copy(self : NetrouteospfNode) -> NetrouteospfNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NetrouteospfNode::fill(self : NetrouteospfNode, v : Double) -> NetrouteospfNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NetrouteospfNode::min(self : NetrouteospfNode) -> Double { @_common.min(self.data) }

pub fn NetrouteospfNode::max(self : NetrouteospfNode) -> Double { @_common.max(self.data) }

pub fn NetrouteospfNode::to_string(self : NetrouteospfNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NetrouteospfEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_route_ospf_edge_make(size : Int) -> NetrouteospfEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NetrouteospfEdge::len(self : NetrouteospfEdge) -> Int { self.size }

pub fn NetrouteospfEdge::get(self : NetrouteospfEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NetrouteospfEdge::set(self : NetrouteospfEdge, i : Int, v : Double) -> NetrouteospfEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NetrouteospfEdge::sum(self : NetrouteospfEdge) -> Double { @_common.sum(self.data) }

pub fn NetrouteospfEdge::mean(self : NetrouteospfEdge) -> Double { @_common.mean(self.data) }

pub fn NetrouteospfEdge::scale(self : NetrouteospfEdge, f : Double) -> NetrouteospfEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NetrouteospfEdge::add(self : NetrouteospfEdge, other : NetrouteospfEdge) -> NetrouteospfEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NetrouteospfEdge::copy(self : NetrouteospfEdge) -> NetrouteospfEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NetrouteospfEdge::fill(self : NetrouteospfEdge, v : Double) -> NetrouteospfEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NetrouteospfEdge::min(self : NetrouteospfEdge) -> Double { @_common.min(self.data) }

pub fn NetrouteospfEdge::max(self : NetrouteospfEdge) -> Double { @_common.max(self.data) }

pub fn NetrouteospfEdge::to_string(self : NetrouteospfEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NetrouteospfPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_route_ospf_path_make(size : Int) -> NetrouteospfPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NetrouteospfPath::len(self : NetrouteospfPath) -> Int { self.size }

pub fn NetrouteospfPath::get(self : NetrouteospfPath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NetrouteospfPath::set(self : NetrouteospfPath, i : Int, v : Double) -> NetrouteospfPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NetrouteospfPath::sum(self : NetrouteospfPath) -> Double { @_common.sum(self.data) }

pub fn NetrouteospfPath::mean(self : NetrouteospfPath) -> Double { @_common.mean(self.data) }

pub fn NetrouteospfPath::scale(self : NetrouteospfPath, f : Double) -> NetrouteospfPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NetrouteospfPath::add(self : NetrouteospfPath, other : NetrouteospfPath) -> NetrouteospfPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NetrouteospfPath::copy(self : NetrouteospfPath) -> NetrouteospfPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NetrouteospfPath::fill(self : NetrouteospfPath, v : Double) -> NetrouteospfPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NetrouteospfPath::min(self : NetrouteospfPath) -> Double { @_common.min(self.data) }

pub fn NetrouteospfPath::max(self : NetrouteospfPath) -> Double { @_common.max(self.data) }

pub fn NetrouteospfPath::to_string(self : NetrouteospfPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NetrouteospfCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_route_ospf_cluster_make(size : Int) -> NetrouteospfCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NetrouteospfCluster::len(self : NetrouteospfCluster) -> Int { self.size }

pub fn NetrouteospfCluster::get(self : NetrouteospfCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NetrouteospfCluster::set(self : NetrouteospfCluster, i : Int, v : Double) -> NetrouteospfCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NetrouteospfCluster::sum(self : NetrouteospfCluster) -> Double { @_common.sum(self.data) }

pub fn NetrouteospfCluster::mean(self : NetrouteospfCluster) -> Double { @_common.mean(self.data) }

pub fn NetrouteospfCluster::scale(self : NetrouteospfCluster, f : Double) -> NetrouteospfCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NetrouteospfCluster::add(self : NetrouteospfCluster, other : NetrouteospfCluster) -> NetrouteospfCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NetrouteospfCluster::copy(self : NetrouteospfCluster) -> NetrouteospfCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NetrouteospfCluster::fill(self : NetrouteospfCluster, v : Double) -> NetrouteospfCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NetrouteospfCluster::min(self : NetrouteospfCluster) -> Double { @_common.min(self.data) }

pub fn NetrouteospfCluster::max(self : NetrouteospfCluster) -> Double { @_common.max(self.data) }

pub fn NetrouteospfCluster::to_string(self : NetrouteospfCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NetrouteospfModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_route_ospf_model_make(size : Int) -> NetrouteospfModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NetrouteospfModel::len(self : NetrouteospfModel) -> Int { self.size }

pub fn NetrouteospfModel::get(self : NetrouteospfModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NetrouteospfModel::set(self : NetrouteospfModel, i : Int, v : Double) -> NetrouteospfModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NetrouteospfModel::sum(self : NetrouteospfModel) -> Double { @_common.sum(self.data) }

pub fn NetrouteospfModel::mean(self : NetrouteospfModel) -> Double { @_common.mean(self.data) }

pub fn NetrouteospfModel::scale(self : NetrouteospfModel, f : Double) -> NetrouteospfModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NetrouteospfModel::add(self : NetrouteospfModel, other : NetrouteospfModel) -> NetrouteospfModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NetrouteospfModel::copy(self : NetrouteospfModel) -> NetrouteospfModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NetrouteospfModel::fill(self : NetrouteospfModel, v : Double) -> NetrouteospfModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NetrouteospfModel::min(self : NetrouteospfModel) -> Double { @_common.min(self.data) }

pub fn NetrouteospfModel::max(self : NetrouteospfModel) -> Double { @_common.max(self.data) }

pub fn NetrouteospfModel::to_string(self : NetrouteospfModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NetrouteospfLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_route_ospf_layer_make(size : Int) -> NetrouteospfLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NetrouteospfLayer::len(self : NetrouteospfLayer) -> Int { self.size }

pub fn NetrouteospfLayer::get(self : NetrouteospfLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NetrouteospfLayer::set(self : NetrouteospfLayer, i : Int, v : Double) -> NetrouteospfLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NetrouteospfLayer::sum(self : NetrouteospfLayer) -> Double { @_common.sum(self.data) }

pub fn NetrouteospfLayer::mean(self : NetrouteospfLayer) -> Double { @_common.mean(self.data) }

pub fn NetrouteospfLayer::scale(self : NetrouteospfLayer, f : Double) -> NetrouteospfLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NetrouteospfLayer::add(self : NetrouteospfLayer, other : NetrouteospfLayer) -> NetrouteospfLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NetrouteospfLayer::copy(self : NetrouteospfLayer) -> NetrouteospfLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NetrouteospfLayer::fill(self : NetrouteospfLayer, v : Double) -> NetrouteospfLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NetrouteospfLayer::min(self : NetrouteospfLayer) -> Double { @_common.min(self.data) }

pub fn NetrouteospfLayer::max(self : NetrouteospfLayer) -> Double { @_common.max(self.data) }

pub fn NetrouteospfLayer::to_string(self : NetrouteospfLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NetrouteospfBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_route_ospf_buffer_make(size : Int) -> NetrouteospfBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NetrouteospfBuffer::len(self : NetrouteospfBuffer) -> Int { self.size }

pub fn NetrouteospfBuffer::get(self : NetrouteospfBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NetrouteospfBuffer::set(self : NetrouteospfBuffer, i : Int, v : Double) -> NetrouteospfBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NetrouteospfBuffer::sum(self : NetrouteospfBuffer) -> Double { @_common.sum(self.data) }

pub fn NetrouteospfBuffer::mean(self : NetrouteospfBuffer) -> Double { @_common.mean(self.data) }

pub fn NetrouteospfBuffer::scale(self : NetrouteospfBuffer, f : Double) -> NetrouteospfBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NetrouteospfBuffer::add(self : NetrouteospfBuffer, other : NetrouteospfBuffer) -> NetrouteospfBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NetrouteospfBuffer::copy(self : NetrouteospfBuffer) -> NetrouteospfBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NetrouteospfBuffer::fill(self : NetrouteospfBuffer, v : Double) -> NetrouteospfBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NetrouteospfBuffer::min(self : NetrouteospfBuffer) -> Double { @_common.min(self.data) }

pub fn NetrouteospfBuffer::max(self : NetrouteospfBuffer) -> Double { @_common.max(self.data) }

pub fn NetrouteospfBuffer::to_string(self : NetrouteospfBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NetrouteospfCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_route_ospf_cursor_make(size : Int) -> NetrouteospfCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NetrouteospfCursor::len(self : NetrouteospfCursor) -> Int { self.size }

pub fn NetrouteospfCursor::get(self : NetrouteospfCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NetrouteospfCursor::set(self : NetrouteospfCursor, i : Int, v : Double) -> NetrouteospfCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NetrouteospfCursor::sum(self : NetrouteospfCursor) -> Double { @_common.sum(self.data) }

pub fn NetrouteospfCursor::mean(self : NetrouteospfCursor) -> Double { @_common.mean(self.data) }

pub fn NetrouteospfCursor::scale(self : NetrouteospfCursor, f : Double) -> NetrouteospfCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NetrouteospfCursor::add(self : NetrouteospfCursor, other : NetrouteospfCursor) -> NetrouteospfCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NetrouteospfCursor::copy(self : NetrouteospfCursor) -> NetrouteospfCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NetrouteospfCursor::fill(self : NetrouteospfCursor, v : Double) -> NetrouteospfCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NetrouteospfCursor::min(self : NetrouteospfCursor) -> Double { @_common.min(self.data) }

pub fn NetrouteospfCursor::max(self : NetrouteospfCursor) -> Double { @_common.max(self.data) }

pub fn NetrouteospfCursor::to_string(self : NetrouteospfCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NetrouteospfView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_route_ospf_view_make(size : Int) -> NetrouteospfView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NetrouteospfView::len(self : NetrouteospfView) -> Int { self.size }

pub fn NetrouteospfView::get(self : NetrouteospfView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NetrouteospfView::set(self : NetrouteospfView, i : Int, v : Double) -> NetrouteospfView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NetrouteospfView::sum(self : NetrouteospfView) -> Double { @_common.sum(self.data) }

pub fn NetrouteospfView::mean(self : NetrouteospfView) -> Double { @_common.mean(self.data) }

pub fn NetrouteospfView::scale(self : NetrouteospfView, f : Double) -> NetrouteospfView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NetrouteospfView::add(self : NetrouteospfView, other : NetrouteospfView) -> NetrouteospfView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NetrouteospfView::copy(self : NetrouteospfView) -> NetrouteospfView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NetrouteospfView::fill(self : NetrouteospfView, v : Double) -> NetrouteospfView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NetrouteospfView::min(self : NetrouteospfView) -> Double { @_common.min(self.data) }

pub fn NetrouteospfView::max(self : NetrouteospfView) -> Double { @_common.max(self.data) }

pub fn NetrouteospfView::to_string(self : NetrouteospfView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NetrouteospfRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_route_ospf_range_make(size : Int) -> NetrouteospfRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NetrouteospfRange::len(self : NetrouteospfRange) -> Int { self.size }

pub fn NetrouteospfRange::get(self : NetrouteospfRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NetrouteospfRange::set(self : NetrouteospfRange, i : Int, v : Double) -> NetrouteospfRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NetrouteospfRange::sum(self : NetrouteospfRange) -> Double { @_common.sum(self.data) }

pub fn NetrouteospfRange::mean(self : NetrouteospfRange) -> Double { @_common.mean(self.data) }

pub fn NetrouteospfRange::scale(self : NetrouteospfRange, f : Double) -> NetrouteospfRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NetrouteospfRange::add(self : NetrouteospfRange, other : NetrouteospfRange) -> NetrouteospfRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NetrouteospfRange::copy(self : NetrouteospfRange) -> NetrouteospfRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NetrouteospfRange::fill(self : NetrouteospfRange, v : Double) -> NetrouteospfRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NetrouteospfRange::min(self : NetrouteospfRange) -> Double { @_common.min(self.data) }

pub fn NetrouteospfRange::max(self : NetrouteospfRange) -> Double { @_common.max(self.data) }

pub fn NetrouteospfRange::to_string(self : NetrouteospfRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NetrouteospfSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_route_ospf_slice_make(size : Int) -> NetrouteospfSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NetrouteospfSlice::len(self : NetrouteospfSlice) -> Int { self.size }

pub fn NetrouteospfSlice::get(self : NetrouteospfSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NetrouteospfSlice::set(self : NetrouteospfSlice, i : Int, v : Double) -> NetrouteospfSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NetrouteospfSlice::sum(self : NetrouteospfSlice) -> Double { @_common.sum(self.data) }

pub fn NetrouteospfSlice::mean(self : NetrouteospfSlice) -> Double { @_common.mean(self.data) }

pub fn NetrouteospfSlice::scale(self : NetrouteospfSlice, f : Double) -> NetrouteospfSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NetrouteospfSlice::add(self : NetrouteospfSlice, other : NetrouteospfSlice) -> NetrouteospfSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NetrouteospfSlice::copy(self : NetrouteospfSlice) -> NetrouteospfSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NetrouteospfSlice::fill(self : NetrouteospfSlice, v : Double) -> NetrouteospfSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NetrouteospfSlice::min(self : NetrouteospfSlice) -> Double { @_common.min(self.data) }

pub fn NetrouteospfSlice::max(self : NetrouteospfSlice) -> Double { @_common.max(self.data) }

pub fn NetrouteospfSlice::to_string(self : NetrouteospfSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

