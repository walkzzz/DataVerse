///===
/// extcore/sort_hybrid_timsort

pub(all) struct SorthybridtimsortPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn sort_hybrid_timsort_make_point(x : Double, y : Double) -> SorthybridtimsortPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn sort_hybrid_timsort_make_point3(x : Double, y : Double, z : Double) -> SorthybridtimsortPoint {
  { x, y, z, label: 0 }
}

pub fn SorthybridtimsortPoint::x(self : SorthybridtimsortPoint) -> Double { self.x }

pub fn SorthybridtimsortPoint::y(self : SorthybridtimsortPoint) -> Double { self.y }

pub fn SorthybridtimsortPoint::z(self : SorthybridtimsortPoint) -> Double { self.z }

pub fn SorthybridtimsortPoint::label(self : SorthybridtimsortPoint) -> Int { self.label }

pub fn SorthybridtimsortPoint::dist(self : SorthybridtimsortPoint, other : SorthybridtimsortPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn SorthybridtimsortPoint::add(self : SorthybridtimsortPoint, other : SorthybridtimsortPoint) -> SorthybridtimsortPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn SorthybridtimsortPoint::sub(self : SorthybridtimsortPoint, other : SorthybridtimsortPoint) -> SorthybridtimsortPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn SorthybridtimsortPoint::scale(self : SorthybridtimsortPoint, s : Double) -> SorthybridtimsortPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn SorthybridtimsortPoint::dot(self : SorthybridtimsortPoint, other : SorthybridtimsortPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn SorthybridtimsortPoint::cross(self : SorthybridtimsortPoint, other : SorthybridtimsortPoint) -> SorthybridtimsortPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn SorthybridtimsortPoint::norm(self : SorthybridtimsortPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn SorthybridtimsortPoint::normalize(self : SorthybridtimsortPoint) -> SorthybridtimsortPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn SorthybridtimsortPoint::negate(self : SorthybridtimsortPoint) -> SorthybridtimsortPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn SorthybridtimsortPoint::mid(self : SorthybridtimsortPoint, other : SorthybridtimsortPoint) -> SorthybridtimsortPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn SorthybridtimsortPoint::lerp(self : SorthybridtimsortPoint, other : SorthybridtimsortPoint, t : Double) -> SorthybridtimsortPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn SorthybridtimsortPoint::to_string(self : SorthybridtimsortPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct SorthybridtimsortSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn sort_hybrid_timsort_make_series(vals : Array[Double], name : String) -> SorthybridtimsortSeries {
  { vals, name, meta: 0 }
}

pub fn SorthybridtimsortSeries::len(self : SorthybridtimsortSeries) -> Int { self.vals.length() }

pub fn SorthybridtimsortSeries::sum(self : SorthybridtimsortSeries) -> Double { @_common.sum(self.vals) }

pub fn SorthybridtimsortSeries::mean(self : SorthybridtimsortSeries) -> Double { @_common.mean(self.vals) }

pub fn SorthybridtimsortSeries::min(self : SorthybridtimsortSeries) -> Double { @_common.min(self.vals) }

pub fn SorthybridtimsortSeries::max(self : SorthybridtimsortSeries) -> Double { @_common.max(self.vals) }

pub fn SorthybridtimsortSeries::range(self : SorthybridtimsortSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn SorthybridtimsortSeries::variance(self : SorthybridtimsortSeries) -> Double { @_common.variance(self.vals) }

pub fn SorthybridtimsortSeries::std(self : SorthybridtimsortSeries) -> Double { @_common.std(self.vals) }

pub fn SorthybridtimsortSeries::median(self : SorthybridtimsortSeries) -> Double { @_common.median(self.vals) }

pub fn SorthybridtimsortSeries::scale(self : SorthybridtimsortSeries, f : Double) -> SorthybridtimsortSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn SorthybridtimsortSeries::add(self : SorthybridtimsortSeries, other : SorthybridtimsortSeries) -> SorthybridtimsortSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn SorthybridtimsortSeries::sub(self : SorthybridtimsortSeries, other : SorthybridtimsortSeries) -> SorthybridtimsortSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn SorthybridtimsortSeries::normalize(self : SorthybridtimsortSeries) -> SorthybridtimsortSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn SorthybridtimsortSeries::cumsum(self : SorthybridtimsortSeries) -> SorthybridtimsortSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn SorthybridtimsortSeries::to_string(self : SorthybridtimsortSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct SorthybridtimsortMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn sort_hybrid_timsort_make_matrix(rows : Int, cols : Int, val : Double) -> SorthybridtimsortMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn sort_hybrid_timsort_matrix_identity(n : Int) -> SorthybridtimsortMatrix {
  let m = sort_hybrid_timsort_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn SorthybridtimsortMatrix::get(self : SorthybridtimsortMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn SorthybridtimsortMatrix::transpose(self : SorthybridtimsortMatrix) -> SorthybridtimsortMatrix {
  let result = sort_hybrid_timsort_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn SorthybridtimsortMatrix::add(self : SorthybridtimsortMatrix, other : SorthybridtimsortMatrix) -> SorthybridtimsortMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = sort_hybrid_timsort_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn SorthybridtimsortMatrix::scale(self : SorthybridtimsortMatrix, s : Double) -> SorthybridtimsortMatrix {
  let result = sort_hybrid_timsort_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn SorthybridtimsortMatrix::multiply(self : SorthybridtimsortMatrix, other : SorthybridtimsortMatrix) -> SorthybridtimsortMatrix {
  if self.cols != other.rows { return sort_hybrid_timsort_make_matrix(self.rows, other.cols, 0.0) }
  let result = sort_hybrid_timsort_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn SorthybridtimsortMatrix::trace(self : SorthybridtimsortMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn SorthybridtimsortMatrix::det(self : SorthybridtimsortMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn SorthybridtimsortMatrix::norm(self : SorthybridtimsortMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn SorthybridtimsortMatrix::to_string(self : SorthybridtimsortMatrix) -> String {
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

pub(all) struct SorthybridtimsortVector {
  comps : Array[Double]
  dim : Int
}

pub fn sort_hybrid_timsort_make_vector(comps : Array[Double]) -> SorthybridtimsortVector {
  { comps, dim: comps.length() }
}

pub fn sort_hybrid_timsort_vector_zero(dim : Int) -> SorthybridtimsortVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn SorthybridtimsortVector::add(self : SorthybridtimsortVector, other : SorthybridtimsortVector) -> SorthybridtimsortVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn SorthybridtimsortVector::sub(self : SorthybridtimsortVector, other : SorthybridtimsortVector) -> SorthybridtimsortVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn SorthybridtimsortVector::scale(self : SorthybridtimsortVector, s : Double) -> SorthybridtimsortVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn SorthybridtimsortVector::dot(self : SorthybridtimsortVector, other : SorthybridtimsortVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn SorthybridtimsortVector::norm(self : SorthybridtimsortVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn SorthybridtimsortVector::normalize(self : SorthybridtimsortVector) -> SorthybridtimsortVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn SorthybridtimsortVector::dist(self : SorthybridtimsortVector, other : SorthybridtimsortVector) -> Double {
  self.sub(other).norm()
}

pub fn SorthybridtimsortVector::to_string(self : SorthybridtimsortVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn sort_hybrid_timsort_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn sort_hybrid_timsort_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn sort_hybrid_timsort_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn sort_hybrid_timsort_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn sort_hybrid_timsort_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn sort_hybrid_timsort_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn sort_hybrid_timsort_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn sort_hybrid_timsort_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn sort_hybrid_timsort_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn sort_hybrid_timsort_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn sort_hybrid_timsort_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn sort_hybrid_timsort_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn sort_hybrid_timsort_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn sort_hybrid_timsort_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn sort_hybrid_timsort_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn sort_hybrid_timsort_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn sort_hybrid_timsort_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn sort_hybrid_timsort_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn sort_hybrid_timsort_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn sort_hybrid_timsort_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn sort_hybrid_timsort_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn sort_hybrid_timsort_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn sort_hybrid_timsort_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn sort_hybrid_timsort_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn sort_hybrid_timsort_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn sort_hybrid_timsort_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn sort_hybrid_timsort_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn sort_hybrid_timsort_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn sort_hybrid_timsort_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct SorthybridtimsortFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_hybrid_timsort_frame_make(size : Int) -> SorthybridtimsortFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SorthybridtimsortFrame::len(self : SorthybridtimsortFrame) -> Int { self.size }

pub fn SorthybridtimsortFrame::get(self : SorthybridtimsortFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SorthybridtimsortFrame::set(self : SorthybridtimsortFrame, i : Int, v : Double) -> SorthybridtimsortFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SorthybridtimsortFrame::sum(self : SorthybridtimsortFrame) -> Double { @_common.sum(self.data) }

pub fn SorthybridtimsortFrame::mean(self : SorthybridtimsortFrame) -> Double { @_common.mean(self.data) }

pub fn SorthybridtimsortFrame::scale(self : SorthybridtimsortFrame, f : Double) -> SorthybridtimsortFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SorthybridtimsortFrame::add(self : SorthybridtimsortFrame, other : SorthybridtimsortFrame) -> SorthybridtimsortFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SorthybridtimsortFrame::copy(self : SorthybridtimsortFrame) -> SorthybridtimsortFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SorthybridtimsortFrame::fill(self : SorthybridtimsortFrame, v : Double) -> SorthybridtimsortFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SorthybridtimsortFrame::min(self : SorthybridtimsortFrame) -> Double { @_common.min(self.data) }

pub fn SorthybridtimsortFrame::max(self : SorthybridtimsortFrame) -> Double { @_common.max(self.data) }

pub fn SorthybridtimsortFrame::to_string(self : SorthybridtimsortFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SorthybridtimsortTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_hybrid_timsort_table_make(size : Int) -> SorthybridtimsortTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SorthybridtimsortTable::len(self : SorthybridtimsortTable) -> Int { self.size }

pub fn SorthybridtimsortTable::get(self : SorthybridtimsortTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SorthybridtimsortTable::set(self : SorthybridtimsortTable, i : Int, v : Double) -> SorthybridtimsortTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SorthybridtimsortTable::sum(self : SorthybridtimsortTable) -> Double { @_common.sum(self.data) }

pub fn SorthybridtimsortTable::mean(self : SorthybridtimsortTable) -> Double { @_common.mean(self.data) }

pub fn SorthybridtimsortTable::scale(self : SorthybridtimsortTable, f : Double) -> SorthybridtimsortTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SorthybridtimsortTable::add(self : SorthybridtimsortTable, other : SorthybridtimsortTable) -> SorthybridtimsortTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SorthybridtimsortTable::copy(self : SorthybridtimsortTable) -> SorthybridtimsortTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SorthybridtimsortTable::fill(self : SorthybridtimsortTable, v : Double) -> SorthybridtimsortTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SorthybridtimsortTable::min(self : SorthybridtimsortTable) -> Double { @_common.min(self.data) }

pub fn SorthybridtimsortTable::max(self : SorthybridtimsortTable) -> Double { @_common.max(self.data) }

pub fn SorthybridtimsortTable::to_string(self : SorthybridtimsortTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SorthybridtimsortGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_hybrid_timsort_graphn_make(size : Int) -> SorthybridtimsortGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SorthybridtimsortGraphN::len(self : SorthybridtimsortGraphN) -> Int { self.size }

pub fn SorthybridtimsortGraphN::get(self : SorthybridtimsortGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SorthybridtimsortGraphN::set(self : SorthybridtimsortGraphN, i : Int, v : Double) -> SorthybridtimsortGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SorthybridtimsortGraphN::sum(self : SorthybridtimsortGraphN) -> Double { @_common.sum(self.data) }

pub fn SorthybridtimsortGraphN::mean(self : SorthybridtimsortGraphN) -> Double { @_common.mean(self.data) }

pub fn SorthybridtimsortGraphN::scale(self : SorthybridtimsortGraphN, f : Double) -> SorthybridtimsortGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SorthybridtimsortGraphN::add(self : SorthybridtimsortGraphN, other : SorthybridtimsortGraphN) -> SorthybridtimsortGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SorthybridtimsortGraphN::copy(self : SorthybridtimsortGraphN) -> SorthybridtimsortGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SorthybridtimsortGraphN::fill(self : SorthybridtimsortGraphN, v : Double) -> SorthybridtimsortGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SorthybridtimsortGraphN::min(self : SorthybridtimsortGraphN) -> Double { @_common.min(self.data) }

pub fn SorthybridtimsortGraphN::max(self : SorthybridtimsortGraphN) -> Double { @_common.max(self.data) }

pub fn SorthybridtimsortGraphN::to_string(self : SorthybridtimsortGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SorthybridtimsortNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_hybrid_timsort_node_make(size : Int) -> SorthybridtimsortNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SorthybridtimsortNode::len(self : SorthybridtimsortNode) -> Int { self.size }

pub fn SorthybridtimsortNode::get(self : SorthybridtimsortNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SorthybridtimsortNode::set(self : SorthybridtimsortNode, i : Int, v : Double) -> SorthybridtimsortNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SorthybridtimsortNode::sum(self : SorthybridtimsortNode) -> Double { @_common.sum(self.data) }

pub fn SorthybridtimsortNode::mean(self : SorthybridtimsortNode) -> Double { @_common.mean(self.data) }

pub fn SorthybridtimsortNode::scale(self : SorthybridtimsortNode, f : Double) -> SorthybridtimsortNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SorthybridtimsortNode::add(self : SorthybridtimsortNode, other : SorthybridtimsortNode) -> SorthybridtimsortNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SorthybridtimsortNode::copy(self : SorthybridtimsortNode) -> SorthybridtimsortNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SorthybridtimsortNode::fill(self : SorthybridtimsortNode, v : Double) -> SorthybridtimsortNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SorthybridtimsortNode::min(self : SorthybridtimsortNode) -> Double { @_common.min(self.data) }

pub fn SorthybridtimsortNode::max(self : SorthybridtimsortNode) -> Double { @_common.max(self.data) }

pub fn SorthybridtimsortNode::to_string(self : SorthybridtimsortNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SorthybridtimsortEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_hybrid_timsort_edge_make(size : Int) -> SorthybridtimsortEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SorthybridtimsortEdge::len(self : SorthybridtimsortEdge) -> Int { self.size }

pub fn SorthybridtimsortEdge::get(self : SorthybridtimsortEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SorthybridtimsortEdge::set(self : SorthybridtimsortEdge, i : Int, v : Double) -> SorthybridtimsortEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SorthybridtimsortEdge::sum(self : SorthybridtimsortEdge) -> Double { @_common.sum(self.data) }

pub fn SorthybridtimsortEdge::mean(self : SorthybridtimsortEdge) -> Double { @_common.mean(self.data) }

pub fn SorthybridtimsortEdge::scale(self : SorthybridtimsortEdge, f : Double) -> SorthybridtimsortEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SorthybridtimsortEdge::add(self : SorthybridtimsortEdge, other : SorthybridtimsortEdge) -> SorthybridtimsortEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SorthybridtimsortEdge::copy(self : SorthybridtimsortEdge) -> SorthybridtimsortEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SorthybridtimsortEdge::fill(self : SorthybridtimsortEdge, v : Double) -> SorthybridtimsortEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SorthybridtimsortEdge::min(self : SorthybridtimsortEdge) -> Double { @_common.min(self.data) }

pub fn SorthybridtimsortEdge::max(self : SorthybridtimsortEdge) -> Double { @_common.max(self.data) }

pub fn SorthybridtimsortEdge::to_string(self : SorthybridtimsortEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SorthybridtimsortPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_hybrid_timsort_path_make(size : Int) -> SorthybridtimsortPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SorthybridtimsortPath::len(self : SorthybridtimsortPath) -> Int { self.size }

pub fn SorthybridtimsortPath::get(self : SorthybridtimsortPath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SorthybridtimsortPath::set(self : SorthybridtimsortPath, i : Int, v : Double) -> SorthybridtimsortPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SorthybridtimsortPath::sum(self : SorthybridtimsortPath) -> Double { @_common.sum(self.data) }

pub fn SorthybridtimsortPath::mean(self : SorthybridtimsortPath) -> Double { @_common.mean(self.data) }

pub fn SorthybridtimsortPath::scale(self : SorthybridtimsortPath, f : Double) -> SorthybridtimsortPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SorthybridtimsortPath::add(self : SorthybridtimsortPath, other : SorthybridtimsortPath) -> SorthybridtimsortPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SorthybridtimsortPath::copy(self : SorthybridtimsortPath) -> SorthybridtimsortPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SorthybridtimsortPath::fill(self : SorthybridtimsortPath, v : Double) -> SorthybridtimsortPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SorthybridtimsortPath::min(self : SorthybridtimsortPath) -> Double { @_common.min(self.data) }

pub fn SorthybridtimsortPath::max(self : SorthybridtimsortPath) -> Double { @_common.max(self.data) }

pub fn SorthybridtimsortPath::to_string(self : SorthybridtimsortPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SorthybridtimsortCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_hybrid_timsort_cluster_make(size : Int) -> SorthybridtimsortCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SorthybridtimsortCluster::len(self : SorthybridtimsortCluster) -> Int { self.size }

pub fn SorthybridtimsortCluster::get(self : SorthybridtimsortCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SorthybridtimsortCluster::set(self : SorthybridtimsortCluster, i : Int, v : Double) -> SorthybridtimsortCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SorthybridtimsortCluster::sum(self : SorthybridtimsortCluster) -> Double { @_common.sum(self.data) }

pub fn SorthybridtimsortCluster::mean(self : SorthybridtimsortCluster) -> Double { @_common.mean(self.data) }

pub fn SorthybridtimsortCluster::scale(self : SorthybridtimsortCluster, f : Double) -> SorthybridtimsortCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SorthybridtimsortCluster::add(self : SorthybridtimsortCluster, other : SorthybridtimsortCluster) -> SorthybridtimsortCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SorthybridtimsortCluster::copy(self : SorthybridtimsortCluster) -> SorthybridtimsortCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SorthybridtimsortCluster::fill(self : SorthybridtimsortCluster, v : Double) -> SorthybridtimsortCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SorthybridtimsortCluster::min(self : SorthybridtimsortCluster) -> Double { @_common.min(self.data) }

pub fn SorthybridtimsortCluster::max(self : SorthybridtimsortCluster) -> Double { @_common.max(self.data) }

pub fn SorthybridtimsortCluster::to_string(self : SorthybridtimsortCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SorthybridtimsortModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_hybrid_timsort_model_make(size : Int) -> SorthybridtimsortModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SorthybridtimsortModel::len(self : SorthybridtimsortModel) -> Int { self.size }

pub fn SorthybridtimsortModel::get(self : SorthybridtimsortModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SorthybridtimsortModel::set(self : SorthybridtimsortModel, i : Int, v : Double) -> SorthybridtimsortModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SorthybridtimsortModel::sum(self : SorthybridtimsortModel) -> Double { @_common.sum(self.data) }

pub fn SorthybridtimsortModel::mean(self : SorthybridtimsortModel) -> Double { @_common.mean(self.data) }

pub fn SorthybridtimsortModel::scale(self : SorthybridtimsortModel, f : Double) -> SorthybridtimsortModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SorthybridtimsortModel::add(self : SorthybridtimsortModel, other : SorthybridtimsortModel) -> SorthybridtimsortModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SorthybridtimsortModel::copy(self : SorthybridtimsortModel) -> SorthybridtimsortModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SorthybridtimsortModel::fill(self : SorthybridtimsortModel, v : Double) -> SorthybridtimsortModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SorthybridtimsortModel::min(self : SorthybridtimsortModel) -> Double { @_common.min(self.data) }

pub fn SorthybridtimsortModel::max(self : SorthybridtimsortModel) -> Double { @_common.max(self.data) }

pub fn SorthybridtimsortModel::to_string(self : SorthybridtimsortModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SorthybridtimsortLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_hybrid_timsort_layer_make(size : Int) -> SorthybridtimsortLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SorthybridtimsortLayer::len(self : SorthybridtimsortLayer) -> Int { self.size }

pub fn SorthybridtimsortLayer::get(self : SorthybridtimsortLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SorthybridtimsortLayer::set(self : SorthybridtimsortLayer, i : Int, v : Double) -> SorthybridtimsortLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SorthybridtimsortLayer::sum(self : SorthybridtimsortLayer) -> Double { @_common.sum(self.data) }

pub fn SorthybridtimsortLayer::mean(self : SorthybridtimsortLayer) -> Double { @_common.mean(self.data) }

pub fn SorthybridtimsortLayer::scale(self : SorthybridtimsortLayer, f : Double) -> SorthybridtimsortLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SorthybridtimsortLayer::add(self : SorthybridtimsortLayer, other : SorthybridtimsortLayer) -> SorthybridtimsortLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SorthybridtimsortLayer::copy(self : SorthybridtimsortLayer) -> SorthybridtimsortLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SorthybridtimsortLayer::fill(self : SorthybridtimsortLayer, v : Double) -> SorthybridtimsortLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SorthybridtimsortLayer::min(self : SorthybridtimsortLayer) -> Double { @_common.min(self.data) }

pub fn SorthybridtimsortLayer::max(self : SorthybridtimsortLayer) -> Double { @_common.max(self.data) }

pub fn SorthybridtimsortLayer::to_string(self : SorthybridtimsortLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SorthybridtimsortBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_hybrid_timsort_buffer_make(size : Int) -> SorthybridtimsortBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SorthybridtimsortBuffer::len(self : SorthybridtimsortBuffer) -> Int { self.size }

pub fn SorthybridtimsortBuffer::get(self : SorthybridtimsortBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SorthybridtimsortBuffer::set(self : SorthybridtimsortBuffer, i : Int, v : Double) -> SorthybridtimsortBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SorthybridtimsortBuffer::sum(self : SorthybridtimsortBuffer) -> Double { @_common.sum(self.data) }

pub fn SorthybridtimsortBuffer::mean(self : SorthybridtimsortBuffer) -> Double { @_common.mean(self.data) }

pub fn SorthybridtimsortBuffer::scale(self : SorthybridtimsortBuffer, f : Double) -> SorthybridtimsortBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SorthybridtimsortBuffer::add(self : SorthybridtimsortBuffer, other : SorthybridtimsortBuffer) -> SorthybridtimsortBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SorthybridtimsortBuffer::copy(self : SorthybridtimsortBuffer) -> SorthybridtimsortBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SorthybridtimsortBuffer::fill(self : SorthybridtimsortBuffer, v : Double) -> SorthybridtimsortBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SorthybridtimsortBuffer::min(self : SorthybridtimsortBuffer) -> Double { @_common.min(self.data) }

pub fn SorthybridtimsortBuffer::max(self : SorthybridtimsortBuffer) -> Double { @_common.max(self.data) }

pub fn SorthybridtimsortBuffer::to_string(self : SorthybridtimsortBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SorthybridtimsortCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_hybrid_timsort_cursor_make(size : Int) -> SorthybridtimsortCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SorthybridtimsortCursor::len(self : SorthybridtimsortCursor) -> Int { self.size }

pub fn SorthybridtimsortCursor::get(self : SorthybridtimsortCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SorthybridtimsortCursor::set(self : SorthybridtimsortCursor, i : Int, v : Double) -> SorthybridtimsortCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SorthybridtimsortCursor::sum(self : SorthybridtimsortCursor) -> Double { @_common.sum(self.data) }

pub fn SorthybridtimsortCursor::mean(self : SorthybridtimsortCursor) -> Double { @_common.mean(self.data) }

pub fn SorthybridtimsortCursor::scale(self : SorthybridtimsortCursor, f : Double) -> SorthybridtimsortCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SorthybridtimsortCursor::add(self : SorthybridtimsortCursor, other : SorthybridtimsortCursor) -> SorthybridtimsortCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SorthybridtimsortCursor::copy(self : SorthybridtimsortCursor) -> SorthybridtimsortCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SorthybridtimsortCursor::fill(self : SorthybridtimsortCursor, v : Double) -> SorthybridtimsortCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SorthybridtimsortCursor::min(self : SorthybridtimsortCursor) -> Double { @_common.min(self.data) }

pub fn SorthybridtimsortCursor::max(self : SorthybridtimsortCursor) -> Double { @_common.max(self.data) }

pub fn SorthybridtimsortCursor::to_string(self : SorthybridtimsortCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SorthybridtimsortView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_hybrid_timsort_view_make(size : Int) -> SorthybridtimsortView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SorthybridtimsortView::len(self : SorthybridtimsortView) -> Int { self.size }

pub fn SorthybridtimsortView::get(self : SorthybridtimsortView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SorthybridtimsortView::set(self : SorthybridtimsortView, i : Int, v : Double) -> SorthybridtimsortView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SorthybridtimsortView::sum(self : SorthybridtimsortView) -> Double { @_common.sum(self.data) }

pub fn SorthybridtimsortView::mean(self : SorthybridtimsortView) -> Double { @_common.mean(self.data) }

pub fn SorthybridtimsortView::scale(self : SorthybridtimsortView, f : Double) -> SorthybridtimsortView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SorthybridtimsortView::add(self : SorthybridtimsortView, other : SorthybridtimsortView) -> SorthybridtimsortView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SorthybridtimsortView::copy(self : SorthybridtimsortView) -> SorthybridtimsortView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SorthybridtimsortView::fill(self : SorthybridtimsortView, v : Double) -> SorthybridtimsortView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SorthybridtimsortView::min(self : SorthybridtimsortView) -> Double { @_common.min(self.data) }

pub fn SorthybridtimsortView::max(self : SorthybridtimsortView) -> Double { @_common.max(self.data) }

pub fn SorthybridtimsortView::to_string(self : SorthybridtimsortView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SorthybridtimsortRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_hybrid_timsort_range_make(size : Int) -> SorthybridtimsortRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SorthybridtimsortRange::len(self : SorthybridtimsortRange) -> Int { self.size }

pub fn SorthybridtimsortRange::get(self : SorthybridtimsortRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SorthybridtimsortRange::set(self : SorthybridtimsortRange, i : Int, v : Double) -> SorthybridtimsortRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SorthybridtimsortRange::sum(self : SorthybridtimsortRange) -> Double { @_common.sum(self.data) }

pub fn SorthybridtimsortRange::mean(self : SorthybridtimsortRange) -> Double { @_common.mean(self.data) }

pub fn SorthybridtimsortRange::scale(self : SorthybridtimsortRange, f : Double) -> SorthybridtimsortRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SorthybridtimsortRange::add(self : SorthybridtimsortRange, other : SorthybridtimsortRange) -> SorthybridtimsortRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SorthybridtimsortRange::copy(self : SorthybridtimsortRange) -> SorthybridtimsortRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SorthybridtimsortRange::fill(self : SorthybridtimsortRange, v : Double) -> SorthybridtimsortRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SorthybridtimsortRange::min(self : SorthybridtimsortRange) -> Double { @_common.min(self.data) }

pub fn SorthybridtimsortRange::max(self : SorthybridtimsortRange) -> Double { @_common.max(self.data) }

pub fn SorthybridtimsortRange::to_string(self : SorthybridtimsortRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SorthybridtimsortSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_hybrid_timsort_slice_make(size : Int) -> SorthybridtimsortSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SorthybridtimsortSlice::len(self : SorthybridtimsortSlice) -> Int { self.size }

pub fn SorthybridtimsortSlice::get(self : SorthybridtimsortSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SorthybridtimsortSlice::set(self : SorthybridtimsortSlice, i : Int, v : Double) -> SorthybridtimsortSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SorthybridtimsortSlice::sum(self : SorthybridtimsortSlice) -> Double { @_common.sum(self.data) }

pub fn SorthybridtimsortSlice::mean(self : SorthybridtimsortSlice) -> Double { @_common.mean(self.data) }

pub fn SorthybridtimsortSlice::scale(self : SorthybridtimsortSlice, f : Double) -> SorthybridtimsortSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SorthybridtimsortSlice::add(self : SorthybridtimsortSlice, other : SorthybridtimsortSlice) -> SorthybridtimsortSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SorthybridtimsortSlice::copy(self : SorthybridtimsortSlice) -> SorthybridtimsortSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SorthybridtimsortSlice::fill(self : SorthybridtimsortSlice, v : Double) -> SorthybridtimsortSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SorthybridtimsortSlice::min(self : SorthybridtimsortSlice) -> Double { @_common.min(self.data) }

pub fn SorthybridtimsortSlice::max(self : SorthybridtimsortSlice) -> Double { @_common.max(self.data) }

pub fn SorthybridtimsortSlice::to_string(self : SorthybridtimsortSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

