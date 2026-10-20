///===
/// extcore/graph_tree_spanning

pub(all) struct GraphtreespanningPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn graph_tree_spanning_make_point(x : Double, y : Double) -> GraphtreespanningPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn graph_tree_spanning_make_point3(x : Double, y : Double, z : Double) -> GraphtreespanningPoint {
  { x, y, z, label: 0 }
}

pub fn GraphtreespanningPoint::x(self : GraphtreespanningPoint) -> Double { self.x }

pub fn GraphtreespanningPoint::y(self : GraphtreespanningPoint) -> Double { self.y }

pub fn GraphtreespanningPoint::z(self : GraphtreespanningPoint) -> Double { self.z }

pub fn GraphtreespanningPoint::label(self : GraphtreespanningPoint) -> Int { self.label }

pub fn GraphtreespanningPoint::dist(self : GraphtreespanningPoint, other : GraphtreespanningPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn GraphtreespanningPoint::add(self : GraphtreespanningPoint, other : GraphtreespanningPoint) -> GraphtreespanningPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn GraphtreespanningPoint::sub(self : GraphtreespanningPoint, other : GraphtreespanningPoint) -> GraphtreespanningPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn GraphtreespanningPoint::scale(self : GraphtreespanningPoint, s : Double) -> GraphtreespanningPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn GraphtreespanningPoint::dot(self : GraphtreespanningPoint, other : GraphtreespanningPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn GraphtreespanningPoint::cross(self : GraphtreespanningPoint, other : GraphtreespanningPoint) -> GraphtreespanningPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn GraphtreespanningPoint::norm(self : GraphtreespanningPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn GraphtreespanningPoint::normalize(self : GraphtreespanningPoint) -> GraphtreespanningPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn GraphtreespanningPoint::negate(self : GraphtreespanningPoint) -> GraphtreespanningPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn GraphtreespanningPoint::mid(self : GraphtreespanningPoint, other : GraphtreespanningPoint) -> GraphtreespanningPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn GraphtreespanningPoint::lerp(self : GraphtreespanningPoint, other : GraphtreespanningPoint, t : Double) -> GraphtreespanningPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn GraphtreespanningPoint::to_string(self : GraphtreespanningPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct GraphtreespanningSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn graph_tree_spanning_make_series(vals : Array[Double], name : String) -> GraphtreespanningSeries {
  { vals, name, meta: 0 }
}

pub fn GraphtreespanningSeries::len(self : GraphtreespanningSeries) -> Int { self.vals.length() }

pub fn GraphtreespanningSeries::sum(self : GraphtreespanningSeries) -> Double { @_common.sum(self.vals) }

pub fn GraphtreespanningSeries::mean(self : GraphtreespanningSeries) -> Double { @_common.mean(self.vals) }

pub fn GraphtreespanningSeries::min(self : GraphtreespanningSeries) -> Double { @_common.min(self.vals) }

pub fn GraphtreespanningSeries::max(self : GraphtreespanningSeries) -> Double { @_common.max(self.vals) }

pub fn GraphtreespanningSeries::range(self : GraphtreespanningSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn GraphtreespanningSeries::variance(self : GraphtreespanningSeries) -> Double { @_common.variance(self.vals) }

pub fn GraphtreespanningSeries::std(self : GraphtreespanningSeries) -> Double { @_common.std(self.vals) }

pub fn GraphtreespanningSeries::median(self : GraphtreespanningSeries) -> Double { @_common.median(self.vals) }

pub fn GraphtreespanningSeries::scale(self : GraphtreespanningSeries, f : Double) -> GraphtreespanningSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn GraphtreespanningSeries::add(self : GraphtreespanningSeries, other : GraphtreespanningSeries) -> GraphtreespanningSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn GraphtreespanningSeries::sub(self : GraphtreespanningSeries, other : GraphtreespanningSeries) -> GraphtreespanningSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn GraphtreespanningSeries::normalize(self : GraphtreespanningSeries) -> GraphtreespanningSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn GraphtreespanningSeries::cumsum(self : GraphtreespanningSeries) -> GraphtreespanningSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn GraphtreespanningSeries::to_string(self : GraphtreespanningSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct GraphtreespanningMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn graph_tree_spanning_make_matrix(rows : Int, cols : Int, val : Double) -> GraphtreespanningMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn graph_tree_spanning_matrix_identity(n : Int) -> GraphtreespanningMatrix {
  let m = graph_tree_spanning_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn GraphtreespanningMatrix::get(self : GraphtreespanningMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn GraphtreespanningMatrix::transpose(self : GraphtreespanningMatrix) -> GraphtreespanningMatrix {
  let result = graph_tree_spanning_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn GraphtreespanningMatrix::add(self : GraphtreespanningMatrix, other : GraphtreespanningMatrix) -> GraphtreespanningMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = graph_tree_spanning_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn GraphtreespanningMatrix::scale(self : GraphtreespanningMatrix, s : Double) -> GraphtreespanningMatrix {
  let result = graph_tree_spanning_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn GraphtreespanningMatrix::multiply(self : GraphtreespanningMatrix, other : GraphtreespanningMatrix) -> GraphtreespanningMatrix {
  if self.cols != other.rows { return graph_tree_spanning_make_matrix(self.rows, other.cols, 0.0) }
  let result = graph_tree_spanning_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn GraphtreespanningMatrix::trace(self : GraphtreespanningMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn GraphtreespanningMatrix::det(self : GraphtreespanningMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn GraphtreespanningMatrix::norm(self : GraphtreespanningMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn GraphtreespanningMatrix::to_string(self : GraphtreespanningMatrix) -> String {
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

pub(all) struct GraphtreespanningVector {
  comps : Array[Double]
  dim : Int
}

pub fn graph_tree_spanning_make_vector(comps : Array[Double]) -> GraphtreespanningVector {
  { comps, dim: comps.length() }
}

pub fn graph_tree_spanning_vector_zero(dim : Int) -> GraphtreespanningVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn GraphtreespanningVector::add(self : GraphtreespanningVector, other : GraphtreespanningVector) -> GraphtreespanningVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn GraphtreespanningVector::sub(self : GraphtreespanningVector, other : GraphtreespanningVector) -> GraphtreespanningVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn GraphtreespanningVector::scale(self : GraphtreespanningVector, s : Double) -> GraphtreespanningVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn GraphtreespanningVector::dot(self : GraphtreespanningVector, other : GraphtreespanningVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn GraphtreespanningVector::norm(self : GraphtreespanningVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn GraphtreespanningVector::normalize(self : GraphtreespanningVector) -> GraphtreespanningVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn GraphtreespanningVector::dist(self : GraphtreespanningVector, other : GraphtreespanningVector) -> Double {
  self.sub(other).norm()
}

pub fn GraphtreespanningVector::to_string(self : GraphtreespanningVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn graph_tree_spanning_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn graph_tree_spanning_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn graph_tree_spanning_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn graph_tree_spanning_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn graph_tree_spanning_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn graph_tree_spanning_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn graph_tree_spanning_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn graph_tree_spanning_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn graph_tree_spanning_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn graph_tree_spanning_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn graph_tree_spanning_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn graph_tree_spanning_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn graph_tree_spanning_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn graph_tree_spanning_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn graph_tree_spanning_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn graph_tree_spanning_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn graph_tree_spanning_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn graph_tree_spanning_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn graph_tree_spanning_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn graph_tree_spanning_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn graph_tree_spanning_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn graph_tree_spanning_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn graph_tree_spanning_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn graph_tree_spanning_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn graph_tree_spanning_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn graph_tree_spanning_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn graph_tree_spanning_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn graph_tree_spanning_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn graph_tree_spanning_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct GraphtreespanningFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_tree_spanning_frame_make(size : Int) -> GraphtreespanningFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_tree_spanning_frame_len(s : GraphtreespanningFrame) -> Int { s.size }

pub fn graph_tree_spanning_frame_get(s : GraphtreespanningFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_tree_spanning_frame_set(s : GraphtreespanningFrame, i : Int, v : Double) -> GraphtreespanningFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_tree_spanning_frame_sum(s : GraphtreespanningFrame) -> Double { @_common.sum(s.data) }

pub fn graph_tree_spanning_frame_mean(s : GraphtreespanningFrame) -> Double { @_common.mean(s.data) }

pub fn graph_tree_spanning_frame_scale(s : GraphtreespanningFrame, f : Double) -> GraphtreespanningFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_tree_spanning_frame_add(a : GraphtreespanningFrame, b : GraphtreespanningFrame) -> GraphtreespanningFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_tree_spanning_frame_copy(s : GraphtreespanningFrame) -> GraphtreespanningFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_tree_spanning_frame_fill(s : GraphtreespanningFrame, v : Double) -> GraphtreespanningFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_tree_spanning_frame_min(s : GraphtreespanningFrame) -> Double { @_common.min(s.data) }

pub fn graph_tree_spanning_frame_max(s : GraphtreespanningFrame) -> Double { @_common.max(s.data) }

pub fn graph_tree_spanning_frame_to_string(s : GraphtreespanningFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphtreespanningTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_tree_spanning_table_make(size : Int) -> GraphtreespanningTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_tree_spanning_table_len(s : GraphtreespanningTable) -> Int { s.size }

pub fn graph_tree_spanning_table_get(s : GraphtreespanningTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_tree_spanning_table_set(s : GraphtreespanningTable, i : Int, v : Double) -> GraphtreespanningTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_tree_spanning_table_sum(s : GraphtreespanningTable) -> Double { @_common.sum(s.data) }

pub fn graph_tree_spanning_table_mean(s : GraphtreespanningTable) -> Double { @_common.mean(s.data) }

pub fn graph_tree_spanning_table_scale(s : GraphtreespanningTable, f : Double) -> GraphtreespanningTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_tree_spanning_table_add(a : GraphtreespanningTable, b : GraphtreespanningTable) -> GraphtreespanningTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_tree_spanning_table_copy(s : GraphtreespanningTable) -> GraphtreespanningTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_tree_spanning_table_fill(s : GraphtreespanningTable, v : Double) -> GraphtreespanningTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_tree_spanning_table_min(s : GraphtreespanningTable) -> Double { @_common.min(s.data) }

pub fn graph_tree_spanning_table_max(s : GraphtreespanningTable) -> Double { @_common.max(s.data) }

pub fn graph_tree_spanning_table_to_string(s : GraphtreespanningTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphtreespanningGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_tree_spanning_graphn_make(size : Int) -> GraphtreespanningGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_tree_spanning_graphn_len(s : GraphtreespanningGraphN) -> Int { s.size }

pub fn graph_tree_spanning_graphn_get(s : GraphtreespanningGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_tree_spanning_graphn_set(s : GraphtreespanningGraphN, i : Int, v : Double) -> GraphtreespanningGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_tree_spanning_graphn_sum(s : GraphtreespanningGraphN) -> Double { @_common.sum(s.data) }

pub fn graph_tree_spanning_graphn_mean(s : GraphtreespanningGraphN) -> Double { @_common.mean(s.data) }

pub fn graph_tree_spanning_graphn_scale(s : GraphtreespanningGraphN, f : Double) -> GraphtreespanningGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_tree_spanning_graphn_add(a : GraphtreespanningGraphN, b : GraphtreespanningGraphN) -> GraphtreespanningGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_tree_spanning_graphn_copy(s : GraphtreespanningGraphN) -> GraphtreespanningGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_tree_spanning_graphn_fill(s : GraphtreespanningGraphN, v : Double) -> GraphtreespanningGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_tree_spanning_graphn_min(s : GraphtreespanningGraphN) -> Double { @_common.min(s.data) }

pub fn graph_tree_spanning_graphn_max(s : GraphtreespanningGraphN) -> Double { @_common.max(s.data) }

pub fn graph_tree_spanning_graphn_to_string(s : GraphtreespanningGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphtreespanningNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_tree_spanning_node_make(size : Int) -> GraphtreespanningNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_tree_spanning_node_len(s : GraphtreespanningNode) -> Int { s.size }

pub fn graph_tree_spanning_node_get(s : GraphtreespanningNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_tree_spanning_node_set(s : GraphtreespanningNode, i : Int, v : Double) -> GraphtreespanningNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_tree_spanning_node_sum(s : GraphtreespanningNode) -> Double { @_common.sum(s.data) }

pub fn graph_tree_spanning_node_mean(s : GraphtreespanningNode) -> Double { @_common.mean(s.data) }

pub fn graph_tree_spanning_node_scale(s : GraphtreespanningNode, f : Double) -> GraphtreespanningNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_tree_spanning_node_add(a : GraphtreespanningNode, b : GraphtreespanningNode) -> GraphtreespanningNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_tree_spanning_node_copy(s : GraphtreespanningNode) -> GraphtreespanningNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_tree_spanning_node_fill(s : GraphtreespanningNode, v : Double) -> GraphtreespanningNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_tree_spanning_node_min(s : GraphtreespanningNode) -> Double { @_common.min(s.data) }

pub fn graph_tree_spanning_node_max(s : GraphtreespanningNode) -> Double { @_common.max(s.data) }

pub fn graph_tree_spanning_node_to_string(s : GraphtreespanningNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphtreespanningEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_tree_spanning_edge_make(size : Int) -> GraphtreespanningEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_tree_spanning_edge_len(s : GraphtreespanningEdge) -> Int { s.size }

pub fn graph_tree_spanning_edge_get(s : GraphtreespanningEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_tree_spanning_edge_set(s : GraphtreespanningEdge, i : Int, v : Double) -> GraphtreespanningEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_tree_spanning_edge_sum(s : GraphtreespanningEdge) -> Double { @_common.sum(s.data) }

pub fn graph_tree_spanning_edge_mean(s : GraphtreespanningEdge) -> Double { @_common.mean(s.data) }

pub fn graph_tree_spanning_edge_scale(s : GraphtreespanningEdge, f : Double) -> GraphtreespanningEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_tree_spanning_edge_add(a : GraphtreespanningEdge, b : GraphtreespanningEdge) -> GraphtreespanningEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_tree_spanning_edge_copy(s : GraphtreespanningEdge) -> GraphtreespanningEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_tree_spanning_edge_fill(s : GraphtreespanningEdge, v : Double) -> GraphtreespanningEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_tree_spanning_edge_min(s : GraphtreespanningEdge) -> Double { @_common.min(s.data) }

pub fn graph_tree_spanning_edge_max(s : GraphtreespanningEdge) -> Double { @_common.max(s.data) }

pub fn graph_tree_spanning_edge_to_string(s : GraphtreespanningEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphtreespanningPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_tree_spanning_path_make(size : Int) -> GraphtreespanningPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_tree_spanning_path_len(s : GraphtreespanningPath) -> Int { s.size }

pub fn graph_tree_spanning_path_get(s : GraphtreespanningPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_tree_spanning_path_set(s : GraphtreespanningPath, i : Int, v : Double) -> GraphtreespanningPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_tree_spanning_path_sum(s : GraphtreespanningPath) -> Double { @_common.sum(s.data) }

pub fn graph_tree_spanning_path_mean(s : GraphtreespanningPath) -> Double { @_common.mean(s.data) }

pub fn graph_tree_spanning_path_scale(s : GraphtreespanningPath, f : Double) -> GraphtreespanningPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_tree_spanning_path_add(a : GraphtreespanningPath, b : GraphtreespanningPath) -> GraphtreespanningPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_tree_spanning_path_copy(s : GraphtreespanningPath) -> GraphtreespanningPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_tree_spanning_path_fill(s : GraphtreespanningPath, v : Double) -> GraphtreespanningPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_tree_spanning_path_min(s : GraphtreespanningPath) -> Double { @_common.min(s.data) }

pub fn graph_tree_spanning_path_max(s : GraphtreespanningPath) -> Double { @_common.max(s.data) }

pub fn graph_tree_spanning_path_to_string(s : GraphtreespanningPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphtreespanningCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_tree_spanning_cluster_make(size : Int) -> GraphtreespanningCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_tree_spanning_cluster_len(s : GraphtreespanningCluster) -> Int { s.size }

pub fn graph_tree_spanning_cluster_get(s : GraphtreespanningCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_tree_spanning_cluster_set(s : GraphtreespanningCluster, i : Int, v : Double) -> GraphtreespanningCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_tree_spanning_cluster_sum(s : GraphtreespanningCluster) -> Double { @_common.sum(s.data) }

pub fn graph_tree_spanning_cluster_mean(s : GraphtreespanningCluster) -> Double { @_common.mean(s.data) }

pub fn graph_tree_spanning_cluster_scale(s : GraphtreespanningCluster, f : Double) -> GraphtreespanningCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_tree_spanning_cluster_add(a : GraphtreespanningCluster, b : GraphtreespanningCluster) -> GraphtreespanningCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_tree_spanning_cluster_copy(s : GraphtreespanningCluster) -> GraphtreespanningCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_tree_spanning_cluster_fill(s : GraphtreespanningCluster, v : Double) -> GraphtreespanningCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_tree_spanning_cluster_min(s : GraphtreespanningCluster) -> Double { @_common.min(s.data) }

pub fn graph_tree_spanning_cluster_max(s : GraphtreespanningCluster) -> Double { @_common.max(s.data) }

pub fn graph_tree_spanning_cluster_to_string(s : GraphtreespanningCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphtreespanningModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_tree_spanning_model_make(size : Int) -> GraphtreespanningModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_tree_spanning_model_len(s : GraphtreespanningModel) -> Int { s.size }

pub fn graph_tree_spanning_model_get(s : GraphtreespanningModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_tree_spanning_model_set(s : GraphtreespanningModel, i : Int, v : Double) -> GraphtreespanningModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_tree_spanning_model_sum(s : GraphtreespanningModel) -> Double { @_common.sum(s.data) }

pub fn graph_tree_spanning_model_mean(s : GraphtreespanningModel) -> Double { @_common.mean(s.data) }

pub fn graph_tree_spanning_model_scale(s : GraphtreespanningModel, f : Double) -> GraphtreespanningModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_tree_spanning_model_add(a : GraphtreespanningModel, b : GraphtreespanningModel) -> GraphtreespanningModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_tree_spanning_model_copy(s : GraphtreespanningModel) -> GraphtreespanningModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_tree_spanning_model_fill(s : GraphtreespanningModel, v : Double) -> GraphtreespanningModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_tree_spanning_model_min(s : GraphtreespanningModel) -> Double { @_common.min(s.data) }

pub fn graph_tree_spanning_model_max(s : GraphtreespanningModel) -> Double { @_common.max(s.data) }

pub fn graph_tree_spanning_model_to_string(s : GraphtreespanningModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphtreespanningLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_tree_spanning_layer_make(size : Int) -> GraphtreespanningLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_tree_spanning_layer_len(s : GraphtreespanningLayer) -> Int { s.size }

pub fn graph_tree_spanning_layer_get(s : GraphtreespanningLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_tree_spanning_layer_set(s : GraphtreespanningLayer, i : Int, v : Double) -> GraphtreespanningLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_tree_spanning_layer_sum(s : GraphtreespanningLayer) -> Double { @_common.sum(s.data) }

pub fn graph_tree_spanning_layer_mean(s : GraphtreespanningLayer) -> Double { @_common.mean(s.data) }

pub fn graph_tree_spanning_layer_scale(s : GraphtreespanningLayer, f : Double) -> GraphtreespanningLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_tree_spanning_layer_add(a : GraphtreespanningLayer, b : GraphtreespanningLayer) -> GraphtreespanningLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_tree_spanning_layer_copy(s : GraphtreespanningLayer) -> GraphtreespanningLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_tree_spanning_layer_fill(s : GraphtreespanningLayer, v : Double) -> GraphtreespanningLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_tree_spanning_layer_min(s : GraphtreespanningLayer) -> Double { @_common.min(s.data) }

pub fn graph_tree_spanning_layer_max(s : GraphtreespanningLayer) -> Double { @_common.max(s.data) }

pub fn graph_tree_spanning_layer_to_string(s : GraphtreespanningLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphtreespanningBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_tree_spanning_buffer_make(size : Int) -> GraphtreespanningBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_tree_spanning_buffer_len(s : GraphtreespanningBuffer) -> Int { s.size }

pub fn graph_tree_spanning_buffer_get(s : GraphtreespanningBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_tree_spanning_buffer_set(s : GraphtreespanningBuffer, i : Int, v : Double) -> GraphtreespanningBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_tree_spanning_buffer_sum(s : GraphtreespanningBuffer) -> Double { @_common.sum(s.data) }

pub fn graph_tree_spanning_buffer_mean(s : GraphtreespanningBuffer) -> Double { @_common.mean(s.data) }

pub fn graph_tree_spanning_buffer_scale(s : GraphtreespanningBuffer, f : Double) -> GraphtreespanningBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_tree_spanning_buffer_add(a : GraphtreespanningBuffer, b : GraphtreespanningBuffer) -> GraphtreespanningBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_tree_spanning_buffer_copy(s : GraphtreespanningBuffer) -> GraphtreespanningBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_tree_spanning_buffer_fill(s : GraphtreespanningBuffer, v : Double) -> GraphtreespanningBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_tree_spanning_buffer_min(s : GraphtreespanningBuffer) -> Double { @_common.min(s.data) }

pub fn graph_tree_spanning_buffer_max(s : GraphtreespanningBuffer) -> Double { @_common.max(s.data) }

pub fn graph_tree_spanning_buffer_to_string(s : GraphtreespanningBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphtreespanningCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_tree_spanning_cursor_make(size : Int) -> GraphtreespanningCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_tree_spanning_cursor_len(s : GraphtreespanningCursor) -> Int { s.size }

pub fn graph_tree_spanning_cursor_get(s : GraphtreespanningCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_tree_spanning_cursor_set(s : GraphtreespanningCursor, i : Int, v : Double) -> GraphtreespanningCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_tree_spanning_cursor_sum(s : GraphtreespanningCursor) -> Double { @_common.sum(s.data) }

pub fn graph_tree_spanning_cursor_mean(s : GraphtreespanningCursor) -> Double { @_common.mean(s.data) }

pub fn graph_tree_spanning_cursor_scale(s : GraphtreespanningCursor, f : Double) -> GraphtreespanningCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_tree_spanning_cursor_add(a : GraphtreespanningCursor, b : GraphtreespanningCursor) -> GraphtreespanningCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_tree_spanning_cursor_copy(s : GraphtreespanningCursor) -> GraphtreespanningCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_tree_spanning_cursor_fill(s : GraphtreespanningCursor, v : Double) -> GraphtreespanningCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_tree_spanning_cursor_min(s : GraphtreespanningCursor) -> Double { @_common.min(s.data) }

pub fn graph_tree_spanning_cursor_max(s : GraphtreespanningCursor) -> Double { @_common.max(s.data) }

pub fn graph_tree_spanning_cursor_to_string(s : GraphtreespanningCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphtreespanningView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_tree_spanning_view_make(size : Int) -> GraphtreespanningView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_tree_spanning_view_len(s : GraphtreespanningView) -> Int { s.size }

pub fn graph_tree_spanning_view_get(s : GraphtreespanningView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_tree_spanning_view_set(s : GraphtreespanningView, i : Int, v : Double) -> GraphtreespanningView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_tree_spanning_view_sum(s : GraphtreespanningView) -> Double { @_common.sum(s.data) }

pub fn graph_tree_spanning_view_mean(s : GraphtreespanningView) -> Double { @_common.mean(s.data) }

pub fn graph_tree_spanning_view_scale(s : GraphtreespanningView, f : Double) -> GraphtreespanningView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_tree_spanning_view_add(a : GraphtreespanningView, b : GraphtreespanningView) -> GraphtreespanningView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_tree_spanning_view_copy(s : GraphtreespanningView) -> GraphtreespanningView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_tree_spanning_view_fill(s : GraphtreespanningView, v : Double) -> GraphtreespanningView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_tree_spanning_view_min(s : GraphtreespanningView) -> Double { @_common.min(s.data) }

pub fn graph_tree_spanning_view_max(s : GraphtreespanningView) -> Double { @_common.max(s.data) }

pub fn graph_tree_spanning_view_to_string(s : GraphtreespanningView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphtreespanningRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_tree_spanning_range_make(size : Int) -> GraphtreespanningRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_tree_spanning_range_len(s : GraphtreespanningRange) -> Int { s.size }

pub fn graph_tree_spanning_range_get(s : GraphtreespanningRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_tree_spanning_range_set(s : GraphtreespanningRange, i : Int, v : Double) -> GraphtreespanningRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_tree_spanning_range_sum(s : GraphtreespanningRange) -> Double { @_common.sum(s.data) }

pub fn graph_tree_spanning_range_mean(s : GraphtreespanningRange) -> Double { @_common.mean(s.data) }

pub fn graph_tree_spanning_range_scale(s : GraphtreespanningRange, f : Double) -> GraphtreespanningRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_tree_spanning_range_add(a : GraphtreespanningRange, b : GraphtreespanningRange) -> GraphtreespanningRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_tree_spanning_range_copy(s : GraphtreespanningRange) -> GraphtreespanningRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_tree_spanning_range_fill(s : GraphtreespanningRange, v : Double) -> GraphtreespanningRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_tree_spanning_range_min(s : GraphtreespanningRange) -> Double { @_common.min(s.data) }

pub fn graph_tree_spanning_range_max(s : GraphtreespanningRange) -> Double { @_common.max(s.data) }

pub fn graph_tree_spanning_range_to_string(s : GraphtreespanningRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphtreespanningSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_tree_spanning_slice_make(size : Int) -> GraphtreespanningSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_tree_spanning_slice_len(s : GraphtreespanningSlice) -> Int { s.size }

pub fn graph_tree_spanning_slice_get(s : GraphtreespanningSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_tree_spanning_slice_set(s : GraphtreespanningSlice, i : Int, v : Double) -> GraphtreespanningSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_tree_spanning_slice_sum(s : GraphtreespanningSlice) -> Double { @_common.sum(s.data) }

pub fn graph_tree_spanning_slice_mean(s : GraphtreespanningSlice) -> Double { @_common.mean(s.data) }

pub fn graph_tree_spanning_slice_scale(s : GraphtreespanningSlice, f : Double) -> GraphtreespanningSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_tree_spanning_slice_add(a : GraphtreespanningSlice, b : GraphtreespanningSlice) -> GraphtreespanningSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_tree_spanning_slice_copy(s : GraphtreespanningSlice) -> GraphtreespanningSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_tree_spanning_slice_fill(s : GraphtreespanningSlice, v : Double) -> GraphtreespanningSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_tree_spanning_slice_min(s : GraphtreespanningSlice) -> Double { @_common.min(s.data) }

pub fn graph_tree_spanning_slice_max(s : GraphtreespanningSlice) -> Double { @_common.max(s.data) }

pub fn graph_tree_spanning_slice_to_string(s : GraphtreespanningSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

