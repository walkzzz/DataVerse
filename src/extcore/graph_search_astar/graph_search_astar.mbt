///===
/// extcore/graph_search_astar

pub(all) struct GraphsearchastarPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn graph_search_astar_make_point(x : Double, y : Double) -> GraphsearchastarPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn graph_search_astar_make_point3(x : Double, y : Double, z : Double) -> GraphsearchastarPoint {
  { x, y, z, label: 0 }
}

pub fn GraphsearchastarPoint::x(self : GraphsearchastarPoint) -> Double { self.x }

pub fn GraphsearchastarPoint::y(self : GraphsearchastarPoint) -> Double { self.y }

pub fn GraphsearchastarPoint::z(self : GraphsearchastarPoint) -> Double { self.z }

pub fn GraphsearchastarPoint::label(self : GraphsearchastarPoint) -> Int { self.label }

pub fn GraphsearchastarPoint::dist(self : GraphsearchastarPoint, other : GraphsearchastarPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn GraphsearchastarPoint::add(self : GraphsearchastarPoint, other : GraphsearchastarPoint) -> GraphsearchastarPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn GraphsearchastarPoint::sub(self : GraphsearchastarPoint, other : GraphsearchastarPoint) -> GraphsearchastarPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn GraphsearchastarPoint::scale(self : GraphsearchastarPoint, s : Double) -> GraphsearchastarPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn GraphsearchastarPoint::dot(self : GraphsearchastarPoint, other : GraphsearchastarPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn GraphsearchastarPoint::cross(self : GraphsearchastarPoint, other : GraphsearchastarPoint) -> GraphsearchastarPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn GraphsearchastarPoint::norm(self : GraphsearchastarPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn GraphsearchastarPoint::normalize(self : GraphsearchastarPoint) -> GraphsearchastarPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn GraphsearchastarPoint::negate(self : GraphsearchastarPoint) -> GraphsearchastarPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn GraphsearchastarPoint::mid(self : GraphsearchastarPoint, other : GraphsearchastarPoint) -> GraphsearchastarPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn GraphsearchastarPoint::lerp(self : GraphsearchastarPoint, other : GraphsearchastarPoint, t : Double) -> GraphsearchastarPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn GraphsearchastarPoint::to_string(self : GraphsearchastarPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct GraphsearchastarSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn graph_search_astar_make_series(vals : Array[Double], name : String) -> GraphsearchastarSeries {
  { vals, name, meta: 0 }
}

pub fn GraphsearchastarSeries::len(self : GraphsearchastarSeries) -> Int { self.vals.length() }

pub fn GraphsearchastarSeries::sum(self : GraphsearchastarSeries) -> Double { @_common.sum(self.vals) }

pub fn GraphsearchastarSeries::mean(self : GraphsearchastarSeries) -> Double { @_common.mean(self.vals) }

pub fn GraphsearchastarSeries::min(self : GraphsearchastarSeries) -> Double { @_common.min(self.vals) }

pub fn GraphsearchastarSeries::max(self : GraphsearchastarSeries) -> Double { @_common.max(self.vals) }

pub fn GraphsearchastarSeries::range(self : GraphsearchastarSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn GraphsearchastarSeries::variance(self : GraphsearchastarSeries) -> Double { @_common.variance(self.vals) }

pub fn GraphsearchastarSeries::std(self : GraphsearchastarSeries) -> Double { @_common.std(self.vals) }

pub fn GraphsearchastarSeries::median(self : GraphsearchastarSeries) -> Double { @_common.median(self.vals) }

pub fn GraphsearchastarSeries::scale(self : GraphsearchastarSeries, f : Double) -> GraphsearchastarSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn GraphsearchastarSeries::add(self : GraphsearchastarSeries, other : GraphsearchastarSeries) -> GraphsearchastarSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn GraphsearchastarSeries::sub(self : GraphsearchastarSeries, other : GraphsearchastarSeries) -> GraphsearchastarSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn GraphsearchastarSeries::normalize(self : GraphsearchastarSeries) -> GraphsearchastarSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn GraphsearchastarSeries::cumsum(self : GraphsearchastarSeries) -> GraphsearchastarSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn GraphsearchastarSeries::to_string(self : GraphsearchastarSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct GraphsearchastarMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn graph_search_astar_make_matrix(rows : Int, cols : Int, val : Double) -> GraphsearchastarMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn graph_search_astar_matrix_identity(n : Int) -> GraphsearchastarMatrix {
  let m = graph_search_astar_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn GraphsearchastarMatrix::get(self : GraphsearchastarMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn GraphsearchastarMatrix::transpose(self : GraphsearchastarMatrix) -> GraphsearchastarMatrix {
  let result = graph_search_astar_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn GraphsearchastarMatrix::add(self : GraphsearchastarMatrix, other : GraphsearchastarMatrix) -> GraphsearchastarMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = graph_search_astar_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn GraphsearchastarMatrix::scale(self : GraphsearchastarMatrix, s : Double) -> GraphsearchastarMatrix {
  let result = graph_search_astar_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn GraphsearchastarMatrix::multiply(self : GraphsearchastarMatrix, other : GraphsearchastarMatrix) -> GraphsearchastarMatrix {
  if self.cols != other.rows { return graph_search_astar_make_matrix(self.rows, other.cols, 0.0) }
  let result = graph_search_astar_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn GraphsearchastarMatrix::trace(self : GraphsearchastarMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn GraphsearchastarMatrix::det(self : GraphsearchastarMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn GraphsearchastarMatrix::norm(self : GraphsearchastarMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn GraphsearchastarMatrix::to_string(self : GraphsearchastarMatrix) -> String {
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

pub(all) struct GraphsearchastarVector {
  comps : Array[Double]
  dim : Int
}

pub fn graph_search_astar_make_vector(comps : Array[Double]) -> GraphsearchastarVector {
  { comps, dim: comps.length() }
}

pub fn graph_search_astar_vector_zero(dim : Int) -> GraphsearchastarVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn GraphsearchastarVector::add(self : GraphsearchastarVector, other : GraphsearchastarVector) -> GraphsearchastarVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn GraphsearchastarVector::sub(self : GraphsearchastarVector, other : GraphsearchastarVector) -> GraphsearchastarVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn GraphsearchastarVector::scale(self : GraphsearchastarVector, s : Double) -> GraphsearchastarVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn GraphsearchastarVector::dot(self : GraphsearchastarVector, other : GraphsearchastarVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn GraphsearchastarVector::norm(self : GraphsearchastarVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn GraphsearchastarVector::normalize(self : GraphsearchastarVector) -> GraphsearchastarVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn GraphsearchastarVector::dist(self : GraphsearchastarVector, other : GraphsearchastarVector) -> Double {
  self.sub(other).norm()
}

pub fn GraphsearchastarVector::to_string(self : GraphsearchastarVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn graph_search_astar_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn graph_search_astar_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn graph_search_astar_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn graph_search_astar_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn graph_search_astar_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn graph_search_astar_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn graph_search_astar_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn graph_search_astar_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn graph_search_astar_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn graph_search_astar_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn graph_search_astar_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn graph_search_astar_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn graph_search_astar_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn graph_search_astar_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn graph_search_astar_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn graph_search_astar_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn graph_search_astar_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn graph_search_astar_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn graph_search_astar_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn graph_search_astar_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn graph_search_astar_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn graph_search_astar_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn graph_search_astar_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn graph_search_astar_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn graph_search_astar_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn graph_search_astar_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn graph_search_astar_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn graph_search_astar_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn graph_search_astar_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct GraphsearchastarFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_search_astar_frame_make(size : Int) -> GraphsearchastarFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_search_astar_frame_len(s : GraphsearchastarFrame) -> Int { s.size }

pub fn graph_search_astar_frame_get(s : GraphsearchastarFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_search_astar_frame_set(s : GraphsearchastarFrame, i : Int, v : Double) -> GraphsearchastarFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_search_astar_frame_sum(s : GraphsearchastarFrame) -> Double { @_common.sum(s.data) }

pub fn graph_search_astar_frame_mean(s : GraphsearchastarFrame) -> Double { @_common.mean(s.data) }

pub fn graph_search_astar_frame_scale(s : GraphsearchastarFrame, f : Double) -> GraphsearchastarFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_search_astar_frame_add(a : GraphsearchastarFrame, b : GraphsearchastarFrame) -> GraphsearchastarFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_search_astar_frame_copy(s : GraphsearchastarFrame) -> GraphsearchastarFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_search_astar_frame_fill(s : GraphsearchastarFrame, v : Double) -> GraphsearchastarFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_search_astar_frame_min(s : GraphsearchastarFrame) -> Double { @_common.min(s.data) }

pub fn graph_search_astar_frame_max(s : GraphsearchastarFrame) -> Double { @_common.max(s.data) }

pub fn graph_search_astar_frame_to_string(s : GraphsearchastarFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphsearchastarTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_search_astar_table_make(size : Int) -> GraphsearchastarTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_search_astar_table_len(s : GraphsearchastarTable) -> Int { s.size }

pub fn graph_search_astar_table_get(s : GraphsearchastarTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_search_astar_table_set(s : GraphsearchastarTable, i : Int, v : Double) -> GraphsearchastarTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_search_astar_table_sum(s : GraphsearchastarTable) -> Double { @_common.sum(s.data) }

pub fn graph_search_astar_table_mean(s : GraphsearchastarTable) -> Double { @_common.mean(s.data) }

pub fn graph_search_astar_table_scale(s : GraphsearchastarTable, f : Double) -> GraphsearchastarTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_search_astar_table_add(a : GraphsearchastarTable, b : GraphsearchastarTable) -> GraphsearchastarTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_search_astar_table_copy(s : GraphsearchastarTable) -> GraphsearchastarTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_search_astar_table_fill(s : GraphsearchastarTable, v : Double) -> GraphsearchastarTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_search_astar_table_min(s : GraphsearchastarTable) -> Double { @_common.min(s.data) }

pub fn graph_search_astar_table_max(s : GraphsearchastarTable) -> Double { @_common.max(s.data) }

pub fn graph_search_astar_table_to_string(s : GraphsearchastarTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphsearchastarGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_search_astar_graphn_make(size : Int) -> GraphsearchastarGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_search_astar_graphn_len(s : GraphsearchastarGraphN) -> Int { s.size }

pub fn graph_search_astar_graphn_get(s : GraphsearchastarGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_search_astar_graphn_set(s : GraphsearchastarGraphN, i : Int, v : Double) -> GraphsearchastarGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_search_astar_graphn_sum(s : GraphsearchastarGraphN) -> Double { @_common.sum(s.data) }

pub fn graph_search_astar_graphn_mean(s : GraphsearchastarGraphN) -> Double { @_common.mean(s.data) }

pub fn graph_search_astar_graphn_scale(s : GraphsearchastarGraphN, f : Double) -> GraphsearchastarGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_search_astar_graphn_add(a : GraphsearchastarGraphN, b : GraphsearchastarGraphN) -> GraphsearchastarGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_search_astar_graphn_copy(s : GraphsearchastarGraphN) -> GraphsearchastarGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_search_astar_graphn_fill(s : GraphsearchastarGraphN, v : Double) -> GraphsearchastarGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_search_astar_graphn_min(s : GraphsearchastarGraphN) -> Double { @_common.min(s.data) }

pub fn graph_search_astar_graphn_max(s : GraphsearchastarGraphN) -> Double { @_common.max(s.data) }

pub fn graph_search_astar_graphn_to_string(s : GraphsearchastarGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphsearchastarNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_search_astar_node_make(size : Int) -> GraphsearchastarNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_search_astar_node_len(s : GraphsearchastarNode) -> Int { s.size }

pub fn graph_search_astar_node_get(s : GraphsearchastarNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_search_astar_node_set(s : GraphsearchastarNode, i : Int, v : Double) -> GraphsearchastarNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_search_astar_node_sum(s : GraphsearchastarNode) -> Double { @_common.sum(s.data) }

pub fn graph_search_astar_node_mean(s : GraphsearchastarNode) -> Double { @_common.mean(s.data) }

pub fn graph_search_astar_node_scale(s : GraphsearchastarNode, f : Double) -> GraphsearchastarNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_search_astar_node_add(a : GraphsearchastarNode, b : GraphsearchastarNode) -> GraphsearchastarNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_search_astar_node_copy(s : GraphsearchastarNode) -> GraphsearchastarNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_search_astar_node_fill(s : GraphsearchastarNode, v : Double) -> GraphsearchastarNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_search_astar_node_min(s : GraphsearchastarNode) -> Double { @_common.min(s.data) }

pub fn graph_search_astar_node_max(s : GraphsearchastarNode) -> Double { @_common.max(s.data) }

pub fn graph_search_astar_node_to_string(s : GraphsearchastarNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphsearchastarEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_search_astar_edge_make(size : Int) -> GraphsearchastarEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_search_astar_edge_len(s : GraphsearchastarEdge) -> Int { s.size }

pub fn graph_search_astar_edge_get(s : GraphsearchastarEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_search_astar_edge_set(s : GraphsearchastarEdge, i : Int, v : Double) -> GraphsearchastarEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_search_astar_edge_sum(s : GraphsearchastarEdge) -> Double { @_common.sum(s.data) }

pub fn graph_search_astar_edge_mean(s : GraphsearchastarEdge) -> Double { @_common.mean(s.data) }

pub fn graph_search_astar_edge_scale(s : GraphsearchastarEdge, f : Double) -> GraphsearchastarEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_search_astar_edge_add(a : GraphsearchastarEdge, b : GraphsearchastarEdge) -> GraphsearchastarEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_search_astar_edge_copy(s : GraphsearchastarEdge) -> GraphsearchastarEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_search_astar_edge_fill(s : GraphsearchastarEdge, v : Double) -> GraphsearchastarEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_search_astar_edge_min(s : GraphsearchastarEdge) -> Double { @_common.min(s.data) }

pub fn graph_search_astar_edge_max(s : GraphsearchastarEdge) -> Double { @_common.max(s.data) }

pub fn graph_search_astar_edge_to_string(s : GraphsearchastarEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphsearchastarPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_search_astar_path_make(size : Int) -> GraphsearchastarPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_search_astar_path_len(s : GraphsearchastarPath) -> Int { s.size }

pub fn graph_search_astar_path_get(s : GraphsearchastarPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_search_astar_path_set(s : GraphsearchastarPath, i : Int, v : Double) -> GraphsearchastarPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_search_astar_path_sum(s : GraphsearchastarPath) -> Double { @_common.sum(s.data) }

pub fn graph_search_astar_path_mean(s : GraphsearchastarPath) -> Double { @_common.mean(s.data) }

pub fn graph_search_astar_path_scale(s : GraphsearchastarPath, f : Double) -> GraphsearchastarPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_search_astar_path_add(a : GraphsearchastarPath, b : GraphsearchastarPath) -> GraphsearchastarPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_search_astar_path_copy(s : GraphsearchastarPath) -> GraphsearchastarPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_search_astar_path_fill(s : GraphsearchastarPath, v : Double) -> GraphsearchastarPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_search_astar_path_min(s : GraphsearchastarPath) -> Double { @_common.min(s.data) }

pub fn graph_search_astar_path_max(s : GraphsearchastarPath) -> Double { @_common.max(s.data) }

pub fn graph_search_astar_path_to_string(s : GraphsearchastarPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphsearchastarCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_search_astar_cluster_make(size : Int) -> GraphsearchastarCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_search_astar_cluster_len(s : GraphsearchastarCluster) -> Int { s.size }

pub fn graph_search_astar_cluster_get(s : GraphsearchastarCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_search_astar_cluster_set(s : GraphsearchastarCluster, i : Int, v : Double) -> GraphsearchastarCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_search_astar_cluster_sum(s : GraphsearchastarCluster) -> Double { @_common.sum(s.data) }

pub fn graph_search_astar_cluster_mean(s : GraphsearchastarCluster) -> Double { @_common.mean(s.data) }

pub fn graph_search_astar_cluster_scale(s : GraphsearchastarCluster, f : Double) -> GraphsearchastarCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_search_astar_cluster_add(a : GraphsearchastarCluster, b : GraphsearchastarCluster) -> GraphsearchastarCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_search_astar_cluster_copy(s : GraphsearchastarCluster) -> GraphsearchastarCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_search_astar_cluster_fill(s : GraphsearchastarCluster, v : Double) -> GraphsearchastarCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_search_astar_cluster_min(s : GraphsearchastarCluster) -> Double { @_common.min(s.data) }

pub fn graph_search_astar_cluster_max(s : GraphsearchastarCluster) -> Double { @_common.max(s.data) }

pub fn graph_search_astar_cluster_to_string(s : GraphsearchastarCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphsearchastarModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_search_astar_model_make(size : Int) -> GraphsearchastarModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_search_astar_model_len(s : GraphsearchastarModel) -> Int { s.size }

pub fn graph_search_astar_model_get(s : GraphsearchastarModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_search_astar_model_set(s : GraphsearchastarModel, i : Int, v : Double) -> GraphsearchastarModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_search_astar_model_sum(s : GraphsearchastarModel) -> Double { @_common.sum(s.data) }

pub fn graph_search_astar_model_mean(s : GraphsearchastarModel) -> Double { @_common.mean(s.data) }

pub fn graph_search_astar_model_scale(s : GraphsearchastarModel, f : Double) -> GraphsearchastarModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_search_astar_model_add(a : GraphsearchastarModel, b : GraphsearchastarModel) -> GraphsearchastarModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_search_astar_model_copy(s : GraphsearchastarModel) -> GraphsearchastarModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_search_astar_model_fill(s : GraphsearchastarModel, v : Double) -> GraphsearchastarModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_search_astar_model_min(s : GraphsearchastarModel) -> Double { @_common.min(s.data) }

pub fn graph_search_astar_model_max(s : GraphsearchastarModel) -> Double { @_common.max(s.data) }

pub fn graph_search_astar_model_to_string(s : GraphsearchastarModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphsearchastarLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_search_astar_layer_make(size : Int) -> GraphsearchastarLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_search_astar_layer_len(s : GraphsearchastarLayer) -> Int { s.size }

pub fn graph_search_astar_layer_get(s : GraphsearchastarLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_search_astar_layer_set(s : GraphsearchastarLayer, i : Int, v : Double) -> GraphsearchastarLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_search_astar_layer_sum(s : GraphsearchastarLayer) -> Double { @_common.sum(s.data) }

pub fn graph_search_astar_layer_mean(s : GraphsearchastarLayer) -> Double { @_common.mean(s.data) }

pub fn graph_search_astar_layer_scale(s : GraphsearchastarLayer, f : Double) -> GraphsearchastarLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_search_astar_layer_add(a : GraphsearchastarLayer, b : GraphsearchastarLayer) -> GraphsearchastarLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_search_astar_layer_copy(s : GraphsearchastarLayer) -> GraphsearchastarLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_search_astar_layer_fill(s : GraphsearchastarLayer, v : Double) -> GraphsearchastarLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_search_astar_layer_min(s : GraphsearchastarLayer) -> Double { @_common.min(s.data) }

pub fn graph_search_astar_layer_max(s : GraphsearchastarLayer) -> Double { @_common.max(s.data) }

pub fn graph_search_astar_layer_to_string(s : GraphsearchastarLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphsearchastarBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_search_astar_buffer_make(size : Int) -> GraphsearchastarBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_search_astar_buffer_len(s : GraphsearchastarBuffer) -> Int { s.size }

pub fn graph_search_astar_buffer_get(s : GraphsearchastarBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_search_astar_buffer_set(s : GraphsearchastarBuffer, i : Int, v : Double) -> GraphsearchastarBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_search_astar_buffer_sum(s : GraphsearchastarBuffer) -> Double { @_common.sum(s.data) }

pub fn graph_search_astar_buffer_mean(s : GraphsearchastarBuffer) -> Double { @_common.mean(s.data) }

pub fn graph_search_astar_buffer_scale(s : GraphsearchastarBuffer, f : Double) -> GraphsearchastarBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_search_astar_buffer_add(a : GraphsearchastarBuffer, b : GraphsearchastarBuffer) -> GraphsearchastarBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_search_astar_buffer_copy(s : GraphsearchastarBuffer) -> GraphsearchastarBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_search_astar_buffer_fill(s : GraphsearchastarBuffer, v : Double) -> GraphsearchastarBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_search_astar_buffer_min(s : GraphsearchastarBuffer) -> Double { @_common.min(s.data) }

pub fn graph_search_astar_buffer_max(s : GraphsearchastarBuffer) -> Double { @_common.max(s.data) }

pub fn graph_search_astar_buffer_to_string(s : GraphsearchastarBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphsearchastarCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_search_astar_cursor_make(size : Int) -> GraphsearchastarCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_search_astar_cursor_len(s : GraphsearchastarCursor) -> Int { s.size }

pub fn graph_search_astar_cursor_get(s : GraphsearchastarCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_search_astar_cursor_set(s : GraphsearchastarCursor, i : Int, v : Double) -> GraphsearchastarCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_search_astar_cursor_sum(s : GraphsearchastarCursor) -> Double { @_common.sum(s.data) }

pub fn graph_search_astar_cursor_mean(s : GraphsearchastarCursor) -> Double { @_common.mean(s.data) }

pub fn graph_search_astar_cursor_scale(s : GraphsearchastarCursor, f : Double) -> GraphsearchastarCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_search_astar_cursor_add(a : GraphsearchastarCursor, b : GraphsearchastarCursor) -> GraphsearchastarCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_search_astar_cursor_copy(s : GraphsearchastarCursor) -> GraphsearchastarCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_search_astar_cursor_fill(s : GraphsearchastarCursor, v : Double) -> GraphsearchastarCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_search_astar_cursor_min(s : GraphsearchastarCursor) -> Double { @_common.min(s.data) }

pub fn graph_search_astar_cursor_max(s : GraphsearchastarCursor) -> Double { @_common.max(s.data) }

pub fn graph_search_astar_cursor_to_string(s : GraphsearchastarCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphsearchastarView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_search_astar_view_make(size : Int) -> GraphsearchastarView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_search_astar_view_len(s : GraphsearchastarView) -> Int { s.size }

pub fn graph_search_astar_view_get(s : GraphsearchastarView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_search_astar_view_set(s : GraphsearchastarView, i : Int, v : Double) -> GraphsearchastarView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_search_astar_view_sum(s : GraphsearchastarView) -> Double { @_common.sum(s.data) }

pub fn graph_search_astar_view_mean(s : GraphsearchastarView) -> Double { @_common.mean(s.data) }

pub fn graph_search_astar_view_scale(s : GraphsearchastarView, f : Double) -> GraphsearchastarView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_search_astar_view_add(a : GraphsearchastarView, b : GraphsearchastarView) -> GraphsearchastarView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_search_astar_view_copy(s : GraphsearchastarView) -> GraphsearchastarView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_search_astar_view_fill(s : GraphsearchastarView, v : Double) -> GraphsearchastarView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_search_astar_view_min(s : GraphsearchastarView) -> Double { @_common.min(s.data) }

pub fn graph_search_astar_view_max(s : GraphsearchastarView) -> Double { @_common.max(s.data) }

pub fn graph_search_astar_view_to_string(s : GraphsearchastarView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphsearchastarRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_search_astar_range_make(size : Int) -> GraphsearchastarRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_search_astar_range_len(s : GraphsearchastarRange) -> Int { s.size }

pub fn graph_search_astar_range_get(s : GraphsearchastarRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_search_astar_range_set(s : GraphsearchastarRange, i : Int, v : Double) -> GraphsearchastarRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_search_astar_range_sum(s : GraphsearchastarRange) -> Double { @_common.sum(s.data) }

pub fn graph_search_astar_range_mean(s : GraphsearchastarRange) -> Double { @_common.mean(s.data) }

pub fn graph_search_astar_range_scale(s : GraphsearchastarRange, f : Double) -> GraphsearchastarRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_search_astar_range_add(a : GraphsearchastarRange, b : GraphsearchastarRange) -> GraphsearchastarRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_search_astar_range_copy(s : GraphsearchastarRange) -> GraphsearchastarRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_search_astar_range_fill(s : GraphsearchastarRange, v : Double) -> GraphsearchastarRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_search_astar_range_min(s : GraphsearchastarRange) -> Double { @_common.min(s.data) }

pub fn graph_search_astar_range_max(s : GraphsearchastarRange) -> Double { @_common.max(s.data) }

pub fn graph_search_astar_range_to_string(s : GraphsearchastarRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphsearchastarSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_search_astar_slice_make(size : Int) -> GraphsearchastarSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_search_astar_slice_len(s : GraphsearchastarSlice) -> Int { s.size }

pub fn graph_search_astar_slice_get(s : GraphsearchastarSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_search_astar_slice_set(s : GraphsearchastarSlice, i : Int, v : Double) -> GraphsearchastarSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_search_astar_slice_sum(s : GraphsearchastarSlice) -> Double { @_common.sum(s.data) }

pub fn graph_search_astar_slice_mean(s : GraphsearchastarSlice) -> Double { @_common.mean(s.data) }

pub fn graph_search_astar_slice_scale(s : GraphsearchastarSlice, f : Double) -> GraphsearchastarSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_search_astar_slice_add(a : GraphsearchastarSlice, b : GraphsearchastarSlice) -> GraphsearchastarSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_search_astar_slice_copy(s : GraphsearchastarSlice) -> GraphsearchastarSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_search_astar_slice_fill(s : GraphsearchastarSlice, v : Double) -> GraphsearchastarSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_search_astar_slice_min(s : GraphsearchastarSlice) -> Double { @_common.min(s.data) }

pub fn graph_search_astar_slice_max(s : GraphsearchastarSlice) -> Double { @_common.max(s.data) }

pub fn graph_search_astar_slice_to_string(s : GraphsearchastarSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

