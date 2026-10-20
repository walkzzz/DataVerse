///===
/// extcore/sort_exchange_pancake

pub(all) struct SortexchangepancakePoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn sort_exchange_pancake_make_point(x : Double, y : Double) -> SortexchangepancakePoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn sort_exchange_pancake_make_point3(x : Double, y : Double, z : Double) -> SortexchangepancakePoint {
  { x, y, z, label: 0 }
}

pub fn SortexchangepancakePoint::x(self : SortexchangepancakePoint) -> Double { self.x }

pub fn SortexchangepancakePoint::y(self : SortexchangepancakePoint) -> Double { self.y }

pub fn SortexchangepancakePoint::z(self : SortexchangepancakePoint) -> Double { self.z }

pub fn SortexchangepancakePoint::label(self : SortexchangepancakePoint) -> Int { self.label }

pub fn SortexchangepancakePoint::dist(self : SortexchangepancakePoint, other : SortexchangepancakePoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn SortexchangepancakePoint::add(self : SortexchangepancakePoint, other : SortexchangepancakePoint) -> SortexchangepancakePoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn SortexchangepancakePoint::sub(self : SortexchangepancakePoint, other : SortexchangepancakePoint) -> SortexchangepancakePoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn SortexchangepancakePoint::scale(self : SortexchangepancakePoint, s : Double) -> SortexchangepancakePoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn SortexchangepancakePoint::dot(self : SortexchangepancakePoint, other : SortexchangepancakePoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn SortexchangepancakePoint::cross(self : SortexchangepancakePoint, other : SortexchangepancakePoint) -> SortexchangepancakePoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn SortexchangepancakePoint::norm(self : SortexchangepancakePoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn SortexchangepancakePoint::normalize(self : SortexchangepancakePoint) -> SortexchangepancakePoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn SortexchangepancakePoint::negate(self : SortexchangepancakePoint) -> SortexchangepancakePoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn SortexchangepancakePoint::mid(self : SortexchangepancakePoint, other : SortexchangepancakePoint) -> SortexchangepancakePoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn SortexchangepancakePoint::lerp(self : SortexchangepancakePoint, other : SortexchangepancakePoint, t : Double) -> SortexchangepancakePoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn SortexchangepancakePoint::to_string(self : SortexchangepancakePoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct SortexchangepancakeSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn sort_exchange_pancake_make_series(vals : Array[Double], name : String) -> SortexchangepancakeSeries {
  { vals, name, meta: 0 }
}

pub fn SortexchangepancakeSeries::len(self : SortexchangepancakeSeries) -> Int { self.vals.length() }

pub fn SortexchangepancakeSeries::sum(self : SortexchangepancakeSeries) -> Double { @_common.sum(self.vals) }

pub fn SortexchangepancakeSeries::mean(self : SortexchangepancakeSeries) -> Double { @_common.mean(self.vals) }

pub fn SortexchangepancakeSeries::min(self : SortexchangepancakeSeries) -> Double { @_common.min(self.vals) }

pub fn SortexchangepancakeSeries::max(self : SortexchangepancakeSeries) -> Double { @_common.max(self.vals) }

pub fn SortexchangepancakeSeries::range(self : SortexchangepancakeSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn SortexchangepancakeSeries::variance(self : SortexchangepancakeSeries) -> Double { @_common.variance(self.vals) }

pub fn SortexchangepancakeSeries::std(self : SortexchangepancakeSeries) -> Double { @_common.std(self.vals) }

pub fn SortexchangepancakeSeries::median(self : SortexchangepancakeSeries) -> Double { @_common.median(self.vals) }

pub fn SortexchangepancakeSeries::scale(self : SortexchangepancakeSeries, f : Double) -> SortexchangepancakeSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn SortexchangepancakeSeries::add(self : SortexchangepancakeSeries, other : SortexchangepancakeSeries) -> SortexchangepancakeSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn SortexchangepancakeSeries::sub(self : SortexchangepancakeSeries, other : SortexchangepancakeSeries) -> SortexchangepancakeSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn SortexchangepancakeSeries::normalize(self : SortexchangepancakeSeries) -> SortexchangepancakeSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn SortexchangepancakeSeries::cumsum(self : SortexchangepancakeSeries) -> SortexchangepancakeSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn SortexchangepancakeSeries::to_string(self : SortexchangepancakeSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct SortexchangepancakeMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn sort_exchange_pancake_make_matrix(rows : Int, cols : Int, val : Double) -> SortexchangepancakeMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn sort_exchange_pancake_matrix_identity(n : Int) -> SortexchangepancakeMatrix {
  let m = sort_exchange_pancake_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn SortexchangepancakeMatrix::get(self : SortexchangepancakeMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn SortexchangepancakeMatrix::transpose(self : SortexchangepancakeMatrix) -> SortexchangepancakeMatrix {
  let result = sort_exchange_pancake_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn SortexchangepancakeMatrix::add(self : SortexchangepancakeMatrix, other : SortexchangepancakeMatrix) -> SortexchangepancakeMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = sort_exchange_pancake_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn SortexchangepancakeMatrix::scale(self : SortexchangepancakeMatrix, s : Double) -> SortexchangepancakeMatrix {
  let result = sort_exchange_pancake_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn SortexchangepancakeMatrix::multiply(self : SortexchangepancakeMatrix, other : SortexchangepancakeMatrix) -> SortexchangepancakeMatrix {
  if self.cols != other.rows { return sort_exchange_pancake_make_matrix(self.rows, other.cols, 0.0) }
  let result = sort_exchange_pancake_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn SortexchangepancakeMatrix::trace(self : SortexchangepancakeMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn SortexchangepancakeMatrix::det(self : SortexchangepancakeMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn SortexchangepancakeMatrix::norm(self : SortexchangepancakeMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn SortexchangepancakeMatrix::to_string(self : SortexchangepancakeMatrix) -> String {
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

pub(all) struct SortexchangepancakeVector {
  comps : Array[Double]
  dim : Int
}

pub fn sort_exchange_pancake_make_vector(comps : Array[Double]) -> SortexchangepancakeVector {
  { comps, dim: comps.length() }
}

pub fn sort_exchange_pancake_vector_zero(dim : Int) -> SortexchangepancakeVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn SortexchangepancakeVector::add(self : SortexchangepancakeVector, other : SortexchangepancakeVector) -> SortexchangepancakeVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn SortexchangepancakeVector::sub(self : SortexchangepancakeVector, other : SortexchangepancakeVector) -> SortexchangepancakeVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn SortexchangepancakeVector::scale(self : SortexchangepancakeVector, s : Double) -> SortexchangepancakeVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn SortexchangepancakeVector::dot(self : SortexchangepancakeVector, other : SortexchangepancakeVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn SortexchangepancakeVector::norm(self : SortexchangepancakeVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn SortexchangepancakeVector::normalize(self : SortexchangepancakeVector) -> SortexchangepancakeVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn SortexchangepancakeVector::dist(self : SortexchangepancakeVector, other : SortexchangepancakeVector) -> Double {
  self.sub(other).norm()
}

pub fn SortexchangepancakeVector::to_string(self : SortexchangepancakeVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn sort_exchange_pancake_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn sort_exchange_pancake_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn sort_exchange_pancake_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn sort_exchange_pancake_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn sort_exchange_pancake_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn sort_exchange_pancake_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn sort_exchange_pancake_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn sort_exchange_pancake_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn sort_exchange_pancake_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn sort_exchange_pancake_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn sort_exchange_pancake_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn sort_exchange_pancake_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn sort_exchange_pancake_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn sort_exchange_pancake_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn sort_exchange_pancake_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn sort_exchange_pancake_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn sort_exchange_pancake_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn sort_exchange_pancake_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn sort_exchange_pancake_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn sort_exchange_pancake_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn sort_exchange_pancake_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn sort_exchange_pancake_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn sort_exchange_pancake_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn sort_exchange_pancake_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn sort_exchange_pancake_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn sort_exchange_pancake_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn sort_exchange_pancake_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn sort_exchange_pancake_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn sort_exchange_pancake_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct SortexchangepancakeFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_exchange_pancake_frame_make(size : Int) -> SortexchangepancakeFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_exchange_pancake_frame_len(s : SortexchangepancakeFrame) -> Int { s.size }

pub fn sort_exchange_pancake_frame_get(s : SortexchangepancakeFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_exchange_pancake_frame_set(s : SortexchangepancakeFrame, i : Int, v : Double) -> SortexchangepancakeFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_exchange_pancake_frame_sum(s : SortexchangepancakeFrame) -> Double { @_common.sum(s.data) }

pub fn sort_exchange_pancake_frame_mean(s : SortexchangepancakeFrame) -> Double { @_common.mean(s.data) }

pub fn sort_exchange_pancake_frame_scale(s : SortexchangepancakeFrame, f : Double) -> SortexchangepancakeFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_exchange_pancake_frame_add(a : SortexchangepancakeFrame, b : SortexchangepancakeFrame) -> SortexchangepancakeFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_exchange_pancake_frame_copy(s : SortexchangepancakeFrame) -> SortexchangepancakeFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_exchange_pancake_frame_fill(s : SortexchangepancakeFrame, v : Double) -> SortexchangepancakeFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_exchange_pancake_frame_min(s : SortexchangepancakeFrame) -> Double { @_common.min(s.data) }

pub fn sort_exchange_pancake_frame_max(s : SortexchangepancakeFrame) -> Double { @_common.max(s.data) }

pub fn sort_exchange_pancake_frame_to_string(s : SortexchangepancakeFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortexchangepancakeTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_exchange_pancake_table_make(size : Int) -> SortexchangepancakeTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_exchange_pancake_table_len(s : SortexchangepancakeTable) -> Int { s.size }

pub fn sort_exchange_pancake_table_get(s : SortexchangepancakeTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_exchange_pancake_table_set(s : SortexchangepancakeTable, i : Int, v : Double) -> SortexchangepancakeTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_exchange_pancake_table_sum(s : SortexchangepancakeTable) -> Double { @_common.sum(s.data) }

pub fn sort_exchange_pancake_table_mean(s : SortexchangepancakeTable) -> Double { @_common.mean(s.data) }

pub fn sort_exchange_pancake_table_scale(s : SortexchangepancakeTable, f : Double) -> SortexchangepancakeTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_exchange_pancake_table_add(a : SortexchangepancakeTable, b : SortexchangepancakeTable) -> SortexchangepancakeTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_exchange_pancake_table_copy(s : SortexchangepancakeTable) -> SortexchangepancakeTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_exchange_pancake_table_fill(s : SortexchangepancakeTable, v : Double) -> SortexchangepancakeTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_exchange_pancake_table_min(s : SortexchangepancakeTable) -> Double { @_common.min(s.data) }

pub fn sort_exchange_pancake_table_max(s : SortexchangepancakeTable) -> Double { @_common.max(s.data) }

pub fn sort_exchange_pancake_table_to_string(s : SortexchangepancakeTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortexchangepancakeGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_exchange_pancake_graphn_make(size : Int) -> SortexchangepancakeGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_exchange_pancake_graphn_len(s : SortexchangepancakeGraphN) -> Int { s.size }

pub fn sort_exchange_pancake_graphn_get(s : SortexchangepancakeGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_exchange_pancake_graphn_set(s : SortexchangepancakeGraphN, i : Int, v : Double) -> SortexchangepancakeGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_exchange_pancake_graphn_sum(s : SortexchangepancakeGraphN) -> Double { @_common.sum(s.data) }

pub fn sort_exchange_pancake_graphn_mean(s : SortexchangepancakeGraphN) -> Double { @_common.mean(s.data) }

pub fn sort_exchange_pancake_graphn_scale(s : SortexchangepancakeGraphN, f : Double) -> SortexchangepancakeGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_exchange_pancake_graphn_add(a : SortexchangepancakeGraphN, b : SortexchangepancakeGraphN) -> SortexchangepancakeGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_exchange_pancake_graphn_copy(s : SortexchangepancakeGraphN) -> SortexchangepancakeGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_exchange_pancake_graphn_fill(s : SortexchangepancakeGraphN, v : Double) -> SortexchangepancakeGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_exchange_pancake_graphn_min(s : SortexchangepancakeGraphN) -> Double { @_common.min(s.data) }

pub fn sort_exchange_pancake_graphn_max(s : SortexchangepancakeGraphN) -> Double { @_common.max(s.data) }

pub fn sort_exchange_pancake_graphn_to_string(s : SortexchangepancakeGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortexchangepancakeNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_exchange_pancake_node_make(size : Int) -> SortexchangepancakeNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_exchange_pancake_node_len(s : SortexchangepancakeNode) -> Int { s.size }

pub fn sort_exchange_pancake_node_get(s : SortexchangepancakeNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_exchange_pancake_node_set(s : SortexchangepancakeNode, i : Int, v : Double) -> SortexchangepancakeNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_exchange_pancake_node_sum(s : SortexchangepancakeNode) -> Double { @_common.sum(s.data) }

pub fn sort_exchange_pancake_node_mean(s : SortexchangepancakeNode) -> Double { @_common.mean(s.data) }

pub fn sort_exchange_pancake_node_scale(s : SortexchangepancakeNode, f : Double) -> SortexchangepancakeNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_exchange_pancake_node_add(a : SortexchangepancakeNode, b : SortexchangepancakeNode) -> SortexchangepancakeNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_exchange_pancake_node_copy(s : SortexchangepancakeNode) -> SortexchangepancakeNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_exchange_pancake_node_fill(s : SortexchangepancakeNode, v : Double) -> SortexchangepancakeNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_exchange_pancake_node_min(s : SortexchangepancakeNode) -> Double { @_common.min(s.data) }

pub fn sort_exchange_pancake_node_max(s : SortexchangepancakeNode) -> Double { @_common.max(s.data) }

pub fn sort_exchange_pancake_node_to_string(s : SortexchangepancakeNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortexchangepancakeEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_exchange_pancake_edge_make(size : Int) -> SortexchangepancakeEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_exchange_pancake_edge_len(s : SortexchangepancakeEdge) -> Int { s.size }

pub fn sort_exchange_pancake_edge_get(s : SortexchangepancakeEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_exchange_pancake_edge_set(s : SortexchangepancakeEdge, i : Int, v : Double) -> SortexchangepancakeEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_exchange_pancake_edge_sum(s : SortexchangepancakeEdge) -> Double { @_common.sum(s.data) }

pub fn sort_exchange_pancake_edge_mean(s : SortexchangepancakeEdge) -> Double { @_common.mean(s.data) }

pub fn sort_exchange_pancake_edge_scale(s : SortexchangepancakeEdge, f : Double) -> SortexchangepancakeEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_exchange_pancake_edge_add(a : SortexchangepancakeEdge, b : SortexchangepancakeEdge) -> SortexchangepancakeEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_exchange_pancake_edge_copy(s : SortexchangepancakeEdge) -> SortexchangepancakeEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_exchange_pancake_edge_fill(s : SortexchangepancakeEdge, v : Double) -> SortexchangepancakeEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_exchange_pancake_edge_min(s : SortexchangepancakeEdge) -> Double { @_common.min(s.data) }

pub fn sort_exchange_pancake_edge_max(s : SortexchangepancakeEdge) -> Double { @_common.max(s.data) }

pub fn sort_exchange_pancake_edge_to_string(s : SortexchangepancakeEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortexchangepancakePath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_exchange_pancake_path_make(size : Int) -> SortexchangepancakePath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_exchange_pancake_path_len(s : SortexchangepancakePath) -> Int { s.size }

pub fn sort_exchange_pancake_path_get(s : SortexchangepancakePath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_exchange_pancake_path_set(s : SortexchangepancakePath, i : Int, v : Double) -> SortexchangepancakePath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_exchange_pancake_path_sum(s : SortexchangepancakePath) -> Double { @_common.sum(s.data) }

pub fn sort_exchange_pancake_path_mean(s : SortexchangepancakePath) -> Double { @_common.mean(s.data) }

pub fn sort_exchange_pancake_path_scale(s : SortexchangepancakePath, f : Double) -> SortexchangepancakePath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_exchange_pancake_path_add(a : SortexchangepancakePath, b : SortexchangepancakePath) -> SortexchangepancakePath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_exchange_pancake_path_copy(s : SortexchangepancakePath) -> SortexchangepancakePath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_exchange_pancake_path_fill(s : SortexchangepancakePath, v : Double) -> SortexchangepancakePath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_exchange_pancake_path_min(s : SortexchangepancakePath) -> Double { @_common.min(s.data) }

pub fn sort_exchange_pancake_path_max(s : SortexchangepancakePath) -> Double { @_common.max(s.data) }

pub fn sort_exchange_pancake_path_to_string(s : SortexchangepancakePath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortexchangepancakeCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_exchange_pancake_cluster_make(size : Int) -> SortexchangepancakeCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_exchange_pancake_cluster_len(s : SortexchangepancakeCluster) -> Int { s.size }

pub fn sort_exchange_pancake_cluster_get(s : SortexchangepancakeCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_exchange_pancake_cluster_set(s : SortexchangepancakeCluster, i : Int, v : Double) -> SortexchangepancakeCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_exchange_pancake_cluster_sum(s : SortexchangepancakeCluster) -> Double { @_common.sum(s.data) }

pub fn sort_exchange_pancake_cluster_mean(s : SortexchangepancakeCluster) -> Double { @_common.mean(s.data) }

pub fn sort_exchange_pancake_cluster_scale(s : SortexchangepancakeCluster, f : Double) -> SortexchangepancakeCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_exchange_pancake_cluster_add(a : SortexchangepancakeCluster, b : SortexchangepancakeCluster) -> SortexchangepancakeCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_exchange_pancake_cluster_copy(s : SortexchangepancakeCluster) -> SortexchangepancakeCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_exchange_pancake_cluster_fill(s : SortexchangepancakeCluster, v : Double) -> SortexchangepancakeCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_exchange_pancake_cluster_min(s : SortexchangepancakeCluster) -> Double { @_common.min(s.data) }

pub fn sort_exchange_pancake_cluster_max(s : SortexchangepancakeCluster) -> Double { @_common.max(s.data) }

pub fn sort_exchange_pancake_cluster_to_string(s : SortexchangepancakeCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortexchangepancakeModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_exchange_pancake_model_make(size : Int) -> SortexchangepancakeModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_exchange_pancake_model_len(s : SortexchangepancakeModel) -> Int { s.size }

pub fn sort_exchange_pancake_model_get(s : SortexchangepancakeModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_exchange_pancake_model_set(s : SortexchangepancakeModel, i : Int, v : Double) -> SortexchangepancakeModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_exchange_pancake_model_sum(s : SortexchangepancakeModel) -> Double { @_common.sum(s.data) }

pub fn sort_exchange_pancake_model_mean(s : SortexchangepancakeModel) -> Double { @_common.mean(s.data) }

pub fn sort_exchange_pancake_model_scale(s : SortexchangepancakeModel, f : Double) -> SortexchangepancakeModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_exchange_pancake_model_add(a : SortexchangepancakeModel, b : SortexchangepancakeModel) -> SortexchangepancakeModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_exchange_pancake_model_copy(s : SortexchangepancakeModel) -> SortexchangepancakeModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_exchange_pancake_model_fill(s : SortexchangepancakeModel, v : Double) -> SortexchangepancakeModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_exchange_pancake_model_min(s : SortexchangepancakeModel) -> Double { @_common.min(s.data) }

pub fn sort_exchange_pancake_model_max(s : SortexchangepancakeModel) -> Double { @_common.max(s.data) }

pub fn sort_exchange_pancake_model_to_string(s : SortexchangepancakeModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortexchangepancakeLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_exchange_pancake_layer_make(size : Int) -> SortexchangepancakeLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_exchange_pancake_layer_len(s : SortexchangepancakeLayer) -> Int { s.size }

pub fn sort_exchange_pancake_layer_get(s : SortexchangepancakeLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_exchange_pancake_layer_set(s : SortexchangepancakeLayer, i : Int, v : Double) -> SortexchangepancakeLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_exchange_pancake_layer_sum(s : SortexchangepancakeLayer) -> Double { @_common.sum(s.data) }

pub fn sort_exchange_pancake_layer_mean(s : SortexchangepancakeLayer) -> Double { @_common.mean(s.data) }

pub fn sort_exchange_pancake_layer_scale(s : SortexchangepancakeLayer, f : Double) -> SortexchangepancakeLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_exchange_pancake_layer_add(a : SortexchangepancakeLayer, b : SortexchangepancakeLayer) -> SortexchangepancakeLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_exchange_pancake_layer_copy(s : SortexchangepancakeLayer) -> SortexchangepancakeLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_exchange_pancake_layer_fill(s : SortexchangepancakeLayer, v : Double) -> SortexchangepancakeLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_exchange_pancake_layer_min(s : SortexchangepancakeLayer) -> Double { @_common.min(s.data) }

pub fn sort_exchange_pancake_layer_max(s : SortexchangepancakeLayer) -> Double { @_common.max(s.data) }

pub fn sort_exchange_pancake_layer_to_string(s : SortexchangepancakeLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortexchangepancakeBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_exchange_pancake_buffer_make(size : Int) -> SortexchangepancakeBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_exchange_pancake_buffer_len(s : SortexchangepancakeBuffer) -> Int { s.size }

pub fn sort_exchange_pancake_buffer_get(s : SortexchangepancakeBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_exchange_pancake_buffer_set(s : SortexchangepancakeBuffer, i : Int, v : Double) -> SortexchangepancakeBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_exchange_pancake_buffer_sum(s : SortexchangepancakeBuffer) -> Double { @_common.sum(s.data) }

pub fn sort_exchange_pancake_buffer_mean(s : SortexchangepancakeBuffer) -> Double { @_common.mean(s.data) }

pub fn sort_exchange_pancake_buffer_scale(s : SortexchangepancakeBuffer, f : Double) -> SortexchangepancakeBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_exchange_pancake_buffer_add(a : SortexchangepancakeBuffer, b : SortexchangepancakeBuffer) -> SortexchangepancakeBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_exchange_pancake_buffer_copy(s : SortexchangepancakeBuffer) -> SortexchangepancakeBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_exchange_pancake_buffer_fill(s : SortexchangepancakeBuffer, v : Double) -> SortexchangepancakeBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_exchange_pancake_buffer_min(s : SortexchangepancakeBuffer) -> Double { @_common.min(s.data) }

pub fn sort_exchange_pancake_buffer_max(s : SortexchangepancakeBuffer) -> Double { @_common.max(s.data) }

pub fn sort_exchange_pancake_buffer_to_string(s : SortexchangepancakeBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortexchangepancakeCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_exchange_pancake_cursor_make(size : Int) -> SortexchangepancakeCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_exchange_pancake_cursor_len(s : SortexchangepancakeCursor) -> Int { s.size }

pub fn sort_exchange_pancake_cursor_get(s : SortexchangepancakeCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_exchange_pancake_cursor_set(s : SortexchangepancakeCursor, i : Int, v : Double) -> SortexchangepancakeCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_exchange_pancake_cursor_sum(s : SortexchangepancakeCursor) -> Double { @_common.sum(s.data) }

pub fn sort_exchange_pancake_cursor_mean(s : SortexchangepancakeCursor) -> Double { @_common.mean(s.data) }

pub fn sort_exchange_pancake_cursor_scale(s : SortexchangepancakeCursor, f : Double) -> SortexchangepancakeCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_exchange_pancake_cursor_add(a : SortexchangepancakeCursor, b : SortexchangepancakeCursor) -> SortexchangepancakeCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_exchange_pancake_cursor_copy(s : SortexchangepancakeCursor) -> SortexchangepancakeCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_exchange_pancake_cursor_fill(s : SortexchangepancakeCursor, v : Double) -> SortexchangepancakeCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_exchange_pancake_cursor_min(s : SortexchangepancakeCursor) -> Double { @_common.min(s.data) }

pub fn sort_exchange_pancake_cursor_max(s : SortexchangepancakeCursor) -> Double { @_common.max(s.data) }

pub fn sort_exchange_pancake_cursor_to_string(s : SortexchangepancakeCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortexchangepancakeView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_exchange_pancake_view_make(size : Int) -> SortexchangepancakeView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_exchange_pancake_view_len(s : SortexchangepancakeView) -> Int { s.size }

pub fn sort_exchange_pancake_view_get(s : SortexchangepancakeView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_exchange_pancake_view_set(s : SortexchangepancakeView, i : Int, v : Double) -> SortexchangepancakeView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_exchange_pancake_view_sum(s : SortexchangepancakeView) -> Double { @_common.sum(s.data) }

pub fn sort_exchange_pancake_view_mean(s : SortexchangepancakeView) -> Double { @_common.mean(s.data) }

pub fn sort_exchange_pancake_view_scale(s : SortexchangepancakeView, f : Double) -> SortexchangepancakeView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_exchange_pancake_view_add(a : SortexchangepancakeView, b : SortexchangepancakeView) -> SortexchangepancakeView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_exchange_pancake_view_copy(s : SortexchangepancakeView) -> SortexchangepancakeView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_exchange_pancake_view_fill(s : SortexchangepancakeView, v : Double) -> SortexchangepancakeView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_exchange_pancake_view_min(s : SortexchangepancakeView) -> Double { @_common.min(s.data) }

pub fn sort_exchange_pancake_view_max(s : SortexchangepancakeView) -> Double { @_common.max(s.data) }

pub fn sort_exchange_pancake_view_to_string(s : SortexchangepancakeView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortexchangepancakeRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_exchange_pancake_range_make(size : Int) -> SortexchangepancakeRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_exchange_pancake_range_len(s : SortexchangepancakeRange) -> Int { s.size }

pub fn sort_exchange_pancake_range_get(s : SortexchangepancakeRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_exchange_pancake_range_set(s : SortexchangepancakeRange, i : Int, v : Double) -> SortexchangepancakeRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_exchange_pancake_range_sum(s : SortexchangepancakeRange) -> Double { @_common.sum(s.data) }

pub fn sort_exchange_pancake_range_mean(s : SortexchangepancakeRange) -> Double { @_common.mean(s.data) }

pub fn sort_exchange_pancake_range_scale(s : SortexchangepancakeRange, f : Double) -> SortexchangepancakeRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_exchange_pancake_range_add(a : SortexchangepancakeRange, b : SortexchangepancakeRange) -> SortexchangepancakeRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_exchange_pancake_range_copy(s : SortexchangepancakeRange) -> SortexchangepancakeRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_exchange_pancake_range_fill(s : SortexchangepancakeRange, v : Double) -> SortexchangepancakeRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_exchange_pancake_range_min(s : SortexchangepancakeRange) -> Double { @_common.min(s.data) }

pub fn sort_exchange_pancake_range_max(s : SortexchangepancakeRange) -> Double { @_common.max(s.data) }

pub fn sort_exchange_pancake_range_to_string(s : SortexchangepancakeRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortexchangepancakeSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_exchange_pancake_slice_make(size : Int) -> SortexchangepancakeSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_exchange_pancake_slice_len(s : SortexchangepancakeSlice) -> Int { s.size }

pub fn sort_exchange_pancake_slice_get(s : SortexchangepancakeSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_exchange_pancake_slice_set(s : SortexchangepancakeSlice, i : Int, v : Double) -> SortexchangepancakeSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_exchange_pancake_slice_sum(s : SortexchangepancakeSlice) -> Double { @_common.sum(s.data) }

pub fn sort_exchange_pancake_slice_mean(s : SortexchangepancakeSlice) -> Double { @_common.mean(s.data) }

pub fn sort_exchange_pancake_slice_scale(s : SortexchangepancakeSlice, f : Double) -> SortexchangepancakeSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_exchange_pancake_slice_add(a : SortexchangepancakeSlice, b : SortexchangepancakeSlice) -> SortexchangepancakeSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_exchange_pancake_slice_copy(s : SortexchangepancakeSlice) -> SortexchangepancakeSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_exchange_pancake_slice_fill(s : SortexchangepancakeSlice, v : Double) -> SortexchangepancakeSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_exchange_pancake_slice_min(s : SortexchangepancakeSlice) -> Double { @_common.min(s.data) }

pub fn sort_exchange_pancake_slice_max(s : SortexchangepancakeSlice) -> Double { @_common.max(s.data) }

pub fn sort_exchange_pancake_slice_to_string(s : SortexchangepancakeSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

