///===
/// extcore/graph_connect_components

pub(all) struct GraphconnectcomponentsPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn graph_connect_components_make_point(x : Double, y : Double) -> GraphconnectcomponentsPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn graph_connect_components_make_point3(x : Double, y : Double, z : Double) -> GraphconnectcomponentsPoint {
  { x, y, z, label: 0 }
}

pub fn GraphconnectcomponentsPoint::x(self : GraphconnectcomponentsPoint) -> Double { self.x }

pub fn GraphconnectcomponentsPoint::y(self : GraphconnectcomponentsPoint) -> Double { self.y }

pub fn GraphconnectcomponentsPoint::z(self : GraphconnectcomponentsPoint) -> Double { self.z }

pub fn GraphconnectcomponentsPoint::label(self : GraphconnectcomponentsPoint) -> Int { self.label }

pub fn GraphconnectcomponentsPoint::dist(self : GraphconnectcomponentsPoint, other : GraphconnectcomponentsPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn GraphconnectcomponentsPoint::add(self : GraphconnectcomponentsPoint, other : GraphconnectcomponentsPoint) -> GraphconnectcomponentsPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn GraphconnectcomponentsPoint::sub(self : GraphconnectcomponentsPoint, other : GraphconnectcomponentsPoint) -> GraphconnectcomponentsPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn GraphconnectcomponentsPoint::scale(self : GraphconnectcomponentsPoint, s : Double) -> GraphconnectcomponentsPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn GraphconnectcomponentsPoint::dot(self : GraphconnectcomponentsPoint, other : GraphconnectcomponentsPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn GraphconnectcomponentsPoint::cross(self : GraphconnectcomponentsPoint, other : GraphconnectcomponentsPoint) -> GraphconnectcomponentsPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn GraphconnectcomponentsPoint::norm(self : GraphconnectcomponentsPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn GraphconnectcomponentsPoint::normalize(self : GraphconnectcomponentsPoint) -> GraphconnectcomponentsPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn GraphconnectcomponentsPoint::negate(self : GraphconnectcomponentsPoint) -> GraphconnectcomponentsPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn GraphconnectcomponentsPoint::mid(self : GraphconnectcomponentsPoint, other : GraphconnectcomponentsPoint) -> GraphconnectcomponentsPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn GraphconnectcomponentsPoint::lerp(self : GraphconnectcomponentsPoint, other : GraphconnectcomponentsPoint, t : Double) -> GraphconnectcomponentsPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn GraphconnectcomponentsPoint::to_string(self : GraphconnectcomponentsPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct GraphconnectcomponentsSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn graph_connect_components_make_series(vals : Array[Double], name : String) -> GraphconnectcomponentsSeries {
  { vals, name, meta: 0 }
}

pub fn GraphconnectcomponentsSeries::len(self : GraphconnectcomponentsSeries) -> Int { self.vals.length() }

pub fn GraphconnectcomponentsSeries::sum(self : GraphconnectcomponentsSeries) -> Double { @_common.sum(self.vals) }

pub fn GraphconnectcomponentsSeries::mean(self : GraphconnectcomponentsSeries) -> Double { @_common.mean(self.vals) }

pub fn GraphconnectcomponentsSeries::min(self : GraphconnectcomponentsSeries) -> Double { @_common.min(self.vals) }

pub fn GraphconnectcomponentsSeries::max(self : GraphconnectcomponentsSeries) -> Double { @_common.max(self.vals) }

pub fn GraphconnectcomponentsSeries::range(self : GraphconnectcomponentsSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn GraphconnectcomponentsSeries::variance(self : GraphconnectcomponentsSeries) -> Double { @_common.variance(self.vals) }

pub fn GraphconnectcomponentsSeries::std(self : GraphconnectcomponentsSeries) -> Double { @_common.std(self.vals) }

pub fn GraphconnectcomponentsSeries::median(self : GraphconnectcomponentsSeries) -> Double { @_common.median(self.vals) }

pub fn GraphconnectcomponentsSeries::scale(self : GraphconnectcomponentsSeries, f : Double) -> GraphconnectcomponentsSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn GraphconnectcomponentsSeries::add(self : GraphconnectcomponentsSeries, other : GraphconnectcomponentsSeries) -> GraphconnectcomponentsSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn GraphconnectcomponentsSeries::sub(self : GraphconnectcomponentsSeries, other : GraphconnectcomponentsSeries) -> GraphconnectcomponentsSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn GraphconnectcomponentsSeries::normalize(self : GraphconnectcomponentsSeries) -> GraphconnectcomponentsSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn GraphconnectcomponentsSeries::cumsum(self : GraphconnectcomponentsSeries) -> GraphconnectcomponentsSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn GraphconnectcomponentsSeries::to_string(self : GraphconnectcomponentsSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct GraphconnectcomponentsMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn graph_connect_components_make_matrix(rows : Int, cols : Int, val : Double) -> GraphconnectcomponentsMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn graph_connect_components_matrix_identity(n : Int) -> GraphconnectcomponentsMatrix {
  let m = graph_connect_components_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn GraphconnectcomponentsMatrix::get(self : GraphconnectcomponentsMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn GraphconnectcomponentsMatrix::transpose(self : GraphconnectcomponentsMatrix) -> GraphconnectcomponentsMatrix {
  let result = graph_connect_components_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn GraphconnectcomponentsMatrix::add(self : GraphconnectcomponentsMatrix, other : GraphconnectcomponentsMatrix) -> GraphconnectcomponentsMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = graph_connect_components_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn GraphconnectcomponentsMatrix::scale(self : GraphconnectcomponentsMatrix, s : Double) -> GraphconnectcomponentsMatrix {
  let result = graph_connect_components_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn GraphconnectcomponentsMatrix::multiply(self : GraphconnectcomponentsMatrix, other : GraphconnectcomponentsMatrix) -> GraphconnectcomponentsMatrix {
  if self.cols != other.rows { return graph_connect_components_make_matrix(self.rows, other.cols, 0.0) }
  let result = graph_connect_components_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn GraphconnectcomponentsMatrix::trace(self : GraphconnectcomponentsMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn GraphconnectcomponentsMatrix::det(self : GraphconnectcomponentsMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn GraphconnectcomponentsMatrix::norm(self : GraphconnectcomponentsMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn GraphconnectcomponentsMatrix::to_string(self : GraphconnectcomponentsMatrix) -> String {
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

pub(all) struct GraphconnectcomponentsVector {
  comps : Array[Double]
  dim : Int
}

pub fn graph_connect_components_make_vector(comps : Array[Double]) -> GraphconnectcomponentsVector {
  { comps, dim: comps.length() }
}

pub fn graph_connect_components_vector_zero(dim : Int) -> GraphconnectcomponentsVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn GraphconnectcomponentsVector::add(self : GraphconnectcomponentsVector, other : GraphconnectcomponentsVector) -> GraphconnectcomponentsVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn GraphconnectcomponentsVector::sub(self : GraphconnectcomponentsVector, other : GraphconnectcomponentsVector) -> GraphconnectcomponentsVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn GraphconnectcomponentsVector::scale(self : GraphconnectcomponentsVector, s : Double) -> GraphconnectcomponentsVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn GraphconnectcomponentsVector::dot(self : GraphconnectcomponentsVector, other : GraphconnectcomponentsVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn GraphconnectcomponentsVector::norm(self : GraphconnectcomponentsVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn GraphconnectcomponentsVector::normalize(self : GraphconnectcomponentsVector) -> GraphconnectcomponentsVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn GraphconnectcomponentsVector::dist(self : GraphconnectcomponentsVector, other : GraphconnectcomponentsVector) -> Double {
  self.sub(other).norm()
}

pub fn GraphconnectcomponentsVector::to_string(self : GraphconnectcomponentsVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn graph_connect_components_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn graph_connect_components_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn graph_connect_components_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn graph_connect_components_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn graph_connect_components_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn graph_connect_components_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn graph_connect_components_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn graph_connect_components_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn graph_connect_components_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn graph_connect_components_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn graph_connect_components_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn graph_connect_components_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn graph_connect_components_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn graph_connect_components_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn graph_connect_components_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn graph_connect_components_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn graph_connect_components_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn graph_connect_components_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn graph_connect_components_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn graph_connect_components_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn graph_connect_components_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn graph_connect_components_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn graph_connect_components_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn graph_connect_components_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn graph_connect_components_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn graph_connect_components_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn graph_connect_components_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn graph_connect_components_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn graph_connect_components_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct GraphconnectcomponentsFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_connect_components_frame_make(size : Int) -> GraphconnectcomponentsFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_connect_components_frame_len(s : GraphconnectcomponentsFrame) -> Int { s.size }

pub fn graph_connect_components_frame_get(s : GraphconnectcomponentsFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_connect_components_frame_set(s : GraphconnectcomponentsFrame, i : Int, v : Double) -> GraphconnectcomponentsFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_connect_components_frame_sum(s : GraphconnectcomponentsFrame) -> Double { @_common.sum(s.data) }

pub fn graph_connect_components_frame_mean(s : GraphconnectcomponentsFrame) -> Double { @_common.mean(s.data) }

pub fn graph_connect_components_frame_scale(s : GraphconnectcomponentsFrame, f : Double) -> GraphconnectcomponentsFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_connect_components_frame_add(a : GraphconnectcomponentsFrame, b : GraphconnectcomponentsFrame) -> GraphconnectcomponentsFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_connect_components_frame_copy(s : GraphconnectcomponentsFrame) -> GraphconnectcomponentsFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_connect_components_frame_fill(s : GraphconnectcomponentsFrame, v : Double) -> GraphconnectcomponentsFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_connect_components_frame_min(s : GraphconnectcomponentsFrame) -> Double { @_common.min(s.data) }

pub fn graph_connect_components_frame_max(s : GraphconnectcomponentsFrame) -> Double { @_common.max(s.data) }

pub fn graph_connect_components_frame_to_string(s : GraphconnectcomponentsFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphconnectcomponentsTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_connect_components_table_make(size : Int) -> GraphconnectcomponentsTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_connect_components_table_len(s : GraphconnectcomponentsTable) -> Int { s.size }

pub fn graph_connect_components_table_get(s : GraphconnectcomponentsTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_connect_components_table_set(s : GraphconnectcomponentsTable, i : Int, v : Double) -> GraphconnectcomponentsTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_connect_components_table_sum(s : GraphconnectcomponentsTable) -> Double { @_common.sum(s.data) }

pub fn graph_connect_components_table_mean(s : GraphconnectcomponentsTable) -> Double { @_common.mean(s.data) }

pub fn graph_connect_components_table_scale(s : GraphconnectcomponentsTable, f : Double) -> GraphconnectcomponentsTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_connect_components_table_add(a : GraphconnectcomponentsTable, b : GraphconnectcomponentsTable) -> GraphconnectcomponentsTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_connect_components_table_copy(s : GraphconnectcomponentsTable) -> GraphconnectcomponentsTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_connect_components_table_fill(s : GraphconnectcomponentsTable, v : Double) -> GraphconnectcomponentsTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_connect_components_table_min(s : GraphconnectcomponentsTable) -> Double { @_common.min(s.data) }

pub fn graph_connect_components_table_max(s : GraphconnectcomponentsTable) -> Double { @_common.max(s.data) }

pub fn graph_connect_components_table_to_string(s : GraphconnectcomponentsTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphconnectcomponentsGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_connect_components_graphn_make(size : Int) -> GraphconnectcomponentsGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_connect_components_graphn_len(s : GraphconnectcomponentsGraphN) -> Int { s.size }

pub fn graph_connect_components_graphn_get(s : GraphconnectcomponentsGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_connect_components_graphn_set(s : GraphconnectcomponentsGraphN, i : Int, v : Double) -> GraphconnectcomponentsGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_connect_components_graphn_sum(s : GraphconnectcomponentsGraphN) -> Double { @_common.sum(s.data) }

pub fn graph_connect_components_graphn_mean(s : GraphconnectcomponentsGraphN) -> Double { @_common.mean(s.data) }

pub fn graph_connect_components_graphn_scale(s : GraphconnectcomponentsGraphN, f : Double) -> GraphconnectcomponentsGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_connect_components_graphn_add(a : GraphconnectcomponentsGraphN, b : GraphconnectcomponentsGraphN) -> GraphconnectcomponentsGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_connect_components_graphn_copy(s : GraphconnectcomponentsGraphN) -> GraphconnectcomponentsGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_connect_components_graphn_fill(s : GraphconnectcomponentsGraphN, v : Double) -> GraphconnectcomponentsGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_connect_components_graphn_min(s : GraphconnectcomponentsGraphN) -> Double { @_common.min(s.data) }

pub fn graph_connect_components_graphn_max(s : GraphconnectcomponentsGraphN) -> Double { @_common.max(s.data) }

pub fn graph_connect_components_graphn_to_string(s : GraphconnectcomponentsGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphconnectcomponentsNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_connect_components_node_make(size : Int) -> GraphconnectcomponentsNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_connect_components_node_len(s : GraphconnectcomponentsNode) -> Int { s.size }

pub fn graph_connect_components_node_get(s : GraphconnectcomponentsNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_connect_components_node_set(s : GraphconnectcomponentsNode, i : Int, v : Double) -> GraphconnectcomponentsNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_connect_components_node_sum(s : GraphconnectcomponentsNode) -> Double { @_common.sum(s.data) }

pub fn graph_connect_components_node_mean(s : GraphconnectcomponentsNode) -> Double { @_common.mean(s.data) }

pub fn graph_connect_components_node_scale(s : GraphconnectcomponentsNode, f : Double) -> GraphconnectcomponentsNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_connect_components_node_add(a : GraphconnectcomponentsNode, b : GraphconnectcomponentsNode) -> GraphconnectcomponentsNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_connect_components_node_copy(s : GraphconnectcomponentsNode) -> GraphconnectcomponentsNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_connect_components_node_fill(s : GraphconnectcomponentsNode, v : Double) -> GraphconnectcomponentsNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_connect_components_node_min(s : GraphconnectcomponentsNode) -> Double { @_common.min(s.data) }

pub fn graph_connect_components_node_max(s : GraphconnectcomponentsNode) -> Double { @_common.max(s.data) }

pub fn graph_connect_components_node_to_string(s : GraphconnectcomponentsNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphconnectcomponentsEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_connect_components_edge_make(size : Int) -> GraphconnectcomponentsEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_connect_components_edge_len(s : GraphconnectcomponentsEdge) -> Int { s.size }

pub fn graph_connect_components_edge_get(s : GraphconnectcomponentsEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_connect_components_edge_set(s : GraphconnectcomponentsEdge, i : Int, v : Double) -> GraphconnectcomponentsEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_connect_components_edge_sum(s : GraphconnectcomponentsEdge) -> Double { @_common.sum(s.data) }

pub fn graph_connect_components_edge_mean(s : GraphconnectcomponentsEdge) -> Double { @_common.mean(s.data) }

pub fn graph_connect_components_edge_scale(s : GraphconnectcomponentsEdge, f : Double) -> GraphconnectcomponentsEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_connect_components_edge_add(a : GraphconnectcomponentsEdge, b : GraphconnectcomponentsEdge) -> GraphconnectcomponentsEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_connect_components_edge_copy(s : GraphconnectcomponentsEdge) -> GraphconnectcomponentsEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_connect_components_edge_fill(s : GraphconnectcomponentsEdge, v : Double) -> GraphconnectcomponentsEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_connect_components_edge_min(s : GraphconnectcomponentsEdge) -> Double { @_common.min(s.data) }

pub fn graph_connect_components_edge_max(s : GraphconnectcomponentsEdge) -> Double { @_common.max(s.data) }

pub fn graph_connect_components_edge_to_string(s : GraphconnectcomponentsEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphconnectcomponentsPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_connect_components_path_make(size : Int) -> GraphconnectcomponentsPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_connect_components_path_len(s : GraphconnectcomponentsPath) -> Int { s.size }

pub fn graph_connect_components_path_get(s : GraphconnectcomponentsPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_connect_components_path_set(s : GraphconnectcomponentsPath, i : Int, v : Double) -> GraphconnectcomponentsPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_connect_components_path_sum(s : GraphconnectcomponentsPath) -> Double { @_common.sum(s.data) }

pub fn graph_connect_components_path_mean(s : GraphconnectcomponentsPath) -> Double { @_common.mean(s.data) }

pub fn graph_connect_components_path_scale(s : GraphconnectcomponentsPath, f : Double) -> GraphconnectcomponentsPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_connect_components_path_add(a : GraphconnectcomponentsPath, b : GraphconnectcomponentsPath) -> GraphconnectcomponentsPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_connect_components_path_copy(s : GraphconnectcomponentsPath) -> GraphconnectcomponentsPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_connect_components_path_fill(s : GraphconnectcomponentsPath, v : Double) -> GraphconnectcomponentsPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_connect_components_path_min(s : GraphconnectcomponentsPath) -> Double { @_common.min(s.data) }

pub fn graph_connect_components_path_max(s : GraphconnectcomponentsPath) -> Double { @_common.max(s.data) }

pub fn graph_connect_components_path_to_string(s : GraphconnectcomponentsPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphconnectcomponentsCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_connect_components_cluster_make(size : Int) -> GraphconnectcomponentsCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_connect_components_cluster_len(s : GraphconnectcomponentsCluster) -> Int { s.size }

pub fn graph_connect_components_cluster_get(s : GraphconnectcomponentsCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_connect_components_cluster_set(s : GraphconnectcomponentsCluster, i : Int, v : Double) -> GraphconnectcomponentsCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_connect_components_cluster_sum(s : GraphconnectcomponentsCluster) -> Double { @_common.sum(s.data) }

pub fn graph_connect_components_cluster_mean(s : GraphconnectcomponentsCluster) -> Double { @_common.mean(s.data) }

pub fn graph_connect_components_cluster_scale(s : GraphconnectcomponentsCluster, f : Double) -> GraphconnectcomponentsCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_connect_components_cluster_add(a : GraphconnectcomponentsCluster, b : GraphconnectcomponentsCluster) -> GraphconnectcomponentsCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_connect_components_cluster_copy(s : GraphconnectcomponentsCluster) -> GraphconnectcomponentsCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_connect_components_cluster_fill(s : GraphconnectcomponentsCluster, v : Double) -> GraphconnectcomponentsCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_connect_components_cluster_min(s : GraphconnectcomponentsCluster) -> Double { @_common.min(s.data) }

pub fn graph_connect_components_cluster_max(s : GraphconnectcomponentsCluster) -> Double { @_common.max(s.data) }

pub fn graph_connect_components_cluster_to_string(s : GraphconnectcomponentsCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphconnectcomponentsModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_connect_components_model_make(size : Int) -> GraphconnectcomponentsModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_connect_components_model_len(s : GraphconnectcomponentsModel) -> Int { s.size }

pub fn graph_connect_components_model_get(s : GraphconnectcomponentsModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_connect_components_model_set(s : GraphconnectcomponentsModel, i : Int, v : Double) -> GraphconnectcomponentsModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_connect_components_model_sum(s : GraphconnectcomponentsModel) -> Double { @_common.sum(s.data) }

pub fn graph_connect_components_model_mean(s : GraphconnectcomponentsModel) -> Double { @_common.mean(s.data) }

pub fn graph_connect_components_model_scale(s : GraphconnectcomponentsModel, f : Double) -> GraphconnectcomponentsModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_connect_components_model_add(a : GraphconnectcomponentsModel, b : GraphconnectcomponentsModel) -> GraphconnectcomponentsModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_connect_components_model_copy(s : GraphconnectcomponentsModel) -> GraphconnectcomponentsModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_connect_components_model_fill(s : GraphconnectcomponentsModel, v : Double) -> GraphconnectcomponentsModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_connect_components_model_min(s : GraphconnectcomponentsModel) -> Double { @_common.min(s.data) }

pub fn graph_connect_components_model_max(s : GraphconnectcomponentsModel) -> Double { @_common.max(s.data) }

pub fn graph_connect_components_model_to_string(s : GraphconnectcomponentsModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphconnectcomponentsLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_connect_components_layer_make(size : Int) -> GraphconnectcomponentsLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_connect_components_layer_len(s : GraphconnectcomponentsLayer) -> Int { s.size }

pub fn graph_connect_components_layer_get(s : GraphconnectcomponentsLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_connect_components_layer_set(s : GraphconnectcomponentsLayer, i : Int, v : Double) -> GraphconnectcomponentsLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_connect_components_layer_sum(s : GraphconnectcomponentsLayer) -> Double { @_common.sum(s.data) }

pub fn graph_connect_components_layer_mean(s : GraphconnectcomponentsLayer) -> Double { @_common.mean(s.data) }

pub fn graph_connect_components_layer_scale(s : GraphconnectcomponentsLayer, f : Double) -> GraphconnectcomponentsLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_connect_components_layer_add(a : GraphconnectcomponentsLayer, b : GraphconnectcomponentsLayer) -> GraphconnectcomponentsLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_connect_components_layer_copy(s : GraphconnectcomponentsLayer) -> GraphconnectcomponentsLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_connect_components_layer_fill(s : GraphconnectcomponentsLayer, v : Double) -> GraphconnectcomponentsLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_connect_components_layer_min(s : GraphconnectcomponentsLayer) -> Double { @_common.min(s.data) }

pub fn graph_connect_components_layer_max(s : GraphconnectcomponentsLayer) -> Double { @_common.max(s.data) }

pub fn graph_connect_components_layer_to_string(s : GraphconnectcomponentsLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphconnectcomponentsBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_connect_components_buffer_make(size : Int) -> GraphconnectcomponentsBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_connect_components_buffer_len(s : GraphconnectcomponentsBuffer) -> Int { s.size }

pub fn graph_connect_components_buffer_get(s : GraphconnectcomponentsBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_connect_components_buffer_set(s : GraphconnectcomponentsBuffer, i : Int, v : Double) -> GraphconnectcomponentsBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_connect_components_buffer_sum(s : GraphconnectcomponentsBuffer) -> Double { @_common.sum(s.data) }

pub fn graph_connect_components_buffer_mean(s : GraphconnectcomponentsBuffer) -> Double { @_common.mean(s.data) }

pub fn graph_connect_components_buffer_scale(s : GraphconnectcomponentsBuffer, f : Double) -> GraphconnectcomponentsBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_connect_components_buffer_add(a : GraphconnectcomponentsBuffer, b : GraphconnectcomponentsBuffer) -> GraphconnectcomponentsBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_connect_components_buffer_copy(s : GraphconnectcomponentsBuffer) -> GraphconnectcomponentsBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_connect_components_buffer_fill(s : GraphconnectcomponentsBuffer, v : Double) -> GraphconnectcomponentsBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_connect_components_buffer_min(s : GraphconnectcomponentsBuffer) -> Double { @_common.min(s.data) }

pub fn graph_connect_components_buffer_max(s : GraphconnectcomponentsBuffer) -> Double { @_common.max(s.data) }

pub fn graph_connect_components_buffer_to_string(s : GraphconnectcomponentsBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphconnectcomponentsCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_connect_components_cursor_make(size : Int) -> GraphconnectcomponentsCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_connect_components_cursor_len(s : GraphconnectcomponentsCursor) -> Int { s.size }

pub fn graph_connect_components_cursor_get(s : GraphconnectcomponentsCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_connect_components_cursor_set(s : GraphconnectcomponentsCursor, i : Int, v : Double) -> GraphconnectcomponentsCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_connect_components_cursor_sum(s : GraphconnectcomponentsCursor) -> Double { @_common.sum(s.data) }

pub fn graph_connect_components_cursor_mean(s : GraphconnectcomponentsCursor) -> Double { @_common.mean(s.data) }

pub fn graph_connect_components_cursor_scale(s : GraphconnectcomponentsCursor, f : Double) -> GraphconnectcomponentsCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_connect_components_cursor_add(a : GraphconnectcomponentsCursor, b : GraphconnectcomponentsCursor) -> GraphconnectcomponentsCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_connect_components_cursor_copy(s : GraphconnectcomponentsCursor) -> GraphconnectcomponentsCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_connect_components_cursor_fill(s : GraphconnectcomponentsCursor, v : Double) -> GraphconnectcomponentsCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_connect_components_cursor_min(s : GraphconnectcomponentsCursor) -> Double { @_common.min(s.data) }

pub fn graph_connect_components_cursor_max(s : GraphconnectcomponentsCursor) -> Double { @_common.max(s.data) }

pub fn graph_connect_components_cursor_to_string(s : GraphconnectcomponentsCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphconnectcomponentsView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_connect_components_view_make(size : Int) -> GraphconnectcomponentsView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_connect_components_view_len(s : GraphconnectcomponentsView) -> Int { s.size }

pub fn graph_connect_components_view_get(s : GraphconnectcomponentsView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_connect_components_view_set(s : GraphconnectcomponentsView, i : Int, v : Double) -> GraphconnectcomponentsView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_connect_components_view_sum(s : GraphconnectcomponentsView) -> Double { @_common.sum(s.data) }

pub fn graph_connect_components_view_mean(s : GraphconnectcomponentsView) -> Double { @_common.mean(s.data) }

pub fn graph_connect_components_view_scale(s : GraphconnectcomponentsView, f : Double) -> GraphconnectcomponentsView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_connect_components_view_add(a : GraphconnectcomponentsView, b : GraphconnectcomponentsView) -> GraphconnectcomponentsView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_connect_components_view_copy(s : GraphconnectcomponentsView) -> GraphconnectcomponentsView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_connect_components_view_fill(s : GraphconnectcomponentsView, v : Double) -> GraphconnectcomponentsView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_connect_components_view_min(s : GraphconnectcomponentsView) -> Double { @_common.min(s.data) }

pub fn graph_connect_components_view_max(s : GraphconnectcomponentsView) -> Double { @_common.max(s.data) }

pub fn graph_connect_components_view_to_string(s : GraphconnectcomponentsView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphconnectcomponentsRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_connect_components_range_make(size : Int) -> GraphconnectcomponentsRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_connect_components_range_len(s : GraphconnectcomponentsRange) -> Int { s.size }

pub fn graph_connect_components_range_get(s : GraphconnectcomponentsRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_connect_components_range_set(s : GraphconnectcomponentsRange, i : Int, v : Double) -> GraphconnectcomponentsRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_connect_components_range_sum(s : GraphconnectcomponentsRange) -> Double { @_common.sum(s.data) }

pub fn graph_connect_components_range_mean(s : GraphconnectcomponentsRange) -> Double { @_common.mean(s.data) }

pub fn graph_connect_components_range_scale(s : GraphconnectcomponentsRange, f : Double) -> GraphconnectcomponentsRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_connect_components_range_add(a : GraphconnectcomponentsRange, b : GraphconnectcomponentsRange) -> GraphconnectcomponentsRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_connect_components_range_copy(s : GraphconnectcomponentsRange) -> GraphconnectcomponentsRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_connect_components_range_fill(s : GraphconnectcomponentsRange, v : Double) -> GraphconnectcomponentsRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_connect_components_range_min(s : GraphconnectcomponentsRange) -> Double { @_common.min(s.data) }

pub fn graph_connect_components_range_max(s : GraphconnectcomponentsRange) -> Double { @_common.max(s.data) }

pub fn graph_connect_components_range_to_string(s : GraphconnectcomponentsRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphconnectcomponentsSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_connect_components_slice_make(size : Int) -> GraphconnectcomponentsSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_connect_components_slice_len(s : GraphconnectcomponentsSlice) -> Int { s.size }

pub fn graph_connect_components_slice_get(s : GraphconnectcomponentsSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_connect_components_slice_set(s : GraphconnectcomponentsSlice, i : Int, v : Double) -> GraphconnectcomponentsSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_connect_components_slice_sum(s : GraphconnectcomponentsSlice) -> Double { @_common.sum(s.data) }

pub fn graph_connect_components_slice_mean(s : GraphconnectcomponentsSlice) -> Double { @_common.mean(s.data) }

pub fn graph_connect_components_slice_scale(s : GraphconnectcomponentsSlice, f : Double) -> GraphconnectcomponentsSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_connect_components_slice_add(a : GraphconnectcomponentsSlice, b : GraphconnectcomponentsSlice) -> GraphconnectcomponentsSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_connect_components_slice_copy(s : GraphconnectcomponentsSlice) -> GraphconnectcomponentsSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_connect_components_slice_fill(s : GraphconnectcomponentsSlice, v : Double) -> GraphconnectcomponentsSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_connect_components_slice_min(s : GraphconnectcomponentsSlice) -> Double { @_common.min(s.data) }

pub fn graph_connect_components_slice_max(s : GraphconnectcomponentsSlice) -> Double { @_common.max(s.data) }

pub fn graph_connect_components_slice_to_string(s : GraphconnectcomponentsSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

