///===
/// extcore/sort_exchange_bogo

pub(all) struct SortexchangebogoPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn sort_exchange_bogo_make_point(x : Double, y : Double) -> SortexchangebogoPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn sort_exchange_bogo_make_point3(x : Double, y : Double, z : Double) -> SortexchangebogoPoint {
  { x, y, z, label: 0 }
}

pub fn SortexchangebogoPoint::x(self : SortexchangebogoPoint) -> Double { self.x }

pub fn SortexchangebogoPoint::y(self : SortexchangebogoPoint) -> Double { self.y }

pub fn SortexchangebogoPoint::z(self : SortexchangebogoPoint) -> Double { self.z }

pub fn SortexchangebogoPoint::label(self : SortexchangebogoPoint) -> Int { self.label }

pub fn SortexchangebogoPoint::dist(self : SortexchangebogoPoint, other : SortexchangebogoPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn SortexchangebogoPoint::add(self : SortexchangebogoPoint, other : SortexchangebogoPoint) -> SortexchangebogoPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn SortexchangebogoPoint::sub(self : SortexchangebogoPoint, other : SortexchangebogoPoint) -> SortexchangebogoPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn SortexchangebogoPoint::scale(self : SortexchangebogoPoint, s : Double) -> SortexchangebogoPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn SortexchangebogoPoint::dot(self : SortexchangebogoPoint, other : SortexchangebogoPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn SortexchangebogoPoint::cross(self : SortexchangebogoPoint, other : SortexchangebogoPoint) -> SortexchangebogoPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn SortexchangebogoPoint::norm(self : SortexchangebogoPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn SortexchangebogoPoint::normalize(self : SortexchangebogoPoint) -> SortexchangebogoPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn SortexchangebogoPoint::negate(self : SortexchangebogoPoint) -> SortexchangebogoPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn SortexchangebogoPoint::mid(self : SortexchangebogoPoint, other : SortexchangebogoPoint) -> SortexchangebogoPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn SortexchangebogoPoint::lerp(self : SortexchangebogoPoint, other : SortexchangebogoPoint, t : Double) -> SortexchangebogoPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn SortexchangebogoPoint::to_string(self : SortexchangebogoPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct SortexchangebogoSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn sort_exchange_bogo_make_series(vals : Array[Double], name : String) -> SortexchangebogoSeries {
  { vals, name, meta: 0 }
}

pub fn SortexchangebogoSeries::len(self : SortexchangebogoSeries) -> Int { self.vals.length() }

pub fn SortexchangebogoSeries::sum(self : SortexchangebogoSeries) -> Double { @_common.sum(self.vals) }

pub fn SortexchangebogoSeries::mean(self : SortexchangebogoSeries) -> Double { @_common.mean(self.vals) }

pub fn SortexchangebogoSeries::min(self : SortexchangebogoSeries) -> Double { @_common.min(self.vals) }

pub fn SortexchangebogoSeries::max(self : SortexchangebogoSeries) -> Double { @_common.max(self.vals) }

pub fn SortexchangebogoSeries::range(self : SortexchangebogoSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn SortexchangebogoSeries::variance(self : SortexchangebogoSeries) -> Double { @_common.variance(self.vals) }

pub fn SortexchangebogoSeries::std(self : SortexchangebogoSeries) -> Double { @_common.std(self.vals) }

pub fn SortexchangebogoSeries::median(self : SortexchangebogoSeries) -> Double { @_common.median(self.vals) }

pub fn SortexchangebogoSeries::scale(self : SortexchangebogoSeries, f : Double) -> SortexchangebogoSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn SortexchangebogoSeries::add(self : SortexchangebogoSeries, other : SortexchangebogoSeries) -> SortexchangebogoSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn SortexchangebogoSeries::sub(self : SortexchangebogoSeries, other : SortexchangebogoSeries) -> SortexchangebogoSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn SortexchangebogoSeries::normalize(self : SortexchangebogoSeries) -> SortexchangebogoSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn SortexchangebogoSeries::cumsum(self : SortexchangebogoSeries) -> SortexchangebogoSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn SortexchangebogoSeries::to_string(self : SortexchangebogoSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct SortexchangebogoMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn sort_exchange_bogo_make_matrix(rows : Int, cols : Int, val : Double) -> SortexchangebogoMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn sort_exchange_bogo_matrix_identity(n : Int) -> SortexchangebogoMatrix {
  let m = sort_exchange_bogo_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn SortexchangebogoMatrix::get(self : SortexchangebogoMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn SortexchangebogoMatrix::transpose(self : SortexchangebogoMatrix) -> SortexchangebogoMatrix {
  let result = sort_exchange_bogo_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn SortexchangebogoMatrix::add(self : SortexchangebogoMatrix, other : SortexchangebogoMatrix) -> SortexchangebogoMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = sort_exchange_bogo_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn SortexchangebogoMatrix::scale(self : SortexchangebogoMatrix, s : Double) -> SortexchangebogoMatrix {
  let result = sort_exchange_bogo_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn SortexchangebogoMatrix::multiply(self : SortexchangebogoMatrix, other : SortexchangebogoMatrix) -> SortexchangebogoMatrix {
  if self.cols != other.rows { return sort_exchange_bogo_make_matrix(self.rows, other.cols, 0.0) }
  let result = sort_exchange_bogo_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn SortexchangebogoMatrix::trace(self : SortexchangebogoMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn SortexchangebogoMatrix::det(self : SortexchangebogoMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn SortexchangebogoMatrix::norm(self : SortexchangebogoMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn SortexchangebogoMatrix::to_string(self : SortexchangebogoMatrix) -> String {
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

pub(all) struct SortexchangebogoVector {
  comps : Array[Double]
  dim : Int
}

pub fn sort_exchange_bogo_make_vector(comps : Array[Double]) -> SortexchangebogoVector {
  { comps, dim: comps.length() }
}

pub fn sort_exchange_bogo_vector_zero(dim : Int) -> SortexchangebogoVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn SortexchangebogoVector::add(self : SortexchangebogoVector, other : SortexchangebogoVector) -> SortexchangebogoVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn SortexchangebogoVector::sub(self : SortexchangebogoVector, other : SortexchangebogoVector) -> SortexchangebogoVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn SortexchangebogoVector::scale(self : SortexchangebogoVector, s : Double) -> SortexchangebogoVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn SortexchangebogoVector::dot(self : SortexchangebogoVector, other : SortexchangebogoVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn SortexchangebogoVector::norm(self : SortexchangebogoVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn SortexchangebogoVector::normalize(self : SortexchangebogoVector) -> SortexchangebogoVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn SortexchangebogoVector::dist(self : SortexchangebogoVector, other : SortexchangebogoVector) -> Double {
  self.sub(other).norm()
}

pub fn SortexchangebogoVector::to_string(self : SortexchangebogoVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn sort_exchange_bogo_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn sort_exchange_bogo_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn sort_exchange_bogo_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn sort_exchange_bogo_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn sort_exchange_bogo_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn sort_exchange_bogo_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn sort_exchange_bogo_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn sort_exchange_bogo_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn sort_exchange_bogo_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn sort_exchange_bogo_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn sort_exchange_bogo_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn sort_exchange_bogo_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn sort_exchange_bogo_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn sort_exchange_bogo_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn sort_exchange_bogo_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn sort_exchange_bogo_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn sort_exchange_bogo_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn sort_exchange_bogo_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn sort_exchange_bogo_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn sort_exchange_bogo_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn sort_exchange_bogo_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn sort_exchange_bogo_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn sort_exchange_bogo_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn sort_exchange_bogo_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn sort_exchange_bogo_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn sort_exchange_bogo_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn sort_exchange_bogo_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn sort_exchange_bogo_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn sort_exchange_bogo_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct SortexchangebogoFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_exchange_bogo_frame_make(size : Int) -> SortexchangebogoFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_exchange_bogo_frame_len(s : SortexchangebogoFrame) -> Int { s.size }

pub fn sort_exchange_bogo_frame_get(s : SortexchangebogoFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_exchange_bogo_frame_set(s : SortexchangebogoFrame, i : Int, v : Double) -> SortexchangebogoFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_exchange_bogo_frame_sum(s : SortexchangebogoFrame) -> Double { @_common.sum(s.data) }

pub fn sort_exchange_bogo_frame_mean(s : SortexchangebogoFrame) -> Double { @_common.mean(s.data) }

pub fn sort_exchange_bogo_frame_scale(s : SortexchangebogoFrame, f : Double) -> SortexchangebogoFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_exchange_bogo_frame_add(a : SortexchangebogoFrame, b : SortexchangebogoFrame) -> SortexchangebogoFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_exchange_bogo_frame_copy(s : SortexchangebogoFrame) -> SortexchangebogoFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_exchange_bogo_frame_fill(s : SortexchangebogoFrame, v : Double) -> SortexchangebogoFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_exchange_bogo_frame_min(s : SortexchangebogoFrame) -> Double { @_common.min(s.data) }

pub fn sort_exchange_bogo_frame_max(s : SortexchangebogoFrame) -> Double { @_common.max(s.data) }

pub fn sort_exchange_bogo_frame_to_string(s : SortexchangebogoFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortexchangebogoTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_exchange_bogo_table_make(size : Int) -> SortexchangebogoTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_exchange_bogo_table_len(s : SortexchangebogoTable) -> Int { s.size }

pub fn sort_exchange_bogo_table_get(s : SortexchangebogoTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_exchange_bogo_table_set(s : SortexchangebogoTable, i : Int, v : Double) -> SortexchangebogoTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_exchange_bogo_table_sum(s : SortexchangebogoTable) -> Double { @_common.sum(s.data) }

pub fn sort_exchange_bogo_table_mean(s : SortexchangebogoTable) -> Double { @_common.mean(s.data) }

pub fn sort_exchange_bogo_table_scale(s : SortexchangebogoTable, f : Double) -> SortexchangebogoTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_exchange_bogo_table_add(a : SortexchangebogoTable, b : SortexchangebogoTable) -> SortexchangebogoTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_exchange_bogo_table_copy(s : SortexchangebogoTable) -> SortexchangebogoTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_exchange_bogo_table_fill(s : SortexchangebogoTable, v : Double) -> SortexchangebogoTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_exchange_bogo_table_min(s : SortexchangebogoTable) -> Double { @_common.min(s.data) }

pub fn sort_exchange_bogo_table_max(s : SortexchangebogoTable) -> Double { @_common.max(s.data) }

pub fn sort_exchange_bogo_table_to_string(s : SortexchangebogoTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortexchangebogoGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_exchange_bogo_graphn_make(size : Int) -> SortexchangebogoGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_exchange_bogo_graphn_len(s : SortexchangebogoGraphN) -> Int { s.size }

pub fn sort_exchange_bogo_graphn_get(s : SortexchangebogoGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_exchange_bogo_graphn_set(s : SortexchangebogoGraphN, i : Int, v : Double) -> SortexchangebogoGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_exchange_bogo_graphn_sum(s : SortexchangebogoGraphN) -> Double { @_common.sum(s.data) }

pub fn sort_exchange_bogo_graphn_mean(s : SortexchangebogoGraphN) -> Double { @_common.mean(s.data) }

pub fn sort_exchange_bogo_graphn_scale(s : SortexchangebogoGraphN, f : Double) -> SortexchangebogoGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_exchange_bogo_graphn_add(a : SortexchangebogoGraphN, b : SortexchangebogoGraphN) -> SortexchangebogoGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_exchange_bogo_graphn_copy(s : SortexchangebogoGraphN) -> SortexchangebogoGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_exchange_bogo_graphn_fill(s : SortexchangebogoGraphN, v : Double) -> SortexchangebogoGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_exchange_bogo_graphn_min(s : SortexchangebogoGraphN) -> Double { @_common.min(s.data) }

pub fn sort_exchange_bogo_graphn_max(s : SortexchangebogoGraphN) -> Double { @_common.max(s.data) }

pub fn sort_exchange_bogo_graphn_to_string(s : SortexchangebogoGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortexchangebogoNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_exchange_bogo_node_make(size : Int) -> SortexchangebogoNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_exchange_bogo_node_len(s : SortexchangebogoNode) -> Int { s.size }

pub fn sort_exchange_bogo_node_get(s : SortexchangebogoNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_exchange_bogo_node_set(s : SortexchangebogoNode, i : Int, v : Double) -> SortexchangebogoNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_exchange_bogo_node_sum(s : SortexchangebogoNode) -> Double { @_common.sum(s.data) }

pub fn sort_exchange_bogo_node_mean(s : SortexchangebogoNode) -> Double { @_common.mean(s.data) }

pub fn sort_exchange_bogo_node_scale(s : SortexchangebogoNode, f : Double) -> SortexchangebogoNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_exchange_bogo_node_add(a : SortexchangebogoNode, b : SortexchangebogoNode) -> SortexchangebogoNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_exchange_bogo_node_copy(s : SortexchangebogoNode) -> SortexchangebogoNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_exchange_bogo_node_fill(s : SortexchangebogoNode, v : Double) -> SortexchangebogoNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_exchange_bogo_node_min(s : SortexchangebogoNode) -> Double { @_common.min(s.data) }

pub fn sort_exchange_bogo_node_max(s : SortexchangebogoNode) -> Double { @_common.max(s.data) }

pub fn sort_exchange_bogo_node_to_string(s : SortexchangebogoNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortexchangebogoEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_exchange_bogo_edge_make(size : Int) -> SortexchangebogoEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_exchange_bogo_edge_len(s : SortexchangebogoEdge) -> Int { s.size }

pub fn sort_exchange_bogo_edge_get(s : SortexchangebogoEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_exchange_bogo_edge_set(s : SortexchangebogoEdge, i : Int, v : Double) -> SortexchangebogoEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_exchange_bogo_edge_sum(s : SortexchangebogoEdge) -> Double { @_common.sum(s.data) }

pub fn sort_exchange_bogo_edge_mean(s : SortexchangebogoEdge) -> Double { @_common.mean(s.data) }

pub fn sort_exchange_bogo_edge_scale(s : SortexchangebogoEdge, f : Double) -> SortexchangebogoEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_exchange_bogo_edge_add(a : SortexchangebogoEdge, b : SortexchangebogoEdge) -> SortexchangebogoEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_exchange_bogo_edge_copy(s : SortexchangebogoEdge) -> SortexchangebogoEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_exchange_bogo_edge_fill(s : SortexchangebogoEdge, v : Double) -> SortexchangebogoEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_exchange_bogo_edge_min(s : SortexchangebogoEdge) -> Double { @_common.min(s.data) }

pub fn sort_exchange_bogo_edge_max(s : SortexchangebogoEdge) -> Double { @_common.max(s.data) }

pub fn sort_exchange_bogo_edge_to_string(s : SortexchangebogoEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortexchangebogoPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_exchange_bogo_path_make(size : Int) -> SortexchangebogoPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_exchange_bogo_path_len(s : SortexchangebogoPath) -> Int { s.size }

pub fn sort_exchange_bogo_path_get(s : SortexchangebogoPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_exchange_bogo_path_set(s : SortexchangebogoPath, i : Int, v : Double) -> SortexchangebogoPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_exchange_bogo_path_sum(s : SortexchangebogoPath) -> Double { @_common.sum(s.data) }

pub fn sort_exchange_bogo_path_mean(s : SortexchangebogoPath) -> Double { @_common.mean(s.data) }

pub fn sort_exchange_bogo_path_scale(s : SortexchangebogoPath, f : Double) -> SortexchangebogoPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_exchange_bogo_path_add(a : SortexchangebogoPath, b : SortexchangebogoPath) -> SortexchangebogoPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_exchange_bogo_path_copy(s : SortexchangebogoPath) -> SortexchangebogoPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_exchange_bogo_path_fill(s : SortexchangebogoPath, v : Double) -> SortexchangebogoPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_exchange_bogo_path_min(s : SortexchangebogoPath) -> Double { @_common.min(s.data) }

pub fn sort_exchange_bogo_path_max(s : SortexchangebogoPath) -> Double { @_common.max(s.data) }

pub fn sort_exchange_bogo_path_to_string(s : SortexchangebogoPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortexchangebogoCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_exchange_bogo_cluster_make(size : Int) -> SortexchangebogoCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_exchange_bogo_cluster_len(s : SortexchangebogoCluster) -> Int { s.size }

pub fn sort_exchange_bogo_cluster_get(s : SortexchangebogoCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_exchange_bogo_cluster_set(s : SortexchangebogoCluster, i : Int, v : Double) -> SortexchangebogoCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_exchange_bogo_cluster_sum(s : SortexchangebogoCluster) -> Double { @_common.sum(s.data) }

pub fn sort_exchange_bogo_cluster_mean(s : SortexchangebogoCluster) -> Double { @_common.mean(s.data) }

pub fn sort_exchange_bogo_cluster_scale(s : SortexchangebogoCluster, f : Double) -> SortexchangebogoCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_exchange_bogo_cluster_add(a : SortexchangebogoCluster, b : SortexchangebogoCluster) -> SortexchangebogoCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_exchange_bogo_cluster_copy(s : SortexchangebogoCluster) -> SortexchangebogoCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_exchange_bogo_cluster_fill(s : SortexchangebogoCluster, v : Double) -> SortexchangebogoCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_exchange_bogo_cluster_min(s : SortexchangebogoCluster) -> Double { @_common.min(s.data) }

pub fn sort_exchange_bogo_cluster_max(s : SortexchangebogoCluster) -> Double { @_common.max(s.data) }

pub fn sort_exchange_bogo_cluster_to_string(s : SortexchangebogoCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortexchangebogoModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_exchange_bogo_model_make(size : Int) -> SortexchangebogoModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_exchange_bogo_model_len(s : SortexchangebogoModel) -> Int { s.size }

pub fn sort_exchange_bogo_model_get(s : SortexchangebogoModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_exchange_bogo_model_set(s : SortexchangebogoModel, i : Int, v : Double) -> SortexchangebogoModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_exchange_bogo_model_sum(s : SortexchangebogoModel) -> Double { @_common.sum(s.data) }

pub fn sort_exchange_bogo_model_mean(s : SortexchangebogoModel) -> Double { @_common.mean(s.data) }

pub fn sort_exchange_bogo_model_scale(s : SortexchangebogoModel, f : Double) -> SortexchangebogoModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_exchange_bogo_model_add(a : SortexchangebogoModel, b : SortexchangebogoModel) -> SortexchangebogoModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_exchange_bogo_model_copy(s : SortexchangebogoModel) -> SortexchangebogoModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_exchange_bogo_model_fill(s : SortexchangebogoModel, v : Double) -> SortexchangebogoModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_exchange_bogo_model_min(s : SortexchangebogoModel) -> Double { @_common.min(s.data) }

pub fn sort_exchange_bogo_model_max(s : SortexchangebogoModel) -> Double { @_common.max(s.data) }

pub fn sort_exchange_bogo_model_to_string(s : SortexchangebogoModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortexchangebogoLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_exchange_bogo_layer_make(size : Int) -> SortexchangebogoLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_exchange_bogo_layer_len(s : SortexchangebogoLayer) -> Int { s.size }

pub fn sort_exchange_bogo_layer_get(s : SortexchangebogoLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_exchange_bogo_layer_set(s : SortexchangebogoLayer, i : Int, v : Double) -> SortexchangebogoLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_exchange_bogo_layer_sum(s : SortexchangebogoLayer) -> Double { @_common.sum(s.data) }

pub fn sort_exchange_bogo_layer_mean(s : SortexchangebogoLayer) -> Double { @_common.mean(s.data) }

pub fn sort_exchange_bogo_layer_scale(s : SortexchangebogoLayer, f : Double) -> SortexchangebogoLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_exchange_bogo_layer_add(a : SortexchangebogoLayer, b : SortexchangebogoLayer) -> SortexchangebogoLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_exchange_bogo_layer_copy(s : SortexchangebogoLayer) -> SortexchangebogoLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_exchange_bogo_layer_fill(s : SortexchangebogoLayer, v : Double) -> SortexchangebogoLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_exchange_bogo_layer_min(s : SortexchangebogoLayer) -> Double { @_common.min(s.data) }

pub fn sort_exchange_bogo_layer_max(s : SortexchangebogoLayer) -> Double { @_common.max(s.data) }

pub fn sort_exchange_bogo_layer_to_string(s : SortexchangebogoLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortexchangebogoBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_exchange_bogo_buffer_make(size : Int) -> SortexchangebogoBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_exchange_bogo_buffer_len(s : SortexchangebogoBuffer) -> Int { s.size }

pub fn sort_exchange_bogo_buffer_get(s : SortexchangebogoBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_exchange_bogo_buffer_set(s : SortexchangebogoBuffer, i : Int, v : Double) -> SortexchangebogoBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_exchange_bogo_buffer_sum(s : SortexchangebogoBuffer) -> Double { @_common.sum(s.data) }

pub fn sort_exchange_bogo_buffer_mean(s : SortexchangebogoBuffer) -> Double { @_common.mean(s.data) }

pub fn sort_exchange_bogo_buffer_scale(s : SortexchangebogoBuffer, f : Double) -> SortexchangebogoBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_exchange_bogo_buffer_add(a : SortexchangebogoBuffer, b : SortexchangebogoBuffer) -> SortexchangebogoBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_exchange_bogo_buffer_copy(s : SortexchangebogoBuffer) -> SortexchangebogoBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_exchange_bogo_buffer_fill(s : SortexchangebogoBuffer, v : Double) -> SortexchangebogoBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_exchange_bogo_buffer_min(s : SortexchangebogoBuffer) -> Double { @_common.min(s.data) }

pub fn sort_exchange_bogo_buffer_max(s : SortexchangebogoBuffer) -> Double { @_common.max(s.data) }

pub fn sort_exchange_bogo_buffer_to_string(s : SortexchangebogoBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortexchangebogoCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_exchange_bogo_cursor_make(size : Int) -> SortexchangebogoCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_exchange_bogo_cursor_len(s : SortexchangebogoCursor) -> Int { s.size }

pub fn sort_exchange_bogo_cursor_get(s : SortexchangebogoCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_exchange_bogo_cursor_set(s : SortexchangebogoCursor, i : Int, v : Double) -> SortexchangebogoCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_exchange_bogo_cursor_sum(s : SortexchangebogoCursor) -> Double { @_common.sum(s.data) }

pub fn sort_exchange_bogo_cursor_mean(s : SortexchangebogoCursor) -> Double { @_common.mean(s.data) }

pub fn sort_exchange_bogo_cursor_scale(s : SortexchangebogoCursor, f : Double) -> SortexchangebogoCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_exchange_bogo_cursor_add(a : SortexchangebogoCursor, b : SortexchangebogoCursor) -> SortexchangebogoCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_exchange_bogo_cursor_copy(s : SortexchangebogoCursor) -> SortexchangebogoCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_exchange_bogo_cursor_fill(s : SortexchangebogoCursor, v : Double) -> SortexchangebogoCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_exchange_bogo_cursor_min(s : SortexchangebogoCursor) -> Double { @_common.min(s.data) }

pub fn sort_exchange_bogo_cursor_max(s : SortexchangebogoCursor) -> Double { @_common.max(s.data) }

pub fn sort_exchange_bogo_cursor_to_string(s : SortexchangebogoCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortexchangebogoView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_exchange_bogo_view_make(size : Int) -> SortexchangebogoView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_exchange_bogo_view_len(s : SortexchangebogoView) -> Int { s.size }

pub fn sort_exchange_bogo_view_get(s : SortexchangebogoView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_exchange_bogo_view_set(s : SortexchangebogoView, i : Int, v : Double) -> SortexchangebogoView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_exchange_bogo_view_sum(s : SortexchangebogoView) -> Double { @_common.sum(s.data) }

pub fn sort_exchange_bogo_view_mean(s : SortexchangebogoView) -> Double { @_common.mean(s.data) }

pub fn sort_exchange_bogo_view_scale(s : SortexchangebogoView, f : Double) -> SortexchangebogoView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_exchange_bogo_view_add(a : SortexchangebogoView, b : SortexchangebogoView) -> SortexchangebogoView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_exchange_bogo_view_copy(s : SortexchangebogoView) -> SortexchangebogoView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_exchange_bogo_view_fill(s : SortexchangebogoView, v : Double) -> SortexchangebogoView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_exchange_bogo_view_min(s : SortexchangebogoView) -> Double { @_common.min(s.data) }

pub fn sort_exchange_bogo_view_max(s : SortexchangebogoView) -> Double { @_common.max(s.data) }

pub fn sort_exchange_bogo_view_to_string(s : SortexchangebogoView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortexchangebogoRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_exchange_bogo_range_make(size : Int) -> SortexchangebogoRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_exchange_bogo_range_len(s : SortexchangebogoRange) -> Int { s.size }

pub fn sort_exchange_bogo_range_get(s : SortexchangebogoRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_exchange_bogo_range_set(s : SortexchangebogoRange, i : Int, v : Double) -> SortexchangebogoRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_exchange_bogo_range_sum(s : SortexchangebogoRange) -> Double { @_common.sum(s.data) }

pub fn sort_exchange_bogo_range_mean(s : SortexchangebogoRange) -> Double { @_common.mean(s.data) }

pub fn sort_exchange_bogo_range_scale(s : SortexchangebogoRange, f : Double) -> SortexchangebogoRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_exchange_bogo_range_add(a : SortexchangebogoRange, b : SortexchangebogoRange) -> SortexchangebogoRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_exchange_bogo_range_copy(s : SortexchangebogoRange) -> SortexchangebogoRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_exchange_bogo_range_fill(s : SortexchangebogoRange, v : Double) -> SortexchangebogoRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_exchange_bogo_range_min(s : SortexchangebogoRange) -> Double { @_common.min(s.data) }

pub fn sort_exchange_bogo_range_max(s : SortexchangebogoRange) -> Double { @_common.max(s.data) }

pub fn sort_exchange_bogo_range_to_string(s : SortexchangebogoRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortexchangebogoSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_exchange_bogo_slice_make(size : Int) -> SortexchangebogoSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_exchange_bogo_slice_len(s : SortexchangebogoSlice) -> Int { s.size }

pub fn sort_exchange_bogo_slice_get(s : SortexchangebogoSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_exchange_bogo_slice_set(s : SortexchangebogoSlice, i : Int, v : Double) -> SortexchangebogoSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_exchange_bogo_slice_sum(s : SortexchangebogoSlice) -> Double { @_common.sum(s.data) }

pub fn sort_exchange_bogo_slice_mean(s : SortexchangebogoSlice) -> Double { @_common.mean(s.data) }

pub fn sort_exchange_bogo_slice_scale(s : SortexchangebogoSlice, f : Double) -> SortexchangebogoSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_exchange_bogo_slice_add(a : SortexchangebogoSlice, b : SortexchangebogoSlice) -> SortexchangebogoSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_exchange_bogo_slice_copy(s : SortexchangebogoSlice) -> SortexchangebogoSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_exchange_bogo_slice_fill(s : SortexchangebogoSlice, v : Double) -> SortexchangebogoSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_exchange_bogo_slice_min(s : SortexchangebogoSlice) -> Double { @_common.min(s.data) }

pub fn sort_exchange_bogo_slice_max(s : SortexchangebogoSlice) -> Double { @_common.max(s.data) }

pub fn sort_exchange_bogo_slice_to_string(s : SortexchangebogoSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

