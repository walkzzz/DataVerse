///===
/// extcore/sort_exchange_comb

pub(all) struct SortexchangecombPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn sort_exchange_comb_make_point(x : Double, y : Double) -> SortexchangecombPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn sort_exchange_comb_make_point3(x : Double, y : Double, z : Double) -> SortexchangecombPoint {
  { x, y, z, label: 0 }
}

pub fn SortexchangecombPoint::x(self : SortexchangecombPoint) -> Double { self.x }

pub fn SortexchangecombPoint::y(self : SortexchangecombPoint) -> Double { self.y }

pub fn SortexchangecombPoint::z(self : SortexchangecombPoint) -> Double { self.z }

pub fn SortexchangecombPoint::label(self : SortexchangecombPoint) -> Int { self.label }

pub fn SortexchangecombPoint::dist(self : SortexchangecombPoint, other : SortexchangecombPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn SortexchangecombPoint::add(self : SortexchangecombPoint, other : SortexchangecombPoint) -> SortexchangecombPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn SortexchangecombPoint::sub(self : SortexchangecombPoint, other : SortexchangecombPoint) -> SortexchangecombPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn SortexchangecombPoint::scale(self : SortexchangecombPoint, s : Double) -> SortexchangecombPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn SortexchangecombPoint::dot(self : SortexchangecombPoint, other : SortexchangecombPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn SortexchangecombPoint::cross(self : SortexchangecombPoint, other : SortexchangecombPoint) -> SortexchangecombPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn SortexchangecombPoint::norm(self : SortexchangecombPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn SortexchangecombPoint::normalize(self : SortexchangecombPoint) -> SortexchangecombPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn SortexchangecombPoint::negate(self : SortexchangecombPoint) -> SortexchangecombPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn SortexchangecombPoint::mid(self : SortexchangecombPoint, other : SortexchangecombPoint) -> SortexchangecombPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn SortexchangecombPoint::lerp(self : SortexchangecombPoint, other : SortexchangecombPoint, t : Double) -> SortexchangecombPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn SortexchangecombPoint::to_string(self : SortexchangecombPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct SortexchangecombSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn sort_exchange_comb_make_series(vals : Array[Double], name : String) -> SortexchangecombSeries {
  { vals, name, meta: 0 }
}

pub fn SortexchangecombSeries::len(self : SortexchangecombSeries) -> Int { self.vals.length() }

pub fn SortexchangecombSeries::sum(self : SortexchangecombSeries) -> Double { @_common.sum(self.vals) }

pub fn SortexchangecombSeries::mean(self : SortexchangecombSeries) -> Double { @_common.mean(self.vals) }

pub fn SortexchangecombSeries::min(self : SortexchangecombSeries) -> Double { @_common.min(self.vals) }

pub fn SortexchangecombSeries::max(self : SortexchangecombSeries) -> Double { @_common.max(self.vals) }

pub fn SortexchangecombSeries::range(self : SortexchangecombSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn SortexchangecombSeries::variance(self : SortexchangecombSeries) -> Double { @_common.variance(self.vals) }

pub fn SortexchangecombSeries::std(self : SortexchangecombSeries) -> Double { @_common.std(self.vals) }

pub fn SortexchangecombSeries::median(self : SortexchangecombSeries) -> Double { @_common.median(self.vals) }

pub fn SortexchangecombSeries::scale(self : SortexchangecombSeries, f : Double) -> SortexchangecombSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn SortexchangecombSeries::add(self : SortexchangecombSeries, other : SortexchangecombSeries) -> SortexchangecombSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn SortexchangecombSeries::sub(self : SortexchangecombSeries, other : SortexchangecombSeries) -> SortexchangecombSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn SortexchangecombSeries::normalize(self : SortexchangecombSeries) -> SortexchangecombSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn SortexchangecombSeries::cumsum(self : SortexchangecombSeries) -> SortexchangecombSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn SortexchangecombSeries::to_string(self : SortexchangecombSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct SortexchangecombMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn sort_exchange_comb_make_matrix(rows : Int, cols : Int, val : Double) -> SortexchangecombMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn sort_exchange_comb_matrix_identity(n : Int) -> SortexchangecombMatrix {
  let m = sort_exchange_comb_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn SortexchangecombMatrix::get(self : SortexchangecombMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn SortexchangecombMatrix::transpose(self : SortexchangecombMatrix) -> SortexchangecombMatrix {
  let result = sort_exchange_comb_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn SortexchangecombMatrix::add(self : SortexchangecombMatrix, other : SortexchangecombMatrix) -> SortexchangecombMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = sort_exchange_comb_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn SortexchangecombMatrix::scale(self : SortexchangecombMatrix, s : Double) -> SortexchangecombMatrix {
  let result = sort_exchange_comb_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn SortexchangecombMatrix::multiply(self : SortexchangecombMatrix, other : SortexchangecombMatrix) -> SortexchangecombMatrix {
  if self.cols != other.rows { return sort_exchange_comb_make_matrix(self.rows, other.cols, 0.0) }
  let result = sort_exchange_comb_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn SortexchangecombMatrix::trace(self : SortexchangecombMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn SortexchangecombMatrix::det(self : SortexchangecombMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn SortexchangecombMatrix::norm(self : SortexchangecombMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn SortexchangecombMatrix::to_string(self : SortexchangecombMatrix) -> String {
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

pub(all) struct SortexchangecombVector {
  comps : Array[Double]
  dim : Int
}

pub fn sort_exchange_comb_make_vector(comps : Array[Double]) -> SortexchangecombVector {
  { comps, dim: comps.length() }
}

pub fn sort_exchange_comb_vector_zero(dim : Int) -> SortexchangecombVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn SortexchangecombVector::add(self : SortexchangecombVector, other : SortexchangecombVector) -> SortexchangecombVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn SortexchangecombVector::sub(self : SortexchangecombVector, other : SortexchangecombVector) -> SortexchangecombVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn SortexchangecombVector::scale(self : SortexchangecombVector, s : Double) -> SortexchangecombVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn SortexchangecombVector::dot(self : SortexchangecombVector, other : SortexchangecombVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn SortexchangecombVector::norm(self : SortexchangecombVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn SortexchangecombVector::normalize(self : SortexchangecombVector) -> SortexchangecombVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn SortexchangecombVector::dist(self : SortexchangecombVector, other : SortexchangecombVector) -> Double {
  self.sub(other).norm()
}

pub fn SortexchangecombVector::to_string(self : SortexchangecombVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn sort_exchange_comb_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn sort_exchange_comb_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn sort_exchange_comb_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn sort_exchange_comb_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn sort_exchange_comb_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn sort_exchange_comb_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn sort_exchange_comb_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn sort_exchange_comb_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn sort_exchange_comb_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn sort_exchange_comb_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn sort_exchange_comb_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn sort_exchange_comb_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn sort_exchange_comb_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn sort_exchange_comb_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn sort_exchange_comb_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn sort_exchange_comb_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn sort_exchange_comb_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn sort_exchange_comb_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn sort_exchange_comb_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn sort_exchange_comb_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn sort_exchange_comb_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn sort_exchange_comb_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn sort_exchange_comb_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn sort_exchange_comb_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn sort_exchange_comb_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn sort_exchange_comb_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn sort_exchange_comb_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn sort_exchange_comb_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn sort_exchange_comb_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct SortexchangecombFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_exchange_comb_frame_make(size : Int) -> SortexchangecombFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_exchange_comb_frame_len(s : SortexchangecombFrame) -> Int { s.size }

pub fn sort_exchange_comb_frame_get(s : SortexchangecombFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_exchange_comb_frame_set(s : SortexchangecombFrame, i : Int, v : Double) -> SortexchangecombFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_exchange_comb_frame_sum(s : SortexchangecombFrame) -> Double { @_common.sum(s.data) }

pub fn sort_exchange_comb_frame_mean(s : SortexchangecombFrame) -> Double { @_common.mean(s.data) }

pub fn sort_exchange_comb_frame_scale(s : SortexchangecombFrame, f : Double) -> SortexchangecombFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_exchange_comb_frame_add(a : SortexchangecombFrame, b : SortexchangecombFrame) -> SortexchangecombFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_exchange_comb_frame_copy(s : SortexchangecombFrame) -> SortexchangecombFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_exchange_comb_frame_fill(s : SortexchangecombFrame, v : Double) -> SortexchangecombFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_exchange_comb_frame_min(s : SortexchangecombFrame) -> Double { @_common.min(s.data) }

pub fn sort_exchange_comb_frame_max(s : SortexchangecombFrame) -> Double { @_common.max(s.data) }

pub fn sort_exchange_comb_frame_to_string(s : SortexchangecombFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortexchangecombTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_exchange_comb_table_make(size : Int) -> SortexchangecombTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_exchange_comb_table_len(s : SortexchangecombTable) -> Int { s.size }

pub fn sort_exchange_comb_table_get(s : SortexchangecombTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_exchange_comb_table_set(s : SortexchangecombTable, i : Int, v : Double) -> SortexchangecombTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_exchange_comb_table_sum(s : SortexchangecombTable) -> Double { @_common.sum(s.data) }

pub fn sort_exchange_comb_table_mean(s : SortexchangecombTable) -> Double { @_common.mean(s.data) }

pub fn sort_exchange_comb_table_scale(s : SortexchangecombTable, f : Double) -> SortexchangecombTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_exchange_comb_table_add(a : SortexchangecombTable, b : SortexchangecombTable) -> SortexchangecombTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_exchange_comb_table_copy(s : SortexchangecombTable) -> SortexchangecombTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_exchange_comb_table_fill(s : SortexchangecombTable, v : Double) -> SortexchangecombTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_exchange_comb_table_min(s : SortexchangecombTable) -> Double { @_common.min(s.data) }

pub fn sort_exchange_comb_table_max(s : SortexchangecombTable) -> Double { @_common.max(s.data) }

pub fn sort_exchange_comb_table_to_string(s : SortexchangecombTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortexchangecombGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_exchange_comb_graphn_make(size : Int) -> SortexchangecombGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_exchange_comb_graphn_len(s : SortexchangecombGraphN) -> Int { s.size }

pub fn sort_exchange_comb_graphn_get(s : SortexchangecombGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_exchange_comb_graphn_set(s : SortexchangecombGraphN, i : Int, v : Double) -> SortexchangecombGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_exchange_comb_graphn_sum(s : SortexchangecombGraphN) -> Double { @_common.sum(s.data) }

pub fn sort_exchange_comb_graphn_mean(s : SortexchangecombGraphN) -> Double { @_common.mean(s.data) }

pub fn sort_exchange_comb_graphn_scale(s : SortexchangecombGraphN, f : Double) -> SortexchangecombGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_exchange_comb_graphn_add(a : SortexchangecombGraphN, b : SortexchangecombGraphN) -> SortexchangecombGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_exchange_comb_graphn_copy(s : SortexchangecombGraphN) -> SortexchangecombGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_exchange_comb_graphn_fill(s : SortexchangecombGraphN, v : Double) -> SortexchangecombGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_exchange_comb_graphn_min(s : SortexchangecombGraphN) -> Double { @_common.min(s.data) }

pub fn sort_exchange_comb_graphn_max(s : SortexchangecombGraphN) -> Double { @_common.max(s.data) }

pub fn sort_exchange_comb_graphn_to_string(s : SortexchangecombGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortexchangecombNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_exchange_comb_node_make(size : Int) -> SortexchangecombNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_exchange_comb_node_len(s : SortexchangecombNode) -> Int { s.size }

pub fn sort_exchange_comb_node_get(s : SortexchangecombNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_exchange_comb_node_set(s : SortexchangecombNode, i : Int, v : Double) -> SortexchangecombNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_exchange_comb_node_sum(s : SortexchangecombNode) -> Double { @_common.sum(s.data) }

pub fn sort_exchange_comb_node_mean(s : SortexchangecombNode) -> Double { @_common.mean(s.data) }

pub fn sort_exchange_comb_node_scale(s : SortexchangecombNode, f : Double) -> SortexchangecombNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_exchange_comb_node_add(a : SortexchangecombNode, b : SortexchangecombNode) -> SortexchangecombNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_exchange_comb_node_copy(s : SortexchangecombNode) -> SortexchangecombNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_exchange_comb_node_fill(s : SortexchangecombNode, v : Double) -> SortexchangecombNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_exchange_comb_node_min(s : SortexchangecombNode) -> Double { @_common.min(s.data) }

pub fn sort_exchange_comb_node_max(s : SortexchangecombNode) -> Double { @_common.max(s.data) }

pub fn sort_exchange_comb_node_to_string(s : SortexchangecombNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortexchangecombEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_exchange_comb_edge_make(size : Int) -> SortexchangecombEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_exchange_comb_edge_len(s : SortexchangecombEdge) -> Int { s.size }

pub fn sort_exchange_comb_edge_get(s : SortexchangecombEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_exchange_comb_edge_set(s : SortexchangecombEdge, i : Int, v : Double) -> SortexchangecombEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_exchange_comb_edge_sum(s : SortexchangecombEdge) -> Double { @_common.sum(s.data) }

pub fn sort_exchange_comb_edge_mean(s : SortexchangecombEdge) -> Double { @_common.mean(s.data) }

pub fn sort_exchange_comb_edge_scale(s : SortexchangecombEdge, f : Double) -> SortexchangecombEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_exchange_comb_edge_add(a : SortexchangecombEdge, b : SortexchangecombEdge) -> SortexchangecombEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_exchange_comb_edge_copy(s : SortexchangecombEdge) -> SortexchangecombEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_exchange_comb_edge_fill(s : SortexchangecombEdge, v : Double) -> SortexchangecombEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_exchange_comb_edge_min(s : SortexchangecombEdge) -> Double { @_common.min(s.data) }

pub fn sort_exchange_comb_edge_max(s : SortexchangecombEdge) -> Double { @_common.max(s.data) }

pub fn sort_exchange_comb_edge_to_string(s : SortexchangecombEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortexchangecombPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_exchange_comb_path_make(size : Int) -> SortexchangecombPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_exchange_comb_path_len(s : SortexchangecombPath) -> Int { s.size }

pub fn sort_exchange_comb_path_get(s : SortexchangecombPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_exchange_comb_path_set(s : SortexchangecombPath, i : Int, v : Double) -> SortexchangecombPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_exchange_comb_path_sum(s : SortexchangecombPath) -> Double { @_common.sum(s.data) }

pub fn sort_exchange_comb_path_mean(s : SortexchangecombPath) -> Double { @_common.mean(s.data) }

pub fn sort_exchange_comb_path_scale(s : SortexchangecombPath, f : Double) -> SortexchangecombPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_exchange_comb_path_add(a : SortexchangecombPath, b : SortexchangecombPath) -> SortexchangecombPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_exchange_comb_path_copy(s : SortexchangecombPath) -> SortexchangecombPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_exchange_comb_path_fill(s : SortexchangecombPath, v : Double) -> SortexchangecombPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_exchange_comb_path_min(s : SortexchangecombPath) -> Double { @_common.min(s.data) }

pub fn sort_exchange_comb_path_max(s : SortexchangecombPath) -> Double { @_common.max(s.data) }

pub fn sort_exchange_comb_path_to_string(s : SortexchangecombPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortexchangecombCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_exchange_comb_cluster_make(size : Int) -> SortexchangecombCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_exchange_comb_cluster_len(s : SortexchangecombCluster) -> Int { s.size }

pub fn sort_exchange_comb_cluster_get(s : SortexchangecombCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_exchange_comb_cluster_set(s : SortexchangecombCluster, i : Int, v : Double) -> SortexchangecombCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_exchange_comb_cluster_sum(s : SortexchangecombCluster) -> Double { @_common.sum(s.data) }

pub fn sort_exchange_comb_cluster_mean(s : SortexchangecombCluster) -> Double { @_common.mean(s.data) }

pub fn sort_exchange_comb_cluster_scale(s : SortexchangecombCluster, f : Double) -> SortexchangecombCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_exchange_comb_cluster_add(a : SortexchangecombCluster, b : SortexchangecombCluster) -> SortexchangecombCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_exchange_comb_cluster_copy(s : SortexchangecombCluster) -> SortexchangecombCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_exchange_comb_cluster_fill(s : SortexchangecombCluster, v : Double) -> SortexchangecombCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_exchange_comb_cluster_min(s : SortexchangecombCluster) -> Double { @_common.min(s.data) }

pub fn sort_exchange_comb_cluster_max(s : SortexchangecombCluster) -> Double { @_common.max(s.data) }

pub fn sort_exchange_comb_cluster_to_string(s : SortexchangecombCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortexchangecombModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_exchange_comb_model_make(size : Int) -> SortexchangecombModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_exchange_comb_model_len(s : SortexchangecombModel) -> Int { s.size }

pub fn sort_exchange_comb_model_get(s : SortexchangecombModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_exchange_comb_model_set(s : SortexchangecombModel, i : Int, v : Double) -> SortexchangecombModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_exchange_comb_model_sum(s : SortexchangecombModel) -> Double { @_common.sum(s.data) }

pub fn sort_exchange_comb_model_mean(s : SortexchangecombModel) -> Double { @_common.mean(s.data) }

pub fn sort_exchange_comb_model_scale(s : SortexchangecombModel, f : Double) -> SortexchangecombModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_exchange_comb_model_add(a : SortexchangecombModel, b : SortexchangecombModel) -> SortexchangecombModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_exchange_comb_model_copy(s : SortexchangecombModel) -> SortexchangecombModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_exchange_comb_model_fill(s : SortexchangecombModel, v : Double) -> SortexchangecombModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_exchange_comb_model_min(s : SortexchangecombModel) -> Double { @_common.min(s.data) }

pub fn sort_exchange_comb_model_max(s : SortexchangecombModel) -> Double { @_common.max(s.data) }

pub fn sort_exchange_comb_model_to_string(s : SortexchangecombModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortexchangecombLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_exchange_comb_layer_make(size : Int) -> SortexchangecombLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_exchange_comb_layer_len(s : SortexchangecombLayer) -> Int { s.size }

pub fn sort_exchange_comb_layer_get(s : SortexchangecombLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_exchange_comb_layer_set(s : SortexchangecombLayer, i : Int, v : Double) -> SortexchangecombLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_exchange_comb_layer_sum(s : SortexchangecombLayer) -> Double { @_common.sum(s.data) }

pub fn sort_exchange_comb_layer_mean(s : SortexchangecombLayer) -> Double { @_common.mean(s.data) }

pub fn sort_exchange_comb_layer_scale(s : SortexchangecombLayer, f : Double) -> SortexchangecombLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_exchange_comb_layer_add(a : SortexchangecombLayer, b : SortexchangecombLayer) -> SortexchangecombLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_exchange_comb_layer_copy(s : SortexchangecombLayer) -> SortexchangecombLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_exchange_comb_layer_fill(s : SortexchangecombLayer, v : Double) -> SortexchangecombLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_exchange_comb_layer_min(s : SortexchangecombLayer) -> Double { @_common.min(s.data) }

pub fn sort_exchange_comb_layer_max(s : SortexchangecombLayer) -> Double { @_common.max(s.data) }

pub fn sort_exchange_comb_layer_to_string(s : SortexchangecombLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortexchangecombBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_exchange_comb_buffer_make(size : Int) -> SortexchangecombBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_exchange_comb_buffer_len(s : SortexchangecombBuffer) -> Int { s.size }

pub fn sort_exchange_comb_buffer_get(s : SortexchangecombBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_exchange_comb_buffer_set(s : SortexchangecombBuffer, i : Int, v : Double) -> SortexchangecombBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_exchange_comb_buffer_sum(s : SortexchangecombBuffer) -> Double { @_common.sum(s.data) }

pub fn sort_exchange_comb_buffer_mean(s : SortexchangecombBuffer) -> Double { @_common.mean(s.data) }

pub fn sort_exchange_comb_buffer_scale(s : SortexchangecombBuffer, f : Double) -> SortexchangecombBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_exchange_comb_buffer_add(a : SortexchangecombBuffer, b : SortexchangecombBuffer) -> SortexchangecombBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_exchange_comb_buffer_copy(s : SortexchangecombBuffer) -> SortexchangecombBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_exchange_comb_buffer_fill(s : SortexchangecombBuffer, v : Double) -> SortexchangecombBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_exchange_comb_buffer_min(s : SortexchangecombBuffer) -> Double { @_common.min(s.data) }

pub fn sort_exchange_comb_buffer_max(s : SortexchangecombBuffer) -> Double { @_common.max(s.data) }

pub fn sort_exchange_comb_buffer_to_string(s : SortexchangecombBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortexchangecombCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_exchange_comb_cursor_make(size : Int) -> SortexchangecombCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_exchange_comb_cursor_len(s : SortexchangecombCursor) -> Int { s.size }

pub fn sort_exchange_comb_cursor_get(s : SortexchangecombCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_exchange_comb_cursor_set(s : SortexchangecombCursor, i : Int, v : Double) -> SortexchangecombCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_exchange_comb_cursor_sum(s : SortexchangecombCursor) -> Double { @_common.sum(s.data) }

pub fn sort_exchange_comb_cursor_mean(s : SortexchangecombCursor) -> Double { @_common.mean(s.data) }

pub fn sort_exchange_comb_cursor_scale(s : SortexchangecombCursor, f : Double) -> SortexchangecombCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_exchange_comb_cursor_add(a : SortexchangecombCursor, b : SortexchangecombCursor) -> SortexchangecombCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_exchange_comb_cursor_copy(s : SortexchangecombCursor) -> SortexchangecombCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_exchange_comb_cursor_fill(s : SortexchangecombCursor, v : Double) -> SortexchangecombCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_exchange_comb_cursor_min(s : SortexchangecombCursor) -> Double { @_common.min(s.data) }

pub fn sort_exchange_comb_cursor_max(s : SortexchangecombCursor) -> Double { @_common.max(s.data) }

pub fn sort_exchange_comb_cursor_to_string(s : SortexchangecombCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortexchangecombView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_exchange_comb_view_make(size : Int) -> SortexchangecombView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_exchange_comb_view_len(s : SortexchangecombView) -> Int { s.size }

pub fn sort_exchange_comb_view_get(s : SortexchangecombView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_exchange_comb_view_set(s : SortexchangecombView, i : Int, v : Double) -> SortexchangecombView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_exchange_comb_view_sum(s : SortexchangecombView) -> Double { @_common.sum(s.data) }

pub fn sort_exchange_comb_view_mean(s : SortexchangecombView) -> Double { @_common.mean(s.data) }

pub fn sort_exchange_comb_view_scale(s : SortexchangecombView, f : Double) -> SortexchangecombView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_exchange_comb_view_add(a : SortexchangecombView, b : SortexchangecombView) -> SortexchangecombView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_exchange_comb_view_copy(s : SortexchangecombView) -> SortexchangecombView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_exchange_comb_view_fill(s : SortexchangecombView, v : Double) -> SortexchangecombView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_exchange_comb_view_min(s : SortexchangecombView) -> Double { @_common.min(s.data) }

pub fn sort_exchange_comb_view_max(s : SortexchangecombView) -> Double { @_common.max(s.data) }

pub fn sort_exchange_comb_view_to_string(s : SortexchangecombView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortexchangecombRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_exchange_comb_range_make(size : Int) -> SortexchangecombRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_exchange_comb_range_len(s : SortexchangecombRange) -> Int { s.size }

pub fn sort_exchange_comb_range_get(s : SortexchangecombRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_exchange_comb_range_set(s : SortexchangecombRange, i : Int, v : Double) -> SortexchangecombRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_exchange_comb_range_sum(s : SortexchangecombRange) -> Double { @_common.sum(s.data) }

pub fn sort_exchange_comb_range_mean(s : SortexchangecombRange) -> Double { @_common.mean(s.data) }

pub fn sort_exchange_comb_range_scale(s : SortexchangecombRange, f : Double) -> SortexchangecombRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_exchange_comb_range_add(a : SortexchangecombRange, b : SortexchangecombRange) -> SortexchangecombRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_exchange_comb_range_copy(s : SortexchangecombRange) -> SortexchangecombRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_exchange_comb_range_fill(s : SortexchangecombRange, v : Double) -> SortexchangecombRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_exchange_comb_range_min(s : SortexchangecombRange) -> Double { @_common.min(s.data) }

pub fn sort_exchange_comb_range_max(s : SortexchangecombRange) -> Double { @_common.max(s.data) }

pub fn sort_exchange_comb_range_to_string(s : SortexchangecombRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortexchangecombSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_exchange_comb_slice_make(size : Int) -> SortexchangecombSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_exchange_comb_slice_len(s : SortexchangecombSlice) -> Int { s.size }

pub fn sort_exchange_comb_slice_get(s : SortexchangecombSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_exchange_comb_slice_set(s : SortexchangecombSlice, i : Int, v : Double) -> SortexchangecombSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_exchange_comb_slice_sum(s : SortexchangecombSlice) -> Double { @_common.sum(s.data) }

pub fn sort_exchange_comb_slice_mean(s : SortexchangecombSlice) -> Double { @_common.mean(s.data) }

pub fn sort_exchange_comb_slice_scale(s : SortexchangecombSlice, f : Double) -> SortexchangecombSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_exchange_comb_slice_add(a : SortexchangecombSlice, b : SortexchangecombSlice) -> SortexchangecombSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_exchange_comb_slice_copy(s : SortexchangecombSlice) -> SortexchangecombSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_exchange_comb_slice_fill(s : SortexchangecombSlice, v : Double) -> SortexchangecombSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_exchange_comb_slice_min(s : SortexchangecombSlice) -> Double { @_common.min(s.data) }

pub fn sort_exchange_comb_slice_max(s : SortexchangecombSlice) -> Double { @_common.max(s.data) }

pub fn sort_exchange_comb_slice_to_string(s : SortexchangecombSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

