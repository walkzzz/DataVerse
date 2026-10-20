///===
/// extcore/sort_hybrid_wikisort

pub(all) struct SorthybridwikisortPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn sort_hybrid_wikisort_make_point(x : Double, y : Double) -> SorthybridwikisortPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn sort_hybrid_wikisort_make_point3(x : Double, y : Double, z : Double) -> SorthybridwikisortPoint {
  { x, y, z, label: 0 }
}

pub fn SorthybridwikisortPoint::x(self : SorthybridwikisortPoint) -> Double { self.x }

pub fn SorthybridwikisortPoint::y(self : SorthybridwikisortPoint) -> Double { self.y }

pub fn SorthybridwikisortPoint::z(self : SorthybridwikisortPoint) -> Double { self.z }

pub fn SorthybridwikisortPoint::label(self : SorthybridwikisortPoint) -> Int { self.label }

pub fn SorthybridwikisortPoint::dist(self : SorthybridwikisortPoint, other : SorthybridwikisortPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn SorthybridwikisortPoint::add(self : SorthybridwikisortPoint, other : SorthybridwikisortPoint) -> SorthybridwikisortPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn SorthybridwikisortPoint::sub(self : SorthybridwikisortPoint, other : SorthybridwikisortPoint) -> SorthybridwikisortPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn SorthybridwikisortPoint::scale(self : SorthybridwikisortPoint, s : Double) -> SorthybridwikisortPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn SorthybridwikisortPoint::dot(self : SorthybridwikisortPoint, other : SorthybridwikisortPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn SorthybridwikisortPoint::cross(self : SorthybridwikisortPoint, other : SorthybridwikisortPoint) -> SorthybridwikisortPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn SorthybridwikisortPoint::norm(self : SorthybridwikisortPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn SorthybridwikisortPoint::normalize(self : SorthybridwikisortPoint) -> SorthybridwikisortPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn SorthybridwikisortPoint::negate(self : SorthybridwikisortPoint) -> SorthybridwikisortPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn SorthybridwikisortPoint::mid(self : SorthybridwikisortPoint, other : SorthybridwikisortPoint) -> SorthybridwikisortPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn SorthybridwikisortPoint::lerp(self : SorthybridwikisortPoint, other : SorthybridwikisortPoint, t : Double) -> SorthybridwikisortPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn SorthybridwikisortPoint::to_string(self : SorthybridwikisortPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct SorthybridwikisortSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn sort_hybrid_wikisort_make_series(vals : Array[Double], name : String) -> SorthybridwikisortSeries {
  { vals, name, meta: 0 }
}

pub fn SorthybridwikisortSeries::len(self : SorthybridwikisortSeries) -> Int { self.vals.length() }

pub fn SorthybridwikisortSeries::sum(self : SorthybridwikisortSeries) -> Double { @_common.sum(self.vals) }

pub fn SorthybridwikisortSeries::mean(self : SorthybridwikisortSeries) -> Double { @_common.mean(self.vals) }

pub fn SorthybridwikisortSeries::min(self : SorthybridwikisortSeries) -> Double { @_common.min(self.vals) }

pub fn SorthybridwikisortSeries::max(self : SorthybridwikisortSeries) -> Double { @_common.max(self.vals) }

pub fn SorthybridwikisortSeries::range(self : SorthybridwikisortSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn SorthybridwikisortSeries::variance(self : SorthybridwikisortSeries) -> Double { @_common.variance(self.vals) }

pub fn SorthybridwikisortSeries::std(self : SorthybridwikisortSeries) -> Double { @_common.std(self.vals) }

pub fn SorthybridwikisortSeries::median(self : SorthybridwikisortSeries) -> Double { @_common.median(self.vals) }

pub fn SorthybridwikisortSeries::scale(self : SorthybridwikisortSeries, f : Double) -> SorthybridwikisortSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn SorthybridwikisortSeries::add(self : SorthybridwikisortSeries, other : SorthybridwikisortSeries) -> SorthybridwikisortSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn SorthybridwikisortSeries::sub(self : SorthybridwikisortSeries, other : SorthybridwikisortSeries) -> SorthybridwikisortSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn SorthybridwikisortSeries::normalize(self : SorthybridwikisortSeries) -> SorthybridwikisortSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn SorthybridwikisortSeries::cumsum(self : SorthybridwikisortSeries) -> SorthybridwikisortSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn SorthybridwikisortSeries::to_string(self : SorthybridwikisortSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct SorthybridwikisortMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn sort_hybrid_wikisort_make_matrix(rows : Int, cols : Int, val : Double) -> SorthybridwikisortMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn sort_hybrid_wikisort_matrix_identity(n : Int) -> SorthybridwikisortMatrix {
  let m = sort_hybrid_wikisort_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn SorthybridwikisortMatrix::get(self : SorthybridwikisortMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn SorthybridwikisortMatrix::transpose(self : SorthybridwikisortMatrix) -> SorthybridwikisortMatrix {
  let result = sort_hybrid_wikisort_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn SorthybridwikisortMatrix::add(self : SorthybridwikisortMatrix, other : SorthybridwikisortMatrix) -> SorthybridwikisortMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = sort_hybrid_wikisort_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn SorthybridwikisortMatrix::scale(self : SorthybridwikisortMatrix, s : Double) -> SorthybridwikisortMatrix {
  let result = sort_hybrid_wikisort_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn SorthybridwikisortMatrix::multiply(self : SorthybridwikisortMatrix, other : SorthybridwikisortMatrix) -> SorthybridwikisortMatrix {
  if self.cols != other.rows { return sort_hybrid_wikisort_make_matrix(self.rows, other.cols, 0.0) }
  let result = sort_hybrid_wikisort_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn SorthybridwikisortMatrix::trace(self : SorthybridwikisortMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn SorthybridwikisortMatrix::det(self : SorthybridwikisortMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn SorthybridwikisortMatrix::norm(self : SorthybridwikisortMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn SorthybridwikisortMatrix::to_string(self : SorthybridwikisortMatrix) -> String {
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

pub(all) struct SorthybridwikisortVector {
  comps : Array[Double]
  dim : Int
}

pub fn sort_hybrid_wikisort_make_vector(comps : Array[Double]) -> SorthybridwikisortVector {
  { comps, dim: comps.length() }
}

pub fn sort_hybrid_wikisort_vector_zero(dim : Int) -> SorthybridwikisortVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn SorthybridwikisortVector::add(self : SorthybridwikisortVector, other : SorthybridwikisortVector) -> SorthybridwikisortVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn SorthybridwikisortVector::sub(self : SorthybridwikisortVector, other : SorthybridwikisortVector) -> SorthybridwikisortVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn SorthybridwikisortVector::scale(self : SorthybridwikisortVector, s : Double) -> SorthybridwikisortVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn SorthybridwikisortVector::dot(self : SorthybridwikisortVector, other : SorthybridwikisortVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn SorthybridwikisortVector::norm(self : SorthybridwikisortVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn SorthybridwikisortVector::normalize(self : SorthybridwikisortVector) -> SorthybridwikisortVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn SorthybridwikisortVector::dist(self : SorthybridwikisortVector, other : SorthybridwikisortVector) -> Double {
  self.sub(other).norm()
}

pub fn SorthybridwikisortVector::to_string(self : SorthybridwikisortVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn sort_hybrid_wikisort_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn sort_hybrid_wikisort_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn sort_hybrid_wikisort_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn sort_hybrid_wikisort_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn sort_hybrid_wikisort_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn sort_hybrid_wikisort_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn sort_hybrid_wikisort_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn sort_hybrid_wikisort_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn sort_hybrid_wikisort_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn sort_hybrid_wikisort_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn sort_hybrid_wikisort_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn sort_hybrid_wikisort_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn sort_hybrid_wikisort_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn sort_hybrid_wikisort_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn sort_hybrid_wikisort_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn sort_hybrid_wikisort_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn sort_hybrid_wikisort_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn sort_hybrid_wikisort_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn sort_hybrid_wikisort_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn sort_hybrid_wikisort_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn sort_hybrid_wikisort_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn sort_hybrid_wikisort_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn sort_hybrid_wikisort_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn sort_hybrid_wikisort_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn sort_hybrid_wikisort_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn sort_hybrid_wikisort_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn sort_hybrid_wikisort_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn sort_hybrid_wikisort_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn sort_hybrid_wikisort_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct SorthybridwikisortFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_hybrid_wikisort_frame_make(size : Int) -> SorthybridwikisortFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_hybrid_wikisort_frame_len(s : SorthybridwikisortFrame) -> Int { s.size }

pub fn sort_hybrid_wikisort_frame_get(s : SorthybridwikisortFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_hybrid_wikisort_frame_set(s : SorthybridwikisortFrame, i : Int, v : Double) -> SorthybridwikisortFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_hybrid_wikisort_frame_sum(s : SorthybridwikisortFrame) -> Double { @_common.sum(s.data) }

pub fn sort_hybrid_wikisort_frame_mean(s : SorthybridwikisortFrame) -> Double { @_common.mean(s.data) }

pub fn sort_hybrid_wikisort_frame_scale(s : SorthybridwikisortFrame, f : Double) -> SorthybridwikisortFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_hybrid_wikisort_frame_add(a : SorthybridwikisortFrame, b : SorthybridwikisortFrame) -> SorthybridwikisortFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_hybrid_wikisort_frame_copy(s : SorthybridwikisortFrame) -> SorthybridwikisortFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_hybrid_wikisort_frame_fill(s : SorthybridwikisortFrame, v : Double) -> SorthybridwikisortFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_hybrid_wikisort_frame_min(s : SorthybridwikisortFrame) -> Double { @_common.min(s.data) }

pub fn sort_hybrid_wikisort_frame_max(s : SorthybridwikisortFrame) -> Double { @_common.max(s.data) }

pub fn sort_hybrid_wikisort_frame_to_string(s : SorthybridwikisortFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SorthybridwikisortTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_hybrid_wikisort_table_make(size : Int) -> SorthybridwikisortTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_hybrid_wikisort_table_len(s : SorthybridwikisortTable) -> Int { s.size }

pub fn sort_hybrid_wikisort_table_get(s : SorthybridwikisortTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_hybrid_wikisort_table_set(s : SorthybridwikisortTable, i : Int, v : Double) -> SorthybridwikisortTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_hybrid_wikisort_table_sum(s : SorthybridwikisortTable) -> Double { @_common.sum(s.data) }

pub fn sort_hybrid_wikisort_table_mean(s : SorthybridwikisortTable) -> Double { @_common.mean(s.data) }

pub fn sort_hybrid_wikisort_table_scale(s : SorthybridwikisortTable, f : Double) -> SorthybridwikisortTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_hybrid_wikisort_table_add(a : SorthybridwikisortTable, b : SorthybridwikisortTable) -> SorthybridwikisortTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_hybrid_wikisort_table_copy(s : SorthybridwikisortTable) -> SorthybridwikisortTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_hybrid_wikisort_table_fill(s : SorthybridwikisortTable, v : Double) -> SorthybridwikisortTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_hybrid_wikisort_table_min(s : SorthybridwikisortTable) -> Double { @_common.min(s.data) }

pub fn sort_hybrid_wikisort_table_max(s : SorthybridwikisortTable) -> Double { @_common.max(s.data) }

pub fn sort_hybrid_wikisort_table_to_string(s : SorthybridwikisortTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SorthybridwikisortGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_hybrid_wikisort_graphn_make(size : Int) -> SorthybridwikisortGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_hybrid_wikisort_graphn_len(s : SorthybridwikisortGraphN) -> Int { s.size }

pub fn sort_hybrid_wikisort_graphn_get(s : SorthybridwikisortGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_hybrid_wikisort_graphn_set(s : SorthybridwikisortGraphN, i : Int, v : Double) -> SorthybridwikisortGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_hybrid_wikisort_graphn_sum(s : SorthybridwikisortGraphN) -> Double { @_common.sum(s.data) }

pub fn sort_hybrid_wikisort_graphn_mean(s : SorthybridwikisortGraphN) -> Double { @_common.mean(s.data) }

pub fn sort_hybrid_wikisort_graphn_scale(s : SorthybridwikisortGraphN, f : Double) -> SorthybridwikisortGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_hybrid_wikisort_graphn_add(a : SorthybridwikisortGraphN, b : SorthybridwikisortGraphN) -> SorthybridwikisortGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_hybrid_wikisort_graphn_copy(s : SorthybridwikisortGraphN) -> SorthybridwikisortGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_hybrid_wikisort_graphn_fill(s : SorthybridwikisortGraphN, v : Double) -> SorthybridwikisortGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_hybrid_wikisort_graphn_min(s : SorthybridwikisortGraphN) -> Double { @_common.min(s.data) }

pub fn sort_hybrid_wikisort_graphn_max(s : SorthybridwikisortGraphN) -> Double { @_common.max(s.data) }

pub fn sort_hybrid_wikisort_graphn_to_string(s : SorthybridwikisortGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SorthybridwikisortNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_hybrid_wikisort_node_make(size : Int) -> SorthybridwikisortNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_hybrid_wikisort_node_len(s : SorthybridwikisortNode) -> Int { s.size }

pub fn sort_hybrid_wikisort_node_get(s : SorthybridwikisortNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_hybrid_wikisort_node_set(s : SorthybridwikisortNode, i : Int, v : Double) -> SorthybridwikisortNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_hybrid_wikisort_node_sum(s : SorthybridwikisortNode) -> Double { @_common.sum(s.data) }

pub fn sort_hybrid_wikisort_node_mean(s : SorthybridwikisortNode) -> Double { @_common.mean(s.data) }

pub fn sort_hybrid_wikisort_node_scale(s : SorthybridwikisortNode, f : Double) -> SorthybridwikisortNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_hybrid_wikisort_node_add(a : SorthybridwikisortNode, b : SorthybridwikisortNode) -> SorthybridwikisortNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_hybrid_wikisort_node_copy(s : SorthybridwikisortNode) -> SorthybridwikisortNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_hybrid_wikisort_node_fill(s : SorthybridwikisortNode, v : Double) -> SorthybridwikisortNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_hybrid_wikisort_node_min(s : SorthybridwikisortNode) -> Double { @_common.min(s.data) }

pub fn sort_hybrid_wikisort_node_max(s : SorthybridwikisortNode) -> Double { @_common.max(s.data) }

pub fn sort_hybrid_wikisort_node_to_string(s : SorthybridwikisortNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SorthybridwikisortEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_hybrid_wikisort_edge_make(size : Int) -> SorthybridwikisortEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_hybrid_wikisort_edge_len(s : SorthybridwikisortEdge) -> Int { s.size }

pub fn sort_hybrid_wikisort_edge_get(s : SorthybridwikisortEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_hybrid_wikisort_edge_set(s : SorthybridwikisortEdge, i : Int, v : Double) -> SorthybridwikisortEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_hybrid_wikisort_edge_sum(s : SorthybridwikisortEdge) -> Double { @_common.sum(s.data) }

pub fn sort_hybrid_wikisort_edge_mean(s : SorthybridwikisortEdge) -> Double { @_common.mean(s.data) }

pub fn sort_hybrid_wikisort_edge_scale(s : SorthybridwikisortEdge, f : Double) -> SorthybridwikisortEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_hybrid_wikisort_edge_add(a : SorthybridwikisortEdge, b : SorthybridwikisortEdge) -> SorthybridwikisortEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_hybrid_wikisort_edge_copy(s : SorthybridwikisortEdge) -> SorthybridwikisortEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_hybrid_wikisort_edge_fill(s : SorthybridwikisortEdge, v : Double) -> SorthybridwikisortEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_hybrid_wikisort_edge_min(s : SorthybridwikisortEdge) -> Double { @_common.min(s.data) }

pub fn sort_hybrid_wikisort_edge_max(s : SorthybridwikisortEdge) -> Double { @_common.max(s.data) }

pub fn sort_hybrid_wikisort_edge_to_string(s : SorthybridwikisortEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SorthybridwikisortPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_hybrid_wikisort_path_make(size : Int) -> SorthybridwikisortPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_hybrid_wikisort_path_len(s : SorthybridwikisortPath) -> Int { s.size }

pub fn sort_hybrid_wikisort_path_get(s : SorthybridwikisortPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_hybrid_wikisort_path_set(s : SorthybridwikisortPath, i : Int, v : Double) -> SorthybridwikisortPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_hybrid_wikisort_path_sum(s : SorthybridwikisortPath) -> Double { @_common.sum(s.data) }

pub fn sort_hybrid_wikisort_path_mean(s : SorthybridwikisortPath) -> Double { @_common.mean(s.data) }

pub fn sort_hybrid_wikisort_path_scale(s : SorthybridwikisortPath, f : Double) -> SorthybridwikisortPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_hybrid_wikisort_path_add(a : SorthybridwikisortPath, b : SorthybridwikisortPath) -> SorthybridwikisortPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_hybrid_wikisort_path_copy(s : SorthybridwikisortPath) -> SorthybridwikisortPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_hybrid_wikisort_path_fill(s : SorthybridwikisortPath, v : Double) -> SorthybridwikisortPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_hybrid_wikisort_path_min(s : SorthybridwikisortPath) -> Double { @_common.min(s.data) }

pub fn sort_hybrid_wikisort_path_max(s : SorthybridwikisortPath) -> Double { @_common.max(s.data) }

pub fn sort_hybrid_wikisort_path_to_string(s : SorthybridwikisortPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SorthybridwikisortCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_hybrid_wikisort_cluster_make(size : Int) -> SorthybridwikisortCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_hybrid_wikisort_cluster_len(s : SorthybridwikisortCluster) -> Int { s.size }

pub fn sort_hybrid_wikisort_cluster_get(s : SorthybridwikisortCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_hybrid_wikisort_cluster_set(s : SorthybridwikisortCluster, i : Int, v : Double) -> SorthybridwikisortCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_hybrid_wikisort_cluster_sum(s : SorthybridwikisortCluster) -> Double { @_common.sum(s.data) }

pub fn sort_hybrid_wikisort_cluster_mean(s : SorthybridwikisortCluster) -> Double { @_common.mean(s.data) }

pub fn sort_hybrid_wikisort_cluster_scale(s : SorthybridwikisortCluster, f : Double) -> SorthybridwikisortCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_hybrid_wikisort_cluster_add(a : SorthybridwikisortCluster, b : SorthybridwikisortCluster) -> SorthybridwikisortCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_hybrid_wikisort_cluster_copy(s : SorthybridwikisortCluster) -> SorthybridwikisortCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_hybrid_wikisort_cluster_fill(s : SorthybridwikisortCluster, v : Double) -> SorthybridwikisortCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_hybrid_wikisort_cluster_min(s : SorthybridwikisortCluster) -> Double { @_common.min(s.data) }

pub fn sort_hybrid_wikisort_cluster_max(s : SorthybridwikisortCluster) -> Double { @_common.max(s.data) }

pub fn sort_hybrid_wikisort_cluster_to_string(s : SorthybridwikisortCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SorthybridwikisortModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_hybrid_wikisort_model_make(size : Int) -> SorthybridwikisortModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_hybrid_wikisort_model_len(s : SorthybridwikisortModel) -> Int { s.size }

pub fn sort_hybrid_wikisort_model_get(s : SorthybridwikisortModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_hybrid_wikisort_model_set(s : SorthybridwikisortModel, i : Int, v : Double) -> SorthybridwikisortModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_hybrid_wikisort_model_sum(s : SorthybridwikisortModel) -> Double { @_common.sum(s.data) }

pub fn sort_hybrid_wikisort_model_mean(s : SorthybridwikisortModel) -> Double { @_common.mean(s.data) }

pub fn sort_hybrid_wikisort_model_scale(s : SorthybridwikisortModel, f : Double) -> SorthybridwikisortModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_hybrid_wikisort_model_add(a : SorthybridwikisortModel, b : SorthybridwikisortModel) -> SorthybridwikisortModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_hybrid_wikisort_model_copy(s : SorthybridwikisortModel) -> SorthybridwikisortModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_hybrid_wikisort_model_fill(s : SorthybridwikisortModel, v : Double) -> SorthybridwikisortModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_hybrid_wikisort_model_min(s : SorthybridwikisortModel) -> Double { @_common.min(s.data) }

pub fn sort_hybrid_wikisort_model_max(s : SorthybridwikisortModel) -> Double { @_common.max(s.data) }

pub fn sort_hybrid_wikisort_model_to_string(s : SorthybridwikisortModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SorthybridwikisortLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_hybrid_wikisort_layer_make(size : Int) -> SorthybridwikisortLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_hybrid_wikisort_layer_len(s : SorthybridwikisortLayer) -> Int { s.size }

pub fn sort_hybrid_wikisort_layer_get(s : SorthybridwikisortLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_hybrid_wikisort_layer_set(s : SorthybridwikisortLayer, i : Int, v : Double) -> SorthybridwikisortLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_hybrid_wikisort_layer_sum(s : SorthybridwikisortLayer) -> Double { @_common.sum(s.data) }

pub fn sort_hybrid_wikisort_layer_mean(s : SorthybridwikisortLayer) -> Double { @_common.mean(s.data) }

pub fn sort_hybrid_wikisort_layer_scale(s : SorthybridwikisortLayer, f : Double) -> SorthybridwikisortLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_hybrid_wikisort_layer_add(a : SorthybridwikisortLayer, b : SorthybridwikisortLayer) -> SorthybridwikisortLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_hybrid_wikisort_layer_copy(s : SorthybridwikisortLayer) -> SorthybridwikisortLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_hybrid_wikisort_layer_fill(s : SorthybridwikisortLayer, v : Double) -> SorthybridwikisortLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_hybrid_wikisort_layer_min(s : SorthybridwikisortLayer) -> Double { @_common.min(s.data) }

pub fn sort_hybrid_wikisort_layer_max(s : SorthybridwikisortLayer) -> Double { @_common.max(s.data) }

pub fn sort_hybrid_wikisort_layer_to_string(s : SorthybridwikisortLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SorthybridwikisortBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_hybrid_wikisort_buffer_make(size : Int) -> SorthybridwikisortBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_hybrid_wikisort_buffer_len(s : SorthybridwikisortBuffer) -> Int { s.size }

pub fn sort_hybrid_wikisort_buffer_get(s : SorthybridwikisortBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_hybrid_wikisort_buffer_set(s : SorthybridwikisortBuffer, i : Int, v : Double) -> SorthybridwikisortBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_hybrid_wikisort_buffer_sum(s : SorthybridwikisortBuffer) -> Double { @_common.sum(s.data) }

pub fn sort_hybrid_wikisort_buffer_mean(s : SorthybridwikisortBuffer) -> Double { @_common.mean(s.data) }

pub fn sort_hybrid_wikisort_buffer_scale(s : SorthybridwikisortBuffer, f : Double) -> SorthybridwikisortBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_hybrid_wikisort_buffer_add(a : SorthybridwikisortBuffer, b : SorthybridwikisortBuffer) -> SorthybridwikisortBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_hybrid_wikisort_buffer_copy(s : SorthybridwikisortBuffer) -> SorthybridwikisortBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_hybrid_wikisort_buffer_fill(s : SorthybridwikisortBuffer, v : Double) -> SorthybridwikisortBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_hybrid_wikisort_buffer_min(s : SorthybridwikisortBuffer) -> Double { @_common.min(s.data) }

pub fn sort_hybrid_wikisort_buffer_max(s : SorthybridwikisortBuffer) -> Double { @_common.max(s.data) }

pub fn sort_hybrid_wikisort_buffer_to_string(s : SorthybridwikisortBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SorthybridwikisortCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_hybrid_wikisort_cursor_make(size : Int) -> SorthybridwikisortCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_hybrid_wikisort_cursor_len(s : SorthybridwikisortCursor) -> Int { s.size }

pub fn sort_hybrid_wikisort_cursor_get(s : SorthybridwikisortCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_hybrid_wikisort_cursor_set(s : SorthybridwikisortCursor, i : Int, v : Double) -> SorthybridwikisortCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_hybrid_wikisort_cursor_sum(s : SorthybridwikisortCursor) -> Double { @_common.sum(s.data) }

pub fn sort_hybrid_wikisort_cursor_mean(s : SorthybridwikisortCursor) -> Double { @_common.mean(s.data) }

pub fn sort_hybrid_wikisort_cursor_scale(s : SorthybridwikisortCursor, f : Double) -> SorthybridwikisortCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_hybrid_wikisort_cursor_add(a : SorthybridwikisortCursor, b : SorthybridwikisortCursor) -> SorthybridwikisortCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_hybrid_wikisort_cursor_copy(s : SorthybridwikisortCursor) -> SorthybridwikisortCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_hybrid_wikisort_cursor_fill(s : SorthybridwikisortCursor, v : Double) -> SorthybridwikisortCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_hybrid_wikisort_cursor_min(s : SorthybridwikisortCursor) -> Double { @_common.min(s.data) }

pub fn sort_hybrid_wikisort_cursor_max(s : SorthybridwikisortCursor) -> Double { @_common.max(s.data) }

pub fn sort_hybrid_wikisort_cursor_to_string(s : SorthybridwikisortCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SorthybridwikisortView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_hybrid_wikisort_view_make(size : Int) -> SorthybridwikisortView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_hybrid_wikisort_view_len(s : SorthybridwikisortView) -> Int { s.size }

pub fn sort_hybrid_wikisort_view_get(s : SorthybridwikisortView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_hybrid_wikisort_view_set(s : SorthybridwikisortView, i : Int, v : Double) -> SorthybridwikisortView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_hybrid_wikisort_view_sum(s : SorthybridwikisortView) -> Double { @_common.sum(s.data) }

pub fn sort_hybrid_wikisort_view_mean(s : SorthybridwikisortView) -> Double { @_common.mean(s.data) }

pub fn sort_hybrid_wikisort_view_scale(s : SorthybridwikisortView, f : Double) -> SorthybridwikisortView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_hybrid_wikisort_view_add(a : SorthybridwikisortView, b : SorthybridwikisortView) -> SorthybridwikisortView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_hybrid_wikisort_view_copy(s : SorthybridwikisortView) -> SorthybridwikisortView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_hybrid_wikisort_view_fill(s : SorthybridwikisortView, v : Double) -> SorthybridwikisortView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_hybrid_wikisort_view_min(s : SorthybridwikisortView) -> Double { @_common.min(s.data) }

pub fn sort_hybrid_wikisort_view_max(s : SorthybridwikisortView) -> Double { @_common.max(s.data) }

pub fn sort_hybrid_wikisort_view_to_string(s : SorthybridwikisortView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SorthybridwikisortRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_hybrid_wikisort_range_make(size : Int) -> SorthybridwikisortRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_hybrid_wikisort_range_len(s : SorthybridwikisortRange) -> Int { s.size }

pub fn sort_hybrid_wikisort_range_get(s : SorthybridwikisortRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_hybrid_wikisort_range_set(s : SorthybridwikisortRange, i : Int, v : Double) -> SorthybridwikisortRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_hybrid_wikisort_range_sum(s : SorthybridwikisortRange) -> Double { @_common.sum(s.data) }

pub fn sort_hybrid_wikisort_range_mean(s : SorthybridwikisortRange) -> Double { @_common.mean(s.data) }

pub fn sort_hybrid_wikisort_range_scale(s : SorthybridwikisortRange, f : Double) -> SorthybridwikisortRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_hybrid_wikisort_range_add(a : SorthybridwikisortRange, b : SorthybridwikisortRange) -> SorthybridwikisortRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_hybrid_wikisort_range_copy(s : SorthybridwikisortRange) -> SorthybridwikisortRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_hybrid_wikisort_range_fill(s : SorthybridwikisortRange, v : Double) -> SorthybridwikisortRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_hybrid_wikisort_range_min(s : SorthybridwikisortRange) -> Double { @_common.min(s.data) }

pub fn sort_hybrid_wikisort_range_max(s : SorthybridwikisortRange) -> Double { @_common.max(s.data) }

pub fn sort_hybrid_wikisort_range_to_string(s : SorthybridwikisortRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SorthybridwikisortSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_hybrid_wikisort_slice_make(size : Int) -> SorthybridwikisortSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_hybrid_wikisort_slice_len(s : SorthybridwikisortSlice) -> Int { s.size }

pub fn sort_hybrid_wikisort_slice_get(s : SorthybridwikisortSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_hybrid_wikisort_slice_set(s : SorthybridwikisortSlice, i : Int, v : Double) -> SorthybridwikisortSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_hybrid_wikisort_slice_sum(s : SorthybridwikisortSlice) -> Double { @_common.sum(s.data) }

pub fn sort_hybrid_wikisort_slice_mean(s : SorthybridwikisortSlice) -> Double { @_common.mean(s.data) }

pub fn sort_hybrid_wikisort_slice_scale(s : SorthybridwikisortSlice, f : Double) -> SorthybridwikisortSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_hybrid_wikisort_slice_add(a : SorthybridwikisortSlice, b : SorthybridwikisortSlice) -> SorthybridwikisortSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_hybrid_wikisort_slice_copy(s : SorthybridwikisortSlice) -> SorthybridwikisortSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_hybrid_wikisort_slice_fill(s : SorthybridwikisortSlice, v : Double) -> SorthybridwikisortSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_hybrid_wikisort_slice_min(s : SorthybridwikisortSlice) -> Double { @_common.min(s.data) }

pub fn sort_hybrid_wikisort_slice_max(s : SorthybridwikisortSlice) -> Double { @_common.max(s.data) }

pub fn sort_hybrid_wikisort_slice_to_string(s : SorthybridwikisortSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

