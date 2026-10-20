///===
/// extcore/signal_window_blackman

pub(all) struct SignalwindowblackmanPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn signal_window_blackman_make_point(x : Double, y : Double) -> SignalwindowblackmanPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn signal_window_blackman_make_point3(x : Double, y : Double, z : Double) -> SignalwindowblackmanPoint {
  { x, y, z, label: 0 }
}

pub fn SignalwindowblackmanPoint::x(self : SignalwindowblackmanPoint) -> Double { self.x }

pub fn SignalwindowblackmanPoint::y(self : SignalwindowblackmanPoint) -> Double { self.y }

pub fn SignalwindowblackmanPoint::z(self : SignalwindowblackmanPoint) -> Double { self.z }

pub fn SignalwindowblackmanPoint::label(self : SignalwindowblackmanPoint) -> Int { self.label }

pub fn SignalwindowblackmanPoint::dist(self : SignalwindowblackmanPoint, other : SignalwindowblackmanPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn SignalwindowblackmanPoint::add(self : SignalwindowblackmanPoint, other : SignalwindowblackmanPoint) -> SignalwindowblackmanPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn SignalwindowblackmanPoint::sub(self : SignalwindowblackmanPoint, other : SignalwindowblackmanPoint) -> SignalwindowblackmanPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn SignalwindowblackmanPoint::scale(self : SignalwindowblackmanPoint, s : Double) -> SignalwindowblackmanPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn SignalwindowblackmanPoint::dot(self : SignalwindowblackmanPoint, other : SignalwindowblackmanPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn SignalwindowblackmanPoint::cross(self : SignalwindowblackmanPoint, other : SignalwindowblackmanPoint) -> SignalwindowblackmanPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn SignalwindowblackmanPoint::norm(self : SignalwindowblackmanPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn SignalwindowblackmanPoint::normalize(self : SignalwindowblackmanPoint) -> SignalwindowblackmanPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn SignalwindowblackmanPoint::negate(self : SignalwindowblackmanPoint) -> SignalwindowblackmanPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn SignalwindowblackmanPoint::mid(self : SignalwindowblackmanPoint, other : SignalwindowblackmanPoint) -> SignalwindowblackmanPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn SignalwindowblackmanPoint::lerp(self : SignalwindowblackmanPoint, other : SignalwindowblackmanPoint, t : Double) -> SignalwindowblackmanPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn SignalwindowblackmanPoint::to_string(self : SignalwindowblackmanPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct SignalwindowblackmanSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn signal_window_blackman_make_series(vals : Array[Double], name : String) -> SignalwindowblackmanSeries {
  { vals, name, meta: 0 }
}

pub fn SignalwindowblackmanSeries::len(self : SignalwindowblackmanSeries) -> Int { self.vals.length() }

pub fn SignalwindowblackmanSeries::sum(self : SignalwindowblackmanSeries) -> Double { @_common.sum(self.vals) }

pub fn SignalwindowblackmanSeries::mean(self : SignalwindowblackmanSeries) -> Double { @_common.mean(self.vals) }

pub fn SignalwindowblackmanSeries::min(self : SignalwindowblackmanSeries) -> Double { @_common.min(self.vals) }

pub fn SignalwindowblackmanSeries::max(self : SignalwindowblackmanSeries) -> Double { @_common.max(self.vals) }

pub fn SignalwindowblackmanSeries::range(self : SignalwindowblackmanSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn SignalwindowblackmanSeries::variance(self : SignalwindowblackmanSeries) -> Double { @_common.variance(self.vals) }

pub fn SignalwindowblackmanSeries::std(self : SignalwindowblackmanSeries) -> Double { @_common.std(self.vals) }

pub fn SignalwindowblackmanSeries::median(self : SignalwindowblackmanSeries) -> Double { @_common.median(self.vals) }

pub fn SignalwindowblackmanSeries::scale(self : SignalwindowblackmanSeries, f : Double) -> SignalwindowblackmanSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn SignalwindowblackmanSeries::add(self : SignalwindowblackmanSeries, other : SignalwindowblackmanSeries) -> SignalwindowblackmanSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn SignalwindowblackmanSeries::sub(self : SignalwindowblackmanSeries, other : SignalwindowblackmanSeries) -> SignalwindowblackmanSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn SignalwindowblackmanSeries::normalize(self : SignalwindowblackmanSeries) -> SignalwindowblackmanSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn SignalwindowblackmanSeries::cumsum(self : SignalwindowblackmanSeries) -> SignalwindowblackmanSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn SignalwindowblackmanSeries::to_string(self : SignalwindowblackmanSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct SignalwindowblackmanMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn signal_window_blackman_make_matrix(rows : Int, cols : Int, val : Double) -> SignalwindowblackmanMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn signal_window_blackman_matrix_identity(n : Int) -> SignalwindowblackmanMatrix {
  let m = signal_window_blackman_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn SignalwindowblackmanMatrix::get(self : SignalwindowblackmanMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn SignalwindowblackmanMatrix::transpose(self : SignalwindowblackmanMatrix) -> SignalwindowblackmanMatrix {
  let result = signal_window_blackman_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn SignalwindowblackmanMatrix::add(self : SignalwindowblackmanMatrix, other : SignalwindowblackmanMatrix) -> SignalwindowblackmanMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = signal_window_blackman_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn SignalwindowblackmanMatrix::scale(self : SignalwindowblackmanMatrix, s : Double) -> SignalwindowblackmanMatrix {
  let result = signal_window_blackman_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn SignalwindowblackmanMatrix::multiply(self : SignalwindowblackmanMatrix, other : SignalwindowblackmanMatrix) -> SignalwindowblackmanMatrix {
  if self.cols != other.rows { return signal_window_blackman_make_matrix(self.rows, other.cols, 0.0) }
  let result = signal_window_blackman_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn SignalwindowblackmanMatrix::trace(self : SignalwindowblackmanMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn SignalwindowblackmanMatrix::det(self : SignalwindowblackmanMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn SignalwindowblackmanMatrix::norm(self : SignalwindowblackmanMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn SignalwindowblackmanMatrix::to_string(self : SignalwindowblackmanMatrix) -> String {
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

pub(all) struct SignalwindowblackmanVector {
  comps : Array[Double]
  dim : Int
}

pub fn signal_window_blackman_make_vector(comps : Array[Double]) -> SignalwindowblackmanVector {
  { comps, dim: comps.length() }
}

pub fn signal_window_blackman_vector_zero(dim : Int) -> SignalwindowblackmanVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn SignalwindowblackmanVector::add(self : SignalwindowblackmanVector, other : SignalwindowblackmanVector) -> SignalwindowblackmanVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn SignalwindowblackmanVector::sub(self : SignalwindowblackmanVector, other : SignalwindowblackmanVector) -> SignalwindowblackmanVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn SignalwindowblackmanVector::scale(self : SignalwindowblackmanVector, s : Double) -> SignalwindowblackmanVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn SignalwindowblackmanVector::dot(self : SignalwindowblackmanVector, other : SignalwindowblackmanVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn SignalwindowblackmanVector::norm(self : SignalwindowblackmanVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn SignalwindowblackmanVector::normalize(self : SignalwindowblackmanVector) -> SignalwindowblackmanVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn SignalwindowblackmanVector::dist(self : SignalwindowblackmanVector, other : SignalwindowblackmanVector) -> Double {
  self.sub(other).norm()
}

pub fn SignalwindowblackmanVector::to_string(self : SignalwindowblackmanVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn signal_window_blackman_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn signal_window_blackman_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn signal_window_blackman_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn signal_window_blackman_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn signal_window_blackman_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn signal_window_blackman_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn signal_window_blackman_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn signal_window_blackman_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn signal_window_blackman_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn signal_window_blackman_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn signal_window_blackman_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn signal_window_blackman_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn signal_window_blackman_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn signal_window_blackman_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn signal_window_blackman_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn signal_window_blackman_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn signal_window_blackman_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn signal_window_blackman_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn signal_window_blackman_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn signal_window_blackman_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn signal_window_blackman_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn signal_window_blackman_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn signal_window_blackman_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn signal_window_blackman_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn signal_window_blackman_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn signal_window_blackman_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn signal_window_blackman_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn signal_window_blackman_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn signal_window_blackman_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct SignalwindowblackmanFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_window_blackman_frame_make(size : Int) -> SignalwindowblackmanFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_window_blackman_frame_len(s : SignalwindowblackmanFrame) -> Int { s.size }

pub fn signal_window_blackman_frame_get(s : SignalwindowblackmanFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_window_blackman_frame_set(s : SignalwindowblackmanFrame, i : Int, v : Double) -> SignalwindowblackmanFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_window_blackman_frame_sum(s : SignalwindowblackmanFrame) -> Double { @_common.sum(s.data) }

pub fn signal_window_blackman_frame_mean(s : SignalwindowblackmanFrame) -> Double { @_common.mean(s.data) }

pub fn signal_window_blackman_frame_scale(s : SignalwindowblackmanFrame, f : Double) -> SignalwindowblackmanFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_window_blackman_frame_add(a : SignalwindowblackmanFrame, b : SignalwindowblackmanFrame) -> SignalwindowblackmanFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_window_blackman_frame_copy(s : SignalwindowblackmanFrame) -> SignalwindowblackmanFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_window_blackman_frame_fill(s : SignalwindowblackmanFrame, v : Double) -> SignalwindowblackmanFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_window_blackman_frame_min(s : SignalwindowblackmanFrame) -> Double { @_common.min(s.data) }

pub fn signal_window_blackman_frame_max(s : SignalwindowblackmanFrame) -> Double { @_common.max(s.data) }

pub fn signal_window_blackman_frame_to_string(s : SignalwindowblackmanFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalwindowblackmanTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_window_blackman_table_make(size : Int) -> SignalwindowblackmanTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_window_blackman_table_len(s : SignalwindowblackmanTable) -> Int { s.size }

pub fn signal_window_blackman_table_get(s : SignalwindowblackmanTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_window_blackman_table_set(s : SignalwindowblackmanTable, i : Int, v : Double) -> SignalwindowblackmanTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_window_blackman_table_sum(s : SignalwindowblackmanTable) -> Double { @_common.sum(s.data) }

pub fn signal_window_blackman_table_mean(s : SignalwindowblackmanTable) -> Double { @_common.mean(s.data) }

pub fn signal_window_blackman_table_scale(s : SignalwindowblackmanTable, f : Double) -> SignalwindowblackmanTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_window_blackman_table_add(a : SignalwindowblackmanTable, b : SignalwindowblackmanTable) -> SignalwindowblackmanTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_window_blackman_table_copy(s : SignalwindowblackmanTable) -> SignalwindowblackmanTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_window_blackman_table_fill(s : SignalwindowblackmanTable, v : Double) -> SignalwindowblackmanTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_window_blackman_table_min(s : SignalwindowblackmanTable) -> Double { @_common.min(s.data) }

pub fn signal_window_blackman_table_max(s : SignalwindowblackmanTable) -> Double { @_common.max(s.data) }

pub fn signal_window_blackman_table_to_string(s : SignalwindowblackmanTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalwindowblackmanGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_window_blackman_graphn_make(size : Int) -> SignalwindowblackmanGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_window_blackman_graphn_len(s : SignalwindowblackmanGraphN) -> Int { s.size }

pub fn signal_window_blackman_graphn_get(s : SignalwindowblackmanGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_window_blackman_graphn_set(s : SignalwindowblackmanGraphN, i : Int, v : Double) -> SignalwindowblackmanGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_window_blackman_graphn_sum(s : SignalwindowblackmanGraphN) -> Double { @_common.sum(s.data) }

pub fn signal_window_blackman_graphn_mean(s : SignalwindowblackmanGraphN) -> Double { @_common.mean(s.data) }

pub fn signal_window_blackman_graphn_scale(s : SignalwindowblackmanGraphN, f : Double) -> SignalwindowblackmanGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_window_blackman_graphn_add(a : SignalwindowblackmanGraphN, b : SignalwindowblackmanGraphN) -> SignalwindowblackmanGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_window_blackman_graphn_copy(s : SignalwindowblackmanGraphN) -> SignalwindowblackmanGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_window_blackman_graphn_fill(s : SignalwindowblackmanGraphN, v : Double) -> SignalwindowblackmanGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_window_blackman_graphn_min(s : SignalwindowblackmanGraphN) -> Double { @_common.min(s.data) }

pub fn signal_window_blackman_graphn_max(s : SignalwindowblackmanGraphN) -> Double { @_common.max(s.data) }

pub fn signal_window_blackman_graphn_to_string(s : SignalwindowblackmanGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalwindowblackmanNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_window_blackman_node_make(size : Int) -> SignalwindowblackmanNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_window_blackman_node_len(s : SignalwindowblackmanNode) -> Int { s.size }

pub fn signal_window_blackman_node_get(s : SignalwindowblackmanNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_window_blackman_node_set(s : SignalwindowblackmanNode, i : Int, v : Double) -> SignalwindowblackmanNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_window_blackman_node_sum(s : SignalwindowblackmanNode) -> Double { @_common.sum(s.data) }

pub fn signal_window_blackman_node_mean(s : SignalwindowblackmanNode) -> Double { @_common.mean(s.data) }

pub fn signal_window_blackman_node_scale(s : SignalwindowblackmanNode, f : Double) -> SignalwindowblackmanNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_window_blackman_node_add(a : SignalwindowblackmanNode, b : SignalwindowblackmanNode) -> SignalwindowblackmanNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_window_blackman_node_copy(s : SignalwindowblackmanNode) -> SignalwindowblackmanNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_window_blackman_node_fill(s : SignalwindowblackmanNode, v : Double) -> SignalwindowblackmanNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_window_blackman_node_min(s : SignalwindowblackmanNode) -> Double { @_common.min(s.data) }

pub fn signal_window_blackman_node_max(s : SignalwindowblackmanNode) -> Double { @_common.max(s.data) }

pub fn signal_window_blackman_node_to_string(s : SignalwindowblackmanNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalwindowblackmanEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_window_blackman_edge_make(size : Int) -> SignalwindowblackmanEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_window_blackman_edge_len(s : SignalwindowblackmanEdge) -> Int { s.size }

pub fn signal_window_blackman_edge_get(s : SignalwindowblackmanEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_window_blackman_edge_set(s : SignalwindowblackmanEdge, i : Int, v : Double) -> SignalwindowblackmanEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_window_blackman_edge_sum(s : SignalwindowblackmanEdge) -> Double { @_common.sum(s.data) }

pub fn signal_window_blackman_edge_mean(s : SignalwindowblackmanEdge) -> Double { @_common.mean(s.data) }

pub fn signal_window_blackman_edge_scale(s : SignalwindowblackmanEdge, f : Double) -> SignalwindowblackmanEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_window_blackman_edge_add(a : SignalwindowblackmanEdge, b : SignalwindowblackmanEdge) -> SignalwindowblackmanEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_window_blackman_edge_copy(s : SignalwindowblackmanEdge) -> SignalwindowblackmanEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_window_blackman_edge_fill(s : SignalwindowblackmanEdge, v : Double) -> SignalwindowblackmanEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_window_blackman_edge_min(s : SignalwindowblackmanEdge) -> Double { @_common.min(s.data) }

pub fn signal_window_blackman_edge_max(s : SignalwindowblackmanEdge) -> Double { @_common.max(s.data) }

pub fn signal_window_blackman_edge_to_string(s : SignalwindowblackmanEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalwindowblackmanPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_window_blackman_path_make(size : Int) -> SignalwindowblackmanPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_window_blackman_path_len(s : SignalwindowblackmanPath) -> Int { s.size }

pub fn signal_window_blackman_path_get(s : SignalwindowblackmanPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_window_blackman_path_set(s : SignalwindowblackmanPath, i : Int, v : Double) -> SignalwindowblackmanPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_window_blackman_path_sum(s : SignalwindowblackmanPath) -> Double { @_common.sum(s.data) }

pub fn signal_window_blackman_path_mean(s : SignalwindowblackmanPath) -> Double { @_common.mean(s.data) }

pub fn signal_window_blackman_path_scale(s : SignalwindowblackmanPath, f : Double) -> SignalwindowblackmanPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_window_blackman_path_add(a : SignalwindowblackmanPath, b : SignalwindowblackmanPath) -> SignalwindowblackmanPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_window_blackman_path_copy(s : SignalwindowblackmanPath) -> SignalwindowblackmanPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_window_blackman_path_fill(s : SignalwindowblackmanPath, v : Double) -> SignalwindowblackmanPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_window_blackman_path_min(s : SignalwindowblackmanPath) -> Double { @_common.min(s.data) }

pub fn signal_window_blackman_path_max(s : SignalwindowblackmanPath) -> Double { @_common.max(s.data) }

pub fn signal_window_blackman_path_to_string(s : SignalwindowblackmanPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalwindowblackmanCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_window_blackman_cluster_make(size : Int) -> SignalwindowblackmanCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_window_blackman_cluster_len(s : SignalwindowblackmanCluster) -> Int { s.size }

pub fn signal_window_blackman_cluster_get(s : SignalwindowblackmanCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_window_blackman_cluster_set(s : SignalwindowblackmanCluster, i : Int, v : Double) -> SignalwindowblackmanCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_window_blackman_cluster_sum(s : SignalwindowblackmanCluster) -> Double { @_common.sum(s.data) }

pub fn signal_window_blackman_cluster_mean(s : SignalwindowblackmanCluster) -> Double { @_common.mean(s.data) }

pub fn signal_window_blackman_cluster_scale(s : SignalwindowblackmanCluster, f : Double) -> SignalwindowblackmanCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_window_blackman_cluster_add(a : SignalwindowblackmanCluster, b : SignalwindowblackmanCluster) -> SignalwindowblackmanCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_window_blackman_cluster_copy(s : SignalwindowblackmanCluster) -> SignalwindowblackmanCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_window_blackman_cluster_fill(s : SignalwindowblackmanCluster, v : Double) -> SignalwindowblackmanCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_window_blackman_cluster_min(s : SignalwindowblackmanCluster) -> Double { @_common.min(s.data) }

pub fn signal_window_blackman_cluster_max(s : SignalwindowblackmanCluster) -> Double { @_common.max(s.data) }

pub fn signal_window_blackman_cluster_to_string(s : SignalwindowblackmanCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalwindowblackmanModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_window_blackman_model_make(size : Int) -> SignalwindowblackmanModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_window_blackman_model_len(s : SignalwindowblackmanModel) -> Int { s.size }

pub fn signal_window_blackman_model_get(s : SignalwindowblackmanModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_window_blackman_model_set(s : SignalwindowblackmanModel, i : Int, v : Double) -> SignalwindowblackmanModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_window_blackman_model_sum(s : SignalwindowblackmanModel) -> Double { @_common.sum(s.data) }

pub fn signal_window_blackman_model_mean(s : SignalwindowblackmanModel) -> Double { @_common.mean(s.data) }

pub fn signal_window_blackman_model_scale(s : SignalwindowblackmanModel, f : Double) -> SignalwindowblackmanModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_window_blackman_model_add(a : SignalwindowblackmanModel, b : SignalwindowblackmanModel) -> SignalwindowblackmanModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_window_blackman_model_copy(s : SignalwindowblackmanModel) -> SignalwindowblackmanModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_window_blackman_model_fill(s : SignalwindowblackmanModel, v : Double) -> SignalwindowblackmanModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_window_blackman_model_min(s : SignalwindowblackmanModel) -> Double { @_common.min(s.data) }

pub fn signal_window_blackman_model_max(s : SignalwindowblackmanModel) -> Double { @_common.max(s.data) }

pub fn signal_window_blackman_model_to_string(s : SignalwindowblackmanModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalwindowblackmanLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_window_blackman_layer_make(size : Int) -> SignalwindowblackmanLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_window_blackman_layer_len(s : SignalwindowblackmanLayer) -> Int { s.size }

pub fn signal_window_blackman_layer_get(s : SignalwindowblackmanLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_window_blackman_layer_set(s : SignalwindowblackmanLayer, i : Int, v : Double) -> SignalwindowblackmanLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_window_blackman_layer_sum(s : SignalwindowblackmanLayer) -> Double { @_common.sum(s.data) }

pub fn signal_window_blackman_layer_mean(s : SignalwindowblackmanLayer) -> Double { @_common.mean(s.data) }

pub fn signal_window_blackman_layer_scale(s : SignalwindowblackmanLayer, f : Double) -> SignalwindowblackmanLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_window_blackman_layer_add(a : SignalwindowblackmanLayer, b : SignalwindowblackmanLayer) -> SignalwindowblackmanLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_window_blackman_layer_copy(s : SignalwindowblackmanLayer) -> SignalwindowblackmanLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_window_blackman_layer_fill(s : SignalwindowblackmanLayer, v : Double) -> SignalwindowblackmanLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_window_blackman_layer_min(s : SignalwindowblackmanLayer) -> Double { @_common.min(s.data) }

pub fn signal_window_blackman_layer_max(s : SignalwindowblackmanLayer) -> Double { @_common.max(s.data) }

pub fn signal_window_blackman_layer_to_string(s : SignalwindowblackmanLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalwindowblackmanBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_window_blackman_buffer_make(size : Int) -> SignalwindowblackmanBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_window_blackman_buffer_len(s : SignalwindowblackmanBuffer) -> Int { s.size }

pub fn signal_window_blackman_buffer_get(s : SignalwindowblackmanBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_window_blackman_buffer_set(s : SignalwindowblackmanBuffer, i : Int, v : Double) -> SignalwindowblackmanBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_window_blackman_buffer_sum(s : SignalwindowblackmanBuffer) -> Double { @_common.sum(s.data) }

pub fn signal_window_blackman_buffer_mean(s : SignalwindowblackmanBuffer) -> Double { @_common.mean(s.data) }

pub fn signal_window_blackman_buffer_scale(s : SignalwindowblackmanBuffer, f : Double) -> SignalwindowblackmanBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_window_blackman_buffer_add(a : SignalwindowblackmanBuffer, b : SignalwindowblackmanBuffer) -> SignalwindowblackmanBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_window_blackman_buffer_copy(s : SignalwindowblackmanBuffer) -> SignalwindowblackmanBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_window_blackman_buffer_fill(s : SignalwindowblackmanBuffer, v : Double) -> SignalwindowblackmanBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_window_blackman_buffer_min(s : SignalwindowblackmanBuffer) -> Double { @_common.min(s.data) }

pub fn signal_window_blackman_buffer_max(s : SignalwindowblackmanBuffer) -> Double { @_common.max(s.data) }

pub fn signal_window_blackman_buffer_to_string(s : SignalwindowblackmanBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalwindowblackmanCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_window_blackman_cursor_make(size : Int) -> SignalwindowblackmanCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_window_blackman_cursor_len(s : SignalwindowblackmanCursor) -> Int { s.size }

pub fn signal_window_blackman_cursor_get(s : SignalwindowblackmanCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_window_blackman_cursor_set(s : SignalwindowblackmanCursor, i : Int, v : Double) -> SignalwindowblackmanCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_window_blackman_cursor_sum(s : SignalwindowblackmanCursor) -> Double { @_common.sum(s.data) }

pub fn signal_window_blackman_cursor_mean(s : SignalwindowblackmanCursor) -> Double { @_common.mean(s.data) }

pub fn signal_window_blackman_cursor_scale(s : SignalwindowblackmanCursor, f : Double) -> SignalwindowblackmanCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_window_blackman_cursor_add(a : SignalwindowblackmanCursor, b : SignalwindowblackmanCursor) -> SignalwindowblackmanCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_window_blackman_cursor_copy(s : SignalwindowblackmanCursor) -> SignalwindowblackmanCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_window_blackman_cursor_fill(s : SignalwindowblackmanCursor, v : Double) -> SignalwindowblackmanCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_window_blackman_cursor_min(s : SignalwindowblackmanCursor) -> Double { @_common.min(s.data) }

pub fn signal_window_blackman_cursor_max(s : SignalwindowblackmanCursor) -> Double { @_common.max(s.data) }

pub fn signal_window_blackman_cursor_to_string(s : SignalwindowblackmanCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalwindowblackmanView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_window_blackman_view_make(size : Int) -> SignalwindowblackmanView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_window_blackman_view_len(s : SignalwindowblackmanView) -> Int { s.size }

pub fn signal_window_blackman_view_get(s : SignalwindowblackmanView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_window_blackman_view_set(s : SignalwindowblackmanView, i : Int, v : Double) -> SignalwindowblackmanView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_window_blackman_view_sum(s : SignalwindowblackmanView) -> Double { @_common.sum(s.data) }

pub fn signal_window_blackman_view_mean(s : SignalwindowblackmanView) -> Double { @_common.mean(s.data) }

pub fn signal_window_blackman_view_scale(s : SignalwindowblackmanView, f : Double) -> SignalwindowblackmanView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_window_blackman_view_add(a : SignalwindowblackmanView, b : SignalwindowblackmanView) -> SignalwindowblackmanView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_window_blackman_view_copy(s : SignalwindowblackmanView) -> SignalwindowblackmanView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_window_blackman_view_fill(s : SignalwindowblackmanView, v : Double) -> SignalwindowblackmanView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_window_blackman_view_min(s : SignalwindowblackmanView) -> Double { @_common.min(s.data) }

pub fn signal_window_blackman_view_max(s : SignalwindowblackmanView) -> Double { @_common.max(s.data) }

pub fn signal_window_blackman_view_to_string(s : SignalwindowblackmanView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalwindowblackmanRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_window_blackman_range_make(size : Int) -> SignalwindowblackmanRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_window_blackman_range_len(s : SignalwindowblackmanRange) -> Int { s.size }

pub fn signal_window_blackman_range_get(s : SignalwindowblackmanRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_window_blackman_range_set(s : SignalwindowblackmanRange, i : Int, v : Double) -> SignalwindowblackmanRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_window_blackman_range_sum(s : SignalwindowblackmanRange) -> Double { @_common.sum(s.data) }

pub fn signal_window_blackman_range_mean(s : SignalwindowblackmanRange) -> Double { @_common.mean(s.data) }

pub fn signal_window_blackman_range_scale(s : SignalwindowblackmanRange, f : Double) -> SignalwindowblackmanRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_window_blackman_range_add(a : SignalwindowblackmanRange, b : SignalwindowblackmanRange) -> SignalwindowblackmanRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_window_blackman_range_copy(s : SignalwindowblackmanRange) -> SignalwindowblackmanRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_window_blackman_range_fill(s : SignalwindowblackmanRange, v : Double) -> SignalwindowblackmanRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_window_blackman_range_min(s : SignalwindowblackmanRange) -> Double { @_common.min(s.data) }

pub fn signal_window_blackman_range_max(s : SignalwindowblackmanRange) -> Double { @_common.max(s.data) }

pub fn signal_window_blackman_range_to_string(s : SignalwindowblackmanRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalwindowblackmanSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_window_blackman_slice_make(size : Int) -> SignalwindowblackmanSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_window_blackman_slice_len(s : SignalwindowblackmanSlice) -> Int { s.size }

pub fn signal_window_blackman_slice_get(s : SignalwindowblackmanSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_window_blackman_slice_set(s : SignalwindowblackmanSlice, i : Int, v : Double) -> SignalwindowblackmanSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_window_blackman_slice_sum(s : SignalwindowblackmanSlice) -> Double { @_common.sum(s.data) }

pub fn signal_window_blackman_slice_mean(s : SignalwindowblackmanSlice) -> Double { @_common.mean(s.data) }

pub fn signal_window_blackman_slice_scale(s : SignalwindowblackmanSlice, f : Double) -> SignalwindowblackmanSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_window_blackman_slice_add(a : SignalwindowblackmanSlice, b : SignalwindowblackmanSlice) -> SignalwindowblackmanSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_window_blackman_slice_copy(s : SignalwindowblackmanSlice) -> SignalwindowblackmanSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_window_blackman_slice_fill(s : SignalwindowblackmanSlice, v : Double) -> SignalwindowblackmanSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_window_blackman_slice_min(s : SignalwindowblackmanSlice) -> Double { @_common.min(s.data) }

pub fn signal_window_blackman_slice_max(s : SignalwindowblackmanSlice) -> Double { @_common.max(s.data) }

pub fn signal_window_blackman_slice_to_string(s : SignalwindowblackmanSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

