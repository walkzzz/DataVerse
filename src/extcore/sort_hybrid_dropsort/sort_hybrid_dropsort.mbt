///===
/// extcore/sort_hybrid_dropsort

pub(all) struct SorthybriddropsortPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn sort_hybrid_dropsort_make_point(x : Double, y : Double) -> SorthybriddropsortPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn sort_hybrid_dropsort_make_point3(x : Double, y : Double, z : Double) -> SorthybriddropsortPoint {
  { x, y, z, label: 0 }
}

pub fn SorthybriddropsortPoint::x(self : SorthybriddropsortPoint) -> Double { self.x }

pub fn SorthybriddropsortPoint::y(self : SorthybriddropsortPoint) -> Double { self.y }

pub fn SorthybriddropsortPoint::z(self : SorthybriddropsortPoint) -> Double { self.z }

pub fn SorthybriddropsortPoint::label(self : SorthybriddropsortPoint) -> Int { self.label }

pub fn SorthybriddropsortPoint::dist(self : SorthybriddropsortPoint, other : SorthybriddropsortPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn SorthybriddropsortPoint::add(self : SorthybriddropsortPoint, other : SorthybriddropsortPoint) -> SorthybriddropsortPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn SorthybriddropsortPoint::sub(self : SorthybriddropsortPoint, other : SorthybriddropsortPoint) -> SorthybriddropsortPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn SorthybriddropsortPoint::scale(self : SorthybriddropsortPoint, s : Double) -> SorthybriddropsortPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn SorthybriddropsortPoint::dot(self : SorthybriddropsortPoint, other : SorthybriddropsortPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn SorthybriddropsortPoint::cross(self : SorthybriddropsortPoint, other : SorthybriddropsortPoint) -> SorthybriddropsortPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn SorthybriddropsortPoint::norm(self : SorthybriddropsortPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn SorthybriddropsortPoint::normalize(self : SorthybriddropsortPoint) -> SorthybriddropsortPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn SorthybriddropsortPoint::negate(self : SorthybriddropsortPoint) -> SorthybriddropsortPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn SorthybriddropsortPoint::mid(self : SorthybriddropsortPoint, other : SorthybriddropsortPoint) -> SorthybriddropsortPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn SorthybriddropsortPoint::lerp(self : SorthybriddropsortPoint, other : SorthybriddropsortPoint, t : Double) -> SorthybriddropsortPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn SorthybriddropsortPoint::to_string(self : SorthybriddropsortPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct SorthybriddropsortSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn sort_hybrid_dropsort_make_series(vals : Array[Double], name : String) -> SorthybriddropsortSeries {
  { vals, name, meta: 0 }
}

pub fn SorthybriddropsortSeries::len(self : SorthybriddropsortSeries) -> Int { self.vals.length() }

pub fn SorthybriddropsortSeries::sum(self : SorthybriddropsortSeries) -> Double { @_common.sum(self.vals) }

pub fn SorthybriddropsortSeries::mean(self : SorthybriddropsortSeries) -> Double { @_common.mean(self.vals) }

pub fn SorthybriddropsortSeries::min(self : SorthybriddropsortSeries) -> Double { @_common.min(self.vals) }

pub fn SorthybriddropsortSeries::max(self : SorthybriddropsortSeries) -> Double { @_common.max(self.vals) }

pub fn SorthybriddropsortSeries::range(self : SorthybriddropsortSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn SorthybriddropsortSeries::variance(self : SorthybriddropsortSeries) -> Double { @_common.variance(self.vals) }

pub fn SorthybriddropsortSeries::std(self : SorthybriddropsortSeries) -> Double { @_common.std(self.vals) }

pub fn SorthybriddropsortSeries::median(self : SorthybriddropsortSeries) -> Double { @_common.median(self.vals) }

pub fn SorthybriddropsortSeries::scale(self : SorthybriddropsortSeries, f : Double) -> SorthybriddropsortSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn SorthybriddropsortSeries::add(self : SorthybriddropsortSeries, other : SorthybriddropsortSeries) -> SorthybriddropsortSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn SorthybriddropsortSeries::sub(self : SorthybriddropsortSeries, other : SorthybriddropsortSeries) -> SorthybriddropsortSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn SorthybriddropsortSeries::normalize(self : SorthybriddropsortSeries) -> SorthybriddropsortSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn SorthybriddropsortSeries::cumsum(self : SorthybriddropsortSeries) -> SorthybriddropsortSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn SorthybriddropsortSeries::to_string(self : SorthybriddropsortSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct SorthybriddropsortMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn sort_hybrid_dropsort_make_matrix(rows : Int, cols : Int, val : Double) -> SorthybriddropsortMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn sort_hybrid_dropsort_matrix_identity(n : Int) -> SorthybriddropsortMatrix {
  let m = sort_hybrid_dropsort_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn SorthybriddropsortMatrix::get(self : SorthybriddropsortMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn SorthybriddropsortMatrix::transpose(self : SorthybriddropsortMatrix) -> SorthybriddropsortMatrix {
  let result = sort_hybrid_dropsort_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn SorthybriddropsortMatrix::add(self : SorthybriddropsortMatrix, other : SorthybriddropsortMatrix) -> SorthybriddropsortMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = sort_hybrid_dropsort_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn SorthybriddropsortMatrix::scale(self : SorthybriddropsortMatrix, s : Double) -> SorthybriddropsortMatrix {
  let result = sort_hybrid_dropsort_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn SorthybriddropsortMatrix::multiply(self : SorthybriddropsortMatrix, other : SorthybriddropsortMatrix) -> SorthybriddropsortMatrix {
  if self.cols != other.rows { return sort_hybrid_dropsort_make_matrix(self.rows, other.cols, 0.0) }
  let result = sort_hybrid_dropsort_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn SorthybriddropsortMatrix::trace(self : SorthybriddropsortMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn SorthybriddropsortMatrix::det(self : SorthybriddropsortMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn SorthybriddropsortMatrix::norm(self : SorthybriddropsortMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn SorthybriddropsortMatrix::to_string(self : SorthybriddropsortMatrix) -> String {
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

pub(all) struct SorthybriddropsortVector {
  comps : Array[Double]
  dim : Int
}

pub fn sort_hybrid_dropsort_make_vector(comps : Array[Double]) -> SorthybriddropsortVector {
  { comps, dim: comps.length() }
}

pub fn sort_hybrid_dropsort_vector_zero(dim : Int) -> SorthybriddropsortVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn SorthybriddropsortVector::add(self : SorthybriddropsortVector, other : SorthybriddropsortVector) -> SorthybriddropsortVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn SorthybriddropsortVector::sub(self : SorthybriddropsortVector, other : SorthybriddropsortVector) -> SorthybriddropsortVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn SorthybriddropsortVector::scale(self : SorthybriddropsortVector, s : Double) -> SorthybriddropsortVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn SorthybriddropsortVector::dot(self : SorthybriddropsortVector, other : SorthybriddropsortVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn SorthybriddropsortVector::norm(self : SorthybriddropsortVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn SorthybriddropsortVector::normalize(self : SorthybriddropsortVector) -> SorthybriddropsortVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn SorthybriddropsortVector::dist(self : SorthybriddropsortVector, other : SorthybriddropsortVector) -> Double {
  self.sub(other).norm()
}

pub fn SorthybriddropsortVector::to_string(self : SorthybriddropsortVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn sort_hybrid_dropsort_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn sort_hybrid_dropsort_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn sort_hybrid_dropsort_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn sort_hybrid_dropsort_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn sort_hybrid_dropsort_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn sort_hybrid_dropsort_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn sort_hybrid_dropsort_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn sort_hybrid_dropsort_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn sort_hybrid_dropsort_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn sort_hybrid_dropsort_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn sort_hybrid_dropsort_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn sort_hybrid_dropsort_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn sort_hybrid_dropsort_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn sort_hybrid_dropsort_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn sort_hybrid_dropsort_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn sort_hybrid_dropsort_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn sort_hybrid_dropsort_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn sort_hybrid_dropsort_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn sort_hybrid_dropsort_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn sort_hybrid_dropsort_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn sort_hybrid_dropsort_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn sort_hybrid_dropsort_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn sort_hybrid_dropsort_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn sort_hybrid_dropsort_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn sort_hybrid_dropsort_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn sort_hybrid_dropsort_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn sort_hybrid_dropsort_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn sort_hybrid_dropsort_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn sort_hybrid_dropsort_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct SorthybriddropsortFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_hybrid_dropsort_frame_make(size : Int) -> SorthybriddropsortFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_hybrid_dropsort_frame_len(s : SorthybriddropsortFrame) -> Int { s.size }

pub fn sort_hybrid_dropsort_frame_get(s : SorthybriddropsortFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_hybrid_dropsort_frame_set(s : SorthybriddropsortFrame, i : Int, v : Double) -> SorthybriddropsortFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_hybrid_dropsort_frame_sum(s : SorthybriddropsortFrame) -> Double { @_common.sum(s.data) }

pub fn sort_hybrid_dropsort_frame_mean(s : SorthybriddropsortFrame) -> Double { @_common.mean(s.data) }

pub fn sort_hybrid_dropsort_frame_scale(s : SorthybriddropsortFrame, f : Double) -> SorthybriddropsortFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_hybrid_dropsort_frame_add(a : SorthybriddropsortFrame, b : SorthybriddropsortFrame) -> SorthybriddropsortFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_hybrid_dropsort_frame_copy(s : SorthybriddropsortFrame) -> SorthybriddropsortFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_hybrid_dropsort_frame_fill(s : SorthybriddropsortFrame, v : Double) -> SorthybriddropsortFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_hybrid_dropsort_frame_min(s : SorthybriddropsortFrame) -> Double { @_common.min(s.data) }

pub fn sort_hybrid_dropsort_frame_max(s : SorthybriddropsortFrame) -> Double { @_common.max(s.data) }

pub fn sort_hybrid_dropsort_frame_to_string(s : SorthybriddropsortFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SorthybriddropsortTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_hybrid_dropsort_table_make(size : Int) -> SorthybriddropsortTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_hybrid_dropsort_table_len(s : SorthybriddropsortTable) -> Int { s.size }

pub fn sort_hybrid_dropsort_table_get(s : SorthybriddropsortTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_hybrid_dropsort_table_set(s : SorthybriddropsortTable, i : Int, v : Double) -> SorthybriddropsortTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_hybrid_dropsort_table_sum(s : SorthybriddropsortTable) -> Double { @_common.sum(s.data) }

pub fn sort_hybrid_dropsort_table_mean(s : SorthybriddropsortTable) -> Double { @_common.mean(s.data) }

pub fn sort_hybrid_dropsort_table_scale(s : SorthybriddropsortTable, f : Double) -> SorthybriddropsortTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_hybrid_dropsort_table_add(a : SorthybriddropsortTable, b : SorthybriddropsortTable) -> SorthybriddropsortTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_hybrid_dropsort_table_copy(s : SorthybriddropsortTable) -> SorthybriddropsortTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_hybrid_dropsort_table_fill(s : SorthybriddropsortTable, v : Double) -> SorthybriddropsortTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_hybrid_dropsort_table_min(s : SorthybriddropsortTable) -> Double { @_common.min(s.data) }

pub fn sort_hybrid_dropsort_table_max(s : SorthybriddropsortTable) -> Double { @_common.max(s.data) }

pub fn sort_hybrid_dropsort_table_to_string(s : SorthybriddropsortTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SorthybriddropsortGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_hybrid_dropsort_graphn_make(size : Int) -> SorthybriddropsortGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_hybrid_dropsort_graphn_len(s : SorthybriddropsortGraphN) -> Int { s.size }

pub fn sort_hybrid_dropsort_graphn_get(s : SorthybriddropsortGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_hybrid_dropsort_graphn_set(s : SorthybriddropsortGraphN, i : Int, v : Double) -> SorthybriddropsortGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_hybrid_dropsort_graphn_sum(s : SorthybriddropsortGraphN) -> Double { @_common.sum(s.data) }

pub fn sort_hybrid_dropsort_graphn_mean(s : SorthybriddropsortGraphN) -> Double { @_common.mean(s.data) }

pub fn sort_hybrid_dropsort_graphn_scale(s : SorthybriddropsortGraphN, f : Double) -> SorthybriddropsortGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_hybrid_dropsort_graphn_add(a : SorthybriddropsortGraphN, b : SorthybriddropsortGraphN) -> SorthybriddropsortGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_hybrid_dropsort_graphn_copy(s : SorthybriddropsortGraphN) -> SorthybriddropsortGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_hybrid_dropsort_graphn_fill(s : SorthybriddropsortGraphN, v : Double) -> SorthybriddropsortGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_hybrid_dropsort_graphn_min(s : SorthybriddropsortGraphN) -> Double { @_common.min(s.data) }

pub fn sort_hybrid_dropsort_graphn_max(s : SorthybriddropsortGraphN) -> Double { @_common.max(s.data) }

pub fn sort_hybrid_dropsort_graphn_to_string(s : SorthybriddropsortGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SorthybriddropsortNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_hybrid_dropsort_node_make(size : Int) -> SorthybriddropsortNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_hybrid_dropsort_node_len(s : SorthybriddropsortNode) -> Int { s.size }

pub fn sort_hybrid_dropsort_node_get(s : SorthybriddropsortNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_hybrid_dropsort_node_set(s : SorthybriddropsortNode, i : Int, v : Double) -> SorthybriddropsortNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_hybrid_dropsort_node_sum(s : SorthybriddropsortNode) -> Double { @_common.sum(s.data) }

pub fn sort_hybrid_dropsort_node_mean(s : SorthybriddropsortNode) -> Double { @_common.mean(s.data) }

pub fn sort_hybrid_dropsort_node_scale(s : SorthybriddropsortNode, f : Double) -> SorthybriddropsortNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_hybrid_dropsort_node_add(a : SorthybriddropsortNode, b : SorthybriddropsortNode) -> SorthybriddropsortNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_hybrid_dropsort_node_copy(s : SorthybriddropsortNode) -> SorthybriddropsortNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_hybrid_dropsort_node_fill(s : SorthybriddropsortNode, v : Double) -> SorthybriddropsortNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_hybrid_dropsort_node_min(s : SorthybriddropsortNode) -> Double { @_common.min(s.data) }

pub fn sort_hybrid_dropsort_node_max(s : SorthybriddropsortNode) -> Double { @_common.max(s.data) }

pub fn sort_hybrid_dropsort_node_to_string(s : SorthybriddropsortNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SorthybriddropsortEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_hybrid_dropsort_edge_make(size : Int) -> SorthybriddropsortEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_hybrid_dropsort_edge_len(s : SorthybriddropsortEdge) -> Int { s.size }

pub fn sort_hybrid_dropsort_edge_get(s : SorthybriddropsortEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_hybrid_dropsort_edge_set(s : SorthybriddropsortEdge, i : Int, v : Double) -> SorthybriddropsortEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_hybrid_dropsort_edge_sum(s : SorthybriddropsortEdge) -> Double { @_common.sum(s.data) }

pub fn sort_hybrid_dropsort_edge_mean(s : SorthybriddropsortEdge) -> Double { @_common.mean(s.data) }

pub fn sort_hybrid_dropsort_edge_scale(s : SorthybriddropsortEdge, f : Double) -> SorthybriddropsortEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_hybrid_dropsort_edge_add(a : SorthybriddropsortEdge, b : SorthybriddropsortEdge) -> SorthybriddropsortEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_hybrid_dropsort_edge_copy(s : SorthybriddropsortEdge) -> SorthybriddropsortEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_hybrid_dropsort_edge_fill(s : SorthybriddropsortEdge, v : Double) -> SorthybriddropsortEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_hybrid_dropsort_edge_min(s : SorthybriddropsortEdge) -> Double { @_common.min(s.data) }

pub fn sort_hybrid_dropsort_edge_max(s : SorthybriddropsortEdge) -> Double { @_common.max(s.data) }

pub fn sort_hybrid_dropsort_edge_to_string(s : SorthybriddropsortEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SorthybriddropsortPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_hybrid_dropsort_path_make(size : Int) -> SorthybriddropsortPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_hybrid_dropsort_path_len(s : SorthybriddropsortPath) -> Int { s.size }

pub fn sort_hybrid_dropsort_path_get(s : SorthybriddropsortPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_hybrid_dropsort_path_set(s : SorthybriddropsortPath, i : Int, v : Double) -> SorthybriddropsortPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_hybrid_dropsort_path_sum(s : SorthybriddropsortPath) -> Double { @_common.sum(s.data) }

pub fn sort_hybrid_dropsort_path_mean(s : SorthybriddropsortPath) -> Double { @_common.mean(s.data) }

pub fn sort_hybrid_dropsort_path_scale(s : SorthybriddropsortPath, f : Double) -> SorthybriddropsortPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_hybrid_dropsort_path_add(a : SorthybriddropsortPath, b : SorthybriddropsortPath) -> SorthybriddropsortPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_hybrid_dropsort_path_copy(s : SorthybriddropsortPath) -> SorthybriddropsortPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_hybrid_dropsort_path_fill(s : SorthybriddropsortPath, v : Double) -> SorthybriddropsortPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_hybrid_dropsort_path_min(s : SorthybriddropsortPath) -> Double { @_common.min(s.data) }

pub fn sort_hybrid_dropsort_path_max(s : SorthybriddropsortPath) -> Double { @_common.max(s.data) }

pub fn sort_hybrid_dropsort_path_to_string(s : SorthybriddropsortPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SorthybriddropsortCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_hybrid_dropsort_cluster_make(size : Int) -> SorthybriddropsortCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_hybrid_dropsort_cluster_len(s : SorthybriddropsortCluster) -> Int { s.size }

pub fn sort_hybrid_dropsort_cluster_get(s : SorthybriddropsortCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_hybrid_dropsort_cluster_set(s : SorthybriddropsortCluster, i : Int, v : Double) -> SorthybriddropsortCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_hybrid_dropsort_cluster_sum(s : SorthybriddropsortCluster) -> Double { @_common.sum(s.data) }

pub fn sort_hybrid_dropsort_cluster_mean(s : SorthybriddropsortCluster) -> Double { @_common.mean(s.data) }

pub fn sort_hybrid_dropsort_cluster_scale(s : SorthybriddropsortCluster, f : Double) -> SorthybriddropsortCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_hybrid_dropsort_cluster_add(a : SorthybriddropsortCluster, b : SorthybriddropsortCluster) -> SorthybriddropsortCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_hybrid_dropsort_cluster_copy(s : SorthybriddropsortCluster) -> SorthybriddropsortCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_hybrid_dropsort_cluster_fill(s : SorthybriddropsortCluster, v : Double) -> SorthybriddropsortCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_hybrid_dropsort_cluster_min(s : SorthybriddropsortCluster) -> Double { @_common.min(s.data) }

pub fn sort_hybrid_dropsort_cluster_max(s : SorthybriddropsortCluster) -> Double { @_common.max(s.data) }

pub fn sort_hybrid_dropsort_cluster_to_string(s : SorthybriddropsortCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SorthybriddropsortModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_hybrid_dropsort_model_make(size : Int) -> SorthybriddropsortModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_hybrid_dropsort_model_len(s : SorthybriddropsortModel) -> Int { s.size }

pub fn sort_hybrid_dropsort_model_get(s : SorthybriddropsortModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_hybrid_dropsort_model_set(s : SorthybriddropsortModel, i : Int, v : Double) -> SorthybriddropsortModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_hybrid_dropsort_model_sum(s : SorthybriddropsortModel) -> Double { @_common.sum(s.data) }

pub fn sort_hybrid_dropsort_model_mean(s : SorthybriddropsortModel) -> Double { @_common.mean(s.data) }

pub fn sort_hybrid_dropsort_model_scale(s : SorthybriddropsortModel, f : Double) -> SorthybriddropsortModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_hybrid_dropsort_model_add(a : SorthybriddropsortModel, b : SorthybriddropsortModel) -> SorthybriddropsortModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_hybrid_dropsort_model_copy(s : SorthybriddropsortModel) -> SorthybriddropsortModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_hybrid_dropsort_model_fill(s : SorthybriddropsortModel, v : Double) -> SorthybriddropsortModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_hybrid_dropsort_model_min(s : SorthybriddropsortModel) -> Double { @_common.min(s.data) }

pub fn sort_hybrid_dropsort_model_max(s : SorthybriddropsortModel) -> Double { @_common.max(s.data) }

pub fn sort_hybrid_dropsort_model_to_string(s : SorthybriddropsortModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SorthybriddropsortLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_hybrid_dropsort_layer_make(size : Int) -> SorthybriddropsortLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_hybrid_dropsort_layer_len(s : SorthybriddropsortLayer) -> Int { s.size }

pub fn sort_hybrid_dropsort_layer_get(s : SorthybriddropsortLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_hybrid_dropsort_layer_set(s : SorthybriddropsortLayer, i : Int, v : Double) -> SorthybriddropsortLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_hybrid_dropsort_layer_sum(s : SorthybriddropsortLayer) -> Double { @_common.sum(s.data) }

pub fn sort_hybrid_dropsort_layer_mean(s : SorthybriddropsortLayer) -> Double { @_common.mean(s.data) }

pub fn sort_hybrid_dropsort_layer_scale(s : SorthybriddropsortLayer, f : Double) -> SorthybriddropsortLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_hybrid_dropsort_layer_add(a : SorthybriddropsortLayer, b : SorthybriddropsortLayer) -> SorthybriddropsortLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_hybrid_dropsort_layer_copy(s : SorthybriddropsortLayer) -> SorthybriddropsortLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_hybrid_dropsort_layer_fill(s : SorthybriddropsortLayer, v : Double) -> SorthybriddropsortLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_hybrid_dropsort_layer_min(s : SorthybriddropsortLayer) -> Double { @_common.min(s.data) }

pub fn sort_hybrid_dropsort_layer_max(s : SorthybriddropsortLayer) -> Double { @_common.max(s.data) }

pub fn sort_hybrid_dropsort_layer_to_string(s : SorthybriddropsortLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SorthybriddropsortBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_hybrid_dropsort_buffer_make(size : Int) -> SorthybriddropsortBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_hybrid_dropsort_buffer_len(s : SorthybriddropsortBuffer) -> Int { s.size }

pub fn sort_hybrid_dropsort_buffer_get(s : SorthybriddropsortBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_hybrid_dropsort_buffer_set(s : SorthybriddropsortBuffer, i : Int, v : Double) -> SorthybriddropsortBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_hybrid_dropsort_buffer_sum(s : SorthybriddropsortBuffer) -> Double { @_common.sum(s.data) }

pub fn sort_hybrid_dropsort_buffer_mean(s : SorthybriddropsortBuffer) -> Double { @_common.mean(s.data) }

pub fn sort_hybrid_dropsort_buffer_scale(s : SorthybriddropsortBuffer, f : Double) -> SorthybriddropsortBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_hybrid_dropsort_buffer_add(a : SorthybriddropsortBuffer, b : SorthybriddropsortBuffer) -> SorthybriddropsortBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_hybrid_dropsort_buffer_copy(s : SorthybriddropsortBuffer) -> SorthybriddropsortBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_hybrid_dropsort_buffer_fill(s : SorthybriddropsortBuffer, v : Double) -> SorthybriddropsortBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_hybrid_dropsort_buffer_min(s : SorthybriddropsortBuffer) -> Double { @_common.min(s.data) }

pub fn sort_hybrid_dropsort_buffer_max(s : SorthybriddropsortBuffer) -> Double { @_common.max(s.data) }

pub fn sort_hybrid_dropsort_buffer_to_string(s : SorthybriddropsortBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SorthybriddropsortCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_hybrid_dropsort_cursor_make(size : Int) -> SorthybriddropsortCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_hybrid_dropsort_cursor_len(s : SorthybriddropsortCursor) -> Int { s.size }

pub fn sort_hybrid_dropsort_cursor_get(s : SorthybriddropsortCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_hybrid_dropsort_cursor_set(s : SorthybriddropsortCursor, i : Int, v : Double) -> SorthybriddropsortCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_hybrid_dropsort_cursor_sum(s : SorthybriddropsortCursor) -> Double { @_common.sum(s.data) }

pub fn sort_hybrid_dropsort_cursor_mean(s : SorthybriddropsortCursor) -> Double { @_common.mean(s.data) }

pub fn sort_hybrid_dropsort_cursor_scale(s : SorthybriddropsortCursor, f : Double) -> SorthybriddropsortCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_hybrid_dropsort_cursor_add(a : SorthybriddropsortCursor, b : SorthybriddropsortCursor) -> SorthybriddropsortCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_hybrid_dropsort_cursor_copy(s : SorthybriddropsortCursor) -> SorthybriddropsortCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_hybrid_dropsort_cursor_fill(s : SorthybriddropsortCursor, v : Double) -> SorthybriddropsortCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_hybrid_dropsort_cursor_min(s : SorthybriddropsortCursor) -> Double { @_common.min(s.data) }

pub fn sort_hybrid_dropsort_cursor_max(s : SorthybriddropsortCursor) -> Double { @_common.max(s.data) }

pub fn sort_hybrid_dropsort_cursor_to_string(s : SorthybriddropsortCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SorthybriddropsortView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_hybrid_dropsort_view_make(size : Int) -> SorthybriddropsortView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_hybrid_dropsort_view_len(s : SorthybriddropsortView) -> Int { s.size }

pub fn sort_hybrid_dropsort_view_get(s : SorthybriddropsortView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_hybrid_dropsort_view_set(s : SorthybriddropsortView, i : Int, v : Double) -> SorthybriddropsortView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_hybrid_dropsort_view_sum(s : SorthybriddropsortView) -> Double { @_common.sum(s.data) }

pub fn sort_hybrid_dropsort_view_mean(s : SorthybriddropsortView) -> Double { @_common.mean(s.data) }

pub fn sort_hybrid_dropsort_view_scale(s : SorthybriddropsortView, f : Double) -> SorthybriddropsortView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_hybrid_dropsort_view_add(a : SorthybriddropsortView, b : SorthybriddropsortView) -> SorthybriddropsortView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_hybrid_dropsort_view_copy(s : SorthybriddropsortView) -> SorthybriddropsortView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_hybrid_dropsort_view_fill(s : SorthybriddropsortView, v : Double) -> SorthybriddropsortView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_hybrid_dropsort_view_min(s : SorthybriddropsortView) -> Double { @_common.min(s.data) }

pub fn sort_hybrid_dropsort_view_max(s : SorthybriddropsortView) -> Double { @_common.max(s.data) }

pub fn sort_hybrid_dropsort_view_to_string(s : SorthybriddropsortView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SorthybriddropsortRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_hybrid_dropsort_range_make(size : Int) -> SorthybriddropsortRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_hybrid_dropsort_range_len(s : SorthybriddropsortRange) -> Int { s.size }

pub fn sort_hybrid_dropsort_range_get(s : SorthybriddropsortRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_hybrid_dropsort_range_set(s : SorthybriddropsortRange, i : Int, v : Double) -> SorthybriddropsortRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_hybrid_dropsort_range_sum(s : SorthybriddropsortRange) -> Double { @_common.sum(s.data) }

pub fn sort_hybrid_dropsort_range_mean(s : SorthybriddropsortRange) -> Double { @_common.mean(s.data) }

pub fn sort_hybrid_dropsort_range_scale(s : SorthybriddropsortRange, f : Double) -> SorthybriddropsortRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_hybrid_dropsort_range_add(a : SorthybriddropsortRange, b : SorthybriddropsortRange) -> SorthybriddropsortRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_hybrid_dropsort_range_copy(s : SorthybriddropsortRange) -> SorthybriddropsortRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_hybrid_dropsort_range_fill(s : SorthybriddropsortRange, v : Double) -> SorthybriddropsortRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_hybrid_dropsort_range_min(s : SorthybriddropsortRange) -> Double { @_common.min(s.data) }

pub fn sort_hybrid_dropsort_range_max(s : SorthybriddropsortRange) -> Double { @_common.max(s.data) }

pub fn sort_hybrid_dropsort_range_to_string(s : SorthybriddropsortRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SorthybriddropsortSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_hybrid_dropsort_slice_make(size : Int) -> SorthybriddropsortSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_hybrid_dropsort_slice_len(s : SorthybriddropsortSlice) -> Int { s.size }

pub fn sort_hybrid_dropsort_slice_get(s : SorthybriddropsortSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_hybrid_dropsort_slice_set(s : SorthybriddropsortSlice, i : Int, v : Double) -> SorthybriddropsortSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_hybrid_dropsort_slice_sum(s : SorthybriddropsortSlice) -> Double { @_common.sum(s.data) }

pub fn sort_hybrid_dropsort_slice_mean(s : SorthybriddropsortSlice) -> Double { @_common.mean(s.data) }

pub fn sort_hybrid_dropsort_slice_scale(s : SorthybriddropsortSlice, f : Double) -> SorthybriddropsortSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_hybrid_dropsort_slice_add(a : SorthybriddropsortSlice, b : SorthybriddropsortSlice) -> SorthybriddropsortSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_hybrid_dropsort_slice_copy(s : SorthybriddropsortSlice) -> SorthybriddropsortSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_hybrid_dropsort_slice_fill(s : SorthybriddropsortSlice, v : Double) -> SorthybriddropsortSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_hybrid_dropsort_slice_min(s : SorthybriddropsortSlice) -> Double { @_common.min(s.data) }

pub fn sort_hybrid_dropsort_slice_max(s : SorthybriddropsortSlice) -> Double { @_common.max(s.data) }

pub fn sort_hybrid_dropsort_slice_to_string(s : SorthybriddropsortSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

