///===
/// extcore/signal_window_kaiser

pub(all) struct SignalwindowkaiserPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn signal_window_kaiser_make_point(x : Double, y : Double) -> SignalwindowkaiserPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn signal_window_kaiser_make_point3(x : Double, y : Double, z : Double) -> SignalwindowkaiserPoint {
  { x, y, z, label: 0 }
}

pub fn SignalwindowkaiserPoint::x(self : SignalwindowkaiserPoint) -> Double { self.x }

pub fn SignalwindowkaiserPoint::y(self : SignalwindowkaiserPoint) -> Double { self.y }

pub fn SignalwindowkaiserPoint::z(self : SignalwindowkaiserPoint) -> Double { self.z }

pub fn SignalwindowkaiserPoint::label(self : SignalwindowkaiserPoint) -> Int { self.label }

pub fn SignalwindowkaiserPoint::dist(self : SignalwindowkaiserPoint, other : SignalwindowkaiserPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn SignalwindowkaiserPoint::add(self : SignalwindowkaiserPoint, other : SignalwindowkaiserPoint) -> SignalwindowkaiserPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn SignalwindowkaiserPoint::sub(self : SignalwindowkaiserPoint, other : SignalwindowkaiserPoint) -> SignalwindowkaiserPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn SignalwindowkaiserPoint::scale(self : SignalwindowkaiserPoint, s : Double) -> SignalwindowkaiserPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn SignalwindowkaiserPoint::dot(self : SignalwindowkaiserPoint, other : SignalwindowkaiserPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn SignalwindowkaiserPoint::cross(self : SignalwindowkaiserPoint, other : SignalwindowkaiserPoint) -> SignalwindowkaiserPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn SignalwindowkaiserPoint::norm(self : SignalwindowkaiserPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn SignalwindowkaiserPoint::normalize(self : SignalwindowkaiserPoint) -> SignalwindowkaiserPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn SignalwindowkaiserPoint::negate(self : SignalwindowkaiserPoint) -> SignalwindowkaiserPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn SignalwindowkaiserPoint::mid(self : SignalwindowkaiserPoint, other : SignalwindowkaiserPoint) -> SignalwindowkaiserPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn SignalwindowkaiserPoint::lerp(self : SignalwindowkaiserPoint, other : SignalwindowkaiserPoint, t : Double) -> SignalwindowkaiserPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn SignalwindowkaiserPoint::to_string(self : SignalwindowkaiserPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct SignalwindowkaiserSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn signal_window_kaiser_make_series(vals : Array[Double], name : String) -> SignalwindowkaiserSeries {
  { vals, name, meta: 0 }
}

pub fn SignalwindowkaiserSeries::len(self : SignalwindowkaiserSeries) -> Int { self.vals.length() }

pub fn SignalwindowkaiserSeries::sum(self : SignalwindowkaiserSeries) -> Double { @_common.sum(self.vals) }

pub fn SignalwindowkaiserSeries::mean(self : SignalwindowkaiserSeries) -> Double { @_common.mean(self.vals) }

pub fn SignalwindowkaiserSeries::min(self : SignalwindowkaiserSeries) -> Double { @_common.min(self.vals) }

pub fn SignalwindowkaiserSeries::max(self : SignalwindowkaiserSeries) -> Double { @_common.max(self.vals) }

pub fn SignalwindowkaiserSeries::range(self : SignalwindowkaiserSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn SignalwindowkaiserSeries::variance(self : SignalwindowkaiserSeries) -> Double { @_common.variance(self.vals) }

pub fn SignalwindowkaiserSeries::std(self : SignalwindowkaiserSeries) -> Double { @_common.std(self.vals) }

pub fn SignalwindowkaiserSeries::median(self : SignalwindowkaiserSeries) -> Double { @_common.median(self.vals) }

pub fn SignalwindowkaiserSeries::scale(self : SignalwindowkaiserSeries, f : Double) -> SignalwindowkaiserSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn SignalwindowkaiserSeries::add(self : SignalwindowkaiserSeries, other : SignalwindowkaiserSeries) -> SignalwindowkaiserSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn SignalwindowkaiserSeries::sub(self : SignalwindowkaiserSeries, other : SignalwindowkaiserSeries) -> SignalwindowkaiserSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn SignalwindowkaiserSeries::normalize(self : SignalwindowkaiserSeries) -> SignalwindowkaiserSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn SignalwindowkaiserSeries::cumsum(self : SignalwindowkaiserSeries) -> SignalwindowkaiserSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn SignalwindowkaiserSeries::to_string(self : SignalwindowkaiserSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct SignalwindowkaiserMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn signal_window_kaiser_make_matrix(rows : Int, cols : Int, val : Double) -> SignalwindowkaiserMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn signal_window_kaiser_matrix_identity(n : Int) -> SignalwindowkaiserMatrix {
  let m = signal_window_kaiser_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn SignalwindowkaiserMatrix::get(self : SignalwindowkaiserMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn SignalwindowkaiserMatrix::transpose(self : SignalwindowkaiserMatrix) -> SignalwindowkaiserMatrix {
  let result = signal_window_kaiser_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn SignalwindowkaiserMatrix::add(self : SignalwindowkaiserMatrix, other : SignalwindowkaiserMatrix) -> SignalwindowkaiserMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = signal_window_kaiser_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn SignalwindowkaiserMatrix::scale(self : SignalwindowkaiserMatrix, s : Double) -> SignalwindowkaiserMatrix {
  let result = signal_window_kaiser_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn SignalwindowkaiserMatrix::multiply(self : SignalwindowkaiserMatrix, other : SignalwindowkaiserMatrix) -> SignalwindowkaiserMatrix {
  if self.cols != other.rows { return signal_window_kaiser_make_matrix(self.rows, other.cols, 0.0) }
  let result = signal_window_kaiser_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn SignalwindowkaiserMatrix::trace(self : SignalwindowkaiserMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn SignalwindowkaiserMatrix::det(self : SignalwindowkaiserMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn SignalwindowkaiserMatrix::norm(self : SignalwindowkaiserMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn SignalwindowkaiserMatrix::to_string(self : SignalwindowkaiserMatrix) -> String {
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

pub(all) struct SignalwindowkaiserVector {
  comps : Array[Double]
  dim : Int
}

pub fn signal_window_kaiser_make_vector(comps : Array[Double]) -> SignalwindowkaiserVector {
  { comps, dim: comps.length() }
}

pub fn signal_window_kaiser_vector_zero(dim : Int) -> SignalwindowkaiserVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn SignalwindowkaiserVector::add(self : SignalwindowkaiserVector, other : SignalwindowkaiserVector) -> SignalwindowkaiserVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn SignalwindowkaiserVector::sub(self : SignalwindowkaiserVector, other : SignalwindowkaiserVector) -> SignalwindowkaiserVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn SignalwindowkaiserVector::scale(self : SignalwindowkaiserVector, s : Double) -> SignalwindowkaiserVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn SignalwindowkaiserVector::dot(self : SignalwindowkaiserVector, other : SignalwindowkaiserVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn SignalwindowkaiserVector::norm(self : SignalwindowkaiserVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn SignalwindowkaiserVector::normalize(self : SignalwindowkaiserVector) -> SignalwindowkaiserVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn SignalwindowkaiserVector::dist(self : SignalwindowkaiserVector, other : SignalwindowkaiserVector) -> Double {
  self.sub(other).norm()
}

pub fn SignalwindowkaiserVector::to_string(self : SignalwindowkaiserVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn signal_window_kaiser_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn signal_window_kaiser_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn signal_window_kaiser_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn signal_window_kaiser_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn signal_window_kaiser_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn signal_window_kaiser_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn signal_window_kaiser_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn signal_window_kaiser_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn signal_window_kaiser_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn signal_window_kaiser_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn signal_window_kaiser_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn signal_window_kaiser_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn signal_window_kaiser_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn signal_window_kaiser_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn signal_window_kaiser_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn signal_window_kaiser_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn signal_window_kaiser_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn signal_window_kaiser_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn signal_window_kaiser_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn signal_window_kaiser_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn signal_window_kaiser_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn signal_window_kaiser_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn signal_window_kaiser_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn signal_window_kaiser_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn signal_window_kaiser_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn signal_window_kaiser_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn signal_window_kaiser_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn signal_window_kaiser_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn signal_window_kaiser_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct SignalwindowkaiserFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_window_kaiser_frame_make(size : Int) -> SignalwindowkaiserFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_window_kaiser_frame_len(s : SignalwindowkaiserFrame) -> Int { s.size }

pub fn signal_window_kaiser_frame_get(s : SignalwindowkaiserFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_window_kaiser_frame_set(s : SignalwindowkaiserFrame, i : Int, v : Double) -> SignalwindowkaiserFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_window_kaiser_frame_sum(s : SignalwindowkaiserFrame) -> Double { @_common.sum(s.data) }

pub fn signal_window_kaiser_frame_mean(s : SignalwindowkaiserFrame) -> Double { @_common.mean(s.data) }

pub fn signal_window_kaiser_frame_scale(s : SignalwindowkaiserFrame, f : Double) -> SignalwindowkaiserFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_window_kaiser_frame_add(a : SignalwindowkaiserFrame, b : SignalwindowkaiserFrame) -> SignalwindowkaiserFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_window_kaiser_frame_copy(s : SignalwindowkaiserFrame) -> SignalwindowkaiserFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_window_kaiser_frame_fill(s : SignalwindowkaiserFrame, v : Double) -> SignalwindowkaiserFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_window_kaiser_frame_min(s : SignalwindowkaiserFrame) -> Double { @_common.min(s.data) }

pub fn signal_window_kaiser_frame_max(s : SignalwindowkaiserFrame) -> Double { @_common.max(s.data) }

pub fn signal_window_kaiser_frame_to_string(s : SignalwindowkaiserFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalwindowkaiserTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_window_kaiser_table_make(size : Int) -> SignalwindowkaiserTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_window_kaiser_table_len(s : SignalwindowkaiserTable) -> Int { s.size }

pub fn signal_window_kaiser_table_get(s : SignalwindowkaiserTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_window_kaiser_table_set(s : SignalwindowkaiserTable, i : Int, v : Double) -> SignalwindowkaiserTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_window_kaiser_table_sum(s : SignalwindowkaiserTable) -> Double { @_common.sum(s.data) }

pub fn signal_window_kaiser_table_mean(s : SignalwindowkaiserTable) -> Double { @_common.mean(s.data) }

pub fn signal_window_kaiser_table_scale(s : SignalwindowkaiserTable, f : Double) -> SignalwindowkaiserTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_window_kaiser_table_add(a : SignalwindowkaiserTable, b : SignalwindowkaiserTable) -> SignalwindowkaiserTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_window_kaiser_table_copy(s : SignalwindowkaiserTable) -> SignalwindowkaiserTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_window_kaiser_table_fill(s : SignalwindowkaiserTable, v : Double) -> SignalwindowkaiserTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_window_kaiser_table_min(s : SignalwindowkaiserTable) -> Double { @_common.min(s.data) }

pub fn signal_window_kaiser_table_max(s : SignalwindowkaiserTable) -> Double { @_common.max(s.data) }

pub fn signal_window_kaiser_table_to_string(s : SignalwindowkaiserTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalwindowkaiserGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_window_kaiser_graphn_make(size : Int) -> SignalwindowkaiserGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_window_kaiser_graphn_len(s : SignalwindowkaiserGraphN) -> Int { s.size }

pub fn signal_window_kaiser_graphn_get(s : SignalwindowkaiserGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_window_kaiser_graphn_set(s : SignalwindowkaiserGraphN, i : Int, v : Double) -> SignalwindowkaiserGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_window_kaiser_graphn_sum(s : SignalwindowkaiserGraphN) -> Double { @_common.sum(s.data) }

pub fn signal_window_kaiser_graphn_mean(s : SignalwindowkaiserGraphN) -> Double { @_common.mean(s.data) }

pub fn signal_window_kaiser_graphn_scale(s : SignalwindowkaiserGraphN, f : Double) -> SignalwindowkaiserGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_window_kaiser_graphn_add(a : SignalwindowkaiserGraphN, b : SignalwindowkaiserGraphN) -> SignalwindowkaiserGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_window_kaiser_graphn_copy(s : SignalwindowkaiserGraphN) -> SignalwindowkaiserGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_window_kaiser_graphn_fill(s : SignalwindowkaiserGraphN, v : Double) -> SignalwindowkaiserGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_window_kaiser_graphn_min(s : SignalwindowkaiserGraphN) -> Double { @_common.min(s.data) }

pub fn signal_window_kaiser_graphn_max(s : SignalwindowkaiserGraphN) -> Double { @_common.max(s.data) }

pub fn signal_window_kaiser_graphn_to_string(s : SignalwindowkaiserGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalwindowkaiserNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_window_kaiser_node_make(size : Int) -> SignalwindowkaiserNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_window_kaiser_node_len(s : SignalwindowkaiserNode) -> Int { s.size }

pub fn signal_window_kaiser_node_get(s : SignalwindowkaiserNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_window_kaiser_node_set(s : SignalwindowkaiserNode, i : Int, v : Double) -> SignalwindowkaiserNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_window_kaiser_node_sum(s : SignalwindowkaiserNode) -> Double { @_common.sum(s.data) }

pub fn signal_window_kaiser_node_mean(s : SignalwindowkaiserNode) -> Double { @_common.mean(s.data) }

pub fn signal_window_kaiser_node_scale(s : SignalwindowkaiserNode, f : Double) -> SignalwindowkaiserNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_window_kaiser_node_add(a : SignalwindowkaiserNode, b : SignalwindowkaiserNode) -> SignalwindowkaiserNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_window_kaiser_node_copy(s : SignalwindowkaiserNode) -> SignalwindowkaiserNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_window_kaiser_node_fill(s : SignalwindowkaiserNode, v : Double) -> SignalwindowkaiserNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_window_kaiser_node_min(s : SignalwindowkaiserNode) -> Double { @_common.min(s.data) }

pub fn signal_window_kaiser_node_max(s : SignalwindowkaiserNode) -> Double { @_common.max(s.data) }

pub fn signal_window_kaiser_node_to_string(s : SignalwindowkaiserNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalwindowkaiserEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_window_kaiser_edge_make(size : Int) -> SignalwindowkaiserEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_window_kaiser_edge_len(s : SignalwindowkaiserEdge) -> Int { s.size }

pub fn signal_window_kaiser_edge_get(s : SignalwindowkaiserEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_window_kaiser_edge_set(s : SignalwindowkaiserEdge, i : Int, v : Double) -> SignalwindowkaiserEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_window_kaiser_edge_sum(s : SignalwindowkaiserEdge) -> Double { @_common.sum(s.data) }

pub fn signal_window_kaiser_edge_mean(s : SignalwindowkaiserEdge) -> Double { @_common.mean(s.data) }

pub fn signal_window_kaiser_edge_scale(s : SignalwindowkaiserEdge, f : Double) -> SignalwindowkaiserEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_window_kaiser_edge_add(a : SignalwindowkaiserEdge, b : SignalwindowkaiserEdge) -> SignalwindowkaiserEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_window_kaiser_edge_copy(s : SignalwindowkaiserEdge) -> SignalwindowkaiserEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_window_kaiser_edge_fill(s : SignalwindowkaiserEdge, v : Double) -> SignalwindowkaiserEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_window_kaiser_edge_min(s : SignalwindowkaiserEdge) -> Double { @_common.min(s.data) }

pub fn signal_window_kaiser_edge_max(s : SignalwindowkaiserEdge) -> Double { @_common.max(s.data) }

pub fn signal_window_kaiser_edge_to_string(s : SignalwindowkaiserEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalwindowkaiserPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_window_kaiser_path_make(size : Int) -> SignalwindowkaiserPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_window_kaiser_path_len(s : SignalwindowkaiserPath) -> Int { s.size }

pub fn signal_window_kaiser_path_get(s : SignalwindowkaiserPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_window_kaiser_path_set(s : SignalwindowkaiserPath, i : Int, v : Double) -> SignalwindowkaiserPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_window_kaiser_path_sum(s : SignalwindowkaiserPath) -> Double { @_common.sum(s.data) }

pub fn signal_window_kaiser_path_mean(s : SignalwindowkaiserPath) -> Double { @_common.mean(s.data) }

pub fn signal_window_kaiser_path_scale(s : SignalwindowkaiserPath, f : Double) -> SignalwindowkaiserPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_window_kaiser_path_add(a : SignalwindowkaiserPath, b : SignalwindowkaiserPath) -> SignalwindowkaiserPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_window_kaiser_path_copy(s : SignalwindowkaiserPath) -> SignalwindowkaiserPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_window_kaiser_path_fill(s : SignalwindowkaiserPath, v : Double) -> SignalwindowkaiserPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_window_kaiser_path_min(s : SignalwindowkaiserPath) -> Double { @_common.min(s.data) }

pub fn signal_window_kaiser_path_max(s : SignalwindowkaiserPath) -> Double { @_common.max(s.data) }

pub fn signal_window_kaiser_path_to_string(s : SignalwindowkaiserPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalwindowkaiserCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_window_kaiser_cluster_make(size : Int) -> SignalwindowkaiserCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_window_kaiser_cluster_len(s : SignalwindowkaiserCluster) -> Int { s.size }

pub fn signal_window_kaiser_cluster_get(s : SignalwindowkaiserCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_window_kaiser_cluster_set(s : SignalwindowkaiserCluster, i : Int, v : Double) -> SignalwindowkaiserCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_window_kaiser_cluster_sum(s : SignalwindowkaiserCluster) -> Double { @_common.sum(s.data) }

pub fn signal_window_kaiser_cluster_mean(s : SignalwindowkaiserCluster) -> Double { @_common.mean(s.data) }

pub fn signal_window_kaiser_cluster_scale(s : SignalwindowkaiserCluster, f : Double) -> SignalwindowkaiserCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_window_kaiser_cluster_add(a : SignalwindowkaiserCluster, b : SignalwindowkaiserCluster) -> SignalwindowkaiserCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_window_kaiser_cluster_copy(s : SignalwindowkaiserCluster) -> SignalwindowkaiserCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_window_kaiser_cluster_fill(s : SignalwindowkaiserCluster, v : Double) -> SignalwindowkaiserCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_window_kaiser_cluster_min(s : SignalwindowkaiserCluster) -> Double { @_common.min(s.data) }

pub fn signal_window_kaiser_cluster_max(s : SignalwindowkaiserCluster) -> Double { @_common.max(s.data) }

pub fn signal_window_kaiser_cluster_to_string(s : SignalwindowkaiserCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalwindowkaiserModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_window_kaiser_model_make(size : Int) -> SignalwindowkaiserModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_window_kaiser_model_len(s : SignalwindowkaiserModel) -> Int { s.size }

pub fn signal_window_kaiser_model_get(s : SignalwindowkaiserModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_window_kaiser_model_set(s : SignalwindowkaiserModel, i : Int, v : Double) -> SignalwindowkaiserModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_window_kaiser_model_sum(s : SignalwindowkaiserModel) -> Double { @_common.sum(s.data) }

pub fn signal_window_kaiser_model_mean(s : SignalwindowkaiserModel) -> Double { @_common.mean(s.data) }

pub fn signal_window_kaiser_model_scale(s : SignalwindowkaiserModel, f : Double) -> SignalwindowkaiserModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_window_kaiser_model_add(a : SignalwindowkaiserModel, b : SignalwindowkaiserModel) -> SignalwindowkaiserModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_window_kaiser_model_copy(s : SignalwindowkaiserModel) -> SignalwindowkaiserModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_window_kaiser_model_fill(s : SignalwindowkaiserModel, v : Double) -> SignalwindowkaiserModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_window_kaiser_model_min(s : SignalwindowkaiserModel) -> Double { @_common.min(s.data) }

pub fn signal_window_kaiser_model_max(s : SignalwindowkaiserModel) -> Double { @_common.max(s.data) }

pub fn signal_window_kaiser_model_to_string(s : SignalwindowkaiserModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalwindowkaiserLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_window_kaiser_layer_make(size : Int) -> SignalwindowkaiserLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_window_kaiser_layer_len(s : SignalwindowkaiserLayer) -> Int { s.size }

pub fn signal_window_kaiser_layer_get(s : SignalwindowkaiserLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_window_kaiser_layer_set(s : SignalwindowkaiserLayer, i : Int, v : Double) -> SignalwindowkaiserLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_window_kaiser_layer_sum(s : SignalwindowkaiserLayer) -> Double { @_common.sum(s.data) }

pub fn signal_window_kaiser_layer_mean(s : SignalwindowkaiserLayer) -> Double { @_common.mean(s.data) }

pub fn signal_window_kaiser_layer_scale(s : SignalwindowkaiserLayer, f : Double) -> SignalwindowkaiserLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_window_kaiser_layer_add(a : SignalwindowkaiserLayer, b : SignalwindowkaiserLayer) -> SignalwindowkaiserLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_window_kaiser_layer_copy(s : SignalwindowkaiserLayer) -> SignalwindowkaiserLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_window_kaiser_layer_fill(s : SignalwindowkaiserLayer, v : Double) -> SignalwindowkaiserLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_window_kaiser_layer_min(s : SignalwindowkaiserLayer) -> Double { @_common.min(s.data) }

pub fn signal_window_kaiser_layer_max(s : SignalwindowkaiserLayer) -> Double { @_common.max(s.data) }

pub fn signal_window_kaiser_layer_to_string(s : SignalwindowkaiserLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalwindowkaiserBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_window_kaiser_buffer_make(size : Int) -> SignalwindowkaiserBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_window_kaiser_buffer_len(s : SignalwindowkaiserBuffer) -> Int { s.size }

pub fn signal_window_kaiser_buffer_get(s : SignalwindowkaiserBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_window_kaiser_buffer_set(s : SignalwindowkaiserBuffer, i : Int, v : Double) -> SignalwindowkaiserBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_window_kaiser_buffer_sum(s : SignalwindowkaiserBuffer) -> Double { @_common.sum(s.data) }

pub fn signal_window_kaiser_buffer_mean(s : SignalwindowkaiserBuffer) -> Double { @_common.mean(s.data) }

pub fn signal_window_kaiser_buffer_scale(s : SignalwindowkaiserBuffer, f : Double) -> SignalwindowkaiserBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_window_kaiser_buffer_add(a : SignalwindowkaiserBuffer, b : SignalwindowkaiserBuffer) -> SignalwindowkaiserBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_window_kaiser_buffer_copy(s : SignalwindowkaiserBuffer) -> SignalwindowkaiserBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_window_kaiser_buffer_fill(s : SignalwindowkaiserBuffer, v : Double) -> SignalwindowkaiserBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_window_kaiser_buffer_min(s : SignalwindowkaiserBuffer) -> Double { @_common.min(s.data) }

pub fn signal_window_kaiser_buffer_max(s : SignalwindowkaiserBuffer) -> Double { @_common.max(s.data) }

pub fn signal_window_kaiser_buffer_to_string(s : SignalwindowkaiserBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalwindowkaiserCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_window_kaiser_cursor_make(size : Int) -> SignalwindowkaiserCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_window_kaiser_cursor_len(s : SignalwindowkaiserCursor) -> Int { s.size }

pub fn signal_window_kaiser_cursor_get(s : SignalwindowkaiserCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_window_kaiser_cursor_set(s : SignalwindowkaiserCursor, i : Int, v : Double) -> SignalwindowkaiserCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_window_kaiser_cursor_sum(s : SignalwindowkaiserCursor) -> Double { @_common.sum(s.data) }

pub fn signal_window_kaiser_cursor_mean(s : SignalwindowkaiserCursor) -> Double { @_common.mean(s.data) }

pub fn signal_window_kaiser_cursor_scale(s : SignalwindowkaiserCursor, f : Double) -> SignalwindowkaiserCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_window_kaiser_cursor_add(a : SignalwindowkaiserCursor, b : SignalwindowkaiserCursor) -> SignalwindowkaiserCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_window_kaiser_cursor_copy(s : SignalwindowkaiserCursor) -> SignalwindowkaiserCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_window_kaiser_cursor_fill(s : SignalwindowkaiserCursor, v : Double) -> SignalwindowkaiserCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_window_kaiser_cursor_min(s : SignalwindowkaiserCursor) -> Double { @_common.min(s.data) }

pub fn signal_window_kaiser_cursor_max(s : SignalwindowkaiserCursor) -> Double { @_common.max(s.data) }

pub fn signal_window_kaiser_cursor_to_string(s : SignalwindowkaiserCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalwindowkaiserView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_window_kaiser_view_make(size : Int) -> SignalwindowkaiserView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_window_kaiser_view_len(s : SignalwindowkaiserView) -> Int { s.size }

pub fn signal_window_kaiser_view_get(s : SignalwindowkaiserView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_window_kaiser_view_set(s : SignalwindowkaiserView, i : Int, v : Double) -> SignalwindowkaiserView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_window_kaiser_view_sum(s : SignalwindowkaiserView) -> Double { @_common.sum(s.data) }

pub fn signal_window_kaiser_view_mean(s : SignalwindowkaiserView) -> Double { @_common.mean(s.data) }

pub fn signal_window_kaiser_view_scale(s : SignalwindowkaiserView, f : Double) -> SignalwindowkaiserView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_window_kaiser_view_add(a : SignalwindowkaiserView, b : SignalwindowkaiserView) -> SignalwindowkaiserView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_window_kaiser_view_copy(s : SignalwindowkaiserView) -> SignalwindowkaiserView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_window_kaiser_view_fill(s : SignalwindowkaiserView, v : Double) -> SignalwindowkaiserView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_window_kaiser_view_min(s : SignalwindowkaiserView) -> Double { @_common.min(s.data) }

pub fn signal_window_kaiser_view_max(s : SignalwindowkaiserView) -> Double { @_common.max(s.data) }

pub fn signal_window_kaiser_view_to_string(s : SignalwindowkaiserView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalwindowkaiserRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_window_kaiser_range_make(size : Int) -> SignalwindowkaiserRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_window_kaiser_range_len(s : SignalwindowkaiserRange) -> Int { s.size }

pub fn signal_window_kaiser_range_get(s : SignalwindowkaiserRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_window_kaiser_range_set(s : SignalwindowkaiserRange, i : Int, v : Double) -> SignalwindowkaiserRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_window_kaiser_range_sum(s : SignalwindowkaiserRange) -> Double { @_common.sum(s.data) }

pub fn signal_window_kaiser_range_mean(s : SignalwindowkaiserRange) -> Double { @_common.mean(s.data) }

pub fn signal_window_kaiser_range_scale(s : SignalwindowkaiserRange, f : Double) -> SignalwindowkaiserRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_window_kaiser_range_add(a : SignalwindowkaiserRange, b : SignalwindowkaiserRange) -> SignalwindowkaiserRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_window_kaiser_range_copy(s : SignalwindowkaiserRange) -> SignalwindowkaiserRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_window_kaiser_range_fill(s : SignalwindowkaiserRange, v : Double) -> SignalwindowkaiserRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_window_kaiser_range_min(s : SignalwindowkaiserRange) -> Double { @_common.min(s.data) }

pub fn signal_window_kaiser_range_max(s : SignalwindowkaiserRange) -> Double { @_common.max(s.data) }

pub fn signal_window_kaiser_range_to_string(s : SignalwindowkaiserRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalwindowkaiserSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_window_kaiser_slice_make(size : Int) -> SignalwindowkaiserSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_window_kaiser_slice_len(s : SignalwindowkaiserSlice) -> Int { s.size }

pub fn signal_window_kaiser_slice_get(s : SignalwindowkaiserSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_window_kaiser_slice_set(s : SignalwindowkaiserSlice, i : Int, v : Double) -> SignalwindowkaiserSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_window_kaiser_slice_sum(s : SignalwindowkaiserSlice) -> Double { @_common.sum(s.data) }

pub fn signal_window_kaiser_slice_mean(s : SignalwindowkaiserSlice) -> Double { @_common.mean(s.data) }

pub fn signal_window_kaiser_slice_scale(s : SignalwindowkaiserSlice, f : Double) -> SignalwindowkaiserSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_window_kaiser_slice_add(a : SignalwindowkaiserSlice, b : SignalwindowkaiserSlice) -> SignalwindowkaiserSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_window_kaiser_slice_copy(s : SignalwindowkaiserSlice) -> SignalwindowkaiserSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_window_kaiser_slice_fill(s : SignalwindowkaiserSlice, v : Double) -> SignalwindowkaiserSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_window_kaiser_slice_min(s : SignalwindowkaiserSlice) -> Double { @_common.min(s.data) }

pub fn signal_window_kaiser_slice_max(s : SignalwindowkaiserSlice) -> Double { @_common.max(s.data) }

pub fn signal_window_kaiser_slice_to_string(s : SignalwindowkaiserSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

