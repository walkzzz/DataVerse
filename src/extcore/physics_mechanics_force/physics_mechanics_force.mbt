///===
/// extcore/physics_mechanics_force

pub(all) struct PhysicsmechanicsforcePoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn physics_mechanics_force_make_point(x : Double, y : Double) -> PhysicsmechanicsforcePoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn physics_mechanics_force_make_point3(x : Double, y : Double, z : Double) -> PhysicsmechanicsforcePoint {
  { x, y, z, label: 0 }
}

pub fn PhysicsmechanicsforcePoint::x(self : PhysicsmechanicsforcePoint) -> Double { self.x }

pub fn PhysicsmechanicsforcePoint::y(self : PhysicsmechanicsforcePoint) -> Double { self.y }

pub fn PhysicsmechanicsforcePoint::z(self : PhysicsmechanicsforcePoint) -> Double { self.z }

pub fn PhysicsmechanicsforcePoint::label(self : PhysicsmechanicsforcePoint) -> Int { self.label }

pub fn PhysicsmechanicsforcePoint::dist(self : PhysicsmechanicsforcePoint, other : PhysicsmechanicsforcePoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn PhysicsmechanicsforcePoint::add(self : PhysicsmechanicsforcePoint, other : PhysicsmechanicsforcePoint) -> PhysicsmechanicsforcePoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn PhysicsmechanicsforcePoint::sub(self : PhysicsmechanicsforcePoint, other : PhysicsmechanicsforcePoint) -> PhysicsmechanicsforcePoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn PhysicsmechanicsforcePoint::scale(self : PhysicsmechanicsforcePoint, s : Double) -> PhysicsmechanicsforcePoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn PhysicsmechanicsforcePoint::dot(self : PhysicsmechanicsforcePoint, other : PhysicsmechanicsforcePoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn PhysicsmechanicsforcePoint::cross(self : PhysicsmechanicsforcePoint, other : PhysicsmechanicsforcePoint) -> PhysicsmechanicsforcePoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn PhysicsmechanicsforcePoint::norm(self : PhysicsmechanicsforcePoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn PhysicsmechanicsforcePoint::normalize(self : PhysicsmechanicsforcePoint) -> PhysicsmechanicsforcePoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn PhysicsmechanicsforcePoint::negate(self : PhysicsmechanicsforcePoint) -> PhysicsmechanicsforcePoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn PhysicsmechanicsforcePoint::mid(self : PhysicsmechanicsforcePoint, other : PhysicsmechanicsforcePoint) -> PhysicsmechanicsforcePoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn PhysicsmechanicsforcePoint::lerp(self : PhysicsmechanicsforcePoint, other : PhysicsmechanicsforcePoint, t : Double) -> PhysicsmechanicsforcePoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn PhysicsmechanicsforcePoint::to_string(self : PhysicsmechanicsforcePoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct PhysicsmechanicsforceSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn physics_mechanics_force_make_series(vals : Array[Double], name : String) -> PhysicsmechanicsforceSeries {
  { vals, name, meta: 0 }
}

pub fn PhysicsmechanicsforceSeries::len(self : PhysicsmechanicsforceSeries) -> Int { self.vals.length() }

pub fn PhysicsmechanicsforceSeries::sum(self : PhysicsmechanicsforceSeries) -> Double { @_common.sum(self.vals) }

pub fn PhysicsmechanicsforceSeries::mean(self : PhysicsmechanicsforceSeries) -> Double { @_common.mean(self.vals) }

pub fn PhysicsmechanicsforceSeries::min(self : PhysicsmechanicsforceSeries) -> Double { @_common.min(self.vals) }

pub fn PhysicsmechanicsforceSeries::max(self : PhysicsmechanicsforceSeries) -> Double { @_common.max(self.vals) }

pub fn PhysicsmechanicsforceSeries::range(self : PhysicsmechanicsforceSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn PhysicsmechanicsforceSeries::variance(self : PhysicsmechanicsforceSeries) -> Double { @_common.variance(self.vals) }

pub fn PhysicsmechanicsforceSeries::std(self : PhysicsmechanicsforceSeries) -> Double { @_common.std(self.vals) }

pub fn PhysicsmechanicsforceSeries::median(self : PhysicsmechanicsforceSeries) -> Double { @_common.median(self.vals) }

pub fn PhysicsmechanicsforceSeries::scale(self : PhysicsmechanicsforceSeries, f : Double) -> PhysicsmechanicsforceSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn PhysicsmechanicsforceSeries::add(self : PhysicsmechanicsforceSeries, other : PhysicsmechanicsforceSeries) -> PhysicsmechanicsforceSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn PhysicsmechanicsforceSeries::sub(self : PhysicsmechanicsforceSeries, other : PhysicsmechanicsforceSeries) -> PhysicsmechanicsforceSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn PhysicsmechanicsforceSeries::normalize(self : PhysicsmechanicsforceSeries) -> PhysicsmechanicsforceSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn PhysicsmechanicsforceSeries::cumsum(self : PhysicsmechanicsforceSeries) -> PhysicsmechanicsforceSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn PhysicsmechanicsforceSeries::to_string(self : PhysicsmechanicsforceSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct PhysicsmechanicsforceMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn physics_mechanics_force_make_matrix(rows : Int, cols : Int, val : Double) -> PhysicsmechanicsforceMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn physics_mechanics_force_matrix_identity(n : Int) -> PhysicsmechanicsforceMatrix {
  let m = physics_mechanics_force_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn PhysicsmechanicsforceMatrix::get(self : PhysicsmechanicsforceMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn PhysicsmechanicsforceMatrix::transpose(self : PhysicsmechanicsforceMatrix) -> PhysicsmechanicsforceMatrix {
  let result = physics_mechanics_force_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn PhysicsmechanicsforceMatrix::add(self : PhysicsmechanicsforceMatrix, other : PhysicsmechanicsforceMatrix) -> PhysicsmechanicsforceMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = physics_mechanics_force_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn PhysicsmechanicsforceMatrix::scale(self : PhysicsmechanicsforceMatrix, s : Double) -> PhysicsmechanicsforceMatrix {
  let result = physics_mechanics_force_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn PhysicsmechanicsforceMatrix::multiply(self : PhysicsmechanicsforceMatrix, other : PhysicsmechanicsforceMatrix) -> PhysicsmechanicsforceMatrix {
  if self.cols != other.rows { return physics_mechanics_force_make_matrix(self.rows, other.cols, 0.0) }
  let result = physics_mechanics_force_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn PhysicsmechanicsforceMatrix::trace(self : PhysicsmechanicsforceMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn PhysicsmechanicsforceMatrix::det(self : PhysicsmechanicsforceMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn PhysicsmechanicsforceMatrix::norm(self : PhysicsmechanicsforceMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn PhysicsmechanicsforceMatrix::to_string(self : PhysicsmechanicsforceMatrix) -> String {
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

pub(all) struct PhysicsmechanicsforceVector {
  comps : Array[Double]
  dim : Int
}

pub fn physics_mechanics_force_make_vector(comps : Array[Double]) -> PhysicsmechanicsforceVector {
  { comps, dim: comps.length() }
}

pub fn physics_mechanics_force_vector_zero(dim : Int) -> PhysicsmechanicsforceVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn PhysicsmechanicsforceVector::add(self : PhysicsmechanicsforceVector, other : PhysicsmechanicsforceVector) -> PhysicsmechanicsforceVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn PhysicsmechanicsforceVector::sub(self : PhysicsmechanicsforceVector, other : PhysicsmechanicsforceVector) -> PhysicsmechanicsforceVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn PhysicsmechanicsforceVector::scale(self : PhysicsmechanicsforceVector, s : Double) -> PhysicsmechanicsforceVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn PhysicsmechanicsforceVector::dot(self : PhysicsmechanicsforceVector, other : PhysicsmechanicsforceVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn PhysicsmechanicsforceVector::norm(self : PhysicsmechanicsforceVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn PhysicsmechanicsforceVector::normalize(self : PhysicsmechanicsforceVector) -> PhysicsmechanicsforceVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn PhysicsmechanicsforceVector::dist(self : PhysicsmechanicsforceVector, other : PhysicsmechanicsforceVector) -> Double {
  self.sub(other).norm()
}

pub fn PhysicsmechanicsforceVector::to_string(self : PhysicsmechanicsforceVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn physics_mechanics_force_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn physics_mechanics_force_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn physics_mechanics_force_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn physics_mechanics_force_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn physics_mechanics_force_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn physics_mechanics_force_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn physics_mechanics_force_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn physics_mechanics_force_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn physics_mechanics_force_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn physics_mechanics_force_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn physics_mechanics_force_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn physics_mechanics_force_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn physics_mechanics_force_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn physics_mechanics_force_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn physics_mechanics_force_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn physics_mechanics_force_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn physics_mechanics_force_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn physics_mechanics_force_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn physics_mechanics_force_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn physics_mechanics_force_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn physics_mechanics_force_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn physics_mechanics_force_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn physics_mechanics_force_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn physics_mechanics_force_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn physics_mechanics_force_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn physics_mechanics_force_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn physics_mechanics_force_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn physics_mechanics_force_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn physics_mechanics_force_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct PhysicsmechanicsforceFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_mechanics_force_frame_make(size : Int) -> PhysicsmechanicsforceFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_mechanics_force_frame_len(s : PhysicsmechanicsforceFrame) -> Int { s.size }

pub fn physics_mechanics_force_frame_get(s : PhysicsmechanicsforceFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_mechanics_force_frame_set(s : PhysicsmechanicsforceFrame, i : Int, v : Double) -> PhysicsmechanicsforceFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn physics_mechanics_force_frame_sum(s : PhysicsmechanicsforceFrame) -> Double { @_common.sum(s.data) }

pub fn physics_mechanics_force_frame_mean(s : PhysicsmechanicsforceFrame) -> Double { @_common.mean(s.data) }

pub fn physics_mechanics_force_frame_scale(s : PhysicsmechanicsforceFrame, f : Double) -> PhysicsmechanicsforceFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_mechanics_force_frame_add(a : PhysicsmechanicsforceFrame, b : PhysicsmechanicsforceFrame) -> PhysicsmechanicsforceFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_mechanics_force_frame_copy(s : PhysicsmechanicsforceFrame) -> PhysicsmechanicsforceFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_mechanics_force_frame_fill(s : PhysicsmechanicsforceFrame, v : Double) -> PhysicsmechanicsforceFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_mechanics_force_frame_min(s : PhysicsmechanicsforceFrame) -> Double { @_common.min(s.data) }

pub fn physics_mechanics_force_frame_max(s : PhysicsmechanicsforceFrame) -> Double { @_common.max(s.data) }

pub fn physics_mechanics_force_frame_to_string(s : PhysicsmechanicsforceFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsmechanicsforceTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_mechanics_force_table_make(size : Int) -> PhysicsmechanicsforceTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_mechanics_force_table_len(s : PhysicsmechanicsforceTable) -> Int { s.size }

pub fn physics_mechanics_force_table_get(s : PhysicsmechanicsforceTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_mechanics_force_table_set(s : PhysicsmechanicsforceTable, i : Int, v : Double) -> PhysicsmechanicsforceTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn physics_mechanics_force_table_sum(s : PhysicsmechanicsforceTable) -> Double { @_common.sum(s.data) }

pub fn physics_mechanics_force_table_mean(s : PhysicsmechanicsforceTable) -> Double { @_common.mean(s.data) }

pub fn physics_mechanics_force_table_scale(s : PhysicsmechanicsforceTable, f : Double) -> PhysicsmechanicsforceTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_mechanics_force_table_add(a : PhysicsmechanicsforceTable, b : PhysicsmechanicsforceTable) -> PhysicsmechanicsforceTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_mechanics_force_table_copy(s : PhysicsmechanicsforceTable) -> PhysicsmechanicsforceTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_mechanics_force_table_fill(s : PhysicsmechanicsforceTable, v : Double) -> PhysicsmechanicsforceTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_mechanics_force_table_min(s : PhysicsmechanicsforceTable) -> Double { @_common.min(s.data) }

pub fn physics_mechanics_force_table_max(s : PhysicsmechanicsforceTable) -> Double { @_common.max(s.data) }

pub fn physics_mechanics_force_table_to_string(s : PhysicsmechanicsforceTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsmechanicsforceGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_mechanics_force_graphn_make(size : Int) -> PhysicsmechanicsforceGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_mechanics_force_graphn_len(s : PhysicsmechanicsforceGraphN) -> Int { s.size }

pub fn physics_mechanics_force_graphn_get(s : PhysicsmechanicsforceGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_mechanics_force_graphn_set(s : PhysicsmechanicsforceGraphN, i : Int, v : Double) -> PhysicsmechanicsforceGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn physics_mechanics_force_graphn_sum(s : PhysicsmechanicsforceGraphN) -> Double { @_common.sum(s.data) }

pub fn physics_mechanics_force_graphn_mean(s : PhysicsmechanicsforceGraphN) -> Double { @_common.mean(s.data) }

pub fn physics_mechanics_force_graphn_scale(s : PhysicsmechanicsforceGraphN, f : Double) -> PhysicsmechanicsforceGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_mechanics_force_graphn_add(a : PhysicsmechanicsforceGraphN, b : PhysicsmechanicsforceGraphN) -> PhysicsmechanicsforceGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_mechanics_force_graphn_copy(s : PhysicsmechanicsforceGraphN) -> PhysicsmechanicsforceGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_mechanics_force_graphn_fill(s : PhysicsmechanicsforceGraphN, v : Double) -> PhysicsmechanicsforceGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_mechanics_force_graphn_min(s : PhysicsmechanicsforceGraphN) -> Double { @_common.min(s.data) }

pub fn physics_mechanics_force_graphn_max(s : PhysicsmechanicsforceGraphN) -> Double { @_common.max(s.data) }

pub fn physics_mechanics_force_graphn_to_string(s : PhysicsmechanicsforceGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsmechanicsforceNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_mechanics_force_node_make(size : Int) -> PhysicsmechanicsforceNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_mechanics_force_node_len(s : PhysicsmechanicsforceNode) -> Int { s.size }

pub fn physics_mechanics_force_node_get(s : PhysicsmechanicsforceNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_mechanics_force_node_set(s : PhysicsmechanicsforceNode, i : Int, v : Double) -> PhysicsmechanicsforceNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn physics_mechanics_force_node_sum(s : PhysicsmechanicsforceNode) -> Double { @_common.sum(s.data) }

pub fn physics_mechanics_force_node_mean(s : PhysicsmechanicsforceNode) -> Double { @_common.mean(s.data) }

pub fn physics_mechanics_force_node_scale(s : PhysicsmechanicsforceNode, f : Double) -> PhysicsmechanicsforceNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_mechanics_force_node_add(a : PhysicsmechanicsforceNode, b : PhysicsmechanicsforceNode) -> PhysicsmechanicsforceNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_mechanics_force_node_copy(s : PhysicsmechanicsforceNode) -> PhysicsmechanicsforceNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_mechanics_force_node_fill(s : PhysicsmechanicsforceNode, v : Double) -> PhysicsmechanicsforceNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_mechanics_force_node_min(s : PhysicsmechanicsforceNode) -> Double { @_common.min(s.data) }

pub fn physics_mechanics_force_node_max(s : PhysicsmechanicsforceNode) -> Double { @_common.max(s.data) }

pub fn physics_mechanics_force_node_to_string(s : PhysicsmechanicsforceNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsmechanicsforceEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_mechanics_force_edge_make(size : Int) -> PhysicsmechanicsforceEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_mechanics_force_edge_len(s : PhysicsmechanicsforceEdge) -> Int { s.size }

pub fn physics_mechanics_force_edge_get(s : PhysicsmechanicsforceEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_mechanics_force_edge_set(s : PhysicsmechanicsforceEdge, i : Int, v : Double) -> PhysicsmechanicsforceEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn physics_mechanics_force_edge_sum(s : PhysicsmechanicsforceEdge) -> Double { @_common.sum(s.data) }

pub fn physics_mechanics_force_edge_mean(s : PhysicsmechanicsforceEdge) -> Double { @_common.mean(s.data) }

pub fn physics_mechanics_force_edge_scale(s : PhysicsmechanicsforceEdge, f : Double) -> PhysicsmechanicsforceEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_mechanics_force_edge_add(a : PhysicsmechanicsforceEdge, b : PhysicsmechanicsforceEdge) -> PhysicsmechanicsforceEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_mechanics_force_edge_copy(s : PhysicsmechanicsforceEdge) -> PhysicsmechanicsforceEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_mechanics_force_edge_fill(s : PhysicsmechanicsforceEdge, v : Double) -> PhysicsmechanicsforceEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_mechanics_force_edge_min(s : PhysicsmechanicsforceEdge) -> Double { @_common.min(s.data) }

pub fn physics_mechanics_force_edge_max(s : PhysicsmechanicsforceEdge) -> Double { @_common.max(s.data) }

pub fn physics_mechanics_force_edge_to_string(s : PhysicsmechanicsforceEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsmechanicsforcePath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_mechanics_force_path_make(size : Int) -> PhysicsmechanicsforcePath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_mechanics_force_path_len(s : PhysicsmechanicsforcePath) -> Int { s.size }

pub fn physics_mechanics_force_path_get(s : PhysicsmechanicsforcePath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_mechanics_force_path_set(s : PhysicsmechanicsforcePath, i : Int, v : Double) -> PhysicsmechanicsforcePath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn physics_mechanics_force_path_sum(s : PhysicsmechanicsforcePath) -> Double { @_common.sum(s.data) }

pub fn physics_mechanics_force_path_mean(s : PhysicsmechanicsforcePath) -> Double { @_common.mean(s.data) }

pub fn physics_mechanics_force_path_scale(s : PhysicsmechanicsforcePath, f : Double) -> PhysicsmechanicsforcePath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_mechanics_force_path_add(a : PhysicsmechanicsforcePath, b : PhysicsmechanicsforcePath) -> PhysicsmechanicsforcePath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_mechanics_force_path_copy(s : PhysicsmechanicsforcePath) -> PhysicsmechanicsforcePath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_mechanics_force_path_fill(s : PhysicsmechanicsforcePath, v : Double) -> PhysicsmechanicsforcePath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_mechanics_force_path_min(s : PhysicsmechanicsforcePath) -> Double { @_common.min(s.data) }

pub fn physics_mechanics_force_path_max(s : PhysicsmechanicsforcePath) -> Double { @_common.max(s.data) }

pub fn physics_mechanics_force_path_to_string(s : PhysicsmechanicsforcePath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsmechanicsforceCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_mechanics_force_cluster_make(size : Int) -> PhysicsmechanicsforceCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_mechanics_force_cluster_len(s : PhysicsmechanicsforceCluster) -> Int { s.size }

pub fn physics_mechanics_force_cluster_get(s : PhysicsmechanicsforceCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_mechanics_force_cluster_set(s : PhysicsmechanicsforceCluster, i : Int, v : Double) -> PhysicsmechanicsforceCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn physics_mechanics_force_cluster_sum(s : PhysicsmechanicsforceCluster) -> Double { @_common.sum(s.data) }

pub fn physics_mechanics_force_cluster_mean(s : PhysicsmechanicsforceCluster) -> Double { @_common.mean(s.data) }

pub fn physics_mechanics_force_cluster_scale(s : PhysicsmechanicsforceCluster, f : Double) -> PhysicsmechanicsforceCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_mechanics_force_cluster_add(a : PhysicsmechanicsforceCluster, b : PhysicsmechanicsforceCluster) -> PhysicsmechanicsforceCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_mechanics_force_cluster_copy(s : PhysicsmechanicsforceCluster) -> PhysicsmechanicsforceCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_mechanics_force_cluster_fill(s : PhysicsmechanicsforceCluster, v : Double) -> PhysicsmechanicsforceCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_mechanics_force_cluster_min(s : PhysicsmechanicsforceCluster) -> Double { @_common.min(s.data) }

pub fn physics_mechanics_force_cluster_max(s : PhysicsmechanicsforceCluster) -> Double { @_common.max(s.data) }

pub fn physics_mechanics_force_cluster_to_string(s : PhysicsmechanicsforceCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsmechanicsforceModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_mechanics_force_model_make(size : Int) -> PhysicsmechanicsforceModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_mechanics_force_model_len(s : PhysicsmechanicsforceModel) -> Int { s.size }

pub fn physics_mechanics_force_model_get(s : PhysicsmechanicsforceModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_mechanics_force_model_set(s : PhysicsmechanicsforceModel, i : Int, v : Double) -> PhysicsmechanicsforceModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn physics_mechanics_force_model_sum(s : PhysicsmechanicsforceModel) -> Double { @_common.sum(s.data) }

pub fn physics_mechanics_force_model_mean(s : PhysicsmechanicsforceModel) -> Double { @_common.mean(s.data) }

pub fn physics_mechanics_force_model_scale(s : PhysicsmechanicsforceModel, f : Double) -> PhysicsmechanicsforceModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_mechanics_force_model_add(a : PhysicsmechanicsforceModel, b : PhysicsmechanicsforceModel) -> PhysicsmechanicsforceModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_mechanics_force_model_copy(s : PhysicsmechanicsforceModel) -> PhysicsmechanicsforceModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_mechanics_force_model_fill(s : PhysicsmechanicsforceModel, v : Double) -> PhysicsmechanicsforceModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_mechanics_force_model_min(s : PhysicsmechanicsforceModel) -> Double { @_common.min(s.data) }

pub fn physics_mechanics_force_model_max(s : PhysicsmechanicsforceModel) -> Double { @_common.max(s.data) }

pub fn physics_mechanics_force_model_to_string(s : PhysicsmechanicsforceModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsmechanicsforceLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_mechanics_force_layer_make(size : Int) -> PhysicsmechanicsforceLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_mechanics_force_layer_len(s : PhysicsmechanicsforceLayer) -> Int { s.size }

pub fn physics_mechanics_force_layer_get(s : PhysicsmechanicsforceLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_mechanics_force_layer_set(s : PhysicsmechanicsforceLayer, i : Int, v : Double) -> PhysicsmechanicsforceLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn physics_mechanics_force_layer_sum(s : PhysicsmechanicsforceLayer) -> Double { @_common.sum(s.data) }

pub fn physics_mechanics_force_layer_mean(s : PhysicsmechanicsforceLayer) -> Double { @_common.mean(s.data) }

pub fn physics_mechanics_force_layer_scale(s : PhysicsmechanicsforceLayer, f : Double) -> PhysicsmechanicsforceLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_mechanics_force_layer_add(a : PhysicsmechanicsforceLayer, b : PhysicsmechanicsforceLayer) -> PhysicsmechanicsforceLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_mechanics_force_layer_copy(s : PhysicsmechanicsforceLayer) -> PhysicsmechanicsforceLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_mechanics_force_layer_fill(s : PhysicsmechanicsforceLayer, v : Double) -> PhysicsmechanicsforceLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_mechanics_force_layer_min(s : PhysicsmechanicsforceLayer) -> Double { @_common.min(s.data) }

pub fn physics_mechanics_force_layer_max(s : PhysicsmechanicsforceLayer) -> Double { @_common.max(s.data) }

pub fn physics_mechanics_force_layer_to_string(s : PhysicsmechanicsforceLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsmechanicsforceBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_mechanics_force_buffer_make(size : Int) -> PhysicsmechanicsforceBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_mechanics_force_buffer_len(s : PhysicsmechanicsforceBuffer) -> Int { s.size }

pub fn physics_mechanics_force_buffer_get(s : PhysicsmechanicsforceBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_mechanics_force_buffer_set(s : PhysicsmechanicsforceBuffer, i : Int, v : Double) -> PhysicsmechanicsforceBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn physics_mechanics_force_buffer_sum(s : PhysicsmechanicsforceBuffer) -> Double { @_common.sum(s.data) }

pub fn physics_mechanics_force_buffer_mean(s : PhysicsmechanicsforceBuffer) -> Double { @_common.mean(s.data) }

pub fn physics_mechanics_force_buffer_scale(s : PhysicsmechanicsforceBuffer, f : Double) -> PhysicsmechanicsforceBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_mechanics_force_buffer_add(a : PhysicsmechanicsforceBuffer, b : PhysicsmechanicsforceBuffer) -> PhysicsmechanicsforceBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_mechanics_force_buffer_copy(s : PhysicsmechanicsforceBuffer) -> PhysicsmechanicsforceBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_mechanics_force_buffer_fill(s : PhysicsmechanicsforceBuffer, v : Double) -> PhysicsmechanicsforceBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_mechanics_force_buffer_min(s : PhysicsmechanicsforceBuffer) -> Double { @_common.min(s.data) }

pub fn physics_mechanics_force_buffer_max(s : PhysicsmechanicsforceBuffer) -> Double { @_common.max(s.data) }

pub fn physics_mechanics_force_buffer_to_string(s : PhysicsmechanicsforceBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsmechanicsforceCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_mechanics_force_cursor_make(size : Int) -> PhysicsmechanicsforceCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_mechanics_force_cursor_len(s : PhysicsmechanicsforceCursor) -> Int { s.size }

pub fn physics_mechanics_force_cursor_get(s : PhysicsmechanicsforceCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_mechanics_force_cursor_set(s : PhysicsmechanicsforceCursor, i : Int, v : Double) -> PhysicsmechanicsforceCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn physics_mechanics_force_cursor_sum(s : PhysicsmechanicsforceCursor) -> Double { @_common.sum(s.data) }

pub fn physics_mechanics_force_cursor_mean(s : PhysicsmechanicsforceCursor) -> Double { @_common.mean(s.data) }

pub fn physics_mechanics_force_cursor_scale(s : PhysicsmechanicsforceCursor, f : Double) -> PhysicsmechanicsforceCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_mechanics_force_cursor_add(a : PhysicsmechanicsforceCursor, b : PhysicsmechanicsforceCursor) -> PhysicsmechanicsforceCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_mechanics_force_cursor_copy(s : PhysicsmechanicsforceCursor) -> PhysicsmechanicsforceCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_mechanics_force_cursor_fill(s : PhysicsmechanicsforceCursor, v : Double) -> PhysicsmechanicsforceCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_mechanics_force_cursor_min(s : PhysicsmechanicsforceCursor) -> Double { @_common.min(s.data) }

pub fn physics_mechanics_force_cursor_max(s : PhysicsmechanicsforceCursor) -> Double { @_common.max(s.data) }

pub fn physics_mechanics_force_cursor_to_string(s : PhysicsmechanicsforceCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsmechanicsforceView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_mechanics_force_view_make(size : Int) -> PhysicsmechanicsforceView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_mechanics_force_view_len(s : PhysicsmechanicsforceView) -> Int { s.size }

pub fn physics_mechanics_force_view_get(s : PhysicsmechanicsforceView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_mechanics_force_view_set(s : PhysicsmechanicsforceView, i : Int, v : Double) -> PhysicsmechanicsforceView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn physics_mechanics_force_view_sum(s : PhysicsmechanicsforceView) -> Double { @_common.sum(s.data) }

pub fn physics_mechanics_force_view_mean(s : PhysicsmechanicsforceView) -> Double { @_common.mean(s.data) }

pub fn physics_mechanics_force_view_scale(s : PhysicsmechanicsforceView, f : Double) -> PhysicsmechanicsforceView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_mechanics_force_view_add(a : PhysicsmechanicsforceView, b : PhysicsmechanicsforceView) -> PhysicsmechanicsforceView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_mechanics_force_view_copy(s : PhysicsmechanicsforceView) -> PhysicsmechanicsforceView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_mechanics_force_view_fill(s : PhysicsmechanicsforceView, v : Double) -> PhysicsmechanicsforceView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_mechanics_force_view_min(s : PhysicsmechanicsforceView) -> Double { @_common.min(s.data) }

pub fn physics_mechanics_force_view_max(s : PhysicsmechanicsforceView) -> Double { @_common.max(s.data) }

pub fn physics_mechanics_force_view_to_string(s : PhysicsmechanicsforceView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsmechanicsforceRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_mechanics_force_range_make(size : Int) -> PhysicsmechanicsforceRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_mechanics_force_range_len(s : PhysicsmechanicsforceRange) -> Int { s.size }

pub fn physics_mechanics_force_range_get(s : PhysicsmechanicsforceRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_mechanics_force_range_set(s : PhysicsmechanicsforceRange, i : Int, v : Double) -> PhysicsmechanicsforceRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn physics_mechanics_force_range_sum(s : PhysicsmechanicsforceRange) -> Double { @_common.sum(s.data) }

pub fn physics_mechanics_force_range_mean(s : PhysicsmechanicsforceRange) -> Double { @_common.mean(s.data) }

pub fn physics_mechanics_force_range_scale(s : PhysicsmechanicsforceRange, f : Double) -> PhysicsmechanicsforceRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_mechanics_force_range_add(a : PhysicsmechanicsforceRange, b : PhysicsmechanicsforceRange) -> PhysicsmechanicsforceRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_mechanics_force_range_copy(s : PhysicsmechanicsforceRange) -> PhysicsmechanicsforceRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_mechanics_force_range_fill(s : PhysicsmechanicsforceRange, v : Double) -> PhysicsmechanicsforceRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_mechanics_force_range_min(s : PhysicsmechanicsforceRange) -> Double { @_common.min(s.data) }

pub fn physics_mechanics_force_range_max(s : PhysicsmechanicsforceRange) -> Double { @_common.max(s.data) }

pub fn physics_mechanics_force_range_to_string(s : PhysicsmechanicsforceRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsmechanicsforceSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_mechanics_force_slice_make(size : Int) -> PhysicsmechanicsforceSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_mechanics_force_slice_len(s : PhysicsmechanicsforceSlice) -> Int { s.size }

pub fn physics_mechanics_force_slice_get(s : PhysicsmechanicsforceSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_mechanics_force_slice_set(s : PhysicsmechanicsforceSlice, i : Int, v : Double) -> PhysicsmechanicsforceSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn physics_mechanics_force_slice_sum(s : PhysicsmechanicsforceSlice) -> Double { @_common.sum(s.data) }

pub fn physics_mechanics_force_slice_mean(s : PhysicsmechanicsforceSlice) -> Double { @_common.mean(s.data) }

pub fn physics_mechanics_force_slice_scale(s : PhysicsmechanicsforceSlice, f : Double) -> PhysicsmechanicsforceSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_mechanics_force_slice_add(a : PhysicsmechanicsforceSlice, b : PhysicsmechanicsforceSlice) -> PhysicsmechanicsforceSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_mechanics_force_slice_copy(s : PhysicsmechanicsforceSlice) -> PhysicsmechanicsforceSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_mechanics_force_slice_fill(s : PhysicsmechanicsforceSlice, v : Double) -> PhysicsmechanicsforceSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_mechanics_force_slice_min(s : PhysicsmechanicsforceSlice) -> Double { @_common.min(s.data) }

pub fn physics_mechanics_force_slice_max(s : PhysicsmechanicsforceSlice) -> Double { @_common.max(s.data) }

pub fn physics_mechanics_force_slice_to_string(s : PhysicsmechanicsforceSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

