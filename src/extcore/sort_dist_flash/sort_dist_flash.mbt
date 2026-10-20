///===
/// extcore/sort_dist_flash

pub(all) struct SortdistflashPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn sort_dist_flash_make_point(x : Double, y : Double) -> SortdistflashPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn sort_dist_flash_make_point3(x : Double, y : Double, z : Double) -> SortdistflashPoint {
  { x, y, z, label: 0 }
}

pub fn SortdistflashPoint::x(self : SortdistflashPoint) -> Double { self.x }

pub fn SortdistflashPoint::y(self : SortdistflashPoint) -> Double { self.y }

pub fn SortdistflashPoint::z(self : SortdistflashPoint) -> Double { self.z }

pub fn SortdistflashPoint::label(self : SortdistflashPoint) -> Int { self.label }

pub fn SortdistflashPoint::dist(self : SortdistflashPoint, other : SortdistflashPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn SortdistflashPoint::add(self : SortdistflashPoint, other : SortdistflashPoint) -> SortdistflashPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn SortdistflashPoint::sub(self : SortdistflashPoint, other : SortdistflashPoint) -> SortdistflashPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn SortdistflashPoint::scale(self : SortdistflashPoint, s : Double) -> SortdistflashPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn SortdistflashPoint::dot(self : SortdistflashPoint, other : SortdistflashPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn SortdistflashPoint::cross(self : SortdistflashPoint, other : SortdistflashPoint) -> SortdistflashPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn SortdistflashPoint::norm(self : SortdistflashPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn SortdistflashPoint::normalize(self : SortdistflashPoint) -> SortdistflashPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn SortdistflashPoint::negate(self : SortdistflashPoint) -> SortdistflashPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn SortdistflashPoint::mid(self : SortdistflashPoint, other : SortdistflashPoint) -> SortdistflashPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn SortdistflashPoint::lerp(self : SortdistflashPoint, other : SortdistflashPoint, t : Double) -> SortdistflashPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn SortdistflashPoint::to_string(self : SortdistflashPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct SortdistflashSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn sort_dist_flash_make_series(vals : Array[Double], name : String) -> SortdistflashSeries {
  { vals, name, meta: 0 }
}

pub fn SortdistflashSeries::len(self : SortdistflashSeries) -> Int { self.vals.length() }

pub fn SortdistflashSeries::sum(self : SortdistflashSeries) -> Double { @_common.sum(self.vals) }

pub fn SortdistflashSeries::mean(self : SortdistflashSeries) -> Double { @_common.mean(self.vals) }

pub fn SortdistflashSeries::min(self : SortdistflashSeries) -> Double { @_common.min(self.vals) }

pub fn SortdistflashSeries::max(self : SortdistflashSeries) -> Double { @_common.max(self.vals) }

pub fn SortdistflashSeries::range(self : SortdistflashSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn SortdistflashSeries::variance(self : SortdistflashSeries) -> Double { @_common.variance(self.vals) }

pub fn SortdistflashSeries::std(self : SortdistflashSeries) -> Double { @_common.std(self.vals) }

pub fn SortdistflashSeries::median(self : SortdistflashSeries) -> Double { @_common.median(self.vals) }

pub fn SortdistflashSeries::scale(self : SortdistflashSeries, f : Double) -> SortdistflashSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn SortdistflashSeries::add(self : SortdistflashSeries, other : SortdistflashSeries) -> SortdistflashSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn SortdistflashSeries::sub(self : SortdistflashSeries, other : SortdistflashSeries) -> SortdistflashSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn SortdistflashSeries::normalize(self : SortdistflashSeries) -> SortdistflashSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn SortdistflashSeries::cumsum(self : SortdistflashSeries) -> SortdistflashSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn SortdistflashSeries::to_string(self : SortdistflashSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct SortdistflashMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn sort_dist_flash_make_matrix(rows : Int, cols : Int, val : Double) -> SortdistflashMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn sort_dist_flash_matrix_identity(n : Int) -> SortdistflashMatrix {
  let m = sort_dist_flash_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn SortdistflashMatrix::get(self : SortdistflashMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn SortdistflashMatrix::transpose(self : SortdistflashMatrix) -> SortdistflashMatrix {
  let result = sort_dist_flash_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn SortdistflashMatrix::add(self : SortdistflashMatrix, other : SortdistflashMatrix) -> SortdistflashMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = sort_dist_flash_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn SortdistflashMatrix::scale(self : SortdistflashMatrix, s : Double) -> SortdistflashMatrix {
  let result = sort_dist_flash_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn SortdistflashMatrix::multiply(self : SortdistflashMatrix, other : SortdistflashMatrix) -> SortdistflashMatrix {
  if self.cols != other.rows { return sort_dist_flash_make_matrix(self.rows, other.cols, 0.0) }
  let result = sort_dist_flash_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn SortdistflashMatrix::trace(self : SortdistflashMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn SortdistflashMatrix::det(self : SortdistflashMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn SortdistflashMatrix::norm(self : SortdistflashMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn SortdistflashMatrix::to_string(self : SortdistflashMatrix) -> String {
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

pub(all) struct SortdistflashVector {
  comps : Array[Double]
  dim : Int
}

pub fn sort_dist_flash_make_vector(comps : Array[Double]) -> SortdistflashVector {
  { comps, dim: comps.length() }
}

pub fn sort_dist_flash_vector_zero(dim : Int) -> SortdistflashVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn SortdistflashVector::add(self : SortdistflashVector, other : SortdistflashVector) -> SortdistflashVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn SortdistflashVector::sub(self : SortdistflashVector, other : SortdistflashVector) -> SortdistflashVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn SortdistflashVector::scale(self : SortdistflashVector, s : Double) -> SortdistflashVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn SortdistflashVector::dot(self : SortdistflashVector, other : SortdistflashVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn SortdistflashVector::norm(self : SortdistflashVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn SortdistflashVector::normalize(self : SortdistflashVector) -> SortdistflashVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn SortdistflashVector::dist(self : SortdistflashVector, other : SortdistflashVector) -> Double {
  self.sub(other).norm()
}

pub fn SortdistflashVector::to_string(self : SortdistflashVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn sort_dist_flash_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn sort_dist_flash_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn sort_dist_flash_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn sort_dist_flash_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn sort_dist_flash_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn sort_dist_flash_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn sort_dist_flash_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn sort_dist_flash_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn sort_dist_flash_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn sort_dist_flash_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn sort_dist_flash_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn sort_dist_flash_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn sort_dist_flash_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn sort_dist_flash_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn sort_dist_flash_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn sort_dist_flash_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn sort_dist_flash_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn sort_dist_flash_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn sort_dist_flash_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn sort_dist_flash_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn sort_dist_flash_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn sort_dist_flash_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn sort_dist_flash_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn sort_dist_flash_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn sort_dist_flash_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn sort_dist_flash_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn sort_dist_flash_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn sort_dist_flash_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn sort_dist_flash_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct SortdistflashFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_dist_flash_frame_make(size : Int) -> SortdistflashFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_dist_flash_frame_len(s : SortdistflashFrame) -> Int { s.size }

pub fn sort_dist_flash_frame_get(s : SortdistflashFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_dist_flash_frame_set(s : SortdistflashFrame, i : Int, v : Double) -> SortdistflashFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_dist_flash_frame_sum(s : SortdistflashFrame) -> Double { @_common.sum(s.data) }

pub fn sort_dist_flash_frame_mean(s : SortdistflashFrame) -> Double { @_common.mean(s.data) }

pub fn sort_dist_flash_frame_scale(s : SortdistflashFrame, f : Double) -> SortdistflashFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_dist_flash_frame_add(a : SortdistflashFrame, b : SortdistflashFrame) -> SortdistflashFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_dist_flash_frame_copy(s : SortdistflashFrame) -> SortdistflashFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_dist_flash_frame_fill(s : SortdistflashFrame, v : Double) -> SortdistflashFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_dist_flash_frame_min(s : SortdistflashFrame) -> Double { @_common.min(s.data) }

pub fn sort_dist_flash_frame_max(s : SortdistflashFrame) -> Double { @_common.max(s.data) }

pub fn sort_dist_flash_frame_to_string(s : SortdistflashFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortdistflashTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_dist_flash_table_make(size : Int) -> SortdistflashTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_dist_flash_table_len(s : SortdistflashTable) -> Int { s.size }

pub fn sort_dist_flash_table_get(s : SortdistflashTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_dist_flash_table_set(s : SortdistflashTable, i : Int, v : Double) -> SortdistflashTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_dist_flash_table_sum(s : SortdistflashTable) -> Double { @_common.sum(s.data) }

pub fn sort_dist_flash_table_mean(s : SortdistflashTable) -> Double { @_common.mean(s.data) }

pub fn sort_dist_flash_table_scale(s : SortdistflashTable, f : Double) -> SortdistflashTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_dist_flash_table_add(a : SortdistflashTable, b : SortdistflashTable) -> SortdistflashTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_dist_flash_table_copy(s : SortdistflashTable) -> SortdistflashTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_dist_flash_table_fill(s : SortdistflashTable, v : Double) -> SortdistflashTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_dist_flash_table_min(s : SortdistflashTable) -> Double { @_common.min(s.data) }

pub fn sort_dist_flash_table_max(s : SortdistflashTable) -> Double { @_common.max(s.data) }

pub fn sort_dist_flash_table_to_string(s : SortdistflashTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortdistflashGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_dist_flash_graphn_make(size : Int) -> SortdistflashGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_dist_flash_graphn_len(s : SortdistflashGraphN) -> Int { s.size }

pub fn sort_dist_flash_graphn_get(s : SortdistflashGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_dist_flash_graphn_set(s : SortdistflashGraphN, i : Int, v : Double) -> SortdistflashGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_dist_flash_graphn_sum(s : SortdistflashGraphN) -> Double { @_common.sum(s.data) }

pub fn sort_dist_flash_graphn_mean(s : SortdistflashGraphN) -> Double { @_common.mean(s.data) }

pub fn sort_dist_flash_graphn_scale(s : SortdistflashGraphN, f : Double) -> SortdistflashGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_dist_flash_graphn_add(a : SortdistflashGraphN, b : SortdistflashGraphN) -> SortdistflashGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_dist_flash_graphn_copy(s : SortdistflashGraphN) -> SortdistflashGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_dist_flash_graphn_fill(s : SortdistflashGraphN, v : Double) -> SortdistflashGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_dist_flash_graphn_min(s : SortdistflashGraphN) -> Double { @_common.min(s.data) }

pub fn sort_dist_flash_graphn_max(s : SortdistflashGraphN) -> Double { @_common.max(s.data) }

pub fn sort_dist_flash_graphn_to_string(s : SortdistflashGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortdistflashNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_dist_flash_node_make(size : Int) -> SortdistflashNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_dist_flash_node_len(s : SortdistflashNode) -> Int { s.size }

pub fn sort_dist_flash_node_get(s : SortdistflashNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_dist_flash_node_set(s : SortdistflashNode, i : Int, v : Double) -> SortdistflashNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_dist_flash_node_sum(s : SortdistflashNode) -> Double { @_common.sum(s.data) }

pub fn sort_dist_flash_node_mean(s : SortdistflashNode) -> Double { @_common.mean(s.data) }

pub fn sort_dist_flash_node_scale(s : SortdistflashNode, f : Double) -> SortdistflashNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_dist_flash_node_add(a : SortdistflashNode, b : SortdistflashNode) -> SortdistflashNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_dist_flash_node_copy(s : SortdistflashNode) -> SortdistflashNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_dist_flash_node_fill(s : SortdistflashNode, v : Double) -> SortdistflashNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_dist_flash_node_min(s : SortdistflashNode) -> Double { @_common.min(s.data) }

pub fn sort_dist_flash_node_max(s : SortdistflashNode) -> Double { @_common.max(s.data) }

pub fn sort_dist_flash_node_to_string(s : SortdistflashNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortdistflashEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_dist_flash_edge_make(size : Int) -> SortdistflashEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_dist_flash_edge_len(s : SortdistflashEdge) -> Int { s.size }

pub fn sort_dist_flash_edge_get(s : SortdistflashEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_dist_flash_edge_set(s : SortdistflashEdge, i : Int, v : Double) -> SortdistflashEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_dist_flash_edge_sum(s : SortdistflashEdge) -> Double { @_common.sum(s.data) }

pub fn sort_dist_flash_edge_mean(s : SortdistflashEdge) -> Double { @_common.mean(s.data) }

pub fn sort_dist_flash_edge_scale(s : SortdistflashEdge, f : Double) -> SortdistflashEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_dist_flash_edge_add(a : SortdistflashEdge, b : SortdistflashEdge) -> SortdistflashEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_dist_flash_edge_copy(s : SortdistflashEdge) -> SortdistflashEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_dist_flash_edge_fill(s : SortdistflashEdge, v : Double) -> SortdistflashEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_dist_flash_edge_min(s : SortdistflashEdge) -> Double { @_common.min(s.data) }

pub fn sort_dist_flash_edge_max(s : SortdistflashEdge) -> Double { @_common.max(s.data) }

pub fn sort_dist_flash_edge_to_string(s : SortdistflashEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortdistflashPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_dist_flash_path_make(size : Int) -> SortdistflashPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_dist_flash_path_len(s : SortdistflashPath) -> Int { s.size }

pub fn sort_dist_flash_path_get(s : SortdistflashPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_dist_flash_path_set(s : SortdistflashPath, i : Int, v : Double) -> SortdistflashPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_dist_flash_path_sum(s : SortdistflashPath) -> Double { @_common.sum(s.data) }

pub fn sort_dist_flash_path_mean(s : SortdistflashPath) -> Double { @_common.mean(s.data) }

pub fn sort_dist_flash_path_scale(s : SortdistflashPath, f : Double) -> SortdistflashPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_dist_flash_path_add(a : SortdistflashPath, b : SortdistflashPath) -> SortdistflashPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_dist_flash_path_copy(s : SortdistflashPath) -> SortdistflashPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_dist_flash_path_fill(s : SortdistflashPath, v : Double) -> SortdistflashPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_dist_flash_path_min(s : SortdistflashPath) -> Double { @_common.min(s.data) }

pub fn sort_dist_flash_path_max(s : SortdistflashPath) -> Double { @_common.max(s.data) }

pub fn sort_dist_flash_path_to_string(s : SortdistflashPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortdistflashCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_dist_flash_cluster_make(size : Int) -> SortdistflashCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_dist_flash_cluster_len(s : SortdistflashCluster) -> Int { s.size }

pub fn sort_dist_flash_cluster_get(s : SortdistflashCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_dist_flash_cluster_set(s : SortdistflashCluster, i : Int, v : Double) -> SortdistflashCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_dist_flash_cluster_sum(s : SortdistflashCluster) -> Double { @_common.sum(s.data) }

pub fn sort_dist_flash_cluster_mean(s : SortdistflashCluster) -> Double { @_common.mean(s.data) }

pub fn sort_dist_flash_cluster_scale(s : SortdistflashCluster, f : Double) -> SortdistflashCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_dist_flash_cluster_add(a : SortdistflashCluster, b : SortdistflashCluster) -> SortdistflashCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_dist_flash_cluster_copy(s : SortdistflashCluster) -> SortdistflashCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_dist_flash_cluster_fill(s : SortdistflashCluster, v : Double) -> SortdistflashCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_dist_flash_cluster_min(s : SortdistflashCluster) -> Double { @_common.min(s.data) }

pub fn sort_dist_flash_cluster_max(s : SortdistflashCluster) -> Double { @_common.max(s.data) }

pub fn sort_dist_flash_cluster_to_string(s : SortdistflashCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortdistflashModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_dist_flash_model_make(size : Int) -> SortdistflashModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_dist_flash_model_len(s : SortdistflashModel) -> Int { s.size }

pub fn sort_dist_flash_model_get(s : SortdistflashModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_dist_flash_model_set(s : SortdistflashModel, i : Int, v : Double) -> SortdistflashModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_dist_flash_model_sum(s : SortdistflashModel) -> Double { @_common.sum(s.data) }

pub fn sort_dist_flash_model_mean(s : SortdistflashModel) -> Double { @_common.mean(s.data) }

pub fn sort_dist_flash_model_scale(s : SortdistflashModel, f : Double) -> SortdistflashModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_dist_flash_model_add(a : SortdistflashModel, b : SortdistflashModel) -> SortdistflashModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_dist_flash_model_copy(s : SortdistflashModel) -> SortdistflashModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_dist_flash_model_fill(s : SortdistflashModel, v : Double) -> SortdistflashModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_dist_flash_model_min(s : SortdistflashModel) -> Double { @_common.min(s.data) }

pub fn sort_dist_flash_model_max(s : SortdistflashModel) -> Double { @_common.max(s.data) }

pub fn sort_dist_flash_model_to_string(s : SortdistflashModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortdistflashLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_dist_flash_layer_make(size : Int) -> SortdistflashLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_dist_flash_layer_len(s : SortdistflashLayer) -> Int { s.size }

pub fn sort_dist_flash_layer_get(s : SortdistflashLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_dist_flash_layer_set(s : SortdistflashLayer, i : Int, v : Double) -> SortdistflashLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_dist_flash_layer_sum(s : SortdistflashLayer) -> Double { @_common.sum(s.data) }

pub fn sort_dist_flash_layer_mean(s : SortdistflashLayer) -> Double { @_common.mean(s.data) }

pub fn sort_dist_flash_layer_scale(s : SortdistflashLayer, f : Double) -> SortdistflashLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_dist_flash_layer_add(a : SortdistflashLayer, b : SortdistflashLayer) -> SortdistflashLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_dist_flash_layer_copy(s : SortdistflashLayer) -> SortdistflashLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_dist_flash_layer_fill(s : SortdistflashLayer, v : Double) -> SortdistflashLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_dist_flash_layer_min(s : SortdistflashLayer) -> Double { @_common.min(s.data) }

pub fn sort_dist_flash_layer_max(s : SortdistflashLayer) -> Double { @_common.max(s.data) }

pub fn sort_dist_flash_layer_to_string(s : SortdistflashLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortdistflashBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_dist_flash_buffer_make(size : Int) -> SortdistflashBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_dist_flash_buffer_len(s : SortdistflashBuffer) -> Int { s.size }

pub fn sort_dist_flash_buffer_get(s : SortdistflashBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_dist_flash_buffer_set(s : SortdistflashBuffer, i : Int, v : Double) -> SortdistflashBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_dist_flash_buffer_sum(s : SortdistflashBuffer) -> Double { @_common.sum(s.data) }

pub fn sort_dist_flash_buffer_mean(s : SortdistflashBuffer) -> Double { @_common.mean(s.data) }

pub fn sort_dist_flash_buffer_scale(s : SortdistflashBuffer, f : Double) -> SortdistflashBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_dist_flash_buffer_add(a : SortdistflashBuffer, b : SortdistflashBuffer) -> SortdistflashBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_dist_flash_buffer_copy(s : SortdistflashBuffer) -> SortdistflashBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_dist_flash_buffer_fill(s : SortdistflashBuffer, v : Double) -> SortdistflashBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_dist_flash_buffer_min(s : SortdistflashBuffer) -> Double { @_common.min(s.data) }

pub fn sort_dist_flash_buffer_max(s : SortdistflashBuffer) -> Double { @_common.max(s.data) }

pub fn sort_dist_flash_buffer_to_string(s : SortdistflashBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortdistflashCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_dist_flash_cursor_make(size : Int) -> SortdistflashCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_dist_flash_cursor_len(s : SortdistflashCursor) -> Int { s.size }

pub fn sort_dist_flash_cursor_get(s : SortdistflashCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_dist_flash_cursor_set(s : SortdistflashCursor, i : Int, v : Double) -> SortdistflashCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_dist_flash_cursor_sum(s : SortdistflashCursor) -> Double { @_common.sum(s.data) }

pub fn sort_dist_flash_cursor_mean(s : SortdistflashCursor) -> Double { @_common.mean(s.data) }

pub fn sort_dist_flash_cursor_scale(s : SortdistflashCursor, f : Double) -> SortdistflashCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_dist_flash_cursor_add(a : SortdistflashCursor, b : SortdistflashCursor) -> SortdistflashCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_dist_flash_cursor_copy(s : SortdistflashCursor) -> SortdistflashCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_dist_flash_cursor_fill(s : SortdistflashCursor, v : Double) -> SortdistflashCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_dist_flash_cursor_min(s : SortdistflashCursor) -> Double { @_common.min(s.data) }

pub fn sort_dist_flash_cursor_max(s : SortdistflashCursor) -> Double { @_common.max(s.data) }

pub fn sort_dist_flash_cursor_to_string(s : SortdistflashCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortdistflashView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_dist_flash_view_make(size : Int) -> SortdistflashView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_dist_flash_view_len(s : SortdistflashView) -> Int { s.size }

pub fn sort_dist_flash_view_get(s : SortdistflashView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_dist_flash_view_set(s : SortdistflashView, i : Int, v : Double) -> SortdistflashView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_dist_flash_view_sum(s : SortdistflashView) -> Double { @_common.sum(s.data) }

pub fn sort_dist_flash_view_mean(s : SortdistflashView) -> Double { @_common.mean(s.data) }

pub fn sort_dist_flash_view_scale(s : SortdistflashView, f : Double) -> SortdistflashView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_dist_flash_view_add(a : SortdistflashView, b : SortdistflashView) -> SortdistflashView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_dist_flash_view_copy(s : SortdistflashView) -> SortdistflashView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_dist_flash_view_fill(s : SortdistflashView, v : Double) -> SortdistflashView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_dist_flash_view_min(s : SortdistflashView) -> Double { @_common.min(s.data) }

pub fn sort_dist_flash_view_max(s : SortdistflashView) -> Double { @_common.max(s.data) }

pub fn sort_dist_flash_view_to_string(s : SortdistflashView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortdistflashRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_dist_flash_range_make(size : Int) -> SortdistflashRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_dist_flash_range_len(s : SortdistflashRange) -> Int { s.size }

pub fn sort_dist_flash_range_get(s : SortdistflashRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_dist_flash_range_set(s : SortdistflashRange, i : Int, v : Double) -> SortdistflashRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_dist_flash_range_sum(s : SortdistflashRange) -> Double { @_common.sum(s.data) }

pub fn sort_dist_flash_range_mean(s : SortdistflashRange) -> Double { @_common.mean(s.data) }

pub fn sort_dist_flash_range_scale(s : SortdistflashRange, f : Double) -> SortdistflashRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_dist_flash_range_add(a : SortdistflashRange, b : SortdistflashRange) -> SortdistflashRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_dist_flash_range_copy(s : SortdistflashRange) -> SortdistflashRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_dist_flash_range_fill(s : SortdistflashRange, v : Double) -> SortdistflashRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_dist_flash_range_min(s : SortdistflashRange) -> Double { @_common.min(s.data) }

pub fn sort_dist_flash_range_max(s : SortdistflashRange) -> Double { @_common.max(s.data) }

pub fn sort_dist_flash_range_to_string(s : SortdistflashRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortdistflashSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_dist_flash_slice_make(size : Int) -> SortdistflashSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_dist_flash_slice_len(s : SortdistflashSlice) -> Int { s.size }

pub fn sort_dist_flash_slice_get(s : SortdistflashSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_dist_flash_slice_set(s : SortdistflashSlice, i : Int, v : Double) -> SortdistflashSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_dist_flash_slice_sum(s : SortdistflashSlice) -> Double { @_common.sum(s.data) }

pub fn sort_dist_flash_slice_mean(s : SortdistflashSlice) -> Double { @_common.mean(s.data) }

pub fn sort_dist_flash_slice_scale(s : SortdistflashSlice, f : Double) -> SortdistflashSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_dist_flash_slice_add(a : SortdistflashSlice, b : SortdistflashSlice) -> SortdistflashSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_dist_flash_slice_copy(s : SortdistflashSlice) -> SortdistflashSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_dist_flash_slice_fill(s : SortdistflashSlice, v : Double) -> SortdistflashSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_dist_flash_slice_min(s : SortdistflashSlice) -> Double { @_common.min(s.data) }

pub fn sort_dist_flash_slice_max(s : SortdistflashSlice) -> Double { @_common.max(s.data) }

pub fn sort_dist_flash_slice_to_string(s : SortdistflashSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

