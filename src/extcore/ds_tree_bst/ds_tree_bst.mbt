///===
/// extcore/ds_tree_bst

pub(all) struct DstreebstPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn ds_tree_bst_make_point(x : Double, y : Double) -> DstreebstPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn ds_tree_bst_make_point3(x : Double, y : Double, z : Double) -> DstreebstPoint {
  { x, y, z, label: 0 }
}

pub fn DstreebstPoint::x(self : DstreebstPoint) -> Double { self.x }

pub fn DstreebstPoint::y(self : DstreebstPoint) -> Double { self.y }

pub fn DstreebstPoint::z(self : DstreebstPoint) -> Double { self.z }

pub fn DstreebstPoint::label(self : DstreebstPoint) -> Int { self.label }

pub fn DstreebstPoint::dist(self : DstreebstPoint, other : DstreebstPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn DstreebstPoint::add(self : DstreebstPoint, other : DstreebstPoint) -> DstreebstPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn DstreebstPoint::sub(self : DstreebstPoint, other : DstreebstPoint) -> DstreebstPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn DstreebstPoint::scale(self : DstreebstPoint, s : Double) -> DstreebstPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn DstreebstPoint::dot(self : DstreebstPoint, other : DstreebstPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn DstreebstPoint::cross(self : DstreebstPoint, other : DstreebstPoint) -> DstreebstPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn DstreebstPoint::norm(self : DstreebstPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn DstreebstPoint::normalize(self : DstreebstPoint) -> DstreebstPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn DstreebstPoint::negate(self : DstreebstPoint) -> DstreebstPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn DstreebstPoint::mid(self : DstreebstPoint, other : DstreebstPoint) -> DstreebstPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn DstreebstPoint::lerp(self : DstreebstPoint, other : DstreebstPoint, t : Double) -> DstreebstPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn DstreebstPoint::to_string(self : DstreebstPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct DstreebstSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn ds_tree_bst_make_series(vals : Array[Double], name : String) -> DstreebstSeries {
  { vals, name, meta: 0 }
}

pub fn DstreebstSeries::len(self : DstreebstSeries) -> Int { self.vals.length() }

pub fn DstreebstSeries::sum(self : DstreebstSeries) -> Double { @_common.sum(self.vals) }

pub fn DstreebstSeries::mean(self : DstreebstSeries) -> Double { @_common.mean(self.vals) }

pub fn DstreebstSeries::min(self : DstreebstSeries) -> Double { @_common.min(self.vals) }

pub fn DstreebstSeries::max(self : DstreebstSeries) -> Double { @_common.max(self.vals) }

pub fn DstreebstSeries::range(self : DstreebstSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn DstreebstSeries::variance(self : DstreebstSeries) -> Double { @_common.variance(self.vals) }

pub fn DstreebstSeries::std(self : DstreebstSeries) -> Double { @_common.std(self.vals) }

pub fn DstreebstSeries::median(self : DstreebstSeries) -> Double { @_common.median(self.vals) }

pub fn DstreebstSeries::scale(self : DstreebstSeries, f : Double) -> DstreebstSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn DstreebstSeries::add(self : DstreebstSeries, other : DstreebstSeries) -> DstreebstSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn DstreebstSeries::sub(self : DstreebstSeries, other : DstreebstSeries) -> DstreebstSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn DstreebstSeries::normalize(self : DstreebstSeries) -> DstreebstSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn DstreebstSeries::cumsum(self : DstreebstSeries) -> DstreebstSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn DstreebstSeries::to_string(self : DstreebstSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct DstreebstMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn ds_tree_bst_make_matrix(rows : Int, cols : Int, val : Double) -> DstreebstMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn ds_tree_bst_matrix_identity(n : Int) -> DstreebstMatrix {
  let m = ds_tree_bst_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn DstreebstMatrix::get(self : DstreebstMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn DstreebstMatrix::transpose(self : DstreebstMatrix) -> DstreebstMatrix {
  let result = ds_tree_bst_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn DstreebstMatrix::add(self : DstreebstMatrix, other : DstreebstMatrix) -> DstreebstMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = ds_tree_bst_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn DstreebstMatrix::scale(self : DstreebstMatrix, s : Double) -> DstreebstMatrix {
  let result = ds_tree_bst_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn DstreebstMatrix::multiply(self : DstreebstMatrix, other : DstreebstMatrix) -> DstreebstMatrix {
  if self.cols != other.rows { return ds_tree_bst_make_matrix(self.rows, other.cols, 0.0) }
  let result = ds_tree_bst_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn DstreebstMatrix::trace(self : DstreebstMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn DstreebstMatrix::det(self : DstreebstMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn DstreebstMatrix::norm(self : DstreebstMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn DstreebstMatrix::to_string(self : DstreebstMatrix) -> String {
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

pub(all) struct DstreebstVector {
  comps : Array[Double]
  dim : Int
}

pub fn ds_tree_bst_make_vector(comps : Array[Double]) -> DstreebstVector {
  { comps, dim: comps.length() }
}

pub fn ds_tree_bst_vector_zero(dim : Int) -> DstreebstVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn DstreebstVector::add(self : DstreebstVector, other : DstreebstVector) -> DstreebstVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn DstreebstVector::sub(self : DstreebstVector, other : DstreebstVector) -> DstreebstVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn DstreebstVector::scale(self : DstreebstVector, s : Double) -> DstreebstVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn DstreebstVector::dot(self : DstreebstVector, other : DstreebstVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn DstreebstVector::norm(self : DstreebstVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn DstreebstVector::normalize(self : DstreebstVector) -> DstreebstVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn DstreebstVector::dist(self : DstreebstVector, other : DstreebstVector) -> Double {
  self.sub(other).norm()
}

pub fn DstreebstVector::to_string(self : DstreebstVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn ds_tree_bst_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn ds_tree_bst_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn ds_tree_bst_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn ds_tree_bst_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn ds_tree_bst_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn ds_tree_bst_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn ds_tree_bst_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn ds_tree_bst_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn ds_tree_bst_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn ds_tree_bst_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn ds_tree_bst_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn ds_tree_bst_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn ds_tree_bst_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn ds_tree_bst_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn ds_tree_bst_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn ds_tree_bst_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn ds_tree_bst_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn ds_tree_bst_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn ds_tree_bst_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn ds_tree_bst_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn ds_tree_bst_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn ds_tree_bst_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn ds_tree_bst_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn ds_tree_bst_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn ds_tree_bst_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn ds_tree_bst_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn ds_tree_bst_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn ds_tree_bst_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn ds_tree_bst_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct DstreebstFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_tree_bst_frame_make(size : Int) -> DstreebstFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_tree_bst_frame_len(s : DstreebstFrame) -> Int { s.size }

pub fn ds_tree_bst_frame_get(s : DstreebstFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_tree_bst_frame_set(s : DstreebstFrame, i : Int, v : Double) -> DstreebstFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_tree_bst_frame_sum(s : DstreebstFrame) -> Double { @_common.sum(s.data) }

pub fn ds_tree_bst_frame_mean(s : DstreebstFrame) -> Double { @_common.mean(s.data) }

pub fn ds_tree_bst_frame_scale(s : DstreebstFrame, f : Double) -> DstreebstFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_tree_bst_frame_add(a : DstreebstFrame, b : DstreebstFrame) -> DstreebstFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_tree_bst_frame_copy(s : DstreebstFrame) -> DstreebstFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_tree_bst_frame_fill(s : DstreebstFrame, v : Double) -> DstreebstFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_tree_bst_frame_min(s : DstreebstFrame) -> Double { @_common.min(s.data) }

pub fn ds_tree_bst_frame_max(s : DstreebstFrame) -> Double { @_common.max(s.data) }

pub fn ds_tree_bst_frame_to_string(s : DstreebstFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DstreebstTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_tree_bst_table_make(size : Int) -> DstreebstTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_tree_bst_table_len(s : DstreebstTable) -> Int { s.size }

pub fn ds_tree_bst_table_get(s : DstreebstTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_tree_bst_table_set(s : DstreebstTable, i : Int, v : Double) -> DstreebstTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_tree_bst_table_sum(s : DstreebstTable) -> Double { @_common.sum(s.data) }

pub fn ds_tree_bst_table_mean(s : DstreebstTable) -> Double { @_common.mean(s.data) }

pub fn ds_tree_bst_table_scale(s : DstreebstTable, f : Double) -> DstreebstTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_tree_bst_table_add(a : DstreebstTable, b : DstreebstTable) -> DstreebstTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_tree_bst_table_copy(s : DstreebstTable) -> DstreebstTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_tree_bst_table_fill(s : DstreebstTable, v : Double) -> DstreebstTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_tree_bst_table_min(s : DstreebstTable) -> Double { @_common.min(s.data) }

pub fn ds_tree_bst_table_max(s : DstreebstTable) -> Double { @_common.max(s.data) }

pub fn ds_tree_bst_table_to_string(s : DstreebstTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DstreebstGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_tree_bst_graphn_make(size : Int) -> DstreebstGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_tree_bst_graphn_len(s : DstreebstGraphN) -> Int { s.size }

pub fn ds_tree_bst_graphn_get(s : DstreebstGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_tree_bst_graphn_set(s : DstreebstGraphN, i : Int, v : Double) -> DstreebstGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_tree_bst_graphn_sum(s : DstreebstGraphN) -> Double { @_common.sum(s.data) }

pub fn ds_tree_bst_graphn_mean(s : DstreebstGraphN) -> Double { @_common.mean(s.data) }

pub fn ds_tree_bst_graphn_scale(s : DstreebstGraphN, f : Double) -> DstreebstGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_tree_bst_graphn_add(a : DstreebstGraphN, b : DstreebstGraphN) -> DstreebstGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_tree_bst_graphn_copy(s : DstreebstGraphN) -> DstreebstGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_tree_bst_graphn_fill(s : DstreebstGraphN, v : Double) -> DstreebstGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_tree_bst_graphn_min(s : DstreebstGraphN) -> Double { @_common.min(s.data) }

pub fn ds_tree_bst_graphn_max(s : DstreebstGraphN) -> Double { @_common.max(s.data) }

pub fn ds_tree_bst_graphn_to_string(s : DstreebstGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DstreebstNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_tree_bst_node_make(size : Int) -> DstreebstNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_tree_bst_node_len(s : DstreebstNode) -> Int { s.size }

pub fn ds_tree_bst_node_get(s : DstreebstNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_tree_bst_node_set(s : DstreebstNode, i : Int, v : Double) -> DstreebstNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_tree_bst_node_sum(s : DstreebstNode) -> Double { @_common.sum(s.data) }

pub fn ds_tree_bst_node_mean(s : DstreebstNode) -> Double { @_common.mean(s.data) }

pub fn ds_tree_bst_node_scale(s : DstreebstNode, f : Double) -> DstreebstNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_tree_bst_node_add(a : DstreebstNode, b : DstreebstNode) -> DstreebstNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_tree_bst_node_copy(s : DstreebstNode) -> DstreebstNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_tree_bst_node_fill(s : DstreebstNode, v : Double) -> DstreebstNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_tree_bst_node_min(s : DstreebstNode) -> Double { @_common.min(s.data) }

pub fn ds_tree_bst_node_max(s : DstreebstNode) -> Double { @_common.max(s.data) }

pub fn ds_tree_bst_node_to_string(s : DstreebstNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DstreebstEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_tree_bst_edge_make(size : Int) -> DstreebstEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_tree_bst_edge_len(s : DstreebstEdge) -> Int { s.size }

pub fn ds_tree_bst_edge_get(s : DstreebstEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_tree_bst_edge_set(s : DstreebstEdge, i : Int, v : Double) -> DstreebstEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_tree_bst_edge_sum(s : DstreebstEdge) -> Double { @_common.sum(s.data) }

pub fn ds_tree_bst_edge_mean(s : DstreebstEdge) -> Double { @_common.mean(s.data) }

pub fn ds_tree_bst_edge_scale(s : DstreebstEdge, f : Double) -> DstreebstEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_tree_bst_edge_add(a : DstreebstEdge, b : DstreebstEdge) -> DstreebstEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_tree_bst_edge_copy(s : DstreebstEdge) -> DstreebstEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_tree_bst_edge_fill(s : DstreebstEdge, v : Double) -> DstreebstEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_tree_bst_edge_min(s : DstreebstEdge) -> Double { @_common.min(s.data) }

pub fn ds_tree_bst_edge_max(s : DstreebstEdge) -> Double { @_common.max(s.data) }

pub fn ds_tree_bst_edge_to_string(s : DstreebstEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DstreebstPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_tree_bst_path_make(size : Int) -> DstreebstPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_tree_bst_path_len(s : DstreebstPath) -> Int { s.size }

pub fn ds_tree_bst_path_get(s : DstreebstPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_tree_bst_path_set(s : DstreebstPath, i : Int, v : Double) -> DstreebstPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_tree_bst_path_sum(s : DstreebstPath) -> Double { @_common.sum(s.data) }

pub fn ds_tree_bst_path_mean(s : DstreebstPath) -> Double { @_common.mean(s.data) }

pub fn ds_tree_bst_path_scale(s : DstreebstPath, f : Double) -> DstreebstPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_tree_bst_path_add(a : DstreebstPath, b : DstreebstPath) -> DstreebstPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_tree_bst_path_copy(s : DstreebstPath) -> DstreebstPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_tree_bst_path_fill(s : DstreebstPath, v : Double) -> DstreebstPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_tree_bst_path_min(s : DstreebstPath) -> Double { @_common.min(s.data) }

pub fn ds_tree_bst_path_max(s : DstreebstPath) -> Double { @_common.max(s.data) }

pub fn ds_tree_bst_path_to_string(s : DstreebstPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DstreebstCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_tree_bst_cluster_make(size : Int) -> DstreebstCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_tree_bst_cluster_len(s : DstreebstCluster) -> Int { s.size }

pub fn ds_tree_bst_cluster_get(s : DstreebstCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_tree_bst_cluster_set(s : DstreebstCluster, i : Int, v : Double) -> DstreebstCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_tree_bst_cluster_sum(s : DstreebstCluster) -> Double { @_common.sum(s.data) }

pub fn ds_tree_bst_cluster_mean(s : DstreebstCluster) -> Double { @_common.mean(s.data) }

pub fn ds_tree_bst_cluster_scale(s : DstreebstCluster, f : Double) -> DstreebstCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_tree_bst_cluster_add(a : DstreebstCluster, b : DstreebstCluster) -> DstreebstCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_tree_bst_cluster_copy(s : DstreebstCluster) -> DstreebstCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_tree_bst_cluster_fill(s : DstreebstCluster, v : Double) -> DstreebstCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_tree_bst_cluster_min(s : DstreebstCluster) -> Double { @_common.min(s.data) }

pub fn ds_tree_bst_cluster_max(s : DstreebstCluster) -> Double { @_common.max(s.data) }

pub fn ds_tree_bst_cluster_to_string(s : DstreebstCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DstreebstModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_tree_bst_model_make(size : Int) -> DstreebstModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_tree_bst_model_len(s : DstreebstModel) -> Int { s.size }

pub fn ds_tree_bst_model_get(s : DstreebstModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_tree_bst_model_set(s : DstreebstModel, i : Int, v : Double) -> DstreebstModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_tree_bst_model_sum(s : DstreebstModel) -> Double { @_common.sum(s.data) }

pub fn ds_tree_bst_model_mean(s : DstreebstModel) -> Double { @_common.mean(s.data) }

pub fn ds_tree_bst_model_scale(s : DstreebstModel, f : Double) -> DstreebstModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_tree_bst_model_add(a : DstreebstModel, b : DstreebstModel) -> DstreebstModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_tree_bst_model_copy(s : DstreebstModel) -> DstreebstModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_tree_bst_model_fill(s : DstreebstModel, v : Double) -> DstreebstModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_tree_bst_model_min(s : DstreebstModel) -> Double { @_common.min(s.data) }

pub fn ds_tree_bst_model_max(s : DstreebstModel) -> Double { @_common.max(s.data) }

pub fn ds_tree_bst_model_to_string(s : DstreebstModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DstreebstLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_tree_bst_layer_make(size : Int) -> DstreebstLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_tree_bst_layer_len(s : DstreebstLayer) -> Int { s.size }

pub fn ds_tree_bst_layer_get(s : DstreebstLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_tree_bst_layer_set(s : DstreebstLayer, i : Int, v : Double) -> DstreebstLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_tree_bst_layer_sum(s : DstreebstLayer) -> Double { @_common.sum(s.data) }

pub fn ds_tree_bst_layer_mean(s : DstreebstLayer) -> Double { @_common.mean(s.data) }

pub fn ds_tree_bst_layer_scale(s : DstreebstLayer, f : Double) -> DstreebstLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_tree_bst_layer_add(a : DstreebstLayer, b : DstreebstLayer) -> DstreebstLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_tree_bst_layer_copy(s : DstreebstLayer) -> DstreebstLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_tree_bst_layer_fill(s : DstreebstLayer, v : Double) -> DstreebstLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_tree_bst_layer_min(s : DstreebstLayer) -> Double { @_common.min(s.data) }

pub fn ds_tree_bst_layer_max(s : DstreebstLayer) -> Double { @_common.max(s.data) }

pub fn ds_tree_bst_layer_to_string(s : DstreebstLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DstreebstBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_tree_bst_buffer_make(size : Int) -> DstreebstBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_tree_bst_buffer_len(s : DstreebstBuffer) -> Int { s.size }

pub fn ds_tree_bst_buffer_get(s : DstreebstBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_tree_bst_buffer_set(s : DstreebstBuffer, i : Int, v : Double) -> DstreebstBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_tree_bst_buffer_sum(s : DstreebstBuffer) -> Double { @_common.sum(s.data) }

pub fn ds_tree_bst_buffer_mean(s : DstreebstBuffer) -> Double { @_common.mean(s.data) }

pub fn ds_tree_bst_buffer_scale(s : DstreebstBuffer, f : Double) -> DstreebstBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_tree_bst_buffer_add(a : DstreebstBuffer, b : DstreebstBuffer) -> DstreebstBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_tree_bst_buffer_copy(s : DstreebstBuffer) -> DstreebstBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_tree_bst_buffer_fill(s : DstreebstBuffer, v : Double) -> DstreebstBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_tree_bst_buffer_min(s : DstreebstBuffer) -> Double { @_common.min(s.data) }

pub fn ds_tree_bst_buffer_max(s : DstreebstBuffer) -> Double { @_common.max(s.data) }

pub fn ds_tree_bst_buffer_to_string(s : DstreebstBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DstreebstCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_tree_bst_cursor_make(size : Int) -> DstreebstCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_tree_bst_cursor_len(s : DstreebstCursor) -> Int { s.size }

pub fn ds_tree_bst_cursor_get(s : DstreebstCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_tree_bst_cursor_set(s : DstreebstCursor, i : Int, v : Double) -> DstreebstCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_tree_bst_cursor_sum(s : DstreebstCursor) -> Double { @_common.sum(s.data) }

pub fn ds_tree_bst_cursor_mean(s : DstreebstCursor) -> Double { @_common.mean(s.data) }

pub fn ds_tree_bst_cursor_scale(s : DstreebstCursor, f : Double) -> DstreebstCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_tree_bst_cursor_add(a : DstreebstCursor, b : DstreebstCursor) -> DstreebstCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_tree_bst_cursor_copy(s : DstreebstCursor) -> DstreebstCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_tree_bst_cursor_fill(s : DstreebstCursor, v : Double) -> DstreebstCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_tree_bst_cursor_min(s : DstreebstCursor) -> Double { @_common.min(s.data) }

pub fn ds_tree_bst_cursor_max(s : DstreebstCursor) -> Double { @_common.max(s.data) }

pub fn ds_tree_bst_cursor_to_string(s : DstreebstCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DstreebstView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_tree_bst_view_make(size : Int) -> DstreebstView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_tree_bst_view_len(s : DstreebstView) -> Int { s.size }

pub fn ds_tree_bst_view_get(s : DstreebstView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_tree_bst_view_set(s : DstreebstView, i : Int, v : Double) -> DstreebstView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_tree_bst_view_sum(s : DstreebstView) -> Double { @_common.sum(s.data) }

pub fn ds_tree_bst_view_mean(s : DstreebstView) -> Double { @_common.mean(s.data) }

pub fn ds_tree_bst_view_scale(s : DstreebstView, f : Double) -> DstreebstView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_tree_bst_view_add(a : DstreebstView, b : DstreebstView) -> DstreebstView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_tree_bst_view_copy(s : DstreebstView) -> DstreebstView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_tree_bst_view_fill(s : DstreebstView, v : Double) -> DstreebstView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_tree_bst_view_min(s : DstreebstView) -> Double { @_common.min(s.data) }

pub fn ds_tree_bst_view_max(s : DstreebstView) -> Double { @_common.max(s.data) }

pub fn ds_tree_bst_view_to_string(s : DstreebstView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DstreebstRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_tree_bst_range_make(size : Int) -> DstreebstRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_tree_bst_range_len(s : DstreebstRange) -> Int { s.size }

pub fn ds_tree_bst_range_get(s : DstreebstRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_tree_bst_range_set(s : DstreebstRange, i : Int, v : Double) -> DstreebstRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_tree_bst_range_sum(s : DstreebstRange) -> Double { @_common.sum(s.data) }

pub fn ds_tree_bst_range_mean(s : DstreebstRange) -> Double { @_common.mean(s.data) }

pub fn ds_tree_bst_range_scale(s : DstreebstRange, f : Double) -> DstreebstRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_tree_bst_range_add(a : DstreebstRange, b : DstreebstRange) -> DstreebstRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_tree_bst_range_copy(s : DstreebstRange) -> DstreebstRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_tree_bst_range_fill(s : DstreebstRange, v : Double) -> DstreebstRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_tree_bst_range_min(s : DstreebstRange) -> Double { @_common.min(s.data) }

pub fn ds_tree_bst_range_max(s : DstreebstRange) -> Double { @_common.max(s.data) }

pub fn ds_tree_bst_range_to_string(s : DstreebstRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DstreebstSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_tree_bst_slice_make(size : Int) -> DstreebstSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_tree_bst_slice_len(s : DstreebstSlice) -> Int { s.size }

pub fn ds_tree_bst_slice_get(s : DstreebstSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_tree_bst_slice_set(s : DstreebstSlice, i : Int, v : Double) -> DstreebstSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_tree_bst_slice_sum(s : DstreebstSlice) -> Double { @_common.sum(s.data) }

pub fn ds_tree_bst_slice_mean(s : DstreebstSlice) -> Double { @_common.mean(s.data) }

pub fn ds_tree_bst_slice_scale(s : DstreebstSlice, f : Double) -> DstreebstSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_tree_bst_slice_add(a : DstreebstSlice, b : DstreebstSlice) -> DstreebstSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_tree_bst_slice_copy(s : DstreebstSlice) -> DstreebstSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_tree_bst_slice_fill(s : DstreebstSlice, v : Double) -> DstreebstSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_tree_bst_slice_min(s : DstreebstSlice) -> Double { @_common.min(s.data) }

pub fn ds_tree_bst_slice_max(s : DstreebstSlice) -> Double { @_common.max(s.data) }

pub fn ds_tree_bst_slice_to_string(s : DstreebstSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

