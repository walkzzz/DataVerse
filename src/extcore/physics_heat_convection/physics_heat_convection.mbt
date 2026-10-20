///===
/// extcore/physics_heat_convection

pub(all) struct PhysicsheatconvectionPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn physics_heat_convection_make_point(x : Double, y : Double) -> PhysicsheatconvectionPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn physics_heat_convection_make_point3(x : Double, y : Double, z : Double) -> PhysicsheatconvectionPoint {
  { x, y, z, label: 0 }
}

pub fn PhysicsheatconvectionPoint::x(self : PhysicsheatconvectionPoint) -> Double { self.x }

pub fn PhysicsheatconvectionPoint::y(self : PhysicsheatconvectionPoint) -> Double { self.y }

pub fn PhysicsheatconvectionPoint::z(self : PhysicsheatconvectionPoint) -> Double { self.z }

pub fn PhysicsheatconvectionPoint::label(self : PhysicsheatconvectionPoint) -> Int { self.label }

pub fn PhysicsheatconvectionPoint::dist(self : PhysicsheatconvectionPoint, other : PhysicsheatconvectionPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn PhysicsheatconvectionPoint::add(self : PhysicsheatconvectionPoint, other : PhysicsheatconvectionPoint) -> PhysicsheatconvectionPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn PhysicsheatconvectionPoint::sub(self : PhysicsheatconvectionPoint, other : PhysicsheatconvectionPoint) -> PhysicsheatconvectionPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn PhysicsheatconvectionPoint::scale(self : PhysicsheatconvectionPoint, s : Double) -> PhysicsheatconvectionPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn PhysicsheatconvectionPoint::dot(self : PhysicsheatconvectionPoint, other : PhysicsheatconvectionPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn PhysicsheatconvectionPoint::cross(self : PhysicsheatconvectionPoint, other : PhysicsheatconvectionPoint) -> PhysicsheatconvectionPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn PhysicsheatconvectionPoint::norm(self : PhysicsheatconvectionPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn PhysicsheatconvectionPoint::normalize(self : PhysicsheatconvectionPoint) -> PhysicsheatconvectionPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn PhysicsheatconvectionPoint::negate(self : PhysicsheatconvectionPoint) -> PhysicsheatconvectionPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn PhysicsheatconvectionPoint::mid(self : PhysicsheatconvectionPoint, other : PhysicsheatconvectionPoint) -> PhysicsheatconvectionPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn PhysicsheatconvectionPoint::lerp(self : PhysicsheatconvectionPoint, other : PhysicsheatconvectionPoint, t : Double) -> PhysicsheatconvectionPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn PhysicsheatconvectionPoint::to_string(self : PhysicsheatconvectionPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct PhysicsheatconvectionSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn physics_heat_convection_make_series(vals : Array[Double], name : String) -> PhysicsheatconvectionSeries {
  { vals, name, meta: 0 }
}

pub fn PhysicsheatconvectionSeries::len(self : PhysicsheatconvectionSeries) -> Int { self.vals.length() }

pub fn PhysicsheatconvectionSeries::sum(self : PhysicsheatconvectionSeries) -> Double { @_common.sum(self.vals) }

pub fn PhysicsheatconvectionSeries::mean(self : PhysicsheatconvectionSeries) -> Double { @_common.mean(self.vals) }

pub fn PhysicsheatconvectionSeries::min(self : PhysicsheatconvectionSeries) -> Double { @_common.min(self.vals) }

pub fn PhysicsheatconvectionSeries::max(self : PhysicsheatconvectionSeries) -> Double { @_common.max(self.vals) }

pub fn PhysicsheatconvectionSeries::range(self : PhysicsheatconvectionSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn PhysicsheatconvectionSeries::variance(self : PhysicsheatconvectionSeries) -> Double { @_common.variance(self.vals) }

pub fn PhysicsheatconvectionSeries::std(self : PhysicsheatconvectionSeries) -> Double { @_common.std(self.vals) }

pub fn PhysicsheatconvectionSeries::median(self : PhysicsheatconvectionSeries) -> Double { @_common.median(self.vals) }

pub fn PhysicsheatconvectionSeries::scale(self : PhysicsheatconvectionSeries, f : Double) -> PhysicsheatconvectionSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn PhysicsheatconvectionSeries::add(self : PhysicsheatconvectionSeries, other : PhysicsheatconvectionSeries) -> PhysicsheatconvectionSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn PhysicsheatconvectionSeries::sub(self : PhysicsheatconvectionSeries, other : PhysicsheatconvectionSeries) -> PhysicsheatconvectionSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn PhysicsheatconvectionSeries::normalize(self : PhysicsheatconvectionSeries) -> PhysicsheatconvectionSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn PhysicsheatconvectionSeries::cumsum(self : PhysicsheatconvectionSeries) -> PhysicsheatconvectionSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn PhysicsheatconvectionSeries::to_string(self : PhysicsheatconvectionSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct PhysicsheatconvectionMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn physics_heat_convection_make_matrix(rows : Int, cols : Int, val : Double) -> PhysicsheatconvectionMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn physics_heat_convection_matrix_identity(n : Int) -> PhysicsheatconvectionMatrix {
  let m = physics_heat_convection_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn PhysicsheatconvectionMatrix::get(self : PhysicsheatconvectionMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn PhysicsheatconvectionMatrix::transpose(self : PhysicsheatconvectionMatrix) -> PhysicsheatconvectionMatrix {
  let result = physics_heat_convection_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn PhysicsheatconvectionMatrix::add(self : PhysicsheatconvectionMatrix, other : PhysicsheatconvectionMatrix) -> PhysicsheatconvectionMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = physics_heat_convection_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn PhysicsheatconvectionMatrix::scale(self : PhysicsheatconvectionMatrix, s : Double) -> PhysicsheatconvectionMatrix {
  let result = physics_heat_convection_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn PhysicsheatconvectionMatrix::multiply(self : PhysicsheatconvectionMatrix, other : PhysicsheatconvectionMatrix) -> PhysicsheatconvectionMatrix {
  if self.cols != other.rows { return physics_heat_convection_make_matrix(self.rows, other.cols, 0.0) }
  let result = physics_heat_convection_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn PhysicsheatconvectionMatrix::trace(self : PhysicsheatconvectionMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn PhysicsheatconvectionMatrix::det(self : PhysicsheatconvectionMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn PhysicsheatconvectionMatrix::norm(self : PhysicsheatconvectionMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn PhysicsheatconvectionMatrix::to_string(self : PhysicsheatconvectionMatrix) -> String {
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

pub(all) struct PhysicsheatconvectionVector {
  comps : Array[Double]
  dim : Int
}

pub fn physics_heat_convection_make_vector(comps : Array[Double]) -> PhysicsheatconvectionVector {
  { comps, dim: comps.length() }
}

pub fn physics_heat_convection_vector_zero(dim : Int) -> PhysicsheatconvectionVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn PhysicsheatconvectionVector::add(self : PhysicsheatconvectionVector, other : PhysicsheatconvectionVector) -> PhysicsheatconvectionVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn PhysicsheatconvectionVector::sub(self : PhysicsheatconvectionVector, other : PhysicsheatconvectionVector) -> PhysicsheatconvectionVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn PhysicsheatconvectionVector::scale(self : PhysicsheatconvectionVector, s : Double) -> PhysicsheatconvectionVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn PhysicsheatconvectionVector::dot(self : PhysicsheatconvectionVector, other : PhysicsheatconvectionVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn PhysicsheatconvectionVector::norm(self : PhysicsheatconvectionVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn PhysicsheatconvectionVector::normalize(self : PhysicsheatconvectionVector) -> PhysicsheatconvectionVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn PhysicsheatconvectionVector::dist(self : PhysicsheatconvectionVector, other : PhysicsheatconvectionVector) -> Double {
  self.sub(other).norm()
}

pub fn PhysicsheatconvectionVector::to_string(self : PhysicsheatconvectionVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn physics_heat_convection_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn physics_heat_convection_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn physics_heat_convection_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn physics_heat_convection_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn physics_heat_convection_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn physics_heat_convection_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn physics_heat_convection_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn physics_heat_convection_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn physics_heat_convection_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn physics_heat_convection_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn physics_heat_convection_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn physics_heat_convection_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn physics_heat_convection_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn physics_heat_convection_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn physics_heat_convection_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn physics_heat_convection_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn physics_heat_convection_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn physics_heat_convection_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn physics_heat_convection_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn physics_heat_convection_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn physics_heat_convection_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn physics_heat_convection_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn physics_heat_convection_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn physics_heat_convection_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn physics_heat_convection_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn physics_heat_convection_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn physics_heat_convection_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn physics_heat_convection_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn physics_heat_convection_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct PhysicsheatconvectionFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_heat_convection_frame_make(size : Int) -> PhysicsheatconvectionFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_heat_convection_frame_len(s : PhysicsheatconvectionFrame) -> Int { s.size }

pub fn physics_heat_convection_frame_get(s : PhysicsheatconvectionFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_heat_convection_frame_set(s : PhysicsheatconvectionFrame, i : Int, v : Double) -> PhysicsheatconvectionFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn physics_heat_convection_frame_sum(s : PhysicsheatconvectionFrame) -> Double { @_common.sum(s.data) }

pub fn physics_heat_convection_frame_mean(s : PhysicsheatconvectionFrame) -> Double { @_common.mean(s.data) }

pub fn physics_heat_convection_frame_scale(s : PhysicsheatconvectionFrame, f : Double) -> PhysicsheatconvectionFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_heat_convection_frame_add(a : PhysicsheatconvectionFrame, b : PhysicsheatconvectionFrame) -> PhysicsheatconvectionFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_heat_convection_frame_copy(s : PhysicsheatconvectionFrame) -> PhysicsheatconvectionFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_heat_convection_frame_fill(s : PhysicsheatconvectionFrame, v : Double) -> PhysicsheatconvectionFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_heat_convection_frame_min(s : PhysicsheatconvectionFrame) -> Double { @_common.min(s.data) }

pub fn physics_heat_convection_frame_max(s : PhysicsheatconvectionFrame) -> Double { @_common.max(s.data) }

pub fn physics_heat_convection_frame_to_string(s : PhysicsheatconvectionFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsheatconvectionTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_heat_convection_table_make(size : Int) -> PhysicsheatconvectionTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_heat_convection_table_len(s : PhysicsheatconvectionTable) -> Int { s.size }

pub fn physics_heat_convection_table_get(s : PhysicsheatconvectionTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_heat_convection_table_set(s : PhysicsheatconvectionTable, i : Int, v : Double) -> PhysicsheatconvectionTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn physics_heat_convection_table_sum(s : PhysicsheatconvectionTable) -> Double { @_common.sum(s.data) }

pub fn physics_heat_convection_table_mean(s : PhysicsheatconvectionTable) -> Double { @_common.mean(s.data) }

pub fn physics_heat_convection_table_scale(s : PhysicsheatconvectionTable, f : Double) -> PhysicsheatconvectionTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_heat_convection_table_add(a : PhysicsheatconvectionTable, b : PhysicsheatconvectionTable) -> PhysicsheatconvectionTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_heat_convection_table_copy(s : PhysicsheatconvectionTable) -> PhysicsheatconvectionTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_heat_convection_table_fill(s : PhysicsheatconvectionTable, v : Double) -> PhysicsheatconvectionTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_heat_convection_table_min(s : PhysicsheatconvectionTable) -> Double { @_common.min(s.data) }

pub fn physics_heat_convection_table_max(s : PhysicsheatconvectionTable) -> Double { @_common.max(s.data) }

pub fn physics_heat_convection_table_to_string(s : PhysicsheatconvectionTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsheatconvectionGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_heat_convection_graphn_make(size : Int) -> PhysicsheatconvectionGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_heat_convection_graphn_len(s : PhysicsheatconvectionGraphN) -> Int { s.size }

pub fn physics_heat_convection_graphn_get(s : PhysicsheatconvectionGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_heat_convection_graphn_set(s : PhysicsheatconvectionGraphN, i : Int, v : Double) -> PhysicsheatconvectionGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn physics_heat_convection_graphn_sum(s : PhysicsheatconvectionGraphN) -> Double { @_common.sum(s.data) }

pub fn physics_heat_convection_graphn_mean(s : PhysicsheatconvectionGraphN) -> Double { @_common.mean(s.data) }

pub fn physics_heat_convection_graphn_scale(s : PhysicsheatconvectionGraphN, f : Double) -> PhysicsheatconvectionGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_heat_convection_graphn_add(a : PhysicsheatconvectionGraphN, b : PhysicsheatconvectionGraphN) -> PhysicsheatconvectionGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_heat_convection_graphn_copy(s : PhysicsheatconvectionGraphN) -> PhysicsheatconvectionGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_heat_convection_graphn_fill(s : PhysicsheatconvectionGraphN, v : Double) -> PhysicsheatconvectionGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_heat_convection_graphn_min(s : PhysicsheatconvectionGraphN) -> Double { @_common.min(s.data) }

pub fn physics_heat_convection_graphn_max(s : PhysicsheatconvectionGraphN) -> Double { @_common.max(s.data) }

pub fn physics_heat_convection_graphn_to_string(s : PhysicsheatconvectionGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsheatconvectionNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_heat_convection_node_make(size : Int) -> PhysicsheatconvectionNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_heat_convection_node_len(s : PhysicsheatconvectionNode) -> Int { s.size }

pub fn physics_heat_convection_node_get(s : PhysicsheatconvectionNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_heat_convection_node_set(s : PhysicsheatconvectionNode, i : Int, v : Double) -> PhysicsheatconvectionNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn physics_heat_convection_node_sum(s : PhysicsheatconvectionNode) -> Double { @_common.sum(s.data) }

pub fn physics_heat_convection_node_mean(s : PhysicsheatconvectionNode) -> Double { @_common.mean(s.data) }

pub fn physics_heat_convection_node_scale(s : PhysicsheatconvectionNode, f : Double) -> PhysicsheatconvectionNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_heat_convection_node_add(a : PhysicsheatconvectionNode, b : PhysicsheatconvectionNode) -> PhysicsheatconvectionNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_heat_convection_node_copy(s : PhysicsheatconvectionNode) -> PhysicsheatconvectionNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_heat_convection_node_fill(s : PhysicsheatconvectionNode, v : Double) -> PhysicsheatconvectionNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_heat_convection_node_min(s : PhysicsheatconvectionNode) -> Double { @_common.min(s.data) }

pub fn physics_heat_convection_node_max(s : PhysicsheatconvectionNode) -> Double { @_common.max(s.data) }

pub fn physics_heat_convection_node_to_string(s : PhysicsheatconvectionNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsheatconvectionEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_heat_convection_edge_make(size : Int) -> PhysicsheatconvectionEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_heat_convection_edge_len(s : PhysicsheatconvectionEdge) -> Int { s.size }

pub fn physics_heat_convection_edge_get(s : PhysicsheatconvectionEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_heat_convection_edge_set(s : PhysicsheatconvectionEdge, i : Int, v : Double) -> PhysicsheatconvectionEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn physics_heat_convection_edge_sum(s : PhysicsheatconvectionEdge) -> Double { @_common.sum(s.data) }

pub fn physics_heat_convection_edge_mean(s : PhysicsheatconvectionEdge) -> Double { @_common.mean(s.data) }

pub fn physics_heat_convection_edge_scale(s : PhysicsheatconvectionEdge, f : Double) -> PhysicsheatconvectionEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_heat_convection_edge_add(a : PhysicsheatconvectionEdge, b : PhysicsheatconvectionEdge) -> PhysicsheatconvectionEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_heat_convection_edge_copy(s : PhysicsheatconvectionEdge) -> PhysicsheatconvectionEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_heat_convection_edge_fill(s : PhysicsheatconvectionEdge, v : Double) -> PhysicsheatconvectionEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_heat_convection_edge_min(s : PhysicsheatconvectionEdge) -> Double { @_common.min(s.data) }

pub fn physics_heat_convection_edge_max(s : PhysicsheatconvectionEdge) -> Double { @_common.max(s.data) }

pub fn physics_heat_convection_edge_to_string(s : PhysicsheatconvectionEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsheatconvectionPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_heat_convection_path_make(size : Int) -> PhysicsheatconvectionPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_heat_convection_path_len(s : PhysicsheatconvectionPath) -> Int { s.size }

pub fn physics_heat_convection_path_get(s : PhysicsheatconvectionPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_heat_convection_path_set(s : PhysicsheatconvectionPath, i : Int, v : Double) -> PhysicsheatconvectionPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn physics_heat_convection_path_sum(s : PhysicsheatconvectionPath) -> Double { @_common.sum(s.data) }

pub fn physics_heat_convection_path_mean(s : PhysicsheatconvectionPath) -> Double { @_common.mean(s.data) }

pub fn physics_heat_convection_path_scale(s : PhysicsheatconvectionPath, f : Double) -> PhysicsheatconvectionPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_heat_convection_path_add(a : PhysicsheatconvectionPath, b : PhysicsheatconvectionPath) -> PhysicsheatconvectionPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_heat_convection_path_copy(s : PhysicsheatconvectionPath) -> PhysicsheatconvectionPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_heat_convection_path_fill(s : PhysicsheatconvectionPath, v : Double) -> PhysicsheatconvectionPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_heat_convection_path_min(s : PhysicsheatconvectionPath) -> Double { @_common.min(s.data) }

pub fn physics_heat_convection_path_max(s : PhysicsheatconvectionPath) -> Double { @_common.max(s.data) }

pub fn physics_heat_convection_path_to_string(s : PhysicsheatconvectionPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsheatconvectionCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_heat_convection_cluster_make(size : Int) -> PhysicsheatconvectionCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_heat_convection_cluster_len(s : PhysicsheatconvectionCluster) -> Int { s.size }

pub fn physics_heat_convection_cluster_get(s : PhysicsheatconvectionCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_heat_convection_cluster_set(s : PhysicsheatconvectionCluster, i : Int, v : Double) -> PhysicsheatconvectionCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn physics_heat_convection_cluster_sum(s : PhysicsheatconvectionCluster) -> Double { @_common.sum(s.data) }

pub fn physics_heat_convection_cluster_mean(s : PhysicsheatconvectionCluster) -> Double { @_common.mean(s.data) }

pub fn physics_heat_convection_cluster_scale(s : PhysicsheatconvectionCluster, f : Double) -> PhysicsheatconvectionCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_heat_convection_cluster_add(a : PhysicsheatconvectionCluster, b : PhysicsheatconvectionCluster) -> PhysicsheatconvectionCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_heat_convection_cluster_copy(s : PhysicsheatconvectionCluster) -> PhysicsheatconvectionCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_heat_convection_cluster_fill(s : PhysicsheatconvectionCluster, v : Double) -> PhysicsheatconvectionCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_heat_convection_cluster_min(s : PhysicsheatconvectionCluster) -> Double { @_common.min(s.data) }

pub fn physics_heat_convection_cluster_max(s : PhysicsheatconvectionCluster) -> Double { @_common.max(s.data) }

pub fn physics_heat_convection_cluster_to_string(s : PhysicsheatconvectionCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsheatconvectionModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_heat_convection_model_make(size : Int) -> PhysicsheatconvectionModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_heat_convection_model_len(s : PhysicsheatconvectionModel) -> Int { s.size }

pub fn physics_heat_convection_model_get(s : PhysicsheatconvectionModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_heat_convection_model_set(s : PhysicsheatconvectionModel, i : Int, v : Double) -> PhysicsheatconvectionModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn physics_heat_convection_model_sum(s : PhysicsheatconvectionModel) -> Double { @_common.sum(s.data) }

pub fn physics_heat_convection_model_mean(s : PhysicsheatconvectionModel) -> Double { @_common.mean(s.data) }

pub fn physics_heat_convection_model_scale(s : PhysicsheatconvectionModel, f : Double) -> PhysicsheatconvectionModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_heat_convection_model_add(a : PhysicsheatconvectionModel, b : PhysicsheatconvectionModel) -> PhysicsheatconvectionModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_heat_convection_model_copy(s : PhysicsheatconvectionModel) -> PhysicsheatconvectionModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_heat_convection_model_fill(s : PhysicsheatconvectionModel, v : Double) -> PhysicsheatconvectionModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_heat_convection_model_min(s : PhysicsheatconvectionModel) -> Double { @_common.min(s.data) }

pub fn physics_heat_convection_model_max(s : PhysicsheatconvectionModel) -> Double { @_common.max(s.data) }

pub fn physics_heat_convection_model_to_string(s : PhysicsheatconvectionModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsheatconvectionLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_heat_convection_layer_make(size : Int) -> PhysicsheatconvectionLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_heat_convection_layer_len(s : PhysicsheatconvectionLayer) -> Int { s.size }

pub fn physics_heat_convection_layer_get(s : PhysicsheatconvectionLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_heat_convection_layer_set(s : PhysicsheatconvectionLayer, i : Int, v : Double) -> PhysicsheatconvectionLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn physics_heat_convection_layer_sum(s : PhysicsheatconvectionLayer) -> Double { @_common.sum(s.data) }

pub fn physics_heat_convection_layer_mean(s : PhysicsheatconvectionLayer) -> Double { @_common.mean(s.data) }

pub fn physics_heat_convection_layer_scale(s : PhysicsheatconvectionLayer, f : Double) -> PhysicsheatconvectionLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_heat_convection_layer_add(a : PhysicsheatconvectionLayer, b : PhysicsheatconvectionLayer) -> PhysicsheatconvectionLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_heat_convection_layer_copy(s : PhysicsheatconvectionLayer) -> PhysicsheatconvectionLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_heat_convection_layer_fill(s : PhysicsheatconvectionLayer, v : Double) -> PhysicsheatconvectionLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_heat_convection_layer_min(s : PhysicsheatconvectionLayer) -> Double { @_common.min(s.data) }

pub fn physics_heat_convection_layer_max(s : PhysicsheatconvectionLayer) -> Double { @_common.max(s.data) }

pub fn physics_heat_convection_layer_to_string(s : PhysicsheatconvectionLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsheatconvectionBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_heat_convection_buffer_make(size : Int) -> PhysicsheatconvectionBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_heat_convection_buffer_len(s : PhysicsheatconvectionBuffer) -> Int { s.size }

pub fn physics_heat_convection_buffer_get(s : PhysicsheatconvectionBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_heat_convection_buffer_set(s : PhysicsheatconvectionBuffer, i : Int, v : Double) -> PhysicsheatconvectionBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn physics_heat_convection_buffer_sum(s : PhysicsheatconvectionBuffer) -> Double { @_common.sum(s.data) }

pub fn physics_heat_convection_buffer_mean(s : PhysicsheatconvectionBuffer) -> Double { @_common.mean(s.data) }

pub fn physics_heat_convection_buffer_scale(s : PhysicsheatconvectionBuffer, f : Double) -> PhysicsheatconvectionBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_heat_convection_buffer_add(a : PhysicsheatconvectionBuffer, b : PhysicsheatconvectionBuffer) -> PhysicsheatconvectionBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_heat_convection_buffer_copy(s : PhysicsheatconvectionBuffer) -> PhysicsheatconvectionBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_heat_convection_buffer_fill(s : PhysicsheatconvectionBuffer, v : Double) -> PhysicsheatconvectionBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_heat_convection_buffer_min(s : PhysicsheatconvectionBuffer) -> Double { @_common.min(s.data) }

pub fn physics_heat_convection_buffer_max(s : PhysicsheatconvectionBuffer) -> Double { @_common.max(s.data) }

pub fn physics_heat_convection_buffer_to_string(s : PhysicsheatconvectionBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsheatconvectionCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_heat_convection_cursor_make(size : Int) -> PhysicsheatconvectionCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_heat_convection_cursor_len(s : PhysicsheatconvectionCursor) -> Int { s.size }

pub fn physics_heat_convection_cursor_get(s : PhysicsheatconvectionCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_heat_convection_cursor_set(s : PhysicsheatconvectionCursor, i : Int, v : Double) -> PhysicsheatconvectionCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn physics_heat_convection_cursor_sum(s : PhysicsheatconvectionCursor) -> Double { @_common.sum(s.data) }

pub fn physics_heat_convection_cursor_mean(s : PhysicsheatconvectionCursor) -> Double { @_common.mean(s.data) }

pub fn physics_heat_convection_cursor_scale(s : PhysicsheatconvectionCursor, f : Double) -> PhysicsheatconvectionCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_heat_convection_cursor_add(a : PhysicsheatconvectionCursor, b : PhysicsheatconvectionCursor) -> PhysicsheatconvectionCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_heat_convection_cursor_copy(s : PhysicsheatconvectionCursor) -> PhysicsheatconvectionCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_heat_convection_cursor_fill(s : PhysicsheatconvectionCursor, v : Double) -> PhysicsheatconvectionCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_heat_convection_cursor_min(s : PhysicsheatconvectionCursor) -> Double { @_common.min(s.data) }

pub fn physics_heat_convection_cursor_max(s : PhysicsheatconvectionCursor) -> Double { @_common.max(s.data) }

pub fn physics_heat_convection_cursor_to_string(s : PhysicsheatconvectionCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsheatconvectionView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_heat_convection_view_make(size : Int) -> PhysicsheatconvectionView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_heat_convection_view_len(s : PhysicsheatconvectionView) -> Int { s.size }

pub fn physics_heat_convection_view_get(s : PhysicsheatconvectionView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_heat_convection_view_set(s : PhysicsheatconvectionView, i : Int, v : Double) -> PhysicsheatconvectionView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn physics_heat_convection_view_sum(s : PhysicsheatconvectionView) -> Double { @_common.sum(s.data) }

pub fn physics_heat_convection_view_mean(s : PhysicsheatconvectionView) -> Double { @_common.mean(s.data) }

pub fn physics_heat_convection_view_scale(s : PhysicsheatconvectionView, f : Double) -> PhysicsheatconvectionView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_heat_convection_view_add(a : PhysicsheatconvectionView, b : PhysicsheatconvectionView) -> PhysicsheatconvectionView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_heat_convection_view_copy(s : PhysicsheatconvectionView) -> PhysicsheatconvectionView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_heat_convection_view_fill(s : PhysicsheatconvectionView, v : Double) -> PhysicsheatconvectionView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_heat_convection_view_min(s : PhysicsheatconvectionView) -> Double { @_common.min(s.data) }

pub fn physics_heat_convection_view_max(s : PhysicsheatconvectionView) -> Double { @_common.max(s.data) }

pub fn physics_heat_convection_view_to_string(s : PhysicsheatconvectionView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsheatconvectionRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_heat_convection_range_make(size : Int) -> PhysicsheatconvectionRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_heat_convection_range_len(s : PhysicsheatconvectionRange) -> Int { s.size }

pub fn physics_heat_convection_range_get(s : PhysicsheatconvectionRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_heat_convection_range_set(s : PhysicsheatconvectionRange, i : Int, v : Double) -> PhysicsheatconvectionRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn physics_heat_convection_range_sum(s : PhysicsheatconvectionRange) -> Double { @_common.sum(s.data) }

pub fn physics_heat_convection_range_mean(s : PhysicsheatconvectionRange) -> Double { @_common.mean(s.data) }

pub fn physics_heat_convection_range_scale(s : PhysicsheatconvectionRange, f : Double) -> PhysicsheatconvectionRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_heat_convection_range_add(a : PhysicsheatconvectionRange, b : PhysicsheatconvectionRange) -> PhysicsheatconvectionRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_heat_convection_range_copy(s : PhysicsheatconvectionRange) -> PhysicsheatconvectionRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_heat_convection_range_fill(s : PhysicsheatconvectionRange, v : Double) -> PhysicsheatconvectionRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_heat_convection_range_min(s : PhysicsheatconvectionRange) -> Double { @_common.min(s.data) }

pub fn physics_heat_convection_range_max(s : PhysicsheatconvectionRange) -> Double { @_common.max(s.data) }

pub fn physics_heat_convection_range_to_string(s : PhysicsheatconvectionRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsheatconvectionSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_heat_convection_slice_make(size : Int) -> PhysicsheatconvectionSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_heat_convection_slice_len(s : PhysicsheatconvectionSlice) -> Int { s.size }

pub fn physics_heat_convection_slice_get(s : PhysicsheatconvectionSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_heat_convection_slice_set(s : PhysicsheatconvectionSlice, i : Int, v : Double) -> PhysicsheatconvectionSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn physics_heat_convection_slice_sum(s : PhysicsheatconvectionSlice) -> Double { @_common.sum(s.data) }

pub fn physics_heat_convection_slice_mean(s : PhysicsheatconvectionSlice) -> Double { @_common.mean(s.data) }

pub fn physics_heat_convection_slice_scale(s : PhysicsheatconvectionSlice, f : Double) -> PhysicsheatconvectionSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_heat_convection_slice_add(a : PhysicsheatconvectionSlice, b : PhysicsheatconvectionSlice) -> PhysicsheatconvectionSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_heat_convection_slice_copy(s : PhysicsheatconvectionSlice) -> PhysicsheatconvectionSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_heat_convection_slice_fill(s : PhysicsheatconvectionSlice, v : Double) -> PhysicsheatconvectionSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_heat_convection_slice_min(s : PhysicsheatconvectionSlice) -> Double { @_common.min(s.data) }

pub fn physics_heat_convection_slice_max(s : PhysicsheatconvectionSlice) -> Double { @_common.max(s.data) }

pub fn physics_heat_convection_slice_to_string(s : PhysicsheatconvectionSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

