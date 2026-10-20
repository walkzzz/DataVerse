///===
/// extcore/signal_spec_covariance

pub(all) struct SignalspeccovariancePoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn signal_spec_covariance_make_point(x : Double, y : Double) -> SignalspeccovariancePoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn signal_spec_covariance_make_point3(x : Double, y : Double, z : Double) -> SignalspeccovariancePoint {
  { x, y, z, label: 0 }
}

pub fn SignalspeccovariancePoint::x(self : SignalspeccovariancePoint) -> Double { self.x }

pub fn SignalspeccovariancePoint::y(self : SignalspeccovariancePoint) -> Double { self.y }

pub fn SignalspeccovariancePoint::z(self : SignalspeccovariancePoint) -> Double { self.z }

pub fn SignalspeccovariancePoint::label(self : SignalspeccovariancePoint) -> Int { self.label }

pub fn SignalspeccovariancePoint::dist(self : SignalspeccovariancePoint, other : SignalspeccovariancePoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn SignalspeccovariancePoint::add(self : SignalspeccovariancePoint, other : SignalspeccovariancePoint) -> SignalspeccovariancePoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn SignalspeccovariancePoint::sub(self : SignalspeccovariancePoint, other : SignalspeccovariancePoint) -> SignalspeccovariancePoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn SignalspeccovariancePoint::scale(self : SignalspeccovariancePoint, s : Double) -> SignalspeccovariancePoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn SignalspeccovariancePoint::dot(self : SignalspeccovariancePoint, other : SignalspeccovariancePoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn SignalspeccovariancePoint::cross(self : SignalspeccovariancePoint, other : SignalspeccovariancePoint) -> SignalspeccovariancePoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn SignalspeccovariancePoint::norm(self : SignalspeccovariancePoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn SignalspeccovariancePoint::normalize(self : SignalspeccovariancePoint) -> SignalspeccovariancePoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn SignalspeccovariancePoint::negate(self : SignalspeccovariancePoint) -> SignalspeccovariancePoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn SignalspeccovariancePoint::mid(self : SignalspeccovariancePoint, other : SignalspeccovariancePoint) -> SignalspeccovariancePoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn SignalspeccovariancePoint::lerp(self : SignalspeccovariancePoint, other : SignalspeccovariancePoint, t : Double) -> SignalspeccovariancePoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn SignalspeccovariancePoint::to_string(self : SignalspeccovariancePoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct SignalspeccovarianceSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn signal_spec_covariance_make_series(vals : Array[Double], name : String) -> SignalspeccovarianceSeries {
  { vals, name, meta: 0 }
}

pub fn SignalspeccovarianceSeries::len(self : SignalspeccovarianceSeries) -> Int { self.vals.length() }

pub fn SignalspeccovarianceSeries::sum(self : SignalspeccovarianceSeries) -> Double { @_common.sum(self.vals) }

pub fn SignalspeccovarianceSeries::mean(self : SignalspeccovarianceSeries) -> Double { @_common.mean(self.vals) }

pub fn SignalspeccovarianceSeries::min(self : SignalspeccovarianceSeries) -> Double { @_common.min(self.vals) }

pub fn SignalspeccovarianceSeries::max(self : SignalspeccovarianceSeries) -> Double { @_common.max(self.vals) }

pub fn SignalspeccovarianceSeries::range(self : SignalspeccovarianceSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn SignalspeccovarianceSeries::variance(self : SignalspeccovarianceSeries) -> Double { @_common.variance(self.vals) }

pub fn SignalspeccovarianceSeries::std(self : SignalspeccovarianceSeries) -> Double { @_common.std(self.vals) }

pub fn SignalspeccovarianceSeries::median(self : SignalspeccovarianceSeries) -> Double { @_common.median(self.vals) }

pub fn SignalspeccovarianceSeries::scale(self : SignalspeccovarianceSeries, f : Double) -> SignalspeccovarianceSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn SignalspeccovarianceSeries::add(self : SignalspeccovarianceSeries, other : SignalspeccovarianceSeries) -> SignalspeccovarianceSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn SignalspeccovarianceSeries::sub(self : SignalspeccovarianceSeries, other : SignalspeccovarianceSeries) -> SignalspeccovarianceSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn SignalspeccovarianceSeries::normalize(self : SignalspeccovarianceSeries) -> SignalspeccovarianceSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn SignalspeccovarianceSeries::cumsum(self : SignalspeccovarianceSeries) -> SignalspeccovarianceSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn SignalspeccovarianceSeries::to_string(self : SignalspeccovarianceSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct SignalspeccovarianceMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn signal_spec_covariance_make_matrix(rows : Int, cols : Int, val : Double) -> SignalspeccovarianceMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn signal_spec_covariance_matrix_identity(n : Int) -> SignalspeccovarianceMatrix {
  let m = signal_spec_covariance_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn SignalspeccovarianceMatrix::get(self : SignalspeccovarianceMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn SignalspeccovarianceMatrix::transpose(self : SignalspeccovarianceMatrix) -> SignalspeccovarianceMatrix {
  let result = signal_spec_covariance_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn SignalspeccovarianceMatrix::add(self : SignalspeccovarianceMatrix, other : SignalspeccovarianceMatrix) -> SignalspeccovarianceMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = signal_spec_covariance_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn SignalspeccovarianceMatrix::scale(self : SignalspeccovarianceMatrix, s : Double) -> SignalspeccovarianceMatrix {
  let result = signal_spec_covariance_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn SignalspeccovarianceMatrix::multiply(self : SignalspeccovarianceMatrix, other : SignalspeccovarianceMatrix) -> SignalspeccovarianceMatrix {
  if self.cols != other.rows { return signal_spec_covariance_make_matrix(self.rows, other.cols, 0.0) }
  let result = signal_spec_covariance_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn SignalspeccovarianceMatrix::trace(self : SignalspeccovarianceMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn SignalspeccovarianceMatrix::det(self : SignalspeccovarianceMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn SignalspeccovarianceMatrix::norm(self : SignalspeccovarianceMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn SignalspeccovarianceMatrix::to_string(self : SignalspeccovarianceMatrix) -> String {
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

pub(all) struct SignalspeccovarianceVector {
  comps : Array[Double]
  dim : Int
}

pub fn signal_spec_covariance_make_vector(comps : Array[Double]) -> SignalspeccovarianceVector {
  { comps, dim: comps.length() }
}

pub fn signal_spec_covariance_vector_zero(dim : Int) -> SignalspeccovarianceVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn SignalspeccovarianceVector::add(self : SignalspeccovarianceVector, other : SignalspeccovarianceVector) -> SignalspeccovarianceVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn SignalspeccovarianceVector::sub(self : SignalspeccovarianceVector, other : SignalspeccovarianceVector) -> SignalspeccovarianceVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn SignalspeccovarianceVector::scale(self : SignalspeccovarianceVector, s : Double) -> SignalspeccovarianceVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn SignalspeccovarianceVector::dot(self : SignalspeccovarianceVector, other : SignalspeccovarianceVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn SignalspeccovarianceVector::norm(self : SignalspeccovarianceVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn SignalspeccovarianceVector::normalize(self : SignalspeccovarianceVector) -> SignalspeccovarianceVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn SignalspeccovarianceVector::dist(self : SignalspeccovarianceVector, other : SignalspeccovarianceVector) -> Double {
  self.sub(other).norm()
}

pub fn SignalspeccovarianceVector::to_string(self : SignalspeccovarianceVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn signal_spec_covariance_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn signal_spec_covariance_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn signal_spec_covariance_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn signal_spec_covariance_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn signal_spec_covariance_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn signal_spec_covariance_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn signal_spec_covariance_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn signal_spec_covariance_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn signal_spec_covariance_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn signal_spec_covariance_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn signal_spec_covariance_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn signal_spec_covariance_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn signal_spec_covariance_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn signal_spec_covariance_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn signal_spec_covariance_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn signal_spec_covariance_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn signal_spec_covariance_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn signal_spec_covariance_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn signal_spec_covariance_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn signal_spec_covariance_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn signal_spec_covariance_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn signal_spec_covariance_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn signal_spec_covariance_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn signal_spec_covariance_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn signal_spec_covariance_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn signal_spec_covariance_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn signal_spec_covariance_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn signal_spec_covariance_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn signal_spec_covariance_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct SignalspeccovarianceFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_spec_covariance_frame_make(size : Int) -> SignalspeccovarianceFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_spec_covariance_frame_len(s : SignalspeccovarianceFrame) -> Int { s.size }

pub fn signal_spec_covariance_frame_get(s : SignalspeccovarianceFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_spec_covariance_frame_set(s : SignalspeccovarianceFrame, i : Int, v : Double) -> SignalspeccovarianceFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_spec_covariance_frame_sum(s : SignalspeccovarianceFrame) -> Double { @_common.sum(s.data) }

pub fn signal_spec_covariance_frame_mean(s : SignalspeccovarianceFrame) -> Double { @_common.mean(s.data) }

pub fn signal_spec_covariance_frame_scale(s : SignalspeccovarianceFrame, f : Double) -> SignalspeccovarianceFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_spec_covariance_frame_add(a : SignalspeccovarianceFrame, b : SignalspeccovarianceFrame) -> SignalspeccovarianceFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_spec_covariance_frame_copy(s : SignalspeccovarianceFrame) -> SignalspeccovarianceFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_spec_covariance_frame_fill(s : SignalspeccovarianceFrame, v : Double) -> SignalspeccovarianceFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_spec_covariance_frame_min(s : SignalspeccovarianceFrame) -> Double { @_common.min(s.data) }

pub fn signal_spec_covariance_frame_max(s : SignalspeccovarianceFrame) -> Double { @_common.max(s.data) }

pub fn signal_spec_covariance_frame_to_string(s : SignalspeccovarianceFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalspeccovarianceTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_spec_covariance_table_make(size : Int) -> SignalspeccovarianceTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_spec_covariance_table_len(s : SignalspeccovarianceTable) -> Int { s.size }

pub fn signal_spec_covariance_table_get(s : SignalspeccovarianceTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_spec_covariance_table_set(s : SignalspeccovarianceTable, i : Int, v : Double) -> SignalspeccovarianceTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_spec_covariance_table_sum(s : SignalspeccovarianceTable) -> Double { @_common.sum(s.data) }

pub fn signal_spec_covariance_table_mean(s : SignalspeccovarianceTable) -> Double { @_common.mean(s.data) }

pub fn signal_spec_covariance_table_scale(s : SignalspeccovarianceTable, f : Double) -> SignalspeccovarianceTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_spec_covariance_table_add(a : SignalspeccovarianceTable, b : SignalspeccovarianceTable) -> SignalspeccovarianceTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_spec_covariance_table_copy(s : SignalspeccovarianceTable) -> SignalspeccovarianceTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_spec_covariance_table_fill(s : SignalspeccovarianceTable, v : Double) -> SignalspeccovarianceTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_spec_covariance_table_min(s : SignalspeccovarianceTable) -> Double { @_common.min(s.data) }

pub fn signal_spec_covariance_table_max(s : SignalspeccovarianceTable) -> Double { @_common.max(s.data) }

pub fn signal_spec_covariance_table_to_string(s : SignalspeccovarianceTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalspeccovarianceGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_spec_covariance_graphn_make(size : Int) -> SignalspeccovarianceGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_spec_covariance_graphn_len(s : SignalspeccovarianceGraphN) -> Int { s.size }

pub fn signal_spec_covariance_graphn_get(s : SignalspeccovarianceGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_spec_covariance_graphn_set(s : SignalspeccovarianceGraphN, i : Int, v : Double) -> SignalspeccovarianceGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_spec_covariance_graphn_sum(s : SignalspeccovarianceGraphN) -> Double { @_common.sum(s.data) }

pub fn signal_spec_covariance_graphn_mean(s : SignalspeccovarianceGraphN) -> Double { @_common.mean(s.data) }

pub fn signal_spec_covariance_graphn_scale(s : SignalspeccovarianceGraphN, f : Double) -> SignalspeccovarianceGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_spec_covariance_graphn_add(a : SignalspeccovarianceGraphN, b : SignalspeccovarianceGraphN) -> SignalspeccovarianceGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_spec_covariance_graphn_copy(s : SignalspeccovarianceGraphN) -> SignalspeccovarianceGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_spec_covariance_graphn_fill(s : SignalspeccovarianceGraphN, v : Double) -> SignalspeccovarianceGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_spec_covariance_graphn_min(s : SignalspeccovarianceGraphN) -> Double { @_common.min(s.data) }

pub fn signal_spec_covariance_graphn_max(s : SignalspeccovarianceGraphN) -> Double { @_common.max(s.data) }

pub fn signal_spec_covariance_graphn_to_string(s : SignalspeccovarianceGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalspeccovarianceNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_spec_covariance_node_make(size : Int) -> SignalspeccovarianceNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_spec_covariance_node_len(s : SignalspeccovarianceNode) -> Int { s.size }

pub fn signal_spec_covariance_node_get(s : SignalspeccovarianceNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_spec_covariance_node_set(s : SignalspeccovarianceNode, i : Int, v : Double) -> SignalspeccovarianceNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_spec_covariance_node_sum(s : SignalspeccovarianceNode) -> Double { @_common.sum(s.data) }

pub fn signal_spec_covariance_node_mean(s : SignalspeccovarianceNode) -> Double { @_common.mean(s.data) }

pub fn signal_spec_covariance_node_scale(s : SignalspeccovarianceNode, f : Double) -> SignalspeccovarianceNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_spec_covariance_node_add(a : SignalspeccovarianceNode, b : SignalspeccovarianceNode) -> SignalspeccovarianceNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_spec_covariance_node_copy(s : SignalspeccovarianceNode) -> SignalspeccovarianceNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_spec_covariance_node_fill(s : SignalspeccovarianceNode, v : Double) -> SignalspeccovarianceNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_spec_covariance_node_min(s : SignalspeccovarianceNode) -> Double { @_common.min(s.data) }

pub fn signal_spec_covariance_node_max(s : SignalspeccovarianceNode) -> Double { @_common.max(s.data) }

pub fn signal_spec_covariance_node_to_string(s : SignalspeccovarianceNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalspeccovarianceEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_spec_covariance_edge_make(size : Int) -> SignalspeccovarianceEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_spec_covariance_edge_len(s : SignalspeccovarianceEdge) -> Int { s.size }

pub fn signal_spec_covariance_edge_get(s : SignalspeccovarianceEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_spec_covariance_edge_set(s : SignalspeccovarianceEdge, i : Int, v : Double) -> SignalspeccovarianceEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_spec_covariance_edge_sum(s : SignalspeccovarianceEdge) -> Double { @_common.sum(s.data) }

pub fn signal_spec_covariance_edge_mean(s : SignalspeccovarianceEdge) -> Double { @_common.mean(s.data) }

pub fn signal_spec_covariance_edge_scale(s : SignalspeccovarianceEdge, f : Double) -> SignalspeccovarianceEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_spec_covariance_edge_add(a : SignalspeccovarianceEdge, b : SignalspeccovarianceEdge) -> SignalspeccovarianceEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_spec_covariance_edge_copy(s : SignalspeccovarianceEdge) -> SignalspeccovarianceEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_spec_covariance_edge_fill(s : SignalspeccovarianceEdge, v : Double) -> SignalspeccovarianceEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_spec_covariance_edge_min(s : SignalspeccovarianceEdge) -> Double { @_common.min(s.data) }

pub fn signal_spec_covariance_edge_max(s : SignalspeccovarianceEdge) -> Double { @_common.max(s.data) }

pub fn signal_spec_covariance_edge_to_string(s : SignalspeccovarianceEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalspeccovariancePath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_spec_covariance_path_make(size : Int) -> SignalspeccovariancePath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_spec_covariance_path_len(s : SignalspeccovariancePath) -> Int { s.size }

pub fn signal_spec_covariance_path_get(s : SignalspeccovariancePath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_spec_covariance_path_set(s : SignalspeccovariancePath, i : Int, v : Double) -> SignalspeccovariancePath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_spec_covariance_path_sum(s : SignalspeccovariancePath) -> Double { @_common.sum(s.data) }

pub fn signal_spec_covariance_path_mean(s : SignalspeccovariancePath) -> Double { @_common.mean(s.data) }

pub fn signal_spec_covariance_path_scale(s : SignalspeccovariancePath, f : Double) -> SignalspeccovariancePath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_spec_covariance_path_add(a : SignalspeccovariancePath, b : SignalspeccovariancePath) -> SignalspeccovariancePath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_spec_covariance_path_copy(s : SignalspeccovariancePath) -> SignalspeccovariancePath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_spec_covariance_path_fill(s : SignalspeccovariancePath, v : Double) -> SignalspeccovariancePath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_spec_covariance_path_min(s : SignalspeccovariancePath) -> Double { @_common.min(s.data) }

pub fn signal_spec_covariance_path_max(s : SignalspeccovariancePath) -> Double { @_common.max(s.data) }

pub fn signal_spec_covariance_path_to_string(s : SignalspeccovariancePath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalspeccovarianceCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_spec_covariance_cluster_make(size : Int) -> SignalspeccovarianceCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_spec_covariance_cluster_len(s : SignalspeccovarianceCluster) -> Int { s.size }

pub fn signal_spec_covariance_cluster_get(s : SignalspeccovarianceCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_spec_covariance_cluster_set(s : SignalspeccovarianceCluster, i : Int, v : Double) -> SignalspeccovarianceCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_spec_covariance_cluster_sum(s : SignalspeccovarianceCluster) -> Double { @_common.sum(s.data) }

pub fn signal_spec_covariance_cluster_mean(s : SignalspeccovarianceCluster) -> Double { @_common.mean(s.data) }

pub fn signal_spec_covariance_cluster_scale(s : SignalspeccovarianceCluster, f : Double) -> SignalspeccovarianceCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_spec_covariance_cluster_add(a : SignalspeccovarianceCluster, b : SignalspeccovarianceCluster) -> SignalspeccovarianceCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_spec_covariance_cluster_copy(s : SignalspeccovarianceCluster) -> SignalspeccovarianceCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_spec_covariance_cluster_fill(s : SignalspeccovarianceCluster, v : Double) -> SignalspeccovarianceCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_spec_covariance_cluster_min(s : SignalspeccovarianceCluster) -> Double { @_common.min(s.data) }

pub fn signal_spec_covariance_cluster_max(s : SignalspeccovarianceCluster) -> Double { @_common.max(s.data) }

pub fn signal_spec_covariance_cluster_to_string(s : SignalspeccovarianceCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalspeccovarianceModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_spec_covariance_model_make(size : Int) -> SignalspeccovarianceModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_spec_covariance_model_len(s : SignalspeccovarianceModel) -> Int { s.size }

pub fn signal_spec_covariance_model_get(s : SignalspeccovarianceModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_spec_covariance_model_set(s : SignalspeccovarianceModel, i : Int, v : Double) -> SignalspeccovarianceModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_spec_covariance_model_sum(s : SignalspeccovarianceModel) -> Double { @_common.sum(s.data) }

pub fn signal_spec_covariance_model_mean(s : SignalspeccovarianceModel) -> Double { @_common.mean(s.data) }

pub fn signal_spec_covariance_model_scale(s : SignalspeccovarianceModel, f : Double) -> SignalspeccovarianceModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_spec_covariance_model_add(a : SignalspeccovarianceModel, b : SignalspeccovarianceModel) -> SignalspeccovarianceModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_spec_covariance_model_copy(s : SignalspeccovarianceModel) -> SignalspeccovarianceModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_spec_covariance_model_fill(s : SignalspeccovarianceModel, v : Double) -> SignalspeccovarianceModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_spec_covariance_model_min(s : SignalspeccovarianceModel) -> Double { @_common.min(s.data) }

pub fn signal_spec_covariance_model_max(s : SignalspeccovarianceModel) -> Double { @_common.max(s.data) }

pub fn signal_spec_covariance_model_to_string(s : SignalspeccovarianceModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalspeccovarianceLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_spec_covariance_layer_make(size : Int) -> SignalspeccovarianceLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_spec_covariance_layer_len(s : SignalspeccovarianceLayer) -> Int { s.size }

pub fn signal_spec_covariance_layer_get(s : SignalspeccovarianceLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_spec_covariance_layer_set(s : SignalspeccovarianceLayer, i : Int, v : Double) -> SignalspeccovarianceLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_spec_covariance_layer_sum(s : SignalspeccovarianceLayer) -> Double { @_common.sum(s.data) }

pub fn signal_spec_covariance_layer_mean(s : SignalspeccovarianceLayer) -> Double { @_common.mean(s.data) }

pub fn signal_spec_covariance_layer_scale(s : SignalspeccovarianceLayer, f : Double) -> SignalspeccovarianceLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_spec_covariance_layer_add(a : SignalspeccovarianceLayer, b : SignalspeccovarianceLayer) -> SignalspeccovarianceLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_spec_covariance_layer_copy(s : SignalspeccovarianceLayer) -> SignalspeccovarianceLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_spec_covariance_layer_fill(s : SignalspeccovarianceLayer, v : Double) -> SignalspeccovarianceLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_spec_covariance_layer_min(s : SignalspeccovarianceLayer) -> Double { @_common.min(s.data) }

pub fn signal_spec_covariance_layer_max(s : SignalspeccovarianceLayer) -> Double { @_common.max(s.data) }

pub fn signal_spec_covariance_layer_to_string(s : SignalspeccovarianceLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalspeccovarianceBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_spec_covariance_buffer_make(size : Int) -> SignalspeccovarianceBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_spec_covariance_buffer_len(s : SignalspeccovarianceBuffer) -> Int { s.size }

pub fn signal_spec_covariance_buffer_get(s : SignalspeccovarianceBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_spec_covariance_buffer_set(s : SignalspeccovarianceBuffer, i : Int, v : Double) -> SignalspeccovarianceBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_spec_covariance_buffer_sum(s : SignalspeccovarianceBuffer) -> Double { @_common.sum(s.data) }

pub fn signal_spec_covariance_buffer_mean(s : SignalspeccovarianceBuffer) -> Double { @_common.mean(s.data) }

pub fn signal_spec_covariance_buffer_scale(s : SignalspeccovarianceBuffer, f : Double) -> SignalspeccovarianceBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_spec_covariance_buffer_add(a : SignalspeccovarianceBuffer, b : SignalspeccovarianceBuffer) -> SignalspeccovarianceBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_spec_covariance_buffer_copy(s : SignalspeccovarianceBuffer) -> SignalspeccovarianceBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_spec_covariance_buffer_fill(s : SignalspeccovarianceBuffer, v : Double) -> SignalspeccovarianceBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_spec_covariance_buffer_min(s : SignalspeccovarianceBuffer) -> Double { @_common.min(s.data) }

pub fn signal_spec_covariance_buffer_max(s : SignalspeccovarianceBuffer) -> Double { @_common.max(s.data) }

pub fn signal_spec_covariance_buffer_to_string(s : SignalspeccovarianceBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalspeccovarianceCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_spec_covariance_cursor_make(size : Int) -> SignalspeccovarianceCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_spec_covariance_cursor_len(s : SignalspeccovarianceCursor) -> Int { s.size }

pub fn signal_spec_covariance_cursor_get(s : SignalspeccovarianceCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_spec_covariance_cursor_set(s : SignalspeccovarianceCursor, i : Int, v : Double) -> SignalspeccovarianceCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_spec_covariance_cursor_sum(s : SignalspeccovarianceCursor) -> Double { @_common.sum(s.data) }

pub fn signal_spec_covariance_cursor_mean(s : SignalspeccovarianceCursor) -> Double { @_common.mean(s.data) }

pub fn signal_spec_covariance_cursor_scale(s : SignalspeccovarianceCursor, f : Double) -> SignalspeccovarianceCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_spec_covariance_cursor_add(a : SignalspeccovarianceCursor, b : SignalspeccovarianceCursor) -> SignalspeccovarianceCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_spec_covariance_cursor_copy(s : SignalspeccovarianceCursor) -> SignalspeccovarianceCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_spec_covariance_cursor_fill(s : SignalspeccovarianceCursor, v : Double) -> SignalspeccovarianceCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_spec_covariance_cursor_min(s : SignalspeccovarianceCursor) -> Double { @_common.min(s.data) }

pub fn signal_spec_covariance_cursor_max(s : SignalspeccovarianceCursor) -> Double { @_common.max(s.data) }

pub fn signal_spec_covariance_cursor_to_string(s : SignalspeccovarianceCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalspeccovarianceView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_spec_covariance_view_make(size : Int) -> SignalspeccovarianceView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_spec_covariance_view_len(s : SignalspeccovarianceView) -> Int { s.size }

pub fn signal_spec_covariance_view_get(s : SignalspeccovarianceView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_spec_covariance_view_set(s : SignalspeccovarianceView, i : Int, v : Double) -> SignalspeccovarianceView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_spec_covariance_view_sum(s : SignalspeccovarianceView) -> Double { @_common.sum(s.data) }

pub fn signal_spec_covariance_view_mean(s : SignalspeccovarianceView) -> Double { @_common.mean(s.data) }

pub fn signal_spec_covariance_view_scale(s : SignalspeccovarianceView, f : Double) -> SignalspeccovarianceView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_spec_covariance_view_add(a : SignalspeccovarianceView, b : SignalspeccovarianceView) -> SignalspeccovarianceView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_spec_covariance_view_copy(s : SignalspeccovarianceView) -> SignalspeccovarianceView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_spec_covariance_view_fill(s : SignalspeccovarianceView, v : Double) -> SignalspeccovarianceView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_spec_covariance_view_min(s : SignalspeccovarianceView) -> Double { @_common.min(s.data) }

pub fn signal_spec_covariance_view_max(s : SignalspeccovarianceView) -> Double { @_common.max(s.data) }

pub fn signal_spec_covariance_view_to_string(s : SignalspeccovarianceView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalspeccovarianceRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_spec_covariance_range_make(size : Int) -> SignalspeccovarianceRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_spec_covariance_range_len(s : SignalspeccovarianceRange) -> Int { s.size }

pub fn signal_spec_covariance_range_get(s : SignalspeccovarianceRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_spec_covariance_range_set(s : SignalspeccovarianceRange, i : Int, v : Double) -> SignalspeccovarianceRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_spec_covariance_range_sum(s : SignalspeccovarianceRange) -> Double { @_common.sum(s.data) }

pub fn signal_spec_covariance_range_mean(s : SignalspeccovarianceRange) -> Double { @_common.mean(s.data) }

pub fn signal_spec_covariance_range_scale(s : SignalspeccovarianceRange, f : Double) -> SignalspeccovarianceRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_spec_covariance_range_add(a : SignalspeccovarianceRange, b : SignalspeccovarianceRange) -> SignalspeccovarianceRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_spec_covariance_range_copy(s : SignalspeccovarianceRange) -> SignalspeccovarianceRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_spec_covariance_range_fill(s : SignalspeccovarianceRange, v : Double) -> SignalspeccovarianceRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_spec_covariance_range_min(s : SignalspeccovarianceRange) -> Double { @_common.min(s.data) }

pub fn signal_spec_covariance_range_max(s : SignalspeccovarianceRange) -> Double { @_common.max(s.data) }

pub fn signal_spec_covariance_range_to_string(s : SignalspeccovarianceRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalspeccovarianceSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_spec_covariance_slice_make(size : Int) -> SignalspeccovarianceSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_spec_covariance_slice_len(s : SignalspeccovarianceSlice) -> Int { s.size }

pub fn signal_spec_covariance_slice_get(s : SignalspeccovarianceSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_spec_covariance_slice_set(s : SignalspeccovarianceSlice, i : Int, v : Double) -> SignalspeccovarianceSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_spec_covariance_slice_sum(s : SignalspeccovarianceSlice) -> Double { @_common.sum(s.data) }

pub fn signal_spec_covariance_slice_mean(s : SignalspeccovarianceSlice) -> Double { @_common.mean(s.data) }

pub fn signal_spec_covariance_slice_scale(s : SignalspeccovarianceSlice, f : Double) -> SignalspeccovarianceSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_spec_covariance_slice_add(a : SignalspeccovarianceSlice, b : SignalspeccovarianceSlice) -> SignalspeccovarianceSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_spec_covariance_slice_copy(s : SignalspeccovarianceSlice) -> SignalspeccovarianceSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_spec_covariance_slice_fill(s : SignalspeccovarianceSlice, v : Double) -> SignalspeccovarianceSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_spec_covariance_slice_min(s : SignalspeccovarianceSlice) -> Double { @_common.min(s.data) }

pub fn signal_spec_covariance_slice_max(s : SignalspeccovarianceSlice) -> Double { @_common.max(s.data) }

pub fn signal_spec_covariance_slice_to_string(s : SignalspeccovarianceSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

