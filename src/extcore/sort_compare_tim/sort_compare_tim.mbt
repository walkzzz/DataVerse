///===
/// extcore/sort_compare_tim

pub(all) struct SortcomparetimPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn sort_compare_tim_make_point(x : Double, y : Double) -> SortcomparetimPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn sort_compare_tim_make_point3(x : Double, y : Double, z : Double) -> SortcomparetimPoint {
  { x, y, z, label: 0 }
}

pub fn SortcomparetimPoint::x(self : SortcomparetimPoint) -> Double { self.x }

pub fn SortcomparetimPoint::y(self : SortcomparetimPoint) -> Double { self.y }

pub fn SortcomparetimPoint::z(self : SortcomparetimPoint) -> Double { self.z }

pub fn SortcomparetimPoint::label(self : SortcomparetimPoint) -> Int { self.label }

pub fn SortcomparetimPoint::dist(self : SortcomparetimPoint, other : SortcomparetimPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn SortcomparetimPoint::add(self : SortcomparetimPoint, other : SortcomparetimPoint) -> SortcomparetimPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn SortcomparetimPoint::sub(self : SortcomparetimPoint, other : SortcomparetimPoint) -> SortcomparetimPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn SortcomparetimPoint::scale(self : SortcomparetimPoint, s : Double) -> SortcomparetimPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn SortcomparetimPoint::dot(self : SortcomparetimPoint, other : SortcomparetimPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn SortcomparetimPoint::cross(self : SortcomparetimPoint, other : SortcomparetimPoint) -> SortcomparetimPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn SortcomparetimPoint::norm(self : SortcomparetimPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn SortcomparetimPoint::normalize(self : SortcomparetimPoint) -> SortcomparetimPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn SortcomparetimPoint::negate(self : SortcomparetimPoint) -> SortcomparetimPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn SortcomparetimPoint::mid(self : SortcomparetimPoint, other : SortcomparetimPoint) -> SortcomparetimPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn SortcomparetimPoint::lerp(self : SortcomparetimPoint, other : SortcomparetimPoint, t : Double) -> SortcomparetimPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn SortcomparetimPoint::to_string(self : SortcomparetimPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct SortcomparetimSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn sort_compare_tim_make_series(vals : Array[Double], name : String) -> SortcomparetimSeries {
  { vals, name, meta: 0 }
}

pub fn SortcomparetimSeries::len(self : SortcomparetimSeries) -> Int { self.vals.length() }

pub fn SortcomparetimSeries::sum(self : SortcomparetimSeries) -> Double { @_common.sum(self.vals) }

pub fn SortcomparetimSeries::mean(self : SortcomparetimSeries) -> Double { @_common.mean(self.vals) }

pub fn SortcomparetimSeries::min(self : SortcomparetimSeries) -> Double { @_common.min(self.vals) }

pub fn SortcomparetimSeries::max(self : SortcomparetimSeries) -> Double { @_common.max(self.vals) }

pub fn SortcomparetimSeries::range(self : SortcomparetimSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn SortcomparetimSeries::variance(self : SortcomparetimSeries) -> Double { @_common.variance(self.vals) }

pub fn SortcomparetimSeries::std(self : SortcomparetimSeries) -> Double { @_common.std(self.vals) }

pub fn SortcomparetimSeries::median(self : SortcomparetimSeries) -> Double { @_common.median(self.vals) }

pub fn SortcomparetimSeries::scale(self : SortcomparetimSeries, f : Double) -> SortcomparetimSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn SortcomparetimSeries::add(self : SortcomparetimSeries, other : SortcomparetimSeries) -> SortcomparetimSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn SortcomparetimSeries::sub(self : SortcomparetimSeries, other : SortcomparetimSeries) -> SortcomparetimSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn SortcomparetimSeries::normalize(self : SortcomparetimSeries) -> SortcomparetimSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn SortcomparetimSeries::cumsum(self : SortcomparetimSeries) -> SortcomparetimSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn SortcomparetimSeries::to_string(self : SortcomparetimSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct SortcomparetimMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn sort_compare_tim_make_matrix(rows : Int, cols : Int, val : Double) -> SortcomparetimMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn sort_compare_tim_matrix_identity(n : Int) -> SortcomparetimMatrix {
  let m = sort_compare_tim_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn SortcomparetimMatrix::get(self : SortcomparetimMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn SortcomparetimMatrix::transpose(self : SortcomparetimMatrix) -> SortcomparetimMatrix {
  let result = sort_compare_tim_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn SortcomparetimMatrix::add(self : SortcomparetimMatrix, other : SortcomparetimMatrix) -> SortcomparetimMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = sort_compare_tim_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn SortcomparetimMatrix::scale(self : SortcomparetimMatrix, s : Double) -> SortcomparetimMatrix {
  let result = sort_compare_tim_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn SortcomparetimMatrix::multiply(self : SortcomparetimMatrix, other : SortcomparetimMatrix) -> SortcomparetimMatrix {
  if self.cols != other.rows { return sort_compare_tim_make_matrix(self.rows, other.cols, 0.0) }
  let result = sort_compare_tim_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn SortcomparetimMatrix::trace(self : SortcomparetimMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn SortcomparetimMatrix::det(self : SortcomparetimMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn SortcomparetimMatrix::norm(self : SortcomparetimMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn SortcomparetimMatrix::to_string(self : SortcomparetimMatrix) -> String {
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

pub(all) struct SortcomparetimVector {
  comps : Array[Double]
  dim : Int
}

pub fn sort_compare_tim_make_vector(comps : Array[Double]) -> SortcomparetimVector {
  { comps, dim: comps.length() }
}

pub fn sort_compare_tim_vector_zero(dim : Int) -> SortcomparetimVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn SortcomparetimVector::add(self : SortcomparetimVector, other : SortcomparetimVector) -> SortcomparetimVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn SortcomparetimVector::sub(self : SortcomparetimVector, other : SortcomparetimVector) -> SortcomparetimVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn SortcomparetimVector::scale(self : SortcomparetimVector, s : Double) -> SortcomparetimVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn SortcomparetimVector::dot(self : SortcomparetimVector, other : SortcomparetimVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn SortcomparetimVector::norm(self : SortcomparetimVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn SortcomparetimVector::normalize(self : SortcomparetimVector) -> SortcomparetimVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn SortcomparetimVector::dist(self : SortcomparetimVector, other : SortcomparetimVector) -> Double {
  self.sub(other).norm()
}

pub fn SortcomparetimVector::to_string(self : SortcomparetimVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn sort_compare_tim_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn sort_compare_tim_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn sort_compare_tim_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn sort_compare_tim_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn sort_compare_tim_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn sort_compare_tim_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn sort_compare_tim_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn sort_compare_tim_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn sort_compare_tim_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn sort_compare_tim_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn sort_compare_tim_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn sort_compare_tim_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn sort_compare_tim_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn sort_compare_tim_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn sort_compare_tim_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn sort_compare_tim_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn sort_compare_tim_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn sort_compare_tim_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn sort_compare_tim_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn sort_compare_tim_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn sort_compare_tim_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn sort_compare_tim_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn sort_compare_tim_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn sort_compare_tim_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn sort_compare_tim_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn sort_compare_tim_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn sort_compare_tim_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn sort_compare_tim_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn sort_compare_tim_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct SortcomparetimFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_compare_tim_frame_make(size : Int) -> SortcomparetimFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_compare_tim_frame_len(s : SortcomparetimFrame) -> Int { s.size }

pub fn sort_compare_tim_frame_get(s : SortcomparetimFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_compare_tim_frame_set(s : SortcomparetimFrame, i : Int, v : Double) -> SortcomparetimFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_compare_tim_frame_sum(s : SortcomparetimFrame) -> Double { @_common.sum(s.data) }

pub fn sort_compare_tim_frame_mean(s : SortcomparetimFrame) -> Double { @_common.mean(s.data) }

pub fn sort_compare_tim_frame_scale(s : SortcomparetimFrame, f : Double) -> SortcomparetimFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_compare_tim_frame_add(a : SortcomparetimFrame, b : SortcomparetimFrame) -> SortcomparetimFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_compare_tim_frame_copy(s : SortcomparetimFrame) -> SortcomparetimFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_compare_tim_frame_fill(s : SortcomparetimFrame, v : Double) -> SortcomparetimFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_compare_tim_frame_min(s : SortcomparetimFrame) -> Double { @_common.min(s.data) }

pub fn sort_compare_tim_frame_max(s : SortcomparetimFrame) -> Double { @_common.max(s.data) }

pub fn sort_compare_tim_frame_to_string(s : SortcomparetimFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortcomparetimTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_compare_tim_table_make(size : Int) -> SortcomparetimTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_compare_tim_table_len(s : SortcomparetimTable) -> Int { s.size }

pub fn sort_compare_tim_table_get(s : SortcomparetimTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_compare_tim_table_set(s : SortcomparetimTable, i : Int, v : Double) -> SortcomparetimTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_compare_tim_table_sum(s : SortcomparetimTable) -> Double { @_common.sum(s.data) }

pub fn sort_compare_tim_table_mean(s : SortcomparetimTable) -> Double { @_common.mean(s.data) }

pub fn sort_compare_tim_table_scale(s : SortcomparetimTable, f : Double) -> SortcomparetimTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_compare_tim_table_add(a : SortcomparetimTable, b : SortcomparetimTable) -> SortcomparetimTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_compare_tim_table_copy(s : SortcomparetimTable) -> SortcomparetimTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_compare_tim_table_fill(s : SortcomparetimTable, v : Double) -> SortcomparetimTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_compare_tim_table_min(s : SortcomparetimTable) -> Double { @_common.min(s.data) }

pub fn sort_compare_tim_table_max(s : SortcomparetimTable) -> Double { @_common.max(s.data) }

pub fn sort_compare_tim_table_to_string(s : SortcomparetimTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortcomparetimGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_compare_tim_graphn_make(size : Int) -> SortcomparetimGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_compare_tim_graphn_len(s : SortcomparetimGraphN) -> Int { s.size }

pub fn sort_compare_tim_graphn_get(s : SortcomparetimGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_compare_tim_graphn_set(s : SortcomparetimGraphN, i : Int, v : Double) -> SortcomparetimGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_compare_tim_graphn_sum(s : SortcomparetimGraphN) -> Double { @_common.sum(s.data) }

pub fn sort_compare_tim_graphn_mean(s : SortcomparetimGraphN) -> Double { @_common.mean(s.data) }

pub fn sort_compare_tim_graphn_scale(s : SortcomparetimGraphN, f : Double) -> SortcomparetimGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_compare_tim_graphn_add(a : SortcomparetimGraphN, b : SortcomparetimGraphN) -> SortcomparetimGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_compare_tim_graphn_copy(s : SortcomparetimGraphN) -> SortcomparetimGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_compare_tim_graphn_fill(s : SortcomparetimGraphN, v : Double) -> SortcomparetimGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_compare_tim_graphn_min(s : SortcomparetimGraphN) -> Double { @_common.min(s.data) }

pub fn sort_compare_tim_graphn_max(s : SortcomparetimGraphN) -> Double { @_common.max(s.data) }

pub fn sort_compare_tim_graphn_to_string(s : SortcomparetimGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortcomparetimNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_compare_tim_node_make(size : Int) -> SortcomparetimNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_compare_tim_node_len(s : SortcomparetimNode) -> Int { s.size }

pub fn sort_compare_tim_node_get(s : SortcomparetimNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_compare_tim_node_set(s : SortcomparetimNode, i : Int, v : Double) -> SortcomparetimNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_compare_tim_node_sum(s : SortcomparetimNode) -> Double { @_common.sum(s.data) }

pub fn sort_compare_tim_node_mean(s : SortcomparetimNode) -> Double { @_common.mean(s.data) }

pub fn sort_compare_tim_node_scale(s : SortcomparetimNode, f : Double) -> SortcomparetimNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_compare_tim_node_add(a : SortcomparetimNode, b : SortcomparetimNode) -> SortcomparetimNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_compare_tim_node_copy(s : SortcomparetimNode) -> SortcomparetimNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_compare_tim_node_fill(s : SortcomparetimNode, v : Double) -> SortcomparetimNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_compare_tim_node_min(s : SortcomparetimNode) -> Double { @_common.min(s.data) }

pub fn sort_compare_tim_node_max(s : SortcomparetimNode) -> Double { @_common.max(s.data) }

pub fn sort_compare_tim_node_to_string(s : SortcomparetimNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortcomparetimEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_compare_tim_edge_make(size : Int) -> SortcomparetimEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_compare_tim_edge_len(s : SortcomparetimEdge) -> Int { s.size }

pub fn sort_compare_tim_edge_get(s : SortcomparetimEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_compare_tim_edge_set(s : SortcomparetimEdge, i : Int, v : Double) -> SortcomparetimEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_compare_tim_edge_sum(s : SortcomparetimEdge) -> Double { @_common.sum(s.data) }

pub fn sort_compare_tim_edge_mean(s : SortcomparetimEdge) -> Double { @_common.mean(s.data) }

pub fn sort_compare_tim_edge_scale(s : SortcomparetimEdge, f : Double) -> SortcomparetimEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_compare_tim_edge_add(a : SortcomparetimEdge, b : SortcomparetimEdge) -> SortcomparetimEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_compare_tim_edge_copy(s : SortcomparetimEdge) -> SortcomparetimEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_compare_tim_edge_fill(s : SortcomparetimEdge, v : Double) -> SortcomparetimEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_compare_tim_edge_min(s : SortcomparetimEdge) -> Double { @_common.min(s.data) }

pub fn sort_compare_tim_edge_max(s : SortcomparetimEdge) -> Double { @_common.max(s.data) }

pub fn sort_compare_tim_edge_to_string(s : SortcomparetimEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortcomparetimPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_compare_tim_path_make(size : Int) -> SortcomparetimPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_compare_tim_path_len(s : SortcomparetimPath) -> Int { s.size }

pub fn sort_compare_tim_path_get(s : SortcomparetimPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_compare_tim_path_set(s : SortcomparetimPath, i : Int, v : Double) -> SortcomparetimPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_compare_tim_path_sum(s : SortcomparetimPath) -> Double { @_common.sum(s.data) }

pub fn sort_compare_tim_path_mean(s : SortcomparetimPath) -> Double { @_common.mean(s.data) }

pub fn sort_compare_tim_path_scale(s : SortcomparetimPath, f : Double) -> SortcomparetimPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_compare_tim_path_add(a : SortcomparetimPath, b : SortcomparetimPath) -> SortcomparetimPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_compare_tim_path_copy(s : SortcomparetimPath) -> SortcomparetimPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_compare_tim_path_fill(s : SortcomparetimPath, v : Double) -> SortcomparetimPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_compare_tim_path_min(s : SortcomparetimPath) -> Double { @_common.min(s.data) }

pub fn sort_compare_tim_path_max(s : SortcomparetimPath) -> Double { @_common.max(s.data) }

pub fn sort_compare_tim_path_to_string(s : SortcomparetimPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortcomparetimCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_compare_tim_cluster_make(size : Int) -> SortcomparetimCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_compare_tim_cluster_len(s : SortcomparetimCluster) -> Int { s.size }

pub fn sort_compare_tim_cluster_get(s : SortcomparetimCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_compare_tim_cluster_set(s : SortcomparetimCluster, i : Int, v : Double) -> SortcomparetimCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_compare_tim_cluster_sum(s : SortcomparetimCluster) -> Double { @_common.sum(s.data) }

pub fn sort_compare_tim_cluster_mean(s : SortcomparetimCluster) -> Double { @_common.mean(s.data) }

pub fn sort_compare_tim_cluster_scale(s : SortcomparetimCluster, f : Double) -> SortcomparetimCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_compare_tim_cluster_add(a : SortcomparetimCluster, b : SortcomparetimCluster) -> SortcomparetimCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_compare_tim_cluster_copy(s : SortcomparetimCluster) -> SortcomparetimCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_compare_tim_cluster_fill(s : SortcomparetimCluster, v : Double) -> SortcomparetimCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_compare_tim_cluster_min(s : SortcomparetimCluster) -> Double { @_common.min(s.data) }

pub fn sort_compare_tim_cluster_max(s : SortcomparetimCluster) -> Double { @_common.max(s.data) }

pub fn sort_compare_tim_cluster_to_string(s : SortcomparetimCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortcomparetimModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_compare_tim_model_make(size : Int) -> SortcomparetimModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_compare_tim_model_len(s : SortcomparetimModel) -> Int { s.size }

pub fn sort_compare_tim_model_get(s : SortcomparetimModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_compare_tim_model_set(s : SortcomparetimModel, i : Int, v : Double) -> SortcomparetimModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_compare_tim_model_sum(s : SortcomparetimModel) -> Double { @_common.sum(s.data) }

pub fn sort_compare_tim_model_mean(s : SortcomparetimModel) -> Double { @_common.mean(s.data) }

pub fn sort_compare_tim_model_scale(s : SortcomparetimModel, f : Double) -> SortcomparetimModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_compare_tim_model_add(a : SortcomparetimModel, b : SortcomparetimModel) -> SortcomparetimModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_compare_tim_model_copy(s : SortcomparetimModel) -> SortcomparetimModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_compare_tim_model_fill(s : SortcomparetimModel, v : Double) -> SortcomparetimModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_compare_tim_model_min(s : SortcomparetimModel) -> Double { @_common.min(s.data) }

pub fn sort_compare_tim_model_max(s : SortcomparetimModel) -> Double { @_common.max(s.data) }

pub fn sort_compare_tim_model_to_string(s : SortcomparetimModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortcomparetimLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_compare_tim_layer_make(size : Int) -> SortcomparetimLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_compare_tim_layer_len(s : SortcomparetimLayer) -> Int { s.size }

pub fn sort_compare_tim_layer_get(s : SortcomparetimLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_compare_tim_layer_set(s : SortcomparetimLayer, i : Int, v : Double) -> SortcomparetimLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_compare_tim_layer_sum(s : SortcomparetimLayer) -> Double { @_common.sum(s.data) }

pub fn sort_compare_tim_layer_mean(s : SortcomparetimLayer) -> Double { @_common.mean(s.data) }

pub fn sort_compare_tim_layer_scale(s : SortcomparetimLayer, f : Double) -> SortcomparetimLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_compare_tim_layer_add(a : SortcomparetimLayer, b : SortcomparetimLayer) -> SortcomparetimLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_compare_tim_layer_copy(s : SortcomparetimLayer) -> SortcomparetimLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_compare_tim_layer_fill(s : SortcomparetimLayer, v : Double) -> SortcomparetimLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_compare_tim_layer_min(s : SortcomparetimLayer) -> Double { @_common.min(s.data) }

pub fn sort_compare_tim_layer_max(s : SortcomparetimLayer) -> Double { @_common.max(s.data) }

pub fn sort_compare_tim_layer_to_string(s : SortcomparetimLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortcomparetimBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_compare_tim_buffer_make(size : Int) -> SortcomparetimBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_compare_tim_buffer_len(s : SortcomparetimBuffer) -> Int { s.size }

pub fn sort_compare_tim_buffer_get(s : SortcomparetimBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_compare_tim_buffer_set(s : SortcomparetimBuffer, i : Int, v : Double) -> SortcomparetimBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_compare_tim_buffer_sum(s : SortcomparetimBuffer) -> Double { @_common.sum(s.data) }

pub fn sort_compare_tim_buffer_mean(s : SortcomparetimBuffer) -> Double { @_common.mean(s.data) }

pub fn sort_compare_tim_buffer_scale(s : SortcomparetimBuffer, f : Double) -> SortcomparetimBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_compare_tim_buffer_add(a : SortcomparetimBuffer, b : SortcomparetimBuffer) -> SortcomparetimBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_compare_tim_buffer_copy(s : SortcomparetimBuffer) -> SortcomparetimBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_compare_tim_buffer_fill(s : SortcomparetimBuffer, v : Double) -> SortcomparetimBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_compare_tim_buffer_min(s : SortcomparetimBuffer) -> Double { @_common.min(s.data) }

pub fn sort_compare_tim_buffer_max(s : SortcomparetimBuffer) -> Double { @_common.max(s.data) }

pub fn sort_compare_tim_buffer_to_string(s : SortcomparetimBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortcomparetimCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_compare_tim_cursor_make(size : Int) -> SortcomparetimCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_compare_tim_cursor_len(s : SortcomparetimCursor) -> Int { s.size }

pub fn sort_compare_tim_cursor_get(s : SortcomparetimCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_compare_tim_cursor_set(s : SortcomparetimCursor, i : Int, v : Double) -> SortcomparetimCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_compare_tim_cursor_sum(s : SortcomparetimCursor) -> Double { @_common.sum(s.data) }

pub fn sort_compare_tim_cursor_mean(s : SortcomparetimCursor) -> Double { @_common.mean(s.data) }

pub fn sort_compare_tim_cursor_scale(s : SortcomparetimCursor, f : Double) -> SortcomparetimCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_compare_tim_cursor_add(a : SortcomparetimCursor, b : SortcomparetimCursor) -> SortcomparetimCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_compare_tim_cursor_copy(s : SortcomparetimCursor) -> SortcomparetimCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_compare_tim_cursor_fill(s : SortcomparetimCursor, v : Double) -> SortcomparetimCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_compare_tim_cursor_min(s : SortcomparetimCursor) -> Double { @_common.min(s.data) }

pub fn sort_compare_tim_cursor_max(s : SortcomparetimCursor) -> Double { @_common.max(s.data) }

pub fn sort_compare_tim_cursor_to_string(s : SortcomparetimCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortcomparetimView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_compare_tim_view_make(size : Int) -> SortcomparetimView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_compare_tim_view_len(s : SortcomparetimView) -> Int { s.size }

pub fn sort_compare_tim_view_get(s : SortcomparetimView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_compare_tim_view_set(s : SortcomparetimView, i : Int, v : Double) -> SortcomparetimView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_compare_tim_view_sum(s : SortcomparetimView) -> Double { @_common.sum(s.data) }

pub fn sort_compare_tim_view_mean(s : SortcomparetimView) -> Double { @_common.mean(s.data) }

pub fn sort_compare_tim_view_scale(s : SortcomparetimView, f : Double) -> SortcomparetimView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_compare_tim_view_add(a : SortcomparetimView, b : SortcomparetimView) -> SortcomparetimView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_compare_tim_view_copy(s : SortcomparetimView) -> SortcomparetimView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_compare_tim_view_fill(s : SortcomparetimView, v : Double) -> SortcomparetimView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_compare_tim_view_min(s : SortcomparetimView) -> Double { @_common.min(s.data) }

pub fn sort_compare_tim_view_max(s : SortcomparetimView) -> Double { @_common.max(s.data) }

pub fn sort_compare_tim_view_to_string(s : SortcomparetimView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortcomparetimRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_compare_tim_range_make(size : Int) -> SortcomparetimRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_compare_tim_range_len(s : SortcomparetimRange) -> Int { s.size }

pub fn sort_compare_tim_range_get(s : SortcomparetimRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_compare_tim_range_set(s : SortcomparetimRange, i : Int, v : Double) -> SortcomparetimRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_compare_tim_range_sum(s : SortcomparetimRange) -> Double { @_common.sum(s.data) }

pub fn sort_compare_tim_range_mean(s : SortcomparetimRange) -> Double { @_common.mean(s.data) }

pub fn sort_compare_tim_range_scale(s : SortcomparetimRange, f : Double) -> SortcomparetimRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_compare_tim_range_add(a : SortcomparetimRange, b : SortcomparetimRange) -> SortcomparetimRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_compare_tim_range_copy(s : SortcomparetimRange) -> SortcomparetimRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_compare_tim_range_fill(s : SortcomparetimRange, v : Double) -> SortcomparetimRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_compare_tim_range_min(s : SortcomparetimRange) -> Double { @_common.min(s.data) }

pub fn sort_compare_tim_range_max(s : SortcomparetimRange) -> Double { @_common.max(s.data) }

pub fn sort_compare_tim_range_to_string(s : SortcomparetimRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortcomparetimSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_compare_tim_slice_make(size : Int) -> SortcomparetimSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_compare_tim_slice_len(s : SortcomparetimSlice) -> Int { s.size }

pub fn sort_compare_tim_slice_get(s : SortcomparetimSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_compare_tim_slice_set(s : SortcomparetimSlice, i : Int, v : Double) -> SortcomparetimSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_compare_tim_slice_sum(s : SortcomparetimSlice) -> Double { @_common.sum(s.data) }

pub fn sort_compare_tim_slice_mean(s : SortcomparetimSlice) -> Double { @_common.mean(s.data) }

pub fn sort_compare_tim_slice_scale(s : SortcomparetimSlice, f : Double) -> SortcomparetimSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_compare_tim_slice_add(a : SortcomparetimSlice, b : SortcomparetimSlice) -> SortcomparetimSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_compare_tim_slice_copy(s : SortcomparetimSlice) -> SortcomparetimSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_compare_tim_slice_fill(s : SortcomparetimSlice, v : Double) -> SortcomparetimSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_compare_tim_slice_min(s : SortcomparetimSlice) -> Double { @_common.min(s.data) }

pub fn sort_compare_tim_slice_max(s : SortcomparetimSlice) -> Double { @_common.max(s.data) }

pub fn sort_compare_tim_slice_to_string(s : SortcomparetimSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

