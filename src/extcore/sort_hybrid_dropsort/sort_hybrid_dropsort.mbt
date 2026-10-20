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

pub fn SorthybriddropsortFrame::len(self : SorthybriddropsortFrame) -> Int { self.size }

pub fn SorthybriddropsortFrame::get(self : SorthybriddropsortFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SorthybriddropsortFrame::set(self : SorthybriddropsortFrame, i : Int, v : Double) -> SorthybriddropsortFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SorthybriddropsortFrame::sum(self : SorthybriddropsortFrame) -> Double { @_common.sum(self.data) }

pub fn SorthybriddropsortFrame::mean(self : SorthybriddropsortFrame) -> Double { @_common.mean(self.data) }

pub fn SorthybriddropsortFrame::scale(self : SorthybriddropsortFrame, f : Double) -> SorthybriddropsortFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SorthybriddropsortFrame::add(self : SorthybriddropsortFrame, other : SorthybriddropsortFrame) -> SorthybriddropsortFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SorthybriddropsortFrame::copy(self : SorthybriddropsortFrame) -> SorthybriddropsortFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SorthybriddropsortFrame::fill(self : SorthybriddropsortFrame, v : Double) -> SorthybriddropsortFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SorthybriddropsortFrame::min(self : SorthybriddropsortFrame) -> Double { @_common.min(self.data) }

pub fn SorthybriddropsortFrame::max(self : SorthybriddropsortFrame) -> Double { @_common.max(self.data) }

pub fn SorthybriddropsortFrame::to_string(self : SorthybriddropsortFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SorthybriddropsortTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_hybrid_dropsort_table_make(size : Int) -> SorthybriddropsortTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SorthybriddropsortTable::len(self : SorthybriddropsortTable) -> Int { self.size }

pub fn SorthybriddropsortTable::get(self : SorthybriddropsortTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SorthybriddropsortTable::set(self : SorthybriddropsortTable, i : Int, v : Double) -> SorthybriddropsortTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SorthybriddropsortTable::sum(self : SorthybriddropsortTable) -> Double { @_common.sum(self.data) }

pub fn SorthybriddropsortTable::mean(self : SorthybriddropsortTable) -> Double { @_common.mean(self.data) }

pub fn SorthybriddropsortTable::scale(self : SorthybriddropsortTable, f : Double) -> SorthybriddropsortTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SorthybriddropsortTable::add(self : SorthybriddropsortTable, other : SorthybriddropsortTable) -> SorthybriddropsortTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SorthybriddropsortTable::copy(self : SorthybriddropsortTable) -> SorthybriddropsortTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SorthybriddropsortTable::fill(self : SorthybriddropsortTable, v : Double) -> SorthybriddropsortTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SorthybriddropsortTable::min(self : SorthybriddropsortTable) -> Double { @_common.min(self.data) }

pub fn SorthybriddropsortTable::max(self : SorthybriddropsortTable) -> Double { @_common.max(self.data) }

pub fn SorthybriddropsortTable::to_string(self : SorthybriddropsortTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SorthybriddropsortGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_hybrid_dropsort_graphn_make(size : Int) -> SorthybriddropsortGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SorthybriddropsortGraphN::len(self : SorthybriddropsortGraphN) -> Int { self.size }

pub fn SorthybriddropsortGraphN::get(self : SorthybriddropsortGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SorthybriddropsortGraphN::set(self : SorthybriddropsortGraphN, i : Int, v : Double) -> SorthybriddropsortGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SorthybriddropsortGraphN::sum(self : SorthybriddropsortGraphN) -> Double { @_common.sum(self.data) }

pub fn SorthybriddropsortGraphN::mean(self : SorthybriddropsortGraphN) -> Double { @_common.mean(self.data) }

pub fn SorthybriddropsortGraphN::scale(self : SorthybriddropsortGraphN, f : Double) -> SorthybriddropsortGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SorthybriddropsortGraphN::add(self : SorthybriddropsortGraphN, other : SorthybriddropsortGraphN) -> SorthybriddropsortGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SorthybriddropsortGraphN::copy(self : SorthybriddropsortGraphN) -> SorthybriddropsortGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SorthybriddropsortGraphN::fill(self : SorthybriddropsortGraphN, v : Double) -> SorthybriddropsortGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SorthybriddropsortGraphN::min(self : SorthybriddropsortGraphN) -> Double { @_common.min(self.data) }

pub fn SorthybriddropsortGraphN::max(self : SorthybriddropsortGraphN) -> Double { @_common.max(self.data) }

pub fn SorthybriddropsortGraphN::to_string(self : SorthybriddropsortGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SorthybriddropsortNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_hybrid_dropsort_node_make(size : Int) -> SorthybriddropsortNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SorthybriddropsortNode::len(self : SorthybriddropsortNode) -> Int { self.size }

pub fn SorthybriddropsortNode::get(self : SorthybriddropsortNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SorthybriddropsortNode::set(self : SorthybriddropsortNode, i : Int, v : Double) -> SorthybriddropsortNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SorthybriddropsortNode::sum(self : SorthybriddropsortNode) -> Double { @_common.sum(self.data) }

pub fn SorthybriddropsortNode::mean(self : SorthybriddropsortNode) -> Double { @_common.mean(self.data) }

pub fn SorthybriddropsortNode::scale(self : SorthybriddropsortNode, f : Double) -> SorthybriddropsortNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SorthybriddropsortNode::add(self : SorthybriddropsortNode, other : SorthybriddropsortNode) -> SorthybriddropsortNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SorthybriddropsortNode::copy(self : SorthybriddropsortNode) -> SorthybriddropsortNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SorthybriddropsortNode::fill(self : SorthybriddropsortNode, v : Double) -> SorthybriddropsortNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SorthybriddropsortNode::min(self : SorthybriddropsortNode) -> Double { @_common.min(self.data) }

pub fn SorthybriddropsortNode::max(self : SorthybriddropsortNode) -> Double { @_common.max(self.data) }

pub fn SorthybriddropsortNode::to_string(self : SorthybriddropsortNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SorthybriddropsortEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_hybrid_dropsort_edge_make(size : Int) -> SorthybriddropsortEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SorthybriddropsortEdge::len(self : SorthybriddropsortEdge) -> Int { self.size }

pub fn SorthybriddropsortEdge::get(self : SorthybriddropsortEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SorthybriddropsortEdge::set(self : SorthybriddropsortEdge, i : Int, v : Double) -> SorthybriddropsortEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SorthybriddropsortEdge::sum(self : SorthybriddropsortEdge) -> Double { @_common.sum(self.data) }

pub fn SorthybriddropsortEdge::mean(self : SorthybriddropsortEdge) -> Double { @_common.mean(self.data) }

pub fn SorthybriddropsortEdge::scale(self : SorthybriddropsortEdge, f : Double) -> SorthybriddropsortEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SorthybriddropsortEdge::add(self : SorthybriddropsortEdge, other : SorthybriddropsortEdge) -> SorthybriddropsortEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SorthybriddropsortEdge::copy(self : SorthybriddropsortEdge) -> SorthybriddropsortEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SorthybriddropsortEdge::fill(self : SorthybriddropsortEdge, v : Double) -> SorthybriddropsortEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SorthybriddropsortEdge::min(self : SorthybriddropsortEdge) -> Double { @_common.min(self.data) }

pub fn SorthybriddropsortEdge::max(self : SorthybriddropsortEdge) -> Double { @_common.max(self.data) }

pub fn SorthybriddropsortEdge::to_string(self : SorthybriddropsortEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SorthybriddropsortPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_hybrid_dropsort_path_make(size : Int) -> SorthybriddropsortPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SorthybriddropsortPath::len(self : SorthybriddropsortPath) -> Int { self.size }

pub fn SorthybriddropsortPath::get(self : SorthybriddropsortPath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SorthybriddropsortPath::set(self : SorthybriddropsortPath, i : Int, v : Double) -> SorthybriddropsortPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SorthybriddropsortPath::sum(self : SorthybriddropsortPath) -> Double { @_common.sum(self.data) }

pub fn SorthybriddropsortPath::mean(self : SorthybriddropsortPath) -> Double { @_common.mean(self.data) }

pub fn SorthybriddropsortPath::scale(self : SorthybriddropsortPath, f : Double) -> SorthybriddropsortPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SorthybriddropsortPath::add(self : SorthybriddropsortPath, other : SorthybriddropsortPath) -> SorthybriddropsortPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SorthybriddropsortPath::copy(self : SorthybriddropsortPath) -> SorthybriddropsortPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SorthybriddropsortPath::fill(self : SorthybriddropsortPath, v : Double) -> SorthybriddropsortPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SorthybriddropsortPath::min(self : SorthybriddropsortPath) -> Double { @_common.min(self.data) }

pub fn SorthybriddropsortPath::max(self : SorthybriddropsortPath) -> Double { @_common.max(self.data) }

pub fn SorthybriddropsortPath::to_string(self : SorthybriddropsortPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SorthybriddropsortCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_hybrid_dropsort_cluster_make(size : Int) -> SorthybriddropsortCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SorthybriddropsortCluster::len(self : SorthybriddropsortCluster) -> Int { self.size }

pub fn SorthybriddropsortCluster::get(self : SorthybriddropsortCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SorthybriddropsortCluster::set(self : SorthybriddropsortCluster, i : Int, v : Double) -> SorthybriddropsortCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SorthybriddropsortCluster::sum(self : SorthybriddropsortCluster) -> Double { @_common.sum(self.data) }

pub fn SorthybriddropsortCluster::mean(self : SorthybriddropsortCluster) -> Double { @_common.mean(self.data) }

pub fn SorthybriddropsortCluster::scale(self : SorthybriddropsortCluster, f : Double) -> SorthybriddropsortCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SorthybriddropsortCluster::add(self : SorthybriddropsortCluster, other : SorthybriddropsortCluster) -> SorthybriddropsortCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SorthybriddropsortCluster::copy(self : SorthybriddropsortCluster) -> SorthybriddropsortCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SorthybriddropsortCluster::fill(self : SorthybriddropsortCluster, v : Double) -> SorthybriddropsortCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SorthybriddropsortCluster::min(self : SorthybriddropsortCluster) -> Double { @_common.min(self.data) }

pub fn SorthybriddropsortCluster::max(self : SorthybriddropsortCluster) -> Double { @_common.max(self.data) }

pub fn SorthybriddropsortCluster::to_string(self : SorthybriddropsortCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SorthybriddropsortModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_hybrid_dropsort_model_make(size : Int) -> SorthybriddropsortModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SorthybriddropsortModel::len(self : SorthybriddropsortModel) -> Int { self.size }

pub fn SorthybriddropsortModel::get(self : SorthybriddropsortModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SorthybriddropsortModel::set(self : SorthybriddropsortModel, i : Int, v : Double) -> SorthybriddropsortModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SorthybriddropsortModel::sum(self : SorthybriddropsortModel) -> Double { @_common.sum(self.data) }

pub fn SorthybriddropsortModel::mean(self : SorthybriddropsortModel) -> Double { @_common.mean(self.data) }

pub fn SorthybriddropsortModel::scale(self : SorthybriddropsortModel, f : Double) -> SorthybriddropsortModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SorthybriddropsortModel::add(self : SorthybriddropsortModel, other : SorthybriddropsortModel) -> SorthybriddropsortModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SorthybriddropsortModel::copy(self : SorthybriddropsortModel) -> SorthybriddropsortModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SorthybriddropsortModel::fill(self : SorthybriddropsortModel, v : Double) -> SorthybriddropsortModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SorthybriddropsortModel::min(self : SorthybriddropsortModel) -> Double { @_common.min(self.data) }

pub fn SorthybriddropsortModel::max(self : SorthybriddropsortModel) -> Double { @_common.max(self.data) }

pub fn SorthybriddropsortModel::to_string(self : SorthybriddropsortModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SorthybriddropsortLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_hybrid_dropsort_layer_make(size : Int) -> SorthybriddropsortLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SorthybriddropsortLayer::len(self : SorthybriddropsortLayer) -> Int { self.size }

pub fn SorthybriddropsortLayer::get(self : SorthybriddropsortLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SorthybriddropsortLayer::set(self : SorthybriddropsortLayer, i : Int, v : Double) -> SorthybriddropsortLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SorthybriddropsortLayer::sum(self : SorthybriddropsortLayer) -> Double { @_common.sum(self.data) }

pub fn SorthybriddropsortLayer::mean(self : SorthybriddropsortLayer) -> Double { @_common.mean(self.data) }

pub fn SorthybriddropsortLayer::scale(self : SorthybriddropsortLayer, f : Double) -> SorthybriddropsortLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SorthybriddropsortLayer::add(self : SorthybriddropsortLayer, other : SorthybriddropsortLayer) -> SorthybriddropsortLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SorthybriddropsortLayer::copy(self : SorthybriddropsortLayer) -> SorthybriddropsortLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SorthybriddropsortLayer::fill(self : SorthybriddropsortLayer, v : Double) -> SorthybriddropsortLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SorthybriddropsortLayer::min(self : SorthybriddropsortLayer) -> Double { @_common.min(self.data) }

pub fn SorthybriddropsortLayer::max(self : SorthybriddropsortLayer) -> Double { @_common.max(self.data) }

pub fn SorthybriddropsortLayer::to_string(self : SorthybriddropsortLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SorthybriddropsortBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_hybrid_dropsort_buffer_make(size : Int) -> SorthybriddropsortBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SorthybriddropsortBuffer::len(self : SorthybriddropsortBuffer) -> Int { self.size }

pub fn SorthybriddropsortBuffer::get(self : SorthybriddropsortBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SorthybriddropsortBuffer::set(self : SorthybriddropsortBuffer, i : Int, v : Double) -> SorthybriddropsortBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SorthybriddropsortBuffer::sum(self : SorthybriddropsortBuffer) -> Double { @_common.sum(self.data) }

pub fn SorthybriddropsortBuffer::mean(self : SorthybriddropsortBuffer) -> Double { @_common.mean(self.data) }

pub fn SorthybriddropsortBuffer::scale(self : SorthybriddropsortBuffer, f : Double) -> SorthybriddropsortBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SorthybriddropsortBuffer::add(self : SorthybriddropsortBuffer, other : SorthybriddropsortBuffer) -> SorthybriddropsortBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SorthybriddropsortBuffer::copy(self : SorthybriddropsortBuffer) -> SorthybriddropsortBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SorthybriddropsortBuffer::fill(self : SorthybriddropsortBuffer, v : Double) -> SorthybriddropsortBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SorthybriddropsortBuffer::min(self : SorthybriddropsortBuffer) -> Double { @_common.min(self.data) }

pub fn SorthybriddropsortBuffer::max(self : SorthybriddropsortBuffer) -> Double { @_common.max(self.data) }

pub fn SorthybriddropsortBuffer::to_string(self : SorthybriddropsortBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SorthybriddropsortCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_hybrid_dropsort_cursor_make(size : Int) -> SorthybriddropsortCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SorthybriddropsortCursor::len(self : SorthybriddropsortCursor) -> Int { self.size }

pub fn SorthybriddropsortCursor::get(self : SorthybriddropsortCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SorthybriddropsortCursor::set(self : SorthybriddropsortCursor, i : Int, v : Double) -> SorthybriddropsortCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SorthybriddropsortCursor::sum(self : SorthybriddropsortCursor) -> Double { @_common.sum(self.data) }

pub fn SorthybriddropsortCursor::mean(self : SorthybriddropsortCursor) -> Double { @_common.mean(self.data) }

pub fn SorthybriddropsortCursor::scale(self : SorthybriddropsortCursor, f : Double) -> SorthybriddropsortCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SorthybriddropsortCursor::add(self : SorthybriddropsortCursor, other : SorthybriddropsortCursor) -> SorthybriddropsortCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SorthybriddropsortCursor::copy(self : SorthybriddropsortCursor) -> SorthybriddropsortCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SorthybriddropsortCursor::fill(self : SorthybriddropsortCursor, v : Double) -> SorthybriddropsortCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SorthybriddropsortCursor::min(self : SorthybriddropsortCursor) -> Double { @_common.min(self.data) }

pub fn SorthybriddropsortCursor::max(self : SorthybriddropsortCursor) -> Double { @_common.max(self.data) }

pub fn SorthybriddropsortCursor::to_string(self : SorthybriddropsortCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SorthybriddropsortView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_hybrid_dropsort_view_make(size : Int) -> SorthybriddropsortView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SorthybriddropsortView::len(self : SorthybriddropsortView) -> Int { self.size }

pub fn SorthybriddropsortView::get(self : SorthybriddropsortView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SorthybriddropsortView::set(self : SorthybriddropsortView, i : Int, v : Double) -> SorthybriddropsortView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SorthybriddropsortView::sum(self : SorthybriddropsortView) -> Double { @_common.sum(self.data) }

pub fn SorthybriddropsortView::mean(self : SorthybriddropsortView) -> Double { @_common.mean(self.data) }

pub fn SorthybriddropsortView::scale(self : SorthybriddropsortView, f : Double) -> SorthybriddropsortView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SorthybriddropsortView::add(self : SorthybriddropsortView, other : SorthybriddropsortView) -> SorthybriddropsortView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SorthybriddropsortView::copy(self : SorthybriddropsortView) -> SorthybriddropsortView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SorthybriddropsortView::fill(self : SorthybriddropsortView, v : Double) -> SorthybriddropsortView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SorthybriddropsortView::min(self : SorthybriddropsortView) -> Double { @_common.min(self.data) }

pub fn SorthybriddropsortView::max(self : SorthybriddropsortView) -> Double { @_common.max(self.data) }

pub fn SorthybriddropsortView::to_string(self : SorthybriddropsortView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SorthybriddropsortRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_hybrid_dropsort_range_make(size : Int) -> SorthybriddropsortRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SorthybriddropsortRange::len(self : SorthybriddropsortRange) -> Int { self.size }

pub fn SorthybriddropsortRange::get(self : SorthybriddropsortRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SorthybriddropsortRange::set(self : SorthybriddropsortRange, i : Int, v : Double) -> SorthybriddropsortRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SorthybriddropsortRange::sum(self : SorthybriddropsortRange) -> Double { @_common.sum(self.data) }

pub fn SorthybriddropsortRange::mean(self : SorthybriddropsortRange) -> Double { @_common.mean(self.data) }

pub fn SorthybriddropsortRange::scale(self : SorthybriddropsortRange, f : Double) -> SorthybriddropsortRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SorthybriddropsortRange::add(self : SorthybriddropsortRange, other : SorthybriddropsortRange) -> SorthybriddropsortRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SorthybriddropsortRange::copy(self : SorthybriddropsortRange) -> SorthybriddropsortRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SorthybriddropsortRange::fill(self : SorthybriddropsortRange, v : Double) -> SorthybriddropsortRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SorthybriddropsortRange::min(self : SorthybriddropsortRange) -> Double { @_common.min(self.data) }

pub fn SorthybriddropsortRange::max(self : SorthybriddropsortRange) -> Double { @_common.max(self.data) }

pub fn SorthybriddropsortRange::to_string(self : SorthybriddropsortRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SorthybriddropsortSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_hybrid_dropsort_slice_make(size : Int) -> SorthybriddropsortSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SorthybriddropsortSlice::len(self : SorthybriddropsortSlice) -> Int { self.size }

pub fn SorthybriddropsortSlice::get(self : SorthybriddropsortSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SorthybriddropsortSlice::set(self : SorthybriddropsortSlice, i : Int, v : Double) -> SorthybriddropsortSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SorthybriddropsortSlice::sum(self : SorthybriddropsortSlice) -> Double { @_common.sum(self.data) }

pub fn SorthybriddropsortSlice::mean(self : SorthybriddropsortSlice) -> Double { @_common.mean(self.data) }

pub fn SorthybriddropsortSlice::scale(self : SorthybriddropsortSlice, f : Double) -> SorthybriddropsortSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SorthybriddropsortSlice::add(self : SorthybriddropsortSlice, other : SorthybriddropsortSlice) -> SorthybriddropsortSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SorthybriddropsortSlice::copy(self : SorthybriddropsortSlice) -> SorthybriddropsortSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SorthybriddropsortSlice::fill(self : SorthybriddropsortSlice, v : Double) -> SorthybriddropsortSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SorthybriddropsortSlice::min(self : SorthybriddropsortSlice) -> Double { @_common.min(self.data) }

pub fn SorthybriddropsortSlice::max(self : SorthybriddropsortSlice) -> Double { @_common.max(self.data) }

pub fn SorthybriddropsortSlice::to_string(self : SorthybriddropsortSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

