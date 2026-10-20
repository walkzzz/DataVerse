///===
/// extcore/signal_filter_wiener

pub(all) struct SignalfilterwienerPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn signal_filter_wiener_make_point(x : Double, y : Double) -> SignalfilterwienerPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn signal_filter_wiener_make_point3(x : Double, y : Double, z : Double) -> SignalfilterwienerPoint {
  { x, y, z, label: 0 }
}

pub fn SignalfilterwienerPoint::x(self : SignalfilterwienerPoint) -> Double { self.x }

pub fn SignalfilterwienerPoint::y(self : SignalfilterwienerPoint) -> Double { self.y }

pub fn SignalfilterwienerPoint::z(self : SignalfilterwienerPoint) -> Double { self.z }

pub fn SignalfilterwienerPoint::label(self : SignalfilterwienerPoint) -> Int { self.label }

pub fn SignalfilterwienerPoint::dist(self : SignalfilterwienerPoint, other : SignalfilterwienerPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn SignalfilterwienerPoint::add(self : SignalfilterwienerPoint, other : SignalfilterwienerPoint) -> SignalfilterwienerPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn SignalfilterwienerPoint::sub(self : SignalfilterwienerPoint, other : SignalfilterwienerPoint) -> SignalfilterwienerPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn SignalfilterwienerPoint::scale(self : SignalfilterwienerPoint, s : Double) -> SignalfilterwienerPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn SignalfilterwienerPoint::dot(self : SignalfilterwienerPoint, other : SignalfilterwienerPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn SignalfilterwienerPoint::cross(self : SignalfilterwienerPoint, other : SignalfilterwienerPoint) -> SignalfilterwienerPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn SignalfilterwienerPoint::norm(self : SignalfilterwienerPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn SignalfilterwienerPoint::normalize(self : SignalfilterwienerPoint) -> SignalfilterwienerPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn SignalfilterwienerPoint::negate(self : SignalfilterwienerPoint) -> SignalfilterwienerPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn SignalfilterwienerPoint::mid(self : SignalfilterwienerPoint, other : SignalfilterwienerPoint) -> SignalfilterwienerPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn SignalfilterwienerPoint::lerp(self : SignalfilterwienerPoint, other : SignalfilterwienerPoint, t : Double) -> SignalfilterwienerPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn SignalfilterwienerPoint::to_string(self : SignalfilterwienerPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct SignalfilterwienerSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn signal_filter_wiener_make_series(vals : Array[Double], name : String) -> SignalfilterwienerSeries {
  { vals, name, meta: 0 }
}

pub fn SignalfilterwienerSeries::len(self : SignalfilterwienerSeries) -> Int { self.vals.length() }

pub fn SignalfilterwienerSeries::sum(self : SignalfilterwienerSeries) -> Double { @_common.sum(self.vals) }

pub fn SignalfilterwienerSeries::mean(self : SignalfilterwienerSeries) -> Double { @_common.mean(self.vals) }

pub fn SignalfilterwienerSeries::min(self : SignalfilterwienerSeries) -> Double { @_common.min(self.vals) }

pub fn SignalfilterwienerSeries::max(self : SignalfilterwienerSeries) -> Double { @_common.max(self.vals) }

pub fn SignalfilterwienerSeries::range(self : SignalfilterwienerSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn SignalfilterwienerSeries::variance(self : SignalfilterwienerSeries) -> Double { @_common.variance(self.vals) }

pub fn SignalfilterwienerSeries::std(self : SignalfilterwienerSeries) -> Double { @_common.std(self.vals) }

pub fn SignalfilterwienerSeries::median(self : SignalfilterwienerSeries) -> Double { @_common.median(self.vals) }

pub fn SignalfilterwienerSeries::scale(self : SignalfilterwienerSeries, f : Double) -> SignalfilterwienerSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn SignalfilterwienerSeries::add(self : SignalfilterwienerSeries, other : SignalfilterwienerSeries) -> SignalfilterwienerSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn SignalfilterwienerSeries::sub(self : SignalfilterwienerSeries, other : SignalfilterwienerSeries) -> SignalfilterwienerSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn SignalfilterwienerSeries::normalize(self : SignalfilterwienerSeries) -> SignalfilterwienerSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn SignalfilterwienerSeries::cumsum(self : SignalfilterwienerSeries) -> SignalfilterwienerSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn SignalfilterwienerSeries::to_string(self : SignalfilterwienerSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct SignalfilterwienerMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn signal_filter_wiener_make_matrix(rows : Int, cols : Int, val : Double) -> SignalfilterwienerMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn signal_filter_wiener_matrix_identity(n : Int) -> SignalfilterwienerMatrix {
  let m = signal_filter_wiener_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn SignalfilterwienerMatrix::get(self : SignalfilterwienerMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn SignalfilterwienerMatrix::transpose(self : SignalfilterwienerMatrix) -> SignalfilterwienerMatrix {
  let result = signal_filter_wiener_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn SignalfilterwienerMatrix::add(self : SignalfilterwienerMatrix, other : SignalfilterwienerMatrix) -> SignalfilterwienerMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = signal_filter_wiener_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn SignalfilterwienerMatrix::scale(self : SignalfilterwienerMatrix, s : Double) -> SignalfilterwienerMatrix {
  let result = signal_filter_wiener_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn SignalfilterwienerMatrix::multiply(self : SignalfilterwienerMatrix, other : SignalfilterwienerMatrix) -> SignalfilterwienerMatrix {
  if self.cols != other.rows { return signal_filter_wiener_make_matrix(self.rows, other.cols, 0.0) }
  let result = signal_filter_wiener_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn SignalfilterwienerMatrix::trace(self : SignalfilterwienerMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn SignalfilterwienerMatrix::det(self : SignalfilterwienerMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn SignalfilterwienerMatrix::norm(self : SignalfilterwienerMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn SignalfilterwienerMatrix::to_string(self : SignalfilterwienerMatrix) -> String {
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

pub(all) struct SignalfilterwienerVector {
  comps : Array[Double]
  dim : Int
}

pub fn signal_filter_wiener_make_vector(comps : Array[Double]) -> SignalfilterwienerVector {
  { comps, dim: comps.length() }
}

pub fn signal_filter_wiener_vector_zero(dim : Int) -> SignalfilterwienerVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn SignalfilterwienerVector::add(self : SignalfilterwienerVector, other : SignalfilterwienerVector) -> SignalfilterwienerVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn SignalfilterwienerVector::sub(self : SignalfilterwienerVector, other : SignalfilterwienerVector) -> SignalfilterwienerVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn SignalfilterwienerVector::scale(self : SignalfilterwienerVector, s : Double) -> SignalfilterwienerVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn SignalfilterwienerVector::dot(self : SignalfilterwienerVector, other : SignalfilterwienerVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn SignalfilterwienerVector::norm(self : SignalfilterwienerVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn SignalfilterwienerVector::normalize(self : SignalfilterwienerVector) -> SignalfilterwienerVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn SignalfilterwienerVector::dist(self : SignalfilterwienerVector, other : SignalfilterwienerVector) -> Double {
  self.sub(other).norm()
}

pub fn SignalfilterwienerVector::to_string(self : SignalfilterwienerVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn signal_filter_wiener_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn signal_filter_wiener_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn signal_filter_wiener_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn signal_filter_wiener_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn signal_filter_wiener_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn signal_filter_wiener_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn signal_filter_wiener_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn signal_filter_wiener_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn signal_filter_wiener_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn signal_filter_wiener_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn signal_filter_wiener_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn signal_filter_wiener_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn signal_filter_wiener_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn signal_filter_wiener_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn signal_filter_wiener_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn signal_filter_wiener_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn signal_filter_wiener_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn signal_filter_wiener_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn signal_filter_wiener_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn signal_filter_wiener_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn signal_filter_wiener_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn signal_filter_wiener_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn signal_filter_wiener_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn signal_filter_wiener_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn signal_filter_wiener_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn signal_filter_wiener_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn signal_filter_wiener_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn signal_filter_wiener_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn signal_filter_wiener_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct SignalfilterwienerFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_filter_wiener_frame_make(size : Int) -> SignalfilterwienerFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_filter_wiener_frame_len(s : SignalfilterwienerFrame) -> Int { s.size }

pub fn signal_filter_wiener_frame_get(s : SignalfilterwienerFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_filter_wiener_frame_set(s : SignalfilterwienerFrame, i : Int, v : Double) -> SignalfilterwienerFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_filter_wiener_frame_sum(s : SignalfilterwienerFrame) -> Double { @_common.sum(s.data) }

pub fn signal_filter_wiener_frame_mean(s : SignalfilterwienerFrame) -> Double { @_common.mean(s.data) }

pub fn signal_filter_wiener_frame_scale(s : SignalfilterwienerFrame, f : Double) -> SignalfilterwienerFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_filter_wiener_frame_add(a : SignalfilterwienerFrame, b : SignalfilterwienerFrame) -> SignalfilterwienerFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_filter_wiener_frame_copy(s : SignalfilterwienerFrame) -> SignalfilterwienerFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_filter_wiener_frame_fill(s : SignalfilterwienerFrame, v : Double) -> SignalfilterwienerFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_filter_wiener_frame_min(s : SignalfilterwienerFrame) -> Double { @_common.min(s.data) }

pub fn signal_filter_wiener_frame_max(s : SignalfilterwienerFrame) -> Double { @_common.max(s.data) }

pub fn signal_filter_wiener_frame_to_string(s : SignalfilterwienerFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalfilterwienerTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_filter_wiener_table_make(size : Int) -> SignalfilterwienerTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_filter_wiener_table_len(s : SignalfilterwienerTable) -> Int { s.size }

pub fn signal_filter_wiener_table_get(s : SignalfilterwienerTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_filter_wiener_table_set(s : SignalfilterwienerTable, i : Int, v : Double) -> SignalfilterwienerTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_filter_wiener_table_sum(s : SignalfilterwienerTable) -> Double { @_common.sum(s.data) }

pub fn signal_filter_wiener_table_mean(s : SignalfilterwienerTable) -> Double { @_common.mean(s.data) }

pub fn signal_filter_wiener_table_scale(s : SignalfilterwienerTable, f : Double) -> SignalfilterwienerTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_filter_wiener_table_add(a : SignalfilterwienerTable, b : SignalfilterwienerTable) -> SignalfilterwienerTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_filter_wiener_table_copy(s : SignalfilterwienerTable) -> SignalfilterwienerTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_filter_wiener_table_fill(s : SignalfilterwienerTable, v : Double) -> SignalfilterwienerTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_filter_wiener_table_min(s : SignalfilterwienerTable) -> Double { @_common.min(s.data) }

pub fn signal_filter_wiener_table_max(s : SignalfilterwienerTable) -> Double { @_common.max(s.data) }

pub fn signal_filter_wiener_table_to_string(s : SignalfilterwienerTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalfilterwienerGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_filter_wiener_graphn_make(size : Int) -> SignalfilterwienerGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_filter_wiener_graphn_len(s : SignalfilterwienerGraphN) -> Int { s.size }

pub fn signal_filter_wiener_graphn_get(s : SignalfilterwienerGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_filter_wiener_graphn_set(s : SignalfilterwienerGraphN, i : Int, v : Double) -> SignalfilterwienerGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_filter_wiener_graphn_sum(s : SignalfilterwienerGraphN) -> Double { @_common.sum(s.data) }

pub fn signal_filter_wiener_graphn_mean(s : SignalfilterwienerGraphN) -> Double { @_common.mean(s.data) }

pub fn signal_filter_wiener_graphn_scale(s : SignalfilterwienerGraphN, f : Double) -> SignalfilterwienerGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_filter_wiener_graphn_add(a : SignalfilterwienerGraphN, b : SignalfilterwienerGraphN) -> SignalfilterwienerGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_filter_wiener_graphn_copy(s : SignalfilterwienerGraphN) -> SignalfilterwienerGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_filter_wiener_graphn_fill(s : SignalfilterwienerGraphN, v : Double) -> SignalfilterwienerGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_filter_wiener_graphn_min(s : SignalfilterwienerGraphN) -> Double { @_common.min(s.data) }

pub fn signal_filter_wiener_graphn_max(s : SignalfilterwienerGraphN) -> Double { @_common.max(s.data) }

pub fn signal_filter_wiener_graphn_to_string(s : SignalfilterwienerGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalfilterwienerNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_filter_wiener_node_make(size : Int) -> SignalfilterwienerNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_filter_wiener_node_len(s : SignalfilterwienerNode) -> Int { s.size }

pub fn signal_filter_wiener_node_get(s : SignalfilterwienerNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_filter_wiener_node_set(s : SignalfilterwienerNode, i : Int, v : Double) -> SignalfilterwienerNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_filter_wiener_node_sum(s : SignalfilterwienerNode) -> Double { @_common.sum(s.data) }

pub fn signal_filter_wiener_node_mean(s : SignalfilterwienerNode) -> Double { @_common.mean(s.data) }

pub fn signal_filter_wiener_node_scale(s : SignalfilterwienerNode, f : Double) -> SignalfilterwienerNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_filter_wiener_node_add(a : SignalfilterwienerNode, b : SignalfilterwienerNode) -> SignalfilterwienerNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_filter_wiener_node_copy(s : SignalfilterwienerNode) -> SignalfilterwienerNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_filter_wiener_node_fill(s : SignalfilterwienerNode, v : Double) -> SignalfilterwienerNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_filter_wiener_node_min(s : SignalfilterwienerNode) -> Double { @_common.min(s.data) }

pub fn signal_filter_wiener_node_max(s : SignalfilterwienerNode) -> Double { @_common.max(s.data) }

pub fn signal_filter_wiener_node_to_string(s : SignalfilterwienerNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalfilterwienerEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_filter_wiener_edge_make(size : Int) -> SignalfilterwienerEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_filter_wiener_edge_len(s : SignalfilterwienerEdge) -> Int { s.size }

pub fn signal_filter_wiener_edge_get(s : SignalfilterwienerEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_filter_wiener_edge_set(s : SignalfilterwienerEdge, i : Int, v : Double) -> SignalfilterwienerEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_filter_wiener_edge_sum(s : SignalfilterwienerEdge) -> Double { @_common.sum(s.data) }

pub fn signal_filter_wiener_edge_mean(s : SignalfilterwienerEdge) -> Double { @_common.mean(s.data) }

pub fn signal_filter_wiener_edge_scale(s : SignalfilterwienerEdge, f : Double) -> SignalfilterwienerEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_filter_wiener_edge_add(a : SignalfilterwienerEdge, b : SignalfilterwienerEdge) -> SignalfilterwienerEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_filter_wiener_edge_copy(s : SignalfilterwienerEdge) -> SignalfilterwienerEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_filter_wiener_edge_fill(s : SignalfilterwienerEdge, v : Double) -> SignalfilterwienerEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_filter_wiener_edge_min(s : SignalfilterwienerEdge) -> Double { @_common.min(s.data) }

pub fn signal_filter_wiener_edge_max(s : SignalfilterwienerEdge) -> Double { @_common.max(s.data) }

pub fn signal_filter_wiener_edge_to_string(s : SignalfilterwienerEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalfilterwienerPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_filter_wiener_path_make(size : Int) -> SignalfilterwienerPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_filter_wiener_path_len(s : SignalfilterwienerPath) -> Int { s.size }

pub fn signal_filter_wiener_path_get(s : SignalfilterwienerPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_filter_wiener_path_set(s : SignalfilterwienerPath, i : Int, v : Double) -> SignalfilterwienerPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_filter_wiener_path_sum(s : SignalfilterwienerPath) -> Double { @_common.sum(s.data) }

pub fn signal_filter_wiener_path_mean(s : SignalfilterwienerPath) -> Double { @_common.mean(s.data) }

pub fn signal_filter_wiener_path_scale(s : SignalfilterwienerPath, f : Double) -> SignalfilterwienerPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_filter_wiener_path_add(a : SignalfilterwienerPath, b : SignalfilterwienerPath) -> SignalfilterwienerPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_filter_wiener_path_copy(s : SignalfilterwienerPath) -> SignalfilterwienerPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_filter_wiener_path_fill(s : SignalfilterwienerPath, v : Double) -> SignalfilterwienerPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_filter_wiener_path_min(s : SignalfilterwienerPath) -> Double { @_common.min(s.data) }

pub fn signal_filter_wiener_path_max(s : SignalfilterwienerPath) -> Double { @_common.max(s.data) }

pub fn signal_filter_wiener_path_to_string(s : SignalfilterwienerPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalfilterwienerCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_filter_wiener_cluster_make(size : Int) -> SignalfilterwienerCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_filter_wiener_cluster_len(s : SignalfilterwienerCluster) -> Int { s.size }

pub fn signal_filter_wiener_cluster_get(s : SignalfilterwienerCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_filter_wiener_cluster_set(s : SignalfilterwienerCluster, i : Int, v : Double) -> SignalfilterwienerCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_filter_wiener_cluster_sum(s : SignalfilterwienerCluster) -> Double { @_common.sum(s.data) }

pub fn signal_filter_wiener_cluster_mean(s : SignalfilterwienerCluster) -> Double { @_common.mean(s.data) }

pub fn signal_filter_wiener_cluster_scale(s : SignalfilterwienerCluster, f : Double) -> SignalfilterwienerCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_filter_wiener_cluster_add(a : SignalfilterwienerCluster, b : SignalfilterwienerCluster) -> SignalfilterwienerCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_filter_wiener_cluster_copy(s : SignalfilterwienerCluster) -> SignalfilterwienerCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_filter_wiener_cluster_fill(s : SignalfilterwienerCluster, v : Double) -> SignalfilterwienerCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_filter_wiener_cluster_min(s : SignalfilterwienerCluster) -> Double { @_common.min(s.data) }

pub fn signal_filter_wiener_cluster_max(s : SignalfilterwienerCluster) -> Double { @_common.max(s.data) }

pub fn signal_filter_wiener_cluster_to_string(s : SignalfilterwienerCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalfilterwienerModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_filter_wiener_model_make(size : Int) -> SignalfilterwienerModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_filter_wiener_model_len(s : SignalfilterwienerModel) -> Int { s.size }

pub fn signal_filter_wiener_model_get(s : SignalfilterwienerModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_filter_wiener_model_set(s : SignalfilterwienerModel, i : Int, v : Double) -> SignalfilterwienerModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_filter_wiener_model_sum(s : SignalfilterwienerModel) -> Double { @_common.sum(s.data) }

pub fn signal_filter_wiener_model_mean(s : SignalfilterwienerModel) -> Double { @_common.mean(s.data) }

pub fn signal_filter_wiener_model_scale(s : SignalfilterwienerModel, f : Double) -> SignalfilterwienerModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_filter_wiener_model_add(a : SignalfilterwienerModel, b : SignalfilterwienerModel) -> SignalfilterwienerModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_filter_wiener_model_copy(s : SignalfilterwienerModel) -> SignalfilterwienerModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_filter_wiener_model_fill(s : SignalfilterwienerModel, v : Double) -> SignalfilterwienerModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_filter_wiener_model_min(s : SignalfilterwienerModel) -> Double { @_common.min(s.data) }

pub fn signal_filter_wiener_model_max(s : SignalfilterwienerModel) -> Double { @_common.max(s.data) }

pub fn signal_filter_wiener_model_to_string(s : SignalfilterwienerModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalfilterwienerLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_filter_wiener_layer_make(size : Int) -> SignalfilterwienerLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_filter_wiener_layer_len(s : SignalfilterwienerLayer) -> Int { s.size }

pub fn signal_filter_wiener_layer_get(s : SignalfilterwienerLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_filter_wiener_layer_set(s : SignalfilterwienerLayer, i : Int, v : Double) -> SignalfilterwienerLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_filter_wiener_layer_sum(s : SignalfilterwienerLayer) -> Double { @_common.sum(s.data) }

pub fn signal_filter_wiener_layer_mean(s : SignalfilterwienerLayer) -> Double { @_common.mean(s.data) }

pub fn signal_filter_wiener_layer_scale(s : SignalfilterwienerLayer, f : Double) -> SignalfilterwienerLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_filter_wiener_layer_add(a : SignalfilterwienerLayer, b : SignalfilterwienerLayer) -> SignalfilterwienerLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_filter_wiener_layer_copy(s : SignalfilterwienerLayer) -> SignalfilterwienerLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_filter_wiener_layer_fill(s : SignalfilterwienerLayer, v : Double) -> SignalfilterwienerLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_filter_wiener_layer_min(s : SignalfilterwienerLayer) -> Double { @_common.min(s.data) }

pub fn signal_filter_wiener_layer_max(s : SignalfilterwienerLayer) -> Double { @_common.max(s.data) }

pub fn signal_filter_wiener_layer_to_string(s : SignalfilterwienerLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalfilterwienerBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_filter_wiener_buffer_make(size : Int) -> SignalfilterwienerBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_filter_wiener_buffer_len(s : SignalfilterwienerBuffer) -> Int { s.size }

pub fn signal_filter_wiener_buffer_get(s : SignalfilterwienerBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_filter_wiener_buffer_set(s : SignalfilterwienerBuffer, i : Int, v : Double) -> SignalfilterwienerBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_filter_wiener_buffer_sum(s : SignalfilterwienerBuffer) -> Double { @_common.sum(s.data) }

pub fn signal_filter_wiener_buffer_mean(s : SignalfilterwienerBuffer) -> Double { @_common.mean(s.data) }

pub fn signal_filter_wiener_buffer_scale(s : SignalfilterwienerBuffer, f : Double) -> SignalfilterwienerBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_filter_wiener_buffer_add(a : SignalfilterwienerBuffer, b : SignalfilterwienerBuffer) -> SignalfilterwienerBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_filter_wiener_buffer_copy(s : SignalfilterwienerBuffer) -> SignalfilterwienerBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_filter_wiener_buffer_fill(s : SignalfilterwienerBuffer, v : Double) -> SignalfilterwienerBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_filter_wiener_buffer_min(s : SignalfilterwienerBuffer) -> Double { @_common.min(s.data) }

pub fn signal_filter_wiener_buffer_max(s : SignalfilterwienerBuffer) -> Double { @_common.max(s.data) }

pub fn signal_filter_wiener_buffer_to_string(s : SignalfilterwienerBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalfilterwienerCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_filter_wiener_cursor_make(size : Int) -> SignalfilterwienerCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_filter_wiener_cursor_len(s : SignalfilterwienerCursor) -> Int { s.size }

pub fn signal_filter_wiener_cursor_get(s : SignalfilterwienerCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_filter_wiener_cursor_set(s : SignalfilterwienerCursor, i : Int, v : Double) -> SignalfilterwienerCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_filter_wiener_cursor_sum(s : SignalfilterwienerCursor) -> Double { @_common.sum(s.data) }

pub fn signal_filter_wiener_cursor_mean(s : SignalfilterwienerCursor) -> Double { @_common.mean(s.data) }

pub fn signal_filter_wiener_cursor_scale(s : SignalfilterwienerCursor, f : Double) -> SignalfilterwienerCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_filter_wiener_cursor_add(a : SignalfilterwienerCursor, b : SignalfilterwienerCursor) -> SignalfilterwienerCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_filter_wiener_cursor_copy(s : SignalfilterwienerCursor) -> SignalfilterwienerCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_filter_wiener_cursor_fill(s : SignalfilterwienerCursor, v : Double) -> SignalfilterwienerCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_filter_wiener_cursor_min(s : SignalfilterwienerCursor) -> Double { @_common.min(s.data) }

pub fn signal_filter_wiener_cursor_max(s : SignalfilterwienerCursor) -> Double { @_common.max(s.data) }

pub fn signal_filter_wiener_cursor_to_string(s : SignalfilterwienerCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalfilterwienerView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_filter_wiener_view_make(size : Int) -> SignalfilterwienerView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_filter_wiener_view_len(s : SignalfilterwienerView) -> Int { s.size }

pub fn signal_filter_wiener_view_get(s : SignalfilterwienerView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_filter_wiener_view_set(s : SignalfilterwienerView, i : Int, v : Double) -> SignalfilterwienerView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_filter_wiener_view_sum(s : SignalfilterwienerView) -> Double { @_common.sum(s.data) }

pub fn signal_filter_wiener_view_mean(s : SignalfilterwienerView) -> Double { @_common.mean(s.data) }

pub fn signal_filter_wiener_view_scale(s : SignalfilterwienerView, f : Double) -> SignalfilterwienerView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_filter_wiener_view_add(a : SignalfilterwienerView, b : SignalfilterwienerView) -> SignalfilterwienerView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_filter_wiener_view_copy(s : SignalfilterwienerView) -> SignalfilterwienerView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_filter_wiener_view_fill(s : SignalfilterwienerView, v : Double) -> SignalfilterwienerView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_filter_wiener_view_min(s : SignalfilterwienerView) -> Double { @_common.min(s.data) }

pub fn signal_filter_wiener_view_max(s : SignalfilterwienerView) -> Double { @_common.max(s.data) }

pub fn signal_filter_wiener_view_to_string(s : SignalfilterwienerView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalfilterwienerRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_filter_wiener_range_make(size : Int) -> SignalfilterwienerRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_filter_wiener_range_len(s : SignalfilterwienerRange) -> Int { s.size }

pub fn signal_filter_wiener_range_get(s : SignalfilterwienerRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_filter_wiener_range_set(s : SignalfilterwienerRange, i : Int, v : Double) -> SignalfilterwienerRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_filter_wiener_range_sum(s : SignalfilterwienerRange) -> Double { @_common.sum(s.data) }

pub fn signal_filter_wiener_range_mean(s : SignalfilterwienerRange) -> Double { @_common.mean(s.data) }

pub fn signal_filter_wiener_range_scale(s : SignalfilterwienerRange, f : Double) -> SignalfilterwienerRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_filter_wiener_range_add(a : SignalfilterwienerRange, b : SignalfilterwienerRange) -> SignalfilterwienerRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_filter_wiener_range_copy(s : SignalfilterwienerRange) -> SignalfilterwienerRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_filter_wiener_range_fill(s : SignalfilterwienerRange, v : Double) -> SignalfilterwienerRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_filter_wiener_range_min(s : SignalfilterwienerRange) -> Double { @_common.min(s.data) }

pub fn signal_filter_wiener_range_max(s : SignalfilterwienerRange) -> Double { @_common.max(s.data) }

pub fn signal_filter_wiener_range_to_string(s : SignalfilterwienerRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalfilterwienerSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_filter_wiener_slice_make(size : Int) -> SignalfilterwienerSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_filter_wiener_slice_len(s : SignalfilterwienerSlice) -> Int { s.size }

pub fn signal_filter_wiener_slice_get(s : SignalfilterwienerSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_filter_wiener_slice_set(s : SignalfilterwienerSlice, i : Int, v : Double) -> SignalfilterwienerSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_filter_wiener_slice_sum(s : SignalfilterwienerSlice) -> Double { @_common.sum(s.data) }

pub fn signal_filter_wiener_slice_mean(s : SignalfilterwienerSlice) -> Double { @_common.mean(s.data) }

pub fn signal_filter_wiener_slice_scale(s : SignalfilterwienerSlice, f : Double) -> SignalfilterwienerSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_filter_wiener_slice_add(a : SignalfilterwienerSlice, b : SignalfilterwienerSlice) -> SignalfilterwienerSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_filter_wiener_slice_copy(s : SignalfilterwienerSlice) -> SignalfilterwienerSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_filter_wiener_slice_fill(s : SignalfilterwienerSlice, v : Double) -> SignalfilterwienerSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_filter_wiener_slice_min(s : SignalfilterwienerSlice) -> Double { @_common.min(s.data) }

pub fn signal_filter_wiener_slice_max(s : SignalfilterwienerSlice) -> Double { @_common.max(s.data) }

pub fn signal_filter_wiener_slice_to_string(s : SignalfilterwienerSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

