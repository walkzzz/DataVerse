///===
/// extcore/graph_connect_hamilton

pub(all) struct GraphconnecthamiltonPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn graph_connect_hamilton_make_point(x : Double, y : Double) -> GraphconnecthamiltonPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn graph_connect_hamilton_make_point3(x : Double, y : Double, z : Double) -> GraphconnecthamiltonPoint {
  { x, y, z, label: 0 }
}

pub fn GraphconnecthamiltonPoint::x(self : GraphconnecthamiltonPoint) -> Double { self.x }

pub fn GraphconnecthamiltonPoint::y(self : GraphconnecthamiltonPoint) -> Double { self.y }

pub fn GraphconnecthamiltonPoint::z(self : GraphconnecthamiltonPoint) -> Double { self.z }

pub fn GraphconnecthamiltonPoint::label(self : GraphconnecthamiltonPoint) -> Int { self.label }

pub fn GraphconnecthamiltonPoint::dist(self : GraphconnecthamiltonPoint, other : GraphconnecthamiltonPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn GraphconnecthamiltonPoint::add(self : GraphconnecthamiltonPoint, other : GraphconnecthamiltonPoint) -> GraphconnecthamiltonPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn GraphconnecthamiltonPoint::sub(self : GraphconnecthamiltonPoint, other : GraphconnecthamiltonPoint) -> GraphconnecthamiltonPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn GraphconnecthamiltonPoint::scale(self : GraphconnecthamiltonPoint, s : Double) -> GraphconnecthamiltonPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn GraphconnecthamiltonPoint::dot(self : GraphconnecthamiltonPoint, other : GraphconnecthamiltonPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn GraphconnecthamiltonPoint::cross(self : GraphconnecthamiltonPoint, other : GraphconnecthamiltonPoint) -> GraphconnecthamiltonPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn GraphconnecthamiltonPoint::norm(self : GraphconnecthamiltonPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn GraphconnecthamiltonPoint::normalize(self : GraphconnecthamiltonPoint) -> GraphconnecthamiltonPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn GraphconnecthamiltonPoint::negate(self : GraphconnecthamiltonPoint) -> GraphconnecthamiltonPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn GraphconnecthamiltonPoint::mid(self : GraphconnecthamiltonPoint, other : GraphconnecthamiltonPoint) -> GraphconnecthamiltonPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn GraphconnecthamiltonPoint::lerp(self : GraphconnecthamiltonPoint, other : GraphconnecthamiltonPoint, t : Double) -> GraphconnecthamiltonPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn GraphconnecthamiltonPoint::to_string(self : GraphconnecthamiltonPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct GraphconnecthamiltonSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn graph_connect_hamilton_make_series(vals : Array[Double], name : String) -> GraphconnecthamiltonSeries {
  { vals, name, meta: 0 }
}

pub fn GraphconnecthamiltonSeries::len(self : GraphconnecthamiltonSeries) -> Int { self.vals.length() }

pub fn GraphconnecthamiltonSeries::sum(self : GraphconnecthamiltonSeries) -> Double { @_common.sum(self.vals) }

pub fn GraphconnecthamiltonSeries::mean(self : GraphconnecthamiltonSeries) -> Double { @_common.mean(self.vals) }

pub fn GraphconnecthamiltonSeries::min(self : GraphconnecthamiltonSeries) -> Double { @_common.min(self.vals) }

pub fn GraphconnecthamiltonSeries::max(self : GraphconnecthamiltonSeries) -> Double { @_common.max(self.vals) }

pub fn GraphconnecthamiltonSeries::range(self : GraphconnecthamiltonSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn GraphconnecthamiltonSeries::variance(self : GraphconnecthamiltonSeries) -> Double { @_common.variance(self.vals) }

pub fn GraphconnecthamiltonSeries::std(self : GraphconnecthamiltonSeries) -> Double { @_common.std(self.vals) }

pub fn GraphconnecthamiltonSeries::median(self : GraphconnecthamiltonSeries) -> Double { @_common.median(self.vals) }

pub fn GraphconnecthamiltonSeries::scale(self : GraphconnecthamiltonSeries, f : Double) -> GraphconnecthamiltonSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn GraphconnecthamiltonSeries::add(self : GraphconnecthamiltonSeries, other : GraphconnecthamiltonSeries) -> GraphconnecthamiltonSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn GraphconnecthamiltonSeries::sub(self : GraphconnecthamiltonSeries, other : GraphconnecthamiltonSeries) -> GraphconnecthamiltonSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn GraphconnecthamiltonSeries::normalize(self : GraphconnecthamiltonSeries) -> GraphconnecthamiltonSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn GraphconnecthamiltonSeries::cumsum(self : GraphconnecthamiltonSeries) -> GraphconnecthamiltonSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn GraphconnecthamiltonSeries::to_string(self : GraphconnecthamiltonSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct GraphconnecthamiltonMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn graph_connect_hamilton_make_matrix(rows : Int, cols : Int, val : Double) -> GraphconnecthamiltonMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn graph_connect_hamilton_matrix_identity(n : Int) -> GraphconnecthamiltonMatrix {
  let m = graph_connect_hamilton_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn GraphconnecthamiltonMatrix::get(self : GraphconnecthamiltonMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn GraphconnecthamiltonMatrix::transpose(self : GraphconnecthamiltonMatrix) -> GraphconnecthamiltonMatrix {
  let result = graph_connect_hamilton_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn GraphconnecthamiltonMatrix::add(self : GraphconnecthamiltonMatrix, other : GraphconnecthamiltonMatrix) -> GraphconnecthamiltonMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = graph_connect_hamilton_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn GraphconnecthamiltonMatrix::scale(self : GraphconnecthamiltonMatrix, s : Double) -> GraphconnecthamiltonMatrix {
  let result = graph_connect_hamilton_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn GraphconnecthamiltonMatrix::multiply(self : GraphconnecthamiltonMatrix, other : GraphconnecthamiltonMatrix) -> GraphconnecthamiltonMatrix {
  if self.cols != other.rows { return graph_connect_hamilton_make_matrix(self.rows, other.cols, 0.0) }
  let result = graph_connect_hamilton_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn GraphconnecthamiltonMatrix::trace(self : GraphconnecthamiltonMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn GraphconnecthamiltonMatrix::det(self : GraphconnecthamiltonMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn GraphconnecthamiltonMatrix::norm(self : GraphconnecthamiltonMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn GraphconnecthamiltonMatrix::to_string(self : GraphconnecthamiltonMatrix) -> String {
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

pub(all) struct GraphconnecthamiltonVector {
  comps : Array[Double]
  dim : Int
}

pub fn graph_connect_hamilton_make_vector(comps : Array[Double]) -> GraphconnecthamiltonVector {
  { comps, dim: comps.length() }
}

pub fn graph_connect_hamilton_vector_zero(dim : Int) -> GraphconnecthamiltonVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn GraphconnecthamiltonVector::add(self : GraphconnecthamiltonVector, other : GraphconnecthamiltonVector) -> GraphconnecthamiltonVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn GraphconnecthamiltonVector::sub(self : GraphconnecthamiltonVector, other : GraphconnecthamiltonVector) -> GraphconnecthamiltonVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn GraphconnecthamiltonVector::scale(self : GraphconnecthamiltonVector, s : Double) -> GraphconnecthamiltonVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn GraphconnecthamiltonVector::dot(self : GraphconnecthamiltonVector, other : GraphconnecthamiltonVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn GraphconnecthamiltonVector::norm(self : GraphconnecthamiltonVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn GraphconnecthamiltonVector::normalize(self : GraphconnecthamiltonVector) -> GraphconnecthamiltonVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn GraphconnecthamiltonVector::dist(self : GraphconnecthamiltonVector, other : GraphconnecthamiltonVector) -> Double {
  self.sub(other).norm()
}

pub fn GraphconnecthamiltonVector::to_string(self : GraphconnecthamiltonVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn graph_connect_hamilton_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn graph_connect_hamilton_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn graph_connect_hamilton_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn graph_connect_hamilton_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn graph_connect_hamilton_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn graph_connect_hamilton_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn graph_connect_hamilton_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn graph_connect_hamilton_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn graph_connect_hamilton_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn graph_connect_hamilton_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn graph_connect_hamilton_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn graph_connect_hamilton_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn graph_connect_hamilton_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn graph_connect_hamilton_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn graph_connect_hamilton_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn graph_connect_hamilton_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn graph_connect_hamilton_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn graph_connect_hamilton_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn graph_connect_hamilton_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn graph_connect_hamilton_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn graph_connect_hamilton_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn graph_connect_hamilton_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn graph_connect_hamilton_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn graph_connect_hamilton_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn graph_connect_hamilton_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn graph_connect_hamilton_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn graph_connect_hamilton_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn graph_connect_hamilton_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn graph_connect_hamilton_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct GraphconnecthamiltonFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_connect_hamilton_frame_make(size : Int) -> GraphconnecthamiltonFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_connect_hamilton_frame_len(s : GraphconnecthamiltonFrame) -> Int { s.size }

pub fn graph_connect_hamilton_frame_get(s : GraphconnecthamiltonFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_connect_hamilton_frame_set(s : GraphconnecthamiltonFrame, i : Int, v : Double) -> GraphconnecthamiltonFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_connect_hamilton_frame_sum(s : GraphconnecthamiltonFrame) -> Double { @_common.sum(s.data) }

pub fn graph_connect_hamilton_frame_mean(s : GraphconnecthamiltonFrame) -> Double { @_common.mean(s.data) }

pub fn graph_connect_hamilton_frame_scale(s : GraphconnecthamiltonFrame, f : Double) -> GraphconnecthamiltonFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_connect_hamilton_frame_add(a : GraphconnecthamiltonFrame, b : GraphconnecthamiltonFrame) -> GraphconnecthamiltonFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_connect_hamilton_frame_copy(s : GraphconnecthamiltonFrame) -> GraphconnecthamiltonFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_connect_hamilton_frame_fill(s : GraphconnecthamiltonFrame, v : Double) -> GraphconnecthamiltonFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_connect_hamilton_frame_min(s : GraphconnecthamiltonFrame) -> Double { @_common.min(s.data) }

pub fn graph_connect_hamilton_frame_max(s : GraphconnecthamiltonFrame) -> Double { @_common.max(s.data) }

pub fn graph_connect_hamilton_frame_to_string(s : GraphconnecthamiltonFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphconnecthamiltonTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_connect_hamilton_table_make(size : Int) -> GraphconnecthamiltonTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_connect_hamilton_table_len(s : GraphconnecthamiltonTable) -> Int { s.size }

pub fn graph_connect_hamilton_table_get(s : GraphconnecthamiltonTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_connect_hamilton_table_set(s : GraphconnecthamiltonTable, i : Int, v : Double) -> GraphconnecthamiltonTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_connect_hamilton_table_sum(s : GraphconnecthamiltonTable) -> Double { @_common.sum(s.data) }

pub fn graph_connect_hamilton_table_mean(s : GraphconnecthamiltonTable) -> Double { @_common.mean(s.data) }

pub fn graph_connect_hamilton_table_scale(s : GraphconnecthamiltonTable, f : Double) -> GraphconnecthamiltonTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_connect_hamilton_table_add(a : GraphconnecthamiltonTable, b : GraphconnecthamiltonTable) -> GraphconnecthamiltonTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_connect_hamilton_table_copy(s : GraphconnecthamiltonTable) -> GraphconnecthamiltonTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_connect_hamilton_table_fill(s : GraphconnecthamiltonTable, v : Double) -> GraphconnecthamiltonTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_connect_hamilton_table_min(s : GraphconnecthamiltonTable) -> Double { @_common.min(s.data) }

pub fn graph_connect_hamilton_table_max(s : GraphconnecthamiltonTable) -> Double { @_common.max(s.data) }

pub fn graph_connect_hamilton_table_to_string(s : GraphconnecthamiltonTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphconnecthamiltonGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_connect_hamilton_graphn_make(size : Int) -> GraphconnecthamiltonGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_connect_hamilton_graphn_len(s : GraphconnecthamiltonGraphN) -> Int { s.size }

pub fn graph_connect_hamilton_graphn_get(s : GraphconnecthamiltonGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_connect_hamilton_graphn_set(s : GraphconnecthamiltonGraphN, i : Int, v : Double) -> GraphconnecthamiltonGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_connect_hamilton_graphn_sum(s : GraphconnecthamiltonGraphN) -> Double { @_common.sum(s.data) }

pub fn graph_connect_hamilton_graphn_mean(s : GraphconnecthamiltonGraphN) -> Double { @_common.mean(s.data) }

pub fn graph_connect_hamilton_graphn_scale(s : GraphconnecthamiltonGraphN, f : Double) -> GraphconnecthamiltonGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_connect_hamilton_graphn_add(a : GraphconnecthamiltonGraphN, b : GraphconnecthamiltonGraphN) -> GraphconnecthamiltonGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_connect_hamilton_graphn_copy(s : GraphconnecthamiltonGraphN) -> GraphconnecthamiltonGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_connect_hamilton_graphn_fill(s : GraphconnecthamiltonGraphN, v : Double) -> GraphconnecthamiltonGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_connect_hamilton_graphn_min(s : GraphconnecthamiltonGraphN) -> Double { @_common.min(s.data) }

pub fn graph_connect_hamilton_graphn_max(s : GraphconnecthamiltonGraphN) -> Double { @_common.max(s.data) }

pub fn graph_connect_hamilton_graphn_to_string(s : GraphconnecthamiltonGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphconnecthamiltonNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_connect_hamilton_node_make(size : Int) -> GraphconnecthamiltonNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_connect_hamilton_node_len(s : GraphconnecthamiltonNode) -> Int { s.size }

pub fn graph_connect_hamilton_node_get(s : GraphconnecthamiltonNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_connect_hamilton_node_set(s : GraphconnecthamiltonNode, i : Int, v : Double) -> GraphconnecthamiltonNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_connect_hamilton_node_sum(s : GraphconnecthamiltonNode) -> Double { @_common.sum(s.data) }

pub fn graph_connect_hamilton_node_mean(s : GraphconnecthamiltonNode) -> Double { @_common.mean(s.data) }

pub fn graph_connect_hamilton_node_scale(s : GraphconnecthamiltonNode, f : Double) -> GraphconnecthamiltonNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_connect_hamilton_node_add(a : GraphconnecthamiltonNode, b : GraphconnecthamiltonNode) -> GraphconnecthamiltonNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_connect_hamilton_node_copy(s : GraphconnecthamiltonNode) -> GraphconnecthamiltonNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_connect_hamilton_node_fill(s : GraphconnecthamiltonNode, v : Double) -> GraphconnecthamiltonNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_connect_hamilton_node_min(s : GraphconnecthamiltonNode) -> Double { @_common.min(s.data) }

pub fn graph_connect_hamilton_node_max(s : GraphconnecthamiltonNode) -> Double { @_common.max(s.data) }

pub fn graph_connect_hamilton_node_to_string(s : GraphconnecthamiltonNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphconnecthamiltonEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_connect_hamilton_edge_make(size : Int) -> GraphconnecthamiltonEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_connect_hamilton_edge_len(s : GraphconnecthamiltonEdge) -> Int { s.size }

pub fn graph_connect_hamilton_edge_get(s : GraphconnecthamiltonEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_connect_hamilton_edge_set(s : GraphconnecthamiltonEdge, i : Int, v : Double) -> GraphconnecthamiltonEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_connect_hamilton_edge_sum(s : GraphconnecthamiltonEdge) -> Double { @_common.sum(s.data) }

pub fn graph_connect_hamilton_edge_mean(s : GraphconnecthamiltonEdge) -> Double { @_common.mean(s.data) }

pub fn graph_connect_hamilton_edge_scale(s : GraphconnecthamiltonEdge, f : Double) -> GraphconnecthamiltonEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_connect_hamilton_edge_add(a : GraphconnecthamiltonEdge, b : GraphconnecthamiltonEdge) -> GraphconnecthamiltonEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_connect_hamilton_edge_copy(s : GraphconnecthamiltonEdge) -> GraphconnecthamiltonEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_connect_hamilton_edge_fill(s : GraphconnecthamiltonEdge, v : Double) -> GraphconnecthamiltonEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_connect_hamilton_edge_min(s : GraphconnecthamiltonEdge) -> Double { @_common.min(s.data) }

pub fn graph_connect_hamilton_edge_max(s : GraphconnecthamiltonEdge) -> Double { @_common.max(s.data) }

pub fn graph_connect_hamilton_edge_to_string(s : GraphconnecthamiltonEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphconnecthamiltonPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_connect_hamilton_path_make(size : Int) -> GraphconnecthamiltonPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_connect_hamilton_path_len(s : GraphconnecthamiltonPath) -> Int { s.size }

pub fn graph_connect_hamilton_path_get(s : GraphconnecthamiltonPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_connect_hamilton_path_set(s : GraphconnecthamiltonPath, i : Int, v : Double) -> GraphconnecthamiltonPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_connect_hamilton_path_sum(s : GraphconnecthamiltonPath) -> Double { @_common.sum(s.data) }

pub fn graph_connect_hamilton_path_mean(s : GraphconnecthamiltonPath) -> Double { @_common.mean(s.data) }

pub fn graph_connect_hamilton_path_scale(s : GraphconnecthamiltonPath, f : Double) -> GraphconnecthamiltonPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_connect_hamilton_path_add(a : GraphconnecthamiltonPath, b : GraphconnecthamiltonPath) -> GraphconnecthamiltonPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_connect_hamilton_path_copy(s : GraphconnecthamiltonPath) -> GraphconnecthamiltonPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_connect_hamilton_path_fill(s : GraphconnecthamiltonPath, v : Double) -> GraphconnecthamiltonPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_connect_hamilton_path_min(s : GraphconnecthamiltonPath) -> Double { @_common.min(s.data) }

pub fn graph_connect_hamilton_path_max(s : GraphconnecthamiltonPath) -> Double { @_common.max(s.data) }

pub fn graph_connect_hamilton_path_to_string(s : GraphconnecthamiltonPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphconnecthamiltonCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_connect_hamilton_cluster_make(size : Int) -> GraphconnecthamiltonCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_connect_hamilton_cluster_len(s : GraphconnecthamiltonCluster) -> Int { s.size }

pub fn graph_connect_hamilton_cluster_get(s : GraphconnecthamiltonCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_connect_hamilton_cluster_set(s : GraphconnecthamiltonCluster, i : Int, v : Double) -> GraphconnecthamiltonCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_connect_hamilton_cluster_sum(s : GraphconnecthamiltonCluster) -> Double { @_common.sum(s.data) }

pub fn graph_connect_hamilton_cluster_mean(s : GraphconnecthamiltonCluster) -> Double { @_common.mean(s.data) }

pub fn graph_connect_hamilton_cluster_scale(s : GraphconnecthamiltonCluster, f : Double) -> GraphconnecthamiltonCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_connect_hamilton_cluster_add(a : GraphconnecthamiltonCluster, b : GraphconnecthamiltonCluster) -> GraphconnecthamiltonCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_connect_hamilton_cluster_copy(s : GraphconnecthamiltonCluster) -> GraphconnecthamiltonCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_connect_hamilton_cluster_fill(s : GraphconnecthamiltonCluster, v : Double) -> GraphconnecthamiltonCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_connect_hamilton_cluster_min(s : GraphconnecthamiltonCluster) -> Double { @_common.min(s.data) }

pub fn graph_connect_hamilton_cluster_max(s : GraphconnecthamiltonCluster) -> Double { @_common.max(s.data) }

pub fn graph_connect_hamilton_cluster_to_string(s : GraphconnecthamiltonCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphconnecthamiltonModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_connect_hamilton_model_make(size : Int) -> GraphconnecthamiltonModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_connect_hamilton_model_len(s : GraphconnecthamiltonModel) -> Int { s.size }

pub fn graph_connect_hamilton_model_get(s : GraphconnecthamiltonModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_connect_hamilton_model_set(s : GraphconnecthamiltonModel, i : Int, v : Double) -> GraphconnecthamiltonModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_connect_hamilton_model_sum(s : GraphconnecthamiltonModel) -> Double { @_common.sum(s.data) }

pub fn graph_connect_hamilton_model_mean(s : GraphconnecthamiltonModel) -> Double { @_common.mean(s.data) }

pub fn graph_connect_hamilton_model_scale(s : GraphconnecthamiltonModel, f : Double) -> GraphconnecthamiltonModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_connect_hamilton_model_add(a : GraphconnecthamiltonModel, b : GraphconnecthamiltonModel) -> GraphconnecthamiltonModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_connect_hamilton_model_copy(s : GraphconnecthamiltonModel) -> GraphconnecthamiltonModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_connect_hamilton_model_fill(s : GraphconnecthamiltonModel, v : Double) -> GraphconnecthamiltonModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_connect_hamilton_model_min(s : GraphconnecthamiltonModel) -> Double { @_common.min(s.data) }

pub fn graph_connect_hamilton_model_max(s : GraphconnecthamiltonModel) -> Double { @_common.max(s.data) }

pub fn graph_connect_hamilton_model_to_string(s : GraphconnecthamiltonModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphconnecthamiltonLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_connect_hamilton_layer_make(size : Int) -> GraphconnecthamiltonLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_connect_hamilton_layer_len(s : GraphconnecthamiltonLayer) -> Int { s.size }

pub fn graph_connect_hamilton_layer_get(s : GraphconnecthamiltonLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_connect_hamilton_layer_set(s : GraphconnecthamiltonLayer, i : Int, v : Double) -> GraphconnecthamiltonLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_connect_hamilton_layer_sum(s : GraphconnecthamiltonLayer) -> Double { @_common.sum(s.data) }

pub fn graph_connect_hamilton_layer_mean(s : GraphconnecthamiltonLayer) -> Double { @_common.mean(s.data) }

pub fn graph_connect_hamilton_layer_scale(s : GraphconnecthamiltonLayer, f : Double) -> GraphconnecthamiltonLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_connect_hamilton_layer_add(a : GraphconnecthamiltonLayer, b : GraphconnecthamiltonLayer) -> GraphconnecthamiltonLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_connect_hamilton_layer_copy(s : GraphconnecthamiltonLayer) -> GraphconnecthamiltonLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_connect_hamilton_layer_fill(s : GraphconnecthamiltonLayer, v : Double) -> GraphconnecthamiltonLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_connect_hamilton_layer_min(s : GraphconnecthamiltonLayer) -> Double { @_common.min(s.data) }

pub fn graph_connect_hamilton_layer_max(s : GraphconnecthamiltonLayer) -> Double { @_common.max(s.data) }

pub fn graph_connect_hamilton_layer_to_string(s : GraphconnecthamiltonLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphconnecthamiltonBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_connect_hamilton_buffer_make(size : Int) -> GraphconnecthamiltonBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_connect_hamilton_buffer_len(s : GraphconnecthamiltonBuffer) -> Int { s.size }

pub fn graph_connect_hamilton_buffer_get(s : GraphconnecthamiltonBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_connect_hamilton_buffer_set(s : GraphconnecthamiltonBuffer, i : Int, v : Double) -> GraphconnecthamiltonBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_connect_hamilton_buffer_sum(s : GraphconnecthamiltonBuffer) -> Double { @_common.sum(s.data) }

pub fn graph_connect_hamilton_buffer_mean(s : GraphconnecthamiltonBuffer) -> Double { @_common.mean(s.data) }

pub fn graph_connect_hamilton_buffer_scale(s : GraphconnecthamiltonBuffer, f : Double) -> GraphconnecthamiltonBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_connect_hamilton_buffer_add(a : GraphconnecthamiltonBuffer, b : GraphconnecthamiltonBuffer) -> GraphconnecthamiltonBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_connect_hamilton_buffer_copy(s : GraphconnecthamiltonBuffer) -> GraphconnecthamiltonBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_connect_hamilton_buffer_fill(s : GraphconnecthamiltonBuffer, v : Double) -> GraphconnecthamiltonBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_connect_hamilton_buffer_min(s : GraphconnecthamiltonBuffer) -> Double { @_common.min(s.data) }

pub fn graph_connect_hamilton_buffer_max(s : GraphconnecthamiltonBuffer) -> Double { @_common.max(s.data) }

pub fn graph_connect_hamilton_buffer_to_string(s : GraphconnecthamiltonBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphconnecthamiltonCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_connect_hamilton_cursor_make(size : Int) -> GraphconnecthamiltonCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_connect_hamilton_cursor_len(s : GraphconnecthamiltonCursor) -> Int { s.size }

pub fn graph_connect_hamilton_cursor_get(s : GraphconnecthamiltonCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_connect_hamilton_cursor_set(s : GraphconnecthamiltonCursor, i : Int, v : Double) -> GraphconnecthamiltonCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_connect_hamilton_cursor_sum(s : GraphconnecthamiltonCursor) -> Double { @_common.sum(s.data) }

pub fn graph_connect_hamilton_cursor_mean(s : GraphconnecthamiltonCursor) -> Double { @_common.mean(s.data) }

pub fn graph_connect_hamilton_cursor_scale(s : GraphconnecthamiltonCursor, f : Double) -> GraphconnecthamiltonCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_connect_hamilton_cursor_add(a : GraphconnecthamiltonCursor, b : GraphconnecthamiltonCursor) -> GraphconnecthamiltonCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_connect_hamilton_cursor_copy(s : GraphconnecthamiltonCursor) -> GraphconnecthamiltonCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_connect_hamilton_cursor_fill(s : GraphconnecthamiltonCursor, v : Double) -> GraphconnecthamiltonCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_connect_hamilton_cursor_min(s : GraphconnecthamiltonCursor) -> Double { @_common.min(s.data) }

pub fn graph_connect_hamilton_cursor_max(s : GraphconnecthamiltonCursor) -> Double { @_common.max(s.data) }

pub fn graph_connect_hamilton_cursor_to_string(s : GraphconnecthamiltonCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphconnecthamiltonView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_connect_hamilton_view_make(size : Int) -> GraphconnecthamiltonView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_connect_hamilton_view_len(s : GraphconnecthamiltonView) -> Int { s.size }

pub fn graph_connect_hamilton_view_get(s : GraphconnecthamiltonView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_connect_hamilton_view_set(s : GraphconnecthamiltonView, i : Int, v : Double) -> GraphconnecthamiltonView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_connect_hamilton_view_sum(s : GraphconnecthamiltonView) -> Double { @_common.sum(s.data) }

pub fn graph_connect_hamilton_view_mean(s : GraphconnecthamiltonView) -> Double { @_common.mean(s.data) }

pub fn graph_connect_hamilton_view_scale(s : GraphconnecthamiltonView, f : Double) -> GraphconnecthamiltonView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_connect_hamilton_view_add(a : GraphconnecthamiltonView, b : GraphconnecthamiltonView) -> GraphconnecthamiltonView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_connect_hamilton_view_copy(s : GraphconnecthamiltonView) -> GraphconnecthamiltonView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_connect_hamilton_view_fill(s : GraphconnecthamiltonView, v : Double) -> GraphconnecthamiltonView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_connect_hamilton_view_min(s : GraphconnecthamiltonView) -> Double { @_common.min(s.data) }

pub fn graph_connect_hamilton_view_max(s : GraphconnecthamiltonView) -> Double { @_common.max(s.data) }

pub fn graph_connect_hamilton_view_to_string(s : GraphconnecthamiltonView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphconnecthamiltonRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_connect_hamilton_range_make(size : Int) -> GraphconnecthamiltonRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_connect_hamilton_range_len(s : GraphconnecthamiltonRange) -> Int { s.size }

pub fn graph_connect_hamilton_range_get(s : GraphconnecthamiltonRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_connect_hamilton_range_set(s : GraphconnecthamiltonRange, i : Int, v : Double) -> GraphconnecthamiltonRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_connect_hamilton_range_sum(s : GraphconnecthamiltonRange) -> Double { @_common.sum(s.data) }

pub fn graph_connect_hamilton_range_mean(s : GraphconnecthamiltonRange) -> Double { @_common.mean(s.data) }

pub fn graph_connect_hamilton_range_scale(s : GraphconnecthamiltonRange, f : Double) -> GraphconnecthamiltonRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_connect_hamilton_range_add(a : GraphconnecthamiltonRange, b : GraphconnecthamiltonRange) -> GraphconnecthamiltonRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_connect_hamilton_range_copy(s : GraphconnecthamiltonRange) -> GraphconnecthamiltonRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_connect_hamilton_range_fill(s : GraphconnecthamiltonRange, v : Double) -> GraphconnecthamiltonRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_connect_hamilton_range_min(s : GraphconnecthamiltonRange) -> Double { @_common.min(s.data) }

pub fn graph_connect_hamilton_range_max(s : GraphconnecthamiltonRange) -> Double { @_common.max(s.data) }

pub fn graph_connect_hamilton_range_to_string(s : GraphconnecthamiltonRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphconnecthamiltonSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_connect_hamilton_slice_make(size : Int) -> GraphconnecthamiltonSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_connect_hamilton_slice_len(s : GraphconnecthamiltonSlice) -> Int { s.size }

pub fn graph_connect_hamilton_slice_get(s : GraphconnecthamiltonSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_connect_hamilton_slice_set(s : GraphconnecthamiltonSlice, i : Int, v : Double) -> GraphconnecthamiltonSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_connect_hamilton_slice_sum(s : GraphconnecthamiltonSlice) -> Double { @_common.sum(s.data) }

pub fn graph_connect_hamilton_slice_mean(s : GraphconnecthamiltonSlice) -> Double { @_common.mean(s.data) }

pub fn graph_connect_hamilton_slice_scale(s : GraphconnecthamiltonSlice, f : Double) -> GraphconnecthamiltonSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_connect_hamilton_slice_add(a : GraphconnecthamiltonSlice, b : GraphconnecthamiltonSlice) -> GraphconnecthamiltonSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_connect_hamilton_slice_copy(s : GraphconnecthamiltonSlice) -> GraphconnecthamiltonSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_connect_hamilton_slice_fill(s : GraphconnecthamiltonSlice, v : Double) -> GraphconnecthamiltonSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_connect_hamilton_slice_min(s : GraphconnecthamiltonSlice) -> Double { @_common.min(s.data) }

pub fn graph_connect_hamilton_slice_max(s : GraphconnecthamiltonSlice) -> Double { @_common.max(s.data) }

pub fn graph_connect_hamilton_slice_to_string(s : GraphconnecthamiltonSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

