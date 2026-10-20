///===
/// extcore/physics_em_high_freq

pub(all) struct PhysicsemhighfreqPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn physics_em_high_freq_make_point(x : Double, y : Double) -> PhysicsemhighfreqPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn physics_em_high_freq_make_point3(x : Double, y : Double, z : Double) -> PhysicsemhighfreqPoint {
  { x, y, z, label: 0 }
}

pub fn PhysicsemhighfreqPoint::x(self : PhysicsemhighfreqPoint) -> Double { self.x }

pub fn PhysicsemhighfreqPoint::y(self : PhysicsemhighfreqPoint) -> Double { self.y }

pub fn PhysicsemhighfreqPoint::z(self : PhysicsemhighfreqPoint) -> Double { self.z }

pub fn PhysicsemhighfreqPoint::label(self : PhysicsemhighfreqPoint) -> Int { self.label }

pub fn PhysicsemhighfreqPoint::dist(self : PhysicsemhighfreqPoint, other : PhysicsemhighfreqPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn PhysicsemhighfreqPoint::add(self : PhysicsemhighfreqPoint, other : PhysicsemhighfreqPoint) -> PhysicsemhighfreqPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn PhysicsemhighfreqPoint::sub(self : PhysicsemhighfreqPoint, other : PhysicsemhighfreqPoint) -> PhysicsemhighfreqPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn PhysicsemhighfreqPoint::scale(self : PhysicsemhighfreqPoint, s : Double) -> PhysicsemhighfreqPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn PhysicsemhighfreqPoint::dot(self : PhysicsemhighfreqPoint, other : PhysicsemhighfreqPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn PhysicsemhighfreqPoint::cross(self : PhysicsemhighfreqPoint, other : PhysicsemhighfreqPoint) -> PhysicsemhighfreqPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn PhysicsemhighfreqPoint::norm(self : PhysicsemhighfreqPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn PhysicsemhighfreqPoint::normalize(self : PhysicsemhighfreqPoint) -> PhysicsemhighfreqPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn PhysicsemhighfreqPoint::negate(self : PhysicsemhighfreqPoint) -> PhysicsemhighfreqPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn PhysicsemhighfreqPoint::mid(self : PhysicsemhighfreqPoint, other : PhysicsemhighfreqPoint) -> PhysicsemhighfreqPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn PhysicsemhighfreqPoint::lerp(self : PhysicsemhighfreqPoint, other : PhysicsemhighfreqPoint, t : Double) -> PhysicsemhighfreqPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn PhysicsemhighfreqPoint::to_string(self : PhysicsemhighfreqPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct PhysicsemhighfreqSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn physics_em_high_freq_make_series(vals : Array[Double], name : String) -> PhysicsemhighfreqSeries {
  { vals, name, meta: 0 }
}

pub fn PhysicsemhighfreqSeries::len(self : PhysicsemhighfreqSeries) -> Int { self.vals.length() }

pub fn PhysicsemhighfreqSeries::sum(self : PhysicsemhighfreqSeries) -> Double { @_common.sum(self.vals) }

pub fn PhysicsemhighfreqSeries::mean(self : PhysicsemhighfreqSeries) -> Double { @_common.mean(self.vals) }

pub fn PhysicsemhighfreqSeries::min(self : PhysicsemhighfreqSeries) -> Double { @_common.min(self.vals) }

pub fn PhysicsemhighfreqSeries::max(self : PhysicsemhighfreqSeries) -> Double { @_common.max(self.vals) }

pub fn PhysicsemhighfreqSeries::range(self : PhysicsemhighfreqSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn PhysicsemhighfreqSeries::variance(self : PhysicsemhighfreqSeries) -> Double { @_common.variance(self.vals) }

pub fn PhysicsemhighfreqSeries::std(self : PhysicsemhighfreqSeries) -> Double { @_common.std(self.vals) }

pub fn PhysicsemhighfreqSeries::median(self : PhysicsemhighfreqSeries) -> Double { @_common.median(self.vals) }

pub fn PhysicsemhighfreqSeries::scale(self : PhysicsemhighfreqSeries, f : Double) -> PhysicsemhighfreqSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn PhysicsemhighfreqSeries::add(self : PhysicsemhighfreqSeries, other : PhysicsemhighfreqSeries) -> PhysicsemhighfreqSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn PhysicsemhighfreqSeries::sub(self : PhysicsemhighfreqSeries, other : PhysicsemhighfreqSeries) -> PhysicsemhighfreqSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn PhysicsemhighfreqSeries::normalize(self : PhysicsemhighfreqSeries) -> PhysicsemhighfreqSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn PhysicsemhighfreqSeries::cumsum(self : PhysicsemhighfreqSeries) -> PhysicsemhighfreqSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn PhysicsemhighfreqSeries::to_string(self : PhysicsemhighfreqSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct PhysicsemhighfreqMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn physics_em_high_freq_make_matrix(rows : Int, cols : Int, val : Double) -> PhysicsemhighfreqMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn physics_em_high_freq_matrix_identity(n : Int) -> PhysicsemhighfreqMatrix {
  let m = physics_em_high_freq_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn PhysicsemhighfreqMatrix::get(self : PhysicsemhighfreqMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn PhysicsemhighfreqMatrix::transpose(self : PhysicsemhighfreqMatrix) -> PhysicsemhighfreqMatrix {
  let result = physics_em_high_freq_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn PhysicsemhighfreqMatrix::add(self : PhysicsemhighfreqMatrix, other : PhysicsemhighfreqMatrix) -> PhysicsemhighfreqMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = physics_em_high_freq_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn PhysicsemhighfreqMatrix::scale(self : PhysicsemhighfreqMatrix, s : Double) -> PhysicsemhighfreqMatrix {
  let result = physics_em_high_freq_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn PhysicsemhighfreqMatrix::multiply(self : PhysicsemhighfreqMatrix, other : PhysicsemhighfreqMatrix) -> PhysicsemhighfreqMatrix {
  if self.cols != other.rows { return physics_em_high_freq_make_matrix(self.rows, other.cols, 0.0) }
  let result = physics_em_high_freq_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn PhysicsemhighfreqMatrix::trace(self : PhysicsemhighfreqMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn PhysicsemhighfreqMatrix::det(self : PhysicsemhighfreqMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn PhysicsemhighfreqMatrix::norm(self : PhysicsemhighfreqMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn PhysicsemhighfreqMatrix::to_string(self : PhysicsemhighfreqMatrix) -> String {
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

pub(all) struct PhysicsemhighfreqVector {
  comps : Array[Double]
  dim : Int
}

pub fn physics_em_high_freq_make_vector(comps : Array[Double]) -> PhysicsemhighfreqVector {
  { comps, dim: comps.length() }
}

pub fn physics_em_high_freq_vector_zero(dim : Int) -> PhysicsemhighfreqVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn PhysicsemhighfreqVector::add(self : PhysicsemhighfreqVector, other : PhysicsemhighfreqVector) -> PhysicsemhighfreqVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn PhysicsemhighfreqVector::sub(self : PhysicsemhighfreqVector, other : PhysicsemhighfreqVector) -> PhysicsemhighfreqVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn PhysicsemhighfreqVector::scale(self : PhysicsemhighfreqVector, s : Double) -> PhysicsemhighfreqVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn PhysicsemhighfreqVector::dot(self : PhysicsemhighfreqVector, other : PhysicsemhighfreqVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn PhysicsemhighfreqVector::norm(self : PhysicsemhighfreqVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn PhysicsemhighfreqVector::normalize(self : PhysicsemhighfreqVector) -> PhysicsemhighfreqVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn PhysicsemhighfreqVector::dist(self : PhysicsemhighfreqVector, other : PhysicsemhighfreqVector) -> Double {
  self.sub(other).norm()
}

pub fn PhysicsemhighfreqVector::to_string(self : PhysicsemhighfreqVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn physics_em_high_freq_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn physics_em_high_freq_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn physics_em_high_freq_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn physics_em_high_freq_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn physics_em_high_freq_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn physics_em_high_freq_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn physics_em_high_freq_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn physics_em_high_freq_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn physics_em_high_freq_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn physics_em_high_freq_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn physics_em_high_freq_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn physics_em_high_freq_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn physics_em_high_freq_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn physics_em_high_freq_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn physics_em_high_freq_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn physics_em_high_freq_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn physics_em_high_freq_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn physics_em_high_freq_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn physics_em_high_freq_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn physics_em_high_freq_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn physics_em_high_freq_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn physics_em_high_freq_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn physics_em_high_freq_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn physics_em_high_freq_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn physics_em_high_freq_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn physics_em_high_freq_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn physics_em_high_freq_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn physics_em_high_freq_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn physics_em_high_freq_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct PhysicsemhighfreqFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_em_high_freq_frame_make(size : Int) -> PhysicsemhighfreqFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_em_high_freq_frame_len(s : PhysicsemhighfreqFrame) -> Int { s.size }

pub fn physics_em_high_freq_frame_get(s : PhysicsemhighfreqFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_em_high_freq_frame_set(s : PhysicsemhighfreqFrame, i : Int, v : Double) -> PhysicsemhighfreqFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn physics_em_high_freq_frame_sum(s : PhysicsemhighfreqFrame) -> Double { @_common.sum(s.data) }

pub fn physics_em_high_freq_frame_mean(s : PhysicsemhighfreqFrame) -> Double { @_common.mean(s.data) }

pub fn physics_em_high_freq_frame_scale(s : PhysicsemhighfreqFrame, f : Double) -> PhysicsemhighfreqFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_em_high_freq_frame_add(a : PhysicsemhighfreqFrame, b : PhysicsemhighfreqFrame) -> PhysicsemhighfreqFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_em_high_freq_frame_copy(s : PhysicsemhighfreqFrame) -> PhysicsemhighfreqFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_em_high_freq_frame_fill(s : PhysicsemhighfreqFrame, v : Double) -> PhysicsemhighfreqFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_em_high_freq_frame_min(s : PhysicsemhighfreqFrame) -> Double { @_common.min(s.data) }

pub fn physics_em_high_freq_frame_max(s : PhysicsemhighfreqFrame) -> Double { @_common.max(s.data) }

pub fn physics_em_high_freq_frame_to_string(s : PhysicsemhighfreqFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsemhighfreqTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_em_high_freq_table_make(size : Int) -> PhysicsemhighfreqTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_em_high_freq_table_len(s : PhysicsemhighfreqTable) -> Int { s.size }

pub fn physics_em_high_freq_table_get(s : PhysicsemhighfreqTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_em_high_freq_table_set(s : PhysicsemhighfreqTable, i : Int, v : Double) -> PhysicsemhighfreqTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn physics_em_high_freq_table_sum(s : PhysicsemhighfreqTable) -> Double { @_common.sum(s.data) }

pub fn physics_em_high_freq_table_mean(s : PhysicsemhighfreqTable) -> Double { @_common.mean(s.data) }

pub fn physics_em_high_freq_table_scale(s : PhysicsemhighfreqTable, f : Double) -> PhysicsemhighfreqTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_em_high_freq_table_add(a : PhysicsemhighfreqTable, b : PhysicsemhighfreqTable) -> PhysicsemhighfreqTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_em_high_freq_table_copy(s : PhysicsemhighfreqTable) -> PhysicsemhighfreqTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_em_high_freq_table_fill(s : PhysicsemhighfreqTable, v : Double) -> PhysicsemhighfreqTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_em_high_freq_table_min(s : PhysicsemhighfreqTable) -> Double { @_common.min(s.data) }

pub fn physics_em_high_freq_table_max(s : PhysicsemhighfreqTable) -> Double { @_common.max(s.data) }

pub fn physics_em_high_freq_table_to_string(s : PhysicsemhighfreqTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsemhighfreqGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_em_high_freq_graphn_make(size : Int) -> PhysicsemhighfreqGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_em_high_freq_graphn_len(s : PhysicsemhighfreqGraphN) -> Int { s.size }

pub fn physics_em_high_freq_graphn_get(s : PhysicsemhighfreqGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_em_high_freq_graphn_set(s : PhysicsemhighfreqGraphN, i : Int, v : Double) -> PhysicsemhighfreqGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn physics_em_high_freq_graphn_sum(s : PhysicsemhighfreqGraphN) -> Double { @_common.sum(s.data) }

pub fn physics_em_high_freq_graphn_mean(s : PhysicsemhighfreqGraphN) -> Double { @_common.mean(s.data) }

pub fn physics_em_high_freq_graphn_scale(s : PhysicsemhighfreqGraphN, f : Double) -> PhysicsemhighfreqGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_em_high_freq_graphn_add(a : PhysicsemhighfreqGraphN, b : PhysicsemhighfreqGraphN) -> PhysicsemhighfreqGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_em_high_freq_graphn_copy(s : PhysicsemhighfreqGraphN) -> PhysicsemhighfreqGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_em_high_freq_graphn_fill(s : PhysicsemhighfreqGraphN, v : Double) -> PhysicsemhighfreqGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_em_high_freq_graphn_min(s : PhysicsemhighfreqGraphN) -> Double { @_common.min(s.data) }

pub fn physics_em_high_freq_graphn_max(s : PhysicsemhighfreqGraphN) -> Double { @_common.max(s.data) }

pub fn physics_em_high_freq_graphn_to_string(s : PhysicsemhighfreqGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsemhighfreqNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_em_high_freq_node_make(size : Int) -> PhysicsemhighfreqNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_em_high_freq_node_len(s : PhysicsemhighfreqNode) -> Int { s.size }

pub fn physics_em_high_freq_node_get(s : PhysicsemhighfreqNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_em_high_freq_node_set(s : PhysicsemhighfreqNode, i : Int, v : Double) -> PhysicsemhighfreqNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn physics_em_high_freq_node_sum(s : PhysicsemhighfreqNode) -> Double { @_common.sum(s.data) }

pub fn physics_em_high_freq_node_mean(s : PhysicsemhighfreqNode) -> Double { @_common.mean(s.data) }

pub fn physics_em_high_freq_node_scale(s : PhysicsemhighfreqNode, f : Double) -> PhysicsemhighfreqNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_em_high_freq_node_add(a : PhysicsemhighfreqNode, b : PhysicsemhighfreqNode) -> PhysicsemhighfreqNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_em_high_freq_node_copy(s : PhysicsemhighfreqNode) -> PhysicsemhighfreqNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_em_high_freq_node_fill(s : PhysicsemhighfreqNode, v : Double) -> PhysicsemhighfreqNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_em_high_freq_node_min(s : PhysicsemhighfreqNode) -> Double { @_common.min(s.data) }

pub fn physics_em_high_freq_node_max(s : PhysicsemhighfreqNode) -> Double { @_common.max(s.data) }

pub fn physics_em_high_freq_node_to_string(s : PhysicsemhighfreqNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsemhighfreqEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_em_high_freq_edge_make(size : Int) -> PhysicsemhighfreqEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_em_high_freq_edge_len(s : PhysicsemhighfreqEdge) -> Int { s.size }

pub fn physics_em_high_freq_edge_get(s : PhysicsemhighfreqEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_em_high_freq_edge_set(s : PhysicsemhighfreqEdge, i : Int, v : Double) -> PhysicsemhighfreqEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn physics_em_high_freq_edge_sum(s : PhysicsemhighfreqEdge) -> Double { @_common.sum(s.data) }

pub fn physics_em_high_freq_edge_mean(s : PhysicsemhighfreqEdge) -> Double { @_common.mean(s.data) }

pub fn physics_em_high_freq_edge_scale(s : PhysicsemhighfreqEdge, f : Double) -> PhysicsemhighfreqEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_em_high_freq_edge_add(a : PhysicsemhighfreqEdge, b : PhysicsemhighfreqEdge) -> PhysicsemhighfreqEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_em_high_freq_edge_copy(s : PhysicsemhighfreqEdge) -> PhysicsemhighfreqEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_em_high_freq_edge_fill(s : PhysicsemhighfreqEdge, v : Double) -> PhysicsemhighfreqEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_em_high_freq_edge_min(s : PhysicsemhighfreqEdge) -> Double { @_common.min(s.data) }

pub fn physics_em_high_freq_edge_max(s : PhysicsemhighfreqEdge) -> Double { @_common.max(s.data) }

pub fn physics_em_high_freq_edge_to_string(s : PhysicsemhighfreqEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsemhighfreqPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_em_high_freq_path_make(size : Int) -> PhysicsemhighfreqPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_em_high_freq_path_len(s : PhysicsemhighfreqPath) -> Int { s.size }

pub fn physics_em_high_freq_path_get(s : PhysicsemhighfreqPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_em_high_freq_path_set(s : PhysicsemhighfreqPath, i : Int, v : Double) -> PhysicsemhighfreqPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn physics_em_high_freq_path_sum(s : PhysicsemhighfreqPath) -> Double { @_common.sum(s.data) }

pub fn physics_em_high_freq_path_mean(s : PhysicsemhighfreqPath) -> Double { @_common.mean(s.data) }

pub fn physics_em_high_freq_path_scale(s : PhysicsemhighfreqPath, f : Double) -> PhysicsemhighfreqPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_em_high_freq_path_add(a : PhysicsemhighfreqPath, b : PhysicsemhighfreqPath) -> PhysicsemhighfreqPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_em_high_freq_path_copy(s : PhysicsemhighfreqPath) -> PhysicsemhighfreqPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_em_high_freq_path_fill(s : PhysicsemhighfreqPath, v : Double) -> PhysicsemhighfreqPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_em_high_freq_path_min(s : PhysicsemhighfreqPath) -> Double { @_common.min(s.data) }

pub fn physics_em_high_freq_path_max(s : PhysicsemhighfreqPath) -> Double { @_common.max(s.data) }

pub fn physics_em_high_freq_path_to_string(s : PhysicsemhighfreqPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsemhighfreqCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_em_high_freq_cluster_make(size : Int) -> PhysicsemhighfreqCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_em_high_freq_cluster_len(s : PhysicsemhighfreqCluster) -> Int { s.size }

pub fn physics_em_high_freq_cluster_get(s : PhysicsemhighfreqCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_em_high_freq_cluster_set(s : PhysicsemhighfreqCluster, i : Int, v : Double) -> PhysicsemhighfreqCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn physics_em_high_freq_cluster_sum(s : PhysicsemhighfreqCluster) -> Double { @_common.sum(s.data) }

pub fn physics_em_high_freq_cluster_mean(s : PhysicsemhighfreqCluster) -> Double { @_common.mean(s.data) }

pub fn physics_em_high_freq_cluster_scale(s : PhysicsemhighfreqCluster, f : Double) -> PhysicsemhighfreqCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_em_high_freq_cluster_add(a : PhysicsemhighfreqCluster, b : PhysicsemhighfreqCluster) -> PhysicsemhighfreqCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_em_high_freq_cluster_copy(s : PhysicsemhighfreqCluster) -> PhysicsemhighfreqCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_em_high_freq_cluster_fill(s : PhysicsemhighfreqCluster, v : Double) -> PhysicsemhighfreqCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_em_high_freq_cluster_min(s : PhysicsemhighfreqCluster) -> Double { @_common.min(s.data) }

pub fn physics_em_high_freq_cluster_max(s : PhysicsemhighfreqCluster) -> Double { @_common.max(s.data) }

pub fn physics_em_high_freq_cluster_to_string(s : PhysicsemhighfreqCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsemhighfreqModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_em_high_freq_model_make(size : Int) -> PhysicsemhighfreqModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_em_high_freq_model_len(s : PhysicsemhighfreqModel) -> Int { s.size }

pub fn physics_em_high_freq_model_get(s : PhysicsemhighfreqModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_em_high_freq_model_set(s : PhysicsemhighfreqModel, i : Int, v : Double) -> PhysicsemhighfreqModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn physics_em_high_freq_model_sum(s : PhysicsemhighfreqModel) -> Double { @_common.sum(s.data) }

pub fn physics_em_high_freq_model_mean(s : PhysicsemhighfreqModel) -> Double { @_common.mean(s.data) }

pub fn physics_em_high_freq_model_scale(s : PhysicsemhighfreqModel, f : Double) -> PhysicsemhighfreqModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_em_high_freq_model_add(a : PhysicsemhighfreqModel, b : PhysicsemhighfreqModel) -> PhysicsemhighfreqModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_em_high_freq_model_copy(s : PhysicsemhighfreqModel) -> PhysicsemhighfreqModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_em_high_freq_model_fill(s : PhysicsemhighfreqModel, v : Double) -> PhysicsemhighfreqModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_em_high_freq_model_min(s : PhysicsemhighfreqModel) -> Double { @_common.min(s.data) }

pub fn physics_em_high_freq_model_max(s : PhysicsemhighfreqModel) -> Double { @_common.max(s.data) }

pub fn physics_em_high_freq_model_to_string(s : PhysicsemhighfreqModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsemhighfreqLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_em_high_freq_layer_make(size : Int) -> PhysicsemhighfreqLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_em_high_freq_layer_len(s : PhysicsemhighfreqLayer) -> Int { s.size }

pub fn physics_em_high_freq_layer_get(s : PhysicsemhighfreqLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_em_high_freq_layer_set(s : PhysicsemhighfreqLayer, i : Int, v : Double) -> PhysicsemhighfreqLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn physics_em_high_freq_layer_sum(s : PhysicsemhighfreqLayer) -> Double { @_common.sum(s.data) }

pub fn physics_em_high_freq_layer_mean(s : PhysicsemhighfreqLayer) -> Double { @_common.mean(s.data) }

pub fn physics_em_high_freq_layer_scale(s : PhysicsemhighfreqLayer, f : Double) -> PhysicsemhighfreqLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_em_high_freq_layer_add(a : PhysicsemhighfreqLayer, b : PhysicsemhighfreqLayer) -> PhysicsemhighfreqLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_em_high_freq_layer_copy(s : PhysicsemhighfreqLayer) -> PhysicsemhighfreqLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_em_high_freq_layer_fill(s : PhysicsemhighfreqLayer, v : Double) -> PhysicsemhighfreqLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_em_high_freq_layer_min(s : PhysicsemhighfreqLayer) -> Double { @_common.min(s.data) }

pub fn physics_em_high_freq_layer_max(s : PhysicsemhighfreqLayer) -> Double { @_common.max(s.data) }

pub fn physics_em_high_freq_layer_to_string(s : PhysicsemhighfreqLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsemhighfreqBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_em_high_freq_buffer_make(size : Int) -> PhysicsemhighfreqBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_em_high_freq_buffer_len(s : PhysicsemhighfreqBuffer) -> Int { s.size }

pub fn physics_em_high_freq_buffer_get(s : PhysicsemhighfreqBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_em_high_freq_buffer_set(s : PhysicsemhighfreqBuffer, i : Int, v : Double) -> PhysicsemhighfreqBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn physics_em_high_freq_buffer_sum(s : PhysicsemhighfreqBuffer) -> Double { @_common.sum(s.data) }

pub fn physics_em_high_freq_buffer_mean(s : PhysicsemhighfreqBuffer) -> Double { @_common.mean(s.data) }

pub fn physics_em_high_freq_buffer_scale(s : PhysicsemhighfreqBuffer, f : Double) -> PhysicsemhighfreqBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_em_high_freq_buffer_add(a : PhysicsemhighfreqBuffer, b : PhysicsemhighfreqBuffer) -> PhysicsemhighfreqBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_em_high_freq_buffer_copy(s : PhysicsemhighfreqBuffer) -> PhysicsemhighfreqBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_em_high_freq_buffer_fill(s : PhysicsemhighfreqBuffer, v : Double) -> PhysicsemhighfreqBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_em_high_freq_buffer_min(s : PhysicsemhighfreqBuffer) -> Double { @_common.min(s.data) }

pub fn physics_em_high_freq_buffer_max(s : PhysicsemhighfreqBuffer) -> Double { @_common.max(s.data) }

pub fn physics_em_high_freq_buffer_to_string(s : PhysicsemhighfreqBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsemhighfreqCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_em_high_freq_cursor_make(size : Int) -> PhysicsemhighfreqCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_em_high_freq_cursor_len(s : PhysicsemhighfreqCursor) -> Int { s.size }

pub fn physics_em_high_freq_cursor_get(s : PhysicsemhighfreqCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_em_high_freq_cursor_set(s : PhysicsemhighfreqCursor, i : Int, v : Double) -> PhysicsemhighfreqCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn physics_em_high_freq_cursor_sum(s : PhysicsemhighfreqCursor) -> Double { @_common.sum(s.data) }

pub fn physics_em_high_freq_cursor_mean(s : PhysicsemhighfreqCursor) -> Double { @_common.mean(s.data) }

pub fn physics_em_high_freq_cursor_scale(s : PhysicsemhighfreqCursor, f : Double) -> PhysicsemhighfreqCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_em_high_freq_cursor_add(a : PhysicsemhighfreqCursor, b : PhysicsemhighfreqCursor) -> PhysicsemhighfreqCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_em_high_freq_cursor_copy(s : PhysicsemhighfreqCursor) -> PhysicsemhighfreqCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_em_high_freq_cursor_fill(s : PhysicsemhighfreqCursor, v : Double) -> PhysicsemhighfreqCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_em_high_freq_cursor_min(s : PhysicsemhighfreqCursor) -> Double { @_common.min(s.data) }

pub fn physics_em_high_freq_cursor_max(s : PhysicsemhighfreqCursor) -> Double { @_common.max(s.data) }

pub fn physics_em_high_freq_cursor_to_string(s : PhysicsemhighfreqCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsemhighfreqView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_em_high_freq_view_make(size : Int) -> PhysicsemhighfreqView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_em_high_freq_view_len(s : PhysicsemhighfreqView) -> Int { s.size }

pub fn physics_em_high_freq_view_get(s : PhysicsemhighfreqView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_em_high_freq_view_set(s : PhysicsemhighfreqView, i : Int, v : Double) -> PhysicsemhighfreqView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn physics_em_high_freq_view_sum(s : PhysicsemhighfreqView) -> Double { @_common.sum(s.data) }

pub fn physics_em_high_freq_view_mean(s : PhysicsemhighfreqView) -> Double { @_common.mean(s.data) }

pub fn physics_em_high_freq_view_scale(s : PhysicsemhighfreqView, f : Double) -> PhysicsemhighfreqView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_em_high_freq_view_add(a : PhysicsemhighfreqView, b : PhysicsemhighfreqView) -> PhysicsemhighfreqView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_em_high_freq_view_copy(s : PhysicsemhighfreqView) -> PhysicsemhighfreqView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_em_high_freq_view_fill(s : PhysicsemhighfreqView, v : Double) -> PhysicsemhighfreqView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_em_high_freq_view_min(s : PhysicsemhighfreqView) -> Double { @_common.min(s.data) }

pub fn physics_em_high_freq_view_max(s : PhysicsemhighfreqView) -> Double { @_common.max(s.data) }

pub fn physics_em_high_freq_view_to_string(s : PhysicsemhighfreqView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsemhighfreqRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_em_high_freq_range_make(size : Int) -> PhysicsemhighfreqRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_em_high_freq_range_len(s : PhysicsemhighfreqRange) -> Int { s.size }

pub fn physics_em_high_freq_range_get(s : PhysicsemhighfreqRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_em_high_freq_range_set(s : PhysicsemhighfreqRange, i : Int, v : Double) -> PhysicsemhighfreqRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn physics_em_high_freq_range_sum(s : PhysicsemhighfreqRange) -> Double { @_common.sum(s.data) }

pub fn physics_em_high_freq_range_mean(s : PhysicsemhighfreqRange) -> Double { @_common.mean(s.data) }

pub fn physics_em_high_freq_range_scale(s : PhysicsemhighfreqRange, f : Double) -> PhysicsemhighfreqRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_em_high_freq_range_add(a : PhysicsemhighfreqRange, b : PhysicsemhighfreqRange) -> PhysicsemhighfreqRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_em_high_freq_range_copy(s : PhysicsemhighfreqRange) -> PhysicsemhighfreqRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_em_high_freq_range_fill(s : PhysicsemhighfreqRange, v : Double) -> PhysicsemhighfreqRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_em_high_freq_range_min(s : PhysicsemhighfreqRange) -> Double { @_common.min(s.data) }

pub fn physics_em_high_freq_range_max(s : PhysicsemhighfreqRange) -> Double { @_common.max(s.data) }

pub fn physics_em_high_freq_range_to_string(s : PhysicsemhighfreqRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsemhighfreqSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_em_high_freq_slice_make(size : Int) -> PhysicsemhighfreqSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_em_high_freq_slice_len(s : PhysicsemhighfreqSlice) -> Int { s.size }

pub fn physics_em_high_freq_slice_get(s : PhysicsemhighfreqSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_em_high_freq_slice_set(s : PhysicsemhighfreqSlice, i : Int, v : Double) -> PhysicsemhighfreqSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn physics_em_high_freq_slice_sum(s : PhysicsemhighfreqSlice) -> Double { @_common.sum(s.data) }

pub fn physics_em_high_freq_slice_mean(s : PhysicsemhighfreqSlice) -> Double { @_common.mean(s.data) }

pub fn physics_em_high_freq_slice_scale(s : PhysicsemhighfreqSlice, f : Double) -> PhysicsemhighfreqSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_em_high_freq_slice_add(a : PhysicsemhighfreqSlice, b : PhysicsemhighfreqSlice) -> PhysicsemhighfreqSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_em_high_freq_slice_copy(s : PhysicsemhighfreqSlice) -> PhysicsemhighfreqSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_em_high_freq_slice_fill(s : PhysicsemhighfreqSlice, v : Double) -> PhysicsemhighfreqSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_em_high_freq_slice_min(s : PhysicsemhighfreqSlice) -> Double { @_common.min(s.data) }

pub fn physics_em_high_freq_slice_max(s : PhysicsemhighfreqSlice) -> Double { @_common.max(s.data) }

pub fn physics_em_high_freq_slice_to_string(s : PhysicsemhighfreqSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

