///===
/// extcore/sort_compare_intro

pub(all) struct SortcompareintroPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn sort_compare_intro_make_point(x : Double, y : Double) -> SortcompareintroPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn sort_compare_intro_make_point3(x : Double, y : Double, z : Double) -> SortcompareintroPoint {
  { x, y, z, label: 0 }
}

pub fn SortcompareintroPoint::x(self : SortcompareintroPoint) -> Double { self.x }

pub fn SortcompareintroPoint::y(self : SortcompareintroPoint) -> Double { self.y }

pub fn SortcompareintroPoint::z(self : SortcompareintroPoint) -> Double { self.z }

pub fn SortcompareintroPoint::label(self : SortcompareintroPoint) -> Int { self.label }

pub fn SortcompareintroPoint::dist(self : SortcompareintroPoint, other : SortcompareintroPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn SortcompareintroPoint::add(self : SortcompareintroPoint, other : SortcompareintroPoint) -> SortcompareintroPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn SortcompareintroPoint::sub(self : SortcompareintroPoint, other : SortcompareintroPoint) -> SortcompareintroPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn SortcompareintroPoint::scale(self : SortcompareintroPoint, s : Double) -> SortcompareintroPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn SortcompareintroPoint::dot(self : SortcompareintroPoint, other : SortcompareintroPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn SortcompareintroPoint::cross(self : SortcompareintroPoint, other : SortcompareintroPoint) -> SortcompareintroPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn SortcompareintroPoint::norm(self : SortcompareintroPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn SortcompareintroPoint::normalize(self : SortcompareintroPoint) -> SortcompareintroPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn SortcompareintroPoint::negate(self : SortcompareintroPoint) -> SortcompareintroPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn SortcompareintroPoint::mid(self : SortcompareintroPoint, other : SortcompareintroPoint) -> SortcompareintroPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn SortcompareintroPoint::lerp(self : SortcompareintroPoint, other : SortcompareintroPoint, t : Double) -> SortcompareintroPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn SortcompareintroPoint::to_string(self : SortcompareintroPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct SortcompareintroSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn sort_compare_intro_make_series(vals : Array[Double], name : String) -> SortcompareintroSeries {
  { vals, name, meta: 0 }
}

pub fn SortcompareintroSeries::len(self : SortcompareintroSeries) -> Int { self.vals.length() }

pub fn SortcompareintroSeries::sum(self : SortcompareintroSeries) -> Double { @_common.sum(self.vals) }

pub fn SortcompareintroSeries::mean(self : SortcompareintroSeries) -> Double { @_common.mean(self.vals) }

pub fn SortcompareintroSeries::min(self : SortcompareintroSeries) -> Double { @_common.min(self.vals) }

pub fn SortcompareintroSeries::max(self : SortcompareintroSeries) -> Double { @_common.max(self.vals) }

pub fn SortcompareintroSeries::range(self : SortcompareintroSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn SortcompareintroSeries::variance(self : SortcompareintroSeries) -> Double { @_common.variance(self.vals) }

pub fn SortcompareintroSeries::std(self : SortcompareintroSeries) -> Double { @_common.std(self.vals) }

pub fn SortcompareintroSeries::median(self : SortcompareintroSeries) -> Double { @_common.median(self.vals) }

pub fn SortcompareintroSeries::scale(self : SortcompareintroSeries, f : Double) -> SortcompareintroSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn SortcompareintroSeries::add(self : SortcompareintroSeries, other : SortcompareintroSeries) -> SortcompareintroSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn SortcompareintroSeries::sub(self : SortcompareintroSeries, other : SortcompareintroSeries) -> SortcompareintroSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn SortcompareintroSeries::normalize(self : SortcompareintroSeries) -> SortcompareintroSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn SortcompareintroSeries::cumsum(self : SortcompareintroSeries) -> SortcompareintroSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn SortcompareintroSeries::to_string(self : SortcompareintroSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct SortcompareintroMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn sort_compare_intro_make_matrix(rows : Int, cols : Int, val : Double) -> SortcompareintroMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn sort_compare_intro_matrix_identity(n : Int) -> SortcompareintroMatrix {
  let m = sort_compare_intro_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn SortcompareintroMatrix::get(self : SortcompareintroMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn SortcompareintroMatrix::transpose(self : SortcompareintroMatrix) -> SortcompareintroMatrix {
  let result = sort_compare_intro_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn SortcompareintroMatrix::add(self : SortcompareintroMatrix, other : SortcompareintroMatrix) -> SortcompareintroMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = sort_compare_intro_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn SortcompareintroMatrix::scale(self : SortcompareintroMatrix, s : Double) -> SortcompareintroMatrix {
  let result = sort_compare_intro_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn SortcompareintroMatrix::multiply(self : SortcompareintroMatrix, other : SortcompareintroMatrix) -> SortcompareintroMatrix {
  if self.cols != other.rows { return sort_compare_intro_make_matrix(self.rows, other.cols, 0.0) }
  let result = sort_compare_intro_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn SortcompareintroMatrix::trace(self : SortcompareintroMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn SortcompareintroMatrix::det(self : SortcompareintroMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn SortcompareintroMatrix::norm(self : SortcompareintroMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn SortcompareintroMatrix::to_string(self : SortcompareintroMatrix) -> String {
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

pub(all) struct SortcompareintroVector {
  comps : Array[Double]
  dim : Int
}

pub fn sort_compare_intro_make_vector(comps : Array[Double]) -> SortcompareintroVector {
  { comps, dim: comps.length() }
}

pub fn sort_compare_intro_vector_zero(dim : Int) -> SortcompareintroVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn SortcompareintroVector::add(self : SortcompareintroVector, other : SortcompareintroVector) -> SortcompareintroVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn SortcompareintroVector::sub(self : SortcompareintroVector, other : SortcompareintroVector) -> SortcompareintroVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn SortcompareintroVector::scale(self : SortcompareintroVector, s : Double) -> SortcompareintroVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn SortcompareintroVector::dot(self : SortcompareintroVector, other : SortcompareintroVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn SortcompareintroVector::norm(self : SortcompareintroVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn SortcompareintroVector::normalize(self : SortcompareintroVector) -> SortcompareintroVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn SortcompareintroVector::dist(self : SortcompareintroVector, other : SortcompareintroVector) -> Double {
  self.sub(other).norm()
}

pub fn SortcompareintroVector::to_string(self : SortcompareintroVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn sort_compare_intro_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn sort_compare_intro_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn sort_compare_intro_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn sort_compare_intro_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn sort_compare_intro_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn sort_compare_intro_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn sort_compare_intro_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn sort_compare_intro_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn sort_compare_intro_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn sort_compare_intro_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn sort_compare_intro_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn sort_compare_intro_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn sort_compare_intro_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn sort_compare_intro_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn sort_compare_intro_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn sort_compare_intro_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn sort_compare_intro_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn sort_compare_intro_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn sort_compare_intro_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn sort_compare_intro_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn sort_compare_intro_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn sort_compare_intro_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn sort_compare_intro_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn sort_compare_intro_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn sort_compare_intro_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn sort_compare_intro_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn sort_compare_intro_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn sort_compare_intro_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn sort_compare_intro_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct SortcompareintroFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_compare_intro_frame_make(size : Int) -> SortcompareintroFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_compare_intro_frame_len(s : SortcompareintroFrame) -> Int { s.size }

pub fn sort_compare_intro_frame_get(s : SortcompareintroFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_compare_intro_frame_set(s : SortcompareintroFrame, i : Int, v : Double) -> SortcompareintroFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_compare_intro_frame_sum(s : SortcompareintroFrame) -> Double { @_common.sum(s.data) }

pub fn sort_compare_intro_frame_mean(s : SortcompareintroFrame) -> Double { @_common.mean(s.data) }

pub fn sort_compare_intro_frame_scale(s : SortcompareintroFrame, f : Double) -> SortcompareintroFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_compare_intro_frame_add(a : SortcompareintroFrame, b : SortcompareintroFrame) -> SortcompareintroFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_compare_intro_frame_copy(s : SortcompareintroFrame) -> SortcompareintroFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_compare_intro_frame_fill(s : SortcompareintroFrame, v : Double) -> SortcompareintroFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_compare_intro_frame_min(s : SortcompareintroFrame) -> Double { @_common.min(s.data) }

pub fn sort_compare_intro_frame_max(s : SortcompareintroFrame) -> Double { @_common.max(s.data) }

pub fn sort_compare_intro_frame_to_string(s : SortcompareintroFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortcompareintroTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_compare_intro_table_make(size : Int) -> SortcompareintroTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_compare_intro_table_len(s : SortcompareintroTable) -> Int { s.size }

pub fn sort_compare_intro_table_get(s : SortcompareintroTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_compare_intro_table_set(s : SortcompareintroTable, i : Int, v : Double) -> SortcompareintroTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_compare_intro_table_sum(s : SortcompareintroTable) -> Double { @_common.sum(s.data) }

pub fn sort_compare_intro_table_mean(s : SortcompareintroTable) -> Double { @_common.mean(s.data) }

pub fn sort_compare_intro_table_scale(s : SortcompareintroTable, f : Double) -> SortcompareintroTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_compare_intro_table_add(a : SortcompareintroTable, b : SortcompareintroTable) -> SortcompareintroTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_compare_intro_table_copy(s : SortcompareintroTable) -> SortcompareintroTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_compare_intro_table_fill(s : SortcompareintroTable, v : Double) -> SortcompareintroTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_compare_intro_table_min(s : SortcompareintroTable) -> Double { @_common.min(s.data) }

pub fn sort_compare_intro_table_max(s : SortcompareintroTable) -> Double { @_common.max(s.data) }

pub fn sort_compare_intro_table_to_string(s : SortcompareintroTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortcompareintroGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_compare_intro_graphn_make(size : Int) -> SortcompareintroGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_compare_intro_graphn_len(s : SortcompareintroGraphN) -> Int { s.size }

pub fn sort_compare_intro_graphn_get(s : SortcompareintroGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_compare_intro_graphn_set(s : SortcompareintroGraphN, i : Int, v : Double) -> SortcompareintroGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_compare_intro_graphn_sum(s : SortcompareintroGraphN) -> Double { @_common.sum(s.data) }

pub fn sort_compare_intro_graphn_mean(s : SortcompareintroGraphN) -> Double { @_common.mean(s.data) }

pub fn sort_compare_intro_graphn_scale(s : SortcompareintroGraphN, f : Double) -> SortcompareintroGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_compare_intro_graphn_add(a : SortcompareintroGraphN, b : SortcompareintroGraphN) -> SortcompareintroGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_compare_intro_graphn_copy(s : SortcompareintroGraphN) -> SortcompareintroGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_compare_intro_graphn_fill(s : SortcompareintroGraphN, v : Double) -> SortcompareintroGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_compare_intro_graphn_min(s : SortcompareintroGraphN) -> Double { @_common.min(s.data) }

pub fn sort_compare_intro_graphn_max(s : SortcompareintroGraphN) -> Double { @_common.max(s.data) }

pub fn sort_compare_intro_graphn_to_string(s : SortcompareintroGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortcompareintroNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_compare_intro_node_make(size : Int) -> SortcompareintroNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_compare_intro_node_len(s : SortcompareintroNode) -> Int { s.size }

pub fn sort_compare_intro_node_get(s : SortcompareintroNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_compare_intro_node_set(s : SortcompareintroNode, i : Int, v : Double) -> SortcompareintroNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_compare_intro_node_sum(s : SortcompareintroNode) -> Double { @_common.sum(s.data) }

pub fn sort_compare_intro_node_mean(s : SortcompareintroNode) -> Double { @_common.mean(s.data) }

pub fn sort_compare_intro_node_scale(s : SortcompareintroNode, f : Double) -> SortcompareintroNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_compare_intro_node_add(a : SortcompareintroNode, b : SortcompareintroNode) -> SortcompareintroNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_compare_intro_node_copy(s : SortcompareintroNode) -> SortcompareintroNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_compare_intro_node_fill(s : SortcompareintroNode, v : Double) -> SortcompareintroNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_compare_intro_node_min(s : SortcompareintroNode) -> Double { @_common.min(s.data) }

pub fn sort_compare_intro_node_max(s : SortcompareintroNode) -> Double { @_common.max(s.data) }

pub fn sort_compare_intro_node_to_string(s : SortcompareintroNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortcompareintroEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_compare_intro_edge_make(size : Int) -> SortcompareintroEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_compare_intro_edge_len(s : SortcompareintroEdge) -> Int { s.size }

pub fn sort_compare_intro_edge_get(s : SortcompareintroEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_compare_intro_edge_set(s : SortcompareintroEdge, i : Int, v : Double) -> SortcompareintroEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_compare_intro_edge_sum(s : SortcompareintroEdge) -> Double { @_common.sum(s.data) }

pub fn sort_compare_intro_edge_mean(s : SortcompareintroEdge) -> Double { @_common.mean(s.data) }

pub fn sort_compare_intro_edge_scale(s : SortcompareintroEdge, f : Double) -> SortcompareintroEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_compare_intro_edge_add(a : SortcompareintroEdge, b : SortcompareintroEdge) -> SortcompareintroEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_compare_intro_edge_copy(s : SortcompareintroEdge) -> SortcompareintroEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_compare_intro_edge_fill(s : SortcompareintroEdge, v : Double) -> SortcompareintroEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_compare_intro_edge_min(s : SortcompareintroEdge) -> Double { @_common.min(s.data) }

pub fn sort_compare_intro_edge_max(s : SortcompareintroEdge) -> Double { @_common.max(s.data) }

pub fn sort_compare_intro_edge_to_string(s : SortcompareintroEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortcompareintroPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_compare_intro_path_make(size : Int) -> SortcompareintroPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_compare_intro_path_len(s : SortcompareintroPath) -> Int { s.size }

pub fn sort_compare_intro_path_get(s : SortcompareintroPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_compare_intro_path_set(s : SortcompareintroPath, i : Int, v : Double) -> SortcompareintroPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_compare_intro_path_sum(s : SortcompareintroPath) -> Double { @_common.sum(s.data) }

pub fn sort_compare_intro_path_mean(s : SortcompareintroPath) -> Double { @_common.mean(s.data) }

pub fn sort_compare_intro_path_scale(s : SortcompareintroPath, f : Double) -> SortcompareintroPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_compare_intro_path_add(a : SortcompareintroPath, b : SortcompareintroPath) -> SortcompareintroPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_compare_intro_path_copy(s : SortcompareintroPath) -> SortcompareintroPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_compare_intro_path_fill(s : SortcompareintroPath, v : Double) -> SortcompareintroPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_compare_intro_path_min(s : SortcompareintroPath) -> Double { @_common.min(s.data) }

pub fn sort_compare_intro_path_max(s : SortcompareintroPath) -> Double { @_common.max(s.data) }

pub fn sort_compare_intro_path_to_string(s : SortcompareintroPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortcompareintroCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_compare_intro_cluster_make(size : Int) -> SortcompareintroCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_compare_intro_cluster_len(s : SortcompareintroCluster) -> Int { s.size }

pub fn sort_compare_intro_cluster_get(s : SortcompareintroCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_compare_intro_cluster_set(s : SortcompareintroCluster, i : Int, v : Double) -> SortcompareintroCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_compare_intro_cluster_sum(s : SortcompareintroCluster) -> Double { @_common.sum(s.data) }

pub fn sort_compare_intro_cluster_mean(s : SortcompareintroCluster) -> Double { @_common.mean(s.data) }

pub fn sort_compare_intro_cluster_scale(s : SortcompareintroCluster, f : Double) -> SortcompareintroCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_compare_intro_cluster_add(a : SortcompareintroCluster, b : SortcompareintroCluster) -> SortcompareintroCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_compare_intro_cluster_copy(s : SortcompareintroCluster) -> SortcompareintroCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_compare_intro_cluster_fill(s : SortcompareintroCluster, v : Double) -> SortcompareintroCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_compare_intro_cluster_min(s : SortcompareintroCluster) -> Double { @_common.min(s.data) }

pub fn sort_compare_intro_cluster_max(s : SortcompareintroCluster) -> Double { @_common.max(s.data) }

pub fn sort_compare_intro_cluster_to_string(s : SortcompareintroCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortcompareintroModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_compare_intro_model_make(size : Int) -> SortcompareintroModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_compare_intro_model_len(s : SortcompareintroModel) -> Int { s.size }

pub fn sort_compare_intro_model_get(s : SortcompareintroModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_compare_intro_model_set(s : SortcompareintroModel, i : Int, v : Double) -> SortcompareintroModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_compare_intro_model_sum(s : SortcompareintroModel) -> Double { @_common.sum(s.data) }

pub fn sort_compare_intro_model_mean(s : SortcompareintroModel) -> Double { @_common.mean(s.data) }

pub fn sort_compare_intro_model_scale(s : SortcompareintroModel, f : Double) -> SortcompareintroModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_compare_intro_model_add(a : SortcompareintroModel, b : SortcompareintroModel) -> SortcompareintroModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_compare_intro_model_copy(s : SortcompareintroModel) -> SortcompareintroModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_compare_intro_model_fill(s : SortcompareintroModel, v : Double) -> SortcompareintroModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_compare_intro_model_min(s : SortcompareintroModel) -> Double { @_common.min(s.data) }

pub fn sort_compare_intro_model_max(s : SortcompareintroModel) -> Double { @_common.max(s.data) }

pub fn sort_compare_intro_model_to_string(s : SortcompareintroModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortcompareintroLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_compare_intro_layer_make(size : Int) -> SortcompareintroLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_compare_intro_layer_len(s : SortcompareintroLayer) -> Int { s.size }

pub fn sort_compare_intro_layer_get(s : SortcompareintroLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_compare_intro_layer_set(s : SortcompareintroLayer, i : Int, v : Double) -> SortcompareintroLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_compare_intro_layer_sum(s : SortcompareintroLayer) -> Double { @_common.sum(s.data) }

pub fn sort_compare_intro_layer_mean(s : SortcompareintroLayer) -> Double { @_common.mean(s.data) }

pub fn sort_compare_intro_layer_scale(s : SortcompareintroLayer, f : Double) -> SortcompareintroLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_compare_intro_layer_add(a : SortcompareintroLayer, b : SortcompareintroLayer) -> SortcompareintroLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_compare_intro_layer_copy(s : SortcompareintroLayer) -> SortcompareintroLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_compare_intro_layer_fill(s : SortcompareintroLayer, v : Double) -> SortcompareintroLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_compare_intro_layer_min(s : SortcompareintroLayer) -> Double { @_common.min(s.data) }

pub fn sort_compare_intro_layer_max(s : SortcompareintroLayer) -> Double { @_common.max(s.data) }

pub fn sort_compare_intro_layer_to_string(s : SortcompareintroLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortcompareintroBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_compare_intro_buffer_make(size : Int) -> SortcompareintroBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_compare_intro_buffer_len(s : SortcompareintroBuffer) -> Int { s.size }

pub fn sort_compare_intro_buffer_get(s : SortcompareintroBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_compare_intro_buffer_set(s : SortcompareintroBuffer, i : Int, v : Double) -> SortcompareintroBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_compare_intro_buffer_sum(s : SortcompareintroBuffer) -> Double { @_common.sum(s.data) }

pub fn sort_compare_intro_buffer_mean(s : SortcompareintroBuffer) -> Double { @_common.mean(s.data) }

pub fn sort_compare_intro_buffer_scale(s : SortcompareintroBuffer, f : Double) -> SortcompareintroBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_compare_intro_buffer_add(a : SortcompareintroBuffer, b : SortcompareintroBuffer) -> SortcompareintroBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_compare_intro_buffer_copy(s : SortcompareintroBuffer) -> SortcompareintroBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_compare_intro_buffer_fill(s : SortcompareintroBuffer, v : Double) -> SortcompareintroBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_compare_intro_buffer_min(s : SortcompareintroBuffer) -> Double { @_common.min(s.data) }

pub fn sort_compare_intro_buffer_max(s : SortcompareintroBuffer) -> Double { @_common.max(s.data) }

pub fn sort_compare_intro_buffer_to_string(s : SortcompareintroBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortcompareintroCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_compare_intro_cursor_make(size : Int) -> SortcompareintroCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_compare_intro_cursor_len(s : SortcompareintroCursor) -> Int { s.size }

pub fn sort_compare_intro_cursor_get(s : SortcompareintroCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_compare_intro_cursor_set(s : SortcompareintroCursor, i : Int, v : Double) -> SortcompareintroCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_compare_intro_cursor_sum(s : SortcompareintroCursor) -> Double { @_common.sum(s.data) }

pub fn sort_compare_intro_cursor_mean(s : SortcompareintroCursor) -> Double { @_common.mean(s.data) }

pub fn sort_compare_intro_cursor_scale(s : SortcompareintroCursor, f : Double) -> SortcompareintroCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_compare_intro_cursor_add(a : SortcompareintroCursor, b : SortcompareintroCursor) -> SortcompareintroCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_compare_intro_cursor_copy(s : SortcompareintroCursor) -> SortcompareintroCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_compare_intro_cursor_fill(s : SortcompareintroCursor, v : Double) -> SortcompareintroCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_compare_intro_cursor_min(s : SortcompareintroCursor) -> Double { @_common.min(s.data) }

pub fn sort_compare_intro_cursor_max(s : SortcompareintroCursor) -> Double { @_common.max(s.data) }

pub fn sort_compare_intro_cursor_to_string(s : SortcompareintroCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortcompareintroView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_compare_intro_view_make(size : Int) -> SortcompareintroView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_compare_intro_view_len(s : SortcompareintroView) -> Int { s.size }

pub fn sort_compare_intro_view_get(s : SortcompareintroView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_compare_intro_view_set(s : SortcompareintroView, i : Int, v : Double) -> SortcompareintroView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_compare_intro_view_sum(s : SortcompareintroView) -> Double { @_common.sum(s.data) }

pub fn sort_compare_intro_view_mean(s : SortcompareintroView) -> Double { @_common.mean(s.data) }

pub fn sort_compare_intro_view_scale(s : SortcompareintroView, f : Double) -> SortcompareintroView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_compare_intro_view_add(a : SortcompareintroView, b : SortcompareintroView) -> SortcompareintroView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_compare_intro_view_copy(s : SortcompareintroView) -> SortcompareintroView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_compare_intro_view_fill(s : SortcompareintroView, v : Double) -> SortcompareintroView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_compare_intro_view_min(s : SortcompareintroView) -> Double { @_common.min(s.data) }

pub fn sort_compare_intro_view_max(s : SortcompareintroView) -> Double { @_common.max(s.data) }

pub fn sort_compare_intro_view_to_string(s : SortcompareintroView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortcompareintroRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_compare_intro_range_make(size : Int) -> SortcompareintroRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_compare_intro_range_len(s : SortcompareintroRange) -> Int { s.size }

pub fn sort_compare_intro_range_get(s : SortcompareintroRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_compare_intro_range_set(s : SortcompareintroRange, i : Int, v : Double) -> SortcompareintroRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_compare_intro_range_sum(s : SortcompareintroRange) -> Double { @_common.sum(s.data) }

pub fn sort_compare_intro_range_mean(s : SortcompareintroRange) -> Double { @_common.mean(s.data) }

pub fn sort_compare_intro_range_scale(s : SortcompareintroRange, f : Double) -> SortcompareintroRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_compare_intro_range_add(a : SortcompareintroRange, b : SortcompareintroRange) -> SortcompareintroRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_compare_intro_range_copy(s : SortcompareintroRange) -> SortcompareintroRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_compare_intro_range_fill(s : SortcompareintroRange, v : Double) -> SortcompareintroRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_compare_intro_range_min(s : SortcompareintroRange) -> Double { @_common.min(s.data) }

pub fn sort_compare_intro_range_max(s : SortcompareintroRange) -> Double { @_common.max(s.data) }

pub fn sort_compare_intro_range_to_string(s : SortcompareintroRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortcompareintroSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_compare_intro_slice_make(size : Int) -> SortcompareintroSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_compare_intro_slice_len(s : SortcompareintroSlice) -> Int { s.size }

pub fn sort_compare_intro_slice_get(s : SortcompareintroSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_compare_intro_slice_set(s : SortcompareintroSlice, i : Int, v : Double) -> SortcompareintroSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_compare_intro_slice_sum(s : SortcompareintroSlice) -> Double { @_common.sum(s.data) }

pub fn sort_compare_intro_slice_mean(s : SortcompareintroSlice) -> Double { @_common.mean(s.data) }

pub fn sort_compare_intro_slice_scale(s : SortcompareintroSlice, f : Double) -> SortcompareintroSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_compare_intro_slice_add(a : SortcompareintroSlice, b : SortcompareintroSlice) -> SortcompareintroSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_compare_intro_slice_copy(s : SortcompareintroSlice) -> SortcompareintroSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_compare_intro_slice_fill(s : SortcompareintroSlice, v : Double) -> SortcompareintroSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_compare_intro_slice_min(s : SortcompareintroSlice) -> Double { @_common.min(s.data) }

pub fn sort_compare_intro_slice_max(s : SortcompareintroSlice) -> Double { @_common.max(s.data) }

pub fn sort_compare_intro_slice_to_string(s : SortcompareintroSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

