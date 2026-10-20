///===
/// extcore/sort_dist_pigeonhole

pub(all) struct SortdistpigeonholePoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn sort_dist_pigeonhole_make_point(x : Double, y : Double) -> SortdistpigeonholePoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn sort_dist_pigeonhole_make_point3(x : Double, y : Double, z : Double) -> SortdistpigeonholePoint {
  { x, y, z, label: 0 }
}

pub fn SortdistpigeonholePoint::x(self : SortdistpigeonholePoint) -> Double { self.x }

pub fn SortdistpigeonholePoint::y(self : SortdistpigeonholePoint) -> Double { self.y }

pub fn SortdistpigeonholePoint::z(self : SortdistpigeonholePoint) -> Double { self.z }

pub fn SortdistpigeonholePoint::label(self : SortdistpigeonholePoint) -> Int { self.label }

pub fn SortdistpigeonholePoint::dist(self : SortdistpigeonholePoint, other : SortdistpigeonholePoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn SortdistpigeonholePoint::add(self : SortdistpigeonholePoint, other : SortdistpigeonholePoint) -> SortdistpigeonholePoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn SortdistpigeonholePoint::sub(self : SortdistpigeonholePoint, other : SortdistpigeonholePoint) -> SortdistpigeonholePoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn SortdistpigeonholePoint::scale(self : SortdistpigeonholePoint, s : Double) -> SortdistpigeonholePoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn SortdistpigeonholePoint::dot(self : SortdistpigeonholePoint, other : SortdistpigeonholePoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn SortdistpigeonholePoint::cross(self : SortdistpigeonholePoint, other : SortdistpigeonholePoint) -> SortdistpigeonholePoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn SortdistpigeonholePoint::norm(self : SortdistpigeonholePoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn SortdistpigeonholePoint::normalize(self : SortdistpigeonholePoint) -> SortdistpigeonholePoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn SortdistpigeonholePoint::negate(self : SortdistpigeonholePoint) -> SortdistpigeonholePoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn SortdistpigeonholePoint::mid(self : SortdistpigeonholePoint, other : SortdistpigeonholePoint) -> SortdistpigeonholePoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn SortdistpigeonholePoint::lerp(self : SortdistpigeonholePoint, other : SortdistpigeonholePoint, t : Double) -> SortdistpigeonholePoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn SortdistpigeonholePoint::to_string(self : SortdistpigeonholePoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct SortdistpigeonholeSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn sort_dist_pigeonhole_make_series(vals : Array[Double], name : String) -> SortdistpigeonholeSeries {
  { vals, name, meta: 0 }
}

pub fn SortdistpigeonholeSeries::len(self : SortdistpigeonholeSeries) -> Int { self.vals.length() }

pub fn SortdistpigeonholeSeries::sum(self : SortdistpigeonholeSeries) -> Double { @_common.sum(self.vals) }

pub fn SortdistpigeonholeSeries::mean(self : SortdistpigeonholeSeries) -> Double { @_common.mean(self.vals) }

pub fn SortdistpigeonholeSeries::min(self : SortdistpigeonholeSeries) -> Double { @_common.min(self.vals) }

pub fn SortdistpigeonholeSeries::max(self : SortdistpigeonholeSeries) -> Double { @_common.max(self.vals) }

pub fn SortdistpigeonholeSeries::range(self : SortdistpigeonholeSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn SortdistpigeonholeSeries::variance(self : SortdistpigeonholeSeries) -> Double { @_common.variance(self.vals) }

pub fn SortdistpigeonholeSeries::std(self : SortdistpigeonholeSeries) -> Double { @_common.std(self.vals) }

pub fn SortdistpigeonholeSeries::median(self : SortdistpigeonholeSeries) -> Double { @_common.median(self.vals) }

pub fn SortdistpigeonholeSeries::scale(self : SortdistpigeonholeSeries, f : Double) -> SortdistpigeonholeSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn SortdistpigeonholeSeries::add(self : SortdistpigeonholeSeries, other : SortdistpigeonholeSeries) -> SortdistpigeonholeSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn SortdistpigeonholeSeries::sub(self : SortdistpigeonholeSeries, other : SortdistpigeonholeSeries) -> SortdistpigeonholeSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn SortdistpigeonholeSeries::normalize(self : SortdistpigeonholeSeries) -> SortdistpigeonholeSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn SortdistpigeonholeSeries::cumsum(self : SortdistpigeonholeSeries) -> SortdistpigeonholeSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn SortdistpigeonholeSeries::to_string(self : SortdistpigeonholeSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct SortdistpigeonholeMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn sort_dist_pigeonhole_make_matrix(rows : Int, cols : Int, val : Double) -> SortdistpigeonholeMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn sort_dist_pigeonhole_matrix_identity(n : Int) -> SortdistpigeonholeMatrix {
  let m = sort_dist_pigeonhole_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn SortdistpigeonholeMatrix::get(self : SortdistpigeonholeMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn SortdistpigeonholeMatrix::transpose(self : SortdistpigeonholeMatrix) -> SortdistpigeonholeMatrix {
  let result = sort_dist_pigeonhole_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn SortdistpigeonholeMatrix::add(self : SortdistpigeonholeMatrix, other : SortdistpigeonholeMatrix) -> SortdistpigeonholeMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = sort_dist_pigeonhole_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn SortdistpigeonholeMatrix::scale(self : SortdistpigeonholeMatrix, s : Double) -> SortdistpigeonholeMatrix {
  let result = sort_dist_pigeonhole_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn SortdistpigeonholeMatrix::multiply(self : SortdistpigeonholeMatrix, other : SortdistpigeonholeMatrix) -> SortdistpigeonholeMatrix {
  if self.cols != other.rows { return sort_dist_pigeonhole_make_matrix(self.rows, other.cols, 0.0) }
  let result = sort_dist_pigeonhole_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn SortdistpigeonholeMatrix::trace(self : SortdistpigeonholeMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn SortdistpigeonholeMatrix::det(self : SortdistpigeonholeMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn SortdistpigeonholeMatrix::norm(self : SortdistpigeonholeMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn SortdistpigeonholeMatrix::to_string(self : SortdistpigeonholeMatrix) -> String {
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

pub(all) struct SortdistpigeonholeVector {
  comps : Array[Double]
  dim : Int
}

pub fn sort_dist_pigeonhole_make_vector(comps : Array[Double]) -> SortdistpigeonholeVector {
  { comps, dim: comps.length() }
}

pub fn sort_dist_pigeonhole_vector_zero(dim : Int) -> SortdistpigeonholeVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn SortdistpigeonholeVector::add(self : SortdistpigeonholeVector, other : SortdistpigeonholeVector) -> SortdistpigeonholeVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn SortdistpigeonholeVector::sub(self : SortdistpigeonholeVector, other : SortdistpigeonholeVector) -> SortdistpigeonholeVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn SortdistpigeonholeVector::scale(self : SortdistpigeonholeVector, s : Double) -> SortdistpigeonholeVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn SortdistpigeonholeVector::dot(self : SortdistpigeonholeVector, other : SortdistpigeonholeVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn SortdistpigeonholeVector::norm(self : SortdistpigeonholeVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn SortdistpigeonholeVector::normalize(self : SortdistpigeonholeVector) -> SortdistpigeonholeVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn SortdistpigeonholeVector::dist(self : SortdistpigeonholeVector, other : SortdistpigeonholeVector) -> Double {
  self.sub(other).norm()
}

pub fn SortdistpigeonholeVector::to_string(self : SortdistpigeonholeVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn sort_dist_pigeonhole_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn sort_dist_pigeonhole_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn sort_dist_pigeonhole_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn sort_dist_pigeonhole_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn sort_dist_pigeonhole_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn sort_dist_pigeonhole_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn sort_dist_pigeonhole_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn sort_dist_pigeonhole_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn sort_dist_pigeonhole_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn sort_dist_pigeonhole_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn sort_dist_pigeonhole_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn sort_dist_pigeonhole_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn sort_dist_pigeonhole_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn sort_dist_pigeonhole_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn sort_dist_pigeonhole_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn sort_dist_pigeonhole_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn sort_dist_pigeonhole_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn sort_dist_pigeonhole_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn sort_dist_pigeonhole_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn sort_dist_pigeonhole_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn sort_dist_pigeonhole_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn sort_dist_pigeonhole_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn sort_dist_pigeonhole_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn sort_dist_pigeonhole_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn sort_dist_pigeonhole_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn sort_dist_pigeonhole_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn sort_dist_pigeonhole_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn sort_dist_pigeonhole_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn sort_dist_pigeonhole_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct SortdistpigeonholeFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_dist_pigeonhole_frame_make(size : Int) -> SortdistpigeonholeFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SortdistpigeonholeFrame::len(self : SortdistpigeonholeFrame) -> Int { self.size }

pub fn SortdistpigeonholeFrame::get(self : SortdistpigeonholeFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SortdistpigeonholeFrame::set(self : SortdistpigeonholeFrame, i : Int, v : Double) -> SortdistpigeonholeFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SortdistpigeonholeFrame::sum(self : SortdistpigeonholeFrame) -> Double { @_common.sum(self.data) }

pub fn SortdistpigeonholeFrame::mean(self : SortdistpigeonholeFrame) -> Double { @_common.mean(self.data) }

pub fn SortdistpigeonholeFrame::scale(self : SortdistpigeonholeFrame, f : Double) -> SortdistpigeonholeFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SortdistpigeonholeFrame::add(self : SortdistpigeonholeFrame, other : SortdistpigeonholeFrame) -> SortdistpigeonholeFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SortdistpigeonholeFrame::copy(self : SortdistpigeonholeFrame) -> SortdistpigeonholeFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SortdistpigeonholeFrame::fill(self : SortdistpigeonholeFrame, v : Double) -> SortdistpigeonholeFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SortdistpigeonholeFrame::min(self : SortdistpigeonholeFrame) -> Double { @_common.min(self.data) }

pub fn SortdistpigeonholeFrame::max(self : SortdistpigeonholeFrame) -> Double { @_common.max(self.data) }

pub fn SortdistpigeonholeFrame::to_string(self : SortdistpigeonholeFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SortdistpigeonholeTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_dist_pigeonhole_table_make(size : Int) -> SortdistpigeonholeTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SortdistpigeonholeTable::len(self : SortdistpigeonholeTable) -> Int { self.size }

pub fn SortdistpigeonholeTable::get(self : SortdistpigeonholeTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SortdistpigeonholeTable::set(self : SortdistpigeonholeTable, i : Int, v : Double) -> SortdistpigeonholeTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SortdistpigeonholeTable::sum(self : SortdistpigeonholeTable) -> Double { @_common.sum(self.data) }

pub fn SortdistpigeonholeTable::mean(self : SortdistpigeonholeTable) -> Double { @_common.mean(self.data) }

pub fn SortdistpigeonholeTable::scale(self : SortdistpigeonholeTable, f : Double) -> SortdistpigeonholeTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SortdistpigeonholeTable::add(self : SortdistpigeonholeTable, other : SortdistpigeonholeTable) -> SortdistpigeonholeTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SortdistpigeonholeTable::copy(self : SortdistpigeonholeTable) -> SortdistpigeonholeTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SortdistpigeonholeTable::fill(self : SortdistpigeonholeTable, v : Double) -> SortdistpigeonholeTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SortdistpigeonholeTable::min(self : SortdistpigeonholeTable) -> Double { @_common.min(self.data) }

pub fn SortdistpigeonholeTable::max(self : SortdistpigeonholeTable) -> Double { @_common.max(self.data) }

pub fn SortdistpigeonholeTable::to_string(self : SortdistpigeonholeTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SortdistpigeonholeGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_dist_pigeonhole_graphn_make(size : Int) -> SortdistpigeonholeGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SortdistpigeonholeGraphN::len(self : SortdistpigeonholeGraphN) -> Int { self.size }

pub fn SortdistpigeonholeGraphN::get(self : SortdistpigeonholeGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SortdistpigeonholeGraphN::set(self : SortdistpigeonholeGraphN, i : Int, v : Double) -> SortdistpigeonholeGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SortdistpigeonholeGraphN::sum(self : SortdistpigeonholeGraphN) -> Double { @_common.sum(self.data) }

pub fn SortdistpigeonholeGraphN::mean(self : SortdistpigeonholeGraphN) -> Double { @_common.mean(self.data) }

pub fn SortdistpigeonholeGraphN::scale(self : SortdistpigeonholeGraphN, f : Double) -> SortdistpigeonholeGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SortdistpigeonholeGraphN::add(self : SortdistpigeonholeGraphN, other : SortdistpigeonholeGraphN) -> SortdistpigeonholeGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SortdistpigeonholeGraphN::copy(self : SortdistpigeonholeGraphN) -> SortdistpigeonholeGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SortdistpigeonholeGraphN::fill(self : SortdistpigeonholeGraphN, v : Double) -> SortdistpigeonholeGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SortdistpigeonholeGraphN::min(self : SortdistpigeonholeGraphN) -> Double { @_common.min(self.data) }

pub fn SortdistpigeonholeGraphN::max(self : SortdistpigeonholeGraphN) -> Double { @_common.max(self.data) }

pub fn SortdistpigeonholeGraphN::to_string(self : SortdistpigeonholeGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SortdistpigeonholeNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_dist_pigeonhole_node_make(size : Int) -> SortdistpigeonholeNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SortdistpigeonholeNode::len(self : SortdistpigeonholeNode) -> Int { self.size }

pub fn SortdistpigeonholeNode::get(self : SortdistpigeonholeNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SortdistpigeonholeNode::set(self : SortdistpigeonholeNode, i : Int, v : Double) -> SortdistpigeonholeNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SortdistpigeonholeNode::sum(self : SortdistpigeonholeNode) -> Double { @_common.sum(self.data) }

pub fn SortdistpigeonholeNode::mean(self : SortdistpigeonholeNode) -> Double { @_common.mean(self.data) }

pub fn SortdistpigeonholeNode::scale(self : SortdistpigeonholeNode, f : Double) -> SortdistpigeonholeNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SortdistpigeonholeNode::add(self : SortdistpigeonholeNode, other : SortdistpigeonholeNode) -> SortdistpigeonholeNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SortdistpigeonholeNode::copy(self : SortdistpigeonholeNode) -> SortdistpigeonholeNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SortdistpigeonholeNode::fill(self : SortdistpigeonholeNode, v : Double) -> SortdistpigeonholeNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SortdistpigeonholeNode::min(self : SortdistpigeonholeNode) -> Double { @_common.min(self.data) }

pub fn SortdistpigeonholeNode::max(self : SortdistpigeonholeNode) -> Double { @_common.max(self.data) }

pub fn SortdistpigeonholeNode::to_string(self : SortdistpigeonholeNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SortdistpigeonholeEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_dist_pigeonhole_edge_make(size : Int) -> SortdistpigeonholeEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SortdistpigeonholeEdge::len(self : SortdistpigeonholeEdge) -> Int { self.size }

pub fn SortdistpigeonholeEdge::get(self : SortdistpigeonholeEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SortdistpigeonholeEdge::set(self : SortdistpigeonholeEdge, i : Int, v : Double) -> SortdistpigeonholeEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SortdistpigeonholeEdge::sum(self : SortdistpigeonholeEdge) -> Double { @_common.sum(self.data) }

pub fn SortdistpigeonholeEdge::mean(self : SortdistpigeonholeEdge) -> Double { @_common.mean(self.data) }

pub fn SortdistpigeonholeEdge::scale(self : SortdistpigeonholeEdge, f : Double) -> SortdistpigeonholeEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SortdistpigeonholeEdge::add(self : SortdistpigeonholeEdge, other : SortdistpigeonholeEdge) -> SortdistpigeonholeEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SortdistpigeonholeEdge::copy(self : SortdistpigeonholeEdge) -> SortdistpigeonholeEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SortdistpigeonholeEdge::fill(self : SortdistpigeonholeEdge, v : Double) -> SortdistpigeonholeEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SortdistpigeonholeEdge::min(self : SortdistpigeonholeEdge) -> Double { @_common.min(self.data) }

pub fn SortdistpigeonholeEdge::max(self : SortdistpigeonholeEdge) -> Double { @_common.max(self.data) }

pub fn SortdistpigeonholeEdge::to_string(self : SortdistpigeonholeEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SortdistpigeonholePath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_dist_pigeonhole_path_make(size : Int) -> SortdistpigeonholePath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SortdistpigeonholePath::len(self : SortdistpigeonholePath) -> Int { self.size }

pub fn SortdistpigeonholePath::get(self : SortdistpigeonholePath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SortdistpigeonholePath::set(self : SortdistpigeonholePath, i : Int, v : Double) -> SortdistpigeonholePath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SortdistpigeonholePath::sum(self : SortdistpigeonholePath) -> Double { @_common.sum(self.data) }

pub fn SortdistpigeonholePath::mean(self : SortdistpigeonholePath) -> Double { @_common.mean(self.data) }

pub fn SortdistpigeonholePath::scale(self : SortdistpigeonholePath, f : Double) -> SortdistpigeonholePath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SortdistpigeonholePath::add(self : SortdistpigeonholePath, other : SortdistpigeonholePath) -> SortdistpigeonholePath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SortdistpigeonholePath::copy(self : SortdistpigeonholePath) -> SortdistpigeonholePath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SortdistpigeonholePath::fill(self : SortdistpigeonholePath, v : Double) -> SortdistpigeonholePath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SortdistpigeonholePath::min(self : SortdistpigeonholePath) -> Double { @_common.min(self.data) }

pub fn SortdistpigeonholePath::max(self : SortdistpigeonholePath) -> Double { @_common.max(self.data) }

pub fn SortdistpigeonholePath::to_string(self : SortdistpigeonholePath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SortdistpigeonholeCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_dist_pigeonhole_cluster_make(size : Int) -> SortdistpigeonholeCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SortdistpigeonholeCluster::len(self : SortdistpigeonholeCluster) -> Int { self.size }

pub fn SortdistpigeonholeCluster::get(self : SortdistpigeonholeCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SortdistpigeonholeCluster::set(self : SortdistpigeonholeCluster, i : Int, v : Double) -> SortdistpigeonholeCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SortdistpigeonholeCluster::sum(self : SortdistpigeonholeCluster) -> Double { @_common.sum(self.data) }

pub fn SortdistpigeonholeCluster::mean(self : SortdistpigeonholeCluster) -> Double { @_common.mean(self.data) }

pub fn SortdistpigeonholeCluster::scale(self : SortdistpigeonholeCluster, f : Double) -> SortdistpigeonholeCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SortdistpigeonholeCluster::add(self : SortdistpigeonholeCluster, other : SortdistpigeonholeCluster) -> SortdistpigeonholeCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SortdistpigeonholeCluster::copy(self : SortdistpigeonholeCluster) -> SortdistpigeonholeCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SortdistpigeonholeCluster::fill(self : SortdistpigeonholeCluster, v : Double) -> SortdistpigeonholeCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SortdistpigeonholeCluster::min(self : SortdistpigeonholeCluster) -> Double { @_common.min(self.data) }

pub fn SortdistpigeonholeCluster::max(self : SortdistpigeonholeCluster) -> Double { @_common.max(self.data) }

pub fn SortdistpigeonholeCluster::to_string(self : SortdistpigeonholeCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SortdistpigeonholeModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_dist_pigeonhole_model_make(size : Int) -> SortdistpigeonholeModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SortdistpigeonholeModel::len(self : SortdistpigeonholeModel) -> Int { self.size }

pub fn SortdistpigeonholeModel::get(self : SortdistpigeonholeModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SortdistpigeonholeModel::set(self : SortdistpigeonholeModel, i : Int, v : Double) -> SortdistpigeonholeModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SortdistpigeonholeModel::sum(self : SortdistpigeonholeModel) -> Double { @_common.sum(self.data) }

pub fn SortdistpigeonholeModel::mean(self : SortdistpigeonholeModel) -> Double { @_common.mean(self.data) }

pub fn SortdistpigeonholeModel::scale(self : SortdistpigeonholeModel, f : Double) -> SortdistpigeonholeModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SortdistpigeonholeModel::add(self : SortdistpigeonholeModel, other : SortdistpigeonholeModel) -> SortdistpigeonholeModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SortdistpigeonholeModel::copy(self : SortdistpigeonholeModel) -> SortdistpigeonholeModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SortdistpigeonholeModel::fill(self : SortdistpigeonholeModel, v : Double) -> SortdistpigeonholeModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SortdistpigeonholeModel::min(self : SortdistpigeonholeModel) -> Double { @_common.min(self.data) }

pub fn SortdistpigeonholeModel::max(self : SortdistpigeonholeModel) -> Double { @_common.max(self.data) }

pub fn SortdistpigeonholeModel::to_string(self : SortdistpigeonholeModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SortdistpigeonholeLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_dist_pigeonhole_layer_make(size : Int) -> SortdistpigeonholeLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SortdistpigeonholeLayer::len(self : SortdistpigeonholeLayer) -> Int { self.size }

pub fn SortdistpigeonholeLayer::get(self : SortdistpigeonholeLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SortdistpigeonholeLayer::set(self : SortdistpigeonholeLayer, i : Int, v : Double) -> SortdistpigeonholeLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SortdistpigeonholeLayer::sum(self : SortdistpigeonholeLayer) -> Double { @_common.sum(self.data) }

pub fn SortdistpigeonholeLayer::mean(self : SortdistpigeonholeLayer) -> Double { @_common.mean(self.data) }

pub fn SortdistpigeonholeLayer::scale(self : SortdistpigeonholeLayer, f : Double) -> SortdistpigeonholeLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SortdistpigeonholeLayer::add(self : SortdistpigeonholeLayer, other : SortdistpigeonholeLayer) -> SortdistpigeonholeLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SortdistpigeonholeLayer::copy(self : SortdistpigeonholeLayer) -> SortdistpigeonholeLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SortdistpigeonholeLayer::fill(self : SortdistpigeonholeLayer, v : Double) -> SortdistpigeonholeLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SortdistpigeonholeLayer::min(self : SortdistpigeonholeLayer) -> Double { @_common.min(self.data) }

pub fn SortdistpigeonholeLayer::max(self : SortdistpigeonholeLayer) -> Double { @_common.max(self.data) }

pub fn SortdistpigeonholeLayer::to_string(self : SortdistpigeonholeLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SortdistpigeonholeBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_dist_pigeonhole_buffer_make(size : Int) -> SortdistpigeonholeBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SortdistpigeonholeBuffer::len(self : SortdistpigeonholeBuffer) -> Int { self.size }

pub fn SortdistpigeonholeBuffer::get(self : SortdistpigeonholeBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SortdistpigeonholeBuffer::set(self : SortdistpigeonholeBuffer, i : Int, v : Double) -> SortdistpigeonholeBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SortdistpigeonholeBuffer::sum(self : SortdistpigeonholeBuffer) -> Double { @_common.sum(self.data) }

pub fn SortdistpigeonholeBuffer::mean(self : SortdistpigeonholeBuffer) -> Double { @_common.mean(self.data) }

pub fn SortdistpigeonholeBuffer::scale(self : SortdistpigeonholeBuffer, f : Double) -> SortdistpigeonholeBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SortdistpigeonholeBuffer::add(self : SortdistpigeonholeBuffer, other : SortdistpigeonholeBuffer) -> SortdistpigeonholeBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SortdistpigeonholeBuffer::copy(self : SortdistpigeonholeBuffer) -> SortdistpigeonholeBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SortdistpigeonholeBuffer::fill(self : SortdistpigeonholeBuffer, v : Double) -> SortdistpigeonholeBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SortdistpigeonholeBuffer::min(self : SortdistpigeonholeBuffer) -> Double { @_common.min(self.data) }

pub fn SortdistpigeonholeBuffer::max(self : SortdistpigeonholeBuffer) -> Double { @_common.max(self.data) }

pub fn SortdistpigeonholeBuffer::to_string(self : SortdistpigeonholeBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SortdistpigeonholeCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_dist_pigeonhole_cursor_make(size : Int) -> SortdistpigeonholeCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SortdistpigeonholeCursor::len(self : SortdistpigeonholeCursor) -> Int { self.size }

pub fn SortdistpigeonholeCursor::get(self : SortdistpigeonholeCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SortdistpigeonholeCursor::set(self : SortdistpigeonholeCursor, i : Int, v : Double) -> SortdistpigeonholeCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SortdistpigeonholeCursor::sum(self : SortdistpigeonholeCursor) -> Double { @_common.sum(self.data) }

pub fn SortdistpigeonholeCursor::mean(self : SortdistpigeonholeCursor) -> Double { @_common.mean(self.data) }

pub fn SortdistpigeonholeCursor::scale(self : SortdistpigeonholeCursor, f : Double) -> SortdistpigeonholeCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SortdistpigeonholeCursor::add(self : SortdistpigeonholeCursor, other : SortdistpigeonholeCursor) -> SortdistpigeonholeCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SortdistpigeonholeCursor::copy(self : SortdistpigeonholeCursor) -> SortdistpigeonholeCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SortdistpigeonholeCursor::fill(self : SortdistpigeonholeCursor, v : Double) -> SortdistpigeonholeCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SortdistpigeonholeCursor::min(self : SortdistpigeonholeCursor) -> Double { @_common.min(self.data) }

pub fn SortdistpigeonholeCursor::max(self : SortdistpigeonholeCursor) -> Double { @_common.max(self.data) }

pub fn SortdistpigeonholeCursor::to_string(self : SortdistpigeonholeCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SortdistpigeonholeView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_dist_pigeonhole_view_make(size : Int) -> SortdistpigeonholeView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SortdistpigeonholeView::len(self : SortdistpigeonholeView) -> Int { self.size }

pub fn SortdistpigeonholeView::get(self : SortdistpigeonholeView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SortdistpigeonholeView::set(self : SortdistpigeonholeView, i : Int, v : Double) -> SortdistpigeonholeView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SortdistpigeonholeView::sum(self : SortdistpigeonholeView) -> Double { @_common.sum(self.data) }

pub fn SortdistpigeonholeView::mean(self : SortdistpigeonholeView) -> Double { @_common.mean(self.data) }

pub fn SortdistpigeonholeView::scale(self : SortdistpigeonholeView, f : Double) -> SortdistpigeonholeView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SortdistpigeonholeView::add(self : SortdistpigeonholeView, other : SortdistpigeonholeView) -> SortdistpigeonholeView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SortdistpigeonholeView::copy(self : SortdistpigeonholeView) -> SortdistpigeonholeView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SortdistpigeonholeView::fill(self : SortdistpigeonholeView, v : Double) -> SortdistpigeonholeView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SortdistpigeonholeView::min(self : SortdistpigeonholeView) -> Double { @_common.min(self.data) }

pub fn SortdistpigeonholeView::max(self : SortdistpigeonholeView) -> Double { @_common.max(self.data) }

pub fn SortdistpigeonholeView::to_string(self : SortdistpigeonholeView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SortdistpigeonholeRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_dist_pigeonhole_range_make(size : Int) -> SortdistpigeonholeRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SortdistpigeonholeRange::len(self : SortdistpigeonholeRange) -> Int { self.size }

pub fn SortdistpigeonholeRange::get(self : SortdistpigeonholeRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SortdistpigeonholeRange::set(self : SortdistpigeonholeRange, i : Int, v : Double) -> SortdistpigeonholeRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SortdistpigeonholeRange::sum(self : SortdistpigeonholeRange) -> Double { @_common.sum(self.data) }

pub fn SortdistpigeonholeRange::mean(self : SortdistpigeonholeRange) -> Double { @_common.mean(self.data) }

pub fn SortdistpigeonholeRange::scale(self : SortdistpigeonholeRange, f : Double) -> SortdistpigeonholeRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SortdistpigeonholeRange::add(self : SortdistpigeonholeRange, other : SortdistpigeonholeRange) -> SortdistpigeonholeRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SortdistpigeonholeRange::copy(self : SortdistpigeonholeRange) -> SortdistpigeonholeRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SortdistpigeonholeRange::fill(self : SortdistpigeonholeRange, v : Double) -> SortdistpigeonholeRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SortdistpigeonholeRange::min(self : SortdistpigeonholeRange) -> Double { @_common.min(self.data) }

pub fn SortdistpigeonholeRange::max(self : SortdistpigeonholeRange) -> Double { @_common.max(self.data) }

pub fn SortdistpigeonholeRange::to_string(self : SortdistpigeonholeRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SortdistpigeonholeSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_dist_pigeonhole_slice_make(size : Int) -> SortdistpigeonholeSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SortdistpigeonholeSlice::len(self : SortdistpigeonholeSlice) -> Int { self.size }

pub fn SortdistpigeonholeSlice::get(self : SortdistpigeonholeSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SortdistpigeonholeSlice::set(self : SortdistpigeonholeSlice, i : Int, v : Double) -> SortdistpigeonholeSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SortdistpigeonholeSlice::sum(self : SortdistpigeonholeSlice) -> Double { @_common.sum(self.data) }

pub fn SortdistpigeonholeSlice::mean(self : SortdistpigeonholeSlice) -> Double { @_common.mean(self.data) }

pub fn SortdistpigeonholeSlice::scale(self : SortdistpigeonholeSlice, f : Double) -> SortdistpigeonholeSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SortdistpigeonholeSlice::add(self : SortdistpigeonholeSlice, other : SortdistpigeonholeSlice) -> SortdistpigeonholeSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SortdistpigeonholeSlice::copy(self : SortdistpigeonholeSlice) -> SortdistpigeonholeSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SortdistpigeonholeSlice::fill(self : SortdistpigeonholeSlice, v : Double) -> SortdistpigeonholeSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SortdistpigeonholeSlice::min(self : SortdistpigeonholeSlice) -> Double { @_common.min(self.data) }

pub fn SortdistpigeonholeSlice::max(self : SortdistpigeonholeSlice) -> Double { @_common.max(self.data) }

pub fn SortdistpigeonholeSlice::to_string(self : SortdistpigeonholeSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

