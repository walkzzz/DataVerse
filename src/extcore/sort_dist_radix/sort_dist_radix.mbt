///===
/// extcore/sort_dist_radix

pub(all) struct SortdistradixPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn sort_dist_radix_make_point(x : Double, y : Double) -> SortdistradixPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn sort_dist_radix_make_point3(x : Double, y : Double, z : Double) -> SortdistradixPoint {
  { x, y, z, label: 0 }
}

pub fn SortdistradixPoint::x(self : SortdistradixPoint) -> Double { self.x }

pub fn SortdistradixPoint::y(self : SortdistradixPoint) -> Double { self.y }

pub fn SortdistradixPoint::z(self : SortdistradixPoint) -> Double { self.z }

pub fn SortdistradixPoint::label(self : SortdistradixPoint) -> Int { self.label }

pub fn SortdistradixPoint::dist(self : SortdistradixPoint, other : SortdistradixPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn SortdistradixPoint::add(self : SortdistradixPoint, other : SortdistradixPoint) -> SortdistradixPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn SortdistradixPoint::sub(self : SortdistradixPoint, other : SortdistradixPoint) -> SortdistradixPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn SortdistradixPoint::scale(self : SortdistradixPoint, s : Double) -> SortdistradixPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn SortdistradixPoint::dot(self : SortdistradixPoint, other : SortdistradixPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn SortdistradixPoint::cross(self : SortdistradixPoint, other : SortdistradixPoint) -> SortdistradixPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn SortdistradixPoint::norm(self : SortdistradixPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn SortdistradixPoint::normalize(self : SortdistradixPoint) -> SortdistradixPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn SortdistradixPoint::negate(self : SortdistradixPoint) -> SortdistradixPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn SortdistradixPoint::mid(self : SortdistradixPoint, other : SortdistradixPoint) -> SortdistradixPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn SortdistradixPoint::lerp(self : SortdistradixPoint, other : SortdistradixPoint, t : Double) -> SortdistradixPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn SortdistradixPoint::to_string(self : SortdistradixPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct SortdistradixSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn sort_dist_radix_make_series(vals : Array[Double], name : String) -> SortdistradixSeries {
  { vals, name, meta: 0 }
}

pub fn SortdistradixSeries::len(self : SortdistradixSeries) -> Int { self.vals.length() }

pub fn SortdistradixSeries::sum(self : SortdistradixSeries) -> Double { @_common.sum(self.vals) }

pub fn SortdistradixSeries::mean(self : SortdistradixSeries) -> Double { @_common.mean(self.vals) }

pub fn SortdistradixSeries::min(self : SortdistradixSeries) -> Double { @_common.min(self.vals) }

pub fn SortdistradixSeries::max(self : SortdistradixSeries) -> Double { @_common.max(self.vals) }

pub fn SortdistradixSeries::range(self : SortdistradixSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn SortdistradixSeries::variance(self : SortdistradixSeries) -> Double { @_common.variance(self.vals) }

pub fn SortdistradixSeries::std(self : SortdistradixSeries) -> Double { @_common.std(self.vals) }

pub fn SortdistradixSeries::median(self : SortdistradixSeries) -> Double { @_common.median(self.vals) }

pub fn SortdistradixSeries::scale(self : SortdistradixSeries, f : Double) -> SortdistradixSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn SortdistradixSeries::add(self : SortdistradixSeries, other : SortdistradixSeries) -> SortdistradixSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn SortdistradixSeries::sub(self : SortdistradixSeries, other : SortdistradixSeries) -> SortdistradixSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn SortdistradixSeries::normalize(self : SortdistradixSeries) -> SortdistradixSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn SortdistradixSeries::cumsum(self : SortdistradixSeries) -> SortdistradixSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn SortdistradixSeries::to_string(self : SortdistradixSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct SortdistradixMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn sort_dist_radix_make_matrix(rows : Int, cols : Int, val : Double) -> SortdistradixMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn sort_dist_radix_matrix_identity(n : Int) -> SortdistradixMatrix {
  let m = sort_dist_radix_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn SortdistradixMatrix::get(self : SortdistradixMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn SortdistradixMatrix::transpose(self : SortdistradixMatrix) -> SortdistradixMatrix {
  let result = sort_dist_radix_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn SortdistradixMatrix::add(self : SortdistradixMatrix, other : SortdistradixMatrix) -> SortdistradixMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = sort_dist_radix_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn SortdistradixMatrix::scale(self : SortdistradixMatrix, s : Double) -> SortdistradixMatrix {
  let result = sort_dist_radix_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn SortdistradixMatrix::multiply(self : SortdistradixMatrix, other : SortdistradixMatrix) -> SortdistradixMatrix {
  if self.cols != other.rows { return sort_dist_radix_make_matrix(self.rows, other.cols, 0.0) }
  let result = sort_dist_radix_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn SortdistradixMatrix::trace(self : SortdistradixMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn SortdistradixMatrix::det(self : SortdistradixMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn SortdistradixMatrix::norm(self : SortdistradixMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn SortdistradixMatrix::to_string(self : SortdistradixMatrix) -> String {
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

pub(all) struct SortdistradixVector {
  comps : Array[Double]
  dim : Int
}

pub fn sort_dist_radix_make_vector(comps : Array[Double]) -> SortdistradixVector {
  { comps, dim: comps.length() }
}

pub fn sort_dist_radix_vector_zero(dim : Int) -> SortdistradixVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn SortdistradixVector::add(self : SortdistradixVector, other : SortdistradixVector) -> SortdistradixVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn SortdistradixVector::sub(self : SortdistradixVector, other : SortdistradixVector) -> SortdistradixVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn SortdistradixVector::scale(self : SortdistradixVector, s : Double) -> SortdistradixVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn SortdistradixVector::dot(self : SortdistradixVector, other : SortdistradixVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn SortdistradixVector::norm(self : SortdistradixVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn SortdistradixVector::normalize(self : SortdistradixVector) -> SortdistradixVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn SortdistradixVector::dist(self : SortdistradixVector, other : SortdistradixVector) -> Double {
  self.sub(other).norm()
}

pub fn SortdistradixVector::to_string(self : SortdistradixVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn sort_dist_radix_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn sort_dist_radix_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn sort_dist_radix_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn sort_dist_radix_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn sort_dist_radix_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn sort_dist_radix_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn sort_dist_radix_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn sort_dist_radix_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn sort_dist_radix_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn sort_dist_radix_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn sort_dist_radix_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn sort_dist_radix_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn sort_dist_radix_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn sort_dist_radix_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn sort_dist_radix_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn sort_dist_radix_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn sort_dist_radix_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn sort_dist_radix_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn sort_dist_radix_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn sort_dist_radix_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn sort_dist_radix_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn sort_dist_radix_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn sort_dist_radix_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn sort_dist_radix_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn sort_dist_radix_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn sort_dist_radix_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn sort_dist_radix_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn sort_dist_radix_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn sort_dist_radix_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct SortdistradixFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_dist_radix_frame_make(size : Int) -> SortdistradixFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_dist_radix_frame_len(s : SortdistradixFrame) -> Int { s.size }

pub fn sort_dist_radix_frame_get(s : SortdistradixFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_dist_radix_frame_set(s : SortdistradixFrame, i : Int, v : Double) -> SortdistradixFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_dist_radix_frame_sum(s : SortdistradixFrame) -> Double { @_common.sum(s.data) }

pub fn sort_dist_radix_frame_mean(s : SortdistradixFrame) -> Double { @_common.mean(s.data) }

pub fn sort_dist_radix_frame_scale(s : SortdistradixFrame, f : Double) -> SortdistradixFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_dist_radix_frame_add(a : SortdistradixFrame, b : SortdistradixFrame) -> SortdistradixFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_dist_radix_frame_copy(s : SortdistradixFrame) -> SortdistradixFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_dist_radix_frame_fill(s : SortdistradixFrame, v : Double) -> SortdistradixFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_dist_radix_frame_min(s : SortdistradixFrame) -> Double { @_common.min(s.data) }

pub fn sort_dist_radix_frame_max(s : SortdistradixFrame) -> Double { @_common.max(s.data) }

pub fn sort_dist_radix_frame_to_string(s : SortdistradixFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortdistradixTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_dist_radix_table_make(size : Int) -> SortdistradixTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_dist_radix_table_len(s : SortdistradixTable) -> Int { s.size }

pub fn sort_dist_radix_table_get(s : SortdistradixTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_dist_radix_table_set(s : SortdistradixTable, i : Int, v : Double) -> SortdistradixTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_dist_radix_table_sum(s : SortdistradixTable) -> Double { @_common.sum(s.data) }

pub fn sort_dist_radix_table_mean(s : SortdistradixTable) -> Double { @_common.mean(s.data) }

pub fn sort_dist_radix_table_scale(s : SortdistradixTable, f : Double) -> SortdistradixTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_dist_radix_table_add(a : SortdistradixTable, b : SortdistradixTable) -> SortdistradixTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_dist_radix_table_copy(s : SortdistradixTable) -> SortdistradixTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_dist_radix_table_fill(s : SortdistradixTable, v : Double) -> SortdistradixTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_dist_radix_table_min(s : SortdistradixTable) -> Double { @_common.min(s.data) }

pub fn sort_dist_radix_table_max(s : SortdistradixTable) -> Double { @_common.max(s.data) }

pub fn sort_dist_radix_table_to_string(s : SortdistradixTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortdistradixGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_dist_radix_graphn_make(size : Int) -> SortdistradixGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_dist_radix_graphn_len(s : SortdistradixGraphN) -> Int { s.size }

pub fn sort_dist_radix_graphn_get(s : SortdistradixGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_dist_radix_graphn_set(s : SortdistradixGraphN, i : Int, v : Double) -> SortdistradixGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_dist_radix_graphn_sum(s : SortdistradixGraphN) -> Double { @_common.sum(s.data) }

pub fn sort_dist_radix_graphn_mean(s : SortdistradixGraphN) -> Double { @_common.mean(s.data) }

pub fn sort_dist_radix_graphn_scale(s : SortdistradixGraphN, f : Double) -> SortdistradixGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_dist_radix_graphn_add(a : SortdistradixGraphN, b : SortdistradixGraphN) -> SortdistradixGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_dist_radix_graphn_copy(s : SortdistradixGraphN) -> SortdistradixGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_dist_radix_graphn_fill(s : SortdistradixGraphN, v : Double) -> SortdistradixGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_dist_radix_graphn_min(s : SortdistradixGraphN) -> Double { @_common.min(s.data) }

pub fn sort_dist_radix_graphn_max(s : SortdistradixGraphN) -> Double { @_common.max(s.data) }

pub fn sort_dist_radix_graphn_to_string(s : SortdistradixGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortdistradixNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_dist_radix_node_make(size : Int) -> SortdistradixNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_dist_radix_node_len(s : SortdistradixNode) -> Int { s.size }

pub fn sort_dist_radix_node_get(s : SortdistradixNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_dist_radix_node_set(s : SortdistradixNode, i : Int, v : Double) -> SortdistradixNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_dist_radix_node_sum(s : SortdistradixNode) -> Double { @_common.sum(s.data) }

pub fn sort_dist_radix_node_mean(s : SortdistradixNode) -> Double { @_common.mean(s.data) }

pub fn sort_dist_radix_node_scale(s : SortdistradixNode, f : Double) -> SortdistradixNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_dist_radix_node_add(a : SortdistradixNode, b : SortdistradixNode) -> SortdistradixNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_dist_radix_node_copy(s : SortdistradixNode) -> SortdistradixNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_dist_radix_node_fill(s : SortdistradixNode, v : Double) -> SortdistradixNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_dist_radix_node_min(s : SortdistradixNode) -> Double { @_common.min(s.data) }

pub fn sort_dist_radix_node_max(s : SortdistradixNode) -> Double { @_common.max(s.data) }

pub fn sort_dist_radix_node_to_string(s : SortdistradixNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortdistradixEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_dist_radix_edge_make(size : Int) -> SortdistradixEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_dist_radix_edge_len(s : SortdistradixEdge) -> Int { s.size }

pub fn sort_dist_radix_edge_get(s : SortdistradixEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_dist_radix_edge_set(s : SortdistradixEdge, i : Int, v : Double) -> SortdistradixEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_dist_radix_edge_sum(s : SortdistradixEdge) -> Double { @_common.sum(s.data) }

pub fn sort_dist_radix_edge_mean(s : SortdistradixEdge) -> Double { @_common.mean(s.data) }

pub fn sort_dist_radix_edge_scale(s : SortdistradixEdge, f : Double) -> SortdistradixEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_dist_radix_edge_add(a : SortdistradixEdge, b : SortdistradixEdge) -> SortdistradixEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_dist_radix_edge_copy(s : SortdistradixEdge) -> SortdistradixEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_dist_radix_edge_fill(s : SortdistradixEdge, v : Double) -> SortdistradixEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_dist_radix_edge_min(s : SortdistradixEdge) -> Double { @_common.min(s.data) }

pub fn sort_dist_radix_edge_max(s : SortdistradixEdge) -> Double { @_common.max(s.data) }

pub fn sort_dist_radix_edge_to_string(s : SortdistradixEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortdistradixPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_dist_radix_path_make(size : Int) -> SortdistradixPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_dist_radix_path_len(s : SortdistradixPath) -> Int { s.size }

pub fn sort_dist_radix_path_get(s : SortdistradixPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_dist_radix_path_set(s : SortdistradixPath, i : Int, v : Double) -> SortdistradixPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_dist_radix_path_sum(s : SortdistradixPath) -> Double { @_common.sum(s.data) }

pub fn sort_dist_radix_path_mean(s : SortdistradixPath) -> Double { @_common.mean(s.data) }

pub fn sort_dist_radix_path_scale(s : SortdistradixPath, f : Double) -> SortdistradixPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_dist_radix_path_add(a : SortdistradixPath, b : SortdistradixPath) -> SortdistradixPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_dist_radix_path_copy(s : SortdistradixPath) -> SortdistradixPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_dist_radix_path_fill(s : SortdistradixPath, v : Double) -> SortdistradixPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_dist_radix_path_min(s : SortdistradixPath) -> Double { @_common.min(s.data) }

pub fn sort_dist_radix_path_max(s : SortdistradixPath) -> Double { @_common.max(s.data) }

pub fn sort_dist_radix_path_to_string(s : SortdistradixPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortdistradixCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_dist_radix_cluster_make(size : Int) -> SortdistradixCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_dist_radix_cluster_len(s : SortdistradixCluster) -> Int { s.size }

pub fn sort_dist_radix_cluster_get(s : SortdistradixCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_dist_radix_cluster_set(s : SortdistradixCluster, i : Int, v : Double) -> SortdistradixCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_dist_radix_cluster_sum(s : SortdistradixCluster) -> Double { @_common.sum(s.data) }

pub fn sort_dist_radix_cluster_mean(s : SortdistradixCluster) -> Double { @_common.mean(s.data) }

pub fn sort_dist_radix_cluster_scale(s : SortdistradixCluster, f : Double) -> SortdistradixCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_dist_radix_cluster_add(a : SortdistradixCluster, b : SortdistradixCluster) -> SortdistradixCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_dist_radix_cluster_copy(s : SortdistradixCluster) -> SortdistradixCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_dist_radix_cluster_fill(s : SortdistradixCluster, v : Double) -> SortdistradixCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_dist_radix_cluster_min(s : SortdistradixCluster) -> Double { @_common.min(s.data) }

pub fn sort_dist_radix_cluster_max(s : SortdistradixCluster) -> Double { @_common.max(s.data) }

pub fn sort_dist_radix_cluster_to_string(s : SortdistradixCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortdistradixModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_dist_radix_model_make(size : Int) -> SortdistradixModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_dist_radix_model_len(s : SortdistradixModel) -> Int { s.size }

pub fn sort_dist_radix_model_get(s : SortdistradixModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_dist_radix_model_set(s : SortdistradixModel, i : Int, v : Double) -> SortdistradixModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_dist_radix_model_sum(s : SortdistradixModel) -> Double { @_common.sum(s.data) }

pub fn sort_dist_radix_model_mean(s : SortdistradixModel) -> Double { @_common.mean(s.data) }

pub fn sort_dist_radix_model_scale(s : SortdistradixModel, f : Double) -> SortdistradixModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_dist_radix_model_add(a : SortdistradixModel, b : SortdistradixModel) -> SortdistradixModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_dist_radix_model_copy(s : SortdistradixModel) -> SortdistradixModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_dist_radix_model_fill(s : SortdistradixModel, v : Double) -> SortdistradixModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_dist_radix_model_min(s : SortdistradixModel) -> Double { @_common.min(s.data) }

pub fn sort_dist_radix_model_max(s : SortdistradixModel) -> Double { @_common.max(s.data) }

pub fn sort_dist_radix_model_to_string(s : SortdistradixModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortdistradixLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_dist_radix_layer_make(size : Int) -> SortdistradixLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_dist_radix_layer_len(s : SortdistradixLayer) -> Int { s.size }

pub fn sort_dist_radix_layer_get(s : SortdistradixLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_dist_radix_layer_set(s : SortdistradixLayer, i : Int, v : Double) -> SortdistradixLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_dist_radix_layer_sum(s : SortdistradixLayer) -> Double { @_common.sum(s.data) }

pub fn sort_dist_radix_layer_mean(s : SortdistradixLayer) -> Double { @_common.mean(s.data) }

pub fn sort_dist_radix_layer_scale(s : SortdistradixLayer, f : Double) -> SortdistradixLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_dist_radix_layer_add(a : SortdistradixLayer, b : SortdistradixLayer) -> SortdistradixLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_dist_radix_layer_copy(s : SortdistradixLayer) -> SortdistradixLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_dist_radix_layer_fill(s : SortdistradixLayer, v : Double) -> SortdistradixLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_dist_radix_layer_min(s : SortdistradixLayer) -> Double { @_common.min(s.data) }

pub fn sort_dist_radix_layer_max(s : SortdistradixLayer) -> Double { @_common.max(s.data) }

pub fn sort_dist_radix_layer_to_string(s : SortdistradixLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortdistradixBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_dist_radix_buffer_make(size : Int) -> SortdistradixBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_dist_radix_buffer_len(s : SortdistradixBuffer) -> Int { s.size }

pub fn sort_dist_radix_buffer_get(s : SortdistradixBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_dist_radix_buffer_set(s : SortdistradixBuffer, i : Int, v : Double) -> SortdistradixBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_dist_radix_buffer_sum(s : SortdistradixBuffer) -> Double { @_common.sum(s.data) }

pub fn sort_dist_radix_buffer_mean(s : SortdistradixBuffer) -> Double { @_common.mean(s.data) }

pub fn sort_dist_radix_buffer_scale(s : SortdistradixBuffer, f : Double) -> SortdistradixBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_dist_radix_buffer_add(a : SortdistradixBuffer, b : SortdistradixBuffer) -> SortdistradixBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_dist_radix_buffer_copy(s : SortdistradixBuffer) -> SortdistradixBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_dist_radix_buffer_fill(s : SortdistradixBuffer, v : Double) -> SortdistradixBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_dist_radix_buffer_min(s : SortdistradixBuffer) -> Double { @_common.min(s.data) }

pub fn sort_dist_radix_buffer_max(s : SortdistradixBuffer) -> Double { @_common.max(s.data) }

pub fn sort_dist_radix_buffer_to_string(s : SortdistradixBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortdistradixCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_dist_radix_cursor_make(size : Int) -> SortdistradixCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_dist_radix_cursor_len(s : SortdistradixCursor) -> Int { s.size }

pub fn sort_dist_radix_cursor_get(s : SortdistradixCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_dist_radix_cursor_set(s : SortdistradixCursor, i : Int, v : Double) -> SortdistradixCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_dist_radix_cursor_sum(s : SortdistradixCursor) -> Double { @_common.sum(s.data) }

pub fn sort_dist_radix_cursor_mean(s : SortdistradixCursor) -> Double { @_common.mean(s.data) }

pub fn sort_dist_radix_cursor_scale(s : SortdistradixCursor, f : Double) -> SortdistradixCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_dist_radix_cursor_add(a : SortdistradixCursor, b : SortdistradixCursor) -> SortdistradixCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_dist_radix_cursor_copy(s : SortdistradixCursor) -> SortdistradixCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_dist_radix_cursor_fill(s : SortdistradixCursor, v : Double) -> SortdistradixCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_dist_radix_cursor_min(s : SortdistradixCursor) -> Double { @_common.min(s.data) }

pub fn sort_dist_radix_cursor_max(s : SortdistradixCursor) -> Double { @_common.max(s.data) }

pub fn sort_dist_radix_cursor_to_string(s : SortdistradixCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortdistradixView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_dist_radix_view_make(size : Int) -> SortdistradixView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_dist_radix_view_len(s : SortdistradixView) -> Int { s.size }

pub fn sort_dist_radix_view_get(s : SortdistradixView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_dist_radix_view_set(s : SortdistradixView, i : Int, v : Double) -> SortdistradixView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_dist_radix_view_sum(s : SortdistradixView) -> Double { @_common.sum(s.data) }

pub fn sort_dist_radix_view_mean(s : SortdistradixView) -> Double { @_common.mean(s.data) }

pub fn sort_dist_radix_view_scale(s : SortdistradixView, f : Double) -> SortdistradixView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_dist_radix_view_add(a : SortdistradixView, b : SortdistradixView) -> SortdistradixView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_dist_radix_view_copy(s : SortdistradixView) -> SortdistradixView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_dist_radix_view_fill(s : SortdistradixView, v : Double) -> SortdistradixView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_dist_radix_view_min(s : SortdistradixView) -> Double { @_common.min(s.data) }

pub fn sort_dist_radix_view_max(s : SortdistradixView) -> Double { @_common.max(s.data) }

pub fn sort_dist_radix_view_to_string(s : SortdistradixView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortdistradixRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_dist_radix_range_make(size : Int) -> SortdistradixRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_dist_radix_range_len(s : SortdistradixRange) -> Int { s.size }

pub fn sort_dist_radix_range_get(s : SortdistradixRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_dist_radix_range_set(s : SortdistradixRange, i : Int, v : Double) -> SortdistradixRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_dist_radix_range_sum(s : SortdistradixRange) -> Double { @_common.sum(s.data) }

pub fn sort_dist_radix_range_mean(s : SortdistradixRange) -> Double { @_common.mean(s.data) }

pub fn sort_dist_radix_range_scale(s : SortdistradixRange, f : Double) -> SortdistradixRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_dist_radix_range_add(a : SortdistradixRange, b : SortdistradixRange) -> SortdistradixRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_dist_radix_range_copy(s : SortdistradixRange) -> SortdistradixRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_dist_radix_range_fill(s : SortdistradixRange, v : Double) -> SortdistradixRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_dist_radix_range_min(s : SortdistradixRange) -> Double { @_common.min(s.data) }

pub fn sort_dist_radix_range_max(s : SortdistradixRange) -> Double { @_common.max(s.data) }

pub fn sort_dist_radix_range_to_string(s : SortdistradixRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortdistradixSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_dist_radix_slice_make(size : Int) -> SortdistradixSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_dist_radix_slice_len(s : SortdistradixSlice) -> Int { s.size }

pub fn sort_dist_radix_slice_get(s : SortdistradixSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_dist_radix_slice_set(s : SortdistradixSlice, i : Int, v : Double) -> SortdistradixSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_dist_radix_slice_sum(s : SortdistradixSlice) -> Double { @_common.sum(s.data) }

pub fn sort_dist_radix_slice_mean(s : SortdistradixSlice) -> Double { @_common.mean(s.data) }

pub fn sort_dist_radix_slice_scale(s : SortdistradixSlice, f : Double) -> SortdistradixSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_dist_radix_slice_add(a : SortdistradixSlice, b : SortdistradixSlice) -> SortdistradixSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_dist_radix_slice_copy(s : SortdistradixSlice) -> SortdistradixSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_dist_radix_slice_fill(s : SortdistradixSlice, v : Double) -> SortdistradixSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_dist_radix_slice_min(s : SortdistradixSlice) -> Double { @_common.min(s.data) }

pub fn sort_dist_radix_slice_max(s : SortdistradixSlice) -> Double { @_common.max(s.data) }

pub fn sort_dist_radix_slice_to_string(s : SortdistradixSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

