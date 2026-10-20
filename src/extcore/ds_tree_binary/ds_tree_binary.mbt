///===
/// extcore/ds_tree_binary

pub(all) struct DstreebinaryPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn ds_tree_binary_make_point(x : Double, y : Double) -> DstreebinaryPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn ds_tree_binary_make_point3(x : Double, y : Double, z : Double) -> DstreebinaryPoint {
  { x, y, z, label: 0 }
}

pub fn DstreebinaryPoint::x(self : DstreebinaryPoint) -> Double { self.x }

pub fn DstreebinaryPoint::y(self : DstreebinaryPoint) -> Double { self.y }

pub fn DstreebinaryPoint::z(self : DstreebinaryPoint) -> Double { self.z }

pub fn DstreebinaryPoint::label(self : DstreebinaryPoint) -> Int { self.label }

pub fn DstreebinaryPoint::dist(self : DstreebinaryPoint, other : DstreebinaryPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn DstreebinaryPoint::add(self : DstreebinaryPoint, other : DstreebinaryPoint) -> DstreebinaryPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn DstreebinaryPoint::sub(self : DstreebinaryPoint, other : DstreebinaryPoint) -> DstreebinaryPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn DstreebinaryPoint::scale(self : DstreebinaryPoint, s : Double) -> DstreebinaryPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn DstreebinaryPoint::dot(self : DstreebinaryPoint, other : DstreebinaryPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn DstreebinaryPoint::cross(self : DstreebinaryPoint, other : DstreebinaryPoint) -> DstreebinaryPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn DstreebinaryPoint::norm(self : DstreebinaryPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn DstreebinaryPoint::normalize(self : DstreebinaryPoint) -> DstreebinaryPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn DstreebinaryPoint::negate(self : DstreebinaryPoint) -> DstreebinaryPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn DstreebinaryPoint::mid(self : DstreebinaryPoint, other : DstreebinaryPoint) -> DstreebinaryPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn DstreebinaryPoint::lerp(self : DstreebinaryPoint, other : DstreebinaryPoint, t : Double) -> DstreebinaryPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn DstreebinaryPoint::to_string(self : DstreebinaryPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct DstreebinarySeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn ds_tree_binary_make_series(vals : Array[Double], name : String) -> DstreebinarySeries {
  { vals, name, meta: 0 }
}

pub fn DstreebinarySeries::len(self : DstreebinarySeries) -> Int { self.vals.length() }

pub fn DstreebinarySeries::sum(self : DstreebinarySeries) -> Double { @_common.sum(self.vals) }

pub fn DstreebinarySeries::mean(self : DstreebinarySeries) -> Double { @_common.mean(self.vals) }

pub fn DstreebinarySeries::min(self : DstreebinarySeries) -> Double { @_common.min(self.vals) }

pub fn DstreebinarySeries::max(self : DstreebinarySeries) -> Double { @_common.max(self.vals) }

pub fn DstreebinarySeries::range(self : DstreebinarySeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn DstreebinarySeries::variance(self : DstreebinarySeries) -> Double { @_common.variance(self.vals) }

pub fn DstreebinarySeries::std(self : DstreebinarySeries) -> Double { @_common.std(self.vals) }

pub fn DstreebinarySeries::median(self : DstreebinarySeries) -> Double { @_common.median(self.vals) }

pub fn DstreebinarySeries::scale(self : DstreebinarySeries, f : Double) -> DstreebinarySeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn DstreebinarySeries::add(self : DstreebinarySeries, other : DstreebinarySeries) -> DstreebinarySeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn DstreebinarySeries::sub(self : DstreebinarySeries, other : DstreebinarySeries) -> DstreebinarySeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn DstreebinarySeries::normalize(self : DstreebinarySeries) -> DstreebinarySeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn DstreebinarySeries::cumsum(self : DstreebinarySeries) -> DstreebinarySeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn DstreebinarySeries::to_string(self : DstreebinarySeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct DstreebinaryMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn ds_tree_binary_make_matrix(rows : Int, cols : Int, val : Double) -> DstreebinaryMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn ds_tree_binary_matrix_identity(n : Int) -> DstreebinaryMatrix {
  let m = ds_tree_binary_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn DstreebinaryMatrix::get(self : DstreebinaryMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn DstreebinaryMatrix::transpose(self : DstreebinaryMatrix) -> DstreebinaryMatrix {
  let result = ds_tree_binary_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn DstreebinaryMatrix::add(self : DstreebinaryMatrix, other : DstreebinaryMatrix) -> DstreebinaryMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = ds_tree_binary_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn DstreebinaryMatrix::scale(self : DstreebinaryMatrix, s : Double) -> DstreebinaryMatrix {
  let result = ds_tree_binary_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn DstreebinaryMatrix::multiply(self : DstreebinaryMatrix, other : DstreebinaryMatrix) -> DstreebinaryMatrix {
  if self.cols != other.rows { return ds_tree_binary_make_matrix(self.rows, other.cols, 0.0) }
  let result = ds_tree_binary_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn DstreebinaryMatrix::trace(self : DstreebinaryMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn DstreebinaryMatrix::det(self : DstreebinaryMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn DstreebinaryMatrix::norm(self : DstreebinaryMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn DstreebinaryMatrix::to_string(self : DstreebinaryMatrix) -> String {
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

pub(all) struct DstreebinaryVector {
  comps : Array[Double]
  dim : Int
}

pub fn ds_tree_binary_make_vector(comps : Array[Double]) -> DstreebinaryVector {
  { comps, dim: comps.length() }
}

pub fn ds_tree_binary_vector_zero(dim : Int) -> DstreebinaryVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn DstreebinaryVector::add(self : DstreebinaryVector, other : DstreebinaryVector) -> DstreebinaryVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn DstreebinaryVector::sub(self : DstreebinaryVector, other : DstreebinaryVector) -> DstreebinaryVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn DstreebinaryVector::scale(self : DstreebinaryVector, s : Double) -> DstreebinaryVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn DstreebinaryVector::dot(self : DstreebinaryVector, other : DstreebinaryVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn DstreebinaryVector::norm(self : DstreebinaryVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn DstreebinaryVector::normalize(self : DstreebinaryVector) -> DstreebinaryVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn DstreebinaryVector::dist(self : DstreebinaryVector, other : DstreebinaryVector) -> Double {
  self.sub(other).norm()
}

pub fn DstreebinaryVector::to_string(self : DstreebinaryVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn ds_tree_binary_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn ds_tree_binary_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn ds_tree_binary_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn ds_tree_binary_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn ds_tree_binary_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn ds_tree_binary_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn ds_tree_binary_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn ds_tree_binary_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn ds_tree_binary_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn ds_tree_binary_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn ds_tree_binary_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn ds_tree_binary_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn ds_tree_binary_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn ds_tree_binary_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn ds_tree_binary_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn ds_tree_binary_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn ds_tree_binary_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn ds_tree_binary_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn ds_tree_binary_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn ds_tree_binary_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn ds_tree_binary_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn ds_tree_binary_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn ds_tree_binary_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn ds_tree_binary_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn ds_tree_binary_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn ds_tree_binary_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn ds_tree_binary_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn ds_tree_binary_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn ds_tree_binary_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct DstreebinaryFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_tree_binary_frame_make(size : Int) -> DstreebinaryFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DstreebinaryFrame::len(self : DstreebinaryFrame) -> Int { self.size }

pub fn DstreebinaryFrame::get(self : DstreebinaryFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DstreebinaryFrame::set(self : DstreebinaryFrame, i : Int, v : Double) -> DstreebinaryFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DstreebinaryFrame::sum(self : DstreebinaryFrame) -> Double { @_common.sum(self.data) }

pub fn DstreebinaryFrame::mean(self : DstreebinaryFrame) -> Double { @_common.mean(self.data) }

pub fn DstreebinaryFrame::scale(self : DstreebinaryFrame, f : Double) -> DstreebinaryFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DstreebinaryFrame::add(self : DstreebinaryFrame, other : DstreebinaryFrame) -> DstreebinaryFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DstreebinaryFrame::copy(self : DstreebinaryFrame) -> DstreebinaryFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DstreebinaryFrame::fill(self : DstreebinaryFrame, v : Double) -> DstreebinaryFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DstreebinaryFrame::min(self : DstreebinaryFrame) -> Double { @_common.min(self.data) }

pub fn DstreebinaryFrame::max(self : DstreebinaryFrame) -> Double { @_common.max(self.data) }

pub fn DstreebinaryFrame::to_string(self : DstreebinaryFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DstreebinaryTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_tree_binary_table_make(size : Int) -> DstreebinaryTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DstreebinaryTable::len(self : DstreebinaryTable) -> Int { self.size }

pub fn DstreebinaryTable::get(self : DstreebinaryTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DstreebinaryTable::set(self : DstreebinaryTable, i : Int, v : Double) -> DstreebinaryTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DstreebinaryTable::sum(self : DstreebinaryTable) -> Double { @_common.sum(self.data) }

pub fn DstreebinaryTable::mean(self : DstreebinaryTable) -> Double { @_common.mean(self.data) }

pub fn DstreebinaryTable::scale(self : DstreebinaryTable, f : Double) -> DstreebinaryTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DstreebinaryTable::add(self : DstreebinaryTable, other : DstreebinaryTable) -> DstreebinaryTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DstreebinaryTable::copy(self : DstreebinaryTable) -> DstreebinaryTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DstreebinaryTable::fill(self : DstreebinaryTable, v : Double) -> DstreebinaryTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DstreebinaryTable::min(self : DstreebinaryTable) -> Double { @_common.min(self.data) }

pub fn DstreebinaryTable::max(self : DstreebinaryTable) -> Double { @_common.max(self.data) }

pub fn DstreebinaryTable::to_string(self : DstreebinaryTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DstreebinaryGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_tree_binary_graphn_make(size : Int) -> DstreebinaryGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DstreebinaryGraphN::len(self : DstreebinaryGraphN) -> Int { self.size }

pub fn DstreebinaryGraphN::get(self : DstreebinaryGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DstreebinaryGraphN::set(self : DstreebinaryGraphN, i : Int, v : Double) -> DstreebinaryGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DstreebinaryGraphN::sum(self : DstreebinaryGraphN) -> Double { @_common.sum(self.data) }

pub fn DstreebinaryGraphN::mean(self : DstreebinaryGraphN) -> Double { @_common.mean(self.data) }

pub fn DstreebinaryGraphN::scale(self : DstreebinaryGraphN, f : Double) -> DstreebinaryGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DstreebinaryGraphN::add(self : DstreebinaryGraphN, other : DstreebinaryGraphN) -> DstreebinaryGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DstreebinaryGraphN::copy(self : DstreebinaryGraphN) -> DstreebinaryGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DstreebinaryGraphN::fill(self : DstreebinaryGraphN, v : Double) -> DstreebinaryGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DstreebinaryGraphN::min(self : DstreebinaryGraphN) -> Double { @_common.min(self.data) }

pub fn DstreebinaryGraphN::max(self : DstreebinaryGraphN) -> Double { @_common.max(self.data) }

pub fn DstreebinaryGraphN::to_string(self : DstreebinaryGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DstreebinaryNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_tree_binary_node_make(size : Int) -> DstreebinaryNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DstreebinaryNode::len(self : DstreebinaryNode) -> Int { self.size }

pub fn DstreebinaryNode::get(self : DstreebinaryNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DstreebinaryNode::set(self : DstreebinaryNode, i : Int, v : Double) -> DstreebinaryNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DstreebinaryNode::sum(self : DstreebinaryNode) -> Double { @_common.sum(self.data) }

pub fn DstreebinaryNode::mean(self : DstreebinaryNode) -> Double { @_common.mean(self.data) }

pub fn DstreebinaryNode::scale(self : DstreebinaryNode, f : Double) -> DstreebinaryNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DstreebinaryNode::add(self : DstreebinaryNode, other : DstreebinaryNode) -> DstreebinaryNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DstreebinaryNode::copy(self : DstreebinaryNode) -> DstreebinaryNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DstreebinaryNode::fill(self : DstreebinaryNode, v : Double) -> DstreebinaryNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DstreebinaryNode::min(self : DstreebinaryNode) -> Double { @_common.min(self.data) }

pub fn DstreebinaryNode::max(self : DstreebinaryNode) -> Double { @_common.max(self.data) }

pub fn DstreebinaryNode::to_string(self : DstreebinaryNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DstreebinaryEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_tree_binary_edge_make(size : Int) -> DstreebinaryEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DstreebinaryEdge::len(self : DstreebinaryEdge) -> Int { self.size }

pub fn DstreebinaryEdge::get(self : DstreebinaryEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DstreebinaryEdge::set(self : DstreebinaryEdge, i : Int, v : Double) -> DstreebinaryEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DstreebinaryEdge::sum(self : DstreebinaryEdge) -> Double { @_common.sum(self.data) }

pub fn DstreebinaryEdge::mean(self : DstreebinaryEdge) -> Double { @_common.mean(self.data) }

pub fn DstreebinaryEdge::scale(self : DstreebinaryEdge, f : Double) -> DstreebinaryEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DstreebinaryEdge::add(self : DstreebinaryEdge, other : DstreebinaryEdge) -> DstreebinaryEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DstreebinaryEdge::copy(self : DstreebinaryEdge) -> DstreebinaryEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DstreebinaryEdge::fill(self : DstreebinaryEdge, v : Double) -> DstreebinaryEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DstreebinaryEdge::min(self : DstreebinaryEdge) -> Double { @_common.min(self.data) }

pub fn DstreebinaryEdge::max(self : DstreebinaryEdge) -> Double { @_common.max(self.data) }

pub fn DstreebinaryEdge::to_string(self : DstreebinaryEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DstreebinaryPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_tree_binary_path_make(size : Int) -> DstreebinaryPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DstreebinaryPath::len(self : DstreebinaryPath) -> Int { self.size }

pub fn DstreebinaryPath::get(self : DstreebinaryPath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DstreebinaryPath::set(self : DstreebinaryPath, i : Int, v : Double) -> DstreebinaryPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DstreebinaryPath::sum(self : DstreebinaryPath) -> Double { @_common.sum(self.data) }

pub fn DstreebinaryPath::mean(self : DstreebinaryPath) -> Double { @_common.mean(self.data) }

pub fn DstreebinaryPath::scale(self : DstreebinaryPath, f : Double) -> DstreebinaryPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DstreebinaryPath::add(self : DstreebinaryPath, other : DstreebinaryPath) -> DstreebinaryPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DstreebinaryPath::copy(self : DstreebinaryPath) -> DstreebinaryPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DstreebinaryPath::fill(self : DstreebinaryPath, v : Double) -> DstreebinaryPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DstreebinaryPath::min(self : DstreebinaryPath) -> Double { @_common.min(self.data) }

pub fn DstreebinaryPath::max(self : DstreebinaryPath) -> Double { @_common.max(self.data) }

pub fn DstreebinaryPath::to_string(self : DstreebinaryPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DstreebinaryCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_tree_binary_cluster_make(size : Int) -> DstreebinaryCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DstreebinaryCluster::len(self : DstreebinaryCluster) -> Int { self.size }

pub fn DstreebinaryCluster::get(self : DstreebinaryCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DstreebinaryCluster::set(self : DstreebinaryCluster, i : Int, v : Double) -> DstreebinaryCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DstreebinaryCluster::sum(self : DstreebinaryCluster) -> Double { @_common.sum(self.data) }

pub fn DstreebinaryCluster::mean(self : DstreebinaryCluster) -> Double { @_common.mean(self.data) }

pub fn DstreebinaryCluster::scale(self : DstreebinaryCluster, f : Double) -> DstreebinaryCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DstreebinaryCluster::add(self : DstreebinaryCluster, other : DstreebinaryCluster) -> DstreebinaryCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DstreebinaryCluster::copy(self : DstreebinaryCluster) -> DstreebinaryCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DstreebinaryCluster::fill(self : DstreebinaryCluster, v : Double) -> DstreebinaryCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DstreebinaryCluster::min(self : DstreebinaryCluster) -> Double { @_common.min(self.data) }

pub fn DstreebinaryCluster::max(self : DstreebinaryCluster) -> Double { @_common.max(self.data) }

pub fn DstreebinaryCluster::to_string(self : DstreebinaryCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DstreebinaryModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_tree_binary_model_make(size : Int) -> DstreebinaryModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DstreebinaryModel::len(self : DstreebinaryModel) -> Int { self.size }

pub fn DstreebinaryModel::get(self : DstreebinaryModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DstreebinaryModel::set(self : DstreebinaryModel, i : Int, v : Double) -> DstreebinaryModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DstreebinaryModel::sum(self : DstreebinaryModel) -> Double { @_common.sum(self.data) }

pub fn DstreebinaryModel::mean(self : DstreebinaryModel) -> Double { @_common.mean(self.data) }

pub fn DstreebinaryModel::scale(self : DstreebinaryModel, f : Double) -> DstreebinaryModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DstreebinaryModel::add(self : DstreebinaryModel, other : DstreebinaryModel) -> DstreebinaryModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DstreebinaryModel::copy(self : DstreebinaryModel) -> DstreebinaryModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DstreebinaryModel::fill(self : DstreebinaryModel, v : Double) -> DstreebinaryModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DstreebinaryModel::min(self : DstreebinaryModel) -> Double { @_common.min(self.data) }

pub fn DstreebinaryModel::max(self : DstreebinaryModel) -> Double { @_common.max(self.data) }

pub fn DstreebinaryModel::to_string(self : DstreebinaryModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DstreebinaryLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_tree_binary_layer_make(size : Int) -> DstreebinaryLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DstreebinaryLayer::len(self : DstreebinaryLayer) -> Int { self.size }

pub fn DstreebinaryLayer::get(self : DstreebinaryLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DstreebinaryLayer::set(self : DstreebinaryLayer, i : Int, v : Double) -> DstreebinaryLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DstreebinaryLayer::sum(self : DstreebinaryLayer) -> Double { @_common.sum(self.data) }

pub fn DstreebinaryLayer::mean(self : DstreebinaryLayer) -> Double { @_common.mean(self.data) }

pub fn DstreebinaryLayer::scale(self : DstreebinaryLayer, f : Double) -> DstreebinaryLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DstreebinaryLayer::add(self : DstreebinaryLayer, other : DstreebinaryLayer) -> DstreebinaryLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DstreebinaryLayer::copy(self : DstreebinaryLayer) -> DstreebinaryLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DstreebinaryLayer::fill(self : DstreebinaryLayer, v : Double) -> DstreebinaryLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DstreebinaryLayer::min(self : DstreebinaryLayer) -> Double { @_common.min(self.data) }

pub fn DstreebinaryLayer::max(self : DstreebinaryLayer) -> Double { @_common.max(self.data) }

pub fn DstreebinaryLayer::to_string(self : DstreebinaryLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DstreebinaryBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_tree_binary_buffer_make(size : Int) -> DstreebinaryBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DstreebinaryBuffer::len(self : DstreebinaryBuffer) -> Int { self.size }

pub fn DstreebinaryBuffer::get(self : DstreebinaryBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DstreebinaryBuffer::set(self : DstreebinaryBuffer, i : Int, v : Double) -> DstreebinaryBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DstreebinaryBuffer::sum(self : DstreebinaryBuffer) -> Double { @_common.sum(self.data) }

pub fn DstreebinaryBuffer::mean(self : DstreebinaryBuffer) -> Double { @_common.mean(self.data) }

pub fn DstreebinaryBuffer::scale(self : DstreebinaryBuffer, f : Double) -> DstreebinaryBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DstreebinaryBuffer::add(self : DstreebinaryBuffer, other : DstreebinaryBuffer) -> DstreebinaryBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DstreebinaryBuffer::copy(self : DstreebinaryBuffer) -> DstreebinaryBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DstreebinaryBuffer::fill(self : DstreebinaryBuffer, v : Double) -> DstreebinaryBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DstreebinaryBuffer::min(self : DstreebinaryBuffer) -> Double { @_common.min(self.data) }

pub fn DstreebinaryBuffer::max(self : DstreebinaryBuffer) -> Double { @_common.max(self.data) }

pub fn DstreebinaryBuffer::to_string(self : DstreebinaryBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DstreebinaryCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_tree_binary_cursor_make(size : Int) -> DstreebinaryCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DstreebinaryCursor::len(self : DstreebinaryCursor) -> Int { self.size }

pub fn DstreebinaryCursor::get(self : DstreebinaryCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DstreebinaryCursor::set(self : DstreebinaryCursor, i : Int, v : Double) -> DstreebinaryCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DstreebinaryCursor::sum(self : DstreebinaryCursor) -> Double { @_common.sum(self.data) }

pub fn DstreebinaryCursor::mean(self : DstreebinaryCursor) -> Double { @_common.mean(self.data) }

pub fn DstreebinaryCursor::scale(self : DstreebinaryCursor, f : Double) -> DstreebinaryCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DstreebinaryCursor::add(self : DstreebinaryCursor, other : DstreebinaryCursor) -> DstreebinaryCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DstreebinaryCursor::copy(self : DstreebinaryCursor) -> DstreebinaryCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DstreebinaryCursor::fill(self : DstreebinaryCursor, v : Double) -> DstreebinaryCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DstreebinaryCursor::min(self : DstreebinaryCursor) -> Double { @_common.min(self.data) }

pub fn DstreebinaryCursor::max(self : DstreebinaryCursor) -> Double { @_common.max(self.data) }

pub fn DstreebinaryCursor::to_string(self : DstreebinaryCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DstreebinaryView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_tree_binary_view_make(size : Int) -> DstreebinaryView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DstreebinaryView::len(self : DstreebinaryView) -> Int { self.size }

pub fn DstreebinaryView::get(self : DstreebinaryView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DstreebinaryView::set(self : DstreebinaryView, i : Int, v : Double) -> DstreebinaryView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DstreebinaryView::sum(self : DstreebinaryView) -> Double { @_common.sum(self.data) }

pub fn DstreebinaryView::mean(self : DstreebinaryView) -> Double { @_common.mean(self.data) }

pub fn DstreebinaryView::scale(self : DstreebinaryView, f : Double) -> DstreebinaryView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DstreebinaryView::add(self : DstreebinaryView, other : DstreebinaryView) -> DstreebinaryView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DstreebinaryView::copy(self : DstreebinaryView) -> DstreebinaryView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DstreebinaryView::fill(self : DstreebinaryView, v : Double) -> DstreebinaryView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DstreebinaryView::min(self : DstreebinaryView) -> Double { @_common.min(self.data) }

pub fn DstreebinaryView::max(self : DstreebinaryView) -> Double { @_common.max(self.data) }

pub fn DstreebinaryView::to_string(self : DstreebinaryView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DstreebinaryRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_tree_binary_range_make(size : Int) -> DstreebinaryRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DstreebinaryRange::len(self : DstreebinaryRange) -> Int { self.size }

pub fn DstreebinaryRange::get(self : DstreebinaryRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DstreebinaryRange::set(self : DstreebinaryRange, i : Int, v : Double) -> DstreebinaryRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DstreebinaryRange::sum(self : DstreebinaryRange) -> Double { @_common.sum(self.data) }

pub fn DstreebinaryRange::mean(self : DstreebinaryRange) -> Double { @_common.mean(self.data) }

pub fn DstreebinaryRange::scale(self : DstreebinaryRange, f : Double) -> DstreebinaryRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DstreebinaryRange::add(self : DstreebinaryRange, other : DstreebinaryRange) -> DstreebinaryRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DstreebinaryRange::copy(self : DstreebinaryRange) -> DstreebinaryRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DstreebinaryRange::fill(self : DstreebinaryRange, v : Double) -> DstreebinaryRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DstreebinaryRange::min(self : DstreebinaryRange) -> Double { @_common.min(self.data) }

pub fn DstreebinaryRange::max(self : DstreebinaryRange) -> Double { @_common.max(self.data) }

pub fn DstreebinaryRange::to_string(self : DstreebinaryRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DstreebinarySlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_tree_binary_slice_make(size : Int) -> DstreebinarySlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DstreebinarySlice::len(self : DstreebinarySlice) -> Int { self.size }

pub fn DstreebinarySlice::get(self : DstreebinarySlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DstreebinarySlice::set(self : DstreebinarySlice, i : Int, v : Double) -> DstreebinarySlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DstreebinarySlice::sum(self : DstreebinarySlice) -> Double { @_common.sum(self.data) }

pub fn DstreebinarySlice::mean(self : DstreebinarySlice) -> Double { @_common.mean(self.data) }

pub fn DstreebinarySlice::scale(self : DstreebinarySlice, f : Double) -> DstreebinarySlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DstreebinarySlice::add(self : DstreebinarySlice, other : DstreebinarySlice) -> DstreebinarySlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DstreebinarySlice::copy(self : DstreebinarySlice) -> DstreebinarySlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DstreebinarySlice::fill(self : DstreebinarySlice, v : Double) -> DstreebinarySlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DstreebinarySlice::min(self : DstreebinarySlice) -> Double { @_common.min(self.data) }

pub fn DstreebinarySlice::max(self : DstreebinarySlice) -> Double { @_common.max(self.data) }

pub fn DstreebinarySlice::to_string(self : DstreebinarySlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

