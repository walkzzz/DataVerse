///===
/// extcore/sort_exchange_gnome

pub(all) struct SortexchangegnomePoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn sort_exchange_gnome_make_point(x : Double, y : Double) -> SortexchangegnomePoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn sort_exchange_gnome_make_point3(x : Double, y : Double, z : Double) -> SortexchangegnomePoint {
  { x, y, z, label: 0 }
}

pub fn SortexchangegnomePoint::x(self : SortexchangegnomePoint) -> Double { self.x }

pub fn SortexchangegnomePoint::y(self : SortexchangegnomePoint) -> Double { self.y }

pub fn SortexchangegnomePoint::z(self : SortexchangegnomePoint) -> Double { self.z }

pub fn SortexchangegnomePoint::label(self : SortexchangegnomePoint) -> Int { self.label }

pub fn SortexchangegnomePoint::dist(self : SortexchangegnomePoint, other : SortexchangegnomePoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn SortexchangegnomePoint::add(self : SortexchangegnomePoint, other : SortexchangegnomePoint) -> SortexchangegnomePoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn SortexchangegnomePoint::sub(self : SortexchangegnomePoint, other : SortexchangegnomePoint) -> SortexchangegnomePoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn SortexchangegnomePoint::scale(self : SortexchangegnomePoint, s : Double) -> SortexchangegnomePoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn SortexchangegnomePoint::dot(self : SortexchangegnomePoint, other : SortexchangegnomePoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn SortexchangegnomePoint::cross(self : SortexchangegnomePoint, other : SortexchangegnomePoint) -> SortexchangegnomePoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn SortexchangegnomePoint::norm(self : SortexchangegnomePoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn SortexchangegnomePoint::normalize(self : SortexchangegnomePoint) -> SortexchangegnomePoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn SortexchangegnomePoint::negate(self : SortexchangegnomePoint) -> SortexchangegnomePoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn SortexchangegnomePoint::mid(self : SortexchangegnomePoint, other : SortexchangegnomePoint) -> SortexchangegnomePoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn SortexchangegnomePoint::lerp(self : SortexchangegnomePoint, other : SortexchangegnomePoint, t : Double) -> SortexchangegnomePoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn SortexchangegnomePoint::to_string(self : SortexchangegnomePoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct SortexchangegnomeSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn sort_exchange_gnome_make_series(vals : Array[Double], name : String) -> SortexchangegnomeSeries {
  { vals, name, meta: 0 }
}

pub fn SortexchangegnomeSeries::len(self : SortexchangegnomeSeries) -> Int { self.vals.length() }

pub fn SortexchangegnomeSeries::sum(self : SortexchangegnomeSeries) -> Double { @_common.sum(self.vals) }

pub fn SortexchangegnomeSeries::mean(self : SortexchangegnomeSeries) -> Double { @_common.mean(self.vals) }

pub fn SortexchangegnomeSeries::min(self : SortexchangegnomeSeries) -> Double { @_common.min(self.vals) }

pub fn SortexchangegnomeSeries::max(self : SortexchangegnomeSeries) -> Double { @_common.max(self.vals) }

pub fn SortexchangegnomeSeries::range(self : SortexchangegnomeSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn SortexchangegnomeSeries::variance(self : SortexchangegnomeSeries) -> Double { @_common.variance(self.vals) }

pub fn SortexchangegnomeSeries::std(self : SortexchangegnomeSeries) -> Double { @_common.std(self.vals) }

pub fn SortexchangegnomeSeries::median(self : SortexchangegnomeSeries) -> Double { @_common.median(self.vals) }

pub fn SortexchangegnomeSeries::scale(self : SortexchangegnomeSeries, f : Double) -> SortexchangegnomeSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn SortexchangegnomeSeries::add(self : SortexchangegnomeSeries, other : SortexchangegnomeSeries) -> SortexchangegnomeSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn SortexchangegnomeSeries::sub(self : SortexchangegnomeSeries, other : SortexchangegnomeSeries) -> SortexchangegnomeSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn SortexchangegnomeSeries::normalize(self : SortexchangegnomeSeries) -> SortexchangegnomeSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn SortexchangegnomeSeries::cumsum(self : SortexchangegnomeSeries) -> SortexchangegnomeSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn SortexchangegnomeSeries::to_string(self : SortexchangegnomeSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct SortexchangegnomeMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn sort_exchange_gnome_make_matrix(rows : Int, cols : Int, val : Double) -> SortexchangegnomeMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn sort_exchange_gnome_matrix_identity(n : Int) -> SortexchangegnomeMatrix {
  let m = sort_exchange_gnome_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn SortexchangegnomeMatrix::get(self : SortexchangegnomeMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn SortexchangegnomeMatrix::transpose(self : SortexchangegnomeMatrix) -> SortexchangegnomeMatrix {
  let result = sort_exchange_gnome_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn SortexchangegnomeMatrix::add(self : SortexchangegnomeMatrix, other : SortexchangegnomeMatrix) -> SortexchangegnomeMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = sort_exchange_gnome_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn SortexchangegnomeMatrix::scale(self : SortexchangegnomeMatrix, s : Double) -> SortexchangegnomeMatrix {
  let result = sort_exchange_gnome_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn SortexchangegnomeMatrix::multiply(self : SortexchangegnomeMatrix, other : SortexchangegnomeMatrix) -> SortexchangegnomeMatrix {
  if self.cols != other.rows { return sort_exchange_gnome_make_matrix(self.rows, other.cols, 0.0) }
  let result = sort_exchange_gnome_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn SortexchangegnomeMatrix::trace(self : SortexchangegnomeMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn SortexchangegnomeMatrix::det(self : SortexchangegnomeMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn SortexchangegnomeMatrix::norm(self : SortexchangegnomeMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn SortexchangegnomeMatrix::to_string(self : SortexchangegnomeMatrix) -> String {
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

pub(all) struct SortexchangegnomeVector {
  comps : Array[Double]
  dim : Int
}

pub fn sort_exchange_gnome_make_vector(comps : Array[Double]) -> SortexchangegnomeVector {
  { comps, dim: comps.length() }
}

pub fn sort_exchange_gnome_vector_zero(dim : Int) -> SortexchangegnomeVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn SortexchangegnomeVector::add(self : SortexchangegnomeVector, other : SortexchangegnomeVector) -> SortexchangegnomeVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn SortexchangegnomeVector::sub(self : SortexchangegnomeVector, other : SortexchangegnomeVector) -> SortexchangegnomeVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn SortexchangegnomeVector::scale(self : SortexchangegnomeVector, s : Double) -> SortexchangegnomeVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn SortexchangegnomeVector::dot(self : SortexchangegnomeVector, other : SortexchangegnomeVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn SortexchangegnomeVector::norm(self : SortexchangegnomeVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn SortexchangegnomeVector::normalize(self : SortexchangegnomeVector) -> SortexchangegnomeVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn SortexchangegnomeVector::dist(self : SortexchangegnomeVector, other : SortexchangegnomeVector) -> Double {
  self.sub(other).norm()
}

pub fn SortexchangegnomeVector::to_string(self : SortexchangegnomeVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn sort_exchange_gnome_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn sort_exchange_gnome_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn sort_exchange_gnome_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn sort_exchange_gnome_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn sort_exchange_gnome_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn sort_exchange_gnome_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn sort_exchange_gnome_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn sort_exchange_gnome_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn sort_exchange_gnome_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn sort_exchange_gnome_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn sort_exchange_gnome_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn sort_exchange_gnome_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn sort_exchange_gnome_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn sort_exchange_gnome_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn sort_exchange_gnome_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn sort_exchange_gnome_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn sort_exchange_gnome_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn sort_exchange_gnome_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn sort_exchange_gnome_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn sort_exchange_gnome_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn sort_exchange_gnome_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn sort_exchange_gnome_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn sort_exchange_gnome_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn sort_exchange_gnome_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn sort_exchange_gnome_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn sort_exchange_gnome_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn sort_exchange_gnome_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn sort_exchange_gnome_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn sort_exchange_gnome_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct SortexchangegnomeFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_exchange_gnome_frame_make(size : Int) -> SortexchangegnomeFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_exchange_gnome_frame_len(s : SortexchangegnomeFrame) -> Int { s.size }

pub fn sort_exchange_gnome_frame_get(s : SortexchangegnomeFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_exchange_gnome_frame_set(s : SortexchangegnomeFrame, i : Int, v : Double) -> SortexchangegnomeFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_exchange_gnome_frame_sum(s : SortexchangegnomeFrame) -> Double { @_common.sum(s.data) }

pub fn sort_exchange_gnome_frame_mean(s : SortexchangegnomeFrame) -> Double { @_common.mean(s.data) }

pub fn sort_exchange_gnome_frame_scale(s : SortexchangegnomeFrame, f : Double) -> SortexchangegnomeFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_exchange_gnome_frame_add(a : SortexchangegnomeFrame, b : SortexchangegnomeFrame) -> SortexchangegnomeFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_exchange_gnome_frame_copy(s : SortexchangegnomeFrame) -> SortexchangegnomeFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_exchange_gnome_frame_fill(s : SortexchangegnomeFrame, v : Double) -> SortexchangegnomeFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_exchange_gnome_frame_min(s : SortexchangegnomeFrame) -> Double { @_common.min(s.data) }

pub fn sort_exchange_gnome_frame_max(s : SortexchangegnomeFrame) -> Double { @_common.max(s.data) }

pub fn sort_exchange_gnome_frame_to_string(s : SortexchangegnomeFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortexchangegnomeTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_exchange_gnome_table_make(size : Int) -> SortexchangegnomeTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_exchange_gnome_table_len(s : SortexchangegnomeTable) -> Int { s.size }

pub fn sort_exchange_gnome_table_get(s : SortexchangegnomeTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_exchange_gnome_table_set(s : SortexchangegnomeTable, i : Int, v : Double) -> SortexchangegnomeTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_exchange_gnome_table_sum(s : SortexchangegnomeTable) -> Double { @_common.sum(s.data) }

pub fn sort_exchange_gnome_table_mean(s : SortexchangegnomeTable) -> Double { @_common.mean(s.data) }

pub fn sort_exchange_gnome_table_scale(s : SortexchangegnomeTable, f : Double) -> SortexchangegnomeTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_exchange_gnome_table_add(a : SortexchangegnomeTable, b : SortexchangegnomeTable) -> SortexchangegnomeTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_exchange_gnome_table_copy(s : SortexchangegnomeTable) -> SortexchangegnomeTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_exchange_gnome_table_fill(s : SortexchangegnomeTable, v : Double) -> SortexchangegnomeTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_exchange_gnome_table_min(s : SortexchangegnomeTable) -> Double { @_common.min(s.data) }

pub fn sort_exchange_gnome_table_max(s : SortexchangegnomeTable) -> Double { @_common.max(s.data) }

pub fn sort_exchange_gnome_table_to_string(s : SortexchangegnomeTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortexchangegnomeGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_exchange_gnome_graphn_make(size : Int) -> SortexchangegnomeGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_exchange_gnome_graphn_len(s : SortexchangegnomeGraphN) -> Int { s.size }

pub fn sort_exchange_gnome_graphn_get(s : SortexchangegnomeGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_exchange_gnome_graphn_set(s : SortexchangegnomeGraphN, i : Int, v : Double) -> SortexchangegnomeGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_exchange_gnome_graphn_sum(s : SortexchangegnomeGraphN) -> Double { @_common.sum(s.data) }

pub fn sort_exchange_gnome_graphn_mean(s : SortexchangegnomeGraphN) -> Double { @_common.mean(s.data) }

pub fn sort_exchange_gnome_graphn_scale(s : SortexchangegnomeGraphN, f : Double) -> SortexchangegnomeGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_exchange_gnome_graphn_add(a : SortexchangegnomeGraphN, b : SortexchangegnomeGraphN) -> SortexchangegnomeGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_exchange_gnome_graphn_copy(s : SortexchangegnomeGraphN) -> SortexchangegnomeGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_exchange_gnome_graphn_fill(s : SortexchangegnomeGraphN, v : Double) -> SortexchangegnomeGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_exchange_gnome_graphn_min(s : SortexchangegnomeGraphN) -> Double { @_common.min(s.data) }

pub fn sort_exchange_gnome_graphn_max(s : SortexchangegnomeGraphN) -> Double { @_common.max(s.data) }

pub fn sort_exchange_gnome_graphn_to_string(s : SortexchangegnomeGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortexchangegnomeNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_exchange_gnome_node_make(size : Int) -> SortexchangegnomeNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_exchange_gnome_node_len(s : SortexchangegnomeNode) -> Int { s.size }

pub fn sort_exchange_gnome_node_get(s : SortexchangegnomeNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_exchange_gnome_node_set(s : SortexchangegnomeNode, i : Int, v : Double) -> SortexchangegnomeNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_exchange_gnome_node_sum(s : SortexchangegnomeNode) -> Double { @_common.sum(s.data) }

pub fn sort_exchange_gnome_node_mean(s : SortexchangegnomeNode) -> Double { @_common.mean(s.data) }

pub fn sort_exchange_gnome_node_scale(s : SortexchangegnomeNode, f : Double) -> SortexchangegnomeNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_exchange_gnome_node_add(a : SortexchangegnomeNode, b : SortexchangegnomeNode) -> SortexchangegnomeNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_exchange_gnome_node_copy(s : SortexchangegnomeNode) -> SortexchangegnomeNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_exchange_gnome_node_fill(s : SortexchangegnomeNode, v : Double) -> SortexchangegnomeNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_exchange_gnome_node_min(s : SortexchangegnomeNode) -> Double { @_common.min(s.data) }

pub fn sort_exchange_gnome_node_max(s : SortexchangegnomeNode) -> Double { @_common.max(s.data) }

pub fn sort_exchange_gnome_node_to_string(s : SortexchangegnomeNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortexchangegnomeEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_exchange_gnome_edge_make(size : Int) -> SortexchangegnomeEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_exchange_gnome_edge_len(s : SortexchangegnomeEdge) -> Int { s.size }

pub fn sort_exchange_gnome_edge_get(s : SortexchangegnomeEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_exchange_gnome_edge_set(s : SortexchangegnomeEdge, i : Int, v : Double) -> SortexchangegnomeEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_exchange_gnome_edge_sum(s : SortexchangegnomeEdge) -> Double { @_common.sum(s.data) }

pub fn sort_exchange_gnome_edge_mean(s : SortexchangegnomeEdge) -> Double { @_common.mean(s.data) }

pub fn sort_exchange_gnome_edge_scale(s : SortexchangegnomeEdge, f : Double) -> SortexchangegnomeEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_exchange_gnome_edge_add(a : SortexchangegnomeEdge, b : SortexchangegnomeEdge) -> SortexchangegnomeEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_exchange_gnome_edge_copy(s : SortexchangegnomeEdge) -> SortexchangegnomeEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_exchange_gnome_edge_fill(s : SortexchangegnomeEdge, v : Double) -> SortexchangegnomeEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_exchange_gnome_edge_min(s : SortexchangegnomeEdge) -> Double { @_common.min(s.data) }

pub fn sort_exchange_gnome_edge_max(s : SortexchangegnomeEdge) -> Double { @_common.max(s.data) }

pub fn sort_exchange_gnome_edge_to_string(s : SortexchangegnomeEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortexchangegnomePath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_exchange_gnome_path_make(size : Int) -> SortexchangegnomePath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_exchange_gnome_path_len(s : SortexchangegnomePath) -> Int { s.size }

pub fn sort_exchange_gnome_path_get(s : SortexchangegnomePath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_exchange_gnome_path_set(s : SortexchangegnomePath, i : Int, v : Double) -> SortexchangegnomePath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_exchange_gnome_path_sum(s : SortexchangegnomePath) -> Double { @_common.sum(s.data) }

pub fn sort_exchange_gnome_path_mean(s : SortexchangegnomePath) -> Double { @_common.mean(s.data) }

pub fn sort_exchange_gnome_path_scale(s : SortexchangegnomePath, f : Double) -> SortexchangegnomePath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_exchange_gnome_path_add(a : SortexchangegnomePath, b : SortexchangegnomePath) -> SortexchangegnomePath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_exchange_gnome_path_copy(s : SortexchangegnomePath) -> SortexchangegnomePath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_exchange_gnome_path_fill(s : SortexchangegnomePath, v : Double) -> SortexchangegnomePath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_exchange_gnome_path_min(s : SortexchangegnomePath) -> Double { @_common.min(s.data) }

pub fn sort_exchange_gnome_path_max(s : SortexchangegnomePath) -> Double { @_common.max(s.data) }

pub fn sort_exchange_gnome_path_to_string(s : SortexchangegnomePath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortexchangegnomeCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_exchange_gnome_cluster_make(size : Int) -> SortexchangegnomeCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_exchange_gnome_cluster_len(s : SortexchangegnomeCluster) -> Int { s.size }

pub fn sort_exchange_gnome_cluster_get(s : SortexchangegnomeCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_exchange_gnome_cluster_set(s : SortexchangegnomeCluster, i : Int, v : Double) -> SortexchangegnomeCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_exchange_gnome_cluster_sum(s : SortexchangegnomeCluster) -> Double { @_common.sum(s.data) }

pub fn sort_exchange_gnome_cluster_mean(s : SortexchangegnomeCluster) -> Double { @_common.mean(s.data) }

pub fn sort_exchange_gnome_cluster_scale(s : SortexchangegnomeCluster, f : Double) -> SortexchangegnomeCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_exchange_gnome_cluster_add(a : SortexchangegnomeCluster, b : SortexchangegnomeCluster) -> SortexchangegnomeCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_exchange_gnome_cluster_copy(s : SortexchangegnomeCluster) -> SortexchangegnomeCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_exchange_gnome_cluster_fill(s : SortexchangegnomeCluster, v : Double) -> SortexchangegnomeCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_exchange_gnome_cluster_min(s : SortexchangegnomeCluster) -> Double { @_common.min(s.data) }

pub fn sort_exchange_gnome_cluster_max(s : SortexchangegnomeCluster) -> Double { @_common.max(s.data) }

pub fn sort_exchange_gnome_cluster_to_string(s : SortexchangegnomeCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortexchangegnomeModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_exchange_gnome_model_make(size : Int) -> SortexchangegnomeModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_exchange_gnome_model_len(s : SortexchangegnomeModel) -> Int { s.size }

pub fn sort_exchange_gnome_model_get(s : SortexchangegnomeModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_exchange_gnome_model_set(s : SortexchangegnomeModel, i : Int, v : Double) -> SortexchangegnomeModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_exchange_gnome_model_sum(s : SortexchangegnomeModel) -> Double { @_common.sum(s.data) }

pub fn sort_exchange_gnome_model_mean(s : SortexchangegnomeModel) -> Double { @_common.mean(s.data) }

pub fn sort_exchange_gnome_model_scale(s : SortexchangegnomeModel, f : Double) -> SortexchangegnomeModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_exchange_gnome_model_add(a : SortexchangegnomeModel, b : SortexchangegnomeModel) -> SortexchangegnomeModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_exchange_gnome_model_copy(s : SortexchangegnomeModel) -> SortexchangegnomeModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_exchange_gnome_model_fill(s : SortexchangegnomeModel, v : Double) -> SortexchangegnomeModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_exchange_gnome_model_min(s : SortexchangegnomeModel) -> Double { @_common.min(s.data) }

pub fn sort_exchange_gnome_model_max(s : SortexchangegnomeModel) -> Double { @_common.max(s.data) }

pub fn sort_exchange_gnome_model_to_string(s : SortexchangegnomeModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortexchangegnomeLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_exchange_gnome_layer_make(size : Int) -> SortexchangegnomeLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_exchange_gnome_layer_len(s : SortexchangegnomeLayer) -> Int { s.size }

pub fn sort_exchange_gnome_layer_get(s : SortexchangegnomeLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_exchange_gnome_layer_set(s : SortexchangegnomeLayer, i : Int, v : Double) -> SortexchangegnomeLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_exchange_gnome_layer_sum(s : SortexchangegnomeLayer) -> Double { @_common.sum(s.data) }

pub fn sort_exchange_gnome_layer_mean(s : SortexchangegnomeLayer) -> Double { @_common.mean(s.data) }

pub fn sort_exchange_gnome_layer_scale(s : SortexchangegnomeLayer, f : Double) -> SortexchangegnomeLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_exchange_gnome_layer_add(a : SortexchangegnomeLayer, b : SortexchangegnomeLayer) -> SortexchangegnomeLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_exchange_gnome_layer_copy(s : SortexchangegnomeLayer) -> SortexchangegnomeLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_exchange_gnome_layer_fill(s : SortexchangegnomeLayer, v : Double) -> SortexchangegnomeLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_exchange_gnome_layer_min(s : SortexchangegnomeLayer) -> Double { @_common.min(s.data) }

pub fn sort_exchange_gnome_layer_max(s : SortexchangegnomeLayer) -> Double { @_common.max(s.data) }

pub fn sort_exchange_gnome_layer_to_string(s : SortexchangegnomeLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortexchangegnomeBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_exchange_gnome_buffer_make(size : Int) -> SortexchangegnomeBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_exchange_gnome_buffer_len(s : SortexchangegnomeBuffer) -> Int { s.size }

pub fn sort_exchange_gnome_buffer_get(s : SortexchangegnomeBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_exchange_gnome_buffer_set(s : SortexchangegnomeBuffer, i : Int, v : Double) -> SortexchangegnomeBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_exchange_gnome_buffer_sum(s : SortexchangegnomeBuffer) -> Double { @_common.sum(s.data) }

pub fn sort_exchange_gnome_buffer_mean(s : SortexchangegnomeBuffer) -> Double { @_common.mean(s.data) }

pub fn sort_exchange_gnome_buffer_scale(s : SortexchangegnomeBuffer, f : Double) -> SortexchangegnomeBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_exchange_gnome_buffer_add(a : SortexchangegnomeBuffer, b : SortexchangegnomeBuffer) -> SortexchangegnomeBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_exchange_gnome_buffer_copy(s : SortexchangegnomeBuffer) -> SortexchangegnomeBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_exchange_gnome_buffer_fill(s : SortexchangegnomeBuffer, v : Double) -> SortexchangegnomeBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_exchange_gnome_buffer_min(s : SortexchangegnomeBuffer) -> Double { @_common.min(s.data) }

pub fn sort_exchange_gnome_buffer_max(s : SortexchangegnomeBuffer) -> Double { @_common.max(s.data) }

pub fn sort_exchange_gnome_buffer_to_string(s : SortexchangegnomeBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortexchangegnomeCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_exchange_gnome_cursor_make(size : Int) -> SortexchangegnomeCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_exchange_gnome_cursor_len(s : SortexchangegnomeCursor) -> Int { s.size }

pub fn sort_exchange_gnome_cursor_get(s : SortexchangegnomeCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_exchange_gnome_cursor_set(s : SortexchangegnomeCursor, i : Int, v : Double) -> SortexchangegnomeCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_exchange_gnome_cursor_sum(s : SortexchangegnomeCursor) -> Double { @_common.sum(s.data) }

pub fn sort_exchange_gnome_cursor_mean(s : SortexchangegnomeCursor) -> Double { @_common.mean(s.data) }

pub fn sort_exchange_gnome_cursor_scale(s : SortexchangegnomeCursor, f : Double) -> SortexchangegnomeCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_exchange_gnome_cursor_add(a : SortexchangegnomeCursor, b : SortexchangegnomeCursor) -> SortexchangegnomeCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_exchange_gnome_cursor_copy(s : SortexchangegnomeCursor) -> SortexchangegnomeCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_exchange_gnome_cursor_fill(s : SortexchangegnomeCursor, v : Double) -> SortexchangegnomeCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_exchange_gnome_cursor_min(s : SortexchangegnomeCursor) -> Double { @_common.min(s.data) }

pub fn sort_exchange_gnome_cursor_max(s : SortexchangegnomeCursor) -> Double { @_common.max(s.data) }

pub fn sort_exchange_gnome_cursor_to_string(s : SortexchangegnomeCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortexchangegnomeView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_exchange_gnome_view_make(size : Int) -> SortexchangegnomeView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_exchange_gnome_view_len(s : SortexchangegnomeView) -> Int { s.size }

pub fn sort_exchange_gnome_view_get(s : SortexchangegnomeView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_exchange_gnome_view_set(s : SortexchangegnomeView, i : Int, v : Double) -> SortexchangegnomeView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_exchange_gnome_view_sum(s : SortexchangegnomeView) -> Double { @_common.sum(s.data) }

pub fn sort_exchange_gnome_view_mean(s : SortexchangegnomeView) -> Double { @_common.mean(s.data) }

pub fn sort_exchange_gnome_view_scale(s : SortexchangegnomeView, f : Double) -> SortexchangegnomeView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_exchange_gnome_view_add(a : SortexchangegnomeView, b : SortexchangegnomeView) -> SortexchangegnomeView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_exchange_gnome_view_copy(s : SortexchangegnomeView) -> SortexchangegnomeView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_exchange_gnome_view_fill(s : SortexchangegnomeView, v : Double) -> SortexchangegnomeView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_exchange_gnome_view_min(s : SortexchangegnomeView) -> Double { @_common.min(s.data) }

pub fn sort_exchange_gnome_view_max(s : SortexchangegnomeView) -> Double { @_common.max(s.data) }

pub fn sort_exchange_gnome_view_to_string(s : SortexchangegnomeView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortexchangegnomeRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_exchange_gnome_range_make(size : Int) -> SortexchangegnomeRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_exchange_gnome_range_len(s : SortexchangegnomeRange) -> Int { s.size }

pub fn sort_exchange_gnome_range_get(s : SortexchangegnomeRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_exchange_gnome_range_set(s : SortexchangegnomeRange, i : Int, v : Double) -> SortexchangegnomeRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_exchange_gnome_range_sum(s : SortexchangegnomeRange) -> Double { @_common.sum(s.data) }

pub fn sort_exchange_gnome_range_mean(s : SortexchangegnomeRange) -> Double { @_common.mean(s.data) }

pub fn sort_exchange_gnome_range_scale(s : SortexchangegnomeRange, f : Double) -> SortexchangegnomeRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_exchange_gnome_range_add(a : SortexchangegnomeRange, b : SortexchangegnomeRange) -> SortexchangegnomeRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_exchange_gnome_range_copy(s : SortexchangegnomeRange) -> SortexchangegnomeRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_exchange_gnome_range_fill(s : SortexchangegnomeRange, v : Double) -> SortexchangegnomeRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_exchange_gnome_range_min(s : SortexchangegnomeRange) -> Double { @_common.min(s.data) }

pub fn sort_exchange_gnome_range_max(s : SortexchangegnomeRange) -> Double { @_common.max(s.data) }

pub fn sort_exchange_gnome_range_to_string(s : SortexchangegnomeRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortexchangegnomeSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_exchange_gnome_slice_make(size : Int) -> SortexchangegnomeSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_exchange_gnome_slice_len(s : SortexchangegnomeSlice) -> Int { s.size }

pub fn sort_exchange_gnome_slice_get(s : SortexchangegnomeSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_exchange_gnome_slice_set(s : SortexchangegnomeSlice, i : Int, v : Double) -> SortexchangegnomeSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_exchange_gnome_slice_sum(s : SortexchangegnomeSlice) -> Double { @_common.sum(s.data) }

pub fn sort_exchange_gnome_slice_mean(s : SortexchangegnomeSlice) -> Double { @_common.mean(s.data) }

pub fn sort_exchange_gnome_slice_scale(s : SortexchangegnomeSlice, f : Double) -> SortexchangegnomeSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_exchange_gnome_slice_add(a : SortexchangegnomeSlice, b : SortexchangegnomeSlice) -> SortexchangegnomeSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_exchange_gnome_slice_copy(s : SortexchangegnomeSlice) -> SortexchangegnomeSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_exchange_gnome_slice_fill(s : SortexchangegnomeSlice, v : Double) -> SortexchangegnomeSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_exchange_gnome_slice_min(s : SortexchangegnomeSlice) -> Double { @_common.min(s.data) }

pub fn sort_exchange_gnome_slice_max(s : SortexchangegnomeSlice) -> Double { @_common.max(s.data) }

pub fn sort_exchange_gnome_slice_to_string(s : SortexchangegnomeSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

