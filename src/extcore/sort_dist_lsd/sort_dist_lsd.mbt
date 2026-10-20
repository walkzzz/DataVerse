///===
/// extcore/sort_dist_lsd

pub(all) struct SortdistlsdPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn sort_dist_lsd_make_point(x : Double, y : Double) -> SortdistlsdPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn sort_dist_lsd_make_point3(x : Double, y : Double, z : Double) -> SortdistlsdPoint {
  { x, y, z, label: 0 }
}

pub fn SortdistlsdPoint::x(self : SortdistlsdPoint) -> Double { self.x }

pub fn SortdistlsdPoint::y(self : SortdistlsdPoint) -> Double { self.y }

pub fn SortdistlsdPoint::z(self : SortdistlsdPoint) -> Double { self.z }

pub fn SortdistlsdPoint::label(self : SortdistlsdPoint) -> Int { self.label }

pub fn SortdistlsdPoint::dist(self : SortdistlsdPoint, other : SortdistlsdPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn SortdistlsdPoint::add(self : SortdistlsdPoint, other : SortdistlsdPoint) -> SortdistlsdPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn SortdistlsdPoint::sub(self : SortdistlsdPoint, other : SortdistlsdPoint) -> SortdistlsdPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn SortdistlsdPoint::scale(self : SortdistlsdPoint, s : Double) -> SortdistlsdPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn SortdistlsdPoint::dot(self : SortdistlsdPoint, other : SortdistlsdPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn SortdistlsdPoint::cross(self : SortdistlsdPoint, other : SortdistlsdPoint) -> SortdistlsdPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn SortdistlsdPoint::norm(self : SortdistlsdPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn SortdistlsdPoint::normalize(self : SortdistlsdPoint) -> SortdistlsdPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn SortdistlsdPoint::negate(self : SortdistlsdPoint) -> SortdistlsdPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn SortdistlsdPoint::mid(self : SortdistlsdPoint, other : SortdistlsdPoint) -> SortdistlsdPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn SortdistlsdPoint::lerp(self : SortdistlsdPoint, other : SortdistlsdPoint, t : Double) -> SortdistlsdPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn SortdistlsdPoint::to_string(self : SortdistlsdPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct SortdistlsdSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn sort_dist_lsd_make_series(vals : Array[Double], name : String) -> SortdistlsdSeries {
  { vals, name, meta: 0 }
}

pub fn SortdistlsdSeries::len(self : SortdistlsdSeries) -> Int { self.vals.length() }

pub fn SortdistlsdSeries::sum(self : SortdistlsdSeries) -> Double { @_common.sum(self.vals) }

pub fn SortdistlsdSeries::mean(self : SortdistlsdSeries) -> Double { @_common.mean(self.vals) }

pub fn SortdistlsdSeries::min(self : SortdistlsdSeries) -> Double { @_common.min(self.vals) }

pub fn SortdistlsdSeries::max(self : SortdistlsdSeries) -> Double { @_common.max(self.vals) }

pub fn SortdistlsdSeries::range(self : SortdistlsdSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn SortdistlsdSeries::variance(self : SortdistlsdSeries) -> Double { @_common.variance(self.vals) }

pub fn SortdistlsdSeries::std(self : SortdistlsdSeries) -> Double { @_common.std(self.vals) }

pub fn SortdistlsdSeries::median(self : SortdistlsdSeries) -> Double { @_common.median(self.vals) }

pub fn SortdistlsdSeries::scale(self : SortdistlsdSeries, f : Double) -> SortdistlsdSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn SortdistlsdSeries::add(self : SortdistlsdSeries, other : SortdistlsdSeries) -> SortdistlsdSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn SortdistlsdSeries::sub(self : SortdistlsdSeries, other : SortdistlsdSeries) -> SortdistlsdSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn SortdistlsdSeries::normalize(self : SortdistlsdSeries) -> SortdistlsdSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn SortdistlsdSeries::cumsum(self : SortdistlsdSeries) -> SortdistlsdSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn SortdistlsdSeries::to_string(self : SortdistlsdSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct SortdistlsdMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn sort_dist_lsd_make_matrix(rows : Int, cols : Int, val : Double) -> SortdistlsdMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn sort_dist_lsd_matrix_identity(n : Int) -> SortdistlsdMatrix {
  let m = sort_dist_lsd_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn SortdistlsdMatrix::get(self : SortdistlsdMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn SortdistlsdMatrix::transpose(self : SortdistlsdMatrix) -> SortdistlsdMatrix {
  let result = sort_dist_lsd_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn SortdistlsdMatrix::add(self : SortdistlsdMatrix, other : SortdistlsdMatrix) -> SortdistlsdMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = sort_dist_lsd_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn SortdistlsdMatrix::scale(self : SortdistlsdMatrix, s : Double) -> SortdistlsdMatrix {
  let result = sort_dist_lsd_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn SortdistlsdMatrix::multiply(self : SortdistlsdMatrix, other : SortdistlsdMatrix) -> SortdistlsdMatrix {
  if self.cols != other.rows { return sort_dist_lsd_make_matrix(self.rows, other.cols, 0.0) }
  let result = sort_dist_lsd_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn SortdistlsdMatrix::trace(self : SortdistlsdMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn SortdistlsdMatrix::det(self : SortdistlsdMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn SortdistlsdMatrix::norm(self : SortdistlsdMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn SortdistlsdMatrix::to_string(self : SortdistlsdMatrix) -> String {
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

pub(all) struct SortdistlsdVector {
  comps : Array[Double]
  dim : Int
}

pub fn sort_dist_lsd_make_vector(comps : Array[Double]) -> SortdistlsdVector {
  { comps, dim: comps.length() }
}

pub fn sort_dist_lsd_vector_zero(dim : Int) -> SortdistlsdVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn SortdistlsdVector::add(self : SortdistlsdVector, other : SortdistlsdVector) -> SortdistlsdVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn SortdistlsdVector::sub(self : SortdistlsdVector, other : SortdistlsdVector) -> SortdistlsdVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn SortdistlsdVector::scale(self : SortdistlsdVector, s : Double) -> SortdistlsdVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn SortdistlsdVector::dot(self : SortdistlsdVector, other : SortdistlsdVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn SortdistlsdVector::norm(self : SortdistlsdVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn SortdistlsdVector::normalize(self : SortdistlsdVector) -> SortdistlsdVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn SortdistlsdVector::dist(self : SortdistlsdVector, other : SortdistlsdVector) -> Double {
  self.sub(other).norm()
}

pub fn SortdistlsdVector::to_string(self : SortdistlsdVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn sort_dist_lsd_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn sort_dist_lsd_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn sort_dist_lsd_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn sort_dist_lsd_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn sort_dist_lsd_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn sort_dist_lsd_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn sort_dist_lsd_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn sort_dist_lsd_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn sort_dist_lsd_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn sort_dist_lsd_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn sort_dist_lsd_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn sort_dist_lsd_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn sort_dist_lsd_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn sort_dist_lsd_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn sort_dist_lsd_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn sort_dist_lsd_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn sort_dist_lsd_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn sort_dist_lsd_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn sort_dist_lsd_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn sort_dist_lsd_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn sort_dist_lsd_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn sort_dist_lsd_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn sort_dist_lsd_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn sort_dist_lsd_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn sort_dist_lsd_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn sort_dist_lsd_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn sort_dist_lsd_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn sort_dist_lsd_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn sort_dist_lsd_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct SortdistlsdFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_dist_lsd_frame_make(size : Int) -> SortdistlsdFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_dist_lsd_frame_len(s : SortdistlsdFrame) -> Int { s.size }

pub fn sort_dist_lsd_frame_get(s : SortdistlsdFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_dist_lsd_frame_set(s : SortdistlsdFrame, i : Int, v : Double) -> SortdistlsdFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_dist_lsd_frame_sum(s : SortdistlsdFrame) -> Double { @_common.sum(s.data) }

pub fn sort_dist_lsd_frame_mean(s : SortdistlsdFrame) -> Double { @_common.mean(s.data) }

pub fn sort_dist_lsd_frame_scale(s : SortdistlsdFrame, f : Double) -> SortdistlsdFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_dist_lsd_frame_add(a : SortdistlsdFrame, b : SortdistlsdFrame) -> SortdistlsdFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_dist_lsd_frame_copy(s : SortdistlsdFrame) -> SortdistlsdFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_dist_lsd_frame_fill(s : SortdistlsdFrame, v : Double) -> SortdistlsdFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_dist_lsd_frame_min(s : SortdistlsdFrame) -> Double { @_common.min(s.data) }

pub fn sort_dist_lsd_frame_max(s : SortdistlsdFrame) -> Double { @_common.max(s.data) }

pub fn sort_dist_lsd_frame_to_string(s : SortdistlsdFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortdistlsdTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_dist_lsd_table_make(size : Int) -> SortdistlsdTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_dist_lsd_table_len(s : SortdistlsdTable) -> Int { s.size }

pub fn sort_dist_lsd_table_get(s : SortdistlsdTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_dist_lsd_table_set(s : SortdistlsdTable, i : Int, v : Double) -> SortdistlsdTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_dist_lsd_table_sum(s : SortdistlsdTable) -> Double { @_common.sum(s.data) }

pub fn sort_dist_lsd_table_mean(s : SortdistlsdTable) -> Double { @_common.mean(s.data) }

pub fn sort_dist_lsd_table_scale(s : SortdistlsdTable, f : Double) -> SortdistlsdTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_dist_lsd_table_add(a : SortdistlsdTable, b : SortdistlsdTable) -> SortdistlsdTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_dist_lsd_table_copy(s : SortdistlsdTable) -> SortdistlsdTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_dist_lsd_table_fill(s : SortdistlsdTable, v : Double) -> SortdistlsdTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_dist_lsd_table_min(s : SortdistlsdTable) -> Double { @_common.min(s.data) }

pub fn sort_dist_lsd_table_max(s : SortdistlsdTable) -> Double { @_common.max(s.data) }

pub fn sort_dist_lsd_table_to_string(s : SortdistlsdTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortdistlsdGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_dist_lsd_graphn_make(size : Int) -> SortdistlsdGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_dist_lsd_graphn_len(s : SortdistlsdGraphN) -> Int { s.size }

pub fn sort_dist_lsd_graphn_get(s : SortdistlsdGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_dist_lsd_graphn_set(s : SortdistlsdGraphN, i : Int, v : Double) -> SortdistlsdGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_dist_lsd_graphn_sum(s : SortdistlsdGraphN) -> Double { @_common.sum(s.data) }

pub fn sort_dist_lsd_graphn_mean(s : SortdistlsdGraphN) -> Double { @_common.mean(s.data) }

pub fn sort_dist_lsd_graphn_scale(s : SortdistlsdGraphN, f : Double) -> SortdistlsdGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_dist_lsd_graphn_add(a : SortdistlsdGraphN, b : SortdistlsdGraphN) -> SortdistlsdGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_dist_lsd_graphn_copy(s : SortdistlsdGraphN) -> SortdistlsdGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_dist_lsd_graphn_fill(s : SortdistlsdGraphN, v : Double) -> SortdistlsdGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_dist_lsd_graphn_min(s : SortdistlsdGraphN) -> Double { @_common.min(s.data) }

pub fn sort_dist_lsd_graphn_max(s : SortdistlsdGraphN) -> Double { @_common.max(s.data) }

pub fn sort_dist_lsd_graphn_to_string(s : SortdistlsdGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortdistlsdNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_dist_lsd_node_make(size : Int) -> SortdistlsdNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_dist_lsd_node_len(s : SortdistlsdNode) -> Int { s.size }

pub fn sort_dist_lsd_node_get(s : SortdistlsdNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_dist_lsd_node_set(s : SortdistlsdNode, i : Int, v : Double) -> SortdistlsdNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_dist_lsd_node_sum(s : SortdistlsdNode) -> Double { @_common.sum(s.data) }

pub fn sort_dist_lsd_node_mean(s : SortdistlsdNode) -> Double { @_common.mean(s.data) }

pub fn sort_dist_lsd_node_scale(s : SortdistlsdNode, f : Double) -> SortdistlsdNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_dist_lsd_node_add(a : SortdistlsdNode, b : SortdistlsdNode) -> SortdistlsdNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_dist_lsd_node_copy(s : SortdistlsdNode) -> SortdistlsdNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_dist_lsd_node_fill(s : SortdistlsdNode, v : Double) -> SortdistlsdNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_dist_lsd_node_min(s : SortdistlsdNode) -> Double { @_common.min(s.data) }

pub fn sort_dist_lsd_node_max(s : SortdistlsdNode) -> Double { @_common.max(s.data) }

pub fn sort_dist_lsd_node_to_string(s : SortdistlsdNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortdistlsdEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_dist_lsd_edge_make(size : Int) -> SortdistlsdEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_dist_lsd_edge_len(s : SortdistlsdEdge) -> Int { s.size }

pub fn sort_dist_lsd_edge_get(s : SortdistlsdEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_dist_lsd_edge_set(s : SortdistlsdEdge, i : Int, v : Double) -> SortdistlsdEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_dist_lsd_edge_sum(s : SortdistlsdEdge) -> Double { @_common.sum(s.data) }

pub fn sort_dist_lsd_edge_mean(s : SortdistlsdEdge) -> Double { @_common.mean(s.data) }

pub fn sort_dist_lsd_edge_scale(s : SortdistlsdEdge, f : Double) -> SortdistlsdEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_dist_lsd_edge_add(a : SortdistlsdEdge, b : SortdistlsdEdge) -> SortdistlsdEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_dist_lsd_edge_copy(s : SortdistlsdEdge) -> SortdistlsdEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_dist_lsd_edge_fill(s : SortdistlsdEdge, v : Double) -> SortdistlsdEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_dist_lsd_edge_min(s : SortdistlsdEdge) -> Double { @_common.min(s.data) }

pub fn sort_dist_lsd_edge_max(s : SortdistlsdEdge) -> Double { @_common.max(s.data) }

pub fn sort_dist_lsd_edge_to_string(s : SortdistlsdEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortdistlsdPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_dist_lsd_path_make(size : Int) -> SortdistlsdPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_dist_lsd_path_len(s : SortdistlsdPath) -> Int { s.size }

pub fn sort_dist_lsd_path_get(s : SortdistlsdPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_dist_lsd_path_set(s : SortdistlsdPath, i : Int, v : Double) -> SortdistlsdPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_dist_lsd_path_sum(s : SortdistlsdPath) -> Double { @_common.sum(s.data) }

pub fn sort_dist_lsd_path_mean(s : SortdistlsdPath) -> Double { @_common.mean(s.data) }

pub fn sort_dist_lsd_path_scale(s : SortdistlsdPath, f : Double) -> SortdistlsdPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_dist_lsd_path_add(a : SortdistlsdPath, b : SortdistlsdPath) -> SortdistlsdPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_dist_lsd_path_copy(s : SortdistlsdPath) -> SortdistlsdPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_dist_lsd_path_fill(s : SortdistlsdPath, v : Double) -> SortdistlsdPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_dist_lsd_path_min(s : SortdistlsdPath) -> Double { @_common.min(s.data) }

pub fn sort_dist_lsd_path_max(s : SortdistlsdPath) -> Double { @_common.max(s.data) }

pub fn sort_dist_lsd_path_to_string(s : SortdistlsdPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortdistlsdCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_dist_lsd_cluster_make(size : Int) -> SortdistlsdCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_dist_lsd_cluster_len(s : SortdistlsdCluster) -> Int { s.size }

pub fn sort_dist_lsd_cluster_get(s : SortdistlsdCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_dist_lsd_cluster_set(s : SortdistlsdCluster, i : Int, v : Double) -> SortdistlsdCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_dist_lsd_cluster_sum(s : SortdistlsdCluster) -> Double { @_common.sum(s.data) }

pub fn sort_dist_lsd_cluster_mean(s : SortdistlsdCluster) -> Double { @_common.mean(s.data) }

pub fn sort_dist_lsd_cluster_scale(s : SortdistlsdCluster, f : Double) -> SortdistlsdCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_dist_lsd_cluster_add(a : SortdistlsdCluster, b : SortdistlsdCluster) -> SortdistlsdCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_dist_lsd_cluster_copy(s : SortdistlsdCluster) -> SortdistlsdCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_dist_lsd_cluster_fill(s : SortdistlsdCluster, v : Double) -> SortdistlsdCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_dist_lsd_cluster_min(s : SortdistlsdCluster) -> Double { @_common.min(s.data) }

pub fn sort_dist_lsd_cluster_max(s : SortdistlsdCluster) -> Double { @_common.max(s.data) }

pub fn sort_dist_lsd_cluster_to_string(s : SortdistlsdCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortdistlsdModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_dist_lsd_model_make(size : Int) -> SortdistlsdModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_dist_lsd_model_len(s : SortdistlsdModel) -> Int { s.size }

pub fn sort_dist_lsd_model_get(s : SortdistlsdModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_dist_lsd_model_set(s : SortdistlsdModel, i : Int, v : Double) -> SortdistlsdModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_dist_lsd_model_sum(s : SortdistlsdModel) -> Double { @_common.sum(s.data) }

pub fn sort_dist_lsd_model_mean(s : SortdistlsdModel) -> Double { @_common.mean(s.data) }

pub fn sort_dist_lsd_model_scale(s : SortdistlsdModel, f : Double) -> SortdistlsdModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_dist_lsd_model_add(a : SortdistlsdModel, b : SortdistlsdModel) -> SortdistlsdModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_dist_lsd_model_copy(s : SortdistlsdModel) -> SortdistlsdModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_dist_lsd_model_fill(s : SortdistlsdModel, v : Double) -> SortdistlsdModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_dist_lsd_model_min(s : SortdistlsdModel) -> Double { @_common.min(s.data) }

pub fn sort_dist_lsd_model_max(s : SortdistlsdModel) -> Double { @_common.max(s.data) }

pub fn sort_dist_lsd_model_to_string(s : SortdistlsdModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortdistlsdLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_dist_lsd_layer_make(size : Int) -> SortdistlsdLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_dist_lsd_layer_len(s : SortdistlsdLayer) -> Int { s.size }

pub fn sort_dist_lsd_layer_get(s : SortdistlsdLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_dist_lsd_layer_set(s : SortdistlsdLayer, i : Int, v : Double) -> SortdistlsdLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_dist_lsd_layer_sum(s : SortdistlsdLayer) -> Double { @_common.sum(s.data) }

pub fn sort_dist_lsd_layer_mean(s : SortdistlsdLayer) -> Double { @_common.mean(s.data) }

pub fn sort_dist_lsd_layer_scale(s : SortdistlsdLayer, f : Double) -> SortdistlsdLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_dist_lsd_layer_add(a : SortdistlsdLayer, b : SortdistlsdLayer) -> SortdistlsdLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_dist_lsd_layer_copy(s : SortdistlsdLayer) -> SortdistlsdLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_dist_lsd_layer_fill(s : SortdistlsdLayer, v : Double) -> SortdistlsdLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_dist_lsd_layer_min(s : SortdistlsdLayer) -> Double { @_common.min(s.data) }

pub fn sort_dist_lsd_layer_max(s : SortdistlsdLayer) -> Double { @_common.max(s.data) }

pub fn sort_dist_lsd_layer_to_string(s : SortdistlsdLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortdistlsdBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_dist_lsd_buffer_make(size : Int) -> SortdistlsdBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_dist_lsd_buffer_len(s : SortdistlsdBuffer) -> Int { s.size }

pub fn sort_dist_lsd_buffer_get(s : SortdistlsdBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_dist_lsd_buffer_set(s : SortdistlsdBuffer, i : Int, v : Double) -> SortdistlsdBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_dist_lsd_buffer_sum(s : SortdistlsdBuffer) -> Double { @_common.sum(s.data) }

pub fn sort_dist_lsd_buffer_mean(s : SortdistlsdBuffer) -> Double { @_common.mean(s.data) }

pub fn sort_dist_lsd_buffer_scale(s : SortdistlsdBuffer, f : Double) -> SortdistlsdBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_dist_lsd_buffer_add(a : SortdistlsdBuffer, b : SortdistlsdBuffer) -> SortdistlsdBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_dist_lsd_buffer_copy(s : SortdistlsdBuffer) -> SortdistlsdBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_dist_lsd_buffer_fill(s : SortdistlsdBuffer, v : Double) -> SortdistlsdBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_dist_lsd_buffer_min(s : SortdistlsdBuffer) -> Double { @_common.min(s.data) }

pub fn sort_dist_lsd_buffer_max(s : SortdistlsdBuffer) -> Double { @_common.max(s.data) }

pub fn sort_dist_lsd_buffer_to_string(s : SortdistlsdBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortdistlsdCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_dist_lsd_cursor_make(size : Int) -> SortdistlsdCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_dist_lsd_cursor_len(s : SortdistlsdCursor) -> Int { s.size }

pub fn sort_dist_lsd_cursor_get(s : SortdistlsdCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_dist_lsd_cursor_set(s : SortdistlsdCursor, i : Int, v : Double) -> SortdistlsdCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_dist_lsd_cursor_sum(s : SortdistlsdCursor) -> Double { @_common.sum(s.data) }

pub fn sort_dist_lsd_cursor_mean(s : SortdistlsdCursor) -> Double { @_common.mean(s.data) }

pub fn sort_dist_lsd_cursor_scale(s : SortdistlsdCursor, f : Double) -> SortdistlsdCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_dist_lsd_cursor_add(a : SortdistlsdCursor, b : SortdistlsdCursor) -> SortdistlsdCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_dist_lsd_cursor_copy(s : SortdistlsdCursor) -> SortdistlsdCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_dist_lsd_cursor_fill(s : SortdistlsdCursor, v : Double) -> SortdistlsdCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_dist_lsd_cursor_min(s : SortdistlsdCursor) -> Double { @_common.min(s.data) }

pub fn sort_dist_lsd_cursor_max(s : SortdistlsdCursor) -> Double { @_common.max(s.data) }

pub fn sort_dist_lsd_cursor_to_string(s : SortdistlsdCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortdistlsdView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_dist_lsd_view_make(size : Int) -> SortdistlsdView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_dist_lsd_view_len(s : SortdistlsdView) -> Int { s.size }

pub fn sort_dist_lsd_view_get(s : SortdistlsdView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_dist_lsd_view_set(s : SortdistlsdView, i : Int, v : Double) -> SortdistlsdView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_dist_lsd_view_sum(s : SortdistlsdView) -> Double { @_common.sum(s.data) }

pub fn sort_dist_lsd_view_mean(s : SortdistlsdView) -> Double { @_common.mean(s.data) }

pub fn sort_dist_lsd_view_scale(s : SortdistlsdView, f : Double) -> SortdistlsdView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_dist_lsd_view_add(a : SortdistlsdView, b : SortdistlsdView) -> SortdistlsdView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_dist_lsd_view_copy(s : SortdistlsdView) -> SortdistlsdView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_dist_lsd_view_fill(s : SortdistlsdView, v : Double) -> SortdistlsdView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_dist_lsd_view_min(s : SortdistlsdView) -> Double { @_common.min(s.data) }

pub fn sort_dist_lsd_view_max(s : SortdistlsdView) -> Double { @_common.max(s.data) }

pub fn sort_dist_lsd_view_to_string(s : SortdistlsdView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortdistlsdRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_dist_lsd_range_make(size : Int) -> SortdistlsdRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_dist_lsd_range_len(s : SortdistlsdRange) -> Int { s.size }

pub fn sort_dist_lsd_range_get(s : SortdistlsdRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_dist_lsd_range_set(s : SortdistlsdRange, i : Int, v : Double) -> SortdistlsdRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_dist_lsd_range_sum(s : SortdistlsdRange) -> Double { @_common.sum(s.data) }

pub fn sort_dist_lsd_range_mean(s : SortdistlsdRange) -> Double { @_common.mean(s.data) }

pub fn sort_dist_lsd_range_scale(s : SortdistlsdRange, f : Double) -> SortdistlsdRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_dist_lsd_range_add(a : SortdistlsdRange, b : SortdistlsdRange) -> SortdistlsdRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_dist_lsd_range_copy(s : SortdistlsdRange) -> SortdistlsdRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_dist_lsd_range_fill(s : SortdistlsdRange, v : Double) -> SortdistlsdRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_dist_lsd_range_min(s : SortdistlsdRange) -> Double { @_common.min(s.data) }

pub fn sort_dist_lsd_range_max(s : SortdistlsdRange) -> Double { @_common.max(s.data) }

pub fn sort_dist_lsd_range_to_string(s : SortdistlsdRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortdistlsdSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_dist_lsd_slice_make(size : Int) -> SortdistlsdSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_dist_lsd_slice_len(s : SortdistlsdSlice) -> Int { s.size }

pub fn sort_dist_lsd_slice_get(s : SortdistlsdSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_dist_lsd_slice_set(s : SortdistlsdSlice, i : Int, v : Double) -> SortdistlsdSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_dist_lsd_slice_sum(s : SortdistlsdSlice) -> Double { @_common.sum(s.data) }

pub fn sort_dist_lsd_slice_mean(s : SortdistlsdSlice) -> Double { @_common.mean(s.data) }

pub fn sort_dist_lsd_slice_scale(s : SortdistlsdSlice, f : Double) -> SortdistlsdSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_dist_lsd_slice_add(a : SortdistlsdSlice, b : SortdistlsdSlice) -> SortdistlsdSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_dist_lsd_slice_copy(s : SortdistlsdSlice) -> SortdistlsdSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_dist_lsd_slice_fill(s : SortdistlsdSlice, v : Double) -> SortdistlsdSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_dist_lsd_slice_min(s : SortdistlsdSlice) -> Double { @_common.min(s.data) }

pub fn sort_dist_lsd_slice_max(s : SortdistlsdSlice) -> Double { @_common.max(s.data) }

pub fn sort_dist_lsd_slice_to_string(s : SortdistlsdSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

