///===
/// extcore/ds_tree_trie

pub(all) struct DstreetriePoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn ds_tree_trie_make_point(x : Double, y : Double) -> DstreetriePoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn ds_tree_trie_make_point3(x : Double, y : Double, z : Double) -> DstreetriePoint {
  { x, y, z, label: 0 }
}

pub fn DstreetriePoint::x(self : DstreetriePoint) -> Double { self.x }

pub fn DstreetriePoint::y(self : DstreetriePoint) -> Double { self.y }

pub fn DstreetriePoint::z(self : DstreetriePoint) -> Double { self.z }

pub fn DstreetriePoint::label(self : DstreetriePoint) -> Int { self.label }

pub fn DstreetriePoint::dist(self : DstreetriePoint, other : DstreetriePoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn DstreetriePoint::add(self : DstreetriePoint, other : DstreetriePoint) -> DstreetriePoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn DstreetriePoint::sub(self : DstreetriePoint, other : DstreetriePoint) -> DstreetriePoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn DstreetriePoint::scale(self : DstreetriePoint, s : Double) -> DstreetriePoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn DstreetriePoint::dot(self : DstreetriePoint, other : DstreetriePoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn DstreetriePoint::cross(self : DstreetriePoint, other : DstreetriePoint) -> DstreetriePoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn DstreetriePoint::norm(self : DstreetriePoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn DstreetriePoint::normalize(self : DstreetriePoint) -> DstreetriePoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn DstreetriePoint::negate(self : DstreetriePoint) -> DstreetriePoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn DstreetriePoint::mid(self : DstreetriePoint, other : DstreetriePoint) -> DstreetriePoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn DstreetriePoint::lerp(self : DstreetriePoint, other : DstreetriePoint, t : Double) -> DstreetriePoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn DstreetriePoint::to_string(self : DstreetriePoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct DstreetrieSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn ds_tree_trie_make_series(vals : Array[Double], name : String) -> DstreetrieSeries {
  { vals, name, meta: 0 }
}

pub fn DstreetrieSeries::len(self : DstreetrieSeries) -> Int { self.vals.length() }

pub fn DstreetrieSeries::sum(self : DstreetrieSeries) -> Double { @_common.sum(self.vals) }

pub fn DstreetrieSeries::mean(self : DstreetrieSeries) -> Double { @_common.mean(self.vals) }

pub fn DstreetrieSeries::min(self : DstreetrieSeries) -> Double { @_common.min(self.vals) }

pub fn DstreetrieSeries::max(self : DstreetrieSeries) -> Double { @_common.max(self.vals) }

pub fn DstreetrieSeries::range(self : DstreetrieSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn DstreetrieSeries::variance(self : DstreetrieSeries) -> Double { @_common.variance(self.vals) }

pub fn DstreetrieSeries::std(self : DstreetrieSeries) -> Double { @_common.std(self.vals) }

pub fn DstreetrieSeries::median(self : DstreetrieSeries) -> Double { @_common.median(self.vals) }

pub fn DstreetrieSeries::scale(self : DstreetrieSeries, f : Double) -> DstreetrieSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn DstreetrieSeries::add(self : DstreetrieSeries, other : DstreetrieSeries) -> DstreetrieSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn DstreetrieSeries::sub(self : DstreetrieSeries, other : DstreetrieSeries) -> DstreetrieSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn DstreetrieSeries::normalize(self : DstreetrieSeries) -> DstreetrieSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn DstreetrieSeries::cumsum(self : DstreetrieSeries) -> DstreetrieSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn DstreetrieSeries::to_string(self : DstreetrieSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct DstreetrieMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn ds_tree_trie_make_matrix(rows : Int, cols : Int, val : Double) -> DstreetrieMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn ds_tree_trie_matrix_identity(n : Int) -> DstreetrieMatrix {
  let m = ds_tree_trie_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn DstreetrieMatrix::get(self : DstreetrieMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn DstreetrieMatrix::transpose(self : DstreetrieMatrix) -> DstreetrieMatrix {
  let result = ds_tree_trie_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn DstreetrieMatrix::add(self : DstreetrieMatrix, other : DstreetrieMatrix) -> DstreetrieMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = ds_tree_trie_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn DstreetrieMatrix::scale(self : DstreetrieMatrix, s : Double) -> DstreetrieMatrix {
  let result = ds_tree_trie_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn DstreetrieMatrix::multiply(self : DstreetrieMatrix, other : DstreetrieMatrix) -> DstreetrieMatrix {
  if self.cols != other.rows { return ds_tree_trie_make_matrix(self.rows, other.cols, 0.0) }
  let result = ds_tree_trie_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn DstreetrieMatrix::trace(self : DstreetrieMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn DstreetrieMatrix::det(self : DstreetrieMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn DstreetrieMatrix::norm(self : DstreetrieMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn DstreetrieMatrix::to_string(self : DstreetrieMatrix) -> String {
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

pub(all) struct DstreetrieVector {
  comps : Array[Double]
  dim : Int
}

pub fn ds_tree_trie_make_vector(comps : Array[Double]) -> DstreetrieVector {
  { comps, dim: comps.length() }
}

pub fn ds_tree_trie_vector_zero(dim : Int) -> DstreetrieVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn DstreetrieVector::add(self : DstreetrieVector, other : DstreetrieVector) -> DstreetrieVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn DstreetrieVector::sub(self : DstreetrieVector, other : DstreetrieVector) -> DstreetrieVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn DstreetrieVector::scale(self : DstreetrieVector, s : Double) -> DstreetrieVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn DstreetrieVector::dot(self : DstreetrieVector, other : DstreetrieVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn DstreetrieVector::norm(self : DstreetrieVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn DstreetrieVector::normalize(self : DstreetrieVector) -> DstreetrieVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn DstreetrieVector::dist(self : DstreetrieVector, other : DstreetrieVector) -> Double {
  self.sub(other).norm()
}

pub fn DstreetrieVector::to_string(self : DstreetrieVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn ds_tree_trie_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn ds_tree_trie_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn ds_tree_trie_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn ds_tree_trie_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn ds_tree_trie_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn ds_tree_trie_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn ds_tree_trie_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn ds_tree_trie_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn ds_tree_trie_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn ds_tree_trie_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn ds_tree_trie_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn ds_tree_trie_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn ds_tree_trie_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn ds_tree_trie_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn ds_tree_trie_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn ds_tree_trie_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn ds_tree_trie_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn ds_tree_trie_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn ds_tree_trie_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn ds_tree_trie_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn ds_tree_trie_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn ds_tree_trie_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn ds_tree_trie_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn ds_tree_trie_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn ds_tree_trie_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn ds_tree_trie_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn ds_tree_trie_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn ds_tree_trie_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn ds_tree_trie_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct DstreetrieFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_tree_trie_frame_make(size : Int) -> DstreetrieFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_tree_trie_frame_len(s : DstreetrieFrame) -> Int { s.size }

pub fn ds_tree_trie_frame_get(s : DstreetrieFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_tree_trie_frame_set(s : DstreetrieFrame, i : Int, v : Double) -> DstreetrieFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_tree_trie_frame_sum(s : DstreetrieFrame) -> Double { @_common.sum(s.data) }

pub fn ds_tree_trie_frame_mean(s : DstreetrieFrame) -> Double { @_common.mean(s.data) }

pub fn ds_tree_trie_frame_scale(s : DstreetrieFrame, f : Double) -> DstreetrieFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_tree_trie_frame_add(a : DstreetrieFrame, b : DstreetrieFrame) -> DstreetrieFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_tree_trie_frame_copy(s : DstreetrieFrame) -> DstreetrieFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_tree_trie_frame_fill(s : DstreetrieFrame, v : Double) -> DstreetrieFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_tree_trie_frame_min(s : DstreetrieFrame) -> Double { @_common.min(s.data) }

pub fn ds_tree_trie_frame_max(s : DstreetrieFrame) -> Double { @_common.max(s.data) }

pub fn ds_tree_trie_frame_to_string(s : DstreetrieFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DstreetrieTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_tree_trie_table_make(size : Int) -> DstreetrieTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_tree_trie_table_len(s : DstreetrieTable) -> Int { s.size }

pub fn ds_tree_trie_table_get(s : DstreetrieTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_tree_trie_table_set(s : DstreetrieTable, i : Int, v : Double) -> DstreetrieTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_tree_trie_table_sum(s : DstreetrieTable) -> Double { @_common.sum(s.data) }

pub fn ds_tree_trie_table_mean(s : DstreetrieTable) -> Double { @_common.mean(s.data) }

pub fn ds_tree_trie_table_scale(s : DstreetrieTable, f : Double) -> DstreetrieTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_tree_trie_table_add(a : DstreetrieTable, b : DstreetrieTable) -> DstreetrieTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_tree_trie_table_copy(s : DstreetrieTable) -> DstreetrieTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_tree_trie_table_fill(s : DstreetrieTable, v : Double) -> DstreetrieTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_tree_trie_table_min(s : DstreetrieTable) -> Double { @_common.min(s.data) }

pub fn ds_tree_trie_table_max(s : DstreetrieTable) -> Double { @_common.max(s.data) }

pub fn ds_tree_trie_table_to_string(s : DstreetrieTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DstreetrieGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_tree_trie_graphn_make(size : Int) -> DstreetrieGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_tree_trie_graphn_len(s : DstreetrieGraphN) -> Int { s.size }

pub fn ds_tree_trie_graphn_get(s : DstreetrieGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_tree_trie_graphn_set(s : DstreetrieGraphN, i : Int, v : Double) -> DstreetrieGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_tree_trie_graphn_sum(s : DstreetrieGraphN) -> Double { @_common.sum(s.data) }

pub fn ds_tree_trie_graphn_mean(s : DstreetrieGraphN) -> Double { @_common.mean(s.data) }

pub fn ds_tree_trie_graphn_scale(s : DstreetrieGraphN, f : Double) -> DstreetrieGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_tree_trie_graphn_add(a : DstreetrieGraphN, b : DstreetrieGraphN) -> DstreetrieGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_tree_trie_graphn_copy(s : DstreetrieGraphN) -> DstreetrieGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_tree_trie_graphn_fill(s : DstreetrieGraphN, v : Double) -> DstreetrieGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_tree_trie_graphn_min(s : DstreetrieGraphN) -> Double { @_common.min(s.data) }

pub fn ds_tree_trie_graphn_max(s : DstreetrieGraphN) -> Double { @_common.max(s.data) }

pub fn ds_tree_trie_graphn_to_string(s : DstreetrieGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DstreetrieNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_tree_trie_node_make(size : Int) -> DstreetrieNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_tree_trie_node_len(s : DstreetrieNode) -> Int { s.size }

pub fn ds_tree_trie_node_get(s : DstreetrieNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_tree_trie_node_set(s : DstreetrieNode, i : Int, v : Double) -> DstreetrieNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_tree_trie_node_sum(s : DstreetrieNode) -> Double { @_common.sum(s.data) }

pub fn ds_tree_trie_node_mean(s : DstreetrieNode) -> Double { @_common.mean(s.data) }

pub fn ds_tree_trie_node_scale(s : DstreetrieNode, f : Double) -> DstreetrieNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_tree_trie_node_add(a : DstreetrieNode, b : DstreetrieNode) -> DstreetrieNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_tree_trie_node_copy(s : DstreetrieNode) -> DstreetrieNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_tree_trie_node_fill(s : DstreetrieNode, v : Double) -> DstreetrieNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_tree_trie_node_min(s : DstreetrieNode) -> Double { @_common.min(s.data) }

pub fn ds_tree_trie_node_max(s : DstreetrieNode) -> Double { @_common.max(s.data) }

pub fn ds_tree_trie_node_to_string(s : DstreetrieNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DstreetrieEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_tree_trie_edge_make(size : Int) -> DstreetrieEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_tree_trie_edge_len(s : DstreetrieEdge) -> Int { s.size }

pub fn ds_tree_trie_edge_get(s : DstreetrieEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_tree_trie_edge_set(s : DstreetrieEdge, i : Int, v : Double) -> DstreetrieEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_tree_trie_edge_sum(s : DstreetrieEdge) -> Double { @_common.sum(s.data) }

pub fn ds_tree_trie_edge_mean(s : DstreetrieEdge) -> Double { @_common.mean(s.data) }

pub fn ds_tree_trie_edge_scale(s : DstreetrieEdge, f : Double) -> DstreetrieEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_tree_trie_edge_add(a : DstreetrieEdge, b : DstreetrieEdge) -> DstreetrieEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_tree_trie_edge_copy(s : DstreetrieEdge) -> DstreetrieEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_tree_trie_edge_fill(s : DstreetrieEdge, v : Double) -> DstreetrieEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_tree_trie_edge_min(s : DstreetrieEdge) -> Double { @_common.min(s.data) }

pub fn ds_tree_trie_edge_max(s : DstreetrieEdge) -> Double { @_common.max(s.data) }

pub fn ds_tree_trie_edge_to_string(s : DstreetrieEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DstreetriePath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_tree_trie_path_make(size : Int) -> DstreetriePath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_tree_trie_path_len(s : DstreetriePath) -> Int { s.size }

pub fn ds_tree_trie_path_get(s : DstreetriePath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_tree_trie_path_set(s : DstreetriePath, i : Int, v : Double) -> DstreetriePath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_tree_trie_path_sum(s : DstreetriePath) -> Double { @_common.sum(s.data) }

pub fn ds_tree_trie_path_mean(s : DstreetriePath) -> Double { @_common.mean(s.data) }

pub fn ds_tree_trie_path_scale(s : DstreetriePath, f : Double) -> DstreetriePath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_tree_trie_path_add(a : DstreetriePath, b : DstreetriePath) -> DstreetriePath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_tree_trie_path_copy(s : DstreetriePath) -> DstreetriePath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_tree_trie_path_fill(s : DstreetriePath, v : Double) -> DstreetriePath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_tree_trie_path_min(s : DstreetriePath) -> Double { @_common.min(s.data) }

pub fn ds_tree_trie_path_max(s : DstreetriePath) -> Double { @_common.max(s.data) }

pub fn ds_tree_trie_path_to_string(s : DstreetriePath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DstreetrieCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_tree_trie_cluster_make(size : Int) -> DstreetrieCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_tree_trie_cluster_len(s : DstreetrieCluster) -> Int { s.size }

pub fn ds_tree_trie_cluster_get(s : DstreetrieCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_tree_trie_cluster_set(s : DstreetrieCluster, i : Int, v : Double) -> DstreetrieCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_tree_trie_cluster_sum(s : DstreetrieCluster) -> Double { @_common.sum(s.data) }

pub fn ds_tree_trie_cluster_mean(s : DstreetrieCluster) -> Double { @_common.mean(s.data) }

pub fn ds_tree_trie_cluster_scale(s : DstreetrieCluster, f : Double) -> DstreetrieCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_tree_trie_cluster_add(a : DstreetrieCluster, b : DstreetrieCluster) -> DstreetrieCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_tree_trie_cluster_copy(s : DstreetrieCluster) -> DstreetrieCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_tree_trie_cluster_fill(s : DstreetrieCluster, v : Double) -> DstreetrieCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_tree_trie_cluster_min(s : DstreetrieCluster) -> Double { @_common.min(s.data) }

pub fn ds_tree_trie_cluster_max(s : DstreetrieCluster) -> Double { @_common.max(s.data) }

pub fn ds_tree_trie_cluster_to_string(s : DstreetrieCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DstreetrieModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_tree_trie_model_make(size : Int) -> DstreetrieModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_tree_trie_model_len(s : DstreetrieModel) -> Int { s.size }

pub fn ds_tree_trie_model_get(s : DstreetrieModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_tree_trie_model_set(s : DstreetrieModel, i : Int, v : Double) -> DstreetrieModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_tree_trie_model_sum(s : DstreetrieModel) -> Double { @_common.sum(s.data) }

pub fn ds_tree_trie_model_mean(s : DstreetrieModel) -> Double { @_common.mean(s.data) }

pub fn ds_tree_trie_model_scale(s : DstreetrieModel, f : Double) -> DstreetrieModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_tree_trie_model_add(a : DstreetrieModel, b : DstreetrieModel) -> DstreetrieModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_tree_trie_model_copy(s : DstreetrieModel) -> DstreetrieModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_tree_trie_model_fill(s : DstreetrieModel, v : Double) -> DstreetrieModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_tree_trie_model_min(s : DstreetrieModel) -> Double { @_common.min(s.data) }

pub fn ds_tree_trie_model_max(s : DstreetrieModel) -> Double { @_common.max(s.data) }

pub fn ds_tree_trie_model_to_string(s : DstreetrieModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DstreetrieLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_tree_trie_layer_make(size : Int) -> DstreetrieLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_tree_trie_layer_len(s : DstreetrieLayer) -> Int { s.size }

pub fn ds_tree_trie_layer_get(s : DstreetrieLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_tree_trie_layer_set(s : DstreetrieLayer, i : Int, v : Double) -> DstreetrieLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_tree_trie_layer_sum(s : DstreetrieLayer) -> Double { @_common.sum(s.data) }

pub fn ds_tree_trie_layer_mean(s : DstreetrieLayer) -> Double { @_common.mean(s.data) }

pub fn ds_tree_trie_layer_scale(s : DstreetrieLayer, f : Double) -> DstreetrieLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_tree_trie_layer_add(a : DstreetrieLayer, b : DstreetrieLayer) -> DstreetrieLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_tree_trie_layer_copy(s : DstreetrieLayer) -> DstreetrieLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_tree_trie_layer_fill(s : DstreetrieLayer, v : Double) -> DstreetrieLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_tree_trie_layer_min(s : DstreetrieLayer) -> Double { @_common.min(s.data) }

pub fn ds_tree_trie_layer_max(s : DstreetrieLayer) -> Double { @_common.max(s.data) }

pub fn ds_tree_trie_layer_to_string(s : DstreetrieLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DstreetrieBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_tree_trie_buffer_make(size : Int) -> DstreetrieBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_tree_trie_buffer_len(s : DstreetrieBuffer) -> Int { s.size }

pub fn ds_tree_trie_buffer_get(s : DstreetrieBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_tree_trie_buffer_set(s : DstreetrieBuffer, i : Int, v : Double) -> DstreetrieBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_tree_trie_buffer_sum(s : DstreetrieBuffer) -> Double { @_common.sum(s.data) }

pub fn ds_tree_trie_buffer_mean(s : DstreetrieBuffer) -> Double { @_common.mean(s.data) }

pub fn ds_tree_trie_buffer_scale(s : DstreetrieBuffer, f : Double) -> DstreetrieBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_tree_trie_buffer_add(a : DstreetrieBuffer, b : DstreetrieBuffer) -> DstreetrieBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_tree_trie_buffer_copy(s : DstreetrieBuffer) -> DstreetrieBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_tree_trie_buffer_fill(s : DstreetrieBuffer, v : Double) -> DstreetrieBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_tree_trie_buffer_min(s : DstreetrieBuffer) -> Double { @_common.min(s.data) }

pub fn ds_tree_trie_buffer_max(s : DstreetrieBuffer) -> Double { @_common.max(s.data) }

pub fn ds_tree_trie_buffer_to_string(s : DstreetrieBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DstreetrieCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_tree_trie_cursor_make(size : Int) -> DstreetrieCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_tree_trie_cursor_len(s : DstreetrieCursor) -> Int { s.size }

pub fn ds_tree_trie_cursor_get(s : DstreetrieCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_tree_trie_cursor_set(s : DstreetrieCursor, i : Int, v : Double) -> DstreetrieCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_tree_trie_cursor_sum(s : DstreetrieCursor) -> Double { @_common.sum(s.data) }

pub fn ds_tree_trie_cursor_mean(s : DstreetrieCursor) -> Double { @_common.mean(s.data) }

pub fn ds_tree_trie_cursor_scale(s : DstreetrieCursor, f : Double) -> DstreetrieCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_tree_trie_cursor_add(a : DstreetrieCursor, b : DstreetrieCursor) -> DstreetrieCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_tree_trie_cursor_copy(s : DstreetrieCursor) -> DstreetrieCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_tree_trie_cursor_fill(s : DstreetrieCursor, v : Double) -> DstreetrieCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_tree_trie_cursor_min(s : DstreetrieCursor) -> Double { @_common.min(s.data) }

pub fn ds_tree_trie_cursor_max(s : DstreetrieCursor) -> Double { @_common.max(s.data) }

pub fn ds_tree_trie_cursor_to_string(s : DstreetrieCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DstreetrieView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_tree_trie_view_make(size : Int) -> DstreetrieView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_tree_trie_view_len(s : DstreetrieView) -> Int { s.size }

pub fn ds_tree_trie_view_get(s : DstreetrieView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_tree_trie_view_set(s : DstreetrieView, i : Int, v : Double) -> DstreetrieView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_tree_trie_view_sum(s : DstreetrieView) -> Double { @_common.sum(s.data) }

pub fn ds_tree_trie_view_mean(s : DstreetrieView) -> Double { @_common.mean(s.data) }

pub fn ds_tree_trie_view_scale(s : DstreetrieView, f : Double) -> DstreetrieView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_tree_trie_view_add(a : DstreetrieView, b : DstreetrieView) -> DstreetrieView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_tree_trie_view_copy(s : DstreetrieView) -> DstreetrieView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_tree_trie_view_fill(s : DstreetrieView, v : Double) -> DstreetrieView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_tree_trie_view_min(s : DstreetrieView) -> Double { @_common.min(s.data) }

pub fn ds_tree_trie_view_max(s : DstreetrieView) -> Double { @_common.max(s.data) }

pub fn ds_tree_trie_view_to_string(s : DstreetrieView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DstreetrieRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_tree_trie_range_make(size : Int) -> DstreetrieRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_tree_trie_range_len(s : DstreetrieRange) -> Int { s.size }

pub fn ds_tree_trie_range_get(s : DstreetrieRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_tree_trie_range_set(s : DstreetrieRange, i : Int, v : Double) -> DstreetrieRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_tree_trie_range_sum(s : DstreetrieRange) -> Double { @_common.sum(s.data) }

pub fn ds_tree_trie_range_mean(s : DstreetrieRange) -> Double { @_common.mean(s.data) }

pub fn ds_tree_trie_range_scale(s : DstreetrieRange, f : Double) -> DstreetrieRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_tree_trie_range_add(a : DstreetrieRange, b : DstreetrieRange) -> DstreetrieRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_tree_trie_range_copy(s : DstreetrieRange) -> DstreetrieRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_tree_trie_range_fill(s : DstreetrieRange, v : Double) -> DstreetrieRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_tree_trie_range_min(s : DstreetrieRange) -> Double { @_common.min(s.data) }

pub fn ds_tree_trie_range_max(s : DstreetrieRange) -> Double { @_common.max(s.data) }

pub fn ds_tree_trie_range_to_string(s : DstreetrieRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DstreetrieSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_tree_trie_slice_make(size : Int) -> DstreetrieSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_tree_trie_slice_len(s : DstreetrieSlice) -> Int { s.size }

pub fn ds_tree_trie_slice_get(s : DstreetrieSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_tree_trie_slice_set(s : DstreetrieSlice, i : Int, v : Double) -> DstreetrieSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_tree_trie_slice_sum(s : DstreetrieSlice) -> Double { @_common.sum(s.data) }

pub fn ds_tree_trie_slice_mean(s : DstreetrieSlice) -> Double { @_common.mean(s.data) }

pub fn ds_tree_trie_slice_scale(s : DstreetrieSlice, f : Double) -> DstreetrieSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_tree_trie_slice_add(a : DstreetrieSlice, b : DstreetrieSlice) -> DstreetrieSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_tree_trie_slice_copy(s : DstreetrieSlice) -> DstreetrieSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_tree_trie_slice_fill(s : DstreetrieSlice, v : Double) -> DstreetrieSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_tree_trie_slice_min(s : DstreetrieSlice) -> Double { @_common.min(s.data) }

pub fn ds_tree_trie_slice_max(s : DstreetrieSlice) -> Double { @_common.max(s.data) }

pub fn ds_tree_trie_slice_to_string(s : DstreetrieSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

