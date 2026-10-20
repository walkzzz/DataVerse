///===
/// extcore/graph_tree_diameter

pub(all) struct GraphtreediameterPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn graph_tree_diameter_make_point(x : Double, y : Double) -> GraphtreediameterPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn graph_tree_diameter_make_point3(x : Double, y : Double, z : Double) -> GraphtreediameterPoint {
  { x, y, z, label: 0 }
}

pub fn GraphtreediameterPoint::x(self : GraphtreediameterPoint) -> Double { self.x }

pub fn GraphtreediameterPoint::y(self : GraphtreediameterPoint) -> Double { self.y }

pub fn GraphtreediameterPoint::z(self : GraphtreediameterPoint) -> Double { self.z }

pub fn GraphtreediameterPoint::label(self : GraphtreediameterPoint) -> Int { self.label }

pub fn GraphtreediameterPoint::dist(self : GraphtreediameterPoint, other : GraphtreediameterPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn GraphtreediameterPoint::add(self : GraphtreediameterPoint, other : GraphtreediameterPoint) -> GraphtreediameterPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn GraphtreediameterPoint::sub(self : GraphtreediameterPoint, other : GraphtreediameterPoint) -> GraphtreediameterPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn GraphtreediameterPoint::scale(self : GraphtreediameterPoint, s : Double) -> GraphtreediameterPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn GraphtreediameterPoint::dot(self : GraphtreediameterPoint, other : GraphtreediameterPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn GraphtreediameterPoint::cross(self : GraphtreediameterPoint, other : GraphtreediameterPoint) -> GraphtreediameterPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn GraphtreediameterPoint::norm(self : GraphtreediameterPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn GraphtreediameterPoint::normalize(self : GraphtreediameterPoint) -> GraphtreediameterPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn GraphtreediameterPoint::negate(self : GraphtreediameterPoint) -> GraphtreediameterPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn GraphtreediameterPoint::mid(self : GraphtreediameterPoint, other : GraphtreediameterPoint) -> GraphtreediameterPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn GraphtreediameterPoint::lerp(self : GraphtreediameterPoint, other : GraphtreediameterPoint, t : Double) -> GraphtreediameterPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn GraphtreediameterPoint::to_string(self : GraphtreediameterPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct GraphtreediameterSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn graph_tree_diameter_make_series(vals : Array[Double], name : String) -> GraphtreediameterSeries {
  { vals, name, meta: 0 }
}

pub fn GraphtreediameterSeries::len(self : GraphtreediameterSeries) -> Int { self.vals.length() }

pub fn GraphtreediameterSeries::sum(self : GraphtreediameterSeries) -> Double { @_common.sum(self.vals) }

pub fn GraphtreediameterSeries::mean(self : GraphtreediameterSeries) -> Double { @_common.mean(self.vals) }

pub fn GraphtreediameterSeries::min(self : GraphtreediameterSeries) -> Double { @_common.min(self.vals) }

pub fn GraphtreediameterSeries::max(self : GraphtreediameterSeries) -> Double { @_common.max(self.vals) }

pub fn GraphtreediameterSeries::range(self : GraphtreediameterSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn GraphtreediameterSeries::variance(self : GraphtreediameterSeries) -> Double { @_common.variance(self.vals) }

pub fn GraphtreediameterSeries::std(self : GraphtreediameterSeries) -> Double { @_common.std(self.vals) }

pub fn GraphtreediameterSeries::median(self : GraphtreediameterSeries) -> Double { @_common.median(self.vals) }

pub fn GraphtreediameterSeries::scale(self : GraphtreediameterSeries, f : Double) -> GraphtreediameterSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn GraphtreediameterSeries::add(self : GraphtreediameterSeries, other : GraphtreediameterSeries) -> GraphtreediameterSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn GraphtreediameterSeries::sub(self : GraphtreediameterSeries, other : GraphtreediameterSeries) -> GraphtreediameterSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn GraphtreediameterSeries::normalize(self : GraphtreediameterSeries) -> GraphtreediameterSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn GraphtreediameterSeries::cumsum(self : GraphtreediameterSeries) -> GraphtreediameterSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn GraphtreediameterSeries::to_string(self : GraphtreediameterSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct GraphtreediameterMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn graph_tree_diameter_make_matrix(rows : Int, cols : Int, val : Double) -> GraphtreediameterMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn graph_tree_diameter_matrix_identity(n : Int) -> GraphtreediameterMatrix {
  let m = graph_tree_diameter_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn GraphtreediameterMatrix::get(self : GraphtreediameterMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn GraphtreediameterMatrix::transpose(self : GraphtreediameterMatrix) -> GraphtreediameterMatrix {
  let result = graph_tree_diameter_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn GraphtreediameterMatrix::add(self : GraphtreediameterMatrix, other : GraphtreediameterMatrix) -> GraphtreediameterMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = graph_tree_diameter_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn GraphtreediameterMatrix::scale(self : GraphtreediameterMatrix, s : Double) -> GraphtreediameterMatrix {
  let result = graph_tree_diameter_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn GraphtreediameterMatrix::multiply(self : GraphtreediameterMatrix, other : GraphtreediameterMatrix) -> GraphtreediameterMatrix {
  if self.cols != other.rows { return graph_tree_diameter_make_matrix(self.rows, other.cols, 0.0) }
  let result = graph_tree_diameter_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn GraphtreediameterMatrix::trace(self : GraphtreediameterMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn GraphtreediameterMatrix::det(self : GraphtreediameterMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn GraphtreediameterMatrix::norm(self : GraphtreediameterMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn GraphtreediameterMatrix::to_string(self : GraphtreediameterMatrix) -> String {
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

pub(all) struct GraphtreediameterVector {
  comps : Array[Double]
  dim : Int
}

pub fn graph_tree_diameter_make_vector(comps : Array[Double]) -> GraphtreediameterVector {
  { comps, dim: comps.length() }
}

pub fn graph_tree_diameter_vector_zero(dim : Int) -> GraphtreediameterVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn GraphtreediameterVector::add(self : GraphtreediameterVector, other : GraphtreediameterVector) -> GraphtreediameterVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn GraphtreediameterVector::sub(self : GraphtreediameterVector, other : GraphtreediameterVector) -> GraphtreediameterVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn GraphtreediameterVector::scale(self : GraphtreediameterVector, s : Double) -> GraphtreediameterVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn GraphtreediameterVector::dot(self : GraphtreediameterVector, other : GraphtreediameterVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn GraphtreediameterVector::norm(self : GraphtreediameterVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn GraphtreediameterVector::normalize(self : GraphtreediameterVector) -> GraphtreediameterVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn GraphtreediameterVector::dist(self : GraphtreediameterVector, other : GraphtreediameterVector) -> Double {
  self.sub(other).norm()
}

pub fn GraphtreediameterVector::to_string(self : GraphtreediameterVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn graph_tree_diameter_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn graph_tree_diameter_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn graph_tree_diameter_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn graph_tree_diameter_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn graph_tree_diameter_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn graph_tree_diameter_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn graph_tree_diameter_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn graph_tree_diameter_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn graph_tree_diameter_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn graph_tree_diameter_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn graph_tree_diameter_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn graph_tree_diameter_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn graph_tree_diameter_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn graph_tree_diameter_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn graph_tree_diameter_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn graph_tree_diameter_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn graph_tree_diameter_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn graph_tree_diameter_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn graph_tree_diameter_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn graph_tree_diameter_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn graph_tree_diameter_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn graph_tree_diameter_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn graph_tree_diameter_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn graph_tree_diameter_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn graph_tree_diameter_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn graph_tree_diameter_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn graph_tree_diameter_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn graph_tree_diameter_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn graph_tree_diameter_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct GraphtreediameterFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_tree_diameter_frame_make(size : Int) -> GraphtreediameterFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_tree_diameter_frame_len(s : GraphtreediameterFrame) -> Int { s.size }

pub fn graph_tree_diameter_frame_get(s : GraphtreediameterFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_tree_diameter_frame_set(s : GraphtreediameterFrame, i : Int, v : Double) -> GraphtreediameterFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_tree_diameter_frame_sum(s : GraphtreediameterFrame) -> Double { @_common.sum(s.data) }

pub fn graph_tree_diameter_frame_mean(s : GraphtreediameterFrame) -> Double { @_common.mean(s.data) }

pub fn graph_tree_diameter_frame_scale(s : GraphtreediameterFrame, f : Double) -> GraphtreediameterFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_tree_diameter_frame_add(a : GraphtreediameterFrame, b : GraphtreediameterFrame) -> GraphtreediameterFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_tree_diameter_frame_copy(s : GraphtreediameterFrame) -> GraphtreediameterFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_tree_diameter_frame_fill(s : GraphtreediameterFrame, v : Double) -> GraphtreediameterFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_tree_diameter_frame_min(s : GraphtreediameterFrame) -> Double { @_common.min(s.data) }

pub fn graph_tree_diameter_frame_max(s : GraphtreediameterFrame) -> Double { @_common.max(s.data) }

pub fn graph_tree_diameter_frame_to_string(s : GraphtreediameterFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphtreediameterTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_tree_diameter_table_make(size : Int) -> GraphtreediameterTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_tree_diameter_table_len(s : GraphtreediameterTable) -> Int { s.size }

pub fn graph_tree_diameter_table_get(s : GraphtreediameterTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_tree_diameter_table_set(s : GraphtreediameterTable, i : Int, v : Double) -> GraphtreediameterTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_tree_diameter_table_sum(s : GraphtreediameterTable) -> Double { @_common.sum(s.data) }

pub fn graph_tree_diameter_table_mean(s : GraphtreediameterTable) -> Double { @_common.mean(s.data) }

pub fn graph_tree_diameter_table_scale(s : GraphtreediameterTable, f : Double) -> GraphtreediameterTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_tree_diameter_table_add(a : GraphtreediameterTable, b : GraphtreediameterTable) -> GraphtreediameterTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_tree_diameter_table_copy(s : GraphtreediameterTable) -> GraphtreediameterTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_tree_diameter_table_fill(s : GraphtreediameterTable, v : Double) -> GraphtreediameterTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_tree_diameter_table_min(s : GraphtreediameterTable) -> Double { @_common.min(s.data) }

pub fn graph_tree_diameter_table_max(s : GraphtreediameterTable) -> Double { @_common.max(s.data) }

pub fn graph_tree_diameter_table_to_string(s : GraphtreediameterTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphtreediameterGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_tree_diameter_graphn_make(size : Int) -> GraphtreediameterGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_tree_diameter_graphn_len(s : GraphtreediameterGraphN) -> Int { s.size }

pub fn graph_tree_diameter_graphn_get(s : GraphtreediameterGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_tree_diameter_graphn_set(s : GraphtreediameterGraphN, i : Int, v : Double) -> GraphtreediameterGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_tree_diameter_graphn_sum(s : GraphtreediameterGraphN) -> Double { @_common.sum(s.data) }

pub fn graph_tree_diameter_graphn_mean(s : GraphtreediameterGraphN) -> Double { @_common.mean(s.data) }

pub fn graph_tree_diameter_graphn_scale(s : GraphtreediameterGraphN, f : Double) -> GraphtreediameterGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_tree_diameter_graphn_add(a : GraphtreediameterGraphN, b : GraphtreediameterGraphN) -> GraphtreediameterGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_tree_diameter_graphn_copy(s : GraphtreediameterGraphN) -> GraphtreediameterGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_tree_diameter_graphn_fill(s : GraphtreediameterGraphN, v : Double) -> GraphtreediameterGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_tree_diameter_graphn_min(s : GraphtreediameterGraphN) -> Double { @_common.min(s.data) }

pub fn graph_tree_diameter_graphn_max(s : GraphtreediameterGraphN) -> Double { @_common.max(s.data) }

pub fn graph_tree_diameter_graphn_to_string(s : GraphtreediameterGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphtreediameterNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_tree_diameter_node_make(size : Int) -> GraphtreediameterNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_tree_diameter_node_len(s : GraphtreediameterNode) -> Int { s.size }

pub fn graph_tree_diameter_node_get(s : GraphtreediameterNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_tree_diameter_node_set(s : GraphtreediameterNode, i : Int, v : Double) -> GraphtreediameterNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_tree_diameter_node_sum(s : GraphtreediameterNode) -> Double { @_common.sum(s.data) }

pub fn graph_tree_diameter_node_mean(s : GraphtreediameterNode) -> Double { @_common.mean(s.data) }

pub fn graph_tree_diameter_node_scale(s : GraphtreediameterNode, f : Double) -> GraphtreediameterNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_tree_diameter_node_add(a : GraphtreediameterNode, b : GraphtreediameterNode) -> GraphtreediameterNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_tree_diameter_node_copy(s : GraphtreediameterNode) -> GraphtreediameterNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_tree_diameter_node_fill(s : GraphtreediameterNode, v : Double) -> GraphtreediameterNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_tree_diameter_node_min(s : GraphtreediameterNode) -> Double { @_common.min(s.data) }

pub fn graph_tree_diameter_node_max(s : GraphtreediameterNode) -> Double { @_common.max(s.data) }

pub fn graph_tree_diameter_node_to_string(s : GraphtreediameterNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphtreediameterEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_tree_diameter_edge_make(size : Int) -> GraphtreediameterEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_tree_diameter_edge_len(s : GraphtreediameterEdge) -> Int { s.size }

pub fn graph_tree_diameter_edge_get(s : GraphtreediameterEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_tree_diameter_edge_set(s : GraphtreediameterEdge, i : Int, v : Double) -> GraphtreediameterEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_tree_diameter_edge_sum(s : GraphtreediameterEdge) -> Double { @_common.sum(s.data) }

pub fn graph_tree_diameter_edge_mean(s : GraphtreediameterEdge) -> Double { @_common.mean(s.data) }

pub fn graph_tree_diameter_edge_scale(s : GraphtreediameterEdge, f : Double) -> GraphtreediameterEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_tree_diameter_edge_add(a : GraphtreediameterEdge, b : GraphtreediameterEdge) -> GraphtreediameterEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_tree_diameter_edge_copy(s : GraphtreediameterEdge) -> GraphtreediameterEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_tree_diameter_edge_fill(s : GraphtreediameterEdge, v : Double) -> GraphtreediameterEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_tree_diameter_edge_min(s : GraphtreediameterEdge) -> Double { @_common.min(s.data) }

pub fn graph_tree_diameter_edge_max(s : GraphtreediameterEdge) -> Double { @_common.max(s.data) }

pub fn graph_tree_diameter_edge_to_string(s : GraphtreediameterEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphtreediameterPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_tree_diameter_path_make(size : Int) -> GraphtreediameterPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_tree_diameter_path_len(s : GraphtreediameterPath) -> Int { s.size }

pub fn graph_tree_diameter_path_get(s : GraphtreediameterPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_tree_diameter_path_set(s : GraphtreediameterPath, i : Int, v : Double) -> GraphtreediameterPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_tree_diameter_path_sum(s : GraphtreediameterPath) -> Double { @_common.sum(s.data) }

pub fn graph_tree_diameter_path_mean(s : GraphtreediameterPath) -> Double { @_common.mean(s.data) }

pub fn graph_tree_diameter_path_scale(s : GraphtreediameterPath, f : Double) -> GraphtreediameterPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_tree_diameter_path_add(a : GraphtreediameterPath, b : GraphtreediameterPath) -> GraphtreediameterPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_tree_diameter_path_copy(s : GraphtreediameterPath) -> GraphtreediameterPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_tree_diameter_path_fill(s : GraphtreediameterPath, v : Double) -> GraphtreediameterPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_tree_diameter_path_min(s : GraphtreediameterPath) -> Double { @_common.min(s.data) }

pub fn graph_tree_diameter_path_max(s : GraphtreediameterPath) -> Double { @_common.max(s.data) }

pub fn graph_tree_diameter_path_to_string(s : GraphtreediameterPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphtreediameterCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_tree_diameter_cluster_make(size : Int) -> GraphtreediameterCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_tree_diameter_cluster_len(s : GraphtreediameterCluster) -> Int { s.size }

pub fn graph_tree_diameter_cluster_get(s : GraphtreediameterCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_tree_diameter_cluster_set(s : GraphtreediameterCluster, i : Int, v : Double) -> GraphtreediameterCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_tree_diameter_cluster_sum(s : GraphtreediameterCluster) -> Double { @_common.sum(s.data) }

pub fn graph_tree_diameter_cluster_mean(s : GraphtreediameterCluster) -> Double { @_common.mean(s.data) }

pub fn graph_tree_diameter_cluster_scale(s : GraphtreediameterCluster, f : Double) -> GraphtreediameterCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_tree_diameter_cluster_add(a : GraphtreediameterCluster, b : GraphtreediameterCluster) -> GraphtreediameterCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_tree_diameter_cluster_copy(s : GraphtreediameterCluster) -> GraphtreediameterCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_tree_diameter_cluster_fill(s : GraphtreediameterCluster, v : Double) -> GraphtreediameterCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_tree_diameter_cluster_min(s : GraphtreediameterCluster) -> Double { @_common.min(s.data) }

pub fn graph_tree_diameter_cluster_max(s : GraphtreediameterCluster) -> Double { @_common.max(s.data) }

pub fn graph_tree_diameter_cluster_to_string(s : GraphtreediameterCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphtreediameterModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_tree_diameter_model_make(size : Int) -> GraphtreediameterModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_tree_diameter_model_len(s : GraphtreediameterModel) -> Int { s.size }

pub fn graph_tree_diameter_model_get(s : GraphtreediameterModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_tree_diameter_model_set(s : GraphtreediameterModel, i : Int, v : Double) -> GraphtreediameterModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_tree_diameter_model_sum(s : GraphtreediameterModel) -> Double { @_common.sum(s.data) }

pub fn graph_tree_diameter_model_mean(s : GraphtreediameterModel) -> Double { @_common.mean(s.data) }

pub fn graph_tree_diameter_model_scale(s : GraphtreediameterModel, f : Double) -> GraphtreediameterModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_tree_diameter_model_add(a : GraphtreediameterModel, b : GraphtreediameterModel) -> GraphtreediameterModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_tree_diameter_model_copy(s : GraphtreediameterModel) -> GraphtreediameterModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_tree_diameter_model_fill(s : GraphtreediameterModel, v : Double) -> GraphtreediameterModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_tree_diameter_model_min(s : GraphtreediameterModel) -> Double { @_common.min(s.data) }

pub fn graph_tree_diameter_model_max(s : GraphtreediameterModel) -> Double { @_common.max(s.data) }

pub fn graph_tree_diameter_model_to_string(s : GraphtreediameterModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphtreediameterLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_tree_diameter_layer_make(size : Int) -> GraphtreediameterLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_tree_diameter_layer_len(s : GraphtreediameterLayer) -> Int { s.size }

pub fn graph_tree_diameter_layer_get(s : GraphtreediameterLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_tree_diameter_layer_set(s : GraphtreediameterLayer, i : Int, v : Double) -> GraphtreediameterLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_tree_diameter_layer_sum(s : GraphtreediameterLayer) -> Double { @_common.sum(s.data) }

pub fn graph_tree_diameter_layer_mean(s : GraphtreediameterLayer) -> Double { @_common.mean(s.data) }

pub fn graph_tree_diameter_layer_scale(s : GraphtreediameterLayer, f : Double) -> GraphtreediameterLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_tree_diameter_layer_add(a : GraphtreediameterLayer, b : GraphtreediameterLayer) -> GraphtreediameterLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_tree_diameter_layer_copy(s : GraphtreediameterLayer) -> GraphtreediameterLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_tree_diameter_layer_fill(s : GraphtreediameterLayer, v : Double) -> GraphtreediameterLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_tree_diameter_layer_min(s : GraphtreediameterLayer) -> Double { @_common.min(s.data) }

pub fn graph_tree_diameter_layer_max(s : GraphtreediameterLayer) -> Double { @_common.max(s.data) }

pub fn graph_tree_diameter_layer_to_string(s : GraphtreediameterLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphtreediameterBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_tree_diameter_buffer_make(size : Int) -> GraphtreediameterBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_tree_diameter_buffer_len(s : GraphtreediameterBuffer) -> Int { s.size }

pub fn graph_tree_diameter_buffer_get(s : GraphtreediameterBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_tree_diameter_buffer_set(s : GraphtreediameterBuffer, i : Int, v : Double) -> GraphtreediameterBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_tree_diameter_buffer_sum(s : GraphtreediameterBuffer) -> Double { @_common.sum(s.data) }

pub fn graph_tree_diameter_buffer_mean(s : GraphtreediameterBuffer) -> Double { @_common.mean(s.data) }

pub fn graph_tree_diameter_buffer_scale(s : GraphtreediameterBuffer, f : Double) -> GraphtreediameterBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_tree_diameter_buffer_add(a : GraphtreediameterBuffer, b : GraphtreediameterBuffer) -> GraphtreediameterBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_tree_diameter_buffer_copy(s : GraphtreediameterBuffer) -> GraphtreediameterBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_tree_diameter_buffer_fill(s : GraphtreediameterBuffer, v : Double) -> GraphtreediameterBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_tree_diameter_buffer_min(s : GraphtreediameterBuffer) -> Double { @_common.min(s.data) }

pub fn graph_tree_diameter_buffer_max(s : GraphtreediameterBuffer) -> Double { @_common.max(s.data) }

pub fn graph_tree_diameter_buffer_to_string(s : GraphtreediameterBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphtreediameterCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_tree_diameter_cursor_make(size : Int) -> GraphtreediameterCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_tree_diameter_cursor_len(s : GraphtreediameterCursor) -> Int { s.size }

pub fn graph_tree_diameter_cursor_get(s : GraphtreediameterCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_tree_diameter_cursor_set(s : GraphtreediameterCursor, i : Int, v : Double) -> GraphtreediameterCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_tree_diameter_cursor_sum(s : GraphtreediameterCursor) -> Double { @_common.sum(s.data) }

pub fn graph_tree_diameter_cursor_mean(s : GraphtreediameterCursor) -> Double { @_common.mean(s.data) }

pub fn graph_tree_diameter_cursor_scale(s : GraphtreediameterCursor, f : Double) -> GraphtreediameterCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_tree_diameter_cursor_add(a : GraphtreediameterCursor, b : GraphtreediameterCursor) -> GraphtreediameterCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_tree_diameter_cursor_copy(s : GraphtreediameterCursor) -> GraphtreediameterCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_tree_diameter_cursor_fill(s : GraphtreediameterCursor, v : Double) -> GraphtreediameterCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_tree_diameter_cursor_min(s : GraphtreediameterCursor) -> Double { @_common.min(s.data) }

pub fn graph_tree_diameter_cursor_max(s : GraphtreediameterCursor) -> Double { @_common.max(s.data) }

pub fn graph_tree_diameter_cursor_to_string(s : GraphtreediameterCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphtreediameterView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_tree_diameter_view_make(size : Int) -> GraphtreediameterView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_tree_diameter_view_len(s : GraphtreediameterView) -> Int { s.size }

pub fn graph_tree_diameter_view_get(s : GraphtreediameterView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_tree_diameter_view_set(s : GraphtreediameterView, i : Int, v : Double) -> GraphtreediameterView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_tree_diameter_view_sum(s : GraphtreediameterView) -> Double { @_common.sum(s.data) }

pub fn graph_tree_diameter_view_mean(s : GraphtreediameterView) -> Double { @_common.mean(s.data) }

pub fn graph_tree_diameter_view_scale(s : GraphtreediameterView, f : Double) -> GraphtreediameterView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_tree_diameter_view_add(a : GraphtreediameterView, b : GraphtreediameterView) -> GraphtreediameterView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_tree_diameter_view_copy(s : GraphtreediameterView) -> GraphtreediameterView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_tree_diameter_view_fill(s : GraphtreediameterView, v : Double) -> GraphtreediameterView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_tree_diameter_view_min(s : GraphtreediameterView) -> Double { @_common.min(s.data) }

pub fn graph_tree_diameter_view_max(s : GraphtreediameterView) -> Double { @_common.max(s.data) }

pub fn graph_tree_diameter_view_to_string(s : GraphtreediameterView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphtreediameterRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_tree_diameter_range_make(size : Int) -> GraphtreediameterRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_tree_diameter_range_len(s : GraphtreediameterRange) -> Int { s.size }

pub fn graph_tree_diameter_range_get(s : GraphtreediameterRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_tree_diameter_range_set(s : GraphtreediameterRange, i : Int, v : Double) -> GraphtreediameterRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_tree_diameter_range_sum(s : GraphtreediameterRange) -> Double { @_common.sum(s.data) }

pub fn graph_tree_diameter_range_mean(s : GraphtreediameterRange) -> Double { @_common.mean(s.data) }

pub fn graph_tree_diameter_range_scale(s : GraphtreediameterRange, f : Double) -> GraphtreediameterRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_tree_diameter_range_add(a : GraphtreediameterRange, b : GraphtreediameterRange) -> GraphtreediameterRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_tree_diameter_range_copy(s : GraphtreediameterRange) -> GraphtreediameterRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_tree_diameter_range_fill(s : GraphtreediameterRange, v : Double) -> GraphtreediameterRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_tree_diameter_range_min(s : GraphtreediameterRange) -> Double { @_common.min(s.data) }

pub fn graph_tree_diameter_range_max(s : GraphtreediameterRange) -> Double { @_common.max(s.data) }

pub fn graph_tree_diameter_range_to_string(s : GraphtreediameterRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphtreediameterSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_tree_diameter_slice_make(size : Int) -> GraphtreediameterSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_tree_diameter_slice_len(s : GraphtreediameterSlice) -> Int { s.size }

pub fn graph_tree_diameter_slice_get(s : GraphtreediameterSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_tree_diameter_slice_set(s : GraphtreediameterSlice, i : Int, v : Double) -> GraphtreediameterSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_tree_diameter_slice_sum(s : GraphtreediameterSlice) -> Double { @_common.sum(s.data) }

pub fn graph_tree_diameter_slice_mean(s : GraphtreediameterSlice) -> Double { @_common.mean(s.data) }

pub fn graph_tree_diameter_slice_scale(s : GraphtreediameterSlice, f : Double) -> GraphtreediameterSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_tree_diameter_slice_add(a : GraphtreediameterSlice, b : GraphtreediameterSlice) -> GraphtreediameterSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_tree_diameter_slice_copy(s : GraphtreediameterSlice) -> GraphtreediameterSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_tree_diameter_slice_fill(s : GraphtreediameterSlice, v : Double) -> GraphtreediameterSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_tree_diameter_slice_min(s : GraphtreediameterSlice) -> Double { @_common.min(s.data) }

pub fn graph_tree_diameter_slice_max(s : GraphtreediameterSlice) -> Double { @_common.max(s.data) }

pub fn graph_tree_diameter_slice_to_string(s : GraphtreediameterSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

