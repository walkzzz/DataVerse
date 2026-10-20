///===
/// extcore/graph_flow_bipartite

pub(all) struct GraphflowbipartitePoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn graph_flow_bipartite_make_point(x : Double, y : Double) -> GraphflowbipartitePoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn graph_flow_bipartite_make_point3(x : Double, y : Double, z : Double) -> GraphflowbipartitePoint {
  { x, y, z, label: 0 }
}

pub fn GraphflowbipartitePoint::x(self : GraphflowbipartitePoint) -> Double { self.x }

pub fn GraphflowbipartitePoint::y(self : GraphflowbipartitePoint) -> Double { self.y }

pub fn GraphflowbipartitePoint::z(self : GraphflowbipartitePoint) -> Double { self.z }

pub fn GraphflowbipartitePoint::label(self : GraphflowbipartitePoint) -> Int { self.label }

pub fn GraphflowbipartitePoint::dist(self : GraphflowbipartitePoint, other : GraphflowbipartitePoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn GraphflowbipartitePoint::add(self : GraphflowbipartitePoint, other : GraphflowbipartitePoint) -> GraphflowbipartitePoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn GraphflowbipartitePoint::sub(self : GraphflowbipartitePoint, other : GraphflowbipartitePoint) -> GraphflowbipartitePoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn GraphflowbipartitePoint::scale(self : GraphflowbipartitePoint, s : Double) -> GraphflowbipartitePoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn GraphflowbipartitePoint::dot(self : GraphflowbipartitePoint, other : GraphflowbipartitePoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn GraphflowbipartitePoint::cross(self : GraphflowbipartitePoint, other : GraphflowbipartitePoint) -> GraphflowbipartitePoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn GraphflowbipartitePoint::norm(self : GraphflowbipartitePoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn GraphflowbipartitePoint::normalize(self : GraphflowbipartitePoint) -> GraphflowbipartitePoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn GraphflowbipartitePoint::negate(self : GraphflowbipartitePoint) -> GraphflowbipartitePoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn GraphflowbipartitePoint::mid(self : GraphflowbipartitePoint, other : GraphflowbipartitePoint) -> GraphflowbipartitePoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn GraphflowbipartitePoint::lerp(self : GraphflowbipartitePoint, other : GraphflowbipartitePoint, t : Double) -> GraphflowbipartitePoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn GraphflowbipartitePoint::to_string(self : GraphflowbipartitePoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct GraphflowbipartiteSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn graph_flow_bipartite_make_series(vals : Array[Double], name : String) -> GraphflowbipartiteSeries {
  { vals, name, meta: 0 }
}

pub fn GraphflowbipartiteSeries::len(self : GraphflowbipartiteSeries) -> Int { self.vals.length() }

pub fn GraphflowbipartiteSeries::sum(self : GraphflowbipartiteSeries) -> Double { @_common.sum(self.vals) }

pub fn GraphflowbipartiteSeries::mean(self : GraphflowbipartiteSeries) -> Double { @_common.mean(self.vals) }

pub fn GraphflowbipartiteSeries::min(self : GraphflowbipartiteSeries) -> Double { @_common.min(self.vals) }

pub fn GraphflowbipartiteSeries::max(self : GraphflowbipartiteSeries) -> Double { @_common.max(self.vals) }

pub fn GraphflowbipartiteSeries::range(self : GraphflowbipartiteSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn GraphflowbipartiteSeries::variance(self : GraphflowbipartiteSeries) -> Double { @_common.variance(self.vals) }

pub fn GraphflowbipartiteSeries::std(self : GraphflowbipartiteSeries) -> Double { @_common.std(self.vals) }

pub fn GraphflowbipartiteSeries::median(self : GraphflowbipartiteSeries) -> Double { @_common.median(self.vals) }

pub fn GraphflowbipartiteSeries::scale(self : GraphflowbipartiteSeries, f : Double) -> GraphflowbipartiteSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn GraphflowbipartiteSeries::add(self : GraphflowbipartiteSeries, other : GraphflowbipartiteSeries) -> GraphflowbipartiteSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn GraphflowbipartiteSeries::sub(self : GraphflowbipartiteSeries, other : GraphflowbipartiteSeries) -> GraphflowbipartiteSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn GraphflowbipartiteSeries::normalize(self : GraphflowbipartiteSeries) -> GraphflowbipartiteSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn GraphflowbipartiteSeries::cumsum(self : GraphflowbipartiteSeries) -> GraphflowbipartiteSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn GraphflowbipartiteSeries::to_string(self : GraphflowbipartiteSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct GraphflowbipartiteMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn graph_flow_bipartite_make_matrix(rows : Int, cols : Int, val : Double) -> GraphflowbipartiteMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn graph_flow_bipartite_matrix_identity(n : Int) -> GraphflowbipartiteMatrix {
  let m = graph_flow_bipartite_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn GraphflowbipartiteMatrix::get(self : GraphflowbipartiteMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn GraphflowbipartiteMatrix::transpose(self : GraphflowbipartiteMatrix) -> GraphflowbipartiteMatrix {
  let result = graph_flow_bipartite_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn GraphflowbipartiteMatrix::add(self : GraphflowbipartiteMatrix, other : GraphflowbipartiteMatrix) -> GraphflowbipartiteMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = graph_flow_bipartite_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn GraphflowbipartiteMatrix::scale(self : GraphflowbipartiteMatrix, s : Double) -> GraphflowbipartiteMatrix {
  let result = graph_flow_bipartite_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn GraphflowbipartiteMatrix::multiply(self : GraphflowbipartiteMatrix, other : GraphflowbipartiteMatrix) -> GraphflowbipartiteMatrix {
  if self.cols != other.rows { return graph_flow_bipartite_make_matrix(self.rows, other.cols, 0.0) }
  let result = graph_flow_bipartite_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn GraphflowbipartiteMatrix::trace(self : GraphflowbipartiteMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn GraphflowbipartiteMatrix::det(self : GraphflowbipartiteMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn GraphflowbipartiteMatrix::norm(self : GraphflowbipartiteMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn GraphflowbipartiteMatrix::to_string(self : GraphflowbipartiteMatrix) -> String {
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

pub(all) struct GraphflowbipartiteVector {
  comps : Array[Double]
  dim : Int
}

pub fn graph_flow_bipartite_make_vector(comps : Array[Double]) -> GraphflowbipartiteVector {
  { comps, dim: comps.length() }
}

pub fn graph_flow_bipartite_vector_zero(dim : Int) -> GraphflowbipartiteVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn GraphflowbipartiteVector::add(self : GraphflowbipartiteVector, other : GraphflowbipartiteVector) -> GraphflowbipartiteVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn GraphflowbipartiteVector::sub(self : GraphflowbipartiteVector, other : GraphflowbipartiteVector) -> GraphflowbipartiteVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn GraphflowbipartiteVector::scale(self : GraphflowbipartiteVector, s : Double) -> GraphflowbipartiteVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn GraphflowbipartiteVector::dot(self : GraphflowbipartiteVector, other : GraphflowbipartiteVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn GraphflowbipartiteVector::norm(self : GraphflowbipartiteVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn GraphflowbipartiteVector::normalize(self : GraphflowbipartiteVector) -> GraphflowbipartiteVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn GraphflowbipartiteVector::dist(self : GraphflowbipartiteVector, other : GraphflowbipartiteVector) -> Double {
  self.sub(other).norm()
}

pub fn GraphflowbipartiteVector::to_string(self : GraphflowbipartiteVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn graph_flow_bipartite_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn graph_flow_bipartite_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn graph_flow_bipartite_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn graph_flow_bipartite_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn graph_flow_bipartite_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn graph_flow_bipartite_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn graph_flow_bipartite_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn graph_flow_bipartite_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn graph_flow_bipartite_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn graph_flow_bipartite_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn graph_flow_bipartite_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn graph_flow_bipartite_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn graph_flow_bipartite_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn graph_flow_bipartite_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn graph_flow_bipartite_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn graph_flow_bipartite_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn graph_flow_bipartite_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn graph_flow_bipartite_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn graph_flow_bipartite_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn graph_flow_bipartite_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn graph_flow_bipartite_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn graph_flow_bipartite_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn graph_flow_bipartite_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn graph_flow_bipartite_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn graph_flow_bipartite_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn graph_flow_bipartite_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn graph_flow_bipartite_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn graph_flow_bipartite_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn graph_flow_bipartite_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct GraphflowbipartiteFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_flow_bipartite_frame_make(size : Int) -> GraphflowbipartiteFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_flow_bipartite_frame_len(s : GraphflowbipartiteFrame) -> Int { s.size }

pub fn graph_flow_bipartite_frame_get(s : GraphflowbipartiteFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_flow_bipartite_frame_set(s : GraphflowbipartiteFrame, i : Int, v : Double) -> GraphflowbipartiteFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_flow_bipartite_frame_sum(s : GraphflowbipartiteFrame) -> Double { @_common.sum(s.data) }

pub fn graph_flow_bipartite_frame_mean(s : GraphflowbipartiteFrame) -> Double { @_common.mean(s.data) }

pub fn graph_flow_bipartite_frame_scale(s : GraphflowbipartiteFrame, f : Double) -> GraphflowbipartiteFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_flow_bipartite_frame_add(a : GraphflowbipartiteFrame, b : GraphflowbipartiteFrame) -> GraphflowbipartiteFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_flow_bipartite_frame_copy(s : GraphflowbipartiteFrame) -> GraphflowbipartiteFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_flow_bipartite_frame_fill(s : GraphflowbipartiteFrame, v : Double) -> GraphflowbipartiteFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_flow_bipartite_frame_min(s : GraphflowbipartiteFrame) -> Double { @_common.min(s.data) }

pub fn graph_flow_bipartite_frame_max(s : GraphflowbipartiteFrame) -> Double { @_common.max(s.data) }

pub fn graph_flow_bipartite_frame_to_string(s : GraphflowbipartiteFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphflowbipartiteTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_flow_bipartite_table_make(size : Int) -> GraphflowbipartiteTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_flow_bipartite_table_len(s : GraphflowbipartiteTable) -> Int { s.size }

pub fn graph_flow_bipartite_table_get(s : GraphflowbipartiteTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_flow_bipartite_table_set(s : GraphflowbipartiteTable, i : Int, v : Double) -> GraphflowbipartiteTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_flow_bipartite_table_sum(s : GraphflowbipartiteTable) -> Double { @_common.sum(s.data) }

pub fn graph_flow_bipartite_table_mean(s : GraphflowbipartiteTable) -> Double { @_common.mean(s.data) }

pub fn graph_flow_bipartite_table_scale(s : GraphflowbipartiteTable, f : Double) -> GraphflowbipartiteTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_flow_bipartite_table_add(a : GraphflowbipartiteTable, b : GraphflowbipartiteTable) -> GraphflowbipartiteTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_flow_bipartite_table_copy(s : GraphflowbipartiteTable) -> GraphflowbipartiteTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_flow_bipartite_table_fill(s : GraphflowbipartiteTable, v : Double) -> GraphflowbipartiteTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_flow_bipartite_table_min(s : GraphflowbipartiteTable) -> Double { @_common.min(s.data) }

pub fn graph_flow_bipartite_table_max(s : GraphflowbipartiteTable) -> Double { @_common.max(s.data) }

pub fn graph_flow_bipartite_table_to_string(s : GraphflowbipartiteTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphflowbipartiteGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_flow_bipartite_graphn_make(size : Int) -> GraphflowbipartiteGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_flow_bipartite_graphn_len(s : GraphflowbipartiteGraphN) -> Int { s.size }

pub fn graph_flow_bipartite_graphn_get(s : GraphflowbipartiteGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_flow_bipartite_graphn_set(s : GraphflowbipartiteGraphN, i : Int, v : Double) -> GraphflowbipartiteGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_flow_bipartite_graphn_sum(s : GraphflowbipartiteGraphN) -> Double { @_common.sum(s.data) }

pub fn graph_flow_bipartite_graphn_mean(s : GraphflowbipartiteGraphN) -> Double { @_common.mean(s.data) }

pub fn graph_flow_bipartite_graphn_scale(s : GraphflowbipartiteGraphN, f : Double) -> GraphflowbipartiteGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_flow_bipartite_graphn_add(a : GraphflowbipartiteGraphN, b : GraphflowbipartiteGraphN) -> GraphflowbipartiteGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_flow_bipartite_graphn_copy(s : GraphflowbipartiteGraphN) -> GraphflowbipartiteGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_flow_bipartite_graphn_fill(s : GraphflowbipartiteGraphN, v : Double) -> GraphflowbipartiteGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_flow_bipartite_graphn_min(s : GraphflowbipartiteGraphN) -> Double { @_common.min(s.data) }

pub fn graph_flow_bipartite_graphn_max(s : GraphflowbipartiteGraphN) -> Double { @_common.max(s.data) }

pub fn graph_flow_bipartite_graphn_to_string(s : GraphflowbipartiteGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphflowbipartiteNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_flow_bipartite_node_make(size : Int) -> GraphflowbipartiteNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_flow_bipartite_node_len(s : GraphflowbipartiteNode) -> Int { s.size }

pub fn graph_flow_bipartite_node_get(s : GraphflowbipartiteNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_flow_bipartite_node_set(s : GraphflowbipartiteNode, i : Int, v : Double) -> GraphflowbipartiteNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_flow_bipartite_node_sum(s : GraphflowbipartiteNode) -> Double { @_common.sum(s.data) }

pub fn graph_flow_bipartite_node_mean(s : GraphflowbipartiteNode) -> Double { @_common.mean(s.data) }

pub fn graph_flow_bipartite_node_scale(s : GraphflowbipartiteNode, f : Double) -> GraphflowbipartiteNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_flow_bipartite_node_add(a : GraphflowbipartiteNode, b : GraphflowbipartiteNode) -> GraphflowbipartiteNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_flow_bipartite_node_copy(s : GraphflowbipartiteNode) -> GraphflowbipartiteNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_flow_bipartite_node_fill(s : GraphflowbipartiteNode, v : Double) -> GraphflowbipartiteNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_flow_bipartite_node_min(s : GraphflowbipartiteNode) -> Double { @_common.min(s.data) }

pub fn graph_flow_bipartite_node_max(s : GraphflowbipartiteNode) -> Double { @_common.max(s.data) }

pub fn graph_flow_bipartite_node_to_string(s : GraphflowbipartiteNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphflowbipartiteEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_flow_bipartite_edge_make(size : Int) -> GraphflowbipartiteEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_flow_bipartite_edge_len(s : GraphflowbipartiteEdge) -> Int { s.size }

pub fn graph_flow_bipartite_edge_get(s : GraphflowbipartiteEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_flow_bipartite_edge_set(s : GraphflowbipartiteEdge, i : Int, v : Double) -> GraphflowbipartiteEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_flow_bipartite_edge_sum(s : GraphflowbipartiteEdge) -> Double { @_common.sum(s.data) }

pub fn graph_flow_bipartite_edge_mean(s : GraphflowbipartiteEdge) -> Double { @_common.mean(s.data) }

pub fn graph_flow_bipartite_edge_scale(s : GraphflowbipartiteEdge, f : Double) -> GraphflowbipartiteEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_flow_bipartite_edge_add(a : GraphflowbipartiteEdge, b : GraphflowbipartiteEdge) -> GraphflowbipartiteEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_flow_bipartite_edge_copy(s : GraphflowbipartiteEdge) -> GraphflowbipartiteEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_flow_bipartite_edge_fill(s : GraphflowbipartiteEdge, v : Double) -> GraphflowbipartiteEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_flow_bipartite_edge_min(s : GraphflowbipartiteEdge) -> Double { @_common.min(s.data) }

pub fn graph_flow_bipartite_edge_max(s : GraphflowbipartiteEdge) -> Double { @_common.max(s.data) }

pub fn graph_flow_bipartite_edge_to_string(s : GraphflowbipartiteEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphflowbipartitePath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_flow_bipartite_path_make(size : Int) -> GraphflowbipartitePath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_flow_bipartite_path_len(s : GraphflowbipartitePath) -> Int { s.size }

pub fn graph_flow_bipartite_path_get(s : GraphflowbipartitePath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_flow_bipartite_path_set(s : GraphflowbipartitePath, i : Int, v : Double) -> GraphflowbipartitePath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_flow_bipartite_path_sum(s : GraphflowbipartitePath) -> Double { @_common.sum(s.data) }

pub fn graph_flow_bipartite_path_mean(s : GraphflowbipartitePath) -> Double { @_common.mean(s.data) }

pub fn graph_flow_bipartite_path_scale(s : GraphflowbipartitePath, f : Double) -> GraphflowbipartitePath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_flow_bipartite_path_add(a : GraphflowbipartitePath, b : GraphflowbipartitePath) -> GraphflowbipartitePath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_flow_bipartite_path_copy(s : GraphflowbipartitePath) -> GraphflowbipartitePath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_flow_bipartite_path_fill(s : GraphflowbipartitePath, v : Double) -> GraphflowbipartitePath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_flow_bipartite_path_min(s : GraphflowbipartitePath) -> Double { @_common.min(s.data) }

pub fn graph_flow_bipartite_path_max(s : GraphflowbipartitePath) -> Double { @_common.max(s.data) }

pub fn graph_flow_bipartite_path_to_string(s : GraphflowbipartitePath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphflowbipartiteCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_flow_bipartite_cluster_make(size : Int) -> GraphflowbipartiteCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_flow_bipartite_cluster_len(s : GraphflowbipartiteCluster) -> Int { s.size }

pub fn graph_flow_bipartite_cluster_get(s : GraphflowbipartiteCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_flow_bipartite_cluster_set(s : GraphflowbipartiteCluster, i : Int, v : Double) -> GraphflowbipartiteCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_flow_bipartite_cluster_sum(s : GraphflowbipartiteCluster) -> Double { @_common.sum(s.data) }

pub fn graph_flow_bipartite_cluster_mean(s : GraphflowbipartiteCluster) -> Double { @_common.mean(s.data) }

pub fn graph_flow_bipartite_cluster_scale(s : GraphflowbipartiteCluster, f : Double) -> GraphflowbipartiteCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_flow_bipartite_cluster_add(a : GraphflowbipartiteCluster, b : GraphflowbipartiteCluster) -> GraphflowbipartiteCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_flow_bipartite_cluster_copy(s : GraphflowbipartiteCluster) -> GraphflowbipartiteCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_flow_bipartite_cluster_fill(s : GraphflowbipartiteCluster, v : Double) -> GraphflowbipartiteCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_flow_bipartite_cluster_min(s : GraphflowbipartiteCluster) -> Double { @_common.min(s.data) }

pub fn graph_flow_bipartite_cluster_max(s : GraphflowbipartiteCluster) -> Double { @_common.max(s.data) }

pub fn graph_flow_bipartite_cluster_to_string(s : GraphflowbipartiteCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphflowbipartiteModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_flow_bipartite_model_make(size : Int) -> GraphflowbipartiteModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_flow_bipartite_model_len(s : GraphflowbipartiteModel) -> Int { s.size }

pub fn graph_flow_bipartite_model_get(s : GraphflowbipartiteModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_flow_bipartite_model_set(s : GraphflowbipartiteModel, i : Int, v : Double) -> GraphflowbipartiteModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_flow_bipartite_model_sum(s : GraphflowbipartiteModel) -> Double { @_common.sum(s.data) }

pub fn graph_flow_bipartite_model_mean(s : GraphflowbipartiteModel) -> Double { @_common.mean(s.data) }

pub fn graph_flow_bipartite_model_scale(s : GraphflowbipartiteModel, f : Double) -> GraphflowbipartiteModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_flow_bipartite_model_add(a : GraphflowbipartiteModel, b : GraphflowbipartiteModel) -> GraphflowbipartiteModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_flow_bipartite_model_copy(s : GraphflowbipartiteModel) -> GraphflowbipartiteModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_flow_bipartite_model_fill(s : GraphflowbipartiteModel, v : Double) -> GraphflowbipartiteModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_flow_bipartite_model_min(s : GraphflowbipartiteModel) -> Double { @_common.min(s.data) }

pub fn graph_flow_bipartite_model_max(s : GraphflowbipartiteModel) -> Double { @_common.max(s.data) }

pub fn graph_flow_bipartite_model_to_string(s : GraphflowbipartiteModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphflowbipartiteLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_flow_bipartite_layer_make(size : Int) -> GraphflowbipartiteLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_flow_bipartite_layer_len(s : GraphflowbipartiteLayer) -> Int { s.size }

pub fn graph_flow_bipartite_layer_get(s : GraphflowbipartiteLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_flow_bipartite_layer_set(s : GraphflowbipartiteLayer, i : Int, v : Double) -> GraphflowbipartiteLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_flow_bipartite_layer_sum(s : GraphflowbipartiteLayer) -> Double { @_common.sum(s.data) }

pub fn graph_flow_bipartite_layer_mean(s : GraphflowbipartiteLayer) -> Double { @_common.mean(s.data) }

pub fn graph_flow_bipartite_layer_scale(s : GraphflowbipartiteLayer, f : Double) -> GraphflowbipartiteLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_flow_bipartite_layer_add(a : GraphflowbipartiteLayer, b : GraphflowbipartiteLayer) -> GraphflowbipartiteLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_flow_bipartite_layer_copy(s : GraphflowbipartiteLayer) -> GraphflowbipartiteLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_flow_bipartite_layer_fill(s : GraphflowbipartiteLayer, v : Double) -> GraphflowbipartiteLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_flow_bipartite_layer_min(s : GraphflowbipartiteLayer) -> Double { @_common.min(s.data) }

pub fn graph_flow_bipartite_layer_max(s : GraphflowbipartiteLayer) -> Double { @_common.max(s.data) }

pub fn graph_flow_bipartite_layer_to_string(s : GraphflowbipartiteLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphflowbipartiteBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_flow_bipartite_buffer_make(size : Int) -> GraphflowbipartiteBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_flow_bipartite_buffer_len(s : GraphflowbipartiteBuffer) -> Int { s.size }

pub fn graph_flow_bipartite_buffer_get(s : GraphflowbipartiteBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_flow_bipartite_buffer_set(s : GraphflowbipartiteBuffer, i : Int, v : Double) -> GraphflowbipartiteBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_flow_bipartite_buffer_sum(s : GraphflowbipartiteBuffer) -> Double { @_common.sum(s.data) }

pub fn graph_flow_bipartite_buffer_mean(s : GraphflowbipartiteBuffer) -> Double { @_common.mean(s.data) }

pub fn graph_flow_bipartite_buffer_scale(s : GraphflowbipartiteBuffer, f : Double) -> GraphflowbipartiteBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_flow_bipartite_buffer_add(a : GraphflowbipartiteBuffer, b : GraphflowbipartiteBuffer) -> GraphflowbipartiteBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_flow_bipartite_buffer_copy(s : GraphflowbipartiteBuffer) -> GraphflowbipartiteBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_flow_bipartite_buffer_fill(s : GraphflowbipartiteBuffer, v : Double) -> GraphflowbipartiteBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_flow_bipartite_buffer_min(s : GraphflowbipartiteBuffer) -> Double { @_common.min(s.data) }

pub fn graph_flow_bipartite_buffer_max(s : GraphflowbipartiteBuffer) -> Double { @_common.max(s.data) }

pub fn graph_flow_bipartite_buffer_to_string(s : GraphflowbipartiteBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphflowbipartiteCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_flow_bipartite_cursor_make(size : Int) -> GraphflowbipartiteCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_flow_bipartite_cursor_len(s : GraphflowbipartiteCursor) -> Int { s.size }

pub fn graph_flow_bipartite_cursor_get(s : GraphflowbipartiteCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_flow_bipartite_cursor_set(s : GraphflowbipartiteCursor, i : Int, v : Double) -> GraphflowbipartiteCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_flow_bipartite_cursor_sum(s : GraphflowbipartiteCursor) -> Double { @_common.sum(s.data) }

pub fn graph_flow_bipartite_cursor_mean(s : GraphflowbipartiteCursor) -> Double { @_common.mean(s.data) }

pub fn graph_flow_bipartite_cursor_scale(s : GraphflowbipartiteCursor, f : Double) -> GraphflowbipartiteCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_flow_bipartite_cursor_add(a : GraphflowbipartiteCursor, b : GraphflowbipartiteCursor) -> GraphflowbipartiteCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_flow_bipartite_cursor_copy(s : GraphflowbipartiteCursor) -> GraphflowbipartiteCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_flow_bipartite_cursor_fill(s : GraphflowbipartiteCursor, v : Double) -> GraphflowbipartiteCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_flow_bipartite_cursor_min(s : GraphflowbipartiteCursor) -> Double { @_common.min(s.data) }

pub fn graph_flow_bipartite_cursor_max(s : GraphflowbipartiteCursor) -> Double { @_common.max(s.data) }

pub fn graph_flow_bipartite_cursor_to_string(s : GraphflowbipartiteCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphflowbipartiteView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_flow_bipartite_view_make(size : Int) -> GraphflowbipartiteView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_flow_bipartite_view_len(s : GraphflowbipartiteView) -> Int { s.size }

pub fn graph_flow_bipartite_view_get(s : GraphflowbipartiteView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_flow_bipartite_view_set(s : GraphflowbipartiteView, i : Int, v : Double) -> GraphflowbipartiteView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_flow_bipartite_view_sum(s : GraphflowbipartiteView) -> Double { @_common.sum(s.data) }

pub fn graph_flow_bipartite_view_mean(s : GraphflowbipartiteView) -> Double { @_common.mean(s.data) }

pub fn graph_flow_bipartite_view_scale(s : GraphflowbipartiteView, f : Double) -> GraphflowbipartiteView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_flow_bipartite_view_add(a : GraphflowbipartiteView, b : GraphflowbipartiteView) -> GraphflowbipartiteView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_flow_bipartite_view_copy(s : GraphflowbipartiteView) -> GraphflowbipartiteView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_flow_bipartite_view_fill(s : GraphflowbipartiteView, v : Double) -> GraphflowbipartiteView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_flow_bipartite_view_min(s : GraphflowbipartiteView) -> Double { @_common.min(s.data) }

pub fn graph_flow_bipartite_view_max(s : GraphflowbipartiteView) -> Double { @_common.max(s.data) }

pub fn graph_flow_bipartite_view_to_string(s : GraphflowbipartiteView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphflowbipartiteRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_flow_bipartite_range_make(size : Int) -> GraphflowbipartiteRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_flow_bipartite_range_len(s : GraphflowbipartiteRange) -> Int { s.size }

pub fn graph_flow_bipartite_range_get(s : GraphflowbipartiteRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_flow_bipartite_range_set(s : GraphflowbipartiteRange, i : Int, v : Double) -> GraphflowbipartiteRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_flow_bipartite_range_sum(s : GraphflowbipartiteRange) -> Double { @_common.sum(s.data) }

pub fn graph_flow_bipartite_range_mean(s : GraphflowbipartiteRange) -> Double { @_common.mean(s.data) }

pub fn graph_flow_bipartite_range_scale(s : GraphflowbipartiteRange, f : Double) -> GraphflowbipartiteRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_flow_bipartite_range_add(a : GraphflowbipartiteRange, b : GraphflowbipartiteRange) -> GraphflowbipartiteRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_flow_bipartite_range_copy(s : GraphflowbipartiteRange) -> GraphflowbipartiteRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_flow_bipartite_range_fill(s : GraphflowbipartiteRange, v : Double) -> GraphflowbipartiteRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_flow_bipartite_range_min(s : GraphflowbipartiteRange) -> Double { @_common.min(s.data) }

pub fn graph_flow_bipartite_range_max(s : GraphflowbipartiteRange) -> Double { @_common.max(s.data) }

pub fn graph_flow_bipartite_range_to_string(s : GraphflowbipartiteRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphflowbipartiteSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_flow_bipartite_slice_make(size : Int) -> GraphflowbipartiteSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_flow_bipartite_slice_len(s : GraphflowbipartiteSlice) -> Int { s.size }

pub fn graph_flow_bipartite_slice_get(s : GraphflowbipartiteSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_flow_bipartite_slice_set(s : GraphflowbipartiteSlice, i : Int, v : Double) -> GraphflowbipartiteSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_flow_bipartite_slice_sum(s : GraphflowbipartiteSlice) -> Double { @_common.sum(s.data) }

pub fn graph_flow_bipartite_slice_mean(s : GraphflowbipartiteSlice) -> Double { @_common.mean(s.data) }

pub fn graph_flow_bipartite_slice_scale(s : GraphflowbipartiteSlice, f : Double) -> GraphflowbipartiteSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_flow_bipartite_slice_add(a : GraphflowbipartiteSlice, b : GraphflowbipartiteSlice) -> GraphflowbipartiteSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_flow_bipartite_slice_copy(s : GraphflowbipartiteSlice) -> GraphflowbipartiteSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_flow_bipartite_slice_fill(s : GraphflowbipartiteSlice, v : Double) -> GraphflowbipartiteSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_flow_bipartite_slice_min(s : GraphflowbipartiteSlice) -> Double { @_common.min(s.data) }

pub fn graph_flow_bipartite_slice_max(s : GraphflowbipartiteSlice) -> Double { @_common.max(s.data) }

pub fn graph_flow_bipartite_slice_to_string(s : GraphflowbipartiteSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

