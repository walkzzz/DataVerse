///===
/// extcore/signal_filter_median

pub(all) struct SignalfiltermedianPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn signal_filter_median_make_point(x : Double, y : Double) -> SignalfiltermedianPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn signal_filter_median_make_point3(x : Double, y : Double, z : Double) -> SignalfiltermedianPoint {
  { x, y, z, label: 0 }
}

pub fn SignalfiltermedianPoint::x(self : SignalfiltermedianPoint) -> Double { self.x }

pub fn SignalfiltermedianPoint::y(self : SignalfiltermedianPoint) -> Double { self.y }

pub fn SignalfiltermedianPoint::z(self : SignalfiltermedianPoint) -> Double { self.z }

pub fn SignalfiltermedianPoint::label(self : SignalfiltermedianPoint) -> Int { self.label }

pub fn SignalfiltermedianPoint::dist(self : SignalfiltermedianPoint, other : SignalfiltermedianPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn SignalfiltermedianPoint::add(self : SignalfiltermedianPoint, other : SignalfiltermedianPoint) -> SignalfiltermedianPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn SignalfiltermedianPoint::sub(self : SignalfiltermedianPoint, other : SignalfiltermedianPoint) -> SignalfiltermedianPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn SignalfiltermedianPoint::scale(self : SignalfiltermedianPoint, s : Double) -> SignalfiltermedianPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn SignalfiltermedianPoint::dot(self : SignalfiltermedianPoint, other : SignalfiltermedianPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn SignalfiltermedianPoint::cross(self : SignalfiltermedianPoint, other : SignalfiltermedianPoint) -> SignalfiltermedianPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn SignalfiltermedianPoint::norm(self : SignalfiltermedianPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn SignalfiltermedianPoint::normalize(self : SignalfiltermedianPoint) -> SignalfiltermedianPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn SignalfiltermedianPoint::negate(self : SignalfiltermedianPoint) -> SignalfiltermedianPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn SignalfiltermedianPoint::mid(self : SignalfiltermedianPoint, other : SignalfiltermedianPoint) -> SignalfiltermedianPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn SignalfiltermedianPoint::lerp(self : SignalfiltermedianPoint, other : SignalfiltermedianPoint, t : Double) -> SignalfiltermedianPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn SignalfiltermedianPoint::to_string(self : SignalfiltermedianPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct SignalfiltermedianSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn signal_filter_median_make_series(vals : Array[Double], name : String) -> SignalfiltermedianSeries {
  { vals, name, meta: 0 }
}

pub fn SignalfiltermedianSeries::len(self : SignalfiltermedianSeries) -> Int { self.vals.length() }

pub fn SignalfiltermedianSeries::sum(self : SignalfiltermedianSeries) -> Double { @_common.sum(self.vals) }

pub fn SignalfiltermedianSeries::mean(self : SignalfiltermedianSeries) -> Double { @_common.mean(self.vals) }

pub fn SignalfiltermedianSeries::min(self : SignalfiltermedianSeries) -> Double { @_common.min(self.vals) }

pub fn SignalfiltermedianSeries::max(self : SignalfiltermedianSeries) -> Double { @_common.max(self.vals) }

pub fn SignalfiltermedianSeries::range(self : SignalfiltermedianSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn SignalfiltermedianSeries::variance(self : SignalfiltermedianSeries) -> Double { @_common.variance(self.vals) }

pub fn SignalfiltermedianSeries::std(self : SignalfiltermedianSeries) -> Double { @_common.std(self.vals) }

pub fn SignalfiltermedianSeries::median(self : SignalfiltermedianSeries) -> Double { @_common.median(self.vals) }

pub fn SignalfiltermedianSeries::scale(self : SignalfiltermedianSeries, f : Double) -> SignalfiltermedianSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn SignalfiltermedianSeries::add(self : SignalfiltermedianSeries, other : SignalfiltermedianSeries) -> SignalfiltermedianSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn SignalfiltermedianSeries::sub(self : SignalfiltermedianSeries, other : SignalfiltermedianSeries) -> SignalfiltermedianSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn SignalfiltermedianSeries::normalize(self : SignalfiltermedianSeries) -> SignalfiltermedianSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn SignalfiltermedianSeries::cumsum(self : SignalfiltermedianSeries) -> SignalfiltermedianSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn SignalfiltermedianSeries::to_string(self : SignalfiltermedianSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct SignalfiltermedianMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn signal_filter_median_make_matrix(rows : Int, cols : Int, val : Double) -> SignalfiltermedianMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn signal_filter_median_matrix_identity(n : Int) -> SignalfiltermedianMatrix {
  let m = signal_filter_median_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn SignalfiltermedianMatrix::get(self : SignalfiltermedianMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn SignalfiltermedianMatrix::transpose(self : SignalfiltermedianMatrix) -> SignalfiltermedianMatrix {
  let result = signal_filter_median_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn SignalfiltermedianMatrix::add(self : SignalfiltermedianMatrix, other : SignalfiltermedianMatrix) -> SignalfiltermedianMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = signal_filter_median_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn SignalfiltermedianMatrix::scale(self : SignalfiltermedianMatrix, s : Double) -> SignalfiltermedianMatrix {
  let result = signal_filter_median_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn SignalfiltermedianMatrix::multiply(self : SignalfiltermedianMatrix, other : SignalfiltermedianMatrix) -> SignalfiltermedianMatrix {
  if self.cols != other.rows { return signal_filter_median_make_matrix(self.rows, other.cols, 0.0) }
  let result = signal_filter_median_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn SignalfiltermedianMatrix::trace(self : SignalfiltermedianMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn SignalfiltermedianMatrix::det(self : SignalfiltermedianMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn SignalfiltermedianMatrix::norm(self : SignalfiltermedianMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn SignalfiltermedianMatrix::to_string(self : SignalfiltermedianMatrix) -> String {
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

pub(all) struct SignalfiltermedianVector {
  comps : Array[Double]
  dim : Int
}

pub fn signal_filter_median_make_vector(comps : Array[Double]) -> SignalfiltermedianVector {
  { comps, dim: comps.length() }
}

pub fn signal_filter_median_vector_zero(dim : Int) -> SignalfiltermedianVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn SignalfiltermedianVector::add(self : SignalfiltermedianVector, other : SignalfiltermedianVector) -> SignalfiltermedianVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn SignalfiltermedianVector::sub(self : SignalfiltermedianVector, other : SignalfiltermedianVector) -> SignalfiltermedianVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn SignalfiltermedianVector::scale(self : SignalfiltermedianVector, s : Double) -> SignalfiltermedianVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn SignalfiltermedianVector::dot(self : SignalfiltermedianVector, other : SignalfiltermedianVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn SignalfiltermedianVector::norm(self : SignalfiltermedianVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn SignalfiltermedianVector::normalize(self : SignalfiltermedianVector) -> SignalfiltermedianVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn SignalfiltermedianVector::dist(self : SignalfiltermedianVector, other : SignalfiltermedianVector) -> Double {
  self.sub(other).norm()
}

pub fn SignalfiltermedianVector::to_string(self : SignalfiltermedianVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn signal_filter_median_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn signal_filter_median_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn signal_filter_median_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn signal_filter_median_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn signal_filter_median_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn signal_filter_median_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn signal_filter_median_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn signal_filter_median_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn signal_filter_median_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn signal_filter_median_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn signal_filter_median_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn signal_filter_median_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn signal_filter_median_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn signal_filter_median_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn signal_filter_median_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn signal_filter_median_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn signal_filter_median_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn signal_filter_median_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn signal_filter_median_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn signal_filter_median_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn signal_filter_median_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn signal_filter_median_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn signal_filter_median_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn signal_filter_median_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn signal_filter_median_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn signal_filter_median_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn signal_filter_median_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn signal_filter_median_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn signal_filter_median_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct SignalfiltermedianFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_filter_median_frame_make(size : Int) -> SignalfiltermedianFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_filter_median_frame_len(s : SignalfiltermedianFrame) -> Int { s.size }

pub fn signal_filter_median_frame_get(s : SignalfiltermedianFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_filter_median_frame_set(s : SignalfiltermedianFrame, i : Int, v : Double) -> SignalfiltermedianFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_filter_median_frame_sum(s : SignalfiltermedianFrame) -> Double { @_common.sum(s.data) }

pub fn signal_filter_median_frame_mean(s : SignalfiltermedianFrame) -> Double { @_common.mean(s.data) }

pub fn signal_filter_median_frame_scale(s : SignalfiltermedianFrame, f : Double) -> SignalfiltermedianFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_filter_median_frame_add(a : SignalfiltermedianFrame, b : SignalfiltermedianFrame) -> SignalfiltermedianFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_filter_median_frame_copy(s : SignalfiltermedianFrame) -> SignalfiltermedianFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_filter_median_frame_fill(s : SignalfiltermedianFrame, v : Double) -> SignalfiltermedianFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_filter_median_frame_min(s : SignalfiltermedianFrame) -> Double { @_common.min(s.data) }

pub fn signal_filter_median_frame_max(s : SignalfiltermedianFrame) -> Double { @_common.max(s.data) }

pub fn signal_filter_median_frame_to_string(s : SignalfiltermedianFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalfiltermedianTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_filter_median_table_make(size : Int) -> SignalfiltermedianTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_filter_median_table_len(s : SignalfiltermedianTable) -> Int { s.size }

pub fn signal_filter_median_table_get(s : SignalfiltermedianTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_filter_median_table_set(s : SignalfiltermedianTable, i : Int, v : Double) -> SignalfiltermedianTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_filter_median_table_sum(s : SignalfiltermedianTable) -> Double { @_common.sum(s.data) }

pub fn signal_filter_median_table_mean(s : SignalfiltermedianTable) -> Double { @_common.mean(s.data) }

pub fn signal_filter_median_table_scale(s : SignalfiltermedianTable, f : Double) -> SignalfiltermedianTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_filter_median_table_add(a : SignalfiltermedianTable, b : SignalfiltermedianTable) -> SignalfiltermedianTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_filter_median_table_copy(s : SignalfiltermedianTable) -> SignalfiltermedianTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_filter_median_table_fill(s : SignalfiltermedianTable, v : Double) -> SignalfiltermedianTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_filter_median_table_min(s : SignalfiltermedianTable) -> Double { @_common.min(s.data) }

pub fn signal_filter_median_table_max(s : SignalfiltermedianTable) -> Double { @_common.max(s.data) }

pub fn signal_filter_median_table_to_string(s : SignalfiltermedianTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalfiltermedianGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_filter_median_graphn_make(size : Int) -> SignalfiltermedianGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_filter_median_graphn_len(s : SignalfiltermedianGraphN) -> Int { s.size }

pub fn signal_filter_median_graphn_get(s : SignalfiltermedianGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_filter_median_graphn_set(s : SignalfiltermedianGraphN, i : Int, v : Double) -> SignalfiltermedianGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_filter_median_graphn_sum(s : SignalfiltermedianGraphN) -> Double { @_common.sum(s.data) }

pub fn signal_filter_median_graphn_mean(s : SignalfiltermedianGraphN) -> Double { @_common.mean(s.data) }

pub fn signal_filter_median_graphn_scale(s : SignalfiltermedianGraphN, f : Double) -> SignalfiltermedianGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_filter_median_graphn_add(a : SignalfiltermedianGraphN, b : SignalfiltermedianGraphN) -> SignalfiltermedianGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_filter_median_graphn_copy(s : SignalfiltermedianGraphN) -> SignalfiltermedianGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_filter_median_graphn_fill(s : SignalfiltermedianGraphN, v : Double) -> SignalfiltermedianGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_filter_median_graphn_min(s : SignalfiltermedianGraphN) -> Double { @_common.min(s.data) }

pub fn signal_filter_median_graphn_max(s : SignalfiltermedianGraphN) -> Double { @_common.max(s.data) }

pub fn signal_filter_median_graphn_to_string(s : SignalfiltermedianGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalfiltermedianNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_filter_median_node_make(size : Int) -> SignalfiltermedianNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_filter_median_node_len(s : SignalfiltermedianNode) -> Int { s.size }

pub fn signal_filter_median_node_get(s : SignalfiltermedianNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_filter_median_node_set(s : SignalfiltermedianNode, i : Int, v : Double) -> SignalfiltermedianNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_filter_median_node_sum(s : SignalfiltermedianNode) -> Double { @_common.sum(s.data) }

pub fn signal_filter_median_node_mean(s : SignalfiltermedianNode) -> Double { @_common.mean(s.data) }

pub fn signal_filter_median_node_scale(s : SignalfiltermedianNode, f : Double) -> SignalfiltermedianNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_filter_median_node_add(a : SignalfiltermedianNode, b : SignalfiltermedianNode) -> SignalfiltermedianNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_filter_median_node_copy(s : SignalfiltermedianNode) -> SignalfiltermedianNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_filter_median_node_fill(s : SignalfiltermedianNode, v : Double) -> SignalfiltermedianNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_filter_median_node_min(s : SignalfiltermedianNode) -> Double { @_common.min(s.data) }

pub fn signal_filter_median_node_max(s : SignalfiltermedianNode) -> Double { @_common.max(s.data) }

pub fn signal_filter_median_node_to_string(s : SignalfiltermedianNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalfiltermedianEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_filter_median_edge_make(size : Int) -> SignalfiltermedianEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_filter_median_edge_len(s : SignalfiltermedianEdge) -> Int { s.size }

pub fn signal_filter_median_edge_get(s : SignalfiltermedianEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_filter_median_edge_set(s : SignalfiltermedianEdge, i : Int, v : Double) -> SignalfiltermedianEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_filter_median_edge_sum(s : SignalfiltermedianEdge) -> Double { @_common.sum(s.data) }

pub fn signal_filter_median_edge_mean(s : SignalfiltermedianEdge) -> Double { @_common.mean(s.data) }

pub fn signal_filter_median_edge_scale(s : SignalfiltermedianEdge, f : Double) -> SignalfiltermedianEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_filter_median_edge_add(a : SignalfiltermedianEdge, b : SignalfiltermedianEdge) -> SignalfiltermedianEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_filter_median_edge_copy(s : SignalfiltermedianEdge) -> SignalfiltermedianEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_filter_median_edge_fill(s : SignalfiltermedianEdge, v : Double) -> SignalfiltermedianEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_filter_median_edge_min(s : SignalfiltermedianEdge) -> Double { @_common.min(s.data) }

pub fn signal_filter_median_edge_max(s : SignalfiltermedianEdge) -> Double { @_common.max(s.data) }

pub fn signal_filter_median_edge_to_string(s : SignalfiltermedianEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalfiltermedianPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_filter_median_path_make(size : Int) -> SignalfiltermedianPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_filter_median_path_len(s : SignalfiltermedianPath) -> Int { s.size }

pub fn signal_filter_median_path_get(s : SignalfiltermedianPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_filter_median_path_set(s : SignalfiltermedianPath, i : Int, v : Double) -> SignalfiltermedianPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_filter_median_path_sum(s : SignalfiltermedianPath) -> Double { @_common.sum(s.data) }

pub fn signal_filter_median_path_mean(s : SignalfiltermedianPath) -> Double { @_common.mean(s.data) }

pub fn signal_filter_median_path_scale(s : SignalfiltermedianPath, f : Double) -> SignalfiltermedianPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_filter_median_path_add(a : SignalfiltermedianPath, b : SignalfiltermedianPath) -> SignalfiltermedianPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_filter_median_path_copy(s : SignalfiltermedianPath) -> SignalfiltermedianPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_filter_median_path_fill(s : SignalfiltermedianPath, v : Double) -> SignalfiltermedianPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_filter_median_path_min(s : SignalfiltermedianPath) -> Double { @_common.min(s.data) }

pub fn signal_filter_median_path_max(s : SignalfiltermedianPath) -> Double { @_common.max(s.data) }

pub fn signal_filter_median_path_to_string(s : SignalfiltermedianPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalfiltermedianCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_filter_median_cluster_make(size : Int) -> SignalfiltermedianCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_filter_median_cluster_len(s : SignalfiltermedianCluster) -> Int { s.size }

pub fn signal_filter_median_cluster_get(s : SignalfiltermedianCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_filter_median_cluster_set(s : SignalfiltermedianCluster, i : Int, v : Double) -> SignalfiltermedianCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_filter_median_cluster_sum(s : SignalfiltermedianCluster) -> Double { @_common.sum(s.data) }

pub fn signal_filter_median_cluster_mean(s : SignalfiltermedianCluster) -> Double { @_common.mean(s.data) }

pub fn signal_filter_median_cluster_scale(s : SignalfiltermedianCluster, f : Double) -> SignalfiltermedianCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_filter_median_cluster_add(a : SignalfiltermedianCluster, b : SignalfiltermedianCluster) -> SignalfiltermedianCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_filter_median_cluster_copy(s : SignalfiltermedianCluster) -> SignalfiltermedianCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_filter_median_cluster_fill(s : SignalfiltermedianCluster, v : Double) -> SignalfiltermedianCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_filter_median_cluster_min(s : SignalfiltermedianCluster) -> Double { @_common.min(s.data) }

pub fn signal_filter_median_cluster_max(s : SignalfiltermedianCluster) -> Double { @_common.max(s.data) }

pub fn signal_filter_median_cluster_to_string(s : SignalfiltermedianCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalfiltermedianModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_filter_median_model_make(size : Int) -> SignalfiltermedianModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_filter_median_model_len(s : SignalfiltermedianModel) -> Int { s.size }

pub fn signal_filter_median_model_get(s : SignalfiltermedianModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_filter_median_model_set(s : SignalfiltermedianModel, i : Int, v : Double) -> SignalfiltermedianModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_filter_median_model_sum(s : SignalfiltermedianModel) -> Double { @_common.sum(s.data) }

pub fn signal_filter_median_model_mean(s : SignalfiltermedianModel) -> Double { @_common.mean(s.data) }

pub fn signal_filter_median_model_scale(s : SignalfiltermedianModel, f : Double) -> SignalfiltermedianModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_filter_median_model_add(a : SignalfiltermedianModel, b : SignalfiltermedianModel) -> SignalfiltermedianModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_filter_median_model_copy(s : SignalfiltermedianModel) -> SignalfiltermedianModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_filter_median_model_fill(s : SignalfiltermedianModel, v : Double) -> SignalfiltermedianModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_filter_median_model_min(s : SignalfiltermedianModel) -> Double { @_common.min(s.data) }

pub fn signal_filter_median_model_max(s : SignalfiltermedianModel) -> Double { @_common.max(s.data) }

pub fn signal_filter_median_model_to_string(s : SignalfiltermedianModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalfiltermedianLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_filter_median_layer_make(size : Int) -> SignalfiltermedianLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_filter_median_layer_len(s : SignalfiltermedianLayer) -> Int { s.size }

pub fn signal_filter_median_layer_get(s : SignalfiltermedianLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_filter_median_layer_set(s : SignalfiltermedianLayer, i : Int, v : Double) -> SignalfiltermedianLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_filter_median_layer_sum(s : SignalfiltermedianLayer) -> Double { @_common.sum(s.data) }

pub fn signal_filter_median_layer_mean(s : SignalfiltermedianLayer) -> Double { @_common.mean(s.data) }

pub fn signal_filter_median_layer_scale(s : SignalfiltermedianLayer, f : Double) -> SignalfiltermedianLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_filter_median_layer_add(a : SignalfiltermedianLayer, b : SignalfiltermedianLayer) -> SignalfiltermedianLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_filter_median_layer_copy(s : SignalfiltermedianLayer) -> SignalfiltermedianLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_filter_median_layer_fill(s : SignalfiltermedianLayer, v : Double) -> SignalfiltermedianLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_filter_median_layer_min(s : SignalfiltermedianLayer) -> Double { @_common.min(s.data) }

pub fn signal_filter_median_layer_max(s : SignalfiltermedianLayer) -> Double { @_common.max(s.data) }

pub fn signal_filter_median_layer_to_string(s : SignalfiltermedianLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalfiltermedianBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_filter_median_buffer_make(size : Int) -> SignalfiltermedianBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_filter_median_buffer_len(s : SignalfiltermedianBuffer) -> Int { s.size }

pub fn signal_filter_median_buffer_get(s : SignalfiltermedianBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_filter_median_buffer_set(s : SignalfiltermedianBuffer, i : Int, v : Double) -> SignalfiltermedianBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_filter_median_buffer_sum(s : SignalfiltermedianBuffer) -> Double { @_common.sum(s.data) }

pub fn signal_filter_median_buffer_mean(s : SignalfiltermedianBuffer) -> Double { @_common.mean(s.data) }

pub fn signal_filter_median_buffer_scale(s : SignalfiltermedianBuffer, f : Double) -> SignalfiltermedianBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_filter_median_buffer_add(a : SignalfiltermedianBuffer, b : SignalfiltermedianBuffer) -> SignalfiltermedianBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_filter_median_buffer_copy(s : SignalfiltermedianBuffer) -> SignalfiltermedianBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_filter_median_buffer_fill(s : SignalfiltermedianBuffer, v : Double) -> SignalfiltermedianBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_filter_median_buffer_min(s : SignalfiltermedianBuffer) -> Double { @_common.min(s.data) }

pub fn signal_filter_median_buffer_max(s : SignalfiltermedianBuffer) -> Double { @_common.max(s.data) }

pub fn signal_filter_median_buffer_to_string(s : SignalfiltermedianBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalfiltermedianCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_filter_median_cursor_make(size : Int) -> SignalfiltermedianCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_filter_median_cursor_len(s : SignalfiltermedianCursor) -> Int { s.size }

pub fn signal_filter_median_cursor_get(s : SignalfiltermedianCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_filter_median_cursor_set(s : SignalfiltermedianCursor, i : Int, v : Double) -> SignalfiltermedianCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_filter_median_cursor_sum(s : SignalfiltermedianCursor) -> Double { @_common.sum(s.data) }

pub fn signal_filter_median_cursor_mean(s : SignalfiltermedianCursor) -> Double { @_common.mean(s.data) }

pub fn signal_filter_median_cursor_scale(s : SignalfiltermedianCursor, f : Double) -> SignalfiltermedianCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_filter_median_cursor_add(a : SignalfiltermedianCursor, b : SignalfiltermedianCursor) -> SignalfiltermedianCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_filter_median_cursor_copy(s : SignalfiltermedianCursor) -> SignalfiltermedianCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_filter_median_cursor_fill(s : SignalfiltermedianCursor, v : Double) -> SignalfiltermedianCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_filter_median_cursor_min(s : SignalfiltermedianCursor) -> Double { @_common.min(s.data) }

pub fn signal_filter_median_cursor_max(s : SignalfiltermedianCursor) -> Double { @_common.max(s.data) }

pub fn signal_filter_median_cursor_to_string(s : SignalfiltermedianCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalfiltermedianView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_filter_median_view_make(size : Int) -> SignalfiltermedianView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_filter_median_view_len(s : SignalfiltermedianView) -> Int { s.size }

pub fn signal_filter_median_view_get(s : SignalfiltermedianView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_filter_median_view_set(s : SignalfiltermedianView, i : Int, v : Double) -> SignalfiltermedianView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_filter_median_view_sum(s : SignalfiltermedianView) -> Double { @_common.sum(s.data) }

pub fn signal_filter_median_view_mean(s : SignalfiltermedianView) -> Double { @_common.mean(s.data) }

pub fn signal_filter_median_view_scale(s : SignalfiltermedianView, f : Double) -> SignalfiltermedianView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_filter_median_view_add(a : SignalfiltermedianView, b : SignalfiltermedianView) -> SignalfiltermedianView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_filter_median_view_copy(s : SignalfiltermedianView) -> SignalfiltermedianView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_filter_median_view_fill(s : SignalfiltermedianView, v : Double) -> SignalfiltermedianView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_filter_median_view_min(s : SignalfiltermedianView) -> Double { @_common.min(s.data) }

pub fn signal_filter_median_view_max(s : SignalfiltermedianView) -> Double { @_common.max(s.data) }

pub fn signal_filter_median_view_to_string(s : SignalfiltermedianView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalfiltermedianRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_filter_median_range_make(size : Int) -> SignalfiltermedianRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_filter_median_range_len(s : SignalfiltermedianRange) -> Int { s.size }

pub fn signal_filter_median_range_get(s : SignalfiltermedianRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_filter_median_range_set(s : SignalfiltermedianRange, i : Int, v : Double) -> SignalfiltermedianRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_filter_median_range_sum(s : SignalfiltermedianRange) -> Double { @_common.sum(s.data) }

pub fn signal_filter_median_range_mean(s : SignalfiltermedianRange) -> Double { @_common.mean(s.data) }

pub fn signal_filter_median_range_scale(s : SignalfiltermedianRange, f : Double) -> SignalfiltermedianRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_filter_median_range_add(a : SignalfiltermedianRange, b : SignalfiltermedianRange) -> SignalfiltermedianRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_filter_median_range_copy(s : SignalfiltermedianRange) -> SignalfiltermedianRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_filter_median_range_fill(s : SignalfiltermedianRange, v : Double) -> SignalfiltermedianRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_filter_median_range_min(s : SignalfiltermedianRange) -> Double { @_common.min(s.data) }

pub fn signal_filter_median_range_max(s : SignalfiltermedianRange) -> Double { @_common.max(s.data) }

pub fn signal_filter_median_range_to_string(s : SignalfiltermedianRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalfiltermedianSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_filter_median_slice_make(size : Int) -> SignalfiltermedianSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_filter_median_slice_len(s : SignalfiltermedianSlice) -> Int { s.size }

pub fn signal_filter_median_slice_get(s : SignalfiltermedianSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_filter_median_slice_set(s : SignalfiltermedianSlice, i : Int, v : Double) -> SignalfiltermedianSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_filter_median_slice_sum(s : SignalfiltermedianSlice) -> Double { @_common.sum(s.data) }

pub fn signal_filter_median_slice_mean(s : SignalfiltermedianSlice) -> Double { @_common.mean(s.data) }

pub fn signal_filter_median_slice_scale(s : SignalfiltermedianSlice, f : Double) -> SignalfiltermedianSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_filter_median_slice_add(a : SignalfiltermedianSlice, b : SignalfiltermedianSlice) -> SignalfiltermedianSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_filter_median_slice_copy(s : SignalfiltermedianSlice) -> SignalfiltermedianSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_filter_median_slice_fill(s : SignalfiltermedianSlice, v : Double) -> SignalfiltermedianSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_filter_median_slice_min(s : SignalfiltermedianSlice) -> Double { @_common.min(s.data) }

pub fn signal_filter_median_slice_max(s : SignalfiltermedianSlice) -> Double { @_common.max(s.data) }

pub fn signal_filter_median_slice_to_string(s : SignalfiltermedianSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

