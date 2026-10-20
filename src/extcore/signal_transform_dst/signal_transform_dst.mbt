///===
/// extcore/signal_transform_dst

pub(all) struct SignaltransformdstPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn signal_transform_dst_make_point(x : Double, y : Double) -> SignaltransformdstPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn signal_transform_dst_make_point3(x : Double, y : Double, z : Double) -> SignaltransformdstPoint {
  { x, y, z, label: 0 }
}

pub fn SignaltransformdstPoint::x(self : SignaltransformdstPoint) -> Double { self.x }

pub fn SignaltransformdstPoint::y(self : SignaltransformdstPoint) -> Double { self.y }

pub fn SignaltransformdstPoint::z(self : SignaltransformdstPoint) -> Double { self.z }

pub fn SignaltransformdstPoint::label(self : SignaltransformdstPoint) -> Int { self.label }

pub fn SignaltransformdstPoint::dist(self : SignaltransformdstPoint, other : SignaltransformdstPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn SignaltransformdstPoint::add(self : SignaltransformdstPoint, other : SignaltransformdstPoint) -> SignaltransformdstPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn SignaltransformdstPoint::sub(self : SignaltransformdstPoint, other : SignaltransformdstPoint) -> SignaltransformdstPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn SignaltransformdstPoint::scale(self : SignaltransformdstPoint, s : Double) -> SignaltransformdstPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn SignaltransformdstPoint::dot(self : SignaltransformdstPoint, other : SignaltransformdstPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn SignaltransformdstPoint::cross(self : SignaltransformdstPoint, other : SignaltransformdstPoint) -> SignaltransformdstPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn SignaltransformdstPoint::norm(self : SignaltransformdstPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn SignaltransformdstPoint::normalize(self : SignaltransformdstPoint) -> SignaltransformdstPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn SignaltransformdstPoint::negate(self : SignaltransformdstPoint) -> SignaltransformdstPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn SignaltransformdstPoint::mid(self : SignaltransformdstPoint, other : SignaltransformdstPoint) -> SignaltransformdstPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn SignaltransformdstPoint::lerp(self : SignaltransformdstPoint, other : SignaltransformdstPoint, t : Double) -> SignaltransformdstPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn SignaltransformdstPoint::to_string(self : SignaltransformdstPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct SignaltransformdstSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn signal_transform_dst_make_series(vals : Array[Double], name : String) -> SignaltransformdstSeries {
  { vals, name, meta: 0 }
}

pub fn SignaltransformdstSeries::len(self : SignaltransformdstSeries) -> Int { self.vals.length() }

pub fn SignaltransformdstSeries::sum(self : SignaltransformdstSeries) -> Double { @_common.sum(self.vals) }

pub fn SignaltransformdstSeries::mean(self : SignaltransformdstSeries) -> Double { @_common.mean(self.vals) }

pub fn SignaltransformdstSeries::min(self : SignaltransformdstSeries) -> Double { @_common.min(self.vals) }

pub fn SignaltransformdstSeries::max(self : SignaltransformdstSeries) -> Double { @_common.max(self.vals) }

pub fn SignaltransformdstSeries::range(self : SignaltransformdstSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn SignaltransformdstSeries::variance(self : SignaltransformdstSeries) -> Double { @_common.variance(self.vals) }

pub fn SignaltransformdstSeries::std(self : SignaltransformdstSeries) -> Double { @_common.std(self.vals) }

pub fn SignaltransformdstSeries::median(self : SignaltransformdstSeries) -> Double { @_common.median(self.vals) }

pub fn SignaltransformdstSeries::scale(self : SignaltransformdstSeries, f : Double) -> SignaltransformdstSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn SignaltransformdstSeries::add(self : SignaltransformdstSeries, other : SignaltransformdstSeries) -> SignaltransformdstSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn SignaltransformdstSeries::sub(self : SignaltransformdstSeries, other : SignaltransformdstSeries) -> SignaltransformdstSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn SignaltransformdstSeries::normalize(self : SignaltransformdstSeries) -> SignaltransformdstSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn SignaltransformdstSeries::cumsum(self : SignaltransformdstSeries) -> SignaltransformdstSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn SignaltransformdstSeries::to_string(self : SignaltransformdstSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct SignaltransformdstMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn signal_transform_dst_make_matrix(rows : Int, cols : Int, val : Double) -> SignaltransformdstMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn signal_transform_dst_matrix_identity(n : Int) -> SignaltransformdstMatrix {
  let m = signal_transform_dst_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn SignaltransformdstMatrix::get(self : SignaltransformdstMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn SignaltransformdstMatrix::transpose(self : SignaltransformdstMatrix) -> SignaltransformdstMatrix {
  let result = signal_transform_dst_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn SignaltransformdstMatrix::add(self : SignaltransformdstMatrix, other : SignaltransformdstMatrix) -> SignaltransformdstMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = signal_transform_dst_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn SignaltransformdstMatrix::scale(self : SignaltransformdstMatrix, s : Double) -> SignaltransformdstMatrix {
  let result = signal_transform_dst_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn SignaltransformdstMatrix::multiply(self : SignaltransformdstMatrix, other : SignaltransformdstMatrix) -> SignaltransformdstMatrix {
  if self.cols != other.rows { return signal_transform_dst_make_matrix(self.rows, other.cols, 0.0) }
  let result = signal_transform_dst_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn SignaltransformdstMatrix::trace(self : SignaltransformdstMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn SignaltransformdstMatrix::det(self : SignaltransformdstMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn SignaltransformdstMatrix::norm(self : SignaltransformdstMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn SignaltransformdstMatrix::to_string(self : SignaltransformdstMatrix) -> String {
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

pub(all) struct SignaltransformdstVector {
  comps : Array[Double]
  dim : Int
}

pub fn signal_transform_dst_make_vector(comps : Array[Double]) -> SignaltransformdstVector {
  { comps, dim: comps.length() }
}

pub fn signal_transform_dst_vector_zero(dim : Int) -> SignaltransformdstVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn SignaltransformdstVector::add(self : SignaltransformdstVector, other : SignaltransformdstVector) -> SignaltransformdstVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn SignaltransformdstVector::sub(self : SignaltransformdstVector, other : SignaltransformdstVector) -> SignaltransformdstVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn SignaltransformdstVector::scale(self : SignaltransformdstVector, s : Double) -> SignaltransformdstVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn SignaltransformdstVector::dot(self : SignaltransformdstVector, other : SignaltransformdstVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn SignaltransformdstVector::norm(self : SignaltransformdstVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn SignaltransformdstVector::normalize(self : SignaltransformdstVector) -> SignaltransformdstVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn SignaltransformdstVector::dist(self : SignaltransformdstVector, other : SignaltransformdstVector) -> Double {
  self.sub(other).norm()
}

pub fn SignaltransformdstVector::to_string(self : SignaltransformdstVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn signal_transform_dst_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn signal_transform_dst_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn signal_transform_dst_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn signal_transform_dst_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn signal_transform_dst_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn signal_transform_dst_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn signal_transform_dst_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn signal_transform_dst_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn signal_transform_dst_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn signal_transform_dst_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn signal_transform_dst_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn signal_transform_dst_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn signal_transform_dst_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn signal_transform_dst_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn signal_transform_dst_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn signal_transform_dst_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn signal_transform_dst_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn signal_transform_dst_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn signal_transform_dst_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn signal_transform_dst_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn signal_transform_dst_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn signal_transform_dst_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn signal_transform_dst_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn signal_transform_dst_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn signal_transform_dst_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn signal_transform_dst_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn signal_transform_dst_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn signal_transform_dst_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn signal_transform_dst_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct SignaltransformdstFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_transform_dst_frame_make(size : Int) -> SignaltransformdstFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SignaltransformdstFrame::len(self : SignaltransformdstFrame) -> Int { self.size }

pub fn SignaltransformdstFrame::get(self : SignaltransformdstFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SignaltransformdstFrame::set(self : SignaltransformdstFrame, i : Int, v : Double) -> SignaltransformdstFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SignaltransformdstFrame::sum(self : SignaltransformdstFrame) -> Double { @_common.sum(self.data) }

pub fn SignaltransformdstFrame::mean(self : SignaltransformdstFrame) -> Double { @_common.mean(self.data) }

pub fn SignaltransformdstFrame::scale(self : SignaltransformdstFrame, f : Double) -> SignaltransformdstFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SignaltransformdstFrame::add(self : SignaltransformdstFrame, other : SignaltransformdstFrame) -> SignaltransformdstFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SignaltransformdstFrame::copy(self : SignaltransformdstFrame) -> SignaltransformdstFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SignaltransformdstFrame::fill(self : SignaltransformdstFrame, v : Double) -> SignaltransformdstFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SignaltransformdstFrame::min(self : SignaltransformdstFrame) -> Double { @_common.min(self.data) }

pub fn SignaltransformdstFrame::max(self : SignaltransformdstFrame) -> Double { @_common.max(self.data) }

pub fn SignaltransformdstFrame::to_string(self : SignaltransformdstFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SignaltransformdstTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_transform_dst_table_make(size : Int) -> SignaltransformdstTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SignaltransformdstTable::len(self : SignaltransformdstTable) -> Int { self.size }

pub fn SignaltransformdstTable::get(self : SignaltransformdstTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SignaltransformdstTable::set(self : SignaltransformdstTable, i : Int, v : Double) -> SignaltransformdstTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SignaltransformdstTable::sum(self : SignaltransformdstTable) -> Double { @_common.sum(self.data) }

pub fn SignaltransformdstTable::mean(self : SignaltransformdstTable) -> Double { @_common.mean(self.data) }

pub fn SignaltransformdstTable::scale(self : SignaltransformdstTable, f : Double) -> SignaltransformdstTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SignaltransformdstTable::add(self : SignaltransformdstTable, other : SignaltransformdstTable) -> SignaltransformdstTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SignaltransformdstTable::copy(self : SignaltransformdstTable) -> SignaltransformdstTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SignaltransformdstTable::fill(self : SignaltransformdstTable, v : Double) -> SignaltransformdstTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SignaltransformdstTable::min(self : SignaltransformdstTable) -> Double { @_common.min(self.data) }

pub fn SignaltransformdstTable::max(self : SignaltransformdstTable) -> Double { @_common.max(self.data) }

pub fn SignaltransformdstTable::to_string(self : SignaltransformdstTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SignaltransformdstGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_transform_dst_graphn_make(size : Int) -> SignaltransformdstGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SignaltransformdstGraphN::len(self : SignaltransformdstGraphN) -> Int { self.size }

pub fn SignaltransformdstGraphN::get(self : SignaltransformdstGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SignaltransformdstGraphN::set(self : SignaltransformdstGraphN, i : Int, v : Double) -> SignaltransformdstGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SignaltransformdstGraphN::sum(self : SignaltransformdstGraphN) -> Double { @_common.sum(self.data) }

pub fn SignaltransformdstGraphN::mean(self : SignaltransformdstGraphN) -> Double { @_common.mean(self.data) }

pub fn SignaltransformdstGraphN::scale(self : SignaltransformdstGraphN, f : Double) -> SignaltransformdstGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SignaltransformdstGraphN::add(self : SignaltransformdstGraphN, other : SignaltransformdstGraphN) -> SignaltransformdstGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SignaltransformdstGraphN::copy(self : SignaltransformdstGraphN) -> SignaltransformdstGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SignaltransformdstGraphN::fill(self : SignaltransformdstGraphN, v : Double) -> SignaltransformdstGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SignaltransformdstGraphN::min(self : SignaltransformdstGraphN) -> Double { @_common.min(self.data) }

pub fn SignaltransformdstGraphN::max(self : SignaltransformdstGraphN) -> Double { @_common.max(self.data) }

pub fn SignaltransformdstGraphN::to_string(self : SignaltransformdstGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SignaltransformdstNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_transform_dst_node_make(size : Int) -> SignaltransformdstNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SignaltransformdstNode::len(self : SignaltransformdstNode) -> Int { self.size }

pub fn SignaltransformdstNode::get(self : SignaltransformdstNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SignaltransformdstNode::set(self : SignaltransformdstNode, i : Int, v : Double) -> SignaltransformdstNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SignaltransformdstNode::sum(self : SignaltransformdstNode) -> Double { @_common.sum(self.data) }

pub fn SignaltransformdstNode::mean(self : SignaltransformdstNode) -> Double { @_common.mean(self.data) }

pub fn SignaltransformdstNode::scale(self : SignaltransformdstNode, f : Double) -> SignaltransformdstNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SignaltransformdstNode::add(self : SignaltransformdstNode, other : SignaltransformdstNode) -> SignaltransformdstNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SignaltransformdstNode::copy(self : SignaltransformdstNode) -> SignaltransformdstNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SignaltransformdstNode::fill(self : SignaltransformdstNode, v : Double) -> SignaltransformdstNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SignaltransformdstNode::min(self : SignaltransformdstNode) -> Double { @_common.min(self.data) }

pub fn SignaltransformdstNode::max(self : SignaltransformdstNode) -> Double { @_common.max(self.data) }

pub fn SignaltransformdstNode::to_string(self : SignaltransformdstNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SignaltransformdstEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_transform_dst_edge_make(size : Int) -> SignaltransformdstEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SignaltransformdstEdge::len(self : SignaltransformdstEdge) -> Int { self.size }

pub fn SignaltransformdstEdge::get(self : SignaltransformdstEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SignaltransformdstEdge::set(self : SignaltransformdstEdge, i : Int, v : Double) -> SignaltransformdstEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SignaltransformdstEdge::sum(self : SignaltransformdstEdge) -> Double { @_common.sum(self.data) }

pub fn SignaltransformdstEdge::mean(self : SignaltransformdstEdge) -> Double { @_common.mean(self.data) }

pub fn SignaltransformdstEdge::scale(self : SignaltransformdstEdge, f : Double) -> SignaltransformdstEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SignaltransformdstEdge::add(self : SignaltransformdstEdge, other : SignaltransformdstEdge) -> SignaltransformdstEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SignaltransformdstEdge::copy(self : SignaltransformdstEdge) -> SignaltransformdstEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SignaltransformdstEdge::fill(self : SignaltransformdstEdge, v : Double) -> SignaltransformdstEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SignaltransformdstEdge::min(self : SignaltransformdstEdge) -> Double { @_common.min(self.data) }

pub fn SignaltransformdstEdge::max(self : SignaltransformdstEdge) -> Double { @_common.max(self.data) }

pub fn SignaltransformdstEdge::to_string(self : SignaltransformdstEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SignaltransformdstPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_transform_dst_path_make(size : Int) -> SignaltransformdstPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SignaltransformdstPath::len(self : SignaltransformdstPath) -> Int { self.size }

pub fn SignaltransformdstPath::get(self : SignaltransformdstPath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SignaltransformdstPath::set(self : SignaltransformdstPath, i : Int, v : Double) -> SignaltransformdstPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SignaltransformdstPath::sum(self : SignaltransformdstPath) -> Double { @_common.sum(self.data) }

pub fn SignaltransformdstPath::mean(self : SignaltransformdstPath) -> Double { @_common.mean(self.data) }

pub fn SignaltransformdstPath::scale(self : SignaltransformdstPath, f : Double) -> SignaltransformdstPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SignaltransformdstPath::add(self : SignaltransformdstPath, other : SignaltransformdstPath) -> SignaltransformdstPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SignaltransformdstPath::copy(self : SignaltransformdstPath) -> SignaltransformdstPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SignaltransformdstPath::fill(self : SignaltransformdstPath, v : Double) -> SignaltransformdstPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SignaltransformdstPath::min(self : SignaltransformdstPath) -> Double { @_common.min(self.data) }

pub fn SignaltransformdstPath::max(self : SignaltransformdstPath) -> Double { @_common.max(self.data) }

pub fn SignaltransformdstPath::to_string(self : SignaltransformdstPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SignaltransformdstCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_transform_dst_cluster_make(size : Int) -> SignaltransformdstCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SignaltransformdstCluster::len(self : SignaltransformdstCluster) -> Int { self.size }

pub fn SignaltransformdstCluster::get(self : SignaltransformdstCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SignaltransformdstCluster::set(self : SignaltransformdstCluster, i : Int, v : Double) -> SignaltransformdstCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SignaltransformdstCluster::sum(self : SignaltransformdstCluster) -> Double { @_common.sum(self.data) }

pub fn SignaltransformdstCluster::mean(self : SignaltransformdstCluster) -> Double { @_common.mean(self.data) }

pub fn SignaltransformdstCluster::scale(self : SignaltransformdstCluster, f : Double) -> SignaltransformdstCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SignaltransformdstCluster::add(self : SignaltransformdstCluster, other : SignaltransformdstCluster) -> SignaltransformdstCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SignaltransformdstCluster::copy(self : SignaltransformdstCluster) -> SignaltransformdstCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SignaltransformdstCluster::fill(self : SignaltransformdstCluster, v : Double) -> SignaltransformdstCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SignaltransformdstCluster::min(self : SignaltransformdstCluster) -> Double { @_common.min(self.data) }

pub fn SignaltransformdstCluster::max(self : SignaltransformdstCluster) -> Double { @_common.max(self.data) }

pub fn SignaltransformdstCluster::to_string(self : SignaltransformdstCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SignaltransformdstModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_transform_dst_model_make(size : Int) -> SignaltransformdstModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SignaltransformdstModel::len(self : SignaltransformdstModel) -> Int { self.size }

pub fn SignaltransformdstModel::get(self : SignaltransformdstModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SignaltransformdstModel::set(self : SignaltransformdstModel, i : Int, v : Double) -> SignaltransformdstModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SignaltransformdstModel::sum(self : SignaltransformdstModel) -> Double { @_common.sum(self.data) }

pub fn SignaltransformdstModel::mean(self : SignaltransformdstModel) -> Double { @_common.mean(self.data) }

pub fn SignaltransformdstModel::scale(self : SignaltransformdstModel, f : Double) -> SignaltransformdstModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SignaltransformdstModel::add(self : SignaltransformdstModel, other : SignaltransformdstModel) -> SignaltransformdstModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SignaltransformdstModel::copy(self : SignaltransformdstModel) -> SignaltransformdstModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SignaltransformdstModel::fill(self : SignaltransformdstModel, v : Double) -> SignaltransformdstModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SignaltransformdstModel::min(self : SignaltransformdstModel) -> Double { @_common.min(self.data) }

pub fn SignaltransformdstModel::max(self : SignaltransformdstModel) -> Double { @_common.max(self.data) }

pub fn SignaltransformdstModel::to_string(self : SignaltransformdstModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SignaltransformdstLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_transform_dst_layer_make(size : Int) -> SignaltransformdstLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SignaltransformdstLayer::len(self : SignaltransformdstLayer) -> Int { self.size }

pub fn SignaltransformdstLayer::get(self : SignaltransformdstLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SignaltransformdstLayer::set(self : SignaltransformdstLayer, i : Int, v : Double) -> SignaltransformdstLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SignaltransformdstLayer::sum(self : SignaltransformdstLayer) -> Double { @_common.sum(self.data) }

pub fn SignaltransformdstLayer::mean(self : SignaltransformdstLayer) -> Double { @_common.mean(self.data) }

pub fn SignaltransformdstLayer::scale(self : SignaltransformdstLayer, f : Double) -> SignaltransformdstLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SignaltransformdstLayer::add(self : SignaltransformdstLayer, other : SignaltransformdstLayer) -> SignaltransformdstLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SignaltransformdstLayer::copy(self : SignaltransformdstLayer) -> SignaltransformdstLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SignaltransformdstLayer::fill(self : SignaltransformdstLayer, v : Double) -> SignaltransformdstLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SignaltransformdstLayer::min(self : SignaltransformdstLayer) -> Double { @_common.min(self.data) }

pub fn SignaltransformdstLayer::max(self : SignaltransformdstLayer) -> Double { @_common.max(self.data) }

pub fn SignaltransformdstLayer::to_string(self : SignaltransformdstLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SignaltransformdstBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_transform_dst_buffer_make(size : Int) -> SignaltransformdstBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SignaltransformdstBuffer::len(self : SignaltransformdstBuffer) -> Int { self.size }

pub fn SignaltransformdstBuffer::get(self : SignaltransformdstBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SignaltransformdstBuffer::set(self : SignaltransformdstBuffer, i : Int, v : Double) -> SignaltransformdstBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SignaltransformdstBuffer::sum(self : SignaltransformdstBuffer) -> Double { @_common.sum(self.data) }

pub fn SignaltransformdstBuffer::mean(self : SignaltransformdstBuffer) -> Double { @_common.mean(self.data) }

pub fn SignaltransformdstBuffer::scale(self : SignaltransformdstBuffer, f : Double) -> SignaltransformdstBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SignaltransformdstBuffer::add(self : SignaltransformdstBuffer, other : SignaltransformdstBuffer) -> SignaltransformdstBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SignaltransformdstBuffer::copy(self : SignaltransformdstBuffer) -> SignaltransformdstBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SignaltransformdstBuffer::fill(self : SignaltransformdstBuffer, v : Double) -> SignaltransformdstBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SignaltransformdstBuffer::min(self : SignaltransformdstBuffer) -> Double { @_common.min(self.data) }

pub fn SignaltransformdstBuffer::max(self : SignaltransformdstBuffer) -> Double { @_common.max(self.data) }

pub fn SignaltransformdstBuffer::to_string(self : SignaltransformdstBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SignaltransformdstCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_transform_dst_cursor_make(size : Int) -> SignaltransformdstCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SignaltransformdstCursor::len(self : SignaltransformdstCursor) -> Int { self.size }

pub fn SignaltransformdstCursor::get(self : SignaltransformdstCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SignaltransformdstCursor::set(self : SignaltransformdstCursor, i : Int, v : Double) -> SignaltransformdstCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SignaltransformdstCursor::sum(self : SignaltransformdstCursor) -> Double { @_common.sum(self.data) }

pub fn SignaltransformdstCursor::mean(self : SignaltransformdstCursor) -> Double { @_common.mean(self.data) }

pub fn SignaltransformdstCursor::scale(self : SignaltransformdstCursor, f : Double) -> SignaltransformdstCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SignaltransformdstCursor::add(self : SignaltransformdstCursor, other : SignaltransformdstCursor) -> SignaltransformdstCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SignaltransformdstCursor::copy(self : SignaltransformdstCursor) -> SignaltransformdstCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SignaltransformdstCursor::fill(self : SignaltransformdstCursor, v : Double) -> SignaltransformdstCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SignaltransformdstCursor::min(self : SignaltransformdstCursor) -> Double { @_common.min(self.data) }

pub fn SignaltransformdstCursor::max(self : SignaltransformdstCursor) -> Double { @_common.max(self.data) }

pub fn SignaltransformdstCursor::to_string(self : SignaltransformdstCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SignaltransformdstView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_transform_dst_view_make(size : Int) -> SignaltransformdstView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SignaltransformdstView::len(self : SignaltransformdstView) -> Int { self.size }

pub fn SignaltransformdstView::get(self : SignaltransformdstView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SignaltransformdstView::set(self : SignaltransformdstView, i : Int, v : Double) -> SignaltransformdstView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SignaltransformdstView::sum(self : SignaltransformdstView) -> Double { @_common.sum(self.data) }

pub fn SignaltransformdstView::mean(self : SignaltransformdstView) -> Double { @_common.mean(self.data) }

pub fn SignaltransformdstView::scale(self : SignaltransformdstView, f : Double) -> SignaltransformdstView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SignaltransformdstView::add(self : SignaltransformdstView, other : SignaltransformdstView) -> SignaltransformdstView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SignaltransformdstView::copy(self : SignaltransformdstView) -> SignaltransformdstView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SignaltransformdstView::fill(self : SignaltransformdstView, v : Double) -> SignaltransformdstView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SignaltransformdstView::min(self : SignaltransformdstView) -> Double { @_common.min(self.data) }

pub fn SignaltransformdstView::max(self : SignaltransformdstView) -> Double { @_common.max(self.data) }

pub fn SignaltransformdstView::to_string(self : SignaltransformdstView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SignaltransformdstRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_transform_dst_range_make(size : Int) -> SignaltransformdstRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SignaltransformdstRange::len(self : SignaltransformdstRange) -> Int { self.size }

pub fn SignaltransformdstRange::get(self : SignaltransformdstRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SignaltransformdstRange::set(self : SignaltransformdstRange, i : Int, v : Double) -> SignaltransformdstRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SignaltransformdstRange::sum(self : SignaltransformdstRange) -> Double { @_common.sum(self.data) }

pub fn SignaltransformdstRange::mean(self : SignaltransformdstRange) -> Double { @_common.mean(self.data) }

pub fn SignaltransformdstRange::scale(self : SignaltransformdstRange, f : Double) -> SignaltransformdstRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SignaltransformdstRange::add(self : SignaltransformdstRange, other : SignaltransformdstRange) -> SignaltransformdstRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SignaltransformdstRange::copy(self : SignaltransformdstRange) -> SignaltransformdstRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SignaltransformdstRange::fill(self : SignaltransformdstRange, v : Double) -> SignaltransformdstRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SignaltransformdstRange::min(self : SignaltransformdstRange) -> Double { @_common.min(self.data) }

pub fn SignaltransformdstRange::max(self : SignaltransformdstRange) -> Double { @_common.max(self.data) }

pub fn SignaltransformdstRange::to_string(self : SignaltransformdstRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SignaltransformdstSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_transform_dst_slice_make(size : Int) -> SignaltransformdstSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SignaltransformdstSlice::len(self : SignaltransformdstSlice) -> Int { self.size }

pub fn SignaltransformdstSlice::get(self : SignaltransformdstSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SignaltransformdstSlice::set(self : SignaltransformdstSlice, i : Int, v : Double) -> SignaltransformdstSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SignaltransformdstSlice::sum(self : SignaltransformdstSlice) -> Double { @_common.sum(self.data) }

pub fn SignaltransformdstSlice::mean(self : SignaltransformdstSlice) -> Double { @_common.mean(self.data) }

pub fn SignaltransformdstSlice::scale(self : SignaltransformdstSlice, f : Double) -> SignaltransformdstSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SignaltransformdstSlice::add(self : SignaltransformdstSlice, other : SignaltransformdstSlice) -> SignaltransformdstSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SignaltransformdstSlice::copy(self : SignaltransformdstSlice) -> SignaltransformdstSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SignaltransformdstSlice::fill(self : SignaltransformdstSlice, v : Double) -> SignaltransformdstSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SignaltransformdstSlice::min(self : SignaltransformdstSlice) -> Double { @_common.min(self.data) }

pub fn SignaltransformdstSlice::max(self : SignaltransformdstSlice) -> Double { @_common.max(self.data) }

pub fn SignaltransformdstSlice::to_string(self : SignaltransformdstSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

