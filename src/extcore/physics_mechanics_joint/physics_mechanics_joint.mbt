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

pub fn PhysicsmechanicsjointFrame::len(self : PhysicsmechanicsjointFrame) -> Int { self.size }

pub fn PhysicsmechanicsjointFrame::get(self : PhysicsmechanicsjointFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn PhysicsmechanicsjointFrame::set(self : PhysicsmechanicsjointFrame, i : Int, v : Double) -> PhysicsmechanicsjointFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn PhysicsmechanicsjointFrame::sum(self : PhysicsmechanicsjointFrame) -> Double { @_common.sum(self.data) }

pub fn PhysicsmechanicsjointFrame::mean(self : PhysicsmechanicsjointFrame) -> Double { @_common.mean(self.data) }

pub fn PhysicsmechanicsjointFrame::scale(self : PhysicsmechanicsjointFrame, f : Double) -> PhysicsmechanicsjointFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn PhysicsmechanicsjointFrame::add(self : PhysicsmechanicsjointFrame, other : PhysicsmechanicsjointFrame) -> PhysicsmechanicsjointFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn PhysicsmechanicsjointFrame::copy(self : PhysicsmechanicsjointFrame) -> PhysicsmechanicsjointFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn PhysicsmechanicsjointFrame::fill(self : PhysicsmechanicsjointFrame, v : Double) -> PhysicsmechanicsjointFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn PhysicsmechanicsjointFrame::min(self : PhysicsmechanicsjointFrame) -> Double { @_common.min(self.data) }

pub fn PhysicsmechanicsjointFrame::max(self : PhysicsmechanicsjointFrame) -> Double { @_common.max(self.data) }

pub fn PhysicsmechanicsjointFrame::to_string(self : PhysicsmechanicsjointFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct PhysicsmechanicsjointTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_mechanics_joint_table_make(size : Int) -> PhysicsmechanicsjointTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn PhysicsmechanicsjointTable::len(self : PhysicsmechanicsjointTable) -> Int { self.size }

pub fn PhysicsmechanicsjointTable::get(self : PhysicsmechanicsjointTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn PhysicsmechanicsjointTable::set(self : PhysicsmechanicsjointTable, i : Int, v : Double) -> PhysicsmechanicsjointTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn PhysicsmechanicsjointTable::sum(self : PhysicsmechanicsjointTable) -> Double { @_common.sum(self.data) }

pub fn PhysicsmechanicsjointTable::mean(self : PhysicsmechanicsjointTable) -> Double { @_common.mean(self.data) }

pub fn PhysicsmechanicsjointTable::scale(self : PhysicsmechanicsjointTable, f : Double) -> PhysicsmechanicsjointTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn PhysicsmechanicsjointTable::add(self : PhysicsmechanicsjointTable, other : PhysicsmechanicsjointTable) -> PhysicsmechanicsjointTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn PhysicsmechanicsjointTable::copy(self : PhysicsmechanicsjointTable) -> PhysicsmechanicsjointTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn PhysicsmechanicsjointTable::fill(self : PhysicsmechanicsjointTable, v : Double) -> PhysicsmechanicsjointTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn PhysicsmechanicsjointTable::min(self : PhysicsmechanicsjointTable) -> Double { @_common.min(self.data) }

pub fn PhysicsmechanicsjointTable::max(self : PhysicsmechanicsjointTable) -> Double { @_common.max(self.data) }

pub fn PhysicsmechanicsjointTable::to_string(self : PhysicsmechanicsjointTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct PhysicsmechanicsjointGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_mechanics_joint_graphn_make(size : Int) -> PhysicsmechanicsjointGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn PhysicsmechanicsjointGraphN::len(self : PhysicsmechanicsjointGraphN) -> Int { self.size }

pub fn PhysicsmechanicsjointGraphN::get(self : PhysicsmechanicsjointGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn PhysicsmechanicsjointGraphN::set(self : PhysicsmechanicsjointGraphN, i : Int, v : Double) -> PhysicsmechanicsjointGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn PhysicsmechanicsjointGraphN::sum(self : PhysicsmechanicsjointGraphN) -> Double { @_common.sum(self.data) }

pub fn PhysicsmechanicsjointGraphN::mean(self : PhysicsmechanicsjointGraphN) -> Double { @_common.mean(self.data) }

pub fn PhysicsmechanicsjointGraphN::scale(self : PhysicsmechanicsjointGraphN, f : Double) -> PhysicsmechanicsjointGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn PhysicsmechanicsjointGraphN::add(self : PhysicsmechanicsjointGraphN, other : PhysicsmechanicsjointGraphN) -> PhysicsmechanicsjointGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn PhysicsmechanicsjointGraphN::copy(self : PhysicsmechanicsjointGraphN) -> PhysicsmechanicsjointGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn PhysicsmechanicsjointGraphN::fill(self : PhysicsmechanicsjointGraphN, v : Double) -> PhysicsmechanicsjointGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn PhysicsmechanicsjointGraphN::min(self : PhysicsmechanicsjointGraphN) -> Double { @_common.min(self.data) }

pub fn PhysicsmechanicsjointGraphN::max(self : PhysicsmechanicsjointGraphN) -> Double { @_common.max(self.data) }

pub fn PhysicsmechanicsjointGraphN::to_string(self : PhysicsmechanicsjointGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct PhysicsmechanicsjointNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_mechanics_joint_node_make(size : Int) -> PhysicsmechanicsjointNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn PhysicsmechanicsjointNode::len(self : PhysicsmechanicsjointNode) -> Int { self.size }

pub fn PhysicsmechanicsjointNode::get(self : PhysicsmechanicsjointNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn PhysicsmechanicsjointNode::set(self : PhysicsmechanicsjointNode, i : Int, v : Double) -> PhysicsmechanicsjointNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn PhysicsmechanicsjointNode::sum(self : PhysicsmechanicsjointNode) -> Double { @_common.sum(self.data) }

pub fn PhysicsmechanicsjointNode::mean(self : PhysicsmechanicsjointNode) -> Double { @_common.mean(self.data) }

pub fn PhysicsmechanicsjointNode::scale(self : PhysicsmechanicsjointNode, f : Double) -> PhysicsmechanicsjointNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn PhysicsmechanicsjointNode::add(self : PhysicsmechanicsjointNode, other : PhysicsmechanicsjointNode) -> PhysicsmechanicsjointNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn PhysicsmechanicsjointNode::copy(self : PhysicsmechanicsjointNode) -> PhysicsmechanicsjointNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn PhysicsmechanicsjointNode::fill(self : PhysicsmechanicsjointNode, v : Double) -> PhysicsmechanicsjointNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn PhysicsmechanicsjointNode::min(self : PhysicsmechanicsjointNode) -> Double { @_common.min(self.data) }

pub fn PhysicsmechanicsjointNode::max(self : PhysicsmechanicsjointNode) -> Double { @_common.max(self.data) }

pub fn PhysicsmechanicsjointNode::to_string(self : PhysicsmechanicsjointNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct PhysicsmechanicsjointEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_mechanics_joint_edge_make(size : Int) -> PhysicsmechanicsjointEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn PhysicsmechanicsjointEdge::len(self : PhysicsmechanicsjointEdge) -> Int { self.size }

pub fn PhysicsmechanicsjointEdge::get(self : PhysicsmechanicsjointEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn PhysicsmechanicsjointEdge::set(self : PhysicsmechanicsjointEdge, i : Int, v : Double) -> PhysicsmechanicsjointEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn PhysicsmechanicsjointEdge::sum(self : PhysicsmechanicsjointEdge) -> Double { @_common.sum(self.data) }

pub fn PhysicsmechanicsjointEdge::mean(self : PhysicsmechanicsjointEdge) -> Double { @_common.mean(self.data) }

pub fn PhysicsmechanicsjointEdge::scale(self : PhysicsmechanicsjointEdge, f : Double) -> PhysicsmechanicsjointEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn PhysicsmechanicsjointEdge::add(self : PhysicsmechanicsjointEdge, other : PhysicsmechanicsjointEdge) -> PhysicsmechanicsjointEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn PhysicsmechanicsjointEdge::copy(self : PhysicsmechanicsjointEdge) -> PhysicsmechanicsjointEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn PhysicsmechanicsjointEdge::fill(self : PhysicsmechanicsjointEdge, v : Double) -> PhysicsmechanicsjointEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn PhysicsmechanicsjointEdge::min(self : PhysicsmechanicsjointEdge) -> Double { @_common.min(self.data) }

pub fn PhysicsmechanicsjointEdge::max(self : PhysicsmechanicsjointEdge) -> Double { @_common.max(self.data) }

pub fn PhysicsmechanicsjointEdge::to_string(self : PhysicsmechanicsjointEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct PhysicsmechanicsjointPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_mechanics_joint_path_make(size : Int) -> PhysicsmechanicsjointPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn PhysicsmechanicsjointPath::len(self : PhysicsmechanicsjointPath) -> Int { self.size }

pub fn PhysicsmechanicsjointPath::get(self : PhysicsmechanicsjointPath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn PhysicsmechanicsjointPath::set(self : PhysicsmechanicsjointPath, i : Int, v : Double) -> PhysicsmechanicsjointPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn PhysicsmechanicsjointPath::sum(self : PhysicsmechanicsjointPath) -> Double { @_common.sum(self.data) }

pub fn PhysicsmechanicsjointPath::mean(self : PhysicsmechanicsjointPath) -> Double { @_common.mean(self.data) }

pub fn PhysicsmechanicsjointPath::scale(self : PhysicsmechanicsjointPath, f : Double) -> PhysicsmechanicsjointPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn PhysicsmechanicsjointPath::add(self : PhysicsmechanicsjointPath, other : PhysicsmechanicsjointPath) -> PhysicsmechanicsjointPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn PhysicsmechanicsjointPath::copy(self : PhysicsmechanicsjointPath) -> PhysicsmechanicsjointPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn PhysicsmechanicsjointPath::fill(self : PhysicsmechanicsjointPath, v : Double) -> PhysicsmechanicsjointPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn PhysicsmechanicsjointPath::min(self : PhysicsmechanicsjointPath) -> Double { @_common.min(self.data) }

pub fn PhysicsmechanicsjointPath::max(self : PhysicsmechanicsjointPath) -> Double { @_common.max(self.data) }

pub fn PhysicsmechanicsjointPath::to_string(self : PhysicsmechanicsjointPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct PhysicsmechanicsjointCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_mechanics_joint_cluster_make(size : Int) -> PhysicsmechanicsjointCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn PhysicsmechanicsjointCluster::len(self : PhysicsmechanicsjointCluster) -> Int { self.size }

pub fn PhysicsmechanicsjointCluster::get(self : PhysicsmechanicsjointCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn PhysicsmechanicsjointCluster::set(self : PhysicsmechanicsjointCluster, i : Int, v : Double) -> PhysicsmechanicsjointCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn PhysicsmechanicsjointCluster::sum(self : PhysicsmechanicsjointCluster) -> Double { @_common.sum(self.data) }

pub fn PhysicsmechanicsjointCluster::mean(self : PhysicsmechanicsjointCluster) -> Double { @_common.mean(self.data) }

pub fn PhysicsmechanicsjointCluster::scale(self : PhysicsmechanicsjointCluster, f : Double) -> PhysicsmechanicsjointCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn PhysicsmechanicsjointCluster::add(self : PhysicsmechanicsjointCluster, other : PhysicsmechanicsjointCluster) -> PhysicsmechanicsjointCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn PhysicsmechanicsjointCluster::copy(self : PhysicsmechanicsjointCluster) -> PhysicsmechanicsjointCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn PhysicsmechanicsjointCluster::fill(self : PhysicsmechanicsjointCluster, v : Double) -> PhysicsmechanicsjointCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn PhysicsmechanicsjointCluster::min(self : PhysicsmechanicsjointCluster) -> Double { @_common.min(self.data) }

pub fn PhysicsmechanicsjointCluster::max(self : PhysicsmechanicsjointCluster) -> Double { @_common.max(self.data) }

pub fn PhysicsmechanicsjointCluster::to_string(self : PhysicsmechanicsjointCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct PhysicsmechanicsjointModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_mechanics_joint_model_make(size : Int) -> PhysicsmechanicsjointModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn PhysicsmechanicsjointModel::len(self : PhysicsmechanicsjointModel) -> Int { self.size }

pub fn PhysicsmechanicsjointModel::get(self : PhysicsmechanicsjointModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn PhysicsmechanicsjointModel::set(self : PhysicsmechanicsjointModel, i : Int, v : Double) -> PhysicsmechanicsjointModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn PhysicsmechanicsjointModel::sum(self : PhysicsmechanicsjointModel) -> Double { @_common.sum(self.data) }

pub fn PhysicsmechanicsjointModel::mean(self : PhysicsmechanicsjointModel) -> Double { @_common.mean(self.data) }

pub fn PhysicsmechanicsjointModel::scale(self : PhysicsmechanicsjointModel, f : Double) -> PhysicsmechanicsjointModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn PhysicsmechanicsjointModel::add(self : PhysicsmechanicsjointModel, other : PhysicsmechanicsjointModel) -> PhysicsmechanicsjointModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn PhysicsmechanicsjointModel::copy(self : PhysicsmechanicsjointModel) -> PhysicsmechanicsjointModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn PhysicsmechanicsjointModel::fill(self : PhysicsmechanicsjointModel, v : Double) -> PhysicsmechanicsjointModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn PhysicsmechanicsjointModel::min(self : PhysicsmechanicsjointModel) -> Double { @_common.min(self.data) }

pub fn PhysicsmechanicsjointModel::max(self : PhysicsmechanicsjointModel) -> Double { @_common.max(self.data) }

pub fn PhysicsmechanicsjointModel::to_string(self : PhysicsmechanicsjointModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct PhysicsmechanicsjointLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_mechanics_joint_layer_make(size : Int) -> PhysicsmechanicsjointLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn PhysicsmechanicsjointLayer::len(self : PhysicsmechanicsjointLayer) -> Int { self.size }

pub fn PhysicsmechanicsjointLayer::get(self : PhysicsmechanicsjointLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn PhysicsmechanicsjointLayer::set(self : PhysicsmechanicsjointLayer, i : Int, v : Double) -> PhysicsmechanicsjointLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn PhysicsmechanicsjointLayer::sum(self : PhysicsmechanicsjointLayer) -> Double { @_common.sum(self.data) }

pub fn PhysicsmechanicsjointLayer::mean(self : PhysicsmechanicsjointLayer) -> Double { @_common.mean(self.data) }

pub fn PhysicsmechanicsjointLayer::scale(self : PhysicsmechanicsjointLayer, f : Double) -> PhysicsmechanicsjointLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn PhysicsmechanicsjointLayer::add(self : PhysicsmechanicsjointLayer, other : PhysicsmechanicsjointLayer) -> PhysicsmechanicsjointLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn PhysicsmechanicsjointLayer::copy(self : PhysicsmechanicsjointLayer) -> PhysicsmechanicsjointLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn PhysicsmechanicsjointLayer::fill(self : PhysicsmechanicsjointLayer, v : Double) -> PhysicsmechanicsjointLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn PhysicsmechanicsjointLayer::min(self : PhysicsmechanicsjointLayer) -> Double { @_common.min(self.data) }

pub fn PhysicsmechanicsjointLayer::max(self : PhysicsmechanicsjointLayer) -> Double { @_common.max(self.data) }

pub fn PhysicsmechanicsjointLayer::to_string(self : PhysicsmechanicsjointLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct PhysicsmechanicsjointBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_mechanics_joint_buffer_make(size : Int) -> PhysicsmechanicsjointBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn PhysicsmechanicsjointBuffer::len(self : PhysicsmechanicsjointBuffer) -> Int { self.size }

pub fn PhysicsmechanicsjointBuffer::get(self : PhysicsmechanicsjointBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn PhysicsmechanicsjointBuffer::set(self : PhysicsmechanicsjointBuffer, i : Int, v : Double) -> PhysicsmechanicsjointBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn PhysicsmechanicsjointBuffer::sum(self : PhysicsmechanicsjointBuffer) -> Double { @_common.sum(self.data) }

pub fn PhysicsmechanicsjointBuffer::mean(self : PhysicsmechanicsjointBuffer) -> Double { @_common.mean(self.data) }

pub fn PhysicsmechanicsjointBuffer::scale(self : PhysicsmechanicsjointBuffer, f : Double) -> PhysicsmechanicsjointBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn PhysicsmechanicsjointBuffer::add(self : PhysicsmechanicsjointBuffer, other : PhysicsmechanicsjointBuffer) -> PhysicsmechanicsjointBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn PhysicsmechanicsjointBuffer::copy(self : PhysicsmechanicsjointBuffer) -> PhysicsmechanicsjointBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn PhysicsmechanicsjointBuffer::fill(self : PhysicsmechanicsjointBuffer, v : Double) -> PhysicsmechanicsjointBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn PhysicsmechanicsjointBuffer::min(self : PhysicsmechanicsjointBuffer) -> Double { @_common.min(self.data) }

pub fn PhysicsmechanicsjointBuffer::max(self : PhysicsmechanicsjointBuffer) -> Double { @_common.max(self.data) }

pub fn PhysicsmechanicsjointBuffer::to_string(self : PhysicsmechanicsjointBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct PhysicsmechanicsjointCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_mechanics_joint_cursor_make(size : Int) -> PhysicsmechanicsjointCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn PhysicsmechanicsjointCursor::len(self : PhysicsmechanicsjointCursor) -> Int { self.size }

pub fn PhysicsmechanicsjointCursor::get(self : PhysicsmechanicsjointCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn PhysicsmechanicsjointCursor::set(self : PhysicsmechanicsjointCursor, i : Int, v : Double) -> PhysicsmechanicsjointCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn PhysicsmechanicsjointCursor::sum(self : PhysicsmechanicsjointCursor) -> Double { @_common.sum(self.data) }

pub fn PhysicsmechanicsjointCursor::mean(self : PhysicsmechanicsjointCursor) -> Double { @_common.mean(self.data) }

pub fn PhysicsmechanicsjointCursor::scale(self : PhysicsmechanicsjointCursor, f : Double) -> PhysicsmechanicsjointCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn PhysicsmechanicsjointCursor::add(self : PhysicsmechanicsjointCursor, other : PhysicsmechanicsjointCursor) -> PhysicsmechanicsjointCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn PhysicsmechanicsjointCursor::copy(self : PhysicsmechanicsjointCursor) -> PhysicsmechanicsjointCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn PhysicsmechanicsjointCursor::fill(self : PhysicsmechanicsjointCursor, v : Double) -> PhysicsmechanicsjointCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn PhysicsmechanicsjointCursor::min(self : PhysicsmechanicsjointCursor) -> Double { @_common.min(self.data) }

pub fn PhysicsmechanicsjointCursor::max(self : PhysicsmechanicsjointCursor) -> Double { @_common.max(self.data) }

pub fn PhysicsmechanicsjointCursor::to_string(self : PhysicsmechanicsjointCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct PhysicsmechanicsjointView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_mechanics_joint_view_make(size : Int) -> PhysicsmechanicsjointView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn PhysicsmechanicsjointView::len(self : PhysicsmechanicsjointView) -> Int { self.size }

pub fn PhysicsmechanicsjointView::get(self : PhysicsmechanicsjointView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn PhysicsmechanicsjointView::set(self : PhysicsmechanicsjointView, i : Int, v : Double) -> PhysicsmechanicsjointView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn PhysicsmechanicsjointView::sum(self : PhysicsmechanicsjointView) -> Double { @_common.sum(self.data) }

pub fn PhysicsmechanicsjointView::mean(self : PhysicsmechanicsjointView) -> Double { @_common.mean(self.data) }

pub fn PhysicsmechanicsjointView::scale(self : PhysicsmechanicsjointView, f : Double) -> PhysicsmechanicsjointView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn PhysicsmechanicsjointView::add(self : PhysicsmechanicsjointView, other : PhysicsmechanicsjointView) -> PhysicsmechanicsjointView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn PhysicsmechanicsjointView::copy(self : PhysicsmechanicsjointView) -> PhysicsmechanicsjointView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn PhysicsmechanicsjointView::fill(self : PhysicsmechanicsjointView, v : Double) -> PhysicsmechanicsjointView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn PhysicsmechanicsjointView::min(self : PhysicsmechanicsjointView) -> Double { @_common.min(self.data) }

pub fn PhysicsmechanicsjointView::max(self : PhysicsmechanicsjointView) -> Double { @_common.max(self.data) }

pub fn PhysicsmechanicsjointView::to_string(self : PhysicsmechanicsjointView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct PhysicsmechanicsjointRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_mechanics_joint_range_make(size : Int) -> PhysicsmechanicsjointRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn PhysicsmechanicsjointRange::len(self : PhysicsmechanicsjointRange) -> Int { self.size }

pub fn PhysicsmechanicsjointRange::get(self : PhysicsmechanicsjointRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn PhysicsmechanicsjointRange::set(self : PhysicsmechanicsjointRange, i : Int, v : Double) -> PhysicsmechanicsjointRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn PhysicsmechanicsjointRange::sum(self : PhysicsmechanicsjointRange) -> Double { @_common.sum(self.data) }

pub fn PhysicsmechanicsjointRange::mean(self : PhysicsmechanicsjointRange) -> Double { @_common.mean(self.data) }

pub fn PhysicsmechanicsjointRange::scale(self : PhysicsmechanicsjointRange, f : Double) -> PhysicsmechanicsjointRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn PhysicsmechanicsjointRange::add(self : PhysicsmechanicsjointRange, other : PhysicsmechanicsjointRange) -> PhysicsmechanicsjointRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn PhysicsmechanicsjointRange::copy(self : PhysicsmechanicsjointRange) -> PhysicsmechanicsjointRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn PhysicsmechanicsjointRange::fill(self : PhysicsmechanicsjointRange, v : Double) -> PhysicsmechanicsjointRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn PhysicsmechanicsjointRange::min(self : PhysicsmechanicsjointRange) -> Double { @_common.min(self.data) }

pub fn PhysicsmechanicsjointRange::max(self : PhysicsmechanicsjointRange) -> Double { @_common.max(self.data) }

pub fn PhysicsmechanicsjointRange::to_string(self : PhysicsmechanicsjointRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct PhysicsmechanicsjointSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_mechanics_joint_slice_make(size : Int) -> PhysicsmechanicsjointSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn PhysicsmechanicsjointSlice::len(self : PhysicsmechanicsjointSlice) -> Int { self.size }

pub fn PhysicsmechanicsjointSlice::get(self : PhysicsmechanicsjointSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn PhysicsmechanicsjointSlice::set(self : PhysicsmechanicsjointSlice, i : Int, v : Double) -> PhysicsmechanicsjointSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn PhysicsmechanicsjointSlice::sum(self : PhysicsmechanicsjointSlice) -> Double { @_common.sum(self.data) }

pub fn PhysicsmechanicsjointSlice::mean(self : PhysicsmechanicsjointSlice) -> Double { @_common.mean(self.data) }

pub fn PhysicsmechanicsjointSlice::scale(self : PhysicsmechanicsjointSlice, f : Double) -> PhysicsmechanicsjointSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn PhysicsmechanicsjointSlice::add(self : PhysicsmechanicsjointSlice, other : PhysicsmechanicsjointSlice) -> PhysicsmechanicsjointSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn PhysicsmechanicsjointSlice::copy(self : PhysicsmechanicsjointSlice) -> PhysicsmechanicsjointSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn PhysicsmechanicsjointSlice::fill(self : PhysicsmechanicsjointSlice, v : Double) -> PhysicsmechanicsjointSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn PhysicsmechanicsjointSlice::min(self : PhysicsmechanicsjointSlice) -> Double { @_common.min(self.data) }

pub fn PhysicsmechanicsjointSlice::max(self : PhysicsmechanicsjointSlice) -> Double { @_common.max(self.data) }

pub fn PhysicsmechanicsjointSlice::to_string(self : PhysicsmechanicsjointSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

