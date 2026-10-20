///===
/// extcore/geo_dist_rhumb

pub(all) struct GeodistrhumbPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn geo_dist_rhumb_make_point(x : Double, y : Double) -> GeodistrhumbPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn geo_dist_rhumb_make_point3(x : Double, y : Double, z : Double) -> GeodistrhumbPoint {
  { x, y, z, label: 0 }
}

pub fn GeodistrhumbPoint::x(self : GeodistrhumbPoint) -> Double { self.x }

pub fn GeodistrhumbPoint::y(self : GeodistrhumbPoint) -> Double { self.y }

pub fn GeodistrhumbPoint::z(self : GeodistrhumbPoint) -> Double { self.z }

pub fn GeodistrhumbPoint::label(self : GeodistrhumbPoint) -> Int { self.label }

pub fn GeodistrhumbPoint::dist(self : GeodistrhumbPoint, other : GeodistrhumbPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn GeodistrhumbPoint::add(self : GeodistrhumbPoint, other : GeodistrhumbPoint) -> GeodistrhumbPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn GeodistrhumbPoint::sub(self : GeodistrhumbPoint, other : GeodistrhumbPoint) -> GeodistrhumbPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn GeodistrhumbPoint::scale(self : GeodistrhumbPoint, s : Double) -> GeodistrhumbPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn GeodistrhumbPoint::dot(self : GeodistrhumbPoint, other : GeodistrhumbPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn GeodistrhumbPoint::cross(self : GeodistrhumbPoint, other : GeodistrhumbPoint) -> GeodistrhumbPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn GeodistrhumbPoint::norm(self : GeodistrhumbPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn GeodistrhumbPoint::normalize(self : GeodistrhumbPoint) -> GeodistrhumbPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn GeodistrhumbPoint::negate(self : GeodistrhumbPoint) -> GeodistrhumbPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn GeodistrhumbPoint::mid(self : GeodistrhumbPoint, other : GeodistrhumbPoint) -> GeodistrhumbPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn GeodistrhumbPoint::lerp(self : GeodistrhumbPoint, other : GeodistrhumbPoint, t : Double) -> GeodistrhumbPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn GeodistrhumbPoint::to_string(self : GeodistrhumbPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct GeodistrhumbSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn geo_dist_rhumb_make_series(vals : Array[Double], name : String) -> GeodistrhumbSeries {
  { vals, name, meta: 0 }
}

pub fn GeodistrhumbSeries::len(self : GeodistrhumbSeries) -> Int { self.vals.length() }

pub fn GeodistrhumbSeries::sum(self : GeodistrhumbSeries) -> Double { @_common.sum(self.vals) }

pub fn GeodistrhumbSeries::mean(self : GeodistrhumbSeries) -> Double { @_common.mean(self.vals) }

pub fn GeodistrhumbSeries::min(self : GeodistrhumbSeries) -> Double { @_common.min(self.vals) }

pub fn GeodistrhumbSeries::max(self : GeodistrhumbSeries) -> Double { @_common.max(self.vals) }

pub fn GeodistrhumbSeries::range(self : GeodistrhumbSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn GeodistrhumbSeries::variance(self : GeodistrhumbSeries) -> Double { @_common.variance(self.vals) }

pub fn GeodistrhumbSeries::std(self : GeodistrhumbSeries) -> Double { @_common.std(self.vals) }

pub fn GeodistrhumbSeries::median(self : GeodistrhumbSeries) -> Double { @_common.median(self.vals) }

pub fn GeodistrhumbSeries::scale(self : GeodistrhumbSeries, f : Double) -> GeodistrhumbSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn GeodistrhumbSeries::add(self : GeodistrhumbSeries, other : GeodistrhumbSeries) -> GeodistrhumbSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn GeodistrhumbSeries::sub(self : GeodistrhumbSeries, other : GeodistrhumbSeries) -> GeodistrhumbSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn GeodistrhumbSeries::normalize(self : GeodistrhumbSeries) -> GeodistrhumbSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn GeodistrhumbSeries::cumsum(self : GeodistrhumbSeries) -> GeodistrhumbSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn GeodistrhumbSeries::to_string(self : GeodistrhumbSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct GeodistrhumbMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn geo_dist_rhumb_make_matrix(rows : Int, cols : Int, val : Double) -> GeodistrhumbMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn geo_dist_rhumb_matrix_identity(n : Int) -> GeodistrhumbMatrix {
  let m = geo_dist_rhumb_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn GeodistrhumbMatrix::get(self : GeodistrhumbMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn GeodistrhumbMatrix::transpose(self : GeodistrhumbMatrix) -> GeodistrhumbMatrix {
  let result = geo_dist_rhumb_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn GeodistrhumbMatrix::add(self : GeodistrhumbMatrix, other : GeodistrhumbMatrix) -> GeodistrhumbMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = geo_dist_rhumb_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn GeodistrhumbMatrix::scale(self : GeodistrhumbMatrix, s : Double) -> GeodistrhumbMatrix {
  let result = geo_dist_rhumb_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn GeodistrhumbMatrix::multiply(self : GeodistrhumbMatrix, other : GeodistrhumbMatrix) -> GeodistrhumbMatrix {
  if self.cols != other.rows { return geo_dist_rhumb_make_matrix(self.rows, other.cols, 0.0) }
  let result = geo_dist_rhumb_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn GeodistrhumbMatrix::trace(self : GeodistrhumbMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn GeodistrhumbMatrix::det(self : GeodistrhumbMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn GeodistrhumbMatrix::norm(self : GeodistrhumbMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn GeodistrhumbMatrix::to_string(self : GeodistrhumbMatrix) -> String {
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

pub(all) struct GeodistrhumbVector {
  comps : Array[Double]
  dim : Int
}

pub fn geo_dist_rhumb_make_vector(comps : Array[Double]) -> GeodistrhumbVector {
  { comps, dim: comps.length() }
}

pub fn geo_dist_rhumb_vector_zero(dim : Int) -> GeodistrhumbVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn GeodistrhumbVector::add(self : GeodistrhumbVector, other : GeodistrhumbVector) -> GeodistrhumbVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn GeodistrhumbVector::sub(self : GeodistrhumbVector, other : GeodistrhumbVector) -> GeodistrhumbVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn GeodistrhumbVector::scale(self : GeodistrhumbVector, s : Double) -> GeodistrhumbVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn GeodistrhumbVector::dot(self : GeodistrhumbVector, other : GeodistrhumbVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn GeodistrhumbVector::norm(self : GeodistrhumbVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn GeodistrhumbVector::normalize(self : GeodistrhumbVector) -> GeodistrhumbVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn GeodistrhumbVector::dist(self : GeodistrhumbVector, other : GeodistrhumbVector) -> Double {
  self.sub(other).norm()
}

pub fn GeodistrhumbVector::to_string(self : GeodistrhumbVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn geo_dist_rhumb_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn geo_dist_rhumb_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn geo_dist_rhumb_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn geo_dist_rhumb_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn geo_dist_rhumb_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn geo_dist_rhumb_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn geo_dist_rhumb_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn geo_dist_rhumb_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn geo_dist_rhumb_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn geo_dist_rhumb_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn geo_dist_rhumb_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn geo_dist_rhumb_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn geo_dist_rhumb_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn geo_dist_rhumb_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn geo_dist_rhumb_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn geo_dist_rhumb_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn geo_dist_rhumb_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn geo_dist_rhumb_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn geo_dist_rhumb_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn geo_dist_rhumb_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn geo_dist_rhumb_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn geo_dist_rhumb_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn geo_dist_rhumb_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn geo_dist_rhumb_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn geo_dist_rhumb_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn geo_dist_rhumb_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn geo_dist_rhumb_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn geo_dist_rhumb_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn geo_dist_rhumb_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct GeodistrhumbFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_dist_rhumb_frame_make(size : Int) -> GeodistrhumbFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GeodistrhumbFrame::len(self : GeodistrhumbFrame) -> Int { self.size }

pub fn GeodistrhumbFrame::get(self : GeodistrhumbFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GeodistrhumbFrame::set(self : GeodistrhumbFrame, i : Int, v : Double) -> GeodistrhumbFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GeodistrhumbFrame::sum(self : GeodistrhumbFrame) -> Double { @_common.sum(self.data) }

pub fn GeodistrhumbFrame::mean(self : GeodistrhumbFrame) -> Double { @_common.mean(self.data) }

pub fn GeodistrhumbFrame::scale(self : GeodistrhumbFrame, f : Double) -> GeodistrhumbFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GeodistrhumbFrame::add(self : GeodistrhumbFrame, other : GeodistrhumbFrame) -> GeodistrhumbFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GeodistrhumbFrame::copy(self : GeodistrhumbFrame) -> GeodistrhumbFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GeodistrhumbFrame::fill(self : GeodistrhumbFrame, v : Double) -> GeodistrhumbFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GeodistrhumbFrame::min(self : GeodistrhumbFrame) -> Double { @_common.min(self.data) }

pub fn GeodistrhumbFrame::max(self : GeodistrhumbFrame) -> Double { @_common.max(self.data) }

pub fn GeodistrhumbFrame::to_string(self : GeodistrhumbFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GeodistrhumbTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_dist_rhumb_table_make(size : Int) -> GeodistrhumbTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GeodistrhumbTable::len(self : GeodistrhumbTable) -> Int { self.size }

pub fn GeodistrhumbTable::get(self : GeodistrhumbTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GeodistrhumbTable::set(self : GeodistrhumbTable, i : Int, v : Double) -> GeodistrhumbTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GeodistrhumbTable::sum(self : GeodistrhumbTable) -> Double { @_common.sum(self.data) }

pub fn GeodistrhumbTable::mean(self : GeodistrhumbTable) -> Double { @_common.mean(self.data) }

pub fn GeodistrhumbTable::scale(self : GeodistrhumbTable, f : Double) -> GeodistrhumbTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GeodistrhumbTable::add(self : GeodistrhumbTable, other : GeodistrhumbTable) -> GeodistrhumbTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GeodistrhumbTable::copy(self : GeodistrhumbTable) -> GeodistrhumbTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GeodistrhumbTable::fill(self : GeodistrhumbTable, v : Double) -> GeodistrhumbTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GeodistrhumbTable::min(self : GeodistrhumbTable) -> Double { @_common.min(self.data) }

pub fn GeodistrhumbTable::max(self : GeodistrhumbTable) -> Double { @_common.max(self.data) }

pub fn GeodistrhumbTable::to_string(self : GeodistrhumbTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GeodistrhumbGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_dist_rhumb_graphn_make(size : Int) -> GeodistrhumbGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GeodistrhumbGraphN::len(self : GeodistrhumbGraphN) -> Int { self.size }

pub fn GeodistrhumbGraphN::get(self : GeodistrhumbGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GeodistrhumbGraphN::set(self : GeodistrhumbGraphN, i : Int, v : Double) -> GeodistrhumbGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GeodistrhumbGraphN::sum(self : GeodistrhumbGraphN) -> Double { @_common.sum(self.data) }

pub fn GeodistrhumbGraphN::mean(self : GeodistrhumbGraphN) -> Double { @_common.mean(self.data) }

pub fn GeodistrhumbGraphN::scale(self : GeodistrhumbGraphN, f : Double) -> GeodistrhumbGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GeodistrhumbGraphN::add(self : GeodistrhumbGraphN, other : GeodistrhumbGraphN) -> GeodistrhumbGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GeodistrhumbGraphN::copy(self : GeodistrhumbGraphN) -> GeodistrhumbGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GeodistrhumbGraphN::fill(self : GeodistrhumbGraphN, v : Double) -> GeodistrhumbGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GeodistrhumbGraphN::min(self : GeodistrhumbGraphN) -> Double { @_common.min(self.data) }

pub fn GeodistrhumbGraphN::max(self : GeodistrhumbGraphN) -> Double { @_common.max(self.data) }

pub fn GeodistrhumbGraphN::to_string(self : GeodistrhumbGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GeodistrhumbNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_dist_rhumb_node_make(size : Int) -> GeodistrhumbNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GeodistrhumbNode::len(self : GeodistrhumbNode) -> Int { self.size }

pub fn GeodistrhumbNode::get(self : GeodistrhumbNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GeodistrhumbNode::set(self : GeodistrhumbNode, i : Int, v : Double) -> GeodistrhumbNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GeodistrhumbNode::sum(self : GeodistrhumbNode) -> Double { @_common.sum(self.data) }

pub fn GeodistrhumbNode::mean(self : GeodistrhumbNode) -> Double { @_common.mean(self.data) }

pub fn GeodistrhumbNode::scale(self : GeodistrhumbNode, f : Double) -> GeodistrhumbNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GeodistrhumbNode::add(self : GeodistrhumbNode, other : GeodistrhumbNode) -> GeodistrhumbNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GeodistrhumbNode::copy(self : GeodistrhumbNode) -> GeodistrhumbNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GeodistrhumbNode::fill(self : GeodistrhumbNode, v : Double) -> GeodistrhumbNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GeodistrhumbNode::min(self : GeodistrhumbNode) -> Double { @_common.min(self.data) }

pub fn GeodistrhumbNode::max(self : GeodistrhumbNode) -> Double { @_common.max(self.data) }

pub fn GeodistrhumbNode::to_string(self : GeodistrhumbNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GeodistrhumbEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_dist_rhumb_edge_make(size : Int) -> GeodistrhumbEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GeodistrhumbEdge::len(self : GeodistrhumbEdge) -> Int { self.size }

pub fn GeodistrhumbEdge::get(self : GeodistrhumbEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GeodistrhumbEdge::set(self : GeodistrhumbEdge, i : Int, v : Double) -> GeodistrhumbEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GeodistrhumbEdge::sum(self : GeodistrhumbEdge) -> Double { @_common.sum(self.data) }

pub fn GeodistrhumbEdge::mean(self : GeodistrhumbEdge) -> Double { @_common.mean(self.data) }

pub fn GeodistrhumbEdge::scale(self : GeodistrhumbEdge, f : Double) -> GeodistrhumbEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GeodistrhumbEdge::add(self : GeodistrhumbEdge, other : GeodistrhumbEdge) -> GeodistrhumbEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GeodistrhumbEdge::copy(self : GeodistrhumbEdge) -> GeodistrhumbEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GeodistrhumbEdge::fill(self : GeodistrhumbEdge, v : Double) -> GeodistrhumbEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GeodistrhumbEdge::min(self : GeodistrhumbEdge) -> Double { @_common.min(self.data) }

pub fn GeodistrhumbEdge::max(self : GeodistrhumbEdge) -> Double { @_common.max(self.data) }

pub fn GeodistrhumbEdge::to_string(self : GeodistrhumbEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GeodistrhumbPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_dist_rhumb_path_make(size : Int) -> GeodistrhumbPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GeodistrhumbPath::len(self : GeodistrhumbPath) -> Int { self.size }

pub fn GeodistrhumbPath::get(self : GeodistrhumbPath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GeodistrhumbPath::set(self : GeodistrhumbPath, i : Int, v : Double) -> GeodistrhumbPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GeodistrhumbPath::sum(self : GeodistrhumbPath) -> Double { @_common.sum(self.data) }

pub fn GeodistrhumbPath::mean(self : GeodistrhumbPath) -> Double { @_common.mean(self.data) }

pub fn GeodistrhumbPath::scale(self : GeodistrhumbPath, f : Double) -> GeodistrhumbPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GeodistrhumbPath::add(self : GeodistrhumbPath, other : GeodistrhumbPath) -> GeodistrhumbPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GeodistrhumbPath::copy(self : GeodistrhumbPath) -> GeodistrhumbPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GeodistrhumbPath::fill(self : GeodistrhumbPath, v : Double) -> GeodistrhumbPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GeodistrhumbPath::min(self : GeodistrhumbPath) -> Double { @_common.min(self.data) }

pub fn GeodistrhumbPath::max(self : GeodistrhumbPath) -> Double { @_common.max(self.data) }

pub fn GeodistrhumbPath::to_string(self : GeodistrhumbPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GeodistrhumbCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_dist_rhumb_cluster_make(size : Int) -> GeodistrhumbCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GeodistrhumbCluster::len(self : GeodistrhumbCluster) -> Int { self.size }

pub fn GeodistrhumbCluster::get(self : GeodistrhumbCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GeodistrhumbCluster::set(self : GeodistrhumbCluster, i : Int, v : Double) -> GeodistrhumbCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GeodistrhumbCluster::sum(self : GeodistrhumbCluster) -> Double { @_common.sum(self.data) }

pub fn GeodistrhumbCluster::mean(self : GeodistrhumbCluster) -> Double { @_common.mean(self.data) }

pub fn GeodistrhumbCluster::scale(self : GeodistrhumbCluster, f : Double) -> GeodistrhumbCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GeodistrhumbCluster::add(self : GeodistrhumbCluster, other : GeodistrhumbCluster) -> GeodistrhumbCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GeodistrhumbCluster::copy(self : GeodistrhumbCluster) -> GeodistrhumbCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GeodistrhumbCluster::fill(self : GeodistrhumbCluster, v : Double) -> GeodistrhumbCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GeodistrhumbCluster::min(self : GeodistrhumbCluster) -> Double { @_common.min(self.data) }

pub fn GeodistrhumbCluster::max(self : GeodistrhumbCluster) -> Double { @_common.max(self.data) }

pub fn GeodistrhumbCluster::to_string(self : GeodistrhumbCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GeodistrhumbModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_dist_rhumb_model_make(size : Int) -> GeodistrhumbModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GeodistrhumbModel::len(self : GeodistrhumbModel) -> Int { self.size }

pub fn GeodistrhumbModel::get(self : GeodistrhumbModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GeodistrhumbModel::set(self : GeodistrhumbModel, i : Int, v : Double) -> GeodistrhumbModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GeodistrhumbModel::sum(self : GeodistrhumbModel) -> Double { @_common.sum(self.data) }

pub fn GeodistrhumbModel::mean(self : GeodistrhumbModel) -> Double { @_common.mean(self.data) }

pub fn GeodistrhumbModel::scale(self : GeodistrhumbModel, f : Double) -> GeodistrhumbModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GeodistrhumbModel::add(self : GeodistrhumbModel, other : GeodistrhumbModel) -> GeodistrhumbModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GeodistrhumbModel::copy(self : GeodistrhumbModel) -> GeodistrhumbModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GeodistrhumbModel::fill(self : GeodistrhumbModel, v : Double) -> GeodistrhumbModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GeodistrhumbModel::min(self : GeodistrhumbModel) -> Double { @_common.min(self.data) }

pub fn GeodistrhumbModel::max(self : GeodistrhumbModel) -> Double { @_common.max(self.data) }

pub fn GeodistrhumbModel::to_string(self : GeodistrhumbModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GeodistrhumbLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_dist_rhumb_layer_make(size : Int) -> GeodistrhumbLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GeodistrhumbLayer::len(self : GeodistrhumbLayer) -> Int { self.size }

pub fn GeodistrhumbLayer::get(self : GeodistrhumbLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GeodistrhumbLayer::set(self : GeodistrhumbLayer, i : Int, v : Double) -> GeodistrhumbLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GeodistrhumbLayer::sum(self : GeodistrhumbLayer) -> Double { @_common.sum(self.data) }

pub fn GeodistrhumbLayer::mean(self : GeodistrhumbLayer) -> Double { @_common.mean(self.data) }

pub fn GeodistrhumbLayer::scale(self : GeodistrhumbLayer, f : Double) -> GeodistrhumbLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GeodistrhumbLayer::add(self : GeodistrhumbLayer, other : GeodistrhumbLayer) -> GeodistrhumbLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GeodistrhumbLayer::copy(self : GeodistrhumbLayer) -> GeodistrhumbLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GeodistrhumbLayer::fill(self : GeodistrhumbLayer, v : Double) -> GeodistrhumbLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GeodistrhumbLayer::min(self : GeodistrhumbLayer) -> Double { @_common.min(self.data) }

pub fn GeodistrhumbLayer::max(self : GeodistrhumbLayer) -> Double { @_common.max(self.data) }

pub fn GeodistrhumbLayer::to_string(self : GeodistrhumbLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GeodistrhumbBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_dist_rhumb_buffer_make(size : Int) -> GeodistrhumbBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GeodistrhumbBuffer::len(self : GeodistrhumbBuffer) -> Int { self.size }

pub fn GeodistrhumbBuffer::get(self : GeodistrhumbBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GeodistrhumbBuffer::set(self : GeodistrhumbBuffer, i : Int, v : Double) -> GeodistrhumbBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GeodistrhumbBuffer::sum(self : GeodistrhumbBuffer) -> Double { @_common.sum(self.data) }

pub fn GeodistrhumbBuffer::mean(self : GeodistrhumbBuffer) -> Double { @_common.mean(self.data) }

pub fn GeodistrhumbBuffer::scale(self : GeodistrhumbBuffer, f : Double) -> GeodistrhumbBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GeodistrhumbBuffer::add(self : GeodistrhumbBuffer, other : GeodistrhumbBuffer) -> GeodistrhumbBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GeodistrhumbBuffer::copy(self : GeodistrhumbBuffer) -> GeodistrhumbBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GeodistrhumbBuffer::fill(self : GeodistrhumbBuffer, v : Double) -> GeodistrhumbBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GeodistrhumbBuffer::min(self : GeodistrhumbBuffer) -> Double { @_common.min(self.data) }

pub fn GeodistrhumbBuffer::max(self : GeodistrhumbBuffer) -> Double { @_common.max(self.data) }

pub fn GeodistrhumbBuffer::to_string(self : GeodistrhumbBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GeodistrhumbCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_dist_rhumb_cursor_make(size : Int) -> GeodistrhumbCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GeodistrhumbCursor::len(self : GeodistrhumbCursor) -> Int { self.size }

pub fn GeodistrhumbCursor::get(self : GeodistrhumbCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GeodistrhumbCursor::set(self : GeodistrhumbCursor, i : Int, v : Double) -> GeodistrhumbCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GeodistrhumbCursor::sum(self : GeodistrhumbCursor) -> Double { @_common.sum(self.data) }

pub fn GeodistrhumbCursor::mean(self : GeodistrhumbCursor) -> Double { @_common.mean(self.data) }

pub fn GeodistrhumbCursor::scale(self : GeodistrhumbCursor, f : Double) -> GeodistrhumbCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GeodistrhumbCursor::add(self : GeodistrhumbCursor, other : GeodistrhumbCursor) -> GeodistrhumbCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GeodistrhumbCursor::copy(self : GeodistrhumbCursor) -> GeodistrhumbCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GeodistrhumbCursor::fill(self : GeodistrhumbCursor, v : Double) -> GeodistrhumbCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GeodistrhumbCursor::min(self : GeodistrhumbCursor) -> Double { @_common.min(self.data) }

pub fn GeodistrhumbCursor::max(self : GeodistrhumbCursor) -> Double { @_common.max(self.data) }

pub fn GeodistrhumbCursor::to_string(self : GeodistrhumbCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GeodistrhumbView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_dist_rhumb_view_make(size : Int) -> GeodistrhumbView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GeodistrhumbView::len(self : GeodistrhumbView) -> Int { self.size }

pub fn GeodistrhumbView::get(self : GeodistrhumbView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GeodistrhumbView::set(self : GeodistrhumbView, i : Int, v : Double) -> GeodistrhumbView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GeodistrhumbView::sum(self : GeodistrhumbView) -> Double { @_common.sum(self.data) }

pub fn GeodistrhumbView::mean(self : GeodistrhumbView) -> Double { @_common.mean(self.data) }

pub fn GeodistrhumbView::scale(self : GeodistrhumbView, f : Double) -> GeodistrhumbView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GeodistrhumbView::add(self : GeodistrhumbView, other : GeodistrhumbView) -> GeodistrhumbView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GeodistrhumbView::copy(self : GeodistrhumbView) -> GeodistrhumbView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GeodistrhumbView::fill(self : GeodistrhumbView, v : Double) -> GeodistrhumbView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GeodistrhumbView::min(self : GeodistrhumbView) -> Double { @_common.min(self.data) }

pub fn GeodistrhumbView::max(self : GeodistrhumbView) -> Double { @_common.max(self.data) }

pub fn GeodistrhumbView::to_string(self : GeodistrhumbView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GeodistrhumbRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_dist_rhumb_range_make(size : Int) -> GeodistrhumbRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GeodistrhumbRange::len(self : GeodistrhumbRange) -> Int { self.size }

pub fn GeodistrhumbRange::get(self : GeodistrhumbRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GeodistrhumbRange::set(self : GeodistrhumbRange, i : Int, v : Double) -> GeodistrhumbRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GeodistrhumbRange::sum(self : GeodistrhumbRange) -> Double { @_common.sum(self.data) }

pub fn GeodistrhumbRange::mean(self : GeodistrhumbRange) -> Double { @_common.mean(self.data) }

pub fn GeodistrhumbRange::scale(self : GeodistrhumbRange, f : Double) -> GeodistrhumbRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GeodistrhumbRange::add(self : GeodistrhumbRange, other : GeodistrhumbRange) -> GeodistrhumbRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GeodistrhumbRange::copy(self : GeodistrhumbRange) -> GeodistrhumbRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GeodistrhumbRange::fill(self : GeodistrhumbRange, v : Double) -> GeodistrhumbRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GeodistrhumbRange::min(self : GeodistrhumbRange) -> Double { @_common.min(self.data) }

pub fn GeodistrhumbRange::max(self : GeodistrhumbRange) -> Double { @_common.max(self.data) }

pub fn GeodistrhumbRange::to_string(self : GeodistrhumbRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GeodistrhumbSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_dist_rhumb_slice_make(size : Int) -> GeodistrhumbSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GeodistrhumbSlice::len(self : GeodistrhumbSlice) -> Int { self.size }

pub fn GeodistrhumbSlice::get(self : GeodistrhumbSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GeodistrhumbSlice::set(self : GeodistrhumbSlice, i : Int, v : Double) -> GeodistrhumbSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GeodistrhumbSlice::sum(self : GeodistrhumbSlice) -> Double { @_common.sum(self.data) }

pub fn GeodistrhumbSlice::mean(self : GeodistrhumbSlice) -> Double { @_common.mean(self.data) }

pub fn GeodistrhumbSlice::scale(self : GeodistrhumbSlice, f : Double) -> GeodistrhumbSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GeodistrhumbSlice::add(self : GeodistrhumbSlice, other : GeodistrhumbSlice) -> GeodistrhumbSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GeodistrhumbSlice::copy(self : GeodistrhumbSlice) -> GeodistrhumbSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GeodistrhumbSlice::fill(self : GeodistrhumbSlice, v : Double) -> GeodistrhumbSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GeodistrhumbSlice::min(self : GeodistrhumbSlice) -> Double { @_common.min(self.data) }

pub fn GeodistrhumbSlice::max(self : GeodistrhumbSlice) -> Double { @_common.max(self.data) }

pub fn GeodistrhumbSlice::to_string(self : GeodistrhumbSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

