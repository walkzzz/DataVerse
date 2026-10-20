///===
/// extcore/sort_dist_counting

pub(all) struct SortdistcountingPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn sort_dist_counting_make_point(x : Double, y : Double) -> SortdistcountingPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn sort_dist_counting_make_point3(x : Double, y : Double, z : Double) -> SortdistcountingPoint {
  { x, y, z, label: 0 }
}

pub fn SortdistcountingPoint::x(self : SortdistcountingPoint) -> Double { self.x }

pub fn SortdistcountingPoint::y(self : SortdistcountingPoint) -> Double { self.y }

pub fn SortdistcountingPoint::z(self : SortdistcountingPoint) -> Double { self.z }

pub fn SortdistcountingPoint::label(self : SortdistcountingPoint) -> Int { self.label }

pub fn SortdistcountingPoint::dist(self : SortdistcountingPoint, other : SortdistcountingPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn SortdistcountingPoint::add(self : SortdistcountingPoint, other : SortdistcountingPoint) -> SortdistcountingPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn SortdistcountingPoint::sub(self : SortdistcountingPoint, other : SortdistcountingPoint) -> SortdistcountingPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn SortdistcountingPoint::scale(self : SortdistcountingPoint, s : Double) -> SortdistcountingPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn SortdistcountingPoint::dot(self : SortdistcountingPoint, other : SortdistcountingPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn SortdistcountingPoint::cross(self : SortdistcountingPoint, other : SortdistcountingPoint) -> SortdistcountingPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn SortdistcountingPoint::norm(self : SortdistcountingPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn SortdistcountingPoint::normalize(self : SortdistcountingPoint) -> SortdistcountingPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn SortdistcountingPoint::negate(self : SortdistcountingPoint) -> SortdistcountingPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn SortdistcountingPoint::mid(self : SortdistcountingPoint, other : SortdistcountingPoint) -> SortdistcountingPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn SortdistcountingPoint::lerp(self : SortdistcountingPoint, other : SortdistcountingPoint, t : Double) -> SortdistcountingPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn SortdistcountingPoint::to_string(self : SortdistcountingPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct SortdistcountingSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn sort_dist_counting_make_series(vals : Array[Double], name : String) -> SortdistcountingSeries {
  { vals, name, meta: 0 }
}

pub fn SortdistcountingSeries::len(self : SortdistcountingSeries) -> Int { self.vals.length() }

pub fn SortdistcountingSeries::sum(self : SortdistcountingSeries) -> Double { @_common.sum(self.vals) }

pub fn SortdistcountingSeries::mean(self : SortdistcountingSeries) -> Double { @_common.mean(self.vals) }

pub fn SortdistcountingSeries::min(self : SortdistcountingSeries) -> Double { @_common.min(self.vals) }

pub fn SortdistcountingSeries::max(self : SortdistcountingSeries) -> Double { @_common.max(self.vals) }

pub fn SortdistcountingSeries::range(self : SortdistcountingSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn SortdistcountingSeries::variance(self : SortdistcountingSeries) -> Double { @_common.variance(self.vals) }

pub fn SortdistcountingSeries::std(self : SortdistcountingSeries) -> Double { @_common.std(self.vals) }

pub fn SortdistcountingSeries::median(self : SortdistcountingSeries) -> Double { @_common.median(self.vals) }

pub fn SortdistcountingSeries::scale(self : SortdistcountingSeries, f : Double) -> SortdistcountingSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn SortdistcountingSeries::add(self : SortdistcountingSeries, other : SortdistcountingSeries) -> SortdistcountingSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn SortdistcountingSeries::sub(self : SortdistcountingSeries, other : SortdistcountingSeries) -> SortdistcountingSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn SortdistcountingSeries::normalize(self : SortdistcountingSeries) -> SortdistcountingSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn SortdistcountingSeries::cumsum(self : SortdistcountingSeries) -> SortdistcountingSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn SortdistcountingSeries::to_string(self : SortdistcountingSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct SortdistcountingMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn sort_dist_counting_make_matrix(rows : Int, cols : Int, val : Double) -> SortdistcountingMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn sort_dist_counting_matrix_identity(n : Int) -> SortdistcountingMatrix {
  let m = sort_dist_counting_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn SortdistcountingMatrix::get(self : SortdistcountingMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn SortdistcountingMatrix::transpose(self : SortdistcountingMatrix) -> SortdistcountingMatrix {
  let result = sort_dist_counting_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn SortdistcountingMatrix::add(self : SortdistcountingMatrix, other : SortdistcountingMatrix) -> SortdistcountingMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = sort_dist_counting_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn SortdistcountingMatrix::scale(self : SortdistcountingMatrix, s : Double) -> SortdistcountingMatrix {
  let result = sort_dist_counting_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn SortdistcountingMatrix::multiply(self : SortdistcountingMatrix, other : SortdistcountingMatrix) -> SortdistcountingMatrix {
  if self.cols != other.rows { return sort_dist_counting_make_matrix(self.rows, other.cols, 0.0) }
  let result = sort_dist_counting_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn SortdistcountingMatrix::trace(self : SortdistcountingMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn SortdistcountingMatrix::det(self : SortdistcountingMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn SortdistcountingMatrix::norm(self : SortdistcountingMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn SortdistcountingMatrix::to_string(self : SortdistcountingMatrix) -> String {
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

pub(all) struct SortdistcountingVector {
  comps : Array[Double]
  dim : Int
}

pub fn sort_dist_counting_make_vector(comps : Array[Double]) -> SortdistcountingVector {
  { comps, dim: comps.length() }
}

pub fn sort_dist_counting_vector_zero(dim : Int) -> SortdistcountingVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn SortdistcountingVector::add(self : SortdistcountingVector, other : SortdistcountingVector) -> SortdistcountingVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn SortdistcountingVector::sub(self : SortdistcountingVector, other : SortdistcountingVector) -> SortdistcountingVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn SortdistcountingVector::scale(self : SortdistcountingVector, s : Double) -> SortdistcountingVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn SortdistcountingVector::dot(self : SortdistcountingVector, other : SortdistcountingVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn SortdistcountingVector::norm(self : SortdistcountingVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn SortdistcountingVector::normalize(self : SortdistcountingVector) -> SortdistcountingVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn SortdistcountingVector::dist(self : SortdistcountingVector, other : SortdistcountingVector) -> Double {
  self.sub(other).norm()
}

pub fn SortdistcountingVector::to_string(self : SortdistcountingVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn sort_dist_counting_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn sort_dist_counting_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn sort_dist_counting_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn sort_dist_counting_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn sort_dist_counting_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn sort_dist_counting_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn sort_dist_counting_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn sort_dist_counting_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn sort_dist_counting_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn sort_dist_counting_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn sort_dist_counting_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn sort_dist_counting_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn sort_dist_counting_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn sort_dist_counting_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn sort_dist_counting_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn sort_dist_counting_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn sort_dist_counting_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn sort_dist_counting_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn sort_dist_counting_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn sort_dist_counting_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn sort_dist_counting_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn sort_dist_counting_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn sort_dist_counting_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn sort_dist_counting_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn sort_dist_counting_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn sort_dist_counting_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn sort_dist_counting_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn sort_dist_counting_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn sort_dist_counting_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct SortdistcountingFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_dist_counting_frame_make(size : Int) -> SortdistcountingFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SortdistcountingFrame::len(self : SortdistcountingFrame) -> Int { self.size }

pub fn SortdistcountingFrame::get(self : SortdistcountingFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SortdistcountingFrame::set(self : SortdistcountingFrame, i : Int, v : Double) -> SortdistcountingFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SortdistcountingFrame::sum(self : SortdistcountingFrame) -> Double { @_common.sum(self.data) }

pub fn SortdistcountingFrame::mean(self : SortdistcountingFrame) -> Double { @_common.mean(self.data) }

pub fn SortdistcountingFrame::scale(self : SortdistcountingFrame, f : Double) -> SortdistcountingFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SortdistcountingFrame::add(self : SortdistcountingFrame, other : SortdistcountingFrame) -> SortdistcountingFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SortdistcountingFrame::copy(self : SortdistcountingFrame) -> SortdistcountingFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SortdistcountingFrame::fill(self : SortdistcountingFrame, v : Double) -> SortdistcountingFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SortdistcountingFrame::min(self : SortdistcountingFrame) -> Double { @_common.min(self.data) }

pub fn SortdistcountingFrame::max(self : SortdistcountingFrame) -> Double { @_common.max(self.data) }

pub fn SortdistcountingFrame::to_string(self : SortdistcountingFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SortdistcountingTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_dist_counting_table_make(size : Int) -> SortdistcountingTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SortdistcountingTable::len(self : SortdistcountingTable) -> Int { self.size }

pub fn SortdistcountingTable::get(self : SortdistcountingTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SortdistcountingTable::set(self : SortdistcountingTable, i : Int, v : Double) -> SortdistcountingTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SortdistcountingTable::sum(self : SortdistcountingTable) -> Double { @_common.sum(self.data) }

pub fn SortdistcountingTable::mean(self : SortdistcountingTable) -> Double { @_common.mean(self.data) }

pub fn SortdistcountingTable::scale(self : SortdistcountingTable, f : Double) -> SortdistcountingTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SortdistcountingTable::add(self : SortdistcountingTable, other : SortdistcountingTable) -> SortdistcountingTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SortdistcountingTable::copy(self : SortdistcountingTable) -> SortdistcountingTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SortdistcountingTable::fill(self : SortdistcountingTable, v : Double) -> SortdistcountingTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SortdistcountingTable::min(self : SortdistcountingTable) -> Double { @_common.min(self.data) }

pub fn SortdistcountingTable::max(self : SortdistcountingTable) -> Double { @_common.max(self.data) }

pub fn SortdistcountingTable::to_string(self : SortdistcountingTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SortdistcountingGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_dist_counting_graphn_make(size : Int) -> SortdistcountingGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SortdistcountingGraphN::len(self : SortdistcountingGraphN) -> Int { self.size }

pub fn SortdistcountingGraphN::get(self : SortdistcountingGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SortdistcountingGraphN::set(self : SortdistcountingGraphN, i : Int, v : Double) -> SortdistcountingGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SortdistcountingGraphN::sum(self : SortdistcountingGraphN) -> Double { @_common.sum(self.data) }

pub fn SortdistcountingGraphN::mean(self : SortdistcountingGraphN) -> Double { @_common.mean(self.data) }

pub fn SortdistcountingGraphN::scale(self : SortdistcountingGraphN, f : Double) -> SortdistcountingGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SortdistcountingGraphN::add(self : SortdistcountingGraphN, other : SortdistcountingGraphN) -> SortdistcountingGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SortdistcountingGraphN::copy(self : SortdistcountingGraphN) -> SortdistcountingGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SortdistcountingGraphN::fill(self : SortdistcountingGraphN, v : Double) -> SortdistcountingGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SortdistcountingGraphN::min(self : SortdistcountingGraphN) -> Double { @_common.min(self.data) }

pub fn SortdistcountingGraphN::max(self : SortdistcountingGraphN) -> Double { @_common.max(self.data) }

pub fn SortdistcountingGraphN::to_string(self : SortdistcountingGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SortdistcountingNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_dist_counting_node_make(size : Int) -> SortdistcountingNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SortdistcountingNode::len(self : SortdistcountingNode) -> Int { self.size }

pub fn SortdistcountingNode::get(self : SortdistcountingNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SortdistcountingNode::set(self : SortdistcountingNode, i : Int, v : Double) -> SortdistcountingNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SortdistcountingNode::sum(self : SortdistcountingNode) -> Double { @_common.sum(self.data) }

pub fn SortdistcountingNode::mean(self : SortdistcountingNode) -> Double { @_common.mean(self.data) }

pub fn SortdistcountingNode::scale(self : SortdistcountingNode, f : Double) -> SortdistcountingNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SortdistcountingNode::add(self : SortdistcountingNode, other : SortdistcountingNode) -> SortdistcountingNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SortdistcountingNode::copy(self : SortdistcountingNode) -> SortdistcountingNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SortdistcountingNode::fill(self : SortdistcountingNode, v : Double) -> SortdistcountingNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SortdistcountingNode::min(self : SortdistcountingNode) -> Double { @_common.min(self.data) }

pub fn SortdistcountingNode::max(self : SortdistcountingNode) -> Double { @_common.max(self.data) }

pub fn SortdistcountingNode::to_string(self : SortdistcountingNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SortdistcountingEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_dist_counting_edge_make(size : Int) -> SortdistcountingEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SortdistcountingEdge::len(self : SortdistcountingEdge) -> Int { self.size }

pub fn SortdistcountingEdge::get(self : SortdistcountingEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SortdistcountingEdge::set(self : SortdistcountingEdge, i : Int, v : Double) -> SortdistcountingEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SortdistcountingEdge::sum(self : SortdistcountingEdge) -> Double { @_common.sum(self.data) }

pub fn SortdistcountingEdge::mean(self : SortdistcountingEdge) -> Double { @_common.mean(self.data) }

pub fn SortdistcountingEdge::scale(self : SortdistcountingEdge, f : Double) -> SortdistcountingEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SortdistcountingEdge::add(self : SortdistcountingEdge, other : SortdistcountingEdge) -> SortdistcountingEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SortdistcountingEdge::copy(self : SortdistcountingEdge) -> SortdistcountingEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SortdistcountingEdge::fill(self : SortdistcountingEdge, v : Double) -> SortdistcountingEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SortdistcountingEdge::min(self : SortdistcountingEdge) -> Double { @_common.min(self.data) }

pub fn SortdistcountingEdge::max(self : SortdistcountingEdge) -> Double { @_common.max(self.data) }

pub fn SortdistcountingEdge::to_string(self : SortdistcountingEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SortdistcountingPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_dist_counting_path_make(size : Int) -> SortdistcountingPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SortdistcountingPath::len(self : SortdistcountingPath) -> Int { self.size }

pub fn SortdistcountingPath::get(self : SortdistcountingPath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SortdistcountingPath::set(self : SortdistcountingPath, i : Int, v : Double) -> SortdistcountingPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SortdistcountingPath::sum(self : SortdistcountingPath) -> Double { @_common.sum(self.data) }

pub fn SortdistcountingPath::mean(self : SortdistcountingPath) -> Double { @_common.mean(self.data) }

pub fn SortdistcountingPath::scale(self : SortdistcountingPath, f : Double) -> SortdistcountingPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SortdistcountingPath::add(self : SortdistcountingPath, other : SortdistcountingPath) -> SortdistcountingPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SortdistcountingPath::copy(self : SortdistcountingPath) -> SortdistcountingPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SortdistcountingPath::fill(self : SortdistcountingPath, v : Double) -> SortdistcountingPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SortdistcountingPath::min(self : SortdistcountingPath) -> Double { @_common.min(self.data) }

pub fn SortdistcountingPath::max(self : SortdistcountingPath) -> Double { @_common.max(self.data) }

pub fn SortdistcountingPath::to_string(self : SortdistcountingPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SortdistcountingCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_dist_counting_cluster_make(size : Int) -> SortdistcountingCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SortdistcountingCluster::len(self : SortdistcountingCluster) -> Int { self.size }

pub fn SortdistcountingCluster::get(self : SortdistcountingCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SortdistcountingCluster::set(self : SortdistcountingCluster, i : Int, v : Double) -> SortdistcountingCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SortdistcountingCluster::sum(self : SortdistcountingCluster) -> Double { @_common.sum(self.data) }

pub fn SortdistcountingCluster::mean(self : SortdistcountingCluster) -> Double { @_common.mean(self.data) }

pub fn SortdistcountingCluster::scale(self : SortdistcountingCluster, f : Double) -> SortdistcountingCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SortdistcountingCluster::add(self : SortdistcountingCluster, other : SortdistcountingCluster) -> SortdistcountingCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SortdistcountingCluster::copy(self : SortdistcountingCluster) -> SortdistcountingCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SortdistcountingCluster::fill(self : SortdistcountingCluster, v : Double) -> SortdistcountingCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SortdistcountingCluster::min(self : SortdistcountingCluster) -> Double { @_common.min(self.data) }

pub fn SortdistcountingCluster::max(self : SortdistcountingCluster) -> Double { @_common.max(self.data) }

pub fn SortdistcountingCluster::to_string(self : SortdistcountingCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SortdistcountingModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_dist_counting_model_make(size : Int) -> SortdistcountingModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SortdistcountingModel::len(self : SortdistcountingModel) -> Int { self.size }

pub fn SortdistcountingModel::get(self : SortdistcountingModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SortdistcountingModel::set(self : SortdistcountingModel, i : Int, v : Double) -> SortdistcountingModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SortdistcountingModel::sum(self : SortdistcountingModel) -> Double { @_common.sum(self.data) }

pub fn SortdistcountingModel::mean(self : SortdistcountingModel) -> Double { @_common.mean(self.data) }

pub fn SortdistcountingModel::scale(self : SortdistcountingModel, f : Double) -> SortdistcountingModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SortdistcountingModel::add(self : SortdistcountingModel, other : SortdistcountingModel) -> SortdistcountingModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SortdistcountingModel::copy(self : SortdistcountingModel) -> SortdistcountingModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SortdistcountingModel::fill(self : SortdistcountingModel, v : Double) -> SortdistcountingModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SortdistcountingModel::min(self : SortdistcountingModel) -> Double { @_common.min(self.data) }

pub fn SortdistcountingModel::max(self : SortdistcountingModel) -> Double { @_common.max(self.data) }

pub fn SortdistcountingModel::to_string(self : SortdistcountingModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SortdistcountingLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_dist_counting_layer_make(size : Int) -> SortdistcountingLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SortdistcountingLayer::len(self : SortdistcountingLayer) -> Int { self.size }

pub fn SortdistcountingLayer::get(self : SortdistcountingLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SortdistcountingLayer::set(self : SortdistcountingLayer, i : Int, v : Double) -> SortdistcountingLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SortdistcountingLayer::sum(self : SortdistcountingLayer) -> Double { @_common.sum(self.data) }

pub fn SortdistcountingLayer::mean(self : SortdistcountingLayer) -> Double { @_common.mean(self.data) }

pub fn SortdistcountingLayer::scale(self : SortdistcountingLayer, f : Double) -> SortdistcountingLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SortdistcountingLayer::add(self : SortdistcountingLayer, other : SortdistcountingLayer) -> SortdistcountingLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SortdistcountingLayer::copy(self : SortdistcountingLayer) -> SortdistcountingLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SortdistcountingLayer::fill(self : SortdistcountingLayer, v : Double) -> SortdistcountingLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SortdistcountingLayer::min(self : SortdistcountingLayer) -> Double { @_common.min(self.data) }

pub fn SortdistcountingLayer::max(self : SortdistcountingLayer) -> Double { @_common.max(self.data) }

pub fn SortdistcountingLayer::to_string(self : SortdistcountingLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SortdistcountingBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_dist_counting_buffer_make(size : Int) -> SortdistcountingBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SortdistcountingBuffer::len(self : SortdistcountingBuffer) -> Int { self.size }

pub fn SortdistcountingBuffer::get(self : SortdistcountingBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SortdistcountingBuffer::set(self : SortdistcountingBuffer, i : Int, v : Double) -> SortdistcountingBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SortdistcountingBuffer::sum(self : SortdistcountingBuffer) -> Double { @_common.sum(self.data) }

pub fn SortdistcountingBuffer::mean(self : SortdistcountingBuffer) -> Double { @_common.mean(self.data) }

pub fn SortdistcountingBuffer::scale(self : SortdistcountingBuffer, f : Double) -> SortdistcountingBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SortdistcountingBuffer::add(self : SortdistcountingBuffer, other : SortdistcountingBuffer) -> SortdistcountingBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SortdistcountingBuffer::copy(self : SortdistcountingBuffer) -> SortdistcountingBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SortdistcountingBuffer::fill(self : SortdistcountingBuffer, v : Double) -> SortdistcountingBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SortdistcountingBuffer::min(self : SortdistcountingBuffer) -> Double { @_common.min(self.data) }

pub fn SortdistcountingBuffer::max(self : SortdistcountingBuffer) -> Double { @_common.max(self.data) }

pub fn SortdistcountingBuffer::to_string(self : SortdistcountingBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SortdistcountingCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_dist_counting_cursor_make(size : Int) -> SortdistcountingCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SortdistcountingCursor::len(self : SortdistcountingCursor) -> Int { self.size }

pub fn SortdistcountingCursor::get(self : SortdistcountingCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SortdistcountingCursor::set(self : SortdistcountingCursor, i : Int, v : Double) -> SortdistcountingCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SortdistcountingCursor::sum(self : SortdistcountingCursor) -> Double { @_common.sum(self.data) }

pub fn SortdistcountingCursor::mean(self : SortdistcountingCursor) -> Double { @_common.mean(self.data) }

pub fn SortdistcountingCursor::scale(self : SortdistcountingCursor, f : Double) -> SortdistcountingCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SortdistcountingCursor::add(self : SortdistcountingCursor, other : SortdistcountingCursor) -> SortdistcountingCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SortdistcountingCursor::copy(self : SortdistcountingCursor) -> SortdistcountingCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SortdistcountingCursor::fill(self : SortdistcountingCursor, v : Double) -> SortdistcountingCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SortdistcountingCursor::min(self : SortdistcountingCursor) -> Double { @_common.min(self.data) }

pub fn SortdistcountingCursor::max(self : SortdistcountingCursor) -> Double { @_common.max(self.data) }

pub fn SortdistcountingCursor::to_string(self : SortdistcountingCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SortdistcountingView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_dist_counting_view_make(size : Int) -> SortdistcountingView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SortdistcountingView::len(self : SortdistcountingView) -> Int { self.size }

pub fn SortdistcountingView::get(self : SortdistcountingView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SortdistcountingView::set(self : SortdistcountingView, i : Int, v : Double) -> SortdistcountingView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SortdistcountingView::sum(self : SortdistcountingView) -> Double { @_common.sum(self.data) }

pub fn SortdistcountingView::mean(self : SortdistcountingView) -> Double { @_common.mean(self.data) }

pub fn SortdistcountingView::scale(self : SortdistcountingView, f : Double) -> SortdistcountingView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SortdistcountingView::add(self : SortdistcountingView, other : SortdistcountingView) -> SortdistcountingView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SortdistcountingView::copy(self : SortdistcountingView) -> SortdistcountingView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SortdistcountingView::fill(self : SortdistcountingView, v : Double) -> SortdistcountingView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SortdistcountingView::min(self : SortdistcountingView) -> Double { @_common.min(self.data) }

pub fn SortdistcountingView::max(self : SortdistcountingView) -> Double { @_common.max(self.data) }

pub fn SortdistcountingView::to_string(self : SortdistcountingView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SortdistcountingRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_dist_counting_range_make(size : Int) -> SortdistcountingRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SortdistcountingRange::len(self : SortdistcountingRange) -> Int { self.size }

pub fn SortdistcountingRange::get(self : SortdistcountingRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SortdistcountingRange::set(self : SortdistcountingRange, i : Int, v : Double) -> SortdistcountingRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SortdistcountingRange::sum(self : SortdistcountingRange) -> Double { @_common.sum(self.data) }

pub fn SortdistcountingRange::mean(self : SortdistcountingRange) -> Double { @_common.mean(self.data) }

pub fn SortdistcountingRange::scale(self : SortdistcountingRange, f : Double) -> SortdistcountingRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SortdistcountingRange::add(self : SortdistcountingRange, other : SortdistcountingRange) -> SortdistcountingRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SortdistcountingRange::copy(self : SortdistcountingRange) -> SortdistcountingRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SortdistcountingRange::fill(self : SortdistcountingRange, v : Double) -> SortdistcountingRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SortdistcountingRange::min(self : SortdistcountingRange) -> Double { @_common.min(self.data) }

pub fn SortdistcountingRange::max(self : SortdistcountingRange) -> Double { @_common.max(self.data) }

pub fn SortdistcountingRange::to_string(self : SortdistcountingRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SortdistcountingSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_dist_counting_slice_make(size : Int) -> SortdistcountingSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SortdistcountingSlice::len(self : SortdistcountingSlice) -> Int { self.size }

pub fn SortdistcountingSlice::get(self : SortdistcountingSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SortdistcountingSlice::set(self : SortdistcountingSlice, i : Int, v : Double) -> SortdistcountingSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SortdistcountingSlice::sum(self : SortdistcountingSlice) -> Double { @_common.sum(self.data) }

pub fn SortdistcountingSlice::mean(self : SortdistcountingSlice) -> Double { @_common.mean(self.data) }

pub fn SortdistcountingSlice::scale(self : SortdistcountingSlice, f : Double) -> SortdistcountingSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SortdistcountingSlice::add(self : SortdistcountingSlice, other : SortdistcountingSlice) -> SortdistcountingSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SortdistcountingSlice::copy(self : SortdistcountingSlice) -> SortdistcountingSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SortdistcountingSlice::fill(self : SortdistcountingSlice, v : Double) -> SortdistcountingSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SortdistcountingSlice::min(self : SortdistcountingSlice) -> Double { @_common.min(self.data) }

pub fn SortdistcountingSlice::max(self : SortdistcountingSlice) -> Double { @_common.max(self.data) }

pub fn SortdistcountingSlice::to_string(self : SortdistcountingSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

