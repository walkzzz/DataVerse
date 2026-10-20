///===
/// extcore/signal_window_gaussian

pub(all) struct SignalwindowgaussianPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn signal_window_gaussian_make_point(x : Double, y : Double) -> SignalwindowgaussianPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn signal_window_gaussian_make_point3(x : Double, y : Double, z : Double) -> SignalwindowgaussianPoint {
  { x, y, z, label: 0 }
}

pub fn SignalwindowgaussianPoint::x(self : SignalwindowgaussianPoint) -> Double { self.x }

pub fn SignalwindowgaussianPoint::y(self : SignalwindowgaussianPoint) -> Double { self.y }

pub fn SignalwindowgaussianPoint::z(self : SignalwindowgaussianPoint) -> Double { self.z }

pub fn SignalwindowgaussianPoint::label(self : SignalwindowgaussianPoint) -> Int { self.label }

pub fn SignalwindowgaussianPoint::dist(self : SignalwindowgaussianPoint, other : SignalwindowgaussianPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn SignalwindowgaussianPoint::add(self : SignalwindowgaussianPoint, other : SignalwindowgaussianPoint) -> SignalwindowgaussianPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn SignalwindowgaussianPoint::sub(self : SignalwindowgaussianPoint, other : SignalwindowgaussianPoint) -> SignalwindowgaussianPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn SignalwindowgaussianPoint::scale(self : SignalwindowgaussianPoint, s : Double) -> SignalwindowgaussianPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn SignalwindowgaussianPoint::dot(self : SignalwindowgaussianPoint, other : SignalwindowgaussianPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn SignalwindowgaussianPoint::cross(self : SignalwindowgaussianPoint, other : SignalwindowgaussianPoint) -> SignalwindowgaussianPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn SignalwindowgaussianPoint::norm(self : SignalwindowgaussianPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn SignalwindowgaussianPoint::normalize(self : SignalwindowgaussianPoint) -> SignalwindowgaussianPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn SignalwindowgaussianPoint::negate(self : SignalwindowgaussianPoint) -> SignalwindowgaussianPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn SignalwindowgaussianPoint::mid(self : SignalwindowgaussianPoint, other : SignalwindowgaussianPoint) -> SignalwindowgaussianPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn SignalwindowgaussianPoint::lerp(self : SignalwindowgaussianPoint, other : SignalwindowgaussianPoint, t : Double) -> SignalwindowgaussianPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn SignalwindowgaussianPoint::to_string(self : SignalwindowgaussianPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct SignalwindowgaussianSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn signal_window_gaussian_make_series(vals : Array[Double], name : String) -> SignalwindowgaussianSeries {
  { vals, name, meta: 0 }
}

pub fn SignalwindowgaussianSeries::len(self : SignalwindowgaussianSeries) -> Int { self.vals.length() }

pub fn SignalwindowgaussianSeries::sum(self : SignalwindowgaussianSeries) -> Double { @_common.sum(self.vals) }

pub fn SignalwindowgaussianSeries::mean(self : SignalwindowgaussianSeries) -> Double { @_common.mean(self.vals) }

pub fn SignalwindowgaussianSeries::min(self : SignalwindowgaussianSeries) -> Double { @_common.min(self.vals) }

pub fn SignalwindowgaussianSeries::max(self : SignalwindowgaussianSeries) -> Double { @_common.max(self.vals) }

pub fn SignalwindowgaussianSeries::range(self : SignalwindowgaussianSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn SignalwindowgaussianSeries::variance(self : SignalwindowgaussianSeries) -> Double { @_common.variance(self.vals) }

pub fn SignalwindowgaussianSeries::std(self : SignalwindowgaussianSeries) -> Double { @_common.std(self.vals) }

pub fn SignalwindowgaussianSeries::median(self : SignalwindowgaussianSeries) -> Double { @_common.median(self.vals) }

pub fn SignalwindowgaussianSeries::scale(self : SignalwindowgaussianSeries, f : Double) -> SignalwindowgaussianSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn SignalwindowgaussianSeries::add(self : SignalwindowgaussianSeries, other : SignalwindowgaussianSeries) -> SignalwindowgaussianSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn SignalwindowgaussianSeries::sub(self : SignalwindowgaussianSeries, other : SignalwindowgaussianSeries) -> SignalwindowgaussianSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn SignalwindowgaussianSeries::normalize(self : SignalwindowgaussianSeries) -> SignalwindowgaussianSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn SignalwindowgaussianSeries::cumsum(self : SignalwindowgaussianSeries) -> SignalwindowgaussianSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn SignalwindowgaussianSeries::to_string(self : SignalwindowgaussianSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct SignalwindowgaussianMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn signal_window_gaussian_make_matrix(rows : Int, cols : Int, val : Double) -> SignalwindowgaussianMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn signal_window_gaussian_matrix_identity(n : Int) -> SignalwindowgaussianMatrix {
  let m = signal_window_gaussian_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn SignalwindowgaussianMatrix::get(self : SignalwindowgaussianMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn SignalwindowgaussianMatrix::transpose(self : SignalwindowgaussianMatrix) -> SignalwindowgaussianMatrix {
  let result = signal_window_gaussian_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn SignalwindowgaussianMatrix::add(self : SignalwindowgaussianMatrix, other : SignalwindowgaussianMatrix) -> SignalwindowgaussianMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = signal_window_gaussian_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn SignalwindowgaussianMatrix::scale(self : SignalwindowgaussianMatrix, s : Double) -> SignalwindowgaussianMatrix {
  let result = signal_window_gaussian_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn SignalwindowgaussianMatrix::multiply(self : SignalwindowgaussianMatrix, other : SignalwindowgaussianMatrix) -> SignalwindowgaussianMatrix {
  if self.cols != other.rows { return signal_window_gaussian_make_matrix(self.rows, other.cols, 0.0) }
  let result = signal_window_gaussian_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn SignalwindowgaussianMatrix::trace(self : SignalwindowgaussianMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn SignalwindowgaussianMatrix::det(self : SignalwindowgaussianMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn SignalwindowgaussianMatrix::norm(self : SignalwindowgaussianMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn SignalwindowgaussianMatrix::to_string(self : SignalwindowgaussianMatrix) -> String {
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

pub(all) struct SignalwindowgaussianVector {
  comps : Array[Double]
  dim : Int
}

pub fn signal_window_gaussian_make_vector(comps : Array[Double]) -> SignalwindowgaussianVector {
  { comps, dim: comps.length() }
}

pub fn signal_window_gaussian_vector_zero(dim : Int) -> SignalwindowgaussianVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn SignalwindowgaussianVector::add(self : SignalwindowgaussianVector, other : SignalwindowgaussianVector) -> SignalwindowgaussianVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn SignalwindowgaussianVector::sub(self : SignalwindowgaussianVector, other : SignalwindowgaussianVector) -> SignalwindowgaussianVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn SignalwindowgaussianVector::scale(self : SignalwindowgaussianVector, s : Double) -> SignalwindowgaussianVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn SignalwindowgaussianVector::dot(self : SignalwindowgaussianVector, other : SignalwindowgaussianVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn SignalwindowgaussianVector::norm(self : SignalwindowgaussianVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn SignalwindowgaussianVector::normalize(self : SignalwindowgaussianVector) -> SignalwindowgaussianVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn SignalwindowgaussianVector::dist(self : SignalwindowgaussianVector, other : SignalwindowgaussianVector) -> Double {
  self.sub(other).norm()
}

pub fn SignalwindowgaussianVector::to_string(self : SignalwindowgaussianVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn signal_window_gaussian_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn signal_window_gaussian_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn signal_window_gaussian_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn signal_window_gaussian_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn signal_window_gaussian_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn signal_window_gaussian_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn signal_window_gaussian_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn signal_window_gaussian_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn signal_window_gaussian_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn signal_window_gaussian_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn signal_window_gaussian_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn signal_window_gaussian_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn signal_window_gaussian_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn signal_window_gaussian_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn signal_window_gaussian_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn signal_window_gaussian_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn signal_window_gaussian_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn signal_window_gaussian_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn signal_window_gaussian_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn signal_window_gaussian_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn signal_window_gaussian_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn signal_window_gaussian_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn signal_window_gaussian_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn signal_window_gaussian_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn signal_window_gaussian_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn signal_window_gaussian_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn signal_window_gaussian_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn signal_window_gaussian_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn signal_window_gaussian_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct SignalwindowgaussianFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_window_gaussian_frame_make(size : Int) -> SignalwindowgaussianFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_window_gaussian_frame_len(s : SignalwindowgaussianFrame) -> Int { s.size }

pub fn signal_window_gaussian_frame_get(s : SignalwindowgaussianFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_window_gaussian_frame_set(s : SignalwindowgaussianFrame, i : Int, v : Double) -> SignalwindowgaussianFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_window_gaussian_frame_sum(s : SignalwindowgaussianFrame) -> Double { @_common.sum(s.data) }

pub fn signal_window_gaussian_frame_mean(s : SignalwindowgaussianFrame) -> Double { @_common.mean(s.data) }

pub fn signal_window_gaussian_frame_scale(s : SignalwindowgaussianFrame, f : Double) -> SignalwindowgaussianFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_window_gaussian_frame_add(a : SignalwindowgaussianFrame, b : SignalwindowgaussianFrame) -> SignalwindowgaussianFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_window_gaussian_frame_copy(s : SignalwindowgaussianFrame) -> SignalwindowgaussianFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_window_gaussian_frame_fill(s : SignalwindowgaussianFrame, v : Double) -> SignalwindowgaussianFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_window_gaussian_frame_min(s : SignalwindowgaussianFrame) -> Double { @_common.min(s.data) }

pub fn signal_window_gaussian_frame_max(s : SignalwindowgaussianFrame) -> Double { @_common.max(s.data) }

pub fn signal_window_gaussian_frame_to_string(s : SignalwindowgaussianFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalwindowgaussianTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_window_gaussian_table_make(size : Int) -> SignalwindowgaussianTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_window_gaussian_table_len(s : SignalwindowgaussianTable) -> Int { s.size }

pub fn signal_window_gaussian_table_get(s : SignalwindowgaussianTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_window_gaussian_table_set(s : SignalwindowgaussianTable, i : Int, v : Double) -> SignalwindowgaussianTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_window_gaussian_table_sum(s : SignalwindowgaussianTable) -> Double { @_common.sum(s.data) }

pub fn signal_window_gaussian_table_mean(s : SignalwindowgaussianTable) -> Double { @_common.mean(s.data) }

pub fn signal_window_gaussian_table_scale(s : SignalwindowgaussianTable, f : Double) -> SignalwindowgaussianTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_window_gaussian_table_add(a : SignalwindowgaussianTable, b : SignalwindowgaussianTable) -> SignalwindowgaussianTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_window_gaussian_table_copy(s : SignalwindowgaussianTable) -> SignalwindowgaussianTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_window_gaussian_table_fill(s : SignalwindowgaussianTable, v : Double) -> SignalwindowgaussianTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_window_gaussian_table_min(s : SignalwindowgaussianTable) -> Double { @_common.min(s.data) }

pub fn signal_window_gaussian_table_max(s : SignalwindowgaussianTable) -> Double { @_common.max(s.data) }

pub fn signal_window_gaussian_table_to_string(s : SignalwindowgaussianTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalwindowgaussianGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_window_gaussian_graphn_make(size : Int) -> SignalwindowgaussianGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_window_gaussian_graphn_len(s : SignalwindowgaussianGraphN) -> Int { s.size }

pub fn signal_window_gaussian_graphn_get(s : SignalwindowgaussianGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_window_gaussian_graphn_set(s : SignalwindowgaussianGraphN, i : Int, v : Double) -> SignalwindowgaussianGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_window_gaussian_graphn_sum(s : SignalwindowgaussianGraphN) -> Double { @_common.sum(s.data) }

pub fn signal_window_gaussian_graphn_mean(s : SignalwindowgaussianGraphN) -> Double { @_common.mean(s.data) }

pub fn signal_window_gaussian_graphn_scale(s : SignalwindowgaussianGraphN, f : Double) -> SignalwindowgaussianGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_window_gaussian_graphn_add(a : SignalwindowgaussianGraphN, b : SignalwindowgaussianGraphN) -> SignalwindowgaussianGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_window_gaussian_graphn_copy(s : SignalwindowgaussianGraphN) -> SignalwindowgaussianGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_window_gaussian_graphn_fill(s : SignalwindowgaussianGraphN, v : Double) -> SignalwindowgaussianGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_window_gaussian_graphn_min(s : SignalwindowgaussianGraphN) -> Double { @_common.min(s.data) }

pub fn signal_window_gaussian_graphn_max(s : SignalwindowgaussianGraphN) -> Double { @_common.max(s.data) }

pub fn signal_window_gaussian_graphn_to_string(s : SignalwindowgaussianGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalwindowgaussianNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_window_gaussian_node_make(size : Int) -> SignalwindowgaussianNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_window_gaussian_node_len(s : SignalwindowgaussianNode) -> Int { s.size }

pub fn signal_window_gaussian_node_get(s : SignalwindowgaussianNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_window_gaussian_node_set(s : SignalwindowgaussianNode, i : Int, v : Double) -> SignalwindowgaussianNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_window_gaussian_node_sum(s : SignalwindowgaussianNode) -> Double { @_common.sum(s.data) }

pub fn signal_window_gaussian_node_mean(s : SignalwindowgaussianNode) -> Double { @_common.mean(s.data) }

pub fn signal_window_gaussian_node_scale(s : SignalwindowgaussianNode, f : Double) -> SignalwindowgaussianNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_window_gaussian_node_add(a : SignalwindowgaussianNode, b : SignalwindowgaussianNode) -> SignalwindowgaussianNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_window_gaussian_node_copy(s : SignalwindowgaussianNode) -> SignalwindowgaussianNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_window_gaussian_node_fill(s : SignalwindowgaussianNode, v : Double) -> SignalwindowgaussianNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_window_gaussian_node_min(s : SignalwindowgaussianNode) -> Double { @_common.min(s.data) }

pub fn signal_window_gaussian_node_max(s : SignalwindowgaussianNode) -> Double { @_common.max(s.data) }

pub fn signal_window_gaussian_node_to_string(s : SignalwindowgaussianNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalwindowgaussianEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_window_gaussian_edge_make(size : Int) -> SignalwindowgaussianEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_window_gaussian_edge_len(s : SignalwindowgaussianEdge) -> Int { s.size }

pub fn signal_window_gaussian_edge_get(s : SignalwindowgaussianEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_window_gaussian_edge_set(s : SignalwindowgaussianEdge, i : Int, v : Double) -> SignalwindowgaussianEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_window_gaussian_edge_sum(s : SignalwindowgaussianEdge) -> Double { @_common.sum(s.data) }

pub fn signal_window_gaussian_edge_mean(s : SignalwindowgaussianEdge) -> Double { @_common.mean(s.data) }

pub fn signal_window_gaussian_edge_scale(s : SignalwindowgaussianEdge, f : Double) -> SignalwindowgaussianEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_window_gaussian_edge_add(a : SignalwindowgaussianEdge, b : SignalwindowgaussianEdge) -> SignalwindowgaussianEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_window_gaussian_edge_copy(s : SignalwindowgaussianEdge) -> SignalwindowgaussianEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_window_gaussian_edge_fill(s : SignalwindowgaussianEdge, v : Double) -> SignalwindowgaussianEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_window_gaussian_edge_min(s : SignalwindowgaussianEdge) -> Double { @_common.min(s.data) }

pub fn signal_window_gaussian_edge_max(s : SignalwindowgaussianEdge) -> Double { @_common.max(s.data) }

pub fn signal_window_gaussian_edge_to_string(s : SignalwindowgaussianEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalwindowgaussianPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_window_gaussian_path_make(size : Int) -> SignalwindowgaussianPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_window_gaussian_path_len(s : SignalwindowgaussianPath) -> Int { s.size }

pub fn signal_window_gaussian_path_get(s : SignalwindowgaussianPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_window_gaussian_path_set(s : SignalwindowgaussianPath, i : Int, v : Double) -> SignalwindowgaussianPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_window_gaussian_path_sum(s : SignalwindowgaussianPath) -> Double { @_common.sum(s.data) }

pub fn signal_window_gaussian_path_mean(s : SignalwindowgaussianPath) -> Double { @_common.mean(s.data) }

pub fn signal_window_gaussian_path_scale(s : SignalwindowgaussianPath, f : Double) -> SignalwindowgaussianPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_window_gaussian_path_add(a : SignalwindowgaussianPath, b : SignalwindowgaussianPath) -> SignalwindowgaussianPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_window_gaussian_path_copy(s : SignalwindowgaussianPath) -> SignalwindowgaussianPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_window_gaussian_path_fill(s : SignalwindowgaussianPath, v : Double) -> SignalwindowgaussianPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_window_gaussian_path_min(s : SignalwindowgaussianPath) -> Double { @_common.min(s.data) }

pub fn signal_window_gaussian_path_max(s : SignalwindowgaussianPath) -> Double { @_common.max(s.data) }

pub fn signal_window_gaussian_path_to_string(s : SignalwindowgaussianPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalwindowgaussianCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_window_gaussian_cluster_make(size : Int) -> SignalwindowgaussianCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_window_gaussian_cluster_len(s : SignalwindowgaussianCluster) -> Int { s.size }

pub fn signal_window_gaussian_cluster_get(s : SignalwindowgaussianCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_window_gaussian_cluster_set(s : SignalwindowgaussianCluster, i : Int, v : Double) -> SignalwindowgaussianCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_window_gaussian_cluster_sum(s : SignalwindowgaussianCluster) -> Double { @_common.sum(s.data) }

pub fn signal_window_gaussian_cluster_mean(s : SignalwindowgaussianCluster) -> Double { @_common.mean(s.data) }

pub fn signal_window_gaussian_cluster_scale(s : SignalwindowgaussianCluster, f : Double) -> SignalwindowgaussianCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_window_gaussian_cluster_add(a : SignalwindowgaussianCluster, b : SignalwindowgaussianCluster) -> SignalwindowgaussianCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_window_gaussian_cluster_copy(s : SignalwindowgaussianCluster) -> SignalwindowgaussianCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_window_gaussian_cluster_fill(s : SignalwindowgaussianCluster, v : Double) -> SignalwindowgaussianCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_window_gaussian_cluster_min(s : SignalwindowgaussianCluster) -> Double { @_common.min(s.data) }

pub fn signal_window_gaussian_cluster_max(s : SignalwindowgaussianCluster) -> Double { @_common.max(s.data) }

pub fn signal_window_gaussian_cluster_to_string(s : SignalwindowgaussianCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalwindowgaussianModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_window_gaussian_model_make(size : Int) -> SignalwindowgaussianModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_window_gaussian_model_len(s : SignalwindowgaussianModel) -> Int { s.size }

pub fn signal_window_gaussian_model_get(s : SignalwindowgaussianModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_window_gaussian_model_set(s : SignalwindowgaussianModel, i : Int, v : Double) -> SignalwindowgaussianModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_window_gaussian_model_sum(s : SignalwindowgaussianModel) -> Double { @_common.sum(s.data) }

pub fn signal_window_gaussian_model_mean(s : SignalwindowgaussianModel) -> Double { @_common.mean(s.data) }

pub fn signal_window_gaussian_model_scale(s : SignalwindowgaussianModel, f : Double) -> SignalwindowgaussianModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_window_gaussian_model_add(a : SignalwindowgaussianModel, b : SignalwindowgaussianModel) -> SignalwindowgaussianModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_window_gaussian_model_copy(s : SignalwindowgaussianModel) -> SignalwindowgaussianModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_window_gaussian_model_fill(s : SignalwindowgaussianModel, v : Double) -> SignalwindowgaussianModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_window_gaussian_model_min(s : SignalwindowgaussianModel) -> Double { @_common.min(s.data) }

pub fn signal_window_gaussian_model_max(s : SignalwindowgaussianModel) -> Double { @_common.max(s.data) }

pub fn signal_window_gaussian_model_to_string(s : SignalwindowgaussianModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalwindowgaussianLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_window_gaussian_layer_make(size : Int) -> SignalwindowgaussianLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_window_gaussian_layer_len(s : SignalwindowgaussianLayer) -> Int { s.size }

pub fn signal_window_gaussian_layer_get(s : SignalwindowgaussianLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_window_gaussian_layer_set(s : SignalwindowgaussianLayer, i : Int, v : Double) -> SignalwindowgaussianLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_window_gaussian_layer_sum(s : SignalwindowgaussianLayer) -> Double { @_common.sum(s.data) }

pub fn signal_window_gaussian_layer_mean(s : SignalwindowgaussianLayer) -> Double { @_common.mean(s.data) }

pub fn signal_window_gaussian_layer_scale(s : SignalwindowgaussianLayer, f : Double) -> SignalwindowgaussianLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_window_gaussian_layer_add(a : SignalwindowgaussianLayer, b : SignalwindowgaussianLayer) -> SignalwindowgaussianLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_window_gaussian_layer_copy(s : SignalwindowgaussianLayer) -> SignalwindowgaussianLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_window_gaussian_layer_fill(s : SignalwindowgaussianLayer, v : Double) -> SignalwindowgaussianLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_window_gaussian_layer_min(s : SignalwindowgaussianLayer) -> Double { @_common.min(s.data) }

pub fn signal_window_gaussian_layer_max(s : SignalwindowgaussianLayer) -> Double { @_common.max(s.data) }

pub fn signal_window_gaussian_layer_to_string(s : SignalwindowgaussianLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalwindowgaussianBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_window_gaussian_buffer_make(size : Int) -> SignalwindowgaussianBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_window_gaussian_buffer_len(s : SignalwindowgaussianBuffer) -> Int { s.size }

pub fn signal_window_gaussian_buffer_get(s : SignalwindowgaussianBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_window_gaussian_buffer_set(s : SignalwindowgaussianBuffer, i : Int, v : Double) -> SignalwindowgaussianBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_window_gaussian_buffer_sum(s : SignalwindowgaussianBuffer) -> Double { @_common.sum(s.data) }

pub fn signal_window_gaussian_buffer_mean(s : SignalwindowgaussianBuffer) -> Double { @_common.mean(s.data) }

pub fn signal_window_gaussian_buffer_scale(s : SignalwindowgaussianBuffer, f : Double) -> SignalwindowgaussianBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_window_gaussian_buffer_add(a : SignalwindowgaussianBuffer, b : SignalwindowgaussianBuffer) -> SignalwindowgaussianBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_window_gaussian_buffer_copy(s : SignalwindowgaussianBuffer) -> SignalwindowgaussianBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_window_gaussian_buffer_fill(s : SignalwindowgaussianBuffer, v : Double) -> SignalwindowgaussianBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_window_gaussian_buffer_min(s : SignalwindowgaussianBuffer) -> Double { @_common.min(s.data) }

pub fn signal_window_gaussian_buffer_max(s : SignalwindowgaussianBuffer) -> Double { @_common.max(s.data) }

pub fn signal_window_gaussian_buffer_to_string(s : SignalwindowgaussianBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalwindowgaussianCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_window_gaussian_cursor_make(size : Int) -> SignalwindowgaussianCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_window_gaussian_cursor_len(s : SignalwindowgaussianCursor) -> Int { s.size }

pub fn signal_window_gaussian_cursor_get(s : SignalwindowgaussianCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_window_gaussian_cursor_set(s : SignalwindowgaussianCursor, i : Int, v : Double) -> SignalwindowgaussianCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_window_gaussian_cursor_sum(s : SignalwindowgaussianCursor) -> Double { @_common.sum(s.data) }

pub fn signal_window_gaussian_cursor_mean(s : SignalwindowgaussianCursor) -> Double { @_common.mean(s.data) }

pub fn signal_window_gaussian_cursor_scale(s : SignalwindowgaussianCursor, f : Double) -> SignalwindowgaussianCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_window_gaussian_cursor_add(a : SignalwindowgaussianCursor, b : SignalwindowgaussianCursor) -> SignalwindowgaussianCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_window_gaussian_cursor_copy(s : SignalwindowgaussianCursor) -> SignalwindowgaussianCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_window_gaussian_cursor_fill(s : SignalwindowgaussianCursor, v : Double) -> SignalwindowgaussianCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_window_gaussian_cursor_min(s : SignalwindowgaussianCursor) -> Double { @_common.min(s.data) }

pub fn signal_window_gaussian_cursor_max(s : SignalwindowgaussianCursor) -> Double { @_common.max(s.data) }

pub fn signal_window_gaussian_cursor_to_string(s : SignalwindowgaussianCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalwindowgaussianView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_window_gaussian_view_make(size : Int) -> SignalwindowgaussianView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_window_gaussian_view_len(s : SignalwindowgaussianView) -> Int { s.size }

pub fn signal_window_gaussian_view_get(s : SignalwindowgaussianView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_window_gaussian_view_set(s : SignalwindowgaussianView, i : Int, v : Double) -> SignalwindowgaussianView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_window_gaussian_view_sum(s : SignalwindowgaussianView) -> Double { @_common.sum(s.data) }

pub fn signal_window_gaussian_view_mean(s : SignalwindowgaussianView) -> Double { @_common.mean(s.data) }

pub fn signal_window_gaussian_view_scale(s : SignalwindowgaussianView, f : Double) -> SignalwindowgaussianView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_window_gaussian_view_add(a : SignalwindowgaussianView, b : SignalwindowgaussianView) -> SignalwindowgaussianView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_window_gaussian_view_copy(s : SignalwindowgaussianView) -> SignalwindowgaussianView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_window_gaussian_view_fill(s : SignalwindowgaussianView, v : Double) -> SignalwindowgaussianView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_window_gaussian_view_min(s : SignalwindowgaussianView) -> Double { @_common.min(s.data) }

pub fn signal_window_gaussian_view_max(s : SignalwindowgaussianView) -> Double { @_common.max(s.data) }

pub fn signal_window_gaussian_view_to_string(s : SignalwindowgaussianView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalwindowgaussianRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_window_gaussian_range_make(size : Int) -> SignalwindowgaussianRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_window_gaussian_range_len(s : SignalwindowgaussianRange) -> Int { s.size }

pub fn signal_window_gaussian_range_get(s : SignalwindowgaussianRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_window_gaussian_range_set(s : SignalwindowgaussianRange, i : Int, v : Double) -> SignalwindowgaussianRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_window_gaussian_range_sum(s : SignalwindowgaussianRange) -> Double { @_common.sum(s.data) }

pub fn signal_window_gaussian_range_mean(s : SignalwindowgaussianRange) -> Double { @_common.mean(s.data) }

pub fn signal_window_gaussian_range_scale(s : SignalwindowgaussianRange, f : Double) -> SignalwindowgaussianRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_window_gaussian_range_add(a : SignalwindowgaussianRange, b : SignalwindowgaussianRange) -> SignalwindowgaussianRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_window_gaussian_range_copy(s : SignalwindowgaussianRange) -> SignalwindowgaussianRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_window_gaussian_range_fill(s : SignalwindowgaussianRange, v : Double) -> SignalwindowgaussianRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_window_gaussian_range_min(s : SignalwindowgaussianRange) -> Double { @_common.min(s.data) }

pub fn signal_window_gaussian_range_max(s : SignalwindowgaussianRange) -> Double { @_common.max(s.data) }

pub fn signal_window_gaussian_range_to_string(s : SignalwindowgaussianRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalwindowgaussianSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_window_gaussian_slice_make(size : Int) -> SignalwindowgaussianSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_window_gaussian_slice_len(s : SignalwindowgaussianSlice) -> Int { s.size }

pub fn signal_window_gaussian_slice_get(s : SignalwindowgaussianSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_window_gaussian_slice_set(s : SignalwindowgaussianSlice, i : Int, v : Double) -> SignalwindowgaussianSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_window_gaussian_slice_sum(s : SignalwindowgaussianSlice) -> Double { @_common.sum(s.data) }

pub fn signal_window_gaussian_slice_mean(s : SignalwindowgaussianSlice) -> Double { @_common.mean(s.data) }

pub fn signal_window_gaussian_slice_scale(s : SignalwindowgaussianSlice, f : Double) -> SignalwindowgaussianSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_window_gaussian_slice_add(a : SignalwindowgaussianSlice, b : SignalwindowgaussianSlice) -> SignalwindowgaussianSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_window_gaussian_slice_copy(s : SignalwindowgaussianSlice) -> SignalwindowgaussianSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_window_gaussian_slice_fill(s : SignalwindowgaussianSlice, v : Double) -> SignalwindowgaussianSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_window_gaussian_slice_min(s : SignalwindowgaussianSlice) -> Double { @_common.min(s.data) }

pub fn signal_window_gaussian_slice_max(s : SignalwindowgaussianSlice) -> Double { @_common.max(s.data) }

pub fn signal_window_gaussian_slice_to_string(s : SignalwindowgaussianSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

