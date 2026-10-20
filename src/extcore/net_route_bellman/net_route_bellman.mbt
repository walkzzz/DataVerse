///===
/// extcore/net_route_bellman

pub(all) struct NetroutebellmanPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn net_route_bellman_make_point(x : Double, y : Double) -> NetroutebellmanPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn net_route_bellman_make_point3(x : Double, y : Double, z : Double) -> NetroutebellmanPoint {
  { x, y, z, label: 0 }
}

pub fn NetroutebellmanPoint::x(self : NetroutebellmanPoint) -> Double { self.x }

pub fn NetroutebellmanPoint::y(self : NetroutebellmanPoint) -> Double { self.y }

pub fn NetroutebellmanPoint::z(self : NetroutebellmanPoint) -> Double { self.z }

pub fn NetroutebellmanPoint::label(self : NetroutebellmanPoint) -> Int { self.label }

pub fn NetroutebellmanPoint::dist(self : NetroutebellmanPoint, other : NetroutebellmanPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn NetroutebellmanPoint::add(self : NetroutebellmanPoint, other : NetroutebellmanPoint) -> NetroutebellmanPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn NetroutebellmanPoint::sub(self : NetroutebellmanPoint, other : NetroutebellmanPoint) -> NetroutebellmanPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn NetroutebellmanPoint::scale(self : NetroutebellmanPoint, s : Double) -> NetroutebellmanPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn NetroutebellmanPoint::dot(self : NetroutebellmanPoint, other : NetroutebellmanPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn NetroutebellmanPoint::cross(self : NetroutebellmanPoint, other : NetroutebellmanPoint) -> NetroutebellmanPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn NetroutebellmanPoint::norm(self : NetroutebellmanPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn NetroutebellmanPoint::normalize(self : NetroutebellmanPoint) -> NetroutebellmanPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn NetroutebellmanPoint::negate(self : NetroutebellmanPoint) -> NetroutebellmanPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn NetroutebellmanPoint::mid(self : NetroutebellmanPoint, other : NetroutebellmanPoint) -> NetroutebellmanPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn NetroutebellmanPoint::lerp(self : NetroutebellmanPoint, other : NetroutebellmanPoint, t : Double) -> NetroutebellmanPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn NetroutebellmanPoint::to_string(self : NetroutebellmanPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct NetroutebellmanSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn net_route_bellman_make_series(vals : Array[Double], name : String) -> NetroutebellmanSeries {
  { vals, name, meta: 0 }
}

pub fn NetroutebellmanSeries::len(self : NetroutebellmanSeries) -> Int { self.vals.length() }

pub fn NetroutebellmanSeries::sum(self : NetroutebellmanSeries) -> Double { @_common.sum(self.vals) }

pub fn NetroutebellmanSeries::mean(self : NetroutebellmanSeries) -> Double { @_common.mean(self.vals) }

pub fn NetroutebellmanSeries::min(self : NetroutebellmanSeries) -> Double { @_common.min(self.vals) }

pub fn NetroutebellmanSeries::max(self : NetroutebellmanSeries) -> Double { @_common.max(self.vals) }

pub fn NetroutebellmanSeries::range(self : NetroutebellmanSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn NetroutebellmanSeries::variance(self : NetroutebellmanSeries) -> Double { @_common.variance(self.vals) }

pub fn NetroutebellmanSeries::std(self : NetroutebellmanSeries) -> Double { @_common.std(self.vals) }

pub fn NetroutebellmanSeries::median(self : NetroutebellmanSeries) -> Double { @_common.median(self.vals) }

pub fn NetroutebellmanSeries::scale(self : NetroutebellmanSeries, f : Double) -> NetroutebellmanSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn NetroutebellmanSeries::add(self : NetroutebellmanSeries, other : NetroutebellmanSeries) -> NetroutebellmanSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn NetroutebellmanSeries::sub(self : NetroutebellmanSeries, other : NetroutebellmanSeries) -> NetroutebellmanSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn NetroutebellmanSeries::normalize(self : NetroutebellmanSeries) -> NetroutebellmanSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn NetroutebellmanSeries::cumsum(self : NetroutebellmanSeries) -> NetroutebellmanSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn NetroutebellmanSeries::to_string(self : NetroutebellmanSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct NetroutebellmanMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn net_route_bellman_make_matrix(rows : Int, cols : Int, val : Double) -> NetroutebellmanMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn net_route_bellman_matrix_identity(n : Int) -> NetroutebellmanMatrix {
  let m = net_route_bellman_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn NetroutebellmanMatrix::get(self : NetroutebellmanMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn NetroutebellmanMatrix::transpose(self : NetroutebellmanMatrix) -> NetroutebellmanMatrix {
  let result = net_route_bellman_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn NetroutebellmanMatrix::add(self : NetroutebellmanMatrix, other : NetroutebellmanMatrix) -> NetroutebellmanMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = net_route_bellman_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn NetroutebellmanMatrix::scale(self : NetroutebellmanMatrix, s : Double) -> NetroutebellmanMatrix {
  let result = net_route_bellman_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn NetroutebellmanMatrix::multiply(self : NetroutebellmanMatrix, other : NetroutebellmanMatrix) -> NetroutebellmanMatrix {
  if self.cols != other.rows { return net_route_bellman_make_matrix(self.rows, other.cols, 0.0) }
  let result = net_route_bellman_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn NetroutebellmanMatrix::trace(self : NetroutebellmanMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn NetroutebellmanMatrix::det(self : NetroutebellmanMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn NetroutebellmanMatrix::norm(self : NetroutebellmanMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn NetroutebellmanMatrix::to_string(self : NetroutebellmanMatrix) -> String {
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

pub(all) struct NetroutebellmanVector {
  comps : Array[Double]
  dim : Int
}

pub fn net_route_bellman_make_vector(comps : Array[Double]) -> NetroutebellmanVector {
  { comps, dim: comps.length() }
}

pub fn net_route_bellman_vector_zero(dim : Int) -> NetroutebellmanVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn NetroutebellmanVector::add(self : NetroutebellmanVector, other : NetroutebellmanVector) -> NetroutebellmanVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn NetroutebellmanVector::sub(self : NetroutebellmanVector, other : NetroutebellmanVector) -> NetroutebellmanVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn NetroutebellmanVector::scale(self : NetroutebellmanVector, s : Double) -> NetroutebellmanVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn NetroutebellmanVector::dot(self : NetroutebellmanVector, other : NetroutebellmanVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn NetroutebellmanVector::norm(self : NetroutebellmanVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn NetroutebellmanVector::normalize(self : NetroutebellmanVector) -> NetroutebellmanVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn NetroutebellmanVector::dist(self : NetroutebellmanVector, other : NetroutebellmanVector) -> Double {
  self.sub(other).norm()
}

pub fn NetroutebellmanVector::to_string(self : NetroutebellmanVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn net_route_bellman_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn net_route_bellman_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn net_route_bellman_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn net_route_bellman_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn net_route_bellman_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn net_route_bellman_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn net_route_bellman_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn net_route_bellman_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn net_route_bellman_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn net_route_bellman_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn net_route_bellman_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn net_route_bellman_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn net_route_bellman_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn net_route_bellman_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn net_route_bellman_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn net_route_bellman_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn net_route_bellman_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn net_route_bellman_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn net_route_bellman_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn net_route_bellman_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn net_route_bellman_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn net_route_bellman_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn net_route_bellman_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn net_route_bellman_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn net_route_bellman_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn net_route_bellman_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn net_route_bellman_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn net_route_bellman_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn net_route_bellman_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct NetroutebellmanFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_route_bellman_frame_make(size : Int) -> NetroutebellmanFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NetroutebellmanFrame::len(self : NetroutebellmanFrame) -> Int { self.size }

pub fn NetroutebellmanFrame::get(self : NetroutebellmanFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NetroutebellmanFrame::set(self : NetroutebellmanFrame, i : Int, v : Double) -> NetroutebellmanFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NetroutebellmanFrame::sum(self : NetroutebellmanFrame) -> Double { @_common.sum(self.data) }

pub fn NetroutebellmanFrame::mean(self : NetroutebellmanFrame) -> Double { @_common.mean(self.data) }

pub fn NetroutebellmanFrame::scale(self : NetroutebellmanFrame, f : Double) -> NetroutebellmanFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NetroutebellmanFrame::add(self : NetroutebellmanFrame, other : NetroutebellmanFrame) -> NetroutebellmanFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NetroutebellmanFrame::copy(self : NetroutebellmanFrame) -> NetroutebellmanFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NetroutebellmanFrame::fill(self : NetroutebellmanFrame, v : Double) -> NetroutebellmanFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NetroutebellmanFrame::min(self : NetroutebellmanFrame) -> Double { @_common.min(self.data) }

pub fn NetroutebellmanFrame::max(self : NetroutebellmanFrame) -> Double { @_common.max(self.data) }

pub fn NetroutebellmanFrame::to_string(self : NetroutebellmanFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NetroutebellmanTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_route_bellman_table_make(size : Int) -> NetroutebellmanTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NetroutebellmanTable::len(self : NetroutebellmanTable) -> Int { self.size }

pub fn NetroutebellmanTable::get(self : NetroutebellmanTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NetroutebellmanTable::set(self : NetroutebellmanTable, i : Int, v : Double) -> NetroutebellmanTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NetroutebellmanTable::sum(self : NetroutebellmanTable) -> Double { @_common.sum(self.data) }

pub fn NetroutebellmanTable::mean(self : NetroutebellmanTable) -> Double { @_common.mean(self.data) }

pub fn NetroutebellmanTable::scale(self : NetroutebellmanTable, f : Double) -> NetroutebellmanTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NetroutebellmanTable::add(self : NetroutebellmanTable, other : NetroutebellmanTable) -> NetroutebellmanTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NetroutebellmanTable::copy(self : NetroutebellmanTable) -> NetroutebellmanTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NetroutebellmanTable::fill(self : NetroutebellmanTable, v : Double) -> NetroutebellmanTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NetroutebellmanTable::min(self : NetroutebellmanTable) -> Double { @_common.min(self.data) }

pub fn NetroutebellmanTable::max(self : NetroutebellmanTable) -> Double { @_common.max(self.data) }

pub fn NetroutebellmanTable::to_string(self : NetroutebellmanTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NetroutebellmanGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_route_bellman_graphn_make(size : Int) -> NetroutebellmanGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NetroutebellmanGraphN::len(self : NetroutebellmanGraphN) -> Int { self.size }

pub fn NetroutebellmanGraphN::get(self : NetroutebellmanGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NetroutebellmanGraphN::set(self : NetroutebellmanGraphN, i : Int, v : Double) -> NetroutebellmanGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NetroutebellmanGraphN::sum(self : NetroutebellmanGraphN) -> Double { @_common.sum(self.data) }

pub fn NetroutebellmanGraphN::mean(self : NetroutebellmanGraphN) -> Double { @_common.mean(self.data) }

pub fn NetroutebellmanGraphN::scale(self : NetroutebellmanGraphN, f : Double) -> NetroutebellmanGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NetroutebellmanGraphN::add(self : NetroutebellmanGraphN, other : NetroutebellmanGraphN) -> NetroutebellmanGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NetroutebellmanGraphN::copy(self : NetroutebellmanGraphN) -> NetroutebellmanGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NetroutebellmanGraphN::fill(self : NetroutebellmanGraphN, v : Double) -> NetroutebellmanGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NetroutebellmanGraphN::min(self : NetroutebellmanGraphN) -> Double { @_common.min(self.data) }

pub fn NetroutebellmanGraphN::max(self : NetroutebellmanGraphN) -> Double { @_common.max(self.data) }

pub fn NetroutebellmanGraphN::to_string(self : NetroutebellmanGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NetroutebellmanNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_route_bellman_node_make(size : Int) -> NetroutebellmanNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NetroutebellmanNode::len(self : NetroutebellmanNode) -> Int { self.size }

pub fn NetroutebellmanNode::get(self : NetroutebellmanNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NetroutebellmanNode::set(self : NetroutebellmanNode, i : Int, v : Double) -> NetroutebellmanNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NetroutebellmanNode::sum(self : NetroutebellmanNode) -> Double { @_common.sum(self.data) }

pub fn NetroutebellmanNode::mean(self : NetroutebellmanNode) -> Double { @_common.mean(self.data) }

pub fn NetroutebellmanNode::scale(self : NetroutebellmanNode, f : Double) -> NetroutebellmanNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NetroutebellmanNode::add(self : NetroutebellmanNode, other : NetroutebellmanNode) -> NetroutebellmanNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NetroutebellmanNode::copy(self : NetroutebellmanNode) -> NetroutebellmanNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NetroutebellmanNode::fill(self : NetroutebellmanNode, v : Double) -> NetroutebellmanNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NetroutebellmanNode::min(self : NetroutebellmanNode) -> Double { @_common.min(self.data) }

pub fn NetroutebellmanNode::max(self : NetroutebellmanNode) -> Double { @_common.max(self.data) }

pub fn NetroutebellmanNode::to_string(self : NetroutebellmanNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NetroutebellmanEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_route_bellman_edge_make(size : Int) -> NetroutebellmanEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NetroutebellmanEdge::len(self : NetroutebellmanEdge) -> Int { self.size }

pub fn NetroutebellmanEdge::get(self : NetroutebellmanEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NetroutebellmanEdge::set(self : NetroutebellmanEdge, i : Int, v : Double) -> NetroutebellmanEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NetroutebellmanEdge::sum(self : NetroutebellmanEdge) -> Double { @_common.sum(self.data) }

pub fn NetroutebellmanEdge::mean(self : NetroutebellmanEdge) -> Double { @_common.mean(self.data) }

pub fn NetroutebellmanEdge::scale(self : NetroutebellmanEdge, f : Double) -> NetroutebellmanEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NetroutebellmanEdge::add(self : NetroutebellmanEdge, other : NetroutebellmanEdge) -> NetroutebellmanEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NetroutebellmanEdge::copy(self : NetroutebellmanEdge) -> NetroutebellmanEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NetroutebellmanEdge::fill(self : NetroutebellmanEdge, v : Double) -> NetroutebellmanEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NetroutebellmanEdge::min(self : NetroutebellmanEdge) -> Double { @_common.min(self.data) }

pub fn NetroutebellmanEdge::max(self : NetroutebellmanEdge) -> Double { @_common.max(self.data) }

pub fn NetroutebellmanEdge::to_string(self : NetroutebellmanEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NetroutebellmanPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_route_bellman_path_make(size : Int) -> NetroutebellmanPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NetroutebellmanPath::len(self : NetroutebellmanPath) -> Int { self.size }

pub fn NetroutebellmanPath::get(self : NetroutebellmanPath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NetroutebellmanPath::set(self : NetroutebellmanPath, i : Int, v : Double) -> NetroutebellmanPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NetroutebellmanPath::sum(self : NetroutebellmanPath) -> Double { @_common.sum(self.data) }

pub fn NetroutebellmanPath::mean(self : NetroutebellmanPath) -> Double { @_common.mean(self.data) }

pub fn NetroutebellmanPath::scale(self : NetroutebellmanPath, f : Double) -> NetroutebellmanPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NetroutebellmanPath::add(self : NetroutebellmanPath, other : NetroutebellmanPath) -> NetroutebellmanPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NetroutebellmanPath::copy(self : NetroutebellmanPath) -> NetroutebellmanPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NetroutebellmanPath::fill(self : NetroutebellmanPath, v : Double) -> NetroutebellmanPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NetroutebellmanPath::min(self : NetroutebellmanPath) -> Double { @_common.min(self.data) }

pub fn NetroutebellmanPath::max(self : NetroutebellmanPath) -> Double { @_common.max(self.data) }

pub fn NetroutebellmanPath::to_string(self : NetroutebellmanPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NetroutebellmanCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_route_bellman_cluster_make(size : Int) -> NetroutebellmanCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NetroutebellmanCluster::len(self : NetroutebellmanCluster) -> Int { self.size }

pub fn NetroutebellmanCluster::get(self : NetroutebellmanCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NetroutebellmanCluster::set(self : NetroutebellmanCluster, i : Int, v : Double) -> NetroutebellmanCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NetroutebellmanCluster::sum(self : NetroutebellmanCluster) -> Double { @_common.sum(self.data) }

pub fn NetroutebellmanCluster::mean(self : NetroutebellmanCluster) -> Double { @_common.mean(self.data) }

pub fn NetroutebellmanCluster::scale(self : NetroutebellmanCluster, f : Double) -> NetroutebellmanCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NetroutebellmanCluster::add(self : NetroutebellmanCluster, other : NetroutebellmanCluster) -> NetroutebellmanCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NetroutebellmanCluster::copy(self : NetroutebellmanCluster) -> NetroutebellmanCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NetroutebellmanCluster::fill(self : NetroutebellmanCluster, v : Double) -> NetroutebellmanCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NetroutebellmanCluster::min(self : NetroutebellmanCluster) -> Double { @_common.min(self.data) }

pub fn NetroutebellmanCluster::max(self : NetroutebellmanCluster) -> Double { @_common.max(self.data) }

pub fn NetroutebellmanCluster::to_string(self : NetroutebellmanCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NetroutebellmanModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_route_bellman_model_make(size : Int) -> NetroutebellmanModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NetroutebellmanModel::len(self : NetroutebellmanModel) -> Int { self.size }

pub fn NetroutebellmanModel::get(self : NetroutebellmanModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NetroutebellmanModel::set(self : NetroutebellmanModel, i : Int, v : Double) -> NetroutebellmanModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NetroutebellmanModel::sum(self : NetroutebellmanModel) -> Double { @_common.sum(self.data) }

pub fn NetroutebellmanModel::mean(self : NetroutebellmanModel) -> Double { @_common.mean(self.data) }

pub fn NetroutebellmanModel::scale(self : NetroutebellmanModel, f : Double) -> NetroutebellmanModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NetroutebellmanModel::add(self : NetroutebellmanModel, other : NetroutebellmanModel) -> NetroutebellmanModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NetroutebellmanModel::copy(self : NetroutebellmanModel) -> NetroutebellmanModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NetroutebellmanModel::fill(self : NetroutebellmanModel, v : Double) -> NetroutebellmanModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NetroutebellmanModel::min(self : NetroutebellmanModel) -> Double { @_common.min(self.data) }

pub fn NetroutebellmanModel::max(self : NetroutebellmanModel) -> Double { @_common.max(self.data) }

pub fn NetroutebellmanModel::to_string(self : NetroutebellmanModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NetroutebellmanLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_route_bellman_layer_make(size : Int) -> NetroutebellmanLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NetroutebellmanLayer::len(self : NetroutebellmanLayer) -> Int { self.size }

pub fn NetroutebellmanLayer::get(self : NetroutebellmanLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NetroutebellmanLayer::set(self : NetroutebellmanLayer, i : Int, v : Double) -> NetroutebellmanLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NetroutebellmanLayer::sum(self : NetroutebellmanLayer) -> Double { @_common.sum(self.data) }

pub fn NetroutebellmanLayer::mean(self : NetroutebellmanLayer) -> Double { @_common.mean(self.data) }

pub fn NetroutebellmanLayer::scale(self : NetroutebellmanLayer, f : Double) -> NetroutebellmanLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NetroutebellmanLayer::add(self : NetroutebellmanLayer, other : NetroutebellmanLayer) -> NetroutebellmanLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NetroutebellmanLayer::copy(self : NetroutebellmanLayer) -> NetroutebellmanLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NetroutebellmanLayer::fill(self : NetroutebellmanLayer, v : Double) -> NetroutebellmanLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NetroutebellmanLayer::min(self : NetroutebellmanLayer) -> Double { @_common.min(self.data) }

pub fn NetroutebellmanLayer::max(self : NetroutebellmanLayer) -> Double { @_common.max(self.data) }

pub fn NetroutebellmanLayer::to_string(self : NetroutebellmanLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NetroutebellmanBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_route_bellman_buffer_make(size : Int) -> NetroutebellmanBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NetroutebellmanBuffer::len(self : NetroutebellmanBuffer) -> Int { self.size }

pub fn NetroutebellmanBuffer::get(self : NetroutebellmanBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NetroutebellmanBuffer::set(self : NetroutebellmanBuffer, i : Int, v : Double) -> NetroutebellmanBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NetroutebellmanBuffer::sum(self : NetroutebellmanBuffer) -> Double { @_common.sum(self.data) }

pub fn NetroutebellmanBuffer::mean(self : NetroutebellmanBuffer) -> Double { @_common.mean(self.data) }

pub fn NetroutebellmanBuffer::scale(self : NetroutebellmanBuffer, f : Double) -> NetroutebellmanBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NetroutebellmanBuffer::add(self : NetroutebellmanBuffer, other : NetroutebellmanBuffer) -> NetroutebellmanBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NetroutebellmanBuffer::copy(self : NetroutebellmanBuffer) -> NetroutebellmanBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NetroutebellmanBuffer::fill(self : NetroutebellmanBuffer, v : Double) -> NetroutebellmanBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NetroutebellmanBuffer::min(self : NetroutebellmanBuffer) -> Double { @_common.min(self.data) }

pub fn NetroutebellmanBuffer::max(self : NetroutebellmanBuffer) -> Double { @_common.max(self.data) }

pub fn NetroutebellmanBuffer::to_string(self : NetroutebellmanBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NetroutebellmanCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_route_bellman_cursor_make(size : Int) -> NetroutebellmanCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NetroutebellmanCursor::len(self : NetroutebellmanCursor) -> Int { self.size }

pub fn NetroutebellmanCursor::get(self : NetroutebellmanCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NetroutebellmanCursor::set(self : NetroutebellmanCursor, i : Int, v : Double) -> NetroutebellmanCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NetroutebellmanCursor::sum(self : NetroutebellmanCursor) -> Double { @_common.sum(self.data) }

pub fn NetroutebellmanCursor::mean(self : NetroutebellmanCursor) -> Double { @_common.mean(self.data) }

pub fn NetroutebellmanCursor::scale(self : NetroutebellmanCursor, f : Double) -> NetroutebellmanCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NetroutebellmanCursor::add(self : NetroutebellmanCursor, other : NetroutebellmanCursor) -> NetroutebellmanCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NetroutebellmanCursor::copy(self : NetroutebellmanCursor) -> NetroutebellmanCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NetroutebellmanCursor::fill(self : NetroutebellmanCursor, v : Double) -> NetroutebellmanCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NetroutebellmanCursor::min(self : NetroutebellmanCursor) -> Double { @_common.min(self.data) }

pub fn NetroutebellmanCursor::max(self : NetroutebellmanCursor) -> Double { @_common.max(self.data) }

pub fn NetroutebellmanCursor::to_string(self : NetroutebellmanCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NetroutebellmanView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_route_bellman_view_make(size : Int) -> NetroutebellmanView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NetroutebellmanView::len(self : NetroutebellmanView) -> Int { self.size }

pub fn NetroutebellmanView::get(self : NetroutebellmanView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NetroutebellmanView::set(self : NetroutebellmanView, i : Int, v : Double) -> NetroutebellmanView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NetroutebellmanView::sum(self : NetroutebellmanView) -> Double { @_common.sum(self.data) }

pub fn NetroutebellmanView::mean(self : NetroutebellmanView) -> Double { @_common.mean(self.data) }

pub fn NetroutebellmanView::scale(self : NetroutebellmanView, f : Double) -> NetroutebellmanView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NetroutebellmanView::add(self : NetroutebellmanView, other : NetroutebellmanView) -> NetroutebellmanView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NetroutebellmanView::copy(self : NetroutebellmanView) -> NetroutebellmanView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NetroutebellmanView::fill(self : NetroutebellmanView, v : Double) -> NetroutebellmanView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NetroutebellmanView::min(self : NetroutebellmanView) -> Double { @_common.min(self.data) }

pub fn NetroutebellmanView::max(self : NetroutebellmanView) -> Double { @_common.max(self.data) }

pub fn NetroutebellmanView::to_string(self : NetroutebellmanView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NetroutebellmanRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_route_bellman_range_make(size : Int) -> NetroutebellmanRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NetroutebellmanRange::len(self : NetroutebellmanRange) -> Int { self.size }

pub fn NetroutebellmanRange::get(self : NetroutebellmanRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NetroutebellmanRange::set(self : NetroutebellmanRange, i : Int, v : Double) -> NetroutebellmanRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NetroutebellmanRange::sum(self : NetroutebellmanRange) -> Double { @_common.sum(self.data) }

pub fn NetroutebellmanRange::mean(self : NetroutebellmanRange) -> Double { @_common.mean(self.data) }

pub fn NetroutebellmanRange::scale(self : NetroutebellmanRange, f : Double) -> NetroutebellmanRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NetroutebellmanRange::add(self : NetroutebellmanRange, other : NetroutebellmanRange) -> NetroutebellmanRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NetroutebellmanRange::copy(self : NetroutebellmanRange) -> NetroutebellmanRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NetroutebellmanRange::fill(self : NetroutebellmanRange, v : Double) -> NetroutebellmanRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NetroutebellmanRange::min(self : NetroutebellmanRange) -> Double { @_common.min(self.data) }

pub fn NetroutebellmanRange::max(self : NetroutebellmanRange) -> Double { @_common.max(self.data) }

pub fn NetroutebellmanRange::to_string(self : NetroutebellmanRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NetroutebellmanSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_route_bellman_slice_make(size : Int) -> NetroutebellmanSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NetroutebellmanSlice::len(self : NetroutebellmanSlice) -> Int { self.size }

pub fn NetroutebellmanSlice::get(self : NetroutebellmanSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NetroutebellmanSlice::set(self : NetroutebellmanSlice, i : Int, v : Double) -> NetroutebellmanSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NetroutebellmanSlice::sum(self : NetroutebellmanSlice) -> Double { @_common.sum(self.data) }

pub fn NetroutebellmanSlice::mean(self : NetroutebellmanSlice) -> Double { @_common.mean(self.data) }

pub fn NetroutebellmanSlice::scale(self : NetroutebellmanSlice, f : Double) -> NetroutebellmanSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NetroutebellmanSlice::add(self : NetroutebellmanSlice, other : NetroutebellmanSlice) -> NetroutebellmanSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NetroutebellmanSlice::copy(self : NetroutebellmanSlice) -> NetroutebellmanSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NetroutebellmanSlice::fill(self : NetroutebellmanSlice, v : Double) -> NetroutebellmanSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NetroutebellmanSlice::min(self : NetroutebellmanSlice) -> Double { @_common.min(self.data) }

pub fn NetroutebellmanSlice::max(self : NetroutebellmanSlice) -> Double { @_common.max(self.data) }

pub fn NetroutebellmanSlice::to_string(self : NetroutebellmanSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

