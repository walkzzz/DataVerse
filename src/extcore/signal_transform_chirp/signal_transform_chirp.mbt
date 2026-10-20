///===
/// extcore/signal_transform_chirp

pub(all) struct SignaltransformchirpPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn signal_transform_chirp_make_point(x : Double, y : Double) -> SignaltransformchirpPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn signal_transform_chirp_make_point3(x : Double, y : Double, z : Double) -> SignaltransformchirpPoint {
  { x, y, z, label: 0 }
}

pub fn SignaltransformchirpPoint::x(self : SignaltransformchirpPoint) -> Double { self.x }

pub fn SignaltransformchirpPoint::y(self : SignaltransformchirpPoint) -> Double { self.y }

pub fn SignaltransformchirpPoint::z(self : SignaltransformchirpPoint) -> Double { self.z }

pub fn SignaltransformchirpPoint::label(self : SignaltransformchirpPoint) -> Int { self.label }

pub fn SignaltransformchirpPoint::dist(self : SignaltransformchirpPoint, other : SignaltransformchirpPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn SignaltransformchirpPoint::add(self : SignaltransformchirpPoint, other : SignaltransformchirpPoint) -> SignaltransformchirpPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn SignaltransformchirpPoint::sub(self : SignaltransformchirpPoint, other : SignaltransformchirpPoint) -> SignaltransformchirpPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn SignaltransformchirpPoint::scale(self : SignaltransformchirpPoint, s : Double) -> SignaltransformchirpPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn SignaltransformchirpPoint::dot(self : SignaltransformchirpPoint, other : SignaltransformchirpPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn SignaltransformchirpPoint::cross(self : SignaltransformchirpPoint, other : SignaltransformchirpPoint) -> SignaltransformchirpPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn SignaltransformchirpPoint::norm(self : SignaltransformchirpPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn SignaltransformchirpPoint::normalize(self : SignaltransformchirpPoint) -> SignaltransformchirpPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn SignaltransformchirpPoint::negate(self : SignaltransformchirpPoint) -> SignaltransformchirpPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn SignaltransformchirpPoint::mid(self : SignaltransformchirpPoint, other : SignaltransformchirpPoint) -> SignaltransformchirpPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn SignaltransformchirpPoint::lerp(self : SignaltransformchirpPoint, other : SignaltransformchirpPoint, t : Double) -> SignaltransformchirpPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn SignaltransformchirpPoint::to_string(self : SignaltransformchirpPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct SignaltransformchirpSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn signal_transform_chirp_make_series(vals : Array[Double], name : String) -> SignaltransformchirpSeries {
  { vals, name, meta: 0 }
}

pub fn SignaltransformchirpSeries::len(self : SignaltransformchirpSeries) -> Int { self.vals.length() }

pub fn SignaltransformchirpSeries::sum(self : SignaltransformchirpSeries) -> Double { @_common.sum(self.vals) }

pub fn SignaltransformchirpSeries::mean(self : SignaltransformchirpSeries) -> Double { @_common.mean(self.vals) }

pub fn SignaltransformchirpSeries::min(self : SignaltransformchirpSeries) -> Double { @_common.min(self.vals) }

pub fn SignaltransformchirpSeries::max(self : SignaltransformchirpSeries) -> Double { @_common.max(self.vals) }

pub fn SignaltransformchirpSeries::range(self : SignaltransformchirpSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn SignaltransformchirpSeries::variance(self : SignaltransformchirpSeries) -> Double { @_common.variance(self.vals) }

pub fn SignaltransformchirpSeries::std(self : SignaltransformchirpSeries) -> Double { @_common.std(self.vals) }

pub fn SignaltransformchirpSeries::median(self : SignaltransformchirpSeries) -> Double { @_common.median(self.vals) }

pub fn SignaltransformchirpSeries::scale(self : SignaltransformchirpSeries, f : Double) -> SignaltransformchirpSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn SignaltransformchirpSeries::add(self : SignaltransformchirpSeries, other : SignaltransformchirpSeries) -> SignaltransformchirpSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn SignaltransformchirpSeries::sub(self : SignaltransformchirpSeries, other : SignaltransformchirpSeries) -> SignaltransformchirpSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn SignaltransformchirpSeries::normalize(self : SignaltransformchirpSeries) -> SignaltransformchirpSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn SignaltransformchirpSeries::cumsum(self : SignaltransformchirpSeries) -> SignaltransformchirpSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn SignaltransformchirpSeries::to_string(self : SignaltransformchirpSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct SignaltransformchirpMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn signal_transform_chirp_make_matrix(rows : Int, cols : Int, val : Double) -> SignaltransformchirpMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn signal_transform_chirp_matrix_identity(n : Int) -> SignaltransformchirpMatrix {
  let m = signal_transform_chirp_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn SignaltransformchirpMatrix::get(self : SignaltransformchirpMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn SignaltransformchirpMatrix::transpose(self : SignaltransformchirpMatrix) -> SignaltransformchirpMatrix {
  let result = signal_transform_chirp_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn SignaltransformchirpMatrix::add(self : SignaltransformchirpMatrix, other : SignaltransformchirpMatrix) -> SignaltransformchirpMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = signal_transform_chirp_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn SignaltransformchirpMatrix::scale(self : SignaltransformchirpMatrix, s : Double) -> SignaltransformchirpMatrix {
  let result = signal_transform_chirp_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn SignaltransformchirpMatrix::multiply(self : SignaltransformchirpMatrix, other : SignaltransformchirpMatrix) -> SignaltransformchirpMatrix {
  if self.cols != other.rows { return signal_transform_chirp_make_matrix(self.rows, other.cols, 0.0) }
  let result = signal_transform_chirp_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn SignaltransformchirpMatrix::trace(self : SignaltransformchirpMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn SignaltransformchirpMatrix::det(self : SignaltransformchirpMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn SignaltransformchirpMatrix::norm(self : SignaltransformchirpMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn SignaltransformchirpMatrix::to_string(self : SignaltransformchirpMatrix) -> String {
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

pub(all) struct SignaltransformchirpVector {
  comps : Array[Double]
  dim : Int
}

pub fn signal_transform_chirp_make_vector(comps : Array[Double]) -> SignaltransformchirpVector {
  { comps, dim: comps.length() }
}

pub fn signal_transform_chirp_vector_zero(dim : Int) -> SignaltransformchirpVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn SignaltransformchirpVector::add(self : SignaltransformchirpVector, other : SignaltransformchirpVector) -> SignaltransformchirpVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn SignaltransformchirpVector::sub(self : SignaltransformchirpVector, other : SignaltransformchirpVector) -> SignaltransformchirpVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn SignaltransformchirpVector::scale(self : SignaltransformchirpVector, s : Double) -> SignaltransformchirpVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn SignaltransformchirpVector::dot(self : SignaltransformchirpVector, other : SignaltransformchirpVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn SignaltransformchirpVector::norm(self : SignaltransformchirpVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn SignaltransformchirpVector::normalize(self : SignaltransformchirpVector) -> SignaltransformchirpVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn SignaltransformchirpVector::dist(self : SignaltransformchirpVector, other : SignaltransformchirpVector) -> Double {
  self.sub(other).norm()
}

pub fn SignaltransformchirpVector::to_string(self : SignaltransformchirpVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn signal_transform_chirp_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn signal_transform_chirp_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn signal_transform_chirp_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn signal_transform_chirp_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn signal_transform_chirp_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn signal_transform_chirp_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn signal_transform_chirp_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn signal_transform_chirp_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn signal_transform_chirp_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn signal_transform_chirp_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn signal_transform_chirp_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn signal_transform_chirp_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn signal_transform_chirp_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn signal_transform_chirp_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn signal_transform_chirp_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn signal_transform_chirp_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn signal_transform_chirp_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn signal_transform_chirp_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn signal_transform_chirp_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn signal_transform_chirp_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn signal_transform_chirp_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn signal_transform_chirp_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn signal_transform_chirp_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn signal_transform_chirp_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn signal_transform_chirp_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn signal_transform_chirp_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn signal_transform_chirp_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn signal_transform_chirp_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn signal_transform_chirp_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct SignaltransformchirpFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_transform_chirp_frame_make(size : Int) -> SignaltransformchirpFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_transform_chirp_frame_len(s : SignaltransformchirpFrame) -> Int { s.size }

pub fn signal_transform_chirp_frame_get(s : SignaltransformchirpFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_transform_chirp_frame_set(s : SignaltransformchirpFrame, i : Int, v : Double) -> SignaltransformchirpFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_transform_chirp_frame_sum(s : SignaltransformchirpFrame) -> Double { @_common.sum(s.data) }

pub fn signal_transform_chirp_frame_mean(s : SignaltransformchirpFrame) -> Double { @_common.mean(s.data) }

pub fn signal_transform_chirp_frame_scale(s : SignaltransformchirpFrame, f : Double) -> SignaltransformchirpFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_transform_chirp_frame_add(a : SignaltransformchirpFrame, b : SignaltransformchirpFrame) -> SignaltransformchirpFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_transform_chirp_frame_copy(s : SignaltransformchirpFrame) -> SignaltransformchirpFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_transform_chirp_frame_fill(s : SignaltransformchirpFrame, v : Double) -> SignaltransformchirpFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_transform_chirp_frame_min(s : SignaltransformchirpFrame) -> Double { @_common.min(s.data) }

pub fn signal_transform_chirp_frame_max(s : SignaltransformchirpFrame) -> Double { @_common.max(s.data) }

pub fn signal_transform_chirp_frame_to_string(s : SignaltransformchirpFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignaltransformchirpTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_transform_chirp_table_make(size : Int) -> SignaltransformchirpTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_transform_chirp_table_len(s : SignaltransformchirpTable) -> Int { s.size }

pub fn signal_transform_chirp_table_get(s : SignaltransformchirpTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_transform_chirp_table_set(s : SignaltransformchirpTable, i : Int, v : Double) -> SignaltransformchirpTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_transform_chirp_table_sum(s : SignaltransformchirpTable) -> Double { @_common.sum(s.data) }

pub fn signal_transform_chirp_table_mean(s : SignaltransformchirpTable) -> Double { @_common.mean(s.data) }

pub fn signal_transform_chirp_table_scale(s : SignaltransformchirpTable, f : Double) -> SignaltransformchirpTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_transform_chirp_table_add(a : SignaltransformchirpTable, b : SignaltransformchirpTable) -> SignaltransformchirpTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_transform_chirp_table_copy(s : SignaltransformchirpTable) -> SignaltransformchirpTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_transform_chirp_table_fill(s : SignaltransformchirpTable, v : Double) -> SignaltransformchirpTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_transform_chirp_table_min(s : SignaltransformchirpTable) -> Double { @_common.min(s.data) }

pub fn signal_transform_chirp_table_max(s : SignaltransformchirpTable) -> Double { @_common.max(s.data) }

pub fn signal_transform_chirp_table_to_string(s : SignaltransformchirpTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignaltransformchirpGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_transform_chirp_graphn_make(size : Int) -> SignaltransformchirpGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_transform_chirp_graphn_len(s : SignaltransformchirpGraphN) -> Int { s.size }

pub fn signal_transform_chirp_graphn_get(s : SignaltransformchirpGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_transform_chirp_graphn_set(s : SignaltransformchirpGraphN, i : Int, v : Double) -> SignaltransformchirpGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_transform_chirp_graphn_sum(s : SignaltransformchirpGraphN) -> Double { @_common.sum(s.data) }

pub fn signal_transform_chirp_graphn_mean(s : SignaltransformchirpGraphN) -> Double { @_common.mean(s.data) }

pub fn signal_transform_chirp_graphn_scale(s : SignaltransformchirpGraphN, f : Double) -> SignaltransformchirpGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_transform_chirp_graphn_add(a : SignaltransformchirpGraphN, b : SignaltransformchirpGraphN) -> SignaltransformchirpGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_transform_chirp_graphn_copy(s : SignaltransformchirpGraphN) -> SignaltransformchirpGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_transform_chirp_graphn_fill(s : SignaltransformchirpGraphN, v : Double) -> SignaltransformchirpGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_transform_chirp_graphn_min(s : SignaltransformchirpGraphN) -> Double { @_common.min(s.data) }

pub fn signal_transform_chirp_graphn_max(s : SignaltransformchirpGraphN) -> Double { @_common.max(s.data) }

pub fn signal_transform_chirp_graphn_to_string(s : SignaltransformchirpGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignaltransformchirpNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_transform_chirp_node_make(size : Int) -> SignaltransformchirpNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_transform_chirp_node_len(s : SignaltransformchirpNode) -> Int { s.size }

pub fn signal_transform_chirp_node_get(s : SignaltransformchirpNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_transform_chirp_node_set(s : SignaltransformchirpNode, i : Int, v : Double) -> SignaltransformchirpNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_transform_chirp_node_sum(s : SignaltransformchirpNode) -> Double { @_common.sum(s.data) }

pub fn signal_transform_chirp_node_mean(s : SignaltransformchirpNode) -> Double { @_common.mean(s.data) }

pub fn signal_transform_chirp_node_scale(s : SignaltransformchirpNode, f : Double) -> SignaltransformchirpNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_transform_chirp_node_add(a : SignaltransformchirpNode, b : SignaltransformchirpNode) -> SignaltransformchirpNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_transform_chirp_node_copy(s : SignaltransformchirpNode) -> SignaltransformchirpNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_transform_chirp_node_fill(s : SignaltransformchirpNode, v : Double) -> SignaltransformchirpNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_transform_chirp_node_min(s : SignaltransformchirpNode) -> Double { @_common.min(s.data) }

pub fn signal_transform_chirp_node_max(s : SignaltransformchirpNode) -> Double { @_common.max(s.data) }

pub fn signal_transform_chirp_node_to_string(s : SignaltransformchirpNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignaltransformchirpEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_transform_chirp_edge_make(size : Int) -> SignaltransformchirpEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_transform_chirp_edge_len(s : SignaltransformchirpEdge) -> Int { s.size }

pub fn signal_transform_chirp_edge_get(s : SignaltransformchirpEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_transform_chirp_edge_set(s : SignaltransformchirpEdge, i : Int, v : Double) -> SignaltransformchirpEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_transform_chirp_edge_sum(s : SignaltransformchirpEdge) -> Double { @_common.sum(s.data) }

pub fn signal_transform_chirp_edge_mean(s : SignaltransformchirpEdge) -> Double { @_common.mean(s.data) }

pub fn signal_transform_chirp_edge_scale(s : SignaltransformchirpEdge, f : Double) -> SignaltransformchirpEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_transform_chirp_edge_add(a : SignaltransformchirpEdge, b : SignaltransformchirpEdge) -> SignaltransformchirpEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_transform_chirp_edge_copy(s : SignaltransformchirpEdge) -> SignaltransformchirpEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_transform_chirp_edge_fill(s : SignaltransformchirpEdge, v : Double) -> SignaltransformchirpEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_transform_chirp_edge_min(s : SignaltransformchirpEdge) -> Double { @_common.min(s.data) }

pub fn signal_transform_chirp_edge_max(s : SignaltransformchirpEdge) -> Double { @_common.max(s.data) }

pub fn signal_transform_chirp_edge_to_string(s : SignaltransformchirpEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignaltransformchirpPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_transform_chirp_path_make(size : Int) -> SignaltransformchirpPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_transform_chirp_path_len(s : SignaltransformchirpPath) -> Int { s.size }

pub fn signal_transform_chirp_path_get(s : SignaltransformchirpPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_transform_chirp_path_set(s : SignaltransformchirpPath, i : Int, v : Double) -> SignaltransformchirpPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_transform_chirp_path_sum(s : SignaltransformchirpPath) -> Double { @_common.sum(s.data) }

pub fn signal_transform_chirp_path_mean(s : SignaltransformchirpPath) -> Double { @_common.mean(s.data) }

pub fn signal_transform_chirp_path_scale(s : SignaltransformchirpPath, f : Double) -> SignaltransformchirpPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_transform_chirp_path_add(a : SignaltransformchirpPath, b : SignaltransformchirpPath) -> SignaltransformchirpPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_transform_chirp_path_copy(s : SignaltransformchirpPath) -> SignaltransformchirpPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_transform_chirp_path_fill(s : SignaltransformchirpPath, v : Double) -> SignaltransformchirpPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_transform_chirp_path_min(s : SignaltransformchirpPath) -> Double { @_common.min(s.data) }

pub fn signal_transform_chirp_path_max(s : SignaltransformchirpPath) -> Double { @_common.max(s.data) }

pub fn signal_transform_chirp_path_to_string(s : SignaltransformchirpPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignaltransformchirpCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_transform_chirp_cluster_make(size : Int) -> SignaltransformchirpCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_transform_chirp_cluster_len(s : SignaltransformchirpCluster) -> Int { s.size }

pub fn signal_transform_chirp_cluster_get(s : SignaltransformchirpCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_transform_chirp_cluster_set(s : SignaltransformchirpCluster, i : Int, v : Double) -> SignaltransformchirpCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_transform_chirp_cluster_sum(s : SignaltransformchirpCluster) -> Double { @_common.sum(s.data) }

pub fn signal_transform_chirp_cluster_mean(s : SignaltransformchirpCluster) -> Double { @_common.mean(s.data) }

pub fn signal_transform_chirp_cluster_scale(s : SignaltransformchirpCluster, f : Double) -> SignaltransformchirpCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_transform_chirp_cluster_add(a : SignaltransformchirpCluster, b : SignaltransformchirpCluster) -> SignaltransformchirpCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_transform_chirp_cluster_copy(s : SignaltransformchirpCluster) -> SignaltransformchirpCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_transform_chirp_cluster_fill(s : SignaltransformchirpCluster, v : Double) -> SignaltransformchirpCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_transform_chirp_cluster_min(s : SignaltransformchirpCluster) -> Double { @_common.min(s.data) }

pub fn signal_transform_chirp_cluster_max(s : SignaltransformchirpCluster) -> Double { @_common.max(s.data) }

pub fn signal_transform_chirp_cluster_to_string(s : SignaltransformchirpCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignaltransformchirpModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_transform_chirp_model_make(size : Int) -> SignaltransformchirpModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_transform_chirp_model_len(s : SignaltransformchirpModel) -> Int { s.size }

pub fn signal_transform_chirp_model_get(s : SignaltransformchirpModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_transform_chirp_model_set(s : SignaltransformchirpModel, i : Int, v : Double) -> SignaltransformchirpModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_transform_chirp_model_sum(s : SignaltransformchirpModel) -> Double { @_common.sum(s.data) }

pub fn signal_transform_chirp_model_mean(s : SignaltransformchirpModel) -> Double { @_common.mean(s.data) }

pub fn signal_transform_chirp_model_scale(s : SignaltransformchirpModel, f : Double) -> SignaltransformchirpModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_transform_chirp_model_add(a : SignaltransformchirpModel, b : SignaltransformchirpModel) -> SignaltransformchirpModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_transform_chirp_model_copy(s : SignaltransformchirpModel) -> SignaltransformchirpModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_transform_chirp_model_fill(s : SignaltransformchirpModel, v : Double) -> SignaltransformchirpModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_transform_chirp_model_min(s : SignaltransformchirpModel) -> Double { @_common.min(s.data) }

pub fn signal_transform_chirp_model_max(s : SignaltransformchirpModel) -> Double { @_common.max(s.data) }

pub fn signal_transform_chirp_model_to_string(s : SignaltransformchirpModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignaltransformchirpLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_transform_chirp_layer_make(size : Int) -> SignaltransformchirpLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_transform_chirp_layer_len(s : SignaltransformchirpLayer) -> Int { s.size }

pub fn signal_transform_chirp_layer_get(s : SignaltransformchirpLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_transform_chirp_layer_set(s : SignaltransformchirpLayer, i : Int, v : Double) -> SignaltransformchirpLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_transform_chirp_layer_sum(s : SignaltransformchirpLayer) -> Double { @_common.sum(s.data) }

pub fn signal_transform_chirp_layer_mean(s : SignaltransformchirpLayer) -> Double { @_common.mean(s.data) }

pub fn signal_transform_chirp_layer_scale(s : SignaltransformchirpLayer, f : Double) -> SignaltransformchirpLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_transform_chirp_layer_add(a : SignaltransformchirpLayer, b : SignaltransformchirpLayer) -> SignaltransformchirpLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_transform_chirp_layer_copy(s : SignaltransformchirpLayer) -> SignaltransformchirpLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_transform_chirp_layer_fill(s : SignaltransformchirpLayer, v : Double) -> SignaltransformchirpLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_transform_chirp_layer_min(s : SignaltransformchirpLayer) -> Double { @_common.min(s.data) }

pub fn signal_transform_chirp_layer_max(s : SignaltransformchirpLayer) -> Double { @_common.max(s.data) }

pub fn signal_transform_chirp_layer_to_string(s : SignaltransformchirpLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignaltransformchirpBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_transform_chirp_buffer_make(size : Int) -> SignaltransformchirpBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_transform_chirp_buffer_len(s : SignaltransformchirpBuffer) -> Int { s.size }

pub fn signal_transform_chirp_buffer_get(s : SignaltransformchirpBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_transform_chirp_buffer_set(s : SignaltransformchirpBuffer, i : Int, v : Double) -> SignaltransformchirpBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_transform_chirp_buffer_sum(s : SignaltransformchirpBuffer) -> Double { @_common.sum(s.data) }

pub fn signal_transform_chirp_buffer_mean(s : SignaltransformchirpBuffer) -> Double { @_common.mean(s.data) }

pub fn signal_transform_chirp_buffer_scale(s : SignaltransformchirpBuffer, f : Double) -> SignaltransformchirpBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_transform_chirp_buffer_add(a : SignaltransformchirpBuffer, b : SignaltransformchirpBuffer) -> SignaltransformchirpBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_transform_chirp_buffer_copy(s : SignaltransformchirpBuffer) -> SignaltransformchirpBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_transform_chirp_buffer_fill(s : SignaltransformchirpBuffer, v : Double) -> SignaltransformchirpBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_transform_chirp_buffer_min(s : SignaltransformchirpBuffer) -> Double { @_common.min(s.data) }

pub fn signal_transform_chirp_buffer_max(s : SignaltransformchirpBuffer) -> Double { @_common.max(s.data) }

pub fn signal_transform_chirp_buffer_to_string(s : SignaltransformchirpBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignaltransformchirpCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_transform_chirp_cursor_make(size : Int) -> SignaltransformchirpCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_transform_chirp_cursor_len(s : SignaltransformchirpCursor) -> Int { s.size }

pub fn signal_transform_chirp_cursor_get(s : SignaltransformchirpCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_transform_chirp_cursor_set(s : SignaltransformchirpCursor, i : Int, v : Double) -> SignaltransformchirpCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_transform_chirp_cursor_sum(s : SignaltransformchirpCursor) -> Double { @_common.sum(s.data) }

pub fn signal_transform_chirp_cursor_mean(s : SignaltransformchirpCursor) -> Double { @_common.mean(s.data) }

pub fn signal_transform_chirp_cursor_scale(s : SignaltransformchirpCursor, f : Double) -> SignaltransformchirpCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_transform_chirp_cursor_add(a : SignaltransformchirpCursor, b : SignaltransformchirpCursor) -> SignaltransformchirpCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_transform_chirp_cursor_copy(s : SignaltransformchirpCursor) -> SignaltransformchirpCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_transform_chirp_cursor_fill(s : SignaltransformchirpCursor, v : Double) -> SignaltransformchirpCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_transform_chirp_cursor_min(s : SignaltransformchirpCursor) -> Double { @_common.min(s.data) }

pub fn signal_transform_chirp_cursor_max(s : SignaltransformchirpCursor) -> Double { @_common.max(s.data) }

pub fn signal_transform_chirp_cursor_to_string(s : SignaltransformchirpCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignaltransformchirpView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_transform_chirp_view_make(size : Int) -> SignaltransformchirpView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_transform_chirp_view_len(s : SignaltransformchirpView) -> Int { s.size }

pub fn signal_transform_chirp_view_get(s : SignaltransformchirpView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_transform_chirp_view_set(s : SignaltransformchirpView, i : Int, v : Double) -> SignaltransformchirpView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_transform_chirp_view_sum(s : SignaltransformchirpView) -> Double { @_common.sum(s.data) }

pub fn signal_transform_chirp_view_mean(s : SignaltransformchirpView) -> Double { @_common.mean(s.data) }

pub fn signal_transform_chirp_view_scale(s : SignaltransformchirpView, f : Double) -> SignaltransformchirpView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_transform_chirp_view_add(a : SignaltransformchirpView, b : SignaltransformchirpView) -> SignaltransformchirpView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_transform_chirp_view_copy(s : SignaltransformchirpView) -> SignaltransformchirpView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_transform_chirp_view_fill(s : SignaltransformchirpView, v : Double) -> SignaltransformchirpView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_transform_chirp_view_min(s : SignaltransformchirpView) -> Double { @_common.min(s.data) }

pub fn signal_transform_chirp_view_max(s : SignaltransformchirpView) -> Double { @_common.max(s.data) }

pub fn signal_transform_chirp_view_to_string(s : SignaltransformchirpView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignaltransformchirpRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_transform_chirp_range_make(size : Int) -> SignaltransformchirpRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_transform_chirp_range_len(s : SignaltransformchirpRange) -> Int { s.size }

pub fn signal_transform_chirp_range_get(s : SignaltransformchirpRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_transform_chirp_range_set(s : SignaltransformchirpRange, i : Int, v : Double) -> SignaltransformchirpRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_transform_chirp_range_sum(s : SignaltransformchirpRange) -> Double { @_common.sum(s.data) }

pub fn signal_transform_chirp_range_mean(s : SignaltransformchirpRange) -> Double { @_common.mean(s.data) }

pub fn signal_transform_chirp_range_scale(s : SignaltransformchirpRange, f : Double) -> SignaltransformchirpRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_transform_chirp_range_add(a : SignaltransformchirpRange, b : SignaltransformchirpRange) -> SignaltransformchirpRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_transform_chirp_range_copy(s : SignaltransformchirpRange) -> SignaltransformchirpRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_transform_chirp_range_fill(s : SignaltransformchirpRange, v : Double) -> SignaltransformchirpRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_transform_chirp_range_min(s : SignaltransformchirpRange) -> Double { @_common.min(s.data) }

pub fn signal_transform_chirp_range_max(s : SignaltransformchirpRange) -> Double { @_common.max(s.data) }

pub fn signal_transform_chirp_range_to_string(s : SignaltransformchirpRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SignaltransformchirpSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_transform_chirp_slice_make(size : Int) -> SignaltransformchirpSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn signal_transform_chirp_slice_len(s : SignaltransformchirpSlice) -> Int { s.size }

pub fn signal_transform_chirp_slice_get(s : SignaltransformchirpSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn signal_transform_chirp_slice_set(s : SignaltransformchirpSlice, i : Int, v : Double) -> SignaltransformchirpSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn signal_transform_chirp_slice_sum(s : SignaltransformchirpSlice) -> Double { @_common.sum(s.data) }

pub fn signal_transform_chirp_slice_mean(s : SignaltransformchirpSlice) -> Double { @_common.mean(s.data) }

pub fn signal_transform_chirp_slice_scale(s : SignaltransformchirpSlice, f : Double) -> SignaltransformchirpSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn signal_transform_chirp_slice_add(a : SignaltransformchirpSlice, b : SignaltransformchirpSlice) -> SignaltransformchirpSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn signal_transform_chirp_slice_copy(s : SignaltransformchirpSlice) -> SignaltransformchirpSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn signal_transform_chirp_slice_fill(s : SignaltransformchirpSlice, v : Double) -> SignaltransformchirpSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn signal_transform_chirp_slice_min(s : SignaltransformchirpSlice) -> Double { @_common.min(s.data) }

pub fn signal_transform_chirp_slice_max(s : SignaltransformchirpSlice) -> Double { @_common.max(s.data) }

pub fn signal_transform_chirp_slice_to_string(s : SignaltransformchirpSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

