///===
/// extcore/signal_filter_iir

pub(all) struct SignalfilteriirPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn signal_filter_iir_make_point(x : Double, y : Double) -> SignalfilteriirPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn signal_filter_iir_make_point3(x : Double, y : Double, z : Double) -> SignalfilteriirPoint {
  { x, y, z, label: 0 }
}

pub fn SignalfilteriirPoint::x(self : SignalfilteriirPoint) -> Double { self.x }

pub fn SignalfilteriirPoint::y(self : SignalfilteriirPoint) -> Double { self.y }

pub fn SignalfilteriirPoint::z(self : SignalfilteriirPoint) -> Double { self.z }

pub fn SignalfilteriirPoint::label(self : SignalfilteriirPoint) -> Int { self.label }

pub fn SignalfilteriirPoint::dist(self : SignalfilteriirPoint, other : SignalfilteriirPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn SignalfilteriirPoint::add(self : SignalfilteriirPoint, other : SignalfilteriirPoint) -> SignalfilteriirPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn SignalfilteriirPoint::sub(self : SignalfilteriirPoint, other : SignalfilteriirPoint) -> SignalfilteriirPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn SignalfilteriirPoint::scale(self : SignalfilteriirPoint, s : Double) -> SignalfilteriirPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn SignalfilteriirPoint::dot(self : SignalfilteriirPoint, other : SignalfilteriirPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn SignalfilteriirPoint::cross(self : SignalfilteriirPoint, other : SignalfilteriirPoint) -> SignalfilteriirPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn SignalfilteriirPoint::norm(self : SignalfilteriirPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn SignalfilteriirPoint::normalize(self : SignalfilteriirPoint) -> SignalfilteriirPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn SignalfilteriirPoint::negate(self : SignalfilteriirPoint) -> SignalfilteriirPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn SignalfilteriirPoint::mid(self : SignalfilteriirPoint, other : SignalfilteriirPoint) -> SignalfilteriirPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn SignalfilteriirPoint::lerp(self : SignalfilteriirPoint, other : SignalfilteriirPoint, t : Double) -> SignalfilteriirPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn SignalfilteriirPoint::to_string(self : SignalfilteriirPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct SignalfilteriirSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn signal_filter_iir_make_series(vals : Array[Double], name : String) -> SignalfilteriirSeries {
  { vals, name, meta: 0 }
}

pub fn SignalfilteriirSeries::len(self : SignalfilteriirSeries) -> Int { self.vals.length() }

pub fn SignalfilteriirSeries::sum(self : SignalfilteriirSeries) -> Double { @_common.sum(self.vals) }

pub fn SignalfilteriirSeries::mean(self : SignalfilteriirSeries) -> Double { @_common.mean(self.vals) }

pub fn SignalfilteriirSeries::min(self : SignalfilteriirSeries) -> Double { @_common.min(self.vals) }

pub fn SignalfilteriirSeries::max(self : SignalfilteriirSeries) -> Double { @_common.max(self.vals) }

pub fn SignalfilteriirSeries::range(self : SignalfilteriirSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn SignalfilteriirSeries::variance(self : SignalfilteriirSeries) -> Double { @_common.variance(self.vals) }

pub fn SignalfilteriirSeries::std(self : SignalfilteriirSeries) -> Double { @_common.std(self.vals) }

pub fn SignalfilteriirSeries::median(self : SignalfilteriirSeries) -> Double { @_common.median(self.vals) }

pub fn SignalfilteriirSeries::scale(self : SignalfilteriirSeries, f : Double) -> SignalfilteriirSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn SignalfilteriirSeries::add(self : SignalfilteriirSeries, other : SignalfilteriirSeries) -> SignalfilteriirSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn SignalfilteriirSeries::sub(self : SignalfilteriirSeries, other : SignalfilteriirSeries) -> SignalfilteriirSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn SignalfilteriirSeries::normalize(self : SignalfilteriirSeries) -> SignalfilteriirSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn SignalfilteriirSeries::cumsum(self : SignalfilteriirSeries) -> SignalfilteriirSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn SignalfilteriirSeries::to_string(self : SignalfilteriirSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct SignalfilteriirMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn signal_filter_iir_make_matrix(rows : Int, cols : Int, val : Double) -> SignalfilteriirMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn signal_filter_iir_matrix_identity(n : Int) -> SignalfilteriirMatrix {
  let m = signal_filter_iir_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn SignalfilteriirMatrix::get(self : SignalfilteriirMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn SignalfilteriirMatrix::transpose(self : SignalfilteriirMatrix) -> SignalfilteriirMatrix {
  let result = signal_filter_iir_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn SignalfilteriirMatrix::add(self : SignalfilteriirMatrix, other : SignalfilteriirMatrix) -> SignalfilteriirMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = signal_filter_iir_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn SignalfilteriirMatrix::scale(self : SignalfilteriirMatrix, s : Double) -> SignalfilteriirMatrix {
  let result = signal_filter_iir_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn SignalfilteriirMatrix::multiply(self : SignalfilteriirMatrix, other : SignalfilteriirMatrix) -> SignalfilteriirMatrix {
  if self.cols != other.rows { return signal_filter_iir_make_matrix(self.rows, other.cols, 0.0) }
  let result = signal_filter_iir_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn SignalfilteriirMatrix::trace(self : SignalfilteriirMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn SignalfilteriirMatrix::det(self : SignalfilteriirMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn SignalfilteriirMatrix::norm(self : SignalfilteriirMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn SignalfilteriirMatrix::to_string(self : SignalfilteriirMatrix) -> String {
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

pub(all) struct SignalfilteriirVector {
  comps : Array[Double]
  dim : Int
}

pub fn signal_filter_iir_make_vector(comps : Array[Double]) -> SignalfilteriirVector {
  { comps, dim: comps.length() }
}

pub fn signal_filter_iir_vector_zero(dim : Int) -> SignalfilteriirVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn SignalfilteriirVector::add(self : SignalfilteriirVector, other : SignalfilteriirVector) -> SignalfilteriirVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn SignalfilteriirVector::sub(self : SignalfilteriirVector, other : SignalfilteriirVector) -> SignalfilteriirVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn SignalfilteriirVector::scale(self : SignalfilteriirVector, s : Double) -> SignalfilteriirVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn SignalfilteriirVector::dot(self : SignalfilteriirVector, other : SignalfilteriirVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn SignalfilteriirVector::norm(self : SignalfilteriirVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn SignalfilteriirVector::normalize(self : SignalfilteriirVector) -> SignalfilteriirVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn SignalfilteriirVector::dist(self : SignalfilteriirVector, other : SignalfilteriirVector) -> Double {
  self.sub(other).norm()
}

pub fn SignalfilteriirVector::to_string(self : SignalfilteriirVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn signal_filter_iir_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn signal_filter_iir_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn signal_filter_iir_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn signal_filter_iir_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn signal_filter_iir_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn signal_filter_iir_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn signal_filter_iir_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn signal_filter_iir_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn signal_filter_iir_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn signal_filter_iir_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn signal_filter_iir_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn signal_filter_iir_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn signal_filter_iir_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn signal_filter_iir_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn signal_filter_iir_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn signal_filter_iir_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn signal_filter_iir_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn signal_filter_iir_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn signal_filter_iir_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn signal_filter_iir_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn signal_filter_iir_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn signal_filter_iir_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn signal_filter_iir_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn signal_filter_iir_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn signal_filter_iir_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn signal_filter_iir_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn signal_filter_iir_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn signal_filter_iir_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn signal_filter_iir_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct SignalfilteriirFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_filter_iir_frame_make(size : Int) -> SignalfilteriirFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_filter_iir_frame_len(s : SignalfilteriirFrame) -> Int { s.size }

pub fn signal_filter_iir_frame_get(s : SignalfilteriirFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_filter_iir_frame_set(s : SignalfilteriirFrame, i : Int, v : Double) -> SignalfilteriirFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_filter_iir_frame_sum(s : SignalfilteriirFrame) -> Double { @_common.sum(s.data) }

pub fn signal_filter_iir_frame_mean(s : SignalfilteriirFrame) -> Double { @_common.mean(s.data) }

pub fn signal_filter_iir_frame_scale(s : SignalfilteriirFrame, f : Double) -> SignalfilteriirFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_filter_iir_frame_add(a : SignalfilteriirFrame, b : SignalfilteriirFrame) -> SignalfilteriirFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_filter_iir_frame_copy(s : SignalfilteriirFrame) -> SignalfilteriirFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_filter_iir_frame_fill(s : SignalfilteriirFrame, v : Double) -> SignalfilteriirFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_filter_iir_frame_min(s : SignalfilteriirFrame) -> Double { @_common.min(s.data) }

pub fn signal_filter_iir_frame_max(s : SignalfilteriirFrame) -> Double { @_common.max(s.data) }

pub fn signal_filter_iir_frame_to_string(s : SignalfilteriirFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalfilteriirTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_filter_iir_table_make(size : Int) -> SignalfilteriirTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_filter_iir_table_len(s : SignalfilteriirTable) -> Int { s.size }

pub fn signal_filter_iir_table_get(s : SignalfilteriirTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_filter_iir_table_set(s : SignalfilteriirTable, i : Int, v : Double) -> SignalfilteriirTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_filter_iir_table_sum(s : SignalfilteriirTable) -> Double { @_common.sum(s.data) }

pub fn signal_filter_iir_table_mean(s : SignalfilteriirTable) -> Double { @_common.mean(s.data) }

pub fn signal_filter_iir_table_scale(s : SignalfilteriirTable, f : Double) -> SignalfilteriirTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_filter_iir_table_add(a : SignalfilteriirTable, b : SignalfilteriirTable) -> SignalfilteriirTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_filter_iir_table_copy(s : SignalfilteriirTable) -> SignalfilteriirTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_filter_iir_table_fill(s : SignalfilteriirTable, v : Double) -> SignalfilteriirTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_filter_iir_table_min(s : SignalfilteriirTable) -> Double { @_common.min(s.data) }

pub fn signal_filter_iir_table_max(s : SignalfilteriirTable) -> Double { @_common.max(s.data) }

pub fn signal_filter_iir_table_to_string(s : SignalfilteriirTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalfilteriirGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_filter_iir_graphn_make(size : Int) -> SignalfilteriirGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_filter_iir_graphn_len(s : SignalfilteriirGraphN) -> Int { s.size }

pub fn signal_filter_iir_graphn_get(s : SignalfilteriirGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_filter_iir_graphn_set(s : SignalfilteriirGraphN, i : Int, v : Double) -> SignalfilteriirGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_filter_iir_graphn_sum(s : SignalfilteriirGraphN) -> Double { @_common.sum(s.data) }

pub fn signal_filter_iir_graphn_mean(s : SignalfilteriirGraphN) -> Double { @_common.mean(s.data) }

pub fn signal_filter_iir_graphn_scale(s : SignalfilteriirGraphN, f : Double) -> SignalfilteriirGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_filter_iir_graphn_add(a : SignalfilteriirGraphN, b : SignalfilteriirGraphN) -> SignalfilteriirGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_filter_iir_graphn_copy(s : SignalfilteriirGraphN) -> SignalfilteriirGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_filter_iir_graphn_fill(s : SignalfilteriirGraphN, v : Double) -> SignalfilteriirGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_filter_iir_graphn_min(s : SignalfilteriirGraphN) -> Double { @_common.min(s.data) }

pub fn signal_filter_iir_graphn_max(s : SignalfilteriirGraphN) -> Double { @_common.max(s.data) }

pub fn signal_filter_iir_graphn_to_string(s : SignalfilteriirGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalfilteriirNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_filter_iir_node_make(size : Int) -> SignalfilteriirNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_filter_iir_node_len(s : SignalfilteriirNode) -> Int { s.size }

pub fn signal_filter_iir_node_get(s : SignalfilteriirNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_filter_iir_node_set(s : SignalfilteriirNode, i : Int, v : Double) -> SignalfilteriirNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_filter_iir_node_sum(s : SignalfilteriirNode) -> Double { @_common.sum(s.data) }

pub fn signal_filter_iir_node_mean(s : SignalfilteriirNode) -> Double { @_common.mean(s.data) }

pub fn signal_filter_iir_node_scale(s : SignalfilteriirNode, f : Double) -> SignalfilteriirNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_filter_iir_node_add(a : SignalfilteriirNode, b : SignalfilteriirNode) -> SignalfilteriirNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_filter_iir_node_copy(s : SignalfilteriirNode) -> SignalfilteriirNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_filter_iir_node_fill(s : SignalfilteriirNode, v : Double) -> SignalfilteriirNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_filter_iir_node_min(s : SignalfilteriirNode) -> Double { @_common.min(s.data) }

pub fn signal_filter_iir_node_max(s : SignalfilteriirNode) -> Double { @_common.max(s.data) }

pub fn signal_filter_iir_node_to_string(s : SignalfilteriirNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalfilteriirEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_filter_iir_edge_make(size : Int) -> SignalfilteriirEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_filter_iir_edge_len(s : SignalfilteriirEdge) -> Int { s.size }

pub fn signal_filter_iir_edge_get(s : SignalfilteriirEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_filter_iir_edge_set(s : SignalfilteriirEdge, i : Int, v : Double) -> SignalfilteriirEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_filter_iir_edge_sum(s : SignalfilteriirEdge) -> Double { @_common.sum(s.data) }

pub fn signal_filter_iir_edge_mean(s : SignalfilteriirEdge) -> Double { @_common.mean(s.data) }

pub fn signal_filter_iir_edge_scale(s : SignalfilteriirEdge, f : Double) -> SignalfilteriirEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_filter_iir_edge_add(a : SignalfilteriirEdge, b : SignalfilteriirEdge) -> SignalfilteriirEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_filter_iir_edge_copy(s : SignalfilteriirEdge) -> SignalfilteriirEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_filter_iir_edge_fill(s : SignalfilteriirEdge, v : Double) -> SignalfilteriirEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_filter_iir_edge_min(s : SignalfilteriirEdge) -> Double { @_common.min(s.data) }

pub fn signal_filter_iir_edge_max(s : SignalfilteriirEdge) -> Double { @_common.max(s.data) }

pub fn signal_filter_iir_edge_to_string(s : SignalfilteriirEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalfilteriirPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_filter_iir_path_make(size : Int) -> SignalfilteriirPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_filter_iir_path_len(s : SignalfilteriirPath) -> Int { s.size }

pub fn signal_filter_iir_path_get(s : SignalfilteriirPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_filter_iir_path_set(s : SignalfilteriirPath, i : Int, v : Double) -> SignalfilteriirPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_filter_iir_path_sum(s : SignalfilteriirPath) -> Double { @_common.sum(s.data) }

pub fn signal_filter_iir_path_mean(s : SignalfilteriirPath) -> Double { @_common.mean(s.data) }

pub fn signal_filter_iir_path_scale(s : SignalfilteriirPath, f : Double) -> SignalfilteriirPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_filter_iir_path_add(a : SignalfilteriirPath, b : SignalfilteriirPath) -> SignalfilteriirPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_filter_iir_path_copy(s : SignalfilteriirPath) -> SignalfilteriirPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_filter_iir_path_fill(s : SignalfilteriirPath, v : Double) -> SignalfilteriirPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_filter_iir_path_min(s : SignalfilteriirPath) -> Double { @_common.min(s.data) }

pub fn signal_filter_iir_path_max(s : SignalfilteriirPath) -> Double { @_common.max(s.data) }

pub fn signal_filter_iir_path_to_string(s : SignalfilteriirPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalfilteriirCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_filter_iir_cluster_make(size : Int) -> SignalfilteriirCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_filter_iir_cluster_len(s : SignalfilteriirCluster) -> Int { s.size }

pub fn signal_filter_iir_cluster_get(s : SignalfilteriirCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_filter_iir_cluster_set(s : SignalfilteriirCluster, i : Int, v : Double) -> SignalfilteriirCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_filter_iir_cluster_sum(s : SignalfilteriirCluster) -> Double { @_common.sum(s.data) }

pub fn signal_filter_iir_cluster_mean(s : SignalfilteriirCluster) -> Double { @_common.mean(s.data) }

pub fn signal_filter_iir_cluster_scale(s : SignalfilteriirCluster, f : Double) -> SignalfilteriirCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_filter_iir_cluster_add(a : SignalfilteriirCluster, b : SignalfilteriirCluster) -> SignalfilteriirCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_filter_iir_cluster_copy(s : SignalfilteriirCluster) -> SignalfilteriirCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_filter_iir_cluster_fill(s : SignalfilteriirCluster, v : Double) -> SignalfilteriirCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_filter_iir_cluster_min(s : SignalfilteriirCluster) -> Double { @_common.min(s.data) }

pub fn signal_filter_iir_cluster_max(s : SignalfilteriirCluster) -> Double { @_common.max(s.data) }

pub fn signal_filter_iir_cluster_to_string(s : SignalfilteriirCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalfilteriirModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_filter_iir_model_make(size : Int) -> SignalfilteriirModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_filter_iir_model_len(s : SignalfilteriirModel) -> Int { s.size }

pub fn signal_filter_iir_model_get(s : SignalfilteriirModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_filter_iir_model_set(s : SignalfilteriirModel, i : Int, v : Double) -> SignalfilteriirModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_filter_iir_model_sum(s : SignalfilteriirModel) -> Double { @_common.sum(s.data) }

pub fn signal_filter_iir_model_mean(s : SignalfilteriirModel) -> Double { @_common.mean(s.data) }

pub fn signal_filter_iir_model_scale(s : SignalfilteriirModel, f : Double) -> SignalfilteriirModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_filter_iir_model_add(a : SignalfilteriirModel, b : SignalfilteriirModel) -> SignalfilteriirModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_filter_iir_model_copy(s : SignalfilteriirModel) -> SignalfilteriirModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_filter_iir_model_fill(s : SignalfilteriirModel, v : Double) -> SignalfilteriirModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_filter_iir_model_min(s : SignalfilteriirModel) -> Double { @_common.min(s.data) }

pub fn signal_filter_iir_model_max(s : SignalfilteriirModel) -> Double { @_common.max(s.data) }

pub fn signal_filter_iir_model_to_string(s : SignalfilteriirModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalfilteriirLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_filter_iir_layer_make(size : Int) -> SignalfilteriirLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_filter_iir_layer_len(s : SignalfilteriirLayer) -> Int { s.size }

pub fn signal_filter_iir_layer_get(s : SignalfilteriirLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_filter_iir_layer_set(s : SignalfilteriirLayer, i : Int, v : Double) -> SignalfilteriirLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_filter_iir_layer_sum(s : SignalfilteriirLayer) -> Double { @_common.sum(s.data) }

pub fn signal_filter_iir_layer_mean(s : SignalfilteriirLayer) -> Double { @_common.mean(s.data) }

pub fn signal_filter_iir_layer_scale(s : SignalfilteriirLayer, f : Double) -> SignalfilteriirLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_filter_iir_layer_add(a : SignalfilteriirLayer, b : SignalfilteriirLayer) -> SignalfilteriirLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_filter_iir_layer_copy(s : SignalfilteriirLayer) -> SignalfilteriirLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_filter_iir_layer_fill(s : SignalfilteriirLayer, v : Double) -> SignalfilteriirLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_filter_iir_layer_min(s : SignalfilteriirLayer) -> Double { @_common.min(s.data) }

pub fn signal_filter_iir_layer_max(s : SignalfilteriirLayer) -> Double { @_common.max(s.data) }

pub fn signal_filter_iir_layer_to_string(s : SignalfilteriirLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalfilteriirBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_filter_iir_buffer_make(size : Int) -> SignalfilteriirBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_filter_iir_buffer_len(s : SignalfilteriirBuffer) -> Int { s.size }

pub fn signal_filter_iir_buffer_get(s : SignalfilteriirBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_filter_iir_buffer_set(s : SignalfilteriirBuffer, i : Int, v : Double) -> SignalfilteriirBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_filter_iir_buffer_sum(s : SignalfilteriirBuffer) -> Double { @_common.sum(s.data) }

pub fn signal_filter_iir_buffer_mean(s : SignalfilteriirBuffer) -> Double { @_common.mean(s.data) }

pub fn signal_filter_iir_buffer_scale(s : SignalfilteriirBuffer, f : Double) -> SignalfilteriirBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_filter_iir_buffer_add(a : SignalfilteriirBuffer, b : SignalfilteriirBuffer) -> SignalfilteriirBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_filter_iir_buffer_copy(s : SignalfilteriirBuffer) -> SignalfilteriirBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_filter_iir_buffer_fill(s : SignalfilteriirBuffer, v : Double) -> SignalfilteriirBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_filter_iir_buffer_min(s : SignalfilteriirBuffer) -> Double { @_common.min(s.data) }

pub fn signal_filter_iir_buffer_max(s : SignalfilteriirBuffer) -> Double { @_common.max(s.data) }

pub fn signal_filter_iir_buffer_to_string(s : SignalfilteriirBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalfilteriirCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_filter_iir_cursor_make(size : Int) -> SignalfilteriirCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_filter_iir_cursor_len(s : SignalfilteriirCursor) -> Int { s.size }

pub fn signal_filter_iir_cursor_get(s : SignalfilteriirCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_filter_iir_cursor_set(s : SignalfilteriirCursor, i : Int, v : Double) -> SignalfilteriirCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_filter_iir_cursor_sum(s : SignalfilteriirCursor) -> Double { @_common.sum(s.data) }

pub fn signal_filter_iir_cursor_mean(s : SignalfilteriirCursor) -> Double { @_common.mean(s.data) }

pub fn signal_filter_iir_cursor_scale(s : SignalfilteriirCursor, f : Double) -> SignalfilteriirCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_filter_iir_cursor_add(a : SignalfilteriirCursor, b : SignalfilteriirCursor) -> SignalfilteriirCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_filter_iir_cursor_copy(s : SignalfilteriirCursor) -> SignalfilteriirCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_filter_iir_cursor_fill(s : SignalfilteriirCursor, v : Double) -> SignalfilteriirCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_filter_iir_cursor_min(s : SignalfilteriirCursor) -> Double { @_common.min(s.data) }

pub fn signal_filter_iir_cursor_max(s : SignalfilteriirCursor) -> Double { @_common.max(s.data) }

pub fn signal_filter_iir_cursor_to_string(s : SignalfilteriirCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalfilteriirView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_filter_iir_view_make(size : Int) -> SignalfilteriirView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_filter_iir_view_len(s : SignalfilteriirView) -> Int { s.size }

pub fn signal_filter_iir_view_get(s : SignalfilteriirView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_filter_iir_view_set(s : SignalfilteriirView, i : Int, v : Double) -> SignalfilteriirView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_filter_iir_view_sum(s : SignalfilteriirView) -> Double { @_common.sum(s.data) }

pub fn signal_filter_iir_view_mean(s : SignalfilteriirView) -> Double { @_common.mean(s.data) }

pub fn signal_filter_iir_view_scale(s : SignalfilteriirView, f : Double) -> SignalfilteriirView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_filter_iir_view_add(a : SignalfilteriirView, b : SignalfilteriirView) -> SignalfilteriirView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_filter_iir_view_copy(s : SignalfilteriirView) -> SignalfilteriirView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_filter_iir_view_fill(s : SignalfilteriirView, v : Double) -> SignalfilteriirView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_filter_iir_view_min(s : SignalfilteriirView) -> Double { @_common.min(s.data) }

pub fn signal_filter_iir_view_max(s : SignalfilteriirView) -> Double { @_common.max(s.data) }

pub fn signal_filter_iir_view_to_string(s : SignalfilteriirView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalfilteriirRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_filter_iir_range_make(size : Int) -> SignalfilteriirRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_filter_iir_range_len(s : SignalfilteriirRange) -> Int { s.size }

pub fn signal_filter_iir_range_get(s : SignalfilteriirRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_filter_iir_range_set(s : SignalfilteriirRange, i : Int, v : Double) -> SignalfilteriirRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_filter_iir_range_sum(s : SignalfilteriirRange) -> Double { @_common.sum(s.data) }

pub fn signal_filter_iir_range_mean(s : SignalfilteriirRange) -> Double { @_common.mean(s.data) }

pub fn signal_filter_iir_range_scale(s : SignalfilteriirRange, f : Double) -> SignalfilteriirRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_filter_iir_range_add(a : SignalfilteriirRange, b : SignalfilteriirRange) -> SignalfilteriirRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_filter_iir_range_copy(s : SignalfilteriirRange) -> SignalfilteriirRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_filter_iir_range_fill(s : SignalfilteriirRange, v : Double) -> SignalfilteriirRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_filter_iir_range_min(s : SignalfilteriirRange) -> Double { @_common.min(s.data) }

pub fn signal_filter_iir_range_max(s : SignalfilteriirRange) -> Double { @_common.max(s.data) }

pub fn signal_filter_iir_range_to_string(s : SignalfilteriirRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalfilteriirSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_filter_iir_slice_make(size : Int) -> SignalfilteriirSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_filter_iir_slice_len(s : SignalfilteriirSlice) -> Int { s.size }

pub fn signal_filter_iir_slice_get(s : SignalfilteriirSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_filter_iir_slice_set(s : SignalfilteriirSlice, i : Int, v : Double) -> SignalfilteriirSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_filter_iir_slice_sum(s : SignalfilteriirSlice) -> Double { @_common.sum(s.data) }

pub fn signal_filter_iir_slice_mean(s : SignalfilteriirSlice) -> Double { @_common.mean(s.data) }

pub fn signal_filter_iir_slice_scale(s : SignalfilteriirSlice, f : Double) -> SignalfilteriirSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_filter_iir_slice_add(a : SignalfilteriirSlice, b : SignalfilteriirSlice) -> SignalfilteriirSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_filter_iir_slice_copy(s : SignalfilteriirSlice) -> SignalfilteriirSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_filter_iir_slice_fill(s : SignalfilteriirSlice, v : Double) -> SignalfilteriirSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_filter_iir_slice_min(s : SignalfilteriirSlice) -> Double { @_common.min(s.data) }

pub fn signal_filter_iir_slice_max(s : SignalfilteriirSlice) -> Double { @_common.max(s.data) }

pub fn signal_filter_iir_slice_to_string(s : SignalfilteriirSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

