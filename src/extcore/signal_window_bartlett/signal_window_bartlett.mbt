///===
/// extcore/signal_window_bartlett

pub(all) struct SignalwindowbartlettPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn signal_window_bartlett_make_point(x : Double, y : Double) -> SignalwindowbartlettPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn signal_window_bartlett_make_point3(x : Double, y : Double, z : Double) -> SignalwindowbartlettPoint {
  { x, y, z, label: 0 }
}

pub fn SignalwindowbartlettPoint::x(self : SignalwindowbartlettPoint) -> Double { self.x }

pub fn SignalwindowbartlettPoint::y(self : SignalwindowbartlettPoint) -> Double { self.y }

pub fn SignalwindowbartlettPoint::z(self : SignalwindowbartlettPoint) -> Double { self.z }

pub fn SignalwindowbartlettPoint::label(self : SignalwindowbartlettPoint) -> Int { self.label }

pub fn SignalwindowbartlettPoint::dist(self : SignalwindowbartlettPoint, other : SignalwindowbartlettPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn SignalwindowbartlettPoint::add(self : SignalwindowbartlettPoint, other : SignalwindowbartlettPoint) -> SignalwindowbartlettPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn SignalwindowbartlettPoint::sub(self : SignalwindowbartlettPoint, other : SignalwindowbartlettPoint) -> SignalwindowbartlettPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn SignalwindowbartlettPoint::scale(self : SignalwindowbartlettPoint, s : Double) -> SignalwindowbartlettPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn SignalwindowbartlettPoint::dot(self : SignalwindowbartlettPoint, other : SignalwindowbartlettPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn SignalwindowbartlettPoint::cross(self : SignalwindowbartlettPoint, other : SignalwindowbartlettPoint) -> SignalwindowbartlettPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn SignalwindowbartlettPoint::norm(self : SignalwindowbartlettPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn SignalwindowbartlettPoint::normalize(self : SignalwindowbartlettPoint) -> SignalwindowbartlettPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn SignalwindowbartlettPoint::negate(self : SignalwindowbartlettPoint) -> SignalwindowbartlettPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn SignalwindowbartlettPoint::mid(self : SignalwindowbartlettPoint, other : SignalwindowbartlettPoint) -> SignalwindowbartlettPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn SignalwindowbartlettPoint::lerp(self : SignalwindowbartlettPoint, other : SignalwindowbartlettPoint, t : Double) -> SignalwindowbartlettPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn SignalwindowbartlettPoint::to_string(self : SignalwindowbartlettPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct SignalwindowbartlettSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn signal_window_bartlett_make_series(vals : Array[Double], name : String) -> SignalwindowbartlettSeries {
  { vals, name, meta: 0 }
}

pub fn SignalwindowbartlettSeries::len(self : SignalwindowbartlettSeries) -> Int { self.vals.length() }

pub fn SignalwindowbartlettSeries::sum(self : SignalwindowbartlettSeries) -> Double { @_common.sum(self.vals) }

pub fn SignalwindowbartlettSeries::mean(self : SignalwindowbartlettSeries) -> Double { @_common.mean(self.vals) }

pub fn SignalwindowbartlettSeries::min(self : SignalwindowbartlettSeries) -> Double { @_common.min(self.vals) }

pub fn SignalwindowbartlettSeries::max(self : SignalwindowbartlettSeries) -> Double { @_common.max(self.vals) }

pub fn SignalwindowbartlettSeries::range(self : SignalwindowbartlettSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn SignalwindowbartlettSeries::variance(self : SignalwindowbartlettSeries) -> Double { @_common.variance(self.vals) }

pub fn SignalwindowbartlettSeries::std(self : SignalwindowbartlettSeries) -> Double { @_common.std(self.vals) }

pub fn SignalwindowbartlettSeries::median(self : SignalwindowbartlettSeries) -> Double { @_common.median(self.vals) }

pub fn SignalwindowbartlettSeries::scale(self : SignalwindowbartlettSeries, f : Double) -> SignalwindowbartlettSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn SignalwindowbartlettSeries::add(self : SignalwindowbartlettSeries, other : SignalwindowbartlettSeries) -> SignalwindowbartlettSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn SignalwindowbartlettSeries::sub(self : SignalwindowbartlettSeries, other : SignalwindowbartlettSeries) -> SignalwindowbartlettSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn SignalwindowbartlettSeries::normalize(self : SignalwindowbartlettSeries) -> SignalwindowbartlettSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn SignalwindowbartlettSeries::cumsum(self : SignalwindowbartlettSeries) -> SignalwindowbartlettSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn SignalwindowbartlettSeries::to_string(self : SignalwindowbartlettSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct SignalwindowbartlettMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn signal_window_bartlett_make_matrix(rows : Int, cols : Int, val : Double) -> SignalwindowbartlettMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn signal_window_bartlett_matrix_identity(n : Int) -> SignalwindowbartlettMatrix {
  let m = signal_window_bartlett_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn SignalwindowbartlettMatrix::get(self : SignalwindowbartlettMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn SignalwindowbartlettMatrix::transpose(self : SignalwindowbartlettMatrix) -> SignalwindowbartlettMatrix {
  let result = signal_window_bartlett_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn SignalwindowbartlettMatrix::add(self : SignalwindowbartlettMatrix, other : SignalwindowbartlettMatrix) -> SignalwindowbartlettMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = signal_window_bartlett_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn SignalwindowbartlettMatrix::scale(self : SignalwindowbartlettMatrix, s : Double) -> SignalwindowbartlettMatrix {
  let result = signal_window_bartlett_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn SignalwindowbartlettMatrix::multiply(self : SignalwindowbartlettMatrix, other : SignalwindowbartlettMatrix) -> SignalwindowbartlettMatrix {
  if self.cols != other.rows { return signal_window_bartlett_make_matrix(self.rows, other.cols, 0.0) }
  let result = signal_window_bartlett_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn SignalwindowbartlettMatrix::trace(self : SignalwindowbartlettMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn SignalwindowbartlettMatrix::det(self : SignalwindowbartlettMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn SignalwindowbartlettMatrix::norm(self : SignalwindowbartlettMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn SignalwindowbartlettMatrix::to_string(self : SignalwindowbartlettMatrix) -> String {
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

pub(all) struct SignalwindowbartlettVector {
  comps : Array[Double]
  dim : Int
}

pub fn signal_window_bartlett_make_vector(comps : Array[Double]) -> SignalwindowbartlettVector {
  { comps, dim: comps.length() }
}

pub fn signal_window_bartlett_vector_zero(dim : Int) -> SignalwindowbartlettVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn SignalwindowbartlettVector::add(self : SignalwindowbartlettVector, other : SignalwindowbartlettVector) -> SignalwindowbartlettVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn SignalwindowbartlettVector::sub(self : SignalwindowbartlettVector, other : SignalwindowbartlettVector) -> SignalwindowbartlettVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn SignalwindowbartlettVector::scale(self : SignalwindowbartlettVector, s : Double) -> SignalwindowbartlettVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn SignalwindowbartlettVector::dot(self : SignalwindowbartlettVector, other : SignalwindowbartlettVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn SignalwindowbartlettVector::norm(self : SignalwindowbartlettVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn SignalwindowbartlettVector::normalize(self : SignalwindowbartlettVector) -> SignalwindowbartlettVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn SignalwindowbartlettVector::dist(self : SignalwindowbartlettVector, other : SignalwindowbartlettVector) -> Double {
  self.sub(other).norm()
}

pub fn SignalwindowbartlettVector::to_string(self : SignalwindowbartlettVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn signal_window_bartlett_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn signal_window_bartlett_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn signal_window_bartlett_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn signal_window_bartlett_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn signal_window_bartlett_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn signal_window_bartlett_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn signal_window_bartlett_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn signal_window_bartlett_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn signal_window_bartlett_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn signal_window_bartlett_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn signal_window_bartlett_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn signal_window_bartlett_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn signal_window_bartlett_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn signal_window_bartlett_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn signal_window_bartlett_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn signal_window_bartlett_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn signal_window_bartlett_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn signal_window_bartlett_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn signal_window_bartlett_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn signal_window_bartlett_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn signal_window_bartlett_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn signal_window_bartlett_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn signal_window_bartlett_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn signal_window_bartlett_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn signal_window_bartlett_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn signal_window_bartlett_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn signal_window_bartlett_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn signal_window_bartlett_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn signal_window_bartlett_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct SignalwindowbartlettFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_window_bartlett_frame_make(size : Int) -> SignalwindowbartlettFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_window_bartlett_frame_len(s : SignalwindowbartlettFrame) -> Int { s.size }

pub fn signal_window_bartlett_frame_get(s : SignalwindowbartlettFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_window_bartlett_frame_set(s : SignalwindowbartlettFrame, i : Int, v : Double) -> SignalwindowbartlettFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_window_bartlett_frame_sum(s : SignalwindowbartlettFrame) -> Double { @_common.sum(s.data) }

pub fn signal_window_bartlett_frame_mean(s : SignalwindowbartlettFrame) -> Double { @_common.mean(s.data) }

pub fn signal_window_bartlett_frame_scale(s : SignalwindowbartlettFrame, f : Double) -> SignalwindowbartlettFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_window_bartlett_frame_add(a : SignalwindowbartlettFrame, b : SignalwindowbartlettFrame) -> SignalwindowbartlettFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_window_bartlett_frame_copy(s : SignalwindowbartlettFrame) -> SignalwindowbartlettFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_window_bartlett_frame_fill(s : SignalwindowbartlettFrame, v : Double) -> SignalwindowbartlettFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_window_bartlett_frame_min(s : SignalwindowbartlettFrame) -> Double { @_common.min(s.data) }

pub fn signal_window_bartlett_frame_max(s : SignalwindowbartlettFrame) -> Double { @_common.max(s.data) }

pub fn signal_window_bartlett_frame_to_string(s : SignalwindowbartlettFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalwindowbartlettTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_window_bartlett_table_make(size : Int) -> SignalwindowbartlettTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_window_bartlett_table_len(s : SignalwindowbartlettTable) -> Int { s.size }

pub fn signal_window_bartlett_table_get(s : SignalwindowbartlettTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_window_bartlett_table_set(s : SignalwindowbartlettTable, i : Int, v : Double) -> SignalwindowbartlettTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_window_bartlett_table_sum(s : SignalwindowbartlettTable) -> Double { @_common.sum(s.data) }

pub fn signal_window_bartlett_table_mean(s : SignalwindowbartlettTable) -> Double { @_common.mean(s.data) }

pub fn signal_window_bartlett_table_scale(s : SignalwindowbartlettTable, f : Double) -> SignalwindowbartlettTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_window_bartlett_table_add(a : SignalwindowbartlettTable, b : SignalwindowbartlettTable) -> SignalwindowbartlettTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_window_bartlett_table_copy(s : SignalwindowbartlettTable) -> SignalwindowbartlettTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_window_bartlett_table_fill(s : SignalwindowbartlettTable, v : Double) -> SignalwindowbartlettTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_window_bartlett_table_min(s : SignalwindowbartlettTable) -> Double { @_common.min(s.data) }

pub fn signal_window_bartlett_table_max(s : SignalwindowbartlettTable) -> Double { @_common.max(s.data) }

pub fn signal_window_bartlett_table_to_string(s : SignalwindowbartlettTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalwindowbartlettGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_window_bartlett_graphn_make(size : Int) -> SignalwindowbartlettGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_window_bartlett_graphn_len(s : SignalwindowbartlettGraphN) -> Int { s.size }

pub fn signal_window_bartlett_graphn_get(s : SignalwindowbartlettGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_window_bartlett_graphn_set(s : SignalwindowbartlettGraphN, i : Int, v : Double) -> SignalwindowbartlettGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_window_bartlett_graphn_sum(s : SignalwindowbartlettGraphN) -> Double { @_common.sum(s.data) }

pub fn signal_window_bartlett_graphn_mean(s : SignalwindowbartlettGraphN) -> Double { @_common.mean(s.data) }

pub fn signal_window_bartlett_graphn_scale(s : SignalwindowbartlettGraphN, f : Double) -> SignalwindowbartlettGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_window_bartlett_graphn_add(a : SignalwindowbartlettGraphN, b : SignalwindowbartlettGraphN) -> SignalwindowbartlettGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_window_bartlett_graphn_copy(s : SignalwindowbartlettGraphN) -> SignalwindowbartlettGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_window_bartlett_graphn_fill(s : SignalwindowbartlettGraphN, v : Double) -> SignalwindowbartlettGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_window_bartlett_graphn_min(s : SignalwindowbartlettGraphN) -> Double { @_common.min(s.data) }

pub fn signal_window_bartlett_graphn_max(s : SignalwindowbartlettGraphN) -> Double { @_common.max(s.data) }

pub fn signal_window_bartlett_graphn_to_string(s : SignalwindowbartlettGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalwindowbartlettNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_window_bartlett_node_make(size : Int) -> SignalwindowbartlettNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_window_bartlett_node_len(s : SignalwindowbartlettNode) -> Int { s.size }

pub fn signal_window_bartlett_node_get(s : SignalwindowbartlettNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_window_bartlett_node_set(s : SignalwindowbartlettNode, i : Int, v : Double) -> SignalwindowbartlettNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_window_bartlett_node_sum(s : SignalwindowbartlettNode) -> Double { @_common.sum(s.data) }

pub fn signal_window_bartlett_node_mean(s : SignalwindowbartlettNode) -> Double { @_common.mean(s.data) }

pub fn signal_window_bartlett_node_scale(s : SignalwindowbartlettNode, f : Double) -> SignalwindowbartlettNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_window_bartlett_node_add(a : SignalwindowbartlettNode, b : SignalwindowbartlettNode) -> SignalwindowbartlettNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_window_bartlett_node_copy(s : SignalwindowbartlettNode) -> SignalwindowbartlettNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_window_bartlett_node_fill(s : SignalwindowbartlettNode, v : Double) -> SignalwindowbartlettNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_window_bartlett_node_min(s : SignalwindowbartlettNode) -> Double { @_common.min(s.data) }

pub fn signal_window_bartlett_node_max(s : SignalwindowbartlettNode) -> Double { @_common.max(s.data) }

pub fn signal_window_bartlett_node_to_string(s : SignalwindowbartlettNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalwindowbartlettEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_window_bartlett_edge_make(size : Int) -> SignalwindowbartlettEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_window_bartlett_edge_len(s : SignalwindowbartlettEdge) -> Int { s.size }

pub fn signal_window_bartlett_edge_get(s : SignalwindowbartlettEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_window_bartlett_edge_set(s : SignalwindowbartlettEdge, i : Int, v : Double) -> SignalwindowbartlettEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_window_bartlett_edge_sum(s : SignalwindowbartlettEdge) -> Double { @_common.sum(s.data) }

pub fn signal_window_bartlett_edge_mean(s : SignalwindowbartlettEdge) -> Double { @_common.mean(s.data) }

pub fn signal_window_bartlett_edge_scale(s : SignalwindowbartlettEdge, f : Double) -> SignalwindowbartlettEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_window_bartlett_edge_add(a : SignalwindowbartlettEdge, b : SignalwindowbartlettEdge) -> SignalwindowbartlettEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_window_bartlett_edge_copy(s : SignalwindowbartlettEdge) -> SignalwindowbartlettEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_window_bartlett_edge_fill(s : SignalwindowbartlettEdge, v : Double) -> SignalwindowbartlettEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_window_bartlett_edge_min(s : SignalwindowbartlettEdge) -> Double { @_common.min(s.data) }

pub fn signal_window_bartlett_edge_max(s : SignalwindowbartlettEdge) -> Double { @_common.max(s.data) }

pub fn signal_window_bartlett_edge_to_string(s : SignalwindowbartlettEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalwindowbartlettPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_window_bartlett_path_make(size : Int) -> SignalwindowbartlettPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_window_bartlett_path_len(s : SignalwindowbartlettPath) -> Int { s.size }

pub fn signal_window_bartlett_path_get(s : SignalwindowbartlettPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_window_bartlett_path_set(s : SignalwindowbartlettPath, i : Int, v : Double) -> SignalwindowbartlettPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_window_bartlett_path_sum(s : SignalwindowbartlettPath) -> Double { @_common.sum(s.data) }

pub fn signal_window_bartlett_path_mean(s : SignalwindowbartlettPath) -> Double { @_common.mean(s.data) }

pub fn signal_window_bartlett_path_scale(s : SignalwindowbartlettPath, f : Double) -> SignalwindowbartlettPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_window_bartlett_path_add(a : SignalwindowbartlettPath, b : SignalwindowbartlettPath) -> SignalwindowbartlettPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_window_bartlett_path_copy(s : SignalwindowbartlettPath) -> SignalwindowbartlettPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_window_bartlett_path_fill(s : SignalwindowbartlettPath, v : Double) -> SignalwindowbartlettPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_window_bartlett_path_min(s : SignalwindowbartlettPath) -> Double { @_common.min(s.data) }

pub fn signal_window_bartlett_path_max(s : SignalwindowbartlettPath) -> Double { @_common.max(s.data) }

pub fn signal_window_bartlett_path_to_string(s : SignalwindowbartlettPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalwindowbartlettCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_window_bartlett_cluster_make(size : Int) -> SignalwindowbartlettCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_window_bartlett_cluster_len(s : SignalwindowbartlettCluster) -> Int { s.size }

pub fn signal_window_bartlett_cluster_get(s : SignalwindowbartlettCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_window_bartlett_cluster_set(s : SignalwindowbartlettCluster, i : Int, v : Double) -> SignalwindowbartlettCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_window_bartlett_cluster_sum(s : SignalwindowbartlettCluster) -> Double { @_common.sum(s.data) }

pub fn signal_window_bartlett_cluster_mean(s : SignalwindowbartlettCluster) -> Double { @_common.mean(s.data) }

pub fn signal_window_bartlett_cluster_scale(s : SignalwindowbartlettCluster, f : Double) -> SignalwindowbartlettCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_window_bartlett_cluster_add(a : SignalwindowbartlettCluster, b : SignalwindowbartlettCluster) -> SignalwindowbartlettCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_window_bartlett_cluster_copy(s : SignalwindowbartlettCluster) -> SignalwindowbartlettCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_window_bartlett_cluster_fill(s : SignalwindowbartlettCluster, v : Double) -> SignalwindowbartlettCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_window_bartlett_cluster_min(s : SignalwindowbartlettCluster) -> Double { @_common.min(s.data) }

pub fn signal_window_bartlett_cluster_max(s : SignalwindowbartlettCluster) -> Double { @_common.max(s.data) }

pub fn signal_window_bartlett_cluster_to_string(s : SignalwindowbartlettCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalwindowbartlettModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_window_bartlett_model_make(size : Int) -> SignalwindowbartlettModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_window_bartlett_model_len(s : SignalwindowbartlettModel) -> Int { s.size }

pub fn signal_window_bartlett_model_get(s : SignalwindowbartlettModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_window_bartlett_model_set(s : SignalwindowbartlettModel, i : Int, v : Double) -> SignalwindowbartlettModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_window_bartlett_model_sum(s : SignalwindowbartlettModel) -> Double { @_common.sum(s.data) }

pub fn signal_window_bartlett_model_mean(s : SignalwindowbartlettModel) -> Double { @_common.mean(s.data) }

pub fn signal_window_bartlett_model_scale(s : SignalwindowbartlettModel, f : Double) -> SignalwindowbartlettModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_window_bartlett_model_add(a : SignalwindowbartlettModel, b : SignalwindowbartlettModel) -> SignalwindowbartlettModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_window_bartlett_model_copy(s : SignalwindowbartlettModel) -> SignalwindowbartlettModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_window_bartlett_model_fill(s : SignalwindowbartlettModel, v : Double) -> SignalwindowbartlettModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_window_bartlett_model_min(s : SignalwindowbartlettModel) -> Double { @_common.min(s.data) }

pub fn signal_window_bartlett_model_max(s : SignalwindowbartlettModel) -> Double { @_common.max(s.data) }

pub fn signal_window_bartlett_model_to_string(s : SignalwindowbartlettModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalwindowbartlettLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_window_bartlett_layer_make(size : Int) -> SignalwindowbartlettLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_window_bartlett_layer_len(s : SignalwindowbartlettLayer) -> Int { s.size }

pub fn signal_window_bartlett_layer_get(s : SignalwindowbartlettLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_window_bartlett_layer_set(s : SignalwindowbartlettLayer, i : Int, v : Double) -> SignalwindowbartlettLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_window_bartlett_layer_sum(s : SignalwindowbartlettLayer) -> Double { @_common.sum(s.data) }

pub fn signal_window_bartlett_layer_mean(s : SignalwindowbartlettLayer) -> Double { @_common.mean(s.data) }

pub fn signal_window_bartlett_layer_scale(s : SignalwindowbartlettLayer, f : Double) -> SignalwindowbartlettLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_window_bartlett_layer_add(a : SignalwindowbartlettLayer, b : SignalwindowbartlettLayer) -> SignalwindowbartlettLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_window_bartlett_layer_copy(s : SignalwindowbartlettLayer) -> SignalwindowbartlettLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_window_bartlett_layer_fill(s : SignalwindowbartlettLayer, v : Double) -> SignalwindowbartlettLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_window_bartlett_layer_min(s : SignalwindowbartlettLayer) -> Double { @_common.min(s.data) }

pub fn signal_window_bartlett_layer_max(s : SignalwindowbartlettLayer) -> Double { @_common.max(s.data) }

pub fn signal_window_bartlett_layer_to_string(s : SignalwindowbartlettLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalwindowbartlettBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_window_bartlett_buffer_make(size : Int) -> SignalwindowbartlettBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_window_bartlett_buffer_len(s : SignalwindowbartlettBuffer) -> Int { s.size }

pub fn signal_window_bartlett_buffer_get(s : SignalwindowbartlettBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_window_bartlett_buffer_set(s : SignalwindowbartlettBuffer, i : Int, v : Double) -> SignalwindowbartlettBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_window_bartlett_buffer_sum(s : SignalwindowbartlettBuffer) -> Double { @_common.sum(s.data) }

pub fn signal_window_bartlett_buffer_mean(s : SignalwindowbartlettBuffer) -> Double { @_common.mean(s.data) }

pub fn signal_window_bartlett_buffer_scale(s : SignalwindowbartlettBuffer, f : Double) -> SignalwindowbartlettBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_window_bartlett_buffer_add(a : SignalwindowbartlettBuffer, b : SignalwindowbartlettBuffer) -> SignalwindowbartlettBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_window_bartlett_buffer_copy(s : SignalwindowbartlettBuffer) -> SignalwindowbartlettBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_window_bartlett_buffer_fill(s : SignalwindowbartlettBuffer, v : Double) -> SignalwindowbartlettBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_window_bartlett_buffer_min(s : SignalwindowbartlettBuffer) -> Double { @_common.min(s.data) }

pub fn signal_window_bartlett_buffer_max(s : SignalwindowbartlettBuffer) -> Double { @_common.max(s.data) }

pub fn signal_window_bartlett_buffer_to_string(s : SignalwindowbartlettBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalwindowbartlettCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_window_bartlett_cursor_make(size : Int) -> SignalwindowbartlettCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_window_bartlett_cursor_len(s : SignalwindowbartlettCursor) -> Int { s.size }

pub fn signal_window_bartlett_cursor_get(s : SignalwindowbartlettCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_window_bartlett_cursor_set(s : SignalwindowbartlettCursor, i : Int, v : Double) -> SignalwindowbartlettCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_window_bartlett_cursor_sum(s : SignalwindowbartlettCursor) -> Double { @_common.sum(s.data) }

pub fn signal_window_bartlett_cursor_mean(s : SignalwindowbartlettCursor) -> Double { @_common.mean(s.data) }

pub fn signal_window_bartlett_cursor_scale(s : SignalwindowbartlettCursor, f : Double) -> SignalwindowbartlettCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_window_bartlett_cursor_add(a : SignalwindowbartlettCursor, b : SignalwindowbartlettCursor) -> SignalwindowbartlettCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_window_bartlett_cursor_copy(s : SignalwindowbartlettCursor) -> SignalwindowbartlettCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_window_bartlett_cursor_fill(s : SignalwindowbartlettCursor, v : Double) -> SignalwindowbartlettCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_window_bartlett_cursor_min(s : SignalwindowbartlettCursor) -> Double { @_common.min(s.data) }

pub fn signal_window_bartlett_cursor_max(s : SignalwindowbartlettCursor) -> Double { @_common.max(s.data) }

pub fn signal_window_bartlett_cursor_to_string(s : SignalwindowbartlettCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalwindowbartlettView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_window_bartlett_view_make(size : Int) -> SignalwindowbartlettView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_window_bartlett_view_len(s : SignalwindowbartlettView) -> Int { s.size }

pub fn signal_window_bartlett_view_get(s : SignalwindowbartlettView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_window_bartlett_view_set(s : SignalwindowbartlettView, i : Int, v : Double) -> SignalwindowbartlettView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_window_bartlett_view_sum(s : SignalwindowbartlettView) -> Double { @_common.sum(s.data) }

pub fn signal_window_bartlett_view_mean(s : SignalwindowbartlettView) -> Double { @_common.mean(s.data) }

pub fn signal_window_bartlett_view_scale(s : SignalwindowbartlettView, f : Double) -> SignalwindowbartlettView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_window_bartlett_view_add(a : SignalwindowbartlettView, b : SignalwindowbartlettView) -> SignalwindowbartlettView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_window_bartlett_view_copy(s : SignalwindowbartlettView) -> SignalwindowbartlettView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_window_bartlett_view_fill(s : SignalwindowbartlettView, v : Double) -> SignalwindowbartlettView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_window_bartlett_view_min(s : SignalwindowbartlettView) -> Double { @_common.min(s.data) }

pub fn signal_window_bartlett_view_max(s : SignalwindowbartlettView) -> Double { @_common.max(s.data) }

pub fn signal_window_bartlett_view_to_string(s : SignalwindowbartlettView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalwindowbartlettRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_window_bartlett_range_make(size : Int) -> SignalwindowbartlettRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_window_bartlett_range_len(s : SignalwindowbartlettRange) -> Int { s.size }

pub fn signal_window_bartlett_range_get(s : SignalwindowbartlettRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_window_bartlett_range_set(s : SignalwindowbartlettRange, i : Int, v : Double) -> SignalwindowbartlettRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_window_bartlett_range_sum(s : SignalwindowbartlettRange) -> Double { @_common.sum(s.data) }

pub fn signal_window_bartlett_range_mean(s : SignalwindowbartlettRange) -> Double { @_common.mean(s.data) }

pub fn signal_window_bartlett_range_scale(s : SignalwindowbartlettRange, f : Double) -> SignalwindowbartlettRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_window_bartlett_range_add(a : SignalwindowbartlettRange, b : SignalwindowbartlettRange) -> SignalwindowbartlettRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_window_bartlett_range_copy(s : SignalwindowbartlettRange) -> SignalwindowbartlettRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_window_bartlett_range_fill(s : SignalwindowbartlettRange, v : Double) -> SignalwindowbartlettRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_window_bartlett_range_min(s : SignalwindowbartlettRange) -> Double { @_common.min(s.data) }

pub fn signal_window_bartlett_range_max(s : SignalwindowbartlettRange) -> Double { @_common.max(s.data) }

pub fn signal_window_bartlett_range_to_string(s : SignalwindowbartlettRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalwindowbartlettSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_window_bartlett_slice_make(size : Int) -> SignalwindowbartlettSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_window_bartlett_slice_len(s : SignalwindowbartlettSlice) -> Int { s.size }

pub fn signal_window_bartlett_slice_get(s : SignalwindowbartlettSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_window_bartlett_slice_set(s : SignalwindowbartlettSlice, i : Int, v : Double) -> SignalwindowbartlettSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_window_bartlett_slice_sum(s : SignalwindowbartlettSlice) -> Double { @_common.sum(s.data) }

pub fn signal_window_bartlett_slice_mean(s : SignalwindowbartlettSlice) -> Double { @_common.mean(s.data) }

pub fn signal_window_bartlett_slice_scale(s : SignalwindowbartlettSlice, f : Double) -> SignalwindowbartlettSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_window_bartlett_slice_add(a : SignalwindowbartlettSlice, b : SignalwindowbartlettSlice) -> SignalwindowbartlettSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_window_bartlett_slice_copy(s : SignalwindowbartlettSlice) -> SignalwindowbartlettSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_window_bartlett_slice_fill(s : SignalwindowbartlettSlice, v : Double) -> SignalwindowbartlettSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_window_bartlett_slice_min(s : SignalwindowbartlettSlice) -> Double { @_common.min(s.data) }

pub fn signal_window_bartlett_slice_max(s : SignalwindowbartlettSlice) -> Double { @_common.max(s.data) }

pub fn signal_window_bartlett_slice_to_string(s : SignalwindowbartlettSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

