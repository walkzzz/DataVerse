///===
/// extcore/signal_window_tukey

pub(all) struct SignalwindowtukeyPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn signal_window_tukey_make_point(x : Double, y : Double) -> SignalwindowtukeyPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn signal_window_tukey_make_point3(x : Double, y : Double, z : Double) -> SignalwindowtukeyPoint {
  { x, y, z, label: 0 }
}

pub fn SignalwindowtukeyPoint::x(self : SignalwindowtukeyPoint) -> Double { self.x }

pub fn SignalwindowtukeyPoint::y(self : SignalwindowtukeyPoint) -> Double { self.y }

pub fn SignalwindowtukeyPoint::z(self : SignalwindowtukeyPoint) -> Double { self.z }

pub fn SignalwindowtukeyPoint::label(self : SignalwindowtukeyPoint) -> Int { self.label }

pub fn SignalwindowtukeyPoint::dist(self : SignalwindowtukeyPoint, other : SignalwindowtukeyPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn SignalwindowtukeyPoint::add(self : SignalwindowtukeyPoint, other : SignalwindowtukeyPoint) -> SignalwindowtukeyPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn SignalwindowtukeyPoint::sub(self : SignalwindowtukeyPoint, other : SignalwindowtukeyPoint) -> SignalwindowtukeyPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn SignalwindowtukeyPoint::scale(self : SignalwindowtukeyPoint, s : Double) -> SignalwindowtukeyPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn SignalwindowtukeyPoint::dot(self : SignalwindowtukeyPoint, other : SignalwindowtukeyPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn SignalwindowtukeyPoint::cross(self : SignalwindowtukeyPoint, other : SignalwindowtukeyPoint) -> SignalwindowtukeyPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn SignalwindowtukeyPoint::norm(self : SignalwindowtukeyPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn SignalwindowtukeyPoint::normalize(self : SignalwindowtukeyPoint) -> SignalwindowtukeyPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn SignalwindowtukeyPoint::negate(self : SignalwindowtukeyPoint) -> SignalwindowtukeyPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn SignalwindowtukeyPoint::mid(self : SignalwindowtukeyPoint, other : SignalwindowtukeyPoint) -> SignalwindowtukeyPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn SignalwindowtukeyPoint::lerp(self : SignalwindowtukeyPoint, other : SignalwindowtukeyPoint, t : Double) -> SignalwindowtukeyPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn SignalwindowtukeyPoint::to_string(self : SignalwindowtukeyPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct SignalwindowtukeySeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn signal_window_tukey_make_series(vals : Array[Double], name : String) -> SignalwindowtukeySeries {
  { vals, name, meta: 0 }
}

pub fn SignalwindowtukeySeries::len(self : SignalwindowtukeySeries) -> Int { self.vals.length() }

pub fn SignalwindowtukeySeries::sum(self : SignalwindowtukeySeries) -> Double { @_common.sum(self.vals) }

pub fn SignalwindowtukeySeries::mean(self : SignalwindowtukeySeries) -> Double { @_common.mean(self.vals) }

pub fn SignalwindowtukeySeries::min(self : SignalwindowtukeySeries) -> Double { @_common.min(self.vals) }

pub fn SignalwindowtukeySeries::max(self : SignalwindowtukeySeries) -> Double { @_common.max(self.vals) }

pub fn SignalwindowtukeySeries::range(self : SignalwindowtukeySeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn SignalwindowtukeySeries::variance(self : SignalwindowtukeySeries) -> Double { @_common.variance(self.vals) }

pub fn SignalwindowtukeySeries::std(self : SignalwindowtukeySeries) -> Double { @_common.std(self.vals) }

pub fn SignalwindowtukeySeries::median(self : SignalwindowtukeySeries) -> Double { @_common.median(self.vals) }

pub fn SignalwindowtukeySeries::scale(self : SignalwindowtukeySeries, f : Double) -> SignalwindowtukeySeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn SignalwindowtukeySeries::add(self : SignalwindowtukeySeries, other : SignalwindowtukeySeries) -> SignalwindowtukeySeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn SignalwindowtukeySeries::sub(self : SignalwindowtukeySeries, other : SignalwindowtukeySeries) -> SignalwindowtukeySeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn SignalwindowtukeySeries::normalize(self : SignalwindowtukeySeries) -> SignalwindowtukeySeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn SignalwindowtukeySeries::cumsum(self : SignalwindowtukeySeries) -> SignalwindowtukeySeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn SignalwindowtukeySeries::to_string(self : SignalwindowtukeySeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct SignalwindowtukeyMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn signal_window_tukey_make_matrix(rows : Int, cols : Int, val : Double) -> SignalwindowtukeyMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn signal_window_tukey_matrix_identity(n : Int) -> SignalwindowtukeyMatrix {
  let m = signal_window_tukey_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn SignalwindowtukeyMatrix::get(self : SignalwindowtukeyMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn SignalwindowtukeyMatrix::transpose(self : SignalwindowtukeyMatrix) -> SignalwindowtukeyMatrix {
  let result = signal_window_tukey_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn SignalwindowtukeyMatrix::add(self : SignalwindowtukeyMatrix, other : SignalwindowtukeyMatrix) -> SignalwindowtukeyMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = signal_window_tukey_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn SignalwindowtukeyMatrix::scale(self : SignalwindowtukeyMatrix, s : Double) -> SignalwindowtukeyMatrix {
  let result = signal_window_tukey_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn SignalwindowtukeyMatrix::multiply(self : SignalwindowtukeyMatrix, other : SignalwindowtukeyMatrix) -> SignalwindowtukeyMatrix {
  if self.cols != other.rows { return signal_window_tukey_make_matrix(self.rows, other.cols, 0.0) }
  let result = signal_window_tukey_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn SignalwindowtukeyMatrix::trace(self : SignalwindowtukeyMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn SignalwindowtukeyMatrix::det(self : SignalwindowtukeyMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn SignalwindowtukeyMatrix::norm(self : SignalwindowtukeyMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn SignalwindowtukeyMatrix::to_string(self : SignalwindowtukeyMatrix) -> String {
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

pub(all) struct SignalwindowtukeyVector {
  comps : Array[Double]
  dim : Int
}

pub fn signal_window_tukey_make_vector(comps : Array[Double]) -> SignalwindowtukeyVector {
  { comps, dim: comps.length() }
}

pub fn signal_window_tukey_vector_zero(dim : Int) -> SignalwindowtukeyVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn SignalwindowtukeyVector::add(self : SignalwindowtukeyVector, other : SignalwindowtukeyVector) -> SignalwindowtukeyVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn SignalwindowtukeyVector::sub(self : SignalwindowtukeyVector, other : SignalwindowtukeyVector) -> SignalwindowtukeyVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn SignalwindowtukeyVector::scale(self : SignalwindowtukeyVector, s : Double) -> SignalwindowtukeyVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn SignalwindowtukeyVector::dot(self : SignalwindowtukeyVector, other : SignalwindowtukeyVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn SignalwindowtukeyVector::norm(self : SignalwindowtukeyVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn SignalwindowtukeyVector::normalize(self : SignalwindowtukeyVector) -> SignalwindowtukeyVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn SignalwindowtukeyVector::dist(self : SignalwindowtukeyVector, other : SignalwindowtukeyVector) -> Double {
  self.sub(other).norm()
}

pub fn SignalwindowtukeyVector::to_string(self : SignalwindowtukeyVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn signal_window_tukey_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn signal_window_tukey_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn signal_window_tukey_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn signal_window_tukey_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn signal_window_tukey_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn signal_window_tukey_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn signal_window_tukey_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn signal_window_tukey_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn signal_window_tukey_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn signal_window_tukey_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn signal_window_tukey_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn signal_window_tukey_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn signal_window_tukey_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn signal_window_tukey_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn signal_window_tukey_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn signal_window_tukey_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn signal_window_tukey_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn signal_window_tukey_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn signal_window_tukey_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn signal_window_tukey_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn signal_window_tukey_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn signal_window_tukey_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn signal_window_tukey_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn signal_window_tukey_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn signal_window_tukey_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn signal_window_tukey_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn signal_window_tukey_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn signal_window_tukey_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn signal_window_tukey_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct SignalwindowtukeyFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_window_tukey_frame_make(size : Int) -> SignalwindowtukeyFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_window_tukey_frame_len(s : SignalwindowtukeyFrame) -> Int { s.size }

pub fn signal_window_tukey_frame_get(s : SignalwindowtukeyFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_window_tukey_frame_set(s : SignalwindowtukeyFrame, i : Int, v : Double) -> SignalwindowtukeyFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_window_tukey_frame_sum(s : SignalwindowtukeyFrame) -> Double { @_common.sum(s.data) }

pub fn signal_window_tukey_frame_mean(s : SignalwindowtukeyFrame) -> Double { @_common.mean(s.data) }

pub fn signal_window_tukey_frame_scale(s : SignalwindowtukeyFrame, f : Double) -> SignalwindowtukeyFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_window_tukey_frame_add(a : SignalwindowtukeyFrame, b : SignalwindowtukeyFrame) -> SignalwindowtukeyFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_window_tukey_frame_copy(s : SignalwindowtukeyFrame) -> SignalwindowtukeyFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_window_tukey_frame_fill(s : SignalwindowtukeyFrame, v : Double) -> SignalwindowtukeyFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_window_tukey_frame_min(s : SignalwindowtukeyFrame) -> Double { @_common.min(s.data) }

pub fn signal_window_tukey_frame_max(s : SignalwindowtukeyFrame) -> Double { @_common.max(s.data) }

pub fn signal_window_tukey_frame_to_string(s : SignalwindowtukeyFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalwindowtukeyTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_window_tukey_table_make(size : Int) -> SignalwindowtukeyTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_window_tukey_table_len(s : SignalwindowtukeyTable) -> Int { s.size }

pub fn signal_window_tukey_table_get(s : SignalwindowtukeyTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_window_tukey_table_set(s : SignalwindowtukeyTable, i : Int, v : Double) -> SignalwindowtukeyTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_window_tukey_table_sum(s : SignalwindowtukeyTable) -> Double { @_common.sum(s.data) }

pub fn signal_window_tukey_table_mean(s : SignalwindowtukeyTable) -> Double { @_common.mean(s.data) }

pub fn signal_window_tukey_table_scale(s : SignalwindowtukeyTable, f : Double) -> SignalwindowtukeyTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_window_tukey_table_add(a : SignalwindowtukeyTable, b : SignalwindowtukeyTable) -> SignalwindowtukeyTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_window_tukey_table_copy(s : SignalwindowtukeyTable) -> SignalwindowtukeyTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_window_tukey_table_fill(s : SignalwindowtukeyTable, v : Double) -> SignalwindowtukeyTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_window_tukey_table_min(s : SignalwindowtukeyTable) -> Double { @_common.min(s.data) }

pub fn signal_window_tukey_table_max(s : SignalwindowtukeyTable) -> Double { @_common.max(s.data) }

pub fn signal_window_tukey_table_to_string(s : SignalwindowtukeyTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalwindowtukeyGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_window_tukey_graphn_make(size : Int) -> SignalwindowtukeyGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_window_tukey_graphn_len(s : SignalwindowtukeyGraphN) -> Int { s.size }

pub fn signal_window_tukey_graphn_get(s : SignalwindowtukeyGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_window_tukey_graphn_set(s : SignalwindowtukeyGraphN, i : Int, v : Double) -> SignalwindowtukeyGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_window_tukey_graphn_sum(s : SignalwindowtukeyGraphN) -> Double { @_common.sum(s.data) }

pub fn signal_window_tukey_graphn_mean(s : SignalwindowtukeyGraphN) -> Double { @_common.mean(s.data) }

pub fn signal_window_tukey_graphn_scale(s : SignalwindowtukeyGraphN, f : Double) -> SignalwindowtukeyGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_window_tukey_graphn_add(a : SignalwindowtukeyGraphN, b : SignalwindowtukeyGraphN) -> SignalwindowtukeyGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_window_tukey_graphn_copy(s : SignalwindowtukeyGraphN) -> SignalwindowtukeyGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_window_tukey_graphn_fill(s : SignalwindowtukeyGraphN, v : Double) -> SignalwindowtukeyGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_window_tukey_graphn_min(s : SignalwindowtukeyGraphN) -> Double { @_common.min(s.data) }

pub fn signal_window_tukey_graphn_max(s : SignalwindowtukeyGraphN) -> Double { @_common.max(s.data) }

pub fn signal_window_tukey_graphn_to_string(s : SignalwindowtukeyGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalwindowtukeyNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_window_tukey_node_make(size : Int) -> SignalwindowtukeyNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_window_tukey_node_len(s : SignalwindowtukeyNode) -> Int { s.size }

pub fn signal_window_tukey_node_get(s : SignalwindowtukeyNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_window_tukey_node_set(s : SignalwindowtukeyNode, i : Int, v : Double) -> SignalwindowtukeyNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_window_tukey_node_sum(s : SignalwindowtukeyNode) -> Double { @_common.sum(s.data) }

pub fn signal_window_tukey_node_mean(s : SignalwindowtukeyNode) -> Double { @_common.mean(s.data) }

pub fn signal_window_tukey_node_scale(s : SignalwindowtukeyNode, f : Double) -> SignalwindowtukeyNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_window_tukey_node_add(a : SignalwindowtukeyNode, b : SignalwindowtukeyNode) -> SignalwindowtukeyNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_window_tukey_node_copy(s : SignalwindowtukeyNode) -> SignalwindowtukeyNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_window_tukey_node_fill(s : SignalwindowtukeyNode, v : Double) -> SignalwindowtukeyNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_window_tukey_node_min(s : SignalwindowtukeyNode) -> Double { @_common.min(s.data) }

pub fn signal_window_tukey_node_max(s : SignalwindowtukeyNode) -> Double { @_common.max(s.data) }

pub fn signal_window_tukey_node_to_string(s : SignalwindowtukeyNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalwindowtukeyEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_window_tukey_edge_make(size : Int) -> SignalwindowtukeyEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_window_tukey_edge_len(s : SignalwindowtukeyEdge) -> Int { s.size }

pub fn signal_window_tukey_edge_get(s : SignalwindowtukeyEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_window_tukey_edge_set(s : SignalwindowtukeyEdge, i : Int, v : Double) -> SignalwindowtukeyEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_window_tukey_edge_sum(s : SignalwindowtukeyEdge) -> Double { @_common.sum(s.data) }

pub fn signal_window_tukey_edge_mean(s : SignalwindowtukeyEdge) -> Double { @_common.mean(s.data) }

pub fn signal_window_tukey_edge_scale(s : SignalwindowtukeyEdge, f : Double) -> SignalwindowtukeyEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_window_tukey_edge_add(a : SignalwindowtukeyEdge, b : SignalwindowtukeyEdge) -> SignalwindowtukeyEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_window_tukey_edge_copy(s : SignalwindowtukeyEdge) -> SignalwindowtukeyEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_window_tukey_edge_fill(s : SignalwindowtukeyEdge, v : Double) -> SignalwindowtukeyEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_window_tukey_edge_min(s : SignalwindowtukeyEdge) -> Double { @_common.min(s.data) }

pub fn signal_window_tukey_edge_max(s : SignalwindowtukeyEdge) -> Double { @_common.max(s.data) }

pub fn signal_window_tukey_edge_to_string(s : SignalwindowtukeyEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalwindowtukeyPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_window_tukey_path_make(size : Int) -> SignalwindowtukeyPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_window_tukey_path_len(s : SignalwindowtukeyPath) -> Int { s.size }

pub fn signal_window_tukey_path_get(s : SignalwindowtukeyPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_window_tukey_path_set(s : SignalwindowtukeyPath, i : Int, v : Double) -> SignalwindowtukeyPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_window_tukey_path_sum(s : SignalwindowtukeyPath) -> Double { @_common.sum(s.data) }

pub fn signal_window_tukey_path_mean(s : SignalwindowtukeyPath) -> Double { @_common.mean(s.data) }

pub fn signal_window_tukey_path_scale(s : SignalwindowtukeyPath, f : Double) -> SignalwindowtukeyPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_window_tukey_path_add(a : SignalwindowtukeyPath, b : SignalwindowtukeyPath) -> SignalwindowtukeyPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_window_tukey_path_copy(s : SignalwindowtukeyPath) -> SignalwindowtukeyPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_window_tukey_path_fill(s : SignalwindowtukeyPath, v : Double) -> SignalwindowtukeyPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_window_tukey_path_min(s : SignalwindowtukeyPath) -> Double { @_common.min(s.data) }

pub fn signal_window_tukey_path_max(s : SignalwindowtukeyPath) -> Double { @_common.max(s.data) }

pub fn signal_window_tukey_path_to_string(s : SignalwindowtukeyPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalwindowtukeyCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_window_tukey_cluster_make(size : Int) -> SignalwindowtukeyCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_window_tukey_cluster_len(s : SignalwindowtukeyCluster) -> Int { s.size }

pub fn signal_window_tukey_cluster_get(s : SignalwindowtukeyCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_window_tukey_cluster_set(s : SignalwindowtukeyCluster, i : Int, v : Double) -> SignalwindowtukeyCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_window_tukey_cluster_sum(s : SignalwindowtukeyCluster) -> Double { @_common.sum(s.data) }

pub fn signal_window_tukey_cluster_mean(s : SignalwindowtukeyCluster) -> Double { @_common.mean(s.data) }

pub fn signal_window_tukey_cluster_scale(s : SignalwindowtukeyCluster, f : Double) -> SignalwindowtukeyCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_window_tukey_cluster_add(a : SignalwindowtukeyCluster, b : SignalwindowtukeyCluster) -> SignalwindowtukeyCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_window_tukey_cluster_copy(s : SignalwindowtukeyCluster) -> SignalwindowtukeyCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_window_tukey_cluster_fill(s : SignalwindowtukeyCluster, v : Double) -> SignalwindowtukeyCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_window_tukey_cluster_min(s : SignalwindowtukeyCluster) -> Double { @_common.min(s.data) }

pub fn signal_window_tukey_cluster_max(s : SignalwindowtukeyCluster) -> Double { @_common.max(s.data) }

pub fn signal_window_tukey_cluster_to_string(s : SignalwindowtukeyCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalwindowtukeyModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_window_tukey_model_make(size : Int) -> SignalwindowtukeyModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_window_tukey_model_len(s : SignalwindowtukeyModel) -> Int { s.size }

pub fn signal_window_tukey_model_get(s : SignalwindowtukeyModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_window_tukey_model_set(s : SignalwindowtukeyModel, i : Int, v : Double) -> SignalwindowtukeyModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_window_tukey_model_sum(s : SignalwindowtukeyModel) -> Double { @_common.sum(s.data) }

pub fn signal_window_tukey_model_mean(s : SignalwindowtukeyModel) -> Double { @_common.mean(s.data) }

pub fn signal_window_tukey_model_scale(s : SignalwindowtukeyModel, f : Double) -> SignalwindowtukeyModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_window_tukey_model_add(a : SignalwindowtukeyModel, b : SignalwindowtukeyModel) -> SignalwindowtukeyModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_window_tukey_model_copy(s : SignalwindowtukeyModel) -> SignalwindowtukeyModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_window_tukey_model_fill(s : SignalwindowtukeyModel, v : Double) -> SignalwindowtukeyModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_window_tukey_model_min(s : SignalwindowtukeyModel) -> Double { @_common.min(s.data) }

pub fn signal_window_tukey_model_max(s : SignalwindowtukeyModel) -> Double { @_common.max(s.data) }

pub fn signal_window_tukey_model_to_string(s : SignalwindowtukeyModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalwindowtukeyLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_window_tukey_layer_make(size : Int) -> SignalwindowtukeyLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_window_tukey_layer_len(s : SignalwindowtukeyLayer) -> Int { s.size }

pub fn signal_window_tukey_layer_get(s : SignalwindowtukeyLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_window_tukey_layer_set(s : SignalwindowtukeyLayer, i : Int, v : Double) -> SignalwindowtukeyLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_window_tukey_layer_sum(s : SignalwindowtukeyLayer) -> Double { @_common.sum(s.data) }

pub fn signal_window_tukey_layer_mean(s : SignalwindowtukeyLayer) -> Double { @_common.mean(s.data) }

pub fn signal_window_tukey_layer_scale(s : SignalwindowtukeyLayer, f : Double) -> SignalwindowtukeyLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_window_tukey_layer_add(a : SignalwindowtukeyLayer, b : SignalwindowtukeyLayer) -> SignalwindowtukeyLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_window_tukey_layer_copy(s : SignalwindowtukeyLayer) -> SignalwindowtukeyLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_window_tukey_layer_fill(s : SignalwindowtukeyLayer, v : Double) -> SignalwindowtukeyLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_window_tukey_layer_min(s : SignalwindowtukeyLayer) -> Double { @_common.min(s.data) }

pub fn signal_window_tukey_layer_max(s : SignalwindowtukeyLayer) -> Double { @_common.max(s.data) }

pub fn signal_window_tukey_layer_to_string(s : SignalwindowtukeyLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalwindowtukeyBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_window_tukey_buffer_make(size : Int) -> SignalwindowtukeyBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_window_tukey_buffer_len(s : SignalwindowtukeyBuffer) -> Int { s.size }

pub fn signal_window_tukey_buffer_get(s : SignalwindowtukeyBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_window_tukey_buffer_set(s : SignalwindowtukeyBuffer, i : Int, v : Double) -> SignalwindowtukeyBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_window_tukey_buffer_sum(s : SignalwindowtukeyBuffer) -> Double { @_common.sum(s.data) }

pub fn signal_window_tukey_buffer_mean(s : SignalwindowtukeyBuffer) -> Double { @_common.mean(s.data) }

pub fn signal_window_tukey_buffer_scale(s : SignalwindowtukeyBuffer, f : Double) -> SignalwindowtukeyBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_window_tukey_buffer_add(a : SignalwindowtukeyBuffer, b : SignalwindowtukeyBuffer) -> SignalwindowtukeyBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_window_tukey_buffer_copy(s : SignalwindowtukeyBuffer) -> SignalwindowtukeyBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_window_tukey_buffer_fill(s : SignalwindowtukeyBuffer, v : Double) -> SignalwindowtukeyBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_window_tukey_buffer_min(s : SignalwindowtukeyBuffer) -> Double { @_common.min(s.data) }

pub fn signal_window_tukey_buffer_max(s : SignalwindowtukeyBuffer) -> Double { @_common.max(s.data) }

pub fn signal_window_tukey_buffer_to_string(s : SignalwindowtukeyBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalwindowtukeyCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_window_tukey_cursor_make(size : Int) -> SignalwindowtukeyCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_window_tukey_cursor_len(s : SignalwindowtukeyCursor) -> Int { s.size }

pub fn signal_window_tukey_cursor_get(s : SignalwindowtukeyCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_window_tukey_cursor_set(s : SignalwindowtukeyCursor, i : Int, v : Double) -> SignalwindowtukeyCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_window_tukey_cursor_sum(s : SignalwindowtukeyCursor) -> Double { @_common.sum(s.data) }

pub fn signal_window_tukey_cursor_mean(s : SignalwindowtukeyCursor) -> Double { @_common.mean(s.data) }

pub fn signal_window_tukey_cursor_scale(s : SignalwindowtukeyCursor, f : Double) -> SignalwindowtukeyCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_window_tukey_cursor_add(a : SignalwindowtukeyCursor, b : SignalwindowtukeyCursor) -> SignalwindowtukeyCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_window_tukey_cursor_copy(s : SignalwindowtukeyCursor) -> SignalwindowtukeyCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_window_tukey_cursor_fill(s : SignalwindowtukeyCursor, v : Double) -> SignalwindowtukeyCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_window_tukey_cursor_min(s : SignalwindowtukeyCursor) -> Double { @_common.min(s.data) }

pub fn signal_window_tukey_cursor_max(s : SignalwindowtukeyCursor) -> Double { @_common.max(s.data) }

pub fn signal_window_tukey_cursor_to_string(s : SignalwindowtukeyCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalwindowtukeyView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_window_tukey_view_make(size : Int) -> SignalwindowtukeyView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_window_tukey_view_len(s : SignalwindowtukeyView) -> Int { s.size }

pub fn signal_window_tukey_view_get(s : SignalwindowtukeyView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_window_tukey_view_set(s : SignalwindowtukeyView, i : Int, v : Double) -> SignalwindowtukeyView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_window_tukey_view_sum(s : SignalwindowtukeyView) -> Double { @_common.sum(s.data) }

pub fn signal_window_tukey_view_mean(s : SignalwindowtukeyView) -> Double { @_common.mean(s.data) }

pub fn signal_window_tukey_view_scale(s : SignalwindowtukeyView, f : Double) -> SignalwindowtukeyView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_window_tukey_view_add(a : SignalwindowtukeyView, b : SignalwindowtukeyView) -> SignalwindowtukeyView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_window_tukey_view_copy(s : SignalwindowtukeyView) -> SignalwindowtukeyView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_window_tukey_view_fill(s : SignalwindowtukeyView, v : Double) -> SignalwindowtukeyView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_window_tukey_view_min(s : SignalwindowtukeyView) -> Double { @_common.min(s.data) }

pub fn signal_window_tukey_view_max(s : SignalwindowtukeyView) -> Double { @_common.max(s.data) }

pub fn signal_window_tukey_view_to_string(s : SignalwindowtukeyView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalwindowtukeyRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_window_tukey_range_make(size : Int) -> SignalwindowtukeyRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_window_tukey_range_len(s : SignalwindowtukeyRange) -> Int { s.size }

pub fn signal_window_tukey_range_get(s : SignalwindowtukeyRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_window_tukey_range_set(s : SignalwindowtukeyRange, i : Int, v : Double) -> SignalwindowtukeyRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_window_tukey_range_sum(s : SignalwindowtukeyRange) -> Double { @_common.sum(s.data) }

pub fn signal_window_tukey_range_mean(s : SignalwindowtukeyRange) -> Double { @_common.mean(s.data) }

pub fn signal_window_tukey_range_scale(s : SignalwindowtukeyRange, f : Double) -> SignalwindowtukeyRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_window_tukey_range_add(a : SignalwindowtukeyRange, b : SignalwindowtukeyRange) -> SignalwindowtukeyRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_window_tukey_range_copy(s : SignalwindowtukeyRange) -> SignalwindowtukeyRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_window_tukey_range_fill(s : SignalwindowtukeyRange, v : Double) -> SignalwindowtukeyRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_window_tukey_range_min(s : SignalwindowtukeyRange) -> Double { @_common.min(s.data) }

pub fn signal_window_tukey_range_max(s : SignalwindowtukeyRange) -> Double { @_common.max(s.data) }

pub fn signal_window_tukey_range_to_string(s : SignalwindowtukeyRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalwindowtukeySlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_window_tukey_slice_make(size : Int) -> SignalwindowtukeySlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_window_tukey_slice_len(s : SignalwindowtukeySlice) -> Int { s.size }

pub fn signal_window_tukey_slice_get(s : SignalwindowtukeySlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_window_tukey_slice_set(s : SignalwindowtukeySlice, i : Int, v : Double) -> SignalwindowtukeySlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_window_tukey_slice_sum(s : SignalwindowtukeySlice) -> Double { @_common.sum(s.data) }

pub fn signal_window_tukey_slice_mean(s : SignalwindowtukeySlice) -> Double { @_common.mean(s.data) }

pub fn signal_window_tukey_slice_scale(s : SignalwindowtukeySlice, f : Double) -> SignalwindowtukeySlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_window_tukey_slice_add(a : SignalwindowtukeySlice, b : SignalwindowtukeySlice) -> SignalwindowtukeySlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_window_tukey_slice_copy(s : SignalwindowtukeySlice) -> SignalwindowtukeySlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_window_tukey_slice_fill(s : SignalwindowtukeySlice, v : Double) -> SignalwindowtukeySlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_window_tukey_slice_min(s : SignalwindowtukeySlice) -> Double { @_common.min(s.data) }

pub fn signal_window_tukey_slice_max(s : SignalwindowtukeySlice) -> Double { @_common.max(s.data) }

pub fn signal_window_tukey_slice_to_string(s : SignalwindowtukeySlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

