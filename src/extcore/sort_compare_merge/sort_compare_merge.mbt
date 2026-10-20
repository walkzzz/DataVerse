///===
/// extcore/sort_compare_merge

pub(all) struct SortcomparemergePoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn sort_compare_merge_make_point(x : Double, y : Double) -> SortcomparemergePoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn sort_compare_merge_make_point3(x : Double, y : Double, z : Double) -> SortcomparemergePoint {
  { x, y, z, label: 0 }
}

pub fn SortcomparemergePoint::x(self : SortcomparemergePoint) -> Double { self.x }

pub fn SortcomparemergePoint::y(self : SortcomparemergePoint) -> Double { self.y }

pub fn SortcomparemergePoint::z(self : SortcomparemergePoint) -> Double { self.z }

pub fn SortcomparemergePoint::label(self : SortcomparemergePoint) -> Int { self.label }

pub fn SortcomparemergePoint::dist(self : SortcomparemergePoint, other : SortcomparemergePoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn SortcomparemergePoint::add(self : SortcomparemergePoint, other : SortcomparemergePoint) -> SortcomparemergePoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn SortcomparemergePoint::sub(self : SortcomparemergePoint, other : SortcomparemergePoint) -> SortcomparemergePoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn SortcomparemergePoint::scale(self : SortcomparemergePoint, s : Double) -> SortcomparemergePoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn SortcomparemergePoint::dot(self : SortcomparemergePoint, other : SortcomparemergePoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn SortcomparemergePoint::cross(self : SortcomparemergePoint, other : SortcomparemergePoint) -> SortcomparemergePoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn SortcomparemergePoint::norm(self : SortcomparemergePoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn SortcomparemergePoint::normalize(self : SortcomparemergePoint) -> SortcomparemergePoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn SortcomparemergePoint::negate(self : SortcomparemergePoint) -> SortcomparemergePoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn SortcomparemergePoint::mid(self : SortcomparemergePoint, other : SortcomparemergePoint) -> SortcomparemergePoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn SortcomparemergePoint::lerp(self : SortcomparemergePoint, other : SortcomparemergePoint, t : Double) -> SortcomparemergePoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn SortcomparemergePoint::to_string(self : SortcomparemergePoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct SortcomparemergeSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn sort_compare_merge_make_series(vals : Array[Double], name : String) -> SortcomparemergeSeries {
  { vals, name, meta: 0 }
}

pub fn SortcomparemergeSeries::len(self : SortcomparemergeSeries) -> Int { self.vals.length() }

pub fn SortcomparemergeSeries::sum(self : SortcomparemergeSeries) -> Double { @_common.sum(self.vals) }

pub fn SortcomparemergeSeries::mean(self : SortcomparemergeSeries) -> Double { @_common.mean(self.vals) }

pub fn SortcomparemergeSeries::min(self : SortcomparemergeSeries) -> Double { @_common.min(self.vals) }

pub fn SortcomparemergeSeries::max(self : SortcomparemergeSeries) -> Double { @_common.max(self.vals) }

pub fn SortcomparemergeSeries::range(self : SortcomparemergeSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn SortcomparemergeSeries::variance(self : SortcomparemergeSeries) -> Double { @_common.variance(self.vals) }

pub fn SortcomparemergeSeries::std(self : SortcomparemergeSeries) -> Double { @_common.std(self.vals) }

pub fn SortcomparemergeSeries::median(self : SortcomparemergeSeries) -> Double { @_common.median(self.vals) }

pub fn SortcomparemergeSeries::scale(self : SortcomparemergeSeries, f : Double) -> SortcomparemergeSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn SortcomparemergeSeries::add(self : SortcomparemergeSeries, other : SortcomparemergeSeries) -> SortcomparemergeSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn SortcomparemergeSeries::sub(self : SortcomparemergeSeries, other : SortcomparemergeSeries) -> SortcomparemergeSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn SortcomparemergeSeries::normalize(self : SortcomparemergeSeries) -> SortcomparemergeSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn SortcomparemergeSeries::cumsum(self : SortcomparemergeSeries) -> SortcomparemergeSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn SortcomparemergeSeries::to_string(self : SortcomparemergeSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct SortcomparemergeMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn sort_compare_merge_make_matrix(rows : Int, cols : Int, val : Double) -> SortcomparemergeMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn sort_compare_merge_matrix_identity(n : Int) -> SortcomparemergeMatrix {
  let m = sort_compare_merge_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn SortcomparemergeMatrix::get(self : SortcomparemergeMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn SortcomparemergeMatrix::transpose(self : SortcomparemergeMatrix) -> SortcomparemergeMatrix {
  let result = sort_compare_merge_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn SortcomparemergeMatrix::add(self : SortcomparemergeMatrix, other : SortcomparemergeMatrix) -> SortcomparemergeMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = sort_compare_merge_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn SortcomparemergeMatrix::scale(self : SortcomparemergeMatrix, s : Double) -> SortcomparemergeMatrix {
  let result = sort_compare_merge_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn SortcomparemergeMatrix::multiply(self : SortcomparemergeMatrix, other : SortcomparemergeMatrix) -> SortcomparemergeMatrix {
  if self.cols != other.rows { return sort_compare_merge_make_matrix(self.rows, other.cols, 0.0) }
  let result = sort_compare_merge_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn SortcomparemergeMatrix::trace(self : SortcomparemergeMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn SortcomparemergeMatrix::det(self : SortcomparemergeMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn SortcomparemergeMatrix::norm(self : SortcomparemergeMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn SortcomparemergeMatrix::to_string(self : SortcomparemergeMatrix) -> String {
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

pub(all) struct SortcomparemergeVector {
  comps : Array[Double]
  dim : Int
}

pub fn sort_compare_merge_make_vector(comps : Array[Double]) -> SortcomparemergeVector {
  { comps, dim: comps.length() }
}

pub fn sort_compare_merge_vector_zero(dim : Int) -> SortcomparemergeVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn SortcomparemergeVector::add(self : SortcomparemergeVector, other : SortcomparemergeVector) -> SortcomparemergeVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn SortcomparemergeVector::sub(self : SortcomparemergeVector, other : SortcomparemergeVector) -> SortcomparemergeVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn SortcomparemergeVector::scale(self : SortcomparemergeVector, s : Double) -> SortcomparemergeVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn SortcomparemergeVector::dot(self : SortcomparemergeVector, other : SortcomparemergeVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn SortcomparemergeVector::norm(self : SortcomparemergeVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn SortcomparemergeVector::normalize(self : SortcomparemergeVector) -> SortcomparemergeVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn SortcomparemergeVector::dist(self : SortcomparemergeVector, other : SortcomparemergeVector) -> Double {
  self.sub(other).norm()
}

pub fn SortcomparemergeVector::to_string(self : SortcomparemergeVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn sort_compare_merge_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn sort_compare_merge_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn sort_compare_merge_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn sort_compare_merge_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn sort_compare_merge_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn sort_compare_merge_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn sort_compare_merge_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn sort_compare_merge_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn sort_compare_merge_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn sort_compare_merge_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn sort_compare_merge_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn sort_compare_merge_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn sort_compare_merge_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn sort_compare_merge_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn sort_compare_merge_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn sort_compare_merge_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn sort_compare_merge_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn sort_compare_merge_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn sort_compare_merge_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn sort_compare_merge_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn sort_compare_merge_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn sort_compare_merge_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn sort_compare_merge_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn sort_compare_merge_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn sort_compare_merge_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn sort_compare_merge_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn sort_compare_merge_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn sort_compare_merge_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn sort_compare_merge_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct SortcomparemergeFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_compare_merge_frame_make(size : Int) -> SortcomparemergeFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_compare_merge_frame_len(s : SortcomparemergeFrame) -> Int { s.size }

pub fn sort_compare_merge_frame_get(s : SortcomparemergeFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_compare_merge_frame_set(s : SortcomparemergeFrame, i : Int, v : Double) -> SortcomparemergeFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_compare_merge_frame_sum(s : SortcomparemergeFrame) -> Double { @_common.sum(s.data) }

pub fn sort_compare_merge_frame_mean(s : SortcomparemergeFrame) -> Double { @_common.mean(s.data) }

pub fn sort_compare_merge_frame_scale(s : SortcomparemergeFrame, f : Double) -> SortcomparemergeFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_compare_merge_frame_add(a : SortcomparemergeFrame, b : SortcomparemergeFrame) -> SortcomparemergeFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_compare_merge_frame_copy(s : SortcomparemergeFrame) -> SortcomparemergeFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_compare_merge_frame_fill(s : SortcomparemergeFrame, v : Double) -> SortcomparemergeFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_compare_merge_frame_min(s : SortcomparemergeFrame) -> Double { @_common.min(s.data) }

pub fn sort_compare_merge_frame_max(s : SortcomparemergeFrame) -> Double { @_common.max(s.data) }

pub fn sort_compare_merge_frame_to_string(s : SortcomparemergeFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortcomparemergeTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_compare_merge_table_make(size : Int) -> SortcomparemergeTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_compare_merge_table_len(s : SortcomparemergeTable) -> Int { s.size }

pub fn sort_compare_merge_table_get(s : SortcomparemergeTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_compare_merge_table_set(s : SortcomparemergeTable, i : Int, v : Double) -> SortcomparemergeTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_compare_merge_table_sum(s : SortcomparemergeTable) -> Double { @_common.sum(s.data) }

pub fn sort_compare_merge_table_mean(s : SortcomparemergeTable) -> Double { @_common.mean(s.data) }

pub fn sort_compare_merge_table_scale(s : SortcomparemergeTable, f : Double) -> SortcomparemergeTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_compare_merge_table_add(a : SortcomparemergeTable, b : SortcomparemergeTable) -> SortcomparemergeTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_compare_merge_table_copy(s : SortcomparemergeTable) -> SortcomparemergeTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_compare_merge_table_fill(s : SortcomparemergeTable, v : Double) -> SortcomparemergeTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_compare_merge_table_min(s : SortcomparemergeTable) -> Double { @_common.min(s.data) }

pub fn sort_compare_merge_table_max(s : SortcomparemergeTable) -> Double { @_common.max(s.data) }

pub fn sort_compare_merge_table_to_string(s : SortcomparemergeTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortcomparemergeGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_compare_merge_graphn_make(size : Int) -> SortcomparemergeGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_compare_merge_graphn_len(s : SortcomparemergeGraphN) -> Int { s.size }

pub fn sort_compare_merge_graphn_get(s : SortcomparemergeGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_compare_merge_graphn_set(s : SortcomparemergeGraphN, i : Int, v : Double) -> SortcomparemergeGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_compare_merge_graphn_sum(s : SortcomparemergeGraphN) -> Double { @_common.sum(s.data) }

pub fn sort_compare_merge_graphn_mean(s : SortcomparemergeGraphN) -> Double { @_common.mean(s.data) }

pub fn sort_compare_merge_graphn_scale(s : SortcomparemergeGraphN, f : Double) -> SortcomparemergeGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_compare_merge_graphn_add(a : SortcomparemergeGraphN, b : SortcomparemergeGraphN) -> SortcomparemergeGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_compare_merge_graphn_copy(s : SortcomparemergeGraphN) -> SortcomparemergeGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_compare_merge_graphn_fill(s : SortcomparemergeGraphN, v : Double) -> SortcomparemergeGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_compare_merge_graphn_min(s : SortcomparemergeGraphN) -> Double { @_common.min(s.data) }

pub fn sort_compare_merge_graphn_max(s : SortcomparemergeGraphN) -> Double { @_common.max(s.data) }

pub fn sort_compare_merge_graphn_to_string(s : SortcomparemergeGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortcomparemergeNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_compare_merge_node_make(size : Int) -> SortcomparemergeNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_compare_merge_node_len(s : SortcomparemergeNode) -> Int { s.size }

pub fn sort_compare_merge_node_get(s : SortcomparemergeNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_compare_merge_node_set(s : SortcomparemergeNode, i : Int, v : Double) -> SortcomparemergeNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_compare_merge_node_sum(s : SortcomparemergeNode) -> Double { @_common.sum(s.data) }

pub fn sort_compare_merge_node_mean(s : SortcomparemergeNode) -> Double { @_common.mean(s.data) }

pub fn sort_compare_merge_node_scale(s : SortcomparemergeNode, f : Double) -> SortcomparemergeNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_compare_merge_node_add(a : SortcomparemergeNode, b : SortcomparemergeNode) -> SortcomparemergeNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_compare_merge_node_copy(s : SortcomparemergeNode) -> SortcomparemergeNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_compare_merge_node_fill(s : SortcomparemergeNode, v : Double) -> SortcomparemergeNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_compare_merge_node_min(s : SortcomparemergeNode) -> Double { @_common.min(s.data) }

pub fn sort_compare_merge_node_max(s : SortcomparemergeNode) -> Double { @_common.max(s.data) }

pub fn sort_compare_merge_node_to_string(s : SortcomparemergeNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortcomparemergeEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_compare_merge_edge_make(size : Int) -> SortcomparemergeEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_compare_merge_edge_len(s : SortcomparemergeEdge) -> Int { s.size }

pub fn sort_compare_merge_edge_get(s : SortcomparemergeEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_compare_merge_edge_set(s : SortcomparemergeEdge, i : Int, v : Double) -> SortcomparemergeEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_compare_merge_edge_sum(s : SortcomparemergeEdge) -> Double { @_common.sum(s.data) }

pub fn sort_compare_merge_edge_mean(s : SortcomparemergeEdge) -> Double { @_common.mean(s.data) }

pub fn sort_compare_merge_edge_scale(s : SortcomparemergeEdge, f : Double) -> SortcomparemergeEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_compare_merge_edge_add(a : SortcomparemergeEdge, b : SortcomparemergeEdge) -> SortcomparemergeEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_compare_merge_edge_copy(s : SortcomparemergeEdge) -> SortcomparemergeEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_compare_merge_edge_fill(s : SortcomparemergeEdge, v : Double) -> SortcomparemergeEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_compare_merge_edge_min(s : SortcomparemergeEdge) -> Double { @_common.min(s.data) }

pub fn sort_compare_merge_edge_max(s : SortcomparemergeEdge) -> Double { @_common.max(s.data) }

pub fn sort_compare_merge_edge_to_string(s : SortcomparemergeEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortcomparemergePath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_compare_merge_path_make(size : Int) -> SortcomparemergePath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_compare_merge_path_len(s : SortcomparemergePath) -> Int { s.size }

pub fn sort_compare_merge_path_get(s : SortcomparemergePath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_compare_merge_path_set(s : SortcomparemergePath, i : Int, v : Double) -> SortcomparemergePath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_compare_merge_path_sum(s : SortcomparemergePath) -> Double { @_common.sum(s.data) }

pub fn sort_compare_merge_path_mean(s : SortcomparemergePath) -> Double { @_common.mean(s.data) }

pub fn sort_compare_merge_path_scale(s : SortcomparemergePath, f : Double) -> SortcomparemergePath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_compare_merge_path_add(a : SortcomparemergePath, b : SortcomparemergePath) -> SortcomparemergePath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_compare_merge_path_copy(s : SortcomparemergePath) -> SortcomparemergePath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_compare_merge_path_fill(s : SortcomparemergePath, v : Double) -> SortcomparemergePath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_compare_merge_path_min(s : SortcomparemergePath) -> Double { @_common.min(s.data) }

pub fn sort_compare_merge_path_max(s : SortcomparemergePath) -> Double { @_common.max(s.data) }

pub fn sort_compare_merge_path_to_string(s : SortcomparemergePath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortcomparemergeCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_compare_merge_cluster_make(size : Int) -> SortcomparemergeCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_compare_merge_cluster_len(s : SortcomparemergeCluster) -> Int { s.size }

pub fn sort_compare_merge_cluster_get(s : SortcomparemergeCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_compare_merge_cluster_set(s : SortcomparemergeCluster, i : Int, v : Double) -> SortcomparemergeCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_compare_merge_cluster_sum(s : SortcomparemergeCluster) -> Double { @_common.sum(s.data) }

pub fn sort_compare_merge_cluster_mean(s : SortcomparemergeCluster) -> Double { @_common.mean(s.data) }

pub fn sort_compare_merge_cluster_scale(s : SortcomparemergeCluster, f : Double) -> SortcomparemergeCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_compare_merge_cluster_add(a : SortcomparemergeCluster, b : SortcomparemergeCluster) -> SortcomparemergeCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_compare_merge_cluster_copy(s : SortcomparemergeCluster) -> SortcomparemergeCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_compare_merge_cluster_fill(s : SortcomparemergeCluster, v : Double) -> SortcomparemergeCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_compare_merge_cluster_min(s : SortcomparemergeCluster) -> Double { @_common.min(s.data) }

pub fn sort_compare_merge_cluster_max(s : SortcomparemergeCluster) -> Double { @_common.max(s.data) }

pub fn sort_compare_merge_cluster_to_string(s : SortcomparemergeCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortcomparemergeModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_compare_merge_model_make(size : Int) -> SortcomparemergeModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_compare_merge_model_len(s : SortcomparemergeModel) -> Int { s.size }

pub fn sort_compare_merge_model_get(s : SortcomparemergeModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_compare_merge_model_set(s : SortcomparemergeModel, i : Int, v : Double) -> SortcomparemergeModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_compare_merge_model_sum(s : SortcomparemergeModel) -> Double { @_common.sum(s.data) }

pub fn sort_compare_merge_model_mean(s : SortcomparemergeModel) -> Double { @_common.mean(s.data) }

pub fn sort_compare_merge_model_scale(s : SortcomparemergeModel, f : Double) -> SortcomparemergeModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_compare_merge_model_add(a : SortcomparemergeModel, b : SortcomparemergeModel) -> SortcomparemergeModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_compare_merge_model_copy(s : SortcomparemergeModel) -> SortcomparemergeModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_compare_merge_model_fill(s : SortcomparemergeModel, v : Double) -> SortcomparemergeModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_compare_merge_model_min(s : SortcomparemergeModel) -> Double { @_common.min(s.data) }

pub fn sort_compare_merge_model_max(s : SortcomparemergeModel) -> Double { @_common.max(s.data) }

pub fn sort_compare_merge_model_to_string(s : SortcomparemergeModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortcomparemergeLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_compare_merge_layer_make(size : Int) -> SortcomparemergeLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_compare_merge_layer_len(s : SortcomparemergeLayer) -> Int { s.size }

pub fn sort_compare_merge_layer_get(s : SortcomparemergeLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_compare_merge_layer_set(s : SortcomparemergeLayer, i : Int, v : Double) -> SortcomparemergeLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_compare_merge_layer_sum(s : SortcomparemergeLayer) -> Double { @_common.sum(s.data) }

pub fn sort_compare_merge_layer_mean(s : SortcomparemergeLayer) -> Double { @_common.mean(s.data) }

pub fn sort_compare_merge_layer_scale(s : SortcomparemergeLayer, f : Double) -> SortcomparemergeLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_compare_merge_layer_add(a : SortcomparemergeLayer, b : SortcomparemergeLayer) -> SortcomparemergeLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_compare_merge_layer_copy(s : SortcomparemergeLayer) -> SortcomparemergeLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_compare_merge_layer_fill(s : SortcomparemergeLayer, v : Double) -> SortcomparemergeLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_compare_merge_layer_min(s : SortcomparemergeLayer) -> Double { @_common.min(s.data) }

pub fn sort_compare_merge_layer_max(s : SortcomparemergeLayer) -> Double { @_common.max(s.data) }

pub fn sort_compare_merge_layer_to_string(s : SortcomparemergeLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortcomparemergeBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_compare_merge_buffer_make(size : Int) -> SortcomparemergeBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_compare_merge_buffer_len(s : SortcomparemergeBuffer) -> Int { s.size }

pub fn sort_compare_merge_buffer_get(s : SortcomparemergeBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_compare_merge_buffer_set(s : SortcomparemergeBuffer, i : Int, v : Double) -> SortcomparemergeBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_compare_merge_buffer_sum(s : SortcomparemergeBuffer) -> Double { @_common.sum(s.data) }

pub fn sort_compare_merge_buffer_mean(s : SortcomparemergeBuffer) -> Double { @_common.mean(s.data) }

pub fn sort_compare_merge_buffer_scale(s : SortcomparemergeBuffer, f : Double) -> SortcomparemergeBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_compare_merge_buffer_add(a : SortcomparemergeBuffer, b : SortcomparemergeBuffer) -> SortcomparemergeBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_compare_merge_buffer_copy(s : SortcomparemergeBuffer) -> SortcomparemergeBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_compare_merge_buffer_fill(s : SortcomparemergeBuffer, v : Double) -> SortcomparemergeBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_compare_merge_buffer_min(s : SortcomparemergeBuffer) -> Double { @_common.min(s.data) }

pub fn sort_compare_merge_buffer_max(s : SortcomparemergeBuffer) -> Double { @_common.max(s.data) }

pub fn sort_compare_merge_buffer_to_string(s : SortcomparemergeBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortcomparemergeCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_compare_merge_cursor_make(size : Int) -> SortcomparemergeCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_compare_merge_cursor_len(s : SortcomparemergeCursor) -> Int { s.size }

pub fn sort_compare_merge_cursor_get(s : SortcomparemergeCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_compare_merge_cursor_set(s : SortcomparemergeCursor, i : Int, v : Double) -> SortcomparemergeCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_compare_merge_cursor_sum(s : SortcomparemergeCursor) -> Double { @_common.sum(s.data) }

pub fn sort_compare_merge_cursor_mean(s : SortcomparemergeCursor) -> Double { @_common.mean(s.data) }

pub fn sort_compare_merge_cursor_scale(s : SortcomparemergeCursor, f : Double) -> SortcomparemergeCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_compare_merge_cursor_add(a : SortcomparemergeCursor, b : SortcomparemergeCursor) -> SortcomparemergeCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_compare_merge_cursor_copy(s : SortcomparemergeCursor) -> SortcomparemergeCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_compare_merge_cursor_fill(s : SortcomparemergeCursor, v : Double) -> SortcomparemergeCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_compare_merge_cursor_min(s : SortcomparemergeCursor) -> Double { @_common.min(s.data) }

pub fn sort_compare_merge_cursor_max(s : SortcomparemergeCursor) -> Double { @_common.max(s.data) }

pub fn sort_compare_merge_cursor_to_string(s : SortcomparemergeCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortcomparemergeView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_compare_merge_view_make(size : Int) -> SortcomparemergeView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_compare_merge_view_len(s : SortcomparemergeView) -> Int { s.size }

pub fn sort_compare_merge_view_get(s : SortcomparemergeView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_compare_merge_view_set(s : SortcomparemergeView, i : Int, v : Double) -> SortcomparemergeView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_compare_merge_view_sum(s : SortcomparemergeView) -> Double { @_common.sum(s.data) }

pub fn sort_compare_merge_view_mean(s : SortcomparemergeView) -> Double { @_common.mean(s.data) }

pub fn sort_compare_merge_view_scale(s : SortcomparemergeView, f : Double) -> SortcomparemergeView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_compare_merge_view_add(a : SortcomparemergeView, b : SortcomparemergeView) -> SortcomparemergeView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_compare_merge_view_copy(s : SortcomparemergeView) -> SortcomparemergeView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_compare_merge_view_fill(s : SortcomparemergeView, v : Double) -> SortcomparemergeView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_compare_merge_view_min(s : SortcomparemergeView) -> Double { @_common.min(s.data) }

pub fn sort_compare_merge_view_max(s : SortcomparemergeView) -> Double { @_common.max(s.data) }

pub fn sort_compare_merge_view_to_string(s : SortcomparemergeView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortcomparemergeRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_compare_merge_range_make(size : Int) -> SortcomparemergeRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_compare_merge_range_len(s : SortcomparemergeRange) -> Int { s.size }

pub fn sort_compare_merge_range_get(s : SortcomparemergeRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_compare_merge_range_set(s : SortcomparemergeRange, i : Int, v : Double) -> SortcomparemergeRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_compare_merge_range_sum(s : SortcomparemergeRange) -> Double { @_common.sum(s.data) }

pub fn sort_compare_merge_range_mean(s : SortcomparemergeRange) -> Double { @_common.mean(s.data) }

pub fn sort_compare_merge_range_scale(s : SortcomparemergeRange, f : Double) -> SortcomparemergeRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_compare_merge_range_add(a : SortcomparemergeRange, b : SortcomparemergeRange) -> SortcomparemergeRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_compare_merge_range_copy(s : SortcomparemergeRange) -> SortcomparemergeRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_compare_merge_range_fill(s : SortcomparemergeRange, v : Double) -> SortcomparemergeRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_compare_merge_range_min(s : SortcomparemergeRange) -> Double { @_common.min(s.data) }

pub fn sort_compare_merge_range_max(s : SortcomparemergeRange) -> Double { @_common.max(s.data) }

pub fn sort_compare_merge_range_to_string(s : SortcomparemergeRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortcomparemergeSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_compare_merge_slice_make(size : Int) -> SortcomparemergeSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_compare_merge_slice_len(s : SortcomparemergeSlice) -> Int { s.size }

pub fn sort_compare_merge_slice_get(s : SortcomparemergeSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_compare_merge_slice_set(s : SortcomparemergeSlice, i : Int, v : Double) -> SortcomparemergeSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_compare_merge_slice_sum(s : SortcomparemergeSlice) -> Double { @_common.sum(s.data) }

pub fn sort_compare_merge_slice_mean(s : SortcomparemergeSlice) -> Double { @_common.mean(s.data) }

pub fn sort_compare_merge_slice_scale(s : SortcomparemergeSlice, f : Double) -> SortcomparemergeSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_compare_merge_slice_add(a : SortcomparemergeSlice, b : SortcomparemergeSlice) -> SortcomparemergeSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_compare_merge_slice_copy(s : SortcomparemergeSlice) -> SortcomparemergeSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_compare_merge_slice_fill(s : SortcomparemergeSlice, v : Double) -> SortcomparemergeSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_compare_merge_slice_min(s : SortcomparemergeSlice) -> Double { @_common.min(s.data) }

pub fn sort_compare_merge_slice_max(s : SortcomparemergeSlice) -> Double { @_common.max(s.data) }

pub fn sort_compare_merge_slice_to_string(s : SortcomparemergeSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

