///===
/// extcore/graph_search_bds

pub(all) struct GraphsearchbdsPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn graph_search_bds_make_point(x : Double, y : Double) -> GraphsearchbdsPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn graph_search_bds_make_point3(x : Double, y : Double, z : Double) -> GraphsearchbdsPoint {
  { x, y, z, label: 0 }
}

pub fn GraphsearchbdsPoint::x(self : GraphsearchbdsPoint) -> Double { self.x }

pub fn GraphsearchbdsPoint::y(self : GraphsearchbdsPoint) -> Double { self.y }

pub fn GraphsearchbdsPoint::z(self : GraphsearchbdsPoint) -> Double { self.z }

pub fn GraphsearchbdsPoint::label(self : GraphsearchbdsPoint) -> Int { self.label }

pub fn GraphsearchbdsPoint::dist(self : GraphsearchbdsPoint, other : GraphsearchbdsPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn GraphsearchbdsPoint::add(self : GraphsearchbdsPoint, other : GraphsearchbdsPoint) -> GraphsearchbdsPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn GraphsearchbdsPoint::sub(self : GraphsearchbdsPoint, other : GraphsearchbdsPoint) -> GraphsearchbdsPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn GraphsearchbdsPoint::scale(self : GraphsearchbdsPoint, s : Double) -> GraphsearchbdsPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn GraphsearchbdsPoint::dot(self : GraphsearchbdsPoint, other : GraphsearchbdsPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn GraphsearchbdsPoint::cross(self : GraphsearchbdsPoint, other : GraphsearchbdsPoint) -> GraphsearchbdsPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn GraphsearchbdsPoint::norm(self : GraphsearchbdsPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn GraphsearchbdsPoint::normalize(self : GraphsearchbdsPoint) -> GraphsearchbdsPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn GraphsearchbdsPoint::negate(self : GraphsearchbdsPoint) -> GraphsearchbdsPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn GraphsearchbdsPoint::mid(self : GraphsearchbdsPoint, other : GraphsearchbdsPoint) -> GraphsearchbdsPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn GraphsearchbdsPoint::lerp(self : GraphsearchbdsPoint, other : GraphsearchbdsPoint, t : Double) -> GraphsearchbdsPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn GraphsearchbdsPoint::to_string(self : GraphsearchbdsPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct GraphsearchbdsSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn graph_search_bds_make_series(vals : Array[Double], name : String) -> GraphsearchbdsSeries {
  { vals, name, meta: 0 }
}

pub fn GraphsearchbdsSeries::len(self : GraphsearchbdsSeries) -> Int { self.vals.length() }

pub fn GraphsearchbdsSeries::sum(self : GraphsearchbdsSeries) -> Double { @_common.sum(self.vals) }

pub fn GraphsearchbdsSeries::mean(self : GraphsearchbdsSeries) -> Double { @_common.mean(self.vals) }

pub fn GraphsearchbdsSeries::min(self : GraphsearchbdsSeries) -> Double { @_common.min(self.vals) }

pub fn GraphsearchbdsSeries::max(self : GraphsearchbdsSeries) -> Double { @_common.max(self.vals) }

pub fn GraphsearchbdsSeries::range(self : GraphsearchbdsSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn GraphsearchbdsSeries::variance(self : GraphsearchbdsSeries) -> Double { @_common.variance(self.vals) }

pub fn GraphsearchbdsSeries::std(self : GraphsearchbdsSeries) -> Double { @_common.std(self.vals) }

pub fn GraphsearchbdsSeries::median(self : GraphsearchbdsSeries) -> Double { @_common.median(self.vals) }

pub fn GraphsearchbdsSeries::scale(self : GraphsearchbdsSeries, f : Double) -> GraphsearchbdsSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn GraphsearchbdsSeries::add(self : GraphsearchbdsSeries, other : GraphsearchbdsSeries) -> GraphsearchbdsSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn GraphsearchbdsSeries::sub(self : GraphsearchbdsSeries, other : GraphsearchbdsSeries) -> GraphsearchbdsSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn GraphsearchbdsSeries::normalize(self : GraphsearchbdsSeries) -> GraphsearchbdsSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn GraphsearchbdsSeries::cumsum(self : GraphsearchbdsSeries) -> GraphsearchbdsSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn GraphsearchbdsSeries::to_string(self : GraphsearchbdsSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct GraphsearchbdsMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn graph_search_bds_make_matrix(rows : Int, cols : Int, val : Double) -> GraphsearchbdsMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn graph_search_bds_matrix_identity(n : Int) -> GraphsearchbdsMatrix {
  let m = graph_search_bds_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn GraphsearchbdsMatrix::get(self : GraphsearchbdsMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn GraphsearchbdsMatrix::transpose(self : GraphsearchbdsMatrix) -> GraphsearchbdsMatrix {
  let result = graph_search_bds_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn GraphsearchbdsMatrix::add(self : GraphsearchbdsMatrix, other : GraphsearchbdsMatrix) -> GraphsearchbdsMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = graph_search_bds_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn GraphsearchbdsMatrix::scale(self : GraphsearchbdsMatrix, s : Double) -> GraphsearchbdsMatrix {
  let result = graph_search_bds_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn GraphsearchbdsMatrix::multiply(self : GraphsearchbdsMatrix, other : GraphsearchbdsMatrix) -> GraphsearchbdsMatrix {
  if self.cols != other.rows { return graph_search_bds_make_matrix(self.rows, other.cols, 0.0) }
  let result = graph_search_bds_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn GraphsearchbdsMatrix::trace(self : GraphsearchbdsMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn GraphsearchbdsMatrix::det(self : GraphsearchbdsMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn GraphsearchbdsMatrix::norm(self : GraphsearchbdsMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn GraphsearchbdsMatrix::to_string(self : GraphsearchbdsMatrix) -> String {
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

pub(all) struct GraphsearchbdsVector {
  comps : Array[Double]
  dim : Int
}

pub fn graph_search_bds_make_vector(comps : Array[Double]) -> GraphsearchbdsVector {
  { comps, dim: comps.length() }
}

pub fn graph_search_bds_vector_zero(dim : Int) -> GraphsearchbdsVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn GraphsearchbdsVector::add(self : GraphsearchbdsVector, other : GraphsearchbdsVector) -> GraphsearchbdsVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn GraphsearchbdsVector::sub(self : GraphsearchbdsVector, other : GraphsearchbdsVector) -> GraphsearchbdsVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn GraphsearchbdsVector::scale(self : GraphsearchbdsVector, s : Double) -> GraphsearchbdsVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn GraphsearchbdsVector::dot(self : GraphsearchbdsVector, other : GraphsearchbdsVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn GraphsearchbdsVector::norm(self : GraphsearchbdsVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn GraphsearchbdsVector::normalize(self : GraphsearchbdsVector) -> GraphsearchbdsVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn GraphsearchbdsVector::dist(self : GraphsearchbdsVector, other : GraphsearchbdsVector) -> Double {
  self.sub(other).norm()
}

pub fn GraphsearchbdsVector::to_string(self : GraphsearchbdsVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn graph_search_bds_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn graph_search_bds_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn graph_search_bds_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn graph_search_bds_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn graph_search_bds_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn graph_search_bds_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn graph_search_bds_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn graph_search_bds_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn graph_search_bds_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn graph_search_bds_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn graph_search_bds_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn graph_search_bds_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn graph_search_bds_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn graph_search_bds_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn graph_search_bds_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn graph_search_bds_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn graph_search_bds_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn graph_search_bds_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn graph_search_bds_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn graph_search_bds_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn graph_search_bds_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn graph_search_bds_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn graph_search_bds_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn graph_search_bds_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn graph_search_bds_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn graph_search_bds_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn graph_search_bds_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn graph_search_bds_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn graph_search_bds_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct GraphsearchbdsFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_search_bds_frame_make(size : Int) -> GraphsearchbdsFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_search_bds_frame_len(s : GraphsearchbdsFrame) -> Int { s.size }

pub fn graph_search_bds_frame_get(s : GraphsearchbdsFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_search_bds_frame_set(s : GraphsearchbdsFrame, i : Int, v : Double) -> GraphsearchbdsFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_search_bds_frame_sum(s : GraphsearchbdsFrame) -> Double { @_common.sum(s.data) }

pub fn graph_search_bds_frame_mean(s : GraphsearchbdsFrame) -> Double { @_common.mean(s.data) }

pub fn graph_search_bds_frame_scale(s : GraphsearchbdsFrame, f : Double) -> GraphsearchbdsFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_search_bds_frame_add(a : GraphsearchbdsFrame, b : GraphsearchbdsFrame) -> GraphsearchbdsFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_search_bds_frame_copy(s : GraphsearchbdsFrame) -> GraphsearchbdsFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_search_bds_frame_fill(s : GraphsearchbdsFrame, v : Double) -> GraphsearchbdsFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_search_bds_frame_min(s : GraphsearchbdsFrame) -> Double { @_common.min(s.data) }

pub fn graph_search_bds_frame_max(s : GraphsearchbdsFrame) -> Double { @_common.max(s.data) }

pub fn graph_search_bds_frame_to_string(s : GraphsearchbdsFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphsearchbdsTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_search_bds_table_make(size : Int) -> GraphsearchbdsTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_search_bds_table_len(s : GraphsearchbdsTable) -> Int { s.size }

pub fn graph_search_bds_table_get(s : GraphsearchbdsTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_search_bds_table_set(s : GraphsearchbdsTable, i : Int, v : Double) -> GraphsearchbdsTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_search_bds_table_sum(s : GraphsearchbdsTable) -> Double { @_common.sum(s.data) }

pub fn graph_search_bds_table_mean(s : GraphsearchbdsTable) -> Double { @_common.mean(s.data) }

pub fn graph_search_bds_table_scale(s : GraphsearchbdsTable, f : Double) -> GraphsearchbdsTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_search_bds_table_add(a : GraphsearchbdsTable, b : GraphsearchbdsTable) -> GraphsearchbdsTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_search_bds_table_copy(s : GraphsearchbdsTable) -> GraphsearchbdsTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_search_bds_table_fill(s : GraphsearchbdsTable, v : Double) -> GraphsearchbdsTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_search_bds_table_min(s : GraphsearchbdsTable) -> Double { @_common.min(s.data) }

pub fn graph_search_bds_table_max(s : GraphsearchbdsTable) -> Double { @_common.max(s.data) }

pub fn graph_search_bds_table_to_string(s : GraphsearchbdsTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphsearchbdsGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_search_bds_graphn_make(size : Int) -> GraphsearchbdsGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_search_bds_graphn_len(s : GraphsearchbdsGraphN) -> Int { s.size }

pub fn graph_search_bds_graphn_get(s : GraphsearchbdsGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_search_bds_graphn_set(s : GraphsearchbdsGraphN, i : Int, v : Double) -> GraphsearchbdsGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_search_bds_graphn_sum(s : GraphsearchbdsGraphN) -> Double { @_common.sum(s.data) }

pub fn graph_search_bds_graphn_mean(s : GraphsearchbdsGraphN) -> Double { @_common.mean(s.data) }

pub fn graph_search_bds_graphn_scale(s : GraphsearchbdsGraphN, f : Double) -> GraphsearchbdsGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_search_bds_graphn_add(a : GraphsearchbdsGraphN, b : GraphsearchbdsGraphN) -> GraphsearchbdsGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_search_bds_graphn_copy(s : GraphsearchbdsGraphN) -> GraphsearchbdsGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_search_bds_graphn_fill(s : GraphsearchbdsGraphN, v : Double) -> GraphsearchbdsGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_search_bds_graphn_min(s : GraphsearchbdsGraphN) -> Double { @_common.min(s.data) }

pub fn graph_search_bds_graphn_max(s : GraphsearchbdsGraphN) -> Double { @_common.max(s.data) }

pub fn graph_search_bds_graphn_to_string(s : GraphsearchbdsGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphsearchbdsNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_search_bds_node_make(size : Int) -> GraphsearchbdsNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_search_bds_node_len(s : GraphsearchbdsNode) -> Int { s.size }

pub fn graph_search_bds_node_get(s : GraphsearchbdsNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_search_bds_node_set(s : GraphsearchbdsNode, i : Int, v : Double) -> GraphsearchbdsNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_search_bds_node_sum(s : GraphsearchbdsNode) -> Double { @_common.sum(s.data) }

pub fn graph_search_bds_node_mean(s : GraphsearchbdsNode) -> Double { @_common.mean(s.data) }

pub fn graph_search_bds_node_scale(s : GraphsearchbdsNode, f : Double) -> GraphsearchbdsNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_search_bds_node_add(a : GraphsearchbdsNode, b : GraphsearchbdsNode) -> GraphsearchbdsNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_search_bds_node_copy(s : GraphsearchbdsNode) -> GraphsearchbdsNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_search_bds_node_fill(s : GraphsearchbdsNode, v : Double) -> GraphsearchbdsNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_search_bds_node_min(s : GraphsearchbdsNode) -> Double { @_common.min(s.data) }

pub fn graph_search_bds_node_max(s : GraphsearchbdsNode) -> Double { @_common.max(s.data) }

pub fn graph_search_bds_node_to_string(s : GraphsearchbdsNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphsearchbdsEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_search_bds_edge_make(size : Int) -> GraphsearchbdsEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_search_bds_edge_len(s : GraphsearchbdsEdge) -> Int { s.size }

pub fn graph_search_bds_edge_get(s : GraphsearchbdsEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_search_bds_edge_set(s : GraphsearchbdsEdge, i : Int, v : Double) -> GraphsearchbdsEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_search_bds_edge_sum(s : GraphsearchbdsEdge) -> Double { @_common.sum(s.data) }

pub fn graph_search_bds_edge_mean(s : GraphsearchbdsEdge) -> Double { @_common.mean(s.data) }

pub fn graph_search_bds_edge_scale(s : GraphsearchbdsEdge, f : Double) -> GraphsearchbdsEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_search_bds_edge_add(a : GraphsearchbdsEdge, b : GraphsearchbdsEdge) -> GraphsearchbdsEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_search_bds_edge_copy(s : GraphsearchbdsEdge) -> GraphsearchbdsEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_search_bds_edge_fill(s : GraphsearchbdsEdge, v : Double) -> GraphsearchbdsEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_search_bds_edge_min(s : GraphsearchbdsEdge) -> Double { @_common.min(s.data) }

pub fn graph_search_bds_edge_max(s : GraphsearchbdsEdge) -> Double { @_common.max(s.data) }

pub fn graph_search_bds_edge_to_string(s : GraphsearchbdsEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphsearchbdsPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_search_bds_path_make(size : Int) -> GraphsearchbdsPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_search_bds_path_len(s : GraphsearchbdsPath) -> Int { s.size }

pub fn graph_search_bds_path_get(s : GraphsearchbdsPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_search_bds_path_set(s : GraphsearchbdsPath, i : Int, v : Double) -> GraphsearchbdsPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_search_bds_path_sum(s : GraphsearchbdsPath) -> Double { @_common.sum(s.data) }

pub fn graph_search_bds_path_mean(s : GraphsearchbdsPath) -> Double { @_common.mean(s.data) }

pub fn graph_search_bds_path_scale(s : GraphsearchbdsPath, f : Double) -> GraphsearchbdsPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_search_bds_path_add(a : GraphsearchbdsPath, b : GraphsearchbdsPath) -> GraphsearchbdsPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_search_bds_path_copy(s : GraphsearchbdsPath) -> GraphsearchbdsPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_search_bds_path_fill(s : GraphsearchbdsPath, v : Double) -> GraphsearchbdsPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_search_bds_path_min(s : GraphsearchbdsPath) -> Double { @_common.min(s.data) }

pub fn graph_search_bds_path_max(s : GraphsearchbdsPath) -> Double { @_common.max(s.data) }

pub fn graph_search_bds_path_to_string(s : GraphsearchbdsPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphsearchbdsCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_search_bds_cluster_make(size : Int) -> GraphsearchbdsCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_search_bds_cluster_len(s : GraphsearchbdsCluster) -> Int { s.size }

pub fn graph_search_bds_cluster_get(s : GraphsearchbdsCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_search_bds_cluster_set(s : GraphsearchbdsCluster, i : Int, v : Double) -> GraphsearchbdsCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_search_bds_cluster_sum(s : GraphsearchbdsCluster) -> Double { @_common.sum(s.data) }

pub fn graph_search_bds_cluster_mean(s : GraphsearchbdsCluster) -> Double { @_common.mean(s.data) }

pub fn graph_search_bds_cluster_scale(s : GraphsearchbdsCluster, f : Double) -> GraphsearchbdsCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_search_bds_cluster_add(a : GraphsearchbdsCluster, b : GraphsearchbdsCluster) -> GraphsearchbdsCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_search_bds_cluster_copy(s : GraphsearchbdsCluster) -> GraphsearchbdsCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_search_bds_cluster_fill(s : GraphsearchbdsCluster, v : Double) -> GraphsearchbdsCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_search_bds_cluster_min(s : GraphsearchbdsCluster) -> Double { @_common.min(s.data) }

pub fn graph_search_bds_cluster_max(s : GraphsearchbdsCluster) -> Double { @_common.max(s.data) }

pub fn graph_search_bds_cluster_to_string(s : GraphsearchbdsCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphsearchbdsModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_search_bds_model_make(size : Int) -> GraphsearchbdsModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_search_bds_model_len(s : GraphsearchbdsModel) -> Int { s.size }

pub fn graph_search_bds_model_get(s : GraphsearchbdsModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_search_bds_model_set(s : GraphsearchbdsModel, i : Int, v : Double) -> GraphsearchbdsModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_search_bds_model_sum(s : GraphsearchbdsModel) -> Double { @_common.sum(s.data) }

pub fn graph_search_bds_model_mean(s : GraphsearchbdsModel) -> Double { @_common.mean(s.data) }

pub fn graph_search_bds_model_scale(s : GraphsearchbdsModel, f : Double) -> GraphsearchbdsModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_search_bds_model_add(a : GraphsearchbdsModel, b : GraphsearchbdsModel) -> GraphsearchbdsModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_search_bds_model_copy(s : GraphsearchbdsModel) -> GraphsearchbdsModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_search_bds_model_fill(s : GraphsearchbdsModel, v : Double) -> GraphsearchbdsModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_search_bds_model_min(s : GraphsearchbdsModel) -> Double { @_common.min(s.data) }

pub fn graph_search_bds_model_max(s : GraphsearchbdsModel) -> Double { @_common.max(s.data) }

pub fn graph_search_bds_model_to_string(s : GraphsearchbdsModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphsearchbdsLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_search_bds_layer_make(size : Int) -> GraphsearchbdsLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_search_bds_layer_len(s : GraphsearchbdsLayer) -> Int { s.size }

pub fn graph_search_bds_layer_get(s : GraphsearchbdsLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_search_bds_layer_set(s : GraphsearchbdsLayer, i : Int, v : Double) -> GraphsearchbdsLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_search_bds_layer_sum(s : GraphsearchbdsLayer) -> Double { @_common.sum(s.data) }

pub fn graph_search_bds_layer_mean(s : GraphsearchbdsLayer) -> Double { @_common.mean(s.data) }

pub fn graph_search_bds_layer_scale(s : GraphsearchbdsLayer, f : Double) -> GraphsearchbdsLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_search_bds_layer_add(a : GraphsearchbdsLayer, b : GraphsearchbdsLayer) -> GraphsearchbdsLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_search_bds_layer_copy(s : GraphsearchbdsLayer) -> GraphsearchbdsLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_search_bds_layer_fill(s : GraphsearchbdsLayer, v : Double) -> GraphsearchbdsLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_search_bds_layer_min(s : GraphsearchbdsLayer) -> Double { @_common.min(s.data) }

pub fn graph_search_bds_layer_max(s : GraphsearchbdsLayer) -> Double { @_common.max(s.data) }

pub fn graph_search_bds_layer_to_string(s : GraphsearchbdsLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphsearchbdsBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_search_bds_buffer_make(size : Int) -> GraphsearchbdsBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_search_bds_buffer_len(s : GraphsearchbdsBuffer) -> Int { s.size }

pub fn graph_search_bds_buffer_get(s : GraphsearchbdsBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_search_bds_buffer_set(s : GraphsearchbdsBuffer, i : Int, v : Double) -> GraphsearchbdsBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_search_bds_buffer_sum(s : GraphsearchbdsBuffer) -> Double { @_common.sum(s.data) }

pub fn graph_search_bds_buffer_mean(s : GraphsearchbdsBuffer) -> Double { @_common.mean(s.data) }

pub fn graph_search_bds_buffer_scale(s : GraphsearchbdsBuffer, f : Double) -> GraphsearchbdsBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_search_bds_buffer_add(a : GraphsearchbdsBuffer, b : GraphsearchbdsBuffer) -> GraphsearchbdsBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_search_bds_buffer_copy(s : GraphsearchbdsBuffer) -> GraphsearchbdsBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_search_bds_buffer_fill(s : GraphsearchbdsBuffer, v : Double) -> GraphsearchbdsBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_search_bds_buffer_min(s : GraphsearchbdsBuffer) -> Double { @_common.min(s.data) }

pub fn graph_search_bds_buffer_max(s : GraphsearchbdsBuffer) -> Double { @_common.max(s.data) }

pub fn graph_search_bds_buffer_to_string(s : GraphsearchbdsBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphsearchbdsCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_search_bds_cursor_make(size : Int) -> GraphsearchbdsCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_search_bds_cursor_len(s : GraphsearchbdsCursor) -> Int { s.size }

pub fn graph_search_bds_cursor_get(s : GraphsearchbdsCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_search_bds_cursor_set(s : GraphsearchbdsCursor, i : Int, v : Double) -> GraphsearchbdsCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_search_bds_cursor_sum(s : GraphsearchbdsCursor) -> Double { @_common.sum(s.data) }

pub fn graph_search_bds_cursor_mean(s : GraphsearchbdsCursor) -> Double { @_common.mean(s.data) }

pub fn graph_search_bds_cursor_scale(s : GraphsearchbdsCursor, f : Double) -> GraphsearchbdsCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_search_bds_cursor_add(a : GraphsearchbdsCursor, b : GraphsearchbdsCursor) -> GraphsearchbdsCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_search_bds_cursor_copy(s : GraphsearchbdsCursor) -> GraphsearchbdsCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_search_bds_cursor_fill(s : GraphsearchbdsCursor, v : Double) -> GraphsearchbdsCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_search_bds_cursor_min(s : GraphsearchbdsCursor) -> Double { @_common.min(s.data) }

pub fn graph_search_bds_cursor_max(s : GraphsearchbdsCursor) -> Double { @_common.max(s.data) }

pub fn graph_search_bds_cursor_to_string(s : GraphsearchbdsCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphsearchbdsView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_search_bds_view_make(size : Int) -> GraphsearchbdsView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_search_bds_view_len(s : GraphsearchbdsView) -> Int { s.size }

pub fn graph_search_bds_view_get(s : GraphsearchbdsView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_search_bds_view_set(s : GraphsearchbdsView, i : Int, v : Double) -> GraphsearchbdsView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_search_bds_view_sum(s : GraphsearchbdsView) -> Double { @_common.sum(s.data) }

pub fn graph_search_bds_view_mean(s : GraphsearchbdsView) -> Double { @_common.mean(s.data) }

pub fn graph_search_bds_view_scale(s : GraphsearchbdsView, f : Double) -> GraphsearchbdsView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_search_bds_view_add(a : GraphsearchbdsView, b : GraphsearchbdsView) -> GraphsearchbdsView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_search_bds_view_copy(s : GraphsearchbdsView) -> GraphsearchbdsView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_search_bds_view_fill(s : GraphsearchbdsView, v : Double) -> GraphsearchbdsView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_search_bds_view_min(s : GraphsearchbdsView) -> Double { @_common.min(s.data) }

pub fn graph_search_bds_view_max(s : GraphsearchbdsView) -> Double { @_common.max(s.data) }

pub fn graph_search_bds_view_to_string(s : GraphsearchbdsView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphsearchbdsRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_search_bds_range_make(size : Int) -> GraphsearchbdsRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_search_bds_range_len(s : GraphsearchbdsRange) -> Int { s.size }

pub fn graph_search_bds_range_get(s : GraphsearchbdsRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_search_bds_range_set(s : GraphsearchbdsRange, i : Int, v : Double) -> GraphsearchbdsRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_search_bds_range_sum(s : GraphsearchbdsRange) -> Double { @_common.sum(s.data) }

pub fn graph_search_bds_range_mean(s : GraphsearchbdsRange) -> Double { @_common.mean(s.data) }

pub fn graph_search_bds_range_scale(s : GraphsearchbdsRange, f : Double) -> GraphsearchbdsRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_search_bds_range_add(a : GraphsearchbdsRange, b : GraphsearchbdsRange) -> GraphsearchbdsRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_search_bds_range_copy(s : GraphsearchbdsRange) -> GraphsearchbdsRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_search_bds_range_fill(s : GraphsearchbdsRange, v : Double) -> GraphsearchbdsRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_search_bds_range_min(s : GraphsearchbdsRange) -> Double { @_common.min(s.data) }

pub fn graph_search_bds_range_max(s : GraphsearchbdsRange) -> Double { @_common.max(s.data) }

pub fn graph_search_bds_range_to_string(s : GraphsearchbdsRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphsearchbdsSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_search_bds_slice_make(size : Int) -> GraphsearchbdsSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_search_bds_slice_len(s : GraphsearchbdsSlice) -> Int { s.size }

pub fn graph_search_bds_slice_get(s : GraphsearchbdsSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_search_bds_slice_set(s : GraphsearchbdsSlice, i : Int, v : Double) -> GraphsearchbdsSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_search_bds_slice_sum(s : GraphsearchbdsSlice) -> Double { @_common.sum(s.data) }

pub fn graph_search_bds_slice_mean(s : GraphsearchbdsSlice) -> Double { @_common.mean(s.data) }

pub fn graph_search_bds_slice_scale(s : GraphsearchbdsSlice, f : Double) -> GraphsearchbdsSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_search_bds_slice_add(a : GraphsearchbdsSlice, b : GraphsearchbdsSlice) -> GraphsearchbdsSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_search_bds_slice_copy(s : GraphsearchbdsSlice) -> GraphsearchbdsSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_search_bds_slice_fill(s : GraphsearchbdsSlice, v : Double) -> GraphsearchbdsSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_search_bds_slice_min(s : GraphsearchbdsSlice) -> Double { @_common.min(s.data) }

pub fn graph_search_bds_slice_max(s : GraphsearchbdsSlice) -> Double { @_common.max(s.data) }

pub fn graph_search_bds_slice_to_string(s : GraphsearchbdsSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

