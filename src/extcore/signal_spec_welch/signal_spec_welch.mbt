///===
/// extcore/signal_spec_welch

pub(all) struct SignalspecwelchPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn signal_spec_welch_make_point(x : Double, y : Double) -> SignalspecwelchPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn signal_spec_welch_make_point3(x : Double, y : Double, z : Double) -> SignalspecwelchPoint {
  { x, y, z, label: 0 }
}

pub fn SignalspecwelchPoint::x(self : SignalspecwelchPoint) -> Double { self.x }

pub fn SignalspecwelchPoint::y(self : SignalspecwelchPoint) -> Double { self.y }

pub fn SignalspecwelchPoint::z(self : SignalspecwelchPoint) -> Double { self.z }

pub fn SignalspecwelchPoint::label(self : SignalspecwelchPoint) -> Int { self.label }

pub fn SignalspecwelchPoint::dist(self : SignalspecwelchPoint, other : SignalspecwelchPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn SignalspecwelchPoint::add(self : SignalspecwelchPoint, other : SignalspecwelchPoint) -> SignalspecwelchPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn SignalspecwelchPoint::sub(self : SignalspecwelchPoint, other : SignalspecwelchPoint) -> SignalspecwelchPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn SignalspecwelchPoint::scale(self : SignalspecwelchPoint, s : Double) -> SignalspecwelchPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn SignalspecwelchPoint::dot(self : SignalspecwelchPoint, other : SignalspecwelchPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn SignalspecwelchPoint::cross(self : SignalspecwelchPoint, other : SignalspecwelchPoint) -> SignalspecwelchPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn SignalspecwelchPoint::norm(self : SignalspecwelchPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn SignalspecwelchPoint::normalize(self : SignalspecwelchPoint) -> SignalspecwelchPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn SignalspecwelchPoint::negate(self : SignalspecwelchPoint) -> SignalspecwelchPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn SignalspecwelchPoint::mid(self : SignalspecwelchPoint, other : SignalspecwelchPoint) -> SignalspecwelchPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn SignalspecwelchPoint::lerp(self : SignalspecwelchPoint, other : SignalspecwelchPoint, t : Double) -> SignalspecwelchPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn SignalspecwelchPoint::to_string(self : SignalspecwelchPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct SignalspecwelchSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn signal_spec_welch_make_series(vals : Array[Double], name : String) -> SignalspecwelchSeries {
  { vals, name, meta: 0 }
}

pub fn SignalspecwelchSeries::len(self : SignalspecwelchSeries) -> Int { self.vals.length() }

pub fn SignalspecwelchSeries::sum(self : SignalspecwelchSeries) -> Double { @_common.sum(self.vals) }

pub fn SignalspecwelchSeries::mean(self : SignalspecwelchSeries) -> Double { @_common.mean(self.vals) }

pub fn SignalspecwelchSeries::min(self : SignalspecwelchSeries) -> Double { @_common.min(self.vals) }

pub fn SignalspecwelchSeries::max(self : SignalspecwelchSeries) -> Double { @_common.max(self.vals) }

pub fn SignalspecwelchSeries::range(self : SignalspecwelchSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn SignalspecwelchSeries::variance(self : SignalspecwelchSeries) -> Double { @_common.variance(self.vals) }

pub fn SignalspecwelchSeries::std(self : SignalspecwelchSeries) -> Double { @_common.std(self.vals) }

pub fn SignalspecwelchSeries::median(self : SignalspecwelchSeries) -> Double { @_common.median(self.vals) }

pub fn SignalspecwelchSeries::scale(self : SignalspecwelchSeries, f : Double) -> SignalspecwelchSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn SignalspecwelchSeries::add(self : SignalspecwelchSeries, other : SignalspecwelchSeries) -> SignalspecwelchSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn SignalspecwelchSeries::sub(self : SignalspecwelchSeries, other : SignalspecwelchSeries) -> SignalspecwelchSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn SignalspecwelchSeries::normalize(self : SignalspecwelchSeries) -> SignalspecwelchSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn SignalspecwelchSeries::cumsum(self : SignalspecwelchSeries) -> SignalspecwelchSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn SignalspecwelchSeries::to_string(self : SignalspecwelchSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct SignalspecwelchMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn signal_spec_welch_make_matrix(rows : Int, cols : Int, val : Double) -> SignalspecwelchMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn signal_spec_welch_matrix_identity(n : Int) -> SignalspecwelchMatrix {
  let m = signal_spec_welch_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn SignalspecwelchMatrix::get(self : SignalspecwelchMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn SignalspecwelchMatrix::transpose(self : SignalspecwelchMatrix) -> SignalspecwelchMatrix {
  let result = signal_spec_welch_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn SignalspecwelchMatrix::add(self : SignalspecwelchMatrix, other : SignalspecwelchMatrix) -> SignalspecwelchMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = signal_spec_welch_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn SignalspecwelchMatrix::scale(self : SignalspecwelchMatrix, s : Double) -> SignalspecwelchMatrix {
  let result = signal_spec_welch_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn SignalspecwelchMatrix::multiply(self : SignalspecwelchMatrix, other : SignalspecwelchMatrix) -> SignalspecwelchMatrix {
  if self.cols != other.rows { return signal_spec_welch_make_matrix(self.rows, other.cols, 0.0) }
  let result = signal_spec_welch_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn SignalspecwelchMatrix::trace(self : SignalspecwelchMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn SignalspecwelchMatrix::det(self : SignalspecwelchMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn SignalspecwelchMatrix::norm(self : SignalspecwelchMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn SignalspecwelchMatrix::to_string(self : SignalspecwelchMatrix) -> String {
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

pub(all) struct SignalspecwelchVector {
  comps : Array[Double]
  dim : Int
}

pub fn signal_spec_welch_make_vector(comps : Array[Double]) -> SignalspecwelchVector {
  { comps, dim: comps.length() }
}

pub fn signal_spec_welch_vector_zero(dim : Int) -> SignalspecwelchVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn SignalspecwelchVector::add(self : SignalspecwelchVector, other : SignalspecwelchVector) -> SignalspecwelchVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn SignalspecwelchVector::sub(self : SignalspecwelchVector, other : SignalspecwelchVector) -> SignalspecwelchVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn SignalspecwelchVector::scale(self : SignalspecwelchVector, s : Double) -> SignalspecwelchVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn SignalspecwelchVector::dot(self : SignalspecwelchVector, other : SignalspecwelchVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn SignalspecwelchVector::norm(self : SignalspecwelchVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn SignalspecwelchVector::normalize(self : SignalspecwelchVector) -> SignalspecwelchVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn SignalspecwelchVector::dist(self : SignalspecwelchVector, other : SignalspecwelchVector) -> Double {
  self.sub(other).norm()
}

pub fn SignalspecwelchVector::to_string(self : SignalspecwelchVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn signal_spec_welch_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn signal_spec_welch_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn signal_spec_welch_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn signal_spec_welch_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn signal_spec_welch_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn signal_spec_welch_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn signal_spec_welch_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn signal_spec_welch_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn signal_spec_welch_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn signal_spec_welch_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn signal_spec_welch_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn signal_spec_welch_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn signal_spec_welch_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn signal_spec_welch_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn signal_spec_welch_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn signal_spec_welch_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn signal_spec_welch_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn signal_spec_welch_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn signal_spec_welch_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn signal_spec_welch_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn signal_spec_welch_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn signal_spec_welch_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn signal_spec_welch_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn signal_spec_welch_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn signal_spec_welch_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn signal_spec_welch_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn signal_spec_welch_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn signal_spec_welch_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn signal_spec_welch_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct SignalspecwelchFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_spec_welch_frame_make(size : Int) -> SignalspecwelchFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_spec_welch_frame_len(s : SignalspecwelchFrame) -> Int { s.size }

pub fn signal_spec_welch_frame_get(s : SignalspecwelchFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_spec_welch_frame_set(s : SignalspecwelchFrame, i : Int, v : Double) -> SignalspecwelchFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_spec_welch_frame_sum(s : SignalspecwelchFrame) -> Double { @_common.sum(s.data) }

pub fn signal_spec_welch_frame_mean(s : SignalspecwelchFrame) -> Double { @_common.mean(s.data) }

pub fn signal_spec_welch_frame_scale(s : SignalspecwelchFrame, f : Double) -> SignalspecwelchFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_spec_welch_frame_add(a : SignalspecwelchFrame, b : SignalspecwelchFrame) -> SignalspecwelchFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_spec_welch_frame_copy(s : SignalspecwelchFrame) -> SignalspecwelchFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_spec_welch_frame_fill(s : SignalspecwelchFrame, v : Double) -> SignalspecwelchFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_spec_welch_frame_min(s : SignalspecwelchFrame) -> Double { @_common.min(s.data) }

pub fn signal_spec_welch_frame_max(s : SignalspecwelchFrame) -> Double { @_common.max(s.data) }

pub fn signal_spec_welch_frame_to_string(s : SignalspecwelchFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalspecwelchTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_spec_welch_table_make(size : Int) -> SignalspecwelchTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_spec_welch_table_len(s : SignalspecwelchTable) -> Int { s.size }

pub fn signal_spec_welch_table_get(s : SignalspecwelchTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_spec_welch_table_set(s : SignalspecwelchTable, i : Int, v : Double) -> SignalspecwelchTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_spec_welch_table_sum(s : SignalspecwelchTable) -> Double { @_common.sum(s.data) }

pub fn signal_spec_welch_table_mean(s : SignalspecwelchTable) -> Double { @_common.mean(s.data) }

pub fn signal_spec_welch_table_scale(s : SignalspecwelchTable, f : Double) -> SignalspecwelchTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_spec_welch_table_add(a : SignalspecwelchTable, b : SignalspecwelchTable) -> SignalspecwelchTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_spec_welch_table_copy(s : SignalspecwelchTable) -> SignalspecwelchTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_spec_welch_table_fill(s : SignalspecwelchTable, v : Double) -> SignalspecwelchTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_spec_welch_table_min(s : SignalspecwelchTable) -> Double { @_common.min(s.data) }

pub fn signal_spec_welch_table_max(s : SignalspecwelchTable) -> Double { @_common.max(s.data) }

pub fn signal_spec_welch_table_to_string(s : SignalspecwelchTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalspecwelchGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_spec_welch_graphn_make(size : Int) -> SignalspecwelchGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_spec_welch_graphn_len(s : SignalspecwelchGraphN) -> Int { s.size }

pub fn signal_spec_welch_graphn_get(s : SignalspecwelchGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_spec_welch_graphn_set(s : SignalspecwelchGraphN, i : Int, v : Double) -> SignalspecwelchGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_spec_welch_graphn_sum(s : SignalspecwelchGraphN) -> Double { @_common.sum(s.data) }

pub fn signal_spec_welch_graphn_mean(s : SignalspecwelchGraphN) -> Double { @_common.mean(s.data) }

pub fn signal_spec_welch_graphn_scale(s : SignalspecwelchGraphN, f : Double) -> SignalspecwelchGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_spec_welch_graphn_add(a : SignalspecwelchGraphN, b : SignalspecwelchGraphN) -> SignalspecwelchGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_spec_welch_graphn_copy(s : SignalspecwelchGraphN) -> SignalspecwelchGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_spec_welch_graphn_fill(s : SignalspecwelchGraphN, v : Double) -> SignalspecwelchGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_spec_welch_graphn_min(s : SignalspecwelchGraphN) -> Double { @_common.min(s.data) }

pub fn signal_spec_welch_graphn_max(s : SignalspecwelchGraphN) -> Double { @_common.max(s.data) }

pub fn signal_spec_welch_graphn_to_string(s : SignalspecwelchGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalspecwelchNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_spec_welch_node_make(size : Int) -> SignalspecwelchNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_spec_welch_node_len(s : SignalspecwelchNode) -> Int { s.size }

pub fn signal_spec_welch_node_get(s : SignalspecwelchNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_spec_welch_node_set(s : SignalspecwelchNode, i : Int, v : Double) -> SignalspecwelchNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_spec_welch_node_sum(s : SignalspecwelchNode) -> Double { @_common.sum(s.data) }

pub fn signal_spec_welch_node_mean(s : SignalspecwelchNode) -> Double { @_common.mean(s.data) }

pub fn signal_spec_welch_node_scale(s : SignalspecwelchNode, f : Double) -> SignalspecwelchNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_spec_welch_node_add(a : SignalspecwelchNode, b : SignalspecwelchNode) -> SignalspecwelchNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_spec_welch_node_copy(s : SignalspecwelchNode) -> SignalspecwelchNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_spec_welch_node_fill(s : SignalspecwelchNode, v : Double) -> SignalspecwelchNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_spec_welch_node_min(s : SignalspecwelchNode) -> Double { @_common.min(s.data) }

pub fn signal_spec_welch_node_max(s : SignalspecwelchNode) -> Double { @_common.max(s.data) }

pub fn signal_spec_welch_node_to_string(s : SignalspecwelchNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalspecwelchEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_spec_welch_edge_make(size : Int) -> SignalspecwelchEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_spec_welch_edge_len(s : SignalspecwelchEdge) -> Int { s.size }

pub fn signal_spec_welch_edge_get(s : SignalspecwelchEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_spec_welch_edge_set(s : SignalspecwelchEdge, i : Int, v : Double) -> SignalspecwelchEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_spec_welch_edge_sum(s : SignalspecwelchEdge) -> Double { @_common.sum(s.data) }

pub fn signal_spec_welch_edge_mean(s : SignalspecwelchEdge) -> Double { @_common.mean(s.data) }

pub fn signal_spec_welch_edge_scale(s : SignalspecwelchEdge, f : Double) -> SignalspecwelchEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_spec_welch_edge_add(a : SignalspecwelchEdge, b : SignalspecwelchEdge) -> SignalspecwelchEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_spec_welch_edge_copy(s : SignalspecwelchEdge) -> SignalspecwelchEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_spec_welch_edge_fill(s : SignalspecwelchEdge, v : Double) -> SignalspecwelchEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_spec_welch_edge_min(s : SignalspecwelchEdge) -> Double { @_common.min(s.data) }

pub fn signal_spec_welch_edge_max(s : SignalspecwelchEdge) -> Double { @_common.max(s.data) }

pub fn signal_spec_welch_edge_to_string(s : SignalspecwelchEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalspecwelchPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_spec_welch_path_make(size : Int) -> SignalspecwelchPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_spec_welch_path_len(s : SignalspecwelchPath) -> Int { s.size }

pub fn signal_spec_welch_path_get(s : SignalspecwelchPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_spec_welch_path_set(s : SignalspecwelchPath, i : Int, v : Double) -> SignalspecwelchPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_spec_welch_path_sum(s : SignalspecwelchPath) -> Double { @_common.sum(s.data) }

pub fn signal_spec_welch_path_mean(s : SignalspecwelchPath) -> Double { @_common.mean(s.data) }

pub fn signal_spec_welch_path_scale(s : SignalspecwelchPath, f : Double) -> SignalspecwelchPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_spec_welch_path_add(a : SignalspecwelchPath, b : SignalspecwelchPath) -> SignalspecwelchPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_spec_welch_path_copy(s : SignalspecwelchPath) -> SignalspecwelchPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_spec_welch_path_fill(s : SignalspecwelchPath, v : Double) -> SignalspecwelchPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_spec_welch_path_min(s : SignalspecwelchPath) -> Double { @_common.min(s.data) }

pub fn signal_spec_welch_path_max(s : SignalspecwelchPath) -> Double { @_common.max(s.data) }

pub fn signal_spec_welch_path_to_string(s : SignalspecwelchPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalspecwelchCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_spec_welch_cluster_make(size : Int) -> SignalspecwelchCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_spec_welch_cluster_len(s : SignalspecwelchCluster) -> Int { s.size }

pub fn signal_spec_welch_cluster_get(s : SignalspecwelchCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_spec_welch_cluster_set(s : SignalspecwelchCluster, i : Int, v : Double) -> SignalspecwelchCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_spec_welch_cluster_sum(s : SignalspecwelchCluster) -> Double { @_common.sum(s.data) }

pub fn signal_spec_welch_cluster_mean(s : SignalspecwelchCluster) -> Double { @_common.mean(s.data) }

pub fn signal_spec_welch_cluster_scale(s : SignalspecwelchCluster, f : Double) -> SignalspecwelchCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_spec_welch_cluster_add(a : SignalspecwelchCluster, b : SignalspecwelchCluster) -> SignalspecwelchCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_spec_welch_cluster_copy(s : SignalspecwelchCluster) -> SignalspecwelchCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_spec_welch_cluster_fill(s : SignalspecwelchCluster, v : Double) -> SignalspecwelchCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_spec_welch_cluster_min(s : SignalspecwelchCluster) -> Double { @_common.min(s.data) }

pub fn signal_spec_welch_cluster_max(s : SignalspecwelchCluster) -> Double { @_common.max(s.data) }

pub fn signal_spec_welch_cluster_to_string(s : SignalspecwelchCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalspecwelchModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_spec_welch_model_make(size : Int) -> SignalspecwelchModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_spec_welch_model_len(s : SignalspecwelchModel) -> Int { s.size }

pub fn signal_spec_welch_model_get(s : SignalspecwelchModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_spec_welch_model_set(s : SignalspecwelchModel, i : Int, v : Double) -> SignalspecwelchModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_spec_welch_model_sum(s : SignalspecwelchModel) -> Double { @_common.sum(s.data) }

pub fn signal_spec_welch_model_mean(s : SignalspecwelchModel) -> Double { @_common.mean(s.data) }

pub fn signal_spec_welch_model_scale(s : SignalspecwelchModel, f : Double) -> SignalspecwelchModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_spec_welch_model_add(a : SignalspecwelchModel, b : SignalspecwelchModel) -> SignalspecwelchModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_spec_welch_model_copy(s : SignalspecwelchModel) -> SignalspecwelchModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_spec_welch_model_fill(s : SignalspecwelchModel, v : Double) -> SignalspecwelchModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_spec_welch_model_min(s : SignalspecwelchModel) -> Double { @_common.min(s.data) }

pub fn signal_spec_welch_model_max(s : SignalspecwelchModel) -> Double { @_common.max(s.data) }

pub fn signal_spec_welch_model_to_string(s : SignalspecwelchModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalspecwelchLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_spec_welch_layer_make(size : Int) -> SignalspecwelchLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_spec_welch_layer_len(s : SignalspecwelchLayer) -> Int { s.size }

pub fn signal_spec_welch_layer_get(s : SignalspecwelchLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_spec_welch_layer_set(s : SignalspecwelchLayer, i : Int, v : Double) -> SignalspecwelchLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_spec_welch_layer_sum(s : SignalspecwelchLayer) -> Double { @_common.sum(s.data) }

pub fn signal_spec_welch_layer_mean(s : SignalspecwelchLayer) -> Double { @_common.mean(s.data) }

pub fn signal_spec_welch_layer_scale(s : SignalspecwelchLayer, f : Double) -> SignalspecwelchLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_spec_welch_layer_add(a : SignalspecwelchLayer, b : SignalspecwelchLayer) -> SignalspecwelchLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_spec_welch_layer_copy(s : SignalspecwelchLayer) -> SignalspecwelchLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_spec_welch_layer_fill(s : SignalspecwelchLayer, v : Double) -> SignalspecwelchLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_spec_welch_layer_min(s : SignalspecwelchLayer) -> Double { @_common.min(s.data) }

pub fn signal_spec_welch_layer_max(s : SignalspecwelchLayer) -> Double { @_common.max(s.data) }

pub fn signal_spec_welch_layer_to_string(s : SignalspecwelchLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalspecwelchBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_spec_welch_buffer_make(size : Int) -> SignalspecwelchBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_spec_welch_buffer_len(s : SignalspecwelchBuffer) -> Int { s.size }

pub fn signal_spec_welch_buffer_get(s : SignalspecwelchBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_spec_welch_buffer_set(s : SignalspecwelchBuffer, i : Int, v : Double) -> SignalspecwelchBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_spec_welch_buffer_sum(s : SignalspecwelchBuffer) -> Double { @_common.sum(s.data) }

pub fn signal_spec_welch_buffer_mean(s : SignalspecwelchBuffer) -> Double { @_common.mean(s.data) }

pub fn signal_spec_welch_buffer_scale(s : SignalspecwelchBuffer, f : Double) -> SignalspecwelchBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_spec_welch_buffer_add(a : SignalspecwelchBuffer, b : SignalspecwelchBuffer) -> SignalspecwelchBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_spec_welch_buffer_copy(s : SignalspecwelchBuffer) -> SignalspecwelchBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_spec_welch_buffer_fill(s : SignalspecwelchBuffer, v : Double) -> SignalspecwelchBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_spec_welch_buffer_min(s : SignalspecwelchBuffer) -> Double { @_common.min(s.data) }

pub fn signal_spec_welch_buffer_max(s : SignalspecwelchBuffer) -> Double { @_common.max(s.data) }

pub fn signal_spec_welch_buffer_to_string(s : SignalspecwelchBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalspecwelchCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_spec_welch_cursor_make(size : Int) -> SignalspecwelchCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_spec_welch_cursor_len(s : SignalspecwelchCursor) -> Int { s.size }

pub fn signal_spec_welch_cursor_get(s : SignalspecwelchCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_spec_welch_cursor_set(s : SignalspecwelchCursor, i : Int, v : Double) -> SignalspecwelchCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_spec_welch_cursor_sum(s : SignalspecwelchCursor) -> Double { @_common.sum(s.data) }

pub fn signal_spec_welch_cursor_mean(s : SignalspecwelchCursor) -> Double { @_common.mean(s.data) }

pub fn signal_spec_welch_cursor_scale(s : SignalspecwelchCursor, f : Double) -> SignalspecwelchCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_spec_welch_cursor_add(a : SignalspecwelchCursor, b : SignalspecwelchCursor) -> SignalspecwelchCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_spec_welch_cursor_copy(s : SignalspecwelchCursor) -> SignalspecwelchCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_spec_welch_cursor_fill(s : SignalspecwelchCursor, v : Double) -> SignalspecwelchCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_spec_welch_cursor_min(s : SignalspecwelchCursor) -> Double { @_common.min(s.data) }

pub fn signal_spec_welch_cursor_max(s : SignalspecwelchCursor) -> Double { @_common.max(s.data) }

pub fn signal_spec_welch_cursor_to_string(s : SignalspecwelchCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalspecwelchView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_spec_welch_view_make(size : Int) -> SignalspecwelchView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_spec_welch_view_len(s : SignalspecwelchView) -> Int { s.size }

pub fn signal_spec_welch_view_get(s : SignalspecwelchView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_spec_welch_view_set(s : SignalspecwelchView, i : Int, v : Double) -> SignalspecwelchView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_spec_welch_view_sum(s : SignalspecwelchView) -> Double { @_common.sum(s.data) }

pub fn signal_spec_welch_view_mean(s : SignalspecwelchView) -> Double { @_common.mean(s.data) }

pub fn signal_spec_welch_view_scale(s : SignalspecwelchView, f : Double) -> SignalspecwelchView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_spec_welch_view_add(a : SignalspecwelchView, b : SignalspecwelchView) -> SignalspecwelchView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_spec_welch_view_copy(s : SignalspecwelchView) -> SignalspecwelchView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_spec_welch_view_fill(s : SignalspecwelchView, v : Double) -> SignalspecwelchView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_spec_welch_view_min(s : SignalspecwelchView) -> Double { @_common.min(s.data) }

pub fn signal_spec_welch_view_max(s : SignalspecwelchView) -> Double { @_common.max(s.data) }

pub fn signal_spec_welch_view_to_string(s : SignalspecwelchView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalspecwelchRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_spec_welch_range_make(size : Int) -> SignalspecwelchRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_spec_welch_range_len(s : SignalspecwelchRange) -> Int { s.size }

pub fn signal_spec_welch_range_get(s : SignalspecwelchRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_spec_welch_range_set(s : SignalspecwelchRange, i : Int, v : Double) -> SignalspecwelchRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_spec_welch_range_sum(s : SignalspecwelchRange) -> Double { @_common.sum(s.data) }

pub fn signal_spec_welch_range_mean(s : SignalspecwelchRange) -> Double { @_common.mean(s.data) }

pub fn signal_spec_welch_range_scale(s : SignalspecwelchRange, f : Double) -> SignalspecwelchRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_spec_welch_range_add(a : SignalspecwelchRange, b : SignalspecwelchRange) -> SignalspecwelchRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_spec_welch_range_copy(s : SignalspecwelchRange) -> SignalspecwelchRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_spec_welch_range_fill(s : SignalspecwelchRange, v : Double) -> SignalspecwelchRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_spec_welch_range_min(s : SignalspecwelchRange) -> Double { @_common.min(s.data) }

pub fn signal_spec_welch_range_max(s : SignalspecwelchRange) -> Double { @_common.max(s.data) }

pub fn signal_spec_welch_range_to_string(s : SignalspecwelchRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalspecwelchSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_spec_welch_slice_make(size : Int) -> SignalspecwelchSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_spec_welch_slice_len(s : SignalspecwelchSlice) -> Int { s.size }

pub fn signal_spec_welch_slice_get(s : SignalspecwelchSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_spec_welch_slice_set(s : SignalspecwelchSlice, i : Int, v : Double) -> SignalspecwelchSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_spec_welch_slice_sum(s : SignalspecwelchSlice) -> Double { @_common.sum(s.data) }

pub fn signal_spec_welch_slice_mean(s : SignalspecwelchSlice) -> Double { @_common.mean(s.data) }

pub fn signal_spec_welch_slice_scale(s : SignalspecwelchSlice, f : Double) -> SignalspecwelchSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_spec_welch_slice_add(a : SignalspecwelchSlice, b : SignalspecwelchSlice) -> SignalspecwelchSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_spec_welch_slice_copy(s : SignalspecwelchSlice) -> SignalspecwelchSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_spec_welch_slice_fill(s : SignalspecwelchSlice, v : Double) -> SignalspecwelchSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_spec_welch_slice_min(s : SignalspecwelchSlice) -> Double { @_common.min(s.data) }

pub fn signal_spec_welch_slice_max(s : SignalspecwelchSlice) -> Double { @_common.max(s.data) }

pub fn signal_spec_welch_slice_to_string(s : SignalspecwelchSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

