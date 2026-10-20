///===
/// extcore/sort_exchange_odd_even

pub(all) struct SortexchangeoddevenPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn sort_exchange_odd_even_make_point(x : Double, y : Double) -> SortexchangeoddevenPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn sort_exchange_odd_even_make_point3(x : Double, y : Double, z : Double) -> SortexchangeoddevenPoint {
  { x, y, z, label: 0 }
}

pub fn SortexchangeoddevenPoint::x(self : SortexchangeoddevenPoint) -> Double { self.x }

pub fn SortexchangeoddevenPoint::y(self : SortexchangeoddevenPoint) -> Double { self.y }

pub fn SortexchangeoddevenPoint::z(self : SortexchangeoddevenPoint) -> Double { self.z }

pub fn SortexchangeoddevenPoint::label(self : SortexchangeoddevenPoint) -> Int { self.label }

pub fn SortexchangeoddevenPoint::dist(self : SortexchangeoddevenPoint, other : SortexchangeoddevenPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn SortexchangeoddevenPoint::add(self : SortexchangeoddevenPoint, other : SortexchangeoddevenPoint) -> SortexchangeoddevenPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn SortexchangeoddevenPoint::sub(self : SortexchangeoddevenPoint, other : SortexchangeoddevenPoint) -> SortexchangeoddevenPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn SortexchangeoddevenPoint::scale(self : SortexchangeoddevenPoint, s : Double) -> SortexchangeoddevenPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn SortexchangeoddevenPoint::dot(self : SortexchangeoddevenPoint, other : SortexchangeoddevenPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn SortexchangeoddevenPoint::cross(self : SortexchangeoddevenPoint, other : SortexchangeoddevenPoint) -> SortexchangeoddevenPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn SortexchangeoddevenPoint::norm(self : SortexchangeoddevenPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn SortexchangeoddevenPoint::normalize(self : SortexchangeoddevenPoint) -> SortexchangeoddevenPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn SortexchangeoddevenPoint::negate(self : SortexchangeoddevenPoint) -> SortexchangeoddevenPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn SortexchangeoddevenPoint::mid(self : SortexchangeoddevenPoint, other : SortexchangeoddevenPoint) -> SortexchangeoddevenPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn SortexchangeoddevenPoint::lerp(self : SortexchangeoddevenPoint, other : SortexchangeoddevenPoint, t : Double) -> SortexchangeoddevenPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn SortexchangeoddevenPoint::to_string(self : SortexchangeoddevenPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct SortexchangeoddevenSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn sort_exchange_odd_even_make_series(vals : Array[Double], name : String) -> SortexchangeoddevenSeries {
  { vals, name, meta: 0 }
}

pub fn SortexchangeoddevenSeries::len(self : SortexchangeoddevenSeries) -> Int { self.vals.length() }

pub fn SortexchangeoddevenSeries::sum(self : SortexchangeoddevenSeries) -> Double { @_common.sum(self.vals) }

pub fn SortexchangeoddevenSeries::mean(self : SortexchangeoddevenSeries) -> Double { @_common.mean(self.vals) }

pub fn SortexchangeoddevenSeries::min(self : SortexchangeoddevenSeries) -> Double { @_common.min(self.vals) }

pub fn SortexchangeoddevenSeries::max(self : SortexchangeoddevenSeries) -> Double { @_common.max(self.vals) }

pub fn SortexchangeoddevenSeries::range(self : SortexchangeoddevenSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn SortexchangeoddevenSeries::variance(self : SortexchangeoddevenSeries) -> Double { @_common.variance(self.vals) }

pub fn SortexchangeoddevenSeries::std(self : SortexchangeoddevenSeries) -> Double { @_common.std(self.vals) }

pub fn SortexchangeoddevenSeries::median(self : SortexchangeoddevenSeries) -> Double { @_common.median(self.vals) }

pub fn SortexchangeoddevenSeries::scale(self : SortexchangeoddevenSeries, f : Double) -> SortexchangeoddevenSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn SortexchangeoddevenSeries::add(self : SortexchangeoddevenSeries, other : SortexchangeoddevenSeries) -> SortexchangeoddevenSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn SortexchangeoddevenSeries::sub(self : SortexchangeoddevenSeries, other : SortexchangeoddevenSeries) -> SortexchangeoddevenSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn SortexchangeoddevenSeries::normalize(self : SortexchangeoddevenSeries) -> SortexchangeoddevenSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn SortexchangeoddevenSeries::cumsum(self : SortexchangeoddevenSeries) -> SortexchangeoddevenSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn SortexchangeoddevenSeries::to_string(self : SortexchangeoddevenSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct SortexchangeoddevenMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn sort_exchange_odd_even_make_matrix(rows : Int, cols : Int, val : Double) -> SortexchangeoddevenMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn sort_exchange_odd_even_matrix_identity(n : Int) -> SortexchangeoddevenMatrix {
  let m = sort_exchange_odd_even_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn SortexchangeoddevenMatrix::get(self : SortexchangeoddevenMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn SortexchangeoddevenMatrix::transpose(self : SortexchangeoddevenMatrix) -> SortexchangeoddevenMatrix {
  let result = sort_exchange_odd_even_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn SortexchangeoddevenMatrix::add(self : SortexchangeoddevenMatrix, other : SortexchangeoddevenMatrix) -> SortexchangeoddevenMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = sort_exchange_odd_even_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn SortexchangeoddevenMatrix::scale(self : SortexchangeoddevenMatrix, s : Double) -> SortexchangeoddevenMatrix {
  let result = sort_exchange_odd_even_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn SortexchangeoddevenMatrix::multiply(self : SortexchangeoddevenMatrix, other : SortexchangeoddevenMatrix) -> SortexchangeoddevenMatrix {
  if self.cols != other.rows { return sort_exchange_odd_even_make_matrix(self.rows, other.cols, 0.0) }
  let result = sort_exchange_odd_even_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn SortexchangeoddevenMatrix::trace(self : SortexchangeoddevenMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn SortexchangeoddevenMatrix::det(self : SortexchangeoddevenMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn SortexchangeoddevenMatrix::norm(self : SortexchangeoddevenMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn SortexchangeoddevenMatrix::to_string(self : SortexchangeoddevenMatrix) -> String {
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

pub(all) struct SortexchangeoddevenVector {
  comps : Array[Double]
  dim : Int
}

pub fn sort_exchange_odd_even_make_vector(comps : Array[Double]) -> SortexchangeoddevenVector {
  { comps, dim: comps.length() }
}

pub fn sort_exchange_odd_even_vector_zero(dim : Int) -> SortexchangeoddevenVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn SortexchangeoddevenVector::add(self : SortexchangeoddevenVector, other : SortexchangeoddevenVector) -> SortexchangeoddevenVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn SortexchangeoddevenVector::sub(self : SortexchangeoddevenVector, other : SortexchangeoddevenVector) -> SortexchangeoddevenVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn SortexchangeoddevenVector::scale(self : SortexchangeoddevenVector, s : Double) -> SortexchangeoddevenVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn SortexchangeoddevenVector::dot(self : SortexchangeoddevenVector, other : SortexchangeoddevenVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn SortexchangeoddevenVector::norm(self : SortexchangeoddevenVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn SortexchangeoddevenVector::normalize(self : SortexchangeoddevenVector) -> SortexchangeoddevenVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn SortexchangeoddevenVector::dist(self : SortexchangeoddevenVector, other : SortexchangeoddevenVector) -> Double {
  self.sub(other).norm()
}

pub fn SortexchangeoddevenVector::to_string(self : SortexchangeoddevenVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn sort_exchange_odd_even_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn sort_exchange_odd_even_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn sort_exchange_odd_even_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn sort_exchange_odd_even_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn sort_exchange_odd_even_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn sort_exchange_odd_even_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn sort_exchange_odd_even_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn sort_exchange_odd_even_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn sort_exchange_odd_even_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn sort_exchange_odd_even_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn sort_exchange_odd_even_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn sort_exchange_odd_even_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn sort_exchange_odd_even_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn sort_exchange_odd_even_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn sort_exchange_odd_even_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn sort_exchange_odd_even_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn sort_exchange_odd_even_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn sort_exchange_odd_even_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn sort_exchange_odd_even_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn sort_exchange_odd_even_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn sort_exchange_odd_even_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn sort_exchange_odd_even_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn sort_exchange_odd_even_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn sort_exchange_odd_even_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn sort_exchange_odd_even_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn sort_exchange_odd_even_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn sort_exchange_odd_even_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn sort_exchange_odd_even_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn sort_exchange_odd_even_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct SortexchangeoddevenFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_exchange_odd_even_frame_make(size : Int) -> SortexchangeoddevenFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_exchange_odd_even_frame_len(s : SortexchangeoddevenFrame) -> Int { s.size }

pub fn sort_exchange_odd_even_frame_get(s : SortexchangeoddevenFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_exchange_odd_even_frame_set(s : SortexchangeoddevenFrame, i : Int, v : Double) -> SortexchangeoddevenFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_exchange_odd_even_frame_sum(s : SortexchangeoddevenFrame) -> Double { @_common.sum(s.data) }

pub fn sort_exchange_odd_even_frame_mean(s : SortexchangeoddevenFrame) -> Double { @_common.mean(s.data) }

pub fn sort_exchange_odd_even_frame_scale(s : SortexchangeoddevenFrame, f : Double) -> SortexchangeoddevenFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_exchange_odd_even_frame_add(a : SortexchangeoddevenFrame, b : SortexchangeoddevenFrame) -> SortexchangeoddevenFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_exchange_odd_even_frame_copy(s : SortexchangeoddevenFrame) -> SortexchangeoddevenFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_exchange_odd_even_frame_fill(s : SortexchangeoddevenFrame, v : Double) -> SortexchangeoddevenFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_exchange_odd_even_frame_min(s : SortexchangeoddevenFrame) -> Double { @_common.min(s.data) }

pub fn sort_exchange_odd_even_frame_max(s : SortexchangeoddevenFrame) -> Double { @_common.max(s.data) }

pub fn sort_exchange_odd_even_frame_to_string(s : SortexchangeoddevenFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortexchangeoddevenTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_exchange_odd_even_table_make(size : Int) -> SortexchangeoddevenTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_exchange_odd_even_table_len(s : SortexchangeoddevenTable) -> Int { s.size }

pub fn sort_exchange_odd_even_table_get(s : SortexchangeoddevenTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_exchange_odd_even_table_set(s : SortexchangeoddevenTable, i : Int, v : Double) -> SortexchangeoddevenTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_exchange_odd_even_table_sum(s : SortexchangeoddevenTable) -> Double { @_common.sum(s.data) }

pub fn sort_exchange_odd_even_table_mean(s : SortexchangeoddevenTable) -> Double { @_common.mean(s.data) }

pub fn sort_exchange_odd_even_table_scale(s : SortexchangeoddevenTable, f : Double) -> SortexchangeoddevenTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_exchange_odd_even_table_add(a : SortexchangeoddevenTable, b : SortexchangeoddevenTable) -> SortexchangeoddevenTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_exchange_odd_even_table_copy(s : SortexchangeoddevenTable) -> SortexchangeoddevenTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_exchange_odd_even_table_fill(s : SortexchangeoddevenTable, v : Double) -> SortexchangeoddevenTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_exchange_odd_even_table_min(s : SortexchangeoddevenTable) -> Double { @_common.min(s.data) }

pub fn sort_exchange_odd_even_table_max(s : SortexchangeoddevenTable) -> Double { @_common.max(s.data) }

pub fn sort_exchange_odd_even_table_to_string(s : SortexchangeoddevenTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortexchangeoddevenGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_exchange_odd_even_graphn_make(size : Int) -> SortexchangeoddevenGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_exchange_odd_even_graphn_len(s : SortexchangeoddevenGraphN) -> Int { s.size }

pub fn sort_exchange_odd_even_graphn_get(s : SortexchangeoddevenGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_exchange_odd_even_graphn_set(s : SortexchangeoddevenGraphN, i : Int, v : Double) -> SortexchangeoddevenGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_exchange_odd_even_graphn_sum(s : SortexchangeoddevenGraphN) -> Double { @_common.sum(s.data) }

pub fn sort_exchange_odd_even_graphn_mean(s : SortexchangeoddevenGraphN) -> Double { @_common.mean(s.data) }

pub fn sort_exchange_odd_even_graphn_scale(s : SortexchangeoddevenGraphN, f : Double) -> SortexchangeoddevenGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_exchange_odd_even_graphn_add(a : SortexchangeoddevenGraphN, b : SortexchangeoddevenGraphN) -> SortexchangeoddevenGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_exchange_odd_even_graphn_copy(s : SortexchangeoddevenGraphN) -> SortexchangeoddevenGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_exchange_odd_even_graphn_fill(s : SortexchangeoddevenGraphN, v : Double) -> SortexchangeoddevenGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_exchange_odd_even_graphn_min(s : SortexchangeoddevenGraphN) -> Double { @_common.min(s.data) }

pub fn sort_exchange_odd_even_graphn_max(s : SortexchangeoddevenGraphN) -> Double { @_common.max(s.data) }

pub fn sort_exchange_odd_even_graphn_to_string(s : SortexchangeoddevenGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortexchangeoddevenNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_exchange_odd_even_node_make(size : Int) -> SortexchangeoddevenNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_exchange_odd_even_node_len(s : SortexchangeoddevenNode) -> Int { s.size }

pub fn sort_exchange_odd_even_node_get(s : SortexchangeoddevenNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_exchange_odd_even_node_set(s : SortexchangeoddevenNode, i : Int, v : Double) -> SortexchangeoddevenNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_exchange_odd_even_node_sum(s : SortexchangeoddevenNode) -> Double { @_common.sum(s.data) }

pub fn sort_exchange_odd_even_node_mean(s : SortexchangeoddevenNode) -> Double { @_common.mean(s.data) }

pub fn sort_exchange_odd_even_node_scale(s : SortexchangeoddevenNode, f : Double) -> SortexchangeoddevenNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_exchange_odd_even_node_add(a : SortexchangeoddevenNode, b : SortexchangeoddevenNode) -> SortexchangeoddevenNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_exchange_odd_even_node_copy(s : SortexchangeoddevenNode) -> SortexchangeoddevenNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_exchange_odd_even_node_fill(s : SortexchangeoddevenNode, v : Double) -> SortexchangeoddevenNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_exchange_odd_even_node_min(s : SortexchangeoddevenNode) -> Double { @_common.min(s.data) }

pub fn sort_exchange_odd_even_node_max(s : SortexchangeoddevenNode) -> Double { @_common.max(s.data) }

pub fn sort_exchange_odd_even_node_to_string(s : SortexchangeoddevenNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortexchangeoddevenEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_exchange_odd_even_edge_make(size : Int) -> SortexchangeoddevenEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_exchange_odd_even_edge_len(s : SortexchangeoddevenEdge) -> Int { s.size }

pub fn sort_exchange_odd_even_edge_get(s : SortexchangeoddevenEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_exchange_odd_even_edge_set(s : SortexchangeoddevenEdge, i : Int, v : Double) -> SortexchangeoddevenEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_exchange_odd_even_edge_sum(s : SortexchangeoddevenEdge) -> Double { @_common.sum(s.data) }

pub fn sort_exchange_odd_even_edge_mean(s : SortexchangeoddevenEdge) -> Double { @_common.mean(s.data) }

pub fn sort_exchange_odd_even_edge_scale(s : SortexchangeoddevenEdge, f : Double) -> SortexchangeoddevenEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_exchange_odd_even_edge_add(a : SortexchangeoddevenEdge, b : SortexchangeoddevenEdge) -> SortexchangeoddevenEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_exchange_odd_even_edge_copy(s : SortexchangeoddevenEdge) -> SortexchangeoddevenEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_exchange_odd_even_edge_fill(s : SortexchangeoddevenEdge, v : Double) -> SortexchangeoddevenEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_exchange_odd_even_edge_min(s : SortexchangeoddevenEdge) -> Double { @_common.min(s.data) }

pub fn sort_exchange_odd_even_edge_max(s : SortexchangeoddevenEdge) -> Double { @_common.max(s.data) }

pub fn sort_exchange_odd_even_edge_to_string(s : SortexchangeoddevenEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortexchangeoddevenPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_exchange_odd_even_path_make(size : Int) -> SortexchangeoddevenPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_exchange_odd_even_path_len(s : SortexchangeoddevenPath) -> Int { s.size }

pub fn sort_exchange_odd_even_path_get(s : SortexchangeoddevenPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_exchange_odd_even_path_set(s : SortexchangeoddevenPath, i : Int, v : Double) -> SortexchangeoddevenPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_exchange_odd_even_path_sum(s : SortexchangeoddevenPath) -> Double { @_common.sum(s.data) }

pub fn sort_exchange_odd_even_path_mean(s : SortexchangeoddevenPath) -> Double { @_common.mean(s.data) }

pub fn sort_exchange_odd_even_path_scale(s : SortexchangeoddevenPath, f : Double) -> SortexchangeoddevenPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_exchange_odd_even_path_add(a : SortexchangeoddevenPath, b : SortexchangeoddevenPath) -> SortexchangeoddevenPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_exchange_odd_even_path_copy(s : SortexchangeoddevenPath) -> SortexchangeoddevenPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_exchange_odd_even_path_fill(s : SortexchangeoddevenPath, v : Double) -> SortexchangeoddevenPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_exchange_odd_even_path_min(s : SortexchangeoddevenPath) -> Double { @_common.min(s.data) }

pub fn sort_exchange_odd_even_path_max(s : SortexchangeoddevenPath) -> Double { @_common.max(s.data) }

pub fn sort_exchange_odd_even_path_to_string(s : SortexchangeoddevenPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortexchangeoddevenCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_exchange_odd_even_cluster_make(size : Int) -> SortexchangeoddevenCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_exchange_odd_even_cluster_len(s : SortexchangeoddevenCluster) -> Int { s.size }

pub fn sort_exchange_odd_even_cluster_get(s : SortexchangeoddevenCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_exchange_odd_even_cluster_set(s : SortexchangeoddevenCluster, i : Int, v : Double) -> SortexchangeoddevenCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_exchange_odd_even_cluster_sum(s : SortexchangeoddevenCluster) -> Double { @_common.sum(s.data) }

pub fn sort_exchange_odd_even_cluster_mean(s : SortexchangeoddevenCluster) -> Double { @_common.mean(s.data) }

pub fn sort_exchange_odd_even_cluster_scale(s : SortexchangeoddevenCluster, f : Double) -> SortexchangeoddevenCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_exchange_odd_even_cluster_add(a : SortexchangeoddevenCluster, b : SortexchangeoddevenCluster) -> SortexchangeoddevenCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_exchange_odd_even_cluster_copy(s : SortexchangeoddevenCluster) -> SortexchangeoddevenCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_exchange_odd_even_cluster_fill(s : SortexchangeoddevenCluster, v : Double) -> SortexchangeoddevenCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_exchange_odd_even_cluster_min(s : SortexchangeoddevenCluster) -> Double { @_common.min(s.data) }

pub fn sort_exchange_odd_even_cluster_max(s : SortexchangeoddevenCluster) -> Double { @_common.max(s.data) }

pub fn sort_exchange_odd_even_cluster_to_string(s : SortexchangeoddevenCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortexchangeoddevenModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_exchange_odd_even_model_make(size : Int) -> SortexchangeoddevenModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_exchange_odd_even_model_len(s : SortexchangeoddevenModel) -> Int { s.size }

pub fn sort_exchange_odd_even_model_get(s : SortexchangeoddevenModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_exchange_odd_even_model_set(s : SortexchangeoddevenModel, i : Int, v : Double) -> SortexchangeoddevenModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_exchange_odd_even_model_sum(s : SortexchangeoddevenModel) -> Double { @_common.sum(s.data) }

pub fn sort_exchange_odd_even_model_mean(s : SortexchangeoddevenModel) -> Double { @_common.mean(s.data) }

pub fn sort_exchange_odd_even_model_scale(s : SortexchangeoddevenModel, f : Double) -> SortexchangeoddevenModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_exchange_odd_even_model_add(a : SortexchangeoddevenModel, b : SortexchangeoddevenModel) -> SortexchangeoddevenModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_exchange_odd_even_model_copy(s : SortexchangeoddevenModel) -> SortexchangeoddevenModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_exchange_odd_even_model_fill(s : SortexchangeoddevenModel, v : Double) -> SortexchangeoddevenModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_exchange_odd_even_model_min(s : SortexchangeoddevenModel) -> Double { @_common.min(s.data) }

pub fn sort_exchange_odd_even_model_max(s : SortexchangeoddevenModel) -> Double { @_common.max(s.data) }

pub fn sort_exchange_odd_even_model_to_string(s : SortexchangeoddevenModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortexchangeoddevenLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_exchange_odd_even_layer_make(size : Int) -> SortexchangeoddevenLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_exchange_odd_even_layer_len(s : SortexchangeoddevenLayer) -> Int { s.size }

pub fn sort_exchange_odd_even_layer_get(s : SortexchangeoddevenLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_exchange_odd_even_layer_set(s : SortexchangeoddevenLayer, i : Int, v : Double) -> SortexchangeoddevenLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_exchange_odd_even_layer_sum(s : SortexchangeoddevenLayer) -> Double { @_common.sum(s.data) }

pub fn sort_exchange_odd_even_layer_mean(s : SortexchangeoddevenLayer) -> Double { @_common.mean(s.data) }

pub fn sort_exchange_odd_even_layer_scale(s : SortexchangeoddevenLayer, f : Double) -> SortexchangeoddevenLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_exchange_odd_even_layer_add(a : SortexchangeoddevenLayer, b : SortexchangeoddevenLayer) -> SortexchangeoddevenLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_exchange_odd_even_layer_copy(s : SortexchangeoddevenLayer) -> SortexchangeoddevenLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_exchange_odd_even_layer_fill(s : SortexchangeoddevenLayer, v : Double) -> SortexchangeoddevenLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_exchange_odd_even_layer_min(s : SortexchangeoddevenLayer) -> Double { @_common.min(s.data) }

pub fn sort_exchange_odd_even_layer_max(s : SortexchangeoddevenLayer) -> Double { @_common.max(s.data) }

pub fn sort_exchange_odd_even_layer_to_string(s : SortexchangeoddevenLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortexchangeoddevenBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_exchange_odd_even_buffer_make(size : Int) -> SortexchangeoddevenBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_exchange_odd_even_buffer_len(s : SortexchangeoddevenBuffer) -> Int { s.size }

pub fn sort_exchange_odd_even_buffer_get(s : SortexchangeoddevenBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_exchange_odd_even_buffer_set(s : SortexchangeoddevenBuffer, i : Int, v : Double) -> SortexchangeoddevenBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_exchange_odd_even_buffer_sum(s : SortexchangeoddevenBuffer) -> Double { @_common.sum(s.data) }

pub fn sort_exchange_odd_even_buffer_mean(s : SortexchangeoddevenBuffer) -> Double { @_common.mean(s.data) }

pub fn sort_exchange_odd_even_buffer_scale(s : SortexchangeoddevenBuffer, f : Double) -> SortexchangeoddevenBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_exchange_odd_even_buffer_add(a : SortexchangeoddevenBuffer, b : SortexchangeoddevenBuffer) -> SortexchangeoddevenBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_exchange_odd_even_buffer_copy(s : SortexchangeoddevenBuffer) -> SortexchangeoddevenBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_exchange_odd_even_buffer_fill(s : SortexchangeoddevenBuffer, v : Double) -> SortexchangeoddevenBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_exchange_odd_even_buffer_min(s : SortexchangeoddevenBuffer) -> Double { @_common.min(s.data) }

pub fn sort_exchange_odd_even_buffer_max(s : SortexchangeoddevenBuffer) -> Double { @_common.max(s.data) }

pub fn sort_exchange_odd_even_buffer_to_string(s : SortexchangeoddevenBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortexchangeoddevenCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_exchange_odd_even_cursor_make(size : Int) -> SortexchangeoddevenCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_exchange_odd_even_cursor_len(s : SortexchangeoddevenCursor) -> Int { s.size }

pub fn sort_exchange_odd_even_cursor_get(s : SortexchangeoddevenCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_exchange_odd_even_cursor_set(s : SortexchangeoddevenCursor, i : Int, v : Double) -> SortexchangeoddevenCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_exchange_odd_even_cursor_sum(s : SortexchangeoddevenCursor) -> Double { @_common.sum(s.data) }

pub fn sort_exchange_odd_even_cursor_mean(s : SortexchangeoddevenCursor) -> Double { @_common.mean(s.data) }

pub fn sort_exchange_odd_even_cursor_scale(s : SortexchangeoddevenCursor, f : Double) -> SortexchangeoddevenCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_exchange_odd_even_cursor_add(a : SortexchangeoddevenCursor, b : SortexchangeoddevenCursor) -> SortexchangeoddevenCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_exchange_odd_even_cursor_copy(s : SortexchangeoddevenCursor) -> SortexchangeoddevenCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_exchange_odd_even_cursor_fill(s : SortexchangeoddevenCursor, v : Double) -> SortexchangeoddevenCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_exchange_odd_even_cursor_min(s : SortexchangeoddevenCursor) -> Double { @_common.min(s.data) }

pub fn sort_exchange_odd_even_cursor_max(s : SortexchangeoddevenCursor) -> Double { @_common.max(s.data) }

pub fn sort_exchange_odd_even_cursor_to_string(s : SortexchangeoddevenCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortexchangeoddevenView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_exchange_odd_even_view_make(size : Int) -> SortexchangeoddevenView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_exchange_odd_even_view_len(s : SortexchangeoddevenView) -> Int { s.size }

pub fn sort_exchange_odd_even_view_get(s : SortexchangeoddevenView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_exchange_odd_even_view_set(s : SortexchangeoddevenView, i : Int, v : Double) -> SortexchangeoddevenView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_exchange_odd_even_view_sum(s : SortexchangeoddevenView) -> Double { @_common.sum(s.data) }

pub fn sort_exchange_odd_even_view_mean(s : SortexchangeoddevenView) -> Double { @_common.mean(s.data) }

pub fn sort_exchange_odd_even_view_scale(s : SortexchangeoddevenView, f : Double) -> SortexchangeoddevenView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_exchange_odd_even_view_add(a : SortexchangeoddevenView, b : SortexchangeoddevenView) -> SortexchangeoddevenView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_exchange_odd_even_view_copy(s : SortexchangeoddevenView) -> SortexchangeoddevenView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_exchange_odd_even_view_fill(s : SortexchangeoddevenView, v : Double) -> SortexchangeoddevenView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_exchange_odd_even_view_min(s : SortexchangeoddevenView) -> Double { @_common.min(s.data) }

pub fn sort_exchange_odd_even_view_max(s : SortexchangeoddevenView) -> Double { @_common.max(s.data) }

pub fn sort_exchange_odd_even_view_to_string(s : SortexchangeoddevenView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortexchangeoddevenRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_exchange_odd_even_range_make(size : Int) -> SortexchangeoddevenRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_exchange_odd_even_range_len(s : SortexchangeoddevenRange) -> Int { s.size }

pub fn sort_exchange_odd_even_range_get(s : SortexchangeoddevenRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_exchange_odd_even_range_set(s : SortexchangeoddevenRange, i : Int, v : Double) -> SortexchangeoddevenRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_exchange_odd_even_range_sum(s : SortexchangeoddevenRange) -> Double { @_common.sum(s.data) }

pub fn sort_exchange_odd_even_range_mean(s : SortexchangeoddevenRange) -> Double { @_common.mean(s.data) }

pub fn sort_exchange_odd_even_range_scale(s : SortexchangeoddevenRange, f : Double) -> SortexchangeoddevenRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_exchange_odd_even_range_add(a : SortexchangeoddevenRange, b : SortexchangeoddevenRange) -> SortexchangeoddevenRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_exchange_odd_even_range_copy(s : SortexchangeoddevenRange) -> SortexchangeoddevenRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_exchange_odd_even_range_fill(s : SortexchangeoddevenRange, v : Double) -> SortexchangeoddevenRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_exchange_odd_even_range_min(s : SortexchangeoddevenRange) -> Double { @_common.min(s.data) }

pub fn sort_exchange_odd_even_range_max(s : SortexchangeoddevenRange) -> Double { @_common.max(s.data) }

pub fn sort_exchange_odd_even_range_to_string(s : SortexchangeoddevenRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortexchangeoddevenSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_exchange_odd_even_slice_make(size : Int) -> SortexchangeoddevenSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_exchange_odd_even_slice_len(s : SortexchangeoddevenSlice) -> Int { s.size }

pub fn sort_exchange_odd_even_slice_get(s : SortexchangeoddevenSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_exchange_odd_even_slice_set(s : SortexchangeoddevenSlice, i : Int, v : Double) -> SortexchangeoddevenSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_exchange_odd_even_slice_sum(s : SortexchangeoddevenSlice) -> Double { @_common.sum(s.data) }

pub fn sort_exchange_odd_even_slice_mean(s : SortexchangeoddevenSlice) -> Double { @_common.mean(s.data) }

pub fn sort_exchange_odd_even_slice_scale(s : SortexchangeoddevenSlice, f : Double) -> SortexchangeoddevenSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_exchange_odd_even_slice_add(a : SortexchangeoddevenSlice, b : SortexchangeoddevenSlice) -> SortexchangeoddevenSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_exchange_odd_even_slice_copy(s : SortexchangeoddevenSlice) -> SortexchangeoddevenSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_exchange_odd_even_slice_fill(s : SortexchangeoddevenSlice, v : Double) -> SortexchangeoddevenSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_exchange_odd_even_slice_min(s : SortexchangeoddevenSlice) -> Double { @_common.min(s.data) }

pub fn sort_exchange_odd_even_slice_max(s : SortexchangeoddevenSlice) -> Double { @_common.max(s.data) }

pub fn sort_exchange_odd_even_slice_to_string(s : SortexchangeoddevenSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

