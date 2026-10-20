///===
/// extcore/graph_color_dsatur

pub(all) struct GraphcolordsaturPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn graph_color_dsatur_make_point(x : Double, y : Double) -> GraphcolordsaturPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn graph_color_dsatur_make_point3(x : Double, y : Double, z : Double) -> GraphcolordsaturPoint {
  { x, y, z, label: 0 }
}

pub fn GraphcolordsaturPoint::x(self : GraphcolordsaturPoint) -> Double { self.x }

pub fn GraphcolordsaturPoint::y(self : GraphcolordsaturPoint) -> Double { self.y }

pub fn GraphcolordsaturPoint::z(self : GraphcolordsaturPoint) -> Double { self.z }

pub fn GraphcolordsaturPoint::label(self : GraphcolordsaturPoint) -> Int { self.label }

pub fn GraphcolordsaturPoint::dist(self : GraphcolordsaturPoint, other : GraphcolordsaturPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn GraphcolordsaturPoint::add(self : GraphcolordsaturPoint, other : GraphcolordsaturPoint) -> GraphcolordsaturPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn GraphcolordsaturPoint::sub(self : GraphcolordsaturPoint, other : GraphcolordsaturPoint) -> GraphcolordsaturPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn GraphcolordsaturPoint::scale(self : GraphcolordsaturPoint, s : Double) -> GraphcolordsaturPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn GraphcolordsaturPoint::dot(self : GraphcolordsaturPoint, other : GraphcolordsaturPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn GraphcolordsaturPoint::cross(self : GraphcolordsaturPoint, other : GraphcolordsaturPoint) -> GraphcolordsaturPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn GraphcolordsaturPoint::norm(self : GraphcolordsaturPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn GraphcolordsaturPoint::normalize(self : GraphcolordsaturPoint) -> GraphcolordsaturPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn GraphcolordsaturPoint::negate(self : GraphcolordsaturPoint) -> GraphcolordsaturPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn GraphcolordsaturPoint::mid(self : GraphcolordsaturPoint, other : GraphcolordsaturPoint) -> GraphcolordsaturPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn GraphcolordsaturPoint::lerp(self : GraphcolordsaturPoint, other : GraphcolordsaturPoint, t : Double) -> GraphcolordsaturPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn GraphcolordsaturPoint::to_string(self : GraphcolordsaturPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct GraphcolordsaturSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn graph_color_dsatur_make_series(vals : Array[Double], name : String) -> GraphcolordsaturSeries {
  { vals, name, meta: 0 }
}

pub fn GraphcolordsaturSeries::len(self : GraphcolordsaturSeries) -> Int { self.vals.length() }

pub fn GraphcolordsaturSeries::sum(self : GraphcolordsaturSeries) -> Double { @_common.sum(self.vals) }

pub fn GraphcolordsaturSeries::mean(self : GraphcolordsaturSeries) -> Double { @_common.mean(self.vals) }

pub fn GraphcolordsaturSeries::min(self : GraphcolordsaturSeries) -> Double { @_common.min(self.vals) }

pub fn GraphcolordsaturSeries::max(self : GraphcolordsaturSeries) -> Double { @_common.max(self.vals) }

pub fn GraphcolordsaturSeries::range(self : GraphcolordsaturSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn GraphcolordsaturSeries::variance(self : GraphcolordsaturSeries) -> Double { @_common.variance(self.vals) }

pub fn GraphcolordsaturSeries::std(self : GraphcolordsaturSeries) -> Double { @_common.std(self.vals) }

pub fn GraphcolordsaturSeries::median(self : GraphcolordsaturSeries) -> Double { @_common.median(self.vals) }

pub fn GraphcolordsaturSeries::scale(self : GraphcolordsaturSeries, f : Double) -> GraphcolordsaturSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn GraphcolordsaturSeries::add(self : GraphcolordsaturSeries, other : GraphcolordsaturSeries) -> GraphcolordsaturSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn GraphcolordsaturSeries::sub(self : GraphcolordsaturSeries, other : GraphcolordsaturSeries) -> GraphcolordsaturSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn GraphcolordsaturSeries::normalize(self : GraphcolordsaturSeries) -> GraphcolordsaturSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn GraphcolordsaturSeries::cumsum(self : GraphcolordsaturSeries) -> GraphcolordsaturSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn GraphcolordsaturSeries::to_string(self : GraphcolordsaturSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct GraphcolordsaturMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn graph_color_dsatur_make_matrix(rows : Int, cols : Int, val : Double) -> GraphcolordsaturMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn graph_color_dsatur_matrix_identity(n : Int) -> GraphcolordsaturMatrix {
  let m = graph_color_dsatur_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn GraphcolordsaturMatrix::get(self : GraphcolordsaturMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn GraphcolordsaturMatrix::transpose(self : GraphcolordsaturMatrix) -> GraphcolordsaturMatrix {
  let result = graph_color_dsatur_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn GraphcolordsaturMatrix::add(self : GraphcolordsaturMatrix, other : GraphcolordsaturMatrix) -> GraphcolordsaturMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = graph_color_dsatur_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn GraphcolordsaturMatrix::scale(self : GraphcolordsaturMatrix, s : Double) -> GraphcolordsaturMatrix {
  let result = graph_color_dsatur_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn GraphcolordsaturMatrix::multiply(self : GraphcolordsaturMatrix, other : GraphcolordsaturMatrix) -> GraphcolordsaturMatrix {
  if self.cols != other.rows { return graph_color_dsatur_make_matrix(self.rows, other.cols, 0.0) }
  let result = graph_color_dsatur_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn GraphcolordsaturMatrix::trace(self : GraphcolordsaturMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn GraphcolordsaturMatrix::det(self : GraphcolordsaturMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn GraphcolordsaturMatrix::norm(self : GraphcolordsaturMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn GraphcolordsaturMatrix::to_string(self : GraphcolordsaturMatrix) -> String {
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

pub(all) struct GraphcolordsaturVector {
  comps : Array[Double]
  dim : Int
}

pub fn graph_color_dsatur_make_vector(comps : Array[Double]) -> GraphcolordsaturVector {
  { comps, dim: comps.length() }
}

pub fn graph_color_dsatur_vector_zero(dim : Int) -> GraphcolordsaturVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn GraphcolordsaturVector::add(self : GraphcolordsaturVector, other : GraphcolordsaturVector) -> GraphcolordsaturVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn GraphcolordsaturVector::sub(self : GraphcolordsaturVector, other : GraphcolordsaturVector) -> GraphcolordsaturVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn GraphcolordsaturVector::scale(self : GraphcolordsaturVector, s : Double) -> GraphcolordsaturVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn GraphcolordsaturVector::dot(self : GraphcolordsaturVector, other : GraphcolordsaturVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn GraphcolordsaturVector::norm(self : GraphcolordsaturVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn GraphcolordsaturVector::normalize(self : GraphcolordsaturVector) -> GraphcolordsaturVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn GraphcolordsaturVector::dist(self : GraphcolordsaturVector, other : GraphcolordsaturVector) -> Double {
  self.sub(other).norm()
}

pub fn GraphcolordsaturVector::to_string(self : GraphcolordsaturVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn graph_color_dsatur_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn graph_color_dsatur_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn graph_color_dsatur_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn graph_color_dsatur_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn graph_color_dsatur_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn graph_color_dsatur_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn graph_color_dsatur_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn graph_color_dsatur_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn graph_color_dsatur_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn graph_color_dsatur_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn graph_color_dsatur_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn graph_color_dsatur_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn graph_color_dsatur_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn graph_color_dsatur_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn graph_color_dsatur_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn graph_color_dsatur_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn graph_color_dsatur_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn graph_color_dsatur_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn graph_color_dsatur_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn graph_color_dsatur_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn graph_color_dsatur_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn graph_color_dsatur_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn graph_color_dsatur_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn graph_color_dsatur_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn graph_color_dsatur_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn graph_color_dsatur_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn graph_color_dsatur_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn graph_color_dsatur_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn graph_color_dsatur_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct GraphcolordsaturFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_color_dsatur_frame_make(size : Int) -> GraphcolordsaturFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_color_dsatur_frame_len(s : GraphcolordsaturFrame) -> Int { s.size }

pub fn graph_color_dsatur_frame_get(s : GraphcolordsaturFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_color_dsatur_frame_set(s : GraphcolordsaturFrame, i : Int, v : Double) -> GraphcolordsaturFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_color_dsatur_frame_sum(s : GraphcolordsaturFrame) -> Double { @_common.sum(s.data) }

pub fn graph_color_dsatur_frame_mean(s : GraphcolordsaturFrame) -> Double { @_common.mean(s.data) }

pub fn graph_color_dsatur_frame_scale(s : GraphcolordsaturFrame, f : Double) -> GraphcolordsaturFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_color_dsatur_frame_add(a : GraphcolordsaturFrame, b : GraphcolordsaturFrame) -> GraphcolordsaturFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_color_dsatur_frame_copy(s : GraphcolordsaturFrame) -> GraphcolordsaturFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_color_dsatur_frame_fill(s : GraphcolordsaturFrame, v : Double) -> GraphcolordsaturFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_color_dsatur_frame_min(s : GraphcolordsaturFrame) -> Double { @_common.min(s.data) }

pub fn graph_color_dsatur_frame_max(s : GraphcolordsaturFrame) -> Double { @_common.max(s.data) }

pub fn graph_color_dsatur_frame_to_string(s : GraphcolordsaturFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphcolordsaturTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_color_dsatur_table_make(size : Int) -> GraphcolordsaturTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_color_dsatur_table_len(s : GraphcolordsaturTable) -> Int { s.size }

pub fn graph_color_dsatur_table_get(s : GraphcolordsaturTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_color_dsatur_table_set(s : GraphcolordsaturTable, i : Int, v : Double) -> GraphcolordsaturTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_color_dsatur_table_sum(s : GraphcolordsaturTable) -> Double { @_common.sum(s.data) }

pub fn graph_color_dsatur_table_mean(s : GraphcolordsaturTable) -> Double { @_common.mean(s.data) }

pub fn graph_color_dsatur_table_scale(s : GraphcolordsaturTable, f : Double) -> GraphcolordsaturTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_color_dsatur_table_add(a : GraphcolordsaturTable, b : GraphcolordsaturTable) -> GraphcolordsaturTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_color_dsatur_table_copy(s : GraphcolordsaturTable) -> GraphcolordsaturTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_color_dsatur_table_fill(s : GraphcolordsaturTable, v : Double) -> GraphcolordsaturTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_color_dsatur_table_min(s : GraphcolordsaturTable) -> Double { @_common.min(s.data) }

pub fn graph_color_dsatur_table_max(s : GraphcolordsaturTable) -> Double { @_common.max(s.data) }

pub fn graph_color_dsatur_table_to_string(s : GraphcolordsaturTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphcolordsaturGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_color_dsatur_graphn_make(size : Int) -> GraphcolordsaturGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_color_dsatur_graphn_len(s : GraphcolordsaturGraphN) -> Int { s.size }

pub fn graph_color_dsatur_graphn_get(s : GraphcolordsaturGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_color_dsatur_graphn_set(s : GraphcolordsaturGraphN, i : Int, v : Double) -> GraphcolordsaturGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_color_dsatur_graphn_sum(s : GraphcolordsaturGraphN) -> Double { @_common.sum(s.data) }

pub fn graph_color_dsatur_graphn_mean(s : GraphcolordsaturGraphN) -> Double { @_common.mean(s.data) }

pub fn graph_color_dsatur_graphn_scale(s : GraphcolordsaturGraphN, f : Double) -> GraphcolordsaturGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_color_dsatur_graphn_add(a : GraphcolordsaturGraphN, b : GraphcolordsaturGraphN) -> GraphcolordsaturGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_color_dsatur_graphn_copy(s : GraphcolordsaturGraphN) -> GraphcolordsaturGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_color_dsatur_graphn_fill(s : GraphcolordsaturGraphN, v : Double) -> GraphcolordsaturGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_color_dsatur_graphn_min(s : GraphcolordsaturGraphN) -> Double { @_common.min(s.data) }

pub fn graph_color_dsatur_graphn_max(s : GraphcolordsaturGraphN) -> Double { @_common.max(s.data) }

pub fn graph_color_dsatur_graphn_to_string(s : GraphcolordsaturGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphcolordsaturNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_color_dsatur_node_make(size : Int) -> GraphcolordsaturNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_color_dsatur_node_len(s : GraphcolordsaturNode) -> Int { s.size }

pub fn graph_color_dsatur_node_get(s : GraphcolordsaturNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_color_dsatur_node_set(s : GraphcolordsaturNode, i : Int, v : Double) -> GraphcolordsaturNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_color_dsatur_node_sum(s : GraphcolordsaturNode) -> Double { @_common.sum(s.data) }

pub fn graph_color_dsatur_node_mean(s : GraphcolordsaturNode) -> Double { @_common.mean(s.data) }

pub fn graph_color_dsatur_node_scale(s : GraphcolordsaturNode, f : Double) -> GraphcolordsaturNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_color_dsatur_node_add(a : GraphcolordsaturNode, b : GraphcolordsaturNode) -> GraphcolordsaturNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_color_dsatur_node_copy(s : GraphcolordsaturNode) -> GraphcolordsaturNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_color_dsatur_node_fill(s : GraphcolordsaturNode, v : Double) -> GraphcolordsaturNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_color_dsatur_node_min(s : GraphcolordsaturNode) -> Double { @_common.min(s.data) }

pub fn graph_color_dsatur_node_max(s : GraphcolordsaturNode) -> Double { @_common.max(s.data) }

pub fn graph_color_dsatur_node_to_string(s : GraphcolordsaturNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphcolordsaturEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_color_dsatur_edge_make(size : Int) -> GraphcolordsaturEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_color_dsatur_edge_len(s : GraphcolordsaturEdge) -> Int { s.size }

pub fn graph_color_dsatur_edge_get(s : GraphcolordsaturEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_color_dsatur_edge_set(s : GraphcolordsaturEdge, i : Int, v : Double) -> GraphcolordsaturEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_color_dsatur_edge_sum(s : GraphcolordsaturEdge) -> Double { @_common.sum(s.data) }

pub fn graph_color_dsatur_edge_mean(s : GraphcolordsaturEdge) -> Double { @_common.mean(s.data) }

pub fn graph_color_dsatur_edge_scale(s : GraphcolordsaturEdge, f : Double) -> GraphcolordsaturEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_color_dsatur_edge_add(a : GraphcolordsaturEdge, b : GraphcolordsaturEdge) -> GraphcolordsaturEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_color_dsatur_edge_copy(s : GraphcolordsaturEdge) -> GraphcolordsaturEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_color_dsatur_edge_fill(s : GraphcolordsaturEdge, v : Double) -> GraphcolordsaturEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_color_dsatur_edge_min(s : GraphcolordsaturEdge) -> Double { @_common.min(s.data) }

pub fn graph_color_dsatur_edge_max(s : GraphcolordsaturEdge) -> Double { @_common.max(s.data) }

pub fn graph_color_dsatur_edge_to_string(s : GraphcolordsaturEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphcolordsaturPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_color_dsatur_path_make(size : Int) -> GraphcolordsaturPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_color_dsatur_path_len(s : GraphcolordsaturPath) -> Int { s.size }

pub fn graph_color_dsatur_path_get(s : GraphcolordsaturPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_color_dsatur_path_set(s : GraphcolordsaturPath, i : Int, v : Double) -> GraphcolordsaturPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_color_dsatur_path_sum(s : GraphcolordsaturPath) -> Double { @_common.sum(s.data) }

pub fn graph_color_dsatur_path_mean(s : GraphcolordsaturPath) -> Double { @_common.mean(s.data) }

pub fn graph_color_dsatur_path_scale(s : GraphcolordsaturPath, f : Double) -> GraphcolordsaturPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_color_dsatur_path_add(a : GraphcolordsaturPath, b : GraphcolordsaturPath) -> GraphcolordsaturPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_color_dsatur_path_copy(s : GraphcolordsaturPath) -> GraphcolordsaturPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_color_dsatur_path_fill(s : GraphcolordsaturPath, v : Double) -> GraphcolordsaturPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_color_dsatur_path_min(s : GraphcolordsaturPath) -> Double { @_common.min(s.data) }

pub fn graph_color_dsatur_path_max(s : GraphcolordsaturPath) -> Double { @_common.max(s.data) }

pub fn graph_color_dsatur_path_to_string(s : GraphcolordsaturPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphcolordsaturCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_color_dsatur_cluster_make(size : Int) -> GraphcolordsaturCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_color_dsatur_cluster_len(s : GraphcolordsaturCluster) -> Int { s.size }

pub fn graph_color_dsatur_cluster_get(s : GraphcolordsaturCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_color_dsatur_cluster_set(s : GraphcolordsaturCluster, i : Int, v : Double) -> GraphcolordsaturCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_color_dsatur_cluster_sum(s : GraphcolordsaturCluster) -> Double { @_common.sum(s.data) }

pub fn graph_color_dsatur_cluster_mean(s : GraphcolordsaturCluster) -> Double { @_common.mean(s.data) }

pub fn graph_color_dsatur_cluster_scale(s : GraphcolordsaturCluster, f : Double) -> GraphcolordsaturCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_color_dsatur_cluster_add(a : GraphcolordsaturCluster, b : GraphcolordsaturCluster) -> GraphcolordsaturCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_color_dsatur_cluster_copy(s : GraphcolordsaturCluster) -> GraphcolordsaturCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_color_dsatur_cluster_fill(s : GraphcolordsaturCluster, v : Double) -> GraphcolordsaturCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_color_dsatur_cluster_min(s : GraphcolordsaturCluster) -> Double { @_common.min(s.data) }

pub fn graph_color_dsatur_cluster_max(s : GraphcolordsaturCluster) -> Double { @_common.max(s.data) }

pub fn graph_color_dsatur_cluster_to_string(s : GraphcolordsaturCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphcolordsaturModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_color_dsatur_model_make(size : Int) -> GraphcolordsaturModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_color_dsatur_model_len(s : GraphcolordsaturModel) -> Int { s.size }

pub fn graph_color_dsatur_model_get(s : GraphcolordsaturModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_color_dsatur_model_set(s : GraphcolordsaturModel, i : Int, v : Double) -> GraphcolordsaturModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_color_dsatur_model_sum(s : GraphcolordsaturModel) -> Double { @_common.sum(s.data) }

pub fn graph_color_dsatur_model_mean(s : GraphcolordsaturModel) -> Double { @_common.mean(s.data) }

pub fn graph_color_dsatur_model_scale(s : GraphcolordsaturModel, f : Double) -> GraphcolordsaturModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_color_dsatur_model_add(a : GraphcolordsaturModel, b : GraphcolordsaturModel) -> GraphcolordsaturModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_color_dsatur_model_copy(s : GraphcolordsaturModel) -> GraphcolordsaturModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_color_dsatur_model_fill(s : GraphcolordsaturModel, v : Double) -> GraphcolordsaturModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_color_dsatur_model_min(s : GraphcolordsaturModel) -> Double { @_common.min(s.data) }

pub fn graph_color_dsatur_model_max(s : GraphcolordsaturModel) -> Double { @_common.max(s.data) }

pub fn graph_color_dsatur_model_to_string(s : GraphcolordsaturModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphcolordsaturLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_color_dsatur_layer_make(size : Int) -> GraphcolordsaturLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_color_dsatur_layer_len(s : GraphcolordsaturLayer) -> Int { s.size }

pub fn graph_color_dsatur_layer_get(s : GraphcolordsaturLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_color_dsatur_layer_set(s : GraphcolordsaturLayer, i : Int, v : Double) -> GraphcolordsaturLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_color_dsatur_layer_sum(s : GraphcolordsaturLayer) -> Double { @_common.sum(s.data) }

pub fn graph_color_dsatur_layer_mean(s : GraphcolordsaturLayer) -> Double { @_common.mean(s.data) }

pub fn graph_color_dsatur_layer_scale(s : GraphcolordsaturLayer, f : Double) -> GraphcolordsaturLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_color_dsatur_layer_add(a : GraphcolordsaturLayer, b : GraphcolordsaturLayer) -> GraphcolordsaturLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_color_dsatur_layer_copy(s : GraphcolordsaturLayer) -> GraphcolordsaturLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_color_dsatur_layer_fill(s : GraphcolordsaturLayer, v : Double) -> GraphcolordsaturLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_color_dsatur_layer_min(s : GraphcolordsaturLayer) -> Double { @_common.min(s.data) }

pub fn graph_color_dsatur_layer_max(s : GraphcolordsaturLayer) -> Double { @_common.max(s.data) }

pub fn graph_color_dsatur_layer_to_string(s : GraphcolordsaturLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphcolordsaturBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_color_dsatur_buffer_make(size : Int) -> GraphcolordsaturBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_color_dsatur_buffer_len(s : GraphcolordsaturBuffer) -> Int { s.size }

pub fn graph_color_dsatur_buffer_get(s : GraphcolordsaturBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_color_dsatur_buffer_set(s : GraphcolordsaturBuffer, i : Int, v : Double) -> GraphcolordsaturBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_color_dsatur_buffer_sum(s : GraphcolordsaturBuffer) -> Double { @_common.sum(s.data) }

pub fn graph_color_dsatur_buffer_mean(s : GraphcolordsaturBuffer) -> Double { @_common.mean(s.data) }

pub fn graph_color_dsatur_buffer_scale(s : GraphcolordsaturBuffer, f : Double) -> GraphcolordsaturBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_color_dsatur_buffer_add(a : GraphcolordsaturBuffer, b : GraphcolordsaturBuffer) -> GraphcolordsaturBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_color_dsatur_buffer_copy(s : GraphcolordsaturBuffer) -> GraphcolordsaturBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_color_dsatur_buffer_fill(s : GraphcolordsaturBuffer, v : Double) -> GraphcolordsaturBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_color_dsatur_buffer_min(s : GraphcolordsaturBuffer) -> Double { @_common.min(s.data) }

pub fn graph_color_dsatur_buffer_max(s : GraphcolordsaturBuffer) -> Double { @_common.max(s.data) }

pub fn graph_color_dsatur_buffer_to_string(s : GraphcolordsaturBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphcolordsaturCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_color_dsatur_cursor_make(size : Int) -> GraphcolordsaturCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_color_dsatur_cursor_len(s : GraphcolordsaturCursor) -> Int { s.size }

pub fn graph_color_dsatur_cursor_get(s : GraphcolordsaturCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_color_dsatur_cursor_set(s : GraphcolordsaturCursor, i : Int, v : Double) -> GraphcolordsaturCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_color_dsatur_cursor_sum(s : GraphcolordsaturCursor) -> Double { @_common.sum(s.data) }

pub fn graph_color_dsatur_cursor_mean(s : GraphcolordsaturCursor) -> Double { @_common.mean(s.data) }

pub fn graph_color_dsatur_cursor_scale(s : GraphcolordsaturCursor, f : Double) -> GraphcolordsaturCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_color_dsatur_cursor_add(a : GraphcolordsaturCursor, b : GraphcolordsaturCursor) -> GraphcolordsaturCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_color_dsatur_cursor_copy(s : GraphcolordsaturCursor) -> GraphcolordsaturCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_color_dsatur_cursor_fill(s : GraphcolordsaturCursor, v : Double) -> GraphcolordsaturCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_color_dsatur_cursor_min(s : GraphcolordsaturCursor) -> Double { @_common.min(s.data) }

pub fn graph_color_dsatur_cursor_max(s : GraphcolordsaturCursor) -> Double { @_common.max(s.data) }

pub fn graph_color_dsatur_cursor_to_string(s : GraphcolordsaturCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphcolordsaturView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_color_dsatur_view_make(size : Int) -> GraphcolordsaturView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_color_dsatur_view_len(s : GraphcolordsaturView) -> Int { s.size }

pub fn graph_color_dsatur_view_get(s : GraphcolordsaturView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_color_dsatur_view_set(s : GraphcolordsaturView, i : Int, v : Double) -> GraphcolordsaturView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_color_dsatur_view_sum(s : GraphcolordsaturView) -> Double { @_common.sum(s.data) }

pub fn graph_color_dsatur_view_mean(s : GraphcolordsaturView) -> Double { @_common.mean(s.data) }

pub fn graph_color_dsatur_view_scale(s : GraphcolordsaturView, f : Double) -> GraphcolordsaturView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_color_dsatur_view_add(a : GraphcolordsaturView, b : GraphcolordsaturView) -> GraphcolordsaturView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_color_dsatur_view_copy(s : GraphcolordsaturView) -> GraphcolordsaturView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_color_dsatur_view_fill(s : GraphcolordsaturView, v : Double) -> GraphcolordsaturView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_color_dsatur_view_min(s : GraphcolordsaturView) -> Double { @_common.min(s.data) }

pub fn graph_color_dsatur_view_max(s : GraphcolordsaturView) -> Double { @_common.max(s.data) }

pub fn graph_color_dsatur_view_to_string(s : GraphcolordsaturView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphcolordsaturRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_color_dsatur_range_make(size : Int) -> GraphcolordsaturRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_color_dsatur_range_len(s : GraphcolordsaturRange) -> Int { s.size }

pub fn graph_color_dsatur_range_get(s : GraphcolordsaturRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_color_dsatur_range_set(s : GraphcolordsaturRange, i : Int, v : Double) -> GraphcolordsaturRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_color_dsatur_range_sum(s : GraphcolordsaturRange) -> Double { @_common.sum(s.data) }

pub fn graph_color_dsatur_range_mean(s : GraphcolordsaturRange) -> Double { @_common.mean(s.data) }

pub fn graph_color_dsatur_range_scale(s : GraphcolordsaturRange, f : Double) -> GraphcolordsaturRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_color_dsatur_range_add(a : GraphcolordsaturRange, b : GraphcolordsaturRange) -> GraphcolordsaturRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_color_dsatur_range_copy(s : GraphcolordsaturRange) -> GraphcolordsaturRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_color_dsatur_range_fill(s : GraphcolordsaturRange, v : Double) -> GraphcolordsaturRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_color_dsatur_range_min(s : GraphcolordsaturRange) -> Double { @_common.min(s.data) }

pub fn graph_color_dsatur_range_max(s : GraphcolordsaturRange) -> Double { @_common.max(s.data) }

pub fn graph_color_dsatur_range_to_string(s : GraphcolordsaturRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphcolordsaturSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_color_dsatur_slice_make(size : Int) -> GraphcolordsaturSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_color_dsatur_slice_len(s : GraphcolordsaturSlice) -> Int { s.size }

pub fn graph_color_dsatur_slice_get(s : GraphcolordsaturSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_color_dsatur_slice_set(s : GraphcolordsaturSlice, i : Int, v : Double) -> GraphcolordsaturSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_color_dsatur_slice_sum(s : GraphcolordsaturSlice) -> Double { @_common.sum(s.data) }

pub fn graph_color_dsatur_slice_mean(s : GraphcolordsaturSlice) -> Double { @_common.mean(s.data) }

pub fn graph_color_dsatur_slice_scale(s : GraphcolordsaturSlice, f : Double) -> GraphcolordsaturSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_color_dsatur_slice_add(a : GraphcolordsaturSlice, b : GraphcolordsaturSlice) -> GraphcolordsaturSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_color_dsatur_slice_copy(s : GraphcolordsaturSlice) -> GraphcolordsaturSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_color_dsatur_slice_fill(s : GraphcolordsaturSlice, v : Double) -> GraphcolordsaturSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_color_dsatur_slice_min(s : GraphcolordsaturSlice) -> Double { @_common.min(s.data) }

pub fn graph_color_dsatur_slice_max(s : GraphcolordsaturSlice) -> Double { @_common.max(s.data) }

pub fn graph_color_dsatur_slice_to_string(s : GraphcolordsaturSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

