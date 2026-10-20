///===
/// extcore/graph_search_dijkstra

pub(all) struct GraphsearchdijkstraPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn graph_search_dijkstra_make_point(x : Double, y : Double) -> GraphsearchdijkstraPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn graph_search_dijkstra_make_point3(x : Double, y : Double, z : Double) -> GraphsearchdijkstraPoint {
  { x, y, z, label: 0 }
}

pub fn GraphsearchdijkstraPoint::x(self : GraphsearchdijkstraPoint) -> Double { self.x }

pub fn GraphsearchdijkstraPoint::y(self : GraphsearchdijkstraPoint) -> Double { self.y }

pub fn GraphsearchdijkstraPoint::z(self : GraphsearchdijkstraPoint) -> Double { self.z }

pub fn GraphsearchdijkstraPoint::label(self : GraphsearchdijkstraPoint) -> Int { self.label }

pub fn GraphsearchdijkstraPoint::dist(self : GraphsearchdijkstraPoint, other : GraphsearchdijkstraPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn GraphsearchdijkstraPoint::add(self : GraphsearchdijkstraPoint, other : GraphsearchdijkstraPoint) -> GraphsearchdijkstraPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn GraphsearchdijkstraPoint::sub(self : GraphsearchdijkstraPoint, other : GraphsearchdijkstraPoint) -> GraphsearchdijkstraPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn GraphsearchdijkstraPoint::scale(self : GraphsearchdijkstraPoint, s : Double) -> GraphsearchdijkstraPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn GraphsearchdijkstraPoint::dot(self : GraphsearchdijkstraPoint, other : GraphsearchdijkstraPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn GraphsearchdijkstraPoint::cross(self : GraphsearchdijkstraPoint, other : GraphsearchdijkstraPoint) -> GraphsearchdijkstraPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn GraphsearchdijkstraPoint::norm(self : GraphsearchdijkstraPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn GraphsearchdijkstraPoint::normalize(self : GraphsearchdijkstraPoint) -> GraphsearchdijkstraPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn GraphsearchdijkstraPoint::negate(self : GraphsearchdijkstraPoint) -> GraphsearchdijkstraPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn GraphsearchdijkstraPoint::mid(self : GraphsearchdijkstraPoint, other : GraphsearchdijkstraPoint) -> GraphsearchdijkstraPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn GraphsearchdijkstraPoint::lerp(self : GraphsearchdijkstraPoint, other : GraphsearchdijkstraPoint, t : Double) -> GraphsearchdijkstraPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn GraphsearchdijkstraPoint::to_string(self : GraphsearchdijkstraPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct GraphsearchdijkstraSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn graph_search_dijkstra_make_series(vals : Array[Double], name : String) -> GraphsearchdijkstraSeries {
  { vals, name, meta: 0 }
}

pub fn GraphsearchdijkstraSeries::len(self : GraphsearchdijkstraSeries) -> Int { self.vals.length() }

pub fn GraphsearchdijkstraSeries::sum(self : GraphsearchdijkstraSeries) -> Double { @_common.sum(self.vals) }

pub fn GraphsearchdijkstraSeries::mean(self : GraphsearchdijkstraSeries) -> Double { @_common.mean(self.vals) }

pub fn GraphsearchdijkstraSeries::min(self : GraphsearchdijkstraSeries) -> Double { @_common.min(self.vals) }

pub fn GraphsearchdijkstraSeries::max(self : GraphsearchdijkstraSeries) -> Double { @_common.max(self.vals) }

pub fn GraphsearchdijkstraSeries::range(self : GraphsearchdijkstraSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn GraphsearchdijkstraSeries::variance(self : GraphsearchdijkstraSeries) -> Double { @_common.variance(self.vals) }

pub fn GraphsearchdijkstraSeries::std(self : GraphsearchdijkstraSeries) -> Double { @_common.std(self.vals) }

pub fn GraphsearchdijkstraSeries::median(self : GraphsearchdijkstraSeries) -> Double { @_common.median(self.vals) }

pub fn GraphsearchdijkstraSeries::scale(self : GraphsearchdijkstraSeries, f : Double) -> GraphsearchdijkstraSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn GraphsearchdijkstraSeries::add(self : GraphsearchdijkstraSeries, other : GraphsearchdijkstraSeries) -> GraphsearchdijkstraSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn GraphsearchdijkstraSeries::sub(self : GraphsearchdijkstraSeries, other : GraphsearchdijkstraSeries) -> GraphsearchdijkstraSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn GraphsearchdijkstraSeries::normalize(self : GraphsearchdijkstraSeries) -> GraphsearchdijkstraSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn GraphsearchdijkstraSeries::cumsum(self : GraphsearchdijkstraSeries) -> GraphsearchdijkstraSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn GraphsearchdijkstraSeries::to_string(self : GraphsearchdijkstraSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct GraphsearchdijkstraMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn graph_search_dijkstra_make_matrix(rows : Int, cols : Int, val : Double) -> GraphsearchdijkstraMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn graph_search_dijkstra_matrix_identity(n : Int) -> GraphsearchdijkstraMatrix {
  let m = graph_search_dijkstra_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn GraphsearchdijkstraMatrix::get(self : GraphsearchdijkstraMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn GraphsearchdijkstraMatrix::transpose(self : GraphsearchdijkstraMatrix) -> GraphsearchdijkstraMatrix {
  let result = graph_search_dijkstra_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn GraphsearchdijkstraMatrix::add(self : GraphsearchdijkstraMatrix, other : GraphsearchdijkstraMatrix) -> GraphsearchdijkstraMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = graph_search_dijkstra_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn GraphsearchdijkstraMatrix::scale(self : GraphsearchdijkstraMatrix, s : Double) -> GraphsearchdijkstraMatrix {
  let result = graph_search_dijkstra_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn GraphsearchdijkstraMatrix::multiply(self : GraphsearchdijkstraMatrix, other : GraphsearchdijkstraMatrix) -> GraphsearchdijkstraMatrix {
  if self.cols != other.rows { return graph_search_dijkstra_make_matrix(self.rows, other.cols, 0.0) }
  let result = graph_search_dijkstra_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn GraphsearchdijkstraMatrix::trace(self : GraphsearchdijkstraMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn GraphsearchdijkstraMatrix::det(self : GraphsearchdijkstraMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn GraphsearchdijkstraMatrix::norm(self : GraphsearchdijkstraMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn GraphsearchdijkstraMatrix::to_string(self : GraphsearchdijkstraMatrix) -> String {
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

pub(all) struct GraphsearchdijkstraVector {
  comps : Array[Double]
  dim : Int
}

pub fn graph_search_dijkstra_make_vector(comps : Array[Double]) -> GraphsearchdijkstraVector {
  { comps, dim: comps.length() }
}

pub fn graph_search_dijkstra_vector_zero(dim : Int) -> GraphsearchdijkstraVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn GraphsearchdijkstraVector::add(self : GraphsearchdijkstraVector, other : GraphsearchdijkstraVector) -> GraphsearchdijkstraVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn GraphsearchdijkstraVector::sub(self : GraphsearchdijkstraVector, other : GraphsearchdijkstraVector) -> GraphsearchdijkstraVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn GraphsearchdijkstraVector::scale(self : GraphsearchdijkstraVector, s : Double) -> GraphsearchdijkstraVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn GraphsearchdijkstraVector::dot(self : GraphsearchdijkstraVector, other : GraphsearchdijkstraVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn GraphsearchdijkstraVector::norm(self : GraphsearchdijkstraVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn GraphsearchdijkstraVector::normalize(self : GraphsearchdijkstraVector) -> GraphsearchdijkstraVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn GraphsearchdijkstraVector::dist(self : GraphsearchdijkstraVector, other : GraphsearchdijkstraVector) -> Double {
  self.sub(other).norm()
}

pub fn GraphsearchdijkstraVector::to_string(self : GraphsearchdijkstraVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn graph_search_dijkstra_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn graph_search_dijkstra_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn graph_search_dijkstra_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn graph_search_dijkstra_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn graph_search_dijkstra_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn graph_search_dijkstra_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn graph_search_dijkstra_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn graph_search_dijkstra_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn graph_search_dijkstra_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn graph_search_dijkstra_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn graph_search_dijkstra_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn graph_search_dijkstra_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn graph_search_dijkstra_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn graph_search_dijkstra_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn graph_search_dijkstra_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn graph_search_dijkstra_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn graph_search_dijkstra_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn graph_search_dijkstra_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn graph_search_dijkstra_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn graph_search_dijkstra_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn graph_search_dijkstra_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn graph_search_dijkstra_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn graph_search_dijkstra_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn graph_search_dijkstra_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn graph_search_dijkstra_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn graph_search_dijkstra_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn graph_search_dijkstra_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn graph_search_dijkstra_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn graph_search_dijkstra_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct GraphsearchdijkstraFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_search_dijkstra_frame_make(size : Int) -> GraphsearchdijkstraFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_search_dijkstra_frame_len(s : GraphsearchdijkstraFrame) -> Int { s.size }

pub fn graph_search_dijkstra_frame_get(s : GraphsearchdijkstraFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_search_dijkstra_frame_set(s : GraphsearchdijkstraFrame, i : Int, v : Double) -> GraphsearchdijkstraFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_search_dijkstra_frame_sum(s : GraphsearchdijkstraFrame) -> Double { @_common.sum(s.data) }

pub fn graph_search_dijkstra_frame_mean(s : GraphsearchdijkstraFrame) -> Double { @_common.mean(s.data) }

pub fn graph_search_dijkstra_frame_scale(s : GraphsearchdijkstraFrame, f : Double) -> GraphsearchdijkstraFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_search_dijkstra_frame_add(a : GraphsearchdijkstraFrame, b : GraphsearchdijkstraFrame) -> GraphsearchdijkstraFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_search_dijkstra_frame_copy(s : GraphsearchdijkstraFrame) -> GraphsearchdijkstraFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_search_dijkstra_frame_fill(s : GraphsearchdijkstraFrame, v : Double) -> GraphsearchdijkstraFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_search_dijkstra_frame_min(s : GraphsearchdijkstraFrame) -> Double { @_common.min(s.data) }

pub fn graph_search_dijkstra_frame_max(s : GraphsearchdijkstraFrame) -> Double { @_common.max(s.data) }

pub fn graph_search_dijkstra_frame_to_string(s : GraphsearchdijkstraFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphsearchdijkstraTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_search_dijkstra_table_make(size : Int) -> GraphsearchdijkstraTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_search_dijkstra_table_len(s : GraphsearchdijkstraTable) -> Int { s.size }

pub fn graph_search_dijkstra_table_get(s : GraphsearchdijkstraTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_search_dijkstra_table_set(s : GraphsearchdijkstraTable, i : Int, v : Double) -> GraphsearchdijkstraTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_search_dijkstra_table_sum(s : GraphsearchdijkstraTable) -> Double { @_common.sum(s.data) }

pub fn graph_search_dijkstra_table_mean(s : GraphsearchdijkstraTable) -> Double { @_common.mean(s.data) }

pub fn graph_search_dijkstra_table_scale(s : GraphsearchdijkstraTable, f : Double) -> GraphsearchdijkstraTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_search_dijkstra_table_add(a : GraphsearchdijkstraTable, b : GraphsearchdijkstraTable) -> GraphsearchdijkstraTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_search_dijkstra_table_copy(s : GraphsearchdijkstraTable) -> GraphsearchdijkstraTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_search_dijkstra_table_fill(s : GraphsearchdijkstraTable, v : Double) -> GraphsearchdijkstraTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_search_dijkstra_table_min(s : GraphsearchdijkstraTable) -> Double { @_common.min(s.data) }

pub fn graph_search_dijkstra_table_max(s : GraphsearchdijkstraTable) -> Double { @_common.max(s.data) }

pub fn graph_search_dijkstra_table_to_string(s : GraphsearchdijkstraTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphsearchdijkstraGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_search_dijkstra_graphn_make(size : Int) -> GraphsearchdijkstraGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_search_dijkstra_graphn_len(s : GraphsearchdijkstraGraphN) -> Int { s.size }

pub fn graph_search_dijkstra_graphn_get(s : GraphsearchdijkstraGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_search_dijkstra_graphn_set(s : GraphsearchdijkstraGraphN, i : Int, v : Double) -> GraphsearchdijkstraGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_search_dijkstra_graphn_sum(s : GraphsearchdijkstraGraphN) -> Double { @_common.sum(s.data) }

pub fn graph_search_dijkstra_graphn_mean(s : GraphsearchdijkstraGraphN) -> Double { @_common.mean(s.data) }

pub fn graph_search_dijkstra_graphn_scale(s : GraphsearchdijkstraGraphN, f : Double) -> GraphsearchdijkstraGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_search_dijkstra_graphn_add(a : GraphsearchdijkstraGraphN, b : GraphsearchdijkstraGraphN) -> GraphsearchdijkstraGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_search_dijkstra_graphn_copy(s : GraphsearchdijkstraGraphN) -> GraphsearchdijkstraGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_search_dijkstra_graphn_fill(s : GraphsearchdijkstraGraphN, v : Double) -> GraphsearchdijkstraGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_search_dijkstra_graphn_min(s : GraphsearchdijkstraGraphN) -> Double { @_common.min(s.data) }

pub fn graph_search_dijkstra_graphn_max(s : GraphsearchdijkstraGraphN) -> Double { @_common.max(s.data) }

pub fn graph_search_dijkstra_graphn_to_string(s : GraphsearchdijkstraGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphsearchdijkstraNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_search_dijkstra_node_make(size : Int) -> GraphsearchdijkstraNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_search_dijkstra_node_len(s : GraphsearchdijkstraNode) -> Int { s.size }

pub fn graph_search_dijkstra_node_get(s : GraphsearchdijkstraNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_search_dijkstra_node_set(s : GraphsearchdijkstraNode, i : Int, v : Double) -> GraphsearchdijkstraNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_search_dijkstra_node_sum(s : GraphsearchdijkstraNode) -> Double { @_common.sum(s.data) }

pub fn graph_search_dijkstra_node_mean(s : GraphsearchdijkstraNode) -> Double { @_common.mean(s.data) }

pub fn graph_search_dijkstra_node_scale(s : GraphsearchdijkstraNode, f : Double) -> GraphsearchdijkstraNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_search_dijkstra_node_add(a : GraphsearchdijkstraNode, b : GraphsearchdijkstraNode) -> GraphsearchdijkstraNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_search_dijkstra_node_copy(s : GraphsearchdijkstraNode) -> GraphsearchdijkstraNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_search_dijkstra_node_fill(s : GraphsearchdijkstraNode, v : Double) -> GraphsearchdijkstraNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_search_dijkstra_node_min(s : GraphsearchdijkstraNode) -> Double { @_common.min(s.data) }

pub fn graph_search_dijkstra_node_max(s : GraphsearchdijkstraNode) -> Double { @_common.max(s.data) }

pub fn graph_search_dijkstra_node_to_string(s : GraphsearchdijkstraNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphsearchdijkstraEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_search_dijkstra_edge_make(size : Int) -> GraphsearchdijkstraEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_search_dijkstra_edge_len(s : GraphsearchdijkstraEdge) -> Int { s.size }

pub fn graph_search_dijkstra_edge_get(s : GraphsearchdijkstraEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_search_dijkstra_edge_set(s : GraphsearchdijkstraEdge, i : Int, v : Double) -> GraphsearchdijkstraEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_search_dijkstra_edge_sum(s : GraphsearchdijkstraEdge) -> Double { @_common.sum(s.data) }

pub fn graph_search_dijkstra_edge_mean(s : GraphsearchdijkstraEdge) -> Double { @_common.mean(s.data) }

pub fn graph_search_dijkstra_edge_scale(s : GraphsearchdijkstraEdge, f : Double) -> GraphsearchdijkstraEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_search_dijkstra_edge_add(a : GraphsearchdijkstraEdge, b : GraphsearchdijkstraEdge) -> GraphsearchdijkstraEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_search_dijkstra_edge_copy(s : GraphsearchdijkstraEdge) -> GraphsearchdijkstraEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_search_dijkstra_edge_fill(s : GraphsearchdijkstraEdge, v : Double) -> GraphsearchdijkstraEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_search_dijkstra_edge_min(s : GraphsearchdijkstraEdge) -> Double { @_common.min(s.data) }

pub fn graph_search_dijkstra_edge_max(s : GraphsearchdijkstraEdge) -> Double { @_common.max(s.data) }

pub fn graph_search_dijkstra_edge_to_string(s : GraphsearchdijkstraEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphsearchdijkstraPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_search_dijkstra_path_make(size : Int) -> GraphsearchdijkstraPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_search_dijkstra_path_len(s : GraphsearchdijkstraPath) -> Int { s.size }

pub fn graph_search_dijkstra_path_get(s : GraphsearchdijkstraPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_search_dijkstra_path_set(s : GraphsearchdijkstraPath, i : Int, v : Double) -> GraphsearchdijkstraPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_search_dijkstra_path_sum(s : GraphsearchdijkstraPath) -> Double { @_common.sum(s.data) }

pub fn graph_search_dijkstra_path_mean(s : GraphsearchdijkstraPath) -> Double { @_common.mean(s.data) }

pub fn graph_search_dijkstra_path_scale(s : GraphsearchdijkstraPath, f : Double) -> GraphsearchdijkstraPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_search_dijkstra_path_add(a : GraphsearchdijkstraPath, b : GraphsearchdijkstraPath) -> GraphsearchdijkstraPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_search_dijkstra_path_copy(s : GraphsearchdijkstraPath) -> GraphsearchdijkstraPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_search_dijkstra_path_fill(s : GraphsearchdijkstraPath, v : Double) -> GraphsearchdijkstraPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_search_dijkstra_path_min(s : GraphsearchdijkstraPath) -> Double { @_common.min(s.data) }

pub fn graph_search_dijkstra_path_max(s : GraphsearchdijkstraPath) -> Double { @_common.max(s.data) }

pub fn graph_search_dijkstra_path_to_string(s : GraphsearchdijkstraPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphsearchdijkstraCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_search_dijkstra_cluster_make(size : Int) -> GraphsearchdijkstraCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_search_dijkstra_cluster_len(s : GraphsearchdijkstraCluster) -> Int { s.size }

pub fn graph_search_dijkstra_cluster_get(s : GraphsearchdijkstraCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_search_dijkstra_cluster_set(s : GraphsearchdijkstraCluster, i : Int, v : Double) -> GraphsearchdijkstraCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_search_dijkstra_cluster_sum(s : GraphsearchdijkstraCluster) -> Double { @_common.sum(s.data) }

pub fn graph_search_dijkstra_cluster_mean(s : GraphsearchdijkstraCluster) -> Double { @_common.mean(s.data) }

pub fn graph_search_dijkstra_cluster_scale(s : GraphsearchdijkstraCluster, f : Double) -> GraphsearchdijkstraCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_search_dijkstra_cluster_add(a : GraphsearchdijkstraCluster, b : GraphsearchdijkstraCluster) -> GraphsearchdijkstraCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_search_dijkstra_cluster_copy(s : GraphsearchdijkstraCluster) -> GraphsearchdijkstraCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_search_dijkstra_cluster_fill(s : GraphsearchdijkstraCluster, v : Double) -> GraphsearchdijkstraCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_search_dijkstra_cluster_min(s : GraphsearchdijkstraCluster) -> Double { @_common.min(s.data) }

pub fn graph_search_dijkstra_cluster_max(s : GraphsearchdijkstraCluster) -> Double { @_common.max(s.data) }

pub fn graph_search_dijkstra_cluster_to_string(s : GraphsearchdijkstraCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphsearchdijkstraModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_search_dijkstra_model_make(size : Int) -> GraphsearchdijkstraModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_search_dijkstra_model_len(s : GraphsearchdijkstraModel) -> Int { s.size }

pub fn graph_search_dijkstra_model_get(s : GraphsearchdijkstraModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_search_dijkstra_model_set(s : GraphsearchdijkstraModel, i : Int, v : Double) -> GraphsearchdijkstraModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_search_dijkstra_model_sum(s : GraphsearchdijkstraModel) -> Double { @_common.sum(s.data) }

pub fn graph_search_dijkstra_model_mean(s : GraphsearchdijkstraModel) -> Double { @_common.mean(s.data) }

pub fn graph_search_dijkstra_model_scale(s : GraphsearchdijkstraModel, f : Double) -> GraphsearchdijkstraModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_search_dijkstra_model_add(a : GraphsearchdijkstraModel, b : GraphsearchdijkstraModel) -> GraphsearchdijkstraModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_search_dijkstra_model_copy(s : GraphsearchdijkstraModel) -> GraphsearchdijkstraModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_search_dijkstra_model_fill(s : GraphsearchdijkstraModel, v : Double) -> GraphsearchdijkstraModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_search_dijkstra_model_min(s : GraphsearchdijkstraModel) -> Double { @_common.min(s.data) }

pub fn graph_search_dijkstra_model_max(s : GraphsearchdijkstraModel) -> Double { @_common.max(s.data) }

pub fn graph_search_dijkstra_model_to_string(s : GraphsearchdijkstraModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphsearchdijkstraLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_search_dijkstra_layer_make(size : Int) -> GraphsearchdijkstraLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_search_dijkstra_layer_len(s : GraphsearchdijkstraLayer) -> Int { s.size }

pub fn graph_search_dijkstra_layer_get(s : GraphsearchdijkstraLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_search_dijkstra_layer_set(s : GraphsearchdijkstraLayer, i : Int, v : Double) -> GraphsearchdijkstraLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_search_dijkstra_layer_sum(s : GraphsearchdijkstraLayer) -> Double { @_common.sum(s.data) }

pub fn graph_search_dijkstra_layer_mean(s : GraphsearchdijkstraLayer) -> Double { @_common.mean(s.data) }

pub fn graph_search_dijkstra_layer_scale(s : GraphsearchdijkstraLayer, f : Double) -> GraphsearchdijkstraLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_search_dijkstra_layer_add(a : GraphsearchdijkstraLayer, b : GraphsearchdijkstraLayer) -> GraphsearchdijkstraLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_search_dijkstra_layer_copy(s : GraphsearchdijkstraLayer) -> GraphsearchdijkstraLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_search_dijkstra_layer_fill(s : GraphsearchdijkstraLayer, v : Double) -> GraphsearchdijkstraLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_search_dijkstra_layer_min(s : GraphsearchdijkstraLayer) -> Double { @_common.min(s.data) }

pub fn graph_search_dijkstra_layer_max(s : GraphsearchdijkstraLayer) -> Double { @_common.max(s.data) }

pub fn graph_search_dijkstra_layer_to_string(s : GraphsearchdijkstraLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphsearchdijkstraBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_search_dijkstra_buffer_make(size : Int) -> GraphsearchdijkstraBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_search_dijkstra_buffer_len(s : GraphsearchdijkstraBuffer) -> Int { s.size }

pub fn graph_search_dijkstra_buffer_get(s : GraphsearchdijkstraBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_search_dijkstra_buffer_set(s : GraphsearchdijkstraBuffer, i : Int, v : Double) -> GraphsearchdijkstraBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_search_dijkstra_buffer_sum(s : GraphsearchdijkstraBuffer) -> Double { @_common.sum(s.data) }

pub fn graph_search_dijkstra_buffer_mean(s : GraphsearchdijkstraBuffer) -> Double { @_common.mean(s.data) }

pub fn graph_search_dijkstra_buffer_scale(s : GraphsearchdijkstraBuffer, f : Double) -> GraphsearchdijkstraBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_search_dijkstra_buffer_add(a : GraphsearchdijkstraBuffer, b : GraphsearchdijkstraBuffer) -> GraphsearchdijkstraBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_search_dijkstra_buffer_copy(s : GraphsearchdijkstraBuffer) -> GraphsearchdijkstraBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_search_dijkstra_buffer_fill(s : GraphsearchdijkstraBuffer, v : Double) -> GraphsearchdijkstraBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_search_dijkstra_buffer_min(s : GraphsearchdijkstraBuffer) -> Double { @_common.min(s.data) }

pub fn graph_search_dijkstra_buffer_max(s : GraphsearchdijkstraBuffer) -> Double { @_common.max(s.data) }

pub fn graph_search_dijkstra_buffer_to_string(s : GraphsearchdijkstraBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphsearchdijkstraCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_search_dijkstra_cursor_make(size : Int) -> GraphsearchdijkstraCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_search_dijkstra_cursor_len(s : GraphsearchdijkstraCursor) -> Int { s.size }

pub fn graph_search_dijkstra_cursor_get(s : GraphsearchdijkstraCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_search_dijkstra_cursor_set(s : GraphsearchdijkstraCursor, i : Int, v : Double) -> GraphsearchdijkstraCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_search_dijkstra_cursor_sum(s : GraphsearchdijkstraCursor) -> Double { @_common.sum(s.data) }

pub fn graph_search_dijkstra_cursor_mean(s : GraphsearchdijkstraCursor) -> Double { @_common.mean(s.data) }

pub fn graph_search_dijkstra_cursor_scale(s : GraphsearchdijkstraCursor, f : Double) -> GraphsearchdijkstraCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_search_dijkstra_cursor_add(a : GraphsearchdijkstraCursor, b : GraphsearchdijkstraCursor) -> GraphsearchdijkstraCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_search_dijkstra_cursor_copy(s : GraphsearchdijkstraCursor) -> GraphsearchdijkstraCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_search_dijkstra_cursor_fill(s : GraphsearchdijkstraCursor, v : Double) -> GraphsearchdijkstraCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_search_dijkstra_cursor_min(s : GraphsearchdijkstraCursor) -> Double { @_common.min(s.data) }

pub fn graph_search_dijkstra_cursor_max(s : GraphsearchdijkstraCursor) -> Double { @_common.max(s.data) }

pub fn graph_search_dijkstra_cursor_to_string(s : GraphsearchdijkstraCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphsearchdijkstraView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_search_dijkstra_view_make(size : Int) -> GraphsearchdijkstraView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_search_dijkstra_view_len(s : GraphsearchdijkstraView) -> Int { s.size }

pub fn graph_search_dijkstra_view_get(s : GraphsearchdijkstraView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_search_dijkstra_view_set(s : GraphsearchdijkstraView, i : Int, v : Double) -> GraphsearchdijkstraView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_search_dijkstra_view_sum(s : GraphsearchdijkstraView) -> Double { @_common.sum(s.data) }

pub fn graph_search_dijkstra_view_mean(s : GraphsearchdijkstraView) -> Double { @_common.mean(s.data) }

pub fn graph_search_dijkstra_view_scale(s : GraphsearchdijkstraView, f : Double) -> GraphsearchdijkstraView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_search_dijkstra_view_add(a : GraphsearchdijkstraView, b : GraphsearchdijkstraView) -> GraphsearchdijkstraView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_search_dijkstra_view_copy(s : GraphsearchdijkstraView) -> GraphsearchdijkstraView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_search_dijkstra_view_fill(s : GraphsearchdijkstraView, v : Double) -> GraphsearchdijkstraView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_search_dijkstra_view_min(s : GraphsearchdijkstraView) -> Double { @_common.min(s.data) }

pub fn graph_search_dijkstra_view_max(s : GraphsearchdijkstraView) -> Double { @_common.max(s.data) }

pub fn graph_search_dijkstra_view_to_string(s : GraphsearchdijkstraView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphsearchdijkstraRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_search_dijkstra_range_make(size : Int) -> GraphsearchdijkstraRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_search_dijkstra_range_len(s : GraphsearchdijkstraRange) -> Int { s.size }

pub fn graph_search_dijkstra_range_get(s : GraphsearchdijkstraRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_search_dijkstra_range_set(s : GraphsearchdijkstraRange, i : Int, v : Double) -> GraphsearchdijkstraRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_search_dijkstra_range_sum(s : GraphsearchdijkstraRange) -> Double { @_common.sum(s.data) }

pub fn graph_search_dijkstra_range_mean(s : GraphsearchdijkstraRange) -> Double { @_common.mean(s.data) }

pub fn graph_search_dijkstra_range_scale(s : GraphsearchdijkstraRange, f : Double) -> GraphsearchdijkstraRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_search_dijkstra_range_add(a : GraphsearchdijkstraRange, b : GraphsearchdijkstraRange) -> GraphsearchdijkstraRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_search_dijkstra_range_copy(s : GraphsearchdijkstraRange) -> GraphsearchdijkstraRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_search_dijkstra_range_fill(s : GraphsearchdijkstraRange, v : Double) -> GraphsearchdijkstraRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_search_dijkstra_range_min(s : GraphsearchdijkstraRange) -> Double { @_common.min(s.data) }

pub fn graph_search_dijkstra_range_max(s : GraphsearchdijkstraRange) -> Double { @_common.max(s.data) }

pub fn graph_search_dijkstra_range_to_string(s : GraphsearchdijkstraRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphsearchdijkstraSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_search_dijkstra_slice_make(size : Int) -> GraphsearchdijkstraSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_search_dijkstra_slice_len(s : GraphsearchdijkstraSlice) -> Int { s.size }

pub fn graph_search_dijkstra_slice_get(s : GraphsearchdijkstraSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_search_dijkstra_slice_set(s : GraphsearchdijkstraSlice, i : Int, v : Double) -> GraphsearchdijkstraSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_search_dijkstra_slice_sum(s : GraphsearchdijkstraSlice) -> Double { @_common.sum(s.data) }

pub fn graph_search_dijkstra_slice_mean(s : GraphsearchdijkstraSlice) -> Double { @_common.mean(s.data) }

pub fn graph_search_dijkstra_slice_scale(s : GraphsearchdijkstraSlice, f : Double) -> GraphsearchdijkstraSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_search_dijkstra_slice_add(a : GraphsearchdijkstraSlice, b : GraphsearchdijkstraSlice) -> GraphsearchdijkstraSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_search_dijkstra_slice_copy(s : GraphsearchdijkstraSlice) -> GraphsearchdijkstraSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_search_dijkstra_slice_fill(s : GraphsearchdijkstraSlice, v : Double) -> GraphsearchdijkstraSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_search_dijkstra_slice_min(s : GraphsearchdijkstraSlice) -> Double { @_common.min(s.data) }

pub fn graph_search_dijkstra_slice_max(s : GraphsearchdijkstraSlice) -> Double { @_common.max(s.data) }

pub fn graph_search_dijkstra_slice_to_string(s : GraphsearchdijkstraSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

