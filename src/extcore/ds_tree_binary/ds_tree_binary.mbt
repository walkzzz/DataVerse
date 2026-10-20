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

pub fn ds_tree_binary_frame_len(s : DstreebinaryFrame) -> Int { s.size }

pub fn ds_tree_binary_frame_get(s : DstreebinaryFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_tree_binary_frame_set(s : DstreebinaryFrame, i : Int, v : Double) -> DstreebinaryFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_tree_binary_frame_sum(s : DstreebinaryFrame) -> Double { @_common.sum(s.data) }

pub fn ds_tree_binary_frame_mean(s : DstreebinaryFrame) -> Double { @_common.mean(s.data) }

pub fn ds_tree_binary_frame_scale(s : DstreebinaryFrame, f : Double) -> DstreebinaryFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_tree_binary_frame_add(a : DstreebinaryFrame, b : DstreebinaryFrame) -> DstreebinaryFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_tree_binary_frame_copy(s : DstreebinaryFrame) -> DstreebinaryFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_tree_binary_frame_fill(s : DstreebinaryFrame, v : Double) -> DstreebinaryFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_tree_binary_frame_min(s : DstreebinaryFrame) -> Double { @_common.min(s.data) }

pub fn ds_tree_binary_frame_max(s : DstreebinaryFrame) -> Double { @_common.max(s.data) }

pub fn ds_tree_binary_frame_to_string(s : DstreebinaryFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DstreebinaryTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_tree_binary_table_make(size : Int) -> DstreebinaryTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_tree_binary_table_len(s : DstreebinaryTable) -> Int { s.size }

pub fn ds_tree_binary_table_get(s : DstreebinaryTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_tree_binary_table_set(s : DstreebinaryTable, i : Int, v : Double) -> DstreebinaryTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_tree_binary_table_sum(s : DstreebinaryTable) -> Double { @_common.sum(s.data) }

pub fn ds_tree_binary_table_mean(s : DstreebinaryTable) -> Double { @_common.mean(s.data) }

pub fn ds_tree_binary_table_scale(s : DstreebinaryTable, f : Double) -> DstreebinaryTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_tree_binary_table_add(a : DstreebinaryTable, b : DstreebinaryTable) -> DstreebinaryTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_tree_binary_table_copy(s : DstreebinaryTable) -> DstreebinaryTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_tree_binary_table_fill(s : DstreebinaryTable, v : Double) -> DstreebinaryTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_tree_binary_table_min(s : DstreebinaryTable) -> Double { @_common.min(s.data) }

pub fn ds_tree_binary_table_max(s : DstreebinaryTable) -> Double { @_common.max(s.data) }

pub fn ds_tree_binary_table_to_string(s : DstreebinaryTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DstreebinaryGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_tree_binary_graphn_make(size : Int) -> DstreebinaryGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_tree_binary_graphn_len(s : DstreebinaryGraphN) -> Int { s.size }

pub fn ds_tree_binary_graphn_get(s : DstreebinaryGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_tree_binary_graphn_set(s : DstreebinaryGraphN, i : Int, v : Double) -> DstreebinaryGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_tree_binary_graphn_sum(s : DstreebinaryGraphN) -> Double { @_common.sum(s.data) }

pub fn ds_tree_binary_graphn_mean(s : DstreebinaryGraphN) -> Double { @_common.mean(s.data) }

pub fn ds_tree_binary_graphn_scale(s : DstreebinaryGraphN, f : Double) -> DstreebinaryGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_tree_binary_graphn_add(a : DstreebinaryGraphN, b : DstreebinaryGraphN) -> DstreebinaryGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_tree_binary_graphn_copy(s : DstreebinaryGraphN) -> DstreebinaryGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_tree_binary_graphn_fill(s : DstreebinaryGraphN, v : Double) -> DstreebinaryGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_tree_binary_graphn_min(s : DstreebinaryGraphN) -> Double { @_common.min(s.data) }

pub fn ds_tree_binary_graphn_max(s : DstreebinaryGraphN) -> Double { @_common.max(s.data) }

pub fn ds_tree_binary_graphn_to_string(s : DstreebinaryGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DstreebinaryNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_tree_binary_node_make(size : Int) -> DstreebinaryNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_tree_binary_node_len(s : DstreebinaryNode) -> Int { s.size }

pub fn ds_tree_binary_node_get(s : DstreebinaryNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_tree_binary_node_set(s : DstreebinaryNode, i : Int, v : Double) -> DstreebinaryNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_tree_binary_node_sum(s : DstreebinaryNode) -> Double { @_common.sum(s.data) }

pub fn ds_tree_binary_node_mean(s : DstreebinaryNode) -> Double { @_common.mean(s.data) }

pub fn ds_tree_binary_node_scale(s : DstreebinaryNode, f : Double) -> DstreebinaryNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_tree_binary_node_add(a : DstreebinaryNode, b : DstreebinaryNode) -> DstreebinaryNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_tree_binary_node_copy(s : DstreebinaryNode) -> DstreebinaryNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_tree_binary_node_fill(s : DstreebinaryNode, v : Double) -> DstreebinaryNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_tree_binary_node_min(s : DstreebinaryNode) -> Double { @_common.min(s.data) }

pub fn ds_tree_binary_node_max(s : DstreebinaryNode) -> Double { @_common.max(s.data) }

pub fn ds_tree_binary_node_to_string(s : DstreebinaryNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DstreebinaryEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_tree_binary_edge_make(size : Int) -> DstreebinaryEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_tree_binary_edge_len(s : DstreebinaryEdge) -> Int { s.size }

pub fn ds_tree_binary_edge_get(s : DstreebinaryEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_tree_binary_edge_set(s : DstreebinaryEdge, i : Int, v : Double) -> DstreebinaryEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_tree_binary_edge_sum(s : DstreebinaryEdge) -> Double { @_common.sum(s.data) }

pub fn ds_tree_binary_edge_mean(s : DstreebinaryEdge) -> Double { @_common.mean(s.data) }

pub fn ds_tree_binary_edge_scale(s : DstreebinaryEdge, f : Double) -> DstreebinaryEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_tree_binary_edge_add(a : DstreebinaryEdge, b : DstreebinaryEdge) -> DstreebinaryEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_tree_binary_edge_copy(s : DstreebinaryEdge) -> DstreebinaryEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_tree_binary_edge_fill(s : DstreebinaryEdge, v : Double) -> DstreebinaryEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_tree_binary_edge_min(s : DstreebinaryEdge) -> Double { @_common.min(s.data) }

pub fn ds_tree_binary_edge_max(s : DstreebinaryEdge) -> Double { @_common.max(s.data) }

pub fn ds_tree_binary_edge_to_string(s : DstreebinaryEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DstreebinaryPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_tree_binary_path_make(size : Int) -> DstreebinaryPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_tree_binary_path_len(s : DstreebinaryPath) -> Int { s.size }

pub fn ds_tree_binary_path_get(s : DstreebinaryPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_tree_binary_path_set(s : DstreebinaryPath, i : Int, v : Double) -> DstreebinaryPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_tree_binary_path_sum(s : DstreebinaryPath) -> Double { @_common.sum(s.data) }

pub fn ds_tree_binary_path_mean(s : DstreebinaryPath) -> Double { @_common.mean(s.data) }

pub fn ds_tree_binary_path_scale(s : DstreebinaryPath, f : Double) -> DstreebinaryPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_tree_binary_path_add(a : DstreebinaryPath, b : DstreebinaryPath) -> DstreebinaryPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_tree_binary_path_copy(s : DstreebinaryPath) -> DstreebinaryPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_tree_binary_path_fill(s : DstreebinaryPath, v : Double) -> DstreebinaryPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_tree_binary_path_min(s : DstreebinaryPath) -> Double { @_common.min(s.data) }

pub fn ds_tree_binary_path_max(s : DstreebinaryPath) -> Double { @_common.max(s.data) }

pub fn ds_tree_binary_path_to_string(s : DstreebinaryPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DstreebinaryCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_tree_binary_cluster_make(size : Int) -> DstreebinaryCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_tree_binary_cluster_len(s : DstreebinaryCluster) -> Int { s.size }

pub fn ds_tree_binary_cluster_get(s : DstreebinaryCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_tree_binary_cluster_set(s : DstreebinaryCluster, i : Int, v : Double) -> DstreebinaryCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_tree_binary_cluster_sum(s : DstreebinaryCluster) -> Double { @_common.sum(s.data) }

pub fn ds_tree_binary_cluster_mean(s : DstreebinaryCluster) -> Double { @_common.mean(s.data) }

pub fn ds_tree_binary_cluster_scale(s : DstreebinaryCluster, f : Double) -> DstreebinaryCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_tree_binary_cluster_add(a : DstreebinaryCluster, b : DstreebinaryCluster) -> DstreebinaryCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_tree_binary_cluster_copy(s : DstreebinaryCluster) -> DstreebinaryCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_tree_binary_cluster_fill(s : DstreebinaryCluster, v : Double) -> DstreebinaryCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_tree_binary_cluster_min(s : DstreebinaryCluster) -> Double { @_common.min(s.data) }

pub fn ds_tree_binary_cluster_max(s : DstreebinaryCluster) -> Double { @_common.max(s.data) }

pub fn ds_tree_binary_cluster_to_string(s : DstreebinaryCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DstreebinaryModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_tree_binary_model_make(size : Int) -> DstreebinaryModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_tree_binary_model_len(s : DstreebinaryModel) -> Int { s.size }

pub fn ds_tree_binary_model_get(s : DstreebinaryModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_tree_binary_model_set(s : DstreebinaryModel, i : Int, v : Double) -> DstreebinaryModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_tree_binary_model_sum(s : DstreebinaryModel) -> Double { @_common.sum(s.data) }

pub fn ds_tree_binary_model_mean(s : DstreebinaryModel) -> Double { @_common.mean(s.data) }

pub fn ds_tree_binary_model_scale(s : DstreebinaryModel, f : Double) -> DstreebinaryModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_tree_binary_model_add(a : DstreebinaryModel, b : DstreebinaryModel) -> DstreebinaryModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_tree_binary_model_copy(s : DstreebinaryModel) -> DstreebinaryModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_tree_binary_model_fill(s : DstreebinaryModel, v : Double) -> DstreebinaryModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_tree_binary_model_min(s : DstreebinaryModel) -> Double { @_common.min(s.data) }

pub fn ds_tree_binary_model_max(s : DstreebinaryModel) -> Double { @_common.max(s.data) }

pub fn ds_tree_binary_model_to_string(s : DstreebinaryModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DstreebinaryLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_tree_binary_layer_make(size : Int) -> DstreebinaryLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_tree_binary_layer_len(s : DstreebinaryLayer) -> Int { s.size }

pub fn ds_tree_binary_layer_get(s : DstreebinaryLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_tree_binary_layer_set(s : DstreebinaryLayer, i : Int, v : Double) -> DstreebinaryLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_tree_binary_layer_sum(s : DstreebinaryLayer) -> Double { @_common.sum(s.data) }

pub fn ds_tree_binary_layer_mean(s : DstreebinaryLayer) -> Double { @_common.mean(s.data) }

pub fn ds_tree_binary_layer_scale(s : DstreebinaryLayer, f : Double) -> DstreebinaryLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_tree_binary_layer_add(a : DstreebinaryLayer, b : DstreebinaryLayer) -> DstreebinaryLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_tree_binary_layer_copy(s : DstreebinaryLayer) -> DstreebinaryLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_tree_binary_layer_fill(s : DstreebinaryLayer, v : Double) -> DstreebinaryLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_tree_binary_layer_min(s : DstreebinaryLayer) -> Double { @_common.min(s.data) }

pub fn ds_tree_binary_layer_max(s : DstreebinaryLayer) -> Double { @_common.max(s.data) }

pub fn ds_tree_binary_layer_to_string(s : DstreebinaryLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DstreebinaryBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_tree_binary_buffer_make(size : Int) -> DstreebinaryBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_tree_binary_buffer_len(s : DstreebinaryBuffer) -> Int { s.size }

pub fn ds_tree_binary_buffer_get(s : DstreebinaryBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_tree_binary_buffer_set(s : DstreebinaryBuffer, i : Int, v : Double) -> DstreebinaryBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_tree_binary_buffer_sum(s : DstreebinaryBuffer) -> Double { @_common.sum(s.data) }

pub fn ds_tree_binary_buffer_mean(s : DstreebinaryBuffer) -> Double { @_common.mean(s.data) }

pub fn ds_tree_binary_buffer_scale(s : DstreebinaryBuffer, f : Double) -> DstreebinaryBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_tree_binary_buffer_add(a : DstreebinaryBuffer, b : DstreebinaryBuffer) -> DstreebinaryBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_tree_binary_buffer_copy(s : DstreebinaryBuffer) -> DstreebinaryBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_tree_binary_buffer_fill(s : DstreebinaryBuffer, v : Double) -> DstreebinaryBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_tree_binary_buffer_min(s : DstreebinaryBuffer) -> Double { @_common.min(s.data) }

pub fn ds_tree_binary_buffer_max(s : DstreebinaryBuffer) -> Double { @_common.max(s.data) }

pub fn ds_tree_binary_buffer_to_string(s : DstreebinaryBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DstreebinaryCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_tree_binary_cursor_make(size : Int) -> DstreebinaryCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_tree_binary_cursor_len(s : DstreebinaryCursor) -> Int { s.size }

pub fn ds_tree_binary_cursor_get(s : DstreebinaryCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_tree_binary_cursor_set(s : DstreebinaryCursor, i : Int, v : Double) -> DstreebinaryCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_tree_binary_cursor_sum(s : DstreebinaryCursor) -> Double { @_common.sum(s.data) }

pub fn ds_tree_binary_cursor_mean(s : DstreebinaryCursor) -> Double { @_common.mean(s.data) }

pub fn ds_tree_binary_cursor_scale(s : DstreebinaryCursor, f : Double) -> DstreebinaryCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_tree_binary_cursor_add(a : DstreebinaryCursor, b : DstreebinaryCursor) -> DstreebinaryCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_tree_binary_cursor_copy(s : DstreebinaryCursor) -> DstreebinaryCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_tree_binary_cursor_fill(s : DstreebinaryCursor, v : Double) -> DstreebinaryCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_tree_binary_cursor_min(s : DstreebinaryCursor) -> Double { @_common.min(s.data) }

pub fn ds_tree_binary_cursor_max(s : DstreebinaryCursor) -> Double { @_common.max(s.data) }

pub fn ds_tree_binary_cursor_to_string(s : DstreebinaryCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DstreebinaryView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_tree_binary_view_make(size : Int) -> DstreebinaryView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_tree_binary_view_len(s : DstreebinaryView) -> Int { s.size }

pub fn ds_tree_binary_view_get(s : DstreebinaryView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_tree_binary_view_set(s : DstreebinaryView, i : Int, v : Double) -> DstreebinaryView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_tree_binary_view_sum(s : DstreebinaryView) -> Double { @_common.sum(s.data) }

pub fn ds_tree_binary_view_mean(s : DstreebinaryView) -> Double { @_common.mean(s.data) }

pub fn ds_tree_binary_view_scale(s : DstreebinaryView, f : Double) -> DstreebinaryView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_tree_binary_view_add(a : DstreebinaryView, b : DstreebinaryView) -> DstreebinaryView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_tree_binary_view_copy(s : DstreebinaryView) -> DstreebinaryView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_tree_binary_view_fill(s : DstreebinaryView, v : Double) -> DstreebinaryView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_tree_binary_view_min(s : DstreebinaryView) -> Double { @_common.min(s.data) }

pub fn ds_tree_binary_view_max(s : DstreebinaryView) -> Double { @_common.max(s.data) }

pub fn ds_tree_binary_view_to_string(s : DstreebinaryView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DstreebinaryRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_tree_binary_range_make(size : Int) -> DstreebinaryRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_tree_binary_range_len(s : DstreebinaryRange) -> Int { s.size }

pub fn ds_tree_binary_range_get(s : DstreebinaryRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_tree_binary_range_set(s : DstreebinaryRange, i : Int, v : Double) -> DstreebinaryRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_tree_binary_range_sum(s : DstreebinaryRange) -> Double { @_common.sum(s.data) }

pub fn ds_tree_binary_range_mean(s : DstreebinaryRange) -> Double { @_common.mean(s.data) }

pub fn ds_tree_binary_range_scale(s : DstreebinaryRange, f : Double) -> DstreebinaryRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_tree_binary_range_add(a : DstreebinaryRange, b : DstreebinaryRange) -> DstreebinaryRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_tree_binary_range_copy(s : DstreebinaryRange) -> DstreebinaryRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_tree_binary_range_fill(s : DstreebinaryRange, v : Double) -> DstreebinaryRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_tree_binary_range_min(s : DstreebinaryRange) -> Double { @_common.min(s.data) }

pub fn ds_tree_binary_range_max(s : DstreebinaryRange) -> Double { @_common.max(s.data) }

pub fn ds_tree_binary_range_to_string(s : DstreebinaryRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DstreebinarySlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_tree_binary_slice_make(size : Int) -> DstreebinarySlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_tree_binary_slice_len(s : DstreebinarySlice) -> Int { s.size }

pub fn ds_tree_binary_slice_get(s : DstreebinarySlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_tree_binary_slice_set(s : DstreebinarySlice, i : Int, v : Double) -> DstreebinarySlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_tree_binary_slice_sum(s : DstreebinarySlice) -> Double { @_common.sum(s.data) }

pub fn ds_tree_binary_slice_mean(s : DstreebinarySlice) -> Double { @_common.mean(s.data) }

pub fn ds_tree_binary_slice_scale(s : DstreebinarySlice, f : Double) -> DstreebinarySlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_tree_binary_slice_add(a : DstreebinarySlice, b : DstreebinarySlice) -> DstreebinarySlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_tree_binary_slice_copy(s : DstreebinarySlice) -> DstreebinarySlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_tree_binary_slice_fill(s : DstreebinarySlice, v : Double) -> DstreebinarySlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_tree_binary_slice_min(s : DstreebinarySlice) -> Double { @_common.min(s.data) }

pub fn ds_tree_binary_slice_max(s : DstreebinarySlice) -> Double { @_common.max(s.data) }

pub fn ds_tree_binary_slice_to_string(s : DstreebinarySlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

