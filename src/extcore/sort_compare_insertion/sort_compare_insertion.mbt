///===
/// extcore/sort_compare_insertion

pub(all) struct SortcompareinsertionPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn sort_compare_insertion_make_point(x : Double, y : Double) -> SortcompareinsertionPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn sort_compare_insertion_make_point3(x : Double, y : Double, z : Double) -> SortcompareinsertionPoint {
  { x, y, z, label: 0 }
}

pub fn SortcompareinsertionPoint::x(self : SortcompareinsertionPoint) -> Double { self.x }

pub fn SortcompareinsertionPoint::y(self : SortcompareinsertionPoint) -> Double { self.y }

pub fn SortcompareinsertionPoint::z(self : SortcompareinsertionPoint) -> Double { self.z }

pub fn SortcompareinsertionPoint::label(self : SortcompareinsertionPoint) -> Int { self.label }

pub fn SortcompareinsertionPoint::dist(self : SortcompareinsertionPoint, other : SortcompareinsertionPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn SortcompareinsertionPoint::add(self : SortcompareinsertionPoint, other : SortcompareinsertionPoint) -> SortcompareinsertionPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn SortcompareinsertionPoint::sub(self : SortcompareinsertionPoint, other : SortcompareinsertionPoint) -> SortcompareinsertionPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn SortcompareinsertionPoint::scale(self : SortcompareinsertionPoint, s : Double) -> SortcompareinsertionPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn SortcompareinsertionPoint::dot(self : SortcompareinsertionPoint, other : SortcompareinsertionPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn SortcompareinsertionPoint::cross(self : SortcompareinsertionPoint, other : SortcompareinsertionPoint) -> SortcompareinsertionPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn SortcompareinsertionPoint::norm(self : SortcompareinsertionPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn SortcompareinsertionPoint::normalize(self : SortcompareinsertionPoint) -> SortcompareinsertionPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn SortcompareinsertionPoint::negate(self : SortcompareinsertionPoint) -> SortcompareinsertionPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn SortcompareinsertionPoint::mid(self : SortcompareinsertionPoint, other : SortcompareinsertionPoint) -> SortcompareinsertionPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn SortcompareinsertionPoint::lerp(self : SortcompareinsertionPoint, other : SortcompareinsertionPoint, t : Double) -> SortcompareinsertionPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn SortcompareinsertionPoint::to_string(self : SortcompareinsertionPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct SortcompareinsertionSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn sort_compare_insertion_make_series(vals : Array[Double], name : String) -> SortcompareinsertionSeries {
  { vals, name, meta: 0 }
}

pub fn SortcompareinsertionSeries::len(self : SortcompareinsertionSeries) -> Int { self.vals.length() }

pub fn SortcompareinsertionSeries::sum(self : SortcompareinsertionSeries) -> Double { @_common.sum(self.vals) }

pub fn SortcompareinsertionSeries::mean(self : SortcompareinsertionSeries) -> Double { @_common.mean(self.vals) }

pub fn SortcompareinsertionSeries::min(self : SortcompareinsertionSeries) -> Double { @_common.min(self.vals) }

pub fn SortcompareinsertionSeries::max(self : SortcompareinsertionSeries) -> Double { @_common.max(self.vals) }

pub fn SortcompareinsertionSeries::range(self : SortcompareinsertionSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn SortcompareinsertionSeries::variance(self : SortcompareinsertionSeries) -> Double { @_common.variance(self.vals) }

pub fn SortcompareinsertionSeries::std(self : SortcompareinsertionSeries) -> Double { @_common.std(self.vals) }

pub fn SortcompareinsertionSeries::median(self : SortcompareinsertionSeries) -> Double { @_common.median(self.vals) }

pub fn SortcompareinsertionSeries::scale(self : SortcompareinsertionSeries, f : Double) -> SortcompareinsertionSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn SortcompareinsertionSeries::add(self : SortcompareinsertionSeries, other : SortcompareinsertionSeries) -> SortcompareinsertionSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn SortcompareinsertionSeries::sub(self : SortcompareinsertionSeries, other : SortcompareinsertionSeries) -> SortcompareinsertionSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn SortcompareinsertionSeries::normalize(self : SortcompareinsertionSeries) -> SortcompareinsertionSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn SortcompareinsertionSeries::cumsum(self : SortcompareinsertionSeries) -> SortcompareinsertionSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn SortcompareinsertionSeries::to_string(self : SortcompareinsertionSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct SortcompareinsertionMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn sort_compare_insertion_make_matrix(rows : Int, cols : Int, val : Double) -> SortcompareinsertionMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn sort_compare_insertion_matrix_identity(n : Int) -> SortcompareinsertionMatrix {
  let m = sort_compare_insertion_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn SortcompareinsertionMatrix::get(self : SortcompareinsertionMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn SortcompareinsertionMatrix::transpose(self : SortcompareinsertionMatrix) -> SortcompareinsertionMatrix {
  let result = sort_compare_insertion_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn SortcompareinsertionMatrix::add(self : SortcompareinsertionMatrix, other : SortcompareinsertionMatrix) -> SortcompareinsertionMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = sort_compare_insertion_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn SortcompareinsertionMatrix::scale(self : SortcompareinsertionMatrix, s : Double) -> SortcompareinsertionMatrix {
  let result = sort_compare_insertion_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn SortcompareinsertionMatrix::multiply(self : SortcompareinsertionMatrix, other : SortcompareinsertionMatrix) -> SortcompareinsertionMatrix {
  if self.cols != other.rows { return sort_compare_insertion_make_matrix(self.rows, other.cols, 0.0) }
  let result = sort_compare_insertion_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn SortcompareinsertionMatrix::trace(self : SortcompareinsertionMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn SortcompareinsertionMatrix::det(self : SortcompareinsertionMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn SortcompareinsertionMatrix::norm(self : SortcompareinsertionMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn SortcompareinsertionMatrix::to_string(self : SortcompareinsertionMatrix) -> String {
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

pub(all) struct SortcompareinsertionVector {
  comps : Array[Double]
  dim : Int
}

pub fn sort_compare_insertion_make_vector(comps : Array[Double]) -> SortcompareinsertionVector {
  { comps, dim: comps.length() }
}

pub fn sort_compare_insertion_vector_zero(dim : Int) -> SortcompareinsertionVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn SortcompareinsertionVector::add(self : SortcompareinsertionVector, other : SortcompareinsertionVector) -> SortcompareinsertionVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn SortcompareinsertionVector::sub(self : SortcompareinsertionVector, other : SortcompareinsertionVector) -> SortcompareinsertionVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn SortcompareinsertionVector::scale(self : SortcompareinsertionVector, s : Double) -> SortcompareinsertionVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn SortcompareinsertionVector::dot(self : SortcompareinsertionVector, other : SortcompareinsertionVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn SortcompareinsertionVector::norm(self : SortcompareinsertionVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn SortcompareinsertionVector::normalize(self : SortcompareinsertionVector) -> SortcompareinsertionVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn SortcompareinsertionVector::dist(self : SortcompareinsertionVector, other : SortcompareinsertionVector) -> Double {
  self.sub(other).norm()
}

pub fn SortcompareinsertionVector::to_string(self : SortcompareinsertionVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn sort_compare_insertion_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn sort_compare_insertion_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn sort_compare_insertion_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn sort_compare_insertion_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn sort_compare_insertion_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn sort_compare_insertion_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn sort_compare_insertion_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn sort_compare_insertion_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn sort_compare_insertion_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn sort_compare_insertion_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn sort_compare_insertion_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn sort_compare_insertion_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn sort_compare_insertion_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn sort_compare_insertion_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn sort_compare_insertion_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn sort_compare_insertion_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn sort_compare_insertion_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn sort_compare_insertion_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn sort_compare_insertion_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn sort_compare_insertion_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn sort_compare_insertion_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn sort_compare_insertion_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn sort_compare_insertion_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn sort_compare_insertion_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn sort_compare_insertion_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn sort_compare_insertion_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn sort_compare_insertion_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn sort_compare_insertion_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn sort_compare_insertion_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct SortcompareinsertionFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_compare_insertion_frame_make(size : Int) -> SortcompareinsertionFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_compare_insertion_frame_len(s : SortcompareinsertionFrame) -> Int { s.size }

pub fn sort_compare_insertion_frame_get(s : SortcompareinsertionFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_compare_insertion_frame_set(s : SortcompareinsertionFrame, i : Int, v : Double) -> SortcompareinsertionFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_compare_insertion_frame_sum(s : SortcompareinsertionFrame) -> Double { @_common.sum(s.data) }

pub fn sort_compare_insertion_frame_mean(s : SortcompareinsertionFrame) -> Double { @_common.mean(s.data) }

pub fn sort_compare_insertion_frame_scale(s : SortcompareinsertionFrame, f : Double) -> SortcompareinsertionFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_compare_insertion_frame_add(a : SortcompareinsertionFrame, b : SortcompareinsertionFrame) -> SortcompareinsertionFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_compare_insertion_frame_copy(s : SortcompareinsertionFrame) -> SortcompareinsertionFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_compare_insertion_frame_fill(s : SortcompareinsertionFrame, v : Double) -> SortcompareinsertionFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_compare_insertion_frame_min(s : SortcompareinsertionFrame) -> Double { @_common.min(s.data) }

pub fn sort_compare_insertion_frame_max(s : SortcompareinsertionFrame) -> Double { @_common.max(s.data) }

pub fn sort_compare_insertion_frame_to_string(s : SortcompareinsertionFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortcompareinsertionTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_compare_insertion_table_make(size : Int) -> SortcompareinsertionTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_compare_insertion_table_len(s : SortcompareinsertionTable) -> Int { s.size }

pub fn sort_compare_insertion_table_get(s : SortcompareinsertionTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_compare_insertion_table_set(s : SortcompareinsertionTable, i : Int, v : Double) -> SortcompareinsertionTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_compare_insertion_table_sum(s : SortcompareinsertionTable) -> Double { @_common.sum(s.data) }

pub fn sort_compare_insertion_table_mean(s : SortcompareinsertionTable) -> Double { @_common.mean(s.data) }

pub fn sort_compare_insertion_table_scale(s : SortcompareinsertionTable, f : Double) -> SortcompareinsertionTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_compare_insertion_table_add(a : SortcompareinsertionTable, b : SortcompareinsertionTable) -> SortcompareinsertionTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_compare_insertion_table_copy(s : SortcompareinsertionTable) -> SortcompareinsertionTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_compare_insertion_table_fill(s : SortcompareinsertionTable, v : Double) -> SortcompareinsertionTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_compare_insertion_table_min(s : SortcompareinsertionTable) -> Double { @_common.min(s.data) }

pub fn sort_compare_insertion_table_max(s : SortcompareinsertionTable) -> Double { @_common.max(s.data) }

pub fn sort_compare_insertion_table_to_string(s : SortcompareinsertionTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortcompareinsertionGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_compare_insertion_graphn_make(size : Int) -> SortcompareinsertionGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_compare_insertion_graphn_len(s : SortcompareinsertionGraphN) -> Int { s.size }

pub fn sort_compare_insertion_graphn_get(s : SortcompareinsertionGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_compare_insertion_graphn_set(s : SortcompareinsertionGraphN, i : Int, v : Double) -> SortcompareinsertionGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_compare_insertion_graphn_sum(s : SortcompareinsertionGraphN) -> Double { @_common.sum(s.data) }

pub fn sort_compare_insertion_graphn_mean(s : SortcompareinsertionGraphN) -> Double { @_common.mean(s.data) }

pub fn sort_compare_insertion_graphn_scale(s : SortcompareinsertionGraphN, f : Double) -> SortcompareinsertionGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_compare_insertion_graphn_add(a : SortcompareinsertionGraphN, b : SortcompareinsertionGraphN) -> SortcompareinsertionGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_compare_insertion_graphn_copy(s : SortcompareinsertionGraphN) -> SortcompareinsertionGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_compare_insertion_graphn_fill(s : SortcompareinsertionGraphN, v : Double) -> SortcompareinsertionGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_compare_insertion_graphn_min(s : SortcompareinsertionGraphN) -> Double { @_common.min(s.data) }

pub fn sort_compare_insertion_graphn_max(s : SortcompareinsertionGraphN) -> Double { @_common.max(s.data) }

pub fn sort_compare_insertion_graphn_to_string(s : SortcompareinsertionGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortcompareinsertionNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_compare_insertion_node_make(size : Int) -> SortcompareinsertionNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_compare_insertion_node_len(s : SortcompareinsertionNode) -> Int { s.size }

pub fn sort_compare_insertion_node_get(s : SortcompareinsertionNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_compare_insertion_node_set(s : SortcompareinsertionNode, i : Int, v : Double) -> SortcompareinsertionNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_compare_insertion_node_sum(s : SortcompareinsertionNode) -> Double { @_common.sum(s.data) }

pub fn sort_compare_insertion_node_mean(s : SortcompareinsertionNode) -> Double { @_common.mean(s.data) }

pub fn sort_compare_insertion_node_scale(s : SortcompareinsertionNode, f : Double) -> SortcompareinsertionNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_compare_insertion_node_add(a : SortcompareinsertionNode, b : SortcompareinsertionNode) -> SortcompareinsertionNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_compare_insertion_node_copy(s : SortcompareinsertionNode) -> SortcompareinsertionNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_compare_insertion_node_fill(s : SortcompareinsertionNode, v : Double) -> SortcompareinsertionNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_compare_insertion_node_min(s : SortcompareinsertionNode) -> Double { @_common.min(s.data) }

pub fn sort_compare_insertion_node_max(s : SortcompareinsertionNode) -> Double { @_common.max(s.data) }

pub fn sort_compare_insertion_node_to_string(s : SortcompareinsertionNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortcompareinsertionEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_compare_insertion_edge_make(size : Int) -> SortcompareinsertionEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_compare_insertion_edge_len(s : SortcompareinsertionEdge) -> Int { s.size }

pub fn sort_compare_insertion_edge_get(s : SortcompareinsertionEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_compare_insertion_edge_set(s : SortcompareinsertionEdge, i : Int, v : Double) -> SortcompareinsertionEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_compare_insertion_edge_sum(s : SortcompareinsertionEdge) -> Double { @_common.sum(s.data) }

pub fn sort_compare_insertion_edge_mean(s : SortcompareinsertionEdge) -> Double { @_common.mean(s.data) }

pub fn sort_compare_insertion_edge_scale(s : SortcompareinsertionEdge, f : Double) -> SortcompareinsertionEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_compare_insertion_edge_add(a : SortcompareinsertionEdge, b : SortcompareinsertionEdge) -> SortcompareinsertionEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_compare_insertion_edge_copy(s : SortcompareinsertionEdge) -> SortcompareinsertionEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_compare_insertion_edge_fill(s : SortcompareinsertionEdge, v : Double) -> SortcompareinsertionEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_compare_insertion_edge_min(s : SortcompareinsertionEdge) -> Double { @_common.min(s.data) }

pub fn sort_compare_insertion_edge_max(s : SortcompareinsertionEdge) -> Double { @_common.max(s.data) }

pub fn sort_compare_insertion_edge_to_string(s : SortcompareinsertionEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortcompareinsertionPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_compare_insertion_path_make(size : Int) -> SortcompareinsertionPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_compare_insertion_path_len(s : SortcompareinsertionPath) -> Int { s.size }

pub fn sort_compare_insertion_path_get(s : SortcompareinsertionPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_compare_insertion_path_set(s : SortcompareinsertionPath, i : Int, v : Double) -> SortcompareinsertionPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_compare_insertion_path_sum(s : SortcompareinsertionPath) -> Double { @_common.sum(s.data) }

pub fn sort_compare_insertion_path_mean(s : SortcompareinsertionPath) -> Double { @_common.mean(s.data) }

pub fn sort_compare_insertion_path_scale(s : SortcompareinsertionPath, f : Double) -> SortcompareinsertionPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_compare_insertion_path_add(a : SortcompareinsertionPath, b : SortcompareinsertionPath) -> SortcompareinsertionPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_compare_insertion_path_copy(s : SortcompareinsertionPath) -> SortcompareinsertionPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_compare_insertion_path_fill(s : SortcompareinsertionPath, v : Double) -> SortcompareinsertionPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_compare_insertion_path_min(s : SortcompareinsertionPath) -> Double { @_common.min(s.data) }

pub fn sort_compare_insertion_path_max(s : SortcompareinsertionPath) -> Double { @_common.max(s.data) }

pub fn sort_compare_insertion_path_to_string(s : SortcompareinsertionPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortcompareinsertionCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_compare_insertion_cluster_make(size : Int) -> SortcompareinsertionCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_compare_insertion_cluster_len(s : SortcompareinsertionCluster) -> Int { s.size }

pub fn sort_compare_insertion_cluster_get(s : SortcompareinsertionCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_compare_insertion_cluster_set(s : SortcompareinsertionCluster, i : Int, v : Double) -> SortcompareinsertionCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_compare_insertion_cluster_sum(s : SortcompareinsertionCluster) -> Double { @_common.sum(s.data) }

pub fn sort_compare_insertion_cluster_mean(s : SortcompareinsertionCluster) -> Double { @_common.mean(s.data) }

pub fn sort_compare_insertion_cluster_scale(s : SortcompareinsertionCluster, f : Double) -> SortcompareinsertionCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_compare_insertion_cluster_add(a : SortcompareinsertionCluster, b : SortcompareinsertionCluster) -> SortcompareinsertionCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_compare_insertion_cluster_copy(s : SortcompareinsertionCluster) -> SortcompareinsertionCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_compare_insertion_cluster_fill(s : SortcompareinsertionCluster, v : Double) -> SortcompareinsertionCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_compare_insertion_cluster_min(s : SortcompareinsertionCluster) -> Double { @_common.min(s.data) }

pub fn sort_compare_insertion_cluster_max(s : SortcompareinsertionCluster) -> Double { @_common.max(s.data) }

pub fn sort_compare_insertion_cluster_to_string(s : SortcompareinsertionCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortcompareinsertionModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_compare_insertion_model_make(size : Int) -> SortcompareinsertionModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_compare_insertion_model_len(s : SortcompareinsertionModel) -> Int { s.size }

pub fn sort_compare_insertion_model_get(s : SortcompareinsertionModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_compare_insertion_model_set(s : SortcompareinsertionModel, i : Int, v : Double) -> SortcompareinsertionModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_compare_insertion_model_sum(s : SortcompareinsertionModel) -> Double { @_common.sum(s.data) }

pub fn sort_compare_insertion_model_mean(s : SortcompareinsertionModel) -> Double { @_common.mean(s.data) }

pub fn sort_compare_insertion_model_scale(s : SortcompareinsertionModel, f : Double) -> SortcompareinsertionModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_compare_insertion_model_add(a : SortcompareinsertionModel, b : SortcompareinsertionModel) -> SortcompareinsertionModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_compare_insertion_model_copy(s : SortcompareinsertionModel) -> SortcompareinsertionModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_compare_insertion_model_fill(s : SortcompareinsertionModel, v : Double) -> SortcompareinsertionModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_compare_insertion_model_min(s : SortcompareinsertionModel) -> Double { @_common.min(s.data) }

pub fn sort_compare_insertion_model_max(s : SortcompareinsertionModel) -> Double { @_common.max(s.data) }

pub fn sort_compare_insertion_model_to_string(s : SortcompareinsertionModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortcompareinsertionLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_compare_insertion_layer_make(size : Int) -> SortcompareinsertionLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_compare_insertion_layer_len(s : SortcompareinsertionLayer) -> Int { s.size }

pub fn sort_compare_insertion_layer_get(s : SortcompareinsertionLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_compare_insertion_layer_set(s : SortcompareinsertionLayer, i : Int, v : Double) -> SortcompareinsertionLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_compare_insertion_layer_sum(s : SortcompareinsertionLayer) -> Double { @_common.sum(s.data) }

pub fn sort_compare_insertion_layer_mean(s : SortcompareinsertionLayer) -> Double { @_common.mean(s.data) }

pub fn sort_compare_insertion_layer_scale(s : SortcompareinsertionLayer, f : Double) -> SortcompareinsertionLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_compare_insertion_layer_add(a : SortcompareinsertionLayer, b : SortcompareinsertionLayer) -> SortcompareinsertionLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_compare_insertion_layer_copy(s : SortcompareinsertionLayer) -> SortcompareinsertionLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_compare_insertion_layer_fill(s : SortcompareinsertionLayer, v : Double) -> SortcompareinsertionLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_compare_insertion_layer_min(s : SortcompareinsertionLayer) -> Double { @_common.min(s.data) }

pub fn sort_compare_insertion_layer_max(s : SortcompareinsertionLayer) -> Double { @_common.max(s.data) }

pub fn sort_compare_insertion_layer_to_string(s : SortcompareinsertionLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortcompareinsertionBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_compare_insertion_buffer_make(size : Int) -> SortcompareinsertionBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_compare_insertion_buffer_len(s : SortcompareinsertionBuffer) -> Int { s.size }

pub fn sort_compare_insertion_buffer_get(s : SortcompareinsertionBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_compare_insertion_buffer_set(s : SortcompareinsertionBuffer, i : Int, v : Double) -> SortcompareinsertionBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_compare_insertion_buffer_sum(s : SortcompareinsertionBuffer) -> Double { @_common.sum(s.data) }

pub fn sort_compare_insertion_buffer_mean(s : SortcompareinsertionBuffer) -> Double { @_common.mean(s.data) }

pub fn sort_compare_insertion_buffer_scale(s : SortcompareinsertionBuffer, f : Double) -> SortcompareinsertionBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_compare_insertion_buffer_add(a : SortcompareinsertionBuffer, b : SortcompareinsertionBuffer) -> SortcompareinsertionBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_compare_insertion_buffer_copy(s : SortcompareinsertionBuffer) -> SortcompareinsertionBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_compare_insertion_buffer_fill(s : SortcompareinsertionBuffer, v : Double) -> SortcompareinsertionBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_compare_insertion_buffer_min(s : SortcompareinsertionBuffer) -> Double { @_common.min(s.data) }

pub fn sort_compare_insertion_buffer_max(s : SortcompareinsertionBuffer) -> Double { @_common.max(s.data) }

pub fn sort_compare_insertion_buffer_to_string(s : SortcompareinsertionBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortcompareinsertionCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_compare_insertion_cursor_make(size : Int) -> SortcompareinsertionCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_compare_insertion_cursor_len(s : SortcompareinsertionCursor) -> Int { s.size }

pub fn sort_compare_insertion_cursor_get(s : SortcompareinsertionCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_compare_insertion_cursor_set(s : SortcompareinsertionCursor, i : Int, v : Double) -> SortcompareinsertionCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_compare_insertion_cursor_sum(s : SortcompareinsertionCursor) -> Double { @_common.sum(s.data) }

pub fn sort_compare_insertion_cursor_mean(s : SortcompareinsertionCursor) -> Double { @_common.mean(s.data) }

pub fn sort_compare_insertion_cursor_scale(s : SortcompareinsertionCursor, f : Double) -> SortcompareinsertionCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_compare_insertion_cursor_add(a : SortcompareinsertionCursor, b : SortcompareinsertionCursor) -> SortcompareinsertionCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_compare_insertion_cursor_copy(s : SortcompareinsertionCursor) -> SortcompareinsertionCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_compare_insertion_cursor_fill(s : SortcompareinsertionCursor, v : Double) -> SortcompareinsertionCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_compare_insertion_cursor_min(s : SortcompareinsertionCursor) -> Double { @_common.min(s.data) }

pub fn sort_compare_insertion_cursor_max(s : SortcompareinsertionCursor) -> Double { @_common.max(s.data) }

pub fn sort_compare_insertion_cursor_to_string(s : SortcompareinsertionCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortcompareinsertionView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_compare_insertion_view_make(size : Int) -> SortcompareinsertionView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_compare_insertion_view_len(s : SortcompareinsertionView) -> Int { s.size }

pub fn sort_compare_insertion_view_get(s : SortcompareinsertionView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_compare_insertion_view_set(s : SortcompareinsertionView, i : Int, v : Double) -> SortcompareinsertionView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_compare_insertion_view_sum(s : SortcompareinsertionView) -> Double { @_common.sum(s.data) }

pub fn sort_compare_insertion_view_mean(s : SortcompareinsertionView) -> Double { @_common.mean(s.data) }

pub fn sort_compare_insertion_view_scale(s : SortcompareinsertionView, f : Double) -> SortcompareinsertionView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_compare_insertion_view_add(a : SortcompareinsertionView, b : SortcompareinsertionView) -> SortcompareinsertionView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_compare_insertion_view_copy(s : SortcompareinsertionView) -> SortcompareinsertionView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_compare_insertion_view_fill(s : SortcompareinsertionView, v : Double) -> SortcompareinsertionView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_compare_insertion_view_min(s : SortcompareinsertionView) -> Double { @_common.min(s.data) }

pub fn sort_compare_insertion_view_max(s : SortcompareinsertionView) -> Double { @_common.max(s.data) }

pub fn sort_compare_insertion_view_to_string(s : SortcompareinsertionView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortcompareinsertionRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_compare_insertion_range_make(size : Int) -> SortcompareinsertionRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_compare_insertion_range_len(s : SortcompareinsertionRange) -> Int { s.size }

pub fn sort_compare_insertion_range_get(s : SortcompareinsertionRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_compare_insertion_range_set(s : SortcompareinsertionRange, i : Int, v : Double) -> SortcompareinsertionRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_compare_insertion_range_sum(s : SortcompareinsertionRange) -> Double { @_common.sum(s.data) }

pub fn sort_compare_insertion_range_mean(s : SortcompareinsertionRange) -> Double { @_common.mean(s.data) }

pub fn sort_compare_insertion_range_scale(s : SortcompareinsertionRange, f : Double) -> SortcompareinsertionRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_compare_insertion_range_add(a : SortcompareinsertionRange, b : SortcompareinsertionRange) -> SortcompareinsertionRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_compare_insertion_range_copy(s : SortcompareinsertionRange) -> SortcompareinsertionRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_compare_insertion_range_fill(s : SortcompareinsertionRange, v : Double) -> SortcompareinsertionRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_compare_insertion_range_min(s : SortcompareinsertionRange) -> Double { @_common.min(s.data) }

pub fn sort_compare_insertion_range_max(s : SortcompareinsertionRange) -> Double { @_common.max(s.data) }

pub fn sort_compare_insertion_range_to_string(s : SortcompareinsertionRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortcompareinsertionSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_compare_insertion_slice_make(size : Int) -> SortcompareinsertionSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_compare_insertion_slice_len(s : SortcompareinsertionSlice) -> Int { s.size }

pub fn sort_compare_insertion_slice_get(s : SortcompareinsertionSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_compare_insertion_slice_set(s : SortcompareinsertionSlice, i : Int, v : Double) -> SortcompareinsertionSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_compare_insertion_slice_sum(s : SortcompareinsertionSlice) -> Double { @_common.sum(s.data) }

pub fn sort_compare_insertion_slice_mean(s : SortcompareinsertionSlice) -> Double { @_common.mean(s.data) }

pub fn sort_compare_insertion_slice_scale(s : SortcompareinsertionSlice, f : Double) -> SortcompareinsertionSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_compare_insertion_slice_add(a : SortcompareinsertionSlice, b : SortcompareinsertionSlice) -> SortcompareinsertionSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_compare_insertion_slice_copy(s : SortcompareinsertionSlice) -> SortcompareinsertionSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_compare_insertion_slice_fill(s : SortcompareinsertionSlice, v : Double) -> SortcompareinsertionSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_compare_insertion_slice_min(s : SortcompareinsertionSlice) -> Double { @_common.min(s.data) }

pub fn sort_compare_insertion_slice_max(s : SortcompareinsertionSlice) -> Double { @_common.max(s.data) }

pub fn sort_compare_insertion_slice_to_string(s : SortcompareinsertionSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

