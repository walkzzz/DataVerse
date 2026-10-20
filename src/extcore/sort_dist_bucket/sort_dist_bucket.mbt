///===
/// extcore/sort_dist_bucket

pub(all) struct SortdistbucketPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn sort_dist_bucket_make_point(x : Double, y : Double) -> SortdistbucketPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn sort_dist_bucket_make_point3(x : Double, y : Double, z : Double) -> SortdistbucketPoint {
  { x, y, z, label: 0 }
}

pub fn SortdistbucketPoint::x(self : SortdistbucketPoint) -> Double { self.x }

pub fn SortdistbucketPoint::y(self : SortdistbucketPoint) -> Double { self.y }

pub fn SortdistbucketPoint::z(self : SortdistbucketPoint) -> Double { self.z }

pub fn SortdistbucketPoint::label(self : SortdistbucketPoint) -> Int { self.label }

pub fn SortdistbucketPoint::dist(self : SortdistbucketPoint, other : SortdistbucketPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn SortdistbucketPoint::add(self : SortdistbucketPoint, other : SortdistbucketPoint) -> SortdistbucketPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn SortdistbucketPoint::sub(self : SortdistbucketPoint, other : SortdistbucketPoint) -> SortdistbucketPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn SortdistbucketPoint::scale(self : SortdistbucketPoint, s : Double) -> SortdistbucketPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn SortdistbucketPoint::dot(self : SortdistbucketPoint, other : SortdistbucketPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn SortdistbucketPoint::cross(self : SortdistbucketPoint, other : SortdistbucketPoint) -> SortdistbucketPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn SortdistbucketPoint::norm(self : SortdistbucketPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn SortdistbucketPoint::normalize(self : SortdistbucketPoint) -> SortdistbucketPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn SortdistbucketPoint::negate(self : SortdistbucketPoint) -> SortdistbucketPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn SortdistbucketPoint::mid(self : SortdistbucketPoint, other : SortdistbucketPoint) -> SortdistbucketPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn SortdistbucketPoint::lerp(self : SortdistbucketPoint, other : SortdistbucketPoint, t : Double) -> SortdistbucketPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn SortdistbucketPoint::to_string(self : SortdistbucketPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct SortdistbucketSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn sort_dist_bucket_make_series(vals : Array[Double], name : String) -> SortdistbucketSeries {
  { vals, name, meta: 0 }
}

pub fn SortdistbucketSeries::len(self : SortdistbucketSeries) -> Int { self.vals.length() }

pub fn SortdistbucketSeries::sum(self : SortdistbucketSeries) -> Double { @_common.sum(self.vals) }

pub fn SortdistbucketSeries::mean(self : SortdistbucketSeries) -> Double { @_common.mean(self.vals) }

pub fn SortdistbucketSeries::min(self : SortdistbucketSeries) -> Double { @_common.min(self.vals) }

pub fn SortdistbucketSeries::max(self : SortdistbucketSeries) -> Double { @_common.max(self.vals) }

pub fn SortdistbucketSeries::range(self : SortdistbucketSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn SortdistbucketSeries::variance(self : SortdistbucketSeries) -> Double { @_common.variance(self.vals) }

pub fn SortdistbucketSeries::std(self : SortdistbucketSeries) -> Double { @_common.std(self.vals) }

pub fn SortdistbucketSeries::median(self : SortdistbucketSeries) -> Double { @_common.median(self.vals) }

pub fn SortdistbucketSeries::scale(self : SortdistbucketSeries, f : Double) -> SortdistbucketSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn SortdistbucketSeries::add(self : SortdistbucketSeries, other : SortdistbucketSeries) -> SortdistbucketSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn SortdistbucketSeries::sub(self : SortdistbucketSeries, other : SortdistbucketSeries) -> SortdistbucketSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn SortdistbucketSeries::normalize(self : SortdistbucketSeries) -> SortdistbucketSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn SortdistbucketSeries::cumsum(self : SortdistbucketSeries) -> SortdistbucketSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn SortdistbucketSeries::to_string(self : SortdistbucketSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct SortdistbucketMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn sort_dist_bucket_make_matrix(rows : Int, cols : Int, val : Double) -> SortdistbucketMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn sort_dist_bucket_matrix_identity(n : Int) -> SortdistbucketMatrix {
  let m = sort_dist_bucket_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn SortdistbucketMatrix::get(self : SortdistbucketMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn SortdistbucketMatrix::transpose(self : SortdistbucketMatrix) -> SortdistbucketMatrix {
  let result = sort_dist_bucket_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn SortdistbucketMatrix::add(self : SortdistbucketMatrix, other : SortdistbucketMatrix) -> SortdistbucketMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = sort_dist_bucket_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn SortdistbucketMatrix::scale(self : SortdistbucketMatrix, s : Double) -> SortdistbucketMatrix {
  let result = sort_dist_bucket_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn SortdistbucketMatrix::multiply(self : SortdistbucketMatrix, other : SortdistbucketMatrix) -> SortdistbucketMatrix {
  if self.cols != other.rows { return sort_dist_bucket_make_matrix(self.rows, other.cols, 0.0) }
  let result = sort_dist_bucket_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn SortdistbucketMatrix::trace(self : SortdistbucketMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn SortdistbucketMatrix::det(self : SortdistbucketMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn SortdistbucketMatrix::norm(self : SortdistbucketMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn SortdistbucketMatrix::to_string(self : SortdistbucketMatrix) -> String {
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

pub(all) struct SortdistbucketVector {
  comps : Array[Double]
  dim : Int
}

pub fn sort_dist_bucket_make_vector(comps : Array[Double]) -> SortdistbucketVector {
  { comps, dim: comps.length() }
}

pub fn sort_dist_bucket_vector_zero(dim : Int) -> SortdistbucketVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn SortdistbucketVector::add(self : SortdistbucketVector, other : SortdistbucketVector) -> SortdistbucketVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn SortdistbucketVector::sub(self : SortdistbucketVector, other : SortdistbucketVector) -> SortdistbucketVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn SortdistbucketVector::scale(self : SortdistbucketVector, s : Double) -> SortdistbucketVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn SortdistbucketVector::dot(self : SortdistbucketVector, other : SortdistbucketVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn SortdistbucketVector::norm(self : SortdistbucketVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn SortdistbucketVector::normalize(self : SortdistbucketVector) -> SortdistbucketVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn SortdistbucketVector::dist(self : SortdistbucketVector, other : SortdistbucketVector) -> Double {
  self.sub(other).norm()
}

pub fn SortdistbucketVector::to_string(self : SortdistbucketVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn sort_dist_bucket_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn sort_dist_bucket_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn sort_dist_bucket_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn sort_dist_bucket_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn sort_dist_bucket_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn sort_dist_bucket_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn sort_dist_bucket_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn sort_dist_bucket_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn sort_dist_bucket_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn sort_dist_bucket_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn sort_dist_bucket_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn sort_dist_bucket_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn sort_dist_bucket_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn sort_dist_bucket_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn sort_dist_bucket_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn sort_dist_bucket_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn sort_dist_bucket_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn sort_dist_bucket_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn sort_dist_bucket_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn sort_dist_bucket_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn sort_dist_bucket_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn sort_dist_bucket_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn sort_dist_bucket_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn sort_dist_bucket_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn sort_dist_bucket_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn sort_dist_bucket_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn sort_dist_bucket_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn sort_dist_bucket_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn sort_dist_bucket_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct SortdistbucketFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_dist_bucket_frame_make(size : Int) -> SortdistbucketFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_dist_bucket_frame_len(s : SortdistbucketFrame) -> Int { s.size }

pub fn sort_dist_bucket_frame_get(s : SortdistbucketFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_dist_bucket_frame_set(s : SortdistbucketFrame, i : Int, v : Double) -> SortdistbucketFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_dist_bucket_frame_sum(s : SortdistbucketFrame) -> Double { @_common.sum(s.data) }

pub fn sort_dist_bucket_frame_mean(s : SortdistbucketFrame) -> Double { @_common.mean(s.data) }

pub fn sort_dist_bucket_frame_scale(s : SortdistbucketFrame, f : Double) -> SortdistbucketFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_dist_bucket_frame_add(a : SortdistbucketFrame, b : SortdistbucketFrame) -> SortdistbucketFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_dist_bucket_frame_copy(s : SortdistbucketFrame) -> SortdistbucketFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_dist_bucket_frame_fill(s : SortdistbucketFrame, v : Double) -> SortdistbucketFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_dist_bucket_frame_min(s : SortdistbucketFrame) -> Double { @_common.min(s.data) }

pub fn sort_dist_bucket_frame_max(s : SortdistbucketFrame) -> Double { @_common.max(s.data) }

pub fn sort_dist_bucket_frame_to_string(s : SortdistbucketFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortdistbucketTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_dist_bucket_table_make(size : Int) -> SortdistbucketTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_dist_bucket_table_len(s : SortdistbucketTable) -> Int { s.size }

pub fn sort_dist_bucket_table_get(s : SortdistbucketTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_dist_bucket_table_set(s : SortdistbucketTable, i : Int, v : Double) -> SortdistbucketTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_dist_bucket_table_sum(s : SortdistbucketTable) -> Double { @_common.sum(s.data) }

pub fn sort_dist_bucket_table_mean(s : SortdistbucketTable) -> Double { @_common.mean(s.data) }

pub fn sort_dist_bucket_table_scale(s : SortdistbucketTable, f : Double) -> SortdistbucketTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_dist_bucket_table_add(a : SortdistbucketTable, b : SortdistbucketTable) -> SortdistbucketTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_dist_bucket_table_copy(s : SortdistbucketTable) -> SortdistbucketTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_dist_bucket_table_fill(s : SortdistbucketTable, v : Double) -> SortdistbucketTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_dist_bucket_table_min(s : SortdistbucketTable) -> Double { @_common.min(s.data) }

pub fn sort_dist_bucket_table_max(s : SortdistbucketTable) -> Double { @_common.max(s.data) }

pub fn sort_dist_bucket_table_to_string(s : SortdistbucketTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortdistbucketGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_dist_bucket_graphn_make(size : Int) -> SortdistbucketGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_dist_bucket_graphn_len(s : SortdistbucketGraphN) -> Int { s.size }

pub fn sort_dist_bucket_graphn_get(s : SortdistbucketGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_dist_bucket_graphn_set(s : SortdistbucketGraphN, i : Int, v : Double) -> SortdistbucketGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_dist_bucket_graphn_sum(s : SortdistbucketGraphN) -> Double { @_common.sum(s.data) }

pub fn sort_dist_bucket_graphn_mean(s : SortdistbucketGraphN) -> Double { @_common.mean(s.data) }

pub fn sort_dist_bucket_graphn_scale(s : SortdistbucketGraphN, f : Double) -> SortdistbucketGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_dist_bucket_graphn_add(a : SortdistbucketGraphN, b : SortdistbucketGraphN) -> SortdistbucketGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_dist_bucket_graphn_copy(s : SortdistbucketGraphN) -> SortdistbucketGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_dist_bucket_graphn_fill(s : SortdistbucketGraphN, v : Double) -> SortdistbucketGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_dist_bucket_graphn_min(s : SortdistbucketGraphN) -> Double { @_common.min(s.data) }

pub fn sort_dist_bucket_graphn_max(s : SortdistbucketGraphN) -> Double { @_common.max(s.data) }

pub fn sort_dist_bucket_graphn_to_string(s : SortdistbucketGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortdistbucketNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_dist_bucket_node_make(size : Int) -> SortdistbucketNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_dist_bucket_node_len(s : SortdistbucketNode) -> Int { s.size }

pub fn sort_dist_bucket_node_get(s : SortdistbucketNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_dist_bucket_node_set(s : SortdistbucketNode, i : Int, v : Double) -> SortdistbucketNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_dist_bucket_node_sum(s : SortdistbucketNode) -> Double { @_common.sum(s.data) }

pub fn sort_dist_bucket_node_mean(s : SortdistbucketNode) -> Double { @_common.mean(s.data) }

pub fn sort_dist_bucket_node_scale(s : SortdistbucketNode, f : Double) -> SortdistbucketNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_dist_bucket_node_add(a : SortdistbucketNode, b : SortdistbucketNode) -> SortdistbucketNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_dist_bucket_node_copy(s : SortdistbucketNode) -> SortdistbucketNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_dist_bucket_node_fill(s : SortdistbucketNode, v : Double) -> SortdistbucketNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_dist_bucket_node_min(s : SortdistbucketNode) -> Double { @_common.min(s.data) }

pub fn sort_dist_bucket_node_max(s : SortdistbucketNode) -> Double { @_common.max(s.data) }

pub fn sort_dist_bucket_node_to_string(s : SortdistbucketNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortdistbucketEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_dist_bucket_edge_make(size : Int) -> SortdistbucketEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_dist_bucket_edge_len(s : SortdistbucketEdge) -> Int { s.size }

pub fn sort_dist_bucket_edge_get(s : SortdistbucketEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_dist_bucket_edge_set(s : SortdistbucketEdge, i : Int, v : Double) -> SortdistbucketEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_dist_bucket_edge_sum(s : SortdistbucketEdge) -> Double { @_common.sum(s.data) }

pub fn sort_dist_bucket_edge_mean(s : SortdistbucketEdge) -> Double { @_common.mean(s.data) }

pub fn sort_dist_bucket_edge_scale(s : SortdistbucketEdge, f : Double) -> SortdistbucketEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_dist_bucket_edge_add(a : SortdistbucketEdge, b : SortdistbucketEdge) -> SortdistbucketEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_dist_bucket_edge_copy(s : SortdistbucketEdge) -> SortdistbucketEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_dist_bucket_edge_fill(s : SortdistbucketEdge, v : Double) -> SortdistbucketEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_dist_bucket_edge_min(s : SortdistbucketEdge) -> Double { @_common.min(s.data) }

pub fn sort_dist_bucket_edge_max(s : SortdistbucketEdge) -> Double { @_common.max(s.data) }

pub fn sort_dist_bucket_edge_to_string(s : SortdistbucketEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortdistbucketPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_dist_bucket_path_make(size : Int) -> SortdistbucketPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_dist_bucket_path_len(s : SortdistbucketPath) -> Int { s.size }

pub fn sort_dist_bucket_path_get(s : SortdistbucketPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_dist_bucket_path_set(s : SortdistbucketPath, i : Int, v : Double) -> SortdistbucketPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_dist_bucket_path_sum(s : SortdistbucketPath) -> Double { @_common.sum(s.data) }

pub fn sort_dist_bucket_path_mean(s : SortdistbucketPath) -> Double { @_common.mean(s.data) }

pub fn sort_dist_bucket_path_scale(s : SortdistbucketPath, f : Double) -> SortdistbucketPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_dist_bucket_path_add(a : SortdistbucketPath, b : SortdistbucketPath) -> SortdistbucketPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_dist_bucket_path_copy(s : SortdistbucketPath) -> SortdistbucketPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_dist_bucket_path_fill(s : SortdistbucketPath, v : Double) -> SortdistbucketPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_dist_bucket_path_min(s : SortdistbucketPath) -> Double { @_common.min(s.data) }

pub fn sort_dist_bucket_path_max(s : SortdistbucketPath) -> Double { @_common.max(s.data) }

pub fn sort_dist_bucket_path_to_string(s : SortdistbucketPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortdistbucketCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_dist_bucket_cluster_make(size : Int) -> SortdistbucketCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_dist_bucket_cluster_len(s : SortdistbucketCluster) -> Int { s.size }

pub fn sort_dist_bucket_cluster_get(s : SortdistbucketCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_dist_bucket_cluster_set(s : SortdistbucketCluster, i : Int, v : Double) -> SortdistbucketCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_dist_bucket_cluster_sum(s : SortdistbucketCluster) -> Double { @_common.sum(s.data) }

pub fn sort_dist_bucket_cluster_mean(s : SortdistbucketCluster) -> Double { @_common.mean(s.data) }

pub fn sort_dist_bucket_cluster_scale(s : SortdistbucketCluster, f : Double) -> SortdistbucketCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_dist_bucket_cluster_add(a : SortdistbucketCluster, b : SortdistbucketCluster) -> SortdistbucketCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_dist_bucket_cluster_copy(s : SortdistbucketCluster) -> SortdistbucketCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_dist_bucket_cluster_fill(s : SortdistbucketCluster, v : Double) -> SortdistbucketCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_dist_bucket_cluster_min(s : SortdistbucketCluster) -> Double { @_common.min(s.data) }

pub fn sort_dist_bucket_cluster_max(s : SortdistbucketCluster) -> Double { @_common.max(s.data) }

pub fn sort_dist_bucket_cluster_to_string(s : SortdistbucketCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortdistbucketModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_dist_bucket_model_make(size : Int) -> SortdistbucketModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_dist_bucket_model_len(s : SortdistbucketModel) -> Int { s.size }

pub fn sort_dist_bucket_model_get(s : SortdistbucketModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_dist_bucket_model_set(s : SortdistbucketModel, i : Int, v : Double) -> SortdistbucketModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_dist_bucket_model_sum(s : SortdistbucketModel) -> Double { @_common.sum(s.data) }

pub fn sort_dist_bucket_model_mean(s : SortdistbucketModel) -> Double { @_common.mean(s.data) }

pub fn sort_dist_bucket_model_scale(s : SortdistbucketModel, f : Double) -> SortdistbucketModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_dist_bucket_model_add(a : SortdistbucketModel, b : SortdistbucketModel) -> SortdistbucketModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_dist_bucket_model_copy(s : SortdistbucketModel) -> SortdistbucketModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_dist_bucket_model_fill(s : SortdistbucketModel, v : Double) -> SortdistbucketModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_dist_bucket_model_min(s : SortdistbucketModel) -> Double { @_common.min(s.data) }

pub fn sort_dist_bucket_model_max(s : SortdistbucketModel) -> Double { @_common.max(s.data) }

pub fn sort_dist_bucket_model_to_string(s : SortdistbucketModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortdistbucketLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_dist_bucket_layer_make(size : Int) -> SortdistbucketLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_dist_bucket_layer_len(s : SortdistbucketLayer) -> Int { s.size }

pub fn sort_dist_bucket_layer_get(s : SortdistbucketLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_dist_bucket_layer_set(s : SortdistbucketLayer, i : Int, v : Double) -> SortdistbucketLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_dist_bucket_layer_sum(s : SortdistbucketLayer) -> Double { @_common.sum(s.data) }

pub fn sort_dist_bucket_layer_mean(s : SortdistbucketLayer) -> Double { @_common.mean(s.data) }

pub fn sort_dist_bucket_layer_scale(s : SortdistbucketLayer, f : Double) -> SortdistbucketLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_dist_bucket_layer_add(a : SortdistbucketLayer, b : SortdistbucketLayer) -> SortdistbucketLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_dist_bucket_layer_copy(s : SortdistbucketLayer) -> SortdistbucketLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_dist_bucket_layer_fill(s : SortdistbucketLayer, v : Double) -> SortdistbucketLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_dist_bucket_layer_min(s : SortdistbucketLayer) -> Double { @_common.min(s.data) }

pub fn sort_dist_bucket_layer_max(s : SortdistbucketLayer) -> Double { @_common.max(s.data) }

pub fn sort_dist_bucket_layer_to_string(s : SortdistbucketLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortdistbucketBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_dist_bucket_buffer_make(size : Int) -> SortdistbucketBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_dist_bucket_buffer_len(s : SortdistbucketBuffer) -> Int { s.size }

pub fn sort_dist_bucket_buffer_get(s : SortdistbucketBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_dist_bucket_buffer_set(s : SortdistbucketBuffer, i : Int, v : Double) -> SortdistbucketBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_dist_bucket_buffer_sum(s : SortdistbucketBuffer) -> Double { @_common.sum(s.data) }

pub fn sort_dist_bucket_buffer_mean(s : SortdistbucketBuffer) -> Double { @_common.mean(s.data) }

pub fn sort_dist_bucket_buffer_scale(s : SortdistbucketBuffer, f : Double) -> SortdistbucketBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_dist_bucket_buffer_add(a : SortdistbucketBuffer, b : SortdistbucketBuffer) -> SortdistbucketBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_dist_bucket_buffer_copy(s : SortdistbucketBuffer) -> SortdistbucketBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_dist_bucket_buffer_fill(s : SortdistbucketBuffer, v : Double) -> SortdistbucketBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_dist_bucket_buffer_min(s : SortdistbucketBuffer) -> Double { @_common.min(s.data) }

pub fn sort_dist_bucket_buffer_max(s : SortdistbucketBuffer) -> Double { @_common.max(s.data) }

pub fn sort_dist_bucket_buffer_to_string(s : SortdistbucketBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortdistbucketCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_dist_bucket_cursor_make(size : Int) -> SortdistbucketCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_dist_bucket_cursor_len(s : SortdistbucketCursor) -> Int { s.size }

pub fn sort_dist_bucket_cursor_get(s : SortdistbucketCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_dist_bucket_cursor_set(s : SortdistbucketCursor, i : Int, v : Double) -> SortdistbucketCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_dist_bucket_cursor_sum(s : SortdistbucketCursor) -> Double { @_common.sum(s.data) }

pub fn sort_dist_bucket_cursor_mean(s : SortdistbucketCursor) -> Double { @_common.mean(s.data) }

pub fn sort_dist_bucket_cursor_scale(s : SortdistbucketCursor, f : Double) -> SortdistbucketCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_dist_bucket_cursor_add(a : SortdistbucketCursor, b : SortdistbucketCursor) -> SortdistbucketCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_dist_bucket_cursor_copy(s : SortdistbucketCursor) -> SortdistbucketCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_dist_bucket_cursor_fill(s : SortdistbucketCursor, v : Double) -> SortdistbucketCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_dist_bucket_cursor_min(s : SortdistbucketCursor) -> Double { @_common.min(s.data) }

pub fn sort_dist_bucket_cursor_max(s : SortdistbucketCursor) -> Double { @_common.max(s.data) }

pub fn sort_dist_bucket_cursor_to_string(s : SortdistbucketCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortdistbucketView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_dist_bucket_view_make(size : Int) -> SortdistbucketView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_dist_bucket_view_len(s : SortdistbucketView) -> Int { s.size }

pub fn sort_dist_bucket_view_get(s : SortdistbucketView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_dist_bucket_view_set(s : SortdistbucketView, i : Int, v : Double) -> SortdistbucketView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_dist_bucket_view_sum(s : SortdistbucketView) -> Double { @_common.sum(s.data) }

pub fn sort_dist_bucket_view_mean(s : SortdistbucketView) -> Double { @_common.mean(s.data) }

pub fn sort_dist_bucket_view_scale(s : SortdistbucketView, f : Double) -> SortdistbucketView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_dist_bucket_view_add(a : SortdistbucketView, b : SortdistbucketView) -> SortdistbucketView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_dist_bucket_view_copy(s : SortdistbucketView) -> SortdistbucketView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_dist_bucket_view_fill(s : SortdistbucketView, v : Double) -> SortdistbucketView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_dist_bucket_view_min(s : SortdistbucketView) -> Double { @_common.min(s.data) }

pub fn sort_dist_bucket_view_max(s : SortdistbucketView) -> Double { @_common.max(s.data) }

pub fn sort_dist_bucket_view_to_string(s : SortdistbucketView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortdistbucketRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_dist_bucket_range_make(size : Int) -> SortdistbucketRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_dist_bucket_range_len(s : SortdistbucketRange) -> Int { s.size }

pub fn sort_dist_bucket_range_get(s : SortdistbucketRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_dist_bucket_range_set(s : SortdistbucketRange, i : Int, v : Double) -> SortdistbucketRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_dist_bucket_range_sum(s : SortdistbucketRange) -> Double { @_common.sum(s.data) }

pub fn sort_dist_bucket_range_mean(s : SortdistbucketRange) -> Double { @_common.mean(s.data) }

pub fn sort_dist_bucket_range_scale(s : SortdistbucketRange, f : Double) -> SortdistbucketRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_dist_bucket_range_add(a : SortdistbucketRange, b : SortdistbucketRange) -> SortdistbucketRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_dist_bucket_range_copy(s : SortdistbucketRange) -> SortdistbucketRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_dist_bucket_range_fill(s : SortdistbucketRange, v : Double) -> SortdistbucketRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_dist_bucket_range_min(s : SortdistbucketRange) -> Double { @_common.min(s.data) }

pub fn sort_dist_bucket_range_max(s : SortdistbucketRange) -> Double { @_common.max(s.data) }

pub fn sort_dist_bucket_range_to_string(s : SortdistbucketRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortdistbucketSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_dist_bucket_slice_make(size : Int) -> SortdistbucketSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_dist_bucket_slice_len(s : SortdistbucketSlice) -> Int { s.size }

pub fn sort_dist_bucket_slice_get(s : SortdistbucketSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_dist_bucket_slice_set(s : SortdistbucketSlice, i : Int, v : Double) -> SortdistbucketSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_dist_bucket_slice_sum(s : SortdistbucketSlice) -> Double { @_common.sum(s.data) }

pub fn sort_dist_bucket_slice_mean(s : SortdistbucketSlice) -> Double { @_common.mean(s.data) }

pub fn sort_dist_bucket_slice_scale(s : SortdistbucketSlice, f : Double) -> SortdistbucketSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_dist_bucket_slice_add(a : SortdistbucketSlice, b : SortdistbucketSlice) -> SortdistbucketSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_dist_bucket_slice_copy(s : SortdistbucketSlice) -> SortdistbucketSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_dist_bucket_slice_fill(s : SortdistbucketSlice, v : Double) -> SortdistbucketSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_dist_bucket_slice_min(s : SortdistbucketSlice) -> Double { @_common.min(s.data) }

pub fn sort_dist_bucket_slice_max(s : SortdistbucketSlice) -> Double { @_common.max(s.data) }

pub fn sort_dist_bucket_slice_to_string(s : SortdistbucketSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

