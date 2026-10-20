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

pub fn SortexchangestoogeFrame::len(self : SortexchangestoogeFrame) -> Int { self.size }

pub fn SortexchangestoogeFrame::get(self : SortexchangestoogeFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SortexchangestoogeFrame::set(self : SortexchangestoogeFrame, i : Int, v : Double) -> SortexchangestoogeFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SortexchangestoogeFrame::sum(self : SortexchangestoogeFrame) -> Double { @_common.sum(self.data) }

pub fn SortexchangestoogeFrame::mean(self : SortexchangestoogeFrame) -> Double { @_common.mean(self.data) }

pub fn SortexchangestoogeFrame::scale(self : SortexchangestoogeFrame, f : Double) -> SortexchangestoogeFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SortexchangestoogeFrame::add(self : SortexchangestoogeFrame, other : SortexchangestoogeFrame) -> SortexchangestoogeFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SortexchangestoogeFrame::copy(self : SortexchangestoogeFrame) -> SortexchangestoogeFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SortexchangestoogeFrame::fill(self : SortexchangestoogeFrame, v : Double) -> SortexchangestoogeFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SortexchangestoogeFrame::min(self : SortexchangestoogeFrame) -> Double { @_common.min(self.data) }

pub fn SortexchangestoogeFrame::max(self : SortexchangestoogeFrame) -> Double { @_common.max(self.data) }

pub fn SortexchangestoogeFrame::to_string(self : SortexchangestoogeFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SortexchangestoogeTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_exchange_stooge_table_make(size : Int) -> SortexchangestoogeTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SortexchangestoogeTable::len(self : SortexchangestoogeTable) -> Int { self.size }

pub fn SortexchangestoogeTable::get(self : SortexchangestoogeTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SortexchangestoogeTable::set(self : SortexchangestoogeTable, i : Int, v : Double) -> SortexchangestoogeTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SortexchangestoogeTable::sum(self : SortexchangestoogeTable) -> Double { @_common.sum(self.data) }

pub fn SortexchangestoogeTable::mean(self : SortexchangestoogeTable) -> Double { @_common.mean(self.data) }

pub fn SortexchangestoogeTable::scale(self : SortexchangestoogeTable, f : Double) -> SortexchangestoogeTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SortexchangestoogeTable::add(self : SortexchangestoogeTable, other : SortexchangestoogeTable) -> SortexchangestoogeTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SortexchangestoogeTable::copy(self : SortexchangestoogeTable) -> SortexchangestoogeTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SortexchangestoogeTable::fill(self : SortexchangestoogeTable, v : Double) -> SortexchangestoogeTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SortexchangestoogeTable::min(self : SortexchangestoogeTable) -> Double { @_common.min(self.data) }

pub fn SortexchangestoogeTable::max(self : SortexchangestoogeTable) -> Double { @_common.max(self.data) }

pub fn SortexchangestoogeTable::to_string(self : SortexchangestoogeTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SortexchangestoogeGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_exchange_stooge_graphn_make(size : Int) -> SortexchangestoogeGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SortexchangestoogeGraphN::len(self : SortexchangestoogeGraphN) -> Int { self.size }

pub fn SortexchangestoogeGraphN::get(self : SortexchangestoogeGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SortexchangestoogeGraphN::set(self : SortexchangestoogeGraphN, i : Int, v : Double) -> SortexchangestoogeGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SortexchangestoogeGraphN::sum(self : SortexchangestoogeGraphN) -> Double { @_common.sum(self.data) }

pub fn SortexchangestoogeGraphN::mean(self : SortexchangestoogeGraphN) -> Double { @_common.mean(self.data) }

pub fn SortexchangestoogeGraphN::scale(self : SortexchangestoogeGraphN, f : Double) -> SortexchangestoogeGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SortexchangestoogeGraphN::add(self : SortexchangestoogeGraphN, other : SortexchangestoogeGraphN) -> SortexchangestoogeGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SortexchangestoogeGraphN::copy(self : SortexchangestoogeGraphN) -> SortexchangestoogeGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SortexchangestoogeGraphN::fill(self : SortexchangestoogeGraphN, v : Double) -> SortexchangestoogeGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SortexchangestoogeGraphN::min(self : SortexchangestoogeGraphN) -> Double { @_common.min(self.data) }

pub fn SortexchangestoogeGraphN::max(self : SortexchangestoogeGraphN) -> Double { @_common.max(self.data) }

pub fn SortexchangestoogeGraphN::to_string(self : SortexchangestoogeGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SortexchangestoogeNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_exchange_stooge_node_make(size : Int) -> SortexchangestoogeNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SortexchangestoogeNode::len(self : SortexchangestoogeNode) -> Int { self.size }

pub fn SortexchangestoogeNode::get(self : SortexchangestoogeNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SortexchangestoogeNode::set(self : SortexchangestoogeNode, i : Int, v : Double) -> SortexchangestoogeNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SortexchangestoogeNode::sum(self : SortexchangestoogeNode) -> Double { @_common.sum(self.data) }

pub fn SortexchangestoogeNode::mean(self : SortexchangestoogeNode) -> Double { @_common.mean(self.data) }

pub fn SortexchangestoogeNode::scale(self : SortexchangestoogeNode, f : Double) -> SortexchangestoogeNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SortexchangestoogeNode::add(self : SortexchangestoogeNode, other : SortexchangestoogeNode) -> SortexchangestoogeNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SortexchangestoogeNode::copy(self : SortexchangestoogeNode) -> SortexchangestoogeNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SortexchangestoogeNode::fill(self : SortexchangestoogeNode, v : Double) -> SortexchangestoogeNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SortexchangestoogeNode::min(self : SortexchangestoogeNode) -> Double { @_common.min(self.data) }

pub fn SortexchangestoogeNode::max(self : SortexchangestoogeNode) -> Double { @_common.max(self.data) }

pub fn SortexchangestoogeNode::to_string(self : SortexchangestoogeNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SortexchangestoogeEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_exchange_stooge_edge_make(size : Int) -> SortexchangestoogeEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SortexchangestoogeEdge::len(self : SortexchangestoogeEdge) -> Int { self.size }

pub fn SortexchangestoogeEdge::get(self : SortexchangestoogeEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SortexchangestoogeEdge::set(self : SortexchangestoogeEdge, i : Int, v : Double) -> SortexchangestoogeEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SortexchangestoogeEdge::sum(self : SortexchangestoogeEdge) -> Double { @_common.sum(self.data) }

pub fn SortexchangestoogeEdge::mean(self : SortexchangestoogeEdge) -> Double { @_common.mean(self.data) }

pub fn SortexchangestoogeEdge::scale(self : SortexchangestoogeEdge, f : Double) -> SortexchangestoogeEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SortexchangestoogeEdge::add(self : SortexchangestoogeEdge, other : SortexchangestoogeEdge) -> SortexchangestoogeEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SortexchangestoogeEdge::copy(self : SortexchangestoogeEdge) -> SortexchangestoogeEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SortexchangestoogeEdge::fill(self : SortexchangestoogeEdge, v : Double) -> SortexchangestoogeEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SortexchangestoogeEdge::min(self : SortexchangestoogeEdge) -> Double { @_common.min(self.data) }

pub fn SortexchangestoogeEdge::max(self : SortexchangestoogeEdge) -> Double { @_common.max(self.data) }

pub fn SortexchangestoogeEdge::to_string(self : SortexchangestoogeEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SortexchangestoogePath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_exchange_stooge_path_make(size : Int) -> SortexchangestoogePath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SortexchangestoogePath::len(self : SortexchangestoogePath) -> Int { self.size }

pub fn SortexchangestoogePath::get(self : SortexchangestoogePath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SortexchangestoogePath::set(self : SortexchangestoogePath, i : Int, v : Double) -> SortexchangestoogePath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SortexchangestoogePath::sum(self : SortexchangestoogePath) -> Double { @_common.sum(self.data) }

pub fn SortexchangestoogePath::mean(self : SortexchangestoogePath) -> Double { @_common.mean(self.data) }

pub fn SortexchangestoogePath::scale(self : SortexchangestoogePath, f : Double) -> SortexchangestoogePath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SortexchangestoogePath::add(self : SortexchangestoogePath, other : SortexchangestoogePath) -> SortexchangestoogePath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SortexchangestoogePath::copy(self : SortexchangestoogePath) -> SortexchangestoogePath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SortexchangestoogePath::fill(self : SortexchangestoogePath, v : Double) -> SortexchangestoogePath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SortexchangestoogePath::min(self : SortexchangestoogePath) -> Double { @_common.min(self.data) }

pub fn SortexchangestoogePath::max(self : SortexchangestoogePath) -> Double { @_common.max(self.data) }

pub fn SortexchangestoogePath::to_string(self : SortexchangestoogePath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SortexchangestoogeCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_exchange_stooge_cluster_make(size : Int) -> SortexchangestoogeCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SortexchangestoogeCluster::len(self : SortexchangestoogeCluster) -> Int { self.size }

pub fn SortexchangestoogeCluster::get(self : SortexchangestoogeCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SortexchangestoogeCluster::set(self : SortexchangestoogeCluster, i : Int, v : Double) -> SortexchangestoogeCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SortexchangestoogeCluster::sum(self : SortexchangestoogeCluster) -> Double { @_common.sum(self.data) }

pub fn SortexchangestoogeCluster::mean(self : SortexchangestoogeCluster) -> Double { @_common.mean(self.data) }

pub fn SortexchangestoogeCluster::scale(self : SortexchangestoogeCluster, f : Double) -> SortexchangestoogeCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SortexchangestoogeCluster::add(self : SortexchangestoogeCluster, other : SortexchangestoogeCluster) -> SortexchangestoogeCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SortexchangestoogeCluster::copy(self : SortexchangestoogeCluster) -> SortexchangestoogeCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SortexchangestoogeCluster::fill(self : SortexchangestoogeCluster, v : Double) -> SortexchangestoogeCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SortexchangestoogeCluster::min(self : SortexchangestoogeCluster) -> Double { @_common.min(self.data) }

pub fn SortexchangestoogeCluster::max(self : SortexchangestoogeCluster) -> Double { @_common.max(self.data) }

pub fn SortexchangestoogeCluster::to_string(self : SortexchangestoogeCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SortexchangestoogeModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_exchange_stooge_model_make(size : Int) -> SortexchangestoogeModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SortexchangestoogeModel::len(self : SortexchangestoogeModel) -> Int { self.size }

pub fn SortexchangestoogeModel::get(self : SortexchangestoogeModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SortexchangestoogeModel::set(self : SortexchangestoogeModel, i : Int, v : Double) -> SortexchangestoogeModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SortexchangestoogeModel::sum(self : SortexchangestoogeModel) -> Double { @_common.sum(self.data) }

pub fn SortexchangestoogeModel::mean(self : SortexchangestoogeModel) -> Double { @_common.mean(self.data) }

pub fn SortexchangestoogeModel::scale(self : SortexchangestoogeModel, f : Double) -> SortexchangestoogeModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SortexchangestoogeModel::add(self : SortexchangestoogeModel, other : SortexchangestoogeModel) -> SortexchangestoogeModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SortexchangestoogeModel::copy(self : SortexchangestoogeModel) -> SortexchangestoogeModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SortexchangestoogeModel::fill(self : SortexchangestoogeModel, v : Double) -> SortexchangestoogeModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SortexchangestoogeModel::min(self : SortexchangestoogeModel) -> Double { @_common.min(self.data) }

pub fn SortexchangestoogeModel::max(self : SortexchangestoogeModel) -> Double { @_common.max(self.data) }

pub fn SortexchangestoogeModel::to_string(self : SortexchangestoogeModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SortexchangestoogeLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_exchange_stooge_layer_make(size : Int) -> SortexchangestoogeLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SortexchangestoogeLayer::len(self : SortexchangestoogeLayer) -> Int { self.size }

pub fn SortexchangestoogeLayer::get(self : SortexchangestoogeLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SortexchangestoogeLayer::set(self : SortexchangestoogeLayer, i : Int, v : Double) -> SortexchangestoogeLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SortexchangestoogeLayer::sum(self : SortexchangestoogeLayer) -> Double { @_common.sum(self.data) }

pub fn SortexchangestoogeLayer::mean(self : SortexchangestoogeLayer) -> Double { @_common.mean(self.data) }

pub fn SortexchangestoogeLayer::scale(self : SortexchangestoogeLayer, f : Double) -> SortexchangestoogeLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SortexchangestoogeLayer::add(self : SortexchangestoogeLayer, other : SortexchangestoogeLayer) -> SortexchangestoogeLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SortexchangestoogeLayer::copy(self : SortexchangestoogeLayer) -> SortexchangestoogeLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SortexchangestoogeLayer::fill(self : SortexchangestoogeLayer, v : Double) -> SortexchangestoogeLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SortexchangestoogeLayer::min(self : SortexchangestoogeLayer) -> Double { @_common.min(self.data) }

pub fn SortexchangestoogeLayer::max(self : SortexchangestoogeLayer) -> Double { @_common.max(self.data) }

pub fn SortexchangestoogeLayer::to_string(self : SortexchangestoogeLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SortexchangestoogeBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_exchange_stooge_buffer_make(size : Int) -> SortexchangestoogeBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SortexchangestoogeBuffer::len(self : SortexchangestoogeBuffer) -> Int { self.size }

pub fn SortexchangestoogeBuffer::get(self : SortexchangestoogeBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SortexchangestoogeBuffer::set(self : SortexchangestoogeBuffer, i : Int, v : Double) -> SortexchangestoogeBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SortexchangestoogeBuffer::sum(self : SortexchangestoogeBuffer) -> Double { @_common.sum(self.data) }

pub fn SortexchangestoogeBuffer::mean(self : SortexchangestoogeBuffer) -> Double { @_common.mean(self.data) }

pub fn SortexchangestoogeBuffer::scale(self : SortexchangestoogeBuffer, f : Double) -> SortexchangestoogeBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SortexchangestoogeBuffer::add(self : SortexchangestoogeBuffer, other : SortexchangestoogeBuffer) -> SortexchangestoogeBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SortexchangestoogeBuffer::copy(self : SortexchangestoogeBuffer) -> SortexchangestoogeBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SortexchangestoogeBuffer::fill(self : SortexchangestoogeBuffer, v : Double) -> SortexchangestoogeBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SortexchangestoogeBuffer::min(self : SortexchangestoogeBuffer) -> Double { @_common.min(self.data) }

pub fn SortexchangestoogeBuffer::max(self : SortexchangestoogeBuffer) -> Double { @_common.max(self.data) }

pub fn SortexchangestoogeBuffer::to_string(self : SortexchangestoogeBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SortexchangestoogeCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_exchange_stooge_cursor_make(size : Int) -> SortexchangestoogeCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SortexchangestoogeCursor::len(self : SortexchangestoogeCursor) -> Int { self.size }

pub fn SortexchangestoogeCursor::get(self : SortexchangestoogeCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SortexchangestoogeCursor::set(self : SortexchangestoogeCursor, i : Int, v : Double) -> SortexchangestoogeCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SortexchangestoogeCursor::sum(self : SortexchangestoogeCursor) -> Double { @_common.sum(self.data) }

pub fn SortexchangestoogeCursor::mean(self : SortexchangestoogeCursor) -> Double { @_common.mean(self.data) }

pub fn SortexchangestoogeCursor::scale(self : SortexchangestoogeCursor, f : Double) -> SortexchangestoogeCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SortexchangestoogeCursor::add(self : SortexchangestoogeCursor, other : SortexchangestoogeCursor) -> SortexchangestoogeCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SortexchangestoogeCursor::copy(self : SortexchangestoogeCursor) -> SortexchangestoogeCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SortexchangestoogeCursor::fill(self : SortexchangestoogeCursor, v : Double) -> SortexchangestoogeCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SortexchangestoogeCursor::min(self : SortexchangestoogeCursor) -> Double { @_common.min(self.data) }

pub fn SortexchangestoogeCursor::max(self : SortexchangestoogeCursor) -> Double { @_common.max(self.data) }

pub fn SortexchangestoogeCursor::to_string(self : SortexchangestoogeCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SortexchangestoogeView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_exchange_stooge_view_make(size : Int) -> SortexchangestoogeView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SortexchangestoogeView::len(self : SortexchangestoogeView) -> Int { self.size }

pub fn SortexchangestoogeView::get(self : SortexchangestoogeView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SortexchangestoogeView::set(self : SortexchangestoogeView, i : Int, v : Double) -> SortexchangestoogeView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SortexchangestoogeView::sum(self : SortexchangestoogeView) -> Double { @_common.sum(self.data) }

pub fn SortexchangestoogeView::mean(self : SortexchangestoogeView) -> Double { @_common.mean(self.data) }

pub fn SortexchangestoogeView::scale(self : SortexchangestoogeView, f : Double) -> SortexchangestoogeView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SortexchangestoogeView::add(self : SortexchangestoogeView, other : SortexchangestoogeView) -> SortexchangestoogeView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SortexchangestoogeView::copy(self : SortexchangestoogeView) -> SortexchangestoogeView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SortexchangestoogeView::fill(self : SortexchangestoogeView, v : Double) -> SortexchangestoogeView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SortexchangestoogeView::min(self : SortexchangestoogeView) -> Double { @_common.min(self.data) }

pub fn SortexchangestoogeView::max(self : SortexchangestoogeView) -> Double { @_common.max(self.data) }

pub fn SortexchangestoogeView::to_string(self : SortexchangestoogeView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SortexchangestoogeRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_exchange_stooge_range_make(size : Int) -> SortexchangestoogeRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SortexchangestoogeRange::len(self : SortexchangestoogeRange) -> Int { self.size }

pub fn SortexchangestoogeRange::get(self : SortexchangestoogeRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SortexchangestoogeRange::set(self : SortexchangestoogeRange, i : Int, v : Double) -> SortexchangestoogeRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SortexchangestoogeRange::sum(self : SortexchangestoogeRange) -> Double { @_common.sum(self.data) }

pub fn SortexchangestoogeRange::mean(self : SortexchangestoogeRange) -> Double { @_common.mean(self.data) }

pub fn SortexchangestoogeRange::scale(self : SortexchangestoogeRange, f : Double) -> SortexchangestoogeRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SortexchangestoogeRange::add(self : SortexchangestoogeRange, other : SortexchangestoogeRange) -> SortexchangestoogeRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SortexchangestoogeRange::copy(self : SortexchangestoogeRange) -> SortexchangestoogeRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SortexchangestoogeRange::fill(self : SortexchangestoogeRange, v : Double) -> SortexchangestoogeRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SortexchangestoogeRange::min(self : SortexchangestoogeRange) -> Double { @_common.min(self.data) }

pub fn SortexchangestoogeRange::max(self : SortexchangestoogeRange) -> Double { @_common.max(self.data) }

pub fn SortexchangestoogeRange::to_string(self : SortexchangestoogeRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SortexchangestoogeSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_exchange_stooge_slice_make(size : Int) -> SortexchangestoogeSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SortexchangestoogeSlice::len(self : SortexchangestoogeSlice) -> Int { self.size }

pub fn SortexchangestoogeSlice::get(self : SortexchangestoogeSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SortexchangestoogeSlice::set(self : SortexchangestoogeSlice, i : Int, v : Double) -> SortexchangestoogeSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SortexchangestoogeSlice::sum(self : SortexchangestoogeSlice) -> Double { @_common.sum(self.data) }

pub fn SortexchangestoogeSlice::mean(self : SortexchangestoogeSlice) -> Double { @_common.mean(self.data) }

pub fn SortexchangestoogeSlice::scale(self : SortexchangestoogeSlice, f : Double) -> SortexchangestoogeSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SortexchangestoogeSlice::add(self : SortexchangestoogeSlice, other : SortexchangestoogeSlice) -> SortexchangestoogeSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SortexchangestoogeSlice::copy(self : SortexchangestoogeSlice) -> SortexchangestoogeSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SortexchangestoogeSlice::fill(self : SortexchangestoogeSlice, v : Double) -> SortexchangestoogeSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SortexchangestoogeSlice::min(self : SortexchangestoogeSlice) -> Double { @_common.min(self.data) }

pub fn SortexchangestoogeSlice::max(self : SortexchangestoogeSlice) -> Double { @_common.max(self.data) }

pub fn SortexchangestoogeSlice::to_string(self : SortexchangestoogeSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

