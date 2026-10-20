///===
/// extcore/signal_filter_fir

pub(all) struct SignalfilterfirPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn signal_filter_fir_make_point(x : Double, y : Double) -> SignalfilterfirPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn signal_filter_fir_make_point3(x : Double, y : Double, z : Double) -> SignalfilterfirPoint {
  { x, y, z, label: 0 }
}

pub fn SignalfilterfirPoint::x(self : SignalfilterfirPoint) -> Double { self.x }

pub fn SignalfilterfirPoint::y(self : SignalfilterfirPoint) -> Double { self.y }

pub fn SignalfilterfirPoint::z(self : SignalfilterfirPoint) -> Double { self.z }

pub fn SignalfilterfirPoint::label(self : SignalfilterfirPoint) -> Int { self.label }

pub fn SignalfilterfirPoint::dist(self : SignalfilterfirPoint, other : SignalfilterfirPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn SignalfilterfirPoint::add(self : SignalfilterfirPoint, other : SignalfilterfirPoint) -> SignalfilterfirPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn SignalfilterfirPoint::sub(self : SignalfilterfirPoint, other : SignalfilterfirPoint) -> SignalfilterfirPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn SignalfilterfirPoint::scale(self : SignalfilterfirPoint, s : Double) -> SignalfilterfirPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn SignalfilterfirPoint::dot(self : SignalfilterfirPoint, other : SignalfilterfirPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn SignalfilterfirPoint::cross(self : SignalfilterfirPoint, other : SignalfilterfirPoint) -> SignalfilterfirPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn SignalfilterfirPoint::norm(self : SignalfilterfirPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn SignalfilterfirPoint::normalize(self : SignalfilterfirPoint) -> SignalfilterfirPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn SignalfilterfirPoint::negate(self : SignalfilterfirPoint) -> SignalfilterfirPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn SignalfilterfirPoint::mid(self : SignalfilterfirPoint, other : SignalfilterfirPoint) -> SignalfilterfirPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn SignalfilterfirPoint::lerp(self : SignalfilterfirPoint, other : SignalfilterfirPoint, t : Double) -> SignalfilterfirPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn SignalfilterfirPoint::to_string(self : SignalfilterfirPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct SignalfilterfirSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn signal_filter_fir_make_series(vals : Array[Double], name : String) -> SignalfilterfirSeries {
  { vals, name, meta: 0 }
}

pub fn SignalfilterfirSeries::len(self : SignalfilterfirSeries) -> Int { self.vals.length() }

pub fn SignalfilterfirSeries::sum(self : SignalfilterfirSeries) -> Double { @_common.sum(self.vals) }

pub fn SignalfilterfirSeries::mean(self : SignalfilterfirSeries) -> Double { @_common.mean(self.vals) }

pub fn SignalfilterfirSeries::min(self : SignalfilterfirSeries) -> Double { @_common.min(self.vals) }

pub fn SignalfilterfirSeries::max(self : SignalfilterfirSeries) -> Double { @_common.max(self.vals) }

pub fn SignalfilterfirSeries::range(self : SignalfilterfirSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn SignalfilterfirSeries::variance(self : SignalfilterfirSeries) -> Double { @_common.variance(self.vals) }

pub fn SignalfilterfirSeries::std(self : SignalfilterfirSeries) -> Double { @_common.std(self.vals) }

pub fn SignalfilterfirSeries::median(self : SignalfilterfirSeries) -> Double { @_common.median(self.vals) }

pub fn SignalfilterfirSeries::scale(self : SignalfilterfirSeries, f : Double) -> SignalfilterfirSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn SignalfilterfirSeries::add(self : SignalfilterfirSeries, other : SignalfilterfirSeries) -> SignalfilterfirSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn SignalfilterfirSeries::sub(self : SignalfilterfirSeries, other : SignalfilterfirSeries) -> SignalfilterfirSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn SignalfilterfirSeries::normalize(self : SignalfilterfirSeries) -> SignalfilterfirSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn SignalfilterfirSeries::cumsum(self : SignalfilterfirSeries) -> SignalfilterfirSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn SignalfilterfirSeries::to_string(self : SignalfilterfirSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct SignalfilterfirMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn signal_filter_fir_make_matrix(rows : Int, cols : Int, val : Double) -> SignalfilterfirMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn signal_filter_fir_matrix_identity(n : Int) -> SignalfilterfirMatrix {
  let m = signal_filter_fir_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn SignalfilterfirMatrix::get(self : SignalfilterfirMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn SignalfilterfirMatrix::transpose(self : SignalfilterfirMatrix) -> SignalfilterfirMatrix {
  let result = signal_filter_fir_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn SignalfilterfirMatrix::add(self : SignalfilterfirMatrix, other : SignalfilterfirMatrix) -> SignalfilterfirMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = signal_filter_fir_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn SignalfilterfirMatrix::scale(self : SignalfilterfirMatrix, s : Double) -> SignalfilterfirMatrix {
  let result = signal_filter_fir_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn SignalfilterfirMatrix::multiply(self : SignalfilterfirMatrix, other : SignalfilterfirMatrix) -> SignalfilterfirMatrix {
  if self.cols != other.rows { return signal_filter_fir_make_matrix(self.rows, other.cols, 0.0) }
  let result = signal_filter_fir_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn SignalfilterfirMatrix::trace(self : SignalfilterfirMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn SignalfilterfirMatrix::det(self : SignalfilterfirMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn SignalfilterfirMatrix::norm(self : SignalfilterfirMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn SignalfilterfirMatrix::to_string(self : SignalfilterfirMatrix) -> String {
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

pub(all) struct SignalfilterfirVector {
  comps : Array[Double]
  dim : Int
}

pub fn signal_filter_fir_make_vector(comps : Array[Double]) -> SignalfilterfirVector {
  { comps, dim: comps.length() }
}

pub fn signal_filter_fir_vector_zero(dim : Int) -> SignalfilterfirVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn SignalfilterfirVector::add(self : SignalfilterfirVector, other : SignalfilterfirVector) -> SignalfilterfirVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn SignalfilterfirVector::sub(self : SignalfilterfirVector, other : SignalfilterfirVector) -> SignalfilterfirVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn SignalfilterfirVector::scale(self : SignalfilterfirVector, s : Double) -> SignalfilterfirVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn SignalfilterfirVector::dot(self : SignalfilterfirVector, other : SignalfilterfirVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn SignalfilterfirVector::norm(self : SignalfilterfirVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn SignalfilterfirVector::normalize(self : SignalfilterfirVector) -> SignalfilterfirVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn SignalfilterfirVector::dist(self : SignalfilterfirVector, other : SignalfilterfirVector) -> Double {
  self.sub(other).norm()
}

pub fn SignalfilterfirVector::to_string(self : SignalfilterfirVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn signal_filter_fir_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn signal_filter_fir_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn signal_filter_fir_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn signal_filter_fir_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn signal_filter_fir_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn signal_filter_fir_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn signal_filter_fir_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn signal_filter_fir_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn signal_filter_fir_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn signal_filter_fir_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn signal_filter_fir_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn signal_filter_fir_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn signal_filter_fir_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn signal_filter_fir_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn signal_filter_fir_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn signal_filter_fir_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn signal_filter_fir_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn signal_filter_fir_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn signal_filter_fir_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn signal_filter_fir_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn signal_filter_fir_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn signal_filter_fir_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn signal_filter_fir_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn signal_filter_fir_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn signal_filter_fir_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn signal_filter_fir_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn signal_filter_fir_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn signal_filter_fir_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn signal_filter_fir_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct SignalfilterfirFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_filter_fir_frame_make(size : Int) -> SignalfilterfirFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_filter_fir_frame_len(s : SignalfilterfirFrame) -> Int { s.size }

pub fn signal_filter_fir_frame_get(s : SignalfilterfirFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_filter_fir_frame_set(s : SignalfilterfirFrame, i : Int, v : Double) -> SignalfilterfirFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_filter_fir_frame_sum(s : SignalfilterfirFrame) -> Double { @_common.sum(s.data) }

pub fn signal_filter_fir_frame_mean(s : SignalfilterfirFrame) -> Double { @_common.mean(s.data) }

pub fn signal_filter_fir_frame_scale(s : SignalfilterfirFrame, f : Double) -> SignalfilterfirFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_filter_fir_frame_add(a : SignalfilterfirFrame, b : SignalfilterfirFrame) -> SignalfilterfirFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_filter_fir_frame_copy(s : SignalfilterfirFrame) -> SignalfilterfirFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_filter_fir_frame_fill(s : SignalfilterfirFrame, v : Double) -> SignalfilterfirFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_filter_fir_frame_min(s : SignalfilterfirFrame) -> Double { @_common.min(s.data) }

pub fn signal_filter_fir_frame_max(s : SignalfilterfirFrame) -> Double { @_common.max(s.data) }

pub fn signal_filter_fir_frame_to_string(s : SignalfilterfirFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalfilterfirTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_filter_fir_table_make(size : Int) -> SignalfilterfirTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_filter_fir_table_len(s : SignalfilterfirTable) -> Int { s.size }

pub fn signal_filter_fir_table_get(s : SignalfilterfirTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_filter_fir_table_set(s : SignalfilterfirTable, i : Int, v : Double) -> SignalfilterfirTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_filter_fir_table_sum(s : SignalfilterfirTable) -> Double { @_common.sum(s.data) }

pub fn signal_filter_fir_table_mean(s : SignalfilterfirTable) -> Double { @_common.mean(s.data) }

pub fn signal_filter_fir_table_scale(s : SignalfilterfirTable, f : Double) -> SignalfilterfirTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_filter_fir_table_add(a : SignalfilterfirTable, b : SignalfilterfirTable) -> SignalfilterfirTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_filter_fir_table_copy(s : SignalfilterfirTable) -> SignalfilterfirTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_filter_fir_table_fill(s : SignalfilterfirTable, v : Double) -> SignalfilterfirTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_filter_fir_table_min(s : SignalfilterfirTable) -> Double { @_common.min(s.data) }

pub fn signal_filter_fir_table_max(s : SignalfilterfirTable) -> Double { @_common.max(s.data) }

pub fn signal_filter_fir_table_to_string(s : SignalfilterfirTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalfilterfirGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_filter_fir_graphn_make(size : Int) -> SignalfilterfirGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_filter_fir_graphn_len(s : SignalfilterfirGraphN) -> Int { s.size }

pub fn signal_filter_fir_graphn_get(s : SignalfilterfirGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_filter_fir_graphn_set(s : SignalfilterfirGraphN, i : Int, v : Double) -> SignalfilterfirGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_filter_fir_graphn_sum(s : SignalfilterfirGraphN) -> Double { @_common.sum(s.data) }

pub fn signal_filter_fir_graphn_mean(s : SignalfilterfirGraphN) -> Double { @_common.mean(s.data) }

pub fn signal_filter_fir_graphn_scale(s : SignalfilterfirGraphN, f : Double) -> SignalfilterfirGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_filter_fir_graphn_add(a : SignalfilterfirGraphN, b : SignalfilterfirGraphN) -> SignalfilterfirGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_filter_fir_graphn_copy(s : SignalfilterfirGraphN) -> SignalfilterfirGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_filter_fir_graphn_fill(s : SignalfilterfirGraphN, v : Double) -> SignalfilterfirGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_filter_fir_graphn_min(s : SignalfilterfirGraphN) -> Double { @_common.min(s.data) }

pub fn signal_filter_fir_graphn_max(s : SignalfilterfirGraphN) -> Double { @_common.max(s.data) }

pub fn signal_filter_fir_graphn_to_string(s : SignalfilterfirGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalfilterfirNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_filter_fir_node_make(size : Int) -> SignalfilterfirNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_filter_fir_node_len(s : SignalfilterfirNode) -> Int { s.size }

pub fn signal_filter_fir_node_get(s : SignalfilterfirNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_filter_fir_node_set(s : SignalfilterfirNode, i : Int, v : Double) -> SignalfilterfirNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_filter_fir_node_sum(s : SignalfilterfirNode) -> Double { @_common.sum(s.data) }

pub fn signal_filter_fir_node_mean(s : SignalfilterfirNode) -> Double { @_common.mean(s.data) }

pub fn signal_filter_fir_node_scale(s : SignalfilterfirNode, f : Double) -> SignalfilterfirNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_filter_fir_node_add(a : SignalfilterfirNode, b : SignalfilterfirNode) -> SignalfilterfirNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_filter_fir_node_copy(s : SignalfilterfirNode) -> SignalfilterfirNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_filter_fir_node_fill(s : SignalfilterfirNode, v : Double) -> SignalfilterfirNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_filter_fir_node_min(s : SignalfilterfirNode) -> Double { @_common.min(s.data) }

pub fn signal_filter_fir_node_max(s : SignalfilterfirNode) -> Double { @_common.max(s.data) }

pub fn signal_filter_fir_node_to_string(s : SignalfilterfirNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalfilterfirEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_filter_fir_edge_make(size : Int) -> SignalfilterfirEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_filter_fir_edge_len(s : SignalfilterfirEdge) -> Int { s.size }

pub fn signal_filter_fir_edge_get(s : SignalfilterfirEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_filter_fir_edge_set(s : SignalfilterfirEdge, i : Int, v : Double) -> SignalfilterfirEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_filter_fir_edge_sum(s : SignalfilterfirEdge) -> Double { @_common.sum(s.data) }

pub fn signal_filter_fir_edge_mean(s : SignalfilterfirEdge) -> Double { @_common.mean(s.data) }

pub fn signal_filter_fir_edge_scale(s : SignalfilterfirEdge, f : Double) -> SignalfilterfirEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_filter_fir_edge_add(a : SignalfilterfirEdge, b : SignalfilterfirEdge) -> SignalfilterfirEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_filter_fir_edge_copy(s : SignalfilterfirEdge) -> SignalfilterfirEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_filter_fir_edge_fill(s : SignalfilterfirEdge, v : Double) -> SignalfilterfirEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_filter_fir_edge_min(s : SignalfilterfirEdge) -> Double { @_common.min(s.data) }

pub fn signal_filter_fir_edge_max(s : SignalfilterfirEdge) -> Double { @_common.max(s.data) }

pub fn signal_filter_fir_edge_to_string(s : SignalfilterfirEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalfilterfirPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_filter_fir_path_make(size : Int) -> SignalfilterfirPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_filter_fir_path_len(s : SignalfilterfirPath) -> Int { s.size }

pub fn signal_filter_fir_path_get(s : SignalfilterfirPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_filter_fir_path_set(s : SignalfilterfirPath, i : Int, v : Double) -> SignalfilterfirPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_filter_fir_path_sum(s : SignalfilterfirPath) -> Double { @_common.sum(s.data) }

pub fn signal_filter_fir_path_mean(s : SignalfilterfirPath) -> Double { @_common.mean(s.data) }

pub fn signal_filter_fir_path_scale(s : SignalfilterfirPath, f : Double) -> SignalfilterfirPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_filter_fir_path_add(a : SignalfilterfirPath, b : SignalfilterfirPath) -> SignalfilterfirPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_filter_fir_path_copy(s : SignalfilterfirPath) -> SignalfilterfirPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_filter_fir_path_fill(s : SignalfilterfirPath, v : Double) -> SignalfilterfirPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_filter_fir_path_min(s : SignalfilterfirPath) -> Double { @_common.min(s.data) }

pub fn signal_filter_fir_path_max(s : SignalfilterfirPath) -> Double { @_common.max(s.data) }

pub fn signal_filter_fir_path_to_string(s : SignalfilterfirPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalfilterfirCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_filter_fir_cluster_make(size : Int) -> SignalfilterfirCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_filter_fir_cluster_len(s : SignalfilterfirCluster) -> Int { s.size }

pub fn signal_filter_fir_cluster_get(s : SignalfilterfirCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_filter_fir_cluster_set(s : SignalfilterfirCluster, i : Int, v : Double) -> SignalfilterfirCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_filter_fir_cluster_sum(s : SignalfilterfirCluster) -> Double { @_common.sum(s.data) }

pub fn signal_filter_fir_cluster_mean(s : SignalfilterfirCluster) -> Double { @_common.mean(s.data) }

pub fn signal_filter_fir_cluster_scale(s : SignalfilterfirCluster, f : Double) -> SignalfilterfirCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_filter_fir_cluster_add(a : SignalfilterfirCluster, b : SignalfilterfirCluster) -> SignalfilterfirCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_filter_fir_cluster_copy(s : SignalfilterfirCluster) -> SignalfilterfirCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_filter_fir_cluster_fill(s : SignalfilterfirCluster, v : Double) -> SignalfilterfirCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_filter_fir_cluster_min(s : SignalfilterfirCluster) -> Double { @_common.min(s.data) }

pub fn signal_filter_fir_cluster_max(s : SignalfilterfirCluster) -> Double { @_common.max(s.data) }

pub fn signal_filter_fir_cluster_to_string(s : SignalfilterfirCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalfilterfirModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_filter_fir_model_make(size : Int) -> SignalfilterfirModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_filter_fir_model_len(s : SignalfilterfirModel) -> Int { s.size }

pub fn signal_filter_fir_model_get(s : SignalfilterfirModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_filter_fir_model_set(s : SignalfilterfirModel, i : Int, v : Double) -> SignalfilterfirModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_filter_fir_model_sum(s : SignalfilterfirModel) -> Double { @_common.sum(s.data) }

pub fn signal_filter_fir_model_mean(s : SignalfilterfirModel) -> Double { @_common.mean(s.data) }

pub fn signal_filter_fir_model_scale(s : SignalfilterfirModel, f : Double) -> SignalfilterfirModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_filter_fir_model_add(a : SignalfilterfirModel, b : SignalfilterfirModel) -> SignalfilterfirModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_filter_fir_model_copy(s : SignalfilterfirModel) -> SignalfilterfirModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_filter_fir_model_fill(s : SignalfilterfirModel, v : Double) -> SignalfilterfirModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_filter_fir_model_min(s : SignalfilterfirModel) -> Double { @_common.min(s.data) }

pub fn signal_filter_fir_model_max(s : SignalfilterfirModel) -> Double { @_common.max(s.data) }

pub fn signal_filter_fir_model_to_string(s : SignalfilterfirModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalfilterfirLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_filter_fir_layer_make(size : Int) -> SignalfilterfirLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_filter_fir_layer_len(s : SignalfilterfirLayer) -> Int { s.size }

pub fn signal_filter_fir_layer_get(s : SignalfilterfirLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_filter_fir_layer_set(s : SignalfilterfirLayer, i : Int, v : Double) -> SignalfilterfirLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_filter_fir_layer_sum(s : SignalfilterfirLayer) -> Double { @_common.sum(s.data) }

pub fn signal_filter_fir_layer_mean(s : SignalfilterfirLayer) -> Double { @_common.mean(s.data) }

pub fn signal_filter_fir_layer_scale(s : SignalfilterfirLayer, f : Double) -> SignalfilterfirLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_filter_fir_layer_add(a : SignalfilterfirLayer, b : SignalfilterfirLayer) -> SignalfilterfirLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_filter_fir_layer_copy(s : SignalfilterfirLayer) -> SignalfilterfirLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_filter_fir_layer_fill(s : SignalfilterfirLayer, v : Double) -> SignalfilterfirLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_filter_fir_layer_min(s : SignalfilterfirLayer) -> Double { @_common.min(s.data) }

pub fn signal_filter_fir_layer_max(s : SignalfilterfirLayer) -> Double { @_common.max(s.data) }

pub fn signal_filter_fir_layer_to_string(s : SignalfilterfirLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalfilterfirBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_filter_fir_buffer_make(size : Int) -> SignalfilterfirBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_filter_fir_buffer_len(s : SignalfilterfirBuffer) -> Int { s.size }

pub fn signal_filter_fir_buffer_get(s : SignalfilterfirBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_filter_fir_buffer_set(s : SignalfilterfirBuffer, i : Int, v : Double) -> SignalfilterfirBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_filter_fir_buffer_sum(s : SignalfilterfirBuffer) -> Double { @_common.sum(s.data) }

pub fn signal_filter_fir_buffer_mean(s : SignalfilterfirBuffer) -> Double { @_common.mean(s.data) }

pub fn signal_filter_fir_buffer_scale(s : SignalfilterfirBuffer, f : Double) -> SignalfilterfirBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_filter_fir_buffer_add(a : SignalfilterfirBuffer, b : SignalfilterfirBuffer) -> SignalfilterfirBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_filter_fir_buffer_copy(s : SignalfilterfirBuffer) -> SignalfilterfirBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_filter_fir_buffer_fill(s : SignalfilterfirBuffer, v : Double) -> SignalfilterfirBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_filter_fir_buffer_min(s : SignalfilterfirBuffer) -> Double { @_common.min(s.data) }

pub fn signal_filter_fir_buffer_max(s : SignalfilterfirBuffer) -> Double { @_common.max(s.data) }

pub fn signal_filter_fir_buffer_to_string(s : SignalfilterfirBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalfilterfirCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_filter_fir_cursor_make(size : Int) -> SignalfilterfirCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_filter_fir_cursor_len(s : SignalfilterfirCursor) -> Int { s.size }

pub fn signal_filter_fir_cursor_get(s : SignalfilterfirCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_filter_fir_cursor_set(s : SignalfilterfirCursor, i : Int, v : Double) -> SignalfilterfirCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_filter_fir_cursor_sum(s : SignalfilterfirCursor) -> Double { @_common.sum(s.data) }

pub fn signal_filter_fir_cursor_mean(s : SignalfilterfirCursor) -> Double { @_common.mean(s.data) }

pub fn signal_filter_fir_cursor_scale(s : SignalfilterfirCursor, f : Double) -> SignalfilterfirCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_filter_fir_cursor_add(a : SignalfilterfirCursor, b : SignalfilterfirCursor) -> SignalfilterfirCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_filter_fir_cursor_copy(s : SignalfilterfirCursor) -> SignalfilterfirCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_filter_fir_cursor_fill(s : SignalfilterfirCursor, v : Double) -> SignalfilterfirCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_filter_fir_cursor_min(s : SignalfilterfirCursor) -> Double { @_common.min(s.data) }

pub fn signal_filter_fir_cursor_max(s : SignalfilterfirCursor) -> Double { @_common.max(s.data) }

pub fn signal_filter_fir_cursor_to_string(s : SignalfilterfirCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalfilterfirView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_filter_fir_view_make(size : Int) -> SignalfilterfirView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_filter_fir_view_len(s : SignalfilterfirView) -> Int { s.size }

pub fn signal_filter_fir_view_get(s : SignalfilterfirView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_filter_fir_view_set(s : SignalfilterfirView, i : Int, v : Double) -> SignalfilterfirView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_filter_fir_view_sum(s : SignalfilterfirView) -> Double { @_common.sum(s.data) }

pub fn signal_filter_fir_view_mean(s : SignalfilterfirView) -> Double { @_common.mean(s.data) }

pub fn signal_filter_fir_view_scale(s : SignalfilterfirView, f : Double) -> SignalfilterfirView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_filter_fir_view_add(a : SignalfilterfirView, b : SignalfilterfirView) -> SignalfilterfirView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_filter_fir_view_copy(s : SignalfilterfirView) -> SignalfilterfirView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_filter_fir_view_fill(s : SignalfilterfirView, v : Double) -> SignalfilterfirView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_filter_fir_view_min(s : SignalfilterfirView) -> Double { @_common.min(s.data) }

pub fn signal_filter_fir_view_max(s : SignalfilterfirView) -> Double { @_common.max(s.data) }

pub fn signal_filter_fir_view_to_string(s : SignalfilterfirView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalfilterfirRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_filter_fir_range_make(size : Int) -> SignalfilterfirRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_filter_fir_range_len(s : SignalfilterfirRange) -> Int { s.size }

pub fn signal_filter_fir_range_get(s : SignalfilterfirRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_filter_fir_range_set(s : SignalfilterfirRange, i : Int, v : Double) -> SignalfilterfirRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_filter_fir_range_sum(s : SignalfilterfirRange) -> Double { @_common.sum(s.data) }

pub fn signal_filter_fir_range_mean(s : SignalfilterfirRange) -> Double { @_common.mean(s.data) }

pub fn signal_filter_fir_range_scale(s : SignalfilterfirRange, f : Double) -> SignalfilterfirRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_filter_fir_range_add(a : SignalfilterfirRange, b : SignalfilterfirRange) -> SignalfilterfirRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_filter_fir_range_copy(s : SignalfilterfirRange) -> SignalfilterfirRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_filter_fir_range_fill(s : SignalfilterfirRange, v : Double) -> SignalfilterfirRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_filter_fir_range_min(s : SignalfilterfirRange) -> Double { @_common.min(s.data) }

pub fn signal_filter_fir_range_max(s : SignalfilterfirRange) -> Double { @_common.max(s.data) }

pub fn signal_filter_fir_range_to_string(s : SignalfilterfirRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignalfilterfirSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_filter_fir_slice_make(size : Int) -> SignalfilterfirSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_filter_fir_slice_len(s : SignalfilterfirSlice) -> Int { s.size }

pub fn signal_filter_fir_slice_get(s : SignalfilterfirSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_filter_fir_slice_set(s : SignalfilterfirSlice, i : Int, v : Double) -> SignalfilterfirSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_filter_fir_slice_sum(s : SignalfilterfirSlice) -> Double { @_common.sum(s.data) }

pub fn signal_filter_fir_slice_mean(s : SignalfilterfirSlice) -> Double { @_common.mean(s.data) }

pub fn signal_filter_fir_slice_scale(s : SignalfilterfirSlice, f : Double) -> SignalfilterfirSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_filter_fir_slice_add(a : SignalfilterfirSlice, b : SignalfilterfirSlice) -> SignalfilterfirSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_filter_fir_slice_copy(s : SignalfilterfirSlice) -> SignalfilterfirSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_filter_fir_slice_fill(s : SignalfilterfirSlice, v : Double) -> SignalfilterfirSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_filter_fir_slice_min(s : SignalfilterfirSlice) -> Double { @_common.min(s.data) }

pub fn signal_filter_fir_slice_max(s : SignalfilterfirSlice) -> Double { @_common.max(s.data) }

pub fn signal_filter_fir_slice_to_string(s : SignalfilterfirSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

