///===
/// extcore/signal_filter_kalman

pub(all) struct SignalfilterkalmanPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn signal_filter_kalman_make_point(x : Double, y : Double) -> SignalfilterkalmanPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn signal_filter_kalman_make_point3(x : Double, y : Double, z : Double) -> SignalfilterkalmanPoint {
  { x, y, z, label: 0 }
}

pub fn SignalfilterkalmanPoint::x(self : SignalfilterkalmanPoint) -> Double { self.x }

pub fn SignalfilterkalmanPoint::y(self : SignalfilterkalmanPoint) -> Double { self.y }

pub fn SignalfilterkalmanPoint::z(self : SignalfilterkalmanPoint) -> Double { self.z }

pub fn SignalfilterkalmanPoint::label(self : SignalfilterkalmanPoint) -> Int { self.label }

pub fn SignalfilterkalmanPoint::dist(self : SignalfilterkalmanPoint, other : SignalfilterkalmanPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn SignalfilterkalmanPoint::add(self : SignalfilterkalmanPoint, other : SignalfilterkalmanPoint) -> SignalfilterkalmanPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn SignalfilterkalmanPoint::sub(self : SignalfilterkalmanPoint, other : SignalfilterkalmanPoint) -> SignalfilterkalmanPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn SignalfilterkalmanPoint::scale(self : SignalfilterkalmanPoint, s : Double) -> SignalfilterkalmanPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn SignalfilterkalmanPoint::dot(self : SignalfilterkalmanPoint, other : SignalfilterkalmanPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn SignalfilterkalmanPoint::cross(self : SignalfilterkalmanPoint, other : SignalfilterkalmanPoint) -> SignalfilterkalmanPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn SignalfilterkalmanPoint::norm(self : SignalfilterkalmanPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn SignalfilterkalmanPoint::normalize(self : SignalfilterkalmanPoint) -> SignalfilterkalmanPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn SignalfilterkalmanPoint::negate(self : SignalfilterkalmanPoint) -> SignalfilterkalmanPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn SignalfilterkalmanPoint::mid(self : SignalfilterkalmanPoint, other : SignalfilterkalmanPoint) -> SignalfilterkalmanPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn SignalfilterkalmanPoint::lerp(self : SignalfilterkalmanPoint, other : SignalfilterkalmanPoint, t : Double) -> SignalfilterkalmanPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn SignalfilterkalmanPoint::to_string(self : SignalfilterkalmanPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct SignalfilterkalmanSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn signal_filter_kalman_make_series(vals : Array[Double], name : String) -> SignalfilterkalmanSeries {
  { vals, name, meta: 0 }
}

pub fn SignalfilterkalmanSeries::len(self : SignalfilterkalmanSeries) -> Int { self.vals.length() }

pub fn SignalfilterkalmanSeries::sum(self : SignalfilterkalmanSeries) -> Double { @_common.sum(self.vals) }

pub fn SignalfilterkalmanSeries::mean(self : SignalfilterkalmanSeries) -> Double { @_common.mean(self.vals) }

pub fn SignalfilterkalmanSeries::min(self : SignalfilterkalmanSeries) -> Double { @_common.min(self.vals) }

pub fn SignalfilterkalmanSeries::max(self : SignalfilterkalmanSeries) -> Double { @_common.max(self.vals) }

pub fn SignalfilterkalmanSeries::range(self : SignalfilterkalmanSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn SignalfilterkalmanSeries::variance(self : SignalfilterkalmanSeries) -> Double { @_common.variance(self.vals) }

pub fn SignalfilterkalmanSeries::std(self : SignalfilterkalmanSeries) -> Double { @_common.std(self.vals) }

pub fn SignalfilterkalmanSeries::median(self : SignalfilterkalmanSeries) -> Double { @_common.median(self.vals) }

pub fn SignalfilterkalmanSeries::scale(self : SignalfilterkalmanSeries, f : Double) -> SignalfilterkalmanSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn SignalfilterkalmanSeries::add(self : SignalfilterkalmanSeries, other : SignalfilterkalmanSeries) -> SignalfilterkalmanSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn SignalfilterkalmanSeries::sub(self : SignalfilterkalmanSeries, other : SignalfilterkalmanSeries) -> SignalfilterkalmanSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn SignalfilterkalmanSeries::normalize(self : SignalfilterkalmanSeries) -> SignalfilterkalmanSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn SignalfilterkalmanSeries::cumsum(self : SignalfilterkalmanSeries) -> SignalfilterkalmanSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn SignalfilterkalmanSeries::to_string(self : SignalfilterkalmanSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct SignalfilterkalmanMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn signal_filter_kalman_make_matrix(rows : Int, cols : Int, val : Double) -> SignalfilterkalmanMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn signal_filter_kalman_matrix_identity(n : Int) -> SignalfilterkalmanMatrix {
  let m = signal_filter_kalman_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn SignalfilterkalmanMatrix::get(self : SignalfilterkalmanMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn SignalfilterkalmanMatrix::transpose(self : SignalfilterkalmanMatrix) -> SignalfilterkalmanMatrix {
  let result = signal_filter_kalman_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn SignalfilterkalmanMatrix::add(self : SignalfilterkalmanMatrix, other : SignalfilterkalmanMatrix) -> SignalfilterkalmanMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = signal_filter_kalman_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn SignalfilterkalmanMatrix::scale(self : SignalfilterkalmanMatrix, s : Double) -> SignalfilterkalmanMatrix {
  let result = signal_filter_kalman_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn SignalfilterkalmanMatrix::multiply(self : SignalfilterkalmanMatrix, other : SignalfilterkalmanMatrix) -> SignalfilterkalmanMatrix {
  if self.cols != other.rows { return signal_filter_kalman_make_matrix(self.rows, other.cols, 0.0) }
  let result = signal_filter_kalman_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn SignalfilterkalmanMatrix::trace(self : SignalfilterkalmanMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn SignalfilterkalmanMatrix::det(self : SignalfilterkalmanMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn SignalfilterkalmanMatrix::norm(self : SignalfilterkalmanMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn SignalfilterkalmanMatrix::to_string(self : SignalfilterkalmanMatrix) -> String {
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

pub(all) struct SignalfilterkalmanVector {
  comps : Array[Double]
  dim : Int
}

pub fn signal_filter_kalman_make_vector(comps : Array[Double]) -> SignalfilterkalmanVector {
  { comps, dim: comps.length() }
}

pub fn signal_filter_kalman_vector_zero(dim : Int) -> SignalfilterkalmanVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn SignalfilterkalmanVector::add(self : SignalfilterkalmanVector, other : SignalfilterkalmanVector) -> SignalfilterkalmanVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn SignalfilterkalmanVector::sub(self : SignalfilterkalmanVector, other : SignalfilterkalmanVector) -> SignalfilterkalmanVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn SignalfilterkalmanVector::scale(self : SignalfilterkalmanVector, s : Double) -> SignalfilterkalmanVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn SignalfilterkalmanVector::dot(self : SignalfilterkalmanVector, other : SignalfilterkalmanVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn SignalfilterkalmanVector::norm(self : SignalfilterkalmanVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn SignalfilterkalmanVector::normalize(self : SignalfilterkalmanVector) -> SignalfilterkalmanVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn SignalfilterkalmanVector::dist(self : SignalfilterkalmanVector, other : SignalfilterkalmanVector) -> Double {
  self.sub(other).norm()
}

pub fn SignalfilterkalmanVector::to_string(self : SignalfilterkalmanVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn signal_filter_kalman_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn signal_filter_kalman_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn signal_filter_kalman_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn signal_filter_kalman_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn signal_filter_kalman_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn signal_filter_kalman_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn signal_filter_kalman_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn signal_filter_kalman_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn signal_filter_kalman_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn signal_filter_kalman_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn signal_filter_kalman_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn signal_filter_kalman_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn signal_filter_kalman_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn signal_filter_kalman_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn signal_filter_kalman_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn signal_filter_kalman_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn signal_filter_kalman_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn signal_filter_kalman_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn signal_filter_kalman_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn signal_filter_kalman_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn signal_filter_kalman_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn signal_filter_kalman_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn signal_filter_kalman_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn signal_filter_kalman_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn signal_filter_kalman_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn signal_filter_kalman_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn signal_filter_kalman_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn signal_filter_kalman_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn signal_filter_kalman_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct SignalfilterkalmanFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_filter_kalman_frame_make(size : Int) -> SignalfilterkalmanFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_filter_kalman_frame_len(s : SignalfilterkalmanFrame) -> Int { s.size }

pub fn signal_filter_kalman_frame_get(s : SignalfilterkalmanFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_filter_kalman_frame_set(s : SignalfilterkalmanFrame, i : Int, v : Double) -> SignalfilterkalmanFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_filter_kalman_frame_sum(s : SignalfilterkalmanFrame) -> Double { @_common.sum(s.data) }

pub fn signal_filter_kalman_frame_mean(s : SignalfilterkalmanFrame) -> Double { @_common.mean(s.data) }

pub fn signal_filter_kalman_frame_scale(s : SignalfilterkalmanFrame, f : Double) -> SignalfilterkalmanFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_filter_kalman_frame_add(a : SignalfilterkalmanFrame, b : SignalfilterkalmanFrame) -> SignalfilterkalmanFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_filter_kalman_frame_copy(s : SignalfilterkalmanFrame) -> SignalfilterkalmanFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_filter_kalman_frame_fill(s : SignalfilterkalmanFrame, v : Double) -> SignalfilterkalmanFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_filter_kalman_frame_min(s : SignalfilterkalmanFrame) -> Double { @_common.min(s.data) }

pub fn signal_filter_kalman_frame_max(s : SignalfilterkalmanFrame) -> Double { @_common.max(s.data) }

pub fn signal_filter_kalman_frame_to_string(s : SignalfilterkalmanFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalfilterkalmanTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_filter_kalman_table_make(size : Int) -> SignalfilterkalmanTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_filter_kalman_table_len(s : SignalfilterkalmanTable) -> Int { s.size }

pub fn signal_filter_kalman_table_get(s : SignalfilterkalmanTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_filter_kalman_table_set(s : SignalfilterkalmanTable, i : Int, v : Double) -> SignalfilterkalmanTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_filter_kalman_table_sum(s : SignalfilterkalmanTable) -> Double { @_common.sum(s.data) }

pub fn signal_filter_kalman_table_mean(s : SignalfilterkalmanTable) -> Double { @_common.mean(s.data) }

pub fn signal_filter_kalman_table_scale(s : SignalfilterkalmanTable, f : Double) -> SignalfilterkalmanTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_filter_kalman_table_add(a : SignalfilterkalmanTable, b : SignalfilterkalmanTable) -> SignalfilterkalmanTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_filter_kalman_table_copy(s : SignalfilterkalmanTable) -> SignalfilterkalmanTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_filter_kalman_table_fill(s : SignalfilterkalmanTable, v : Double) -> SignalfilterkalmanTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_filter_kalman_table_min(s : SignalfilterkalmanTable) -> Double { @_common.min(s.data) }

pub fn signal_filter_kalman_table_max(s : SignalfilterkalmanTable) -> Double { @_common.max(s.data) }

pub fn signal_filter_kalman_table_to_string(s : SignalfilterkalmanTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalfilterkalmanGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_filter_kalman_graphn_make(size : Int) -> SignalfilterkalmanGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_filter_kalman_graphn_len(s : SignalfilterkalmanGraphN) -> Int { s.size }

pub fn signal_filter_kalman_graphn_get(s : SignalfilterkalmanGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_filter_kalman_graphn_set(s : SignalfilterkalmanGraphN, i : Int, v : Double) -> SignalfilterkalmanGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_filter_kalman_graphn_sum(s : SignalfilterkalmanGraphN) -> Double { @_common.sum(s.data) }

pub fn signal_filter_kalman_graphn_mean(s : SignalfilterkalmanGraphN) -> Double { @_common.mean(s.data) }

pub fn signal_filter_kalman_graphn_scale(s : SignalfilterkalmanGraphN, f : Double) -> SignalfilterkalmanGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_filter_kalman_graphn_add(a : SignalfilterkalmanGraphN, b : SignalfilterkalmanGraphN) -> SignalfilterkalmanGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_filter_kalman_graphn_copy(s : SignalfilterkalmanGraphN) -> SignalfilterkalmanGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_filter_kalman_graphn_fill(s : SignalfilterkalmanGraphN, v : Double) -> SignalfilterkalmanGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_filter_kalman_graphn_min(s : SignalfilterkalmanGraphN) -> Double { @_common.min(s.data) }

pub fn signal_filter_kalman_graphn_max(s : SignalfilterkalmanGraphN) -> Double { @_common.max(s.data) }

pub fn signal_filter_kalman_graphn_to_string(s : SignalfilterkalmanGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalfilterkalmanNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_filter_kalman_node_make(size : Int) -> SignalfilterkalmanNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_filter_kalman_node_len(s : SignalfilterkalmanNode) -> Int { s.size }

pub fn signal_filter_kalman_node_get(s : SignalfilterkalmanNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_filter_kalman_node_set(s : SignalfilterkalmanNode, i : Int, v : Double) -> SignalfilterkalmanNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_filter_kalman_node_sum(s : SignalfilterkalmanNode) -> Double { @_common.sum(s.data) }

pub fn signal_filter_kalman_node_mean(s : SignalfilterkalmanNode) -> Double { @_common.mean(s.data) }

pub fn signal_filter_kalman_node_scale(s : SignalfilterkalmanNode, f : Double) -> SignalfilterkalmanNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_filter_kalman_node_add(a : SignalfilterkalmanNode, b : SignalfilterkalmanNode) -> SignalfilterkalmanNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_filter_kalman_node_copy(s : SignalfilterkalmanNode) -> SignalfilterkalmanNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_filter_kalman_node_fill(s : SignalfilterkalmanNode, v : Double) -> SignalfilterkalmanNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_filter_kalman_node_min(s : SignalfilterkalmanNode) -> Double { @_common.min(s.data) }

pub fn signal_filter_kalman_node_max(s : SignalfilterkalmanNode) -> Double { @_common.max(s.data) }

pub fn signal_filter_kalman_node_to_string(s : SignalfilterkalmanNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalfilterkalmanEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_filter_kalman_edge_make(size : Int) -> SignalfilterkalmanEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_filter_kalman_edge_len(s : SignalfilterkalmanEdge) -> Int { s.size }

pub fn signal_filter_kalman_edge_get(s : SignalfilterkalmanEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_filter_kalman_edge_set(s : SignalfilterkalmanEdge, i : Int, v : Double) -> SignalfilterkalmanEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_filter_kalman_edge_sum(s : SignalfilterkalmanEdge) -> Double { @_common.sum(s.data) }

pub fn signal_filter_kalman_edge_mean(s : SignalfilterkalmanEdge) -> Double { @_common.mean(s.data) }

pub fn signal_filter_kalman_edge_scale(s : SignalfilterkalmanEdge, f : Double) -> SignalfilterkalmanEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_filter_kalman_edge_add(a : SignalfilterkalmanEdge, b : SignalfilterkalmanEdge) -> SignalfilterkalmanEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_filter_kalman_edge_copy(s : SignalfilterkalmanEdge) -> SignalfilterkalmanEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_filter_kalman_edge_fill(s : SignalfilterkalmanEdge, v : Double) -> SignalfilterkalmanEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_filter_kalman_edge_min(s : SignalfilterkalmanEdge) -> Double { @_common.min(s.data) }

pub fn signal_filter_kalman_edge_max(s : SignalfilterkalmanEdge) -> Double { @_common.max(s.data) }

pub fn signal_filter_kalman_edge_to_string(s : SignalfilterkalmanEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalfilterkalmanPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_filter_kalman_path_make(size : Int) -> SignalfilterkalmanPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_filter_kalman_path_len(s : SignalfilterkalmanPath) -> Int { s.size }

pub fn signal_filter_kalman_path_get(s : SignalfilterkalmanPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_filter_kalman_path_set(s : SignalfilterkalmanPath, i : Int, v : Double) -> SignalfilterkalmanPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_filter_kalman_path_sum(s : SignalfilterkalmanPath) -> Double { @_common.sum(s.data) }

pub fn signal_filter_kalman_path_mean(s : SignalfilterkalmanPath) -> Double { @_common.mean(s.data) }

pub fn signal_filter_kalman_path_scale(s : SignalfilterkalmanPath, f : Double) -> SignalfilterkalmanPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_filter_kalman_path_add(a : SignalfilterkalmanPath, b : SignalfilterkalmanPath) -> SignalfilterkalmanPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_filter_kalman_path_copy(s : SignalfilterkalmanPath) -> SignalfilterkalmanPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_filter_kalman_path_fill(s : SignalfilterkalmanPath, v : Double) -> SignalfilterkalmanPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_filter_kalman_path_min(s : SignalfilterkalmanPath) -> Double { @_common.min(s.data) }

pub fn signal_filter_kalman_path_max(s : SignalfilterkalmanPath) -> Double { @_common.max(s.data) }

pub fn signal_filter_kalman_path_to_string(s : SignalfilterkalmanPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalfilterkalmanCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_filter_kalman_cluster_make(size : Int) -> SignalfilterkalmanCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_filter_kalman_cluster_len(s : SignalfilterkalmanCluster) -> Int { s.size }

pub fn signal_filter_kalman_cluster_get(s : SignalfilterkalmanCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_filter_kalman_cluster_set(s : SignalfilterkalmanCluster, i : Int, v : Double) -> SignalfilterkalmanCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_filter_kalman_cluster_sum(s : SignalfilterkalmanCluster) -> Double { @_common.sum(s.data) }

pub fn signal_filter_kalman_cluster_mean(s : SignalfilterkalmanCluster) -> Double { @_common.mean(s.data) }

pub fn signal_filter_kalman_cluster_scale(s : SignalfilterkalmanCluster, f : Double) -> SignalfilterkalmanCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_filter_kalman_cluster_add(a : SignalfilterkalmanCluster, b : SignalfilterkalmanCluster) -> SignalfilterkalmanCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_filter_kalman_cluster_copy(s : SignalfilterkalmanCluster) -> SignalfilterkalmanCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_filter_kalman_cluster_fill(s : SignalfilterkalmanCluster, v : Double) -> SignalfilterkalmanCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_filter_kalman_cluster_min(s : SignalfilterkalmanCluster) -> Double { @_common.min(s.data) }

pub fn signal_filter_kalman_cluster_max(s : SignalfilterkalmanCluster) -> Double { @_common.max(s.data) }

pub fn signal_filter_kalman_cluster_to_string(s : SignalfilterkalmanCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalfilterkalmanModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_filter_kalman_model_make(size : Int) -> SignalfilterkalmanModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_filter_kalman_model_len(s : SignalfilterkalmanModel) -> Int { s.size }

pub fn signal_filter_kalman_model_get(s : SignalfilterkalmanModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_filter_kalman_model_set(s : SignalfilterkalmanModel, i : Int, v : Double) -> SignalfilterkalmanModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_filter_kalman_model_sum(s : SignalfilterkalmanModel) -> Double { @_common.sum(s.data) }

pub fn signal_filter_kalman_model_mean(s : SignalfilterkalmanModel) -> Double { @_common.mean(s.data) }

pub fn signal_filter_kalman_model_scale(s : SignalfilterkalmanModel, f : Double) -> SignalfilterkalmanModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_filter_kalman_model_add(a : SignalfilterkalmanModel, b : SignalfilterkalmanModel) -> SignalfilterkalmanModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_filter_kalman_model_copy(s : SignalfilterkalmanModel) -> SignalfilterkalmanModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_filter_kalman_model_fill(s : SignalfilterkalmanModel, v : Double) -> SignalfilterkalmanModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_filter_kalman_model_min(s : SignalfilterkalmanModel) -> Double { @_common.min(s.data) }

pub fn signal_filter_kalman_model_max(s : SignalfilterkalmanModel) -> Double { @_common.max(s.data) }

pub fn signal_filter_kalman_model_to_string(s : SignalfilterkalmanModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalfilterkalmanLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_filter_kalman_layer_make(size : Int) -> SignalfilterkalmanLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_filter_kalman_layer_len(s : SignalfilterkalmanLayer) -> Int { s.size }

pub fn signal_filter_kalman_layer_get(s : SignalfilterkalmanLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_filter_kalman_layer_set(s : SignalfilterkalmanLayer, i : Int, v : Double) -> SignalfilterkalmanLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_filter_kalman_layer_sum(s : SignalfilterkalmanLayer) -> Double { @_common.sum(s.data) }

pub fn signal_filter_kalman_layer_mean(s : SignalfilterkalmanLayer) -> Double { @_common.mean(s.data) }

pub fn signal_filter_kalman_layer_scale(s : SignalfilterkalmanLayer, f : Double) -> SignalfilterkalmanLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_filter_kalman_layer_add(a : SignalfilterkalmanLayer, b : SignalfilterkalmanLayer) -> SignalfilterkalmanLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_filter_kalman_layer_copy(s : SignalfilterkalmanLayer) -> SignalfilterkalmanLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_filter_kalman_layer_fill(s : SignalfilterkalmanLayer, v : Double) -> SignalfilterkalmanLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_filter_kalman_layer_min(s : SignalfilterkalmanLayer) -> Double { @_common.min(s.data) }

pub fn signal_filter_kalman_layer_max(s : SignalfilterkalmanLayer) -> Double { @_common.max(s.data) }

pub fn signal_filter_kalman_layer_to_string(s : SignalfilterkalmanLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalfilterkalmanBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_filter_kalman_buffer_make(size : Int) -> SignalfilterkalmanBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_filter_kalman_buffer_len(s : SignalfilterkalmanBuffer) -> Int { s.size }

pub fn signal_filter_kalman_buffer_get(s : SignalfilterkalmanBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_filter_kalman_buffer_set(s : SignalfilterkalmanBuffer, i : Int, v : Double) -> SignalfilterkalmanBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_filter_kalman_buffer_sum(s : SignalfilterkalmanBuffer) -> Double { @_common.sum(s.data) }

pub fn signal_filter_kalman_buffer_mean(s : SignalfilterkalmanBuffer) -> Double { @_common.mean(s.data) }

pub fn signal_filter_kalman_buffer_scale(s : SignalfilterkalmanBuffer, f : Double) -> SignalfilterkalmanBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_filter_kalman_buffer_add(a : SignalfilterkalmanBuffer, b : SignalfilterkalmanBuffer) -> SignalfilterkalmanBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_filter_kalman_buffer_copy(s : SignalfilterkalmanBuffer) -> SignalfilterkalmanBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_filter_kalman_buffer_fill(s : SignalfilterkalmanBuffer, v : Double) -> SignalfilterkalmanBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_filter_kalman_buffer_min(s : SignalfilterkalmanBuffer) -> Double { @_common.min(s.data) }

pub fn signal_filter_kalman_buffer_max(s : SignalfilterkalmanBuffer) -> Double { @_common.max(s.data) }

pub fn signal_filter_kalman_buffer_to_string(s : SignalfilterkalmanBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalfilterkalmanCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_filter_kalman_cursor_make(size : Int) -> SignalfilterkalmanCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_filter_kalman_cursor_len(s : SignalfilterkalmanCursor) -> Int { s.size }

pub fn signal_filter_kalman_cursor_get(s : SignalfilterkalmanCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_filter_kalman_cursor_set(s : SignalfilterkalmanCursor, i : Int, v : Double) -> SignalfilterkalmanCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_filter_kalman_cursor_sum(s : SignalfilterkalmanCursor) -> Double { @_common.sum(s.data) }

pub fn signal_filter_kalman_cursor_mean(s : SignalfilterkalmanCursor) -> Double { @_common.mean(s.data) }

pub fn signal_filter_kalman_cursor_scale(s : SignalfilterkalmanCursor, f : Double) -> SignalfilterkalmanCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_filter_kalman_cursor_add(a : SignalfilterkalmanCursor, b : SignalfilterkalmanCursor) -> SignalfilterkalmanCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_filter_kalman_cursor_copy(s : SignalfilterkalmanCursor) -> SignalfilterkalmanCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_filter_kalman_cursor_fill(s : SignalfilterkalmanCursor, v : Double) -> SignalfilterkalmanCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_filter_kalman_cursor_min(s : SignalfilterkalmanCursor) -> Double { @_common.min(s.data) }

pub fn signal_filter_kalman_cursor_max(s : SignalfilterkalmanCursor) -> Double { @_common.max(s.data) }

pub fn signal_filter_kalman_cursor_to_string(s : SignalfilterkalmanCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalfilterkalmanView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_filter_kalman_view_make(size : Int) -> SignalfilterkalmanView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_filter_kalman_view_len(s : SignalfilterkalmanView) -> Int { s.size }

pub fn signal_filter_kalman_view_get(s : SignalfilterkalmanView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_filter_kalman_view_set(s : SignalfilterkalmanView, i : Int, v : Double) -> SignalfilterkalmanView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_filter_kalman_view_sum(s : SignalfilterkalmanView) -> Double { @_common.sum(s.data) }

pub fn signal_filter_kalman_view_mean(s : SignalfilterkalmanView) -> Double { @_common.mean(s.data) }

pub fn signal_filter_kalman_view_scale(s : SignalfilterkalmanView, f : Double) -> SignalfilterkalmanView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_filter_kalman_view_add(a : SignalfilterkalmanView, b : SignalfilterkalmanView) -> SignalfilterkalmanView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_filter_kalman_view_copy(s : SignalfilterkalmanView) -> SignalfilterkalmanView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_filter_kalman_view_fill(s : SignalfilterkalmanView, v : Double) -> SignalfilterkalmanView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_filter_kalman_view_min(s : SignalfilterkalmanView) -> Double { @_common.min(s.data) }

pub fn signal_filter_kalman_view_max(s : SignalfilterkalmanView) -> Double { @_common.max(s.data) }

pub fn signal_filter_kalman_view_to_string(s : SignalfilterkalmanView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalfilterkalmanRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_filter_kalman_range_make(size : Int) -> SignalfilterkalmanRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_filter_kalman_range_len(s : SignalfilterkalmanRange) -> Int { s.size }

pub fn signal_filter_kalman_range_get(s : SignalfilterkalmanRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_filter_kalman_range_set(s : SignalfilterkalmanRange, i : Int, v : Double) -> SignalfilterkalmanRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_filter_kalman_range_sum(s : SignalfilterkalmanRange) -> Double { @_common.sum(s.data) }

pub fn signal_filter_kalman_range_mean(s : SignalfilterkalmanRange) -> Double { @_common.mean(s.data) }

pub fn signal_filter_kalman_range_scale(s : SignalfilterkalmanRange, f : Double) -> SignalfilterkalmanRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_filter_kalman_range_add(a : SignalfilterkalmanRange, b : SignalfilterkalmanRange) -> SignalfilterkalmanRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_filter_kalman_range_copy(s : SignalfilterkalmanRange) -> SignalfilterkalmanRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_filter_kalman_range_fill(s : SignalfilterkalmanRange, v : Double) -> SignalfilterkalmanRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_filter_kalman_range_min(s : SignalfilterkalmanRange) -> Double { @_common.min(s.data) }

pub fn signal_filter_kalman_range_max(s : SignalfilterkalmanRange) -> Double { @_common.max(s.data) }

pub fn signal_filter_kalman_range_to_string(s : SignalfilterkalmanRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalfilterkalmanSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_filter_kalman_slice_make(size : Int) -> SignalfilterkalmanSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_filter_kalman_slice_len(s : SignalfilterkalmanSlice) -> Int { s.size }

pub fn signal_filter_kalman_slice_get(s : SignalfilterkalmanSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_filter_kalman_slice_set(s : SignalfilterkalmanSlice, i : Int, v : Double) -> SignalfilterkalmanSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_filter_kalman_slice_sum(s : SignalfilterkalmanSlice) -> Double { @_common.sum(s.data) }

pub fn signal_filter_kalman_slice_mean(s : SignalfilterkalmanSlice) -> Double { @_common.mean(s.data) }

pub fn signal_filter_kalman_slice_scale(s : SignalfilterkalmanSlice, f : Double) -> SignalfilterkalmanSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_filter_kalman_slice_add(a : SignalfilterkalmanSlice, b : SignalfilterkalmanSlice) -> SignalfilterkalmanSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_filter_kalman_slice_copy(s : SignalfilterkalmanSlice) -> SignalfilterkalmanSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_filter_kalman_slice_fill(s : SignalfilterkalmanSlice, v : Double) -> SignalfilterkalmanSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_filter_kalman_slice_min(s : SignalfilterkalmanSlice) -> Double { @_common.min(s.data) }

pub fn signal_filter_kalman_slice_max(s : SignalfilterkalmanSlice) -> Double { @_common.max(s.data) }

pub fn signal_filter_kalman_slice_to_string(s : SignalfilterkalmanSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

