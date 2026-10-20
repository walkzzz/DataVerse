///===
/// extcore/graph_search_iddfs

pub(all) struct GraphsearchiddfsPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn graph_search_iddfs_make_point(x : Double, y : Double) -> GraphsearchiddfsPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn graph_search_iddfs_make_point3(x : Double, y : Double, z : Double) -> GraphsearchiddfsPoint {
  { x, y, z, label: 0 }
}

pub fn GraphsearchiddfsPoint::x(self : GraphsearchiddfsPoint) -> Double { self.x }

pub fn GraphsearchiddfsPoint::y(self : GraphsearchiddfsPoint) -> Double { self.y }

pub fn GraphsearchiddfsPoint::z(self : GraphsearchiddfsPoint) -> Double { self.z }

pub fn GraphsearchiddfsPoint::label(self : GraphsearchiddfsPoint) -> Int { self.label }

pub fn GraphsearchiddfsPoint::dist(self : GraphsearchiddfsPoint, other : GraphsearchiddfsPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn GraphsearchiddfsPoint::add(self : GraphsearchiddfsPoint, other : GraphsearchiddfsPoint) -> GraphsearchiddfsPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn GraphsearchiddfsPoint::sub(self : GraphsearchiddfsPoint, other : GraphsearchiddfsPoint) -> GraphsearchiddfsPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn GraphsearchiddfsPoint::scale(self : GraphsearchiddfsPoint, s : Double) -> GraphsearchiddfsPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn GraphsearchiddfsPoint::dot(self : GraphsearchiddfsPoint, other : GraphsearchiddfsPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn GraphsearchiddfsPoint::cross(self : GraphsearchiddfsPoint, other : GraphsearchiddfsPoint) -> GraphsearchiddfsPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn GraphsearchiddfsPoint::norm(self : GraphsearchiddfsPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn GraphsearchiddfsPoint::normalize(self : GraphsearchiddfsPoint) -> GraphsearchiddfsPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn GraphsearchiddfsPoint::negate(self : GraphsearchiddfsPoint) -> GraphsearchiddfsPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn GraphsearchiddfsPoint::mid(self : GraphsearchiddfsPoint, other : GraphsearchiddfsPoint) -> GraphsearchiddfsPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn GraphsearchiddfsPoint::lerp(self : GraphsearchiddfsPoint, other : GraphsearchiddfsPoint, t : Double) -> GraphsearchiddfsPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn GraphsearchiddfsPoint::to_string(self : GraphsearchiddfsPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct GraphsearchiddfsSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn graph_search_iddfs_make_series(vals : Array[Double], name : String) -> GraphsearchiddfsSeries {
  { vals, name, meta: 0 }
}

pub fn GraphsearchiddfsSeries::len(self : GraphsearchiddfsSeries) -> Int { self.vals.length() }

pub fn GraphsearchiddfsSeries::sum(self : GraphsearchiddfsSeries) -> Double { @_common.sum(self.vals) }

pub fn GraphsearchiddfsSeries::mean(self : GraphsearchiddfsSeries) -> Double { @_common.mean(self.vals) }

pub fn GraphsearchiddfsSeries::min(self : GraphsearchiddfsSeries) -> Double { @_common.min(self.vals) }

pub fn GraphsearchiddfsSeries::max(self : GraphsearchiddfsSeries) -> Double { @_common.max(self.vals) }

pub fn GraphsearchiddfsSeries::range(self : GraphsearchiddfsSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn GraphsearchiddfsSeries::variance(self : GraphsearchiddfsSeries) -> Double { @_common.variance(self.vals) }

pub fn GraphsearchiddfsSeries::std(self : GraphsearchiddfsSeries) -> Double { @_common.std(self.vals) }

pub fn GraphsearchiddfsSeries::median(self : GraphsearchiddfsSeries) -> Double { @_common.median(self.vals) }

pub fn GraphsearchiddfsSeries::scale(self : GraphsearchiddfsSeries, f : Double) -> GraphsearchiddfsSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn GraphsearchiddfsSeries::add(self : GraphsearchiddfsSeries, other : GraphsearchiddfsSeries) -> GraphsearchiddfsSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn GraphsearchiddfsSeries::sub(self : GraphsearchiddfsSeries, other : GraphsearchiddfsSeries) -> GraphsearchiddfsSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn GraphsearchiddfsSeries::normalize(self : GraphsearchiddfsSeries) -> GraphsearchiddfsSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn GraphsearchiddfsSeries::cumsum(self : GraphsearchiddfsSeries) -> GraphsearchiddfsSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn GraphsearchiddfsSeries::to_string(self : GraphsearchiddfsSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct GraphsearchiddfsMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn graph_search_iddfs_make_matrix(rows : Int, cols : Int, val : Double) -> GraphsearchiddfsMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn graph_search_iddfs_matrix_identity(n : Int) -> GraphsearchiddfsMatrix {
  let m = graph_search_iddfs_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn GraphsearchiddfsMatrix::get(self : GraphsearchiddfsMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn GraphsearchiddfsMatrix::transpose(self : GraphsearchiddfsMatrix) -> GraphsearchiddfsMatrix {
  let result = graph_search_iddfs_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn GraphsearchiddfsMatrix::add(self : GraphsearchiddfsMatrix, other : GraphsearchiddfsMatrix) -> GraphsearchiddfsMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = graph_search_iddfs_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn GraphsearchiddfsMatrix::scale(self : GraphsearchiddfsMatrix, s : Double) -> GraphsearchiddfsMatrix {
  let result = graph_search_iddfs_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn GraphsearchiddfsMatrix::multiply(self : GraphsearchiddfsMatrix, other : GraphsearchiddfsMatrix) -> GraphsearchiddfsMatrix {
  if self.cols != other.rows { return graph_search_iddfs_make_matrix(self.rows, other.cols, 0.0) }
  let result = graph_search_iddfs_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn GraphsearchiddfsMatrix::trace(self : GraphsearchiddfsMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn GraphsearchiddfsMatrix::det(self : GraphsearchiddfsMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn GraphsearchiddfsMatrix::norm(self : GraphsearchiddfsMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn GraphsearchiddfsMatrix::to_string(self : GraphsearchiddfsMatrix) -> String {
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

pub(all) struct GraphsearchiddfsVector {
  comps : Array[Double]
  dim : Int
}

pub fn graph_search_iddfs_make_vector(comps : Array[Double]) -> GraphsearchiddfsVector {
  { comps, dim: comps.length() }
}

pub fn graph_search_iddfs_vector_zero(dim : Int) -> GraphsearchiddfsVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn GraphsearchiddfsVector::add(self : GraphsearchiddfsVector, other : GraphsearchiddfsVector) -> GraphsearchiddfsVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn GraphsearchiddfsVector::sub(self : GraphsearchiddfsVector, other : GraphsearchiddfsVector) -> GraphsearchiddfsVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn GraphsearchiddfsVector::scale(self : GraphsearchiddfsVector, s : Double) -> GraphsearchiddfsVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn GraphsearchiddfsVector::dot(self : GraphsearchiddfsVector, other : GraphsearchiddfsVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn GraphsearchiddfsVector::norm(self : GraphsearchiddfsVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn GraphsearchiddfsVector::normalize(self : GraphsearchiddfsVector) -> GraphsearchiddfsVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn GraphsearchiddfsVector::dist(self : GraphsearchiddfsVector, other : GraphsearchiddfsVector) -> Double {
  self.sub(other).norm()
}

pub fn GraphsearchiddfsVector::to_string(self : GraphsearchiddfsVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn graph_search_iddfs_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn graph_search_iddfs_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn graph_search_iddfs_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn graph_search_iddfs_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn graph_search_iddfs_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn graph_search_iddfs_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn graph_search_iddfs_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn graph_search_iddfs_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn graph_search_iddfs_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn graph_search_iddfs_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn graph_search_iddfs_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn graph_search_iddfs_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn graph_search_iddfs_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn graph_search_iddfs_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn graph_search_iddfs_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn graph_search_iddfs_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn graph_search_iddfs_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn graph_search_iddfs_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn graph_search_iddfs_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn graph_search_iddfs_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn graph_search_iddfs_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn graph_search_iddfs_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn graph_search_iddfs_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn graph_search_iddfs_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn graph_search_iddfs_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn graph_search_iddfs_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn graph_search_iddfs_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn graph_search_iddfs_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn graph_search_iddfs_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct GraphsearchiddfsFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_search_iddfs_frame_make(size : Int) -> GraphsearchiddfsFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_search_iddfs_frame_len(s : GraphsearchiddfsFrame) -> Int { s.size }

pub fn graph_search_iddfs_frame_get(s : GraphsearchiddfsFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_search_iddfs_frame_set(s : GraphsearchiddfsFrame, i : Int, v : Double) -> GraphsearchiddfsFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_search_iddfs_frame_sum(s : GraphsearchiddfsFrame) -> Double { @_common.sum(s.data) }

pub fn graph_search_iddfs_frame_mean(s : GraphsearchiddfsFrame) -> Double { @_common.mean(s.data) }

pub fn graph_search_iddfs_frame_scale(s : GraphsearchiddfsFrame, f : Double) -> GraphsearchiddfsFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_search_iddfs_frame_add(a : GraphsearchiddfsFrame, b : GraphsearchiddfsFrame) -> GraphsearchiddfsFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_search_iddfs_frame_copy(s : GraphsearchiddfsFrame) -> GraphsearchiddfsFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_search_iddfs_frame_fill(s : GraphsearchiddfsFrame, v : Double) -> GraphsearchiddfsFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_search_iddfs_frame_min(s : GraphsearchiddfsFrame) -> Double { @_common.min(s.data) }

pub fn graph_search_iddfs_frame_max(s : GraphsearchiddfsFrame) -> Double { @_common.max(s.data) }

pub fn graph_search_iddfs_frame_to_string(s : GraphsearchiddfsFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphsearchiddfsTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_search_iddfs_table_make(size : Int) -> GraphsearchiddfsTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_search_iddfs_table_len(s : GraphsearchiddfsTable) -> Int { s.size }

pub fn graph_search_iddfs_table_get(s : GraphsearchiddfsTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_search_iddfs_table_set(s : GraphsearchiddfsTable, i : Int, v : Double) -> GraphsearchiddfsTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_search_iddfs_table_sum(s : GraphsearchiddfsTable) -> Double { @_common.sum(s.data) }

pub fn graph_search_iddfs_table_mean(s : GraphsearchiddfsTable) -> Double { @_common.mean(s.data) }

pub fn graph_search_iddfs_table_scale(s : GraphsearchiddfsTable, f : Double) -> GraphsearchiddfsTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_search_iddfs_table_add(a : GraphsearchiddfsTable, b : GraphsearchiddfsTable) -> GraphsearchiddfsTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_search_iddfs_table_copy(s : GraphsearchiddfsTable) -> GraphsearchiddfsTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_search_iddfs_table_fill(s : GraphsearchiddfsTable, v : Double) -> GraphsearchiddfsTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_search_iddfs_table_min(s : GraphsearchiddfsTable) -> Double { @_common.min(s.data) }

pub fn graph_search_iddfs_table_max(s : GraphsearchiddfsTable) -> Double { @_common.max(s.data) }

pub fn graph_search_iddfs_table_to_string(s : GraphsearchiddfsTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphsearchiddfsGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_search_iddfs_graphn_make(size : Int) -> GraphsearchiddfsGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_search_iddfs_graphn_len(s : GraphsearchiddfsGraphN) -> Int { s.size }

pub fn graph_search_iddfs_graphn_get(s : GraphsearchiddfsGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_search_iddfs_graphn_set(s : GraphsearchiddfsGraphN, i : Int, v : Double) -> GraphsearchiddfsGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_search_iddfs_graphn_sum(s : GraphsearchiddfsGraphN) -> Double { @_common.sum(s.data) }

pub fn graph_search_iddfs_graphn_mean(s : GraphsearchiddfsGraphN) -> Double { @_common.mean(s.data) }

pub fn graph_search_iddfs_graphn_scale(s : GraphsearchiddfsGraphN, f : Double) -> GraphsearchiddfsGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_search_iddfs_graphn_add(a : GraphsearchiddfsGraphN, b : GraphsearchiddfsGraphN) -> GraphsearchiddfsGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_search_iddfs_graphn_copy(s : GraphsearchiddfsGraphN) -> GraphsearchiddfsGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_search_iddfs_graphn_fill(s : GraphsearchiddfsGraphN, v : Double) -> GraphsearchiddfsGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_search_iddfs_graphn_min(s : GraphsearchiddfsGraphN) -> Double { @_common.min(s.data) }

pub fn graph_search_iddfs_graphn_max(s : GraphsearchiddfsGraphN) -> Double { @_common.max(s.data) }

pub fn graph_search_iddfs_graphn_to_string(s : GraphsearchiddfsGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphsearchiddfsNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_search_iddfs_node_make(size : Int) -> GraphsearchiddfsNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_search_iddfs_node_len(s : GraphsearchiddfsNode) -> Int { s.size }

pub fn graph_search_iddfs_node_get(s : GraphsearchiddfsNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_search_iddfs_node_set(s : GraphsearchiddfsNode, i : Int, v : Double) -> GraphsearchiddfsNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_search_iddfs_node_sum(s : GraphsearchiddfsNode) -> Double { @_common.sum(s.data) }

pub fn graph_search_iddfs_node_mean(s : GraphsearchiddfsNode) -> Double { @_common.mean(s.data) }

pub fn graph_search_iddfs_node_scale(s : GraphsearchiddfsNode, f : Double) -> GraphsearchiddfsNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_search_iddfs_node_add(a : GraphsearchiddfsNode, b : GraphsearchiddfsNode) -> GraphsearchiddfsNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_search_iddfs_node_copy(s : GraphsearchiddfsNode) -> GraphsearchiddfsNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_search_iddfs_node_fill(s : GraphsearchiddfsNode, v : Double) -> GraphsearchiddfsNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_search_iddfs_node_min(s : GraphsearchiddfsNode) -> Double { @_common.min(s.data) }

pub fn graph_search_iddfs_node_max(s : GraphsearchiddfsNode) -> Double { @_common.max(s.data) }

pub fn graph_search_iddfs_node_to_string(s : GraphsearchiddfsNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphsearchiddfsEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_search_iddfs_edge_make(size : Int) -> GraphsearchiddfsEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_search_iddfs_edge_len(s : GraphsearchiddfsEdge) -> Int { s.size }

pub fn graph_search_iddfs_edge_get(s : GraphsearchiddfsEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_search_iddfs_edge_set(s : GraphsearchiddfsEdge, i : Int, v : Double) -> GraphsearchiddfsEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_search_iddfs_edge_sum(s : GraphsearchiddfsEdge) -> Double { @_common.sum(s.data) }

pub fn graph_search_iddfs_edge_mean(s : GraphsearchiddfsEdge) -> Double { @_common.mean(s.data) }

pub fn graph_search_iddfs_edge_scale(s : GraphsearchiddfsEdge, f : Double) -> GraphsearchiddfsEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_search_iddfs_edge_add(a : GraphsearchiddfsEdge, b : GraphsearchiddfsEdge) -> GraphsearchiddfsEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_search_iddfs_edge_copy(s : GraphsearchiddfsEdge) -> GraphsearchiddfsEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_search_iddfs_edge_fill(s : GraphsearchiddfsEdge, v : Double) -> GraphsearchiddfsEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_search_iddfs_edge_min(s : GraphsearchiddfsEdge) -> Double { @_common.min(s.data) }

pub fn graph_search_iddfs_edge_max(s : GraphsearchiddfsEdge) -> Double { @_common.max(s.data) }

pub fn graph_search_iddfs_edge_to_string(s : GraphsearchiddfsEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphsearchiddfsPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_search_iddfs_path_make(size : Int) -> GraphsearchiddfsPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_search_iddfs_path_len(s : GraphsearchiddfsPath) -> Int { s.size }

pub fn graph_search_iddfs_path_get(s : GraphsearchiddfsPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_search_iddfs_path_set(s : GraphsearchiddfsPath, i : Int, v : Double) -> GraphsearchiddfsPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_search_iddfs_path_sum(s : GraphsearchiddfsPath) -> Double { @_common.sum(s.data) }

pub fn graph_search_iddfs_path_mean(s : GraphsearchiddfsPath) -> Double { @_common.mean(s.data) }

pub fn graph_search_iddfs_path_scale(s : GraphsearchiddfsPath, f : Double) -> GraphsearchiddfsPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_search_iddfs_path_add(a : GraphsearchiddfsPath, b : GraphsearchiddfsPath) -> GraphsearchiddfsPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_search_iddfs_path_copy(s : GraphsearchiddfsPath) -> GraphsearchiddfsPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_search_iddfs_path_fill(s : GraphsearchiddfsPath, v : Double) -> GraphsearchiddfsPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_search_iddfs_path_min(s : GraphsearchiddfsPath) -> Double { @_common.min(s.data) }

pub fn graph_search_iddfs_path_max(s : GraphsearchiddfsPath) -> Double { @_common.max(s.data) }

pub fn graph_search_iddfs_path_to_string(s : GraphsearchiddfsPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphsearchiddfsCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_search_iddfs_cluster_make(size : Int) -> GraphsearchiddfsCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_search_iddfs_cluster_len(s : GraphsearchiddfsCluster) -> Int { s.size }

pub fn graph_search_iddfs_cluster_get(s : GraphsearchiddfsCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_search_iddfs_cluster_set(s : GraphsearchiddfsCluster, i : Int, v : Double) -> GraphsearchiddfsCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_search_iddfs_cluster_sum(s : GraphsearchiddfsCluster) -> Double { @_common.sum(s.data) }

pub fn graph_search_iddfs_cluster_mean(s : GraphsearchiddfsCluster) -> Double { @_common.mean(s.data) }

pub fn graph_search_iddfs_cluster_scale(s : GraphsearchiddfsCluster, f : Double) -> GraphsearchiddfsCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_search_iddfs_cluster_add(a : GraphsearchiddfsCluster, b : GraphsearchiddfsCluster) -> GraphsearchiddfsCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_search_iddfs_cluster_copy(s : GraphsearchiddfsCluster) -> GraphsearchiddfsCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_search_iddfs_cluster_fill(s : GraphsearchiddfsCluster, v : Double) -> GraphsearchiddfsCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_search_iddfs_cluster_min(s : GraphsearchiddfsCluster) -> Double { @_common.min(s.data) }

pub fn graph_search_iddfs_cluster_max(s : GraphsearchiddfsCluster) -> Double { @_common.max(s.data) }

pub fn graph_search_iddfs_cluster_to_string(s : GraphsearchiddfsCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphsearchiddfsModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_search_iddfs_model_make(size : Int) -> GraphsearchiddfsModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_search_iddfs_model_len(s : GraphsearchiddfsModel) -> Int { s.size }

pub fn graph_search_iddfs_model_get(s : GraphsearchiddfsModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_search_iddfs_model_set(s : GraphsearchiddfsModel, i : Int, v : Double) -> GraphsearchiddfsModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_search_iddfs_model_sum(s : GraphsearchiddfsModel) -> Double { @_common.sum(s.data) }

pub fn graph_search_iddfs_model_mean(s : GraphsearchiddfsModel) -> Double { @_common.mean(s.data) }

pub fn graph_search_iddfs_model_scale(s : GraphsearchiddfsModel, f : Double) -> GraphsearchiddfsModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_search_iddfs_model_add(a : GraphsearchiddfsModel, b : GraphsearchiddfsModel) -> GraphsearchiddfsModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_search_iddfs_model_copy(s : GraphsearchiddfsModel) -> GraphsearchiddfsModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_search_iddfs_model_fill(s : GraphsearchiddfsModel, v : Double) -> GraphsearchiddfsModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_search_iddfs_model_min(s : GraphsearchiddfsModel) -> Double { @_common.min(s.data) }

pub fn graph_search_iddfs_model_max(s : GraphsearchiddfsModel) -> Double { @_common.max(s.data) }

pub fn graph_search_iddfs_model_to_string(s : GraphsearchiddfsModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphsearchiddfsLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_search_iddfs_layer_make(size : Int) -> GraphsearchiddfsLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_search_iddfs_layer_len(s : GraphsearchiddfsLayer) -> Int { s.size }

pub fn graph_search_iddfs_layer_get(s : GraphsearchiddfsLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_search_iddfs_layer_set(s : GraphsearchiddfsLayer, i : Int, v : Double) -> GraphsearchiddfsLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_search_iddfs_layer_sum(s : GraphsearchiddfsLayer) -> Double { @_common.sum(s.data) }

pub fn graph_search_iddfs_layer_mean(s : GraphsearchiddfsLayer) -> Double { @_common.mean(s.data) }

pub fn graph_search_iddfs_layer_scale(s : GraphsearchiddfsLayer, f : Double) -> GraphsearchiddfsLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_search_iddfs_layer_add(a : GraphsearchiddfsLayer, b : GraphsearchiddfsLayer) -> GraphsearchiddfsLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_search_iddfs_layer_copy(s : GraphsearchiddfsLayer) -> GraphsearchiddfsLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_search_iddfs_layer_fill(s : GraphsearchiddfsLayer, v : Double) -> GraphsearchiddfsLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_search_iddfs_layer_min(s : GraphsearchiddfsLayer) -> Double { @_common.min(s.data) }

pub fn graph_search_iddfs_layer_max(s : GraphsearchiddfsLayer) -> Double { @_common.max(s.data) }

pub fn graph_search_iddfs_layer_to_string(s : GraphsearchiddfsLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphsearchiddfsBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_search_iddfs_buffer_make(size : Int) -> GraphsearchiddfsBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_search_iddfs_buffer_len(s : GraphsearchiddfsBuffer) -> Int { s.size }

pub fn graph_search_iddfs_buffer_get(s : GraphsearchiddfsBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_search_iddfs_buffer_set(s : GraphsearchiddfsBuffer, i : Int, v : Double) -> GraphsearchiddfsBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_search_iddfs_buffer_sum(s : GraphsearchiddfsBuffer) -> Double { @_common.sum(s.data) }

pub fn graph_search_iddfs_buffer_mean(s : GraphsearchiddfsBuffer) -> Double { @_common.mean(s.data) }

pub fn graph_search_iddfs_buffer_scale(s : GraphsearchiddfsBuffer, f : Double) -> GraphsearchiddfsBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_search_iddfs_buffer_add(a : GraphsearchiddfsBuffer, b : GraphsearchiddfsBuffer) -> GraphsearchiddfsBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_search_iddfs_buffer_copy(s : GraphsearchiddfsBuffer) -> GraphsearchiddfsBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_search_iddfs_buffer_fill(s : GraphsearchiddfsBuffer, v : Double) -> GraphsearchiddfsBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_search_iddfs_buffer_min(s : GraphsearchiddfsBuffer) -> Double { @_common.min(s.data) }

pub fn graph_search_iddfs_buffer_max(s : GraphsearchiddfsBuffer) -> Double { @_common.max(s.data) }

pub fn graph_search_iddfs_buffer_to_string(s : GraphsearchiddfsBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphsearchiddfsCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_search_iddfs_cursor_make(size : Int) -> GraphsearchiddfsCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_search_iddfs_cursor_len(s : GraphsearchiddfsCursor) -> Int { s.size }

pub fn graph_search_iddfs_cursor_get(s : GraphsearchiddfsCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_search_iddfs_cursor_set(s : GraphsearchiddfsCursor, i : Int, v : Double) -> GraphsearchiddfsCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_search_iddfs_cursor_sum(s : GraphsearchiddfsCursor) -> Double { @_common.sum(s.data) }

pub fn graph_search_iddfs_cursor_mean(s : GraphsearchiddfsCursor) -> Double { @_common.mean(s.data) }

pub fn graph_search_iddfs_cursor_scale(s : GraphsearchiddfsCursor, f : Double) -> GraphsearchiddfsCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_search_iddfs_cursor_add(a : GraphsearchiddfsCursor, b : GraphsearchiddfsCursor) -> GraphsearchiddfsCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_search_iddfs_cursor_copy(s : GraphsearchiddfsCursor) -> GraphsearchiddfsCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_search_iddfs_cursor_fill(s : GraphsearchiddfsCursor, v : Double) -> GraphsearchiddfsCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_search_iddfs_cursor_min(s : GraphsearchiddfsCursor) -> Double { @_common.min(s.data) }

pub fn graph_search_iddfs_cursor_max(s : GraphsearchiddfsCursor) -> Double { @_common.max(s.data) }

pub fn graph_search_iddfs_cursor_to_string(s : GraphsearchiddfsCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphsearchiddfsView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_search_iddfs_view_make(size : Int) -> GraphsearchiddfsView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_search_iddfs_view_len(s : GraphsearchiddfsView) -> Int { s.size }

pub fn graph_search_iddfs_view_get(s : GraphsearchiddfsView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_search_iddfs_view_set(s : GraphsearchiddfsView, i : Int, v : Double) -> GraphsearchiddfsView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_search_iddfs_view_sum(s : GraphsearchiddfsView) -> Double { @_common.sum(s.data) }

pub fn graph_search_iddfs_view_mean(s : GraphsearchiddfsView) -> Double { @_common.mean(s.data) }

pub fn graph_search_iddfs_view_scale(s : GraphsearchiddfsView, f : Double) -> GraphsearchiddfsView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_search_iddfs_view_add(a : GraphsearchiddfsView, b : GraphsearchiddfsView) -> GraphsearchiddfsView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_search_iddfs_view_copy(s : GraphsearchiddfsView) -> GraphsearchiddfsView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_search_iddfs_view_fill(s : GraphsearchiddfsView, v : Double) -> GraphsearchiddfsView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_search_iddfs_view_min(s : GraphsearchiddfsView) -> Double { @_common.min(s.data) }

pub fn graph_search_iddfs_view_max(s : GraphsearchiddfsView) -> Double { @_common.max(s.data) }

pub fn graph_search_iddfs_view_to_string(s : GraphsearchiddfsView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphsearchiddfsRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_search_iddfs_range_make(size : Int) -> GraphsearchiddfsRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_search_iddfs_range_len(s : GraphsearchiddfsRange) -> Int { s.size }

pub fn graph_search_iddfs_range_get(s : GraphsearchiddfsRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_search_iddfs_range_set(s : GraphsearchiddfsRange, i : Int, v : Double) -> GraphsearchiddfsRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_search_iddfs_range_sum(s : GraphsearchiddfsRange) -> Double { @_common.sum(s.data) }

pub fn graph_search_iddfs_range_mean(s : GraphsearchiddfsRange) -> Double { @_common.mean(s.data) }

pub fn graph_search_iddfs_range_scale(s : GraphsearchiddfsRange, f : Double) -> GraphsearchiddfsRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_search_iddfs_range_add(a : GraphsearchiddfsRange, b : GraphsearchiddfsRange) -> GraphsearchiddfsRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_search_iddfs_range_copy(s : GraphsearchiddfsRange) -> GraphsearchiddfsRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_search_iddfs_range_fill(s : GraphsearchiddfsRange, v : Double) -> GraphsearchiddfsRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_search_iddfs_range_min(s : GraphsearchiddfsRange) -> Double { @_common.min(s.data) }

pub fn graph_search_iddfs_range_max(s : GraphsearchiddfsRange) -> Double { @_common.max(s.data) }

pub fn graph_search_iddfs_range_to_string(s : GraphsearchiddfsRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphsearchiddfsSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_search_iddfs_slice_make(size : Int) -> GraphsearchiddfsSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_search_iddfs_slice_len(s : GraphsearchiddfsSlice) -> Int { s.size }

pub fn graph_search_iddfs_slice_get(s : GraphsearchiddfsSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_search_iddfs_slice_set(s : GraphsearchiddfsSlice, i : Int, v : Double) -> GraphsearchiddfsSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_search_iddfs_slice_sum(s : GraphsearchiddfsSlice) -> Double { @_common.sum(s.data) }

pub fn graph_search_iddfs_slice_mean(s : GraphsearchiddfsSlice) -> Double { @_common.mean(s.data) }

pub fn graph_search_iddfs_slice_scale(s : GraphsearchiddfsSlice, f : Double) -> GraphsearchiddfsSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_search_iddfs_slice_add(a : GraphsearchiddfsSlice, b : GraphsearchiddfsSlice) -> GraphsearchiddfsSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_search_iddfs_slice_copy(s : GraphsearchiddfsSlice) -> GraphsearchiddfsSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_search_iddfs_slice_fill(s : GraphsearchiddfsSlice, v : Double) -> GraphsearchiddfsSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_search_iddfs_slice_min(s : GraphsearchiddfsSlice) -> Double { @_common.min(s.data) }

pub fn graph_search_iddfs_slice_max(s : GraphsearchiddfsSlice) -> Double { @_common.max(s.data) }

pub fn graph_search_iddfs_slice_to_string(s : GraphsearchiddfsSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

