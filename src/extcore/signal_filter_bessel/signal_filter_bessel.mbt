///===
/// extcore/signal_filter_bessel

pub(all) struct SignalfilterbesselPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn signal_filter_bessel_make_point(x : Double, y : Double) -> SignalfilterbesselPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn signal_filter_bessel_make_point3(x : Double, y : Double, z : Double) -> SignalfilterbesselPoint {
  { x, y, z, label: 0 }
}

pub fn SignalfilterbesselPoint::x(self : SignalfilterbesselPoint) -> Double { self.x }

pub fn SignalfilterbesselPoint::y(self : SignalfilterbesselPoint) -> Double { self.y }

pub fn SignalfilterbesselPoint::z(self : SignalfilterbesselPoint) -> Double { self.z }

pub fn SignalfilterbesselPoint::label(self : SignalfilterbesselPoint) -> Int { self.label }

pub fn SignalfilterbesselPoint::dist(self : SignalfilterbesselPoint, other : SignalfilterbesselPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn SignalfilterbesselPoint::add(self : SignalfilterbesselPoint, other : SignalfilterbesselPoint) -> SignalfilterbesselPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn SignalfilterbesselPoint::sub(self : SignalfilterbesselPoint, other : SignalfilterbesselPoint) -> SignalfilterbesselPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn SignalfilterbesselPoint::scale(self : SignalfilterbesselPoint, s : Double) -> SignalfilterbesselPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn SignalfilterbesselPoint::dot(self : SignalfilterbesselPoint, other : SignalfilterbesselPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn SignalfilterbesselPoint::cross(self : SignalfilterbesselPoint, other : SignalfilterbesselPoint) -> SignalfilterbesselPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn SignalfilterbesselPoint::norm(self : SignalfilterbesselPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn SignalfilterbesselPoint::normalize(self : SignalfilterbesselPoint) -> SignalfilterbesselPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn SignalfilterbesselPoint::negate(self : SignalfilterbesselPoint) -> SignalfilterbesselPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn SignalfilterbesselPoint::mid(self : SignalfilterbesselPoint, other : SignalfilterbesselPoint) -> SignalfilterbesselPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn SignalfilterbesselPoint::lerp(self : SignalfilterbesselPoint, other : SignalfilterbesselPoint, t : Double) -> SignalfilterbesselPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn SignalfilterbesselPoint::to_string(self : SignalfilterbesselPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct SignalfilterbesselSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn signal_filter_bessel_make_series(vals : Array[Double], name : String) -> SignalfilterbesselSeries {
  { vals, name, meta: 0 }
}

pub fn SignalfilterbesselSeries::len(self : SignalfilterbesselSeries) -> Int { self.vals.length() }

pub fn SignalfilterbesselSeries::sum(self : SignalfilterbesselSeries) -> Double { @_common.sum(self.vals) }

pub fn SignalfilterbesselSeries::mean(self : SignalfilterbesselSeries) -> Double { @_common.mean(self.vals) }

pub fn SignalfilterbesselSeries::min(self : SignalfilterbesselSeries) -> Double { @_common.min(self.vals) }

pub fn SignalfilterbesselSeries::max(self : SignalfilterbesselSeries) -> Double { @_common.max(self.vals) }

pub fn SignalfilterbesselSeries::range(self : SignalfilterbesselSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn SignalfilterbesselSeries::variance(self : SignalfilterbesselSeries) -> Double { @_common.variance(self.vals) }

pub fn SignalfilterbesselSeries::std(self : SignalfilterbesselSeries) -> Double { @_common.std(self.vals) }

pub fn SignalfilterbesselSeries::median(self : SignalfilterbesselSeries) -> Double { @_common.median(self.vals) }

pub fn SignalfilterbesselSeries::scale(self : SignalfilterbesselSeries, f : Double) -> SignalfilterbesselSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn SignalfilterbesselSeries::add(self : SignalfilterbesselSeries, other : SignalfilterbesselSeries) -> SignalfilterbesselSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn SignalfilterbesselSeries::sub(self : SignalfilterbesselSeries, other : SignalfilterbesselSeries) -> SignalfilterbesselSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn SignalfilterbesselSeries::normalize(self : SignalfilterbesselSeries) -> SignalfilterbesselSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn SignalfilterbesselSeries::cumsum(self : SignalfilterbesselSeries) -> SignalfilterbesselSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn SignalfilterbesselSeries::to_string(self : SignalfilterbesselSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct SignalfilterbesselMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn signal_filter_bessel_make_matrix(rows : Int, cols : Int, val : Double) -> SignalfilterbesselMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn signal_filter_bessel_matrix_identity(n : Int) -> SignalfilterbesselMatrix {
  let m = signal_filter_bessel_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn SignalfilterbesselMatrix::get(self : SignalfilterbesselMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn SignalfilterbesselMatrix::transpose(self : SignalfilterbesselMatrix) -> SignalfilterbesselMatrix {
  let result = signal_filter_bessel_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn SignalfilterbesselMatrix::add(self : SignalfilterbesselMatrix, other : SignalfilterbesselMatrix) -> SignalfilterbesselMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = signal_filter_bessel_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn SignalfilterbesselMatrix::scale(self : SignalfilterbesselMatrix, s : Double) -> SignalfilterbesselMatrix {
  let result = signal_filter_bessel_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn SignalfilterbesselMatrix::multiply(self : SignalfilterbesselMatrix, other : SignalfilterbesselMatrix) -> SignalfilterbesselMatrix {
  if self.cols != other.rows { return signal_filter_bessel_make_matrix(self.rows, other.cols, 0.0) }
  let result = signal_filter_bessel_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn SignalfilterbesselMatrix::trace(self : SignalfilterbesselMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn SignalfilterbesselMatrix::det(self : SignalfilterbesselMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn SignalfilterbesselMatrix::norm(self : SignalfilterbesselMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn SignalfilterbesselMatrix::to_string(self : SignalfilterbesselMatrix) -> String {
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

pub(all) struct SignalfilterbesselVector {
  comps : Array[Double]
  dim : Int
}

pub fn signal_filter_bessel_make_vector(comps : Array[Double]) -> SignalfilterbesselVector {
  { comps, dim: comps.length() }
}

pub fn signal_filter_bessel_vector_zero(dim : Int) -> SignalfilterbesselVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn SignalfilterbesselVector::add(self : SignalfilterbesselVector, other : SignalfilterbesselVector) -> SignalfilterbesselVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn SignalfilterbesselVector::sub(self : SignalfilterbesselVector, other : SignalfilterbesselVector) -> SignalfilterbesselVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn SignalfilterbesselVector::scale(self : SignalfilterbesselVector, s : Double) -> SignalfilterbesselVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn SignalfilterbesselVector::dot(self : SignalfilterbesselVector, other : SignalfilterbesselVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn SignalfilterbesselVector::norm(self : SignalfilterbesselVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn SignalfilterbesselVector::normalize(self : SignalfilterbesselVector) -> SignalfilterbesselVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn SignalfilterbesselVector::dist(self : SignalfilterbesselVector, other : SignalfilterbesselVector) -> Double {
  self.sub(other).norm()
}

pub fn SignalfilterbesselVector::to_string(self : SignalfilterbesselVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn signal_filter_bessel_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn signal_filter_bessel_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn signal_filter_bessel_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn signal_filter_bessel_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn signal_filter_bessel_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn signal_filter_bessel_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn signal_filter_bessel_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn signal_filter_bessel_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn signal_filter_bessel_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn signal_filter_bessel_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn signal_filter_bessel_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn signal_filter_bessel_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn signal_filter_bessel_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn signal_filter_bessel_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn signal_filter_bessel_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn signal_filter_bessel_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn signal_filter_bessel_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn signal_filter_bessel_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn signal_filter_bessel_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn signal_filter_bessel_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn signal_filter_bessel_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn signal_filter_bessel_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn signal_filter_bessel_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn signal_filter_bessel_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn signal_filter_bessel_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn signal_filter_bessel_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn signal_filter_bessel_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn signal_filter_bessel_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn signal_filter_bessel_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct SignalfilterbesselFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_filter_bessel_frame_make(size : Int) -> SignalfilterbesselFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_filter_bessel_frame_len(s : SignalfilterbesselFrame) -> Int { s.size }

pub fn signal_filter_bessel_frame_get(s : SignalfilterbesselFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_filter_bessel_frame_set(s : SignalfilterbesselFrame, i : Int, v : Double) -> SignalfilterbesselFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_filter_bessel_frame_sum(s : SignalfilterbesselFrame) -> Double { @_common.sum(s.data) }

pub fn signal_filter_bessel_frame_mean(s : SignalfilterbesselFrame) -> Double { @_common.mean(s.data) }

pub fn signal_filter_bessel_frame_scale(s : SignalfilterbesselFrame, f : Double) -> SignalfilterbesselFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_filter_bessel_frame_add(a : SignalfilterbesselFrame, b : SignalfilterbesselFrame) -> SignalfilterbesselFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_filter_bessel_frame_copy(s : SignalfilterbesselFrame) -> SignalfilterbesselFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_filter_bessel_frame_fill(s : SignalfilterbesselFrame, v : Double) -> SignalfilterbesselFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_filter_bessel_frame_min(s : SignalfilterbesselFrame) -> Double { @_common.min(s.data) }

pub fn signal_filter_bessel_frame_max(s : SignalfilterbesselFrame) -> Double { @_common.max(s.data) }

pub fn signal_filter_bessel_frame_to_string(s : SignalfilterbesselFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalfilterbesselTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_filter_bessel_table_make(size : Int) -> SignalfilterbesselTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_filter_bessel_table_len(s : SignalfilterbesselTable) -> Int { s.size }

pub fn signal_filter_bessel_table_get(s : SignalfilterbesselTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_filter_bessel_table_set(s : SignalfilterbesselTable, i : Int, v : Double) -> SignalfilterbesselTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_filter_bessel_table_sum(s : SignalfilterbesselTable) -> Double { @_common.sum(s.data) }

pub fn signal_filter_bessel_table_mean(s : SignalfilterbesselTable) -> Double { @_common.mean(s.data) }

pub fn signal_filter_bessel_table_scale(s : SignalfilterbesselTable, f : Double) -> SignalfilterbesselTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_filter_bessel_table_add(a : SignalfilterbesselTable, b : SignalfilterbesselTable) -> SignalfilterbesselTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_filter_bessel_table_copy(s : SignalfilterbesselTable) -> SignalfilterbesselTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_filter_bessel_table_fill(s : SignalfilterbesselTable, v : Double) -> SignalfilterbesselTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_filter_bessel_table_min(s : SignalfilterbesselTable) -> Double { @_common.min(s.data) }

pub fn signal_filter_bessel_table_max(s : SignalfilterbesselTable) -> Double { @_common.max(s.data) }

pub fn signal_filter_bessel_table_to_string(s : SignalfilterbesselTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalfilterbesselGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_filter_bessel_graphn_make(size : Int) -> SignalfilterbesselGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_filter_bessel_graphn_len(s : SignalfilterbesselGraphN) -> Int { s.size }

pub fn signal_filter_bessel_graphn_get(s : SignalfilterbesselGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_filter_bessel_graphn_set(s : SignalfilterbesselGraphN, i : Int, v : Double) -> SignalfilterbesselGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_filter_bessel_graphn_sum(s : SignalfilterbesselGraphN) -> Double { @_common.sum(s.data) }

pub fn signal_filter_bessel_graphn_mean(s : SignalfilterbesselGraphN) -> Double { @_common.mean(s.data) }

pub fn signal_filter_bessel_graphn_scale(s : SignalfilterbesselGraphN, f : Double) -> SignalfilterbesselGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_filter_bessel_graphn_add(a : SignalfilterbesselGraphN, b : SignalfilterbesselGraphN) -> SignalfilterbesselGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_filter_bessel_graphn_copy(s : SignalfilterbesselGraphN) -> SignalfilterbesselGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_filter_bessel_graphn_fill(s : SignalfilterbesselGraphN, v : Double) -> SignalfilterbesselGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_filter_bessel_graphn_min(s : SignalfilterbesselGraphN) -> Double { @_common.min(s.data) }

pub fn signal_filter_bessel_graphn_max(s : SignalfilterbesselGraphN) -> Double { @_common.max(s.data) }

pub fn signal_filter_bessel_graphn_to_string(s : SignalfilterbesselGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalfilterbesselNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_filter_bessel_node_make(size : Int) -> SignalfilterbesselNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_filter_bessel_node_len(s : SignalfilterbesselNode) -> Int { s.size }

pub fn signal_filter_bessel_node_get(s : SignalfilterbesselNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_filter_bessel_node_set(s : SignalfilterbesselNode, i : Int, v : Double) -> SignalfilterbesselNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_filter_bessel_node_sum(s : SignalfilterbesselNode) -> Double { @_common.sum(s.data) }

pub fn signal_filter_bessel_node_mean(s : SignalfilterbesselNode) -> Double { @_common.mean(s.data) }

pub fn signal_filter_bessel_node_scale(s : SignalfilterbesselNode, f : Double) -> SignalfilterbesselNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_filter_bessel_node_add(a : SignalfilterbesselNode, b : SignalfilterbesselNode) -> SignalfilterbesselNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_filter_bessel_node_copy(s : SignalfilterbesselNode) -> SignalfilterbesselNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_filter_bessel_node_fill(s : SignalfilterbesselNode, v : Double) -> SignalfilterbesselNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_filter_bessel_node_min(s : SignalfilterbesselNode) -> Double { @_common.min(s.data) }

pub fn signal_filter_bessel_node_max(s : SignalfilterbesselNode) -> Double { @_common.max(s.data) }

pub fn signal_filter_bessel_node_to_string(s : SignalfilterbesselNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalfilterbesselEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_filter_bessel_edge_make(size : Int) -> SignalfilterbesselEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_filter_bessel_edge_len(s : SignalfilterbesselEdge) -> Int { s.size }

pub fn signal_filter_bessel_edge_get(s : SignalfilterbesselEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_filter_bessel_edge_set(s : SignalfilterbesselEdge, i : Int, v : Double) -> SignalfilterbesselEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_filter_bessel_edge_sum(s : SignalfilterbesselEdge) -> Double { @_common.sum(s.data) }

pub fn signal_filter_bessel_edge_mean(s : SignalfilterbesselEdge) -> Double { @_common.mean(s.data) }

pub fn signal_filter_bessel_edge_scale(s : SignalfilterbesselEdge, f : Double) -> SignalfilterbesselEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_filter_bessel_edge_add(a : SignalfilterbesselEdge, b : SignalfilterbesselEdge) -> SignalfilterbesselEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_filter_bessel_edge_copy(s : SignalfilterbesselEdge) -> SignalfilterbesselEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_filter_bessel_edge_fill(s : SignalfilterbesselEdge, v : Double) -> SignalfilterbesselEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_filter_bessel_edge_min(s : SignalfilterbesselEdge) -> Double { @_common.min(s.data) }

pub fn signal_filter_bessel_edge_max(s : SignalfilterbesselEdge) -> Double { @_common.max(s.data) }

pub fn signal_filter_bessel_edge_to_string(s : SignalfilterbesselEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalfilterbesselPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_filter_bessel_path_make(size : Int) -> SignalfilterbesselPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_filter_bessel_path_len(s : SignalfilterbesselPath) -> Int { s.size }

pub fn signal_filter_bessel_path_get(s : SignalfilterbesselPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_filter_bessel_path_set(s : SignalfilterbesselPath, i : Int, v : Double) -> SignalfilterbesselPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_filter_bessel_path_sum(s : SignalfilterbesselPath) -> Double { @_common.sum(s.data) }

pub fn signal_filter_bessel_path_mean(s : SignalfilterbesselPath) -> Double { @_common.mean(s.data) }

pub fn signal_filter_bessel_path_scale(s : SignalfilterbesselPath, f : Double) -> SignalfilterbesselPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_filter_bessel_path_add(a : SignalfilterbesselPath, b : SignalfilterbesselPath) -> SignalfilterbesselPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_filter_bessel_path_copy(s : SignalfilterbesselPath) -> SignalfilterbesselPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_filter_bessel_path_fill(s : SignalfilterbesselPath, v : Double) -> SignalfilterbesselPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_filter_bessel_path_min(s : SignalfilterbesselPath) -> Double { @_common.min(s.data) }

pub fn signal_filter_bessel_path_max(s : SignalfilterbesselPath) -> Double { @_common.max(s.data) }

pub fn signal_filter_bessel_path_to_string(s : SignalfilterbesselPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalfilterbesselCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_filter_bessel_cluster_make(size : Int) -> SignalfilterbesselCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_filter_bessel_cluster_len(s : SignalfilterbesselCluster) -> Int { s.size }

pub fn signal_filter_bessel_cluster_get(s : SignalfilterbesselCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_filter_bessel_cluster_set(s : SignalfilterbesselCluster, i : Int, v : Double) -> SignalfilterbesselCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_filter_bessel_cluster_sum(s : SignalfilterbesselCluster) -> Double { @_common.sum(s.data) }

pub fn signal_filter_bessel_cluster_mean(s : SignalfilterbesselCluster) -> Double { @_common.mean(s.data) }

pub fn signal_filter_bessel_cluster_scale(s : SignalfilterbesselCluster, f : Double) -> SignalfilterbesselCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_filter_bessel_cluster_add(a : SignalfilterbesselCluster, b : SignalfilterbesselCluster) -> SignalfilterbesselCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_filter_bessel_cluster_copy(s : SignalfilterbesselCluster) -> SignalfilterbesselCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_filter_bessel_cluster_fill(s : SignalfilterbesselCluster, v : Double) -> SignalfilterbesselCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_filter_bessel_cluster_min(s : SignalfilterbesselCluster) -> Double { @_common.min(s.data) }

pub fn signal_filter_bessel_cluster_max(s : SignalfilterbesselCluster) -> Double { @_common.max(s.data) }

pub fn signal_filter_bessel_cluster_to_string(s : SignalfilterbesselCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalfilterbesselModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_filter_bessel_model_make(size : Int) -> SignalfilterbesselModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_filter_bessel_model_len(s : SignalfilterbesselModel) -> Int { s.size }

pub fn signal_filter_bessel_model_get(s : SignalfilterbesselModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_filter_bessel_model_set(s : SignalfilterbesselModel, i : Int, v : Double) -> SignalfilterbesselModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_filter_bessel_model_sum(s : SignalfilterbesselModel) -> Double { @_common.sum(s.data) }

pub fn signal_filter_bessel_model_mean(s : SignalfilterbesselModel) -> Double { @_common.mean(s.data) }

pub fn signal_filter_bessel_model_scale(s : SignalfilterbesselModel, f : Double) -> SignalfilterbesselModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_filter_bessel_model_add(a : SignalfilterbesselModel, b : SignalfilterbesselModel) -> SignalfilterbesselModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_filter_bessel_model_copy(s : SignalfilterbesselModel) -> SignalfilterbesselModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_filter_bessel_model_fill(s : SignalfilterbesselModel, v : Double) -> SignalfilterbesselModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_filter_bessel_model_min(s : SignalfilterbesselModel) -> Double { @_common.min(s.data) }

pub fn signal_filter_bessel_model_max(s : SignalfilterbesselModel) -> Double { @_common.max(s.data) }

pub fn signal_filter_bessel_model_to_string(s : SignalfilterbesselModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalfilterbesselLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_filter_bessel_layer_make(size : Int) -> SignalfilterbesselLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_filter_bessel_layer_len(s : SignalfilterbesselLayer) -> Int { s.size }

pub fn signal_filter_bessel_layer_get(s : SignalfilterbesselLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_filter_bessel_layer_set(s : SignalfilterbesselLayer, i : Int, v : Double) -> SignalfilterbesselLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_filter_bessel_layer_sum(s : SignalfilterbesselLayer) -> Double { @_common.sum(s.data) }

pub fn signal_filter_bessel_layer_mean(s : SignalfilterbesselLayer) -> Double { @_common.mean(s.data) }

pub fn signal_filter_bessel_layer_scale(s : SignalfilterbesselLayer, f : Double) -> SignalfilterbesselLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_filter_bessel_layer_add(a : SignalfilterbesselLayer, b : SignalfilterbesselLayer) -> SignalfilterbesselLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_filter_bessel_layer_copy(s : SignalfilterbesselLayer) -> SignalfilterbesselLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_filter_bessel_layer_fill(s : SignalfilterbesselLayer, v : Double) -> SignalfilterbesselLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_filter_bessel_layer_min(s : SignalfilterbesselLayer) -> Double { @_common.min(s.data) }

pub fn signal_filter_bessel_layer_max(s : SignalfilterbesselLayer) -> Double { @_common.max(s.data) }

pub fn signal_filter_bessel_layer_to_string(s : SignalfilterbesselLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalfilterbesselBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_filter_bessel_buffer_make(size : Int) -> SignalfilterbesselBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_filter_bessel_buffer_len(s : SignalfilterbesselBuffer) -> Int { s.size }

pub fn signal_filter_bessel_buffer_get(s : SignalfilterbesselBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_filter_bessel_buffer_set(s : SignalfilterbesselBuffer, i : Int, v : Double) -> SignalfilterbesselBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_filter_bessel_buffer_sum(s : SignalfilterbesselBuffer) -> Double { @_common.sum(s.data) }

pub fn signal_filter_bessel_buffer_mean(s : SignalfilterbesselBuffer) -> Double { @_common.mean(s.data) }

pub fn signal_filter_bessel_buffer_scale(s : SignalfilterbesselBuffer, f : Double) -> SignalfilterbesselBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_filter_bessel_buffer_add(a : SignalfilterbesselBuffer, b : SignalfilterbesselBuffer) -> SignalfilterbesselBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_filter_bessel_buffer_copy(s : SignalfilterbesselBuffer) -> SignalfilterbesselBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_filter_bessel_buffer_fill(s : SignalfilterbesselBuffer, v : Double) -> SignalfilterbesselBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_filter_bessel_buffer_min(s : SignalfilterbesselBuffer) -> Double { @_common.min(s.data) }

pub fn signal_filter_bessel_buffer_max(s : SignalfilterbesselBuffer) -> Double { @_common.max(s.data) }

pub fn signal_filter_bessel_buffer_to_string(s : SignalfilterbesselBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalfilterbesselCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_filter_bessel_cursor_make(size : Int) -> SignalfilterbesselCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_filter_bessel_cursor_len(s : SignalfilterbesselCursor) -> Int { s.size }

pub fn signal_filter_bessel_cursor_get(s : SignalfilterbesselCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_filter_bessel_cursor_set(s : SignalfilterbesselCursor, i : Int, v : Double) -> SignalfilterbesselCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_filter_bessel_cursor_sum(s : SignalfilterbesselCursor) -> Double { @_common.sum(s.data) }

pub fn signal_filter_bessel_cursor_mean(s : SignalfilterbesselCursor) -> Double { @_common.mean(s.data) }

pub fn signal_filter_bessel_cursor_scale(s : SignalfilterbesselCursor, f : Double) -> SignalfilterbesselCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_filter_bessel_cursor_add(a : SignalfilterbesselCursor, b : SignalfilterbesselCursor) -> SignalfilterbesselCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_filter_bessel_cursor_copy(s : SignalfilterbesselCursor) -> SignalfilterbesselCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_filter_bessel_cursor_fill(s : SignalfilterbesselCursor, v : Double) -> SignalfilterbesselCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_filter_bessel_cursor_min(s : SignalfilterbesselCursor) -> Double { @_common.min(s.data) }

pub fn signal_filter_bessel_cursor_max(s : SignalfilterbesselCursor) -> Double { @_common.max(s.data) }

pub fn signal_filter_bessel_cursor_to_string(s : SignalfilterbesselCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalfilterbesselView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_filter_bessel_view_make(size : Int) -> SignalfilterbesselView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_filter_bessel_view_len(s : SignalfilterbesselView) -> Int { s.size }

pub fn signal_filter_bessel_view_get(s : SignalfilterbesselView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_filter_bessel_view_set(s : SignalfilterbesselView, i : Int, v : Double) -> SignalfilterbesselView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_filter_bessel_view_sum(s : SignalfilterbesselView) -> Double { @_common.sum(s.data) }

pub fn signal_filter_bessel_view_mean(s : SignalfilterbesselView) -> Double { @_common.mean(s.data) }

pub fn signal_filter_bessel_view_scale(s : SignalfilterbesselView, f : Double) -> SignalfilterbesselView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_filter_bessel_view_add(a : SignalfilterbesselView, b : SignalfilterbesselView) -> SignalfilterbesselView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_filter_bessel_view_copy(s : SignalfilterbesselView) -> SignalfilterbesselView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_filter_bessel_view_fill(s : SignalfilterbesselView, v : Double) -> SignalfilterbesselView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_filter_bessel_view_min(s : SignalfilterbesselView) -> Double { @_common.min(s.data) }

pub fn signal_filter_bessel_view_max(s : SignalfilterbesselView) -> Double { @_common.max(s.data) }

pub fn signal_filter_bessel_view_to_string(s : SignalfilterbesselView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalfilterbesselRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_filter_bessel_range_make(size : Int) -> SignalfilterbesselRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_filter_bessel_range_len(s : SignalfilterbesselRange) -> Int { s.size }

pub fn signal_filter_bessel_range_get(s : SignalfilterbesselRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_filter_bessel_range_set(s : SignalfilterbesselRange, i : Int, v : Double) -> SignalfilterbesselRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_filter_bessel_range_sum(s : SignalfilterbesselRange) -> Double { @_common.sum(s.data) }

pub fn signal_filter_bessel_range_mean(s : SignalfilterbesselRange) -> Double { @_common.mean(s.data) }

pub fn signal_filter_bessel_range_scale(s : SignalfilterbesselRange, f : Double) -> SignalfilterbesselRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_filter_bessel_range_add(a : SignalfilterbesselRange, b : SignalfilterbesselRange) -> SignalfilterbesselRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_filter_bessel_range_copy(s : SignalfilterbesselRange) -> SignalfilterbesselRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_filter_bessel_range_fill(s : SignalfilterbesselRange, v : Double) -> SignalfilterbesselRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_filter_bessel_range_min(s : SignalfilterbesselRange) -> Double { @_common.min(s.data) }

pub fn signal_filter_bessel_range_max(s : SignalfilterbesselRange) -> Double { @_common.max(s.data) }

pub fn signal_filter_bessel_range_to_string(s : SignalfilterbesselRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalfilterbesselSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_filter_bessel_slice_make(size : Int) -> SignalfilterbesselSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_filter_bessel_slice_len(s : SignalfilterbesselSlice) -> Int { s.size }

pub fn signal_filter_bessel_slice_get(s : SignalfilterbesselSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_filter_bessel_slice_set(s : SignalfilterbesselSlice, i : Int, v : Double) -> SignalfilterbesselSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_filter_bessel_slice_sum(s : SignalfilterbesselSlice) -> Double { @_common.sum(s.data) }

pub fn signal_filter_bessel_slice_mean(s : SignalfilterbesselSlice) -> Double { @_common.mean(s.data) }

pub fn signal_filter_bessel_slice_scale(s : SignalfilterbesselSlice, f : Double) -> SignalfilterbesselSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_filter_bessel_slice_add(a : SignalfilterbesselSlice, b : SignalfilterbesselSlice) -> SignalfilterbesselSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_filter_bessel_slice_copy(s : SignalfilterbesselSlice) -> SignalfilterbesselSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_filter_bessel_slice_fill(s : SignalfilterbesselSlice, v : Double) -> SignalfilterbesselSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_filter_bessel_slice_min(s : SignalfilterbesselSlice) -> Double { @_common.min(s.data) }

pub fn signal_filter_bessel_slice_max(s : SignalfilterbesselSlice) -> Double { @_common.max(s.data) }

pub fn signal_filter_bessel_slice_to_string(s : SignalfilterbesselSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

