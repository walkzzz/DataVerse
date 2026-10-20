///===
/// extcore/sort_dist_pigeonhole

pub(all) struct SortdistpigeonholePoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn sort_dist_pigeonhole_make_point(x : Double, y : Double) -> SortdistpigeonholePoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn sort_dist_pigeonhole_make_point3(x : Double, y : Double, z : Double) -> SortdistpigeonholePoint {
  { x, y, z, label: 0 }
}

pub fn SortdistpigeonholePoint::x(self : SortdistpigeonholePoint) -> Double { self.x }

pub fn SortdistpigeonholePoint::y(self : SortdistpigeonholePoint) -> Double { self.y }

pub fn SortdistpigeonholePoint::z(self : SortdistpigeonholePoint) -> Double { self.z }

pub fn SortdistpigeonholePoint::label(self : SortdistpigeonholePoint) -> Int { self.label }

pub fn SortdistpigeonholePoint::dist(self : SortdistpigeonholePoint, other : SortdistpigeonholePoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn SortdistpigeonholePoint::add(self : SortdistpigeonholePoint, other : SortdistpigeonholePoint) -> SortdistpigeonholePoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn SortdistpigeonholePoint::sub(self : SortdistpigeonholePoint, other : SortdistpigeonholePoint) -> SortdistpigeonholePoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn SortdistpigeonholePoint::scale(self : SortdistpigeonholePoint, s : Double) -> SortdistpigeonholePoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn SortdistpigeonholePoint::dot(self : SortdistpigeonholePoint, other : SortdistpigeonholePoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn SortdistpigeonholePoint::cross(self : SortdistpigeonholePoint, other : SortdistpigeonholePoint) -> SortdistpigeonholePoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn SortdistpigeonholePoint::norm(self : SortdistpigeonholePoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn SortdistpigeonholePoint::normalize(self : SortdistpigeonholePoint) -> SortdistpigeonholePoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn SortdistpigeonholePoint::negate(self : SortdistpigeonholePoint) -> SortdistpigeonholePoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn SortdistpigeonholePoint::mid(self : SortdistpigeonholePoint, other : SortdistpigeonholePoint) -> SortdistpigeonholePoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn SortdistpigeonholePoint::lerp(self : SortdistpigeonholePoint, other : SortdistpigeonholePoint, t : Double) -> SortdistpigeonholePoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn SortdistpigeonholePoint::to_string(self : SortdistpigeonholePoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct SortdistpigeonholeSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn sort_dist_pigeonhole_make_series(vals : Array[Double], name : String) -> SortdistpigeonholeSeries {
  { vals, name, meta: 0 }
}

pub fn SortdistpigeonholeSeries::len(self : SortdistpigeonholeSeries) -> Int { self.vals.length() }

pub fn SortdistpigeonholeSeries::sum(self : SortdistpigeonholeSeries) -> Double { @_common.sum(self.vals) }

pub fn SortdistpigeonholeSeries::mean(self : SortdistpigeonholeSeries) -> Double { @_common.mean(self.vals) }

pub fn SortdistpigeonholeSeries::min(self : SortdistpigeonholeSeries) -> Double { @_common.min(self.vals) }

pub fn SortdistpigeonholeSeries::max(self : SortdistpigeonholeSeries) -> Double { @_common.max(self.vals) }

pub fn SortdistpigeonholeSeries::range(self : SortdistpigeonholeSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn SortdistpigeonholeSeries::variance(self : SortdistpigeonholeSeries) -> Double { @_common.variance(self.vals) }

pub fn SortdistpigeonholeSeries::std(self : SortdistpigeonholeSeries) -> Double { @_common.std(self.vals) }

pub fn SortdistpigeonholeSeries::median(self : SortdistpigeonholeSeries) -> Double { @_common.median(self.vals) }

pub fn SortdistpigeonholeSeries::scale(self : SortdistpigeonholeSeries, f : Double) -> SortdistpigeonholeSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn SortdistpigeonholeSeries::add(self : SortdistpigeonholeSeries, other : SortdistpigeonholeSeries) -> SortdistpigeonholeSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn SortdistpigeonholeSeries::sub(self : SortdistpigeonholeSeries, other : SortdistpigeonholeSeries) -> SortdistpigeonholeSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn SortdistpigeonholeSeries::normalize(self : SortdistpigeonholeSeries) -> SortdistpigeonholeSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn SortdistpigeonholeSeries::cumsum(self : SortdistpigeonholeSeries) -> SortdistpigeonholeSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn SortdistpigeonholeSeries::to_string(self : SortdistpigeonholeSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct SortdistpigeonholeMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn sort_dist_pigeonhole_make_matrix(rows : Int, cols : Int, val : Double) -> SortdistpigeonholeMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn sort_dist_pigeonhole_matrix_identity(n : Int) -> SortdistpigeonholeMatrix {
  let m = sort_dist_pigeonhole_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn SortdistpigeonholeMatrix::get(self : SortdistpigeonholeMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn SortdistpigeonholeMatrix::transpose(self : SortdistpigeonholeMatrix) -> SortdistpigeonholeMatrix {
  let result = sort_dist_pigeonhole_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn SortdistpigeonholeMatrix::add(self : SortdistpigeonholeMatrix, other : SortdistpigeonholeMatrix) -> SortdistpigeonholeMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = sort_dist_pigeonhole_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn SortdistpigeonholeMatrix::scale(self : SortdistpigeonholeMatrix, s : Double) -> SortdistpigeonholeMatrix {
  let result = sort_dist_pigeonhole_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn SortdistpigeonholeMatrix::multiply(self : SortdistpigeonholeMatrix, other : SortdistpigeonholeMatrix) -> SortdistpigeonholeMatrix {
  if self.cols != other.rows { return sort_dist_pigeonhole_make_matrix(self.rows, other.cols, 0.0) }
  let result = sort_dist_pigeonhole_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn SortdistpigeonholeMatrix::trace(self : SortdistpigeonholeMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn SortdistpigeonholeMatrix::det(self : SortdistpigeonholeMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn SortdistpigeonholeMatrix::norm(self : SortdistpigeonholeMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn SortdistpigeonholeMatrix::to_string(self : SortdistpigeonholeMatrix) -> String {
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

pub(all) struct SortdistpigeonholeVector {
  comps : Array[Double]
  dim : Int
}

pub fn sort_dist_pigeonhole_make_vector(comps : Array[Double]) -> SortdistpigeonholeVector {
  { comps, dim: comps.length() }
}

pub fn sort_dist_pigeonhole_vector_zero(dim : Int) -> SortdistpigeonholeVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn SortdistpigeonholeVector::add(self : SortdistpigeonholeVector, other : SortdistpigeonholeVector) -> SortdistpigeonholeVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn SortdistpigeonholeVector::sub(self : SortdistpigeonholeVector, other : SortdistpigeonholeVector) -> SortdistpigeonholeVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn SortdistpigeonholeVector::scale(self : SortdistpigeonholeVector, s : Double) -> SortdistpigeonholeVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn SortdistpigeonholeVector::dot(self : SortdistpigeonholeVector, other : SortdistpigeonholeVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn SortdistpigeonholeVector::norm(self : SortdistpigeonholeVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn SortdistpigeonholeVector::normalize(self : SortdistpigeonholeVector) -> SortdistpigeonholeVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn SortdistpigeonholeVector::dist(self : SortdistpigeonholeVector, other : SortdistpigeonholeVector) -> Double {
  self.sub(other).norm()
}

pub fn SortdistpigeonholeVector::to_string(self : SortdistpigeonholeVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn sort_dist_pigeonhole_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn sort_dist_pigeonhole_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn sort_dist_pigeonhole_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn sort_dist_pigeonhole_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn sort_dist_pigeonhole_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn sort_dist_pigeonhole_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn sort_dist_pigeonhole_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn sort_dist_pigeonhole_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn sort_dist_pigeonhole_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn sort_dist_pigeonhole_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn sort_dist_pigeonhole_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn sort_dist_pigeonhole_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn sort_dist_pigeonhole_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn sort_dist_pigeonhole_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn sort_dist_pigeonhole_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn sort_dist_pigeonhole_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn sort_dist_pigeonhole_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn sort_dist_pigeonhole_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn sort_dist_pigeonhole_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn sort_dist_pigeonhole_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn sort_dist_pigeonhole_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn sort_dist_pigeonhole_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn sort_dist_pigeonhole_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn sort_dist_pigeonhole_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn sort_dist_pigeonhole_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn sort_dist_pigeonhole_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn sort_dist_pigeonhole_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn sort_dist_pigeonhole_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn sort_dist_pigeonhole_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct SortdistpigeonholeFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_dist_pigeonhole_frame_make(size : Int) -> SortdistpigeonholeFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_dist_pigeonhole_frame_len(s : SortdistpigeonholeFrame) -> Int { s.size }

pub fn sort_dist_pigeonhole_frame_get(s : SortdistpigeonholeFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_dist_pigeonhole_frame_set(s : SortdistpigeonholeFrame, i : Int, v : Double) -> SortdistpigeonholeFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_dist_pigeonhole_frame_sum(s : SortdistpigeonholeFrame) -> Double { @_common.sum(s.data) }

pub fn sort_dist_pigeonhole_frame_mean(s : SortdistpigeonholeFrame) -> Double { @_common.mean(s.data) }

pub fn sort_dist_pigeonhole_frame_scale(s : SortdistpigeonholeFrame, f : Double) -> SortdistpigeonholeFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_dist_pigeonhole_frame_add(a : SortdistpigeonholeFrame, b : SortdistpigeonholeFrame) -> SortdistpigeonholeFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_dist_pigeonhole_frame_copy(s : SortdistpigeonholeFrame) -> SortdistpigeonholeFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_dist_pigeonhole_frame_fill(s : SortdistpigeonholeFrame, v : Double) -> SortdistpigeonholeFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_dist_pigeonhole_frame_min(s : SortdistpigeonholeFrame) -> Double { @_common.min(s.data) }

pub fn sort_dist_pigeonhole_frame_max(s : SortdistpigeonholeFrame) -> Double { @_common.max(s.data) }

pub fn sort_dist_pigeonhole_frame_to_string(s : SortdistpigeonholeFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortdistpigeonholeTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_dist_pigeonhole_table_make(size : Int) -> SortdistpigeonholeTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_dist_pigeonhole_table_len(s : SortdistpigeonholeTable) -> Int { s.size }

pub fn sort_dist_pigeonhole_table_get(s : SortdistpigeonholeTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_dist_pigeonhole_table_set(s : SortdistpigeonholeTable, i : Int, v : Double) -> SortdistpigeonholeTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_dist_pigeonhole_table_sum(s : SortdistpigeonholeTable) -> Double { @_common.sum(s.data) }

pub fn sort_dist_pigeonhole_table_mean(s : SortdistpigeonholeTable) -> Double { @_common.mean(s.data) }

pub fn sort_dist_pigeonhole_table_scale(s : SortdistpigeonholeTable, f : Double) -> SortdistpigeonholeTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_dist_pigeonhole_table_add(a : SortdistpigeonholeTable, b : SortdistpigeonholeTable) -> SortdistpigeonholeTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_dist_pigeonhole_table_copy(s : SortdistpigeonholeTable) -> SortdistpigeonholeTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_dist_pigeonhole_table_fill(s : SortdistpigeonholeTable, v : Double) -> SortdistpigeonholeTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_dist_pigeonhole_table_min(s : SortdistpigeonholeTable) -> Double { @_common.min(s.data) }

pub fn sort_dist_pigeonhole_table_max(s : SortdistpigeonholeTable) -> Double { @_common.max(s.data) }

pub fn sort_dist_pigeonhole_table_to_string(s : SortdistpigeonholeTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortdistpigeonholeGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_dist_pigeonhole_graphn_make(size : Int) -> SortdistpigeonholeGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_dist_pigeonhole_graphn_len(s : SortdistpigeonholeGraphN) -> Int { s.size }

pub fn sort_dist_pigeonhole_graphn_get(s : SortdistpigeonholeGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_dist_pigeonhole_graphn_set(s : SortdistpigeonholeGraphN, i : Int, v : Double) -> SortdistpigeonholeGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_dist_pigeonhole_graphn_sum(s : SortdistpigeonholeGraphN) -> Double { @_common.sum(s.data) }

pub fn sort_dist_pigeonhole_graphn_mean(s : SortdistpigeonholeGraphN) -> Double { @_common.mean(s.data) }

pub fn sort_dist_pigeonhole_graphn_scale(s : SortdistpigeonholeGraphN, f : Double) -> SortdistpigeonholeGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_dist_pigeonhole_graphn_add(a : SortdistpigeonholeGraphN, b : SortdistpigeonholeGraphN) -> SortdistpigeonholeGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_dist_pigeonhole_graphn_copy(s : SortdistpigeonholeGraphN) -> SortdistpigeonholeGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_dist_pigeonhole_graphn_fill(s : SortdistpigeonholeGraphN, v : Double) -> SortdistpigeonholeGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_dist_pigeonhole_graphn_min(s : SortdistpigeonholeGraphN) -> Double { @_common.min(s.data) }

pub fn sort_dist_pigeonhole_graphn_max(s : SortdistpigeonholeGraphN) -> Double { @_common.max(s.data) }

pub fn sort_dist_pigeonhole_graphn_to_string(s : SortdistpigeonholeGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortdistpigeonholeNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_dist_pigeonhole_node_make(size : Int) -> SortdistpigeonholeNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_dist_pigeonhole_node_len(s : SortdistpigeonholeNode) -> Int { s.size }

pub fn sort_dist_pigeonhole_node_get(s : SortdistpigeonholeNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_dist_pigeonhole_node_set(s : SortdistpigeonholeNode, i : Int, v : Double) -> SortdistpigeonholeNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_dist_pigeonhole_node_sum(s : SortdistpigeonholeNode) -> Double { @_common.sum(s.data) }

pub fn sort_dist_pigeonhole_node_mean(s : SortdistpigeonholeNode) -> Double { @_common.mean(s.data) }

pub fn sort_dist_pigeonhole_node_scale(s : SortdistpigeonholeNode, f : Double) -> SortdistpigeonholeNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_dist_pigeonhole_node_add(a : SortdistpigeonholeNode, b : SortdistpigeonholeNode) -> SortdistpigeonholeNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_dist_pigeonhole_node_copy(s : SortdistpigeonholeNode) -> SortdistpigeonholeNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_dist_pigeonhole_node_fill(s : SortdistpigeonholeNode, v : Double) -> SortdistpigeonholeNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_dist_pigeonhole_node_min(s : SortdistpigeonholeNode) -> Double { @_common.min(s.data) }

pub fn sort_dist_pigeonhole_node_max(s : SortdistpigeonholeNode) -> Double { @_common.max(s.data) }

pub fn sort_dist_pigeonhole_node_to_string(s : SortdistpigeonholeNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortdistpigeonholeEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_dist_pigeonhole_edge_make(size : Int) -> SortdistpigeonholeEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_dist_pigeonhole_edge_len(s : SortdistpigeonholeEdge) -> Int { s.size }

pub fn sort_dist_pigeonhole_edge_get(s : SortdistpigeonholeEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_dist_pigeonhole_edge_set(s : SortdistpigeonholeEdge, i : Int, v : Double) -> SortdistpigeonholeEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_dist_pigeonhole_edge_sum(s : SortdistpigeonholeEdge) -> Double { @_common.sum(s.data) }

pub fn sort_dist_pigeonhole_edge_mean(s : SortdistpigeonholeEdge) -> Double { @_common.mean(s.data) }

pub fn sort_dist_pigeonhole_edge_scale(s : SortdistpigeonholeEdge, f : Double) -> SortdistpigeonholeEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_dist_pigeonhole_edge_add(a : SortdistpigeonholeEdge, b : SortdistpigeonholeEdge) -> SortdistpigeonholeEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_dist_pigeonhole_edge_copy(s : SortdistpigeonholeEdge) -> SortdistpigeonholeEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_dist_pigeonhole_edge_fill(s : SortdistpigeonholeEdge, v : Double) -> SortdistpigeonholeEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_dist_pigeonhole_edge_min(s : SortdistpigeonholeEdge) -> Double { @_common.min(s.data) }

pub fn sort_dist_pigeonhole_edge_max(s : SortdistpigeonholeEdge) -> Double { @_common.max(s.data) }

pub fn sort_dist_pigeonhole_edge_to_string(s : SortdistpigeonholeEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortdistpigeonholePath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_dist_pigeonhole_path_make(size : Int) -> SortdistpigeonholePath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_dist_pigeonhole_path_len(s : SortdistpigeonholePath) -> Int { s.size }

pub fn sort_dist_pigeonhole_path_get(s : SortdistpigeonholePath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_dist_pigeonhole_path_set(s : SortdistpigeonholePath, i : Int, v : Double) -> SortdistpigeonholePath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_dist_pigeonhole_path_sum(s : SortdistpigeonholePath) -> Double { @_common.sum(s.data) }

pub fn sort_dist_pigeonhole_path_mean(s : SortdistpigeonholePath) -> Double { @_common.mean(s.data) }

pub fn sort_dist_pigeonhole_path_scale(s : SortdistpigeonholePath, f : Double) -> SortdistpigeonholePath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_dist_pigeonhole_path_add(a : SortdistpigeonholePath, b : SortdistpigeonholePath) -> SortdistpigeonholePath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_dist_pigeonhole_path_copy(s : SortdistpigeonholePath) -> SortdistpigeonholePath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_dist_pigeonhole_path_fill(s : SortdistpigeonholePath, v : Double) -> SortdistpigeonholePath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_dist_pigeonhole_path_min(s : SortdistpigeonholePath) -> Double { @_common.min(s.data) }

pub fn sort_dist_pigeonhole_path_max(s : SortdistpigeonholePath) -> Double { @_common.max(s.data) }

pub fn sort_dist_pigeonhole_path_to_string(s : SortdistpigeonholePath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortdistpigeonholeCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_dist_pigeonhole_cluster_make(size : Int) -> SortdistpigeonholeCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_dist_pigeonhole_cluster_len(s : SortdistpigeonholeCluster) -> Int { s.size }

pub fn sort_dist_pigeonhole_cluster_get(s : SortdistpigeonholeCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_dist_pigeonhole_cluster_set(s : SortdistpigeonholeCluster, i : Int, v : Double) -> SortdistpigeonholeCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_dist_pigeonhole_cluster_sum(s : SortdistpigeonholeCluster) -> Double { @_common.sum(s.data) }

pub fn sort_dist_pigeonhole_cluster_mean(s : SortdistpigeonholeCluster) -> Double { @_common.mean(s.data) }

pub fn sort_dist_pigeonhole_cluster_scale(s : SortdistpigeonholeCluster, f : Double) -> SortdistpigeonholeCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_dist_pigeonhole_cluster_add(a : SortdistpigeonholeCluster, b : SortdistpigeonholeCluster) -> SortdistpigeonholeCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_dist_pigeonhole_cluster_copy(s : SortdistpigeonholeCluster) -> SortdistpigeonholeCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_dist_pigeonhole_cluster_fill(s : SortdistpigeonholeCluster, v : Double) -> SortdistpigeonholeCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_dist_pigeonhole_cluster_min(s : SortdistpigeonholeCluster) -> Double { @_common.min(s.data) }

pub fn sort_dist_pigeonhole_cluster_max(s : SortdistpigeonholeCluster) -> Double { @_common.max(s.data) }

pub fn sort_dist_pigeonhole_cluster_to_string(s : SortdistpigeonholeCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortdistpigeonholeModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_dist_pigeonhole_model_make(size : Int) -> SortdistpigeonholeModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_dist_pigeonhole_model_len(s : SortdistpigeonholeModel) -> Int { s.size }

pub fn sort_dist_pigeonhole_model_get(s : SortdistpigeonholeModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_dist_pigeonhole_model_set(s : SortdistpigeonholeModel, i : Int, v : Double) -> SortdistpigeonholeModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_dist_pigeonhole_model_sum(s : SortdistpigeonholeModel) -> Double { @_common.sum(s.data) }

pub fn sort_dist_pigeonhole_model_mean(s : SortdistpigeonholeModel) -> Double { @_common.mean(s.data) }

pub fn sort_dist_pigeonhole_model_scale(s : SortdistpigeonholeModel, f : Double) -> SortdistpigeonholeModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_dist_pigeonhole_model_add(a : SortdistpigeonholeModel, b : SortdistpigeonholeModel) -> SortdistpigeonholeModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_dist_pigeonhole_model_copy(s : SortdistpigeonholeModel) -> SortdistpigeonholeModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_dist_pigeonhole_model_fill(s : SortdistpigeonholeModel, v : Double) -> SortdistpigeonholeModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_dist_pigeonhole_model_min(s : SortdistpigeonholeModel) -> Double { @_common.min(s.data) }

pub fn sort_dist_pigeonhole_model_max(s : SortdistpigeonholeModel) -> Double { @_common.max(s.data) }

pub fn sort_dist_pigeonhole_model_to_string(s : SortdistpigeonholeModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortdistpigeonholeLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_dist_pigeonhole_layer_make(size : Int) -> SortdistpigeonholeLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_dist_pigeonhole_layer_len(s : SortdistpigeonholeLayer) -> Int { s.size }

pub fn sort_dist_pigeonhole_layer_get(s : SortdistpigeonholeLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_dist_pigeonhole_layer_set(s : SortdistpigeonholeLayer, i : Int, v : Double) -> SortdistpigeonholeLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_dist_pigeonhole_layer_sum(s : SortdistpigeonholeLayer) -> Double { @_common.sum(s.data) }

pub fn sort_dist_pigeonhole_layer_mean(s : SortdistpigeonholeLayer) -> Double { @_common.mean(s.data) }

pub fn sort_dist_pigeonhole_layer_scale(s : SortdistpigeonholeLayer, f : Double) -> SortdistpigeonholeLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_dist_pigeonhole_layer_add(a : SortdistpigeonholeLayer, b : SortdistpigeonholeLayer) -> SortdistpigeonholeLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_dist_pigeonhole_layer_copy(s : SortdistpigeonholeLayer) -> SortdistpigeonholeLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_dist_pigeonhole_layer_fill(s : SortdistpigeonholeLayer, v : Double) -> SortdistpigeonholeLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_dist_pigeonhole_layer_min(s : SortdistpigeonholeLayer) -> Double { @_common.min(s.data) }

pub fn sort_dist_pigeonhole_layer_max(s : SortdistpigeonholeLayer) -> Double { @_common.max(s.data) }

pub fn sort_dist_pigeonhole_layer_to_string(s : SortdistpigeonholeLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortdistpigeonholeBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_dist_pigeonhole_buffer_make(size : Int) -> SortdistpigeonholeBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_dist_pigeonhole_buffer_len(s : SortdistpigeonholeBuffer) -> Int { s.size }

pub fn sort_dist_pigeonhole_buffer_get(s : SortdistpigeonholeBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_dist_pigeonhole_buffer_set(s : SortdistpigeonholeBuffer, i : Int, v : Double) -> SortdistpigeonholeBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_dist_pigeonhole_buffer_sum(s : SortdistpigeonholeBuffer) -> Double { @_common.sum(s.data) }

pub fn sort_dist_pigeonhole_buffer_mean(s : SortdistpigeonholeBuffer) -> Double { @_common.mean(s.data) }

pub fn sort_dist_pigeonhole_buffer_scale(s : SortdistpigeonholeBuffer, f : Double) -> SortdistpigeonholeBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_dist_pigeonhole_buffer_add(a : SortdistpigeonholeBuffer, b : SortdistpigeonholeBuffer) -> SortdistpigeonholeBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_dist_pigeonhole_buffer_copy(s : SortdistpigeonholeBuffer) -> SortdistpigeonholeBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_dist_pigeonhole_buffer_fill(s : SortdistpigeonholeBuffer, v : Double) -> SortdistpigeonholeBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_dist_pigeonhole_buffer_min(s : SortdistpigeonholeBuffer) -> Double { @_common.min(s.data) }

pub fn sort_dist_pigeonhole_buffer_max(s : SortdistpigeonholeBuffer) -> Double { @_common.max(s.data) }

pub fn sort_dist_pigeonhole_buffer_to_string(s : SortdistpigeonholeBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortdistpigeonholeCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_dist_pigeonhole_cursor_make(size : Int) -> SortdistpigeonholeCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_dist_pigeonhole_cursor_len(s : SortdistpigeonholeCursor) -> Int { s.size }

pub fn sort_dist_pigeonhole_cursor_get(s : SortdistpigeonholeCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_dist_pigeonhole_cursor_set(s : SortdistpigeonholeCursor, i : Int, v : Double) -> SortdistpigeonholeCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_dist_pigeonhole_cursor_sum(s : SortdistpigeonholeCursor) -> Double { @_common.sum(s.data) }

pub fn sort_dist_pigeonhole_cursor_mean(s : SortdistpigeonholeCursor) -> Double { @_common.mean(s.data) }

pub fn sort_dist_pigeonhole_cursor_scale(s : SortdistpigeonholeCursor, f : Double) -> SortdistpigeonholeCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_dist_pigeonhole_cursor_add(a : SortdistpigeonholeCursor, b : SortdistpigeonholeCursor) -> SortdistpigeonholeCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_dist_pigeonhole_cursor_copy(s : SortdistpigeonholeCursor) -> SortdistpigeonholeCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_dist_pigeonhole_cursor_fill(s : SortdistpigeonholeCursor, v : Double) -> SortdistpigeonholeCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_dist_pigeonhole_cursor_min(s : SortdistpigeonholeCursor) -> Double { @_common.min(s.data) }

pub fn sort_dist_pigeonhole_cursor_max(s : SortdistpigeonholeCursor) -> Double { @_common.max(s.data) }

pub fn sort_dist_pigeonhole_cursor_to_string(s : SortdistpigeonholeCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortdistpigeonholeView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_dist_pigeonhole_view_make(size : Int) -> SortdistpigeonholeView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_dist_pigeonhole_view_len(s : SortdistpigeonholeView) -> Int { s.size }

pub fn sort_dist_pigeonhole_view_get(s : SortdistpigeonholeView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_dist_pigeonhole_view_set(s : SortdistpigeonholeView, i : Int, v : Double) -> SortdistpigeonholeView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_dist_pigeonhole_view_sum(s : SortdistpigeonholeView) -> Double { @_common.sum(s.data) }

pub fn sort_dist_pigeonhole_view_mean(s : SortdistpigeonholeView) -> Double { @_common.mean(s.data) }

pub fn sort_dist_pigeonhole_view_scale(s : SortdistpigeonholeView, f : Double) -> SortdistpigeonholeView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_dist_pigeonhole_view_add(a : SortdistpigeonholeView, b : SortdistpigeonholeView) -> SortdistpigeonholeView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_dist_pigeonhole_view_copy(s : SortdistpigeonholeView) -> SortdistpigeonholeView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_dist_pigeonhole_view_fill(s : SortdistpigeonholeView, v : Double) -> SortdistpigeonholeView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_dist_pigeonhole_view_min(s : SortdistpigeonholeView) -> Double { @_common.min(s.data) }

pub fn sort_dist_pigeonhole_view_max(s : SortdistpigeonholeView) -> Double { @_common.max(s.data) }

pub fn sort_dist_pigeonhole_view_to_string(s : SortdistpigeonholeView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortdistpigeonholeRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_dist_pigeonhole_range_make(size : Int) -> SortdistpigeonholeRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_dist_pigeonhole_range_len(s : SortdistpigeonholeRange) -> Int { s.size }

pub fn sort_dist_pigeonhole_range_get(s : SortdistpigeonholeRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_dist_pigeonhole_range_set(s : SortdistpigeonholeRange, i : Int, v : Double) -> SortdistpigeonholeRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_dist_pigeonhole_range_sum(s : SortdistpigeonholeRange) -> Double { @_common.sum(s.data) }

pub fn sort_dist_pigeonhole_range_mean(s : SortdistpigeonholeRange) -> Double { @_common.mean(s.data) }

pub fn sort_dist_pigeonhole_range_scale(s : SortdistpigeonholeRange, f : Double) -> SortdistpigeonholeRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_dist_pigeonhole_range_add(a : SortdistpigeonholeRange, b : SortdistpigeonholeRange) -> SortdistpigeonholeRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_dist_pigeonhole_range_copy(s : SortdistpigeonholeRange) -> SortdistpigeonholeRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_dist_pigeonhole_range_fill(s : SortdistpigeonholeRange, v : Double) -> SortdistpigeonholeRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_dist_pigeonhole_range_min(s : SortdistpigeonholeRange) -> Double { @_common.min(s.data) }

pub fn sort_dist_pigeonhole_range_max(s : SortdistpigeonholeRange) -> Double { @_common.max(s.data) }

pub fn sort_dist_pigeonhole_range_to_string(s : SortdistpigeonholeRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortdistpigeonholeSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_dist_pigeonhole_slice_make(size : Int) -> SortdistpigeonholeSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_dist_pigeonhole_slice_len(s : SortdistpigeonholeSlice) -> Int { s.size }

pub fn sort_dist_pigeonhole_slice_get(s : SortdistpigeonholeSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_dist_pigeonhole_slice_set(s : SortdistpigeonholeSlice, i : Int, v : Double) -> SortdistpigeonholeSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_dist_pigeonhole_slice_sum(s : SortdistpigeonholeSlice) -> Double { @_common.sum(s.data) }

pub fn sort_dist_pigeonhole_slice_mean(s : SortdistpigeonholeSlice) -> Double { @_common.mean(s.data) }

pub fn sort_dist_pigeonhole_slice_scale(s : SortdistpigeonholeSlice, f : Double) -> SortdistpigeonholeSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_dist_pigeonhole_slice_add(a : SortdistpigeonholeSlice, b : SortdistpigeonholeSlice) -> SortdistpigeonholeSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_dist_pigeonhole_slice_copy(s : SortdistpigeonholeSlice) -> SortdistpigeonholeSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_dist_pigeonhole_slice_fill(s : SortdistpigeonholeSlice, v : Double) -> SortdistpigeonholeSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_dist_pigeonhole_slice_min(s : SortdistpigeonholeSlice) -> Double { @_common.min(s.data) }

pub fn sort_dist_pigeonhole_slice_max(s : SortdistpigeonholeSlice) -> Double { @_common.max(s.data) }

pub fn sort_dist_pigeonhole_slice_to_string(s : SortdistpigeonholeSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

