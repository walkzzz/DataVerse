///===
/// extcore/sort_dist_parallel

pub(all) struct SortdistparallelPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn sort_dist_parallel_make_point(x : Double, y : Double) -> SortdistparallelPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn sort_dist_parallel_make_point3(x : Double, y : Double, z : Double) -> SortdistparallelPoint {
  { x, y, z, label: 0 }
}

pub fn SortdistparallelPoint::x(self : SortdistparallelPoint) -> Double { self.x }

pub fn SortdistparallelPoint::y(self : SortdistparallelPoint) -> Double { self.y }

pub fn SortdistparallelPoint::z(self : SortdistparallelPoint) -> Double { self.z }

pub fn SortdistparallelPoint::label(self : SortdistparallelPoint) -> Int { self.label }

pub fn SortdistparallelPoint::dist(self : SortdistparallelPoint, other : SortdistparallelPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn SortdistparallelPoint::add(self : SortdistparallelPoint, other : SortdistparallelPoint) -> SortdistparallelPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn SortdistparallelPoint::sub(self : SortdistparallelPoint, other : SortdistparallelPoint) -> SortdistparallelPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn SortdistparallelPoint::scale(self : SortdistparallelPoint, s : Double) -> SortdistparallelPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn SortdistparallelPoint::dot(self : SortdistparallelPoint, other : SortdistparallelPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn SortdistparallelPoint::cross(self : SortdistparallelPoint, other : SortdistparallelPoint) -> SortdistparallelPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn SortdistparallelPoint::norm(self : SortdistparallelPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn SortdistparallelPoint::normalize(self : SortdistparallelPoint) -> SortdistparallelPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn SortdistparallelPoint::negate(self : SortdistparallelPoint) -> SortdistparallelPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn SortdistparallelPoint::mid(self : SortdistparallelPoint, other : SortdistparallelPoint) -> SortdistparallelPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn SortdistparallelPoint::lerp(self : SortdistparallelPoint, other : SortdistparallelPoint, t : Double) -> SortdistparallelPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn SortdistparallelPoint::to_string(self : SortdistparallelPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct SortdistparallelSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn sort_dist_parallel_make_series(vals : Array[Double], name : String) -> SortdistparallelSeries {
  { vals, name, meta: 0 }
}

pub fn SortdistparallelSeries::len(self : SortdistparallelSeries) -> Int { self.vals.length() }

pub fn SortdistparallelSeries::sum(self : SortdistparallelSeries) -> Double { @_common.sum(self.vals) }

pub fn SortdistparallelSeries::mean(self : SortdistparallelSeries) -> Double { @_common.mean(self.vals) }

pub fn SortdistparallelSeries::min(self : SortdistparallelSeries) -> Double { @_common.min(self.vals) }

pub fn SortdistparallelSeries::max(self : SortdistparallelSeries) -> Double { @_common.max(self.vals) }

pub fn SortdistparallelSeries::range(self : SortdistparallelSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn SortdistparallelSeries::variance(self : SortdistparallelSeries) -> Double { @_common.variance(self.vals) }

pub fn SortdistparallelSeries::std(self : SortdistparallelSeries) -> Double { @_common.std(self.vals) }

pub fn SortdistparallelSeries::median(self : SortdistparallelSeries) -> Double { @_common.median(self.vals) }

pub fn SortdistparallelSeries::scale(self : SortdistparallelSeries, f : Double) -> SortdistparallelSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn SortdistparallelSeries::add(self : SortdistparallelSeries, other : SortdistparallelSeries) -> SortdistparallelSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn SortdistparallelSeries::sub(self : SortdistparallelSeries, other : SortdistparallelSeries) -> SortdistparallelSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn SortdistparallelSeries::normalize(self : SortdistparallelSeries) -> SortdistparallelSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn SortdistparallelSeries::cumsum(self : SortdistparallelSeries) -> SortdistparallelSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn SortdistparallelSeries::to_string(self : SortdistparallelSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct SortdistparallelMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn sort_dist_parallel_make_matrix(rows : Int, cols : Int, val : Double) -> SortdistparallelMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn sort_dist_parallel_matrix_identity(n : Int) -> SortdistparallelMatrix {
  let m = sort_dist_parallel_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn SortdistparallelMatrix::get(self : SortdistparallelMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn SortdistparallelMatrix::transpose(self : SortdistparallelMatrix) -> SortdistparallelMatrix {
  let result = sort_dist_parallel_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn SortdistparallelMatrix::add(self : SortdistparallelMatrix, other : SortdistparallelMatrix) -> SortdistparallelMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = sort_dist_parallel_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn SortdistparallelMatrix::scale(self : SortdistparallelMatrix, s : Double) -> SortdistparallelMatrix {
  let result = sort_dist_parallel_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn SortdistparallelMatrix::multiply(self : SortdistparallelMatrix, other : SortdistparallelMatrix) -> SortdistparallelMatrix {
  if self.cols != other.rows { return sort_dist_parallel_make_matrix(self.rows, other.cols, 0.0) }
  let result = sort_dist_parallel_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn SortdistparallelMatrix::trace(self : SortdistparallelMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn SortdistparallelMatrix::det(self : SortdistparallelMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn SortdistparallelMatrix::norm(self : SortdistparallelMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn SortdistparallelMatrix::to_string(self : SortdistparallelMatrix) -> String {
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

pub(all) struct SortdistparallelVector {
  comps : Array[Double]
  dim : Int
}

pub fn sort_dist_parallel_make_vector(comps : Array[Double]) -> SortdistparallelVector {
  { comps, dim: comps.length() }
}

pub fn sort_dist_parallel_vector_zero(dim : Int) -> SortdistparallelVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn SortdistparallelVector::add(self : SortdistparallelVector, other : SortdistparallelVector) -> SortdistparallelVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn SortdistparallelVector::sub(self : SortdistparallelVector, other : SortdistparallelVector) -> SortdistparallelVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn SortdistparallelVector::scale(self : SortdistparallelVector, s : Double) -> SortdistparallelVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn SortdistparallelVector::dot(self : SortdistparallelVector, other : SortdistparallelVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn SortdistparallelVector::norm(self : SortdistparallelVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn SortdistparallelVector::normalize(self : SortdistparallelVector) -> SortdistparallelVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn SortdistparallelVector::dist(self : SortdistparallelVector, other : SortdistparallelVector) -> Double {
  self.sub(other).norm()
}

pub fn SortdistparallelVector::to_string(self : SortdistparallelVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn sort_dist_parallel_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn sort_dist_parallel_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn sort_dist_parallel_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn sort_dist_parallel_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn sort_dist_parallel_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn sort_dist_parallel_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn sort_dist_parallel_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn sort_dist_parallel_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn sort_dist_parallel_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn sort_dist_parallel_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn sort_dist_parallel_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn sort_dist_parallel_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn sort_dist_parallel_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn sort_dist_parallel_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn sort_dist_parallel_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn sort_dist_parallel_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn sort_dist_parallel_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn sort_dist_parallel_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn sort_dist_parallel_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn sort_dist_parallel_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn sort_dist_parallel_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn sort_dist_parallel_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn sort_dist_parallel_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn sort_dist_parallel_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn sort_dist_parallel_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn sort_dist_parallel_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn sort_dist_parallel_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn sort_dist_parallel_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn sort_dist_parallel_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct SortdistparallelFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_dist_parallel_frame_make(size : Int) -> SortdistparallelFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SortdistparallelFrame::len(self : SortdistparallelFrame) -> Int { self.size }

pub fn SortdistparallelFrame::get(self : SortdistparallelFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SortdistparallelFrame::set(self : SortdistparallelFrame, i : Int, v : Double) -> SortdistparallelFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SortdistparallelFrame::sum(self : SortdistparallelFrame) -> Double { @_common.sum(self.data) }

pub fn SortdistparallelFrame::mean(self : SortdistparallelFrame) -> Double { @_common.mean(self.data) }

pub fn SortdistparallelFrame::scale(self : SortdistparallelFrame, f : Double) -> SortdistparallelFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SortdistparallelFrame::add(self : SortdistparallelFrame, other : SortdistparallelFrame) -> SortdistparallelFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SortdistparallelFrame::copy(self : SortdistparallelFrame) -> SortdistparallelFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SortdistparallelFrame::fill(self : SortdistparallelFrame, v : Double) -> SortdistparallelFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SortdistparallelFrame::min(self : SortdistparallelFrame) -> Double { @_common.min(self.data) }

pub fn SortdistparallelFrame::max(self : SortdistparallelFrame) -> Double { @_common.max(self.data) }

pub fn SortdistparallelFrame::to_string(self : SortdistparallelFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SortdistparallelTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_dist_parallel_table_make(size : Int) -> SortdistparallelTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SortdistparallelTable::len(self : SortdistparallelTable) -> Int { self.size }

pub fn SortdistparallelTable::get(self : SortdistparallelTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SortdistparallelTable::set(self : SortdistparallelTable, i : Int, v : Double) -> SortdistparallelTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SortdistparallelTable::sum(self : SortdistparallelTable) -> Double { @_common.sum(self.data) }

pub fn SortdistparallelTable::mean(self : SortdistparallelTable) -> Double { @_common.mean(self.data) }

pub fn SortdistparallelTable::scale(self : SortdistparallelTable, f : Double) -> SortdistparallelTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SortdistparallelTable::add(self : SortdistparallelTable, other : SortdistparallelTable) -> SortdistparallelTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SortdistparallelTable::copy(self : SortdistparallelTable) -> SortdistparallelTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SortdistparallelTable::fill(self : SortdistparallelTable, v : Double) -> SortdistparallelTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SortdistparallelTable::min(self : SortdistparallelTable) -> Double { @_common.min(self.data) }

pub fn SortdistparallelTable::max(self : SortdistparallelTable) -> Double { @_common.max(self.data) }

pub fn SortdistparallelTable::to_string(self : SortdistparallelTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SortdistparallelGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_dist_parallel_graphn_make(size : Int) -> SortdistparallelGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SortdistparallelGraphN::len(self : SortdistparallelGraphN) -> Int { self.size }

pub fn SortdistparallelGraphN::get(self : SortdistparallelGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SortdistparallelGraphN::set(self : SortdistparallelGraphN, i : Int, v : Double) -> SortdistparallelGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SortdistparallelGraphN::sum(self : SortdistparallelGraphN) -> Double { @_common.sum(self.data) }

pub fn SortdistparallelGraphN::mean(self : SortdistparallelGraphN) -> Double { @_common.mean(self.data) }

pub fn SortdistparallelGraphN::scale(self : SortdistparallelGraphN, f : Double) -> SortdistparallelGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SortdistparallelGraphN::add(self : SortdistparallelGraphN, other : SortdistparallelGraphN) -> SortdistparallelGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SortdistparallelGraphN::copy(self : SortdistparallelGraphN) -> SortdistparallelGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SortdistparallelGraphN::fill(self : SortdistparallelGraphN, v : Double) -> SortdistparallelGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SortdistparallelGraphN::min(self : SortdistparallelGraphN) -> Double { @_common.min(self.data) }

pub fn SortdistparallelGraphN::max(self : SortdistparallelGraphN) -> Double { @_common.max(self.data) }

pub fn SortdistparallelGraphN::to_string(self : SortdistparallelGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SortdistparallelNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_dist_parallel_node_make(size : Int) -> SortdistparallelNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SortdistparallelNode::len(self : SortdistparallelNode) -> Int { self.size }

pub fn SortdistparallelNode::get(self : SortdistparallelNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SortdistparallelNode::set(self : SortdistparallelNode, i : Int, v : Double) -> SortdistparallelNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SortdistparallelNode::sum(self : SortdistparallelNode) -> Double { @_common.sum(self.data) }

pub fn SortdistparallelNode::mean(self : SortdistparallelNode) -> Double { @_common.mean(self.data) }

pub fn SortdistparallelNode::scale(self : SortdistparallelNode, f : Double) -> SortdistparallelNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SortdistparallelNode::add(self : SortdistparallelNode, other : SortdistparallelNode) -> SortdistparallelNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SortdistparallelNode::copy(self : SortdistparallelNode) -> SortdistparallelNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SortdistparallelNode::fill(self : SortdistparallelNode, v : Double) -> SortdistparallelNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SortdistparallelNode::min(self : SortdistparallelNode) -> Double { @_common.min(self.data) }

pub fn SortdistparallelNode::max(self : SortdistparallelNode) -> Double { @_common.max(self.data) }

pub fn SortdistparallelNode::to_string(self : SortdistparallelNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SortdistparallelEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_dist_parallel_edge_make(size : Int) -> SortdistparallelEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SortdistparallelEdge::len(self : SortdistparallelEdge) -> Int { self.size }

pub fn SortdistparallelEdge::get(self : SortdistparallelEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SortdistparallelEdge::set(self : SortdistparallelEdge, i : Int, v : Double) -> SortdistparallelEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SortdistparallelEdge::sum(self : SortdistparallelEdge) -> Double { @_common.sum(self.data) }

pub fn SortdistparallelEdge::mean(self : SortdistparallelEdge) -> Double { @_common.mean(self.data) }

pub fn SortdistparallelEdge::scale(self : SortdistparallelEdge, f : Double) -> SortdistparallelEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SortdistparallelEdge::add(self : SortdistparallelEdge, other : SortdistparallelEdge) -> SortdistparallelEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SortdistparallelEdge::copy(self : SortdistparallelEdge) -> SortdistparallelEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SortdistparallelEdge::fill(self : SortdistparallelEdge, v : Double) -> SortdistparallelEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SortdistparallelEdge::min(self : SortdistparallelEdge) -> Double { @_common.min(self.data) }

pub fn SortdistparallelEdge::max(self : SortdistparallelEdge) -> Double { @_common.max(self.data) }

pub fn SortdistparallelEdge::to_string(self : SortdistparallelEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SortdistparallelPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_dist_parallel_path_make(size : Int) -> SortdistparallelPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SortdistparallelPath::len(self : SortdistparallelPath) -> Int { self.size }

pub fn SortdistparallelPath::get(self : SortdistparallelPath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SortdistparallelPath::set(self : SortdistparallelPath, i : Int, v : Double) -> SortdistparallelPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SortdistparallelPath::sum(self : SortdistparallelPath) -> Double { @_common.sum(self.data) }

pub fn SortdistparallelPath::mean(self : SortdistparallelPath) -> Double { @_common.mean(self.data) }

pub fn SortdistparallelPath::scale(self : SortdistparallelPath, f : Double) -> SortdistparallelPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SortdistparallelPath::add(self : SortdistparallelPath, other : SortdistparallelPath) -> SortdistparallelPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SortdistparallelPath::copy(self : SortdistparallelPath) -> SortdistparallelPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SortdistparallelPath::fill(self : SortdistparallelPath, v : Double) -> SortdistparallelPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SortdistparallelPath::min(self : SortdistparallelPath) -> Double { @_common.min(self.data) }

pub fn SortdistparallelPath::max(self : SortdistparallelPath) -> Double { @_common.max(self.data) }

pub fn SortdistparallelPath::to_string(self : SortdistparallelPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SortdistparallelCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_dist_parallel_cluster_make(size : Int) -> SortdistparallelCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SortdistparallelCluster::len(self : SortdistparallelCluster) -> Int { self.size }

pub fn SortdistparallelCluster::get(self : SortdistparallelCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SortdistparallelCluster::set(self : SortdistparallelCluster, i : Int, v : Double) -> SortdistparallelCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SortdistparallelCluster::sum(self : SortdistparallelCluster) -> Double { @_common.sum(self.data) }

pub fn SortdistparallelCluster::mean(self : SortdistparallelCluster) -> Double { @_common.mean(self.data) }

pub fn SortdistparallelCluster::scale(self : SortdistparallelCluster, f : Double) -> SortdistparallelCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SortdistparallelCluster::add(self : SortdistparallelCluster, other : SortdistparallelCluster) -> SortdistparallelCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SortdistparallelCluster::copy(self : SortdistparallelCluster) -> SortdistparallelCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SortdistparallelCluster::fill(self : SortdistparallelCluster, v : Double) -> SortdistparallelCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SortdistparallelCluster::min(self : SortdistparallelCluster) -> Double { @_common.min(self.data) }

pub fn SortdistparallelCluster::max(self : SortdistparallelCluster) -> Double { @_common.max(self.data) }

pub fn SortdistparallelCluster::to_string(self : SortdistparallelCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SortdistparallelModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_dist_parallel_model_make(size : Int) -> SortdistparallelModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SortdistparallelModel::len(self : SortdistparallelModel) -> Int { self.size }

pub fn SortdistparallelModel::get(self : SortdistparallelModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SortdistparallelModel::set(self : SortdistparallelModel, i : Int, v : Double) -> SortdistparallelModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SortdistparallelModel::sum(self : SortdistparallelModel) -> Double { @_common.sum(self.data) }

pub fn SortdistparallelModel::mean(self : SortdistparallelModel) -> Double { @_common.mean(self.data) }

pub fn SortdistparallelModel::scale(self : SortdistparallelModel, f : Double) -> SortdistparallelModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SortdistparallelModel::add(self : SortdistparallelModel, other : SortdistparallelModel) -> SortdistparallelModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SortdistparallelModel::copy(self : SortdistparallelModel) -> SortdistparallelModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SortdistparallelModel::fill(self : SortdistparallelModel, v : Double) -> SortdistparallelModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SortdistparallelModel::min(self : SortdistparallelModel) -> Double { @_common.min(self.data) }

pub fn SortdistparallelModel::max(self : SortdistparallelModel) -> Double { @_common.max(self.data) }

pub fn SortdistparallelModel::to_string(self : SortdistparallelModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SortdistparallelLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_dist_parallel_layer_make(size : Int) -> SortdistparallelLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SortdistparallelLayer::len(self : SortdistparallelLayer) -> Int { self.size }

pub fn SortdistparallelLayer::get(self : SortdistparallelLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SortdistparallelLayer::set(self : SortdistparallelLayer, i : Int, v : Double) -> SortdistparallelLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SortdistparallelLayer::sum(self : SortdistparallelLayer) -> Double { @_common.sum(self.data) }

pub fn SortdistparallelLayer::mean(self : SortdistparallelLayer) -> Double { @_common.mean(self.data) }

pub fn SortdistparallelLayer::scale(self : SortdistparallelLayer, f : Double) -> SortdistparallelLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SortdistparallelLayer::add(self : SortdistparallelLayer, other : SortdistparallelLayer) -> SortdistparallelLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SortdistparallelLayer::copy(self : SortdistparallelLayer) -> SortdistparallelLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SortdistparallelLayer::fill(self : SortdistparallelLayer, v : Double) -> SortdistparallelLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SortdistparallelLayer::min(self : SortdistparallelLayer) -> Double { @_common.min(self.data) }

pub fn SortdistparallelLayer::max(self : SortdistparallelLayer) -> Double { @_common.max(self.data) }

pub fn SortdistparallelLayer::to_string(self : SortdistparallelLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SortdistparallelBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_dist_parallel_buffer_make(size : Int) -> SortdistparallelBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SortdistparallelBuffer::len(self : SortdistparallelBuffer) -> Int { self.size }

pub fn SortdistparallelBuffer::get(self : SortdistparallelBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SortdistparallelBuffer::set(self : SortdistparallelBuffer, i : Int, v : Double) -> SortdistparallelBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SortdistparallelBuffer::sum(self : SortdistparallelBuffer) -> Double { @_common.sum(self.data) }

pub fn SortdistparallelBuffer::mean(self : SortdistparallelBuffer) -> Double { @_common.mean(self.data) }

pub fn SortdistparallelBuffer::scale(self : SortdistparallelBuffer, f : Double) -> SortdistparallelBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SortdistparallelBuffer::add(self : SortdistparallelBuffer, other : SortdistparallelBuffer) -> SortdistparallelBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SortdistparallelBuffer::copy(self : SortdistparallelBuffer) -> SortdistparallelBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SortdistparallelBuffer::fill(self : SortdistparallelBuffer, v : Double) -> SortdistparallelBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SortdistparallelBuffer::min(self : SortdistparallelBuffer) -> Double { @_common.min(self.data) }

pub fn SortdistparallelBuffer::max(self : SortdistparallelBuffer) -> Double { @_common.max(self.data) }

pub fn SortdistparallelBuffer::to_string(self : SortdistparallelBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SortdistparallelCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_dist_parallel_cursor_make(size : Int) -> SortdistparallelCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SortdistparallelCursor::len(self : SortdistparallelCursor) -> Int { self.size }

pub fn SortdistparallelCursor::get(self : SortdistparallelCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SortdistparallelCursor::set(self : SortdistparallelCursor, i : Int, v : Double) -> SortdistparallelCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SortdistparallelCursor::sum(self : SortdistparallelCursor) -> Double { @_common.sum(self.data) }

pub fn SortdistparallelCursor::mean(self : SortdistparallelCursor) -> Double { @_common.mean(self.data) }

pub fn SortdistparallelCursor::scale(self : SortdistparallelCursor, f : Double) -> SortdistparallelCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SortdistparallelCursor::add(self : SortdistparallelCursor, other : SortdistparallelCursor) -> SortdistparallelCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SortdistparallelCursor::copy(self : SortdistparallelCursor) -> SortdistparallelCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SortdistparallelCursor::fill(self : SortdistparallelCursor, v : Double) -> SortdistparallelCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SortdistparallelCursor::min(self : SortdistparallelCursor) -> Double { @_common.min(self.data) }

pub fn SortdistparallelCursor::max(self : SortdistparallelCursor) -> Double { @_common.max(self.data) }

pub fn SortdistparallelCursor::to_string(self : SortdistparallelCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SortdistparallelView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_dist_parallel_view_make(size : Int) -> SortdistparallelView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SortdistparallelView::len(self : SortdistparallelView) -> Int { self.size }

pub fn SortdistparallelView::get(self : SortdistparallelView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SortdistparallelView::set(self : SortdistparallelView, i : Int, v : Double) -> SortdistparallelView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SortdistparallelView::sum(self : SortdistparallelView) -> Double { @_common.sum(self.data) }

pub fn SortdistparallelView::mean(self : SortdistparallelView) -> Double { @_common.mean(self.data) }

pub fn SortdistparallelView::scale(self : SortdistparallelView, f : Double) -> SortdistparallelView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SortdistparallelView::add(self : SortdistparallelView, other : SortdistparallelView) -> SortdistparallelView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SortdistparallelView::copy(self : SortdistparallelView) -> SortdistparallelView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SortdistparallelView::fill(self : SortdistparallelView, v : Double) -> SortdistparallelView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SortdistparallelView::min(self : SortdistparallelView) -> Double { @_common.min(self.data) }

pub fn SortdistparallelView::max(self : SortdistparallelView) -> Double { @_common.max(self.data) }

pub fn SortdistparallelView::to_string(self : SortdistparallelView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SortdistparallelRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_dist_parallel_range_make(size : Int) -> SortdistparallelRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SortdistparallelRange::len(self : SortdistparallelRange) -> Int { self.size }

pub fn SortdistparallelRange::get(self : SortdistparallelRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SortdistparallelRange::set(self : SortdistparallelRange, i : Int, v : Double) -> SortdistparallelRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SortdistparallelRange::sum(self : SortdistparallelRange) -> Double { @_common.sum(self.data) }

pub fn SortdistparallelRange::mean(self : SortdistparallelRange) -> Double { @_common.mean(self.data) }

pub fn SortdistparallelRange::scale(self : SortdistparallelRange, f : Double) -> SortdistparallelRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SortdistparallelRange::add(self : SortdistparallelRange, other : SortdistparallelRange) -> SortdistparallelRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SortdistparallelRange::copy(self : SortdistparallelRange) -> SortdistparallelRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SortdistparallelRange::fill(self : SortdistparallelRange, v : Double) -> SortdistparallelRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SortdistparallelRange::min(self : SortdistparallelRange) -> Double { @_common.min(self.data) }

pub fn SortdistparallelRange::max(self : SortdistparallelRange) -> Double { @_common.max(self.data) }

pub fn SortdistparallelRange::to_string(self : SortdistparallelRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SortdistparallelSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_dist_parallel_slice_make(size : Int) -> SortdistparallelSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SortdistparallelSlice::len(self : SortdistparallelSlice) -> Int { self.size }

pub fn SortdistparallelSlice::get(self : SortdistparallelSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SortdistparallelSlice::set(self : SortdistparallelSlice, i : Int, v : Double) -> SortdistparallelSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SortdistparallelSlice::sum(self : SortdistparallelSlice) -> Double { @_common.sum(self.data) }

pub fn SortdistparallelSlice::mean(self : SortdistparallelSlice) -> Double { @_common.mean(self.data) }

pub fn SortdistparallelSlice::scale(self : SortdistparallelSlice, f : Double) -> SortdistparallelSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SortdistparallelSlice::add(self : SortdistparallelSlice, other : SortdistparallelSlice) -> SortdistparallelSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SortdistparallelSlice::copy(self : SortdistparallelSlice) -> SortdistparallelSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SortdistparallelSlice::fill(self : SortdistparallelSlice, v : Double) -> SortdistparallelSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SortdistparallelSlice::min(self : SortdistparallelSlice) -> Double { @_common.min(self.data) }

pub fn SortdistparallelSlice::max(self : SortdistparallelSlice) -> Double { @_common.max(self.data) }

pub fn SortdistparallelSlice::to_string(self : SortdistparallelSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

