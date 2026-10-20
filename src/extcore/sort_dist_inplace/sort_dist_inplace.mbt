///===
/// extcore/sort_dist_inplace

pub(all) struct SortdistinplacePoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn sort_dist_inplace_make_point(x : Double, y : Double) -> SortdistinplacePoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn sort_dist_inplace_make_point3(x : Double, y : Double, z : Double) -> SortdistinplacePoint {
  { x, y, z, label: 0 }
}

pub fn SortdistinplacePoint::x(self : SortdistinplacePoint) -> Double { self.x }

pub fn SortdistinplacePoint::y(self : SortdistinplacePoint) -> Double { self.y }

pub fn SortdistinplacePoint::z(self : SortdistinplacePoint) -> Double { self.z }

pub fn SortdistinplacePoint::label(self : SortdistinplacePoint) -> Int { self.label }

pub fn SortdistinplacePoint::dist(self : SortdistinplacePoint, other : SortdistinplacePoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn SortdistinplacePoint::add(self : SortdistinplacePoint, other : SortdistinplacePoint) -> SortdistinplacePoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn SortdistinplacePoint::sub(self : SortdistinplacePoint, other : SortdistinplacePoint) -> SortdistinplacePoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn SortdistinplacePoint::scale(self : SortdistinplacePoint, s : Double) -> SortdistinplacePoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn SortdistinplacePoint::dot(self : SortdistinplacePoint, other : SortdistinplacePoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn SortdistinplacePoint::cross(self : SortdistinplacePoint, other : SortdistinplacePoint) -> SortdistinplacePoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn SortdistinplacePoint::norm(self : SortdistinplacePoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn SortdistinplacePoint::normalize(self : SortdistinplacePoint) -> SortdistinplacePoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn SortdistinplacePoint::negate(self : SortdistinplacePoint) -> SortdistinplacePoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn SortdistinplacePoint::mid(self : SortdistinplacePoint, other : SortdistinplacePoint) -> SortdistinplacePoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn SortdistinplacePoint::lerp(self : SortdistinplacePoint, other : SortdistinplacePoint, t : Double) -> SortdistinplacePoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn SortdistinplacePoint::to_string(self : SortdistinplacePoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct SortdistinplaceSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn sort_dist_inplace_make_series(vals : Array[Double], name : String) -> SortdistinplaceSeries {
  { vals, name, meta: 0 }
}

pub fn SortdistinplaceSeries::len(self : SortdistinplaceSeries) -> Int { self.vals.length() }

pub fn SortdistinplaceSeries::sum(self : SortdistinplaceSeries) -> Double { @_common.sum(self.vals) }

pub fn SortdistinplaceSeries::mean(self : SortdistinplaceSeries) -> Double { @_common.mean(self.vals) }

pub fn SortdistinplaceSeries::min(self : SortdistinplaceSeries) -> Double { @_common.min(self.vals) }

pub fn SortdistinplaceSeries::max(self : SortdistinplaceSeries) -> Double { @_common.max(self.vals) }

pub fn SortdistinplaceSeries::range(self : SortdistinplaceSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn SortdistinplaceSeries::variance(self : SortdistinplaceSeries) -> Double { @_common.variance(self.vals) }

pub fn SortdistinplaceSeries::std(self : SortdistinplaceSeries) -> Double { @_common.std(self.vals) }

pub fn SortdistinplaceSeries::median(self : SortdistinplaceSeries) -> Double { @_common.median(self.vals) }

pub fn SortdistinplaceSeries::scale(self : SortdistinplaceSeries, f : Double) -> SortdistinplaceSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn SortdistinplaceSeries::add(self : SortdistinplaceSeries, other : SortdistinplaceSeries) -> SortdistinplaceSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn SortdistinplaceSeries::sub(self : SortdistinplaceSeries, other : SortdistinplaceSeries) -> SortdistinplaceSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn SortdistinplaceSeries::normalize(self : SortdistinplaceSeries) -> SortdistinplaceSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn SortdistinplaceSeries::cumsum(self : SortdistinplaceSeries) -> SortdistinplaceSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn SortdistinplaceSeries::to_string(self : SortdistinplaceSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct SortdistinplaceMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn sort_dist_inplace_make_matrix(rows : Int, cols : Int, val : Double) -> SortdistinplaceMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn sort_dist_inplace_matrix_identity(n : Int) -> SortdistinplaceMatrix {
  let m = sort_dist_inplace_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn SortdistinplaceMatrix::get(self : SortdistinplaceMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn SortdistinplaceMatrix::transpose(self : SortdistinplaceMatrix) -> SortdistinplaceMatrix {
  let result = sort_dist_inplace_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn SortdistinplaceMatrix::add(self : SortdistinplaceMatrix, other : SortdistinplaceMatrix) -> SortdistinplaceMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = sort_dist_inplace_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn SortdistinplaceMatrix::scale(self : SortdistinplaceMatrix, s : Double) -> SortdistinplaceMatrix {
  let result = sort_dist_inplace_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn SortdistinplaceMatrix::multiply(self : SortdistinplaceMatrix, other : SortdistinplaceMatrix) -> SortdistinplaceMatrix {
  if self.cols != other.rows { return sort_dist_inplace_make_matrix(self.rows, other.cols, 0.0) }
  let result = sort_dist_inplace_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn SortdistinplaceMatrix::trace(self : SortdistinplaceMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn SortdistinplaceMatrix::det(self : SortdistinplaceMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn SortdistinplaceMatrix::norm(self : SortdistinplaceMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn SortdistinplaceMatrix::to_string(self : SortdistinplaceMatrix) -> String {
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

pub(all) struct SortdistinplaceVector {
  comps : Array[Double]
  dim : Int
}

pub fn sort_dist_inplace_make_vector(comps : Array[Double]) -> SortdistinplaceVector {
  { comps, dim: comps.length() }
}

pub fn sort_dist_inplace_vector_zero(dim : Int) -> SortdistinplaceVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn SortdistinplaceVector::add(self : SortdistinplaceVector, other : SortdistinplaceVector) -> SortdistinplaceVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn SortdistinplaceVector::sub(self : SortdistinplaceVector, other : SortdistinplaceVector) -> SortdistinplaceVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn SortdistinplaceVector::scale(self : SortdistinplaceVector, s : Double) -> SortdistinplaceVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn SortdistinplaceVector::dot(self : SortdistinplaceVector, other : SortdistinplaceVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn SortdistinplaceVector::norm(self : SortdistinplaceVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn SortdistinplaceVector::normalize(self : SortdistinplaceVector) -> SortdistinplaceVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn SortdistinplaceVector::dist(self : SortdistinplaceVector, other : SortdistinplaceVector) -> Double {
  self.sub(other).norm()
}

pub fn SortdistinplaceVector::to_string(self : SortdistinplaceVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn sort_dist_inplace_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn sort_dist_inplace_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn sort_dist_inplace_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn sort_dist_inplace_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn sort_dist_inplace_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn sort_dist_inplace_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn sort_dist_inplace_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn sort_dist_inplace_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn sort_dist_inplace_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn sort_dist_inplace_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn sort_dist_inplace_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn sort_dist_inplace_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn sort_dist_inplace_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn sort_dist_inplace_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn sort_dist_inplace_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn sort_dist_inplace_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn sort_dist_inplace_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn sort_dist_inplace_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn sort_dist_inplace_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn sort_dist_inplace_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn sort_dist_inplace_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn sort_dist_inplace_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn sort_dist_inplace_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn sort_dist_inplace_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn sort_dist_inplace_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn sort_dist_inplace_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn sort_dist_inplace_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn sort_dist_inplace_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn sort_dist_inplace_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct SortdistinplaceFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_dist_inplace_frame_make(size : Int) -> SortdistinplaceFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_dist_inplace_frame_len(s : SortdistinplaceFrame) -> Int { s.size }

pub fn sort_dist_inplace_frame_get(s : SortdistinplaceFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_dist_inplace_frame_set(s : SortdistinplaceFrame, i : Int, v : Double) -> SortdistinplaceFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_dist_inplace_frame_sum(s : SortdistinplaceFrame) -> Double { @_common.sum(s.data) }

pub fn sort_dist_inplace_frame_mean(s : SortdistinplaceFrame) -> Double { @_common.mean(s.data) }

pub fn sort_dist_inplace_frame_scale(s : SortdistinplaceFrame, f : Double) -> SortdistinplaceFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_dist_inplace_frame_add(a : SortdistinplaceFrame, b : SortdistinplaceFrame) -> SortdistinplaceFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_dist_inplace_frame_copy(s : SortdistinplaceFrame) -> SortdistinplaceFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_dist_inplace_frame_fill(s : SortdistinplaceFrame, v : Double) -> SortdistinplaceFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_dist_inplace_frame_min(s : SortdistinplaceFrame) -> Double { @_common.min(s.data) }

pub fn sort_dist_inplace_frame_max(s : SortdistinplaceFrame) -> Double { @_common.max(s.data) }

pub fn sort_dist_inplace_frame_to_string(s : SortdistinplaceFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortdistinplaceTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_dist_inplace_table_make(size : Int) -> SortdistinplaceTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_dist_inplace_table_len(s : SortdistinplaceTable) -> Int { s.size }

pub fn sort_dist_inplace_table_get(s : SortdistinplaceTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_dist_inplace_table_set(s : SortdistinplaceTable, i : Int, v : Double) -> SortdistinplaceTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_dist_inplace_table_sum(s : SortdistinplaceTable) -> Double { @_common.sum(s.data) }

pub fn sort_dist_inplace_table_mean(s : SortdistinplaceTable) -> Double { @_common.mean(s.data) }

pub fn sort_dist_inplace_table_scale(s : SortdistinplaceTable, f : Double) -> SortdistinplaceTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_dist_inplace_table_add(a : SortdistinplaceTable, b : SortdistinplaceTable) -> SortdistinplaceTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_dist_inplace_table_copy(s : SortdistinplaceTable) -> SortdistinplaceTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_dist_inplace_table_fill(s : SortdistinplaceTable, v : Double) -> SortdistinplaceTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_dist_inplace_table_min(s : SortdistinplaceTable) -> Double { @_common.min(s.data) }

pub fn sort_dist_inplace_table_max(s : SortdistinplaceTable) -> Double { @_common.max(s.data) }

pub fn sort_dist_inplace_table_to_string(s : SortdistinplaceTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortdistinplaceGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_dist_inplace_graphn_make(size : Int) -> SortdistinplaceGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_dist_inplace_graphn_len(s : SortdistinplaceGraphN) -> Int { s.size }

pub fn sort_dist_inplace_graphn_get(s : SortdistinplaceGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_dist_inplace_graphn_set(s : SortdistinplaceGraphN, i : Int, v : Double) -> SortdistinplaceGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_dist_inplace_graphn_sum(s : SortdistinplaceGraphN) -> Double { @_common.sum(s.data) }

pub fn sort_dist_inplace_graphn_mean(s : SortdistinplaceGraphN) -> Double { @_common.mean(s.data) }

pub fn sort_dist_inplace_graphn_scale(s : SortdistinplaceGraphN, f : Double) -> SortdistinplaceGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_dist_inplace_graphn_add(a : SortdistinplaceGraphN, b : SortdistinplaceGraphN) -> SortdistinplaceGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_dist_inplace_graphn_copy(s : SortdistinplaceGraphN) -> SortdistinplaceGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_dist_inplace_graphn_fill(s : SortdistinplaceGraphN, v : Double) -> SortdistinplaceGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_dist_inplace_graphn_min(s : SortdistinplaceGraphN) -> Double { @_common.min(s.data) }

pub fn sort_dist_inplace_graphn_max(s : SortdistinplaceGraphN) -> Double { @_common.max(s.data) }

pub fn sort_dist_inplace_graphn_to_string(s : SortdistinplaceGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortdistinplaceNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_dist_inplace_node_make(size : Int) -> SortdistinplaceNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_dist_inplace_node_len(s : SortdistinplaceNode) -> Int { s.size }

pub fn sort_dist_inplace_node_get(s : SortdistinplaceNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_dist_inplace_node_set(s : SortdistinplaceNode, i : Int, v : Double) -> SortdistinplaceNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_dist_inplace_node_sum(s : SortdistinplaceNode) -> Double { @_common.sum(s.data) }

pub fn sort_dist_inplace_node_mean(s : SortdistinplaceNode) -> Double { @_common.mean(s.data) }

pub fn sort_dist_inplace_node_scale(s : SortdistinplaceNode, f : Double) -> SortdistinplaceNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_dist_inplace_node_add(a : SortdistinplaceNode, b : SortdistinplaceNode) -> SortdistinplaceNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_dist_inplace_node_copy(s : SortdistinplaceNode) -> SortdistinplaceNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_dist_inplace_node_fill(s : SortdistinplaceNode, v : Double) -> SortdistinplaceNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_dist_inplace_node_min(s : SortdistinplaceNode) -> Double { @_common.min(s.data) }

pub fn sort_dist_inplace_node_max(s : SortdistinplaceNode) -> Double { @_common.max(s.data) }

pub fn sort_dist_inplace_node_to_string(s : SortdistinplaceNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortdistinplaceEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_dist_inplace_edge_make(size : Int) -> SortdistinplaceEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_dist_inplace_edge_len(s : SortdistinplaceEdge) -> Int { s.size }

pub fn sort_dist_inplace_edge_get(s : SortdistinplaceEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_dist_inplace_edge_set(s : SortdistinplaceEdge, i : Int, v : Double) -> SortdistinplaceEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_dist_inplace_edge_sum(s : SortdistinplaceEdge) -> Double { @_common.sum(s.data) }

pub fn sort_dist_inplace_edge_mean(s : SortdistinplaceEdge) -> Double { @_common.mean(s.data) }

pub fn sort_dist_inplace_edge_scale(s : SortdistinplaceEdge, f : Double) -> SortdistinplaceEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_dist_inplace_edge_add(a : SortdistinplaceEdge, b : SortdistinplaceEdge) -> SortdistinplaceEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_dist_inplace_edge_copy(s : SortdistinplaceEdge) -> SortdistinplaceEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_dist_inplace_edge_fill(s : SortdistinplaceEdge, v : Double) -> SortdistinplaceEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_dist_inplace_edge_min(s : SortdistinplaceEdge) -> Double { @_common.min(s.data) }

pub fn sort_dist_inplace_edge_max(s : SortdistinplaceEdge) -> Double { @_common.max(s.data) }

pub fn sort_dist_inplace_edge_to_string(s : SortdistinplaceEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortdistinplacePath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_dist_inplace_path_make(size : Int) -> SortdistinplacePath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_dist_inplace_path_len(s : SortdistinplacePath) -> Int { s.size }

pub fn sort_dist_inplace_path_get(s : SortdistinplacePath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_dist_inplace_path_set(s : SortdistinplacePath, i : Int, v : Double) -> SortdistinplacePath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_dist_inplace_path_sum(s : SortdistinplacePath) -> Double { @_common.sum(s.data) }

pub fn sort_dist_inplace_path_mean(s : SortdistinplacePath) -> Double { @_common.mean(s.data) }

pub fn sort_dist_inplace_path_scale(s : SortdistinplacePath, f : Double) -> SortdistinplacePath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_dist_inplace_path_add(a : SortdistinplacePath, b : SortdistinplacePath) -> SortdistinplacePath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_dist_inplace_path_copy(s : SortdistinplacePath) -> SortdistinplacePath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_dist_inplace_path_fill(s : SortdistinplacePath, v : Double) -> SortdistinplacePath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_dist_inplace_path_min(s : SortdistinplacePath) -> Double { @_common.min(s.data) }

pub fn sort_dist_inplace_path_max(s : SortdistinplacePath) -> Double { @_common.max(s.data) }

pub fn sort_dist_inplace_path_to_string(s : SortdistinplacePath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortdistinplaceCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_dist_inplace_cluster_make(size : Int) -> SortdistinplaceCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_dist_inplace_cluster_len(s : SortdistinplaceCluster) -> Int { s.size }

pub fn sort_dist_inplace_cluster_get(s : SortdistinplaceCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_dist_inplace_cluster_set(s : SortdistinplaceCluster, i : Int, v : Double) -> SortdistinplaceCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_dist_inplace_cluster_sum(s : SortdistinplaceCluster) -> Double { @_common.sum(s.data) }

pub fn sort_dist_inplace_cluster_mean(s : SortdistinplaceCluster) -> Double { @_common.mean(s.data) }

pub fn sort_dist_inplace_cluster_scale(s : SortdistinplaceCluster, f : Double) -> SortdistinplaceCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_dist_inplace_cluster_add(a : SortdistinplaceCluster, b : SortdistinplaceCluster) -> SortdistinplaceCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_dist_inplace_cluster_copy(s : SortdistinplaceCluster) -> SortdistinplaceCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_dist_inplace_cluster_fill(s : SortdistinplaceCluster, v : Double) -> SortdistinplaceCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_dist_inplace_cluster_min(s : SortdistinplaceCluster) -> Double { @_common.min(s.data) }

pub fn sort_dist_inplace_cluster_max(s : SortdistinplaceCluster) -> Double { @_common.max(s.data) }

pub fn sort_dist_inplace_cluster_to_string(s : SortdistinplaceCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortdistinplaceModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_dist_inplace_model_make(size : Int) -> SortdistinplaceModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_dist_inplace_model_len(s : SortdistinplaceModel) -> Int { s.size }

pub fn sort_dist_inplace_model_get(s : SortdistinplaceModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_dist_inplace_model_set(s : SortdistinplaceModel, i : Int, v : Double) -> SortdistinplaceModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_dist_inplace_model_sum(s : SortdistinplaceModel) -> Double { @_common.sum(s.data) }

pub fn sort_dist_inplace_model_mean(s : SortdistinplaceModel) -> Double { @_common.mean(s.data) }

pub fn sort_dist_inplace_model_scale(s : SortdistinplaceModel, f : Double) -> SortdistinplaceModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_dist_inplace_model_add(a : SortdistinplaceModel, b : SortdistinplaceModel) -> SortdistinplaceModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_dist_inplace_model_copy(s : SortdistinplaceModel) -> SortdistinplaceModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_dist_inplace_model_fill(s : SortdistinplaceModel, v : Double) -> SortdistinplaceModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_dist_inplace_model_min(s : SortdistinplaceModel) -> Double { @_common.min(s.data) }

pub fn sort_dist_inplace_model_max(s : SortdistinplaceModel) -> Double { @_common.max(s.data) }

pub fn sort_dist_inplace_model_to_string(s : SortdistinplaceModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortdistinplaceLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_dist_inplace_layer_make(size : Int) -> SortdistinplaceLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_dist_inplace_layer_len(s : SortdistinplaceLayer) -> Int { s.size }

pub fn sort_dist_inplace_layer_get(s : SortdistinplaceLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_dist_inplace_layer_set(s : SortdistinplaceLayer, i : Int, v : Double) -> SortdistinplaceLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_dist_inplace_layer_sum(s : SortdistinplaceLayer) -> Double { @_common.sum(s.data) }

pub fn sort_dist_inplace_layer_mean(s : SortdistinplaceLayer) -> Double { @_common.mean(s.data) }

pub fn sort_dist_inplace_layer_scale(s : SortdistinplaceLayer, f : Double) -> SortdistinplaceLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_dist_inplace_layer_add(a : SortdistinplaceLayer, b : SortdistinplaceLayer) -> SortdistinplaceLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_dist_inplace_layer_copy(s : SortdistinplaceLayer) -> SortdistinplaceLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_dist_inplace_layer_fill(s : SortdistinplaceLayer, v : Double) -> SortdistinplaceLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_dist_inplace_layer_min(s : SortdistinplaceLayer) -> Double { @_common.min(s.data) }

pub fn sort_dist_inplace_layer_max(s : SortdistinplaceLayer) -> Double { @_common.max(s.data) }

pub fn sort_dist_inplace_layer_to_string(s : SortdistinplaceLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortdistinplaceBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_dist_inplace_buffer_make(size : Int) -> SortdistinplaceBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_dist_inplace_buffer_len(s : SortdistinplaceBuffer) -> Int { s.size }

pub fn sort_dist_inplace_buffer_get(s : SortdistinplaceBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_dist_inplace_buffer_set(s : SortdistinplaceBuffer, i : Int, v : Double) -> SortdistinplaceBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_dist_inplace_buffer_sum(s : SortdistinplaceBuffer) -> Double { @_common.sum(s.data) }

pub fn sort_dist_inplace_buffer_mean(s : SortdistinplaceBuffer) -> Double { @_common.mean(s.data) }

pub fn sort_dist_inplace_buffer_scale(s : SortdistinplaceBuffer, f : Double) -> SortdistinplaceBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_dist_inplace_buffer_add(a : SortdistinplaceBuffer, b : SortdistinplaceBuffer) -> SortdistinplaceBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_dist_inplace_buffer_copy(s : SortdistinplaceBuffer) -> SortdistinplaceBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_dist_inplace_buffer_fill(s : SortdistinplaceBuffer, v : Double) -> SortdistinplaceBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_dist_inplace_buffer_min(s : SortdistinplaceBuffer) -> Double { @_common.min(s.data) }

pub fn sort_dist_inplace_buffer_max(s : SortdistinplaceBuffer) -> Double { @_common.max(s.data) }

pub fn sort_dist_inplace_buffer_to_string(s : SortdistinplaceBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortdistinplaceCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_dist_inplace_cursor_make(size : Int) -> SortdistinplaceCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_dist_inplace_cursor_len(s : SortdistinplaceCursor) -> Int { s.size }

pub fn sort_dist_inplace_cursor_get(s : SortdistinplaceCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_dist_inplace_cursor_set(s : SortdistinplaceCursor, i : Int, v : Double) -> SortdistinplaceCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_dist_inplace_cursor_sum(s : SortdistinplaceCursor) -> Double { @_common.sum(s.data) }

pub fn sort_dist_inplace_cursor_mean(s : SortdistinplaceCursor) -> Double { @_common.mean(s.data) }

pub fn sort_dist_inplace_cursor_scale(s : SortdistinplaceCursor, f : Double) -> SortdistinplaceCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_dist_inplace_cursor_add(a : SortdistinplaceCursor, b : SortdistinplaceCursor) -> SortdistinplaceCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_dist_inplace_cursor_copy(s : SortdistinplaceCursor) -> SortdistinplaceCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_dist_inplace_cursor_fill(s : SortdistinplaceCursor, v : Double) -> SortdistinplaceCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_dist_inplace_cursor_min(s : SortdistinplaceCursor) -> Double { @_common.min(s.data) }

pub fn sort_dist_inplace_cursor_max(s : SortdistinplaceCursor) -> Double { @_common.max(s.data) }

pub fn sort_dist_inplace_cursor_to_string(s : SortdistinplaceCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortdistinplaceView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_dist_inplace_view_make(size : Int) -> SortdistinplaceView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_dist_inplace_view_len(s : SortdistinplaceView) -> Int { s.size }

pub fn sort_dist_inplace_view_get(s : SortdistinplaceView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_dist_inplace_view_set(s : SortdistinplaceView, i : Int, v : Double) -> SortdistinplaceView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_dist_inplace_view_sum(s : SortdistinplaceView) -> Double { @_common.sum(s.data) }

pub fn sort_dist_inplace_view_mean(s : SortdistinplaceView) -> Double { @_common.mean(s.data) }

pub fn sort_dist_inplace_view_scale(s : SortdistinplaceView, f : Double) -> SortdistinplaceView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_dist_inplace_view_add(a : SortdistinplaceView, b : SortdistinplaceView) -> SortdistinplaceView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_dist_inplace_view_copy(s : SortdistinplaceView) -> SortdistinplaceView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_dist_inplace_view_fill(s : SortdistinplaceView, v : Double) -> SortdistinplaceView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_dist_inplace_view_min(s : SortdistinplaceView) -> Double { @_common.min(s.data) }

pub fn sort_dist_inplace_view_max(s : SortdistinplaceView) -> Double { @_common.max(s.data) }

pub fn sort_dist_inplace_view_to_string(s : SortdistinplaceView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortdistinplaceRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_dist_inplace_range_make(size : Int) -> SortdistinplaceRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_dist_inplace_range_len(s : SortdistinplaceRange) -> Int { s.size }

pub fn sort_dist_inplace_range_get(s : SortdistinplaceRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_dist_inplace_range_set(s : SortdistinplaceRange, i : Int, v : Double) -> SortdistinplaceRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_dist_inplace_range_sum(s : SortdistinplaceRange) -> Double { @_common.sum(s.data) }

pub fn sort_dist_inplace_range_mean(s : SortdistinplaceRange) -> Double { @_common.mean(s.data) }

pub fn sort_dist_inplace_range_scale(s : SortdistinplaceRange, f : Double) -> SortdistinplaceRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_dist_inplace_range_add(a : SortdistinplaceRange, b : SortdistinplaceRange) -> SortdistinplaceRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_dist_inplace_range_copy(s : SortdistinplaceRange) -> SortdistinplaceRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_dist_inplace_range_fill(s : SortdistinplaceRange, v : Double) -> SortdistinplaceRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_dist_inplace_range_min(s : SortdistinplaceRange) -> Double { @_common.min(s.data) }

pub fn sort_dist_inplace_range_max(s : SortdistinplaceRange) -> Double { @_common.max(s.data) }

pub fn sort_dist_inplace_range_to_string(s : SortdistinplaceRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortdistinplaceSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_dist_inplace_slice_make(size : Int) -> SortdistinplaceSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_dist_inplace_slice_len(s : SortdistinplaceSlice) -> Int { s.size }

pub fn sort_dist_inplace_slice_get(s : SortdistinplaceSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_dist_inplace_slice_set(s : SortdistinplaceSlice, i : Int, v : Double) -> SortdistinplaceSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_dist_inplace_slice_sum(s : SortdistinplaceSlice) -> Double { @_common.sum(s.data) }

pub fn sort_dist_inplace_slice_mean(s : SortdistinplaceSlice) -> Double { @_common.mean(s.data) }

pub fn sort_dist_inplace_slice_scale(s : SortdistinplaceSlice, f : Double) -> SortdistinplaceSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_dist_inplace_slice_add(a : SortdistinplaceSlice, b : SortdistinplaceSlice) -> SortdistinplaceSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_dist_inplace_slice_copy(s : SortdistinplaceSlice) -> SortdistinplaceSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_dist_inplace_slice_fill(s : SortdistinplaceSlice, v : Double) -> SortdistinplaceSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_dist_inplace_slice_min(s : SortdistinplaceSlice) -> Double { @_common.min(s.data) }

pub fn sort_dist_inplace_slice_max(s : SortdistinplaceSlice) -> Double { @_common.max(s.data) }

pub fn sort_dist_inplace_slice_to_string(s : SortdistinplaceSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

