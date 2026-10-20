///===
/// extcore/physics_mechanics_rigid

pub(all) struct PhysicsmechanicsrigidPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn physics_mechanics_rigid_make_point(x : Double, y : Double) -> PhysicsmechanicsrigidPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn physics_mechanics_rigid_make_point3(x : Double, y : Double, z : Double) -> PhysicsmechanicsrigidPoint {
  { x, y, z, label: 0 }
}

pub fn PhysicsmechanicsrigidPoint::x(self : PhysicsmechanicsrigidPoint) -> Double { self.x }

pub fn PhysicsmechanicsrigidPoint::y(self : PhysicsmechanicsrigidPoint) -> Double { self.y }

pub fn PhysicsmechanicsrigidPoint::z(self : PhysicsmechanicsrigidPoint) -> Double { self.z }

pub fn PhysicsmechanicsrigidPoint::label(self : PhysicsmechanicsrigidPoint) -> Int { self.label }

pub fn PhysicsmechanicsrigidPoint::dist(self : PhysicsmechanicsrigidPoint, other : PhysicsmechanicsrigidPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn PhysicsmechanicsrigidPoint::add(self : PhysicsmechanicsrigidPoint, other : PhysicsmechanicsrigidPoint) -> PhysicsmechanicsrigidPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn PhysicsmechanicsrigidPoint::sub(self : PhysicsmechanicsrigidPoint, other : PhysicsmechanicsrigidPoint) -> PhysicsmechanicsrigidPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn PhysicsmechanicsrigidPoint::scale(self : PhysicsmechanicsrigidPoint, s : Double) -> PhysicsmechanicsrigidPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn PhysicsmechanicsrigidPoint::dot(self : PhysicsmechanicsrigidPoint, other : PhysicsmechanicsrigidPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn PhysicsmechanicsrigidPoint::cross(self : PhysicsmechanicsrigidPoint, other : PhysicsmechanicsrigidPoint) -> PhysicsmechanicsrigidPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn PhysicsmechanicsrigidPoint::norm(self : PhysicsmechanicsrigidPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn PhysicsmechanicsrigidPoint::normalize(self : PhysicsmechanicsrigidPoint) -> PhysicsmechanicsrigidPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn PhysicsmechanicsrigidPoint::negate(self : PhysicsmechanicsrigidPoint) -> PhysicsmechanicsrigidPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn PhysicsmechanicsrigidPoint::mid(self : PhysicsmechanicsrigidPoint, other : PhysicsmechanicsrigidPoint) -> PhysicsmechanicsrigidPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn PhysicsmechanicsrigidPoint::lerp(self : PhysicsmechanicsrigidPoint, other : PhysicsmechanicsrigidPoint, t : Double) -> PhysicsmechanicsrigidPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn PhysicsmechanicsrigidPoint::to_string(self : PhysicsmechanicsrigidPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct PhysicsmechanicsrigidSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn physics_mechanics_rigid_make_series(vals : Array[Double], name : String) -> PhysicsmechanicsrigidSeries {
  { vals, name, meta: 0 }
}

pub fn PhysicsmechanicsrigidSeries::len(self : PhysicsmechanicsrigidSeries) -> Int { self.vals.length() }

pub fn PhysicsmechanicsrigidSeries::sum(self : PhysicsmechanicsrigidSeries) -> Double { @_common.sum(self.vals) }

pub fn PhysicsmechanicsrigidSeries::mean(self : PhysicsmechanicsrigidSeries) -> Double { @_common.mean(self.vals) }

pub fn PhysicsmechanicsrigidSeries::min(self : PhysicsmechanicsrigidSeries) -> Double { @_common.min(self.vals) }

pub fn PhysicsmechanicsrigidSeries::max(self : PhysicsmechanicsrigidSeries) -> Double { @_common.max(self.vals) }

pub fn PhysicsmechanicsrigidSeries::range(self : PhysicsmechanicsrigidSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn PhysicsmechanicsrigidSeries::variance(self : PhysicsmechanicsrigidSeries) -> Double { @_common.variance(self.vals) }

pub fn PhysicsmechanicsrigidSeries::std(self : PhysicsmechanicsrigidSeries) -> Double { @_common.std(self.vals) }

pub fn PhysicsmechanicsrigidSeries::median(self : PhysicsmechanicsrigidSeries) -> Double { @_common.median(self.vals) }

pub fn PhysicsmechanicsrigidSeries::scale(self : PhysicsmechanicsrigidSeries, f : Double) -> PhysicsmechanicsrigidSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn PhysicsmechanicsrigidSeries::add(self : PhysicsmechanicsrigidSeries, other : PhysicsmechanicsrigidSeries) -> PhysicsmechanicsrigidSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn PhysicsmechanicsrigidSeries::sub(self : PhysicsmechanicsrigidSeries, other : PhysicsmechanicsrigidSeries) -> PhysicsmechanicsrigidSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn PhysicsmechanicsrigidSeries::normalize(self : PhysicsmechanicsrigidSeries) -> PhysicsmechanicsrigidSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn PhysicsmechanicsrigidSeries::cumsum(self : PhysicsmechanicsrigidSeries) -> PhysicsmechanicsrigidSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn PhysicsmechanicsrigidSeries::to_string(self : PhysicsmechanicsrigidSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct PhysicsmechanicsrigidMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn physics_mechanics_rigid_make_matrix(rows : Int, cols : Int, val : Double) -> PhysicsmechanicsrigidMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn physics_mechanics_rigid_matrix_identity(n : Int) -> PhysicsmechanicsrigidMatrix {
  let m = physics_mechanics_rigid_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn PhysicsmechanicsrigidMatrix::get(self : PhysicsmechanicsrigidMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn PhysicsmechanicsrigidMatrix::transpose(self : PhysicsmechanicsrigidMatrix) -> PhysicsmechanicsrigidMatrix {
  let result = physics_mechanics_rigid_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn PhysicsmechanicsrigidMatrix::add(self : PhysicsmechanicsrigidMatrix, other : PhysicsmechanicsrigidMatrix) -> PhysicsmechanicsrigidMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = physics_mechanics_rigid_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn PhysicsmechanicsrigidMatrix::scale(self : PhysicsmechanicsrigidMatrix, s : Double) -> PhysicsmechanicsrigidMatrix {
  let result = physics_mechanics_rigid_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn PhysicsmechanicsrigidMatrix::multiply(self : PhysicsmechanicsrigidMatrix, other : PhysicsmechanicsrigidMatrix) -> PhysicsmechanicsrigidMatrix {
  if self.cols != other.rows { return physics_mechanics_rigid_make_matrix(self.rows, other.cols, 0.0) }
  let result = physics_mechanics_rigid_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn PhysicsmechanicsrigidMatrix::trace(self : PhysicsmechanicsrigidMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn PhysicsmechanicsrigidMatrix::det(self : PhysicsmechanicsrigidMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn PhysicsmechanicsrigidMatrix::norm(self : PhysicsmechanicsrigidMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn PhysicsmechanicsrigidMatrix::to_string(self : PhysicsmechanicsrigidMatrix) -> String {
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

pub(all) struct PhysicsmechanicsrigidVector {
  comps : Array[Double]
  dim : Int
}

pub fn physics_mechanics_rigid_make_vector(comps : Array[Double]) -> PhysicsmechanicsrigidVector {
  { comps, dim: comps.length() }
}

pub fn physics_mechanics_rigid_vector_zero(dim : Int) -> PhysicsmechanicsrigidVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn PhysicsmechanicsrigidVector::add(self : PhysicsmechanicsrigidVector, other : PhysicsmechanicsrigidVector) -> PhysicsmechanicsrigidVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn PhysicsmechanicsrigidVector::sub(self : PhysicsmechanicsrigidVector, other : PhysicsmechanicsrigidVector) -> PhysicsmechanicsrigidVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn PhysicsmechanicsrigidVector::scale(self : PhysicsmechanicsrigidVector, s : Double) -> PhysicsmechanicsrigidVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn PhysicsmechanicsrigidVector::dot(self : PhysicsmechanicsrigidVector, other : PhysicsmechanicsrigidVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn PhysicsmechanicsrigidVector::norm(self : PhysicsmechanicsrigidVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn PhysicsmechanicsrigidVector::normalize(self : PhysicsmechanicsrigidVector) -> PhysicsmechanicsrigidVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn PhysicsmechanicsrigidVector::dist(self : PhysicsmechanicsrigidVector, other : PhysicsmechanicsrigidVector) -> Double {
  self.sub(other).norm()
}

pub fn PhysicsmechanicsrigidVector::to_string(self : PhysicsmechanicsrigidVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn physics_mechanics_rigid_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn physics_mechanics_rigid_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn physics_mechanics_rigid_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn physics_mechanics_rigid_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn physics_mechanics_rigid_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn physics_mechanics_rigid_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn physics_mechanics_rigid_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn physics_mechanics_rigid_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn physics_mechanics_rigid_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn physics_mechanics_rigid_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn physics_mechanics_rigid_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn physics_mechanics_rigid_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn physics_mechanics_rigid_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn physics_mechanics_rigid_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn physics_mechanics_rigid_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn physics_mechanics_rigid_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn physics_mechanics_rigid_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn physics_mechanics_rigid_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn physics_mechanics_rigid_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn physics_mechanics_rigid_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn physics_mechanics_rigid_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn physics_mechanics_rigid_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn physics_mechanics_rigid_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn physics_mechanics_rigid_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn physics_mechanics_rigid_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn physics_mechanics_rigid_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn physics_mechanics_rigid_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn physics_mechanics_rigid_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn physics_mechanics_rigid_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct PhysicsmechanicsrigidFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_mechanics_rigid_frame_make(size : Int) -> PhysicsmechanicsrigidFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_mechanics_rigid_frame_len(s : PhysicsmechanicsrigidFrame) -> Int { s.size }

pub fn physics_mechanics_rigid_frame_get(s : PhysicsmechanicsrigidFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_mechanics_rigid_frame_set(s : PhysicsmechanicsrigidFrame, i : Int, v : Double) -> PhysicsmechanicsrigidFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn physics_mechanics_rigid_frame_sum(s : PhysicsmechanicsrigidFrame) -> Double { @_common.sum(s.data) }

pub fn physics_mechanics_rigid_frame_mean(s : PhysicsmechanicsrigidFrame) -> Double { @_common.mean(s.data) }

pub fn physics_mechanics_rigid_frame_scale(s : PhysicsmechanicsrigidFrame, f : Double) -> PhysicsmechanicsrigidFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_mechanics_rigid_frame_add(a : PhysicsmechanicsrigidFrame, b : PhysicsmechanicsrigidFrame) -> PhysicsmechanicsrigidFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_mechanics_rigid_frame_copy(s : PhysicsmechanicsrigidFrame) -> PhysicsmechanicsrigidFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_mechanics_rigid_frame_fill(s : PhysicsmechanicsrigidFrame, v : Double) -> PhysicsmechanicsrigidFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_mechanics_rigid_frame_min(s : PhysicsmechanicsrigidFrame) -> Double { @_common.min(s.data) }

pub fn physics_mechanics_rigid_frame_max(s : PhysicsmechanicsrigidFrame) -> Double { @_common.max(s.data) }

pub fn physics_mechanics_rigid_frame_to_string(s : PhysicsmechanicsrigidFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsmechanicsrigidTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_mechanics_rigid_table_make(size : Int) -> PhysicsmechanicsrigidTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_mechanics_rigid_table_len(s : PhysicsmechanicsrigidTable) -> Int { s.size }

pub fn physics_mechanics_rigid_table_get(s : PhysicsmechanicsrigidTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_mechanics_rigid_table_set(s : PhysicsmechanicsrigidTable, i : Int, v : Double) -> PhysicsmechanicsrigidTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn physics_mechanics_rigid_table_sum(s : PhysicsmechanicsrigidTable) -> Double { @_common.sum(s.data) }

pub fn physics_mechanics_rigid_table_mean(s : PhysicsmechanicsrigidTable) -> Double { @_common.mean(s.data) }

pub fn physics_mechanics_rigid_table_scale(s : PhysicsmechanicsrigidTable, f : Double) -> PhysicsmechanicsrigidTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_mechanics_rigid_table_add(a : PhysicsmechanicsrigidTable, b : PhysicsmechanicsrigidTable) -> PhysicsmechanicsrigidTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_mechanics_rigid_table_copy(s : PhysicsmechanicsrigidTable) -> PhysicsmechanicsrigidTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_mechanics_rigid_table_fill(s : PhysicsmechanicsrigidTable, v : Double) -> PhysicsmechanicsrigidTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_mechanics_rigid_table_min(s : PhysicsmechanicsrigidTable) -> Double { @_common.min(s.data) }

pub fn physics_mechanics_rigid_table_max(s : PhysicsmechanicsrigidTable) -> Double { @_common.max(s.data) }

pub fn physics_mechanics_rigid_table_to_string(s : PhysicsmechanicsrigidTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsmechanicsrigidGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_mechanics_rigid_graphn_make(size : Int) -> PhysicsmechanicsrigidGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_mechanics_rigid_graphn_len(s : PhysicsmechanicsrigidGraphN) -> Int { s.size }

pub fn physics_mechanics_rigid_graphn_get(s : PhysicsmechanicsrigidGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_mechanics_rigid_graphn_set(s : PhysicsmechanicsrigidGraphN, i : Int, v : Double) -> PhysicsmechanicsrigidGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn physics_mechanics_rigid_graphn_sum(s : PhysicsmechanicsrigidGraphN) -> Double { @_common.sum(s.data) }

pub fn physics_mechanics_rigid_graphn_mean(s : PhysicsmechanicsrigidGraphN) -> Double { @_common.mean(s.data) }

pub fn physics_mechanics_rigid_graphn_scale(s : PhysicsmechanicsrigidGraphN, f : Double) -> PhysicsmechanicsrigidGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_mechanics_rigid_graphn_add(a : PhysicsmechanicsrigidGraphN, b : PhysicsmechanicsrigidGraphN) -> PhysicsmechanicsrigidGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_mechanics_rigid_graphn_copy(s : PhysicsmechanicsrigidGraphN) -> PhysicsmechanicsrigidGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_mechanics_rigid_graphn_fill(s : PhysicsmechanicsrigidGraphN, v : Double) -> PhysicsmechanicsrigidGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_mechanics_rigid_graphn_min(s : PhysicsmechanicsrigidGraphN) -> Double { @_common.min(s.data) }

pub fn physics_mechanics_rigid_graphn_max(s : PhysicsmechanicsrigidGraphN) -> Double { @_common.max(s.data) }

pub fn physics_mechanics_rigid_graphn_to_string(s : PhysicsmechanicsrigidGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsmechanicsrigidNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_mechanics_rigid_node_make(size : Int) -> PhysicsmechanicsrigidNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_mechanics_rigid_node_len(s : PhysicsmechanicsrigidNode) -> Int { s.size }

pub fn physics_mechanics_rigid_node_get(s : PhysicsmechanicsrigidNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_mechanics_rigid_node_set(s : PhysicsmechanicsrigidNode, i : Int, v : Double) -> PhysicsmechanicsrigidNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn physics_mechanics_rigid_node_sum(s : PhysicsmechanicsrigidNode) -> Double { @_common.sum(s.data) }

pub fn physics_mechanics_rigid_node_mean(s : PhysicsmechanicsrigidNode) -> Double { @_common.mean(s.data) }

pub fn physics_mechanics_rigid_node_scale(s : PhysicsmechanicsrigidNode, f : Double) -> PhysicsmechanicsrigidNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_mechanics_rigid_node_add(a : PhysicsmechanicsrigidNode, b : PhysicsmechanicsrigidNode) -> PhysicsmechanicsrigidNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_mechanics_rigid_node_copy(s : PhysicsmechanicsrigidNode) -> PhysicsmechanicsrigidNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_mechanics_rigid_node_fill(s : PhysicsmechanicsrigidNode, v : Double) -> PhysicsmechanicsrigidNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_mechanics_rigid_node_min(s : PhysicsmechanicsrigidNode) -> Double { @_common.min(s.data) }

pub fn physics_mechanics_rigid_node_max(s : PhysicsmechanicsrigidNode) -> Double { @_common.max(s.data) }

pub fn physics_mechanics_rigid_node_to_string(s : PhysicsmechanicsrigidNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsmechanicsrigidEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_mechanics_rigid_edge_make(size : Int) -> PhysicsmechanicsrigidEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_mechanics_rigid_edge_len(s : PhysicsmechanicsrigidEdge) -> Int { s.size }

pub fn physics_mechanics_rigid_edge_get(s : PhysicsmechanicsrigidEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_mechanics_rigid_edge_set(s : PhysicsmechanicsrigidEdge, i : Int, v : Double) -> PhysicsmechanicsrigidEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn physics_mechanics_rigid_edge_sum(s : PhysicsmechanicsrigidEdge) -> Double { @_common.sum(s.data) }

pub fn physics_mechanics_rigid_edge_mean(s : PhysicsmechanicsrigidEdge) -> Double { @_common.mean(s.data) }

pub fn physics_mechanics_rigid_edge_scale(s : PhysicsmechanicsrigidEdge, f : Double) -> PhysicsmechanicsrigidEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_mechanics_rigid_edge_add(a : PhysicsmechanicsrigidEdge, b : PhysicsmechanicsrigidEdge) -> PhysicsmechanicsrigidEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_mechanics_rigid_edge_copy(s : PhysicsmechanicsrigidEdge) -> PhysicsmechanicsrigidEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_mechanics_rigid_edge_fill(s : PhysicsmechanicsrigidEdge, v : Double) -> PhysicsmechanicsrigidEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_mechanics_rigid_edge_min(s : PhysicsmechanicsrigidEdge) -> Double { @_common.min(s.data) }

pub fn physics_mechanics_rigid_edge_max(s : PhysicsmechanicsrigidEdge) -> Double { @_common.max(s.data) }

pub fn physics_mechanics_rigid_edge_to_string(s : PhysicsmechanicsrigidEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsmechanicsrigidPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_mechanics_rigid_path_make(size : Int) -> PhysicsmechanicsrigidPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_mechanics_rigid_path_len(s : PhysicsmechanicsrigidPath) -> Int { s.size }

pub fn physics_mechanics_rigid_path_get(s : PhysicsmechanicsrigidPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_mechanics_rigid_path_set(s : PhysicsmechanicsrigidPath, i : Int, v : Double) -> PhysicsmechanicsrigidPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn physics_mechanics_rigid_path_sum(s : PhysicsmechanicsrigidPath) -> Double { @_common.sum(s.data) }

pub fn physics_mechanics_rigid_path_mean(s : PhysicsmechanicsrigidPath) -> Double { @_common.mean(s.data) }

pub fn physics_mechanics_rigid_path_scale(s : PhysicsmechanicsrigidPath, f : Double) -> PhysicsmechanicsrigidPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_mechanics_rigid_path_add(a : PhysicsmechanicsrigidPath, b : PhysicsmechanicsrigidPath) -> PhysicsmechanicsrigidPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_mechanics_rigid_path_copy(s : PhysicsmechanicsrigidPath) -> PhysicsmechanicsrigidPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_mechanics_rigid_path_fill(s : PhysicsmechanicsrigidPath, v : Double) -> PhysicsmechanicsrigidPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_mechanics_rigid_path_min(s : PhysicsmechanicsrigidPath) -> Double { @_common.min(s.data) }

pub fn physics_mechanics_rigid_path_max(s : PhysicsmechanicsrigidPath) -> Double { @_common.max(s.data) }

pub fn physics_mechanics_rigid_path_to_string(s : PhysicsmechanicsrigidPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsmechanicsrigidCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_mechanics_rigid_cluster_make(size : Int) -> PhysicsmechanicsrigidCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_mechanics_rigid_cluster_len(s : PhysicsmechanicsrigidCluster) -> Int { s.size }

pub fn physics_mechanics_rigid_cluster_get(s : PhysicsmechanicsrigidCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_mechanics_rigid_cluster_set(s : PhysicsmechanicsrigidCluster, i : Int, v : Double) -> PhysicsmechanicsrigidCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn physics_mechanics_rigid_cluster_sum(s : PhysicsmechanicsrigidCluster) -> Double { @_common.sum(s.data) }

pub fn physics_mechanics_rigid_cluster_mean(s : PhysicsmechanicsrigidCluster) -> Double { @_common.mean(s.data) }

pub fn physics_mechanics_rigid_cluster_scale(s : PhysicsmechanicsrigidCluster, f : Double) -> PhysicsmechanicsrigidCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_mechanics_rigid_cluster_add(a : PhysicsmechanicsrigidCluster, b : PhysicsmechanicsrigidCluster) -> PhysicsmechanicsrigidCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_mechanics_rigid_cluster_copy(s : PhysicsmechanicsrigidCluster) -> PhysicsmechanicsrigidCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_mechanics_rigid_cluster_fill(s : PhysicsmechanicsrigidCluster, v : Double) -> PhysicsmechanicsrigidCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_mechanics_rigid_cluster_min(s : PhysicsmechanicsrigidCluster) -> Double { @_common.min(s.data) }

pub fn physics_mechanics_rigid_cluster_max(s : PhysicsmechanicsrigidCluster) -> Double { @_common.max(s.data) }

pub fn physics_mechanics_rigid_cluster_to_string(s : PhysicsmechanicsrigidCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsmechanicsrigidModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_mechanics_rigid_model_make(size : Int) -> PhysicsmechanicsrigidModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_mechanics_rigid_model_len(s : PhysicsmechanicsrigidModel) -> Int { s.size }

pub fn physics_mechanics_rigid_model_get(s : PhysicsmechanicsrigidModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_mechanics_rigid_model_set(s : PhysicsmechanicsrigidModel, i : Int, v : Double) -> PhysicsmechanicsrigidModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn physics_mechanics_rigid_model_sum(s : PhysicsmechanicsrigidModel) -> Double { @_common.sum(s.data) }

pub fn physics_mechanics_rigid_model_mean(s : PhysicsmechanicsrigidModel) -> Double { @_common.mean(s.data) }

pub fn physics_mechanics_rigid_model_scale(s : PhysicsmechanicsrigidModel, f : Double) -> PhysicsmechanicsrigidModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_mechanics_rigid_model_add(a : PhysicsmechanicsrigidModel, b : PhysicsmechanicsrigidModel) -> PhysicsmechanicsrigidModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_mechanics_rigid_model_copy(s : PhysicsmechanicsrigidModel) -> PhysicsmechanicsrigidModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_mechanics_rigid_model_fill(s : PhysicsmechanicsrigidModel, v : Double) -> PhysicsmechanicsrigidModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_mechanics_rigid_model_min(s : PhysicsmechanicsrigidModel) -> Double { @_common.min(s.data) }

pub fn physics_mechanics_rigid_model_max(s : PhysicsmechanicsrigidModel) -> Double { @_common.max(s.data) }

pub fn physics_mechanics_rigid_model_to_string(s : PhysicsmechanicsrigidModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsmechanicsrigidLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_mechanics_rigid_layer_make(size : Int) -> PhysicsmechanicsrigidLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_mechanics_rigid_layer_len(s : PhysicsmechanicsrigidLayer) -> Int { s.size }

pub fn physics_mechanics_rigid_layer_get(s : PhysicsmechanicsrigidLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_mechanics_rigid_layer_set(s : PhysicsmechanicsrigidLayer, i : Int, v : Double) -> PhysicsmechanicsrigidLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn physics_mechanics_rigid_layer_sum(s : PhysicsmechanicsrigidLayer) -> Double { @_common.sum(s.data) }

pub fn physics_mechanics_rigid_layer_mean(s : PhysicsmechanicsrigidLayer) -> Double { @_common.mean(s.data) }

pub fn physics_mechanics_rigid_layer_scale(s : PhysicsmechanicsrigidLayer, f : Double) -> PhysicsmechanicsrigidLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_mechanics_rigid_layer_add(a : PhysicsmechanicsrigidLayer, b : PhysicsmechanicsrigidLayer) -> PhysicsmechanicsrigidLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_mechanics_rigid_layer_copy(s : PhysicsmechanicsrigidLayer) -> PhysicsmechanicsrigidLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_mechanics_rigid_layer_fill(s : PhysicsmechanicsrigidLayer, v : Double) -> PhysicsmechanicsrigidLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_mechanics_rigid_layer_min(s : PhysicsmechanicsrigidLayer) -> Double { @_common.min(s.data) }

pub fn physics_mechanics_rigid_layer_max(s : PhysicsmechanicsrigidLayer) -> Double { @_common.max(s.data) }

pub fn physics_mechanics_rigid_layer_to_string(s : PhysicsmechanicsrigidLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsmechanicsrigidBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_mechanics_rigid_buffer_make(size : Int) -> PhysicsmechanicsrigidBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_mechanics_rigid_buffer_len(s : PhysicsmechanicsrigidBuffer) -> Int { s.size }

pub fn physics_mechanics_rigid_buffer_get(s : PhysicsmechanicsrigidBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_mechanics_rigid_buffer_set(s : PhysicsmechanicsrigidBuffer, i : Int, v : Double) -> PhysicsmechanicsrigidBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn physics_mechanics_rigid_buffer_sum(s : PhysicsmechanicsrigidBuffer) -> Double { @_common.sum(s.data) }

pub fn physics_mechanics_rigid_buffer_mean(s : PhysicsmechanicsrigidBuffer) -> Double { @_common.mean(s.data) }

pub fn physics_mechanics_rigid_buffer_scale(s : PhysicsmechanicsrigidBuffer, f : Double) -> PhysicsmechanicsrigidBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_mechanics_rigid_buffer_add(a : PhysicsmechanicsrigidBuffer, b : PhysicsmechanicsrigidBuffer) -> PhysicsmechanicsrigidBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_mechanics_rigid_buffer_copy(s : PhysicsmechanicsrigidBuffer) -> PhysicsmechanicsrigidBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_mechanics_rigid_buffer_fill(s : PhysicsmechanicsrigidBuffer, v : Double) -> PhysicsmechanicsrigidBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_mechanics_rigid_buffer_min(s : PhysicsmechanicsrigidBuffer) -> Double { @_common.min(s.data) }

pub fn physics_mechanics_rigid_buffer_max(s : PhysicsmechanicsrigidBuffer) -> Double { @_common.max(s.data) }

pub fn physics_mechanics_rigid_buffer_to_string(s : PhysicsmechanicsrigidBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsmechanicsrigidCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_mechanics_rigid_cursor_make(size : Int) -> PhysicsmechanicsrigidCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_mechanics_rigid_cursor_len(s : PhysicsmechanicsrigidCursor) -> Int { s.size }

pub fn physics_mechanics_rigid_cursor_get(s : PhysicsmechanicsrigidCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_mechanics_rigid_cursor_set(s : PhysicsmechanicsrigidCursor, i : Int, v : Double) -> PhysicsmechanicsrigidCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn physics_mechanics_rigid_cursor_sum(s : PhysicsmechanicsrigidCursor) -> Double { @_common.sum(s.data) }

pub fn physics_mechanics_rigid_cursor_mean(s : PhysicsmechanicsrigidCursor) -> Double { @_common.mean(s.data) }

pub fn physics_mechanics_rigid_cursor_scale(s : PhysicsmechanicsrigidCursor, f : Double) -> PhysicsmechanicsrigidCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_mechanics_rigid_cursor_add(a : PhysicsmechanicsrigidCursor, b : PhysicsmechanicsrigidCursor) -> PhysicsmechanicsrigidCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_mechanics_rigid_cursor_copy(s : PhysicsmechanicsrigidCursor) -> PhysicsmechanicsrigidCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_mechanics_rigid_cursor_fill(s : PhysicsmechanicsrigidCursor, v : Double) -> PhysicsmechanicsrigidCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_mechanics_rigid_cursor_min(s : PhysicsmechanicsrigidCursor) -> Double { @_common.min(s.data) }

pub fn physics_mechanics_rigid_cursor_max(s : PhysicsmechanicsrigidCursor) -> Double { @_common.max(s.data) }

pub fn physics_mechanics_rigid_cursor_to_string(s : PhysicsmechanicsrigidCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsmechanicsrigidView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_mechanics_rigid_view_make(size : Int) -> PhysicsmechanicsrigidView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_mechanics_rigid_view_len(s : PhysicsmechanicsrigidView) -> Int { s.size }

pub fn physics_mechanics_rigid_view_get(s : PhysicsmechanicsrigidView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_mechanics_rigid_view_set(s : PhysicsmechanicsrigidView, i : Int, v : Double) -> PhysicsmechanicsrigidView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn physics_mechanics_rigid_view_sum(s : PhysicsmechanicsrigidView) -> Double { @_common.sum(s.data) }

pub fn physics_mechanics_rigid_view_mean(s : PhysicsmechanicsrigidView) -> Double { @_common.mean(s.data) }

pub fn physics_mechanics_rigid_view_scale(s : PhysicsmechanicsrigidView, f : Double) -> PhysicsmechanicsrigidView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_mechanics_rigid_view_add(a : PhysicsmechanicsrigidView, b : PhysicsmechanicsrigidView) -> PhysicsmechanicsrigidView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_mechanics_rigid_view_copy(s : PhysicsmechanicsrigidView) -> PhysicsmechanicsrigidView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_mechanics_rigid_view_fill(s : PhysicsmechanicsrigidView, v : Double) -> PhysicsmechanicsrigidView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_mechanics_rigid_view_min(s : PhysicsmechanicsrigidView) -> Double { @_common.min(s.data) }

pub fn physics_mechanics_rigid_view_max(s : PhysicsmechanicsrigidView) -> Double { @_common.max(s.data) }

pub fn physics_mechanics_rigid_view_to_string(s : PhysicsmechanicsrigidView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsmechanicsrigidRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_mechanics_rigid_range_make(size : Int) -> PhysicsmechanicsrigidRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_mechanics_rigid_range_len(s : PhysicsmechanicsrigidRange) -> Int { s.size }

pub fn physics_mechanics_rigid_range_get(s : PhysicsmechanicsrigidRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_mechanics_rigid_range_set(s : PhysicsmechanicsrigidRange, i : Int, v : Double) -> PhysicsmechanicsrigidRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn physics_mechanics_rigid_range_sum(s : PhysicsmechanicsrigidRange) -> Double { @_common.sum(s.data) }

pub fn physics_mechanics_rigid_range_mean(s : PhysicsmechanicsrigidRange) -> Double { @_common.mean(s.data) }

pub fn physics_mechanics_rigid_range_scale(s : PhysicsmechanicsrigidRange, f : Double) -> PhysicsmechanicsrigidRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_mechanics_rigid_range_add(a : PhysicsmechanicsrigidRange, b : PhysicsmechanicsrigidRange) -> PhysicsmechanicsrigidRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_mechanics_rigid_range_copy(s : PhysicsmechanicsrigidRange) -> PhysicsmechanicsrigidRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_mechanics_rigid_range_fill(s : PhysicsmechanicsrigidRange, v : Double) -> PhysicsmechanicsrigidRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_mechanics_rigid_range_min(s : PhysicsmechanicsrigidRange) -> Double { @_common.min(s.data) }

pub fn physics_mechanics_rigid_range_max(s : PhysicsmechanicsrigidRange) -> Double { @_common.max(s.data) }

pub fn physics_mechanics_rigid_range_to_string(s : PhysicsmechanicsrigidRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsmechanicsrigidSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_mechanics_rigid_slice_make(size : Int) -> PhysicsmechanicsrigidSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_mechanics_rigid_slice_len(s : PhysicsmechanicsrigidSlice) -> Int { s.size }

pub fn physics_mechanics_rigid_slice_get(s : PhysicsmechanicsrigidSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_mechanics_rigid_slice_set(s : PhysicsmechanicsrigidSlice, i : Int, v : Double) -> PhysicsmechanicsrigidSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn physics_mechanics_rigid_slice_sum(s : PhysicsmechanicsrigidSlice) -> Double { @_common.sum(s.data) }

pub fn physics_mechanics_rigid_slice_mean(s : PhysicsmechanicsrigidSlice) -> Double { @_common.mean(s.data) }

pub fn physics_mechanics_rigid_slice_scale(s : PhysicsmechanicsrigidSlice, f : Double) -> PhysicsmechanicsrigidSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_mechanics_rigid_slice_add(a : PhysicsmechanicsrigidSlice, b : PhysicsmechanicsrigidSlice) -> PhysicsmechanicsrigidSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_mechanics_rigid_slice_copy(s : PhysicsmechanicsrigidSlice) -> PhysicsmechanicsrigidSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_mechanics_rigid_slice_fill(s : PhysicsmechanicsrigidSlice, v : Double) -> PhysicsmechanicsrigidSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_mechanics_rigid_slice_min(s : PhysicsmechanicsrigidSlice) -> Double { @_common.min(s.data) }

pub fn physics_mechanics_rigid_slice_max(s : PhysicsmechanicsrigidSlice) -> Double { @_common.max(s.data) }

pub fn physics_mechanics_rigid_slice_to_string(s : PhysicsmechanicsrigidSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

