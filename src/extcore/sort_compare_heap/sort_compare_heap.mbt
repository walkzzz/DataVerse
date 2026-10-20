///===
/// extcore/sort_compare_heap

pub(all) struct SortcompareheapPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn sort_compare_heap_make_point(x : Double, y : Double) -> SortcompareheapPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn sort_compare_heap_make_point3(x : Double, y : Double, z : Double) -> SortcompareheapPoint {
  { x, y, z, label: 0 }
}

pub fn SortcompareheapPoint::x(self : SortcompareheapPoint) -> Double { self.x }

pub fn SortcompareheapPoint::y(self : SortcompareheapPoint) -> Double { self.y }

pub fn SortcompareheapPoint::z(self : SortcompareheapPoint) -> Double { self.z }

pub fn SortcompareheapPoint::label(self : SortcompareheapPoint) -> Int { self.label }

pub fn SortcompareheapPoint::dist(self : SortcompareheapPoint, other : SortcompareheapPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn SortcompareheapPoint::add(self : SortcompareheapPoint, other : SortcompareheapPoint) -> SortcompareheapPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn SortcompareheapPoint::sub(self : SortcompareheapPoint, other : SortcompareheapPoint) -> SortcompareheapPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn SortcompareheapPoint::scale(self : SortcompareheapPoint, s : Double) -> SortcompareheapPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn SortcompareheapPoint::dot(self : SortcompareheapPoint, other : SortcompareheapPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn SortcompareheapPoint::cross(self : SortcompareheapPoint, other : SortcompareheapPoint) -> SortcompareheapPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn SortcompareheapPoint::norm(self : SortcompareheapPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn SortcompareheapPoint::normalize(self : SortcompareheapPoint) -> SortcompareheapPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn SortcompareheapPoint::negate(self : SortcompareheapPoint) -> SortcompareheapPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn SortcompareheapPoint::mid(self : SortcompareheapPoint, other : SortcompareheapPoint) -> SortcompareheapPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn SortcompareheapPoint::lerp(self : SortcompareheapPoint, other : SortcompareheapPoint, t : Double) -> SortcompareheapPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn SortcompareheapPoint::to_string(self : SortcompareheapPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct SortcompareheapSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn sort_compare_heap_make_series(vals : Array[Double], name : String) -> SortcompareheapSeries {
  { vals, name, meta: 0 }
}

pub fn SortcompareheapSeries::len(self : SortcompareheapSeries) -> Int { self.vals.length() }

pub fn SortcompareheapSeries::sum(self : SortcompareheapSeries) -> Double { @_common.sum(self.vals) }

pub fn SortcompareheapSeries::mean(self : SortcompareheapSeries) -> Double { @_common.mean(self.vals) }

pub fn SortcompareheapSeries::min(self : SortcompareheapSeries) -> Double { @_common.min(self.vals) }

pub fn SortcompareheapSeries::max(self : SortcompareheapSeries) -> Double { @_common.max(self.vals) }

pub fn SortcompareheapSeries::range(self : SortcompareheapSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn SortcompareheapSeries::variance(self : SortcompareheapSeries) -> Double { @_common.variance(self.vals) }

pub fn SortcompareheapSeries::std(self : SortcompareheapSeries) -> Double { @_common.std(self.vals) }

pub fn SortcompareheapSeries::median(self : SortcompareheapSeries) -> Double { @_common.median(self.vals) }

pub fn SortcompareheapSeries::scale(self : SortcompareheapSeries, f : Double) -> SortcompareheapSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn SortcompareheapSeries::add(self : SortcompareheapSeries, other : SortcompareheapSeries) -> SortcompareheapSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn SortcompareheapSeries::sub(self : SortcompareheapSeries, other : SortcompareheapSeries) -> SortcompareheapSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn SortcompareheapSeries::normalize(self : SortcompareheapSeries) -> SortcompareheapSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn SortcompareheapSeries::cumsum(self : SortcompareheapSeries) -> SortcompareheapSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn SortcompareheapSeries::to_string(self : SortcompareheapSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct SortcompareheapMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn sort_compare_heap_make_matrix(rows : Int, cols : Int, val : Double) -> SortcompareheapMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn sort_compare_heap_matrix_identity(n : Int) -> SortcompareheapMatrix {
  let m = sort_compare_heap_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn SortcompareheapMatrix::get(self : SortcompareheapMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn SortcompareheapMatrix::transpose(self : SortcompareheapMatrix) -> SortcompareheapMatrix {
  let result = sort_compare_heap_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn SortcompareheapMatrix::add(self : SortcompareheapMatrix, other : SortcompareheapMatrix) -> SortcompareheapMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = sort_compare_heap_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn SortcompareheapMatrix::scale(self : SortcompareheapMatrix, s : Double) -> SortcompareheapMatrix {
  let result = sort_compare_heap_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn SortcompareheapMatrix::multiply(self : SortcompareheapMatrix, other : SortcompareheapMatrix) -> SortcompareheapMatrix {
  if self.cols != other.rows { return sort_compare_heap_make_matrix(self.rows, other.cols, 0.0) }
  let result = sort_compare_heap_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn SortcompareheapMatrix::trace(self : SortcompareheapMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn SortcompareheapMatrix::det(self : SortcompareheapMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn SortcompareheapMatrix::norm(self : SortcompareheapMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn SortcompareheapMatrix::to_string(self : SortcompareheapMatrix) -> String {
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

pub(all) struct SortcompareheapVector {
  comps : Array[Double]
  dim : Int
}

pub fn sort_compare_heap_make_vector(comps : Array[Double]) -> SortcompareheapVector {
  { comps, dim: comps.length() }
}

pub fn sort_compare_heap_vector_zero(dim : Int) -> SortcompareheapVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn SortcompareheapVector::add(self : SortcompareheapVector, other : SortcompareheapVector) -> SortcompareheapVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn SortcompareheapVector::sub(self : SortcompareheapVector, other : SortcompareheapVector) -> SortcompareheapVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn SortcompareheapVector::scale(self : SortcompareheapVector, s : Double) -> SortcompareheapVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn SortcompareheapVector::dot(self : SortcompareheapVector, other : SortcompareheapVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn SortcompareheapVector::norm(self : SortcompareheapVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn SortcompareheapVector::normalize(self : SortcompareheapVector) -> SortcompareheapVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn SortcompareheapVector::dist(self : SortcompareheapVector, other : SortcompareheapVector) -> Double {
  self.sub(other).norm()
}

pub fn SortcompareheapVector::to_string(self : SortcompareheapVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn sort_compare_heap_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn sort_compare_heap_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn sort_compare_heap_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn sort_compare_heap_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn sort_compare_heap_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn sort_compare_heap_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn sort_compare_heap_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn sort_compare_heap_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn sort_compare_heap_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn sort_compare_heap_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn sort_compare_heap_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn sort_compare_heap_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn sort_compare_heap_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn sort_compare_heap_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn sort_compare_heap_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn sort_compare_heap_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn sort_compare_heap_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn sort_compare_heap_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn sort_compare_heap_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn sort_compare_heap_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn sort_compare_heap_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn sort_compare_heap_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn sort_compare_heap_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn sort_compare_heap_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn sort_compare_heap_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn sort_compare_heap_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn sort_compare_heap_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn sort_compare_heap_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn sort_compare_heap_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct SortcompareheapFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_compare_heap_frame_make(size : Int) -> SortcompareheapFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_compare_heap_frame_len(s : SortcompareheapFrame) -> Int { s.size }

pub fn sort_compare_heap_frame_get(s : SortcompareheapFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_compare_heap_frame_set(s : SortcompareheapFrame, i : Int, v : Double) -> SortcompareheapFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_compare_heap_frame_sum(s : SortcompareheapFrame) -> Double { @_common.sum(s.data) }

pub fn sort_compare_heap_frame_mean(s : SortcompareheapFrame) -> Double { @_common.mean(s.data) }

pub fn sort_compare_heap_frame_scale(s : SortcompareheapFrame, f : Double) -> SortcompareheapFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_compare_heap_frame_add(a : SortcompareheapFrame, b : SortcompareheapFrame) -> SortcompareheapFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_compare_heap_frame_copy(s : SortcompareheapFrame) -> SortcompareheapFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_compare_heap_frame_fill(s : SortcompareheapFrame, v : Double) -> SortcompareheapFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_compare_heap_frame_min(s : SortcompareheapFrame) -> Double { @_common.min(s.data) }

pub fn sort_compare_heap_frame_max(s : SortcompareheapFrame) -> Double { @_common.max(s.data) }

pub fn sort_compare_heap_frame_to_string(s : SortcompareheapFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortcompareheapTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_compare_heap_table_make(size : Int) -> SortcompareheapTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_compare_heap_table_len(s : SortcompareheapTable) -> Int { s.size }

pub fn sort_compare_heap_table_get(s : SortcompareheapTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_compare_heap_table_set(s : SortcompareheapTable, i : Int, v : Double) -> SortcompareheapTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_compare_heap_table_sum(s : SortcompareheapTable) -> Double { @_common.sum(s.data) }

pub fn sort_compare_heap_table_mean(s : SortcompareheapTable) -> Double { @_common.mean(s.data) }

pub fn sort_compare_heap_table_scale(s : SortcompareheapTable, f : Double) -> SortcompareheapTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_compare_heap_table_add(a : SortcompareheapTable, b : SortcompareheapTable) -> SortcompareheapTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_compare_heap_table_copy(s : SortcompareheapTable) -> SortcompareheapTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_compare_heap_table_fill(s : SortcompareheapTable, v : Double) -> SortcompareheapTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_compare_heap_table_min(s : SortcompareheapTable) -> Double { @_common.min(s.data) }

pub fn sort_compare_heap_table_max(s : SortcompareheapTable) -> Double { @_common.max(s.data) }

pub fn sort_compare_heap_table_to_string(s : SortcompareheapTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortcompareheapGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_compare_heap_graphn_make(size : Int) -> SortcompareheapGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_compare_heap_graphn_len(s : SortcompareheapGraphN) -> Int { s.size }

pub fn sort_compare_heap_graphn_get(s : SortcompareheapGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_compare_heap_graphn_set(s : SortcompareheapGraphN, i : Int, v : Double) -> SortcompareheapGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_compare_heap_graphn_sum(s : SortcompareheapGraphN) -> Double { @_common.sum(s.data) }

pub fn sort_compare_heap_graphn_mean(s : SortcompareheapGraphN) -> Double { @_common.mean(s.data) }

pub fn sort_compare_heap_graphn_scale(s : SortcompareheapGraphN, f : Double) -> SortcompareheapGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_compare_heap_graphn_add(a : SortcompareheapGraphN, b : SortcompareheapGraphN) -> SortcompareheapGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_compare_heap_graphn_copy(s : SortcompareheapGraphN) -> SortcompareheapGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_compare_heap_graphn_fill(s : SortcompareheapGraphN, v : Double) -> SortcompareheapGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_compare_heap_graphn_min(s : SortcompareheapGraphN) -> Double { @_common.min(s.data) }

pub fn sort_compare_heap_graphn_max(s : SortcompareheapGraphN) -> Double { @_common.max(s.data) }

pub fn sort_compare_heap_graphn_to_string(s : SortcompareheapGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortcompareheapNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_compare_heap_node_make(size : Int) -> SortcompareheapNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_compare_heap_node_len(s : SortcompareheapNode) -> Int { s.size }

pub fn sort_compare_heap_node_get(s : SortcompareheapNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_compare_heap_node_set(s : SortcompareheapNode, i : Int, v : Double) -> SortcompareheapNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_compare_heap_node_sum(s : SortcompareheapNode) -> Double { @_common.sum(s.data) }

pub fn sort_compare_heap_node_mean(s : SortcompareheapNode) -> Double { @_common.mean(s.data) }

pub fn sort_compare_heap_node_scale(s : SortcompareheapNode, f : Double) -> SortcompareheapNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_compare_heap_node_add(a : SortcompareheapNode, b : SortcompareheapNode) -> SortcompareheapNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_compare_heap_node_copy(s : SortcompareheapNode) -> SortcompareheapNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_compare_heap_node_fill(s : SortcompareheapNode, v : Double) -> SortcompareheapNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_compare_heap_node_min(s : SortcompareheapNode) -> Double { @_common.min(s.data) }

pub fn sort_compare_heap_node_max(s : SortcompareheapNode) -> Double { @_common.max(s.data) }

pub fn sort_compare_heap_node_to_string(s : SortcompareheapNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortcompareheapEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_compare_heap_edge_make(size : Int) -> SortcompareheapEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_compare_heap_edge_len(s : SortcompareheapEdge) -> Int { s.size }

pub fn sort_compare_heap_edge_get(s : SortcompareheapEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_compare_heap_edge_set(s : SortcompareheapEdge, i : Int, v : Double) -> SortcompareheapEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_compare_heap_edge_sum(s : SortcompareheapEdge) -> Double { @_common.sum(s.data) }

pub fn sort_compare_heap_edge_mean(s : SortcompareheapEdge) -> Double { @_common.mean(s.data) }

pub fn sort_compare_heap_edge_scale(s : SortcompareheapEdge, f : Double) -> SortcompareheapEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_compare_heap_edge_add(a : SortcompareheapEdge, b : SortcompareheapEdge) -> SortcompareheapEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_compare_heap_edge_copy(s : SortcompareheapEdge) -> SortcompareheapEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_compare_heap_edge_fill(s : SortcompareheapEdge, v : Double) -> SortcompareheapEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_compare_heap_edge_min(s : SortcompareheapEdge) -> Double { @_common.min(s.data) }

pub fn sort_compare_heap_edge_max(s : SortcompareheapEdge) -> Double { @_common.max(s.data) }

pub fn sort_compare_heap_edge_to_string(s : SortcompareheapEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortcompareheapPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_compare_heap_path_make(size : Int) -> SortcompareheapPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_compare_heap_path_len(s : SortcompareheapPath) -> Int { s.size }

pub fn sort_compare_heap_path_get(s : SortcompareheapPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_compare_heap_path_set(s : SortcompareheapPath, i : Int, v : Double) -> SortcompareheapPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_compare_heap_path_sum(s : SortcompareheapPath) -> Double { @_common.sum(s.data) }

pub fn sort_compare_heap_path_mean(s : SortcompareheapPath) -> Double { @_common.mean(s.data) }

pub fn sort_compare_heap_path_scale(s : SortcompareheapPath, f : Double) -> SortcompareheapPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_compare_heap_path_add(a : SortcompareheapPath, b : SortcompareheapPath) -> SortcompareheapPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_compare_heap_path_copy(s : SortcompareheapPath) -> SortcompareheapPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_compare_heap_path_fill(s : SortcompareheapPath, v : Double) -> SortcompareheapPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_compare_heap_path_min(s : SortcompareheapPath) -> Double { @_common.min(s.data) }

pub fn sort_compare_heap_path_max(s : SortcompareheapPath) -> Double { @_common.max(s.data) }

pub fn sort_compare_heap_path_to_string(s : SortcompareheapPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortcompareheapCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_compare_heap_cluster_make(size : Int) -> SortcompareheapCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_compare_heap_cluster_len(s : SortcompareheapCluster) -> Int { s.size }

pub fn sort_compare_heap_cluster_get(s : SortcompareheapCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_compare_heap_cluster_set(s : SortcompareheapCluster, i : Int, v : Double) -> SortcompareheapCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_compare_heap_cluster_sum(s : SortcompareheapCluster) -> Double { @_common.sum(s.data) }

pub fn sort_compare_heap_cluster_mean(s : SortcompareheapCluster) -> Double { @_common.mean(s.data) }

pub fn sort_compare_heap_cluster_scale(s : SortcompareheapCluster, f : Double) -> SortcompareheapCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_compare_heap_cluster_add(a : SortcompareheapCluster, b : SortcompareheapCluster) -> SortcompareheapCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_compare_heap_cluster_copy(s : SortcompareheapCluster) -> SortcompareheapCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_compare_heap_cluster_fill(s : SortcompareheapCluster, v : Double) -> SortcompareheapCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_compare_heap_cluster_min(s : SortcompareheapCluster) -> Double { @_common.min(s.data) }

pub fn sort_compare_heap_cluster_max(s : SortcompareheapCluster) -> Double { @_common.max(s.data) }

pub fn sort_compare_heap_cluster_to_string(s : SortcompareheapCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortcompareheapModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_compare_heap_model_make(size : Int) -> SortcompareheapModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_compare_heap_model_len(s : SortcompareheapModel) -> Int { s.size }

pub fn sort_compare_heap_model_get(s : SortcompareheapModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_compare_heap_model_set(s : SortcompareheapModel, i : Int, v : Double) -> SortcompareheapModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_compare_heap_model_sum(s : SortcompareheapModel) -> Double { @_common.sum(s.data) }

pub fn sort_compare_heap_model_mean(s : SortcompareheapModel) -> Double { @_common.mean(s.data) }

pub fn sort_compare_heap_model_scale(s : SortcompareheapModel, f : Double) -> SortcompareheapModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_compare_heap_model_add(a : SortcompareheapModel, b : SortcompareheapModel) -> SortcompareheapModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_compare_heap_model_copy(s : SortcompareheapModel) -> SortcompareheapModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_compare_heap_model_fill(s : SortcompareheapModel, v : Double) -> SortcompareheapModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_compare_heap_model_min(s : SortcompareheapModel) -> Double { @_common.min(s.data) }

pub fn sort_compare_heap_model_max(s : SortcompareheapModel) -> Double { @_common.max(s.data) }

pub fn sort_compare_heap_model_to_string(s : SortcompareheapModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortcompareheapLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_compare_heap_layer_make(size : Int) -> SortcompareheapLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_compare_heap_layer_len(s : SortcompareheapLayer) -> Int { s.size }

pub fn sort_compare_heap_layer_get(s : SortcompareheapLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_compare_heap_layer_set(s : SortcompareheapLayer, i : Int, v : Double) -> SortcompareheapLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_compare_heap_layer_sum(s : SortcompareheapLayer) -> Double { @_common.sum(s.data) }

pub fn sort_compare_heap_layer_mean(s : SortcompareheapLayer) -> Double { @_common.mean(s.data) }

pub fn sort_compare_heap_layer_scale(s : SortcompareheapLayer, f : Double) -> SortcompareheapLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_compare_heap_layer_add(a : SortcompareheapLayer, b : SortcompareheapLayer) -> SortcompareheapLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_compare_heap_layer_copy(s : SortcompareheapLayer) -> SortcompareheapLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_compare_heap_layer_fill(s : SortcompareheapLayer, v : Double) -> SortcompareheapLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_compare_heap_layer_min(s : SortcompareheapLayer) -> Double { @_common.min(s.data) }

pub fn sort_compare_heap_layer_max(s : SortcompareheapLayer) -> Double { @_common.max(s.data) }

pub fn sort_compare_heap_layer_to_string(s : SortcompareheapLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortcompareheapBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_compare_heap_buffer_make(size : Int) -> SortcompareheapBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_compare_heap_buffer_len(s : SortcompareheapBuffer) -> Int { s.size }

pub fn sort_compare_heap_buffer_get(s : SortcompareheapBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_compare_heap_buffer_set(s : SortcompareheapBuffer, i : Int, v : Double) -> SortcompareheapBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_compare_heap_buffer_sum(s : SortcompareheapBuffer) -> Double { @_common.sum(s.data) }

pub fn sort_compare_heap_buffer_mean(s : SortcompareheapBuffer) -> Double { @_common.mean(s.data) }

pub fn sort_compare_heap_buffer_scale(s : SortcompareheapBuffer, f : Double) -> SortcompareheapBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_compare_heap_buffer_add(a : SortcompareheapBuffer, b : SortcompareheapBuffer) -> SortcompareheapBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_compare_heap_buffer_copy(s : SortcompareheapBuffer) -> SortcompareheapBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_compare_heap_buffer_fill(s : SortcompareheapBuffer, v : Double) -> SortcompareheapBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_compare_heap_buffer_min(s : SortcompareheapBuffer) -> Double { @_common.min(s.data) }

pub fn sort_compare_heap_buffer_max(s : SortcompareheapBuffer) -> Double { @_common.max(s.data) }

pub fn sort_compare_heap_buffer_to_string(s : SortcompareheapBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortcompareheapCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_compare_heap_cursor_make(size : Int) -> SortcompareheapCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_compare_heap_cursor_len(s : SortcompareheapCursor) -> Int { s.size }

pub fn sort_compare_heap_cursor_get(s : SortcompareheapCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_compare_heap_cursor_set(s : SortcompareheapCursor, i : Int, v : Double) -> SortcompareheapCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_compare_heap_cursor_sum(s : SortcompareheapCursor) -> Double { @_common.sum(s.data) }

pub fn sort_compare_heap_cursor_mean(s : SortcompareheapCursor) -> Double { @_common.mean(s.data) }

pub fn sort_compare_heap_cursor_scale(s : SortcompareheapCursor, f : Double) -> SortcompareheapCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_compare_heap_cursor_add(a : SortcompareheapCursor, b : SortcompareheapCursor) -> SortcompareheapCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_compare_heap_cursor_copy(s : SortcompareheapCursor) -> SortcompareheapCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_compare_heap_cursor_fill(s : SortcompareheapCursor, v : Double) -> SortcompareheapCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_compare_heap_cursor_min(s : SortcompareheapCursor) -> Double { @_common.min(s.data) }

pub fn sort_compare_heap_cursor_max(s : SortcompareheapCursor) -> Double { @_common.max(s.data) }

pub fn sort_compare_heap_cursor_to_string(s : SortcompareheapCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortcompareheapView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_compare_heap_view_make(size : Int) -> SortcompareheapView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_compare_heap_view_len(s : SortcompareheapView) -> Int { s.size }

pub fn sort_compare_heap_view_get(s : SortcompareheapView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_compare_heap_view_set(s : SortcompareheapView, i : Int, v : Double) -> SortcompareheapView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_compare_heap_view_sum(s : SortcompareheapView) -> Double { @_common.sum(s.data) }

pub fn sort_compare_heap_view_mean(s : SortcompareheapView) -> Double { @_common.mean(s.data) }

pub fn sort_compare_heap_view_scale(s : SortcompareheapView, f : Double) -> SortcompareheapView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_compare_heap_view_add(a : SortcompareheapView, b : SortcompareheapView) -> SortcompareheapView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_compare_heap_view_copy(s : SortcompareheapView) -> SortcompareheapView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_compare_heap_view_fill(s : SortcompareheapView, v : Double) -> SortcompareheapView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_compare_heap_view_min(s : SortcompareheapView) -> Double { @_common.min(s.data) }

pub fn sort_compare_heap_view_max(s : SortcompareheapView) -> Double { @_common.max(s.data) }

pub fn sort_compare_heap_view_to_string(s : SortcompareheapView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortcompareheapRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_compare_heap_range_make(size : Int) -> SortcompareheapRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_compare_heap_range_len(s : SortcompareheapRange) -> Int { s.size }

pub fn sort_compare_heap_range_get(s : SortcompareheapRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_compare_heap_range_set(s : SortcompareheapRange, i : Int, v : Double) -> SortcompareheapRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_compare_heap_range_sum(s : SortcompareheapRange) -> Double { @_common.sum(s.data) }

pub fn sort_compare_heap_range_mean(s : SortcompareheapRange) -> Double { @_common.mean(s.data) }

pub fn sort_compare_heap_range_scale(s : SortcompareheapRange, f : Double) -> SortcompareheapRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_compare_heap_range_add(a : SortcompareheapRange, b : SortcompareheapRange) -> SortcompareheapRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_compare_heap_range_copy(s : SortcompareheapRange) -> SortcompareheapRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_compare_heap_range_fill(s : SortcompareheapRange, v : Double) -> SortcompareheapRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_compare_heap_range_min(s : SortcompareheapRange) -> Double { @_common.min(s.data) }

pub fn sort_compare_heap_range_max(s : SortcompareheapRange) -> Double { @_common.max(s.data) }

pub fn sort_compare_heap_range_to_string(s : SortcompareheapRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortcompareheapSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_compare_heap_slice_make(size : Int) -> SortcompareheapSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_compare_heap_slice_len(s : SortcompareheapSlice) -> Int { s.size }

pub fn sort_compare_heap_slice_get(s : SortcompareheapSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_compare_heap_slice_set(s : SortcompareheapSlice, i : Int, v : Double) -> SortcompareheapSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_compare_heap_slice_sum(s : SortcompareheapSlice) -> Double { @_common.sum(s.data) }

pub fn sort_compare_heap_slice_mean(s : SortcompareheapSlice) -> Double { @_common.mean(s.data) }

pub fn sort_compare_heap_slice_scale(s : SortcompareheapSlice, f : Double) -> SortcompareheapSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_compare_heap_slice_add(a : SortcompareheapSlice, b : SortcompareheapSlice) -> SortcompareheapSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_compare_heap_slice_copy(s : SortcompareheapSlice) -> SortcompareheapSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_compare_heap_slice_fill(s : SortcompareheapSlice, v : Double) -> SortcompareheapSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_compare_heap_slice_min(s : SortcompareheapSlice) -> Double { @_common.min(s.data) }

pub fn sort_compare_heap_slice_max(s : SortcompareheapSlice) -> Double { @_common.max(s.data) }

pub fn sort_compare_heap_slice_to_string(s : SortcompareheapSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

