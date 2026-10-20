///===
/// extcore/sort_hybrid_blocksort

pub(all) struct SorthybridblocksortPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn sort_hybrid_blocksort_make_point(x : Double, y : Double) -> SorthybridblocksortPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn sort_hybrid_blocksort_make_point3(x : Double, y : Double, z : Double) -> SorthybridblocksortPoint {
  { x, y, z, label: 0 }
}

pub fn SorthybridblocksortPoint::x(self : SorthybridblocksortPoint) -> Double { self.x }

pub fn SorthybridblocksortPoint::y(self : SorthybridblocksortPoint) -> Double { self.y }

pub fn SorthybridblocksortPoint::z(self : SorthybridblocksortPoint) -> Double { self.z }

pub fn SorthybridblocksortPoint::label(self : SorthybridblocksortPoint) -> Int { self.label }

pub fn SorthybridblocksortPoint::dist(self : SorthybridblocksortPoint, other : SorthybridblocksortPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn SorthybridblocksortPoint::add(self : SorthybridblocksortPoint, other : SorthybridblocksortPoint) -> SorthybridblocksortPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn SorthybridblocksortPoint::sub(self : SorthybridblocksortPoint, other : SorthybridblocksortPoint) -> SorthybridblocksortPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn SorthybridblocksortPoint::scale(self : SorthybridblocksortPoint, s : Double) -> SorthybridblocksortPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn SorthybridblocksortPoint::dot(self : SorthybridblocksortPoint, other : SorthybridblocksortPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn SorthybridblocksortPoint::cross(self : SorthybridblocksortPoint, other : SorthybridblocksortPoint) -> SorthybridblocksortPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn SorthybridblocksortPoint::norm(self : SorthybridblocksortPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn SorthybridblocksortPoint::normalize(self : SorthybridblocksortPoint) -> SorthybridblocksortPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn SorthybridblocksortPoint::negate(self : SorthybridblocksortPoint) -> SorthybridblocksortPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn SorthybridblocksortPoint::mid(self : SorthybridblocksortPoint, other : SorthybridblocksortPoint) -> SorthybridblocksortPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn SorthybridblocksortPoint::lerp(self : SorthybridblocksortPoint, other : SorthybridblocksortPoint, t : Double) -> SorthybridblocksortPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn SorthybridblocksortPoint::to_string(self : SorthybridblocksortPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct SorthybridblocksortSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn sort_hybrid_blocksort_make_series(vals : Array[Double], name : String) -> SorthybridblocksortSeries {
  { vals, name, meta: 0 }
}

pub fn SorthybridblocksortSeries::len(self : SorthybridblocksortSeries) -> Int { self.vals.length() }

pub fn SorthybridblocksortSeries::sum(self : SorthybridblocksortSeries) -> Double { @_common.sum(self.vals) }

pub fn SorthybridblocksortSeries::mean(self : SorthybridblocksortSeries) -> Double { @_common.mean(self.vals) }

pub fn SorthybridblocksortSeries::min(self : SorthybridblocksortSeries) -> Double { @_common.min(self.vals) }

pub fn SorthybridblocksortSeries::max(self : SorthybridblocksortSeries) -> Double { @_common.max(self.vals) }

pub fn SorthybridblocksortSeries::range(self : SorthybridblocksortSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn SorthybridblocksortSeries::variance(self : SorthybridblocksortSeries) -> Double { @_common.variance(self.vals) }

pub fn SorthybridblocksortSeries::std(self : SorthybridblocksortSeries) -> Double { @_common.std(self.vals) }

pub fn SorthybridblocksortSeries::median(self : SorthybridblocksortSeries) -> Double { @_common.median(self.vals) }

pub fn SorthybridblocksortSeries::scale(self : SorthybridblocksortSeries, f : Double) -> SorthybridblocksortSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn SorthybridblocksortSeries::add(self : SorthybridblocksortSeries, other : SorthybridblocksortSeries) -> SorthybridblocksortSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn SorthybridblocksortSeries::sub(self : SorthybridblocksortSeries, other : SorthybridblocksortSeries) -> SorthybridblocksortSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn SorthybridblocksortSeries::normalize(self : SorthybridblocksortSeries) -> SorthybridblocksortSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn SorthybridblocksortSeries::cumsum(self : SorthybridblocksortSeries) -> SorthybridblocksortSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn SorthybridblocksortSeries::to_string(self : SorthybridblocksortSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct SorthybridblocksortMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn sort_hybrid_blocksort_make_matrix(rows : Int, cols : Int, val : Double) -> SorthybridblocksortMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn sort_hybrid_blocksort_matrix_identity(n : Int) -> SorthybridblocksortMatrix {
  let m = sort_hybrid_blocksort_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn SorthybridblocksortMatrix::get(self : SorthybridblocksortMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn SorthybridblocksortMatrix::transpose(self : SorthybridblocksortMatrix) -> SorthybridblocksortMatrix {
  let result = sort_hybrid_blocksort_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn SorthybridblocksortMatrix::add(self : SorthybridblocksortMatrix, other : SorthybridblocksortMatrix) -> SorthybridblocksortMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = sort_hybrid_blocksort_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn SorthybridblocksortMatrix::scale(self : SorthybridblocksortMatrix, s : Double) -> SorthybridblocksortMatrix {
  let result = sort_hybrid_blocksort_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn SorthybridblocksortMatrix::multiply(self : SorthybridblocksortMatrix, other : SorthybridblocksortMatrix) -> SorthybridblocksortMatrix {
  if self.cols != other.rows { return sort_hybrid_blocksort_make_matrix(self.rows, other.cols, 0.0) }
  let result = sort_hybrid_blocksort_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn SorthybridblocksortMatrix::trace(self : SorthybridblocksortMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn SorthybridblocksortMatrix::det(self : SorthybridblocksortMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn SorthybridblocksortMatrix::norm(self : SorthybridblocksortMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn SorthybridblocksortMatrix::to_string(self : SorthybridblocksortMatrix) -> String {
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

pub(all) struct SorthybridblocksortVector {
  comps : Array[Double]
  dim : Int
}

pub fn sort_hybrid_blocksort_make_vector(comps : Array[Double]) -> SorthybridblocksortVector {
  { comps, dim: comps.length() }
}

pub fn sort_hybrid_blocksort_vector_zero(dim : Int) -> SorthybridblocksortVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn SorthybridblocksortVector::add(self : SorthybridblocksortVector, other : SorthybridblocksortVector) -> SorthybridblocksortVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn SorthybridblocksortVector::sub(self : SorthybridblocksortVector, other : SorthybridblocksortVector) -> SorthybridblocksortVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn SorthybridblocksortVector::scale(self : SorthybridblocksortVector, s : Double) -> SorthybridblocksortVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn SorthybridblocksortVector::dot(self : SorthybridblocksortVector, other : SorthybridblocksortVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn SorthybridblocksortVector::norm(self : SorthybridblocksortVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn SorthybridblocksortVector::normalize(self : SorthybridblocksortVector) -> SorthybridblocksortVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn SorthybridblocksortVector::dist(self : SorthybridblocksortVector, other : SorthybridblocksortVector) -> Double {
  self.sub(other).norm()
}

pub fn SorthybridblocksortVector::to_string(self : SorthybridblocksortVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn sort_hybrid_blocksort_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn sort_hybrid_blocksort_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn sort_hybrid_blocksort_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn sort_hybrid_blocksort_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn sort_hybrid_blocksort_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn sort_hybrid_blocksort_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn sort_hybrid_blocksort_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn sort_hybrid_blocksort_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn sort_hybrid_blocksort_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn sort_hybrid_blocksort_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn sort_hybrid_blocksort_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn sort_hybrid_blocksort_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn sort_hybrid_blocksort_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn sort_hybrid_blocksort_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn sort_hybrid_blocksort_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn sort_hybrid_blocksort_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn sort_hybrid_blocksort_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn sort_hybrid_blocksort_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn sort_hybrid_blocksort_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn sort_hybrid_blocksort_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn sort_hybrid_blocksort_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn sort_hybrid_blocksort_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn sort_hybrid_blocksort_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn sort_hybrid_blocksort_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn sort_hybrid_blocksort_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn sort_hybrid_blocksort_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn sort_hybrid_blocksort_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn sort_hybrid_blocksort_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn sort_hybrid_blocksort_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct SorthybridblocksortFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_hybrid_blocksort_frame_make(size : Int) -> SorthybridblocksortFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_hybrid_blocksort_frame_len(s : SorthybridblocksortFrame) -> Int { s.size }

pub fn sort_hybrid_blocksort_frame_get(s : SorthybridblocksortFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_hybrid_blocksort_frame_set(s : SorthybridblocksortFrame, i : Int, v : Double) -> SorthybridblocksortFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_hybrid_blocksort_frame_sum(s : SorthybridblocksortFrame) -> Double { @_common.sum(s.data) }

pub fn sort_hybrid_blocksort_frame_mean(s : SorthybridblocksortFrame) -> Double { @_common.mean(s.data) }

pub fn sort_hybrid_blocksort_frame_scale(s : SorthybridblocksortFrame, f : Double) -> SorthybridblocksortFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_hybrid_blocksort_frame_add(a : SorthybridblocksortFrame, b : SorthybridblocksortFrame) -> SorthybridblocksortFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_hybrid_blocksort_frame_copy(s : SorthybridblocksortFrame) -> SorthybridblocksortFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_hybrid_blocksort_frame_fill(s : SorthybridblocksortFrame, v : Double) -> SorthybridblocksortFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_hybrid_blocksort_frame_min(s : SorthybridblocksortFrame) -> Double { @_common.min(s.data) }

pub fn sort_hybrid_blocksort_frame_max(s : SorthybridblocksortFrame) -> Double { @_common.max(s.data) }

pub fn sort_hybrid_blocksort_frame_to_string(s : SorthybridblocksortFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SorthybridblocksortTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_hybrid_blocksort_table_make(size : Int) -> SorthybridblocksortTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_hybrid_blocksort_table_len(s : SorthybridblocksortTable) -> Int { s.size }

pub fn sort_hybrid_blocksort_table_get(s : SorthybridblocksortTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_hybrid_blocksort_table_set(s : SorthybridblocksortTable, i : Int, v : Double) -> SorthybridblocksortTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_hybrid_blocksort_table_sum(s : SorthybridblocksortTable) -> Double { @_common.sum(s.data) }

pub fn sort_hybrid_blocksort_table_mean(s : SorthybridblocksortTable) -> Double { @_common.mean(s.data) }

pub fn sort_hybrid_blocksort_table_scale(s : SorthybridblocksortTable, f : Double) -> SorthybridblocksortTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_hybrid_blocksort_table_add(a : SorthybridblocksortTable, b : SorthybridblocksortTable) -> SorthybridblocksortTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_hybrid_blocksort_table_copy(s : SorthybridblocksortTable) -> SorthybridblocksortTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_hybrid_blocksort_table_fill(s : SorthybridblocksortTable, v : Double) -> SorthybridblocksortTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_hybrid_blocksort_table_min(s : SorthybridblocksortTable) -> Double { @_common.min(s.data) }

pub fn sort_hybrid_blocksort_table_max(s : SorthybridblocksortTable) -> Double { @_common.max(s.data) }

pub fn sort_hybrid_blocksort_table_to_string(s : SorthybridblocksortTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SorthybridblocksortGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_hybrid_blocksort_graphn_make(size : Int) -> SorthybridblocksortGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_hybrid_blocksort_graphn_len(s : SorthybridblocksortGraphN) -> Int { s.size }

pub fn sort_hybrid_blocksort_graphn_get(s : SorthybridblocksortGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_hybrid_blocksort_graphn_set(s : SorthybridblocksortGraphN, i : Int, v : Double) -> SorthybridblocksortGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_hybrid_blocksort_graphn_sum(s : SorthybridblocksortGraphN) -> Double { @_common.sum(s.data) }

pub fn sort_hybrid_blocksort_graphn_mean(s : SorthybridblocksortGraphN) -> Double { @_common.mean(s.data) }

pub fn sort_hybrid_blocksort_graphn_scale(s : SorthybridblocksortGraphN, f : Double) -> SorthybridblocksortGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_hybrid_blocksort_graphn_add(a : SorthybridblocksortGraphN, b : SorthybridblocksortGraphN) -> SorthybridblocksortGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_hybrid_blocksort_graphn_copy(s : SorthybridblocksortGraphN) -> SorthybridblocksortGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_hybrid_blocksort_graphn_fill(s : SorthybridblocksortGraphN, v : Double) -> SorthybridblocksortGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_hybrid_blocksort_graphn_min(s : SorthybridblocksortGraphN) -> Double { @_common.min(s.data) }

pub fn sort_hybrid_blocksort_graphn_max(s : SorthybridblocksortGraphN) -> Double { @_common.max(s.data) }

pub fn sort_hybrid_blocksort_graphn_to_string(s : SorthybridblocksortGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SorthybridblocksortNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_hybrid_blocksort_node_make(size : Int) -> SorthybridblocksortNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_hybrid_blocksort_node_len(s : SorthybridblocksortNode) -> Int { s.size }

pub fn sort_hybrid_blocksort_node_get(s : SorthybridblocksortNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_hybrid_blocksort_node_set(s : SorthybridblocksortNode, i : Int, v : Double) -> SorthybridblocksortNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_hybrid_blocksort_node_sum(s : SorthybridblocksortNode) -> Double { @_common.sum(s.data) }

pub fn sort_hybrid_blocksort_node_mean(s : SorthybridblocksortNode) -> Double { @_common.mean(s.data) }

pub fn sort_hybrid_blocksort_node_scale(s : SorthybridblocksortNode, f : Double) -> SorthybridblocksortNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_hybrid_blocksort_node_add(a : SorthybridblocksortNode, b : SorthybridblocksortNode) -> SorthybridblocksortNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_hybrid_blocksort_node_copy(s : SorthybridblocksortNode) -> SorthybridblocksortNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_hybrid_blocksort_node_fill(s : SorthybridblocksortNode, v : Double) -> SorthybridblocksortNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_hybrid_blocksort_node_min(s : SorthybridblocksortNode) -> Double { @_common.min(s.data) }

pub fn sort_hybrid_blocksort_node_max(s : SorthybridblocksortNode) -> Double { @_common.max(s.data) }

pub fn sort_hybrid_blocksort_node_to_string(s : SorthybridblocksortNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SorthybridblocksortEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_hybrid_blocksort_edge_make(size : Int) -> SorthybridblocksortEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_hybrid_blocksort_edge_len(s : SorthybridblocksortEdge) -> Int { s.size }

pub fn sort_hybrid_blocksort_edge_get(s : SorthybridblocksortEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_hybrid_blocksort_edge_set(s : SorthybridblocksortEdge, i : Int, v : Double) -> SorthybridblocksortEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_hybrid_blocksort_edge_sum(s : SorthybridblocksortEdge) -> Double { @_common.sum(s.data) }

pub fn sort_hybrid_blocksort_edge_mean(s : SorthybridblocksortEdge) -> Double { @_common.mean(s.data) }

pub fn sort_hybrid_blocksort_edge_scale(s : SorthybridblocksortEdge, f : Double) -> SorthybridblocksortEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_hybrid_blocksort_edge_add(a : SorthybridblocksortEdge, b : SorthybridblocksortEdge) -> SorthybridblocksortEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_hybrid_blocksort_edge_copy(s : SorthybridblocksortEdge) -> SorthybridblocksortEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_hybrid_blocksort_edge_fill(s : SorthybridblocksortEdge, v : Double) -> SorthybridblocksortEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_hybrid_blocksort_edge_min(s : SorthybridblocksortEdge) -> Double { @_common.min(s.data) }

pub fn sort_hybrid_blocksort_edge_max(s : SorthybridblocksortEdge) -> Double { @_common.max(s.data) }

pub fn sort_hybrid_blocksort_edge_to_string(s : SorthybridblocksortEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SorthybridblocksortPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_hybrid_blocksort_path_make(size : Int) -> SorthybridblocksortPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_hybrid_blocksort_path_len(s : SorthybridblocksortPath) -> Int { s.size }

pub fn sort_hybrid_blocksort_path_get(s : SorthybridblocksortPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_hybrid_blocksort_path_set(s : SorthybridblocksortPath, i : Int, v : Double) -> SorthybridblocksortPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_hybrid_blocksort_path_sum(s : SorthybridblocksortPath) -> Double { @_common.sum(s.data) }

pub fn sort_hybrid_blocksort_path_mean(s : SorthybridblocksortPath) -> Double { @_common.mean(s.data) }

pub fn sort_hybrid_blocksort_path_scale(s : SorthybridblocksortPath, f : Double) -> SorthybridblocksortPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_hybrid_blocksort_path_add(a : SorthybridblocksortPath, b : SorthybridblocksortPath) -> SorthybridblocksortPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_hybrid_blocksort_path_copy(s : SorthybridblocksortPath) -> SorthybridblocksortPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_hybrid_blocksort_path_fill(s : SorthybridblocksortPath, v : Double) -> SorthybridblocksortPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_hybrid_blocksort_path_min(s : SorthybridblocksortPath) -> Double { @_common.min(s.data) }

pub fn sort_hybrid_blocksort_path_max(s : SorthybridblocksortPath) -> Double { @_common.max(s.data) }

pub fn sort_hybrid_blocksort_path_to_string(s : SorthybridblocksortPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SorthybridblocksortCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_hybrid_blocksort_cluster_make(size : Int) -> SorthybridblocksortCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_hybrid_blocksort_cluster_len(s : SorthybridblocksortCluster) -> Int { s.size }

pub fn sort_hybrid_blocksort_cluster_get(s : SorthybridblocksortCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_hybrid_blocksort_cluster_set(s : SorthybridblocksortCluster, i : Int, v : Double) -> SorthybridblocksortCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_hybrid_blocksort_cluster_sum(s : SorthybridblocksortCluster) -> Double { @_common.sum(s.data) }

pub fn sort_hybrid_blocksort_cluster_mean(s : SorthybridblocksortCluster) -> Double { @_common.mean(s.data) }

pub fn sort_hybrid_blocksort_cluster_scale(s : SorthybridblocksortCluster, f : Double) -> SorthybridblocksortCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_hybrid_blocksort_cluster_add(a : SorthybridblocksortCluster, b : SorthybridblocksortCluster) -> SorthybridblocksortCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_hybrid_blocksort_cluster_copy(s : SorthybridblocksortCluster) -> SorthybridblocksortCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_hybrid_blocksort_cluster_fill(s : SorthybridblocksortCluster, v : Double) -> SorthybridblocksortCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_hybrid_blocksort_cluster_min(s : SorthybridblocksortCluster) -> Double { @_common.min(s.data) }

pub fn sort_hybrid_blocksort_cluster_max(s : SorthybridblocksortCluster) -> Double { @_common.max(s.data) }

pub fn sort_hybrid_blocksort_cluster_to_string(s : SorthybridblocksortCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SorthybridblocksortModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_hybrid_blocksort_model_make(size : Int) -> SorthybridblocksortModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_hybrid_blocksort_model_len(s : SorthybridblocksortModel) -> Int { s.size }

pub fn sort_hybrid_blocksort_model_get(s : SorthybridblocksortModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_hybrid_blocksort_model_set(s : SorthybridblocksortModel, i : Int, v : Double) -> SorthybridblocksortModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_hybrid_blocksort_model_sum(s : SorthybridblocksortModel) -> Double { @_common.sum(s.data) }

pub fn sort_hybrid_blocksort_model_mean(s : SorthybridblocksortModel) -> Double { @_common.mean(s.data) }

pub fn sort_hybrid_blocksort_model_scale(s : SorthybridblocksortModel, f : Double) -> SorthybridblocksortModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_hybrid_blocksort_model_add(a : SorthybridblocksortModel, b : SorthybridblocksortModel) -> SorthybridblocksortModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_hybrid_blocksort_model_copy(s : SorthybridblocksortModel) -> SorthybridblocksortModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_hybrid_blocksort_model_fill(s : SorthybridblocksortModel, v : Double) -> SorthybridblocksortModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_hybrid_blocksort_model_min(s : SorthybridblocksortModel) -> Double { @_common.min(s.data) }

pub fn sort_hybrid_blocksort_model_max(s : SorthybridblocksortModel) -> Double { @_common.max(s.data) }

pub fn sort_hybrid_blocksort_model_to_string(s : SorthybridblocksortModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SorthybridblocksortLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_hybrid_blocksort_layer_make(size : Int) -> SorthybridblocksortLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_hybrid_blocksort_layer_len(s : SorthybridblocksortLayer) -> Int { s.size }

pub fn sort_hybrid_blocksort_layer_get(s : SorthybridblocksortLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_hybrid_blocksort_layer_set(s : SorthybridblocksortLayer, i : Int, v : Double) -> SorthybridblocksortLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_hybrid_blocksort_layer_sum(s : SorthybridblocksortLayer) -> Double { @_common.sum(s.data) }

pub fn sort_hybrid_blocksort_layer_mean(s : SorthybridblocksortLayer) -> Double { @_common.mean(s.data) }

pub fn sort_hybrid_blocksort_layer_scale(s : SorthybridblocksortLayer, f : Double) -> SorthybridblocksortLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_hybrid_blocksort_layer_add(a : SorthybridblocksortLayer, b : SorthybridblocksortLayer) -> SorthybridblocksortLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_hybrid_blocksort_layer_copy(s : SorthybridblocksortLayer) -> SorthybridblocksortLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_hybrid_blocksort_layer_fill(s : SorthybridblocksortLayer, v : Double) -> SorthybridblocksortLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_hybrid_blocksort_layer_min(s : SorthybridblocksortLayer) -> Double { @_common.min(s.data) }

pub fn sort_hybrid_blocksort_layer_max(s : SorthybridblocksortLayer) -> Double { @_common.max(s.data) }

pub fn sort_hybrid_blocksort_layer_to_string(s : SorthybridblocksortLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SorthybridblocksortBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_hybrid_blocksort_buffer_make(size : Int) -> SorthybridblocksortBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_hybrid_blocksort_buffer_len(s : SorthybridblocksortBuffer) -> Int { s.size }

pub fn sort_hybrid_blocksort_buffer_get(s : SorthybridblocksortBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_hybrid_blocksort_buffer_set(s : SorthybridblocksortBuffer, i : Int, v : Double) -> SorthybridblocksortBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_hybrid_blocksort_buffer_sum(s : SorthybridblocksortBuffer) -> Double { @_common.sum(s.data) }

pub fn sort_hybrid_blocksort_buffer_mean(s : SorthybridblocksortBuffer) -> Double { @_common.mean(s.data) }

pub fn sort_hybrid_blocksort_buffer_scale(s : SorthybridblocksortBuffer, f : Double) -> SorthybridblocksortBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_hybrid_blocksort_buffer_add(a : SorthybridblocksortBuffer, b : SorthybridblocksortBuffer) -> SorthybridblocksortBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_hybrid_blocksort_buffer_copy(s : SorthybridblocksortBuffer) -> SorthybridblocksortBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_hybrid_blocksort_buffer_fill(s : SorthybridblocksortBuffer, v : Double) -> SorthybridblocksortBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_hybrid_blocksort_buffer_min(s : SorthybridblocksortBuffer) -> Double { @_common.min(s.data) }

pub fn sort_hybrid_blocksort_buffer_max(s : SorthybridblocksortBuffer) -> Double { @_common.max(s.data) }

pub fn sort_hybrid_blocksort_buffer_to_string(s : SorthybridblocksortBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SorthybridblocksortCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_hybrid_blocksort_cursor_make(size : Int) -> SorthybridblocksortCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_hybrid_blocksort_cursor_len(s : SorthybridblocksortCursor) -> Int { s.size }

pub fn sort_hybrid_blocksort_cursor_get(s : SorthybridblocksortCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_hybrid_blocksort_cursor_set(s : SorthybridblocksortCursor, i : Int, v : Double) -> SorthybridblocksortCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_hybrid_blocksort_cursor_sum(s : SorthybridblocksortCursor) -> Double { @_common.sum(s.data) }

pub fn sort_hybrid_blocksort_cursor_mean(s : SorthybridblocksortCursor) -> Double { @_common.mean(s.data) }

pub fn sort_hybrid_blocksort_cursor_scale(s : SorthybridblocksortCursor, f : Double) -> SorthybridblocksortCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_hybrid_blocksort_cursor_add(a : SorthybridblocksortCursor, b : SorthybridblocksortCursor) -> SorthybridblocksortCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_hybrid_blocksort_cursor_copy(s : SorthybridblocksortCursor) -> SorthybridblocksortCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_hybrid_blocksort_cursor_fill(s : SorthybridblocksortCursor, v : Double) -> SorthybridblocksortCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_hybrid_blocksort_cursor_min(s : SorthybridblocksortCursor) -> Double { @_common.min(s.data) }

pub fn sort_hybrid_blocksort_cursor_max(s : SorthybridblocksortCursor) -> Double { @_common.max(s.data) }

pub fn sort_hybrid_blocksort_cursor_to_string(s : SorthybridblocksortCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SorthybridblocksortView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_hybrid_blocksort_view_make(size : Int) -> SorthybridblocksortView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_hybrid_blocksort_view_len(s : SorthybridblocksortView) -> Int { s.size }

pub fn sort_hybrid_blocksort_view_get(s : SorthybridblocksortView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_hybrid_blocksort_view_set(s : SorthybridblocksortView, i : Int, v : Double) -> SorthybridblocksortView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_hybrid_blocksort_view_sum(s : SorthybridblocksortView) -> Double { @_common.sum(s.data) }

pub fn sort_hybrid_blocksort_view_mean(s : SorthybridblocksortView) -> Double { @_common.mean(s.data) }

pub fn sort_hybrid_blocksort_view_scale(s : SorthybridblocksortView, f : Double) -> SorthybridblocksortView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_hybrid_blocksort_view_add(a : SorthybridblocksortView, b : SorthybridblocksortView) -> SorthybridblocksortView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_hybrid_blocksort_view_copy(s : SorthybridblocksortView) -> SorthybridblocksortView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_hybrid_blocksort_view_fill(s : SorthybridblocksortView, v : Double) -> SorthybridblocksortView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_hybrid_blocksort_view_min(s : SorthybridblocksortView) -> Double { @_common.min(s.data) }

pub fn sort_hybrid_blocksort_view_max(s : SorthybridblocksortView) -> Double { @_common.max(s.data) }

pub fn sort_hybrid_blocksort_view_to_string(s : SorthybridblocksortView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SorthybridblocksortRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_hybrid_blocksort_range_make(size : Int) -> SorthybridblocksortRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_hybrid_blocksort_range_len(s : SorthybridblocksortRange) -> Int { s.size }

pub fn sort_hybrid_blocksort_range_get(s : SorthybridblocksortRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_hybrid_blocksort_range_set(s : SorthybridblocksortRange, i : Int, v : Double) -> SorthybridblocksortRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_hybrid_blocksort_range_sum(s : SorthybridblocksortRange) -> Double { @_common.sum(s.data) }

pub fn sort_hybrid_blocksort_range_mean(s : SorthybridblocksortRange) -> Double { @_common.mean(s.data) }

pub fn sort_hybrid_blocksort_range_scale(s : SorthybridblocksortRange, f : Double) -> SorthybridblocksortRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_hybrid_blocksort_range_add(a : SorthybridblocksortRange, b : SorthybridblocksortRange) -> SorthybridblocksortRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_hybrid_blocksort_range_copy(s : SorthybridblocksortRange) -> SorthybridblocksortRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_hybrid_blocksort_range_fill(s : SorthybridblocksortRange, v : Double) -> SorthybridblocksortRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_hybrid_blocksort_range_min(s : SorthybridblocksortRange) -> Double { @_common.min(s.data) }

pub fn sort_hybrid_blocksort_range_max(s : SorthybridblocksortRange) -> Double { @_common.max(s.data) }

pub fn sort_hybrid_blocksort_range_to_string(s : SorthybridblocksortRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SorthybridblocksortSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_hybrid_blocksort_slice_make(size : Int) -> SorthybridblocksortSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_hybrid_blocksort_slice_len(s : SorthybridblocksortSlice) -> Int { s.size }

pub fn sort_hybrid_blocksort_slice_get(s : SorthybridblocksortSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_hybrid_blocksort_slice_set(s : SorthybridblocksortSlice, i : Int, v : Double) -> SorthybridblocksortSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_hybrid_blocksort_slice_sum(s : SorthybridblocksortSlice) -> Double { @_common.sum(s.data) }

pub fn sort_hybrid_blocksort_slice_mean(s : SorthybridblocksortSlice) -> Double { @_common.mean(s.data) }

pub fn sort_hybrid_blocksort_slice_scale(s : SorthybridblocksortSlice, f : Double) -> SorthybridblocksortSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_hybrid_blocksort_slice_add(a : SorthybridblocksortSlice, b : SorthybridblocksortSlice) -> SorthybridblocksortSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_hybrid_blocksort_slice_copy(s : SorthybridblocksortSlice) -> SorthybridblocksortSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_hybrid_blocksort_slice_fill(s : SorthybridblocksortSlice, v : Double) -> SorthybridblocksortSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_hybrid_blocksort_slice_min(s : SorthybridblocksortSlice) -> Double { @_common.min(s.data) }

pub fn sort_hybrid_blocksort_slice_max(s : SorthybridblocksortSlice) -> Double { @_common.max(s.data) }

pub fn sort_hybrid_blocksort_slice_to_string(s : SorthybridblocksortSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

