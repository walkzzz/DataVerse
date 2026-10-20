///===
/// extcore/signal_window_hamming

pub(all) struct SignalwindowhammingPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn signal_window_hamming_make_point(x : Double, y : Double) -> SignalwindowhammingPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn signal_window_hamming_make_point3(x : Double, y : Double, z : Double) -> SignalwindowhammingPoint {
  { x, y, z, label: 0 }
}

pub fn SignalwindowhammingPoint::x(self : SignalwindowhammingPoint) -> Double { self.x }

pub fn SignalwindowhammingPoint::y(self : SignalwindowhammingPoint) -> Double { self.y }

pub fn SignalwindowhammingPoint::z(self : SignalwindowhammingPoint) -> Double { self.z }

pub fn SignalwindowhammingPoint::label(self : SignalwindowhammingPoint) -> Int { self.label }

pub fn SignalwindowhammingPoint::dist(self : SignalwindowhammingPoint, other : SignalwindowhammingPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn SignalwindowhammingPoint::add(self : SignalwindowhammingPoint, other : SignalwindowhammingPoint) -> SignalwindowhammingPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn SignalwindowhammingPoint::sub(self : SignalwindowhammingPoint, other : SignalwindowhammingPoint) -> SignalwindowhammingPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn SignalwindowhammingPoint::scale(self : SignalwindowhammingPoint, s : Double) -> SignalwindowhammingPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn SignalwindowhammingPoint::dot(self : SignalwindowhammingPoint, other : SignalwindowhammingPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn SignalwindowhammingPoint::cross(self : SignalwindowhammingPoint, other : SignalwindowhammingPoint) -> SignalwindowhammingPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn SignalwindowhammingPoint::norm(self : SignalwindowhammingPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn SignalwindowhammingPoint::normalize(self : SignalwindowhammingPoint) -> SignalwindowhammingPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn SignalwindowhammingPoint::negate(self : SignalwindowhammingPoint) -> SignalwindowhammingPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn SignalwindowhammingPoint::mid(self : SignalwindowhammingPoint, other : SignalwindowhammingPoint) -> SignalwindowhammingPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn SignalwindowhammingPoint::lerp(self : SignalwindowhammingPoint, other : SignalwindowhammingPoint, t : Double) -> SignalwindowhammingPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn SignalwindowhammingPoint::to_string(self : SignalwindowhammingPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct SignalwindowhammingSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn signal_window_hamming_make_series(vals : Array[Double], name : String) -> SignalwindowhammingSeries {
  { vals, name, meta: 0 }
}

pub fn SignalwindowhammingSeries::len(self : SignalwindowhammingSeries) -> Int { self.vals.length() }

pub fn SignalwindowhammingSeries::sum(self : SignalwindowhammingSeries) -> Double { @_common.sum(self.vals) }

pub fn SignalwindowhammingSeries::mean(self : SignalwindowhammingSeries) -> Double { @_common.mean(self.vals) }

pub fn SignalwindowhammingSeries::min(self : SignalwindowhammingSeries) -> Double { @_common.min(self.vals) }

pub fn SignalwindowhammingSeries::max(self : SignalwindowhammingSeries) -> Double { @_common.max(self.vals) }

pub fn SignalwindowhammingSeries::range(self : SignalwindowhammingSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn SignalwindowhammingSeries::variance(self : SignalwindowhammingSeries) -> Double { @_common.variance(self.vals) }

pub fn SignalwindowhammingSeries::std(self : SignalwindowhammingSeries) -> Double { @_common.std(self.vals) }

pub fn SignalwindowhammingSeries::median(self : SignalwindowhammingSeries) -> Double { @_common.median(self.vals) }

pub fn SignalwindowhammingSeries::scale(self : SignalwindowhammingSeries, f : Double) -> SignalwindowhammingSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn SignalwindowhammingSeries::add(self : SignalwindowhammingSeries, other : SignalwindowhammingSeries) -> SignalwindowhammingSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn SignalwindowhammingSeries::sub(self : SignalwindowhammingSeries, other : SignalwindowhammingSeries) -> SignalwindowhammingSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn SignalwindowhammingSeries::normalize(self : SignalwindowhammingSeries) -> SignalwindowhammingSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn SignalwindowhammingSeries::cumsum(self : SignalwindowhammingSeries) -> SignalwindowhammingSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn SignalwindowhammingSeries::to_string(self : SignalwindowhammingSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct SignalwindowhammingMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn signal_window_hamming_make_matrix(rows : Int, cols : Int, val : Double) -> SignalwindowhammingMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn signal_window_hamming_matrix_identity(n : Int) -> SignalwindowhammingMatrix {
  let m = signal_window_hamming_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn SignalwindowhammingMatrix::get(self : SignalwindowhammingMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn SignalwindowhammingMatrix::transpose(self : SignalwindowhammingMatrix) -> SignalwindowhammingMatrix {
  let result = signal_window_hamming_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn SignalwindowhammingMatrix::add(self : SignalwindowhammingMatrix, other : SignalwindowhammingMatrix) -> SignalwindowhammingMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = signal_window_hamming_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn SignalwindowhammingMatrix::scale(self : SignalwindowhammingMatrix, s : Double) -> SignalwindowhammingMatrix {
  let result = signal_window_hamming_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn SignalwindowhammingMatrix::multiply(self : SignalwindowhammingMatrix, other : SignalwindowhammingMatrix) -> SignalwindowhammingMatrix {
  if self.cols != other.rows { return signal_window_hamming_make_matrix(self.rows, other.cols, 0.0) }
  let result = signal_window_hamming_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn SignalwindowhammingMatrix::trace(self : SignalwindowhammingMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn SignalwindowhammingMatrix::det(self : SignalwindowhammingMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn SignalwindowhammingMatrix::norm(self : SignalwindowhammingMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn SignalwindowhammingMatrix::to_string(self : SignalwindowhammingMatrix) -> String {
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

pub(all) struct SignalwindowhammingVector {
  comps : Array[Double]
  dim : Int
}

pub fn signal_window_hamming_make_vector(comps : Array[Double]) -> SignalwindowhammingVector {
  { comps, dim: comps.length() }
}

pub fn signal_window_hamming_vector_zero(dim : Int) -> SignalwindowhammingVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn SignalwindowhammingVector::add(self : SignalwindowhammingVector, other : SignalwindowhammingVector) -> SignalwindowhammingVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn SignalwindowhammingVector::sub(self : SignalwindowhammingVector, other : SignalwindowhammingVector) -> SignalwindowhammingVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn SignalwindowhammingVector::scale(self : SignalwindowhammingVector, s : Double) -> SignalwindowhammingVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn SignalwindowhammingVector::dot(self : SignalwindowhammingVector, other : SignalwindowhammingVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn SignalwindowhammingVector::norm(self : SignalwindowhammingVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn SignalwindowhammingVector::normalize(self : SignalwindowhammingVector) -> SignalwindowhammingVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn SignalwindowhammingVector::dist(self : SignalwindowhammingVector, other : SignalwindowhammingVector) -> Double {
  self.sub(other).norm()
}

pub fn SignalwindowhammingVector::to_string(self : SignalwindowhammingVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn signal_window_hamming_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn signal_window_hamming_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn signal_window_hamming_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn signal_window_hamming_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn signal_window_hamming_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn signal_window_hamming_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn signal_window_hamming_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn signal_window_hamming_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn signal_window_hamming_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn signal_window_hamming_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn signal_window_hamming_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn signal_window_hamming_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn signal_window_hamming_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn signal_window_hamming_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn signal_window_hamming_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn signal_window_hamming_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn signal_window_hamming_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn signal_window_hamming_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn signal_window_hamming_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn signal_window_hamming_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn signal_window_hamming_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn signal_window_hamming_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn signal_window_hamming_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn signal_window_hamming_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn signal_window_hamming_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn signal_window_hamming_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn signal_window_hamming_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn signal_window_hamming_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn signal_window_hamming_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct SignalwindowhammingFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_window_hamming_frame_make(size : Int) -> SignalwindowhammingFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_window_hamming_frame_len(s : SignalwindowhammingFrame) -> Int { s.size }

pub fn signal_window_hamming_frame_get(s : SignalwindowhammingFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_window_hamming_frame_set(s : SignalwindowhammingFrame, i : Int, v : Double) -> SignalwindowhammingFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_window_hamming_frame_sum(s : SignalwindowhammingFrame) -> Double { @_common.sum(s.data) }

pub fn signal_window_hamming_frame_mean(s : SignalwindowhammingFrame) -> Double { @_common.mean(s.data) }

pub fn signal_window_hamming_frame_scale(s : SignalwindowhammingFrame, f : Double) -> SignalwindowhammingFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_window_hamming_frame_add(a : SignalwindowhammingFrame, b : SignalwindowhammingFrame) -> SignalwindowhammingFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_window_hamming_frame_copy(s : SignalwindowhammingFrame) -> SignalwindowhammingFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_window_hamming_frame_fill(s : SignalwindowhammingFrame, v : Double) -> SignalwindowhammingFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_window_hamming_frame_min(s : SignalwindowhammingFrame) -> Double { @_common.min(s.data) }

pub fn signal_window_hamming_frame_max(s : SignalwindowhammingFrame) -> Double { @_common.max(s.data) }

pub fn signal_window_hamming_frame_to_string(s : SignalwindowhammingFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalwindowhammingTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_window_hamming_table_make(size : Int) -> SignalwindowhammingTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_window_hamming_table_len(s : SignalwindowhammingTable) -> Int { s.size }

pub fn signal_window_hamming_table_get(s : SignalwindowhammingTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_window_hamming_table_set(s : SignalwindowhammingTable, i : Int, v : Double) -> SignalwindowhammingTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_window_hamming_table_sum(s : SignalwindowhammingTable) -> Double { @_common.sum(s.data) }

pub fn signal_window_hamming_table_mean(s : SignalwindowhammingTable) -> Double { @_common.mean(s.data) }

pub fn signal_window_hamming_table_scale(s : SignalwindowhammingTable, f : Double) -> SignalwindowhammingTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_window_hamming_table_add(a : SignalwindowhammingTable, b : SignalwindowhammingTable) -> SignalwindowhammingTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_window_hamming_table_copy(s : SignalwindowhammingTable) -> SignalwindowhammingTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_window_hamming_table_fill(s : SignalwindowhammingTable, v : Double) -> SignalwindowhammingTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_window_hamming_table_min(s : SignalwindowhammingTable) -> Double { @_common.min(s.data) }

pub fn signal_window_hamming_table_max(s : SignalwindowhammingTable) -> Double { @_common.max(s.data) }

pub fn signal_window_hamming_table_to_string(s : SignalwindowhammingTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalwindowhammingGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_window_hamming_graphn_make(size : Int) -> SignalwindowhammingGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_window_hamming_graphn_len(s : SignalwindowhammingGraphN) -> Int { s.size }

pub fn signal_window_hamming_graphn_get(s : SignalwindowhammingGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_window_hamming_graphn_set(s : SignalwindowhammingGraphN, i : Int, v : Double) -> SignalwindowhammingGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_window_hamming_graphn_sum(s : SignalwindowhammingGraphN) -> Double { @_common.sum(s.data) }

pub fn signal_window_hamming_graphn_mean(s : SignalwindowhammingGraphN) -> Double { @_common.mean(s.data) }

pub fn signal_window_hamming_graphn_scale(s : SignalwindowhammingGraphN, f : Double) -> SignalwindowhammingGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_window_hamming_graphn_add(a : SignalwindowhammingGraphN, b : SignalwindowhammingGraphN) -> SignalwindowhammingGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_window_hamming_graphn_copy(s : SignalwindowhammingGraphN) -> SignalwindowhammingGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_window_hamming_graphn_fill(s : SignalwindowhammingGraphN, v : Double) -> SignalwindowhammingGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_window_hamming_graphn_min(s : SignalwindowhammingGraphN) -> Double { @_common.min(s.data) }

pub fn signal_window_hamming_graphn_max(s : SignalwindowhammingGraphN) -> Double { @_common.max(s.data) }

pub fn signal_window_hamming_graphn_to_string(s : SignalwindowhammingGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalwindowhammingNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_window_hamming_node_make(size : Int) -> SignalwindowhammingNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_window_hamming_node_len(s : SignalwindowhammingNode) -> Int { s.size }

pub fn signal_window_hamming_node_get(s : SignalwindowhammingNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_window_hamming_node_set(s : SignalwindowhammingNode, i : Int, v : Double) -> SignalwindowhammingNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_window_hamming_node_sum(s : SignalwindowhammingNode) -> Double { @_common.sum(s.data) }

pub fn signal_window_hamming_node_mean(s : SignalwindowhammingNode) -> Double { @_common.mean(s.data) }

pub fn signal_window_hamming_node_scale(s : SignalwindowhammingNode, f : Double) -> SignalwindowhammingNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_window_hamming_node_add(a : SignalwindowhammingNode, b : SignalwindowhammingNode) -> SignalwindowhammingNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_window_hamming_node_copy(s : SignalwindowhammingNode) -> SignalwindowhammingNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_window_hamming_node_fill(s : SignalwindowhammingNode, v : Double) -> SignalwindowhammingNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_window_hamming_node_min(s : SignalwindowhammingNode) -> Double { @_common.min(s.data) }

pub fn signal_window_hamming_node_max(s : SignalwindowhammingNode) -> Double { @_common.max(s.data) }

pub fn signal_window_hamming_node_to_string(s : SignalwindowhammingNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalwindowhammingEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_window_hamming_edge_make(size : Int) -> SignalwindowhammingEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_window_hamming_edge_len(s : SignalwindowhammingEdge) -> Int { s.size }

pub fn signal_window_hamming_edge_get(s : SignalwindowhammingEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_window_hamming_edge_set(s : SignalwindowhammingEdge, i : Int, v : Double) -> SignalwindowhammingEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_window_hamming_edge_sum(s : SignalwindowhammingEdge) -> Double { @_common.sum(s.data) }

pub fn signal_window_hamming_edge_mean(s : SignalwindowhammingEdge) -> Double { @_common.mean(s.data) }

pub fn signal_window_hamming_edge_scale(s : SignalwindowhammingEdge, f : Double) -> SignalwindowhammingEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_window_hamming_edge_add(a : SignalwindowhammingEdge, b : SignalwindowhammingEdge) -> SignalwindowhammingEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_window_hamming_edge_copy(s : SignalwindowhammingEdge) -> SignalwindowhammingEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_window_hamming_edge_fill(s : SignalwindowhammingEdge, v : Double) -> SignalwindowhammingEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_window_hamming_edge_min(s : SignalwindowhammingEdge) -> Double { @_common.min(s.data) }

pub fn signal_window_hamming_edge_max(s : SignalwindowhammingEdge) -> Double { @_common.max(s.data) }

pub fn signal_window_hamming_edge_to_string(s : SignalwindowhammingEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalwindowhammingPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_window_hamming_path_make(size : Int) -> SignalwindowhammingPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_window_hamming_path_len(s : SignalwindowhammingPath) -> Int { s.size }

pub fn signal_window_hamming_path_get(s : SignalwindowhammingPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_window_hamming_path_set(s : SignalwindowhammingPath, i : Int, v : Double) -> SignalwindowhammingPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_window_hamming_path_sum(s : SignalwindowhammingPath) -> Double { @_common.sum(s.data) }

pub fn signal_window_hamming_path_mean(s : SignalwindowhammingPath) -> Double { @_common.mean(s.data) }

pub fn signal_window_hamming_path_scale(s : SignalwindowhammingPath, f : Double) -> SignalwindowhammingPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_window_hamming_path_add(a : SignalwindowhammingPath, b : SignalwindowhammingPath) -> SignalwindowhammingPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_window_hamming_path_copy(s : SignalwindowhammingPath) -> SignalwindowhammingPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_window_hamming_path_fill(s : SignalwindowhammingPath, v : Double) -> SignalwindowhammingPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_window_hamming_path_min(s : SignalwindowhammingPath) -> Double { @_common.min(s.data) }

pub fn signal_window_hamming_path_max(s : SignalwindowhammingPath) -> Double { @_common.max(s.data) }

pub fn signal_window_hamming_path_to_string(s : SignalwindowhammingPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalwindowhammingCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_window_hamming_cluster_make(size : Int) -> SignalwindowhammingCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_window_hamming_cluster_len(s : SignalwindowhammingCluster) -> Int { s.size }

pub fn signal_window_hamming_cluster_get(s : SignalwindowhammingCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_window_hamming_cluster_set(s : SignalwindowhammingCluster, i : Int, v : Double) -> SignalwindowhammingCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_window_hamming_cluster_sum(s : SignalwindowhammingCluster) -> Double { @_common.sum(s.data) }

pub fn signal_window_hamming_cluster_mean(s : SignalwindowhammingCluster) -> Double { @_common.mean(s.data) }

pub fn signal_window_hamming_cluster_scale(s : SignalwindowhammingCluster, f : Double) -> SignalwindowhammingCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_window_hamming_cluster_add(a : SignalwindowhammingCluster, b : SignalwindowhammingCluster) -> SignalwindowhammingCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_window_hamming_cluster_copy(s : SignalwindowhammingCluster) -> SignalwindowhammingCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_window_hamming_cluster_fill(s : SignalwindowhammingCluster, v : Double) -> SignalwindowhammingCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_window_hamming_cluster_min(s : SignalwindowhammingCluster) -> Double { @_common.min(s.data) }

pub fn signal_window_hamming_cluster_max(s : SignalwindowhammingCluster) -> Double { @_common.max(s.data) }

pub fn signal_window_hamming_cluster_to_string(s : SignalwindowhammingCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalwindowhammingModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_window_hamming_model_make(size : Int) -> SignalwindowhammingModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_window_hamming_model_len(s : SignalwindowhammingModel) -> Int { s.size }

pub fn signal_window_hamming_model_get(s : SignalwindowhammingModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_window_hamming_model_set(s : SignalwindowhammingModel, i : Int, v : Double) -> SignalwindowhammingModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_window_hamming_model_sum(s : SignalwindowhammingModel) -> Double { @_common.sum(s.data) }

pub fn signal_window_hamming_model_mean(s : SignalwindowhammingModel) -> Double { @_common.mean(s.data) }

pub fn signal_window_hamming_model_scale(s : SignalwindowhammingModel, f : Double) -> SignalwindowhammingModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_window_hamming_model_add(a : SignalwindowhammingModel, b : SignalwindowhammingModel) -> SignalwindowhammingModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_window_hamming_model_copy(s : SignalwindowhammingModel) -> SignalwindowhammingModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_window_hamming_model_fill(s : SignalwindowhammingModel, v : Double) -> SignalwindowhammingModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_window_hamming_model_min(s : SignalwindowhammingModel) -> Double { @_common.min(s.data) }

pub fn signal_window_hamming_model_max(s : SignalwindowhammingModel) -> Double { @_common.max(s.data) }

pub fn signal_window_hamming_model_to_string(s : SignalwindowhammingModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalwindowhammingLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_window_hamming_layer_make(size : Int) -> SignalwindowhammingLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_window_hamming_layer_len(s : SignalwindowhammingLayer) -> Int { s.size }

pub fn signal_window_hamming_layer_get(s : SignalwindowhammingLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_window_hamming_layer_set(s : SignalwindowhammingLayer, i : Int, v : Double) -> SignalwindowhammingLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_window_hamming_layer_sum(s : SignalwindowhammingLayer) -> Double { @_common.sum(s.data) }

pub fn signal_window_hamming_layer_mean(s : SignalwindowhammingLayer) -> Double { @_common.mean(s.data) }

pub fn signal_window_hamming_layer_scale(s : SignalwindowhammingLayer, f : Double) -> SignalwindowhammingLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_window_hamming_layer_add(a : SignalwindowhammingLayer, b : SignalwindowhammingLayer) -> SignalwindowhammingLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_window_hamming_layer_copy(s : SignalwindowhammingLayer) -> SignalwindowhammingLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_window_hamming_layer_fill(s : SignalwindowhammingLayer, v : Double) -> SignalwindowhammingLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_window_hamming_layer_min(s : SignalwindowhammingLayer) -> Double { @_common.min(s.data) }

pub fn signal_window_hamming_layer_max(s : SignalwindowhammingLayer) -> Double { @_common.max(s.data) }

pub fn signal_window_hamming_layer_to_string(s : SignalwindowhammingLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalwindowhammingBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_window_hamming_buffer_make(size : Int) -> SignalwindowhammingBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_window_hamming_buffer_len(s : SignalwindowhammingBuffer) -> Int { s.size }

pub fn signal_window_hamming_buffer_get(s : SignalwindowhammingBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_window_hamming_buffer_set(s : SignalwindowhammingBuffer, i : Int, v : Double) -> SignalwindowhammingBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_window_hamming_buffer_sum(s : SignalwindowhammingBuffer) -> Double { @_common.sum(s.data) }

pub fn signal_window_hamming_buffer_mean(s : SignalwindowhammingBuffer) -> Double { @_common.mean(s.data) }

pub fn signal_window_hamming_buffer_scale(s : SignalwindowhammingBuffer, f : Double) -> SignalwindowhammingBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_window_hamming_buffer_add(a : SignalwindowhammingBuffer, b : SignalwindowhammingBuffer) -> SignalwindowhammingBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_window_hamming_buffer_copy(s : SignalwindowhammingBuffer) -> SignalwindowhammingBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_window_hamming_buffer_fill(s : SignalwindowhammingBuffer, v : Double) -> SignalwindowhammingBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_window_hamming_buffer_min(s : SignalwindowhammingBuffer) -> Double { @_common.min(s.data) }

pub fn signal_window_hamming_buffer_max(s : SignalwindowhammingBuffer) -> Double { @_common.max(s.data) }

pub fn signal_window_hamming_buffer_to_string(s : SignalwindowhammingBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalwindowhammingCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_window_hamming_cursor_make(size : Int) -> SignalwindowhammingCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_window_hamming_cursor_len(s : SignalwindowhammingCursor) -> Int { s.size }

pub fn signal_window_hamming_cursor_get(s : SignalwindowhammingCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_window_hamming_cursor_set(s : SignalwindowhammingCursor, i : Int, v : Double) -> SignalwindowhammingCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_window_hamming_cursor_sum(s : SignalwindowhammingCursor) -> Double { @_common.sum(s.data) }

pub fn signal_window_hamming_cursor_mean(s : SignalwindowhammingCursor) -> Double { @_common.mean(s.data) }

pub fn signal_window_hamming_cursor_scale(s : SignalwindowhammingCursor, f : Double) -> SignalwindowhammingCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_window_hamming_cursor_add(a : SignalwindowhammingCursor, b : SignalwindowhammingCursor) -> SignalwindowhammingCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_window_hamming_cursor_copy(s : SignalwindowhammingCursor) -> SignalwindowhammingCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_window_hamming_cursor_fill(s : SignalwindowhammingCursor, v : Double) -> SignalwindowhammingCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_window_hamming_cursor_min(s : SignalwindowhammingCursor) -> Double { @_common.min(s.data) }

pub fn signal_window_hamming_cursor_max(s : SignalwindowhammingCursor) -> Double { @_common.max(s.data) }

pub fn signal_window_hamming_cursor_to_string(s : SignalwindowhammingCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalwindowhammingView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_window_hamming_view_make(size : Int) -> SignalwindowhammingView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_window_hamming_view_len(s : SignalwindowhammingView) -> Int { s.size }

pub fn signal_window_hamming_view_get(s : SignalwindowhammingView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_window_hamming_view_set(s : SignalwindowhammingView, i : Int, v : Double) -> SignalwindowhammingView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_window_hamming_view_sum(s : SignalwindowhammingView) -> Double { @_common.sum(s.data) }

pub fn signal_window_hamming_view_mean(s : SignalwindowhammingView) -> Double { @_common.mean(s.data) }

pub fn signal_window_hamming_view_scale(s : SignalwindowhammingView, f : Double) -> SignalwindowhammingView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_window_hamming_view_add(a : SignalwindowhammingView, b : SignalwindowhammingView) -> SignalwindowhammingView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_window_hamming_view_copy(s : SignalwindowhammingView) -> SignalwindowhammingView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_window_hamming_view_fill(s : SignalwindowhammingView, v : Double) -> SignalwindowhammingView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_window_hamming_view_min(s : SignalwindowhammingView) -> Double { @_common.min(s.data) }

pub fn signal_window_hamming_view_max(s : SignalwindowhammingView) -> Double { @_common.max(s.data) }

pub fn signal_window_hamming_view_to_string(s : SignalwindowhammingView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalwindowhammingRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_window_hamming_range_make(size : Int) -> SignalwindowhammingRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_window_hamming_range_len(s : SignalwindowhammingRange) -> Int { s.size }

pub fn signal_window_hamming_range_get(s : SignalwindowhammingRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_window_hamming_range_set(s : SignalwindowhammingRange, i : Int, v : Double) -> SignalwindowhammingRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_window_hamming_range_sum(s : SignalwindowhammingRange) -> Double { @_common.sum(s.data) }

pub fn signal_window_hamming_range_mean(s : SignalwindowhammingRange) -> Double { @_common.mean(s.data) }

pub fn signal_window_hamming_range_scale(s : SignalwindowhammingRange, f : Double) -> SignalwindowhammingRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_window_hamming_range_add(a : SignalwindowhammingRange, b : SignalwindowhammingRange) -> SignalwindowhammingRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_window_hamming_range_copy(s : SignalwindowhammingRange) -> SignalwindowhammingRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_window_hamming_range_fill(s : SignalwindowhammingRange, v : Double) -> SignalwindowhammingRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_window_hamming_range_min(s : SignalwindowhammingRange) -> Double { @_common.min(s.data) }

pub fn signal_window_hamming_range_max(s : SignalwindowhammingRange) -> Double { @_common.max(s.data) }

pub fn signal_window_hamming_range_to_string(s : SignalwindowhammingRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalwindowhammingSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_window_hamming_slice_make(size : Int) -> SignalwindowhammingSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_window_hamming_slice_len(s : SignalwindowhammingSlice) -> Int { s.size }

pub fn signal_window_hamming_slice_get(s : SignalwindowhammingSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_window_hamming_slice_set(s : SignalwindowhammingSlice, i : Int, v : Double) -> SignalwindowhammingSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_window_hamming_slice_sum(s : SignalwindowhammingSlice) -> Double { @_common.sum(s.data) }

pub fn signal_window_hamming_slice_mean(s : SignalwindowhammingSlice) -> Double { @_common.mean(s.data) }

pub fn signal_window_hamming_slice_scale(s : SignalwindowhammingSlice, f : Double) -> SignalwindowhammingSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_window_hamming_slice_add(a : SignalwindowhammingSlice, b : SignalwindowhammingSlice) -> SignalwindowhammingSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_window_hamming_slice_copy(s : SignalwindowhammingSlice) -> SignalwindowhammingSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_window_hamming_slice_fill(s : SignalwindowhammingSlice, v : Double) -> SignalwindowhammingSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_window_hamming_slice_min(s : SignalwindowhammingSlice) -> Double { @_common.min(s.data) }

pub fn signal_window_hamming_slice_max(s : SignalwindowhammingSlice) -> Double { @_common.max(s.data) }

pub fn signal_window_hamming_slice_to_string(s : SignalwindowhammingSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

