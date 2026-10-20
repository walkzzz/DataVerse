///===
/// extcore/physics_fluid_euler

pub(all) struct PhysicsfluideulerPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn physics_fluid_euler_make_point(x : Double, y : Double) -> PhysicsfluideulerPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn physics_fluid_euler_make_point3(x : Double, y : Double, z : Double) -> PhysicsfluideulerPoint {
  { x, y, z, label: 0 }
}

pub fn PhysicsfluideulerPoint::x(self : PhysicsfluideulerPoint) -> Double { self.x }

pub fn PhysicsfluideulerPoint::y(self : PhysicsfluideulerPoint) -> Double { self.y }

pub fn PhysicsfluideulerPoint::z(self : PhysicsfluideulerPoint) -> Double { self.z }

pub fn PhysicsfluideulerPoint::label(self : PhysicsfluideulerPoint) -> Int { self.label }

pub fn PhysicsfluideulerPoint::dist(self : PhysicsfluideulerPoint, other : PhysicsfluideulerPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn PhysicsfluideulerPoint::add(self : PhysicsfluideulerPoint, other : PhysicsfluideulerPoint) -> PhysicsfluideulerPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn PhysicsfluideulerPoint::sub(self : PhysicsfluideulerPoint, other : PhysicsfluideulerPoint) -> PhysicsfluideulerPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn PhysicsfluideulerPoint::scale(self : PhysicsfluideulerPoint, s : Double) -> PhysicsfluideulerPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn PhysicsfluideulerPoint::dot(self : PhysicsfluideulerPoint, other : PhysicsfluideulerPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn PhysicsfluideulerPoint::cross(self : PhysicsfluideulerPoint, other : PhysicsfluideulerPoint) -> PhysicsfluideulerPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn PhysicsfluideulerPoint::norm(self : PhysicsfluideulerPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn PhysicsfluideulerPoint::normalize(self : PhysicsfluideulerPoint) -> PhysicsfluideulerPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn PhysicsfluideulerPoint::negate(self : PhysicsfluideulerPoint) -> PhysicsfluideulerPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn PhysicsfluideulerPoint::mid(self : PhysicsfluideulerPoint, other : PhysicsfluideulerPoint) -> PhysicsfluideulerPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn PhysicsfluideulerPoint::lerp(self : PhysicsfluideulerPoint, other : PhysicsfluideulerPoint, t : Double) -> PhysicsfluideulerPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn PhysicsfluideulerPoint::to_string(self : PhysicsfluideulerPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct PhysicsfluideulerSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn physics_fluid_euler_make_series(vals : Array[Double], name : String) -> PhysicsfluideulerSeries {
  { vals, name, meta: 0 }
}

pub fn PhysicsfluideulerSeries::len(self : PhysicsfluideulerSeries) -> Int { self.vals.length() }

pub fn PhysicsfluideulerSeries::sum(self : PhysicsfluideulerSeries) -> Double { @_common.sum(self.vals) }

pub fn PhysicsfluideulerSeries::mean(self : PhysicsfluideulerSeries) -> Double { @_common.mean(self.vals) }

pub fn PhysicsfluideulerSeries::min(self : PhysicsfluideulerSeries) -> Double { @_common.min(self.vals) }

pub fn PhysicsfluideulerSeries::max(self : PhysicsfluideulerSeries) -> Double { @_common.max(self.vals) }

pub fn PhysicsfluideulerSeries::range(self : PhysicsfluideulerSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn PhysicsfluideulerSeries::variance(self : PhysicsfluideulerSeries) -> Double { @_common.variance(self.vals) }

pub fn PhysicsfluideulerSeries::std(self : PhysicsfluideulerSeries) -> Double { @_common.std(self.vals) }

pub fn PhysicsfluideulerSeries::median(self : PhysicsfluideulerSeries) -> Double { @_common.median(self.vals) }

pub fn PhysicsfluideulerSeries::scale(self : PhysicsfluideulerSeries, f : Double) -> PhysicsfluideulerSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn PhysicsfluideulerSeries::add(self : PhysicsfluideulerSeries, other : PhysicsfluideulerSeries) -> PhysicsfluideulerSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn PhysicsfluideulerSeries::sub(self : PhysicsfluideulerSeries, other : PhysicsfluideulerSeries) -> PhysicsfluideulerSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn PhysicsfluideulerSeries::normalize(self : PhysicsfluideulerSeries) -> PhysicsfluideulerSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn PhysicsfluideulerSeries::cumsum(self : PhysicsfluideulerSeries) -> PhysicsfluideulerSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn PhysicsfluideulerSeries::to_string(self : PhysicsfluideulerSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct PhysicsfluideulerMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn physics_fluid_euler_make_matrix(rows : Int, cols : Int, val : Double) -> PhysicsfluideulerMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn physics_fluid_euler_matrix_identity(n : Int) -> PhysicsfluideulerMatrix {
  let m = physics_fluid_euler_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn PhysicsfluideulerMatrix::get(self : PhysicsfluideulerMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn PhysicsfluideulerMatrix::transpose(self : PhysicsfluideulerMatrix) -> PhysicsfluideulerMatrix {
  let result = physics_fluid_euler_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn PhysicsfluideulerMatrix::add(self : PhysicsfluideulerMatrix, other : PhysicsfluideulerMatrix) -> PhysicsfluideulerMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = physics_fluid_euler_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn PhysicsfluideulerMatrix::scale(self : PhysicsfluideulerMatrix, s : Double) -> PhysicsfluideulerMatrix {
  let result = physics_fluid_euler_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn PhysicsfluideulerMatrix::multiply(self : PhysicsfluideulerMatrix, other : PhysicsfluideulerMatrix) -> PhysicsfluideulerMatrix {
  if self.cols != other.rows { return physics_fluid_euler_make_matrix(self.rows, other.cols, 0.0) }
  let result = physics_fluid_euler_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn PhysicsfluideulerMatrix::trace(self : PhysicsfluideulerMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn PhysicsfluideulerMatrix::det(self : PhysicsfluideulerMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn PhysicsfluideulerMatrix::norm(self : PhysicsfluideulerMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn PhysicsfluideulerMatrix::to_string(self : PhysicsfluideulerMatrix) -> String {
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

pub(all) struct PhysicsfluideulerVector {
  comps : Array[Double]
  dim : Int
}

pub fn physics_fluid_euler_make_vector(comps : Array[Double]) -> PhysicsfluideulerVector {
  { comps, dim: comps.length() }
}

pub fn physics_fluid_euler_vector_zero(dim : Int) -> PhysicsfluideulerVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn PhysicsfluideulerVector::add(self : PhysicsfluideulerVector, other : PhysicsfluideulerVector) -> PhysicsfluideulerVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn PhysicsfluideulerVector::sub(self : PhysicsfluideulerVector, other : PhysicsfluideulerVector) -> PhysicsfluideulerVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn PhysicsfluideulerVector::scale(self : PhysicsfluideulerVector, s : Double) -> PhysicsfluideulerVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn PhysicsfluideulerVector::dot(self : PhysicsfluideulerVector, other : PhysicsfluideulerVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn PhysicsfluideulerVector::norm(self : PhysicsfluideulerVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn PhysicsfluideulerVector::normalize(self : PhysicsfluideulerVector) -> PhysicsfluideulerVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn PhysicsfluideulerVector::dist(self : PhysicsfluideulerVector, other : PhysicsfluideulerVector) -> Double {
  self.sub(other).norm()
}

pub fn PhysicsfluideulerVector::to_string(self : PhysicsfluideulerVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn physics_fluid_euler_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn physics_fluid_euler_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn physics_fluid_euler_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn physics_fluid_euler_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn physics_fluid_euler_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn physics_fluid_euler_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn physics_fluid_euler_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn physics_fluid_euler_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn physics_fluid_euler_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn physics_fluid_euler_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn physics_fluid_euler_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn physics_fluid_euler_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn physics_fluid_euler_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn physics_fluid_euler_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn physics_fluid_euler_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn physics_fluid_euler_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn physics_fluid_euler_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn physics_fluid_euler_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn physics_fluid_euler_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn physics_fluid_euler_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn physics_fluid_euler_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn physics_fluid_euler_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn physics_fluid_euler_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn physics_fluid_euler_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn physics_fluid_euler_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn physics_fluid_euler_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn physics_fluid_euler_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn physics_fluid_euler_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn physics_fluid_euler_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct PhysicsfluideulerFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_fluid_euler_frame_make(size : Int) -> PhysicsfluideulerFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_fluid_euler_frame_len(s : PhysicsfluideulerFrame) -> Int { s.size }

pub fn physics_fluid_euler_frame_get(s : PhysicsfluideulerFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_fluid_euler_frame_set(s : PhysicsfluideulerFrame, i : Int, v : Double) -> PhysicsfluideulerFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn physics_fluid_euler_frame_sum(s : PhysicsfluideulerFrame) -> Double { @_common.sum(s.data) }

pub fn physics_fluid_euler_frame_mean(s : PhysicsfluideulerFrame) -> Double { @_common.mean(s.data) }

pub fn physics_fluid_euler_frame_scale(s : PhysicsfluideulerFrame, f : Double) -> PhysicsfluideulerFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_fluid_euler_frame_add(a : PhysicsfluideulerFrame, b : PhysicsfluideulerFrame) -> PhysicsfluideulerFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_fluid_euler_frame_copy(s : PhysicsfluideulerFrame) -> PhysicsfluideulerFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_fluid_euler_frame_fill(s : PhysicsfluideulerFrame, v : Double) -> PhysicsfluideulerFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_fluid_euler_frame_min(s : PhysicsfluideulerFrame) -> Double { @_common.min(s.data) }

pub fn physics_fluid_euler_frame_max(s : PhysicsfluideulerFrame) -> Double { @_common.max(s.data) }

pub fn physics_fluid_euler_frame_to_string(s : PhysicsfluideulerFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsfluideulerTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_fluid_euler_table_make(size : Int) -> PhysicsfluideulerTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_fluid_euler_table_len(s : PhysicsfluideulerTable) -> Int { s.size }

pub fn physics_fluid_euler_table_get(s : PhysicsfluideulerTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_fluid_euler_table_set(s : PhysicsfluideulerTable, i : Int, v : Double) -> PhysicsfluideulerTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn physics_fluid_euler_table_sum(s : PhysicsfluideulerTable) -> Double { @_common.sum(s.data) }

pub fn physics_fluid_euler_table_mean(s : PhysicsfluideulerTable) -> Double { @_common.mean(s.data) }

pub fn physics_fluid_euler_table_scale(s : PhysicsfluideulerTable, f : Double) -> PhysicsfluideulerTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_fluid_euler_table_add(a : PhysicsfluideulerTable, b : PhysicsfluideulerTable) -> PhysicsfluideulerTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_fluid_euler_table_copy(s : PhysicsfluideulerTable) -> PhysicsfluideulerTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_fluid_euler_table_fill(s : PhysicsfluideulerTable, v : Double) -> PhysicsfluideulerTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_fluid_euler_table_min(s : PhysicsfluideulerTable) -> Double { @_common.min(s.data) }

pub fn physics_fluid_euler_table_max(s : PhysicsfluideulerTable) -> Double { @_common.max(s.data) }

pub fn physics_fluid_euler_table_to_string(s : PhysicsfluideulerTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsfluideulerGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_fluid_euler_graphn_make(size : Int) -> PhysicsfluideulerGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_fluid_euler_graphn_len(s : PhysicsfluideulerGraphN) -> Int { s.size }

pub fn physics_fluid_euler_graphn_get(s : PhysicsfluideulerGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_fluid_euler_graphn_set(s : PhysicsfluideulerGraphN, i : Int, v : Double) -> PhysicsfluideulerGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn physics_fluid_euler_graphn_sum(s : PhysicsfluideulerGraphN) -> Double { @_common.sum(s.data) }

pub fn physics_fluid_euler_graphn_mean(s : PhysicsfluideulerGraphN) -> Double { @_common.mean(s.data) }

pub fn physics_fluid_euler_graphn_scale(s : PhysicsfluideulerGraphN, f : Double) -> PhysicsfluideulerGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_fluid_euler_graphn_add(a : PhysicsfluideulerGraphN, b : PhysicsfluideulerGraphN) -> PhysicsfluideulerGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_fluid_euler_graphn_copy(s : PhysicsfluideulerGraphN) -> PhysicsfluideulerGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_fluid_euler_graphn_fill(s : PhysicsfluideulerGraphN, v : Double) -> PhysicsfluideulerGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_fluid_euler_graphn_min(s : PhysicsfluideulerGraphN) -> Double { @_common.min(s.data) }

pub fn physics_fluid_euler_graphn_max(s : PhysicsfluideulerGraphN) -> Double { @_common.max(s.data) }

pub fn physics_fluid_euler_graphn_to_string(s : PhysicsfluideulerGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsfluideulerNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_fluid_euler_node_make(size : Int) -> PhysicsfluideulerNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_fluid_euler_node_len(s : PhysicsfluideulerNode) -> Int { s.size }

pub fn physics_fluid_euler_node_get(s : PhysicsfluideulerNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_fluid_euler_node_set(s : PhysicsfluideulerNode, i : Int, v : Double) -> PhysicsfluideulerNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn physics_fluid_euler_node_sum(s : PhysicsfluideulerNode) -> Double { @_common.sum(s.data) }

pub fn physics_fluid_euler_node_mean(s : PhysicsfluideulerNode) -> Double { @_common.mean(s.data) }

pub fn physics_fluid_euler_node_scale(s : PhysicsfluideulerNode, f : Double) -> PhysicsfluideulerNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_fluid_euler_node_add(a : PhysicsfluideulerNode, b : PhysicsfluideulerNode) -> PhysicsfluideulerNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_fluid_euler_node_copy(s : PhysicsfluideulerNode) -> PhysicsfluideulerNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_fluid_euler_node_fill(s : PhysicsfluideulerNode, v : Double) -> PhysicsfluideulerNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_fluid_euler_node_min(s : PhysicsfluideulerNode) -> Double { @_common.min(s.data) }

pub fn physics_fluid_euler_node_max(s : PhysicsfluideulerNode) -> Double { @_common.max(s.data) }

pub fn physics_fluid_euler_node_to_string(s : PhysicsfluideulerNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsfluideulerEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_fluid_euler_edge_make(size : Int) -> PhysicsfluideulerEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_fluid_euler_edge_len(s : PhysicsfluideulerEdge) -> Int { s.size }

pub fn physics_fluid_euler_edge_get(s : PhysicsfluideulerEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_fluid_euler_edge_set(s : PhysicsfluideulerEdge, i : Int, v : Double) -> PhysicsfluideulerEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn physics_fluid_euler_edge_sum(s : PhysicsfluideulerEdge) -> Double { @_common.sum(s.data) }

pub fn physics_fluid_euler_edge_mean(s : PhysicsfluideulerEdge) -> Double { @_common.mean(s.data) }

pub fn physics_fluid_euler_edge_scale(s : PhysicsfluideulerEdge, f : Double) -> PhysicsfluideulerEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_fluid_euler_edge_add(a : PhysicsfluideulerEdge, b : PhysicsfluideulerEdge) -> PhysicsfluideulerEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_fluid_euler_edge_copy(s : PhysicsfluideulerEdge) -> PhysicsfluideulerEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_fluid_euler_edge_fill(s : PhysicsfluideulerEdge, v : Double) -> PhysicsfluideulerEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_fluid_euler_edge_min(s : PhysicsfluideulerEdge) -> Double { @_common.min(s.data) }

pub fn physics_fluid_euler_edge_max(s : PhysicsfluideulerEdge) -> Double { @_common.max(s.data) }

pub fn physics_fluid_euler_edge_to_string(s : PhysicsfluideulerEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsfluideulerPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_fluid_euler_path_make(size : Int) -> PhysicsfluideulerPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_fluid_euler_path_len(s : PhysicsfluideulerPath) -> Int { s.size }

pub fn physics_fluid_euler_path_get(s : PhysicsfluideulerPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_fluid_euler_path_set(s : PhysicsfluideulerPath, i : Int, v : Double) -> PhysicsfluideulerPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn physics_fluid_euler_path_sum(s : PhysicsfluideulerPath) -> Double { @_common.sum(s.data) }

pub fn physics_fluid_euler_path_mean(s : PhysicsfluideulerPath) -> Double { @_common.mean(s.data) }

pub fn physics_fluid_euler_path_scale(s : PhysicsfluideulerPath, f : Double) -> PhysicsfluideulerPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_fluid_euler_path_add(a : PhysicsfluideulerPath, b : PhysicsfluideulerPath) -> PhysicsfluideulerPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_fluid_euler_path_copy(s : PhysicsfluideulerPath) -> PhysicsfluideulerPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_fluid_euler_path_fill(s : PhysicsfluideulerPath, v : Double) -> PhysicsfluideulerPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_fluid_euler_path_min(s : PhysicsfluideulerPath) -> Double { @_common.min(s.data) }

pub fn physics_fluid_euler_path_max(s : PhysicsfluideulerPath) -> Double { @_common.max(s.data) }

pub fn physics_fluid_euler_path_to_string(s : PhysicsfluideulerPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsfluideulerCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_fluid_euler_cluster_make(size : Int) -> PhysicsfluideulerCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_fluid_euler_cluster_len(s : PhysicsfluideulerCluster) -> Int { s.size }

pub fn physics_fluid_euler_cluster_get(s : PhysicsfluideulerCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_fluid_euler_cluster_set(s : PhysicsfluideulerCluster, i : Int, v : Double) -> PhysicsfluideulerCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn physics_fluid_euler_cluster_sum(s : PhysicsfluideulerCluster) -> Double { @_common.sum(s.data) }

pub fn physics_fluid_euler_cluster_mean(s : PhysicsfluideulerCluster) -> Double { @_common.mean(s.data) }

pub fn physics_fluid_euler_cluster_scale(s : PhysicsfluideulerCluster, f : Double) -> PhysicsfluideulerCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_fluid_euler_cluster_add(a : PhysicsfluideulerCluster, b : PhysicsfluideulerCluster) -> PhysicsfluideulerCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_fluid_euler_cluster_copy(s : PhysicsfluideulerCluster) -> PhysicsfluideulerCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_fluid_euler_cluster_fill(s : PhysicsfluideulerCluster, v : Double) -> PhysicsfluideulerCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_fluid_euler_cluster_min(s : PhysicsfluideulerCluster) -> Double { @_common.min(s.data) }

pub fn physics_fluid_euler_cluster_max(s : PhysicsfluideulerCluster) -> Double { @_common.max(s.data) }

pub fn physics_fluid_euler_cluster_to_string(s : PhysicsfluideulerCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsfluideulerModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_fluid_euler_model_make(size : Int) -> PhysicsfluideulerModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_fluid_euler_model_len(s : PhysicsfluideulerModel) -> Int { s.size }

pub fn physics_fluid_euler_model_get(s : PhysicsfluideulerModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_fluid_euler_model_set(s : PhysicsfluideulerModel, i : Int, v : Double) -> PhysicsfluideulerModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn physics_fluid_euler_model_sum(s : PhysicsfluideulerModel) -> Double { @_common.sum(s.data) }

pub fn physics_fluid_euler_model_mean(s : PhysicsfluideulerModel) -> Double { @_common.mean(s.data) }

pub fn physics_fluid_euler_model_scale(s : PhysicsfluideulerModel, f : Double) -> PhysicsfluideulerModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_fluid_euler_model_add(a : PhysicsfluideulerModel, b : PhysicsfluideulerModel) -> PhysicsfluideulerModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_fluid_euler_model_copy(s : PhysicsfluideulerModel) -> PhysicsfluideulerModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_fluid_euler_model_fill(s : PhysicsfluideulerModel, v : Double) -> PhysicsfluideulerModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_fluid_euler_model_min(s : PhysicsfluideulerModel) -> Double { @_common.min(s.data) }

pub fn physics_fluid_euler_model_max(s : PhysicsfluideulerModel) -> Double { @_common.max(s.data) }

pub fn physics_fluid_euler_model_to_string(s : PhysicsfluideulerModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsfluideulerLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_fluid_euler_layer_make(size : Int) -> PhysicsfluideulerLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_fluid_euler_layer_len(s : PhysicsfluideulerLayer) -> Int { s.size }

pub fn physics_fluid_euler_layer_get(s : PhysicsfluideulerLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_fluid_euler_layer_set(s : PhysicsfluideulerLayer, i : Int, v : Double) -> PhysicsfluideulerLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn physics_fluid_euler_layer_sum(s : PhysicsfluideulerLayer) -> Double { @_common.sum(s.data) }

pub fn physics_fluid_euler_layer_mean(s : PhysicsfluideulerLayer) -> Double { @_common.mean(s.data) }

pub fn physics_fluid_euler_layer_scale(s : PhysicsfluideulerLayer, f : Double) -> PhysicsfluideulerLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_fluid_euler_layer_add(a : PhysicsfluideulerLayer, b : PhysicsfluideulerLayer) -> PhysicsfluideulerLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_fluid_euler_layer_copy(s : PhysicsfluideulerLayer) -> PhysicsfluideulerLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_fluid_euler_layer_fill(s : PhysicsfluideulerLayer, v : Double) -> PhysicsfluideulerLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_fluid_euler_layer_min(s : PhysicsfluideulerLayer) -> Double { @_common.min(s.data) }

pub fn physics_fluid_euler_layer_max(s : PhysicsfluideulerLayer) -> Double { @_common.max(s.data) }

pub fn physics_fluid_euler_layer_to_string(s : PhysicsfluideulerLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsfluideulerBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_fluid_euler_buffer_make(size : Int) -> PhysicsfluideulerBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_fluid_euler_buffer_len(s : PhysicsfluideulerBuffer) -> Int { s.size }

pub fn physics_fluid_euler_buffer_get(s : PhysicsfluideulerBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_fluid_euler_buffer_set(s : PhysicsfluideulerBuffer, i : Int, v : Double) -> PhysicsfluideulerBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn physics_fluid_euler_buffer_sum(s : PhysicsfluideulerBuffer) -> Double { @_common.sum(s.data) }

pub fn physics_fluid_euler_buffer_mean(s : PhysicsfluideulerBuffer) -> Double { @_common.mean(s.data) }

pub fn physics_fluid_euler_buffer_scale(s : PhysicsfluideulerBuffer, f : Double) -> PhysicsfluideulerBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_fluid_euler_buffer_add(a : PhysicsfluideulerBuffer, b : PhysicsfluideulerBuffer) -> PhysicsfluideulerBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_fluid_euler_buffer_copy(s : PhysicsfluideulerBuffer) -> PhysicsfluideulerBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_fluid_euler_buffer_fill(s : PhysicsfluideulerBuffer, v : Double) -> PhysicsfluideulerBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_fluid_euler_buffer_min(s : PhysicsfluideulerBuffer) -> Double { @_common.min(s.data) }

pub fn physics_fluid_euler_buffer_max(s : PhysicsfluideulerBuffer) -> Double { @_common.max(s.data) }

pub fn physics_fluid_euler_buffer_to_string(s : PhysicsfluideulerBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsfluideulerCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_fluid_euler_cursor_make(size : Int) -> PhysicsfluideulerCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_fluid_euler_cursor_len(s : PhysicsfluideulerCursor) -> Int { s.size }

pub fn physics_fluid_euler_cursor_get(s : PhysicsfluideulerCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_fluid_euler_cursor_set(s : PhysicsfluideulerCursor, i : Int, v : Double) -> PhysicsfluideulerCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn physics_fluid_euler_cursor_sum(s : PhysicsfluideulerCursor) -> Double { @_common.sum(s.data) }

pub fn physics_fluid_euler_cursor_mean(s : PhysicsfluideulerCursor) -> Double { @_common.mean(s.data) }

pub fn physics_fluid_euler_cursor_scale(s : PhysicsfluideulerCursor, f : Double) -> PhysicsfluideulerCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_fluid_euler_cursor_add(a : PhysicsfluideulerCursor, b : PhysicsfluideulerCursor) -> PhysicsfluideulerCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_fluid_euler_cursor_copy(s : PhysicsfluideulerCursor) -> PhysicsfluideulerCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_fluid_euler_cursor_fill(s : PhysicsfluideulerCursor, v : Double) -> PhysicsfluideulerCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_fluid_euler_cursor_min(s : PhysicsfluideulerCursor) -> Double { @_common.min(s.data) }

pub fn physics_fluid_euler_cursor_max(s : PhysicsfluideulerCursor) -> Double { @_common.max(s.data) }

pub fn physics_fluid_euler_cursor_to_string(s : PhysicsfluideulerCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsfluideulerView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_fluid_euler_view_make(size : Int) -> PhysicsfluideulerView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_fluid_euler_view_len(s : PhysicsfluideulerView) -> Int { s.size }

pub fn physics_fluid_euler_view_get(s : PhysicsfluideulerView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_fluid_euler_view_set(s : PhysicsfluideulerView, i : Int, v : Double) -> PhysicsfluideulerView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn physics_fluid_euler_view_sum(s : PhysicsfluideulerView) -> Double { @_common.sum(s.data) }

pub fn physics_fluid_euler_view_mean(s : PhysicsfluideulerView) -> Double { @_common.mean(s.data) }

pub fn physics_fluid_euler_view_scale(s : PhysicsfluideulerView, f : Double) -> PhysicsfluideulerView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_fluid_euler_view_add(a : PhysicsfluideulerView, b : PhysicsfluideulerView) -> PhysicsfluideulerView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_fluid_euler_view_copy(s : PhysicsfluideulerView) -> PhysicsfluideulerView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_fluid_euler_view_fill(s : PhysicsfluideulerView, v : Double) -> PhysicsfluideulerView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_fluid_euler_view_min(s : PhysicsfluideulerView) -> Double { @_common.min(s.data) }

pub fn physics_fluid_euler_view_max(s : PhysicsfluideulerView) -> Double { @_common.max(s.data) }

pub fn physics_fluid_euler_view_to_string(s : PhysicsfluideulerView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsfluideulerRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_fluid_euler_range_make(size : Int) -> PhysicsfluideulerRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_fluid_euler_range_len(s : PhysicsfluideulerRange) -> Int { s.size }

pub fn physics_fluid_euler_range_get(s : PhysicsfluideulerRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_fluid_euler_range_set(s : PhysicsfluideulerRange, i : Int, v : Double) -> PhysicsfluideulerRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn physics_fluid_euler_range_sum(s : PhysicsfluideulerRange) -> Double { @_common.sum(s.data) }

pub fn physics_fluid_euler_range_mean(s : PhysicsfluideulerRange) -> Double { @_common.mean(s.data) }

pub fn physics_fluid_euler_range_scale(s : PhysicsfluideulerRange, f : Double) -> PhysicsfluideulerRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_fluid_euler_range_add(a : PhysicsfluideulerRange, b : PhysicsfluideulerRange) -> PhysicsfluideulerRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_fluid_euler_range_copy(s : PhysicsfluideulerRange) -> PhysicsfluideulerRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_fluid_euler_range_fill(s : PhysicsfluideulerRange, v : Double) -> PhysicsfluideulerRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_fluid_euler_range_min(s : PhysicsfluideulerRange) -> Double { @_common.min(s.data) }

pub fn physics_fluid_euler_range_max(s : PhysicsfluideulerRange) -> Double { @_common.max(s.data) }

pub fn physics_fluid_euler_range_to_string(s : PhysicsfluideulerRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsfluideulerSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_fluid_euler_slice_make(size : Int) -> PhysicsfluideulerSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_fluid_euler_slice_len(s : PhysicsfluideulerSlice) -> Int { s.size }

pub fn physics_fluid_euler_slice_get(s : PhysicsfluideulerSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_fluid_euler_slice_set(s : PhysicsfluideulerSlice, i : Int, v : Double) -> PhysicsfluideulerSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn physics_fluid_euler_slice_sum(s : PhysicsfluideulerSlice) -> Double { @_common.sum(s.data) }

pub fn physics_fluid_euler_slice_mean(s : PhysicsfluideulerSlice) -> Double { @_common.mean(s.data) }

pub fn physics_fluid_euler_slice_scale(s : PhysicsfluideulerSlice, f : Double) -> PhysicsfluideulerSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_fluid_euler_slice_add(a : PhysicsfluideulerSlice, b : PhysicsfluideulerSlice) -> PhysicsfluideulerSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_fluid_euler_slice_copy(s : PhysicsfluideulerSlice) -> PhysicsfluideulerSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_fluid_euler_slice_fill(s : PhysicsfluideulerSlice, v : Double) -> PhysicsfluideulerSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_fluid_euler_slice_min(s : PhysicsfluideulerSlice) -> Double { @_common.min(s.data) }

pub fn physics_fluid_euler_slice_max(s : PhysicsfluideulerSlice) -> Double { @_common.max(s.data) }

pub fn physics_fluid_euler_slice_to_string(s : PhysicsfluideulerSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

