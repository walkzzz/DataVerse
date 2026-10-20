///===
/// extcore/graph_search_bfs

pub(all) struct GraphsearchbfsPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn graph_search_bfs_make_point(x : Double, y : Double) -> GraphsearchbfsPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn graph_search_bfs_make_point3(x : Double, y : Double, z : Double) -> GraphsearchbfsPoint {
  { x, y, z, label: 0 }
}

pub fn GraphsearchbfsPoint::x(self : GraphsearchbfsPoint) -> Double { self.x }

pub fn GraphsearchbfsPoint::y(self : GraphsearchbfsPoint) -> Double { self.y }

pub fn GraphsearchbfsPoint::z(self : GraphsearchbfsPoint) -> Double { self.z }

pub fn GraphsearchbfsPoint::label(self : GraphsearchbfsPoint) -> Int { self.label }

pub fn GraphsearchbfsPoint::dist(self : GraphsearchbfsPoint, other : GraphsearchbfsPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn GraphsearchbfsPoint::add(self : GraphsearchbfsPoint, other : GraphsearchbfsPoint) -> GraphsearchbfsPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn GraphsearchbfsPoint::sub(self : GraphsearchbfsPoint, other : GraphsearchbfsPoint) -> GraphsearchbfsPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn GraphsearchbfsPoint::scale(self : GraphsearchbfsPoint, s : Double) -> GraphsearchbfsPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn GraphsearchbfsPoint::dot(self : GraphsearchbfsPoint, other : GraphsearchbfsPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn GraphsearchbfsPoint::cross(self : GraphsearchbfsPoint, other : GraphsearchbfsPoint) -> GraphsearchbfsPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn GraphsearchbfsPoint::norm(self : GraphsearchbfsPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn GraphsearchbfsPoint::normalize(self : GraphsearchbfsPoint) -> GraphsearchbfsPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn GraphsearchbfsPoint::negate(self : GraphsearchbfsPoint) -> GraphsearchbfsPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn GraphsearchbfsPoint::mid(self : GraphsearchbfsPoint, other : GraphsearchbfsPoint) -> GraphsearchbfsPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn GraphsearchbfsPoint::lerp(self : GraphsearchbfsPoint, other : GraphsearchbfsPoint, t : Double) -> GraphsearchbfsPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn GraphsearchbfsPoint::to_string(self : GraphsearchbfsPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct GraphsearchbfsSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn graph_search_bfs_make_series(vals : Array[Double], name : String) -> GraphsearchbfsSeries {
  { vals, name, meta: 0 }
}

pub fn GraphsearchbfsSeries::len(self : GraphsearchbfsSeries) -> Int { self.vals.length() }

pub fn GraphsearchbfsSeries::sum(self : GraphsearchbfsSeries) -> Double { @_common.sum(self.vals) }

pub fn GraphsearchbfsSeries::mean(self : GraphsearchbfsSeries) -> Double { @_common.mean(self.vals) }

pub fn GraphsearchbfsSeries::min(self : GraphsearchbfsSeries) -> Double { @_common.min(self.vals) }

pub fn GraphsearchbfsSeries::max(self : GraphsearchbfsSeries) -> Double { @_common.max(self.vals) }

pub fn GraphsearchbfsSeries::range(self : GraphsearchbfsSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn GraphsearchbfsSeries::variance(self : GraphsearchbfsSeries) -> Double { @_common.variance(self.vals) }

pub fn GraphsearchbfsSeries::std(self : GraphsearchbfsSeries) -> Double { @_common.std(self.vals) }

pub fn GraphsearchbfsSeries::median(self : GraphsearchbfsSeries) -> Double { @_common.median(self.vals) }

pub fn GraphsearchbfsSeries::scale(self : GraphsearchbfsSeries, f : Double) -> GraphsearchbfsSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn GraphsearchbfsSeries::add(self : GraphsearchbfsSeries, other : GraphsearchbfsSeries) -> GraphsearchbfsSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn GraphsearchbfsSeries::sub(self : GraphsearchbfsSeries, other : GraphsearchbfsSeries) -> GraphsearchbfsSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn GraphsearchbfsSeries::normalize(self : GraphsearchbfsSeries) -> GraphsearchbfsSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn GraphsearchbfsSeries::cumsum(self : GraphsearchbfsSeries) -> GraphsearchbfsSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn GraphsearchbfsSeries::to_string(self : GraphsearchbfsSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct GraphsearchbfsMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn graph_search_bfs_make_matrix(rows : Int, cols : Int, val : Double) -> GraphsearchbfsMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn graph_search_bfs_matrix_identity(n : Int) -> GraphsearchbfsMatrix {
  let m = graph_search_bfs_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn GraphsearchbfsMatrix::get(self : GraphsearchbfsMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn GraphsearchbfsMatrix::transpose(self : GraphsearchbfsMatrix) -> GraphsearchbfsMatrix {
  let result = graph_search_bfs_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn GraphsearchbfsMatrix::add(self : GraphsearchbfsMatrix, other : GraphsearchbfsMatrix) -> GraphsearchbfsMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = graph_search_bfs_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn GraphsearchbfsMatrix::scale(self : GraphsearchbfsMatrix, s : Double) -> GraphsearchbfsMatrix {
  let result = graph_search_bfs_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn GraphsearchbfsMatrix::multiply(self : GraphsearchbfsMatrix, other : GraphsearchbfsMatrix) -> GraphsearchbfsMatrix {
  if self.cols != other.rows { return graph_search_bfs_make_matrix(self.rows, other.cols, 0.0) }
  let result = graph_search_bfs_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn GraphsearchbfsMatrix::trace(self : GraphsearchbfsMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn GraphsearchbfsMatrix::det(self : GraphsearchbfsMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn GraphsearchbfsMatrix::norm(self : GraphsearchbfsMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn GraphsearchbfsMatrix::to_string(self : GraphsearchbfsMatrix) -> String {
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

pub(all) struct GraphsearchbfsVector {
  comps : Array[Double]
  dim : Int
}

pub fn graph_search_bfs_make_vector(comps : Array[Double]) -> GraphsearchbfsVector {
  { comps, dim: comps.length() }
}

pub fn graph_search_bfs_vector_zero(dim : Int) -> GraphsearchbfsVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn GraphsearchbfsVector::add(self : GraphsearchbfsVector, other : GraphsearchbfsVector) -> GraphsearchbfsVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn GraphsearchbfsVector::sub(self : GraphsearchbfsVector, other : GraphsearchbfsVector) -> GraphsearchbfsVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn GraphsearchbfsVector::scale(self : GraphsearchbfsVector, s : Double) -> GraphsearchbfsVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn GraphsearchbfsVector::dot(self : GraphsearchbfsVector, other : GraphsearchbfsVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn GraphsearchbfsVector::norm(self : GraphsearchbfsVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn GraphsearchbfsVector::normalize(self : GraphsearchbfsVector) -> GraphsearchbfsVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn GraphsearchbfsVector::dist(self : GraphsearchbfsVector, other : GraphsearchbfsVector) -> Double {
  self.sub(other).norm()
}

pub fn GraphsearchbfsVector::to_string(self : GraphsearchbfsVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn graph_search_bfs_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn graph_search_bfs_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn graph_search_bfs_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn graph_search_bfs_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn graph_search_bfs_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn graph_search_bfs_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn graph_search_bfs_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn graph_search_bfs_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn graph_search_bfs_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn graph_search_bfs_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn graph_search_bfs_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn graph_search_bfs_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn graph_search_bfs_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn graph_search_bfs_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn graph_search_bfs_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn graph_search_bfs_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn graph_search_bfs_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn graph_search_bfs_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn graph_search_bfs_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn graph_search_bfs_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn graph_search_bfs_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn graph_search_bfs_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn graph_search_bfs_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn graph_search_bfs_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn graph_search_bfs_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn graph_search_bfs_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn graph_search_bfs_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn graph_search_bfs_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn graph_search_bfs_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct GraphsearchbfsFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_search_bfs_frame_make(size : Int) -> GraphsearchbfsFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_search_bfs_frame_len(s : GraphsearchbfsFrame) -> Int { s.size }

pub fn graph_search_bfs_frame_get(s : GraphsearchbfsFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_search_bfs_frame_set(s : GraphsearchbfsFrame, i : Int, v : Double) -> GraphsearchbfsFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_search_bfs_frame_sum(s : GraphsearchbfsFrame) -> Double { @_common.sum(s.data) }

pub fn graph_search_bfs_frame_mean(s : GraphsearchbfsFrame) -> Double { @_common.mean(s.data) }

pub fn graph_search_bfs_frame_scale(s : GraphsearchbfsFrame, f : Double) -> GraphsearchbfsFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_search_bfs_frame_add(a : GraphsearchbfsFrame, b : GraphsearchbfsFrame) -> GraphsearchbfsFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_search_bfs_frame_copy(s : GraphsearchbfsFrame) -> GraphsearchbfsFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_search_bfs_frame_fill(s : GraphsearchbfsFrame, v : Double) -> GraphsearchbfsFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_search_bfs_frame_min(s : GraphsearchbfsFrame) -> Double { @_common.min(s.data) }

pub fn graph_search_bfs_frame_max(s : GraphsearchbfsFrame) -> Double { @_common.max(s.data) }

pub fn graph_search_bfs_frame_to_string(s : GraphsearchbfsFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphsearchbfsTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_search_bfs_table_make(size : Int) -> GraphsearchbfsTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_search_bfs_table_len(s : GraphsearchbfsTable) -> Int { s.size }

pub fn graph_search_bfs_table_get(s : GraphsearchbfsTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_search_bfs_table_set(s : GraphsearchbfsTable, i : Int, v : Double) -> GraphsearchbfsTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_search_bfs_table_sum(s : GraphsearchbfsTable) -> Double { @_common.sum(s.data) }

pub fn graph_search_bfs_table_mean(s : GraphsearchbfsTable) -> Double { @_common.mean(s.data) }

pub fn graph_search_bfs_table_scale(s : GraphsearchbfsTable, f : Double) -> GraphsearchbfsTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_search_bfs_table_add(a : GraphsearchbfsTable, b : GraphsearchbfsTable) -> GraphsearchbfsTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_search_bfs_table_copy(s : GraphsearchbfsTable) -> GraphsearchbfsTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_search_bfs_table_fill(s : GraphsearchbfsTable, v : Double) -> GraphsearchbfsTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_search_bfs_table_min(s : GraphsearchbfsTable) -> Double { @_common.min(s.data) }

pub fn graph_search_bfs_table_max(s : GraphsearchbfsTable) -> Double { @_common.max(s.data) }

pub fn graph_search_bfs_table_to_string(s : GraphsearchbfsTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphsearchbfsGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_search_bfs_graphn_make(size : Int) -> GraphsearchbfsGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_search_bfs_graphn_len(s : GraphsearchbfsGraphN) -> Int { s.size }

pub fn graph_search_bfs_graphn_get(s : GraphsearchbfsGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_search_bfs_graphn_set(s : GraphsearchbfsGraphN, i : Int, v : Double) -> GraphsearchbfsGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_search_bfs_graphn_sum(s : GraphsearchbfsGraphN) -> Double { @_common.sum(s.data) }

pub fn graph_search_bfs_graphn_mean(s : GraphsearchbfsGraphN) -> Double { @_common.mean(s.data) }

pub fn graph_search_bfs_graphn_scale(s : GraphsearchbfsGraphN, f : Double) -> GraphsearchbfsGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_search_bfs_graphn_add(a : GraphsearchbfsGraphN, b : GraphsearchbfsGraphN) -> GraphsearchbfsGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_search_bfs_graphn_copy(s : GraphsearchbfsGraphN) -> GraphsearchbfsGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_search_bfs_graphn_fill(s : GraphsearchbfsGraphN, v : Double) -> GraphsearchbfsGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_search_bfs_graphn_min(s : GraphsearchbfsGraphN) -> Double { @_common.min(s.data) }

pub fn graph_search_bfs_graphn_max(s : GraphsearchbfsGraphN) -> Double { @_common.max(s.data) }

pub fn graph_search_bfs_graphn_to_string(s : GraphsearchbfsGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphsearchbfsNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_search_bfs_node_make(size : Int) -> GraphsearchbfsNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_search_bfs_node_len(s : GraphsearchbfsNode) -> Int { s.size }

pub fn graph_search_bfs_node_get(s : GraphsearchbfsNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_search_bfs_node_set(s : GraphsearchbfsNode, i : Int, v : Double) -> GraphsearchbfsNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_search_bfs_node_sum(s : GraphsearchbfsNode) -> Double { @_common.sum(s.data) }

pub fn graph_search_bfs_node_mean(s : GraphsearchbfsNode) -> Double { @_common.mean(s.data) }

pub fn graph_search_bfs_node_scale(s : GraphsearchbfsNode, f : Double) -> GraphsearchbfsNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_search_bfs_node_add(a : GraphsearchbfsNode, b : GraphsearchbfsNode) -> GraphsearchbfsNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_search_bfs_node_copy(s : GraphsearchbfsNode) -> GraphsearchbfsNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_search_bfs_node_fill(s : GraphsearchbfsNode, v : Double) -> GraphsearchbfsNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_search_bfs_node_min(s : GraphsearchbfsNode) -> Double { @_common.min(s.data) }

pub fn graph_search_bfs_node_max(s : GraphsearchbfsNode) -> Double { @_common.max(s.data) }

pub fn graph_search_bfs_node_to_string(s : GraphsearchbfsNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphsearchbfsEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_search_bfs_edge_make(size : Int) -> GraphsearchbfsEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_search_bfs_edge_len(s : GraphsearchbfsEdge) -> Int { s.size }

pub fn graph_search_bfs_edge_get(s : GraphsearchbfsEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_search_bfs_edge_set(s : GraphsearchbfsEdge, i : Int, v : Double) -> GraphsearchbfsEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_search_bfs_edge_sum(s : GraphsearchbfsEdge) -> Double { @_common.sum(s.data) }

pub fn graph_search_bfs_edge_mean(s : GraphsearchbfsEdge) -> Double { @_common.mean(s.data) }

pub fn graph_search_bfs_edge_scale(s : GraphsearchbfsEdge, f : Double) -> GraphsearchbfsEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_search_bfs_edge_add(a : GraphsearchbfsEdge, b : GraphsearchbfsEdge) -> GraphsearchbfsEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_search_bfs_edge_copy(s : GraphsearchbfsEdge) -> GraphsearchbfsEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_search_bfs_edge_fill(s : GraphsearchbfsEdge, v : Double) -> GraphsearchbfsEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_search_bfs_edge_min(s : GraphsearchbfsEdge) -> Double { @_common.min(s.data) }

pub fn graph_search_bfs_edge_max(s : GraphsearchbfsEdge) -> Double { @_common.max(s.data) }

pub fn graph_search_bfs_edge_to_string(s : GraphsearchbfsEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphsearchbfsPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_search_bfs_path_make(size : Int) -> GraphsearchbfsPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_search_bfs_path_len(s : GraphsearchbfsPath) -> Int { s.size }

pub fn graph_search_bfs_path_get(s : GraphsearchbfsPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_search_bfs_path_set(s : GraphsearchbfsPath, i : Int, v : Double) -> GraphsearchbfsPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_search_bfs_path_sum(s : GraphsearchbfsPath) -> Double { @_common.sum(s.data) }

pub fn graph_search_bfs_path_mean(s : GraphsearchbfsPath) -> Double { @_common.mean(s.data) }

pub fn graph_search_bfs_path_scale(s : GraphsearchbfsPath, f : Double) -> GraphsearchbfsPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_search_bfs_path_add(a : GraphsearchbfsPath, b : GraphsearchbfsPath) -> GraphsearchbfsPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_search_bfs_path_copy(s : GraphsearchbfsPath) -> GraphsearchbfsPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_search_bfs_path_fill(s : GraphsearchbfsPath, v : Double) -> GraphsearchbfsPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_search_bfs_path_min(s : GraphsearchbfsPath) -> Double { @_common.min(s.data) }

pub fn graph_search_bfs_path_max(s : GraphsearchbfsPath) -> Double { @_common.max(s.data) }

pub fn graph_search_bfs_path_to_string(s : GraphsearchbfsPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphsearchbfsCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_search_bfs_cluster_make(size : Int) -> GraphsearchbfsCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_search_bfs_cluster_len(s : GraphsearchbfsCluster) -> Int { s.size }

pub fn graph_search_bfs_cluster_get(s : GraphsearchbfsCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_search_bfs_cluster_set(s : GraphsearchbfsCluster, i : Int, v : Double) -> GraphsearchbfsCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_search_bfs_cluster_sum(s : GraphsearchbfsCluster) -> Double { @_common.sum(s.data) }

pub fn graph_search_bfs_cluster_mean(s : GraphsearchbfsCluster) -> Double { @_common.mean(s.data) }

pub fn graph_search_bfs_cluster_scale(s : GraphsearchbfsCluster, f : Double) -> GraphsearchbfsCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_search_bfs_cluster_add(a : GraphsearchbfsCluster, b : GraphsearchbfsCluster) -> GraphsearchbfsCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_search_bfs_cluster_copy(s : GraphsearchbfsCluster) -> GraphsearchbfsCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_search_bfs_cluster_fill(s : GraphsearchbfsCluster, v : Double) -> GraphsearchbfsCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_search_bfs_cluster_min(s : GraphsearchbfsCluster) -> Double { @_common.min(s.data) }

pub fn graph_search_bfs_cluster_max(s : GraphsearchbfsCluster) -> Double { @_common.max(s.data) }

pub fn graph_search_bfs_cluster_to_string(s : GraphsearchbfsCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphsearchbfsModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_search_bfs_model_make(size : Int) -> GraphsearchbfsModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_search_bfs_model_len(s : GraphsearchbfsModel) -> Int { s.size }

pub fn graph_search_bfs_model_get(s : GraphsearchbfsModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_search_bfs_model_set(s : GraphsearchbfsModel, i : Int, v : Double) -> GraphsearchbfsModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_search_bfs_model_sum(s : GraphsearchbfsModel) -> Double { @_common.sum(s.data) }

pub fn graph_search_bfs_model_mean(s : GraphsearchbfsModel) -> Double { @_common.mean(s.data) }

pub fn graph_search_bfs_model_scale(s : GraphsearchbfsModel, f : Double) -> GraphsearchbfsModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_search_bfs_model_add(a : GraphsearchbfsModel, b : GraphsearchbfsModel) -> GraphsearchbfsModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_search_bfs_model_copy(s : GraphsearchbfsModel) -> GraphsearchbfsModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_search_bfs_model_fill(s : GraphsearchbfsModel, v : Double) -> GraphsearchbfsModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_search_bfs_model_min(s : GraphsearchbfsModel) -> Double { @_common.min(s.data) }

pub fn graph_search_bfs_model_max(s : GraphsearchbfsModel) -> Double { @_common.max(s.data) }

pub fn graph_search_bfs_model_to_string(s : GraphsearchbfsModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphsearchbfsLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_search_bfs_layer_make(size : Int) -> GraphsearchbfsLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_search_bfs_layer_len(s : GraphsearchbfsLayer) -> Int { s.size }

pub fn graph_search_bfs_layer_get(s : GraphsearchbfsLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_search_bfs_layer_set(s : GraphsearchbfsLayer, i : Int, v : Double) -> GraphsearchbfsLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_search_bfs_layer_sum(s : GraphsearchbfsLayer) -> Double { @_common.sum(s.data) }

pub fn graph_search_bfs_layer_mean(s : GraphsearchbfsLayer) -> Double { @_common.mean(s.data) }

pub fn graph_search_bfs_layer_scale(s : GraphsearchbfsLayer, f : Double) -> GraphsearchbfsLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_search_bfs_layer_add(a : GraphsearchbfsLayer, b : GraphsearchbfsLayer) -> GraphsearchbfsLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_search_bfs_layer_copy(s : GraphsearchbfsLayer) -> GraphsearchbfsLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_search_bfs_layer_fill(s : GraphsearchbfsLayer, v : Double) -> GraphsearchbfsLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_search_bfs_layer_min(s : GraphsearchbfsLayer) -> Double { @_common.min(s.data) }

pub fn graph_search_bfs_layer_max(s : GraphsearchbfsLayer) -> Double { @_common.max(s.data) }

pub fn graph_search_bfs_layer_to_string(s : GraphsearchbfsLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphsearchbfsBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_search_bfs_buffer_make(size : Int) -> GraphsearchbfsBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_search_bfs_buffer_len(s : GraphsearchbfsBuffer) -> Int { s.size }

pub fn graph_search_bfs_buffer_get(s : GraphsearchbfsBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_search_bfs_buffer_set(s : GraphsearchbfsBuffer, i : Int, v : Double) -> GraphsearchbfsBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_search_bfs_buffer_sum(s : GraphsearchbfsBuffer) -> Double { @_common.sum(s.data) }

pub fn graph_search_bfs_buffer_mean(s : GraphsearchbfsBuffer) -> Double { @_common.mean(s.data) }

pub fn graph_search_bfs_buffer_scale(s : GraphsearchbfsBuffer, f : Double) -> GraphsearchbfsBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_search_bfs_buffer_add(a : GraphsearchbfsBuffer, b : GraphsearchbfsBuffer) -> GraphsearchbfsBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_search_bfs_buffer_copy(s : GraphsearchbfsBuffer) -> GraphsearchbfsBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_search_bfs_buffer_fill(s : GraphsearchbfsBuffer, v : Double) -> GraphsearchbfsBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_search_bfs_buffer_min(s : GraphsearchbfsBuffer) -> Double { @_common.min(s.data) }

pub fn graph_search_bfs_buffer_max(s : GraphsearchbfsBuffer) -> Double { @_common.max(s.data) }

pub fn graph_search_bfs_buffer_to_string(s : GraphsearchbfsBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphsearchbfsCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_search_bfs_cursor_make(size : Int) -> GraphsearchbfsCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_search_bfs_cursor_len(s : GraphsearchbfsCursor) -> Int { s.size }

pub fn graph_search_bfs_cursor_get(s : GraphsearchbfsCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_search_bfs_cursor_set(s : GraphsearchbfsCursor, i : Int, v : Double) -> GraphsearchbfsCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_search_bfs_cursor_sum(s : GraphsearchbfsCursor) -> Double { @_common.sum(s.data) }

pub fn graph_search_bfs_cursor_mean(s : GraphsearchbfsCursor) -> Double { @_common.mean(s.data) }

pub fn graph_search_bfs_cursor_scale(s : GraphsearchbfsCursor, f : Double) -> GraphsearchbfsCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_search_bfs_cursor_add(a : GraphsearchbfsCursor, b : GraphsearchbfsCursor) -> GraphsearchbfsCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_search_bfs_cursor_copy(s : GraphsearchbfsCursor) -> GraphsearchbfsCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_search_bfs_cursor_fill(s : GraphsearchbfsCursor, v : Double) -> GraphsearchbfsCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_search_bfs_cursor_min(s : GraphsearchbfsCursor) -> Double { @_common.min(s.data) }

pub fn graph_search_bfs_cursor_max(s : GraphsearchbfsCursor) -> Double { @_common.max(s.data) }

pub fn graph_search_bfs_cursor_to_string(s : GraphsearchbfsCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphsearchbfsView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_search_bfs_view_make(size : Int) -> GraphsearchbfsView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_search_bfs_view_len(s : GraphsearchbfsView) -> Int { s.size }

pub fn graph_search_bfs_view_get(s : GraphsearchbfsView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_search_bfs_view_set(s : GraphsearchbfsView, i : Int, v : Double) -> GraphsearchbfsView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_search_bfs_view_sum(s : GraphsearchbfsView) -> Double { @_common.sum(s.data) }

pub fn graph_search_bfs_view_mean(s : GraphsearchbfsView) -> Double { @_common.mean(s.data) }

pub fn graph_search_bfs_view_scale(s : GraphsearchbfsView, f : Double) -> GraphsearchbfsView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_search_bfs_view_add(a : GraphsearchbfsView, b : GraphsearchbfsView) -> GraphsearchbfsView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_search_bfs_view_copy(s : GraphsearchbfsView) -> GraphsearchbfsView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_search_bfs_view_fill(s : GraphsearchbfsView, v : Double) -> GraphsearchbfsView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_search_bfs_view_min(s : GraphsearchbfsView) -> Double { @_common.min(s.data) }

pub fn graph_search_bfs_view_max(s : GraphsearchbfsView) -> Double { @_common.max(s.data) }

pub fn graph_search_bfs_view_to_string(s : GraphsearchbfsView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphsearchbfsRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_search_bfs_range_make(size : Int) -> GraphsearchbfsRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_search_bfs_range_len(s : GraphsearchbfsRange) -> Int { s.size }

pub fn graph_search_bfs_range_get(s : GraphsearchbfsRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_search_bfs_range_set(s : GraphsearchbfsRange, i : Int, v : Double) -> GraphsearchbfsRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_search_bfs_range_sum(s : GraphsearchbfsRange) -> Double { @_common.sum(s.data) }

pub fn graph_search_bfs_range_mean(s : GraphsearchbfsRange) -> Double { @_common.mean(s.data) }

pub fn graph_search_bfs_range_scale(s : GraphsearchbfsRange, f : Double) -> GraphsearchbfsRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_search_bfs_range_add(a : GraphsearchbfsRange, b : GraphsearchbfsRange) -> GraphsearchbfsRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_search_bfs_range_copy(s : GraphsearchbfsRange) -> GraphsearchbfsRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_search_bfs_range_fill(s : GraphsearchbfsRange, v : Double) -> GraphsearchbfsRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_search_bfs_range_min(s : GraphsearchbfsRange) -> Double { @_common.min(s.data) }

pub fn graph_search_bfs_range_max(s : GraphsearchbfsRange) -> Double { @_common.max(s.data) }

pub fn graph_search_bfs_range_to_string(s : GraphsearchbfsRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphsearchbfsSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_search_bfs_slice_make(size : Int) -> GraphsearchbfsSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_search_bfs_slice_len(s : GraphsearchbfsSlice) -> Int { s.size }

pub fn graph_search_bfs_slice_get(s : GraphsearchbfsSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_search_bfs_slice_set(s : GraphsearchbfsSlice, i : Int, v : Double) -> GraphsearchbfsSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_search_bfs_slice_sum(s : GraphsearchbfsSlice) -> Double { @_common.sum(s.data) }

pub fn graph_search_bfs_slice_mean(s : GraphsearchbfsSlice) -> Double { @_common.mean(s.data) }

pub fn graph_search_bfs_slice_scale(s : GraphsearchbfsSlice, f : Double) -> GraphsearchbfsSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_search_bfs_slice_add(a : GraphsearchbfsSlice, b : GraphsearchbfsSlice) -> GraphsearchbfsSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_search_bfs_slice_copy(s : GraphsearchbfsSlice) -> GraphsearchbfsSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_search_bfs_slice_fill(s : GraphsearchbfsSlice, v : Double) -> GraphsearchbfsSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_search_bfs_slice_min(s : GraphsearchbfsSlice) -> Double { @_common.min(s.data) }

pub fn graph_search_bfs_slice_max(s : GraphsearchbfsSlice) -> Double { @_common.max(s.data) }

pub fn graph_search_bfs_slice_to_string(s : GraphsearchbfsSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

