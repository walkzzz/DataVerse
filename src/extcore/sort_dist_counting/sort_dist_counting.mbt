///===
/// extcore/sort_dist_counting

pub(all) struct SortdistcountingPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn sort_dist_counting_make_point(x : Double, y : Double) -> SortdistcountingPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn sort_dist_counting_make_point3(x : Double, y : Double, z : Double) -> SortdistcountingPoint {
  { x, y, z, label: 0 }
}

pub fn SortdistcountingPoint::x(self : SortdistcountingPoint) -> Double { self.x }

pub fn SortdistcountingPoint::y(self : SortdistcountingPoint) -> Double { self.y }

pub fn SortdistcountingPoint::z(self : SortdistcountingPoint) -> Double { self.z }

pub fn SortdistcountingPoint::label(self : SortdistcountingPoint) -> Int { self.label }

pub fn SortdistcountingPoint::dist(self : SortdistcountingPoint, other : SortdistcountingPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn SortdistcountingPoint::add(self : SortdistcountingPoint, other : SortdistcountingPoint) -> SortdistcountingPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn SortdistcountingPoint::sub(self : SortdistcountingPoint, other : SortdistcountingPoint) -> SortdistcountingPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn SortdistcountingPoint::scale(self : SortdistcountingPoint, s : Double) -> SortdistcountingPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn SortdistcountingPoint::dot(self : SortdistcountingPoint, other : SortdistcountingPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn SortdistcountingPoint::cross(self : SortdistcountingPoint, other : SortdistcountingPoint) -> SortdistcountingPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn SortdistcountingPoint::norm(self : SortdistcountingPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn SortdistcountingPoint::normalize(self : SortdistcountingPoint) -> SortdistcountingPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn SortdistcountingPoint::negate(self : SortdistcountingPoint) -> SortdistcountingPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn SortdistcountingPoint::mid(self : SortdistcountingPoint, other : SortdistcountingPoint) -> SortdistcountingPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn SortdistcountingPoint::lerp(self : SortdistcountingPoint, other : SortdistcountingPoint, t : Double) -> SortdistcountingPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn SortdistcountingPoint::to_string(self : SortdistcountingPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct SortdistcountingSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn sort_dist_counting_make_series(vals : Array[Double], name : String) -> SortdistcountingSeries {
  { vals, name, meta: 0 }
}

pub fn SortdistcountingSeries::len(self : SortdistcountingSeries) -> Int { self.vals.length() }

pub fn SortdistcountingSeries::sum(self : SortdistcountingSeries) -> Double { @_common.sum(self.vals) }

pub fn SortdistcountingSeries::mean(self : SortdistcountingSeries) -> Double { @_common.mean(self.vals) }

pub fn SortdistcountingSeries::min(self : SortdistcountingSeries) -> Double { @_common.min(self.vals) }

pub fn SortdistcountingSeries::max(self : SortdistcountingSeries) -> Double { @_common.max(self.vals) }

pub fn SortdistcountingSeries::range(self : SortdistcountingSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn SortdistcountingSeries::variance(self : SortdistcountingSeries) -> Double { @_common.variance(self.vals) }

pub fn SortdistcountingSeries::std(self : SortdistcountingSeries) -> Double { @_common.std(self.vals) }

pub fn SortdistcountingSeries::median(self : SortdistcountingSeries) -> Double { @_common.median(self.vals) }

pub fn SortdistcountingSeries::scale(self : SortdistcountingSeries, f : Double) -> SortdistcountingSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn SortdistcountingSeries::add(self : SortdistcountingSeries, other : SortdistcountingSeries) -> SortdistcountingSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn SortdistcountingSeries::sub(self : SortdistcountingSeries, other : SortdistcountingSeries) -> SortdistcountingSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn SortdistcountingSeries::normalize(self : SortdistcountingSeries) -> SortdistcountingSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn SortdistcountingSeries::cumsum(self : SortdistcountingSeries) -> SortdistcountingSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn SortdistcountingSeries::to_string(self : SortdistcountingSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct SortdistcountingMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn sort_dist_counting_make_matrix(rows : Int, cols : Int, val : Double) -> SortdistcountingMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn sort_dist_counting_matrix_identity(n : Int) -> SortdistcountingMatrix {
  let m = sort_dist_counting_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn SortdistcountingMatrix::get(self : SortdistcountingMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn SortdistcountingMatrix::transpose(self : SortdistcountingMatrix) -> SortdistcountingMatrix {
  let result = sort_dist_counting_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn SortdistcountingMatrix::add(self : SortdistcountingMatrix, other : SortdistcountingMatrix) -> SortdistcountingMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = sort_dist_counting_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn SortdistcountingMatrix::scale(self : SortdistcountingMatrix, s : Double) -> SortdistcountingMatrix {
  let result = sort_dist_counting_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn SortdistcountingMatrix::multiply(self : SortdistcountingMatrix, other : SortdistcountingMatrix) -> SortdistcountingMatrix {
  if self.cols != other.rows { return sort_dist_counting_make_matrix(self.rows, other.cols, 0.0) }
  let result = sort_dist_counting_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn SortdistcountingMatrix::trace(self : SortdistcountingMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn SortdistcountingMatrix::det(self : SortdistcountingMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn SortdistcountingMatrix::norm(self : SortdistcountingMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn SortdistcountingMatrix::to_string(self : SortdistcountingMatrix) -> String {
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

pub(all) struct SortdistcountingVector {
  comps : Array[Double]
  dim : Int
}

pub fn sort_dist_counting_make_vector(comps : Array[Double]) -> SortdistcountingVector {
  { comps, dim: comps.length() }
}

pub fn sort_dist_counting_vector_zero(dim : Int) -> SortdistcountingVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn SortdistcountingVector::add(self : SortdistcountingVector, other : SortdistcountingVector) -> SortdistcountingVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn SortdistcountingVector::sub(self : SortdistcountingVector, other : SortdistcountingVector) -> SortdistcountingVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn SortdistcountingVector::scale(self : SortdistcountingVector, s : Double) -> SortdistcountingVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn SortdistcountingVector::dot(self : SortdistcountingVector, other : SortdistcountingVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn SortdistcountingVector::norm(self : SortdistcountingVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn SortdistcountingVector::normalize(self : SortdistcountingVector) -> SortdistcountingVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn SortdistcountingVector::dist(self : SortdistcountingVector, other : SortdistcountingVector) -> Double {
  self.sub(other).norm()
}

pub fn SortdistcountingVector::to_string(self : SortdistcountingVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn sort_dist_counting_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn sort_dist_counting_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn sort_dist_counting_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn sort_dist_counting_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn sort_dist_counting_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn sort_dist_counting_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn sort_dist_counting_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn sort_dist_counting_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn sort_dist_counting_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn sort_dist_counting_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn sort_dist_counting_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn sort_dist_counting_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn sort_dist_counting_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn sort_dist_counting_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn sort_dist_counting_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn sort_dist_counting_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn sort_dist_counting_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn sort_dist_counting_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn sort_dist_counting_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn sort_dist_counting_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn sort_dist_counting_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn sort_dist_counting_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn sort_dist_counting_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn sort_dist_counting_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn sort_dist_counting_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn sort_dist_counting_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn sort_dist_counting_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn sort_dist_counting_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn sort_dist_counting_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct SortdistcountingFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_dist_counting_frame_make(size : Int) -> SortdistcountingFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_dist_counting_frame_len(s : SortdistcountingFrame) -> Int { s.size }

pub fn sort_dist_counting_frame_get(s : SortdistcountingFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_dist_counting_frame_set(s : SortdistcountingFrame, i : Int, v : Double) -> SortdistcountingFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_dist_counting_frame_sum(s : SortdistcountingFrame) -> Double { @_common.sum(s.data) }

pub fn sort_dist_counting_frame_mean(s : SortdistcountingFrame) -> Double { @_common.mean(s.data) }

pub fn sort_dist_counting_frame_scale(s : SortdistcountingFrame, f : Double) -> SortdistcountingFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_dist_counting_frame_add(a : SortdistcountingFrame, b : SortdistcountingFrame) -> SortdistcountingFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_dist_counting_frame_copy(s : SortdistcountingFrame) -> SortdistcountingFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_dist_counting_frame_fill(s : SortdistcountingFrame, v : Double) -> SortdistcountingFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_dist_counting_frame_min(s : SortdistcountingFrame) -> Double { @_common.min(s.data) }

pub fn sort_dist_counting_frame_max(s : SortdistcountingFrame) -> Double { @_common.max(s.data) }

pub fn sort_dist_counting_frame_to_string(s : SortdistcountingFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortdistcountingTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_dist_counting_table_make(size : Int) -> SortdistcountingTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_dist_counting_table_len(s : SortdistcountingTable) -> Int { s.size }

pub fn sort_dist_counting_table_get(s : SortdistcountingTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_dist_counting_table_set(s : SortdistcountingTable, i : Int, v : Double) -> SortdistcountingTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_dist_counting_table_sum(s : SortdistcountingTable) -> Double { @_common.sum(s.data) }

pub fn sort_dist_counting_table_mean(s : SortdistcountingTable) -> Double { @_common.mean(s.data) }

pub fn sort_dist_counting_table_scale(s : SortdistcountingTable, f : Double) -> SortdistcountingTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_dist_counting_table_add(a : SortdistcountingTable, b : SortdistcountingTable) -> SortdistcountingTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_dist_counting_table_copy(s : SortdistcountingTable) -> SortdistcountingTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_dist_counting_table_fill(s : SortdistcountingTable, v : Double) -> SortdistcountingTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_dist_counting_table_min(s : SortdistcountingTable) -> Double { @_common.min(s.data) }

pub fn sort_dist_counting_table_max(s : SortdistcountingTable) -> Double { @_common.max(s.data) }

pub fn sort_dist_counting_table_to_string(s : SortdistcountingTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortdistcountingGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_dist_counting_graphn_make(size : Int) -> SortdistcountingGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_dist_counting_graphn_len(s : SortdistcountingGraphN) -> Int { s.size }

pub fn sort_dist_counting_graphn_get(s : SortdistcountingGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_dist_counting_graphn_set(s : SortdistcountingGraphN, i : Int, v : Double) -> SortdistcountingGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_dist_counting_graphn_sum(s : SortdistcountingGraphN) -> Double { @_common.sum(s.data) }

pub fn sort_dist_counting_graphn_mean(s : SortdistcountingGraphN) -> Double { @_common.mean(s.data) }

pub fn sort_dist_counting_graphn_scale(s : SortdistcountingGraphN, f : Double) -> SortdistcountingGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_dist_counting_graphn_add(a : SortdistcountingGraphN, b : SortdistcountingGraphN) -> SortdistcountingGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_dist_counting_graphn_copy(s : SortdistcountingGraphN) -> SortdistcountingGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_dist_counting_graphn_fill(s : SortdistcountingGraphN, v : Double) -> SortdistcountingGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_dist_counting_graphn_min(s : SortdistcountingGraphN) -> Double { @_common.min(s.data) }

pub fn sort_dist_counting_graphn_max(s : SortdistcountingGraphN) -> Double { @_common.max(s.data) }

pub fn sort_dist_counting_graphn_to_string(s : SortdistcountingGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortdistcountingNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_dist_counting_node_make(size : Int) -> SortdistcountingNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_dist_counting_node_len(s : SortdistcountingNode) -> Int { s.size }

pub fn sort_dist_counting_node_get(s : SortdistcountingNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_dist_counting_node_set(s : SortdistcountingNode, i : Int, v : Double) -> SortdistcountingNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_dist_counting_node_sum(s : SortdistcountingNode) -> Double { @_common.sum(s.data) }

pub fn sort_dist_counting_node_mean(s : SortdistcountingNode) -> Double { @_common.mean(s.data) }

pub fn sort_dist_counting_node_scale(s : SortdistcountingNode, f : Double) -> SortdistcountingNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_dist_counting_node_add(a : SortdistcountingNode, b : SortdistcountingNode) -> SortdistcountingNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_dist_counting_node_copy(s : SortdistcountingNode) -> SortdistcountingNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_dist_counting_node_fill(s : SortdistcountingNode, v : Double) -> SortdistcountingNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_dist_counting_node_min(s : SortdistcountingNode) -> Double { @_common.min(s.data) }

pub fn sort_dist_counting_node_max(s : SortdistcountingNode) -> Double { @_common.max(s.data) }

pub fn sort_dist_counting_node_to_string(s : SortdistcountingNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortdistcountingEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_dist_counting_edge_make(size : Int) -> SortdistcountingEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_dist_counting_edge_len(s : SortdistcountingEdge) -> Int { s.size }

pub fn sort_dist_counting_edge_get(s : SortdistcountingEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_dist_counting_edge_set(s : SortdistcountingEdge, i : Int, v : Double) -> SortdistcountingEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_dist_counting_edge_sum(s : SortdistcountingEdge) -> Double { @_common.sum(s.data) }

pub fn sort_dist_counting_edge_mean(s : SortdistcountingEdge) -> Double { @_common.mean(s.data) }

pub fn sort_dist_counting_edge_scale(s : SortdistcountingEdge, f : Double) -> SortdistcountingEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_dist_counting_edge_add(a : SortdistcountingEdge, b : SortdistcountingEdge) -> SortdistcountingEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_dist_counting_edge_copy(s : SortdistcountingEdge) -> SortdistcountingEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_dist_counting_edge_fill(s : SortdistcountingEdge, v : Double) -> SortdistcountingEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_dist_counting_edge_min(s : SortdistcountingEdge) -> Double { @_common.min(s.data) }

pub fn sort_dist_counting_edge_max(s : SortdistcountingEdge) -> Double { @_common.max(s.data) }

pub fn sort_dist_counting_edge_to_string(s : SortdistcountingEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortdistcountingPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_dist_counting_path_make(size : Int) -> SortdistcountingPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_dist_counting_path_len(s : SortdistcountingPath) -> Int { s.size }

pub fn sort_dist_counting_path_get(s : SortdistcountingPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_dist_counting_path_set(s : SortdistcountingPath, i : Int, v : Double) -> SortdistcountingPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_dist_counting_path_sum(s : SortdistcountingPath) -> Double { @_common.sum(s.data) }

pub fn sort_dist_counting_path_mean(s : SortdistcountingPath) -> Double { @_common.mean(s.data) }

pub fn sort_dist_counting_path_scale(s : SortdistcountingPath, f : Double) -> SortdistcountingPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_dist_counting_path_add(a : SortdistcountingPath, b : SortdistcountingPath) -> SortdistcountingPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_dist_counting_path_copy(s : SortdistcountingPath) -> SortdistcountingPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_dist_counting_path_fill(s : SortdistcountingPath, v : Double) -> SortdistcountingPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_dist_counting_path_min(s : SortdistcountingPath) -> Double { @_common.min(s.data) }

pub fn sort_dist_counting_path_max(s : SortdistcountingPath) -> Double { @_common.max(s.data) }

pub fn sort_dist_counting_path_to_string(s : SortdistcountingPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortdistcountingCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_dist_counting_cluster_make(size : Int) -> SortdistcountingCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_dist_counting_cluster_len(s : SortdistcountingCluster) -> Int { s.size }

pub fn sort_dist_counting_cluster_get(s : SortdistcountingCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_dist_counting_cluster_set(s : SortdistcountingCluster, i : Int, v : Double) -> SortdistcountingCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_dist_counting_cluster_sum(s : SortdistcountingCluster) -> Double { @_common.sum(s.data) }

pub fn sort_dist_counting_cluster_mean(s : SortdistcountingCluster) -> Double { @_common.mean(s.data) }

pub fn sort_dist_counting_cluster_scale(s : SortdistcountingCluster, f : Double) -> SortdistcountingCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_dist_counting_cluster_add(a : SortdistcountingCluster, b : SortdistcountingCluster) -> SortdistcountingCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_dist_counting_cluster_copy(s : SortdistcountingCluster) -> SortdistcountingCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_dist_counting_cluster_fill(s : SortdistcountingCluster, v : Double) -> SortdistcountingCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_dist_counting_cluster_min(s : SortdistcountingCluster) -> Double { @_common.min(s.data) }

pub fn sort_dist_counting_cluster_max(s : SortdistcountingCluster) -> Double { @_common.max(s.data) }

pub fn sort_dist_counting_cluster_to_string(s : SortdistcountingCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortdistcountingModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_dist_counting_model_make(size : Int) -> SortdistcountingModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_dist_counting_model_len(s : SortdistcountingModel) -> Int { s.size }

pub fn sort_dist_counting_model_get(s : SortdistcountingModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_dist_counting_model_set(s : SortdistcountingModel, i : Int, v : Double) -> SortdistcountingModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_dist_counting_model_sum(s : SortdistcountingModel) -> Double { @_common.sum(s.data) }

pub fn sort_dist_counting_model_mean(s : SortdistcountingModel) -> Double { @_common.mean(s.data) }

pub fn sort_dist_counting_model_scale(s : SortdistcountingModel, f : Double) -> SortdistcountingModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_dist_counting_model_add(a : SortdistcountingModel, b : SortdistcountingModel) -> SortdistcountingModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_dist_counting_model_copy(s : SortdistcountingModel) -> SortdistcountingModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_dist_counting_model_fill(s : SortdistcountingModel, v : Double) -> SortdistcountingModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_dist_counting_model_min(s : SortdistcountingModel) -> Double { @_common.min(s.data) }

pub fn sort_dist_counting_model_max(s : SortdistcountingModel) -> Double { @_common.max(s.data) }

pub fn sort_dist_counting_model_to_string(s : SortdistcountingModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortdistcountingLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_dist_counting_layer_make(size : Int) -> SortdistcountingLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_dist_counting_layer_len(s : SortdistcountingLayer) -> Int { s.size }

pub fn sort_dist_counting_layer_get(s : SortdistcountingLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_dist_counting_layer_set(s : SortdistcountingLayer, i : Int, v : Double) -> SortdistcountingLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_dist_counting_layer_sum(s : SortdistcountingLayer) -> Double { @_common.sum(s.data) }

pub fn sort_dist_counting_layer_mean(s : SortdistcountingLayer) -> Double { @_common.mean(s.data) }

pub fn sort_dist_counting_layer_scale(s : SortdistcountingLayer, f : Double) -> SortdistcountingLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_dist_counting_layer_add(a : SortdistcountingLayer, b : SortdistcountingLayer) -> SortdistcountingLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_dist_counting_layer_copy(s : SortdistcountingLayer) -> SortdistcountingLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_dist_counting_layer_fill(s : SortdistcountingLayer, v : Double) -> SortdistcountingLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_dist_counting_layer_min(s : SortdistcountingLayer) -> Double { @_common.min(s.data) }

pub fn sort_dist_counting_layer_max(s : SortdistcountingLayer) -> Double { @_common.max(s.data) }

pub fn sort_dist_counting_layer_to_string(s : SortdistcountingLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortdistcountingBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_dist_counting_buffer_make(size : Int) -> SortdistcountingBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_dist_counting_buffer_len(s : SortdistcountingBuffer) -> Int { s.size }

pub fn sort_dist_counting_buffer_get(s : SortdistcountingBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_dist_counting_buffer_set(s : SortdistcountingBuffer, i : Int, v : Double) -> SortdistcountingBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_dist_counting_buffer_sum(s : SortdistcountingBuffer) -> Double { @_common.sum(s.data) }

pub fn sort_dist_counting_buffer_mean(s : SortdistcountingBuffer) -> Double { @_common.mean(s.data) }

pub fn sort_dist_counting_buffer_scale(s : SortdistcountingBuffer, f : Double) -> SortdistcountingBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_dist_counting_buffer_add(a : SortdistcountingBuffer, b : SortdistcountingBuffer) -> SortdistcountingBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_dist_counting_buffer_copy(s : SortdistcountingBuffer) -> SortdistcountingBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_dist_counting_buffer_fill(s : SortdistcountingBuffer, v : Double) -> SortdistcountingBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_dist_counting_buffer_min(s : SortdistcountingBuffer) -> Double { @_common.min(s.data) }

pub fn sort_dist_counting_buffer_max(s : SortdistcountingBuffer) -> Double { @_common.max(s.data) }

pub fn sort_dist_counting_buffer_to_string(s : SortdistcountingBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortdistcountingCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_dist_counting_cursor_make(size : Int) -> SortdistcountingCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_dist_counting_cursor_len(s : SortdistcountingCursor) -> Int { s.size }

pub fn sort_dist_counting_cursor_get(s : SortdistcountingCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_dist_counting_cursor_set(s : SortdistcountingCursor, i : Int, v : Double) -> SortdistcountingCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_dist_counting_cursor_sum(s : SortdistcountingCursor) -> Double { @_common.sum(s.data) }

pub fn sort_dist_counting_cursor_mean(s : SortdistcountingCursor) -> Double { @_common.mean(s.data) }

pub fn sort_dist_counting_cursor_scale(s : SortdistcountingCursor, f : Double) -> SortdistcountingCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_dist_counting_cursor_add(a : SortdistcountingCursor, b : SortdistcountingCursor) -> SortdistcountingCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_dist_counting_cursor_copy(s : SortdistcountingCursor) -> SortdistcountingCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_dist_counting_cursor_fill(s : SortdistcountingCursor, v : Double) -> SortdistcountingCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_dist_counting_cursor_min(s : SortdistcountingCursor) -> Double { @_common.min(s.data) }

pub fn sort_dist_counting_cursor_max(s : SortdistcountingCursor) -> Double { @_common.max(s.data) }

pub fn sort_dist_counting_cursor_to_string(s : SortdistcountingCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortdistcountingView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_dist_counting_view_make(size : Int) -> SortdistcountingView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_dist_counting_view_len(s : SortdistcountingView) -> Int { s.size }

pub fn sort_dist_counting_view_get(s : SortdistcountingView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_dist_counting_view_set(s : SortdistcountingView, i : Int, v : Double) -> SortdistcountingView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_dist_counting_view_sum(s : SortdistcountingView) -> Double { @_common.sum(s.data) }

pub fn sort_dist_counting_view_mean(s : SortdistcountingView) -> Double { @_common.mean(s.data) }

pub fn sort_dist_counting_view_scale(s : SortdistcountingView, f : Double) -> SortdistcountingView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_dist_counting_view_add(a : SortdistcountingView, b : SortdistcountingView) -> SortdistcountingView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_dist_counting_view_copy(s : SortdistcountingView) -> SortdistcountingView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_dist_counting_view_fill(s : SortdistcountingView, v : Double) -> SortdistcountingView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_dist_counting_view_min(s : SortdistcountingView) -> Double { @_common.min(s.data) }

pub fn sort_dist_counting_view_max(s : SortdistcountingView) -> Double { @_common.max(s.data) }

pub fn sort_dist_counting_view_to_string(s : SortdistcountingView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortdistcountingRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_dist_counting_range_make(size : Int) -> SortdistcountingRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_dist_counting_range_len(s : SortdistcountingRange) -> Int { s.size }

pub fn sort_dist_counting_range_get(s : SortdistcountingRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_dist_counting_range_set(s : SortdistcountingRange, i : Int, v : Double) -> SortdistcountingRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_dist_counting_range_sum(s : SortdistcountingRange) -> Double { @_common.sum(s.data) }

pub fn sort_dist_counting_range_mean(s : SortdistcountingRange) -> Double { @_common.mean(s.data) }

pub fn sort_dist_counting_range_scale(s : SortdistcountingRange, f : Double) -> SortdistcountingRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_dist_counting_range_add(a : SortdistcountingRange, b : SortdistcountingRange) -> SortdistcountingRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_dist_counting_range_copy(s : SortdistcountingRange) -> SortdistcountingRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_dist_counting_range_fill(s : SortdistcountingRange, v : Double) -> SortdistcountingRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_dist_counting_range_min(s : SortdistcountingRange) -> Double { @_common.min(s.data) }

pub fn sort_dist_counting_range_max(s : SortdistcountingRange) -> Double { @_common.max(s.data) }

pub fn sort_dist_counting_range_to_string(s : SortdistcountingRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortdistcountingSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_dist_counting_slice_make(size : Int) -> SortdistcountingSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_dist_counting_slice_len(s : SortdistcountingSlice) -> Int { s.size }

pub fn sort_dist_counting_slice_get(s : SortdistcountingSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_dist_counting_slice_set(s : SortdistcountingSlice, i : Int, v : Double) -> SortdistcountingSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_dist_counting_slice_sum(s : SortdistcountingSlice) -> Double { @_common.sum(s.data) }

pub fn sort_dist_counting_slice_mean(s : SortdistcountingSlice) -> Double { @_common.mean(s.data) }

pub fn sort_dist_counting_slice_scale(s : SortdistcountingSlice, f : Double) -> SortdistcountingSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_dist_counting_slice_add(a : SortdistcountingSlice, b : SortdistcountingSlice) -> SortdistcountingSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_dist_counting_slice_copy(s : SortdistcountingSlice) -> SortdistcountingSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_dist_counting_slice_fill(s : SortdistcountingSlice, v : Double) -> SortdistcountingSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_dist_counting_slice_min(s : SortdistcountingSlice) -> Double { @_common.min(s.data) }

pub fn sort_dist_counting_slice_max(s : SortdistcountingSlice) -> Double { @_common.max(s.data) }

pub fn sort_dist_counting_slice_to_string(s : SortdistcountingSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

