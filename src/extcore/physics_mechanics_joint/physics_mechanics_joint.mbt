///===
/// extcore/physics_mechanics_joint

pub(all) struct PhysicsmechanicsjointPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn physics_mechanics_joint_make_point(x : Double, y : Double) -> PhysicsmechanicsjointPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn physics_mechanics_joint_make_point3(x : Double, y : Double, z : Double) -> PhysicsmechanicsjointPoint {
  { x, y, z, label: 0 }
}

pub fn PhysicsmechanicsjointPoint::x(self : PhysicsmechanicsjointPoint) -> Double { self.x }

pub fn PhysicsmechanicsjointPoint::y(self : PhysicsmechanicsjointPoint) -> Double { self.y }

pub fn PhysicsmechanicsjointPoint::z(self : PhysicsmechanicsjointPoint) -> Double { self.z }

pub fn PhysicsmechanicsjointPoint::label(self : PhysicsmechanicsjointPoint) -> Int { self.label }

pub fn PhysicsmechanicsjointPoint::dist(self : PhysicsmechanicsjointPoint, other : PhysicsmechanicsjointPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn PhysicsmechanicsjointPoint::add(self : PhysicsmechanicsjointPoint, other : PhysicsmechanicsjointPoint) -> PhysicsmechanicsjointPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn PhysicsmechanicsjointPoint::sub(self : PhysicsmechanicsjointPoint, other : PhysicsmechanicsjointPoint) -> PhysicsmechanicsjointPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn PhysicsmechanicsjointPoint::scale(self : PhysicsmechanicsjointPoint, s : Double) -> PhysicsmechanicsjointPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn PhysicsmechanicsjointPoint::dot(self : PhysicsmechanicsjointPoint, other : PhysicsmechanicsjointPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn PhysicsmechanicsjointPoint::cross(self : PhysicsmechanicsjointPoint, other : PhysicsmechanicsjointPoint) -> PhysicsmechanicsjointPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn PhysicsmechanicsjointPoint::norm(self : PhysicsmechanicsjointPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn PhysicsmechanicsjointPoint::normalize(self : PhysicsmechanicsjointPoint) -> PhysicsmechanicsjointPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn PhysicsmechanicsjointPoint::negate(self : PhysicsmechanicsjointPoint) -> PhysicsmechanicsjointPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn PhysicsmechanicsjointPoint::mid(self : PhysicsmechanicsjointPoint, other : PhysicsmechanicsjointPoint) -> PhysicsmechanicsjointPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn PhysicsmechanicsjointPoint::lerp(self : PhysicsmechanicsjointPoint, other : PhysicsmechanicsjointPoint, t : Double) -> PhysicsmechanicsjointPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn PhysicsmechanicsjointPoint::to_string(self : PhysicsmechanicsjointPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct PhysicsmechanicsjointSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn physics_mechanics_joint_make_series(vals : Array[Double], name : String) -> PhysicsmechanicsjointSeries {
  { vals, name, meta: 0 }
}

pub fn PhysicsmechanicsjointSeries::len(self : PhysicsmechanicsjointSeries) -> Int { self.vals.length() }

pub fn PhysicsmechanicsjointSeries::sum(self : PhysicsmechanicsjointSeries) -> Double { @_common.sum(self.vals) }

pub fn PhysicsmechanicsjointSeries::mean(self : PhysicsmechanicsjointSeries) -> Double { @_common.mean(self.vals) }

pub fn PhysicsmechanicsjointSeries::min(self : PhysicsmechanicsjointSeries) -> Double { @_common.min(self.vals) }

pub fn PhysicsmechanicsjointSeries::max(self : PhysicsmechanicsjointSeries) -> Double { @_common.max(self.vals) }

pub fn PhysicsmechanicsjointSeries::range(self : PhysicsmechanicsjointSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn PhysicsmechanicsjointSeries::variance(self : PhysicsmechanicsjointSeries) -> Double { @_common.variance(self.vals) }

pub fn PhysicsmechanicsjointSeries::std(self : PhysicsmechanicsjointSeries) -> Double { @_common.std(self.vals) }

pub fn PhysicsmechanicsjointSeries::median(self : PhysicsmechanicsjointSeries) -> Double { @_common.median(self.vals) }

pub fn PhysicsmechanicsjointSeries::scale(self : PhysicsmechanicsjointSeries, f : Double) -> PhysicsmechanicsjointSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn PhysicsmechanicsjointSeries::add(self : PhysicsmechanicsjointSeries, other : PhysicsmechanicsjointSeries) -> PhysicsmechanicsjointSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn PhysicsmechanicsjointSeries::sub(self : PhysicsmechanicsjointSeries, other : PhysicsmechanicsjointSeries) -> PhysicsmechanicsjointSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn PhysicsmechanicsjointSeries::normalize(self : PhysicsmechanicsjointSeries) -> PhysicsmechanicsjointSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn PhysicsmechanicsjointSeries::cumsum(self : PhysicsmechanicsjointSeries) -> PhysicsmechanicsjointSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn PhysicsmechanicsjointSeries::to_string(self : PhysicsmechanicsjointSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct PhysicsmechanicsjointMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn physics_mechanics_joint_make_matrix(rows : Int, cols : Int, val : Double) -> PhysicsmechanicsjointMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn physics_mechanics_joint_matrix_identity(n : Int) -> PhysicsmechanicsjointMatrix {
  let m = physics_mechanics_joint_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn PhysicsmechanicsjointMatrix::get(self : PhysicsmechanicsjointMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn PhysicsmechanicsjointMatrix::transpose(self : PhysicsmechanicsjointMatrix) -> PhysicsmechanicsjointMatrix {
  let result = physics_mechanics_joint_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn PhysicsmechanicsjointMatrix::add(self : PhysicsmechanicsjointMatrix, other : PhysicsmechanicsjointMatrix) -> PhysicsmechanicsjointMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = physics_mechanics_joint_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn PhysicsmechanicsjointMatrix::scale(self : PhysicsmechanicsjointMatrix, s : Double) -> PhysicsmechanicsjointMatrix {
  let result = physics_mechanics_joint_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn PhysicsmechanicsjointMatrix::multiply(self : PhysicsmechanicsjointMatrix, other : PhysicsmechanicsjointMatrix) -> PhysicsmechanicsjointMatrix {
  if self.cols != other.rows { return physics_mechanics_joint_make_matrix(self.rows, other.cols, 0.0) }
  let result = physics_mechanics_joint_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn PhysicsmechanicsjointMatrix::trace(self : PhysicsmechanicsjointMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn PhysicsmechanicsjointMatrix::det(self : PhysicsmechanicsjointMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn PhysicsmechanicsjointMatrix::norm(self : PhysicsmechanicsjointMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn PhysicsmechanicsjointMatrix::to_string(self : PhysicsmechanicsjointMatrix) -> String {
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

pub(all) struct PhysicsmechanicsjointVector {
  comps : Array[Double]
  dim : Int
}

pub fn physics_mechanics_joint_make_vector(comps : Array[Double]) -> PhysicsmechanicsjointVector {
  { comps, dim: comps.length() }
}

pub fn physics_mechanics_joint_vector_zero(dim : Int) -> PhysicsmechanicsjointVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn PhysicsmechanicsjointVector::add(self : PhysicsmechanicsjointVector, other : PhysicsmechanicsjointVector) -> PhysicsmechanicsjointVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn PhysicsmechanicsjointVector::sub(self : PhysicsmechanicsjointVector, other : PhysicsmechanicsjointVector) -> PhysicsmechanicsjointVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn PhysicsmechanicsjointVector::scale(self : PhysicsmechanicsjointVector, s : Double) -> PhysicsmechanicsjointVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn PhysicsmechanicsjointVector::dot(self : PhysicsmechanicsjointVector, other : PhysicsmechanicsjointVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn PhysicsmechanicsjointVector::norm(self : PhysicsmechanicsjointVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn PhysicsmechanicsjointVector::normalize(self : PhysicsmechanicsjointVector) -> PhysicsmechanicsjointVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn PhysicsmechanicsjointVector::dist(self : PhysicsmechanicsjointVector, other : PhysicsmechanicsjointVector) -> Double {
  self.sub(other).norm()
}

pub fn PhysicsmechanicsjointVector::to_string(self : PhysicsmechanicsjointVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn physics_mechanics_joint_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn physics_mechanics_joint_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn physics_mechanics_joint_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn physics_mechanics_joint_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn physics_mechanics_joint_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn physics_mechanics_joint_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn physics_mechanics_joint_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn physics_mechanics_joint_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn physics_mechanics_joint_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn physics_mechanics_joint_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn physics_mechanics_joint_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn physics_mechanics_joint_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn physics_mechanics_joint_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn physics_mechanics_joint_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn physics_mechanics_joint_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn physics_mechanics_joint_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn physics_mechanics_joint_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn physics_mechanics_joint_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn physics_mechanics_joint_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn physics_mechanics_joint_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn physics_mechanics_joint_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn physics_mechanics_joint_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn physics_mechanics_joint_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn physics_mechanics_joint_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn physics_mechanics_joint_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn physics_mechanics_joint_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn physics_mechanics_joint_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn physics_mechanics_joint_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn physics_mechanics_joint_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct PhysicsmechanicsjointFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_mechanics_joint_frame_make(size : Int) -> PhysicsmechanicsjointFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_mechanics_joint_frame_len(s : PhysicsmechanicsjointFrame) -> Int { s.size }

pub fn physics_mechanics_joint_frame_get(s : PhysicsmechanicsjointFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_mechanics_joint_frame_set(s : PhysicsmechanicsjointFrame, i : Int, v : Double) -> PhysicsmechanicsjointFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn physics_mechanics_joint_frame_sum(s : PhysicsmechanicsjointFrame) -> Double { @_common.sum(s.data) }

pub fn physics_mechanics_joint_frame_mean(s : PhysicsmechanicsjointFrame) -> Double { @_common.mean(s.data) }

pub fn physics_mechanics_joint_frame_scale(s : PhysicsmechanicsjointFrame, f : Double) -> PhysicsmechanicsjointFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_mechanics_joint_frame_add(a : PhysicsmechanicsjointFrame, b : PhysicsmechanicsjointFrame) -> PhysicsmechanicsjointFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_mechanics_joint_frame_copy(s : PhysicsmechanicsjointFrame) -> PhysicsmechanicsjointFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_mechanics_joint_frame_fill(s : PhysicsmechanicsjointFrame, v : Double) -> PhysicsmechanicsjointFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_mechanics_joint_frame_min(s : PhysicsmechanicsjointFrame) -> Double { @_common.min(s.data) }

pub fn physics_mechanics_joint_frame_max(s : PhysicsmechanicsjointFrame) -> Double { @_common.max(s.data) }

pub fn physics_mechanics_joint_frame_to_string(s : PhysicsmechanicsjointFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsmechanicsjointTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_mechanics_joint_table_make(size : Int) -> PhysicsmechanicsjointTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_mechanics_joint_table_len(s : PhysicsmechanicsjointTable) -> Int { s.size }

pub fn physics_mechanics_joint_table_get(s : PhysicsmechanicsjointTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_mechanics_joint_table_set(s : PhysicsmechanicsjointTable, i : Int, v : Double) -> PhysicsmechanicsjointTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn physics_mechanics_joint_table_sum(s : PhysicsmechanicsjointTable) -> Double { @_common.sum(s.data) }

pub fn physics_mechanics_joint_table_mean(s : PhysicsmechanicsjointTable) -> Double { @_common.mean(s.data) }

pub fn physics_mechanics_joint_table_scale(s : PhysicsmechanicsjointTable, f : Double) -> PhysicsmechanicsjointTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_mechanics_joint_table_add(a : PhysicsmechanicsjointTable, b : PhysicsmechanicsjointTable) -> PhysicsmechanicsjointTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_mechanics_joint_table_copy(s : PhysicsmechanicsjointTable) -> PhysicsmechanicsjointTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_mechanics_joint_table_fill(s : PhysicsmechanicsjointTable, v : Double) -> PhysicsmechanicsjointTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_mechanics_joint_table_min(s : PhysicsmechanicsjointTable) -> Double { @_common.min(s.data) }

pub fn physics_mechanics_joint_table_max(s : PhysicsmechanicsjointTable) -> Double { @_common.max(s.data) }

pub fn physics_mechanics_joint_table_to_string(s : PhysicsmechanicsjointTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsmechanicsjointGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_mechanics_joint_graphn_make(size : Int) -> PhysicsmechanicsjointGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_mechanics_joint_graphn_len(s : PhysicsmechanicsjointGraphN) -> Int { s.size }

pub fn physics_mechanics_joint_graphn_get(s : PhysicsmechanicsjointGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_mechanics_joint_graphn_set(s : PhysicsmechanicsjointGraphN, i : Int, v : Double) -> PhysicsmechanicsjointGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn physics_mechanics_joint_graphn_sum(s : PhysicsmechanicsjointGraphN) -> Double { @_common.sum(s.data) }

pub fn physics_mechanics_joint_graphn_mean(s : PhysicsmechanicsjointGraphN) -> Double { @_common.mean(s.data) }

pub fn physics_mechanics_joint_graphn_scale(s : PhysicsmechanicsjointGraphN, f : Double) -> PhysicsmechanicsjointGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_mechanics_joint_graphn_add(a : PhysicsmechanicsjointGraphN, b : PhysicsmechanicsjointGraphN) -> PhysicsmechanicsjointGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_mechanics_joint_graphn_copy(s : PhysicsmechanicsjointGraphN) -> PhysicsmechanicsjointGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_mechanics_joint_graphn_fill(s : PhysicsmechanicsjointGraphN, v : Double) -> PhysicsmechanicsjointGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_mechanics_joint_graphn_min(s : PhysicsmechanicsjointGraphN) -> Double { @_common.min(s.data) }

pub fn physics_mechanics_joint_graphn_max(s : PhysicsmechanicsjointGraphN) -> Double { @_common.max(s.data) }

pub fn physics_mechanics_joint_graphn_to_string(s : PhysicsmechanicsjointGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsmechanicsjointNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_mechanics_joint_node_make(size : Int) -> PhysicsmechanicsjointNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_mechanics_joint_node_len(s : PhysicsmechanicsjointNode) -> Int { s.size }

pub fn physics_mechanics_joint_node_get(s : PhysicsmechanicsjointNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_mechanics_joint_node_set(s : PhysicsmechanicsjointNode, i : Int, v : Double) -> PhysicsmechanicsjointNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn physics_mechanics_joint_node_sum(s : PhysicsmechanicsjointNode) -> Double { @_common.sum(s.data) }

pub fn physics_mechanics_joint_node_mean(s : PhysicsmechanicsjointNode) -> Double { @_common.mean(s.data) }

pub fn physics_mechanics_joint_node_scale(s : PhysicsmechanicsjointNode, f : Double) -> PhysicsmechanicsjointNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_mechanics_joint_node_add(a : PhysicsmechanicsjointNode, b : PhysicsmechanicsjointNode) -> PhysicsmechanicsjointNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_mechanics_joint_node_copy(s : PhysicsmechanicsjointNode) -> PhysicsmechanicsjointNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_mechanics_joint_node_fill(s : PhysicsmechanicsjointNode, v : Double) -> PhysicsmechanicsjointNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_mechanics_joint_node_min(s : PhysicsmechanicsjointNode) -> Double { @_common.min(s.data) }

pub fn physics_mechanics_joint_node_max(s : PhysicsmechanicsjointNode) -> Double { @_common.max(s.data) }

pub fn physics_mechanics_joint_node_to_string(s : PhysicsmechanicsjointNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsmechanicsjointEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_mechanics_joint_edge_make(size : Int) -> PhysicsmechanicsjointEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_mechanics_joint_edge_len(s : PhysicsmechanicsjointEdge) -> Int { s.size }

pub fn physics_mechanics_joint_edge_get(s : PhysicsmechanicsjointEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_mechanics_joint_edge_set(s : PhysicsmechanicsjointEdge, i : Int, v : Double) -> PhysicsmechanicsjointEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn physics_mechanics_joint_edge_sum(s : PhysicsmechanicsjointEdge) -> Double { @_common.sum(s.data) }

pub fn physics_mechanics_joint_edge_mean(s : PhysicsmechanicsjointEdge) -> Double { @_common.mean(s.data) }

pub fn physics_mechanics_joint_edge_scale(s : PhysicsmechanicsjointEdge, f : Double) -> PhysicsmechanicsjointEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_mechanics_joint_edge_add(a : PhysicsmechanicsjointEdge, b : PhysicsmechanicsjointEdge) -> PhysicsmechanicsjointEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_mechanics_joint_edge_copy(s : PhysicsmechanicsjointEdge) -> PhysicsmechanicsjointEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_mechanics_joint_edge_fill(s : PhysicsmechanicsjointEdge, v : Double) -> PhysicsmechanicsjointEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_mechanics_joint_edge_min(s : PhysicsmechanicsjointEdge) -> Double { @_common.min(s.data) }

pub fn physics_mechanics_joint_edge_max(s : PhysicsmechanicsjointEdge) -> Double { @_common.max(s.data) }

pub fn physics_mechanics_joint_edge_to_string(s : PhysicsmechanicsjointEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsmechanicsjointPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_mechanics_joint_path_make(size : Int) -> PhysicsmechanicsjointPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_mechanics_joint_path_len(s : PhysicsmechanicsjointPath) -> Int { s.size }

pub fn physics_mechanics_joint_path_get(s : PhysicsmechanicsjointPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_mechanics_joint_path_set(s : PhysicsmechanicsjointPath, i : Int, v : Double) -> PhysicsmechanicsjointPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn physics_mechanics_joint_path_sum(s : PhysicsmechanicsjointPath) -> Double { @_common.sum(s.data) }

pub fn physics_mechanics_joint_path_mean(s : PhysicsmechanicsjointPath) -> Double { @_common.mean(s.data) }

pub fn physics_mechanics_joint_path_scale(s : PhysicsmechanicsjointPath, f : Double) -> PhysicsmechanicsjointPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_mechanics_joint_path_add(a : PhysicsmechanicsjointPath, b : PhysicsmechanicsjointPath) -> PhysicsmechanicsjointPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_mechanics_joint_path_copy(s : PhysicsmechanicsjointPath) -> PhysicsmechanicsjointPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_mechanics_joint_path_fill(s : PhysicsmechanicsjointPath, v : Double) -> PhysicsmechanicsjointPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_mechanics_joint_path_min(s : PhysicsmechanicsjointPath) -> Double { @_common.min(s.data) }

pub fn physics_mechanics_joint_path_max(s : PhysicsmechanicsjointPath) -> Double { @_common.max(s.data) }

pub fn physics_mechanics_joint_path_to_string(s : PhysicsmechanicsjointPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsmechanicsjointCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_mechanics_joint_cluster_make(size : Int) -> PhysicsmechanicsjointCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_mechanics_joint_cluster_len(s : PhysicsmechanicsjointCluster) -> Int { s.size }

pub fn physics_mechanics_joint_cluster_get(s : PhysicsmechanicsjointCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_mechanics_joint_cluster_set(s : PhysicsmechanicsjointCluster, i : Int, v : Double) -> PhysicsmechanicsjointCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn physics_mechanics_joint_cluster_sum(s : PhysicsmechanicsjointCluster) -> Double { @_common.sum(s.data) }

pub fn physics_mechanics_joint_cluster_mean(s : PhysicsmechanicsjointCluster) -> Double { @_common.mean(s.data) }

pub fn physics_mechanics_joint_cluster_scale(s : PhysicsmechanicsjointCluster, f : Double) -> PhysicsmechanicsjointCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_mechanics_joint_cluster_add(a : PhysicsmechanicsjointCluster, b : PhysicsmechanicsjointCluster) -> PhysicsmechanicsjointCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_mechanics_joint_cluster_copy(s : PhysicsmechanicsjointCluster) -> PhysicsmechanicsjointCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_mechanics_joint_cluster_fill(s : PhysicsmechanicsjointCluster, v : Double) -> PhysicsmechanicsjointCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_mechanics_joint_cluster_min(s : PhysicsmechanicsjointCluster) -> Double { @_common.min(s.data) }

pub fn physics_mechanics_joint_cluster_max(s : PhysicsmechanicsjointCluster) -> Double { @_common.max(s.data) }

pub fn physics_mechanics_joint_cluster_to_string(s : PhysicsmechanicsjointCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsmechanicsjointModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_mechanics_joint_model_make(size : Int) -> PhysicsmechanicsjointModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_mechanics_joint_model_len(s : PhysicsmechanicsjointModel) -> Int { s.size }

pub fn physics_mechanics_joint_model_get(s : PhysicsmechanicsjointModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_mechanics_joint_model_set(s : PhysicsmechanicsjointModel, i : Int, v : Double) -> PhysicsmechanicsjointModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn physics_mechanics_joint_model_sum(s : PhysicsmechanicsjointModel) -> Double { @_common.sum(s.data) }

pub fn physics_mechanics_joint_model_mean(s : PhysicsmechanicsjointModel) -> Double { @_common.mean(s.data) }

pub fn physics_mechanics_joint_model_scale(s : PhysicsmechanicsjointModel, f : Double) -> PhysicsmechanicsjointModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_mechanics_joint_model_add(a : PhysicsmechanicsjointModel, b : PhysicsmechanicsjointModel) -> PhysicsmechanicsjointModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_mechanics_joint_model_copy(s : PhysicsmechanicsjointModel) -> PhysicsmechanicsjointModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_mechanics_joint_model_fill(s : PhysicsmechanicsjointModel, v : Double) -> PhysicsmechanicsjointModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_mechanics_joint_model_min(s : PhysicsmechanicsjointModel) -> Double { @_common.min(s.data) }

pub fn physics_mechanics_joint_model_max(s : PhysicsmechanicsjointModel) -> Double { @_common.max(s.data) }

pub fn physics_mechanics_joint_model_to_string(s : PhysicsmechanicsjointModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsmechanicsjointLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_mechanics_joint_layer_make(size : Int) -> PhysicsmechanicsjointLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_mechanics_joint_layer_len(s : PhysicsmechanicsjointLayer) -> Int { s.size }

pub fn physics_mechanics_joint_layer_get(s : PhysicsmechanicsjointLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_mechanics_joint_layer_set(s : PhysicsmechanicsjointLayer, i : Int, v : Double) -> PhysicsmechanicsjointLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn physics_mechanics_joint_layer_sum(s : PhysicsmechanicsjointLayer) -> Double { @_common.sum(s.data) }

pub fn physics_mechanics_joint_layer_mean(s : PhysicsmechanicsjointLayer) -> Double { @_common.mean(s.data) }

pub fn physics_mechanics_joint_layer_scale(s : PhysicsmechanicsjointLayer, f : Double) -> PhysicsmechanicsjointLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_mechanics_joint_layer_add(a : PhysicsmechanicsjointLayer, b : PhysicsmechanicsjointLayer) -> PhysicsmechanicsjointLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_mechanics_joint_layer_copy(s : PhysicsmechanicsjointLayer) -> PhysicsmechanicsjointLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_mechanics_joint_layer_fill(s : PhysicsmechanicsjointLayer, v : Double) -> PhysicsmechanicsjointLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_mechanics_joint_layer_min(s : PhysicsmechanicsjointLayer) -> Double { @_common.min(s.data) }

pub fn physics_mechanics_joint_layer_max(s : PhysicsmechanicsjointLayer) -> Double { @_common.max(s.data) }

pub fn physics_mechanics_joint_layer_to_string(s : PhysicsmechanicsjointLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsmechanicsjointBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_mechanics_joint_buffer_make(size : Int) -> PhysicsmechanicsjointBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_mechanics_joint_buffer_len(s : PhysicsmechanicsjointBuffer) -> Int { s.size }

pub fn physics_mechanics_joint_buffer_get(s : PhysicsmechanicsjointBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_mechanics_joint_buffer_set(s : PhysicsmechanicsjointBuffer, i : Int, v : Double) -> PhysicsmechanicsjointBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn physics_mechanics_joint_buffer_sum(s : PhysicsmechanicsjointBuffer) -> Double { @_common.sum(s.data) }

pub fn physics_mechanics_joint_buffer_mean(s : PhysicsmechanicsjointBuffer) -> Double { @_common.mean(s.data) }

pub fn physics_mechanics_joint_buffer_scale(s : PhysicsmechanicsjointBuffer, f : Double) -> PhysicsmechanicsjointBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_mechanics_joint_buffer_add(a : PhysicsmechanicsjointBuffer, b : PhysicsmechanicsjointBuffer) -> PhysicsmechanicsjointBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_mechanics_joint_buffer_copy(s : PhysicsmechanicsjointBuffer) -> PhysicsmechanicsjointBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_mechanics_joint_buffer_fill(s : PhysicsmechanicsjointBuffer, v : Double) -> PhysicsmechanicsjointBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_mechanics_joint_buffer_min(s : PhysicsmechanicsjointBuffer) -> Double { @_common.min(s.data) }

pub fn physics_mechanics_joint_buffer_max(s : PhysicsmechanicsjointBuffer) -> Double { @_common.max(s.data) }

pub fn physics_mechanics_joint_buffer_to_string(s : PhysicsmechanicsjointBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsmechanicsjointCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_mechanics_joint_cursor_make(size : Int) -> PhysicsmechanicsjointCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_mechanics_joint_cursor_len(s : PhysicsmechanicsjointCursor) -> Int { s.size }

pub fn physics_mechanics_joint_cursor_get(s : PhysicsmechanicsjointCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_mechanics_joint_cursor_set(s : PhysicsmechanicsjointCursor, i : Int, v : Double) -> PhysicsmechanicsjointCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn physics_mechanics_joint_cursor_sum(s : PhysicsmechanicsjointCursor) -> Double { @_common.sum(s.data) }

pub fn physics_mechanics_joint_cursor_mean(s : PhysicsmechanicsjointCursor) -> Double { @_common.mean(s.data) }

pub fn physics_mechanics_joint_cursor_scale(s : PhysicsmechanicsjointCursor, f : Double) -> PhysicsmechanicsjointCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_mechanics_joint_cursor_add(a : PhysicsmechanicsjointCursor, b : PhysicsmechanicsjointCursor) -> PhysicsmechanicsjointCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_mechanics_joint_cursor_copy(s : PhysicsmechanicsjointCursor) -> PhysicsmechanicsjointCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_mechanics_joint_cursor_fill(s : PhysicsmechanicsjointCursor, v : Double) -> PhysicsmechanicsjointCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_mechanics_joint_cursor_min(s : PhysicsmechanicsjointCursor) -> Double { @_common.min(s.data) }

pub fn physics_mechanics_joint_cursor_max(s : PhysicsmechanicsjointCursor) -> Double { @_common.max(s.data) }

pub fn physics_mechanics_joint_cursor_to_string(s : PhysicsmechanicsjointCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsmechanicsjointView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_mechanics_joint_view_make(size : Int) -> PhysicsmechanicsjointView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_mechanics_joint_view_len(s : PhysicsmechanicsjointView) -> Int { s.size }

pub fn physics_mechanics_joint_view_get(s : PhysicsmechanicsjointView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_mechanics_joint_view_set(s : PhysicsmechanicsjointView, i : Int, v : Double) -> PhysicsmechanicsjointView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn physics_mechanics_joint_view_sum(s : PhysicsmechanicsjointView) -> Double { @_common.sum(s.data) }

pub fn physics_mechanics_joint_view_mean(s : PhysicsmechanicsjointView) -> Double { @_common.mean(s.data) }

pub fn physics_mechanics_joint_view_scale(s : PhysicsmechanicsjointView, f : Double) -> PhysicsmechanicsjointView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_mechanics_joint_view_add(a : PhysicsmechanicsjointView, b : PhysicsmechanicsjointView) -> PhysicsmechanicsjointView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_mechanics_joint_view_copy(s : PhysicsmechanicsjointView) -> PhysicsmechanicsjointView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_mechanics_joint_view_fill(s : PhysicsmechanicsjointView, v : Double) -> PhysicsmechanicsjointView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_mechanics_joint_view_min(s : PhysicsmechanicsjointView) -> Double { @_common.min(s.data) }

pub fn physics_mechanics_joint_view_max(s : PhysicsmechanicsjointView) -> Double { @_common.max(s.data) }

pub fn physics_mechanics_joint_view_to_string(s : PhysicsmechanicsjointView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsmechanicsjointRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_mechanics_joint_range_make(size : Int) -> PhysicsmechanicsjointRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_mechanics_joint_range_len(s : PhysicsmechanicsjointRange) -> Int { s.size }

pub fn physics_mechanics_joint_range_get(s : PhysicsmechanicsjointRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_mechanics_joint_range_set(s : PhysicsmechanicsjointRange, i : Int, v : Double) -> PhysicsmechanicsjointRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn physics_mechanics_joint_range_sum(s : PhysicsmechanicsjointRange) -> Double { @_common.sum(s.data) }

pub fn physics_mechanics_joint_range_mean(s : PhysicsmechanicsjointRange) -> Double { @_common.mean(s.data) }

pub fn physics_mechanics_joint_range_scale(s : PhysicsmechanicsjointRange, f : Double) -> PhysicsmechanicsjointRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_mechanics_joint_range_add(a : PhysicsmechanicsjointRange, b : PhysicsmechanicsjointRange) -> PhysicsmechanicsjointRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_mechanics_joint_range_copy(s : PhysicsmechanicsjointRange) -> PhysicsmechanicsjointRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_mechanics_joint_range_fill(s : PhysicsmechanicsjointRange, v : Double) -> PhysicsmechanicsjointRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_mechanics_joint_range_min(s : PhysicsmechanicsjointRange) -> Double { @_common.min(s.data) }

pub fn physics_mechanics_joint_range_max(s : PhysicsmechanicsjointRange) -> Double { @_common.max(s.data) }

pub fn physics_mechanics_joint_range_to_string(s : PhysicsmechanicsjointRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsmechanicsjointSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_mechanics_joint_slice_make(size : Int) -> PhysicsmechanicsjointSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_mechanics_joint_slice_len(s : PhysicsmechanicsjointSlice) -> Int { s.size }

pub fn physics_mechanics_joint_slice_get(s : PhysicsmechanicsjointSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_mechanics_joint_slice_set(s : PhysicsmechanicsjointSlice, i : Int, v : Double) -> PhysicsmechanicsjointSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn physics_mechanics_joint_slice_sum(s : PhysicsmechanicsjointSlice) -> Double { @_common.sum(s.data) }

pub fn physics_mechanics_joint_slice_mean(s : PhysicsmechanicsjointSlice) -> Double { @_common.mean(s.data) }

pub fn physics_mechanics_joint_slice_scale(s : PhysicsmechanicsjointSlice, f : Double) -> PhysicsmechanicsjointSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_mechanics_joint_slice_add(a : PhysicsmechanicsjointSlice, b : PhysicsmechanicsjointSlice) -> PhysicsmechanicsjointSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_mechanics_joint_slice_copy(s : PhysicsmechanicsjointSlice) -> PhysicsmechanicsjointSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_mechanics_joint_slice_fill(s : PhysicsmechanicsjointSlice, v : Double) -> PhysicsmechanicsjointSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_mechanics_joint_slice_min(s : PhysicsmechanicsjointSlice) -> Double { @_common.min(s.data) }

pub fn physics_mechanics_joint_slice_max(s : PhysicsmechanicsjointSlice) -> Double { @_common.max(s.data) }

pub fn physics_mechanics_joint_slice_to_string(s : PhysicsmechanicsjointSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

