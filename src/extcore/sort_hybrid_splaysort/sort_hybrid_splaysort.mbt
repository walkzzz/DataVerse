///===
/// extcore/sort_hybrid_splaysort

pub(all) struct SorthybridsplaysortPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn sort_hybrid_splaysort_make_point(x : Double, y : Double) -> SorthybridsplaysortPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn sort_hybrid_splaysort_make_point3(x : Double, y : Double, z : Double) -> SorthybridsplaysortPoint {
  { x, y, z, label: 0 }
}

pub fn SorthybridsplaysortPoint::x(self : SorthybridsplaysortPoint) -> Double { self.x }

pub fn SorthybridsplaysortPoint::y(self : SorthybridsplaysortPoint) -> Double { self.y }

pub fn SorthybridsplaysortPoint::z(self : SorthybridsplaysortPoint) -> Double { self.z }

pub fn SorthybridsplaysortPoint::label(self : SorthybridsplaysortPoint) -> Int { self.label }

pub fn SorthybridsplaysortPoint::dist(self : SorthybridsplaysortPoint, other : SorthybridsplaysortPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn SorthybridsplaysortPoint::add(self : SorthybridsplaysortPoint, other : SorthybridsplaysortPoint) -> SorthybridsplaysortPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn SorthybridsplaysortPoint::sub(self : SorthybridsplaysortPoint, other : SorthybridsplaysortPoint) -> SorthybridsplaysortPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn SorthybridsplaysortPoint::scale(self : SorthybridsplaysortPoint, s : Double) -> SorthybridsplaysortPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn SorthybridsplaysortPoint::dot(self : SorthybridsplaysortPoint, other : SorthybridsplaysortPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn SorthybridsplaysortPoint::cross(self : SorthybridsplaysortPoint, other : SorthybridsplaysortPoint) -> SorthybridsplaysortPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn SorthybridsplaysortPoint::norm(self : SorthybridsplaysortPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn SorthybridsplaysortPoint::normalize(self : SorthybridsplaysortPoint) -> SorthybridsplaysortPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn SorthybridsplaysortPoint::negate(self : SorthybridsplaysortPoint) -> SorthybridsplaysortPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn SorthybridsplaysortPoint::mid(self : SorthybridsplaysortPoint, other : SorthybridsplaysortPoint) -> SorthybridsplaysortPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn SorthybridsplaysortPoint::lerp(self : SorthybridsplaysortPoint, other : SorthybridsplaysortPoint, t : Double) -> SorthybridsplaysortPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn SorthybridsplaysortPoint::to_string(self : SorthybridsplaysortPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct SorthybridsplaysortSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn sort_hybrid_splaysort_make_series(vals : Array[Double], name : String) -> SorthybridsplaysortSeries {
  { vals, name, meta: 0 }
}

pub fn SorthybridsplaysortSeries::len(self : SorthybridsplaysortSeries) -> Int { self.vals.length() }

pub fn SorthybridsplaysortSeries::sum(self : SorthybridsplaysortSeries) -> Double { @_common.sum(self.vals) }

pub fn SorthybridsplaysortSeries::mean(self : SorthybridsplaysortSeries) -> Double { @_common.mean(self.vals) }

pub fn SorthybridsplaysortSeries::min(self : SorthybridsplaysortSeries) -> Double { @_common.min(self.vals) }

pub fn SorthybridsplaysortSeries::max(self : SorthybridsplaysortSeries) -> Double { @_common.max(self.vals) }

pub fn SorthybridsplaysortSeries::range(self : SorthybridsplaysortSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn SorthybridsplaysortSeries::variance(self : SorthybridsplaysortSeries) -> Double { @_common.variance(self.vals) }

pub fn SorthybridsplaysortSeries::std(self : SorthybridsplaysortSeries) -> Double { @_common.std(self.vals) }

pub fn SorthybridsplaysortSeries::median(self : SorthybridsplaysortSeries) -> Double { @_common.median(self.vals) }

pub fn SorthybridsplaysortSeries::scale(self : SorthybridsplaysortSeries, f : Double) -> SorthybridsplaysortSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn SorthybridsplaysortSeries::add(self : SorthybridsplaysortSeries, other : SorthybridsplaysortSeries) -> SorthybridsplaysortSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn SorthybridsplaysortSeries::sub(self : SorthybridsplaysortSeries, other : SorthybridsplaysortSeries) -> SorthybridsplaysortSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn SorthybridsplaysortSeries::normalize(self : SorthybridsplaysortSeries) -> SorthybridsplaysortSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn SorthybridsplaysortSeries::cumsum(self : SorthybridsplaysortSeries) -> SorthybridsplaysortSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn SorthybridsplaysortSeries::to_string(self : SorthybridsplaysortSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct SorthybridsplaysortMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn sort_hybrid_splaysort_make_matrix(rows : Int, cols : Int, val : Double) -> SorthybridsplaysortMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn sort_hybrid_splaysort_matrix_identity(n : Int) -> SorthybridsplaysortMatrix {
  let m = sort_hybrid_splaysort_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn SorthybridsplaysortMatrix::get(self : SorthybridsplaysortMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn SorthybridsplaysortMatrix::transpose(self : SorthybridsplaysortMatrix) -> SorthybridsplaysortMatrix {
  let result = sort_hybrid_splaysort_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn SorthybridsplaysortMatrix::add(self : SorthybridsplaysortMatrix, other : SorthybridsplaysortMatrix) -> SorthybridsplaysortMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = sort_hybrid_splaysort_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn SorthybridsplaysortMatrix::scale(self : SorthybridsplaysortMatrix, s : Double) -> SorthybridsplaysortMatrix {
  let result = sort_hybrid_splaysort_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn SorthybridsplaysortMatrix::multiply(self : SorthybridsplaysortMatrix, other : SorthybridsplaysortMatrix) -> SorthybridsplaysortMatrix {
  if self.cols != other.rows { return sort_hybrid_splaysort_make_matrix(self.rows, other.cols, 0.0) }
  let result = sort_hybrid_splaysort_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn SorthybridsplaysortMatrix::trace(self : SorthybridsplaysortMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn SorthybridsplaysortMatrix::det(self : SorthybridsplaysortMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn SorthybridsplaysortMatrix::norm(self : SorthybridsplaysortMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn SorthybridsplaysortMatrix::to_string(self : SorthybridsplaysortMatrix) -> String {
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

pub(all) struct SorthybridsplaysortVector {
  comps : Array[Double]
  dim : Int
}

pub fn sort_hybrid_splaysort_make_vector(comps : Array[Double]) -> SorthybridsplaysortVector {
  { comps, dim: comps.length() }
}

pub fn sort_hybrid_splaysort_vector_zero(dim : Int) -> SorthybridsplaysortVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn SorthybridsplaysortVector::add(self : SorthybridsplaysortVector, other : SorthybridsplaysortVector) -> SorthybridsplaysortVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn SorthybridsplaysortVector::sub(self : SorthybridsplaysortVector, other : SorthybridsplaysortVector) -> SorthybridsplaysortVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn SorthybridsplaysortVector::scale(self : SorthybridsplaysortVector, s : Double) -> SorthybridsplaysortVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn SorthybridsplaysortVector::dot(self : SorthybridsplaysortVector, other : SorthybridsplaysortVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn SorthybridsplaysortVector::norm(self : SorthybridsplaysortVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn SorthybridsplaysortVector::normalize(self : SorthybridsplaysortVector) -> SorthybridsplaysortVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn SorthybridsplaysortVector::dist(self : SorthybridsplaysortVector, other : SorthybridsplaysortVector) -> Double {
  self.sub(other).norm()
}

pub fn SorthybridsplaysortVector::to_string(self : SorthybridsplaysortVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn sort_hybrid_splaysort_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn sort_hybrid_splaysort_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn sort_hybrid_splaysort_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn sort_hybrid_splaysort_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn sort_hybrid_splaysort_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn sort_hybrid_splaysort_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn sort_hybrid_splaysort_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn sort_hybrid_splaysort_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn sort_hybrid_splaysort_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn sort_hybrid_splaysort_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn sort_hybrid_splaysort_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn sort_hybrid_splaysort_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn sort_hybrid_splaysort_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn sort_hybrid_splaysort_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn sort_hybrid_splaysort_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn sort_hybrid_splaysort_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn sort_hybrid_splaysort_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn sort_hybrid_splaysort_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn sort_hybrid_splaysort_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn sort_hybrid_splaysort_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn sort_hybrid_splaysort_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn sort_hybrid_splaysort_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn sort_hybrid_splaysort_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn sort_hybrid_splaysort_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn sort_hybrid_splaysort_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn sort_hybrid_splaysort_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn sort_hybrid_splaysort_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn sort_hybrid_splaysort_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn sort_hybrid_splaysort_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct SorthybridsplaysortFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_hybrid_splaysort_frame_make(size : Int) -> SorthybridsplaysortFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_hybrid_splaysort_frame_len(s : SorthybridsplaysortFrame) -> Int { s.size }

pub fn sort_hybrid_splaysort_frame_get(s : SorthybridsplaysortFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_hybrid_splaysort_frame_set(s : SorthybridsplaysortFrame, i : Int, v : Double) -> SorthybridsplaysortFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_hybrid_splaysort_frame_sum(s : SorthybridsplaysortFrame) -> Double { @_common.sum(s.data) }

pub fn sort_hybrid_splaysort_frame_mean(s : SorthybridsplaysortFrame) -> Double { @_common.mean(s.data) }

pub fn sort_hybrid_splaysort_frame_scale(s : SorthybridsplaysortFrame, f : Double) -> SorthybridsplaysortFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_hybrid_splaysort_frame_add(a : SorthybridsplaysortFrame, b : SorthybridsplaysortFrame) -> SorthybridsplaysortFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_hybrid_splaysort_frame_copy(s : SorthybridsplaysortFrame) -> SorthybridsplaysortFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_hybrid_splaysort_frame_fill(s : SorthybridsplaysortFrame, v : Double) -> SorthybridsplaysortFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_hybrid_splaysort_frame_min(s : SorthybridsplaysortFrame) -> Double { @_common.min(s.data) }

pub fn sort_hybrid_splaysort_frame_max(s : SorthybridsplaysortFrame) -> Double { @_common.max(s.data) }

pub fn sort_hybrid_splaysort_frame_to_string(s : SorthybridsplaysortFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SorthybridsplaysortTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_hybrid_splaysort_table_make(size : Int) -> SorthybridsplaysortTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_hybrid_splaysort_table_len(s : SorthybridsplaysortTable) -> Int { s.size }

pub fn sort_hybrid_splaysort_table_get(s : SorthybridsplaysortTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_hybrid_splaysort_table_set(s : SorthybridsplaysortTable, i : Int, v : Double) -> SorthybridsplaysortTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_hybrid_splaysort_table_sum(s : SorthybridsplaysortTable) -> Double { @_common.sum(s.data) }

pub fn sort_hybrid_splaysort_table_mean(s : SorthybridsplaysortTable) -> Double { @_common.mean(s.data) }

pub fn sort_hybrid_splaysort_table_scale(s : SorthybridsplaysortTable, f : Double) -> SorthybridsplaysortTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_hybrid_splaysort_table_add(a : SorthybridsplaysortTable, b : SorthybridsplaysortTable) -> SorthybridsplaysortTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_hybrid_splaysort_table_copy(s : SorthybridsplaysortTable) -> SorthybridsplaysortTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_hybrid_splaysort_table_fill(s : SorthybridsplaysortTable, v : Double) -> SorthybridsplaysortTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_hybrid_splaysort_table_min(s : SorthybridsplaysortTable) -> Double { @_common.min(s.data) }

pub fn sort_hybrid_splaysort_table_max(s : SorthybridsplaysortTable) -> Double { @_common.max(s.data) }

pub fn sort_hybrid_splaysort_table_to_string(s : SorthybridsplaysortTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SorthybridsplaysortGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_hybrid_splaysort_graphn_make(size : Int) -> SorthybridsplaysortGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_hybrid_splaysort_graphn_len(s : SorthybridsplaysortGraphN) -> Int { s.size }

pub fn sort_hybrid_splaysort_graphn_get(s : SorthybridsplaysortGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_hybrid_splaysort_graphn_set(s : SorthybridsplaysortGraphN, i : Int, v : Double) -> SorthybridsplaysortGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_hybrid_splaysort_graphn_sum(s : SorthybridsplaysortGraphN) -> Double { @_common.sum(s.data) }

pub fn sort_hybrid_splaysort_graphn_mean(s : SorthybridsplaysortGraphN) -> Double { @_common.mean(s.data) }

pub fn sort_hybrid_splaysort_graphn_scale(s : SorthybridsplaysortGraphN, f : Double) -> SorthybridsplaysortGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_hybrid_splaysort_graphn_add(a : SorthybridsplaysortGraphN, b : SorthybridsplaysortGraphN) -> SorthybridsplaysortGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_hybrid_splaysort_graphn_copy(s : SorthybridsplaysortGraphN) -> SorthybridsplaysortGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_hybrid_splaysort_graphn_fill(s : SorthybridsplaysortGraphN, v : Double) -> SorthybridsplaysortGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_hybrid_splaysort_graphn_min(s : SorthybridsplaysortGraphN) -> Double { @_common.min(s.data) }

pub fn sort_hybrid_splaysort_graphn_max(s : SorthybridsplaysortGraphN) -> Double { @_common.max(s.data) }

pub fn sort_hybrid_splaysort_graphn_to_string(s : SorthybridsplaysortGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SorthybridsplaysortNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_hybrid_splaysort_node_make(size : Int) -> SorthybridsplaysortNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_hybrid_splaysort_node_len(s : SorthybridsplaysortNode) -> Int { s.size }

pub fn sort_hybrid_splaysort_node_get(s : SorthybridsplaysortNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_hybrid_splaysort_node_set(s : SorthybridsplaysortNode, i : Int, v : Double) -> SorthybridsplaysortNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_hybrid_splaysort_node_sum(s : SorthybridsplaysortNode) -> Double { @_common.sum(s.data) }

pub fn sort_hybrid_splaysort_node_mean(s : SorthybridsplaysortNode) -> Double { @_common.mean(s.data) }

pub fn sort_hybrid_splaysort_node_scale(s : SorthybridsplaysortNode, f : Double) -> SorthybridsplaysortNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_hybrid_splaysort_node_add(a : SorthybridsplaysortNode, b : SorthybridsplaysortNode) -> SorthybridsplaysortNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_hybrid_splaysort_node_copy(s : SorthybridsplaysortNode) -> SorthybridsplaysortNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_hybrid_splaysort_node_fill(s : SorthybridsplaysortNode, v : Double) -> SorthybridsplaysortNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_hybrid_splaysort_node_min(s : SorthybridsplaysortNode) -> Double { @_common.min(s.data) }

pub fn sort_hybrid_splaysort_node_max(s : SorthybridsplaysortNode) -> Double { @_common.max(s.data) }

pub fn sort_hybrid_splaysort_node_to_string(s : SorthybridsplaysortNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SorthybridsplaysortEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_hybrid_splaysort_edge_make(size : Int) -> SorthybridsplaysortEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_hybrid_splaysort_edge_len(s : SorthybridsplaysortEdge) -> Int { s.size }

pub fn sort_hybrid_splaysort_edge_get(s : SorthybridsplaysortEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_hybrid_splaysort_edge_set(s : SorthybridsplaysortEdge, i : Int, v : Double) -> SorthybridsplaysortEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_hybrid_splaysort_edge_sum(s : SorthybridsplaysortEdge) -> Double { @_common.sum(s.data) }

pub fn sort_hybrid_splaysort_edge_mean(s : SorthybridsplaysortEdge) -> Double { @_common.mean(s.data) }

pub fn sort_hybrid_splaysort_edge_scale(s : SorthybridsplaysortEdge, f : Double) -> SorthybridsplaysortEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_hybrid_splaysort_edge_add(a : SorthybridsplaysortEdge, b : SorthybridsplaysortEdge) -> SorthybridsplaysortEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_hybrid_splaysort_edge_copy(s : SorthybridsplaysortEdge) -> SorthybridsplaysortEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_hybrid_splaysort_edge_fill(s : SorthybridsplaysortEdge, v : Double) -> SorthybridsplaysortEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_hybrid_splaysort_edge_min(s : SorthybridsplaysortEdge) -> Double { @_common.min(s.data) }

pub fn sort_hybrid_splaysort_edge_max(s : SorthybridsplaysortEdge) -> Double { @_common.max(s.data) }

pub fn sort_hybrid_splaysort_edge_to_string(s : SorthybridsplaysortEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SorthybridsplaysortPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_hybrid_splaysort_path_make(size : Int) -> SorthybridsplaysortPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_hybrid_splaysort_path_len(s : SorthybridsplaysortPath) -> Int { s.size }

pub fn sort_hybrid_splaysort_path_get(s : SorthybridsplaysortPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_hybrid_splaysort_path_set(s : SorthybridsplaysortPath, i : Int, v : Double) -> SorthybridsplaysortPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_hybrid_splaysort_path_sum(s : SorthybridsplaysortPath) -> Double { @_common.sum(s.data) }

pub fn sort_hybrid_splaysort_path_mean(s : SorthybridsplaysortPath) -> Double { @_common.mean(s.data) }

pub fn sort_hybrid_splaysort_path_scale(s : SorthybridsplaysortPath, f : Double) -> SorthybridsplaysortPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_hybrid_splaysort_path_add(a : SorthybridsplaysortPath, b : SorthybridsplaysortPath) -> SorthybridsplaysortPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_hybrid_splaysort_path_copy(s : SorthybridsplaysortPath) -> SorthybridsplaysortPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_hybrid_splaysort_path_fill(s : SorthybridsplaysortPath, v : Double) -> SorthybridsplaysortPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_hybrid_splaysort_path_min(s : SorthybridsplaysortPath) -> Double { @_common.min(s.data) }

pub fn sort_hybrid_splaysort_path_max(s : SorthybridsplaysortPath) -> Double { @_common.max(s.data) }

pub fn sort_hybrid_splaysort_path_to_string(s : SorthybridsplaysortPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SorthybridsplaysortCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_hybrid_splaysort_cluster_make(size : Int) -> SorthybridsplaysortCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_hybrid_splaysort_cluster_len(s : SorthybridsplaysortCluster) -> Int { s.size }

pub fn sort_hybrid_splaysort_cluster_get(s : SorthybridsplaysortCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_hybrid_splaysort_cluster_set(s : SorthybridsplaysortCluster, i : Int, v : Double) -> SorthybridsplaysortCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_hybrid_splaysort_cluster_sum(s : SorthybridsplaysortCluster) -> Double { @_common.sum(s.data) }

pub fn sort_hybrid_splaysort_cluster_mean(s : SorthybridsplaysortCluster) -> Double { @_common.mean(s.data) }

pub fn sort_hybrid_splaysort_cluster_scale(s : SorthybridsplaysortCluster, f : Double) -> SorthybridsplaysortCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_hybrid_splaysort_cluster_add(a : SorthybridsplaysortCluster, b : SorthybridsplaysortCluster) -> SorthybridsplaysortCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_hybrid_splaysort_cluster_copy(s : SorthybridsplaysortCluster) -> SorthybridsplaysortCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_hybrid_splaysort_cluster_fill(s : SorthybridsplaysortCluster, v : Double) -> SorthybridsplaysortCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_hybrid_splaysort_cluster_min(s : SorthybridsplaysortCluster) -> Double { @_common.min(s.data) }

pub fn sort_hybrid_splaysort_cluster_max(s : SorthybridsplaysortCluster) -> Double { @_common.max(s.data) }

pub fn sort_hybrid_splaysort_cluster_to_string(s : SorthybridsplaysortCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SorthybridsplaysortModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_hybrid_splaysort_model_make(size : Int) -> SorthybridsplaysortModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_hybrid_splaysort_model_len(s : SorthybridsplaysortModel) -> Int { s.size }

pub fn sort_hybrid_splaysort_model_get(s : SorthybridsplaysortModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_hybrid_splaysort_model_set(s : SorthybridsplaysortModel, i : Int, v : Double) -> SorthybridsplaysortModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_hybrid_splaysort_model_sum(s : SorthybridsplaysortModel) -> Double { @_common.sum(s.data) }

pub fn sort_hybrid_splaysort_model_mean(s : SorthybridsplaysortModel) -> Double { @_common.mean(s.data) }

pub fn sort_hybrid_splaysort_model_scale(s : SorthybridsplaysortModel, f : Double) -> SorthybridsplaysortModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_hybrid_splaysort_model_add(a : SorthybridsplaysortModel, b : SorthybridsplaysortModel) -> SorthybridsplaysortModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_hybrid_splaysort_model_copy(s : SorthybridsplaysortModel) -> SorthybridsplaysortModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_hybrid_splaysort_model_fill(s : SorthybridsplaysortModel, v : Double) -> SorthybridsplaysortModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_hybrid_splaysort_model_min(s : SorthybridsplaysortModel) -> Double { @_common.min(s.data) }

pub fn sort_hybrid_splaysort_model_max(s : SorthybridsplaysortModel) -> Double { @_common.max(s.data) }

pub fn sort_hybrid_splaysort_model_to_string(s : SorthybridsplaysortModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SorthybridsplaysortLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_hybrid_splaysort_layer_make(size : Int) -> SorthybridsplaysortLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_hybrid_splaysort_layer_len(s : SorthybridsplaysortLayer) -> Int { s.size }

pub fn sort_hybrid_splaysort_layer_get(s : SorthybridsplaysortLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_hybrid_splaysort_layer_set(s : SorthybridsplaysortLayer, i : Int, v : Double) -> SorthybridsplaysortLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_hybrid_splaysort_layer_sum(s : SorthybridsplaysortLayer) -> Double { @_common.sum(s.data) }

pub fn sort_hybrid_splaysort_layer_mean(s : SorthybridsplaysortLayer) -> Double { @_common.mean(s.data) }

pub fn sort_hybrid_splaysort_layer_scale(s : SorthybridsplaysortLayer, f : Double) -> SorthybridsplaysortLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_hybrid_splaysort_layer_add(a : SorthybridsplaysortLayer, b : SorthybridsplaysortLayer) -> SorthybridsplaysortLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_hybrid_splaysort_layer_copy(s : SorthybridsplaysortLayer) -> SorthybridsplaysortLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_hybrid_splaysort_layer_fill(s : SorthybridsplaysortLayer, v : Double) -> SorthybridsplaysortLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_hybrid_splaysort_layer_min(s : SorthybridsplaysortLayer) -> Double { @_common.min(s.data) }

pub fn sort_hybrid_splaysort_layer_max(s : SorthybridsplaysortLayer) -> Double { @_common.max(s.data) }

pub fn sort_hybrid_splaysort_layer_to_string(s : SorthybridsplaysortLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SorthybridsplaysortBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_hybrid_splaysort_buffer_make(size : Int) -> SorthybridsplaysortBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_hybrid_splaysort_buffer_len(s : SorthybridsplaysortBuffer) -> Int { s.size }

pub fn sort_hybrid_splaysort_buffer_get(s : SorthybridsplaysortBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_hybrid_splaysort_buffer_set(s : SorthybridsplaysortBuffer, i : Int, v : Double) -> SorthybridsplaysortBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_hybrid_splaysort_buffer_sum(s : SorthybridsplaysortBuffer) -> Double { @_common.sum(s.data) }

pub fn sort_hybrid_splaysort_buffer_mean(s : SorthybridsplaysortBuffer) -> Double { @_common.mean(s.data) }

pub fn sort_hybrid_splaysort_buffer_scale(s : SorthybridsplaysortBuffer, f : Double) -> SorthybridsplaysortBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_hybrid_splaysort_buffer_add(a : SorthybridsplaysortBuffer, b : SorthybridsplaysortBuffer) -> SorthybridsplaysortBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_hybrid_splaysort_buffer_copy(s : SorthybridsplaysortBuffer) -> SorthybridsplaysortBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_hybrid_splaysort_buffer_fill(s : SorthybridsplaysortBuffer, v : Double) -> SorthybridsplaysortBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_hybrid_splaysort_buffer_min(s : SorthybridsplaysortBuffer) -> Double { @_common.min(s.data) }

pub fn sort_hybrid_splaysort_buffer_max(s : SorthybridsplaysortBuffer) -> Double { @_common.max(s.data) }

pub fn sort_hybrid_splaysort_buffer_to_string(s : SorthybridsplaysortBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SorthybridsplaysortCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_hybrid_splaysort_cursor_make(size : Int) -> SorthybridsplaysortCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_hybrid_splaysort_cursor_len(s : SorthybridsplaysortCursor) -> Int { s.size }

pub fn sort_hybrid_splaysort_cursor_get(s : SorthybridsplaysortCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_hybrid_splaysort_cursor_set(s : SorthybridsplaysortCursor, i : Int, v : Double) -> SorthybridsplaysortCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_hybrid_splaysort_cursor_sum(s : SorthybridsplaysortCursor) -> Double { @_common.sum(s.data) }

pub fn sort_hybrid_splaysort_cursor_mean(s : SorthybridsplaysortCursor) -> Double { @_common.mean(s.data) }

pub fn sort_hybrid_splaysort_cursor_scale(s : SorthybridsplaysortCursor, f : Double) -> SorthybridsplaysortCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_hybrid_splaysort_cursor_add(a : SorthybridsplaysortCursor, b : SorthybridsplaysortCursor) -> SorthybridsplaysortCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_hybrid_splaysort_cursor_copy(s : SorthybridsplaysortCursor) -> SorthybridsplaysortCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_hybrid_splaysort_cursor_fill(s : SorthybridsplaysortCursor, v : Double) -> SorthybridsplaysortCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_hybrid_splaysort_cursor_min(s : SorthybridsplaysortCursor) -> Double { @_common.min(s.data) }

pub fn sort_hybrid_splaysort_cursor_max(s : SorthybridsplaysortCursor) -> Double { @_common.max(s.data) }

pub fn sort_hybrid_splaysort_cursor_to_string(s : SorthybridsplaysortCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SorthybridsplaysortView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_hybrid_splaysort_view_make(size : Int) -> SorthybridsplaysortView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_hybrid_splaysort_view_len(s : SorthybridsplaysortView) -> Int { s.size }

pub fn sort_hybrid_splaysort_view_get(s : SorthybridsplaysortView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_hybrid_splaysort_view_set(s : SorthybridsplaysortView, i : Int, v : Double) -> SorthybridsplaysortView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_hybrid_splaysort_view_sum(s : SorthybridsplaysortView) -> Double { @_common.sum(s.data) }

pub fn sort_hybrid_splaysort_view_mean(s : SorthybridsplaysortView) -> Double { @_common.mean(s.data) }

pub fn sort_hybrid_splaysort_view_scale(s : SorthybridsplaysortView, f : Double) -> SorthybridsplaysortView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_hybrid_splaysort_view_add(a : SorthybridsplaysortView, b : SorthybridsplaysortView) -> SorthybridsplaysortView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_hybrid_splaysort_view_copy(s : SorthybridsplaysortView) -> SorthybridsplaysortView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_hybrid_splaysort_view_fill(s : SorthybridsplaysortView, v : Double) -> SorthybridsplaysortView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_hybrid_splaysort_view_min(s : SorthybridsplaysortView) -> Double { @_common.min(s.data) }

pub fn sort_hybrid_splaysort_view_max(s : SorthybridsplaysortView) -> Double { @_common.max(s.data) }

pub fn sort_hybrid_splaysort_view_to_string(s : SorthybridsplaysortView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SorthybridsplaysortRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_hybrid_splaysort_range_make(size : Int) -> SorthybridsplaysortRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_hybrid_splaysort_range_len(s : SorthybridsplaysortRange) -> Int { s.size }

pub fn sort_hybrid_splaysort_range_get(s : SorthybridsplaysortRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_hybrid_splaysort_range_set(s : SorthybridsplaysortRange, i : Int, v : Double) -> SorthybridsplaysortRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_hybrid_splaysort_range_sum(s : SorthybridsplaysortRange) -> Double { @_common.sum(s.data) }

pub fn sort_hybrid_splaysort_range_mean(s : SorthybridsplaysortRange) -> Double { @_common.mean(s.data) }

pub fn sort_hybrid_splaysort_range_scale(s : SorthybridsplaysortRange, f : Double) -> SorthybridsplaysortRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_hybrid_splaysort_range_add(a : SorthybridsplaysortRange, b : SorthybridsplaysortRange) -> SorthybridsplaysortRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_hybrid_splaysort_range_copy(s : SorthybridsplaysortRange) -> SorthybridsplaysortRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_hybrid_splaysort_range_fill(s : SorthybridsplaysortRange, v : Double) -> SorthybridsplaysortRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_hybrid_splaysort_range_min(s : SorthybridsplaysortRange) -> Double { @_common.min(s.data) }

pub fn sort_hybrid_splaysort_range_max(s : SorthybridsplaysortRange) -> Double { @_common.max(s.data) }

pub fn sort_hybrid_splaysort_range_to_string(s : SorthybridsplaysortRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SorthybridsplaysortSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_hybrid_splaysort_slice_make(size : Int) -> SorthybridsplaysortSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_hybrid_splaysort_slice_len(s : SorthybridsplaysortSlice) -> Int { s.size }

pub fn sort_hybrid_splaysort_slice_get(s : SorthybridsplaysortSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_hybrid_splaysort_slice_set(s : SorthybridsplaysortSlice, i : Int, v : Double) -> SorthybridsplaysortSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_hybrid_splaysort_slice_sum(s : SorthybridsplaysortSlice) -> Double { @_common.sum(s.data) }

pub fn sort_hybrid_splaysort_slice_mean(s : SorthybridsplaysortSlice) -> Double { @_common.mean(s.data) }

pub fn sort_hybrid_splaysort_slice_scale(s : SorthybridsplaysortSlice, f : Double) -> SorthybridsplaysortSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_hybrid_splaysort_slice_add(a : SorthybridsplaysortSlice, b : SorthybridsplaysortSlice) -> SorthybridsplaysortSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_hybrid_splaysort_slice_copy(s : SorthybridsplaysortSlice) -> SorthybridsplaysortSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_hybrid_splaysort_slice_fill(s : SorthybridsplaysortSlice, v : Double) -> SorthybridsplaysortSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_hybrid_splaysort_slice_min(s : SorthybridsplaysortSlice) -> Double { @_common.min(s.data) }

pub fn sort_hybrid_splaysort_slice_max(s : SorthybridsplaysortSlice) -> Double { @_common.max(s.data) }

pub fn sort_hybrid_splaysort_slice_to_string(s : SorthybridsplaysortSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

