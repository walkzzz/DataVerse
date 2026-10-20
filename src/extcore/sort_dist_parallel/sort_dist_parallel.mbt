///===
/// extcore/sort_dist_parallel

pub(all) struct SortdistparallelPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn sort_dist_parallel_make_point(x : Double, y : Double) -> SortdistparallelPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn sort_dist_parallel_make_point3(x : Double, y : Double, z : Double) -> SortdistparallelPoint {
  { x, y, z, label: 0 }
}

pub fn SortdistparallelPoint::x(self : SortdistparallelPoint) -> Double { self.x }

pub fn SortdistparallelPoint::y(self : SortdistparallelPoint) -> Double { self.y }

pub fn SortdistparallelPoint::z(self : SortdistparallelPoint) -> Double { self.z }

pub fn SortdistparallelPoint::label(self : SortdistparallelPoint) -> Int { self.label }

pub fn SortdistparallelPoint::dist(self : SortdistparallelPoint, other : SortdistparallelPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn SortdistparallelPoint::add(self : SortdistparallelPoint, other : SortdistparallelPoint) -> SortdistparallelPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn SortdistparallelPoint::sub(self : SortdistparallelPoint, other : SortdistparallelPoint) -> SortdistparallelPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn SortdistparallelPoint::scale(self : SortdistparallelPoint, s : Double) -> SortdistparallelPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn SortdistparallelPoint::dot(self : SortdistparallelPoint, other : SortdistparallelPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn SortdistparallelPoint::cross(self : SortdistparallelPoint, other : SortdistparallelPoint) -> SortdistparallelPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn SortdistparallelPoint::norm(self : SortdistparallelPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn SortdistparallelPoint::normalize(self : SortdistparallelPoint) -> SortdistparallelPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn SortdistparallelPoint::negate(self : SortdistparallelPoint) -> SortdistparallelPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn SortdistparallelPoint::mid(self : SortdistparallelPoint, other : SortdistparallelPoint) -> SortdistparallelPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn SortdistparallelPoint::lerp(self : SortdistparallelPoint, other : SortdistparallelPoint, t : Double) -> SortdistparallelPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn SortdistparallelPoint::to_string(self : SortdistparallelPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct SortdistparallelSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn sort_dist_parallel_make_series(vals : Array[Double], name : String) -> SortdistparallelSeries {
  { vals, name, meta: 0 }
}

pub fn SortdistparallelSeries::len(self : SortdistparallelSeries) -> Int { self.vals.length() }

pub fn SortdistparallelSeries::sum(self : SortdistparallelSeries) -> Double { @_common.sum(self.vals) }

pub fn SortdistparallelSeries::mean(self : SortdistparallelSeries) -> Double { @_common.mean(self.vals) }

pub fn SortdistparallelSeries::min(self : SortdistparallelSeries) -> Double { @_common.min(self.vals) }

pub fn SortdistparallelSeries::max(self : SortdistparallelSeries) -> Double { @_common.max(self.vals) }

pub fn SortdistparallelSeries::range(self : SortdistparallelSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn SortdistparallelSeries::variance(self : SortdistparallelSeries) -> Double { @_common.variance(self.vals) }

pub fn SortdistparallelSeries::std(self : SortdistparallelSeries) -> Double { @_common.std(self.vals) }

pub fn SortdistparallelSeries::median(self : SortdistparallelSeries) -> Double { @_common.median(self.vals) }

pub fn SortdistparallelSeries::scale(self : SortdistparallelSeries, f : Double) -> SortdistparallelSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn SortdistparallelSeries::add(self : SortdistparallelSeries, other : SortdistparallelSeries) -> SortdistparallelSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn SortdistparallelSeries::sub(self : SortdistparallelSeries, other : SortdistparallelSeries) -> SortdistparallelSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn SortdistparallelSeries::normalize(self : SortdistparallelSeries) -> SortdistparallelSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn SortdistparallelSeries::cumsum(self : SortdistparallelSeries) -> SortdistparallelSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn SortdistparallelSeries::to_string(self : SortdistparallelSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct SortdistparallelMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn sort_dist_parallel_make_matrix(rows : Int, cols : Int, val : Double) -> SortdistparallelMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn sort_dist_parallel_matrix_identity(n : Int) -> SortdistparallelMatrix {
  let m = sort_dist_parallel_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn SortdistparallelMatrix::get(self : SortdistparallelMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn SortdistparallelMatrix::transpose(self : SortdistparallelMatrix) -> SortdistparallelMatrix {
  let result = sort_dist_parallel_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn SortdistparallelMatrix::add(self : SortdistparallelMatrix, other : SortdistparallelMatrix) -> SortdistparallelMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = sort_dist_parallel_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn SortdistparallelMatrix::scale(self : SortdistparallelMatrix, s : Double) -> SortdistparallelMatrix {
  let result = sort_dist_parallel_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn SortdistparallelMatrix::multiply(self : SortdistparallelMatrix, other : SortdistparallelMatrix) -> SortdistparallelMatrix {
  if self.cols != other.rows { return sort_dist_parallel_make_matrix(self.rows, other.cols, 0.0) }
  let result = sort_dist_parallel_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn SortdistparallelMatrix::trace(self : SortdistparallelMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn SortdistparallelMatrix::det(self : SortdistparallelMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn SortdistparallelMatrix::norm(self : SortdistparallelMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn SortdistparallelMatrix::to_string(self : SortdistparallelMatrix) -> String {
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

pub(all) struct SortdistparallelVector {
  comps : Array[Double]
  dim : Int
}

pub fn sort_dist_parallel_make_vector(comps : Array[Double]) -> SortdistparallelVector {
  { comps, dim: comps.length() }
}

pub fn sort_dist_parallel_vector_zero(dim : Int) -> SortdistparallelVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn SortdistparallelVector::add(self : SortdistparallelVector, other : SortdistparallelVector) -> SortdistparallelVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn SortdistparallelVector::sub(self : SortdistparallelVector, other : SortdistparallelVector) -> SortdistparallelVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn SortdistparallelVector::scale(self : SortdistparallelVector, s : Double) -> SortdistparallelVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn SortdistparallelVector::dot(self : SortdistparallelVector, other : SortdistparallelVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn SortdistparallelVector::norm(self : SortdistparallelVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn SortdistparallelVector::normalize(self : SortdistparallelVector) -> SortdistparallelVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn SortdistparallelVector::dist(self : SortdistparallelVector, other : SortdistparallelVector) -> Double {
  self.sub(other).norm()
}

pub fn SortdistparallelVector::to_string(self : SortdistparallelVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn sort_dist_parallel_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn sort_dist_parallel_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn sort_dist_parallel_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn sort_dist_parallel_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn sort_dist_parallel_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn sort_dist_parallel_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn sort_dist_parallel_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn sort_dist_parallel_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn sort_dist_parallel_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn sort_dist_parallel_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn sort_dist_parallel_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn sort_dist_parallel_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn sort_dist_parallel_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn sort_dist_parallel_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn sort_dist_parallel_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn sort_dist_parallel_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn sort_dist_parallel_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn sort_dist_parallel_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn sort_dist_parallel_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn sort_dist_parallel_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn sort_dist_parallel_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn sort_dist_parallel_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn sort_dist_parallel_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn sort_dist_parallel_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn sort_dist_parallel_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn sort_dist_parallel_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn sort_dist_parallel_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn sort_dist_parallel_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn sort_dist_parallel_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct SortdistparallelFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_dist_parallel_frame_make(size : Int) -> SortdistparallelFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_dist_parallel_frame_len(s : SortdistparallelFrame) -> Int { s.size }

pub fn sort_dist_parallel_frame_get(s : SortdistparallelFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_dist_parallel_frame_set(s : SortdistparallelFrame, i : Int, v : Double) -> SortdistparallelFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_dist_parallel_frame_sum(s : SortdistparallelFrame) -> Double { @_common.sum(s.data) }

pub fn sort_dist_parallel_frame_mean(s : SortdistparallelFrame) -> Double { @_common.mean(s.data) }

pub fn sort_dist_parallel_frame_scale(s : SortdistparallelFrame, f : Double) -> SortdistparallelFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_dist_parallel_frame_add(a : SortdistparallelFrame, b : SortdistparallelFrame) -> SortdistparallelFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_dist_parallel_frame_copy(s : SortdistparallelFrame) -> SortdistparallelFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_dist_parallel_frame_fill(s : SortdistparallelFrame, v : Double) -> SortdistparallelFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_dist_parallel_frame_min(s : SortdistparallelFrame) -> Double { @_common.min(s.data) }

pub fn sort_dist_parallel_frame_max(s : SortdistparallelFrame) -> Double { @_common.max(s.data) }

pub fn sort_dist_parallel_frame_to_string(s : SortdistparallelFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortdistparallelTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_dist_parallel_table_make(size : Int) -> SortdistparallelTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_dist_parallel_table_len(s : SortdistparallelTable) -> Int { s.size }

pub fn sort_dist_parallel_table_get(s : SortdistparallelTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_dist_parallel_table_set(s : SortdistparallelTable, i : Int, v : Double) -> SortdistparallelTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_dist_parallel_table_sum(s : SortdistparallelTable) -> Double { @_common.sum(s.data) }

pub fn sort_dist_parallel_table_mean(s : SortdistparallelTable) -> Double { @_common.mean(s.data) }

pub fn sort_dist_parallel_table_scale(s : SortdistparallelTable, f : Double) -> SortdistparallelTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_dist_parallel_table_add(a : SortdistparallelTable, b : SortdistparallelTable) -> SortdistparallelTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_dist_parallel_table_copy(s : SortdistparallelTable) -> SortdistparallelTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_dist_parallel_table_fill(s : SortdistparallelTable, v : Double) -> SortdistparallelTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_dist_parallel_table_min(s : SortdistparallelTable) -> Double { @_common.min(s.data) }

pub fn sort_dist_parallel_table_max(s : SortdistparallelTable) -> Double { @_common.max(s.data) }

pub fn sort_dist_parallel_table_to_string(s : SortdistparallelTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortdistparallelGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_dist_parallel_graphn_make(size : Int) -> SortdistparallelGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_dist_parallel_graphn_len(s : SortdistparallelGraphN) -> Int { s.size }

pub fn sort_dist_parallel_graphn_get(s : SortdistparallelGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_dist_parallel_graphn_set(s : SortdistparallelGraphN, i : Int, v : Double) -> SortdistparallelGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_dist_parallel_graphn_sum(s : SortdistparallelGraphN) -> Double { @_common.sum(s.data) }

pub fn sort_dist_parallel_graphn_mean(s : SortdistparallelGraphN) -> Double { @_common.mean(s.data) }

pub fn sort_dist_parallel_graphn_scale(s : SortdistparallelGraphN, f : Double) -> SortdistparallelGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_dist_parallel_graphn_add(a : SortdistparallelGraphN, b : SortdistparallelGraphN) -> SortdistparallelGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_dist_parallel_graphn_copy(s : SortdistparallelGraphN) -> SortdistparallelGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_dist_parallel_graphn_fill(s : SortdistparallelGraphN, v : Double) -> SortdistparallelGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_dist_parallel_graphn_min(s : SortdistparallelGraphN) -> Double { @_common.min(s.data) }

pub fn sort_dist_parallel_graphn_max(s : SortdistparallelGraphN) -> Double { @_common.max(s.data) }

pub fn sort_dist_parallel_graphn_to_string(s : SortdistparallelGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortdistparallelNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_dist_parallel_node_make(size : Int) -> SortdistparallelNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_dist_parallel_node_len(s : SortdistparallelNode) -> Int { s.size }

pub fn sort_dist_parallel_node_get(s : SortdistparallelNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_dist_parallel_node_set(s : SortdistparallelNode, i : Int, v : Double) -> SortdistparallelNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_dist_parallel_node_sum(s : SortdistparallelNode) -> Double { @_common.sum(s.data) }

pub fn sort_dist_parallel_node_mean(s : SortdistparallelNode) -> Double { @_common.mean(s.data) }

pub fn sort_dist_parallel_node_scale(s : SortdistparallelNode, f : Double) -> SortdistparallelNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_dist_parallel_node_add(a : SortdistparallelNode, b : SortdistparallelNode) -> SortdistparallelNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_dist_parallel_node_copy(s : SortdistparallelNode) -> SortdistparallelNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_dist_parallel_node_fill(s : SortdistparallelNode, v : Double) -> SortdistparallelNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_dist_parallel_node_min(s : SortdistparallelNode) -> Double { @_common.min(s.data) }

pub fn sort_dist_parallel_node_max(s : SortdistparallelNode) -> Double { @_common.max(s.data) }

pub fn sort_dist_parallel_node_to_string(s : SortdistparallelNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortdistparallelEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_dist_parallel_edge_make(size : Int) -> SortdistparallelEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_dist_parallel_edge_len(s : SortdistparallelEdge) -> Int { s.size }

pub fn sort_dist_parallel_edge_get(s : SortdistparallelEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_dist_parallel_edge_set(s : SortdistparallelEdge, i : Int, v : Double) -> SortdistparallelEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_dist_parallel_edge_sum(s : SortdistparallelEdge) -> Double { @_common.sum(s.data) }

pub fn sort_dist_parallel_edge_mean(s : SortdistparallelEdge) -> Double { @_common.mean(s.data) }

pub fn sort_dist_parallel_edge_scale(s : SortdistparallelEdge, f : Double) -> SortdistparallelEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_dist_parallel_edge_add(a : SortdistparallelEdge, b : SortdistparallelEdge) -> SortdistparallelEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_dist_parallel_edge_copy(s : SortdistparallelEdge) -> SortdistparallelEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_dist_parallel_edge_fill(s : SortdistparallelEdge, v : Double) -> SortdistparallelEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_dist_parallel_edge_min(s : SortdistparallelEdge) -> Double { @_common.min(s.data) }

pub fn sort_dist_parallel_edge_max(s : SortdistparallelEdge) -> Double { @_common.max(s.data) }

pub fn sort_dist_parallel_edge_to_string(s : SortdistparallelEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortdistparallelPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_dist_parallel_path_make(size : Int) -> SortdistparallelPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_dist_parallel_path_len(s : SortdistparallelPath) -> Int { s.size }

pub fn sort_dist_parallel_path_get(s : SortdistparallelPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_dist_parallel_path_set(s : SortdistparallelPath, i : Int, v : Double) -> SortdistparallelPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_dist_parallel_path_sum(s : SortdistparallelPath) -> Double { @_common.sum(s.data) }

pub fn sort_dist_parallel_path_mean(s : SortdistparallelPath) -> Double { @_common.mean(s.data) }

pub fn sort_dist_parallel_path_scale(s : SortdistparallelPath, f : Double) -> SortdistparallelPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_dist_parallel_path_add(a : SortdistparallelPath, b : SortdistparallelPath) -> SortdistparallelPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_dist_parallel_path_copy(s : SortdistparallelPath) -> SortdistparallelPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_dist_parallel_path_fill(s : SortdistparallelPath, v : Double) -> SortdistparallelPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_dist_parallel_path_min(s : SortdistparallelPath) -> Double { @_common.min(s.data) }

pub fn sort_dist_parallel_path_max(s : SortdistparallelPath) -> Double { @_common.max(s.data) }

pub fn sort_dist_parallel_path_to_string(s : SortdistparallelPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortdistparallelCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_dist_parallel_cluster_make(size : Int) -> SortdistparallelCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_dist_parallel_cluster_len(s : SortdistparallelCluster) -> Int { s.size }

pub fn sort_dist_parallel_cluster_get(s : SortdistparallelCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_dist_parallel_cluster_set(s : SortdistparallelCluster, i : Int, v : Double) -> SortdistparallelCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_dist_parallel_cluster_sum(s : SortdistparallelCluster) -> Double { @_common.sum(s.data) }

pub fn sort_dist_parallel_cluster_mean(s : SortdistparallelCluster) -> Double { @_common.mean(s.data) }

pub fn sort_dist_parallel_cluster_scale(s : SortdistparallelCluster, f : Double) -> SortdistparallelCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_dist_parallel_cluster_add(a : SortdistparallelCluster, b : SortdistparallelCluster) -> SortdistparallelCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_dist_parallel_cluster_copy(s : SortdistparallelCluster) -> SortdistparallelCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_dist_parallel_cluster_fill(s : SortdistparallelCluster, v : Double) -> SortdistparallelCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_dist_parallel_cluster_min(s : SortdistparallelCluster) -> Double { @_common.min(s.data) }

pub fn sort_dist_parallel_cluster_max(s : SortdistparallelCluster) -> Double { @_common.max(s.data) }

pub fn sort_dist_parallel_cluster_to_string(s : SortdistparallelCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortdistparallelModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_dist_parallel_model_make(size : Int) -> SortdistparallelModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_dist_parallel_model_len(s : SortdistparallelModel) -> Int { s.size }

pub fn sort_dist_parallel_model_get(s : SortdistparallelModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_dist_parallel_model_set(s : SortdistparallelModel, i : Int, v : Double) -> SortdistparallelModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_dist_parallel_model_sum(s : SortdistparallelModel) -> Double { @_common.sum(s.data) }

pub fn sort_dist_parallel_model_mean(s : SortdistparallelModel) -> Double { @_common.mean(s.data) }

pub fn sort_dist_parallel_model_scale(s : SortdistparallelModel, f : Double) -> SortdistparallelModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_dist_parallel_model_add(a : SortdistparallelModel, b : SortdistparallelModel) -> SortdistparallelModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_dist_parallel_model_copy(s : SortdistparallelModel) -> SortdistparallelModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_dist_parallel_model_fill(s : SortdistparallelModel, v : Double) -> SortdistparallelModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_dist_parallel_model_min(s : SortdistparallelModel) -> Double { @_common.min(s.data) }

pub fn sort_dist_parallel_model_max(s : SortdistparallelModel) -> Double { @_common.max(s.data) }

pub fn sort_dist_parallel_model_to_string(s : SortdistparallelModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortdistparallelLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_dist_parallel_layer_make(size : Int) -> SortdistparallelLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_dist_parallel_layer_len(s : SortdistparallelLayer) -> Int { s.size }

pub fn sort_dist_parallel_layer_get(s : SortdistparallelLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_dist_parallel_layer_set(s : SortdistparallelLayer, i : Int, v : Double) -> SortdistparallelLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_dist_parallel_layer_sum(s : SortdistparallelLayer) -> Double { @_common.sum(s.data) }

pub fn sort_dist_parallel_layer_mean(s : SortdistparallelLayer) -> Double { @_common.mean(s.data) }

pub fn sort_dist_parallel_layer_scale(s : SortdistparallelLayer, f : Double) -> SortdistparallelLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_dist_parallel_layer_add(a : SortdistparallelLayer, b : SortdistparallelLayer) -> SortdistparallelLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_dist_parallel_layer_copy(s : SortdistparallelLayer) -> SortdistparallelLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_dist_parallel_layer_fill(s : SortdistparallelLayer, v : Double) -> SortdistparallelLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_dist_parallel_layer_min(s : SortdistparallelLayer) -> Double { @_common.min(s.data) }

pub fn sort_dist_parallel_layer_max(s : SortdistparallelLayer) -> Double { @_common.max(s.data) }

pub fn sort_dist_parallel_layer_to_string(s : SortdistparallelLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortdistparallelBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_dist_parallel_buffer_make(size : Int) -> SortdistparallelBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_dist_parallel_buffer_len(s : SortdistparallelBuffer) -> Int { s.size }

pub fn sort_dist_parallel_buffer_get(s : SortdistparallelBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_dist_parallel_buffer_set(s : SortdistparallelBuffer, i : Int, v : Double) -> SortdistparallelBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_dist_parallel_buffer_sum(s : SortdistparallelBuffer) -> Double { @_common.sum(s.data) }

pub fn sort_dist_parallel_buffer_mean(s : SortdistparallelBuffer) -> Double { @_common.mean(s.data) }

pub fn sort_dist_parallel_buffer_scale(s : SortdistparallelBuffer, f : Double) -> SortdistparallelBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_dist_parallel_buffer_add(a : SortdistparallelBuffer, b : SortdistparallelBuffer) -> SortdistparallelBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_dist_parallel_buffer_copy(s : SortdistparallelBuffer) -> SortdistparallelBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_dist_parallel_buffer_fill(s : SortdistparallelBuffer, v : Double) -> SortdistparallelBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_dist_parallel_buffer_min(s : SortdistparallelBuffer) -> Double { @_common.min(s.data) }

pub fn sort_dist_parallel_buffer_max(s : SortdistparallelBuffer) -> Double { @_common.max(s.data) }

pub fn sort_dist_parallel_buffer_to_string(s : SortdistparallelBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortdistparallelCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_dist_parallel_cursor_make(size : Int) -> SortdistparallelCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_dist_parallel_cursor_len(s : SortdistparallelCursor) -> Int { s.size }

pub fn sort_dist_parallel_cursor_get(s : SortdistparallelCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_dist_parallel_cursor_set(s : SortdistparallelCursor, i : Int, v : Double) -> SortdistparallelCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_dist_parallel_cursor_sum(s : SortdistparallelCursor) -> Double { @_common.sum(s.data) }

pub fn sort_dist_parallel_cursor_mean(s : SortdistparallelCursor) -> Double { @_common.mean(s.data) }

pub fn sort_dist_parallel_cursor_scale(s : SortdistparallelCursor, f : Double) -> SortdistparallelCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_dist_parallel_cursor_add(a : SortdistparallelCursor, b : SortdistparallelCursor) -> SortdistparallelCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_dist_parallel_cursor_copy(s : SortdistparallelCursor) -> SortdistparallelCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_dist_parallel_cursor_fill(s : SortdistparallelCursor, v : Double) -> SortdistparallelCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_dist_parallel_cursor_min(s : SortdistparallelCursor) -> Double { @_common.min(s.data) }

pub fn sort_dist_parallel_cursor_max(s : SortdistparallelCursor) -> Double { @_common.max(s.data) }

pub fn sort_dist_parallel_cursor_to_string(s : SortdistparallelCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortdistparallelView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_dist_parallel_view_make(size : Int) -> SortdistparallelView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_dist_parallel_view_len(s : SortdistparallelView) -> Int { s.size }

pub fn sort_dist_parallel_view_get(s : SortdistparallelView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_dist_parallel_view_set(s : SortdistparallelView, i : Int, v : Double) -> SortdistparallelView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_dist_parallel_view_sum(s : SortdistparallelView) -> Double { @_common.sum(s.data) }

pub fn sort_dist_parallel_view_mean(s : SortdistparallelView) -> Double { @_common.mean(s.data) }

pub fn sort_dist_parallel_view_scale(s : SortdistparallelView, f : Double) -> SortdistparallelView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_dist_parallel_view_add(a : SortdistparallelView, b : SortdistparallelView) -> SortdistparallelView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_dist_parallel_view_copy(s : SortdistparallelView) -> SortdistparallelView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_dist_parallel_view_fill(s : SortdistparallelView, v : Double) -> SortdistparallelView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_dist_parallel_view_min(s : SortdistparallelView) -> Double { @_common.min(s.data) }

pub fn sort_dist_parallel_view_max(s : SortdistparallelView) -> Double { @_common.max(s.data) }

pub fn sort_dist_parallel_view_to_string(s : SortdistparallelView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortdistparallelRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_dist_parallel_range_make(size : Int) -> SortdistparallelRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_dist_parallel_range_len(s : SortdistparallelRange) -> Int { s.size }

pub fn sort_dist_parallel_range_get(s : SortdistparallelRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_dist_parallel_range_set(s : SortdistparallelRange, i : Int, v : Double) -> SortdistparallelRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_dist_parallel_range_sum(s : SortdistparallelRange) -> Double { @_common.sum(s.data) }

pub fn sort_dist_parallel_range_mean(s : SortdistparallelRange) -> Double { @_common.mean(s.data) }

pub fn sort_dist_parallel_range_scale(s : SortdistparallelRange, f : Double) -> SortdistparallelRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_dist_parallel_range_add(a : SortdistparallelRange, b : SortdistparallelRange) -> SortdistparallelRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_dist_parallel_range_copy(s : SortdistparallelRange) -> SortdistparallelRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_dist_parallel_range_fill(s : SortdistparallelRange, v : Double) -> SortdistparallelRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_dist_parallel_range_min(s : SortdistparallelRange) -> Double { @_common.min(s.data) }

pub fn sort_dist_parallel_range_max(s : SortdistparallelRange) -> Double { @_common.max(s.data) }

pub fn sort_dist_parallel_range_to_string(s : SortdistparallelRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortdistparallelSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_dist_parallel_slice_make(size : Int) -> SortdistparallelSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_dist_parallel_slice_len(s : SortdistparallelSlice) -> Int { s.size }

pub fn sort_dist_parallel_slice_get(s : SortdistparallelSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_dist_parallel_slice_set(s : SortdistparallelSlice, i : Int, v : Double) -> SortdistparallelSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_dist_parallel_slice_sum(s : SortdistparallelSlice) -> Double { @_common.sum(s.data) }

pub fn sort_dist_parallel_slice_mean(s : SortdistparallelSlice) -> Double { @_common.mean(s.data) }

pub fn sort_dist_parallel_slice_scale(s : SortdistparallelSlice, f : Double) -> SortdistparallelSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_dist_parallel_slice_add(a : SortdistparallelSlice, b : SortdistparallelSlice) -> SortdistparallelSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_dist_parallel_slice_copy(s : SortdistparallelSlice) -> SortdistparallelSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_dist_parallel_slice_fill(s : SortdistparallelSlice, v : Double) -> SortdistparallelSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_dist_parallel_slice_min(s : SortdistparallelSlice) -> Double { @_common.min(s.data) }

pub fn sort_dist_parallel_slice_max(s : SortdistparallelSlice) -> Double { @_common.max(s.data) }

pub fn sort_dist_parallel_slice_to_string(s : SortdistparallelSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

