///===
/// extcore/sort_hybrid_powersort

pub(all) struct SorthybridpowersortPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn sort_hybrid_powersort_make_point(x : Double, y : Double) -> SorthybridpowersortPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn sort_hybrid_powersort_make_point3(x : Double, y : Double, z : Double) -> SorthybridpowersortPoint {
  { x, y, z, label: 0 }
}

pub fn SorthybridpowersortPoint::x(self : SorthybridpowersortPoint) -> Double { self.x }

pub fn SorthybridpowersortPoint::y(self : SorthybridpowersortPoint) -> Double { self.y }

pub fn SorthybridpowersortPoint::z(self : SorthybridpowersortPoint) -> Double { self.z }

pub fn SorthybridpowersortPoint::label(self : SorthybridpowersortPoint) -> Int { self.label }

pub fn SorthybridpowersortPoint::dist(self : SorthybridpowersortPoint, other : SorthybridpowersortPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn SorthybridpowersortPoint::add(self : SorthybridpowersortPoint, other : SorthybridpowersortPoint) -> SorthybridpowersortPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn SorthybridpowersortPoint::sub(self : SorthybridpowersortPoint, other : SorthybridpowersortPoint) -> SorthybridpowersortPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn SorthybridpowersortPoint::scale(self : SorthybridpowersortPoint, s : Double) -> SorthybridpowersortPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn SorthybridpowersortPoint::dot(self : SorthybridpowersortPoint, other : SorthybridpowersortPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn SorthybridpowersortPoint::cross(self : SorthybridpowersortPoint, other : SorthybridpowersortPoint) -> SorthybridpowersortPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn SorthybridpowersortPoint::norm(self : SorthybridpowersortPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn SorthybridpowersortPoint::normalize(self : SorthybridpowersortPoint) -> SorthybridpowersortPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn SorthybridpowersortPoint::negate(self : SorthybridpowersortPoint) -> SorthybridpowersortPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn SorthybridpowersortPoint::mid(self : SorthybridpowersortPoint, other : SorthybridpowersortPoint) -> SorthybridpowersortPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn SorthybridpowersortPoint::lerp(self : SorthybridpowersortPoint, other : SorthybridpowersortPoint, t : Double) -> SorthybridpowersortPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn SorthybridpowersortPoint::to_string(self : SorthybridpowersortPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct SorthybridpowersortSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn sort_hybrid_powersort_make_series(vals : Array[Double], name : String) -> SorthybridpowersortSeries {
  { vals, name, meta: 0 }
}

pub fn SorthybridpowersortSeries::len(self : SorthybridpowersortSeries) -> Int { self.vals.length() }

pub fn SorthybridpowersortSeries::sum(self : SorthybridpowersortSeries) -> Double { @_common.sum(self.vals) }

pub fn SorthybridpowersortSeries::mean(self : SorthybridpowersortSeries) -> Double { @_common.mean(self.vals) }

pub fn SorthybridpowersortSeries::min(self : SorthybridpowersortSeries) -> Double { @_common.min(self.vals) }

pub fn SorthybridpowersortSeries::max(self : SorthybridpowersortSeries) -> Double { @_common.max(self.vals) }

pub fn SorthybridpowersortSeries::range(self : SorthybridpowersortSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn SorthybridpowersortSeries::variance(self : SorthybridpowersortSeries) -> Double { @_common.variance(self.vals) }

pub fn SorthybridpowersortSeries::std(self : SorthybridpowersortSeries) -> Double { @_common.std(self.vals) }

pub fn SorthybridpowersortSeries::median(self : SorthybridpowersortSeries) -> Double { @_common.median(self.vals) }

pub fn SorthybridpowersortSeries::scale(self : SorthybridpowersortSeries, f : Double) -> SorthybridpowersortSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn SorthybridpowersortSeries::add(self : SorthybridpowersortSeries, other : SorthybridpowersortSeries) -> SorthybridpowersortSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn SorthybridpowersortSeries::sub(self : SorthybridpowersortSeries, other : SorthybridpowersortSeries) -> SorthybridpowersortSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn SorthybridpowersortSeries::normalize(self : SorthybridpowersortSeries) -> SorthybridpowersortSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn SorthybridpowersortSeries::cumsum(self : SorthybridpowersortSeries) -> SorthybridpowersortSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn SorthybridpowersortSeries::to_string(self : SorthybridpowersortSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct SorthybridpowersortMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn sort_hybrid_powersort_make_matrix(rows : Int, cols : Int, val : Double) -> SorthybridpowersortMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn sort_hybrid_powersort_matrix_identity(n : Int) -> SorthybridpowersortMatrix {
  let m = sort_hybrid_powersort_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn SorthybridpowersortMatrix::get(self : SorthybridpowersortMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn SorthybridpowersortMatrix::transpose(self : SorthybridpowersortMatrix) -> SorthybridpowersortMatrix {
  let result = sort_hybrid_powersort_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn SorthybridpowersortMatrix::add(self : SorthybridpowersortMatrix, other : SorthybridpowersortMatrix) -> SorthybridpowersortMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = sort_hybrid_powersort_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn SorthybridpowersortMatrix::scale(self : SorthybridpowersortMatrix, s : Double) -> SorthybridpowersortMatrix {
  let result = sort_hybrid_powersort_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn SorthybridpowersortMatrix::multiply(self : SorthybridpowersortMatrix, other : SorthybridpowersortMatrix) -> SorthybridpowersortMatrix {
  if self.cols != other.rows { return sort_hybrid_powersort_make_matrix(self.rows, other.cols, 0.0) }
  let result = sort_hybrid_powersort_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn SorthybridpowersortMatrix::trace(self : SorthybridpowersortMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn SorthybridpowersortMatrix::det(self : SorthybridpowersortMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn SorthybridpowersortMatrix::norm(self : SorthybridpowersortMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn SorthybridpowersortMatrix::to_string(self : SorthybridpowersortMatrix) -> String {
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

pub(all) struct SorthybridpowersortVector {
  comps : Array[Double]
  dim : Int
}

pub fn sort_hybrid_powersort_make_vector(comps : Array[Double]) -> SorthybridpowersortVector {
  { comps, dim: comps.length() }
}

pub fn sort_hybrid_powersort_vector_zero(dim : Int) -> SorthybridpowersortVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn SorthybridpowersortVector::add(self : SorthybridpowersortVector, other : SorthybridpowersortVector) -> SorthybridpowersortVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn SorthybridpowersortVector::sub(self : SorthybridpowersortVector, other : SorthybridpowersortVector) -> SorthybridpowersortVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn SorthybridpowersortVector::scale(self : SorthybridpowersortVector, s : Double) -> SorthybridpowersortVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn SorthybridpowersortVector::dot(self : SorthybridpowersortVector, other : SorthybridpowersortVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn SorthybridpowersortVector::norm(self : SorthybridpowersortVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn SorthybridpowersortVector::normalize(self : SorthybridpowersortVector) -> SorthybridpowersortVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn SorthybridpowersortVector::dist(self : SorthybridpowersortVector, other : SorthybridpowersortVector) -> Double {
  self.sub(other).norm()
}

pub fn SorthybridpowersortVector::to_string(self : SorthybridpowersortVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn sort_hybrid_powersort_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn sort_hybrid_powersort_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn sort_hybrid_powersort_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn sort_hybrid_powersort_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn sort_hybrid_powersort_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn sort_hybrid_powersort_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn sort_hybrid_powersort_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn sort_hybrid_powersort_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn sort_hybrid_powersort_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn sort_hybrid_powersort_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn sort_hybrid_powersort_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn sort_hybrid_powersort_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn sort_hybrid_powersort_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn sort_hybrid_powersort_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn sort_hybrid_powersort_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn sort_hybrid_powersort_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn sort_hybrid_powersort_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn sort_hybrid_powersort_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn sort_hybrid_powersort_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn sort_hybrid_powersort_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn sort_hybrid_powersort_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn sort_hybrid_powersort_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn sort_hybrid_powersort_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn sort_hybrid_powersort_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn sort_hybrid_powersort_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn sort_hybrid_powersort_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn sort_hybrid_powersort_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn sort_hybrid_powersort_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn sort_hybrid_powersort_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct SorthybridpowersortFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_hybrid_powersort_frame_make(size : Int) -> SorthybridpowersortFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_hybrid_powersort_frame_len(s : SorthybridpowersortFrame) -> Int { s.size }

pub fn sort_hybrid_powersort_frame_get(s : SorthybridpowersortFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_hybrid_powersort_frame_set(s : SorthybridpowersortFrame, i : Int, v : Double) -> SorthybridpowersortFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_hybrid_powersort_frame_sum(s : SorthybridpowersortFrame) -> Double { @_common.sum(s.data) }

pub fn sort_hybrid_powersort_frame_mean(s : SorthybridpowersortFrame) -> Double { @_common.mean(s.data) }

pub fn sort_hybrid_powersort_frame_scale(s : SorthybridpowersortFrame, f : Double) -> SorthybridpowersortFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_hybrid_powersort_frame_add(a : SorthybridpowersortFrame, b : SorthybridpowersortFrame) -> SorthybridpowersortFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_hybrid_powersort_frame_copy(s : SorthybridpowersortFrame) -> SorthybridpowersortFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_hybrid_powersort_frame_fill(s : SorthybridpowersortFrame, v : Double) -> SorthybridpowersortFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_hybrid_powersort_frame_min(s : SorthybridpowersortFrame) -> Double { @_common.min(s.data) }

pub fn sort_hybrid_powersort_frame_max(s : SorthybridpowersortFrame) -> Double { @_common.max(s.data) }

pub fn sort_hybrid_powersort_frame_to_string(s : SorthybridpowersortFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SorthybridpowersortTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_hybrid_powersort_table_make(size : Int) -> SorthybridpowersortTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_hybrid_powersort_table_len(s : SorthybridpowersortTable) -> Int { s.size }

pub fn sort_hybrid_powersort_table_get(s : SorthybridpowersortTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_hybrid_powersort_table_set(s : SorthybridpowersortTable, i : Int, v : Double) -> SorthybridpowersortTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_hybrid_powersort_table_sum(s : SorthybridpowersortTable) -> Double { @_common.sum(s.data) }

pub fn sort_hybrid_powersort_table_mean(s : SorthybridpowersortTable) -> Double { @_common.mean(s.data) }

pub fn sort_hybrid_powersort_table_scale(s : SorthybridpowersortTable, f : Double) -> SorthybridpowersortTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_hybrid_powersort_table_add(a : SorthybridpowersortTable, b : SorthybridpowersortTable) -> SorthybridpowersortTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_hybrid_powersort_table_copy(s : SorthybridpowersortTable) -> SorthybridpowersortTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_hybrid_powersort_table_fill(s : SorthybridpowersortTable, v : Double) -> SorthybridpowersortTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_hybrid_powersort_table_min(s : SorthybridpowersortTable) -> Double { @_common.min(s.data) }

pub fn sort_hybrid_powersort_table_max(s : SorthybridpowersortTable) -> Double { @_common.max(s.data) }

pub fn sort_hybrid_powersort_table_to_string(s : SorthybridpowersortTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SorthybridpowersortGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_hybrid_powersort_graphn_make(size : Int) -> SorthybridpowersortGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_hybrid_powersort_graphn_len(s : SorthybridpowersortGraphN) -> Int { s.size }

pub fn sort_hybrid_powersort_graphn_get(s : SorthybridpowersortGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_hybrid_powersort_graphn_set(s : SorthybridpowersortGraphN, i : Int, v : Double) -> SorthybridpowersortGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_hybrid_powersort_graphn_sum(s : SorthybridpowersortGraphN) -> Double { @_common.sum(s.data) }

pub fn sort_hybrid_powersort_graphn_mean(s : SorthybridpowersortGraphN) -> Double { @_common.mean(s.data) }

pub fn sort_hybrid_powersort_graphn_scale(s : SorthybridpowersortGraphN, f : Double) -> SorthybridpowersortGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_hybrid_powersort_graphn_add(a : SorthybridpowersortGraphN, b : SorthybridpowersortGraphN) -> SorthybridpowersortGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_hybrid_powersort_graphn_copy(s : SorthybridpowersortGraphN) -> SorthybridpowersortGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_hybrid_powersort_graphn_fill(s : SorthybridpowersortGraphN, v : Double) -> SorthybridpowersortGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_hybrid_powersort_graphn_min(s : SorthybridpowersortGraphN) -> Double { @_common.min(s.data) }

pub fn sort_hybrid_powersort_graphn_max(s : SorthybridpowersortGraphN) -> Double { @_common.max(s.data) }

pub fn sort_hybrid_powersort_graphn_to_string(s : SorthybridpowersortGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SorthybridpowersortNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_hybrid_powersort_node_make(size : Int) -> SorthybridpowersortNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_hybrid_powersort_node_len(s : SorthybridpowersortNode) -> Int { s.size }

pub fn sort_hybrid_powersort_node_get(s : SorthybridpowersortNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_hybrid_powersort_node_set(s : SorthybridpowersortNode, i : Int, v : Double) -> SorthybridpowersortNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_hybrid_powersort_node_sum(s : SorthybridpowersortNode) -> Double { @_common.sum(s.data) }

pub fn sort_hybrid_powersort_node_mean(s : SorthybridpowersortNode) -> Double { @_common.mean(s.data) }

pub fn sort_hybrid_powersort_node_scale(s : SorthybridpowersortNode, f : Double) -> SorthybridpowersortNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_hybrid_powersort_node_add(a : SorthybridpowersortNode, b : SorthybridpowersortNode) -> SorthybridpowersortNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_hybrid_powersort_node_copy(s : SorthybridpowersortNode) -> SorthybridpowersortNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_hybrid_powersort_node_fill(s : SorthybridpowersortNode, v : Double) -> SorthybridpowersortNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_hybrid_powersort_node_min(s : SorthybridpowersortNode) -> Double { @_common.min(s.data) }

pub fn sort_hybrid_powersort_node_max(s : SorthybridpowersortNode) -> Double { @_common.max(s.data) }

pub fn sort_hybrid_powersort_node_to_string(s : SorthybridpowersortNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SorthybridpowersortEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_hybrid_powersort_edge_make(size : Int) -> SorthybridpowersortEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_hybrid_powersort_edge_len(s : SorthybridpowersortEdge) -> Int { s.size }

pub fn sort_hybrid_powersort_edge_get(s : SorthybridpowersortEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_hybrid_powersort_edge_set(s : SorthybridpowersortEdge, i : Int, v : Double) -> SorthybridpowersortEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_hybrid_powersort_edge_sum(s : SorthybridpowersortEdge) -> Double { @_common.sum(s.data) }

pub fn sort_hybrid_powersort_edge_mean(s : SorthybridpowersortEdge) -> Double { @_common.mean(s.data) }

pub fn sort_hybrid_powersort_edge_scale(s : SorthybridpowersortEdge, f : Double) -> SorthybridpowersortEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_hybrid_powersort_edge_add(a : SorthybridpowersortEdge, b : SorthybridpowersortEdge) -> SorthybridpowersortEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_hybrid_powersort_edge_copy(s : SorthybridpowersortEdge) -> SorthybridpowersortEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_hybrid_powersort_edge_fill(s : SorthybridpowersortEdge, v : Double) -> SorthybridpowersortEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_hybrid_powersort_edge_min(s : SorthybridpowersortEdge) -> Double { @_common.min(s.data) }

pub fn sort_hybrid_powersort_edge_max(s : SorthybridpowersortEdge) -> Double { @_common.max(s.data) }

pub fn sort_hybrid_powersort_edge_to_string(s : SorthybridpowersortEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SorthybridpowersortPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_hybrid_powersort_path_make(size : Int) -> SorthybridpowersortPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_hybrid_powersort_path_len(s : SorthybridpowersortPath) -> Int { s.size }

pub fn sort_hybrid_powersort_path_get(s : SorthybridpowersortPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_hybrid_powersort_path_set(s : SorthybridpowersortPath, i : Int, v : Double) -> SorthybridpowersortPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_hybrid_powersort_path_sum(s : SorthybridpowersortPath) -> Double { @_common.sum(s.data) }

pub fn sort_hybrid_powersort_path_mean(s : SorthybridpowersortPath) -> Double { @_common.mean(s.data) }

pub fn sort_hybrid_powersort_path_scale(s : SorthybridpowersortPath, f : Double) -> SorthybridpowersortPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_hybrid_powersort_path_add(a : SorthybridpowersortPath, b : SorthybridpowersortPath) -> SorthybridpowersortPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_hybrid_powersort_path_copy(s : SorthybridpowersortPath) -> SorthybridpowersortPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_hybrid_powersort_path_fill(s : SorthybridpowersortPath, v : Double) -> SorthybridpowersortPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_hybrid_powersort_path_min(s : SorthybridpowersortPath) -> Double { @_common.min(s.data) }

pub fn sort_hybrid_powersort_path_max(s : SorthybridpowersortPath) -> Double { @_common.max(s.data) }

pub fn sort_hybrid_powersort_path_to_string(s : SorthybridpowersortPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SorthybridpowersortCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_hybrid_powersort_cluster_make(size : Int) -> SorthybridpowersortCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_hybrid_powersort_cluster_len(s : SorthybridpowersortCluster) -> Int { s.size }

pub fn sort_hybrid_powersort_cluster_get(s : SorthybridpowersortCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_hybrid_powersort_cluster_set(s : SorthybridpowersortCluster, i : Int, v : Double) -> SorthybridpowersortCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_hybrid_powersort_cluster_sum(s : SorthybridpowersortCluster) -> Double { @_common.sum(s.data) }

pub fn sort_hybrid_powersort_cluster_mean(s : SorthybridpowersortCluster) -> Double { @_common.mean(s.data) }

pub fn sort_hybrid_powersort_cluster_scale(s : SorthybridpowersortCluster, f : Double) -> SorthybridpowersortCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_hybrid_powersort_cluster_add(a : SorthybridpowersortCluster, b : SorthybridpowersortCluster) -> SorthybridpowersortCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_hybrid_powersort_cluster_copy(s : SorthybridpowersortCluster) -> SorthybridpowersortCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_hybrid_powersort_cluster_fill(s : SorthybridpowersortCluster, v : Double) -> SorthybridpowersortCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_hybrid_powersort_cluster_min(s : SorthybridpowersortCluster) -> Double { @_common.min(s.data) }

pub fn sort_hybrid_powersort_cluster_max(s : SorthybridpowersortCluster) -> Double { @_common.max(s.data) }

pub fn sort_hybrid_powersort_cluster_to_string(s : SorthybridpowersortCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SorthybridpowersortModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_hybrid_powersort_model_make(size : Int) -> SorthybridpowersortModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_hybrid_powersort_model_len(s : SorthybridpowersortModel) -> Int { s.size }

pub fn sort_hybrid_powersort_model_get(s : SorthybridpowersortModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_hybrid_powersort_model_set(s : SorthybridpowersortModel, i : Int, v : Double) -> SorthybridpowersortModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_hybrid_powersort_model_sum(s : SorthybridpowersortModel) -> Double { @_common.sum(s.data) }

pub fn sort_hybrid_powersort_model_mean(s : SorthybridpowersortModel) -> Double { @_common.mean(s.data) }

pub fn sort_hybrid_powersort_model_scale(s : SorthybridpowersortModel, f : Double) -> SorthybridpowersortModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_hybrid_powersort_model_add(a : SorthybridpowersortModel, b : SorthybridpowersortModel) -> SorthybridpowersortModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_hybrid_powersort_model_copy(s : SorthybridpowersortModel) -> SorthybridpowersortModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_hybrid_powersort_model_fill(s : SorthybridpowersortModel, v : Double) -> SorthybridpowersortModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_hybrid_powersort_model_min(s : SorthybridpowersortModel) -> Double { @_common.min(s.data) }

pub fn sort_hybrid_powersort_model_max(s : SorthybridpowersortModel) -> Double { @_common.max(s.data) }

pub fn sort_hybrid_powersort_model_to_string(s : SorthybridpowersortModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SorthybridpowersortLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_hybrid_powersort_layer_make(size : Int) -> SorthybridpowersortLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_hybrid_powersort_layer_len(s : SorthybridpowersortLayer) -> Int { s.size }

pub fn sort_hybrid_powersort_layer_get(s : SorthybridpowersortLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_hybrid_powersort_layer_set(s : SorthybridpowersortLayer, i : Int, v : Double) -> SorthybridpowersortLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_hybrid_powersort_layer_sum(s : SorthybridpowersortLayer) -> Double { @_common.sum(s.data) }

pub fn sort_hybrid_powersort_layer_mean(s : SorthybridpowersortLayer) -> Double { @_common.mean(s.data) }

pub fn sort_hybrid_powersort_layer_scale(s : SorthybridpowersortLayer, f : Double) -> SorthybridpowersortLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_hybrid_powersort_layer_add(a : SorthybridpowersortLayer, b : SorthybridpowersortLayer) -> SorthybridpowersortLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_hybrid_powersort_layer_copy(s : SorthybridpowersortLayer) -> SorthybridpowersortLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_hybrid_powersort_layer_fill(s : SorthybridpowersortLayer, v : Double) -> SorthybridpowersortLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_hybrid_powersort_layer_min(s : SorthybridpowersortLayer) -> Double { @_common.min(s.data) }

pub fn sort_hybrid_powersort_layer_max(s : SorthybridpowersortLayer) -> Double { @_common.max(s.data) }

pub fn sort_hybrid_powersort_layer_to_string(s : SorthybridpowersortLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SorthybridpowersortBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_hybrid_powersort_buffer_make(size : Int) -> SorthybridpowersortBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_hybrid_powersort_buffer_len(s : SorthybridpowersortBuffer) -> Int { s.size }

pub fn sort_hybrid_powersort_buffer_get(s : SorthybridpowersortBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_hybrid_powersort_buffer_set(s : SorthybridpowersortBuffer, i : Int, v : Double) -> SorthybridpowersortBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_hybrid_powersort_buffer_sum(s : SorthybridpowersortBuffer) -> Double { @_common.sum(s.data) }

pub fn sort_hybrid_powersort_buffer_mean(s : SorthybridpowersortBuffer) -> Double { @_common.mean(s.data) }

pub fn sort_hybrid_powersort_buffer_scale(s : SorthybridpowersortBuffer, f : Double) -> SorthybridpowersortBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_hybrid_powersort_buffer_add(a : SorthybridpowersortBuffer, b : SorthybridpowersortBuffer) -> SorthybridpowersortBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_hybrid_powersort_buffer_copy(s : SorthybridpowersortBuffer) -> SorthybridpowersortBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_hybrid_powersort_buffer_fill(s : SorthybridpowersortBuffer, v : Double) -> SorthybridpowersortBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_hybrid_powersort_buffer_min(s : SorthybridpowersortBuffer) -> Double { @_common.min(s.data) }

pub fn sort_hybrid_powersort_buffer_max(s : SorthybridpowersortBuffer) -> Double { @_common.max(s.data) }

pub fn sort_hybrid_powersort_buffer_to_string(s : SorthybridpowersortBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SorthybridpowersortCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_hybrid_powersort_cursor_make(size : Int) -> SorthybridpowersortCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_hybrid_powersort_cursor_len(s : SorthybridpowersortCursor) -> Int { s.size }

pub fn sort_hybrid_powersort_cursor_get(s : SorthybridpowersortCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_hybrid_powersort_cursor_set(s : SorthybridpowersortCursor, i : Int, v : Double) -> SorthybridpowersortCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_hybrid_powersort_cursor_sum(s : SorthybridpowersortCursor) -> Double { @_common.sum(s.data) }

pub fn sort_hybrid_powersort_cursor_mean(s : SorthybridpowersortCursor) -> Double { @_common.mean(s.data) }

pub fn sort_hybrid_powersort_cursor_scale(s : SorthybridpowersortCursor, f : Double) -> SorthybridpowersortCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_hybrid_powersort_cursor_add(a : SorthybridpowersortCursor, b : SorthybridpowersortCursor) -> SorthybridpowersortCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_hybrid_powersort_cursor_copy(s : SorthybridpowersortCursor) -> SorthybridpowersortCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_hybrid_powersort_cursor_fill(s : SorthybridpowersortCursor, v : Double) -> SorthybridpowersortCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_hybrid_powersort_cursor_min(s : SorthybridpowersortCursor) -> Double { @_common.min(s.data) }

pub fn sort_hybrid_powersort_cursor_max(s : SorthybridpowersortCursor) -> Double { @_common.max(s.data) }

pub fn sort_hybrid_powersort_cursor_to_string(s : SorthybridpowersortCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SorthybridpowersortView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_hybrid_powersort_view_make(size : Int) -> SorthybridpowersortView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_hybrid_powersort_view_len(s : SorthybridpowersortView) -> Int { s.size }

pub fn sort_hybrid_powersort_view_get(s : SorthybridpowersortView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_hybrid_powersort_view_set(s : SorthybridpowersortView, i : Int, v : Double) -> SorthybridpowersortView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_hybrid_powersort_view_sum(s : SorthybridpowersortView) -> Double { @_common.sum(s.data) }

pub fn sort_hybrid_powersort_view_mean(s : SorthybridpowersortView) -> Double { @_common.mean(s.data) }

pub fn sort_hybrid_powersort_view_scale(s : SorthybridpowersortView, f : Double) -> SorthybridpowersortView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_hybrid_powersort_view_add(a : SorthybridpowersortView, b : SorthybridpowersortView) -> SorthybridpowersortView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_hybrid_powersort_view_copy(s : SorthybridpowersortView) -> SorthybridpowersortView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_hybrid_powersort_view_fill(s : SorthybridpowersortView, v : Double) -> SorthybridpowersortView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_hybrid_powersort_view_min(s : SorthybridpowersortView) -> Double { @_common.min(s.data) }

pub fn sort_hybrid_powersort_view_max(s : SorthybridpowersortView) -> Double { @_common.max(s.data) }

pub fn sort_hybrid_powersort_view_to_string(s : SorthybridpowersortView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SorthybridpowersortRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_hybrid_powersort_range_make(size : Int) -> SorthybridpowersortRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_hybrid_powersort_range_len(s : SorthybridpowersortRange) -> Int { s.size }

pub fn sort_hybrid_powersort_range_get(s : SorthybridpowersortRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_hybrid_powersort_range_set(s : SorthybridpowersortRange, i : Int, v : Double) -> SorthybridpowersortRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_hybrid_powersort_range_sum(s : SorthybridpowersortRange) -> Double { @_common.sum(s.data) }

pub fn sort_hybrid_powersort_range_mean(s : SorthybridpowersortRange) -> Double { @_common.mean(s.data) }

pub fn sort_hybrid_powersort_range_scale(s : SorthybridpowersortRange, f : Double) -> SorthybridpowersortRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_hybrid_powersort_range_add(a : SorthybridpowersortRange, b : SorthybridpowersortRange) -> SorthybridpowersortRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_hybrid_powersort_range_copy(s : SorthybridpowersortRange) -> SorthybridpowersortRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_hybrid_powersort_range_fill(s : SorthybridpowersortRange, v : Double) -> SorthybridpowersortRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_hybrid_powersort_range_min(s : SorthybridpowersortRange) -> Double { @_common.min(s.data) }

pub fn sort_hybrid_powersort_range_max(s : SorthybridpowersortRange) -> Double { @_common.max(s.data) }

pub fn sort_hybrid_powersort_range_to_string(s : SorthybridpowersortRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SorthybridpowersortSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_hybrid_powersort_slice_make(size : Int) -> SorthybridpowersortSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_hybrid_powersort_slice_len(s : SorthybridpowersortSlice) -> Int { s.size }

pub fn sort_hybrid_powersort_slice_get(s : SorthybridpowersortSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_hybrid_powersort_slice_set(s : SorthybridpowersortSlice, i : Int, v : Double) -> SorthybridpowersortSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_hybrid_powersort_slice_sum(s : SorthybridpowersortSlice) -> Double { @_common.sum(s.data) }

pub fn sort_hybrid_powersort_slice_mean(s : SorthybridpowersortSlice) -> Double { @_common.mean(s.data) }

pub fn sort_hybrid_powersort_slice_scale(s : SorthybridpowersortSlice, f : Double) -> SorthybridpowersortSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_hybrid_powersort_slice_add(a : SorthybridpowersortSlice, b : SorthybridpowersortSlice) -> SorthybridpowersortSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_hybrid_powersort_slice_copy(s : SorthybridpowersortSlice) -> SorthybridpowersortSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_hybrid_powersort_slice_fill(s : SorthybridpowersortSlice, v : Double) -> SorthybridpowersortSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_hybrid_powersort_slice_min(s : SorthybridpowersortSlice) -> Double { @_common.min(s.data) }

pub fn sort_hybrid_powersort_slice_max(s : SorthybridpowersortSlice) -> Double { @_common.max(s.data) }

pub fn sort_hybrid_powersort_slice_to_string(s : SorthybridpowersortSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

