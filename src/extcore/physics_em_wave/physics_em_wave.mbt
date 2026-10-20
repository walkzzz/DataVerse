///===
/// extcore/physics_em_wave

pub(all) struct PhysicsemwavePoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn physics_em_wave_make_point(x : Double, y : Double) -> PhysicsemwavePoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn physics_em_wave_make_point3(x : Double, y : Double, z : Double) -> PhysicsemwavePoint {
  { x, y, z, label: 0 }
}

pub fn PhysicsemwavePoint::x(self : PhysicsemwavePoint) -> Double { self.x }

pub fn PhysicsemwavePoint::y(self : PhysicsemwavePoint) -> Double { self.y }

pub fn PhysicsemwavePoint::z(self : PhysicsemwavePoint) -> Double { self.z }

pub fn PhysicsemwavePoint::label(self : PhysicsemwavePoint) -> Int { self.label }

pub fn PhysicsemwavePoint::dist(self : PhysicsemwavePoint, other : PhysicsemwavePoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn PhysicsemwavePoint::add(self : PhysicsemwavePoint, other : PhysicsemwavePoint) -> PhysicsemwavePoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn PhysicsemwavePoint::sub(self : PhysicsemwavePoint, other : PhysicsemwavePoint) -> PhysicsemwavePoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn PhysicsemwavePoint::scale(self : PhysicsemwavePoint, s : Double) -> PhysicsemwavePoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn PhysicsemwavePoint::dot(self : PhysicsemwavePoint, other : PhysicsemwavePoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn PhysicsemwavePoint::cross(self : PhysicsemwavePoint, other : PhysicsemwavePoint) -> PhysicsemwavePoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn PhysicsemwavePoint::norm(self : PhysicsemwavePoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn PhysicsemwavePoint::normalize(self : PhysicsemwavePoint) -> PhysicsemwavePoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn PhysicsemwavePoint::negate(self : PhysicsemwavePoint) -> PhysicsemwavePoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn PhysicsemwavePoint::mid(self : PhysicsemwavePoint, other : PhysicsemwavePoint) -> PhysicsemwavePoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn PhysicsemwavePoint::lerp(self : PhysicsemwavePoint, other : PhysicsemwavePoint, t : Double) -> PhysicsemwavePoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn PhysicsemwavePoint::to_string(self : PhysicsemwavePoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct PhysicsemwaveSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn physics_em_wave_make_series(vals : Array[Double], name : String) -> PhysicsemwaveSeries {
  { vals, name, meta: 0 }
}

pub fn PhysicsemwaveSeries::len(self : PhysicsemwaveSeries) -> Int { self.vals.length() }

pub fn PhysicsemwaveSeries::sum(self : PhysicsemwaveSeries) -> Double { @_common.sum(self.vals) }

pub fn PhysicsemwaveSeries::mean(self : PhysicsemwaveSeries) -> Double { @_common.mean(self.vals) }

pub fn PhysicsemwaveSeries::min(self : PhysicsemwaveSeries) -> Double { @_common.min(self.vals) }

pub fn PhysicsemwaveSeries::max(self : PhysicsemwaveSeries) -> Double { @_common.max(self.vals) }

pub fn PhysicsemwaveSeries::range(self : PhysicsemwaveSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn PhysicsemwaveSeries::variance(self : PhysicsemwaveSeries) -> Double { @_common.variance(self.vals) }

pub fn PhysicsemwaveSeries::std(self : PhysicsemwaveSeries) -> Double { @_common.std(self.vals) }

pub fn PhysicsemwaveSeries::median(self : PhysicsemwaveSeries) -> Double { @_common.median(self.vals) }

pub fn PhysicsemwaveSeries::scale(self : PhysicsemwaveSeries, f : Double) -> PhysicsemwaveSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn PhysicsemwaveSeries::add(self : PhysicsemwaveSeries, other : PhysicsemwaveSeries) -> PhysicsemwaveSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn PhysicsemwaveSeries::sub(self : PhysicsemwaveSeries, other : PhysicsemwaveSeries) -> PhysicsemwaveSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn PhysicsemwaveSeries::normalize(self : PhysicsemwaveSeries) -> PhysicsemwaveSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn PhysicsemwaveSeries::cumsum(self : PhysicsemwaveSeries) -> PhysicsemwaveSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn PhysicsemwaveSeries::to_string(self : PhysicsemwaveSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct PhysicsemwaveMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn physics_em_wave_make_matrix(rows : Int, cols : Int, val : Double) -> PhysicsemwaveMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn physics_em_wave_matrix_identity(n : Int) -> PhysicsemwaveMatrix {
  let m = physics_em_wave_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn PhysicsemwaveMatrix::get(self : PhysicsemwaveMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn PhysicsemwaveMatrix::transpose(self : PhysicsemwaveMatrix) -> PhysicsemwaveMatrix {
  let result = physics_em_wave_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn PhysicsemwaveMatrix::add(self : PhysicsemwaveMatrix, other : PhysicsemwaveMatrix) -> PhysicsemwaveMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = physics_em_wave_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn PhysicsemwaveMatrix::scale(self : PhysicsemwaveMatrix, s : Double) -> PhysicsemwaveMatrix {
  let result = physics_em_wave_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn PhysicsemwaveMatrix::multiply(self : PhysicsemwaveMatrix, other : PhysicsemwaveMatrix) -> PhysicsemwaveMatrix {
  if self.cols != other.rows { return physics_em_wave_make_matrix(self.rows, other.cols, 0.0) }
  let result = physics_em_wave_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn PhysicsemwaveMatrix::trace(self : PhysicsemwaveMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn PhysicsemwaveMatrix::det(self : PhysicsemwaveMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn PhysicsemwaveMatrix::norm(self : PhysicsemwaveMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn PhysicsemwaveMatrix::to_string(self : PhysicsemwaveMatrix) -> String {
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

pub(all) struct PhysicsemwaveVector {
  comps : Array[Double]
  dim : Int
}

pub fn physics_em_wave_make_vector(comps : Array[Double]) -> PhysicsemwaveVector {
  { comps, dim: comps.length() }
}

pub fn physics_em_wave_vector_zero(dim : Int) -> PhysicsemwaveVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn PhysicsemwaveVector::add(self : PhysicsemwaveVector, other : PhysicsemwaveVector) -> PhysicsemwaveVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn PhysicsemwaveVector::sub(self : PhysicsemwaveVector, other : PhysicsemwaveVector) -> PhysicsemwaveVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn PhysicsemwaveVector::scale(self : PhysicsemwaveVector, s : Double) -> PhysicsemwaveVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn PhysicsemwaveVector::dot(self : PhysicsemwaveVector, other : PhysicsemwaveVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn PhysicsemwaveVector::norm(self : PhysicsemwaveVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn PhysicsemwaveVector::normalize(self : PhysicsemwaveVector) -> PhysicsemwaveVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn PhysicsemwaveVector::dist(self : PhysicsemwaveVector, other : PhysicsemwaveVector) -> Double {
  self.sub(other).norm()
}

pub fn PhysicsemwaveVector::to_string(self : PhysicsemwaveVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn physics_em_wave_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn physics_em_wave_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn physics_em_wave_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn physics_em_wave_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn physics_em_wave_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn physics_em_wave_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn physics_em_wave_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn physics_em_wave_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn physics_em_wave_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn physics_em_wave_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn physics_em_wave_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn physics_em_wave_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn physics_em_wave_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn physics_em_wave_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn physics_em_wave_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn physics_em_wave_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn physics_em_wave_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn physics_em_wave_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn physics_em_wave_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn physics_em_wave_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn physics_em_wave_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn physics_em_wave_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn physics_em_wave_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn physics_em_wave_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn physics_em_wave_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn physics_em_wave_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn physics_em_wave_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn physics_em_wave_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn physics_em_wave_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct PhysicsemwaveFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_em_wave_frame_make(size : Int) -> PhysicsemwaveFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_em_wave_frame_len(s : PhysicsemwaveFrame) -> Int { s.size }

pub fn physics_em_wave_frame_get(s : PhysicsemwaveFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_em_wave_frame_set(s : PhysicsemwaveFrame, i : Int, v : Double) -> PhysicsemwaveFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn physics_em_wave_frame_sum(s : PhysicsemwaveFrame) -> Double { @_common.sum(s.data) }

pub fn physics_em_wave_frame_mean(s : PhysicsemwaveFrame) -> Double { @_common.mean(s.data) }

pub fn physics_em_wave_frame_scale(s : PhysicsemwaveFrame, f : Double) -> PhysicsemwaveFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_em_wave_frame_add(a : PhysicsemwaveFrame, b : PhysicsemwaveFrame) -> PhysicsemwaveFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_em_wave_frame_copy(s : PhysicsemwaveFrame) -> PhysicsemwaveFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_em_wave_frame_fill(s : PhysicsemwaveFrame, v : Double) -> PhysicsemwaveFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_em_wave_frame_min(s : PhysicsemwaveFrame) -> Double { @_common.min(s.data) }

pub fn physics_em_wave_frame_max(s : PhysicsemwaveFrame) -> Double { @_common.max(s.data) }

pub fn physics_em_wave_frame_to_string(s : PhysicsemwaveFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsemwaveTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_em_wave_table_make(size : Int) -> PhysicsemwaveTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_em_wave_table_len(s : PhysicsemwaveTable) -> Int { s.size }

pub fn physics_em_wave_table_get(s : PhysicsemwaveTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_em_wave_table_set(s : PhysicsemwaveTable, i : Int, v : Double) -> PhysicsemwaveTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn physics_em_wave_table_sum(s : PhysicsemwaveTable) -> Double { @_common.sum(s.data) }

pub fn physics_em_wave_table_mean(s : PhysicsemwaveTable) -> Double { @_common.mean(s.data) }

pub fn physics_em_wave_table_scale(s : PhysicsemwaveTable, f : Double) -> PhysicsemwaveTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_em_wave_table_add(a : PhysicsemwaveTable, b : PhysicsemwaveTable) -> PhysicsemwaveTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_em_wave_table_copy(s : PhysicsemwaveTable) -> PhysicsemwaveTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_em_wave_table_fill(s : PhysicsemwaveTable, v : Double) -> PhysicsemwaveTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_em_wave_table_min(s : PhysicsemwaveTable) -> Double { @_common.min(s.data) }

pub fn physics_em_wave_table_max(s : PhysicsemwaveTable) -> Double { @_common.max(s.data) }

pub fn physics_em_wave_table_to_string(s : PhysicsemwaveTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsemwaveGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_em_wave_graphn_make(size : Int) -> PhysicsemwaveGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_em_wave_graphn_len(s : PhysicsemwaveGraphN) -> Int { s.size }

pub fn physics_em_wave_graphn_get(s : PhysicsemwaveGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_em_wave_graphn_set(s : PhysicsemwaveGraphN, i : Int, v : Double) -> PhysicsemwaveGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn physics_em_wave_graphn_sum(s : PhysicsemwaveGraphN) -> Double { @_common.sum(s.data) }

pub fn physics_em_wave_graphn_mean(s : PhysicsemwaveGraphN) -> Double { @_common.mean(s.data) }

pub fn physics_em_wave_graphn_scale(s : PhysicsemwaveGraphN, f : Double) -> PhysicsemwaveGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_em_wave_graphn_add(a : PhysicsemwaveGraphN, b : PhysicsemwaveGraphN) -> PhysicsemwaveGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_em_wave_graphn_copy(s : PhysicsemwaveGraphN) -> PhysicsemwaveGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_em_wave_graphn_fill(s : PhysicsemwaveGraphN, v : Double) -> PhysicsemwaveGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_em_wave_graphn_min(s : PhysicsemwaveGraphN) -> Double { @_common.min(s.data) }

pub fn physics_em_wave_graphn_max(s : PhysicsemwaveGraphN) -> Double { @_common.max(s.data) }

pub fn physics_em_wave_graphn_to_string(s : PhysicsemwaveGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsemwaveNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_em_wave_node_make(size : Int) -> PhysicsemwaveNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_em_wave_node_len(s : PhysicsemwaveNode) -> Int { s.size }

pub fn physics_em_wave_node_get(s : PhysicsemwaveNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_em_wave_node_set(s : PhysicsemwaveNode, i : Int, v : Double) -> PhysicsemwaveNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn physics_em_wave_node_sum(s : PhysicsemwaveNode) -> Double { @_common.sum(s.data) }

pub fn physics_em_wave_node_mean(s : PhysicsemwaveNode) -> Double { @_common.mean(s.data) }

pub fn physics_em_wave_node_scale(s : PhysicsemwaveNode, f : Double) -> PhysicsemwaveNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_em_wave_node_add(a : PhysicsemwaveNode, b : PhysicsemwaveNode) -> PhysicsemwaveNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_em_wave_node_copy(s : PhysicsemwaveNode) -> PhysicsemwaveNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_em_wave_node_fill(s : PhysicsemwaveNode, v : Double) -> PhysicsemwaveNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_em_wave_node_min(s : PhysicsemwaveNode) -> Double { @_common.min(s.data) }

pub fn physics_em_wave_node_max(s : PhysicsemwaveNode) -> Double { @_common.max(s.data) }

pub fn physics_em_wave_node_to_string(s : PhysicsemwaveNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsemwaveEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_em_wave_edge_make(size : Int) -> PhysicsemwaveEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_em_wave_edge_len(s : PhysicsemwaveEdge) -> Int { s.size }

pub fn physics_em_wave_edge_get(s : PhysicsemwaveEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_em_wave_edge_set(s : PhysicsemwaveEdge, i : Int, v : Double) -> PhysicsemwaveEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn physics_em_wave_edge_sum(s : PhysicsemwaveEdge) -> Double { @_common.sum(s.data) }

pub fn physics_em_wave_edge_mean(s : PhysicsemwaveEdge) -> Double { @_common.mean(s.data) }

pub fn physics_em_wave_edge_scale(s : PhysicsemwaveEdge, f : Double) -> PhysicsemwaveEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_em_wave_edge_add(a : PhysicsemwaveEdge, b : PhysicsemwaveEdge) -> PhysicsemwaveEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_em_wave_edge_copy(s : PhysicsemwaveEdge) -> PhysicsemwaveEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_em_wave_edge_fill(s : PhysicsemwaveEdge, v : Double) -> PhysicsemwaveEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_em_wave_edge_min(s : PhysicsemwaveEdge) -> Double { @_common.min(s.data) }

pub fn physics_em_wave_edge_max(s : PhysicsemwaveEdge) -> Double { @_common.max(s.data) }

pub fn physics_em_wave_edge_to_string(s : PhysicsemwaveEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsemwavePath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_em_wave_path_make(size : Int) -> PhysicsemwavePath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_em_wave_path_len(s : PhysicsemwavePath) -> Int { s.size }

pub fn physics_em_wave_path_get(s : PhysicsemwavePath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_em_wave_path_set(s : PhysicsemwavePath, i : Int, v : Double) -> PhysicsemwavePath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn physics_em_wave_path_sum(s : PhysicsemwavePath) -> Double { @_common.sum(s.data) }

pub fn physics_em_wave_path_mean(s : PhysicsemwavePath) -> Double { @_common.mean(s.data) }

pub fn physics_em_wave_path_scale(s : PhysicsemwavePath, f : Double) -> PhysicsemwavePath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_em_wave_path_add(a : PhysicsemwavePath, b : PhysicsemwavePath) -> PhysicsemwavePath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_em_wave_path_copy(s : PhysicsemwavePath) -> PhysicsemwavePath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_em_wave_path_fill(s : PhysicsemwavePath, v : Double) -> PhysicsemwavePath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_em_wave_path_min(s : PhysicsemwavePath) -> Double { @_common.min(s.data) }

pub fn physics_em_wave_path_max(s : PhysicsemwavePath) -> Double { @_common.max(s.data) }

pub fn physics_em_wave_path_to_string(s : PhysicsemwavePath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsemwaveCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_em_wave_cluster_make(size : Int) -> PhysicsemwaveCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_em_wave_cluster_len(s : PhysicsemwaveCluster) -> Int { s.size }

pub fn physics_em_wave_cluster_get(s : PhysicsemwaveCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_em_wave_cluster_set(s : PhysicsemwaveCluster, i : Int, v : Double) -> PhysicsemwaveCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn physics_em_wave_cluster_sum(s : PhysicsemwaveCluster) -> Double { @_common.sum(s.data) }

pub fn physics_em_wave_cluster_mean(s : PhysicsemwaveCluster) -> Double { @_common.mean(s.data) }

pub fn physics_em_wave_cluster_scale(s : PhysicsemwaveCluster, f : Double) -> PhysicsemwaveCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_em_wave_cluster_add(a : PhysicsemwaveCluster, b : PhysicsemwaveCluster) -> PhysicsemwaveCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_em_wave_cluster_copy(s : PhysicsemwaveCluster) -> PhysicsemwaveCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_em_wave_cluster_fill(s : PhysicsemwaveCluster, v : Double) -> PhysicsemwaveCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_em_wave_cluster_min(s : PhysicsemwaveCluster) -> Double { @_common.min(s.data) }

pub fn physics_em_wave_cluster_max(s : PhysicsemwaveCluster) -> Double { @_common.max(s.data) }

pub fn physics_em_wave_cluster_to_string(s : PhysicsemwaveCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsemwaveModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_em_wave_model_make(size : Int) -> PhysicsemwaveModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_em_wave_model_len(s : PhysicsemwaveModel) -> Int { s.size }

pub fn physics_em_wave_model_get(s : PhysicsemwaveModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_em_wave_model_set(s : PhysicsemwaveModel, i : Int, v : Double) -> PhysicsemwaveModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn physics_em_wave_model_sum(s : PhysicsemwaveModel) -> Double { @_common.sum(s.data) }

pub fn physics_em_wave_model_mean(s : PhysicsemwaveModel) -> Double { @_common.mean(s.data) }

pub fn physics_em_wave_model_scale(s : PhysicsemwaveModel, f : Double) -> PhysicsemwaveModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_em_wave_model_add(a : PhysicsemwaveModel, b : PhysicsemwaveModel) -> PhysicsemwaveModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_em_wave_model_copy(s : PhysicsemwaveModel) -> PhysicsemwaveModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_em_wave_model_fill(s : PhysicsemwaveModel, v : Double) -> PhysicsemwaveModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_em_wave_model_min(s : PhysicsemwaveModel) -> Double { @_common.min(s.data) }

pub fn physics_em_wave_model_max(s : PhysicsemwaveModel) -> Double { @_common.max(s.data) }

pub fn physics_em_wave_model_to_string(s : PhysicsemwaveModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsemwaveLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_em_wave_layer_make(size : Int) -> PhysicsemwaveLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_em_wave_layer_len(s : PhysicsemwaveLayer) -> Int { s.size }

pub fn physics_em_wave_layer_get(s : PhysicsemwaveLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_em_wave_layer_set(s : PhysicsemwaveLayer, i : Int, v : Double) -> PhysicsemwaveLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn physics_em_wave_layer_sum(s : PhysicsemwaveLayer) -> Double { @_common.sum(s.data) }

pub fn physics_em_wave_layer_mean(s : PhysicsemwaveLayer) -> Double { @_common.mean(s.data) }

pub fn physics_em_wave_layer_scale(s : PhysicsemwaveLayer, f : Double) -> PhysicsemwaveLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_em_wave_layer_add(a : PhysicsemwaveLayer, b : PhysicsemwaveLayer) -> PhysicsemwaveLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_em_wave_layer_copy(s : PhysicsemwaveLayer) -> PhysicsemwaveLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_em_wave_layer_fill(s : PhysicsemwaveLayer, v : Double) -> PhysicsemwaveLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_em_wave_layer_min(s : PhysicsemwaveLayer) -> Double { @_common.min(s.data) }

pub fn physics_em_wave_layer_max(s : PhysicsemwaveLayer) -> Double { @_common.max(s.data) }

pub fn physics_em_wave_layer_to_string(s : PhysicsemwaveLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsemwaveBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_em_wave_buffer_make(size : Int) -> PhysicsemwaveBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_em_wave_buffer_len(s : PhysicsemwaveBuffer) -> Int { s.size }

pub fn physics_em_wave_buffer_get(s : PhysicsemwaveBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_em_wave_buffer_set(s : PhysicsemwaveBuffer, i : Int, v : Double) -> PhysicsemwaveBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn physics_em_wave_buffer_sum(s : PhysicsemwaveBuffer) -> Double { @_common.sum(s.data) }

pub fn physics_em_wave_buffer_mean(s : PhysicsemwaveBuffer) -> Double { @_common.mean(s.data) }

pub fn physics_em_wave_buffer_scale(s : PhysicsemwaveBuffer, f : Double) -> PhysicsemwaveBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_em_wave_buffer_add(a : PhysicsemwaveBuffer, b : PhysicsemwaveBuffer) -> PhysicsemwaveBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_em_wave_buffer_copy(s : PhysicsemwaveBuffer) -> PhysicsemwaveBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_em_wave_buffer_fill(s : PhysicsemwaveBuffer, v : Double) -> PhysicsemwaveBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_em_wave_buffer_min(s : PhysicsemwaveBuffer) -> Double { @_common.min(s.data) }

pub fn physics_em_wave_buffer_max(s : PhysicsemwaveBuffer) -> Double { @_common.max(s.data) }

pub fn physics_em_wave_buffer_to_string(s : PhysicsemwaveBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsemwaveCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_em_wave_cursor_make(size : Int) -> PhysicsemwaveCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_em_wave_cursor_len(s : PhysicsemwaveCursor) -> Int { s.size }

pub fn physics_em_wave_cursor_get(s : PhysicsemwaveCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_em_wave_cursor_set(s : PhysicsemwaveCursor, i : Int, v : Double) -> PhysicsemwaveCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn physics_em_wave_cursor_sum(s : PhysicsemwaveCursor) -> Double { @_common.sum(s.data) }

pub fn physics_em_wave_cursor_mean(s : PhysicsemwaveCursor) -> Double { @_common.mean(s.data) }

pub fn physics_em_wave_cursor_scale(s : PhysicsemwaveCursor, f : Double) -> PhysicsemwaveCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_em_wave_cursor_add(a : PhysicsemwaveCursor, b : PhysicsemwaveCursor) -> PhysicsemwaveCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_em_wave_cursor_copy(s : PhysicsemwaveCursor) -> PhysicsemwaveCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_em_wave_cursor_fill(s : PhysicsemwaveCursor, v : Double) -> PhysicsemwaveCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_em_wave_cursor_min(s : PhysicsemwaveCursor) -> Double { @_common.min(s.data) }

pub fn physics_em_wave_cursor_max(s : PhysicsemwaveCursor) -> Double { @_common.max(s.data) }

pub fn physics_em_wave_cursor_to_string(s : PhysicsemwaveCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsemwaveView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_em_wave_view_make(size : Int) -> PhysicsemwaveView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_em_wave_view_len(s : PhysicsemwaveView) -> Int { s.size }

pub fn physics_em_wave_view_get(s : PhysicsemwaveView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_em_wave_view_set(s : PhysicsemwaveView, i : Int, v : Double) -> PhysicsemwaveView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn physics_em_wave_view_sum(s : PhysicsemwaveView) -> Double { @_common.sum(s.data) }

pub fn physics_em_wave_view_mean(s : PhysicsemwaveView) -> Double { @_common.mean(s.data) }

pub fn physics_em_wave_view_scale(s : PhysicsemwaveView, f : Double) -> PhysicsemwaveView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_em_wave_view_add(a : PhysicsemwaveView, b : PhysicsemwaveView) -> PhysicsemwaveView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_em_wave_view_copy(s : PhysicsemwaveView) -> PhysicsemwaveView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_em_wave_view_fill(s : PhysicsemwaveView, v : Double) -> PhysicsemwaveView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_em_wave_view_min(s : PhysicsemwaveView) -> Double { @_common.min(s.data) }

pub fn physics_em_wave_view_max(s : PhysicsemwaveView) -> Double { @_common.max(s.data) }

pub fn physics_em_wave_view_to_string(s : PhysicsemwaveView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsemwaveRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_em_wave_range_make(size : Int) -> PhysicsemwaveRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_em_wave_range_len(s : PhysicsemwaveRange) -> Int { s.size }

pub fn physics_em_wave_range_get(s : PhysicsemwaveRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_em_wave_range_set(s : PhysicsemwaveRange, i : Int, v : Double) -> PhysicsemwaveRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn physics_em_wave_range_sum(s : PhysicsemwaveRange) -> Double { @_common.sum(s.data) }

pub fn physics_em_wave_range_mean(s : PhysicsemwaveRange) -> Double { @_common.mean(s.data) }

pub fn physics_em_wave_range_scale(s : PhysicsemwaveRange, f : Double) -> PhysicsemwaveRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_em_wave_range_add(a : PhysicsemwaveRange, b : PhysicsemwaveRange) -> PhysicsemwaveRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_em_wave_range_copy(s : PhysicsemwaveRange) -> PhysicsemwaveRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_em_wave_range_fill(s : PhysicsemwaveRange, v : Double) -> PhysicsemwaveRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_em_wave_range_min(s : PhysicsemwaveRange) -> Double { @_common.min(s.data) }

pub fn physics_em_wave_range_max(s : PhysicsemwaveRange) -> Double { @_common.max(s.data) }

pub fn physics_em_wave_range_to_string(s : PhysicsemwaveRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsemwaveSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_em_wave_slice_make(size : Int) -> PhysicsemwaveSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_em_wave_slice_len(s : PhysicsemwaveSlice) -> Int { s.size }

pub fn physics_em_wave_slice_get(s : PhysicsemwaveSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_em_wave_slice_set(s : PhysicsemwaveSlice, i : Int, v : Double) -> PhysicsemwaveSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn physics_em_wave_slice_sum(s : PhysicsemwaveSlice) -> Double { @_common.sum(s.data) }

pub fn physics_em_wave_slice_mean(s : PhysicsemwaveSlice) -> Double { @_common.mean(s.data) }

pub fn physics_em_wave_slice_scale(s : PhysicsemwaveSlice, f : Double) -> PhysicsemwaveSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_em_wave_slice_add(a : PhysicsemwaveSlice, b : PhysicsemwaveSlice) -> PhysicsemwaveSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_em_wave_slice_copy(s : PhysicsemwaveSlice) -> PhysicsemwaveSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_em_wave_slice_fill(s : PhysicsemwaveSlice, v : Double) -> PhysicsemwaveSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_em_wave_slice_min(s : PhysicsemwaveSlice) -> Double { @_common.min(s.data) }

pub fn physics_em_wave_slice_max(s : PhysicsemwaveSlice) -> Double { @_common.max(s.data) }

pub fn physics_em_wave_slice_to_string(s : PhysicsemwaveSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

