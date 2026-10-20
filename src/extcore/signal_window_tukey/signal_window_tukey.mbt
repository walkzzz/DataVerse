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

pub fn SignalwindowtukeyFrame::len(self : SignalwindowtukeyFrame) -> Int { self.size }

pub fn SignalwindowtukeyFrame::get(self : SignalwindowtukeyFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SignalwindowtukeyFrame::set(self : SignalwindowtukeyFrame, i : Int, v : Double) -> SignalwindowtukeyFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SignalwindowtukeyFrame::sum(self : SignalwindowtukeyFrame) -> Double { @_common.sum(self.data) }

pub fn SignalwindowtukeyFrame::mean(self : SignalwindowtukeyFrame) -> Double { @_common.mean(self.data) }

pub fn SignalwindowtukeyFrame::scale(self : SignalwindowtukeyFrame, f : Double) -> SignalwindowtukeyFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SignalwindowtukeyFrame::add(self : SignalwindowtukeyFrame, other : SignalwindowtukeyFrame) -> SignalwindowtukeyFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SignalwindowtukeyFrame::copy(self : SignalwindowtukeyFrame) -> SignalwindowtukeyFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SignalwindowtukeyFrame::fill(self : SignalwindowtukeyFrame, v : Double) -> SignalwindowtukeyFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SignalwindowtukeyFrame::min(self : SignalwindowtukeyFrame) -> Double { @_common.min(self.data) }

pub fn SignalwindowtukeyFrame::max(self : SignalwindowtukeyFrame) -> Double { @_common.max(self.data) }

pub fn SignalwindowtukeyFrame::to_string(self : SignalwindowtukeyFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SignalwindowtukeyTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_window_tukey_table_make(size : Int) -> SignalwindowtukeyTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SignalwindowtukeyTable::len(self : SignalwindowtukeyTable) -> Int { self.size }

pub fn SignalwindowtukeyTable::get(self : SignalwindowtukeyTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SignalwindowtukeyTable::set(self : SignalwindowtukeyTable, i : Int, v : Double) -> SignalwindowtukeyTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SignalwindowtukeyTable::sum(self : SignalwindowtukeyTable) -> Double { @_common.sum(self.data) }

pub fn SignalwindowtukeyTable::mean(self : SignalwindowtukeyTable) -> Double { @_common.mean(self.data) }

pub fn SignalwindowtukeyTable::scale(self : SignalwindowtukeyTable, f : Double) -> SignalwindowtukeyTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SignalwindowtukeyTable::add(self : SignalwindowtukeyTable, other : SignalwindowtukeyTable) -> SignalwindowtukeyTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SignalwindowtukeyTable::copy(self : SignalwindowtukeyTable) -> SignalwindowtukeyTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SignalwindowtukeyTable::fill(self : SignalwindowtukeyTable, v : Double) -> SignalwindowtukeyTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SignalwindowtukeyTable::min(self : SignalwindowtukeyTable) -> Double { @_common.min(self.data) }

pub fn SignalwindowtukeyTable::max(self : SignalwindowtukeyTable) -> Double { @_common.max(self.data) }

pub fn SignalwindowtukeyTable::to_string(self : SignalwindowtukeyTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SignalwindowtukeyGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_window_tukey_graphn_make(size : Int) -> SignalwindowtukeyGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SignalwindowtukeyGraphN::len(self : SignalwindowtukeyGraphN) -> Int { self.size }

pub fn SignalwindowtukeyGraphN::get(self : SignalwindowtukeyGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SignalwindowtukeyGraphN::set(self : SignalwindowtukeyGraphN, i : Int, v : Double) -> SignalwindowtukeyGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SignalwindowtukeyGraphN::sum(self : SignalwindowtukeyGraphN) -> Double { @_common.sum(self.data) }

pub fn SignalwindowtukeyGraphN::mean(self : SignalwindowtukeyGraphN) -> Double { @_common.mean(self.data) }

pub fn SignalwindowtukeyGraphN::scale(self : SignalwindowtukeyGraphN, f : Double) -> SignalwindowtukeyGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SignalwindowtukeyGraphN::add(self : SignalwindowtukeyGraphN, other : SignalwindowtukeyGraphN) -> SignalwindowtukeyGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SignalwindowtukeyGraphN::copy(self : SignalwindowtukeyGraphN) -> SignalwindowtukeyGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SignalwindowtukeyGraphN::fill(self : SignalwindowtukeyGraphN, v : Double) -> SignalwindowtukeyGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SignalwindowtukeyGraphN::min(self : SignalwindowtukeyGraphN) -> Double { @_common.min(self.data) }

pub fn SignalwindowtukeyGraphN::max(self : SignalwindowtukeyGraphN) -> Double { @_common.max(self.data) }

pub fn SignalwindowtukeyGraphN::to_string(self : SignalwindowtukeyGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SignalwindowtukeyNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_window_tukey_node_make(size : Int) -> SignalwindowtukeyNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SignalwindowtukeyNode::len(self : SignalwindowtukeyNode) -> Int { self.size }

pub fn SignalwindowtukeyNode::get(self : SignalwindowtukeyNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SignalwindowtukeyNode::set(self : SignalwindowtukeyNode, i : Int, v : Double) -> SignalwindowtukeyNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SignalwindowtukeyNode::sum(self : SignalwindowtukeyNode) -> Double { @_common.sum(self.data) }

pub fn SignalwindowtukeyNode::mean(self : SignalwindowtukeyNode) -> Double { @_common.mean(self.data) }

pub fn SignalwindowtukeyNode::scale(self : SignalwindowtukeyNode, f : Double) -> SignalwindowtukeyNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SignalwindowtukeyNode::add(self : SignalwindowtukeyNode, other : SignalwindowtukeyNode) -> SignalwindowtukeyNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SignalwindowtukeyNode::copy(self : SignalwindowtukeyNode) -> SignalwindowtukeyNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SignalwindowtukeyNode::fill(self : SignalwindowtukeyNode, v : Double) -> SignalwindowtukeyNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SignalwindowtukeyNode::min(self : SignalwindowtukeyNode) -> Double { @_common.min(self.data) }

pub fn SignalwindowtukeyNode::max(self : SignalwindowtukeyNode) -> Double { @_common.max(self.data) }

pub fn SignalwindowtukeyNode::to_string(self : SignalwindowtukeyNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SignalwindowtukeyEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_window_tukey_edge_make(size : Int) -> SignalwindowtukeyEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SignalwindowtukeyEdge::len(self : SignalwindowtukeyEdge) -> Int { self.size }

pub fn SignalwindowtukeyEdge::get(self : SignalwindowtukeyEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SignalwindowtukeyEdge::set(self : SignalwindowtukeyEdge, i : Int, v : Double) -> SignalwindowtukeyEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SignalwindowtukeyEdge::sum(self : SignalwindowtukeyEdge) -> Double { @_common.sum(self.data) }

pub fn SignalwindowtukeyEdge::mean(self : SignalwindowtukeyEdge) -> Double { @_common.mean(self.data) }

pub fn SignalwindowtukeyEdge::scale(self : SignalwindowtukeyEdge, f : Double) -> SignalwindowtukeyEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SignalwindowtukeyEdge::add(self : SignalwindowtukeyEdge, other : SignalwindowtukeyEdge) -> SignalwindowtukeyEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SignalwindowtukeyEdge::copy(self : SignalwindowtukeyEdge) -> SignalwindowtukeyEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SignalwindowtukeyEdge::fill(self : SignalwindowtukeyEdge, v : Double) -> SignalwindowtukeyEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SignalwindowtukeyEdge::min(self : SignalwindowtukeyEdge) -> Double { @_common.min(self.data) }

pub fn SignalwindowtukeyEdge::max(self : SignalwindowtukeyEdge) -> Double { @_common.max(self.data) }

pub fn SignalwindowtukeyEdge::to_string(self : SignalwindowtukeyEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SignalwindowtukeyPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_window_tukey_path_make(size : Int) -> SignalwindowtukeyPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SignalwindowtukeyPath::len(self : SignalwindowtukeyPath) -> Int { self.size }

pub fn SignalwindowtukeyPath::get(self : SignalwindowtukeyPath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SignalwindowtukeyPath::set(self : SignalwindowtukeyPath, i : Int, v : Double) -> SignalwindowtukeyPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SignalwindowtukeyPath::sum(self : SignalwindowtukeyPath) -> Double { @_common.sum(self.data) }

pub fn SignalwindowtukeyPath::mean(self : SignalwindowtukeyPath) -> Double { @_common.mean(self.data) }

pub fn SignalwindowtukeyPath::scale(self : SignalwindowtukeyPath, f : Double) -> SignalwindowtukeyPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SignalwindowtukeyPath::add(self : SignalwindowtukeyPath, other : SignalwindowtukeyPath) -> SignalwindowtukeyPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SignalwindowtukeyPath::copy(self : SignalwindowtukeyPath) -> SignalwindowtukeyPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SignalwindowtukeyPath::fill(self : SignalwindowtukeyPath, v : Double) -> SignalwindowtukeyPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SignalwindowtukeyPath::min(self : SignalwindowtukeyPath) -> Double { @_common.min(self.data) }

pub fn SignalwindowtukeyPath::max(self : SignalwindowtukeyPath) -> Double { @_common.max(self.data) }

pub fn SignalwindowtukeyPath::to_string(self : SignalwindowtukeyPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SignalwindowtukeyCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_window_tukey_cluster_make(size : Int) -> SignalwindowtukeyCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SignalwindowtukeyCluster::len(self : SignalwindowtukeyCluster) -> Int { self.size }

pub fn SignalwindowtukeyCluster::get(self : SignalwindowtukeyCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SignalwindowtukeyCluster::set(self : SignalwindowtukeyCluster, i : Int, v : Double) -> SignalwindowtukeyCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SignalwindowtukeyCluster::sum(self : SignalwindowtukeyCluster) -> Double { @_common.sum(self.data) }

pub fn SignalwindowtukeyCluster::mean(self : SignalwindowtukeyCluster) -> Double { @_common.mean(self.data) }

pub fn SignalwindowtukeyCluster::scale(self : SignalwindowtukeyCluster, f : Double) -> SignalwindowtukeyCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SignalwindowtukeyCluster::add(self : SignalwindowtukeyCluster, other : SignalwindowtukeyCluster) -> SignalwindowtukeyCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SignalwindowtukeyCluster::copy(self : SignalwindowtukeyCluster) -> SignalwindowtukeyCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SignalwindowtukeyCluster::fill(self : SignalwindowtukeyCluster, v : Double) -> SignalwindowtukeyCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SignalwindowtukeyCluster::min(self : SignalwindowtukeyCluster) -> Double { @_common.min(self.data) }

pub fn SignalwindowtukeyCluster::max(self : SignalwindowtukeyCluster) -> Double { @_common.max(self.data) }

pub fn SignalwindowtukeyCluster::to_string(self : SignalwindowtukeyCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SignalwindowtukeyModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_window_tukey_model_make(size : Int) -> SignalwindowtukeyModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SignalwindowtukeyModel::len(self : SignalwindowtukeyModel) -> Int { self.size }

pub fn SignalwindowtukeyModel::get(self : SignalwindowtukeyModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SignalwindowtukeyModel::set(self : SignalwindowtukeyModel, i : Int, v : Double) -> SignalwindowtukeyModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SignalwindowtukeyModel::sum(self : SignalwindowtukeyModel) -> Double { @_common.sum(self.data) }

pub fn SignalwindowtukeyModel::mean(self : SignalwindowtukeyModel) -> Double { @_common.mean(self.data) }

pub fn SignalwindowtukeyModel::scale(self : SignalwindowtukeyModel, f : Double) -> SignalwindowtukeyModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SignalwindowtukeyModel::add(self : SignalwindowtukeyModel, other : SignalwindowtukeyModel) -> SignalwindowtukeyModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SignalwindowtukeyModel::copy(self : SignalwindowtukeyModel) -> SignalwindowtukeyModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SignalwindowtukeyModel::fill(self : SignalwindowtukeyModel, v : Double) -> SignalwindowtukeyModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SignalwindowtukeyModel::min(self : SignalwindowtukeyModel) -> Double { @_common.min(self.data) }

pub fn SignalwindowtukeyModel::max(self : SignalwindowtukeyModel) -> Double { @_common.max(self.data) }

pub fn SignalwindowtukeyModel::to_string(self : SignalwindowtukeyModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SignalwindowtukeyLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_window_tukey_layer_make(size : Int) -> SignalwindowtukeyLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SignalwindowtukeyLayer::len(self : SignalwindowtukeyLayer) -> Int { self.size }

pub fn SignalwindowtukeyLayer::get(self : SignalwindowtukeyLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SignalwindowtukeyLayer::set(self : SignalwindowtukeyLayer, i : Int, v : Double) -> SignalwindowtukeyLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SignalwindowtukeyLayer::sum(self : SignalwindowtukeyLayer) -> Double { @_common.sum(self.data) }

pub fn SignalwindowtukeyLayer::mean(self : SignalwindowtukeyLayer) -> Double { @_common.mean(self.data) }

pub fn SignalwindowtukeyLayer::scale(self : SignalwindowtukeyLayer, f : Double) -> SignalwindowtukeyLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SignalwindowtukeyLayer::add(self : SignalwindowtukeyLayer, other : SignalwindowtukeyLayer) -> SignalwindowtukeyLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SignalwindowtukeyLayer::copy(self : SignalwindowtukeyLayer) -> SignalwindowtukeyLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SignalwindowtukeyLayer::fill(self : SignalwindowtukeyLayer, v : Double) -> SignalwindowtukeyLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SignalwindowtukeyLayer::min(self : SignalwindowtukeyLayer) -> Double { @_common.min(self.data) }

pub fn SignalwindowtukeyLayer::max(self : SignalwindowtukeyLayer) -> Double { @_common.max(self.data) }

pub fn SignalwindowtukeyLayer::to_string(self : SignalwindowtukeyLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SignalwindowtukeyBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_window_tukey_buffer_make(size : Int) -> SignalwindowtukeyBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SignalwindowtukeyBuffer::len(self : SignalwindowtukeyBuffer) -> Int { self.size }

pub fn SignalwindowtukeyBuffer::get(self : SignalwindowtukeyBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SignalwindowtukeyBuffer::set(self : SignalwindowtukeyBuffer, i : Int, v : Double) -> SignalwindowtukeyBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SignalwindowtukeyBuffer::sum(self : SignalwindowtukeyBuffer) -> Double { @_common.sum(self.data) }

pub fn SignalwindowtukeyBuffer::mean(self : SignalwindowtukeyBuffer) -> Double { @_common.mean(self.data) }

pub fn SignalwindowtukeyBuffer::scale(self : SignalwindowtukeyBuffer, f : Double) -> SignalwindowtukeyBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SignalwindowtukeyBuffer::add(self : SignalwindowtukeyBuffer, other : SignalwindowtukeyBuffer) -> SignalwindowtukeyBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SignalwindowtukeyBuffer::copy(self : SignalwindowtukeyBuffer) -> SignalwindowtukeyBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SignalwindowtukeyBuffer::fill(self : SignalwindowtukeyBuffer, v : Double) -> SignalwindowtukeyBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SignalwindowtukeyBuffer::min(self : SignalwindowtukeyBuffer) -> Double { @_common.min(self.data) }

pub fn SignalwindowtukeyBuffer::max(self : SignalwindowtukeyBuffer) -> Double { @_common.max(self.data) }

pub fn SignalwindowtukeyBuffer::to_string(self : SignalwindowtukeyBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SignalwindowtukeyCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_window_tukey_cursor_make(size : Int) -> SignalwindowtukeyCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SignalwindowtukeyCursor::len(self : SignalwindowtukeyCursor) -> Int { self.size }

pub fn SignalwindowtukeyCursor::get(self : SignalwindowtukeyCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SignalwindowtukeyCursor::set(self : SignalwindowtukeyCursor, i : Int, v : Double) -> SignalwindowtukeyCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SignalwindowtukeyCursor::sum(self : SignalwindowtukeyCursor) -> Double { @_common.sum(self.data) }

pub fn SignalwindowtukeyCursor::mean(self : SignalwindowtukeyCursor) -> Double { @_common.mean(self.data) }

pub fn SignalwindowtukeyCursor::scale(self : SignalwindowtukeyCursor, f : Double) -> SignalwindowtukeyCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SignalwindowtukeyCursor::add(self : SignalwindowtukeyCursor, other : SignalwindowtukeyCursor) -> SignalwindowtukeyCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SignalwindowtukeyCursor::copy(self : SignalwindowtukeyCursor) -> SignalwindowtukeyCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SignalwindowtukeyCursor::fill(self : SignalwindowtukeyCursor, v : Double) -> SignalwindowtukeyCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SignalwindowtukeyCursor::min(self : SignalwindowtukeyCursor) -> Double { @_common.min(self.data) }

pub fn SignalwindowtukeyCursor::max(self : SignalwindowtukeyCursor) -> Double { @_common.max(self.data) }

pub fn SignalwindowtukeyCursor::to_string(self : SignalwindowtukeyCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SignalwindowtukeyView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_window_tukey_view_make(size : Int) -> SignalwindowtukeyView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SignalwindowtukeyView::len(self : SignalwindowtukeyView) -> Int { self.size }

pub fn SignalwindowtukeyView::get(self : SignalwindowtukeyView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SignalwindowtukeyView::set(self : SignalwindowtukeyView, i : Int, v : Double) -> SignalwindowtukeyView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SignalwindowtukeyView::sum(self : SignalwindowtukeyView) -> Double { @_common.sum(self.data) }

pub fn SignalwindowtukeyView::mean(self : SignalwindowtukeyView) -> Double { @_common.mean(self.data) }

pub fn SignalwindowtukeyView::scale(self : SignalwindowtukeyView, f : Double) -> SignalwindowtukeyView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SignalwindowtukeyView::add(self : SignalwindowtukeyView, other : SignalwindowtukeyView) -> SignalwindowtukeyView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SignalwindowtukeyView::copy(self : SignalwindowtukeyView) -> SignalwindowtukeyView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SignalwindowtukeyView::fill(self : SignalwindowtukeyView, v : Double) -> SignalwindowtukeyView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SignalwindowtukeyView::min(self : SignalwindowtukeyView) -> Double { @_common.min(self.data) }

pub fn SignalwindowtukeyView::max(self : SignalwindowtukeyView) -> Double { @_common.max(self.data) }

pub fn SignalwindowtukeyView::to_string(self : SignalwindowtukeyView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SignalwindowtukeyRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_window_tukey_range_make(size : Int) -> SignalwindowtukeyRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SignalwindowtukeyRange::len(self : SignalwindowtukeyRange) -> Int { self.size }

pub fn SignalwindowtukeyRange::get(self : SignalwindowtukeyRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SignalwindowtukeyRange::set(self : SignalwindowtukeyRange, i : Int, v : Double) -> SignalwindowtukeyRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SignalwindowtukeyRange::sum(self : SignalwindowtukeyRange) -> Double { @_common.sum(self.data) }

pub fn SignalwindowtukeyRange::mean(self : SignalwindowtukeyRange) -> Double { @_common.mean(self.data) }

pub fn SignalwindowtukeyRange::scale(self : SignalwindowtukeyRange, f : Double) -> SignalwindowtukeyRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SignalwindowtukeyRange::add(self : SignalwindowtukeyRange, other : SignalwindowtukeyRange) -> SignalwindowtukeyRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SignalwindowtukeyRange::copy(self : SignalwindowtukeyRange) -> SignalwindowtukeyRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SignalwindowtukeyRange::fill(self : SignalwindowtukeyRange, v : Double) -> SignalwindowtukeyRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SignalwindowtukeyRange::min(self : SignalwindowtukeyRange) -> Double { @_common.min(self.data) }

pub fn SignalwindowtukeyRange::max(self : SignalwindowtukeyRange) -> Double { @_common.max(self.data) }

pub fn SignalwindowtukeyRange::to_string(self : SignalwindowtukeyRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SignalwindowtukeySlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_window_tukey_slice_make(size : Int) -> SignalwindowtukeySlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SignalwindowtukeySlice::len(self : SignalwindowtukeySlice) -> Int { self.size }

pub fn SignalwindowtukeySlice::get(self : SignalwindowtukeySlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SignalwindowtukeySlice::set(self : SignalwindowtukeySlice, i : Int, v : Double) -> SignalwindowtukeySlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SignalwindowtukeySlice::sum(self : SignalwindowtukeySlice) -> Double { @_common.sum(self.data) }

pub fn SignalwindowtukeySlice::mean(self : SignalwindowtukeySlice) -> Double { @_common.mean(self.data) }

pub fn SignalwindowtukeySlice::scale(self : SignalwindowtukeySlice, f : Double) -> SignalwindowtukeySlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SignalwindowtukeySlice::add(self : SignalwindowtukeySlice, other : SignalwindowtukeySlice) -> SignalwindowtukeySlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SignalwindowtukeySlice::copy(self : SignalwindowtukeySlice) -> SignalwindowtukeySlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SignalwindowtukeySlice::fill(self : SignalwindowtukeySlice, v : Double) -> SignalwindowtukeySlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SignalwindowtukeySlice::min(self : SignalwindowtukeySlice) -> Double { @_common.min(self.data) }

pub fn SignalwindowtukeySlice::max(self : SignalwindowtukeySlice) -> Double { @_common.max(self.data) }

pub fn SignalwindowtukeySlice::to_string(self : SignalwindowtukeySlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

