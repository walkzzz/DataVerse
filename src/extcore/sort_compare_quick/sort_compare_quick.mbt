///===
/// extcore/sort_compare_quick

pub(all) struct SortcomparequickPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn sort_compare_quick_make_point(x : Double, y : Double) -> SortcomparequickPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn sort_compare_quick_make_point3(x : Double, y : Double, z : Double) -> SortcomparequickPoint {
  { x, y, z, label: 0 }
}

pub fn SortcomparequickPoint::x(self : SortcomparequickPoint) -> Double { self.x }

pub fn SortcomparequickPoint::y(self : SortcomparequickPoint) -> Double { self.y }

pub fn SortcomparequickPoint::z(self : SortcomparequickPoint) -> Double { self.z }

pub fn SortcomparequickPoint::label(self : SortcomparequickPoint) -> Int { self.label }

pub fn SortcomparequickPoint::dist(self : SortcomparequickPoint, other : SortcomparequickPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn SortcomparequickPoint::add(self : SortcomparequickPoint, other : SortcomparequickPoint) -> SortcomparequickPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn SortcomparequickPoint::sub(self : SortcomparequickPoint, other : SortcomparequickPoint) -> SortcomparequickPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn SortcomparequickPoint::scale(self : SortcomparequickPoint, s : Double) -> SortcomparequickPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn SortcomparequickPoint::dot(self : SortcomparequickPoint, other : SortcomparequickPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn SortcomparequickPoint::cross(self : SortcomparequickPoint, other : SortcomparequickPoint) -> SortcomparequickPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn SortcomparequickPoint::norm(self : SortcomparequickPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn SortcomparequickPoint::normalize(self : SortcomparequickPoint) -> SortcomparequickPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn SortcomparequickPoint::negate(self : SortcomparequickPoint) -> SortcomparequickPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn SortcomparequickPoint::mid(self : SortcomparequickPoint, other : SortcomparequickPoint) -> SortcomparequickPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn SortcomparequickPoint::lerp(self : SortcomparequickPoint, other : SortcomparequickPoint, t : Double) -> SortcomparequickPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn SortcomparequickPoint::to_string(self : SortcomparequickPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct SortcomparequickSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn sort_compare_quick_make_series(vals : Array[Double], name : String) -> SortcomparequickSeries {
  { vals, name, meta: 0 }
}

pub fn SortcomparequickSeries::len(self : SortcomparequickSeries) -> Int { self.vals.length() }

pub fn SortcomparequickSeries::sum(self : SortcomparequickSeries) -> Double { @_common.sum(self.vals) }

pub fn SortcomparequickSeries::mean(self : SortcomparequickSeries) -> Double { @_common.mean(self.vals) }

pub fn SortcomparequickSeries::min(self : SortcomparequickSeries) -> Double { @_common.min(self.vals) }

pub fn SortcomparequickSeries::max(self : SortcomparequickSeries) -> Double { @_common.max(self.vals) }

pub fn SortcomparequickSeries::range(self : SortcomparequickSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn SortcomparequickSeries::variance(self : SortcomparequickSeries) -> Double { @_common.variance(self.vals) }

pub fn SortcomparequickSeries::std(self : SortcomparequickSeries) -> Double { @_common.std(self.vals) }

pub fn SortcomparequickSeries::median(self : SortcomparequickSeries) -> Double { @_common.median(self.vals) }

pub fn SortcomparequickSeries::scale(self : SortcomparequickSeries, f : Double) -> SortcomparequickSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn SortcomparequickSeries::add(self : SortcomparequickSeries, other : SortcomparequickSeries) -> SortcomparequickSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn SortcomparequickSeries::sub(self : SortcomparequickSeries, other : SortcomparequickSeries) -> SortcomparequickSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn SortcomparequickSeries::normalize(self : SortcomparequickSeries) -> SortcomparequickSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn SortcomparequickSeries::cumsum(self : SortcomparequickSeries) -> SortcomparequickSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn SortcomparequickSeries::to_string(self : SortcomparequickSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct SortcomparequickMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn sort_compare_quick_make_matrix(rows : Int, cols : Int, val : Double) -> SortcomparequickMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn sort_compare_quick_matrix_identity(n : Int) -> SortcomparequickMatrix {
  let m = sort_compare_quick_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn SortcomparequickMatrix::get(self : SortcomparequickMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn SortcomparequickMatrix::transpose(self : SortcomparequickMatrix) -> SortcomparequickMatrix {
  let result = sort_compare_quick_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn SortcomparequickMatrix::add(self : SortcomparequickMatrix, other : SortcomparequickMatrix) -> SortcomparequickMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = sort_compare_quick_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn SortcomparequickMatrix::scale(self : SortcomparequickMatrix, s : Double) -> SortcomparequickMatrix {
  let result = sort_compare_quick_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn SortcomparequickMatrix::multiply(self : SortcomparequickMatrix, other : SortcomparequickMatrix) -> SortcomparequickMatrix {
  if self.cols != other.rows { return sort_compare_quick_make_matrix(self.rows, other.cols, 0.0) }
  let result = sort_compare_quick_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn SortcomparequickMatrix::trace(self : SortcomparequickMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn SortcomparequickMatrix::det(self : SortcomparequickMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn SortcomparequickMatrix::norm(self : SortcomparequickMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn SortcomparequickMatrix::to_string(self : SortcomparequickMatrix) -> String {
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

pub(all) struct SortcomparequickVector {
  comps : Array[Double]
  dim : Int
}

pub fn sort_compare_quick_make_vector(comps : Array[Double]) -> SortcomparequickVector {
  { comps, dim: comps.length() }
}

pub fn sort_compare_quick_vector_zero(dim : Int) -> SortcomparequickVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn SortcomparequickVector::add(self : SortcomparequickVector, other : SortcomparequickVector) -> SortcomparequickVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn SortcomparequickVector::sub(self : SortcomparequickVector, other : SortcomparequickVector) -> SortcomparequickVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn SortcomparequickVector::scale(self : SortcomparequickVector, s : Double) -> SortcomparequickVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn SortcomparequickVector::dot(self : SortcomparequickVector, other : SortcomparequickVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn SortcomparequickVector::norm(self : SortcomparequickVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn SortcomparequickVector::normalize(self : SortcomparequickVector) -> SortcomparequickVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn SortcomparequickVector::dist(self : SortcomparequickVector, other : SortcomparequickVector) -> Double {
  self.sub(other).norm()
}

pub fn SortcomparequickVector::to_string(self : SortcomparequickVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn sort_compare_quick_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn sort_compare_quick_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn sort_compare_quick_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn sort_compare_quick_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn sort_compare_quick_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn sort_compare_quick_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn sort_compare_quick_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn sort_compare_quick_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn sort_compare_quick_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn sort_compare_quick_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn sort_compare_quick_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn sort_compare_quick_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn sort_compare_quick_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn sort_compare_quick_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn sort_compare_quick_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn sort_compare_quick_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn sort_compare_quick_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn sort_compare_quick_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn sort_compare_quick_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn sort_compare_quick_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn sort_compare_quick_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn sort_compare_quick_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn sort_compare_quick_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn sort_compare_quick_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn sort_compare_quick_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn sort_compare_quick_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn sort_compare_quick_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn sort_compare_quick_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn sort_compare_quick_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct SortcomparequickFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_compare_quick_frame_make(size : Int) -> SortcomparequickFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_compare_quick_frame_len(s : SortcomparequickFrame) -> Int { s.size }

pub fn sort_compare_quick_frame_get(s : SortcomparequickFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_compare_quick_frame_set(s : SortcomparequickFrame, i : Int, v : Double) -> SortcomparequickFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_compare_quick_frame_sum(s : SortcomparequickFrame) -> Double { @_common.sum(s.data) }

pub fn sort_compare_quick_frame_mean(s : SortcomparequickFrame) -> Double { @_common.mean(s.data) }

pub fn sort_compare_quick_frame_scale(s : SortcomparequickFrame, f : Double) -> SortcomparequickFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_compare_quick_frame_add(a : SortcomparequickFrame, b : SortcomparequickFrame) -> SortcomparequickFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_compare_quick_frame_copy(s : SortcomparequickFrame) -> SortcomparequickFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_compare_quick_frame_fill(s : SortcomparequickFrame, v : Double) -> SortcomparequickFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_compare_quick_frame_min(s : SortcomparequickFrame) -> Double { @_common.min(s.data) }

pub fn sort_compare_quick_frame_max(s : SortcomparequickFrame) -> Double { @_common.max(s.data) }

pub fn sort_compare_quick_frame_to_string(s : SortcomparequickFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortcomparequickTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_compare_quick_table_make(size : Int) -> SortcomparequickTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_compare_quick_table_len(s : SortcomparequickTable) -> Int { s.size }

pub fn sort_compare_quick_table_get(s : SortcomparequickTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_compare_quick_table_set(s : SortcomparequickTable, i : Int, v : Double) -> SortcomparequickTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_compare_quick_table_sum(s : SortcomparequickTable) -> Double { @_common.sum(s.data) }

pub fn sort_compare_quick_table_mean(s : SortcomparequickTable) -> Double { @_common.mean(s.data) }

pub fn sort_compare_quick_table_scale(s : SortcomparequickTable, f : Double) -> SortcomparequickTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_compare_quick_table_add(a : SortcomparequickTable, b : SortcomparequickTable) -> SortcomparequickTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_compare_quick_table_copy(s : SortcomparequickTable) -> SortcomparequickTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_compare_quick_table_fill(s : SortcomparequickTable, v : Double) -> SortcomparequickTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_compare_quick_table_min(s : SortcomparequickTable) -> Double { @_common.min(s.data) }

pub fn sort_compare_quick_table_max(s : SortcomparequickTable) -> Double { @_common.max(s.data) }

pub fn sort_compare_quick_table_to_string(s : SortcomparequickTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortcomparequickGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_compare_quick_graphn_make(size : Int) -> SortcomparequickGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_compare_quick_graphn_len(s : SortcomparequickGraphN) -> Int { s.size }

pub fn sort_compare_quick_graphn_get(s : SortcomparequickGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_compare_quick_graphn_set(s : SortcomparequickGraphN, i : Int, v : Double) -> SortcomparequickGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_compare_quick_graphn_sum(s : SortcomparequickGraphN) -> Double { @_common.sum(s.data) }

pub fn sort_compare_quick_graphn_mean(s : SortcomparequickGraphN) -> Double { @_common.mean(s.data) }

pub fn sort_compare_quick_graphn_scale(s : SortcomparequickGraphN, f : Double) -> SortcomparequickGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_compare_quick_graphn_add(a : SortcomparequickGraphN, b : SortcomparequickGraphN) -> SortcomparequickGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_compare_quick_graphn_copy(s : SortcomparequickGraphN) -> SortcomparequickGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_compare_quick_graphn_fill(s : SortcomparequickGraphN, v : Double) -> SortcomparequickGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_compare_quick_graphn_min(s : SortcomparequickGraphN) -> Double { @_common.min(s.data) }

pub fn sort_compare_quick_graphn_max(s : SortcomparequickGraphN) -> Double { @_common.max(s.data) }

pub fn sort_compare_quick_graphn_to_string(s : SortcomparequickGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortcomparequickNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_compare_quick_node_make(size : Int) -> SortcomparequickNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_compare_quick_node_len(s : SortcomparequickNode) -> Int { s.size }

pub fn sort_compare_quick_node_get(s : SortcomparequickNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_compare_quick_node_set(s : SortcomparequickNode, i : Int, v : Double) -> SortcomparequickNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_compare_quick_node_sum(s : SortcomparequickNode) -> Double { @_common.sum(s.data) }

pub fn sort_compare_quick_node_mean(s : SortcomparequickNode) -> Double { @_common.mean(s.data) }

pub fn sort_compare_quick_node_scale(s : SortcomparequickNode, f : Double) -> SortcomparequickNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_compare_quick_node_add(a : SortcomparequickNode, b : SortcomparequickNode) -> SortcomparequickNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_compare_quick_node_copy(s : SortcomparequickNode) -> SortcomparequickNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_compare_quick_node_fill(s : SortcomparequickNode, v : Double) -> SortcomparequickNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_compare_quick_node_min(s : SortcomparequickNode) -> Double { @_common.min(s.data) }

pub fn sort_compare_quick_node_max(s : SortcomparequickNode) -> Double { @_common.max(s.data) }

pub fn sort_compare_quick_node_to_string(s : SortcomparequickNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortcomparequickEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_compare_quick_edge_make(size : Int) -> SortcomparequickEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_compare_quick_edge_len(s : SortcomparequickEdge) -> Int { s.size }

pub fn sort_compare_quick_edge_get(s : SortcomparequickEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_compare_quick_edge_set(s : SortcomparequickEdge, i : Int, v : Double) -> SortcomparequickEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_compare_quick_edge_sum(s : SortcomparequickEdge) -> Double { @_common.sum(s.data) }

pub fn sort_compare_quick_edge_mean(s : SortcomparequickEdge) -> Double { @_common.mean(s.data) }

pub fn sort_compare_quick_edge_scale(s : SortcomparequickEdge, f : Double) -> SortcomparequickEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_compare_quick_edge_add(a : SortcomparequickEdge, b : SortcomparequickEdge) -> SortcomparequickEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_compare_quick_edge_copy(s : SortcomparequickEdge) -> SortcomparequickEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_compare_quick_edge_fill(s : SortcomparequickEdge, v : Double) -> SortcomparequickEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_compare_quick_edge_min(s : SortcomparequickEdge) -> Double { @_common.min(s.data) }

pub fn sort_compare_quick_edge_max(s : SortcomparequickEdge) -> Double { @_common.max(s.data) }

pub fn sort_compare_quick_edge_to_string(s : SortcomparequickEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortcomparequickPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_compare_quick_path_make(size : Int) -> SortcomparequickPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_compare_quick_path_len(s : SortcomparequickPath) -> Int { s.size }

pub fn sort_compare_quick_path_get(s : SortcomparequickPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_compare_quick_path_set(s : SortcomparequickPath, i : Int, v : Double) -> SortcomparequickPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_compare_quick_path_sum(s : SortcomparequickPath) -> Double { @_common.sum(s.data) }

pub fn sort_compare_quick_path_mean(s : SortcomparequickPath) -> Double { @_common.mean(s.data) }

pub fn sort_compare_quick_path_scale(s : SortcomparequickPath, f : Double) -> SortcomparequickPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_compare_quick_path_add(a : SortcomparequickPath, b : SortcomparequickPath) -> SortcomparequickPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_compare_quick_path_copy(s : SortcomparequickPath) -> SortcomparequickPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_compare_quick_path_fill(s : SortcomparequickPath, v : Double) -> SortcomparequickPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_compare_quick_path_min(s : SortcomparequickPath) -> Double { @_common.min(s.data) }

pub fn sort_compare_quick_path_max(s : SortcomparequickPath) -> Double { @_common.max(s.data) }

pub fn sort_compare_quick_path_to_string(s : SortcomparequickPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortcomparequickCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_compare_quick_cluster_make(size : Int) -> SortcomparequickCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_compare_quick_cluster_len(s : SortcomparequickCluster) -> Int { s.size }

pub fn sort_compare_quick_cluster_get(s : SortcomparequickCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_compare_quick_cluster_set(s : SortcomparequickCluster, i : Int, v : Double) -> SortcomparequickCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_compare_quick_cluster_sum(s : SortcomparequickCluster) -> Double { @_common.sum(s.data) }

pub fn sort_compare_quick_cluster_mean(s : SortcomparequickCluster) -> Double { @_common.mean(s.data) }

pub fn sort_compare_quick_cluster_scale(s : SortcomparequickCluster, f : Double) -> SortcomparequickCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_compare_quick_cluster_add(a : SortcomparequickCluster, b : SortcomparequickCluster) -> SortcomparequickCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_compare_quick_cluster_copy(s : SortcomparequickCluster) -> SortcomparequickCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_compare_quick_cluster_fill(s : SortcomparequickCluster, v : Double) -> SortcomparequickCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_compare_quick_cluster_min(s : SortcomparequickCluster) -> Double { @_common.min(s.data) }

pub fn sort_compare_quick_cluster_max(s : SortcomparequickCluster) -> Double { @_common.max(s.data) }

pub fn sort_compare_quick_cluster_to_string(s : SortcomparequickCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortcomparequickModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_compare_quick_model_make(size : Int) -> SortcomparequickModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_compare_quick_model_len(s : SortcomparequickModel) -> Int { s.size }

pub fn sort_compare_quick_model_get(s : SortcomparequickModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_compare_quick_model_set(s : SortcomparequickModel, i : Int, v : Double) -> SortcomparequickModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_compare_quick_model_sum(s : SortcomparequickModel) -> Double { @_common.sum(s.data) }

pub fn sort_compare_quick_model_mean(s : SortcomparequickModel) -> Double { @_common.mean(s.data) }

pub fn sort_compare_quick_model_scale(s : SortcomparequickModel, f : Double) -> SortcomparequickModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_compare_quick_model_add(a : SortcomparequickModel, b : SortcomparequickModel) -> SortcomparequickModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_compare_quick_model_copy(s : SortcomparequickModel) -> SortcomparequickModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_compare_quick_model_fill(s : SortcomparequickModel, v : Double) -> SortcomparequickModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_compare_quick_model_min(s : SortcomparequickModel) -> Double { @_common.min(s.data) }

pub fn sort_compare_quick_model_max(s : SortcomparequickModel) -> Double { @_common.max(s.data) }

pub fn sort_compare_quick_model_to_string(s : SortcomparequickModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortcomparequickLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_compare_quick_layer_make(size : Int) -> SortcomparequickLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_compare_quick_layer_len(s : SortcomparequickLayer) -> Int { s.size }

pub fn sort_compare_quick_layer_get(s : SortcomparequickLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_compare_quick_layer_set(s : SortcomparequickLayer, i : Int, v : Double) -> SortcomparequickLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_compare_quick_layer_sum(s : SortcomparequickLayer) -> Double { @_common.sum(s.data) }

pub fn sort_compare_quick_layer_mean(s : SortcomparequickLayer) -> Double { @_common.mean(s.data) }

pub fn sort_compare_quick_layer_scale(s : SortcomparequickLayer, f : Double) -> SortcomparequickLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_compare_quick_layer_add(a : SortcomparequickLayer, b : SortcomparequickLayer) -> SortcomparequickLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_compare_quick_layer_copy(s : SortcomparequickLayer) -> SortcomparequickLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_compare_quick_layer_fill(s : SortcomparequickLayer, v : Double) -> SortcomparequickLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_compare_quick_layer_min(s : SortcomparequickLayer) -> Double { @_common.min(s.data) }

pub fn sort_compare_quick_layer_max(s : SortcomparequickLayer) -> Double { @_common.max(s.data) }

pub fn sort_compare_quick_layer_to_string(s : SortcomparequickLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortcomparequickBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_compare_quick_buffer_make(size : Int) -> SortcomparequickBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_compare_quick_buffer_len(s : SortcomparequickBuffer) -> Int { s.size }

pub fn sort_compare_quick_buffer_get(s : SortcomparequickBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_compare_quick_buffer_set(s : SortcomparequickBuffer, i : Int, v : Double) -> SortcomparequickBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_compare_quick_buffer_sum(s : SortcomparequickBuffer) -> Double { @_common.sum(s.data) }

pub fn sort_compare_quick_buffer_mean(s : SortcomparequickBuffer) -> Double { @_common.mean(s.data) }

pub fn sort_compare_quick_buffer_scale(s : SortcomparequickBuffer, f : Double) -> SortcomparequickBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_compare_quick_buffer_add(a : SortcomparequickBuffer, b : SortcomparequickBuffer) -> SortcomparequickBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_compare_quick_buffer_copy(s : SortcomparequickBuffer) -> SortcomparequickBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_compare_quick_buffer_fill(s : SortcomparequickBuffer, v : Double) -> SortcomparequickBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_compare_quick_buffer_min(s : SortcomparequickBuffer) -> Double { @_common.min(s.data) }

pub fn sort_compare_quick_buffer_max(s : SortcomparequickBuffer) -> Double { @_common.max(s.data) }

pub fn sort_compare_quick_buffer_to_string(s : SortcomparequickBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortcomparequickCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_compare_quick_cursor_make(size : Int) -> SortcomparequickCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_compare_quick_cursor_len(s : SortcomparequickCursor) -> Int { s.size }

pub fn sort_compare_quick_cursor_get(s : SortcomparequickCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_compare_quick_cursor_set(s : SortcomparequickCursor, i : Int, v : Double) -> SortcomparequickCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_compare_quick_cursor_sum(s : SortcomparequickCursor) -> Double { @_common.sum(s.data) }

pub fn sort_compare_quick_cursor_mean(s : SortcomparequickCursor) -> Double { @_common.mean(s.data) }

pub fn sort_compare_quick_cursor_scale(s : SortcomparequickCursor, f : Double) -> SortcomparequickCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_compare_quick_cursor_add(a : SortcomparequickCursor, b : SortcomparequickCursor) -> SortcomparequickCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_compare_quick_cursor_copy(s : SortcomparequickCursor) -> SortcomparequickCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_compare_quick_cursor_fill(s : SortcomparequickCursor, v : Double) -> SortcomparequickCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_compare_quick_cursor_min(s : SortcomparequickCursor) -> Double { @_common.min(s.data) }

pub fn sort_compare_quick_cursor_max(s : SortcomparequickCursor) -> Double { @_common.max(s.data) }

pub fn sort_compare_quick_cursor_to_string(s : SortcomparequickCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortcomparequickView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_compare_quick_view_make(size : Int) -> SortcomparequickView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_compare_quick_view_len(s : SortcomparequickView) -> Int { s.size }

pub fn sort_compare_quick_view_get(s : SortcomparequickView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_compare_quick_view_set(s : SortcomparequickView, i : Int, v : Double) -> SortcomparequickView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_compare_quick_view_sum(s : SortcomparequickView) -> Double { @_common.sum(s.data) }

pub fn sort_compare_quick_view_mean(s : SortcomparequickView) -> Double { @_common.mean(s.data) }

pub fn sort_compare_quick_view_scale(s : SortcomparequickView, f : Double) -> SortcomparequickView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_compare_quick_view_add(a : SortcomparequickView, b : SortcomparequickView) -> SortcomparequickView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_compare_quick_view_copy(s : SortcomparequickView) -> SortcomparequickView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_compare_quick_view_fill(s : SortcomparequickView, v : Double) -> SortcomparequickView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_compare_quick_view_min(s : SortcomparequickView) -> Double { @_common.min(s.data) }

pub fn sort_compare_quick_view_max(s : SortcomparequickView) -> Double { @_common.max(s.data) }

pub fn sort_compare_quick_view_to_string(s : SortcomparequickView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortcomparequickRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_compare_quick_range_make(size : Int) -> SortcomparequickRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_compare_quick_range_len(s : SortcomparequickRange) -> Int { s.size }

pub fn sort_compare_quick_range_get(s : SortcomparequickRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_compare_quick_range_set(s : SortcomparequickRange, i : Int, v : Double) -> SortcomparequickRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_compare_quick_range_sum(s : SortcomparequickRange) -> Double { @_common.sum(s.data) }

pub fn sort_compare_quick_range_mean(s : SortcomparequickRange) -> Double { @_common.mean(s.data) }

pub fn sort_compare_quick_range_scale(s : SortcomparequickRange, f : Double) -> SortcomparequickRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_compare_quick_range_add(a : SortcomparequickRange, b : SortcomparequickRange) -> SortcomparequickRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_compare_quick_range_copy(s : SortcomparequickRange) -> SortcomparequickRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_compare_quick_range_fill(s : SortcomparequickRange, v : Double) -> SortcomparequickRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_compare_quick_range_min(s : SortcomparequickRange) -> Double { @_common.min(s.data) }

pub fn sort_compare_quick_range_max(s : SortcomparequickRange) -> Double { @_common.max(s.data) }

pub fn sort_compare_quick_range_to_string(s : SortcomparequickRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortcomparequickSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_compare_quick_slice_make(size : Int) -> SortcomparequickSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_compare_quick_slice_len(s : SortcomparequickSlice) -> Int { s.size }

pub fn sort_compare_quick_slice_get(s : SortcomparequickSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_compare_quick_slice_set(s : SortcomparequickSlice, i : Int, v : Double) -> SortcomparequickSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_compare_quick_slice_sum(s : SortcomparequickSlice) -> Double { @_common.sum(s.data) }

pub fn sort_compare_quick_slice_mean(s : SortcomparequickSlice) -> Double { @_common.mean(s.data) }

pub fn sort_compare_quick_slice_scale(s : SortcomparequickSlice, f : Double) -> SortcomparequickSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_compare_quick_slice_add(a : SortcomparequickSlice, b : SortcomparequickSlice) -> SortcomparequickSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_compare_quick_slice_copy(s : SortcomparequickSlice) -> SortcomparequickSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_compare_quick_slice_fill(s : SortcomparequickSlice, v : Double) -> SortcomparequickSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_compare_quick_slice_min(s : SortcomparequickSlice) -> Double { @_common.min(s.data) }

pub fn sort_compare_quick_slice_max(s : SortcomparequickSlice) -> Double { @_common.max(s.data) }

pub fn sort_compare_quick_slice_to_string(s : SortcomparequickSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

