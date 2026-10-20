///===
/// extcore/graph_color_list

pub(all) struct GraphcolorlistPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn graph_color_list_make_point(x : Double, y : Double) -> GraphcolorlistPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn graph_color_list_make_point3(x : Double, y : Double, z : Double) -> GraphcolorlistPoint {
  { x, y, z, label: 0 }
}

pub fn GraphcolorlistPoint::x(self : GraphcolorlistPoint) -> Double { self.x }

pub fn GraphcolorlistPoint::y(self : GraphcolorlistPoint) -> Double { self.y }

pub fn GraphcolorlistPoint::z(self : GraphcolorlistPoint) -> Double { self.z }

pub fn GraphcolorlistPoint::label(self : GraphcolorlistPoint) -> Int { self.label }

pub fn GraphcolorlistPoint::dist(self : GraphcolorlistPoint, other : GraphcolorlistPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn GraphcolorlistPoint::add(self : GraphcolorlistPoint, other : GraphcolorlistPoint) -> GraphcolorlistPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn GraphcolorlistPoint::sub(self : GraphcolorlistPoint, other : GraphcolorlistPoint) -> GraphcolorlistPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn GraphcolorlistPoint::scale(self : GraphcolorlistPoint, s : Double) -> GraphcolorlistPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn GraphcolorlistPoint::dot(self : GraphcolorlistPoint, other : GraphcolorlistPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn GraphcolorlistPoint::cross(self : GraphcolorlistPoint, other : GraphcolorlistPoint) -> GraphcolorlistPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn GraphcolorlistPoint::norm(self : GraphcolorlistPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn GraphcolorlistPoint::normalize(self : GraphcolorlistPoint) -> GraphcolorlistPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn GraphcolorlistPoint::negate(self : GraphcolorlistPoint) -> GraphcolorlistPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn GraphcolorlistPoint::mid(self : GraphcolorlistPoint, other : GraphcolorlistPoint) -> GraphcolorlistPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn GraphcolorlistPoint::lerp(self : GraphcolorlistPoint, other : GraphcolorlistPoint, t : Double) -> GraphcolorlistPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn GraphcolorlistPoint::to_string(self : GraphcolorlistPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct GraphcolorlistSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn graph_color_list_make_series(vals : Array[Double], name : String) -> GraphcolorlistSeries {
  { vals, name, meta: 0 }
}

pub fn GraphcolorlistSeries::len(self : GraphcolorlistSeries) -> Int { self.vals.length() }

pub fn GraphcolorlistSeries::sum(self : GraphcolorlistSeries) -> Double { @_common.sum(self.vals) }

pub fn GraphcolorlistSeries::mean(self : GraphcolorlistSeries) -> Double { @_common.mean(self.vals) }

pub fn GraphcolorlistSeries::min(self : GraphcolorlistSeries) -> Double { @_common.min(self.vals) }

pub fn GraphcolorlistSeries::max(self : GraphcolorlistSeries) -> Double { @_common.max(self.vals) }

pub fn GraphcolorlistSeries::range(self : GraphcolorlistSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn GraphcolorlistSeries::variance(self : GraphcolorlistSeries) -> Double { @_common.variance(self.vals) }

pub fn GraphcolorlistSeries::std(self : GraphcolorlistSeries) -> Double { @_common.std(self.vals) }

pub fn GraphcolorlistSeries::median(self : GraphcolorlistSeries) -> Double { @_common.median(self.vals) }

pub fn GraphcolorlistSeries::scale(self : GraphcolorlistSeries, f : Double) -> GraphcolorlistSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn GraphcolorlistSeries::add(self : GraphcolorlistSeries, other : GraphcolorlistSeries) -> GraphcolorlistSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn GraphcolorlistSeries::sub(self : GraphcolorlistSeries, other : GraphcolorlistSeries) -> GraphcolorlistSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn GraphcolorlistSeries::normalize(self : GraphcolorlistSeries) -> GraphcolorlistSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn GraphcolorlistSeries::cumsum(self : GraphcolorlistSeries) -> GraphcolorlistSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn GraphcolorlistSeries::to_string(self : GraphcolorlistSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct GraphcolorlistMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn graph_color_list_make_matrix(rows : Int, cols : Int, val : Double) -> GraphcolorlistMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn graph_color_list_matrix_identity(n : Int) -> GraphcolorlistMatrix {
  let m = graph_color_list_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn GraphcolorlistMatrix::get(self : GraphcolorlistMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn GraphcolorlistMatrix::transpose(self : GraphcolorlistMatrix) -> GraphcolorlistMatrix {
  let result = graph_color_list_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn GraphcolorlistMatrix::add(self : GraphcolorlistMatrix, other : GraphcolorlistMatrix) -> GraphcolorlistMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = graph_color_list_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn GraphcolorlistMatrix::scale(self : GraphcolorlistMatrix, s : Double) -> GraphcolorlistMatrix {
  let result = graph_color_list_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn GraphcolorlistMatrix::multiply(self : GraphcolorlistMatrix, other : GraphcolorlistMatrix) -> GraphcolorlistMatrix {
  if self.cols != other.rows { return graph_color_list_make_matrix(self.rows, other.cols, 0.0) }
  let result = graph_color_list_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn GraphcolorlistMatrix::trace(self : GraphcolorlistMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn GraphcolorlistMatrix::det(self : GraphcolorlistMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn GraphcolorlistMatrix::norm(self : GraphcolorlistMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn GraphcolorlistMatrix::to_string(self : GraphcolorlistMatrix) -> String {
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

pub(all) struct GraphcolorlistVector {
  comps : Array[Double]
  dim : Int
}

pub fn graph_color_list_make_vector(comps : Array[Double]) -> GraphcolorlistVector {
  { comps, dim: comps.length() }
}

pub fn graph_color_list_vector_zero(dim : Int) -> GraphcolorlistVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn GraphcolorlistVector::add(self : GraphcolorlistVector, other : GraphcolorlistVector) -> GraphcolorlistVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn GraphcolorlistVector::sub(self : GraphcolorlistVector, other : GraphcolorlistVector) -> GraphcolorlistVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn GraphcolorlistVector::scale(self : GraphcolorlistVector, s : Double) -> GraphcolorlistVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn GraphcolorlistVector::dot(self : GraphcolorlistVector, other : GraphcolorlistVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn GraphcolorlistVector::norm(self : GraphcolorlistVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn GraphcolorlistVector::normalize(self : GraphcolorlistVector) -> GraphcolorlistVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn GraphcolorlistVector::dist(self : GraphcolorlistVector, other : GraphcolorlistVector) -> Double {
  self.sub(other).norm()
}

pub fn GraphcolorlistVector::to_string(self : GraphcolorlistVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn graph_color_list_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn graph_color_list_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn graph_color_list_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn graph_color_list_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn graph_color_list_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn graph_color_list_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn graph_color_list_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn graph_color_list_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn graph_color_list_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn graph_color_list_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn graph_color_list_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn graph_color_list_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn graph_color_list_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn graph_color_list_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn graph_color_list_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn graph_color_list_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn graph_color_list_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn graph_color_list_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn graph_color_list_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn graph_color_list_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn graph_color_list_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn graph_color_list_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn graph_color_list_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn graph_color_list_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn graph_color_list_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn graph_color_list_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn graph_color_list_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn graph_color_list_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn graph_color_list_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct GraphcolorlistFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_color_list_frame_make(size : Int) -> GraphcolorlistFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_color_list_frame_len(s : GraphcolorlistFrame) -> Int { s.size }

pub fn graph_color_list_frame_get(s : GraphcolorlistFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_color_list_frame_set(s : GraphcolorlistFrame, i : Int, v : Double) -> GraphcolorlistFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_color_list_frame_sum(s : GraphcolorlistFrame) -> Double { @_common.sum(s.data) }

pub fn graph_color_list_frame_mean(s : GraphcolorlistFrame) -> Double { @_common.mean(s.data) }

pub fn graph_color_list_frame_scale(s : GraphcolorlistFrame, f : Double) -> GraphcolorlistFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_color_list_frame_add(a : GraphcolorlistFrame, b : GraphcolorlistFrame) -> GraphcolorlistFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_color_list_frame_copy(s : GraphcolorlistFrame) -> GraphcolorlistFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_color_list_frame_fill(s : GraphcolorlistFrame, v : Double) -> GraphcolorlistFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_color_list_frame_min(s : GraphcolorlistFrame) -> Double { @_common.min(s.data) }

pub fn graph_color_list_frame_max(s : GraphcolorlistFrame) -> Double { @_common.max(s.data) }

pub fn graph_color_list_frame_to_string(s : GraphcolorlistFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphcolorlistTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_color_list_table_make(size : Int) -> GraphcolorlistTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_color_list_table_len(s : GraphcolorlistTable) -> Int { s.size }

pub fn graph_color_list_table_get(s : GraphcolorlistTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_color_list_table_set(s : GraphcolorlistTable, i : Int, v : Double) -> GraphcolorlistTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_color_list_table_sum(s : GraphcolorlistTable) -> Double { @_common.sum(s.data) }

pub fn graph_color_list_table_mean(s : GraphcolorlistTable) -> Double { @_common.mean(s.data) }

pub fn graph_color_list_table_scale(s : GraphcolorlistTable, f : Double) -> GraphcolorlistTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_color_list_table_add(a : GraphcolorlistTable, b : GraphcolorlistTable) -> GraphcolorlistTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_color_list_table_copy(s : GraphcolorlistTable) -> GraphcolorlistTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_color_list_table_fill(s : GraphcolorlistTable, v : Double) -> GraphcolorlistTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_color_list_table_min(s : GraphcolorlistTable) -> Double { @_common.min(s.data) }

pub fn graph_color_list_table_max(s : GraphcolorlistTable) -> Double { @_common.max(s.data) }

pub fn graph_color_list_table_to_string(s : GraphcolorlistTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphcolorlistGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_color_list_graphn_make(size : Int) -> GraphcolorlistGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_color_list_graphn_len(s : GraphcolorlistGraphN) -> Int { s.size }

pub fn graph_color_list_graphn_get(s : GraphcolorlistGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_color_list_graphn_set(s : GraphcolorlistGraphN, i : Int, v : Double) -> GraphcolorlistGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_color_list_graphn_sum(s : GraphcolorlistGraphN) -> Double { @_common.sum(s.data) }

pub fn graph_color_list_graphn_mean(s : GraphcolorlistGraphN) -> Double { @_common.mean(s.data) }

pub fn graph_color_list_graphn_scale(s : GraphcolorlistGraphN, f : Double) -> GraphcolorlistGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_color_list_graphn_add(a : GraphcolorlistGraphN, b : GraphcolorlistGraphN) -> GraphcolorlistGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_color_list_graphn_copy(s : GraphcolorlistGraphN) -> GraphcolorlistGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_color_list_graphn_fill(s : GraphcolorlistGraphN, v : Double) -> GraphcolorlistGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_color_list_graphn_min(s : GraphcolorlistGraphN) -> Double { @_common.min(s.data) }

pub fn graph_color_list_graphn_max(s : GraphcolorlistGraphN) -> Double { @_common.max(s.data) }

pub fn graph_color_list_graphn_to_string(s : GraphcolorlistGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphcolorlistNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_color_list_node_make(size : Int) -> GraphcolorlistNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_color_list_node_len(s : GraphcolorlistNode) -> Int { s.size }

pub fn graph_color_list_node_get(s : GraphcolorlistNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_color_list_node_set(s : GraphcolorlistNode, i : Int, v : Double) -> GraphcolorlistNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_color_list_node_sum(s : GraphcolorlistNode) -> Double { @_common.sum(s.data) }

pub fn graph_color_list_node_mean(s : GraphcolorlistNode) -> Double { @_common.mean(s.data) }

pub fn graph_color_list_node_scale(s : GraphcolorlistNode, f : Double) -> GraphcolorlistNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_color_list_node_add(a : GraphcolorlistNode, b : GraphcolorlistNode) -> GraphcolorlistNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_color_list_node_copy(s : GraphcolorlistNode) -> GraphcolorlistNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_color_list_node_fill(s : GraphcolorlistNode, v : Double) -> GraphcolorlistNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_color_list_node_min(s : GraphcolorlistNode) -> Double { @_common.min(s.data) }

pub fn graph_color_list_node_max(s : GraphcolorlistNode) -> Double { @_common.max(s.data) }

pub fn graph_color_list_node_to_string(s : GraphcolorlistNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphcolorlistEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_color_list_edge_make(size : Int) -> GraphcolorlistEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_color_list_edge_len(s : GraphcolorlistEdge) -> Int { s.size }

pub fn graph_color_list_edge_get(s : GraphcolorlistEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_color_list_edge_set(s : GraphcolorlistEdge, i : Int, v : Double) -> GraphcolorlistEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_color_list_edge_sum(s : GraphcolorlistEdge) -> Double { @_common.sum(s.data) }

pub fn graph_color_list_edge_mean(s : GraphcolorlistEdge) -> Double { @_common.mean(s.data) }

pub fn graph_color_list_edge_scale(s : GraphcolorlistEdge, f : Double) -> GraphcolorlistEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_color_list_edge_add(a : GraphcolorlistEdge, b : GraphcolorlistEdge) -> GraphcolorlistEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_color_list_edge_copy(s : GraphcolorlistEdge) -> GraphcolorlistEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_color_list_edge_fill(s : GraphcolorlistEdge, v : Double) -> GraphcolorlistEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_color_list_edge_min(s : GraphcolorlistEdge) -> Double { @_common.min(s.data) }

pub fn graph_color_list_edge_max(s : GraphcolorlistEdge) -> Double { @_common.max(s.data) }

pub fn graph_color_list_edge_to_string(s : GraphcolorlistEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphcolorlistPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_color_list_path_make(size : Int) -> GraphcolorlistPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_color_list_path_len(s : GraphcolorlistPath) -> Int { s.size }

pub fn graph_color_list_path_get(s : GraphcolorlistPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_color_list_path_set(s : GraphcolorlistPath, i : Int, v : Double) -> GraphcolorlistPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_color_list_path_sum(s : GraphcolorlistPath) -> Double { @_common.sum(s.data) }

pub fn graph_color_list_path_mean(s : GraphcolorlistPath) -> Double { @_common.mean(s.data) }

pub fn graph_color_list_path_scale(s : GraphcolorlistPath, f : Double) -> GraphcolorlistPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_color_list_path_add(a : GraphcolorlistPath, b : GraphcolorlistPath) -> GraphcolorlistPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_color_list_path_copy(s : GraphcolorlistPath) -> GraphcolorlistPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_color_list_path_fill(s : GraphcolorlistPath, v : Double) -> GraphcolorlistPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_color_list_path_min(s : GraphcolorlistPath) -> Double { @_common.min(s.data) }

pub fn graph_color_list_path_max(s : GraphcolorlistPath) -> Double { @_common.max(s.data) }

pub fn graph_color_list_path_to_string(s : GraphcolorlistPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphcolorlistCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_color_list_cluster_make(size : Int) -> GraphcolorlistCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_color_list_cluster_len(s : GraphcolorlistCluster) -> Int { s.size }

pub fn graph_color_list_cluster_get(s : GraphcolorlistCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_color_list_cluster_set(s : GraphcolorlistCluster, i : Int, v : Double) -> GraphcolorlistCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_color_list_cluster_sum(s : GraphcolorlistCluster) -> Double { @_common.sum(s.data) }

pub fn graph_color_list_cluster_mean(s : GraphcolorlistCluster) -> Double { @_common.mean(s.data) }

pub fn graph_color_list_cluster_scale(s : GraphcolorlistCluster, f : Double) -> GraphcolorlistCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_color_list_cluster_add(a : GraphcolorlistCluster, b : GraphcolorlistCluster) -> GraphcolorlistCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_color_list_cluster_copy(s : GraphcolorlistCluster) -> GraphcolorlistCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_color_list_cluster_fill(s : GraphcolorlistCluster, v : Double) -> GraphcolorlistCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_color_list_cluster_min(s : GraphcolorlistCluster) -> Double { @_common.min(s.data) }

pub fn graph_color_list_cluster_max(s : GraphcolorlistCluster) -> Double { @_common.max(s.data) }

pub fn graph_color_list_cluster_to_string(s : GraphcolorlistCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphcolorlistModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_color_list_model_make(size : Int) -> GraphcolorlistModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_color_list_model_len(s : GraphcolorlistModel) -> Int { s.size }

pub fn graph_color_list_model_get(s : GraphcolorlistModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_color_list_model_set(s : GraphcolorlistModel, i : Int, v : Double) -> GraphcolorlistModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_color_list_model_sum(s : GraphcolorlistModel) -> Double { @_common.sum(s.data) }

pub fn graph_color_list_model_mean(s : GraphcolorlistModel) -> Double { @_common.mean(s.data) }

pub fn graph_color_list_model_scale(s : GraphcolorlistModel, f : Double) -> GraphcolorlistModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_color_list_model_add(a : GraphcolorlistModel, b : GraphcolorlistModel) -> GraphcolorlistModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_color_list_model_copy(s : GraphcolorlistModel) -> GraphcolorlistModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_color_list_model_fill(s : GraphcolorlistModel, v : Double) -> GraphcolorlistModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_color_list_model_min(s : GraphcolorlistModel) -> Double { @_common.min(s.data) }

pub fn graph_color_list_model_max(s : GraphcolorlistModel) -> Double { @_common.max(s.data) }

pub fn graph_color_list_model_to_string(s : GraphcolorlistModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphcolorlistLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_color_list_layer_make(size : Int) -> GraphcolorlistLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_color_list_layer_len(s : GraphcolorlistLayer) -> Int { s.size }

pub fn graph_color_list_layer_get(s : GraphcolorlistLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_color_list_layer_set(s : GraphcolorlistLayer, i : Int, v : Double) -> GraphcolorlistLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_color_list_layer_sum(s : GraphcolorlistLayer) -> Double { @_common.sum(s.data) }

pub fn graph_color_list_layer_mean(s : GraphcolorlistLayer) -> Double { @_common.mean(s.data) }

pub fn graph_color_list_layer_scale(s : GraphcolorlistLayer, f : Double) -> GraphcolorlistLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_color_list_layer_add(a : GraphcolorlistLayer, b : GraphcolorlistLayer) -> GraphcolorlistLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_color_list_layer_copy(s : GraphcolorlistLayer) -> GraphcolorlistLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_color_list_layer_fill(s : GraphcolorlistLayer, v : Double) -> GraphcolorlistLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_color_list_layer_min(s : GraphcolorlistLayer) -> Double { @_common.min(s.data) }

pub fn graph_color_list_layer_max(s : GraphcolorlistLayer) -> Double { @_common.max(s.data) }

pub fn graph_color_list_layer_to_string(s : GraphcolorlistLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphcolorlistBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_color_list_buffer_make(size : Int) -> GraphcolorlistBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_color_list_buffer_len(s : GraphcolorlistBuffer) -> Int { s.size }

pub fn graph_color_list_buffer_get(s : GraphcolorlistBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_color_list_buffer_set(s : GraphcolorlistBuffer, i : Int, v : Double) -> GraphcolorlistBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_color_list_buffer_sum(s : GraphcolorlistBuffer) -> Double { @_common.sum(s.data) }

pub fn graph_color_list_buffer_mean(s : GraphcolorlistBuffer) -> Double { @_common.mean(s.data) }

pub fn graph_color_list_buffer_scale(s : GraphcolorlistBuffer, f : Double) -> GraphcolorlistBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_color_list_buffer_add(a : GraphcolorlistBuffer, b : GraphcolorlistBuffer) -> GraphcolorlistBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_color_list_buffer_copy(s : GraphcolorlistBuffer) -> GraphcolorlistBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_color_list_buffer_fill(s : GraphcolorlistBuffer, v : Double) -> GraphcolorlistBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_color_list_buffer_min(s : GraphcolorlistBuffer) -> Double { @_common.min(s.data) }

pub fn graph_color_list_buffer_max(s : GraphcolorlistBuffer) -> Double { @_common.max(s.data) }

pub fn graph_color_list_buffer_to_string(s : GraphcolorlistBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphcolorlistCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_color_list_cursor_make(size : Int) -> GraphcolorlistCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_color_list_cursor_len(s : GraphcolorlistCursor) -> Int { s.size }

pub fn graph_color_list_cursor_get(s : GraphcolorlistCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_color_list_cursor_set(s : GraphcolorlistCursor, i : Int, v : Double) -> GraphcolorlistCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_color_list_cursor_sum(s : GraphcolorlistCursor) -> Double { @_common.sum(s.data) }

pub fn graph_color_list_cursor_mean(s : GraphcolorlistCursor) -> Double { @_common.mean(s.data) }

pub fn graph_color_list_cursor_scale(s : GraphcolorlistCursor, f : Double) -> GraphcolorlistCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_color_list_cursor_add(a : GraphcolorlistCursor, b : GraphcolorlistCursor) -> GraphcolorlistCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_color_list_cursor_copy(s : GraphcolorlistCursor) -> GraphcolorlistCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_color_list_cursor_fill(s : GraphcolorlistCursor, v : Double) -> GraphcolorlistCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_color_list_cursor_min(s : GraphcolorlistCursor) -> Double { @_common.min(s.data) }

pub fn graph_color_list_cursor_max(s : GraphcolorlistCursor) -> Double { @_common.max(s.data) }

pub fn graph_color_list_cursor_to_string(s : GraphcolorlistCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphcolorlistView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_color_list_view_make(size : Int) -> GraphcolorlistView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_color_list_view_len(s : GraphcolorlistView) -> Int { s.size }

pub fn graph_color_list_view_get(s : GraphcolorlistView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_color_list_view_set(s : GraphcolorlistView, i : Int, v : Double) -> GraphcolorlistView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_color_list_view_sum(s : GraphcolorlistView) -> Double { @_common.sum(s.data) }

pub fn graph_color_list_view_mean(s : GraphcolorlistView) -> Double { @_common.mean(s.data) }

pub fn graph_color_list_view_scale(s : GraphcolorlistView, f : Double) -> GraphcolorlistView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_color_list_view_add(a : GraphcolorlistView, b : GraphcolorlistView) -> GraphcolorlistView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_color_list_view_copy(s : GraphcolorlistView) -> GraphcolorlistView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_color_list_view_fill(s : GraphcolorlistView, v : Double) -> GraphcolorlistView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_color_list_view_min(s : GraphcolorlistView) -> Double { @_common.min(s.data) }

pub fn graph_color_list_view_max(s : GraphcolorlistView) -> Double { @_common.max(s.data) }

pub fn graph_color_list_view_to_string(s : GraphcolorlistView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphcolorlistRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_color_list_range_make(size : Int) -> GraphcolorlistRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_color_list_range_len(s : GraphcolorlistRange) -> Int { s.size }

pub fn graph_color_list_range_get(s : GraphcolorlistRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_color_list_range_set(s : GraphcolorlistRange, i : Int, v : Double) -> GraphcolorlistRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_color_list_range_sum(s : GraphcolorlistRange) -> Double { @_common.sum(s.data) }

pub fn graph_color_list_range_mean(s : GraphcolorlistRange) -> Double { @_common.mean(s.data) }

pub fn graph_color_list_range_scale(s : GraphcolorlistRange, f : Double) -> GraphcolorlistRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_color_list_range_add(a : GraphcolorlistRange, b : GraphcolorlistRange) -> GraphcolorlistRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_color_list_range_copy(s : GraphcolorlistRange) -> GraphcolorlistRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_color_list_range_fill(s : GraphcolorlistRange, v : Double) -> GraphcolorlistRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_color_list_range_min(s : GraphcolorlistRange) -> Double { @_common.min(s.data) }

pub fn graph_color_list_range_max(s : GraphcolorlistRange) -> Double { @_common.max(s.data) }

pub fn graph_color_list_range_to_string(s : GraphcolorlistRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphcolorlistSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_color_list_slice_make(size : Int) -> GraphcolorlistSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_color_list_slice_len(s : GraphcolorlistSlice) -> Int { s.size }

pub fn graph_color_list_slice_get(s : GraphcolorlistSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_color_list_slice_set(s : GraphcolorlistSlice, i : Int, v : Double) -> GraphcolorlistSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_color_list_slice_sum(s : GraphcolorlistSlice) -> Double { @_common.sum(s.data) }

pub fn graph_color_list_slice_mean(s : GraphcolorlistSlice) -> Double { @_common.mean(s.data) }

pub fn graph_color_list_slice_scale(s : GraphcolorlistSlice, f : Double) -> GraphcolorlistSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_color_list_slice_add(a : GraphcolorlistSlice, b : GraphcolorlistSlice) -> GraphcolorlistSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_color_list_slice_copy(s : GraphcolorlistSlice) -> GraphcolorlistSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_color_list_slice_fill(s : GraphcolorlistSlice, v : Double) -> GraphcolorlistSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_color_list_slice_min(s : GraphcolorlistSlice) -> Double { @_common.min(s.data) }

pub fn graph_color_list_slice_max(s : GraphcolorlistSlice) -> Double { @_common.max(s.data) }

pub fn graph_color_list_slice_to_string(s : GraphcolorlistSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

