///===
/// extcore/sort_hybrid_quadsort

pub(all) struct SorthybridquadsortPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn sort_hybrid_quadsort_make_point(x : Double, y : Double) -> SorthybridquadsortPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn sort_hybrid_quadsort_make_point3(x : Double, y : Double, z : Double) -> SorthybridquadsortPoint {
  { x, y, z, label: 0 }
}

pub fn SorthybridquadsortPoint::x(self : SorthybridquadsortPoint) -> Double { self.x }

pub fn SorthybridquadsortPoint::y(self : SorthybridquadsortPoint) -> Double { self.y }

pub fn SorthybridquadsortPoint::z(self : SorthybridquadsortPoint) -> Double { self.z }

pub fn SorthybridquadsortPoint::label(self : SorthybridquadsortPoint) -> Int { self.label }

pub fn SorthybridquadsortPoint::dist(self : SorthybridquadsortPoint, other : SorthybridquadsortPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn SorthybridquadsortPoint::add(self : SorthybridquadsortPoint, other : SorthybridquadsortPoint) -> SorthybridquadsortPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn SorthybridquadsortPoint::sub(self : SorthybridquadsortPoint, other : SorthybridquadsortPoint) -> SorthybridquadsortPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn SorthybridquadsortPoint::scale(self : SorthybridquadsortPoint, s : Double) -> SorthybridquadsortPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn SorthybridquadsortPoint::dot(self : SorthybridquadsortPoint, other : SorthybridquadsortPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn SorthybridquadsortPoint::cross(self : SorthybridquadsortPoint, other : SorthybridquadsortPoint) -> SorthybridquadsortPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn SorthybridquadsortPoint::norm(self : SorthybridquadsortPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn SorthybridquadsortPoint::normalize(self : SorthybridquadsortPoint) -> SorthybridquadsortPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn SorthybridquadsortPoint::negate(self : SorthybridquadsortPoint) -> SorthybridquadsortPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn SorthybridquadsortPoint::mid(self : SorthybridquadsortPoint, other : SorthybridquadsortPoint) -> SorthybridquadsortPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn SorthybridquadsortPoint::lerp(self : SorthybridquadsortPoint, other : SorthybridquadsortPoint, t : Double) -> SorthybridquadsortPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn SorthybridquadsortPoint::to_string(self : SorthybridquadsortPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct SorthybridquadsortSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn sort_hybrid_quadsort_make_series(vals : Array[Double], name : String) -> SorthybridquadsortSeries {
  { vals, name, meta: 0 }
}

pub fn SorthybridquadsortSeries::len(self : SorthybridquadsortSeries) -> Int { self.vals.length() }

pub fn SorthybridquadsortSeries::sum(self : SorthybridquadsortSeries) -> Double { @_common.sum(self.vals) }

pub fn SorthybridquadsortSeries::mean(self : SorthybridquadsortSeries) -> Double { @_common.mean(self.vals) }

pub fn SorthybridquadsortSeries::min(self : SorthybridquadsortSeries) -> Double { @_common.min(self.vals) }

pub fn SorthybridquadsortSeries::max(self : SorthybridquadsortSeries) -> Double { @_common.max(self.vals) }

pub fn SorthybridquadsortSeries::range(self : SorthybridquadsortSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn SorthybridquadsortSeries::variance(self : SorthybridquadsortSeries) -> Double { @_common.variance(self.vals) }

pub fn SorthybridquadsortSeries::std(self : SorthybridquadsortSeries) -> Double { @_common.std(self.vals) }

pub fn SorthybridquadsortSeries::median(self : SorthybridquadsortSeries) -> Double { @_common.median(self.vals) }

pub fn SorthybridquadsortSeries::scale(self : SorthybridquadsortSeries, f : Double) -> SorthybridquadsortSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn SorthybridquadsortSeries::add(self : SorthybridquadsortSeries, other : SorthybridquadsortSeries) -> SorthybridquadsortSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn SorthybridquadsortSeries::sub(self : SorthybridquadsortSeries, other : SorthybridquadsortSeries) -> SorthybridquadsortSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn SorthybridquadsortSeries::normalize(self : SorthybridquadsortSeries) -> SorthybridquadsortSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn SorthybridquadsortSeries::cumsum(self : SorthybridquadsortSeries) -> SorthybridquadsortSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn SorthybridquadsortSeries::to_string(self : SorthybridquadsortSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct SorthybridquadsortMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn sort_hybrid_quadsort_make_matrix(rows : Int, cols : Int, val : Double) -> SorthybridquadsortMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn sort_hybrid_quadsort_matrix_identity(n : Int) -> SorthybridquadsortMatrix {
  let m = sort_hybrid_quadsort_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn SorthybridquadsortMatrix::get(self : SorthybridquadsortMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn SorthybridquadsortMatrix::transpose(self : SorthybridquadsortMatrix) -> SorthybridquadsortMatrix {
  let result = sort_hybrid_quadsort_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn SorthybridquadsortMatrix::add(self : SorthybridquadsortMatrix, other : SorthybridquadsortMatrix) -> SorthybridquadsortMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = sort_hybrid_quadsort_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn SorthybridquadsortMatrix::scale(self : SorthybridquadsortMatrix, s : Double) -> SorthybridquadsortMatrix {
  let result = sort_hybrid_quadsort_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn SorthybridquadsortMatrix::multiply(self : SorthybridquadsortMatrix, other : SorthybridquadsortMatrix) -> SorthybridquadsortMatrix {
  if self.cols != other.rows { return sort_hybrid_quadsort_make_matrix(self.rows, other.cols, 0.0) }
  let result = sort_hybrid_quadsort_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn SorthybridquadsortMatrix::trace(self : SorthybridquadsortMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn SorthybridquadsortMatrix::det(self : SorthybridquadsortMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn SorthybridquadsortMatrix::norm(self : SorthybridquadsortMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn SorthybridquadsortMatrix::to_string(self : SorthybridquadsortMatrix) -> String {
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

pub(all) struct SorthybridquadsortVector {
  comps : Array[Double]
  dim : Int
}

pub fn sort_hybrid_quadsort_make_vector(comps : Array[Double]) -> SorthybridquadsortVector {
  { comps, dim: comps.length() }
}

pub fn sort_hybrid_quadsort_vector_zero(dim : Int) -> SorthybridquadsortVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn SorthybridquadsortVector::add(self : SorthybridquadsortVector, other : SorthybridquadsortVector) -> SorthybridquadsortVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn SorthybridquadsortVector::sub(self : SorthybridquadsortVector, other : SorthybridquadsortVector) -> SorthybridquadsortVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn SorthybridquadsortVector::scale(self : SorthybridquadsortVector, s : Double) -> SorthybridquadsortVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn SorthybridquadsortVector::dot(self : SorthybridquadsortVector, other : SorthybridquadsortVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn SorthybridquadsortVector::norm(self : SorthybridquadsortVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn SorthybridquadsortVector::normalize(self : SorthybridquadsortVector) -> SorthybridquadsortVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn SorthybridquadsortVector::dist(self : SorthybridquadsortVector, other : SorthybridquadsortVector) -> Double {
  self.sub(other).norm()
}

pub fn SorthybridquadsortVector::to_string(self : SorthybridquadsortVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn sort_hybrid_quadsort_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn sort_hybrid_quadsort_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn sort_hybrid_quadsort_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn sort_hybrid_quadsort_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn sort_hybrid_quadsort_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn sort_hybrid_quadsort_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn sort_hybrid_quadsort_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn sort_hybrid_quadsort_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn sort_hybrid_quadsort_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn sort_hybrid_quadsort_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn sort_hybrid_quadsort_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn sort_hybrid_quadsort_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn sort_hybrid_quadsort_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn sort_hybrid_quadsort_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn sort_hybrid_quadsort_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn sort_hybrid_quadsort_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn sort_hybrid_quadsort_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn sort_hybrid_quadsort_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn sort_hybrid_quadsort_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn sort_hybrid_quadsort_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn sort_hybrid_quadsort_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn sort_hybrid_quadsort_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn sort_hybrid_quadsort_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn sort_hybrid_quadsort_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn sort_hybrid_quadsort_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn sort_hybrid_quadsort_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn sort_hybrid_quadsort_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn sort_hybrid_quadsort_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn sort_hybrid_quadsort_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct SorthybridquadsortFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_hybrid_quadsort_frame_make(size : Int) -> SorthybridquadsortFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_hybrid_quadsort_frame_len(s : SorthybridquadsortFrame) -> Int { s.size }

pub fn sort_hybrid_quadsort_frame_get(s : SorthybridquadsortFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_hybrid_quadsort_frame_set(s : SorthybridquadsortFrame, i : Int, v : Double) -> SorthybridquadsortFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_hybrid_quadsort_frame_sum(s : SorthybridquadsortFrame) -> Double { @_common.sum(s.data) }

pub fn sort_hybrid_quadsort_frame_mean(s : SorthybridquadsortFrame) -> Double { @_common.mean(s.data) }

pub fn sort_hybrid_quadsort_frame_scale(s : SorthybridquadsortFrame, f : Double) -> SorthybridquadsortFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_hybrid_quadsort_frame_add(a : SorthybridquadsortFrame, b : SorthybridquadsortFrame) -> SorthybridquadsortFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_hybrid_quadsort_frame_copy(s : SorthybridquadsortFrame) -> SorthybridquadsortFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_hybrid_quadsort_frame_fill(s : SorthybridquadsortFrame, v : Double) -> SorthybridquadsortFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_hybrid_quadsort_frame_min(s : SorthybridquadsortFrame) -> Double { @_common.min(s.data) }

pub fn sort_hybrid_quadsort_frame_max(s : SorthybridquadsortFrame) -> Double { @_common.max(s.data) }

pub fn sort_hybrid_quadsort_frame_to_string(s : SorthybridquadsortFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SorthybridquadsortTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_hybrid_quadsort_table_make(size : Int) -> SorthybridquadsortTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_hybrid_quadsort_table_len(s : SorthybridquadsortTable) -> Int { s.size }

pub fn sort_hybrid_quadsort_table_get(s : SorthybridquadsortTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_hybrid_quadsort_table_set(s : SorthybridquadsortTable, i : Int, v : Double) -> SorthybridquadsortTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_hybrid_quadsort_table_sum(s : SorthybridquadsortTable) -> Double { @_common.sum(s.data) }

pub fn sort_hybrid_quadsort_table_mean(s : SorthybridquadsortTable) -> Double { @_common.mean(s.data) }

pub fn sort_hybrid_quadsort_table_scale(s : SorthybridquadsortTable, f : Double) -> SorthybridquadsortTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_hybrid_quadsort_table_add(a : SorthybridquadsortTable, b : SorthybridquadsortTable) -> SorthybridquadsortTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_hybrid_quadsort_table_copy(s : SorthybridquadsortTable) -> SorthybridquadsortTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_hybrid_quadsort_table_fill(s : SorthybridquadsortTable, v : Double) -> SorthybridquadsortTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_hybrid_quadsort_table_min(s : SorthybridquadsortTable) -> Double { @_common.min(s.data) }

pub fn sort_hybrid_quadsort_table_max(s : SorthybridquadsortTable) -> Double { @_common.max(s.data) }

pub fn sort_hybrid_quadsort_table_to_string(s : SorthybridquadsortTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SorthybridquadsortGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_hybrid_quadsort_graphn_make(size : Int) -> SorthybridquadsortGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_hybrid_quadsort_graphn_len(s : SorthybridquadsortGraphN) -> Int { s.size }

pub fn sort_hybrid_quadsort_graphn_get(s : SorthybridquadsortGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_hybrid_quadsort_graphn_set(s : SorthybridquadsortGraphN, i : Int, v : Double) -> SorthybridquadsortGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_hybrid_quadsort_graphn_sum(s : SorthybridquadsortGraphN) -> Double { @_common.sum(s.data) }

pub fn sort_hybrid_quadsort_graphn_mean(s : SorthybridquadsortGraphN) -> Double { @_common.mean(s.data) }

pub fn sort_hybrid_quadsort_graphn_scale(s : SorthybridquadsortGraphN, f : Double) -> SorthybridquadsortGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_hybrid_quadsort_graphn_add(a : SorthybridquadsortGraphN, b : SorthybridquadsortGraphN) -> SorthybridquadsortGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_hybrid_quadsort_graphn_copy(s : SorthybridquadsortGraphN) -> SorthybridquadsortGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_hybrid_quadsort_graphn_fill(s : SorthybridquadsortGraphN, v : Double) -> SorthybridquadsortGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_hybrid_quadsort_graphn_min(s : SorthybridquadsortGraphN) -> Double { @_common.min(s.data) }

pub fn sort_hybrid_quadsort_graphn_max(s : SorthybridquadsortGraphN) -> Double { @_common.max(s.data) }

pub fn sort_hybrid_quadsort_graphn_to_string(s : SorthybridquadsortGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SorthybridquadsortNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_hybrid_quadsort_node_make(size : Int) -> SorthybridquadsortNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_hybrid_quadsort_node_len(s : SorthybridquadsortNode) -> Int { s.size }

pub fn sort_hybrid_quadsort_node_get(s : SorthybridquadsortNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_hybrid_quadsort_node_set(s : SorthybridquadsortNode, i : Int, v : Double) -> SorthybridquadsortNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_hybrid_quadsort_node_sum(s : SorthybridquadsortNode) -> Double { @_common.sum(s.data) }

pub fn sort_hybrid_quadsort_node_mean(s : SorthybridquadsortNode) -> Double { @_common.mean(s.data) }

pub fn sort_hybrid_quadsort_node_scale(s : SorthybridquadsortNode, f : Double) -> SorthybridquadsortNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_hybrid_quadsort_node_add(a : SorthybridquadsortNode, b : SorthybridquadsortNode) -> SorthybridquadsortNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_hybrid_quadsort_node_copy(s : SorthybridquadsortNode) -> SorthybridquadsortNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_hybrid_quadsort_node_fill(s : SorthybridquadsortNode, v : Double) -> SorthybridquadsortNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_hybrid_quadsort_node_min(s : SorthybridquadsortNode) -> Double { @_common.min(s.data) }

pub fn sort_hybrid_quadsort_node_max(s : SorthybridquadsortNode) -> Double { @_common.max(s.data) }

pub fn sort_hybrid_quadsort_node_to_string(s : SorthybridquadsortNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SorthybridquadsortEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_hybrid_quadsort_edge_make(size : Int) -> SorthybridquadsortEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_hybrid_quadsort_edge_len(s : SorthybridquadsortEdge) -> Int { s.size }

pub fn sort_hybrid_quadsort_edge_get(s : SorthybridquadsortEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_hybrid_quadsort_edge_set(s : SorthybridquadsortEdge, i : Int, v : Double) -> SorthybridquadsortEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_hybrid_quadsort_edge_sum(s : SorthybridquadsortEdge) -> Double { @_common.sum(s.data) }

pub fn sort_hybrid_quadsort_edge_mean(s : SorthybridquadsortEdge) -> Double { @_common.mean(s.data) }

pub fn sort_hybrid_quadsort_edge_scale(s : SorthybridquadsortEdge, f : Double) -> SorthybridquadsortEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_hybrid_quadsort_edge_add(a : SorthybridquadsortEdge, b : SorthybridquadsortEdge) -> SorthybridquadsortEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_hybrid_quadsort_edge_copy(s : SorthybridquadsortEdge) -> SorthybridquadsortEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_hybrid_quadsort_edge_fill(s : SorthybridquadsortEdge, v : Double) -> SorthybridquadsortEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_hybrid_quadsort_edge_min(s : SorthybridquadsortEdge) -> Double { @_common.min(s.data) }

pub fn sort_hybrid_quadsort_edge_max(s : SorthybridquadsortEdge) -> Double { @_common.max(s.data) }

pub fn sort_hybrid_quadsort_edge_to_string(s : SorthybridquadsortEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SorthybridquadsortPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_hybrid_quadsort_path_make(size : Int) -> SorthybridquadsortPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_hybrid_quadsort_path_len(s : SorthybridquadsortPath) -> Int { s.size }

pub fn sort_hybrid_quadsort_path_get(s : SorthybridquadsortPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_hybrid_quadsort_path_set(s : SorthybridquadsortPath, i : Int, v : Double) -> SorthybridquadsortPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_hybrid_quadsort_path_sum(s : SorthybridquadsortPath) -> Double { @_common.sum(s.data) }

pub fn sort_hybrid_quadsort_path_mean(s : SorthybridquadsortPath) -> Double { @_common.mean(s.data) }

pub fn sort_hybrid_quadsort_path_scale(s : SorthybridquadsortPath, f : Double) -> SorthybridquadsortPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_hybrid_quadsort_path_add(a : SorthybridquadsortPath, b : SorthybridquadsortPath) -> SorthybridquadsortPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_hybrid_quadsort_path_copy(s : SorthybridquadsortPath) -> SorthybridquadsortPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_hybrid_quadsort_path_fill(s : SorthybridquadsortPath, v : Double) -> SorthybridquadsortPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_hybrid_quadsort_path_min(s : SorthybridquadsortPath) -> Double { @_common.min(s.data) }

pub fn sort_hybrid_quadsort_path_max(s : SorthybridquadsortPath) -> Double { @_common.max(s.data) }

pub fn sort_hybrid_quadsort_path_to_string(s : SorthybridquadsortPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SorthybridquadsortCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_hybrid_quadsort_cluster_make(size : Int) -> SorthybridquadsortCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_hybrid_quadsort_cluster_len(s : SorthybridquadsortCluster) -> Int { s.size }

pub fn sort_hybrid_quadsort_cluster_get(s : SorthybridquadsortCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_hybrid_quadsort_cluster_set(s : SorthybridquadsortCluster, i : Int, v : Double) -> SorthybridquadsortCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_hybrid_quadsort_cluster_sum(s : SorthybridquadsortCluster) -> Double { @_common.sum(s.data) }

pub fn sort_hybrid_quadsort_cluster_mean(s : SorthybridquadsortCluster) -> Double { @_common.mean(s.data) }

pub fn sort_hybrid_quadsort_cluster_scale(s : SorthybridquadsortCluster, f : Double) -> SorthybridquadsortCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_hybrid_quadsort_cluster_add(a : SorthybridquadsortCluster, b : SorthybridquadsortCluster) -> SorthybridquadsortCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_hybrid_quadsort_cluster_copy(s : SorthybridquadsortCluster) -> SorthybridquadsortCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_hybrid_quadsort_cluster_fill(s : SorthybridquadsortCluster, v : Double) -> SorthybridquadsortCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_hybrid_quadsort_cluster_min(s : SorthybridquadsortCluster) -> Double { @_common.min(s.data) }

pub fn sort_hybrid_quadsort_cluster_max(s : SorthybridquadsortCluster) -> Double { @_common.max(s.data) }

pub fn sort_hybrid_quadsort_cluster_to_string(s : SorthybridquadsortCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SorthybridquadsortModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_hybrid_quadsort_model_make(size : Int) -> SorthybridquadsortModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_hybrid_quadsort_model_len(s : SorthybridquadsortModel) -> Int { s.size }

pub fn sort_hybrid_quadsort_model_get(s : SorthybridquadsortModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_hybrid_quadsort_model_set(s : SorthybridquadsortModel, i : Int, v : Double) -> SorthybridquadsortModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_hybrid_quadsort_model_sum(s : SorthybridquadsortModel) -> Double { @_common.sum(s.data) }

pub fn sort_hybrid_quadsort_model_mean(s : SorthybridquadsortModel) -> Double { @_common.mean(s.data) }

pub fn sort_hybrid_quadsort_model_scale(s : SorthybridquadsortModel, f : Double) -> SorthybridquadsortModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_hybrid_quadsort_model_add(a : SorthybridquadsortModel, b : SorthybridquadsortModel) -> SorthybridquadsortModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_hybrid_quadsort_model_copy(s : SorthybridquadsortModel) -> SorthybridquadsortModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_hybrid_quadsort_model_fill(s : SorthybridquadsortModel, v : Double) -> SorthybridquadsortModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_hybrid_quadsort_model_min(s : SorthybridquadsortModel) -> Double { @_common.min(s.data) }

pub fn sort_hybrid_quadsort_model_max(s : SorthybridquadsortModel) -> Double { @_common.max(s.data) }

pub fn sort_hybrid_quadsort_model_to_string(s : SorthybridquadsortModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SorthybridquadsortLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_hybrid_quadsort_layer_make(size : Int) -> SorthybridquadsortLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_hybrid_quadsort_layer_len(s : SorthybridquadsortLayer) -> Int { s.size }

pub fn sort_hybrid_quadsort_layer_get(s : SorthybridquadsortLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_hybrid_quadsort_layer_set(s : SorthybridquadsortLayer, i : Int, v : Double) -> SorthybridquadsortLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_hybrid_quadsort_layer_sum(s : SorthybridquadsortLayer) -> Double { @_common.sum(s.data) }

pub fn sort_hybrid_quadsort_layer_mean(s : SorthybridquadsortLayer) -> Double { @_common.mean(s.data) }

pub fn sort_hybrid_quadsort_layer_scale(s : SorthybridquadsortLayer, f : Double) -> SorthybridquadsortLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_hybrid_quadsort_layer_add(a : SorthybridquadsortLayer, b : SorthybridquadsortLayer) -> SorthybridquadsortLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_hybrid_quadsort_layer_copy(s : SorthybridquadsortLayer) -> SorthybridquadsortLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_hybrid_quadsort_layer_fill(s : SorthybridquadsortLayer, v : Double) -> SorthybridquadsortLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_hybrid_quadsort_layer_min(s : SorthybridquadsortLayer) -> Double { @_common.min(s.data) }

pub fn sort_hybrid_quadsort_layer_max(s : SorthybridquadsortLayer) -> Double { @_common.max(s.data) }

pub fn sort_hybrid_quadsort_layer_to_string(s : SorthybridquadsortLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SorthybridquadsortBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_hybrid_quadsort_buffer_make(size : Int) -> SorthybridquadsortBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_hybrid_quadsort_buffer_len(s : SorthybridquadsortBuffer) -> Int { s.size }

pub fn sort_hybrid_quadsort_buffer_get(s : SorthybridquadsortBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_hybrid_quadsort_buffer_set(s : SorthybridquadsortBuffer, i : Int, v : Double) -> SorthybridquadsortBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_hybrid_quadsort_buffer_sum(s : SorthybridquadsortBuffer) -> Double { @_common.sum(s.data) }

pub fn sort_hybrid_quadsort_buffer_mean(s : SorthybridquadsortBuffer) -> Double { @_common.mean(s.data) }

pub fn sort_hybrid_quadsort_buffer_scale(s : SorthybridquadsortBuffer, f : Double) -> SorthybridquadsortBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_hybrid_quadsort_buffer_add(a : SorthybridquadsortBuffer, b : SorthybridquadsortBuffer) -> SorthybridquadsortBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_hybrid_quadsort_buffer_copy(s : SorthybridquadsortBuffer) -> SorthybridquadsortBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_hybrid_quadsort_buffer_fill(s : SorthybridquadsortBuffer, v : Double) -> SorthybridquadsortBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_hybrid_quadsort_buffer_min(s : SorthybridquadsortBuffer) -> Double { @_common.min(s.data) }

pub fn sort_hybrid_quadsort_buffer_max(s : SorthybridquadsortBuffer) -> Double { @_common.max(s.data) }

pub fn sort_hybrid_quadsort_buffer_to_string(s : SorthybridquadsortBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SorthybridquadsortCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_hybrid_quadsort_cursor_make(size : Int) -> SorthybridquadsortCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_hybrid_quadsort_cursor_len(s : SorthybridquadsortCursor) -> Int { s.size }

pub fn sort_hybrid_quadsort_cursor_get(s : SorthybridquadsortCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_hybrid_quadsort_cursor_set(s : SorthybridquadsortCursor, i : Int, v : Double) -> SorthybridquadsortCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_hybrid_quadsort_cursor_sum(s : SorthybridquadsortCursor) -> Double { @_common.sum(s.data) }

pub fn sort_hybrid_quadsort_cursor_mean(s : SorthybridquadsortCursor) -> Double { @_common.mean(s.data) }

pub fn sort_hybrid_quadsort_cursor_scale(s : SorthybridquadsortCursor, f : Double) -> SorthybridquadsortCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_hybrid_quadsort_cursor_add(a : SorthybridquadsortCursor, b : SorthybridquadsortCursor) -> SorthybridquadsortCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_hybrid_quadsort_cursor_copy(s : SorthybridquadsortCursor) -> SorthybridquadsortCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_hybrid_quadsort_cursor_fill(s : SorthybridquadsortCursor, v : Double) -> SorthybridquadsortCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_hybrid_quadsort_cursor_min(s : SorthybridquadsortCursor) -> Double { @_common.min(s.data) }

pub fn sort_hybrid_quadsort_cursor_max(s : SorthybridquadsortCursor) -> Double { @_common.max(s.data) }

pub fn sort_hybrid_quadsort_cursor_to_string(s : SorthybridquadsortCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SorthybridquadsortView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_hybrid_quadsort_view_make(size : Int) -> SorthybridquadsortView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_hybrid_quadsort_view_len(s : SorthybridquadsortView) -> Int { s.size }

pub fn sort_hybrid_quadsort_view_get(s : SorthybridquadsortView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_hybrid_quadsort_view_set(s : SorthybridquadsortView, i : Int, v : Double) -> SorthybridquadsortView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_hybrid_quadsort_view_sum(s : SorthybridquadsortView) -> Double { @_common.sum(s.data) }

pub fn sort_hybrid_quadsort_view_mean(s : SorthybridquadsortView) -> Double { @_common.mean(s.data) }

pub fn sort_hybrid_quadsort_view_scale(s : SorthybridquadsortView, f : Double) -> SorthybridquadsortView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_hybrid_quadsort_view_add(a : SorthybridquadsortView, b : SorthybridquadsortView) -> SorthybridquadsortView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_hybrid_quadsort_view_copy(s : SorthybridquadsortView) -> SorthybridquadsortView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_hybrid_quadsort_view_fill(s : SorthybridquadsortView, v : Double) -> SorthybridquadsortView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_hybrid_quadsort_view_min(s : SorthybridquadsortView) -> Double { @_common.min(s.data) }

pub fn sort_hybrid_quadsort_view_max(s : SorthybridquadsortView) -> Double { @_common.max(s.data) }

pub fn sort_hybrid_quadsort_view_to_string(s : SorthybridquadsortView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SorthybridquadsortRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_hybrid_quadsort_range_make(size : Int) -> SorthybridquadsortRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_hybrid_quadsort_range_len(s : SorthybridquadsortRange) -> Int { s.size }

pub fn sort_hybrid_quadsort_range_get(s : SorthybridquadsortRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_hybrid_quadsort_range_set(s : SorthybridquadsortRange, i : Int, v : Double) -> SorthybridquadsortRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_hybrid_quadsort_range_sum(s : SorthybridquadsortRange) -> Double { @_common.sum(s.data) }

pub fn sort_hybrid_quadsort_range_mean(s : SorthybridquadsortRange) -> Double { @_common.mean(s.data) }

pub fn sort_hybrid_quadsort_range_scale(s : SorthybridquadsortRange, f : Double) -> SorthybridquadsortRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_hybrid_quadsort_range_add(a : SorthybridquadsortRange, b : SorthybridquadsortRange) -> SorthybridquadsortRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_hybrid_quadsort_range_copy(s : SorthybridquadsortRange) -> SorthybridquadsortRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_hybrid_quadsort_range_fill(s : SorthybridquadsortRange, v : Double) -> SorthybridquadsortRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_hybrid_quadsort_range_min(s : SorthybridquadsortRange) -> Double { @_common.min(s.data) }

pub fn sort_hybrid_quadsort_range_max(s : SorthybridquadsortRange) -> Double { @_common.max(s.data) }

pub fn sort_hybrid_quadsort_range_to_string(s : SorthybridquadsortRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SorthybridquadsortSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_hybrid_quadsort_slice_make(size : Int) -> SorthybridquadsortSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_hybrid_quadsort_slice_len(s : SorthybridquadsortSlice) -> Int { s.size }

pub fn sort_hybrid_quadsort_slice_get(s : SorthybridquadsortSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_hybrid_quadsort_slice_set(s : SorthybridquadsortSlice, i : Int, v : Double) -> SorthybridquadsortSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_hybrid_quadsort_slice_sum(s : SorthybridquadsortSlice) -> Double { @_common.sum(s.data) }

pub fn sort_hybrid_quadsort_slice_mean(s : SorthybridquadsortSlice) -> Double { @_common.mean(s.data) }

pub fn sort_hybrid_quadsort_slice_scale(s : SorthybridquadsortSlice, f : Double) -> SorthybridquadsortSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_hybrid_quadsort_slice_add(a : SorthybridquadsortSlice, b : SorthybridquadsortSlice) -> SorthybridquadsortSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_hybrid_quadsort_slice_copy(s : SorthybridquadsortSlice) -> SorthybridquadsortSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_hybrid_quadsort_slice_fill(s : SorthybridquadsortSlice, v : Double) -> SorthybridquadsortSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_hybrid_quadsort_slice_min(s : SorthybridquadsortSlice) -> Double { @_common.min(s.data) }

pub fn sort_hybrid_quadsort_slice_max(s : SorthybridquadsortSlice) -> Double { @_common.max(s.data) }

pub fn sort_hybrid_quadsort_slice_to_string(s : SorthybridquadsortSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

