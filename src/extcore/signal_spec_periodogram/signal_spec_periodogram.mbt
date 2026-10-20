///===
/// extcore/signal_spec_periodogram

pub(all) struct SignalspecperiodogramPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn signal_spec_periodogram_make_point(x : Double, y : Double) -> SignalspecperiodogramPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn signal_spec_periodogram_make_point3(x : Double, y : Double, z : Double) -> SignalspecperiodogramPoint {
  { x, y, z, label: 0 }
}

pub fn SignalspecperiodogramPoint::x(self : SignalspecperiodogramPoint) -> Double { self.x }

pub fn SignalspecperiodogramPoint::y(self : SignalspecperiodogramPoint) -> Double { self.y }

pub fn SignalspecperiodogramPoint::z(self : SignalspecperiodogramPoint) -> Double { self.z }

pub fn SignalspecperiodogramPoint::label(self : SignalspecperiodogramPoint) -> Int { self.label }

pub fn SignalspecperiodogramPoint::dist(self : SignalspecperiodogramPoint, other : SignalspecperiodogramPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn SignalspecperiodogramPoint::add(self : SignalspecperiodogramPoint, other : SignalspecperiodogramPoint) -> SignalspecperiodogramPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn SignalspecperiodogramPoint::sub(self : SignalspecperiodogramPoint, other : SignalspecperiodogramPoint) -> SignalspecperiodogramPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn SignalspecperiodogramPoint::scale(self : SignalspecperiodogramPoint, s : Double) -> SignalspecperiodogramPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn SignalspecperiodogramPoint::dot(self : SignalspecperiodogramPoint, other : SignalspecperiodogramPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn SignalspecperiodogramPoint::cross(self : SignalspecperiodogramPoint, other : SignalspecperiodogramPoint) -> SignalspecperiodogramPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn SignalspecperiodogramPoint::norm(self : SignalspecperiodogramPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn SignalspecperiodogramPoint::normalize(self : SignalspecperiodogramPoint) -> SignalspecperiodogramPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn SignalspecperiodogramPoint::negate(self : SignalspecperiodogramPoint) -> SignalspecperiodogramPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn SignalspecperiodogramPoint::mid(self : SignalspecperiodogramPoint, other : SignalspecperiodogramPoint) -> SignalspecperiodogramPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn SignalspecperiodogramPoint::lerp(self : SignalspecperiodogramPoint, other : SignalspecperiodogramPoint, t : Double) -> SignalspecperiodogramPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn SignalspecperiodogramPoint::to_string(self : SignalspecperiodogramPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct SignalspecperiodogramSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn signal_spec_periodogram_make_series(vals : Array[Double], name : String) -> SignalspecperiodogramSeries {
  { vals, name, meta: 0 }
}

pub fn SignalspecperiodogramSeries::len(self : SignalspecperiodogramSeries) -> Int { self.vals.length() }

pub fn SignalspecperiodogramSeries::sum(self : SignalspecperiodogramSeries) -> Double { @_common.sum(self.vals) }

pub fn SignalspecperiodogramSeries::mean(self : SignalspecperiodogramSeries) -> Double { @_common.mean(self.vals) }

pub fn SignalspecperiodogramSeries::min(self : SignalspecperiodogramSeries) -> Double { @_common.min(self.vals) }

pub fn SignalspecperiodogramSeries::max(self : SignalspecperiodogramSeries) -> Double { @_common.max(self.vals) }

pub fn SignalspecperiodogramSeries::range(self : SignalspecperiodogramSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn SignalspecperiodogramSeries::variance(self : SignalspecperiodogramSeries) -> Double { @_common.variance(self.vals) }

pub fn SignalspecperiodogramSeries::std(self : SignalspecperiodogramSeries) -> Double { @_common.std(self.vals) }

pub fn SignalspecperiodogramSeries::median(self : SignalspecperiodogramSeries) -> Double { @_common.median(self.vals) }

pub fn SignalspecperiodogramSeries::scale(self : SignalspecperiodogramSeries, f : Double) -> SignalspecperiodogramSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn SignalspecperiodogramSeries::add(self : SignalspecperiodogramSeries, other : SignalspecperiodogramSeries) -> SignalspecperiodogramSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn SignalspecperiodogramSeries::sub(self : SignalspecperiodogramSeries, other : SignalspecperiodogramSeries) -> SignalspecperiodogramSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn SignalspecperiodogramSeries::normalize(self : SignalspecperiodogramSeries) -> SignalspecperiodogramSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn SignalspecperiodogramSeries::cumsum(self : SignalspecperiodogramSeries) -> SignalspecperiodogramSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn SignalspecperiodogramSeries::to_string(self : SignalspecperiodogramSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct SignalspecperiodogramMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn signal_spec_periodogram_make_matrix(rows : Int, cols : Int, val : Double) -> SignalspecperiodogramMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn signal_spec_periodogram_matrix_identity(n : Int) -> SignalspecperiodogramMatrix {
  let m = signal_spec_periodogram_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn SignalspecperiodogramMatrix::get(self : SignalspecperiodogramMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn SignalspecperiodogramMatrix::transpose(self : SignalspecperiodogramMatrix) -> SignalspecperiodogramMatrix {
  let result = signal_spec_periodogram_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn SignalspecperiodogramMatrix::add(self : SignalspecperiodogramMatrix, other : SignalspecperiodogramMatrix) -> SignalspecperiodogramMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = signal_spec_periodogram_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn SignalspecperiodogramMatrix::scale(self : SignalspecperiodogramMatrix, s : Double) -> SignalspecperiodogramMatrix {
  let result = signal_spec_periodogram_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn SignalspecperiodogramMatrix::multiply(self : SignalspecperiodogramMatrix, other : SignalspecperiodogramMatrix) -> SignalspecperiodogramMatrix {
  if self.cols != other.rows { return signal_spec_periodogram_make_matrix(self.rows, other.cols, 0.0) }
  let result = signal_spec_periodogram_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn SignalspecperiodogramMatrix::trace(self : SignalspecperiodogramMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn SignalspecperiodogramMatrix::det(self : SignalspecperiodogramMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn SignalspecperiodogramMatrix::norm(self : SignalspecperiodogramMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn SignalspecperiodogramMatrix::to_string(self : SignalspecperiodogramMatrix) -> String {
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

pub(all) struct SignalspecperiodogramVector {
  comps : Array[Double]
  dim : Int
}

pub fn signal_spec_periodogram_make_vector(comps : Array[Double]) -> SignalspecperiodogramVector {
  { comps, dim: comps.length() }
}

pub fn signal_spec_periodogram_vector_zero(dim : Int) -> SignalspecperiodogramVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn SignalspecperiodogramVector::add(self : SignalspecperiodogramVector, other : SignalspecperiodogramVector) -> SignalspecperiodogramVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn SignalspecperiodogramVector::sub(self : SignalspecperiodogramVector, other : SignalspecperiodogramVector) -> SignalspecperiodogramVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn SignalspecperiodogramVector::scale(self : SignalspecperiodogramVector, s : Double) -> SignalspecperiodogramVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn SignalspecperiodogramVector::dot(self : SignalspecperiodogramVector, other : SignalspecperiodogramVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn SignalspecperiodogramVector::norm(self : SignalspecperiodogramVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn SignalspecperiodogramVector::normalize(self : SignalspecperiodogramVector) -> SignalspecperiodogramVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn SignalspecperiodogramVector::dist(self : SignalspecperiodogramVector, other : SignalspecperiodogramVector) -> Double {
  self.sub(other).norm()
}

pub fn SignalspecperiodogramVector::to_string(self : SignalspecperiodogramVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn signal_spec_periodogram_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn signal_spec_periodogram_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn signal_spec_periodogram_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn signal_spec_periodogram_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn signal_spec_periodogram_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn signal_spec_periodogram_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn signal_spec_periodogram_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn signal_spec_periodogram_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn signal_spec_periodogram_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn signal_spec_periodogram_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn signal_spec_periodogram_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn signal_spec_periodogram_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn signal_spec_periodogram_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn signal_spec_periodogram_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn signal_spec_periodogram_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn signal_spec_periodogram_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn signal_spec_periodogram_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn signal_spec_periodogram_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn signal_spec_periodogram_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn signal_spec_periodogram_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn signal_spec_periodogram_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn signal_spec_periodogram_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn signal_spec_periodogram_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn signal_spec_periodogram_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn signal_spec_periodogram_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn signal_spec_periodogram_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn signal_spec_periodogram_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn signal_spec_periodogram_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn signal_spec_periodogram_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct SignalspecperiodogramFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_spec_periodogram_frame_make(size : Int) -> SignalspecperiodogramFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_spec_periodogram_frame_len(s : SignalspecperiodogramFrame) -> Int { s.size }

pub fn signal_spec_periodogram_frame_get(s : SignalspecperiodogramFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_spec_periodogram_frame_set(s : SignalspecperiodogramFrame, i : Int, v : Double) -> SignalspecperiodogramFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_spec_periodogram_frame_sum(s : SignalspecperiodogramFrame) -> Double { @_common.sum(s.data) }

pub fn signal_spec_periodogram_frame_mean(s : SignalspecperiodogramFrame) -> Double { @_common.mean(s.data) }

pub fn signal_spec_periodogram_frame_scale(s : SignalspecperiodogramFrame, f : Double) -> SignalspecperiodogramFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_spec_periodogram_frame_add(a : SignalspecperiodogramFrame, b : SignalspecperiodogramFrame) -> SignalspecperiodogramFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_spec_periodogram_frame_copy(s : SignalspecperiodogramFrame) -> SignalspecperiodogramFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_spec_periodogram_frame_fill(s : SignalspecperiodogramFrame, v : Double) -> SignalspecperiodogramFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_spec_periodogram_frame_min(s : SignalspecperiodogramFrame) -> Double { @_common.min(s.data) }

pub fn signal_spec_periodogram_frame_max(s : SignalspecperiodogramFrame) -> Double { @_common.max(s.data) }

pub fn signal_spec_periodogram_frame_to_string(s : SignalspecperiodogramFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalspecperiodogramTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_spec_periodogram_table_make(size : Int) -> SignalspecperiodogramTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_spec_periodogram_table_len(s : SignalspecperiodogramTable) -> Int { s.size }

pub fn signal_spec_periodogram_table_get(s : SignalspecperiodogramTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_spec_periodogram_table_set(s : SignalspecperiodogramTable, i : Int, v : Double) -> SignalspecperiodogramTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_spec_periodogram_table_sum(s : SignalspecperiodogramTable) -> Double { @_common.sum(s.data) }

pub fn signal_spec_periodogram_table_mean(s : SignalspecperiodogramTable) -> Double { @_common.mean(s.data) }

pub fn signal_spec_periodogram_table_scale(s : SignalspecperiodogramTable, f : Double) -> SignalspecperiodogramTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_spec_periodogram_table_add(a : SignalspecperiodogramTable, b : SignalspecperiodogramTable) -> SignalspecperiodogramTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_spec_periodogram_table_copy(s : SignalspecperiodogramTable) -> SignalspecperiodogramTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_spec_periodogram_table_fill(s : SignalspecperiodogramTable, v : Double) -> SignalspecperiodogramTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_spec_periodogram_table_min(s : SignalspecperiodogramTable) -> Double { @_common.min(s.data) }

pub fn signal_spec_periodogram_table_max(s : SignalspecperiodogramTable) -> Double { @_common.max(s.data) }

pub fn signal_spec_periodogram_table_to_string(s : SignalspecperiodogramTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalspecperiodogramGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_spec_periodogram_graphn_make(size : Int) -> SignalspecperiodogramGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_spec_periodogram_graphn_len(s : SignalspecperiodogramGraphN) -> Int { s.size }

pub fn signal_spec_periodogram_graphn_get(s : SignalspecperiodogramGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_spec_periodogram_graphn_set(s : SignalspecperiodogramGraphN, i : Int, v : Double) -> SignalspecperiodogramGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_spec_periodogram_graphn_sum(s : SignalspecperiodogramGraphN) -> Double { @_common.sum(s.data) }

pub fn signal_spec_periodogram_graphn_mean(s : SignalspecperiodogramGraphN) -> Double { @_common.mean(s.data) }

pub fn signal_spec_periodogram_graphn_scale(s : SignalspecperiodogramGraphN, f : Double) -> SignalspecperiodogramGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_spec_periodogram_graphn_add(a : SignalspecperiodogramGraphN, b : SignalspecperiodogramGraphN) -> SignalspecperiodogramGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_spec_periodogram_graphn_copy(s : SignalspecperiodogramGraphN) -> SignalspecperiodogramGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_spec_periodogram_graphn_fill(s : SignalspecperiodogramGraphN, v : Double) -> SignalspecperiodogramGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_spec_periodogram_graphn_min(s : SignalspecperiodogramGraphN) -> Double { @_common.min(s.data) }

pub fn signal_spec_periodogram_graphn_max(s : SignalspecperiodogramGraphN) -> Double { @_common.max(s.data) }

pub fn signal_spec_periodogram_graphn_to_string(s : SignalspecperiodogramGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalspecperiodogramNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_spec_periodogram_node_make(size : Int) -> SignalspecperiodogramNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_spec_periodogram_node_len(s : SignalspecperiodogramNode) -> Int { s.size }

pub fn signal_spec_periodogram_node_get(s : SignalspecperiodogramNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_spec_periodogram_node_set(s : SignalspecperiodogramNode, i : Int, v : Double) -> SignalspecperiodogramNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_spec_periodogram_node_sum(s : SignalspecperiodogramNode) -> Double { @_common.sum(s.data) }

pub fn signal_spec_periodogram_node_mean(s : SignalspecperiodogramNode) -> Double { @_common.mean(s.data) }

pub fn signal_spec_periodogram_node_scale(s : SignalspecperiodogramNode, f : Double) -> SignalspecperiodogramNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_spec_periodogram_node_add(a : SignalspecperiodogramNode, b : SignalspecperiodogramNode) -> SignalspecperiodogramNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_spec_periodogram_node_copy(s : SignalspecperiodogramNode) -> SignalspecperiodogramNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_spec_periodogram_node_fill(s : SignalspecperiodogramNode, v : Double) -> SignalspecperiodogramNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_spec_periodogram_node_min(s : SignalspecperiodogramNode) -> Double { @_common.min(s.data) }

pub fn signal_spec_periodogram_node_max(s : SignalspecperiodogramNode) -> Double { @_common.max(s.data) }

pub fn signal_spec_periodogram_node_to_string(s : SignalspecperiodogramNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalspecperiodogramEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_spec_periodogram_edge_make(size : Int) -> SignalspecperiodogramEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_spec_periodogram_edge_len(s : SignalspecperiodogramEdge) -> Int { s.size }

pub fn signal_spec_periodogram_edge_get(s : SignalspecperiodogramEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_spec_periodogram_edge_set(s : SignalspecperiodogramEdge, i : Int, v : Double) -> SignalspecperiodogramEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_spec_periodogram_edge_sum(s : SignalspecperiodogramEdge) -> Double { @_common.sum(s.data) }

pub fn signal_spec_periodogram_edge_mean(s : SignalspecperiodogramEdge) -> Double { @_common.mean(s.data) }

pub fn signal_spec_periodogram_edge_scale(s : SignalspecperiodogramEdge, f : Double) -> SignalspecperiodogramEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_spec_periodogram_edge_add(a : SignalspecperiodogramEdge, b : SignalspecperiodogramEdge) -> SignalspecperiodogramEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_spec_periodogram_edge_copy(s : SignalspecperiodogramEdge) -> SignalspecperiodogramEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_spec_periodogram_edge_fill(s : SignalspecperiodogramEdge, v : Double) -> SignalspecperiodogramEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_spec_periodogram_edge_min(s : SignalspecperiodogramEdge) -> Double { @_common.min(s.data) }

pub fn signal_spec_periodogram_edge_max(s : SignalspecperiodogramEdge) -> Double { @_common.max(s.data) }

pub fn signal_spec_periodogram_edge_to_string(s : SignalspecperiodogramEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalspecperiodogramPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_spec_periodogram_path_make(size : Int) -> SignalspecperiodogramPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_spec_periodogram_path_len(s : SignalspecperiodogramPath) -> Int { s.size }

pub fn signal_spec_periodogram_path_get(s : SignalspecperiodogramPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_spec_periodogram_path_set(s : SignalspecperiodogramPath, i : Int, v : Double) -> SignalspecperiodogramPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_spec_periodogram_path_sum(s : SignalspecperiodogramPath) -> Double { @_common.sum(s.data) }

pub fn signal_spec_periodogram_path_mean(s : SignalspecperiodogramPath) -> Double { @_common.mean(s.data) }

pub fn signal_spec_periodogram_path_scale(s : SignalspecperiodogramPath, f : Double) -> SignalspecperiodogramPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_spec_periodogram_path_add(a : SignalspecperiodogramPath, b : SignalspecperiodogramPath) -> SignalspecperiodogramPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_spec_periodogram_path_copy(s : SignalspecperiodogramPath) -> SignalspecperiodogramPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_spec_periodogram_path_fill(s : SignalspecperiodogramPath, v : Double) -> SignalspecperiodogramPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_spec_periodogram_path_min(s : SignalspecperiodogramPath) -> Double { @_common.min(s.data) }

pub fn signal_spec_periodogram_path_max(s : SignalspecperiodogramPath) -> Double { @_common.max(s.data) }

pub fn signal_spec_periodogram_path_to_string(s : SignalspecperiodogramPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalspecperiodogramCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_spec_periodogram_cluster_make(size : Int) -> SignalspecperiodogramCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_spec_periodogram_cluster_len(s : SignalspecperiodogramCluster) -> Int { s.size }

pub fn signal_spec_periodogram_cluster_get(s : SignalspecperiodogramCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_spec_periodogram_cluster_set(s : SignalspecperiodogramCluster, i : Int, v : Double) -> SignalspecperiodogramCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_spec_periodogram_cluster_sum(s : SignalspecperiodogramCluster) -> Double { @_common.sum(s.data) }

pub fn signal_spec_periodogram_cluster_mean(s : SignalspecperiodogramCluster) -> Double { @_common.mean(s.data) }

pub fn signal_spec_periodogram_cluster_scale(s : SignalspecperiodogramCluster, f : Double) -> SignalspecperiodogramCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_spec_periodogram_cluster_add(a : SignalspecperiodogramCluster, b : SignalspecperiodogramCluster) -> SignalspecperiodogramCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_spec_periodogram_cluster_copy(s : SignalspecperiodogramCluster) -> SignalspecperiodogramCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_spec_periodogram_cluster_fill(s : SignalspecperiodogramCluster, v : Double) -> SignalspecperiodogramCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_spec_periodogram_cluster_min(s : SignalspecperiodogramCluster) -> Double { @_common.min(s.data) }

pub fn signal_spec_periodogram_cluster_max(s : SignalspecperiodogramCluster) -> Double { @_common.max(s.data) }

pub fn signal_spec_periodogram_cluster_to_string(s : SignalspecperiodogramCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalspecperiodogramModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_spec_periodogram_model_make(size : Int) -> SignalspecperiodogramModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_spec_periodogram_model_len(s : SignalspecperiodogramModel) -> Int { s.size }

pub fn signal_spec_periodogram_model_get(s : SignalspecperiodogramModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_spec_periodogram_model_set(s : SignalspecperiodogramModel, i : Int, v : Double) -> SignalspecperiodogramModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_spec_periodogram_model_sum(s : SignalspecperiodogramModel) -> Double { @_common.sum(s.data) }

pub fn signal_spec_periodogram_model_mean(s : SignalspecperiodogramModel) -> Double { @_common.mean(s.data) }

pub fn signal_spec_periodogram_model_scale(s : SignalspecperiodogramModel, f : Double) -> SignalspecperiodogramModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_spec_periodogram_model_add(a : SignalspecperiodogramModel, b : SignalspecperiodogramModel) -> SignalspecperiodogramModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_spec_periodogram_model_copy(s : SignalspecperiodogramModel) -> SignalspecperiodogramModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_spec_periodogram_model_fill(s : SignalspecperiodogramModel, v : Double) -> SignalspecperiodogramModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_spec_periodogram_model_min(s : SignalspecperiodogramModel) -> Double { @_common.min(s.data) }

pub fn signal_spec_periodogram_model_max(s : SignalspecperiodogramModel) -> Double { @_common.max(s.data) }

pub fn signal_spec_periodogram_model_to_string(s : SignalspecperiodogramModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalspecperiodogramLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_spec_periodogram_layer_make(size : Int) -> SignalspecperiodogramLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_spec_periodogram_layer_len(s : SignalspecperiodogramLayer) -> Int { s.size }

pub fn signal_spec_periodogram_layer_get(s : SignalspecperiodogramLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_spec_periodogram_layer_set(s : SignalspecperiodogramLayer, i : Int, v : Double) -> SignalspecperiodogramLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_spec_periodogram_layer_sum(s : SignalspecperiodogramLayer) -> Double { @_common.sum(s.data) }

pub fn signal_spec_periodogram_layer_mean(s : SignalspecperiodogramLayer) -> Double { @_common.mean(s.data) }

pub fn signal_spec_periodogram_layer_scale(s : SignalspecperiodogramLayer, f : Double) -> SignalspecperiodogramLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_spec_periodogram_layer_add(a : SignalspecperiodogramLayer, b : SignalspecperiodogramLayer) -> SignalspecperiodogramLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_spec_periodogram_layer_copy(s : SignalspecperiodogramLayer) -> SignalspecperiodogramLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_spec_periodogram_layer_fill(s : SignalspecperiodogramLayer, v : Double) -> SignalspecperiodogramLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_spec_periodogram_layer_min(s : SignalspecperiodogramLayer) -> Double { @_common.min(s.data) }

pub fn signal_spec_periodogram_layer_max(s : SignalspecperiodogramLayer) -> Double { @_common.max(s.data) }

pub fn signal_spec_periodogram_layer_to_string(s : SignalspecperiodogramLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalspecperiodogramBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_spec_periodogram_buffer_make(size : Int) -> SignalspecperiodogramBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_spec_periodogram_buffer_len(s : SignalspecperiodogramBuffer) -> Int { s.size }

pub fn signal_spec_periodogram_buffer_get(s : SignalspecperiodogramBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_spec_periodogram_buffer_set(s : SignalspecperiodogramBuffer, i : Int, v : Double) -> SignalspecperiodogramBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_spec_periodogram_buffer_sum(s : SignalspecperiodogramBuffer) -> Double { @_common.sum(s.data) }

pub fn signal_spec_periodogram_buffer_mean(s : SignalspecperiodogramBuffer) -> Double { @_common.mean(s.data) }

pub fn signal_spec_periodogram_buffer_scale(s : SignalspecperiodogramBuffer, f : Double) -> SignalspecperiodogramBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_spec_periodogram_buffer_add(a : SignalspecperiodogramBuffer, b : SignalspecperiodogramBuffer) -> SignalspecperiodogramBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_spec_periodogram_buffer_copy(s : SignalspecperiodogramBuffer) -> SignalspecperiodogramBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_spec_periodogram_buffer_fill(s : SignalspecperiodogramBuffer, v : Double) -> SignalspecperiodogramBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_spec_periodogram_buffer_min(s : SignalspecperiodogramBuffer) -> Double { @_common.min(s.data) }

pub fn signal_spec_periodogram_buffer_max(s : SignalspecperiodogramBuffer) -> Double { @_common.max(s.data) }

pub fn signal_spec_periodogram_buffer_to_string(s : SignalspecperiodogramBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalspecperiodogramCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_spec_periodogram_cursor_make(size : Int) -> SignalspecperiodogramCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_spec_periodogram_cursor_len(s : SignalspecperiodogramCursor) -> Int { s.size }

pub fn signal_spec_periodogram_cursor_get(s : SignalspecperiodogramCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_spec_periodogram_cursor_set(s : SignalspecperiodogramCursor, i : Int, v : Double) -> SignalspecperiodogramCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_spec_periodogram_cursor_sum(s : SignalspecperiodogramCursor) -> Double { @_common.sum(s.data) }

pub fn signal_spec_periodogram_cursor_mean(s : SignalspecperiodogramCursor) -> Double { @_common.mean(s.data) }

pub fn signal_spec_periodogram_cursor_scale(s : SignalspecperiodogramCursor, f : Double) -> SignalspecperiodogramCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_spec_periodogram_cursor_add(a : SignalspecperiodogramCursor, b : SignalspecperiodogramCursor) -> SignalspecperiodogramCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_spec_periodogram_cursor_copy(s : SignalspecperiodogramCursor) -> SignalspecperiodogramCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_spec_periodogram_cursor_fill(s : SignalspecperiodogramCursor, v : Double) -> SignalspecperiodogramCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_spec_periodogram_cursor_min(s : SignalspecperiodogramCursor) -> Double { @_common.min(s.data) }

pub fn signal_spec_periodogram_cursor_max(s : SignalspecperiodogramCursor) -> Double { @_common.max(s.data) }

pub fn signal_spec_periodogram_cursor_to_string(s : SignalspecperiodogramCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalspecperiodogramView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_spec_periodogram_view_make(size : Int) -> SignalspecperiodogramView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_spec_periodogram_view_len(s : SignalspecperiodogramView) -> Int { s.size }

pub fn signal_spec_periodogram_view_get(s : SignalspecperiodogramView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_spec_periodogram_view_set(s : SignalspecperiodogramView, i : Int, v : Double) -> SignalspecperiodogramView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_spec_periodogram_view_sum(s : SignalspecperiodogramView) -> Double { @_common.sum(s.data) }

pub fn signal_spec_periodogram_view_mean(s : SignalspecperiodogramView) -> Double { @_common.mean(s.data) }

pub fn signal_spec_periodogram_view_scale(s : SignalspecperiodogramView, f : Double) -> SignalspecperiodogramView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_spec_periodogram_view_add(a : SignalspecperiodogramView, b : SignalspecperiodogramView) -> SignalspecperiodogramView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_spec_periodogram_view_copy(s : SignalspecperiodogramView) -> SignalspecperiodogramView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_spec_periodogram_view_fill(s : SignalspecperiodogramView, v : Double) -> SignalspecperiodogramView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_spec_periodogram_view_min(s : SignalspecperiodogramView) -> Double { @_common.min(s.data) }

pub fn signal_spec_periodogram_view_max(s : SignalspecperiodogramView) -> Double { @_common.max(s.data) }

pub fn signal_spec_periodogram_view_to_string(s : SignalspecperiodogramView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalspecperiodogramRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_spec_periodogram_range_make(size : Int) -> SignalspecperiodogramRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_spec_periodogram_range_len(s : SignalspecperiodogramRange) -> Int { s.size }

pub fn signal_spec_periodogram_range_get(s : SignalspecperiodogramRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_spec_periodogram_range_set(s : SignalspecperiodogramRange, i : Int, v : Double) -> SignalspecperiodogramRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_spec_periodogram_range_sum(s : SignalspecperiodogramRange) -> Double { @_common.sum(s.data) }

pub fn signal_spec_periodogram_range_mean(s : SignalspecperiodogramRange) -> Double { @_common.mean(s.data) }

pub fn signal_spec_periodogram_range_scale(s : SignalspecperiodogramRange, f : Double) -> SignalspecperiodogramRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_spec_periodogram_range_add(a : SignalspecperiodogramRange, b : SignalspecperiodogramRange) -> SignalspecperiodogramRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_spec_periodogram_range_copy(s : SignalspecperiodogramRange) -> SignalspecperiodogramRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_spec_periodogram_range_fill(s : SignalspecperiodogramRange, v : Double) -> SignalspecperiodogramRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_spec_periodogram_range_min(s : SignalspecperiodogramRange) -> Double { @_common.min(s.data) }

pub fn signal_spec_periodogram_range_max(s : SignalspecperiodogramRange) -> Double { @_common.max(s.data) }

pub fn signal_spec_periodogram_range_to_string(s : SignalspecperiodogramRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalspecperiodogramSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_spec_periodogram_slice_make(size : Int) -> SignalspecperiodogramSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_spec_periodogram_slice_len(s : SignalspecperiodogramSlice) -> Int { s.size }

pub fn signal_spec_periodogram_slice_get(s : SignalspecperiodogramSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_spec_periodogram_slice_set(s : SignalspecperiodogramSlice, i : Int, v : Double) -> SignalspecperiodogramSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_spec_periodogram_slice_sum(s : SignalspecperiodogramSlice) -> Double { @_common.sum(s.data) }

pub fn signal_spec_periodogram_slice_mean(s : SignalspecperiodogramSlice) -> Double { @_common.mean(s.data) }

pub fn signal_spec_periodogram_slice_scale(s : SignalspecperiodogramSlice, f : Double) -> SignalspecperiodogramSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_spec_periodogram_slice_add(a : SignalspecperiodogramSlice, b : SignalspecperiodogramSlice) -> SignalspecperiodogramSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_spec_periodogram_slice_copy(s : SignalspecperiodogramSlice) -> SignalspecperiodogramSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_spec_periodogram_slice_fill(s : SignalspecperiodogramSlice, v : Double) -> SignalspecperiodogramSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_spec_periodogram_slice_min(s : SignalspecperiodogramSlice) -> Double { @_common.min(s.data) }

pub fn signal_spec_periodogram_slice_max(s : SignalspecperiodogramSlice) -> Double { @_common.max(s.data) }

pub fn signal_spec_periodogram_slice_to_string(s : SignalspecperiodogramSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

