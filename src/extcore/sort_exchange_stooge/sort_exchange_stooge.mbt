///===
/// extcore/sort_exchange_stooge

pub(all) struct SortexchangestoogePoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn sort_exchange_stooge_make_point(x : Double, y : Double) -> SortexchangestoogePoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn sort_exchange_stooge_make_point3(x : Double, y : Double, z : Double) -> SortexchangestoogePoint {
  { x, y, z, label: 0 }
}

pub fn SortexchangestoogePoint::x(self : SortexchangestoogePoint) -> Double { self.x }

pub fn SortexchangestoogePoint::y(self : SortexchangestoogePoint) -> Double { self.y }

pub fn SortexchangestoogePoint::z(self : SortexchangestoogePoint) -> Double { self.z }

pub fn SortexchangestoogePoint::label(self : SortexchangestoogePoint) -> Int { self.label }

pub fn SortexchangestoogePoint::dist(self : SortexchangestoogePoint, other : SortexchangestoogePoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn SortexchangestoogePoint::add(self : SortexchangestoogePoint, other : SortexchangestoogePoint) -> SortexchangestoogePoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn SortexchangestoogePoint::sub(self : SortexchangestoogePoint, other : SortexchangestoogePoint) -> SortexchangestoogePoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn SortexchangestoogePoint::scale(self : SortexchangestoogePoint, s : Double) -> SortexchangestoogePoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn SortexchangestoogePoint::dot(self : SortexchangestoogePoint, other : SortexchangestoogePoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn SortexchangestoogePoint::cross(self : SortexchangestoogePoint, other : SortexchangestoogePoint) -> SortexchangestoogePoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn SortexchangestoogePoint::norm(self : SortexchangestoogePoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn SortexchangestoogePoint::normalize(self : SortexchangestoogePoint) -> SortexchangestoogePoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn SortexchangestoogePoint::negate(self : SortexchangestoogePoint) -> SortexchangestoogePoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn SortexchangestoogePoint::mid(self : SortexchangestoogePoint, other : SortexchangestoogePoint) -> SortexchangestoogePoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn SortexchangestoogePoint::lerp(self : SortexchangestoogePoint, other : SortexchangestoogePoint, t : Double) -> SortexchangestoogePoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn SortexchangestoogePoint::to_string(self : SortexchangestoogePoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct SortexchangestoogeSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn sort_exchange_stooge_make_series(vals : Array[Double], name : String) -> SortexchangestoogeSeries {
  { vals, name, meta: 0 }
}

pub fn SortexchangestoogeSeries::len(self : SortexchangestoogeSeries) -> Int { self.vals.length() }

pub fn SortexchangestoogeSeries::sum(self : SortexchangestoogeSeries) -> Double { @_common.sum(self.vals) }

pub fn SortexchangestoogeSeries::mean(self : SortexchangestoogeSeries) -> Double { @_common.mean(self.vals) }

pub fn SortexchangestoogeSeries::min(self : SortexchangestoogeSeries) -> Double { @_common.min(self.vals) }

pub fn SortexchangestoogeSeries::max(self : SortexchangestoogeSeries) -> Double { @_common.max(self.vals) }

pub fn SortexchangestoogeSeries::range(self : SortexchangestoogeSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn SortexchangestoogeSeries::variance(self : SortexchangestoogeSeries) -> Double { @_common.variance(self.vals) }

pub fn SortexchangestoogeSeries::std(self : SortexchangestoogeSeries) -> Double { @_common.std(self.vals) }

pub fn SortexchangestoogeSeries::median(self : SortexchangestoogeSeries) -> Double { @_common.median(self.vals) }

pub fn SortexchangestoogeSeries::scale(self : SortexchangestoogeSeries, f : Double) -> SortexchangestoogeSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn SortexchangestoogeSeries::add(self : SortexchangestoogeSeries, other : SortexchangestoogeSeries) -> SortexchangestoogeSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn SortexchangestoogeSeries::sub(self : SortexchangestoogeSeries, other : SortexchangestoogeSeries) -> SortexchangestoogeSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn SortexchangestoogeSeries::normalize(self : SortexchangestoogeSeries) -> SortexchangestoogeSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn SortexchangestoogeSeries::cumsum(self : SortexchangestoogeSeries) -> SortexchangestoogeSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn SortexchangestoogeSeries::to_string(self : SortexchangestoogeSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct SortexchangestoogeMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn sort_exchange_stooge_make_matrix(rows : Int, cols : Int, val : Double) -> SortexchangestoogeMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn sort_exchange_stooge_matrix_identity(n : Int) -> SortexchangestoogeMatrix {
  let m = sort_exchange_stooge_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn SortexchangestoogeMatrix::get(self : SortexchangestoogeMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn SortexchangestoogeMatrix::transpose(self : SortexchangestoogeMatrix) -> SortexchangestoogeMatrix {
  let result = sort_exchange_stooge_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn SortexchangestoogeMatrix::add(self : SortexchangestoogeMatrix, other : SortexchangestoogeMatrix) -> SortexchangestoogeMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = sort_exchange_stooge_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn SortexchangestoogeMatrix::scale(self : SortexchangestoogeMatrix, s : Double) -> SortexchangestoogeMatrix {
  let result = sort_exchange_stooge_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn SortexchangestoogeMatrix::multiply(self : SortexchangestoogeMatrix, other : SortexchangestoogeMatrix) -> SortexchangestoogeMatrix {
  if self.cols != other.rows { return sort_exchange_stooge_make_matrix(self.rows, other.cols, 0.0) }
  let result = sort_exchange_stooge_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn SortexchangestoogeMatrix::trace(self : SortexchangestoogeMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn SortexchangestoogeMatrix::det(self : SortexchangestoogeMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn SortexchangestoogeMatrix::norm(self : SortexchangestoogeMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn SortexchangestoogeMatrix::to_string(self : SortexchangestoogeMatrix) -> String {
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

pub(all) struct SortexchangestoogeVector {
  comps : Array[Double]
  dim : Int
}

pub fn sort_exchange_stooge_make_vector(comps : Array[Double]) -> SortexchangestoogeVector {
  { comps, dim: comps.length() }
}

pub fn sort_exchange_stooge_vector_zero(dim : Int) -> SortexchangestoogeVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn SortexchangestoogeVector::add(self : SortexchangestoogeVector, other : SortexchangestoogeVector) -> SortexchangestoogeVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn SortexchangestoogeVector::sub(self : SortexchangestoogeVector, other : SortexchangestoogeVector) -> SortexchangestoogeVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn SortexchangestoogeVector::scale(self : SortexchangestoogeVector, s : Double) -> SortexchangestoogeVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn SortexchangestoogeVector::dot(self : SortexchangestoogeVector, other : SortexchangestoogeVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn SortexchangestoogeVector::norm(self : SortexchangestoogeVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn SortexchangestoogeVector::normalize(self : SortexchangestoogeVector) -> SortexchangestoogeVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn SortexchangestoogeVector::dist(self : SortexchangestoogeVector, other : SortexchangestoogeVector) -> Double {
  self.sub(other).norm()
}

pub fn SortexchangestoogeVector::to_string(self : SortexchangestoogeVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn sort_exchange_stooge_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn sort_exchange_stooge_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn sort_exchange_stooge_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn sort_exchange_stooge_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn sort_exchange_stooge_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn sort_exchange_stooge_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn sort_exchange_stooge_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn sort_exchange_stooge_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn sort_exchange_stooge_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn sort_exchange_stooge_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn sort_exchange_stooge_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn sort_exchange_stooge_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn sort_exchange_stooge_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn sort_exchange_stooge_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn sort_exchange_stooge_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn sort_exchange_stooge_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn sort_exchange_stooge_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn sort_exchange_stooge_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn sort_exchange_stooge_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn sort_exchange_stooge_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn sort_exchange_stooge_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn sort_exchange_stooge_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn sort_exchange_stooge_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn sort_exchange_stooge_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn sort_exchange_stooge_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn sort_exchange_stooge_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn sort_exchange_stooge_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn sort_exchange_stooge_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn sort_exchange_stooge_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct SortexchangestoogeFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_exchange_stooge_frame_make(size : Int) -> SortexchangestoogeFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_exchange_stooge_frame_len(s : SortexchangestoogeFrame) -> Int { s.size }

pub fn sort_exchange_stooge_frame_get(s : SortexchangestoogeFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_exchange_stooge_frame_set(s : SortexchangestoogeFrame, i : Int, v : Double) -> SortexchangestoogeFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_exchange_stooge_frame_sum(s : SortexchangestoogeFrame) -> Double { @_common.sum(s.data) }

pub fn sort_exchange_stooge_frame_mean(s : SortexchangestoogeFrame) -> Double { @_common.mean(s.data) }

pub fn sort_exchange_stooge_frame_scale(s : SortexchangestoogeFrame, f : Double) -> SortexchangestoogeFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_exchange_stooge_frame_add(a : SortexchangestoogeFrame, b : SortexchangestoogeFrame) -> SortexchangestoogeFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_exchange_stooge_frame_copy(s : SortexchangestoogeFrame) -> SortexchangestoogeFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_exchange_stooge_frame_fill(s : SortexchangestoogeFrame, v : Double) -> SortexchangestoogeFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_exchange_stooge_frame_min(s : SortexchangestoogeFrame) -> Double { @_common.min(s.data) }

pub fn sort_exchange_stooge_frame_max(s : SortexchangestoogeFrame) -> Double { @_common.max(s.data) }

pub fn sort_exchange_stooge_frame_to_string(s : SortexchangestoogeFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortexchangestoogeTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_exchange_stooge_table_make(size : Int) -> SortexchangestoogeTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_exchange_stooge_table_len(s : SortexchangestoogeTable) -> Int { s.size }

pub fn sort_exchange_stooge_table_get(s : SortexchangestoogeTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_exchange_stooge_table_set(s : SortexchangestoogeTable, i : Int, v : Double) -> SortexchangestoogeTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_exchange_stooge_table_sum(s : SortexchangestoogeTable) -> Double { @_common.sum(s.data) }

pub fn sort_exchange_stooge_table_mean(s : SortexchangestoogeTable) -> Double { @_common.mean(s.data) }

pub fn sort_exchange_stooge_table_scale(s : SortexchangestoogeTable, f : Double) -> SortexchangestoogeTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_exchange_stooge_table_add(a : SortexchangestoogeTable, b : SortexchangestoogeTable) -> SortexchangestoogeTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_exchange_stooge_table_copy(s : SortexchangestoogeTable) -> SortexchangestoogeTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_exchange_stooge_table_fill(s : SortexchangestoogeTable, v : Double) -> SortexchangestoogeTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_exchange_stooge_table_min(s : SortexchangestoogeTable) -> Double { @_common.min(s.data) }

pub fn sort_exchange_stooge_table_max(s : SortexchangestoogeTable) -> Double { @_common.max(s.data) }

pub fn sort_exchange_stooge_table_to_string(s : SortexchangestoogeTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortexchangestoogeGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_exchange_stooge_graphn_make(size : Int) -> SortexchangestoogeGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_exchange_stooge_graphn_len(s : SortexchangestoogeGraphN) -> Int { s.size }

pub fn sort_exchange_stooge_graphn_get(s : SortexchangestoogeGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_exchange_stooge_graphn_set(s : SortexchangestoogeGraphN, i : Int, v : Double) -> SortexchangestoogeGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_exchange_stooge_graphn_sum(s : SortexchangestoogeGraphN) -> Double { @_common.sum(s.data) }

pub fn sort_exchange_stooge_graphn_mean(s : SortexchangestoogeGraphN) -> Double { @_common.mean(s.data) }

pub fn sort_exchange_stooge_graphn_scale(s : SortexchangestoogeGraphN, f : Double) -> SortexchangestoogeGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_exchange_stooge_graphn_add(a : SortexchangestoogeGraphN, b : SortexchangestoogeGraphN) -> SortexchangestoogeGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_exchange_stooge_graphn_copy(s : SortexchangestoogeGraphN) -> SortexchangestoogeGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_exchange_stooge_graphn_fill(s : SortexchangestoogeGraphN, v : Double) -> SortexchangestoogeGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_exchange_stooge_graphn_min(s : SortexchangestoogeGraphN) -> Double { @_common.min(s.data) }

pub fn sort_exchange_stooge_graphn_max(s : SortexchangestoogeGraphN) -> Double { @_common.max(s.data) }

pub fn sort_exchange_stooge_graphn_to_string(s : SortexchangestoogeGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortexchangestoogeNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_exchange_stooge_node_make(size : Int) -> SortexchangestoogeNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_exchange_stooge_node_len(s : SortexchangestoogeNode) -> Int { s.size }

pub fn sort_exchange_stooge_node_get(s : SortexchangestoogeNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_exchange_stooge_node_set(s : SortexchangestoogeNode, i : Int, v : Double) -> SortexchangestoogeNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_exchange_stooge_node_sum(s : SortexchangestoogeNode) -> Double { @_common.sum(s.data) }

pub fn sort_exchange_stooge_node_mean(s : SortexchangestoogeNode) -> Double { @_common.mean(s.data) }

pub fn sort_exchange_stooge_node_scale(s : SortexchangestoogeNode, f : Double) -> SortexchangestoogeNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_exchange_stooge_node_add(a : SortexchangestoogeNode, b : SortexchangestoogeNode) -> SortexchangestoogeNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_exchange_stooge_node_copy(s : SortexchangestoogeNode) -> SortexchangestoogeNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_exchange_stooge_node_fill(s : SortexchangestoogeNode, v : Double) -> SortexchangestoogeNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_exchange_stooge_node_min(s : SortexchangestoogeNode) -> Double { @_common.min(s.data) }

pub fn sort_exchange_stooge_node_max(s : SortexchangestoogeNode) -> Double { @_common.max(s.data) }

pub fn sort_exchange_stooge_node_to_string(s : SortexchangestoogeNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortexchangestoogeEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_exchange_stooge_edge_make(size : Int) -> SortexchangestoogeEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_exchange_stooge_edge_len(s : SortexchangestoogeEdge) -> Int { s.size }

pub fn sort_exchange_stooge_edge_get(s : SortexchangestoogeEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_exchange_stooge_edge_set(s : SortexchangestoogeEdge, i : Int, v : Double) -> SortexchangestoogeEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_exchange_stooge_edge_sum(s : SortexchangestoogeEdge) -> Double { @_common.sum(s.data) }

pub fn sort_exchange_stooge_edge_mean(s : SortexchangestoogeEdge) -> Double { @_common.mean(s.data) }

pub fn sort_exchange_stooge_edge_scale(s : SortexchangestoogeEdge, f : Double) -> SortexchangestoogeEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_exchange_stooge_edge_add(a : SortexchangestoogeEdge, b : SortexchangestoogeEdge) -> SortexchangestoogeEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_exchange_stooge_edge_copy(s : SortexchangestoogeEdge) -> SortexchangestoogeEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_exchange_stooge_edge_fill(s : SortexchangestoogeEdge, v : Double) -> SortexchangestoogeEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_exchange_stooge_edge_min(s : SortexchangestoogeEdge) -> Double { @_common.min(s.data) }

pub fn sort_exchange_stooge_edge_max(s : SortexchangestoogeEdge) -> Double { @_common.max(s.data) }

pub fn sort_exchange_stooge_edge_to_string(s : SortexchangestoogeEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortexchangestoogePath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_exchange_stooge_path_make(size : Int) -> SortexchangestoogePath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_exchange_stooge_path_len(s : SortexchangestoogePath) -> Int { s.size }

pub fn sort_exchange_stooge_path_get(s : SortexchangestoogePath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_exchange_stooge_path_set(s : SortexchangestoogePath, i : Int, v : Double) -> SortexchangestoogePath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_exchange_stooge_path_sum(s : SortexchangestoogePath) -> Double { @_common.sum(s.data) }

pub fn sort_exchange_stooge_path_mean(s : SortexchangestoogePath) -> Double { @_common.mean(s.data) }

pub fn sort_exchange_stooge_path_scale(s : SortexchangestoogePath, f : Double) -> SortexchangestoogePath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_exchange_stooge_path_add(a : SortexchangestoogePath, b : SortexchangestoogePath) -> SortexchangestoogePath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_exchange_stooge_path_copy(s : SortexchangestoogePath) -> SortexchangestoogePath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_exchange_stooge_path_fill(s : SortexchangestoogePath, v : Double) -> SortexchangestoogePath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_exchange_stooge_path_min(s : SortexchangestoogePath) -> Double { @_common.min(s.data) }

pub fn sort_exchange_stooge_path_max(s : SortexchangestoogePath) -> Double { @_common.max(s.data) }

pub fn sort_exchange_stooge_path_to_string(s : SortexchangestoogePath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortexchangestoogeCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_exchange_stooge_cluster_make(size : Int) -> SortexchangestoogeCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_exchange_stooge_cluster_len(s : SortexchangestoogeCluster) -> Int { s.size }

pub fn sort_exchange_stooge_cluster_get(s : SortexchangestoogeCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_exchange_stooge_cluster_set(s : SortexchangestoogeCluster, i : Int, v : Double) -> SortexchangestoogeCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_exchange_stooge_cluster_sum(s : SortexchangestoogeCluster) -> Double { @_common.sum(s.data) }

pub fn sort_exchange_stooge_cluster_mean(s : SortexchangestoogeCluster) -> Double { @_common.mean(s.data) }

pub fn sort_exchange_stooge_cluster_scale(s : SortexchangestoogeCluster, f : Double) -> SortexchangestoogeCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_exchange_stooge_cluster_add(a : SortexchangestoogeCluster, b : SortexchangestoogeCluster) -> SortexchangestoogeCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_exchange_stooge_cluster_copy(s : SortexchangestoogeCluster) -> SortexchangestoogeCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_exchange_stooge_cluster_fill(s : SortexchangestoogeCluster, v : Double) -> SortexchangestoogeCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_exchange_stooge_cluster_min(s : SortexchangestoogeCluster) -> Double { @_common.min(s.data) }

pub fn sort_exchange_stooge_cluster_max(s : SortexchangestoogeCluster) -> Double { @_common.max(s.data) }

pub fn sort_exchange_stooge_cluster_to_string(s : SortexchangestoogeCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortexchangestoogeModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_exchange_stooge_model_make(size : Int) -> SortexchangestoogeModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_exchange_stooge_model_len(s : SortexchangestoogeModel) -> Int { s.size }

pub fn sort_exchange_stooge_model_get(s : SortexchangestoogeModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_exchange_stooge_model_set(s : SortexchangestoogeModel, i : Int, v : Double) -> SortexchangestoogeModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_exchange_stooge_model_sum(s : SortexchangestoogeModel) -> Double { @_common.sum(s.data) }

pub fn sort_exchange_stooge_model_mean(s : SortexchangestoogeModel) -> Double { @_common.mean(s.data) }

pub fn sort_exchange_stooge_model_scale(s : SortexchangestoogeModel, f : Double) -> SortexchangestoogeModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_exchange_stooge_model_add(a : SortexchangestoogeModel, b : SortexchangestoogeModel) -> SortexchangestoogeModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_exchange_stooge_model_copy(s : SortexchangestoogeModel) -> SortexchangestoogeModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_exchange_stooge_model_fill(s : SortexchangestoogeModel, v : Double) -> SortexchangestoogeModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_exchange_stooge_model_min(s : SortexchangestoogeModel) -> Double { @_common.min(s.data) }

pub fn sort_exchange_stooge_model_max(s : SortexchangestoogeModel) -> Double { @_common.max(s.data) }

pub fn sort_exchange_stooge_model_to_string(s : SortexchangestoogeModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortexchangestoogeLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_exchange_stooge_layer_make(size : Int) -> SortexchangestoogeLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_exchange_stooge_layer_len(s : SortexchangestoogeLayer) -> Int { s.size }

pub fn sort_exchange_stooge_layer_get(s : SortexchangestoogeLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_exchange_stooge_layer_set(s : SortexchangestoogeLayer, i : Int, v : Double) -> SortexchangestoogeLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_exchange_stooge_layer_sum(s : SortexchangestoogeLayer) -> Double { @_common.sum(s.data) }

pub fn sort_exchange_stooge_layer_mean(s : SortexchangestoogeLayer) -> Double { @_common.mean(s.data) }

pub fn sort_exchange_stooge_layer_scale(s : SortexchangestoogeLayer, f : Double) -> SortexchangestoogeLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_exchange_stooge_layer_add(a : SortexchangestoogeLayer, b : SortexchangestoogeLayer) -> SortexchangestoogeLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_exchange_stooge_layer_copy(s : SortexchangestoogeLayer) -> SortexchangestoogeLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_exchange_stooge_layer_fill(s : SortexchangestoogeLayer, v : Double) -> SortexchangestoogeLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_exchange_stooge_layer_min(s : SortexchangestoogeLayer) -> Double { @_common.min(s.data) }

pub fn sort_exchange_stooge_layer_max(s : SortexchangestoogeLayer) -> Double { @_common.max(s.data) }

pub fn sort_exchange_stooge_layer_to_string(s : SortexchangestoogeLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortexchangestoogeBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_exchange_stooge_buffer_make(size : Int) -> SortexchangestoogeBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_exchange_stooge_buffer_len(s : SortexchangestoogeBuffer) -> Int { s.size }

pub fn sort_exchange_stooge_buffer_get(s : SortexchangestoogeBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_exchange_stooge_buffer_set(s : SortexchangestoogeBuffer, i : Int, v : Double) -> SortexchangestoogeBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_exchange_stooge_buffer_sum(s : SortexchangestoogeBuffer) -> Double { @_common.sum(s.data) }

pub fn sort_exchange_stooge_buffer_mean(s : SortexchangestoogeBuffer) -> Double { @_common.mean(s.data) }

pub fn sort_exchange_stooge_buffer_scale(s : SortexchangestoogeBuffer, f : Double) -> SortexchangestoogeBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_exchange_stooge_buffer_add(a : SortexchangestoogeBuffer, b : SortexchangestoogeBuffer) -> SortexchangestoogeBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_exchange_stooge_buffer_copy(s : SortexchangestoogeBuffer) -> SortexchangestoogeBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_exchange_stooge_buffer_fill(s : SortexchangestoogeBuffer, v : Double) -> SortexchangestoogeBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_exchange_stooge_buffer_min(s : SortexchangestoogeBuffer) -> Double { @_common.min(s.data) }

pub fn sort_exchange_stooge_buffer_max(s : SortexchangestoogeBuffer) -> Double { @_common.max(s.data) }

pub fn sort_exchange_stooge_buffer_to_string(s : SortexchangestoogeBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortexchangestoogeCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_exchange_stooge_cursor_make(size : Int) -> SortexchangestoogeCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_exchange_stooge_cursor_len(s : SortexchangestoogeCursor) -> Int { s.size }

pub fn sort_exchange_stooge_cursor_get(s : SortexchangestoogeCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_exchange_stooge_cursor_set(s : SortexchangestoogeCursor, i : Int, v : Double) -> SortexchangestoogeCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_exchange_stooge_cursor_sum(s : SortexchangestoogeCursor) -> Double { @_common.sum(s.data) }

pub fn sort_exchange_stooge_cursor_mean(s : SortexchangestoogeCursor) -> Double { @_common.mean(s.data) }

pub fn sort_exchange_stooge_cursor_scale(s : SortexchangestoogeCursor, f : Double) -> SortexchangestoogeCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_exchange_stooge_cursor_add(a : SortexchangestoogeCursor, b : SortexchangestoogeCursor) -> SortexchangestoogeCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_exchange_stooge_cursor_copy(s : SortexchangestoogeCursor) -> SortexchangestoogeCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_exchange_stooge_cursor_fill(s : SortexchangestoogeCursor, v : Double) -> SortexchangestoogeCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_exchange_stooge_cursor_min(s : SortexchangestoogeCursor) -> Double { @_common.min(s.data) }

pub fn sort_exchange_stooge_cursor_max(s : SortexchangestoogeCursor) -> Double { @_common.max(s.data) }

pub fn sort_exchange_stooge_cursor_to_string(s : SortexchangestoogeCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortexchangestoogeView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_exchange_stooge_view_make(size : Int) -> SortexchangestoogeView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_exchange_stooge_view_len(s : SortexchangestoogeView) -> Int { s.size }

pub fn sort_exchange_stooge_view_get(s : SortexchangestoogeView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_exchange_stooge_view_set(s : SortexchangestoogeView, i : Int, v : Double) -> SortexchangestoogeView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_exchange_stooge_view_sum(s : SortexchangestoogeView) -> Double { @_common.sum(s.data) }

pub fn sort_exchange_stooge_view_mean(s : SortexchangestoogeView) -> Double { @_common.mean(s.data) }

pub fn sort_exchange_stooge_view_scale(s : SortexchangestoogeView, f : Double) -> SortexchangestoogeView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_exchange_stooge_view_add(a : SortexchangestoogeView, b : SortexchangestoogeView) -> SortexchangestoogeView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_exchange_stooge_view_copy(s : SortexchangestoogeView) -> SortexchangestoogeView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_exchange_stooge_view_fill(s : SortexchangestoogeView, v : Double) -> SortexchangestoogeView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_exchange_stooge_view_min(s : SortexchangestoogeView) -> Double { @_common.min(s.data) }

pub fn sort_exchange_stooge_view_max(s : SortexchangestoogeView) -> Double { @_common.max(s.data) }

pub fn sort_exchange_stooge_view_to_string(s : SortexchangestoogeView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortexchangestoogeRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_exchange_stooge_range_make(size : Int) -> SortexchangestoogeRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_exchange_stooge_range_len(s : SortexchangestoogeRange) -> Int { s.size }

pub fn sort_exchange_stooge_range_get(s : SortexchangestoogeRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_exchange_stooge_range_set(s : SortexchangestoogeRange, i : Int, v : Double) -> SortexchangestoogeRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_exchange_stooge_range_sum(s : SortexchangestoogeRange) -> Double { @_common.sum(s.data) }

pub fn sort_exchange_stooge_range_mean(s : SortexchangestoogeRange) -> Double { @_common.mean(s.data) }

pub fn sort_exchange_stooge_range_scale(s : SortexchangestoogeRange, f : Double) -> SortexchangestoogeRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_exchange_stooge_range_add(a : SortexchangestoogeRange, b : SortexchangestoogeRange) -> SortexchangestoogeRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_exchange_stooge_range_copy(s : SortexchangestoogeRange) -> SortexchangestoogeRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_exchange_stooge_range_fill(s : SortexchangestoogeRange, v : Double) -> SortexchangestoogeRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_exchange_stooge_range_min(s : SortexchangestoogeRange) -> Double { @_common.min(s.data) }

pub fn sort_exchange_stooge_range_max(s : SortexchangestoogeRange) -> Double { @_common.max(s.data) }

pub fn sort_exchange_stooge_range_to_string(s : SortexchangestoogeRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortexchangestoogeSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_exchange_stooge_slice_make(size : Int) -> SortexchangestoogeSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_exchange_stooge_slice_len(s : SortexchangestoogeSlice) -> Int { s.size }

pub fn sort_exchange_stooge_slice_get(s : SortexchangestoogeSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_exchange_stooge_slice_set(s : SortexchangestoogeSlice, i : Int, v : Double) -> SortexchangestoogeSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_exchange_stooge_slice_sum(s : SortexchangestoogeSlice) -> Double { @_common.sum(s.data) }

pub fn sort_exchange_stooge_slice_mean(s : SortexchangestoogeSlice) -> Double { @_common.mean(s.data) }

pub fn sort_exchange_stooge_slice_scale(s : SortexchangestoogeSlice, f : Double) -> SortexchangestoogeSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_exchange_stooge_slice_add(a : SortexchangestoogeSlice, b : SortexchangestoogeSlice) -> SortexchangestoogeSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_exchange_stooge_slice_copy(s : SortexchangestoogeSlice) -> SortexchangestoogeSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_exchange_stooge_slice_fill(s : SortexchangestoogeSlice, v : Double) -> SortexchangestoogeSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_exchange_stooge_slice_min(s : SortexchangestoogeSlice) -> Double { @_common.min(s.data) }

pub fn sort_exchange_stooge_slice_max(s : SortexchangestoogeSlice) -> Double { @_common.max(s.data) }

pub fn sort_exchange_stooge_slice_to_string(s : SortexchangestoogeSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

