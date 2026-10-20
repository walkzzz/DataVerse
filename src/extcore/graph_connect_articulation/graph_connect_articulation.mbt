///===
/// extcore/graph_connect_articulation

pub(all) struct GraphconnectarticulationPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn graph_connect_articulation_make_point(x : Double, y : Double) -> GraphconnectarticulationPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn graph_connect_articulation_make_point3(x : Double, y : Double, z : Double) -> GraphconnectarticulationPoint {
  { x, y, z, label: 0 }
}

pub fn GraphconnectarticulationPoint::x(self : GraphconnectarticulationPoint) -> Double { self.x }

pub fn GraphconnectarticulationPoint::y(self : GraphconnectarticulationPoint) -> Double { self.y }

pub fn GraphconnectarticulationPoint::z(self : GraphconnectarticulationPoint) -> Double { self.z }

pub fn GraphconnectarticulationPoint::label(self : GraphconnectarticulationPoint) -> Int { self.label }

pub fn GraphconnectarticulationPoint::dist(self : GraphconnectarticulationPoint, other : GraphconnectarticulationPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn GraphconnectarticulationPoint::add(self : GraphconnectarticulationPoint, other : GraphconnectarticulationPoint) -> GraphconnectarticulationPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn GraphconnectarticulationPoint::sub(self : GraphconnectarticulationPoint, other : GraphconnectarticulationPoint) -> GraphconnectarticulationPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn GraphconnectarticulationPoint::scale(self : GraphconnectarticulationPoint, s : Double) -> GraphconnectarticulationPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn GraphconnectarticulationPoint::dot(self : GraphconnectarticulationPoint, other : GraphconnectarticulationPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn GraphconnectarticulationPoint::cross(self : GraphconnectarticulationPoint, other : GraphconnectarticulationPoint) -> GraphconnectarticulationPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn GraphconnectarticulationPoint::norm(self : GraphconnectarticulationPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn GraphconnectarticulationPoint::normalize(self : GraphconnectarticulationPoint) -> GraphconnectarticulationPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn GraphconnectarticulationPoint::negate(self : GraphconnectarticulationPoint) -> GraphconnectarticulationPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn GraphconnectarticulationPoint::mid(self : GraphconnectarticulationPoint, other : GraphconnectarticulationPoint) -> GraphconnectarticulationPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn GraphconnectarticulationPoint::lerp(self : GraphconnectarticulationPoint, other : GraphconnectarticulationPoint, t : Double) -> GraphconnectarticulationPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn GraphconnectarticulationPoint::to_string(self : GraphconnectarticulationPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct GraphconnectarticulationSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn graph_connect_articulation_make_series(vals : Array[Double], name : String) -> GraphconnectarticulationSeries {
  { vals, name, meta: 0 }
}

pub fn GraphconnectarticulationSeries::len(self : GraphconnectarticulationSeries) -> Int { self.vals.length() }

pub fn GraphconnectarticulationSeries::sum(self : GraphconnectarticulationSeries) -> Double { @_common.sum(self.vals) }

pub fn GraphconnectarticulationSeries::mean(self : GraphconnectarticulationSeries) -> Double { @_common.mean(self.vals) }

pub fn GraphconnectarticulationSeries::min(self : GraphconnectarticulationSeries) -> Double { @_common.min(self.vals) }

pub fn GraphconnectarticulationSeries::max(self : GraphconnectarticulationSeries) -> Double { @_common.max(self.vals) }

pub fn GraphconnectarticulationSeries::range(self : GraphconnectarticulationSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn GraphconnectarticulationSeries::variance(self : GraphconnectarticulationSeries) -> Double { @_common.variance(self.vals) }

pub fn GraphconnectarticulationSeries::std(self : GraphconnectarticulationSeries) -> Double { @_common.std(self.vals) }

pub fn GraphconnectarticulationSeries::median(self : GraphconnectarticulationSeries) -> Double { @_common.median(self.vals) }

pub fn GraphconnectarticulationSeries::scale(self : GraphconnectarticulationSeries, f : Double) -> GraphconnectarticulationSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn GraphconnectarticulationSeries::add(self : GraphconnectarticulationSeries, other : GraphconnectarticulationSeries) -> GraphconnectarticulationSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn GraphconnectarticulationSeries::sub(self : GraphconnectarticulationSeries, other : GraphconnectarticulationSeries) -> GraphconnectarticulationSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn GraphconnectarticulationSeries::normalize(self : GraphconnectarticulationSeries) -> GraphconnectarticulationSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn GraphconnectarticulationSeries::cumsum(self : GraphconnectarticulationSeries) -> GraphconnectarticulationSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn GraphconnectarticulationSeries::to_string(self : GraphconnectarticulationSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct GraphconnectarticulationMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn graph_connect_articulation_make_matrix(rows : Int, cols : Int, val : Double) -> GraphconnectarticulationMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn graph_connect_articulation_matrix_identity(n : Int) -> GraphconnectarticulationMatrix {
  let m = graph_connect_articulation_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn GraphconnectarticulationMatrix::get(self : GraphconnectarticulationMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn GraphconnectarticulationMatrix::transpose(self : GraphconnectarticulationMatrix) -> GraphconnectarticulationMatrix {
  let result = graph_connect_articulation_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn GraphconnectarticulationMatrix::add(self : GraphconnectarticulationMatrix, other : GraphconnectarticulationMatrix) -> GraphconnectarticulationMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = graph_connect_articulation_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn GraphconnectarticulationMatrix::scale(self : GraphconnectarticulationMatrix, s : Double) -> GraphconnectarticulationMatrix {
  let result = graph_connect_articulation_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn GraphconnectarticulationMatrix::multiply(self : GraphconnectarticulationMatrix, other : GraphconnectarticulationMatrix) -> GraphconnectarticulationMatrix {
  if self.cols != other.rows { return graph_connect_articulation_make_matrix(self.rows, other.cols, 0.0) }
  let result = graph_connect_articulation_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn GraphconnectarticulationMatrix::trace(self : GraphconnectarticulationMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn GraphconnectarticulationMatrix::det(self : GraphconnectarticulationMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn GraphconnectarticulationMatrix::norm(self : GraphconnectarticulationMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn GraphconnectarticulationMatrix::to_string(self : GraphconnectarticulationMatrix) -> String {
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

pub(all) struct GraphconnectarticulationVector {
  comps : Array[Double]
  dim : Int
}

pub fn graph_connect_articulation_make_vector(comps : Array[Double]) -> GraphconnectarticulationVector {
  { comps, dim: comps.length() }
}

pub fn graph_connect_articulation_vector_zero(dim : Int) -> GraphconnectarticulationVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn GraphconnectarticulationVector::add(self : GraphconnectarticulationVector, other : GraphconnectarticulationVector) -> GraphconnectarticulationVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn GraphconnectarticulationVector::sub(self : GraphconnectarticulationVector, other : GraphconnectarticulationVector) -> GraphconnectarticulationVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn GraphconnectarticulationVector::scale(self : GraphconnectarticulationVector, s : Double) -> GraphconnectarticulationVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn GraphconnectarticulationVector::dot(self : GraphconnectarticulationVector, other : GraphconnectarticulationVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn GraphconnectarticulationVector::norm(self : GraphconnectarticulationVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn GraphconnectarticulationVector::normalize(self : GraphconnectarticulationVector) -> GraphconnectarticulationVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn GraphconnectarticulationVector::dist(self : GraphconnectarticulationVector, other : GraphconnectarticulationVector) -> Double {
  self.sub(other).norm()
}

pub fn GraphconnectarticulationVector::to_string(self : GraphconnectarticulationVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn graph_connect_articulation_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn graph_connect_articulation_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn graph_connect_articulation_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn graph_connect_articulation_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn graph_connect_articulation_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn graph_connect_articulation_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn graph_connect_articulation_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn graph_connect_articulation_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn graph_connect_articulation_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn graph_connect_articulation_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn graph_connect_articulation_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn graph_connect_articulation_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn graph_connect_articulation_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn graph_connect_articulation_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn graph_connect_articulation_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn graph_connect_articulation_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn graph_connect_articulation_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn graph_connect_articulation_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn graph_connect_articulation_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn graph_connect_articulation_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn graph_connect_articulation_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn graph_connect_articulation_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn graph_connect_articulation_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn graph_connect_articulation_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn graph_connect_articulation_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn graph_connect_articulation_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn graph_connect_articulation_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn graph_connect_articulation_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn graph_connect_articulation_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct GraphconnectarticulationFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_connect_articulation_frame_make(size : Int) -> GraphconnectarticulationFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_connect_articulation_frame_len(s : GraphconnectarticulationFrame) -> Int { s.size }

pub fn graph_connect_articulation_frame_get(s : GraphconnectarticulationFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_connect_articulation_frame_set(s : GraphconnectarticulationFrame, i : Int, v : Double) -> GraphconnectarticulationFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_connect_articulation_frame_sum(s : GraphconnectarticulationFrame) -> Double { @_common.sum(s.data) }

pub fn graph_connect_articulation_frame_mean(s : GraphconnectarticulationFrame) -> Double { @_common.mean(s.data) }

pub fn graph_connect_articulation_frame_scale(s : GraphconnectarticulationFrame, f : Double) -> GraphconnectarticulationFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_connect_articulation_frame_add(a : GraphconnectarticulationFrame, b : GraphconnectarticulationFrame) -> GraphconnectarticulationFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_connect_articulation_frame_copy(s : GraphconnectarticulationFrame) -> GraphconnectarticulationFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_connect_articulation_frame_fill(s : GraphconnectarticulationFrame, v : Double) -> GraphconnectarticulationFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_connect_articulation_frame_min(s : GraphconnectarticulationFrame) -> Double { @_common.min(s.data) }

pub fn graph_connect_articulation_frame_max(s : GraphconnectarticulationFrame) -> Double { @_common.max(s.data) }

pub fn graph_connect_articulation_frame_to_string(s : GraphconnectarticulationFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphconnectarticulationTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_connect_articulation_table_make(size : Int) -> GraphconnectarticulationTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_connect_articulation_table_len(s : GraphconnectarticulationTable) -> Int { s.size }

pub fn graph_connect_articulation_table_get(s : GraphconnectarticulationTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_connect_articulation_table_set(s : GraphconnectarticulationTable, i : Int, v : Double) -> GraphconnectarticulationTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_connect_articulation_table_sum(s : GraphconnectarticulationTable) -> Double { @_common.sum(s.data) }

pub fn graph_connect_articulation_table_mean(s : GraphconnectarticulationTable) -> Double { @_common.mean(s.data) }

pub fn graph_connect_articulation_table_scale(s : GraphconnectarticulationTable, f : Double) -> GraphconnectarticulationTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_connect_articulation_table_add(a : GraphconnectarticulationTable, b : GraphconnectarticulationTable) -> GraphconnectarticulationTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_connect_articulation_table_copy(s : GraphconnectarticulationTable) -> GraphconnectarticulationTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_connect_articulation_table_fill(s : GraphconnectarticulationTable, v : Double) -> GraphconnectarticulationTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_connect_articulation_table_min(s : GraphconnectarticulationTable) -> Double { @_common.min(s.data) }

pub fn graph_connect_articulation_table_max(s : GraphconnectarticulationTable) -> Double { @_common.max(s.data) }

pub fn graph_connect_articulation_table_to_string(s : GraphconnectarticulationTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphconnectarticulationGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_connect_articulation_graphn_make(size : Int) -> GraphconnectarticulationGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_connect_articulation_graphn_len(s : GraphconnectarticulationGraphN) -> Int { s.size }

pub fn graph_connect_articulation_graphn_get(s : GraphconnectarticulationGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_connect_articulation_graphn_set(s : GraphconnectarticulationGraphN, i : Int, v : Double) -> GraphconnectarticulationGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_connect_articulation_graphn_sum(s : GraphconnectarticulationGraphN) -> Double { @_common.sum(s.data) }

pub fn graph_connect_articulation_graphn_mean(s : GraphconnectarticulationGraphN) -> Double { @_common.mean(s.data) }

pub fn graph_connect_articulation_graphn_scale(s : GraphconnectarticulationGraphN, f : Double) -> GraphconnectarticulationGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_connect_articulation_graphn_add(a : GraphconnectarticulationGraphN, b : GraphconnectarticulationGraphN) -> GraphconnectarticulationGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_connect_articulation_graphn_copy(s : GraphconnectarticulationGraphN) -> GraphconnectarticulationGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_connect_articulation_graphn_fill(s : GraphconnectarticulationGraphN, v : Double) -> GraphconnectarticulationGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_connect_articulation_graphn_min(s : GraphconnectarticulationGraphN) -> Double { @_common.min(s.data) }

pub fn graph_connect_articulation_graphn_max(s : GraphconnectarticulationGraphN) -> Double { @_common.max(s.data) }

pub fn graph_connect_articulation_graphn_to_string(s : GraphconnectarticulationGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphconnectarticulationNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_connect_articulation_node_make(size : Int) -> GraphconnectarticulationNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_connect_articulation_node_len(s : GraphconnectarticulationNode) -> Int { s.size }

pub fn graph_connect_articulation_node_get(s : GraphconnectarticulationNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_connect_articulation_node_set(s : GraphconnectarticulationNode, i : Int, v : Double) -> GraphconnectarticulationNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_connect_articulation_node_sum(s : GraphconnectarticulationNode) -> Double { @_common.sum(s.data) }

pub fn graph_connect_articulation_node_mean(s : GraphconnectarticulationNode) -> Double { @_common.mean(s.data) }

pub fn graph_connect_articulation_node_scale(s : GraphconnectarticulationNode, f : Double) -> GraphconnectarticulationNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_connect_articulation_node_add(a : GraphconnectarticulationNode, b : GraphconnectarticulationNode) -> GraphconnectarticulationNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_connect_articulation_node_copy(s : GraphconnectarticulationNode) -> GraphconnectarticulationNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_connect_articulation_node_fill(s : GraphconnectarticulationNode, v : Double) -> GraphconnectarticulationNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_connect_articulation_node_min(s : GraphconnectarticulationNode) -> Double { @_common.min(s.data) }

pub fn graph_connect_articulation_node_max(s : GraphconnectarticulationNode) -> Double { @_common.max(s.data) }

pub fn graph_connect_articulation_node_to_string(s : GraphconnectarticulationNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphconnectarticulationEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_connect_articulation_edge_make(size : Int) -> GraphconnectarticulationEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_connect_articulation_edge_len(s : GraphconnectarticulationEdge) -> Int { s.size }

pub fn graph_connect_articulation_edge_get(s : GraphconnectarticulationEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_connect_articulation_edge_set(s : GraphconnectarticulationEdge, i : Int, v : Double) -> GraphconnectarticulationEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_connect_articulation_edge_sum(s : GraphconnectarticulationEdge) -> Double { @_common.sum(s.data) }

pub fn graph_connect_articulation_edge_mean(s : GraphconnectarticulationEdge) -> Double { @_common.mean(s.data) }

pub fn graph_connect_articulation_edge_scale(s : GraphconnectarticulationEdge, f : Double) -> GraphconnectarticulationEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_connect_articulation_edge_add(a : GraphconnectarticulationEdge, b : GraphconnectarticulationEdge) -> GraphconnectarticulationEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_connect_articulation_edge_copy(s : GraphconnectarticulationEdge) -> GraphconnectarticulationEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_connect_articulation_edge_fill(s : GraphconnectarticulationEdge, v : Double) -> GraphconnectarticulationEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_connect_articulation_edge_min(s : GraphconnectarticulationEdge) -> Double { @_common.min(s.data) }

pub fn graph_connect_articulation_edge_max(s : GraphconnectarticulationEdge) -> Double { @_common.max(s.data) }

pub fn graph_connect_articulation_edge_to_string(s : GraphconnectarticulationEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphconnectarticulationPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_connect_articulation_path_make(size : Int) -> GraphconnectarticulationPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_connect_articulation_path_len(s : GraphconnectarticulationPath) -> Int { s.size }

pub fn graph_connect_articulation_path_get(s : GraphconnectarticulationPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_connect_articulation_path_set(s : GraphconnectarticulationPath, i : Int, v : Double) -> GraphconnectarticulationPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_connect_articulation_path_sum(s : GraphconnectarticulationPath) -> Double { @_common.sum(s.data) }

pub fn graph_connect_articulation_path_mean(s : GraphconnectarticulationPath) -> Double { @_common.mean(s.data) }

pub fn graph_connect_articulation_path_scale(s : GraphconnectarticulationPath, f : Double) -> GraphconnectarticulationPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_connect_articulation_path_add(a : GraphconnectarticulationPath, b : GraphconnectarticulationPath) -> GraphconnectarticulationPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_connect_articulation_path_copy(s : GraphconnectarticulationPath) -> GraphconnectarticulationPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_connect_articulation_path_fill(s : GraphconnectarticulationPath, v : Double) -> GraphconnectarticulationPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_connect_articulation_path_min(s : GraphconnectarticulationPath) -> Double { @_common.min(s.data) }

pub fn graph_connect_articulation_path_max(s : GraphconnectarticulationPath) -> Double { @_common.max(s.data) }

pub fn graph_connect_articulation_path_to_string(s : GraphconnectarticulationPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphconnectarticulationCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_connect_articulation_cluster_make(size : Int) -> GraphconnectarticulationCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_connect_articulation_cluster_len(s : GraphconnectarticulationCluster) -> Int { s.size }

pub fn graph_connect_articulation_cluster_get(s : GraphconnectarticulationCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_connect_articulation_cluster_set(s : GraphconnectarticulationCluster, i : Int, v : Double) -> GraphconnectarticulationCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_connect_articulation_cluster_sum(s : GraphconnectarticulationCluster) -> Double { @_common.sum(s.data) }

pub fn graph_connect_articulation_cluster_mean(s : GraphconnectarticulationCluster) -> Double { @_common.mean(s.data) }

pub fn graph_connect_articulation_cluster_scale(s : GraphconnectarticulationCluster, f : Double) -> GraphconnectarticulationCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_connect_articulation_cluster_add(a : GraphconnectarticulationCluster, b : GraphconnectarticulationCluster) -> GraphconnectarticulationCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_connect_articulation_cluster_copy(s : GraphconnectarticulationCluster) -> GraphconnectarticulationCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_connect_articulation_cluster_fill(s : GraphconnectarticulationCluster, v : Double) -> GraphconnectarticulationCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_connect_articulation_cluster_min(s : GraphconnectarticulationCluster) -> Double { @_common.min(s.data) }

pub fn graph_connect_articulation_cluster_max(s : GraphconnectarticulationCluster) -> Double { @_common.max(s.data) }

pub fn graph_connect_articulation_cluster_to_string(s : GraphconnectarticulationCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphconnectarticulationModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_connect_articulation_model_make(size : Int) -> GraphconnectarticulationModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_connect_articulation_model_len(s : GraphconnectarticulationModel) -> Int { s.size }

pub fn graph_connect_articulation_model_get(s : GraphconnectarticulationModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_connect_articulation_model_set(s : GraphconnectarticulationModel, i : Int, v : Double) -> GraphconnectarticulationModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_connect_articulation_model_sum(s : GraphconnectarticulationModel) -> Double { @_common.sum(s.data) }

pub fn graph_connect_articulation_model_mean(s : GraphconnectarticulationModel) -> Double { @_common.mean(s.data) }

pub fn graph_connect_articulation_model_scale(s : GraphconnectarticulationModel, f : Double) -> GraphconnectarticulationModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_connect_articulation_model_add(a : GraphconnectarticulationModel, b : GraphconnectarticulationModel) -> GraphconnectarticulationModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_connect_articulation_model_copy(s : GraphconnectarticulationModel) -> GraphconnectarticulationModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_connect_articulation_model_fill(s : GraphconnectarticulationModel, v : Double) -> GraphconnectarticulationModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_connect_articulation_model_min(s : GraphconnectarticulationModel) -> Double { @_common.min(s.data) }

pub fn graph_connect_articulation_model_max(s : GraphconnectarticulationModel) -> Double { @_common.max(s.data) }

pub fn graph_connect_articulation_model_to_string(s : GraphconnectarticulationModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphconnectarticulationLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_connect_articulation_layer_make(size : Int) -> GraphconnectarticulationLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_connect_articulation_layer_len(s : GraphconnectarticulationLayer) -> Int { s.size }

pub fn graph_connect_articulation_layer_get(s : GraphconnectarticulationLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_connect_articulation_layer_set(s : GraphconnectarticulationLayer, i : Int, v : Double) -> GraphconnectarticulationLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_connect_articulation_layer_sum(s : GraphconnectarticulationLayer) -> Double { @_common.sum(s.data) }

pub fn graph_connect_articulation_layer_mean(s : GraphconnectarticulationLayer) -> Double { @_common.mean(s.data) }

pub fn graph_connect_articulation_layer_scale(s : GraphconnectarticulationLayer, f : Double) -> GraphconnectarticulationLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_connect_articulation_layer_add(a : GraphconnectarticulationLayer, b : GraphconnectarticulationLayer) -> GraphconnectarticulationLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_connect_articulation_layer_copy(s : GraphconnectarticulationLayer) -> GraphconnectarticulationLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_connect_articulation_layer_fill(s : GraphconnectarticulationLayer, v : Double) -> GraphconnectarticulationLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_connect_articulation_layer_min(s : GraphconnectarticulationLayer) -> Double { @_common.min(s.data) }

pub fn graph_connect_articulation_layer_max(s : GraphconnectarticulationLayer) -> Double { @_common.max(s.data) }

pub fn graph_connect_articulation_layer_to_string(s : GraphconnectarticulationLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphconnectarticulationBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_connect_articulation_buffer_make(size : Int) -> GraphconnectarticulationBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_connect_articulation_buffer_len(s : GraphconnectarticulationBuffer) -> Int { s.size }

pub fn graph_connect_articulation_buffer_get(s : GraphconnectarticulationBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_connect_articulation_buffer_set(s : GraphconnectarticulationBuffer, i : Int, v : Double) -> GraphconnectarticulationBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_connect_articulation_buffer_sum(s : GraphconnectarticulationBuffer) -> Double { @_common.sum(s.data) }

pub fn graph_connect_articulation_buffer_mean(s : GraphconnectarticulationBuffer) -> Double { @_common.mean(s.data) }

pub fn graph_connect_articulation_buffer_scale(s : GraphconnectarticulationBuffer, f : Double) -> GraphconnectarticulationBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_connect_articulation_buffer_add(a : GraphconnectarticulationBuffer, b : GraphconnectarticulationBuffer) -> GraphconnectarticulationBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_connect_articulation_buffer_copy(s : GraphconnectarticulationBuffer) -> GraphconnectarticulationBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_connect_articulation_buffer_fill(s : GraphconnectarticulationBuffer, v : Double) -> GraphconnectarticulationBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_connect_articulation_buffer_min(s : GraphconnectarticulationBuffer) -> Double { @_common.min(s.data) }

pub fn graph_connect_articulation_buffer_max(s : GraphconnectarticulationBuffer) -> Double { @_common.max(s.data) }

pub fn graph_connect_articulation_buffer_to_string(s : GraphconnectarticulationBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphconnectarticulationCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_connect_articulation_cursor_make(size : Int) -> GraphconnectarticulationCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_connect_articulation_cursor_len(s : GraphconnectarticulationCursor) -> Int { s.size }

pub fn graph_connect_articulation_cursor_get(s : GraphconnectarticulationCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_connect_articulation_cursor_set(s : GraphconnectarticulationCursor, i : Int, v : Double) -> GraphconnectarticulationCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_connect_articulation_cursor_sum(s : GraphconnectarticulationCursor) -> Double { @_common.sum(s.data) }

pub fn graph_connect_articulation_cursor_mean(s : GraphconnectarticulationCursor) -> Double { @_common.mean(s.data) }

pub fn graph_connect_articulation_cursor_scale(s : GraphconnectarticulationCursor, f : Double) -> GraphconnectarticulationCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_connect_articulation_cursor_add(a : GraphconnectarticulationCursor, b : GraphconnectarticulationCursor) -> GraphconnectarticulationCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_connect_articulation_cursor_copy(s : GraphconnectarticulationCursor) -> GraphconnectarticulationCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_connect_articulation_cursor_fill(s : GraphconnectarticulationCursor, v : Double) -> GraphconnectarticulationCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_connect_articulation_cursor_min(s : GraphconnectarticulationCursor) -> Double { @_common.min(s.data) }

pub fn graph_connect_articulation_cursor_max(s : GraphconnectarticulationCursor) -> Double { @_common.max(s.data) }

pub fn graph_connect_articulation_cursor_to_string(s : GraphconnectarticulationCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphconnectarticulationView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_connect_articulation_view_make(size : Int) -> GraphconnectarticulationView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_connect_articulation_view_len(s : GraphconnectarticulationView) -> Int { s.size }

pub fn graph_connect_articulation_view_get(s : GraphconnectarticulationView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_connect_articulation_view_set(s : GraphconnectarticulationView, i : Int, v : Double) -> GraphconnectarticulationView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_connect_articulation_view_sum(s : GraphconnectarticulationView) -> Double { @_common.sum(s.data) }

pub fn graph_connect_articulation_view_mean(s : GraphconnectarticulationView) -> Double { @_common.mean(s.data) }

pub fn graph_connect_articulation_view_scale(s : GraphconnectarticulationView, f : Double) -> GraphconnectarticulationView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_connect_articulation_view_add(a : GraphconnectarticulationView, b : GraphconnectarticulationView) -> GraphconnectarticulationView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_connect_articulation_view_copy(s : GraphconnectarticulationView) -> GraphconnectarticulationView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_connect_articulation_view_fill(s : GraphconnectarticulationView, v : Double) -> GraphconnectarticulationView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_connect_articulation_view_min(s : GraphconnectarticulationView) -> Double { @_common.min(s.data) }

pub fn graph_connect_articulation_view_max(s : GraphconnectarticulationView) -> Double { @_common.max(s.data) }

pub fn graph_connect_articulation_view_to_string(s : GraphconnectarticulationView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphconnectarticulationRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_connect_articulation_range_make(size : Int) -> GraphconnectarticulationRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_connect_articulation_range_len(s : GraphconnectarticulationRange) -> Int { s.size }

pub fn graph_connect_articulation_range_get(s : GraphconnectarticulationRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_connect_articulation_range_set(s : GraphconnectarticulationRange, i : Int, v : Double) -> GraphconnectarticulationRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_connect_articulation_range_sum(s : GraphconnectarticulationRange) -> Double { @_common.sum(s.data) }

pub fn graph_connect_articulation_range_mean(s : GraphconnectarticulationRange) -> Double { @_common.mean(s.data) }

pub fn graph_connect_articulation_range_scale(s : GraphconnectarticulationRange, f : Double) -> GraphconnectarticulationRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_connect_articulation_range_add(a : GraphconnectarticulationRange, b : GraphconnectarticulationRange) -> GraphconnectarticulationRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_connect_articulation_range_copy(s : GraphconnectarticulationRange) -> GraphconnectarticulationRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_connect_articulation_range_fill(s : GraphconnectarticulationRange, v : Double) -> GraphconnectarticulationRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_connect_articulation_range_min(s : GraphconnectarticulationRange) -> Double { @_common.min(s.data) }

pub fn graph_connect_articulation_range_max(s : GraphconnectarticulationRange) -> Double { @_common.max(s.data) }

pub fn graph_connect_articulation_range_to_string(s : GraphconnectarticulationRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphconnectarticulationSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_connect_articulation_slice_make(size : Int) -> GraphconnectarticulationSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_connect_articulation_slice_len(s : GraphconnectarticulationSlice) -> Int { s.size }

pub fn graph_connect_articulation_slice_get(s : GraphconnectarticulationSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_connect_articulation_slice_set(s : GraphconnectarticulationSlice, i : Int, v : Double) -> GraphconnectarticulationSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_connect_articulation_slice_sum(s : GraphconnectarticulationSlice) -> Double { @_common.sum(s.data) }

pub fn graph_connect_articulation_slice_mean(s : GraphconnectarticulationSlice) -> Double { @_common.mean(s.data) }

pub fn graph_connect_articulation_slice_scale(s : GraphconnectarticulationSlice, f : Double) -> GraphconnectarticulationSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_connect_articulation_slice_add(a : GraphconnectarticulationSlice, b : GraphconnectarticulationSlice) -> GraphconnectarticulationSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_connect_articulation_slice_copy(s : GraphconnectarticulationSlice) -> GraphconnectarticulationSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_connect_articulation_slice_fill(s : GraphconnectarticulationSlice, v : Double) -> GraphconnectarticulationSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_connect_articulation_slice_min(s : GraphconnectarticulationSlice) -> Double { @_common.min(s.data) }

pub fn graph_connect_articulation_slice_max(s : GraphconnectarticulationSlice) -> Double { @_common.max(s.data) }

pub fn graph_connect_articulation_slice_to_string(s : GraphconnectarticulationSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

