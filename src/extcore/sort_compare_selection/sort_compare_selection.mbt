///===
/// extcore/sort_compare_selection

pub(all) struct SortcompareselectionPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn sort_compare_selection_make_point(x : Double, y : Double) -> SortcompareselectionPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn sort_compare_selection_make_point3(x : Double, y : Double, z : Double) -> SortcompareselectionPoint {
  { x, y, z, label: 0 }
}

pub fn SortcompareselectionPoint::x(self : SortcompareselectionPoint) -> Double { self.x }

pub fn SortcompareselectionPoint::y(self : SortcompareselectionPoint) -> Double { self.y }

pub fn SortcompareselectionPoint::z(self : SortcompareselectionPoint) -> Double { self.z }

pub fn SortcompareselectionPoint::label(self : SortcompareselectionPoint) -> Int { self.label }

pub fn SortcompareselectionPoint::dist(self : SortcompareselectionPoint, other : SortcompareselectionPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn SortcompareselectionPoint::add(self : SortcompareselectionPoint, other : SortcompareselectionPoint) -> SortcompareselectionPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn SortcompareselectionPoint::sub(self : SortcompareselectionPoint, other : SortcompareselectionPoint) -> SortcompareselectionPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn SortcompareselectionPoint::scale(self : SortcompareselectionPoint, s : Double) -> SortcompareselectionPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn SortcompareselectionPoint::dot(self : SortcompareselectionPoint, other : SortcompareselectionPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn SortcompareselectionPoint::cross(self : SortcompareselectionPoint, other : SortcompareselectionPoint) -> SortcompareselectionPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn SortcompareselectionPoint::norm(self : SortcompareselectionPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn SortcompareselectionPoint::normalize(self : SortcompareselectionPoint) -> SortcompareselectionPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn SortcompareselectionPoint::negate(self : SortcompareselectionPoint) -> SortcompareselectionPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn SortcompareselectionPoint::mid(self : SortcompareselectionPoint, other : SortcompareselectionPoint) -> SortcompareselectionPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn SortcompareselectionPoint::lerp(self : SortcompareselectionPoint, other : SortcompareselectionPoint, t : Double) -> SortcompareselectionPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn SortcompareselectionPoint::to_string(self : SortcompareselectionPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct SortcompareselectionSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn sort_compare_selection_make_series(vals : Array[Double], name : String) -> SortcompareselectionSeries {
  { vals, name, meta: 0 }
}

pub fn SortcompareselectionSeries::len(self : SortcompareselectionSeries) -> Int { self.vals.length() }

pub fn SortcompareselectionSeries::sum(self : SortcompareselectionSeries) -> Double { @_common.sum(self.vals) }

pub fn SortcompareselectionSeries::mean(self : SortcompareselectionSeries) -> Double { @_common.mean(self.vals) }

pub fn SortcompareselectionSeries::min(self : SortcompareselectionSeries) -> Double { @_common.min(self.vals) }

pub fn SortcompareselectionSeries::max(self : SortcompareselectionSeries) -> Double { @_common.max(self.vals) }

pub fn SortcompareselectionSeries::range(self : SortcompareselectionSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn SortcompareselectionSeries::variance(self : SortcompareselectionSeries) -> Double { @_common.variance(self.vals) }

pub fn SortcompareselectionSeries::std(self : SortcompareselectionSeries) -> Double { @_common.std(self.vals) }

pub fn SortcompareselectionSeries::median(self : SortcompareselectionSeries) -> Double { @_common.median(self.vals) }

pub fn SortcompareselectionSeries::scale(self : SortcompareselectionSeries, f : Double) -> SortcompareselectionSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn SortcompareselectionSeries::add(self : SortcompareselectionSeries, other : SortcompareselectionSeries) -> SortcompareselectionSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn SortcompareselectionSeries::sub(self : SortcompareselectionSeries, other : SortcompareselectionSeries) -> SortcompareselectionSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn SortcompareselectionSeries::normalize(self : SortcompareselectionSeries) -> SortcompareselectionSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn SortcompareselectionSeries::cumsum(self : SortcompareselectionSeries) -> SortcompareselectionSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn SortcompareselectionSeries::to_string(self : SortcompareselectionSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct SortcompareselectionMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn sort_compare_selection_make_matrix(rows : Int, cols : Int, val : Double) -> SortcompareselectionMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn sort_compare_selection_matrix_identity(n : Int) -> SortcompareselectionMatrix {
  let m = sort_compare_selection_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn SortcompareselectionMatrix::get(self : SortcompareselectionMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn SortcompareselectionMatrix::transpose(self : SortcompareselectionMatrix) -> SortcompareselectionMatrix {
  let result = sort_compare_selection_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn SortcompareselectionMatrix::add(self : SortcompareselectionMatrix, other : SortcompareselectionMatrix) -> SortcompareselectionMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = sort_compare_selection_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn SortcompareselectionMatrix::scale(self : SortcompareselectionMatrix, s : Double) -> SortcompareselectionMatrix {
  let result = sort_compare_selection_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn SortcompareselectionMatrix::multiply(self : SortcompareselectionMatrix, other : SortcompareselectionMatrix) -> SortcompareselectionMatrix {
  if self.cols != other.rows { return sort_compare_selection_make_matrix(self.rows, other.cols, 0.0) }
  let result = sort_compare_selection_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn SortcompareselectionMatrix::trace(self : SortcompareselectionMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn SortcompareselectionMatrix::det(self : SortcompareselectionMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn SortcompareselectionMatrix::norm(self : SortcompareselectionMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn SortcompareselectionMatrix::to_string(self : SortcompareselectionMatrix) -> String {
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

pub(all) struct SortcompareselectionVector {
  comps : Array[Double]
  dim : Int
}

pub fn sort_compare_selection_make_vector(comps : Array[Double]) -> SortcompareselectionVector {
  { comps, dim: comps.length() }
}

pub fn sort_compare_selection_vector_zero(dim : Int) -> SortcompareselectionVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn SortcompareselectionVector::add(self : SortcompareselectionVector, other : SortcompareselectionVector) -> SortcompareselectionVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn SortcompareselectionVector::sub(self : SortcompareselectionVector, other : SortcompareselectionVector) -> SortcompareselectionVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn SortcompareselectionVector::scale(self : SortcompareselectionVector, s : Double) -> SortcompareselectionVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn SortcompareselectionVector::dot(self : SortcompareselectionVector, other : SortcompareselectionVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn SortcompareselectionVector::norm(self : SortcompareselectionVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn SortcompareselectionVector::normalize(self : SortcompareselectionVector) -> SortcompareselectionVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn SortcompareselectionVector::dist(self : SortcompareselectionVector, other : SortcompareselectionVector) -> Double {
  self.sub(other).norm()
}

pub fn SortcompareselectionVector::to_string(self : SortcompareselectionVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn sort_compare_selection_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn sort_compare_selection_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn sort_compare_selection_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn sort_compare_selection_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn sort_compare_selection_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn sort_compare_selection_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn sort_compare_selection_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn sort_compare_selection_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn sort_compare_selection_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn sort_compare_selection_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn sort_compare_selection_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn sort_compare_selection_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn sort_compare_selection_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn sort_compare_selection_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn sort_compare_selection_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn sort_compare_selection_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn sort_compare_selection_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn sort_compare_selection_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn sort_compare_selection_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn sort_compare_selection_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn sort_compare_selection_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn sort_compare_selection_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn sort_compare_selection_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn sort_compare_selection_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn sort_compare_selection_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn sort_compare_selection_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn sort_compare_selection_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn sort_compare_selection_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn sort_compare_selection_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct SortcompareselectionFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_compare_selection_frame_make(size : Int) -> SortcompareselectionFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_compare_selection_frame_len(s : SortcompareselectionFrame) -> Int { s.size }

pub fn sort_compare_selection_frame_get(s : SortcompareselectionFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_compare_selection_frame_set(s : SortcompareselectionFrame, i : Int, v : Double) -> SortcompareselectionFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_compare_selection_frame_sum(s : SortcompareselectionFrame) -> Double { @_common.sum(s.data) }

pub fn sort_compare_selection_frame_mean(s : SortcompareselectionFrame) -> Double { @_common.mean(s.data) }

pub fn sort_compare_selection_frame_scale(s : SortcompareselectionFrame, f : Double) -> SortcompareselectionFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_compare_selection_frame_add(a : SortcompareselectionFrame, b : SortcompareselectionFrame) -> SortcompareselectionFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_compare_selection_frame_copy(s : SortcompareselectionFrame) -> SortcompareselectionFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_compare_selection_frame_fill(s : SortcompareselectionFrame, v : Double) -> SortcompareselectionFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_compare_selection_frame_min(s : SortcompareselectionFrame) -> Double { @_common.min(s.data) }

pub fn sort_compare_selection_frame_max(s : SortcompareselectionFrame) -> Double { @_common.max(s.data) }

pub fn sort_compare_selection_frame_to_string(s : SortcompareselectionFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortcompareselectionTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_compare_selection_table_make(size : Int) -> SortcompareselectionTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_compare_selection_table_len(s : SortcompareselectionTable) -> Int { s.size }

pub fn sort_compare_selection_table_get(s : SortcompareselectionTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_compare_selection_table_set(s : SortcompareselectionTable, i : Int, v : Double) -> SortcompareselectionTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_compare_selection_table_sum(s : SortcompareselectionTable) -> Double { @_common.sum(s.data) }

pub fn sort_compare_selection_table_mean(s : SortcompareselectionTable) -> Double { @_common.mean(s.data) }

pub fn sort_compare_selection_table_scale(s : SortcompareselectionTable, f : Double) -> SortcompareselectionTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_compare_selection_table_add(a : SortcompareselectionTable, b : SortcompareselectionTable) -> SortcompareselectionTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_compare_selection_table_copy(s : SortcompareselectionTable) -> SortcompareselectionTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_compare_selection_table_fill(s : SortcompareselectionTable, v : Double) -> SortcompareselectionTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_compare_selection_table_min(s : SortcompareselectionTable) -> Double { @_common.min(s.data) }

pub fn sort_compare_selection_table_max(s : SortcompareselectionTable) -> Double { @_common.max(s.data) }

pub fn sort_compare_selection_table_to_string(s : SortcompareselectionTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortcompareselectionGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_compare_selection_graphn_make(size : Int) -> SortcompareselectionGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_compare_selection_graphn_len(s : SortcompareselectionGraphN) -> Int { s.size }

pub fn sort_compare_selection_graphn_get(s : SortcompareselectionGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_compare_selection_graphn_set(s : SortcompareselectionGraphN, i : Int, v : Double) -> SortcompareselectionGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_compare_selection_graphn_sum(s : SortcompareselectionGraphN) -> Double { @_common.sum(s.data) }

pub fn sort_compare_selection_graphn_mean(s : SortcompareselectionGraphN) -> Double { @_common.mean(s.data) }

pub fn sort_compare_selection_graphn_scale(s : SortcompareselectionGraphN, f : Double) -> SortcompareselectionGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_compare_selection_graphn_add(a : SortcompareselectionGraphN, b : SortcompareselectionGraphN) -> SortcompareselectionGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_compare_selection_graphn_copy(s : SortcompareselectionGraphN) -> SortcompareselectionGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_compare_selection_graphn_fill(s : SortcompareselectionGraphN, v : Double) -> SortcompareselectionGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_compare_selection_graphn_min(s : SortcompareselectionGraphN) -> Double { @_common.min(s.data) }

pub fn sort_compare_selection_graphn_max(s : SortcompareselectionGraphN) -> Double { @_common.max(s.data) }

pub fn sort_compare_selection_graphn_to_string(s : SortcompareselectionGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortcompareselectionNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_compare_selection_node_make(size : Int) -> SortcompareselectionNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_compare_selection_node_len(s : SortcompareselectionNode) -> Int { s.size }

pub fn sort_compare_selection_node_get(s : SortcompareselectionNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_compare_selection_node_set(s : SortcompareselectionNode, i : Int, v : Double) -> SortcompareselectionNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_compare_selection_node_sum(s : SortcompareselectionNode) -> Double { @_common.sum(s.data) }

pub fn sort_compare_selection_node_mean(s : SortcompareselectionNode) -> Double { @_common.mean(s.data) }

pub fn sort_compare_selection_node_scale(s : SortcompareselectionNode, f : Double) -> SortcompareselectionNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_compare_selection_node_add(a : SortcompareselectionNode, b : SortcompareselectionNode) -> SortcompareselectionNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_compare_selection_node_copy(s : SortcompareselectionNode) -> SortcompareselectionNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_compare_selection_node_fill(s : SortcompareselectionNode, v : Double) -> SortcompareselectionNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_compare_selection_node_min(s : SortcompareselectionNode) -> Double { @_common.min(s.data) }

pub fn sort_compare_selection_node_max(s : SortcompareselectionNode) -> Double { @_common.max(s.data) }

pub fn sort_compare_selection_node_to_string(s : SortcompareselectionNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortcompareselectionEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_compare_selection_edge_make(size : Int) -> SortcompareselectionEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_compare_selection_edge_len(s : SortcompareselectionEdge) -> Int { s.size }

pub fn sort_compare_selection_edge_get(s : SortcompareselectionEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_compare_selection_edge_set(s : SortcompareselectionEdge, i : Int, v : Double) -> SortcompareselectionEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_compare_selection_edge_sum(s : SortcompareselectionEdge) -> Double { @_common.sum(s.data) }

pub fn sort_compare_selection_edge_mean(s : SortcompareselectionEdge) -> Double { @_common.mean(s.data) }

pub fn sort_compare_selection_edge_scale(s : SortcompareselectionEdge, f : Double) -> SortcompareselectionEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_compare_selection_edge_add(a : SortcompareselectionEdge, b : SortcompareselectionEdge) -> SortcompareselectionEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_compare_selection_edge_copy(s : SortcompareselectionEdge) -> SortcompareselectionEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_compare_selection_edge_fill(s : SortcompareselectionEdge, v : Double) -> SortcompareselectionEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_compare_selection_edge_min(s : SortcompareselectionEdge) -> Double { @_common.min(s.data) }

pub fn sort_compare_selection_edge_max(s : SortcompareselectionEdge) -> Double { @_common.max(s.data) }

pub fn sort_compare_selection_edge_to_string(s : SortcompareselectionEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortcompareselectionPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_compare_selection_path_make(size : Int) -> SortcompareselectionPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_compare_selection_path_len(s : SortcompareselectionPath) -> Int { s.size }

pub fn sort_compare_selection_path_get(s : SortcompareselectionPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_compare_selection_path_set(s : SortcompareselectionPath, i : Int, v : Double) -> SortcompareselectionPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_compare_selection_path_sum(s : SortcompareselectionPath) -> Double { @_common.sum(s.data) }

pub fn sort_compare_selection_path_mean(s : SortcompareselectionPath) -> Double { @_common.mean(s.data) }

pub fn sort_compare_selection_path_scale(s : SortcompareselectionPath, f : Double) -> SortcompareselectionPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_compare_selection_path_add(a : SortcompareselectionPath, b : SortcompareselectionPath) -> SortcompareselectionPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_compare_selection_path_copy(s : SortcompareselectionPath) -> SortcompareselectionPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_compare_selection_path_fill(s : SortcompareselectionPath, v : Double) -> SortcompareselectionPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_compare_selection_path_min(s : SortcompareselectionPath) -> Double { @_common.min(s.data) }

pub fn sort_compare_selection_path_max(s : SortcompareselectionPath) -> Double { @_common.max(s.data) }

pub fn sort_compare_selection_path_to_string(s : SortcompareselectionPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortcompareselectionCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_compare_selection_cluster_make(size : Int) -> SortcompareselectionCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_compare_selection_cluster_len(s : SortcompareselectionCluster) -> Int { s.size }

pub fn sort_compare_selection_cluster_get(s : SortcompareselectionCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_compare_selection_cluster_set(s : SortcompareselectionCluster, i : Int, v : Double) -> SortcompareselectionCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_compare_selection_cluster_sum(s : SortcompareselectionCluster) -> Double { @_common.sum(s.data) }

pub fn sort_compare_selection_cluster_mean(s : SortcompareselectionCluster) -> Double { @_common.mean(s.data) }

pub fn sort_compare_selection_cluster_scale(s : SortcompareselectionCluster, f : Double) -> SortcompareselectionCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_compare_selection_cluster_add(a : SortcompareselectionCluster, b : SortcompareselectionCluster) -> SortcompareselectionCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_compare_selection_cluster_copy(s : SortcompareselectionCluster) -> SortcompareselectionCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_compare_selection_cluster_fill(s : SortcompareselectionCluster, v : Double) -> SortcompareselectionCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_compare_selection_cluster_min(s : SortcompareselectionCluster) -> Double { @_common.min(s.data) }

pub fn sort_compare_selection_cluster_max(s : SortcompareselectionCluster) -> Double { @_common.max(s.data) }

pub fn sort_compare_selection_cluster_to_string(s : SortcompareselectionCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortcompareselectionModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_compare_selection_model_make(size : Int) -> SortcompareselectionModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_compare_selection_model_len(s : SortcompareselectionModel) -> Int { s.size }

pub fn sort_compare_selection_model_get(s : SortcompareselectionModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_compare_selection_model_set(s : SortcompareselectionModel, i : Int, v : Double) -> SortcompareselectionModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_compare_selection_model_sum(s : SortcompareselectionModel) -> Double { @_common.sum(s.data) }

pub fn sort_compare_selection_model_mean(s : SortcompareselectionModel) -> Double { @_common.mean(s.data) }

pub fn sort_compare_selection_model_scale(s : SortcompareselectionModel, f : Double) -> SortcompareselectionModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_compare_selection_model_add(a : SortcompareselectionModel, b : SortcompareselectionModel) -> SortcompareselectionModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_compare_selection_model_copy(s : SortcompareselectionModel) -> SortcompareselectionModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_compare_selection_model_fill(s : SortcompareselectionModel, v : Double) -> SortcompareselectionModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_compare_selection_model_min(s : SortcompareselectionModel) -> Double { @_common.min(s.data) }

pub fn sort_compare_selection_model_max(s : SortcompareselectionModel) -> Double { @_common.max(s.data) }

pub fn sort_compare_selection_model_to_string(s : SortcompareselectionModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortcompareselectionLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_compare_selection_layer_make(size : Int) -> SortcompareselectionLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_compare_selection_layer_len(s : SortcompareselectionLayer) -> Int { s.size }

pub fn sort_compare_selection_layer_get(s : SortcompareselectionLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_compare_selection_layer_set(s : SortcompareselectionLayer, i : Int, v : Double) -> SortcompareselectionLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_compare_selection_layer_sum(s : SortcompareselectionLayer) -> Double { @_common.sum(s.data) }

pub fn sort_compare_selection_layer_mean(s : SortcompareselectionLayer) -> Double { @_common.mean(s.data) }

pub fn sort_compare_selection_layer_scale(s : SortcompareselectionLayer, f : Double) -> SortcompareselectionLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_compare_selection_layer_add(a : SortcompareselectionLayer, b : SortcompareselectionLayer) -> SortcompareselectionLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_compare_selection_layer_copy(s : SortcompareselectionLayer) -> SortcompareselectionLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_compare_selection_layer_fill(s : SortcompareselectionLayer, v : Double) -> SortcompareselectionLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_compare_selection_layer_min(s : SortcompareselectionLayer) -> Double { @_common.min(s.data) }

pub fn sort_compare_selection_layer_max(s : SortcompareselectionLayer) -> Double { @_common.max(s.data) }

pub fn sort_compare_selection_layer_to_string(s : SortcompareselectionLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortcompareselectionBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_compare_selection_buffer_make(size : Int) -> SortcompareselectionBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_compare_selection_buffer_len(s : SortcompareselectionBuffer) -> Int { s.size }

pub fn sort_compare_selection_buffer_get(s : SortcompareselectionBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_compare_selection_buffer_set(s : SortcompareselectionBuffer, i : Int, v : Double) -> SortcompareselectionBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_compare_selection_buffer_sum(s : SortcompareselectionBuffer) -> Double { @_common.sum(s.data) }

pub fn sort_compare_selection_buffer_mean(s : SortcompareselectionBuffer) -> Double { @_common.mean(s.data) }

pub fn sort_compare_selection_buffer_scale(s : SortcompareselectionBuffer, f : Double) -> SortcompareselectionBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_compare_selection_buffer_add(a : SortcompareselectionBuffer, b : SortcompareselectionBuffer) -> SortcompareselectionBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_compare_selection_buffer_copy(s : SortcompareselectionBuffer) -> SortcompareselectionBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_compare_selection_buffer_fill(s : SortcompareselectionBuffer, v : Double) -> SortcompareselectionBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_compare_selection_buffer_min(s : SortcompareselectionBuffer) -> Double { @_common.min(s.data) }

pub fn sort_compare_selection_buffer_max(s : SortcompareselectionBuffer) -> Double { @_common.max(s.data) }

pub fn sort_compare_selection_buffer_to_string(s : SortcompareselectionBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortcompareselectionCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_compare_selection_cursor_make(size : Int) -> SortcompareselectionCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_compare_selection_cursor_len(s : SortcompareselectionCursor) -> Int { s.size }

pub fn sort_compare_selection_cursor_get(s : SortcompareselectionCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_compare_selection_cursor_set(s : SortcompareselectionCursor, i : Int, v : Double) -> SortcompareselectionCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_compare_selection_cursor_sum(s : SortcompareselectionCursor) -> Double { @_common.sum(s.data) }

pub fn sort_compare_selection_cursor_mean(s : SortcompareselectionCursor) -> Double { @_common.mean(s.data) }

pub fn sort_compare_selection_cursor_scale(s : SortcompareselectionCursor, f : Double) -> SortcompareselectionCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_compare_selection_cursor_add(a : SortcompareselectionCursor, b : SortcompareselectionCursor) -> SortcompareselectionCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_compare_selection_cursor_copy(s : SortcompareselectionCursor) -> SortcompareselectionCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_compare_selection_cursor_fill(s : SortcompareselectionCursor, v : Double) -> SortcompareselectionCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_compare_selection_cursor_min(s : SortcompareselectionCursor) -> Double { @_common.min(s.data) }

pub fn sort_compare_selection_cursor_max(s : SortcompareselectionCursor) -> Double { @_common.max(s.data) }

pub fn sort_compare_selection_cursor_to_string(s : SortcompareselectionCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortcompareselectionView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_compare_selection_view_make(size : Int) -> SortcompareselectionView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_compare_selection_view_len(s : SortcompareselectionView) -> Int { s.size }

pub fn sort_compare_selection_view_get(s : SortcompareselectionView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_compare_selection_view_set(s : SortcompareselectionView, i : Int, v : Double) -> SortcompareselectionView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_compare_selection_view_sum(s : SortcompareselectionView) -> Double { @_common.sum(s.data) }

pub fn sort_compare_selection_view_mean(s : SortcompareselectionView) -> Double { @_common.mean(s.data) }

pub fn sort_compare_selection_view_scale(s : SortcompareselectionView, f : Double) -> SortcompareselectionView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_compare_selection_view_add(a : SortcompareselectionView, b : SortcompareselectionView) -> SortcompareselectionView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_compare_selection_view_copy(s : SortcompareselectionView) -> SortcompareselectionView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_compare_selection_view_fill(s : SortcompareselectionView, v : Double) -> SortcompareselectionView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_compare_selection_view_min(s : SortcompareselectionView) -> Double { @_common.min(s.data) }

pub fn sort_compare_selection_view_max(s : SortcompareselectionView) -> Double { @_common.max(s.data) }

pub fn sort_compare_selection_view_to_string(s : SortcompareselectionView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortcompareselectionRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_compare_selection_range_make(size : Int) -> SortcompareselectionRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_compare_selection_range_len(s : SortcompareselectionRange) -> Int { s.size }

pub fn sort_compare_selection_range_get(s : SortcompareselectionRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_compare_selection_range_set(s : SortcompareselectionRange, i : Int, v : Double) -> SortcompareselectionRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_compare_selection_range_sum(s : SortcompareselectionRange) -> Double { @_common.sum(s.data) }

pub fn sort_compare_selection_range_mean(s : SortcompareselectionRange) -> Double { @_common.mean(s.data) }

pub fn sort_compare_selection_range_scale(s : SortcompareselectionRange, f : Double) -> SortcompareselectionRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_compare_selection_range_add(a : SortcompareselectionRange, b : SortcompareselectionRange) -> SortcompareselectionRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_compare_selection_range_copy(s : SortcompareselectionRange) -> SortcompareselectionRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_compare_selection_range_fill(s : SortcompareselectionRange, v : Double) -> SortcompareselectionRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_compare_selection_range_min(s : SortcompareselectionRange) -> Double { @_common.min(s.data) }

pub fn sort_compare_selection_range_max(s : SortcompareselectionRange) -> Double { @_common.max(s.data) }

pub fn sort_compare_selection_range_to_string(s : SortcompareselectionRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortcompareselectionSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_compare_selection_slice_make(size : Int) -> SortcompareselectionSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_compare_selection_slice_len(s : SortcompareselectionSlice) -> Int { s.size }

pub fn sort_compare_selection_slice_get(s : SortcompareselectionSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_compare_selection_slice_set(s : SortcompareselectionSlice, i : Int, v : Double) -> SortcompareselectionSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_compare_selection_slice_sum(s : SortcompareselectionSlice) -> Double { @_common.sum(s.data) }

pub fn sort_compare_selection_slice_mean(s : SortcompareselectionSlice) -> Double { @_common.mean(s.data) }

pub fn sort_compare_selection_slice_scale(s : SortcompareselectionSlice, f : Double) -> SortcompareselectionSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_compare_selection_slice_add(a : SortcompareselectionSlice, b : SortcompareselectionSlice) -> SortcompareselectionSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_compare_selection_slice_copy(s : SortcompareselectionSlice) -> SortcompareselectionSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_compare_selection_slice_fill(s : SortcompareselectionSlice, v : Double) -> SortcompareselectionSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_compare_selection_slice_min(s : SortcompareselectionSlice) -> Double { @_common.min(s.data) }

pub fn sort_compare_selection_slice_max(s : SortcompareselectionSlice) -> Double { @_common.max(s.data) }

pub fn sort_compare_selection_slice_to_string(s : SortcompareselectionSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

