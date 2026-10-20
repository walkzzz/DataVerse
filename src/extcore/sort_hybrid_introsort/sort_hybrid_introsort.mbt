///===
/// extcore/sort_hybrid_introsort

pub(all) struct SorthybridintrosortPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn sort_hybrid_introsort_make_point(x : Double, y : Double) -> SorthybridintrosortPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn sort_hybrid_introsort_make_point3(x : Double, y : Double, z : Double) -> SorthybridintrosortPoint {
  { x, y, z, label: 0 }
}

pub fn SorthybridintrosortPoint::x(self : SorthybridintrosortPoint) -> Double { self.x }

pub fn SorthybridintrosortPoint::y(self : SorthybridintrosortPoint) -> Double { self.y }

pub fn SorthybridintrosortPoint::z(self : SorthybridintrosortPoint) -> Double { self.z }

pub fn SorthybridintrosortPoint::label(self : SorthybridintrosortPoint) -> Int { self.label }

pub fn SorthybridintrosortPoint::dist(self : SorthybridintrosortPoint, other : SorthybridintrosortPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn SorthybridintrosortPoint::add(self : SorthybridintrosortPoint, other : SorthybridintrosortPoint) -> SorthybridintrosortPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn SorthybridintrosortPoint::sub(self : SorthybridintrosortPoint, other : SorthybridintrosortPoint) -> SorthybridintrosortPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn SorthybridintrosortPoint::scale(self : SorthybridintrosortPoint, s : Double) -> SorthybridintrosortPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn SorthybridintrosortPoint::dot(self : SorthybridintrosortPoint, other : SorthybridintrosortPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn SorthybridintrosortPoint::cross(self : SorthybridintrosortPoint, other : SorthybridintrosortPoint) -> SorthybridintrosortPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn SorthybridintrosortPoint::norm(self : SorthybridintrosortPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn SorthybridintrosortPoint::normalize(self : SorthybridintrosortPoint) -> SorthybridintrosortPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn SorthybridintrosortPoint::negate(self : SorthybridintrosortPoint) -> SorthybridintrosortPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn SorthybridintrosortPoint::mid(self : SorthybridintrosortPoint, other : SorthybridintrosortPoint) -> SorthybridintrosortPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn SorthybridintrosortPoint::lerp(self : SorthybridintrosortPoint, other : SorthybridintrosortPoint, t : Double) -> SorthybridintrosortPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn SorthybridintrosortPoint::to_string(self : SorthybridintrosortPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct SorthybridintrosortSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn sort_hybrid_introsort_make_series(vals : Array[Double], name : String) -> SorthybridintrosortSeries {
  { vals, name, meta: 0 }
}

pub fn SorthybridintrosortSeries::len(self : SorthybridintrosortSeries) -> Int { self.vals.length() }

pub fn SorthybridintrosortSeries::sum(self : SorthybridintrosortSeries) -> Double { @_common.sum(self.vals) }

pub fn SorthybridintrosortSeries::mean(self : SorthybridintrosortSeries) -> Double { @_common.mean(self.vals) }

pub fn SorthybridintrosortSeries::min(self : SorthybridintrosortSeries) -> Double { @_common.min(self.vals) }

pub fn SorthybridintrosortSeries::max(self : SorthybridintrosortSeries) -> Double { @_common.max(self.vals) }

pub fn SorthybridintrosortSeries::range(self : SorthybridintrosortSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn SorthybridintrosortSeries::variance(self : SorthybridintrosortSeries) -> Double { @_common.variance(self.vals) }

pub fn SorthybridintrosortSeries::std(self : SorthybridintrosortSeries) -> Double { @_common.std(self.vals) }

pub fn SorthybridintrosortSeries::median(self : SorthybridintrosortSeries) -> Double { @_common.median(self.vals) }

pub fn SorthybridintrosortSeries::scale(self : SorthybridintrosortSeries, f : Double) -> SorthybridintrosortSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn SorthybridintrosortSeries::add(self : SorthybridintrosortSeries, other : SorthybridintrosortSeries) -> SorthybridintrosortSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn SorthybridintrosortSeries::sub(self : SorthybridintrosortSeries, other : SorthybridintrosortSeries) -> SorthybridintrosortSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn SorthybridintrosortSeries::normalize(self : SorthybridintrosortSeries) -> SorthybridintrosortSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn SorthybridintrosortSeries::cumsum(self : SorthybridintrosortSeries) -> SorthybridintrosortSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn SorthybridintrosortSeries::to_string(self : SorthybridintrosortSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct SorthybridintrosortMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn sort_hybrid_introsort_make_matrix(rows : Int, cols : Int, val : Double) -> SorthybridintrosortMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn sort_hybrid_introsort_matrix_identity(n : Int) -> SorthybridintrosortMatrix {
  let m = sort_hybrid_introsort_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn SorthybridintrosortMatrix::get(self : SorthybridintrosortMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn SorthybridintrosortMatrix::transpose(self : SorthybridintrosortMatrix) -> SorthybridintrosortMatrix {
  let result = sort_hybrid_introsort_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn SorthybridintrosortMatrix::add(self : SorthybridintrosortMatrix, other : SorthybridintrosortMatrix) -> SorthybridintrosortMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = sort_hybrid_introsort_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn SorthybridintrosortMatrix::scale(self : SorthybridintrosortMatrix, s : Double) -> SorthybridintrosortMatrix {
  let result = sort_hybrid_introsort_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn SorthybridintrosortMatrix::multiply(self : SorthybridintrosortMatrix, other : SorthybridintrosortMatrix) -> SorthybridintrosortMatrix {
  if self.cols != other.rows { return sort_hybrid_introsort_make_matrix(self.rows, other.cols, 0.0) }
  let result = sort_hybrid_introsort_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn SorthybridintrosortMatrix::trace(self : SorthybridintrosortMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn SorthybridintrosortMatrix::det(self : SorthybridintrosortMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn SorthybridintrosortMatrix::norm(self : SorthybridintrosortMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn SorthybridintrosortMatrix::to_string(self : SorthybridintrosortMatrix) -> String {
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

pub(all) struct SorthybridintrosortVector {
  comps : Array[Double]
  dim : Int
}

pub fn sort_hybrid_introsort_make_vector(comps : Array[Double]) -> SorthybridintrosortVector {
  { comps, dim: comps.length() }
}

pub fn sort_hybrid_introsort_vector_zero(dim : Int) -> SorthybridintrosortVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn SorthybridintrosortVector::add(self : SorthybridintrosortVector, other : SorthybridintrosortVector) -> SorthybridintrosortVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn SorthybridintrosortVector::sub(self : SorthybridintrosortVector, other : SorthybridintrosortVector) -> SorthybridintrosortVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn SorthybridintrosortVector::scale(self : SorthybridintrosortVector, s : Double) -> SorthybridintrosortVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn SorthybridintrosortVector::dot(self : SorthybridintrosortVector, other : SorthybridintrosortVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn SorthybridintrosortVector::norm(self : SorthybridintrosortVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn SorthybridintrosortVector::normalize(self : SorthybridintrosortVector) -> SorthybridintrosortVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn SorthybridintrosortVector::dist(self : SorthybridintrosortVector, other : SorthybridintrosortVector) -> Double {
  self.sub(other).norm()
}

pub fn SorthybridintrosortVector::to_string(self : SorthybridintrosortVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn sort_hybrid_introsort_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn sort_hybrid_introsort_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn sort_hybrid_introsort_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn sort_hybrid_introsort_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn sort_hybrid_introsort_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn sort_hybrid_introsort_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn sort_hybrid_introsort_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn sort_hybrid_introsort_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn sort_hybrid_introsort_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn sort_hybrid_introsort_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn sort_hybrid_introsort_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn sort_hybrid_introsort_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn sort_hybrid_introsort_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn sort_hybrid_introsort_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn sort_hybrid_introsort_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn sort_hybrid_introsort_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn sort_hybrid_introsort_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn sort_hybrid_introsort_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn sort_hybrid_introsort_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn sort_hybrid_introsort_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn sort_hybrid_introsort_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn sort_hybrid_introsort_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn sort_hybrid_introsort_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn sort_hybrid_introsort_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn sort_hybrid_introsort_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn sort_hybrid_introsort_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn sort_hybrid_introsort_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn sort_hybrid_introsort_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn sort_hybrid_introsort_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct SorthybridintrosortFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_hybrid_introsort_frame_make(size : Int) -> SorthybridintrosortFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_hybrid_introsort_frame_len(s : SorthybridintrosortFrame) -> Int { s.size }

pub fn sort_hybrid_introsort_frame_get(s : SorthybridintrosortFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_hybrid_introsort_frame_set(s : SorthybridintrosortFrame, i : Int, v : Double) -> SorthybridintrosortFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_hybrid_introsort_frame_sum(s : SorthybridintrosortFrame) -> Double { @_common.sum(s.data) }

pub fn sort_hybrid_introsort_frame_mean(s : SorthybridintrosortFrame) -> Double { @_common.mean(s.data) }

pub fn sort_hybrid_introsort_frame_scale(s : SorthybridintrosortFrame, f : Double) -> SorthybridintrosortFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_hybrid_introsort_frame_add(a : SorthybridintrosortFrame, b : SorthybridintrosortFrame) -> SorthybridintrosortFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_hybrid_introsort_frame_copy(s : SorthybridintrosortFrame) -> SorthybridintrosortFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_hybrid_introsort_frame_fill(s : SorthybridintrosortFrame, v : Double) -> SorthybridintrosortFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_hybrid_introsort_frame_min(s : SorthybridintrosortFrame) -> Double { @_common.min(s.data) }

pub fn sort_hybrid_introsort_frame_max(s : SorthybridintrosortFrame) -> Double { @_common.max(s.data) }

pub fn sort_hybrid_introsort_frame_to_string(s : SorthybridintrosortFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SorthybridintrosortTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_hybrid_introsort_table_make(size : Int) -> SorthybridintrosortTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_hybrid_introsort_table_len(s : SorthybridintrosortTable) -> Int { s.size }

pub fn sort_hybrid_introsort_table_get(s : SorthybridintrosortTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_hybrid_introsort_table_set(s : SorthybridintrosortTable, i : Int, v : Double) -> SorthybridintrosortTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_hybrid_introsort_table_sum(s : SorthybridintrosortTable) -> Double { @_common.sum(s.data) }

pub fn sort_hybrid_introsort_table_mean(s : SorthybridintrosortTable) -> Double { @_common.mean(s.data) }

pub fn sort_hybrid_introsort_table_scale(s : SorthybridintrosortTable, f : Double) -> SorthybridintrosortTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_hybrid_introsort_table_add(a : SorthybridintrosortTable, b : SorthybridintrosortTable) -> SorthybridintrosortTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_hybrid_introsort_table_copy(s : SorthybridintrosortTable) -> SorthybridintrosortTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_hybrid_introsort_table_fill(s : SorthybridintrosortTable, v : Double) -> SorthybridintrosortTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_hybrid_introsort_table_min(s : SorthybridintrosortTable) -> Double { @_common.min(s.data) }

pub fn sort_hybrid_introsort_table_max(s : SorthybridintrosortTable) -> Double { @_common.max(s.data) }

pub fn sort_hybrid_introsort_table_to_string(s : SorthybridintrosortTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SorthybridintrosortGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_hybrid_introsort_graphn_make(size : Int) -> SorthybridintrosortGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_hybrid_introsort_graphn_len(s : SorthybridintrosortGraphN) -> Int { s.size }

pub fn sort_hybrid_introsort_graphn_get(s : SorthybridintrosortGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_hybrid_introsort_graphn_set(s : SorthybridintrosortGraphN, i : Int, v : Double) -> SorthybridintrosortGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_hybrid_introsort_graphn_sum(s : SorthybridintrosortGraphN) -> Double { @_common.sum(s.data) }

pub fn sort_hybrid_introsort_graphn_mean(s : SorthybridintrosortGraphN) -> Double { @_common.mean(s.data) }

pub fn sort_hybrid_introsort_graphn_scale(s : SorthybridintrosortGraphN, f : Double) -> SorthybridintrosortGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_hybrid_introsort_graphn_add(a : SorthybridintrosortGraphN, b : SorthybridintrosortGraphN) -> SorthybridintrosortGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_hybrid_introsort_graphn_copy(s : SorthybridintrosortGraphN) -> SorthybridintrosortGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_hybrid_introsort_graphn_fill(s : SorthybridintrosortGraphN, v : Double) -> SorthybridintrosortGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_hybrid_introsort_graphn_min(s : SorthybridintrosortGraphN) -> Double { @_common.min(s.data) }

pub fn sort_hybrid_introsort_graphn_max(s : SorthybridintrosortGraphN) -> Double { @_common.max(s.data) }

pub fn sort_hybrid_introsort_graphn_to_string(s : SorthybridintrosortGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SorthybridintrosortNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_hybrid_introsort_node_make(size : Int) -> SorthybridintrosortNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_hybrid_introsort_node_len(s : SorthybridintrosortNode) -> Int { s.size }

pub fn sort_hybrid_introsort_node_get(s : SorthybridintrosortNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_hybrid_introsort_node_set(s : SorthybridintrosortNode, i : Int, v : Double) -> SorthybridintrosortNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_hybrid_introsort_node_sum(s : SorthybridintrosortNode) -> Double { @_common.sum(s.data) }

pub fn sort_hybrid_introsort_node_mean(s : SorthybridintrosortNode) -> Double { @_common.mean(s.data) }

pub fn sort_hybrid_introsort_node_scale(s : SorthybridintrosortNode, f : Double) -> SorthybridintrosortNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_hybrid_introsort_node_add(a : SorthybridintrosortNode, b : SorthybridintrosortNode) -> SorthybridintrosortNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_hybrid_introsort_node_copy(s : SorthybridintrosortNode) -> SorthybridintrosortNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_hybrid_introsort_node_fill(s : SorthybridintrosortNode, v : Double) -> SorthybridintrosortNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_hybrid_introsort_node_min(s : SorthybridintrosortNode) -> Double { @_common.min(s.data) }

pub fn sort_hybrid_introsort_node_max(s : SorthybridintrosortNode) -> Double { @_common.max(s.data) }

pub fn sort_hybrid_introsort_node_to_string(s : SorthybridintrosortNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SorthybridintrosortEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_hybrid_introsort_edge_make(size : Int) -> SorthybridintrosortEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_hybrid_introsort_edge_len(s : SorthybridintrosortEdge) -> Int { s.size }

pub fn sort_hybrid_introsort_edge_get(s : SorthybridintrosortEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_hybrid_introsort_edge_set(s : SorthybridintrosortEdge, i : Int, v : Double) -> SorthybridintrosortEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_hybrid_introsort_edge_sum(s : SorthybridintrosortEdge) -> Double { @_common.sum(s.data) }

pub fn sort_hybrid_introsort_edge_mean(s : SorthybridintrosortEdge) -> Double { @_common.mean(s.data) }

pub fn sort_hybrid_introsort_edge_scale(s : SorthybridintrosortEdge, f : Double) -> SorthybridintrosortEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_hybrid_introsort_edge_add(a : SorthybridintrosortEdge, b : SorthybridintrosortEdge) -> SorthybridintrosortEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_hybrid_introsort_edge_copy(s : SorthybridintrosortEdge) -> SorthybridintrosortEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_hybrid_introsort_edge_fill(s : SorthybridintrosortEdge, v : Double) -> SorthybridintrosortEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_hybrid_introsort_edge_min(s : SorthybridintrosortEdge) -> Double { @_common.min(s.data) }

pub fn sort_hybrid_introsort_edge_max(s : SorthybridintrosortEdge) -> Double { @_common.max(s.data) }

pub fn sort_hybrid_introsort_edge_to_string(s : SorthybridintrosortEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SorthybridintrosortPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_hybrid_introsort_path_make(size : Int) -> SorthybridintrosortPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_hybrid_introsort_path_len(s : SorthybridintrosortPath) -> Int { s.size }

pub fn sort_hybrid_introsort_path_get(s : SorthybridintrosortPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_hybrid_introsort_path_set(s : SorthybridintrosortPath, i : Int, v : Double) -> SorthybridintrosortPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_hybrid_introsort_path_sum(s : SorthybridintrosortPath) -> Double { @_common.sum(s.data) }

pub fn sort_hybrid_introsort_path_mean(s : SorthybridintrosortPath) -> Double { @_common.mean(s.data) }

pub fn sort_hybrid_introsort_path_scale(s : SorthybridintrosortPath, f : Double) -> SorthybridintrosortPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_hybrid_introsort_path_add(a : SorthybridintrosortPath, b : SorthybridintrosortPath) -> SorthybridintrosortPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_hybrid_introsort_path_copy(s : SorthybridintrosortPath) -> SorthybridintrosortPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_hybrid_introsort_path_fill(s : SorthybridintrosortPath, v : Double) -> SorthybridintrosortPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_hybrid_introsort_path_min(s : SorthybridintrosortPath) -> Double { @_common.min(s.data) }

pub fn sort_hybrid_introsort_path_max(s : SorthybridintrosortPath) -> Double { @_common.max(s.data) }

pub fn sort_hybrid_introsort_path_to_string(s : SorthybridintrosortPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SorthybridintrosortCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_hybrid_introsort_cluster_make(size : Int) -> SorthybridintrosortCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_hybrid_introsort_cluster_len(s : SorthybridintrosortCluster) -> Int { s.size }

pub fn sort_hybrid_introsort_cluster_get(s : SorthybridintrosortCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_hybrid_introsort_cluster_set(s : SorthybridintrosortCluster, i : Int, v : Double) -> SorthybridintrosortCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_hybrid_introsort_cluster_sum(s : SorthybridintrosortCluster) -> Double { @_common.sum(s.data) }

pub fn sort_hybrid_introsort_cluster_mean(s : SorthybridintrosortCluster) -> Double { @_common.mean(s.data) }

pub fn sort_hybrid_introsort_cluster_scale(s : SorthybridintrosortCluster, f : Double) -> SorthybridintrosortCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_hybrid_introsort_cluster_add(a : SorthybridintrosortCluster, b : SorthybridintrosortCluster) -> SorthybridintrosortCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_hybrid_introsort_cluster_copy(s : SorthybridintrosortCluster) -> SorthybridintrosortCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_hybrid_introsort_cluster_fill(s : SorthybridintrosortCluster, v : Double) -> SorthybridintrosortCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_hybrid_introsort_cluster_min(s : SorthybridintrosortCluster) -> Double { @_common.min(s.data) }

pub fn sort_hybrid_introsort_cluster_max(s : SorthybridintrosortCluster) -> Double { @_common.max(s.data) }

pub fn sort_hybrid_introsort_cluster_to_string(s : SorthybridintrosortCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SorthybridintrosortModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_hybrid_introsort_model_make(size : Int) -> SorthybridintrosortModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_hybrid_introsort_model_len(s : SorthybridintrosortModel) -> Int { s.size }

pub fn sort_hybrid_introsort_model_get(s : SorthybridintrosortModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_hybrid_introsort_model_set(s : SorthybridintrosortModel, i : Int, v : Double) -> SorthybridintrosortModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_hybrid_introsort_model_sum(s : SorthybridintrosortModel) -> Double { @_common.sum(s.data) }

pub fn sort_hybrid_introsort_model_mean(s : SorthybridintrosortModel) -> Double { @_common.mean(s.data) }

pub fn sort_hybrid_introsort_model_scale(s : SorthybridintrosortModel, f : Double) -> SorthybridintrosortModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_hybrid_introsort_model_add(a : SorthybridintrosortModel, b : SorthybridintrosortModel) -> SorthybridintrosortModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_hybrid_introsort_model_copy(s : SorthybridintrosortModel) -> SorthybridintrosortModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_hybrid_introsort_model_fill(s : SorthybridintrosortModel, v : Double) -> SorthybridintrosortModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_hybrid_introsort_model_min(s : SorthybridintrosortModel) -> Double { @_common.min(s.data) }

pub fn sort_hybrid_introsort_model_max(s : SorthybridintrosortModel) -> Double { @_common.max(s.data) }

pub fn sort_hybrid_introsort_model_to_string(s : SorthybridintrosortModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SorthybridintrosortLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_hybrid_introsort_layer_make(size : Int) -> SorthybridintrosortLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_hybrid_introsort_layer_len(s : SorthybridintrosortLayer) -> Int { s.size }

pub fn sort_hybrid_introsort_layer_get(s : SorthybridintrosortLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_hybrid_introsort_layer_set(s : SorthybridintrosortLayer, i : Int, v : Double) -> SorthybridintrosortLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_hybrid_introsort_layer_sum(s : SorthybridintrosortLayer) -> Double { @_common.sum(s.data) }

pub fn sort_hybrid_introsort_layer_mean(s : SorthybridintrosortLayer) -> Double { @_common.mean(s.data) }

pub fn sort_hybrid_introsort_layer_scale(s : SorthybridintrosortLayer, f : Double) -> SorthybridintrosortLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_hybrid_introsort_layer_add(a : SorthybridintrosortLayer, b : SorthybridintrosortLayer) -> SorthybridintrosortLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_hybrid_introsort_layer_copy(s : SorthybridintrosortLayer) -> SorthybridintrosortLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_hybrid_introsort_layer_fill(s : SorthybridintrosortLayer, v : Double) -> SorthybridintrosortLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_hybrid_introsort_layer_min(s : SorthybridintrosortLayer) -> Double { @_common.min(s.data) }

pub fn sort_hybrid_introsort_layer_max(s : SorthybridintrosortLayer) -> Double { @_common.max(s.data) }

pub fn sort_hybrid_introsort_layer_to_string(s : SorthybridintrosortLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SorthybridintrosortBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_hybrid_introsort_buffer_make(size : Int) -> SorthybridintrosortBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_hybrid_introsort_buffer_len(s : SorthybridintrosortBuffer) -> Int { s.size }

pub fn sort_hybrid_introsort_buffer_get(s : SorthybridintrosortBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_hybrid_introsort_buffer_set(s : SorthybridintrosortBuffer, i : Int, v : Double) -> SorthybridintrosortBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_hybrid_introsort_buffer_sum(s : SorthybridintrosortBuffer) -> Double { @_common.sum(s.data) }

pub fn sort_hybrid_introsort_buffer_mean(s : SorthybridintrosortBuffer) -> Double { @_common.mean(s.data) }

pub fn sort_hybrid_introsort_buffer_scale(s : SorthybridintrosortBuffer, f : Double) -> SorthybridintrosortBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_hybrid_introsort_buffer_add(a : SorthybridintrosortBuffer, b : SorthybridintrosortBuffer) -> SorthybridintrosortBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_hybrid_introsort_buffer_copy(s : SorthybridintrosortBuffer) -> SorthybridintrosortBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_hybrid_introsort_buffer_fill(s : SorthybridintrosortBuffer, v : Double) -> SorthybridintrosortBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_hybrid_introsort_buffer_min(s : SorthybridintrosortBuffer) -> Double { @_common.min(s.data) }

pub fn sort_hybrid_introsort_buffer_max(s : SorthybridintrosortBuffer) -> Double { @_common.max(s.data) }

pub fn sort_hybrid_introsort_buffer_to_string(s : SorthybridintrosortBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SorthybridintrosortCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_hybrid_introsort_cursor_make(size : Int) -> SorthybridintrosortCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_hybrid_introsort_cursor_len(s : SorthybridintrosortCursor) -> Int { s.size }

pub fn sort_hybrid_introsort_cursor_get(s : SorthybridintrosortCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_hybrid_introsort_cursor_set(s : SorthybridintrosortCursor, i : Int, v : Double) -> SorthybridintrosortCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_hybrid_introsort_cursor_sum(s : SorthybridintrosortCursor) -> Double { @_common.sum(s.data) }

pub fn sort_hybrid_introsort_cursor_mean(s : SorthybridintrosortCursor) -> Double { @_common.mean(s.data) }

pub fn sort_hybrid_introsort_cursor_scale(s : SorthybridintrosortCursor, f : Double) -> SorthybridintrosortCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_hybrid_introsort_cursor_add(a : SorthybridintrosortCursor, b : SorthybridintrosortCursor) -> SorthybridintrosortCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_hybrid_introsort_cursor_copy(s : SorthybridintrosortCursor) -> SorthybridintrosortCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_hybrid_introsort_cursor_fill(s : SorthybridintrosortCursor, v : Double) -> SorthybridintrosortCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_hybrid_introsort_cursor_min(s : SorthybridintrosortCursor) -> Double { @_common.min(s.data) }

pub fn sort_hybrid_introsort_cursor_max(s : SorthybridintrosortCursor) -> Double { @_common.max(s.data) }

pub fn sort_hybrid_introsort_cursor_to_string(s : SorthybridintrosortCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SorthybridintrosortView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_hybrid_introsort_view_make(size : Int) -> SorthybridintrosortView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_hybrid_introsort_view_len(s : SorthybridintrosortView) -> Int { s.size }

pub fn sort_hybrid_introsort_view_get(s : SorthybridintrosortView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_hybrid_introsort_view_set(s : SorthybridintrosortView, i : Int, v : Double) -> SorthybridintrosortView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_hybrid_introsort_view_sum(s : SorthybridintrosortView) -> Double { @_common.sum(s.data) }

pub fn sort_hybrid_introsort_view_mean(s : SorthybridintrosortView) -> Double { @_common.mean(s.data) }

pub fn sort_hybrid_introsort_view_scale(s : SorthybridintrosortView, f : Double) -> SorthybridintrosortView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_hybrid_introsort_view_add(a : SorthybridintrosortView, b : SorthybridintrosortView) -> SorthybridintrosortView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_hybrid_introsort_view_copy(s : SorthybridintrosortView) -> SorthybridintrosortView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_hybrid_introsort_view_fill(s : SorthybridintrosortView, v : Double) -> SorthybridintrosortView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_hybrid_introsort_view_min(s : SorthybridintrosortView) -> Double { @_common.min(s.data) }

pub fn sort_hybrid_introsort_view_max(s : SorthybridintrosortView) -> Double { @_common.max(s.data) }

pub fn sort_hybrid_introsort_view_to_string(s : SorthybridintrosortView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SorthybridintrosortRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_hybrid_introsort_range_make(size : Int) -> SorthybridintrosortRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_hybrid_introsort_range_len(s : SorthybridintrosortRange) -> Int { s.size }

pub fn sort_hybrid_introsort_range_get(s : SorthybridintrosortRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_hybrid_introsort_range_set(s : SorthybridintrosortRange, i : Int, v : Double) -> SorthybridintrosortRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_hybrid_introsort_range_sum(s : SorthybridintrosortRange) -> Double { @_common.sum(s.data) }

pub fn sort_hybrid_introsort_range_mean(s : SorthybridintrosortRange) -> Double { @_common.mean(s.data) }

pub fn sort_hybrid_introsort_range_scale(s : SorthybridintrosortRange, f : Double) -> SorthybridintrosortRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_hybrid_introsort_range_add(a : SorthybridintrosortRange, b : SorthybridintrosortRange) -> SorthybridintrosortRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_hybrid_introsort_range_copy(s : SorthybridintrosortRange) -> SorthybridintrosortRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_hybrid_introsort_range_fill(s : SorthybridintrosortRange, v : Double) -> SorthybridintrosortRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_hybrid_introsort_range_min(s : SorthybridintrosortRange) -> Double { @_common.min(s.data) }

pub fn sort_hybrid_introsort_range_max(s : SorthybridintrosortRange) -> Double { @_common.max(s.data) }

pub fn sort_hybrid_introsort_range_to_string(s : SorthybridintrosortRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SorthybridintrosortSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_hybrid_introsort_slice_make(size : Int) -> SorthybridintrosortSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_hybrid_introsort_slice_len(s : SorthybridintrosortSlice) -> Int { s.size }

pub fn sort_hybrid_introsort_slice_get(s : SorthybridintrosortSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_hybrid_introsort_slice_set(s : SorthybridintrosortSlice, i : Int, v : Double) -> SorthybridintrosortSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_hybrid_introsort_slice_sum(s : SorthybridintrosortSlice) -> Double { @_common.sum(s.data) }

pub fn sort_hybrid_introsort_slice_mean(s : SorthybridintrosortSlice) -> Double { @_common.mean(s.data) }

pub fn sort_hybrid_introsort_slice_scale(s : SorthybridintrosortSlice, f : Double) -> SorthybridintrosortSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_hybrid_introsort_slice_add(a : SorthybridintrosortSlice, b : SorthybridintrosortSlice) -> SorthybridintrosortSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_hybrid_introsort_slice_copy(s : SorthybridintrosortSlice) -> SorthybridintrosortSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_hybrid_introsort_slice_fill(s : SorthybridintrosortSlice, v : Double) -> SorthybridintrosortSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_hybrid_introsort_slice_min(s : SorthybridintrosortSlice) -> Double { @_common.min(s.data) }

pub fn sort_hybrid_introsort_slice_max(s : SorthybridintrosortSlice) -> Double { @_common.max(s.data) }

pub fn sort_hybrid_introsort_slice_to_string(s : SorthybridintrosortSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

