///===
/// extcore/signal_filter_butterworth

pub(all) struct SignalfilterbutterworthPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn signal_filter_butterworth_make_point(x : Double, y : Double) -> SignalfilterbutterworthPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn signal_filter_butterworth_make_point3(x : Double, y : Double, z : Double) -> SignalfilterbutterworthPoint {
  { x, y, z, label: 0 }
}

pub fn SignalfilterbutterworthPoint::x(self : SignalfilterbutterworthPoint) -> Double { self.x }

pub fn SignalfilterbutterworthPoint::y(self : SignalfilterbutterworthPoint) -> Double { self.y }

pub fn SignalfilterbutterworthPoint::z(self : SignalfilterbutterworthPoint) -> Double { self.z }

pub fn SignalfilterbutterworthPoint::label(self : SignalfilterbutterworthPoint) -> Int { self.label }

pub fn SignalfilterbutterworthPoint::dist(self : SignalfilterbutterworthPoint, other : SignalfilterbutterworthPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn SignalfilterbutterworthPoint::add(self : SignalfilterbutterworthPoint, other : SignalfilterbutterworthPoint) -> SignalfilterbutterworthPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn SignalfilterbutterworthPoint::sub(self : SignalfilterbutterworthPoint, other : SignalfilterbutterworthPoint) -> SignalfilterbutterworthPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn SignalfilterbutterworthPoint::scale(self : SignalfilterbutterworthPoint, s : Double) -> SignalfilterbutterworthPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn SignalfilterbutterworthPoint::dot(self : SignalfilterbutterworthPoint, other : SignalfilterbutterworthPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn SignalfilterbutterworthPoint::cross(self : SignalfilterbutterworthPoint, other : SignalfilterbutterworthPoint) -> SignalfilterbutterworthPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn SignalfilterbutterworthPoint::norm(self : SignalfilterbutterworthPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn SignalfilterbutterworthPoint::normalize(self : SignalfilterbutterworthPoint) -> SignalfilterbutterworthPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn SignalfilterbutterworthPoint::negate(self : SignalfilterbutterworthPoint) -> SignalfilterbutterworthPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn SignalfilterbutterworthPoint::mid(self : SignalfilterbutterworthPoint, other : SignalfilterbutterworthPoint) -> SignalfilterbutterworthPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn SignalfilterbutterworthPoint::lerp(self : SignalfilterbutterworthPoint, other : SignalfilterbutterworthPoint, t : Double) -> SignalfilterbutterworthPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn SignalfilterbutterworthPoint::to_string(self : SignalfilterbutterworthPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct SignalfilterbutterworthSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn signal_filter_butterworth_make_series(vals : Array[Double], name : String) -> SignalfilterbutterworthSeries {
  { vals, name, meta: 0 }
}

pub fn SignalfilterbutterworthSeries::len(self : SignalfilterbutterworthSeries) -> Int { self.vals.length() }

pub fn SignalfilterbutterworthSeries::sum(self : SignalfilterbutterworthSeries) -> Double { @_common.sum(self.vals) }

pub fn SignalfilterbutterworthSeries::mean(self : SignalfilterbutterworthSeries) -> Double { @_common.mean(self.vals) }

pub fn SignalfilterbutterworthSeries::min(self : SignalfilterbutterworthSeries) -> Double { @_common.min(self.vals) }

pub fn SignalfilterbutterworthSeries::max(self : SignalfilterbutterworthSeries) -> Double { @_common.max(self.vals) }

pub fn SignalfilterbutterworthSeries::range(self : SignalfilterbutterworthSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn SignalfilterbutterworthSeries::variance(self : SignalfilterbutterworthSeries) -> Double { @_common.variance(self.vals) }

pub fn SignalfilterbutterworthSeries::std(self : SignalfilterbutterworthSeries) -> Double { @_common.std(self.vals) }

pub fn SignalfilterbutterworthSeries::median(self : SignalfilterbutterworthSeries) -> Double { @_common.median(self.vals) }

pub fn SignalfilterbutterworthSeries::scale(self : SignalfilterbutterworthSeries, f : Double) -> SignalfilterbutterworthSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn SignalfilterbutterworthSeries::add(self : SignalfilterbutterworthSeries, other : SignalfilterbutterworthSeries) -> SignalfilterbutterworthSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn SignalfilterbutterworthSeries::sub(self : SignalfilterbutterworthSeries, other : SignalfilterbutterworthSeries) -> SignalfilterbutterworthSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn SignalfilterbutterworthSeries::normalize(self : SignalfilterbutterworthSeries) -> SignalfilterbutterworthSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn SignalfilterbutterworthSeries::cumsum(self : SignalfilterbutterworthSeries) -> SignalfilterbutterworthSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn SignalfilterbutterworthSeries::to_string(self : SignalfilterbutterworthSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct SignalfilterbutterworthMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn signal_filter_butterworth_make_matrix(rows : Int, cols : Int, val : Double) -> SignalfilterbutterworthMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn signal_filter_butterworth_matrix_identity(n : Int) -> SignalfilterbutterworthMatrix {
  let m = signal_filter_butterworth_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn SignalfilterbutterworthMatrix::get(self : SignalfilterbutterworthMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn SignalfilterbutterworthMatrix::transpose(self : SignalfilterbutterworthMatrix) -> SignalfilterbutterworthMatrix {
  let result = signal_filter_butterworth_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn SignalfilterbutterworthMatrix::add(self : SignalfilterbutterworthMatrix, other : SignalfilterbutterworthMatrix) -> SignalfilterbutterworthMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = signal_filter_butterworth_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn SignalfilterbutterworthMatrix::scale(self : SignalfilterbutterworthMatrix, s : Double) -> SignalfilterbutterworthMatrix {
  let result = signal_filter_butterworth_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn SignalfilterbutterworthMatrix::multiply(self : SignalfilterbutterworthMatrix, other : SignalfilterbutterworthMatrix) -> SignalfilterbutterworthMatrix {
  if self.cols != other.rows { return signal_filter_butterworth_make_matrix(self.rows, other.cols, 0.0) }
  let result = signal_filter_butterworth_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn SignalfilterbutterworthMatrix::trace(self : SignalfilterbutterworthMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn SignalfilterbutterworthMatrix::det(self : SignalfilterbutterworthMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn SignalfilterbutterworthMatrix::norm(self : SignalfilterbutterworthMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn SignalfilterbutterworthMatrix::to_string(self : SignalfilterbutterworthMatrix) -> String {
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

pub(all) struct SignalfilterbutterworthVector {
  comps : Array[Double]
  dim : Int
}

pub fn signal_filter_butterworth_make_vector(comps : Array[Double]) -> SignalfilterbutterworthVector {
  { comps, dim: comps.length() }
}

pub fn signal_filter_butterworth_vector_zero(dim : Int) -> SignalfilterbutterworthVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn SignalfilterbutterworthVector::add(self : SignalfilterbutterworthVector, other : SignalfilterbutterworthVector) -> SignalfilterbutterworthVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn SignalfilterbutterworthVector::sub(self : SignalfilterbutterworthVector, other : SignalfilterbutterworthVector) -> SignalfilterbutterworthVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn SignalfilterbutterworthVector::scale(self : SignalfilterbutterworthVector, s : Double) -> SignalfilterbutterworthVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn SignalfilterbutterworthVector::dot(self : SignalfilterbutterworthVector, other : SignalfilterbutterworthVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn SignalfilterbutterworthVector::norm(self : SignalfilterbutterworthVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn SignalfilterbutterworthVector::normalize(self : SignalfilterbutterworthVector) -> SignalfilterbutterworthVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn SignalfilterbutterworthVector::dist(self : SignalfilterbutterworthVector, other : SignalfilterbutterworthVector) -> Double {
  self.sub(other).norm()
}

pub fn SignalfilterbutterworthVector::to_string(self : SignalfilterbutterworthVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn signal_filter_butterworth_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn signal_filter_butterworth_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn signal_filter_butterworth_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn signal_filter_butterworth_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn signal_filter_butterworth_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn signal_filter_butterworth_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn signal_filter_butterworth_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn signal_filter_butterworth_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn signal_filter_butterworth_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn signal_filter_butterworth_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn signal_filter_butterworth_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn signal_filter_butterworth_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn signal_filter_butterworth_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn signal_filter_butterworth_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn signal_filter_butterworth_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn signal_filter_butterworth_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn signal_filter_butterworth_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn signal_filter_butterworth_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn signal_filter_butterworth_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn signal_filter_butterworth_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn signal_filter_butterworth_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn signal_filter_butterworth_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn signal_filter_butterworth_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn signal_filter_butterworth_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn signal_filter_butterworth_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn signal_filter_butterworth_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn signal_filter_butterworth_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn signal_filter_butterworth_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn signal_filter_butterworth_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct SignalfilterbutterworthFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_filter_butterworth_frame_make(size : Int) -> SignalfilterbutterworthFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_filter_butterworth_frame_len(s : SignalfilterbutterworthFrame) -> Int { s.size }

pub fn signal_filter_butterworth_frame_get(s : SignalfilterbutterworthFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_filter_butterworth_frame_set(s : SignalfilterbutterworthFrame, i : Int, v : Double) -> SignalfilterbutterworthFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_filter_butterworth_frame_sum(s : SignalfilterbutterworthFrame) -> Double { @_common.sum(s.data) }

pub fn signal_filter_butterworth_frame_mean(s : SignalfilterbutterworthFrame) -> Double { @_common.mean(s.data) }

pub fn signal_filter_butterworth_frame_scale(s : SignalfilterbutterworthFrame, f : Double) -> SignalfilterbutterworthFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_filter_butterworth_frame_add(a : SignalfilterbutterworthFrame, b : SignalfilterbutterworthFrame) -> SignalfilterbutterworthFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_filter_butterworth_frame_copy(s : SignalfilterbutterworthFrame) -> SignalfilterbutterworthFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_filter_butterworth_frame_fill(s : SignalfilterbutterworthFrame, v : Double) -> SignalfilterbutterworthFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_filter_butterworth_frame_min(s : SignalfilterbutterworthFrame) -> Double { @_common.min(s.data) }

pub fn signal_filter_butterworth_frame_max(s : SignalfilterbutterworthFrame) -> Double { @_common.max(s.data) }

pub fn signal_filter_butterworth_frame_to_string(s : SignalfilterbutterworthFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalfilterbutterworthTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_filter_butterworth_table_make(size : Int) -> SignalfilterbutterworthTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_filter_butterworth_table_len(s : SignalfilterbutterworthTable) -> Int { s.size }

pub fn signal_filter_butterworth_table_get(s : SignalfilterbutterworthTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_filter_butterworth_table_set(s : SignalfilterbutterworthTable, i : Int, v : Double) -> SignalfilterbutterworthTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_filter_butterworth_table_sum(s : SignalfilterbutterworthTable) -> Double { @_common.sum(s.data) }

pub fn signal_filter_butterworth_table_mean(s : SignalfilterbutterworthTable) -> Double { @_common.mean(s.data) }

pub fn signal_filter_butterworth_table_scale(s : SignalfilterbutterworthTable, f : Double) -> SignalfilterbutterworthTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_filter_butterworth_table_add(a : SignalfilterbutterworthTable, b : SignalfilterbutterworthTable) -> SignalfilterbutterworthTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_filter_butterworth_table_copy(s : SignalfilterbutterworthTable) -> SignalfilterbutterworthTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_filter_butterworth_table_fill(s : SignalfilterbutterworthTable, v : Double) -> SignalfilterbutterworthTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_filter_butterworth_table_min(s : SignalfilterbutterworthTable) -> Double { @_common.min(s.data) }

pub fn signal_filter_butterworth_table_max(s : SignalfilterbutterworthTable) -> Double { @_common.max(s.data) }

pub fn signal_filter_butterworth_table_to_string(s : SignalfilterbutterworthTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalfilterbutterworthGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_filter_butterworth_graphn_make(size : Int) -> SignalfilterbutterworthGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_filter_butterworth_graphn_len(s : SignalfilterbutterworthGraphN) -> Int { s.size }

pub fn signal_filter_butterworth_graphn_get(s : SignalfilterbutterworthGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_filter_butterworth_graphn_set(s : SignalfilterbutterworthGraphN, i : Int, v : Double) -> SignalfilterbutterworthGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_filter_butterworth_graphn_sum(s : SignalfilterbutterworthGraphN) -> Double { @_common.sum(s.data) }

pub fn signal_filter_butterworth_graphn_mean(s : SignalfilterbutterworthGraphN) -> Double { @_common.mean(s.data) }

pub fn signal_filter_butterworth_graphn_scale(s : SignalfilterbutterworthGraphN, f : Double) -> SignalfilterbutterworthGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_filter_butterworth_graphn_add(a : SignalfilterbutterworthGraphN, b : SignalfilterbutterworthGraphN) -> SignalfilterbutterworthGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_filter_butterworth_graphn_copy(s : SignalfilterbutterworthGraphN) -> SignalfilterbutterworthGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_filter_butterworth_graphn_fill(s : SignalfilterbutterworthGraphN, v : Double) -> SignalfilterbutterworthGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_filter_butterworth_graphn_min(s : SignalfilterbutterworthGraphN) -> Double { @_common.min(s.data) }

pub fn signal_filter_butterworth_graphn_max(s : SignalfilterbutterworthGraphN) -> Double { @_common.max(s.data) }

pub fn signal_filter_butterworth_graphn_to_string(s : SignalfilterbutterworthGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalfilterbutterworthNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_filter_butterworth_node_make(size : Int) -> SignalfilterbutterworthNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_filter_butterworth_node_len(s : SignalfilterbutterworthNode) -> Int { s.size }

pub fn signal_filter_butterworth_node_get(s : SignalfilterbutterworthNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_filter_butterworth_node_set(s : SignalfilterbutterworthNode, i : Int, v : Double) -> SignalfilterbutterworthNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_filter_butterworth_node_sum(s : SignalfilterbutterworthNode) -> Double { @_common.sum(s.data) }

pub fn signal_filter_butterworth_node_mean(s : SignalfilterbutterworthNode) -> Double { @_common.mean(s.data) }

pub fn signal_filter_butterworth_node_scale(s : SignalfilterbutterworthNode, f : Double) -> SignalfilterbutterworthNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_filter_butterworth_node_add(a : SignalfilterbutterworthNode, b : SignalfilterbutterworthNode) -> SignalfilterbutterworthNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_filter_butterworth_node_copy(s : SignalfilterbutterworthNode) -> SignalfilterbutterworthNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_filter_butterworth_node_fill(s : SignalfilterbutterworthNode, v : Double) -> SignalfilterbutterworthNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_filter_butterworth_node_min(s : SignalfilterbutterworthNode) -> Double { @_common.min(s.data) }

pub fn signal_filter_butterworth_node_max(s : SignalfilterbutterworthNode) -> Double { @_common.max(s.data) }

pub fn signal_filter_butterworth_node_to_string(s : SignalfilterbutterworthNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalfilterbutterworthEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_filter_butterworth_edge_make(size : Int) -> SignalfilterbutterworthEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_filter_butterworth_edge_len(s : SignalfilterbutterworthEdge) -> Int { s.size }

pub fn signal_filter_butterworth_edge_get(s : SignalfilterbutterworthEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_filter_butterworth_edge_set(s : SignalfilterbutterworthEdge, i : Int, v : Double) -> SignalfilterbutterworthEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_filter_butterworth_edge_sum(s : SignalfilterbutterworthEdge) -> Double { @_common.sum(s.data) }

pub fn signal_filter_butterworth_edge_mean(s : SignalfilterbutterworthEdge) -> Double { @_common.mean(s.data) }

pub fn signal_filter_butterworth_edge_scale(s : SignalfilterbutterworthEdge, f : Double) -> SignalfilterbutterworthEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_filter_butterworth_edge_add(a : SignalfilterbutterworthEdge, b : SignalfilterbutterworthEdge) -> SignalfilterbutterworthEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_filter_butterworth_edge_copy(s : SignalfilterbutterworthEdge) -> SignalfilterbutterworthEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_filter_butterworth_edge_fill(s : SignalfilterbutterworthEdge, v : Double) -> SignalfilterbutterworthEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_filter_butterworth_edge_min(s : SignalfilterbutterworthEdge) -> Double { @_common.min(s.data) }

pub fn signal_filter_butterworth_edge_max(s : SignalfilterbutterworthEdge) -> Double { @_common.max(s.data) }

pub fn signal_filter_butterworth_edge_to_string(s : SignalfilterbutterworthEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalfilterbutterworthPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_filter_butterworth_path_make(size : Int) -> SignalfilterbutterworthPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_filter_butterworth_path_len(s : SignalfilterbutterworthPath) -> Int { s.size }

pub fn signal_filter_butterworth_path_get(s : SignalfilterbutterworthPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_filter_butterworth_path_set(s : SignalfilterbutterworthPath, i : Int, v : Double) -> SignalfilterbutterworthPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_filter_butterworth_path_sum(s : SignalfilterbutterworthPath) -> Double { @_common.sum(s.data) }

pub fn signal_filter_butterworth_path_mean(s : SignalfilterbutterworthPath) -> Double { @_common.mean(s.data) }

pub fn signal_filter_butterworth_path_scale(s : SignalfilterbutterworthPath, f : Double) -> SignalfilterbutterworthPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_filter_butterworth_path_add(a : SignalfilterbutterworthPath, b : SignalfilterbutterworthPath) -> SignalfilterbutterworthPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_filter_butterworth_path_copy(s : SignalfilterbutterworthPath) -> SignalfilterbutterworthPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_filter_butterworth_path_fill(s : SignalfilterbutterworthPath, v : Double) -> SignalfilterbutterworthPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_filter_butterworth_path_min(s : SignalfilterbutterworthPath) -> Double { @_common.min(s.data) }

pub fn signal_filter_butterworth_path_max(s : SignalfilterbutterworthPath) -> Double { @_common.max(s.data) }

pub fn signal_filter_butterworth_path_to_string(s : SignalfilterbutterworthPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalfilterbutterworthCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_filter_butterworth_cluster_make(size : Int) -> SignalfilterbutterworthCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_filter_butterworth_cluster_len(s : SignalfilterbutterworthCluster) -> Int { s.size }

pub fn signal_filter_butterworth_cluster_get(s : SignalfilterbutterworthCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_filter_butterworth_cluster_set(s : SignalfilterbutterworthCluster, i : Int, v : Double) -> SignalfilterbutterworthCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_filter_butterworth_cluster_sum(s : SignalfilterbutterworthCluster) -> Double { @_common.sum(s.data) }

pub fn signal_filter_butterworth_cluster_mean(s : SignalfilterbutterworthCluster) -> Double { @_common.mean(s.data) }

pub fn signal_filter_butterworth_cluster_scale(s : SignalfilterbutterworthCluster, f : Double) -> SignalfilterbutterworthCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_filter_butterworth_cluster_add(a : SignalfilterbutterworthCluster, b : SignalfilterbutterworthCluster) -> SignalfilterbutterworthCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_filter_butterworth_cluster_copy(s : SignalfilterbutterworthCluster) -> SignalfilterbutterworthCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_filter_butterworth_cluster_fill(s : SignalfilterbutterworthCluster, v : Double) -> SignalfilterbutterworthCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_filter_butterworth_cluster_min(s : SignalfilterbutterworthCluster) -> Double { @_common.min(s.data) }

pub fn signal_filter_butterworth_cluster_max(s : SignalfilterbutterworthCluster) -> Double { @_common.max(s.data) }

pub fn signal_filter_butterworth_cluster_to_string(s : SignalfilterbutterworthCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalfilterbutterworthModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_filter_butterworth_model_make(size : Int) -> SignalfilterbutterworthModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_filter_butterworth_model_len(s : SignalfilterbutterworthModel) -> Int { s.size }

pub fn signal_filter_butterworth_model_get(s : SignalfilterbutterworthModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_filter_butterworth_model_set(s : SignalfilterbutterworthModel, i : Int, v : Double) -> SignalfilterbutterworthModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_filter_butterworth_model_sum(s : SignalfilterbutterworthModel) -> Double { @_common.sum(s.data) }

pub fn signal_filter_butterworth_model_mean(s : SignalfilterbutterworthModel) -> Double { @_common.mean(s.data) }

pub fn signal_filter_butterworth_model_scale(s : SignalfilterbutterworthModel, f : Double) -> SignalfilterbutterworthModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_filter_butterworth_model_add(a : SignalfilterbutterworthModel, b : SignalfilterbutterworthModel) -> SignalfilterbutterworthModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_filter_butterworth_model_copy(s : SignalfilterbutterworthModel) -> SignalfilterbutterworthModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_filter_butterworth_model_fill(s : SignalfilterbutterworthModel, v : Double) -> SignalfilterbutterworthModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_filter_butterworth_model_min(s : SignalfilterbutterworthModel) -> Double { @_common.min(s.data) }

pub fn signal_filter_butterworth_model_max(s : SignalfilterbutterworthModel) -> Double { @_common.max(s.data) }

pub fn signal_filter_butterworth_model_to_string(s : SignalfilterbutterworthModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalfilterbutterworthLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_filter_butterworth_layer_make(size : Int) -> SignalfilterbutterworthLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_filter_butterworth_layer_len(s : SignalfilterbutterworthLayer) -> Int { s.size }

pub fn signal_filter_butterworth_layer_get(s : SignalfilterbutterworthLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_filter_butterworth_layer_set(s : SignalfilterbutterworthLayer, i : Int, v : Double) -> SignalfilterbutterworthLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_filter_butterworth_layer_sum(s : SignalfilterbutterworthLayer) -> Double { @_common.sum(s.data) }

pub fn signal_filter_butterworth_layer_mean(s : SignalfilterbutterworthLayer) -> Double { @_common.mean(s.data) }

pub fn signal_filter_butterworth_layer_scale(s : SignalfilterbutterworthLayer, f : Double) -> SignalfilterbutterworthLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_filter_butterworth_layer_add(a : SignalfilterbutterworthLayer, b : SignalfilterbutterworthLayer) -> SignalfilterbutterworthLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_filter_butterworth_layer_copy(s : SignalfilterbutterworthLayer) -> SignalfilterbutterworthLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_filter_butterworth_layer_fill(s : SignalfilterbutterworthLayer, v : Double) -> SignalfilterbutterworthLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_filter_butterworth_layer_min(s : SignalfilterbutterworthLayer) -> Double { @_common.min(s.data) }

pub fn signal_filter_butterworth_layer_max(s : SignalfilterbutterworthLayer) -> Double { @_common.max(s.data) }

pub fn signal_filter_butterworth_layer_to_string(s : SignalfilterbutterworthLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalfilterbutterworthBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_filter_butterworth_buffer_make(size : Int) -> SignalfilterbutterworthBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_filter_butterworth_buffer_len(s : SignalfilterbutterworthBuffer) -> Int { s.size }

pub fn signal_filter_butterworth_buffer_get(s : SignalfilterbutterworthBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_filter_butterworth_buffer_set(s : SignalfilterbutterworthBuffer, i : Int, v : Double) -> SignalfilterbutterworthBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_filter_butterworth_buffer_sum(s : SignalfilterbutterworthBuffer) -> Double { @_common.sum(s.data) }

pub fn signal_filter_butterworth_buffer_mean(s : SignalfilterbutterworthBuffer) -> Double { @_common.mean(s.data) }

pub fn signal_filter_butterworth_buffer_scale(s : SignalfilterbutterworthBuffer, f : Double) -> SignalfilterbutterworthBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_filter_butterworth_buffer_add(a : SignalfilterbutterworthBuffer, b : SignalfilterbutterworthBuffer) -> SignalfilterbutterworthBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_filter_butterworth_buffer_copy(s : SignalfilterbutterworthBuffer) -> SignalfilterbutterworthBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_filter_butterworth_buffer_fill(s : SignalfilterbutterworthBuffer, v : Double) -> SignalfilterbutterworthBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_filter_butterworth_buffer_min(s : SignalfilterbutterworthBuffer) -> Double { @_common.min(s.data) }

pub fn signal_filter_butterworth_buffer_max(s : SignalfilterbutterworthBuffer) -> Double { @_common.max(s.data) }

pub fn signal_filter_butterworth_buffer_to_string(s : SignalfilterbutterworthBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalfilterbutterworthCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_filter_butterworth_cursor_make(size : Int) -> SignalfilterbutterworthCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_filter_butterworth_cursor_len(s : SignalfilterbutterworthCursor) -> Int { s.size }

pub fn signal_filter_butterworth_cursor_get(s : SignalfilterbutterworthCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_filter_butterworth_cursor_set(s : SignalfilterbutterworthCursor, i : Int, v : Double) -> SignalfilterbutterworthCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_filter_butterworth_cursor_sum(s : SignalfilterbutterworthCursor) -> Double { @_common.sum(s.data) }

pub fn signal_filter_butterworth_cursor_mean(s : SignalfilterbutterworthCursor) -> Double { @_common.mean(s.data) }

pub fn signal_filter_butterworth_cursor_scale(s : SignalfilterbutterworthCursor, f : Double) -> SignalfilterbutterworthCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_filter_butterworth_cursor_add(a : SignalfilterbutterworthCursor, b : SignalfilterbutterworthCursor) -> SignalfilterbutterworthCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_filter_butterworth_cursor_copy(s : SignalfilterbutterworthCursor) -> SignalfilterbutterworthCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_filter_butterworth_cursor_fill(s : SignalfilterbutterworthCursor, v : Double) -> SignalfilterbutterworthCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_filter_butterworth_cursor_min(s : SignalfilterbutterworthCursor) -> Double { @_common.min(s.data) }

pub fn signal_filter_butterworth_cursor_max(s : SignalfilterbutterworthCursor) -> Double { @_common.max(s.data) }

pub fn signal_filter_butterworth_cursor_to_string(s : SignalfilterbutterworthCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalfilterbutterworthView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_filter_butterworth_view_make(size : Int) -> SignalfilterbutterworthView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_filter_butterworth_view_len(s : SignalfilterbutterworthView) -> Int { s.size }

pub fn signal_filter_butterworth_view_get(s : SignalfilterbutterworthView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_filter_butterworth_view_set(s : SignalfilterbutterworthView, i : Int, v : Double) -> SignalfilterbutterworthView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_filter_butterworth_view_sum(s : SignalfilterbutterworthView) -> Double { @_common.sum(s.data) }

pub fn signal_filter_butterworth_view_mean(s : SignalfilterbutterworthView) -> Double { @_common.mean(s.data) }

pub fn signal_filter_butterworth_view_scale(s : SignalfilterbutterworthView, f : Double) -> SignalfilterbutterworthView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_filter_butterworth_view_add(a : SignalfilterbutterworthView, b : SignalfilterbutterworthView) -> SignalfilterbutterworthView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_filter_butterworth_view_copy(s : SignalfilterbutterworthView) -> SignalfilterbutterworthView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_filter_butterworth_view_fill(s : SignalfilterbutterworthView, v : Double) -> SignalfilterbutterworthView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_filter_butterworth_view_min(s : SignalfilterbutterworthView) -> Double { @_common.min(s.data) }

pub fn signal_filter_butterworth_view_max(s : SignalfilterbutterworthView) -> Double { @_common.max(s.data) }

pub fn signal_filter_butterworth_view_to_string(s : SignalfilterbutterworthView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalfilterbutterworthRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_filter_butterworth_range_make(size : Int) -> SignalfilterbutterworthRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_filter_butterworth_range_len(s : SignalfilterbutterworthRange) -> Int { s.size }

pub fn signal_filter_butterworth_range_get(s : SignalfilterbutterworthRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_filter_butterworth_range_set(s : SignalfilterbutterworthRange, i : Int, v : Double) -> SignalfilterbutterworthRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_filter_butterworth_range_sum(s : SignalfilterbutterworthRange) -> Double { @_common.sum(s.data) }

pub fn signal_filter_butterworth_range_mean(s : SignalfilterbutterworthRange) -> Double { @_common.mean(s.data) }

pub fn signal_filter_butterworth_range_scale(s : SignalfilterbutterworthRange, f : Double) -> SignalfilterbutterworthRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_filter_butterworth_range_add(a : SignalfilterbutterworthRange, b : SignalfilterbutterworthRange) -> SignalfilterbutterworthRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_filter_butterworth_range_copy(s : SignalfilterbutterworthRange) -> SignalfilterbutterworthRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_filter_butterworth_range_fill(s : SignalfilterbutterworthRange, v : Double) -> SignalfilterbutterworthRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_filter_butterworth_range_min(s : SignalfilterbutterworthRange) -> Double { @_common.min(s.data) }

pub fn signal_filter_butterworth_range_max(s : SignalfilterbutterworthRange) -> Double { @_common.max(s.data) }

pub fn signal_filter_butterworth_range_to_string(s : SignalfilterbutterworthRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalfilterbutterworthSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_filter_butterworth_slice_make(size : Int) -> SignalfilterbutterworthSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_filter_butterworth_slice_len(s : SignalfilterbutterworthSlice) -> Int { s.size }

pub fn signal_filter_butterworth_slice_get(s : SignalfilterbutterworthSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_filter_butterworth_slice_set(s : SignalfilterbutterworthSlice, i : Int, v : Double) -> SignalfilterbutterworthSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_filter_butterworth_slice_sum(s : SignalfilterbutterworthSlice) -> Double { @_common.sum(s.data) }

pub fn signal_filter_butterworth_slice_mean(s : SignalfilterbutterworthSlice) -> Double { @_common.mean(s.data) }

pub fn signal_filter_butterworth_slice_scale(s : SignalfilterbutterworthSlice, f : Double) -> SignalfilterbutterworthSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_filter_butterworth_slice_add(a : SignalfilterbutterworthSlice, b : SignalfilterbutterworthSlice) -> SignalfilterbutterworthSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_filter_butterworth_slice_copy(s : SignalfilterbutterworthSlice) -> SignalfilterbutterworthSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_filter_butterworth_slice_fill(s : SignalfilterbutterworthSlice, v : Double) -> SignalfilterbutterworthSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_filter_butterworth_slice_min(s : SignalfilterbutterworthSlice) -> Double { @_common.min(s.data) }

pub fn signal_filter_butterworth_slice_max(s : SignalfilterbutterworthSlice) -> Double { @_common.max(s.data) }

pub fn signal_filter_butterworth_slice_to_string(s : SignalfilterbutterworthSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

